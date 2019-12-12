Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2BA111C97D
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2019 10:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728449AbfLLJj3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Dec 2019 04:39:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:39750 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728440AbfLLJj3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Dec 2019 04:39:29 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6A75722527;
        Thu, 12 Dec 2019 09:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576143568;
        bh=BGSDKMjaheWV4Lfmz1O+3NmUfINrABOTX792Tg3Db74=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jwY5dp2ebyWdscj74UjT6X7Nwq5dtxt8o5p4iPpBQK59cX9MILTNJCi0GUr30vy3Q
         WnKMnMV5sQpm654rZqcpBBP3Ij5EJ1JhTLZTsH9PTjZHn9+NnB3QOtLy1Xj+gCd3wt
         rwvh2pOQvf+Uq/jcMk3yoMieZeNCidtXE+sjodts=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-rc v2 16/48] RDMA/cm: Convert QPN and EECN to be u32 variables
Date:   Thu, 12 Dec 2019 11:37:58 +0200
Message-Id: <20191212093830.316934-17-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191212093830.316934-1-leon@kernel.org>
References: <20191212093830.316934-1-leon@kernel.org>
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
index fd79605c9e8b..247238469af1 100644
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
+	IBA_SET(CM_REQ_LOCAL_QPN, req_msg, param->qp_num);
 	cm_req_set_init_depth(req_msg, param->initiator_depth);
 	cm_req_set_remote_resp_timeout(req_msg,
 				       param->remote_cm_response_timeout);
@@ -1443,7 +1443,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->msg->timeout_ms = cm_id_priv->timeout_ms;
 	cm_id_priv->msg->context[1] = (void *) (unsigned long) IB_CM_REQ_SENT;
 
-	cm_id_priv->local_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->local_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->rq_psn = cm_req_get_starting_psn(req_msg);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
@@ -1666,7 +1666,7 @@ static void cm_format_req_event(struct cm_work *work,
 	}
 	param->remote_ca_guid = req_msg->local_ca_guid;
 	param->remote_qkey = be32_to_cpu(req_msg->local_qkey);
-	param->remote_qpn = be32_to_cpu(cm_req_get_local_qpn(req_msg));
+	param->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	param->qp_type = cm_req_get_qp_type(req_msg);
 	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
 	param->responder_resources = cm_req_get_init_depth(req_msg);
@@ -1929,7 +1929,7 @@ static int cm_req_handler(struct cm_work *work)
 	}
 	cm_id_priv->timewait_info->work.remote_id = req_msg->local_comm_id;
 	cm_id_priv->timewait_info->remote_ca_guid = req_msg->local_ca_guid;
-	cm_id_priv->timewait_info->remote_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->timewait_info->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 
 	listen_cm_id_priv = cm_match_req(work, cm_id_priv);
 	if (!listen_cm_id_priv) {
@@ -2003,7 +2003,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
 					cm_req_get_local_resp_timeout(req_msg));
 	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
-	cm_id_priv->remote_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	cm_id_priv->initiator_depth = cm_req_get_resp_res(req_msg);
 	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
@@ -2047,10 +2047,10 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		rep_msg->initiator_depth = param->initiator_depth;
 		cm_rep_set_flow_ctrl(rep_msg, param->flow_control);
 		cm_rep_set_srq(rep_msg, param->srq);
-		cm_rep_set_local_qpn(rep_msg, cpu_to_be32(param->qp_num));
+		IBA_SET(CM_REP_LOCAL_QPN, rep_msg, param->qp_num);
 	} else {
 		cm_rep_set_srq(rep_msg, 1);
-		cm_rep_set_local_eecn(rep_msg, cpu_to_be32(param->qp_num));
+		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
 	if (param->private_data && param->private_data_len)
@@ -2105,7 +2105,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	WARN_ONCE(param->qp_num & 0xFF000000,
 		  "IBTA declares QPN to be 24 bits, but it is 0x%X\n",
 		  param->qp_num);
-	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num);
+	cm_id_priv->local_qpn = param->qp_num;
 
 out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
 	return ret;
@@ -2187,7 +2187,11 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param = &work->cm_event.param.rep_rcvd;
 	param->remote_ca_guid = rep_msg->local_ca_guid;
 	param->remote_qkey = be32_to_cpu(rep_msg->local_qkey);
-	param->remote_qpn = be32_to_cpu(cm_rep_get_qpn(rep_msg, qp_type));
+	if (qp_type == IB_QPT_XRC_INI)
+		param->remote_qpn =
+			IBA_GET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
+	else
+		param->remote_qpn = IBA_GET(CM_REP_LOCAL_QPN, rep_msg);
 	param->starting_psn = be32_to_cpu(cm_rep_get_starting_psn(rep_msg));
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
@@ -2280,7 +2284,12 @@ static int cm_rep_handler(struct cm_work *work)
 
 	cm_id_priv->timewait_info->work.remote_id = rep_msg->local_comm_id;
 	cm_id_priv->timewait_info->remote_ca_guid = rep_msg->local_ca_guid;
-	cm_id_priv->timewait_info->remote_qpn = cm_rep_get_qpn(rep_msg, cm_id_priv->qp_type);
+	if (cm_id_priv->qp_type == IB_QPT_XRC_INI)
+		cm_id_priv->timewait_info->remote_qpn =
+			IBA_GET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
+	else
+		cm_id_priv->timewait_info->remote_qpn =
+			IBA_GET(CM_REP_LOCAL_QPN, rep_msg);
 
 	spin_lock(&cm.lock);
 	/* Check for duplicate REP. */
@@ -2323,7 +2332,11 @@ static int cm_rep_handler(struct cm_work *work)
 
 	cm_id_priv->id.state = IB_CM_REP_RCVD;
 	cm_id_priv->id.remote_id = rep_msg->local_comm_id;
-	cm_id_priv->remote_qpn = cm_rep_get_qpn(rep_msg, cm_id_priv->qp_type);
+	if (cm_id_priv->qp_type == IB_QPT_XRC_INI)
+		cm_id_priv->remote_qpn =
+			IBA_GET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
+	else
+		cm_id_priv->remote_qpn = IBA_GET(CM_REP_LOCAL_QPN, rep_msg);
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
 	cm_id_priv->sq_psn = cm_rep_get_starting_psn(rep_msg);
@@ -2437,7 +2450,7 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 			  cm_form_tid(cm_id_priv));
 	dreq_msg->local_comm_id = cm_id_priv->id.local_id;
 	dreq_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_dreq_set_remote_qpn(dreq_msg, cm_id_priv->remote_qpn);
+	IBA_SET(CM_DREQ_REMOTE_QPN_EECN, dreq_msg, cm_id_priv->remote_qpn);
 
 	if (private_data && private_data_len)
 		memcpy(dreq_msg->private_data, private_data, private_data_len);
@@ -2606,7 +2619,7 @@ static int cm_dreq_handler(struct cm_work *work)
 	work->cm_event.private_data_len = CM_DREQ_PRIVATE_DATA_SIZE;
 
 	spin_lock_irq(&cm_id_priv->lock);
-	if (cm_id_priv->local_qpn != cm_dreq_get_remote_qpn(dreq_msg))
+	if (cm_id_priv->local_qpn != IBA_GET(CM_DREQ_REMOTE_QPN_EECN, dreq_msg))
 		goto unlock;
 
 	switch (cm_id_priv->id.state) {
@@ -3071,7 +3084,7 @@ static void cm_format_lap(struct cm_lap_msg *lap_msg,
 			  cm_form_tid(cm_id_priv));
 	lap_msg->local_comm_id = cm_id_priv->id.local_id;
 	lap_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_lap_set_remote_qpn(lap_msg, cm_id_priv->remote_qpn);
+	IBA_SET(CM_LAP_REMOTE_QPN_EECN, lap_msg, cm_id_priv->remote_qpn);
 	/* todo: need remote CM response timeout */
 	cm_lap_set_remote_resp_timeout(lap_msg, 0x1F);
 	lap_msg->alt_local_lid =
@@ -4114,7 +4127,7 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 				IB_QP_DEST_QPN | IB_QP_RQ_PSN;
 		qp_attr->ah_attr = cm_id_priv->av.ah_attr;
 		qp_attr->path_mtu = cm_id_priv->path_mtu;
-		qp_attr->dest_qp_num = be32_to_cpu(cm_id_priv->remote_qpn);
+		qp_attr->dest_qp_num = cm_id_priv->remote_qpn;
 		qp_attr->rq_psn = be32_to_cpu(cm_id_priv->rq_psn);
 		if (cm_id_priv->qp_type == IB_QPT_RC ||
 		    cm_id_priv->qp_type == IB_QPT_XRC_TGT) {
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index ed887be775e3..650d6fb312c8 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,18 +70,6 @@ struct cm_req_msg {
 
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
@@ -462,6 +450,7 @@ struct cm_rep_msg {
 	__be32 local_qkey;
 	/* local QPN:24, rsvd:8 */
 	__be32 offset12;
+
 	/* local EECN:24, rsvd:8 */
 	__be32 offset16;
 	/* starting PSN:24 rsvd:8 */
@@ -478,34 +467,6 @@ struct cm_rep_msg {
 
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
@@ -598,17 +559,6 @@ struct cm_dreq_msg {
 
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
 
@@ -647,18 +597,6 @@ struct cm_lap_msg {
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

