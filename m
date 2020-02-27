Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71DFF17174B
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729056AbgB0MeQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:34:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:35270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgB0MeP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:34:15 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62CE32468E;
        Thu, 27 Feb 2020 12:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806855;
        bh=hUBJCGylxvZ1m0zoiVTcLL90dKwZQwhVcOaND79H+go=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aNck6i79EdPofYHV1Dpzq0WTX79S7je96qT1WlyYCFUhROauXCrbUwrBBbD3fioJe
         BdNsIoPLwCg/B2ZZlAd1KJMGrxTQVPsjq/et9iIotrNg7vgNH80wjBfUOSedMNRjxs
         FNiG26EsU+SLB2i+BwhNpZ2TkfZHXNNIK1jo00Yw=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/9] RDMA/mlx5: Simplify how the MR cache bucket is located
Date:   Thu, 27 Feb 2020 14:33:54 +0200
Message-Id: <20200227123400.97758-4-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227123400.97758-1-leon@kernel.org>
References: <20200227123400.97758-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

There are many bad APIs here that are accepting a cache bucket index
instead of a bucket pointer. Many of the callers already have a bucket
pointer, so this results in a lot of confusing uses of order2idx().

Pass the struct mlx5_cache_ent into add_keys(), remove_keys(), and
alloc_cached_mr().

Once the MR is in the cache, store the cache bucket pointer directly in
the MR, replacing the 'bool allocated_from cache'.

In the end there is only one place that needs to form index from order,
alloc_mr_from_cache(). Increase the safety of this function by disallowing
it from accessing cache entries in the ODP special area.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   7 +-
 drivers/infiniband/hw/mlx5/mr.c      | 155 +++++++++++----------------
 drivers/infiniband/hw/mlx5/odp.c     |   2 +-
 3 files changed, 69 insertions(+), 95 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 2b566829427e..7aef89cc472d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -621,8 +621,8 @@ struct mlx5_ib_mr {
 	struct ib_umem	       *umem;
 	struct mlx5_shared_mr_info	*smr_info;
 	struct list_head	list;
-	int			order;
-	bool			allocated_from_cache;
+	unsigned int		order;
+	struct mlx5_cache_ent  *cache_ent;
 	int			npages;
 	struct mlx5_ib_dev     *dev;
 	u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
@@ -1276,7 +1276,8 @@ int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mr_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int entry);
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
+				       unsigned int entry);
 void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 int mlx5_mr_cache_invalidate(struct mlx5_ib_mr *mr);
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 9e504f18864a..68e5a3955b1d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -63,16 +63,6 @@ static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	return mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 }
 
-static int order2idx(struct mlx5_ib_dev *dev, int order)
-{
-	struct mlx5_mr_cache *cache = &dev->cache;
-
-	if (order < cache->ent[0].order)
-		return 0;
-	else
-		return order - cache->ent[0].order;
-}
-
 static bool use_umr_mtt_update(struct mlx5_ib_mr *mr, u64 start, u64 length)
 {
 	return ((u64)1 << mr->order) * MLX5_ADAPTER_PAGE_SIZE >=
@@ -103,9 +93,7 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 	struct mlx5_ib_mr *mr =
 		container_of(context, struct mlx5_ib_mr, cb_work);
 	struct mlx5_ib_dev *dev = mr->dev;
-	struct mlx5_mr_cache *cache = &dev->cache;
-	int c = order2idx(dev, mr->order);
-	struct mlx5_cache_ent *ent = &cache->ent[c];
+	struct mlx5_cache_ent *ent = mr->cache_ent;
 	u8 key;
 	unsigned long flags;
 
@@ -126,7 +114,7 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 	spin_unlock_irqrestore(&dev->mdev->priv.mkey_lock, flags);
 	mr->mmkey.key = mlx5_idx_to_mkey(MLX5_GET(create_mkey_out, mr->out, mkey_index)) | key;
 
-	cache->last_add = jiffies;
+	dev->cache.last_add = jiffies;
 
 	spin_lock_irqsave(&ent->lock, flags);
 	list_add_tail(&mr->list, &ent->head);
@@ -138,10 +126,8 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 		complete(&ent->compl);
 }
 
-static int add_keys(struct mlx5_ib_dev *dev, int c, int num)
+static int add_keys(struct mlx5_cache_ent *ent, int num)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent = &cache->ent[c];
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	struct mlx5_ib_mr *mr;
 	void *mkc;
@@ -166,8 +152,8 @@ static int add_keys(struct mlx5_ib_dev *dev, int c, int num)
 			break;
 		}
 		mr->order = ent->order;
-		mr->allocated_from_cache = true;
-		mr->dev = dev;
+		mr->cache_ent = ent;
+		mr->dev = ent->dev;
 
 		MLX5_SET(mkc, mkc, free, 1);
 		MLX5_SET(mkc, mkc, umr_en, 1);
@@ -182,13 +168,14 @@ static int add_keys(struct mlx5_ib_dev *dev, int c, int num)
 		spin_lock_irq(&ent->lock);
 		ent->pending++;
 		spin_unlock_irq(&ent->lock);
-		err = create_mkey_cb(dev->mdev, mr, &dev->async_ctx, in, inlen,
+
+		err = create_mkey_cb(ent->dev->mdev, mr, &ent->dev->async_ctx, in, inlen,
 				     reg_mr_callback);
 		if (err) {
 			spin_lock_irq(&ent->lock);
 			ent->pending--;
 			spin_unlock_irq(&ent->lock);
-			mlx5_ib_warn(dev, "create mkey failed %d\n", err);
+			mlx5_ib_warn(ent->dev, "create mkey failed %d\n", err);
 			kfree(mr);
 			break;
 		}
@@ -198,10 +185,8 @@ static int add_keys(struct mlx5_ib_dev *dev, int c, int num)
 	return err;
 }
 
-static void remove_keys(struct mlx5_ib_dev *dev, int c, int num)
+static void remove_keys(struct mlx5_cache_ent *ent, int num)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent = &cache->ent[c];
 	struct mlx5_ib_mr *tmp_mr;
 	struct mlx5_ib_mr *mr;
 	LIST_HEAD(del_list);
@@ -218,7 +203,7 @@ static void remove_keys(struct mlx5_ib_dev *dev, int c, int num)
 		ent->available_mrs--;
 		ent->total_mrs--;
 		spin_unlock_irq(&ent->lock);
-		mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
+		mlx5_core_destroy_mkey(ent->dev->mdev, &mr->mmkey);
 	}
 
 	list_for_each_entry_safe(mr, tmp_mr, &del_list, list) {
@@ -231,18 +216,14 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 			  size_t count, loff_t *pos)
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
-	struct mlx5_ib_dev *dev = ent->dev;
 	char lbuf[20] = {0};
 	u32 var;
 	int err;
-	int c;
 
 	count = min(count, sizeof(lbuf) - 1);
 	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
 
-	c = order2idx(dev, ent->order);
-
 	if (sscanf(lbuf, "%u", &var) != 1)
 		return -EINVAL;
 
@@ -251,14 +232,14 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 
 	if (var > ent->total_mrs) {
 		do {
-			err = add_keys(dev, c, var - ent->total_mrs);
+			err = add_keys(ent, var - ent->total_mrs);
 			if (err && err != -EAGAIN)
 				return err;
 
 			usleep_range(3000, 5000);
 		} while (err);
 	} else if (var < ent->total_mrs) {
-		remove_keys(dev, c, ent->total_mrs - var);
+		remove_keys(ent, ent->total_mrs - var);
 	}
 
 	return count;
@@ -289,18 +270,14 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 			   size_t count, loff_t *pos)
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
-	struct mlx5_ib_dev *dev = ent->dev;
 	char lbuf[20] = {0};
 	u32 var;
 	int err;
-	int c;
 
 	count = min(count, sizeof(lbuf) - 1);
 	if (copy_from_user(lbuf, buf, count))
 		return -EFAULT;
 
-	c = order2idx(dev, ent->order);
-
 	if (sscanf(lbuf, "%u", &var) != 1)
 		return -EINVAL;
 
@@ -310,7 +287,7 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 	ent->limit = var;
 
 	if (ent->available_mrs < ent->limit) {
-		err = add_keys(dev, c, 2 * ent->limit - ent->available_mrs);
+		err = add_keys(ent, 2 * ent->limit - ent->available_mrs);
 		if (err)
 			return err;
 	}
@@ -355,24 +332,22 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_dev *dev = ent->dev;
 	struct mlx5_mr_cache *cache = &dev->cache;
-	int i = order2idx(dev, ent->order);
 	int err;
 
 	if (cache->stopped)
 		return;
 
-	ent = &dev->cache.ent[i];
 	if (ent->available_mrs < 2 * ent->limit && !dev->fill_delay) {
-		err = add_keys(dev, i, 1);
+		err = add_keys(ent, 1);
 		if (ent->available_mrs < 2 * ent->limit) {
 			if (err == -EAGAIN) {
 				mlx5_ib_dbg(dev, "returned eagain, order %d\n",
-					    i + 2);
+					    ent->order);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(3));
 			} else if (err) {
 				mlx5_ib_warn(dev, "command failed order %d, err %d\n",
-					     i + 2, err);
+					     ent->order, err);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(1000));
 			} else {
@@ -394,7 +369,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		 */
 		if (!need_resched() && !someone_adding(cache) &&
 		    time_after(jiffies, cache->last_add + 300 * HZ)) {
-			remove_keys(dev, i, 1);
+			remove_keys(ent, 1);
 			if (ent->available_mrs > ent->limit)
 				queue_work(cache->wq, &ent->work);
 		} else {
@@ -419,17 +394,18 @@ static void cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int entry)
+/* Allocate a special entry from the cache */
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
+				       unsigned int entry)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
 	int err;
 
-	if (entry < 0 || entry >= MAX_MR_CACHE_ENTRIES) {
-		mlx5_ib_err(dev, "cache entry %d is out of range\n", entry);
+	if (WARN_ON(entry <= MR_CACHE_LAST_STD_ENTRY ||
+		    entry >= ARRAY_SIZE(cache->ent)))
 		return ERR_PTR(-EINVAL);
-	}
 
 	ent = &cache->ent[entry];
 	while (1) {
@@ -437,7 +413,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int entry)
 		if (list_empty(&ent->head)) {
 			spin_unlock_irq(&ent->lock);
 
-			err = add_keys(dev, entry, 1);
+			err = add_keys(ent, 1);
 			if (err && err != -EAGAIN)
 				return ERR_PTR(err);
 
@@ -455,26 +431,16 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int entry)
 	}
 }
 
-static struct mlx5_ib_mr *alloc_cached_mr(struct mlx5_ib_dev *dev, int order)
+static struct mlx5_ib_mr *alloc_cached_mr(struct mlx5_cache_ent *req_ent)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_ib_dev *dev = req_ent->dev;
 	struct mlx5_ib_mr *mr = NULL;
-	struct mlx5_cache_ent *ent;
-	int last_umr_cache_entry;
-	int c;
-	int i;
-
-	c = order2idx(dev, order);
-	last_umr_cache_entry = order2idx(dev, mr_cache_max_order(dev));
-	if (c < 0 || c > last_umr_cache_entry) {
-		mlx5_ib_warn(dev, "order %d, cache index %d\n", order, c);
-		return NULL;
-	}
+	struct mlx5_cache_ent *ent = req_ent;
 
-	for (i = c; i <= last_umr_cache_entry; i++) {
-		ent = &cache->ent[i];
-
-		mlx5_ib_dbg(dev, "order %d, cache index %d\n", ent->order, i);
+	/* Try larger MR pools from the cache to satisfy the allocation */
+	for (; ent != &dev->cache.ent[MR_CACHE_LAST_STD_ENTRY + 1]; ent++) {
+		mlx5_ib_dbg(dev, "order %u, cache index %zu\n", ent->order,
+			    ent - dev->cache.ent);
 
 		spin_lock_irq(&ent->lock);
 		if (!list_empty(&ent->head)) {
@@ -484,43 +450,36 @@ static struct mlx5_ib_mr *alloc_cached_mr(struct mlx5_ib_dev *dev, int order)
 			ent->available_mrs--;
 			spin_unlock_irq(&ent->lock);
 			if (ent->available_mrs < ent->limit)
-				queue_work(cache->wq, &ent->work);
+				queue_work(dev->cache.wq, &ent->work);
 			break;
 		}
 		spin_unlock_irq(&ent->lock);
 
-		queue_work(cache->wq, &ent->work);
+		queue_work(dev->cache.wq, &ent->work);
 	}
 
 	if (!mr)
-		cache->ent[c].miss++;
+		req_ent->miss++;
 
 	return mr;
 }
 
 void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
+	struct mlx5_cache_ent *ent = mr->cache_ent;
 	int shrink = 0;
-	int c;
 
-	if (!mr->allocated_from_cache)
+	if (!ent)
 		return;
 
-	c = order2idx(dev, mr->order);
-	WARN_ON(c < 0 || c >= MAX_MR_CACHE_ENTRIES);
-
 	if (mlx5_mr_cache_invalidate(mr)) {
-		mr->allocated_from_cache = false;
+		mr->cache_ent = NULL;
 		destroy_mkey(dev, mr);
-		ent = &cache->ent[c];
 		if (ent->available_mrs < ent->limit)
-			queue_work(cache->wq, &ent->work);
+			queue_work(dev->cache.wq, &ent->work);
 		return;
 	}
 
-	ent = &cache->ent[c];
 	spin_lock_irq(&ent->lock);
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
@@ -529,7 +488,7 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	spin_unlock_irq(&ent->lock);
 
 	if (shrink)
-		queue_work(cache->wq, &ent->work);
+		queue_work(dev->cache.wq, &ent->work);
 }
 
 static void clean_keys(struct mlx5_ib_dev *dev, int c)
@@ -857,22 +816,38 @@ static int mlx5_ib_post_send_wait(struct mlx5_ib_dev *dev,
 	return err;
 }
 
-static struct mlx5_ib_mr *alloc_mr_from_cache(
-				  struct ib_pd *pd, struct ib_umem *umem,
-				  u64 virt_addr, u64 len, int npages,
-				  int page_shift, int order, int access_flags)
+static struct mlx5_cache_ent *mr_cache_ent_from_order(struct mlx5_ib_dev *dev,
+						      unsigned int order)
+{
+	struct mlx5_mr_cache *cache = &dev->cache;
+
+	if (order < cache->ent[0].order)
+		return &cache->ent[0];
+	order = order - cache->ent[0].order;
+	if (order > MR_CACHE_LAST_STD_ENTRY)
+		return NULL;
+	return &cache->ent[order];
+}
+
+static struct mlx5_ib_mr *
+alloc_mr_from_cache(struct ib_pd *pd, struct ib_umem *umem, u64 virt_addr,
+		    u64 len, int npages, int page_shift, unsigned int order,
+		    int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
+	struct mlx5_cache_ent *ent = mr_cache_ent_from_order(dev, order);
 	struct mlx5_ib_mr *mr;
 	int err = 0;
 	int i;
 
+	if (!ent)
+		return ERR_PTR(-E2BIG);
 	for (i = 0; i < 1; i++) {
-		mr = alloc_cached_mr(dev, order);
+		mr = alloc_cached_mr(ent);
 		if (mr)
 			break;
 
-		err = add_keys(dev, order2idx(dev, order), 1);
+		err = add_keys(ent, 1);
 		if (err && err != -EAGAIN) {
 			mlx5_ib_warn(dev, "add_keys failed, err %d\n", err);
 			break;
@@ -1456,7 +1431,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		/*
 		 * UMR can't be used - MKey needs to be replaced.
 		 */
-		if (mr->allocated_from_cache)
+		if (mr->cache_ent)
 			err = mlx5_mr_cache_invalidate(mr);
 		else
 			err = destroy_mkey(dev, mr);
@@ -1472,7 +1447,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 			goto err;
 		}
 
-		mr->allocated_from_cache = false;
+		mr->cache_ent = NULL;
 	} else {
 		/*
 		 * Send a UMR WQE
@@ -1559,8 +1534,6 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 
 static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
-	int allocated_from_cache = mr->allocated_from_cache;
-
 	if (mr->sig) {
 		if (mlx5_core_destroy_psv(dev->mdev,
 					  mr->sig->psv_memory.psv_idx))
@@ -1575,7 +1548,7 @@ static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		mr->sig = NULL;
 	}
 
-	if (!allocated_from_cache) {
+	if (!mr->cache_ent) {
 		destroy_mkey(dev, mr);
 		mlx5_free_priv_descs(mr);
 	}
@@ -1592,7 +1565,7 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	else
 		clean_mr(dev, mr);
 
-	if (mr->allocated_from_cache)
+	if (mr->cache_ent)
 		mlx5_mr_cache_free(dev, mr);
 	else
 		kfree(mr);
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 4216814ba871..224f480fc441 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -197,7 +197,7 @@ static void dma_fence_odp_mr(struct mlx5_ib_mr *mr)
 	odp->private = NULL;
 	mutex_unlock(&odp->umem_mutex);
 
-	if (!mr->allocated_from_cache) {
+	if (!mr->cache_ent) {
 		mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
 		WARN_ON(mr->descs);
 	}
-- 
2.24.1

