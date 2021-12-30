Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E768481BAC
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:23:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbhL3LXm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:23:42 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60640 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235325AbhL3LXm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:23:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 782F5B80B3A;
        Thu, 30 Dec 2021 11:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA7FC36AE9;
        Thu, 30 Dec 2021 11:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863419;
        bh=bS2EKpoVJc+DiSe++w2nFwHEZ5MGz5BZ5zTNfPsgExs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a7UWFJyCREV3t1aa2xH35hhqq59pu25fy0hY+XBnbWI8NerEk8YZ9UTFCF6R17chq
         UsqelD7c4rJ7NwlNLFFRr88hz9ShoSXkzVtPgWWW5euXQENp7Qz0KG17p0UocGlPjG
         RXdnwy+dBd8a8+Sr7QnO2nlsHo0s3aRnsvLxtdvakvSBpfCj5JWHYBqdS7uyXqV58p
         afh7zbi9TDQImXXDO3HkOaR8uTCiRCnuyiBlrJFX5MAMQCx/WnFmXiIjN7NNVjWFqN
         JPQmSjoFhGU/4BmbmLFUvPfhGoh5CeVzBSpzxuG1NGrUzRj+QDr1itDC9X9jnt2IUp
         navQbeMPX0sWg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 2/7] RDMA/mlx5: Replace cache list with Xarray
Date:   Thu, 30 Dec 2021 13:23:19 +0200
Message-Id: <58c847ceb443d1836fcf6c8602f2ccb5e84728d7.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640862842.git.leonro@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

The Xarray allows us to store the cached mkeys in memory efficient way
and internal xa_lock is used to protect the indexes. It helps us to get
rid of ent->lock as it is not required anymore.

Entries are reserved in the Xarray using xa_cmpxchg before calling to
the upcoming callbacks to avoid allocations in interrupt context.
The xa_cmpxchg can sleep when using GFP_KERNEL, so we call it in
a loop to ensure one reserved entry for each process trying to reserve.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  13 +-
 drivers/infiniband/hw/mlx5/mr.c      | 253 ++++++++++++++++-----------
 2 files changed, 153 insertions(+), 113 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9c3cf6f26ad1..213894053bfe 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -755,11 +755,9 @@ struct umr_common {
 };
 
 struct mlx5_cache_ent {
-	struct list_head	head;
-	/* sync access to the cahce entry
-	 */
-	spinlock_t		lock;
-
+	struct xarray		mkeys;
+	unsigned long		stored;
+	unsigned long		reserved;
 
 	char                    name[4];
 	u32                     order;
@@ -771,18 +769,13 @@ struct mlx5_cache_ent {
 	u8 fill_to_high_water:1;
 
 	/*
-	 * - available_mrs is the length of list head, ie the number of MRs
-	 *   available for immediate allocation.
 	 * - total_mrs is available_mrs plus all in use MRs that could be
 	 *   returned to the cache.
 	 * - limit is the low water mark for available_mrs, 2* limit is the
 	 *   upper water mark.
-	 * - pending is the number of MRs currently being created
 	 */
 	u32 total_mrs;
-	u32 available_mrs;
 	u32 limit;
-	u32 pending;
 
 	/* Statistics */
 	u32                     miss;
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2cba55bb7825..8936b504ff99 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -147,14 +147,17 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 	struct mlx5_ib_dev *dev = ent->dev;
 	unsigned long flags;
+	void *old;
 
 	if (status) {
 		mlx5_ib_warn(dev, "async reg mr failed. status %d\n", status);
 		kfree(mr);
-		spin_lock_irqsave(&ent->lock, flags);
-		ent->pending--;
+		xa_lock_irqsave(&ent->mkeys, flags);
+		ent->reserved--;
+		old = __xa_erase(&ent->mkeys, ent->reserved);
+		WARN_ON(old != NULL);
 		WRITE_ONCE(dev->fill_delay, 1);
-		spin_unlock_irqrestore(&ent->lock, flags);
+		xa_unlock_irqrestore(&ent->mkeys, flags);
 		mod_timer(&dev->delay_timer, jiffies + HZ);
 		return;
 	}
@@ -166,14 +169,14 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 
 	WRITE_ONCE(dev->cache.last_add, jiffies);
 
-	spin_lock_irqsave(&ent->lock, flags);
-	list_add_tail(&mr->list, &ent->head);
-	ent->available_mrs++;
+	xa_lock_irqsave(&ent->mkeys, flags);
+	old = __xa_store(&ent->mkeys, ent->stored, mr, GFP_ATOMIC);
+	WARN_ON(old != NULL);
+	ent->stored++;
 	ent->total_mrs++;
 	/* If we are doing fill_to_high_water then keep going. */
 	queue_adjust_cache_locked(ent);
-	ent->pending--;
-	spin_unlock_irqrestore(&ent->lock, flags);
+	xa_unlock_irqrestore(&ent->mkeys, flags);
 }
 
 static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
@@ -196,12 +199,48 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 	return mr;
 }
 
+static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
+{
+	unsigned long to_reserve;
+	void *old;
+
+	while (true) {
+		to_reserve = ent->reserved;
+		old = __xa_cmpxchg(&ent->mkeys, to_reserve, NULL, XA_ZERO_ENTRY,
+				  GFP_KERNEL);
+
+		if (xa_is_err(old))
+			return xa_err(old);
+
+		if (to_reserve != ent->reserved || old != NULL) {
+			if (to_reserve > ent->reserved && old == NULL)
+				__xa_erase(&ent->mkeys, to_reserve);
+			continue;
+		}
+
+		ent->reserved++;
+		break;
+	}
+	return 0;
+}
+
+static int push_reserve_mkey(struct mlx5_cache_ent *ent)
+{
+	int ret;
+
+	xa_lock_irq(&ent->mkeys);
+	ret = _push_reserve_mkey(ent);
+	xa_unlock_irq(&ent->mkeys);
+
+	return ret;
+}
+
 /* Asynchronously schedule new MRs to be populated in the cache. */
 static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 {
 	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	struct mlx5_ib_mr *mr;
-	void *mkc;
+	void *mkc, *old;
 	u32 *in;
 	int err = 0;
 	int i;
@@ -215,31 +254,41 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 		mr = alloc_cache_mr(ent, mkc);
 		if (!mr) {
 			err = -ENOMEM;
-			break;
+			goto err;
 		}
-		spin_lock_irq(&ent->lock);
-		if (ent->pending >= MAX_PENDING_REG_MR) {
+
+		xa_lock_irq(&ent->mkeys);
+		err = _push_reserve_mkey(ent);
+		if (err)
+			goto err_unlock;
+		if ((ent->reserved - ent->stored) > MAX_PENDING_REG_MR) {
 			err = -EAGAIN;
-			spin_unlock_irq(&ent->lock);
-			kfree(mr);
-			break;
+			goto err_undo_reserve;
 		}
-		ent->pending++;
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
+
 		err = mlx5_ib_create_mkey_cb(ent->dev, &mr->mmkey,
 					     &ent->dev->async_ctx, in, inlen,
 					     mr->out, sizeof(mr->out),
 					     &mr->cb_work);
 		if (err) {
-			spin_lock_irq(&ent->lock);
-			ent->pending--;
-			spin_unlock_irq(&ent->lock);
 			mlx5_ib_warn(ent->dev, "create mkey failed %d\n", err);
-			kfree(mr);
-			break;
+			xa_lock_irq(&ent->mkeys);
+			goto err_undo_reserve;
 		}
 	}
 
+	kfree(in);
+	return 0;
+
+err_undo_reserve:
+	ent->reserved--;
+	old = __xa_erase(&ent->mkeys, ent->reserved);
+	WARN_ON(old != NULL);
+err_unlock:
+	xa_unlock_irq(&ent->mkeys);
+	kfree(mr);
+err:
 	kfree(in);
 	return err;
 }
@@ -271,9 +320,9 @@ static struct mlx5_ib_mr *create_cache_mr(struct mlx5_cache_ent *ent)
 	init_waitqueue_head(&mr->mmkey.wait);
 	mr->mmkey.type = MLX5_MKEY_MR;
 	WRITE_ONCE(ent->dev->cache.last_add, jiffies);
-	spin_lock_irq(&ent->lock);
+	xa_lock_irq(&ent->mkeys);
 	ent->total_mrs++;
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 	kfree(in);
 	return mr;
 free_mr:
@@ -286,40 +335,42 @@ static struct mlx5_ib_mr *create_cache_mr(struct mlx5_cache_ent *ent)
 static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_mr *mr;
+	void *old;
 
-	lockdep_assert_held(&ent->lock);
-	if (list_empty(&ent->head))
+	if (!ent->stored)
 		return;
-	mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
-	list_del(&mr->list);
-	ent->available_mrs--;
+	ent->stored--;
+	mr = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY, GFP_KERNEL);
+	WARN_ON(mr == NULL || xa_is_err(mr));
+	ent->reserved--;
+	old = __xa_erase(&ent->mkeys, ent->reserved);
+	WARN_ON(old != NULL);
 	ent->total_mrs--;
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 	mlx5_core_destroy_mkey(ent->dev->mdev, mr->mmkey.key);
 	kfree(mr);
-	spin_lock_irq(&ent->lock);
+	xa_lock_irq(&ent->mkeys);
 }
 
 static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
 				bool limit_fill)
+	 __acquires(&ent->lock) __releases(&ent->lock)
 {
 	int err;
 
-	lockdep_assert_held(&ent->lock);
-
 	while (true) {
 		if (limit_fill)
 			target = ent->limit * 2;
-		if (target == ent->available_mrs + ent->pending)
+		if (target == ent->reserved)
 			return 0;
-		if (target > ent->available_mrs + ent->pending) {
-			u32 todo = target - (ent->available_mrs + ent->pending);
+		if (target > ent->reserved) {
+			u32 todo = target - ent->reserved;
 
-			spin_unlock_irq(&ent->lock);
+			xa_unlock_irq(&ent->mkeys);
 			err = add_keys(ent, todo);
 			if (err == -EAGAIN)
 				usleep_range(3000, 5000);
-			spin_lock_irq(&ent->lock);
+			xa_lock_irq(&ent->mkeys);
 			if (err) {
 				if (err != -EAGAIN)
 					return err;
@@ -347,12 +398,13 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 	 * cannot free MRs that are in use. Compute the target value for
 	 * available_mrs.
 	 */
-	spin_lock_irq(&ent->lock);
-	if (target < ent->total_mrs - ent->available_mrs) {
+
+	xa_lock_irq(&ent->mkeys);
+	if (target < ent->total_mrs - ent->stored) {
 		err = -EINVAL;
 		goto err_unlock;
 	}
-	target = target - (ent->total_mrs - ent->available_mrs);
+	target = target - (ent->total_mrs - ent->stored);
 	if (target < ent->limit || target > ent->limit*2) {
 		err = -EINVAL;
 		goto err_unlock;
@@ -360,12 +412,12 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 	err = resize_available_mrs(ent, target, false);
 	if (err)
 		goto err_unlock;
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 
 	return count;
 
 err_unlock:
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 	return err;
 }
 
@@ -405,10 +457,10 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 	 * Upon set we immediately fill the cache to high water mark implied by
 	 * the limit.
 	 */
-	spin_lock_irq(&ent->lock);
+	xa_lock_irq(&ent->mkeys);
 	ent->limit = var;
 	err = resize_available_mrs(ent, 0, true);
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 	if (err)
 		return err;
 	return count;
@@ -443,9 +495,9 @@ static bool someone_adding(struct mlx5_mr_cache *cache)
 		struct mlx5_cache_ent *ent = &cache->ent[i];
 		bool ret;
 
-		spin_lock_irq(&ent->lock);
-		ret = ent->available_mrs < ent->limit;
-		spin_unlock_irq(&ent->lock);
+		xa_lock_irq(&ent->mkeys);
+		ret = ent->stored < ent->limit;
+		xa_unlock_irq(&ent->mkeys);
 		if (ret)
 			return true;
 	}
@@ -459,26 +511,24 @@ static bool someone_adding(struct mlx5_mr_cache *cache)
  */
 static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 {
-	lockdep_assert_held(&ent->lock);
-
 	if (ent->disabled || READ_ONCE(ent->dev->fill_delay))
 		return;
-	if (ent->available_mrs < ent->limit) {
+	if (ent->stored < ent->limit) {
 		ent->fill_to_high_water = true;
 		queue_work(ent->dev->cache.wq, &ent->work);
 	} else if (ent->fill_to_high_water &&
-		   ent->available_mrs + ent->pending < 2 * ent->limit) {
+		   ent->reserved < 2 * ent->limit) {
 		/*
 		 * Once we start populating due to hitting a low water mark
 		 * continue until we pass the high water mark.
 		 */
 		queue_work(ent->dev->cache.wq, &ent->work);
-	} else if (ent->available_mrs == 2 * ent->limit) {
+	} else if (ent->stored == 2 * ent->limit) {
 		ent->fill_to_high_water = false;
-	} else if (ent->available_mrs > 2 * ent->limit) {
+	} else if (ent->stored > 2 * ent->limit) {
 		/* Queue deletion of excess entries */
 		ent->fill_to_high_water = false;
-		if (ent->pending)
+		if (ent->stored != ent->reserved)
 			queue_delayed_work(ent->dev->cache.wq, &ent->dwork,
 					   msecs_to_jiffies(1000));
 		else
@@ -492,22 +542,21 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 	struct mlx5_mr_cache *cache = &dev->cache;
 	int err;
 
-	spin_lock_irq(&ent->lock);
+	xa_lock_irq(&ent->mkeys);
 	if (ent->disabled)
 		goto out;
 
-	if (ent->fill_to_high_water &&
-	    ent->available_mrs + ent->pending < 2 * ent->limit &&
+	if (ent->fill_to_high_water && ent->reserved < 2 * ent->limit &&
 	    !READ_ONCE(dev->fill_delay)) {
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 		err = add_keys(ent, 1);
-		spin_lock_irq(&ent->lock);
+		xa_lock_irq(&ent->mkeys);
 		if (ent->disabled)
 			goto out;
 		if (err) {
 			/*
-			 * EAGAIN only happens if pending is positive, so we
-			 * will be rescheduled from reg_mr_callback(). The only
+			 * EAGAIN only happens if there are pending MRs, so we
+			 * will be rescheduled when storing them. The only
 			 * failure path here is ENOMEM.
 			 */
 			if (err != -EAGAIN) {
@@ -519,7 +568,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 						   msecs_to_jiffies(1000));
 			}
 		}
-	} else if (ent->available_mrs > 2 * ent->limit) {
+	} else if (ent->stored > 2 * ent->limit) {
 		bool need_delay;
 
 		/*
@@ -534,11 +583,11 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		 * the garbage collection work to try to run in next cycle, in
 		 * order to free CPU resources to other tasks.
 		 */
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 		need_delay = need_resched() || someone_adding(cache) ||
 			     !time_after(jiffies,
 					 READ_ONCE(cache->last_add) + 300 * HZ);
-		spin_lock_irq(&ent->lock);
+		xa_lock_irq(&ent->mkeys);
 		if (ent->disabled)
 			goto out;
 		if (need_delay)
@@ -547,7 +596,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		queue_adjust_cache_locked(ent);
 	}
 out:
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 }
 
 static void delayed_cache_work_func(struct work_struct *work)
@@ -571,27 +620,32 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       int access_flags)
 {
 	struct mlx5_ib_mr *mr;
+	void *old;
 
 	/* Matches access in alloc_cache_mr() */
 	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	spin_lock_irq(&ent->lock);
-	if (list_empty(&ent->head)) {
+	xa_lock_irq(&ent->mkeys);
+	if (!ent->stored) {
 		if (ent->limit) {
 			queue_adjust_cache_locked(ent);
 			ent->miss++;
 		}
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 		mr = create_cache_mr(ent);
 		if (IS_ERR(mr))
 			return mr;
 	} else {
-		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
-		list_del(&mr->list);
-		ent->available_mrs--;
+		ent->stored--;
+		mr = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY,
+				GFP_KERNEL);
+		WARN_ON(mr == NULL || xa_is_err(mr));
+		ent->reserved--;
+		old = __xa_erase(&ent->mkeys, ent->reserved);
+		WARN_ON(old != NULL);
 		queue_adjust_cache_locked(ent);
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 
 		mlx5_clear_mr(mr);
 	}
@@ -601,41 +655,35 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
+	void *old;
 
-	spin_lock_irq(&ent->lock);
-	list_add_tail(&mr->list, &ent->head);
-	ent->available_mrs++;
+	xa_lock_irq(&ent->mkeys);
+	old = __xa_store(&ent->mkeys, ent->stored, mr, 0);
+	WARN_ON(old != NULL);
+	ent->stored++;
 	queue_adjust_cache_locked(ent);
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 }
 
 static void clean_keys(struct mlx5_ib_dev *dev, int c)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent = &cache->ent[c];
-	struct mlx5_ib_mr *tmp_mr;
 	struct mlx5_ib_mr *mr;
-	LIST_HEAD(del_list);
 
 	cancel_delayed_work(&ent->dwork);
-	while (1) {
-		spin_lock_irq(&ent->lock);
-		if (list_empty(&ent->head)) {
-			spin_unlock_irq(&ent->lock);
-			break;
-		}
-		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
-		list_move(&mr->list, &del_list);
-		ent->available_mrs--;
+	xa_lock_irq(&ent->mkeys);
+	while (ent->stored) {
+		ent->stored--;
+		mr = __xa_erase(&ent->mkeys, ent->stored);
+		WARN_ON(mr == NULL);
 		ent->total_mrs--;
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 		mlx5_core_destroy_mkey(dev->mdev, mr->mmkey.key);
-	}
-
-	list_for_each_entry_safe(mr, tmp_mr, &del_list, list) {
-		list_del(&mr->list);
 		kfree(mr);
+		xa_lock_irq(&ent->mkeys);
 	}
+	xa_unlock_irq(&ent->mkeys);
 }
 
 static void mlx5_mr_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
@@ -665,7 +713,7 @@ static void mlx5_mr_cache_debugfs_init(struct mlx5_ib_dev *dev)
 		dir = debugfs_create_dir(ent->name, cache->root);
 		debugfs_create_file("size", 0600, dir, ent, &size_fops);
 		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
-		debugfs_create_u32("cur", 0400, dir, &ent->available_mrs);
+		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
 		debugfs_create_u32("miss", 0600, dir, &ent->miss);
 	}
 }
@@ -694,8 +742,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
 	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
 		ent = &cache->ent[i];
-		INIT_LIST_HEAD(&ent->head);
-		spin_lock_init(&ent->lock);
+		xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
 		ent->order = i + 2;
 		ent->dev = dev;
 		ent->limit = 0;
@@ -721,9 +768,9 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 			ent->limit = dev->mdev->profile.mr_cache[i].limit;
 		else
 			ent->limit = 0;
-		spin_lock_irq(&ent->lock);
+		xa_lock_irq(&ent->mkeys);
 		queue_adjust_cache_locked(ent);
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 	}
 
 	mlx5_mr_cache_debugfs_init(dev);
@@ -741,9 +788,9 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
 		struct mlx5_cache_ent *ent = &dev->cache.ent[i];
 
-		spin_lock_irq(&ent->lock);
+		xa_lock_irq(&ent->mkeys);
 		ent->disabled = true;
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 		cancel_work_sync(&ent->work);
 		cancel_delayed_work_sync(&ent->dwork);
 	}
@@ -1932,10 +1979,10 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
 	/* Stop DMA */
 	if (mr->cache_ent) {
-		if (revoke_mr(mr)) {
-			spin_lock_irq(&mr->cache_ent->lock);
+		if (revoke_mr(mr) || push_reserve_mkey(mr->cache_ent)) {
+			xa_lock_irq(&mr->cache_ent->mkeys);
 			mr->cache_ent->total_mrs--;
-			spin_unlock_irq(&mr->cache_ent->lock);
+			xa_unlock_irq(&mr->cache_ent->mkeys);
 			mr->cache_ent = NULL;
 		}
 	}
-- 
2.33.1

