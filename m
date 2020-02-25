Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B857A16BFC1
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Feb 2020 12:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730008AbgBYLkf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Feb 2020 06:40:35 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:53090 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729178AbgBYLke (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 25 Feb 2020 06:40:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582630832; x=1614166832;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=m6UqmdZhS4vguvM1fDWyXqGMR80lteMFGItEPxM21pU=;
  b=hVLkEqhHaPtmVsdC894vxm0rEnHd6gKmRG8Af5vgKngJ/d3pBCzJQlfc
   pCA5pklBxMACo+Sguj+NXc960nLeOZDjHZOuXOR9p67nGqnno8cKhyFOx
   aQKLnVHeQTfSHnHqkegOCsw3Q6fj9otKWvcwxk6kZdBzIAYr7+EIWkVHu
   k=;
IronPort-SDR: /1Ie6mZ7Lu5k4H1dsLwxt49zeUmIKNXEpoS7ok0s/tp4I/cwvN5Eo0Ypnjd08D8o/hbDk7dLPH
 5fEkrFs3pKIg==
X-IronPort-AV: E=Sophos;i="5.70,483,1574121600"; 
   d="scan'208";a="27325157"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 25 Feb 2020 11:40:29 +0000
Received: from EX13MTAUEA002.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id A6E93A06B1;
        Tue, 25 Feb 2020 11:40:27 +0000 (UTC)
Received: from EX13D02EUC004.ant.amazon.com (10.43.164.117) by
 EX13MTAUEA002.ant.amazon.com (10.43.61.77) with Microsoft SMTP Server (TLS)
 id 15.0.1236.3; Tue, 25 Feb 2020 11:40:26 +0000
Received: from EX13MTAUEA002.ant.amazon.com (10.43.61.77) by
 EX13D02EUC004.ant.amazon.com (10.43.164.117) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 25 Feb 2020 11:40:25 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.132) by
 mail-relay.amazon.com (10.43.61.169) with Microsoft SMTP Server id
 15.0.1236.3 via Frontend Transport; Tue, 25 Feb 2020 11:40:23 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Firas JahJah <firasj@amazon.com>,
        "Yossi Leybovich" <sleybo@amazon.com>
Subject: [PATCH for-next v2 1/3] RDMA/efa: Unified getters/setters for device structs bitmask access
Date:   Tue, 25 Feb 2020 13:40:08 +0200
Message-ID: <20200225114010.21790-2-galpress@amazon.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200225114010.21790-1-galpress@amazon.com>
References: <20200225114010.21790-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use unified macros for device structs access instead of open coding the
shifts and masks over and over again.

Reviewed-by: Firas JahJah <firasj@amazon.com>
Reviewed-by: Yossi Leybovich <sleybo@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |   7 +-
 drivers/infiniband/hw/efa/efa_admin_defs.h    |   4 +-
 drivers/infiniband/hw/efa/efa_com.c           | 142 ++++++++----------
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  29 ++--
 drivers/infiniband/hw/efa/efa_common_defs.h   |  13 +-
 drivers/infiniband/hw/efa/efa_regs_defs.h     |  22 +--
 6 files changed, 93 insertions(+), 124 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index 74b787a90660..96b104ab5415 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_ADMIN_CMDS_H_
@@ -801,21 +801,16 @@ struct efa_admin_mmio_req_read_less_resp {
 
 /* create_qp_cmd */
 #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
-#define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_SHIFT               1
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
 
 /* reg_mr_cmd */
 #define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
-#define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_SHIFT     7
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_MASK      BIT(7)
 #define EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_MASK        BIT(0)
-#define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_SHIFT       2
 #define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_MASK        BIT(2)
 
 /* create_cq_cmd */
-#define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_SHIFT 5
 #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
-#define EFA_ADMIN_CREATE_CQ_CMD_VIRT_SHIFT                  6
 #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
 #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
 
diff --git a/drivers/infiniband/hw/efa/efa_admin_defs.h b/drivers/infiniband/hw/efa/efa_admin_defs.h
index c8e0c8b905be..29d53ed63b3e 100644
--- a/drivers/infiniband/hw/efa/efa_admin_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_ADMIN_H_
@@ -121,9 +121,7 @@ struct efa_admin_aenq_entry {
 /* aq_common_desc */
 #define EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK            GENMASK(11, 0)
 #define EFA_ADMIN_AQ_COMMON_DESC_PHASE_MASK                 BIT(0)
-#define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_SHIFT            1
 #define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_MASK             BIT(1)
-#define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_SHIFT   2
 #define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_MASK    BIT(2)
 
 /* acq_common_desc */
diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 0778f4f7dccd..00904c9b2ccb 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -16,21 +16,10 @@
 #define EFA_ASYNC_QUEUE_DEPTH 16
 #define EFA_ADMIN_QUEUE_DEPTH 32
 
-#define MIN_EFA_VER\
-	((EFA_ADMIN_API_VERSION_MAJOR << EFA_REGS_VERSION_MAJOR_VERSION_SHIFT) | \
-	 (EFA_ADMIN_API_VERSION_MINOR & EFA_REGS_VERSION_MINOR_VERSION_MASK))
-
 #define EFA_CTRL_MAJOR          0
 #define EFA_CTRL_MINOR          0
 #define EFA_CTRL_SUB_MINOR      1
 
-#define MIN_EFA_CTRL_VER \
-	(((EFA_CTRL_MAJOR) << \
-	(EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_SHIFT)) | \
-	((EFA_CTRL_MINOR) << \
-	(EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_SHIFT)) | \
-	(EFA_CTRL_SUB_MINOR))
-
 #define EFA_DMA_ADDR_TO_UINT32_LOW(x)   ((u32)((u64)(x)))
 #define EFA_DMA_ADDR_TO_UINT32_HIGH(x)  ((u32)(((u64)(x)) >> 32))
 
@@ -84,7 +73,7 @@ static u32 efa_com_reg_read32(struct efa_com_dev *edev, u16 offset)
 	struct efa_com_mmio_read *mmio_read = &edev->mmio_read;
 	struct efa_admin_mmio_req_read_less_resp *read_resp;
 	unsigned long exp_time;
-	u32 mmio_read_reg;
+	u32 mmio_read_reg = 0;
 	u32 err;
 
 	read_resp = mmio_read->read_resp;
@@ -94,10 +83,9 @@ static u32 efa_com_reg_read32(struct efa_com_dev *edev, u16 offset)
 
 	/* trash DMA req_id to identify when hardware is done */
 	read_resp->req_id = mmio_read->seq_num + 0x9aL;
-	mmio_read_reg = (offset << EFA_REGS_MMIO_REG_READ_REG_OFF_SHIFT) &
-			EFA_REGS_MMIO_REG_READ_REG_OFF_MASK;
-	mmio_read_reg |= mmio_read->seq_num &
-			 EFA_REGS_MMIO_REG_READ_REQ_ID_MASK;
+	EFA_SET(&mmio_read_reg, EFA_REGS_MMIO_REG_READ_REG_OFF, offset);
+	EFA_SET(&mmio_read_reg, EFA_REGS_MMIO_REG_READ_REQ_ID,
+		mmio_read->seq_num);
 
 	writel(mmio_read_reg, edev->reg_bar + EFA_REGS_MMIO_REG_READ_OFF);
 
@@ -137,9 +125,9 @@ static int efa_com_admin_init_sq(struct efa_com_dev *edev)
 	struct efa_com_admin_queue *aq = &edev->aq;
 	struct efa_com_admin_sq *sq = &aq->sq;
 	u16 size = aq->depth * sizeof(*sq->entries);
+	u32 aq_caps = 0;
 	u32 addr_high;
 	u32 addr_low;
-	u32 aq_caps;
 
 	sq->entries =
 		dma_alloc_coherent(aq->dmadev, size, &sq->dma_addr, GFP_KERNEL);
@@ -160,10 +148,9 @@ static int efa_com_admin_init_sq(struct efa_com_dev *edev)
 	writel(addr_low, edev->reg_bar + EFA_REGS_AQ_BASE_LO_OFF);
 	writel(addr_high, edev->reg_bar + EFA_REGS_AQ_BASE_HI_OFF);
 
-	aq_caps = aq->depth & EFA_REGS_AQ_CAPS_AQ_DEPTH_MASK;
-	aq_caps |= (sizeof(struct efa_admin_aq_entry) <<
-			EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_SHIFT) &
-			EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_MASK;
+	EFA_SET(&aq_caps, EFA_REGS_AQ_CAPS_AQ_DEPTH, aq->depth);
+	EFA_SET(&aq_caps, EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE,
+		sizeof(struct efa_admin_aq_entry));
 
 	writel(aq_caps, edev->reg_bar + EFA_REGS_AQ_CAPS_OFF);
 
@@ -175,9 +162,9 @@ static int efa_com_admin_init_cq(struct efa_com_dev *edev)
 	struct efa_com_admin_queue *aq = &edev->aq;
 	struct efa_com_admin_cq *cq = &aq->cq;
 	u16 size = aq->depth * sizeof(*cq->entries);
+	u32 acq_caps = 0;
 	u32 addr_high;
 	u32 addr_low;
-	u32 acq_caps;
 
 	cq->entries =
 		dma_alloc_coherent(aq->dmadev, size, &cq->dma_addr, GFP_KERNEL);
@@ -195,13 +182,11 @@ static int efa_com_admin_init_cq(struct efa_com_dev *edev)
 	writel(addr_low, edev->reg_bar + EFA_REGS_ACQ_BASE_LO_OFF);
 	writel(addr_high, edev->reg_bar + EFA_REGS_ACQ_BASE_HI_OFF);
 
-	acq_caps = aq->depth & EFA_REGS_ACQ_CAPS_ACQ_DEPTH_MASK;
-	acq_caps |= (sizeof(struct efa_admin_acq_entry) <<
-			EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_SHIFT) &
-			EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_MASK;
-	acq_caps |= (aq->msix_vector_idx <<
-			EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR_SHIFT) &
-			EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR_MASK;
+	EFA_SET(&acq_caps, EFA_REGS_ACQ_CAPS_ACQ_DEPTH, aq->depth);
+	EFA_SET(&acq_caps, EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE,
+		sizeof(struct efa_admin_acq_entry));
+	EFA_SET(&acq_caps, EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR,
+		aq->msix_vector_idx);
 
 	writel(acq_caps, edev->reg_bar + EFA_REGS_ACQ_CAPS_OFF);
 
@@ -212,7 +197,8 @@ static int efa_com_admin_init_aenq(struct efa_com_dev *edev,
 				   struct efa_aenq_handlers *aenq_handlers)
 {
 	struct efa_com_aenq *aenq = &edev->aenq;
-	u32 addr_low, addr_high, aenq_caps;
+	u32 addr_low, addr_high;
+	u32 aenq_caps = 0;
 	u16 size;
 
 	if (!aenq_handlers) {
@@ -237,13 +223,11 @@ static int efa_com_admin_init_aenq(struct efa_com_dev *edev,
 	writel(addr_low, edev->reg_bar + EFA_REGS_AENQ_BASE_LO_OFF);
 	writel(addr_high, edev->reg_bar + EFA_REGS_AENQ_BASE_HI_OFF);
 
-	aenq_caps = aenq->depth & EFA_REGS_AENQ_CAPS_AENQ_DEPTH_MASK;
-	aenq_caps |= (sizeof(struct efa_admin_aenq_entry) <<
-		EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_SHIFT) &
-		EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_MASK;
-	aenq_caps |= (aenq->msix_vector_idx
-		      << EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_SHIFT) &
-		     EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_MASK;
+	EFA_SET(&aenq_caps, EFA_REGS_AENQ_CAPS_AENQ_DEPTH, aenq->depth);
+	EFA_SET(&aenq_caps, EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE,
+		sizeof(struct efa_admin_aenq_entry));
+	EFA_SET(&aenq_caps, EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR,
+		aenq->msix_vector_idx);
 	writel(aenq_caps, edev->reg_bar + EFA_REGS_AENQ_CAPS_OFF);
 
 	/*
@@ -280,8 +264,8 @@ static void efa_com_dealloc_ctx_id(struct efa_com_admin_queue *aq,
 static inline void efa_com_put_comp_ctx(struct efa_com_admin_queue *aq,
 					struct efa_comp_ctx *comp_ctx)
 {
-	u16 cmd_id = comp_ctx->user_cqe->acq_common_descriptor.command &
-		     EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK;
+	u16 cmd_id = EFA_GET(&comp_ctx->user_cqe->acq_common_descriptor.command,
+			     EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 	u16 ctx_id = cmd_id & (aq->depth - 1);
 
 	ibdev_dbg(aq->efa_dev, "Put completion command_id %#x\n", cmd_id);
@@ -335,8 +319,8 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 	cmd_id &= EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK;
 
 	cmd->aq_common_descriptor.command_id = cmd_id;
-	cmd->aq_common_descriptor.flags |= aq->sq.phase &
-		EFA_ADMIN_AQ_COMMON_DESC_PHASE_MASK;
+	EFA_SET(&cmd->aq_common_descriptor.flags,
+		EFA_ADMIN_AQ_COMMON_DESC_PHASE, aq->sq.phase);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, true);
 	if (!comp_ctx) {
@@ -427,8 +411,8 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 	struct efa_comp_ctx *comp_ctx;
 	u16 cmd_id;
 
-	cmd_id = cqe->acq_common_descriptor.command &
-		 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK;
+	cmd_id = EFA_GET(&cqe->acq_common_descriptor.command,
+			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
 	if (!comp_ctx) {
@@ -743,7 +727,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 	int err;
 
 	dev_sts = efa_com_reg_read32(edev, EFA_REGS_DEV_STS_OFF);
-	if (!(dev_sts & EFA_REGS_DEV_STS_READY_MASK)) {
+	if (!EFA_GET(&dev_sts, EFA_REGS_DEV_STS_READY)) {
 		ibdev_err(edev->efa_dev,
 			  "Device isn't ready, abort com init %#x\n", dev_sts);
 		return -ENODEV;
@@ -778,8 +762,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 		goto err_destroy_cq;
 
 	cap = efa_com_reg_read32(edev, EFA_REGS_CAPS_OFF);
-	timeout = (cap & EFA_REGS_CAPS_ADMIN_CMD_TO_MASK) >>
-		  EFA_REGS_CAPS_ADMIN_CMD_TO_SHIFT;
+	timeout = EFA_GET(&cap, EFA_REGS_CAPS_ADMIN_CMD_TO);
 	if (timeout)
 		/* the resolution of timeout reg is 100ms */
 		aq->completion_timeout = timeout * 100000;
@@ -940,7 +923,9 @@ void efa_com_mmio_reg_read_destroy(struct efa_com_dev *edev)
 
 int efa_com_validate_version(struct efa_com_dev *edev)
 {
+	u32 min_ctrl_ver = 0;
 	u32 ctrl_ver_masked;
+	u32 min_ver = 0;
 	u32 ctrl_ver;
 	u32 ver;
 
@@ -953,11 +938,12 @@ int efa_com_validate_version(struct efa_com_dev *edev)
 				      EFA_REGS_CONTROLLER_VERSION_OFF);
 
 	ibdev_dbg(edev->efa_dev, "efa device version: %d.%d\n",
-		  (ver & EFA_REGS_VERSION_MAJOR_VERSION_MASK) >>
-			  EFA_REGS_VERSION_MAJOR_VERSION_SHIFT,
-		  ver & EFA_REGS_VERSION_MINOR_VERSION_MASK);
+		  EFA_GET(&ver, EFA_REGS_VERSION_MAJOR_VERSION),
+		  EFA_GET(&ver, EFA_REGS_VERSION_MINOR_VERSION));
 
-	if (ver < MIN_EFA_VER) {
+	EFA_SET(&min_ver, EFA_REGS_VERSION_MAJOR_VERSION, EFA_ADMIN_API_VERSION_MAJOR);
+	EFA_SET(&min_ver, EFA_REGS_VERSION_MINOR_VERSION, EFA_ADMIN_API_VERSION_MINOR);
+	if (ver < min_ver) {
 		ibdev_err(edev->efa_dev,
 			  "EFA version is lower than the minimal version the driver supports\n");
 		return -EOPNOTSUPP;
@@ -965,21 +951,25 @@ int efa_com_validate_version(struct efa_com_dev *edev)
 
 	ibdev_dbg(edev->efa_dev,
 		  "efa controller version: %d.%d.%d implementation version %d\n",
-		  (ctrl_ver & EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_MASK) >>
-			  EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_SHIFT,
-		  (ctrl_ver & EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_MASK) >>
-			  EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_SHIFT,
-		  (ctrl_ver & EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION_MASK),
-		  (ctrl_ver & EFA_REGS_CONTROLLER_VERSION_IMPL_ID_MASK) >>
-			  EFA_REGS_CONTROLLER_VERSION_IMPL_ID_SHIFT);
+		  EFA_GET(&ctrl_ver, EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION),
+		  EFA_GET(&ctrl_ver, EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION),
+		  EFA_GET(&ctrl_ver,
+			  EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION),
+		  EFA_GET(&ctrl_ver, EFA_REGS_CONTROLLER_VERSION_IMPL_ID));
 
 	ctrl_ver_masked =
-		(ctrl_ver & EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_MASK) |
-		(ctrl_ver & EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_MASK) |
-		(ctrl_ver & EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION_MASK);
+		EFA_GET(&ctrl_ver, EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION) |
+		EFA_GET(&ctrl_ver, EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION) |
+		EFA_GET(&ctrl_ver, EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION);
 
+	EFA_SET(&min_ctrl_ver, EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION,
+		EFA_CTRL_MAJOR);
+	EFA_SET(&min_ctrl_ver, EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION,
+		EFA_CTRL_MINOR);
+	EFA_SET(&min_ctrl_ver, EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION,
+		EFA_CTRL_SUB_MINOR);
 	/* Validate the ctrl version without the implementation ID */
-	if (ctrl_ver_masked < MIN_EFA_CTRL_VER) {
+	if (ctrl_ver_masked < min_ctrl_ver) {
 		ibdev_err(edev->efa_dev,
 			  "EFA ctrl version is lower than the minimal ctrl version the driver supports\n");
 		return -EOPNOTSUPP;
@@ -1002,8 +992,7 @@ int efa_com_get_dma_width(struct efa_com_dev *edev)
 	u32 caps = efa_com_reg_read32(edev, EFA_REGS_CAPS_OFF);
 	int width;
 
-	width = (caps & EFA_REGS_CAPS_DMA_ADDR_WIDTH_MASK) >>
-		EFA_REGS_CAPS_DMA_ADDR_WIDTH_SHIFT;
+	width = EFA_GET(&caps, EFA_REGS_CAPS_DMA_ADDR_WIDTH);
 
 	ibdev_dbg(edev->efa_dev, "DMA width: %d\n", width);
 
@@ -1017,16 +1006,14 @@ int efa_com_get_dma_width(struct efa_com_dev *edev)
 	return width;
 }
 
-static int wait_for_reset_state(struct efa_com_dev *edev, u32 timeout,
-				u16 exp_state)
+static int wait_for_reset_state(struct efa_com_dev *edev, u32 timeout, int on)
 {
 	u32 val, i;
 
 	for (i = 0; i < timeout; i++) {
 		val = efa_com_reg_read32(edev, EFA_REGS_DEV_STS_OFF);
 
-		if ((val & EFA_REGS_DEV_STS_RESET_IN_PROGRESS_MASK) ==
-		    exp_state)
+		if (EFA_GET(&val, EFA_REGS_DEV_STS_RESET_IN_PROGRESS) == on)
 			return 0;
 
 		ibdev_dbg(edev->efa_dev, "Reset indication val %d\n", val);
@@ -1046,36 +1033,34 @@ static int wait_for_reset_state(struct efa_com_dev *edev, u32 timeout,
 int efa_com_dev_reset(struct efa_com_dev *edev,
 		      enum efa_regs_reset_reason_types reset_reason)
 {
-	u32 stat, timeout, cap, reset_val;
+	u32 stat, timeout, cap;
+	u32 reset_val = 0;
 	int err;
 
 	stat = efa_com_reg_read32(edev, EFA_REGS_DEV_STS_OFF);
 	cap = efa_com_reg_read32(edev, EFA_REGS_CAPS_OFF);
 
-	if (!(stat & EFA_REGS_DEV_STS_READY_MASK)) {
+	if (!EFA_GET(&stat, EFA_REGS_DEV_STS_READY)) {
 		ibdev_err(edev->efa_dev,
 			  "Device isn't ready, can't reset device\n");
 		return -EINVAL;
 	}
 
-	timeout = (cap & EFA_REGS_CAPS_RESET_TIMEOUT_MASK) >>
-		  EFA_REGS_CAPS_RESET_TIMEOUT_SHIFT;
+	timeout = EFA_GET(&cap, EFA_REGS_CAPS_RESET_TIMEOUT);
 	if (!timeout) {
 		ibdev_err(edev->efa_dev, "Invalid timeout value\n");
 		return -EINVAL;
 	}
 
 	/* start reset */
-	reset_val = EFA_REGS_DEV_CTL_DEV_RESET_MASK;
-	reset_val |= (reset_reason << EFA_REGS_DEV_CTL_RESET_REASON_SHIFT) &
-		     EFA_REGS_DEV_CTL_RESET_REASON_MASK;
+	EFA_SET(&reset_val, EFA_REGS_DEV_CTL_DEV_RESET, 1);
+	EFA_SET(&reset_val, EFA_REGS_DEV_CTL_RESET_REASON, reset_reason);
 	writel(reset_val, edev->reg_bar + EFA_REGS_DEV_CTL_OFF);
 
 	/* reset clears the mmio readless address, restore it */
 	efa_com_mmio_reg_read_resp_addr_init(edev);
 
-	err = wait_for_reset_state(edev, timeout,
-				   EFA_REGS_DEV_STS_RESET_IN_PROGRESS_MASK);
+	err = wait_for_reset_state(edev, timeout, 1);
 	if (err) {
 		ibdev_err(edev->efa_dev, "Reset indication didn't turn on\n");
 		return err;
@@ -1089,8 +1074,7 @@ int efa_com_dev_reset(struct efa_com_dev *edev,
 		return err;
 	}
 
-	timeout = (cap & EFA_REGS_CAPS_ADMIN_CMD_TO_MASK) >>
-		  EFA_REGS_CAPS_ADMIN_CMD_TO_SHIFT;
+	timeout = EFA_GET(&cap, EFA_REGS_CAPS_ADMIN_CMD_TO);
 	if (timeout)
 		/* the resolution of timeout reg is 100ms */
 		edev->aq.completion_timeout = timeout * 100000;
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index e20bd84a1014..eea5574a62e8 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #include "efa_com.h"
@@ -161,8 +161,9 @@ int efa_com_create_cq(struct efa_com_dev *edev,
 	int err;
 
 	create_cmd.aq_common_desc.opcode = EFA_ADMIN_CREATE_CQ;
-	create_cmd.cq_caps_2 = (params->entry_size_in_bytes / 4) &
-				EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK;
+	EFA_SET(&create_cmd.cq_caps_2,
+		EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS,
+		params->entry_size_in_bytes / 4);
 	create_cmd.cq_depth = params->cq_depth;
 	create_cmd.num_sub_cqs = params->num_sub_cqs;
 	create_cmd.uar = params->uarn;
@@ -227,8 +228,8 @@ int efa_com_register_mr(struct efa_com_dev *edev,
 	mr_cmd.aq_common_desc.opcode = EFA_ADMIN_REG_MR;
 	mr_cmd.pd = params->pd;
 	mr_cmd.mr_length = params->mr_length_in_bytes;
-	mr_cmd.flags |= params->page_shift &
-		EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK;
+	EFA_SET(&mr_cmd.flags, EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT,
+		params->page_shift);
 	mr_cmd.iova = params->iova;
 	mr_cmd.permissions = params->permissions;
 
@@ -242,11 +243,11 @@ int efa_com_register_mr(struct efa_com_dev *edev,
 			params->pbl.pbl.address.mem_addr_low;
 		mr_cmd.pbl.pbl.address.mem_addr_high =
 			params->pbl.pbl.address.mem_addr_high;
-		mr_cmd.aq_common_desc.flags |=
-			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_MASK;
+		EFA_SET(&mr_cmd.aq_common_desc.flags,
+			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA, 1);
 		if (params->indirect)
-			mr_cmd.aq_common_desc.flags |=
-				EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_MASK;
+			EFA_SET(&mr_cmd.aq_common_desc.flags,
+				EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT, 1);
 	}
 
 	err = efa_com_cmd_exec(aq,
@@ -386,9 +387,8 @@ static int efa_com_get_feature_ex(struct efa_com_dev *edev,
 	get_cmd.aq_common_descriptor.opcode = EFA_ADMIN_GET_FEATURE;
 
 	if (control_buff_size)
-		get_cmd.aq_common_descriptor.flags =
-			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_MASK;
-
+		EFA_SET(&get_cmd.aq_common_descriptor.flags,
+			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT, 1);
 
 	efa_com_set_dma_addr(control_buf_dma_addr,
 			     &get_cmd.control_buffer.address.mem_addr_high,
@@ -538,8 +538,9 @@ static int efa_com_set_feature_ex(struct efa_com_dev *edev,
 
 	set_cmd->aq_common_descriptor.opcode = EFA_ADMIN_SET_FEATURE;
 	if (control_buff_size) {
-		set_cmd->aq_common_descriptor.flags =
-			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_MASK;
+		set_cmd->aq_common_descriptor.flags = 0;
+		EFA_SET(&set_cmd->aq_common_descriptor.flags,
+			EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT, 1);
 		efa_com_set_dma_addr(control_buf_dma_addr,
 				     &set_cmd->control_buffer.address.mem_addr_high,
 				     &set_cmd->control_buffer.address.mem_addr_low);
diff --git a/drivers/infiniband/hw/efa/efa_common_defs.h b/drivers/infiniband/hw/efa/efa_common_defs.h
index c559ec08898e..d5e750581f21 100644
--- a/drivers/infiniband/hw/efa/efa_common_defs.h
+++ b/drivers/infiniband/hw/efa/efa_common_defs.h
@@ -1,14 +1,25 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_COMMON_H_
 #define _EFA_COMMON_H_
 
+#include <linux/bitfield.h>
+
 #define EFA_COMMON_SPEC_VERSION_MAJOR        2
 #define EFA_COMMON_SPEC_VERSION_MINOR        0
 
+#define EFA_GET(ptr, mask) FIELD_GET(mask##_MASK, *(ptr))
+
+#define EFA_SET(ptr, mask, value) \
+	({ \
+		typeof(ptr) _ptr = ptr; \
+		*_ptr = (*_ptr & ~(mask##_MASK)) | \
+			FIELD_PREP(mask##_MASK, value); \
+	})
+
 struct efa_common_mem_addr {
 	u32 mem_addr_low;
 
diff --git a/drivers/infiniband/hw/efa/efa_regs_defs.h b/drivers/infiniband/hw/efa/efa_regs_defs.h
index bb9cad3d6a15..322a2c0d4ef9 100644
--- a/drivers/infiniband/hw/efa/efa_regs_defs.h
+++ b/drivers/infiniband/hw/efa/efa_regs_defs.h
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause */
 /*
- * Copyright 2018-2019 Amazon.com, Inc. or its affiliates. All rights reserved.
+ * Copyright 2018-2020 Amazon.com, Inc. or its affiliates. All rights reserved.
  */
 
 #ifndef _EFA_REGS_H_
@@ -45,69 +45,49 @@ enum efa_regs_reset_reason_types {
 
 /* version register */
 #define EFA_REGS_VERSION_MINOR_VERSION_MASK                 0xff
-#define EFA_REGS_VERSION_MAJOR_VERSION_SHIFT                8
 #define EFA_REGS_VERSION_MAJOR_VERSION_MASK                 0xff00
 
 /* controller_version register */
 #define EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION_MASK   0xff
-#define EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_SHIFT     8
 #define EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_MASK      0xff00
-#define EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_SHIFT     16
 #define EFA_REGS_CONTROLLER_VERSION_MAJOR_VERSION_MASK      0xff0000
-#define EFA_REGS_CONTROLLER_VERSION_IMPL_ID_SHIFT           24
 #define EFA_REGS_CONTROLLER_VERSION_IMPL_ID_MASK            0xff000000
 
 /* caps register */
 #define EFA_REGS_CAPS_CONTIGUOUS_QUEUE_REQUIRED_MASK        0x1
-#define EFA_REGS_CAPS_RESET_TIMEOUT_SHIFT                   1
 #define EFA_REGS_CAPS_RESET_TIMEOUT_MASK                    0x3e
-#define EFA_REGS_CAPS_DMA_ADDR_WIDTH_SHIFT                  8
 #define EFA_REGS_CAPS_DMA_ADDR_WIDTH_MASK                   0xff00
-#define EFA_REGS_CAPS_ADMIN_CMD_TO_SHIFT                    16
 #define EFA_REGS_CAPS_ADMIN_CMD_TO_MASK                     0xf0000
 
 /* aq_caps register */
 #define EFA_REGS_AQ_CAPS_AQ_DEPTH_MASK                      0xffff
-#define EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_SHIFT                16
 #define EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_MASK                 0xffff0000
 
 /* acq_caps register */
 #define EFA_REGS_ACQ_CAPS_ACQ_DEPTH_MASK                    0xffff
-#define EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_SHIFT              16
 #define EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_MASK               0xff0000
-#define EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR_SHIFT             24
 #define EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR_MASK              0xff000000
 
 /* aenq_caps register */
 #define EFA_REGS_AENQ_CAPS_AENQ_DEPTH_MASK                  0xffff
-#define EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_SHIFT            16
 #define EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_MASK             0xff0000
-#define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_SHIFT           24
 #define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_MASK            0xff000000
 
 /* dev_ctl register */
 #define EFA_REGS_DEV_CTL_DEV_RESET_MASK                     0x1
-#define EFA_REGS_DEV_CTL_AQ_RESTART_SHIFT                   1
 #define EFA_REGS_DEV_CTL_AQ_RESTART_MASK                    0x2
-#define EFA_REGS_DEV_CTL_RESET_REASON_SHIFT                 28
 #define EFA_REGS_DEV_CTL_RESET_REASON_MASK                  0xf0000000
 
 /* dev_sts register */
 #define EFA_REGS_DEV_STS_READY_MASK                         0x1
-#define EFA_REGS_DEV_STS_AQ_RESTART_IN_PROGRESS_SHIFT       1
 #define EFA_REGS_DEV_STS_AQ_RESTART_IN_PROGRESS_MASK        0x2
-#define EFA_REGS_DEV_STS_AQ_RESTART_FINISHED_SHIFT          2
 #define EFA_REGS_DEV_STS_AQ_RESTART_FINISHED_MASK           0x4
-#define EFA_REGS_DEV_STS_RESET_IN_PROGRESS_SHIFT            3
 #define EFA_REGS_DEV_STS_RESET_IN_PROGRESS_MASK             0x8
-#define EFA_REGS_DEV_STS_RESET_FINISHED_SHIFT               4
 #define EFA_REGS_DEV_STS_RESET_FINISHED_MASK                0x10
-#define EFA_REGS_DEV_STS_FATAL_ERROR_SHIFT                  5
 #define EFA_REGS_DEV_STS_FATAL_ERROR_MASK                   0x20
 
 /* mmio_reg_read register */
 #define EFA_REGS_MMIO_REG_READ_REQ_ID_MASK                  0xffff
-#define EFA_REGS_MMIO_REG_READ_REG_OFF_SHIFT                16
 #define EFA_REGS_MMIO_REG_READ_REG_OFF_MASK                 0xffff0000
 
 #endif /* _EFA_REGS_H_ */
-- 
2.25.0

