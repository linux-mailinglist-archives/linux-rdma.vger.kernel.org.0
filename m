Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCD033A210C
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Jun 2021 01:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhFIXz3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Jun 2021 19:55:29 -0400
Received: from mga03.intel.com ([134.134.136.65]:9450 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFIXzZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 9 Jun 2021 19:55:25 -0400
IronPort-SDR: fnQCxuWoaJtPgWl7+YQxQQjJ4yysIpg+qkgF787eGVsSMXc8gkwctQt7ISGCyeNcKBkN6ZSgQ9
 oHm9Ao/VuJJQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10010"; a="205224957"
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="205224957"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 16:53:29 -0700
IronPort-SDR: Y7h1S7Gyn9+4+wlipC5Bvw/b4bIOw/TD/F2PXC42NhED0qR+C5RlkgGw8o4D9oyinuA9UmTmhe
 WPtL70xkEUuw==
X-IronPort-AV: E=Sophos;i="5.83,262,1616482800"; 
   d="scan'208";a="470040846"
Received: from ssaleem-mobl.amr.corp.intel.com ([10.212.27.57])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2021 16:53:29 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@nvidia.com
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH rdma-next] irdma: Store PBL info address a pointer type
Date:   Wed,  9 Jun 2021 18:49:24 -0500
Message-Id: <20210609234924.938-1-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

The level1 PBL info address is stored as u64.
This requires casting through a uinptr_t before used
as a pointer type.

And this leads to sparse warning such as this when
uinptr_t is missing:

drivers/infiniband/hw/irdma/hw.c: In function 'irdma_destroy_virt_aeq':
drivers/infiniband/hw/irdma/hw.c:579:23: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
  579 |  dma_addr_t *pg_arr = (dma_addr_t *)aeq->palloc.level1.addr;

This can be fixed using an intermediate uintptr_t, but
rather it is better to fix the structure irdm_pble_info
to store the address as u64* and the VA it is assigned in
irdma_chunk as a void*. This greatly reduces the casting on
this address.

Fixes: 44d9e52977a1 ("RDMA/irdma: Implement device initialization definitions")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/irdma/hw.c    |  2 +-
 drivers/infiniband/hw/irdma/pble.c  | 13 ++++++-------
 drivers/infiniband/hw/irdma/pble.h  |  6 +++---
 drivers/infiniband/hw/irdma/utils.c | 10 +++++-----
 drivers/infiniband/hw/irdma/verbs.c | 16 ++++++++--------
 5 files changed, 23 insertions(+), 24 deletions(-)

diff --git a/drivers/infiniband/hw/irdma/hw.c b/drivers/infiniband/hw/irdma/hw.c
index 518516b9a454..7afb8a6a0526 100644
--- a/drivers/infiniband/hw/irdma/hw.c
+++ b/drivers/infiniband/hw/irdma/hw.c
@@ -1314,7 +1314,7 @@ static enum irdma_status_code irdma_create_virt_aeq(struct irdma_pci_f *rf,
 		return status;
 	}
 
-	pg_arr = (dma_addr_t *)(uintptr_t)aeq->palloc.level1.addr;
+	pg_arr = (dma_addr_t *)aeq->palloc.level1.addr;
 	status = irdma_map_vm_page_list(&rf->hw, aeq->mem.va, pg_arr, pg_cnt);
 	if (status) {
 		irdma_free_pble(rf->pble_rsrc, &aeq->palloc);
diff --git a/drivers/infiniband/hw/irdma/pble.c b/drivers/infiniband/hw/irdma/pble.c
index 2eb9f56085ff..aeeb1c310965 100644
--- a/drivers/infiniband/hw/irdma/pble.c
+++ b/drivers/infiniband/hw/irdma/pble.c
@@ -110,10 +110,10 @@ add_sd_direct(struct irdma_hmc_pble_rsrc *pble_rsrc,
 
 	offset = idx->rel_pd_idx << HMC_PAGED_BP_SHIFT;
 	chunk->size = info->pages << HMC_PAGED_BP_SHIFT;
-	chunk->vaddr = (uintptr_t)sd_entry->u.bp.addr.va + offset;
+	chunk->vaddr = sd_entry->u.bp.addr.va + offset;
 	chunk->fpm_addr = pble_rsrc->next_fpm_addr;
 	ibdev_dbg(to_ibdev(dev),
-		  "PBLE: chunk_size[%lld] = 0x%llx vaddr=0x%llx fpm_addr = %llx\n",
+		  "PBLE: chunk_size[%lld] = 0x%llx vaddr=0x%pK fpm_addr = %llx\n",
 		  chunk->size, chunk->size, chunk->vaddr, chunk->fpm_addr);
 
 	return 0;
@@ -163,7 +163,7 @@ add_bp_pages(struct irdma_hmc_pble_rsrc *pble_rsrc,
 	if (status)
 		goto error;
 
-	addr = (u8 *)(uintptr_t)chunk->vaddr;
+	addr = chunk->vaddr;
 	for (i = 0; i < info->pages; i++) {
 		mem.pa = (u64)chunk->dmainfo.dmaaddrs[i];
 		mem.size = 4096;
@@ -375,7 +375,7 @@ get_lvl2_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 
 	root->idx = fpm_to_idx(pble_rsrc, fpm_addr);
 	root->cnt = total;
-	addr = (u64 *)(uintptr_t)root->addr;
+	addr = root->addr;
 	for (i = 0; i < total; i++, leaf++) {
 		pblcnt = (lflast && ((i + 1) == total)) ?
 				lflast : PBLE_PER_PAGE;
@@ -412,16 +412,15 @@ get_lvl1_pble(struct irdma_hmc_pble_rsrc *pble_rsrc,
 	      struct irdma_pble_alloc *palloc)
 {
 	enum irdma_status_code ret_code;
-	u64 fpm_addr, vaddr;
+	u64 fpm_addr;
 	struct irdma_pble_info *lvl1 = &palloc->level1;
 
 	ret_code = irdma_prm_get_pbles(&pble_rsrc->pinfo, &lvl1->chunkinfo,
-				       palloc->total_cnt << 3, &vaddr,
+				       palloc->total_cnt << 3, &lvl1->addr,
 				       &fpm_addr);
 	if (ret_code)
 		return IRDMA_ERR_NO_MEMORY;
 
-	lvl1->addr = vaddr;
 	palloc->level = PBLE_LEVEL_1;
 	lvl1->idx = fpm_to_idx(pble_rsrc, fpm_addr);
 	lvl1->cnt = palloc->total_cnt;
diff --git a/drivers/infiniband/hw/irdma/pble.h b/drivers/infiniband/hw/irdma/pble.h
index e4da6f53e6c2..e4e635dc4fd9 100644
--- a/drivers/infiniband/hw/irdma/pble.h
+++ b/drivers/infiniband/hw/irdma/pble.h
@@ -30,7 +30,7 @@ struct irdma_pble_chunkinfo {
 };
 
 struct irdma_pble_info {
-	u64 addr;
+	u64 *addr;
 	u32 idx;
 	u32 cnt;
 	struct irdma_pble_chunkinfo chunkinfo;
@@ -73,7 +73,7 @@ struct irdma_chunk {
 
 	u32 sizeofbitmap;
 	u64 size;
-	u64 vaddr;
+	void *vaddr;
 	u64 fpm_addr;
 	u32 pg_cnt;
 	enum irdma_alloc_type type;
@@ -122,7 +122,7 @@ enum irdma_status_code irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
 enum irdma_status_code
 irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
 		    struct irdma_pble_chunkinfo *chunkinfo, u32 mem_size,
-		    u64 *vaddr, u64 *fpm_addr);
+		    u64 **vaddr, u64 *fpm_addr);
 void irdma_prm_return_pbles(struct irdma_pble_prm *pprm,
 			    struct irdma_pble_chunkinfo *chunkinfo);
 void irdma_pble_acquire_lock(struct irdma_hmc_pble_rsrc *pble_rsrc,
diff --git a/drivers/infiniband/hw/irdma/utils.c b/drivers/infiniband/hw/irdma/utils.c
index 8f04347be52c..766bc43855da 100644
--- a/drivers/infiniband/hw/irdma/utils.c
+++ b/drivers/infiniband/hw/irdma/utils.c
@@ -2315,7 +2315,7 @@ enum irdma_status_code irdma_prm_add_pble_mem(struct irdma_pble_prm *pprm,
 enum irdma_status_code
 irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
 		    struct irdma_pble_chunkinfo *chunkinfo, u32 mem_size,
-		    u64 *vaddr, u64 *fpm_addr)
+		    u64 **vaddr, u64 *fpm_addr)
 {
 	u64 bits_needed;
 	u64 bit_idx = PBLE_INVALID_IDX;
@@ -2323,7 +2323,7 @@ irdma_prm_get_pbles(struct irdma_pble_prm *pprm,
 	struct list_head *chunk_entry = pprm->clist.next;
 	u32 offset;
 	unsigned long flags;
-	*vaddr = 0;
+	*vaddr = NULL;
 	*fpm_addr = 0;
 
 	bits_needed = (mem_size + (1 << pprm->pble_shift) - 1) >> pprm->pble_shift;
@@ -2429,8 +2429,8 @@ void irdma_pble_free_paged_mem(struct irdma_chunk *chunk)
 done:
 	kfree(chunk->dmainfo.dmaaddrs);
 	chunk->dmainfo.dmaaddrs = NULL;
-	vfree((void *)(uintptr_t)chunk->vaddr);
-	chunk->vaddr = 0;
+	vfree(chunk->vaddr);
+	chunk->vaddr = NULL;
 	chunk->type = 0;
 }
 
@@ -2459,7 +2459,7 @@ enum irdma_status_code irdma_pble_get_paged_mem(struct irdma_chunk *chunk,
 		vfree(va);
 		goto err;
 	}
-	chunk->vaddr = (uintptr_t)va;
+	chunk->vaddr = va;
 	chunk->size = size;
 	chunk->pg_cnt = pg_cnt;
 	chunk->type = PBLE_SD_PAGED;
diff --git a/drivers/infiniband/hw/irdma/verbs.c b/drivers/infiniband/hw/irdma/verbs.c
index f81371901517..4267661a8ef2 100644
--- a/drivers/infiniband/hw/irdma/verbs.c
+++ b/drivers/infiniband/hw/irdma/verbs.c
@@ -2214,7 +2214,7 @@ static inline u64 *irdma_next_pbl_addr(u64 *pbl, struct irdma_pble_info **pinfo,
 	*idx = 0;
 	(*pinfo)++;
 
-	return (u64 *)(uintptr_t)(*pinfo)->addr;
+	return (*pinfo)->addr;
 }
 
 /**
@@ -2282,16 +2282,16 @@ static bool irdma_check_mr_contiguous(struct irdma_pble_alloc *palloc,
 	bool ret;
 
 	if (palloc->level == PBLE_LEVEL_1) {
-		arr = (u64 *)(uintptr_t)palloc->level1.addr;
+		arr = palloc->level1.addr;
 		ret = irdma_check_mem_contiguous(arr, palloc->total_cnt,
 						 pg_size);
 		return ret;
 	}
 
-	start_addr = (u64 *)(uintptr_t)leaf->addr;
+	start_addr = leaf->addr;
 
 	for (i = 0; i < lvl2->leaf_cnt; i++, leaf++) {
-		arr = (u64 *)(uintptr_t)leaf->addr;
+		arr = leaf->addr;
 		if ((*start_addr + (i * pg_size * PBLE_PER_PAGE)) != *arr)
 			return false;
 		ret = irdma_check_mem_contiguous(arr, leaf->cnt, pg_size);
@@ -2328,7 +2328,7 @@ static int irdma_setup_pbles(struct irdma_pci_f *rf, struct irdma_mr *iwmr,
 		level = palloc->level;
 		pinfo = (level == PBLE_LEVEL_1) ? &palloc->level1 :
 						  palloc->level2.leaf;
-		pbl = (u64 *)(uintptr_t)pinfo->addr;
+		pbl = pinfo->addr;
 	} else {
 		pbl = iwmr->pgaddrmem;
 	}
@@ -2376,7 +2376,7 @@ static int irdma_handle_q_mem(struct irdma_device *iwdev,
 	}
 
 	if (use_pbles)
-		arr = (u64 *)(uintptr_t)palloc->level1.addr;
+		arr = palloc->level1.addr;
 
 	switch (iwmr->type) {
 	case IRDMA_MEMREG_TYPE_QP:
@@ -2643,7 +2643,7 @@ static int irdma_set_page(struct ib_mr *ibmr, u64 addr)
 	if (unlikely(iwmr->npages == iwmr->page_cnt))
 		return -ENOMEM;
 
-	pbl = (u64 *)(uintptr_t)palloc->level1.addr;
+	pbl = palloc->level1.addr;
 	pbl[iwmr->npages++] = addr;
 
 	return 0;
@@ -3223,7 +3223,7 @@ static int irdma_post_send(struct ib_qp *ibqp,
 			stag_info.addr_type = IRDMA_ADDR_TYPE_VA_BASED;
 			stag_info.va = (void *)(uintptr_t)iwmr->ibmr.iova;
 			stag_info.total_len = iwmr->ibmr.length;
-			stag_info.reg_addr_pa = *((u64 *)(uintptr_t)palloc->level1.addr);
+			stag_info.reg_addr_pa = *palloc->level1.addr;
 			stag_info.first_pm_pbl_index = palloc->level1.idx;
 			stag_info.local_fence = ib_wr->send_flags & IB_SEND_FENCE;
 			if (iwmr->npages > IRDMA_MIN_PAGES_PER_FMR)
-- 
2.31.0

