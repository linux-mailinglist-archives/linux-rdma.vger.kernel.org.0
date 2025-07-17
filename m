Return-Path: <linux-rdma+bounces-12266-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A06B08CB1
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 14:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28E7E7AE230
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 12:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5592BD004;
	Thu, 17 Jul 2025 12:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2Y0lLVA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41E42BCF7C
	for <linux-rdma@vger.kernel.org>; Thu, 17 Jul 2025 12:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752754700; cv=none; b=f05mjVseFdc1INczL0ucoLgtrqJ/Dz1ECQBZf7M0tXWxzkG7rVO7wmt8HytVuxLGYxhboj/Y3PJfZy7wOpL56pvbFWbtDO8TTU6r/DPuxNxiPjoVx3/t0vB18H9fgbEk/akR5zGwuG9jrtLJm04v+GKQGs/QCA7z/FxsX8afIPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752754700; c=relaxed/simple;
	bh=5ypDLEcEKah39g0U6iP9ZKgfKiekvKJwh7jm5qdCYMs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Bq16wyzKzqVKod0HzXqOKePqleO7fB5u8GXndM26JqJeMP7WYE+mtu6HtTGipy4vtGibA/rjhxb+8KMzCnogdwrONCxDNytzb+dDCHUMtOcvJVbtWQwdysSwsOv2uFBj7/y01KVax3omBXMmA6/JJceLYYAOulT5YfBuQUqyQWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2Y0lLVA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8028C4CEE3;
	Thu, 17 Jul 2025 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752754700;
	bh=5ypDLEcEKah39g0U6iP9ZKgfKiekvKJwh7jm5qdCYMs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R2Y0lLVAisEC7lhx6XOL6kVZ2J+GVlnoW/jCsNfF/s+gipBaSC+s6aEDsoZ+r9aHq
	 TfQ6qKizibRnUKxU7Ijq2SyTHr2sNyNx7ZdRkyfU39hznDsUaMC3XMrnky18UwKBBa
	 1MlAChxoGBm4wzDNfEYsN61viI9BgvLZOJDjOqVQJJ9cQn0ZzxRIDSpnLceSmiR+pu
	 FZo+kXDz34NfhZZkxSa2SwKpE/a0flO1T2xLzOXYkv35YNlffxcpo1Z3SDHMfPbgd5
	 +m7LalpfzIX1eNSaVeD9+3HY/nPtP1v++hyiQX2f0M9C9MuvrvYks/JwTPp7DM1Jbl
	 DtpZgfVqu0xpw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Yishai Hadas <yishaih@nvidia.com>,
	Edward Srouji <edwards@nvidia.com>,
	linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v2 8/8] RDMA/mlx5: Add DMAH support for reg_user_mr/reg_user_dmabuf_mr
Date: Thu, 17 Jul 2025 15:17:32 +0300
Message-ID: <1c485651cf8417694ddebb80446c5093d5a791a9.1752752567.git.leon@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752752567.git.leon@kernel.org>
References: <cover.1752752567.git.leon@kernel.org>
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
 drivers/infiniband/hw/mlx5/mr.c      | 104 +++++++++++++++++++++------
 drivers/infiniband/hw/mlx5/odp.c     |   1 +
 4 files changed, 94 insertions(+), 20 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
index c03fe5414b9aa..c6ced06111dd0 100644
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
index dfd231333509d..692ec31d937a9 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -638,8 +638,13 @@ enum mlx5_mkey_type {
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
index c47d7e3b3ecbe..49d0bcfa69415 100644
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
@@ -1175,6 +1197,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	rb_key.ndescs = ib_umem_num_dma_blocks(umem, page_size);
 	rb_key.ats = mlx5_umem_needs_ats(dev, umem, access_flags);
 	rb_key.access_flags = get_unchangeable_access_flags(dev, access_flags);
+	rb_key.st_index = st_index;
+	rb_key.ph = ph;
 	ent = mkey_cache_ent_from_rb_key(dev, rb_key);
 	/*
 	 * If the MR can't come from the cache then synchronously create an uncached
@@ -1182,7 +1206,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	 */
 	if (!ent) {
 		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(pd, umem, iova, access_flags, page_size, false, access_mode);
+		mr = reg_create(pd, umem, iova, access_flags, page_size, false, access_mode,
+				st_index, ph);
 		mutex_unlock(&dev->slow_path_mutex);
 		if (IS_ERR(mr))
 			return mr;
@@ -1267,7 +1292,7 @@ reg_create_crossing_vhca_mr(struct ib_pd *pd, u64 iova, u64 length, int access_f
 static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 				     u64 iova, int access_flags,
 				     unsigned long page_size, bool populate,
-				     int access_mode)
+				     int access_mode, u16 st_index, u8 ph)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr;
@@ -1277,7 +1302,8 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
 	u32 *in;
 	int err;
 	bool pg_cap = !!(MLX5_CAP_GEN(dev->mdev, pg)) &&
-		(access_mode == MLX5_MKC_ACCESS_MODE_MTT);
+		(access_mode == MLX5_MKC_ACCESS_MODE_MTT) &&
+		(ph == MLX5_IB_NO_PH);
 	bool ksm_mode = (access_mode == MLX5_MKC_ACCESS_MODE_KSM);
 
 	if (!page_size)
@@ -1341,6 +1367,13 @@ static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
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
@@ -1460,24 +1493,37 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
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
 		unsigned long page_size = mlx5_umem_mkc_find_best_pgsz(
 				dev, umem, iova, MLX5_MKC_ACCESS_MODE_MTT);
 
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(pd, umem, iova, access_flags, page_size,
-				true, MLX5_MKC_ACCESS_MODE_MTT);
+				true, MLX5_MKC_ACCESS_MODE_MTT,
+				st_index, ph);
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
@@ -1541,7 +1587,9 @@ static struct ib_mr *create_user_odp_mr(struct ib_pd *pd, u64 start, u64 length,
 		return ERR_CAST(odp);
 
 	mr = alloc_cacheable_mr(pd, &odp->umem, iova, access_flags,
-				MLX5_MKC_ACCESS_MODE_MTT);
+				MLX5_MKC_ACCESS_MODE_MTT,
+				MLX5_MKC_PCIE_TPH_NO_STEERING_TAG_INDEX,
+				MLX5_IB_NO_PH);
 	if (IS_ERR(mr)) {
 		ib_umem_release(&odp->umem);
 		return ERR_CAST(mr);
@@ -1572,7 +1620,8 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	struct ib_umem *umem;
 	int err;
 
-	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || dmah)
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) ||
+	    ((access_flags & IB_ACCESS_ON_DEMAND) && dmah))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mlx5_ib_dbg(dev, "start 0x%llx, iova 0x%llx, length 0x%llx, access_flags 0x%x\n",
@@ -1588,7 +1637,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	umem = ib_umem_get(&dev->ib_dev, start, length, access_flags);
 	if (IS_ERR(umem))
 		return ERR_CAST(umem);
-	return create_real_mr(pd, umem, iova, access_flags);
+	return create_real_mr(pd, umem, iova, access_flags, dmah);
 }
 
 static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
@@ -1613,12 +1662,15 @@ static struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops = {
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
@@ -1641,8 +1693,17 @@ reg_user_mr_dmabuf(struct ib_pd *pd, struct device *dma_device,
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
@@ -1699,7 +1760,8 @@ reg_user_mr_dmabuf_by_data_direct(struct ib_pd *pd, u64 offset,
 	access_flags &= ~IB_ACCESS_RELAXED_ORDERING;
 	crossed_mr = reg_user_mr_dmabuf(pd, &data_direct_dev->pdev->dev,
 					offset, length, virt_addr, fd,
-					access_flags, MLX5_MKC_ACCESS_MODE_KSM);
+					access_flags, MLX5_MKC_ACCESS_MODE_KSM,
+					NULL);
 	if (IS_ERR(crossed_mr)) {
 		ret = PTR_ERR(crossed_mr);
 		goto end;
@@ -1734,7 +1796,7 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 	int err;
 
 	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) ||
-	    !IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) || dmah)
+	    !IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
 		return ERR_PTR(-EOPNOTSUPP);
 
 	if (uverbs_attr_is_valid(attrs, MLX5_IB_ATTR_REG_DMABUF_MR_ACCESS_FLAGS)) {
@@ -1759,7 +1821,8 @@ struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
 
 	return reg_user_mr_dmabuf(pd, pd->device->dma_device,
 				  offset, length, virt_addr,
-				  fd, access_flags, MLX5_MKC_ACCESS_MODE_MTT);
+				  fd, access_flags, MLX5_MKC_ACCESS_MODE_MTT,
+				  dmah);
 }
 
 /*
@@ -1857,7 +1920,8 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 	struct mlx5_ib_mr *mr = to_mmr(ib_mr);
 	int err;
 
-	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || mr->data_direct)
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM) || mr->data_direct ||
+	    mr->mmkey.rb_key.ph != MLX5_IB_NO_PH)
 		return ERR_PTR(-EOPNOTSUPP);
 
 	mlx5_ib_dbg(
@@ -1901,7 +1965,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		atomic_sub(ib_umem_num_pages(umem), &dev->mdev->priv.reg_pages);
 
 		return create_real_mr(new_pd, umem, mr->ibmr.iova,
-				      new_access_flags);
+				      new_access_flags, NULL);
 	}
 
 	/*
@@ -1932,7 +1996,7 @@ struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			}
 			return NULL;
 		}
-		return create_real_mr(new_pd, new_umem, iova, new_access_flags);
+		return create_real_mr(new_pd, new_umem, iova, new_access_flags, NULL);
 	}
 
 	/*
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 1c63cc0b94091..0e8ae85af5a62 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -1883,6 +1883,7 @@ int mlx5_odp_init_mkey_cache(struct mlx5_ib_dev *dev)
 	struct mlx5r_cache_rb_key rb_key = {
 		.access_mode = MLX5_MKC_ACCESS_MODE_KSM,
 		.ndescs = mlx5_imr_ksm_entries,
+		.ph = MLX5_IB_NO_PH,
 	};
 	struct mlx5_cache_ent *ent;
 
-- 
2.50.1


