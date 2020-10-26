Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61817298DC1
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421676AbgJZNXh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:23:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:59110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421592AbgJZNXh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:23:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 96EB0207DE;
        Mon, 26 Oct 2020 13:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718616;
        bh=QTQFGTxEBeyihxn0zK2nRsy9q1t7FNss0+dJwN3bby4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aMKNPLR5XoMVlUxqquouCdAZWNoDgjmLHpBdbwI5o49QvuEfYPqU4WACUKGM401ZX
         dim9tnI2HeR0cvRa48SjBXUG3ohhra4l8pf0XDiLtSLlDMZjcnKeAhu0s1tjMZSPll
         DSolb/ghj85KCfwDP/QdXOQQpZJVZy+zSyo/O70A=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/5] RDMA/mlx5: Split mlx5_ib_update_xlt() into ODP and non-ODP cases
Date:   Mon, 26 Oct 2020 15:23:13 +0200
Message-Id: <20201026132314.1336717-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026132314.1336717-1-leon@kernel.org>
References: <20201026132314.1336717-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Mixing these together is just a mess, make a dedicated version,
mlx5_ib_update_mr_pas(), which directly loads the whole MTT for a non-ODP
MR.

The split out version can trivially use a simple loop with
rdma_for_each_block() which allows using the core code to compute the MR
pages and avoids seeking in the SGL list after each chunk as the
__mlx5_ib_populate_pas() call required.

Significantly speeds loading large MTTs.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mem.c     |  64 -------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 -
 drivers/infiniband/hw/mlx5/mr.c      | 137 +++++++++++++++++++--------
 3 files changed, 97 insertions(+), 107 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 779c4a040d8b..92e7621ec858 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -91,70 +91,6 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	*shift = PAGE_SHIFT + m;
 }
 
-/*
- * Populate the given array with bus addresses from the umem.
- *
- * dev - mlx5_ib device
- * umem - umem to use to fill the pages
- * page_shift - determines the page size used in the resulting array
- * offset - offset into the umem to start from,
- *          only implemented for ODP umems
- * num_pages - total number of pages to fill
- * pas - bus addresses array to fill
- * access_flags - access flags to set on all present pages.
-		  use enum mlx5_ib_mtt_access_flags for this.
- */
-void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
-			    int page_shift, size_t offset, size_t num_pages,
-			    __be64 *pas, int access_flags)
-{
-	int shift = page_shift - PAGE_SHIFT;
-	int mask = (1 << shift) - 1;
-	int i, k, idx;
-	u64 cur = 0;
-	u64 base;
-	int len;
-	struct scatterlist *sg;
-	int entry;
-
-	i = 0;
-	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
-		len = sg_dma_len(sg) >> PAGE_SHIFT;
-		base = sg_dma_address(sg);
-
-		/* Skip elements below offset */
-		if (i + len < offset << shift) {
-			i += len;
-			continue;
-		}
-
-		/* Skip pages below offset */
-		if (i < offset << shift) {
-			k = (offset << shift) - i;
-			i = offset << shift;
-		} else {
-			k = 0;
-		}
-
-		for (; k < len; k++) {
-			if (!(i & mask)) {
-				cur = base + (k << PAGE_SHIFT);
-				cur |= access_flags;
-				idx = (i >> shift) - offset;
-
-				pas[idx] = cpu_to_be64(cur);
-				mlx5_ib_dbg(dev, "pas[%d] 0x%llx\n",
-					    i >> shift, be64_to_cpu(pas[idx]));
-			}
-			i++;
-
-			/* Stop after num_pages reached */
-			if (i >> shift >= offset + num_pages)
-				return;
-		}
-	}
-}
-
 /*
  * Fill in a physical address list. ib_umem_num_dma_blocks() entries will be
  * filled in the pas array.
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d92afbd26aa5..aadd43425a58 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1232,9 +1232,6 @@ int mlx5_ib_query_port(struct ib_device *ibdev, u8 port,
 void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 			unsigned long max_page_shift,
 			int *shift);
-void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
-			    int page_shift, size_t offset, size_t num_pages,
-			    __be64 *pas, int access_flags);
 void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 			  u64 access_flags);
 void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b2ec4abc5639..10f13acc88c9 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1116,6 +1116,21 @@ static void mlx5_ib_unmap_free_xlt(struct mlx5_ib_dev *dev, void *xlt,
 	mlx5_ib_free_xlt(xlt, sg->length);
 }
 
+static unsigned int xlt_wr_final_send_flags(unsigned int flags)
+{
+	unsigned int res = 0;
+
+	if (flags & MLX5_IB_UPD_XLT_ENABLE)
+		res |= MLX5_IB_SEND_UMR_ENABLE_MR |
+		       MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS |
+		       MLX5_IB_SEND_UMR_UPDATE_TRANSLATION;
+	if (flags & MLX5_IB_UPD_XLT_PD || flags & MLX5_IB_UPD_XLT_ACCESS)
+		res |= MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS;
+	if (flags & MLX5_IB_UPD_XLT_ADDR)
+		res |= MLX5_IB_SEND_UMR_UPDATE_TRANSLATION;
+	return res;
+}
+
 int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		       int page_shift, int flags)
 {
@@ -1140,6 +1155,9 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	    !umr_can_use_indirect_mkey(dev))
 		return -EPERM;
 
+	if (WARN_ON(!mr->umem->is_odp))
+		return -EINVAL;
+
 	/* UMR copies MTTs in units of MLX5_UMR_MTT_ALIGNMENT bytes,
 	 * so we need to align the offset and length accordingly
 	 */
@@ -1155,13 +1173,11 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	pages_iter = sg.length / desc_size;
 	orig_sg_length = sg.length;
 
-	if (mr->umem->is_odp) {
-		if (!(flags & MLX5_IB_UPD_XLT_INDIRECT)) {
-			struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
-			size_t max_pages = ib_umem_odp_num_pages(odp) - idx;
+	if (!(flags & MLX5_IB_UPD_XLT_INDIRECT)) {
+		struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+		size_t max_pages = ib_umem_odp_num_pages(odp) - idx;
 
-			pages_to_map = min_t(size_t, pages_to_map, max_pages);
-		}
+		pages_to_map = min_t(size_t, pages_to_map, max_pages);
 	}
 
 	wr.page_shift = page_shift;
@@ -1173,36 +1189,14 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 		size_to_map = npages * desc_size;
 		dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
 					DMA_TO_DEVICE);
-		if (mr->umem->is_odp) {
-			mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
-		} else {
-			__mlx5_ib_populate_pas(dev, mr->umem, page_shift, idx,
-					       npages, xlt,
-					       MLX5_IB_MTT_PRESENT);
-			/* Clear padding after the pages
-			 * brought from the umem.
-			 */
-			memset(xlt + size_to_map, 0, sg.length - size_to_map);
-		}
+		mlx5_odp_populate_xlt(xlt, idx, npages, mr, flags);
 		dma_sync_single_for_device(ddev, sg.addr, sg.length,
 					   DMA_TO_DEVICE);
 
 		sg.length = ALIGN(size_to_map, MLX5_UMR_MTT_ALIGNMENT);
 
-		if (pages_mapped + pages_iter >= pages_to_map) {
-			if (flags & MLX5_IB_UPD_XLT_ENABLE)
-				wr.wr.send_flags |=
-					MLX5_IB_SEND_UMR_ENABLE_MR |
-					MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS |
-					MLX5_IB_SEND_UMR_UPDATE_TRANSLATION;
-			if (flags & MLX5_IB_UPD_XLT_PD ||
-			    flags & MLX5_IB_UPD_XLT_ACCESS)
-				wr.wr.send_flags |=
-					MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS;
-			if (flags & MLX5_IB_UPD_XLT_ADDR)
-				wr.wr.send_flags |=
-					MLX5_IB_SEND_UMR_UPDATE_TRANSLATION;
-		}
+		if (pages_mapped + pages_iter >= pages_to_map)
+			wr.wr.send_flags |= xlt_wr_final_send_flags(flags);
 
 		wr.offset = idx * desc_size;
 		wr.xlt_size = sg.length;
@@ -1214,6 +1208,69 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
 	return err;
 }
 
+/*
+ * Send the DMA list to the HW for a normal MR using UMR.
+ */
+static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
+{
+	struct mlx5_ib_dev *dev = mr->dev;
+	struct device *ddev = dev->ib_dev.dev.parent;
+	struct ib_block_iter biter;
+	struct mlx5_mtt *cur_mtt;
+	struct mlx5_umr_wr wr;
+	size_t orig_sg_length;
+	struct mlx5_mtt *mtt;
+	size_t final_size;
+	struct ib_sge sg;
+	int err = 0;
+
+	if (WARN_ON(mr->umem->is_odp))
+		return -EINVAL;
+
+	mtt = mlx5_ib_create_xlt_wr(mr, &wr, &sg,
+				    ib_umem_num_dma_blocks(mr->umem,
+							   1 << mr->page_shift),
+				    sizeof(*mtt), flags);
+	if (!mtt)
+		return -ENOMEM;
+	orig_sg_length = sg.length;
+
+	cur_mtt = mtt;
+	rdma_for_each_block (mr->umem->sg_head.sgl, &biter, mr->umem->nmap,
+			     BIT(mr->page_shift)) {
+		if (cur_mtt == (void *)mtt + sg.length) {
+			dma_sync_single_for_device(ddev, sg.addr, sg.length,
+						   DMA_TO_DEVICE);
+			err = mlx5_ib_post_send_wait(dev, &wr);
+			if (err)
+				goto err;
+			dma_sync_single_for_cpu(ddev, sg.addr, sg.length,
+						DMA_TO_DEVICE);
+			wr.offset += sg.length;
+			cur_mtt = mtt;
+		}
+
+		cur_mtt->ptag =
+			cpu_to_be64(rdma_block_iter_dma_address(&biter) |
+				    MLX5_IB_MTT_PRESENT);
+		cur_mtt++;
+	}
+
+	final_size = (void *)cur_mtt - (void *)mtt;
+	sg.length = ALIGN(final_size, MLX5_UMR_MTT_ALIGNMENT);
+	memset(cur_mtt, 0, sg.length - final_size);
+	wr.wr.send_flags |= xlt_wr_final_send_flags(flags);
+	wr.xlt_size = sg.length;
+
+	dma_sync_single_for_device(ddev, sg.addr, sg.length, DMA_TO_DEVICE);
+	err = mlx5_ib_post_send_wait(dev, &wr);
+
+err:
+	sg.length = orig_sg_length;
+	mlx5_ib_unmap_free_xlt(dev, mtt, &sg);
+	return err;
+}
+
 /*
  * If ibmr is NULL it will be allocated by reg_create.
  * Else, the given ibmr will be used.
@@ -1483,10 +1540,14 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		 */
 		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
 
-		err = mlx5_ib_update_xlt(
-			mr, 0,
-			ib_umem_num_dma_blocks(umem, 1UL << mr->page_shift),
-			mr->page_shift, update_xlt_flags);
+		if (is_odp_mr(mr))
+			err = mlx5_ib_update_xlt(
+				mr, 0,
+				ib_umem_num_dma_blocks(umem,
+						       1UL << mr->page_shift),
+				mr->page_shift, update_xlt_flags);
+		else
+			err = mlx5_ib_update_mr_pas(mr, update_xlt_flags);
 		if (err) {
 			dereg_mr(dev, mr);
 			return ERR_PTR(err);
@@ -1652,11 +1713,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 				upd_flags |= MLX5_IB_UPD_XLT_PD;
 			if (flags & IB_MR_REREG_ACCESS)
 				upd_flags |= MLX5_IB_UPD_XLT_ACCESS;
-			err = mlx5_ib_update_xlt(
-				mr, 0,
-				ib_umem_num_dma_blocks(mr->umem,
-						       1UL << mr->page_shift),
-				mr->page_shift, upd_flags);
+			err = mlx5_ib_update_mr_pas(mr, upd_flags);
 		} else {
 			err = rereg_umr(pd, mr, access_flags, flags);
 		}
-- 
2.26.2

