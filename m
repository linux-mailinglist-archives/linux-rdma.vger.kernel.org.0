Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6427B171753
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729074AbgB0Meh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:34:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgB0Meh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:34:37 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EF1BC2468E;
        Thu, 27 Feb 2020 12:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806876;
        bh=EQoyce/8kNLGH872+QrL4MY6iLwyCujFngOgupj5YdM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omU9YQFF9Xqvc8iln7Wn236IW7DNXXwNHoeUhTQ2aQ23s+X6dNKDhE6g1xMVa3CF9
         qnIsJ0ITKqPmO6TPBW8gbRUE5PBMPIKns5LiL2TpKWWCKwFFyo9/fZ6kdUj1OEPTIA
         9ZyQ1hozirETWr3yjrZGTz4DJnulz4qORIdbLFSI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Eli Cohen <eli@mellanox.com>,
        Jack Morgenstein <jackm@dev.mellanox.co.il>,
        linux-rdma@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>
Subject: [PATCH rdma-next 5/9] RDMA/mlx5: Fix MR cache size and limit debugfs
Date:   Thu, 27 Feb 2020 14:33:56 +0200
Message-Id: <20200227123400.97758-6-leon@kernel.org>
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

The size_write function is supposed to adjust the total_mr's to match
the user's request, but lacks locking and safety checking.

total_mrs can only be adjusted by at most available_mrs. mrs already
assigned to users cannot be revoked. Ensure that the user provides
a target value within the range of available_mrs and within the high/low
water mark.

limit_write has confusing and wrong sanity checking, and doesn't have the
ability to deallocate on limit reduction.

Since both functions use the same algorithm to adjust the available_mrs,
consolidate it into one function and write it correctly. Fix the locking
and by holding the spinlock for all accesses to ent->X.

Always fail if the user provides a malformed string.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 152 ++++++++++++++++++--------------
 1 file changed, 88 insertions(+), 64 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index c951bb14de56..00d7dc4cd91b 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -126,7 +126,7 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 		complete(&ent->compl);
 }

-static int add_keys(struct mlx5_cache_ent *ent, int num)
+static int add_keys(struct mlx5_cache_ent *ent, unsigned int num)
 {
 	int inlen = MLX5_ST_SZ_BYTES(create_mkey_in);
 	struct mlx5_ib_mr *mr;
@@ -185,30 +185,54 @@ static int add_keys(struct mlx5_cache_ent *ent, int num)
 	return err;
 }

-static void remove_keys(struct mlx5_cache_ent *ent, int num)
+static void remove_cache_mr(struct mlx5_cache_ent *ent)
 {
-	struct mlx5_ib_mr *tmp_mr;
 	struct mlx5_ib_mr *mr;
-	LIST_HEAD(del_list);
-	int i;

-	for (i = 0; i < num; i++) {
-		spin_lock_irq(&ent->lock);
-		if (list_empty(&ent->head)) {
-			spin_unlock_irq(&ent->lock);
-			break;
-		}
-		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
-		list_move(&mr->list, &del_list);
-		ent->available_mrs--;
-		ent->total_mrs--;
+	spin_lock_irq(&ent->lock);
+	if (list_empty(&ent->head)) {
 		spin_unlock_irq(&ent->lock);
-		mlx5_core_destroy_mkey(ent->dev->mdev, &mr->mmkey);
+		return;
 	}
+	mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
+	list_del(&mr->list);
+	ent->available_mrs--;
+	ent->total_mrs--;
+	spin_unlock_irq(&ent->lock);
+	mlx5_core_destroy_mkey(ent->dev->mdev, &mr->mmkey);
+	kfree(mr);
+}

-	list_for_each_entry_safe(mr, tmp_mr, &del_list, list) {
-		list_del(&mr->list);
-		kfree(mr);
+static int resize_available_mrs(struct mlx5_cache_ent *ent, unsigned int target,
+				bool limit_fill)
+{
+	int err;
+
+	lockdep_assert_held(&ent->lock);
+
+	while (true) {
+		if (limit_fill)
+			target = ent->limit * 2;
+		if (target == ent->available_mrs + ent->pending)
+			return 0;
+		if (target > ent->available_mrs + ent->pending) {
+			u32 todo = target - (ent->available_mrs + ent->pending);
+
+			spin_unlock_irq(&ent->lock);
+			err = add_keys(ent, todo);
+			if (err == -EAGAIN)
+				usleep_range(3000, 5000);
+			spin_lock_irq(&ent->lock);
+			if (err) {
+				if (err != -EAGAIN)
+					return err;
+			} else
+				return 0;
+		} else {
+			spin_unlock_irq(&ent->lock);
+			remove_cache_mr(ent);
+			spin_lock_irq(&ent->lock);
+		}
 	}
 }

@@ -216,33 +240,38 @@ static ssize_t size_write(struct file *filp, const char __user *buf,
 			  size_t count, loff_t *pos)
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
-	char lbuf[20] = {0};
-	u32 var;
+	u32 target;
 	int err;

-	count = min(count, sizeof(lbuf) - 1);
-	if (copy_from_user(lbuf, buf, count))
-		return -EFAULT;
-
-	if (sscanf(lbuf, "%u", &var) != 1)
-		return -EINVAL;
-
-	if (var < ent->limit)
-		return -EINVAL;
-
-	if (var > ent->total_mrs) {
-		do {
-			err = add_keys(ent, var - ent->total_mrs);
-			if (err && err != -EAGAIN)
-				return err;
+	err = kstrtou32_from_user(buf, count, 0, &target);
+	if (err)
+		return err;

-			usleep_range(3000, 5000);
-		} while (err);
-	} else if (var < ent->total_mrs) {
-		remove_keys(ent, ent->total_mrs - var);
+	/*
+	 * Target is the new value of total_mrs the user requests, however we
+	 * cannot free MRs that are in use. Compute the target value for
+	 * available_mrs.
+	 */
+	spin_lock_irq(&ent->lock);
+	if (target < ent->total_mrs - ent->available_mrs) {
+		err = -EINVAL;
+		goto err_unlock;
+	}
+	target = target - (ent->total_mrs - ent->available_mrs);
+	if (target < ent->limit || target > ent->limit*2) {
+		err = -EINVAL;
+		goto err_unlock;
 	}
+	err = resize_available_mrs(ent, target, false);
+	if (err)
+		goto err_unlock;
+	spin_unlock_irq(&ent->lock);

 	return count;
+
+err_unlock:
+	spin_unlock_irq(&ent->lock);
+	return err;
 }

 static ssize_t size_read(struct file *filp, char __user *buf, size_t count,
@@ -270,28 +299,23 @@ static ssize_t limit_write(struct file *filp, const char __user *buf,
 			   size_t count, loff_t *pos)
 {
 	struct mlx5_cache_ent *ent = filp->private_data;
-	char lbuf[20] = {0};
 	u32 var;
 	int err;

-	count = min(count, sizeof(lbuf) - 1);
-	if (copy_from_user(lbuf, buf, count))
-		return -EFAULT;
-
-	if (sscanf(lbuf, "%u", &var) != 1)
-		return -EINVAL;
-
-	if (var > ent->total_mrs)
-		return -EINVAL;
+	err = kstrtou32_from_user(buf, count, 0, &var);
+	if (err)
+		return err;

+	/*
+	 * Upon set we immediately fill the cache to high water mark implied by
+	 * the limit.
+	 */
+	spin_lock_irq(&ent->lock);
 	ent->limit = var;
-
-	if (ent->available_mrs < ent->limit) {
-		err = add_keys(ent, 2 * ent->limit - ent->available_mrs);
-		if (err)
-			return err;
-	}
-
+	err = resize_available_mrs(ent, 0, true);
+	spin_unlock_irq(&ent->lock);
+	if (err)
+		return err;
 	return count;
 }

@@ -356,20 +380,20 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 		}
 	} else if (ent->available_mrs > 2 * ent->limit) {
 		/*
-		 * The remove_keys() logic is performed as garbage collection
-		 * task. Such task is intended to be run when no other active
-		 * processes are running.
+		 * The remove_cache_mr() logic is performed as garbage
+		 * collection task. Such task is intended to be run when no
+		 * other active processes are running.
 		 *
 		 * The need_resched() will return TRUE if there are user tasks
 		 * to be activated in near future.
 		 *
-		 * In such case, we don't execute remove_keys() and postpone
-		 * the garbage collection work to try to run in next cycle,
-		 * in order to free CPU resources to other tasks.
+		 * In such case, we don't execute remove_cache_mr() and postpone
+		 * the garbage collection work to try to run in next cycle, in
+		 * order to free CPU resources to other tasks.
 		 */
 		if (!need_resched() && !someone_adding(cache) &&
 		    time_after(jiffies, cache->last_add + 300 * HZ)) {
-			remove_keys(ent, 1);
+			remove_cache_mr(ent);
 			if (ent->available_mrs > ent->limit)
 				queue_work(cache->wq, &ent->work);
 		} else {
--
2.24.1

