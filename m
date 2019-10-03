Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36BC6CB000
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 22:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388735AbfJCUUU (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 16:20:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:46484 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388527AbfJCUUT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 16:20:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 61908B071;
        Thu,  3 Oct 2019 20:20:16 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     akpm@linux-foundation.org
Cc:     walken@google.com, peterz@infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dri-devel@lists.freedesktop.org, linux-rdma@vger.kernel.org,
        dave@stgolabs.net, Jerome Glisse <jglisse@redhat.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 03/11] drm/amdgpu: convert amdgpu_vm_it to half closed intervals
Date:   Thu,  3 Oct 2019 13:18:50 -0700
Message-Id: <20191003201858.11666-4-dave@stgolabs.net>
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

The amdgpu_vm interval tree really wants [a, b) intervals,
not fully closed ones. As such convert it to use the new
interval_tree_gen.h, and also rename the 'last' endpoint
in the node to 'end', which is both a more suitable name
for the half closed interval and also reduces the chances
of missing a conversion when doing insertion or lookup.

Cc: Jerome Glisse <jglisse@redhat.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org
Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  | 18 ++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c    |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 46 +++++++++++++++---------------
 6 files changed, 36 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 49b767b7238f..290bfe820890 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -756,7 +756,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 			}
 
 			if ((va_start + chunk_ib->ib_bytes) >
-			    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
+			    m->end * AMDGPU_GPU_PAGE_SIZE) {
 				DRM_ERROR("IB va_start+ib_bytes is invalid\n");
 				return -EINVAL;
 			}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 7e99f6c58c48..60b73bc4d11a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -51,7 +51,7 @@ struct amdgpu_bo_va_mapping {
 	struct list_head		list;
 	struct rb_node			rb;
 	uint64_t			start;
-	uint64_t			last;
+	uint64_t			end;
 	uint64_t			__subtree_last;
 	uint64_t			offset;
 	uint64_t			flags;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 8227ebd0f511..c5b0e88d019c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -247,7 +247,7 @@ TRACE_EVENT(amdgpu_vm_bo_map,
 	    TP_STRUCT__entry(
 			     __field(struct amdgpu_bo *, bo)
 			     __field(long, start)
-			     __field(long, last)
+			     __field(long, end)
 			     __field(u64, offset)
 			     __field(u64, flags)
 			     ),
@@ -255,12 +255,12 @@ TRACE_EVENT(amdgpu_vm_bo_map,
 	    TP_fast_assign(
 			   __entry->bo = bo_va ? bo_va->base.bo : NULL;
 			   __entry->start = mapping->start;
-			   __entry->last = mapping->last;
+			   __entry->end = mapping->end;
 			   __entry->offset = mapping->offset;
 			   __entry->flags = mapping->flags;
 			   ),
-	    TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
-		      __entry->bo, __entry->start, __entry->last,
+	    TP_printk("bo=%p, start=%lx, end=%lx, offset=%010llx, flags=%llx",
+		      __entry->bo, __entry->start, __entry->end,
 		      __entry->offset, __entry->flags)
 );
 
@@ -271,7 +271,7 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,
 	    TP_STRUCT__entry(
 			     __field(struct amdgpu_bo *, bo)
 			     __field(long, start)
-			     __field(long, last)
+			     __field(long, end)
 			     __field(u64, offset)
 			     __field(u64, flags)
 			     ),
@@ -279,12 +279,12 @@ TRACE_EVENT(amdgpu_vm_bo_unmap,
 	    TP_fast_assign(
 			   __entry->bo = bo_va ? bo_va->base.bo : NULL;
 			   __entry->start = mapping->start;
-			   __entry->last = mapping->last;
+			   __entry->end = mapping->end;
 			   __entry->offset = mapping->offset;
 			   __entry->flags = mapping->flags;
 			   ),
-	    TP_printk("bo=%p, start=%lx, last=%lx, offset=%010llx, flags=%llx",
-		      __entry->bo, __entry->start, __entry->last,
+	    TP_printk("bo=%p, start=%lx, end=%lx, offset=%010llx, flags=%llx",
+		      __entry->bo, __entry->start, __entry->end,
 		      __entry->offset, __entry->flags)
 );
 
@@ -299,7 +299,7 @@ DECLARE_EVENT_CLASS(amdgpu_vm_mapping,
 
 	    TP_fast_assign(
 			   __entry->soffset = mapping->start;
-			   __entry->eoffset = mapping->last + 1;
+			   __entry->eoffset = mapping->end;
 			   __entry->flags = mapping->flags;
 			   ),
 	    TP_printk("soffs=%010llx, eoffs=%010llx, flags=%llx",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index b2c364b8695f..8094dd0b0332 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -819,7 +819,7 @@ static int amdgpu_uvd_cs_pass2(struct amdgpu_uvd_cs_ctx *ctx)
 
 	start = amdgpu_bo_gpu_offset(bo);
 
-	end = (mapping->last + 1 - mapping->start);
+	end = mapping->end - mapping->start;
 	end = end * AMDGPU_GPU_PAGE_SIZE + start;
 
 	addr -= mapping->start * AMDGPU_GPU_PAGE_SIZE;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b70b3c45bb29..d6511bf446df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -642,8 +642,7 @@ static int amdgpu_vce_cs_reloc(struct amdgpu_cs_parser *p, uint32_t ib_idx,
 		return r;
 	}
 
-	if ((addr + (uint64_t)size) >
-	    (mapping->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
+	if ((addr + (uint64_t)size) > mapping->end * AMDGPU_GPU_PAGE_SIZE) {
 		DRM_ERROR("BO to small for addr 0x%010Lx %d %d\n",
 			  addr, lo, hi);
 		return -EINVAL;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a2c797e34a29..2f618017617e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -26,7 +26,7 @@
  *          Jerome Glisse
  */
 #include <linux/dma-fence-array.h>
-#include <linux/interval_tree_generic.h>
+#include <linux/interval_tree_gen.h>
 #include <linux/idr.h>
 
 #include <drm/amdgpu_drm.h>
@@ -58,13 +58,13 @@
  */
 
 #define START(node) ((node)->start)
-#define LAST(node) ((node)->last)
+#define END(node) ((node)->end)
 
 INTERVAL_TREE_DEFINE(struct amdgpu_bo_va_mapping, rb, uint64_t, __subtree_last,
-		     START, LAST, static, amdgpu_vm_it)
+		     START, END, static, amdgpu_vm_it)
 
 #undef START
-#undef LAST
+#undef END
 
 /**
  * struct amdgpu_prt_cb - Helper to disable partial resident texture feature from a fence callback
@@ -1616,7 +1616,7 @@ static int amdgpu_vm_bo_split_mapping(struct amdgpu_device *adev,
 	do {
 		dma_addr_t *dma_addr = NULL;
 		uint64_t max_entries;
-		uint64_t addr, last;
+		uint64_t addr, end;
 
 		if (nodes) {
 			addr = nodes->start << PAGE_SHIFT;
@@ -1654,21 +1654,21 @@ static int amdgpu_vm_bo_split_mapping(struct amdgpu_device *adev,
 			addr += pfn << PAGE_SHIFT;
 		}
 
-		last = min((uint64_t)mapping->last, start + max_entries - 1);
+		end = min((uint64_t)mapping->end, start + max_entries);
 		r = amdgpu_vm_bo_update_mapping(adev, vm, false, exclusive,
-						start, last, flags, addr,
+						start, end, flags, addr,
 						dma_addr, fence);
 		if (r)
 			return r;
 
-		pfn += (last - start + 1) / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
+		pfn += (end - start) / AMDGPU_GPU_PAGES_IN_CPU_PAGE;
 		if (nodes && nodes->size == pfn) {
 			pfn = 0;
 			++nodes;
 		}
-		start = last + 1;
+		start = end;
 
-	} while (unlikely(start != mapping->last + 1));
+	} while (unlikely(start != mapping->end));
 
 	return 0;
 }
@@ -1946,7 +1946,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
 
 		r = amdgpu_vm_bo_update_mapping(adev, vm, false, NULL,
-						mapping->start, mapping->last,
+						mapping->start, mapping->end,
 						init_pte_value, 0, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
@@ -2129,7 +2129,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
+	eaddr = saddr + size;
 	if (saddr >= eaddr ||
 	    (bo && offset + size > amdgpu_bo_size(bo)))
 		return -EINVAL;
@@ -2142,7 +2142,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 		/* bo and tmp overlap, invalid addr */
 		dev_err(adev->dev, "bo %p va 0x%010Lx-0x%010Lx conflict with "
 			"0x%010Lx-0x%010Lx\n", bo, saddr, eaddr,
-			tmp->start, tmp->last + 1);
+			tmp->start, tmp->end);
 		return -EINVAL;
 	}
 
@@ -2151,7 +2151,7 @@ int amdgpu_vm_bo_map(struct amdgpu_device *adev,
 		return -ENOMEM;
 
 	mapping->start = saddr;
-	mapping->last = eaddr;
+	mapping->end = eaddr;
 	mapping->offset = offset;
 	mapping->flags = flags;
 
@@ -2194,7 +2194,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 		return -EINVAL;
 
 	/* make sure object fit at this offset */
-	eaddr = saddr + size - 1;
+	eaddr = saddr + size;
 	if (saddr >= eaddr ||
 	    (bo && offset + size > amdgpu_bo_size(bo)))
 		return -EINVAL;
@@ -2214,7 +2214,7 @@ int amdgpu_vm_bo_replace_map(struct amdgpu_device *adev,
 	eaddr /= AMDGPU_GPU_PAGE_SIZE;
 
 	mapping->start = saddr;
-	mapping->last = eaddr;
+	mapping->end = eaddr;
 	mapping->offset = offset;
 	mapping->flags = flags;
 
@@ -2299,7 +2299,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 	LIST_HEAD(removed);
 	uint64_t eaddr;
 
-	eaddr = saddr + size - 1;
+	eaddr = saddr + size;
 	saddr /= AMDGPU_GPU_PAGE_SIZE;
 	eaddr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -2322,7 +2322,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		/* Remember mapping split at the start */
 		if (tmp->start < saddr) {
 			before->start = tmp->start;
-			before->last = saddr - 1;
+			before->end = saddr;
 			before->offset = tmp->offset;
 			before->flags = tmp->flags;
 			before->bo_va = tmp->bo_va;
@@ -2330,9 +2330,9 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		}
 
 		/* Remember mapping split at the end */
-		if (tmp->last > eaddr) {
-			after->start = eaddr + 1;
-			after->last = tmp->last;
+		if (tmp->end > eaddr) {
+			after->start = eaddr;
+			after->end = tmp->end;
 			after->offset = tmp->offset;
 			after->offset += after->start - tmp->start;
 			after->flags = tmp->flags;
@@ -2353,8 +2353,8 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 
 		if (tmp->start < saddr)
 		    tmp->start = saddr;
-		if (tmp->last > eaddr)
-		    tmp->last = eaddr;
+		if (tmp->end > eaddr)
+		    tmp->end = eaddr;
 
 		tmp->bo_va = NULL;
 		list_add(&tmp->list, &vm->freed);
-- 
2.16.4

