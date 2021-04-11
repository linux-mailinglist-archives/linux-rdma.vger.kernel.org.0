Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F4B235B415
	for <lists+linux-rdma@lfdr.de>; Sun, 11 Apr 2021 14:22:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbhDKMWR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 11 Apr 2021 08:22:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:44962 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhDKMWR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 11 Apr 2021 08:22:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 47D4D61006;
        Sun, 11 Apr 2021 12:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618143721;
        bh=pyN/fbBH35UJOAGqrbVuV8ioPaMlXXKj9lRMvkmheSk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R6CLu57fPJJNxnCR4oYV2gicPUWOct8Y4vXqNtE2LYIZ3lampskVGH5j+A1AsVzDK
         35puQnDBGBop/2oGJseZ/FOUhnh3FlZfD69W427QpPbiozO7z2NWaJV7bADHblrKgv
         ObH876qAtWvWfWFi5R4YXrjY6F5xtvVYkaQCvglHM9hE6zUpBYCsrB4M8gvDV1gk4C
         q9LioGjNQZvg/mmhb+zuZif9EYRHbJln36zjxMEkdJwxduejZHUnhQfPzlY5+l9gqo
         kE+5/jJ0wvgPua6808bYk7WGwLDHPXOtBm9JlDF9ImqLqlU+ILGi184aMQ3YYlAP0J
         M3dWtIYZ2V1KQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/5] IB/cm: Simplify ib_cancel_mad() and ib_modify_mad() calls
Date:   Sun, 11 Apr 2021 15:21:49 +0300
Message-Id: <20210411122152.59274-3-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210411122152.59274-1-leon@kernel.org>
References: <20210411122152.59274-1-leon@kernel.org>
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
 drivers/infiniband/core/cm.c       | 101 ++++++++++++++++++-----------
 drivers/infiniband/core/mad.c      |  17 ++---
 drivers/infiniband/core/sa_query.c |   4 +-
 include/rdma/ib_mad.h              |  27 ++++----
 4 files changed, 84 insertions(+), 65 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e33b730107b4..f7f094861f79 100644
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
@@ -1473,6 +1473,8 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 		if (ret)
 			goto out;
 	}
+
+	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	cm_id->service_id = param->service_id;
 	cm_id->service_mask = ~cpu_to_be64(0);
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
@@ -1489,7 +1491,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 
 	ret = cm_alloc_msg(cm_id_priv, &cm_id_priv->msg);
 	if (ret)
-		goto out;
+		goto error_alloc;
 
 	req_msg = (struct cm_req_msg *) cm_id_priv->msg->mad;
 	cm_format_req(req_msg, cm_id_priv, param);
@@ -1501,19 +1503,21 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->rq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
 
 	trace_icm_send_req(&cm_id_priv->id);
-	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
-	if (ret) {
-		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-		goto error2;
-	}
-	BUG_ON(cm_id->state != IB_CM_IDLE);
+	if (ret)
+		goto error_post_send_mad;
+
 	cm_id->state = IB_CM_REQ_SENT;
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return 0;
 
-error2:	cm_free_msg(cm_id_priv->msg);
-out:	return ret;
+error_post_send_mad:
+	cm_free_msg(cm_id_priv->msg);
+	cm_id_priv->msg = NULL;
+error_alloc:
+	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
+out:
+	return ret;
 }
 EXPORT_SYMBOL(ib_send_cm_req);
 
@@ -2491,7 +2495,7 @@ static int cm_rep_handler(struct cm_work *work)
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
 				       cm_id_priv->alt_av.timeout - 1);
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 
@@ -2515,7 +2519,7 @@ static int cm_establish_handler(struct cm_work *work)
 		goto out;
 	}
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2548,7 +2552,7 @@ static int cm_rtu_handler(struct cm_work *work)
 	}
 	cm_id_priv->id.state = IB_CM_ESTABLISHED;
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2593,7 +2597,7 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 
 	if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT ||
 	    cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 
 	ret = cm_alloc_msg(cm_id_priv, &msg);
 	if (ret) {
@@ -2768,12 +2772,12 @@ static int cm_dreq_handler(struct cm_work *work)
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
@@ -2834,7 +2838,7 @@ static int cm_drep_handler(struct cm_work *work)
 	}
 	cm_enter_timewait(cm_id_priv);
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2970,7 +2974,7 @@ static int cm_rej_handler(struct cm_work *work)
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		fallthrough;
 	case IB_CM_REQ_RCVD:
 	case IB_CM_MRA_REQ_SENT:
@@ -2980,7 +2984,7 @@ static int cm_rej_handler(struct cm_work *work)
 			cm_reset_to_idle(cm_id_priv);
 		break;
 	case IB_CM_DREQ_SENT:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		fallthrough;
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
@@ -2990,8 +2994,7 @@ static int cm_rej_handler(struct cm_work *work)
 		if (cm_id_priv->id.lap_state == IB_CM_LAP_UNINIT ||
 		    cm_id_priv->id.lap_state == IB_CM_LAP_SENT) {
 			if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT)
-				ib_cancel_mad(cm_id_priv->av.port->mad_agent,
-					      cm_id_priv->msg);
+				ib_cancel_mad(cm_id_priv->msg);
 			cm_enter_timewait(cm_id_priv);
 			break;
 		}
@@ -3130,16 +3133,14 @@ static int cm_mra_handler(struct cm_work *work)
 	case IB_CM_REQ_SENT:
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
 			    CM_MSG_RESPONSE_REQ ||
-		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
-				  cm_id_priv->msg, timeout))
+		    ib_modify_mad(cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REQ_RCVD;
 		break;
 	case IB_CM_REP_SENT:
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
 			    CM_MSG_RESPONSE_REP ||
-		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
-				  cm_id_priv->msg, timeout))
+		    ib_modify_mad(cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REP_RCVD;
 		break;
@@ -3147,8 +3148,7 @@ static int cm_mra_handler(struct cm_work *work)
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
 			    CM_MSG_RESPONSE_OTHER ||
 		    cm_id_priv->id.lap_state != IB_CM_LAP_SENT ||
-		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
-				  cm_id_priv->msg, timeout)) {
+		    ib_modify_mad(cm_id_priv->msg, timeout)) {
 			if (cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
 				atomic_long_inc(&work->port->
 						counter_group[CM_RECV_DUPLICATES].
@@ -3348,7 +3348,7 @@ static int cm_apr_handler(struct cm_work *work)
 		goto out;
 	}
 	cm_id_priv->id.lap_state = IB_CM_LAP_IDLE;
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_id_priv->msg = NULL;
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
@@ -3674,7 +3674,7 @@ static int cm_sidr_rep_handler(struct cm_work *work)
 		goto out;
 	}
 	cm_id_priv->id.state = IB_CM_IDLE;
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	spin_unlock_irq(&cm_id_priv->lock);
 
 	cm_format_sidr_rep_event(work, cm_id_priv);
@@ -3730,17 +3730,23 @@ static void cm_process_send_error(struct ib_mad_send_buf *msg,
 
 	/* No other events can occur on the cm_id at this point. */
 	ret = cm_id_priv->id.cm_handler(&cm_id_priv->id, &cm_event);
+	spin_lock_irq(&cm_id_priv->lock);
 	cm_free_msg(msg);
+	cm_id_priv->msg = NULL;
+	spin_unlock_irq(&cm_id_priv->lock);
 	if (ret)
 		ib_destroy_cm_id(&cm_id_priv->id);
 	return;
 discard:
-	spin_unlock_irq(&cm_id_priv->lock);
+	if (msg == cm_id_priv->msg)
+		cm_id_priv->msg = NULL;
 	cm_free_msg(msg);
+	spin_unlock_irq(&cm_id_priv->lock);
 }
 
-static void cm_send_handler(struct ib_mad_agent *mad_agent,
-			    struct ib_mad_send_wc *mad_send_wc)
+static void __cm_send_handler(struct ib_mad_agent *mad_agent,
+			      struct ib_mad_send_wc *mad_send_wc,
+			      struct cm_id_private *cm_id_priv)
 {
 	struct ib_mad_send_buf *msg = mad_send_wc->send_buf;
 	struct cm_port *port;
@@ -3769,16 +3775,37 @@ static void cm_send_handler(struct ib_mad_agent *mad_agent,
 	case IB_WC_SUCCESS:
 	case IB_WC_WR_FLUSH_ERR:
 		cm_free_msg(msg);
+		if (cm_id_priv)
+			cm_id_priv->msg = NULL;
 		break;
 	default:
-		if (msg->context[0] && msg->context[1])
+		if (msg->context[0] && msg->context[1]) {
 			cm_process_send_error(msg, mad_send_wc->status);
-		else
+		} else {
 			cm_free_msg(msg);
+			if (cm_id_priv)
+				cm_id_priv->msg = NULL;
+		}
 		break;
 	}
 }
 
+static void cm_send_handler(struct ib_mad_agent *mad_agent,
+			    struct ib_mad_send_wc *mad_send_wc)
+{
+	struct ib_mad_send_buf *msg = mad_send_wc->send_buf;
+	struct cm_id_private *cm_id_priv;
+
+	cm_id_priv = msg->context[0];
+	if (!cm_id_priv || cm_id_priv->msg != msg) {
+		__cm_send_handler(mad_agent, mad_send_wc, NULL);
+	} else {
+		spin_lock_irq(&cm_id_priv->lock);
+		__cm_send_handler(mad_agent, mad_send_wc, cm_id_priv);
+		spin_unlock_irq(&cm_id_priv->lock);
+	}
+}
+
 static void cm_work_handler(struct work_struct *_work)
 {
 	struct cm_work *work = container_of(_work, struct cm_work, work.work);
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index ce0397fd4b7d..e7ff4420777e 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2464,16 +2464,18 @@ find_send_wr(struct ib_mad_agent_private *mad_agent_priv,
 	return NULL;
 }
 
-int ib_modify_mad(struct ib_mad_agent *mad_agent,
-		  struct ib_mad_send_buf *send_buf, u32 timeout_ms)
+int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms)
 {
 	struct ib_mad_agent_private *mad_agent_priv;
 	struct ib_mad_send_wr_private *mad_send_wr;
 	unsigned long flags;
 	int active;
 
-	mad_agent_priv = container_of(mad_agent, struct ib_mad_agent_private,
-				      agent);
+	if (!send_buf)
+		return -EINVAL;
+
+	mad_agent_priv = container_of(send_buf->mad_agent,
+				      struct ib_mad_agent_private, agent);
 	spin_lock_irqsave(&mad_agent_priv->lock, flags);
 	mad_send_wr = find_send_wr(mad_agent_priv, send_buf);
 	if (!mad_send_wr || mad_send_wr->status != IB_WC_SUCCESS) {
@@ -2498,13 +2500,6 @@ int ib_modify_mad(struct ib_mad_agent *mad_agent,
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
index f1d34f06a68b..465b0d0bdaf8 100644
--- a/include/rdma/ib_mad.h
+++ b/include/rdma/ib_mad.h
@@ -717,28 +717,27 @@ int ib_post_send_mad(struct ib_mad_send_buf *send_buf,
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
- * @mad_agent: Specifies the registration associated with sent MAD.
  * @send_buf: Indicates the MAD to modify.
  * @timeout_ms: New timeout value for sent MAD.
  *
  * This call will reset the timeout value for a sent MAD to the specified
  * value.
  */
-int ib_modify_mad(struct ib_mad_agent *mad_agent,
-		  struct ib_mad_send_buf *send_buf, u32 timeout_ms);
+int ib_modify_mad(struct ib_mad_send_buf *send_buf, u32 timeout_ms);
+
+/**
+ * ib_cancel_mad - Cancels an outstanding send MAD operation.
+ * @send_buf: Indicates the MAD to cancel.
+ *
+ * MADs will be returned to the user through the corresponding
+ * ib_mad_send_handler.
+ */
+static inline void ib_cancel_mad(struct ib_mad_send_buf *send_buf)
+{
+	ib_modify_mad(send_buf, 0);
+}
 
 /**
  * ib_create_send_mad - Allocate and initialize a data buffer and work request
-- 
2.30.2

