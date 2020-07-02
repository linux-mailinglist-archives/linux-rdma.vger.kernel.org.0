Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACFCE211DE6
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2020 10:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726795AbgGBIST (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 2 Jul 2020 04:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726042AbgGBISS (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 2 Jul 2020 04:18:18 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A6F420720;
        Thu,  2 Jul 2020 08:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593677898;
        bh=/R8TiUgXmzfZqVVqJYrQ7g+Xwq2SigIoJNCqxFBNVz8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wqd0ygNtCq8y/KG2OFU2uMpw/ZFziYyl1Ln6oBAH8bG4hzWP+t3U2tktu6Dp90twr
         rSzmwhEaOInIMDsvjK53AIcNPVU40nG3TFcOuQB5Y1hcr0UJL8SKiOOK+uzCabMMX7
         BRoz1DoSFbsV3Mbqk4XeBIj9S5udVfB9x5/QXHJI=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@mellanox.com>
Subject: [PATCH rdma-next 1/6] RDMA/mlx5: Limit the scope of mlx5_ib_enable_driver function
Date:   Thu,  2 Jul 2020 11:18:04 +0300
Message-Id: <20200702081809.423482-2-leon@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702081809.423482-1-leon@kernel.org>
References: <20200702081809.423482-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Leon Romanovsky <leonro@mellanox.com>

The mlx5_ib_enable_driver() is local function and doesn't need to be
shared in mlx5_ib, so change it's signature to have static keyword in
it.

Reviewed-by: Maor Gottlieb <maorg@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 24 ++++++++++++------------
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  1 -
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index a6d5c35a2845..4154fc2dd250 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -6572,6 +6572,18 @@ static void mlx5_ib_stage_flow_db_cleanup(struct mlx5_ib_dev *dev)
 	kfree(dev->flow_db);
 }
 
+static int mlx5_ib_enable_driver(struct ib_device *dev)
+{
+	struct mlx5_ib_dev *mdev = to_mdev(dev);
+	int ret;
+
+	ret = mlx5_ib_test_wc(mdev);
+	mlx5_ib_dbg(mdev, "Write-Combining %s",
+		    mdev->wc_support ? "supported" : "not supported");
+
+	return ret;
+}
+
 static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MLX5,
@@ -7097,18 +7109,6 @@ static void mlx5_ib_stage_devx_cleanup(struct mlx5_ib_dev *dev)
 	}
 }
 
-int mlx5_ib_enable_driver(struct ib_device *dev)
-{
-	struct mlx5_ib_dev *mdev = to_mdev(dev);
-	int ret;
-
-	ret = mlx5_ib_test_wc(mdev);
-	mlx5_ib_dbg(mdev, "Write-Combining %s",
-		    mdev->wc_support ? "supported" : "not supported");
-
-	return ret;
-}
-
 void __mlx5_ib_remove(struct mlx5_ib_dev *dev,
 		      const struct mlx5_ib_profile *profile,
 		      int stage)
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 726386fe4440..6d48f91a492c 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1541,7 +1541,6 @@ static inline bool mlx5_ib_can_use_umr(struct mlx5_ib_dev *dev,
 	return true;
 }
 
-int mlx5_ib_enable_driver(struct ib_device *dev);
 int mlx5_ib_test_wc(struct mlx5_ib_dev *dev);
 
 static inline bool mlx5_ib_lag_should_assign_affinity(struct mlx5_ib_dev *dev)
-- 
2.26.2

