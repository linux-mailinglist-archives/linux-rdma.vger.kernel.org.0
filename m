Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C2258128DF4
	for <lists+linux-rdma@lfdr.de>; Sun, 22 Dec 2019 13:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfLVMq7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 22 Dec 2019 07:46:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:36898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726189AbfLVMq7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 22 Dec 2019 07:46:59 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1FE742070A;
        Sun, 22 Dec 2019 12:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1577018817;
        bh=FTBx1ECy6NqUlKqD7Nf0l6cFfVauHXjBn4ToeYYdHxs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRqeue6dgACY4jg9t4JGQad3dYccOl3bRlj4EdnzMnkTvlOc8J4o/R01aezVVe2zt
         dOHjSNJIwI8ZUeutAm0SN4RY1ZUHK658MfN+xrcfeGTbNvYtzjbpp2FGDUmeOw1Det
         4K7Obk4zdWEcFG91GvFAIK6cF+7kXbL2hYVwcryE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Artemy Kovalyov <artemyko@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>
Subject: [PATCH rdma-rc v1 1/3] IB/mlx5: Unify ODP MR code paths to allow extra flexibility
Date:   Sun, 22 Dec 2019 14:46:47 +0200
Message-Id: <20191222124649.52300-2-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191222124649.52300-1-leon@kernel.org>
References: <20191222124649.52300-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

Building MR translation table in ODP case requires additional flexibility,
namely random access to DMA addresses. Make both direct and indirect ODP MR
use same code path, separated from non-ODP MR code path.

This change fixed the broken __mlx5_ib_populate_pas() shift calculation.

Fixes: d2183c6f1958 ("RDMA/umem: Move page_shift from ib_umem to ib_odp_umem")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mem.c     | 25 ------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  9 ++---
 drivers/infiniband/hw/mlx5/mr.c      | 58 +++++++++++-----------------
 drivers/infiniband/hw/mlx5/odp.c     | 42 +++++++++++++++++++-
 4 files changed, 67 insertions(+), 67 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 048f4e974a61..b90a3649e7d1 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -101,18 +101,6 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	*count = i;
 }
 
-static u64 umem_dma_to_mtt(dma_addr_t umem_dma)
-{
-	u64 mtt_entry = umem_dma & ODP_DMA_ADDR_MASK;
-
-	if (umem_dma & ODP_READ_ALLOWED_BIT)
-		mtt_entry |= MLX5_IB_MTT_READ;
-	if (umem_dma & ODP_WRITE_ALLOWED_BIT)
-		mtt_entry |= MLX5_IB_MTT_WRITE;
-
-	return mtt_entry;
-}
-
 /*
  * Populate the given array with bus addresses from the umem.
  *
@@ -139,19 +127,6 @@ void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 	struct scatterlist *sg;
 	int entry;
 
-	if (umem->is_odp) {
-		WARN_ON(shift != 0);
-		WARN_ON(access_flags != (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE));
-
-		for (i = 0; i < num_pages; ++i) {
-			dma_addr_t pa =
-				to_ib_umem_odp(umem)->dma_list[offset + i];
-
-			pas[i] = cpu_to_be64(umem_dma_to_mtt(pa));
-		}
-		return;
-	}
-
 	i = 0;
 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
 		len = sg_dma_len(sg) >> PAGE_SHIFT;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index b06f32ff5748..927948328184 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1276,8 +1276,8 @@ void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
 void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent);
-void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
-			   size_t nentries, struct mlx5_ib_mr *mr, int flags);
+void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
+			   struct mlx5_ib_mr *mr, int flags);
 
 int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 			       enum ib_uverbs_advise_mr_advice advice,
@@ -1293,9 +1293,8 @@ static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
 static inline void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent) {}
-static inline void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
-					 size_t nentries, struct mlx5_ib_mr *mr,
-					 int flags) {}
+static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
+					 struct mlx5_ib_mr *mr, int flags) {}
 
 static inline int
 mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ea8bfc3e2d8d..1e38ba0da16a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -868,36 +868,6 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(
 	return mr;
 }
 
-static inline int populate_xlt(struct mlx5_ib_mr *mr, int idx, int npages,
-			       void *xlt, int page_shift, size_t size,
-			       int flags)
-{
-	struct mlx5_ib_dev *dev = mr->dev;
-	struct ib_umem *umem = mr->umem;
-
-	if (flags & MLX5_IB_UPD_XLT_INDIRECT) {
-		if (!umr_can_use_indirect_mkey(dev))
-			return -EPERM;
-		mlx5_odp_populate_klm(xlt, idx, npages, mr, flags);
-		return npages;
-	}
-
-	npages = min_t(size_t, npages, ib_umem_num_pages(umem) - idx);
-
-	if (!(flags & MLX5_IB_UPD_XLT_ZAP)) {
-		__mlx5_ib_populate_pas(dev, umem, page_shift,
-				       idx, npages, xlt,
-				       MLX5_IB_MTT_PRESENT);
-		/* Clear padding after the pages
-		 * brought from the umem.
-		 */
-		memset(xlt + (npages * sizeof(struct mlx5_mtt)), 0,
-		       size - npages * sizeof(struct mlx5_mtt));
-	}
-
-	return npages;
-}
-
 #define MLX5_MAX_UMR_CHUNK ((1 << (MLX5_MAX_UMR_SHIFT + 4)) - \
 			    MLX5_UMR_MTT_ALIGNMENT)
 #define MLX5_SPARE_UMR_CHUNK 0x10000
@@ -921,6 +891,7 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	size_t pages_mapped = 0;
 	size_t pages_to_map = 0;
 	size_t pages_iter = 0;
+	size_t size_to_map = 0;
 	gfp_t gfp;
 	bool use_emergency_page = false;
 
@@ -967,6 +938,15 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		goto free_xlt;
 	}
 
+	if (mr->umem->is_odp) {
+		if (!(flags & MLX5_IB_UPD_XLT_INDIRECT)) {
+			struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+			size_t max_pages = ib_umem_odp_num_pages(odp) - idx;
+
+			pages_to_map = min_t(size_t, pages_to_map, max_pages);
+		}
+	}
+
 	sg.addr = dma;
 	sg.lkey = dev->umrc.pd->local_dma_lkey;
 
@@ -989,14 +969,22 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	     pages_mapped < pages_to_map && !err;
 	     pages_mapped += pages_iter, idx += pages_iter) {
 		npages = min_t(int, pages_iter, pages_to_map - pages_mapped);
+		size_to_map = npages * desc_size;
 		dma_sync_single_for_cpu(ddev, dma, size, DMA_TO_DEVICE);
-		npages = populate_xlt(mr, idx, npages, xlt,
-				      page_shift, size, flags);
-
+		if (mr->umem->is_odp) {
+			mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
+		} else {
+			__mlx5_ib_populate_pas(dev, mr->umem, page_shift, idx,
+					       npages, xlt,
+					       MLX5_IB_MTT_PRESENT);
+			/* Clear padding after the pages
+			 * brought from the umem.
+			 */
+			memset(xlt + size_to_map, 0, size - size_to_map);
+		}
 		dma_sync_single_for_device(ddev, dma, size, DMA_TO_DEVICE);
 
-		sg.length = ALIGN(npages * desc_size,
-				  MLX5_UMR_MTT_ALIGNMENT);
+		sg.length = ALIGN(size_to_map, MLX5_UMR_MTT_ALIGNMENT);
 
 		if (pages_mapped + pages_iter >= pages_to_map) {
 			if (flags & MLX5_IB_UPD_XLT_ENABLE)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f924250f80c2..92da6c4f7ddd 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -93,8 +93,8 @@ struct mlx5_pagefault {
 
 static u64 mlx5_imr_ksm_entries;
 
-void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
-			   struct mlx5_ib_mr *imr, int flags)
+static void populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
+			struct mlx5_ib_mr *imr, int flags)
 {
 	struct mlx5_klm *end = pklm + nentries;
 
@@ -144,6 +144,44 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 	}
 }
 
+static u64 umem_dma_to_mtt(dma_addr_t umem_dma)
+{
+	u64 mtt_entry = umem_dma & ODP_DMA_ADDR_MASK;
+
+	if (umem_dma & ODP_READ_ALLOWED_BIT)
+		mtt_entry |= MLX5_IB_MTT_READ;
+	if (umem_dma & ODP_WRITE_ALLOWED_BIT)
+		mtt_entry |= MLX5_IB_MTT_WRITE;
+
+	return mtt_entry;
+}
+
+static void populate_mtt(__be64 *pas, size_t idx, size_t nentries,
+			 struct mlx5_ib_mr *mr, int flags)
+{
+	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+	dma_addr_t pa;
+	size_t i;
+
+	if (flags & MLX5_IB_UPD_XLT_ZAP)
+		return;
+
+	for (i = 0; i < nentries; i++) {
+		pa = odp->dma_list[idx + i];
+		pas[i] = cpu_to_be64(umem_dma_to_mtt(pa));
+	}
+}
+
+void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
+			   struct mlx5_ib_mr *mr, int flags)
+{
+	if (flags & MLX5_IB_UPD_XLT_INDIRECT) {
+		populate_klm(xlt, idx, nentries, mr, flags);
+	} else {
+		populate_mtt(xlt, idx, nentries, mr, flags);
+	}
+}
+
 static void dma_fence_odp_mr(struct mlx5_ib_mr *mr)
 {
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
-- 
2.20.1

