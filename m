Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DDF226D02
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jul 2020 19:16:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgGTRQt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jul 2020 13:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728889AbgGTRQt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jul 2020 13:16:49 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CE7C061794
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 10:16:48 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id l1so18386035ioh.5
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 10:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:from:to:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lCyII0F51hnKlf7NXSS5UPK1T1I96shE9TpKfi/cVVU=;
        b=ARnfDu0Pv/htwRYEXbupxeZpG44wRUGR4OWwJlCBxb/yrNpBId6ITqHKxXHZw/5YvB
         KNwYHnlCnr/n6kRYh4DvrJZj5o8G7bFqZ5FJy3PX3JBSeRFQlRCIeNxTru21YNaK0+FQ
         SJr5XZId1I0/IyVTsW+9OdslPtQ9nehTs5gnbiVtFxg8Vo+a1esRtiAhCVULTzKocZZR
         XCiTwvciLRtxq3K+DkZYwLCHQzDSEibULwk+HahuUBKJBsCld4/8S4hfSp9l/uhnkMAR
         kFMwurcO8gqz13htJBbotOQz0Jd2EGYNZaucpQ2z/0TsgU4AZt44rcgLsjHR2ieiNNG2
         erRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:from:to:date:message-id
         :in-reply-to:references:user-agent:mime-version
         :content-transfer-encoding;
        bh=lCyII0F51hnKlf7NXSS5UPK1T1I96shE9TpKfi/cVVU=;
        b=tjaM7x/lnB8bPMtZHVAFuGS9voo8J3wN2rHO0cbJifrwIQwshOjd9SY8jcMdNRIYKh
         XTQL2KMitI7Usp+9Wd+1gQXjeX5U2vVwi4xJmLcM11Pbhz+qRFuNbjazqi7tlPEPHWVx
         LWnobbKrfSXLK+V8VOx3T6oxF6IaHGos5YONxIzG3u1oemtKempaMuVqMIQUcC4J6ROu
         5dFTLJqKAu9Eko0NlvVQGzK4KVSpDIGjz5H3j4/vBpoKuttAkx29j8ilgyzUDQlTOtmv
         HXKH0DSRiq5T+0c1kcpWBXXl3nHcUxMGHUyidAo1njlqEkwD/thyhW/DH0w3cnOvTRk2
         kyoQ==
X-Gm-Message-State: AOAM533kIq3uiX+z7bJ9pTm/5DabMIp9AnaOCVQm0880NW16lEhuLpoB
        PDvAhR9otG3JMi407Yn2mGgnk1Ti
X-Google-Smtp-Source: ABdhPJwtjtW8tGp3ZYYp8nN7VDX9UVnhuJNsK5baKJMBeaM7pVfuskxfrtq3rAZG4EL/0IDHRvDypA==
X-Received: by 2002:a02:a78f:: with SMTP id e15mr26331115jaj.36.1595265408059;
        Mon, 20 Jul 2020 10:16:48 -0700 (PDT)
Received: from gateway.1015granger.net (c-68-61-232-219.hsd1.mi.comcast.net. [68.61.232.219])
        by smtp.gmail.com with ESMTPSA id a13sm9082796ilk.19.2020.07.20.10.16.47
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Jul 2020 10:16:47 -0700 (PDT)
Received: from klimt.1015granger.net (klimt.1015granger.net [192.168.1.55])
        by gateway.1015granger.net (8.14.7/8.14.7) with ESMTP id 06KHGkdj023984
        for <linux-rdma@vger.kernel.org>; Mon, 20 Jul 2020 17:16:46 GMT
Subject: [PATCH v2 3/3] RDMA/cm: Add tracepoints to track MAD send operations
From:   Chuck Lever <chuck.lever@oracle.com>
To:     linux-rdma@vger.kernel.org
Date:   Mon, 20 Jul 2020 13:16:46 -0400
Message-ID: <159526540662.1543.16409462782607487395.stgit@klimt.1015granger.net>
In-Reply-To: <159526519212.1543.15414933891659731269.stgit@klimt.1015granger.net>
References: <159526519212.1543.15414933891659731269.stgit@klimt.1015granger.net>
User-Agent: StGit/0.23
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
     kworker/0:4-123   [000]    60.677388: icm_send_rep:         local_id=1965336542 remote_id=1096195961 state=REQ_RCVD lap_state=LAP_UNINIT
   kworker/u8:11-391   [002]    60.678808: icm_send_req:         local_id=1982113758 remote_id=0 state=IDLE lap_state=LAP_UNINIT
     kworker/0:4-123   [000]    60.679652: icm_send_rtu:         local_id=1982113758 remote_id=1079418745 state=REP_RCVD lap_state=LAP_UNINIT
            nfsd-1954  [001]    60.691350: icm_send_rep:         local_id=1998890974 remote_id=1129750393 state=MRA_REQ_SENT lap_state=LAP_UNINIT
            nfsd-1954  [003]    62.017931: icm_send_drep:        local_id=1998890974 remote_id=1129750393 state=TIMEWAIT lap_state=LAP_UNINIT

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 drivers/infiniband/core/cm.c       |   22 +++++++-
 drivers/infiniband/core/cm_trace.h |  105 ++++++++++++++++++++++++++++++++++++
 2 files changed, 125 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 78554e679297..43b32f5ce3da 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1564,6 +1564,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->local_qpn = cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
 	cm_id_priv->rq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
 
+	trace_icm_send_req(&cm_id_priv->id);
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
 	if (ret) {
@@ -1611,6 +1612,9 @@ static int cm_issue_rej(struct cm_port *port,
 		IBA_SET_MEM(CM_REJ_ARI, rej_msg, ari, ari_length);
 	}
 
+	trace_icm_issue_rej(
+		IBA_GET(CM_REJ_LOCAL_COMM_ID, rcv_msg),
+		IBA_GET(CM_REJ_REMOTE_COMM_ID, rcv_msg));
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		cm_free_msg(msg);
@@ -1962,6 +1966,7 @@ static void cm_dup_req_handler(struct cm_work *work,
 	}
 	spin_unlock_irq(&cm_id_priv->lock);
 
+	trace_icm_send_dup_req(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		goto free;
@@ -2288,6 +2293,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	msg->timeout_ms = cm_id_priv->timeout_ms;
 	msg->context[1] = (void *) (unsigned long) IB_CM_REP_SENT;
 
+	trace_icm_send_rep(cm_id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -2359,6 +2365,7 @@ int ib_send_cm_rtu(struct ib_cm_id *cm_id,
 	cm_format_rtu((struct cm_rtu_msg *) msg->mad, cm_id_priv,
 		      private_data, private_data_len);
 
+	trace_icm_send_rtu(cm_id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -2440,6 +2447,7 @@ static void cm_dup_rep_handler(struct cm_work *work)
 		goto unlock;
 	spin_unlock_irq(&cm_id_priv->lock);
 
+	trace_icm_send_dup_rep(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		goto free;
@@ -2661,6 +2669,7 @@ static int cm_send_dreq_locked(struct cm_id_private *cm_id_priv,
 	msg->timeout_ms = cm_id_priv->timeout_ms;
 	msg->context[1] = (void *) (unsigned long) IB_CM_DREQ_SENT;
 
+	trace_icm_send_dreq(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_enter_timewait(cm_id_priv);
@@ -2731,6 +2740,7 @@ static int cm_send_drep_locked(struct cm_id_private *cm_id_priv,
 	cm_format_drep((struct cm_drep_msg *) msg->mad, cm_id_priv,
 		       private_data, private_data_len);
 
+	trace_icm_send_drep(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
@@ -2780,6 +2790,9 @@ static int cm_issue_drep(struct cm_port *port,
 	IBA_SET(CM_DREP_LOCAL_COMM_ID, drep_msg,
 		IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 
+	trace_icm_issue_drep(
+		IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
+		IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
 		cm_free_msg(msg);
@@ -2937,6 +2950,7 @@ static int cm_send_rej_locked(struct cm_id_private *cm_id_priv,
 		return -EINVAL;
 	}
 
+	trace_icm_send_rej(&cm_id_priv->id, reason);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
@@ -3115,6 +3129,7 @@ int ib_send_cm_mra(struct ib_cm_id *cm_id,
 		cm_format_mra((struct cm_mra_msg *) msg->mad, cm_id_priv,
 			      msg_response, service_timeout,
 			      private_data, private_data_len);
+		trace_icm_send_mra(cm_id);
 		ret = ib_post_send_mad(msg, NULL);
 		if (ret)
 			goto error2;
@@ -3485,10 +3500,12 @@ int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
 	msg->context[1] = (void *) (unsigned long) IB_CM_SIDR_REQ_SENT;
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
-	if (cm_id->state == IB_CM_IDLE)
+	if (cm_id->state == IB_CM_IDLE) {
+		trace_icm_send_sidr_req(&cm_id_priv->id);
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
+	trace_icm_send_sidr_rep(&cm_id_priv->id);
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret) {
 		cm_free_msg(msg);
diff --git a/drivers/infiniband/core/cm_trace.h b/drivers/infiniband/core/cm_trace.h
index c69e28564913..8e53982f9250 100644
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
 
 DECLARE_EVENT_CLASS(icm_id_class,
 	TP_PROTO(
@@ -111,6 +164,56 @@ DECLARE_EVENT_CLASS(icm_id_class,
 	)
 );
 
+#define DEFINE_CM_SEND_EVENT(name)					\
+		DEFINE_EVENT(icm_id_class,				\
+				icm_send_##name,				\
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
+TRACE_EVENT(icm_send_rej,
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
 		DEFINE_EVENT(icm_id_class,				\
 				icm_##name##_err,			\
@@ -172,6 +275,8 @@ DECLARE_EVENT_CLASS(icm_local_class,
 				),					\
 				TP_ARGS(local_id, remote_id))
 
+DEFINE_CM_LOCAL_EVENT(issue_rej);
+DEFINE_CM_LOCAL_EVENT(issue_drep);
 DEFINE_CM_LOCAL_EVENT(staleconn_err);
 DEFINE_CM_LOCAL_EVENT(no_priv_err);
 


