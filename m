Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5632813F704
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:09:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387925AbgAPRAv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 12:00:51 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:37743 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729526AbgAPRAu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 12:00:50 -0500
Received: by mail-qk1-f194.google.com with SMTP id 21so19800111qky.4
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 09:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WLEm2nyAfTdsQ0hOEfAhCW8tGXOCMwrQg5KJxEL+Gfc=;
        b=ZVJaZx7IANpSCZqJHX7dIkRMSiObKoeTHg6Wl0pMjg3l+RqOZZhoapLsnKEHhdId+n
         u4Xx5BGg2jgH+sXVCOW7n7QmnaxH+TlGEELxIEALiWVwR68RzcN63XcoIci/UgiQVrD+
         +yOP45ZYaPfGKLWHAUmH4Mpr/dqBHoFZdu9d5Nh2h5XtOyHQgdklNY3j8NvpqfJ9Z+pP
         7vZlUR9D4zzkUaZVnZLEo4KrSIGhMHUkdoz9zm2PechNGC18wwASXxEK3Sh+cYF/qLqW
         XjgYUWSh4P5DGp/l+hJoAo+72XY8m4Us7Sj8CSVNJrvzuJVw1ZqHfwaoXkxe7lLNU57A
         Aq5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WLEm2nyAfTdsQ0hOEfAhCW8tGXOCMwrQg5KJxEL+Gfc=;
        b=rsxe5z5fShpBejGQUON4n1O4cU9AuHZ+12LTmScVJpjz3vh3O4jqMBZetr6wLUY5Fh
         /GD+jDZyWEjlLvnuu9jNgdQiwNMcqEixpiR+e948TVoucBhA+lEQSrqJ72Yy2HqYhsG3
         wnHLb9dLq4dZLoB8Uhqz1CWAbVxhuXHI9YlPD6VQYIDG1PDuZ03/hmG7ZeO09/5FfPzR
         88FZqkNbDYV9NL/DLLLmCPJgBr1rYaDp2pbuZ1Ad0BpJsMlh+xc4Mimy97JY9gJbbKvT
         SszAw4wxsxyPeWSo4cZ1S9mFN1/uPqZlTC92gtvwadPzZjJAnJxo/IxwX22q5pEszZPh
         P4vg==
X-Gm-Message-State: APjAAAXvygw+qZnnDDv5jC1RGNM1WmDMSRBuK/LqhJn+KYDn3wgnbJrc
        XguNyluNUvF9Ps6m1RCnQDqttRaqTT0=
X-Google-Smtp-Source: APXvYqy8Mkh0dq7Ot2ZEpZfB4drRAFOK04ATbPaYtQxWzeDzfp2pEKikWgpffVD9MUBjaJUsW2DkEg==
X-Received: by 2002:ae9:f009:: with SMTP id l9mr33278926qkg.259.1579194048644;
        Thu, 16 Jan 2020 09:00:48 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w20sm11622045qtj.4.2020.01.16.09.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 09:00:41 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1is8Vc-0007tg-8Y; Thu, 16 Jan 2020 13:00:40 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org, Leon Romanovsky <leonro@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 6/7] RDMA/cm: Use IBA functions for complex structure members
Date:   Thu, 16 Jan 2020 13:00:36 -0400
Message-Id: <20200116170037.30109-7-jgg@ziepe.ca>
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

Use a Coccinelle spatch to replace CM structure members used as
structures, arrays, or pointerswith IBA_GET/SET versions. Applied with

$ spatch --sp-file edits.sp --in-place drivers/infiniband/core/cm.c

The spatch file was generated using the template pattern:

@@
expression src;
expression len;
{struct} *msg;
@@
- memcpy(msg->{old_name}, src, len)
+ IBA_SET_MEM({new_name}, msg, src, len)
@@
{struct} *msg;
identifier x;
@@
- msg->{old_name}.x
+ IBA_GET_MEM_PTR({new_name}, msg)->x
@@
{struct} *msg;
@@
- &msg->{old_name}
+ IBA_GET_MEM_PTR({new_name}, msg)

For GIDs:
@@
{struct} *msg;
@@
- msg->{old_name}
+ *IBA_GET_MEM_PTR({new_name}, msg)

For non-GIDs:
@@
{struct} *msg;
@@
- msg->{old_name}
+ IBA_GET_MEM_PTR({new_name}, msg)

Iterated for every remaining IBA_CHECK_OFF()/IBA_CHECK_GET()
pairing. Touched up with clang-format after.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Tested-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/cm.c | 171 ++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
index 047ee560046e78..5ccd59f1ebb874 100644
--- a/drivers/infiniband/core/cm.c
+++ b/drivers/infiniband/core/cm.c
@@ -1280,13 +1280,17 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 		IBA_SET(CM_REQ_SRQ, req_msg, param->srq);
 	}
 
-	req_msg->primary_local_gid = pri_path->sgid;
-	req_msg->primary_remote_gid = pri_path->dgid;
+	*IBA_GET_MEM_PTR(CM_REQ_PRIMARY_LOCAL_PORT_GID, req_msg) =
+		pri_path->sgid;
+	*IBA_GET_MEM_PTR(CM_REQ_PRIMARY_REMOTE_PORT_GID, req_msg) =
+		pri_path->dgid;
 	if (pri_ext) {
-		req_msg->primary_local_gid.global.interface_id
-			= OPA_MAKE_ID(be32_to_cpu(pri_path->opa.slid));
-		req_msg->primary_remote_gid.global.interface_id
-			= OPA_MAKE_ID(be32_to_cpu(pri_path->opa.dlid));
+		IBA_GET_MEM_PTR(CM_REQ_PRIMARY_LOCAL_PORT_GID, req_msg)
+			->global.interface_id =
+			OPA_MAKE_ID(be32_to_cpu(pri_path->opa.slid));
+		IBA_GET_MEM_PTR(CM_REQ_PRIMARY_REMOTE_PORT_GID, req_msg)
+			->global.interface_id =
+			OPA_MAKE_ID(be32_to_cpu(pri_path->opa.dlid));
 	}
 	if (pri_path->hop_limit <= 1) {
 		IBA_SET(CM_REQ_PRIMARY_LOCAL_PORT_LID, req_msg,
@@ -1323,13 +1327,19 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 			alt_ext = opa_is_extended_lid(alt_path->opa.dlid,
 						      alt_path->opa.slid);
 
-		req_msg->alt_local_gid = alt_path->sgid;
-		req_msg->alt_remote_gid = alt_path->dgid;
+		*IBA_GET_MEM_PTR(CM_REQ_ALTERNATE_LOCAL_PORT_GID, req_msg) =
+			alt_path->sgid;
+		*IBA_GET_MEM_PTR(CM_REQ_ALTERNATE_REMOTE_PORT_GID, req_msg) =
+			alt_path->dgid;
 		if (alt_ext) {
-			req_msg->alt_local_gid.global.interface_id
-				= OPA_MAKE_ID(be32_to_cpu(alt_path->opa.slid));
-			req_msg->alt_remote_gid.global.interface_id
-				= OPA_MAKE_ID(be32_to_cpu(alt_path->opa.dlid));
+			IBA_GET_MEM_PTR(CM_REQ_ALTERNATE_LOCAL_PORT_GID,
+					req_msg)
+				->global.interface_id =
+				OPA_MAKE_ID(be32_to_cpu(alt_path->opa.slid));
+			IBA_GET_MEM_PTR(CM_REQ_ALTERNATE_REMOTE_PORT_GID,
+					req_msg)
+				->global.interface_id =
+				OPA_MAKE_ID(be32_to_cpu(alt_path->opa.dlid));
 		}
 		if (alt_path->hop_limit <= 1) {
 			IBA_SET(CM_REQ_ALTERNATE_LOCAL_PORT_LID, req_msg,
@@ -1364,8 +1374,8 @@ static void cm_format_req(struct cm_req_msg *req_msg,
 	}
 
 	if (param->private_data && param->private_data_len)
-		memcpy(req_msg->private_data, param->private_data,
-		       param->private_data_len);
+		IBA_SET_MEM(CM_REQ_PRIVATE_DATA, req_msg, param->private_data,
+			    param->private_data_len);
 }
 
 static int cm_validate_req_param(struct ib_cm_req_param *param)
@@ -1505,7 +1515,7 @@ static int cm_issue_rej(struct cm_port *port,
 
 	if (ari && ari_length) {
 		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
-		memcpy(rej_msg->ari, ari, ari_length);
+		IBA_SET_MEM(CM_REJ_ARI, rej_msg, ari, ari_length);
 	}
 
 	ret = ib_post_send_mad(msg, NULL);
@@ -1519,7 +1529,8 @@ static bool cm_req_has_alt_path(struct cm_req_msg *req_msg)
 {
 	return ((cpu_to_be16(
 			IBA_GET(CM_REQ_ALTERNATE_LOCAL_PORT_LID, req_msg))) ||
-		(ib_is_opa_gid(&req_msg->alt_local_gid)));
+		(ib_is_opa_gid(IBA_GET_MEM_PTR(CM_REQ_ALTERNATE_LOCAL_PORT_GID,
+					       req_msg))));
 }
 
 static void cm_path_set_rec_type(struct ib_device *ib_device, u8 port_num,
@@ -1545,10 +1556,12 @@ static void cm_format_path_lid_from_req(struct cm_req_msg *req_msg,
 				 IBA_GET(CM_REQ_PRIMARY_REMOTE_PORT_LID,
 					 req_msg));
 	} else {
-		lid = opa_get_lid_from_gid(&req_msg->primary_local_gid);
+		lid = opa_get_lid_from_gid(IBA_GET_MEM_PTR(
+			CM_REQ_PRIMARY_LOCAL_PORT_GID, req_msg));
 		sa_path_set_dlid(primary_path, lid);
 
-		lid = opa_get_lid_from_gid(&req_msg->primary_remote_gid);
+		lid = opa_get_lid_from_gid(IBA_GET_MEM_PTR(
+			CM_REQ_PRIMARY_REMOTE_PORT_GID, req_msg));
 		sa_path_set_slid(primary_path, lid);
 	}
 
@@ -1563,10 +1576,12 @@ static void cm_format_path_lid_from_req(struct cm_req_msg *req_msg,
 				 IBA_GET(CM_REQ_ALTERNATE_REMOTE_PORT_LID,
 					 req_msg));
 	} else {
-		lid = opa_get_lid_from_gid(&req_msg->alt_local_gid);
+		lid = opa_get_lid_from_gid(IBA_GET_MEM_PTR(
+			CM_REQ_ALTERNATE_LOCAL_PORT_GID, req_msg));
 		sa_path_set_dlid(alt_path, lid);
 
-		lid = opa_get_lid_from_gid(&req_msg->alt_remote_gid);
+		lid = opa_get_lid_from_gid(IBA_GET_MEM_PTR(
+			CM_REQ_ALTERNATE_REMOTE_PORT_GID, req_msg));
 		sa_path_set_slid(alt_path, lid);
 	}
 }
@@ -1575,8 +1590,10 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 				     struct sa_path_rec *primary_path,
 				     struct sa_path_rec *alt_path)
 {
-	primary_path->dgid = req_msg->primary_local_gid;
-	primary_path->sgid = req_msg->primary_remote_gid;
+	primary_path->dgid =
+		*IBA_GET_MEM_PTR(CM_REQ_PRIMARY_LOCAL_PORT_GID, req_msg);
+	primary_path->sgid =
+		*IBA_GET_MEM_PTR(CM_REQ_PRIMARY_REMOTE_PORT_GID, req_msg);
 	primary_path->flow_label =
 		cpu_to_be32(IBA_GET(CM_REQ_PRIMARY_FLOW_LABEL, req_msg));
 	primary_path->hop_limit = IBA_GET(CM_REQ_PRIMARY_HOP_LIMIT, req_msg);
@@ -1600,8 +1617,10 @@ static void cm_format_paths_from_req(struct cm_req_msg *req_msg,
 		primary_path->roce.route_resolved = false;
 
 	if (cm_req_has_alt_path(req_msg)) {
-		alt_path->dgid = req_msg->alt_local_gid;
-		alt_path->sgid = req_msg->alt_remote_gid;
+		alt_path->dgid = *IBA_GET_MEM_PTR(
+			CM_REQ_ALTERNATE_LOCAL_PORT_GID, req_msg);
+		alt_path->sgid = *IBA_GET_MEM_PTR(
+			CM_REQ_ALTERNATE_REMOTE_PORT_GID, req_msg);
 		alt_path->flow_label = cpu_to_be32(
 			IBA_GET(CM_REQ_ALTERNATE_FLOW_LABEL, req_msg));
 		alt_path->hop_limit =
@@ -1714,7 +1733,8 @@ static void cm_format_req_event(struct cm_work *work,
 	param->rnr_retry_count = IBA_GET(CM_REQ_RNR_RETRY_COUNT, req_msg);
 	param->srq = IBA_GET(CM_REQ_SRQ, req_msg);
 	param->ppath_sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
-	work->cm_event.private_data = &req_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_REQ_PRIVATE_DATA, req_msg);
 }
 
 static void cm_process_work(struct cm_id_private *cm_id_priv,
@@ -1756,7 +1776,8 @@ static void cm_format_mra(struct cm_mra_msg *mra_msg,
 	IBA_SET(CM_MRA_SERVICE_TIMEOUT, mra_msg, service_timeout);
 
 	if (private_data && private_data_len)
-		memcpy(mra_msg->private_data, private_data, private_data_len);
+		IBA_SET_MEM(CM_MRA_PRIVATE_DATA, mra_msg, private_data,
+			    private_data_len);
 }
 
 static void cm_format_rej(struct cm_rej_msg *rej_msg,
@@ -1798,11 +1819,12 @@ static void cm_format_rej(struct cm_rej_msg *rej_msg,
 	IBA_SET(CM_REJ_REASON, rej_msg, reason);
 	if (ari && ari_length) {
 		IBA_SET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg, ari_length);
-		memcpy(rej_msg->ari, ari, ari_length);
+		IBA_SET_MEM(CM_REJ_ARI, rej_msg, ari, ari_length);
 	}
 
 	if (private_data && private_data_len)
-		memcpy(rej_msg->private_data, private_data, private_data_len);
+		IBA_SET_MEM(CM_REJ_PRIVATE_DATA, rej_msg, private_data,
+			    private_data_len);
 }
 
 static void cm_dup_req_handler(struct cm_work *work,
@@ -2012,10 +2034,11 @@ static int cm_req_handler(struct cm_work *work)
 		work->path[0].rec_type =
 			sa_conv_gid_to_pathrec_type(gid_attr->gid_type);
 	} else {
-		cm_path_set_rec_type(work->port->cm_dev->ib_device,
-				     work->port->port_num,
-				     &work->path[0],
-				     &req_msg->primary_local_gid);
+		cm_path_set_rec_type(
+			work->port->cm_dev->ib_device, work->port->port_num,
+			&work->path[0],
+			IBA_GET_MEM_PTR(CM_REQ_PRIMARY_LOCAL_PORT_GID,
+					req_msg));
 	}
 	if (cm_req_has_alt_path(req_msg))
 		work->path[1].rec_type = work->path[0].rec_type;
@@ -2117,8 +2140,8 @@ static void cm_format_rep(struct cm_rep_msg *rep_msg,
 	}
 
 	if (param->private_data && param->private_data_len)
-		memcpy(rep_msg->private_data, param->private_data,
-		       param->private_data_len);
+		IBA_SET_MEM(CM_REP_PRIVATE_DATA, rep_msg, param->private_data,
+			    param->private_data_len);
 }
 
 int ib_send_cm_rep(struct ib_cm_id *cm_id,
@@ -2184,7 +2207,8 @@ static void cm_format_rtu(struct cm_rtu_msg *rtu_msg,
 		be32_to_cpu(cm_id_priv->id.remote_id));
 
 	if (private_data && private_data_len)
-		memcpy(rtu_msg->private_data, private_data, private_data_len);
+		IBA_SET_MEM(CM_RTU_PRIVATE_DATA, rtu_msg, private_data,
+			    private_data_len);
 }
 
 int ib_send_cm_rtu(struct ib_cm_id *cm_id,
@@ -2259,7 +2283,8 @@ static void cm_format_rep_event(struct cm_work *work, enum ib_qp_type qp_type)
 	param->flow_control = IBA_GET(CM_REP_END_TO_END_FLOW_CONTROL, rep_msg);
 	param->rnr_retry_count = IBA_GET(CM_REP_RNR_RETRY_COUNT, rep_msg);
 	param->srq = IBA_GET(CM_REP_SRQ, rep_msg);
-	work->cm_event.private_data = &rep_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_REP_PRIVATE_DATA, rep_msg);
 }
 
 static void cm_dup_rep_handler(struct cm_work *work)
@@ -2472,7 +2497,8 @@ static int cm_rtu_handler(struct cm_work *work)
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	work->cm_event.private_data = &rtu_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_RTU_PRIVATE_DATA, rtu_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_REP_SENT &&
@@ -2515,7 +2541,8 @@ static void cm_format_dreq(struct cm_dreq_msg *dreq_msg,
 		be32_to_cpu(cm_id_priv->remote_qpn));
 
 	if (private_data && private_data_len)
-		memcpy(dreq_msg->private_data, private_data, private_data_len);
+		IBA_SET_MEM(CM_DREQ_PRIVATE_DATA, dreq_msg, private_data,
+			    private_data_len);
 }
 
 int ib_send_cm_dreq(struct ib_cm_id *cm_id,
@@ -2581,7 +2608,8 @@ static void cm_format_drep(struct cm_drep_msg *drep_msg,
 		be32_to_cpu(cm_id_priv->id.remote_id));
 
 	if (private_data && private_data_len)
-		memcpy(drep_msg->private_data, private_data, private_data_len);
+		IBA_SET_MEM(CM_DREP_PRIVATE_DATA, drep_msg, private_data,
+			    private_data_len);
 }
 
 int ib_send_cm_drep(struct ib_cm_id *cm_id,
@@ -2683,7 +2711,8 @@ static int cm_dreq_handler(struct cm_work *work)
 		return -EINVAL;
 	}
 
-	work->cm_event.private_data = &dreq_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_DREQ_PRIVATE_DATA, dreq_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->local_qpn !=
@@ -2759,7 +2788,8 @@ static int cm_drep_handler(struct cm_work *work)
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	work->cm_event.private_data = &drep_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_DREP_PRIVATE_DATA, drep_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_DREQ_SENT &&
@@ -2855,10 +2885,11 @@ static void cm_format_rej_event(struct cm_work *work)
 
 	rej_msg = (struct cm_rej_msg *)work->mad_recv_wc->recv_buf.mad;
 	param = &work->cm_event.param.rej_rcvd;
-	param->ari = rej_msg->ari;
+	param->ari = IBA_GET_MEM_PTR(CM_REJ_ARI, rej_msg);
 	param->ari_length = IBA_GET(CM_REJ_REJECTED_INFO_LENGTH, rej_msg);
 	param->reason = IBA_GET(CM_REJ_REASON, rej_msg);
-	work->cm_event.private_data = &rej_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_REJ_PRIVATE_DATA, rej_msg);
 }
 
 static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
@@ -2871,8 +2902,9 @@ static struct cm_id_private * cm_acquire_rejected_id(struct cm_rej_msg *rej_msg)
 
 	if (IBA_GET(CM_REJ_REASON, rej_msg) == IB_CM_REJ_TIMEOUT) {
 		spin_lock_irq(&cm.lock);
-		timewait_info = cm_find_remote_id( *((__be64 *) rej_msg->ari),
-						  remote_id);
+		timewait_info = cm_find_remote_id(
+			*((__be64 *)IBA_GET_MEM_PTR(CM_REJ_ARI, rej_msg)),
+			remote_id);
 		if (!timewait_info) {
 			spin_unlock_irq(&cm.lock);
 			return NULL;
@@ -3072,7 +3104,8 @@ static int cm_mra_handler(struct cm_work *work)
 	if (!cm_id_priv)
 		return -EINVAL;
 
-	work->cm_event.private_data = &mra_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_MRA_PRIVATE_DATA, mra_msg);
 	work->cm_event.param.mra_rcvd.service_timeout =
 		IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg);
 	timeout = cm_convert_to_ms(IBA_GET(CM_MRA_SERVICE_TIMEOUT, mra_msg)) +
@@ -3151,10 +3184,12 @@ static void cm_format_path_lid_from_lap(struct cm_lap_msg *lap_msg,
 		sa_path_set_slid(path, IBA_GET(CM_LAP_ALTERNATE_REMOTE_PORT_LID,
 					       lap_msg));
 	} else {
-		lid = opa_get_lid_from_gid(&lap_msg->alt_local_gid);
+		lid = opa_get_lid_from_gid(IBA_GET_MEM_PTR(
+			CM_LAP_ALTERNATE_LOCAL_PORT_GID, lap_msg));
 		sa_path_set_dlid(path, lid);
 
-		lid = opa_get_lid_from_gid(&lap_msg->alt_remote_gid);
+		lid = opa_get_lid_from_gid(IBA_GET_MEM_PTR(
+			CM_LAP_ALTERNATE_REMOTE_PORT_GID, lap_msg));
 		sa_path_set_slid(path, lid);
 	}
 }
@@ -3163,8 +3198,9 @@ static void cm_format_path_from_lap(struct cm_id_private *cm_id_priv,
 				    struct sa_path_rec *path,
 				    struct cm_lap_msg *lap_msg)
 {
-	path->dgid = lap_msg->alt_local_gid;
-	path->sgid = lap_msg->alt_remote_gid;
+	path->dgid = *IBA_GET_MEM_PTR(CM_LAP_ALTERNATE_LOCAL_PORT_GID, lap_msg);
+	path->sgid =
+		*IBA_GET_MEM_PTR(CM_LAP_ALTERNATE_REMOTE_PORT_GID, lap_msg);
 	path->flow_label =
 		cpu_to_be32(IBA_GET(CM_LAP_ALTERNATE_FLOW_LABEL, lap_msg));
 	path->hop_limit = IBA_GET(CM_LAP_ALTERNATE_HOP_LIMIT, lap_msg);
@@ -3209,12 +3245,13 @@ static int cm_lap_handler(struct cm_work *work)
 	param = &work->cm_event.param.lap_rcvd;
 	memset(&work->path[0], 0, sizeof(work->path[1]));
 	cm_path_set_rec_type(work->port->cm_dev->ib_device,
-			     work->port->port_num,
-			     &work->path[0],
-			     &lap_msg->alt_local_gid);
+			     work->port->port_num, &work->path[0],
+			     IBA_GET_MEM_PTR(CM_LAP_ALTERNATE_LOCAL_PORT_GID,
+					     lap_msg));
 	param->alternate_path = &work->path[0];
 	cm_format_path_from_lap(cm_id_priv, param->alternate_path, lap_msg);
-	work->cm_event.private_data = &lap_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_LAP_PRIVATE_DATA, lap_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED)
@@ -3301,10 +3338,12 @@ static int cm_apr_handler(struct cm_work *work)
 
 	work->cm_event.param.apr_rcvd.ap_status =
 		IBA_GET(CM_APR_AR_STATUS, apr_msg);
-	work->cm_event.param.apr_rcvd.apr_info = &apr_msg->info;
+	work->cm_event.param.apr_rcvd.apr_info =
+		IBA_GET_MEM_PTR(CM_APR_ADDITIONAL_INFORMATION, apr_msg);
 	work->cm_event.param.apr_rcvd.info_len =
 		IBA_GET(CM_APR_ADDITIONAL_INFORMATION_LENGTH, apr_msg);
-	work->cm_event.private_data = &apr_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_APR_PRIVATE_DATA, apr_msg);
 
 	spin_lock_irq(&cm_id_priv->lock);
 	if (cm_id_priv->id.state != IB_CM_ESTABLISHED ||
@@ -3384,8 +3423,8 @@ static void cm_format_sidr_req(struct cm_sidr_req_msg *sidr_req_msg,
 		be64_to_cpu(param->service_id));
 
 	if (param->private_data && param->private_data_len)
-		memcpy(sidr_req_msg->private_data, param->private_data,
-		       param->private_data_len);
+		IBA_SET_MEM(CM_SIDR_REQ_PRIVATE_DATA, sidr_req_msg,
+			    param->private_data, param->private_data_len);
 }
 
 int ib_send_cm_sidr_req(struct ib_cm_id *cm_id,
@@ -3456,7 +3495,8 @@ static void cm_format_sidr_req_event(struct cm_work *work,
 	param->bth_pkey = cm_get_bth_pkey(work);
 	param->port = work->port->port_num;
 	param->sgid_attr = rx_cm_id->av.ah_attr.grh.sgid_attr;
-	work->cm_event.private_data = &sidr_req_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_SIDR_REQ_PRIVATE_DATA, sidr_req_msg);
 }
 
 static int cm_sidr_req_handler(struct cm_work *work)
@@ -3540,11 +3580,12 @@ static void cm_format_sidr_rep(struct cm_sidr_rep_msg *sidr_rep_msg,
 	IBA_SET(CM_SIDR_REP_Q_KEY, sidr_rep_msg, param->qkey);
 
 	if (param->info && param->info_length)
-		memcpy(sidr_rep_msg->info, param->info, param->info_length);
+		IBA_SET_MEM(CM_SIDR_REP_ADDITIONAL_INFORMATION, sidr_rep_msg,
+			    param->info, param->info_length);
 
 	if (param->private_data && param->private_data_len)
-		memcpy(sidr_rep_msg->private_data, param->private_data,
-		       param->private_data_len);
+		IBA_SET_MEM(CM_SIDR_REP_PRIVATE_DATA, sidr_rep_msg,
+			    param->private_data, param->private_data_len);
 }
 
 int ib_send_cm_sidr_rep(struct ib_cm_id *cm_id,
@@ -3607,11 +3648,13 @@ static void cm_format_sidr_rep_event(struct cm_work *work,
 	param->status = IBA_GET(CM_SIDR_REP_STATUS, sidr_rep_msg);
 	param->qkey = IBA_GET(CM_SIDR_REP_Q_KEY, sidr_rep_msg);
 	param->qpn = IBA_GET(CM_SIDR_REP_QPN, sidr_rep_msg);
-	param->info = &sidr_rep_msg->info;
+	param->info = IBA_GET_MEM_PTR(CM_SIDR_REP_ADDITIONAL_INFORMATION,
+				      sidr_rep_msg);
 	param->info_len = IBA_GET(CM_SIDR_REP_ADDITIONAL_INFORMATION_LENGTH,
 				  sidr_rep_msg);
 	param->sgid_attr = cm_id_priv->av.ah_attr.grh.sgid_attr;
-	work->cm_event.private_data = &sidr_rep_msg->private_data;
+	work->cm_event.private_data =
+		IBA_GET_MEM_PTR(CM_SIDR_REP_PRIVATE_DATA, sidr_rep_msg);
 }
 
 static int cm_sidr_rep_handler(struct cm_work *work)
-- 
2.24.1

