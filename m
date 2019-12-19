Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE3A91263E7
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Dec 2019 14:47:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbfLSNrz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Dec 2019 08:47:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:42608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfLSNry (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Dec 2019 08:47:54 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 777BB2146E;
        Thu, 19 Dec 2019 13:47:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576763274;
        bh=2BijuLgfuM1PhL0ovkHwVTOglSF+z/jBP3VaE8vScmg=;
        h=From:To:Cc:Subject:Date:From;
        b=ijyqlJ3jv3S8BJ//wL7w+64QkELoaWb3i+7+CXPcax9Z1t9kOSrkVwd701e+fhCtf
         8Lubhk5v3DTgEmxl++8XwLJGerTuObf8ZEOk1jzeCayhr1x9A0An7h4nSkHXeStp8q
         /hsJrHiFEmD1v8jH5goJt1qinT1y/bb0V1gryi9Y=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Danit Goldberg <danitg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/cm: Use RCU synchronization mechanism to protect cm_id_private xa_load()
Date:   Thu, 19 Dec 2019 15:47:50 +0200
Message-Id: <20191219134750.413429-1-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Danit Goldberg <danitg@mellanox.com>

The RCU mechanism is optimized for read-mostly scenarios and therefore
more suitable to protect the cm_id_private to decrease "cm.lock"
congestion.

This patch replaces the existing spinlock locking mechanism
and kfree with RCU mechanism in places where spinlock(cm.lock)
protected cm_id_priv xa_load.

In addition, deletes cm_get_id function and use cm_acquire_id directly
with the correct locking. The patch also removes an open coded version
of cm_get_id, and replaces it with a call to cm_acquire_id.

Signed-off-by: Danit Goldberg <danitg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 43 +++++++++++-------------------------
 1 file changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d42a3887057b..0ed69e213bf8 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -241,6 +241,7 @@ struct cm_id_private {
 	/* Number of clients sharing this ib_cm_id. Only valid for listeners.
 	 * Protected by the cm.lock spinlock. */
 	int listen_sharecount;
+	struct rcu_head rcu;
 
 	struct ib_mad_send_buf *msg;
 	struct cm_timewait_info *timewait_info;
@@ -593,28 +594,16 @@ static void cm_free_id(__be32 local_id)
 	xa_erase_irq(&cm.local_id_table, cm_local_id(local_id));
 }
 
-static struct cm_id_private * cm_get_id(__be32 local_id, __be32 remote_id)
+static struct cm_id_private *cm_acquire_id(__be32 local_id, __be32 remote_id)
 {
 	struct cm_id_private *cm_id_priv;
 
+	rcu_read_lock();
 	cm_id_priv = xa_load(&cm.local_id_table, cm_local_id(local_id));
-	if (cm_id_priv) {
-		if (cm_id_priv->id.remote_id == remote_id)
-			refcount_inc(&cm_id_priv->refcount);
-		else
-			cm_id_priv = NULL;
-	}
-
-	return cm_id_priv;
-}
-
-static struct cm_id_private * cm_acquire_id(__be32 local_id, __be32 remote_id)
-{
-	struct cm_id_private *cm_id_priv;
-
-	spin_lock_irq(&cm.lock);
-	cm_id_priv = cm_get_id(local_id, remote_id);
-	spin_unlock_irq(&cm.lock);
+	if (!cm_id_priv || cm_id_priv->id.remote_id != remote_id ||
+	    !refcount_inc_not_zero(&cm_id_priv->refcount))
+		cm_id_priv = NULL;
+	rcu_read_unlock();
 
 	return cm_id_priv;
 }
@@ -1089,7 +1078,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	rdma_destroy_ah_attr(&cm_id_priv->av.ah_attr);
 	rdma_destroy_ah_attr(&cm_id_priv->alt_av.ah_attr);
 	kfree(cm_id_priv->private_data);
-	kfree(cm_id_priv);
+	kfree_rcu(cm_id_priv, rcu);
 }
 
 void ib_destroy_cm_id(struct ib_cm_id *cm_id)
@@ -1851,7 +1840,7 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 	spin_lock_irq(&cm.lock);
 	timewait_info = cm_insert_remote_id(cm_id_priv->timewait_info);
 	if (timewait_info) {
-		cur_cm_id_priv = cm_get_id(timewait_info->work.local_id,
+		cur_cm_id_priv = cm_acquire_id(timewait_info->work.local_id,
 					   timewait_info->work.remote_id);
 		spin_unlock_irq(&cm.lock);
 		if (cur_cm_id_priv) {
@@ -1865,7 +1854,7 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 	timewait_info = cm_insert_remote_qpn(cm_id_priv->timewait_info);
 	if (timewait_info) {
 		cm_cleanup_timewait(cm_id_priv->timewait_info);
-		cur_cm_id_priv = cm_get_id(timewait_info->work.local_id,
+		cur_cm_id_priv = cm_acquire_id(timewait_info->work.local_id,
 					   timewait_info->work.remote_id);
 
 		spin_unlock_irq(&cm.lock);
@@ -2336,7 +2325,7 @@ static int cm_rep_handler(struct cm_work *work)
 		rb_erase(&cm_id_priv->timewait_info->remote_id_node,
 			 &cm.remote_id_table);
 		cm_id_priv->timewait_info->inserted_remote_id = 0;
-		cur_cm_id_priv = cm_get_id(timewait_info->work.local_id,
+		cur_cm_id_priv = cm_acquire_id(timewait_info->work.local_id,
 					   timewait_info->work.remote_id);
 
 		spin_unlock(&cm.lock);
@@ -2837,14 +2826,8 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 			spin_unlock_irq(&cm.lock);
 			return NULL;
 		}
-		cm_id_priv = xa_load(&cm.local_id_table,
-				cm_local_id(timewait_info->work.local_id));
-		if (cm_id_priv) {
-			if (cm_id_priv->id.remote_id == remote_id)
-				refcount_inc(&cm_id_priv->refcount);
-			else
-				cm_id_priv = NULL;
-		}
+		cm_id_priv =
+			cm_acquire_id(timewait_info->work.local_id, remote_id);
 		spin_unlock_irq(&cm.lock);
 	} else if (IBA_GET(CM_REJ_MESSAGE_REJECTED, rej_msg) == CM_MSG_RESPONSE_REQ)
 		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, 0);
-- 
2.20.1

