Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6097236F9
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 07:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234319AbjFFFug (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 01:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbjFFFuX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 01:50:23 -0400
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE19E42
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 22:50:15 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkV2uT4_1686030611;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VkV2uT4_1686030611)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 13:50:12 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 4/4] RDMA/erdma: Refactor the original doorbell allocation mechanism
Date:   Tue,  6 Jun 2023 13:50:05 +0800
Message-Id: <20230606055005.80729-5-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230606055005.80729-1-chengyou@linux.alibaba.com>
References: <20230606055005.80729-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The original doorbell allocation mechanism is complex and does not meet
the isolation requirement. So we introduce a new doorbell mechanism and the
original mechanism (only be used with CAP_SYS_RAWIO if hardware does not
support the new mechanism) needs to be kept as simple as possible for
compatibility.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       |  14 ---
 drivers/infiniband/hw/erdma/erdma_hw.h    |  13 ---
 drivers/infiniband/hw/erdma/erdma_main.c  |  33 ------
 drivers/infiniband/hw/erdma/erdma_verbs.c | 126 +++++-----------------
 drivers/infiniband/hw/erdma/erdma_verbs.h |   4 -
 5 files changed, 27 insertions(+), 163 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index a361d4bcd714..f190111840e9 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -128,13 +128,8 @@ struct erdma_devattr {
 
 	int numa_node;
 	enum erdma_cc_alg cc;
-	u32 grp_num;
 	u32 irq_num;
 
-	bool disable_dwqe;
-	u16 dwqe_pages;
-	u16 dwqe_entries;
-
 	u32 max_qp;
 	u32 max_send_wr;
 	u32 max_recv_wr;
@@ -215,15 +210,6 @@ struct erdma_dev {
 	u32 next_alloc_qpn;
 	u32 next_alloc_cqn;
 
-	spinlock_t db_bitmap_lock;
-	/* We provide max 64 uContexts that each has one SQ doorbell Page. */
-	DECLARE_BITMAP(sdb_page, ERDMA_DWQE_TYPE0_CNT);
-	/*
-	 * We provide max 496 uContexts that each has one SQ normal Db,
-	 * and one directWQE db.
-	 */
-	DECLARE_BITMAP(sdb_entry, ERDMA_DWQE_TYPE1_CNT);
-
 	atomic_t num_ctx;
 	struct list_head cep_list;
 };
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index cf7629bfe534..a882b57aa118 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -82,19 +82,6 @@
 #define ERDMA_BAR_CQDB_SPACE_OFFSET \
 	(ERDMA_BAR_RQDB_SPACE_OFFSET + ERDMA_BAR_RQDB_SPACE_SIZE)
 
-/* Doorbell page resources related. */
-/*
- * Max # of parallelly issued directSQE is 3072 per device,
- * hardware organizes this into 24 group, per group has 128 credits.
- */
-#define ERDMA_DWQE_MAX_GRP_CNT 24
-#define ERDMA_DWQE_NUM_PER_GRP 128
-
-#define ERDMA_DWQE_TYPE0_CNT 64
-#define ERDMA_DWQE_TYPE1_CNT 496
-/* type1 DB contains 2 DBs, takes 256Byte. */
-#define ERDMA_DWQE_TYPE1_CNT_PER_PAGE 16
-
 #define ERDMA_SDB_SHARED_PAGE_INDEX 95
 
 /* Doorbell related. */
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 525edea987b2..0880c79a978c 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -130,33 +130,6 @@ static irqreturn_t erdma_comm_irq_handler(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
-static void erdma_dwqe_resource_init(struct erdma_dev *dev)
-{
-	int total_pages, type0, type1;
-
-	dev->attrs.grp_num = erdma_reg_read32(dev, ERDMA_REGS_GRP_NUM_REG);
-
-	if (dev->attrs.grp_num < 4)
-		dev->attrs.disable_dwqe = true;
-	else
-		dev->attrs.disable_dwqe = false;
-
-	/* One page contains 4 goups. */
-	total_pages = dev->attrs.grp_num * 4;
-
-	if (dev->attrs.grp_num >= ERDMA_DWQE_MAX_GRP_CNT) {
-		dev->attrs.grp_num = ERDMA_DWQE_MAX_GRP_CNT;
-		type0 = ERDMA_DWQE_TYPE0_CNT;
-		type1 = ERDMA_DWQE_TYPE1_CNT / ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
-	} else {
-		type1 = total_pages / 3;
-		type0 = total_pages - type1 - 1;
-	}
-
-	dev->attrs.dwqe_pages = type0;
-	dev->attrs.dwqe_entries = type1 * ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
-}
-
 static int erdma_request_vectors(struct erdma_dev *dev)
 {
 	int expect_irq_num = min(num_possible_cpus() + 1, ERDMA_NUM_MSIX_VEC);
@@ -199,8 +172,6 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
 {
 	int ret;
 
-	erdma_dwqe_resource_init(dev);
-
 	ret = dma_set_mask_and_coherent(&pdev->dev,
 					DMA_BIT_MASK(ERDMA_PCI_WIDTH));
 	if (ret)
@@ -557,10 +528,6 @@ static int erdma_ib_device_add(struct pci_dev *pdev)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&dev->db_bitmap_lock);
-	bitmap_zero(dev->sdb_page, ERDMA_DWQE_TYPE0_CNT);
-	bitmap_zero(dev->sdb_entry, ERDMA_DWQE_TYPE1_CNT);
-
 	atomic_set(&dev->num_ctx, 0);
 
 	mac = erdma_reg_read32(dev, ERDMA_REGS_NETDEV_MAC_L_REG);
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index ffc05ddc98ae..517676fbb8b1 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1149,71 +1149,27 @@ void erdma_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 	kfree(entry);
 }
 
-#define ERDMA_SDB_PAGE 0
-#define ERDMA_SDB_ENTRY 1
-#define ERDMA_SDB_SHARED 2
-
-static void alloc_db_resources(struct erdma_dev *dev,
-			       struct erdma_ucontext *ctx)
-{
-	u32 bitmap_idx;
-	struct erdma_devattr *attrs = &dev->attrs;
-
-	if (attrs->disable_dwqe)
-		goto alloc_normal_db;
-
-	/* Try to alloc independent SDB page. */
-	spin_lock(&dev->db_bitmap_lock);
-	bitmap_idx = find_first_zero_bit(dev->sdb_page, attrs->dwqe_pages);
-	if (bitmap_idx != attrs->dwqe_pages) {
-		set_bit(bitmap_idx, dev->sdb_page);
-		spin_unlock(&dev->db_bitmap_lock);
-
-		ctx->sdb_type = ERDMA_SDB_PAGE;
-		ctx->sdb_idx = bitmap_idx;
-		ctx->sdb_page_idx = bitmap_idx;
-		ctx->sdb = dev->func_bar_addr + ERDMA_BAR_SQDB_SPACE_OFFSET +
-			   (bitmap_idx << PAGE_SHIFT);
-		ctx->sdb_page_off = 0;
-
-		return;
-	}
-
-	bitmap_idx = find_first_zero_bit(dev->sdb_entry, attrs->dwqe_entries);
-	if (bitmap_idx != attrs->dwqe_entries) {
-		set_bit(bitmap_idx, dev->sdb_entry);
-		spin_unlock(&dev->db_bitmap_lock);
-
-		ctx->sdb_type = ERDMA_SDB_ENTRY;
-		ctx->sdb_idx = bitmap_idx;
-		ctx->sdb_page_idx = attrs->dwqe_pages +
-				    bitmap_idx / ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
-		ctx->sdb_page_off = bitmap_idx % ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
-
-		ctx->sdb = dev->func_bar_addr + ERDMA_BAR_SQDB_SPACE_OFFSET +
-			   (ctx->sdb_page_idx << PAGE_SHIFT);
-
-		return;
-	}
-
-	spin_unlock(&dev->db_bitmap_lock);
-
-alloc_normal_db:
-	ctx->sdb_type = ERDMA_SDB_SHARED;
-	ctx->sdb_idx = 0;
-	ctx->sdb_page_idx = ERDMA_SDB_SHARED_PAGE_INDEX;
-	ctx->sdb_page_off = 0;
-
-	ctx->sdb = dev->func_bar_addr + (ctx->sdb_page_idx << PAGE_SHIFT);
-}
-
-static int alloc_ext_db_resources(struct erdma_dev *dev,
-				  struct erdma_ucontext *ctx)
+static int alloc_db_resources(struct erdma_dev *dev, struct erdma_ucontext *ctx,
+			      bool ext_db_en)
 {
 	struct erdma_cmdq_ext_db_req req = {};
 	u64 val0, val1;
 	int ret;
 
+	/*
+	 * CAP_SYS_RAWIO is required if hardware does not support extend
+	 * doorbell mechanism.
+	 */
+	if (!ext_db_en && !capable(CAP_SYS_RAWIO))
+		return -EPERM;
+
+	if (!ext_db_en) {
+		ctx->sdb = dev->func_bar_addr + ERDMA_BAR_SQDB_SPACE_OFFSET;
+		ctx->rdb = dev->func_bar_addr + ERDMA_BAR_RQDB_SPACE_OFFSET;
+		ctx->cdb = dev->func_bar_addr + ERDMA_BAR_CQDB_SPACE_OFFSET;
+		return 0;
+	}
+
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
 				CMDQ_OPCODE_ALLOC_DB);
 
@@ -1230,7 +1186,6 @@ static int alloc_ext_db_resources(struct erdma_dev *dev,
 	ctx->ext_db.rdb_off = ERDMA_GET(val0, ALLOC_DB_RESP_RDB);
 	ctx->ext_db.cdb_off = ERDMA_GET(val0, ALLOC_DB_RESP_CDB);
 
-	ctx->sdb_type = ERDMA_SDB_PAGE;
 	ctx->sdb = dev->func_bar_addr + (ctx->ext_db.sdb_off << PAGE_SHIFT);
 	ctx->cdb = dev->func_bar_addr + (ctx->ext_db.rdb_off << PAGE_SHIFT);
 	ctx->rdb = dev->func_bar_addr + (ctx->ext_db.cdb_off << PAGE_SHIFT);
@@ -1238,12 +1193,14 @@ static int alloc_ext_db_resources(struct erdma_dev *dev,
 	return 0;
 }
 
-static void free_ext_db_resources(struct erdma_dev *dev,
-				  struct erdma_ucontext *ctx)
+static void free_db_resources(struct erdma_dev *dev, struct erdma_ucontext *ctx)
 {
 	struct erdma_cmdq_ext_db_req req = {};
 	int ret;
 
+	if (!ctx->ext_db.enable)
+		return;
+
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
 				CMDQ_OPCODE_FREE_DB);
 
@@ -1274,7 +1231,6 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	struct erdma_dev *dev = to_edev(ibctx->device);
 	int ret;
 	struct erdma_uresp_alloc_ctx uresp = {};
-	bool ext_db_en;
 
 	if (atomic_inc_return(&dev->num_ctx) > ERDMA_MAX_CONTEXT) {
 		ret = -ENOMEM;
@@ -1289,25 +1245,11 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	INIT_LIST_HEAD(&ctx->dbrecords_page_list);
 	mutex_init(&ctx->dbrecords_page_mutex);
 
-	/*
-	 * CAP_SYS_RAWIO is required if hardware does not support extend
-	 * doorbell mechanism.
-	 */
-	ext_db_en = !!(dev->attrs.cap_flags & ERDMA_DEV_CAP_FLAGS_EXTEND_DB);
-	if (!ext_db_en && !capable(CAP_SYS_RAWIO)) {
-		ret = -EPERM;
+	ret = alloc_db_resources(dev, ctx,
+				 !!(dev->attrs.cap_flags &
+				    ERDMA_DEV_CAP_FLAGS_EXTEND_DB));
+	if (ret)
 		goto err_out;
-	}
-
-	if (ext_db_en) {
-		ret = alloc_ext_db_resources(dev, ctx);
-		if (ret)
-			goto err_out;
-	} else {
-		alloc_db_resources(dev, ctx);
-		ctx->rdb = dev->func_bar_addr + ERDMA_BAR_RQDB_SPACE_OFFSET;
-		ctx->cdb = dev->func_bar_addr + ERDMA_BAR_CQDB_SPACE_OFFSET;
-	}
 
 	ctx->sq_db_mmap_entry = erdma_user_mmap_entry_insert(
 		ctx, (void *)ctx->sdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.sdb);
@@ -1331,8 +1273,6 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	}
 
 	uresp.dev_id = dev->pdev->device;
-	uresp.sdb_type = ctx->sdb_type;
-	uresp.sdb_offset = ctx->sdb_page_off;
 
 	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (ret)
@@ -1344,8 +1284,7 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	erdma_uctx_user_mmap_entries_remove(ctx);
 
 err_free_ext_db:
-	if (ext_db_en)
-		free_ext_db_resources(dev, ctx);
+	free_db_resources(dev, ctx);
 
 err_out:
 	atomic_dec(&dev->num_ctx);
@@ -1354,22 +1293,11 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 void erdma_dealloc_ucontext(struct ib_ucontext *ibctx)
 {
-	struct erdma_ucontext *ctx = to_ectx(ibctx);
 	struct erdma_dev *dev = to_edev(ibctx->device);
+	struct erdma_ucontext *ctx = to_ectx(ibctx);
 
 	erdma_uctx_user_mmap_entries_remove(ctx);
-
-	if (ctx->ext_db.enable) {
-		free_ext_db_resources(dev, ctx);
-	} else {
-		spin_lock(&dev->db_bitmap_lock);
-		if (ctx->sdb_type == ERDMA_SDB_PAGE)
-			clear_bit(ctx->sdb_idx, dev->sdb_page);
-		else if (ctx->sdb_type == ERDMA_SDB_ENTRY)
-			clear_bit(ctx->sdb_idx, dev->sdb_entry);
-		spin_unlock(&dev->db_bitmap_lock);
-	}
-
+	free_db_resources(dev, ctx);
 	atomic_dec(&dev->num_ctx);
 }
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 252106679d36..429fc3063f98 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -43,10 +43,6 @@ struct erdma_ucontext {
 
 	struct erdma_ext_db_info ext_db;
 
-	u32 sdb_type;
-	u32 sdb_idx;
-	u32 sdb_page_idx;
-	u32 sdb_page_off;
 	u64 sdb;
 	u64 rdb;
 	u64 cdb;
-- 
2.31.1

