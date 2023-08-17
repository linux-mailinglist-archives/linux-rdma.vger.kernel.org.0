Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED1A77F43F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Aug 2023 12:22:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbjHQKWI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Aug 2023 06:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242433AbjHQKV7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Aug 2023 06:21:59 -0400
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1AC2198C
        for <linux-rdma@vger.kernel.org>; Thu, 17 Aug 2023 03:21:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VpzmBE4_1692267714;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VpzmBE4_1692267714)
          by smtp.aliyun-inc.com;
          Thu, 17 Aug 2023 18:21:55 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/3] RDMA/erdma: Renaming variable names and field names of struct erdma_mem
Date:   Thu, 17 Aug 2023 18:21:49 +0800
Message-Id: <20230817102151.75964-2-chengyou@linux.alibaba.com>
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

Currently, variable names and field names of struct erdma_mem contain
'mtt', which is not accurate. Renaming them with 'xxx_mem' or 'mem'.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_verbs.c | 66 +++++++++++------------
 drivers/infiniband/hw/erdma/erdma_verbs.h |  8 +--
 2 files changed, 37 insertions(+), 37 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index fe0521f1536e..fbbd046b350c 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -67,30 +67,30 @@ static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 		user_qp = &qp->user_qp;
 		req.sq_cqn_mtt_cfg = FIELD_PREP(
 			ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
-			ilog2(user_qp->sq_mtt.page_size) - ERDMA_HW_PAGE_SHIFT);
+			ilog2(user_qp->sq_mem.page_size) - ERDMA_HW_PAGE_SHIFT);
 		req.sq_cqn_mtt_cfg |=
 			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->scq->cqn);
 
 		req.rq_cqn_mtt_cfg = FIELD_PREP(
 			ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
-			ilog2(user_qp->rq_mtt.page_size) - ERDMA_HW_PAGE_SHIFT);
+			ilog2(user_qp->rq_mem.page_size) - ERDMA_HW_PAGE_SHIFT);
 		req.rq_cqn_mtt_cfg |=
 			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->rcq->cqn);
 
-		req.sq_mtt_cfg = user_qp->sq_mtt.page_offset;
+		req.sq_mtt_cfg = user_qp->sq_mem.page_offset;
 		req.sq_mtt_cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_CNT_MASK,
-					     user_qp->sq_mtt.mtt_nents) |
+					     user_qp->sq_mem.mtt_nents) |
 				  FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
-					     user_qp->sq_mtt.mtt_type);
+					     user_qp->sq_mem.mtt_type);
 
-		req.rq_mtt_cfg = user_qp->rq_mtt.page_offset;
+		req.rq_mtt_cfg = user_qp->rq_mem.page_offset;
 		req.rq_mtt_cfg |= FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_CNT_MASK,
-					     user_qp->rq_mtt.mtt_nents) |
+					     user_qp->rq_mem.mtt_nents) |
 				  FIELD_PREP(ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK,
-					     user_qp->rq_mtt.mtt_type);
+					     user_qp->rq_mem.mtt_type);
 
-		req.sq_buf_addr = user_qp->sq_mtt.mtt_entry[0];
-		req.rq_buf_addr = user_qp->rq_mtt.mtt_entry[0];
+		req.sq_buf_addr = user_qp->sq_mem.mtt_entry[0];
+		req.rq_buf_addr = user_qp->rq_mem.mtt_entry[0];
 
 		req.sq_db_info_dma_addr = user_qp->sq_db_info_dma_addr;
 		req.rq_db_info_dma_addr = user_qp->rq_db_info_dma_addr;
@@ -161,7 +161,7 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
 {
 	struct erdma_dev *dev = to_edev(cq->ibcq.device);
 	struct erdma_cmdq_create_cq_req req;
-	struct erdma_mem *mtt;
+	struct erdma_mem *mem;
 	u32 page_size;
 
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
@@ -186,23 +186,23 @@ static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
 		req.cq_db_info_addr =
 			cq->kern_cq.qbuf_dma_addr + (cq->depth << CQE_SHIFT);
 	} else {
-		mtt = &cq->user_cq.qbuf_mtt;
+		mem = &cq->user_cq.qbuf_mem;
 		req.cfg0 |=
 			FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
-				   ilog2(mtt->page_size) - ERDMA_HW_PAGE_SHIFT);
-		if (mtt->mtt_nents == 1) {
-			req.qbuf_addr_l = lower_32_bits(*(u64 *)mtt->mtt_buf);
-			req.qbuf_addr_h = upper_32_bits(*(u64 *)mtt->mtt_buf);
+				   ilog2(mem->page_size) - ERDMA_HW_PAGE_SHIFT);
+		if (mem->mtt_nents == 1) {
+			req.qbuf_addr_l = lower_32_bits(*(u64 *)mem->mtt_buf);
+			req.qbuf_addr_h = upper_32_bits(*(u64 *)mem->mtt_buf);
 		} else {
-			req.qbuf_addr_l = lower_32_bits(mtt->mtt_entry[0]);
-			req.qbuf_addr_h = upper_32_bits(mtt->mtt_entry[0]);
+			req.qbuf_addr_l = lower_32_bits(mem->mtt_entry[0]);
+			req.qbuf_addr_h = upper_32_bits(mem->mtt_entry[0]);
 		}
 		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_CNT_MASK,
-				       mtt->mtt_nents);
+				       mem->mtt_nents);
 		req.cfg1 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_MTT_TYPE_MASK,
-				       mtt->mtt_type);
+				       mem->mtt_type);
 
-		req.first_page_offset = mtt->page_offset;
+		req.first_page_offset = mem->page_offset;
 		req.cq_db_info_addr = cq->user_cq.db_info_dma_addr;
 
 		if (uctx->ext_db.enable) {
@@ -660,7 +660,7 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 		   qp->attrs.rq_size * RQE_SIZE))
 		return -EINVAL;
 
-	ret = get_mtt_entries(qp->dev, &qp->user_qp.sq_mtt, va,
+	ret = get_mtt_entries(qp->dev, &qp->user_qp.sq_mem, va,
 			      qp->attrs.sq_size << SQEBB_SHIFT, 0, va,
 			      (SZ_1M - SZ_4K), 1);
 	if (ret)
@@ -669,7 +669,7 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 	rq_offset = ALIGN(qp->attrs.sq_size << SQEBB_SHIFT, ERDMA_HW_PAGE_SIZE);
 	qp->user_qp.rq_offset = rq_offset;
 
-	ret = get_mtt_entries(qp->dev, &qp->user_qp.rq_mtt, va + rq_offset,
+	ret = get_mtt_entries(qp->dev, &qp->user_qp.rq_mem, va + rq_offset,
 			      qp->attrs.rq_size << RQE_SHIFT, 0, va + rq_offset,
 			      (SZ_1M - SZ_4K), 1);
 	if (ret)
@@ -687,18 +687,18 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 	return 0;
 
 put_rq_mtt:
-	put_mtt_entries(qp->dev, &qp->user_qp.rq_mtt);
+	put_mtt_entries(qp->dev, &qp->user_qp.rq_mem);
 
 put_sq_mtt:
-	put_mtt_entries(qp->dev, &qp->user_qp.sq_mtt);
+	put_mtt_entries(qp->dev, &qp->user_qp.sq_mem);
 
 	return ret;
 }
 
 static void free_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx)
 {
-	put_mtt_entries(qp->dev, &qp->user_qp.sq_mtt);
-	put_mtt_entries(qp->dev, &qp->user_qp.rq_mtt);
+	put_mtt_entries(qp->dev, &qp->user_qp.sq_mem);
+	put_mtt_entries(qp->dev, &qp->user_qp.rq_mem);
 	erdma_unmap_user_dbrecords(uctx, &qp->user_qp.user_dbr_page);
 }
 
@@ -1041,7 +1041,7 @@ int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 				  cq->kern_cq.qbuf, cq->kern_cq.qbuf_dma_addr);
 	} else {
 		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
-		put_mtt_entries(dev, &cq->user_cq.qbuf_mtt);
+		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
 	}
 
 	xa_erase(&dev->cq_xa, cq->cqn);
@@ -1089,8 +1089,8 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 			WARPPED_BUFSIZE(qp->attrs.sq_size << SQEBB_SHIFT),
 			qp->kern_qp.sq_buf, qp->kern_qp.sq_buf_dma_addr);
 	} else {
-		put_mtt_entries(dev, &qp->user_qp.sq_mtt);
-		put_mtt_entries(dev, &qp->user_qp.rq_mtt);
+		put_mtt_entries(dev, &qp->user_qp.sq_mem);
+		put_mtt_entries(dev, &qp->user_qp.rq_mem);
 		erdma_unmap_user_dbrecords(ctx, &qp->user_qp.user_dbr_page);
 	}
 
@@ -1379,7 +1379,7 @@ static int erdma_init_user_cq(struct erdma_ucontext *ctx, struct erdma_cq *cq,
 	int ret;
 	struct erdma_dev *dev = to_edev(cq->ibcq.device);
 
-	ret = get_mtt_entries(dev, &cq->user_cq.qbuf_mtt, ureq->qbuf_va,
+	ret = get_mtt_entries(dev, &cq->user_cq.qbuf_mem, ureq->qbuf_va,
 			      ureq->qbuf_len, 0, ureq->qbuf_va, SZ_64M - SZ_4K,
 			      1);
 	if (ret)
@@ -1389,7 +1389,7 @@ static int erdma_init_user_cq(struct erdma_ucontext *ctx, struct erdma_cq *cq,
 				       &cq->user_cq.user_dbr_page,
 				       &cq->user_cq.db_info_dma_addr);
 	if (ret)
-		put_mtt_entries(dev, &cq->user_cq.qbuf_mtt);
+		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
 
 	return ret;
 }
@@ -1473,7 +1473,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 err_free_res:
 	if (!rdma_is_kernel_res(&ibcq->res)) {
 		erdma_unmap_user_dbrecords(ctx, &cq->user_cq.user_dbr_page);
-		put_mtt_entries(dev, &cq->user_cq.qbuf_mtt);
+		put_mtt_entries(dev, &cq->user_cq.qbuf_mem);
 	} else {
 		dma_free_coherent(&dev->pdev->dev,
 				  WARPPED_BUFSIZE(depth << CQE_SHIFT),
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index 429fc3063f98..abaf031fe0d2 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -65,7 +65,7 @@ struct erdma_pd {
  * MemoryRegion definition.
  */
 #define ERDMA_MAX_INLINE_MTT_ENTRIES 4
-#define MTT_SIZE(mtt_cnt) (mtt_cnt << 3) /* per mtt takes 8 Bytes. */
+#define MTT_SIZE(mtt_cnt) (mtt_cnt << 3) /* per mtt entry takes 8 Bytes. */
 #define ERDMA_MR_MAX_MTT_CNT 524288
 #define ERDMA_MTT_ENTRY_SIZE 8
 
@@ -121,8 +121,8 @@ struct erdma_user_dbrecords_page {
 };
 
 struct erdma_uqp {
-	struct erdma_mem sq_mtt;
-	struct erdma_mem rq_mtt;
+	struct erdma_mem sq_mem;
+	struct erdma_mem rq_mem;
 
 	dma_addr_t sq_db_info_dma_addr;
 	dma_addr_t rq_db_info_dma_addr;
@@ -234,7 +234,7 @@ struct erdma_kcq_info {
 };
 
 struct erdma_ucq_info {
-	struct erdma_mem qbuf_mtt;
+	struct erdma_mem qbuf_mem;
 	struct erdma_user_dbrecords_page *user_dbr_page;
 	dma_addr_t db_info_dma_addr;
 };
-- 
2.31.1

