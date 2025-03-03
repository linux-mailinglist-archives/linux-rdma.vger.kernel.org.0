Return-Path: <linux-rdma+bounces-8257-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7416A4C9A8
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 18:34:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC00C7A657F
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Mar 2025 17:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FFC2376FF;
	Mon,  3 Mar 2025 17:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="CMdi8ycS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2002A237185
	for <linux-rdma@vger.kernel.org>; Mon,  3 Mar 2025 17:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741022430; cv=none; b=SDreDBxT4FAiRu1qBhw/10BMV7XZewzzlYRMSHAesKED72IaQ9AKjwfGTBgWCM0odnVfBdMc2G8WpUX2kHp3gh3qfGMoKySD41+TYWhVe5WxpA7wYqWcCzYJ/7RFwXE7ESXUjJQJnQYTrykW9guJlp72UKvvfkfyXo5gp/tLE9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741022430; c=relaxed/simple;
	bh=SRMeekkHFINuKETaLwWPKzOXMvVxS5buF37I9gRkfoU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=rLjH8WNTtzm0BjDFfVVKmq4g81EAFEn/vg/UzOjuSu6YfZyGJ3EaPlupioTihxp5stiOVJn63k4Hxj7QryV13Ebml4m+zryYeTb0ZodwSqsMLLWIIJciwNlL9IHBXGa8FcyT33hotKgdT6r8RFgI3K7OPaVGVVp0QPNl7wGpkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=CMdi8ycS; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-219f8263ae0so87152135ad.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Mar 2025 09:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1741022428; x=1741627228; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q5r60x8U1KMD7QvNIJnmpfUQ3XnTP4HocbHUY+glfl0=;
        b=CMdi8ycSdwMXFDrYGuS/8CFzbGgszh0sfVRxcd1umTQC6B0Pmi9Tn+30in5gunk/sH
         UUdivQJk2h1GUI9VHs8xsKA/va2lFoCAXepOX/FYfzQx9IhacvIrUCqar42/MyRh+b+l
         QnJeRCpo9xecrDoJtr5IykO0vEkrWC1jIxvSU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741022428; x=1741627228;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q5r60x8U1KMD7QvNIJnmpfUQ3XnTP4HocbHUY+glfl0=;
        b=Mgb+LtAK9A20IspyNDQBG+Xxf9ZRIlDDzP6sM3JSX/i0I0i6PP8EkbzLuPOJDUAMwu
         4ULT2pKnLQd89C5Syt5kqqOxCP3c3hHPVEwlEwyCeOOR4kOhuHTd1I8fNgNuNZ9xm5Fa
         dv3L3zE7eXL/aHuE7ds1lS6FvXS36forxRL2+C9zCRm7oK2TFYLOvIjOdMwk0enkaFkD
         VEPaFy3g/J3yb5irNzO7zTrpEmCLEA/3X2jt/kivedwRshDRsonf3LR70kZzLt8y0tl9
         SXS5e3dKUDZl75CSGW7ZGbgIdYYtseYNVjG0olZNl+0E51HbKyJOkkzNS2mChqqIj+W0
         016w==
X-Gm-Message-State: AOJu0YyxacH2O789ax7/UJ4dGKU7L6g6xJokcBSohxIARSFvz88Wf+9U
	UFz940se5THGcyzu4yLT1Ms8gMvGBtH+2cpx6kRCmZ3loS/FADrtgVRxbC7+HA==
X-Gm-Gg: ASbGnctHHr3Bz5QAaDexNOC1zjtQR/IT80g75AlNfJhtCp/q4wao72yiZKKMCJIJ+pf
	5b2t6Z54byAKJKL8VKjX6Jzhz7H8WC3MM8uWjaYvwg+OOtQ/G613mbQL2cmUQo+BEUNHPJZoUOH
	V5CnQa9AeGp+h5Muuqu0DsC7zpritdyLViCozV4yxnTsv3Vi52Z5J9+9XuFQqSHP3Bi3GE7Hb7O
	Hq02A6U9yLOV+6Ms5EaBxKhs48nnQOAGNjbO812hSa3jqu2hhoV+RIetgcQFkdI1nOozSh/7cBc
	ZFJLGNMnfR6J88RbZX8FDrpw/g72o6vsuLZ/NM6kwpmkSe2bVw3JgwnR66b1OinzRtZRkRQh9Ww
	76E5ASmCVSTJV7su7IJb7yno8
X-Google-Smtp-Source: AGHT+IHTrMdOgg9FI3+16gXsuKXeROmEoz2qOq/swkCsenKerfi22G5hiKLCmVdyPS6FcRkV1+YCKg==
X-Received: by 2002:a05:6a00:2348:b0:736:35d4:f048 with SMTP id d2e1a72fcca58-73635d50046mr12344193b3a.9.1741022428236;
        Mon, 03 Mar 2025 09:20:28 -0800 (PST)
Received: from sxavier-dev.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7364ba1371asm3064917b3a.5.2025.03.03.09.20.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Mar 2025 09:20:27 -0800 (PST)
From: Selvin Xavier <selvin.xavier@broadcom.com>
To: leon@kernel.org,
	jgg@ziepe.ca
Cc: linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com,
	Kashyap Desai <kashyap.desai@broadcom.com>,
	Selvin Xavier <selvin.xavier@broadcom.com>
Subject: [PATCH rdma-rc 1/3] RDMA/bnxt_re: Fix allocation of QP table
Date: Mon,  3 Mar 2025 08:59:36 -0800
Message-Id: <1741021178-2569-2-git-send-email-selvin.xavier@broadcom.com>
X-Mailer: git-send-email 2.5.5
In-Reply-To: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
References: <1741021178-2569-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>

From: Kashyap Desai <kashyap.desai@broadcom.com>

Driver is creating QP table too early while probing before
querying firmware capabilities. Driver currently is using
a hard coded values of 64K as size while creating QP table.
This resulted in a crash when firmwre supported QP count is
more than 64K.

To fix the issue, move the QP tabel creation after the firmware
capabilities are queried. Use the firmware returned maximum value
of QPs while creating the QP table.

Fixes: b1b66ae094cd ("bnxt_en: Use FW defined resource limits for RoCE")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Kashyap Desai <kashyap.desai@broadcom.com>
Signed-off-by: Selvin Xavier <selvin.xavier@broadcom.com>
---
 drivers/infiniband/hw/bnxt_re/bnxt_re.h    |  6 ------
 drivers/infiniband/hw/bnxt_re/main.c       |  3 +--
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.c | 10 +---------
 drivers/infiniband/hw/bnxt_re/qplib_rcfw.h |  3 +--
 drivers/infiniband/hw/bnxt_re/qplib_res.c  |  9 +++++++++
 drivers/infiniband/hw/bnxt_re/qplib_res.h  |  7 +++++++
 6 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/bnxt_re.h b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
index 3721446..502a791 100644
--- a/drivers/infiniband/hw/bnxt_re/bnxt_re.h
+++ b/drivers/infiniband/hw/bnxt_re/bnxt_re.h
@@ -53,12 +53,6 @@
 #define BNXT_RE_MAX_MR_SIZE_HIGH	BIT_ULL(39)
 #define BNXT_RE_MAX_MR_SIZE		BNXT_RE_MAX_MR_SIZE_HIGH
 
-#define BNXT_RE_MAX_QPC_COUNT		(64 * 1024)
-#define BNXT_RE_MAX_MRW_COUNT		(64 * 1024)
-#define BNXT_RE_MAX_SRQC_COUNT		(64 * 1024)
-#define BNXT_RE_MAX_CQ_COUNT		(64 * 1024)
-#define BNXT_RE_MAX_MRW_COUNT_64K	(64 * 1024)
-#define BNXT_RE_MAX_MRW_COUNT_256K	(256 * 1024)
 
 /* Number of MRs to reserve for PF, leaving remainder for VFs */
 #define BNXT_RE_RESVD_MR_FOR_PF         (32 * 1024)
diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
index a94c8c5..4659a2f 100644
--- a/drivers/infiniband/hw/bnxt_re/main.c
+++ b/drivers/infiniband/hw/bnxt_re/main.c
@@ -2130,8 +2130,7 @@ static int bnxt_re_dev_init(struct bnxt_re_dev *rdev, u8 op_type)
 	 * memory for the function and all child VFs
 	 */
 	rc = bnxt_qplib_alloc_rcfw_channel(&rdev->qplib_res, &rdev->rcfw,
-					   &rdev->qplib_ctx,
-					   BNXT_RE_MAX_QPC_COUNT);
+					   &rdev->qplib_ctx);
 	if (rc) {
 		ibdev_err(&rdev->ibdev,
 			  "Failed to allocate RCFW Channel: %#x\n", rc);
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
index 17e62f2..d230743 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.c
@@ -915,7 +915,6 @@ int bnxt_qplib_init_rcfw(struct bnxt_qplib_rcfw *rcfw,
 
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 {
-	kfree(rcfw->qp_tbl);
 	kfree(rcfw->crsqe_tbl);
 	bnxt_qplib_free_hwq(rcfw->res, &rcfw->cmdq.hwq);
 	bnxt_qplib_free_hwq(rcfw->res, &rcfw->creq.hwq);
@@ -924,8 +923,7 @@ void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw)
 
 int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
-				  struct bnxt_qplib_ctx *ctx,
-				  int qp_tbl_sz)
+				  struct bnxt_qplib_ctx *ctx)
 {
 	struct bnxt_qplib_hwq_attr hwq_attr = {};
 	struct bnxt_qplib_sg_info sginfo = {};
@@ -969,12 +967,6 @@ int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 	if (!rcfw->crsqe_tbl)
 		goto fail;
 
-	/* Allocate one extra to hold the QP1 entries */
-	rcfw->qp_tbl_size = qp_tbl_sz + 1;
-	rcfw->qp_tbl = kcalloc(rcfw->qp_tbl_size, sizeof(struct bnxt_qplib_qp_node),
-			       GFP_KERNEL);
-	if (!rcfw->qp_tbl)
-		goto fail;
 	spin_lock_init(&rcfw->tbl_lock);
 
 	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
index 88814cb..30e5e18 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_rcfw.h
@@ -262,8 +262,7 @@ static inline void bnxt_qplib_fill_cmdqmsg(struct bnxt_qplib_cmdqmsg *msg,
 void bnxt_qplib_free_rcfw_channel(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_alloc_rcfw_channel(struct bnxt_qplib_res *res,
 				  struct bnxt_qplib_rcfw *rcfw,
-				  struct bnxt_qplib_ctx *ctx,
-				  int qp_tbl_sz);
+				  struct bnxt_qplib_ctx *ctx);
 void bnxt_qplib_rcfw_stop_irq(struct bnxt_qplib_rcfw *rcfw, bool kill);
 void bnxt_qplib_disable_rcfw_channel(struct bnxt_qplib_rcfw *rcfw);
 int bnxt_qplib_rcfw_start_irq(struct bnxt_qplib_rcfw *rcfw, int msix_vector,
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
index 02922a0..6cd0520 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
@@ -871,6 +871,7 @@ int bnxt_qplib_init_res(struct bnxt_qplib_res *res)
 
 void bnxt_qplib_free_res(struct bnxt_qplib_res *res)
 {
+	kfree(res->rcfw->qp_tbl);
 	bnxt_qplib_free_sgid_tbl(res, &res->sgid_tbl);
 	bnxt_qplib_free_pd_tbl(&res->pd_tbl);
 	bnxt_qplib_free_dpi_tbl(res, &res->dpi_tbl);
@@ -878,12 +879,20 @@ void bnxt_qplib_free_res(struct bnxt_qplib_res *res)
 
 int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct net_device *netdev)
 {
+	struct bnxt_qplib_rcfw *rcfw = res->rcfw;
 	struct bnxt_qplib_dev_attr *dev_attr;
 	int rc;
 
 	res->netdev = netdev;
 	dev_attr = res->dattr;
 
+	/* Allocate one extra to hold the QP1 entries */
+	rcfw->qp_tbl_size = max_t(u32, BNXT_RE_MAX_QPC_COUNT + 1, dev_attr->max_qp);
+	rcfw->qp_tbl = kcalloc(rcfw->qp_tbl_size, sizeof(struct bnxt_qplib_qp_node),
+			       GFP_KERNEL);
+	if (!rcfw->qp_tbl)
+		return -ENOMEM;
+
 	rc = bnxt_qplib_alloc_sgid_tbl(res, &res->sgid_tbl, dev_attr->max_sgid);
 	if (rc)
 		goto fail;
diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.h b/drivers/infiniband/hw/bnxt_re/qplib_res.h
index 7119902..2fb540f 100644
--- a/drivers/infiniband/hw/bnxt_re/qplib_res.h
+++ b/drivers/infiniband/hw/bnxt_re/qplib_res.h
@@ -49,6 +49,13 @@ extern const struct bnxt_qplib_gid bnxt_qplib_gid_zero;
 #define CHIP_NUM_58818          0xd818
 #define CHIP_NUM_57608          0x1760
 
+#define BNXT_RE_MAX_QPC_COUNT		(64 * 1024)
+#define BNXT_RE_MAX_MRW_COUNT		(64 * 1024)
+#define BNXT_RE_MAX_SRQC_COUNT		(64 * 1024)
+#define BNXT_RE_MAX_CQ_COUNT		(64 * 1024)
+#define BNXT_RE_MAX_MRW_COUNT_64K	(64 * 1024)
+#define BNXT_RE_MAX_MRW_COUNT_256K	(256 * 1024)
+
 #define BNXT_QPLIB_DBR_VALID		(0x1UL << 26)
 #define BNXT_QPLIB_DBR_EPOCH_SHIFT	24
 #define BNXT_QPLIB_DBR_TOGGLE_SHIFT	25
-- 
2.5.5


