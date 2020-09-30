Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB6027EF66
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Sep 2020 18:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731287AbgI3Qim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Sep 2020 12:38:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:39244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731286AbgI3Qim (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 30 Sep 2020 12:38:42 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 251682072E;
        Wed, 30 Sep 2020 16:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601483921;
        bh=POUvXOcL/XA/blTJDmucrTxZMh6DBVqj6e31uL0Awl8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyVXok5dJJHDPTJ762latzEIl0xPc0MkJhU4MyhBmILyMLquyCcPPPHkNgYsnfiFv
         gGGftvLLvwVnvn8/psKA1UUItthxgxArgGrHvHYzo30pplUEWn8QAffm4WijobARFY
         3ET4b1jAUU6IpYNo0lOAP2hVPxgEed6iebjQUsRA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v3 2/4] IB/core: Enable ODP sync without faulting
Date:   Wed, 30 Sep 2020 19:38:26 +0300
Message-Id: <20200930163828.1336747-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200930163828.1336747-1-leon@kernel.org>
References: <20200930163828.1336747-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Yishai Hadas <yishaih@nvidia.com>

Enable ODP sync without faulting, this improves performance by reducing
the number of page faults in the system.

The gain from this option is that the device page table can be aligned
with the presented pages in the CPU page table without causing page
faults.

As of that, the overhead on data path from hardware point of view to
trigger a fault which end-up by calling the driver to bring the pages
will be dropped.

Signed-off-by: Yishai Hadas <yishaih@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/core/umem_odp.c | 35 +++++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/odp.c   |  2 +-
 include/rdma/ib_umem_odp.h         |  2 +-
 3 files changed, 27 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index b7dc9ccb2cc9..23c2c009f80e 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -347,9 +347,10 @@ static int ib_umem_odp_map_dma_single_page(
  *        the return value.
  * @access_mask: bit mask of the requested access permissions for the given
  *               range.
+ * @fault: is faulting required for the given range
  */
 int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
-				 u64 bcnt, u64 access_mask)
+				 u64 bcnt, u64 access_mask, bool fault)
 			__acquires(&umem_odp->umem_mutex)
 {
 	struct task_struct *owning_process  = NULL;
@@ -385,10 +386,12 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
 	range.end = ALIGN(user_virt + bcnt, 1UL << page_shift);
 	pfn_start_idx = (range.start - ib_umem_start(umem_odp)) >> PAGE_SHIFT;
 	num_pfns = (range.end - range.start) >> PAGE_SHIFT;
-	range.default_flags = HMM_PFN_REQ_FAULT;
+	if (fault) {
+		range.default_flags = HMM_PFN_REQ_FAULT;

-	if (access_mask & ODP_WRITE_ALLOWED_BIT)
-		range.default_flags |= HMM_PFN_REQ_WRITE;
+		if (access_mask & ODP_WRITE_ALLOWED_BIT)
+			range.default_flags |= HMM_PFN_REQ_WRITE;
+	}

 	range.hmm_pfns = &(umem_odp->pfn_list[pfn_start_idx]);
 	timeout = jiffies + msecs_to_jiffies(HMM_RANGE_DEFAULT_TIMEOUT);
@@ -417,12 +420,24 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,

 	for (pfn_index = 0; pfn_index < num_pfns;
 		pfn_index += 1 << (page_shift - PAGE_SHIFT), dma_index++) {
-		/*
-		 * Since we asked for hmm_range_fault() to populate pages,
-		 * it shouldn't return an error entry on success.
-		 */
-		WARN_ON(range.hmm_pfns[pfn_index] & HMM_PFN_ERROR);
-		WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
+
+		if (fault) {
+			/*
+			 * Since we asked for hmm_range_fault() to populate
+			 * pages it shouldn't return an error entry on success.
+			 */
+			WARN_ON(range.hmm_pfns[pfn_index] & HMM_PFN_ERROR);
+			WARN_ON(!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID));
+		} else {
+			if (!(range.hmm_pfns[pfn_index] & HMM_PFN_VALID)) {
+				WARN_ON(umem_odp->dma_list[dma_index]);
+				continue;
+			}
+			access_mask = ODP_READ_ALLOWED_BIT;
+			if (range.hmm_pfns[pfn_index] & HMM_PFN_WRITE)
+				access_mask |= ODP_WRITE_ALLOWED_BIT;
+		}
+
 		hmm_order = hmm_pfn_to_map_order(range.hmm_pfns[pfn_index]);
 		/* If a hugepage was detected and ODP wasn't set for, the umem
 		 * page_shift will be used, the opposite case is an error.
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 0f203141a6ad..5bd5e19d76a2 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -681,7 +681,7 @@ static int pagefault_real_mr(struct mlx5_ib_mr *mr, struct ib_umem_odp *odp,
 	if (odp->umem.writable && !downgrade)
 		access_mask |= ODP_WRITE_ALLOWED_BIT;

-	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask);
+	np = ib_umem_odp_map_dma_and_lock(odp, user_va, bcnt, access_mask, true);
 	if (np < 0)
 		return np;

diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index a53b62ac8a9d..0844c1d05ac6 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -94,7 +94,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *root_umem, unsigned long addr,
 void ib_umem_odp_release(struct ib_umem_odp *umem_odp);

 int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 start_offset,
-				 u64 bcnt, u64 access_mask);
+				 u64 bcnt, u64 access_mask, bool fault);

 void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 start_offset,
 				 u64 bound);
--
2.26.2

