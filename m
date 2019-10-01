Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503C6C3D85
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Oct 2019 19:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbfJARAh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Oct 2019 13:00:37 -0400
Received: from stargate.chelsio.com ([12.32.117.8]:33688 "EHLO
        stargate.chelsio.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727389AbfJARAe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 1 Oct 2019 13:00:34 -0400
Received: from localhost (budha.blr.asicdesigners.com [10.193.185.4])
        by stargate.chelsio.com (8.13.8/8.13.8) with ESMTP id x91H0VbL013282;
        Tue, 1 Oct 2019 10:00:32 -0700
From:   Krishnamraju Eraparaju <krishna2@chelsio.com>
To:     jgg@ziepe.ca, bmt@zurich.ibm.com
Cc:     linux-rdma@vger.kernel.org, bharat@chelsio.com,
        nirranjan@chelsio.com,
        Krishnamraju Eraparaju <krishna2@chelsio.com>
Subject: [PATCH for-rc] RDMA/siw: move iw_rem_ref() calls out of spinlocks
Date:   Tue,  1 Oct 2019 22:30:25 +0530
Message-Id: <20191001170025.31626-1-krishna2@chelsio.com>
X-Mailer: git-send-email 2.23.0.rc0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

kref release routines usually perform memory release operations,
so they should not be called with spinlocks held.
one such case is: SIW release routine siw_free_qp() calls sleepable
vfree() to release queue memory.

Hence, all iw_rem_ref() calls in IWCM are moved out of spinlocks.

Signed-off-by: Krishnamraju Eraparaju <krishna2@chelsio.com>
---
 drivers/infiniband/core/iwcm.c | 52 +++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/drivers/infiniband/core/iwcm.c b/drivers/infiniband/core/iwcm.c
index 72141c5b7c95..ade71823370f 100644
--- a/drivers/infiniband/core/iwcm.c
+++ b/drivers/infiniband/core/iwcm.c
@@ -372,6 +372,7 @@ EXPORT_SYMBOL(iw_cm_disconnect);
 static void destroy_cm_id(struct iw_cm_id *cm_id)
 {
 	struct iwcm_id_private *cm_id_priv;
+	struct ib_qp *qp;
 	unsigned long flags;
 
 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
@@ -389,6 +390,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 	set_bit(IWCM_F_DROP_EVENTS, &cm_id_priv->flags);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	qp = cm_id_priv->qp;
+	cm_id_priv->qp = NULL;
+
 	switch (cm_id_priv->state) {
 	case IW_CM_STATE_LISTEN:
 		cm_id_priv->state = IW_CM_STATE_DESTROYING;
@@ -401,7 +405,7 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		cm_id_priv->state = IW_CM_STATE_DESTROYING;
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 		/* Abrupt close of the connection */
-		(void)iwcm_modify_qp_err(cm_id_priv->qp);
+		(void)iwcm_modify_qp_err(qp);
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
 		break;
 	case IW_CM_STATE_IDLE:
@@ -426,11 +430,9 @@ static void destroy_cm_id(struct iw_cm_id *cm_id)
 		BUG();
 		break;
 	}
-	if (cm_id_priv->qp) {
-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
-		cm_id_priv->qp = NULL;
-	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	if (qp)
+		cm_id_priv->id.device->ops.iw_rem_ref(qp);
 
 	if (cm_id->mapped) {
 		iwpm_remove_mapinfo(&cm_id->local_addr, &cm_id->m_local_addr);
@@ -671,11 +673,11 @@ int iw_cm_accept(struct iw_cm_id *cm_id,
 		BUG_ON(cm_id_priv->state != IW_CM_STATE_CONN_RECV);
 		cm_id_priv->state = IW_CM_STATE_IDLE;
 		spin_lock_irqsave(&cm_id_priv->lock, flags);
-		if (cm_id_priv->qp) {
-			cm_id->device->ops.iw_rem_ref(qp);
-			cm_id_priv->qp = NULL;
-		}
+		qp = cm_id_priv->qp;
+		cm_id_priv->qp = NULL;
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+		if (qp)
+			cm_id->device->ops.iw_rem_ref(qp);
 		clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
 		wake_up_all(&cm_id_priv->connect_wait);
 	}
@@ -696,7 +698,7 @@ int iw_cm_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
 	struct iwcm_id_private *cm_id_priv;
 	int ret;
 	unsigned long flags;
-	struct ib_qp *qp;
+	struct ib_qp *qp = NULL;
 
 	cm_id_priv = container_of(cm_id, struct iwcm_id_private, id);
 
@@ -730,13 +732,13 @@ int iw_cm_connect(struct iw_cm_id *cm_id, struct iw_cm_conn_param *iw_param)
 		return 0;	/* success */
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id_priv->qp) {
-		cm_id->device->ops.iw_rem_ref(qp);
-		cm_id_priv->qp = NULL;
-	}
+	qp = cm_id_priv->qp;
+	cm_id_priv->qp = NULL;
 	cm_id_priv->state = IW_CM_STATE_IDLE;
 err:
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	if (qp)
+		cm_id->device->ops.iw_rem_ref(qp);
 	clear_bit(IWCM_F_CONNECT_WAIT, &cm_id_priv->flags);
 	wake_up_all(&cm_id_priv->connect_wait);
 	return ret;
@@ -878,6 +880,7 @@ static int cm_conn_est_handler(struct iwcm_id_private *cm_id_priv,
 static int cm_conn_rep_handler(struct iwcm_id_private *cm_id_priv,
 			       struct iw_cm_event *iw_event)
 {
+	struct ib_qp *qp = NULL;
 	unsigned long flags;
 	int ret;
 
@@ -896,11 +899,13 @@ static int cm_conn_rep_handler(struct iwcm_id_private *cm_id_priv,
 		cm_id_priv->state = IW_CM_STATE_ESTABLISHED;
 	} else {
 		/* REJECTED or RESET */
-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
+		qp = cm_id_priv->qp;
 		cm_id_priv->qp = NULL;
 		cm_id_priv->state = IW_CM_STATE_IDLE;
 	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+	if (qp)
+		cm_id_priv->id.device->ops.iw_rem_ref(qp);
 	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
 
 	if (iw_event->private_data_len)
@@ -942,21 +947,18 @@ static void cm_disconnect_handler(struct iwcm_id_private *cm_id_priv,
 static int cm_close_handler(struct iwcm_id_private *cm_id_priv,
 				  struct iw_cm_event *iw_event)
 {
+	struct ib_qp *qp;
 	unsigned long flags;
-	int ret = 0;
+	int ret = 0, notify_event = 0;
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
+	qp = cm_id_priv->qp;
+	cm_id_priv->qp = NULL;
 
-	if (cm_id_priv->qp) {
-		cm_id_priv->id.device->ops.iw_rem_ref(cm_id_priv->qp);
-		cm_id_priv->qp = NULL;
-	}
 	switch (cm_id_priv->state) {
 	case IW_CM_STATE_ESTABLISHED:
 	case IW_CM_STATE_CLOSING:
 		cm_id_priv->state = IW_CM_STATE_IDLE;
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
-		spin_lock_irqsave(&cm_id_priv->lock, flags);
+		notify_event = 1;
 		break;
 	case IW_CM_STATE_DESTROYING:
 		break;
@@ -965,6 +967,10 @@ static int cm_close_handler(struct iwcm_id_private *cm_id_priv,
 	}
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 
+	if (qp)
+		cm_id_priv->id.device->ops.iw_rem_ref(qp);
+	if (notify_event)
+		ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, iw_event);
 	return ret;
 }
 
-- 
2.23.0.rc0

