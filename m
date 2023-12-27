Return-Path: <linux-rdma+bounces-501-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B8081ED6A
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Dec 2023 09:48:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52981F22D5E
	for <lists+linux-rdma@lfdr.de>; Wed, 27 Dec 2023 08:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A23290A;
	Wed, 27 Dec 2023 08:48:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FE85666
	for <linux-rdma@vger.kernel.org>; Wed, 27 Dec 2023 08:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VzKTmei_1703666881;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0VzKTmei_1703666881)
          by smtp.aliyun-inc.com;
          Wed, 27 Dec 2023 16:48:02 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next v3 1/2] RDMA/erdma: Introduce dma pool for hardware responses of CMDQ requests
Date: Wed, 27 Dec 2023 16:47:59 +0800
Message-Id: <20231227084800.99091-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231227084800.99091-1-chengyou@linux.alibaba.com>
References: <20231227084800.99091-1-chengyou@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hardware response, such as the result of query statistics, may be too
long to be directly accommodated within the CQE structure. To address
this, we introduce a DMA pool to hold the hardware's responses of CMDQ
requests.

Signed-off-by: Cheng Xu <chengyou@linux.alibaba.com>
---
 drivers/infiniband/hw/erdma/erdma.h      |  2 ++
 drivers/infiniband/hw/erdma/erdma_hw.h   |  2 ++
 drivers/infiniband/hw/erdma/erdma_main.c | 24 ++++++++++++++++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/erdma/erdma.h b/drivers/infiniband/hw/erdma/erdma.h
index f190111840e9..5df401a30cb9 100644
--- a/drivers/infiniband/hw/erdma/erdma.h
+++ b/drivers/infiniband/hw/erdma/erdma.h
@@ -212,6 +212,8 @@ struct erdma_dev {
 
 	atomic_t num_ctx;
 	struct list_head cep_list;
+
+	struct dma_pool *resp_pool;
 };
 
 static inline void *get_queue_entry(void *qbuf, u32 idx, u32 depth, u32 shift)
diff --git a/drivers/infiniband/hw/erdma/erdma_hw.h b/drivers/infiniband/hw/erdma/erdma_hw.h
index 9d316fdc6f9a..4baabf1f2b08 100644
--- a/drivers/infiniband/hw/erdma/erdma_hw.h
+++ b/drivers/infiniband/hw/erdma/erdma_hw.h
@@ -357,6 +357,8 @@ struct erdma_cmdq_reflush_req {
 	u32 rq_pi;
 };
 
+#define ERDMA_HW_RESP_SIZE 256
+
 /* cap qword 0 definition */
 #define ERDMA_CMD_DEV_CAP_MAX_CQE_MASK GENMASK_ULL(47, 40)
 #define ERDMA_CMD_DEV_CAP_FLAGS_MASK GENMASK_ULL(31, 24)
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 0880c79a978c..e4df5bf89cd0 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -172,14 +172,30 @@ static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
 {
 	int ret;
 
+	dev->resp_pool = dma_pool_create("erdma_resp_pool", &pdev->dev,
+					 ERDMA_HW_RESP_SIZE, ERDMA_HW_RESP_SIZE,
+					 0);
+	if (!dev->resp_pool)
+		return -ENOMEM;
+
 	ret = dma_set_mask_and_coherent(&pdev->dev,
 					DMA_BIT_MASK(ERDMA_PCI_WIDTH));
 	if (ret)
-		return ret;
+		goto destroy_pool;
 
 	dma_set_max_seg_size(&pdev->dev, UINT_MAX);
 
 	return 0;
+
+destroy_pool:
+	dma_pool_destroy(dev->resp_pool);
+
+	return ret;
+}
+
+static void erdma_device_uninit(struct erdma_dev *dev)
+{
+	dma_pool_destroy(dev->resp_pool);
 }
 
 static void erdma_hw_reset(struct erdma_dev *dev)
@@ -273,7 +289,7 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 
 	err = erdma_request_vectors(dev);
 	if (err)
-		goto err_iounmap_func_bar;
+		goto err_uninit_device;
 
 	err = erdma_comm_irq_init(dev);
 	if (err)
@@ -314,6 +330,9 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 err_free_vectors:
 	pci_free_irq_vectors(dev->pdev);
 
+err_uninit_device:
+	erdma_device_uninit(dev);
+
 err_iounmap_func_bar:
 	devm_iounmap(&pdev->dev, dev->func_bar);
 
@@ -339,6 +358,7 @@ static void erdma_remove_dev(struct pci_dev *pdev)
 	erdma_aeq_destroy(dev);
 	erdma_comm_irq_uninit(dev);
 	pci_free_irq_vectors(dev->pdev);
+	erdma_device_uninit(dev);
 
 	devm_iounmap(&pdev->dev, dev->func_bar);
 	pci_release_selected_regions(pdev, ERDMA_BAR_MASK);
-- 
2.31.1


