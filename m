Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22D6469211
	for <lists+linux-rdma@lfdr.de>; Mon,  6 Dec 2021 10:11:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbhLFJOk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Dec 2021 04:14:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240055AbhLFJOk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Dec 2021 04:14:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EF0C061746;
        Mon,  6 Dec 2021 01:11:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1E87FB81020;
        Mon,  6 Dec 2021 09:11:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DE6C341C1;
        Mon,  6 Dec 2021 09:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638781868;
        bh=jauVzVBBw0KUBiEIOgCnAJsJQCPtzSu6u13LGVg1qgc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NUAZwM7NhpH7K78PYgTF9P/w4bytHOaProI+eE0ZCmJSiBGu03UurvMkRqvDkEh8M
         P4SwSoMKmgUU3zdlhUXI7SZbDpBFVGpDWki1ftPU6Te9gWOeaufa2JSAapwLG++YIu
         mAno6pTGkiPyYjYFa0lVETcBAayDdl1JrTnpjzjeuyIyFUXlJwatEb+DDnqh4CPH8X
         MKQcl+T0CXKqKjBUV0rp5t7spgAUJuybYrHXoiuy2HH8HwjM8FUiv3Y6kbQZ7JAGa9
         4dVG1kvOimb5s6wXTjEhTWpTxqbYcgsGaBkUGTSC/Rh2b2htO8xILA8b2FZcbPA3cE
         cYNBMiGZqxPhQ==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 3/7] RDMA/mlx5: Store in the cache mkeys instead of mrs
Date:   Mon,  6 Dec 2021 11:10:48 +0200
Message-Id: <5b5c16efea1cd0d8c113b13e1f2d9fb4e122545e.1638781506.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1638781506.git.leonro@nvidia.com>
References: <cover.1638781506.git.leonro@nvidia.com>
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
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  21 ++---
 drivers/infiniband/hw/mlx5/mr.c      | 135 +++++++++++++--------------
 2 files changed, 71 insertions(+), 85 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d0224f468169..9b12e970ca01 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -668,14 +668,6 @@ struct mlx5_ib_mr {
 
 	/* This is zero'd when the MR is allocated */
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
@@ -715,12 +707,6 @@ struct mlx5_ib_mr {
 	};
 };
 
-/* Zero the fields in the mr that are variant depending on usage */
-static inline void mlx5_clear_mr(struct mlx5_ib_mr *mr)
-{
-	memset(mr->out, 0, sizeof(*mr) - offsetof(struct mlx5_ib_mr, out));
-}
-
 static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
 {
 	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && mr->umem &&
@@ -786,6 +772,13 @@ struct mlx5_cache_ent {
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
index e62f8da8558d..e64f6466f13d 100644
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
 	void *xa_ent;
 
 	if (status) {
 		mlx5_ib_warn(dev, "async reg mr failed. status %d\n", status);
-		kfree(mr);
+		kfree(mkey_out);
 		xa_lock_irqsave(&ent->mkeys, flags);
 		xa_ent = __xa_erase(&ent->mkeys, ent->reserved--);
 		WARN_ON(xa_ent != NULL);
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
-	xa_ent = __xa_store(&ent->mkeys, ent->stored++, mr, GFP_ATOMIC);
+	xa_ent = __xa_store(&ent->mkeys, ent->stored++,
+			    xa_mk_value(mkey_out->mkey), GFP_ATOMIC);
 	WARN_ON(xa_ent != NULL);
 	ent->pending--;
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
@@ -196,7 +186,7 @@ static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
 
 	MLX5_SET(mkc, mkc, translations_octword_size, ent->xlt);
 	MLX5_SET(mkc, mkc, log_page_size, ent->page);
-	return mr;
+	return;
 }
 
 static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
@@ -222,7 +212,7 @@ static int _push_reserve_mkey(struct mlx5_cache_ent *ent)
 static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 {
 	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
-	struct mlx5_ib_mr *mr;
+	struct mlx5_async_create_mkey *async_out;
 	void *mkc;
 	u32 *in;
 	int err = 0;
@@ -233,32 +223,37 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
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
 			break;
 		}
+		async_out->ent = ent;
+
 		xa_lock_irq(&ent->mkeys);
 		if (ent->pending >= MAX_PENDING_REG_MR) {
 			xa_unlock_irq(&ent->mkeys);
 			err = -EAGAIN;
-			kfree(mr);
+			kfree(async_out);
 			break;
 		}
 
 		err = _push_reserve_mkey(ent);
 		if (err) {
 			xa_unlock_irq(&ent->mkeys);
-			kfree(mr);
+			kfree(async_out);
 			break;
 		}
 		ent->pending++;
 		xa_unlock_irq(&ent->mkeys);
-		err = mlx5_ib_create_mkey_cb(ent->dev, &mr->mmkey,
+		err = mlx5_ib_create_mkey_cb(ent->dev, &async_out->mkey,
 					     &ent->dev->async_ctx, in, inlen,
-					     mr->out, sizeof(mr->out),
-					     &mr->cb_work);
+					     async_out->out,
+					     sizeof(async_out->out),
+					     &async_out->cb_work);
 		if (err) {
 			xa_lock_irq(&ent->mkeys);
 			WARN_ON(__xa_erase(&ent->mkeys, ent->reserved--) !=
@@ -266,7 +261,7 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 			ent->pending--;
 			xa_unlock_irq(&ent->mkeys);
 			mlx5_ib_warn(ent->dev, "create mkey failed %d\n", err);
-			kfree(mr);
+			kfree(async_out);
 			break;
 		}
 	}
@@ -276,57 +271,44 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
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
+	void *xa_ent;
 
 	if (!ent->stored)
 		return;
-	mr = __xa_store(&ent->mkeys, --ent->stored, NULL, GFP_KERNEL);
-	WARN_ON(mr == NULL || xa_is_err(mr));
+	xa_ent = __xa_store(&ent->mkeys, --ent->stored, NULL, GFP_KERNEL);
+	WARN_ON(xa_ent == NULL || xa_is_err(xa_ent));
 	WARN_ON(__xa_erase(&ent->mkeys, --ent->reserved) != NULL);
 	ent->total_mrs--;
 	xa_unlock_irq(&ent->mkeys);
-	mlx5_core_destroy_mkey(ent->dev->mdev, mr->mmkey.key);
-	kfree(mr);
+	mlx5_core_destroy_mkey(ent->dev->mdev, (u32)xa_to_value(xa_ent));
 	xa_lock_irq(&ent->mkeys);
 }
 
@@ -598,11 +580,16 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 				       int access_flags)
 {
 	struct mlx5_ib_mr *mr;
+	void *xa_ent;
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
@@ -610,9 +597,11 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
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
 		mr = __xa_store(&ent->mkeys, --ent->stored, NULL,
 				GFP_KERNEL);
@@ -621,9 +610,13 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 		queue_adjust_cache_locked(ent);
 		xa_unlock_irq(&ent->mkeys);
 
-		mlx5_clear_mr(mr);
+		mr->mmkey.key = (u32)xa_to_value(xa_ent);
 	}
+	mr->cache_ent = ent;
+	mr->mmkey.type = MLX5_MKEY_MR;
+	init_waitqueue_head(&mr->mmkey.wait);
 	return mr;
+
 }
 
 static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
@@ -631,7 +624,8 @@ static void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 
 	xa_lock_irq(&ent->mkeys);
-	WARN_ON(__xa_store(&ent->mkeys, ent->stored++, mr, 0) != NULL);
+	WARN_ON(__xa_store(&ent->mkeys, ent->stored++,
+			   xa_mk_value(mr->mmkey.key), 0) != NULL);
 	queue_adjust_cache_locked(ent);
 	xa_unlock_irq(&ent->mkeys);
 }
@@ -640,17 +634,16 @@ static void clean_keys(struct mlx5_ib_dev *dev, int c)
 {
 	struct mlx5_mr_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent = &cache->ent[c];
-	struct mlx5_ib_mr *mr;
 	unsigned long index;
+	void *entry;
 
 	cancel_delayed_work(&ent->dwork);
-	xa_for_each(&ent->mkeys, index, mr) {
+	xa_for_each(&ent->mkeys, index, entry) {
 		xa_lock_irq(&ent->mkeys);
 		__xa_erase(&ent->mkeys, index);
 		ent->total_mrs--;
 		xa_unlock_irq(&ent->mkeys);
-		mlx5_core_destroy_mkey(dev->mdev, mr->mmkey.key);
-		kfree(mr);
+		mlx5_core_destroy_mkey(dev->mdev, (u32)xa_to_value(entry));
 	}
 }
 
@@ -1982,12 +1975,12 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
 			mlx5_ib_free_odp_mr(mr);
 	}
 
-	if (mr->cache_ent) {
+	if (mr->cache_ent)
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

