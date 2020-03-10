Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4206417F382
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 10:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbgCJJ0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 05:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:58100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726446AbgCJJ0e (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 05:26:34 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8F992051A;
        Tue, 10 Mar 2020 09:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583832393;
        bh=0y5edNWZHu3/XWO00IFXouP8tMMnUA4regWiytzigqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gIFpNW/05ynGDooOikeXLeJrmomyUkYNGilj9grw3+nf7Xx7Kf2Q3UbZMZo130wfX
         4Wh3dMsxLPwVoVS69y8eXTYKnDhICYWiJeKqU4PK0oP6Txbm1enz30doWts5yXB/F/
         lPP/1oQ227Skv2D/qEjeCFOaJXyjkxNRyvKphjQg=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 15/15] RDMA/cm: Make sure the cm_id is in the IB_CM_IDLE state in destroy
Date:   Tue, 10 Mar 2020 11:25:45 +0200
Message-Id: <20200310092545.251365-16-leon@kernel.org>
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

The first switch statement in cm_destroy_id() tries to move the ID to
either IB_CM_IDLE or IB_CM_TIMEWAIT. Both states will block concurrent
MAD handlers from progressing.

Previous patches removed the unreliably lock/unlock sequences in this
flow, this patch removes the extra locking steps and adds the missing
parts to guarantee that destroy reaches IB_CM_IDLE. There is no point in
leaving the ID in the IB_CM_TIMEWAIT state the memory about to be kfreed.

Rework things to hold the lock across all the state transitions and
directly assert when done that it ended up in IB_CM_IDLE as expected.

This was accompanied by a careful audit of all the state transitions here,
which generally did end up in IDLE on their success and non-racy paths.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 41 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f536e20e5394..bbbfa77dbce7 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1030,34 +1030,34 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	struct cm_work *work;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-retest:
 	spin_lock_irq(&cm_id_priv->lock);
+retest:
 	switch (cm_id->state) {
 	case IB_CM_LISTEN:
-		spin_unlock_irq(&cm_id_priv->lock);
-
-		spin_lock_irq(&cm.lock);
+		spin_lock(&cm.lock);
 		if (--cm_id_priv->listen_sharecount > 0) {
 			/* The id is still shared. */
 			WARN_ON(refcount_read(&cm_id_priv->refcount) == 1);
+			spin_unlock(&cm.lock);
+			spin_unlock_irq(&cm_id_priv->lock);
 			cm_deref_id(cm_id_priv);
-			spin_unlock_irq(&cm.lock);
 			return;
 		}
+		cm_id->state = IB_CM_IDLE;
 		rb_erase(&cm_id_priv->service_node, &cm.listen_service_table);
 		RB_CLEAR_NODE(&cm_id_priv->service_node);
-		spin_unlock_irq(&cm.lock);
+		spin_unlock(&cm.lock);
 		break;
 	case IB_CM_SIDR_REQ_SENT:
 		cm_id->state = IB_CM_IDLE;
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
-		spin_unlock_irq(&cm_id_priv->lock);
 		break;
 	case IB_CM_SIDR_REQ_RCVD:
 		cm_send_sidr_rep_locked(cm_id_priv,
 					&(struct ib_cm_sidr_rep_param){
 						.status = IB_SIDR_REJECT });
-		spin_unlock_irq(&cm_id_priv->lock);
+		/* cm_send_sidr_rep_locked will not move to IDLE if it fails */
+		cm_id->state = IB_CM_IDLE;
 		break;
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
@@ -1066,18 +1066,15 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 				   &cm_id_priv->id.device->node_guid,
 				   sizeof(cm_id_priv->id.device->node_guid),
 				   NULL, 0);
-		spin_unlock_irq(&cm_id_priv->lock);
 		break;
 	case IB_CM_REQ_RCVD:
 		if (err == -ENOMEM) {
 			/* Do not reject to allow future retries. */
 			cm_reset_to_idle(cm_id_priv);
-			spin_unlock_irq(&cm_id_priv->lock);
 		} else {
 			cm_send_rej_locked(cm_id_priv,
 					   IB_CM_REJ_CONSUMER_DEFINED, NULL, 0,
 					   NULL, 0);
-			spin_unlock_irq(&cm_id_priv->lock);
 		}
 		break;
 	case IB_CM_REP_SENT:
@@ -1089,31 +1086,35 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 	case IB_CM_MRA_REP_SENT:
 		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
 				   0, NULL, 0);
-		spin_unlock_irq(&cm_id_priv->lock);
 		break;
 	case IB_CM_ESTABLISHED:
 		if (cm_id_priv->qp_type == IB_QPT_XRC_TGT) {
-			spin_unlock_irq(&cm_id_priv->lock);
+			cm_id->state = IB_CM_IDLE;
 			break;
 		}
 		cm_send_dreq_locked(cm_id_priv, NULL, 0);
-		spin_unlock_irq(&cm_id_priv->lock);
 		goto retest;
 	case IB_CM_DREQ_SENT:
 		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
 		cm_enter_timewait(cm_id_priv);
-		spin_unlock_irq(&cm_id_priv->lock);
-		break;
+		goto retest;
 	case IB_CM_DREQ_RCVD:
 		cm_send_drep_locked(cm_id_priv, NULL, 0);
-		spin_unlock_irq(&cm_id_priv->lock);
+		WARN_ON(cm_id->state != IB_CM_TIMEWAIT);
+		goto retest;
+	case IB_CM_TIMEWAIT:
+		/*
+		 * The cm_acquire_id in cm_timewait_handler will stop working
+		 * once we do cm_free_id() below, so just move to idle here for
+		 * consistency.
+		 */
+		cm_id->state = IB_CM_IDLE;
 		break;
-	default:
-		spin_unlock_irq(&cm_id_priv->lock);
+	case IB_CM_IDLE:
 		break;
 	}
+	WARN_ON(cm_id->state != IB_CM_IDLE);
 
-	spin_lock_irq(&cm_id_priv->lock);
 	spin_lock(&cm.lock);
 	/* Required for cleanup paths related cm_req_handler() */
 	if (cm_id_priv->timewait_info) {
-- 
2.24.1

