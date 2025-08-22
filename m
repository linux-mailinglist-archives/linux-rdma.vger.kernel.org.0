Return-Path: <linux-rdma+bounces-12873-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D28B30D26
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 06:03:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80D04B64005
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB19528C878;
	Fri, 22 Aug 2025 04:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GyigsuoA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yb1-f228.google.com (mail-yb1-f228.google.com [209.85.219.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7802F287276
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 04:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755835377; cv=none; b=TNuLfGqWslCNVlXrFYHCADeovswYigBUKeKXln72xMwbbma7HfXKLoFA43AyknUzv9YitfpxYCDez/TqXjT62VxRDYjgpaQGTs2MZQKmX+vI6ykde7dfDKSeWeJoIQFbClaqwxlEuLrEmiekBY6lLMRHTmGEyVWT5p7fEIw80B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755835377; c=relaxed/simple;
	bh=39+oe9SB85UaY1/dYjexAgsa7wUOhhfw9MgFsKM0+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oKBneXLLKinQctLDYw+ma9Est38e0ybPS1k2HJXcfzj4GQjw6PwawGdRV4M2q24NL3gCmoJiPLiYXdKw8rVknvYQuGAPB841xstR//SsQG5w3s/x54ASilH0w/wqPYi78xBbel6QYqv6OzY4dDYLL2DzPsRJdNdv1i/KyoQLvho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GyigsuoA; arc=none smtp.client-ip=209.85.219.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yb1-f228.google.com with SMTP id 3f1490d57ef6-e94eb6b811aso1467337276.2
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755835374; x=1756440174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttRgLIRqTP30+LhxgwiGR9e2bpOp/NOF9qofYEvXhuQ=;
        b=W1YK8FRXItf8pfhrnWoVdM3oO0yw3cVzcsR5q3I3/6RNx2ndhT5TCbRc996mQbSdgi
         2aBRz+U0FmqAHW22v6Xyz4N9WIZnuCHKWNvyWOQ9mbM9z6gZmalUkXWJNSFkc9Q85DhA
         vhtrQDIkM5f75FLabvk78g8BziAU1lTl+pOdeKHQhv2PTGytmCm1puAqbMZwrQEnJlDU
         3KstP1eFuPzzY7eb9y/1fYnxrZyVlNcmaBt9wbRbZkxCiFuDOImJHydenj7h3XTaLp80
         FaYpFi9CS40vUN6SbZyBDJI0x800LvjyVIhnqbDbT+vjqYkJjow+CxbNPf0kcC6ZLVUt
         8WOg==
X-Gm-Message-State: AOJu0Yythki+1yxsl72SGrpIt/PBQAOHeYxwppfRscGJV88Dudz2BNvG
	ykf5yz2ef3BvYQ3RHuLsQFn+vAfyYfk3BQnhCyLG2rN0Mdpq1xRye8LUmJkkmG5UMECMwciXZde
	xh/CA/FJD0u+h9jCdqYihViJUlDyShvajdilaXx227r9hhpPzHL+iL5nxP9oD6gUPzj2YDC5TlA
	SjA7/0zhwKw0v68vo1lIgfxlwJmGKTxxassVvlObRjW4vP/y1oC9EIwPdEt6O8SD5D/KDxC/u9o
	4nVu8jqQIonAVrAu3C+agaVnggLJA==
X-Gm-Gg: ASbGncvQPEvd2wWxpdZkA8wbdkB9bqkO5mvyUv6bKNaMcdD2r5HQUXgxdtGwLgeFOZs
	xUlt+v8uP3lkBMuvLJBr0DfK7RC/ZGey44PbcZOh+HvrKEeWinE9XK2jk0oqCcUpYuF9sGvxs0N
	kQ4om9YdnWTcHwj7tq/3MdY/liHFbKnGUU2V75TfKEySTBtrd4lzwe7fFLknIe5sEfM5DoA1qvT
	MSkl9/FEnXhyBxML5gsjICLWGvQpX0r/UaD+PaJR66f9+ND42fqMMjPjBYydX3jwQgGZ0/rPiiu
	qvGcGErOcuXcYtq8uflf5zvATSCTA3Ebg1doUPb6SAkQWv8PW6tSlznCbzLiS/va9cYPVxBUE6O
	aNYbxbsk3Fp7ueLnLMBHQx/bWJl9uP8zpo2sda8j80Roxdg49Y9e5MIC9FguA7UyGEOTN6avQSv
	WayxVy9gq2vk0P
X-Google-Smtp-Source: AGHT+IFSf/D+GeliP1E8Jr0hQUTU55zS8zqXGcg+g57wr8EDRbUSxaSCllU9rBYsbMsc0MhZm/dl3qr5VYAY
X-Received: by 2002:a05:6902:20c4:b0:e93:37c6:1b57 with SMTP id 3f1490d57ef6-e951c20aed5mr1592715276.9.1755835374237;
        Thu, 21 Aug 2025 21:02:54 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-72.dlp.protect.broadcom.com. [144.49.247.72])
        by smtp-relay.gmail.com with ESMTPS id 3f1490d57ef6-e951aea0fb6sm128721276.14.2025.08.21.21.02.53
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Aug 2025 21:02:54 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-76e2e8afd68so1608519b3a.1
        for <linux-rdma@vger.kernel.org>; Thu, 21 Aug 2025 21:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1755835372; x=1756440172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttRgLIRqTP30+LhxgwiGR9e2bpOp/NOF9qofYEvXhuQ=;
        b=GyigsuoAgQuLuTQ3c1tRlmlLy/wRgKoSsnBDlP3lMisrd3NKAAn87X18ygX5T9bVqJ
         UozXLxhqjQ/7/txQ9mRbF7XUFnkcWnPXxMOYlm47Cn/r5I/guzImpKu4WrKsiMeJEkiu
         C7H00i8XdwdpIsyKP6iYjjgcSZGKGPHknr2EE=
X-Received: by 2002:a05:6a00:9295:b0:76e:9f28:ad56 with SMTP id d2e1a72fcca58-7702fa664camr2400139b3a.14.1755835372185;
        Thu, 21 Aug 2025 21:02:52 -0700 (PDT)
X-Received: by 2002:a05:6a00:9295:b0:76e:9f28:ad56 with SMTP id d2e1a72fcca58-7702fa664camr2400106b3a.14.1755835371753;
        Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d0d3abdsm9659814b3a.11.2025.08.21.21.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 21:02:51 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH rdma-next 03/10] RDMA/bnxt_re: Refactor hw context memory allocation
Date: Fri, 22 Aug 2025 09:37:54 +0530
Message-ID: <20250822040801.776196-4-kalesh-anakkur.purayil@broadcom.com>
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

This patch is in preparation for other patches in this series.
There is no functional changes intended.

1. Rename bnxt_qplib_alloc_ctx() to bnxt_qplib_alloc_hwctx().
2. Rename bnxt_qplib_free_ctx() to bnxt_qplib_free_hwctx().
3. Reduce the number of arguments of bnxt_qplib_alloc_hwctx()
   by moving a check outside of it.

Signed-off-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/main.c      | 18 ++++++++++--------
 drivers/infiniband/hw/bnxt_re/qplib_res.c | 17 ++++++-----------
 drivers/infiniband/hw/bnxt_re/qplib_res.h |  9 ++++-----
 3 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index 3ae5f0d08f3a..9f752cb0c135 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2011,7 +2011,7 @@ static void bnxt_re_dev_uninit(struct bnxt_re_dev *rdev, u8 op_type)
 			ibdev_warn(&rdev->ibdev,
 				   "Failed to deinitialize RCFW: %#x", rc);
 		bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
-		bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
+		bnxt_qplib_free_hwctx(&rdev->qplib_res, &rdev->qplib_ctx);
 		bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 		type = bnxt_qplib_get_ring_type(rdev->chip_ctx);
 		bnxt_re_net_ring_free(rdev, rdev->rcfw.creq.ring_id, type);
@@ -2139,12 +2139,14 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	bnxt_qplib_query_version(&rdev->rcfw);
 	bnxt_re_set_resource_limits(rdev);
 
-	rc = bnxt_qplib_alloc_ctx(&rdev->qplib_res, &rdev->qplib_ctx, 0,
-				  bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx));
-	if (rc) {
-		ibdev_err(&rdev->ibdev,
-			  "Failed to allocate QPLIB context: %#x\n", rc);
-		goto disable_rcfw;
+	if (!rdev->is_virtfn &&
+	    !bnxt_qplib_is_chip_gen_p5_p7(rdev->chip_ctx)) {
+		rc = bnxt_qplib_alloc_hwctx(&rdev->qplib_res, &rdev->qplib_ctx);
+		if (rc) {
+			ibdev_err(&rdev->ibdev,
+				  "Failed to allocate hw context: %#x\n", rc);
+			goto disable_rcfw;
+		}
 	}
 	rc = bnxt_re_net_stats_ctx_alloc(rdev,
 					 rdev->qplib_ctx.stats.dma_map,
@@ -2206,7 +2208,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 free_sctx:
 	bnxt_re_net_stats_ctx_free(rdev, rdev->qplib_ctx.stats.fw_id);
 free_ctx:
-	bnxt_qplib_free_ctx(&rdev->qplib_res, &rdev->qplib_ctx);
+	bnxt_qplib_free_hwctx(&rdev->qplib_res, &rdev->qplib_ctx);
 disable_rcfw:
 	bnxt_qplib_disable_rcfw_channel(&rdev->rcfw);
 free_ring:
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 6cd05207ffed..db2ee7246861 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -350,8 +350,8 @@ int bnxt_qplib_alloc_init_hwq(struct bnxt_qplib_hwq *hwq,
 }
 
 /* Context Tables */
-void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx)
+void bnxt_qplib_free_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx)
 {
 	int i;
 
@@ -464,7 +464,7 @@ static int bnxt_qplib_setup_tqm_rings(struct bnxt_qplib_res *res,
 }
 
 /*
- * Routine: bnxt_qplib_alloc_ctx
+ * Routine: bnxt_qplib_alloc_hwctx
  * Description:
  *     Context tables are memories which are used by the chip fw.
  *     The 6 tables defined are:
@@ -484,17 +484,13 @@ static int bnxt_qplib_setup_tqm_rings(struct bnxt_qplib_res *res,
  * Returns:
  *     0 if success, else -ERRORS
  */
-int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx,
-			 bool virt_fn, bool is_p5)
+int bnxt_qplib_alloc_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx)
 {
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
 	int rc;
 
-	if (virt_fn || is_p5)
-		goto stats_alloc;
-
 	/* QPC Tables */
 	sginfo.pgsize = PAGE_SIZE;
 	sginfo.pgshft = PAGE_SHIFT;
@@ -540,7 +536,6 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 	rc = bnxt_qplib_alloc_init_hwq(&ctx->tim_tbl, &hwq_attr);
 	if (rc)
 		goto fail;
-stats_alloc:
 	/* Stats */
 	rc = bnxt_qplib_alloc_stats_ctx(res->pdev, res->cctx, &ctx->stats);
 	if (rc)
@@ -549,7 +544,7 @@ int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
 	return 0;
 
 fail:
-	bnxt_qplib_free_ctx(res, ctx);
+	bnxt_qplib_free_hwctx(res, ctx);
 	return rc;
 }
 
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 12e2fa23794a..9d866cfdebab 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -433,11 +433,10 @@ void bnxt_qplib_cleanup_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_init_res(struct bnxt_qplib_res *res);
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res);
 int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev);
-void bnxt_qplib_free_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx);
-int bnxt_qplib_alloc_ctx(struct bnxt_qplib_res *res,
-			 struct bnxt_qplib_ctx *ctx,
-			 bool virt_fn, bool is_p5);
+void bnxt_qplib_free_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx);
+int bnxt_qplib_alloc_hwctx(struct bnxt_qplib_res *res,
+			   struct bnxt_qplib_ctx *ctx);
 int bnxt_qplib_map_db_bar(struct bnxt_qplib_res *res);
 void bnxt_qplib_unmap_db_bar(struct bnxt_qplib_res *res);
 
-- 
2.43.5


