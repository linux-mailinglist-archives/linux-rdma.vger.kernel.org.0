Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0F38E70B
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730841AbfHOIjK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:39:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:56602 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIjK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:39:10 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7E1872235C;
        Thu, 15 Aug 2019 08:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858350;
        bh=AFRkQLZI+8XDklm1zo97b1gCLuojb80Z6LUBwZL+v6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ffGqLpCinOVMsoQbkTDhgg1x5EXzwNkBw08AUGTFG4Fb/Cb7vXMR2jGpX/AQ6tQaR
         5aGb+Fh+o8kt+6v8hft9N57PN32vJLEAo/bWuvLmSVVLHzAFcYcQsmcIafP6gLpznG
         4L1hpcf8CZvNb6GCN5YOnXRrvZE6JUYjupVMeQvI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 4/8] RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
Date:   Thu, 15 Aug 2019 11:38:30 +0300
Message-Id: <20190815083834.9245-5-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

When ODP is enabled with IB_ACCESS_HUGETLB then the required pages
should be calculated based on the extent of the MR, which is rounded
to the nearest huge page alignment.

Fixes: d2183c6f1958 ("RDMA/umem: Move page_shift from ib_umem to ib_odp_umem")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem.c   | 7 +------
 drivers/infiniband/hw/mlx5/mem.c | 5 +++--
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 08da840ed7ee..56553668256f 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -379,14 +379,9 @@ EXPORT_SYMBOL(ib_umem_release);
 
 int ib_umem_page_count(struct ib_umem *umem)
 {
-	int i;
-	int n;
+	int i, n = 0;
 	struct scatterlist *sg;
 
-	if (umem->is_odp)
-		return ib_umem_num_pages(umem);
-
-	n = 0;
 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
 		n += sg_dma_len(sg) >> PAGE_SHIFT;
 
diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index fe1a76d8531c..a40e0abf2338 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -57,9 +57,10 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	int entry;
 
 	if (umem->is_odp) {
-		unsigned int page_shift = to_ib_umem_odp(umem)->page_shift;
+		struct ib_umem_odp *odp = to_ib_umem_odp(umem);
+		unsigned int page_shift = odp->page_shift;
 
-		*ncont = ib_umem_page_count(umem);
+		*ncont = ib_umem_odp_num_pages(odp);
 		*count = *ncont << (page_shift - PAGE_SHIFT);
 		*shift = page_shift;
 		if (order)
-- 
2.20.1

