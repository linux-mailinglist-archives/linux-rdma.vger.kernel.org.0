Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEFF37F694
	for <lists+linux-rdma@lfdr.de>; Thu, 13 May 2021 13:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhEMLRl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 May 2021 07:17:41 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:2476 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233301AbhEMLRi (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 May 2021 07:17:38 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Fgptx5CH1zBvB1;
        Thu, 13 May 2021 19:13:45 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.498.0; Thu, 13 May 2021 19:16:20 +0800
From:   Weihang Li <liweihang@huawei.com>
To:     <dledford@redhat.com>, <jgg@nvidia.com>
CC:     <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, Lang Cheng <chenglang@huawei.com>,
        Weihang Li <liweihang@huawei.com>
Subject: [PATCH for-next 2/3] RDMA/hns: Remove Receive Queue of CMDQ
Date:   Thu, 13 May 2021 19:16:17 +0800
Message-ID: <1620904578-29829-3-git-send-email-liweihang@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
References: <1620904578-29829-1-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Lang Cheng <chenglang@huawei.com>

The CRQ of CMDQ is unused, so remove code about it.

Signed-off-by: Lang Cheng <chenglang@huawei.com>
Signed-off-by: Weihang Li <liweihang@huawei.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 95 ++++++++----------------------
 drivers/infiniband/hw/hns/hns_roce_hw_v2.h |  1 -
 2 files changed, 25 insertions(+), 71 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index b58d65f..a9b9fca 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1228,44 +1228,32 @@ static void hns_roce_free_cmq_desc(struct hns_roce_dev *hr_dev,
 	kfree(ring->desc);
 }
 
-static int hns_roce_init_cmq_ring(struct hns_roce_dev *hr_dev, bool ring_type)
+static int init_csq(struct hns_roce_dev *hr_dev,
+		    struct hns_roce_v2_cmq_ring *csq)
 {
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
-					    &priv->cmq.csq : &priv->cmq.crq;
+	dma_addr_t dma;
+	int ret;
 
-	ring->flag = ring_type;
-	ring->head = 0;
+	csq->desc_num = CMD_CSQ_DESC_NUM;
+	spin_lock_init(&csq->lock);
+	csq->flag = TYPE_CSQ;
+	csq->head = 0;
 
-	return hns_roce_alloc_cmq_desc(hr_dev, ring);
-}
+	ret = hns_roce_alloc_cmq_desc(hr_dev, csq);
+	if (ret)
+		return ret;
 
-static void hns_roce_cmq_init_regs(struct hns_roce_dev *hr_dev, bool ring_type)
-{
-	struct hns_roce_v2_priv *priv = hr_dev->priv;
-	struct hns_roce_v2_cmq_ring *ring = (ring_type == TYPE_CSQ) ?
-					    &priv->cmq.csq : &priv->cmq.crq;
-	dma_addr_t dma = ring->desc_dma_addr;
-
-	if (ring_type == TYPE_CSQ) {
-		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_L_REG, (u32)dma);
-		roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG,
-			   upper_32_bits(dma));
-		roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
-			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
-
-		/* Make sure to write tail first and then head */
-		roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
-		roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
-	} else {
-		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_L_REG, (u32)dma);
-		roce_write(hr_dev, ROCEE_RX_CMQ_BASEADDR_H_REG,
-			   upper_32_bits(dma));
-		roce_write(hr_dev, ROCEE_RX_CMQ_DEPTH_REG,
-			   (u32)ring->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
-		roce_write(hr_dev, ROCEE_RX_CMQ_HEAD_REG, 0);
-		roce_write(hr_dev, ROCEE_RX_CMQ_TAIL_REG, 0);
-	}
+	dma = csq->desc_dma_addr;
+	roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_L_REG, lower_32_bits(dma));
+	roce_write(hr_dev, ROCEE_TX_CMQ_BASEADDR_H_REG, upper_32_bits(dma));
+	roce_write(hr_dev, ROCEE_TX_CMQ_DEPTH_REG,
+		   (u32)csq->desc_num >> HNS_ROCE_CMQ_DESC_NUM_S);
+
+	/* Make sure to write CI first and then PI */
+	roce_write(hr_dev, ROCEE_TX_CMQ_CI_REG, 0);
+	roce_write(hr_dev, ROCEE_TX_CMQ_PI_REG, 0);
+
+	return 0;
 }
 
 static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
@@ -1273,43 +1261,11 @@ static int hns_roce_v2_cmq_init(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 	int ret;
 
-	/* Setup the queue entries for command queue */
-	priv->cmq.csq.desc_num = CMD_CSQ_DESC_NUM;
-	priv->cmq.crq.desc_num = CMD_CRQ_DESC_NUM;
-
-	/* Setup the lock for command queue */
-	spin_lock_init(&priv->cmq.csq.lock);
-	spin_lock_init(&priv->cmq.crq.lock);
-
-	/* Setup Tx write back timeout */
 	priv->cmq.tx_timeout = HNS_ROCE_CMQ_TX_TIMEOUT;
 
-	/* Init CSQ */
-	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CSQ);
-	if (ret) {
-		dev_err_ratelimited(hr_dev->dev,
-				    "failed to init CSQ, ret = %d.\n", ret);
-		return ret;
-	}
-
-	/* Init CRQ */
-	ret = hns_roce_init_cmq_ring(hr_dev, TYPE_CRQ);
-	if (ret) {
-		dev_err_ratelimited(hr_dev->dev,
-				    "failed to init CRQ, ret = %d.\n", ret);
-		goto err_crq;
-	}
-
-	/* Init CSQ REG */
-	hns_roce_cmq_init_regs(hr_dev, TYPE_CSQ);
-
-	/* Init CRQ REG */
-	hns_roce_cmq_init_regs(hr_dev, TYPE_CRQ);
-
-	return 0;
-
-err_crq:
-	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.csq);
+	ret = init_csq(hr_dev, &priv->cmq.csq);
+	if (ret)
+		dev_err(hr_dev->dev, "failed to init CSQ, ret = %d.\n", ret);
 
 	return ret;
 }
@@ -1319,7 +1275,6 @@ static void hns_roce_v2_cmq_exit(struct hns_roce_dev *hr_dev)
 	struct hns_roce_v2_priv *priv = hr_dev->priv;
 
 	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.csq);
-	hns_roce_free_cmq_desc(hr_dev, &priv->cmq.crq);
 }
 
 static void hns_roce_cmq_setup_basic_desc(struct hns_roce_cmq_desc *desc,
diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
index a2100a6..d168314 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.h
@@ -1731,7 +1731,6 @@ struct hns_roce_v2_cmq_ring {
 
 struct hns_roce_v2_cmq {
 	struct hns_roce_v2_cmq_ring csq;
-	struct hns_roce_v2_cmq_ring crq;
 	u16 tx_timeout;
 };
 
-- 
2.7.4

