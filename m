Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8018BFF9E7
	for <lists+linux-rdma@lfdr.de>; Sun, 17 Nov 2019 14:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfKQNdi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 17 Nov 2019 08:33:38 -0500
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:38172 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726102AbfKQNdi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 17 Nov 2019 08:33:38 -0500
Received: from Internal Mail-Server by MTLPINE1 (envelope-from danitg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 17 Nov 2019 15:33:32 +0200
Received: from vnc2 (vnc2.mtl.labs.mlnx [10.7.2.2])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id xAHDXWwN014776;
        Sun, 17 Nov 2019 15:33:32 +0200
Received: from vnc2.mtl.labs.mlnx (localhost [127.0.0.1])
        by vnc2 (8.14.4/8.14.4) with ESMTP id xAHDXWVY004565;
        Sun, 17 Nov 2019 15:33:32 +0200
Received: (from danitg@localhost)
        by vnc2.mtl.labs.mlnx (8.14.4/8.14.4/Submit) id xAHDXUTf004561;
        Sun, 17 Nov 2019 15:33:30 +0200
X-Authentication-Warning: vnc2.mtl.labs.mlnx: danitg set sender to danitg@mellanox.com using -f
From:   Danit Goldberg <danitg@mellanox.com>
To:     linux-rdma@vger.kernel.org
Cc:     leonro@mellanox.com, jgg@mellanox.com
Subject: [PATCH rdma-next] RDMA/cm: Use refcount_t type for refcount variable
Date:   Sun, 17 Nov 2019 15:33:21 +0200
Message-Id: <1573997601-4502-1-git-send-email-danitg@mellanox.com>
X-Mailer: git-send-email 1.7.1
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The refcount_t API is a kernel self-protection mechanism, and therefore
more suitable for counters variables.

This patch replaces the counting API from atomic_t API to refcount_t API
of the 'refcount' variable in cm_id_private struct.

Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 33b384c7df42..455b3659d84b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -237,7 +237,7 @@ struct cm_id_private {
 	struct rb_node sidr_id_node;
 	spinlock_t lock;	/* Do not acquire inside cm.lock */
 	struct completion comp;
-	atomic_t refcount;
+	refcount_t refcount;
 	/* Number of clients sharing this ib_cm_id. Only valid for listeners.
 	 * Protected by the cm.lock spinlock. */
 	int listen_sharecount;
@@ -282,7 +282,7 @@ static void cm_work_handler(struct work_struct *work);
 
 static inline void cm_deref_id(struct cm_id_private *cm_id_priv)
 {
-	if (atomic_dec_and_test(&cm_id_priv->refcount))
+	if (refcount_dec_and_test(&cm_id_priv->refcount))
 		complete(&cm_id_priv->comp);
 }
 
@@ -339,7 +339,7 @@ static int cm_alloc_msg(struct cm_id_private *cm_id_priv,
 	m->ah = ah;
 	m->retries = cm_id_priv->max_cm_retries;
 
-	atomic_inc(&cm_id_priv->refcount);
+	refcount_inc(&cm_id_priv->refcount);
 	m->context[0] = cm_id_priv;
 	*msg = m;
 
@@ -600,7 +600,7 @@ static struct cm_id_private * cm_get_id(__be32 local_id, __be32 remote_id)
 	cm_id_priv = xa_load(&cm.local_id_table, cm_local_id(local_id));
 	if (cm_id_priv) {
 		if (cm_id_priv->id.remote_id == remote_id)
-			atomic_inc(&cm_id_priv->refcount);
+			refcount_inc(&cm_id_priv->refcount);
 		else
 			cm_id_priv = NULL;
 	}
@@ -857,7 +857,7 @@ struct ib_cm_id *ib_create_cm_id(struct ib_device *device,
 	INIT_LIST_HEAD(&cm_id_priv->prim_list);
 	INIT_LIST_HEAD(&cm_id_priv->altr_list);
 	atomic_set(&cm_id_priv->work_count, -1);
-	atomic_set(&cm_id_priv->refcount, 1);
+	refcount_set(&cm_id_priv->refcount, 1);
 	return &cm_id_priv->id;
 
 error:
@@ -1204,7 +1204,7 @@ struct ib_cm_id *ib_cm_insert_listen(struct ib_device *device,
 			spin_unlock_irqrestore(&cm.lock, flags);
 			return ERR_PTR(-EINVAL);
 		}
-		atomic_inc(&cm_id_priv->refcount);
+		refcount_inc(&cm_id_priv->refcount);
 		++cm_id_priv->listen_sharecount;
 		spin_unlock_irqrestore(&cm.lock, flags);
 
@@ -1861,8 +1861,8 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 			     NULL, 0);
 		goto out;
 	}
-	atomic_inc(&listen_cm_id_priv->refcount);
-	atomic_inc(&cm_id_priv->refcount);
+	refcount_inc(&listen_cm_id_priv->refcount);
+	refcount_inc(&cm_id_priv->refcount);
 	cm_id_priv->id.state = IB_CM_REQ_RCVD;
 	atomic_inc(&cm_id_priv->work_count);
 	spin_unlock_irq(&cm.lock);
@@ -2018,7 +2018,7 @@ static int cm_req_handler(struct cm_work *work)
 	return 0;
 
 rejected:
-	atomic_dec(&cm_id_priv->refcount);
+	refcount_dec(&cm_id_priv->refcount);
 	cm_deref_id(listen_cm_id_priv);
 free_timeinfo:
 	kfree(cm_id_priv->timewait_info);
@@ -2792,7 +2792,7 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 				cm_local_id(timewait_info->work.local_id));
 		if (cm_id_priv) {
 			if (cm_id_priv->id.remote_id == remote_id)
-				atomic_inc(&cm_id_priv->refcount);
+				refcount_inc(&cm_id_priv->refcount);
 			else
 				cm_id_priv = NULL;
 		}
@@ -3562,8 +3562,8 @@ static int cm_sidr_req_handler(struct cm_work *work)
 		cm_reject_sidr_req(cm_id_priv, IB_SIDR_UNSUPPORTED);
 		goto out; /* No match. */
 	}
-	atomic_inc(&cur_cm_id_priv->refcount);
-	atomic_inc(&cm_id_priv->refcount);
+	refcount_inc(&cur_cm_id_priv->refcount);
+	refcount_inc(&cm_id_priv->refcount);
 	spin_unlock_irq(&cm.lock);
 
 	cm_id_priv->id.cm_handler = cur_cm_id_priv->id.cm_handler;
-- 
2.17.2

