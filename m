Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ADA62F4B29
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Jan 2021 13:20:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbhAMMR6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 13 Jan 2021 07:17:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:55098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727017AbhAMMR5 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 13 Jan 2021 07:17:57 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF651233F9;
        Wed, 13 Jan 2021 12:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610540236;
        bh=SsBuA/BoZWuFhrIUCBKnVLRwgZ0vPC40gELF0Kddmqc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F2whAiOn8RlDqnezXFyigQbgShyJGlBhezfCerWbmWFZGUIhjMZCqpHDhnxrpp3za
         vbuovqwE7xcxCNVLPCSEj6H1m9x6roDL+r6hZYOYr5JWhgzMgnWgaRMEbpVcHILeRi
         jUHBth8QNg/SUwo7IQrhsletqHgFv7mCrpVNA7OkAZ0YrMEm7vtw1RKZ3hk/xqMG3Z
         ZvTCyrx4GHPTxUTOtcbbLKjoaK/Uqb0VBo9haIsGmmQ00L3oPaDVhMaNWB9mOJF3hB
         NZVnosYW/cE2AWID4G9SZwex+sgRrj7+ALV7aL+SNW/X4lYaQwS+5/SM/eW2mgkXgo
         8Ojo4jXQBZlDg==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Parav Pandit <parav@nvidia.com>,
        Aharon Landau <aharonl@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>,
        Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 3/5] IB/mlx5: Add mutex destroy call to cap_mask_mutex mutex
Date:   Wed, 13 Jan 2021 14:17:01 +0200
Message-Id: <20210113121703.559778-4-leon@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113121703.559778-1-leon@kernel.org>
References: <20210113121703.559778-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Parav Pandit <parav@nvidia.com>

Mutex destroy call for device's cap_mask_mutex mutex is missing, let's
add it to annotate destruction.

Fixes: e126ba97dba9 ("mlx5: Add driver for Mellanox Connect-IB adapters")
Signed-off-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 4f21e561f73e..84309bcd67d5 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3951,7 +3951,7 @@ static void mlx5_ib_stage_init_cleanup(struct mlx5_ib_dev *dev)
 	mlx5_ib_cleanup_multiport_master(dev);
 	WARN_ON(!xa_empty(&dev->odp_mkeys));
 	cleanup_srcu_struct(&dev->odp_srcu);
-
+	mutex_destroy(&dev->cap_mask_mutex);
 	WARN_ON(!xa_empty(&dev->sig_mrs));
 	WARN_ON(!bitmap_empty(dev->dm.memic_alloc_pages, MLX5_MAX_MEMIC_PAGES));
 }
@@ -4002,6 +4002,10 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	dev->ib_dev.dev.parent		= mdev->device;
 	dev->ib_dev.lag_flags		= RDMA_LAG_FLAGS_HASH_ALL_SLAVES;

+	err = init_srcu_struct(&dev->odp_srcu);
+	if (err)
+		goto err_mp;
+
 	mutex_init(&dev->cap_mask_mutex);
 	INIT_LIST_HEAD(&dev->qp_list);
 	spin_lock_init(&dev->reset_flow_resource_lock);
@@ -4011,11 +4015,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)

 	spin_lock_init(&dev->dm.lock);
 	dev->dm.dev = mdev;
-
-	err = init_srcu_struct(&dev->odp_srcu);
-	if (err)
-		goto err_mp;
-
 	return 0;

 err_mp:
--
2.29.2

