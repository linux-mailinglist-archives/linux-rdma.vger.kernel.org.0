Return-Path: <linux-rdma+bounces-3178-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9789909E67
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 634241F2107F
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5AC3BBE1;
	Sun, 16 Jun 2024 16:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXMy0PpC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5291CA85;
	Sun, 16 Jun 2024 16:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554169; cv=none; b=jg5LMvYIOaRvhcBR2AcGrfrClsr0npUv96HZKTE2PlturBz1LvQIOcc2TnoZzV9XL4Uev6UtMLKHPlxF/MNL8bWQJHgfq7l8DMPxzCH3tgScIDs7hRiJEMw0IhGA8IMY7/qcaZYfoMx/xCJj5j6nmitj1hLwM+2b7WeU0qmv1nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554169; c=relaxed/simple;
	bh=keUOMriSz7khQ0TCa1RtkilqcYfLCqUPX88Gdb+KZzo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aUrsefWSnv0KIagmrLbNt6wF+FvwgvxB8QIxrJOIK29VhH+kKetP1aL+6Wrz2iCCPtGx4xI+qeHMXiltVMwn6lGXhnLs/UM2mlIuh+mIZREfhSSsA3EYHRaWif0AmZCk2sW6XBtN68xA2ZfBIwAQnItBlK6HaTzVEvgCh12DoZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXMy0PpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8E7C2BBFC;
	Sun, 16 Jun 2024 16:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554168;
	bh=keUOMriSz7khQ0TCa1RtkilqcYfLCqUPX88Gdb+KZzo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tXMy0PpC+ToSJlk9V9vFDr4IHv5C8QnLITaAfU4lkX4q7D+fcSmCNUjAwCeDO5hi+
	 R1CXkP5aoG7g9FYRiOFXxOR7yYnV864zcSuFdqaIPJe+yeh0XYOoMSZfGitj+HxpWL
	 9wuDq6ZH00x7PTL7bNODh8bGRbYChHCdfq1vjUGqtyK9XZVJRez2uk8qRg72oR/iF/
	 2dIT8WmSTIxgXgPsX6Rgd0FpnzJCIt7wHt7wahMwssvPzB4qxpKoQnOllgO9qsaR80
	 2iBMkjynBnIPi6GuHhlXCmpe6n+CrhigRAZXgFfi+Lantp8FbXGPw50KvLjmYhvrRb
	 O8L07YR6XR12g==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 10/12] RDMA/mlx5: Add plane index support when querying PTYS registers
Date: Sun, 16 Jun 2024 19:08:42 +0300
Message-ID: <1f703c36306aa46917fcd88eadbb23b3e380d526.1718553901.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1718553901.git.leon@kernel.org>
References: <cover.1718553901.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Zhang <markzhang@nvidia.com>

Support the new "plane_ind" field when querying port PTYS registers.
This is needed when querying the rate of a plane port.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c                    | 12 +++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en/port.c    |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c |  2 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c  |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/port.c       | 10 ++++++----
 include/linux/mlx5/port.h                            |  5 +++--
 6 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 3a653998bd88..4a0380e711ea 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -542,10 +542,10 @@ static int mlx5_query_port_roce(struct ib_device *device, u32 port_num,
 	 */
 	if (dev->is_rep)
 		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
-					   1);
+					   1, 0);
 	else
 		err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN,
-					   mdev_port_num);
+					   mdev_port_num, 0);
 	if (err)
 		goto out;
 	ext = !!MLX5_GET_ETH_PROTO(ptys_reg, out, true, eth_proto_capability);
@@ -1372,11 +1372,11 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u32 port,
 	struct mlx5_ib_dev *dev = to_mdev(ibdev);
 	struct mlx5_core_dev *mdev = dev->mdev;
 	struct mlx5_hca_vport_context *rep;
+	u8 vl_hw_cap, plane_index = 0;
 	u16 max_mtu;
 	u16 oper_mtu;
 	int err;
 	u16 ib_link_width_oper;
-	u8 vl_hw_cap;
 
 	rep = kzalloc(sizeof(*rep), GFP_KERNEL);
 	if (!rep) {
@@ -1386,8 +1386,10 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u32 port,
 
 	/* props being zeroed by the caller, avoid zeroing it here */
 
-	if (ibdev->type == RDMA_DEVICE_TYPE_SMI)
+	if (ibdev->type == RDMA_DEVICE_TYPE_SMI) {
+		plane_index = port;
 		port = smi_to_native_portnum(dev, port);
+	}
 
 	err = mlx5_query_hca_vport_context(mdev, 0, port, 0, rep);
 	if (err)
@@ -1419,7 +1421,7 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u32 port,
 		props->port_cap_flags2 = rep->cap_mask2;
 
 	err = mlx5_query_ib_port_oper(mdev, &ib_link_width_oper,
-				      &props->active_speed, port);
+				      &props->active_speed, port, plane_index);
 	if (err)
 		goto out;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
index b4efc780e297..5f6a0605e4ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port.c
@@ -41,7 +41,7 @@ void mlx5_port_query_eth_autoneg(struct mlx5_core_dev *dev, u8 *an_status,
 	*an_disable_cap = 0;
 	*an_disable_admin = 0;
 
-	if (mlx5_query_port_ptys(dev, out, sizeof(out), MLX5_PTYS_EN, 1))
+	if (mlx5_query_port_ptys(dev, out, sizeof(out), MLX5_PTYS_EN, 1, 0))
 		return;
 
 	*an_status = MLX5_GET(ptys_reg, out, an_status);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 3320f12ba2db..f57e0184c12b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1195,7 +1195,7 @@ static int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
 	bool ext;
 	int err;
 
-	err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN, 1);
+	err = mlx5_query_port_ptys(mdev, out, sizeof(out), MLX5_PTYS_EN, 1, 0);
 	if (err) {
 		netdev_err(priv->netdev, "%s: query port ptys failed: %d\n",
 			   __func__, err);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
index 779d92b762d3..b8aadbea1312 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ethtool.c
@@ -215,7 +215,7 @@ static int mlx5i_get_link_ksettings(struct net_device *netdev,
 	int speed, ret;
 
 	ret = mlx5_query_ib_port_oper(mdev, &ib_link_width_oper, &ib_proto_oper,
-				      1);
+				      1, 0);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index 7fba1c46e2ac..50931584132b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -144,11 +144,13 @@ int mlx5_set_port_caps(struct mlx5_core_dev *dev, u8 port_num, u32 caps)
 EXPORT_SYMBOL_GPL(mlx5_set_port_caps);
 
 int mlx5_query_port_ptys(struct mlx5_core_dev *dev, u32 *ptys,
-			 int ptys_size, int proto_mask, u8 local_port)
+			 int ptys_size, int proto_mask,
+			 u8 local_port, u8 plane_index)
 {
 	u32 in[MLX5_ST_SZ_DW(ptys_reg)] = {0};
 
 	MLX5_SET(ptys_reg, in, local_port, local_port);
+	MLX5_SET(ptys_reg, in, plane_ind, plane_index);
 	MLX5_SET(ptys_reg, in, proto_mask, proto_mask);
 	return mlx5_core_access_reg(dev, in, sizeof(in), ptys,
 				    ptys_size, MLX5_REG_PTYS, 0, 0);
@@ -167,13 +169,13 @@ int mlx5_set_port_beacon(struct mlx5_core_dev *dev, u16 beacon_duration)
 }
 
 int mlx5_query_ib_port_oper(struct mlx5_core_dev *dev, u16 *link_width_oper,
-			    u16 *proto_oper, u8 local_port)
+			    u16 *proto_oper, u8 local_port, u8 plane_index)
 {
 	u32 out[MLX5_ST_SZ_DW(ptys_reg)];
 	int err;
 
 	err = mlx5_query_port_ptys(dev, out, sizeof(out), MLX5_PTYS_IB,
-				   local_port);
+				   local_port, plane_index);
 	if (err)
 		return err;
 
@@ -1114,7 +1116,7 @@ int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
 	if (!eproto)
 		return -EINVAL;
 
-	err = mlx5_query_port_ptys(dev, out, sizeof(out), MLX5_PTYS_EN, port);
+	err = mlx5_query_port_ptys(dev, out, sizeof(out), MLX5_PTYS_EN, port, 0);
 	if (err)
 		return err;
 
diff --git a/include/linux/mlx5/port.h b/include/linux/mlx5/port.h
index 26092c78a985..e68d42b8ce65 100644
--- a/include/linux/mlx5/port.h
+++ b/include/linux/mlx5/port.h
@@ -155,10 +155,11 @@ struct mlx5_port_eth_proto {
 
 int mlx5_set_port_caps(struct mlx5_core_dev *dev, u8 port_num, u32 caps);
 int mlx5_query_port_ptys(struct mlx5_core_dev *dev, u32 *ptys,
-			 int ptys_size, int proto_mask, u8 local_port);
+			 int ptys_size, int proto_mask,
+			 u8 local_port, u8 plane_index);
 
 int mlx5_query_ib_port_oper(struct mlx5_core_dev *dev, u16 *link_width_oper,
-			    u16 *proto_oper, u8 local_port);
+			    u16 *proto_oper, u8 local_port, u8 plane_index);
 void mlx5_toggle_port_link(struct mlx5_core_dev *dev);
 int mlx5_set_port_admin_status(struct mlx5_core_dev *dev,
 			       enum mlx5_port_status status);
-- 
2.45.2


