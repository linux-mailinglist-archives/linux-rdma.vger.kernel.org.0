Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B61C13A351
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jan 2020 09:57:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727083AbgANI5Y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Jan 2020 03:57:24 -0500
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4604 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgANI5X (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Jan 2020 03:57:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1578992241; x=1610528241;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ybajBKS8aEYES4jDwa1vO7+TfAcklYJzR7/FYH0bwws=;
  b=BCrYTVzIWMSIZXKcCsA5+FCbKGoLoJpioz+R8PmkJr+4ZMEghuwrnDO/
   AuARJkjz8LkjUHGWuO9bOCEmH7w5Oth9zE4u/UOCthzOhgo94hB4Ixm+S
   kOmZdiud9sss2LKVAkBgSJwWX5Y3UCGH4HzwnOSLq1Uwc7KLpdBNcmL9i
   w=;
IronPort-SDR: gJfF9F1MxTY2Tyi+ItvxDDD31Tcqirfu0b9c6i9d4He8aoktRulhIIzTGbtQnPeE0XzqEoYOkG
 5X+lTVTyxYDw==
X-IronPort-AV: E=Sophos;i="5.69,432,1571702400"; 
   d="scan'208";a="12864391"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 14 Jan 2020 08:57:21 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 1578BA2869;
        Tue, 14 Jan 2020 08:57:19 +0000 (UTC)
Received: from EX13D19EUA002.ant.amazon.com (10.43.165.247) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:19 +0000
Received: from EX13MTAUEE002.ant.amazon.com (10.43.62.24) by
 EX13D19EUA002.ant.amazon.com (10.43.165.247) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 14 Jan 2020 08:57:18 +0000
Received: from 8c85908914bf.ant.amazon.com (10.218.69.133) by
 mail-relay.amazon.com (10.43.62.224) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Tue, 14 Jan 2020 08:57:15 +0000
From:   Gal Pressman <galpress@amazon.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, Doug Ledford <dledford@redhat.com>
CC:     <linux-rdma@vger.kernel.org>,
        Alexander Matushevsky <matua@amazon.com>,
        Gal Pressman <galpress@amazon.com>,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Firas JahJah <firasj@amazon.com>
Subject: [PATCH for-next 1/6] RDMA/efa: Unified getters/setters for device structs bitmask access
Date:   Tue, 14 Jan 2020 10:57:01 +0200
Message-ID: <20200114085706.82229-2-galpress@amazon.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200114085706.82229-1-galpress@amazon.com>
References: <20200114085706.82229-1-galpress@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Use unified macros for device structs access instead of open coding the
shifts and masks over and over again.

Reviewed-by: Daniel Kranzdorf <dkkranzd@amazon.com>
Reviewed-by: Firas JahJah <firasj@amazon.com>
Signed-off-by: Gal Pressman <galpress@amazon.com>
---
 .../infiniband/hw/efa/efa_admin_cmds_defs.h   |   6 +
 drivers/infiniband/hw/efa/efa_admin_defs.h    |   5 +
 drivers/infiniband/hw/efa/efa_com.c           | 115 ++++++++----------
 drivers/infiniband/hw/efa/efa_com_cmd.c       |  27 ++--
 drivers/infiniband/hw/efa/efa_common_defs.h   |   6 +
 drivers/infiniband/hw/efa/efa_regs_defs.h     |   9 ++
 6 files changed, 90 insertions(+), 78 deletions(-)

diff --git a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
index e96bcb16bd2b..a589a471d122 100644
--- a/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_cmds_defs.h
@@ -789,14 +789,17 @@ struct efa_admin_mmio_req_read_less_resp {
 };
 
 /* create_qp_cmd */
+#define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_SHIFT               0
 #define EFA_ADMIN_CREATE_QP_CMD_SQ_VIRT_MASK                BIT(0)
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_SHIFT               1
 #define EFA_ADMIN_CREATE_QP_CMD_RQ_VIRT_MASK                BIT(1)
 
 /* reg_mr_cmd */
+#define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_SHIFT     0
 #define EFA_ADMIN_REG_MR_CMD_PHYS_PAGE_SIZE_SHIFT_MASK      GENMASK(4, 0)
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_SHIFT     7
 #define EFA_ADMIN_REG_MR_CMD_MEM_ADDR_PHY_MODE_EN_MASK      BIT(7)
+#define EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_SHIFT       0
 #define EFA_ADMIN_REG_MR_CMD_LOCAL_WRITE_ENABLE_MASK        BIT(0)
 #define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_SHIFT       2
 #define EFA_ADMIN_REG_MR_CMD_REMOTE_READ_ENABLE_MASK        BIT(2)
@@ -806,12 +809,15 @@ struct efa_admin_mmio_req_read_less_resp {
 #define EFA_ADMIN_CREATE_CQ_CMD_INTERRUPT_MODE_ENABLED_MASK BIT(5)
 #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_SHIFT                  6
 #define EFA_ADMIN_CREATE_CQ_CMD_VIRT_MASK                   BIT(6)
+#define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_SHIFT   0
 #define EFA_ADMIN_CREATE_CQ_CMD_CQ_ENTRY_SIZE_WORDS_MASK    GENMASK(4, 0)
 
 /* get_set_feature_common_desc */
+#define EFA_ADMIN_GET_SET_FEATURE_COMMON_DESC_SELECT_SHIFT  0
 #define EFA_ADMIN_GET_SET_FEATURE_COMMON_DESC_SELECT_MASK   GENMASK(1, 0)
 
 /* feature_device_attr_desc */
+#define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_SHIFT  0
 #define EFA_ADMIN_FEATURE_DEVICE_ATTR_DESC_RDMA_READ_MASK   BIT(0)
 
 #endif /* _EFA_ADMIN_CMDS_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_admin_defs.h b/drivers/infiniband/hw/efa/efa_admin_defs.h
index c8e0c8b905be..199d8eb3cbda 100644
--- a/drivers/infiniband/hw/efa/efa_admin_defs.h
+++ b/drivers/infiniband/hw/efa/efa_admin_defs.h
@@ -119,7 +119,9 @@ struct efa_admin_aenq_entry {
 };
 
 /* aq_common_desc */
+#define EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_SHIFT           0
 #define EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK            GENMASK(11, 0)
+#define EFA_ADMIN_AQ_COMMON_DESC_PHASE_SHIFT                0
 #define EFA_ADMIN_AQ_COMMON_DESC_PHASE_MASK                 BIT(0)
 #define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_SHIFT            1
 #define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_MASK             BIT(1)
@@ -127,10 +129,13 @@ struct efa_admin_aenq_entry {
 #define EFA_ADMIN_AQ_COMMON_DESC_CTRL_DATA_INDIRECT_MASK    BIT(2)
 
 /* acq_common_desc */
+#define EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_SHIFT          0
 #define EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK           GENMASK(11, 0)
+#define EFA_ADMIN_ACQ_COMMON_DESC_PHASE_SHIFT               0
 #define EFA_ADMIN_ACQ_COMMON_DESC_PHASE_MASK                BIT(0)
 
 /* aenq_common_desc */
+#define EFA_ADMIN_AENQ_COMMON_DESC_PHASE_SHIFT              0
 #define EFA_ADMIN_AENQ_COMMON_DESC_PHASE_MASK               BIT(0)
 
 #endif /* _EFA_ADMIN_H_ */
diff --git a/drivers/infiniband/hw/efa/efa_com.c b/drivers/infiniband/hw/efa/efa_com.c
index 0778f4f7dccd..5dd5e429c15c 100644
--- a/drivers/infiniband/hw/efa/efa_com.c
+++ b/drivers/infiniband/hw/efa/efa_com.c
@@ -84,7 +84,7 @@ static u32 efa_com_reg_read32(struct efa_com_dev *edev, u16 offset)
 	struct efa_com_mmio_read *mmio_read = &edev->mmio_read;
 	struct efa_admin_mmio_req_read_less_resp *read_resp;
 	unsigned long exp_time;
-	u32 mmio_read_reg;
+	u32 mmio_read_reg = 0;
 	u32 err;
 
 	read_resp = mmio_read->read_resp;
@@ -94,10 +94,9 @@ static u32 efa_com_reg_read32(struct efa_com_dev *edev, u16 offset)
 
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
 
@@ -137,9 +136,9 @@ static int efa_com_admin_init_sq(struct efa_com_dev *edev)
 	struct efa_com_admin_queue *aq = &edev->aq;
 	struct efa_com_admin_sq *sq = &aq->sq;
 	u16 size = aq->depth * sizeof(*sq->entries);
+	u32 aq_caps = 0;
 	u32 addr_high;
 	u32 addr_low;
-	u32 aq_caps;
 
 	sq->entries =
 		dma_alloc_coherent(aq->dmadev, size, &sq->dma_addr, GFP_KERNEL);
@@ -160,10 +159,9 @@ static int efa_com_admin_init_sq(struct efa_com_dev *edev)
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
 
@@ -175,9 +173,9 @@ static int efa_com_admin_init_cq(struct efa_com_dev *edev)
 	struct efa_com_admin_queue *aq = &edev->aq;
 	struct efa_com_admin_cq *cq = &aq->cq;
 	u16 size = aq->depth * sizeof(*cq->entries);
+	u32 acq_caps = 0;
 	u32 addr_high;
 	u32 addr_low;
-	u32 acq_caps;
 
 	cq->entries =
 		dma_alloc_coherent(aq->dmadev, size, &cq->dma_addr, GFP_KERNEL);
@@ -195,13 +193,11 @@ static int efa_com_admin_init_cq(struct efa_com_dev *edev)
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
 
@@ -212,7 +208,8 @@ static int efa_com_admin_init_aenq(struct efa_com_dev *edev,
 				   struct efa_aenq_handlers *aenq_handlers)
 {
 	struct efa_com_aenq *aenq = &edev->aenq;
-	u32 addr_low, addr_high, aenq_caps;
+	u32 addr_low, addr_high;
+	u32 aenq_caps = 0;
 	u16 size;
 
 	if (!aenq_handlers) {
@@ -237,13 +234,11 @@ static int efa_com_admin_init_aenq(struct efa_com_dev *edev,
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
@@ -280,8 +275,8 @@ static void efa_com_dealloc_ctx_id(struct efa_com_admin_queue *aq,
 static inline void efa_com_put_comp_ctx(struct efa_com_admin_queue *aq,
 					struct efa_comp_ctx *comp_ctx)
 {
-	u16 cmd_id = comp_ctx->user_cqe->acq_common_descriptor.command &
-		     EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK;
+	u16 cmd_id = EFA_GET(&comp_ctx->user_cqe->acq_common_descriptor.command,
+			     EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 	u16 ctx_id = cmd_id & (aq->depth - 1);
 
 	ibdev_dbg(aq->efa_dev, "Put completion command_id %#x\n", cmd_id);
@@ -335,8 +330,8 @@ static struct efa_comp_ctx *__efa_com_submit_admin_cmd(struct efa_com_admin_queu
 	cmd_id &= EFA_ADMIN_AQ_COMMON_DESC_COMMAND_ID_MASK;
 
 	cmd->aq_common_descriptor.command_id = cmd_id;
-	cmd->aq_common_descriptor.flags |= aq->sq.phase &
-		EFA_ADMIN_AQ_COMMON_DESC_PHASE_MASK;
+	EFA_SET(&cmd->aq_common_descriptor.flags,
+		EFA_ADMIN_AQ_COMMON_DESC_PHASE, aq->sq.phase);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, true);
 	if (!comp_ctx) {
@@ -427,8 +422,8 @@ static void efa_com_handle_single_admin_completion(struct efa_com_admin_queue *a
 	struct efa_comp_ctx *comp_ctx;
 	u16 cmd_id;
 
-	cmd_id = cqe->acq_common_descriptor.command &
-		 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID_MASK;
+	cmd_id = EFA_GET(&cqe->acq_common_descriptor.command,
+			 EFA_ADMIN_ACQ_COMMON_DESC_COMMAND_ID);
 
 	comp_ctx = efa_com_get_comp_ctx(aq, cmd_id, false);
 	if (!comp_ctx) {
@@ -743,7 +738,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 	int err;
 
 	dev_sts = efa_com_reg_read32(edev, EFA_REGS_DEV_STS_OFF);
-	if (!(dev_sts & EFA_REGS_DEV_STS_READY_MASK)) {
+	if (!EFA_GET(&dev_sts, EFA_REGS_DEV_STS_READY)) {
 		ibdev_err(edev->efa_dev,
 			  "Device isn't ready, abort com init %#x\n", dev_sts);
 		return -ENODEV;
@@ -778,8 +773,7 @@ int efa_com_admin_init(struct efa_com_dev *edev,
 		goto err_destroy_cq;
 
 	cap = efa_com_reg_read32(edev, EFA_REGS_CAPS_OFF);
-	timeout = (cap & EFA_REGS_CAPS_ADMIN_CMD_TO_MASK) >>
-		  EFA_REGS_CAPS_ADMIN_CMD_TO_SHIFT;
+	timeout = EFA_GET(&cap, EFA_REGS_CAPS_ADMIN_CMD_TO);
 	if (timeout)
 		/* the resolution of timeout reg is 100ms */
 		aq->completion_timeout = timeout * 100000;
@@ -953,9 +947,8 @@ int efa_com_validate_version(struct efa_com_dev *edev)
 				      EFA_REGS_CONTROLLER_VERSION_OFF);
 
 	ibdev_dbg(edev->efa_dev, "efa device version: %d.%d\n",
-		  (ver & EFA_REGS_VERSION_MAJOR_VERSION_MASK) >>
-			  EFA_REGS_VERSION_MAJOR_VERSION_SHIFT,
-		  ver & EFA_REGS_VERSION_MINOR_VERSION_MASK);
+		  EFA_GET(&ver, EFA_REGS_VERSION_MAJOR_VERSION),
+		  EFA_GET(&ver, EFA_REGS_VERSION_MINOR_VERSION));
 
 	if (ver < MIN_EFA_VER) {
 		ibdev_err(edev->efa_dev,
@@ -965,18 +958,16 @@ int efa_com_validate_version(struct efa_com_dev *edev)
 
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
 
 	/* Validate the ctrl version without the implementation ID */
 	if (ctrl_ver_masked < MIN_EFA_CTRL_VER) {
@@ -1002,8 +993,7 @@ int efa_com_get_dma_width(struct efa_com_dev *edev)
 	u32 caps = efa_com_reg_read32(edev, EFA_REGS_CAPS_OFF);
 	int width;
 
-	width = (caps & EFA_REGS_CAPS_DMA_ADDR_WIDTH_MASK) >>
-		EFA_REGS_CAPS_DMA_ADDR_WIDTH_SHIFT;
+	width = EFA_GET(&caps, EFA_REGS_CAPS_DMA_ADDR_WIDTH);
 
 	ibdev_dbg(edev->efa_dev, "DMA width: %d\n", width);
 
@@ -1017,16 +1007,14 @@ int efa_com_get_dma_width(struct efa_com_dev *edev)
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
@@ -1046,36 +1034,34 @@ static int wait_for_reset_state(struct efa_com_dev *edev, u32 timeout,
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
@@ -1089,8 +1075,7 @@ int efa_com_dev_reset(struct efa_com_dev *edev,
 		return err;
 	}
 
-	timeout = (cap & EFA_REGS_CAPS_ADMIN_CMD_TO_MASK) >>
-		  EFA_REGS_CAPS_ADMIN_CMD_TO_SHIFT;
+	timeout = EFA_GET(&cap, EFA_REGS_CAPS_ADMIN_CMD_TO);
 	if (timeout)
 		/* the resolution of timeout reg is 100ms */
 		edev->aq.completion_timeout = timeout * 100000;
diff --git a/drivers/infiniband/hw/efa/efa_com_cmd.c b/drivers/infiniband/hw/efa/efa_com_cmd.c
index e20bd84a1014..80670517d950 100644
--- a/drivers/infiniband/hw/efa/efa_com_cmd.c
+++ b/drivers/infiniband/hw/efa/efa_com_cmd.c
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
index c559ec08898e..845ea5ca9388 100644
--- a/drivers/infiniband/hw/efa/efa_common_defs.h
+++ b/drivers/infiniband/hw/efa/efa_common_defs.h
@@ -9,6 +9,12 @@
 #define EFA_COMMON_SPEC_VERSION_MAJOR        2
 #define EFA_COMMON_SPEC_VERSION_MINOR        0
 
+#define EFA_GET(ptr, type) \
+	((*(ptr) & type##_MASK) >> type##_SHIFT)
+
+#define EFA_SET(ptr, type, value) \
+	({ *(ptr) |= ((value) << type##_SHIFT) & type##_MASK; })
+
 struct efa_common_mem_addr {
 	u32 mem_addr_low;
 
diff --git a/drivers/infiniband/hw/efa/efa_regs_defs.h b/drivers/infiniband/hw/efa/efa_regs_defs.h
index bb9cad3d6a15..b3119ed8d9b2 100644
--- a/drivers/infiniband/hw/efa/efa_regs_defs.h
+++ b/drivers/infiniband/hw/efa/efa_regs_defs.h
@@ -44,11 +44,13 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_MMIO_RESP_HI_OFF                           0x64
 
 /* version register */
+#define EFA_REGS_VERSION_MINOR_VERSION_SHIFT                0
 #define EFA_REGS_VERSION_MINOR_VERSION_MASK                 0xff
 #define EFA_REGS_VERSION_MAJOR_VERSION_SHIFT                8
 #define EFA_REGS_VERSION_MAJOR_VERSION_MASK                 0xff00
 
 /* controller_version register */
+#define EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION_SHIFT  0
 #define EFA_REGS_CONTROLLER_VERSION_SUBMINOR_VERSION_MASK   0xff
 #define EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_SHIFT     8
 #define EFA_REGS_CONTROLLER_VERSION_MINOR_VERSION_MASK      0xff00
@@ -58,6 +60,7 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_CONTROLLER_VERSION_IMPL_ID_MASK            0xff000000
 
 /* caps register */
+#define EFA_REGS_CAPS_CONTIGUOUS_QUEUE_REQUIRED_SHIFT       0
 #define EFA_REGS_CAPS_CONTIGUOUS_QUEUE_REQUIRED_MASK        0x1
 #define EFA_REGS_CAPS_RESET_TIMEOUT_SHIFT                   1
 #define EFA_REGS_CAPS_RESET_TIMEOUT_MASK                    0x3e
@@ -67,11 +70,13 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_CAPS_ADMIN_CMD_TO_MASK                     0xf0000
 
 /* aq_caps register */
+#define EFA_REGS_AQ_CAPS_AQ_DEPTH_SHIFT                     0
 #define EFA_REGS_AQ_CAPS_AQ_DEPTH_MASK                      0xffff
 #define EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_SHIFT                16
 #define EFA_REGS_AQ_CAPS_AQ_ENTRY_SIZE_MASK                 0xffff0000
 
 /* acq_caps register */
+#define EFA_REGS_ACQ_CAPS_ACQ_DEPTH_SHIFT                   0
 #define EFA_REGS_ACQ_CAPS_ACQ_DEPTH_MASK                    0xffff
 #define EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_SHIFT              16
 #define EFA_REGS_ACQ_CAPS_ACQ_ENTRY_SIZE_MASK               0xff0000
@@ -79,6 +84,7 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_ACQ_CAPS_ACQ_MSIX_VECTOR_MASK              0xff000000
 
 /* aenq_caps register */
+#define EFA_REGS_AENQ_CAPS_AENQ_DEPTH_SHIFT                 0
 #define EFA_REGS_AENQ_CAPS_AENQ_DEPTH_MASK                  0xffff
 #define EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_SHIFT            16
 #define EFA_REGS_AENQ_CAPS_AENQ_ENTRY_SIZE_MASK             0xff0000
@@ -86,6 +92,7 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_AENQ_CAPS_AENQ_MSIX_VECTOR_MASK            0xff000000
 
 /* dev_ctl register */
+#define EFA_REGS_DEV_CTL_DEV_RESET_SHIFT                    0
 #define EFA_REGS_DEV_CTL_DEV_RESET_MASK                     0x1
 #define EFA_REGS_DEV_CTL_AQ_RESTART_SHIFT                   1
 #define EFA_REGS_DEV_CTL_AQ_RESTART_MASK                    0x2
@@ -93,6 +100,7 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_DEV_CTL_RESET_REASON_MASK                  0xf0000000
 
 /* dev_sts register */
+#define EFA_REGS_DEV_STS_READY_SHIFT                        0
 #define EFA_REGS_DEV_STS_READY_MASK                         0x1
 #define EFA_REGS_DEV_STS_AQ_RESTART_IN_PROGRESS_SHIFT       1
 #define EFA_REGS_DEV_STS_AQ_RESTART_IN_PROGRESS_MASK        0x2
@@ -106,6 +114,7 @@ enum efa_regs_reset_reason_types {
 #define EFA_REGS_DEV_STS_FATAL_ERROR_MASK                   0x20
 
 /* mmio_reg_read register */
+#define EFA_REGS_MMIO_REG_READ_REQ_ID_SHIFT                 0
 #define EFA_REGS_MMIO_REG_READ_REQ_ID_MASK                  0xffff
 #define EFA_REGS_MMIO_REG_READ_REG_OFF_SHIFT                16
 #define EFA_REGS_MMIO_REG_READ_REG_OFF_MASK                 0xffff0000
-- 
2.24.1

