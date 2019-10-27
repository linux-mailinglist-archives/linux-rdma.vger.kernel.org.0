Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4F11E6146
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Oct 2019 08:07:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbfJ0HHc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Oct 2019 03:07:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:35054 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbfJ0HHc (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Oct 2019 03:07:32 -0400
Received: from localhost (unknown [77.137.89.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DBD520578;
        Sun, 27 Oct 2019 07:07:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572160051;
        bh=HzMB1D3x10S/Eig2HLguDShujGnDCWdVBsX8vbhDBHM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R1U2IJhTDbmpWz7yvgu8s940pBPjWwU9NsSLKmoIfdiMXQZ6NkRzIwhV/tpTZ9TvV
         aDpwQugDV1EYuuUuBt4cgH/sLYOnqSm7bId5VuvubmLeMbhrmUOaluNmwiYf47UHJq
         oDBRTqU/l2mzPt3NRODjp7fQyMCesK6VwnVCVAqY=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: [PATCH rdma-next 19/43] RDMA/cm: Convert starting PSN to be u32 variable
Date:   Sun, 27 Oct 2019 09:05:57 +0200
Message-Id: <20191027070621.11711-20-leon@kernel.org>
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

Remove extra conversion between be32<->u32 for starting PSN
by using newly created CM_GET/CM_SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 24 ++++++++++++------------
 drivers/infiniband/core/cm_msgs.h | 24 ------------------------
 2 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 3e2eb096b2f9..0367da67501b 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -253,8 +253,8 @@ struct cm_id_private {
 	u32 local_qpn;
 	u32 remote_qpn;
 	enum ib_qp_type qp_type;
-	__be32 sq_psn;
-	__be32 rq_psn;
+	u32 sq_psn;
+	u32 rq_psn;
 	int timeout_ms;
 	enum ib_mtu path_mtu;
 	__be16 pkey;
@@ -1285,7 +1285,7 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	       param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
 	CM_SET(REQ_END_TO_END_FLOW_CONTROL, req_msg, param->flow_control);
-	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
+	CM_SET(REQ_STARTING_PSN, req_msg, param->starting_psn);
 	cm_req_set_local_resp_timeout(req_msg,
 				      param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
@@ -1459,7 +1459,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->msg->context[1] = (void *) (unsigned long) IB_CM_REQ_SENT;
 
 	cm_id_priv->local_qpn = CM_GET(REQ_LOCAL_QPN, req_msg);
-	cm_id_priv->rq_psn = cm_req_get_starting_psn(req_msg);
+	cm_id_priv->rq_psn = CM_GET(REQ_STARTING_PSN, req_msg);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
@@ -1694,7 +1694,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->remote_qkey = be32_to_cpu(req_msg->local_qkey);
 	param->remote_qpn = CM_GET(REP_LOCAL_QPN, req_msg);
 	param->qp_type = cm_req_get_qp_type(req_msg);
-	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
+	param->starting_psn = CM_GET(REQ_STARTING_PSN, req_msg);
 	param->responder_resources = CM_GET(REQ_INITIATOR_DEPTH, req_msg);
 	param->initiator_depth = CM_GET(REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
@@ -2034,7 +2034,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->responder_resources = CM_GET(REQ_INITIATOR_DEPTH, req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
-	cm_id_priv->sq_psn = cm_req_get_starting_psn(req_msg);
+	cm_id_priv->sq_psn = CM_GET(REQ_STARTING_PSN, req_msg);
 	cm_id_priv->retry_count = cm_req_get_retry_count(req_msg);
 	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
@@ -2061,7 +2061,7 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	cm_format_mad_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid);
 	rep_msg->local_comm_id = cm_id_priv->id.local_id;
 	rep_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_rep_set_starting_psn(rep_msg, cpu_to_be32(param->starting_psn));
+	CM_SET(REP_STARTING_PSN, rep_msg, param->starting_psn);
 	rep_msg->resp_resources = param->responder_resources;
 	cm_rep_set_target_ack_delay(rep_msg,
 				    cm_id_priv->av.port->cm_dev->ack_delay);
@@ -2127,7 +2127,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	cm_id_priv->msg = msg;
 	cm_id_priv->initiator_depth = param->initiator_depth;
 	cm_id_priv->responder_resources = param->responder_resources;
-	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
+	cm_id_priv->rq_psn = CM_GET(REP_STARTING_PSN, rep_msg);
 	cm_id_priv->local_qpn = param->qp_num;
 
 out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -2215,7 +2215,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 			CM_GET(REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
 	else
 		param->remote_qpn = CM_GET(REP_LOCAL_QPN, rep_msg);
-	param->starting_psn = be32_to_cpu(cm_rep_get_starting_psn(rep_msg));
+	param->starting_psn = CM_GET(REP_STARTING_PSN, rep_msg);
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
 	param->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
@@ -2362,7 +2362,7 @@ static int cm_rep_handler(struct cm_work *work)
 		cm_id_priv->remote_qpn = CM_GET(REP_LOCAL_QPN, rep_msg);
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
-	cm_id_priv->sq_psn = cm_rep_get_starting_psn(rep_msg);
+	cm_id_priv->sq_psn = CM_GET(REP_STARTING_PSN, rep_msg);
 	cm_id_priv->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	cm_id_priv->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
 	cm_id_priv->av.timeout =
@@ -4151,7 +4151,7 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 		qp_attr->ah_attr = cm_id_priv->av.ah_attr;
 		qp_attr->path_mtu = cm_id_priv->path_mtu;
 		qp_attr->dest_qp_num = cm_id_priv->remote_qpn;
-		qp_attr->rq_psn = be32_to_cpu(cm_id_priv->rq_psn);
+		qp_attr->rq_psn = cm_id_priv->rq_psn;
 		if (cm_id_priv->qp_type == IB_QPT_RC ||
 		    cm_id_priv->qp_type == IB_QPT_XRC_TGT) {
 			*qp_attr_mask |= IB_QP_MAX_DEST_RD_ATOMIC |
@@ -4200,7 +4200,7 @@ static int cm_init_qp_rts_attr(struct cm_id_private *cm_id_priv,
 	case IB_CM_ESTABLISHED:
 		if (cm_id_priv->id.lap_state == IB_CM_LAP_UNINIT) {
 			*qp_attr_mask = IB_QP_STATE | IB_QP_SQ_PSN;
-			qp_attr->sq_psn = be32_to_cpu(cm_id_priv->sq_psn);
+			qp_attr->sq_psn = cm_id_priv->sq_psn;
 			switch (cm_id_priv->qp_type) {
 			case IB_QPT_RC:
 			case IB_QPT_XRC_INI:
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index 538ce42b97c3..b63bba57394e 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -400,18 +400,6 @@ struct cm_req_msg {
 
 } __packed;
 
-static inline __be32 cm_req_get_starting_psn(struct cm_req_msg *req_msg)
-{
-	return cpu_to_be32(be32_to_cpu(req_msg->offset44) >> 8);
-}
-
-static inline void cm_req_set_starting_psn(struct cm_req_msg *req_msg,
-					   __be32 starting_psn)
-{
-	req_msg->offset44 = cpu_to_be32((be32_to_cpu(starting_psn) << 8) |
-			    (be32_to_cpu(req_msg->offset44) & 0x000000FF));
-}
-
 static inline u8 cm_req_get_local_resp_timeout(struct cm_req_msg *req_msg)
 {
 	return (u8) ((be32_to_cpu(req_msg->offset44) & 0xF8) >> 3);
@@ -709,18 +697,6 @@ struct cm_rep_msg {
 
 } __packed;
 
-static inline __be32 cm_rep_get_starting_psn(struct cm_rep_msg *rep_msg)
-{
-	return cpu_to_be32(be32_to_cpu(rep_msg->offset20) >> 8);
-}
-
-static inline void cm_rep_set_starting_psn(struct cm_rep_msg *rep_msg,
-					   __be32 starting_psn)
-{
-	rep_msg->offset20 = cpu_to_be32((be32_to_cpu(starting_psn) << 8) |
-			    (be32_to_cpu(rep_msg->offset20) & 0x000000FF));
-}
-
 static inline u8 cm_rep_get_target_ack_delay(struct cm_rep_msg *rep_msg)
 {
 	return (u8) (rep_msg->offset26 >> 3);
-- 
2.20.1

