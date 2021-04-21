Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59F0C366A08
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 13:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237856AbhDULlr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 07:41:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:55528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237575AbhDULlq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 07:41:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E9AD6143D;
        Wed, 21 Apr 2021 11:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619005273;
        bh=6fZEPoQxr0dZeN/ErO+Jjz9RccyPeqZcIMIMOc94rVI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fPzTbrKo+Da6ABWyDYFd/Sr0xQwZJtYJlioJhtheNKZMgWdIrjEXIPlJZyI4pGrMA
         63pQ6Wm/Ri+7pYc4jx0z5zAaDuegnx7wFTMQ9mNTwFF7sg1Ycs6eQqLoxdovdNF8C2
         tdY+Itym19T/Wnxvxvmh4y+tVdYkRuwQ8O7aV3InCQbTgKEJ8/ANSieSOYvhzvHMwv
         HqFAwW66SvbUIEVeKSMTx1SCEi6xAhquXrq+NCIu06tmODt8ExiYVekSwwTcIWFnJ1
         dKUHixZciri0wKd+aldKZgltklweWU8NxrPNauESHwOD9FPeNlw+UK1M7SO7ped9R9
         BVus7xIbYxP9A==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Mark Zhang <markzhang@nvidia.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 6/9] IB/cm: Simplify ib_cancel_mad() and ib_modify_mad() calls
Date:   Wed, 21 Apr 2021 14:40:36 +0300
Message-Id: <788a5154c70f095b0b38ac70898622eb3012909f.1619004798.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619004798.git.leonro@nvidia.com>
References: <cover.1619004798.git.leonro@nvidia.com>
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
 drivers/infiniband/core/cm.c       | 42 ++++++++++++++----------------
 drivers/infiniband/core/mad.c      | 17 +++++-------
 drivers/infiniband/core/sa_query.c |  4 +--
 include/rdma/ib_mad.h              | 27 +++++++++----------
 4 files changed, 39 insertions(+), 51 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 8a7ac605fded..2d62c90f9790 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1058,7 +1058,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		break;
 	case IB_CM_SIDR_REQ_SENT:
 		cm_id->state = IB_CM_IDLE;
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		break;
 	case IB_CM_SIDR_REQ_RCVD:
 		cm_send_sidr_rep_locked(cm_id_priv,
@@ -1069,7 +1069,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		break;
 	case IB_CM_REQ_SENT:
 	case IB_CM_MRA_REQ_RCVD:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_TIMEOUT,
 				   &cm_id_priv->id.device->node_guid,
 				   sizeof(cm_id_priv->id.device->node_guid),
@@ -1087,7 +1087,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		break;
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		cm_send_rej_locked(cm_id_priv, IB_CM_REJ_CONSUMER_DEFINED, NULL,
 				   0, NULL, 0);
 		goto retest;
@@ -1105,7 +1105,7 @@ static void cm_destroy_id(struct ib_cm_id *cm_id, int err)
 		cm_send_dreq_locked(cm_id_priv, NULL, 0);
 		goto retest;
 	case IB_CM_DREQ_SENT:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		cm_enter_timewait(cm_id_priv);
 		goto retest;
 	case IB_CM_DREQ_RCVD:
@@ -2531,7 +2531,7 @@ static int cm_rep_handler(struct cm_work *work)
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
 				       cm_id_priv->alt_av.timeout - 1);
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 
@@ -2555,7 +2555,7 @@ static int cm_establish_handler(struct cm_work *work)
 		goto out;
 	}
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2588,7 +2588,7 @@ static int cm_rtu_handler(struct cm_work *work)
 	}
 	cm_id_priv->id.state = IB_CM_ESTABLISHED;
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -2633,7 +2633,7 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 
 	if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT ||
 	    cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 
 	msg = cm_alloc_priv_msg(cm_id_priv);
 	if (IS_ERR(msg)) {
@@ -2807,12 +2807,12 @@ static int cm_dreq_handler(struct cm_work *work)
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
@@ -2873,7 +2873,7 @@ static int cm_drep_handler(struct cm_work *work)
 	}
 	cm_enter_timewait(cm_id_priv);
 
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -3009,7 +3009,7 @@ static int cm_rej_handler(struct cm_work *work)
 	case IB_CM_MRA_REQ_RCVD:
 	case IB_CM_REP_SENT:
 	case IB_CM_MRA_REP_RCVD:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		fallthrough;
 	case IB_CM_REQ_RCVD:
 	case IB_CM_MRA_REQ_SENT:
@@ -3019,7 +3019,7 @@ static int cm_rej_handler(struct cm_work *work)
 			cm_reset_to_idle(cm_id_priv);
 		break;
 	case IB_CM_DREQ_SENT:
-		ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+		ib_cancel_mad(cm_id_priv->msg);
 		fallthrough;
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
@@ -3029,8 +3029,7 @@ static int cm_rej_handler(struct cm_work *work)
 		if (cm_id_priv->id.lap_state == IB_CM_LAP_UNINIT ||
 		    cm_id_priv->id.lap_state == IB_CM_LAP_SENT) {
 			if (cm_id_priv->id.lap_state == IB_CM_LAP_SENT)
-				ib_cancel_mad(cm_id_priv->av.port->mad_agent,
-					      cm_id_priv->msg);
+				ib_cancel_mad(cm_id_priv->msg);
 			cm_enter_timewait(cm_id_priv);
 			break;
 		}
@@ -3169,16 +3168,14 @@ static int cm_mra_handler(struct cm_work *work)
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
@@ -3186,8 +3183,7 @@ static int cm_mra_handler(struct cm_work *work)
 		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
 			    CM_MSG_RESPONSE_OTHER ||
 		    cm_id_priv->id.lap_state != IB_CM_LAP_SENT ||
-		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
-				  cm_id_priv->msg, timeout)) {
+		    ib_modify_mad(cm_id_priv->msg, timeout)) {
 			if (cm_id_priv->id.lap_state == IB_CM_MRA_LAP_RCVD)
 				atomic_long_inc(&work->port->
 						counter_group[CM_RECV_DUPLICATES].
@@ -3387,7 +3383,7 @@ static int cm_apr_handler(struct cm_work *work)
 		goto out;
 	}
 	cm_id_priv->id.lap_state = IB_CM_LAP_IDLE;
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	cm_queue_work_unlock(cm_id_priv, work);
 	return 0;
 out:
@@ -3715,7 +3711,7 @@ static int cm_sidr_rep_handler(struct cm_work *work)
 		goto out;
 	}
 	cm_id_priv->id.state = IB_CM_IDLE;
-	ib_cancel_mad(cm_id_priv->av.port->mad_agent, cm_id_priv->msg);
+	ib_cancel_mad(cm_id_priv->msg);
 	spin_unlock_irq(&cm_id_priv->lock);
 
 	cm_format_sidr_rep_event(work, cm_id_priv);
diff --git a/drivers/infiniband/core/mad.c b/drivers/infiniband/core/mad.c
index 2081e4854fb0..df6226f45047 100644
--- a/drivers/infiniband/core/mad.c
+++ b/drivers/infiniband/core/mad.c
@@ -2459,16 +2459,18 @@ find_send_wr(struct ib_mad_agent_private *mad_agent_priv,
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
@@ -2493,13 +2495,6 @@ int ib_modify_mad(struct ib_mad_agent *mad_agent,
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

