Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7F877F440
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 12:22:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244765AbjHQKWJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Aug 2023 06:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348524AbjHQKWC (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Aug 2023 06:22:02 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F2198C
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 03:21:59 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R901e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VpzlsM5_1692267716;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VpzlsM5_1692267716)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 18:21:57 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 3/3] RDMA/erdma: Implement hierachical MTT
Date:   Thu, 17 Aug 2023 18:21:51 +0800
Message-Id: <20230817102151.75964-4-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230817102151.75964-1-chengyou@linux.alibaba.com>
References: <20230817102151.75964-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hierarchical MTT allows large MR registration without the need of
continous physical address. This commit add the support of hierachical
MTT support for erdma.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    |  14 +-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 200 +++++++++++++++++++---
 drivers/infiniband/hw/erdma/erdma_verbs.h |   4 +-
 3 files changed, 194 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 80a78569bc2a..9d316fdc6f9a 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -248,6 +248,7 @@ struct erdma_cmdq_create_cq_req {
 
 /* regmr/deregmr cfg0 */
 #define ERDMA_CMD_MR_VALID_MASK BIT(31)
+#define ERDMA_CMD_MR_VERSION_MASK GENMASK(30, 28)
 #define ERDMA_CMD_MR_KEY_MASK GENMASK(27, 20)
 #define ERDMA_CMD_MR_MPT_IDX_MASK GENMASK(19, 0)
 
@@ -258,6 +259,7 @@ struct erdma_cmdq_create_cq_req {
 
 /* regmr cfg2 */
 #define ERDMA_CMD_REGMR_PAGESIZE_MASK GENMASK(31, 27)
+#define ERDMA_CMD_REGMR_MTT_PAGESIZE_MASK GENMASK(26, 24)
 #define ERDMA_CMD_REGMR_MTT_LEVEL_MASK GENMASK(21, 20)
 #define ERDMA_CMD_REGMR_MTT_CNT_MASK GENMASK(19, 0)
 
@@ -268,7 +270,14 @@ struct erdma_cmdq_reg_mr_req {
 	u64 start_va;
 	u32 size;
 	u32 cfg2;
-	u64 phy_addr[4];
+	union {
+		u64 phy_addr[4];
+		struct {
+			u64 rsvd;
+			u32 size_h;
+			u32 mtt_cnt_h;
+		};
+	};
 };
 
 struct erdma_cmdq_dereg_mr_req {
@@ -309,7 +318,7 @@ struct erdma_cmdq_modify_qp_req {
 /* create qp mtt_cfg */
 #define ERDMA_CMD_CREATE_QP_PAGE_OFFSET_MASK GENMASK(31, 12)
 #define ERDMA_CMD_CREATE_QP_MTT_CNT_MASK GENMASK(11, 1)
-#define ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK BIT(0)
+#define ERDMA_CMD_CREATE_QP_MTT_LEVEL_MASK BIT(0)
 
 /* create qp db cfg */
 #define ERDMA_CMD_CREATE_QP_SQDB_CFG_MASK GENMASK(31, 16)
@@ -364,6 +373,7 @@ struct erdma_cmdq_reflush_req {
 
 enum {
 	ERDMA_DEV_CAP_FLAGS_ATOMIC = 1 << 7,
+	ERDMA_DEV_CAP_FLAGS_MTT_VA = 1 << 5,
 	ERDMA_DEV_CAP_FLAGS_EXTEND_DB = 1 << 3,
 };
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 0d272f18256a..dcccb6015232 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -26,13 +26,13 @@ static void assemble_qbuf_mtt_for_cmd(struct erdma_mem *mem, u32 *cfg,
 
 	if (mem->mtt_nents > ERDMA_MAX_INLINE_MTT_ENTRIES) {
 		*addr0 = mtt->buf_dma;
-		*cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
-				   ERDMA_MR_INDIRECT_MTT);
+		*cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_LEVEL_MASK,
+				   ERDMA_MR_MTT_1LEVEL);
 	} else {
 		*addr0 = mtt->buf[0];
 		memcpy(addr1, mtt->buf + 1, MTT_SIZE(mem->mtt_nents - 1));
-		*cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
-				   ERDMA_MR_INLINE_MTT);
+		*cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_LEVEL_MASK,
+				   ERDMA_MR_MTT_0LEVEL);
 	}
 }
 
@@ -70,8 +70,8 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 		req.sq_mtt_cfg =
 			FIELD_PREP(ERDMA_CMD_CREATE_QP_PAGE_OFFSET_MASK, 0) |
 			FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_CNT_MASK, 1) |
-			FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
-				   ERDMA_MR_INLINE_MTT);
+			FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_LEVEL_MASK,
+				   ERDMA_MR_MTT_0LEVEL);
 		req.rq_mtt_cfg = req.sq_mtt_cfg;
 
 		req.rq_buf_addr = qp->kern_qp.rq_buf_dma_addr;
@@ -140,12 +140,17 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 
 	if (mr->type == ERDMA_MR_TYPE_FRMR ||
 	    mr->mem.page_cnt > ERDMA_MAX_INLINE_MTT_ENTRIES) {
-		req.phy_addr[0] = mr->mem.mtt->buf_dma;
-		mtt_level = ERDMA_MR_INDIRECT_MTT;
+		if (mr->mem.mtt->continuous) {
+			req.phy_addr[0] = mr->mem.mtt->buf_dma;
+			mtt_level = ERDMA_MR_MTT_1LEVEL;
+		} else {
+			req.phy_addr[0] = sg_dma_address(mr->mem.mtt->sglist);
+			mtt_level = mr->mem.mtt->level;
+		}
 	} else {
 		memcpy(req.phy_addr, mr->mem.mtt->buf,
 		       MTT_SIZE(mr->mem.page_cnt));
-		mtt_level = ERDMA_MR_INLINE_MTT;
+		mtt_level = ERDMA_MR_MTT_0LEVEL;
 	}
 
 	req.cfg0 = FIELD_PREP(ERDMA_CMD_MR_VALID_MASK, mr->valid) |
@@ -167,6 +172,14 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 		req.size = mr->mem.len;
 	}
 
+	if (!mr->mem.mtt->continuous && mr->mem.mtt->level > 1) {
+		req.cfg0 |= FIELD_PREP(ERDMA_CMD_MR_VERSION_MASK, 1);
+		req.cfg2 |= FIELD_PREP(ERDMA_CMD_REGMR_MTT_PAGESIZE_MASK,
+				       PAGE_SHIFT - ERDMA_HW_PAGE_SHIFT);
+		req.size_h = upper_32_bits(mr->mem.len);
+		req.mtt_cnt_h = mr->mem.page_cnt >> 20;
+	}
+
 post_cmd:
 	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 }
@@ -194,7 +207,7 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
 
 		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_CNT_MASK, 1) |
 			    FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_LEVEL_MASK,
-				       ERDMA_MR_INLINE_MTT);
+				       ERDMA_MR_MTT_0LEVEL);
 
 		req.first_page_offset = 0;
 		req.cq_db_info_addr =
@@ -209,13 +222,13 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
 			req.qbuf_addr_h = upper_32_bits(mem->mtt->buf[0]);
 			req.cfg1 |=
 				FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_LEVEL_MASK,
-					   ERDMA_MR_INLINE_MTT);
+					   ERDMA_MR_MTT_0LEVEL);
 		} else {
 			req.qbuf_addr_l = lower_32_bits(mem->mtt->buf_dma);
 			req.qbuf_addr_h = upper_32_bits(mem->mtt->buf_dma);
 			req.cfg1 |=
 				FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_LEVEL_MASK,
-					   ERDMA_MR_INDIRECT_MTT);
+					   ERDMA_MR_MTT_1LEVEL);
 		}
 		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_CNT_MASK,
 				       mem->mtt_nents);
@@ -543,7 +556,6 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
 					       size_t size)
 {
 	struct erdma_mtt *mtt;
-	int ret = -ENOMEM;
 
 	mtt = kzalloc(sizeof(*mtt), GFP_KERNEL);
 	if (!mtt)
@@ -565,6 +577,104 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
 err_free_mtt_buf:
 	kfree(mtt->buf);
 
+err_free_mtt:
+	kfree(mtt);
+
+	return ERR_PTR(-ENOMEM);
+}
+
+static void erdma_destroy_mtt_buf_sg(struct erdma_dev *dev,
+				     struct erdma_mtt *mtt)
+{
+	dma_unmap_sg(&dev->pdev->dev, mtt->sglist, mtt->nsg, DMA_TO_DEVICE);
+	vfree(mtt->sglist);
+}
+
+static void erdma_destroy_scatter_mtt(struct erdma_dev *dev,
+				      struct erdma_mtt *mtt)
+{
+	erdma_destroy_mtt_buf_sg(dev, mtt);
+	vfree(mtt->buf);
+	kfree(mtt);
+}
+
+static void erdma_init_middle_mtt(struct erdma_mtt *mtt,
+				  struct erdma_mtt *low_mtt)
+{
+	struct scatterlist *sg;
+	u32 idx = 0, i;
+
+	for_each_sg(low_mtt->sglist, sg, low_mtt->nsg, i)
+		mtt->buf[idx++] = sg_dma_address(sg);
+}
+
+static int erdma_create_mtt_buf_sg(struct erdma_dev *dev, struct erdma_mtt *mtt)
+{
+	struct scatterlist *sglist;
+	void *buf = mtt->buf;
+	u32 npages, i, nsg;
+	struct page *pg;
+
+	/* Failed if buf is not page aligned */
+	if ((uintptr_t)buf & ~PAGE_MASK)
+		return -EINVAL;
+
+	npages = DIV_ROUND_UP(mtt->size, PAGE_SIZE);
+	sglist = vzalloc(npages * sizeof(*sglist));
+	if (!sglist)
+		return -ENOMEM;
+
+	sg_init_table(sglist, npages);
+	for (i = 0; i < npages; i++) {
+		pg = vmalloc_to_page(buf);
+		if (!pg)
+			goto err;
+		sg_set_page(&sglist[i], pg, PAGE_SIZE, 0);
+		buf += PAGE_SIZE;
+	}
+
+	nsg = dma_map_sg(&dev->pdev->dev, sglist, npages, DMA_TO_DEVICE);
+	if (!nsg)
+		goto err;
+
+	mtt->sglist = sglist;
+	mtt->nsg = nsg;
+
+	return 0;
+err:
+	vfree(sglist);
+
+	return -ENOMEM;
+}
+
+static struct erdma_mtt *erdma_create_scatter_mtt(struct erdma_dev *dev,
+						  size_t size)
+{
+	struct erdma_mtt *mtt;
+	int ret = -ENOMEM;
+
+	mtt = kzalloc(sizeof(*mtt), GFP_KERNEL);
+	if (!mtt)
+		return NULL;
+
+	mtt->size = ALIGN(size, PAGE_SIZE);
+	mtt->buf = vzalloc(mtt->size);
+	mtt->continuous = false;
+	if (!mtt->buf)
+		goto err_free_mtt;
+
+	ret = erdma_create_mtt_buf_sg(dev, mtt);
+	if (ret)
+		goto err_free_mtt_buf;
+
+	ibdev_dbg(&dev->ibdev, "create scatter mtt, size:%lu, nsg:%u\n",
+		  mtt->size, mtt->nsg);
+
+	return mtt;
+
+err_free_mtt_buf:
+	vfree(mtt->buf);
+
 err_free_mtt:
 	kfree(mtt);
 
@@ -574,28 +684,77 @@ static struct erdma_mtt *erdma_create_cont_mtt(struct erdma_dev *dev,
 static struct erdma_mtt *erdma_create_mtt(struct erdma_dev *dev, size_t size,
 					  bool force_continuous)
 {
+	struct erdma_mtt *mtt, *tmp_mtt;
+	int ret, level = 0;
+
 	ibdev_dbg(&dev->ibdev, "create_mtt, size:%lu, force cont:%d\n", size,
 		  force_continuous);
 
+	if (!(dev->attrs.cap_flags & ERDMA_DEV_CAP_FLAGS_MTT_VA))
+		force_continuous = true;
+
 	if (force_continuous)
 		return erdma_create_cont_mtt(dev, size);
 
-	return ERR_PTR(-ENOTSUPP);
+	mtt = erdma_create_scatter_mtt(dev, size);
+	if (IS_ERR(mtt))
+		return mtt;
+	level = 1;
+
+	/* convergence the mtt table. */
+	while (mtt->nsg != 1 && level <= 3) {
+		tmp_mtt = erdma_create_scatter_mtt(dev, MTT_SIZE(mtt->nsg));
+		if (IS_ERR(tmp_mtt)) {
+			ret = PTR_ERR(tmp_mtt);
+			goto err_free_mtt;
+		}
+		erdma_init_middle_mtt(tmp_mtt, mtt);
+		tmp_mtt->low_level = mtt;
+		mtt = tmp_mtt;
+		level++;
+	}
+
+	if (level > 3) {
+		ret = -ENOMEM;
+		goto err_free_mtt;
+	}
+
+	mtt->level = level;
+	ibdev_dbg(&dev->ibdev, "top mtt: level:%d, dma_addr 0x%llx\n",
+		  mtt->level, mtt->sglist[0].dma_address);
+
+	return mtt;
+err_free_mtt:
+	while (mtt) {
+		tmp_mtt = mtt->low_level;
+		erdma_destroy_scatter_mtt(dev, mtt);
+		mtt = tmp_mtt;
+	}
+
+	return ERR_PTR(ret);
 }
 
 static void erdma_destroy_mtt(struct erdma_dev *dev, struct erdma_mtt *mtt)
 {
+	struct erdma_mtt *tmp_mtt;
+
 	if (mtt->continuous) {
 		dma_unmap_single(&dev->pdev->dev, mtt->buf_dma, mtt->size,
 				 DMA_TO_DEVICE);
 		kfree(mtt->buf);
 		kfree(mtt);
+	} else {
+		while (mtt) {
+			tmp_mtt = mtt->low_level;
+			erdma_destroy_scatter_mtt(dev, mtt);
+			mtt = tmp_mtt;
+		}
 	}
 }
 
 static int get_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem,
 			   u64 start, u64 len, int access, u64 virt,
-			   unsigned long req_page_size, u8 force_indirect_mtt)
+			   unsigned long req_page_size, bool force_continuous)
 {
 	int ret = 0;
 
@@ -612,7 +771,8 @@ static int get_mtt_entries(struct erdma_dev *dev, struct erdma_mem *mem,
 	mem->page_offset = start & (mem->page_size - 1);
 	mem->mtt_nents = ib_umem_num_dma_blocks(mem->umem, mem->page_size);
 	mem->page_cnt = mem->mtt_nents;
-	mem->mtt = erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt), true);
+	mem->mtt = erdma_create_mtt(dev, MTT_SIZE(mem->page_cnt),
+				    force_continuous);
 	if (IS_ERR(mem->mtt)) {
 		ret = PTR_ERR(mem->mtt);
 		goto error_ret;
@@ -717,7 +877,7 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 
 	ret = get_mtt_entries(qp->dev, &qp->user_qp.sq_mem, va,
 			      qp->attrs.sq_size << SQEBB_SHIFT, 0, va,
-			      (SZ_1M - SZ_4K), 1);
+			      (SZ_1M - SZ_4K), true);
 	if (ret)
 		return ret;
 
@@ -726,7 +886,7 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 
 	ret = get_mtt_entries(qp->dev, &qp->user_qp.rq_mem, va + rq_offset,
 			      qp->attrs.rq_size << RQE_SHIFT, 0, va + rq_offset,
-			      (SZ_1M - SZ_4K), 1);
+			      (SZ_1M - SZ_4K), true);
 	if (ret)
 		goto put_sq_mtt;
 
@@ -998,7 +1158,7 @@ struct ib_mr *erdma_reg_user_mr(struct ib_pd *ibpd, u64 start, u64 len,
 		return ERR_PTR(-ENOMEM);
 
 	ret = get_mtt_entries(dev, &mr->mem, start, len, access, virt,
-			      SZ_2G - SZ_4K, 0);
+			      SZ_2G - SZ_4K, false);
 	if (ret)
 		goto err_out_free;
 
@@ -1423,7 +1583,7 @@ static int erdma_init_user_cq(struct erdma_ucontext *ctx, struct erdma_cq *cq,
 
 	ret = get_mtt_entries(dev, &cq->user_cq.qbuf_mem, ureq->qbuf_va,
 			      ureq->qbuf_len, 0, ureq->qbuf_va, SZ_64M - SZ_4K,
-			      1);
+			      true);
 	if (ret)
 		return ret;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 5f639f27a8a9..eb9c0f92fb6f 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -73,8 +73,8 @@ struct erdma_pd {
 #define ERDMA_MR_TYPE_FRMR 1
 #define ERDMA_MR_TYPE_DMA 2
 
-#define ERDMA_MR_INLINE_MTT 0
-#define ERDMA_MR_INDIRECT_MTT 1
+#define ERDMA_MR_MTT_0LEVEL 0
+#define ERDMA_MR_MTT_1LEVEL 1
 
 #define ERDMA_MR_ACC_RA BIT(0)
 #define ERDMA_MR_ACC_LR BIT(1)
-- 
2.31.1

