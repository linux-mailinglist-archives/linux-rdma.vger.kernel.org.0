Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06171364974
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Apr 2021 20:02:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240500AbhDSSCy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Apr 2021 14:02:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:40938 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240433AbhDSSCx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Apr 2021 14:02:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5CDE061001;
        Mon, 19 Apr 2021 18:02:23 +0000 (UTC)
Subject: [PATCH v3 07/26] xprtrdma: Improve locking around rpcrdma_rep
 destruction
From:   Chuck Lever <chuck.lever@oracle.com>
To:     trondmy@hammerspace.com
Cc:     linux-nfs@vger.kernel.org, linux-rdma@vger.kernel.org
Date:   Mon, 19 Apr 2021 14:02:22 -0400
Message-ID: <161885534259.38598.17355600080366820390.stgit@manet.1015granger.net>
In-Reply-To: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
References: <161885481568.38598.16682844600209775665.stgit@manet.1015granger.net>
User-Agent: StGit/0.23-29-ga622f1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Currently rpcrdma_reps_destroy() assumes that, at transport
tear-down, the content of the rb_free_reps list is the same as the
content of the rb_all_reps list. Although that is usually true,
using the rb_all_reps list should be more reliable because of
the way it's managed. And, rpcrdma_reps_unmap() uses rb_all_reps;
these two functions should both traverse the "all" list.

Ensure that all rpcrdma_reps are always destroyed whether they are
on the rep free list or not.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/sunrpc/xprtrdma/verbs.c |   31 ++++++++++++++++++++++++-------
 1 file changed, 24 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 1b599a623eea..482fdc9e25c2 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -1007,16 +1007,23 @@ struct rpcrdma_rep *rpcrdma_rep_create(struct rpcrdma_xprt *r_xprt,
 	return NULL;
 }
 
-/* No locking needed here. This function is invoked only by the
- * Receive completion handler, or during transport shutdown.
- */
-static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
+static void rpcrdma_rep_destroy_locked(struct rpcrdma_rep *rep)
 {
-	list_del(&rep->rr_all);
 	rpcrdma_regbuf_free(rep->rr_rdmabuf);
 	kfree(rep);
 }
 
+static void rpcrdma_rep_destroy(struct rpcrdma_rep *rep)
+{
+	struct rpcrdma_buffer *buf = &rep->rr_rxprt->rx_buf;
+
+	spin_lock(&buf->rb_lock);
+	list_del(&rep->rr_all);
+	spin_unlock(&buf->rb_lock);
+
+	rpcrdma_rep_destroy_locked(rep);
+}
+
 static struct rpcrdma_rep *rpcrdma_rep_get_locked(struct rpcrdma_buffer *buf)
 {
 	struct llist_node *node;
@@ -1049,8 +1056,18 @@ static void rpcrdma_reps_destroy(struct rpcrdma_buffer *buf)
 {
 	struct rpcrdma_rep *rep;
 
-	while ((rep = rpcrdma_rep_get_locked(buf)) != NULL)
-		rpcrdma_rep_destroy(rep);
+	spin_lock(&buf->rb_lock);
+	while ((rep = list_first_entry_or_null(&buf->rb_all_reps,
+					       struct rpcrdma_rep,
+					       rr_all)) != NULL) {
+		list_del(&rep->rr_all);
+		spin_unlock(&buf->rb_lock);
+
+		rpcrdma_rep_destroy_locked(rep);
+
+		spin_lock(&buf->rb_lock);
+	}
+	spin_unlock(&buf->rb_lock);
 }
 
 /**


