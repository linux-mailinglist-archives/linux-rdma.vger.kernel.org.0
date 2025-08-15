Return-Path: <linux-rdma+bounces-12784-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65609B286A1
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:49:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48A4A1CC8C71
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B002C032E;
	Fri, 15 Aug 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pb4DU9K4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9A2BEFF6;
	Fri, 15 Aug 2025 19:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287349; cv=none; b=MWs3AjrsIVTyTP29w+xI+1X7ZfPImdFrIXnqQLn6V77KNbjd427CtJYEXd7bvO28Qd1i39NgK5C62NnEUjO10UgX+eiZDqurBVFD4Fzkj+S786IxUwvOSupCN8MQ/py6cakaffT5wTivqcWnU0DdTc2HRko99V+N6ylH40qQBx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287349; c=relaxed/simple;
	bh=4rMjcurE+qs7FO3es9RBGttsGU/+kzJ7eo4wN7gnvIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G7tNz//SHjdSePS0IQG4t8iaX4s4+xJ3xH/x+pMuymTNeODbDFmXc2KqunqblYvpdIMgytZsXmDvgHMKl6ECmgfKqsWNSUtxZk0SlGG85XWXiHoa3qDEC2RQn3DGA1KFDuNRdaTzKXfwaqUpHWTjKXTBuGfeGrUsZ6HrhXJz4sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pb4DU9K4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C26C4CEEB;
	Fri, 15 Aug 2025 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287348;
	bh=4rMjcurE+qs7FO3es9RBGttsGU/+kzJ7eo4wN7gnvIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Pb4DU9K4QhB4OIDgrr5lf+SsR5Ms5GdoYygwsJstSwOSU2KDrLepwuGtp3hggiub6
	 lYx4GA+LHXbevzaCF1nDQyCRN54er2X5Qp504yzOKtvoh+dhJ3yhWYU+jmBznofbdZ
	 FD71seZBitQD9it/h81ntKu8onchTyrkwbmtCLPca23Wy63naUO4T8+wmwAneqltD8
	 nW5WQ0+gP29THD+EDK/ukG6Khc7VCF+VxrGXCtomu68qBbTPUwdWkB7Mpy2Oxx+ZE+
	 uh7Sr5Buw7396B5Vz+dseAFWBpPJJLhhJLfE4EAQGd7oJ24CHmb0oUiI2rq6mMsnLt
	 kO/xyjMAU4Q7g==
From: Saeed Mahameed <saeed@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	Alexei Lazar <alazar@nvidia.com>,
	Feng Liu <feliu@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 4/4] {rdma,net}/mlx5: export mlx5_vport_get_vhca_id
Date: Fri, 15 Aug 2025 12:49:01 -0700
Message-ID: <20250815194901.298689-5-saeed@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815194901.298689-1-saeed@kernel.org>
References: <20250815194901.298689-1-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

vhca id is already cached in the vport structure no need to query on
every mlx5 layer, use the mlx5_vport_get_vhca_id, where possible.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/infiniband/hw/mlx5/std_types.c        | 27 +++----------------
 .../mellanox/mlx5/core/diag/reporter_vnic.c   |  2 ++
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  2 --
 .../mellanox/mlx5/core/steering/hws/cmd.c     | 16 +++++++----
 .../mellanox/mlx5/core/steering/sws/dr_cmd.c  | 16 ++++++++---
 .../net/ethernet/mellanox/mlx5/core/vport.c   |  5 +++-
 include/linux/mlx5/vport.h                    |  2 ++
 7 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/std_types.c b/drivers/infiniband/hw/mlx5/std_types.c
index bdb568411091..2fcf553044e1 100644
--- a/drivers/infiniband/hw/mlx5/std_types.c
+++ b/drivers/infiniband/hw/mlx5/std_types.c
@@ -83,33 +83,14 @@ static int fill_vport_icm_addr(struct mlx5_core_dev *mdev, u16 vport,
 static int fill_vport_vhca_id(struct mlx5_core_dev *mdev, u16 vport,
 			      struct mlx5_ib_uapi_query_port *info)
 {
-	size_t out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
-	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
-	void *out;
-	int err;
-
-	out = kzalloc(out_sz, GFP_KERNEL);
-	if (!out)
-		return -ENOMEM;
+	int err = mlx5_vport_get_vhca_id(mdev, vport, &info->vport_vhca_id);
 
-	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
-	MLX5_SET(query_hca_cap_in, in, other_function, true);
-	MLX5_SET(query_hca_cap_in, in, function_id, vport);
-	MLX5_SET(query_hca_cap_in, in, op_mod,
-		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE |
-		 HCA_CAP_OPMOD_GET_CUR);
-
-	err = mlx5_cmd_exec(mdev, in, sizeof(in), out, out_sz);
 	if (err)
-		goto out;
-
-	info->vport_vhca_id = MLX5_GET(query_hca_cap_out, out,
-				       capability.cmd_hca_cap.vhca_id);
+		return err;
 
 	info->flags |= MLX5_IB_UAPI_QUERY_PORT_VPORT_VHCA_ID;
-out:
-	kfree(out);
-	return err;
+
+	return 0;
 }
 
 static int fill_multiport_info(struct mlx5_ib_dev *dev, u32 port_num,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
index 86253a89c24c..32bb769f1829 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/reporter_vnic.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
 /* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
 
+#include <linux/mlx5/vport.h>
+
 #include "reporter_vnic.h"
 #include "en_stats.h"
 #include "devlink.h"
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index b6d53db27cd5..81857c6f6bf7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -447,8 +447,6 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 #define mlx5_vport_get_other_func_general_cap(dev, vport, out)		\
 	mlx5_vport_get_other_func_cap(dev, vport, out, MLX5_CAP_GENERAL)
 
-int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id);
-
 static inline u32 mlx5_sriov_get_vf_total_msix(struct pci_dev *pdev)
 {
 	struct mlx5_core_dev *dev = pci_get_drvdata(pdev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
index 9c83753e4592..d447574d86fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/cmd.c
@@ -1199,22 +1199,28 @@ int mlx5hws_cmd_query_caps(struct mlx5_core_dev *mdev,
 int mlx5hws_cmd_query_gvmi(struct mlx5_core_dev *mdev, bool other_function,
 			   u16 vport_number, u16 *gvmi)
 {
-	bool ec_vf_func = other_function ? mlx5_core_is_ec_vf_vport(mdev, vport_number) : false;
 	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
 	int out_size;
 	void *out;
 	int err;
 
+	if (other_function) {
+		err = mlx5_vport_get_vhca_id(mdev, vport_number, gvmi);
+		if  (!err)
+			return 0;
+
+		mlx5_core_err(mdev, "Failed to get vport vhca id for vport %d\n",
+			      vport_number);
+		return err;
+	}
+
+	/* get vhca_id for `this` function */
 	out_size = MLX5_ST_SZ_BYTES(query_hca_cap_out);
 	out = kzalloc(out_size, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
 	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
-	MLX5_SET(query_hca_cap_in, in, other_function, other_function);
-	MLX5_SET(query_hca_cap_in, in, function_id,
-		 mlx5_vport_to_func_id(mdev, vport_number, ec_vf_func));
-	MLX5_SET(query_hca_cap_in, in, ec_vf_function, ec_vf_func);
 	MLX5_SET(query_hca_cap_in, in, op_mod,
 		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1 | HCA_CAP_OPMOD_GET_CUR);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
index baefb9a3fa05..bf99b933fd14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_cmd.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2019 Mellanox Technologies. */
 
 #include "dr_types.h"
+#include "eswitch.h"
 
 int mlx5dr_cmd_query_esw_vport_context(struct mlx5_core_dev *mdev,
 				       bool other_vport,
@@ -34,21 +35,28 @@ int mlx5dr_cmd_query_esw_vport_context(struct mlx5_core_dev *mdev,
 int mlx5dr_cmd_query_gvmi(struct mlx5_core_dev *mdev, bool other_vport,
 			  u16 vport_number, u16 *gvmi)
 {
-	bool ec_vf_func = other_vport ? mlx5_core_is_ec_vf_vport(mdev, vport_number) : false;
 	u32 in[MLX5_ST_SZ_DW(query_hca_cap_in)] = {};
 	int out_size;
 	void *out;
 	int err;
 
+	if (other_vport) {
+		err = mlx5_vport_get_vhca_id(mdev, vport_number, gvmi);
+		if  (!err)
+			return 0;
+
+		mlx5_core_err(mdev, "Failed to get vport vhca id for vport %d\n",
+			      vport_number);
+		return err;
+	}
+
+	/* get vhca_id for `this` function */
 	out_size = MLX5_ST_SZ_BYTES(query_hca_cap_out);
 	out = kzalloc(out_size, GFP_KERNEL);
 	if (!out)
 		return -ENOMEM;
 
 	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
-	MLX5_SET(query_hca_cap_in, in, other_function, other_vport);
-	MLX5_SET(query_hca_cap_in, in, function_id, mlx5_vport_to_func_id(mdev, vport_number, ec_vf_func));
-	MLX5_SET(query_hca_cap_in, in, ec_vf_function, ec_vf_func);
 	MLX5_SET(query_hca_cap_in, in, op_mod,
 		 MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE << 1 |
 		 HCA_CAP_OPMOD_GET_CUR);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index 231bedc6a252..2ed2e530b07d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -1239,7 +1239,9 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
 	void *hca_caps;
 	int err;
 
-	*vhca_id = 0;
+	/* try get vhca_id via eswitch */
+	if (mlx5_esw_vport_vhca_id(dev->priv.eswitch, vport, vhca_id))
+		return 0;
 
 	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
 	if (!query_ctx)
@@ -1256,6 +1258,7 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
 	kfree(query_ctx);
 	return err;
 }
+EXPORT_SYMBOL_GPL(mlx5_vport_get_vhca_id);
 
 int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap,
 				  u16 vport, u16 opmod)
diff --git a/include/linux/mlx5/vport.h b/include/linux/mlx5/vport.h
index c36cc6d82926..c87b9507cfa1 100644
--- a/include/linux/mlx5/vport.h
+++ b/include/linux/mlx5/vport.h
@@ -135,4 +135,6 @@ int mlx5_nic_vport_unaffiliate_multiport(struct mlx5_core_dev *port_mdev);
 u64 mlx5_query_nic_system_image_guid(struct mlx5_core_dev *mdev);
 int mlx5_vport_get_other_func_cap(struct mlx5_core_dev *dev, u16 vport, void *out,
 				  u16 opmod);
+int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id);
+
 #endif /* __MLX5_VPORT_H__ */
-- 
2.50.1


