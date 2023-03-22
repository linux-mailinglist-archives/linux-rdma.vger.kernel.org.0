Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700016C4680
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 10:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbjCVJda (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 05:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230130AbjCVJd2 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 05:33:28 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16E0D144AB
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 02:33:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R571e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeQMFvW_1679477604;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeQMFvW_1679477604)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 17:33:24 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 2/3] RDMA/erdma: Eliminate unnecessary casting of EQ doorbells
Date:   Wed, 22 Mar 2023 17:33:18 +0800
Message-Id: <20230322093319.84045-3-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230322093319.84045-1-chengyou@linux.alibaba.com>
References: <20230322093319.84045-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Using void * to define EQ doorbell pointer can eliminate unnecessary
casting when performing assignment. Also rename *db_addr* to *db* for a
shorter name.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h      | 2 +-
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 3 +--
 drivers/infiniband/hw/erdma/erdma_eq.c   | 9 ++++-----
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index 3d8c11aa23a2..e819e4032490 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -32,7 +32,7 @@ struct erdma_eq {
 	atomic64_t event_num;
 	atomic64_t notify_num;
 
-	u64 __iomem *db_addr;
+	void __iomem *db;
 	u64 *db_record;
 };
 
diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index 3fd33b85c15a..eb6aaf7e28f5 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -166,8 +166,7 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
 	spin_lock_init(&eq->lock);
 	atomic64_set(&eq->event_num, 0);
 
-	eq->db_addr =
-		(u64 __iomem *)(dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG);
+	eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG;
 	eq->db_record = (u64 *)(eq->qbuf + buf_size);
 
 	erdma_reg_write32(dev, ERDMA_REGS_CMDQ_EQ_ADDR_H_REG,
diff --git a/drivers/infiniband/hw/erdma/erdma_eq.c b/drivers/infiniband/hw/erdma/erdma_eq.c
index ed54130d924b..ea47cb21fdb8 100644
--- a/drivers/infiniband/hw/erdma/erdma_eq.c
+++ b/drivers/infiniband/hw/erdma/erdma_eq.c
@@ -14,7 +14,7 @@ void notify_eq(struct erdma_eq *eq)
 		      FIELD_PREP(ERDMA_EQDB_ARM_MASK, 1);
 
 	*eq->db_record = db_data;
-	writeq(db_data, eq->db_addr);
+	writeq(db_data, eq->db);
 
 	atomic64_inc(&eq->notify_num);
 }
@@ -98,7 +98,7 @@ int erdma_aeq_init(struct erdma_dev *dev)
 	atomic64_set(&eq->event_num, 0);
 	atomic64_set(&eq->notify_num, 0);
 
-	eq->db_addr = (u64 __iomem *)(dev->func_bar + ERDMA_REGS_AEQ_DB_REG);
+	eq->db = dev->func_bar + ERDMA_REGS_AEQ_DB_REG;
 	eq->db_record = (u64 *)(eq->qbuf + buf_size);
 
 	erdma_reg_write32(dev, ERDMA_REGS_AEQ_ADDR_H_REG,
@@ -243,9 +243,8 @@ static int erdma_ceq_init_one(struct erdma_dev *dev, u16 ceqn)
 	atomic64_set(&eq->notify_num, 0);
 
 	eq->depth = ERDMA_DEFAULT_EQ_DEPTH;
-	eq->db_addr =
-		(u64 __iomem *)(dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG +
-				(ceqn + 1) * ERDMA_DB_SIZE);
+	eq->db = dev->func_bar + ERDMA_REGS_CEQ_DB_BASE_REG +
+		 (ceqn + 1) * ERDMA_DB_SIZE;
 	eq->db_record = (u64 *)(eq->qbuf + buf_size);
 	eq->ci = 0;
 	dev->ceqs[ceqn].dev = dev;
-- 
2.31.1

