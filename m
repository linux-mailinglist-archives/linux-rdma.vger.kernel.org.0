Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4803A36497A
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 20:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbhDSSDN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 14:03:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:41036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240510AbhDSSDM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 14:03:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3C20061107;
        Mon, 19 Apr 2021 18:02:42 +0000 (UTC)
Subject: [PATCH v3 10/26] xprtrdma: Fix cwnd update ordering
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:02:41 -0400
Message-ID: <161885536143.38598.9604745938847259595.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After a reconnect, the reply handler is opening the cwnd (and thus
enabling more RPC Calls to be sent) /before/ rpcrdma_post_recvs()
can post enough Receive WRs to receive their replies. This causes an
RNR and the new connection is lost immediately.

The race is most clearly exposed when KASAN and disconnect injection
are enabled. This slows down rpcrdma_rep_create() enough to allow
the send side to post a bunch of RPC Calls before the Receive
completion handler can invoke ib_post_recv().

Fixes: 2ae50ad68cd7 ("xprtrdma: Close window between waking RPC senders and posting Receives")
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/rpc_rdma.c  |    3 ++-
 net/sunrpc/xprtrdma/verbs.c     |   10 +++++-----
 net/sunrpc/xprtrdma/xprt_rdma.h |    2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/rpc_rdma.c b/net/sunrpc/xprtrdma/rpc_rdma.c
index 292f066d006e..21ddd78a8c35 100644
--- a/net/sunrpc/xprtrdma/rpc_rdma.c
+++ b/net/sunrpc/xprtrdma/rpc_rdma.c
@@ -1430,9 +1430,10 @@ void rpcrdma_reply_handler(struct rpcrdma_rep *rep)
 		credits = 1;	/* don't deadlock */
 	else if (credits > r_xprt->rx_ep->re_max_requests)
 		credits = r_xprt->rx_ep->re_max_requests;
+	rpcrdma_post_recvs(r_xprt, credits + (buf->rb_bc_srv_max_requests << 1),
+			   false);
 	if (buf->rb_credits != credits)
 		rpcrdma_update_cwnd(r_xprt, credits);
-	rpcrdma_post_recvs(r_xprt, false);
 
 	req = rpcr_to_rdmar(rqst);
 	if (unlikely(req->rl_reply))
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 0ade69501061..5a2871c4561f 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -544,7 +544,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
 	 * outstanding Receives.
 	 */
 	rpcrdma_ep_get(ep);
-	rpcrdma_post_recvs(r_xprt, true);
+	rpcrdma_post_recvs(r_xprt, 1, true);
 
 	rc = rdma_connect(ep->re_id, &ep->re_remote_cma);
 	if (rc)
@@ -1395,21 +1395,21 @@ int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 /**
  * rpcrdma_post_recvs - Refill the Receive Queue
  * @r_xprt: controlling transport instance
- * @temp: mark Receive buffers to be deleted after use
+ * @needed: current credit grant
+ * @temp: mark Receive buffers to be deleted after one use
  *
  */
-void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp)
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp)
 {
 	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	struct ib_recv_wr *wr, *bad_wr;
 	struct rpcrdma_rep *rep;
-	int needed, count, rc;
+	int count, rc;
 
 	rc = 0;
 	count = 0;
 
-	needed = buf->rb_credits + (buf->rb_bc_srv_max_requests << 1);
 	if (likely(ep->re_receive_count > needed))
 		goto out;
 	needed -= ep->re_receive_count;
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 31404326f29f..2504f67af63e 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -462,7 +462,7 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt);
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt);
 
 int rpcrdma_post_sends(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req);
-void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, bool temp);
+void rpcrdma_post_recvs(struct rpcrdma_xprt *r_xprt, int needed, bool temp);
 
 /*
  * Buffer calls - xprtrdma/verbs.c


