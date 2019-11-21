Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 055FE10592C
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Nov 2019 19:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbfKUSOd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Nov 2019 13:14:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:52946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726279AbfKUSOd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Nov 2019 13:14:33 -0500
Received: from localhost (unknown [5.29.147.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55EAF206CB;
        Thu, 21 Nov 2019 18:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574360072;
        bh=hY2TOofrphCS8ZDM9L8nIENdjtuB0sUUwpoGkFFxwkw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4g/qHpKlmsVjXvUsIoSfs36u1YBxyuKmMnPjnKBSPNVi7TBTylG9gZJHW7VSiPaG
         NevCkecjqnUd8jJqtkFVRPlW1TFeORCaFQnLnwndwPk2gvHbWtJoGAZTjhGVU20jEN
         7g13t5GtR+5f7bqEnKEzhQRwwZ+g2too/LlJIkE8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: [PATCH rdma-next v1 22/48] RDMA/cm: Convert starting PSN to be u32 variable
Date:   Thu, 21 Nov 2019 20:12:47 +0200
Message-Id: <20191121181313.129430-23-leon@kernel.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191121181313.129430-1-leon@kernel.org>
References: <20191121181313.129430-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

Remove extra conversion between be32<->u32 for starting PSN
by using newly created IBA_GET/IBA_SET macros.

Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 24 ++++++++++++------------
 drivers/infiniband/core/cm_msgs.h | 24 ------------------------
 2 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index c60ec7967744..e9123f3b8f43 100644
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
 	IBA_SET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg, param->flow_control);
-	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
+	IBA_SET(CM_REQ_STARTING_PSN, req_msg, param->starting_psn);
 	cm_req_set_local_resp_timeout(req_msg,
 				      param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
@@ -1459,7 +1459,7 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->msg->context[1] = (void *) (unsigned long) IB_CM_REQ_SENT;
 
 	cm_id_priv->local_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
-	cm_id_priv->rq_psn = cm_req_get_starting_psn(req_msg);
+	cm_id_priv->rq_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
@@ -1694,7 +1694,7 @@ static void cm_format_req_event(struct cm_work *work,
 	param->remote_qkey = be32_to_cpu(req_msg->local_qkey);
 	param->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	param->qp_type = cm_req_get_qp_type(req_msg);
-	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
+	param->starting_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
 	param->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	param->initiator_depth = IBA_GET(CM_REQ_RESPONDED_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
@@ -2034,7 +2034,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
-	cm_id_priv->sq_psn = cm_req_get_starting_psn(req_msg);
+	cm_id_priv->sq_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
 	cm_id_priv->retry_count = cm_req_get_retry_count(req_msg);
 	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
@@ -2061,7 +2061,7 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	cm_format_mad_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid);
 	rep_msg->local_comm_id = cm_id_priv->id.local_id;
 	rep_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_rep_set_starting_psn(rep_msg, cpu_to_be32(param->starting_psn));
+	IBA_SET(CM_REP_STARTING_PSN, rep_msg, param->starting_psn);
 	rep_msg->resp_resources = param->responder_resources;
 	cm_rep_set_target_ack_delay(rep_msg,
 				    cm_id_priv->av.port->cm_dev->ack_delay);
@@ -2127,7 +2127,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	cm_id_priv->msg = msg;
 	cm_id_priv->initiator_depth = param->initiator_depth;
 	cm_id_priv->responder_resources = param->responder_resources;
-	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
+	cm_id_priv->rq_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
 	WARN_ONCE(param->qp_num & 0xFF000000,
 		  "IBTA declares QPN to be 24 bits, but it is 0x%X\n",
 		  param->qp_num);
@@ -2218,7 +2218,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 			IBA_GET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg);
 	else
 		param->remote_qpn = IBA_GET(CM_REP_LOCAL_QPN, rep_msg);
-	param->starting_psn = be32_to_cpu(cm_rep_get_starting_psn(rep_msg));
+	param->starting_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
 	param->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
@@ -2365,7 +2365,7 @@ static int cm_rep_handler(struct cm_work *work)
 		cm_id_priv->remote_qpn = IBA_GET(CM_REP_LOCAL_QPN, rep_msg);
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
-	cm_id_priv->sq_psn = cm_rep_get_starting_psn(rep_msg);
+	cm_id_priv->sq_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
 	cm_id_priv->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
 	cm_id_priv->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
 	cm_id_priv->av.timeout =
@@ -4154,7 +4154,7 @@ static int cm_init_qp_rtr_attr(struct cm_id_private *cm_id_priv,
 		qp_attr->ah_attr = cm_id_priv->av.ah_attr;
 		qp_attr->path_mtu = cm_id_priv->path_mtu;
 		qp_attr->dest_qp_num = cm_id_priv->remote_qpn;
-		qp_attr->rq_psn = be32_to_cpu(cm_id_priv->rq_psn);
+		qp_attr->rq_psn = cm_id_priv->rq_psn;
 		if (cm_id_priv->qp_type == IB_QPT_RC ||
 		    cm_id_priv->qp_type == IB_QPT_XRC_TGT) {
 			*qp_attr_mask |= IB_QP_MAX_DEST_RD_ATOMIC |
@@ -4203,7 +4203,7 @@ static int cm_init_qp_rts_attr(struct cm_id_private *cm_id_priv,
 	case IB_CM_ESTABLISHED:
 		if (cm_id_priv->id.lap_state == IB_CM_LAP_UNINIT) {
 			*qp_attr_mask = IB_QP_STATE | IB_QP_SQ_PSN;
-			qp_attr->sq_psn = be32_to_cpu(cm_id_priv->sq_psn);
+			qp_attr->sq_psn = cm_id_priv->sq_psn;
 			switch (cm_id_priv->qp_type) {
 			case IB_QPT_RC:
 			case IB_QPT_XRC_INI:
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index fc05a42e125d..47f66c1793a7 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -70,18 +70,6 @@ struct cm_req_msg {
 
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
@@ -379,18 +367,6 @@ struct cm_rep_msg {
 
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

