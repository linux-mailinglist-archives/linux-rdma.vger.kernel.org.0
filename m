Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B79821B7CB
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2020 16:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbgGJOGW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 10 Jul 2020 10:06:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgGJOGV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 10 Jul 2020 10:06:21 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63DAC08C5CE
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:21 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id k18so5290415qke.4
        for <linux-rdma@vger.kernel.org>; Fri, 10 Jul 2020 07:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=FQYpE1RdJ9wTQ7/M8VnwE4tdVGTrEf1gN+g4JwpkDQM=;
        b=AqUIRyPhN/afDHWv0EvUPHZIRIfZ382ziLoe+bIYfoKKkruzwp9qDvsiF3I5GLnPgx
         gP4KetwCtBoL15AufGqF69QhDxcIgF47cUQz3l7rosQt+Y2GmKFB8BlnifPiF4UDKndC
         jfL5qtjTWph7FivueFUE6IKY6NlG+8XNfCmGjR3zkncLKrsxrrX2+k9kyXcaAyue31jI
         xz5oKNNVkUo1TVwpSpXEl0HMq5qReqEJGFNBsqselHNKB4d0YFHBzkWYcPcgbVxSyd8W
         3obDbjVfNYEQFatIi6/qf4qBd/ebefiOGFXSx7zxC3EeUjnl7vueOaAX55nSJs7h3g6p
         OkTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:cc:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=FQYpE1RdJ9wTQ7/M8VnwE4tdVGTrEf1gN+g4JwpkDQM=;
        b=nZdEVD8J122AAlWgr6IIIyiEzm42fdxCoLyi7Qv6STyI4tSfIbiM0sNQ2h+IAbbNdH
         eWIps5golNOcwwCAbB0ghuLzCtJMs6o8XlDQ2h8P8PBR1CSYJmFi/saX560hqOi+kHts
         pwCbe8t+Be7PCmI2U65kn49eFgaTQPTD+yzCx9cOfBWxVpaRT4uh1yFIT9HnbzXn2xhL
         d6arq7VjGmKWhHq4m5+j/Hf5vILKxTIc8+rnO1s8kMXmPJmqWodoC59oLNYJ93Q5jVFA
         djgvv3TetiwD1IpmwuFpRX0PujBXQRKuv/zWjiVhHWh/3NujH86QNev+nTxyH44xBikC
         8VWQ==
X-Gm-Message-State: AOAM5339Bp9He/OMWbXiAQp8S9nOB2EQF2snjlAZ1zCgylQBa8L/Y1Gk
        ap2Jf5X9tReL2jEuzETxS4g=
X-Google-Smtp-Source: ABdhPJzhAQGjfwGzRgoeZeRbznWLZr3wpvShqpnJep136Ia+9UV3kJ8oA3BwNY5Ds5MNqd8i6bC7Qw==
X-Received: by 2002:a37:27d6:: with SMTP id n205mr69609435qkn.379.1594389979419;
        Fri, 10 Jul 2020 07:06:19 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id w18sm7529461qtn.3.2020.07.10.07.06.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jul 2020 07:06:19 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06AE6Isp012323;
        Fri, 10 Jul 2020 14:06:18 GMT
Subject: [PATCH RFC 3/3] RDMA/cm: Add tracepoints to track MAD send
 operations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Cc:     aron.silverton@oracle.com
Date:   Fri, 10 Jul 2020 10:06:18 -0400
Message-ID: <20200710140618.14749.34935.stgit@klimt.1015granger.net>
In-Reply-To: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
References: <20200710135812.14749.4630.stgit@klimt.1015granger.net>
User-Agent: StGit/0.22-31-g4b47
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Surface the operation of MAD exchanges during connection
establishment. Some samples:

[root@klimt ~]# trace-cmd report -F ib_cma
cpus=4
     kworker/0:4-123   [000]    60.677388: cm_send_rep:          local_id=1965336542 remote_id=1096195961 state=REQ_RCVD lap_state=LAP_UNINIT
   kworker/u8:11-391   [002]    60.678808: cm_send_req:          local_id=1982113758 remote_id=0 state=IDLE lap_state=LAP_UNINIT
     kworker/0:4-123   [000]    60.679652: cm_send_rtu:          local_id=1982113758 remote_id=1079418745 state=REP_RCVD lap_state=LAP_UNINIT
            nfsd-1954  [001]    60.691350: cm_send_rep:          local_id=1998890974 remote_id=1129750393 state=MRA_REQ_SENT lap_state=LAP_UNINIT
            nfsd-1954  [003]    62.017931: cm_send_drep:         local_id=1998890974 remote_id=1129750393 state=TIMEWAIT lap_state=LAP_UNINIT

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cm.c       |   22 +++++++-
 drivers/infiniband/core/cm_trace.h |  105 ++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 8dd8039e1a02..ace3835da0cd 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1564,6 +1564,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->local_qpn = cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
 	cm_id_priv->rq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
 
+	trace_cm_send_req(&cm_id_priv->id);
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
 	if (ret) {
@@ -1611,6 +1612,9 @@ static int cm_issue_rej(struct cm_port *port,
 		IBA_SET_MEM(CM_REJ_ARI, rej_msg, ari, ari_length);
 	}
 
+	trace_cm_issue_rej(
+		IBA_GET(CM_REJ_LOCAL_COMM_ID, rcv_msg),
+		IBA_GET(CM_REJ_REMOTE_COMM_ID, rcv_msg));
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		cm_free_msg(msg);
@@ -1962,6 +1966,7 @@ static void cm_dup_req_handler(struct cm_work *work,
 	}
 	spin_unlock_irq(&cm_id_priv->lock);
 
+	trace_cm_send_dup_req(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		goto free;
@@ -2288,6 +2293,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	msg->timeout_ms = cm_id_priv->timeout_ms;
 	msg->context[1] = (void *) (unsigned long) IB_CM_REP_SENT;
 
+	trace_cm_send_rep(cm_id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -2359,6 +2365,7 @@ int ib_send_cm_rtu(struct ib_cm_id *cm_id,
 	cm_format_rtu((struct cm_rtu_msg *) msg->mad, cm_id_priv,
 		      private_data, private_data_len);
 
+	trace_cm_send_rtu(cm_id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -2440,6 +2447,7 @@ static void cm_dup_rep_handler(struct cm_work *work)
 		goto unlock;
 	spin_unlock_irq(&cm_id_priv->lock);
 
+	trace_cm_send_dup_rep(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		goto free;
@@ -2661,6 +2669,7 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 	msg->timeout_ms = cm_id_priv->timeout_ms;
 	msg->context[1] = (void *) (unsigned long) IB_CM_DREQ_SENT;
 
+	trace_cm_send_dreq(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_enter_timewait(cm_id_priv);
@@ -2731,6 +2740,7 @@ static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
 	cm_format_drep((struct cm_drep_msg *) msg->mad, cm_id_priv,
 		       private_data, private_data_len);
 
+	trace_cm_send_drep(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
@@ -2780,6 +2790,9 @@ static int cm_issue_drep(struct cm_port *port,
 	IBA_SET(CM_DREP_LOCAL_COMM_ID, drep_msg,
 		IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 
+	trace_cm_issue_drep(
+		IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
+		IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		cm_free_msg(msg);
@@ -2937,6 +2950,7 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 	}
 
+	trace_cm_send_rej(&cm_id_priv->id, reason);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
@@ -3115,6 +3129,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 		cm_format_mra((struct cm_mra_msg *) msg->mad, cm_id_priv,
 			      msg_response, service_timeout,
 			      private_data, private_data_len);
+		trace_cm_send_mra(cm_id);
 		ret = ib_post_send_mad(msg, NULL);
 		if (ret)
 			goto error2;
@@ -3485,10 +3500,12 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 	msg->context[1] = (void *) (unsigned long) IB_CM_SIDR_REQ_SENT;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id->state == IB_CM_IDLE)
+	if (cm_id->state == IB_CM_IDLE) {
+		trace_cm_send_sidr_req(&cm_id_priv->id);
 		ret = ib_post_send_mad(msg, NULL);
-	else
+	} else {
 		ret = -EINVAL;
+	}
 
 	if (ret) {
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -3650,6 +3667,7 @@ static int cm_send_sidr_rep_locked(struct cm_id_private *cm_id_priv,
 
 	cm_format_sidr_rep((struct cm_sidr_rep_msg *) msg->mad, cm_id_priv,
 			   param);
+	trace_cm_send_sidr_rep(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
diff --git a/drivers/infiniband/core/cm_trace.h b/drivers/infiniband/core/cm_trace.h
index 84f65f597e34..100e38a3d489 100644
--- a/drivers/infiniband/core/cm_trace.h
+++ b/drivers/infiniband/core/cm_trace.h
@@ -80,6 +80,59 @@ IB_CM_LAP_STATE_LIST
 #define show_ib_cm_lap_state(x) \
 		__print_symbolic(x, IB_CM_LAP_STATE_LIST)
 
+/*
+ * enum ib_cm_rej_reason, from include/rdma/ib_cm.h
+ */
+#define IB_CM_REJ_REASON_LIST					\
+	ib_cm_rej_reason(REJ_NO_QP)				\
+	ib_cm_rej_reason(REJ_NO_EEC)				\
+	ib_cm_rej_reason(REJ_NO_RESOURCES)			\
+	ib_cm_rej_reason(REJ_TIMEOUT)				\
+	ib_cm_rej_reason(REJ_UNSUPPORTED)			\
+	ib_cm_rej_reason(REJ_INVALID_COMM_ID)			\
+	ib_cm_rej_reason(REJ_INVALID_COMM_INSTANCE)		\
+	ib_cm_rej_reason(REJ_INVALID_SERVICE_ID)		\
+	ib_cm_rej_reason(REJ_INVALID_TRANSPORT_TYPE)		\
+	ib_cm_rej_reason(REJ_STALE_CONN)			\
+	ib_cm_rej_reason(REJ_RDC_NOT_EXIST)			\
+	ib_cm_rej_reason(REJ_INVALID_GID)			\
+	ib_cm_rej_reason(REJ_INVALID_LID)			\
+	ib_cm_rej_reason(REJ_INVALID_SL)			\
+	ib_cm_rej_reason(REJ_INVALID_TRAFFIC_CLASS)		\
+	ib_cm_rej_reason(REJ_INVALID_HOP_LIMIT)			\
+	ib_cm_rej_reason(REJ_INVALID_PACKET_RATE)		\
+	ib_cm_rej_reason(REJ_INVALID_ALT_GID)			\
+	ib_cm_rej_reason(REJ_INVALID_ALT_LID)			\
+	ib_cm_rej_reason(REJ_INVALID_ALT_SL)			\
+	ib_cm_rej_reason(REJ_INVALID_ALT_TRAFFIC_CLASS)		\
+	ib_cm_rej_reason(REJ_INVALID_ALT_HOP_LIMIT)		\
+	ib_cm_rej_reason(REJ_INVALID_ALT_PACKET_RATE)		\
+	ib_cm_rej_reason(REJ_PORT_CM_REDIRECT)			\
+	ib_cm_rej_reason(REJ_PORT_REDIRECT)			\
+	ib_cm_rej_reason(REJ_INVALID_MTU)			\
+	ib_cm_rej_reason(REJ_INSUFFICIENT_RESP_RESOURCES)	\
+	ib_cm_rej_reason(REJ_CONSUMER_DEFINED)			\
+	ib_cm_rej_reason(REJ_INVALID_RNR_RETRY)			\
+	ib_cm_rej_reason(REJ_DUPLICATE_LOCAL_COMM_ID)		\
+	ib_cm_rej_reason(REJ_INVALID_CLASS_VERSION)		\
+	ib_cm_rej_reason(REJ_INVALID_FLOW_LABEL)		\
+	ib_cm_rej_reason(REJ_INVALID_ALT_FLOW_LABEL)		\
+	ib_cm_rej_reason_end(REJ_VENDOR_OPTION_NOT_SUPPORTED)
+
+#undef  ib_cm_rej_reason
+#undef  ib_cm_rej_reason_end
+#define ib_cm_rej_reason(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
+#define ib_cm_rej_reason_end(x)	TRACE_DEFINE_ENUM(IB_CM_##x);
+
+IB_CM_REJ_REASON_LIST
+
+#undef  ib_cm_rej_reason
+#undef  ib_cm_rej_reason_end
+#define ib_cm_rej_reason(x)	{ IB_CM_##x, #x },
+#define ib_cm_rej_reason_end(x)	{ IB_CM_##x, #x }
+
+#define show_ib_cm_rej_reason(x) \
+		__print_symbolic(x, IB_CM_REJ_REASON_LIST)
 
 DECLARE_EVENT_CLASS(cm_id_class,
 	TP_PROTO(
@@ -111,6 +164,56 @@ DECLARE_EVENT_CLASS(cm_id_class,
 	)
 );
 
+#define DEFINE_CM_SEND_EVENT(name)					\
+		DEFINE_EVENT(cm_id_class,				\
+				cm_send_##name,				\
+				TP_PROTO(				\
+					const struct ib_cm_id *cm_id	\
+				),					\
+				TP_ARGS(cm_id))
+
+DEFINE_CM_SEND_EVENT(req);
+DEFINE_CM_SEND_EVENT(rep);
+DEFINE_CM_SEND_EVENT(dup_req);
+DEFINE_CM_SEND_EVENT(dup_rep);
+DEFINE_CM_SEND_EVENT(rtu);
+DEFINE_CM_SEND_EVENT(mra);
+DEFINE_CM_SEND_EVENT(sidr_req);
+DEFINE_CM_SEND_EVENT(sidr_rep);
+DEFINE_CM_SEND_EVENT(dreq);
+DEFINE_CM_SEND_EVENT(drep);
+
+TRACE_EVENT(cm_send_rej,
+	TP_PROTO(
+		const struct ib_cm_id *cm_id,
+		enum ib_cm_rej_reason reason
+	),
+
+	TP_ARGS(cm_id, reason),
+
+	TP_STRUCT__entry(
+		__field(const void *, cm_id)
+		__field(u32, local_id)
+		__field(u32, remote_id)
+		__field(unsigned long, state)
+		__field(unsigned long, reason)
+	),
+
+	TP_fast_assign(
+		__entry->cm_id = cm_id;
+		__entry->local_id = be32_to_cpu(cm_id->local_id);
+		__entry->remote_id = be32_to_cpu(cm_id->remote_id);
+		__entry->state = cm_id->state;
+		__entry->reason = reason;
+	),
+
+	TP_printk("local_id=%u remote_id=%u state=%s reason=%s",
+		__entry->local_id, __entry->remote_id,
+		show_ib_cm_state(__entry->state),
+		show_ib_cm_rej_reason(__entry->reason)
+	)
+);
+
 #define DEFINE_CM_ERR_EVENT(name)					\
 		DEFINE_EVENT(cm_id_class,				\
 				cm_##name##_err,			\
@@ -172,6 +275,8 @@ DECLARE_EVENT_CLASS(cm_local_class,
 				),					\
 				TP_ARGS(local_id, remote_id))
 
+DEFINE_CM_LOCAL_EVENT(issue_rej);
+DEFINE_CM_LOCAL_EVENT(issue_drep);
 DEFINE_CM_LOCAL_EVENT(staleconn_err);
 DEFINE_CM_LOCAL_EVENT(no_priv_err);
 

