Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8870746920F
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 10:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240042AbhLFJOf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 04:14:35 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40084 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240041AbhLFJOf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 04:14:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DC48EB81020;
        Mon,  6 Dec 2021 09:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F33C341C2;
        Mon,  6 Dec 2021 09:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638781864;
        bh=Fnf0BrvNOQAlTVztNVbR5qtm9rcLl3l4m7Ec/bI5q24=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKP50m8FdVb/IS7hLntqOoZC4AOZurLsBMvuwzbLOi+mC2O9ZcoEersHRjp+bdING
         2DRD53vmyzyXfDc3AputAkgx6EQoe0qnnQfdqvQv9CuVQG7H0RflA7OWiS10SkBPVO
         G9onCuY1qgRCYu39Egx/weKqAQiilSNrvRzLSt+EooeeDFyOOjPstAc4YSP8WT6nDk
         lE3txi/Ty6C4duMJCIv5JwMibpJOFZKRj/TpKfxpcZIsKXhaLWjFKOJcgYwyMAX6mM
         T7mV1d20oRxa5v+0l5CuGYIaHPhey/2vxk2gN4kjgeY/CJqssFvXD7Zwiw2dB/3EN5
         /qTPll8HEzdsg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/7] RDMA/mlx5: Replace cache list with Xarray
Date:   Mon,  6 Dec 2021 11:10:47 +0200
Message-Id: <63a833106bcb03298489a80e88b1086684c76595.1638781506.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638781506.git.leonro@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  11 +-
 drivers/infiniband/hw/mlx5/mr.c      | 206 +++++++++++++++------------
 2 files changed, 119 insertions(+), 98 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 804748174752..d0224f468169 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -754,11 +754,9 @@ struct umr_common {
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
@@ -770,8 +768,6 @@ struct mlx5_cache_ent {
 	u8 fill_to_high_water:1;
 
 	/*
-	 * - available_mrs is the length of list head, ie the number of MRs
-	 *   available for immediate allocation.
 	 * - total_mrs is available_mrs plus all in use MRs that could be
 	 *   returned to the cache.
 	 * - limit is the low water mark for available_mrs, 2* limit is the
@@ -779,7 +775,6 @@ struct mlx5_cache_ent {
 	 * - pending is the number of MRs currently being created
 	 */
 	u32 total_mrs;
-	u32 available_mrs;
 	u32 limit;
 	u32 pending;
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 2cba55bb7825..e62f8da8558d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -147,14 +147,17 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 	struct mlx5_ib_dev *dev = ent->dev;
 	unsigned long flags;
+	void *xa_ent;
 
 	if (status) {
 		mlx5_ib_warn(dev, "async reg mr failed. status %d\n", status);
 		kfree(mr);
-		spin_lock_irqsave(&ent->lock, flags);
+		xa_lock_irqsave(&ent->mkeys, flags);
+		xa_ent = __xa_erase(&ent->mkeys, ent->reserved--);
+		WARN_ON(xa_ent != NULL);
 		ent->pending--;
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
+	xa_ent = __xa_store(&ent->mkeys, ent->stored++, mr, GFP_ATOMIC);
+	WARN_ON(xa_ent != NULL);
+	ent->pending--;
 	ent->total_mrs++;
 	/* If we are doing fill_to_high_water then keep going. */
 	queue_adjust_cache_locked(ent);
-	ent->pending--;
-	spin_unlock_irqrestore(&ent->lock, flags);
+	xa_unlock_irqrestore(&ent->mkeys, flags);
 }
 
 static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
@@ -196,6 +199,25 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 	return mr;
 }
 
+static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
+{
+	unsigned long to_reserve;
+	int rc;
+
+	while (true) {
+		to_reserve = ent->reserved;
+		rc = xa_err(__xa_cmpxchg(&ent->mkeys, to_reserve, NULL,
+					 XA_ZERO_ENTRY, GFP_KERNEL));
+		if (rc)
+			return rc;
+		if (to_reserve != ent->reserved)
+			continue;
+		ent->reserved++;
+		break;
+	}
+	return 0;
+}
+
 /* Asynchronously schedule new MRs to be populated in the cache. */
 static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 {
@@ -217,23 +239,32 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 			err = -ENOMEM;
 			break;
 		}
-		spin_lock_irq(&ent->lock);
+		xa_lock_irq(&ent->mkeys);
 		if (ent->pending >= MAX_PENDING_REG_MR) {
+			xa_unlock_irq(&ent->mkeys);
 			err = -EAGAIN;
-			spin_unlock_irq(&ent->lock);
+			kfree(mr);
+			break;
+		}
+
+		err = _push_reserve_mkey(ent);
+		if (err) {
+			xa_unlock_irq(&ent->mkeys);
 			kfree(mr);
 			break;
 		}
 		ent->pending++;
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 		err = mlx5_ib_create_mkey_cb(ent->dev, &mr->mmkey,
 					     &ent->dev->async_ctx, in, inlen,
 					     mr->out, sizeof(mr->out),
 					     &mr->cb_work);
 		if (err) {
-			spin_lock_irq(&ent->lock);
+			xa_lock_irq(&ent->mkeys);
+			WARN_ON(__xa_erase(&ent->mkeys, ent->reserved--) !=
+				NULL);
 			ent->pending--;
-			spin_unlock_irq(&ent->lock);
+			xa_unlock_irq(&ent->mkeys);
 			mlx5_ib_warn(ent->dev, "create mkey failed %d\n", err);
 			kfree(mr);
 			break;
@@ -271,9 +302,9 @@ static struct mlx5_ib_mr *create_cache_mr(struct mlx5_cache_ent *ent)
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
@@ -287,39 +318,37 @@ static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_mr *mr;
 
-	lockdep_assert_held(&ent->lock);
-	if (list_empty(&ent->head))
+	if (!ent->stored)
 		return;
-	mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
-	list_del(&mr->list);
-	ent->available_mrs--;
+	mr = __xa_store(&ent->mkeys, --ent->stored, NULL, GFP_KERNEL);
+	WARN_ON(mr == NULL || xa_is_err(mr));
+	WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) != NULL);
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
@@ -347,12 +376,13 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
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
@@ -360,12 +390,12 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
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
 
@@ -405,10 +435,10 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
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
@@ -443,9 +473,9 @@ static bool someone_adding(struct mlx5_mr_cache *cache)
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
@@ -459,23 +489,21 @@ static bool someone_adding(struct mlx5_mr_cache *cache)
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
 		if (ent->pending)
@@ -492,16 +520,15 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
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
@@ -519,7 +546,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 						   msecs_to_jiffies(1000));
 			}
 		}
-	} else if (ent->available_mrs > 2 * ent->limit) {
+	} else if (ent->stored > 2 * ent->limit) {
 		bool need_delay;
 
 		/*
@@ -534,11 +561,11 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
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
@@ -547,7 +574,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		queue_adjust_cache_locked(ent);
 	}
 out:
-	spin_unlock_irq(&ent->lock);
+	xa_unlock_irq(&ent->mkeys);
 }
 
 static void delayed_cache_work_func(struct work_struct *work)
@@ -576,22 +603,23 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
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
+		mr = __xa_store(&ent->mkeys, --ent->stored, NULL,
+				GFP_KERNEL);
+		WARN_ON(mr == NULL || xa_is_err(mr));
+		WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) != NULL);
 		queue_adjust_cache_locked(ent);
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 
 		mlx5_clear_mr(mr);
 	}
@@ -602,38 +630,26 @@ static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 
-	spin_lock_irq(&ent->lock);
-	list_add_tail(&mr->list, &ent->head);
-	ent->available_mrs++;
+	xa_lock_irq(&ent->mkeys);
+	WARN_ON(__xa_store(&ent->mkeys, ent->stored++, mr, 0) != NULL);
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
+	unsigned long index;
 
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
+	xa_for_each(&ent->mkeys, index, mr) {
+		xa_lock_irq(&ent->mkeys);
+		__xa_erase(&ent->mkeys, index);
 		ent->total_mrs--;
-		spin_unlock_irq(&ent->lock);
+		xa_unlock_irq(&ent->mkeys);
 		mlx5_core_destroy_mkey(dev->mdev, mr->mmkey.key);
-	}
-
-	list_for_each_entry_safe(mr, tmp_mr, &del_list, list) {
-		list_del(&mr->list);
 		kfree(mr);
 	}
 }
@@ -665,7 +681,7 @@ static void mlx5_mr_cache_debugfs_init(struct mlx5_ib_dev *dev)
 		dir = debugfs_create_dir(ent->name, cache->root);
 		debugfs_create_file("size", 0600, dir, ent, &size_fops);
 		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
-		debugfs_create_u32("cur", 0400, dir, &ent->available_mrs);
+		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
 		debugfs_create_u32("miss", 0600, dir, &ent->miss);
 	}
 }
@@ -694,8 +710,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
 	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
 		ent = &cache->ent[i];
-		INIT_LIST_HEAD(&ent->head);
-		spin_lock_init(&ent->lock);
+		xa_init_flags(&ent->mkeys, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
 		ent->order = i + 2;
 		ent->dev = dev;
 		ent->limit = 0;
@@ -721,9 +736,9 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
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
@@ -741,9 +756,9 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
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
@@ -1886,6 +1901,17 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }
 
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
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -1932,10 +1958,10 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 
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

