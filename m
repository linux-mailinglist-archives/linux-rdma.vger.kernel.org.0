Return-Path: <linux-rdma+bounces-12874-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AE4B30D25
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3094C5E898B
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6BB828CF6A;
	Fri, 22 Aug 2025 04:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="BHLrTuCB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f226.google.com (mail-yw1-f226.google.com [209.85.128.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADB828CF4A
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835379; cv=none; b=by9cSNTH+BYjLUlS+En0ij9rQsnULIpW/6UT6pRnuygnMhgzbJfMILtqicRu21f1TRoV4bRTlnmTFDg9W2slNXl6beazhs+H/Oites3Aj1AayIhRjQ3T6F1crYAzq4FilwX7pfhc4CT8hFGZ7W8XzrNEQuHXleCzS7sCl+WvcMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835379; c=relaxed/simple;
	bh=OIhVAik299++T2NwIVstX/xxBqyf6VqBS7soWCI/pLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RTmW5kADVwrbB29j3FceEq6H4EgzBUTTCjnr8uCeuiT5npfcPOTDg6oeCQxfyIaq+I4rYOy4mSQinT35tbDxSzdU9q3kaSVd8XFFUyCvjSPM+wm72u79pZwbLrjCyqLOBJdqo5eCvU+rB8zCGvAokcmTKh3YaqMQvaoj2AwBzpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=BHLrTuCB; arc=none smtp.client-ip=209.85.128.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f226.google.com with SMTP id 00721157ae682-71d71bcab69so14308987b3.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835377; x=1756440177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgehaGBydiTXhMzeHwQkiGCglFniU9L9yIWr2yVwOck=;
        b=vt797uUKgdkyEvj3BQS4uybO95C1GrVtHnkWw4BUk9Ifuu/obR9iXeOay1TMULEFwN
         BkTEhKcnTBq65wWnaCoeueNWSZCPcjorFO3LF9ZPnEywaz9eGV5+0KCAkybURHCX/nqD
         2OuQ7MnDpLUb+a95dy29F5fqbiEc4Xc1ddTJvWfZ2/sNw+KlFdybWUzLFhJqsiNxtvlr
         a88QQAl7AIC/ilKk/wgV1aTprcB9FsWOwP0PKhTUqxyKEs2tekxmbIkG9QTIj2SKQSUy
         SU2zyAwPrNkZoHpWTuBKjMoKYVOMQCoDVf9W2pcNf+k8DTQFIR1n0ZndCBC/hVHIOYYx
         uqRg==
X-Gm-Message-State: AOJu0YyAt2ihV7OLYFw1ShmsA9/TfD5kMIqtz1r9ZSqHGgZR38aE3seJ
	0OPc1TkzHnYDB92uAFgLLBPQ/lvVzaRcg+atZtcsHkSjco5pCoxFxIdkVNcChi+w6I4z+nY1fJP
	X+/83uTQrG6lcqWNpITsFB55A8YMVROHyrJxI4ZDpojQdbJanEXYj2+Bwc1mkvr3m2G8/Pz9/YQ
	FxB84M7XIScdjVtwV6R8Tr0LJSzZ4vZwdjZsJMbZEorWcaKsFDqYdl2oDgRcySC9QwlAOx8fR8B
	9i6pHN1H3DV8S1o7DHk0abONdyMyQ==
X-Gm-Gg: ASbGnctbZE6veCUs15OO5b48+J4sC6Z636qwKrtcA+TrkH3Tw0ASIussCmVrDy7SAvQ
	jZ3c+glynhLEsY/OBe4eND8xnoJeJtTW/0ivvILppILjOj+23sUp/apuyh9mLU/y156m7XHoyo5
	zFPwf/m7gdYcf9MWa14Dc0dWQOHa0zI8TJed6sLNP2HVTdJQSihF692kAikfcRjQTrC4hXHqG4K
	o+ZfK8FID1swhIXBxxMsNH+fO0DinL1vBGcHBWRleLUnA2PPYSGTtZCFvvLOsWpynMs1uWC/mjc
	fDFXDJgndMFw/JrctC++cf9RVvgb78ftNKD2b8AAHxsh15+KDG+uSa57oxauKUcEgP8X3vLXaWY
	m2apBLKVIUkoG3AYDj4wWH+sKDFeZthAikgmu08tiZPBPy1eUw8G/IkQ88BYcrB6egraCZLTMhL
	m3IRQmJl1TWqNq
X-Google-Smtp-Source: AGHT+IEJO1J+bWgKd4Gk2KZKGOj65L4nK+T60X3cZlr5Q22DW+mX6Cr5rRPd31GqncTaBABhgukYnJkxf4I3
X-Received: by 2002:a05:690c:e1a:b0:71f:b944:1039 with SMTP id 00721157ae682-71fdc5388d5mr17021437b3.54.1755835376641;
        Thu, 21 Aug 2025 21:02:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-71e7a46aa6asm11451317b3.43.2025.08.21.21.02.56
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-76e2e614889so1691183b3a.0
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835375; x=1756440175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QgehaGBydiTXhMzeHwQkiGCglFniU9L9yIWr2yVwOck=;
        b=BHLrTuCBgL4Ool9W138IH3rh+TPd9XUoIMAge/N4+EkfYVyZvjnelPQkQlghdQH/Gx
         GE6WEgLgAH0H0izLFoLEhPYqfnm3XFpz1JcqPamXASzQor9cIjlrM7TdZN21TfpRN3WP
         74N5mzRlxM4eC9kbjYwrPrMh5Xc6L+vA7xtR8=
X-Received: by 2002:a05:6a00:4f91:b0:76b:dcc6:8138 with SMTP id d2e1a72fcca58-7702fc46479mr1807580b3a.22.1755835375259;
        Thu, 21 Aug 2025 21:02:55 -0700 (PDT)
X-Received: by 2002:a05:6a00:4f91:b0:76b:dcc6:8138 with SMTP id d2e1a72fcca58-7702fc46479mr1807540b3a.22.1755835374668;
        Thu, 21 Aug 2025 21:02:54 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:54 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 04/10] RDMA/bnxt_re: Refactor stats context memory allocation
Date: Fri, 22 Aug 2025 09:37:55 +0530
Message-ID: <20250822040801.776196-5-kalesh-anakkur.purayil@broadcom.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
References: <20250822040801.776196-1-kalesh-anakkur.purayil@broadcom.com>
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


