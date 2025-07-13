Return-Path: <linux-rdma+bounces-12082-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE3AB02EF5
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 08:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7959F189DD2C
	for <lists+linux-rdma@lfdr.de>; Sun, 13 Jul 2025 06:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8971C700D;
	Sun, 13 Jul 2025 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tStDjSUM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BABC1A23A6
	for <linux-rdma@vger.kernel.org>; Sun, 13 Jul 2025 06:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752388690; cv=none; b=PglORyDF1+hi6MKm6T4+96JmFFZMpHSmJqTirrygv88jHoQ6i+h29HqX7LGGghGi5EKji10LHPei22jIaI75ehijzp6MX/CR3GVExfU68OXm6UItOZNh7ighlBhs5DzTAUA5RpX6QBZO+F2mYNlehy/QbJDqvgyaT2U+gmghoKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752388690; c=relaxed/simple;
	bh=/dFrOXU/0GkJD6w4ywaP+gU9+tOkkUUx5pjvq+TbLtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d09W/PUM8nShjmTfM8VDkrc5UH/7vznPm0ZQHGDdcVVzVUkwtUOnCagPtoiISq95f4S4DRrG2V/bh9htM8XnaYpR2kweRt1Doe+XuIwk5yqTEGphtn/LQQ9rAD5YqKkPshPKYPId6p7StrzIfS4Y06ii05DmJgG9PNOaRyuHYx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tStDjSUM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEA1C4CEE3;
	Sun, 13 Jul 2025 06:38:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752388690;
	bh=/dFrOXU/0GkJD6w4ywaP+gU9+tOkkUUx5pjvq+TbLtA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tStDjSUM7FokSr6XxBvojeU9Ubs9nV8mKyUA7amOtfypZGsFcqaJ12SlXaZJkTj8x
	 6gXrEXSZ1V3Fa1yF6DuiwK92hU2RHWLb2Awax0uGDEv1ENfbu2DxvLaPUD8aZAWSGC
	 4DmfjLq4wUTYSHQ9YtY2W0LVxAEJRj9/aLpXB7y1cVffX4bnMeEmIt2O8Aa6Njdd9B
	 pPLnDwKw3V4SMIWeNZyF7GpH0jwC+gkjMyLPQgwQ5R3zqmB+l06mcQjWXQ4u0c2uzX
	 UZ2gFWzcbzgeHAquvQN/VaDbfFMt8D/vf14dWUU1ZT5hw0xQSKhQjDN1VUADBKoHMb
	 /ecy9I5aEE4Rw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 8/8] RDMA/mlx5: Add DMAH support for reg_user_mr/reg_user_dmabuf_mr
Date: Sun, 13 Jul 2025 09:37:29 +0300
Message-ID: <fd902d95c62d38ad2b4acebc91f9b3ac685cab3c.1752388126.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752388126.git.leon@kernel.org>
References: <cover.1752388126.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yishai Hadas <yishaih@nvidia.com>

As part of this enhancement, allow the creation of an MKEY associated
with a DMA handle.

Additional notes:

MKEYs with TPH (i.e. TLP Processing Hints) attributes are currently not
UMR-capable unless explicitly enabled by firmware or hardware.
Therefore, to maintain such MKEYs in the MR cache, the TPH fields have
been added to the rb_key structure, with a dedicated hash bucket.

The ability to bypass the kernel verbs flow and create an MKEY with TPH
attributes using DEVX has been restricted. TPH must follow the standard
InfiniBand flow, where a DMAH is created with the appropriate security
checks and management mechanisms in place.

DMA handles are currently not supported in conjunction with On-Demand
Paging (ODP).

Re-registration of memory regions originally created with TPH attributes
is currently not supported.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Reviewed-by: Edward Srouji <edwards@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/devx.c    |   4 ++
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   5 ++
 drivers/infiniband/hw/mlx5/mr.c      | 101 ++++++++++++++++++++++-----
 drivers/infiniband/hw/mlx5/odp.c     |   1 +
 4 files changed, 92 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index c03fe5414b9a..c6ced06111dd 100644
--- a/drivers/infiniband/hw/mlx5/devx.c
+++ b/drivers/infiniband/hw/mlx5/devx.c
@@ -1393,6 +1393,10 @@ static int devx_handle_mkey_create(struct mlx5_ib_dev *dev,
 	}
 
 	MLX5_SET(create_mkey_in, in, mkey_umem_valid, 1);
+	/* TPH is not allowed to bypass the regular kernel's verbs flow */
+	MLX5_SET(mkc, mkc, pcie_tph_en, 0);
+	MLX5_SET(mkc, mkc, pcie_tph_steering_tag_index,
+		 MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX);
 	return 0;
 }
 
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 71916d730be0..3452695944e8 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -650,8 +650,13 @@ enum mlx5_mkey_type {
 	MLX5_MKEY_IMPLICIT_CHILD,
 };
 
+/* Used for non-existent ph value */
+#define MLX5_IB_NO_PH 0xff
+
 struct mlx5r_cache_rb_key {
 	u8 ats:1;
+	u8 ph;
+	u16 st_index;
 	unsigned int access_mode;
 	unsigned int access_flags;
 	unsigned int ndescs;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8deff7cdf048..5805d8231710 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -44,6 +44,7 @@
 #include "mlx5_ib.h"
 #include "umr.h"
 #include "data_direct.h"
+#include "dmah.h"
 
 enum {
 	MAX_PENDING_REG_MR = 8,
@@ -57,7 +58,7 @@ create_mkey_callback(int status, struct mlx5_async_work *context);
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
 				     unsigned long page_size, bool populate,
-				     int access_mode);
+				     int access_mode, u16 st_index, u8 ph);
 static int __mlx5_ib_dereg_mr(struct ib_mr *ibmr);
 
 static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
@@ -256,6 +257,14 @@ static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
 		 get_mkc_octo_size(ent->rb_key.access_mode,
 				   ent->rb_key.ndescs));
 	MLX5_SET(mkc, mkc, log_page_size, PAGE_SHIFT);
+
+	if (ent->rb_key.ph != MLX5_IB_NO_PH) {
+		MLX5_SET(mkc, mkc, pcie_tph_en, 1);
+		MLX5_SET(mkc, mkc, pcie_tph_ph, ent->rb_key.ph);
+		if (ent->rb_key.st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+			MLX5_SET(mkc, mkc, pcie_tph_steering_tag_index,
+				 ent->rb_key.st_index);
+	}
 }
 
 /* Asynchronously schedule new MRs to be populated in the cache. */
@@ -641,6 +650,14 @@ static int cache_ent_key_cmp(struct mlx5r_cache_rb_key key1,
 	if (res)
 		return res;
 
+	res = key1.st_index - key2.st_index;
+	if (res)
+		return res;
+
+	res = key1.ph - key2.ph;
+	if (res)
+		return res;
+
 	/*
 	 * keep ndescs the last in the compare table since the find function
 	 * searches for an exact match on all properties and only closest
@@ -712,6 +729,8 @@ mkey_cache_ent_from_rb_key(struct mlx5_ib_dev *dev,
 		smallest->rb_key.access_mode == rb_key.access_mode &&
 		smallest->rb_key.access_flags == rb_key.access_flags &&
 		smallest->rb_key.ats == rb_key.ats &&
+		smallest->rb_key.st_index == rb_key.st_index &&
+		smallest->rb_key.ph == rb_key.ph &&
 		smallest->rb_key.ndescs <= ndescs_limit) ?
 		       smallest :
 		       NULL;
@@ -786,7 +805,8 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	struct mlx5r_cache_rb_key rb_key = {
 		.ndescs = ndescs,
 		.access_mode = access_mode,
-		.access_flags = get_unchangeable_access_flags(dev, access_flags)
+		.access_flags = get_unchangeable_access_flags(dev, access_flags),
+		.ph = MLX5_IB_NO_PH,
 	};
 	struct mlx5_cache_ent *ent = mkey_cache_ent_from_rb_key(dev, rb_key);
 
@@ -979,6 +999,7 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	struct rb_root *root = &dev->cache.rb_root;
 	struct mlx5r_cache_rb_key rb_key = {
 		.access_mode = MLX5_MKC_ACCESS_MODE_MTT,
+		.ph = MLX5_IB_NO_PH,
 	};
 	struct mlx5_cache_ent *ent;
 	struct rb_node *node;
@@ -1155,7 +1176,8 @@ static unsigned int mlx5_umem_dmabuf_default_pgsz(struct ib_umem *umem,
 
 static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 					     struct ib_umem *umem, u64 iova,
-					     int access_flags, int access_mode)
+					     int access_flags, int access_mode,
+					     u16 st_index, u8 ph)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5r_cache_rb_key rb_key = {};
@@ -1174,6 +1196,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	rb_key.ndescs = ib_umem_num_dma_blocks(umem, page_size);
 	rb_key.ats = mlx5_umem_needs_ats(dev, umem, access_flags);
 	rb_key.access_flags = get_unchangeable_access_flags(dev, access_flags);
+	rb_key.st_index = st_index;
+	rb_key.ph = ph;
 	ent = mkey_cache_ent_from_rb_key(dev, rb_key);
 	/*
 	 * If the MR can't come from the cache then synchronously create an uncached
@@ -1181,7 +1205,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	 */
 	if (!ent) {
 		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(pd, umem, iova, access_flags, page_size, false, access_mode);
+		mr = reg_create(pd, umem, iova, access_flags, page_size, false, access_mode,
+				st_index, ph);
 		mutex_unlock(&dev->slow_path_mutex);
 		if (IS_ERR(mr))
 			return mr;
@@ -1266,7 +1291,7 @@ reg_create_crossing_vhca_mr(struct ib_pd *pd, u64 iova, u64 length, int access_f
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
 				     unsigned long page_size, bool populate,
-				     int access_mode)
+				     int access_mode, u16 st_index, u8 ph)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr;
@@ -1340,6 +1365,13 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 			 get_octo_len(iova, umem->length, mr->page_shift));
 	}
 
+	if (ph != MLX5_IB_NO_PH) {
+		MLX5_SET(mkc, mkc, pcie_tph_en, 1);
+		MLX5_SET(mkc, mkc, pcie_tph_ph, ph);
+		if (st_index != MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX)
+			MLX5_SET(mkc, mkc, pcie_tph_steering_tag_index, st_index);
+	}
+
 	err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
 	if (err) {
 		mlx5_ib_warn(dev, "create mkey failed\n");
@@ -1459,24 +1491,37 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 }
 
 static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
-				    u64 iova, int access_flags)
+				    u64 iova, int access_flags,
+				    struct ib_dmah *dmah)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr = NULL;
 	bool xlt_with_umr;
+	u16 st_index = MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX;
+	u8 ph = MLX5_IB_NO_PH;
 	int err;
 
+	if (dmah) {
+		struct mlx5_ib_dmah *mdmah = to_mdmah(dmah);
+
+		ph = dmah->ph;
+		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+			st_index = mdmah->st_index;
+	}
+
 	xlt_with_umr = mlx5r_umr_can_load_pas(dev, umem->length);
 	if (xlt_with_umr) {
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags,
-					MLX5_MKC_ACCESS_MODE_MTT);
+					MLX5_MKC_ACCESS_MODE_MTT,
+					st_index, ph);
 	} else {
 		unsigned long page_size =
 			mlx5_umem_mkc_find_best_pgsz(dev, umem, iova);
 
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size,
-				true, MLX5_MKC_ACCESS_MODE_MTT);
+				true, MLX5_MKC_ACCESS_MODE_MTT,
+				st_index, ph);
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
@@ -1540,7 +1585,9 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 		return ERR_CAST(odp);
 
 	mr = alloc_cacheable_mr(pd, &odp->umem, iova, access_flags,
-				MLX5_MKC_ACCESS_MODE_MTT);
+				MLX5_MKC_ACCESS_MODE_MTT,
+				MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX,
+				MLX5_IB_NO_PH);
 	if (IS_ERR(mr)) {
 		ib_umem_release(&odp->umem);
 		return ERR_CAST(mr);
@@ -1571,7 +1618,8 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	struct ib_umem *umem;
 	int err;
 
-	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || dmah)
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) ||
+	    ((access_flags & IB_ACCESS_ON_DEMAND) && dmah))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mlx5_ib_dbg(dev, "start 0x%llx, iova 0x%llx, length 0x%llx, access_flags 0x%x\n",
@@ -1587,7 +1635,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	umem = ib_umem_get(&dev->ib_dev, start, length, access_flags);
 	if (IS_ERR(umem))
 		return ERR_CAST(umem);
-	return create_real_mr(pd, umem, iova, access_flags);
+	return create_real_mr(pd, umem, iova, access_flags, dmah);
 }
 
 static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
@@ -1612,12 +1660,15 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops = {
 static struct ib_mr *
 reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		   u64 offset, u64 length, u64 virt_addr,
-		   int fd, int access_flags, int access_mode)
+		   int fd, int access_flags, int access_mode,
+		   struct ib_dmah *dmah)
 {
 	bool pinned_mode = (access_mode == MLX5_MKC_ACCESS_MODE_KSM);
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr = NULL;
 	struct ib_umem_dmabuf *umem_dmabuf;
+	u16 st_index = MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX;
+	u8 ph = MLX5_IB_NO_PH;
 	int err;
 
 	err = mlx5r_umr_resource_init(dev);
@@ -1640,8 +1691,17 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
 		return ERR_CAST(umem_dmabuf);
 	}
 
+	if (dmah) {
+		struct mlx5_ib_dmah *mdmah = to_mdmah(dmah);
+
+		ph = dmah->ph;
+		if (dmah->valid_fields & BIT(IB_DMAH_CPU_ID_EXISTS))
+			st_index = mdmah->st_index;
+	}
+
 	mr = alloc_cacheable_mr(pd, &umem_dmabuf->umem, virt_addr,
-				access_flags, access_mode);
+				access_flags, access_mode,
+				st_index, ph);
 	if (IS_ERR(mr)) {
 		ib_umem_release(&umem_dmabuf->umem);
 		return ERR_CAST(mr);
@@ -1698,7 +1758,8 @@ reg_user_mr_dmabuf_by_data_direct(struct ib_pd *pd, u64 offset,
 	access_flags &= ~IB_ACCESS_RELAXED_ORDERING;
 	crossed_mr = reg_user_mr_dmabuf(pd, &data_direct_dev->pdev->dev,
 					offset, length, virt_addr, fd,
-					access_flags, MLX5_MKC_ACCESS_MODE_KSM);
+					access_flags, MLX5_MKC_ACCESS_MODE_KSM,
+					NULL);
 	if (IS_ERR(crossed_mr)) {
 		ret = PTR_ERR(crossed_mr);
 		goto end;
@@ -1733,7 +1794,7 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 	int err;
 
 	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) ||
-	    !IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) || dmah)
+	    !IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_REG_DMABUF_MR_ACCESS_FLAGS)) {
@@ -1758,7 +1819,8 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 
 	return reg_user_mr_dmabuf(pd, pd->device->dma_device,
 				  offset, length, virt_addr,
-				  fd, access_flags, MLX5_MKC_ACCESS_MODE_MTT);
+				  fd, access_flags, MLX5_MKC_ACCESS_MODE_MTT,
+				  dmah);
 }
 
 /*
@@ -1855,7 +1917,8 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	struct mlx5_ib_mr *mr = to_mmr(ib_mr);
 	int err;
 
-	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || mr->data_direct)
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || mr->data_direct ||
+	    mr->mmkey.rb_key.ph != MLX5_IB_NO_PH)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mlx5_ib_dbg(
@@ -1899,7 +1962,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		atomic_sub(ib_umem_num_pages(umem), &dev->mdev->priv.reg_pages);
 
 		return create_real_mr(new_pd, umem, mr->ibmr.iova,
-				      new_access_flags);
+				      new_access_flags, NULL);
 	}
 
 	/*
@@ -1930,7 +1993,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			}
 			return NULL;
 		}
-		return create_real_mr(new_pd, new_umem, iova, new_access_flags);
+		return create_real_mr(new_pd, new_umem, iova, new_access_flags, NULL);
 	}
 
 	/*
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index f6abd64f07f7..2cfe66a9839c 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1866,6 +1866,7 @@ int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev)
 	struct mlx5r_cache_rb_key rb_key = {
 		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
 		.ndescs = mlx5_imr_ksm_entries,
+		.ph = MLX5_IB_NO_PH,
 	};
 	struct mlx5_cache_ent *ent;
 
-- 
2.50.1


