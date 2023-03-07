Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BACF6ADBF1
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Mar 2023 11:30:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCGKap (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Mar 2023 05:30:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbjCGKaU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 7 Mar 2023 05:30:20 -0500
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F63497F2
        for <linux-rdma@vger.kernel.org>; Tue,  7 Mar 2023 02:29:31 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R931e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VdL2Wdx_1678184969;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VdL2Wdx_1678184969)
          by smtp.aliyun-inc.com;
          Tue, 07 Mar 2023 18:29:29 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next v2 2/2] RDMA/erdma: Support non-4K page size in doorbell allocation
Date:   Tue,  7 Mar 2023 18:29:24 +0800
Message-Id: <20230307102924.70577-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230307102924.70577-1-chengyou@linux.alibaba.com>
References: <20230307102924.70577-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Doorbell resources are exposed to userspace by mmap. The size unit of mmap
is PAGE_SIZE, previous implementation can not work correctly if PAGE_SIZE
is not 4K. We support non-4K page size in this commit.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 40 ++++++++++-------------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  5 ++-
 include/uapi/rdma/erdma-abi.h             |  5 ++-
 3 files changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 83e1b0d55977..0cd8dd61f569 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -1137,8 +1137,8 @@ void erdma_mmap_free(struct rdma_user_mmap_entry *rdma_entry)
 static void alloc_db_resources(struct erdma_dev *dev,
 			       struct erdma_ucontext *ctx)
 {
-	u32 bitmap_idx;
 	struct erdma_devattr *attrs = &dev->attrs;
+	u32 bitmap_idx, hw_page_idx;
 
 	if (attrs->disable_dwqe)
 		goto alloc_normal_db;
@@ -1151,11 +1151,9 @@ static void alloc_db_resources(struct erdma_dev *dev,
 		spin_unlock(&dev->db_bitmap_lock);
 
 		ctx->sdb_type = ERDMA_SDB_PAGE;
-		ctx->sdb_idx = bitmap_idx;
-		ctx->sdb_page_idx = bitmap_idx;
+		ctx->sdb_bitmap_idx = bitmap_idx;
 		ctx->sdb = dev->func_bar_addr + ERDMA_BAR_SQDB_SPACE_OFFSET +
-			   (bitmap_idx << PAGE_SHIFT);
-		ctx->sdb_page_off = 0;
+			   (bitmap_idx << ERDMA_HW_PAGE_SHIFT);
 
 		return;
 	}
@@ -1166,13 +1164,13 @@ static void alloc_db_resources(struct erdma_dev *dev,
 		spin_unlock(&dev->db_bitmap_lock);
 
 		ctx->sdb_type = ERDMA_SDB_ENTRY;
-		ctx->sdb_idx = bitmap_idx;
-		ctx->sdb_page_idx = attrs->dwqe_pages +
+		ctx->sdb_bitmap_idx = bitmap_idx;
+		hw_page_idx = attrs->dwqe_pages +
 				    bitmap_idx / ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
-		ctx->sdb_page_off = bitmap_idx % ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
 
+		ctx->sdb_entid = bitmap_idx % ERDMA_DWQE_TYPE1_CNT_PER_PAGE;
 		ctx->sdb = dev->func_bar_addr + ERDMA_BAR_SQDB_SPACE_OFFSET +
-			   (ctx->sdb_page_idx << PAGE_SHIFT);
+			   (hw_page_idx << PAGE_SHIFT);
 
 		return;
 	}
@@ -1181,11 +1179,8 @@ static void alloc_db_resources(struct erdma_dev *dev,
 
 alloc_normal_db:
 	ctx->sdb_type = ERDMA_SDB_SHARED;
-	ctx->sdb_idx = 0;
-	ctx->sdb_page_idx = ERDMA_SDB_SHARED_PAGE_INDEX;
-	ctx->sdb_page_off = 0;
-
-	ctx->sdb = dev->func_bar_addr + (ctx->sdb_page_idx << PAGE_SHIFT);
+	ctx->sdb = dev->func_bar_addr +
+		   (ERDMA_SDB_SHARED_PAGE_INDEX << ERDMA_HW_PAGE_SHIFT);
 }
 
 static void erdma_uctx_user_mmap_entries_remove(struct erdma_ucontext *uctx)
@@ -1215,11 +1210,6 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 	ctx->rdb = dev->func_bar_addr + ERDMA_BAR_RQDB_SPACE_OFFSET;
 	ctx->cdb = dev->func_bar_addr + ERDMA_BAR_CQDB_SPACE_OFFSET;
 
-	if (udata->outlen < sizeof(uresp)) {
-		ret = -EINVAL;
-		goto err_out;
-	}
-
 	ctx->sq_db_mmap_entry = erdma_user_mmap_entry_insert(
 		ctx, (void *)ctx->sdb, PAGE_SIZE, ERDMA_MMAP_IO_NC, &uresp.sdb);
 	if (!ctx->sq_db_mmap_entry) {
@@ -1243,9 +1233,13 @@ int erdma_alloc_ucontext(struct ib_ucontext *ibctx, struct ib_udata *udata)
 
 	uresp.dev_id = dev->pdev->device;
 	uresp.sdb_type = ctx->sdb_type;
-	uresp.sdb_offset = ctx->sdb_page_off;
+	uresp.sdb_entid = ctx->sdb_entid;
+	uresp.sdb_off = ctx->sdb & ~PAGE_MASK;
+	uresp.rdb_off = ctx->rdb & ~PAGE_MASK;
+	uresp.cdb_off = ctx->cdb & ~PAGE_MASK;
 
-	ret = ib_copy_to_udata(udata, &uresp, sizeof(uresp));
+	ret = ib_copy_to_udata(udata, &uresp,
+			       min(sizeof(uresp), udata->outlen));
 	if (ret)
 		goto err_out;
 
@@ -1264,9 +1258,9 @@ void erdma_dealloc_ucontext(struct ib_ucontext *ibctx)
 
 	spin_lock(&dev->db_bitmap_lock);
 	if (ctx->sdb_type == ERDMA_SDB_PAGE)
-		clear_bit(ctx->sdb_idx, dev->sdb_page);
+		clear_bit(ctx->sdb_bitmap_idx, dev->sdb_page);
 	else if (ctx->sdb_type == ERDMA_SDB_ENTRY)
-		clear_bit(ctx->sdb_idx, dev->sdb_entry);
+		clear_bit(ctx->sdb_bitmap_idx, dev->sdb_entry);
 
 	erdma_uctx_user_mmap_entries_remove(ctx);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index e0a993bc032a..4dbef1483027 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -35,9 +35,8 @@ struct erdma_ucontext {
 	struct ib_ucontext ibucontext;
 
 	u32 sdb_type;
-	u32 sdb_idx;
-	u32 sdb_page_idx;
-	u32 sdb_page_off;
+	u32 sdb_bitmap_idx;
+	u32 sdb_entid;
 	u64 sdb;
 	u64 rdb;
 	u64 cdb;
diff --git a/include/uapi/rdma/erdma-abi.h b/include/uapi/rdma/erdma-abi.h
index b7a0222f978f..57f8942a3c56 100644
--- a/include/uapi/rdma/erdma-abi.h
+++ b/include/uapi/rdma/erdma-abi.h
@@ -40,10 +40,13 @@ struct erdma_uresp_alloc_ctx {
 	__u32 dev_id;
 	__u32 pad;
 	__u32 sdb_type;
-	__u32 sdb_offset;
+	__u32 sdb_entid;
 	__aligned_u64 sdb;
 	__aligned_u64 rdb;
 	__aligned_u64 cdb;
+	__u32 sdb_off;
+	__u32 rdb_off;
+	__u32 cdb_off;
 };
 
 #endif
-- 
2.31.1

