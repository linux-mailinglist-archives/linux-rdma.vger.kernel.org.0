Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC402273D26
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Sep 2020 10:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbgIVIVT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Sep 2020 04:21:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:35918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726649AbgIVIVT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 22 Sep 2020 04:21:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45A9D239E5;
        Tue, 22 Sep 2020 08:21:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600762878;
        bh=Hoyo0Ab4EV6U54vTMpm5KZ8tFFl48CdNF0Ny2si7f1M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WTiA5BMuGaSPRGFKmpyBjpcNlgObaFGtgE4Jb382bNg1Yk3PqbU9wiNrKDT/mvD0u
         Q2VUXQxNETAeqtWSWhJpofcwAaf7ZOuIz8lilERFMQgP5VU2vG59Gurb6XgWy3+Ow1
         mU6j0/MBCEwIufcxprLSg0cIiRw1UfTnMAjw8WIo=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Yishai Hadas <yishaih@nvidia.com>, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH rdma-next v2 2/4] IB/core: Enable ODP sync without faulting
Date:   Tue, 22 Sep 2020 11:21:02 +0300
Message-Id: <20200922082104.2148873-3-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922082104.2148873-1-leon@kernel.org>
References: <20200922082104.2148873-1-leon@kernel.org>
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
index 3a9537c39d1a..7cf23a3ec02d 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -339,9 +339,10 @@ static int ib_umem_odp_map_dma_single_page(
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
@@ -377,10 +378,12 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,
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
@@ -409,12 +412,24 @@ int ib_umem_odp_map_dma_and_lock(struct ib_umem_odp *umem_odp, u64 user_virt,

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

