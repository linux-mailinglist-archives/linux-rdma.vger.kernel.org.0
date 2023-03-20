Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426FA6C0C73
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Mar 2023 09:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjCTIrE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Mar 2023 04:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbjCTIrE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Mar 2023 04:47:04 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38226B3
        for <linux-rdma@vger.kernel.org>; Mon, 20 Mar 2023 01:47:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeEsA0l_1679302017;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeEsA0l_1679302017)
          by smtp.aliyun-inc.com;
          Mon, 20 Mar 2023 16:46:58 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-rc 1/4] RDMA/erdma: Fix some typos
Date:   Mon, 20 Mar 2023 16:46:49 +0800
Message-Id: <20230320084652.16807-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230320084652.16807-1-chengyou@linux.alibaba.com>
References: <20230320084652.16807-1-chengyou@linux.alibaba.com>
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

FAA is short for atomic fetch and add, not FAD. Fix this.

Fixes: 0ca9c2e2844a ("RDMA/erdma: Implement atomic operations support")
Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cq.c | 2 +-
 drivers/infiniband/hw/erdma/erdma_hw.h | 2 +-
 drivers/infiniband/hw/erdma/erdma_qp.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cq.c b/drivers/infiniband/hw/erdma/erdma_cq.c
index cabd8678b355..7bc354273d4e 100644
--- a/drivers/infiniband/hw/erdma/erdma_cq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cq.c
@@ -65,7 +65,7 @@ static const enum ib_wc_opcode wc_mapping_table[ERDMA_NUM_OPCODES] = {
 	[ERDMA_OP_LOCAL_INV] = IB_WC_LOCAL_INV,
 	[ERDMA_OP_READ_WITH_INV] = IB_WC_RDMA_READ,
 	[ERDMA_OP_ATOMIC_CAS] = IB_WC_COMP_SWAP,
-	[ERDMA_OP_ATOMIC_FAD] = IB_WC_FETCH_ADD,
+	[ERDMA_OP_ATOMIC_FAA] = IB_WC_FETCH_ADD,
 };
 
 static const struct {
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 4c38d99c73f1..5d3a541db941 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -491,7 +491,7 @@ enum erdma_opcode {
 	ERDMA_OP_LOCAL_INV = 15,
 	ERDMA_OP_READ_WITH_INV = 16,
 	ERDMA_OP_ATOMIC_CAS = 17,
-	ERDMA_OP_ATOMIC_FAD = 18,
+	ERDMA_OP_ATOMIC_FAA = 18,
 	ERDMA_NUM_OPCODES = 19,
 	ERDMA_OP_INVALID = ERDMA_NUM_OPCODES + 1
 };
diff --git a/drivers/infiniband/hw/erdma/erdma_qp.c b/drivers/infiniband/hw/erdma/erdma_qp.c
index d088d6bef431..ff473b208acf 100644
--- a/drivers/infiniband/hw/erdma/erdma_qp.c
+++ b/drivers/infiniband/hw/erdma/erdma_qp.c
@@ -439,7 +439,7 @@ static int erdma_push_one_sqe(struct erdma_qp *qp, u16 *pi,
 				cpu_to_le64(atomic_wr(send_wr)->compare_add);
 		} else {
 			wqe_hdr |= FIELD_PREP(ERDMA_SQE_HDR_OPCODE_MASK,
-					      ERDMA_OP_ATOMIC_FAD);
+					      ERDMA_OP_ATOMIC_FAA);
 			atomic_sqe->fetchadd_swap_data =
 				cpu_to_le64(atomic_wr(send_wr)->compare_add);
 		}
-- 
2.31.1

