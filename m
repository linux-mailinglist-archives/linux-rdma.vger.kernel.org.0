Return-Path: <linux-rdma+bounces-468-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB31819AED
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 09:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AB37282CC5
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Dec 2023 08:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A3C71C29E;
	Wed, 20 Dec 2023 08:54:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2321CAB3
	for <linux-rdma@vger.kernel.org>; Wed, 20 Dec 2023 08:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R261e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=chengyou@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0Vyteaxa_1703062466;
Received: from localhost(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0Vyteaxa_1703062466)
          by smtp.aliyun-inc.com;
          Wed, 20 Dec 2023 16:54:26 +0800
From: Cheng Xu <chengyou@linux.alibaba.com>
To: jgg@ziepe.ca,
	leon@kernel.org
Cc: linux-rdma@vger.kernel.org,
	KaiShen@linux.alibaba.com
Subject: [PATCH for-next 1/2] RDMA/erdma: Introduce dma pool for hardware responses of CMDQ requests
Date: Wed, 20 Dec 2023 16:54:23 +0800
Message-Id: <20231220085424.97407-2-chengyou@linux.alibaba.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231220085424.97407-1-chengyou@linux.alibaba.com>
References: <20231220085424.97407-1-chengyou@linux.alibaba.com>
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
 drivers/infiniband/hw/erdma/erdma_main.c | 38 ++++++++++++++++++++++--
 2 files changed, 38 insertions(+), 2 deletions(-)

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
diff --git a/drivers/infiniband/hw/erdma/erdma_main.c b/drivers/infiniband/hw/erdma/erdma_main.c
index 0880c79a978c..541e77aea494 100644
--- a/drivers/infiniband/hw/erdma/erdma_main.c
+++ b/drivers/infiniband/hw/erdma/erdma_main.c
@@ -168,18 +168,48 @@ static void erdma_comm_irq_uninit(struct erdma_dev *dev)
 	free_irq(dev->comm_irq.msix_vector, dev);
 }
 
+static int erdma_dma_pools_init(struct erdma_dev *dev)
+{
+	dev->resp_pool = dma_pool_create("erdma_resp_pool", &dev->pdev->dev,
+					 ERDMA_HW_RESP_SIZE, ERDMA_HW_RESP_SIZE,
+					 0);
+	if (!dev->resp_pool)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void erdma_dma_pools_destroy(struct erdma_dev *dev)
+{
+	dma_pool_destroy(dev->resp_pool);
+}
+
 static int erdma_device_init(struct erdma_dev *dev, struct pci_dev *pdev)
 {
 	int ret;
 
+	ret = erdma_dma_pools_init(dev);
+	if (ret)
+		return ret;
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
+	erdma_dma_pools_destroy(dev);
+
+	return ret;
+}
+
+static void erdma_device_uninit(struct erdma_dev *dev)
+{
+	erdma_dma_pools_destroy(dev);
 }
 
 static void erdma_hw_reset(struct erdma_dev *dev)
@@ -273,7 +303,7 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 
 	err = erdma_request_vectors(dev);
 	if (err)
-		goto err_iounmap_func_bar;
+		goto err_uninit_device;
 
 	err = erdma_comm_irq_init(dev);
 	if (err)
@@ -314,6 +344,9 @@ static int erdma_probe_dev(struct pci_dev *pdev)
 err_free_vectors:
 	pci_free_irq_vectors(dev->pdev);
 
+err_uninit_device:
+	erdma_device_uninit(dev);
+
 err_iounmap_func_bar:
 	devm_iounmap(&pdev->dev, dev->func_bar);
 
@@ -339,6 +372,7 @@ static void erdma_remove_dev(struct pci_dev *pdev)
 	erdma_aeq_destroy(dev);
 	erdma_comm_irq_uninit(dev);
 	pci_free_irq_vectors(dev->pdev);
+	erdma_device_uninit(dev);
 
 	devm_iounmap(&pdev->dev, dev->func_bar);
 	pci_release_selected_regions(pdev, ERDMA_BAR_MASK);
-- 
2.31.1


