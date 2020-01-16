Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1218613F712
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:09:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387916AbgAPRAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 12:00:49 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45538 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733277AbgAPRAs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:48 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so19721201qkl.12
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yZYacYwa9ckXtiCq/Q0DVSTukqFW2RfQsiEsPfWTHK4=;
        b=XdClobSUrFLkpNmKB8qeCbb+fApCsR+lHQLim/lABRd4Sqb3fBlxBL2S0PzPmixgfu
         nLTByHeweBUODJs5fQQDpdHbC5aIfPnTZjnqFdji47zVFMTvVJgajxAM0G5e7aepQ0Ic
         K801z0jc3aW8l/qJuH0e12tt7naLW9Bie2Fo4aun8xHsGA7cCqwuUF+Rwy94/WTaKnLJ
         KxVyZC1WjDxSCXkcKHkWJwxlJBTqT9eeDUCe5dwdIePDGK9RlC38D5dnGSAXPco8AmxP
         Phf7p3jCTb5cLuUIeCRdBPHLIUj8kFVo8vuEm8Rsg3gkiT++S71PwEvonwWgnk9lmF4P
         EA+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yZYacYwa9ckXtiCq/Q0DVSTukqFW2RfQsiEsPfWTHK4=;
        b=tpaH8RrdR+YVV2lnB14OedtkDtzT6m9AgMVoPgbklC1MfQmCIn96bx1aotLRPHyrYC
         MXiEfMjMaCUjmthQiuKPMzA2ow0xwMlgRFtl3Ud6MuYO3cSOW8d/o6FeZlEq+eSbVzVt
         aDm/OEAfx00Ct7Vy6B5He/OOJR3yM3yHrFsDqLEEkJEhSmixZHh2J91MlFupE2qSZ/Ec
         buiEdGAnPwLCdob/MfRXluj9WYH25wglw+GZ2ms1jAlVP+G3UJlyGsmrgLrVWV3smA+X
         r0CZCheHfUkLA8berwlseAQy5tkFVYBdOowrvMpIUjuUkanIeoR/7GtY341zaAZXGnGx
         dByA==
X-Gm-Message-State: APjAAAX8vQHn7iu13k+RD8/rcu/f37A0WVxLWuAXE4L6tFLK4+8aSVDS
        5XF1Ybr1ucUnoWcAHWXHdjkf+KL4Eo4=
X-Google-Smtp-Source: APXvYqz3uhOWtQjH94NbvM+Fchq/61HWgLuqgu1VcGGIWJUnlPTfGizyJixQZwayoijdexTC4Xxkuw==
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr33930629qka.286.1579194046569;
        Thu, 16 Jan 2020 09:00:46 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d184sm10463220qkb.128.2020.01.16.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vc-0007tU-59; Thu, 16 Jan 2020 13:00:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4/7] RDMA/cm: Use IBA functions for swapping get/set acessors
Date:   Thu, 16 Jan 2020 13:00:34 -0400
Message-Id: <20200116170037.30109-5-jgg@ziepe.ca>
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

Use a Coccinelle spatch script to replace CM helper functions that
return/accept BE values with IBA_GET/SET versions. Applied with

$ spatch --sp-file edits.sp --in-place drivers/infiniband/core/cm.c

The spatch file was generated using the template pattern:

@@
expression val;
{struct} *msg;
@@
- {old_setter}(msg, val)
+ IBA_SET({new_name}, msg, be{bits}_to_cpu(val))
@@
{struct} *msg;
@@
- {old_getter}(msg)
+ cpu_to_be{bits}(IBA_GET({new_name}, msg))

Iterated for every IBA_CHECK_GET_BE()/IBA_CHECK_SET_BE() pairing.

And the below iterated over all byte sizes to remove doubled byte swaps:

@@
expression val;
@@
-be{bits}_to_cpu(cpu_to_be{bits}(val))
+val

(and __be_to_cpu and ntoh varients)

Touched up with clang-format after.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c      | 186 ++++++------------------------
 drivers/infiniband/core/cm_msgs.h | 119 +------------------
 2 files changed, 36 insertions(+), 269 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index a1a9681601329a..976bb85b6aa6a4 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1254,13 +1254,13 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	req_msg->local_comm_id = cm_id_priv->id.local_id;
 	req_msg->service_id = param->service_id;
 	req_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
-	cm_req_set_local_qpn(req_msg, cpu_to_be32(param->qp_num));
+	IBA_SET(CM_REQ_LOCAL_QPN, req_msg, param->qp_num);
 	IBA_SET(CM_REQ_INITIATOR_DEPTH, req_msg, param->initiator_depth);
 	IBA_SET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg,
 		param->remote_cm_response_timeout);
 	cm_req_set_qp_type(req_msg, param->qp_type);
 	IBA_SET(CM_REQ_END_TO_END_FLOW_CONTROL, req_msg, param->flow_control);
-	cm_req_set_starting_psn(req_msg, cpu_to_be32(param->starting_psn));
+	IBA_SET(CM_REQ_STARTING_PSN, req_msg, param->starting_psn);
 	IBA_SET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg,
 		param->local_cm_response_timeout);
 	req_msg->pkey = param->primary_path->pkey;
@@ -1295,7 +1295,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		req_msg->primary_local_lid = IB_LID_PERMISSIVE;
 		req_msg->primary_remote_lid = IB_LID_PERMISSIVE;
 	}
-	cm_req_set_primary_flow_label(req_msg, pri_path->flow_label);
+	IBA_SET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg,
+		be32_to_cpu(pri_path->flow_label));
 	IBA_SET(CM_REQ_PRIMARY_PACKET_RATE, req_msg, pri_path->rate);
 	req_msg->primary_traffic_class = pri_path->traffic_class;
 	req_msg->primary_hop_limit = pri_path->hop_limit;
@@ -1330,8 +1331,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 			req_msg->alt_local_lid = IB_LID_PERMISSIVE;
 			req_msg->alt_remote_lid = IB_LID_PERMISSIVE;
 		}
-		cm_req_set_alt_flow_label(req_msg,
-					  alt_path->flow_label);
+		IBA_SET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg,
+			be32_to_cpu(alt_path->flow_label));
 		IBA_SET(CM_REQ_ALTERNATE_PACKET_RATE, req_msg, alt_path->rate);
 		req_msg->alt_traffic_class = alt_path->traffic_class;
 		req_msg->alt_hop_limit = alt_path->hop_limit;
@@ -1437,8 +1438,8 @@ int ib_send_cm_req(struct ib_cm_id *cm_id,
 	cm_id_priv->msg->timeout_ms = cm_id_priv->timeout_ms;
 	cm_id_priv->msg->context[1] = (void *) (unsigned long) IB_CM_REQ_SENT;
 
-	cm_id_priv->local_qpn = cm_req_get_local_qpn(req_msg);
-	cm_id_priv->rq_psn = cm_req_get_starting_psn(req_msg);
+	cm_id_priv->local_qpn = cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
+	cm_id_priv->rq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
 
 	spin_lock_irqsave(&cm_id_priv->lock, flags);
 	ret = ib_post_send_mad(cm_id_priv->msg, NULL);
@@ -1548,7 +1549,8 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 {
 	primary_path->dgid = req_msg->primary_local_gid;
 	primary_path->sgid = req_msg->primary_remote_gid;
-	primary_path->flow_label = cm_req_get_primary_flow_label(req_msg);
+	primary_path->flow_label =
+		cpu_to_be32(IBA_GET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg));
 	primary_path->hop_limit = req_msg->primary_hop_limit;
 	primary_path->traffic_class = req_msg->primary_traffic_class;
 	primary_path->reversible = 1;
@@ -1569,7 +1571,8 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	if (cm_req_has_alt_path(req_msg)) {
 		alt_path->dgid = req_msg->alt_local_gid;
 		alt_path->sgid = req_msg->alt_remote_gid;
-		alt_path->flow_label = cm_req_get_alt_flow_label(req_msg);
+		alt_path->flow_label = cpu_to_be32(
+			IBA_GET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg));
 		alt_path->hop_limit = req_msg->alt_hop_limit;
 		alt_path->traffic_class = req_msg->alt_traffic_class;
 		alt_path->reversible = 1;
@@ -1661,9 +1664,9 @@ static void cm_format_req_event(struct cm_work *work,
 	}
 	param->remote_ca_guid = req_msg->local_ca_guid;
 	param->remote_qkey = be32_to_cpu(req_msg->local_qkey);
-	param->remote_qpn = be32_to_cpu(cm_req_get_local_qpn(req_msg));
+	param->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	param->qp_type = cm_req_get_qp_type(req_msg);
-	param->starting_psn = be32_to_cpu(cm_req_get_starting_psn(req_msg));
+	param->starting_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
 	param->responder_resources = IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	param->initiator_depth = IBA_GET(CM_REQ_RESPONDER_RESOURCES, req_msg);
 	param->local_cm_response_timeout =
@@ -1924,7 +1927,8 @@ static int cm_req_handler(struct cm_work *work)
 	}
 	cm_id_priv->timewait_info->work.remote_id = req_msg->local_comm_id;
 	cm_id_priv->timewait_info->remote_ca_guid = req_msg->local_ca_guid;
-	cm_id_priv->timewait_info->remote_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->timewait_info->remote_qpn =
+		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
 
 	listen_cm_id_priv = cm_match_req(work, cm_id_priv);
 	if (!listen_cm_id_priv) {
@@ -1998,14 +2002,15 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->timeout_ms = cm_convert_to_ms(
 		IBA_GET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg));
 	cm_id_priv->max_cm_retries = IBA_GET(CM_REQ_MAX_CM_RETRIES, req_msg);
-	cm_id_priv->remote_qpn = cm_req_get_local_qpn(req_msg);
+	cm_id_priv->remote_qpn =
+		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
 	cm_id_priv->initiator_depth =
 		IBA_GET(CM_REQ_RESPONDER_RESOURCES, req_msg);
 	cm_id_priv->responder_resources =
 		IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	cm_id_priv->path_mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
 	cm_id_priv->pkey = req_msg->pkey;
-	cm_id_priv->sq_psn = cm_req_get_starting_psn(req_msg);
+	cm_id_priv->sq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
 	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
 	cm_id_priv->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	cm_id_priv->qp_type = cm_req_get_qp_type(req_msg);
@@ -2032,7 +2037,7 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	cm_format_mad_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid);
 	rep_msg->local_comm_id = cm_id_priv->id.local_id;
 	rep_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_rep_set_starting_psn(rep_msg, cpu_to_be32(param->starting_psn));
+	IBA_SET(CM_REP_STARTING_PSN, rep_msg, param->starting_psn);
 	rep_msg->resp_resources = param->responder_resources;
 	IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
 		cm_id_priv->av.port->cm_dev->ack_delay);
@@ -2045,10 +2050,10 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 		IBA_SET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg,
 			param->flow_control);
 		IBA_SET(CM_REP_SRQ, rep_msg, param->srq);
-		cm_rep_set_local_qpn(rep_msg, cpu_to_be32(param->qp_num));
+		IBA_SET(CM_REP_LOCAL_QPN, rep_msg, param->qp_num);
 	} else {
 		IBA_SET(CM_REP_SRQ, rep_msg, 1);
-		cm_rep_set_local_eecn(rep_msg, cpu_to_be32(param->qp_num));
+		IBA_SET(CM_REP_LOCAL_EE_CONTEXT_NUMBER, rep_msg, param->qp_num);
 	}
 
 	if (param->private_data && param->private_data_len)
@@ -2099,7 +2104,7 @@ int ib_send_cm_rep(struct ib_cm_id *cm_id,
 	cm_id_priv->msg = msg;
 	cm_id_priv->initiator_depth = param->initiator_depth;
 	cm_id_priv->responder_resources = param->responder_resources;
-	cm_id_priv->rq_psn = cm_rep_get_starting_psn(rep_msg);
+	cm_id_priv->rq_psn = cpu_to_be32(IBA_GET(CM_REP_STARTING_PSN, rep_msg));
 	cm_id_priv->local_qpn = cpu_to_be32(param->qp_num & 0xFFFFFF);
 
 out:	spin_unlock_irqrestore(&cm_id_priv->lock, flags);
@@ -2183,7 +2188,7 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->remote_ca_guid = rep_msg->local_ca_guid;
 	param->remote_qkey = be32_to_cpu(rep_msg->local_qkey);
 	param->remote_qpn = be32_to_cpu(cm_rep_get_qpn(rep_msg, qp_type));
-	param->starting_psn = be32_to_cpu(cm_rep_get_starting_psn(rep_msg));
+	param->starting_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
 	param->responder_resources = rep_msg->initiator_depth;
 	param->initiator_depth = rep_msg->resp_resources;
 	param->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
@@ -2320,7 +2325,7 @@ static int cm_rep_handler(struct cm_work *work)
 	cm_id_priv->remote_qpn = cm_rep_get_qpn(rep_msg, cm_id_priv->qp_type);
 	cm_id_priv->initiator_depth = rep_msg->resp_resources;
 	cm_id_priv->responder_resources = rep_msg->initiator_depth;
-	cm_id_priv->sq_psn = cm_rep_get_starting_psn(rep_msg);
+	cm_id_priv->sq_psn = cpu_to_be32(IBA_GET(CM_REP_STARTING_PSN, rep_msg));
 	cm_id_priv->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
 	cm_id_priv->target_ack_delay =
 		IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
@@ -2431,7 +2436,8 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 			  cm_form_tid(cm_id_priv));
 	dreq_msg->local_comm_id = cm_id_priv->id.local_id;
 	dreq_msg->remote_comm_id = cm_id_priv->id.remote_id;
-	cm_dreq_set_remote_qpn(dreq_msg, cm_id_priv->remote_qpn);
+	IBA_SET(CM_DREQ_REMOTE_QPN_EECN, dreq_msg,
+		be32_to_cpu(cm_id_priv->remote_qpn));
 
 	if (private_data && private_data_len)
 		memcpy(dreq_msg->private_data, private_data, private_data_len);
@@ -2599,7 +2605,8 @@ static int cm_dreq_handler(struct cm_work *work)
 	work->cm_event.private_data = &dreq_msg->private_data;
 
 	spin_lock_irq(&cm_id_priv->lock);
-	if (cm_id_priv->local_qpn != cm_dreq_get_remote_qpn(dreq_msg))
+	if (cm_id_priv->local_qpn !=
+	    cpu_to_be32(IBA_GET(CM_DREQ_REMOTE_QPN_EECN, dreq_msg)))
 		goto unlock;
 
 	switch (cm_id_priv->id.state) {
@@ -3067,7 +3074,8 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 {
 	path->dgid = lap_msg->alt_local_gid;
 	path->sgid = lap_msg->alt_remote_gid;
-	path->flow_label = cm_lap_get_flow_label(lap_msg);
+	path->flow_label =
+		cpu_to_be32(IBA_GET(CM_LAP_ALTERNATE_FLOW_LABEL, lap_msg));
 	path->hop_limit = lap_msg->alt_hop_limit;
 	path->traffic_class = IBA_GET(CM_LAP_ALTERNATE_TRAFFIC_CLASS, lap_msg);
 	path->reversible = 1;
@@ -3423,7 +3431,7 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 			  cm_id_priv->tid);
 	sidr_rep_msg->request_id = cm_id_priv->id.remote_id;
 	sidr_rep_msg->status = param->status;
-	cm_sidr_rep_set_qpn(sidr_rep_msg, cpu_to_be32(param->qp_num));
+	IBA_SET(CM_SIDR_REP_QPN, sidr_rep_msg, param->qp_num);
 	sidr_rep_msg->service_id = cm_id_priv->id.service_id;
 	sidr_rep_msg->qkey = cpu_to_be32(param->qkey);
 
@@ -3494,7 +3502,7 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	param = &work->cm_event.param.sidr_rep_rcvd;
 	param->status = sidr_rep_msg->status;
 	param->qkey = be32_to_cpu(sidr_rep_msg->qkey);
-	param->qpn = be32_to_cpu(cm_sidr_rep_get_qpn(sidr_rep_msg));
+	param->qpn = IBA_GET(CM_SIDR_REP_QPN, sidr_rep_msg);
 	param->info = &sidr_rep_msg->info;
 	param->info_len = sidr_rep_msg->info_length;
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
@@ -4346,138 +4354,10 @@ IBA_CHECK_OFF(CM_SIDR_REP_Q_KEY, qkey);
 IBA_CHECK_OFF(CM_SIDR_REP_ADDITIONAL_INFORMATION, info);
 IBA_CHECK_OFF(CM_SIDR_REP_PRIVATE_DATA, private_data);
 
-/*
- * Check that the new macro gets the same bits as the old get function.
- *  - IBA_SET() IBA_GET and old get_fn all agree on the field width.
- *    The field width should match what IBA_SET truncates to
- *  - Reading from an all ones data should not return extra bits
- *  - Setting '1' should be the same (ie no endian problems)
- */
-/* defeat builtin_constant checks */
-u64 cm_global_all_ones = 0xffffffffffffffffULL;
-#define _IBA_CHECK_GET(fn, field_struct, field_offset, mask, bits)             \
-	({                                                                     \
-		field_struct *lmsg = (field_struct *)msg;                      \
-		unsigned long long all_ones;                                   \
-		static_assert(sizeof(*lmsg) <= sizeof(msg));                   \
-                                                                               \
-		bitmap_zero(msg, nbits);                                       \
-		_IBA_SET(field_struct, field_offset, mask, bits, lmsg,         \
-			 cm_global_all_ones);                                  \
-		all_ones = (1ULL << bitmap_weight(msg, nbits)) - 1;            \
-		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
-		    all_ones) {                                                \
-			printk("Failed #1 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-		if (fn != all_ones) {                                          \
-			printk("Failed #2 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-                                                                               \
-		bitmap_fill(msg, nbits);                                       \
-		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
-		    all_ones) {                                                \
-			printk("Failed #3 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-		if (fn != all_ones) {                                          \
-			printk("Failed #4 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-                                                                               \
-		_IBA_SET(field_struct, field_offset, mask, bits, lmsg, 0);     \
-		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
-		    0) {                                                       \
-			printk("Failed #5 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-		if (fn != 0) {                                                 \
-			printk("Failed #6 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-		_IBA_SET(field_struct, field_offset, mask, bits, lmsg, 1);     \
-		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
-		    1) {                                                       \
-			printk("Failed #7 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-		if (fn != 1) {                                                 \
-			printk("Failed #8 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-	})
-#define IBA_CHECK_GET(field, fn_name) _IBA_CHECK_GET(fn_name(lmsg), field)
-#define IBA_CHECK_GET_BE(field, fn_name) _IBA_CHECK_GET(be32_to_cpu(fn_name(lmsg)), field)
-
-/*
- * Write the all ones value using the old setter and check that the new getter
- * reads it back.
- */
-#define _IBA_CHECK_SET(fn, field_struct, field_offset, mask, bits)             \
-	({                                                                     \
-		field_struct *lmsg = (field_struct *)msg;                      \
-		unsigned long long all_ones;                                   \
-		static_assert(sizeof(*lmsg) <= sizeof(msg));                   \
-                                                                               \
-		bitmap_zero(msg, nbits);                                       \
-		_IBA_SET(field_struct, field_offset, mask, bits, lmsg,         \
-			 cm_global_all_ones);                                  \
-		all_ones = (1ULL << bitmap_weight(msg, nbits)) - 1;            \
-		bitmap_zero(msg, nbits);                                       \
-		fn;                                                            \
-		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
-		    all_ones) {                                                \
-			printk("Failed #9 line=%u\n", __LINE__);               \
-			return;                                                \
-		}                                                              \
-		all_ones = 1;                                                  \
-		fn;                                                            \
-		if (_IBA_GET(field_struct, field_offset, mask, bits, lmsg) !=  \
-		    1) {                                                       \
-			printk("Failed #10 line=%u\n", __LINE__);              \
-			return;                                                \
-		}                                                              \
-	})
-
-#define IBA_CHECK_SET(field, fn_name) _IBA_CHECK_SET(fn_name(lmsg, all_ones), field)
-#define IBA_CHECK_SET_BE(field, fn_name)                                       \
-	_IBA_CHECK_SET(fn_name(lmsg, cpu_to_be32(all_ones)), field)
-
-static void self_test(void)
-{
-	unsigned long msg[256/4];
-	const unsigned int nbits = sizeof(msg) * 8;
-
-	printk("Running CM extractor self test\n");
-	IBA_CHECK_GET_BE(CM_REQ_LOCAL_QPN, cm_req_get_local_qpn);
-	IBA_CHECK_SET_BE(CM_REQ_LOCAL_QPN, cm_req_set_local_qpn);
-	IBA_CHECK_GET_BE(CM_REQ_STARTING_PSN, cm_req_get_starting_psn);
-	IBA_CHECK_SET_BE(CM_REQ_STARTING_PSN, cm_req_set_starting_psn);
-	IBA_CHECK_GET_BE(CM_REQ_PRIMARY_FLOW_LABEL, cm_req_get_primary_flow_label);
-	IBA_CHECK_SET_BE(CM_REQ_PRIMARY_FLOW_LABEL, cm_req_set_primary_flow_label);
-	IBA_CHECK_GET_BE(CM_REQ_ALTERNATE_FLOW_LABEL, cm_req_get_alt_flow_label);
-	IBA_CHECK_SET_BE(CM_REQ_ALTERNATE_FLOW_LABEL, cm_req_set_alt_flow_label);
-	IBA_CHECK_GET_BE(CM_REP_LOCAL_QPN, cm_rep_get_local_qpn);
-	IBA_CHECK_SET_BE(CM_REP_LOCAL_QPN, cm_rep_set_local_qpn);
-	IBA_CHECK_GET_BE(CM_REP_LOCAL_EE_CONTEXT_NUMBER, cm_rep_get_local_eecn);
-	IBA_CHECK_SET_BE(CM_REP_LOCAL_EE_CONTEXT_NUMBER, cm_rep_set_local_eecn);
-	IBA_CHECK_GET_BE(CM_REP_STARTING_PSN, cm_rep_get_starting_psn);
-	IBA_CHECK_SET_BE(CM_REP_STARTING_PSN, cm_rep_set_starting_psn);
-	IBA_CHECK_GET_BE(CM_DREQ_REMOTE_QPN_EECN, cm_dreq_get_remote_qpn);
-	IBA_CHECK_SET_BE(CM_DREQ_REMOTE_QPN_EECN, cm_dreq_set_remote_qpn);
-	IBA_CHECK_GET_BE(CM_LAP_ALTERNATE_FLOW_LABEL, cm_lap_get_flow_label);
-	IBA_CHECK_GET_BE(CM_SIDR_REP_QPN, cm_sidr_rep_get_qpn);
-	IBA_CHECK_SET_BE(CM_SIDR_REP_QPN, cm_sidr_rep_set_qpn);
-	printk("Success!\n");
-}
-
 static int __init ib_cm_init(void)
 {
 	int ret;
 
-	self_test();
-
 	INIT_LIST_HEAD(&cm.device_list);
 	rwlock_init(&cm.device_lock);
 	spin_lock_init(&cm.lock);
diff --git a/drivers/infiniband/core/cm_msgs.h b/drivers/infiniband/core/cm_msgs.h
index d30586b1b8a475..86ab6952d5d80a 100644
--- a/drivers/infiniband/core/cm_msgs.h
+++ b/drivers/infiniband/core/cm_msgs.h
@@ -75,18 +75,6 @@ struct cm_req_msg {
 
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
 static inline enum ib_qp_type cm_req_get_qp_type(struct cm_req_msg *req_msg)
 {
 	u8 transport_type = IBA_GET(CM_REQ_TRANSPORT_SERVICE_TYPE, req_msg);
@@ -118,46 +106,6 @@ static inline void cm_req_set_qp_type(struct cm_req_msg *req_msg,
 	}
 }
 
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
-static inline __be32 cm_req_get_primary_flow_label(struct cm_req_msg *req_msg)
-{
-	return cpu_to_be32(be32_to_cpu(req_msg->primary_offset88) >> 12);
-}
-
-static inline void cm_req_set_primary_flow_label(struct cm_req_msg *req_msg,
-						 __be32 flow_label)
-{
-	req_msg->primary_offset88 = cpu_to_be32(
-				    (be32_to_cpu(req_msg->primary_offset88) &
-				     0x00000FFF) |
-				     (be32_to_cpu(flow_label) << 12));
-}
-
-static inline __be32 cm_req_get_alt_flow_label(struct cm_req_msg *req_msg)
-{
-	return cpu_to_be32(be32_to_cpu(req_msg->alt_offset132) >> 12);
-}
-
-static inline void cm_req_set_alt_flow_label(struct cm_req_msg *req_msg,
-					     __be32 flow_label)
-{
-	req_msg->alt_offset132 = cpu_to_be32(
-				 (be32_to_cpu(req_msg->alt_offset132) &
-				  0x00000FFF) |
-				  (be32_to_cpu(flow_label) << 12));
-}
-
 /* Message REJected or MRAed */
 enum cm_msg_response {
 	CM_MSG_RESPONSE_REQ = 0x0,
@@ -219,44 +167,12 @@ struct cm_rep_msg {
 
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
 static inline __be32 cm_rep_get_qpn(struct cm_rep_msg *rep_msg, enum ib_qp_type qp_type)
 {
 	return (qp_type == IB_QPT_XRC_INI) ?
-		cm_rep_get_local_eecn(rep_msg) : cm_rep_get_local_qpn(rep_msg);
-}
-
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
+		       cpu_to_be32(IBA_GET(CM_REP_LOCAL_EE_CONTEXT_NUMBER,
+					   rep_msg)) :
+		       cpu_to_be32(IBA_GET(CM_REP_LOCAL_QPN, rep_msg));
 }
 
 struct cm_rtu_msg {
@@ -281,17 +197,6 @@ struct cm_dreq_msg {
 
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
 
@@ -330,11 +235,6 @@ struct cm_lap_msg {
 	u8 private_data[IB_CM_LAP_PRIVATE_DATA_SIZE];
 } __packed;
 
-static inline __be32 cm_lap_get_flow_label(struct cm_lap_msg *lap_msg)
-{
-	return cpu_to_be32(be32_to_cpu(lap_msg->offset56) >> 12);
-}
-
 struct cm_apr_msg {
 	struct ib_mad_hdr hdr;
 
@@ -376,17 +276,4 @@ struct cm_sidr_rep_msg {
 	u8 private_data[IB_CM_SIDR_REP_PRIVATE_DATA_SIZE];
 } __packed;
 
-static inline __be32 cm_sidr_rep_get_qpn(struct cm_sidr_rep_msg *sidr_rep_msg)
-{
-	return cpu_to_be32(be32_to_cpu(sidr_rep_msg->offset8) >> 8);
-}
-
-static inline void cm_sidr_rep_set_qpn(struct cm_sidr_rep_msg *sidr_rep_msg,
-				       __be32 qpn)
-{
-	sidr_rep_msg->offset8 = cpu_to_be32((be32_to_cpu(qpn) << 8) |
-					(be32_to_cpu(sidr_rep_msg->offset8) &
-					 0x000000FF));
-}
-
 #endif /* CM_MSGS_H */
-- 
2.24.1

