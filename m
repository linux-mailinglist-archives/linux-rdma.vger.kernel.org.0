Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A9DD714B49
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbfEFNyD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:54:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:48135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726265AbfEFNyD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:54:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:54:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344291828"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.255.35.243])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 06:54:02 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, Shiraz Saleem <shiraz.saleem@intel.com>
Subject: [PATCH v3 rdma-next 3/6] RDMA/i40iw: Use core helpers to get aligned DMA address within a supported page size
Date:   Mon,  6 May 2019 08:53:34 -0500
Message-Id: <20190506135337.11324-4-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190506135337.11324-1-shiraz.saleem@intel.com>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Call the core helpers to retrieve the HW aligned address to use
for the MR, within a supported i40iw page size.

Remove code in i40iw to determine when MR is backed by 2M huge pages
which involves checking the umem->hugetlb flag and VMA inspection.
The new DMA iterator will return the 2M aligned address if the
MR is backed by 2M pages.

Fixes: f26c7c83395b ("i40iw: Add 2MB page support")
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/i40iw/i40iw_verbs.c | 46 +++++--------------------------
 drivers/infiniband/hw/i40iw/i40iw_verbs.h |  3 +-
 2 files changed, 8 insertions(+), 41 deletions(-)

diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.c b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
index 7bf7fe8..43579cd 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.c
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.c
@@ -1338,53 +1338,22 @@ static void i40iw_copy_user_pgaddrs(struct i40iw_mr *iwmr,
 	struct i40iw_pbl *iwpbl = &iwmr->iwpbl;
 	struct i40iw_pble_alloc *palloc = &iwpbl->pble_alloc;
 	struct i40iw_pble_info *pinfo;
-	struct sg_dma_page_iter sg_iter;
-	u64 pg_addr = 0;
+	struct ib_block_iter biter;
 	u32 idx = 0;
-	bool first_pg = true;
 
 	pinfo = (level == I40IW_LEVEL_1) ? NULL : palloc->level2.leaf;
 
 	if (iwmr->type == IW_MEMREG_TYPE_QP)
 		iwpbl->qp_mr.sq_page = sg_page(region->sg_head.sgl);
 
-	for_each_sg_dma_page (region->sg_head.sgl, &sg_iter, region->nmap, 0) {
-		pg_addr = sg_page_iter_dma_address(&sg_iter);
-		if (first_pg)
-			*pbl = cpu_to_le64(pg_addr & iwmr->page_msk);
-		else if (!(pg_addr & ~iwmr->page_msk))
-			*pbl = cpu_to_le64(pg_addr);
-		else
-			continue;
-
-		first_pg = false;
+	rdma_for_each_block(region->sg_head.sgl, &biter, region->nmap,
+			    iwmr->page_size) {
+		*pbl = rdma_block_iter_dma_address(&biter);
 		pbl = i40iw_next_pbl_addr(pbl, &pinfo, &idx);
 	}
 }
 
 /**
- * i40iw_set_hugetlb_params - set MR pg size and mask to huge pg values.
- * @addr: virtual address
- * @iwmr: mr pointer for this memory registration
- */
-static void i40iw_set_hugetlb_values(u64 addr, struct i40iw_mr *iwmr)
-{
-	struct vm_area_struct *vma;
-	struct hstate *h;
-
-	down_read(&current->mm->mmap_sem);
-	vma = find_vma(current->mm, addr);
-	if (vma && is_vm_hugetlb_page(vma)) {
-		h = hstate_vma(vma);
-		if (huge_page_size(h) == 0x200000) {
-			iwmr->page_size = huge_page_size(h);
-			iwmr->page_msk = huge_page_mask(h);
-		}
-	}
-	up_read(&current->mm->mmap_sem);
-}
-
-/**
  * i40iw_check_mem_contiguous - check if pbls stored in arr are contiguous
  * @arr: lvl1 pbl array
  * @npages: page count
@@ -1839,10 +1808,9 @@ static struct ib_mr *i40iw_reg_user_mr(struct ib_pd *pd,
 	iwmr->ibmr.device = pd->device;
 
 	iwmr->page_size = PAGE_SIZE;
-	iwmr->page_msk = PAGE_MASK;
-
-	if (region->hugetlb && (req.reg_type == IW_MEMREG_TYPE_MEM))
-		i40iw_set_hugetlb_values(start, iwmr);
+	if (req.reg_type == IW_MEMREG_TYPE_MEM)
+		iwmr->page_size = ib_umem_find_best_pgsz(region, SZ_4K | SZ_2M,
+							 virt);
 
 	region_length = region->length + (start & (iwmr->page_size - 1));
 	pg_shift = ffs(iwmr->page_size) - 1;
diff --git a/drivers/infiniband/hw/i40iw/i40iw_verbs.h b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
index 76cf173..3a41375 100644
--- a/drivers/infiniband/hw/i40iw/i40iw_verbs.h
+++ b/drivers/infiniband/hw/i40iw/i40iw_verbs.h
@@ -94,8 +94,7 @@ struct i40iw_mr {
 	struct ib_umem *region;
 	u16 type;
 	u32 page_cnt;
-	u32 page_size;
-	u64 page_msk;
+	u64 page_size;
 	u32 npages;
 	u32 stag;
 	u64 length;
-- 
1.8.3.1

