Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6F630E3D5
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 21:08:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbhBCUIL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 15:08:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:47810 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231742AbhBCUIG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 15:08:06 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF53064F7E;
        Wed,  3 Feb 2021 20:07:16 +0000 (UTC)
Subject: [PATCH v3 5/6] xprtrdma: Pad optimization, revisited
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 15:07:15 -0500
Message-ID: <161238283595.946943.5865303378844229040.stgit@manet.1015granger.net>
In-Reply-To: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
References: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The NetApp Linux team discovered that with NFS/RDMA servers that do
not support RFC 8797, the Linux client is forming NFSv4.x WRITE
requests incorrectly.

In this case, the Linux NFS client disables implicit chunk round-up
for odd-length Read and Write chunks. The goal was to support old
servers that needed that padding to be sent explicitly by clients.

In that case the Linux NFS included the tail kvec in the Read chunk,
since the tail contains any needed padding. That meant a separate
memory registration is needed for the tail kvec, adding to the cost
of forming such requests. To avoid that cost for a mere 3 bytes of
zeroes that are always ignored by receivers, we try to use implicit
roundup when possible.

For NFSv4.x, the tail kvec also sometimes contains a trailing
GETATTR operation. The Linux NFS client unintentionally includes
that GETATTR operation in the Read chunk as well as inline.

The fix is simply to /never/ include the tail kvec when forming a
data payload Read chunk. The padding is thus now always present.

Note that since commit 9ed5af268e88 ("SUNRPC: Clean up the handling
of page padding in rpc_prepare_reply_pages()") [Dec 2020] the NFS
client passes payload data to the transport with the padding in
xdr->pages instead of in the send buffer's tail kvec. So now the
Linux NFS client appends XDR padding to all odd-sized Read chunks.
This shouldn't be a problem because:

 - RFC 8166-compliant servers are supposed to work with or without
   that XDR padding in Read chunks.

 - Since the padding is now in the same memory region as the data
   payload, a separate memory registration is not needed. In
   addition, the link layer extends data in RDMA Read responses to
   4-byte boundaries anyway. Thus there is now no savings when the
   padding is not included.

Because older kernels include the payload's XDR padding in the
tail kvec, a fix there will be more complicated. Thus backporting
this patch is not recommended.

Reported by: Olga Kornievskaia <Olga.Kornievskaia@netapp.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Tom Talpey <tom@talpey.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c |    5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 6357ad5d0d3b..8a0571cb97ec 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -255,10 +255,7 @@ rpcrdma_convert_iovs(struct rpcrdma_xprt *r_xprt, struct xdr_buf *xdrbuf,
 		page_base = 0;
 	}
 
-	/* When encoding a Read chunk, the tail iovec contains an
-	 * XDR pad and may be omitted.
-	 */
-	if (type == rpcrdma_readch && r_xprt->rx_ep->re_implicit_roundup)
+	if (type == rpcrdma_readch)
 		goto out;
 
 	/* When encoding a Write chunk, some servers need to see an


