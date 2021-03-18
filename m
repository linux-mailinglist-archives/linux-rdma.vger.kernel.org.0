Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCE2340744
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Mar 2021 14:53:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhCRNxN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 18 Mar 2021 09:53:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:36558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229960AbhCRNxF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 18 Mar 2021 09:53:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B39164F1B;
        Thu, 18 Mar 2021 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616075585;
        bh=dL5U0Cyq+MYVf5btqYgIASaKs7iTX8a/oamT7stwsuY=;
        h=From:To:Cc:Subject:Date:From;
        b=mq2Hu+2R/JPXYaQ1wtdCv36+E0clvG2g3c+6hTvmDNguGlkEdfe/LVFT2gvVPZJPj
         IOkfUg/HUCVX1/E8zNpdM2fc2yYoUayQZqbXBRbqmhuFgKD0n9ylgkuT8OnR7La58b
         DNoUoDjBLga1EUM+VRO9z8M9hPYpEjtDMBJhwhiY9gUhUq+mnNku6RCjVQ/5dPL9i1
         qcx/dG6f5WUaeGGSdmAhn5nnDN24O4Uj0maQwQQ92jzoG+Ksv7H6t1H4ZQQYldBwPz
         oXhzFsm2iAry7uFn5J+SImUR8hZL0lPXLUCQ6eoXfy44NTclf3Z10M9D9IA6cfFWfE
         V4UNWd7g/BVZA==
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Shay Drory <shayd@nvidia.com>, linux-rdma@vger.kernel.org,
        Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Set ODP caps only if device profile support ODP
Date:   Thu, 18 Mar 2021 15:52:59 +0200
Message-Id: <20210318135259.681264-1-leon@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Shay Drory <shayd@nvidia.com>

Currently, ODP caps are set during the init stage of mlx5_ib_dev,
regardless whether the device profile supports ODP or not.
There isn't a point to set ODP caps if the device profile doesn't
supports ODP. Hence, setting the ODP caps in the odp_init stage.

Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c    | 2 --
 drivers/infiniband/hw/mlx5/mlx5_ib.h | 6 ------
 drivers/infiniband/hw/mlx5/odp.c     | 4 +++-
 3 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 6908db28b796..5f1c76b8dcb1 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3665,8 +3665,6 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 		dev->port[i].roce.last_port_state = IB_PORT_DOWN;
 	}
 
-	mlx5_ib_internal_fill_odp_caps(dev);
-
 	err = mlx5_ib_init_multiport_master(dev);
 	if (err)
 		return err;
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 78099d95e8e9..69ecd0229322 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1372,7 +1372,6 @@ struct ib_mr *mlx5_ib_reg_dm_mr(struct ib_pd *pd, struct ib_dm *dm,
 				struct uverbs_attr_bundle *attrs);
 
 #ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
-void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev);
 int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev);
 int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev, struct mlx5_ib_pf_eq *eq);
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *ibdev);
@@ -1388,11 +1387,6 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
 int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr);
 int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr);
 #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
-static inline void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
-{
-	return;
-}
-
 static inline int mlx5_ib_odp_init_one(struct mlx5_ib_dev *ibdev) { return 0; }
 static inline int mlx5r_odp_create_eq(struct mlx5_ib_dev *dev,
 				      struct mlx5_ib_pf_eq *eq)
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index a0b9111b508a..782b2af8f211 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -317,7 +317,7 @@ const struct mmu_interval_notifier_ops mlx5_mn_ops = {
 	.invalidate = mlx5_ib_invalidate_range,
 };
 
-void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
+static void internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 {
 	struct ib_odp_caps *caps = &dev->odp_caps;
 
@@ -1639,6 +1639,8 @@ int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
 {
 	int ret = 0;
 
+	internal_fill_odp_caps(dev);
+
 	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT))
 		return ret;
 
-- 
2.30.2

