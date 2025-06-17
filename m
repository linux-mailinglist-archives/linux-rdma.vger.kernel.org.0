Return-Path: <linux-rdma+bounces-11398-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06FB1ADC537
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 10:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA9F170F7D
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Jun 2025 08:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5A728FAB7;
	Tue, 17 Jun 2025 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhyQLG38"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F0628DB57
	for <linux-rdma@vger.kernel.org>; Tue, 17 Jun 2025 08:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750149870; cv=none; b=nvmxQjZTsBRwKQn38RzkPPVJhGklb5/4Dnu883+Fw7YjWI8CtcNbMVUXS4uX4ez75rJvNmu29tUhFiuepr9D4OqnKd7R6lYlGfTqsDp3Auugjdw/N0VJ7dhOYM1DJTt3XCkb677IvZCbJc+7YNGLCg8m9EjDf10i0gN5g4vMARU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750149870; c=relaxed/simple;
	bh=ROlC50yg2Q9PgOp9dkutdlRAGUF7RN/ajySi5/oFquo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mt+5Mu8wjXVKZ96fl3b8Tf0ukvk7cU87NpE0sM0mX1EvFZ4h1FmEfKhaluCJTlTyUiEt0KXv6+Q2bI4jZ46SdvCyno9i3O0+CQWiJLWE8wPXtJC0/idctLQ4PESNkrmly17hrLf6x7Zh3e1QmdlMSHDXkfMf+AidJDqhLvgTz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhyQLG38; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31124C4CEE3;
	Tue, 17 Jun 2025 08:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750149869;
	bh=ROlC50yg2Q9PgOp9dkutdlRAGUF7RN/ajySi5/oFquo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dhyQLG38T/DbBJnsR73+qF/ZsT1myReHw7azRnTFJwi0w80mbyn6ounkMt/vpiQaW
	 spoFLTkIj4w6hgpisEqDR8J0Jdx55cVaflhGjLHENN2U6K4lzJg67rJ5t86iI1QLcp
	 YUUuSvVhP/IEMenKZPxY3ZivXm+DBthUQwDCxcy5GOF0JOKuv1yD+LnIqNQrXqhlVl
	 ehIu9wUvgoeR7eL174Qq89OC2G4Ha9HS1gnNH6V0hLN25TVg3PxdEppFvYqnlxWiqt
	 0pL9WgHPq+Rh/z+XfhHjRyF6mOR3vdsKV7i/PKwcypq/58plxc0GEpJQaKUSXAXEQl
	 d3bBffpDjv46Q==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org,
	Parav Pandit <parav@nvidia.com>
Subject: [PATCH rdma-next 2/3] RDMA/mlx5: Allocate IB device with net namespace supplied from core dev
Date: Tue, 17 Jun 2025 11:44:02 +0300
Message-ID: <bc5112ad4def0b2732edf778f43cd31570ba9ed4.1750149405.git.leon@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750149405.git.leon@kernel.org>
References: <cover.1750149405.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

Use the new ib_alloc_device_with_net() API to allocate the IB device
so that it is properly bound to the network namespace obtained via
mlx5_core_net(). This change ensures correct namespace association
(e.g., for containerized setups).

Additionally, expose mlx5_core_net so that RDMA driver can use it.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/ib_rep.c                | 3 ++-
 drivers/infiniband/hw/mlx5/main.c                  | 6 ++++--
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h | 5 -----
 include/linux/mlx5/driver.h                        | 5 +++++
 4 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/ib_rep.c b/drivers/infiniband/hw/mlx5/ib_rep.c
index 49af1cfbe6d1..cc8859d3c2f5 100644
--- a/drivers/infiniband/hw/mlx5/ib_rep.c
+++ b/drivers/infiniband/hw/mlx5/ib_rep.c
@@ -88,7 +88,8 @@ mlx5_ib_vport_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 	else
 		return mlx5_ib_set_vport_rep(lag_master, rep, vport_index);
 
-	ibdev = ib_alloc_device(mlx5_ib_dev, ib_dev);
+	ibdev = ib_alloc_device_with_net(mlx5_ib_dev, ib_dev,
+					 mlx5_core_net(lag_master));
 	if (!ibdev)
 		return -ENOMEM;
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index b0aa6c8f218c..d0ddb24aeb64 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -4826,7 +4826,8 @@ static struct ib_device *mlx5_ib_add_sub_dev(struct ib_device *parent,
 	    !MLX5_CAP_GEN_2(mparent->mdev, multiplane_qp_ud))
 		return ERR_PTR(-EOPNOTSUPP);
 
-	mplane = ib_alloc_device(mlx5_ib_dev, ib_dev);
+	mplane = ib_alloc_device_with_net(mlx5_ib_dev, ib_dev,
+					  mlx5_core_net(mparent->mdev));
 	if (!mplane)
 		return ERR_PTR(-ENOMEM);
 
@@ -4940,7 +4941,8 @@ static int mlx5r_probe(struct auxiliary_device *adev,
 
 	num_ports = max(MLX5_CAP_GEN(mdev, num_ports),
 			MLX5_CAP_GEN(mdev, num_vhca_ports));
-	dev = ib_alloc_device(mlx5_ib_dev, ib_dev);
+	dev = ib_alloc_device_with_net(mlx5_ib_dev, ib_dev,
+				       mlx5_core_net(mdev));
 	if (!dev)
 		return -ENOMEM;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index 37d5f445598c..b111ccd03b02 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -45,11 +45,6 @@ int mlx5_crdump_enable(struct mlx5_core_dev *dev);
 void mlx5_crdump_disable(struct mlx5_core_dev *dev);
 int mlx5_crdump_collect(struct mlx5_core_dev *dev, u32 *cr_data);
 
-static inline struct net *mlx5_core_net(struct mlx5_core_dev *dev)
-{
-	return devlink_net(priv_to_devlink(dev));
-}
-
 static inline struct net_device *mlx5_uplink_netdev_get(struct mlx5_core_dev *mdev)
 {
 	return mdev->mlx5e_res.uplink_netdev;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index e6ba8f4f4bd1..3475d33c75f4 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1349,4 +1349,9 @@ enum {
 };
 
 bool mlx5_wc_support_get(struct mlx5_core_dev *mdev);
+
+static inline struct net *mlx5_core_net(struct mlx5_core_dev *dev)
+{
+	return devlink_net(priv_to_devlink(dev));
+}
 #endif /* MLX5_DRIVER_H */
-- 
2.49.0


