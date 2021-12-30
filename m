Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 416D7481BB2
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Dec 2021 12:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238974AbhL3LX7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 Dec 2021 06:23:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238933AbhL3LX4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 Dec 2021 06:23:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34715C061574;
        Thu, 30 Dec 2021 03:23:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CD1CFB80B3A;
        Thu, 30 Dec 2021 11:23:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1288C36AEA;
        Thu, 30 Dec 2021 11:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640863432;
        bh=BTppMV9tZIN/oliwuCnQUNrOKLjUHpfqt6y+/FO633A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ew2t6SJsyetKZFBdU2sOBUE6Mzd6hAo01iI7/E/lAh9kqKILuJtFy7GRep1z+wDGm
         zu30aZYiP6zchlPfVfG5RLlD+az/NkCTo1LqmIFde1zttGze8lMAgV5+y/kTI7LWVl
         ktBmTrxLB+p1vgiyUZ+qm0MYfQR6Bh0TjGuBZc+fJ3BtT+C6tqb+Oahri8XaWHqb2v
         jjUyr6xJDF9PPoWp/nwgGC4yA0K5jAdk3Liv86JncwVT1cPfR7HlkaZEX/Ihg2EO0I
         kMDG2ZvZi8foC357rR/WIrpDvvjpIvXexikqp0ysvEU6u7JOkQIjeqWHEb4t3NTl4H
         Ul7JYfbdINz7w==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 3/7] RDMA/mlx5: Store in the cache mkeys instead of mrs
Date:   Thu, 30 Dec 2021 13:23:20 +0200
Message-Id: <0d3379edbf41911646cd7a20020bf5a28dcd603f.1640862842.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640862842.git.leonro@nvidia.com>
References: <cover.1640862842.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Currently, the driver stores the entire mlx5_ib_mr struct in the cache,
although the only use of the cached MR is the mkey. Store only the mkey
in the cache.

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  25 ++---
 drivers/infiniband/hw/mlx5/mr.c      | 161 +++++++++++++--------------
 2 files changed, 83 insertions(+), 103 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 213894053bfe..cfc77d43c7a8 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -641,6 +641,7 @@ struct mlx5_ib_mkey {
 	unsigned int ndescs;
 	struct wait_queue_head wait;
 	refcount_t usecount;
+	struct mlx5_cache_ent *cache_ent;
 };
 
 #define MLX5_IB_MTT_PRESENT (MLX5_IB_MTT_READ | MLX5_IB_MTT_WRITE)
@@ -663,20 +664,9 @@ struct mlx5_ib_mr {
 	struct ib_mr ibmr;
 	struct mlx5_ib_mkey mmkey;
 
-	/* User MR data */
-	struct mlx5_cache_ent *cache_ent;
-	/* Everything after cache_ent is zero'd when MR allocated */
 	struct ib_umem *umem;
 
 	union {
-		/* Used only while the MR is in the cache */
-		struct {
-			u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
-			struct mlx5_async_work cb_work;
-			/* Cache list element */
-			struct list_head list;
-		};
-
 		/* Used only by kernel MRs (umem == NULL) */
 		struct {
 			void *descs;
@@ -716,12 +706,6 @@ struct mlx5_ib_mr {
 	};
 };
 
-/* Zero the fields in the mr that are variant depending on usage */
-static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
-{
-	memset_after(mr, 0, cache_ent);
-}
-
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
 {
 	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && mr->umem &&
@@ -785,6 +769,13 @@ struct mlx5_cache_ent {
 	struct delayed_work	dwork;
 };
 
+struct mlx5_async_create_mkey {
+	u32 out[MLX5_ST_SZ_DW(create_mkey_out)];
+	struct mlx5_async_work cb_work;
+	struct mlx5_cache_ent *ent;
+	u32 mkey;
+};
+
 struct mlx5_mr_cache {
 	struct workqueue_struct *wq;
 	struct mlx5_cache_ent	ent[MAX_MR_CACHE_ENTRIES];
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 8936b504ff99..204c37a37421 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -88,15 +88,14 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
 	MLX5_SET64(mkc, mkc, start_addr, start_addr);
 }
 
-static void assign_mkey_variant(struct mlx5_ib_dev *dev,
-				struct mlx5_ib_mkey *mkey, u32 *in)
+static void assign_mkey_variant(struct mlx5_ib_dev *dev, u32 *mkey, u32 *in)
 {
 	u8 key = atomic_inc_return(&dev->mkey_var);
 	void *mkc;
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 	MLX5_SET(mkc, mkc, mkey_7_0, key);
-	mkey->key = key;
+	*mkey = key;
 }
 
 static int mlx5_ib_create_mkey(struct mlx5_ib_dev *dev,
@@ -104,7 +103,7 @@ static int mlx5_ib_create_mkey(struct mlx5_ib_dev *dev,
 {
 	int ret;
 
-	assign_mkey_variant(dev, mkey, in);
+	assign_mkey_variant(dev, &mkey->key, in);
 	ret = mlx5_core_create_mkey(dev->mdev, &mkey->key, in, inlen);
 	if (!ret)
 		init_waitqueue_head(&mkey->wait);
@@ -113,8 +112,7 @@ static int mlx5_ib_create_mkey(struct mlx5_ib_dev *dev,
 }
 
 static int
-mlx5_ib_create_mkey_cb(struct mlx5_ib_dev *dev,
-		       struct mlx5_ib_mkey *mkey,
+mlx5_ib_create_mkey_cb(struct mlx5_ib_dev *dev, u32 *mkey,
 		       struct mlx5_async_ctx *async_ctx,
 		       u32 *in, int inlen, u32 *out, int outlen,
 		       struct mlx5_async_work *context)
@@ -142,16 +140,16 @@ static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 
 static void create_mkey_callback(int status, struct mlx5_async_work *context)
 {
-	struct mlx5_ib_mr *mr =
-		container_of(context, struct mlx5_ib_mr, cb_work);
-	struct mlx5_cache_ent *ent = mr->cache_ent;
+	struct mlx5_async_create_mkey *mkey_out =
+		container_of(context, struct mlx5_async_create_mkey, cb_work);
+	struct mlx5_cache_ent *ent = mkey_out->ent;
 	struct mlx5_ib_dev *dev = ent->dev;
 	unsigned long flags;
 	void *old;
 
 	if (status) {
 		mlx5_ib_warn(dev, "async reg mr failed. status %d\n", status);
-		kfree(mr);
+		kfree(mkey_out);
 		xa_lock_irqsave(&ent->mkeys, flags);
 		ent->reserved--;
 		old = __xa_erase(&ent->mkeys, ent->reserved);
@@ -162,32 +160,24 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 		return;
 	}
 
-	mr->mmkey.type = MLX5_MKEY_MR;
-	mr->mmkey.key |= mlx5_idx_to_mkey(
-		MLX5_GET(create_mkey_out, mr->out, mkey_index));
-	init_waitqueue_head(&mr->mmkey.wait);
-
+	mkey_out->mkey |= mlx5_idx_to_mkey(
+		MLX5_GET(create_mkey_out, mkey_out->out, mkey_index));
 	WRITE_ONCE(dev->cache.last_add, jiffies);
 
 	xa_lock_irqsave(&ent->mkeys, flags);
-	old = __xa_store(&ent->mkeys, ent->stored, mr, GFP_ATOMIC);
+	old = __xa_store(&ent->mkeys, ent->stored, xa_mk_value(mkey_out->mkey),
+			 GFP_ATOMIC);
 	WARN_ON(old != NULL);
 	ent->stored++;
 	ent->total_mrs++;
 	/* If we are doing fill_to_high_water then keep going. */
 	queue_adjust_cache_locked(ent);
 	xa_unlock_irqrestore(&ent->mkeys, flags);
+	kfree(mkey_out);
 }
 
-static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
+static void set_cache_mkc(struct mlx5_cache_ent *ent, void *mkc)
 {
-	struct mlx5_ib_mr *mr;
-
-	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
-	if (!mr)
-		return NULL;
-	mr->cache_ent = ent;
-
 	set_mkc_access_pd_addr_fields(mkc, 0, 0, ent->dev->umrc.pd);
 	MLX5_SET(mkc, mkc, free, 1);
 	MLX5_SET(mkc, mkc, umr_en, 1);
@@ -196,7 +186,6 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 
 	MLX5_SET(mkc, mkc, translations_octword_size, ent->xlt);
 	MLX5_SET(mkc, mkc, log_page_size, ent->page);
-	return mr;
 }
 
 static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
@@ -239,7 +228,7 @@ static int push_reserve_mkey(struct mlx5_cache_ent *ent)
 static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 {
 	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	struct mlx5_ib_mr *mr;
+	struct mlx5_async_create_mkey *async_out;
 	void *mkc, *old;
 	u32 *in;
 	int err = 0;
@@ -250,12 +239,15 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 		return -ENOMEM;
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	set_cache_mkc(ent, mkc);
 	for (i = 0; i < num; i++) {
-		mr = alloc_cache_mr(ent, mkc);
-		if (!mr) {
+		async_out = kzalloc(sizeof(struct mlx5_async_create_mkey),
+				    GFP_KERNEL);
+		if (!async_out) {
 			err = -ENOMEM;
 			goto err;
 		}
+		async_out->ent = ent;
 
 		xa_lock_irq(&ent->mkeys);
 		err = _push_reserve_mkey(ent);
@@ -266,11 +258,11 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 			goto err_undo_reserve;
 		}
 		xa_unlock_irq(&ent->mkeys);
-
-		err = mlx5_ib_create_mkey_cb(ent->dev, &mr->mmkey,
+		err = mlx5_ib_create_mkey_cb(ent->dev, &async_out->mkey,
 					     &ent->dev->async_ctx, in, inlen,
-					     mr->out, sizeof(mr->out),
-					     &mr->cb_work);
+					     async_out->out,
+					     sizeof(async_out->out),
+					     &async_out->cb_work);
 		if (err) {
 			mlx5_ib_warn(ent->dev, "create mkey failed %d\n", err);
 			xa_lock_irq(&ent->mkeys);
@@ -287,68 +279,55 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 	WARN_ON(old != NULL);
 err_unlock:
 	xa_unlock_irq(&ent->mkeys);
-	kfree(mr);
+	kfree(async_out);
 err:
 	kfree(in);
 	return err;
 }
 
 /* Synchronously create a MR in the cache */
-static struct mlx5_ib_mr *create_cache_mr(struct mlx5_cache_ent *ent)
+static int create_cache_mkey(struct mlx5_cache_ent *ent, u32 *mkey)
 {
 	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	struct mlx5_ib_mr *mr;
 	void *mkc;
 	u32 *in;
 	int err;
 
 	in = kzalloc(inlen, GFP_KERNEL);
 	if (!in)
-		return ERR_PTR(-ENOMEM);
+		return -ENOMEM;
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+	set_cache_mkc(ent, mkc);
 
-	mr = alloc_cache_mr(ent, mkc);
-	if (!mr) {
-		err = -ENOMEM;
-		goto free_in;
-	}
-
-	err = mlx5_core_create_mkey(ent->dev->mdev, &mr->mmkey.key, in, inlen);
+	err = mlx5_core_create_mkey(ent->dev->mdev, mkey, in, inlen);
 	if (err)
-		goto free_mr;
+		goto free_in;
 
-	init_waitqueue_head(&mr->mmkey.wait);
-	mr->mmkey.type = MLX5_MKEY_MR;
 	WRITE_ONCE(ent->dev->cache.last_add, jiffies);
 	xa_lock_irq(&ent->mkeys);
 	ent->total_mrs++;
 	xa_unlock_irq(&ent->mkeys);
-	kfree(in);
-	return mr;
-free_mr:
-	kfree(mr);
 free_in:
 	kfree(in);
-	return ERR_PTR(err);
+	return err;
 }
 
 static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 {
-	struct mlx5_ib_mr *mr;
-	void *old;
+	void *old, *xa_mkey;
 
 	if (!ent->stored)
 		return;
 	ent->stored--;
-	mr = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY, GFP_KERNEL);
-	WARN_ON(mr == NULL || xa_is_err(mr));
+	xa_mkey =
+		__xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY, GFP_KERNEL);
+	WARN_ON(xa_mkey == NULL || xa_is_err(xa_mkey));
 	ent->reserved--;
 	old = __xa_erase(&ent->mkeys, ent->reserved);
 	WARN_ON(old != NULL);
 	ent->total_mrs--;
 	xa_unlock_irq(&ent->mkeys);
-	mlx5_core_destroy_mkey(ent->dev->mdev, mr->mmkey.key);
-	kfree(mr);
+	mlx5_core_destroy_mkey(ent->dev->mdev, (u32)xa_to_value(xa_mkey));
 	xa_lock_irq(&ent->mkeys);
 }
 
@@ -620,12 +599,16 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       int access_flags)
 {
 	struct mlx5_ib_mr *mr;
-	void *old;
+	void *old, *xa_mkey;
+	int err;
 
-	/* Matches access in alloc_cache_mr() */
 	if (!mlx5_ib_can_reconfig_with_umr(dev, 0, access_flags))
 		return ERR_PTR(-EOPNOTSUPP);
 
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return ERR_PTR(-ENOMEM);
+
 	xa_lock_irq(&ent->mkeys);
 	if (!ent->stored) {
 		if (ent->limit) {
@@ -633,32 +616,39 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 			ent->miss++;
 		}
 		xa_unlock_irq(&ent->mkeys);
-		mr = create_cache_mr(ent);
-		if (IS_ERR(mr))
-			return mr;
+		err = create_cache_mkey(ent, &mr->mmkey.key);
+		if (err) {
+			kfree(mr);
+			return ERR_PTR(err);
+		}
 	} else {
 		ent->stored--;
-		mr = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY,
-				GFP_KERNEL);
-		WARN_ON(mr == NULL || xa_is_err(mr));
+		xa_mkey = __xa_store(&ent->mkeys, ent->stored, XA_ZERO_ENTRY,
+				     GFP_KERNEL);
+		WARN_ON(xa_mkey == NULL || xa_is_err(xa_mkey));
 		ent->reserved--;
 		old = __xa_erase(&ent->mkeys, ent->reserved);
 		WARN_ON(old != NULL);
 		queue_adjust_cache_locked(ent);
 		xa_unlock_irq(&ent->mkeys);
 
-		mlx5_clear_mr(mr);
+		mr->mmkey.key = (u32)xa_to_value(xa_mkey);
 	}
+	mr->mmkey.cache_ent = ent;
+	mr->mmkey.type = MLX5_MKEY_MR;
+	init_waitqueue_head(&mr->mmkey.wait);
 	return mr;
+
 }
 
 static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
-	struct mlx5_cache_ent *ent = mr->cache_ent;
+	struct mlx5_cache_ent *ent = mr->mmkey.cache_ent;
 	void *old;
 
 	xa_lock_irq(&ent->mkeys);
-	old = __xa_store(&ent->mkeys, ent->stored, mr, 0);
+	old = __xa_store(&ent->mkeys, ent->stored, xa_mk_value(mr->mmkey.key),
+			 0);
 	WARN_ON(old != NULL);
 	ent->stored++;
 	queue_adjust_cache_locked(ent);
@@ -669,18 +659,17 @@ static void clean_keys(struct mlx5_ib_dev *dev, int c)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent = &cache->ent[c];
-	struct mlx5_ib_mr *mr;
+	void *xa_mkey;
 
 	cancel_delayed_work(&ent->dwork);
 	xa_lock_irq(&ent->mkeys);
 	while (ent->stored) {
 		ent->stored--;
-		mr = __xa_erase(&ent->mkeys, ent->stored);
-		WARN_ON(mr == NULL);
+		xa_mkey = __xa_erase(&ent->mkeys, ent->stored);
+		WARN_ON(xa_mkey == NULL);
 		ent->total_mrs--;
 		xa_unlock_irq(&ent->mkeys);
-		mlx5_core_destroy_mkey(dev->mdev, mr->mmkey.key);
-		kfree(mr);
+		mlx5_core_destroy_mkey(dev->mdev, (u32)xa_to_value(xa_mkey));
 		xa_lock_irq(&ent->mkeys);
 	}
 	xa_unlock_irq(&ent->mkeys);
@@ -1729,7 +1718,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 	struct mlx5_ib_dev *dev = to_mdev(mr->ibmr.device);
 
 	/* We only track the allocated sizes of MRs from the cache */
-	if (!mr->cache_ent)
+	if (!mr->mmkey.cache_ent)
 		return false;
 	if (!mlx5_ib_can_load_pas_with_umr(dev, new_umem->length))
 		return false;
@@ -1738,7 +1727,7 @@ static bool can_use_umr_rereg_pas(struct mlx5_ib_mr *mr,
 		mlx5_umem_find_best_pgsz(new_umem, mkc, log_page_size, 0, iova);
 	if (WARN_ON(!*page_size))
 		return false;
-	return (1ULL << mr->cache_ent->order) >=
+	return (1ULL << mr->mmkey.cache_ent->order) >=
 	       ib_umem_num_dma_blocks(new_umem, *page_size);
 }
 
@@ -1978,15 +1967,15 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 	}
 
 	/* Stop DMA */
-	if (mr->cache_ent) {
-		if (revoke_mr(mr) || push_reserve_mkey(mr->cache_ent)) {
-			xa_lock_irq(&mr->cache_ent->mkeys);
-			mr->cache_ent->total_mrs--;
-			xa_unlock_irq(&mr->cache_ent->mkeys);
-			mr->cache_ent = NULL;
+	if (mr->mmkey.cache_ent) {
+		if (revoke_mr(mr) || push_reserve_mkey(mr->mmkey.cache_ent)) {
+			xa_lock_irq(&mr->mmkey.cache_ent->mkeys);
+			mr->mmkey.cache_ent->total_mrs--;
+			xa_unlock_irq(&mr->mmkey.cache_ent->mkeys);
+			mr->mmkey.cache_ent = NULL;
 		}
 	}
-	if (!mr->cache_ent) {
+	if (!mr->mmkey.cache_ent) {
 		rc = destroy_mkey(to_mdev(mr->ibmr.device), mr);
 		if (rc)
 			return rc;
@@ -2003,12 +1992,12 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 			mlx5_ib_free_odp_mr(mr);
 	}
 
-	if (mr->cache_ent) {
+	if (mr->mmkey.cache_ent)
 		mlx5_mr_cache_free(dev, mr);
-	} else {
+	else
 		mlx5_free_priv_descs(mr);
-		kfree(mr);
-	}
+
+	kfree(mr);
 	return 0;
 }
 
-- 
2.33.1

