Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 35742171751
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Feb 2020 13:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729019AbgB0Meb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Feb 2020 07:34:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:35408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729004AbgB0Meb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Feb 2020 07:34:31 -0500
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C95332468E;
        Thu, 27 Feb 2020 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582806870;
        bh=sMuKOHalUGlssnvpMnuuqttJgSjQ9VXJHsK4k8TUGQU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vs8Op0ZZaJvq/MEEM/K0qXVf8nZMYDlmedO/pIX2GimbnL0uErcefsswTWWlevIXs
         cbimG2JpiQtKBXJh80cspWen1DcC5M6gJ4SemAMYzLNJz8YPU3FZqSFQZtznTeoM+G
         Q+s4HihzDWQnCx3ObgYRVHkrchq7nfvK+w4p7vRk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next 8/9] RDMA/mlx5: Revise how the hysteresis scheme works for cache filling
Date:   Thu, 27 Feb 2020 14:33:59 +0200
Message-Id: <20200227123400.97758-9-leon@kernel.org>
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

Currently if the work queue is running then it is in 'hysteresis' mode and
will fill until the cache reaches the high water mark. This implicit state
is very tricky and doesn't interact with pending very well.

Instead of self re-scheduling the work queue after the add_keys() has
started to create the new MR, have the queue scheduled from
reg_mr_callback() only after the requested MR has been added.

This avoids the bad design of an in-rush of queue'd work doing back to
back add_keys() until EAGAIN then sleeping. The add_keys() will be paced
one at a time as they complete, slowly filling up the cache.

Also, fix pending to be only manipulated under lock.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 +
 drivers/infiniband/hw/mlx5/mr.c      | 41 ++++++++++++++++++----------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 08554bd8941e..e997837e600c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -704,6 +704,7 @@ struct mlx5_cache_ent {
 	u32			page;
 
 	u8 disabled:1;
+	u8 fill_to_high_water:1;
 
 	/*
 	 * - available_mrs is the length of list head, ie the number of MRs
diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index f475284c618c..c15de55c5a73 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -50,6 +50,7 @@ enum {
 static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static int mr_cache_max_order(struct mlx5_ib_dev *dev);
+static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent);
 
 static bool umr_can_use_indirect_mkey(struct mlx5_ib_dev *dev)
 {
@@ -120,11 +121,9 @@ static void reg_mr_callback(int status, struct mlx5_async_work *context)
 	list_add_tail(&mr->list, &ent->head);
 	ent->available_mrs++;
 	ent->total_mrs++;
+	/* If we are doing fill_to_high_water then keep going. */
+	queue_adjust_cache_locked(ent);
 	ent->pending--;
-	/*
-	 * Creating is always done in response to some demand, so do not call
-	 * queue_adjust_cache_locked().
-	 */
 	spin_unlock_irqrestore(&ent->lock, flags);
 
 	if (!completion_done(&ent->compl))
@@ -369,11 +368,29 @@ static void queue_adjust_cache_locked(struct mlx5_cache_ent *ent)
 {
 	lockdep_assert_held(&ent->lock);
 
-	if (ent->disabled)
+	if (ent->disabled || READ_ONCE(ent->dev->fill_delay))
 		return;
-	if (ent->available_mrs < ent->limit ||
-	    ent->available_mrs > 2 * ent->limit)
+	if (ent->available_mrs < ent->limit) {
+		ent->fill_to_high_water = true;
+		queue_work(ent->dev->cache.wq, &ent->work);
+	} else if (ent->fill_to_high_water &&
+		   ent->available_mrs + ent->pending < 2 * ent->limit) {
+		/*
+		 * Once we start populating due to hitting a low water mark
+		 * continue until we pass the high water mark.
+		 */
 		queue_work(ent->dev->cache.wq, &ent->work);
+	} else if (ent->available_mrs == 2 * ent->limit) {
+		ent->fill_to_high_water = false;
+	} else if (ent->available_mrs > 2 * ent->limit) {
+		/* Queue deletion of excess entries */
+		ent->fill_to_high_water = false;
+		if (ent->pending)
+			queue_delayed_work(ent->dev->cache.wq, &ent->dwork,
+					   msecs_to_jiffies(1000));
+		else
+			queue_work(ent->dev->cache.wq, &ent->work);
+	}
 }
 
 static void __cache_work_func(struct mlx5_cache_ent *ent)
@@ -386,11 +403,11 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 	if (ent->disabled)
 		goto out;
 
-	if (ent->available_mrs + ent->pending < 2 * ent->limit &&
+	if (ent->fill_to_high_water &&
+	    ent->available_mrs + ent->pending < 2 * ent->limit &&
 	    !READ_ONCE(dev->fill_delay)) {
 		spin_unlock_irq(&ent->lock);
 		err = add_keys(ent, 1);
-
 		spin_lock_irq(&ent->lock);
 		if (ent->disabled)
 			goto out;
@@ -409,12 +426,6 @@ static void __cache_work_func(struct mlx5_cache_ent *ent)
 						   msecs_to_jiffies(1000));
 			}
 		}
-		/*
-		 * Once we start populating due to hitting a low water mark
-		 * continue until we pass the high water mark.
-		 */
-		if (ent->available_mrs + ent->pending < 2 * ent->limit)
-			queue_work(cache->wq, &ent->work);
 	} else if (ent->available_mrs > 2 * ent->limit) {
 		bool need_delay;
 
-- 
2.24.1

