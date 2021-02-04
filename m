Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED17A30E3C3
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 21:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231299AbhBCUH0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 15:07:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231335AbhBCUHZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 15:07:25 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 001B964F68;
        Wed,  3 Feb 2021 20:06:44 +0000 (UTC)
Subject: [PATCH v3 0/6] RPC/RDMA client fixes
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Wed, 03 Feb 2021 15:06:38 -0500
Message-ID: <161238257595.946943.6571271028482175652.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Changes since v2:
- Another minor optimization in rpcrdma_convert_kvec()
- Some patch description clarifications
- Add Reviewed-by (thanks Tom!)

Changes since v1:
- Respond to review comments
- Split "Remove FMR support" into three patches for clarity
- Fix implicit chunk roundup
- Improve Receive completion tracepoints

---

Chuck Lever (6):
      xprtrdma: Remove FMR support in rpcrdma_convert_iovs()
      xprtrdma: Simplify rpcrdma_convert_kvec() and frwr_map()
      xprtrdma: Refactor invocations of offset_in_page()
      rpcrdma: Fix comments about reverse-direction operation
      xprtrdma: Pad optimization, revisited
      rpcrdma: Capture bytes received in Receive completion tracepoints


 include/trace/events/rpcrdma.h             | 50 +++++++++++++++++++++-
 net/sunrpc/xprtrdma/backchannel.c          |  4 +-
 net/sunrpc/xprtrdma/frwr_ops.c             | 12 ++----
 net/sunrpc/xprtrdma/rpc_rdma.c             | 17 +++-----
 net/sunrpc/xprtrdma/svc_rdma_backchannel.c |  4 +-
 net/sunrpc/xprtrdma/xprt_rdma.h            | 15 ++++---
 6 files changed, 68 insertions(+), 34 deletions(-)

--
Chuck Lever

