Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9542113F720
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:09:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387905AbgAPTJf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:09:35 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33547 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387531AbgAPRAq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:46 -0500
Received: by mail-qk1-f193.google.com with SMTP id d71so19800012qkc.0
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jVEmisLyBI2yauh2ZR85h1Od/GSg2/BZHo4CzoJVAGE=;
        b=btbuLGvPFfu8nMWzLXR6pW3OzR6woYz1hIWjDU0+6EfANyQWl/afAd3rTo+iDrXYFS
         GOnKCXtQMuqG3FZjZcTmYTGscPYYblMcFvt1TGOSGTFURWg9sHnjqcXlpXno4OCwddAo
         nlSyVftrsPEnhCBe5lbyReSvKclD5NUrYB/yRFx+fMNuNKqCcNkElGr6gGpdgdMizYF9
         ggR/dsvOJsQta/lyntp3Akgk2GRd9I7Q2aMWbCgSQKSOXAIfyTps0u1gmUdC623q4Z3C
         MHm1OpxkUnWY5HVOqdwKKSdmpfDnMQKL4UzAjgahYn9lb/Icu2n6PSHFr31LvyzosEX9
         jZuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jVEmisLyBI2yauh2ZR85h1Od/GSg2/BZHo4CzoJVAGE=;
        b=ZpdWgg/SdlPPnTYD6vCBBZQc+TscRcm6FdpKmz83Jq559TlFYC/tGVE7S3VyNDa6Au
         erWcyTHUTeSl3spge9VRb2xUJLnS2QKafNrg7Ou3XLDxJTukuf8q/TayVPveaRLlZ0gR
         R1HX71aAzzZ30b4LW5ltbF/sStY6r3/E41HCnX+YkNpKHkdjN3C2Lm7BFfF+mp6Kjr/d
         ahLe4Lu1A+HzUUK6vbMaW3ZOzRxQZQRX72wiPO2vNX3/12RinW4facfd3ULLOLPeBjvQ
         /0q0eeBkXi3RgecrVmrx2QAf4bXTs6nfU4e84+CO78HBtWcOzjV+ZlmhGKg8BZm8x6VP
         YADA==
X-Gm-Message-State: APjAAAUGV7GoVtrr5rsU7GTkKiho6t0CSZhly/m0uIvVVRC2cuD1RZSN
        a547s1aEZX9KC9laxg0gsaTc8ujnOZs=
X-Google-Smtp-Source: APXvYqwg7qU0R/yI0VxOltotfK/7COBNbID+q0Bz4WWbB/k8jSmBYj5EJICjCDs0N/z+n6RwG96vvw==
X-Received: by 2002:a05:620a:166a:: with SMTP id d10mr33055736qko.37.1579194042482;
        Thu, 16 Jan 2020 09:00:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id e21sm10353819qkm.55.2020.01.16.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vc-0007tO-2i; Thu, 16 Jan 2020 13:00:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 3/7] RDMA/cm: Use IBA functions for simple get/set acessors
Date:   Thu, 16 Jan 2020 13:00:33 -0400
Message-Id: <20200116170037.30109-4-jgg@ziepe.ca>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200116170037.30109-1-jgg@ziepe.ca>
References: <20200116170037.30109-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Use a Coccinelle spatch to replace CM helper functions with IBA_GET/SET
versions. Applied with

$ spatch --sp-file edits.sp --in-place drivers/infiniband/core/cm.c

The spatch file was generated using the template pattern:

@@
expression val;
{struct} *msg;
@@
- {old_setter}
+ IBA_SET({new_name}, msg, val)
@@
{struct} *msg;
@@
- {old_getter}
+ IBA_GET({new_name}, msg)

Iterated for every IBA_CHECK_GET()/IBA_CHECK_GET() pairing. Touched up
with clang-format after.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 242 ++++++++-----------
 drivers/infiniband/core/cm_msgs.h | 371 +-----------------------------
 2 files changed, 104 insertions(+), 509 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 7f609979e4debf..a1a9681601329a 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1255,23 +1255,26 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->service_id = param->service_id;
 	req_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 	cm_req_set_local_qpn(req_msg, cpu_to_be32(param->qp_num));
-	cm_req_set_init_depth(req_msg, param->initiator_depth);
-	cm_req_set_remote_resp_timeout(req_msg,
-				       param->remote_cm_response_timeout);
+	IBA_SET(CM_REQ_INITIATOR_DEPTH, req_msg, param->initiator_depth);
+	IBA_SET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg,
+		param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
-	cm_req_set_flow_ctrl(req_msg, param->flow_control);
+	IBA_SET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg, param->flow_control);
 	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
-	cm_req_set_local_resp_timeout(req_msg,
-				      param->local_cm_response_timeout);
+	IBA_SET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg,
+		param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
-	cm_req_set_path_mtu(req_msg, param->primary_path->mtu);
-	cm_req_set_max_cm_retries(req_msg, param->max_cm_retries);
+	IBA_SET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg,
+		param->primary_path->mtu);
+	IBA_SET(CM_REQ_MAX_CM_RETRIES, req_msg, param->max_cm_retries);
 
 	if (param->qp_type != IB_QPT_XRC_INI) {
-		cm_req_set_resp_res(req_msg, param->responder_resources);
-		cm_req_set_retry_count(req_msg, param->retry_count);
-		cm_req_set_rnr_retry_count(req_msg, param->rnr_retry_count);
-		cm_req_set_srq(req_msg, param->srq);
+		IBA_SET(CM_REQ_RESPONDER_RESOURCES, req_msg,
+			param->responder_resources);
+		IBA_SET(CM_REQ_RETRY_COUNT, req_msg, param->retry_count);
+		IBA_SET(CM_REQ_RNR_RETRY_COUNT, req_msg,
+			param->rnr_retry_count);
+		IBA_SET(CM_REQ_SRQ, req_msg, param->srq);
 	}
 
 	req_msg->primary_local_gid = pri_path->sgid;
@@ -1293,12 +1296,13 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		req_msg->primary_remote_lid = IB_LID_PERMISSIVE;
 	}
 	cm_req_set_primary_flow_label(req_msg, pri_path->flow_label);
-	cm_req_set_primary_packet_rate(req_msg, pri_path->rate);
+	IBA_SET(CM_REQ_PRIMARY_PACKET_RATE, req_msg, pri_path->rate);
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
-	cm_req_set_primary_sl(req_msg, pri_path->sl);
-	cm_req_set_primary_subnet_local(req_msg, (pri_path->hop_limit <= 1));
-	cm_req_set_primary_local_ack_timeout(req_msg,
+	IBA_SET(CM_REQ_PRIMARY_SL, req_msg, pri_path->sl);
+	IBA_SET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg,
+		(pri_path->hop_limit <= 1));
+	IBA_SET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg,
 		cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 			       pri_path->packet_life_time));
 
@@ -1328,12 +1332,13 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		}
 		cm_req_set_alt_flow_label(req_msg,
 					  alt_path->flow_label);
-		cm_req_set_alt_packet_rate(req_msg, alt_path->rate);
+		IBA_SET(CM_REQ_ALTERNATE_PACKET_RATE, req_msg, alt_path->rate);
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
-		cm_req_set_alt_sl(req_msg, alt_path->sl);
-		cm_req_set_alt_subnet_local(req_msg, (alt_path->hop_limit <= 1));
-		cm_req_set_alt_local_ack_timeout(req_msg,
+		IBA_SET(CM_REQ_ALTERNATE_SL, req_msg, alt_path->sl);
+		IBA_SET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg,
+			(alt_path->hop_limit <= 1));
+		IBA_SET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg,
 			cm_ack_timeout(cm_id_priv->av.port->cm_dev->ack_delay,
 				       alt_path->packet_life_time));
 	}
@@ -1473,11 +1478,11 @@ static int cm_issue_rej(struct cm_port *port,
 	cm_format_mad_hdr(&rej_msg->hdr, CM_REJ_ATTR_ID, rcv_msg->hdr.tid);
 	rej_msg->remote_comm_id = rcv_msg->local_comm_id;
 	rej_msg->local_comm_id = rcv_msg->remote_comm_id;
-	cm_rej_set_msg_rejected(rej_msg, msg_rejected);
+	IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, msg_rejected);
 	rej_msg->reason = cpu_to_be16(reason);
 
 	if (ari && ari_length) {
-		cm_rej_set_reject_info_len(rej_msg, ari_length);
+		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
 		memcpy(rej_msg->ari, ari, ari_length);
 	}
 
@@ -1548,14 +1553,14 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->traffic_class = req_msg->primary_traffic_class;
 	primary_path->reversible = 1;
 	primary_path->pkey = req_msg->pkey;
-	primary_path->sl = cm_req_get_primary_sl(req_msg);
+	primary_path->sl = IBA_GET(CM_REQ_PRIMARY_SL, req_msg);
 	primary_path->mtu_selector = IB_SA_EQ;
-	primary_path->mtu = cm_req_get_path_mtu(req_msg);
+	primary_path->mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	primary_path->rate_selector = IB_SA_EQ;
-	primary_path->rate = cm_req_get_primary_packet_rate(req_msg);
+	primary_path->rate = IBA_GET(CM_REQ_PRIMARY_PACKET_RATE, req_msg);
 	primary_path->packet_life_time_selector = IB_SA_EQ;
 	primary_path->packet_life_time =
-		cm_req_get_primary_local_ack_timeout(req_msg);
+		IBA_GET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg);
 	primary_path->packet_life_time -= (primary_path->packet_life_time > 0);
 	primary_path->service_id = req_msg->service_id;
 	if (sa_path_is_roce(primary_path))
@@ -1569,14 +1574,15 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->traffic_class = req_msg->alt_traffic_class;
 		alt_path->reversible = 1;
 		alt_path->pkey = req_msg->pkey;
-		alt_path->sl = cm_req_get_alt_sl(req_msg);
+		alt_path->sl = IBA_GET(CM_REQ_ALTERNATE_SL, req_msg);
 		alt_path->mtu_selector = IB_SA_EQ;
-		alt_path->mtu = cm_req_get_path_mtu(req_msg);
+		alt_path->mtu =
+			IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 		alt_path->rate_selector = IB_SA_EQ;
-		alt_path->rate = cm_req_get_alt_packet_rate(req_msg);
+		alt_path->rate = IBA_GET(CM_REQ_ALTERNATE_PACKET_RATE, req_msg);
 		alt_path->packet_life_time_selector = IB_SA_EQ;
 		alt_path->packet_life_time =
-			cm_req_get_alt_local_ack_timeout(req_msg);
+			IBA_GET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg);
 		alt_path->packet_life_time -= (alt_path->packet_life_time > 0);
 		alt_path->service_id = req_msg->service_id;
 
@@ -1658,16 +1664,16 @@ static void cm_format_req_event(struct cm_work *work,
 	param->remote_qpn = be32_to_cpu(cm_req_get_local_qpn(req_msg));
 	param->qp_type = cm_req_get_qp_type(req_msg);
 	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
-	param->responder_resources = cm_req_get_init_depth(req_msg);
-	param->initiator_depth = cm_req_get_resp_res(req_msg);
+	param->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
+	param->initiator_depth = IBA_GET(CM_REQ_RESPONDER_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
-					cm_req_get_remote_resp_timeout(req_msg);
-	param->flow_control = cm_req_get_flow_ctrl(req_msg);
+		IBA_GET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg);
+	param->flow_control = IBA_GET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg);
 	param->remote_cm_response_timeout =
-					cm_req_get_local_resp_timeout(req_msg);
-	param->retry_count = cm_req_get_retry_count(req_msg);
-	param->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
-	param->srq = cm_req_get_srq(req_msg);
+		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg);
+	param->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
+	param->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
+	param->srq = IBA_GET(CM_REQ_SRQ, req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &req_msg->private_data;
 }
@@ -1703,10 +1709,10 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 			  const void *private_data, u8 private_data_len)
 {
 	cm_format_mad_hdr(&mra_msg->hdr, CM_MRA_ATTR_ID, cm_id_priv->tid);
-	cm_mra_set_msg_mraed(mra_msg, msg_mraed);
+	IBA_SET(CM_MRA_MESSAGE_MRAED, mra_msg, msg_mraed);
 	mra_msg->local_comm_id = cm_id_priv->id.local_id;
 	mra_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_mra_set_service_timeout(mra_msg, service_timeout);
+	IBA_SET(CM_MRA_SERVICE_TIMEOUT, mra_msg, service_timeout);
 
 	if (private_data && private_data_len)
 		memcpy(mra_msg->private_data, private_data, private_data_len);
@@ -1726,26 +1732,27 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 	switch(cm_id_priv->id.state) {
 	case IB_CM_REQ_RCVD:
 		rej_msg->local_comm_id = 0;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REQ);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_MRA_REQ_SENT:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REQ);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_REP);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REP);
 		break;
 	default:
 		rej_msg->local_comm_id = cm_id_priv->id.local_id;
-		cm_rej_set_msg_rejected(rej_msg, CM_MSG_RESPONSE_OTHER);
+		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg,
+			CM_MSG_RESPONSE_OTHER);
 		break;
 	}
 
 	rej_msg->reason = cpu_to_be16(reason);
 	if (ari && ari_length) {
-		cm_rej_set_reject_info_len(rej_msg, ari_length);
+		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
 		memcpy(rej_msg->ari, ari, ari_length);
 	}
 
@@ -1866,20 +1873,20 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
  */
 static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 {
-	if (!cm_req_get_primary_subnet_local(req_msg)) {
+	if (!IBA_GET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg)) {
 		if (req_msg->primary_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->primary_local_lid = ib_lid_be16(wc->slid);
-			cm_req_set_primary_sl(req_msg, wc->sl);
+			IBA_SET(CM_REQ_PRIMARY_SL, req_msg, wc->sl);
 		}
 
 		if (req_msg->primary_remote_lid == IB_LID_PERMISSIVE)
 			req_msg->primary_remote_lid = cpu_to_be16(wc->dlid_path_bits);
 	}
 
-	if (!cm_req_get_alt_subnet_local(req_msg)) {
+	if (!IBA_GET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg)) {
 		if (req_msg->alt_local_lid == IB_LID_PERMISSIVE) {
 			req_msg->alt_local_lid = ib_lid_be16(wc->slid);
-			cm_req_set_alt_sl(req_msg, wc->sl);
+			IBA_SET(CM_REQ_ALTERNATE_SL, req_msg, wc->sl);
 		}
 
 		if (req_msg->alt_remote_lid == IB_LID_PERMISSIVE)
@@ -1989,16 +1996,18 @@ static int cm_req_handler(struct cm_work *work)
 	}
 	cm_id_priv->tid = req_msg->hdr.tid;
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
-					cm_req_get_local_resp_timeout(req_msg));
-	cm_id_priv->max_cm_retries = cm_req_get_max_cm_retries(req_msg);
+		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
+	cm_id_priv->max_cm_retries = IBA_GET(CM_REQ_MAX_CM_RETRIES, req_msg);
 	cm_id_priv->remote_qpn = cm_req_get_local_qpn(req_msg);
-	cm_id_priv->initiator_depth = cm_req_get_resp_res(req_msg);
-	cm_id_priv->responder_resources = cm_req_get_init_depth(req_msg);
-	cm_id_priv->path_mtu = cm_req_get_path_mtu(req_msg);
+	cm_id_priv->initiator_depth =
+		IBA_GET(CM_REQ_RESPONDER_RESOURCES, req_msg);
+	cm_id_priv->responder_resources =
+		IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
+	cm_id_priv->path_mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
 	cm_id_priv->sq_psn = cm_req_get_starting_psn(req_msg);
-	cm_id_priv->retry_count = cm_req_get_retry_count(req_msg);
-	cm_id_priv->rnr_retry_count = cm_req_get_rnr_retry_count(req_msg);
+	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
+	cm_id_priv->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
 
 	cm_format_req_event(work, cm_id_priv, &listen_cm_id_priv->id);
@@ -2025,19 +2034,20 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	rep_msg->remote_comm_id = cm_id_priv->id.remote_id;
 	cm_rep_set_starting_psn(rep_msg, cpu_to_be32(param->starting_psn));
 	rep_msg->resp_resources = param->responder_resources;
-	cm_rep_set_target_ack_delay(rep_msg,
-				    cm_id_priv->av.port->cm_dev->ack_delay);
-	cm_rep_set_failover(rep_msg, param->failover_accepted);
-	cm_rep_set_rnr_retry_count(rep_msg, param->rnr_retry_count);
+	IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
+		cm_id_priv->av.port->cm_dev->ack_delay);
+	IBA_SET(CM_REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
+	IBA_SET(CM_REP_RNR_RETRY_COUNT, rep_msg, param->rnr_retry_count);
 	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
 
 	if (cm_id_priv->qp_type != IB_QPT_XRC_TGT) {
 		rep_msg->initiator_depth = param->initiator_depth;
-		cm_rep_set_flow_ctrl(rep_msg, param->flow_control);
-		cm_rep_set_srq(rep_msg, param->srq);
+		IBA_SET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg,
+			param->flow_control);
+		IBA_SET(CM_REP_SRQ, rep_msg, param->srq);
 		cm_rep_set_local_qpn(rep_msg, cpu_to_be32(param->qp_num));
 	} else {
-		cm_rep_set_srq(rep_msg, 1);
+		IBA_SET(CM_REP_SRQ, rep_msg, 1);
 		cm_rep_set_local_eecn(rep_msg, cpu_to_be32(param->qp_num));
 	}
 
@@ -2176,11 +2186,11 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->starting_psn = be32_to_cpu(cm_rep_get_starting_psn(rep_msg));
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
-	param->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
-	param->failover_accepted = cm_rep_get_failover(rep_msg);
-	param->flow_control = cm_rep_get_flow_ctrl(rep_msg);
-	param->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
-	param->srq = cm_rep_get_srq(rep_msg);
+	param->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
+	param->failover_accepted = IBA_GET(CM_REP_FAILOVER_ACCEPTED, rep_msg);
+	param->flow_control = IBA_GET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg);
+	param->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
+	param->srq = IBA_GET(CM_REP_SRQ, rep_msg);
 	work->cm_event.private_data = &rep_msg->private_data;
 }
 
@@ -2311,8 +2321,9 @@ static int cm_rep_handler(struct cm_work *work)
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
 	cm_id_priv->sq_psn = cm_rep_get_starting_psn(rep_msg);
-	cm_id_priv->rnr_retry_count = cm_rep_get_rnr_retry_count(rep_msg);
-	cm_id_priv->target_ack_delay = cm_rep_get_target_ack_delay(rep_msg);
+	cm_id_priv->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
+	cm_id_priv->target_ack_delay =
+		IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	cm_id_priv->av.timeout =
 			cm_ack_timeout(cm_id_priv->target_ack_delay,
 				       cm_id_priv->av.timeout - 1);
@@ -2756,7 +2767,7 @@ static void cm_format_rej_event(struct cm_work *work)
 	rej_msg = (struct cm_rej_msg *)work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.rej_rcvd;
 	param->ari = rej_msg->ari;
-	param->ari_length = cm_rej_get_reject_info_len(rej_msg);
+	param->ari_length = IBA_GET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg);
 	param->reason = __be16_to_cpu(rej_msg->reason);
 	work->cm_event.private_data = &rej_msg->private_data;
 }
@@ -2780,7 +2791,8 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 		cm_id_priv =
 			cm_acquire_id(timewait_info->work.local_id, remote_id);
 		spin_unlock_irq(&cm.lock);
-	} else if (cm_rej_get_msg_rejected(rej_msg) == CM_MSG_RESPONSE_REQ)
+	} else if (IBA_GET(CM_REJ_MESSAGE_REJECTED, rej_msg) ==
+		   CM_MSG_RESPONSE_REQ)
 		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, 0);
 	else
 		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, remote_id);
@@ -2941,7 +2953,7 @@ EXPORT_SYMBOL(ib_send_cm_mra);
 
 static struct cm_id_private * cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
-	switch (cm_mra_get_msg_mraed(mra_msg)) {
+	switch (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg)) {
 	case CM_MSG_RESPONSE_REQ:
 		return cm_acquire_id(mra_msg->remote_comm_id, 0);
 	case CM_MSG_RESPONSE_REP:
@@ -2966,28 +2978,31 @@ static int cm_mra_handler(struct cm_work *work)
 
 	work->cm_event.private_data = &mra_msg->private_data;
 	work->cm_event.param.mra_rcvd.service_timeout =
-					cm_mra_get_service_timeout(mra_msg);
-	timeout = cm_convert_to_ms(cm_mra_get_service_timeout(mra_msg)) +
+		IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg);
+	timeout = cm_convert_to_ms(IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg)) +
 		  cm_convert_to_ms(cm_id_priv->av.timeout);
 
 	spin_lock_irq(&cm_id_priv->lock);
 	switch (cm_id_priv->id.state) {
 	case IB_CM_REQ_SENT:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_REQ ||
+		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
+			    CM_MSG_RESPONSE_REQ ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REQ_RCVD;
 		break;
 	case IB_CM_REP_SENT:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_REP ||
+		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
+			    CM_MSG_RESPONSE_REP ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout))
 			goto out;
 		cm_id_priv->id.state = IB_CM_MRA_REP_RCVD;
 		break;
 	case IB_CM_ESTABLISHED:
-		if (cm_mra_get_msg_mraed(mra_msg) != CM_MSG_RESPONSE_OTHER ||
+		if (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg) !=
+			    CM_MSG_RESPONSE_OTHER ||
 		    cm_id_priv->id.lap_state != IB_CM_LAP_SENT ||
 		    ib_modify_mad(cm_id_priv->av.port->mad_agent,
 				  cm_id_priv->msg, timeout)) {
@@ -3054,16 +3069,17 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 	path->sgid = lap_msg->alt_remote_gid;
 	path->flow_label = cm_lap_get_flow_label(lap_msg);
 	path->hop_limit = lap_msg->alt_hop_limit;
-	path->traffic_class = cm_lap_get_traffic_class(lap_msg);
+	path->traffic_class = IBA_GET(CM_LAP_ALTERNATE_TRAFFIC_CLASS, lap_msg);
 	path->reversible = 1;
 	path->pkey = cm_id_priv->pkey;
-	path->sl = cm_lap_get_sl(lap_msg);
+	path->sl = IBA_GET(CM_LAP_ALTERNATE_SL, lap_msg);
 	path->mtu_selector = IB_SA_EQ;
 	path->mtu = cm_id_priv->path_mtu;
 	path->rate_selector = IB_SA_EQ;
-	path->rate = cm_lap_get_packet_rate(lap_msg);
+	path->rate = IBA_GET(CM_LAP_ALTERNATE_PACKET_RATE, lap_msg);
 	path->packet_life_time_selector = IB_SA_EQ;
-	path->packet_life_time = cm_lap_get_local_ack_timeout(lap_msg);
+	path->packet_life_time =
+		IBA_GET(CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT, lap_msg);
 	path->packet_life_time -= (path->packet_life_time > 0);
 	cm_format_path_lid_from_lap(lap_msg, path);
 }
@@ -4436,83 +4452,21 @@ static void self_test(void)
 	printk("Running CM extractor self test\n");
 	IBA_CHECK_GET_BE(CM_REQ_LOCAL_QPN, cm_req_get_local_qpn);
 	IBA_CHECK_SET_BE(CM_REQ_LOCAL_QPN, cm_req_set_local_qpn);
-	IBA_CHECK_GET(CM_REQ_RESPONDER_RESOURCES, cm_req_get_resp_res);
-	IBA_CHECK_SET(CM_REQ_RESPONDER_RESOURCES, cm_req_set_resp_res);
-	IBA_CHECK_GET(CM_REQ_INITIATOR_DEPTH, cm_req_get_init_depth);
-	IBA_CHECK_SET(CM_REQ_INITIATOR_DEPTH, cm_req_set_init_depth);
-	IBA_CHECK_GET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, cm_req_get_remote_resp_timeout);
-	IBA_CHECK_SET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, cm_req_set_remote_resp_timeout);
-	IBA_CHECK_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, cm_req_get_transport_type);
-	IBA_CHECK_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, cm_req_set_transport_type);
-	IBA_CHECK_GET(CM_REQ_END_TO_END_FLOW_CONTROL, cm_req_get_flow_ctrl);
-	IBA_CHECK_SET(CM_REQ_END_TO_END_FLOW_CONTROL, cm_req_set_flow_ctrl);
 	IBA_CHECK_GET_BE(CM_REQ_STARTING_PSN, cm_req_get_starting_psn);
 	IBA_CHECK_SET_BE(CM_REQ_STARTING_PSN, cm_req_set_starting_psn);
-	IBA_CHECK_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, cm_req_get_local_resp_timeout);
-	IBA_CHECK_SET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, cm_req_set_local_resp_timeout);
-	IBA_CHECK_GET(CM_REQ_RETRY_COUNT, cm_req_get_retry_count);
-	IBA_CHECK_SET(CM_REQ_RETRY_COUNT, cm_req_set_retry_count);
-	IBA_CHECK_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, cm_req_get_path_mtu);
-	IBA_CHECK_SET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, cm_req_set_path_mtu);
-	IBA_CHECK_GET(CM_REQ_RNR_RETRY_COUNT, cm_req_get_rnr_retry_count);
-	IBA_CHECK_SET(CM_REQ_RNR_RETRY_COUNT, cm_req_set_rnr_retry_count);
-	IBA_CHECK_GET(CM_REQ_MAX_CM_RETRIES, cm_req_get_max_cm_retries);
-	IBA_CHECK_SET(CM_REQ_MAX_CM_RETRIES, cm_req_set_max_cm_retries);
-	IBA_CHECK_GET(CM_REQ_SRQ, cm_req_get_srq);
-	IBA_CHECK_SET(CM_REQ_SRQ, cm_req_set_srq);
-	IBA_CHECK_GET(CM_REQ_EXTENDED_TRANSPORT_TYPE, cm_req_get_transport_type_ex);
-	IBA_CHECK_SET(CM_REQ_EXTENDED_TRANSPORT_TYPE, cm_req_set_transport_type_ex);
 	IBA_CHECK_GET_BE(CM_REQ_PRIMARY_FLOW_LABEL, cm_req_get_primary_flow_label);
 	IBA_CHECK_SET_BE(CM_REQ_PRIMARY_FLOW_LABEL, cm_req_set_primary_flow_label);
-	IBA_CHECK_GET(CM_REQ_PRIMARY_PACKET_RATE, cm_req_get_primary_packet_rate);
-	IBA_CHECK_SET(CM_REQ_PRIMARY_PACKET_RATE, cm_req_set_primary_packet_rate);
-	IBA_CHECK_GET(CM_REQ_PRIMARY_SL, cm_req_get_primary_sl);
-	IBA_CHECK_SET(CM_REQ_PRIMARY_SL, cm_req_set_primary_sl);
-	IBA_CHECK_GET(CM_REQ_PRIMARY_SUBNET_LOCAL, cm_req_get_primary_subnet_local);
-	IBA_CHECK_SET(CM_REQ_PRIMARY_SUBNET_LOCAL, cm_req_set_primary_subnet_local);
-	IBA_CHECK_GET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, cm_req_get_primary_local_ack_timeout);
-	IBA_CHECK_SET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, cm_req_set_primary_local_ack_timeout);
 	IBA_CHECK_GET_BE(CM_REQ_ALTERNATE_FLOW_LABEL, cm_req_get_alt_flow_label);
 	IBA_CHECK_SET_BE(CM_REQ_ALTERNATE_FLOW_LABEL, cm_req_set_alt_flow_label);
-	IBA_CHECK_GET(CM_REQ_ALTERNATE_PACKET_RATE, cm_req_get_alt_packet_rate);
-	IBA_CHECK_SET(CM_REQ_ALTERNATE_PACKET_RATE, cm_req_set_alt_packet_rate);
-	IBA_CHECK_GET(CM_REQ_ALTERNATE_SL, cm_req_get_alt_sl);
-	IBA_CHECK_SET(CM_REQ_ALTERNATE_SL, cm_req_set_alt_sl);
-	IBA_CHECK_GET(CM_REQ_ALTERNATE_SUBNET_LOCAL, cm_req_get_alt_subnet_local);
-	IBA_CHECK_SET(CM_REQ_ALTERNATE_SUBNET_LOCAL, cm_req_set_alt_subnet_local);
-	IBA_CHECK_GET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, cm_req_get_alt_local_ack_timeout);
-	IBA_CHECK_SET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, cm_req_set_alt_local_ack_timeout);
-	IBA_CHECK_GET(CM_MRA_MESSAGE_MRAED, cm_mra_get_msg_mraed);
-	IBA_CHECK_SET(CM_MRA_MESSAGE_MRAED, cm_mra_set_msg_mraed);
-	IBA_CHECK_GET(CM_MRA_SERVICE_TIMEOUT, cm_mra_get_service_timeout);
-	IBA_CHECK_SET(CM_MRA_SERVICE_TIMEOUT, cm_mra_set_service_timeout);
-	IBA_CHECK_GET(CM_REJ_MESSAGE_REJECTED, cm_rej_get_msg_rejected);
-	IBA_CHECK_SET(CM_REJ_MESSAGE_REJECTED, cm_rej_set_msg_rejected);
-	IBA_CHECK_GET(CM_REJ_REJECTED_INFO_LENGTH, cm_rej_get_reject_info_len);
-	IBA_CHECK_SET(CM_REJ_REJECTED_INFO_LENGTH, cm_rej_set_reject_info_len);
 	IBA_CHECK_GET_BE(CM_REP_LOCAL_QPN, cm_rep_get_local_qpn);
 	IBA_CHECK_SET_BE(CM_REP_LOCAL_QPN, cm_rep_set_local_qpn);
 	IBA_CHECK_GET_BE(CM_REP_LOCAL_EE_CONTEXT_NUMBER, cm_rep_get_local_eecn);
 	IBA_CHECK_SET_BE(CM_REP_LOCAL_EE_CONTEXT_NUMBER, cm_rep_set_local_eecn);
 	IBA_CHECK_GET_BE(CM_REP_STARTING_PSN, cm_rep_get_starting_psn);
 	IBA_CHECK_SET_BE(CM_REP_STARTING_PSN, cm_rep_set_starting_psn);
-	IBA_CHECK_GET(CM_REP_TARGET_ACK_DELAY, cm_rep_get_target_ack_delay);
-	IBA_CHECK_SET(CM_REP_TARGET_ACK_DELAY, cm_rep_set_target_ack_delay);
-	IBA_CHECK_GET(CM_REP_FAILOVER_ACCEPTED, cm_rep_get_failover);
-	IBA_CHECK_SET(CM_REP_FAILOVER_ACCEPTED, cm_rep_set_failover);
-	IBA_CHECK_GET(CM_REP_END_TO_END_FLOW_CONTROL, cm_rep_get_flow_ctrl);
-	IBA_CHECK_SET(CM_REP_END_TO_END_FLOW_CONTROL, cm_rep_set_flow_ctrl);
-	IBA_CHECK_GET(CM_REP_RNR_RETRY_COUNT, cm_rep_get_rnr_retry_count);
-	IBA_CHECK_SET(CM_REP_RNR_RETRY_COUNT, cm_rep_set_rnr_retry_count);
-	IBA_CHECK_GET(CM_REP_SRQ, cm_rep_get_srq);
-	IBA_CHECK_SET(CM_REP_SRQ, cm_rep_set_srq);
 	IBA_CHECK_GET_BE(CM_DREQ_REMOTE_QPN_EECN, cm_dreq_get_remote_qpn);
 	IBA_CHECK_SET_BE(CM_DREQ_REMOTE_QPN_EECN, cm_dreq_set_remote_qpn);
 	IBA_CHECK_GET_BE(CM_LAP_ALTERNATE_FLOW_LABEL, cm_lap_get_flow_label);
-	IBA_CHECK_GET(CM_LAP_ALTERNATE_TRAFFIC_CLASS, cm_lap_get_traffic_class);
-	IBA_CHECK_GET(CM_LAP_ALTERNATE_PACKET_RATE, cm_lap_get_packet_rate);
-	IBA_CHECK_GET(CM_LAP_ALTERNATE_SL, cm_lap_get_sl);
-	IBA_CHECK_GET(CM_LAP_ALTERNATE_LOCAL_ACK_TIMEOUT, cm_lap_get_local_ack_timeout);
 	IBA_CHECK_GET_BE(CM_SIDR_REP_QPN, cm_sidr_rep_get_qpn);
 	IBA_CHECK_SET_BE(CM_SIDR_REP_QPN, cm_sidr_rep_set_qpn);
 	printk("Success!\n");
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index bf62461d801fa3..d30586b1b8a475 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -87,75 +87,14 @@ static inline void cm_req_set_local_qpn(struct cm_req_msg *req_msg, __be32 qpn)
 					  0x000000FF));
 }
 
-static inline u8 cm_req_get_resp_res(struct cm_req_msg *req_msg)
-{
-	return (u8) be32_to_cpu(req_msg->offset32);
-}
-
-static inline void cm_req_set_resp_res(struct cm_req_msg *req_msg, u8 resp_res)
-{
-	req_msg->offset32 = cpu_to_be32(resp_res |
-					(be32_to_cpu(req_msg->offset32) &
-					 0xFFFFFF00));
-}
-
-static inline u8 cm_req_get_init_depth(struct cm_req_msg *req_msg)
-{
-	return (u8) be32_to_cpu(req_msg->offset36);
-}
-
-static inline void cm_req_set_init_depth(struct cm_req_msg *req_msg,
-					 u8 init_depth)
-{
-	req_msg->offset36 = cpu_to_be32(init_depth |
-					(be32_to_cpu(req_msg->offset36) &
-					 0xFFFFFF00));
-}
-
-static inline u8 cm_req_get_remote_resp_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) ((be32_to_cpu(req_msg->offset40) & 0xF8) >> 3);
-}
-
-static inline void cm_req_set_remote_resp_timeout(struct cm_req_msg *req_msg,
-						  u8 resp_timeout)
-{
-	req_msg->offset40 = cpu_to_be32((resp_timeout << 3) |
-					 (be32_to_cpu(req_msg->offset40) &
-					  0xFFFFFF07));
-}
-
-static inline u8 cm_req_get_transport_type(struct cm_req_msg *req_msg)
-{
-	return (u8) ((be32_to_cpu(req_msg->offset40) & 0x06) >> 1);
-}
-
-static inline void cm_req_set_transport_type(struct cm_req_msg *req_msg, u8 val)
-{
-	req_msg->offset40 =
-		cpu_to_be32((be32_to_cpu(req_msg->offset40) & 0xFFFFFFF9) |
-		(val << 1));
-}
-
-static inline u8 cm_req_get_transport_type_ex(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset51 & 0x7;
-}
-
-static inline void cm_req_set_transport_type_ex(struct cm_req_msg *req_msg,
-						u8 val)
-{
-	req_msg->offset51 = (req_msg->offset51 & 0xF8) | val;
-}
-
 static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
 {
-	u8 transport_type = cm_req_get_transport_type(req_msg);
+	u8 transport_type = IBA_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg);
 	switch(transport_type) {
 	case 0: return IB_QPT_RC;
 	case 1: return IB_QPT_UC;
 	case 3:
-		switch (cm_req_get_transport_type_ex(req_msg)) {
+		switch (IBA_GET(CM_REQ_EXTENDED_TRANSPORT_TYPE, req_msg)) {
 		case 1: return IB_QPT_XRC_TGT;
 		default: return 0;
 		}
@@ -168,30 +107,17 @@ static inline void cm_req_set_qp_type(struct cm_req_msg *req_msg,
 {
 	switch(qp_type) {
 	case IB_QPT_UC:
-		cm_req_set_transport_type(req_msg, 1);
+		IBA_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg, 1);
 		break;
 	case IB_QPT_XRC_INI:
-		cm_req_set_transport_type(req_msg, 3);
-		cm_req_set_transport_type_ex(req_msg, 1);
+		IBA_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg, 3);
+		IBA_SET(CM_REQ_EXTENDED_TRANSPORT_TYPE, req_msg, 1);
 		break;
 	default:
-		cm_req_set_transport_type(req_msg, 0);
+		IBA_SET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg, 0);
 	}
 }
 
-static inline u8 cm_req_get_flow_ctrl(struct cm_req_msg *req_msg)
-{
-	return be32_to_cpu(req_msg->offset40) & 0x1;
-}
-
-static inline void cm_req_set_flow_ctrl(struct cm_req_msg *req_msg,
-					u8 flow_ctrl)
-{
-	req_msg->offset40 = cpu_to_be32((flow_ctrl & 0x1) |
-					 (be32_to_cpu(req_msg->offset40) &
-					  0xFFFFFFFE));
-}
-
 static inline __be32 cm_req_get_starting_psn(struct cm_req_msg *req_msg)
 {
 	return cpu_to_be32(be32_to_cpu(req_msg->offset44) >> 8);
@@ -204,74 +130,6 @@ static inline void cm_req_set_starting_psn(struct cm_req_msg *req_msg,
 			    (be32_to_cpu(req_msg->offset44) & 0x000000FF));
 }
 
-static inline u8 cm_req_get_local_resp_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) ((be32_to_cpu(req_msg->offset44) & 0xF8) >> 3);
-}
-
-static inline void cm_req_set_local_resp_timeout(struct cm_req_msg *req_msg,
-						 u8 resp_timeout)
-{
-	req_msg->offset44 = cpu_to_be32((resp_timeout << 3) |
-			    (be32_to_cpu(req_msg->offset44) & 0xFFFFFF07));
-}
-
-static inline u8 cm_req_get_retry_count(struct cm_req_msg *req_msg)
-{
-	return (u8) (be32_to_cpu(req_msg->offset44) & 0x7);
-}
-
-static inline void cm_req_set_retry_count(struct cm_req_msg *req_msg,
-					  u8 retry_count)
-{
-	req_msg->offset44 = cpu_to_be32((retry_count & 0x7) |
-			    (be32_to_cpu(req_msg->offset44) & 0xFFFFFFF8));
-}
-
-static inline u8 cm_req_get_path_mtu(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset50 >> 4;
-}
-
-static inline void cm_req_set_path_mtu(struct cm_req_msg *req_msg, u8 path_mtu)
-{
-	req_msg->offset50 = (u8) ((req_msg->offset50 & 0xF) | (path_mtu << 4));
-}
-
-static inline u8 cm_req_get_rnr_retry_count(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset50 & 0x7;
-}
-
-static inline void cm_req_set_rnr_retry_count(struct cm_req_msg *req_msg,
-					      u8 rnr_retry_count)
-{
-	req_msg->offset50 = (u8) ((req_msg->offset50 & 0xF8) |
-				  (rnr_retry_count & 0x7));
-}
-
-static inline u8 cm_req_get_max_cm_retries(struct cm_req_msg *req_msg)
-{
-	return req_msg->offset51 >> 4;
-}
-
-static inline void cm_req_set_max_cm_retries(struct cm_req_msg *req_msg,
-					     u8 retries)
-{
-	req_msg->offset51 = (u8) ((req_msg->offset51 & 0xF) | (retries << 4));
-}
-
-static inline u8 cm_req_get_srq(struct cm_req_msg *req_msg)
-{
-	return (req_msg->offset51 & 0x8) >> 3;
-}
-
-static inline void cm_req_set_srq(struct cm_req_msg *req_msg, u8 srq)
-{
-	req_msg->offset51 = (u8) ((req_msg->offset51 & 0xF7) |
-				  ((srq & 0x1) << 3));
-}
-
 static inline __be32 cm_req_get_primary_flow_label(struct cm_req_msg *req_msg)
 {
 	return cpu_to_be32(be32_to_cpu(req_msg->primary_offset88) >> 12);
@@ -286,54 +144,6 @@ static inline void cm_req_set_primary_flow_label(struct cm_req_msg *req_msg,
 				     (be32_to_cpu(flow_label) << 12));
 }
 
-static inline u8 cm_req_get_primary_packet_rate(struct cm_req_msg *req_msg)
-{
-	return (u8) (be32_to_cpu(req_msg->primary_offset88) & 0x3F);
-}
-
-static inline void cm_req_set_primary_packet_rate(struct cm_req_msg *req_msg,
-						  u8 rate)
-{
-	req_msg->primary_offset88 = cpu_to_be32(
-				    (be32_to_cpu(req_msg->primary_offset88) &
-				     0xFFFFFFC0) | (rate & 0x3F));
-}
-
-static inline u8 cm_req_get_primary_sl(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->primary_offset94 >> 4);
-}
-
-static inline void cm_req_set_primary_sl(struct cm_req_msg *req_msg, u8 sl)
-{
-	req_msg->primary_offset94 = (u8) ((req_msg->primary_offset94 & 0x0F) |
-					  (sl << 4));
-}
-
-static inline u8 cm_req_get_primary_subnet_local(struct cm_req_msg *req_msg)
-{
-	return (u8) ((req_msg->primary_offset94 & 0x08) >> 3);
-}
-
-static inline void cm_req_set_primary_subnet_local(struct cm_req_msg *req_msg,
-						   u8 subnet_local)
-{
-	req_msg->primary_offset94 = (u8) ((req_msg->primary_offset94 & 0xF7) |
-					  ((subnet_local & 0x1) << 3));
-}
-
-static inline u8 cm_req_get_primary_local_ack_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->primary_offset95 >> 3);
-}
-
-static inline void cm_req_set_primary_local_ack_timeout(struct cm_req_msg *req_msg,
-							u8 local_ack_timeout)
-{
-	req_msg->primary_offset95 = (u8) ((req_msg->primary_offset95 & 0x07) |
-					  (local_ack_timeout << 3));
-}
-
 static inline __be32 cm_req_get_alt_flow_label(struct cm_req_msg *req_msg)
 {
 	return cpu_to_be32(be32_to_cpu(req_msg->alt_offset132) >> 12);
@@ -348,54 +158,6 @@ static inline void cm_req_set_alt_flow_label(struct cm_req_msg *req_msg,
 				  (be32_to_cpu(flow_label) << 12));
 }
 
-static inline u8 cm_req_get_alt_packet_rate(struct cm_req_msg *req_msg)
-{
-	return (u8) (be32_to_cpu(req_msg->alt_offset132) & 0x3F);
-}
-
-static inline void cm_req_set_alt_packet_rate(struct cm_req_msg *req_msg,
-					      u8 rate)
-{
-	req_msg->alt_offset132 = cpu_to_be32(
-				 (be32_to_cpu(req_msg->alt_offset132) &
-				  0xFFFFFFC0) | (rate & 0x3F));
-}
-
-static inline u8 cm_req_get_alt_sl(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->alt_offset138 >> 4);
-}
-
-static inline void cm_req_set_alt_sl(struct cm_req_msg *req_msg, u8 sl)
-{
-	req_msg->alt_offset138 = (u8) ((req_msg->alt_offset138 & 0x0F) |
-				       (sl << 4));
-}
-
-static inline u8 cm_req_get_alt_subnet_local(struct cm_req_msg *req_msg)
-{
-	return (u8) ((req_msg->alt_offset138 & 0x08) >> 3);
-}
-
-static inline void cm_req_set_alt_subnet_local(struct cm_req_msg *req_msg,
-					       u8 subnet_local)
-{
-	req_msg->alt_offset138 = (u8) ((req_msg->alt_offset138 & 0xF7) |
-				       ((subnet_local & 0x1) << 3));
-}
-
-static inline u8 cm_req_get_alt_local_ack_timeout(struct cm_req_msg *req_msg)
-{
-	return (u8) (req_msg->alt_offset139 >> 3);
-}
-
-static inline void cm_req_set_alt_local_ack_timeout(struct cm_req_msg *req_msg,
-						    u8 local_ack_timeout)
-{
-	req_msg->alt_offset139 = (u8) ((req_msg->alt_offset139 & 0x07) |
-				       (local_ack_timeout << 3));
-}
-
 /* Message REJected or MRAed */
 enum cm_msg_response {
 	CM_MSG_RESPONSE_REQ = 0x0,
@@ -417,28 +179,6 @@ enum cm_msg_response {
 
 } __packed;
 
-static inline u8 cm_mra_get_msg_mraed(struct cm_mra_msg *mra_msg)
-{
-	return (u8) (mra_msg->offset8 >> 6);
-}
-
-static inline void cm_mra_set_msg_mraed(struct cm_mra_msg *mra_msg, u8 msg)
-{
-	mra_msg->offset8 = (u8) ((mra_msg->offset8 & 0x3F) | (msg << 6));
-}
-
-static inline u8 cm_mra_get_service_timeout(struct cm_mra_msg *mra_msg)
-{
-	return (u8) (mra_msg->offset9 >> 3);
-}
-
-static inline void cm_mra_set_service_timeout(struct cm_mra_msg *mra_msg,
-					      u8 service_timeout)
-{
-	mra_msg->offset9 = (u8) ((mra_msg->offset9 & 0x07) |
-				 (service_timeout << 3));
-}
-
 struct cm_rej_msg {
 	struct ib_mad_hdr hdr;
 
@@ -455,27 +195,6 @@ struct cm_rej_msg {
 
 } __packed;
 
-static inline u8 cm_rej_get_msg_rejected(struct cm_rej_msg *rej_msg)
-{
-	return (u8) (rej_msg->offset8 >> 6);
-}
-
-static inline void cm_rej_set_msg_rejected(struct cm_rej_msg *rej_msg, u8 msg)
-{
-	rej_msg->offset8 = (u8) ((rej_msg->offset8 & 0x3F) | (msg << 6));
-}
-
-static inline u8 cm_rej_get_reject_info_len(struct cm_rej_msg *rej_msg)
-{
-	return (u8) (rej_msg->offset9 >> 1);
-}
-
-static inline void cm_rej_set_reject_info_len(struct cm_rej_msg *rej_msg,
-					      u8 len)
-{
-	rej_msg->offset9 = (u8) ((rej_msg->offset9 & 0x1) | (len << 1));
-}
-
 struct cm_rep_msg {
 	struct ib_mad_hdr hdr;
 
@@ -540,64 +259,6 @@ static inline void cm_rep_set_starting_psn(struct cm_rep_msg *rep_msg,
 			    (be32_to_cpu(rep_msg->offset20) & 0x000000FF));
 }
 
-static inline u8 cm_rep_get_target_ack_delay(struct cm_rep_msg *rep_msg)
-{
-	return (u8) (rep_msg->offset26 >> 3);
-}
-
-static inline void cm_rep_set_target_ack_delay(struct cm_rep_msg *rep_msg,
-					       u8 target_ack_delay)
-{
-	rep_msg->offset26 = (u8) ((rep_msg->offset26 & 0x07) |
-				  (target_ack_delay << 3));
-}
-
-static inline u8 cm_rep_get_failover(struct cm_rep_msg *rep_msg)
-{
-	return (u8) ((rep_msg->offset26 & 0x06) >> 1);
-}
-
-static inline void cm_rep_set_failover(struct cm_rep_msg *rep_msg, u8 failover)
-{
-	rep_msg->offset26 = (u8) ((rep_msg->offset26 & 0xF9) |
-				  ((failover & 0x3) << 1));
-}
-
-static inline u8 cm_rep_get_flow_ctrl(struct cm_rep_msg *rep_msg)
-{
-	return (u8) (rep_msg->offset26 & 0x01);
-}
-
-static inline void cm_rep_set_flow_ctrl(struct cm_rep_msg *rep_msg,
-					    u8 flow_ctrl)
-{
-	rep_msg->offset26 = (u8) ((rep_msg->offset26 & 0xFE) |
-				  (flow_ctrl & 0x1));
-}
-
-static inline u8 cm_rep_get_rnr_retry_count(struct cm_rep_msg *rep_msg)
-{
-	return (u8) (rep_msg->offset27 >> 5);
-}
-
-static inline void cm_rep_set_rnr_retry_count(struct cm_rep_msg *rep_msg,
-					      u8 rnr_retry_count)
-{
-	rep_msg->offset27 = (u8) ((rep_msg->offset27 & 0x1F) |
-				  (rnr_retry_count << 5));
-}
-
-static inline u8 cm_rep_get_srq(struct cm_rep_msg *rep_msg)
-{
-	return (u8) ((rep_msg->offset27 >> 4) & 0x1);
-}
-
-static inline void cm_rep_set_srq(struct cm_rep_msg *rep_msg, u8 srq)
-{
-	rep_msg->offset27 = (u8) ((rep_msg->offset27 & 0xEF) |
-				  ((srq & 0x1) << 4));
-}
-
 struct cm_rtu_msg {
 	struct ib_mad_hdr hdr;
 
@@ -674,26 +335,6 @@ static inline __be32 cm_lap_get_flow_label(struct cm_lap_msg *lap_msg)
 	return cpu_to_be32(be32_to_cpu(lap_msg->offset56) >> 12);
 }
 
-static inline u8 cm_lap_get_traffic_class(struct cm_lap_msg *lap_msg)
-{
-	return (u8) be32_to_cpu(lap_msg->offset56);
-}
-
-static inline u8 cm_lap_get_packet_rate(struct cm_lap_msg *lap_msg)
-{
-	return lap_msg->offset61 & 0x3F;
-}
-
-static inline u8 cm_lap_get_sl(struct cm_lap_msg *lap_msg)
-{
-	return lap_msg->offset62 >> 4;
-}
-
-static inline u8 cm_lap_get_local_ack_timeout(struct cm_lap_msg *lap_msg)
-{
-	return lap_msg->offset63 >> 3;
-}
-
 struct cm_apr_msg {
 	struct ib_mad_hdr hdr;
 
-- 
2.24.1

