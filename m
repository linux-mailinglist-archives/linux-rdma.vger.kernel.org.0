Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD54B60F42C
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Oct 2022 11:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbiJ0J6o (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Oct 2022 05:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235095AbiJ0J6L (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 27 Oct 2022 05:58:11 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCDC95E6B
        for <linux-rdma@vger.kernel.org>; Thu, 27 Oct 2022 02:57:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VTB5jTO_1666864663;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VTB5jTO_1666864663)
          by smtp.aliyun-inc.com;
          Thu, 27 Oct 2022 17:57:44 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/3] RDMA/erdma: Extend access right field of FRMR and REG MR to support atomic
Date:   Thu, 27 Oct 2022 17:57:39 +0800
Message-Id: <20221027095741.48044-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20221027095741.48044-1-chengyou@linux.alibaba.com>
References: <20221027095741.48044-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

To support atomic operations, IB_ACCESS_REMOTE_ATOMIC right should be
passed to hardware for permission check. Since "access mode" field in FRMR
SQE and RegMr command is never used by hw, we remove the "access mode"
field, so that we can then have enough space to extend access fields.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_hw.h    |  6 ++----
 drivers/infiniband/hw/erdma/erdma_qp.c    |  3 +--
 drivers/infiniband/hw/erdma/erdma_verbs.c |  3 +--
 drivers/infiniband/hw/erdma/erdma_verbs.h | 12 +++++++-----
 4 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index e788887732e1..2a9a4c73d52c 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -224,8 +224,7 @@ struct erdma_cmdq_create_cq_req {
 /* regmr cfg1 */
 #define ERDMA_CMD_REGMR_PD_MASK GENMASK(31, 12)
 #define ERDMA_CMD_REGMR_TYPE_MASK GENMASK(7, 6)
-#define ERDMA_CMD_REGMR_RIGHT_MASK GENMASK(5, 2)
-#define ERDMA_CMD_REGMR_ACC_MODE_MASK GENMASK(1, 0)
+#define ERDMA_CMD_REGMR_RIGHT_MASK GENMASK(5, 1)
 
 /* regmr cfg2 */
 #define ERDMA_CMD_REGMR_PAGESIZE_MASK GENMASK(31, 27)
@@ -370,8 +369,7 @@ struct erdma_rqe {
 #define ERDMA_SQE_HDR_WQEBB_INDEX_MASK GENMASK_ULL(15, 0)
 
 /* REG MR attrs */
-#define ERDMA_SQE_MR_MODE_MASK GENMASK(1, 0)
-#define ERDMA_SQE_MR_ACCESS_MASK GENMASK(5, 2)
+#define ERDMA_SQE_MR_ACCESS_MASK GENMASK(5, 1)
 #define ERDMA_SQE_MR_MTT_TYPE_MASK GENMASK(7, 6)
 #define ERDMA_SQE_MR_MTT_CNT_MASK GENMASK(31, 12)
 
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index 5fe1a339a435..c7f343173cb9 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -397,8 +397,7 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 		regmr_sge->addr = cpu_to_le64(mr->ibmr.iova);
 		regmr_sge->length = cpu_to_le32(mr->ibmr.length);
 		regmr_sge->stag = cpu_to_le32(reg_wr(send_wr)->key);
-		attrs = FIELD_PREP(ERDMA_SQE_MR_MODE_MASK, 0) |
-			FIELD_PREP(ERDMA_SQE_MR_ACCESS_MASK, mr->access) |
+		attrs = FIELD_PREP(ERDMA_SQE_MR_ACCESS_MASK, mr->access) |
 			FIELD_PREP(ERDMA_SQE_MR_MTT_CNT_MASK,
 				   mr->mem.mtt_nents);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 62be98e2b941..f3bf87f17527 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -118,8 +118,7 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 		   FIELD_PREP(ERDMA_CMD_MR_MPT_IDX_MASK, mr->ibmr.lkey >> 8);
 	req.cfg1 = FIELD_PREP(ERDMA_CMD_REGMR_PD_MASK, pd->pdn) |
 		   FIELD_PREP(ERDMA_CMD_REGMR_TYPE_MASK, mr->type) |
-		   FIELD_PREP(ERDMA_CMD_REGMR_RIGHT_MASK, mr->access) |
-		   FIELD_PREP(ERDMA_CMD_REGMR_ACC_MODE_MASK, 0);
+		   FIELD_PREP(ERDMA_CMD_REGMR_RIGHT_MASK, mr->access);
 	req.cfg2 = FIELD_PREP(ERDMA_CMD_REGMR_PAGESIZE_MASK,
 			      ilog2(mr->mem.page_size)) |
 		   FIELD_PREP(ERDMA_CMD_REGMR_MTT_TYPE_MASK, mr->mem.mtt_type) |
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.h b/drivers/infiniband/hw/erdma/erdma_verbs.h
index ab6380635e9e..a5574f0252bb 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.h
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.h
@@ -71,16 +71,18 @@ struct erdma_pd {
 #define ERDMA_MR_INLINE_MTT 0
 #define ERDMA_MR_INDIRECT_MTT 1
 
-#define ERDMA_MR_ACC_LR BIT(0)
-#define ERDMA_MR_ACC_LW BIT(1)
-#define ERDMA_MR_ACC_RR BIT(2)
-#define ERDMA_MR_ACC_RW BIT(3)
+#define ERDMA_MR_ACC_RA BIT(0)
+#define ERDMA_MR_ACC_LR BIT(1)
+#define ERDMA_MR_ACC_LW BIT(2)
+#define ERDMA_MR_ACC_RR BIT(3)
+#define ERDMA_MR_ACC_RW BIT(4)
 
 static inline u8 to_erdma_access_flags(int access)
 {
 	return (access & IB_ACCESS_REMOTE_READ ? ERDMA_MR_ACC_RR : 0) |
 	       (access & IB_ACCESS_LOCAL_WRITE ? ERDMA_MR_ACC_LW : 0) |
-	       (access & IB_ACCESS_REMOTE_WRITE ? ERDMA_MR_ACC_RW : 0);
+	       (access & IB_ACCESS_REMOTE_WRITE ? ERDMA_MR_ACC_RW : 0) |
+	       (access & IB_ACCESS_REMOTE_ATOMIC ? ERDMA_MR_ACC_RA : 0);
 }
 
 struct erdma_mem {
-- 
2.27.0

