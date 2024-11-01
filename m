Return-Path: <linux-rdma+bounces-5687-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D3A9B8980
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 03:55:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDAD01F2281D
	for <lists+linux-rdma@lfdr.de>; Fri,  1 Nov 2024 02:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4830413A261;
	Fri,  1 Nov 2024 02:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="bjKZZgL7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCDF313BC0D
	for <linux-rdma@vger.kernel.org>; Fri,  1 Nov 2024 02:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730429751; cv=none; b=KtBxvvVzpUl/tWCWrZpeFhpFbqekRs+9e1I1k2M6T4C6m06PauVqbcXMnanVgiDj1AenZid0Hk6OjfFIFa/oqrttNMO3rxI9Ypk0IxpiEflhQPlVwasbOjuaExzbmjuwVzdYb9AiEu9OKZL9BsGqWagqDU3ief8iuZHcc8TO4Ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730429751; c=relaxed/simple;
	bh=PHMDSF3KiD7pKc7kTJ5ZbiWw+y4abP45wJQbFM6Vl30=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OQreCoxzuSVKJHs7XCe5SGqAwdtBMurthZHiTL3Zvg4Sn3/TmbfAxmBcV7I7TXkYExnpS9Ei2qU1MecYj8755wGEapJ+7wuPnqS3xWhGR4BHJEhEHmVoE0AxVBuZ9RPnw9UzpCyxrBbcTzm9cBvmkP67SI7joFcY2OSeK/fjtM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=bjKZZgL7; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2110a622d76so9561245ad.3
        for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 19:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1730429745; x=1731034545; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9KDXtDtuqIsvelg4MNDey7jtAriRPY9+zIR3Vm9THs4=;
        b=bjKZZgL7WL3nJLg4fCXjZ/b1NSCFQTogqcZERHqcsSyzTfvexQZuZ21NUgBbQvBte0
         05aTJyacaFe10LGJUwUCIjJfFl6C6eeX6L4qua+YxYHwMP+G3vygS/r25bixzwef9CVB
         F+3aRo0W40cvWizqzUFj1TQXmRHLBMTXRkyg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730429745; x=1731034545;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9KDXtDtuqIsvelg4MNDey7jtAriRPY9+zIR3Vm9THs4=;
        b=MEh9Q6usZFramFkIJO9zLZd12XMkflC6nm2Sn1uh+/WHN81zmSnD0J7O3tBk9Pbwul
         W+7/9Id/yRVKjJze/nNTS6S6HR29VN+gTWTqDDf4O7AZt3DjF10f2WCUZa6I3e7/CxGP
         4TMuSGXpRGhZA2L1yNU8FEctpKrqsIVbrKBpDU5z6qPBFmrYbc45UxhjLQiOZdFsSD/s
         2VCmRW7VxTQiNZmRZMoWrDsgYuteEQ2/v4C32rPimAFe5tUVD1dPOTAWpdbdOg/pykSS
         vpjjZPbbNor28N3ygBXabnN5HAkl8FakAIqO0wH1jy5Ic9g0evGIE92TtFbriHNtrN1u
         cjZg==
X-Gm-Message-State: AOJu0YzNDgb+4tQufuaxyz+Din70w2VaYweX+qEiMZMPnCg649Gu5A2C
	8RGLwnyl1MYAszCUi1yr+yOAMlqZCdkktuZoQTb3MyBthJcaJ86dOU4PRSRLVA==
X-Google-Smtp-Source: AGHT+IEQz0qHC9Hdt1/1gBDK0gJK35ulrtV6YBnjTDQ9jSRU+bwk9r+6ITzJXbxxI8TElMhexwjGDw==
X-Received: by 2002:a17:902:d501:b0:20c:a7d8:e428 with SMTP id d9443c01a7336-210c68aa356mr309055135ad.7.1730429745188;
        Thu, 31 Oct 2024 19:55:45 -0700 (PDT)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211056edc1asm14961005ad.57.2024.10.31.19.55.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Oct 2024 19:55:44 -0700 (PDT)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	kashyap.desai@broadcom.com,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH for-next v2 2/4] RDMA/bnxt_re: Add support for querying HW contexts
Date: Thu, 31 Oct 2024 19:34:41 -0700
Message-Id: <1730428483-17841-3-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
References: <1730428483-17841-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Implements support for querying the hardware resource
contexts. This raw data can be used for the debugging
of the field issues.

Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    | 19 ++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  2 ++
 drivers/infiniband/hw/bnxt_re/qplib_sp.c   | 35 ++++++++++++++++++++++++++
 drivers/infiniband/hw/bnxt_re/qplib_sp.h   |  2 ++
 drivers/infiniband/hw/bnxt_re/roce_hsi.h   | 40 ++++++++++++++++++++++++++++++
 5 files changed, 98 insertions(+)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index bb28a1f..49186a1 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -247,4 +247,23 @@ static inline void bnxt_re_set_pacing_dev_state(struct bnxt_re_dev *rdev)
 	rdev->qplib_res.pacing_data->dev_err_state =
 		test_bit(BNXT_RE_FLAG_ERR_DEVICE_DETACHED, &rdev->flags);
 }
+
+static inline int bnxt_re_read_context_allowed(struct bnxt_re_dev *rdev)
+{
+	if (!bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx) ||
+	    rdev->rcfw.res->cctx->hwrm_intf_ver < HWRM_VERSION_READ_CTX)
+		return -EOPNOTSUPP;
+	return 0;
+}
+
+#define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P5	1088
+#define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P5		128
+#define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P5	128
+#define BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P5	192
+
+#define BNXT_RE_CONTEXT_TYPE_QPC_SIZE_P7	1088
+#define BNXT_RE_CONTEXT_TYPE_CQ_SIZE_P7		192
+#define BNXT_RE_CONTEXT_TYPE_MRW_SIZE_P7	192
+#define BNXT_RE_CONTEXT_TYPE_SRQ_SIZE_P7	192
+
 #endif
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 45996e6..3e723d7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -131,6 +131,8 @@ static inline u32 bnxt_qplib_set_cmd_slots(struct cmdq_base *req)
 #define RCFW_CMD_IS_BLOCKING		0x8000
 
 #define HWRM_VERSION_DEV_ATTR_MAX_DPI  0x1000A0000000DULL
+/* HWRM version 1.10.3.18 */
+#define HWRM_VERSION_READ_CTX           0x1000A00030012
 
 /* Crsq buf is 1024-Byte */
 struct bnxt_qplib_crsbe {
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.c b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
index 4f75e7e..ad636d7 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.c
@@ -972,3 +972,38 @@ int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_rcfw_send_message(res->rcfw, &msg);
 	return rc;
 }
+
+int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 res_type,
+			    u32 xid, u32 resp_size, void *resp_va)
+{
+	struct creq_read_context resp = {};
+	struct bnxt_qplib_cmdqmsg msg = {};
+	struct cmdq_read_context req = {};
+	struct bnxt_qplib_rcfw_sbuf sbuf;
+	int rc;
+
+	sbuf.size = resp_size;
+	sbuf.sb = dma_alloc_coherent(&rcfw->pdev->dev, sbuf.size,
+				     &sbuf.dma_addr, GFP_KERNEL);
+	if (!sbuf.sb)
+		return -ENOMEM;
+
+	bnxt_qplib_rcfw_cmd_prep((struct cmdq_base *)&req,
+				 CMDQ_BASE_OPCODE_READ_CONTEXT, sizeof(req));
+	req.resp_addr = cpu_to_le64(sbuf.dma_addr);
+	req.resp_size = resp_size / BNXT_QPLIB_CMDQE_UNITS;
+
+	req.xid = cpu_to_le32(xid);
+	req.type = res_type;
+
+	bnxt_qplib_fill_cmdqmsg(&msg, &req, &resp, &sbuf, sizeof(req),
+				sizeof(resp), 0);
+	rc = bnxt_qplib_rcfw_send_message(rcfw, &msg);
+	if (rc)
+		goto free_mem;
+
+	memcpy(resp_va, sbuf.sb, resp_size);
+free_mem:
+	dma_free_coherent(&rcfw->pdev->dev, sbuf.size, sbuf.sb, sbuf.dma_addr);
+	return rc;
+}
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_sp.h b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
index acd9c14..29b841a 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_sp.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_sp.h
@@ -352,6 +352,8 @@ int bnxt_qplib_qext_stat(struct bnxt_qplib_rcfw *rcfw, u32 fid,
 			 struct bnxt_qplib_ext_stat *estat);
 int bnxt_qplib_modify_cc(struct bnxt_qplib_res *res,
 			 struct bnxt_qplib_cc_param *cc_param);
+int bnxt_qplib_read_context(struct bnxt_qplib_rcfw *rcfw, u8 type, u32 xid,
+			    u32 resp_size, void *resp_va);
 
 #define BNXT_VAR_MAX_WQE       4352
 #define BNXT_VAR_MAX_SLOT_ALIGN 256
diff --git a/drivers/infiniband/hw/bnxt_re/roce_hsi.h b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
index a7679ee..d9c5373 100644
--- a/drivers/infiniband/hw/bnxt_re/roce_hsi.h
+++ b/drivers/infiniband/hw/bnxt_re/roce_hsi.h
@@ -2265,6 +2265,46 @@ struct creq_set_func_resources_resp {
 	u8	reserved48[6];
 };
 
+/* cmdq_read_context (size:192b/24B) */
+struct cmdq_read_context {
+	u8	opcode;
+	#define CMDQ_READ_CONTEXT_OPCODE_READ_CONTEXT 0x85UL
+	#define CMDQ_READ_CONTEXT_OPCODE_LAST        CMDQ_READ_CONTEXT_OPCODE_READ_CONTEXT
+	u8	cmd_size;
+	__le16	flags;
+	__le16	cookie;
+	u8	resp_size;
+	u8	reserved8;
+	__le64	resp_addr;
+	__le32	xid;
+	u8	type;
+	#define CMDQ_READ_CONTEXT_TYPE_QPC 0x0UL
+	#define CMDQ_READ_CONTEXT_TYPE_CQ  0x1UL
+	#define CMDQ_READ_CONTEXT_TYPE_MRW 0x2UL
+	#define CMDQ_READ_CONTEXT_TYPE_SRQ 0x3UL
+	#define CMDQ_READ_CONTEXT_TYPE_LAST CMDQ_READ_CONTEXT_TYPE_SRQ
+	u8	unused_0[3];
+};
+
+/* creq_read_context (size:128b/16B) */
+struct creq_read_context {
+	u8	type;
+	#define CREQ_READ_CONTEXT_TYPE_MASK    0x3fUL
+	#define CREQ_READ_CONTEXT_TYPE_SFT     0
+	#define CREQ_READ_CONTEXT_TYPE_QP_EVENT  0x38UL
+	#define CREQ_READ_CONTEXT_TYPE_LAST     CREQ_READ_CONTEXT_TYPE_QP_EVENT
+	u8	status;
+	__le16	cookie;
+	__le32	reserved32;
+	u8	v;
+	#define CREQ_READ_CONTEXT_V     0x1UL
+	u8	event;
+	#define CREQ_READ_CONTEXT_EVENT_READ_CONTEXT 0x85UL
+	#define CREQ_READ_CONTEXT_EVENT_LAST        CREQ_READ_CONTEXT_EVENT_READ_CONTEXT
+	__le16	reserved16;
+	__le32	reserved_32;
+};
+
 /* cmdq_map_tc_to_cos (size:192b/24B) */
 struct cmdq_map_tc_to_cos {
 	u8	opcode;
-- 
2.5.5


