Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFA576C4681
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Mar 2023 10:33:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbjCVJdb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Mar 2023 05:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230182AbjCVJda (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Mar 2023 05:33:30 -0400
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0292F16AD6
        for <linux-rdma@vger.kernel.org>; Wed, 22 Mar 2023 02:33:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VeQKm8._1679477605;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VeQKm8._1679477605)
          by smtp.aliyun-inc.com;
          Wed, 22 Mar 2023 17:33:25 +0800
From:   Cheng Xu <chengyou@linux.alibaba.com>
To:     jgg@ziepe.ca, leon@kernel.org
Cc:     linux-rdma@vger.kernel.org, KaiShen@linux.alibaba.com
Subject: [PATCH for-next 3/3] RDMA/erdma: Minor refactor of device init flow
Date:   Wed, 22 Mar 2023 17:33:19 +0800
Message-Id: <20230322093319.84045-4-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20230322093319.84045-1-chengyou@linux.alibaba.com>
References: <20230322093319.84045-1-chengyou@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

After necessary configuration, driver should wait hardware finishing
initialization. The wait sets at CMDQ related function though it has
nothing to do with CMDQ. Refactor this part to make code cleaner.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma_cmdq.c | 27 +---------------
 drivers/infiniband/hw/erdma/erdma_main.c | 39 ++++++++++++++++++++----
 2 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma_cmdq.c b/drivers/infiniband/hw/erdma/erdma_cmdq.c
index eb6aaf7e28f5..a151a7bdd504 100644
--- a/drivers/infiniband/hw/erdma/erdma_cmdq.c
+++ b/drivers/infiniband/hw/erdma/erdma_cmdq.c
@@ -182,9 +182,8 @@ static int erdma_cmdq_eq_init(struct erdma_dev *dev)
 
 int erdma_cmdq_init(struct erdma_dev *dev)
 {
-	int err, i;
 	struct erdma_cmdq *cmdq = &dev->cmdq;
-	u32 sts, ctrl;
+	int err;
 
 	cmdq->max_outstandings = ERDMA_CMDQ_MAX_OUTSTANDING;
 	cmdq->use_event = false;
@@ -207,34 +206,10 @@ int erdma_cmdq_init(struct erdma_dev *dev)
 	if (err)
 		goto err_destroy_cq;
 
-	ctrl = FIELD_PREP(ERDMA_REG_DEV_CTRL_INIT_MASK, 1);
-	erdma_reg_write32(dev, ERDMA_REGS_DEV_CTRL_REG, ctrl);
-
-	for (i = 0; i < ERDMA_WAIT_DEV_DONE_CNT; i++) {
-		sts = erdma_reg_read32_filed(dev, ERDMA_REGS_DEV_ST_REG,
-					     ERDMA_REG_DEV_ST_INIT_DONE_MASK);
-		if (sts)
-			break;
-
-		msleep(ERDMA_REG_ACCESS_WAIT_MS);
-	}
-
-	if (i == ERDMA_WAIT_DEV_DONE_CNT) {
-		dev_err(&dev->pdev->dev, "wait init done failed.\n");
-		err = -ETIMEDOUT;
-		goto err_destroy_eq;
-	}
-
 	set_bit(ERDMA_CMDQ_STATE_OK_BIT, &cmdq->state);
 
 	return 0;
 
-err_destroy_eq:
-	dma_free_coherent(&dev->pdev->dev,
-			  (cmdq->eq.depth << EQE_SHIFT) +
-				  ERDMA_EXTRA_BUFFER_SIZE,
-			  cmdq->eq.qbuf, cmdq->eq.qbuf_dma_addr);
-
 err_destroy_cq:
 	dma_free_coherent(&dev->pdev->dev,
 			  (cmdq->cq.depth << CQE_SHIFT) +
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 5dc31e5df5cb..2c8fd00b0816 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -211,13 +211,36 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
 	return 0;
 }
 
-static void erdma_device_uninit(struct erdma_dev *dev)
+static void erdma_hw_reset(struct erdma_dev *dev)
 {
 	u32 ctrl = FIELD_PREP(ERDMA_REG_DEV_CTRL_RESET_MASK, 1);
 
 	erdma_reg_write32(dev, ERDMA_REGS_DEV_CTRL_REG, ctrl);
 }
 
+static int erdma_wait_hw_init_done(struct erdma_dev *dev)
+{
+	int i;
+
+	erdma_reg_write32(dev, ERDMA_REGS_DEV_CTRL_REG,
+			  FIELD_PREP(ERDMA_REG_DEV_CTRL_INIT_MASK, 1));
+
+	for (i = 0; i < ERDMA_WAIT_DEV_DONE_CNT; i++) {
+		if (erdma_reg_read32_filed(dev, ERDMA_REGS_DEV_ST_REG,
+					   ERDMA_REG_DEV_ST_INIT_DONE_MASK))
+			break;
+
+		msleep(ERDMA_REG_ACCESS_WAIT_MS);
+	}
+
+	if (i == ERDMA_WAIT_DEV_DONE_CNT) {
+		dev_err(&dev->pdev->dev, "wait init done failed.\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
 static const struct pci_device_id erdma_pci_tbl[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_ALIBABA, 0x107f) },
 	{}
@@ -293,16 +316,22 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 	if (err)
 		goto err_uninit_aeq;
 
-	err = erdma_ceqs_init(dev);
+	err = erdma_wait_hw_init_done(dev);
 	if (err)
 		goto err_uninit_cmdq;
 
+	err = erdma_ceqs_init(dev);
+	if (err)
+		goto err_reset_hw;
+
 	erdma_finish_cmdq_init(dev);
 
 	return 0;
 
+err_reset_hw:
+	erdma_hw_reset(dev);
+
 err_uninit_cmdq:
-	erdma_device_uninit(dev);
 	erdma_cmdq_destroy(dev);
 
 err_uninit_aeq:
@@ -334,9 +363,7 @@ static void erdma_remove_dev(struct pci_dev *pdev)
 	struct erdma_dev *dev = pci_get_drvdata(pdev);
 
 	erdma_ceqs_uninit(dev);
-
-	erdma_device_uninit(dev);
-
+	erdma_hw_reset(dev);
 	erdma_cmdq_destroy(dev);
 	erdma_aeq_destroy(dev);
 	erdma_comm_irq_uninit(dev);
-- 
2.31.1

