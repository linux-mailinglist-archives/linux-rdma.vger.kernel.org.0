Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 43AE5171752
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729049AbgB0Mee (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:34:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:35432 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgB0Mee (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:34:34 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D99EF24697;
        Thu, 27 Feb 2020 12:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806873;
        bh=wa6SY5DbPfBKEVEs4wmpMZfF3vy/PcqoA3oJKYwKaDE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vGDoL5ANQbzKDd/vkg2Gm8hgAkJ1/KnrDfR9iVyNI4UD28wYcIDOjt7MXfZWFx1mI
         CDFmPmUBolLxinb3/6bxqJDepuzqXE4sXm4A31/mF6e0Wh48t7NkN4WM7u66PGc4fF
         IZgun2xQlnXiOHjaFVMMqJ+NMMiR+gaRIW9bLhy8=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 9/9] RDMA/mlx5: Allow MRs to be created in the cache synchronously
Date:   Thu, 27 Feb 2020 14:34:00 +0200
Message-Id: <20200227123400.97758-10-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227123400.97758-1-leon@kernel.org>
References: <20200227123400.97758-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

If the cache is completely out of MRs, and we are running in cache mode,
then directly, and synchronously, create an MR that is compatible with the
cache bucket using a sleeping mailbox command. This ensures that the
thread that is waiting for the MR absolutely will get one.

When a MR allocated in this way becomes freed then it is compatible with
the cache bucket and will be recycled back into it.

Deletes the very buggy ent->compl scheme to create a synchronous MR
allocation.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   1 -
 drivers/infiniband/hw/mlx5/mr.c      | 173 ++++++++++++++++-----------
 2 files changed, 105 insertions(+), 69 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index e997837e600c..0ea8d57827fb 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -726,7 +726,6 @@ struct mlx5_cache_ent {
 	struct mlx5_ib_dev     *dev;
 	struct work_struct	work;
 	struct delayed_work	dwork;
-	struct completion	compl;
 };
 
 struct mlx5_mr_cache {
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c15de55c5a73..e64ac5a8434e 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -89,13 +89,29 @@ static int create_mkey_cb(struct mlx5_core_dev *dev, struct mlx5_ib_mr *mr,
 				callback, &mr->cb_work);
 }
 
+static void finalize_new_mr(struct mlx5_ib_mr *mr)
+{
+	struct mlx5_ib_dev *dev = mr->dev;
+	unsigned long flags;
+	u8 key;
+
+	mr->mmkey.type = MLX5_MKEY_MR;
+	spin_lock_irqsave(&dev->mdev->priv.mkey_lock, flags);
+	key = dev->mdev->priv.mkey_key++;
+	spin_unlock_irqrestore(&dev->mdev->priv.mkey_lock, flags);
+	mr->mmkey.key = mlx5_idx_to_mkey(MLX5_GET(create_mkey_out, mr->out,
+						  mkey_index)) |
+			key;
+
+	WRITE_ONCE(dev->cache.last_add, jiffies);
+}
+
 static void reg_mr_callback(int status, struct mlx5_async_work *context)
 {
 	struct mlx5_ib_mr *mr =
 		container_of(context, struct mlx5_ib_mr, cb_work);
 	struct mlx5_ib_dev *dev = mr->dev;
 	struct mlx5_cache_ent *ent = mr->cache_ent;
-	u8 key;
 	unsigned long flags;
 
 	if (status) {
@@ -109,13 +125,7 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 		return;
 	}
 
-	mr->mmkey.type = MLX5_MKEY_MR;
-	spin_lock_irqsave(&dev->mdev->priv.mkey_lock, flags);
-	key = dev->mdev->priv.mkey_key++;
-	spin_unlock_irqrestore(&dev->mdev->priv.mkey_lock, flags);
-	mr->mmkey.key = mlx5_idx_to_mkey(MLX5_GET(create_mkey_out, mr->out, mkey_index)) | key;
-
-	WRITE_ONCE(dev->cache.last_add, jiffies);
+	finalize_new_mr(mr);
 
 	spin_lock_irqsave(&ent->lock, flags);
 	list_add_tail(&mr->list, &ent->head);
@@ -125,14 +135,34 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 	queue_adjust_cache_locked(ent);
 	ent->pending--;
 	spin_unlock_irqrestore(&ent->lock, flags);
+}
+
+static struct mlx5_ib_mr *alloc_cache_mr(struct mlx5_cache_ent *ent, void *mkc)
+{
+	struct mlx5_ib_mr *mr;
+
+	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+	if (!mr)
+		return NULL;
+	mr->order = ent->order;
+	mr->cache_ent = ent;
+	mr->dev = ent->dev;
 
-	if (!completion_done(&ent->compl))
-		complete(&ent->compl);
+	MLX5_SET(mkc, mkc, free, 1);
+	MLX5_SET(mkc, mkc, umr_en, 1);
+	MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
+	MLX5_SET(mkc, mkc, access_mode_4_2, (ent->access_mode >> 2) & 0x7);
+
+	MLX5_SET(mkc, mkc, qpn, 0xffffff);
+	MLX5_SET(mkc, mkc, translations_octword_size, ent->xlt);
+	MLX5_SET(mkc, mkc, log_page_size, ent->page);
+	return mr;
 }
 
+/* Asynchronously schedule new MRs to be populated in the cache. */
 static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 {
-	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	struct mlx5_ib_mr *mr;
 	void *mkc;
 	u32 *in;
@@ -145,25 +175,11 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 	for (i = 0; i < num; i++) {
-		mr = kzalloc(sizeof(*mr), GFP_KERNEL);
+		mr = alloc_cache_mr(ent, mkc);
 		if (!mr) {
 			err = -ENOMEM;
 			break;
 		}
-		mr->order = ent->order;
-		mr->cache_ent = ent;
-		mr->dev = ent->dev;
-
-		MLX5_SET(mkc, mkc, free, 1);
-		MLX5_SET(mkc, mkc, umr_en, 1);
-		MLX5_SET(mkc, mkc, access_mode_1_0, ent->access_mode & 0x3);
-		MLX5_SET(mkc, mkc, access_mode_4_2,
-			 (ent->access_mode >> 2) & 0x7);
-
-		MLX5_SET(mkc, mkc, qpn, 0xffffff);
-		MLX5_SET(mkc, mkc, translations_octword_size, ent->xlt);
-		MLX5_SET(mkc, mkc, log_page_size, ent->page);
-
 		spin_lock_irq(&ent->lock);
 		if (ent->pending >= MAX_PENDING_REG_MR) {
 			err = -EAGAIN;
@@ -190,6 +206,44 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 	return err;
 }
 
+/* Synchronously create a MR in the cache */
+static struct mlx5_ib_mr *create_cache_mr(struct mlx5_cache_ent *ent)
+{
+	size_t inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
+	struct mlx5_ib_mr *mr;
+	void *mkc;
+	u32 *in;
+	int err;
+
+	in = kzalloc(inlen, GFP_KERNEL);
+	if (!in)
+		return ERR_PTR(-ENOMEM);
+	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
+
+	mr = alloc_cache_mr(ent, mkc);
+	if (!mr) {
+		err = -ENOMEM;
+		goto free_in;
+	}
+
+	err = mlx5_core_create_mkey(ent->dev->mdev, &mr->mmkey, in, inlen);
+	if (err)
+		goto free_mr;
+
+	mr->mmkey.type = MLX5_MKEY_MR;
+	WRITE_ONCE(ent->dev->cache.last_add, jiffies);
+	spin_lock_irq(&ent->lock);
+	ent->total_mrs++;
+	spin_unlock_irq(&ent->lock);
+	kfree(in);
+	return mr;
+free_mr:
+	kfree(mr);
+free_in:
+	kfree(in);
+	return ERR_PTR(err);
+}
+
 static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_mr *mr;
@@ -412,12 +466,12 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		if (ent->disabled)
 			goto out;
 		if (err) {
-			if (err == -EAGAIN) {
-				mlx5_ib_dbg(dev, "returned eagain, order %d\n",
-					    ent->order);
-				queue_delayed_work(cache->wq, &ent->dwork,
-						   msecs_to_jiffies(3));
-			} else {
+			/*
+			 * EAGAIN only happens if pending is positive, so we
+			 * will be rescheduled from reg_mr_callback(). The only
+			 * failure path here is ENOMEM.
+			 */
+			if (err != -EAGAIN) {
 				mlx5_ib_warn(
 					dev,
 					"command failed order %d, err %d\n",
@@ -480,36 +534,30 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 	struct mlx5_mr_cache *cache = &dev->cache;
 	struct mlx5_cache_ent *ent;
 	struct mlx5_ib_mr *mr;
-	int err;
 
 	if (WARN_ON(entry <= MR_CACHE_LAST_STD_ENTRY ||
 		    entry >= ARRAY_SIZE(cache->ent)))
 		return ERR_PTR(-EINVAL);
 
 	ent = &cache->ent[entry];
-	while (1) {
-		spin_lock_irq(&ent->lock);
-		if (list_empty(&ent->head)) {
-			spin_unlock_irq(&ent->lock);
-
-			err = add_keys(ent, 1);
-			if (err && err != -EAGAIN)
-				return ERR_PTR(err);
-
-			wait_for_completion(&ent->compl);
-		} else {
-			mr = list_first_entry(&ent->head, struct mlx5_ib_mr,
-					      list);
-			list_del(&mr->list);
-			ent->available_mrs--;
-			queue_adjust_cache_locked(ent);
-			spin_unlock_irq(&ent->lock);
+	spin_lock_irq(&ent->lock);
+	if (list_empty(&ent->head)) {
+		spin_unlock_irq(&ent->lock);
+		mr = create_cache_mr(ent);
+		if (IS_ERR(mr))
 			return mr;
-		}
+	} else {
+		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
+		list_del(&mr->list);
+		ent->available_mrs--;
+		queue_adjust_cache_locked(ent);
+		spin_unlock_irq(&ent->lock);
 	}
+	return mr;
 }
 
-static struct mlx5_ib_mr *alloc_cached_mr(struct mlx5_cache_ent *req_ent)
+/* Return a MR already available in the cache */
+static struct mlx5_ib_mr *get_cache_mr(struct mlx5_cache_ent *req_ent)
 {
 	struct mlx5_ib_dev *dev = req_ent->dev;
 	struct mlx5_ib_mr *mr = NULL;
@@ -661,7 +709,6 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 		ent->dev = dev;
 		ent->limit = 0;
 
-		init_completion(&ent->compl);
 		INIT_WORK(&ent->work, cache_work_func);
 		INIT_DELAYED_WORK(&ent->dwork, delayed_cache_work_func);
 
@@ -925,26 +972,16 @@ alloc_mr_from_cache(struct ib_pd *pd, struct ib_umem *umem, u64 virt_addr,
 	struct mlx5_ib_dev *dev = to_mdev(pd->device);
 	struct mlx5_cache_ent *ent = mr_cache_ent_from_order(dev, order);
 	struct mlx5_ib_mr *mr;
-	int err = 0;
-	int i;
 
 	if (!ent)
 		return ERR_PTR(-E2BIG);
-	for (i = 0; i < 1; i++) {
-		mr = alloc_cached_mr(ent);
-		if (mr)
-			break;
-
-		err = add_keys(ent, 1);
-		if (err && err != -EAGAIN) {
-			mlx5_ib_warn(dev, "add_keys failed, err %d\n", err);
-			break;
-		}
+	mr = get_cache_mr(ent);
+	if (!mr) {
+		mr = create_cache_mr(ent);
+		if (IS_ERR(mr))
+			return mr;
 	}
 
-	if (!mr)
-		return ERR_PTR(-EAGAIN);
-
 	mr->ibmr.pd = pd;
 	mr->umem = umem;
 	mr->access_flags = access_flags;
-- 
2.24.1

