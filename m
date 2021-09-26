Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39703418759
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Sep 2021 10:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhIZId1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 26 Sep 2021 04:33:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:51638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229532AbhIZId1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 26 Sep 2021 04:33:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 778AC60EB6;
        Sun, 26 Sep 2021 08:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632645111;
        bh=Fs/wUc/Bv/3ccgsJnkJzIN5PvwkgGZqURMAtj+g4res=;
        h=From:To:Cc:Subject:Date:From;
        b=dxmbkyWNCWeAC84vZLSRI6seyo0WivEqA5M3gJUzOojF8af2ihTiu27oFcAJELeK3
         nJbSQwCMInroko5Kg3MzuH2PuUVAQfEe/lLl/LewGOmD1hmvTejImQ2ukvYA9pT+Ko
         pkMziuQRSYWb7kwbudmQa+9zrh5DJ5Q0UI8iKA+GRkc3yJ4M1HATpjqnuwna3Mh2ng
         x8SfN8b+VrEVAJEmyTzB4iahwNYcDue5ULU11CJy07v6wBBACmAAjXO9reX3BF7CFi
         /YdaR9WH50tMo9YNr75QOSSHkoZHjsltVU32F8zApHV239tMylosqeiN86x6u6478M
         anafDrHbNwVqg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Aharon Landau <aharonl@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH rdma-next] RDMA/mlx5: Avoid taking MRs from larger MR cache pools when a pool is empty
Date:   Sun, 26 Sep 2021 11:31:43 +0300
Message-Id: <71af2770c737b936f7b10f457f0ef303ffcf7ad7.1632644527.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Aharon Landau <aharonl@nvidia.com>

Currently, if a cache entry is empty, the driver will try to take MRs
from larger cache entries. This behavior consumes a lot of memory.
In addition, when searching for an mkey in an entry, the entry is locked.
When using a multithreaded application with the old behavior, the threads
will block each other more often, which can hurt performance as can be
seen in the table below.

Therefore, avoid it by creating a new mkey when the requested cache entry
is empty.

The test was performed on a machine with
Intel(R) Xeon(R) CPU E5-2699 v4 @ 2.20GHz 44 cores.

Here are the time measures for allocating MRs of 2^6 pages. The search in
the cache started from entry 6.

+------------+---------------------+---------------------+
|            |     Old behavior    |     New behavior    |
|            +----------+----------+----------+----------+
|            | 1 thread | 5 thread | 1 thread | 5 thread |
+============+==========+==========+==========+==========+
|  1,000 MRs |   14 ms  |   30 ms  |   14 ms  |   80 ms  |
+------------+----------+----------+----------+----------+
| 10,000 MRs |  135 ms  |   6 sec  |  173 ms  |  880 ms  |
+------------+----------+----------+----------+----------+
|100,000 MRs | 11.2 sec |  57 sec  | 1.74 sec |  8.8 sec |
+------------+----------+----------+----------+----------+

Signed-off-by: Aharon Landau <aharonl@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 3be36ebbf67a..b4d2322e9ca5 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -600,29 +600,21 @@ struct mlx5_ib_mr *mlx5_mr_cache_alloc(struct mlx5_ib_dev *dev,
 /* Return a MR already available in the cache */
 static struct mlx5_ib_mr *get_cache_mr(struct mlx5_cache_ent *req_ent)
 {
-	struct mlx5_ib_dev *dev = req_ent->dev;
 	struct mlx5_ib_mr *mr = NULL;
 	struct mlx5_cache_ent *ent = req_ent;
 
-	/* Try larger MR pools from the cache to satisfy the allocation */
-	for (; ent != &dev->cache.ent[MR_CACHE_LAST_STD_ENTRY + 1]; ent++) {
-		mlx5_ib_dbg(dev, "order %u, cache index %zu\n", ent->order,
-			    ent - dev->cache.ent);
-
-		spin_lock_irq(&ent->lock);
-		if (!list_empty(&ent->head)) {
-			mr = list_first_entry(&ent->head, struct mlx5_ib_mr,
-					      list);
-			list_del(&mr->list);
-			ent->available_mrs--;
-			queue_adjust_cache_locked(ent);
-			spin_unlock_irq(&ent->lock);
-			mlx5_clear_mr(mr);
-			return mr;
-		}
+	spin_lock_irq(&ent->lock);
+	if (!list_empty(&ent->head)) {
+		mr = list_first_entry(&ent->head, struct mlx5_ib_mr, list);
+		list_del(&mr->list);
+		ent->available_mrs--;
 		queue_adjust_cache_locked(ent);
 		spin_unlock_irq(&ent->lock);
+		mlx5_clear_mr(mr);
+		return mr;
 	}
+	queue_adjust_cache_locked(ent);
+	spin_unlock_irq(&ent->lock);
 	req_ent->miss++;
 	return NULL;
 }
-- 
2.31.1

