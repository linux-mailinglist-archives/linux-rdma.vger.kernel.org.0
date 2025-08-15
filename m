Return-Path: <linux-rdma+bounces-12783-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1DB286A0
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 21:49:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FDFE1CC8C1E
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Aug 2025 19:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36292BE7C6;
	Fri, 15 Aug 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TsG70NP3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2DC13FEE;
	Fri, 15 Aug 2025 19:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287348; cv=none; b=C7as0dmfNnay0ztUx5Az7EDS4pPLdAFx2rI7swBiO2dq7omcF3VHvyTAaWLTFn3zuDWlOyOJRlb+rqci3jFoMMtuPEuNOL4JkQNbZQqlr2uSN9b3wFE4r/A4/HkjfPsVGTAjjXaEjQoRNLRrMLSzNky3ADh4hSWYjvw2ER+JqG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287348; c=relaxed/simple;
	bh=FqVef2V1YYX39AGqbl5+DJQlz8g3olchUXjsRwDZMrY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YjaOswoX5MCI5d9LowLNiQ28miWd8ayn3jIu6kE/6GrzB85FzoVyLsFZEgp76y+5H/hS5yZ1M8bge3QHgv3QAjFCCelgyK6Uv+vn1mrZWiavFhk94bbmEOlhp2dg6ISlnFq/0mXl4+KCOHKjeqZcsIpVHPE/OAgmZzI7n3ez95A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TsG70NP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16332C4CEEB;
	Fri, 15 Aug 2025 19:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287348;
	bh=FqVef2V1YYX39AGqbl5+DJQlz8g3olchUXjsRwDZMrY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TsG70NP3GUMpVW4gikphoF8mVEJ9wx77nPFeSQqg2+vHkSp323xmWIasbIuXOlhjJ
	 XFqH9Z/PRpQl9zyOnPZyMcn/MOEDi9QSP/GbP0+GBVOeYB2LId28hhetCKVxI1Gv8X
	 LWF0G5B60OLVxkJoA8+tt6R1Kv5cLk0cC0nhaMhi5sJIpunkhVLVkM45Qm1AuffYXi
	 GPpJk/TkoOH2tJztw3Pd9nfHxkoGG1YJWxQwSHgOR6hVddhiN2kNBW0wEJ2t6NLBpJ
	 oTwvmSNg2CUqBSJRlm2XLVrByh4pJvKVXsv3lZBFW6nU0wQTw1cL7pJUJlri0a0zCr
	 EOMUazSsUYE/Q==
From: Saeed Mahameed <saeed@kernel.org>
To: Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Parav Pandit <parav@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Feng Liu <feliu@nvidia.com>,
	William Tu <witu@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH mlx5-next 3/4] net/mlx5: E-Switch, Set/Query hca cap via vhca id
Date: Fri, 15 Aug 2025 12:49:00 -0700
Message-ID: <20250815194901.298689-4-saeed@kernel.org>
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

Dynamically created vports require vhca id as input to set/query other
vport hca cap, when FW is capable and the vhca id of a vport is valid
use it instead of the local function id.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Feng Liu <feliu@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 12 +++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  8 +++
 .../net/ethernet/mellanox/mlx5/core/vport.c   | 53 +++++++++++++++++--
 3 files changed, 68 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index eeffe9c4aa56..21c42138d93c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -840,6 +840,18 @@ static int mlx5_esw_vport_caps_get(struct mlx5_eswitch *esw, struct mlx5_vport *
 	return err;
 }
 
+bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
+{
+	struct mlx5_vport *vport;
+
+	vport = mlx5_eswitch_get_vport(esw, vportn);
+	if (IS_ERR(vport) || MLX5_VPORT_INVAL_VHCA_ID(vport))
+		return false;
+
+	*vhca_id = vport->vhca_id;
+	return true;
+}
+
 static int esw_vport_setup(struct mlx5_eswitch *esw, struct mlx5_vport *vport)
 {
 	bool vst_mode_steering = esw_vst_mode_is_steering(esw);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 7f6bfaae5f5f..f47389629c62 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -833,6 +833,7 @@ int mlx5_esw_vport_vhca_id_map(struct mlx5_eswitch *esw,
 void mlx5_esw_vport_vhca_id_unmap(struct mlx5_eswitch *esw,
 				  struct mlx5_vport *vport);
 int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
+bool mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id);
 
 /**
  * struct mlx5_esw_event_info - Indicates eswitch mode changed/changing.
@@ -973,6 +974,13 @@ static inline bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev)
 }
 
 static inline void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev) {}
+
+static inline bool
+mlx5_esw_vport_vhca_id(struct mlx5_eswitch *esw, u16 vportn, u16 *vhca_id)
+{
+	return -EOPNOTSUPP;
+}
+
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/vport.c b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
index da5c24fc7b30..231bedc6a252 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -36,6 +36,7 @@
 #include <linux/mlx5/vport.h>
 #include <linux/mlx5/eswitch.h>
 #include "mlx5_core.h"
+#include "eswitch.h"
 #include "sf/sf.h"
 
 /* Mutex to hold while enabling or disabling RoCE */
@@ -1189,18 +1190,44 @@ u64 mlx5_query_nic_system_image_guid(struct mlx5_core_dev *mdev)
 }
 EXPORT_SYMBOL_GPL(mlx5_query_nic_system_image_guid);
 
+static bool mlx5_vport_use_vhca_id_as_func_id(struct mlx5_core_dev *dev,
+					      u16 vport_num, u16 *vhca_id)
+{
+	if (!MLX5_CAP_GEN_2(dev, function_id_type_vhca_id))
+		return false;
+
+	return mlx5_esw_vport_vhca_id(dev->priv.eswitch, vport_num, vhca_id);
+}
+
 int mlx5_vport_get_other_func_cap(struct mlx5_core_dev *dev, u16 vport, void *out,
 				  u16 opmod)
 {
-	bool ec_vf_func = mlx5_core_is_ec_vf_vport(dev, vport);
 	u8 in[MLX5_ST_SZ_BYTES(query_hca_cap_in)] = {};
+	u16 vhca_id = 0, function_id = 0;
+	bool ec_vf_func = false;
+
+	/* if this vport is referring to a vport on the ec PF (embedded cpu )
+	 * let the FW know which domain we are querying since vport numbers or
+	 * function_ids are not unique across the different PF domains,
+	 * unless we use vhca_id as the function_id below.
+	 */
+	ec_vf_func = mlx5_core_is_ec_vf_vport(dev, vport);
+	function_id = mlx5_vport_to_func_id(dev, vport, ec_vf_func);
+
+	if (mlx5_vport_use_vhca_id_as_func_id(dev, vport, &vhca_id)) {
+		MLX5_SET(query_hca_cap_in, in, function_id_type, 1);
+		function_id = vhca_id;
+		ec_vf_func = false;
+		mlx5_core_dbg(dev, "%s using vhca_id as function_id for vport %d vhca_id 0x%x\n",
+			      __func__, vport, vhca_id);
+	}
 
 	opmod = (opmod << 1) | (HCA_CAP_OPMOD_GET_MAX & 0x01);
 	MLX5_SET(query_hca_cap_in, in, opcode, MLX5_CMD_OP_QUERY_HCA_CAP);
 	MLX5_SET(query_hca_cap_in, in, op_mod, opmod);
-	MLX5_SET(query_hca_cap_in, in, function_id, mlx5_vport_to_func_id(dev, vport, ec_vf_func));
 	MLX5_SET(query_hca_cap_in, in, other_function, true);
 	MLX5_SET(query_hca_cap_in, in, ec_vf_function, ec_vf_func);
+	MLX5_SET(query_hca_cap_in, in, function_id, function_id);
 	return mlx5_cmd_exec_inout(dev, query_hca_cap, in, out);
 }
 EXPORT_SYMBOL_GPL(mlx5_vport_get_other_func_cap);
@@ -1233,8 +1260,9 @@ int mlx5_vport_get_vhca_id(struct mlx5_core_dev *dev, u16 vport, u16 *vhca_id)
 int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap,
 				  u16 vport, u16 opmod)
 {
-	bool ec_vf_func = mlx5_core_is_ec_vf_vport(dev, vport);
 	int set_sz = MLX5_ST_SZ_BYTES(set_hca_cap_in);
+	u16 vhca_id = 0, function_id = 0;
+	bool ec_vf_func = false;
 	void *set_hca_cap;
 	void *set_ctx;
 	int ret;
@@ -1243,14 +1271,29 @@ int mlx5_vport_set_other_func_cap(struct mlx5_core_dev *dev, const void *hca_cap
 	if (!set_ctx)
 		return -ENOMEM;
 
+	/* if this vport is referring to a vport on the ec PF (embedded cpu )
+	 * let the FW know which domain we are querying since vport numbers or
+	 * function_ids are not unique across the different PF domains,
+	 * unless we use vhca_id as the function_id below.
+	 */
+	ec_vf_func = mlx5_core_is_ec_vf_vport(dev, vport);
+	function_id = mlx5_vport_to_func_id(dev, vport, ec_vf_func);
+
+	if (mlx5_vport_use_vhca_id_as_func_id(dev, vport, &vhca_id)) {
+		MLX5_SET(set_hca_cap_in, set_ctx, function_id_type, 1);
+		function_id = vhca_id;
+		ec_vf_func = false;
+		mlx5_core_dbg(dev, "%s using vhca_id as function_id for vport %d vhca_id 0x%x\n",
+			      __func__, vport, vhca_id);
+	}
+
 	MLX5_SET(set_hca_cap_in, set_ctx, opcode, MLX5_CMD_OP_SET_HCA_CAP);
 	MLX5_SET(set_hca_cap_in, set_ctx, op_mod, opmod << 1);
 	set_hca_cap = MLX5_ADDR_OF(set_hca_cap_in, set_ctx, capability);
 	memcpy(set_hca_cap, hca_cap, MLX5_ST_SZ_BYTES(cmd_hca_cap));
-	MLX5_SET(set_hca_cap_in, set_ctx, function_id,
-		 mlx5_vport_to_func_id(dev, vport, ec_vf_func));
 	MLX5_SET(set_hca_cap_in, set_ctx, other_function, true);
 	MLX5_SET(set_hca_cap_in, set_ctx, ec_vf_function, ec_vf_func);
+	MLX5_SET(set_hca_cap_in, set_ctx, function_id, function_id);
 	ret = mlx5_cmd_exec_in(dev, set_hca_cap, set_ctx);
 
 	kfree(set_ctx);
-- 
2.50.1


