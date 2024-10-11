Return-Path: <linux-rdma+bounces-5373-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C15B6999C14
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 07:24:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D461C217B3
	for <lists+linux-rdma@lfdr.de>; Fri, 11 Oct 2024 05:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0263A1F4732;
	Fri, 11 Oct 2024 05:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ObS1g3nV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AB31CC174
	for <linux-rdma@vger.kernel.org>; Fri, 11 Oct 2024 05:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624291; cv=none; b=Mqa/5tX6vqsKjsbLjoBWwnwAA2UQDNhNFWtIHo1zvKpeXsmtkNcgXV9LjpAsnPG/5IO4ybwMmIjeYv0u+hZaWB972vkJau5VFqrrifX3NnMd3zdhx1EPBtcvpvuebfsGKUdvEwAz7WnU46OAEqp9Qw0Nw3E1H2K9d6AenwUqwTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624291; c=relaxed/simple;
	bh=wepGIUrEj0oV/ZxA7CEA/m6Nbwt+xJ4ox2HQlHCpnI8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=TeJvMdNfQ0ne/EDySmDHF4CaNrf8oIEV8+Lsqruv4xZQhaYgjo+rWX0ciUHhHvMfeMDqy41Hzfy2TMSy/YuDzKiXqWbJTs2OaDX8Sd6wCGsdR3O5leu5JSnUtinbeqZ99ZMmllsqqA/7ga9Nuds4TUvYFCDu7kyQ+r0d4elx9hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ObS1g3nV; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71def8abc2fso1293903b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 10 Oct 2024 22:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1728624288; x=1729229088; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jhJsTANm1sHJvRAZHEB1v/2B6JnSbjrf5lEnpghIzd8=;
        b=ObS1g3nVl53o8i5FM3wBuchGxCcedZipzVxjSFQH83q74+qNsmXLowp4fkOwJvxvfh
         vzM3JZxFz0dyeKblOzwT9IJnao4+gdnIOLsUEfqirT98E12oZZgSj0SnlAsXmc9VAMyA
         0qDv44ozc7n6fsqxlL0ANcsTJ/poP1A5mA5d8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728624288; x=1729229088;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jhJsTANm1sHJvRAZHEB1v/2B6JnSbjrf5lEnpghIzd8=;
        b=Z2o173fZMpjCJC6qHEiviMH/gtEhZaYGYd+PyMPYBa7WeXCvM+Wyk+QyI0WlxWqQWB
         UzsXpbKqLzPpDcDRusfCG2tXyeVUPR7xSZYj5X1CcQ/1l4SnjfFUjt4VfYZFV5f76p2Q
         KdJttncYEzmuW6o/jfAtMVykYZwTvSm4+jLDDvObj+dynX2dIr6esel49ukQDHlJn9VR
         30b/Q263sD+UNaWlz4kS6+dQLNMx7mj4FggfGrdWmspZdox1wlzDFbR1zz9Y3Q/ywyci
         +D/0K/r2acRaExuVvRB/Oe901gv/HJBPoHHCwTP6rda7bYNaBKY64DAvAw2Z1iYGCaUF
         O8Kg==
X-Gm-Message-State: AOJu0YyDnxfhueR4gANeMS9OsAPgRxUxZMjgp8zt9h/kV8lBfCojVdOx
	nztHxMCfIgK65aH4JOsDNepKqISeA6YzrbGOvfHyW9TfViF6y6oqjMZ2Fuc1PQ==
X-Google-Smtp-Source: AGHT+IFtLNdmxecgtScASmeQOB5ZuNetm+WyX4iLGkHcngN/cGIhL6QG8HCm/xFM5xpTj+7JdsJi3g==
X-Received: by 2002:a05:6a20:cd8f:b0:1c6:fb66:cfe with SMTP id adf61e73a8af0-1d8bcf32aefmr1925097637.21.1728624288408;
        Thu, 10 Oct 2024 22:24:48 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2d5f09ff1sm2377069a91.26.2024.10.10.22.24.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Oct 2024 22:24:47 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next 1/4] RDMA/bnxt_re: Add support for optimized modify QP
Date: Thu, 10 Oct 2024 22:03:52 -0700
Message-Id: <1728623035-30657-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
References: <1728623035-30657-1-git-send-email-selvin.xavier@broadcom.com>
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
index 42e98e5..775604f 100644
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
+			req->flags = CMDQ_MODIFY_QP_FLAGS_SRQ_USED;
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
index 3ffaef0c..f66c5e4 100644
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
+		flags |= cpu_to_le16(CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED);
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


