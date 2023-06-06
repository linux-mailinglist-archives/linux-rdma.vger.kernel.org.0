Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29607236F8
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 07:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233695AbjFFFud (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 01:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234238AbjFFFuV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 01:50:21 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7A0E71
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 22:50:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R831e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkV2uQy_1686030609;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VkV2uQy_1686030609)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 13:50:10 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 2/4] RDMA/erdma: Allocate doorbell resources from hardware
Date:   Tue,  6 Jun 2023 13:50:03 +0800
Message-Id: <20230606055005.80729-3-chengyou@linux.alibaba.com>
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

Each ucontext will try to allocate doorbell resources in the extended bar
space from hardware. For compatibility, we change nothing for the original
bar space, and it will be used only for applications with CAP_SYS_RAWIO
authority in the older HW/FW environments.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       |   2 +
 drivers/infiniband/hw/erdma/erdma_hw.h    |  22 ++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 117 ++++++++++++++++++----
 drivers/infiniband/hw/erdma/erdma_verbs.h |   9 ++
 4 files changed, 131 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index e819e4032490..a361d4bcd714 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -268,6 +268,8 @@ static inline u32 erdma_reg_read32_filed(struct erdma_dev *dev, u32 reg,
 	return FIELD_GET(filed_mask, val);
 }
 
+#define ERDMA_GET(val, name) FIELD_GET(ERDMA_CMD_##name##_MASK, val)
+
 int erdma_cmdq_init(struct erdma_dev *dev);
 void erdma_finish_cmdq_init(struct erdma_dev *dev);
 void erdma_cmdq_destroy(struct erdma_dev *dev);
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 670796c22bcc..812fc40de64b 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -160,6 +160,8 @@ enum CMDQ_COMMON_OPCODE {
 	CMDQ_OPCODE_QUERY_FW_INFO = 2,
 	CMDQ_OPCODE_CONF_MTU = 3,
 	CMDQ_OPCODE_CONF_DEVICE = 5,
+	CMDQ_OPCODE_ALLOC_DB = 8,
+	CMDQ_OPCODE_FREE_DB = 9,
 };
 
 /* cmdq-SQE HDR */
@@ -212,6 +214,26 @@ struct erdma_cmdq_config_mtu_req {
 	u32 mtu;
 };
 
+/* ext db requests(alloc and free) cfg */
+#define ERDMA_CMD_EXT_DB_CQ_EN_MASK BIT(2)
+#define ERDMA_CMD_EXT_DB_RQ_EN_MASK BIT(1)
+#define ERDMA_CMD_EXT_DB_SQ_EN_MASK BIT(0)
+
+struct erdma_cmdq_ext_db_req {
+	u64 hdr;
+	u32 cfg;
+	u16 rdb_off;
+	u16 sdb_off;
+	u16 rsvd0;
+	u16 cdb_off;
+	u32 rsvd1[3];
+};
+
+/* alloc db response qword 0 definition */
+#define ERDMA_CMD_ALLOC_DB_RESP_RDB_MASK GENMASK_ULL(63, 48)
+#define ERDMA_CMD_ALLOC_DB_RESP_CDB_MASK GENMASK_ULL(47, 32)
+#define ERDMA_CMD_ALLOC_DB_RESP_SDB_MASK GENMASK_ULL(15, 0)
+
 /* create_cq cfg0 */
 #define ERDMA_CMD_CREATE_CQ_DEPTH_MASK GENMASK(31, 24)
 #define ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK GENMASK(23, 20)
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 83e1b0d55977..376f70219ecd 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1188,6 +1188,60 @@ static void alloc_db_resources(struct erdma_dev *dev,
 	ctx->sdb = dev->func_bar_addr + (ctx->sdb_page_idx << PAGE_SHIFT);
 }
 
+static int alloc_ext_db_resources(struct erdma_dev *dev,
+				  struct erdma_ucontext *ctx)
+{
+	struct erdma_cmdq_ext_db_req req = {};
+	u64 val0, val1;
+	int ret;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
+				CMDQ_OPCODE_ALLOC_DB);
+
+	req.cfg = FIELD_PREP(ERDMA_CMD_EXT_DB_CQ_EN_MASK, 1) |
+		  FIELD_PREP(ERDMA_CMD_EXT_DB_RQ_EN_MASK, 1) |
+		  FIELD_PREP(ERDMA_CMD_EXT_DB_SQ_EN_MASK, 1);
+
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &val0, &val1);
+	if (ret)
+		return ret;
+
+	ctx->ext_db.enable = true;
+	ctx->ext_db.sdb_off = ERDMA_GET(val0, ALLOC_DB_RESP_SDB);
+	ctx->ext_db.rdb_off = ERDMA_GET(val0, ALLOC_DB_RESP_RDB);
+	ctx->ext_db.cdb_off = ERDMA_GET(val0, ALLOC_DB_RESP_CDB);
+
+	ctx->sdb_type = ERDMA_SDB_PAGE;
+	ctx->sdb = dev->func_bar_addr + (ctx->ext_db.sdb_off << PAGE_SHIFT);
+	ctx->cdb = dev->func_bar_addr + (ctx->ext_db.rdb_off << PAGE_SHIFT);
+	ctx->rdb = dev->func_bar_addr + (ctx->ext_db.cdb_off << PAGE_SHIFT);
+
+	return 0;
+}
+
+static void free_ext_db_resources(struct erdma_dev *dev,
+				  struct erdma_ucontext *ctx)
+{
+	struct erdma_cmdq_ext_db_req req = {};
+	int ret;
+
+	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_COMMON,
+				CMDQ_OPCODE_FREE_DB);
+
+	req.cfg = FIELD_PREP(ERDMA_CMD_EXT_DB_CQ_EN_MASK, 1) |
+		  FIELD_PREP(ERDMA_CMD_EXT_DB_RQ_EN_MASK, 1) |
+		  FIELD_PREP(ERDMA_CMD_EXT_DB_SQ_EN_MASK, 1);
+
+	req.sdb_off = ctx->ext_db.sdb_off;
+	req.rdb_off = ctx->ext_db.rdb_off;
+	req.cdb_off = ctx->ext_db.cdb_off;
+
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
+	if (ret)
+		ibdev_err_ratelimited(&dev->ibdev,
+				      "free db resources failed %d", ret);
+}
+
 static void erdma_uctx_user_mmap_entries_remove(struct erdma_ucontext *uctx)
 {
 	rdma_user_mmap_entry_remove(uctx->sq_db_mmap_entry);
@@ -1201,44 +1255,60 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	struct erdma_dev *dev = to_edev(ibctx->device);
 	int ret;
 	struct erdma_uresp_alloc_ctx uresp = {};
+	bool ext_db_en;
 
 	if (atomic_inc_return(&dev->num_ctx) > ERDMA_MAX_CONTEXT) {
 		ret = -ENOMEM;
 		goto err_out;
 	}
 
+	if (udata->outlen < sizeof(uresp)) {
+		ret = -EINVAL;
+		goto err_out;
+	}
+
 	INIT_LIST_HEAD(&ctx->dbrecords_page_list);
 	mutex_init(&ctx->dbrecords_page_mutex);
 
-	alloc_db_resources(dev, ctx);
-
-	ctx->rdb = dev->func_bar_addr + ERDMA_BAR_RQDB_SPACE_OFFSET;
-	ctx->cdb = dev->func_bar_addr + ERDMA_BAR_CQDB_SPACE_OFFSET;
-
-	if (udata->outlen < sizeof(uresp)) {
-		ret = -EINVAL;
+	/*
+	 * CAP_SYS_RAWIO is required if hardware does not support extend
+	 * doorbell mechanism.
+	 */
+	ext_db_en = !!(dev->attrs.cap_flags & ERDMA_DEV_CAP_FLAGS_EXTEND_DB);
+	if (!ext_db_en && !capable(CAP_SYS_RAWIO)) {
+		ret = -EPERM;
 		goto err_out;
 	}
 
+	if (ext_db_en) {
+		ret = alloc_ext_db_resources(dev, ctx);
+		if (ret)
+			goto err_out;
+	} else {
+		alloc_db_resources(dev, ctx);
+		ctx->rdb = dev->func_bar_addr + ERDMA_BAR_RQDB_SPACE_OFFSET;
+		ctx->cdb = dev->func_bar_addr + ERDMA_BAR_CQDB_SPACE_OFFSET;
+	}
+
 	ctx->sq_db_mmap_entry = erdma_user_mmap_entry_insert(
 		ctx, (void *)ctx->sdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.sdb);
 	if (!ctx->sq_db_mmap_entry) {
 		ret = -ENOMEM;
-		goto err_out;
+		goto err_free_ext_db;
 	}
 
 	ctx->rq_db_mmap_entry = erdma_user_mmap_entry_insert(
 		ctx, (void *)ctx->rdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.rdb);
 	if (!ctx->rq_db_mmap_entry) {
 		ret = -EINVAL;
-		goto err_out;
+		goto err_put_mmap_entries;
 	}
 
 	ctx->cq_db_mmap_entry = erdma_user_mmap_entry_insert(
 		ctx, (void *)ctx->cdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.cdb);
 	if (!ctx->cq_db_mmap_entry) {
 		ret = -EINVAL;
-		goto err_out;
+		goto err_put_mmap_entries;
 	}
 
 	uresp.dev_id = dev->pdev->device;
@@ -1247,12 +1317,18 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
 	if (ret)
-		goto err_out;
+		goto err_put_mmap_entries;
 
 	return 0;
 
-err_out:
+err_put_mmap_entries:
 	erdma_uctx_user_mmap_entries_remove(ctx);
+
+err_free_ext_db:
+	if (ext_db_en)
+		free_ext_db_resources(dev, ctx);
+
+err_out:
 	atomic_dec(&dev->num_ctx);
 	return ret;
 }
@@ -1262,15 +1338,18 @@ void erdma_dealloc_ucontext(struct ib_ucontext *ibctx)
 	struct erdma_ucontext *ctx = to_ectx(ibctx);
 	struct erdma_dev *dev = to_edev(ibctx->device);
 
-	spin_lock(&dev->db_bitmap_lock);
-	if (ctx->sdb_type == ERDMA_SDB_PAGE)
-		clear_bit(ctx->sdb_idx, dev->sdb_page);
-	else if (ctx->sdb_type == ERDMA_SDB_ENTRY)
-		clear_bit(ctx->sdb_idx, dev->sdb_entry);
-
 	erdma_uctx_user_mmap_entries_remove(ctx);
 
-	spin_unlock(&dev->db_bitmap_lock);
+	if (ctx->ext_db.enable) {
+		free_ext_db_resources(dev, ctx);
+	} else {
+		spin_lock(&dev->db_bitmap_lock);
+		if (ctx->sdb_type == ERDMA_SDB_PAGE)
+			clear_bit(ctx->sdb_idx, dev->sdb_page);
+		else if (ctx->sdb_type == ERDMA_SDB_ENTRY)
+			clear_bit(ctx->sdb_idx, dev->sdb_entry);
+		spin_unlock(&dev->db_bitmap_lock);
+	}
 
 	atomic_dec(&dev->num_ctx);
 }
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 131cf5f40982..252106679d36 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -31,9 +31,18 @@ struct erdma_user_mmap_entry {
 	u8 mmap_flag;
 };
 
+struct erdma_ext_db_info {
+	bool enable;
+	u16 sdb_off;
+	u16 rdb_off;
+	u16 cdb_off;
+};
+
 struct erdma_ucontext {
 	struct ib_ucontext ibucontext;
 
+	struct erdma_ext_db_info ext_db;
+
 	u32 sdb_type;
 	u32 sdb_idx;
 	u32 sdb_page_idx;
-- 
2.31.1

