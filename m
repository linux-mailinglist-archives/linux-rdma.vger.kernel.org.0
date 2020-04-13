Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45AF61A67AE
	for <lists+linux-rdma@lfdr.de>; Mon, 13 Apr 2020 16:16:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730459AbgDMOQD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 13 Apr 2020 10:16:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730417AbgDMOQC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 13 Apr 2020 10:16:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5EA2D2075E;
        Mon, 13 Apr 2020 14:16:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586787361;
        bh=OcEEAqFy4hvucnebEdhOq7b22kx+wCeOMlgsFNobq1k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=1RuFhqlWB4red4qkVHwtFH9cnoriLQyC5y9aRiZz+XEuizuHDZjdwKRVkqzTQZ8vm
         bTG2GiQWax1BTSVRD9m05z5mFQDZgCU6stmkpy9XJ6UZBgBy7dtnHwjeZIROKBBdpI
         AfXweyy4ppOOLHR/GNS1Xb93zacxQAJShCDZQvIs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 5/7] RDMA/cm: Send and receive ECE parameter over the wire
Date:   Mon, 13 Apr 2020 17:15:36 +0300
Message-Id: <20200413141538.935574-6-leon@kernel.org>
X-Mailer: git-send-email 2.25.2
In-Reply-To: <20200413141538.935574-1-leon@kernel.org>
References: <20200413141538.935574-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

ECE parameters are exchanged through REQ->REP/SIDR_REP messages,
this patch adds the data to provide to other side of CMID communication
channel.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c   | 41 +++++++++++++++++++++++++++++-----
 drivers/infiniband/core/cma.c  |  8 +++++++
 drivers/infiniband/core/ucma.c |  1 -
 include/rdma/ib_cm.h           |  9 +++++++-
 4 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 68e1a9bba027..e77e01b03622 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -66,6 +66,8 @@ static const char * const ibcm_rej_reason_strs[] = {
 	[IB_CM_REJ_INVALID_CLASS_VERSION]	= "invalid class version",
 	[IB_CM_REJ_INVALID_FLOW_LABEL]		= "invalid flow label",
 	[IB_CM_REJ_INVALID_ALT_FLOW_LABEL]	= "invalid alt flow label",
+	[IB_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED] =
+		"vendor option is not supported",
 };
 
 const char *__attribute_const__ ibcm_reject_msg(int reason)
@@ -287,6 +289,8 @@ struct cm_id_private {
 
 	struct list_head work_list;
 	atomic_t work_count;
+
+	struct rdma_ucm_ece ece;
 };
 
 static void cm_work_handler(struct work_struct *work);
@@ -1287,6 +1291,13 @@ static void cm_format_mad_hdr(struct ib_mad_hdr *hdr,
 	hdr->tid	   = tid;
 }
 
+static void cm_format_mad_ece_hdr(struct ib_mad_hdr *hdr, __be16 attr_id,
+				  __be64 tid, u32 attr_mod)
+{
+	cm_format_mad_hdr(hdr, attr_id, tid);
+	hdr->attr_mod = cpu_to_be32(attr_mod);
+}
+
 static void cm_format_req(struct cm_req_msg *req_msg,
 			  struct cm_id_private *cm_id_priv,
 			  struct ib_cm_req_param *param)
@@ -1299,8 +1310,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		pri_ext = opa_is_extended_lid(pri_path->opa.dlid,
 					      pri_path->opa.slid);
 
-	cm_format_mad_hdr(&req_msg->hdr, CM_REQ_ATTR_ID,
-			  cm_form_tid(cm_id_priv));
+	cm_format_mad_ece_hdr(&req_msg->hdr, CM_REQ_ATTR_ID,
+			      cm_form_tid(cm_id_priv), param->ece.attr_mod);
 
 	IBA_SET(CM_REQ_LOCAL_COMM_ID, req_msg,
 		be32_to_cpu(cm_id_priv->id.local_id));
@@ -1423,6 +1434,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 				       alt_path->packet_life_time));
 	}
+	IBA_SET(CM_REQ_VENDOR_ID, req_msg, param->ece.vendor_id);
 
 	if (param->private_data && param->private_data_len)
 		IBA_SET_MEM(CM_REQ_PRIVATE_DATA, req_msg, param->private_data,
@@ -1779,6 +1791,9 @@ static void cm_format_req_event(struct cm_work *work,
 	param->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	param->srq = IBA_GET(CM_REQ_SRQ, req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
+	param->ece.vendor_id = IBA_GET(CM_REQ_VENDOR_ID, req_msg);
+	param->ece.attr_mod = be32_to_cpu(req_msg->hdr.attr_mod);
+
 	work->cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_REQ_PRIVATE_DATA, req_msg);
 }
@@ -2177,7 +2192,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 			  struct cm_id_private *cm_id_priv,
 			  struct ib_cm_rep_param *param)
 {
-	cm_format_mad_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid);
+	cm_format_mad_ece_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid,
+			      param->ece.attr_mod);
 	IBA_SET(CM_REP_LOCAL_COMM_ID, rep_msg,
 		be32_to_cpu(cm_id_priv->id.local_id));
 	IBA_SET(CM_REP_REMOTE_COMM_ID, rep_msg,
@@ -2204,6 +2220,12 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
+	IBA_SET(CM_REP_VENDOR_ID_L, rep_msg, param->ece.vendor_id & 0xFF);
+	IBA_SET(CM_REP_VENDOR_ID_M, rep_msg,
+		(param->ece.vendor_id >> 8) & 0xFF);
+	IBA_SET(CM_REP_VENDOR_ID_H, rep_msg,
+		(param->ece.vendor_id >> 16) & 0xFF);
+
 	if (param->private_data && param->private_data_len)
 		IBA_SET_MEM(CM_REP_PRIVATE_DATA, rep_msg, param->private_data,
 			    param->private_data_len);
@@ -2351,6 +2373,11 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->flow_control = IBA_GET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg);
 	param->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
 	param->srq = IBA_GET(CM_REP_SRQ, rep_msg);
+	param->ece.vendor_id = IBA_GET(CM_REP_VENDOR_ID_H, rep_msg) << 16;
+	param->ece.vendor_id |= IBA_GET(CM_REP_VENDOR_ID_M, rep_msg) << 8;
+	param->ece.vendor_id |= IBA_GET(CM_REP_VENDOR_ID_L, rep_msg);
+	param->ece.attr_mod = be32_to_cpu(rep_msg->hdr.attr_mod);
+
 	work->cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_REP_PRIVATE_DATA, rep_msg);
 }
@@ -3672,8 +3699,8 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 			       struct cm_id_private *cm_id_priv,
 			       struct ib_cm_sidr_rep_param *param)
 {
-	cm_format_mad_hdr(&sidr_rep_msg->hdr, CM_SIDR_REP_ATTR_ID,
-			  cm_id_priv->tid);
+	cm_format_mad_ece_hdr(&sidr_rep_msg->hdr, CM_SIDR_REP_ATTR_ID,
+			      cm_id_priv->tid, param->ece.attr_mod);
 	IBA_SET(CM_SIDR_REP_REQUESTID, sidr_rep_msg,
 		be32_to_cpu(cm_id_priv->id.remote_id));
 	IBA_SET(CM_SIDR_REP_STATUS, sidr_rep_msg, param->status);
@@ -3681,6 +3708,10 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 	IBA_SET(CM_SIDR_REP_SERVICEID, sidr_rep_msg,
 		be64_to_cpu(cm_id_priv->id.service_id));
 	IBA_SET(CM_SIDR_REP_Q_KEY, sidr_rep_msg, param->qkey);
+	IBA_SET(CM_SIDR_REP_VENDOR_ID_L, sidr_rep_msg,
+		param->ece.vendor_id & 0xFF);
+	IBA_SET(CM_SIDR_REP_VENDOR_ID_H, sidr_rep_msg,
+		(param->ece.vendor_id >> 8) & 0xFF);
 
 	if (param->info && param->info_length)
 		IBA_SET_MEM(CM_SIDR_REP_ADDITIONAL_INFORMATION, sidr_rep_msg,
diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 6ded5d3ecc1d..e33e47caab08 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1906,6 +1906,9 @@ static void cma_set_rep_event_data(struct rdma_cm_event *event,
 	event->param.conn.rnr_retry_count = rep_data->rnr_retry_count;
 	event->param.conn.srq = rep_data->srq;
 	event->param.conn.qp_num = rep_data->remote_qpn;
+
+	event->ece.vendor_id = rep_data->ece.vendor_id;
+	event->ece.attr_mod = rep_data->ece.attr_mod;
 }
 
 static int cma_cm_event_handler(struct rdma_id_private *id_priv,
@@ -2124,6 +2127,9 @@ static void cma_set_req_event_data(struct rdma_cm_event *event,
 	event->param.conn.rnr_retry_count = req_data->rnr_retry_count;
 	event->param.conn.srq = req_data->srq;
 	event->param.conn.qp_num = req_data->remote_qpn;
+
+	event->ece.vendor_id = req_data->ece.vendor_id;
+	event->ece.attr_mod = req_data->ece.attr_mod;
 }
 
 static int cma_ib_check_req_qp_type(const struct rdma_cm_id *id,
@@ -3942,6 +3948,8 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.local_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 	req.srq = id_priv->srq ? 1 : 0;
+	req.ece.vendor_id = id_priv->ece.vendor_id;
+	req.ece.attr_mod = id_priv->ece.attr_mod;
 
 	trace_cm_send_req(id_priv);
 	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
diff --git a/drivers/infiniband/core/ucma.c b/drivers/infiniband/core/ucma.c
index ed2c17046ee1..b67cdd2ef187 100644
--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -362,7 +362,6 @@ static int ucma_event_handler(struct rdma_cm_id *cm_id,
 
 	uevent->resp.ece.vendor_id = event->ece.vendor_id;
 	uevent->resp.ece.attr_mod = event->ece.attr_mod;
-
 	if (event->event == RDMA_CM_EVENT_CONNECT_REQUEST) {
 		if (!ctx->backlog) {
 			ret = -ENOMEM;
diff --git a/include/rdma/ib_cm.h b/include/rdma/ib_cm.h
index 058cfbc2b37f..0f1ea5f2d01c 100644
--- a/include/rdma/ib_cm.h
+++ b/include/rdma/ib_cm.h
@@ -11,6 +11,7 @@
 
 #include <rdma/ib_mad.h>
 #include <rdma/ib_sa.h>
+#include <rdma/rdma_cm.h>
 
 /* ib_cm and ib_user_cm modules share /sys/class/infiniband_cm */
 extern struct class cm_class;
@@ -115,6 +116,7 @@ struct ib_cm_req_event_param {
 	unsigned int		retry_count:3;
 	unsigned int		rnr_retry_count:3;
 	unsigned int		srq:1;
+	struct rdma_ucm_ece	ece;
 };
 
 struct ib_cm_rep_event_param {
@@ -129,6 +131,7 @@ struct ib_cm_rep_event_param {
 	unsigned int		flow_control:1;
 	unsigned int		rnr_retry_count:3;
 	unsigned int		srq:1;
+	struct rdma_ucm_ece	ece;
 };
 
 enum ib_cm_rej_reason {
@@ -164,7 +167,8 @@ enum ib_cm_rej_reason {
 	IB_CM_REJ_DUPLICATE_LOCAL_COMM_ID	= 30,
 	IB_CM_REJ_INVALID_CLASS_VERSION		= 31,
 	IB_CM_REJ_INVALID_FLOW_LABEL		= 32,
-	IB_CM_REJ_INVALID_ALT_FLOW_LABEL	= 33
+	IB_CM_REJ_INVALID_ALT_FLOW_LABEL	= 33,
+	IB_CM_REJ_VENDOR_OPTION_NOT_SUPPORTED	= 35,
 };
 
 struct ib_cm_rej_event_param {
@@ -369,6 +373,7 @@ struct ib_cm_req_param {
 	u8			rnr_retry_count;
 	u8			max_cm_retries;
 	u8			srq;
+	struct rdma_ucm_ece	ece;
 };
 
 /**
@@ -392,6 +397,7 @@ struct ib_cm_rep_param {
 	u8		flow_control;
 	u8		rnr_retry_count;
 	u8		srq;
+	struct rdma_ucm_ece ece;
 };
 
 /**
@@ -546,6 +552,7 @@ struct ib_cm_sidr_rep_param {
 	u8			info_length;
 	const void		*private_data;
 	u8			private_data_len;
+	struct rdma_ucm_ece	ece;
 };
 
 /**
-- 
2.25.2

