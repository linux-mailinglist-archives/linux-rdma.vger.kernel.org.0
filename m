Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C00C3921FC
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727440AbfHSLR2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:32950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSLR2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:28 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 462F820989;
        Mon, 19 Aug 2019 11:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213446;
        bh=s7XCQF49m1spU9F8AOsruKO635Q3VuajrwBpdfpRTnw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=igf9ynxsT4eFfQ0dlHe8lg82B1l0xcmEEKCVhatEftB0SNb3DHb4SazjefGvBmCCM
         uCU9dSXtLXHUHqFupr3MnDTFU+ybBxf39TuNqGhEtT4tMYm+jJISrVK8nqLeyvm4W+
         PW5KDTJYLH1GbJ6DoN2AisroURSPryHzdO8eC/3o=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 03/12] RDMA/odp: Make it clearer when a umem is an implicit ODP umem
Date:   Mon, 19 Aug 2019 14:17:01 +0300
Message-Id: <20190819111710.18440-4-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819111710.18440-1-leon@kernel.org>
References: <20190819111710.18440-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Implicit ODP umems are special, they don't have any page lists, they don't
exist in the interval tree and they are never DMA mapped.

Instead of trying to guess this based on a zero length use an explicit
flag.

Further, do not allow non-implicit umems to be 0 size.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 54 +++++++++++++++++-------------
 drivers/infiniband/hw/mlx5/mr.c    |  2 +-
 drivers/infiniband/hw/mlx5/odp.c   |  2 +-
 include/rdma/ib_umem_odp.h         |  8 +++++
 4 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index b9bebef00a33..2eb184a5374a 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -183,18 +183,15 @@ static void add_umem_to_per_mm(struct ib_umem_odp *umem_odp)
 	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
 
 	down_write(&per_mm->umem_rwsem);
-	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp))) {
-		/*
-		 * Note that the representation of the intervals in the
-		 * interval tree considers the ending point as contained in
-		 * the interval, while the function ib_umem_end returns the
-		 * first address which is not contained in the umem.
-		 */
-		umem_odp->interval_tree.start = ib_umem_start(umem_odp);
-		umem_odp->interval_tree.last = ib_umem_end(umem_odp) - 1;
-		interval_tree_insert(&umem_odp->interval_tree,
-				     &per_mm->umem_tree);
-	}
+	/*
+	 * Note that the representation of the intervals in the interval tree
+	 * considers the ending point as contained in the interval, while the
+	 * function ib_umem_end returns the first address which is not
+	 * contained in the umem.
+	 */
+	umem_odp->interval_tree.start = ib_umem_start(umem_odp);
+	umem_odp->interval_tree.last = ib_umem_end(umem_odp) - 1;
+	interval_tree_insert(&umem_odp->interval_tree, &per_mm->umem_tree);
 	up_write(&per_mm->umem_rwsem);
 }
 
@@ -203,11 +200,8 @@ static void remove_umem_from_per_mm(struct ib_umem_odp *umem_odp)
 	struct ib_ucontext_per_mm *per_mm = umem_odp->per_mm;
 
 	down_write(&per_mm->umem_rwsem);
-	if (likely(ib_umem_start(umem_odp) != ib_umem_end(umem_odp)))
-		interval_tree_remove(&umem_odp->interval_tree,
-				     &per_mm->umem_tree);
+	interval_tree_remove(&umem_odp->interval_tree, &per_mm->umem_tree);
 	complete_all(&umem_odp->notifier_completion);
-
 	up_write(&per_mm->umem_rwsem);
 }
 
@@ -327,6 +321,9 @@ struct ib_umem_odp *ib_alloc_odp_umem(struct ib_umem_odp *root,
 	int pages = size >> PAGE_SHIFT;
 	int ret;
 
+	if (!size)
+		return ERR_PTR(-EINVAL);
+
 	odp_data = kzalloc(sizeof(*odp_data), GFP_KERNEL);
 	if (!odp_data)
 		return ERR_PTR(-ENOMEM);
@@ -388,6 +385,9 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 	struct mm_struct *mm = umem->owning_mm;
 	int ret_val;
 
+	if (umem_odp->umem.address == 0 && umem_odp->umem.length == 0)
+		umem_odp->is_implicit_odp = 1;
+
 	umem_odp->page_shift = PAGE_SHIFT;
 	if (access & IB_ACCESS_HUGETLB) {
 		struct vm_area_struct *vma;
@@ -408,7 +408,10 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 
 	init_completion(&umem_odp->notifier_completion);
 
-	if (ib_umem_odp_num_pages(umem_odp)) {
+	if (!umem_odp->is_implicit_odp) {
+		if (!ib_umem_odp_num_pages(umem_odp))
+			return -EINVAL;
+
 		umem_odp->page_list =
 			vzalloc(array_size(sizeof(*umem_odp->page_list),
 					   ib_umem_odp_num_pages(umem_odp)));
@@ -427,7 +430,9 @@ int ib_umem_odp_get(struct ib_umem_odp *umem_odp, int access)
 	ret_val = get_per_mm(umem_odp);
 	if (ret_val)
 		goto out_dma_list;
-	add_umem_to_per_mm(umem_odp);
+
+	if (!umem_odp->is_implicit_odp)
+		add_umem_to_per_mm(umem_odp);
 
 	return 0;
 
@@ -446,13 +451,14 @@ void ib_umem_odp_release(struct ib_umem_odp *umem_odp)
 	 * It is the driver's responsibility to ensure, before calling us,
 	 * that the hardware will not attempt to access the MR any more.
 	 */
-	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
-				    ib_umem_end(umem_odp));
-
-	remove_umem_from_per_mm(umem_odp);
+	if (!umem_odp->is_implicit_odp) {
+		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
+					    ib_umem_end(umem_odp));
+		remove_umem_from_per_mm(umem_odp);
+		vfree(umem_odp->dma_list);
+		vfree(umem_odp->page_list);
+	}
 	put_per_mm(umem_odp);
-	vfree(umem_odp->dma_list);
-	vfree(umem_odp->page_list);
 }
 
 /*
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2c77456f359f..e0015b612ffd 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1609,7 +1609,7 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		/* Wait for all running page-fault handlers to finish. */
 		synchronize_srcu(&dev->mr_srcu);
 		/* Destroy all page mappings */
-		if (umem_odp->page_list)
+		if (!umem_odp->is_implicit_odp)
 			mlx5_ib_invalidate_range(umem_odp,
 						 ib_umem_start(umem_odp),
 						 ib_umem_end(umem_odp));
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3922fced41ec..5b6b2afa26a6 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -585,7 +585,7 @@ static int pagefault_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 	struct ib_umem_odp *odp;
 	size_t size;
 
-	if (!odp_mr->page_list) {
+	if (odp_mr->is_implicit_odp) {
 		odp = implicit_mr_get_data(mr, io_virt, bcnt);
 
 		if (IS_ERR(odp))
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 030d5cbad02c..14b38b4459c5 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -69,6 +69,14 @@ struct ib_umem_odp {
 	/* Tree tracking */
 	struct interval_tree_node interval_tree;
 
+	/*
+	 * An implicit odp umem cannot be DMA mapped, has 0 length, and serves
+	 * only as an anchor for the driver to hold onto the per_mm. FIXME:
+	 * This should be removed and drivers should work with the per_mm
+	 * directly.
+	 */
+	bool is_implicit_odp;
+
 	struct completion	notifier_completion;
 	int			dying;
 	unsigned int		page_shift;
-- 
2.20.1

