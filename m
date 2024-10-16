Return-Path: <linux-rdma+bounces-5422-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C17919A03F7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 10:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12853B259D9
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Oct 2024 08:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE881D1F75;
	Wed, 16 Oct 2024 08:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bUzVIFRO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423151D1E6A
	for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 08:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066602; cv=none; b=IK1Np15f3wDo4CjQgv/+fqVfIwU09ahhu/gdydkofdujuc7d2jauN+WMP5Zv5OYjusQ7QAi4DU4KICBLKxpeEs2KZnXCd2gc3fCgxSti367Yr8eypI22i8xVZwVlBwrslx2OuLxUcqdCU2gh3QeEkauI/hYw9XkgxuTe74Pe80g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066602; c=relaxed/simple;
	bh=vSepB/vPBSBzB9OIoiloVm2+3008BWto4Pv+R/UDxHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=L6aH+zl77i6WfGYjecxWhRDmxW8u0DWE9etPVT04DSJotYq144oFzvyS/igLIDSxsNJqfb75yl45TEH1jJR4aarzA580ExPejVMf/OdSdrUjve97Hot9aoid+k6W4WT0Yur+ij62ipZDneteqM7lBga3rQfbwugUtz5zBvHIZWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bUzVIFRO; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-71e4c2e36daso481437b3a.0
        for <linux-rdma@vger.kernel.org>; Wed, 16 Oct 2024 01:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1729066600; x=1729671400; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CupiautWDqE0qMLelVMWkvm6Cnmox0sS2+jLzZ+5DC8=;
        b=bUzVIFRO2ByRuC3gzhtIEUa30f/Ig4MwGplB0GJ1Wf5O1blcy32ql8j2XcjjxWtKQS
         p3dMyE5Hx7Ukw4ZPWzIVTkxFH9VPy2oezsP095POGiu2nMgT6XSjC790IZA5f+xXkUTK
         GPpu1HLKePE46C7q939Sq1hQZHaXcITmaVXwE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729066600; x=1729671400;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CupiautWDqE0qMLelVMWkvm6Cnmox0sS2+jLzZ+5DC8=;
        b=ar+9SAclEE6X9vIl+iRB4Y5AiG17wOwLp6TC9/V0609cvHIB3V3Hv+bz4iMV5eZ7tW
         Qsy9deup55ZiV7OKCkDnN1ECHB7Y0LOpiBf8BbugHGKExwSSmTqpUruIM9obqCG7WgBP
         ptb4MJDIchkzYPRba5P3RUp0s1IwaXh6r8pay+w1mzaGFabIbh1vllmp2OfhgukSsx4/
         W2al1K7jVrb9F82MxURGYqXTadyIFxUI6iwv20ahr2KM4ZIhakRmNMXUA2R0fFwWXEio
         Lj0LB237/SLBv1vt7WsKxXgR4tYdgz70lmDhMTHl1/3UOa7TgC+ta1uEoAz9AHuyy3+R
         9MVQ==
X-Gm-Message-State: AOJu0YxooN18rEZmGeQJCMghCRDnQo0GzAhFnWYBUtBaoCiOQh5+dRBN
	NjB5v9+j/lmb1SmSXtlIp0Md+HYD8X4FXc6aRu/dRbNULA7Yjtx6lzCxhlr/mw==
X-Google-Smtp-Source: AGHT+IFvARmaIh0nOQy3wwZccex/GAD/wFByc6/gXLZYXIbJ+RDQH0UC0dGf+OW5hOV6JlPiuxL+VQ==
X-Received: by 2002:a05:6a00:8c2:b0:71e:6f09:c0a8 with SMTP id d2e1a72fcca58-71e7d7f0e50mr5979602b3a.10.1729066600373;
        Wed, 16 Oct 2024 01:16:40 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71e77371099sm2632667b3a.15.2024.10.16.01.16.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Oct 2024 01:16:39 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v3 1/4] RDMA/bnxt_re: Add support for optimized modify QP
Date: Wed, 16 Oct 2024 00:55:42 -0700
Message-Id: <1729065346-1364-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
References: <1729065346-1364-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>

Modify QP improvements are for state transitions
from INIT -> RTR and RTR -> RTS.
In order to support the Modify QP Optimization feature,
the driver is expected to check for the feature support
in the CMDQ_QUERY_FUNC and register its support for this
feature with the FW in CMDQ_INITIALIZE_FIRMWARE.

Additionally, the driver is required to specify the new
fields and attribute masks for the transitions as follows:
1. INIT -> RTR:
   - New fields: srq_used, type.
   - enable srq_used when RC QP is configured to use SRQ.
   - set the type based on the QP type.
   - Mandatory masks:
     - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS,
           CMDQ_MODIFY_QP_MODIFY_MASK_PKEY
     - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_PKEY,
                      CMDQ_MODIFY_QP_MODIFY_MASK_QKEY
2. RTR -> RTS:
   - New fields: type
   - set the type based on the QP type.
   - Mandatory masks:
     - RC: CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS
     - UD QP and QP1: CMDQ_MODIFY_QP_MODIFY_MASK_QKEY

Reviewed-by: Saravanan Vajravel <saravanan.vajravel@broadcom.com>
Reviewed-by: Tushar Rane <tushar.rane@broadcom.com>
Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/qplib_fp.c   | 40 ++++++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c |  6 ++++-
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  5 ++++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   |  3 +++
 4 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/bnxt_re/qplib_fp.c b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
index 42e98e5..ff2340c 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_fp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_fp.c
@@ -1277,6 +1277,40 @@ static void __filter_modify_flags(struct bnxt_qplib_qp *qp)
 	}
 }
 
+static void bnxt_set_mandatory_attributes(struct bnxt_qplib_qp *qp,
+					  struct cmdq_modify_qp *req)
+{
+	u32 mandatory_flags = 0;
+
+	if (qp->type == CMDQ_MODIFY_QP_QP_TYPE_RC)
+		mandatory_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_ACCESS;
+
+	if (qp->cur_qp_state == CMDQ_MODIFY_QP_NEW_STATE_INIT &&
+	    qp->state == CMDQ_MODIFY_QP_NEW_STATE_RTR) {
+		if (qp->type == CMDQ_MODIFY_QP_QP_TYPE_RC && qp->srq)
+			req->flags = cpu_to_le16(CMDQ_MODIFY_QP_FLAGS_SRQ_USED);
+		mandatory_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_PKEY;
+	}
+
+	if (qp->type == CMDQ_MODIFY_QP_QP_TYPE_UD ||
+	    qp->type == CMDQ_MODIFY_QP_QP_TYPE_GSI)
+		mandatory_flags |= CMDQ_MODIFY_QP_MODIFY_MASK_QKEY;
+
+	qp->modify_flags |= mandatory_flags;
+	req->qp_type = qp->type;
+}
+
+static bool is_optimized_state_transition(struct bnxt_qplib_qp *qp)
+{
+	if ((qp->cur_qp_state == CMDQ_MODIFY_QP_NEW_STATE_INIT &&
+	     qp->state == CMDQ_MODIFY_QP_NEW_STATE_RTR) ||
+	    (qp->cur_qp_state == CMDQ_MODIFY_QP_NEW_STATE_RTR &&
+	     qp->state == CMDQ_MODIFY_QP_NEW_STATE_RTS))
+		return true;
+
+	return false;
+}
+
 int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 {
 	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
@@ -1293,6 +1327,12 @@ int bnxt_qplib_modify_qp(struct bnxt_qplib_res *res, struct bnxt_qplib_qp *qp)
 
 	/* Filter out the qp_attr_mask based on the state->new transition */
 	__filter_modify_flags(qp);
+	if (qp->modify_flags & CMDQ_MODIFY_QP_MODIFY_MASK_STATE) {
+		/* Set mandatory attributes for INIT -> RTR and RTR -> RTS transition */
+		if (_is_optimize_modify_qp_supported(res->dattr->dev_cap_flags2) &&
+		    is_optimized_state_transition(qp))
+			bnxt_set_mandatory_attributes(qp, &req);
+	}
 	bmask = qp->modify_flags;
 	req.modify_mask = cpu_to_le32(qp->modify_flags);
 	req.qp_cid = cpu_to_le32(qp->id);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 3ffaef0c..f5713e3 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -832,6 +832,7 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 	struct creq_initialize_fw_resp resp = {};
 	struct cmdq_initialize_fw req = {};
 	struct bnxt_qplib_cmdqmsg msg = {};
+	u16 flags = 0;
 	u8 pgsz, lvl;
 	int rc;
 
@@ -906,7 +907,10 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 
 skip_ctx_setup:
 	if (BNXT_RE_HW_RETX(rcfw->res->dattr->dev_cap_flags))
-		req.flags |= cpu_to_le16(CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED);
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED;
+	if (_is_optimize_modify_qp_supported(rcfw->res->dattr->dev_cap_flags2))
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED;
+	req.flags |= cpu_to_le16(flags);
 	req.stat_ctx_id = cpu_to_le32(ctx->stats.fw_id);
 	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
 	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index c2f7103..ef198a6 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -576,4 +576,9 @@ static inline bool _is_relaxed_ordering_supported(u16 dev_cap_ext_flags2)
 	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_MEMORY_REGION_RO_SUPPORTED;
 }
 
+static inline bool _is_optimize_modify_qp_supported(u16 dev_cap_ext_flags2)
+{
+	return dev_cap_ext_flags2 & CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED;
+}
+
 #endif /* __BNXT_QPLIB_RES_H__ */
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index 3ec8952..69d50d7 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -216,6 +216,8 @@ struct cmdq_initialize_fw {
 	__le16	flags;
 	#define CMDQ_INITIALIZE_FW_FLAGS_MRAV_RESERVATION_SPLIT          0x1UL
 	#define CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED     0x2UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_DRV_VERSION                     0x4UL
+	#define CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED    0x8UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	reserved8;
@@ -559,6 +561,7 @@ struct cmdq_modify_qp {
 	#define CMDQ_MODIFY_QP_OPCODE_LAST     CMDQ_MODIFY_QP_OPCODE_MODIFY_QP
 	u8	cmd_size;
 	__le16	flags;
+	 #define CMDQ_MODIFY_QP_FLAGS_SRQ_USED       0x1UL
 	__le16	cookie;
 	u8	resp_size;
 	u8	qp_type;
-- 
2.5.5


