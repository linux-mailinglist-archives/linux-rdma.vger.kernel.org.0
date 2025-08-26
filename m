Return-Path: <linux-rdma+bounces-12923-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C411EB35461
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 999173B0586
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363602F746F;
	Tue, 26 Aug 2025 06:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TSoV0yRq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECFA2F6578
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189249; cv=none; b=aj4FfWdit8pmmSvmcbJNWaNPNbBhtCD1c3xgwreF29sN0qnDMCmqqJSRa8WzogD6DfxbIuXYTcJLF58ZBT/UM9FkIqmbFvpphUYi/suA2Led08z0PI0PjTSdq0YZSZxpwcv4jPkmE4j5DmcMyITnUUc9yDsTxN4Fs3UVQEjNTFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189249; c=relaxed/simple;
	bh=OIhVAik299++T2NwIVstX/xxBqyf6VqBS7soWCI/pLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MQpKdWjsL/wFrn4rBoklFhHXbYbUPqBol367qdramTm5cwyVM530GzWAyi5dw470A0qLKKd1TPjO6YYDK8QlEzqiFmcZlbId5KfsMrsISxgHyJjGCthNhcbaPt2m+MMF0RaXkj1CJGvWQgTKXGc89P9YHHbf3NegZY0XP0gnRwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TSoV0yRq; arc=none smtp.client-ip=209.85.217.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-523011c7489so384307137.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189247; x=1756794047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgehaGBydiTXhMzeHwQkiGCglFniU9L9yIWr2yVwOck=;
        b=BJOwnhWMDAjPn3JP6/yi8SyEJ6Z/v5aRao4ZYQRYWEPbGLy14VTWubr59GK/GfijaX
         g6cfkesuoKLtI/u/zRubhb82jC45b2nPqL+b8JnldgrVEIkMB4i4fFnt826N4U0A1TX/
         gHGW80B0n3H330Vp6USij01SpNBPcqYBeWsCslBga8vHndpB0V8vXeUaMQaCeCShY0GZ
         gcGYHpImdN7+IXgn7CKOE9/738hHtaQB/gI75SfBZlY97JL68vTRQ5F/pz1n6HEkiN/K
         dfpo62Dwr5tYkVJCnilwpBPBXgFvbFpgW/LaTjHC7lubGc3lWW004RXWmU0z81Rf7X33
         4QOg==
X-Gm-Message-State: AOJu0YwBmMdxTYjy/3LPkLRf0F45OiTAoCLByhKMkx+XwBzXZ7YEcQmE
	aGDrUqWCSp5jhHUmb0i8dHgeWYfDLIisre3BKYp+JYDpSmXiSlK1fawRoshTCget85Af04Vp5RG
	m8FMPxrBbTm1qI9AYl8p0LyVMs/3vGMG86zsUi4F6nUInYvgq0SZoJNdeGUK6DHCA2VtYjyliXj
	rUVLI2xjo7K9zs7mfwrdy24HnMp8VZSYd2R99Mln0JhWS3+iYqnjvt4C2SvXvAKOG9hY2EEhWS7
	V0QpN28ft0P3KlvLoJrN5xZG9Y8iQ==
X-Gm-Gg: ASbGnct7iaiyWfv1Hm+WWt4pWYYgoUkMu78YARqdak0WFHJF04g9ad51hd2t3yzA947
	s5rp8NcRVbK4K4ZTrouI875rCE+Zi6vxh7cu8QJaod+j1p02r3w18Digzr43acblF5fll329/Hg
	1wQwcG/mV9723UjbjhSVxQ89TUnWJAC2GYInlXHUSfE2nXSpLqvozljFnQlTKEnOFpN+e/UN9Ee
	BgakTq2sBE2Wxpy1wot48emoUwcNoRDnhSR18Tw4hvJ7RViV1SQ+PloKgihmbVXVo9KwJgnBxDc
	UFdsPcRsS8TORz4kRCM5DomWc6mrXhRuVhLRXTof1NuTyhC6U8EPGO/WLsc0DPI9hKULmEtYOJv
	6yaBvQgWSspocIfoJakJE/jbHBlRw15JB6fwKwCx7OCZn6OflYf7R0VFfqBbIFNyxblDVr1TNn3
	IcgD1LDswxUrPw
X-Google-Smtp-Source: AGHT+IEloWoS7PkWgWERyZLwiPyWEo0qW2ddwWh++qPnFtn1Ws78eJxAfZlfVwocWr8t4ZeqV6XVO7LwkEJJ
X-Received: by 2002:a05:6102:3a0b:b0:523:22e2:e894 with SMTP id ada2fe7eead31-52322e2ed9amr1692884137.28.1756189246638;
        Mon, 25 Aug 2025 23:20:46 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-892374a8ffesm284766241.8.2025.08.25.23.20.45
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:46 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-b4716f9dad2so8267711a12.0
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189245; x=1756794045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgehaGBydiTXhMzeHwQkiGCglFniU9L9yIWr2yVwOck=;
        b=TSoV0yRqr3M15qq/SEdEC8K8N6GiJw19zhvIKuWKbfPJu4J6x56mKZRrTPW9BrIivZ
         a0O77+Ol61pzBijxscm70V807DeIIgseyazwZWc42kol5E9fIuE3eBGOL0kWatwiVZ5K
         kAYeFVMxLdMl5Hiy5096QKusdQXDMxxOEhPl8=
X-Received: by 2002:a05:6a20:3c90:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-24340ca2dc8mr21261487637.20.1756189244647;
        Mon, 25 Aug 2025 23:20:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:3c90:b0:1f5:72eb:8b62 with SMTP id adf61e73a8af0-24340ca2dc8mr21261453637.20.1756189244195;
        Mon, 25 Aug 2025 23:20:44 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:43 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 04/10] RDMA/bnxt_re: Refactor stats context memory allocation
Date: Tue, 26 Aug 2025 11:55:16 +0530
Message-ID: <20250826062522.1036432-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250826062522.1036432-1-kalesh-anakkur.purayil@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Moved the stats context allocation logic to a new function.
The stats context memory allocation code has been moved from
bnxt_qplib_alloc_hwctx() to the newly added bnxt_re_get_stats_ctx()
function. Also, the code to send the firmware command has been moved.

This patch is in preparation for other patches in this series.
There is no functional changes intended.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c      | 46 ++++++++++++++++++-----
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 21 +++--------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  5 +++
 3 files changed, 47 insertions(+), 25 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 9f752cb0c135..c25eb2525a8f 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -935,8 +935,7 @@ static int bnxt_re_net_stats_ctx_free(struct bnxt_re_dev *rdev,
 }
 
 static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
-				       dma_addr_t dma_map,
-				       u32 *fw_stats_ctx_id)
+				       struct bnxt_qplib_stats *stats)
 {
 	struct bnxt_qplib_chip_ctx *chip_ctx = rdev->chip_ctx;
 	struct hwrm_stat_ctx_alloc_output resp = {};
@@ -945,21 +944,21 @@ static int bnxt_re_net_stats_ctx_alloc(struct bnxt_re_dev *rdev,
 	struct bnxt_fw_msg fw_msg = {};
 	int rc = -EINVAL;
 
-	*fw_stats_ctx_id = INVALID_STATS_CTX_ID;
+	stats->fw_id = INVALID_STATS_CTX_ID;
 
 	if (!en_dev)
 		return rc;
 
 	bnxt_re_init_hwrm_hdr((void *)&req, HWRM_STAT_CTX_ALLOC);
 	req.update_period_ms = cpu_to_le32(1000);
-	req.stats_dma_addr = cpu_to_le64(dma_map);
+	req.stats_dma_addr = cpu_to_le64(stats->dma_map);
 	req.stats_dma_length = cpu_to_le16(chip_ctx->hw_stats_size);
 	req.stat_ctx_flags = STAT_CTX_ALLOC_REQ_STAT_CTX_FLAGS_ROCE;
 	bnxt_re_fill_fw_msg(&fw_msg, (void *)&req, sizeof(req), (void *)&resp,
 			    sizeof(resp), DFLT_HWRM_CMD_TIMEOUT);
 	rc = bnxt_send_msg(en_dev, &fw_msg);
 	if (!rc)
-		*fw_stats_ctx_id = le32_to_cpu(resp.stat_ctx_id);
+		stats->fw_id = le32_to_cpu(resp.stat_ctx_id);
 
 	return rc;
 }
@@ -1986,6 +1985,36 @@ static void bnxt_re_free_nqr_mem(struct bnxt_re_dev *rdev)
 	rdev->nqr = NULL;
 }
 
+static int bnxt_re_get_stats_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+	int rc;
+
+	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &hctx->stats);
+	if (rc)
+		return rc;
+
+	rc = bnxt_re_net_stats_ctx_alloc(rdev, &hctx->stats);
+	if (rc)
+		goto free_stat_mem;
+
+	return 0;
+free_stat_mem:
+	bnxt_qplib_free_stats_ctx(res->pdev, &hctx->stats);
+
+	return rc;
+}
+
+static void bnxt_re_put_stats_ctx(struct bnxt_re_dev *rdev)
+{
+	struct bnxt_qplib_ctx *hctx = &rdev->qplib_ctx;
+	struct bnxt_qplib_res *res = &rdev->qplib_res;
+
+	bnxt_re_net_stats_ctx_free(rdev, hctx->stats.fw_id);
+	bnxt_qplib_free_stats_ctx(res->pdev, &hctx->stats);
+}
+
 static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 {
 	u8 type;
@@ -2010,7 +2039,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 		if (rc)
 			ibdev_warn(&rdev->ibdev,
 				   "Failed to deinitialize RCFW: %#x", rc);
-		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
+		bnxt_re_put_stats_ctx(rdev);
 		bnxt_qplib_free_hwctx(&rdev->qplib_res, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
@@ -2148,9 +2177,8 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 			goto disable_rcfw;
 		}
 	}
-	rc = bnxt_re_net_stats_ctx_alloc(rdev,
-					 rdev->qplib_ctx.stats.dma_map,
-					 &rdev->qplib_ctx.stats.fw_id);
+
+	rc = bnxt_re_get_stats_ctx(rdev);
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate stats context: %#x\n", rc);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index db2ee7246861..8d04f98b2606 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -53,12 +53,6 @@
 #include "qplib_sp.h"
 #include "qplib_rcfw.h"
 
-static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
-				      struct bnxt_qplib_stats *stats);
-static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
-				      struct bnxt_qplib_chip_ctx *cctx,
-				      struct bnxt_qplib_stats *stats);
-
 /* PBL */
 static void __free_pbl(struct bnxt_qplib_res *res, struct bnxt_qplib_pbl *pbl,
 		       bool is_umem)
@@ -365,7 +359,6 @@ void bnxt_qplib_free_hwctx(struct bnxt_qplib_res *res,
 	/* restore original pde level before destroy */
 	ctx->tqm_ctx.pde.level = ctx->tqm_ctx.pde_level;
 	bnxt_qplib_free_hwq(res, &ctx->tqm_ctx.pde);
-	bnxt_qplib_free_stats_ctx(res->pdev, &ctx->stats);
 }
 
 static int bnxt_qplib_alloc_tqm_rings(struct bnxt_qplib_res *res,
@@ -534,10 +527,6 @@ int bnxt_qplib_alloc_hwctx(struct bnxt_qplib_res *res,
 	hwq_attr.depth = ctx->qpc_count * 16;
 	hwq_attr.stride = 1;
 	rc = bnxt_qplib_alloc_init_hwq(&ctx->tim_tbl, &hwq_attr);
-	if (rc)
-		goto fail;
-	/* Stats */
-	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &ctx->stats);
 	if (rc)
 		goto fail;
 
@@ -825,8 +814,8 @@ static int bnxt_qplib_alloc_dpi_tbl(struct bnxt_qplib_res *res,
 }
 
 /* Stats */
-static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
-				      struct bnxt_qplib_stats *stats)
+void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
+			       struct bnxt_qplib_stats *stats)
 {
 	if (stats->dma) {
 		dma_free_coherent(&pdev->dev, stats->size,
@@ -836,9 +825,9 @@ static void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
 	stats->fw_id = -1;
 }
 
-static int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
-				      struct bnxt_qplib_chip_ctx *cctx,
-				      struct bnxt_qplib_stats *stats)
+int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
+			       struct bnxt_qplib_chip_ctx *cctx,
+			       struct bnxt_qplib_stats *stats)
 {
 	memset(stats, 0, sizeof(*stats));
 	stats->fw_id = -1;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 9d866cfdebab..ed1be06c2c60 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -441,6 +441,11 @@ int bnxt_qplib_map_db_bar(struct bnxt_qplib_res *res);
 void bnxt_qplib_unmap_db_bar(struct bnxt_qplib_res *res);
 
 int bnxt_qplib_determine_atomics(struct pci_dev *dev);
+int bnxt_qplib_alloc_stats_ctx(struct pci_dev *pdev,
+			       struct bnxt_qplib_chip_ctx *cctx,
+			       struct bnxt_qplib_stats *stats);
+void bnxt_qplib_free_stats_ctx(struct pci_dev *pdev,
+			       struct bnxt_qplib_stats *stats);
 
 static inline void bnxt_qplib_hwq_incr_prod(struct bnxt_qplib_db_info *dbinfo,
 					    struct bnxt_qplib_hwq *hwq, u32 cnt)
-- 
2.43.5


