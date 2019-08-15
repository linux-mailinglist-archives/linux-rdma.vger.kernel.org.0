Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 896858E701
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 10:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730833AbfHOIjB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 04:39:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:56356 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725875AbfHOIjB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 15 Aug 2019 04:39:01 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DB43B2235C;
        Thu, 15 Aug 2019 08:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565858340;
        bh=I6tranG/BpSwYs5U6o73uCrceuOBHO4zzqZxwh3q6Sk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=d70cWJFtrJiL13nJ/MVuLEggPVqpSswKDLqdqrgdgDIOra6736jYog8wFLwrxmqRX
         IUGp+LvG7GqPtLfjPLLOgrlG291DyjrEwUIZ/BcYz4l6leRIRZtVsFGsoIbS9iH0XR
         r6bsqEyBMRgfBpusCGl64jMEaSbYMwYt+BROP8Fk=
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Ido Kalir <idok@mellanox.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Majd Dibbiny <majd@mellanox.com>,
        Mark Zhang <markz@mellanox.com>,
        Moni Shoua <monis@mellanox.com>
Subject: [PATCH rdma-rc 6/8] IB/mlx5: Report and handle ODP support properly
Date:   Thu, 15 Aug 2019 11:38:32 +0300
Message-Id: <20190815083834.9245-7-leon@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190815083834.9245-1-leon@kernel.org>
References: <20190815083834.9245-1-leon@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

From: Moni Shoua <monis@mellanox.com>

ODP depends on the several device capabilities, among them is the ability
to send UMR WQEs with that modify atomic and entity size of the MR.
Therefore, only if all conditions to send such a UMR WQE are met then
driver can report that ODP is supported. Use this check of conditions
in all places where driver needs to know about ODP support.

Also, implicit ODP support depends on ability of driver to send UMR WQEs
for an indirect mkey. Therefore, verify that all conditions to do so are
met when reporting support.

Fixes: c8d75a980fab ("IB/mlx5: Respect new UMR capabilities")
Signed-off-by: Moni Shoua <monis@mellanox.com>
Reviewed-by: Guy Levi <guyle@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
---
 drivers/infiniband/hw/mlx5/main.c |  6 +++---
 drivers/infiniband/hw/mlx5/odp.c  | 17 +++++++++--------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index e12a4404096b..0569bcab02d4 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -1023,7 +1023,7 @@ static int mlx5_ib_query_device(struct ib_device *ibdev,
 	props->timestamp_mask = 0x7FFFFFFFFFFFFFFFULL;
 
 	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
-		if (MLX5_CAP_GEN(mdev, pg))
+		if (dev->odp_caps.general_caps & IB_ODP_SUPPORT)
 			props->device_cap_flags |= IB_DEVICE_ON_DEMAND_PAGING;
 		props->odp_caps = dev->odp_caps;
 	}
@@ -6139,6 +6139,8 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 		dev->port[i].roce.last_port_state = IB_PORT_DOWN;
 	}
 
+	mlx5_ib_internal_fill_odp_caps(dev);
+
 	err = mlx5_ib_init_multiport_master(dev);
 	if (err)
 		return err;
@@ -6563,8 +6565,6 @@ static void mlx5_ib_stage_dev_res_cleanup(struct mlx5_ib_dev *dev)
 
 static int mlx5_ib_stage_odp_init(struct mlx5_ib_dev *dev)
 {
-	mlx5_ib_internal_fill_odp_caps(dev);
-
 	return mlx5_ib_odp_init_one(dev);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
index 1d257d1b3b0d..0a59912a4cef 100644
--- a/drivers/infiniband/hw/mlx5/odp.c
+++ b/drivers/infiniband/hw/mlx5/odp.c
@@ -301,7 +301,8 @@ void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 
 	memset(caps, 0, sizeof(*caps));
 
-	if (!MLX5_CAP_GEN(dev->mdev, pg))
+	if (!MLX5_CAP_GEN(dev->mdev, pg) ||
+	    !mlx5_ib_can_use_umr(dev, true))
 		return;
 
 	caps->general_caps = IB_ODP_SUPPORT;
@@ -355,7 +356,8 @@ void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *dev)
 
 	if (MLX5_CAP_GEN(dev->mdev, fixed_buffer_size) &&
 	    MLX5_CAP_GEN(dev->mdev, null_mkey) &&
-	    MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset))
+	    MLX5_CAP_GEN(dev->mdev, umr_extended_translation_offset) &&
+	    !MLX5_CAP_GEN(dev->mdev, umr_indirect_mkey_disabled))
 		caps->general_caps |= IB_ODP_SUPPORT_IMPLICIT;
 
 	return;
@@ -1622,8 +1624,10 @@ int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
 {
 	int ret = 0;
 
-	if (dev->odp_caps.general_caps & IB_ODP_SUPPORT)
-		ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_odp_ops);
+	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT))
+		return ret;
+
+	ib_set_device_ops(&dev->ib_dev, &mlx5_ib_dev_odp_ops);
 
 	if (dev->odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT) {
 		ret = mlx5_cmd_null_mkey(dev->mdev, &dev->null_mkey);
@@ -1633,9 +1637,6 @@ int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
 		}
 	}
 
-	if (!MLX5_CAP_GEN(dev->mdev, pg))
-		return ret;
-
 	ret = mlx5_ib_create_pf_eq(dev, &dev->odp_pf_eq);
 
 	return ret;
@@ -1643,7 +1644,7 @@ int mlx5_ib_odp_init_one(struct mlx5_ib_dev *dev)
 
 void mlx5_ib_odp_cleanup_one(struct mlx5_ib_dev *dev)
 {
-	if (!MLX5_CAP_GEN(dev->mdev, pg))
+	if (!(dev->odp_caps.general_caps & IB_ODP_SUPPORT))
 		return;
 
 	mlx5_ib_destroy_pf_eq(dev, &dev->odp_pf_eq);
-- 
2.20.1

