Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36AA314B4B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:54:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726046AbfEFNyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:54:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:48135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726190AbfEFNyF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:54:05 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344291844"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.255.35.243])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 06:54:03 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v3 rdma-next 5/6] RDMA/umem: Remove hugetlb flag
Date:   Mon,  6 May 2019 08:53:36 -0500
Message-Id: <20190506135337.11324-6-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190506135337.11324-1-shiraz.saleem@intel.com>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The drivers i40iw and bnxt_re no longer dependent on the
hugetlb flag. So remove this flag from ib_umem structure.

Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/core/umem.c     | 26 +-------------------------
 drivers/infiniband/core/umem_odp.c |  3 ---
 include/rdma/ib_umem.h             |  1 -
 3 files changed, 1 insertion(+), 29 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 2534ddd..13441b2 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -37,7 +37,6 @@
 #include <linux/sched/signal.h>
 #include <linux/sched/mm.h>
 #include <linux/export.h>
-#include <linux/hugetlb.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
 #include <rdma/ib_umem_odp.h>
@@ -195,14 +194,12 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 	struct ib_ucontext *context;
 	struct ib_umem *umem;
 	struct page **page_list;
-	struct vm_area_struct **vma_list;
 	unsigned long lock_limit;
 	unsigned long new_pinned;
 	unsigned long cur_base;
 	struct mm_struct *mm;
 	unsigned long npages;
 	int ret;
-	int i;
 	unsigned long dma_attrs = 0;
 	struct scatterlist *sg;
 	unsigned int gup_flags = FOLL_WRITE;
@@ -260,23 +257,12 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 		return umem;
 	}
 
-	/* We assume the memory is from hugetlb until proved otherwise */
-	umem->hugetlb   = 1;
-
 	page_list = (struct page **) __get_free_page(GFP_KERNEL);
 	if (!page_list) {
 		ret = -ENOMEM;
 		goto umem_kfree;
 	}
 
-	/*
-	 * if we can't alloc the vma_list, it's not so bad;
-	 * just assume the memory is not hugetlb memory
-	 */
-	vma_list = (struct vm_area_struct **) __get_free_page(GFP_KERNEL);
-	if (!vma_list)
-		umem->hugetlb = 0;
-
 	npages = ib_umem_num_pages(umem);
 	if (npages == 0 || npages > UINT_MAX) {
 		ret = -EINVAL;
@@ -308,7 +294,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 		ret = get_user_pages_longterm(cur_base,
 				     min_t(unsigned long, npages,
 					   PAGE_SIZE / sizeof (struct page *)),
-				     gup_flags, page_list, vma_list);
+				     gup_flags, page_list, NULL);
 		if (ret < 0) {
 			up_read(&mm->mmap_sem);
 			goto umem_release;
@@ -321,14 +307,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 			dma_get_max_seg_size(context->device->dma_device),
 			&umem->sg_nents);
 
-		/* Continue to hold the mmap_sem as vma_list access
-		 * needs to be protected.
-		 */
-		for (i = 0; i < ret && umem->hugetlb; i++) {
-			if (vma_list && !is_vm_hugetlb_page(vma_list[i]))
-				umem->hugetlb = 0;
-		}
-
 		up_read(&mm->mmap_sem);
 	}
 
@@ -353,8 +331,6 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 vma:
 	atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
 out:
-	if (vma_list)
-		free_page((unsigned long) vma_list);
 	free_page((unsigned long) page_list);
 umem_kfree:
 	if (ret) {
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 9721914..c7226cf 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -417,9 +417,6 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 		h = hstate_vma(vma);
 		umem->page_shift = huge_page_shift(h);
 		up_read(&mm->mmap_sem);
-		umem->hugetlb = 1;
-	} else {
-		umem->hugetlb = 0;
 	}
 
 	mutex_init(&umem_odp->umem_mutex);
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 917b687..040d853 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -48,7 +48,6 @@ struct ib_umem {
 	unsigned long		address;
 	int			page_shift;
 	u32 writable : 1;
-	u32 hugetlb : 1;
 	u32 is_odp : 1;
 	struct work_struct	work;
 	struct sg_table sg_head;
-- 
1.8.3.1

