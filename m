Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6702F17F1DA
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 09:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726521AbgCJIXP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 04:23:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:44842 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725919AbgCJIXP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 04:23:15 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7231B24677;
        Tue, 10 Mar 2020 08:23:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583828594;
        bh=eJzpbLde5mtr4q2HnQK+Xf5A2S0BuxKX2rbXBHhzCWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=u7SLZMXslHM8hFhSF8in/Q5EsN6UukuHDaGZFOES+GrzznBinYcfT/DGHwd5oyrPm
         7VNuMU5oFZG/8IBmr9qR1swVBbMfqB30IakuOrzwHm6mrFbAI0nB5M9SODPJ6Hoc31
         rqHXOBXfZkEQJCyaDnsXQogRLHwSGxmusk+JQY+M=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next v1 10/12] RDMA/mlx5: Fix locking in MR cache work queue
Date:   Tue, 10 Mar 2020 10:22:36 +0200
Message-Id: <20200310082238.239865-11-leon@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200310082238.239865-1-leon@kernel.org>
References: <20200310082238.239865-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Jason Gunthorpe <jgg@mellanox.com>

All of the members of mlx5_cache_ent must be accessed while holding the
spinlock, add the missing spinlock in the __cache_work_func().

Using cache->stopped and flush_workqueue() is an inherently racy way to
shutdown self-scheduling work on a queue. Replace it with ent->disabled
under lock, and always check disabled before queuing any new work. Use
cancel_work_sync() to shutdown the queue.

Use READ_ONCE/WRITE_ONCE for dev->last_add to manage concurrency as
coherency is less important here.

Split fill_delay from the bitfield. C bitfield updates are not atomic and
this is just a mess. Use READ_ONCE/WRITE_ONCE, but this could also use
test_bit()/set_bit().

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   5 +-
 drivers/infiniband/hw/mlx5/mr.c      | 121 +++++++++++++++++----------
 2 files changed, 80 insertions(+), 46 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 58369d38d627..21345d7bafcb 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -704,6 +704,8 @@ struct mlx5_cache_ent {
 	u32			access_mode;
 	u32			page;
 
+	u8 disabled:1;
+
 	/*
 	 * - available_mrs is the length of list head, ie the number of MRs
 	 *   available for immediate allocation.
@@ -730,7 +732,6 @@ struct mlx5_cache_ent {
 struct mlx5_mr_cache {
 	struct workqueue_struct *wq;
 	struct mlx5_cache_ent	ent[MAX_MR_CACHE_ENTRIES];
-	int			stopped;
 	struct dentry		*root;
 	unsigned long		last_add;
 };
@@ -1002,10 +1003,10 @@ struct mlx5_ib_dev {
 	 */
 	struct mutex			cap_mask_mutex;
 	u8				ib_active:1;
-	u8				fill_delay:1;
 	u8				is_rep:1;
 	u8				lag_active:1;
 	u8				wc_support:1;
+	u8				fill_delay;
 	struct umr_common		umrc;
 	/* sync used page count stats
 	 */
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index b46039d86b98..424ce3de3865 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -113,13 +113,13 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 	struct mlx5_cache_ent *ent = mr->cache_ent;
 	unsigned long flags;
 
-	spin_lock_irqsave(&ent->lock, flags);
-	ent->pending--;
-	spin_unlock_irqrestore(&ent->lock, flags);
 	if (status) {
 		mlx5_ib_warn(dev, "async reg mr failed. status %d\n", status);
 		kfree(mr);
-		dev->fill_delay = 1;
+		spin_lock_irqsave(&ent->lock, flags);
+		ent->pending--;
+		WRITE_ONCE(dev->fill_delay, 1);
+		spin_unlock_irqrestore(&ent->lock, flags);
 		mod_timer(&dev->delay_timer, jiffies + HZ);
 		return;
 	}
@@ -128,12 +128,13 @@ static void create_mkey_callback(int status, struct mlx5_async_work *context)
 	mr->mmkey.key |= mlx5_idx_to_mkey(
 		MLX5_GET(create_mkey_out, mr->out, mkey_index));
 
-	dev->cache.last_add = jiffies;
+	WRITE_ONCE(dev->cache.last_add, jiffies);
 
 	spin_lock_irqsave(&ent->lock, flags);
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
 	ent->total_mrs++;
+	ent->pending--;
 	/*
 	 * Creating is always done in response to some demand, so do not call
 	 * queue_adjust_cache_locked().
@@ -159,11 +160,6 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 
 	mkc = MLX5_ADDR_OF(create_mkey_in, in, memory_key_mkey_entry);
 	for (i = 0; i < num; i++) {
-		if (ent->pending >= MAX_PENDING_REG_MR) {
-			err = -EAGAIN;
-			break;
-		}
-
 		mr = kzalloc(sizeof(*mr), GFP_KERNEL);
 		if (!mr) {
 			err = -ENOMEM;
@@ -184,6 +180,12 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 		MLX5_SET(mkc, mkc, log_page_size, ent->page);
 
 		spin_lock_irq(&ent->lock);
+		if (ent->pending >= MAX_PENDING_REG_MR) {
+			err = -EAGAIN;
+			spin_unlock_irq(&ent->lock);
+			kfree(mr);
+			break;
+		}
 		ent->pending++;
 		spin_unlock_irq(&ent->lock);
 		err = mlx5_ib_create_mkey_cb(ent->dev, &mr->mmkey,
@@ -204,15 +206,13 @@ static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 	return err;
 }
 
-static void remove_cache_mr(struct mlx5_cache_ent *ent)
+static void remove_cache_mr_locked(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_mr *mr;
 
-	spin_lock_irq(&ent->lock);
-	if (list_empty(&ent->head)) {
-		spin_unlock_irq(&ent->lock);
+	lockdep_assert_held(&ent->lock);
+	if (list_empty(&ent->head))
 		return;
-	}
 	mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
 	list_del(&mr->list);
 	ent->available_mrs--;
@@ -220,6 +220,7 @@ static void remove_cache_mr(struct mlx5_cache_ent *ent)
 	spin_unlock_irq(&ent->lock);
 	mlx5_core_destroy_mkey(ent->dev->mdev, &mr->mmkey);
 	kfree(mr);
+	spin_lock_irq(&ent->lock);
 }
 
 static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
@@ -248,9 +249,7 @@ static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
 			} else
 				return 0;
 		} else {
-			spin_unlock_irq(&ent->lock);
-			remove_cache_mr(ent);
-			spin_lock_irq(&ent->lock);
+			remove_cache_mr_locked(ent);
 		}
 	}
 }
@@ -359,16 +358,21 @@ static const struct file_operations limit_fops = {
 	.read	= limit_read,
 };
 
-static int someone_adding(struct mlx5_mr_cache *cache)
+static bool someone_adding(struct mlx5_mr_cache *cache)
 {
-	int i;
+	unsigned int i;
 
 	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
-		if (cache->ent[i].available_mrs < cache->ent[i].limit)
-			return 1;
-	}
+		struct mlx5_cache_ent *ent = &cache->ent[i];
+		bool ret;
 
-	return 0;
+		spin_lock_irq(&ent->lock);
+		ret = ent->available_mrs < ent->limit;
+		spin_unlock_irq(&ent->lock);
+		if (ret)
+			return true;
+	}
+	return false;
 }
 
 /*
@@ -380,6 +384,8 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 {
 	lockdep_assert_held(&ent->lock);
 
+	if (ent->disabled)
+		return;
 	if (ent->available_mrs < ent->limit ||
 	    ent->available_mrs > 2 * ent->limit)
 		queue_work(ent->dev->cache.wq, &ent->work);
@@ -391,27 +397,42 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 	struct mlx5_mr_cache *cache = &dev->cache;
 	int err;
 
-	if (cache->stopped)
-		return;
+	spin_lock_irq(&ent->lock);
+	if (ent->disabled)
+		goto out;
 
-	if (ent->available_mrs < 2 * ent->limit && !dev->fill_delay) {
+	if (ent->available_mrs + ent->pending < 2 * ent->limit &&
+	    !READ_ONCE(dev->fill_delay)) {
+		spin_unlock_irq(&ent->lock);
 		err = add_keys(ent, 1);
-		if (ent->available_mrs < 2 * ent->limit) {
+
+		spin_lock_irq(&ent->lock);
+		if (ent->disabled)
+			goto out;
+		if (err) {
 			if (err == -EAGAIN) {
 				mlx5_ib_dbg(dev, "returned eagain, order %d\n",
 					    ent->order);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(3));
-			} else if (err) {
-				mlx5_ib_warn(dev, "command failed order %d, err %d\n",
-					     ent->order, err);
+			} else {
+				mlx5_ib_warn(
+					dev,
+					"command failed order %d, err %d\n",
+					ent->order, err);
 				queue_delayed_work(cache->wq, &ent->dwork,
 						   msecs_to_jiffies(1000));
-			} else {
-				queue_work(cache->wq, &ent->work);
 			}
 		}
+		/*
+		 * Once we start populating due to hitting a low water mark
+		 * continue until we pass the high water mark.
+		 */
+		if (ent->available_mrs + ent->pending < 2 * ent->limit)
+			queue_work(cache->wq, &ent->work);
 	} else if (ent->available_mrs > 2 * ent->limit) {
+		bool need_delay;
+
 		/*
 		 * The remove_cache_mr() logic is performed as garbage
 		 * collection task. Such task is intended to be run when no
@@ -424,15 +445,20 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		 * the garbage collection work to try to run in next cycle, in
 		 * order to free CPU resources to other tasks.
 		 */
-		if (!need_resched() && !someone_adding(cache) &&
-		    time_after(jiffies, cache->last_add + 300 * HZ)) {
-			remove_cache_mr(ent);
-			if (ent->available_mrs > ent->limit)
-				queue_work(cache->wq, &ent->work);
-		} else {
+		spin_unlock_irq(&ent->lock);
+		need_delay = need_resched() || someone_adding(cache) ||
+			     time_after(jiffies,
+					READ_ONCE(cache->last_add) + 300 * HZ);
+		spin_lock_irq(&ent->lock);
+		if (ent->disabled)
+			goto out;
+		if (need_delay)
 			queue_delayed_work(cache->wq, &ent->dwork, 300 * HZ);
-		}
+		remove_cache_mr_locked(ent);
+		queue_adjust_cache_locked(ent);
 	}
+out:
+	spin_unlock_irq(&ent->lock);
 }
 
 static void delayed_cache_work_func(struct work_struct *work)
@@ -613,7 +639,7 @@ static void delay_time_func(struct timer_list *t)
 {
 	struct mlx5_ib_dev *dev = from_timer(dev, t, delay_timer);
 
-	dev->fill_delay = 0;
+	WRITE_ONCE(dev->fill_delay, 0);
 }
 
 int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
@@ -673,13 +699,20 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 
 int mlx5_mr_cache_cleanup(struct mlx5_ib_dev *dev)
 {
-	int i;
+	unsigned int i;
 
 	if (!dev->cache.wq)
 		return 0;
 
-	dev->cache.stopped = 1;
-	flush_workqueue(dev->cache.wq);
+	for (i = 0; i < MAX_MR_CACHE_ENTRIES; i++) {
+		struct mlx5_cache_ent *ent = &dev->cache.ent[i];
+
+		spin_lock_irq(&ent->lock);
+		ent->disabled = true;
+		spin_unlock_irq(&ent->lock);
+		cancel_work_sync(&ent->work);
+		cancel_delayed_work_sync(&ent->dwork);
+	}
 
 	mlx5_mr_cache_debugfs_cleanup(dev);
 	mlx5_cmd_cleanup_async_ctx(&dev->async_ctx);
-- 
2.24.1

