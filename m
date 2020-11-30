Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A9E2C7F76
	for <lists+linux-rdma@lfdr.de>; Mon, 30 Nov 2020 08:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727853AbgK3H7n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 30 Nov 2020 02:59:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:56662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727852AbgK3H7m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 30 Nov 2020 02:59:42 -0500
Received: from localhost (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 09C7D20857;
        Mon, 30 Nov 2020 07:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606723140;
        bh=DhxxzIFvUmi6Qy70Sz6PsWnNhYIAIjP+agRlWWMXR+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FrsqtducSU5KmYE281qXyHFWuolHh8H+fdE7ioHfndlkRzmJ8GXDRQYhnAfEkVEuq
         HEhh+sV0xeAwq3QLk2N+WYAI8qsSlaxk848rkzh2KypyXDAx03NP1/J/3THTysKhfs
         8AgxlrA2BDLQOeW3s717dlWrD4Gk3X6Ojfyj1Jx4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/5] RDMA/mlx5: Fix error unwinds for rereg_mr
Date:   Mon, 30 Nov 2020 09:58:39 +0200
Message-Id: <20201130075839.278575-6-leon@kernel.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201130075839.278575-1-leon@kernel.org>
References: <20201130075839.278575-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

This is all a giant train wreck of error handling, in many cases the MR is
left in some corrupted state where continuing on is going to lead to
chaos, or various unwinds/order is missed.

rereg had three possible completely different actions, depending on flags
and various details about the MR. Split the three actions into three
functions, and call the right action from the start.

For each action carefully design the error handling to fit the action:

- UMR access/PD update is a simple UMR, if it fails the MR isn't changed,
  so do nothing

- PAS update over UMR is multiple UMR operations. To keep everything sane
  revoke access to the MKey while it is being changed and restore it once
  the MR is correct.

- Recreating the mkey should completely build a parallel MR with a fully
  loaded PAS then swap and destroy the old one. If it fails the original
  should be left untouched. This is handled in the core code. Directly
  call the normal MR creation functions, possibly re-using the existing
  umem.

Add support for working with ODP MRs. The READ/WRITE access flags can be
changed by UMR and we can trivially convert to/from ODP MRs using the
logic to build a completely new MR.

This new logic also fixes various problems with MRs continuing to work
while their PAS lists are no longer valid, eg during a page size change.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 316 +++++++++++++++++++-------------
 1 file changed, 188 insertions(+), 128 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4905454a41fd..6f48fa361eb0 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -56,10 +56,9 @@ enum {

 static void
 create_mkey_callback(int status, struct mlx5_async_work *context);
-static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
-				     struct ib_umem *umem, u64 iova,
-				     int access_flags, unsigned int page_size,
-				     bool populate);
+static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
+				     u64 iova, int access_flags,
+				     unsigned int page_size, bool populate);

 static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 					  struct ib_pd *pd)
@@ -134,15 +133,6 @@ static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	return mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 }

-static inline bool mlx5_ib_pas_fits_in_mr(struct mlx5_ib_mr *mr, u64 start,
-					  u64 length)
-{
-	if (!mr->cache_ent)
-		return false;
-	return ((u64)1 << mr->cache_ent->order) * MLX5_ADAPTER_PAGE_SIZE >=
-		length + (start & (MLX5_ADAPTER_PAGE_SIZE - 1));
-}
-
 static void create_mkey_callback(int status, struct mlx5_async_work *context)
 {
 	struct mlx5_ib_mr *mr =
@@ -965,8 +955,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 	if (!ent || ent->limit == 0 ||
 	    !mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags)) {
 		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(NULL, pd, umem, iova, access_flags, page_size,
-				false);
+		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
 		mutex_unlock(&dev->slow_path_mutex);
 		return mr;
 	}
@@ -1276,10 +1265,9 @@ static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
  * If ibmr is NULL it will be allocated by reg_create.
  * Else, the given ibmr will be used.
  */
-static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
-				     struct ib_umem *umem, u64 iova,
-				     int access_flags, unsigned int page_size,
-				     bool populate)
+static struct mlx5_ib_mr *reg_create(struct ib_pd *pd, struct ib_umem *umem,
+				     u64 iova, int access_flags,
+				     unsigned int page_size, bool populate)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr;
@@ -1290,13 +1278,9 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 	int err;
 	bool pg_cap = !!(MLX5_CAP_GEN(dev->mdev, pg));

-	if (!page_size) {
-		page_size = mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
-						     0, iova);
-		if (!page_size)
-			return ERR_PTR(-EINVAL);
-	}
-	mr = ibmr ? to_mmr(ibmr) : kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!page_size)
+		return ERR_PTR(-EINVAL);
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 	if (!mr)
 		return ERR_PTR(-ENOMEM);

@@ -1362,11 +1346,8 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,

 err_2:
 	kvfree(in);
-
 err_1:
-	if (!ibmr)
-		kfree(mr);
-
+	kfree(mr);
 	return ERR_PTR(err);
 }

@@ -1477,8 +1458,11 @@ static struct ib_mr *create_real_mr(struct ib_pd *pd, struct ib_umem *umem,
 	if (xlt_with_umr) {
 		mr = alloc_cacheable_mr(pd, umem, iova, access_flags);
 	} else {
+		unsigned int page_size = mlx5_umem_find_best_pgsz(
+			umem, mkc, log_page_size, 0, iova);
+
 		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(NULL, pd, umem, iova, access_flags, 0, true);
+		mr = reg_create(pd, umem, iova, access_flags, page_size, true);
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 	if (IS_ERR(mr)) {
@@ -1609,135 +1593,211 @@ int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr)
 	return mlx5_ib_post_send_wait(mr->dev, &umrwr);
 }

-static int rereg_umr(struct ib_pd *pd, struct mlx5_ib_mr *mr,
-		     int access_flags, int flags)
+/*
+ * True if the change in access flags can be done via UMR, only some access
+ * flags can be updated.
+ */
+static bool can_use_umr_rereg_access(struct mlx5_ib_dev *dev,
+				     unsigned int current_access_flags,
+				     unsigned int target_access_flags)
 {
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_umr_wr umrwr = {};
+	unsigned int diffs = current_access_flags ^ target_access_flags;
+
+	if (diffs & ~(IB_ACCESS_LOCAL_WRITE | IB_ACCESS_REMOTE_WRITE |
+		      IB_ACCESS_REMOTE_READ | IB_ACCESS_RELAXED_ORDERING))
+		return false;
+	return mlx5_ib_can_reconfig_with_umr(dev, current_access_flags,
+					     target_access_flags);
+}
+
+static int umr_rereg_pd_access(struct mlx5_ib_mr *mr, struct ib_pd *pd,
+			       int access_flags)
+{
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	struct mlx5_umr_wr umrwr = {
+		.wr = {
+			.send_flags = MLX5_IB_SEND_UMR_FAIL_IF_FREE |
+				      MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS,
+			.opcode = MLX5_IB_WR_UMR,
+		},
+		.mkey = mr->mmkey.key,
+		.pd = pd,
+		.access_flags = access_flags,
+	};
 	int err;

-	umrwr.wr.send_flags = MLX5_IB_SEND_UMR_FAIL_IF_FREE;
+	err = mlx5_ib_post_send_wait(dev, &umrwr);
+	if (err)
+		return err;

-	umrwr.wr.opcode = MLX5_IB_WR_UMR;
-	umrwr.mkey = mr->mmkey.key;
+	mr->access_flags = access_flags;
+	mr->mmkey.pd = to_mpd(pd)->pdn;
+	return 0;
+}
+
+static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
+				  struct ib_umem *new_umem,
+				  int new_access_flags, u64 iova,
+				  unsigned long *page_size)
+{
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+
+	/* We only track the allocated sizes of MRs from the cache */
+	if (!mr->cache_ent)
+		return false;
+	if (!mlx5_ib_can_load_pas_with_umr(dev, new_umem->length))
+		return false;
+
+	*page_size =
+		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
+	if (WARN_ON(!*page_size))
+		return false;
+	return (1ULL << mr->cache_ent->order) >=
+	       ib_umem_num_dma_blocks(new_umem, *page_size);
+}
+
+static int umr_rereg_pas(struct mlx5_ib_mr *mr, struct ib_pd *pd,
+			 int access_flags, int flags, struct ib_umem *new_umem,
+			 u64 iova, unsigned long page_size)
+{
+	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
+	int upd_flags = MLX5_IB_UPD_XLT_ADDR | MLX5_IB_UPD_XLT_ENABLE;
+	struct ib_umem *old_umem = mr->umem;
+	int err;
+
+	/*
+	 * To keep everything simple the MR is revoked before we start to mess
+	 * with it. This ensure the change is atomic relative to any use of the
+	 * MR.
+	 */
+	err = mlx5_mr_cache_invalidate(mr);
+	if (err)
+		return err;

-	if (flags & IB_MR_REREG_PD || flags & IB_MR_REREG_ACCESS) {
-		umrwr.pd = pd;
-		umrwr.access_flags = access_flags;
-		umrwr.wr.send_flags |= MLX5_IB_SEND_UMR_UPDATE_PD_ACCESS;
+	if (flags & IB_MR_REREG_PD) {
+		mr->ibmr.pd = pd;
+		mr->mmkey.pd = to_mpd(pd)->pdn;
+		upd_flags |= MLX5_IB_UPD_XLT_PD;
+	}
+	if (flags & IB_MR_REREG_ACCESS) {
+		mr->access_flags = access_flags;
+		upd_flags |= MLX5_IB_UPD_XLT_ACCESS;
 	}

-	err = mlx5_ib_post_send_wait(dev, &umrwr);
+	mr->ibmr.length = new_umem->length;
+	mr->mmkey.iova = iova;
+	mr->mmkey.size = new_umem->length;
+	mr->page_shift = order_base_2(page_size);
+	mr->umem = new_umem;
+	err = mlx5_ib_update_mr_pas(mr, upd_flags);
+	if (err) {
+		/*
+		 * The MR is revoked at this point so there is no issue to free
+		 * new_umem.
+		 */
+		mr->umem = old_umem;
+		return err;
+	}

-	return err;
+	atomic_sub(ib_umem_num_pages(old_umem), &dev->mdev->priv.reg_pages);
+	ib_umem_release(old_umem);
+	atomic_add(ib_umem_num_pages(new_umem), &dev->mdev->priv.reg_pages);
+	return 0;
 }

 struct ib_mr *mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
-				    u64 length, u64 virt_addr,
-				    int new_access_flags, struct ib_pd *new_pd,
+				    u64 length, u64 iova, int new_access_flags,
+				    struct ib_pd *new_pd,
 				    struct ib_udata *udata)
 {
 	struct mlx5_ib_dev *dev = to_mdev(ib_mr->device);
 	struct mlx5_ib_mr *mr = to_mmr(ib_mr);
-	struct ib_pd *pd = (flags & IB_MR_REREG_PD) ? new_pd : ib_mr->pd;
-	int access_flags = flags & IB_MR_REREG_ACCESS ?
-			    new_access_flags :
-			    mr->access_flags;
-	int upd_flags = 0;
-	u64 addr, len;
 	int err;

-	mlx5_ib_dbg(dev, "start 0x%llx, virt_addr 0x%llx, length 0x%llx, access_flags 0x%x\n",
-		    start, virt_addr, length, access_flags);
+	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
+		return ERR_PTR(-EOPNOTSUPP);

-	if (!mr->umem)
-		return ERR_PTR(-EINVAL);
+	mlx5_ib_dbg(
+		dev,
+		"start 0x%llx, iova 0x%llx, length 0x%llx, access_flags 0x%x\n",
+		start, iova, length, new_access_flags);

-	if (is_odp_mr(mr))
+	if (flags & ~(IB_MR_REREG_TRANS | IB_MR_REREG_PD | IB_MR_REREG_ACCESS))
 		return ERR_PTR(-EOPNOTSUPP);

-	if (flags & IB_MR_REREG_TRANS) {
-		addr = virt_addr;
-		len = length;
-	} else {
-		addr = mr->umem->address;
-		len = mr->umem->length;
-	}
+	if (!(flags & IB_MR_REREG_ACCESS))
+		new_access_flags = mr->access_flags;
+	if (!(flags & IB_MR_REREG_PD))
+		new_pd = ib_mr->pd;

-	if (flags != IB_MR_REREG_PD) {
-		/*
-		 * Replace umem. This needs to be done whether or not UMR is
-		 * used.
-		 */
-		flags |= IB_MR_REREG_TRANS;
-		atomic_sub(ib_umem_num_pages(mr->umem),
-			   &dev->mdev->priv.reg_pages);
-		ib_umem_release(mr->umem);
-		mr->umem = ib_umem_get(&dev->ib_dev, addr, len, access_flags);
-		if (IS_ERR(mr->umem)) {
-			err = PTR_ERR(mr->umem);
-			mr->umem = NULL;
-			goto err;
+	if (!(flags & IB_MR_REREG_TRANS)) {
+		struct ib_umem *umem;
+
+		/* Fast path for PD/access change */
+		if (can_use_umr_rereg_access(dev, mr->access_flags,
+					     new_access_flags)) {
+			err = umr_rereg_pd_access(mr, new_pd, new_access_flags);
+			if (err)
+				return ERR_PTR(err);
+			return NULL;
 		}
-		atomic_add(ib_umem_num_pages(mr->umem),
-			   &dev->mdev->priv.reg_pages);
-	}
+		/* DM or ODP MR's don't have a umem so we can't re-use it */
+		if (!mr->umem || is_odp_mr(mr))
+			goto recreate;

-	if (!mlx5_ib_can_reconfig_with_umr(dev, mr->access_flags,
-					   access_flags) ||
-	    !mlx5_ib_can_load_pas_with_umr(dev, len) ||
-	    (flags & IB_MR_REREG_TRANS &&
-	     !mlx5_ib_pas_fits_in_mr(mr, addr, len))) {
 		/*
-		 * UMR can't be used - MKey needs to be replaced.
+		 * Only one active MR can refer to a umem at one time, revoke
+		 * the old MR before assigning the umem to the new one.
 		 */
-		if (mr->cache_ent)
-			detach_mr_from_cache(mr);
-		err = destroy_mkey(dev, mr);
+		err = mlx5_mr_cache_invalidate(mr);
 		if (err)
-			goto err;
+			return ERR_PTR(err);
+		umem = mr->umem;
+		mr->umem = NULL;
+		atomic_sub(ib_umem_num_pages(umem), &dev->mdev->priv.reg_pages);

-		mr = reg_create(ib_mr, pd, mr->umem, addr, access_flags, 0, true);
-		if (IS_ERR(mr)) {
-			err = PTR_ERR(mr);
-			mr = to_mmr(ib_mr);
-			goto err;
-		}
-	} else {
-		/*
-		 * Send a UMR WQE
-		 */
-		mr->ibmr.pd = pd;
-		mr->access_flags = access_flags;
-		mr->mmkey.iova = addr;
-		mr->mmkey.size = len;
-		mr->mmkey.pd = to_mpd(pd)->pdn;
+		return create_real_mr(new_pd, umem, mr->mmkey.iova,
+				      new_access_flags);
+	}

-		if (flags & IB_MR_REREG_TRANS) {
-			upd_flags = MLX5_IB_UPD_XLT_ADDR;
-			if (flags & IB_MR_REREG_PD)
-				upd_flags |= MLX5_IB_UPD_XLT_PD;
-			if (flags & IB_MR_REREG_ACCESS)
-				upd_flags |= MLX5_IB_UPD_XLT_ACCESS;
-			err = mlx5_ib_update_mr_pas(mr, upd_flags);
-		} else {
-			err = rereg_umr(pd, mr, access_flags, flags);
+	/*
+	 * DM doesn't have a PAS list so we can't re-use it, odp does but the
+	 * logic around releasing the umem is different
+	 */
+	if (!mr->umem || is_odp_mr(mr))
+		goto recreate;
+
+	if (!(new_access_flags & IB_ACCESS_ON_DEMAND) &&
+	    can_use_umr_rereg_access(dev, mr->access_flags, new_access_flags)) {
+		struct ib_umem *new_umem;
+		unsigned long page_size;
+
+		new_umem = ib_umem_get(&dev->ib_dev, start, length,
+				       new_access_flags);
+		if (IS_ERR(new_umem))
+			return ERR_CAST(new_umem);
+
+		/* Fast path for PAS change */
+		if (can_use_umr_rereg_pas(mr, new_umem, new_access_flags, iova,
+					  &page_size)) {
+			err = umr_rereg_pas(mr, new_pd, new_access_flags, flags,
+					    new_umem, iova, page_size);
+			if (err) {
+				ib_umem_release(new_umem);
+				return ERR_PTR(err);
+			}
+			return NULL;
 		}
-
-		if (err)
-			goto err;
+		return create_real_mr(new_pd, new_umem, iova, new_access_flags);
 	}

-	set_mr_fields(dev, mr, len, access_flags);
-
-	return NULL;
-
-err:
-	ib_umem_release(mr->umem);
-	mr->umem = NULL;
-
-	clean_mr(dev, mr);
-	return ERR_PTR(err);
+	/*
+	 * Everything else has no state we can preserve, just create a new MR
+	 * from scratch
+	 */
+recreate:
+	return mlx5_ib_reg_user_mr(new_pd, start, length, iova,
+				   new_access_flags, udata);
 }

 static int
--
2.28.0

