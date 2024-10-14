Return-Path: <linux-rdma+bounces-5401-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2933E99D642
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 20:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE61A283A62
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Oct 2024 18:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E651C830B;
	Mon, 14 Oct 2024 18:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WspVL0PV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828441BFE10
	for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 18:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728929818; cv=none; b=uOjpMuuatxYpHJktLemNVO3LTzNIIovDR60mnb2NTKT71AJ54vK2BFEpNYzRYxDRTZhLmSa78Ui6AK6wH3pOCgRm8SwwEAP54UIw64rpgR8F4wu9803uFLjmN0WDwk6/lvbzPUjpkjMIsuMbNAepXYM19k6MFzjqPf60W+nYd3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728929818; c=relaxed/simple;
	bh=vSepB/vPBSBzB9OIoiloVm2+3008BWto4Pv+R/UDxHE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YSiLr9z+H9bwMNjDSOjNuDML8NALYnWJYLLuDeUtgJyf1TTfxXl5XyoxD0Bubx/mMAJRIa62MJtYL1zmWohwE8Xr3euw6jXgWpGI372bgu9tmIhXM0p9oqqbcTgvbV4ZLcb1+Ja+iFjCZj2cl3sX/gJzyvzxQ8LzL8RlLkk8eFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WspVL0PV; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20bb39d97d1so38620905ad.2
        for <linux-rdma@vger.kernel.org>; Mon, 14 Oct 2024 11:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728929816; x=1729534616; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CupiautWDqE0qMLelVMWkvm6Cnmox0sS2+jLzZ+5DC8=;
        b=WspVL0PV/rgToA0ggdk6Spn9CjK0DOAhiNf19FgwNtRqIwXAeF4b9gazqEIIKjuqO1
         xCHVNMlMM4qbWZMifw/SlHh1/gnMUz2+xffdFPzZvN9h3G4yhNpA9wHnr9WOk1Zyv0u8
         w0rRuxK2ZxTj9WNaO5NXLnoEKSO0Dqykp6tiM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728929816; x=1729534616;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CupiautWDqE0qMLelVMWkvm6Cnmox0sS2+jLzZ+5DC8=;
        b=OVU1YhzySyERoPbV+s0A5ZAPOvZ01habtfqhO+PSgaS0bfOwiFFi4o+X0WCmu3epiu
         uJE095zNlAeUSVrVqns2qttsc0NiHCUOL9Fgklbg79B5CpSkXLqmIgCrRO0Gn2OIUSMO
         XnQmrQEDx5XNvanC+1gFPIw9trfMhnIFpOxwSGfzql9/WS8jrxqtR6tAIm7BeGb1fa6q
         168KgXlwRtAXZxYGCp8zsH1tE4YPUskcwcXL2upU6qg4F1qheaIDVMFQ7sV+K+bNcKqP
         29ZKo1uz0mK4XiwYHrzCe/hSeCkkXuwIPbNUMxx90M0I5mecYoysVMFVWFVgMFFh9m2d
         CpOA==
X-Gm-Message-State: AOJu0YwCZfD4dkooraKzZFuuZnx7ddgBrpe1pfRoL7BtyHuyRv8CIE1o
	tQFeJj/Ii3XCws8D5P1VUJ/HEAKyCEvvVOseuEipku7dDdY7Hk+LDXu1uYErsA==
X-Google-Smtp-Source: AGHT+IF7UJ/h6T51eEdurQmn9wb++4Lhy5s+7+qiBvoFJLQzexJkAdBZv3/9RuepSJFlDDFJPolvCw==
X-Received: by 2002:a17:903:8c5:b0:20c:a97d:cc5c with SMTP id d9443c01a7336-20ca97dcf51mr157899585ad.6.1728929815731;
        Mon, 14 Oct 2024 11:16:55 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c8bada14asm69245605ad.7.2024.10.14.11.16.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Oct 2024 11:16:55 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 1/4] RDMA/bnxt_re: Add support for optimized modify QP
Date: Mon, 14 Oct 2024 10:55:58 -0700
Message-Id: <1728928561-25607-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728928561-25607-1-git-send-email-selvin.xavier@broadcom.com>
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


