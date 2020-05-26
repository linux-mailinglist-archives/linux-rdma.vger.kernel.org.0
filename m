Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8F81E1FC1
	for <lists+linux-rdma@lfdr.de>; Tue, 26 May 2020 12:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731891AbgEZKdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 May 2020 06:33:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:50426 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731745AbgEZKda (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 May 2020 06:33:30 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09413207CB;
        Tue, 26 May 2020 10:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590489209;
        bh=DKm3MFs7Z13mLOrPE4c2peB9YGZzBuJrsj3q/MOJ4jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMbOT5USIgn+rW6o0qqfpAkPHr3pvbztJA6/hfBHygPgqwxZ0PURoqyh7qRXAk1MK
         0trzI7xni6B0Gq9YJaLSgZWY4zx+A7m0U6gdYPVJ45oUlnBqsNQpcPyRKcZGnvSmf5
         To2ybaEH0XPg6bDEroE/+t0perLK8/WAoi7MyUXU=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v3 4/6] RDMA/cm: Send and receive ECE parameter over the wire
Date:   Tue, 26 May 2020 13:33:02 +0300
Message-Id: <20200526103304.196371-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200526103304.196371-1-leon@kernel.org>
References: <20200526103304.196371-1-leon@kernel.org>
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
 drivers/infiniband/core/cm.c  | 39 ++++++++++++++++++++++++++++++-----
 drivers/infiniband/core/cma.c |  8 +++++++
 include/rdma/ib_cm.h          |  9 +++++++-
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index f38ff46abe8f..085c146fe400 100644
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
@@ -290,6 +292,8 @@ struct cm_id_private {
 
 	struct list_head work_list;
 	atomic_t work_count;
+
+	struct rdma_ucm_ece ece;
 };
 
 static void cm_work_handler(struct work_struct *work);
@@ -1318,6 +1322,13 @@ static void cm_format_mad_hdr(struct ib_mad_hdr *hdr,
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
@@ -1330,8 +1341,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		pri_ext = opa_is_extended_lid(pri_path->opa.dlid,
 					      pri_path->opa.slid);
 
-	cm_format_mad_hdr(&req_msg->hdr, CM_REQ_ATTR_ID,
-			  cm_form_tid(cm_id_priv));
+	cm_format_mad_ece_hdr(&req_msg->hdr, CM_REQ_ATTR_ID,
+			      cm_form_tid(cm_id_priv), param->ece.attr_mod);
 
 	IBA_SET(CM_REQ_LOCAL_COMM_ID, req_msg,
 		be32_to_cpu(cm_id_priv->id.local_id));
@@ -1454,6 +1465,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 				       alt_path->packet_life_time));
 	}
+	IBA_SET(CM_REQ_VENDOR_ID, req_msg, param->ece.vendor_id);
 
 	if (param->private_data && param->private_data_len)
 		IBA_SET_MEM(CM_REQ_PRIVATE_DATA, req_msg, param->private_data,
@@ -1810,6 +1822,9 @@ static void cm_format_req_event(struct cm_work *work,
 	param->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	param->srq = IBA_GET(CM_REQ_SRQ, req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
+	param->ece.vendor_id = IBA_GET(CM_REQ_VENDOR_ID, req_msg);
+	param->ece.attr_mod = be32_to_cpu(req_msg->hdr.attr_mod);
+
 	work->cm_event.private_data =
 		IBA_GET_MEM_PTR(CM_REQ_PRIVATE_DATA, req_msg);
 }
@@ -2202,7 +2217,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 			  struct cm_id_private *cm_id_priv,
 			  struct ib_cm_rep_param *param)
 {
-	cm_format_mad_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid);
+	cm_format_mad_ece_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid,
+			      param->ece.attr_mod);
 	IBA_SET(CM_REP_LOCAL_COMM_ID, rep_msg,
 		be32_to_cpu(cm_id_priv->id.local_id));
 	IBA_SET(CM_REP_REMOTE_COMM_ID, rep_msg,
@@ -2229,6 +2245,10 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
+	IBA_SET(CM_REP_VENDOR_ID_L, rep_msg, param->ece.vendor_id);
+	IBA_SET(CM_REP_VENDOR_ID_M, rep_msg, param->ece.vendor_id >> 8);
+	IBA_SET(CM_REP_VENDOR_ID_H, rep_msg, param->ece.vendor_id >> 16);
+
 	if (param->private_data && param->private_data_len)
 		IBA_SET_MEM(CM_REP_PRIVATE_DATA, rep_msg, param->private_data,
 			    param->private_data_len);
@@ -2376,6 +2396,11 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
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
@@ -3597,8 +3622,8 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
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
@@ -3606,6 +3631,10 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
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
index e81b8a523a3e..f554a371f4fa 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -1911,6 +1911,9 @@ static void cma_set_rep_event_data(struct rdma_cm_event *event,
 	event->param.conn.rnr_retry_count = rep_data->rnr_retry_count;
 	event->param.conn.srq = rep_data->srq;
 	event->param.conn.qp_num = rep_data->remote_qpn;
+
+	event->ece.vendor_id = rep_data->ece.vendor_id;
+	event->ece.attr_mod = rep_data->ece.attr_mod;
 }
 
 static int cma_cm_event_handler(struct rdma_id_private *id_priv,
@@ -2129,6 +2132,9 @@ static void cma_set_req_event_data(struct rdma_cm_event *event,
 	event->param.conn.rnr_retry_count = req_data->rnr_retry_count;
 	event->param.conn.srq = req_data->srq;
 	event->param.conn.qp_num = req_data->remote_qpn;
+
+	event->ece.vendor_id = req_data->ece.vendor_id;
+	event->ece.attr_mod = req_data->ece.attr_mod;
 }
 
 static int cma_ib_check_req_qp_type(const struct rdma_cm_id *id,
@@ -3947,6 +3953,8 @@ static int cma_connect_ib(struct rdma_id_private *id_priv,
 	req.local_cm_response_timeout = CMA_CM_RESPONSE_TIMEOUT;
 	req.max_cm_retries = CMA_MAX_CM_RETRIES;
 	req.srq = id_priv->srq ? 1 : 0;
+	req.ece.vendor_id = id_priv->ece.vendor_id;
+	req.ece.attr_mod = id_priv->ece.attr_mod;
 
 	trace_cm_send_req(id_priv);
 	ret = ib_send_cm_req(id_priv->cm_id.ib, &req);
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
2.26.2

