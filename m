Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 660A51052E
	for <lists+linux-rdma@lfdr.de>; Wed,  1 May 2019 07:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726023AbfEAFWi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 1 May 2019 01:22:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:35178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725298AbfEAFWi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 1 May 2019 01:22:38 -0400
Received: from localhost (unknown [77.138.135.184])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1AA6A2081C;
        Wed,  1 May 2019 05:22:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556688155;
        bh=Gvu/3R0gnQmxpcJD+N9Ykcukl8lSD+fGu6482rmIEjk=;
        h=From:To:Cc:Subject:Date:From;
        b=wUv8/PzkIUzmbgUMJqr17DPuLIqKsNl1DBhDbgse9Et/vUA1qKMntMG/mCOVrswML
         OWMZuUtGi99xq9xQt8u+1eHxzrHRB99B/OwrD4YkU3HEF4pq3lOg+AEYFiJxwH8dl/
         IPOTzamWG5UhzXFHFf952/6bVrUMMLjA8kMUbMbE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next v1] RDMA/umem: Move page_shift from ib_umem to ib_odp_umem
Date:   Wed,  1 May 2019 08:22:27 +0300
Message-Id: <20190501052227.23246-1-leon@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

This value has always been set to PAGE_SHIFT in the core code, the only
thing that does differently was the ODP path. Move the value into the ODP
struct and still use it for ODP, but change all the non-ODP things to just
use PAGE_SHIFT/PAGE_SIZE/PAGE_MASK directly.

Reviewed-by: Shiraz Saleem <shiraz.saleem@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 Changelog v0 -> v1:
 * Added Shiraz's ROB tag
 * Changed types of local page_shift variables to be unsigned int
---
 drivers/infiniband/core/umem.c           |  3 +-
 drivers/infiniband/core/umem_odp.c       | 78 +++++++++++-------------
 drivers/infiniband/hw/hns/hns_roce_cq.c  |  3 +-
 drivers/infiniband/hw/hns/hns_roce_srq.c | 10 ++-
 drivers/infiniband/hw/mlx4/mr.c          |  8 +--
 drivers/infiniband/hw/mlx4/srq.c         |  2 +-
 drivers/infiniband/hw/mlx5/mem.c         | 20 +++---
 drivers/infiniband/hw/mlx5/mr.c          |  5 +-
 drivers/infiniband/hw/mlx5/odp.c         | 23 +++----
 drivers/infiniband/hw/nes/nes_verbs.c    |  9 +--
 include/rdma/ib_umem.h                   | 19 ++----
 include/rdma/ib_umem_odp.h               | 19 ++++++
 12 files changed, 97 insertions(+), 102 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 7e912a91ec8e..0898512fce7d 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -192,7 +192,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	umem->context    = context;
 	umem->length     = size;
 	umem->address    = addr;
-	umem->page_shift = PAGE_SHIFT;
 	umem->writable   = ib_access_writable(access);
 	umem->owning_mm = mm = current->mm;
 	mmgrab(mm);
@@ -353,7 +352,7 @@ int ib_umem_page_count(struct ib_umem *umem)

 	n = 0;
 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, i)
-		n += sg_dma_len(sg) >> umem->page_shift;
+		n += sg_dma_len(sg) >> PAGE_SHIFT;

 	return n;
 }
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 97219143f16f..ee5954214da9 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -59,7 +59,7 @@ static u64 node_start(struct umem_odp_node *n)
 	struct ib_umem_odp *umem_odp =
 			container_of(n, struct ib_umem_odp, interval_tree);

-	return ib_umem_start(&umem_odp->umem);
+	return ib_umem_start(umem_odp);
 }

 /* Note that the representation of the intervals in the interval tree
@@ -72,7 +72,7 @@ static u64 node_last(struct umem_odp_node *n)
 	struct ib_umem_odp *umem_odp =
 			container_of(n, struct ib_umem_odp, interval_tree);

-	return ib_umem_end(&umem_odp->umem) - 1;
+	return ib_umem_end(umem_odp) - 1;
 }

 INTERVAL_TREE_DEFINE(struct umem_odp_node, rb, u64, __subtree_last,
@@ -107,8 +107,6 @@ static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
 static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
 					       u64 start, u64 end, void *cookie)
 {
-	struct ib_umem *umem = &umem_odp->umem;
-
 	/*
 	 * Increase the number of notifiers running, to
 	 * prevent any further fault handling on this MR.
@@ -119,8 +117,8 @@ static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
 	 * all pending page faults. */
 	smp_wmb();
 	complete_all(&umem_odp->notifier_completion);
-	umem->context->invalidate_range(umem_odp, ib_umem_start(umem),
-					ib_umem_end(umem));
+	umem_odp->umem.context->invalidate_range(
+		umem_odp, ib_umem_start(umem_odp), ib_umem_end(umem_odp));
 	return 0;
 }

@@ -204,10 +202,9 @@ static const struct mmu_notifier_ops ib_umem_notifiers = {
 static void add_umem_to_per_mm(struct ib_umem_odp *umem_odp)
 {
 	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
-	struct ib_umem *umem = &umem_odp->umem;

 	down_write(&per_mm->umem_rwsem);
-	if (likely(ib_umem_start(umem) != ib_umem_end(umem)))
+	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp)))
 		rbt_ib_umem_insert(&umem_odp->interval_tree,
 				   &per_mm->umem_tree);
 	up_write(&per_mm->umem_rwsem);
@@ -216,10 +213,9 @@ static void add_umem_to_per_mm(struct ib_umem_odp *umem_odp)
 static void remove_umem_from_per_mm(struct ib_umem_odp *umem_odp)
 {
 	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
-	struct ib_umem *umem = &umem_odp->umem;

 	down_write(&per_mm->umem_rwsem);
-	if (likely(ib_umem_start(umem) != ib_umem_end(umem)))
+	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp)))
 		rbt_ib_umem_remove(&umem_odp->interval_tree,
 				   &per_mm->umem_tree);
 	complete_all(&umem_odp->notifier_completion);
@@ -350,7 +346,7 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 	umem->context    = ctx;
 	umem->length     = size;
 	umem->address    = addr;
-	umem->page_shift = PAGE_SHIFT;
+	odp_data->page_shift = PAGE_SHIFT;
 	umem->writable   = root->umem.writable;
 	umem->is_odp = 1;
 	odp_data->per_mm = per_mm;
@@ -409,13 +405,13 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 		struct hstate *h;

 		down_read(&mm->mmap_sem);
-		vma = find_vma(mm, ib_umem_start(umem));
+		vma = find_vma(mm, ib_umem_start(umem_odp));
 		if (!vma || !is_vm_hugetlb_page(vma)) {
 			up_read(&mm->mmap_sem);
 			return -EINVAL;
 		}
 		h = hstate_vma(vma);
-		umem->page_shift = huge_page_shift(h);
+		umem_odp->page_shift = huge_page_shift(h);
 		up_read(&mm->mmap_sem);
 		umem->hugetlb = 1;
 	} else {
@@ -426,16 +422,16 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)

 	init_completion(&umem_odp->notifier_completion);

-	if (ib_umem_num_pages(umem)) {
+	if (ib_umem_odp_num_pages(umem_odp)) {
 		umem_odp->page_list =
 			vzalloc(array_size(sizeof(*umem_odp->page_list),
-					   ib_umem_num_pages(umem)));
+					   ib_umem_odp_num_pages(umem_odp)));
 		if (!umem_odp->page_list)
 			return -ENOMEM;

 		umem_odp->dma_list =
 			vzalloc(array_size(sizeof(*umem_odp->dma_list),
-					   ib_umem_num_pages(umem)));
+					   ib_umem_odp_num_pages(umem_odp)));
 		if (!umem_odp->dma_list) {
 			ret_val = -ENOMEM;
 			goto out_page_list;
@@ -458,16 +454,14 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)

 void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 {
-	struct ib_umem *umem = &umem_odp->umem;
-
 	/*
 	 * Ensure that no more pages are mapped in the umem.
 	 *
 	 * It is the driver's responsibility to ensure, before calling us,
 	 * that the hardware will not attempt to access the MR any more.
 	 */
-	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem),
-				    ib_umem_end(umem));
+	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
+				    ib_umem_end(umem_odp));

 	remove_umem_from_per_mm(umem_odp);
 	put_per_mm(umem_odp);
@@ -500,8 +494,8 @@ static int ib_umem_odp_map_dma_single_page(
 		u64 access_mask,
 		unsigned long current_seq)
 {
-	struct ib_umem *umem = &umem_odp->umem;
-	struct ib_device *dev = umem->context->device;
+	struct ib_ucontext *context = umem_odp->umem.context;
+	struct ib_device *dev = context->device;
 	dma_addr_t dma_addr;
 	int remove_existing_mapping = 0;
 	int ret = 0;
@@ -516,10 +510,9 @@ static int ib_umem_odp_map_dma_single_page(
 		goto out;
 	}
 	if (!(umem_odp->dma_list[page_index])) {
-		dma_addr = ib_dma_map_page(dev,
-					   page,
-					   0, BIT(umem->page_shift),
-					   DMA_BIDIRECTIONAL);
+		dma_addr =
+			ib_dma_map_page(dev, page, 0, BIT(umem_odp->page_shift),
+					DMA_BIDIRECTIONAL);
 		if (ib_dma_mapping_error(dev, dma_addr)) {
 			ret = -EFAULT;
 			goto out;
@@ -542,11 +535,12 @@ static int ib_umem_odp_map_dma_single_page(

 	if (remove_existing_mapping) {
 		ib_umem_notifier_start_account(umem_odp);
-		umem->context->invalidate_range(
+		context->invalidate_range(
 			umem_odp,
-			ib_umem_start(umem) + (page_index << umem->page_shift),
-			ib_umem_start(umem) +
-				((page_index + 1) << umem->page_shift));
+			ib_umem_start(umem_odp) +
+				(page_index << umem_odp->page_shift),
+			ib_umem_start(umem_odp) +
+				((page_index + 1) << umem_odp->page_shift));
 		ib_umem_notifier_end_account(umem_odp);
 		ret = -EAGAIN;
 	}
@@ -583,27 +577,26 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 			      u64 bcnt, u64 access_mask,
 			      unsigned long current_seq)
 {
-	struct ib_umem *umem = &umem_odp->umem;
 	struct task_struct *owning_process  = NULL;
 	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
 	struct page       **local_page_list = NULL;
 	u64 page_mask, off;
-	int j, k, ret = 0, start_idx, npages = 0, page_shift;
-	unsigned int flags = 0;
+	int j, k, ret = 0, start_idx, npages = 0;
+	unsigned int flags = 0, page_shift;
 	phys_addr_t p = 0;

 	if (access_mask == 0)
 		return -EINVAL;

-	if (user_virt < ib_umem_start(umem) ||
-	    user_virt + bcnt > ib_umem_end(umem))
+	if (user_virt < ib_umem_start(umem_odp) ||
+	    user_virt + bcnt > ib_umem_end(umem_odp))
 		return -EFAULT;

 	local_page_list = (struct page **)__get_free_page(GFP_KERNEL);
 	if (!local_page_list)
 		return -ENOMEM;

-	page_shift = umem->page_shift;
+	page_shift = umem_odp->page_shift;
 	page_mask = ~(BIT(page_shift) - 1);
 	off = user_virt & (~page_mask);
 	user_virt = user_virt & page_mask;
@@ -623,7 +616,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 	if (access_mask & ODP_WRITE_ALLOWED_BIT)
 		flags |= FOLL_WRITE;

-	start_idx = (user_virt - ib_umem_start(umem)) >> page_shift;
+	start_idx = (user_virt - ib_umem_start(umem_odp)) >> page_shift;
 	k = start_idx;

 	while (bcnt > 0) {
@@ -713,21 +706,20 @@ EXPORT_SYMBOL(ib_umem_odp_map_dma_pages);
 void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 				 u64 bound)
 {
-	struct ib_umem *umem = &umem_odp->umem;
 	int idx;
 	u64 addr;
-	struct ib_device *dev = umem->context->device;
+	struct ib_device *dev = umem_odp->umem.context->device;

-	virt  = max_t(u64, virt,  ib_umem_start(umem));
-	bound = min_t(u64, bound, ib_umem_end(umem));
+	virt = max_t(u64, virt, ib_umem_start(umem_odp));
+	bound = min_t(u64, bound, ib_umem_end(umem_odp));
 	/* Note that during the run of this function, the
 	 * notifiers_count of the MR is > 0, preventing any racing
 	 * faults from completion. We might be racing with other
 	 * invalidations, so we must make sure we free each page only
 	 * once. */
 	mutex_lock(&umem_odp->umem_mutex);
-	for (addr = virt; addr < bound; addr += BIT(umem->page_shift)) {
-		idx = (addr - ib_umem_start(umem)) >> umem->page_shift;
+	for (addr = virt; addr < bound; addr += BIT(umem_odp->page_shift)) {
+		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 		if (umem_odp->page_list[idx]) {
 			struct page *page = umem_odp->page_list[idx];
 			dma_addr_t dma = umem_odp->dma_list[idx];
diff --git a/drivers/infiniband/hw/hns/hns_roce_cq.c b/drivers/infiniband/hw/hns/hns_roce_cq.c
index 9caf35061721..6e81ff3f1813 100644
--- a/drivers/infiniband/hw/hns/hns_roce_cq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_cq.c
@@ -235,8 +235,7 @@ static int hns_roce_ib_get_cq_umem(struct hns_roce_dev *hr_dev,
 					&buf->hr_mtt);
 	} else {
 		ret = hns_roce_mtt_init(hr_dev, ib_umem_page_count(*umem),
-				(*umem)->page_shift,
-				&buf->hr_mtt);
+					PAGE_SHIFT, &buf->hr_mtt);
 	}
 	if (ret)
 		goto err_buf;
diff --git a/drivers/infiniband/hw/hns/hns_roce_srq.c b/drivers/infiniband/hw/hns/hns_roce_srq.c
index b3421b1f21e0..ad15b41da30a 100644
--- a/drivers/infiniband/hw/hns/hns_roce_srq.c
+++ b/drivers/infiniband/hw/hns/hns_roce_srq.c
@@ -264,8 +264,7 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 		} else
 			ret = hns_roce_mtt_init(hr_dev,
 						ib_umem_page_count(srq->umem),
-						srq->umem->page_shift,
-						&srq->mtt);
+						PAGE_SHIFT, &srq->mtt);
 		if (ret)
 			goto err_buf;

@@ -291,10 +290,9 @@ int hns_roce_create_srq(struct ib_srq *ib_srq,
 			ret = hns_roce_mtt_init(hr_dev, npages,
 						page_shift, &srq->idx_que.mtt);
 		} else {
-			ret = hns_roce_mtt_init(hr_dev,
-				       ib_umem_page_count(srq->idx_que.umem),
-				       srq->idx_que.umem->page_shift,
-				       &srq->idx_que.mtt);
+			ret = hns_roce_mtt_init(
+				hr_dev, ib_umem_page_count(srq->idx_que.umem),
+				PAGE_SHIFT, &srq->idx_que.mtt);
 		}

 		if (ret) {
diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
index 355205a28544..b0b94dedb848 100644
--- a/drivers/infiniband/hw/mlx4/mr.c
+++ b/drivers/infiniband/hw/mlx4/mr.c
@@ -258,7 +258,7 @@ int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
 				       int *num_of_mtts)
 {
 	u64 block_shift = MLX4_MAX_MTT_SHIFT;
-	u64 min_shift = umem->page_shift;
+	u64 min_shift = PAGE_SHIFT;
 	u64 last_block_aligned_end = 0;
 	u64 current_block_start = 0;
 	u64 first_block_start = 0;
@@ -295,8 +295,8 @@ int mlx4_ib_umem_calc_optimal_mtt_size(struct ib_umem *umem, u64 start_va,
 			 * in access to the wrong data.
 			 */
 			misalignment_bits =
-			(start_va & (~(((u64)(BIT(umem->page_shift))) - 1ULL)))
-			^ current_block_start;
+				(start_va & (~(((u64)(PAGE_SIZE)) - 1ULL))) ^
+				current_block_start;
 			block_shift = min(alignment_of(misalignment_bits),
 					  block_shift);
 		}
@@ -514,7 +514,7 @@ int mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags,
 			goto release_mpt_entry;
 		}
 		n = ib_umem_page_count(mmr->umem);
-		shift = mmr->umem->page_shift;
+		shift = PAGE_SHIFT;

 		err = mlx4_mr_rereg_mem_write(dev->dev, &mmr->mmr,
 					      virt_addr, length, n, shift,
diff --git a/drivers/infiniband/hw/mlx4/srq.c b/drivers/infiniband/hw/mlx4/srq.c
index 4bf2946b9759..c9f555e04c9f 100644
--- a/drivers/infiniband/hw/mlx4/srq.c
+++ b/drivers/infiniband/hw/mlx4/srq.c
@@ -115,7 +115,7 @@ int mlx4_ib_create_srq(struct ib_srq *ib_srq,
 			return PTR_ERR(srq->umem);

 		err = mlx4_mtt_init(dev->dev, ib_umem_page_count(srq->umem),
-				    srq->umem->page_shift, &srq->mtt);
+				    PAGE_SHIFT, &srq->mtt);
 		if (err)
 			goto err_buf;

diff --git a/drivers/infiniband/hw/mlx5/mem.c b/drivers/infiniband/hw/mlx5/mem.c
index 9f90be296ee0..fe1a76d8531c 100644
--- a/drivers/infiniband/hw/mlx5/mem.c
+++ b/drivers/infiniband/hw/mlx5/mem.c
@@ -55,9 +55,10 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 	int i = 0;
 	struct scatterlist *sg;
 	int entry;
-	unsigned long page_shift = umem->page_shift;

 	if (umem->is_odp) {
+		unsigned int page_shift = to_ib_umem_odp(umem)->page_shift;
+
 		*ncont = ib_umem_page_count(umem);
 		*count = *ncont << (page_shift - PAGE_SHIFT);
 		*shift = page_shift;
@@ -67,15 +68,15 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,
 		return;
 	}

-	addr = addr >> page_shift;
+	addr = addr >> PAGE_SHIFT;
 	tmp = (unsigned long)addr;
 	m = find_first_bit(&tmp, BITS_PER_LONG);
 	if (max_page_shift)
-		m = min_t(unsigned long, max_page_shift - page_shift, m);
+		m = min_t(unsigned long, max_page_shift - PAGE_SHIFT, m);

 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
-		len = sg_dma_len(sg) >> page_shift;
-		pfn = sg_dma_address(sg) >> page_shift;
+		len = sg_dma_len(sg) >> PAGE_SHIFT;
+		pfn = sg_dma_address(sg) >> PAGE_SHIFT;
 		if (base + p != pfn) {
 			/* If either the offset or the new
 			 * base are unaligned update m
@@ -107,7 +108,7 @@ void mlx5_ib_cont_pages(struct ib_umem *umem, u64 addr,

 		*ncont = 0;
 	}
-	*shift = page_shift + m;
+	*shift = PAGE_SHIFT + m;
 	*count = i;
 }

@@ -140,8 +141,7 @@ void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,
 			    int page_shift, size_t offset, size_t num_pages,
 			    __be64 *pas, int access_flags)
 {
-	unsigned long umem_page_shift = umem->page_shift;
-	int shift = page_shift - umem_page_shift;
+	int shift = page_shift - PAGE_SHIFT;
 	int mask = (1 << shift) - 1;
 	int i, k, idx;
 	u64 cur = 0;
@@ -165,7 +165,7 @@ void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,

 	i = 0;
 	for_each_sg(umem->sg_head.sgl, sg, umem->nmap, entry) {
-		len = sg_dma_len(sg) >> umem_page_shift;
+		len = sg_dma_len(sg) >> PAGE_SHIFT;
 		base = sg_dma_address(sg);

 		/* Skip elements below offset */
@@ -184,7 +184,7 @@ void __mlx5_ib_populate_pas(struct mlx5_ib_dev *dev, struct ib_umem *umem,

 		for (; k < len; k++) {
 			if (!(i & mask)) {
-				cur = base + (k << umem_page_shift);
+				cur = base + (k << PAGE_SHIFT);
 				cur |= access_flags;
 				idx = (i >> shift) - offset;

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 5f09699fab98..4d033796dcfc 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1606,8 +1606,9 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		synchronize_srcu(&dev->mr_srcu);
 		/* Destroy all page mappings */
 		if (umem_odp->page_list)
-			mlx5_ib_invalidate_range(umem_odp, ib_umem_start(umem),
-						 ib_umem_end(umem));
+			mlx5_ib_invalidate_range(umem_odp,
+						 ib_umem_start(umem_odp),
+						 ib_umem_end(umem_odp));
 		else
 			mlx5_ib_free_implicit_mr(mr);
 		/*
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 91507a2e9290..d0c6f9cc97ef 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -150,7 +150,7 @@ static struct ib_umem_odp *odp_lookup(u64 start, u64 length,
 		if (!rb)
 			goto not_found;
 		odp = rb_entry(rb, struct ib_umem_odp, interval_tree.rb);
-		if (ib_umem_start(&odp->umem) > start + length)
+		if (ib_umem_start(odp) > start + length)
 			goto not_found;
 	}
 not_found:
@@ -200,7 +200,7 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
 static void mr_leaf_free_action(struct work_struct *work)
 {
 	struct ib_umem_odp *odp = container_of(work, struct ib_umem_odp, work);
-	int idx = ib_umem_start(&odp->umem) >> MLX5_IMR_MTT_SHIFT;
+	int idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	struct mlx5_ib_mr *mr = odp->private, *imr = mr->parent;

 	mr->parent = NULL;
@@ -224,7 +224,6 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 	const u64 umr_block_mask = (MLX5_UMR_MTT_ALIGNMENT /
 				    sizeof(struct mlx5_mtt)) - 1;
 	u64 idx = 0, blk_start_idx = 0;
-	struct ib_umem *umem;
 	int in_block = 0;
 	u64 addr;

@@ -232,15 +231,14 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 		pr_err("invalidation called on NULL umem or non-ODP umem\n");
 		return;
 	}
-	umem = &umem_odp->umem;

 	mr = umem_odp->private;

 	if (!mr || !mr->ibmr.pd)
 		return;

-	start = max_t(u64, ib_umem_start(umem), start);
-	end = min_t(u64, ib_umem_end(umem), end);
+	start = max_t(u64, ib_umem_start(umem_odp), start);
+	end = min_t(u64, ib_umem_end(umem_odp), end);

 	/*
 	 * Iteration one - zap the HW's MTTs. The notifiers_count ensures that
@@ -249,8 +247,8 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 	 * but they will write 0s as well, so no difference in the end result.
 	 */

-	for (addr = start; addr < end; addr += BIT(umem->page_shift)) {
-		idx = (addr - ib_umem_start(umem)) >> umem->page_shift;
+	for (addr = start; addr < end; addr += BIT(umem_odp->page_shift)) {
+		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
 		/*
 		 * Strive to write the MTTs in chunks, but avoid overwriting
 		 * non-existing MTTs. The huristic here can be improved to
@@ -544,13 +542,12 @@ static int mr_leaf_free(struct ib_umem_odp *umem_odp, u64 start, u64 end,
 			void *cookie)
 {
 	struct mlx5_ib_mr *mr = umem_odp->private, *imr = cookie;
-	struct ib_umem *umem = &umem_odp->umem;

 	if (mr->parent != imr)
 		return 0;

-	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem),
-				    ib_umem_end(umem));
+	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
+				    ib_umem_end(umem_odp));

 	if (umem_odp->dying)
 		return 0;
@@ -602,9 +599,9 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	}

 next_mr:
-	size = min_t(size_t, bcnt, ib_umem_end(&odp->umem) - io_virt);
+	size = min_t(size_t, bcnt, ib_umem_end(odp) - io_virt);

-	page_shift = mr->umem->page_shift;
+	page_shift = odp->page_shift;
 	page_mask = ~(BIT(page_shift) - 1);
 	start_idx = (io_virt - (mr->mmkey.iova & page_mask)) >> page_shift;
 	access_mask = ODP_READ_ALLOWED_BIT;
diff --git a/drivers/infiniband/hw/nes/nes_verbs.c b/drivers/infiniband/hw/nes/nes_verbs.c
index a3b5e8eecb98..9840df13f18d 100644
--- a/drivers/infiniband/hw/nes/nes_verbs.c
+++ b/drivers/infiniband/hw/nes/nes_verbs.c
@@ -2112,10 +2112,11 @@ static struct ib_mr *nes_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 		return (struct ib_mr *)region;
 	}

-	nes_debug(NES_DBG_MR, "User base = 0x%lX, Virt base = 0x%lX, length = %u,"
-			" offset = %u, page size = %lu.\n",
-			(unsigned long int)start, (unsigned long int)virt, (u32)length,
-			ib_umem_offset(region), BIT(region->page_shift));
+	nes_debug(
+		NES_DBG_MR,
+		"User base = 0x%lX, Virt base = 0x%lX, length = %u, offset = %u, page size = %lu.\n",
+		(unsigned long)start, (unsigned long)virt, (u32)length,
+		ib_umem_offset(region), PAGE_SIZE);

 	skip_pages = ((u32)ib_umem_offset(region)) >> 12;

diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index b13a2e9a50d4..854229f90a97 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -46,7 +46,6 @@ struct ib_umem {
 	struct mm_struct       *owning_mm;
 	size_t			length;
 	unsigned long		address;
-	int			page_shift;
 	u32 writable : 1;
 	u32 hugetlb : 1;
 	u32 is_odp : 1;
@@ -59,24 +58,14 @@ struct ib_umem {
 /* Returns the offset of the umem start relative to the first page. */
 static inline int ib_umem_offset(struct ib_umem *umem)
 {
-	return umem->address & (BIT(umem->page_shift) - 1);
-}
-
-/* Returns the first page of an ODP umem. */
-static inline unsigned long ib_umem_start(struct ib_umem *umem)
-{
-	return umem->address - ib_umem_offset(umem);
-}
-
-/* Returns the address of the page after the last one of an ODP umem. */
-static inline unsigned long ib_umem_end(struct ib_umem *umem)
-{
-	return ALIGN(umem->address + umem->length, BIT(umem->page_shift));
+	return umem->address & PAGE_MASK;
 }

 static inline size_t ib_umem_num_pages(struct ib_umem *umem)
 {
-	return (ib_umem_end(umem) - ib_umem_start(umem)) >> umem->page_shift;
+	return (ALIGN(umem->address + umem->length, PAGE_SIZE) -
+		ALIGN_DOWN(umem->address, PAGE_SIZE)) >>
+	       PAGE_SHIFT;
 }

 #ifdef CONFIG_INFINIBAND_USER_MEM
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index eeec4e53c448..417467fd0302 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -76,6 +76,7 @@ struct ib_umem_odp {

 	struct completion	notifier_completion;
 	int			dying;
+	unsigned int		page_shift;
 	struct work_struct	work;
 };

@@ -84,6 +85,24 @@ static inline struct ib_umem_odp *to_ib_umem_odp(struct ib_umem *umem)
 	return container_of(umem, struct ib_umem_odp, umem);
 }

+/* Returns the first page of an ODP umem. */
+static inline unsigned long ib_umem_start(struct ib_umem_odp *umem_odp)
+{
+	return ALIGN_DOWN(umem_odp->umem.address, 1UL << umem_odp->page_shift);
+}
+
+/* Returns the address of the page after the last one of an ODP umem. */
+static inline unsigned long ib_umem_end(struct ib_umem_odp *umem_odp)
+{
+	return ALIGN(umem_odp->umem.address + umem_odp->umem.length,
+		     1UL << umem_odp->page_shift);
+}
+
+static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
+{
+	return (ib_umem_end(umem_odp) - ib_umem_start(umem_odp)) >> PAGE_SHIFT;
+}
+
 /*
  * The lower 2 bits of the DMA address signal the R/W permissions for
  * the entry. To upgrade the permissions, provide the appropriate
--
2.20.1

