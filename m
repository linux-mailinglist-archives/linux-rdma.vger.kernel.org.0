Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 950853B02F4
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Jun 2021 13:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbhFVLmM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Jun 2021 07:42:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:51836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhFVLmM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Jun 2021 07:42:12 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BC64161374;
        Tue, 22 Jun 2021 11:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624361996;
        bh=uaayGzGqEGBo5zjETiYgFeMXefFKm2yBfSj2AcVL9U8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JCYTjiJd/RkN6jEpTCcY8LskvrGnYrXr6cCVjqGQOHNUfH2VZW/zlLnV6MHMRk5fE
         BJWsQJjlHH4lX5Now/IgrctguPWFi/WCG0weDWq0fWyAYL3HGx2nawVcR7W+lWFPRK
         VBv7I1p1UCEZm1EJfsEQv3RNc1bpU92zpgPp5FxIVf8wldv2+DnzLLslyszjb8EfRb
         efHdGzPOCv57NwKbBCFkE8+isn0v/LZnp4ofAYOeQXDq7fqKnRLH9i8AnZ2qJEPHHd
         r1Ij41/39FV+ybggHYLnC7m9jEYuDZsgIMm+yVvb8viDltATGnR1xkWZb7S4WYYFVX
         eCrEc9X2q0G/g==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Christoph Hellwig <hch@lst.de>
Cc:     Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: [PATCH rdma-next 2/2] RDMA: Use dma_map_sgtable for map umem pages
Date:   Tue, 22 Jun 2021 14:39:42 +0300
Message-Id: <29b80ff0c32675351c0a1b2f34e0181f463beb3d.1624361199.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1624361199.git.leonro@nvidia.com>
References: <cover.1624361199.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

In order to avoid incorrect usage of sg_table fields, change umem to
use dma_map_sgtable for map the pages for DMA. Since dma_map_sgtable
update the nents field (number of DMA entries), there is no need
anymore for nmap variable, hence do some cleanups accordingly.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c        | 29 ++++++++++-----------------
 drivers/infiniband/core/umem_dmabuf.c |  1 -
 drivers/infiniband/hw/mlx4/mr.c       |  4 ++--
 drivers/infiniband/hw/mlx5/mr.c       |  3 ++-
 drivers/infiniband/sw/rdmavt/mr.c     |  2 +-
 drivers/infiniband/sw/rxe/rxe_mr.c    |  3 ++-
 include/rdma/ib_umem.h                |  5 ++---
 include/rdma/ib_verbs.h               | 28 ++++++++++++++++++++++++++
 8 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 0eb40025075f..a76ef6a6bac5 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -51,11 +51,11 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 	struct scatterlist *sg;
 	unsigned int i;
 
-	if (umem->nmap > 0)
-		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
-				DMA_BIDIRECTIONAL);
+	if (dirty)
+		ib_dma_unmap_sgtable_attrs(dev, &umem->sg_head,
+					   DMA_BIDIRECTIONAL, 0);
 
-	for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
+	for_each_sgtable_dma_sg(&umem->sg_head, sg, i)
 		unpin_user_page_range_dirty_lock(sg_page(sg),
 			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
 
@@ -111,7 +111,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 	/* offset into first SGL */
 	pgoff = umem->address & ~PAGE_MASK;
 
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i) {
+	for_each_sgtable_dma_sg(&umem->sg_head, sg, i) {
 		/* Walk SGL and reduce max page size if VA/PA bits differ
 		 * for any address.
 		 */
@@ -121,7 +121,7 @@ unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
 		 * the maximum possible page size as the low bits of the iova
 		 * must be zero when starting the next chunk.
 		 */
-		if (i != (umem->nmap - 1))
+		if (i != (umem->sg_head.nents - 1))
 			mask |= va;
 		pgoff = 0;
 	}
@@ -230,7 +230,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 				0, ret << PAGE_SHIFT,
 				ib_dma_max_seg_size(device), sg, npages,
 				GFP_KERNEL);
-		umem->sg_nents = umem->sg_head.nents;
 		if (IS_ERR(sg)) {
 			unpin_user_pages_dirty_lock(page_list, ret, 0);
 			ret = PTR_ERR(sg);
@@ -241,16 +240,10 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	if (access & IB_ACCESS_RELAXED_ORDERING)
 		dma_attr |= DMA_ATTR_WEAK_ORDERING;
 
-	umem->nmap =
-		ib_dma_map_sg_attrs(device, umem->sg_head.sgl, umem->sg_nents,
-				    DMA_BIDIRECTIONAL, dma_attr);
-
-	if (!umem->nmap) {
-		ret = -ENOMEM;
+	ret = ib_dma_map_sgtable_attrs(device, &umem->sg_head,
+				       DMA_BIDIRECTIONAL, dma_attr);
+	if (ret)
 		goto umem_release;
-	}
-
-	ret = 0;
 	goto out;
 
 umem_release:
@@ -310,8 +303,8 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
 		return -EINVAL;
 	}
 
-	ret = sg_pcopy_to_buffer(umem->sg_head.sgl, umem->sg_nents, dst, length,
-				 offset + ib_umem_offset(umem));
+	ret = sg_pcopy_to_buffer(umem->sg_head.sgl, umem->sg_head.orig_nents,
+				 dst, length, offset + ib_umem_offset(umem));
 
 	if (ret < 0)
 		return ret;
diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
index 0d65ce146fc4..cd2dd1f39aa7 100644
--- a/drivers/infiniband/core/umem_dmabuf.c
+++ b/drivers/infiniband/core/umem_dmabuf.c
@@ -57,7 +57,6 @@ int ib_umem_dmabuf_map_pages(struct ib_umem_dmabuf *umem_dmabuf)
 
 	umem_dmabuf->umem.sg_head.sgl = umem_dmabuf->first_sg;
 	umem_dmabuf->umem.sg_head.nents = nmap;
-	umem_dmabuf->umem.nmap = nmap;
 	umem_dmabuf->sgt = sgt;
 
 wait_fence:
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 50becc0e4b62..ab5dc8eac7f8 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -200,7 +200,7 @@ int mlx4_ib_umem_write_mtt(struct mlx4_ib_dev *dev, struct mlx4_mtt *mtt,
 	mtt_shift = mtt->page_shift;
 	mtt_size = 1ULL << mtt_shift;
 
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i) {
+	for_each_sgtable_dma_sg(&umem->sg_head, sg, i) {
 		if (cur_start_addr + len == sg_dma_address(sg)) {
 			/* still the same block */
 			len += sg_dma_len(sg);
@@ -273,7 +273,7 @@ int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
 
 	*num_of_mtts = ib_umem_num_dma_blocks(umem, PAGE_SIZE);
 
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i) {
+	for_each_sgtable_dma_sg(&umem->sg_head, sg, i) {
 		/*
 		 * Initialization - save the first chunk start as the
 		 * current_block_start - block means contiguous pages.
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index e288531fedc9..870209178a65 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1226,7 +1226,8 @@ int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 	orig_sg_length = sg.length;
 
 	cur_mtt = mtt;
-	rdma_for_each_block (mr->umem->sg_head.sgl, &biter, mr->umem->nmap,
+	rdma_for_each_block (mr->umem->sg_head.sgl, &biter,
+			     mr->umem->sg_head.nents,
 			     BIT(mr->page_shift)) {
 		if (cur_mtt == (void *)mtt + sg.length) {
 			dma_sync_single_for_device(ddev, sg.addr, sg.length,
diff --git a/drivers/infiniband/sw/rdmavt/mr.c b/drivers/infiniband/sw/rdmavt/mr.c
index 34b7af6ab9c2..d955c8c4acc4 100644
--- a/drivers/infiniband/sw/rdmavt/mr.c
+++ b/drivers/infiniband/sw/rdmavt/mr.c
@@ -410,7 +410,7 @@ struct ib_mr *rvt_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mr->mr.page_shift = PAGE_SHIFT;
 	m = 0;
 	n = 0;
-	for_each_sg_page (umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
+	for_each_sg_page (umem->sg_head.sgl, &sg_iter, umem->sg_head.nents, 0) {
 		void *vaddr;
 
 		vaddr = page_address(sg_page_iter_page(&sg_iter));
diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
index 6aabcb4de235..a269085e0946 100644
--- a/drivers/infiniband/sw/rxe/rxe_mr.c
+++ b/drivers/infiniband/sw/rxe/rxe_mr.c
@@ -142,7 +142,8 @@ int rxe_mr_init_user(struct rxe_pd *pd, u64 start, u64 length, u64 iova,
 	if (length > 0) {
 		buf = map[0]->buf;
 
-		for_each_sg_page(umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
+		for_each_sg_page(umem->sg_head.sgl, &sg_iter,
+				 umem->sg_head.nents, 0) {
 			if (num_buf >= RXE_BUF_PER_MAP) {
 				map++;
 				buf = map[0]->buf;
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 676c57f5ca80..c754b1a31cc9 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -27,8 +27,6 @@ struct ib_umem {
 	u32 is_dmabuf : 1;
 	struct work_struct	work;
 	struct sg_table sg_head;
-	int             nmap;
-	unsigned int    sg_nents;
 };
 
 struct ib_umem_dmabuf {
@@ -77,7 +75,8 @@ static inline void __rdma_umem_block_iter_start(struct ib_block_iter *biter,
 						struct ib_umem *umem,
 						unsigned long pgsz)
 {
-	__rdma_block_iter_start(biter, umem->sg_head.sgl, umem->nmap, pgsz);
+	__rdma_block_iter_start(biter, umem->sg_head.sgl, umem->sg_head.nents,
+				pgsz);
 }
 
 /**
diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
index 371df1c80aeb..2dba30849731 100644
--- a/include/rdma/ib_verbs.h
+++ b/include/rdma/ib_verbs.h
@@ -4057,6 +4057,34 @@ static inline void ib_dma_unmap_sg_attrs(struct ib_device *dev,
 				   dma_attrs);
 }
 
+/**
+ * ib_dma_map_sgtable_attrs - Map a scatter/gather table to DMA addresses
+ * @dev: The device for which the DMA addresses are to be created
+ * @sg: The sg_table object describing the buffer
+ * @direction: The direction of the DMA
+ * @attrs: Optional DMA attributes for the map operation
+ */
+static inline int ib_dma_map_sgtable_attrs(struct ib_device *dev,
+					   struct sg_table *sgt,
+					   enum dma_data_direction direction,
+					   unsigned long dma_attrs)
+{
+	if (ib_uses_virt_dma(dev)) {
+		ib_dma_virt_map_sg(dev, sgt->sgl, sgt->orig_nents);
+		return 0;
+	}
+	return dma_map_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
+static inline void ib_dma_unmap_sgtable_attrs(struct ib_device *dev,
+					      struct sg_table *sgt,
+					      enum dma_data_direction direction,
+					      unsigned long dma_attrs)
+{
+	if (!ib_uses_virt_dma(dev))
+		dma_unmap_sgtable(dev->dma_device, sgt, direction, dma_attrs);
+}
+
 /**
  * ib_dma_map_sg - Map a scatter/gather list to DMA addresses
  * @dev: The device for which the DMA addresses are to be created
-- 
2.31.1

