Return-Path: <linux-rdma+bounces-4715-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EDAE969BA1
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 13:25:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 820F21C2166E
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Sep 2024 11:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C6EA1A42B3;
	Tue,  3 Sep 2024 11:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzqNnGlg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5A81B12E9
	for <linux-rdma@vger.kernel.org>; Tue,  3 Sep 2024 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725362709; cv=none; b=BlRGgo0WN6sbOkThvGqQAZzEYMnel5ue0SVIdQY2ntXbBQNWOvOQvABxGIU4dL7r6t9lLbjtxpm7tNjpe0dzeifXhzzoqc0uswQVc5RMuEHcvyc924B/o6Lp6HtcGdBimgsdkw4PdIpNc+xCT14thnTRXdKlMEWtced7pIYymXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725362709; c=relaxed/simple;
	bh=XtQpO4Z7zLlEIeRy7PgKvwzhRTEJQpS8dq5ZFRQXJ4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o5OwGyInYm0JRZTaR8tOii0V6AveLblyOl0TNzQQsDsR3v6QRNwvMQ2JL/N0m4H+1hTgmjkckatKdSpG/1+HCzH0MngtErvzWEMKtURUl9pMLrWhd2pNofsqssNKTLMFtJFoL1vZ8P/aFKLsE/fhX/m1VvSv2qfYF5wssWQ9kGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzqNnGlg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0858C4CEC4;
	Tue,  3 Sep 2024 11:25:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725362709;
	bh=XtQpO4Z7zLlEIeRy7PgKvwzhRTEJQpS8dq5ZFRQXJ4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tzqNnGlgUrSBSpHAUki1vXb+g5EIPvgZBnTt3f/NholXcb7UvYyPEEKoAngKV/c8I
	 4C5B9dZUlbTPDI6JN4fRbZuFTA+q6les9vHFlPhmr+MIe2gn9+WupLHtpQxHsbTq1e
	 0UFRHtYJQxu2BO8I0FIF0a1ecjJsmHOUbkyyYWxJRvj3B6gpumyPSZoaj1K8rlyJxK
	 STmOsFxPdeUxKcuKGt8Q25kUUYYvMX+lQgdKAdp6tuf2/dYrnxMbu3cPHtsHDsDgLI
	 3fZHyusPJh4JaulS1Z5ChY/uW9cBPe9gAD65f8+qtmfj4SgcWJRAIfEONnWyIUAV57
	 DgLjsAQozoeFw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Michael Guralnik <michaelgur@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Shay Drory <shayd@nvidia.com>
Subject: [PATCH rdma-next 4/4] RDMA/mlx5: Fix MR cache temp entries cleanup
Date: Tue,  3 Sep 2024 14:24:50 +0300
Message-ID: <e4fa4bb03bebf20dceae320f26816cd2dde23a26.1725362530.git.leon@kernel.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1725362530.git.leon@kernel.org>
References: <cover.1725362530.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Guralnik <michaelgur@nvidia.com>

Fix the cleanup of the temp cache entries that are dynamically created
in the MR cache.

The cleanup of the temp cache entries is currently scheduled only when a
new entry is created. Since in the cleanup of the entries only the mkeys
are destroyed and the cache entry stays in the cache, subsequent
registrations might reuse the entry and it will eventually be filled with
new mkeys without cleanup ever getting scheduled again.

On workloads that register and deregister MRs with a wide range of
properties we see the cache ends up holding many cache entries, each
holding the max number of mkeys that were ever used through it.

Additionally, as the cleanup work is scheduled to run over the whole
cache, any mkey that is returned to the cache after the cleanup was
scheduled will be held for less than the intended 30 seconds timeout.

Solve both issues by dropping the existing remove_ent_work and reusing
the existing per-entry work to also handle the temp entries cleanup.

Schedule the work to run with a 30 seconds delay every time we push an
mkey to a clean temp entry.
This ensures the cleanup runs on each entry only 30 seconds after the
first mkey was pushed to an empty entry.

As we have already been distinguishing between persistent and temp entries
when scheduling the cache_work_func, it is not being scheduled in any
other flows for the temp entries.

Another benefit from moving to a per-entry cleanup is we now not
required to hold the rb_tree mutex, thus enabling other flow to run
concurrently.

Fixes: dd1b913fb0d0 ("RDMA/mlx5: Cache all user cacheable mkeys on dereg MR flow")
Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  2 +-
 drivers/infiniband/hw/mlx5/mr.c      | 82 +++++++++++-----------------
 2 files changed, 32 insertions(+), 52 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index c0b1a9cd752b..5505eb70939b 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -802,6 +802,7 @@ struct mlx5_cache_ent {
 	u8 is_tmp:1;
 	u8 disabled:1;
 	u8 fill_to_high_water:1;
+	u8 tmp_cleanup_scheduled:1;
 
 	/*
 	 * - limit is the low water mark for stored mkeys, 2* limit is the
@@ -833,7 +834,6 @@ struct mlx5_mkey_cache {
 	struct mutex		rb_lock;
 	struct dentry		*fs_root;
 	unsigned long		last_add;
-	struct delayed_work	remove_ent_dwork;
 };
 
 struct mlx5_ib_port_resources {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c17a35014a2b..73962bd0b216 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -531,6 +531,21 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 	}
 }
 
+static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
+{
+	u32 mkey;
+
+	spin_lock_irq(&ent->mkeys_queue.lock);
+	while (ent->mkeys_queue.ci) {
+		mkey = pop_mkey_locked(ent);
+		spin_unlock_irq(&ent->mkeys_queue.lock);
+		mlx5_core_destroy_mkey(dev->mdev, mkey);
+		spin_lock_irq(&ent->mkeys_queue.lock);
+	}
+	ent->tmp_cleanup_scheduled = false;
+	spin_unlock_irq(&ent->mkeys_queue.lock);
+}
+
 static void __cache_work_func(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_dev *dev = ent->dev;
@@ -602,7 +617,11 @@ static void delayed_cache_work_func(struct work_struct *work)
 	struct mlx5_cache_ent *ent;
 
 	ent = container_of(work, struct mlx5_cache_ent, dwork.work);
-	__cache_work_func(ent);
+	/* temp entries are never filled, only cleaned */
+	if (ent->is_tmp)
+		clean_keys(ent->dev, ent);
+	else
+		__cache_work_func(ent);
 }
 
 static int cache_ent_key_cmp(struct mlx5r_cache_rb_key key1,
@@ -778,20 +797,6 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	return _mlx5_mr_cache_alloc(dev, ent, access_flags);
 }
 
-static void clean_keys(struct mlx5_ib_dev *dev, struct mlx5_cache_ent *ent)
-{
-	u32 mkey;
-
-	spin_lock_irq(&ent->mkeys_queue.lock);
-	while (ent->mkeys_queue.ci) {
-		mkey = pop_mkey_locked(ent);
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-		mlx5_core_destroy_mkey(dev->mdev, mkey);
-		spin_lock_irq(&ent->mkeys_queue.lock);
-	}
-	spin_unlock_irq(&ent->mkeys_queue.lock);
-}
-
 static void mlx5_mkey_cache_debugfs_cleanup(struct mlx5_ib_dev *dev)
 {
 	if (!mlx5_debugfs_root || dev->is_rep)
@@ -904,10 +909,6 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 			ent->limit = 0;
 
 		mlx5_mkey_cache_debugfs_add_ent(dev, ent);
-	} else {
-		mod_delayed_work(ent->dev->cache.wq,
-				 &ent->dev->cache.remove_ent_dwork,
-				 msecs_to_jiffies(30 * 1000));
 	}
 
 	return ent;
@@ -918,35 +919,6 @@ mlx5r_cache_create_ent_locked(struct mlx5_ib_dev *dev,
 	return ERR_PTR(ret);
 }
 
-static void remove_ent_work_func(struct work_struct *work)
-{
-	struct mlx5_mkey_cache *cache;
-	struct mlx5_cache_ent *ent;
-	struct rb_node *cur;
-
-	cache = container_of(work, struct mlx5_mkey_cache,
-			     remove_ent_dwork.work);
-	mutex_lock(&cache->rb_lock);
-	cur = rb_last(&cache->rb_root);
-	while (cur) {
-		ent = rb_entry(cur, struct mlx5_cache_ent, node);
-		cur = rb_prev(cur);
-		mutex_unlock(&cache->rb_lock);
-
-		spin_lock_irq(&ent->mkeys_queue.lock);
-		if (!ent->is_tmp) {
-			spin_unlock_irq(&ent->mkeys_queue.lock);
-			mutex_lock(&cache->rb_lock);
-			continue;
-		}
-		spin_unlock_irq(&ent->mkeys_queue.lock);
-
-		clean_keys(ent->dev, ent);
-		mutex_lock(&cache->rb_lock);
-	}
-	mutex_unlock(&cache->rb_lock);
-}
-
 int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 {
 	struct mlx5_mkey_cache *cache = &dev->cache;
@@ -962,7 +934,6 @@ int mlx5_mkey_cache_init(struct mlx5_ib_dev *dev)
 	mutex_init(&dev->slow_path_mutex);
 	mutex_init(&dev->cache.rb_lock);
 	dev->cache.rb_root = RB_ROOT;
-	INIT_DELAYED_WORK(&dev->cache.remove_ent_dwork, remove_ent_work_func);
 	cache->wq = alloc_ordered_workqueue("mkey_cache", WQ_MEM_RECLAIM);
 	if (!cache->wq) {
 		mlx5_ib_warn(dev, "failed to create work queue\n");
@@ -1013,7 +984,6 @@ void mlx5_mkey_cache_cleanup(struct mlx5_ib_dev *dev)
 		return;
 
 	mutex_lock(&dev->cache.rb_lock);
-	cancel_delayed_work(&dev->cache.remove_ent_dwork);
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		ent = rb_entry(node, struct mlx5_cache_ent, node);
 		spin_lock_irq(&ent->mkeys_queue.lock);
@@ -2053,8 +2023,18 @@ static int mlx5_revoke_mr(struct mlx5_ib_mr *mr)
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 
-	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr))
+	if (mr->mmkey.cacheable && !mlx5r_umr_revoke_mr(mr) && !cache_ent_find_and_store(dev, mr)) {
+		ent = mr->mmkey.cache_ent;
+		/* upon storing to a clean temp entry - schedule its cleanup */
+		spin_lock_irq(&ent->mkeys_queue.lock);
+		if (ent->is_tmp && !ent->tmp_cleanup_scheduled) {
+			mod_delayed_work(ent->dev->cache.wq, &ent->dwork,
+					 msecs_to_jiffies(30 * 1000));
+			ent->tmp_cleanup_scheduled = true;
+		}
+		spin_unlock_irq(&ent->mkeys_queue.lock);
 		return 0;
+	}
 
 	if (ent) {
 		spin_lock_irq(&ent->mkeys_queue.lock);
-- 
2.46.0


