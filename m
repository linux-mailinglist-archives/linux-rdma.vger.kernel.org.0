Return-Path: <linux-rdma+bounces-4096-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A452940D3C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 11:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D59DB24B7C
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jul 2024 09:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB96F194C65;
	Tue, 30 Jul 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QdlzC0wj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D78F194AFC
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jul 2024 09:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722331131; cv=none; b=JgbUaWTpxWZcGFjKmUzGDNfRjNhJmPnp1OJspyvw8CjubOfGNsVQ9T2QkKZRw14s4zrLGxxo1fUhQmkusLYv5bgL92ASiFXRMcfzJi1S7Kt6f3YCAXZXfs5vl9oL8cHzeDNwW3EY5VH9e3CQ87Ydmc+RyT8fiAZf/mkJdNKD8ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722331131; c=relaxed/simple;
	bh=RNERRm1tKULRCHwkJX2oQZjbNCIu8zCHVWj+NzA3G6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=i2Tz4/D8Dx/ZAYWpU2UqNPzTBfsok92rxcGdaDvqAXAFgPpk56AOk4THGy889M0pgwUoq0JUiQIt0dI30bFZrPG4vQBAER1HCf96b7UP3sQDXqnPNEUENiHRZJSSAVPtxN0V+mbgHlnS/0+TLaPuov+Nlm8E4fAPSa3dJrA+nPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QdlzC0wj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7F9C4AF09;
	Tue, 30 Jul 2024 09:18:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722331131;
	bh=RNERRm1tKULRCHwkJX2oQZjbNCIu8zCHVWj+NzA3G6M=;
	h=From:To:Cc:Subject:Date:From;
	b=QdlzC0wjnugDXeJnfILYQpryb8R5PpOqoGL1TRkcoDc+st+FbAYge5OBK7RAC2Kyt
	 xL919125k1oZvi5TY4NykcAEAUeavEaDWS9mVd3Z3TDXY1/LeHQhWV93cIjYmdaQTo
	 tzgox7xJzyx6kP7AA97r/1Fhac3IhwHAezL6uv3AtIbWH8vFlV7G0+0P04U3w+j+EQ
	 7IPLSYAGZtpdUzAsJIsNMiKpza2D7TyNT8rw1vd0/K40EfBiglQsQxDwqFaIdMlnvM
	 wyX2ZD65UXn2ptThHrp4VPIOOqGYpOde0d8BLqayFkZmJGxI58Txhu8pTpr9mrBURw
	 k57afGtmrnwdw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Bloch <mbloch@nvidia.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH rdma-next] RDMA/mlx5: Expose vhca id for all ports in multiport mode
Date: Tue, 30 Jul 2024 12:18:45 +0300
Message-ID: <41dea83aa51843aa4c067b4f73f28d64e51bd53c.1722331101.git.leon@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mark Bloch <mbloch@nvidia.com>

In multiport mode, RDMA devices make it impossible for userspace to use
DEVX to discover vhca id values for ports beyond port 1. This patch
addresses the issue by exposing the vhca id of all ports.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/std_types.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/infiniband/hw/mlx5/std_types.c b/drivers/infiniband/hw/mlx5/std_types.c
index ffeb1e1a1538..bdb568411091 100644
--- a/drivers/infiniband/hw/mlx5/std_types.c
+++ b/drivers/infiniband/hw/mlx5/std_types.c
@@ -112,6 +112,23 @@ static int fill_vport_vhca_id(struct mlx5_core_dev *mdev, u16 vport,
 	return err;
 }
 
+static int fill_multiport_info(struct mlx5_ib_dev *dev, u32 port_num,
+			       struct mlx5_ib_uapi_query_port *info)
+{
+	struct mlx5_core_dev *mdev;
+
+	mdev = mlx5_ib_get_native_port_mdev(dev, port_num, NULL);
+	if (!mdev)
+		return -EINVAL;
+
+	info->vport_vhca_id = MLX5_CAP_GEN(mdev, vhca_id);
+	info->flags |= MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID;
+
+	mlx5_ib_put_native_port_mdev(dev, port_num);
+
+	return 0;
+}
+
 static int fill_switchdev_info(struct mlx5_ib_dev *dev, u32 port_num,
 			       struct mlx5_ib_uapi_query_port *info)
 {
@@ -178,6 +195,10 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_QUERY_PORT)(
 		ret = fill_switchdev_info(dev, port_num, &info);
 		if (ret)
 			return ret;
+	} else if (mlx5_core_mp_enabled(dev->mdev)) {
+		ret = fill_multiport_info(dev, port_num, &info);
+		if (ret)
+			return ret;
 	}
 
 	return uverbs_copy_to_struct_or_zero(attrs, MLX5_IB_ATTR_QUERY_PORT, &info,
-- 
2.45.2


