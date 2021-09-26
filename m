Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14EFC4186AC
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Sep 2021 08:11:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhIZGNP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Sep 2021 02:13:15 -0400
Received: from mx22.baidu.com ([220.181.50.185]:49068 "EHLO baidu.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231146AbhIZGNJ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Sep 2021 02:13:09 -0400
Received: from BC-Mail-Ex09.internal.baidu.com (unknown [172.31.51.49])
        by Forcepoint Email with ESMTPS id 23073A7C24971CC6AF0C;
        Sun, 26 Sep 2021 14:11:31 +0800 (CST)
Received: from BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) by
 BC-Mail-Ex09.internal.baidu.com (172.31.51.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2242.12; Sun, 26 Sep 2021 14:11:31 +0800
Received: from LAPTOP-UKSR4ENP.internal.baidu.com (172.31.63.8) by
 BJHW-MAIL-EX27.internal.baidu.com (10.127.64.42) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.14; Sun, 26 Sep 2021 14:11:30 +0800
From:   Cai Huoqing <caihuoqing@baidu.com>
To:     <caihuoqing@baidu.com>
CC:     Mustafa Ismail <mustafa.ismail@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Doug Ledford <dledford@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] RDMA/irdma: Use dma_alloc_coherent() instead of kmalloc/dma_map_single()
Date:   Sun, 26 Sep 2021 14:11:23 +0800
Message-ID: <20210926061124.335-1-caihuoqing@baidu.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.31.63.8]
X-ClientProxiedBy: BC-Mail-Ex15.internal.baidu.com (172.31.51.55) To
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
 drivers/infiniband/hw/irdma/puda.c | 19 ++++---------------
 1 file changed, 4 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/puda.c b/drivers/infiniband/hw/irdma/puda.c
index 58e7d875643b..feafe21b12c6 100644
--- a/drivers/infiniband/hw/irdma/puda.c
+++ b/drivers/infiniband/hw/irdma/puda.c
@@ -151,24 +151,15 @@ static struct irdma_puda_buf *irdma_puda_alloc_buf(struct irdma_sc_dev *dev,
 
 	buf = buf_mem.va;
 	buf->mem.size = len;
-	buf->mem.va = kzalloc(buf->mem.size, GFP_KERNEL);
+	buf->mem.va = dma_alloc_coherent(dev->hw->device, len,
+					 &buf->mem.pa, GFP_KERNEL);
 	if (!buf->mem.va)
-		goto free_virt;
-	buf->mem.pa = dma_map_single(dev->hw->device, buf->mem.va,
-				     buf->mem.size, DMA_BIDIRECTIONAL);
-	if (dma_mapping_error(dev->hw->device, buf->mem.pa)) {
-		kfree(buf->mem.va);
-		goto free_virt;
-	}
+		return NULL;
 
 	buf->buf_mem.va = buf_mem.va;
 	buf->buf_mem.size = buf_mem.size;
 
 	return buf;
-
-free_virt:
-	kfree(buf_mem.va);
-	return NULL;
 }
 
 /**
@@ -179,9 +170,7 @@ static struct irdma_puda_buf *irdma_puda_alloc_buf(struct irdma_sc_dev *dev,
 static void irdma_puda_dele_buf(struct irdma_sc_dev *dev,
 				struct irdma_puda_buf *buf)
 {
-	dma_unmap_single(dev->hw->device, buf->mem.pa, buf->mem.size,
-			 DMA_BIDIRECTIONAL);
-	kfree(buf->mem.va);
+	dma_free_coherent(dev->hw->device, buf->mem.size, buf->mem.va, buf->mem.pa);
 	kfree(buf->buf_mem.va);
 }
 
-- 
2.25.1

