Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCFF65B3423
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Sep 2022 11:39:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231521AbiIIJim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Sep 2022 05:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiIIJia (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Sep 2022 05:38:30 -0400
Received: from out199-8.us.a.mail.aliyun.com (out199-8.us.a.mail.aliyun.com [47.90.199.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2F7FA0266
        for <linux-rdma@vger.kernel.org>; Fri,  9 Sep 2022 02:38:28 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VP8mhQ8_1662716304;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VP8mhQ8_1662716304)
          by smtp.aliyun-inc.com;
          Fri, 09 Sep 2022 17:38:25 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/4] RDMA/erdma: Eliminate unnecessary casting for erdma_post_cmd_wait
Date:   Fri,  9 Sep 2022 17:38:19 +0800
Message-Id: <20220909093822.33868-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220909093822.33868-1-chengyou@linux.alibaba.com>
References: <20220909093822.33868-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

erdma_post_cmd_wait does not use the 'u64 *req' input parameter directly.
So it is better to define it to 'void *req', and by this we can eliminate
the casting when calling erdma_post_cmd_wait.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h       |  2 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c  |  2 +-
 drivers/infiniband/hw/erdma/erdma_eq.c    |  7 ++-----
 drivers/infiniband/hw/erdma/erdma_qp.c    |  6 ++----
 drivers/infiniband/hw/erdma/erdma_verbs.c | 17 ++++++-----------
 5 files changed, 12 insertions(+), 22 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 2aae635c1c8d..07bcd688fdb7 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -269,7 +269,7 @@ void erdma_finish_cmdq_init(struct erdma_dev *dev);
 void erdma_cmdq_destroy(struct erdma_dev *dev);
 
 void erdma_cmdq_build_reqhdr(u64 *hdr, u32 mod, u32 op);
-int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, u64 *req, u32 req_size,
+int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, void *req, u32 req_size,
 			u64 *resp0, u64 *resp1);
 void erdma_cmdq_completion_handler(struct erdma_cmdq *cmdq);
 
diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index 57da0c670472..c8f93dc11449 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -441,7 +441,7 @@ void erdma_cmdq_build_reqhdr(u64 *hdr, u32 mod, u32 op)
 	       FIELD_PREP(ERDMA_CMD_HDR_OPCODE_MASK, op);
 }
 
-int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, u64 *req, u32 req_size,
+int erdma_post_cmd_wait(struct erdma_cmdq *cmdq, void *req, u32 req_size,
 			u64 *resp0, u64 *resp1)
 {
 	struct erdma_comp_wait *comp_wait;
diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
index 8f2d094e0227..09ddedb5c1b5 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -229,9 +229,7 @@ static int create_eq_cmd(struct erdma_dev *dev, u32 eqn, struct erdma_eq *eq)
 	req.db_dma_addr_l = lower_32_bits(db_info_dma_addr);
 	req.db_dma_addr_h = upper_32_bits(db_info_dma_addr);
 
-	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req,
-				   sizeof(struct erdma_cmdq_create_eq_req),
-				   NULL, NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 }
 
 static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
@@ -281,8 +279,7 @@ static void erdma_ceq_uninit_one(struct erdma_dev *dev, u16 ceqn)
 	req.qtype = ERDMA_EQ_TYPE_CEQ;
 	req.vector_idx = ceqn + 1;
 
-	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				  NULL);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 	if (err)
 		return;
 
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index bc3ec22a62c5..60f898ccc4e4 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -105,8 +105,7 @@ static int erdma_modify_qp_state_to_rts(struct erdma_qp *qp,
 		req.send_nxt += MPA_DEFAULT_HDR_LEN + qp->attrs.pd_len;
 	req.recv_nxt = tp->rcv_nxt;
 
-	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				   NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 }
 
 static int erdma_modify_qp_state_to_stop(struct erdma_qp *qp,
@@ -124,8 +123,7 @@ static int erdma_modify_qp_state_to_stop(struct erdma_qp *qp,
 	req.cfg = FIELD_PREP(ERDMA_CMD_MODIFY_QP_STATE_MASK, attrs->state) |
 		  FIELD_PREP(ERDMA_CMD_MODIFY_QP_QPN_MASK, QP_ID(qp));
 
-	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				   NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 }
 
 int erdma_modify_qp_internal(struct erdma_qp *qp, struct erdma_qp_attrs *attrs,
diff --git a/drivers/infiniband/hw/erdma/erdma_verbs.c b/drivers/infiniband/hw/erdma/erdma_verbs.c
index 699bd3f59cd3..d04b90549cd6 100644
--- a/drivers/infiniband/hw/erdma/erdma_verbs.c
+++ b/drivers/infiniband/hw/erdma/erdma_verbs.c
@@ -102,7 +102,7 @@ static int create_qp_cmd(struct erdma_dev *dev, struct erdma_qp *qp)
 		req.rq_db_info_dma_addr = user_qp->rq_db_info_dma_addr;
 	}
 
-	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), &resp0,
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), &resp0,
 				  &resp1);
 	if (!err)
 		qp->attrs.cookie =
@@ -151,8 +151,7 @@ static int regmr_cmd(struct erdma_dev *dev, struct erdma_mr *mr)
 	}
 
 post_cmd:
-	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				   NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 }
 
 static int create_cq_cmd(struct erdma_dev *dev, struct erdma_cq *cq)
@@ -202,8 +201,7 @@ static int create_cq_cmd(struct erdma_dev *dev, struct erdma_cq *cq)
 		req.cq_db_info_addr = cq->user_cq.db_info_dma_addr;
 	}
 
-	return erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				   NULL);
+	return erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 }
 
 static int erdma_alloc_idx(struct erdma_resource_cb *res_cb)
@@ -976,8 +974,7 @@ int erdma_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	req.cfg = FIELD_PREP(ERDMA_CMD_MR_MPT_IDX_MASK, ibmr->lkey >> 8) |
 		  FIELD_PREP(ERDMA_CMD_MR_KEY_MASK, ibmr->lkey & 0xFF);
 
-	ret = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				  NULL);
+	ret = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 	if (ret)
 		return ret;
 
@@ -1002,8 +999,7 @@ int erdma_destroy_cq(struct ib_cq *ibcq, struct ib_udata *udata)
 				CMDQ_OPCODE_DESTROY_CQ);
 	req.cqn = cq->cqn;
 
-	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				  NULL);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 	if (err)
 		return err;
 
@@ -1040,8 +1036,7 @@ int erdma_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
 				CMDQ_OPCODE_DESTROY_QP);
 	req.qpn = QP_ID(qp);
 
-	err = erdma_post_cmd_wait(&dev->cmdq, (u64 *)&req, sizeof(req), NULL,
-				  NULL);
+	err = erdma_post_cmd_wait(&dev->cmdq, &req, sizeof(req), NULL, NULL);
 	if (err)
 		return err;
 
-- 
2.27.0

