Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97938D13BA
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731831AbfJIQKN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:10:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33286 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731835AbfJIQKN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:10:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id x134so2750475qkb.0
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:10:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1OghJ54h93W+vZ6jhJ9S64izA+jT7TOYefZlFRPoAl0=;
        b=GzBAv6XGG7fRBzSpngmMjtcdjwNCSIMIe6ThbGEg6FW4568nYhb2anfUvWfHlT53Je
         75bfPHnha35flxRVxXyNxsN0RPD0aSUY7ETnVuDDraMvCk63b46nAJ4iYmBRQZV664Ue
         TM2omZlwJNPVinR+z9ZCpwD1N/LHkqU37oXpLGVhgzCmS3Yf7fC8q7btRUurKwbiW0EJ
         rNWUziAM57jwNqt+WxuhDqBX35GQpJJvKi9U4LoG1caKnd+jNi310fSSME0wOA8Bh5No
         v93WCGPA6ixC/tmEQduPbDSIdt6Pib2QExCG0LPZ2SpYkQ9VZk0PF4aZSWucM1etIBBV
         uh2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1OghJ54h93W+vZ6jhJ9S64izA+jT7TOYefZlFRPoAl0=;
        b=jObLW4+3UwSR7eXtG69l2+MKvWnHSN/zl+qaMJclKSpZm5N4sLMfw+Yaixxv9tV7bn
         IVPvvnh5JXU2cHVuPuzVs3+uGyGb5JljaDon7xN/0y/xTB6BoLz1yBjzqlIgttSBd3mu
         at+0Nn82xJPrVa9hDkYs/CPvis2XSjrsGyRdVySMWcBnZfoDzk59NDQvkTPIxQhMM6TY
         w/IqC5C5ojoZKMmf6cPO/AoGde1Cuk1A4ILsjleYjnFrS7ZfUXg6L8bjfoa0wrGz+0KM
         cYi/HbgVHfvPoEkBtv0EEQlwpvqqPlJz7anpjcHNIPsAykx5FbCjCO1RwKRdvBjCP9Bn
         AMyw==
X-Gm-Message-State: APjAAAXVnDPIFa8b2GagCTvOoA51zpd4l5I4r2RcXJBPl6FaJJ8JbmAR
        2IRe7rjvTuB0nu9vhMo+1Q443oqBbhM=
X-Google-Smtp-Source: APXvYqxv0UwfMjb28TbdxCPt9YdYyJ2IKtwvQK5a6Eh161KjNTC5cDzd0ToLwihlg/QTfxW/LfLjcQ==
X-Received: by 2002:a05:620a:74b:: with SMTP id i11mr4313570qki.397.1570637411889;
        Wed, 09 Oct 2019 09:10:11 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id g45sm1312655qtc.9.2019.10.09.09.10.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:10:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000r4-37; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 09/15] RDMA/mlx5: Use an xarray for the children of an implicit ODP
Date:   Wed,  9 Oct 2019 13:09:29 -0300
Message-Id: <20191009160934.3143-10-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Currently the child leaves are stored in the shared interval tree and
every lookup for a child must be done under the interval tree rwsem.

This is further complicated by dropping the rwsem during iteration (ie the
odp_lookup(), odp_next() pattern), which requires a very tricky an
difficult to understand locking scheme with SRCU.

Instead reserve the interval tree for the exclusive use of the mmu
notifier related code in umem_odp.c and give each implicit MR a xarray
containing all the child MRs.

Since the size of each child is 1GB of VA, a 1 level xarray will index 64G
of VA, and a 2 level will index 2TB, making xarray a much better
data structure choice than an interval tree.

The locking properties of xarray will be used in the next patches to
rework the implicit ODP locking scheme into something simpler.

At this point, the xarray is locked by the implicit MR's umem_mutex, and
read can also be locked by the odp_srcu.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   5 +-
 drivers/infiniband/hw/mlx5/odp.c     | 195 +++++++++------------------
 include/rdma/ib_umem_odp.h           |  16 ---
 3 files changed, 67 insertions(+), 149 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2cf91db6a36f5f..88769fcffb5a10 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -617,10 +617,13 @@ struct mlx5_ib_mr {
 	u64			data_iova;
 	u64			pi_iova;
 
+	/* For ODP and implicit */
 	atomic_t		num_leaf_free;
 	wait_queue_head_t       q_leaf_free;
-	struct mlx5_async_work  cb_work;
 	atomic_t		num_pending_prefetch;
+	struct xarray		implicit_children;
+
+	struct mlx5_async_work  cb_work;
 };
 
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index aba4f17c235467..d70cf02343a79f 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -93,132 +93,54 @@ struct mlx5_pagefault {
 
 static u64 mlx5_imr_ksm_entries;
 
-static int check_parent(struct ib_umem_odp *odp,
-			       struct mlx5_ib_mr *parent)
+void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
+			   struct mlx5_ib_mr *imr, int flags)
 {
-	struct mlx5_ib_mr *mr = odp->private;
-
-	return mr && mr->parent == parent && !odp->dying;
-}
-
-static struct ib_ucontext_per_mm *mr_to_per_mm(struct mlx5_ib_mr *mr)
-{
-	if (WARN_ON(!mr || !is_odp_mr(mr)))
-		return NULL;
-
-	return to_ib_umem_odp(mr->umem)->per_mm;
-}
-
-static struct ib_umem_odp *odp_next(struct ib_umem_odp *odp)
-{
-	struct mlx5_ib_mr *mr = odp->private, *parent = mr->parent;
-	struct ib_ucontext_per_mm *per_mm = odp->per_mm;
-	struct rb_node *rb;
-
-	down_read(&per_mm->umem_rwsem);
-	while (1) {
-		rb = rb_next(&odp->interval_tree.rb);
-		if (!rb)
-			goto not_found;
-		odp = rb_entry(rb, struct ib_umem_odp, interval_tree.rb);
-		if (check_parent(odp, parent))
-			goto end;
-	}
-not_found:
-	odp = NULL;
-end:
-	up_read(&per_mm->umem_rwsem);
-	return odp;
-}
-
-static struct ib_umem_odp *odp_lookup(u64 start, u64 length,
-				      struct mlx5_ib_mr *parent)
-{
-	struct ib_ucontext_per_mm *per_mm = mr_to_per_mm(parent);
-	struct ib_umem_odp *odp;
-	struct rb_node *rb;
-
-	down_read(&per_mm->umem_rwsem);
-	odp = rbt_ib_umem_lookup(&per_mm->umem_tree, start, length);
-	if (!odp)
-		goto end;
-
-	while (1) {
-		if (check_parent(odp, parent))
-			goto end;
-		rb = rb_next(&odp->interval_tree.rb);
-		if (!rb)
-			goto not_found;
-		odp = rb_entry(rb, struct ib_umem_odp, interval_tree.rb);
-		if (ib_umem_start(odp) > start + length)
-			goto not_found;
-	}
-not_found:
-	odp = NULL;
-end:
-	up_read(&per_mm->umem_rwsem);
-	return odp;
-}
-
-void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
-			   size_t nentries, struct mlx5_ib_mr *mr, int flags)
-{
-	struct ib_pd *pd = mr->ibmr.pd;
-	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct ib_umem_odp *odp;
-	unsigned long va;
-	int i;
+	struct mlx5_klm *end = pklm + nentries;
 
 	if (flags & MLX5_IB_UPD_XLT_ZAP) {
-		for (i = 0; i < nentries; i++, pklm++) {
+		for (; pklm != end; pklm++, idx++) {
 			pklm->bcount = cpu_to_be32(MLX5_IMR_MTT_SIZE);
-			pklm->key = cpu_to_be32(dev->null_mkey);
+			pklm->key = cpu_to_be32(imr->dev->null_mkey);
 			pklm->va = 0;
 		}
 		return;
 	}
 
 	/*
-	 * The locking here is pretty subtle. Ideally the implicit children
-	 * list would be protected by the umem_mutex, however that is not
+	 * The locking here is pretty subtle. Ideally the implicit_children
+	 * xarray would be protected by the umem_mutex, however that is not
 	 * possible. Instead this uses a weaker update-then-lock pattern:
 	 *
 	 *  srcu_read_lock()
-	 *    <change children list>
+	 *    xa_store()
 	 *    mutex_lock(umem_mutex)
 	 *     mlx5_ib_update_xlt()
 	 *    mutex_unlock(umem_mutex)
 	 *    destroy lkey
 	 *
-	 * ie any change the children list must be followed by the locked
-	 * update_xlt before destroying.
+	 * ie any change the xarray must be followed by the locked update_xlt
+	 * before destroying.
 	 *
 	 * The umem_mutex provides the acquire/release semantic needed to make
-	 * the children list visible to a racing thread. While SRCU is not
+	 * the xa_store() visible to a racing thread. While SRCU is not
 	 * technically required, using it gives consistent use of the SRCU
-	 * locking around the children list.
+	 * locking around the xarray.
 	 */
-	lockdep_assert_held(&to_ib_umem_odp(mr->umem)->umem_mutex);
-	lockdep_assert_held(&mr->dev->odp_srcu);
+	lockdep_assert_held(&to_ib_umem_odp(imr->umem)->umem_mutex);
+	lockdep_assert_held(&imr->dev->odp_srcu);
 
-	odp = odp_lookup(offset * MLX5_IMR_MTT_SIZE,
-			 nentries * MLX5_IMR_MTT_SIZE, mr);
+	for (; pklm != end; pklm++, idx++) {
+		struct mlx5_ib_mr *mtt = xa_load(&imr->implicit_children, idx);
 
-	for (i = 0; i < nentries; i++, pklm++) {
 		pklm->bcount = cpu_to_be32(MLX5_IMR_MTT_SIZE);
-		va = (offset + i) * MLX5_IMR_MTT_SIZE;
-		if (odp && ib_umem_start(odp) == va) {
-			struct mlx5_ib_mr *mtt = odp->private;
-
+		if (mtt) {
 			pklm->key = cpu_to_be32(mtt->ibmr.lkey);
-			pklm->va = cpu_to_be64(va);
-			odp = odp_next(odp);
+			pklm->va = cpu_to_be64(idx * MLX5_IMR_MTT_SIZE);
 		} else {
-			pklm->key = cpu_to_be32(dev->null_mkey);
+			pklm->key = cpu_to_be32(imr->dev->null_mkey);
 			pklm->va = 0;
 		}
-		mlx5_ib_dbg(dev, "[%d] va %lx key %x\n",
-			    i, va, be32_to_cpu(pklm->key));
 	}
 }
 
@@ -320,6 +242,8 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	if (unlikely(!umem_odp->npages && mr->parent &&
 		     !umem_odp->dying)) {
+		xa_erase(&mr->parent->implicit_children,
+			 ib_umem_start(umem_odp) >> MLX5_IMR_MTT_SHIFT);
 		xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
 		umem_odp->dying = 1;
 		atomic_inc(&mr->parent->num_leaf_free);
@@ -464,6 +388,16 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		goto out_release;
 	}
 
+	/*
+	 * Once the store to either xarray completes any error unwind has to
+	 * use synchronize_srcu(). Avoid this with xa_reserve()
+	 */
+	err = xa_err(xa_store(&imr->implicit_children, idx, mr, GFP_KERNEL));
+	if (err) {
+		ret = ERR_PTR(err);
+		goto out_release;
+	}
+
 	xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
 		 &mr->mmkey, GFP_ATOMIC);
 
@@ -479,7 +413,7 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	return ret;
 }
 
-static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *imr,
+static struct mlx5_ib_mr *implicit_mr_get_data(struct mlx5_ib_mr *imr,
 						u64 io_virt, size_t bcnt)
 {
 	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
@@ -487,39 +421,32 @@ static struct ib_umem_odp *implicit_mr_get_data(struct mlx5_ib_mr *imr,
 	unsigned long idx = io_virt >> MLX5_IMR_MTT_SHIFT;
 	unsigned long inv_start_idx = end_idx + 1;
 	unsigned long inv_len = 0;
-	struct ib_umem_odp *result = NULL;
-	struct ib_umem_odp *odp;
+	struct mlx5_ib_mr *result = NULL;
 	int ret;
 
 	mutex_lock(&odp_imr->umem_mutex);
-	odp = odp_lookup(idx * MLX5_IMR_MTT_SIZE, 1, imr);
 	for (idx = idx; idx <= end_idx; idx++) {
-		if (unlikely(!odp)) {
-			struct mlx5_ib_mr *mtt;
+		struct mlx5_ib_mr *mtt = xa_load(&imr->implicit_children, idx);
 
+		if (unlikely(!mtt)) {
 			mtt = implicit_get_child_mr(imr, idx);
 			if (IS_ERR(mtt)) {
-				result = ERR_CAST(mtt);
+				result = mtt;
 				goto out;
 			}
-			odp = to_ib_umem_odp(mtt->umem);
 			inv_start_idx = min(inv_start_idx, idx);
 			inv_len = idx - inv_start_idx + 1;
 		}
 
 		/* Return first odp if region not covered by single one */
 		if (likely(!result))
-			result = odp;
-
-		odp = odp_next(odp);
-		if (odp && ib_umem_start(odp) != idx * MLX5_IMR_MTT_SIZE)
-			odp = NULL;
+			result = mtt;
 	}
 
 	/*
-	 * Any time the children in the interval tree are changed we must
-	 * perform an update of the xlt before exiting to ensure the HW and
-	 * the tree remains synchronized.
+	 * Any time the implicit_children are changed we must perform an
+	 * update of the xlt before exiting to ensure the HW and the
+	 * implicit_children remains synchronized.
 	 */
 out:
 	if (likely(!inv_len))
@@ -569,6 +496,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	init_waitqueue_head(&imr->q_leaf_free);
 	atomic_set(&imr->num_leaf_free, 0);
 	atomic_set(&imr->num_pending_prefetch, 0);
+	xa_init(&imr->implicit_children);
 
 	err = mlx5_ib_update_xlt(imr, 0,
 				 mlx5_imr_ksm_entries,
@@ -596,18 +524,15 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 {
-	struct ib_ucontext_per_mm *per_mm = mr_to_per_mm(imr);
-	struct rb_node *node;
+	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
+	struct mlx5_ib_mr *mtt;
+	unsigned long idx;
 
-	down_read(&per_mm->umem_rwsem);
-	for (node = rb_first_cached(&per_mm->umem_tree); node;
-	     node = rb_next(node)) {
-		struct ib_umem_odp *umem_odp =
-			rb_entry(node, struct ib_umem_odp, interval_tree.rb);
-		struct mlx5_ib_mr *mr = umem_odp->private;
+	mutex_lock(&odp_imr->umem_mutex);
+	xa_for_each (&imr->implicit_children, idx, mtt) {
+		struct ib_umem_odp *umem_odp = to_ib_umem_odp(mtt->umem);
 
-		if (mr->parent != imr)
-			continue;
+		xa_erase(&imr->implicit_children, idx);
 
 		mutex_lock(&umem_odp->umem_mutex);
 		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
@@ -623,9 +548,12 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 		schedule_work(&umem_odp->work);
 		mutex_unlock(&umem_odp->umem_mutex);
 	}
-	up_read(&per_mm->umem_rwsem);
+	mutex_unlock(&odp_imr->umem_mutex);
 
 	wait_event(imr->q_leaf_free, !atomic_read(&imr->num_leaf_free));
+	WARN_ON(!xa_empty(&imr->implicit_children));
+	/* Remove any left over reserved elements */
+	xa_destroy(&imr->implicit_children);
 }
 
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
@@ -718,7 +646,7 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 			u32 *bytes_mapped, u32 flags)
 {
 	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
-	struct ib_umem_odp *child;
+	struct mlx5_ib_mr *mtt;
 	int npages = 0;
 
 	if (!odp->is_implicit_odp) {
@@ -733,17 +661,18 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 		     mlx5_imr_ksm_entries * MLX5_IMR_MTT_SIZE - io_virt < bcnt))
 		return -EFAULT;
 
-	child = implicit_mr_get_data(mr, io_virt, bcnt);
-	if (IS_ERR(child))
-		return PTR_ERR(child);
+	mtt = implicit_mr_get_data(mr, io_virt, bcnt);
+	if (IS_ERR(mtt))
+		return PTR_ERR(mtt);
 
 	/* Fault each child mr that intersects with our interval. */
 	while (bcnt) {
-		u64 end = min_t(u64, io_virt + bcnt, ib_umem_end(child));
+		struct ib_umem_odp *umem_odp = to_ib_umem_odp(mtt->umem);
+		u64 end = min_t(u64, io_virt + bcnt, ib_umem_end(umem_odp));
 		u64 len = end - io_virt;
 		int ret;
 
-		ret = pagefault_real_mr(child->private, child, io_virt, len,
+		ret = pagefault_real_mr(mtt, umem_odp, io_virt, len,
 					bytes_mapped, flags);
 		if (ret < 0)
 			return ret;
@@ -752,12 +681,14 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io_virt, size_t bcnt,
 		npages += ret;
 
 		if (unlikely(bcnt)) {
-			child = odp_next(child);
+			mtt = xa_load(&mr->implicit_children,
+				      io_virt >> MLX5_IMR_MTT_SHIFT);
+
 			/*
 			 * implicit_mr_get_data sets up all the leaves, this
 			 * means they got invalidated before we got to them.
 			 */
-			if (!child || ib_umem_start(child) != io_virt) {
+			if (!mtt) {
 				mlx5_ib_dbg(
 					mr->dev,
 					"next implicit leaf removed at 0x%llx.\n",
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 253df1a1fa5406..28078efc38339f 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -156,22 +156,6 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 				  umem_call_back cb,
 				  bool blockable, void *cookie);
 
-/*
- * Find first region intersecting with address range.
- * Return NULL if not found
- */
-static inline struct ib_umem_odp *
-rbt_ib_umem_lookup(struct rb_root_cached *root, u64 addr, u64 length)
-{
-	struct interval_tree_node *node;
-
-	node = interval_tree_iter_first(root, addr, addr + length - 1);
-	if (!node)
-		return NULL;
-	return container_of(node, struct ib_umem_odp, interval_tree);
-
-}
-
 static inline int ib_umem_mmu_notifier_retry(struct ib_umem_odp *umem_odp,
 					     unsigned long mmu_seq)
 {
-- 
2.23.0

