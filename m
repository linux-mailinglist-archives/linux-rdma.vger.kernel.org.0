Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6595D7236F7
	for <lists+linux-rdma@lfdr.de>; Tue,  6 Jun 2023 07:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231670AbjFFFub (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 6 Jun 2023 01:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234224AbjFFFuU (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 6 Jun 2023 01:50:20 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A901FE6F
        for <linux-rdma@vger.kernel.org>; Mon,  5 Jun 2023 22:50:14 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R301e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VkV1mr6_1686030610;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VkV1mr6_1686030610)
          by smtp.aliyun-inc.com;
          Tue, 06 Jun 2023 13:50:11 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 3/4] RDMA/erdma: Associate QPs/CQs with doorbells for authorization
Date:   Tue,  6 Jun 2023 13:50:04 +0800
Message-Id: <20230606055005.80729-4-chengyou@linux.alibaba.com>
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

For the isolation requirement, each QP/CQ can only issue doorbells from the
allocated mmio space. Configure the relationship between QPs/CQs and
mmio doorbell spaces to hardware in create_qp/create_cq interfaces.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    | 17 ++++++++++++-
 drivers/infiniband/hw/erdma/erdma_verbs.c | 31 ++++++++++++++++++-----
 2 files changed, 41 insertions(+), 7 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 812fc40de64b..cf7629bfe534 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -134,7 +134,7 @@
 
 /* CMDQ related. */
 #define ERDMA_CMDQ_MAX_OUTSTANDING 128
-#define ERDMA_CMDQ_SQE_SIZE 64
+#define ERDMA_CMDQ_SQE_SIZE 128
 
 /* cmdq sub module definition. */
 enum CMDQ_WQE_SUB_MOD {
@@ -242,8 +242,12 @@ struct erdma_cmdq_ext_db_req {
 /* create_cq cfg1 */
 #define ERDMA_CMD_CREATE_CQ_MTT_CNT_MASK GENMASK(31, 16)
 #define ERDMA_CMD_CREATE_CQ_MTT_TYPE_MASK BIT(15)
+#define ERDMA_CMD_CREATE_CQ_MTT_DB_CFG_MASK BIT(11)
 #define ERDMA_CMD_CREATE_CQ_EQN_MASK GENMASK(9, 0)
 
+/* create_cq cfg2 */
+#define ERDMA_CMD_CREATE_CQ_DB_CFG_MASK GENMASK(15, 0)
+
 struct erdma_cmdq_create_cq_req {
 	u64 hdr;
 	u32 cfg0;
@@ -252,6 +256,7 @@ struct erdma_cmdq_create_cq_req {
 	u32 cfg1;
 	u64 cq_db_info_addr;
 	u32 first_page_offset;
+	u32 cfg2;
 };
 
 /* regmr/deregmr cfg0 */
@@ -311,6 +316,7 @@ struct erdma_cmdq_modify_qp_req {
 
 /* create qp cqn_mtt_cfg */
 #define ERDMA_CMD_CREATE_QP_PAGE_SIZE_MASK GENMASK(31, 28)
+#define ERDMA_CMD_CREATE_QP_DB_CFG_MASK BIT(25)
 #define ERDMA_CMD_CREATE_QP_CQN_MASK GENMASK(23, 0)
 
 /* create qp mtt_cfg */
@@ -318,6 +324,10 @@ struct erdma_cmdq_modify_qp_req {
 #define ERDMA_CMD_CREATE_QP_MTT_CNT_MASK GENMASK(11, 1)
 #define ERDMA_CMD_CREATE_QP_MTT_TYPE_MASK BIT(0)
 
+/* create qp db cfg */
+#define ERDMA_CMD_CREATE_QP_SQDB_CFG_MASK GENMASK(31, 16)
+#define ERDMA_CMD_CREATE_QP_RQDB_CFG_MASK GENMASK(15, 0)
+
 #define ERDMA_CMDQ_CREATE_QP_RESP_COOKIE_MASK GENMASK_ULL(31, 0)
 
 struct erdma_cmdq_create_qp_req {
@@ -332,6 +342,11 @@ struct erdma_cmdq_create_qp_req {
 	u32 rq_mtt_cfg;
 	u64 sq_db_info_dma_addr;
 	u64 rq_db_info_dma_addr;
+
+	u64 sq_mtt_entry[3];
+	u64 rq_mtt_entry[3];
+
+	u32 db_cfg;
 };
 
 struct erdma_cmdq_destroy_qp_req {
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 376f70219ecd..ffc05ddc98ae 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -19,10 +19,11 @@
 #include "erdma_cm.h"
 #include "erdma_verbs.h"
 
-static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
+static int create_qp_cmd(struct erdma_ucontext *uctx, struct erdma_qp *qp)
 {
-	struct erdma_cmdq_create_qp_req req;
+	struct erdma_dev *dev = to_edev(qp->ibqp.device);
 	struct erdma_pd *pd = to_epd(qp->ibqp.pd);
+	struct erdma_cmdq_create_qp_req req;
 	struct erdma_uqp *user_qp;
 	u64 resp0, resp1;
 	int err;
@@ -93,6 +94,16 @@ static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
 
 		req.sq_db_info_dma_addr = user_qp->sq_db_info_dma_addr;
 		req.rq_db_info_dma_addr = user_qp->rq_db_info_dma_addr;
+
+		if (uctx->ext_db.enable) {
+			req.sq_cqn_mtt_cfg |=
+				FIELD_PREP(ERDMA_CMD_CREATE_QP_DB_CFG_MASK, 1);
+			req.db_cfg =
+				FIELD_PREP(ERDMA_CMD_CREATE_QP_SQDB_CFG_MASK,
+					   uctx->ext_db.sdb_off) |
+				FIELD_PREP(ERDMA_CMD_CREATE_QP_RQDB_CFG_MASK,
+					   uctx->ext_db.rdb_off);
+		}
 	}
 
 	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0,
@@ -146,11 +157,12 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 }
 
-static int create_cq_cmd(struct erdma_dev *dev, struct erdma_cq *cq)
+static int create_cq_cmd(struct erdma_ucontext *uctx, struct erdma_cq *cq)
 {
+	struct erdma_dev *dev = to_edev(cq->ibcq.device);
 	struct erdma_cmdq_create_cq_req req;
-	u32 page_size;
 	struct erdma_mem *mtt;
+	u32 page_size;
 
 	erdma_cmdq_build_reqhdr(&req.hdr, CMDQ_SUBMOD_RDMA,
 				CMDQ_OPCODE_CREATE_CQ);
@@ -192,6 +204,13 @@ static int create_cq_cmd(struct erdma_dev *dev, struct erdma_cq *cq)
 
 		req.first_page_offset = mtt->page_offset;
 		req.cq_db_info_addr = cq->user_cq.db_info_dma_addr;
+
+		if (uctx->ext_db.enable) {
+			req.cfg1 |= FIELD_PREP(
+				ERDMA_CMD_CREATE_CQ_MTT_DB_CFG_MASK, 1);
+			req.cfg2 = FIELD_PREP(ERDMA_CMD_CREATE_CQ_DB_CFG_MASK,
+					      uctx->ext_db.cdb_off);
+		}
 	}
 
 	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
@@ -753,7 +772,7 @@ int erdma_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
 	qp->attrs.state = ERDMA_QP_STATE_IDLE;
 	INIT_DELAYED_WORK(&qp->reflush_dwork, erdma_flush_worker);
 
-	ret = create_qp_cmd(dev, qp);
+	ret = create_qp_cmd(uctx, qp);
 	if (ret)
 		goto err_out_cmd;
 
@@ -1517,7 +1536,7 @@ int erdma_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
 			goto err_out_xa;
 	}
 
-	ret = create_cq_cmd(dev, cq);
+	ret = create_cq_cmd(ctx, cq);
 	if (ret)
 		goto err_free_res;
 
-- 
2.31.1

