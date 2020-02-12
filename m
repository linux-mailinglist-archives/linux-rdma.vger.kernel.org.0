Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AED6115A223
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2020 08:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728375AbgBLHft (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Feb 2020 02:35:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:39542 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgBLHft (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Feb 2020 02:35:49 -0500
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 60A8A20848;
        Wed, 12 Feb 2020 07:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581492949;
        bh=LnUDr37rQUU6Q8MqtMqnYEkQ8OmvPxE2AUHkkQRe42s=;
        h=From:To:Cc:Subject:Date:From;
        b=wEyHdV3+yn6jNE27p5IWHo5yaIheGGy/MDheYRh7G3G9MI5SkZ61W9LxQBpkkPs0Z
         q7AypnXzEQOtx39bu6SJbe4cvG7vBjR9btBlNR2p0gIKr7qEe10ZPUTqkMJwOY5a8U
         HqRWG+8BobcP8g5wIueSH+lO5zSJGjbZmzdS5r4E=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Michael Guralnik <michaelgur@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] RDMA/core: Add weak ordering dma attr to dma mapping
Date:   Wed, 12 Feb 2020 09:35:59 +0200
Message-Id: <20200212073559.684139-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Michael Guralnik <michaelgur@mellanox.com>

For memory regions registered with IB_ACCESS_RELAXED_ORDERING will be
dma mapped with the DMA_ATTR_WEAK_ORDERING.

This will allow reads and writes to the mapping to be weakly ordered,
such change can enhance performance on some supporting architectures.

Signed-off-by: Michael Guralnik <michaelgur@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 06b6125b5ae1..82455a1392f1 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -197,6 +197,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	unsigned long lock_limit;
 	unsigned long new_pinned;
 	unsigned long cur_base;
+	unsigned long dma_attr = 0;
 	struct mm_struct *mm;
 	unsigned long npages;
 	int ret;
@@ -278,10 +279,12 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 
 	sg_mark_end(sg);
 
-	umem->nmap = ib_dma_map_sg(device,
-				   umem->sg_head.sgl,
-				   umem->sg_nents,
-				   DMA_BIDIRECTIONAL);
+	if (access & IB_ACCESS_RELAXED_ORDERING)
+		dma_attr |= DMA_ATTR_WEAK_ORDERING;
+
+	umem->nmap =
+		ib_dma_map_sg_attrs(device, umem->sg_head.sgl, umem->sg_nents,
+				    DMA_BIDIRECTIONAL, dma_attr);
 
 	if (!umem->nmap) {
 		ret = -ENOMEM;
-- 
2.24.1

