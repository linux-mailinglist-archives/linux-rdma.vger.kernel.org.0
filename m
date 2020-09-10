Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E36A3265362
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Sep 2020 23:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728047AbgIJVd0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Sep 2020 17:33:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:57774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730967AbgIJNuh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Sep 2020 09:50:37 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 59AB320BED;
        Thu, 10 Sep 2020 13:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599745396;
        bh=8QzOBdGtAEfTvY+qjjRebWQ49oYXe7yIQ/TYvn0cRvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CD8znm7TPFIPB1nouUDF75W8epNtlXG7DRjzpdNy7UwpgGBhQW3Oy6JaAJ5Y8ziMw
         CMLF3mm6f/JcvD9aEbGLJVmH+7AafS1Y3BI5vyvaYFFvNl0Gx26T6omiK1wiK2qNwt
         SacFlno9L8kwEFcI08Odk8G9I6vmkyOTcPG4EusE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Maor Gottlieb <maorg@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 4/4] RDMA/umem: Move to allocate SG table from pages
Date:   Thu, 10 Sep 2020 16:42:59 +0300
Message-Id: <20200910134259.1304543-5-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910134259.1304543-1-leon@kernel.org>
References: <20200910134259.1304543-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Maor Gottlieb <maorg@nvidia.com>

Remove the implementation of ib_umem_add_sg_table and instead
call to sg_alloc_table_append which already has the logic to
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
 drivers/infiniband/Kconfig     |  1 +
 drivers/infiniband/core/umem.c | 90 +++++-----------------------------
 2 files changed, 12 insertions(+), 79 deletions(-)

diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
index 91b023341b77..2f299c0be2e5 100644
--- a/drivers/infiniband/Kconfig
+++ b/drivers/infiniband/Kconfig
@@ -6,6 +6,7 @@ menuconfig INFINIBAND
 	depends on INET
 	depends on m || IPV6 != m
 	depends on !ALPHA
+	depends on !ARCH_NO_SG_CHAIN
 	select IRQ_POLL
 	select DIMLIB
 	help
diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index 01b680b62846..690c303bcc8c 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -63,73 +63,6 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
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
@@ -221,7 +154,7 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,
 	struct mm_struct *mm;
 	unsigned long npages;
 	int ret;
-	struct scatterlist *sg;
+	struct scatterlist *sg = NULL;
 	unsigned int gup_flags = FOLL_WRITE;

 	/*
@@ -276,15 +209,9 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,

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
@@ -297,10 +224,16 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,

 		cur_base += ret * PAGE_SIZE;
 		npages   -= ret;
-
-		sg = ib_umem_add_sg_table(sg, page_list, ret,
-			dma_get_max_seg_size(device->dma_device),
-			&umem->sg_nents);
+		sg = sg_alloc_table_append(&umem->sg_head, page_list, ret, 0,
+					   ret << PAGE_SHIFT,
+					   dma_get_max_seg_size(device->dma_device),
+					   GFP_KERNEL, sg, npages);
+		umem->sg_nents = umem->sg_head.nents;
+		if (IS_ERR(sg)) {
+			unpin_user_pages_dirty_lock(page_list, ret, 0);
+			ret = PTR_ERR(sg);
+			goto umem_release;
+		}
 	}

 	sg_mark_end(sg);
@@ -322,7 +255,6 @@ static struct ib_umem *__ib_umem_get(struct ib_device *device,

 umem_release:
 	__ib_umem_release(device, umem, 0);
-vma:
 	atomic64_sub(ib_umem_num_pages(umem), &mm->pinned_vm);
 out:
 	free_page((unsigned long) page_list);
--
2.26.2

