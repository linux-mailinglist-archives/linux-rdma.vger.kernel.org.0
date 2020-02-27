Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B82D17174F
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgB0MeZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:34:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:35358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgB0MeZ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:34:25 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9DF6D24698;
        Thu, 27 Feb 2020 12:34:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806864;
        bh=vGZDjvoB3hRn6vVB2bgV97lN4QLJhMdk9N5k1KLF2QM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y64UPFoFrP49sJc0dNu7RhNB30/e8Q12RACC9T5hrEiPE4S/qY2bGohTtFLr6oFif
         3h7a30E31wp+ySK5bDQVdJATMlQzvj+YMb3ap4q4JpqQcPCTdCgP5eU0xOFOyF2KIC
         AGbJavVmAMeF99hLMgWFpEo+CdweiiLW4g2yvzkA=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 6/9] RDMA/mlx5: Lock access to ent->available_mrs/limit when doing queue_work
Date:   Thu, 27 Feb 2020 14:33:57 +0200
Message-Id: <20200227123400.97758-7-leon@kernel.org>
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

Accesses to these members needs to be locked. There is no reason not
to hold a spinlock while calling queue_work(), so move the tests into
a helper and always call it under lock.

The helper should be called when available_mrs is adjusted.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 40 ++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 00d7dc4cd91b..17dda58360c4 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -120,6 +120,10 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
 	ent->total_mrs++;
+	/*
+	 * Creating is always done in response to some demand, so do not call
+	 * queue_adjust_cache_locked().
+	 */
 	spin_unlock_irqrestore(&ent->lock, flags);
 
 	if (!completion_done(&ent->compl))
@@ -352,6 +356,20 @@ static int someone_adding(struct mlx5_mr_cache *cache)
 	return 0;
 }
 
+/*
+ * Check if the bucket is outside the high/low water mark and schedule an async
+ * update. The cache refill has hysteresis, once the low water mark is hit it is
+ * refilled up to the high mark.
+ */
+static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
+{
+	lockdep_assert_held(&ent->lock);
+
+	if (ent->available_mrs < ent->limit ||
+	    ent->available_mrs > 2 * ent->limit)
+		queue_work(ent->dev->cache.wq, &ent->work);
+}
+
 static void __cache_work_func(struct mlx5_cache_ent *ent)
 {
 	struct mlx5_ib_dev *dev = ent->dev;
@@ -447,9 +465,8 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 					      list);
 			list_del(&mr->list);
 			ent->available_mrs--;
+			queue_adjust_cache_locked(ent);
 			spin_unlock_irq(&ent->lock);
-			if (ent->available_mrs < ent->limit)
-				queue_work(cache->wq, &ent->work);
 			return mr;
 		}
 	}
@@ -472,14 +489,12 @@ static struct mlx5_ib_mr *alloc_cached_mr(struct mlx5_cache_ent *req_ent)
 					      list);
 			list_del(&mr->list);
 			ent->available_mrs--;
+			queue_adjust_cache_locked(ent);
 			spin_unlock_irq(&ent->lock);
-			if (ent->available_mrs < ent->limit)
-				queue_work(dev->cache.wq, &ent->work);
 			break;
 		}
+		queue_adjust_cache_locked(ent);
 		spin_unlock_irq(&ent->lock);
-
-		queue_work(dev->cache.wq, &ent->work);
 	}
 
 	if (!mr)
@@ -501,7 +516,6 @@ static void detach_mr_from_cache(struct mlx5_ib_mr *mr)
 void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 {
 	struct mlx5_cache_ent *ent = mr->cache_ent;
-	int shrink = 0;
 
 	if (!ent)
 		return;
@@ -509,20 +523,14 @@ void mlx5_mr_cache_free(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	if (mlx5_mr_cache_invalidate(mr)) {
 		detach_mr_from_cache(mr);
 		destroy_mkey(dev, mr);
-		if (ent->available_mrs < ent->limit)
-			queue_work(dev->cache.wq, &ent->work);
 		return;
 	}
 
 	spin_lock_irq(&ent->lock);
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
-	if (ent->available_mrs > 2 * ent->limit)
-		shrink = 1;
+	queue_adjust_cache_locked(ent);
 	spin_unlock_irq(&ent->lock);
-
-	if (shrink)
-		queue_work(dev->cache.wq, &ent->work);
 }
 
 static void clean_keys(struct mlx5_ib_dev *dev, int c)
@@ -638,7 +646,9 @@ int mlx5_mr_cache_init(struct mlx5_ib_dev *dev)
 			ent->limit = dev->mdev->profile->mr_cache[i].limit;
 		else
 			ent->limit = 0;
-		queue_work(cache->wq, &ent->work);
+		spin_lock_irq(&ent->lock);
+		queue_adjust_cache_locked(ent);
+		spin_unlock_irq(&ent->lock);
 	}
 
 	mlx5_mr_cache_debugfs_init(dev);
-- 
2.24.1

