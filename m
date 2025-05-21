Return-Path: <linux-rdma+bounces-10477-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62EE1ABF2E4
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 13:34:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D418177837
	for <lists+linux-rdma@lfdr.de>; Wed, 21 May 2025 11:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09972638BA;
	Wed, 21 May 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHzFoaGb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8F22627EC
	for <linux-rdma@vger.kernel.org>; Wed, 21 May 2025 11:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747827264; cv=none; b=koWLIAO+CGuCaQnqKBmkw3kQltZQHZw7yR0D4cpuoQ+u+5tMdz5UxJzt2s33NirPs/4HudbZZR0M7tcynAGvtgYOITVei80wgpUMYo4hKHpapUQXANGT0IL+yoZmAz89sznXL+uLWsL6mED7jbFRmLYO9HVNQYoCxidFYa9MQJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747827264; c=relaxed/simple;
	bh=IuKeKwj7EEYmAnvkEDbHWMlhCIKrp1oWENaNlT7cMmc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OUxsnULBw1fbTuqvfEUt2TEOweL7AAvekp8QI9w9pGtpMTIrtS6CQY5UjNpYzcpmHqxrEtqxXYr1esSTgERvXfRyFCVTAa8CMgmzsUeRjzia6rTud1fLvlIoLZVfFApE8jlKFwqrxryay6R5Es+yUEiwkqn0OXK6Rfz7g61qmUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHzFoaGb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 762B9C4CEEA;
	Wed, 21 May 2025 11:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747827263;
	bh=IuKeKwj7EEYmAnvkEDbHWMlhCIKrp1oWENaNlT7cMmc=;
	h=From:To:Cc:Subject:Date:From;
	b=lHzFoaGbDgAHCgn/bsilXO4datuoWdEQVlKYklBJVJTIPMZFW7tAdjPE7EAcLKWRx
	 jUTO+yW6rtBvnkAPh6eMU8ZSWADmE4TfzwalNr4UFeFNjFR5VIh4E0XWO38kzd6doS
	 JIfEcT3NAap+NVu6/2q/5LhYHGUt4l6q6mKKpXHgcr81Vo0iSWc4Tcg+8gjiWmnKAZ
	 7CDSVCpmrwEjneZMQmCAXmWVegRqx9fNL/cNxk4WN65V6eyKv1Rw88lLiClV/CFLvs
	 g3SRd4VkTBcsGqOjoQi1wZehbi5ZDbub/nPN54a3LezYMGzZ0lV3BE6kSCF/szdrb0
	 z0f8pMFYDpr/Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Vlad Dumitrescu <vdumitrescu@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Sean Hefty <shefty@nvidia.com>
Subject: [PATCH rdma-next] IB/cm: Remove dead code and adjust naming
Date: Wed, 21 May 2025 14:34:17 +0300
Message-ID: <cdd2a237acf2b495c19ce02e4b1c42c41c6751c2.1747827207.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vlad Dumitrescu <vdumitrescu@nvidia.com>

Drop ib_send_cm_mra parameters which are always constant. Remove branch
which is never taken. Adjust name to ib_prepare_cm_mra, which better
reflects its functionality - no MRA is actually sent. Adjust name of
related tracepoints. Push setting of the constant service timeout to
cm.c and drop IB_CM_MRA_FLAG_DELAY.

Signed-off-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
Reviewed-by: Sean Hefty <shefty@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/cm.c        | 59 +++++------------------------
 drivers/infiniband/core/cm_trace.h  |  2 +-
 drivers/infiniband/core/cma.c       |  9 ++---
 drivers/infiniband/core/cma_trace.h |  2 +-
 include/rdma/ib_cm.h                | 17 ++-------
 5 files changed, 19 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index e64cbd034a2a1..8670e58675c6d 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -36,6 +36,7 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 #define CM_DESTROY_ID_WAIT_TIMEOUT 10000 /* msecs */
 #define CM_DIRECT_RETRY_CTX ((void *) 1UL)
+#define CM_MRA_SETTING 24 /* 4.096us * 2^24 = ~68.7 seconds */
 
 static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_NO_QP]			= "no QP",
@@ -241,7 +242,6 @@ struct cm_id_private {
 	u8 initiator_depth;
 	u8 retry_count;
 	u8 rnr_retry_count;
-	u8 service_timeout;
 	u8 target_ack_delay;
 
 	struct list_head work_list;
@@ -1872,7 +1872,7 @@ static void cm_process_work(struct cm_id_private *cm_id_priv,
 
 static void cm_format_mra(struct cm_mra_msg *mra_msg,
 			  struct cm_id_private *cm_id_priv,
-			  enum cm_msg_response msg_mraed, u8 service_timeout,
+			  enum cm_msg_response msg_mraed,
 			  const void *private_data, u8 private_data_len)
 {
 	cm_format_mad_hdr(&mra_msg->hdr, CM_MRA_ATTR_ID, cm_id_priv->tid);
@@ -1881,7 +1881,7 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 		be32_to_cpu(cm_id_priv->id.local_id));
 	IBA_SET(CM_MRA_REMOTE_COMM_ID, mra_msg,
 		be32_to_cpu(cm_id_priv->id.remote_id));
-	IBA_SET(CM_MRA_SERVICE_TIMEOUT, mra_msg, service_timeout);
+	IBA_SET(CM_MRA_SERVICE_TIMEOUT, mra_msg, CM_MRA_SETTING);
 
 	if (private_data && private_data_len)
 		IBA_SET_MEM(CM_MRA_PRIVATE_DATA, mra_msg, private_data,
@@ -1960,7 +1960,7 @@ static void cm_dup_req_handler(struct cm_work *work,
 	switch (cm_id_priv->id.state) {
 	case IB_CM_MRA_REQ_SENT:
 		cm_format_mra((struct cm_mra_msg *) msg->mad, cm_id_priv,
-			      CM_MSG_RESPONSE_REQ, cm_id_priv->service_timeout,
+			      CM_MSG_RESPONSE_REQ,
 			      cm_id_priv->private_data,
 			      cm_id_priv->private_data_len);
 		break;
@@ -2454,7 +2454,7 @@ static void cm_dup_rep_handler(struct cm_work *work)
 			      cm_id_priv->private_data_len);
 	else if (cm_id_priv->id.state == IB_CM_MRA_REP_SENT)
 		cm_format_mra((struct cm_mra_msg *) msg->mad, cm_id_priv,
-			      CM_MSG_RESPONSE_REP, cm_id_priv->service_timeout,
+			      CM_MSG_RESPONSE_REP,
 			      cm_id_priv->private_data,
 			      cm_id_priv->private_data_len);
 	else
@@ -3094,26 +3094,13 @@ static int cm_rej_handler(struct cm_work *work)
 	return -EINVAL;
 }
 
-int ib_send_cm_mra(struct ib_cm_id *cm_id,
-		   u8 service_timeout,
-		   const void *private_data,
-		   u8 private_data_len)
+int ib_prepare_cm_mra(struct ib_cm_id *cm_id)
 {
 	struct cm_id_private *cm_id_priv;
-	struct ib_mad_send_buf *msg;
 	enum ib_cm_state cm_state;
 	enum ib_cm_lap_state lap_state;
-	enum cm_msg_response msg_response;
-	void *data;
 	unsigned long flags;
-	int ret;
-
-	if (private_data && private_data_len > IB_CM_MRA_PRIVATE_DATA_SIZE)
-		return -EINVAL;
-
-	data = cm_copy_private_data(private_data, private_data_len);
-	if (IS_ERR(data))
-		return PTR_ERR(data);
+	int ret = 0;
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
 
@@ -3122,58 +3109,33 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 	case IB_CM_REQ_RCVD:
 		cm_state = IB_CM_MRA_REQ_SENT;
 		lap_state = cm_id->lap_state;
-		msg_response = CM_MSG_RESPONSE_REQ;
 		break;
 	case IB_CM_REP_RCVD:
 		cm_state = IB_CM_MRA_REP_SENT;
 		lap_state = cm_id->lap_state;
-		msg_response = CM_MSG_RESPONSE_REP;
 		break;
 	case IB_CM_ESTABLISHED:
 		if (cm_id->lap_state == IB_CM_LAP_RCVD) {
 			cm_state = cm_id->state;
 			lap_state = IB_CM_MRA_LAP_SENT;
-			msg_response = CM_MSG_RESPONSE_OTHER;
 			break;
 		}
 		fallthrough;
 	default:
-		trace_icm_send_mra_unknown_err(&cm_id_priv->id);
+		trace_icm_prepare_mra_unknown_err(&cm_id_priv->id);
 		ret = -EINVAL;
 		goto error_unlock;
 	}
 
-	if (!(service_timeout & IB_CM_MRA_FLAG_DELAY)) {
-		msg = cm_alloc_msg(cm_id_priv);
-		if (IS_ERR(msg)) {
-			ret = PTR_ERR(msg);
-			goto error_unlock;
-		}
-
-		cm_format_mra((struct cm_mra_msg *) msg->mad, cm_id_priv,
-			      msg_response, service_timeout,
-			      private_data, private_data_len);
-		trace_icm_send_mra(cm_id);
-		ret = ib_post_send_mad(msg, NULL);
-		if (ret)
-			goto error_free_msg;
-	}
-
 	cm_id->state = cm_state;
 	cm_id->lap_state = lap_state;
-	cm_id_priv->service_timeout = service_timeout;
-	cm_set_private_data(cm_id_priv, data, private_data_len);
-	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-	return 0;
+	cm_set_private_data(cm_id_priv, NULL, 0);
 
-error_free_msg:
-	cm_free_msg(msg);
 error_unlock:
 	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
-	kfree(data);
 	return ret;
 }
-EXPORT_SYMBOL(ib_send_cm_mra);
+EXPORT_SYMBOL(ib_prepare_cm_mra);
 
 static struct cm_id_private *cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
@@ -3377,7 +3339,6 @@ static int cm_lap_handler(struct cm_work *work)
 
 		cm_format_mra((struct cm_mra_msg *) msg->mad, cm_id_priv,
 			      CM_MSG_RESPONSE_OTHER,
-			      cm_id_priv->service_timeout,
 			      cm_id_priv->private_data,
 			      cm_id_priv->private_data_len);
 		spin_unlock_irq(&cm_id_priv->lock);
diff --git a/drivers/infiniband/core/cm_trace.h b/drivers/infiniband/core/cm_trace.h
index 944d9071245d2..4a4987da69d43 100644
--- a/drivers/infiniband/core/cm_trace.h
+++ b/drivers/infiniband/core/cm_trace.h
@@ -229,7 +229,7 @@ DEFINE_CM_ERR_EVENT(send_drep);
 DEFINE_CM_ERR_EVENT(dreq_unknown);
 DEFINE_CM_ERR_EVENT(send_unknown_rej);
 DEFINE_CM_ERR_EVENT(rej_unknown);
-DEFINE_CM_ERR_EVENT(send_mra_unknown);
+DEFINE_CM_ERR_EVENT(prepare_mra_unknown);
 DEFINE_CM_ERR_EVENT(mra_unknown);
 DEFINE_CM_ERR_EVENT(qp_init);
 DEFINE_CM_ERR_EVENT(qp_rtr);
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index cd7df623161d4..ccd0d9cf1dda9 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -46,7 +46,6 @@ MODULE_LICENSE("Dual BSD/GPL");
 
 #define CMA_CM_RESPONSE_TIMEOUT 20
 #define CMA_MAX_CM_RETRIES 15
-#define CMA_CM_MRA_SETTING (IB_CM_MRA_FLAG_DELAY | 24)
 #define CMA_IBOE_PACKET_LIFETIME 16
 #define CMA_PREFERRED_ROCE_GID_TYPE IB_GID_TYPE_ROCE_UDP_ENCAP
 
@@ -2198,8 +2197,8 @@ static int cma_ib_handler(struct ib_cm_id *cm_id,
 	case IB_CM_REP_RECEIVED:
 		if (state == RDMA_CM_CONNECT &&
 		    (id_priv->id.qp_type != IB_QPT_UD)) {
-			trace_cm_send_mra(id_priv);
-			ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
+			trace_cm_prepare_mra(id_priv);
+			ib_prepare_cm_mra(cm_id);
 		}
 		if (id_priv->id.qp) {
 			event.status = cma_rep_recv(id_priv);
@@ -2460,8 +2459,8 @@ static int cma_ib_req_handler(struct ib_cm_id *cm_id,
 
 	if (READ_ONCE(conn_id->state) == RDMA_CM_CONNECT &&
 	    conn_id->id.qp_type != IB_QPT_UD) {
-		trace_cm_send_mra(cm_id->context);
-		ib_send_cm_mra(cm_id, CMA_CM_MRA_SETTING, NULL, 0);
+		trace_cm_prepare_mra(cm_id->context);
+		ib_prepare_cm_mra(cm_id);
 	}
 	mutex_unlock(&conn_id->handler_mutex);
 
diff --git a/drivers/infiniband/core/cma_trace.h b/drivers/infiniband/core/cma_trace.h
index dc622f3778be2..3456d5f3aa47e 100644
--- a/drivers/infiniband/core/cma_trace.h
+++ b/drivers/infiniband/core/cma_trace.h
@@ -55,7 +55,7 @@ DECLARE_EVENT_CLASS(cma_fsm_class,
 
 DEFINE_CMA_FSM_EVENT(send_rtu);
 DEFINE_CMA_FSM_EVENT(send_rej);
-DEFINE_CMA_FSM_EVENT(send_mra);
+DEFINE_CMA_FSM_EVENT(prepare_mra);
 DEFINE_CMA_FSM_EVENT(send_sidr_req);
 DEFINE_CMA_FSM_EVENT(send_sidr_rep);
 DEFINE_CMA_FSM_EVENT(disconnect);
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index a2ac62b4a6cf1..1fa3786f82f42 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -480,23 +480,12 @@ int ib_send_cm_rej(struct ib_cm_id *cm_id,
 		   const void *private_data,
 		   u8 private_data_len);
 
-#define IB_CM_MRA_FLAG_DELAY 0x80  /* Send MRA only after a duplicate msg */
-
 /**
- * ib_send_cm_mra - Sends a message receipt acknowledgement to a connection
- *   message.
+ * ib_prepare_cm_mra - Prepares to send a message receipt acknowledgment to a
+     connection message in case duplicates are received.
  * @cm_id: Connection identifier associated with the connection message.
- * @service_timeout: The lower 5-bits specify the maximum time required for
- *   the sender to reply to the connection message.  The upper 3-bits
- *   specify additional control flags.
- * @private_data: Optional user-defined private data sent with the
- *   message receipt acknowledgement.
- * @private_data_len: Size of the private data buffer, in bytes.
  */
-int ib_send_cm_mra(struct ib_cm_id *cm_id,
-		   u8 service_timeout,
-		   const void *private_data,
-		   u8 private_data_len);
+int ib_prepare_cm_mra(struct ib_cm_id *cm_id);
 
 /**
  * ib_cm_init_qp_attr - Initializes the QP attributes for use in transitioning
-- 
2.49.0


