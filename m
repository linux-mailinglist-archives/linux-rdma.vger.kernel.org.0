Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FB356C4682
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 10:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjCVJdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230145AbjCVJda (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 05:33:30 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2672E13DD4
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 02:33:25 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeQKm7A_1679477602;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeQKm7A_1679477602)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 17:33:23 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/3] RDMA/erdma: Unify byte ordering APIs usage
Date:   Wed, 22 Mar 2023 17:33:17 +0800
Message-Id: <20230322093319.84045-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230322093319.84045-1-chengyou@linux.alibaba.com>
References: <20230322093319.84045-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        URIBL_BLOCKED,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replace __be32_to_cpu/__cpu_to_be16 with be32_to_cpu/cpu_to_be16.
And use be32_to_cpu_array to copy and swap byte order to hide the
loop.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cm.h   | 10 +++++-----
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 12 +++++-------
 drivers/infiniband/hw/erdma/erdma_cq.c   |  2 +-
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cm.h b/drivers/infiniband/hw/erdma/erdma_cm.h
index 8a3f998fec9b..a26d80770188 100644
--- a/drivers/infiniband/hw/erdma/erdma_cm.h
+++ b/drivers/infiniband/hw/erdma/erdma_cm.h
@@ -33,11 +33,11 @@ struct mpa_rr_params {
  * MPA request/response Hdr bits & fields
  */
 enum {
-	MPA_RR_FLAG_MARKERS = __cpu_to_be16(0x8000),
-	MPA_RR_FLAG_CRC = __cpu_to_be16(0x4000),
-	MPA_RR_FLAG_REJECT = __cpu_to_be16(0x2000),
-	MPA_RR_RESERVED = __cpu_to_be16(0x1f00),
-	MPA_RR_MASK_REVISION = __cpu_to_be16(0x00ff)
+	MPA_RR_FLAG_MARKERS = cpu_to_be16(0x8000),
+	MPA_RR_FLAG_CRC = cpu_to_be16(0x4000),
+	MPA_RR_FLAG_REJECT = cpu_to_be16(0x2000),
+	MPA_RR_RESERVED = cpu_to_be16(0x1f00),
+	MPA_RR_MASK_REVISION = cpu_to_be16(0x00ff)
 };
 
 /*
diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index 6ebfa6989b11..3fd33b85c15a 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -283,7 +283,7 @@ static void *get_next_valid_cmdq_cqe(struct erdma_cmdq *cmdq)
 	__be32 *cqe = get_queue_entry(cmdq->cq.qbuf, cmdq->cq.ci,
 				      cmdq->cq.depth, CQE_SHIFT);
 	u32 owner = FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK,
-			      __be32_to_cpu(READ_ONCE(*cqe)));
+			      be32_to_cpu(READ_ONCE(*cqe)));
 
 	return owner ^ !!(cmdq->cq.ci & cmdq->cq.depth) ? cqe : NULL;
 }
@@ -319,7 +319,6 @@ static int erdma_poll_single_cmd_completion(struct erdma_cmdq *cmdq)
 	__be32 *cqe;
 	u16 ctx_id;
 	u64 *sqe;
-	int i;
 
 	cqe = get_next_valid_cmdq_cqe(cmdq);
 	if (!cqe)
@@ -328,8 +327,8 @@ static int erdma_poll_single_cmd_completion(struct erdma_cmdq *cmdq)
 	cmdq->cq.ci++;
 
 	dma_rmb();
-	hdr0 = __be32_to_cpu(*cqe);
-	sqe_idx = __be32_to_cpu(*(cqe + 1));
+	hdr0 = be32_to_cpu(*cqe);
+	sqe_idx = be32_to_cpu(*(cqe + 1));
 
 	sqe = get_queue_entry(cmdq->sq.qbuf, sqe_idx, cmdq->sq.depth,
 			      SQEBB_SHIFT);
@@ -341,9 +340,8 @@ static int erdma_poll_single_cmd_completion(struct erdma_cmdq *cmdq)
 	comp_wait->cmd_status = ERDMA_CMD_STATUS_FINISHED;
 	comp_wait->comp_status = FIELD_GET(ERDMA_CQE_HDR_SYNDROME_MASK, hdr0);
 	cmdq->sq.ci += cmdq->sq.wqebb_cnt;
-
-	for (i = 0; i < 4; i++)
-		comp_wait->comp_data[i] = __be32_to_cpu(*(cqe + 2 + i));
+	/* Copy 16B comp data after cqe hdr to outer */
+	be32_to_cpu_array(comp_wait->comp_data, cqe + 2, 4);
 
 	if (cmdq->use_event)
 		complete(&comp_wait->wait_event);
diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
index cabd8678b355..7e2bfa6ed86f 100644
--- a/drivers/infiniband/hw/erdma/erdma_cq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -11,7 +11,7 @@ static void *get_next_valid_cqe(struct erdma_cq *cq)
 	__be32 *cqe = get_queue_entry(cq->kern_cq.qbuf, cq->kern_cq.ci,
 				      cq->depth, CQE_SHIFT);
 	u32 owner = FIELD_GET(ERDMA_CQE_HDR_OWNER_MASK,
-			      __be32_to_cpu(READ_ONCE(*cqe)));
+			      be32_to_cpu(READ_ONCE(*cqe)));
 
 	return owner ^ !!(cq->kern_cq.ci & cq->depth) ? cqe : NULL;
 }
-- 
2.31.1

