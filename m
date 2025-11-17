Return-Path: <linux-rdma+bounces-14544-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A3202C6575F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 18:24:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BAFAE4F5052
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 17:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6632C33E;
	Mon, 17 Nov 2025 17:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="eKiwqOoV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f225.google.com (mail-qt1-f225.google.com [209.85.160.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4318432254E
	for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 17:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399560; cv=none; b=IbZp4l1gbdBD8g+6NHfNPRZu01zv8BqneWJOuxK4EJ09nVoW2cLSKde3+/VPl69LkH7nYKu424GqzN/m0VWcsm4xi1unU1cuHFtdKW8uBXdqnkMkxutphzE/2aO1EOdmXagxBn/OPVWIMHt1x9MVc/MWzGU+v2rp204VD4IRGTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399560; c=relaxed/simple;
	bh=KRBAfsP1CIePvQOEvg0cTATn15M2lY/4Ra9ttJkkPRs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b+QdoM6Q94McLVho3SMwPM6OX1Iw1BjDcUWpSxgwfmHY6T7B5emmevZ/pjum4Ner+nct2wdKymNjJvpzRpWxpQye2stLo9ZdilInnFsxd9wYt5SxBtq78AcIMcqpWOfdoFcOot2oQBMZs2m3DU0vvVpUJ8zRAZDDeDalQKyisPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=eKiwqOoV; arc=none smtp.client-ip=209.85.160.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f225.google.com with SMTP id d75a77b69052e-4ee1e18fb37so16120281cf.0
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:12:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763399557; x=1764004357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ii8xJxIBH7sk5ETjQaOZ+tU1o0eewtiEBDWlKvAOFk8=;
        b=R9hCueE5kSC3C6M9VQd5qPGwiCMO47xtGT/dcVcKipxxQJCsScpw4JL0cftK7Eugc3
         NgmSuVaYdI6m1ovLepEXTv/Eunuy8H1yO8o7irW7dH/L5OL0gjeNVCVNlLw0Pc1gyMRj
         w2igGeb6o9PxklVgShmhM37hbNL2XI79+/31HlQlQ/Hgcr7h7orS0mtvXXPbAn5ldDB5
         ktIrcF16kRleF2PwgBpiPK986ig4qzw28/AuzeR5qa4LOoWvdyDToaiL1MGUQ5LrFl67
         1Sb/QNzVj8CQa9NFtcQNUmGWqvzgDdvu2AVSX2YyhNejahviUyBTjkSOmyAVZOC0rC//
         FTwA==
X-Gm-Message-State: AOJu0YxGEZdrpKOlXG0za01BC982OICbSGUCb9GL7Tove+8Fl5kjwqA9
	FmtlfvHgFAg2C7ukI+FVXqledyaao4/z8vjkZ4x8WsV3K2nyLxb+z4bvsd8zsu/0WQJYIk8oM/C
	nnnqjm9f1Bh2O1eTpCE6BNo5fRMeeHZ/RGPc+N9XipeToFy03/CMTk/S11CsjzYcHIpCQwTKCS0
	qgV2nswe9hRVmUaEfC9GrHuACKiyP+5KQn5nSdmnEyxwY4mbkdeSdiK2HbfsIe/onUuFZN0pfB3
	6BJCM3FbZKSTCD/5A==
X-Gm-Gg: ASbGncteD2a8deoEgE57mV28x6/3Q/t1jet2rn1T+MJb7AF9vswDAVdVISj7D1QgeA/
	jwSjYaMA01tOqb7QjmGTPzobntHMyL8TBSa0N0Cj8qpX88xu1uPzj3rODmxQ+eCeXtBj+QYClMF
	T2t4E+d+I8a5JfMWGIQSUa89wwijHVt09YRSmOtWlwITLtntSMnMhlmigTlnQN9sO7HMXyUtEi4
	N4q4peBdFWlLYy6JS45Zc/vvm9AU2DmJ8zQ/6FwFi/GdOrdHEfSTu7nbrAxO7OjHCanQxH4gpnp
	VE8OBjSOraqJRoCBqXVtiQZcZNdap7LL2UEqSr1VWxgyzZW4S9Y9UopGJIEA3HiMC/PFt+p3b1b
	eK3b5RbExROeXhqF8tnW/vmKAuQ0m37HC29bxB0wSSnBGO9VzWIvv28RVi048yWHYAdA5NWphDX
	c3GHWFq1yF7Wlum+rZ0GTZJzuydK9vX4/V
X-Google-Smtp-Source: AGHT+IG6eQO+trO2Gh+3FyRMQUjZYUI2aehYO8gUWGdw1UrIQh8vNoQJit0pC2i2Yb1sPBiHJZt8lNlb++br
X-Received: by 2002:a05:622a:10f:b0:4eb:a216:c070 with SMTP id d75a77b69052e-4edf2184598mr184501351cf.84.1763399557032;
        Mon, 17 Nov 2025 09:12:37 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-77.dlp.protect.broadcom.com. [144.49.247.77])
        by smtp-relay.gmail.com with ESMTPS id d75a77b69052e-4ee1bf11b10sm2920911cf.4.2025.11.17.09.12.36
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2025 09:12:37 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-88050bdc2abso158565086d6.2
        for <linux-rdma@vger.kernel.org>; Mon, 17 Nov 2025 09:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763399556; x=1764004356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ii8xJxIBH7sk5ETjQaOZ+tU1o0eewtiEBDWlKvAOFk8=;
        b=eKiwqOoVoH2Sn7KZV4JeLFWkq8Im/nc+HxGBjZF4YNhBR5V2//sp+EZ77lB6p0vZgc
         D3/8QcpXGOmdVf1I4Ng/nam3ZOTGpHG78u/SScAWjiidP9fvFFuoJXT42B+T1h8pcamW
         /RAkVTtkfdXPBWNSe3ePfB5iZzu3l6GIeMaag=
X-Received: by 2002:ad4:5cce:0:b0:87f:bd05:1c89 with SMTP id 6a1803df08f44-88292658fdbmr172848666d6.35.1763399556073;
        Mon, 17 Nov 2025 09:12:36 -0800 (PST)
X-Received: by 2002:ad4:5cce:0:b0:87f:bd05:1c89 with SMTP id 6a1803df08f44-88292658fdbmr172848076d6.35.1763399555558;
        Mon, 17 Nov 2025 09:12:35 -0800 (PST)
Received: from sjs-csg-thor3-swe-29.lvn.broadcom.net044broadcom.net ([192.19.224.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-88286314557sm96082236d6.20.2025.11.17.09.12.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 09:12:34 -0800 (PST)
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
Subject: [PATCH v3 4/8] RDMA/bng_re: Allocate required memory resources for Firmware channel
Date: Mon, 17 Nov 2025 17:11:22 +0000
Message-ID: <20251117171136.128193-5-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117171136.128193-1-siva.kallam@broadcom.com>
References: <20251117171136.128193-1-siva.kallam@broadcom.com>
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
2.43.0


