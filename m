Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6F3A14B4A
	for <lists+linux-rdma@lfdr.de>; Mon,  6 May 2019 15:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEFNyF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 May 2019 09:54:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:48135 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfEFNyE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 6 May 2019 09:54:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 May 2019 06:54:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,438,1549958400"; 
   d="scan'208";a="344291839"
Received: from ssaleem-mobl4.amr.corp.intel.com ([10.255.35.243])
  by fmsmga006.fm.intel.com with ESMTP; 06 May 2019 06:54:03 -0700
From:   Shiraz Saleem <shiraz.saleem@intel.com>
To:     dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>
Subject: [PATCH v3 rdma-next 4/6] RDMA/bnxt_re: Use core helpers to get aligned DMA address
Date:   Mon,  6 May 2019 08:53:35 -0500
Message-Id: <20190506135337.11324-5-shiraz.saleem@intel.com>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20190506135337.11324-1-shiraz.saleem@intel.com>
References: <20190506135337.11324-1-shiraz.saleem@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Call the core helpers to retrieve the HW aligned address to use
for the MR, within a supported bnxt_re page size.

Remove checking the umem->hugtetlb flag as it is no
longer required. The new DMA block iterator will return
the 2M aligned address if the MR is backed by 2M huge pages.

Cc: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: Devesh Sharma <devesh.sharma@broadcom.com>
Acked-by: Selvin Xavier <selvin.xavier@broadcom.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
---
 drivers/infiniband/hw/bnxt_re/ib_verbs.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
index 3fcc77c..311d541 100644
--- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
+++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
@@ -3501,17 +3501,12 @@ static int fill_umem_pbl_tbl(struct ib_umem *umem, u64 *pbl_tbl_orig,
 			     int page_shift)
 {
 	u64 *pbl_tbl = pbl_tbl_orig;
-	u64 paddr;
-	u64 page_mask = (1ULL << page_shift) - 1;
-	struct sg_dma_page_iter sg_iter;
+	u64 page_size =  BIT_ULL(page_shift);
+	struct ib_block_iter biter;
+
+	rdma_for_each_block(umem->sg_head.sgl, &biter, umem->nmap, page_size)
+		*pbl_tbl++ = rdma_block_iter_dma_address(&biter);
 
-	for_each_sg_dma_page (umem->sg_head.sgl, &sg_iter, umem->nmap, 0) {
-		paddr = sg_page_iter_dma_address(&sg_iter);
-		if (pbl_tbl == pbl_tbl_orig)
-			*pbl_tbl++ = paddr & ~page_mask;
-		else if ((paddr & page_mask) == 0)
-			*pbl_tbl++ = paddr;
-	}
 	return pbl_tbl - pbl_tbl_orig;
 }
 
@@ -3573,7 +3568,9 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 		goto free_umem;
 	}
 
-	page_shift = PAGE_SHIFT;
+	page_shift = __ffs(ib_umem_find_best_pgsz(umem,
+				BNXT_RE_PAGE_SIZE_4K | BNXT_RE_PAGE_SIZE_2M,
+				virt_addr));
 
 	if (!bnxt_re_page_size_ok(page_shift)) {
 		dev_err(rdev_to_dev(rdev), "umem page size unsupported!");
@@ -3581,17 +3578,13 @@ struct ib_mr *bnxt_re_reg_user_mr(struct ib_pd *ib_pd, u64 start, u64 length,
 		goto fail;
 	}
 
-	if (!umem->hugetlb && length > BNXT_RE_MAX_MR_SIZE_LOW) {
+	if (page_shift == BNXT_RE_PAGE_SHIFT_4K &&
+	    length > BNXT_RE_MAX_MR_SIZE_LOW) {
 		dev_err(rdev_to_dev(rdev), "Requested MR Sz:%llu Max sup:%llu",
 			length,	(u64)BNXT_RE_MAX_MR_SIZE_LOW);
 		rc = -EINVAL;
 		goto fail;
 	}
-	if (umem->hugetlb && length > BNXT_RE_PAGE_SIZE_2M) {
-		page_shift = BNXT_RE_PAGE_SHIFT_2M;
-		dev_warn(rdev_to_dev(rdev), "umem hugetlb set page_size %x",
-			 1 << page_shift);
-	}
 
 	/* Map umem buf ptrs to the PBL */
 	umem_pgs = fill_umem_pbl_tbl(umem, pbl_tbl, page_shift);
-- 
1.8.3.1

