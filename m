Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8C17282B92
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 17:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726045AbgJDPoE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 11:44:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:57942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbgJDPoC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 11:44:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 88C7F20759;
        Sun,  4 Oct 2020 15:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601826241;
        bh=O7HZcQRzxRmAmnS3hiVfDbaeM/A2kfet6dFl98RAZCk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X//tSZm6sevkjEKhDCnbeghNb7kZQJg6fxH61KLJC8YdLD9vUcDgC4p0C9hU5yL3m
         ZWSgNOwL/hM/aZT1U76QjuYUS5CgSA3DaUKuoCUu5SYzhqLOZZzOk24IWuunait3zc
         kkYnHpAnt8kYgYU3KLJprm9srd/PgZEB629dLBRs=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, Christoph Hellwig <hch@lst.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Roland Scheidegger <sroland@vmware.com>,
        Tvrtko Ursulin <tvrtko.ursulin@intel.com>,
        VMware Graphics <linux-graphics-maintainer@vmware.com>
Subject: [PATCH rdma-next v5 4/4] RDMA/umem: Move to allocate SG table from pages
Date:   Sun,  4 Oct 2020 18:43:40 +0300
Message-Id: <20201004154340.1080481-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201004154340.1080481-1-leon@kernel.org>
References: <20201004154340.1080481-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Remove the implementation of ib_umem_add_sg_table and instead
call to __sg_alloc_table_from_pages which already has the logic to
merge contiguous pages.

Besides that it removes duplicated functionality, it reduces the
memory consumption of the SG table significantly. Prior to this
patch, the SG table was allocated in advance regardless consideration
of contiguous pages.

In huge pages system of 2MB page size, without this change, the SG table
would contain x512 SG entries.
E.g. for 100GB memory registration:

	 Number of entries	Size
Before 	      26214400          600.0MB
After            51200		  1.2MB

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem.c | 94 +++++-----------------------------
 1 file changed, 12 insertions(+), 82 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c1ab6a4f2bc3..e9fecbdf391b 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -61,73 +61,6 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
 	sg_free_table(&umem->sg_head);
 }

-/* ib_umem_add_sg_table - Add N contiguous pages to scatter table
- *
- * sg: current scatterlist entry
- * page_list: array of npage struct page pointers
- * npages: number of pages in page_list
- * max_seg_sz: maximum segment size in bytes
- * nents: [out] number of entries in the scatterlist
- *
- * Return new end of scatterlist
- */
-static struct scatterlist *ib_umem_add_sg_table(struct scatterlist *sg,
-						struct page **page_list,
-						unsigned long npages,
-						unsigned int max_seg_sz,
-						int *nents)
-{
-	unsigned long first_pfn;
-	unsigned long i = 0;
-	bool update_cur_sg = false;
-	bool first = !sg_page(sg);
-
-	/* Check if new page_list is contiguous with end of previous page_list.
-	 * sg->length here is a multiple of PAGE_SIZE and sg->offset is 0.
-	 */
-	if (!first && (page_to_pfn(sg_page(sg)) + (sg->length >> PAGE_SHIFT) ==
-		       page_to_pfn(page_list[0])))
-		update_cur_sg = true;
-
-	while (i != npages) {
-		unsigned long len;
-		struct page *first_page = page_list[i];
-
-		first_pfn = page_to_pfn(first_page);
-
-		/* Compute the number of contiguous pages we have starting
-		 * at i
-		 */
-		for (len = 0; i != npages &&
-			      first_pfn + len == page_to_pfn(page_list[i]) &&
-			      len < (max_seg_sz >> PAGE_SHIFT);
-		     len++)
-			i++;
-
-		/* Squash N contiguous pages from page_list into current sge */
-		if (update_cur_sg) {
-			if ((max_seg_sz - sg->length) >= (len << PAGE_SHIFT)) {
-				sg_set_page(sg, sg_page(sg),
-					    sg->length + (len << PAGE_SHIFT),
-					    0);
-				update_cur_sg = false;
-				continue;
-			}
-			update_cur_sg = false;
-		}
-
-		/* Squash N contiguous pages into next sge or first sge */
-		if (!first)
-			sg = sg_next(sg);
-
-		(*nents)++;
-		sg_set_page(sg, first_page, len << PAGE_SHIFT, 0);
-		first = false;
-	}
-
-	return sg;
-}
-
 /**
  * ib_umem_find_best_pgsz - Find best HW page size to use for this MR
  *
@@ -217,7 +150,7 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 	struct mm_struct *mm;
 	unsigned long npages;
 	int ret;
-	struct scatterlist *sg;
+	struct scatterlist *sg = NULL;
 	unsigned int gup_flags = FOLL_WRITE;

 	/*
@@ -272,15 +205,9 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,

 	cur_base = addr & PAGE_MASK;

-	ret = sg_alloc_table(&umem->sg_head, npages, GFP_KERNEL);
-	if (ret)
-		goto vma;
-
 	if (!umem->writable)
 		gup_flags |= FOLL_FORCE;

-	sg = umem->sg_head.sgl;
-
 	while (npages) {
 		cond_resched();
 		ret = pin_user_pages_fast(cur_base,
@@ -292,15 +219,19 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,
 			goto umem_release;

 		cur_base += ret * PAGE_SIZE;
-		npages   -= ret;
-
-		sg = ib_umem_add_sg_table(sg, page_list, ret,
-			dma_get_max_seg_size(device->dma_device),
-			&umem->sg_nents);
+		npages -= ret;
+		sg = __sg_alloc_table_from_pages(
+			&umem->sg_head, page_list, ret, 0, ret << PAGE_SHIFT,
+			dma_get_max_seg_size(device->dma_device), sg, npages,
+			GFP_KERNEL);
+		umem->sg_nents = umem->sg_head.nents;
+		if (IS_ERR(sg)) {
+			unpin_user_pages_dirty_lock(page_list, ret, 0);
+			ret = PTR_ERR(sg);
+			goto umem_release;
+		}
 	}

-	sg_mark_end(sg);
-
 	if (access & IB_ACCESS_RELAXED_ORDERING)
 		dma_attr |= DMA_ATTR_WEAK_ORDERING;

@@ -318,7 +249,6 @@ struct ib_umem *ib_umem_get(struct ib_device *device, unsigned long addr,

 umem_release:
 	__ib_umem_release(device, umem, 0);
-vma:
 	atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
 out:
 	free_page((unsigned long) page_list);
--
2.26.2

