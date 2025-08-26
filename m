Return-Path: <linux-rdma+bounces-12922-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 537FEB3545D
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 08:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B459686994
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Aug 2025 06:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F952F6567;
	Tue, 26 Aug 2025 06:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GnyCUPNK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 078392F6191
	for <linux-rdma@vger.kernel.org>; Tue, 26 Aug 2025 06:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756189245; cv=none; b=HLvuhPLb8XbeBFXJtZiE0OWNA74aUsoo5WDWYpqFWMWoAy7FOCZDL0gTrRocbgK1qmh6QUh+wfAV/5/45zu/HEstTPTuyr29mQoXqS9oaLqp3rOwJ0fAKtH9QCOBXrbkz76tZWCAMYtoWcp4jmCH3soAh866DZqpTJ0sSp1W7UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756189245; c=relaxed/simple;
	bh=39+oe9SB85UaY1/dYjexAgsa7wUOhhfw9MgFsKM0+n8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YixkCnPp1tQgI01Ohktb26FUaD+IqwljWEmdS+K3mlxLNHOLjXSP+wFL5Xxw7vk1m87PtV6UmrziJlyHEDiX/xvCo6LVmKQhg6/rUC5YPUjo11aEz8i9hcMcCYPHVdOLMsHleF0SFRwQUiQkREa6eh7pwsY1MFQU/iEbPkqnPbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GnyCUPNK; arc=none smtp.client-ip=209.85.210.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-770530175b2so1743617b3a.3
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756189243; x=1756794043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ttRgLIRqTP30+LhxgwiGR9e2bpOp/NOF9qofYEvXhuQ=;
        b=JN3glmRANUuHmi898cMuS8vAPCRjYeVQ0fvvZ8H1w20w8wtaO36KKJ47RnSe6oyNhn
         +V8GLA+2qe3ztzEi2Lnw2/3ppZgq8n3uoVFOBuVElv57RS+MZ08l90c4KrCnAV6VYUeI
         WyYL3SeyAxqu2UxFTePtTrdHIItNTEz6hifSDuu3A/5Muzl1+QQ2bKl440qFaxiZS7WG
         ZhMm+YVIkkJiIMhPunnN5KiVAeGhPq5VFLYFs9s2Fmk5g7bc4eSJGkHokxibeF+VRV71
         d8SNp7NfuxWxc359VWssLZiI/LmzB8/9NXVAymlisrOPYsPOD3Y3cNmIxbra5B9mInMJ
         IfvQ==
X-Gm-Message-State: AOJu0YyOoBRQigSV28Xys/ZYfCfnsHhJRjYVte4NXK0q5Yr7Vx+y1Ak+
	JMjqZ76+SAj/gCV2eH12O1TELLkb9MU9EgzsQqpMfj1paLw9+c/UD37SruVb9kwvKK1peu7ov8/
	Knr7l5aUB0K3rs6hSuv2FAJda6+pRSd8SxQR6TPhS51BUMKWxNt0EX3ZkBfwLhywvh1sc3c4a7k
	LwYccnzD02XovJHPQqX5pQhRqPMgbVnZhAAsAC62HvJm3HsQ4T0JZRrK8P8yStTK4f4w6CX3/rv
	UYdorFICy9+X1gQ4OB7xfuYBOpfvg==
X-Gm-Gg: ASbGncv0RGnN82ywwe6pAUKb0XqgiHuiJcadUcumtVnLF6A15LxtBDpbBDAsslSp7iR
	aPOl8NTjiaNu/cWw1zs6ZClgUe+XBNKXJ+o2N8mlu6S2jVw+8ebIDKLSy6aJuDJum1j/fMjFT+L
	dEali1KJKy1+rZWl6xALW9uYYQGKi1p1KcSVw3hdmuGuYfvdU60ytOE5qlPcopW5n033Pb7viIt
	PBL5nnUiDPbliUlUjEkmkWBc8PxG7wWwEWloplQLhuw1Hdxj+nGxFk+kvzwEWO084ugloAltsfa
	/7Jsl1AdzJL6WNIJ2fjB91WEQBrTXjtRh2MojtxAIwfZaqIZH7dt1Zj/bo5JtR4kq/hmZkMjAkf
	qOO7HMCb99OeYcJzqzxJdkP2X7Sd3/u1tewZ7dlpnFNAMhwgzTyhNMRFX2SxdDPqQOST9Ig7clW
	e7X4elvXO7n1x1
X-Google-Smtp-Source: AGHT+IFNN/TH7fCevK4BxXihRa9kGbAEWtBkV6uVNr6EcD5zzMlky4wEtVs27wwYFusQ1QuSgJ3Hrs6b9gXj
X-Received: by 2002:a05:6a00:2196:b0:770:5996:3f71 with SMTP id d2e1a72fcca58-77059965743mr8561981b3a.3.1756189243227;
        Mon, 25 Aug 2025 23:20:43 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-11.dlp.protect.broadcom.com. [144.49.247.11])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-770401a84easm693950b3a.10.2025.08.25.23.20.42
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Aug 2025 23:20:43 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-76e8ae86ab3so5011980b3a.1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Aug 2025 23:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1756189241; x=1756794041; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttRgLIRqTP30+LhxgwiGR9e2bpOp/NOF9qofYEvXhuQ=;
        b=GnyCUPNKP4wKzRx0yyyrBfT0mNRyK5rEBzxE8MARshVgJAXJir5EV1ii8SB2EiX0zR
         utRt6h7TU6rP5pRGSMDiWapblOdxHEteQCLOsOHamKfHaSYGYHVuQyjkBsB5pQI1CTXM
         AnpzSmlemjkataw8jHXmDBGpKgFlUJyLCmDV0=
X-Received: by 2002:a05:6a20:6a28:b0:240:1c56:64a5 with SMTP id adf61e73a8af0-24340bfbefdmr20748770637.15.1756189241402;
        Mon, 25 Aug 2025 23:20:41 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a28:b0:240:1c56:64a5 with SMTP id adf61e73a8af0-24340bfbefdmr20748738637.15.1756189241011;
        Mon, 25 Aug 2025 23:20:41 -0700 (PDT)
Received: from dhcp-10-123-157-228.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4c04c7522fsm4392543a12.5.2025.08.25.23.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 23:20:40 -0700 (PDT)
From: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	selvin.xavier@broadcom.com,
	michael.chan@broadcom.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH V2 rdma-next 03/10] RDMA/bnxt_re: Refactor hw context memory allocation
Date: Tue, 26 Aug 2025 11:55:15 +0530
Message-ID: <20250826062522.1036432-4-kalesh-anakkur.purayil@broadcom.com>
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


