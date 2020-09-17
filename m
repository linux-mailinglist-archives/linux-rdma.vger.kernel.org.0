Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032B326DA04
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Sep 2020 13:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgIQLWM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Sep 2020 07:22:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgIQLWH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 17 Sep 2020 07:22:07 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EAC8B20771;
        Thu, 17 Sep 2020 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600341721;
        bh=Gr6BmDv9kWAWd5xe1zUjYTUW6GaX16l2qeFwWlmjxOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nOxTG0ex9sScJLEh0XDlyMW+U7KBJKDvbH28CDRMviRWCr3FuTMs93UzqaAnLXjvm
         q6/+K/EA0R9+znIaqnYkVUF9k6ZfBmps4iEmqxwV4NKGFjYnDxwk/e9xARYOCA7UTe
         0RQIOzbrkHmZGprOwl4nWpG9ZFTqsxSVp3VR79jw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v1 1/4] IB/core: Improve ODP to use hmm_range_fault()
Date:   Thu, 17 Sep 2020 14:21:49 +0300
Message-Id: <20200917112152.1075974-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200917112152.1075974-1-leon@kernel.org>
References: <20200917112152.1075974-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Move to use hmm_range_fault() which improve performance in few aspects
comparing previous functionality of get_user_pages_remote().

This includes:
- Dropping the need to allocate and free memory to hold its output.
- No need any more to use the put_page() to unpin the pages.
- The logic to detect contiguous pages is done based on the returned
  order, no need to run per page and evaluate.

In addition,
Moving to use hmm_range_fault() enables to reduce page faults in the
system as it exposes the snapshot mode, this will be introduced in next
patches from this series.

As part of this, cleanup some flows and use the required data structures
to work with hmm_range_fault().

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/Kconfig         |   1 +
 drivers/infiniband/core/umem_odp.c | 273 +++++++++++------------------
 drivers/infiniband/hw/mlx5/odp.c   |  24 +--
 include/rdma/ib_umem_odp.h         |  21 +--
 4 files changed, 121 insertions(+), 198 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 91b023341b77..32a51432ec4f 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -48,6 +48,7 @@ config INFINIBAND_ON_DEMAND_PAGING
 	depends on INFINIBAND_USER_MEM
 	select MMU_NOTIFIER
 	select INTERVAL_TREE
+	select HMM_MIRROR
 	default y
 	help
 	  On demand paging support for the InfiniBand subsystem.
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index cc6b4befde7c..3d702aa66d6d 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -40,6 +40,7 @@
 #include <linux/vmalloc.h>
 #include <linux/hugetlb.h>
 #include <linux/interval_tree.h>
+#include <linux/hmm.h>
 #include <linux/pagemap.h>

 #include <rdma/ib_verbs.h>
@@ -60,7 +61,7 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 		size_t page_size = 1UL << umem_odp->page_shift;
 		unsigned long start;
 		unsigned long end;
-		size_t pages;
+		size_t ndmas, npfns;

 		start = ALIGN_DOWN(umem_odp->umem.address, page_size);
 		if (check_add_overflow(umem_odp->umem.address,
@@ -71,20 +72,21 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
 		if (unlikely(end < page_size))
 			return -EOVERFLOW;

-		pages = (end - start) >> umem_odp->page_shift;
-		if (!pages)
+		ndmas = (end - start) >> umem_odp->page_shift;
+		if (!ndmas)
 			return -EINVAL;

-		umem_odp->page_list = kvcalloc(
-			pages, sizeof(*umem_odp->page_list), GFP_KERNEL);
-		if (!umem_odp->page_list)
+		npfns = (end - start) >> PAGE_SHIFT;
+		umem_odp->pfn_list = kvcalloc(
+			npfns, sizeof(*umem_odp->pfn_list), GFP_KERNEL);
+		if (!umem_odp->pfn_list)
 			return -ENOMEM;

 		umem_odp->dma_list = kvcalloc(
-			pages, sizeof(*umem_odp->dma_list), GFP_KERNEL);
+			ndmas, sizeof(*umem_odp->dma_list), GFP_KERNEL);
 		if (!umem_odp->dma_list) {
 			ret = -ENOMEM;
-			goto out_page_list;
+			goto out_pfn_list;
 		}

 		ret = mmu_interval_notifier_insert(&umem_odp->notifier,
@@ -98,8 +100,8 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp,

 out_dma_list:
 	kvfree(umem_odp->dma_list);
-out_page_list:
-	kvfree(umem_odp->page_list);
+out_pfn_list:
+	kvfree(umem_odp->pfn_list);
 	return ret;
 }

@@ -276,7 +278,7 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 		mutex_unlock(&umem_odp->umem_mutex);
 		mmu_interval_notifier_remove(&umem_odp->notifier);
 		kvfree(umem_odp->dma_list);
-		kvfree(umem_odp->page_list);
+		kvfree(umem_odp->pfn_list);
 	}
 	put_pid(umem_odp->tgid);
 	kfree(umem_odp);
@@ -287,87 +289,49 @@ EXPORT_SYMBOL(ib_umem_odp_release);
  * Map for DMA and insert a single page into the on-demand paging page tables.
  *
  * @umem: the umem to insert the page to.
- * @page_index: index in the umem to add the page to.
+ * @dma_index: index in the umem to add the dma to.
  * @page: the page struct to map and add.
  * @access_mask: access permissions needed for this page.
  * @current_seq: sequence number for synchronization with invalidations.
  *               the sequence number is taken from
  *               umem_odp->notifiers_seq.
  *
- * The function returns -EFAULT if the DMA mapping operation fails. It returns
- * -EAGAIN if a concurrent invalidation prevents us from updating the page.
+ * The function returns -EFAULT if the DMA mapping operation fails.
  *
- * The page is released via put_page even if the operation failed. For on-demand
- * pinning, the page is released whenever it isn't stored in the umem.
  */
 static int ib_umem_odp_map_dma_single_page(
 		struct ib_umem_odp *umem_odp,
-		unsigned int page_index,
+		unsigned int dma_index,
 		struct page *page,
-		u64 access_mask,
-		unsigned long current_seq)
+		u64 access_mask)
 {
 	struct ib_device *dev = umem_odp->umem.ibdev;
-	dma_addr_t dma_addr;
-	int ret = 0;
-
-	if (mmu_interval_check_retry(&umem_odp->notifier, current_seq)) {
-		ret = -EAGAIN;
-		goto out;
-	}
-	if (!(umem_odp->dma_list[page_index])) {
-		dma_addr =
-			ib_dma_map_page(dev, page, 0, BIT(umem_odp->page_shift),
-					DMA_BIDIRECTIONAL);
-		if (ib_dma_mapping_error(dev, dma_addr)) {
-			ret = -EFAULT;
-			goto out;
-		}
-		umem_odp->dma_list[page_index] = dma_addr | access_mask;
-		umem_odp->page_list[page_index] = page;
+	dma_addr_t *dma_addr = &umem_odp->dma_list[dma_index];
+
+	if (!*dma_addr) {
+		*dma_addr = ib_dma_map_page(dev, page, 0,
+				1 << umem_odp->page_shift,
+				DMA_BIDIRECTIONAL);
+		if (ib_dma_mapping_error(dev, *dma_addr))
+			return -EFAULT;
 		umem_odp->npages++;
-	} else if (umem_odp->page_list[page_index] == page) {
-		umem_odp->dma_list[page_index] |= access_mask;
-	} else {
-		/*
-		 * This is a race here where we could have done:
-		 *
-		 *         CPU0                             CPU1
-		 *   get_user_pages()
-		 *                                       invalidate()
-		 *                                       page_fault()
-		 *   mutex_lock(umem_mutex)
-		 *    page from GUP != page in ODP
-		 *
-		 * It should be prevented by the retry test above as reading
-		 * the seq number should be reliable under the
-		 * umem_mutex. Thus something is really not working right if
-		 * things get here.
-		 */
-		WARN(true,
-		     "Got different pages in IB device and from get_user_pages. IB device page: %p, gup page: %p\n",
-		     umem_odp->page_list[page_index], page);
-		ret = -EAGAIN;
 	}

-out:
-	put_page(page);
-	return ret;
+	*dma_addr &= ODP_DMA_ADDR_MASK;
+	*dma_addr |= access_mask;
+	return 0;
 }

 /**
- * ib_umem_odp_map_dma_pages - Pin and DMA map userspace memory in an ODP MR.
+ * ib_umem_odp_map_dma_and_lock - DMA map userspace memory in an ODP MR and lock it.
  *
- * Pins the range of pages passed in the argument, and maps them to
- * DMA addresses. The DMA addresses of the mapped pages is updated in
- * umem_odp->dma_list.
+ * Maps the range passed in the argument to DMA addresses.
+ * The DMA addresses of the mapped pages is updated in umem_odp->dma_list.
+ * Upon success the ODP MR will be locked to let caller complete its device
+ * page table update.
  *
  * Returns the number of pages mapped in success, negative error code
  * for failure.
- * An -EAGAIN error code is returned when a concurrent mmu notifier prevents
- * the function from completing its task.
- * An -ENOENT error code indicates that userspace process is being terminated
- * and mm was already destroyed.
  * @umem_odp: the umem to map and pin
  * @user_virt: the address from which we need to map.
  * @bcnt: the minimal number of bytes to pin and map. The mapping might be
@@ -376,21 +340,18 @@ static int ib_umem_odp_map_dma_single_page(
  *        the return value.
  * @access_mask: bit mask of the requested access permissions for the given
  *               range.
- * @current_seq: the MMU notifiers sequance value for synchronization with
- *               invalidations. the sequance number is read from
- *               umem_odp->notifiers_seq before calling this function
  */
-int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
-			      u64 bcnt, u64 access_mask,
-			      unsigned long current_seq)
+int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
+				 u64 bcnt, u64 access_mask)
+			__acquires(&umem_odp->umem_mutex)
 {
 	struct task_struct *owning_process  = NULL;
 	struct mm_struct *owning_mm = umem_odp->umem.owning_mm;
-	struct page       **local_page_list = NULL;
-	u64 page_mask, off;
-	int j, k, ret = 0, start_idx, npages = 0;
-	unsigned int flags = 0, page_shift;
-	phys_addr_t p = 0;
+	int pfn_index, dma_index, ret = 0, start_idx;
+	unsigned int page_shift, hmm_order, pfn_start_idx;
+	unsigned long num_pfns, current_seq;
+	struct hmm_range range = {};
+	unsigned long timeout;

 	if (access_mask == 0)
 		return -EINVAL;
@@ -399,15 +360,7 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 	    user_virt + bcnt > ib_umem_end(umem_odp))
 		return -EFAULT;

-	local_page_list = (struct page **)__get_free_page(GFP_KERNEL);
-	if (!local_page_list)
-		return -ENOMEM;
-
 	page_shift = umem_odp->page_shift;
-	page_mask = ~(BIT(page_shift) - 1);
-	off = user_virt & (~page_mask);
-	user_virt = user_virt & page_mask;
-	bcnt += off; /* Charge for the first page offset as well. */

 	/*
 	 * owning_process is allowed to be NULL, this means somehow the mm is
@@ -420,99 +373,88 @@ int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 user_virt,
 		goto out_put_task;
 	}

+	range.notifier = &umem_odp->notifier;
+	range.start = ALIGN_DOWN(user_virt, 1UL << page_shift);
+	range.end = ALIGN(user_virt + bcnt, 1UL << page_shift);
+	pfn_start_idx = (range.start - ib_umem_start(umem_odp)) >> PAGE_SHIFT;
+	num_pfns = (range.end - range.start) >> PAGE_SHIFT;
+	range.default_flags = HMM_PFN_REQ_FAULT;
+
 	if (access_mask & ODP_WRITE_ALLOWED_BIT)
-		flags |= FOLL_WRITE;
+		range.default_flags |= HMM_PFN_REQ_WRITE;
+
+	range.hmm_pfns = &(umem_odp->pfn_list[pfn_start_idx]);
+	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
+
+retry:
+	current_seq = range.notifier_seq =
+		mmu_interval_read_begin(&umem_odp->notifier);
+
+	mmap_read_lock(owning_mm);
+	ret = hmm_range_fault(&range);
+	mmap_read_unlock(owning_mm);
+	if (unlikely(ret)) {
+		if (ret == -EBUSY && !time_after(jiffies, timeout))
+			goto retry;
+		goto out_put_mm;
+	}

-	start_idx = (user_virt - ib_umem_start(umem_odp)) >> page_shift;
-	k = start_idx;
+	start_idx = (range.start - ib_umem_start(umem_odp)) >> page_shift;
+	dma_index = start_idx;

-	while (bcnt > 0) {
-		const size_t gup_num_pages = min_t(size_t,
-				ALIGN(bcnt, PAGE_SIZE) / PAGE_SIZE,
-				PAGE_SIZE / sizeof(struct page *));
+	mutex_lock(&umem_odp->umem_mutex);
+	if (mmu_interval_read_retry(&umem_odp->notifier, current_seq)) {
+		mutex_unlock(&umem_odp->umem_mutex);
+		goto retry;
+	}

-		mmap_read_lock(owning_mm);
+	for (pfn_index = 0; pfn_index < num_pfns;
+		pfn_index += 1 << (page_shift - PAGE_SHIFT), dma_index++) {
 		/*
-		 * Note: this might result in redundent page getting. We can
-		 * avoid this by checking dma_list to be 0 before calling
-		 * get_user_pages. However, this make the code much more
-		 * complex (and doesn't gain us much performance in most use
-		 * cases).
+		 * Since we asked for hmm_range_fault() to populate pages,
+		 * it shouldn't return an error entry on success.
 		 */
-		npages = get_user_pages_remote(owning_mm,
-				user_virt, gup_num_pages,
-				flags, local_page_list, NULL, NULL);
-		mmap_read_unlock(owning_mm);
-
-		if (npages < 0) {
-			if (npages != -EAGAIN)
-				pr_warn("fail to get %zu user pages with error %d\n", gup_num_pages, npages);
-			else
-				pr_debug("fail to get %zu user pages with error %d\n", gup_num_pages, npages);
+		WARN_ON(range.hmm_pfns[pfn_index] & HMM_PFN_ERROR);
+		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
+		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
+		/* If a hugepage was detected and ODP wasn't set for, the umem
+		 * page_shift will be used, the opposite case is an error.
+		 */
+		if (hmm_order + PAGE_SHIFT < page_shift) {
+			ret = -EINVAL;
+			pr_debug("%s: un-expected hmm_order %d, page_shift %d\n",
+				 __func__, hmm_order, page_shift);
 			break;
 		}

-		bcnt -= min_t(size_t, npages << PAGE_SHIFT, bcnt);
-		mutex_lock(&umem_odp->umem_mutex);
-		for (j = 0; j < npages; j++, user_virt += PAGE_SIZE) {
-			if (user_virt & ~page_mask) {
-				p += PAGE_SIZE;
-				if (page_to_phys(local_page_list[j]) != p) {
-					ret = -EFAULT;
-					break;
-				}
-				put_page(local_page_list[j]);
-				continue;
-			}
-
-			ret = ib_umem_odp_map_dma_single_page(
-					umem_odp, k, local_page_list[j],
-					access_mask, current_seq);
-			if (ret < 0) {
-				if (ret != -EAGAIN)
-					pr_warn("ib_umem_odp_map_dma_single_page failed with error %d\n", ret);
-				else
-					pr_debug("ib_umem_odp_map_dma_single_page failed with error %d\n", ret);
-				break;
-			}
-
-			p = page_to_phys(local_page_list[j]);
-			k++;
-		}
-		mutex_unlock(&umem_odp->umem_mutex);
-
+		ret = ib_umem_odp_map_dma_single_page(
+				umem_odp, dma_index, hmm_pfn_to_page(range.hmm_pfns[pfn_index]),
+				access_mask);
 		if (ret < 0) {
-			/*
-			 * Release pages, remembering that the first page
-			 * to hit an error was already released by
-			 * ib_umem_odp_map_dma_single_page().
-			 */
-			if (npages - (j + 1) > 0)
-				release_pages(&local_page_list[j+1],
-					      npages - (j + 1));
+			pr_debug("ib_umem_odp_map_dma_single_page failed with error %d\n", ret);
 			break;
 		}
 	}
+	/* upon sucesss lock should stay on hold for the callee */
+	if (!ret)
+		ret = dma_index - start_idx;
+	else
+		mutex_unlock(&umem_odp->umem_mutex);

-	if (ret >= 0) {
-		if (npages < 0 && k == start_idx)
-			ret = npages;
-		else
-			ret = k - start_idx;
-	}
-
+out_put_mm:
 	mmput(owning_mm);
 out_put_task:
 	if (owning_process)
 		put_task_struct(owning_process);
-	free_page((unsigned long)local_page_list);
 	return ret;
 }
-EXPORT_SYMBOL(ib_umem_odp_map_dma_pages);
+EXPORT_SYMBOL(ib_umem_odp_map_dma_and_lock);

 void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 				 u64 bound)
 {
+	dma_addr_t dma_addr;
+	dma_addr_t dma;
 	int idx;
 	u64 addr;
 	struct ib_device *dev = umem_odp->umem.ibdev;
@@ -521,20 +463,16 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,

 	virt = max_t(u64, virt, ib_umem_start(umem_odp));
 	bound = min_t(u64, bound, ib_umem_end(umem_odp));
-	/* Note that during the run of this function, the
-	 * notifiers_count of the MR is > 0, preventing any racing
-	 * faults from completion. We might be racing with other
-	 * invalidations, so we must make sure we free each page only
-	 * once. */
 	for (addr = virt; addr < bound; addr += BIT(umem_odp->page_shift)) {
 		idx = (addr - ib_umem_start(umem_odp)) >> umem_odp->page_shift;
-		if (umem_odp->page_list[idx]) {
-			struct page *page = umem_odp->page_list[idx];
-			dma_addr_t dma = umem_odp->dma_list[idx];
-			dma_addr_t dma_addr = dma & ODP_DMA_ADDR_MASK;
+		dma = umem_odp->dma_list[idx];

-			WARN_ON(!dma_addr);
+		/* The access flags guaranteed a valid DMA address in case was NULL */
+		if (dma) {
+			unsigned long pfn_idx = (addr - ib_umem_start(umem_odp)) >> PAGE_SHIFT;
+			struct page *page = hmm_pfn_to_page(umem_odp->pfn_list[pfn_idx]);

+			dma_addr = dma & ODP_DMA_ADDR_MASK;
 			ib_dma_unmap_page(dev, dma_addr,
 					  BIT(umem_odp->page_shift),
 					  DMA_BIDIRECTIONAL);
@@ -551,7 +489,6 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 				 */
 				set_page_dirty(head_page);
 			}
-			umem_odp->page_list[idx] = NULL;
 			umem_odp->dma_list[idx] = 0;
 			umem_odp->npages--;
 		}
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index e40a80c6636c..0f203141a6ad 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -671,7 +671,6 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 {
 	int page_shift, ret, np;
 	bool downgrade = flags & MLX5_PF_FLAGS_DOWNGRADE;
-	unsigned long current_seq;
 	u64 access_mask;
 	u64 start_idx;

@@ -682,25 +681,16 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;

-	current_seq = mmu_interval_read_begin(&odp->notifier);
-
-	np = ib_umem_odp_map_dma_pages(odp, user_va, bcnt, access_mask,
-				       current_seq);
+	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask);
 	if (np < 0)
 		return np;

-	mutex_lock(&odp->umem_mutex);
-	if (!mmu_interval_read_retry(&odp->notifier, current_seq)) {
-		/*
-		 * No need to check whether the MTTs really belong to
-		 * this MR, since ib_umem_odp_map_dma_pages already
-		 * checks this.
-		 */
-		ret = mlx5_ib_update_xlt(mr, start_idx, np,
-					 page_shift, MLX5_IB_UPD_XLT_ATOMIC);
-	} else {
-		ret = -EAGAIN;
-	}
+	/*
+	 * No need to check whether the MTTs really belong to this MR, since
+	 * ib_umem_odp_map_dma_and_lock already checks this.
+	 */
+	ret = mlx5_ib_update_xlt(mr, start_idx, np,
+				 page_shift, MLX5_IB_UPD_XLT_ATOMIC);
 	mutex_unlock(&odp->umem_mutex);

 	if (ret < 0) {
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index d16d2c17e733..a53b62ac8a9d 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -14,17 +14,13 @@ struct ib_umem_odp {
 	struct mmu_interval_notifier notifier;
 	struct pid *tgid;

+	/* An array of the pfns included in the on-demand paging umem. */
+	unsigned long *pfn_list;
+
 	/*
-	 * An array of the pages included in the on-demand paging umem.
-	 * Indices of pages that are currently not mapped into the device will
-	 * contain NULL.
-	 */
-	struct page		**page_list;
-	/*
-	 * An array of the same size as page_list, with DMA addresses mapped
-	 * for pages the pages in page_list. The lower two bits designate
-	 * access permissions. See ODP_READ_ALLOWED_BIT and
-	 * ODP_WRITE_ALLOWED_BIT.
+	 * An array with DMA addresses mapped for pfns in pfn_list.
+	 * The lower two bits designate access permissions.
+	 * See ODP_READ_ALLOWED_BIT and ODP_WRITE_ALLOWED_BIT.
 	 */
 	dma_addr_t		*dma_list;
 	/*
@@ -97,9 +93,8 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root_umem, unsigned long addr,
 			const struct mmu_interval_notifier_ops *ops);
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp);

-int ib_umem_odp_map_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
-			      u64 bcnt, u64 access_mask,
-			      unsigned long current_seq);
+int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 start_offset,
+				 u64 bcnt, u64 access_mask);

 void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
 				 u64 bound);
--
2.26.2

