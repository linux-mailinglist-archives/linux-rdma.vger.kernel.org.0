Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 893A0481BB4
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:24:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238922AbhL3LYA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:24:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238945AbhL3LYA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:24:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D508C06173E;
        Thu, 30 Dec 2021 03:23:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26A76B81B77;
        Thu, 30 Dec 2021 11:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 192BFC36AEA;
        Thu, 30 Dec 2021 11:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863436;
        bh=UlzqUewHmi3ptYof/nBz9OvfZw61xGmQG2sgZLa2lS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DTOmdl96Wy6vvCkONjpMNQ2z3dkioX8q294IlqW7bm/ljUBC8SMZAuNqEqK2I9ACS
         cY+emOfbqI3OzjxW6/DhKP2L3IvcYB2VJRzx0HKoKOjnM4q9YkJrjWz5B1prNAC7Mq
         K9qNS2Ynn/+c5qGDLyZWxKXi5/vAex1PY+VO+ljUIZv6J5whPbTVSjP99zDJulchO/
         eMkjjdLQo9+oYlUrpPk02HuBVY8hxpx2YU9XjBQf9RIV3OZZQ4c9FO6LVzal9XB/cC
         EzAo0qL9HtESOo7YDRyAVaSnnXRjEI0SkIPl9D2OIaEdSmz2TUD86vYKmnvvTEHhXf
         Xa3P9PQIQFglQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 7/7] RDMA/mlx5: Rename the mkey cache variables and functions
Date:   Thu, 30 Dec 2021 13:23:24 +0200
Message-Id: <28648c91910327fe712f9f178e80948ecc2224c4.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640862842.git.leonro@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

After replacing the MR cache with an Mkey cache, rename the variables
and functions to fit the new meaning.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    |  4 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 20 +++---
 drivers/infiniband/hw/mlx5/mr.c      | 97 ++++++++++++++--------------
 drivers/infiniband/hw/mlx5/odp.c     |  8 +--
 include/linux/mlx5/driver.h          |  4 +-
 5 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5ec8bd2f0b2f..74f32b563109 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4034,7 +4034,7 @@ static void mlx5_ib_stage_pre_ib_reg_umr_cleanup(struct mlx5_ib_dev *dev)
 {
 	int err;
 
-	err = mlx5_mr_cache_cleanup(dev);
+	err = mlx5_mkey_cache_cleanup(dev);
 	if (err)
 		mlx5_ib_warn(dev, "mr cache cleanup failed\n");
 
@@ -4131,7 +4131,7 @@ static int mlx5_ib_stage_post_ib_reg_umr_init(struct mlx5_ib_dev *dev)
 	dev->umrc.pd = pd;
 
 	sema_init(&dev->umrc.sem, MAX_UMR_WR);
-	ret = mlx5_mr_cache_init(dev);
+	ret = mlx5_mkey_cache_init(dev);
 	if (ret) {
 		mlx5_ib_warn(dev, "mr cache init failed %d\n", ret);
 		goto error_4;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 8ebe1edce190..93065492dcb8 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -752,12 +752,12 @@ struct mlx5_cache_ent {
 	u8 fill_to_high_water:1;
 
 	/*
-	 * - total_mrs is available_mrs plus all in use MRs that could be
+	 * - total_mkeys is stored mkeys plus all in use mkeys that could be
 	 *   returned to the cache.
-	 * - limit is the low water mark for available_mrs, 2* limit is the
+	 * - limit is the low water mark for available_mkeys, 2 * limit is the
 	 *   upper water mark.
 	 */
-	u32 total_mrs;
+	u32 total_mkeys;
 	u32 limit;
 
 	/* Statistics */
@@ -778,7 +778,7 @@ struct mlx5_async_create_mkey {
 	u32 mkey;
 };
 
-struct mlx5_mr_cache {
+struct mlx5_mkey_cache {
 	struct workqueue_struct *wq;
 	struct rb_root		cache_root;
 	struct mutex		cache_lock;
@@ -1081,7 +1081,7 @@ struct mlx5_ib_dev {
 	struct mlx5_ib_resources	devr;
 
 	atomic_t			mkey_var;
-	struct mlx5_mr_cache		cache;
+	struct mlx5_mkey_cache		cache;
 	struct timer_list		delay_timer;
 	/* Prevents soft lock on massive reg MRs */
 	struct mutex			slow_path_mutex;
@@ -1328,15 +1328,15 @@ void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
 			  u64 access_flags);
 void mlx5_ib_copy_pas(u64 *old, u64 *new, int step, int num);
 int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
-int mlx5_mr_cache_init(struct mlx5_ib_dev *dev);
-int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
+int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev);
+int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev);
 
 int mlx5_acc_flags_to_ent_flags(struct mlx5_ib_dev *dev, int access_flags);
 void mlx5_set_cache_mkc(struct mlx5_ib_dev *dev, void *mkc, int access_flags,
 			unsigned int access_mode, unsigned int page_shift);
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
-				       int inlen, unsigned int ndescs,
-				       unsigned int access_mode);
+struct mlx5_ib_mr *mlx5_mkey_cache_alloc(struct mlx5_ib_dev *dev, int *in,
+					 int inlen, unsigned int ndescs,
+					 unsigned int access_mode);
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 43e993b360d8..827de5fa244d 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -123,7 +123,7 @@ mlx5_ib_create_mkey_cb(struct mlx5_ib_dev *dev, u32 *mkey,
 				create_mkey_callback, context);
 }
 
-static int mr_cache_max_order(struct mlx5_ib_dev *dev);
+static int mkey_cache_max_order(struct mlx5_ib_dev *dev);
 static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent);
 
 static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
@@ -169,7 +169,7 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 			 GFP_ATOMIC);
 	WARN_ON(old != NULL);
 	ent->stored++;
-	ent->total_mrs++;
+	ent->total_mkeys++;
 	/* If we are doing fill_to_high_water then keep going. */
 	queue_adjust_cache_locked(ent);
 	xa_unlock_irqrestore(&ent->mkeys, flags);
@@ -300,7 +300,7 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 	return err;
 }
 
-static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
+static void remove_cache_mkey_locked(struct mlx5_cache_ent *ent)
 {
 	void *old, *xa_mkey;
 
@@ -313,15 +313,15 @@ static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 	ent->reserved--;
 	old = __xa_erase(&ent->mkeys, ent->reserved);
 	WARN_ON(old != NULL);
-	ent->total_mrs--;
+	ent->total_mkeys--;
 	xa_unlock_irq(&ent->mkeys);
 	mlx5_core_destroy_mkey(ent->dev->mdev, (u32)xa_to_value(xa_mkey));
 	xa_lock_irq(&ent->mkeys);
 }
 
-static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
-				bool limit_fill)
-	 __acquires(&ent->lock) __releases(&ent->lock)
+static int resize_available_mkeys(struct mlx5_cache_ent *ent,
+				  unsigned int target, bool limit_fill)
+	__acquires(&ent->lock) __releases(&ent->lock)
 {
 	int err;
 
@@ -344,7 +344,7 @@ static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
 			} else
 				return 0;
 		} else {
-			remove_cache_mr_locked(ent);
+			remove_cache_mkey_locked(ent);
 		}
 	}
 }
@@ -361,22 +361,22 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 		return err;
 
 	/*
-	 * Target is the new value of total_mrs the user requests, however we
+	 * Target is the new value of total_mkeys the user requests, however we
 	 * cannot free MRs that are in use. Compute the target value for
-	 * available_mrs.
+	 * available_mkeys.
 	 */
 
 	xa_lock_irq(&ent->mkeys);
-	if (target < ent->total_mrs - ent->stored) {
+	if (target < ent->total_mkeys - ent->stored) {
 		err = -EINVAL;
 		goto err_unlock;
 	}
-	target = target - (ent->total_mrs - ent->stored);
+	target = target - (ent->total_mkeys - ent->stored);
 	if (target < ent->limit || target > ent->limit*2) {
 		err = -EINVAL;
 		goto err_unlock;
 	}
-	err = resize_available_mrs(ent, target, false);
+	err = resize_available_mkeys(ent, target, false);
 	if (err)
 		goto err_unlock;
 	xa_unlock_irq(&ent->mkeys);
@@ -395,7 +395,7 @@ static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
 	char lbuf[20];
 	int err;
 
-	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->total_mrs);
+	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->total_mkeys);
 	if (err < 0)
 		return err;
 
@@ -426,7 +426,7 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 	 */
 	xa_lock_irq(&ent->mkeys);
 	ent->limit = var;
-	err = resize_available_mrs(ent, 0, true);
+	err = resize_available_mkeys(ent, 0, true);
 	xa_unlock_irq(&ent->mkeys);
 	if (err)
 		return err;
@@ -454,7 +454,7 @@ static const struct file_operations limit_fops = {
 	.read	= limit_read,
 };
 
-static bool someone_adding(struct mlx5_mr_cache *cache)
+static bool someone_adding(struct mlx5_mkey_cache *cache)
 {
 	struct mlx5_cache_ent *ent;
 	struct rb_node *node;
@@ -510,7 +510,7 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 static void __cache_work_func(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_dev *dev = ent->dev;
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	int err;
 
 	xa_lock_irq(&ent->mkeys);
@@ -563,7 +563,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 			goto out;
 		if (need_delay)
 			queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
-		remove_cache_mr_locked(ent);
+		remove_cache_mkey_locked(ent);
 		queue_adjust_cache_locked(ent);
 	}
 out:
@@ -586,7 +586,7 @@ static void cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
-static int mlx5_cache_ent_insert_locked(struct mlx5_mr_cache *cache,
+static int mlx5_cache_ent_insert_locked(struct mlx5_mkey_cache *cache,
 					struct mlx5_cache_ent *ent)
 {
 	struct rb_node **new = &cache->cache_root.rb_node, *parent = NULL;
@@ -621,7 +621,7 @@ static int mlx5_cache_ent_insert_locked(struct mlx5_mr_cache *cache,
 }
 
 static struct mlx5_cache_ent *
-mlx5_cache_find_smallest_ent(struct mlx5_mr_cache *cache, void *mkc,
+mlx5_cache_find_smallest_ent(struct mlx5_mkey_cache *cache, void *mkc,
 			     unsigned int lower_bound, unsigned int upper_bound)
 {
 	struct rb_node *node = cache->cache_root.rb_node;
@@ -675,7 +675,7 @@ static void mlx5_ent_get_mkey_locked(struct mlx5_cache_ent *ent,
 	if (!ent->is_tmp)
 		mr->mmkey.cache_ent = ent;
 	else {
-		ent->total_mrs--;
+		ent->total_mkeys--;
 		cancel_delayed_work(&ent->dev->cache.remove_ent_dwork);
 		queue_delayed_work(ent->dev->cache.wq,
 				   &ent->dev->cache.remove_ent_dwork,
@@ -683,7 +683,7 @@ static void mlx5_ent_get_mkey_locked(struct mlx5_cache_ent *ent,
 	}
 }
 
-static bool mlx5_cache_get_mkey(struct mlx5_mr_cache *cache, void *mkc,
+static bool mlx5_cache_get_mkey(struct mlx5_mkey_cache *cache, void *mkc,
 				unsigned int ndescs, struct mlx5_ib_mr *mr)
 {
 	size_t size = MLX5_ST_SZ_BYTES(mkc);
@@ -734,9 +734,9 @@ static bool mlx5_cache_get_mkey(struct mlx5_mr_cache *cache, void *mkc,
 	return false;
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
-				       int inlen, unsigned int ndescs,
-				       unsigned int access_mode)
+struct mlx5_ib_mr *mlx5_mkey_cache_alloc(struct mlx5_ib_dev *dev, int *in,
+					 int inlen, unsigned int ndescs,
+					 unsigned int access_mode)
 {
 	struct mlx5_ib_mr *mr;
 	void *mkc;
@@ -770,7 +770,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 	return ERR_PTR(err);
 }
 
-static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
+static void mlx5_mkey_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 	void *old;
@@ -794,7 +794,7 @@ static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 		ent->stored--;
 		xa_mkey = __xa_erase(&ent->mkeys, ent->stored);
 		WARN_ON(xa_mkey == NULL);
-		ent->total_mrs--;
+		ent->total_mkeys--;
 		xa_unlock_irq(&ent->mkeys);
 		mlx5_core_destroy_mkey(dev->mdev, (u32)xa_to_value(xa_mkey));
 		xa_lock_irq(&ent->mkeys);
@@ -802,7 +802,7 @@ static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 	xa_unlock_irq(&ent->mkeys);
 }
 
-static void mlx5_mr_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
+static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 {
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
@@ -814,7 +814,7 @@ static void mlx5_mr_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 static void mlx5_cache_ent_debugfs_init(struct mlx5_ib_dev *dev,
 					struct mlx5_cache_ent *ent, int order)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct dentry *dir;
 
 	if (!mlx5_debugfs_root || dev->is_rep)
@@ -876,11 +876,12 @@ static struct mlx5_cache_ent *mlx5_ib_create_cache_ent(struct mlx5_ib_dev *dev,
 
 static void remove_ent_work_func(struct work_struct *work)
 {
-	struct mlx5_mr_cache *cache;
+	struct mlx5_mkey_cache *cache;
 	struct mlx5_cache_ent *ent;
 	struct rb_node *cur;
 
-	cache = container_of(work, struct mlx5_mr_cache, remove_ent_dwork.work);
+	cache = container_of(work, struct mlx5_mkey_cache,
+			     remove_ent_dwork.work);
 	mutex_lock(&cache->cache_lock);
 	cur = rb_last(&cache->cache_root);
 	while (cur) {
@@ -889,8 +890,8 @@ static void remove_ent_work_func(struct work_struct *work)
 		mutex_unlock(&cache->cache_lock);
 
 		xa_lock_irq(&ent->mkeys);
-		if (!ent->is_tmp || ent->total_mrs != ent->stored) {
-			if (ent->total_mrs != ent->stored)
+		if (!ent->is_tmp || ent->total_mkeys != ent->stored) {
+			if (ent->total_mkeys != ent->stored)
 				queue_delayed_work(cache->wq,
 						   &cache->remove_ent_dwork,
 						   msecs_to_jiffies(30 * 1000));
@@ -910,9 +911,9 @@ static void remove_ent_work_func(struct work_struct *work)
 	mutex_unlock(&cache->cache_lock);
 }
 
-int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
+int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	bool can_use_cache, need_cache;
 	struct mlx5_cache_ent *ent;
 	int order, err;
@@ -937,7 +938,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
-	for (order = 2; order < MAX_MR_CACHE_ENTRIES + 2; order++) {
+	for (order = 2; order < MAX_MKEY_CACHE_ENTRIES + 2; order++) {
 		ent = mlx5_ib_create_cache_ent(dev, order);
 
 		if (IS_ERR(ent)) {
@@ -946,7 +947,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 		}
 
 		if (can_use_cache && need_cache &&
-		    order <= mr_cache_max_order(dev)) {
+		    order <= mkey_cache_max_order(dev)) {
 			ent->limit =
 				dev->mdev->profile.mr_cache[order - 2].limit;
 			xa_lock_irq(&ent->mkeys);
@@ -957,11 +958,11 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 
 	return 0;
 err:
-	mlx5_mr_cache_cleanup(dev);
+	mlx5_mkey_cache_cleanup(dev);
 	return err;
 }
 
-int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
+int mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 {
 	struct rb_root *root = &dev->cache.cache_root;
 	struct mlx5_cache_ent *ent;
@@ -981,7 +982,7 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 		cancel_delayed_work_sync(&ent->dwork);
 	}
 
-	mlx5_mr_cache_debugfs_cleanup(dev);
+	mlx5_mkey_cache_debugfs_cleanup(dev);
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
 	node = rb_first(root);
@@ -1059,10 +1060,10 @@ static int get_octo_len(u64 addr, u64 len, int page_shift)
 	return (npages + 1) / 2;
 }
 
-static int mr_cache_max_order(struct mlx5_ib_dev *dev)
+static int mkey_cache_max_order(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
-		return MAX_MR_CACHE_ENTRIES + 2;
+		return MAX_MKEY_CACHE_ENTRIES + 2;
 	return MLX5_MAX_UMR_SHIFT;
 }
 
@@ -1184,8 +1185,8 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 			   mlx5_acc_flags_to_ent_flags(dev, access_flags),
 			   MLX5_MKC_ACCESS_MODE_MTT, PAGE_SHIFT);
 
-	mr = mlx5_mr_cache_alloc(dev, in, inlen, ndescs,
-				 MLX5_MKC_ACCESS_MODE_MTT);
+	mr = mlx5_mkey_cache_alloc(dev, in, inlen, ndescs,
+				   MLX5_MKC_ACCESS_MODE_MTT);
 	if (IS_ERR(mr)) {
 		kfree(in);
 		return mr;
@@ -2173,7 +2174,7 @@ static struct mlx5_cache_ent *mlx5_cache_create_tmp_ent(struct mlx5_ib_dev *dev,
 static void mlx5_cache_tmp_push_mkey(struct mlx5_ib_dev *dev,
 				     struct mlx5_ib_mr *mr)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct ib_umem *umem = mr->umem;
 	struct mlx5_cache_ent *ent;
 	void *mkc;
@@ -2207,7 +2208,7 @@ static void mlx5_cache_tmp_push_mkey(struct mlx5_ib_dev *dev,
 		mutex_unlock(&cache->cache_lock);
 		return;
 	}
-	ent->total_mrs++;
+	ent->total_mkeys++;
 	xa_unlock_irq(&ent->mkeys);
 	cancel_delayed_work(&cache->remove_ent_dwork);
 	queue_delayed_work(cache->wq, &cache->remove_ent_dwork,
@@ -2267,7 +2268,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (mr->mmkey.cache_ent) {
 		if (revoke_mr(mr) || push_reserve_mkey(mr->mmkey.cache_ent)) {
 			xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
-			mr->mmkey.cache_ent->total_mrs--;
+			mr->mmkey.cache_ent->total_mkeys--;
 			xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
 			mr->mmkey.cache_ent = NULL;
 		}
@@ -2290,7 +2291,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	if (mr->mmkey.cache_ent)
-		mlx5_mr_cache_free(dev, mr);
+		mlx5_mkey_cache_free(dev, mr);
 	else
 		mlx5_free_priv_descs(mr);
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 89aaf783fe25..ddb5f77905d5 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -434,8 +434,8 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 			   mlx5_acc_flags_to_ent_flags(dev, imr->access_flags),
 			   MLX5_MKC_ACCESS_MODE_MTT, PAGE_SHIFT);
 
-	mr = mlx5_mr_cache_alloc(dev, in, inlen, MLX5_IMR_MTT_ENTRIES,
-				 MLX5_MKC_ACCESS_MODE_MTT);
+	mr = mlx5_mkey_cache_alloc(dev, in, inlen, MLX5_IMR_MTT_ENTRIES,
+				   MLX5_MKC_ACCESS_MODE_MTT);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
 		kfree(in);
@@ -528,8 +528,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 			   mlx5_acc_flags_to_ent_flags(dev, access_flags),
 			   MLX5_MKC_ACCESS_MODE_KSM, PAGE_SHIFT);
 
-	imr = mlx5_mr_cache_alloc(dev, in, inlen, mlx5_imr_ksm_entries,
-				  MLX5_MKC_ACCESS_MODE_KSM);
+	imr = mlx5_mkey_cache_alloc(dev, in, inlen, mlx5_imr_ksm_entries,
+				    MLX5_MKC_ACCESS_MODE_KSM);
 	if (IS_ERR(imr)) {
 		ib_umem_odp_release(umem_odp);
 		kfree(in);
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index c33f71134136..51b30c11116e 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -699,7 +699,7 @@ enum {
 };
 
 enum {
-	MAX_MR_CACHE_ENTRIES = 21,
+	MAX_MKEY_CACHE_ENTRIES = 21,
 };
 
 struct mlx5_profile {
@@ -708,7 +708,7 @@ struct mlx5_profile {
 	struct {
 		int	size;
 		int	limit;
-	} mr_cache[MAX_MR_CACHE_ENTRIES];
+	} mr_cache[MAX_MKEY_CACHE_ENTRIES];
 };
 
 struct mlx5_hca_cap {
-- 
2.33.1

