Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B367F481BB6
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:24:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238945AbhL3LYE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:24:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239010AbhL3LYD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:24:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADB13C06173E;
        Thu, 30 Dec 2021 03:24:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A46A6168B;
        Thu, 30 Dec 2021 11:24:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9EA5C36AEC;
        Thu, 30 Dec 2021 11:24:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863441;
        bh=CPKISPGTbcoObFThEXqTFHDva0XDHTqBXOhYb8c6dGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SiDtfuVZBtabg6cj76h4Be0/mTQ4Hh3msR8gyGB/ceR89gw7jA94N1gLJcM0Eqzev
         Mxygbowsx/4aqP/kdj0nq4mb+PgBMst8JkTMnGJwJyi7IOh6Vj9KeMQhrIwc6ubWUq
         tssY+bFPq/1JKwwMrkEJvVsaB5R9z0fSjn7ywVesMJH8cfa3VHAiPlCJl8RkFTdrjC
         pdte3h6bJ8GGUvh5d7z2aah1T3I1tLRkxrytPmYw+4E8CBkDrMAmncnl2/KG/bLH3c
         H3bP+EgNbQQ0no6vcaOleDBIRUY+XqspnayEoBPoDPdh5YJDMx75ua5C+T31ZCMg27
         kEY9Zl5oE4QKg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 6/7] RDMA/mlx5: Delay the deregistration of a non-cache mkey
Date:   Thu, 30 Dec 2021 13:23:23 +0200
Message-Id: <c209119299747d97ee39acfc79f2aa7d73b043c4.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640862842.git.leonro@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/mlx5/mr.c      | 131 ++++++++++++++++++++++++++-
 2 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index ce1f48cc8370..8ebe1edce190 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -639,6 +639,7 @@ struct mlx5_ib_mkey {
 	u32 key;
 	enum mlx5_mkey_type type;
 	unsigned int ndescs;
+	unsigned int access_mode;
 	struct wait_queue_head wait;
 	refcount_t usecount;
 	struct mlx5_cache_ent *cache_ent;
@@ -746,6 +747,7 @@ struct mlx5_cache_ent {
 	char                    name[4];
 	unsigned int		ndescs;
 
+	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
 
@@ -782,6 +784,7 @@ struct mlx5_mr_cache {
 	struct mutex		cache_lock;
 	struct dentry		*root;
 	unsigned long		last_add;
+	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 631bb12697fd..43e993b360d8 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -482,7 +482,7 @@ static bool someone_adding(struct mlx5_mr_cache *cache)
  */
 static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 {
-	if (ent->disabled || READ_ONCE(ent->dev->fill_delay))
+	if (ent->disabled || READ_ONCE(ent->dev->fill_delay) || ent->is_tmp)
 		return;
 	if (ent->stored < ent->limit) {
 		ent->fill_to_high_water = true;
@@ -671,7 +671,16 @@ static void mlx5_ent_get_mkey_locked(struct mlx5_cache_ent *ent,
 	WARN_ON(old != NULL);
 	queue_adjust_cache_locked(ent);
 	mr->mmkey.key = (u32)xa_to_value(xa_mkey);
-	mr->mmkey.cache_ent = ent;
+
+	if (!ent->is_tmp)
+		mr->mmkey.cache_ent = ent;
+	else {
+		ent->total_mrs--;
+		cancel_delayed_work(&ent->dev->cache.remove_ent_dwork);
+		queue_delayed_work(ent->dev->cache.wq,
+				   &ent->dev->cache.remove_ent_dwork,
+				   msecs_to_jiffies(30 * 1000));
+	}
 }
 
 static bool mlx5_cache_get_mkey(struct mlx5_mr_cache *cache, void *mkc,
@@ -750,8 +759,10 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int *in,
 		if (err)
 			goto err;
 	}
+	mr->mmkey.ndescs = ndescs;
 	mr->mmkey.type = MLX5_MKEY_MR;
 	init_waitqueue_head(&mr->mmkey.wait);
+	mr->mmkey.access_mode = access_mode;
 	return mr;
 
 err:
@@ -863,6 +874,42 @@ static struct mlx5_cache_ent *mlx5_ib_create_cache_ent(struct mlx5_ib_dev *dev,
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
+		ent = rb_entry(cur, struct mlx5_cache_ent, node);
+		cur = rb_prev(cur);
+		mutex_unlock(&cache->cache_lock);
+
+		xa_lock_irq(&ent->mkeys);
+		if (!ent->is_tmp || ent->total_mrs != ent->stored) {
+			if (ent->total_mrs != ent->stored)
+				queue_delayed_work(cache->wq,
+						   &cache->remove_ent_dwork,
+						   msecs_to_jiffies(30 * 1000));
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
@@ -873,6 +920,7 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.cache_lock);
 	cache->cache_root = RB_ROOT;
+	INIT_DELAYED_WORK(&cache->remove_ent_dwork, remove_ent_work_func);
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -922,6 +970,7 @@ int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 	if (!dev->cache.wq)
 		return 0;
 
+	cancel_delayed_work_sync(&dev->cache.remove_ent_dwork);
 	mutex_lock(&dev->cache.cache_lock);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
@@ -2092,6 +2141,81 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }
 
+static struct mlx5_cache_ent *mlx5_cache_create_tmp_ent(struct mlx5_ib_dev *dev,
+							void *mkc,
+							unsigned int ndescs)
+{
+	struct mlx5_cache_ent *ent;
+	int ret;
+
+	ent = kzalloc(sizeof(*ent), GFP_KERNEL);
+	if (!ent)
+		return ERR_PTR(-ENOMEM);
+
+	xa_init_flags(&ent->mkeys, XA_FLAGS_LOCK_IRQ);
+	ent->ndescs = ndescs;
+	ent->dev = dev;
+	ent->is_tmp = true;
+
+	INIT_WORK(&ent->work, cache_work_func);
+	INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
+
+	ent->mkc = mkc;
+	ret = mlx5_cache_ent_insert_locked(&dev->cache, ent);
+	if (ret) {
+		kfree(ent);
+		return ERR_PTR(ret);
+	}
+
+	return ent;
+}
+
+static void mlx5_cache_tmp_push_mkey(struct mlx5_ib_dev *dev,
+				     struct mlx5_ib_mr *mr)
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
+	mutex_lock(&cache->cache_lock);
+	ent = mlx5_cache_find_smallest_ent(&dev->cache, mkc, mr->mmkey.ndescs,
+					   mr->mmkey.ndescs);
+	if (!ent) {
+		ent = mlx5_cache_create_tmp_ent(dev, mkc, mr->mmkey.ndescs);
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
+	cancel_delayed_work(&cache->remove_ent_dwork);
+	queue_delayed_work(cache->wq, &cache->remove_ent_dwork,
+			   msecs_to_jiffies(30 * 1000));
+	mutex_unlock(&cache->cache_lock);
+	mr->mmkey.cache_ent = ent;
+}
+
 int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 {
 	struct mlx5_ib_mr *mr = to_mmr(ibmr);
@@ -2136,6 +2260,9 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 		mr->sig = NULL;
 	}
 
+	if (!mr->mmkey.cache_ent)
+		mlx5_cache_tmp_push_mkey(dev, mr);
+
 	/* Stop DMA */
 	if (mr->mmkey.cache_ent) {
 		if (revoke_mr(mr) || push_reserve_mkey(mr->mmkey.cache_ent)) {
-- 
2.33.1

