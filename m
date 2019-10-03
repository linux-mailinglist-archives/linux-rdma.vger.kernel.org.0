Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE228CAFFC
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:20:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389147AbfJCUUi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:38 -0400
Received: from mx2.suse.de ([195.135.220.15]:46802 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2389025AbfJCUUi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:38 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AEAD4B03B;
        Thu,  3 Oct 2019 20:20:33 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Doug Ledford <dledford@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 09/11] lib/interval-tree: convert interval_tree to half closed intervals
Date:   Thu,  3 Oct 2019 13:18:56 -0700
Message-Id: <20191003201858.11666-10-dave@stgolabs.net>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003201858.11666-1-dave@stgolabs.net>
References: <20191003201858.11666-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The generic tree tree really wants [a, b) intervals, not fully closed.
As such convert it to use the new interval_tree_gen.h. Most of the
conversions are straightforward, with the exception of perhaps
radeon_vm_bo_set_addr(), but semantics have been tried to be left
untouched.

Cc: "Christian König" <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Doug Ledford <dledford@redhat.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: "Jérôme Glisse" <jglisse@redhat.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-rdma@vger.kernel.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c      | 12 +++---------
 drivers/gpu/drm/i915/gem/i915_gem_userptr.c |  5 +----
 drivers/gpu/drm/radeon/radeon_mn.c          | 11 ++++-------
 drivers/gpu/drm/radeon/radeon_trace.h       |  2 +-
 drivers/gpu/drm/radeon/radeon_vm.c          | 26 +++++++++++++-------------
 drivers/infiniband/core/umem_odp.c          | 21 +++++++--------------
 drivers/iommu/virtio-iommu.c                |  6 +++---
 include/linux/interval_tree.h               |  2 +-
 include/rdma/ib_umem_odp.h                  |  4 ++--
 lib/interval_tree.c                         |  6 +++---
 10 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
index 31d4deb5d294..4bbaa9ffa570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mn.c
@@ -205,9 +205,6 @@ amdgpu_mn_sync_pagetables_gfx(struct hmm_mirror *mirror,
 	bool blockable = mmu_notifier_range_blockable(update);
 	struct interval_tree_node *it;
 
-	/* notification is exclusive, but interval is inclusive */
-	end -= 1;
-
 	/* TODO we should be able to split locking for interval tree and
 	 * amdgpu_mn_invalidate_node
 	 */
@@ -254,9 +251,6 @@ amdgpu_mn_sync_pagetables_hsa(struct hmm_mirror *mirror,
 	bool blockable = mmu_notifier_range_blockable(update);
 	struct interval_tree_node *it;
 
-	/* notification is exclusive, but interval is inclusive */
-	end -= 1;
-
 	if (amdgpu_mn_read_lock(amn, blockable))
 		return -EAGAIN;
 
@@ -374,7 +368,7 @@ struct amdgpu_mn *amdgpu_mn_get(struct amdgpu_device *adev,
  */
 int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 {
-	unsigned long end = addr + amdgpu_bo_size(bo) - 1;
+	unsigned long end = addr + amdgpu_bo_size(bo);
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	enum amdgpu_mn_type type =
 		bo->kfd_bo ? AMDGPU_MN_TYPE_HSA : AMDGPU_MN_TYPE_GFX;
@@ -400,7 +394,7 @@ int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 		node = container_of(it, struct amdgpu_mn_node, it);
 		interval_tree_remove(&node->it, &amn->objects);
 		addr = min(it->start, addr);
-		end = max(it->last, end);
+		end = max(it->end, end);
 		list_splice(&node->bos, &bos);
 	}
 
@@ -412,7 +406,7 @@ int amdgpu_mn_register(struct amdgpu_bo *bo, unsigned long addr)
 	bo->mn = amn;
 
 	node->it.start = addr;
-	node->it.last = end;
+	node->it.end = end;
 	INIT_LIST_HEAD(&node->bos);
 	list_splice(&bos, &node->bos);
 	list_add(&bo->mn_list, &node->bos);
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
index 11b231c187c5..818ff6b33102 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_userptr.c
@@ -99,9 +99,6 @@ userptr_mn_invalidate_range_start(struct mmu_notifier *_mn,
 	if (RB_EMPTY_ROOT(&mn->objects.rb_root))
 		return 0;
 
-	/* interval ranges are inclusive, but invalidate range is exclusive */
-	end = range->end - 1;
-
 	spin_lock(&mn->lock);
 	it = interval_tree_iter_first(&mn->objects, range->start, end);
 	while (it) {
@@ -275,7 +272,7 @@ i915_gem_userptr_init__mmu_notifier(struct drm_i915_gem_object *obj,
 	mo->mn = mn;
 	mo->obj = obj;
 	mo->it.start = obj->userptr.ptr;
-	mo->it.last = obj->userptr.ptr + obj->base.size - 1;
+	mo->it.end = obj->userptr.ptr + obj->base.size;
 	RB_CLEAR_NODE(&mo->it.rb);
 
 	obj->userptr.mmu_object = mo;
diff --git a/drivers/gpu/drm/radeon/radeon_mn.c b/drivers/gpu/drm/radeon/radeon_mn.c
index dbab9a3a969b..4810421dacc2 100644
--- a/drivers/gpu/drm/radeon/radeon_mn.c
+++ b/drivers/gpu/drm/radeon/radeon_mn.c
@@ -66,12 +66,9 @@ static int radeon_mn_invalidate_range_start(struct mmu_notifier *mn,
 	struct radeon_mn *rmn = container_of(mn, struct radeon_mn, mn);
 	struct ttm_operation_ctx ctx = { false, false };
 	struct interval_tree_node *it;
-	unsigned long end;
+	unsigned long end = range->end;
 	int ret = 0;
 
-	/* notification is exclusive, but interval is inclusive */
-	end = range->end - 1;
-
 	/* TODO we should be able to split locking for interval tree and
 	 * the tear down.
 	 */
@@ -174,7 +171,7 @@ static const struct mmu_notifier_ops radeon_mn_ops = {
  */
 int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 {
-	unsigned long end = addr + radeon_bo_size(bo) - 1;
+	unsigned long end = addr + radeon_bo_size(bo);
 	struct mmu_notifier *mn;
 	struct radeon_mn *rmn;
 	struct radeon_mn_node *node = NULL;
@@ -195,7 +192,7 @@ int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 		node = container_of(it, struct radeon_mn_node, it);
 		interval_tree_remove(&node->it, &rmn->objects);
 		addr = min(it->start, addr);
-		end = max(it->last, end);
+		end = max(it->end, end);
 		list_splice(&node->bos, &bos);
 	}
 
@@ -210,7 +207,7 @@ int radeon_mn_register(struct radeon_bo *bo, unsigned long addr)
 	bo->mn = rmn;
 
 	node->it.start = addr;
-	node->it.last = end;
+	node->it.end = end;
 	INIT_LIST_HEAD(&node->bos);
 	list_splice(&bos, &node->bos);
 	list_add(&bo->mn_list, &node->bos);
diff --git a/drivers/gpu/drm/radeon/radeon_trace.h b/drivers/gpu/drm/radeon/radeon_trace.h
index c93f3ab3c4e3..4324f3fc5d82 100644
--- a/drivers/gpu/drm/radeon/radeon_trace.h
+++ b/drivers/gpu/drm/radeon/radeon_trace.h
@@ -73,7 +73,7 @@ TRACE_EVENT(radeon_vm_bo_update,
 
 	    TP_fast_assign(
 			   __entry->soffset = bo_va->it.start;
-			   __entry->eoffset = bo_va->it.last + 1;
+			   __entry->eoffset = bo_va->it.end;
 			   __entry->flags = bo_va->flags;
 			   ),
 	    TP_printk("soffs=%010llx, eoffs=%010llx, flags=%08x",
diff --git a/drivers/gpu/drm/radeon/radeon_vm.c b/drivers/gpu/drm/radeon/radeon_vm.c
index e0ad547786e8..b2a54aff21f4 100644
--- a/drivers/gpu/drm/radeon/radeon_vm.c
+++ b/drivers/gpu/drm/radeon/radeon_vm.c
@@ -329,7 +329,7 @@ struct radeon_bo_va *radeon_vm_bo_add(struct radeon_device *rdev,
 	bo_va->vm = vm;
 	bo_va->bo = bo;
 	bo_va->it.start = 0;
-	bo_va->it.last = 0;
+	bo_va->it.end = 0;
 	bo_va->flags = 0;
 	bo_va->ref_count = 1;
 	INIT_LIST_HEAD(&bo_va->bo_list);
@@ -456,7 +456,7 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
 
 	if (soffset) {
 		/* make sure object fit at this offset */
-		eoffset = soffset + size - 1;
+		eoffset = soffset + size;
 		if (soffset >= eoffset) {
 			r = -EINVAL;
 			goto error_unreserve;
@@ -486,14 +486,14 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
 			/* bo and tmp overlap, invalid offset */
 			dev_err(rdev->dev, "bo %p va 0x%010Lx conflict with "
 				"(bo %p 0x%010lx 0x%010lx)\n", bo_va->bo,
-				soffset, tmp->bo, tmp->it.start, tmp->it.last);
+				soffset, tmp->bo, tmp->it.start, tmp->it.end);
 			mutex_unlock(&vm->mutex);
 			r = -EINVAL;
 			goto error_unreserve;
 		}
 	}
 
-	if (bo_va->it.start || bo_va->it.last) {
+	if (bo_va->it.start || bo_va->it.end) {
 		/* add a clone of the bo_va to clear the old address */
 		struct radeon_bo_va *tmp;
 		tmp = kzalloc(sizeof(struct radeon_bo_va), GFP_KERNEL);
@@ -503,14 +503,14 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
 			goto error_unreserve;
 		}
 		tmp->it.start = bo_va->it.start;
-		tmp->it.last = bo_va->it.last;
+		tmp->it.end = bo_va->it.end;
 		tmp->vm = vm;
 		tmp->bo = radeon_bo_ref(bo_va->bo);
 
 		interval_tree_remove(&bo_va->it, &vm->va);
 		spin_lock(&vm->status_lock);
 		bo_va->it.start = 0;
-		bo_va->it.last = 0;
+		bo_va->it.end = 0;
 		list_del_init(&bo_va->vm_status);
 		list_add(&tmp->vm_status, &vm->freed);
 		spin_unlock(&vm->status_lock);
@@ -519,7 +519,7 @@ int radeon_vm_bo_set_addr(struct radeon_device *rdev,
 	if (soffset || eoffset) {
 		spin_lock(&vm->status_lock);
 		bo_va->it.start = soffset;
-		bo_va->it.last = eoffset;
+		bo_va->it.end = eoffset;
 		list_add(&bo_va->vm_status, &vm->cleared);
 		spin_unlock(&vm->status_lock);
 		interval_tree_insert(&bo_va->it, &vm->va);
@@ -964,7 +964,7 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
 
 	trace_radeon_vm_bo_update(bo_va);
 
-	nptes = bo_va->it.last - bo_va->it.start + 1;
+	nptes = bo_va->it.end - bo_va->it.start;
 
 	/* reserve space for one command every (1 << BLOCK_SIZE) entries
 	   or 2k dwords (whatever is smaller) */
@@ -1010,7 +1010,7 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
 	}
 
 	r = radeon_vm_update_ptes(rdev, vm, &ib, bo_va->it.start,
-				  bo_va->it.last + 1, addr,
+				  bo_va->it.end, addr,
 				  radeon_vm_page_flags(bo_va->flags));
 	if (r) {
 		radeon_ib_free(rdev, &ib);
@@ -1026,7 +1026,7 @@ int radeon_vm_bo_update(struct radeon_device *rdev,
 		return r;
 	}
 	ib.fence->is_vm_update = true;
-	radeon_vm_fence_pts(vm, bo_va->it.start, bo_va->it.last + 1, ib.fence);
+	radeon_vm_fence_pts(vm, bo_va->it.start, bo_va->it.end, ib.fence);
 	radeon_fence_unref(&bo_va->last_pt_update);
 	bo_va->last_pt_update = radeon_fence_ref(ib.fence);
 	radeon_ib_free(rdev, &ib);
@@ -1124,12 +1124,12 @@ void radeon_vm_bo_rmv(struct radeon_device *rdev,
 	list_del(&bo_va->bo_list);
 
 	mutex_lock(&vm->mutex);
-	if (bo_va->it.start || bo_va->it.last)
+	if (bo_va->it.start || bo_va->it.end)
 		interval_tree_remove(&bo_va->it, &vm->va);
 
 	spin_lock(&vm->status_lock);
 	list_del(&bo_va->vm_status);
-	if (bo_va->it.start || bo_va->it.last) {
+	if (bo_va->it.start || bo_va->it.end) {
 		bo_va->bo = radeon_bo_ref(bo_va->bo);
 		list_add(&bo_va->vm_status, &vm->freed);
 	} else {
@@ -1158,7 +1158,7 @@ void radeon_vm_bo_invalidate(struct radeon_device *rdev,
 	list_for_each_entry(bo_va, &bo->va, bo_list) {
 		spin_lock(&bo_va->vm->status_lock);
 		if (list_empty(&bo_va->vm_status) &&
-		    (bo_va->it.start || bo_va->it.last))
+		    (bo_va->it.start || bo_va->it.end))
 			list_add(&bo_va->vm_status, &bo_va->vm->invalidated);
 		spin_unlock(&bo_va->vm->status_lock);
 	}
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index f67a30fda1ed..9b7ac93223d6 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -219,26 +219,19 @@ static inline int ib_init_umem_odp(struct ib_umem_odp *umem_odp)
 			ALIGN_DOWN(umem_odp->umem.address, page_size);
 		if (check_add_overflow(umem_odp->umem.address,
 				       (unsigned long)umem_odp->umem.length,
-				       &umem_odp->interval_tree.last))
+				       &umem_odp->interval_tree.end))
 			return -EOVERFLOW;
-		umem_odp->interval_tree.last =
-			ALIGN(umem_odp->interval_tree.last, page_size);
-		if (unlikely(umem_odp->interval_tree.last < page_size))
+		umem_odp->interval_tree.end =
+			ALIGN(umem_odp->interval_tree.end, page_size);
+		if (unlikely(umem_odp->interval_tree.end < page_size))
 			return -EOVERFLOW;
 
-		pages = (umem_odp->interval_tree.last -
+		pages = (umem_odp->interval_tree.end -
 			 umem_odp->interval_tree.start) >>
 			umem_odp->page_shift;
 		if (!pages)
 			return -EINVAL;
 
-		/*
-		 * Note that the representation of the intervals in the
-		 * interval tree considers the ending point as contained in
-		 * the interval.
-		 */
-		umem_odp->interval_tree.last--;
-
 		umem_odp->page_list = kvcalloc(
 			pages, sizeof(*umem_odp->page_list), GFP_KERNEL);
 		if (!umem_odp->page_list)
@@ -777,12 +770,12 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 	if (unlikely(start == last))
 		return ret_val;
 
-	for (node = interval_tree_iter_first(root, start, last - 1);
+	for (node = interval_tree_iter_first(root, start, last);
 			node; node = next) {
 		/* TODO move the blockable decision up to the callback */
 		if (!blockable)
 			return -EAGAIN;
-		next = interval_tree_iter_next(node, start, last - 1);
+		next = interval_tree_iter_next(node, start, last);
 		umem = container_of(node, struct ib_umem_odp, interval_tree);
 		ret_val = cb(umem, start, last, cookie) || ret_val;
 	}
diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
index 3ea9d7682999..771740981f43 100644
--- a/drivers/iommu/virtio-iommu.c
+++ b/drivers/iommu/virtio-iommu.c
@@ -323,7 +323,7 @@ static int viommu_add_mapping(struct viommu_domain *vdomain, unsigned long iova,
 
 	mapping->paddr		= paddr;
 	mapping->iova.start	= iova;
-	mapping->iova.last	= iova + size - 1;
+	mapping->iova.end	= iova + size;
 	mapping->flags		= flags;
 
 	spin_lock_irqsave(&vdomain->mappings_lock, irqflags);
@@ -348,7 +348,7 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 {
 	size_t unmapped = 0;
 	unsigned long flags;
-	unsigned long last = iova + size - 1;
+	unsigned long last = iova + size;
 	struct viommu_mapping *mapping = NULL;
 	struct interval_tree_node *node, *next;
 
@@ -367,7 +367,7 @@ static size_t viommu_del_mappings(struct viommu_domain *vdomain,
 		 * Virtio-iommu doesn't allow UNMAP to split a mapping created
 		 * with a single MAP request, so remove the full mapping.
 		 */
-		unmapped += mapping->iova.last - mapping->iova.start + 1;
+		unmapped += mapping->iova.end - mapping->iova.start;
 
 		interval_tree_remove(node, &vdomain->mappings);
 		kfree(mapping);
diff --git a/include/linux/interval_tree.h b/include/linux/interval_tree.h
index 288c26f50732..f3d1ea9e4003 100644
--- a/include/linux/interval_tree.h
+++ b/include/linux/interval_tree.h
@@ -7,7 +7,7 @@
 struct interval_tree_node {
 	struct rb_node rb;
 	unsigned long start;	/* Start of interval */
-	unsigned long last;	/* Last location _in_ interval */
+	unsigned long end;	/* Last location _outside_ interval */
 	unsigned long __subtree_last;
 };
 
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 253df1a1fa54..d0ae7aa2139b 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -97,7 +97,7 @@ static inline unsigned long ib_umem_start(struct ib_umem_odp *umem_odp)
 /* Returns the address of the page after the last one of an ODP umem. */
 static inline unsigned long ib_umem_end(struct ib_umem_odp *umem_odp)
 {
-	return umem_odp->interval_tree.last + 1;
+	return umem_odp->interval_tree.end;
 }
 
 static inline size_t ib_umem_odp_num_pages(struct ib_umem_odp *umem_odp)
@@ -165,7 +165,7 @@ rbt_ib_umem_lookup(struct rb_root_cached *root, u64 addr, u64 length)
 {
 	struct interval_tree_node *node;
 
-	node = interval_tree_iter_first(root, addr, addr + length - 1);
+	node = interval_tree_iter_first(root, addr, addr + length);
 	if (!node)
 		return NULL;
 	return container_of(node, struct ib_umem_odp, interval_tree);
diff --git a/lib/interval_tree.c b/lib/interval_tree.c
index 593ce56ece50..336ec5113a28 100644
--- a/lib/interval_tree.c
+++ b/lib/interval_tree.c
@@ -1,15 +1,15 @@
 // SPDX-License-Identifier: GPL-2.0-only
 #include <linux/interval_tree.h>
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree_gen.h>
 #include <linux/compiler.h>
 #include <linux/export.h>
 
 #define START(node) ((node)->start)
-#define LAST(node)  ((node)->last)
+#define END(node)  ((node)->end)
 
 INTERVAL_TREE_DEFINE(struct interval_tree_node, rb,
 		     unsigned long, __subtree_last,
-		     START, LAST,, interval_tree)
+		     START, END,, interval_tree)
 
 EXPORT_SYMBOL_GPL(interval_tree_insert);
 EXPORT_SYMBOL_GPL(interval_tree_remove);
-- 
2.16.4

