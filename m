Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 469501B32EF
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Apr 2020 01:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgDUXLZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 21 Apr 2020 19:11:25 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:3543 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725822AbgDUXLZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 21 Apr 2020 19:11:25 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e9f7d280000>; Tue, 21 Apr 2020 16:09:28 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Tue, 21 Apr 2020 16:11:24 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Tue, 21 Apr 2020 16:11:24 -0700
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 21 Apr
 2020 23:11:21 +0000
Received: from rnnvemgw01.nvidia.com (10.128.109.123) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Tue, 21 Apr 2020 23:11:21 +0000
Received: from rcampbell-dev.nvidia.com (Not Verified[10.110.48.66]) by rnnvemgw01.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e9f7d980002>; Tue, 21 Apr 2020 16:11:20 -0700
From:   Ralph Campbell <rcampbell@nvidia.com>
To:     <nouveau@lists.freedesktop.org>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Jason Gunthorpe <jgg@mellanox.com>,
        "Ben Skeggs" <bskeggs@redhat.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Subject: [PATCH] nouveau/hmm: fix nouveau_dmem_chunk allocations
Date:   Tue, 21 Apr 2020 16:11:07 -0700
Message-ID: <20200421231107.30958-1-rcampbell@nvidia.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1587510568; bh=Ss8LfMa+AksRBRBDjwFG7kPV3m+nba4icKUZa29lbwk=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         MIME-Version:Content-Transfer-Encoding:Content-Type;
        b=WaJXjpFp7f+xKtg4Q3ZNNZEIZoeKi3onACSQ1j1kglR43cR95ldXnmf07qBap1Xjv
         vWR9xJO4UFCzWaBlbqRSBHHyNFUorBEb2YeyM/XaKP+36ofgw5cgKgRbBILgjtjsqB
         6kRpT2mj5IbwXzEGUhTqKjMnixMGyJjCoHNFe5sKFwxwS+1zyFmvXO3OebLyPD68K0
         ksHcpwneogEcDEWlPylTCHAWvntqPKxlxO1gpQoxjQG7ODbl253Pm7IvthJf44GEjf
         guJFFr+E2tPrf8LP0U9keU5CyyWcwtrJ3aPEkCnS8I31ryFAiQgv2gaTC+1N37dmXK
         a6Klo5owp/c2A==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In nouveau_dmem_init(), a number of struct nouveau_dmem_chunk are allocated
and put on the dmem->chunk_empty list. Then in nouveau_dmem_pages_alloc(),
a nouveau_dmem_chunk is removed from the list and GPU memory is allocated.
However, the nouveau_dmem_chunk is never removed from the chunk_empty
list nor placed on the chunk_free or chunk_full lists. This results
in only one chunk ever being actually used (2MB) and quickly leads to
migration to device private memory failures.

Fix this by having just one list of free device private pages and if no
pages are free, allocate a chunk of device private pages and GPU memory.

Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
---
 drivers/gpu/drm/nouveau/nouveau_dmem.c | 304 +++++++++----------------
 1 file changed, 112 insertions(+), 192 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dmem.c b/drivers/gpu/drm/nouve=
au/nouveau_dmem.c
index a2ef8d562867..c39500a84b17 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dmem.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dmem.c
@@ -61,10 +61,8 @@ struct nouveau_dmem_chunk {
 	struct list_head list;
 	struct nouveau_bo *bo;
 	struct nouveau_drm *drm;
-	unsigned long pfn_first;
 	unsigned long callocated;
-	unsigned long bitmap[BITS_TO_LONGS(DMEM_CHUNK_NPAGES)];
-	spinlock_t lock;
+	struct dev_pagemap pagemap;
 };
=20
 struct nouveau_dmem_migrate {
@@ -74,48 +72,50 @@ struct nouveau_dmem_migrate {
=20
 struct nouveau_dmem {
 	struct nouveau_drm *drm;
-	struct dev_pagemap pagemap;
 	struct nouveau_dmem_migrate migrate;
-	struct list_head chunk_free;
-	struct list_head chunk_full;
-	struct list_head chunk_empty;
+	struct list_head chunks;
 	struct mutex mutex;
+	struct page *free_pages;
+	spinlock_t lock;
 };
=20
-static inline struct nouveau_dmem *page_to_dmem(struct page *page)
+static struct nouveau_dmem_chunk *nouveau_page_to_chunk(struct page *page)
+{
+	return container_of(page->pgmap, struct nouveau_dmem_chunk, pagemap);
+}
+
+static struct nouveau_drm *page_to_drm(struct page *page)
 {
-	return container_of(page->pgmap, struct nouveau_dmem, pagemap);
+	struct nouveau_dmem_chunk *chunk =3D nouveau_page_to_chunk(page);
+
+	return chunk->drm;
 }
=20
 static unsigned long nouveau_dmem_page_addr(struct page *page)
 {
-	struct nouveau_dmem_chunk *chunk =3D page->zone_device_data;
-	unsigned long idx =3D page_to_pfn(page) - chunk->pfn_first;
+	struct nouveau_dmem_chunk *chunk =3D nouveau_page_to_chunk(page);
+	unsigned long off =3D (page_to_pfn(page) << PAGE_SHIFT) -
+				chunk->pagemap.res.start;
=20
-	return (idx << PAGE_SHIFT) + chunk->bo->bo.offset;
+	return chunk->bo->bo.offset + off;
 }
=20
 static void nouveau_dmem_page_free(struct page *page)
 {
-	struct nouveau_dmem_chunk *chunk =3D page->zone_device_data;
-	unsigned long idx =3D page_to_pfn(page) - chunk->pfn_first;
+	struct nouveau_dmem_chunk *chunk =3D nouveau_page_to_chunk(page);
+	struct nouveau_dmem *dmem =3D chunk->drm->dmem;
+
+	spin_lock(&dmem->lock);
+	page->zone_device_data =3D dmem->free_pages;
+	dmem->free_pages =3D page;
=20
-	/*
-	 * FIXME:
-	 *
-	 * This is really a bad example, we need to overhaul nouveau memory
-	 * management to be more page focus and allow lighter locking scheme
-	 * to be use in the process.
-	 */
-	spin_lock(&chunk->lock);
-	clear_bit(idx, chunk->bitmap);
 	WARN_ON(!chunk->callocated);
 	chunk->callocated--;
 	/*
 	 * FIXME when chunk->callocated reach 0 we should add the chunk to
 	 * a reclaim list so that it can be freed in case of memory pressure.
 	 */
-	spin_unlock(&chunk->lock);
+	spin_unlock(&dmem->lock);
 }
=20
 static void nouveau_dmem_fence_done(struct nouveau_fence **fence)
@@ -167,8 +167,8 @@ static vm_fault_t nouveau_dmem_fault_copy_one(struct no=
uveau_drm *drm,
=20
 static vm_fault_t nouveau_dmem_migrate_to_ram(struct vm_fault *vmf)
 {
-	struct nouveau_dmem *dmem =3D page_to_dmem(vmf->page);
-	struct nouveau_drm *drm =3D dmem->drm;
+	struct nouveau_drm *drm =3D page_to_drm(vmf->page);
+	struct nouveau_dmem *dmem =3D drm->dmem;
 	struct nouveau_fence *fence;
 	unsigned long src =3D 0, dst =3D 0;
 	dma_addr_t dma_addr =3D 0;
@@ -211,131 +211,105 @@ static const struct dev_pagemap_ops nouveau_dmem_pa=
gemap_ops =3D {
 };
=20
 static int
-nouveau_dmem_chunk_alloc(struct nouveau_drm *drm)
+nouveau_dmem_chunk_alloc(struct nouveau_drm *drm, struct page **ppage)
 {
 	struct nouveau_dmem_chunk *chunk;
+	struct resource *res;
+	struct page *page;
+	void *ptr;
+	unsigned long i, pfn_first;
 	int ret;
=20
-	if (drm->dmem =3D=3D NULL)
-		return -EINVAL;
-
-	mutex_lock(&drm->dmem->mutex);
-	chunk =3D list_first_entry_or_null(&drm->dmem->chunk_empty,
-					 struct nouveau_dmem_chunk,
-					 list);
+	chunk =3D kzalloc(sizeof(*chunk), GFP_KERNEL);
 	if (chunk =3D=3D NULL) {
-		mutex_unlock(&drm->dmem->mutex);
-		return -ENOMEM;
+		ret =3D -ENOMEM;
+		goto out;
 	}
=20
-	list_del(&chunk->list);
-	mutex_unlock(&drm->dmem->mutex);
+	/* Allocate unused physical address space for device private pages. */
+	res =3D request_free_mem_region(&iomem_resource, DMEM_CHUNK_SIZE,
+				      "nouveau_dmem");
+	if (IS_ERR(res)) {
+		ret =3D PTR_ERR(res);
+		goto out_free;
+	}
+
+	chunk->drm =3D drm;
+	chunk->pagemap.type =3D MEMORY_DEVICE_PRIVATE;
+	chunk->pagemap.res =3D *res;
+	chunk->pagemap.ops =3D &nouveau_dmem_pagemap_ops;
+	chunk->pagemap.owner =3D drm->dev;
=20
 	ret =3D nouveau_bo_new(&drm->client, DMEM_CHUNK_SIZE, 0,
 			     TTM_PL_FLAG_VRAM, 0, 0, NULL, NULL,
 			     &chunk->bo);
 	if (ret)
-		goto out;
+		goto out_release;
=20
 	ret =3D nouveau_bo_pin(chunk->bo, TTM_PL_FLAG_VRAM, false);
-	if (ret) {
-		nouveau_bo_ref(NULL, &chunk->bo);
-		goto out;
-	}
+	if (ret)
+		goto out_bo_free;
=20
-	bitmap_zero(chunk->bitmap, DMEM_CHUNK_NPAGES);
-	spin_lock_init(&chunk->lock);
+	ptr =3D memremap_pages(&chunk->pagemap, numa_node_id());
+	if (IS_ERR(ptr)) {
+		ret =3D PTR_ERR(ptr);
+		goto out_bo_unpin;
+	}
=20
-out:
 	mutex_lock(&drm->dmem->mutex);
-	if (chunk->bo)
-		list_add(&chunk->list, &drm->dmem->chunk_empty);
-	else
-		list_add_tail(&chunk->list, &drm->dmem->chunk_empty);
+	list_add(&chunk->list, &drm->dmem->chunks);
 	mutex_unlock(&drm->dmem->mutex);
=20
-	return ret;
-}
-
-static struct nouveau_dmem_chunk *
-nouveau_dmem_chunk_first_free_locked(struct nouveau_drm *drm)
-{
-	struct nouveau_dmem_chunk *chunk;
-
-	chunk =3D list_first_entry_or_null(&drm->dmem->chunk_free,
-					 struct nouveau_dmem_chunk,
-					 list);
-	if (chunk)
-		return chunk;
-
-	chunk =3D list_first_entry_or_null(&drm->dmem->chunk_empty,
-					 struct nouveau_dmem_chunk,
-					 list);
-	if (chunk->bo)
-		return chunk;
-
-	return NULL;
-}
-
-static int
-nouveau_dmem_pages_alloc(struct nouveau_drm *drm,
-			 unsigned long npages,
-			 unsigned long *pages)
-{
-	struct nouveau_dmem_chunk *chunk;
-	unsigned long c;
-	int ret;
-
-	memset(pages, 0xff, npages * sizeof(*pages));
-
-	mutex_lock(&drm->dmem->mutex);
-	for (c =3D 0; c < npages;) {
-		unsigned long i;
-
-		chunk =3D nouveau_dmem_chunk_first_free_locked(drm);
-		if (chunk =3D=3D NULL) {
-			mutex_unlock(&drm->dmem->mutex);
-			ret =3D nouveau_dmem_chunk_alloc(drm);
-			if (ret) {
-				if (c)
-					return 0;
-				return ret;
-			}
-			mutex_lock(&drm->dmem->mutex);
-			continue;
-		}
-
-		spin_lock(&chunk->lock);
-		i =3D find_first_zero_bit(chunk->bitmap, DMEM_CHUNK_NPAGES);
-		while (i < DMEM_CHUNK_NPAGES && c < npages) {
-			pages[c] =3D chunk->pfn_first + i;
-			set_bit(i, chunk->bitmap);
-			chunk->callocated++;
-			c++;
-
-			i =3D find_next_zero_bit(chunk->bitmap,
-					DMEM_CHUNK_NPAGES, i);
-		}
-		spin_unlock(&chunk->lock);
+	pfn_first =3D chunk->pagemap.res.start >> PAGE_SHIFT;
+	page =3D pfn_to_page(pfn_first);
+	spin_lock(&drm->dmem->lock);
+	for (i =3D 0; i < DMEM_CHUNK_NPAGES - 1; ++i, ++page) {
+		page->zone_device_data =3D drm->dmem->free_pages;
+		drm->dmem->free_pages =3D page;
 	}
-	mutex_unlock(&drm->dmem->mutex);
+	*ppage =3D page;
+	chunk->callocated++;
+	spin_unlock(&drm->dmem->lock);
+
+	NV_INFO(drm, "DMEM: registered %ldMB of device memory\n",
+		DMEM_CHUNK_SIZE >> 20);
=20
 	return 0;
+
+out_bo_unpin:
+	nouveau_bo_unpin(chunk->bo);
+out_bo_free:
+	nouveau_bo_ref(NULL, &chunk->bo);
+out_release:
+	release_mem_region(chunk->pagemap.res.start,
+			   resource_size(&chunk->pagemap.res));
+out_free:
+	kfree(chunk);
+out:
+	return ret;
 }
=20
 static struct page *
 nouveau_dmem_page_alloc_locked(struct nouveau_drm *drm)
 {
-	unsigned long pfns[1];
-	struct page *page;
+	struct nouveau_dmem_chunk *chunk;
+	struct page *page =3D NULL;
 	int ret;
=20
-	/* FIXME stop all the miss-match API ... */
-	ret =3D nouveau_dmem_pages_alloc(drm, 1, pfns);
-	if (ret)
-		return NULL;
+	spin_lock(&drm->dmem->lock);
+	if (drm->dmem->free_pages) {
+		page =3D drm->dmem->free_pages;
+		drm->dmem->free_pages =3D page->zone_device_data;
+		chunk =3D nouveau_page_to_chunk(page);
+		chunk->callocated++;
+		spin_unlock(&drm->dmem->lock);
+	} else {
+		spin_unlock(&drm->dmem->lock);
+		ret =3D nouveau_dmem_chunk_alloc(drm, &page);
+		if (ret)
+			return NULL;
+	}
=20
-	page =3D pfn_to_page(pfns[0]);
 	get_page(page);
 	lock_page(page);
 	return page;
@@ -358,12 +332,7 @@ nouveau_dmem_resume(struct nouveau_drm *drm)
 		return;
=20
 	mutex_lock(&drm->dmem->mutex);
-	list_for_each_entry (chunk, &drm->dmem->chunk_free, list) {
-		ret =3D nouveau_bo_pin(chunk->bo, TTM_PL_FLAG_VRAM, false);
-		/* FIXME handle pin failure */
-		WARN_ON(ret);
-	}
-	list_for_each_entry (chunk, &drm->dmem->chunk_full, list) {
+	list_for_each_entry(chunk, &drm->dmem->chunks, list) {
 		ret =3D nouveau_bo_pin(chunk->bo, TTM_PL_FLAG_VRAM, false);
 		/* FIXME handle pin failure */
 		WARN_ON(ret);
@@ -380,12 +349,8 @@ nouveau_dmem_suspend(struct nouveau_drm *drm)
 		return;
=20
 	mutex_lock(&drm->dmem->mutex);
-	list_for_each_entry (chunk, &drm->dmem->chunk_free, list) {
-		nouveau_bo_unpin(chunk->bo);
-	}
-	list_for_each_entry (chunk, &drm->dmem->chunk_full, list) {
+	list_for_each_entry(chunk, &drm->dmem->chunks, list)
 		nouveau_bo_unpin(chunk->bo);
-	}
 	mutex_unlock(&drm->dmem->mutex);
 }
=20
@@ -399,15 +364,13 @@ nouveau_dmem_fini(struct nouveau_drm *drm)
=20
 	mutex_lock(&drm->dmem->mutex);
=20
-	WARN_ON(!list_empty(&drm->dmem->chunk_free));
-	WARN_ON(!list_empty(&drm->dmem->chunk_full));
-
-	list_for_each_entry_safe (chunk, tmp, &drm->dmem->chunk_empty, list) {
-		if (chunk->bo) {
-			nouveau_bo_unpin(chunk->bo);
-			nouveau_bo_ref(NULL, &chunk->bo);
-		}
+	list_for_each_entry_safe(chunk, tmp, &drm->dmem->chunks, list) {
+		nouveau_bo_unpin(chunk->bo);
+		nouveau_bo_ref(NULL, &chunk->bo);
 		list_del(&chunk->list);
+		memunmap_pages(&chunk->pagemap);
+		release_mem_region(chunk->pagemap.res.start,
+				   resource_size(&chunk->pagemap.res));
 		kfree(chunk);
 	}
=20
@@ -493,9 +456,6 @@ nouveau_dmem_migrate_init(struct nouveau_drm *drm)
 void
 nouveau_dmem_init(struct nouveau_drm *drm)
 {
-	struct device *device =3D drm->dev->dev;
-	struct resource *res;
-	unsigned long i, size, pfn_first;
 	int ret;
=20
 	/* This only make sense on PASCAL or newer */
@@ -507,59 +467,16 @@ nouveau_dmem_init(struct nouveau_drm *drm)
=20
 	drm->dmem->drm =3D drm;
 	mutex_init(&drm->dmem->mutex);
-	INIT_LIST_HEAD(&drm->dmem->chunk_free);
-	INIT_LIST_HEAD(&drm->dmem->chunk_full);
-	INIT_LIST_HEAD(&drm->dmem->chunk_empty);
-
-	size =3D ALIGN(drm->client.device.info.ram_user, DMEM_CHUNK_SIZE);
+	INIT_LIST_HEAD(&drm->dmem->chunks);
+	mutex_init(&drm->dmem->mutex);
+	spin_lock_init(&drm->dmem->lock);
=20
 	/* Initialize migration dma helpers before registering memory */
 	ret =3D nouveau_dmem_migrate_init(drm);
-	if (ret)
-		goto out_free;
-
-	/*
-	 * FIXME we need some kind of policy to decide how much VRAM we
-	 * want to register with HMM. For now just register everything
-	 * and latter if we want to do thing like over commit then we
-	 * could revisit this.
-	 */
-	res =3D devm_request_free_mem_region(device, &iomem_resource, size);
-	if (IS_ERR(res))
-		goto out_free;
-	drm->dmem->pagemap.type =3D MEMORY_DEVICE_PRIVATE;
-	drm->dmem->pagemap.res =3D *res;
-	drm->dmem->pagemap.ops =3D &nouveau_dmem_pagemap_ops;
-	drm->dmem->pagemap.owner =3D drm->dev;
-	if (IS_ERR(devm_memremap_pages(device, &drm->dmem->pagemap)))
-		goto out_free;
-
-	pfn_first =3D res->start >> PAGE_SHIFT;
-	for (i =3D 0; i < (size / DMEM_CHUNK_SIZE); ++i) {
-		struct nouveau_dmem_chunk *chunk;
-		struct page *page;
-		unsigned long j;
-
-		chunk =3D kzalloc(sizeof(*chunk), GFP_KERNEL);
-		if (chunk =3D=3D NULL) {
-			nouveau_dmem_fini(drm);
-			return;
-		}
-
-		chunk->drm =3D drm;
-		chunk->pfn_first =3D pfn_first + (i * DMEM_CHUNK_NPAGES);
-		list_add_tail(&chunk->list, &drm->dmem->chunk_empty);
-
-		page =3D pfn_to_page(chunk->pfn_first);
-		for (j =3D 0; j < DMEM_CHUNK_NPAGES; ++j, ++page)
-			page->zone_device_data =3D chunk;
+	if (ret) {
+		kfree(drm->dmem);
+		drm->dmem =3D NULL;
 	}
-
-	NV_INFO(drm, "DMEM: registered %ldMB of device memory\n", size >> 20);
-	return;
-out_free:
-	kfree(drm->dmem);
-	drm->dmem =3D NULL;
 }
=20
 static unsigned long nouveau_dmem_migrate_copy_one(struct nouveau_drm *drm=
,
@@ -646,6 +563,9 @@ nouveau_dmem_migrate_vma(struct nouveau_drm *drm,
 	u64 *pfns;
 	int ret =3D -ENOMEM;
=20
+	if (drm->dmem =3D=3D NULL)
+		return -ENODEV;
+
 	args.src =3D kcalloc(max, sizeof(*args.src), GFP_KERNEL);
 	if (!args.src)
 		goto out;
--=20
2.25.2

