Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6740A171628
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 12:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgB0Ljd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 06:39:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:48946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgB0Ljd (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 06:39:33 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3F33024690;
        Thu, 27 Feb 2020 11:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582803572;
        bh=dsjaN6IEpMcr29Kc5SO3t+9YLNz9Fq1loVXo9eO4oi8=;
        h=From:To:Cc:Subject:Date:From;
        b=L9jvqObYiJxSCOeGUw8598LiU58UuaKaa+0T5ONN7zk93fW1I2G/YDuIG6KKyWNBK
         027MP8laSeIdBPpA16zbdbEhvN0SYsPVqpgjCiUvesXHgksqUtAhQCx1FOtyq+ZL+S
         1RPn0T62mCc0XU/C10x80V/yNnJBplBa/wE2BWn4=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Artemy Kovalyov <artemyko@mellanox.com>, linux-rdma@vger.kernel.org
Subject: [PATCH rdma-rc] IB/mlx5: Fix implicit ODP race
Date:   Thu, 27 Feb 2020 13:39:18 +0200
Message-Id: <20200227113918.94432-1-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Artemy Kovalyov <artemyko@mellanox.com>

Following race may occur because of the call_srcu and the placement of
the synchronize_srcu vs the xa_erase.

CPU0				   CPU1

mlx5_ib_free_implicit_mr:	   destroy_unused_implicit_child_mr:
 xa_erase(odp_mkeys)
 synchronize_srcu()
				    xa_lock(implicit_children)
				    if (still in xarray)
				       atomic_inc()
				       call_srcu()
				    xa_unlock(implicit_children)
 xa_erase(implicit_children):
   xa_lock(implicit_children)
   __xa_erase()
   xa_unlock(implicit_children)

 flush_workqueue()
				   [..]
				    free_implicit_child_mr_rcu:
				     (via call_srcu)
				      queue_work()

 WARN_ON(atomic_read())
				   [..]
				    free_implicit_child_mr_work:
				     (via wq)
				      free_implicit_child_mr()
 mlx5_mr_cache_invalidate()
				     mlx5_ib_update_xlt() <-- UMR QP fail
				     atomic_dec()

The wait_event() solves the race because it blocks until
free_implicit_child_mr_work() completes.

Fixes: 5256edcb98a1 ("RDMA/mlx5: Rework implicit ODP destroy")
Signed-off-by: Artemy Kovalyov <artemyko@mellanox.com>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/odp.c     | 17 +++++++----------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index f21d446249b8..688dd4e28192 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -636,6 +636,7 @@ struct mlx5_ib_mr {
 
 	/* For ODP and implicit */
 	atomic_t		num_deferred_work;
+	wait_queue_head_t       q_deferred_work;
 	struct xarray		implicit_children;
 	union {
 		struct rcu_head rcu;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4216814ba871..bf50cd91f472 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -235,7 +235,8 @@ static void free_implicit_child_mr(struct mlx5_ib_mr *mr, bool need_imr_xlt)
 	mr->parent = NULL;
 	mlx5_mr_cache_free(mr->dev, mr);
 	ib_umem_odp_release(odp);
-	atomic_dec(&imr->num_deferred_work);
+	if (atomic_dec_and_test(&imr->num_deferred_work))
+		wake_up(&imr->q_deferred_work);
 }
 
 static void free_implicit_child_mr_work(struct work_struct *work)
@@ -554,6 +555,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	imr->umem = &umem_odp->umem;
 	imr->is_odp_implicit = true;
 	atomic_set(&imr->num_deferred_work, 0);
+	init_waitqueue_head(&imr->q_deferred_work);
 	xa_init(&imr->implicit_children);
 
 	err = mlx5_ib_update_xlt(imr, 0,
@@ -611,10 +613,7 @@ void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 	 * under xa_lock while the child is in the xarray. Thus at this point
 	 * it is only decreasing, and all work holding it is now on the wq.
 	 */
-	if (atomic_read(&imr->num_deferred_work)) {
-		flush_workqueue(system_unbound_wq);
-		WARN_ON(atomic_read(&imr->num_deferred_work));
-	}
+	wait_event(imr->q_deferred_work, !atomic_read(&imr->num_deferred_work));
 
 	/*
 	 * Fence the imr before we destroy the children. This allows us to
@@ -645,10 +644,7 @@ void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)
 	/* Wait for all running page-fault handlers to finish. */
 	synchronize_srcu(&mr->dev->odp_srcu);
 
-	if (atomic_read(&mr->num_deferred_work)) {
-		flush_workqueue(system_unbound_wq);
-		WARN_ON(atomic_read(&mr->num_deferred_work));
-	}
+	wait_event(mr->q_deferred_work, !atomic_read(&mr->num_deferred_work));
 
 	dma_fence_odp_mr(mr);
 }
@@ -1720,7 +1716,8 @@ static void destroy_prefetch_work(struct prefetch_mr_work *work)
 	u32 i;
 
 	for (i = 0; i < work->num_sge; ++i)
-		atomic_dec(&work->frags[i].mr->num_deferred_work);
+		if (atomic_dec_and_test(&work->frags[i].mr->num_deferred_work))
+			wake_up(&work->frags[i].mr->q_deferred_work);
 	kvfree(work);
 }
 
-- 
2.24.1

