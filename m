Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 506A8921FB
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Aug 2019 13:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726987AbfHSLRZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 19 Aug 2019 07:17:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:32862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727424AbfHSLRY (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 19 Aug 2019 07:17:24 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C09F02085A;
        Mon, 19 Aug 2019 11:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566213443;
        bh=b8c1xVTNYiIFx4FiZOHIufuYm1euD+irHiEe8jx6U7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Goo0/l6FA2FFOaWfJPR+PfgL3lAZpW93d6o+vv3+fVdCSprRb6MsA0gviFKTHSDOV
         rz5a1rqTcXxnzJcRGyVLgijlbgagoNpA+FC8yU7tH7yGaB8dq2ymjVrN0GizDy6zEB
         OGDFZHXyIGBt7TTnNOyMD5OCwkLmiFwY1wecZXXc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-next 02/12] RDMA/odp: Iterate over the whole rbtree directly
Date:   Mon, 19 Aug 2019 14:17:00 +0300
Message-Id: <20190819111710.18440-3-leon@kernel.org>
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

Instead of intersecting a full interval, just iterate over every element
directly. This is faster and clearer.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/core/umem_odp.c | 51 ++++++++++++++++--------------
 drivers/infiniband/hw/mlx5/odp.c   | 41 +++++++++++-------------
 2 files changed, 47 insertions(+), 45 deletions(-)

diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index 8358eb8e3a26..b9bebef00a33 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -72,35 +72,41 @@ static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
 	mutex_unlock(&umem_odp->umem_mutex);
 }
 
-static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
-					       u64 start, u64 end, void *cookie)
-{
-	/*
-	 * Increase the number of notifiers running, to
-	 * prevent any further fault handling on this MR.
-	 */
-	ib_umem_notifier_start_account(umem_odp);
-	umem_odp->dying = 1;
-	/* Make sure that the fact the umem is dying is out before we release
-	 * all pending page faults. */
-	smp_wmb();
-	complete_all(&umem_odp->notifier_completion);
-	umem_odp->umem.context->invalidate_range(
-		umem_odp, ib_umem_start(umem_odp), ib_umem_end(umem_odp));
-	return 0;
-}
-
 static void ib_umem_notifier_release(struct mmu_notifier *mn,
 				     struct mm_struct *mm)
 {
 	struct ib_ucontext_per_mm *per_mm =
 		container_of(mn, struct ib_ucontext_per_mm, mn);
+	struct rb_node *node;
 
 	down_read(&per_mm->umem_rwsem);
-	if (per_mm->active)
-		rbt_ib_umem_for_each_in_range(
-			&per_mm->umem_tree, 0, ULLONG_MAX,
-			ib_umem_notifier_release_trampoline, true, NULL);
+	if (!per_mm->active)
+		goto out;
+
+	for (node = rb_first_cached(&per_mm->umem_tree); node;
+	     node = rb_next(node)) {
+		struct ib_umem_odp *umem_odp =
+			rb_entry(node, struct ib_umem_odp, interval_tree.rb);
+
+		/*
+		 * Increase the number of notifiers running, to prevent any
+		 * further fault handling on this MR.
+		 */
+		ib_umem_notifier_start_account(umem_odp);
+
+		umem_odp->dying = 1;
+		/*
+		 * Make sure that the fact the umem is dying is out before we
+		 * release all pending page faults.
+		 */
+		smp_wmb();
+		complete_all(&umem_odp->notifier_completion);
+		umem_odp->umem.context->invalidate_range(
+			umem_odp, ib_umem_start(umem_odp),
+			ib_umem_end(umem_odp));
+	}
+
+out:
 	up_read(&per_mm->umem_rwsem);
 }
 
@@ -760,4 +766,3 @@ int rbt_ib_umem_for_each_in_range(struct rb_root_cached *root,
 
 	return ret_val;
 }
-EXPORT_SYMBOL(rbt_ib_umem_for_each_in_range);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index b0c5de39d186..3922fced41ec 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -539,34 +539,31 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	return imr;
 }
 
-static int mr_leaf_free(struct ib_umem_odp *umem_odp, u64 start, u64 end,
-			void *cookie)
+void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 {
-	struct mlx5_ib_mr *mr = umem_odp->private, *imr = cookie;
-
-	if (mr->parent != imr)
-		return 0;
-
-	ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
-				    ib_umem_end(umem_odp));
+	struct ib_ucontext_per_mm *per_mm = mr_to_per_mm(imr);
+	struct rb_node *node;
 
-	if (umem_odp->dying)
-		return 0;
+	down_read(&per_mm->umem_rwsem);
+	for (node = rb_first_cached(&per_mm->umem_tree); node;
+	     node = rb_next(node)) {
+		struct ib_umem_odp *umem_odp =
+			rb_entry(node, struct ib_umem_odp, interval_tree.rb);
+		struct mlx5_ib_mr *mr = umem_odp->private;
 
-	WRITE_ONCE(umem_odp->dying, 1);
-	atomic_inc(&imr->num_leaf_free);
-	schedule_work(&umem_odp->work);
+		if (mr->parent != imr)
+			continue;
 
-	return 0;
-}
+		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
+					    ib_umem_end(umem_odp));
 
-void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
-{
-	struct ib_ucontext_per_mm *per_mm = mr_to_per_mm(imr);
+		if (umem_odp->dying)
+			continue;
 
-	down_read(&per_mm->umem_rwsem);
-	rbt_ib_umem_for_each_in_range(&per_mm->umem_tree, 0, ULLONG_MAX,
-				      mr_leaf_free, true, imr);
+		WRITE_ONCE(umem_odp->dying, 1);
+		atomic_inc(&imr->num_leaf_free);
+		schedule_work(&umem_odp->work);
+	}
 	up_read(&per_mm->umem_rwsem);
 
 	wait_event(imr->q_leaf_free, !atomic_read(&imr->num_leaf_free));
-- 
2.20.1

