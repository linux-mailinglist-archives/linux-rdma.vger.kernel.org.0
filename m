Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDFBE268A0B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Sep 2020 13:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgINL2J (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 14 Sep 2020 07:28:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726023AbgINL11 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 14 Sep 2020 07:27:27 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0038D21D1A;
        Mon, 14 Sep 2020 11:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600082831;
        bh=UQ2PGz1ePpy9cNpl7zJy0AfWnfU65pgNdHzR8EwFRDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eluj7wNfyDblk2N6JyjTwTVBuWVrXVm0I84sb+htigtewkGn4AR36zZWao6jltyPY
         x3jCJfkUe6c6MAHch3o/i8Qd17v5ogjYrn9N3YUrbGRblPDyVMHRXdVqnlf8dg7OjG
         daUgiJHSjjIEHpbJCrTe+cuKvTeRwvGCX93Paz+M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 5/5] RDMA/mlx5: Clarify what the UMR is for when creating MRs
Date:   Mon, 14 Sep 2020 14:26:53 +0300
Message-Id: <20200914112653.345244-6-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200914112653.345244-1-leon@kernel.org>
References: <20200914112653.345244-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@nvidia.com>

Once a mkey is created it can be modified using UMR. This is desirable for
performance reasons. However, different hardware has restrictions on what
modifications are possible using UMR. Make sense of these checks:

- mlx5_ib_can_reconfig_with_umr() returns true if the access flags can be
  altered. Most cases create MRs using 0 access flags (now made clear by
  consistent use of set_mkc_access_pd_addr_fields()), but the old logic
  here was tormented. Make it clear that this is checking if the current
  access_flags can be modified using UMR to different access_flags. It is
  always OK to use UMR to change flags that all HW supports.

- mlx5_ib_can_load_pas_with_umr() returns true if UMR can be used to
  enable and update the PAS/XLT. Enabling requires updating the entity
  size, so UMR ends up completely disabled on this old hardware. Make it
  clear why it is disabled. FRWR, ODP and cache always requires
  mlx5_ib_can_load_pas_with_umr().

- mlx5_ib_pas_fits_in_mr() is used to tell if an existing MR can be
  resized to hold a new PAS list. This only works for cached MR's because
  we don't store the PAS list size in other cases.

To be very clear, arrange things so any pre-created MR's in the cache
check the newly requested access_flags before allowing the MR to leave the
cache. If UMR cannot set the required access_flags the cache fails to
create the MR.

This in turn means relaxed ordering and atomic are now correctly blocked
early for implicit ODP on older HW.

Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 45 +++++++++++++++----
 drivers/infiniband/hw/mlx5/mr.c      | 65 ++++++++++++++++++----------
 drivers/infiniband/hw/mlx5/odp.c     |  9 ++--
 drivers/infiniband/hw/mlx5/wr.c      | 27 ++++++------
 4 files changed, 97 insertions(+), 49 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 4921701b666a..6ab3efb75b21 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1245,7 +1245,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
 
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       unsigned int entry);
+				       unsigned int entry, int access_flags);
 void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr);
 
@@ -1458,25 +1458,54 @@ int bfregn_to_uar_index(struct mlx5_ib_dev *dev,
 			struct mlx5_bfreg_info *bfregi, u32 bfregn,
 			bool dyn_bfreg);
 
-static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,
-				       bool do_modify_atomic, int access_flags)
+static inline bool mlx5_ib_can_load_pas_with_umr(struct mlx5_ib_dev *dev,
+						 size_t length)
 {
+	/*
+	 * umr_check_mkey_mask() rejects MLX5_MKEY_MASK_PAGE_SIZE which is
+	 * always set if MLX5_IB_SEND_UMR_UPDATE_TRANSLATION (aka
+	 * MLX5_IB_UPD_XLT_ADDR and MLX5_IB_UPD_XLT_ENABLE) is set. Thus, a mkey
+	 * can never be enabled without this capability. Simplify this weird
+	 * quirky hardware by just saying it can't use PAS lists with UMR at
+	 * all.
+	 */
 	if (MLX5_CAP_GEN(dev->mdev, umr_modify_entity_size_disabled))
 		return false;
 
-	if (do_modify_atomic &&
+	/*
+	 * length is the size of the MR in bytes when mlx5_ib_update_xlt() is
+	 * used.
+	 */
+	if (!MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset) &&
+	    length >= MLX5_MAX_UMR_PAGES * PAGE_SIZE)
+		return false;
+	return true;
+}
+
+/*
+ * true if an existing MR can be reconfigured to new access_flags using UMR.
+ * Older HW cannot use UMR to update certain elements of the MKC. See
+ * umr_check_mkey_mask(), get_umr_update_access_mask() and umr_check_mkey_mask()
+ */
+static inline bool mlx5_ib_can_reconfig_with_umr(struct mlx5_ib_dev *dev,
+						 unsigned int current_access_flags,
+						 unsigned int target_access_flags)
+{
+	unsigned int diffs = current_access_flags ^ target_access_flags;
+
+	if ((diffs & IB_ACCESS_REMOTE_ATOMIC) &&
 	    MLX5_CAP_GEN(dev->mdev, atomic) &&
 	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
 		return false;
 
-	if (access_flags & IB_ACCESS_RELAXED_ORDERING &&
+	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
 	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) &&
 	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
 		return false;
 
-	if (access_flags & IB_ACCESS_RELAXED_ORDERING &&
-	     MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
-	     !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+	if ((diffs & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
 		return false;
 
 	return true;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 76cca9885556..6b0d6109afc6 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -125,7 +125,8 @@ static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	return mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 }
 
-static bool use_umr_mtt_update(struct mlx5_ib_mr *mr, u64 start, u64 length)
+static inline bool mlx5_ib_pas_fits_in_mr(struct mlx5_ib_mr *mr, u64 start,
+					  u64 length)
 {
 	return ((u64)1 << mr->order) * MLX5_ADAPTER_PAGE_SIZE >=
 		length + (start & (MLX5_ADAPTER_PAGE_SIZE - 1));
@@ -559,7 +560,7 @@ static void cache_work_func(struct work_struct *work)
 
 /* Allocate a special entry from the cache */
 struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       unsigned int entry)
+				       unsigned int entry, int access_flags)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
@@ -569,6 +570,10 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 		    entry >= ARRAY_SIZE(cache->ent)))
 		return ERR_PTR(-EINVAL);
 
+	/* Matches access in alloc_cache_mr() */
+	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	ent = &cache->ent[entry];
 	spin_lock_irq(&ent->lock);
 	if (list_empty(&ent->head)) {
@@ -583,6 +588,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 		queue_adjust_cache_locked(ent);
 		spin_unlock_irq(&ent->lock);
 	}
+	mr->access_flags = access_flags;
 	return mr;
 }
 
@@ -755,8 +761,8 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 			   MLX5_IB_UMR_OCTOWORD;
 		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
 		if ((dev->mdev->profile->mask & MLX5_PROF_MASK_MR_CACHE) &&
-		    !dev->is_rep &&
-		    mlx5_core_is_pf(dev->mdev))
+		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
+		    mlx5_ib_can_load_pas_with_umr(dev, 0))
 			ent->limit = dev->mdev->profile->mr_cache[i].limit;
 		else
 			ent->limit = 0;
@@ -988,6 +994,11 @@ alloc_mr_from_cache(struct ib_pd *pd, struct ib_umem *umem, u64 virt_addr,
 
 	if (!ent)
 		return ERR_PTR(-E2BIG);
+
+	/* Matches access in alloc_cache_mr() */
+	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
+		return ERR_PTR(-EOPNOTSUPP);
+
 	mr = get_cache_mr(ent);
 	if (!mr) {
 		mr = create_cache_mr(ent);
@@ -1190,9 +1201,14 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr *ibmr, struct ib_pd *pd,
 		goto err_1;
 	}
 	pas = (__be64 *)MLX5_ADDR_OF(create_mkey_in, in, klm_pas_mtt);
-	if (populate && !(access_flags & IB_ACCESS_ON_DEMAND))
+	if (populate) {
+		if (WARN_ON(access_flags & IB_ACCESS_ON_DEMAND)) {
+			err = -EINVAL;
+			goto err_2;
+		}
 		mlx5_ib_populate_pas(dev, umem, page_shift, pas,
 				     pg_cap ? MLX5_IB_MTT_PRESENT : 0);
+	}
 
 	/* The pg_access bit allows setting the access flags
 	 * in the page list submitted with the command. */
@@ -1351,7 +1367,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_ib_mr *mr = NULL;
-	bool use_umr;
+	bool xlt_with_umr;
 	struct ib_umem *umem;
 	int page_shift;
 	int npages;
@@ -1365,6 +1381,11 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mlx5_ib_dbg(dev, "start 0x%llx, virt_addr 0x%llx, length 0x%llx, access_flags 0x%x\n",
 		    start, virt_addr, length, access_flags);
 
+	xlt_with_umr = mlx5_ib_can_load_pas_with_umr(dev, length);
+	/* ODP requires xlt update via umr to work. */
+	if (!xlt_with_umr && (access_flags & IB_ACCESS_ON_DEMAND))
+		return ERR_PTR(-EINVAL);
+
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && !start &&
 	    length == U64_MAX) {
 		if (virt_addr != start)
@@ -1385,26 +1406,17 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	if (err < 0)
 		return ERR_PTR(err);
 
-	use_umr = mlx5_ib_can_use_umr(dev, true, access_flags);
-
-	if (order <= mr_cache_max_order(dev) && use_umr) {
+	if (xlt_with_umr) {
 		mr = alloc_mr_from_cache(pd, umem, virt_addr, length, ncont,
 					 page_shift, order, access_flags);
 		if (IS_ERR(mr))
 			mr = NULL;
-	} else if (!MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset)) {
-		if (access_flags & IB_ACCESS_ON_DEMAND) {
-			err = -EINVAL;
-			pr_err("Got MR registration for ODP MR > 512MB, not supported for Connect-IB\n");
-			goto error;
-		}
-		use_umr = false;
 	}
 
 	if (!mr) {
 		mutex_lock(&dev->slow_path_mutex);
 		mr = reg_create(NULL, pd, virt_addr, length, umem, ncont,
-				page_shift, access_flags, !use_umr);
+				page_shift, access_flags, !xlt_with_umr);
 		mutex_unlock(&dev->slow_path_mutex);
 	}
 
@@ -1418,7 +1430,12 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 	mr->umem = umem;
 	set_mr_fields(dev, mr, npages, length, access_flags);
 
-	if (use_umr) {
+	if (xlt_with_umr) {
+		/*
+		 * If the MR was created with reg_create then it will be
+		 * configured properly but left disabled. It is safe to go ahead
+		 * and configure it again via UMR while enabling it.
+		 */
 		int update_xlt_flags = MLX5_IB_UPD_XLT_ENABLE;
 
 		if (access_flags & IB_ACCESS_ON_DEMAND)
@@ -1426,7 +1443,6 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 		err = mlx5_ib_update_xlt(mr, 0, ncont, page_shift,
 					 update_xlt_flags);
-
 		if (err) {
 			dereg_mr(dev, mr);
 			return ERR_PTR(err);
@@ -1561,8 +1577,11 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			goto err;
 	}
 
-	if (!mlx5_ib_can_use_umr(dev, true, access_flags) ||
-	    (flags & IB_MR_REREG_TRANS && !use_umr_mtt_update(mr, addr, len))) {
+	if (!mlx5_ib_can_reconfig_with_umr(dev, mr->access_flags,
+					   access_flags) ||
+	    !mlx5_ib_can_load_pas_with_umr(dev, len) ||
+	    (flags & IB_MR_REREG_TRANS &&
+	     !mlx5_ib_pas_fits_in_mr(mr, addr, len))) {
 		/*
 		 * UMR can't be used - MKey needs to be replaced.
 		 */
@@ -1732,9 +1751,9 @@ static void mlx5_set_umr_free_mkey(struct ib_pd *pd, u32 *in, int ndescs,
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 
+	/* This is only used from the kernel, so setting the PD is OK. */
+	set_mkc_access_pd_addr_fields(mkc, 0, 0, pd);
 	MLX5_SET(mkc, mkc, free, 1);
-	MLX5_SET(mkc, mkc, qpn, 0xffffff);
-	MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
 	MLX5_SET(mkc, mkc, translations_octword_size, ndescs);
 	MLX5_SET(mkc, mkc, access_mode_1_0, access_mode & 0x3);
 	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index cfd7efab114e..e40a80c6636c 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -382,7 +382,7 @@ void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 	memset(caps, 0, sizeof(*caps));
 
 	if (!MLX5_CAP_GEN(dev->mdev, pg) ||
-	    !mlx5_ib_can_use_umr(dev, true, 0))
+	    !mlx5_ib_can_load_pas_with_umr(dev, 0))
 		return;
 
 	caps->general_caps = IB_ODP_SUPPORT;
@@ -476,12 +476,12 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	ret = mr = mlx5_mr_cache_alloc(imr->dev, MLX5_IMR_MTT_CACHE_ENTRY);
+	ret = mr = mlx5_mr_cache_alloc(imr->dev, MLX5_IMR_MTT_CACHE_ENTRY,
+				       imr->access_flags);
 	if (IS_ERR(mr))
 		goto out_umem;
 
 	mr->ibmr.pd = imr->ibmr.pd;
-	mr->access_flags = imr->access_flags;
 	mr->umem = &odp->umem;
 	mr->ibmr.lkey = mr->mmkey.key;
 	mr->ibmr.rkey = mr->mmkey.key;
@@ -540,14 +540,13 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = mlx5_mr_cache_alloc(dev, MLX5_IMR_KSM_CACHE_ENTRY);
+	imr = mlx5_mr_cache_alloc(dev, MLX5_IMR_KSM_CACHE_ENTRY, access_flags);
 	if (IS_ERR(imr)) {
 		err = PTR_ERR(imr);
 		goto out_umem;
 	}
 
 	imr->ibmr.pd = &pd->ibpd;
-	imr->access_flags = access_flags;
 	imr->mmkey.iova = 0;
 	imr->umem = &umem_odp->umem;
 	imr->ibmr.lkey = imr->mmkey.key;
diff --git a/drivers/infiniband/hw/mlx5/wr.c b/drivers/infiniband/hw/mlx5/wr.c
index 43880973a512..d6038fb6c50c 100644
--- a/drivers/infiniband/hw/mlx5/wr.c
+++ b/drivers/infiniband/hw/mlx5/wr.c
@@ -398,7 +398,8 @@ static void set_linv_mkey_seg(struct mlx5_mkey_seg *seg)
 	seg->status = MLX5_MKEY_STATUS_FREE;
 }
 
-static void set_reg_mkey_segment(struct mlx5_mkey_seg *seg,
+static void set_reg_mkey_segment(struct mlx5_ib_dev *dev,
+				 struct mlx5_mkey_seg *seg,
 				 const struct ib_send_wr *wr)
 {
 	const struct mlx5_umr_wr *umrwr = umr_wr(wr);
@@ -414,10 +415,12 @@ static void set_reg_mkey_segment(struct mlx5_mkey_seg *seg,
 	MLX5_SET(mkc, seg, rr, !!(umrwr->access_flags & IB_ACCESS_REMOTE_READ));
 	MLX5_SET(mkc, seg, lw, !!(umrwr->access_flags & IB_ACCESS_LOCAL_WRITE));
 	MLX5_SET(mkc, seg, lr, 1);
-	MLX5_SET(mkc, seg, relaxed_ordering_write,
-		 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
-	MLX5_SET(mkc, seg, relaxed_ordering_read,
-		 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
+		MLX5_SET(mkc, seg, relaxed_ordering_write,
+			 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
+	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+		MLX5_SET(mkc, seg, relaxed_ordering_read,
+			 !!(umrwr->access_flags & IB_ACCESS_RELAXED_ORDERING));
 
 	if (umrwr->pd)
 		MLX5_SET(mkc, seg, pd, to_mpd(umrwr->pd)->pdn);
@@ -863,13 +866,11 @@ static int set_reg_wr(struct mlx5_ib_qp *qp,
 	bool atomic = wr->access & IB_ACCESS_REMOTE_ATOMIC;
 	u8 flags = 0;
 
-	if (!mlx5_ib_can_use_umr(dev, atomic, wr->access)) {
-		mlx5_ib_warn(to_mdev(qp->ibqp.device),
-			     "Fast update of %s for MR is disabled\n",
-			     (MLX5_CAP_GEN(dev->mdev,
-					   umr_modify_entity_size_disabled)) ?
-				     "entity size" :
-				     "atomic access");
+	/* Matches access in mlx5_set_umr_free_mkey() */
+	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, wr->access)) {
+		mlx5_ib_warn(
+			to_mdev(qp->ibqp.device),
+			"Fast update for MR access flags is not possible\n");
 		return -EINVAL;
 	}
 
@@ -1263,7 +1264,7 @@ static int handle_qpt_reg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_qp *qp,
 	*seg += sizeof(struct mlx5_wqe_umr_ctrl_seg);
 	*size += sizeof(struct mlx5_wqe_umr_ctrl_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-	set_reg_mkey_segment(*seg, wr);
+	set_reg_mkey_segment(dev, *seg, wr);
 	*seg += sizeof(struct mlx5_mkey_seg);
 	*size += sizeof(struct mlx5_mkey_seg) / 16;
 	handle_post_send_edge(&qp->sq, seg, *size, cur_edge);
-- 
2.26.2

