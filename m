Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38B6146921B
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 10:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240369AbhLFJPn (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 04:15:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240161AbhLFJO5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 04:14:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A029C061354;
        Mon,  6 Dec 2021 01:11:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BFB65B81059;
        Mon,  6 Dec 2021 09:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A17B4C341C2;
        Mon,  6 Dec 2021 09:11:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638781886;
        bh=6zJlaNWEj82WX7WiOTXRM5cNVy90JGJ+Np924IyALkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ant+mH1X+Z0R/rK7+HO4SZkgma+XsvbQbzsRjEOThUTAOw8lLQnhKfScOgjvBNwb4
         4e37QgeDZz0sjzwxEJdJiwkygAoiXNsR3efofjz1BTGg0xipWyaWRmMY3Uaze02azE
         EikT0//Ubm1SKMh44unoTUsn8qcjBy9Q5y7E9Cv2AL/LyoeivAMZ6H491fruUM6ttL
         6dxrwjSwtHsvj6r40SNusEKHmgQQRcD8EHDRNXiSm3G2mmWYHmx0HkVV4BnOcfMh3F
         Lc9ujxLVsh8E+HXTn50GnCfnrr3r2ufFO5x0gy/D1uu6DMz+jYccfG46sPfCYL/MTS
         jKUAKeM36fKng==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 7/7] RDMA/mlx5: Rename the mkey cache variables and functions
Date:   Mon,  6 Dec 2021 11:10:52 +0200
Message-Id: <7b0077b34eebcffa477371bed10567ec34c97b6d.1638781506.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638781506.git.leonro@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 26 ++++----
 drivers/infiniband/hw/mlx5/mr.c      | 88 ++++++++++++++--------------
 drivers/infiniband/hw/mlx5/odp.c     |  8 +--
 include/linux/mlx5/driver.h          |  4 +-
 5 files changed, 66 insertions(+), 64 deletions(-)

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
index 7dcc9e69a649..54a5c4bc2919 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -753,13 +753,13 @@ struct mlx5_cache_ent {
 	u8 fill_to_high_water:1;
 
 	/*
-	 * - total_mrs is available_mrs plus all in use MRs that could be
+	 * - total_mkeys is stored mkeys plus all in use mkeys that could be
 	 *   returned to the cache.
-	 * - limit is the low water mark for available_mrs, 2* limit is the
+	 * - limit is the low water mark for available_mkeys, 2 * limit is the
 	 *   upper water mark.
-	 * - pending is the number of MRs currently being created
+	 * - pending is the number of mkeys currently being created
 	 */
-	u32 total_mrs;
+	u32 total_mkeys;
 	u32 limit;
 	u32 pending;
 
@@ -781,7 +781,7 @@ struct mlx5_async_create_mkey {
 	u32 mkey;
 };
 
-struct mlx5_mr_cache {
+struct mlx5_mkey_cache {
 	struct workqueue_struct *wq;
 	struct rb_root		cache_root;
 	struct mutex		cache_lock;
@@ -1085,7 +1085,7 @@ struct mlx5_ib_dev {
 	struct mlx5_ib_resources	devr;
 
 	atomic_t			mkey_var;
-	struct mlx5_mr_cache		cache;
+	struct mlx5_mkey_cache		cache;
 	struct timer_list		delay_timer;
 	/* Prevents soft lock on massive reg MRs */
 	struct mutex			slow_path_mutex;
@@ -1332,15 +1332,15 @@ void mlx5_ib_populate_pas(struct ib_umem *umem, size_t page_size, __be64 *pas,
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
-				       unsigned int access_mode, bool force);
+struct mlx5_ib_mr *mlx5_mkey_cache_alloc(struct mlx5_ib_dev *dev, int *in,
+					 int inlen, unsigned int ndescs,
+					 unsigned int access_mode, bool force);
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
@@ -1364,7 +1364,7 @@ int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
-int mlx5_odp_init_mr_cache_entry(struct mlx5_ib_dev *dev);
+int mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev);
 void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 			   struct mlx5_ib_mr *mr, int flags);
 
@@ -1383,7 +1383,7 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
-static inline int mlx5_odp_init_mr_cache_entry(struct mlx5_ib_dev *dev)
+static inline int mlx5_odp_init_mkey_cache_entry(struct mlx5_ib_dev *dev)
 {
 	return 0;
 }
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 29888a426b33..11e797e27873 100644
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
 			    xa_mk_value(mkey_out->mkey), GFP_ATOMIC);
 	WARN_ON(xa_ent != NULL);
 	ent->pending--;
-	ent->total_mrs++;
+	ent->total_mkeys++;
 	/* If we are doing fill_to_high_water then keep going. */
 	queue_adjust_cache_locked(ent);
 	xa_unlock_irqrestore(&ent->mkeys, flags);
@@ -279,15 +279,15 @@ static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 	xa_ent = __xa_store(&ent->mkeys, --ent->stored, NULL, GFP_KERNEL);
 	WARN_ON(xa_ent == NULL || xa_is_err(xa_ent));
 	WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) != NULL);
-	ent->total_mrs--;
+	ent->total_mkeys--;
 	xa_unlock_irq(&ent->mkeys);
 	mlx5_core_destroy_mkey(ent->dev->mdev, (u32)xa_to_value(xa_ent));
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
 
@@ -327,22 +327,22 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
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
@@ -361,7 +361,7 @@ static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
 	char lbuf[20];
 	int err;
 
-	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->total_mrs);
+	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->total_mkeys);
 	if (err < 0)
 		return err;
 
@@ -392,7 +392,7 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 	 */
 	xa_lock_irq(&ent->mkeys);
 	ent->limit = var;
-	err = resize_available_mrs(ent, 0, true);
+	err = resize_available_mkeys(ent, 0, true);
 	xa_unlock_irq(&ent->mkeys);
 	if (err)
 		return err;
@@ -421,7 +421,7 @@ static const struct file_operations limit_fops = {
 	.read	= limit_read,
 };
 
-static bool someone_adding(struct mlx5_mr_cache *cache)
+static bool someone_adding(struct mlx5_mkey_cache *cache)
 {
 	struct mlx5_cache_ent *ent;
 	struct rb_node *node;
@@ -477,7 +477,7 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 static void __cache_work_func(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_dev *dev = ent->dev;
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	int err;
 
 	xa_lock_irq(&ent->mkeys);
@@ -553,7 +553,8 @@ static void cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
-static struct mlx5_cache_ent *ent_search(struct mlx5_mr_cache *cache, void *mkc)
+static struct mlx5_cache_ent *ent_search(struct mlx5_mkey_cache *cache,
+					 void *mkc)
 {
 	struct rb_node *node = cache->cache_root.rb_node;
 	int size = MLX5_ST_SZ_BYTES(mkc);
@@ -588,9 +589,9 @@ static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
 	}
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
-				       int inlen, unsigned int ndescs,
-				       unsigned int access_mode, bool force)
+struct mlx5_ib_mr *mlx5_mkey_cache_alloc(struct mlx5_ib_dev *dev, int *in,
+					 int inlen, unsigned int ndescs,
+					 unsigned int access_mode, bool force)
 {
 	struct mlx5_cache_ent *ent = NULL;
 	struct mlx5_ib_mr *mr;
@@ -645,7 +646,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 
 			WRITE_ONCE(ent->dev->cache.last_add, jiffies);
 			xa_lock_irq(&ent->mkeys);
-			ent->total_mrs++;
+			ent->total_mkeys++;
 		} else {
 			xa_ent = __xa_store(&ent->mkeys, --ent->stored,
 					  NULL, GFP_KERNEL);
@@ -656,7 +657,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 			mr->mmkey.key = (u32)xa_to_value(xa_ent);
 		}
 		if (ent->is_tmp) {
-			ent->total_mrs--;
+			ent->total_mkeys--;
 			queue_delayed_work(dev->cache.wq,
 					   &dev->cache.remove_ent_dwork,
 					   msecs_to_jiffies(30 * 1000));
@@ -684,7 +685,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 	return ERR_PTR(err);
 }
 
-static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
+static void mlx5_mkey_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 
@@ -704,13 +705,13 @@ static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 	xa_for_each(&ent->mkeys, index, entry) {
 		xa_lock_irq(&ent->mkeys);
 		__xa_erase(&ent->mkeys, index);
-		ent->total_mrs--;
+		ent->total_mkeys--;
 		xa_unlock_irq(&ent->mkeys);
 		mlx5_core_destroy_mkey(dev->mdev, (u32)xa_to_value(entry));
 	}
 }
 
-static void mlx5_mr_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
+static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 {
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
@@ -722,7 +723,7 @@ static void mlx5_mr_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 static void mlx5_cache_ent_debugfs_init(struct mlx5_ib_dev *dev,
 					struct mlx5_cache_ent *ent, int order)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct dentry *dir;
 
 	if (!mlx5_debugfs_root || dev->is_rep)
@@ -743,7 +744,7 @@ static void delay_time_func(struct timer_list *t)
 	WRITE_ONCE(dev->fill_delay, 0);
 }
 
-static int ent_insert(struct mlx5_mr_cache *cache, struct mlx5_cache_ent *ent)
+static int ent_insert(struct mlx5_mkey_cache *cache, struct mlx5_cache_ent *ent)
 {
 	struct rb_node **new = &cache->cache_root.rb_node, *parent = NULL;
 	int size = MLX5_ST_SZ_BYTES(mkc);
@@ -812,11 +813,12 @@ static struct mlx5_cache_ent *mlx5_ib_create_cache_ent(struct mlx5_ib_dev *dev,
 
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
@@ -825,7 +827,7 @@ static void remove_ent_work_func(struct work_struct *work)
 		mutex_unlock(&cache->cache_lock);
 
 		xa_lock_irq(&ent->mkeys);
-		if (!ent->is_tmp || ent->total_mrs != ent->stored) {
+		if (!ent->is_tmp || ent->total_mkeys != ent->stored) {
 			xa_unlock_irq(&ent->mkeys);
 			mutex_lock(&cache->cache_lock);
 			continue;
@@ -842,9 +844,9 @@ static void remove_ent_work_func(struct work_struct *work)
 	mutex_unlock(&cache->cache_lock);
 }
 
-int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
+int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
 	int order, err;
 
@@ -869,7 +871,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
-	for (order = 2; order < MAX_MR_CACHE_ENTRIES + 2; order++) {
+	for (order = 2; order < MAX_MKEY_CACHE_ENTRIES + 2; order++) {
 		ent = mlx5_ib_create_cache_ent(dev, order);
 
 		if (IS_ERR(ent)) {
@@ -878,7 +880,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 		}
 
 		if (cache->maintained_cache &&
-		    order <= mr_cache_max_order(dev)) {
+		    order <= mkey_cache_max_order(dev)) {
 			ent->limit =
 				dev->mdev->profile.mr_cache[order - 2].limit;
 			xa_lock_irq(&ent->mkeys);
@@ -889,11 +891,11 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 
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
@@ -913,7 +915,7 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 		cancel_delayed_work_sync(&ent->dwork);
 	}
 
-	mlx5_mr_cache_debugfs_cleanup(dev);
+	mlx5_mkey_cache_debugfs_cleanup(dev);
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
 	node = rb_first(root);
@@ -991,10 +993,10 @@ static int get_octo_len(u64 addr, u64 len, int page_shift)
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
 
@@ -1116,7 +1118,7 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 			   mlx5_acc_flags_to_ent_flags(dev, access_flags),
 			   MLX5_MKC_ACCESS_MODE_MTT, PAGE_SHIFT);
 
-	mr = mlx5_mr_cache_alloc(
+	mr = mlx5_mkey_cache_alloc(
 		dev, in, inlen, ndescs, MLX5_MKC_ACCESS_MODE_MTT,
 		!mlx5_ib_can_reconfig_with_umr(dev, access_flags, 0));
 	if (IS_ERR(mr)) {
@@ -2115,7 +2117,7 @@ create_tmp_cache_ent(struct mlx5_ib_dev *dev, void *mkc, unsigned int ndescs)
 
 static void tmp_cache_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
+	struct mlx5_mkey_cache *cache = &dev->cache;
 	struct ib_umem *umem = mr->umem;
 	struct mlx5_cache_ent *ent;
 	void *mkc;
@@ -2150,7 +2152,7 @@ static void tmp_cache_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		mutex_unlock(&cache->cache_lock);
 		return;
 	}
-	ent->total_mrs++;
+	ent->total_mkeys++;
 	xa_unlock_irq(&ent->mkeys);
 	queue_delayed_work(cache->wq, &cache->remove_ent_dwork,
 			   msecs_to_jiffies(30 * 1000));
@@ -2209,7 +2211,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	if (mr->cache_ent) {
 		if (revoke_mr(mr) || push_reserve_mkey(mr->cache_ent)) {
 			xa_lock_irq(&mr->cache_ent->mkeys);
-			mr->cache_ent->total_mrs--;
+			mr->cache_ent->total_mkeys--;
 			xa_unlock_irq(&mr->cache_ent->mkeys);
 			mr->cache_ent = NULL;
 		}
@@ -2232,7 +2234,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	if (mr->cache_ent)
-		mlx5_mr_cache_free(dev, mr);
+		mlx5_mkey_cache_free(dev, mr);
 	else
 		mlx5_free_priv_descs(mr);
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 3d86a448ec97..25328abaedc9 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -434,8 +434,8 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 			   mlx5_acc_flags_to_ent_flags(dev, imr->access_flags),
 			   MLX5_MKC_ACCESS_MODE_MTT, PAGE_SHIFT);
 
-	mr = mlx5_mr_cache_alloc(dev, in, inlen, MLX5_IMR_MTT_ENTRIES,
-				 MLX5_MKC_ACCESS_MODE_MTT, true);
+	mr = mlx5_mkey_cache_alloc(dev, in, inlen, MLX5_IMR_MTT_ENTRIES,
+				   MLX5_MKC_ACCESS_MODE_MTT, true);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
 		kfree(in);
@@ -528,8 +528,8 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 			   mlx5_acc_flags_to_ent_flags(dev, access_flags),
 			   MLX5_MKC_ACCESS_MODE_KSM, PAGE_SHIFT);
 
-	imr = mlx5_mr_cache_alloc(dev, in, inlen, mlx5_imr_ksm_entries,
-				  MLX5_MKC_ACCESS_MODE_KSM, true);
+	imr = mlx5_mkey_cache_alloc(dev, in, inlen, mlx5_imr_ksm_entries,
+				    MLX5_MKC_ACCESS_MODE_KSM, true);
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

