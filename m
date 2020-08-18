Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1EE7248466
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Aug 2020 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726592AbgHRMGJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 18 Aug 2020 08:06:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:32982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726480AbgHRMGJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 18 Aug 2020 08:06:09 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB89B204EA;
        Tue, 18 Aug 2020 12:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597752368;
        bh=KGUZfSWcwG1OPm0GPYyU10bbCGHgONbrUWaQxq2iCzs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R3hIujR2BctqJLcXnN901USnBYs/nNtKja2ZvRyXNUaHvDExPFQ/h3hrn5w1SAidk
         T/h0M/gKtn2fd31PmTtnlWUeUDyymhugTAbcB7VEa+eQvlyTiuw7W6ruvzgVxqYF3W
         BY4VxQtMMdQ1TGLM3eSvm+vS/BWGX7LsoKiF37YI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 06/14] RDMA/cma: Add missing locking to rdma_accept()
Date:   Tue, 18 Aug 2020 15:05:18 +0300
Message-Id: <20200818120526.702120-7-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818120526.702120-1-leon@kernel.org>
References: <20200818120526.702120-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

In almost all cases rdma_accept() is called under the handler_mutex by
ULPs from their handler callbacks. The one exception was ucma which did
not get the handler_mutex.

To improve the understand-ability of the locking scheme obtain the mutex
for ucma as well.

This improves how ucma works by allowing it to directly use handler_mutex
for some of its internal locking against the handler callbacks intead of
the global file->mut lock.

There does not seem to be a serious bug here, other than a DISCONNECT event
can be delivered concurrently with accept succeeding.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cma.c  | 25 ++++++++++++++++++++++---
 drivers/infiniband/core/ucma.c | 12 ++++++++----
 include/rdma/rdma_cm.h         |  5 +++++
 3 files changed, 35 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 26de0dab60bb..78641858abe2 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -4154,14 +4154,15 @@ static int cma_send_sidr_rep(struct rdma_id_private *id_priv,
 int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 		  const char *caller)
 {
-	struct rdma_id_private *id_priv;
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
 	int ret;
 
-	id_priv = container_of(id, struct rdma_id_private, id);
+	lockdep_assert_held(&id_priv->handler_mutex);
 
 	rdma_restrack_set_task(&id_priv->res, caller);
 
-	if (!cma_comp(id_priv, RDMA_CM_CONNECT))
+	if (READ_ONCE(id_priv->state) != RDMA_CM_CONNECT)
 		return -EINVAL;
 
 	if (!id->qp && conn_param) {
@@ -4214,6 +4215,24 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 }
 EXPORT_SYMBOL(__rdma_accept_ece);
 
+void rdma_lock_handler(struct rdma_cm_id *id)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	mutex_lock(&id_priv->handler_mutex);
+}
+EXPORT_SYMBOL(rdma_lock_handler);
+
+void rdma_unlock_handler(struct rdma_cm_id *id)
+{
+	struct rdma_id_private *id_priv =
+		container_of(id, struct rdma_id_private, id);
+
+	mutex_unlock(&id_priv->handler_mutex);
+}
+EXPORT_SYMBOL(rdma_unlock_handler);
+
 int rdma_notify(struct rdma_cm_id *id, enum ib_event_type event)
 {
 	struct rdma_id_private *id_priv;
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index dd12931f3038..add1ece38739 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1162,16 +1162,20 @@ static ssize_t ucma_accept(struct ucma_file *file, const char __user *inbuf,
 
 	if (cmd.conn_param.valid) {
 		ucma_copy_conn_param(ctx->cm_id, &conn_param, &cmd.conn_param);
-		mutex_lock(&file->mut);
 		mutex_lock(&ctx->mutex);
+		rdma_lock_handler(ctx->cm_id);
 		ret = __rdma_accept_ece(ctx->cm_id, &conn_param, NULL, &ece);
-		mutex_unlock(&ctx->mutex);
-		if (!ret)
+		if (!ret) {
+			/* The uid must be set atomically with the handler */
 			ctx->uid = cmd.uid;
-		mutex_unlock(&file->mut);
+		}
+		rdma_unlock_handler(ctx->cm_id);
+		mutex_unlock(&ctx->mutex);
 	} else {
 		mutex_lock(&ctx->mutex);
+		rdma_lock_handler(ctx->cm_id);
 		ret = __rdma_accept_ece(ctx->cm_id, NULL, NULL, &ece);
+		rdma_unlock_handler(ctx->cm_id);
 		mutex_unlock(&ctx->mutex);
 	}
 	ucma_put_ctx(ctx);
diff --git a/include/rdma/rdma_cm.h b/include/rdma/rdma_cm.h
index cf5da2ae49bf..c1334c9a7aa8 100644
--- a/include/rdma/rdma_cm.h
+++ b/include/rdma/rdma_cm.h
@@ -253,6 +253,8 @@ int rdma_listen(struct rdma_cm_id *id, int backlog);
 int __rdma_accept(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 		  const char *caller);
 
+void rdma_lock_handler(struct rdma_cm_id *id);
+void rdma_unlock_handler(struct rdma_cm_id *id);
 int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
 		      const char *caller, struct rdma_ucm_ece *ece);
 
@@ -270,6 +272,9 @@ int __rdma_accept_ece(struct rdma_cm_id *id, struct rdma_conn_param *conn_param,
  * In the case of error, a reject message is sent to the remote side and the
  * state of the qp associated with the id is modified to error, such that any
  * previously posted receive buffers would be flushed.
+ *
+ * This function is for use by kernel ULPs and must be called from under the
+ * handler callback.
  */
 #define rdma_accept(id, conn_param) \
 	__rdma_accept((id), (conn_param),  KBUILD_MODNAME)
-- 
2.26.2

