Return-Path: <linux-rdma+bounces-13001-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96959B3BB61
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 14:32:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D21917AD76
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Aug 2025 12:32:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CED31A544;
	Fri, 29 Aug 2025 12:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Gu9pJod0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-io1-f99.google.com (mail-io1-f99.google.com [209.85.166.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B74317700
	for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 12:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756470713; cv=none; b=nMxeEpcxouzmP/3wV5cDLBy59U+xExVBzEjDEX3kRTV3FAxbJehL4uBmN63HcNGO0BzonZLBFUlt3UkKN2z7fvB1+WPy61mY9s0pFJTCLfILy/iHAM4BGsh++wgUiw4XnvyY3ebC3jIex0ymyeSUhWrqebkIZ2eqiAn711KImMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756470713; c=relaxed/simple;
	bh=1sMdEwJ19bZWzqb73aqbSTCvL6CTu7tWK6BaJq2oMPg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nJUP5jKLbvRUvgB0uxDfRDlJcXAGdHKCHgoTmj7VVNnFu/+7Nfg3epDKlmmYH7TI6BQOFdOb427eqYWkX1w7DIIlwpB/uJdzI0x3/7tMKtZQEpkDsw752SA7WWk0WEamZeuZ5h9umSS41NNz2yfRUrutQqgG9cytjWXneycmTgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Gu9pJod0; arc=none smtp.client-ip=209.85.166.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-io1-f99.google.com with SMTP id ca18e2360f4ac-88428b19ea9so102228239f.0
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756470711; x=1757075511;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAGq+6QY91x8bNrMnFL8ELYKX5LVTxyvgkeVDMauwvQ=;
        b=qnIbIu+AUcUgh0JOsm9AoTXsoAFjWA7M1vz9B9TSIXpqvYmZHnosDUvgN2gMda/XT7
         RGXtP1pJqLlk+dV7rdtgts9TorcaW8PqPCWz72yOxHI7C3VMhCo6aByEH2GJV2hhF9JJ
         iTtamLsx2+FQ+UmokfWT3v4+pkGSOMQT5abxgCT1698SdM1QIyP1BtQX+gPE+DH9JRNl
         OUay97qFTp0VVyoeJlYyI4IY0mHjgisrlUESpvjo9XqEeiDgdVqq5GqgShjnxYnlXwz0
         NXfA4EtxlDmEYYowVe3VWWFYsXdlSjYRj81aYUJlAwMTgJeBkR+40p975Onzby5j/E/U
         yr0w==
X-Gm-Message-State: AOJu0YzF1q4aEwoKnXFwI0+ThpB1pW6KRzopa7Bqyj3Vwc4Ip7iEVtNe
	aT2nU371ZmdR0l6gFSRhRl66fCFut6W3QDoyScnJLPafZns5QD6uJ39Lx4BWR9WtMiAmydy6qYL
	1Vsj6GMdNqoA7jH/vHxrpnZz/caOCGxJeh7qIgqBecQBNLPzlALg1Pqv6Of0R6Dw7iUy5g7DdLH
	fMOurPBEwZZtxji7kxrVfcMG4nQvMUARzoeU9e332J8Ya5bctn90gZIOLdCUd/H9pj+15F3dbV2
	Wey3Df/RvOi0+bd7A==
X-Gm-Gg: ASbGncv1Um2XJjctM0zECJT2oRAvk1UCtmGdPRLA4XvXMX5ZhLjJrHr0fSZzJgdaV4W
	9VrG7zV7Ae5mihGzMeekk51XM0QPC0JYzhRRd/mgXkUd5gD/1TqwioGS80tJN6WDWop+i47e3wp
	xi4WrWWqvHWr5TLBeVo+vOPRLMa16uJT/i2MBgX+e1I1iEAR8MBOkEzYwsLCqKaiR6LKVky3L5v
	rw/rYbqXakC01o2vD8L8TjNnfnhZy1q8N52r8akX9SO3hLHWkof/+IB4POgiPCTJYLTnDpJKuws
	TIJP03MC7nT0AbMKtvHLvEU1JKUNXhprfBpPq4caqzL0l/HBg+52rwxSbpYzfRIFvGTsTY/nhEN
	/DR3hXRc9DL18wLRKSJNpKDghAlMq5krVjQRAVlllbEv2mNmGj0M2eIe4oPr6KFhG8oiTOToXKA
	==
X-Google-Smtp-Source: AGHT+IH+njiyhPgEnx17jIJlCe/0QmLM4l6lilp+QkEoAFP5du/JRB0Ek0K+TFQacd0kZBdWR0B6hXUfOTI4
X-Received: by 2002:a92:c26b:0:b0:3ec:175:a6f6 with SMTP id e9e14a558f8ab-3ef0894d163mr195771645ab.0.1756470710927;
        Fri, 29 Aug 2025 05:31:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id e9e14a558f8ab-3f29c2ee9c2sm1447885ab.0.2025.08.29.05.31.50
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Aug 2025 05:31:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-7f01c331c09so303896685a.1
        for <linux-rdma@vger.kernel.org>; Fri, 29 Aug 2025 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756470709; x=1757075509; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZAGq+6QY91x8bNrMnFL8ELYKX5LVTxyvgkeVDMauwvQ=;
        b=Gu9pJod0jl1FyxDbOAJ53eNltBVMlAD0q4WQ4ReAGGdOcOx3Mpbk7Fl80udS5NPwye
         AJ8/fO75VwWvstGgXYXL1GhDDlS3W3AUwQEgs03X8snPET/BTg/slVELcWPCN2aCsgQa
         Eyh/OSYpRIySqclIMKAV+DH5aWLlQaPnVsPCU=
X-Received: by 2002:a05:620a:4441:b0:7f4:4117:ad50 with SMTP id af79cd13be357-7f58d941d5fmr1258397585a.42.1756470709347;
        Fri, 29 Aug 2025 05:31:49 -0700 (PDT)
X-Received: by 2002:a05:620a:4441:b0:7f4:4117:ad50 with SMTP id af79cd13be357-7f58d941d5fmr1258393085a.42.1756470708764;
        Fri, 29 Aug 2025 05:31:48 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7fc16536012sm162384585a.66.2025.08.29.05.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 05:31:48 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>,
	Usman Ansari <usman.ansari@broadcom.com>
Subject: [PATCH 8/8] RDMA/bng_re: Initialize the Firmware and Hardware
Date: Fri, 29 Aug 2025 12:30:42 +0000
Message-Id: <20250829123042.44459-9-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829123042.44459-1-siva.kallam@broadcom.com>
References: <20250829123042.44459-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Initialize the firmware and hardware with HWRM command.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/bng_dev.c | 92 +++++++++++++++++++++++++-
 drivers/infiniband/hw/bng_re/bng_fw.c  | 65 ++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_fw.h  |  4 ++
 drivers/infiniband/hw/bng_re/bng_re.h  |  4 ++
 drivers/infiniband/hw/bng_re/bng_res.c | 27 ++++++++
 drivers/infiniband/hw/bng_re/bng_res.h | 14 ++++
 6 files changed, 203 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index 773121682bbe..348cf7c61595 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -182,6 +182,56 @@ static int bng_re_net_ring_alloc(struct bng_re_dev *rdev,
 	return rc;
 }
 
+static int bng_re_stats_ctx_free(struct bng_re_dev *rdev)
+{
+	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
+	struct hwrm_stat_ctx_free_input req = {};
+	struct hwrm_stat_ctx_free_output resp = {};
+	struct bnge_fw_msg fw_msg = {};
+	int rc = -EINVAL;
+
+	if (!aux_dev)
+		return rc;
+
+	bng_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_FREE);
+	req.stat_ctx_id = cpu_to_le32(rdev->stats_ctx.fw_id);
+	bng_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			   sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnge_send_msg(aux_dev, &fw_msg);
+	if (rc)
+		ibdev_err(&rdev->ibdev, "Failed to free HW stats context %#x",
+			  rc);
+
+	return rc;
+}
+
+static int bng_re_stats_ctx_alloc(struct bng_re_dev *rdev)
+{
+	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
+	struct bng_re_stats *stats = &rdev->stats_ctx;
+	struct hwrm_stat_ctx_alloc_output resp = {};
+	struct hwrm_stat_ctx_alloc_input req = {};
+	struct bnge_fw_msg fw_msg = {};
+	int rc = -EINVAL;
+
+	stats->fw_id = BNGE_INVALID_STATS_CTX_ID;
+
+	if (!aux_dev)
+		return rc;
+
+	bng_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_ALLOC);
+	req.update_period_ms = cpu_to_le32(1000);
+	req.stats_dma_addr = cpu_to_le64(stats->dma_map);
+	req.stats_dma_length = cpu_to_le16(rdev->chip_ctx->hw_stats_size);
+	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
+	bng_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
+			   sizeof(resp), BNGE_DFLT_HWRM_CMD_TIMEOUT);
+	rc = bnge_send_msg(aux_dev, &fw_msg);
+	if (!rc)
+		stats->fw_id = le32_to_cpu(resp.stat_ctx_id);
+	return rc;
+}
+
 static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 {
 	struct bnge_auxr_dev *aux_dev = rdev->aux_dev;
@@ -220,11 +270,21 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 
 static void bng_re_dev_uninit(struct bng_re_dev *rdev)
 {
+	int rc;
 	bng_re_debugfs_rem_pdev(rdev);
-	bng_re_disable_rcfw_channel(&rdev->rcfw);
-	bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id,
+
+	if (test_and_clear_bit(BNG_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags)) {
+		rc = bng_re_deinit_rcfw(&rdev->rcfw);
+		if (rc)
+			ibdev_warn(&rdev->ibdev,
+				   "Failed to deinitialize RCFW: %#x", rc);
+		bng_re_stats_ctx_free(rdev);
+		bng_re_free_stats_ctx_mem(rdev->bng_res.pdev, &rdev->stats_ctx);
+		bng_re_disable_rcfw_channel(&rdev->rcfw);
+		bng_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id,
 			     RING_ALLOC_REQ_RING_TYPE_NQ);
-	bng_re_free_rcfw_channel(&rdev->rcfw);
+		bng_re_free_rcfw_channel(&rdev->rcfw);
+	}
 
 	kfree(rdev->nqr);
 	rdev->nqr = NULL;
@@ -322,8 +382,34 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 		goto disable_rcfw;
 
 	bng_re_debugfs_add_pdev(rdev);
+	rc = bng_re_alloc_stats_ctx_mem(rdev->bng_res.pdev, rdev->chip_ctx,
+					&rdev->stats_ctx);
+	if (rc) {
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate stats context: %#x\n", rc);
+		goto disable_rcfw;
+	}
+
+	rc = bng_re_stats_ctx_alloc(rdev);
+	if (rc) {
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate QPLIB context: %#x\n", rc);
+		goto free_stats_ctx;
+	}
+
+	rc = bng_re_init_rcfw(&rdev->rcfw, &rdev->stats_ctx);
+	if (rc) {
+		ibdev_err(&rdev->ibdev,
+			  "Failed to initialize RCFW: %#x\n", rc);
+		goto free_sctx;
+	}
+	set_bit(BNG_RE_FLAG_RCFW_CHANNEL_EN, &rdev->flags);
 
 	return 0;
+free_sctx:
+	bng_re_stats_ctx_free(rdev);
+free_stats_ctx:
+	bng_re_free_stats_ctx_mem(rdev->bng_res.pdev, &rdev->stats_ctx);
 disable_rcfw:
 	bng_re_disable_rcfw_channel(&rdev->rcfw);
 free_ring:
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
index ec76e731b09b..1ffd87295b68 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.c
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -5,6 +5,7 @@
 #include "roce_hsi.h"
 #include "bng_res.h"
 #include "bng_fw.h"
+#include "bng_sp.h"
 
 /**
  * bng_re_map_rc  -  map return type based on opcode
@@ -719,3 +720,67 @@ int bng_re_enable_fw_channel(struct bng_re_rcfw *rcfw,
 	bng_re_start_rcfw(rcfw);
 	return 0;
 }
+
+int bng_re_deinit_rcfw(struct bng_re_rcfw *rcfw)
+{
+	struct creq_deinitialize_fw_resp resp = {};
+	struct cmdq_deinitialize_fw req = {};
+	struct bng_re_cmdqmsg msg = {};
+	int rc;
+
+	bng_re_rcfw_cmd_prep((struct cmdq_base *)&req,
+			     CMDQ_BASE_OPCODE_DEINITIALIZE_FW,
+			     sizeof(req));
+	bng_re_fill_cmdqmsg(&msg, &req, &resp, NULL,
+			    sizeof(req), sizeof(resp), 0);
+	rc = bng_re_rcfw_send_message(rcfw, &msg);
+	if (rc)
+		return rc;
+
+	clear_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->cmdq.flags);
+	return 0;
+}
+static inline bool _is_hw_retx_supported(u16 dev_cap_flags)
+{
+	return dev_cap_flags &
+		(CREQ_QUERY_FUNC_RESP_SB_HW_REQUESTER_RETX_ENABLED |
+		 CREQ_QUERY_FUNC_RESP_SB_HW_RESPONDER_RETX_ENABLED);
+}
+
+#define BNG_RE_HW_RETX(a) _is_hw_retx_supported((a))
+static inline bool _is_optimize_modify_qp_supported(u16 dev_cap_ext_flags2)
+{
+	return dev_cap_ext_flags2 &
+	       CREQ_QUERY_FUNC_RESP_SB_OPTIMIZE_MODIFY_QP_SUPPORTED;
+}
+
+int bng_re_init_rcfw(struct bng_re_rcfw *rcfw,
+		     struct bng_re_stats *stats_ctx)
+{
+	struct creq_initialize_fw_resp resp = {};
+	struct cmdq_initialize_fw req = {};
+	struct bng_re_cmdqmsg msg = {};
+	int rc;
+	u16 flags = 0;
+
+	bng_re_rcfw_cmd_prep((struct cmdq_base *)&req,
+			     CMDQ_BASE_OPCODE_INITIALIZE_FW,
+			     sizeof(req));
+	/* Supply (log-base-2-of-host-page-size - base-page-shift)
+	 * to bono to adjust the doorbell page sizes.
+	 */
+	req.log2_dbr_pg_size = cpu_to_le16(PAGE_SHIFT -
+					   BNG_FW_DBR_BASE_PAGE_SHIFT);
+	if (BNG_RE_HW_RETX(rcfw->res->dattr->dev_cap_flags))
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_HW_REQUESTER_RETX_SUPPORTED;
+	if (_is_optimize_modify_qp_supported(rcfw->res->dattr->dev_cap_flags2))
+		flags |= CMDQ_INITIALIZE_FW_FLAGS_OPTIMIZE_MODIFY_QP_SUPPORTED;
+	req.flags |= cpu_to_le16(flags);
+	req.stat_ctx_id = cpu_to_le32(stats_ctx->fw_id);
+	bng_re_fill_cmdqmsg(&msg, &req, &resp, NULL, sizeof(req), sizeof(resp), 0);
+	rc = bng_re_rcfw_send_message(rcfw, &msg);
+	if (rc)
+		return rc;
+	set_bit(FIRMWARE_INITIALIZED_FLAG, &rcfw->cmdq.flags);
+	return 0;
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.h b/drivers/infiniband/hw/bng_re/bng_fw.h
index 88476d6c1d07..c89c926ec2fc 100644
--- a/drivers/infiniband/hw/bng_re/bng_fw.h
+++ b/drivers/infiniband/hw/bng_re/bng_fw.h
@@ -10,6 +10,7 @@
 #define BNG_FW_CMDQ_TRIG_VAL		1
 #define BNG_FW_COMM_PCI_BAR_REGION	0
 #define BNG_FW_COMM_CONS_PCI_BAR_REGION	2
+#define BNG_FW_DBR_BASE_PAGE_SHIFT	12
 #define BNG_FW_COMM_SIZE		0x104
 #define BNG_FW_COMM_BASE_OFFSET		0x600
 #define BNG_FW_COMM_TRIG_OFFSET		0x100
@@ -204,4 +205,7 @@ int bng_re_rcfw_start_irq(struct bng_re_rcfw *rcfw, int msix_vector,
 void bng_re_rcfw_stop_irq(struct bng_re_rcfw *rcfw, bool kill);
 int bng_re_rcfw_send_message(struct bng_re_rcfw *rcfw,
 			     struct bng_re_cmdqmsg *msg);
+int bng_re_init_rcfw(struct bng_re_rcfw *rcfw,
+		     struct bng_re_stats *stats_ctx);
+int bng_re_deinit_rcfw(struct bng_re_rcfw *rcfw);
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index 76837f17f12d..f63791d716b7 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -17,6 +17,8 @@
 #define BNG_RE_MAX_MSIX		BNGE_MAX_ROCE_MSIX
 
 #define BNG_RE_CREQ_NQ_IDX	0
+
+#define BNGE_INVALID_STATS_CTX_ID	-1
 /* NQ specific structures  */
 struct bng_re_nq_db {
 	struct bng_re_reg_desc	reg;
@@ -66,6 +68,7 @@ struct bng_re_dev {
 	struct ib_device		ibdev;
 	unsigned long			flags;
 #define BNG_RE_FLAG_NETDEV_REGISTERED		0
+#define BNG_RE_FLAG_RCFW_CHANNEL_EN		1
 	struct net_device		*netdev;
 	struct auxiliary_device         *adev;
 	struct bnge_auxr_dev		*aux_dev;
@@ -77,6 +80,7 @@ struct bng_re_dev {
 	/* Device Resources */
 	struct bng_re_dev_attr		*dev_attr;
 	struct dentry			*dbg_root;
+	struct bng_re_stats		stats_ctx;
 };
 
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_res.c b/drivers/infiniband/hw/bng_re/bng_res.c
index cb42c0fd2cdf..c50823758b53 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.c
+++ b/drivers/infiniband/hw/bng_re/bng_res.c
@@ -9,6 +9,33 @@
 #include "bng_res.h"
 #include "roce_hsi.h"
 
+/* Stats */
+void bng_re_free_stats_ctx_mem(struct pci_dev *pdev,
+			       struct bng_re_stats *stats)
+{
+	if (stats->dma) {
+		dma_free_coherent(&pdev->dev, stats->size,
+				  stats->dma, stats->dma_map);
+	}
+	memset(stats, 0, sizeof(*stats));
+	stats->fw_id = -1;
+}
+
+int bng_re_alloc_stats_ctx_mem(struct pci_dev *pdev,
+			       struct bng_re_chip_ctx *cctx,
+			       struct bng_re_stats *stats)
+{
+	memset(stats, 0, sizeof(*stats));
+	stats->fw_id = -1;
+	stats->size = cctx->hw_stats_size;
+	stats->dma = dma_alloc_coherent(&pdev->dev, stats->size,
+					&stats->dma_map, GFP_KERNEL);
+	if (!stats->dma)
+		return -ENOMEM;
+
+	return 0;
+}
+
 static void bng_free_pbl(struct bng_re_res  *res, struct bng_re_pbl *pbl)
 {
 	struct pci_dev *pdev = res->pdev;
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
index 7315db347aa6..9997f86d6a0e 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.h
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -125,6 +125,13 @@ struct bng_re_hwq {
 	u16				qe_ppg;
 };
 
+struct bng_re_stats {
+	dma_addr_t			dma_map;
+	void				*dma;
+	u32				size;
+	u32				fw_id;
+};
+
 struct bng_re_res {
 	struct pci_dev			*pdev;
 	struct bng_re_chip_ctx		*cctx;
@@ -198,4 +205,11 @@ void bng_re_free_hwq(struct bng_re_res *res,
 
 int bng_re_alloc_init_hwq(struct bng_re_hwq *hwq,
 			  struct bng_re_hwq_attr *hwq_attr);
+
+void bng_re_free_stats_ctx_mem(struct pci_dev *pdev,
+			       struct bng_re_stats *stats);
+
+int bng_re_alloc_stats_ctx_mem(struct pci_dev *pdev,
+			       struct bng_re_chip_ctx *cctx,
+			       struct bng_re_stats *stats);
 #endif
-- 
2.34.1


