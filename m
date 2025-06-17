Return-Path: <linux-rdma+bounces-11385-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B3C6ADC47B
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A801116A404
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3828FFC2;
	Tue, 17 Jun 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E61dqZmC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF5128FAB7
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750148368; cv=none; b=CwojpKCz+V0WJ4j2BNatj2IMr3oMQPM+GhFgAs6EimOpHjNYzbVyknIhhUXIA5cdp1q5kWoE1eS5r+TygdlBhpIQZS++JnelahO8aIvfmGUZsfRlPWBPe/duuFF7KdjvKGKV6JrJyuaXnteKm6OCxYQQJnisZ/F3YR2zknUt5HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750148368; c=relaxed/simple;
	bh=u3YMhaHd3lZH0KP85aa/apG1EL4auinoADYXmbQadLs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QTEbtQ0HTnMeaGTTNcGKQJ4FFc2q8OZXfxKgFCmYe0ZOQZw+9eucxvoXhVhiftglIj3bESxqkEB5fmvwgm9Di8NI8Kijh6w+dICbhtVIx3VBHxlfaGo6gtLVsQKktkiNHbNi7TtvVPkVpaK1toUfgPy5bxy7wd0bqbMZfTyYRC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E61dqZmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE59C4CEE3;
	Tue, 17 Jun 2025 08:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750148368;
	bh=u3YMhaHd3lZH0KP85aa/apG1EL4auinoADYXmbQadLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=E61dqZmC48MdIbV9hFsLmnYnWM+KgzAcWW1Bcm22uCl9SamFMFpk3AstOW2p/WYkb
	 UGySUnhiPsBh6CSRh2+ZCwGKPx/kkxWGSvdsy/7iBaxnLFm6k+Bhkaetd7xnKDUkkN
	 vzdCVXwP74+bjYCZB9XRWPeMhF2ngzgiP3M5VIbFtTynDWTLFnOsVVmUlP2VUqyN35
	 rMNvnhpAkB0FSDWX7w8ZQBcWVrXoAoPS8D/C85PlOFkPXGn270arIwZCc8XsQ3ulhK
	 hfsLZ2cZzAfcD3wGlUk4yk+MpJxQCg3vq8sShlcgPNsZtmPHJS3DF7l2xZwbHKPqzI
	 3599iDcK6l1IA==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Patrisious Haddad <phaddad@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH rdma-next 2/2] RDMA/mlx5: Add multiple priorities support to RDMA TRANSPORT userspace tables
Date: Tue, 17 Jun 2025 11:19:16 +0300
Message-ID: <bb38e50ae4504e979c6568d41939402a4cf15635.1750148083.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750148083.git.leon@kernel.org>
References: <cover.1750148083.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Patrisious Haddad <phaddad@nvidia.com>

Support the creation of RDMA TRANSPORT tables over multiple priorities
via matcher creation.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/fs.c      | 40 +++++++++++++++++-----------
 drivers/infiniband/hw/mlx5/fs.h      |  8 ++++--
 drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 +--
 3 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/fs.c b/drivers/infiniband/hw/mlx5/fs.c
index 680627f1de33..ebcc05f766e1 100644
--- a/drivers/infiniband/hw/mlx5/fs.c
+++ b/drivers/infiniband/hw/mlx5/fs.c
@@ -1966,7 +1966,8 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX:
 	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX:
-		if (ib_port == 0 || user_priority > MLX5_RDMA_TRANSPORT_BYPASS_PRIO)
+		if (ib_port == 0 ||
+		    user_priority >= MLX5_RDMA_TRANSPORT_BYPASS_PRIO)
 			return ERR_PTR(-EINVAL);
 		ret = mlx5_ib_fill_transport_ns_info(dev, ns_type, &flags,
 						     &vport_idx, &vport,
@@ -2016,10 +2017,10 @@ _get_flow_table(struct mlx5_ib_dev *dev, u16 user_priority,
 		prio = &dev->flow_db->rdma_tx[priority];
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_RX:
-		prio = &dev->flow_db->rdma_transport_rx[ib_port - 1];
+		prio = &dev->flow_db->rdma_transport_rx[priority][ib_port - 1];
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TRANSPORT_TX:
-		prio = &dev->flow_db->rdma_transport_tx[ib_port - 1];
+		prio = &dev->flow_db->rdma_transport_tx[priority][ib_port - 1];
 		break;
 	default: return ERR_PTR(-EINVAL);
 	}
@@ -3466,31 +3467,40 @@ static const struct ib_device_ops flow_ops = {
 
 int mlx5_ib_fs_init(struct mlx5_ib_dev *dev)
 {
+	int i, j;
+
 	dev->flow_db = kzalloc(sizeof(*dev->flow_db), GFP_KERNEL);
 
 	if (!dev->flow_db)
 		return -ENOMEM;
 
-	dev->flow_db->rdma_transport_rx = kcalloc(dev->num_ports,
-					sizeof(struct mlx5_ib_flow_prio),
-					GFP_KERNEL);
-	if (!dev->flow_db->rdma_transport_rx)
-		goto free_flow_db;
+	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++) {
+		dev->flow_db->rdma_transport_rx[i] =
+			kcalloc(dev->num_ports,
+				sizeof(struct mlx5_ib_flow_prio), GFP_KERNEL);
+		if (!dev->flow_db->rdma_transport_rx[i])
+			goto free_rdma_transport_rx;
+	}
 
-	dev->flow_db->rdma_transport_tx = kcalloc(dev->num_ports,
-					sizeof(struct mlx5_ib_flow_prio),
-					GFP_KERNEL);
-	if (!dev->flow_db->rdma_transport_tx)
-		goto free_rdma_transport_rx;
+	for (j = 0; j < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; j++) {
+		dev->flow_db->rdma_transport_tx[j] =
+			kcalloc(dev->num_ports,
+				sizeof(struct mlx5_ib_flow_prio), GFP_KERNEL);
+		if (!dev->flow_db->rdma_transport_tx[j])
+			goto free_rdma_transport_tx;
+	}
 
 	mutex_init(&dev->flow_db->lock);
 
 	ib_set_device_ops(&dev->ib_dev, &flow_ops);
 	return 0;
 
+free_rdma_transport_tx:
+	while (j--)
+		kfree(dev->flow_db->rdma_transport_tx[j]);
 free_rdma_transport_rx:
-	kfree(dev->flow_db->rdma_transport_rx);
-free_flow_db:
+	while (i--)
+		kfree(dev->flow_db->rdma_transport_rx[i]);
 	kfree(dev->flow_db);
 	return -ENOMEM;
 }
diff --git a/drivers/infiniband/hw/mlx5/fs.h b/drivers/infiniband/hw/mlx5/fs.h
index 2ebe86e5be10..7abba0e2837c 100644
--- a/drivers/infiniband/hw/mlx5/fs.h
+++ b/drivers/infiniband/hw/mlx5/fs.h
@@ -13,6 +13,8 @@ void mlx5_ib_fs_cleanup_anchor(struct mlx5_ib_dev *dev);
 
 static inline void mlx5_ib_fs_cleanup(struct mlx5_ib_dev *dev)
 {
+	int i;
+
 	/* When a steering anchor is created, a special flow table is also
 	 * created for the user to reference. Since the user can reference it,
 	 * the kernel cannot trust that when the user destroys the steering
@@ -25,8 +27,10 @@ static inline void mlx5_ib_fs_cleanup(struct mlx5_ib_dev *dev)
 	 * is a safe assumption that all references are gone.
 	 */
 	mlx5_ib_fs_cleanup_anchor(dev);
-	kfree(dev->flow_db->rdma_transport_tx);
-	kfree(dev->flow_db->rdma_transport_rx);
+	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++)
+		kfree(dev->flow_db->rdma_transport_tx[i]);
+	for (i = 0; i < MLX5_RDMA_TRANSPORT_BYPASS_PRIO; i++)
+		kfree(dev->flow_db->rdma_transport_rx[i]);
 	kfree(dev->flow_db);
 }
 #endif /* _MLX5_IB_FS_H */
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index 9c6ec5a968b1..ef627e2f8e6d 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -320,8 +320,8 @@ struct mlx5_ib_flow_db {
 	struct mlx5_ib_flow_prio	rdma_tx[MLX5_IB_NUM_FLOW_FT];
 	struct mlx5_ib_flow_prio	opfcs[MLX5_IB_OPCOUNTER_MAX];
 	struct mlx5_flow_table		*lag_demux_ft;
-	struct mlx5_ib_flow_prio        *rdma_transport_rx;
-	struct mlx5_ib_flow_prio        *rdma_transport_tx;
+	struct mlx5_ib_flow_prio        *rdma_transport_rx[MLX5_RDMA_TRANSPORT_BYPASS_PRIO];
+	struct mlx5_ib_flow_prio        *rdma_transport_tx[MLX5_RDMA_TRANSPORT_BYPASS_PRIO];
 	/* Protect flow steering bypass flow tables
 	 * when add/del flow rules.
 	 * only single add/removal of flow steering rule could be done
-- 
2.49.0


