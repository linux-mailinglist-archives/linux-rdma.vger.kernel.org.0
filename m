Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22B2317174A
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:34:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728964AbgB0MeM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:34:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:35238 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgB0MeM (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:34:12 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31CFF2468E;
        Thu, 27 Feb 2020 12:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806851;
        bh=8g/kwiR7eIDIbEZaiAHKv9xAmB7+RpyhfO58LhZJIPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=abkQl+gmQn4xMGvwLFaBEGHAc6IXjB49X89Eb9Qdt6rXwc/YRSKkcAqHopv43CTeu
         UVeh/3OGiHDeUjZTBYYshOxb0yDm8UEePVoqGINqGj+375WqIvSr4Id4j9VWVp5egL
         5fGR/NKsYzsaS9sdrVxfA1hNLhB/V3+7ATOjsYvc=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 2/9] RDMA/mlx5: Rename the tracking variables for the MR cache
Date:   Thu, 27 Feb 2020 14:33:53 +0200
Message-Id: <20200227123400.97758-3-leon@kernel.org>
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

The old names do not clearly indicate the intent.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 19 +++++++---
 drivers/infiniband/hw/mlx5/mr.c      | 54 ++++++++++++++--------------
 2 files changed, 42 insertions(+), 31 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index fd812a24db25..2b566829427e 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -703,15 +703,26 @@ struct mlx5_cache_ent {
 	u32			access_mode;
 	u32			page;
 
-	u32			size;
-	u32                     cur;
+	/*
+	 * - available_mrs is the length of list head, ie the number of MRs
+	 *   available for immediate allocation.
+	 * - total_mrs is available_mrs plus all in use MRs that could be
+	 *   returned to the cache.
+	 * - limit is the low water mark for available_mrs, 2* limit is the
+	 *   upper water mark.
+	 * - pending is the number of MRs currently being created
+	 */
+	u32 total_mrs;
+	u32 available_mrs;
+	u32 limit;
+	u32 pending;
+
+	/* Statistics */
 	u32                     miss;
-	u32			limit;
 
 	struct mlx5_ib_dev     *dev;
 	struct work_struct	work;
 	struct delayed_work	dwork;
-	int			pending;
 	struct completion	compl;
 };
 
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index dea14477a676..9e504f18864a 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -130,8 +130,8 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 
 	spin_lock_irqsave(&ent->lock, flags);
 	list_add_tail(&mr->list, &ent->head);
-	ent->cur++;
-	ent->size++;
+	ent->available_mrs++;
+	ent->total_mrs++;
 	spin_unlock_irqrestore(&ent->lock, flags);
 
 	if (!completion_done(&ent->compl))
@@ -215,8 +215,8 @@ static void remove_keys(struct mlx5_ib_dev *dev, int c, int num)
 		}
 		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
 		list_move(&mr->list, &del_list);
-		ent->cur--;
-		ent->size--;
+		ent->available_mrs--;
+		ent->total_mrs--;
 		spin_unlock_irq(&ent->lock);
 		mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 	}
@@ -249,16 +249,16 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 	if (var < ent->limit)
 		return -EINVAL;
 
-	if (var > ent->size) {
+	if (var > ent->total_mrs) {
 		do {
-			err = add_keys(dev, c, var - ent->size);
+			err = add_keys(dev, c, var - ent->total_mrs);
 			if (err && err != -EAGAIN)
 				return err;
 
 			usleep_range(3000, 5000);
 		} while (err);
-	} else if (var < ent->size) {
-		remove_keys(dev, c, ent->size - var);
+	} else if (var < ent->total_mrs) {
+		remove_keys(dev, c, ent->total_mrs - var);
 	}
 
 	return count;
@@ -271,7 +271,7 @@ static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
 	char lbuf[20];
 	int err;
 
-	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->size);
+	err = snprintf(lbuf, sizeof(lbuf), "%d\n", ent->total_mrs);
 	if (err < 0)
 		return err;
 
@@ -304,13 +304,13 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 	if (sscanf(lbuf, "%u", &var) != 1)
 		return -EINVAL;
 
-	if (var > ent->size)
+	if (var > ent->total_mrs)
 		return -EINVAL;
 
 	ent->limit = var;
 
-	if (ent->cur < ent->limit) {
-		err = add_keys(dev, c, 2 * ent->limit - ent->cur);
+	if (ent->available_mrs < ent->limit) {
+		err = add_keys(dev, c, 2 * ent->limit - ent->available_mrs);
 		if (err)
 			return err;
 	}
@@ -344,7 +344,7 @@ static int someone_adding(struct mlx5_mr_cache *cache)
 	int i;
 
 	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
-		if (cache->ent[i].cur < cache->ent[i].limit)
+		if (cache->ent[i].available_mrs < cache->ent[i].limit)
 			return 1;
 	}
 
@@ -362,9 +362,9 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		return;
 
 	ent = &dev->cache.ent[i];
-	if (ent->cur < 2 * ent->limit && !dev->fill_delay) {
+	if (ent->available_mrs < 2 * ent->limit && !dev->fill_delay) {
 		err = add_keys(dev, i, 1);
-		if (ent->cur < 2 * ent->limit) {
+		if (ent->available_mrs < 2 * ent->limit) {
 			if (err == -EAGAIN) {
 				mlx5_ib_dbg(dev, "returned eagain, order %d\n",
 					    i + 2);
@@ -379,7 +379,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 				queue_work(cache->wq, &ent->work);
 			}
 		}
-	} else if (ent->cur > 2 * ent->limit) {
+	} else if (ent->available_mrs > 2 * ent->limit) {
 		/*
 		 * The remove_keys() logic is performed as garbage collection
 		 * task. Such task is intended to be run when no other active
@@ -395,7 +395,7 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		if (!need_resched() && !someone_adding(cache) &&
 		    time_after(jiffies, cache->last_add + 300 * HZ)) {
 			remove_keys(dev, i, 1);
-			if (ent->cur > ent->limit)
+			if (ent->available_mrs > ent->limit)
 				queue_work(cache->wq, &ent->work);
 		} else {
 			queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
@@ -446,9 +446,9 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev, int entry)
 			mr = list_first_entry(&ent->head, struct mlx5_ib_mr,
 					      list);
 			list_del(&mr->list);
-			ent->cur--;
+			ent->available_mrs--;
 			spin_unlock_irq(&ent->lock);
-			if (ent->cur < ent->limit)
+			if (ent->available_mrs < ent->limit)
 				queue_work(cache->wq, &ent->work);
 			return mr;
 		}
@@ -481,9 +481,9 @@ static struct mlx5_ib_mr *alloc_cached_mr(struct mlx5_ib_dev *dev, int order)
 			mr = list_first_entry(&ent->head, struct mlx5_ib_mr,
 					      list);
 			list_del(&mr->list);
-			ent->cur--;
+			ent->available_mrs--;
 			spin_unlock_irq(&ent->lock);
-			if (ent->cur < ent->limit)
+			if (ent->available_mrs < ent->limit)
 				queue_work(cache->wq, &ent->work);
 			break;
 		}
@@ -515,7 +515,7 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		mr->allocated_from_cache = false;
 		destroy_mkey(dev, mr);
 		ent = &cache->ent[c];
-		if (ent->cur < ent->limit)
+		if (ent->available_mrs < ent->limit)
 			queue_work(cache->wq, &ent->work);
 		return;
 	}
@@ -523,8 +523,8 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	ent = &cache->ent[c];
 	spin_lock_irq(&ent->lock);
 	list_add_tail(&mr->list, &ent->head);
-	ent->cur++;
-	if (ent->cur > 2 * ent->limit)
+	ent->available_mrs++;
+	if (ent->available_mrs > 2 * ent->limit)
 		shrink = 1;
 	spin_unlock_irq(&ent->lock);
 
@@ -549,8 +549,8 @@ static void clean_keys(struct mlx5_ib_dev *dev, int c)
 		}
 		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
 		list_move(&mr->list, &del_list);
-		ent->cur--;
-		ent->size--;
+		ent->available_mrs--;
+		ent->total_mrs--;
 		spin_unlock_irq(&ent->lock);
 		mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);
 	}
@@ -588,7 +588,7 @@ static void mlx5_mr_cache_debugfs_init(struct mlx5_ib_dev *dev)
 		dir = debugfs_create_dir(ent->name, cache->root);
 		debugfs_create_file("size", 0600, dir, ent, &size_fops);
 		debugfs_create_file("limit", 0600, dir, ent, &limit_fops);
-		debugfs_create_u32("cur", 0400, dir, &ent->cur);
+		debugfs_create_u32("cur", 0400, dir, &ent->available_mrs);
 		debugfs_create_u32("miss", 0600, dir, &ent->miss);
 	}
 }
-- 
2.24.1

