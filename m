Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EAFA469217
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 10:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhLFJOx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 04:14:53 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40266 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240140AbhLFJOw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 04:14:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E022B81059;
        Mon,  6 Dec 2021 09:11:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 698D6C341C2;
        Mon,  6 Dec 2021 09:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638781882;
        bh=TDEdDAdLR6DdwMk/U9plpHnFH41Wc4XS1dzt+MljErI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h/u1fZvfpkh3qdwk7x3rvtjbgVfCI8CBkbd3+IqwQ6IbsT5vlDB7y6oga7EstF1xM
         ux1QcgIz4iCUopx0hNXreWDLepa6mPdifbKXw2P7daQot5HcTOnyrFzifkF5hy4LsV
         DzD9ru+aeZE5AFi5WuU9l1l/pznAMlUxYZb0pmhppv8CUJeF21JzW0NwgYPVHyYGR9
         aiSv6q4FZ/WTsU0cYvdFV692NaVj2udiZ/tZb0W3gymzN5NVZJPf8NBot16Nhutxpx
         lo+r0sU0vF5rYatnBJeLlcLbks87Dpd/mtj3twOC0UFDF4MfrXbfs5G+C4iqGaUu7C
         ACac6akIFuyPw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/7] RDMA/mlx5: Delay the deregistration of a non-cache mkey
Date:   Mon,  6 Dec 2021 11:10:51 +0200
Message-Id: <f827300a569f39dc47429017f88c073f1b8a1df5.1638781506.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638781506.git.leonro@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

When restarting an application with many non-cached mkeys, all the mkeys
will be destroyed and then recreated.

This process takes a long time (about 20 seconds for deregistration and
28 seconds for registration of 100,000 MRs).

To shorten the restart runtime, insert the mkeys temporarily into the
cache and schedule a delayed work to destroy them later. If there is no
fitting entry to these mkeys, create a temporary entry that fits them.

If 30 seconds have passed and no user reclaimed the temporarily cached
mkeys, the scheduled work will destroy the mkeys and the temporary
entries.

When restarting an application, the mkeys will still be in the cache
when trying to reg them again, therefore, the registration will be
faster (4 seconds for deregistration and 5 seconds or registration of
100,000 MRs).

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   3 +
 drivers/infiniband/hw/mlx5/mr.c      | 157 ++++++++++++++++++++++++---
 2 files changed, 146 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 202d8fbc423d..7dcc9e69a649 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -638,6 +638,7 @@ struct mlx5_ib_mkey {
 	u32 key;
 	enum mlx5_mkey_type type;
 	unsigned int ndescs;
+	unsigned int access_mode;
 	struct wait_queue_head wait;
 	refcount_t usecount;
 };
@@ -747,6 +748,7 @@ struct mlx5_cache_ent {
 	char                    name[4];
 	int			ndescs;
 
+	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
 
@@ -786,6 +788,7 @@ struct mlx5_mr_cache {
 	struct dentry		*root;
 	unsigned long		last_add;
 	bool			maintained_cache;
+	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index ca6faf599cd3..29888a426b33 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -449,7 +449,7 @@ static bool someone_adding(struct mlx5_mr_cache *cache)
  */
 static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 {
-	if (ent->disabled || READ_ONCE(ent->dev->fill_delay))
+	if (ent->disabled || READ_ONCE(ent->dev->fill_delay) || ent->is_tmp)
 		return;
 	if (ent->stored < ent->limit) {
 		ent->fill_to_high_water = true;
@@ -603,6 +603,7 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 		return ERR_PTR(-ENOMEM);
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	mutex_lock(&dev->cache.cache_lock);
 	if (dev->cache.maintained_cache && !force) {
 		int order;
 
@@ -612,13 +613,25 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 		order = order_base_2(ndescs) > 2 ? order_base_2(ndescs) : 2;
 		MLX5_SET(mkc, mkc, translations_octword_size,
 			 get_mkc_octo_size(access_mode, 1 << order));
-		mutex_lock(&dev->cache.cache_lock);
 		ent = ent_search(&dev->cache, mkc);
-		mutex_unlock(&dev->cache.cache_lock);
 	}
-
-	if (ent && (ent->limit || force)) {
+	if (!ent) {
+		/*
+		 * Can not use a cache mkey.
+		 * Create an mkey with the exact needed size.
+		 */
+		MLX5_SET(mkc, mkc, translations_octword_size,
+			 get_mkc_octo_size(access_mode, ndescs));
+		ent = ent_search(&dev->cache, mkc);
+	}
+	if (ent)
 		xa_lock_irq(&ent->mkeys);
+	else
+		__acquire(&ent->lock);
+	mutex_unlock(&dev->cache.cache_lock);
+
+	if (ent && !ent->disabled &&
+	    (ent->stored || ent->limit || force)) {
 		if (!ent->stored) {
 			if (ent->limit) {
 				queue_adjust_cache_locked(ent);
@@ -633,7 +646,6 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 			WRITE_ONCE(ent->dev->cache.last_add, jiffies);
 			xa_lock_irq(&ent->mkeys);
 			ent->total_mrs++;
-			xa_unlock_irq(&ent->mkeys);
 		} else {
 			xa_ent = __xa_store(&ent->mkeys, --ent->stored,
 					  NULL, GFP_KERNEL);
@@ -641,23 +653,30 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 			WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) !=
 				NULL);
 			queue_adjust_cache_locked(ent);
-			xa_unlock_irq(&ent->mkeys);
 			mr->mmkey.key = (u32)xa_to_value(xa_ent);
 		}
-		mr->cache_ent = ent;
+		if (ent->is_tmp) {
+			ent->total_mrs--;
+			queue_delayed_work(dev->cache.wq,
+					   &dev->cache.remove_ent_dwork,
+					   msecs_to_jiffies(30 * 1000));
+		} else
+			mr->cache_ent = ent;
+
+		xa_unlock_irq(&ent->mkeys);
 	} else {
-		/*
-		 * Can not use a cache mkey.
-		 * Create an mkey with the exact needed size.
-		 */
-		MLX5_SET(mkc, mkc, translations_octword_size,
-			 get_mkc_octo_size(access_mode, ndescs));
+		if (ent)
+			xa_unlock_irq(&ent->mkeys);
+		else
+			__release(&ent->lock);
 		err = mlx5_ib_create_mkey(dev, &mr->mmkey, in, inlen);
 		if (err)
 			goto err;
 	}
+	mr->mmkey.ndescs = ndescs;
 	mr->mmkey.type = MLX5_MKEY_MR;
 	init_waitqueue_head(&mr->mmkey.wait);
+	mr->mmkey.access_mode = access_mode;
 	return mr;
 
 err:
@@ -791,6 +810,38 @@ static struct mlx5_cache_ent *mlx5_ib_create_cache_ent(struct mlx5_ib_dev *dev,
 	return ent;
 }
 
+static void remove_ent_work_func(struct work_struct *work)
+{
+	struct mlx5_mr_cache *cache;
+	struct mlx5_cache_ent *ent;
+	struct rb_node *cur;
+
+	cache = container_of(work, struct mlx5_mr_cache, remove_ent_dwork.work);
+	mutex_lock(&cache->cache_lock);
+	cur = rb_last(&cache->cache_root);
+	while (cur) {
+		ent = container_of(cur, struct mlx5_cache_ent, node);
+		cur = rb_prev(cur);
+		mutex_unlock(&cache->cache_lock);
+
+		xa_lock_irq(&ent->mkeys);
+		if (!ent->is_tmp || ent->total_mrs != ent->stored) {
+			xa_unlock_irq(&ent->mkeys);
+			mutex_lock(&cache->cache_lock);
+			continue;
+		}
+		ent->disabled = true;
+		xa_unlock_irq(&ent->mkeys);
+
+		clean_keys(ent->dev, ent);
+		mutex_lock(&cache->cache_lock);
+		rb_erase(&ent->node, &cache->cache_root);
+		kfree(ent->mkc);
+		kfree(ent);
+	}
+	mutex_unlock(&cache->cache_lock);
+}
+
 int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
@@ -800,6 +851,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.cache_lock);
 	cache->cache_root = RB_ROOT;
+	INIT_DELAYED_WORK(&cache->remove_ent_dwork, remove_ent_work_func);
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed tocreate work queue\n");
@@ -850,6 +902,7 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 	if (!dev->cache.wq)
 		return 0;
 
+	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.cache_lock);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = container_of(node, struct mlx5_cache_ent, node);
@@ -2032,6 +2085,79 @@ static int push_reserve_mkey(struct mlx5_cache_ent *ent)
 	return ret;
 }
 
+static struct mlx5_cache_ent *
+create_tmp_cache_ent(struct mlx5_ib_dev *dev, void *mkc, unsigned int ndescs)
+{
+	struct mlx5_cache_ent *ent;
+	int ret;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	ent->mkc = mkc;
+	ret = ent_insert(&dev->cache, ent);
+	if (ret) {
+		kfree(ent);
+		return ERR_PTR(ret);
+	}
+
+	xa_init_flags(&ent->mkeys, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
+	ent->ndescs = ndescs;
+	ent->dev = dev;
+	ent->is_tmp = true;
+
+	INIT_WORK(&ent->work, cache_work_func);
+	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
+
+	return ent;
+}
+
+static void tmp_cache_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
+{
+	struct mlx5_mr_cache *cache = &dev->cache;
+	struct ib_umem *umem = mr->umem;
+	struct mlx5_cache_ent *ent;
+	void *mkc;
+
+	if (!umem || !mlx5_ib_can_load_pas_with_umr(dev, umem->length))
+		return;
+
+	mkc = kzalloc(MLX5_ST_SZ_BYTES(mkc), GFP_KERNEL);
+	if (!mkc)
+		return;
+
+	mlx5_set_cache_mkc(dev, mkc,
+			   mlx5_acc_flags_to_ent_flags(dev, mr->access_flags),
+			   mr->mmkey.access_mode, PAGE_SHIFT);
+	MLX5_SET(mkc, mkc, translations_octword_size,
+		 get_mkc_octo_size(mr->mmkey.access_mode, mr->mmkey.ndescs));
+	mutex_lock(&cache->cache_lock);
+	ent = ent_search(cache, mkc);
+	if (!ent) {
+		ent = create_tmp_cache_ent(dev, mkc, mr->mmkey.ndescs);
+		if (IS_ERR(ent)) {
+			mutex_unlock(&cache->cache_lock);
+			kfree(mkc);
+			return;
+		}
+	} else
+		kfree(mkc);
+
+	xa_lock_irq(&ent->mkeys);
+	if (ent->disabled) {
+		xa_unlock_irq(&ent->mkeys);
+		mutex_unlock(&cache->cache_lock);
+		return;
+	}
+	ent->total_mrs++;
+	xa_unlock_irq(&ent->mkeys);
+	queue_delayed_work(cache->wq, &cache->remove_ent_dwork,
+			   msecs_to_jiffies(30 * 1000));
+	mutex_unlock(&cache->cache_lock);
+	mr->cache_ent = ent;
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -2076,6 +2202,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		mr->sig = NULL;
 	}
 
+	if (!mr->cache_ent)
+		tmp_cache_mkey(dev, mr);
+
 	/* Stop DMA */
 	if (mr->cache_ent) {
 		if (revoke_mr(mr) || push_reserve_mkey(mr->cache_ent)) {
-- 
2.33.1

