Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68882298DB9
	for <lists+linux-rdma@lfdr.de>; Mon, 26 Oct 2020 14:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420720AbgJZNWr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 26 Oct 2020 09:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:54638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1776867AbgJZNTx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 26 Oct 2020 09:19:53 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2E7AA22263;
        Mon, 26 Oct 2020 13:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603718392;
        bh=JPuCe5u9OEkB8/Y1y7nvz/sBqX5UWhkeQcfUAU/nabY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1fOXn5YW+t33f6om0M76c2Fo/yGevb1SLxtbiqW9ksIk6Phc3rNVKQBRGXUAgwen
         cEKGl/PgN+RVX67wQMEqEfzhxhOmuh1E4GZ0u+umRXN/io/WXXEtiB9GRfTkVSaJMn
         o7B6H/YwBRQM1EL3WXzTm5q9g/t+GmSDbN/BqSe0=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 4/7] RDMA/mlx5: Move mlx5_ib_cont_pages() to the creation of the mlx5_ib_mr
Date:   Mon, 26 Oct 2020 15:19:33 +0200
Message-Id: <20201026131936.1335664-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026131936.1335664-1-leon@kernel.org>
References: <20201026131936.1335664-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

For the user MR path, instead of calling this after getting the umem, call
it as part of creating the struct mlx5_ib_mr and distill its output to a
single page_shift stored inside the mr.

This avoids passing around the tuple of its output. Based on the umem and
page_shift, the output arguments can be computed using:

  count == ib_umem_num_pages(mr->umem)
  shift == mr->page_shift
  ncont == ib_umem_num_dma_blocks(mr->umem, 1 << mr->page_shift)
  order == order_base_2(ncont)

And since mr->page_shift == umem_odp->page_shift then ncont ==
ib_umem_num_dma_blocks() == ib_umem_odp_num_pages() for ODP umems.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mem.c     |  11 +++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 +
 drivers/infiniband/hw/mlx5/mr.c      | 135 +++++++++++----------------
 3 files changed, 69 insertions(+), 78 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 13de3d2edd34..e63af1b05c0b 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -57,6 +57,17 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	struct scatterlist *sg;
 	int entry;
 
+	if (umem->is_odp) {
+		struct ib_umem_odp *odp = to_ib_umem_odp(umem);
+
+		*shift = odp->page_shift;
+		*ncont = ib_umem_odp_num_pages(odp);
+		*count = *ncont << (*shift - PAGE_SHIFT);
+		if (order)
+			*order = ilog2(roundup_pow_of_two(*count));
+		return;
+	}
+
 	addr = addr >> PAGE_SHIFT;
 	tmp = (unsigned long)addr;
 	m = find_first_bit(&tmp, BITS_PER_LONG);
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 0eaf992a4e15..9c1d206cb900 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -597,6 +597,7 @@ struct mlx5_ib_mr {
 	int			max_descs;
 	int			desc_size;
 	int			access_mode;
+	unsigned int		page_shift;
 	struct mlx5_core_mkey	mmkey;
 	struct ib_umem	       *umem;
 	struct mlx5_shared_mr_info	*smr_info;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c76134219bf2..f1e4b4c001fe 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -868,14 +868,11 @@ static int mr_cache_max_order(struct mlx5_ib_dev *dev)
 	return MLX5_MAX_UMR_SHIFT;
 }
 
-static int mr_umem_get(struct mlx5_ib_dev *dev, u64 start, u64 length,
-		       int access_flags, struct ib_umem **umem, int *npages,
-		       int *page_shift, int *ncont, int *order)
+static struct ib_umem *mr_umem_get(struct mlx5_ib_dev *dev, u64 start,
+				   u64 length, int access_flags)
 {
 	struct ib_umem *u;
 
-	*umem = NULL;
-
 	if (access_flags & IB_ACCESS_ON_DEMAND) {
 		struct ib_umem_odp *odp;
 
@@ -884,39 +881,17 @@ static int mr_umem_get(struct mlx5_ib_dev *dev, u64 start, u64 length,
 		if (IS_ERR(odp)) {
 			mlx5_ib_dbg(dev, "umem get failed (%ld)\n",
 				    PTR_ERR(odp));
-			return PTR_ERR(odp);
-		}
-
-		u = &odp->umem;
-
-		*page_shift = odp->page_shift;
-		*ncont = ib_umem_odp_num_pages(odp);
-		*npages = *ncont << (*page_shift - PAGE_SHIFT);
-		if (order)
-			*order = ilog2(roundup_pow_of_two(*ncont));
-	} else {
-		u = ib_umem_get(&dev->ib_dev, start, length, access_flags);
-		if (IS_ERR(u)) {
-			mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(u));
-			return PTR_ERR(u);
+			return ERR_CAST(odp);
 		}
-
-		mlx5_ib_cont_pages(u, start, MLX5_MKEY_PAGE_SHIFT_MASK, npages,
-				   page_shift, ncont, order);
+		return &odp->umem;
 	}
 
-	if (!*npages) {
-		mlx5_ib_warn(dev, "avoid zero region\n");
-		ib_umem_release(u);
-		return -EINVAL;
+	u = ib_umem_get(&dev->ib_dev, start, length, access_flags);
+	if (IS_ERR(u)) {
+		mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(u));
+		return u;
 	}
-
-	*umem = u;
-
-	mlx5_ib_dbg(dev, "npages %d, ncont %d, order %d, page_shift %d\n",
-		    *npages, *ncont, *order, *page_shift);
-
-	return 0;
+	return u;
 }
 
 static void mlx5_ib_umr_done(struct ib_cq *cq, struct ib_wc *wc)
@@ -975,15 +950,21 @@ static struct mlx5_cache_ent *mr_cache_ent_from_order(struct mlx5_ib_dev *dev,
 	return &cache->ent[order];
 }
 
-static struct mlx5_ib_mr *
-alloc_mr_from_cache(struct ib_pd *pd, struct ib_umem *umem, u64 virt_addr,
-		    u64 len, int npages, int page_shift, unsigned int order,
-		    int access_flags)
+static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
+					      struct ib_umem *umem, u64 iova,
+					      int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_cache_ent *ent = mr_cache_ent_from_order(dev, order);
+	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
+	int npages;
+	int page_shift;
+	int ncont;
+	int order;
 
+	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
+			   &page_shift, &ncont, &order);
+	ent = mr_cache_ent_from_order(dev, order);
 	if (!ent)
 		return ERR_PTR(-E2BIG);
 
@@ -1002,9 +983,10 @@ alloc_mr_from_cache(struct ib_pd *pd, struct ib_umem *umem, u64 virt_addr,
 	mr->umem = umem;
 	mr->access_flags = access_flags;
 	mr->desc_size = sizeof(struct mlx5_mtt);
-	mr->mmkey.iova = virt_addr;
-	mr->mmkey.size = len;
+	mr->mmkey.iova = iova;
+	mr->mmkey.size = umem->length;
 	mr->mmkey.pd = to_mpd(pd)->pdn;
+	mr->page_shift = page_shift;
 
 	return mr;
 }
@@ -1163,14 +1145,15 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
  * Else, the given ibmr will be used.
  */
 static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
-				     u64 virt_addr, u64 length,
-				     struct ib_umem *umem, int npages,
-				     int page_shift, int access_flags,
-				     bool populate)
+				     struct ib_umem *umem, u64 iova,
+				     int access_flags, bool populate)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr;
+	int page_shift;
 	__be64 *pas;
+	int npages;
+	int ncont;
 	void *mkc;
 	int inlen;
 	u32 *in;
@@ -1181,6 +1164,10 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	if (!mr)
 		return ERR_PTR(-ENOMEM);
 
+	mlx5_ib_cont_pages(umem, iova, MLX5_MKEY_PAGE_SHIFT_MASK, &npages,
+			   &page_shift, &ncont, NULL);
+
+	mr->page_shift = page_shift;
 	mr->ibmr.pd = pd;
 	mr->access_flags = access_flags;
 
@@ -1207,20 +1194,20 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	MLX5_SET(create_mkey_in, in, pg_access, !!(pg_cap));
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	set_mkc_access_pd_addr_fields(mkc, access_flags, virt_addr,
+	set_mkc_access_pd_addr_fields(mkc, access_flags, iova,
 				      populate ? pd : dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, !populate);
 	MLX5_SET(mkc, mkc, access_mode_1_0, MLX5_MKC_ACCESS_MODE_MTT);
 	MLX5_SET(mkc, mkc, umr_en, 1);
 
-	MLX5_SET64(mkc, mkc, len, length);
+	MLX5_SET64(mkc, mkc, len, umem->length);
 	MLX5_SET(mkc, mkc, bsf_octword_size, 0);
 	MLX5_SET(mkc, mkc, translations_octword_size,
-		 get_octo_len(virt_addr, length, page_shift));
+		 get_octo_len(iova, umem->length, page_shift));
 	MLX5_SET(mkc, mkc, log_page_size, page_shift);
 	if (populate) {
 		MLX5_SET(create_mkey_in, in, translations_octword_actual_size,
-			 get_octo_len(virt_addr, length, page_shift));
+			 get_octo_len(iova, umem->length, page_shift));
 	}
 
 	err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
@@ -1359,10 +1346,6 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	struct mlx5_ib_mr *mr = NULL;
 	bool xlt_with_umr;
 	struct ib_umem *umem;
-	int page_shift;
-	int npages;
-	int ncont;
-	int order;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
@@ -1390,23 +1373,20 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return &mr->ibmr;
 	}
 
-	err = mr_umem_get(dev, start, length, access_flags, &umem,
-			  &npages, &page_shift, &ncont, &order);
-
-	if (err < 0)
-		return ERR_PTR(err);
+	umem = mr_umem_get(dev, start, length, access_flags);
+	if (IS_ERR(umem))
+		return ERR_CAST(umem);
 
 	if (xlt_with_umr) {
-		mr = alloc_mr_from_cache(pd, umem, virt_addr, length, ncont,
-					 page_shift, order, access_flags);
+		mr = alloc_mr_from_cache(pd, umem, virt_addr, access_flags);
 		if (IS_ERR(mr))
 			mr = NULL;
 	}
 
 	if (!mr) {
 		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(NULL, pd, virt_addr, length, umem, ncont,
-				page_shift, access_flags, !xlt_with_umr);
+		mr = reg_create(NULL, pd, umem, virt_addr, access_flags,
+				!xlt_with_umr);
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 
@@ -1429,8 +1409,10 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		 */
 		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
 
-		err = mlx5_ib_update_xlt(mr, 0, ncont, page_shift,
-					 update_xlt_flags);
+		err = mlx5_ib_update_xlt(
+			mr, 0,
+			ib_umem_num_dma_blocks(umem, 1UL << mr->page_shift),
+			mr->page_shift, update_xlt_flags);
 		if (err) {
 			dereg_mr(dev, mr);
 			return ERR_PTR(err);
@@ -1520,11 +1502,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	int access_flags = flags & IB_MR_REREG_ACCESS ?
 			    new_access_flags :
 			    mr->access_flags;
-	int page_shift = 0;
 	int upd_flags = 0;
-	int npages = 0;
-	int ncont = 0;
-	int order = 0;
 	u64 addr, len;
 	int err;
 
@@ -1554,12 +1532,12 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		atomic_sub(ib_umem_num_pages(mr->umem),
 			   &dev->mdev->priv.reg_pages);
 		ib_umem_release(mr->umem);
-		mr->umem = NULL;
-
-		err = mr_umem_get(dev, addr, len, access_flags, &mr->umem,
-				  &npages, &page_shift, &ncont, &order);
-		if (err)
+		mr->umem = mr_umem_get(dev, addr, len, access_flags);
+		if (IS_ERR(mr->umem)) {
+			err = PTR_ERR(mr->umem);
+			mr->umem = NULL;
 			goto err;
+		}
 		atomic_add(ib_umem_num_pages(mr->umem),
 			   &dev->mdev->priv.reg_pages);
 	}
@@ -1578,9 +1556,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		if (err)
 			goto err;
 
-		mr = reg_create(ib_mr, pd, addr, len, mr->umem, ncont,
-				page_shift, access_flags, true);
-
+		mr = reg_create(ib_mr, pd, mr->umem, addr, access_flags, true);
 		if (IS_ERR(mr)) {
 			err = PTR_ERR(mr);
 			mr = to_mmr(ib_mr);
@@ -1602,8 +1578,11 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 				upd_flags |= MLX5_IB_UPD_XLT_PD;
 			if (flags & IB_MR_REREG_ACCESS)
 				upd_flags |= MLX5_IB_UPD_XLT_ACCESS;
-			err = mlx5_ib_update_xlt(mr, 0, npages, page_shift,
-						 upd_flags);
+			err = mlx5_ib_update_xlt(
+				mr, 0,
+				ib_umem_num_dma_blocks(mr->umem,
+						       1UL << mr->page_shift),
+				mr->page_shift, upd_flags);
 		} else {
 			err = rereg_umr(pd, mr, access_flags, flags);
 		}
-- 
2.26.2

