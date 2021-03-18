Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD0AB3402B0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 11:04:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCRKDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 06:03:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:39862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229558AbhCRKDa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 06:03:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6630564F30;
        Thu, 18 Mar 2021 10:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616061810;
        bh=xJyRu5hpIuL61ghN+5qdUK6rSOnqNN81AzB3C04lJl0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rP9HrP3GkfTTfw4Ot5Vp1c/GzKRNyqcxEPUxPxsDf3C1y3JOAsE0g0Hd1d/RWV8jO
         atNenzfdrTsGOHnEpGatHicbHURoAkvlkbjHP6/LeWjuy3sCgdu/jNFB4YDMRXruDh
         0WxNVOKCqwDNWQoOb29dBk3DQkR40q6kOaNivXeqB0/fWaDZ5Is6vat1qdXaopXiVq
         VsMGS2mTC6279zAJU+ZsbDWCS8oJ5td282MEJUAtEt83kCrfcwSQ5mVOMbBirxyuuU
         sk7JWHt5F+iH+d0Xc0PYILPdjJF0gwh62IvFt8h9OF2PLw13G2x7Dknd7mUrgKt2X5
         obyYJZlWztkVw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/6] IB/cm: Remove "mad_agent" parameter of ib_cancel_mad
Date:   Thu, 18 Mar 2021 12:03:05 +0200
Message-Id: <20210318100309.670344-3-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210318100309.670344-1-leon@kernel.org>
References: <20210318100309.670344-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Mark Zhang <markzhang@nvidia.com>

The mad_agent parameter is redundant since the struct ib_mad_send_buf
already has a pointer of it.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c       | 33 +++++++++++++++---------------
 drivers/infiniband/core/mad.c      |  7 -------
 drivers/infiniband/core/sa_query.c |  4 +---
 include/rdma/ib_mad.h              | 23 +++++++++++----------
 4 files changed, 29 insertions(+), 38 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f397edd8e0a0..2cee5352c620 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1023,7 +1023,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		break;
 	case IB_CM_SIDR_REQ_SENT:
 		cm_id->state = IB_CM_IDLE;
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		break;
 	case IB_CM_SIDR_REQ_RCVD:
 		cm_send_sidr_rep_locked(cm_id_priv,
@@ -1034,7 +1034,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		break;
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_TIMEOUT,
 				   &cm_id_priv->id.device->node_guid,
 				   sizeof(cm_id_priv->id.device->node_guid),
@@ -1052,7 +1052,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		break;
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
 				   0, NULL, 0);
 		goto retest;
@@ -1070,7 +1070,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		cm_send_dreq_locked(cm_id_priv, NULL, 0);
 		goto retest;
 	case IB_CM_DREQ_SENT:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		cm_enter_timewait(cm_id_priv);
 		goto retest;
 	case IB_CM_DREQ_RCVD:
@@ -2490,7 +2490,7 @@ static int cm_rep_handler(struct cm_work *work)
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
 				       cm_id_priv->alt_av.timeout - 1);
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 
@@ -2514,7 +2514,7 @@ static int cm_establish_handler(struct cm_work *work)
 		goto out;
 	}
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2547,7 +2547,7 @@ static int cm_rtu_handler(struct cm_work *work)
 	}
 	cm_id_priv->id.state = IB_CM_ESTABLISHED;
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2592,7 +2592,7 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 
 	if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT ||
 	    cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 
 	ret = cm_alloc_msg(cm_id_priv, &msg);
 	if (ret) {
@@ -2767,12 +2767,12 @@ static int cm_dreq_handler(struct cm_work *work)
 	switch (cm_id_priv->id.state) {
 	case IB_CM_REP_SENT:
 	case IB_CM_DREQ_SENT:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		break;
 	case IB_CM_ESTABLISHED:
 		if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT ||
 		    cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
-			ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+			ib_cancel_mad(cm_id_priv->msg);
 		break;
 	case IB_CM_MRA_REP_RCVD:
 		break;
@@ -2833,7 +2833,7 @@ static int cm_drep_handler(struct cm_work *work)
 	}
 	cm_enter_timewait(cm_id_priv);
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2969,7 +2969,7 @@ static int cm_rej_handler(struct cm_work *work)
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		fallthrough;
 	case IB_CM_REQ_RCVD:
 	case IB_CM_MRA_REQ_SENT:
@@ -2979,7 +2979,7 @@ static int cm_rej_handler(struct cm_work *work)
 			cm_reset_to_idle(cm_id_priv);
 		break;
 	case IB_CM_DREQ_SENT:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		fallthrough;
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
@@ -2989,8 +2989,7 @@ static int cm_rej_handler(struct cm_work *work)
 		if (cm_id_priv->id.lap_state == IB_CM_LAP_UNINIT ||
 		    cm_id_priv->id.lap_state == IB_CM_LAP_SENT) {
 			if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT)
-				ib_cancel_mad(cm_id_priv->av.port->mad_agent,
-					      cm_id_priv->msg);
+				ib_cancel_mad(cm_id_priv->msg);
 			cm_enter_timewait(cm_id_priv);
 			break;
 		}
@@ -3347,7 +3346,7 @@ static int cm_apr_handler(struct cm_work *work)
 		goto out;
 	}
 	cm_id_priv->id.lap_state = IB_CM_LAP_IDLE;
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_id_priv->msg = NULL;
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
@@ -3673,7 +3672,7 @@ static int cm_sidr_rep_handler(struct cm_work *work)
 		goto out;
 	}
 	cm_id_priv->id.state = IB_CM_IDLE;
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	spin_unlock_irq(&cm_id_priv->lock);
 
 	cm_format_sidr_rep_event(work, cm_id_priv);
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index ce0397fd4b7d..31a97cf1ef81 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2498,13 +2498,6 @@ int ib_modify_mad(struct ib_mad_agent *mad_agent,
 }
 EXPORT_SYMBOL(ib_modify_mad);
 
-void ib_cancel_mad(struct ib_mad_agent *mad_agent,
-		   struct ib_mad_send_buf *send_buf)
-{
-	ib_modify_mad(mad_agent, send_buf, 0);
-}
-EXPORT_SYMBOL(ib_cancel_mad);
-
 static void local_completions(struct work_struct *work)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
diff --git a/drivers/infiniband/core/sa_query.c b/drivers/infiniband/core/sa_query.c
index 8f1705c403b4..9a4a49c37922 100644
--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1172,7 +1172,6 @@ EXPORT_SYMBOL(ib_sa_unregister_client);
 void ib_sa_cancel_query(int id, struct ib_sa_query *query)
 {
 	unsigned long flags;
-	struct ib_mad_agent *agent;
 	struct ib_mad_send_buf *mad_buf;
 
 	xa_lock_irqsave(&queries, flags);
@@ -1180,7 +1179,6 @@ void ib_sa_cancel_query(int id, struct ib_sa_query *query)
 		xa_unlock_irqrestore(&queries, flags);
 		return;
 	}
-	agent = query->port->agent;
 	mad_buf = query->mad_buf;
 	xa_unlock_irqrestore(&queries, flags);
 
@@ -1190,7 +1188,7 @@ void ib_sa_cancel_query(int id, struct ib_sa_query *query)
 	 * sent to the MAD layer and has to be cancelled from there.
 	 */
 	if (!ib_nl_cancel_request(query))
-		ib_cancel_mad(agent, mad_buf);
+		ib_cancel_mad(mad_buf);
 }
 EXPORT_SYMBOL(ib_sa_cancel_query);
 
diff --git a/include/rdma/ib_mad.h b/include/rdma/ib_mad.h
index f1d34f06a68b..69b824dc7820 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -717,17 +717,6 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
  */
 void ib_free_recv_mad(struct ib_mad_recv_wc *mad_recv_wc);
 
-/**
- * ib_cancel_mad - Cancels an outstanding send MAD operation.
- * @mad_agent: Specifies the registration associated with sent MAD.
- * @send_buf: Indicates the MAD to cancel.
- *
- * MADs will be returned to the user through the corresponding
- * ib_mad_send_handler.
- */
-void ib_cancel_mad(struct ib_mad_agent *mad_agent,
-		   struct ib_mad_send_buf *send_buf);
-
 /**
  * ib_modify_mad - Modifies an outstanding send MAD operation.
  * @mad_agent: Specifies the registration associated with sent MAD.
@@ -740,6 +729,18 @@ void ib_cancel_mad(struct ib_mad_agent *mad_agent,
 int ib_modify_mad(struct ib_mad_agent *mad_agent,
 		  struct ib_mad_send_buf *send_buf, u32 timeout_ms);
 
+/**
+ * ib_cancel_mad - Cancels an outstanding send MAD operation.
+ * @send_buf: Indicates the MAD to cancel.
+ *
+ * MADs will be returned to the user through the corresponding
+ * ib_mad_send_handler.
+ */
+static inline void ib_cancel_mad(struct ib_mad_send_buf *send_buf)
+{
+	ib_modify_mad(send_buf->mad_agent, send_buf, 0);
+}
+
 /**
  * ib_create_send_mad - Allocate and initialize a data buffer and work request
  *   for sending a MAD.
-- 
2.30.2

