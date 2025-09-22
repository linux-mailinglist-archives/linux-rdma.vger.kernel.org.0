Return-Path: <linux-rdma+bounces-13572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C333AB92079
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 17:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C5213B4541
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 15:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A64D52EB5B7;
	Mon, 22 Sep 2025 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TEKX3vqg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674082EB5B3
	for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758555822; cv=none; b=f8xMKxei5ppBgLLgeH589SYWTWGhNrWFinjfMT6OByST4zvq76YRI3PTKKUUTrfcY6KYzikyt9hjtbo0j+P7xoPoepcUEy1c5y1xWLpjUafEceh/xggigyNJIG2Z+DuR7nmokQdnSx8rr5zwAWdpv03BCT9jFzfu9ARxPeHN370=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758555822; c=relaxed/simple;
	bh=Br9Bks/9nSFnyRluZAi40V3sh16fAmnmRYCaG/zY86A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=L4N5WXK8sFGUADLwZbyrr+umISL+27rjpEzjhu9DLhqUFJFTfmwKEvKQGXdcnGB9+HwAD6xMnRr6mJmLYtdXmIFyXt7CTu7oOURHI37h5jFPKfxjsoP3jwGvx9YAEWQ1lTinRVAD6k0tFGgp4D7TYl2a8nd4cHomytaxK25+V/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TEKX3vqg; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2445824dc27so48734405ad.3
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758555820; x=1759160620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w8ugwrW3JHxQdE71RS1L0SPO3O6DHbv2Tldl1Sm3ELQ=;
        b=DAaUUEPMENGlCfI4+oJr+6BDeyvq2yo7H+VZWYDlDXuWtxZ6wR2hUru/eBajflyRuy
         brN4hInopaL9h+/kwz/kQIA1Hls58uYGLIqOnOgPebcMhOUs8Cg/g5G0q6HaueONLbMe
         hNnlw4PAReyZaxuHgQZuGjzVJ0jQzFhOrlQ91KSqgiXAqGRG1fNu0X6Zf/ZbgPBHd23p
         37vaIRsbC4HvHzYE+xEI1xMlWmmpg19KY3mSow88vBmdI62k3G14LXtt6D9SAwRom/7q
         HGdRhFVqF1dAxFC0W7ysEMLpunmjJhVyR9I82TdxUFO4mnX+p91zIzo3JAp8B9/PtMlZ
         BLlQ==
X-Gm-Message-State: AOJu0Yw5yBeWHTnrk/9uKvoO9JreDaza7AhJ+tVRiyYPZtomHlbmCwZk
	/rqdx5iLyioa+wsrCc48VFSrp3uWE7X5IQsslhXu/Y1JfT7+3qCzmvLwt7iVyneUlSGwDLXmDIa
	WEWat+RJLORZNXFkshfPZXgV9uWYoVfGKxF7SgyMsA6gDq9H9k4TxI8JSD7c0Wx+GMg0hzE4+N/
	opUm9gg++oKyCuzdbv37wGkH+e5KlCzBxfvs+hhhHN7S1nhhO49iegLW/LBWGGXXn1nKhF6x6de
	HdKq8Dqk/c96dqq2w==
X-Gm-Gg: ASbGncvFJpolThXsY/sKy3elYkiQyLoniAvn0MvF9wKl5Xs4kXAr23MBifd0Yhkw0ia
	rNr4p3wSsfk9XWPKnFNSDR8SZe7QIlobhFZlA/7B+f+uvHJGbqFLLEUsC/BfbuE57Y5qqxdRdjZ
	9Bu0aUhKu96pwl2zXirCwKXoY18U0DkfR/zKnPJC5uCuxeA/ZEz5a+egX7q8Cyx0v4OlpDFzZ74
	isLx7vtLDqkxGEREtGk9rP1+DHGymZ7MaU6CYpZ2QOO0jBolUOraqDnXqnHDVffxkL0OWpf9++d
	HoEfvJFC+mKsqcZgyXaAnEADuiJ3ZU3f7vpMAIFVR0kmF2SHsXLy0t3NHrqg7eEIsYM3Qx9l3HQ
	S10IyiSJax0ThbWBiydVUWiOukcdY7oa60Yb+FZv38ZPSiCBZLxwh3eG56D8wYSXymQ9QElT0Ng
	==
X-Google-Smtp-Source: AGHT+IEJ8m82YOkGuef/1W4MPldiQc7tDE96ndvTk6BNnKAjVeRVWJCFbmmPoqBmIvtELhQC8QdUaK5UBZmk
X-Received: by 2002:a17:902:8490:b0:269:8072:5be7 with SMTP id d9443c01a7336-269ba566c82mr119907655ad.56.1758555819565;
        Mon, 22 Sep 2025 08:43:39 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-269802bae5fsm8353065ad.63.2025.09.22.08.43.39
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Sep 2025 08:43:39 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-4b4980c96c3so161379241cf.1
        for <linux-rdma@vger.kernel.org>; Mon, 22 Sep 2025 08:43:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1758555818; x=1759160618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w8ugwrW3JHxQdE71RS1L0SPO3O6DHbv2Tldl1Sm3ELQ=;
        b=TEKX3vqgAqQtvwxeEUkx+aYJZY7z6E2gWSWhFRL3TeuHxmr7Km1t0nuHLzccmIv1Ar
         6nfrFDQ5Te+WtVOuy3SeWtPZfvVLI53fbV+shkbNHs7+M5H/9FBdux6fn7D5DUVBqvR5
         fJ7vAYj/rLg5DkQAx/FbKAEOrQIcNCmyJ7SMU=
X-Received: by 2002:a05:620a:318a:b0:84c:1d25:890d with SMTP id af79cd13be357-84c1d258b69mr256316085a.57.1758555818185;
        Mon, 22 Sep 2025 08:43:38 -0700 (PDT)
X-Received: by 2002:a05:620a:318a:b0:84c:1d25:890d with SMTP id af79cd13be357-84c1d258b69mr256313185a.57.1758555817663;
        Mon, 22 Sep 2025 08:43:37 -0700 (PDT)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-84ada77bb17sm179496785a.30.2025.09.22.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Sep 2025 08:43:37 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com
Cc: linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	vikas.gupta@broadcom.com,
	selvin.xavier@broadcom.com,
	anand.subramanian@broadcom.com,
	usman.ansari@broadcom.com,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH v2 4/8] RDMA/bng_re: Allocate required memory resources for Firmware channel
Date: Mon, 22 Sep 2025 15:42:59 +0000
Message-Id: <20250922154303.246809-5-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250922154303.246809-1-siva.kallam@broadcom.com>
References: <20250922154303.246809-1-siva.kallam@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Allocate required memory resources for Firmware channel.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Reviewed-by: Usman Ansari <usman.ansari@broadcom.com>
---
 drivers/infiniband/hw/bng_re/Makefile  |   6 +-
 drivers/infiniband/hw/bng_re/bng_dev.c |  32 +++-
 drivers/infiniband/hw/bng_re/bng_fw.c  |  70 +++++++
 drivers/infiniband/hw/bng_re/bng_fw.h  |  69 +++++++
 drivers/infiniband/hw/bng_re/bng_re.h  |   2 +
 drivers/infiniband/hw/bng_re/bng_res.c | 250 +++++++++++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_res.h |  76 ++++++++
 7 files changed, 495 insertions(+), 10 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fw.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_res.c

diff --git a/drivers/infiniband/hw/bng_re/Makefile b/drivers/infiniband/hw/bng_re/Makefile
index f854dae25b1c..1b957defbabc 100644
--- a/drivers/infiniband/hw/bng_re/Makefile
+++ b/drivers/infiniband/hw/bng_re/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
-
-ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge
+ccflags-y := -I $(srctree)/drivers/net/ethernet/broadcom/bnge -I $(srctree)/drivers/infiniband/hw/bnxt_re
 
 obj-$(CONFIG_INFINIBAND_BNG_RE) += bng_re.o
 
-bng_re-y := bng_dev.o
+bng_re-y := bng_dev.o bng_fw.o \
+	    bng_res.o
diff --git a/drivers/infiniband/hw/bng_re/bng_dev.c b/drivers/infiniband/hw/bng_re/bng_dev.c
index cad065df2032..1506f32fb550 100644
--- a/drivers/infiniband/hw/bng_re/bng_dev.c
+++ b/drivers/infiniband/hw/bng_re/bng_dev.c
@@ -8,6 +8,7 @@
 #include <rdma/ib_verbs.h>
 
 #include "bng_res.h"
+#include "bng_fw.h"
 #include "bng_re.h"
 #include "bnge.h"
 #include "bnge_hwrm.h"
@@ -60,6 +61,9 @@ static void bng_re_destroy_chip_ctx(struct bng_re_dev *rdev)
 
 	chip_ctx = rdev->chip_ctx;
 	rdev->chip_ctx = NULL;
+	rdev->rcfw.res = NULL;
+	rdev->bng_res.cctx = NULL;
+	rdev->bng_res.pdev = NULL;
 	kfree(chip_ctx);
 }
 
@@ -69,7 +73,8 @@ static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
 	struct bnge_auxr_dev *aux_dev;
 
 	aux_dev = rdev->aux_dev;
-
+	rdev->bng_res.pdev = aux_dev->pdev;
+	rdev->rcfw.res = &rdev->bng_res;
 	chip_ctx = kzalloc(sizeof(*chip_ctx), GFP_KERNEL);
 	if (!chip_ctx)
 		return -ENOMEM;
@@ -77,6 +82,7 @@ static int bng_re_setup_chip_ctx(struct bng_re_dev *rdev)
 	chip_ctx->hw_stats_size = aux_dev->hw_ring_stats_size;
 
 	rdev->chip_ctx = chip_ctx;
+	rdev->bng_res.cctx = rdev->chip_ctx;
 
 	return 0;
 }
@@ -135,6 +141,14 @@ static void bng_re_query_hwrm_version(struct bng_re_dev *rdev)
 		cctx->hwrm_cmd_max_timeout = BNG_ROCE_FW_MAX_TIMEOUT;
 }
 
+static void bng_re_dev_uninit(struct bng_re_dev *rdev)
+{
+	bng_re_free_rcfw_channel(&rdev->rcfw);
+	bng_re_destroy_chip_ctx(rdev);
+	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
+		bnge_unregister_dev(rdev->aux_dev);
+}
+
 static int bng_re_dev_init(struct bng_re_dev *rdev)
 {
 	int rc;
@@ -170,14 +184,18 @@ static int bng_re_dev_init(struct bng_re_dev *rdev)
 
 	bng_re_query_hwrm_version(rdev);
 
+	rc = bng_re_alloc_fw_channel(&rdev->bng_res, &rdev->rcfw);
+	if (rc) {
+		ibdev_err(&rdev->ibdev,
+			  "Failed to allocate RCFW Channel: %#x\n", rc);
+		goto fail;
+	}
+
 	return 0;
-}
 
-static void bng_re_dev_uninit(struct bng_re_dev *rdev)
-{
-	bng_re_destroy_chip_ctx(rdev);
-	if (test_and_clear_bit(BNG_RE_FLAG_NETDEV_REGISTERED, &rdev->flags))
-		bnge_unregister_dev(rdev->aux_dev);
+fail:
+	bng_re_dev_uninit(rdev);
+	return rc;
 }
 
 static int bng_re_add_device(struct auxiliary_device *adev)
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.c b/drivers/infiniband/hw/bng_re/bng_fw.c
new file mode 100644
index 000000000000..bf7bbcf9b56e
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_fw.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+#include <linux/pci.h>
+
+#include "bng_res.h"
+#include "bng_fw.h"
+
+void bng_re_free_rcfw_channel(struct bng_re_rcfw *rcfw)
+{
+	kfree(rcfw->crsqe_tbl);
+	bng_re_free_hwq(rcfw->res, &rcfw->cmdq.hwq);
+	bng_re_free_hwq(rcfw->res, &rcfw->creq.hwq);
+	rcfw->pdev = NULL;
+}
+
+int bng_re_alloc_fw_channel(struct bng_re_res *res,
+			    struct bng_re_rcfw *rcfw)
+{
+	struct bng_re_hwq_attr hwq_attr = {};
+	struct bng_re_sg_info sginfo = {};
+	struct bng_re_cmdq_ctx *cmdq;
+	struct bng_re_creq_ctx *creq;
+
+	rcfw->pdev = res->pdev;
+	cmdq = &rcfw->cmdq;
+	creq = &rcfw->creq;
+	rcfw->res = res;
+
+	sginfo.pgsize = PAGE_SIZE;
+	sginfo.pgshft = PAGE_SHIFT;
+
+	hwq_attr.sginfo = &sginfo;
+	hwq_attr.res = rcfw->res;
+	hwq_attr.depth = BNG_FW_CREQE_MAX_CNT;
+	hwq_attr.stride = BNG_FW_CREQE_UNITS;
+	hwq_attr.type = BNG_HWQ_TYPE_QUEUE;
+
+	if (bng_re_alloc_init_hwq(&creq->hwq, &hwq_attr)) {
+		dev_err(&rcfw->pdev->dev,
+			"HW channel CREQ allocation failed\n");
+		goto fail;
+	}
+
+	rcfw->cmdq_depth = BNG_FW_CMDQE_MAX_CNT;
+
+	sginfo.pgsize = bng_fw_cmdqe_page_size(rcfw->cmdq_depth);
+	hwq_attr.depth = rcfw->cmdq_depth & 0x7FFFFFFF;
+	hwq_attr.stride = BNG_FW_CMDQE_UNITS;
+	hwq_attr.type = BNG_HWQ_TYPE_CTX;
+	if (bng_re_alloc_init_hwq(&cmdq->hwq, &hwq_attr)) {
+		dev_err(&rcfw->pdev->dev,
+			"HW channel CMDQ allocation failed\n");
+		goto fail;
+	}
+
+	rcfw->crsqe_tbl = kcalloc(cmdq->hwq.max_elements,
+				  sizeof(*rcfw->crsqe_tbl), GFP_KERNEL);
+	if (!rcfw->crsqe_tbl)
+		goto fail;
+
+	spin_lock_init(&rcfw->tbl_lock);
+
+	rcfw->max_timeout = res->cctx->hwrm_cmd_max_timeout;
+
+	return 0;
+
+fail:
+	bng_re_free_rcfw_channel(rcfw);
+	return -ENOMEM;
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_fw.h b/drivers/infiniband/hw/bng_re/bng_fw.h
new file mode 100644
index 000000000000..351f73baa9df
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_fw.h
@@ -0,0 +1,69 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+// Copyright (c) 2025 Broadcom.
+
+#ifndef __BNG_FW_H__
+#define __BNG_FW_H__
+
+/* CREQ */
+#define BNG_FW_CREQE_MAX_CNT	(64 * 1024)
+#define BNG_FW_CREQE_UNITS	16
+
+/* CMDQ */
+struct bng_fw_cmdqe {
+	u8	data[16];
+};
+
+#define BNG_FW_CMDQE_MAX_CNT		8192
+#define BNG_FW_CMDQE_UNITS		sizeof(struct bng_fw_cmdqe)
+#define BNG_FW_CMDQE_BYTES(depth)	((depth) * BNG_FW_CMDQE_UNITS)
+
+static inline u32 bng_fw_cmdqe_npages(u32 depth)
+{
+	u32 npages;
+
+	npages = BNG_FW_CMDQE_BYTES(depth) / PAGE_SIZE;
+	if (BNG_FW_CMDQE_BYTES(depth) % PAGE_SIZE)
+		npages++;
+	return npages;
+}
+
+static inline u32 bng_fw_cmdqe_page_size(u32 depth)
+{
+	return (bng_fw_cmdqe_npages(depth) * PAGE_SIZE);
+}
+
+/* HWQ */
+struct bng_re_cmdq_ctx {
+	struct bng_re_hwq		hwq;
+};
+
+struct bng_re_creq_ctx {
+	struct bng_re_hwq		hwq;
+};
+
+struct bng_re_crsqe {
+	struct creq_qp_event	*resp;
+	u32			req_size;
+	/* Free slots at the time of submission */
+	u32			free_slots;
+	u8			opcode;
+};
+
+/* RoCE FW Communication Channels */
+struct bng_re_rcfw {
+	struct pci_dev		*pdev;
+	struct bng_re_res	*res;
+	struct bng_re_cmdq_ctx	cmdq;
+	struct bng_re_creq_ctx	creq;
+	struct bng_re_crsqe	*crsqe_tbl;
+	/* To synchronize the qp-handle hash table */
+	spinlock_t		tbl_lock;
+	u32			cmdq_depth;
+	/* cached from chip cctx for quick reference in slow path */
+	u16			max_timeout;
+};
+
+void bng_re_free_rcfw_channel(struct bng_re_rcfw *rcfw);
+int bng_re_alloc_fw_channel(struct bng_re_res *res,
+			    struct bng_re_rcfw *rcfw);
+#endif
diff --git a/drivers/infiniband/hw/bng_re/bng_re.h b/drivers/infiniband/hw/bng_re/bng_re.h
index db692ad8db0e..18f80e2a1a46 100644
--- a/drivers/infiniband/hw/bng_re/bng_re.h
+++ b/drivers/infiniband/hw/bng_re/bng_re.h
@@ -27,6 +27,8 @@ struct bng_re_dev {
 	struct bnge_auxr_dev		*aux_dev;
 	struct bng_re_chip_ctx		*chip_ctx;
 	int				fn_id;
+	struct bng_re_res		bng_res;
+	struct bng_re_rcfw		rcfw;
 };
 
 #endif
diff --git a/drivers/infiniband/hw/bng_re/bng_res.c b/drivers/infiniband/hw/bng_re/bng_res.c
new file mode 100644
index 000000000000..2119d1f39b65
--- /dev/null
+++ b/drivers/infiniband/hw/bng_re/bng_res.c
@@ -0,0 +1,250 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2025 Broadcom.
+
+#include <linux/pci.h>
+#include <linux/vmalloc.h>
+#include <rdma/ib_umem.h>
+
+#include "bng_res.h"
+#include "roce_hsi.h"
+
+static void bng_free_pbl(struct bng_re_res  *res, struct bng_re_pbl *pbl)
+{
+	struct pci_dev *pdev = res->pdev;
+	int i;
+
+	for (i = 0; i < pbl->pg_count; i++) {
+		if (pbl->pg_arr[i])
+			dma_free_coherent(&pdev->dev, pbl->pg_size,
+					  (void *)((unsigned long)
+					     pbl->pg_arr[i] &
+						PAGE_MASK),
+					  pbl->pg_map_arr[i]);
+		else
+			dev_warn(&pdev->dev,
+					"PBL free pg_arr[%d] empty?!\n", i);
+		pbl->pg_arr[i] = NULL;
+	}
+
+	vfree(pbl->pg_arr);
+	pbl->pg_arr = NULL;
+	vfree(pbl->pg_map_arr);
+	pbl->pg_map_arr = NULL;
+	pbl->pg_count = 0;
+	pbl->pg_size = 0;
+}
+
+static int bng_alloc_pbl(struct bng_re_res  *res,
+			 struct bng_re_pbl *pbl,
+			 struct bng_re_sg_info *sginfo)
+{
+	struct pci_dev *pdev = res->pdev;
+	u32 pages;
+	int i;
+
+	if (sginfo->nopte)
+		return 0;
+	pages = sginfo->npages;
+
+	/* page ptr arrays */
+	pbl->pg_arr = vmalloc_array(pages, sizeof(void *));
+	if (!pbl->pg_arr)
+		return -ENOMEM;
+
+	pbl->pg_map_arr = vmalloc_array(pages, sizeof(dma_addr_t));
+	if (!pbl->pg_map_arr) {
+		vfree(pbl->pg_arr);
+		pbl->pg_arr = NULL;
+		return -ENOMEM;
+	}
+	pbl->pg_count = 0;
+	pbl->pg_size = sginfo->pgsize;
+
+	for (i = 0; i < pages; i++) {
+		pbl->pg_arr[i] = dma_alloc_coherent(&pdev->dev,
+				pbl->pg_size,
+				&pbl->pg_map_arr[i],
+				GFP_KERNEL);
+		if (!pbl->pg_arr[i])
+			goto fail;
+		pbl->pg_count++;
+	}
+
+	return 0;
+fail:
+	bng_free_pbl(res, pbl);
+	return -ENOMEM;
+}
+
+void bng_re_free_hwq(struct bng_re_res *res,
+		     struct bng_re_hwq *hwq)
+{
+	int i;
+
+	if (!hwq->max_elements)
+		return;
+	if (hwq->level >= BNG_PBL_LVL_MAX)
+		return;
+
+	for (i = 0; i < hwq->level + 1; i++)
+		bng_free_pbl(res, &hwq->pbl[i]);
+
+	hwq->level = BNG_PBL_LVL_MAX;
+	hwq->max_elements = 0;
+	hwq->element_size = 0;
+	hwq->prod = 0;
+	hwq->cons = 0;
+}
+
+/* All HWQs are power of 2 in size */
+int bng_re_alloc_init_hwq(struct bng_re_hwq *hwq,
+			  struct bng_re_hwq_attr *hwq_attr)
+{
+	u32 npages, pg_size;
+	struct bng_re_sg_info sginfo = {};
+	u32 depth, stride, npbl, npde;
+	dma_addr_t *src_phys_ptr, **dst_virt_ptr;
+	struct bng_re_res *res;
+	struct pci_dev *pdev;
+	int i, rc, lvl;
+
+	res = hwq_attr->res;
+	pdev = res->pdev;
+	pg_size = hwq_attr->sginfo->pgsize;
+	hwq->level = BNG_PBL_LVL_MAX;
+
+	depth = roundup_pow_of_two(hwq_attr->depth);
+	stride = roundup_pow_of_two(hwq_attr->stride);
+
+	npages = (depth * stride) / pg_size;
+	if ((depth * stride) % pg_size)
+		npages++;
+	if (!npages)
+		return -EINVAL;
+	hwq_attr->sginfo->npages = npages;
+
+	if (npages == MAX_PBL_LVL_0_PGS && !hwq_attr->sginfo->nopte) {
+		/* This request is Level 0, map PTE */
+		rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_0], hwq_attr->sginfo);
+		if (rc)
+			goto fail;
+		hwq->level = BNG_PBL_LVL_0;
+		goto done;
+	}
+
+	if (npages >= MAX_PBL_LVL_0_PGS) {
+		if (npages > MAX_PBL_LVL_1_PGS) {
+			u32 flag = PTU_PTE_VALID;
+			/* 2 levels of indirection */
+			npbl = npages >> MAX_PBL_LVL_1_PGS_SHIFT;
+			if (npages % BIT(MAX_PBL_LVL_1_PGS_SHIFT))
+				npbl++;
+			npde = npbl >> MAX_PDL_LVL_SHIFT;
+			if (npbl % BIT(MAX_PDL_LVL_SHIFT))
+				npde++;
+			/* Alloc PDE pages */
+			sginfo.pgsize = npde * pg_size;
+			sginfo.npages = 1;
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
+
+			/* Alloc PBL pages */
+			sginfo.npages = npbl;
+			sginfo.pgsize = PAGE_SIZE;
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_1], &sginfo);
+			if (rc)
+				goto fail;
+			/* Fill PDL with PBL page pointers */
+			dst_virt_ptr =
+				(dma_addr_t **)hwq->pbl[BNG_PBL_LVL_0].pg_arr;
+			src_phys_ptr = hwq->pbl[BNG_PBL_LVL_1].pg_map_arr;
+			for (i = 0; i < hwq->pbl[BNG_PBL_LVL_1].pg_count; i++)
+				dst_virt_ptr[0][i] = src_phys_ptr[i] | flag;
+
+			/* Alloc or init PTEs */
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_2],
+					 hwq_attr->sginfo);
+			if (rc)
+				goto fail;
+			hwq->level = BNG_PBL_LVL_2;
+			if (hwq_attr->sginfo->nopte)
+				goto done;
+			/* Fill PBLs with PTE pointers */
+			dst_virt_ptr =
+				(dma_addr_t **)hwq->pbl[BNG_PBL_LVL_1].pg_arr;
+			src_phys_ptr = hwq->pbl[BNG_PBL_LVL_2].pg_map_arr;
+			for (i = 0; i < hwq->pbl[BNG_PBL_LVL_2].pg_count; i++) {
+				dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
+					src_phys_ptr[i] | PTU_PTE_VALID;
+			}
+			if (hwq_attr->type == BNG_HWQ_TYPE_QUEUE) {
+				/* Find the last pg of the size */
+				i = hwq->pbl[BNG_PBL_LVL_2].pg_count;
+				dst_virt_ptr[PTR_PG(i - 1)][PTR_IDX(i - 1)] |=
+								  PTU_PTE_LAST;
+				if (i > 1)
+					dst_virt_ptr[PTR_PG(i - 2)]
+						    [PTR_IDX(i - 2)] |=
+						    PTU_PTE_NEXT_TO_LAST;
+			}
+		} else { /* pages < 512 npbl = 1, npde = 0 */
+			u32 flag = PTU_PTE_VALID;
+
+			/* 1 level of indirection */
+			npbl = npages >> MAX_PBL_LVL_1_PGS_SHIFT;
+			if (npages % BIT(MAX_PBL_LVL_1_PGS_SHIFT))
+				npbl++;
+			sginfo.npages = npbl;
+			sginfo.pgsize = PAGE_SIZE;
+			/* Alloc PBL page */
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_0], &sginfo);
+			if (rc)
+				goto fail;
+			/* Alloc or init  PTEs */
+			rc = bng_alloc_pbl(res, &hwq->pbl[BNG_PBL_LVL_1],
+					 hwq_attr->sginfo);
+			if (rc)
+				goto fail;
+			hwq->level = BNG_PBL_LVL_1;
+			if (hwq_attr->sginfo->nopte)
+				goto done;
+			/* Fill PBL with PTE pointers */
+			dst_virt_ptr =
+				(dma_addr_t **)hwq->pbl[BNG_PBL_LVL_0].pg_arr;
+			src_phys_ptr = hwq->pbl[BNG_PBL_LVL_1].pg_map_arr;
+			for (i = 0; i < hwq->pbl[BNG_PBL_LVL_1].pg_count; i++)
+				dst_virt_ptr[PTR_PG(i)][PTR_IDX(i)] =
+					src_phys_ptr[i] | flag;
+			if (hwq_attr->type == BNG_HWQ_TYPE_QUEUE) {
+				/* Find the last pg of the size */
+				i = hwq->pbl[BNG_PBL_LVL_1].pg_count;
+				dst_virt_ptr[PTR_PG(i - 1)][PTR_IDX(i - 1)] |=
+								  PTU_PTE_LAST;
+				if (i > 1)
+					dst_virt_ptr[PTR_PG(i - 2)]
+						    [PTR_IDX(i - 2)] |=
+						    PTU_PTE_NEXT_TO_LAST;
+			}
+		}
+	}
+done:
+	hwq->prod = 0;
+	hwq->cons = 0;
+	hwq->pdev = pdev;
+	hwq->depth = hwq_attr->depth;
+	hwq->max_elements = hwq->depth;
+	hwq->element_size = stride;
+	/* For direct access to the elements */
+	lvl = hwq->level;
+	if (hwq_attr->sginfo->nopte && hwq->level)
+		lvl = hwq->level - 1;
+	hwq->pbl_ptr = hwq->pbl[lvl].pg_arr;
+	hwq->pbl_dma_ptr = hwq->pbl[lvl].pg_map_arr;
+	spin_lock_init(&hwq->lock);
+
+	return 0;
+fail:
+	bng_re_free_hwq(res, hwq);
+	return -ENOMEM;
+}
diff --git a/drivers/infiniband/hw/bng_re/bng_res.h b/drivers/infiniband/hw/bng_re/bng_res.h
index d64833498e2a..e6123abadfad 100644
--- a/drivers/infiniband/hw/bng_re/bng_res.h
+++ b/drivers/infiniband/hw/bng_re/bng_res.h
@@ -6,6 +6,18 @@
 
 #define BNG_ROCE_FW_MAX_TIMEOUT	60
 
+#define PTR_CNT_PER_PG		(PAGE_SIZE / sizeof(void *))
+#define PTR_MAX_IDX_PER_PG	(PTR_CNT_PER_PG - 1)
+#define PTR_PG(x)		(((x) & ~PTR_MAX_IDX_PER_PG) / PTR_CNT_PER_PG)
+#define PTR_IDX(x)		((x) & PTR_MAX_IDX_PER_PG)
+
+#define MAX_PBL_LVL_0_PGS		1
+#define MAX_PBL_LVL_1_PGS		512
+#define MAX_PBL_LVL_1_PGS_SHIFT		9
+#define MAX_PBL_LVL_1_PGS_FOR_LVL_2	256
+#define MAX_PBL_LVL_2_PGS		(256 * 512)
+#define MAX_PDL_LVL_SHIFT               9
+
 struct bng_re_chip_ctx {
 	u16	chip_num;
 	u16	hw_stats_size;
@@ -13,4 +25,68 @@ struct bng_re_chip_ctx {
 	u16	hwrm_cmd_max_timeout;
 };
 
+struct bng_re_pbl {
+	u32		pg_count;
+	u32		pg_size;
+	void		**pg_arr;
+	dma_addr_t	*pg_map_arr;
+};
+
+enum bng_re_pbl_lvl {
+	BNG_PBL_LVL_0,
+	BNG_PBL_LVL_1,
+	BNG_PBL_LVL_2,
+	BNG_PBL_LVL_MAX
+};
+
+enum bng_re_hwq_type {
+	BNG_HWQ_TYPE_CTX,
+	BNG_HWQ_TYPE_QUEUE
+};
+
+struct bng_re_sg_info {
+	u32	npages;
+	u32	pgshft;
+	u32	pgsize;
+	bool	nopte;
+};
+
+struct bng_re_hwq_attr {
+	struct bng_re_res		*res;
+	struct bng_re_sg_info		*sginfo;
+	enum bng_re_hwq_type		type;
+	u32				depth;
+	u32				stride;
+	u32				aux_stride;
+	u32				aux_depth;
+};
+
+struct bng_re_hwq {
+	struct pci_dev			*pdev;
+	/* lock to protect hwq */
+	spinlock_t			lock;
+	struct bng_re_pbl		pbl[BNG_PBL_LVL_MAX + 1];
+	/* Valid values: 0, 1, 2 */
+	enum bng_re_pbl_lvl		level;
+	/* PBL entries */
+	void				**pbl_ptr;
+	/* PBL  dma_addr */
+	dma_addr_t			*pbl_dma_ptr;
+	u32				max_elements;
+	u32				depth;
+	u16				element_size;
+	u32				prod;
+	u32				cons;
+};
+
+struct bng_re_res {
+	struct pci_dev			*pdev;
+	struct bng_re_chip_ctx		*cctx;
+};
+
+void bng_re_free_hwq(struct bng_re_res *res,
+		     struct bng_re_hwq *hwq);
+
+int bng_re_alloc_init_hwq(struct bng_re_hwq *hwq,
+			  struct bng_re_hwq_attr *hwq_attr);
 #endif
-- 
2.34.1


