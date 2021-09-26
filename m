Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC234186A8
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Sep 2021 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbhIZGNC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Sep 2021 02:13:02 -0400
Received: from mx22.baidu.com ([220.181.50.185]:48924 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229485AbhIZGNC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Sep 2021 02:13:02 -0400
Received: from BC-Mail-Ex11.internal.baidu.com (unknown [172.31.51.51])
        by Forcepoint Email with ESMTPS id 8FCD1700013123366D75;
        Sun, 26 Sep 2021 14:11:23 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex11.internal.baidu.com (172.31.51.51) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 26 Sep 2021 14:11:23 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 26 Sep 2021 14:11:22 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Lijun Ou <oulijun@huawei.com>, Weihang Li <liweihang@huawei.com>,
        "Doug Ledford" <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA/hns: Use dma_alloc_coherent() instead of kmalloc/dma_map_single()
Date:   Sun, 26 Sep 2021 14:11:15 +0800
Message-ID: <20210926061116.282-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex22.internal.baidu.com (172.31.51.16) To
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
with dma_alloc_coherent/dma_free_coherent() helps to reduce
code size, and simplify the code, and coherent DMA will not
clear the cache every time.

Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
---
 drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
index 5b9953105752..380445f98a49 100644
--- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
+++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
@@ -1165,32 +1165,22 @@ static int hns_roce_alloc_cmq_desc(struct hns_roce_dev *hr_dev,
 {
 	int size = ring->desc_num * sizeof(struct hns_roce_cmq_desc);
 
-	ring->desc = kzalloc(size, GFP_KERNEL);
+	ring->desc = dma_alloc_coherent(hr_dev->dev, size,
+					&ring->desc_dma_addr, GFP_KERNEL);
 	if (!ring->desc)
 		return -ENOMEM;
 
-	ring->desc_dma_addr = dma_map_single(hr_dev->dev, ring->desc, size,
-					     DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(hr_dev->dev, ring->desc_dma_addr)) {
-		ring->desc_dma_addr = 0;
-		kfree(ring->desc);
-		ring->desc = NULL;
-
-		return -ENOMEM;
-	}
-
 	return 0;
 }
 
 static void hns_roce_free_cmq_desc(struct hns_roce_dev *hr_dev,
 				   struct hns_roce_v2_cmq_ring *ring)
 {
-	dma_unmap_single(hr_dev->dev, ring->desc_dma_addr,
-			 ring->desc_num * sizeof(struct hns_roce_cmq_desc),
-			 DMA_BIDIRECTIONAL);
+	dma_free_coherent(hr_dev->dev,
+			  ring->desc_num * sizeof(struct hns_roce_cmq_desc),
+			  ring->desc, ring->desc_dma_addr);
 
 	ring->desc_dma_addr = 0;
-	kfree(ring->desc);
 }
 
 static int init_csq(struct hns_roce_dev *hr_dev,
-- 
2.25.1

