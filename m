Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C23F5E6140
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJ0HHL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:34922 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHL (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:11 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0031B20578;
        Sun, 27 Oct 2019 07:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160029;
        bh=Poi+QHQSGc4SYHTbmKC7/QE9bpNIJ7TALeKGkpv1Lhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=I52phZ3qBxTUzo1sYO6lSlhrPa7aA1g73StFyqOZ7nOKQ3Mp3YVzaZ2PqxAz1pukw
         GmCJFGMmtuJJqoHwMCaXmJyrr1gYybAkV1sd4dVI/yZsr1ne9AvubL6wAh3l4WpE8f
         lpgExaqodmstbKPtkAAHnMoX3e+gJ30HCCWunLVQ=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 13/43] RDMA/cm: Convert QPN and EECN to be u32 variables
Date:   Sun, 27 Oct 2019 09:05:51 +0200
Message-Id: <20191027070621.11711-14-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191027070621.11711-1-leon@kernel.org>
References: <20191027070621.11711-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Remove unnecessary ambiguity in mixing be32<->u32 declarations
of QPN and EECN, convert them from be32 to u32 with help
of newly introduced CM_GET/CM_SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 55 ++++++++++++++++----------
 drivers/infiniband/core/cm_msgs.h | 64 +------------------------------
 2 files changed, 35 insertions(+), 84 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index d07a5f141720..81a67805b029 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -225,7 +225,7 @@ struct cm_timewait_info {
 	struct rb_node remote_qp_node;
 	struct rb_node remote_id_node;
 	__be64 remote_ca_guid;
-	__be32 remote_qpn;
+	u32 remote_qpn;
 	u8 inserted_remote_qp;
 	u8 inserted_remote_id;
 };
@@ -250,8 +250,8 @@ struct cm_id_private {
 
 	void *private_data;
 	__be64 tid;
-	__be32 local_qpn;
-	__be32 remote_qpn;
+	u32 local_qpn;
+	u32 remote_qpn;
 	enum ib_qp_type qp_type;
 	__be32 sq_psn;
 	__be32 rq_psn;
@@ -764,15 +764,15 @@ static struct cm_timewait_info * cm_insert_remote_qpn(struct cm_timewait_info
 	struct rb_node *parent = NULL;
 	struct cm_timewait_info *cur_timewait_info;
 	__be64 remote_ca_guid = timewait_info->remote_ca_guid;
-	__be32 remote_qpn = timewait_info->remote_qpn;
+	u32 remote_qpn = timewait_info->remote_qpn;
 
 	while (*link) {
 		parent = *link;
 		cur_timewait_info = rb_entry(parent, struct cm_timewait_info,
 					     remote_qp_node);
-		if (be32_lt(remote_qpn, cur_timewait_info->remote_qpn))
+		if (remote_qpn < cur_timewait_info->remote_qpn)
 			link = &(*link)->rb_left;
-		else if (be32_gt(remote_qpn, cur_timewait_info->remote_qpn))
+		else if (remote_qpn > cur_timewait_info->remote_qpn)
 			link = &(*link)->rb_right;
 		else if (be64_lt(remote_ca_guid, cur_timewait_info->remote_ca_guid))
 			link = &(*link)->rb_left;
@@ -1265,7 +1265,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->local_comm_id = cm_id_priv->id.local_id;
 	req_msg->service_id = param->service_id;
 	req_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
-	cm_req_set_local_qpn(req_msg, cpu_to_be32(param->qp_num));
+	CM_SET(REQ_LOCAL_QPN, req_msg, param->qp_num);
 	cm_req_set_init_depth(req_msg, param->initiator_depth);
 	cm_req_set_remote_resp_timeout(req_msg,
 				       param->remote_cm_response_timeout);
@@ -1443,7 +1443,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->msg->timeout_ms = cm_id_priv->timeout_ms;
 	cm_id_priv->msg->context[1] = (void *) (unsigned long) IB_CM_REQ_SENT;
 
-	cm_id_priv->local_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->local_qpn = CM_GET(REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->rq_psn = cm_req_get_starting_psn(req_msg);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
@@ -1666,7 +1666,7 @@ static void cm_format_req_event(struct cm_work *work,
 	}
 	param->remote_ca_guid = req_msg->local_ca_guid;
 	param->remote_qkey = be32_to_cpu(req_msg->local_qkey);
-	param->remote_qpn = be32_to_cpu(cm_req_get_local_qpn(req_msg));
+	param->remote_qpn = CM_GET(REP_LOCAL_QPN, req_msg);
 	param->qp_type = cm_req_get_qp_type(req_msg);
 	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
 	param->responder_resources = cm_req_get_init_depth(req_msg);
@@ -1929,7 +1929,7 @@ static int cm_req_handler(struct cm_work *work)
 	}
 	cm_id_priv->timewait_info->work.remote_id = req_msg->local_comm_id;
 	cm_id_priv->timewait_info->remote_ca_guid = req_msg->local_ca_guid;
-	cm_id_priv->timewait_info->remote_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->timewait_info->remote_qpn = CM_GET(REQ_LOCAL_QPN, req_msg);
 
 	listen_cm_id_priv = cm_match_req(work, cm_id_priv);
 	if (!listen_cm_id_priv) {
@@ -2003,7 +2003,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
 					cm_req_get_local_resp_timeout(req_msg));
 	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
-	cm_id_priv->remote_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->remote_qpn = CM_GET(REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->initiator_depth = cm_req_get_resp_res(req_msg);
 	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
@@ -2047,10 +2047,10 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		rep_msg->initiator_depth = param->initiator_depth;
 		cm_rep_set_flow_ctrl(rep_msg, param->flow_control);
 		cm_rep_set_srq(rep_msg, param->srq);
-		cm_rep_set_local_qpn(rep_msg, cpu_to_be32(param->qp_num));
+		CM_SET(REP_LOCAL_QPN, rep_msg, param->qp_num);
 	} else {
 		cm_rep_set_srq(rep_msg, 1);
-		cm_rep_set_local_eecn(rep_msg, cpu_to_be32(param->qp_num));
+		CM_SET(REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
 	if (param->private_data && param->private_data_len)
@@ -2102,7 +2102,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	cm_id_priv->initiator_depth = param->initiator_depth;
 	cm_id_priv->responder_resources = param->responder_resources;
 	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
-	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num);
+	cm_id_priv->local_qpn = param->qp_num;
 
 out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
@@ -2184,7 +2184,11 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param = &work->cm_event.param.rep_rcvd;
 	param->remote_ca_guid = rep_msg->local_ca_guid;
 	param->remote_qkey = be32_to_cpu(rep_msg->local_qkey);
-	param->remote_qpn = be32_to_cpu(cm_rep_get_qpn(rep_msg, qp_type));
+	if (qp_type == IB_QPT_XRC_INI)
+		param->remote_qpn =
+			CM_GET(REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
+	else
+		param->remote_qpn = CM_GET(REP_LOCAL_QPN, rep_msg);
 	param->starting_psn = be32_to_cpu(cm_rep_get_starting_psn(rep_msg));
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
@@ -2277,7 +2281,12 @@ static int cm_rep_handler(struct cm_work *work)
 
 	cm_id_priv->timewait_info->work.remote_id = rep_msg->local_comm_id;
 	cm_id_priv->timewait_info->remote_ca_guid = rep_msg->local_ca_guid;
-	cm_id_priv->timewait_info->remote_qpn = cm_rep_get_qpn(rep_msg, cm_id_priv->qp_type);
+	if (cm_id_priv->qp_type == IB_QPT_XRC_INI)
+		cm_id_priv->timewait_info->remote_qpn =
+			CM_GET(REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
+	else
+		cm_id_priv->timewait_info->remote_qpn =
+			CM_GET(REP_LOCAL_QPN, rep_msg);
 
 	spin_lock(&cm.lock);
 	/* Check for duplicate REP. */
@@ -2320,7 +2329,11 @@ static int cm_rep_handler(struct cm_work *work)
 
 	cm_id_priv->id.state = IB_CM_REP_RCVD;
 	cm_id_priv->id.remote_id = rep_msg->local_comm_id;
-	cm_id_priv->remote_qpn = cm_rep_get_qpn(rep_msg, cm_id_priv->qp_type);
+	if (cm_id_priv->qp_type == IB_QPT_XRC_INI)
+		cm_id_priv->remote_qpn =
+			CM_GET(REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
+	else
+		cm_id_priv->remote_qpn = CM_GET(REP_LOCAL_QPN, rep_msg);
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
 	cm_id_priv->sq_psn = cm_rep_get_starting_psn(rep_msg);
@@ -2434,7 +2447,7 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 			  cm_form_tid(cm_id_priv));
 	dreq_msg->local_comm_id = cm_id_priv->id.local_id;
 	dreq_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_dreq_set_remote_qpn(dreq_msg, cm_id_priv->remote_qpn);
+	CM_SET(DREQ_REMOTE_QPN_EECN, dreq_msg, cm_id_priv->remote_qpn);
 
 	if (private_data && private_data_len)
 		memcpy(dreq_msg->private_data, private_data, private_data_len);
@@ -2603,7 +2616,7 @@ static int cm_dreq_handler(struct cm_work *work)
 	work->cm_event.private_data_len = CM_DREQ_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
-	if (cm_id_priv->local_qpn != cm_dreq_get_remote_qpn(dreq_msg))
+	if (cm_id_priv->local_qpn != CM_GET(DREQ_REMOTE_QPN_EECN, dreq_msg))
 		goto unlock;
 
 	switch (cm_id_priv->id.state) {
@@ -3068,7 +3081,7 @@ static void cm_format_lap(struct cm_lap_msg *lap_msg,
 			  cm_form_tid(cm_id_priv));
 	lap_msg->local_comm_id = cm_id_priv->id.local_id;
 	lap_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_lap_set_remote_qpn(lap_msg, cm_id_priv->remote_qpn);
+	CM_SET(LAP_REMOTE_QPN_EECN, lap_msg, cm_id_priv->remote_qpn);
 	/* todo: need remote CM response timeout */
 	cm_lap_set_remote_resp_timeout(lap_msg, 0x1F);
 	lap_msg->alt_local_lid =
@@ -4111,7 +4124,7 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 				IB_QP_DEST_QPN | IB_QP_RQ_PSN;
 		qp_attr->ah_attr = cm_id_priv->av.ah_attr;
 		qp_attr->path_mtu = cm_id_priv->path_mtu;
-		qp_attr->dest_qp_num = be32_to_cpu(cm_id_priv->remote_qpn);
+		qp_attr->dest_qp_num = cm_id_priv->remote_qpn;
 		qp_attr->rq_psn = be32_to_cpu(cm_id_priv->rq_psn);
 		if (cm_id_priv->qp_type == IB_QPT_RC ||
 		    cm_id_priv->qp_type == IB_QPT_XRC_TGT) {
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 08b337551775..4cef1fe58813 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,18 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline __be32 cm_req_get_local_qpn(struct cm_req_msg *req_msg)
-{
-	return cpu_to_be32(be32_to_cpu(req_msg->offset32) >> 8);
-}
-
-static inline void cm_req_set_local_qpn(struct cm_req_msg *req_msg, __be32 qpn)
-{
-	req_msg->offset32 = cpu_to_be32((be32_to_cpu(qpn) << 8) |
-					 (be32_to_cpu(req_msg->offset32) &
-					  0x000000FF));
-}
-
 static inline u8 cm_req_get_resp_res(struct cm_req_msg *req_msg)
 {
 	return (u8) be32_to_cpu(req_msg->offset32);
@@ -792,6 +780,7 @@ struct cm_rep_msg {
 	__be32 local_qkey;
 	/* local QPN:24, rsvd:8 */
 	__be32 offset12;
+
 	/* local EECN:24, rsvd:8 */
 	__be32 offset16;
 	/* starting PSN:24 rsvd:8 */
@@ -808,34 +797,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline __be32 cm_rep_get_local_qpn(struct cm_rep_msg *rep_msg)
-{
-	return cpu_to_be32(be32_to_cpu(rep_msg->offset12) >> 8);
-}
-
-static inline void cm_rep_set_local_qpn(struct cm_rep_msg *rep_msg, __be32 qpn)
-{
-	rep_msg->offset12 = cpu_to_be32((be32_to_cpu(qpn) << 8) |
-			    (be32_to_cpu(rep_msg->offset12) & 0x000000FF));
-}
-
-static inline __be32 cm_rep_get_local_eecn(struct cm_rep_msg *rep_msg)
-{
-	return cpu_to_be32(be32_to_cpu(rep_msg->offset16) >> 8);
-}
-
-static inline void cm_rep_set_local_eecn(struct cm_rep_msg *rep_msg, __be32 eecn)
-{
-	rep_msg->offset16 = cpu_to_be32((be32_to_cpu(eecn) << 8) |
-			    (be32_to_cpu(rep_msg->offset16) & 0x000000FF));
-}
-
-static inline __be32 cm_rep_get_qpn(struct cm_rep_msg *rep_msg, enum ib_qp_type qp_type)
-{
-	return (qp_type == IB_QPT_XRC_INI) ?
-		cm_rep_get_local_eecn(rep_msg) : cm_rep_get_local_qpn(rep_msg);
-}
-
 static inline __be32 cm_rep_get_starting_psn(struct cm_rep_msg *rep_msg)
 {
 	return cpu_to_be32(be32_to_cpu(rep_msg->offset20) >> 8);
@@ -928,17 +889,6 @@ struct cm_dreq_msg {
 
 } __packed;
 
-static inline __be32 cm_dreq_get_remote_qpn(struct cm_dreq_msg *dreq_msg)
-{
-	return cpu_to_be32(be32_to_cpu(dreq_msg->offset8) >> 8);
-}
-
-static inline void cm_dreq_set_remote_qpn(struct cm_dreq_msg *dreq_msg, __be32 qpn)
-{
-	dreq_msg->offset8 = cpu_to_be32((be32_to_cpu(qpn) << 8) |
-			    (be32_to_cpu(dreq_msg->offset8) & 0x000000FF));
-}
-
 struct cm_drep_msg {
 	struct ib_mad_hdr hdr;
 
@@ -977,18 +927,6 @@ struct cm_lap_msg {
 	u8 private_data[CM_LAP_PRIVATE_DATA_SIZE];
 } __packed;
 
-static inline __be32 cm_lap_get_remote_qpn(struct cm_lap_msg *lap_msg)
-{
-	return cpu_to_be32(be32_to_cpu(lap_msg->offset12) >> 8);
-}
-
-static inline void cm_lap_set_remote_qpn(struct cm_lap_msg *lap_msg, __be32 qpn)
-{
-	lap_msg->offset12 = cpu_to_be32((be32_to_cpu(qpn) << 8) |
-					 (be32_to_cpu(lap_msg->offset12) &
-					  0x000000FF));
-}
-
 static inline u8 cm_lap_get_remote_resp_timeout(struct cm_lap_msg *lap_msg)
 {
 	return (u8) ((be32_to_cpu(lap_msg->offset12) & 0xF8) >> 3);
-- 
2.20.1

