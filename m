Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE3969C875
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Feb 2023 11:20:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjBTKU0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Feb 2023 05:20:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbjBTKUZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Feb 2023 05:20:25 -0500
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF6E40C3
        for <linux-rdma@vger.kernel.org>; Mon, 20 Feb 2023 02:20:20 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vc50v1s_1676888417;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vc50v1s_1676888417)
          by smtp.aliyun-inc.com;
          Mon, 20 Feb 2023 18:20:18 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/2] RDMA/erdma: Use fixed hardware page size
Date:   Mon, 20 Feb 2023 18:20:14 +0800
Message-Id: <20230220102015.43047-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230220102015.43047-1-chengyou@linux.alibaba.com>
References: <20230220102015.43047-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hardware page size is 4096, but the kernel's page size may vary. driver
should use hardware page size to set the parameters to hardware.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    |  4 ++++
 drivers/infiniband/hw/erdma/erdma_verbs.c | 17 +++++++++--------
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 4c38d99c73f1..56e0c7a3e8f8 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -112,6 +112,10 @@
 
 #define ERDMA_PAGE_SIZE_SUPPORT 0x7FFFF000
 
+/* Hardware page size definition */
+#define ERDMA_HW_PAGE_SHIFT 12
+#define ERDMA_HW_PAGE_SIZE 4096
+
 /* WQE related. */
 #define EQE_SIZE 16
 #define EQE_SHIFT 4
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 9c30d78730aa..83e1b0d55977 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -38,7 +38,7 @@ static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
 		   FIELD_PREP(ERDMA_CMD_CREATE_QP_PD_MASK, pd->pdn);
 
 	if (rdma_is_kernel_res(&qp->ibqp.res)) {
-		u32 pgsz_range = ilog2(SZ_1M) - PAGE_SHIFT;
+		u32 pgsz_range = ilog2(SZ_1M) - ERDMA_HW_PAGE_SHIFT;
 
 		req.sq_cqn_mtt_cfg =
 			FIELD_PREP(ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
@@ -66,13 +66,13 @@ static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
 		user_qp = &qp->user_qp;
 		req.sq_cqn_mtt_cfg = FIELD_PREP(
 			ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
-			ilog2(user_qp->sq_mtt.page_size) - PAGE_SHIFT);
+			ilog2(user_qp->sq_mtt.page_size) - ERDMA_HW_PAGE_SHIFT);
 		req.sq_cqn_mtt_cfg |=
 			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->scq->cqn);
 
 		req.rq_cqn_mtt_cfg = FIELD_PREP(
 			ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK,
-			ilog2(user_qp->rq_mtt.page_size) - PAGE_SHIFT);
+			ilog2(user_qp->rq_mtt.page_size) - ERDMA_HW_PAGE_SHIFT);
 		req.rq_cqn_mtt_cfg |=
 			FIELD_PREP(ERDMA_CMD_CREATE_QP_CQN_MASK, qp->rcq->cqn);
 
@@ -162,7 +162,7 @@ static int create_cq_cmd(struct erdma_dev *dev, struct erdma_cq *cq)
 	if (rdma_is_kernel_res(&cq->ibcq.res)) {
 		page_size = SZ_32M;
 		req.cfg0 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
-				       ilog2(page_size) - PAGE_SHIFT);
+				       ilog2(page_size) - ERDMA_HW_PAGE_SHIFT);
 		req.qbuf_addr_l = lower_32_bits(cq->kern_cq.qbuf_dma_addr);
 		req.qbuf_addr_h = upper_32_bits(cq->kern_cq.qbuf_dma_addr);
 
@@ -175,8 +175,9 @@ static int create_cq_cmd(struct erdma_dev *dev, struct erdma_cq *cq)
 			cq->kern_cq.qbuf_dma_addr + (cq->depth << CQE_SHIFT);
 	} else {
 		mtt = &cq->user_cq.qbuf_mtt;
-		req.cfg0 |= FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
-				       ilog2(mtt->page_size) - PAGE_SHIFT);
+		req.cfg0 |=
+			FIELD_PREP(ERDMA_CMD_CREATE_CQ_PAGESIZE_MASK,
+				   ilog2(mtt->page_size) - ERDMA_HW_PAGE_SHIFT);
 		if (mtt->mtt_nents == 1) {
 			req.qbuf_addr_l = lower_32_bits(*(u64 *)mtt->mtt_buf);
 			req.qbuf_addr_h = upper_32_bits(*(u64 *)mtt->mtt_buf);
@@ -636,7 +637,7 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 	u32 rq_offset;
 	int ret;
 
-	if (len < (PAGE_ALIGN(qp->attrs.sq_size * SQEBB_SIZE) +
+	if (len < (ALIGN(qp->attrs.sq_size * SQEBB_SIZE, ERDMA_HW_PAGE_SIZE) +
 		   qp->attrs.rq_size * RQE_SIZE))
 		return -EINVAL;
 
@@ -646,7 +647,7 @@ static int init_user_qp(struct erdma_qp *qp, struct erdma_ucontext *uctx,
 	if (ret)
 		return ret;
 
-	rq_offset = PAGE_ALIGN(qp->attrs.sq_size << SQEBB_SHIFT);
+	rq_offset = ALIGN(qp->attrs.sq_size << SQEBB_SHIFT, ERDMA_HW_PAGE_SIZE);
 	qp->user_qp.rq_offset = rq_offset;
 
 	ret = get_mtt_entries(qp->dev, &qp->user_qp.rq_mtt, va + rq_offset,
-- 
2.27.0

