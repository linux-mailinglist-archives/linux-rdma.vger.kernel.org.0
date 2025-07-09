Return-Path: <linux-rdma+bounces-11996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81B1CAFE05B
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 08:47:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BE841C419A0
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 06:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F18E3280CC8;
	Wed,  9 Jul 2025 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiMOOHm6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA7D280A51
	for <linux-rdma@vger.kernel.org>; Wed,  9 Jul 2025 06:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752043358; cv=none; b=h8fdmI2txfDWFjxSSDFsp2nsUYuvyOwDS7XRiBSmvaQptahO0kUfqH8nX012YxtbusnyT2/+2pQZQSfFnI9b9jUz06TVToblF70Rz5aYu/NLeQWL7FhpFyK2WGiFKEi3cIOqfAI7KP9hdcUIUa93OIfxymQ3bf3A9FW/m+EKm5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752043358; c=relaxed/simple;
	bh=q3jVGHBaLHGXqANQE1OZgHwpG4rK4NrdUGon0+Bfqos=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X/0DEBcggljs96OXUSGYieHBBirKDG8CGQkKRsG/RoV5OS6la/jCXxc0cjp0s4xErcgjGIExSoSWSEmFeUuwjFc4dpN/FCpG9SqKMrywARVIwAnh68a21IMkjvyls+cIvLIKDL5bj0WY/KiJkcD6jyAJI97m/Uiqkex8X9gY5Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiMOOHm6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6705C4CEF0;
	Wed,  9 Jul 2025 06:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752043358;
	bh=q3jVGHBaLHGXqANQE1OZgHwpG4rK4NrdUGon0+Bfqos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiMOOHm6n8iMc59GmckvM36yQDSeg4i1NuyZ5kqYY21X91HO6m9g+IB2SMXoO/okz
	 cGY9nrt0FW7kPDZd9S0Se3xEOiUTBnp1O3VSMn6NcJR8MVPc0NTrB5/dp0Cr8qJVDK
	 wstEZ0mkMDRywIYVx52qsUyOCh6R8kk4ZLV7Iz5I+s6PO5EqhcXQOtSNSY2kd/9YSh
	 oZlEAW9wOKG9gvN5sX/GcFxvbYwPv2NEM+8En5kklzZVzYRF1IFZN/j0pgeNilObyx
	 SjgFVKv5BVhglD8BY1xm34fi6lOpVImT2O/LqMlDdBfW7vg1iS8oZyeYq8KwNOVQ9S
	 ywxP7jnqoBdJA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 4/4] RDMA/mlx5: Optimize DMABUF mkey page size
Date: Wed,  9 Jul 2025 09:42:11 +0300
Message-ID: <bc05a6b2142c02f96a90635f9a4458ee4bbbf39f.1751979184.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751979184.git.leon@kernel.org>
References: <cover.1751979184.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Edward Srouji <edwards@nvidia.com>

The current implementation of DMABUF memory registration uses a fixed
page size for the memory key (mkey), which can lead to suboptimal
performance when the underlying memory layout may offer better page
size.

The optimization improves performance by reducing the number of page
table entries required for the mkey, leading to less MTT/KSM descriptors
that the HCA must go through to find translations, fewer cache-lines,
and shorter UMR work requests on mkey updates such as when
re-registering or reusing a cacheable mkey.

To ensure safe page size updates, the implementation uses a 5-step
process:
1. Make the first X entries non-present, while X is calculated to be
   minimal according to a large page shift that can be used to cover the
   MR length.
2. Update the page size to the large supported page size
3. Load the remaining N-X entries according to the (optimized)
   page shift
4. Update the page size according to the (optimized) page shift
5. Load the first X entries with the correct translations

This ensures that at no point is the MR accessible with a partially
updated translation table, maintaining correctness and preventing
access to stale or inconsistent mappings, such as having an mkey
advertising the new page size while some of the underlying page table
entries still contain the old page size translations.

Signed-off-by: Edward Srouji <edwards@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  26 +--
 drivers/infiniband/hw/mlx5/odp.c     |  31 ++-
 drivers/infiniband/hw/mlx5/umr.c     | 300 +++++++++++++++++++++++++--
 drivers/infiniband/hw/mlx5/umr.h     |  13 +-
 4 files changed, 327 insertions(+), 43 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 37e557d259fc..9fe7a197614a 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -104,19 +104,6 @@ unsigned long __mlx5_umem_find_best_quantized_pgoff(
 		__mlx5_bit_sz(typ, page_offset_fld), 0, scale,                 \
 		page_offset_quantized)
 
-static inline unsigned long
-mlx5_umem_dmabuf_find_best_pgsz(struct ib_umem_dmabuf *umem_dmabuf)
-{
-	/*
-	 * mkeys used for dmabuf are fixed at PAGE_SIZE because we must be able
-	 * to hold any sgl after a move operation. Ideally the mkc page size
-	 * could be changed at runtime to be optimal, but right now the driver
-	 * cannot do that.
-	 */
-	return ib_umem_find_best_pgsz(&umem_dmabuf->umem, PAGE_SIZE,
-				      umem_dmabuf->umem.iova);
-}
-
 enum {
 	MLX5_IB_MMAP_OFFSET_START = 9,
 	MLX5_IB_MMAP_OFFSET_END = 255,
@@ -352,6 +339,7 @@ struct mlx5_ib_flow_db {
 #define MLX5_IB_UPD_XLT_ACCESS	      BIT(5)
 #define MLX5_IB_UPD_XLT_INDIRECT      BIT(6)
 #define MLX5_IB_UPD_XLT_DOWNGRADE     BIT(7)
+#define MLX5_IB_UPD_XLT_KEEP_PGSZ     BIT(8)
 
 /* Private QP creation flags to be passed in ib_qp_init_attr.create_flags.
  *
@@ -744,6 +732,8 @@ struct mlx5_ib_mr {
 			struct mlx5_ib_mr *dd_crossed_mr;
 			struct list_head dd_node;
 			u8 revoked :1;
+			/* Indicates previous dmabuf page fault occurred */
+			u8 dmabuf_faulted:1;
 			struct mlx5_ib_mkey null_mmkey;
 		};
 	};
@@ -1814,4 +1804,14 @@ mlx5_umem_mkc_find_best_pgsz(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 	return ib_umem_find_best_pgsz(umem, bitmap, iova);
 }
 
+static inline unsigned long
+mlx5_umem_dmabuf_find_best_pgsz(struct ib_umem_dmabuf *umem_dmabuf,
+				int access_mode)
+{
+	return mlx5_umem_mkc_find_best_pgsz(to_mdev(umem_dmabuf->umem.ibdev),
+					    &umem_dmabuf->umem,
+					    umem_dmabuf->umem.iova,
+					    access_mode);
+}
+
 #endif /* MLX5_IB_H */
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 2cfe66a9839c..0e8ae85af5a6 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -836,9 +836,13 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 			       u32 *bytes_mapped, u32 flags)
 {
 	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(mr->umem);
+	int access_mode = mr->data_direct ? MLX5_MKC_ACCESS_MODE_KSM :
+					    MLX5_MKC_ACCESS_MODE_MTT;
+	unsigned int old_page_shift = mr->page_shift;
+	unsigned int page_shift;
+	unsigned long page_size;
 	u32 xlt_flags = 0;
 	int err;
-	unsigned long page_size;
 
 	if (flags & MLX5_PF_FLAGS_ENABLE)
 		xlt_flags |= MLX5_IB_UPD_XLT_ENABLE;
@@ -850,20 +854,33 @@ static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
 		return err;
 	}
 
-	page_size = mlx5_umem_dmabuf_find_best_pgsz(umem_dmabuf);
+	page_size = mlx5_umem_dmabuf_find_best_pgsz(umem_dmabuf, access_mode);
 	if (!page_size) {
 		ib_umem_dmabuf_unmap_pages(umem_dmabuf);
 		err = -EINVAL;
 	} else {
-		if (mr->data_direct)
-			err = mlx5r_umr_update_data_direct_ksm_pas(mr, xlt_flags);
-		else
-			err = mlx5r_umr_update_mr_pas(mr, xlt_flags);
+		page_shift = order_base_2(page_size);
+		if (page_shift != mr->page_shift && mr->dmabuf_faulted) {
+			err = mlx5r_umr_dmabuf_update_pgsz(mr, xlt_flags,
+							   page_shift);
+		} else {
+			mr->page_shift = page_shift;
+			if (mr->data_direct)
+				err = mlx5r_umr_update_data_direct_ksm_pas(
+					mr, xlt_flags);
+			else
+				err = mlx5r_umr_update_mr_pas(mr,
+							      xlt_flags);
+		}
 	}
 	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
 
-	if (err)
+	if (err) {
+		mr->page_shift = old_page_shift;
 		return err;
+	}
+
+	mr->dmabuf_faulted = 1;
 
 	if (bytes_mapped)
 		*bytes_mapped += bcnt;
diff --git a/drivers/infiniband/hw/mlx5/umr.c b/drivers/infiniband/hw/mlx5/umr.c
index 25601dea9e30..b097d8839cad 100644
--- a/drivers/infiniband/hw/mlx5/umr.c
+++ b/drivers/infiniband/hw/mlx5/umr.c
@@ -659,6 +659,8 @@ static void mlx5r_umr_final_update_xlt(struct mlx5_ib_dev *dev,
 		wqe->ctrl_seg.mkey_mask |= get_umr_update_translation_mask(dev);
 		if (!mr->ibmr.length)
 			MLX5_SET(mkc, &wqe->mkey_seg, length64, 1);
+		if (flags & MLX5_IB_UPD_XLT_KEEP_PGSZ)
+			wqe->ctrl_seg.mkey_mask &= ~MLX5_MKEY_MASK_PAGE_SIZE;
 	}
 
 	wqe->ctrl_seg.xlt_octowords =
@@ -666,46 +668,78 @@ static void mlx5r_umr_final_update_xlt(struct mlx5_ib_dev *dev,
 	wqe->data_seg.byte_count = cpu_to_be32(sg->length);
 }
 
+static void
+_mlx5r_umr_init_wqe(struct mlx5_ib_mr *mr, struct mlx5r_umr_wqe *wqe,
+		    struct ib_sge *sg, unsigned int flags,
+		    unsigned int page_shift, bool dd)
+{
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+
+	mlx5r_umr_set_update_xlt_ctrl_seg(&wqe->ctrl_seg, flags, sg);
+	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe->mkey_seg, mr, page_shift);
+	if (dd) /* Use the data direct internal kernel PD */
+		MLX5_SET(mkc, &wqe->mkey_seg, pd, dev->ddr.pdn);
+	mlx5r_umr_set_update_xlt_data_seg(&wqe->data_seg, sg);
+}
+
 static int
-_mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd)
+_mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd,
+			 size_t start_block, size_t nblocks)
 {
 	size_t ent_size = dd ? sizeof(struct mlx5_ksm) : sizeof(struct mlx5_mtt);
 	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
 	struct device *ddev = &dev->mdev->pdev->dev;
 	struct mlx5r_umr_wqe wqe = {};
+	size_t processed_blocks = 0;
 	struct ib_block_iter biter;
+	size_t cur_block_idx = 0;
 	struct mlx5_ksm *cur_ksm;
 	struct mlx5_mtt *cur_mtt;
 	size_t orig_sg_length;
+	size_t total_blocks;
 	size_t final_size;
 	void *curr_entry;
 	struct ib_sge sg;
 	void *entry;
-	u64 offset = 0;
+	u64 offset;
 	int err = 0;
 
-	entry = mlx5r_umr_create_xlt(dev, &sg,
-				     ib_umem_num_dma_blocks(mr->umem, 1 << mr->page_shift),
-				     ent_size, flags);
+	total_blocks = ib_umem_num_dma_blocks(mr->umem, 1UL << mr->page_shift);
+	if (start_block > total_blocks)
+		return -EINVAL;
+
+	/* nblocks 0 means update all blocks starting from start_block */
+	if (nblocks)
+		total_blocks = nblocks;
+
+	entry = mlx5r_umr_create_xlt(dev, &sg, total_blocks, ent_size, flags);
 	if (!entry)
 		return -ENOMEM;
 
 	orig_sg_length = sg.length;
-	mlx5r_umr_set_update_xlt_ctrl_seg(&wqe.ctrl_seg, flags, &sg);
-	mlx5r_umr_set_update_xlt_mkey_seg(dev, &wqe.mkey_seg, mr,
-					  mr->page_shift);
-	if (dd) {
-		/* Use the data direct internal kernel PD */
-		MLX5_SET(mkc, &wqe.mkey_seg, pd, dev->ddr.pdn);
+
+	_mlx5r_umr_init_wqe(mr, &wqe, &sg, flags, mr->page_shift, dd);
+
+	/* Set initial translation offset to start_block */
+	offset = (u64)start_block * ent_size;
+	mlx5r_umr_update_offset(&wqe.ctrl_seg, offset);
+
+	if (dd)
 		cur_ksm = entry;
-	} else {
+	else
 		cur_mtt = entry;
-	}
-
-	mlx5r_umr_set_update_xlt_data_seg(&wqe.data_seg, &sg);
 
 	curr_entry = entry;
+
 	rdma_umem_for_each_dma_block(mr->umem, &biter, BIT(mr->page_shift)) {
+		if (cur_block_idx < start_block) {
+			cur_block_idx++;
+			continue;
+		}
+
+		if (nblocks && processed_blocks >= nblocks)
+			break;
+
 		if (curr_entry == entry + sg.length) {
 			dma_sync_single_for_device(ddev, sg.addr, sg.length,
 						   DMA_TO_DEVICE);
@@ -727,6 +761,11 @@ _mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd)
 		if (dd) {
 			cur_ksm->va = cpu_to_be64(rdma_block_iter_dma_address(&biter));
 			cur_ksm->key = cpu_to_be32(dev->ddr.mkey);
+			if (mr->umem->is_dmabuf &&
+			    (flags & MLX5_IB_UPD_XLT_ZAP)) {
+				cur_ksm->va = 0;
+				cur_ksm->key = 0;
+			}
 			cur_ksm++;
 			curr_entry = cur_ksm;
 		} else {
@@ -738,6 +777,8 @@ _mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd)
 			cur_mtt++;
 			curr_entry = cur_mtt;
 		}
+
+		processed_blocks++;
 	}
 
 	final_size = curr_entry - entry;
@@ -754,13 +795,32 @@ _mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags, bool dd)
 	return err;
 }
 
-int mlx5r_umr_update_data_direct_ksm_pas(struct mlx5_ib_mr *mr, unsigned int flags)
+int mlx5r_umr_update_data_direct_ksm_pas_range(struct mlx5_ib_mr *mr,
+					       unsigned int flags,
+					       size_t start_block,
+					       size_t nblocks)
 {
 	/* No invalidation flow is expected */
-	if (WARN_ON(!mr->umem->is_dmabuf) || (flags & MLX5_IB_UPD_XLT_ZAP))
+	if (WARN_ON(!mr->umem->is_dmabuf) || ((flags & MLX5_IB_UPD_XLT_ZAP) &&
+	    !(flags & MLX5_IB_UPD_XLT_KEEP_PGSZ)))
 		return -EINVAL;
 
-	return _mlx5r_umr_update_mr_pas(mr, flags, true);
+	return _mlx5r_umr_update_mr_pas(mr, flags, true, start_block, nblocks);
+}
+
+int mlx5r_umr_update_data_direct_ksm_pas(struct mlx5_ib_mr *mr,
+					 unsigned int flags)
+{
+	return mlx5r_umr_update_data_direct_ksm_pas_range(mr, flags, 0, 0);
+}
+
+int mlx5r_umr_update_mr_pas_range(struct mlx5_ib_mr *mr, unsigned int flags,
+				  size_t start_block, size_t nblocks)
+{
+	if (WARN_ON(mr->umem->is_odp))
+		return -EINVAL;
+
+	return _mlx5r_umr_update_mr_pas(mr, flags, false, start_block, nblocks);
 }
 
 /*
@@ -770,10 +830,7 @@ int mlx5r_umr_update_data_direct_ksm_pas(struct mlx5_ib_mr *mr, unsigned int fla
  */
 int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
 {
-	if (WARN_ON(mr->umem->is_odp))
-		return -EINVAL;
-
-	return _mlx5r_umr_update_mr_pas(mr, flags, false);
+	return mlx5r_umr_update_mr_pas_range(mr, flags, 0, 0);
 }
 
 static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
@@ -866,3 +923,202 @@ int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	mlx5r_umr_unmap_free_xlt(dev, xlt, &sg);
 	return err;
 }
+
+/*
+ * Update only the page-size (log_page_size) field of an existing memory key
+ * using UMR.  This is useful when the MR's physical layout stays the same
+ * but the optimal page shift has changed (e.g. dmabuf after pages are
+ * pinned and the HW can switch from 4K to huge-page alignment).
+ */
+int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
+				   unsigned int page_shift,
+				   bool dd)
+{
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+	struct mlx5r_umr_wqe wqe = {};
+	int err;
+
+	/* Build UMR wqe: we touch only PAGE_SIZE, so use the dedicated mask */
+	wqe.ctrl_seg.mkey_mask = get_umr_update_translation_mask(dev);
+
+	/* MR must be free while page size is modified */
+	wqe.ctrl_seg.flags = MLX5_UMR_CHECK_FREE | MLX5_UMR_INLINE;
+
+	/* Fill mkey segment with the new page size, keep the rest unchanged */
+	MLX5_SET(mkc, &wqe.mkey_seg, log_page_size, page_shift);
+
+	if (dd)
+		MLX5_SET(mkc, &wqe.mkey_seg, pd, dev->ddr.pdn);
+	else
+		MLX5_SET(mkc, &wqe.mkey_seg, pd, to_mpd(mr->ibmr.pd)->pdn);
+
+	MLX5_SET64(mkc, &wqe.mkey_seg, start_addr, mr->ibmr.iova);
+	MLX5_SET64(mkc, &wqe.mkey_seg, len, mr->ibmr.length);
+	MLX5_SET(mkc, &wqe.mkey_seg, qpn, 0xffffff);
+	MLX5_SET(mkc, &wqe.mkey_seg, mkey_7_0,
+		 mlx5_mkey_variant(mr->mmkey.key));
+
+	err = mlx5r_umr_post_send_wait(dev, mr->mmkey.key, &wqe, false);
+	if (!err)
+		mr->page_shift = page_shift;
+
+	return err;
+}
+
+static inline int
+_mlx5r_dmabuf_umr_update_pas(struct mlx5_ib_mr *mr, unsigned int flags,
+			     size_t start_block, size_t nblocks, bool dd)
+{
+	if (dd)
+		return mlx5r_umr_update_data_direct_ksm_pas_range(mr, flags,
+								  start_block,
+								  nblocks);
+	else
+		return mlx5r_umr_update_mr_pas_range(mr, flags, start_block,
+						     nblocks);
+}
+
+/**
+ * This function makes an mkey non-present by zapping the translation entries of
+ * the mkey by zapping (zeroing out) the first N entries, where N is determined
+ * by the largest page size supported by the device and the MR length.
+ * It then updates the mkey's page size to the largest possible value, ensuring
+ * the MR is completely non-present and safe for further updates.
+ * It is useful to update the page size of a dmabuf MR on a page fault.
+ *
+ * Return: On success, returns the number of entries that were zapped.
+ *         On error, returns a negative error code.
+ */
+static int _mlx5r_umr_zap_mkey(struct mlx5_ib_mr *mr,
+			       unsigned int flags,
+			       unsigned int page_shift,
+			       bool dd)
+{
+	unsigned int old_page_shift = mr->page_shift;
+	struct mlx5_ib_dev *dev = mr_to_mdev(mr);
+	unsigned int max_page_shift;
+	size_t page_shift_nblocks;
+	unsigned int max_log_size;
+	int access_mode;
+	size_t nblocks;
+	int err;
+
+	access_mode = dd ? MLX5_MKC_ACCESS_MODE_KSM : MLX5_MKC_ACCESS_MODE_MTT;
+	flags |= MLX5_IB_UPD_XLT_KEEP_PGSZ | MLX5_IB_UPD_XLT_ZAP |
+		 MLX5_IB_UPD_XLT_ATOMIC;
+	max_log_size = get_max_log_entity_size_cap(dev, access_mode);
+	max_page_shift = order_base_2(mr->ibmr.length);
+	max_page_shift = min(max(max_page_shift, page_shift), max_log_size);
+	/* Count blocks in units of max_page_shift, we will zap exactly this
+	 * many to make the whole MR non-present.
+	 * Block size must be aligned to MLX5_UMR_FLEX_ALIGNMENT since it may
+	 * be used as offset into the XLT later on.
+	 */
+	nblocks = ib_umem_num_dma_blocks(mr->umem, 1UL << max_page_shift);
+	if (dd)
+		nblocks = ALIGN(nblocks, MLX5_UMR_KSM_NUM_ENTRIES_ALIGNMENT);
+	else
+		nblocks = ALIGN(nblocks, MLX5_UMR_MTT_NUM_ENTRIES_ALIGNMENT);
+	page_shift_nblocks = ib_umem_num_dma_blocks(mr->umem,
+						    1UL << page_shift);
+	/* If the number of blocks at max possible page shift is greater than
+	 * the number of blocks at the new page size, we should just go over the
+	 * whole mkey entries.
+	 */
+	if (nblocks >= page_shift_nblocks)
+		nblocks = 0;
+
+	/* Make the first nblocks entries non-present without changing
+	 * page size yet.
+	 */
+	if (nblocks)
+		mr->page_shift = max_page_shift;
+	err = _mlx5r_dmabuf_umr_update_pas(mr, flags, 0, nblocks, dd);
+	if (err) {
+		mr->page_shift = old_page_shift;
+		return err;
+	}
+
+	/* Change page size to the max page size now that the MR is completely
+	 * non-present.
+	 */
+	if (nblocks) {
+		err = mlx5r_umr_update_mr_page_shift(mr, max_page_shift, dd);
+		if (err) {
+			mr->page_shift = old_page_shift;
+			return err;
+		}
+	}
+
+	return err ? err : nblocks;
+}
+
+/**
+ * mlx5r_umr_dmabuf_update_pgsz - Safely update DMABUF MR page size and its
+ * entries accordingly
+ * @mr:        The memory region to update
+ * @xlt_flags: Translation table update flags
+ * @page_shift: The new (optimized) page shift to use
+ *
+ * This function updates the page size and mkey translation entries for a DMABUF
+ * MR in a safe, multi-step process to avoid exposing partially updated mappings
+ * The update is performed in 5 steps:
+ *   1. Make the first X entries non-present, while X is calculated to be
+ *        minimal according to a large page shift that can be used to cover the
+ *        MR length.
+ *   2. Update the page size to the large supported page size
+ *   3. Load the remaining N-X entries according to the (optimized) page_shift
+ *   4. Update the page size according to the (optimized) page_shift
+ *   5. Load the first X entries with the correct translations
+ *
+ * This ensures that at no point is the MR accessible with a partially updated
+ * translation table, maintaining correctness and preventing access to stale or
+ * inconsistent mappings.
+ *
+ * Returns 0 on success or a negative error code on failure.
+ */
+int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
+				 unsigned int page_shift)
+{
+	unsigned int old_page_shift = mr->page_shift;
+	size_t zapped_blocks;
+	size_t total_blocks;
+	int err;
+
+	zapped_blocks = _mlx5r_umr_zap_mkey(mr, xlt_flags, page_shift,
+					    mr->data_direct);
+	if (zapped_blocks < 0)
+		return zapped_blocks;
+
+	/* _mlx5r_umr_zap_mkey already enables the mkey */
+	xlt_flags &= ~MLX5_IB_UPD_XLT_ENABLE;
+	mr->page_shift = page_shift;
+	total_blocks = ib_umem_num_dma_blocks(mr->umem, 1UL << mr->page_shift);
+	if (zapped_blocks && zapped_blocks < total_blocks) {
+		/* Update PAS according to the new page size but don't update
+		 * the page size in the mkey yet.
+		 */
+		err = _mlx5r_dmabuf_umr_update_pas(
+			mr,
+			xlt_flags | MLX5_IB_UPD_XLT_KEEP_PGSZ,
+			zapped_blocks,
+			total_blocks - zapped_blocks,
+			mr->data_direct);
+		if (err)
+			goto err;
+	}
+
+	err = mlx5r_umr_update_mr_page_shift(mr, mr->page_shift,
+					     mr->data_direct);
+	if (err)
+		goto err;
+	err = _mlx5r_dmabuf_umr_update_pas(mr, xlt_flags, 0, zapped_blocks,
+					   mr->data_direct);
+	if (err)
+		goto err;
+
+	return 0;
+err:
+	mr->page_shift = old_page_shift;
+	return err;
+}
diff --git a/drivers/infiniband/hw/mlx5/umr.h b/drivers/infiniband/hw/mlx5/umr.h
index 4a02c9b5aad8..e9361f0140e7 100644
--- a/drivers/infiniband/hw/mlx5/umr.h
+++ b/drivers/infiniband/hw/mlx5/umr.h
@@ -94,9 +94,20 @@ struct mlx5r_umr_wqe {
 int mlx5r_umr_revoke_mr(struct mlx5_ib_mr *mr);
 int mlx5r_umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
 			      int access_flags);
-int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
+int mlx5r_umr_update_data_direct_ksm_pas_range(struct mlx5_ib_mr *mr,
+					       unsigned int flags,
+					       size_t start_block,
+					       size_t nblocks);
 int mlx5r_umr_update_data_direct_ksm_pas(struct mlx5_ib_mr *mr, unsigned int flags);
+int mlx5r_umr_update_mr_pas_range(struct mlx5_ib_mr *mr, unsigned int flags,
+				  size_t start_block, size_t nblocks);
+int mlx5r_umr_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
 int mlx5r_umr_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 			 int page_shift, int flags);
+int mlx5r_umr_update_mr_page_shift(struct mlx5_ib_mr *mr,
+				   unsigned int page_shift,
+				   bool dd);
+int mlx5r_umr_dmabuf_update_pgsz(struct mlx5_ib_mr *mr, u32 xlt_flags,
+				 unsigned int page_shift);
 
 #endif /* _MLX5_IB_UMR_H */
-- 
2.50.0


