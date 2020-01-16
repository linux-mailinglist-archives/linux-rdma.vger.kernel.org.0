Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ADC113F706
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387789AbgAPTI4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:08:56 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35399 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387452AbgAPRAv (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:51 -0500
Received: by mail-qt1-f195.google.com with SMTP id e12so19439383qto.2
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ok105b5xstdSCkzhbh1uGDUuifaGCPDtOpyfuPfIhZo=;
        b=GAT0gFXt903NEXZgHzGhDYvxqnHVSR+dm/gPoUui+JO7fsvdWLLy+6Bg+NR+HK2azU
         r60Lld6lc1P9i+T+IsonW+LKM2o7XExtUhiknRYVChH9Ijafns/2tV4wo/C2J0OE3Oc9
         vuFnPRDw8vSWQPZA8JIJVFyNP3f/XpewL1H/oKa6+lDzcutGYuvcwe0syTRYuTzzmDUu
         1QAvYKPTbKRBhnY4JFrwioaLatGK+FjYJWd4VWEpfPKI/Cn4HTwyV23GbBKgNQvIE723
         RxuhZLXrZNdNAQwnAKDwmyVISELRzQ1trgMPEWbwy25sumvve5ZHvK5el20fUusai6ka
         ESiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ok105b5xstdSCkzhbh1uGDUuifaGCPDtOpyfuPfIhZo=;
        b=Qc8n+SQk1oio09I8HByvQ7nokK6+ScxkhYPHTHVMkJRM4PU5cFWfgPJaE5pnzA6/jI
         y7y3W7enWqvHaj2xH3wj0GqQSnQTsiw/9HCPGElj48ppmTvc8DeAHTlJ+vKpElroWRW4
         WL5/N1GfEAGShqDgwGPcZ8IhnsoNr0j0BGQvl176p+Nz/LpdyDNFKnVXJV0PwAWivljh
         /exBzZfEpLToPF1gGZ17XTVkyOQKzr0+cPOyN1qHhMFkTrmhUX0iWqAFxrdfndJvx/5u
         xr45G0eNdDcnRqUc7oAZ4MRaWaa93BojzgzfSfO1HtCQqYz+QAH/Hu6469ku26aQy1y9
         4zbg==
X-Gm-Message-State: APjAAAVLqO+KNHfyW89CIJq7ACIxi34DgOo1sdxfCu8HC64naFxWUpD8
        +5kt7OKlMF0TFSxA43wNRdzLJUmAYJw=
X-Google-Smtp-Source: APXvYqwb9h4ch3QIH7q2cikraHKay8ju36MSsWRgfQilfYbyNiL2kyL6rVcfP/wzCyUYaUnq43wksA==
X-Received: by 2002:aed:2a87:: with SMTP id t7mr3328723qtd.384.1579194047627;
        Thu, 16 Jan 2020 09:00:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id m10sm10277057qki.74.2020.01.16.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vc-0007ta-7E; Thu, 16 Jan 2020 13:00:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 5/7] RDMA/cm: Use IBA functions for simple structure members
Date:   Thu, 16 Jan 2020 13:00:35 -0400
Message-Id: <20200116170037.30109-6-jgg@ziepe.ca>
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

Use a Coccinelle spatch script to replace use of simple CM structure
members with IBA_GET/SET versions. Applied with

$ spatch --sp-file edits.sp --in-place drivers/infiniband/core/cm.c

The spatch file was generated using the template pattern:

@@
expression val;
{struct} *msg;
@@
- msg->{old_name} = val
+ IBA_SET({new_name}, msg, be{bits}_to_cpu(val))
@@
{struct} *msg;
@@
- msg->{old_name}
+ cpu_to_be{bits}(IBA_GET({new_name}, msg))

Iterated for every IBA_CHECK_OFF that isn't a CM_FIELD_MLOC.

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
 drivers/infiniband/core/cm.c | 384 ++++++++++++++++++++++-------------
 1 file changed, 245 insertions(+), 139 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 976bb85b6aa6a4..047ee560046e78 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1251,9 +1251,11 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	cm_format_mad_hdr(&req_msg->hdr, CM_REQ_ATTR_ID,
 			  cm_form_tid(cm_id_priv));
 
-	req_msg->local_comm_id = cm_id_priv->id.local_id;
-	req_msg->service_id = param->service_id;
-	req_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
+	IBA_SET(CM_REQ_LOCAL_COMM_ID, req_msg,
+		be32_to_cpu(cm_id_priv->id.local_id));
+	IBA_SET(CM_REQ_SERVICE_ID, req_msg, be64_to_cpu(param->service_id));
+	IBA_SET(CM_REQ_LOCAL_CA_GUID, req_msg,
+		be64_to_cpu(cm_id_priv->id.device->node_guid));
 	IBA_SET(CM_REQ_LOCAL_QPN, req_msg, param->qp_num);
 	IBA_SET(CM_REQ_INITIATOR_DEPTH, req_msg, param->initiator_depth);
 	IBA_SET(CM_REQ_REMOTE_CM_RESPONSE_TIMEOUT, req_msg,
@@ -1263,7 +1265,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	IBA_SET(CM_REQ_STARTING_PSN, req_msg, param->starting_psn);
 	IBA_SET(CM_REQ_LOCAL_CM_RESPONSE_TIMEOUT, req_msg,
 		param->local_cm_response_timeout);
-	req_msg->pkey = param->primary_path->pkey;
+	IBA_SET(CM_REQ_PARTITION_KEY, req_msg,
+		be16_to_cpu(param->primary_path->pkey));
 	IBA_SET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg,
 		param->primary_path->mtu);
 	IBA_SET(CM_REQ_MAX_CM_RETRIES, req_msg, param->max_cm_retries);
@@ -1286,20 +1289,26 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 			= OPA_MAKE_ID(be32_to_cpu(pri_path->opa.dlid));
 	}
 	if (pri_path->hop_limit <= 1) {
-		req_msg->primary_local_lid = pri_ext ? 0 :
-			htons(ntohl(sa_path_get_slid(pri_path)));
-		req_msg->primary_remote_lid = pri_ext ? 0 :
-			htons(ntohl(sa_path_get_dlid(pri_path)));
+		IBA_SET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg,
+			be16_to_cpu(pri_ext ? 0 :
+					      htons(ntohl(sa_path_get_slid(
+						      pri_path)))));
+		IBA_SET(CM_REQ_PRIMARY_REMOTE_PORT_LID, req_msg,
+			be16_to_cpu(pri_ext ? 0 :
+					      htons(ntohl(sa_path_get_dlid(
+						      pri_path)))));
 	} else {
 		/* Work-around until there's a way to obtain remote LID info */
-		req_msg->primary_local_lid = IB_LID_PERMISSIVE;
-		req_msg->primary_remote_lid = IB_LID_PERMISSIVE;
+		IBA_SET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg,
+			be16_to_cpu(IB_LID_PERMISSIVE));
+		IBA_SET(CM_REQ_PRIMARY_REMOTE_PORT_LID, req_msg,
+			be16_to_cpu(IB_LID_PERMISSIVE));
 	}
 	IBA_SET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg,
 		be32_to_cpu(pri_path->flow_label));
 	IBA_SET(CM_REQ_PRIMARY_PACKET_RATE, req_msg, pri_path->rate);
-	req_msg->primary_traffic_class = pri_path->traffic_class;
-	req_msg->primary_hop_limit = pri_path->hop_limit;
+	IBA_SET(CM_REQ_PRIMARY_TRAFFIC_CLASS, req_msg, pri_path->traffic_class);
+	IBA_SET(CM_REQ_PRIMARY_HOP_LIMIT, req_msg, pri_path->hop_limit);
 	IBA_SET(CM_REQ_PRIMARY_SL, req_msg, pri_path->sl);
 	IBA_SET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg,
 		(pri_path->hop_limit <= 1));
@@ -1323,19 +1332,29 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 				= OPA_MAKE_ID(be32_to_cpu(alt_path->opa.dlid));
 		}
 		if (alt_path->hop_limit <= 1) {
-			req_msg->alt_local_lid = alt_ext ? 0 :
-				htons(ntohl(sa_path_get_slid(alt_path)));
-			req_msg->alt_remote_lid = alt_ext ? 0 :
-				htons(ntohl(sa_path_get_dlid(alt_path)));
+			IBA_SET(CM_REQ_ALTERNATE_LOCAL_PORT_LID, req_msg,
+				be16_to_cpu(
+					alt_ext ? 0 :
+						  htons(ntohl(sa_path_get_slid(
+							  alt_path)))));
+			IBA_SET(CM_REQ_ALTERNATE_REMOTE_PORT_LID, req_msg,
+				be16_to_cpu(
+					alt_ext ? 0 :
+						  htons(ntohl(sa_path_get_dlid(
+							  alt_path)))));
 		} else {
-			req_msg->alt_local_lid = IB_LID_PERMISSIVE;
-			req_msg->alt_remote_lid = IB_LID_PERMISSIVE;
+			IBA_SET(CM_REQ_ALTERNATE_LOCAL_PORT_LID, req_msg,
+				be16_to_cpu(IB_LID_PERMISSIVE));
+			IBA_SET(CM_REQ_ALTERNATE_REMOTE_PORT_LID, req_msg,
+				be16_to_cpu(IB_LID_PERMISSIVE));
 		}
 		IBA_SET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg,
 			be32_to_cpu(alt_path->flow_label));
 		IBA_SET(CM_REQ_ALTERNATE_PACKET_RATE, req_msg, alt_path->rate);
-		req_msg->alt_traffic_class = alt_path->traffic_class;
-		req_msg->alt_hop_limit = alt_path->hop_limit;
+		IBA_SET(CM_REQ_ALTERNATE_TRAFFIC_CLASS, req_msg,
+			alt_path->traffic_class);
+		IBA_SET(CM_REQ_ALTERNATE_HOP_LIMIT, req_msg,
+			alt_path->hop_limit);
 		IBA_SET(CM_REQ_ALTERNATE_SL, req_msg, alt_path->sl);
 		IBA_SET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg,
 			(alt_path->hop_limit <= 1));
@@ -1477,10 +1496,12 @@ static int cm_issue_rej(struct cm_port *port,
 	rej_msg = (struct cm_rej_msg *) msg->mad;
 
 	cm_format_mad_hdr(&rej_msg->hdr, CM_REJ_ATTR_ID, rcv_msg->hdr.tid);
-	rej_msg->remote_comm_id = rcv_msg->local_comm_id;
-	rej_msg->local_comm_id = rcv_msg->remote_comm_id;
+	IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
+		IBA_GET(CM_REJ_LOCAL_COMM_ID, rcv_msg));
+	IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg,
+		IBA_GET(CM_REJ_REMOTE_COMM_ID, rcv_msg));
 	IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, msg_rejected);
-	rej_msg->reason = cpu_to_be16(reason);
+	IBA_SET(CM_REJ_REASON, rej_msg, reason);
 
 	if (ari && ari_length) {
 		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
@@ -1496,7 +1517,8 @@ static int cm_issue_rej(struct cm_port *port,
 
 static bool cm_req_has_alt_path(struct cm_req_msg *req_msg)
 {
-	return ((req_msg->alt_local_lid) ||
+	return ((cpu_to_be16(
+			IBA_GET(CM_REQ_ALTERNATE_LOCAL_PORT_LID, req_msg))) ||
 		(ib_is_opa_gid(&req_msg->alt_local_gid)));
 }
 
@@ -1517,9 +1539,11 @@ static void cm_format_path_lid_from_req(struct cm_req_msg *req_msg,
 
 	if (primary_path->rec_type != SA_PATH_REC_TYPE_OPA) {
 		sa_path_set_dlid(primary_path,
-				 ntohs(req_msg->primary_local_lid));
+				 IBA_GET(CM_REQ_PRIMARY_LOCAL_PORT_LID,
+					 req_msg));
 		sa_path_set_slid(primary_path,
-				 ntohs(req_msg->primary_remote_lid));
+				 IBA_GET(CM_REQ_PRIMARY_REMOTE_PORT_LID,
+					 req_msg));
 	} else {
 		lid = opa_get_lid_from_gid(&req_msg->primary_local_gid);
 		sa_path_set_dlid(primary_path, lid);
@@ -1532,8 +1556,12 @@ static void cm_format_path_lid_from_req(struct cm_req_msg *req_msg,
 		return;
 
 	if (alt_path->rec_type != SA_PATH_REC_TYPE_OPA) {
-		sa_path_set_dlid(alt_path, ntohs(req_msg->alt_local_lid));
-		sa_path_set_slid(alt_path, ntohs(req_msg->alt_remote_lid));
+		sa_path_set_dlid(alt_path,
+				 IBA_GET(CM_REQ_ALTERNATE_LOCAL_PORT_LID,
+					 req_msg));
+		sa_path_set_slid(alt_path,
+				 IBA_GET(CM_REQ_ALTERNATE_REMOTE_PORT_LID,
+					 req_msg));
 	} else {
 		lid = opa_get_lid_from_gid(&req_msg->alt_local_gid);
 		sa_path_set_dlid(alt_path, lid);
@@ -1551,10 +1579,12 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->sgid = req_msg->primary_remote_gid;
 	primary_path->flow_label =
 		cpu_to_be32(IBA_GET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg));
-	primary_path->hop_limit = req_msg->primary_hop_limit;
-	primary_path->traffic_class = req_msg->primary_traffic_class;
+	primary_path->hop_limit = IBA_GET(CM_REQ_PRIMARY_HOP_LIMIT, req_msg);
+	primary_path->traffic_class =
+		IBA_GET(CM_REQ_PRIMARY_TRAFFIC_CLASS, req_msg);
 	primary_path->reversible = 1;
-	primary_path->pkey = req_msg->pkey;
+	primary_path->pkey =
+		cpu_to_be16(IBA_GET(CM_REQ_PARTITION_KEY, req_msg));
 	primary_path->sl = IBA_GET(CM_REQ_PRIMARY_SL, req_msg);
 	primary_path->mtu_selector = IB_SA_EQ;
 	primary_path->mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
@@ -1564,7 +1594,8 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 	primary_path->packet_life_time =
 		IBA_GET(CM_REQ_PRIMARY_LOCAL_ACK_TIMEOUT, req_msg);
 	primary_path->packet_life_time -= (primary_path->packet_life_time > 0);
-	primary_path->service_id = req_msg->service_id;
+	primary_path->service_id =
+		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
 	if (sa_path_is_roce(primary_path))
 		primary_path->roce.route_resolved = false;
 
@@ -1573,10 +1604,13 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->sgid = req_msg->alt_remote_gid;
 		alt_path->flow_label = cpu_to_be32(
 			IBA_GET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg));
-		alt_path->hop_limit = req_msg->alt_hop_limit;
-		alt_path->traffic_class = req_msg->alt_traffic_class;
+		alt_path->hop_limit =
+			IBA_GET(CM_REQ_ALTERNATE_HOP_LIMIT, req_msg);
+		alt_path->traffic_class =
+			IBA_GET(CM_REQ_ALTERNATE_TRAFFIC_CLASS, req_msg);
 		alt_path->reversible = 1;
-		alt_path->pkey = req_msg->pkey;
+		alt_path->pkey =
+			cpu_to_be16(IBA_GET(CM_REQ_PARTITION_KEY, req_msg));
 		alt_path->sl = IBA_GET(CM_REQ_ALTERNATE_SL, req_msg);
 		alt_path->mtu_selector = IB_SA_EQ;
 		alt_path->mtu =
@@ -1587,7 +1621,8 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		alt_path->packet_life_time =
 			IBA_GET(CM_REQ_ALTERNATE_LOCAL_ACK_TIMEOUT, req_msg);
 		alt_path->packet_life_time -= (alt_path->packet_life_time > 0);
-		alt_path->service_id = req_msg->service_id;
+		alt_path->service_id =
+			cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
 
 		if (sa_path_is_roce(alt_path))
 			alt_path->roce.route_resolved = false;
@@ -1662,8 +1697,9 @@ static void cm_format_req_event(struct cm_work *work,
 	} else {
 		param->alternate_path = NULL;
 	}
-	param->remote_ca_guid = req_msg->local_ca_guid;
-	param->remote_qkey = be32_to_cpu(req_msg->local_qkey);
+	param->remote_ca_guid =
+		cpu_to_be64(IBA_GET(CM_REQ_LOCAL_CA_GUID, req_msg));
+	param->remote_qkey = IBA_GET(CM_REQ_LOCAL_Q_KEY, req_msg);
 	param->remote_qpn = IBA_GET(CM_REQ_LOCAL_QPN, req_msg);
 	param->qp_type = cm_req_get_qp_type(req_msg);
 	param->starting_psn = IBA_GET(CM_REQ_STARTING_PSN, req_msg);
@@ -1713,8 +1749,10 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 {
 	cm_format_mad_hdr(&mra_msg->hdr, CM_MRA_ATTR_ID, cm_id_priv->tid);
 	IBA_SET(CM_MRA_MESSAGE_MRAED, mra_msg, msg_mraed);
-	mra_msg->local_comm_id = cm_id_priv->id.local_id;
-	mra_msg->remote_comm_id = cm_id_priv->id.remote_id;
+	IBA_SET(CM_MRA_LOCAL_COMM_ID, mra_msg,
+		be32_to_cpu(cm_id_priv->id.local_id));
+	IBA_SET(CM_MRA_REMOTE_COMM_ID, mra_msg,
+		be32_to_cpu(cm_id_priv->id.remote_id));
 	IBA_SET(CM_MRA_SERVICE_TIMEOUT, mra_msg, service_timeout);
 
 	if (private_data && private_data_len)
@@ -1730,30 +1768,34 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 			  u8 private_data_len)
 {
 	cm_format_mad_hdr(&rej_msg->hdr, CM_REJ_ATTR_ID, cm_id_priv->tid);
-	rej_msg->remote_comm_id = cm_id_priv->id.remote_id;
+	IBA_SET(CM_REJ_REMOTE_COMM_ID, rej_msg,
+		be32_to_cpu(cm_id_priv->id.remote_id));
 
 	switch(cm_id_priv->id.state) {
 	case IB_CM_REQ_RCVD:
-		rej_msg->local_comm_id = 0;
+		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg, be32_to_cpu(0));
 		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_MRA_REQ_SENT:
-		rej_msg->local_comm_id = cm_id_priv->id.local_id;
+		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg,
+			be32_to_cpu(cm_id_priv->id.local_id));
 		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REQ);
 		break;
 	case IB_CM_REP_RCVD:
 	case IB_CM_MRA_REP_SENT:
-		rej_msg->local_comm_id = cm_id_priv->id.local_id;
+		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg,
+			be32_to_cpu(cm_id_priv->id.local_id));
 		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg, CM_MSG_RESPONSE_REP);
 		break;
 	default:
-		rej_msg->local_comm_id = cm_id_priv->id.local_id;
+		IBA_SET(CM_REJ_LOCAL_COMM_ID, rej_msg,
+			be32_to_cpu(cm_id_priv->id.local_id));
 		IBA_SET(CM_REJ_MESSAGE_REJECTED, rej_msg,
 			CM_MSG_RESPONSE_OTHER);
 		break;
 	}
 
-	rej_msg->reason = cpu_to_be16(reason);
+	IBA_SET(CM_REJ_REASON, rej_msg, reason);
 	if (ari && ari_length) {
 		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
 		memcpy(rej_msg->ari, ari, ari_length);
@@ -1850,8 +1892,9 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 	}
 
 	/* Find matching listen request. */
-	listen_cm_id_priv = cm_find_listen(cm_id_priv->id.device,
-					   req_msg->service_id);
+	listen_cm_id_priv = cm_find_listen(
+		cm_id_priv->id.device,
+		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg)));
 	if (!listen_cm_id_priv) {
 		cm_cleanup_timewait(cm_id_priv->timewait_info);
 		spin_unlock_irq(&cm.lock);
@@ -1877,23 +1920,31 @@ static struct cm_id_private * cm_match_req(struct cm_work *work,
 static void cm_process_routed_req(struct cm_req_msg *req_msg, struct ib_wc *wc)
 {
 	if (!IBA_GET(CM_REQ_PRIMARY_SUBNET_LOCAL, req_msg)) {
-		if (req_msg->primary_local_lid == IB_LID_PERMISSIVE) {
-			req_msg->primary_local_lid = ib_lid_be16(wc->slid);
+		if (cpu_to_be16(IBA_GET(CM_REQ_PRIMARY_LOCAL_PORT_LID,
+					req_msg)) == IB_LID_PERMISSIVE) {
+			IBA_SET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg,
+				be16_to_cpu(ib_lid_be16(wc->slid)));
 			IBA_SET(CM_REQ_PRIMARY_SL, req_msg, wc->sl);
 		}
 
-		if (req_msg->primary_remote_lid == IB_LID_PERMISSIVE)
-			req_msg->primary_remote_lid = cpu_to_be16(wc->dlid_path_bits);
+		if (cpu_to_be16(IBA_GET(CM_REQ_PRIMARY_REMOTE_PORT_LID,
+					req_msg)) == IB_LID_PERMISSIVE)
+			IBA_SET(CM_REQ_PRIMARY_REMOTE_PORT_LID, req_msg,
+				wc->dlid_path_bits);
 	}
 
 	if (!IBA_GET(CM_REQ_ALTERNATE_SUBNET_LOCAL, req_msg)) {
-		if (req_msg->alt_local_lid == IB_LID_PERMISSIVE) {
-			req_msg->alt_local_lid = ib_lid_be16(wc->slid);
+		if (cpu_to_be16(IBA_GET(CM_REQ_ALTERNATE_LOCAL_PORT_LID,
+					req_msg)) == IB_LID_PERMISSIVE) {
+			IBA_SET(CM_REQ_ALTERNATE_LOCAL_PORT_LID, req_msg,
+				be16_to_cpu(ib_lid_be16(wc->slid)));
 			IBA_SET(CM_REQ_ALTERNATE_SL, req_msg, wc->sl);
 		}
 
-		if (req_msg->alt_remote_lid == IB_LID_PERMISSIVE)
-			req_msg->alt_remote_lid = cpu_to_be16(wc->dlid_path_bits);
+		if (cpu_to_be16(IBA_GET(CM_REQ_ALTERNATE_REMOTE_PORT_LID,
+					req_msg)) == IB_LID_PERMISSIVE)
+			IBA_SET(CM_REQ_ALTERNATE_REMOTE_PORT_LID, req_msg,
+				wc->dlid_path_bits);
 	}
 }
 
@@ -1913,7 +1964,8 @@ static int cm_req_handler(struct cm_work *work)
 		return PTR_ERR(cm_id);
 
 	cm_id_priv = container_of(cm_id, struct cm_id_private, id);
-	cm_id_priv->id.remote_id = req_msg->local_comm_id;
+	cm_id_priv->id.remote_id =
+		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
 	ret = cm_init_av_for_response(work->port, work->mad_recv_wc->wc,
 				      work->mad_recv_wc->recv_buf.grh,
 				      &cm_id_priv->av);
@@ -1925,8 +1977,10 @@ static int cm_req_handler(struct cm_work *work)
 		ret = PTR_ERR(cm_id_priv->timewait_info);
 		goto destroy;
 	}
-	cm_id_priv->timewait_info->work.remote_id = req_msg->local_comm_id;
-	cm_id_priv->timewait_info->remote_ca_guid = req_msg->local_ca_guid;
+	cm_id_priv->timewait_info->work.remote_id =
+		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_COMM_ID, req_msg));
+	cm_id_priv->timewait_info->remote_ca_guid =
+		cpu_to_be64(IBA_GET(CM_REQ_LOCAL_CA_GUID, req_msg));
 	cm_id_priv->timewait_info->remote_qpn =
 		cpu_to_be32(IBA_GET(CM_REQ_LOCAL_QPN, req_msg));
 
@@ -1940,7 +1994,8 @@ static int cm_req_handler(struct cm_work *work)
 
 	cm_id_priv->id.cm_handler = listen_cm_id_priv->id.cm_handler;
 	cm_id_priv->id.context = listen_cm_id_priv->id.context;
-	cm_id_priv->id.service_id = req_msg->service_id;
+	cm_id_priv->id.service_id =
+		cpu_to_be64(IBA_GET(CM_REQ_SERVICE_ID, req_msg));
 	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
 
 	cm_process_routed_req(req_msg, work->mad_recv_wc->wc);
@@ -2009,7 +2064,7 @@ static int cm_req_handler(struct cm_work *work)
 	cm_id_priv->responder_resources =
 		IBA_GET(CM_REQ_INITIATOR_DEPTH, req_msg);
 	cm_id_priv->path_mtu = IBA_GET(CM_REQ_PATH_PACKET_PAYLOAD_MTU, req_msg);
-	cm_id_priv->pkey = req_msg->pkey;
+	cm_id_priv->pkey = cpu_to_be16(IBA_GET(CM_REQ_PARTITION_KEY, req_msg));
 	cm_id_priv->sq_psn = cpu_to_be32(IBA_GET(CM_REQ_STARTING_PSN, req_msg));
 	cm_id_priv->retry_count = IBA_GET(CM_REQ_RETRY_COUNT, req_msg);
 	cm_id_priv->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
@@ -2035,18 +2090,23 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 			  struct ib_cm_rep_param *param)
 {
 	cm_format_mad_hdr(&rep_msg->hdr, CM_REP_ATTR_ID, cm_id_priv->tid);
-	rep_msg->local_comm_id = cm_id_priv->id.local_id;
-	rep_msg->remote_comm_id = cm_id_priv->id.remote_id;
+	IBA_SET(CM_REP_LOCAL_COMM_ID, rep_msg,
+		be32_to_cpu(cm_id_priv->id.local_id));
+	IBA_SET(CM_REP_REMOTE_COMM_ID, rep_msg,
+		be32_to_cpu(cm_id_priv->id.remote_id));
 	IBA_SET(CM_REP_STARTING_PSN, rep_msg, param->starting_psn);
-	rep_msg->resp_resources = param->responder_resources;
+	IBA_SET(CM_REP_RESPONDER_RESOURCES, rep_msg,
+		param->responder_resources);
 	IBA_SET(CM_REP_TARGET_ACK_DELAY, rep_msg,
 		cm_id_priv->av.port->cm_dev->ack_delay);
 	IBA_SET(CM_REP_FAILOVER_ACCEPTED, rep_msg, param->failover_accepted);
 	IBA_SET(CM_REP_RNR_RETRY_COUNT, rep_msg, param->rnr_retry_count);
-	rep_msg->local_ca_guid = cm_id_priv->id.device->node_guid;
+	IBA_SET(CM_REP_LOCAL_CA_GUID, rep_msg,
+		be64_to_cpu(cm_id_priv->id.device->node_guid));
 
 	if (cm_id_priv->qp_type != IB_QPT_XRC_TGT) {
-		rep_msg->initiator_depth = param->initiator_depth;
+		IBA_SET(CM_REP_INITIATOR_DEPTH, rep_msg,
+			param->initiator_depth);
 		IBA_SET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg,
 			param->flow_control);
 		IBA_SET(CM_REP_SRQ, rep_msg, param->srq);
@@ -2118,8 +2178,10 @@ static void cm_format_rtu(struct cm_rtu_msg *rtu_msg,
 			  u8 private_data_len)
 {
 	cm_format_mad_hdr(&rtu_msg->hdr, CM_RTU_ATTR_ID, cm_id_priv->tid);
-	rtu_msg->local_comm_id = cm_id_priv->id.local_id;
-	rtu_msg->remote_comm_id = cm_id_priv->id.remote_id;
+	IBA_SET(CM_RTU_LOCAL_COMM_ID, rtu_msg,
+		be32_to_cpu(cm_id_priv->id.local_id));
+	IBA_SET(CM_RTU_REMOTE_COMM_ID, rtu_msg,
+		be32_to_cpu(cm_id_priv->id.remote_id));
 
 	if (private_data && private_data_len)
 		memcpy(rtu_msg->private_data, private_data, private_data_len);
@@ -2185,12 +2247,13 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 
 	rep_msg = (struct cm_rep_msg *)work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.rep_rcvd;
-	param->remote_ca_guid = rep_msg->local_ca_guid;
-	param->remote_qkey = be32_to_cpu(rep_msg->local_qkey);
+	param->remote_ca_guid =
+		cpu_to_be64(IBA_GET(CM_REP_LOCAL_CA_GUID, rep_msg));
+	param->remote_qkey = IBA_GET(CM_REP_LOCAL_Q_KEY, rep_msg);
 	param->remote_qpn = be32_to_cpu(cm_rep_get_qpn(rep_msg, qp_type));
 	param->starting_psn = IBA_GET(CM_REP_STARTING_PSN, rep_msg);
-	param->responder_resources = rep_msg->initiator_depth;
-	param->initiator_depth = rep_msg->resp_resources;
+	param->responder_resources = IBA_GET(CM_REP_INITIATOR_DEPTH, rep_msg);
+	param->initiator_depth = IBA_GET(CM_REP_RESPONDER_RESOURCES, rep_msg);
 	param->target_ack_delay = IBA_GET(CM_REP_TARGET_ACK_DELAY, rep_msg);
 	param->failover_accepted = IBA_GET(CM_REP_FAILOVER_ACCEPTED, rep_msg);
 	param->flow_control = IBA_GET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg);
@@ -2207,8 +2270,9 @@ static void cm_dup_rep_handler(struct cm_work *work)
 	int ret;
 
 	rep_msg = (struct cm_rep_msg *) work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(rep_msg->remote_comm_id,
-				   rep_msg->local_comm_id);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)),
+		cpu_to_be32(IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg)));
 	if (!cm_id_priv)
 		return;
 
@@ -2252,11 +2316,12 @@ static int cm_rep_handler(struct cm_work *work)
 	struct cm_timewait_info *timewait_info;
 
 	rep_msg = (struct cm_rep_msg *)work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(rep_msg->remote_comm_id, 0);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg)), 0);
 	if (!cm_id_priv) {
 		cm_dup_rep_handler(work);
 		pr_debug("%s: remote_comm_id %d, no cm_id_priv\n", __func__,
-			 be32_to_cpu(rep_msg->remote_comm_id));
+			 IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 		return -EINVAL;
 	}
 
@@ -2270,15 +2335,18 @@ static int cm_rep_handler(struct cm_work *work)
 	default:
 		spin_unlock_irq(&cm_id_priv->lock);
 		ret = -EINVAL;
-		pr_debug("%s: cm_id_priv->id.state: %d, local_comm_id %d, remote_comm_id %d\n",
-			 __func__, cm_id_priv->id.state,
-			 be32_to_cpu(rep_msg->local_comm_id),
-			 be32_to_cpu(rep_msg->remote_comm_id));
+		pr_debug(
+			"%s: cm_id_priv->id.state: %d, local_comm_id %d, remote_comm_id %d\n",
+			__func__, cm_id_priv->id.state,
+			IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
+			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 		goto error;
 	}
 
-	cm_id_priv->timewait_info->work.remote_id = rep_msg->local_comm_id;
-	cm_id_priv->timewait_info->remote_ca_guid = rep_msg->local_ca_guid;
+	cm_id_priv->timewait_info->work.remote_id =
+		cpu_to_be32(IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg));
+	cm_id_priv->timewait_info->remote_ca_guid =
+		cpu_to_be64(IBA_GET(CM_REP_LOCAL_CA_GUID, rep_msg));
 	cm_id_priv->timewait_info->remote_qpn = cm_rep_get_qpn(rep_msg, cm_id_priv->qp_type);
 
 	spin_lock(&cm.lock);
@@ -2288,7 +2356,7 @@ static int cm_rep_handler(struct cm_work *work)
 		spin_unlock_irq(&cm_id_priv->lock);
 		ret = -EINVAL;
 		pr_debug("%s: Failed to insert remote id %d\n", __func__,
-			 be32_to_cpu(rep_msg->remote_comm_id));
+			 IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 		goto error;
 	}
 	/* Check for a stale connection. */
@@ -2306,9 +2374,10 @@ static int cm_rep_handler(struct cm_work *work)
 			     IB_CM_REJ_STALE_CONN, CM_MSG_RESPONSE_REP,
 			     NULL, 0);
 		ret = -EINVAL;
-		pr_debug("%s: Stale connection. local_comm_id %d, remote_comm_id %d\n",
-			 __func__, be32_to_cpu(rep_msg->local_comm_id),
-			 be32_to_cpu(rep_msg->remote_comm_id));
+		pr_debug(
+			"%s: Stale connection. local_comm_id %d, remote_comm_id %d\n",
+			__func__, IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg),
+			IBA_GET(CM_REP_REMOTE_COMM_ID, rep_msg));
 
 		if (cur_cm_id_priv) {
 			cm_id = &cur_cm_id_priv->id;
@@ -2321,10 +2390,13 @@ static int cm_rep_handler(struct cm_work *work)
 	spin_unlock(&cm.lock);
 
 	cm_id_priv->id.state = IB_CM_REP_RCVD;
-	cm_id_priv->id.remote_id = rep_msg->local_comm_id;
+	cm_id_priv->id.remote_id =
+		cpu_to_be32(IBA_GET(CM_REP_LOCAL_COMM_ID, rep_msg));
 	cm_id_priv->remote_qpn = cm_rep_get_qpn(rep_msg, cm_id_priv->qp_type);
-	cm_id_priv->initiator_depth = rep_msg->resp_resources;
-	cm_id_priv->responder_resources = rep_msg->initiator_depth;
+	cm_id_priv->initiator_depth =
+		IBA_GET(CM_REP_RESPONDER_RESOURCES, rep_msg);
+	cm_id_priv->responder_resources =
+		IBA_GET(CM_REP_INITIATOR_DEPTH, rep_msg);
 	cm_id_priv->sq_psn = cpu_to_be32(IBA_GET(CM_REP_STARTING_PSN, rep_msg));
 	cm_id_priv->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
 	cm_id_priv->target_ack_delay =
@@ -2394,8 +2466,9 @@ static int cm_rtu_handler(struct cm_work *work)
 	int ret;
 
 	rtu_msg = (struct cm_rtu_msg *)work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(rtu_msg->remote_comm_id,
-				   rtu_msg->local_comm_id);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_RTU_REMOTE_COMM_ID, rtu_msg)),
+		cpu_to_be32(IBA_GET(CM_RTU_LOCAL_COMM_ID, rtu_msg)));
 	if (!cm_id_priv)
 		return -EINVAL;
 
@@ -2434,8 +2507,10 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 {
 	cm_format_mad_hdr(&dreq_msg->hdr, CM_DREQ_ATTR_ID,
 			  cm_form_tid(cm_id_priv));
-	dreq_msg->local_comm_id = cm_id_priv->id.local_id;
-	dreq_msg->remote_comm_id = cm_id_priv->id.remote_id;
+	IBA_SET(CM_DREQ_LOCAL_COMM_ID, dreq_msg,
+		be32_to_cpu(cm_id_priv->id.local_id));
+	IBA_SET(CM_DREQ_REMOTE_COMM_ID, dreq_msg,
+		be32_to_cpu(cm_id_priv->id.remote_id));
 	IBA_SET(CM_DREQ_REMOTE_QPN_EECN, dreq_msg,
 		be32_to_cpu(cm_id_priv->remote_qpn));
 
@@ -2500,8 +2575,10 @@ static void cm_format_drep(struct cm_drep_msg *drep_msg,
 			  u8 private_data_len)
 {
 	cm_format_mad_hdr(&drep_msg->hdr, CM_DREP_ATTR_ID, cm_id_priv->tid);
-	drep_msg->local_comm_id = cm_id_priv->id.local_id;
-	drep_msg->remote_comm_id = cm_id_priv->id.remote_id;
+	IBA_SET(CM_DREP_LOCAL_COMM_ID, drep_msg,
+		be32_to_cpu(cm_id_priv->id.local_id));
+	IBA_SET(CM_DREP_REMOTE_COMM_ID, drep_msg,
+		be32_to_cpu(cm_id_priv->id.remote_id));
 
 	if (private_data && private_data_len)
 		memcpy(drep_msg->private_data, private_data, private_data_len);
@@ -2572,8 +2649,10 @@ static int cm_issue_drep(struct cm_port *port,
 	drep_msg = (struct cm_drep_msg *) msg->mad;
 
 	cm_format_mad_hdr(&drep_msg->hdr, CM_DREP_ATTR_ID, dreq_msg->hdr.tid);
-	drep_msg->remote_comm_id = dreq_msg->local_comm_id;
-	drep_msg->local_comm_id = dreq_msg->remote_comm_id;
+	IBA_SET(CM_DREP_REMOTE_COMM_ID, drep_msg,
+		IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg));
+	IBA_SET(CM_DREP_LOCAL_COMM_ID, drep_msg,
+		IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 
 	ret = ib_post_send_mad(msg, NULL);
 	if (ret)
@@ -2590,15 +2669,17 @@ static int cm_dreq_handler(struct cm_work *work)
 	int ret;
 
 	dreq_msg = (struct cm_dreq_msg *)work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(dreq_msg->remote_comm_id,
-				   dreq_msg->local_comm_id);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg)),
+		cpu_to_be32(IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg)));
 	if (!cm_id_priv) {
 		atomic_long_inc(&work->port->counter_group[CM_RECV_DUPLICATES].
 				counter[CM_DREQ_COUNTER]);
 		cm_issue_drep(work->port, work->mad_recv_wc);
-		pr_debug("%s: no cm_id_priv, local_comm_id %d, remote_comm_id %d\n",
-			 __func__, be32_to_cpu(dreq_msg->local_comm_id),
-			 be32_to_cpu(dreq_msg->remote_comm_id));
+		pr_debug(
+			"%s: no cm_id_priv, local_comm_id %d, remote_comm_id %d\n",
+			__func__, IBA_GET(CM_DREQ_LOCAL_COMM_ID, dreq_msg),
+			IBA_GET(CM_DREQ_REMOTE_COMM_ID, dreq_msg));
 		return -EINVAL;
 	}
 
@@ -2672,8 +2753,9 @@ static int cm_drep_handler(struct cm_work *work)
 	int ret;
 
 	drep_msg = (struct cm_drep_msg *)work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(drep_msg->remote_comm_id,
-				   drep_msg->local_comm_id);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_DREP_REMOTE_COMM_ID, drep_msg)),
+		cpu_to_be32(IBA_GET(CM_DREP_LOCAL_COMM_ID, drep_msg)));
 	if (!cm_id_priv)
 		return -EINVAL;
 
@@ -2775,7 +2857,7 @@ static void cm_format_rej_event(struct cm_work *work)
 	param = &work->cm_event.param.rej_rcvd;
 	param->ari = rej_msg->ari;
 	param->ari_length = IBA_GET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg);
-	param->reason = __be16_to_cpu(rej_msg->reason);
+	param->reason = IBA_GET(CM_REJ_REASON, rej_msg);
 	work->cm_event.private_data = &rej_msg->private_data;
 }
 
@@ -2785,9 +2867,9 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 	struct cm_id_private *cm_id_priv;
 	__be32 remote_id;
 
-	remote_id = rej_msg->local_comm_id;
+	remote_id = cpu_to_be32(IBA_GET(CM_REJ_LOCAL_COMM_ID, rej_msg));
 
-	if (__be16_to_cpu(rej_msg->reason) == IB_CM_REJ_TIMEOUT) {
+	if (IBA_GET(CM_REJ_REASON, rej_msg) == IB_CM_REJ_TIMEOUT) {
 		spin_lock_irq(&cm.lock);
 		timewait_info = cm_find_remote_id( *((__be64 *) rej_msg->ari),
 						  remote_id);
@@ -2800,9 +2882,13 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 		spin_unlock_irq(&cm.lock);
 	} else if (IBA_GET(CM_REJ_MESSAGE_REJECTED, rej_msg) ==
 		   CM_MSG_RESPONSE_REQ)
-		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, 0);
+		cm_id_priv = cm_acquire_id(
+			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, rej_msg)),
+			0);
 	else
-		cm_id_priv = cm_acquire_id(rej_msg->remote_comm_id, remote_id);
+		cm_id_priv = cm_acquire_id(
+			cpu_to_be32(IBA_GET(CM_REJ_REMOTE_COMM_ID, rej_msg)),
+			remote_id);
 
 	return cm_id_priv;
 }
@@ -2830,7 +2916,7 @@ static int cm_rej_handler(struct cm_work *work)
 		/* fall through */
 	case IB_CM_REQ_RCVD:
 	case IB_CM_MRA_REQ_SENT:
-		if (__be16_to_cpu(rej_msg->reason) == IB_CM_REJ_STALE_CONN)
+		if (IBA_GET(CM_REJ_REASON, rej_msg) == IB_CM_REJ_STALE_CONN)
 			cm_enter_timewait(cm_id_priv);
 		else
 			cm_reset_to_idle(cm_id_priv);
@@ -2962,11 +3048,14 @@ static struct cm_id_private * cm_acquire_mraed_id(struct cm_mra_msg *mra_msg)
 {
 	switch (IBA_GET(CM_MRA_MESSAGE_MRAED, mra_msg)) {
 	case CM_MSG_RESPONSE_REQ:
-		return cm_acquire_id(mra_msg->remote_comm_id, 0);
+		return cm_acquire_id(
+			cpu_to_be32(IBA_GET(CM_MRA_REMOTE_COMM_ID, mra_msg)),
+			0);
 	case CM_MSG_RESPONSE_REP:
 	case CM_MSG_RESPONSE_OTHER:
-		return cm_acquire_id(mra_msg->remote_comm_id,
-				     mra_msg->local_comm_id);
+		return cm_acquire_id(
+			cpu_to_be32(IBA_GET(CM_MRA_REMOTE_COMM_ID, mra_msg)),
+			cpu_to_be32(IBA_GET(CM_MRA_LOCAL_COMM_ID, mra_msg)));
 	default:
 		return NULL;
 	}
@@ -3057,8 +3146,10 @@ static void cm_format_path_lid_from_lap(struct cm_lap_msg *lap_msg,
 	u32 lid;
 
 	if (path->rec_type != SA_PATH_REC_TYPE_OPA) {
-		sa_path_set_dlid(path, ntohs(lap_msg->alt_local_lid));
-		sa_path_set_slid(path, ntohs(lap_msg->alt_remote_lid));
+		sa_path_set_dlid(path, IBA_GET(CM_LAP_ALTERNATE_LOCAL_PORT_LID,
+					       lap_msg));
+		sa_path_set_slid(path, IBA_GET(CM_LAP_ALTERNATE_REMOTE_PORT_LID,
+					       lap_msg));
 	} else {
 		lid = opa_get_lid_from_gid(&lap_msg->alt_local_gid);
 		sa_path_set_dlid(path, lid);
@@ -3076,7 +3167,7 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 	path->sgid = lap_msg->alt_remote_gid;
 	path->flow_label =
 		cpu_to_be32(IBA_GET(CM_LAP_ALTERNATE_FLOW_LABEL, lap_msg));
-	path->hop_limit = lap_msg->alt_hop_limit;
+	path->hop_limit = IBA_GET(CM_LAP_ALTERNATE_HOP_LIMIT, lap_msg);
 	path->traffic_class = IBA_GET(CM_LAP_ALTERNATE_TRAFFIC_CLASS, lap_msg);
 	path->reversible = 1;
 	path->pkey = cm_id_priv->pkey;
@@ -3109,8 +3200,9 @@ static int cm_lap_handler(struct cm_work *work)
 
 	/* todo: verify LAP request and send reject APR if invalid. */
 	lap_msg = (struct cm_lap_msg *)work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(lap_msg->remote_comm_id,
-				   lap_msg->local_comm_id);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_LAP_REMOTE_COMM_ID, lap_msg)),
+		cpu_to_be32(IBA_GET(CM_LAP_LOCAL_COMM_ID, lap_msg)));
 	if (!cm_id_priv)
 		return -EINVAL;
 
@@ -3201,14 +3293,17 @@ static int cm_apr_handler(struct cm_work *work)
 		return -EINVAL;
 
 	apr_msg = (struct cm_apr_msg *)work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(apr_msg->remote_comm_id,
-				   apr_msg->local_comm_id);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_APR_REMOTE_COMM_ID, apr_msg)),
+		cpu_to_be32(IBA_GET(CM_APR_LOCAL_COMM_ID, apr_msg)));
 	if (!cm_id_priv)
 		return -EINVAL; /* Unmatched reply. */
 
-	work->cm_event.param.apr_rcvd.ap_status = apr_msg->ap_status;
+	work->cm_event.param.apr_rcvd.ap_status =
+		IBA_GET(CM_APR_AR_STATUS, apr_msg);
 	work->cm_event.param.apr_rcvd.apr_info = &apr_msg->info;
-	work->cm_event.param.apr_rcvd.info_len = apr_msg->info_length;
+	work->cm_event.param.apr_rcvd.info_len =
+		IBA_GET(CM_APR_ADDITIONAL_INFORMATION_LENGTH, apr_msg);
 	work->cm_event.private_data = &apr_msg->private_data;
 
 	spin_lock_irq(&cm_id_priv->lock);
@@ -3281,9 +3376,12 @@ static void cm_format_sidr_req(struct cm_sidr_req_msg *sidr_req_msg,
 {
 	cm_format_mad_hdr(&sidr_req_msg->hdr, CM_SIDR_REQ_ATTR_ID,
 			  cm_form_tid(cm_id_priv));
-	sidr_req_msg->request_id = cm_id_priv->id.local_id;
-	sidr_req_msg->pkey = param->path->pkey;
-	sidr_req_msg->service_id = param->service_id;
+	IBA_SET(CM_SIDR_REQ_REQUESTID, sidr_req_msg,
+		be32_to_cpu(cm_id_priv->id.local_id));
+	IBA_SET(CM_SIDR_REQ_PARTITION_KEY, sidr_req_msg,
+		be16_to_cpu(param->path->pkey));
+	IBA_SET(CM_SIDR_REQ_SERVICEID, sidr_req_msg,
+		be64_to_cpu(param->service_id));
 
 	if (param->private_data && param->private_data_len)
 		memcpy(sidr_req_msg->private_data, param->private_data,
@@ -3351,9 +3449,10 @@ static void cm_format_sidr_req_event(struct cm_work *work,
 	sidr_req_msg = (struct cm_sidr_req_msg *)
 				work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.sidr_req_rcvd;
-	param->pkey = __be16_to_cpu(sidr_req_msg->pkey);
+	param->pkey = IBA_GET(CM_SIDR_REQ_PARTITION_KEY, sidr_req_msg);
 	param->listen_id = listen_id;
-	param->service_id = sidr_req_msg->service_id;
+	param->service_id =
+		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
 	param->bth_pkey = cm_get_bth_pkey(work);
 	param->port = work->port->port_num;
 	param->sgid_attr = rx_cm_id->av.ah_attr.grh.sgid_attr;
@@ -3385,7 +3484,8 @@ static int cm_sidr_req_handler(struct cm_work *work)
 	if (ret)
 		goto out;
 
-	cm_id_priv->id.remote_id = sidr_req_msg->request_id;
+	cm_id_priv->id.remote_id =
+		cpu_to_be32(IBA_GET(CM_SIDR_REQ_REQUESTID, sidr_req_msg));
 	cm_id_priv->tid = sidr_req_msg->hdr.tid;
 	atomic_inc(&cm_id_priv->work_count);
 
@@ -3398,8 +3498,9 @@ static int cm_sidr_req_handler(struct cm_work *work)
 		goto out; /* Duplicate message. */
 	}
 	cm_id_priv->id.state = IB_CM_SIDR_REQ_RCVD;
-	cur_cm_id_priv = cm_find_listen(cm_id->device,
-					sidr_req_msg->service_id);
+	cur_cm_id_priv = cm_find_listen(
+		cm_id->device,
+		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg)));
 	if (!cur_cm_id_priv) {
 		spin_unlock_irq(&cm.lock);
 		cm_reject_sidr_req(cm_id_priv, IB_SIDR_UNSUPPORTED);
@@ -3411,7 +3512,8 @@ static int cm_sidr_req_handler(struct cm_work *work)
 
 	cm_id_priv->id.cm_handler = cur_cm_id_priv->id.cm_handler;
 	cm_id_priv->id.context = cur_cm_id_priv->id.context;
-	cm_id_priv->id.service_id = sidr_req_msg->service_id;
+	cm_id_priv->id.service_id =
+		cpu_to_be64(IBA_GET(CM_SIDR_REQ_SERVICEID, sidr_req_msg));
 	cm_id_priv->id.service_mask = ~cpu_to_be64(0);
 
 	cm_format_sidr_req_event(work, cm_id_priv, &cur_cm_id_priv->id);
@@ -3429,11 +3531,13 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 {
 	cm_format_mad_hdr(&sidr_rep_msg->hdr, CM_SIDR_REP_ATTR_ID,
 			  cm_id_priv->tid);
-	sidr_rep_msg->request_id = cm_id_priv->id.remote_id;
-	sidr_rep_msg->status = param->status;
+	IBA_SET(CM_SIDR_REP_REQUESTID, sidr_rep_msg,
+		be32_to_cpu(cm_id_priv->id.remote_id));
+	IBA_SET(CM_SIDR_REP_STATUS, sidr_rep_msg, param->status);
 	IBA_SET(CM_SIDR_REP_QPN, sidr_rep_msg, param->qp_num);
-	sidr_rep_msg->service_id = cm_id_priv->id.service_id;
-	sidr_rep_msg->qkey = cpu_to_be32(param->qkey);
+	IBA_SET(CM_SIDR_REP_SERVICEID, sidr_rep_msg,
+		be64_to_cpu(cm_id_priv->id.service_id));
+	IBA_SET(CM_SIDR_REP_Q_KEY, sidr_rep_msg, param->qkey);
 
 	if (param->info && param->info_length)
 		memcpy(sidr_rep_msg->info, param->info, param->info_length);
@@ -3500,11 +3604,12 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	sidr_rep_msg = (struct cm_sidr_rep_msg *)
 				work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.sidr_rep_rcvd;
-	param->status = sidr_rep_msg->status;
-	param->qkey = be32_to_cpu(sidr_rep_msg->qkey);
+	param->status = IBA_GET(CM_SIDR_REP_STATUS, sidr_rep_msg);
+	param->qkey = IBA_GET(CM_SIDR_REP_Q_KEY, sidr_rep_msg);
 	param->qpn = IBA_GET(CM_SIDR_REP_QPN, sidr_rep_msg);
 	param->info = &sidr_rep_msg->info;
-	param->info_len = sidr_rep_msg->info_length;
+	param->info_len = IBA_GET(CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH,
+				  sidr_rep_msg);
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
 	work->cm_event.private_data = &sidr_rep_msg->private_data;
 }
@@ -3516,7 +3621,8 @@ static int cm_sidr_rep_handler(struct cm_work *work)
 
 	sidr_rep_msg = (struct cm_sidr_rep_msg *)
 				work->mad_recv_wc->recv_buf.mad;
-	cm_id_priv = cm_acquire_id(sidr_rep_msg->request_id, 0);
+	cm_id_priv = cm_acquire_id(
+		cpu_to_be32(IBA_GET(CM_SIDR_REP_REQUESTID, sidr_rep_msg)), 0);
 	if (!cm_id_priv)
 		return -EINVAL; /* Unmatched reply. */
 
-- 
2.24.1

