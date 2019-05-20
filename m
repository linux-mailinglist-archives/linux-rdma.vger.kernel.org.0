Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D212B22BE1
	for <lists+linux-rdma@lfdr.de>; Mon, 20 May 2019 08:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730385AbfETGJ3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 May 2019 02:09:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:57914 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729609AbfETGJ2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 20 May 2019 02:09:28 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3E5720657;
        Mon, 20 May 2019 06:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558332567;
        bh=BJS7rCnIGgEDv/Te417e3duVvqbyjPp7XP3fkzguBkE=;
        h=From:To:Cc:Subject:Date:From;
        b=J9q9jxN748ChidrpFTIP6TnbXdD60bKeJT1aSYGtfI5Lm/jGum30M08lNRYJ9RCVg
         L4MkNKqHblc/Cib+B6EIp0PzUMsPwuAXtC/2aYiCCRa849kljk0cE3YoCs8c5LTllc
         Lv0l6/uoqbsEGr8gRDoFJtxRN/uVF/QF0YC8noqE=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Huy Nguyen <huyn@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Ilya Lesokhin <ilyal@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>
Subject: [PATCH rdma-next] IB/mlx5: Avoid second synchronize_srcu in dereg_mr
Date:   Mon, 20 May 2019 09:09:23 +0300
Message-Id: <20190520060923.7987-1-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Huy Nguyen <huyn@mellanox.com>

In dereg_mr, ODP mkey is synced for page fault handler completion.
Therefore, there is no need for another synchronize_srcu in
destroy_mkey (called by dereg_mr->clean_mr).

The current flow is:
dereg_mr
  if (odp mkey) {
    sync_srcu
    release umem
  }

  clean_mr
    if (not from cache)
      destroy_mkey
        sync_srcu <-- this is the redudant call

Beside the improvement for ODP mkey destroy flow, this patch addresses
the below hang. NVME connection creates 128 non-ODP mkeys and call
dereg_mr during teardown. The teardown stucks because dereg_mr call
synchronize_srcu in destroy_mkey for non-ODP mkey.

nvme_rdma_destroy_queue_ib ib_mr_pool_destroy calling
nvme_rdma_destroy_queue_ib ib_mr_pool_destroy calling
INFO: task kworker/u257:0:5 blocked for more than 120 seconds.
      Tainted: G           OE  ------------ 4.14.0-49.8.1.el7a.ppc64le #1
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
kworker/u257:0  D    0     5      2 0x00000800
Workqueue: nvme-delete-wq nvme_delete_ctrl_work [nvme_core]
Call Trace:
__switch_to+0x330/0x660
__schedule+0x354/0xaf0
schedule+0x48/0xc0
schedule_timeout+0x194/0x580
wait_for_completion+0x168/0x270
flush_work+0x17c/0x2e0
cancel_work_sync+0x238/0x470
nvme_rdma_stop_ctrl+0x2c/0x50 [nvme_rdma]
nvme_stop_ctrl+0x84/0xa0 [nvme_core]
nvme_delete_ctrl_work+0x5c/0xc0 [nvme_core]
process_one_work+0x1bc/0x5f0

Fixes: fbcd49838d90 ("IB/mlx5: Fix NULL deference on mlx5_ib_update_xlt failure")
Signed-off-by: Huy Nguyen <huyn@mellanox.com>
Reviewed-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/mr.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
index 4d033796dcfc..465c7ed18304 100644
--- a/drivers/infiniband/hw/mlx5/mr.c
+++ b/drivers/infiniband/hw/mlx5/mr.c
@@ -47,7 +47,7 @@ enum {

 #define MLX5_UMR_ALIGN 2048

-static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
+static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr, bool sync);
 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
 static int mr_cache_max_order(struct mlx5_ib_dev *dev);
 static int unreg_umr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr);
@@ -67,11 +67,12 @@ static bool use_umr(struct mlx5_ib_dev *dev, int order)
 		umr_can_modify_entity_size(dev);
 }

-static int destroy_mkey(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
+static int destroy_mkey(struct mlx5_ib_dev *dev,
+			struct mlx5_ib_mr *mr, bool sync)
 {
 	int err = mlx5_core_destroy_mkey(dev->mdev, &mr->mmkey);

-	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
+	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && sync)
 		/* Wait until all page fault handlers using the mr complete. */
 		synchronize_srcu(&dev->mr_srcu);

@@ -1459,7 +1460,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		if (mr->allocated_from_cache)
 			err = unreg_umr(dev, mr);
 		else
-			err = destroy_mkey(dev, mr);
+			err = destroy_mkey(dev, mr, true);
 		if (err)
 			goto err;

@@ -1511,7 +1512,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
 		ib_umem_release(mr->umem);
 		mr->umem = NULL;
 	}
-	clean_mr(dev, mr);
+	clean_mr(dev, mr, true);
 	return err;
 }

@@ -1561,7 +1562,7 @@ mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
 	}
 }

-static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
+static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr, bool sync)
 {
 	int allocated_from_cache = mr->allocated_from_cache;

@@ -1581,7 +1582,7 @@ static void clean_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 	mlx5_free_priv_descs(mr);

 	if (!allocated_from_cache)
-		destroy_mkey(dev, mr);
+		destroy_mkey(dev, mr, sync);
 }

 static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
@@ -1623,7 +1624,7 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struct mlx5_ib_mr *mr)
 		umem = NULL;
 	}

-	clean_mr(dev, mr);
+	clean_mr(dev, mr, false);

 	/*
 	 * We should unregister the DMA address from the HCA before
--
2.20.1

