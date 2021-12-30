Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C06C481BB0
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238937AbhL3LXv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:23:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60720 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238932AbhL3LXu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:23:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 649F0B81B77;
        Thu, 30 Dec 2021 11:23:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA908C36AEC;
        Thu, 30 Dec 2021 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863428;
        bh=ooa+ky9uXWJXZ9hhIlXGJTlGD0ylWiSti1Ie4Vbuwz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m8oM1g/zzfQKdmjtXB3hJocW3qWCB7EufzPLEJKBdxz/NfnGKO98clG+hxBympVdJ
         zU3ImgBXzyNnZV2D/meCwa1zyXI5bSxTgtUCAmXi3K7gpax1ORsuXz2c3oNYB6xDyV
         cP/0HbcPVFdpdjc0fL7OGG9hbpcwBlrwfkhr5Vy7jlhqRkDs9qhi72FGY7LzVgmsCu
         R7nbeDoZ5Whno1gtbzbHb+2+yJIjjtz/isWgt8WAyKy2P3G9eHLMsu0cTnSVNOoKtW
         RpQXywBGyC5+J94WXC9KJPc001uDj2NqLX5bmZDiFWOE6/L/kZs5cM/qQjfMDdjpTT
         QOTMxiDextKpQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 5/7] RDMA/mlx5: Change the cache structure to an RB-tree
Date:   Thu, 30 Dec 2021 13:23:22 +0200
Message-Id: <46970c6c09eef71128de04f02ed6afd2dc716443.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640862842.git.leonro@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Currently, the cache structure is a linear array held within
mlx5_ib_dev. Therefore, limits to the number of entries.

The existing entries are dedicated to mkeys of size 2^x and with no
access_flags and later in the series, we allow caching mkeys with
different attributes.

In this patch, we change the cache structure to an RB-tree of Xarray
of mkeys. The tree key is the mkc used to create the stored mkeys.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  22 +-
 drivers/infiniband/hw/mlx5/mr.c      | 486 ++++++++++++++++++---------
 drivers/infiniband/hw/mlx5/odp.c     |  71 ++--
 include/linux/mlx5/driver.h          |   5 +-
 4 files changed, 381 insertions(+), 203 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index cfc77d43c7a8..ce1f48cc8370 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -744,10 +744,7 @@ struct mlx5_cache_ent {
 	unsigned long		reserved;
 
 	char                    name[4];
-	u32                     order;
-	u32			xlt;
-	u32			access_mode;
-	u32			page;
+	unsigned int		ndescs;
 
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
@@ -767,6 +764,9 @@ struct mlx5_cache_ent {
 	struct mlx5_ib_dev     *dev;
 	struct work_struct	work;
 	struct delayed_work	dwork;
+
+	struct rb_node		node;
+	void			*mkc;
 };
 
 struct mlx5_async_create_mkey {
@@ -778,7 +778,8 @@ struct mlx5_async_create_mkey {
 
 struct mlx5_mr_cache {
 	struct workqueue_struct *wq;
-	struct mlx5_cache_ent	ent[MAX_MR_CACHE_ENTRIES];
+	struct rb_root		cache_root;
+	struct mutex		cache_lock;
 	struct dentry		*root;
 	unsigned long		last_add;
 };
@@ -1327,9 +1328,12 @@ int mlx5_ib_get_cqe_size(struct ib_cq *ibcq);
 int mlx5_mr_cache_init(struct mlx5_ib_dev *dev);
 int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev);
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags);
+int mlx5_acc_flags_to_ent_flags(struct mlx5_ib_dev *dev, int access_flags);
+void mlx5_set_cache_mkc(struct mlx5_ib_dev *dev, void *mkc, int access_flags,
+			unsigned int access_mode, unsigned int page_shift);
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
+				       int inlen, unsigned int ndescs,
+				       unsigned int access_mode);
 
 int mlx5_ib_check_mr_status(struct ib_mr *ibmr, u32 check_mask,
 			    struct ib_mr_status *mr_status);
@@ -1353,7 +1357,6 @@ int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
 int __init mlx5_ib_odp_init(void);
 void mlx5_ib_odp_cleanup(void);
-void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent);
 void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 			   struct mlx5_ib_mr *mr, int flags);
 
@@ -1372,7 +1375,6 @@ static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 static inline void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev) {}
 static inline int mlx5_ib_odp_init(void) { return 0; }
 static inline void mlx5_ib_odp_cleanup(void)				    {}
-static inline void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent) {}
 static inline void mlx5_odp_populate_xlt(void *xlt, size_t idx, size_t nentries,
 					 struct mlx5_ib_mr *mr, int flags) {}
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 182bdd537e43..631bb12697fd 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -176,16 +176,16 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 	kfree(mkey_out);
 }
 
-static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
+void mlx5_set_cache_mkc(struct mlx5_ib_dev *dev, void *mkc, int access_flags,
+			unsigned int access_mode, unsigned int page_shift)
 {
-	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
+	set_mkc_access_pd_addr_fields(mkc, access_flags, 0, dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
-	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
-	MLX5_SET(mkc, mkc, access_mode_4_2, (ent->access_mode >> 2) & 0x7);
+	MLX5_SET(mkc, mkc, access_mode_1_0, access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (access_mode >> 2) & 0x7);
 
-	MLX5_SET(mkc, mkc, translations_octword_size, ent->xlt);
-	MLX5_SET(mkc, mkc, log_page_size, ent->page);
+	MLX5_SET(mkc, mkc, log_page_size, page_shift);
 }
 
 static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
@@ -224,6 +224,19 @@ static int push_reserve_mkey(struct mlx5_cache_ent *ent)
 	return ret;
 }
 
+static int get_mkc_octo_size(unsigned int access_mode, unsigned int ndescs)
+{
+	if (access_mode == MLX5_MKC_ACCESS_MODE_MTT)
+		return DIV_ROUND_UP(ndescs, MLX5_IB_UMR_OCTOWORD /
+						    sizeof(struct mlx5_mtt));
+	if (access_mode == MLX5_MKC_ACCESS_MODE_KSM)
+		return DIV_ROUND_UP(ndescs, MLX5_IB_UMR_OCTOWORD /
+						    sizeof(struct mlx5_klm));
+
+	WARN_ON(1);
+	return 0;
+}
+
 /* Asynchronously schedule new MRs to be populated in the cache. */
 static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 {
@@ -239,7 +252,9 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 		return -ENOMEM;
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	set_cache_mkc(ent, mkc);
+	memcpy(mkc, ent->mkc, MLX5_ST_SZ_BYTES(mkc));
+	MLX5_SET(mkc, mkc, translations_octword_size,
+		 get_mkc_octo_size(MLX5_MKC_ACCESS_MODE_MTT, ent->ndescs));
 	for (i = 0; i < num; i++) {
 		async_out = kzalloc(sizeof(struct mlx5_async_create_mkey),
 				    GFP_KERNEL);
@@ -285,33 +300,6 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 	return err;
 }
 
-/* Synchronously create a MR in the cache */
-static int create_cache_mkey(struct mlx5_cache_ent *ent, u32 *mkey)
-{
-	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	void *mkc;
-	u32 *in;
-	int err;
-
-	in = kzalloc(inlen, GFP_KERNEL);
-	if (!in)
-		return -ENOMEM;
-	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
-	set_cache_mkc(ent, mkc);
-
-	err = mlx5_core_create_mkey(ent->dev->mdev, mkey, in, inlen);
-	if (err)
-		goto free_in;
-
-	WRITE_ONCE(ent->dev->cache.last_add, jiffies);
-	xa_lock_irq(&ent->mkeys);
-	ent->total_mrs++;
-	xa_unlock_irq(&ent->mkeys);
-free_in:
-	kfree(in);
-	return err;
-}
-
 static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 {
 	void *old, *xa_mkey;
@@ -468,18 +456,22 @@ static const struct file_operations limit_fops = {
 
 static bool someone_adding(struct mlx5_mr_cache *cache)
 {
-	unsigned int i;
-
-	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
-		struct mlx5_cache_ent *ent = &cache->ent[i];
-		bool ret;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+	bool ret;
 
+	mutex_lock(&cache->cache_lock);
+	for (node = rb_first(&cache->cache_root); node; node = rb_next(node)) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		ret = ent->stored < ent->limit;
 		xa_unlock_irq(&ent->mkeys);
-		if (ret)
+		if (ret) {
+			mutex_unlock(&cache->cache_lock);
 			return true;
+		}
 	}
+	mutex_unlock(&cache->cache_lock);
 	return false;
 }
 
@@ -541,8 +533,8 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 			if (err != -EAGAIN) {
 				mlx5_ib_warn(
 					dev,
-					"command failed order %d, err %d\n",
-					ent->order, err);
+					"command failed order %s, err %d\n",
+					ent->name, err);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(1000));
 			}
@@ -594,51 +586,177 @@ static void cache_work_func(struct work_struct *work)
 	__cache_work_func(ent);
 }
 
-struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
-				       struct mlx5_cache_ent *ent,
-				       int access_flags)
+static int mlx5_cache_ent_insert_locked(struct mlx5_mr_cache *cache,
+					struct mlx5_cache_ent *ent)
+{
+	struct rb_node **new = &cache->cache_root.rb_node, *parent = NULL;
+	size_t size = MLX5_ST_SZ_BYTES(mkc);
+	struct mlx5_cache_ent *cur;
+	int cmp;
+
+	/* Figure out where to put new node */
+	while (*new) {
+		cur = rb_entry(*new, struct mlx5_cache_ent, node);
+		parent = *new;
+		cmp = memcmp(ent->mkc, cur->mkc, size);
+		if (cmp < 0)
+			new = &((*new)->rb_left);
+		if (cmp > 0)
+			new = &((*new)->rb_right);
+		if (cmp == 0) {
+			if (ent->ndescs < cur->ndescs)
+				new = &((*new)->rb_left);
+			if (ent->ndescs > cur->ndescs)
+				new = &((*new)->rb_right);
+			if (ent->ndescs == cur->ndescs)
+				return -EEXIST;
+		}
+	}
+
+	/* Add new node and rebalance tree. */
+	rb_link_node(&ent->node, parent, new);
+	rb_insert_color(&ent->node, &cache->cache_root);
+
+	return 0;
+}
+
+static struct mlx5_cache_ent *
+mlx5_cache_find_smallest_ent(struct mlx5_mr_cache *cache, void *mkc,
+			     unsigned int lower_bound, unsigned int upper_bound)
 {
-	struct mlx5_ib_mr *mr;
-	void *old, *xa_mkey;
-	int err;
+	struct rb_node *node = cache->cache_root.rb_node;
+	struct mlx5_cache_ent *cur, *smallest = NULL;
+	size_t size = MLX5_ST_SZ_BYTES(mkc);
+	int cmp;
 
-	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
-		return ERR_PTR(-EOPNOTSUPP);
+	/*
+	 * Find the smallest node within the boundaries.
+	 */
+	while (node) {
+		cur = rb_entry(node, struct mlx5_cache_ent, node);
+		cmp = memcmp(mkc, cur->mkc, size);
+
+		if (cmp < 0)
+			node = node->rb_left;
+		if (cmp > 0)
+			node = node->rb_right;
+		if (cmp == 0) {
+			if ((upper_bound >= cur->ndescs) &&
+			    (cur->ndescs >= lower_bound))
+				smallest = cur;
+
+			if (cur->ndescs > lower_bound)
+				node = node->rb_left;
+			if (cur->ndescs < lower_bound)
+				node = node->rb_right;
+			if (cur->ndescs == lower_bound)
+				return cur;
+		}
+	}
 
-	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
-	if (!mr)
-		return ERR_PTR(-ENOMEM);
+	return smallest;
+}
+
+static void mlx5_ent_get_mkey_locked(struct mlx5_cache_ent *ent,
+				     struct mlx5_ib_mr *mr)
+{
+	void *xa_mkey, *old;
+
+	ent->stored--;
+	xa_mkey = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY,
+			     GFP_KERNEL);
+	WARN_ON(xa_mkey == NULL || xa_is_err(xa_mkey));
+	ent->reserved--;
+	old = __xa_erase(&ent->mkeys, ent->reserved);
+	WARN_ON(old != NULL);
+	queue_adjust_cache_locked(ent);
+	mr->mmkey.key = (u32)xa_to_value(xa_mkey);
+	mr->mmkey.cache_ent = ent;
+}
+
+static bool mlx5_cache_get_mkey(struct mlx5_mr_cache *cache, void *mkc,
+				unsigned int ndescs, struct mlx5_ib_mr *mr)
+{
+	size_t size = MLX5_ST_SZ_BYTES(mkc);
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
+	unsigned int order;
+	int cmp;
+
+	order = order_base_2(ndescs) > 2 ? order_base_2(ndescs) : 2;
+
+	mutex_lock(&cache->cache_lock);
+	ent = mlx5_cache_find_smallest_ent(cache, mkc, ndescs, 1 << order);
+	if (!ent) {
+		mutex_unlock(&cache->cache_lock);
+		return false;
+	}
+
+	/*
+	 * Find the smallest node in the range with available mkeys.
+	 */
+	node = &ent->node;
+	while (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		cmp = memcmp(mkc, ent->mkc, size);
+
+		if (cmp != 0 || ent->ndescs > (1 << order))
+			break;
+
+		xa_lock_irq(&ent->mkeys);
+		if (ent->stored) {
+			mutex_unlock(&cache->cache_lock);
+			mlx5_ent_get_mkey_locked(ent, mr);
+			xa_unlock_irq(&ent->mkeys);
+
+			return true;
+		}
 
-	xa_lock_irq(&ent->mkeys);
-	if (!ent->stored) {
 		if (ent->limit) {
 			queue_adjust_cache_locked(ent);
 			ent->miss++;
 		}
 		xa_unlock_irq(&ent->mkeys);
-		err = create_cache_mkey(ent, &mr->mmkey.key);
-		if (err) {
-			kfree(mr);
-			return ERR_PTR(err);
-		}
-	} else {
-		ent->stored--;
-		xa_mkey = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY,
-				     GFP_KERNEL);
-		WARN_ON(xa_mkey == NULL || xa_is_err(xa_mkey));
-		ent->reserved--;
-		old = __xa_erase(&ent->mkeys, ent->reserved);
-		WARN_ON(old != NULL);
-		queue_adjust_cache_locked(ent);
-		xa_unlock_irq(&ent->mkeys);
+		node = rb_next(node);
+	}
+
+	mutex_unlock(&cache->cache_lock);
+
+	return false;
+}
+
+struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
+				       int inlen, unsigned int ndescs,
+				       unsigned int access_mode)
+{
+	struct mlx5_ib_mr *mr;
+	void *mkc;
+	int err;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 
-		mr->mmkey.key = (u32)xa_to_value(xa_mkey);
+	if (!mlx5_cache_get_mkey(&dev->cache, mkc, ndescs, mr)) {
+		/*
+		 * Can not use a cache mkey.
+		 * Create an mkey with the exact needed size.
+		 */
+		MLX5_SET(mkc, mkc, translations_octword_size,
+			 get_mkc_octo_size(access_mode, ndescs));
+		err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
+		if (err)
+			goto err;
 	}
-	mr->mmkey.cache_ent = ent;
 	mr->mmkey.type = MLX5_MKEY_MR;
 	init_waitqueue_head(&mr->mmkey.wait);
 	return mr;
 
+err:
+	kfree(mr);
+	return ERR_PTR(err);
 }
 
 static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
@@ -655,10 +773,8 @@ static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	xa_unlock_irq(&ent->mkeys);
 }
 
-static void clean_keys(struct mlx5_ib_dev *dev, int c)
+static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
 {
-	struct mlx5_mr_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent = &cache->ent[c];
 	void *xa_mkey;
 
 	cancel_delayed_work(&ent->dwork);
@@ -684,27 +800,21 @@ static void mlx5_mr_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 	dev->cache.root = NULL;
 }
 
-static void mlx5_mr_cache_debugfs_init(struct mlx5_ib_dev *dev)
+static void mlx5_cache_ent_debugfs_init(struct mlx5_ib_dev *dev,
+					struct mlx5_cache_ent *ent, int order)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
-	struct mlx5_cache_ent *ent;
 	struct dentry *dir;
-	int i;
 
 	if (!mlx5_debugfs_root || dev->is_rep)
 		return;
 
-	cache->root = debugfs_create_dir("mr_cache", dev->mdev->priv.dbg_root);
-
-	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
-		sprintf(ent->name, "%d", ent->order);
-		dir = debugfs_create_dir(ent->name, cache->root);
-		debugfs_create_file("size", 0600, dir, ent, &size_fops);
-		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
-		debugfs_create_ulong("cur", 0400, dir, &ent->stored);
-		debugfs_create_u32("miss", 0600, dir, &ent->miss);
-	}
+	sprintf(ent->name, "%d", order);
+	dir = debugfs_create_dir(ent->name, cache->root);
+	debugfs_create_file("size", 0600, dir, ent, &size_fops);
+	debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
+	debugfs_create_ulong("cur", 0400, dir, &ent->stored);
+	debugfs_create_u32("miss", 0600, dir, &ent->miss);
 }
 
 static void delay_time_func(struct timer_list *t)
@@ -714,69 +824,107 @@ static void delay_time_func(struct timer_list *t)
 	WRITE_ONCE(dev->fill_delay, 0);
 }
 
+static struct mlx5_cache_ent *mlx5_ib_create_cache_ent(struct mlx5_ib_dev *dev,
+						       unsigned int order)
+{
+	struct mlx5_cache_ent *ent;
+	int ret;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	ent->mkc = kzalloc(MLX5_ST_SZ_BYTES(mkc), GFP_KERNEL);
+	if (!ent->mkc) {
+		kfree(ent);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	ent->ndescs = 1 << order;
+
+	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
+	ent->dev = dev;
+
+	INIT_WORK(&ent->work, cache_work_func);
+	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
+
+	mlx5_cache_ent_debugfs_init(dev, ent, order);
+
+	mlx5_set_cache_mkc(dev, ent->mkc, 0, MLX5_MKC_ACCESS_MODE_MTT,
+			   PAGE_SHIFT);
+	mutex_lock(&dev->cache.cache_lock);
+	ret = mlx5_cache_ent_insert_locked(&dev->cache, ent);
+	mutex_unlock(&dev->cache.cache_lock);
+	if (ret) {
+		kfree(ent->mkc);
+		kfree(ent);
+		return ERR_PTR(ret);
+	}
+	return ent;
+}
+
 int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
+	bool can_use_cache, need_cache;
 	struct mlx5_cache_ent *ent;
-	int i;
+	int order, err;
 
 	mutex_init(&dev->slow_path_mutex);
+	mutex_init(&dev->cache.cache_lock);
+	cache->cache_root = RB_ROOT;
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
 		return -ENOMEM;
 	}
 
+	if (mlx5_debugfs_root && !dev->is_rep)
+		cache->root = debugfs_create_dir("mr_cache",
+						 dev->mdev->priv.dbg_root);
+
+	can_use_cache = !dev->is_rep && mlx5_ib_can_load_pas_with_umr(dev, 0);
+	need_cache = (dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
+		     mlx5_core_is_pf(dev->mdev);
+
 	mlx5_cmd_init_async_ctx(dev->mdev, &dev->async_ctx);
 	timer_setup(&dev->delay_timer, delay_time_func, 0);
-	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
-		ent = &cache->ent[i];
-		xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
-		ent->order = i + 2;
-		ent->dev = dev;
-		ent->limit = 0;
-
-		INIT_WORK(&ent->work, cache_work_func);
-		INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
-
-		if (i > MR_CACHE_LAST_STD_ENTRY) {
-			mlx5_odp_init_mr_cache_entry(ent);
-			continue;
-		}
+	for (order = 2; order < MAX_MR_CACHE_ENTRIES + 2; order++) {
+		ent = mlx5_ib_create_cache_ent(dev, order);
 
-		if (ent->order > mr_cache_max_order(dev))
-			continue;
+		if (IS_ERR(ent)) {
+			err = PTR_ERR(ent);
+			goto err;
+		}
 
-		ent->page = PAGE_SHIFT;
-		ent->xlt = (1 << ent->order) * sizeof(struct mlx5_mtt) /
-			   MLX5_IB_UMR_OCTOWORD;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
-		if ((dev->mdev->profile.mask & MLX5_PROF_MASK_MR_CACHE) &&
-		    !dev->is_rep && mlx5_core_is_pf(dev->mdev) &&
-		    mlx5_ib_can_load_pas_with_umr(dev, 0))
-			ent->limit = dev->mdev->profile.mr_cache[i].limit;
-		else
-			ent->limit = 0;
-		xa_lock_irq(&ent->mkeys);
-		queue_adjust_cache_locked(ent);
-		xa_unlock_irq(&ent->mkeys);
+		if (can_use_cache && need_cache &&
+		    order <= mr_cache_max_order(dev)) {
+			ent->limit =
+				dev->mdev->profile.mr_cache[order - 2].limit;
+			xa_lock_irq(&ent->mkeys);
+			queue_adjust_cache_locked(ent);
+			xa_unlock_irq(&ent->mkeys);
+		}
 	}
 
-	mlx5_mr_cache_debugfs_init(dev);
-
 	return 0;
+err:
+	mlx5_mr_cache_cleanup(dev);
+	return err;
 }
 
 int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 {
-	unsigned int i;
+	struct rb_root *root = &dev->cache.cache_root;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *node;
 
 	if (!dev->cache.wq)
 		return 0;
 
-	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
-		struct mlx5_cache_ent *ent = &dev->cache.ent[i];
-
+	mutex_lock(&dev->cache.cache_lock);
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		xa_lock_irq(&ent->mkeys);
 		ent->disabled = true;
 		xa_unlock_irq(&ent->mkeys);
@@ -787,8 +935,16 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_mr_cache_debugfs_cleanup(dev);
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
 
-	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++)
-		clean_keys(dev, i);
+	node = rb_first(root);
+	while (node) {
+		ent = rb_entry(node, struct mlx5_cache_ent, node);
+		node = rb_next(node);
+		clean_keys(dev, ent);
+		rb_erase(&ent->node, root);
+		kfree(ent->mkc);
+		kfree(ent);
+	}
+	mutex_unlock(&dev->cache.cache_lock);
 
 	destroy_workqueue(dev->cache.wq);
 	del_timer_sync(&dev->delay_timer);
@@ -857,7 +1013,7 @@ static int get_octo_len(u64 addr, u64 len, int page_shift)
 static int mr_cache_max_order(struct mlx5_ib_dev *dev)
 {
 	if (MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
-		return MR_CACHE_LAST_STD_ENTRY + 2;
+		return MAX_MR_CACHE_ENTRIES + 2;
 	return MLX5_MAX_UMR_SHIFT;
 }
 
@@ -904,18 +1060,6 @@ static int mlx5_ib_post_send_wait(struct mlx5_ib_dev *dev,
 	return err;
 }
 
-static struct mlx5_cache_ent *mr_cache_ent_from_order(struct mlx5_ib_dev *dev,
-						      unsigned int order)
-{
-	struct mlx5_mr_cache *cache = &dev->cache;
-
-	if (order < cache->ent[0].order)
-		return &cache->ent[0];
-	order = order - cache->ent[0].order;
-	if (order > MR_CACHE_LAST_STD_ENTRY)
-		return NULL;
-	return &cache->ent[order];
-}
 
 static void set_mr_fields(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr,
 			  u64 length, int access_flags, u64 iova)
@@ -939,14 +1083,38 @@ static unsigned int mlx5_umem_dmabuf_default_pgsz(struct ib_umem *umem,
 	return PAGE_SIZE;
 }
 
+int mlx5_acc_flags_to_ent_flags(struct mlx5_ib_dev *dev, int access_flags)
+{
+	int ret = 0;
+
+	if ((access_flags & IB_ACCESS_REMOTE_ATOMIC) &&
+	    MLX5_CAP_GEN(dev->mdev, atomic) &&
+	    MLX5_CAP_GEN(dev->mdev, umr_modify_atomic_disabled))
+		ret |= IB_ACCESS_REMOTE_ATOMIC;
+
+	if ((access_flags & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write_umr))
+		ret |= IB_ACCESS_RELAXED_ORDERING;
+
+	if ((access_flags & IB_ACCESS_RELAXED_ORDERING) &&
+	    MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read) &&
+	    !MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read_umr))
+		ret |= IB_ACCESS_RELAXED_ORDERING;
+
+	return ret;
+}
+
 static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 					     struct ib_umem *umem, u64 iova,
 					     int access_flags)
 {
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
-	struct mlx5_cache_ent *ent;
+	unsigned int page_size, ndescs;
 	struct mlx5_ib_mr *mr;
-	unsigned int page_size;
+	void *mkc;
+	int inlen;
+	int *in;
 
 	if (umem->is_dmabuf)
 		page_size = mlx5_umem_dmabuf_default_pgsz(umem, iova);
@@ -955,29 +1123,31 @@ static struct mlx5_ib_mr *alloc_cacheable_mr(struct ib_pd *pd,
 						     0, iova);
 	if (WARN_ON(!page_size))
 		return ERR_PTR(-EINVAL);
-	ent = mr_cache_ent_from_order(
-		dev, order_base_2(ib_umem_num_dma_blocks(umem, page_size)));
-	/*
-	 * Matches access in alloc_cache_mr(). If the MR can't come from the
-	 * cache then synchronously create an uncached one.
-	 */
-	if (!ent || ent->limit == 0 ||
-	    !mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags)) {
-		mutex_lock(&dev->slow_path_mutex);
-		mr = reg_create(pd, umem, iova, access_flags, page_size, false);
-		mutex_unlock(&dev->slow_path_mutex);
-		return mr;
-	}
 
-	mr = mlx5_mr_cache_alloc(dev, ent, access_flags);
-	if (IS_ERR(mr))
+	ndescs = ib_umem_num_dma_blocks(umem, page_size);
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return ERR_PTR(-ENOMEM);
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	mlx5_set_cache_mkc(dev, mkc,
+			   mlx5_acc_flags_to_ent_flags(dev, access_flags),
+			   MLX5_MKC_ACCESS_MODE_MTT, PAGE_SHIFT);
+
+	mr = mlx5_mr_cache_alloc(dev, in, inlen, ndescs,
+				 MLX5_MKC_ACCESS_MODE_MTT);
+	if (IS_ERR(mr)) {
+		kfree(in);
 		return mr;
+	}
 
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
 	mr->page_shift = order_base_2(page_size);
 	set_mr_fields(dev, mr, umem->length, access_flags, iova);
 
+	kfree(in);
 	return mr;
 }
 
@@ -1727,7 +1897,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
 	if (WARN_ON(!*page_size))
 		return false;
-	return (1ULL << mr->mmkey.cache_ent->order) >=
+	return (mr->mmkey.cache_ent->ndescs) >=
 	       ib_umem_num_dma_blocks(new_umem, *page_size);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 0972afc3e952..89aaf783fe25 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -411,6 +411,9 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	struct ib_umem_odp *odp;
 	struct mlx5_ib_mr *mr;
 	struct mlx5_ib_mr *ret;
+	void *mkc;
+	int inlen;
+	int *in;
 	int err;
 
 	odp = ib_umem_odp_alloc_child(to_ib_umem_odp(imr->umem),
@@ -419,10 +422,23 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	if (IS_ERR(odp))
 		return ERR_CAST(odp);
 
-	mr = mlx5_mr_cache_alloc(dev, &dev->cache.ent[MLX5_IMR_MTT_CACHE_ENTRY],
-				 imr->access_flags);
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		ib_umem_odp_release(odp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	mlx5_set_cache_mkc(dev, mkc,
+			   mlx5_acc_flags_to_ent_flags(dev, imr->access_flags),
+			   MLX5_MKC_ACCESS_MODE_MTT, PAGE_SHIFT);
+
+	mr = mlx5_mr_cache_alloc(dev, in, inlen, MLX5_IMR_MTT_ENTRIES,
+				 MLX5_MKC_ACCESS_MODE_MTT);
 	if (IS_ERR(mr)) {
 		ib_umem_odp_release(odp);
+		kfree(in);
 		return mr;
 	}
 
@@ -470,12 +486,14 @@ static struct mlx5_ib_mr *implicit_get_child_mr(struct mlx5_ib_mr *imr,
 	xa_unlock(&imr->implicit_children);
 
 	mlx5_ib_dbg(mr_to_mdev(imr), "key %x mr %p\n", mr->mmkey.key, mr);
+	kfree(in);
 	return mr;
 
 out_lock:
 	xa_unlock(&imr->implicit_children);
 out_mr:
 	mlx5_ib_dereg_mr(&mr->ibmr, NULL);
+	kfree(in);
 	return ret;
 }
 
@@ -485,6 +503,9 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	struct mlx5_ib_dev *dev = to_mdev(pd->ibpd.device);
 	struct ib_umem_odp *umem_odp;
 	struct mlx5_ib_mr *imr;
+	void *mkc;
+	int inlen;
+	int *in;
 	int err;
 
 	if (!mlx5_ib_can_load_pas_with_umr(dev,
@@ -495,11 +516,23 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 	if (IS_ERR(umem_odp))
 		return ERR_CAST(umem_odp);
 
-	imr = mlx5_mr_cache_alloc(dev,
-				  &dev->cache.ent[MLX5_IMR_KSM_CACHE_ENTRY],
-				  access_flags);
+	inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in) {
+		ib_umem_odp_release(umem_odp);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	mlx5_set_cache_mkc(dev, mkc,
+			   mlx5_acc_flags_to_ent_flags(dev, access_flags),
+			   MLX5_MKC_ACCESS_MODE_KSM, PAGE_SHIFT);
+
+	imr = mlx5_mr_cache_alloc(dev, in, inlen, mlx5_imr_ksm_entries,
+				  MLX5_MKC_ACCESS_MODE_KSM);
 	if (IS_ERR(imr)) {
 		ib_umem_odp_release(umem_odp);
+		kfree(in);
 		return imr;
 	}
 
@@ -528,10 +561,12 @@ struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
 		goto out_mr;
 
 	mlx5_ib_dbg(dev, "key %x mr %p\n", imr->mmkey.key, imr);
+	kfree(in);
 	return imr;
 out_mr:
 	mlx5_ib_err(dev, "Failed to register MKEY %d\n", err);
 	mlx5_ib_dereg_mr(&imr->ibmr, NULL);
+	kfree(in);
 	return ERR_PTR(err);
 }
 
@@ -1596,32 +1631,6 @@ mlx5_ib_odp_destroy_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq)
 	return err;
 }
 
-void mlx5_odp_init_mr_cache_entry(struct mlx5_cache_ent *ent)
-{
-	if (!(ent->dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
-		return;
-
-	switch (ent->order - 2) {
-	case MLX5_IMR_MTT_CACHE_ENTRY:
-		ent->page = PAGE_SHIFT;
-		ent->xlt = MLX5_IMR_MTT_ENTRIES *
-			   sizeof(struct mlx5_mtt) /
-			   MLX5_IB_UMR_OCTOWORD;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_MTT;
-		ent->limit = 0;
-		break;
-
-	case MLX5_IMR_KSM_CACHE_ENTRY:
-		ent->page = MLX5_KSM_PAGE_SHIFT;
-		ent->xlt = mlx5_imr_ksm_entries *
-			   sizeof(struct mlx5_klm) /
-			   MLX5_IB_UMR_OCTOWORD;
-		ent->access_mode = MLX5_MKC_ACCESS_MODE_KSM;
-		ent->limit = 0;
-		break;
-	}
-}
-
 static const struct ib_device_ops mlx5_ib_dev_odp_ops = {
 	.advise_mr = mlx5_ib_advise_mr,
 };
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index a623ec635947..c33f71134136 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -699,10 +699,7 @@ enum {
 };
 
 enum {
-	MR_CACHE_LAST_STD_ENTRY = 20,
-	MLX5_IMR_MTT_CACHE_ENTRY,
-	MLX5_IMR_KSM_CACHE_ENTRY,
-	MAX_MR_CACHE_ENTRIES
+	MAX_MR_CACHE_ENTRIES = 21,
 };
 
 struct mlx5_profile {
-- 
2.33.1

