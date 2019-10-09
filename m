Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF9BD1429
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Oct 2019 18:36:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfJIQgR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Oct 2019 12:36:17 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34305 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730546AbfJIQgQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Oct 2019 12:36:16 -0400
Received: by mail-qt1-f196.google.com with SMTP id 3so4356495qta.1
        for <linux-rdma@vger.kernel.org>; Wed, 09 Oct 2019 09:36:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qmwmHKT7cS9Xj2LSeCAi3ZoIRdL1wIOv63AIqmNtaE0=;
        b=U/boH6Zz/1SI/keM0hslaUwgvzBmcasjlM6LfAIa+XRHoXYfnC3rHnKksnxNnUof/l
         U2MlKMG1v8lNi5/HHSexifYoJIEFzaqHq7pGnryjErFYbqHuXFXEsGxjKoDezY4J/de+
         EJ5A1pkY6E/zNBa9GPz5Vw9xHmvaT4pfIkpF03xQ7l7VO7tHdfM+uxz6bqURShl+F3ya
         WRxc6ZvFa5tAJEJRwjeecE83GDrgTp1TWXJIyuJgmCpv2m4m/OXVfgF2Ia/+o0UVyrla
         LewNzAFsaYyjzd81cq/utWMa6RsDA8+zpTKe6IMm8934jAR//POAySdyfq22f8sdYtJp
         3hNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qmwmHKT7cS9Xj2LSeCAi3ZoIRdL1wIOv63AIqmNtaE0=;
        b=qC01TiC+oaz5sgDsUSZb7UkA1M+qQ93I6v722ISL6/yhftXnPC8V3CNZauQ20TlaDC
         edY5Op73f1KgHb0j6kIO369awX29mZEaZgezk073DHZkNJlRwICCjcarOqHiMhGhJK3P
         qrXU2/AKbl/TvZ+TB3u4l4/C8L1lmleNQnB62ihQKTckI8eEXy1aY5rto4PtrgoaEaF/
         FrTfqVr2RhtDYrgeUHVI9avbjefi1DdRYJykSQ1uloG0BWSAGlNt6/W+pCvbm+g9BmqB
         6QvpwAbZzZWILZvdmic6pVzWjAFKhmGaHavhw0is67Wm7OZWroZ/eN3fRbOHJBe49cth
         nXOw==
X-Gm-Message-State: APjAAAXrtBm5flwohGfFVfdOhtOXktFqGhmvbX8ARNcjd3KH8zwEYyxW
        RXr0r2OQbAF2SjxVqyAa5bLWDrhDkFA=
X-Google-Smtp-Source: APXvYqxvJuLl5cTH39Ag6z+StdfA+NmnsWT1f8d8rDMf/2rgGUwtZVrrV7jbz1S0/qrPsNsvCr287A==
X-Received: by 2002:ac8:3917:: with SMTP id s23mr4708815qtb.23.1570638974619;
        Wed, 09 Oct 2019 09:36:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t17sm1902586qtt.57.2019.10.09.09.36.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 09 Oct 2019 09:36:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iIEXN-0000rM-87; Wed, 09 Oct 2019 13:10:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     linux-rdma@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: [PATCH 12/15] RDMA/mlx5: Rework implicit ODP destroy
Date:   Wed,  9 Oct 2019 13:09:32 -0300
Message-Id: <20191009160934.3143-13-jgg@ziepe.ca>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191009160934.3143-1-jgg@ziepe.ca>
References: <20191009160934.3143-1-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

Use SRCU in a sensible way by removing all MRs in the implicit tree from
the two xarrays (the update operation), then a synchronize, followed by a
normal single threaded teardown.

This is only a little unusual from the normal pattern as there can still
be some work pending in the unbound wq that may also require a workqueue
flush. This is tracked with a single atomic, consolidating the redundant
existing atomics and wait queue.

For understand-ability the entire ODP implicit create/destroy flow now
largely exists in a single pair of functions within odp.c, with a few
support functions for tearing down an unused child.

Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    |   2 -
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   9 +-
 drivers/infiniband/hw/mlx5/mr.c      |  21 ++--
 drivers/infiniband/hw/mlx5/odp.c     | 152 ++++++++++++++++++---------
 include/rdma/ib_umem_odp.h           |   2 -
 5 files changed, 120 insertions(+), 66 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4692c37b057cee..add24b6289004a 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6146,8 +6146,6 @@ static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 {
 	mlx5_ib_cleanup_multiport_master(dev);
 	WARN_ON(!xa_empty(&dev->odp_mkeys));
-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
-		srcu_barrier(&dev->odp_srcu);
 	cleanup_srcu_struct(&dev->odp_srcu);
 
 	WARN_ON(!xa_empty(&dev->sig_mrs));
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 88769fcffb5a10..b8c958f6262848 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -618,10 +618,13 @@ struct mlx5_ib_mr {
 	u64			pi_iova;
 
 	/* For ODP and implicit */
-	atomic_t		num_leaf_free;
-	wait_queue_head_t       q_leaf_free;
-	atomic_t		num_pending_prefetch;
+	atomic_t		num_deferred_work;
 	struct xarray		implicit_children;
+	union {
+		struct rcu_head rcu;
+		struct list_head elm;
+		struct work_struct work;
+	} odp_destroy;
 
 	struct mlx5_async_work  cb_work;
 };
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index fd94838a8845d5..1e91f61efa8a3e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -1317,7 +1317,7 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
 
 	if (is_odp_mr(mr)) {
 		to_ib_umem_odp(mr->umem)->private = mr;
-		atomic_set(&mr->num_pending_prefetch, 0);
+		atomic_set(&mr->num_deferred_work, 0);
 		err = xa_err(xa_store(&dev->odp_mkeys,
 				      mlx5_base_mkey(mr->mmkey.key), &mr->mmkey,
 				      GFP_KERNEL));
@@ -1573,17 +1573,15 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		synchronize_srcu(&dev->odp_srcu);
 
 		/* dequeue pending prefetch requests for the mr */
-		if (atomic_read(&mr->num_pending_prefetch))
+		if (atomic_read(&mr->num_deferred_work)) {
 			flush_workqueue(system_unbound_wq);
-		WARN_ON(atomic_read(&mr->num_pending_prefetch));
+			WARN_ON(atomic_read(&mr->num_deferred_work));
+		}
 
 		/* Destroy all page mappings */
-		if (!umem_odp->is_implicit_odp)
-			mlx5_ib_invalidate_range(umem_odp,
-						 ib_umem_start(umem_odp),
-						 ib_umem_end(umem_odp));
-		else
-			mlx5_ib_free_implicit_mr(mr);
+		mlx5_ib_invalidate_range(umem_odp, ib_umem_start(umem_odp),
+					 ib_umem_end(umem_odp));
+
 		/*
 		 * We kill the umem before the MR for ODP,
 		 * so that there will not be any invalidations in
@@ -1620,6 +1618,11 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		dereg_mr(to_mdev(mmr->klm_mr->ibmr.device), mmr->klm_mr);
 	}
 
+	if (is_odp_mr(mmr) && to_ib_umem_odp(mmr->umem)->is_implicit_odp) {
+		mlx5_ib_free_implicit_mr(mmr);
+		return 0;
+	}
+
 	dereg_mr(to_mdev(ibmr->device), mmr);
 
 	return 0;
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 1897ce6a25f693..71f8580b25b2ab 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -144,31 +144,79 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t idx, size_t nentries,
 	}
 }
 
-static void mr_leaf_free_action(struct work_struct *work)
+/*
+ * This must be called after the mr has been removed from implicit_children
+ * and odp_mkeys and the SRCU synchronized.  NOTE: The MR does not necessarily
+ * have to be empty here, parallel page faults could have raced with the free
+ * process and added pages to it.
+ */
+static void free_implicit_child_mr(struct mlx5_ib_mr *mr, bool need_imr_xlt)
 {
-	struct ib_umem_odp *odp = container_of(work, struct ib_umem_odp, work);
-	int idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
-	struct mlx5_ib_mr *mr = odp->private, *imr = mr->parent;
+	struct mlx5_ib_mr *imr = mr->parent;
 	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
+	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
 	int srcu_key;
 
-	mr->parent = NULL;
-	synchronize_srcu(&mr->dev->odp_srcu);
+	/* implicit_child_mr's are not allowed to have deferred work */
+	WARN_ON(atomic_read(&mr->num_deferred_work));
 
-	if (xa_load(&mr->dev->odp_mkeys, mlx5_base_mkey(imr->mmkey.key))) {
+	if (need_imr_xlt) {
 		srcu_key = srcu_read_lock(&mr->dev->odp_srcu);
 		mutex_lock(&odp_imr->umem_mutex);
-		mlx5_ib_update_xlt(imr, idx, 1, 0,
+		mlx5_ib_update_xlt(mr->parent, idx, 1, 0,
 				   MLX5_IB_UPD_XLT_INDIRECT |
 				   MLX5_IB_UPD_XLT_ATOMIC);
 		mutex_unlock(&odp_imr->umem_mutex);
 		srcu_read_unlock(&mr->dev->odp_srcu, srcu_key);
 	}
-	ib_umem_odp_release(odp);
+
+	mr->parent = NULL;
 	mlx5_mr_cache_free(mr->dev, mr);
+	ib_umem_odp_release(odp);
+	atomic_dec(&imr->num_deferred_work);
+}
+
+static void free_implicit_child_mr_work(struct work_struct *work)
+{
+	struct mlx5_ib_mr *mr =
+		container_of(work, struct mlx5_ib_mr, odp_destroy.work);
+
+	free_implicit_child_mr(mr, true);
+}
+
+static void free_implicit_child_mr_rcu(struct rcu_head *head)
+{
+	struct mlx5_ib_mr *mr =
+		container_of(head, struct mlx5_ib_mr, odp_destroy.rcu);
+
+	/* Freeing a MR is a sleeping operation, so bounce to a work queue */
+	INIT_WORK(&mr->odp_destroy.work, free_implicit_child_mr_work);
+	queue_work(system_unbound_wq, &mr->odp_destroy.work);
+}
+
+static void destroy_unused_implicit_child_mr(struct mlx5_ib_mr *mr)
+{
+	struct ib_umem_odp *odp = to_ib_umem_odp(mr->umem);
+	unsigned long idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
+	struct mlx5_ib_mr *imr = mr->parent;
 
-	if (atomic_dec_and_test(&imr->num_leaf_free))
-		wake_up(&imr->q_leaf_free);
+	xa_lock(&imr->implicit_children);
+	/*
+	 * This can race with mlx5_ib_free_implicit_mr(), the first one to
+	 * reach the xa lock wins the race and destroys the MR.
+	 */
+	if (__xa_cmpxchg(&imr->implicit_children, idx, mr, NULL, GFP_ATOMIC) !=
+	    mr)
+		goto out_unlock;
+
+	__xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
+	atomic_inc(&imr->num_deferred_work);
+	call_srcu(&mr->dev->odp_srcu, &mr->odp_destroy.rcu,
+		  free_implicit_child_mr_rcu);
+
+out_unlock:
+	xa_unlock(&imr->implicit_children);
 }
 
 void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
@@ -240,15 +288,8 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
 
 	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
 
-	if (unlikely(!umem_odp->npages && mr->parent &&
-		     !umem_odp->dying)) {
-		xa_erase(&mr->parent->implicit_children,
-			 ib_umem_start(umem_odp) >> MLX5_IMR_MTT_SHIFT);
-		xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
-		umem_odp->dying = 1;
-		atomic_inc(&mr->parent->num_leaf_free);
-		schedule_work(&umem_odp->work);
-	}
+	if (unlikely(!umem_odp->npages && mr->parent))
+		destroy_unused_implicit_child_mr(mr);
 	mutex_unlock(&umem_odp->umem_mutex);
 }
 
@@ -375,7 +416,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	mr->mmkey.iova = idx * MLX5_IMR_MTT_SIZE;
 	mr->parent = imr;
 	odp->private = mr;
-	INIT_WORK(&odp->work, mr_leaf_free_action);
 
 	err = mlx5_ib_update_xlt(mr, 0,
 				 MLX5_IMR_MTT_ENTRIES,
@@ -391,7 +431,11 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	 * Once the store to either xarray completes any error unwind has to
 	 * use synchronize_srcu(). Avoid this with xa_reserve()
 	 */
-	ret = xa_cmpxchg(&imr->implicit_children, idx, NULL, mr, GFP_KERNEL);
+	ret = xa_cmpxchg(&imr->implicit_children, idx, NULL, mr,
+			 GFP_KERNEL);
+	if (likely(!ret))
+		xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
+			 &mr->mmkey, GFP_ATOMIC);
 	if (unlikely(ret)) {
 		if (xa_is_err(ret)) {
 			ret = ERR_PTR(xa_err(ret));
@@ -404,9 +448,6 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 		goto out_release;
 	}
 
-	xa_store(&imr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key),
-		 &mr->mmkey, GFP_ATOMIC);
-
 	mlx5_ib_dbg(imr->dev, "key %x mr %p\n", mr->mmkey.key, mr);
 	return mr;
 
@@ -445,9 +486,7 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	imr->ibmr.lkey = imr->mmkey.key;
 	imr->ibmr.rkey = imr->mmkey.key;
 	imr->umem = &umem_odp->umem;
-	init_waitqueue_head(&imr->q_leaf_free);
-	atomic_set(&imr->num_leaf_free, 0);
-	atomic_set(&imr->num_pending_prefetch, 0);
+	atomic_set(&imr->num_deferred_work, 0);
 	xa_init(&imr->implicit_children);
 
 	err = mlx5_ib_update_xlt(imr, 0,
@@ -477,35 +516,48 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *imr)
 {
 	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
+	struct mlx5_ib_dev *dev = imr->dev;
+	struct list_head destroy_list;
 	struct mlx5_ib_mr *mtt;
+	struct mlx5_ib_mr *tmp;
 	unsigned long idx;
 
-	mutex_lock(&odp_imr->umem_mutex);
-	xa_for_each (&imr->implicit_children, idx, mtt) {
-		struct ib_umem_odp *umem_odp = to_ib_umem_odp(mtt->umem);
+	INIT_LIST_HEAD(&destroy_list);
 
-		xa_erase(&imr->implicit_children, idx);
+	xa_erase(&dev->odp_mkeys, mlx5_base_mkey(imr->mmkey.key));
+	/*
+	 * This stops the SRCU protected page fault path from touching either
+	 * the imr or any children. The page fault path can only reach the
+	 * children xarray via the imr.
+	 */
+	synchronize_srcu(&dev->odp_srcu);
 
-		mutex_lock(&umem_odp->umem_mutex);
-		ib_umem_odp_unmap_dma_pages(umem_odp, ib_umem_start(umem_odp),
-					    ib_umem_end(umem_odp));
+	xa_lock(&imr->implicit_children);
+	xa_for_each (&imr->implicit_children, idx, mtt) {
+		__xa_erase(&imr->implicit_children, idx);
+		__xa_erase(&dev->odp_mkeys, mlx5_base_mkey(mtt->mmkey.key));
+		list_add(&mtt->odp_destroy.elm, &destroy_list);
+	}
+	xa_unlock(&imr->implicit_children);
 
-		if (umem_odp->dying) {
-			mutex_unlock(&umem_odp->umem_mutex);
-			continue;
-		}
+	/* Fence access to the child pointers via the pagefault thread */
+	synchronize_srcu(&dev->odp_srcu);
 
-		umem_odp->dying = 1;
-		atomic_inc(&imr->num_leaf_free);
-		schedule_work(&umem_odp->work);
-		mutex_unlock(&umem_odp->umem_mutex);
+	/*
+	 * num_deferred_work can only be incremented inside the odp_srcu, or
+	 * under xa_lock while the child is in the xarray. Thus at this point
+	 * it is only decreasing, and all work holding it is now on the wq.
+	 */
+	if (atomic_read(&imr->num_deferred_work)) {
+		flush_workqueue(system_unbound_wq);
+		WARN_ON(atomic_read(&imr->num_deferred_work));
 	}
-	mutex_unlock(&odp_imr->umem_mutex);
 
-	wait_event(imr->q_leaf_free, !atomic_read(&imr->num_leaf_free));
-	WARN_ON(!xa_empty(&imr->implicit_children));
-	/* Remove any left over reserved elements */
-	xa_destroy(&imr->implicit_children);
+	list_for_each_entry_safe (mtt, tmp, &destroy_list, odp_destroy.elm)
+		free_implicit_child_mr(mtt, false);
+
+	mlx5_mr_cache_free(dev, imr);
+	ib_umem_odp_release(odp_imr);
 }
 
 #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
@@ -1579,7 +1631,7 @@ static void destroy_prefetch_work(struct prefetch_mr_work *work)
 	u32 i;
 
 	for (i = 0; i < work->num_sge; ++i)
-		atomic_dec(&work->frags[i].mr->num_pending_prefetch);
+		atomic_dec(&work->frags[i].mr->num_deferred_work);
 	kvfree(work);
 }
 
@@ -1658,7 +1710,7 @@ static bool init_prefetch_work(struct ib_pd *pd,
 		}
 
 		/* Keep the MR pointer will valid outside the SRCU */
-		atomic_inc(&work->frags[i].mr->num_pending_prefetch);
+		atomic_inc(&work->frags[i].mr->num_deferred_work);
 	}
 	work->num_sge = num_sge;
 	return true;
diff --git a/include/rdma/ib_umem_odp.h b/include/rdma/ib_umem_odp.h
index 28078efc38339f..09b0e4494986a9 100644
--- a/include/rdma/ib_umem_odp.h
+++ b/include/rdma/ib_umem_odp.h
@@ -78,9 +78,7 @@ struct ib_umem_odp {
 	bool is_implicit_odp;
 
 	struct completion	notifier_completion;
-	int			dying;
 	unsigned int		page_shift;
-	struct work_struct	work;
 };
 
 static inline struct ib_umem_odp *to_ib_umem_odp(struct ib_umem *umem)
-- 
2.23.0

