Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A296E17F376
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbgCJJ0E (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726199AbgCJJ0D (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:03 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E94462051A;
        Tue, 10 Mar 2020 09:26:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832362;
        bh=28kkMzpK6IZ2z2Vgl0J3RZTtRuBf5QuwPvx0dGNo+mI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pobm8nKeI/Z0QVUVvb2KCSBFQCABsfVYmRFxP0nm7ygcYHHaJOEtnnMS5GjFZJLRL
         qKtHVxTxTCNDBwa8m+po+lSRhOYOyfJ5pyCC6tMbSPfgA0cyPzMxtreRWJm2BkV5HR
         ug5Hx6MZgZ9dW5gv1LDC+KvfXzR3olFCbQZPNCO8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 05/15] RDMA/cm: Simplify establishing a listen cm_id
Date:   Tue, 10 Mar 2020 11:25:35 +0200
Message-Id: <20200310092545.251365-6-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310092545.251365-1-leon@kernel.org>
References: <20200310092545.251365-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Any manipulation of cm_id->state must be done under the cm_id_priv->lock,
the two routines that added listens did not follow this rule, because they
never participate in any concurrent access around the state.

However, since this exception makes the code hard to understand, simplify
the flow so that it can be fully locked:
 - Move manipulation of listen_sharecount into cm_insert_listen() so it is
   trivially under the cm.lock without having to expose the cm.lock to the
   caller.
 - Push the cm.lock down into cm_insert_listen() and have the function
   increment the reference count before returning an existing pointer.
 - Split ib_cm_listen() into an cm_init_listen() and do not call
   ib_cm_listen() from ib_cm_insert_listen()
 - Make both ib_cm_listen() and ib_cm_insert_listen() directly call
   cm_insert_listen() under their cm_id_priv->lock which does both a
   collision detect and, if needed, the insert (atomically)
 - Enclose all state manipulation within the cm_id_priv->lock, notice this
   set can be done safely after cm_insert_listen() as no reader is allowed
   to read the state without holding the lock.
 - Do not set the listen cm_id in the xarray, as it is never correct to
   look it up. This makes the concurrency simpler to understand.

Many needless error unwinds are removed in the process.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 199 ++++++++++++++++++++---------------
 1 file changed, 116 insertions(+), 83 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 51e6cebb606e..051a546b8e7b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -624,22 +624,44 @@ static int be64_gt(__be64 a, __be64 b)
 	return (__force u64) a > (__force u64) b;
 }
 
-static struct cm_id_private * cm_insert_listen(struct cm_id_private *cm_id_priv)
+/*
+ * Inserts a new cm_id_priv into the listen_service_table. Returns cm_id_priv
+ * if the new ID was inserted, NULL if it could not be inserted due to a
+ * collision, or the existing cm_id_priv ready for shared usage.
+ */
+static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
+					      ib_cm_handler shared_handler)
 {
 	struct rb_node **link = &cm.listen_service_table.rb_node;
 	struct rb_node *parent = NULL;
 	struct cm_id_private *cur_cm_id_priv;
 	__be64 service_id = cm_id_priv->id.service_id;
 	__be64 service_mask = cm_id_priv->id.service_mask;
+	unsigned long flags;
 
+	spin_lock_irqsave(&cm.lock, flags);
 	while (*link) {
 		parent = *link;
 		cur_cm_id_priv = rb_entry(parent, struct cm_id_private,
 					  service_node);
 		if ((cur_cm_id_priv->id.service_mask & service_id) ==
 		    (service_mask & cur_cm_id_priv->id.service_id) &&
-		    (cm_id_priv->id.device == cur_cm_id_priv->id.device))
+		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
+			/*
+			 * Sharing an ib_cm_id with different handlers is not
+			 * supported
+			 */
+			if (cur_cm_id_priv->id.cm_handler != shared_handler ||
+			    cur_cm_id_priv->id.context ||
+			    WARN_ON(!cur_cm_id_priv->id.cm_handler)) {
+				spin_unlock_irqrestore(&cm.lock, flags);
+				return NULL;
+			}
+			refcount_inc(&cur_cm_id_priv->refcount);
+			cur_cm_id_priv->listen_sharecount++;
+			spin_unlock_irqrestore(&cm.lock, flags);
 			return cur_cm_id_priv;
+		}
 
 		if (cm_id_priv->id.device < cur_cm_id_priv->id.device)
 			link = &(*link)->rb_left;
@@ -652,9 +674,11 @@ static struct cm_id_private * cm_insert_listen(struct cm_id_private *cm_id_priv)
 		else
 			link = &(*link)->rb_right;
 	}
+	cm_id_priv->listen_sharecount++;
 	rb_link_node(&cm_id_priv->service_node, parent, link);
 	rb_insert_color(&cm_id_priv->service_node, &cm.listen_service_table);
-	return NULL;
+	spin_unlock_irqrestore(&cm.lock, flags);
+	return cm_id_priv;
 }
 
 static struct cm_id_private * cm_find_listen(struct ib_device *device,
@@ -811,9 +835,9 @@ static void cm_reject_sidr_req(struct cm_id_private *cm_id_priv,
 	ib_send_cm_sidr_rep(&cm_id_priv->id, &param);
 }
 
-struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
-				 ib_cm_handler cm_handler,
-				 void *context)
+static struct cm_id_private *cm_alloc_id_priv(struct ib_device *device,
+					      ib_cm_handler cm_handler,
+					      void *context)
 {
 	struct cm_id_private *cm_id_priv;
 	u32 id;
@@ -844,15 +868,37 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 	if (ret)
 		goto error;
 	cm_id_priv->id.local_id = (__force __be32)id ^ cm.random_id_operand;
-	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
-		     cm_id_priv, GFP_KERNEL);
 
-	return &cm_id_priv->id;
+	return cm_id_priv;
 
 error:
 	kfree(cm_id_priv);
 	return ERR_PTR(ret);
 }
+
+/*
+ * Make the ID visible to the MAD handlers and other threads that use the
+ * xarray.
+ */
+static void cm_finalize_id(struct cm_id_private *cm_id_priv)
+{
+	xa_store_irq(&cm.local_id_table, cm_local_id(cm_id_priv->id.local_id),
+		     cm_id_priv, GFP_KERNEL);
+}
+
+struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
+				 ib_cm_handler cm_handler,
+				 void *context)
+{
+	struct cm_id_private *cm_id_priv;
+
+	cm_id_priv = cm_alloc_id_priv(device, cm_handler, context);
+	if (IS_ERR(cm_id_priv))
+		return ERR_CAST(cm_id_priv);
+
+	cm_finalize_id(cm_id_priv);
+	return &cm_id_priv->id;
+}
 EXPORT_SYMBOL(ib_create_cm_id);
 
 static struct cm_work * cm_dequeue_work(struct cm_id_private *cm_id_priv)
@@ -1096,8 +1142,27 @@ void ib_destroy_cm_id(struct ib_cm_id *cm_id)
 }
 EXPORT_SYMBOL(ib_destroy_cm_id);
 
+static int cm_init_listen(struct cm_id_private *cm_id_priv, __be64 service_id,
+			  __be64 service_mask)
+{
+	service_mask = service_mask ? service_mask : ~cpu_to_be64(0);
+	service_id &= service_mask;
+	if ((service_id & IB_SERVICE_ID_AGN_MASK) == IB_CM_ASSIGN_SERVICE_ID &&
+	    (service_id != IB_CM_ASSIGN_SERVICE_ID))
+		return -EINVAL;
+
+	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
+		cm_id_priv->id.service_id = cpu_to_be64(cm.listen_service_id++);
+		cm_id_priv->id.service_mask = ~cpu_to_be64(0);
+	} else {
+		cm_id_priv->id.service_id = service_id;
+		cm_id_priv->id.service_mask = service_mask;
+	}
+	return 0;
+}
+
 /**
- * __ib_cm_listen - Initiates listening on the specified service ID for
+ * ib_cm_listen - Initiates listening on the specified service ID for
  *   connection and service ID resolution requests.
  * @cm_id: Connection identifier associated with the listen request.
  * @service_id: Service identifier matched against incoming connection
@@ -1109,51 +1174,33 @@ EXPORT_SYMBOL(ib_destroy_cm_id);
  *   exactly.  This parameter is ignored if %service_id is set to
  *   IB_CM_ASSIGN_SERVICE_ID.
  */
-static int __ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id,
-			  __be64 service_mask)
+int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask)
 {
-	struct cm_id_private *cm_id_priv, *cur_cm_id_priv;
-	int ret = 0;
-
-	service_mask = service_mask ? service_mask : ~cpu_to_be64(0);
-	service_id &= service_mask;
-	if ((service_id & IB_SERVICE_ID_AGN_MASK) == IB_CM_ASSIGN_SERVICE_ID &&
-	    (service_id != IB_CM_ASSIGN_SERVICE_ID))
-		return -EINVAL;
-
-	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	if (cm_id->state != IB_CM_IDLE)
-		return -EINVAL;
-
-	cm_id->state = IB_CM_LISTEN;
-	++cm_id_priv->listen_sharecount;
+	struct cm_id_private *cm_id_priv =
+		container_of(cm_id, struct cm_id_private, id);
+	unsigned long flags;
+	int ret;
 
-	if (service_id == IB_CM_ASSIGN_SERVICE_ID) {
-		cm_id->service_id = cpu_to_be64(cm.listen_service_id++);
-		cm_id->service_mask = ~cpu_to_be64(0);
-	} else {
-		cm_id->service_id = service_id;
-		cm_id->service_mask = service_mask;
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	if (cm_id_priv->id.state != IB_CM_IDLE) {
+		ret = -EINVAL;
+		goto out;
 	}
-	cur_cm_id_priv = cm_insert_listen(cm_id_priv);
 
-	if (cur_cm_id_priv) {
-		cm_id->state = IB_CM_IDLE;
-		--cm_id_priv->listen_sharecount;
+	ret = cm_init_listen(cm_id_priv, service_id, service_mask);
+	if (ret)
+		goto out;
+
+	if (!cm_insert_listen(cm_id_priv, NULL)) {
 		ret = -EBUSY;
+		goto out;
 	}
-	return ret;
-}
 
-int ib_cm_listen(struct ib_cm_id *cm_id, __be64 service_id, __be64 service_mask)
-{
-	unsigned long flags;
-	int ret;
-
-	spin_lock_irqsave(&cm.lock, flags);
-	ret = __ib_cm_listen(cm_id, service_id, service_mask);
-	spin_unlock_irqrestore(&cm.lock, flags);
+	cm_id_priv->id.state = IB_CM_LISTEN;
+	ret = 0;
 
+out:
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
 }
 EXPORT_SYMBOL(ib_cm_listen);
@@ -1178,52 +1225,38 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 				     ib_cm_handler cm_handler,
 				     __be64 service_id)
 {
+	struct cm_id_private *listen_id_priv;
 	struct cm_id_private *cm_id_priv;
-	struct ib_cm_id *cm_id;
-	unsigned long flags;
 	int err = 0;
 
 	/* Create an ID in advance, since the creation may sleep */
-	cm_id = ib_create_cm_id(device, cm_handler, NULL);
-	if (IS_ERR(cm_id))
-		return cm_id;
-
-	spin_lock_irqsave(&cm.lock, flags);
+	cm_id_priv = cm_alloc_id_priv(device, cm_handler, NULL);
+	if (IS_ERR(cm_id_priv))
+		return ERR_CAST(cm_id_priv);
 
-	if (service_id == IB_CM_ASSIGN_SERVICE_ID)
-		goto new_id;
+	err = cm_init_listen(cm_id_priv, service_id, 0);
+	if (err)
+		return ERR_PTR(err);
 
-	/* Find an existing ID */
-	cm_id_priv = cm_find_listen(device, service_id);
-	if (cm_id_priv) {
-		if (cm_id_priv->id.cm_handler != cm_handler ||
-		    cm_id_priv->id.context) {
-			/* Sharing an ib_cm_id with different handlers is not
-			 * supported */
-			spin_unlock_irqrestore(&cm.lock, flags);
-			ib_destroy_cm_id(cm_id);
+	spin_lock_irq(&cm_id_priv->lock);
+	listen_id_priv = cm_insert_listen(cm_id_priv, cm_handler);
+	if (listen_id_priv != cm_id_priv) {
+		spin_unlock_irq(&cm_id_priv->lock);
+		ib_destroy_cm_id(&cm_id_priv->id);
+		if (!listen_id_priv)
 			return ERR_PTR(-EINVAL);
-		}
-		refcount_inc(&cm_id_priv->refcount);
-		++cm_id_priv->listen_sharecount;
-		spin_unlock_irqrestore(&cm.lock, flags);
-
-		ib_destroy_cm_id(cm_id);
-		cm_id = &cm_id_priv->id;
-		return cm_id;
+		return &listen_id_priv->id;
 	}
+	cm_id_priv->id.state = IB_CM_LISTEN;
+	spin_unlock_irq(&cm_id_priv->lock);
 
-new_id:
-	/* Use newly created ID */
-	err = __ib_cm_listen(cm_id, service_id, 0);
-
-	spin_unlock_irqrestore(&cm.lock, flags);
+	/*
+	 * A listen ID does not need to be in the xarray since it does not
+	 * receive mads, is not placed in the remote_id or remote_qpn rbtree,
+	 * and does not enter timewait.
+	 */
 
-	if (err) {
-		ib_destroy_cm_id(cm_id);
-		return ERR_PTR(err);
-	}
-	return cm_id;
+	return &cm_id_priv->id;
 }
 EXPORT_SYMBOL(ib_cm_insert_listen);
 
-- 
2.24.1

