Return-Path: <linux-rdma+bounces-3175-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B0B909E61
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AC1C1F213D1
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Jun 2024 16:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A721BC23;
	Sun, 16 Jun 2024 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/huRDZj"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1421B806;
	Sun, 16 Jun 2024 16:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718554156; cv=none; b=TYaQp2oPN+7jv3ZchhbNITsUlBHGy78CF7paIqW0GeoAlh+bq8P1xOazSr90BJhmTXbwcblRoQ7rkt6I17y9QxggklJARMUIUGcEH8nm2HIuuhM3V3TiE69iz3XZfVI4R8V09m0zdSkvndxiENzNli1jleiwuOghwMN7TDjPBhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718554156; c=relaxed/simple;
	bh=V2XTuLXyvWTD/IwUFmy73QxNMOk+DkkMXewMdlEF2Sc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASeFNwNJQuuylT8bnZSU3tPERMfO4Rch+5/ubnVHR4+laCcPNZQ273FM4lR73a5sa6gwUhk44H4RoJJ5lDZ5DM0ApICRXC/LH4ekcmYdnwbZNyolz8JMtkg8RyvWOXjysaE0XyRIzjkHA9pTL0qkw5VtMq3jd8nLEqe92kMLFQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/huRDZj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B34C2BBFC;
	Sun, 16 Jun 2024 16:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718554156;
	bh=V2XTuLXyvWTD/IwUFmy73QxNMOk+DkkMXewMdlEF2Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=W/huRDZjtc+GSHHgHwkq7ee7cAMYHoF8TYWxSqcBHNKlyi3yWGG38WyBv0tCvBISV
	 qHAzcTHPWM1XofTSsxYCE8BkWJHCefsmoIS1d+47kTImYdcpPs3SeyzbR0il6/jNW7
	 qGaERvfrFkmeYatCghk4ynh1dfiPR1xYYVMIqgwN3YklzIQflJK7DgoXZwDQcXTB8Y
	 2xRd+qyqbh2RNe54urk/UdsinIfEg3iytrFRh5oFTbUJ+8eO5R797G5akzW/GVEWKc
	 Zh/VLX614FxSkUMB32l9DrRg+DKHFV1z3OySXoEJQwjkXCJyOGsoL1ojk6xeBtKwIE
	 kN5RmoyuIEVdQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Mark Zhang <markzhang@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH rdma-next 07/12] RDMA/mlx5: Support plane device and driver APIs to add and delete it
Date: Sun, 16 Jun 2024 19:08:39 +0300
Message-ID: <e933cd0562aece181f8657af2ca0f5b387d0f14e.1718553901.git.leon@kernel.org>
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

This patch supports driver APIs "add_sub_dev" and "del_sub_dev", to
add and delete a plane device respectively.
A mlx5 plane device is a rdma SMI device; It provides the SMI capability
through user MAD for it's parent, the logical multi-plane aggregated
device. For a plane port:
- It supports QP0 only;
- When adding a plane device, all plane ports are added;
- For some commands like mad_ifc, both plane_index and native portnum
  is needed;
- When querying or modifying a plane port context, the native portnum
  must be used, as the query/modify_hca_vport_context command doesn't
  support plane port.

Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
---
 drivers/infiniband/hw/mlx5/cmd.c     |  12 ++-
 drivers/infiniband/hw/mlx5/cmd.h     |   2 +-
 drivers/infiniband/hw/mlx5/mad.c     |   2 +-
 drivers/infiniband/hw/mlx5/main.c    | 116 ++++++++++++++++++++++++++-
 drivers/infiniband/hw/mlx5/mlx5_ib.h |   8 ++
 drivers/infiniband/hw/mlx5/qp.c      |   7 +-
 drivers/infiniband/hw/mlx5/qpc.c     |  13 ++-
 7 files changed, 147 insertions(+), 13 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/cmd.c b/drivers/infiniband/hw/mlx5/cmd.c
index 1d0c8d5e745b..895b62cc528d 100644
--- a/drivers/infiniband/hw/mlx5/cmd.c
+++ b/drivers/infiniband/hw/mlx5/cmd.c
@@ -177,7 +177,7 @@ int mlx5_cmd_xrcd_dealloc(struct mlx5_core_dev *dev, u32 xrcdn, u16 uid)
 	return mlx5_cmd_exec_in(dev, dealloc_xrcd, in);
 }
 
-int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
+int mlx5_cmd_mad_ifc(struct mlx5_ib_dev *dev, const void *inb, void *outb,
 		     u16 opmod, u8 port)
 {
 	int outlen = MLX5_ST_SZ_BYTES(mad_ifc_out);
@@ -195,12 +195,18 @@ int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
 
 	MLX5_SET(mad_ifc_in, in, opcode, MLX5_CMD_OP_MAD_IFC);
 	MLX5_SET(mad_ifc_in, in, op_mod, opmod);
-	MLX5_SET(mad_ifc_in, in, port, port);
+	if (dev->ib_dev.type == RDMA_DEVICE_TYPE_SMI) {
+		MLX5_SET(mad_ifc_in, in, plane_index, port);
+		MLX5_SET(mad_ifc_in, in, port,
+			 smi_to_native_portnum(dev, port));
+	} else {
+		MLX5_SET(mad_ifc_in, in, port, port);
+	}
 
 	data = MLX5_ADDR_OF(mad_ifc_in, in, mad);
 	memcpy(data, inb, MLX5_FLD_SZ_BYTES(mad_ifc_in, mad));
 
-	err = mlx5_cmd_exec_inout(dev, mad_ifc, in, out);
+	err = mlx5_cmd_exec_inout(dev->mdev, mad_ifc, in, out);
 	if (err)
 		goto out;
 
diff --git a/drivers/infiniband/hw/mlx5/cmd.h b/drivers/infiniband/hw/mlx5/cmd.h
index 93a971a40d11..e5cd31270443 100644
--- a/drivers/infiniband/hw/mlx5/cmd.h
+++ b/drivers/infiniband/hw/mlx5/cmd.h
@@ -54,7 +54,7 @@ int mlx5_cmd_detach_mcg(struct mlx5_core_dev *dev, union ib_gid *mgid,
 			u32 qpn, u16 uid);
 int mlx5_cmd_xrcd_alloc(struct mlx5_core_dev *dev, u32 *xrcdn, u16 uid);
 int mlx5_cmd_xrcd_dealloc(struct mlx5_core_dev *dev, u32 xrcdn, u16 uid);
-int mlx5_cmd_mad_ifc(struct mlx5_core_dev *dev, const void *inb, void *outb,
+int mlx5_cmd_mad_ifc(struct mlx5_ib_dev *dev, const void *inb, void *outb,
 		     u16 opmod, u8 port);
 int mlx5_cmd_uar_alloc(struct mlx5_core_dev *dev, u32 *uarn, u16 uid);
 int mlx5_cmd_uar_dealloc(struct mlx5_core_dev *dev, u32 uarn, u16 uid);
diff --git a/drivers/infiniband/hw/mlx5/mad.c b/drivers/infiniband/hw/mlx5/mad.c
index 3e43687a7f6f..ead836d159d3 100644
--- a/drivers/infiniband/hw/mlx5/mad.c
+++ b/drivers/infiniband/hw/mlx5/mad.c
@@ -69,7 +69,7 @@ static int mlx5_MAD_IFC(struct mlx5_ib_dev *dev, int ignore_mkey,
 	if (ignore_bkey || !in_wc)
 		op_modifier |= 0x2;
 
-	return mlx5_cmd_mad_ifc(dev->mdev, in_mad, response_mad, op_modifier,
+	return mlx5_cmd_mad_ifc(dev, in_mad, response_mad, op_modifier,
 				port);
 }
 
diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 55eb60715b48..3a653998bd88 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -313,6 +313,14 @@ struct mlx5_core_dev *mlx5_ib_get_native_port_mdev(struct mlx5_ib_dev *ibdev,
 	struct mlx5_ib_multiport_info *mpi;
 	struct mlx5_ib_port *port;
 
+	if (ibdev->ib_dev.type == RDMA_DEVICE_TYPE_SMI) {
+		if (native_port_num)
+			*native_port_num = smi_to_native_portnum(ibdev,
+								 ib_port_num);
+		return ibdev->mdev;
+
+	}
+
 	if (!mlx5_core_mp_enabled(ibdev->mdev) ||
 	    ll != IB_LINK_LAYER_ETHERNET) {
 		if (native_port_num)
@@ -1378,6 +1386,9 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u32 port,
 
 	/* props being zeroed by the caller, avoid zeroing it here */
 
+	if (ibdev->type == RDMA_DEVICE_TYPE_SMI)
+		port = smi_to_native_portnum(dev, port);
+
 	err = mlx5_query_hca_vport_context(mdev, 0, port, 0, rep);
 	if (err)
 		goto out;
@@ -1393,7 +1404,8 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u32 port,
 	if (dev->num_plane) {
 		props->port_cap_flags |= IB_PORT_SM_DISABLED;
 		props->port_cap_flags &= ~IB_PORT_SM;
-	}
+	} else if (ibdev->type == RDMA_DEVICE_TYPE_SMI)
+		props->port_cap_flags &= ~IB_PORT_CM_SUP;
 
 	props->gid_tbl_len	= mlx5_get_gid_table_len(MLX5_CAP_GEN(mdev, gid_table_size));
 	props->max_msg_sz	= 1 << MLX5_CAP_GEN(mdev, log_max_msg);
@@ -2843,7 +2855,8 @@ static int set_has_smi_cap(struct mlx5_ib_dev *dev)
 		if (dev->num_plane) {
 			dev->port_caps[port - 1].has_smi = false;
 			continue;
-		} else if (!MLX5_CAP_GEN(dev->mdev, ib_virt)) {
+		} else if (!MLX5_CAP_GEN(dev->mdev, ib_virt) ||
+			dev->ib_dev.type == RDMA_DEVICE_TYPE_SMI) {
 			dev->port_caps[port - 1].has_smi = true;
 			continue;
 		}
@@ -3057,6 +3070,8 @@ static u32 get_core_cap_flags(struct ib_device *ibdev,
 		return ret | RDMA_CORE_CAP_PROT_IB | RDMA_CORE_CAP_IB_MAD |
 			RDMA_CORE_CAP_IB_CM | RDMA_CORE_CAP_IB_SA |
 			RDMA_CORE_CAP_AF_IB;
+	else if (ibdev->type == RDMA_DEVICE_TYPE_SMI)
+		return ret | RDMA_CORE_CAP_IB_MAD | RDMA_CORE_CAP_IB_SMI;
 
 	if (ll == IB_LINK_LAYER_INFINIBAND)
 		return ret | RDMA_CORE_PORT_IBA_IB;
@@ -3093,6 +3108,9 @@ static int mlx5_port_immutable(struct ib_device *ibdev, u32 port_num,
 		return err;
 
 	if (ll == IB_LINK_LAYER_INFINIBAND) {
+		if (ibdev->type == RDMA_DEVICE_TYPE_SMI)
+			port_num = smi_to_native_portnum(dev, port_num);
+
 		err = mlx5_query_hca_vport_context(dev->mdev, 0, port_num, 0,
 						   &rep);
 		if (err)
@@ -3892,12 +3910,18 @@ static int mlx5_ib_stage_init_init(struct mlx5_ib_dev *dev)
 	return err;
 }
 
+static struct ib_device *mlx5_ib_add_sub_dev(struct ib_device *parent,
+					     enum rdma_nl_dev_type type,
+					     const char *name);
+static void mlx5_ib_del_sub_dev(struct ib_device *sub_dev);
+
 static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.owner = THIS_MODULE,
 	.driver_id = RDMA_DRIVER_MLX5,
 	.uverbs_abi_ver	= MLX5_IB_UVERBS_ABI_VERSION,
 
 	.add_gid = mlx5_ib_add_gid,
+	.add_sub_dev = mlx5_ib_add_sub_dev,
 	.alloc_mr = mlx5_ib_alloc_mr,
 	.alloc_mr_integrity = mlx5_ib_alloc_mr_integrity,
 	.alloc_pd = mlx5_ib_alloc_pd,
@@ -3912,6 +3936,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
 	.dealloc_pd = mlx5_ib_dealloc_pd,
 	.dealloc_ucontext = mlx5_ib_dealloc_ucontext,
 	.del_gid = mlx5_ib_del_gid,
+	.del_sub_dev = mlx5_ib_del_sub_dev,
 	.dereg_mr = mlx5_ib_dereg_mr,
 	.destroy_ah = mlx5_ib_destroy_ah,
 	.destroy_cq = mlx5_ib_destroy_cq,
@@ -4201,7 +4226,9 @@ static int mlx5_ib_stage_ib_reg_init(struct mlx5_ib_dev *dev)
 {
 	const char *name;
 
-	if (!mlx5_lag_is_active(dev->mdev))
+	if (dev->sub_dev_name)
+		name = dev->sub_dev_name;
+	else if (!mlx5_lag_is_active(dev->mdev))
 		name = "mlx5_%d";
 	else
 		name = "mlx5_bond_%d";
@@ -4462,6 +4489,89 @@ const struct mlx5_ib_profile raw_eth_profile = {
 		     NULL),
 };
 
+static const struct mlx5_ib_profile plane_profile = {
+	STAGE_CREATE(MLX5_IB_STAGE_INIT,
+		     mlx5_ib_stage_init_init,
+		     mlx5_ib_stage_init_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_CAPS,
+		     mlx5_ib_stage_caps_init,
+		     mlx5_ib_stage_caps_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_NON_DEFAULT_CB,
+		     mlx5_ib_stage_non_default_cb,
+		     NULL),
+	STAGE_CREATE(MLX5_IB_STAGE_QP,
+		     mlx5_init_qp_table,
+		     mlx5_cleanup_qp_table),
+	STAGE_CREATE(MLX5_IB_STAGE_SRQ,
+		     mlx5_init_srq_table,
+		     mlx5_cleanup_srq_table),
+	STAGE_CREATE(MLX5_IB_STAGE_DEVICE_RESOURCES,
+		     mlx5_ib_dev_res_init,
+		     mlx5_ib_dev_res_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_BFREG,
+		     mlx5_ib_stage_bfrag_init,
+		     mlx5_ib_stage_bfrag_cleanup),
+	STAGE_CREATE(MLX5_IB_STAGE_IB_REG,
+		     mlx5_ib_stage_ib_reg_init,
+		     mlx5_ib_stage_ib_reg_cleanup),
+};
+
+static struct ib_device *mlx5_ib_add_sub_dev(struct ib_device *parent,
+					     enum rdma_nl_dev_type type,
+					     const char *name)
+{
+	struct mlx5_ib_dev *mparent = to_mdev(parent), *mplane;
+	enum rdma_link_layer ll;
+	int ret;
+
+	if (mparent->smi_dev)
+		return ERR_PTR(-EEXIST);
+
+	ll = mlx5_port_type_cap_to_rdma_ll(MLX5_CAP_GEN(mparent->mdev,
+							port_type));
+	if (type != RDMA_DEVICE_TYPE_SMI || !mparent->num_plane ||
+	    ll != IB_LINK_LAYER_INFINIBAND ||
+	    !MLX5_CAP_GEN_2(mparent->mdev, multiplane_qp_ud))
+		return ERR_PTR(-EOPNOTSUPP);
+
+	mplane = ib_alloc_device(mlx5_ib_dev, ib_dev);
+	if (!mplane)
+		return ERR_PTR(-ENOMEM);
+
+	mplane->port = kcalloc(mparent->num_plane * mparent->num_ports,
+			       sizeof(*mplane->port), GFP_KERNEL);
+	if (!mplane->port) {
+		ret = -ENOMEM;
+		goto fail_kcalloc;
+	}
+
+	mplane->ib_dev.type = type;
+	mplane->mdev = mparent->mdev;
+	mplane->num_ports = mparent->num_plane;
+	mplane->sub_dev_name = name;
+
+	ret = __mlx5_ib_add(mplane, &plane_profile);
+	if (ret)
+		goto fail_ib_add;
+
+	mparent->smi_dev = mplane;
+	return &mplane->ib_dev;
+
+fail_ib_add:
+	kfree(mplane->port);
+fail_kcalloc:
+	ib_dealloc_device(&mplane->ib_dev);
+	return ERR_PTR(ret);
+}
+
+static void mlx5_ib_del_sub_dev(struct ib_device *sub_dev)
+{
+	struct mlx5_ib_dev *mdev = to_mdev(sub_dev);
+
+	to_mdev(sub_dev->parent)->smi_dev = NULL;
+	__mlx5_ib_remove(mdev, mdev->profile, MLX5_IB_STAGE_MAX);
+}
+
 static int mlx5r_mp_probe(struct auxiliary_device *adev,
 			  const struct auxiliary_device_id *id)
 {
diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
index d97d6bc2dbaa..bf25ddb17bce 100644
--- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
+++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
@@ -1191,6 +1191,8 @@ struct mlx5_ib_dev {
 #endif
 
 	u8 num_plane;
+	struct mlx5_ib_dev *smi_dev;
+	const char *sub_dev_name;
 };
 
 static inline struct mlx5_ib_cq *to_mibcq(struct mlx5_core_cq *mcq)
@@ -1698,4 +1700,10 @@ static inline bool mlx5_umem_needs_ats(struct mlx5_ib_dev *dev,
 int set_roce_addr(struct mlx5_ib_dev *dev, u32 port_num,
 		  unsigned int index, const union ib_gid *gid,
 		  const struct ib_gid_attr *attr);
+
+static inline u32 smi_to_native_portnum(struct mlx5_ib_dev *dev, u32 port)
+{
+	return (port - 1) / dev->num_ports + 1;
+}
+
 #endif /* MLX5_IB_H */
diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
index be288cc7a3c0..66d9b44a6991 100644
--- a/drivers/infiniband/hw/mlx5/qp.c
+++ b/drivers/infiniband/hw/mlx5/qp.c
@@ -4219,7 +4219,12 @@ static int __mlx5_ib_modify_qp(struct ib_qp *ibqp,
 
 	/* todo implement counter_index functionality */
 
-	if (is_sqp(qp->type))
+	if (dev->ib_dev.type == RDMA_DEVICE_TYPE_SMI && is_qp0(qp->type)) {
+		MLX5_SET(ads, pri_path, vhca_port_num,
+			 smi_to_native_portnum(dev, qp->port));
+		if (cur_state == IB_QPS_INIT && new_state == IB_QPS_RTR)
+			MLX5_SET(ads, pri_path, plane_index, qp->port);
+	} else if (is_sqp(qp->type))
 		MLX5_SET(ads, pri_path, vhca_port_num, qp->port);
 
 	if (attr_mask & IB_QP_PORT)
diff --git a/drivers/infiniband/hw/mlx5/qpc.c b/drivers/infiniband/hw/mlx5/qpc.c
index d9cf6982d645..d3dcc272200a 100644
--- a/drivers/infiniband/hw/mlx5/qpc.c
+++ b/drivers/infiniband/hw/mlx5/qpc.c
@@ -249,7 +249,8 @@ int mlx5_qpc_create_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
 	if (err)
 		goto err_cmd;
 
-	mlx5_debug_qp_add(dev->mdev, qp);
+	if (dev->ib_dev.type != RDMA_DEVICE_TYPE_SMI)
+		mlx5_debug_qp_add(dev->mdev, qp);
 
 	return 0;
 
@@ -307,7 +308,8 @@ int mlx5_core_destroy_qp(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp)
 {
 	u32 in[MLX5_ST_SZ_DW(destroy_qp_in)] = {};
 
-	mlx5_debug_qp_remove(dev->mdev, qp);
+	if (dev->ib_dev.type != RDMA_DEVICE_TYPE_SMI)
+		mlx5_debug_qp_remove(dev->mdev, qp);
 
 	destroy_resource_common(dev, qp);
 
@@ -504,7 +506,9 @@ int mlx5_init_qp_table(struct mlx5_ib_dev *dev)
 	spin_lock_init(&table->lock);
 	INIT_RADIX_TREE(&table->tree, GFP_ATOMIC);
 	xa_init(&table->dct_xa);
-	mlx5_qp_debugfs_init(dev->mdev);
+
+	if (dev->ib_dev.type != RDMA_DEVICE_TYPE_SMI)
+		mlx5_qp_debugfs_init(dev->mdev);
 
 	table->nb.notifier_call = rsc_event_notifier;
 	mlx5_notifier_register(dev->mdev, &table->nb);
@@ -517,7 +521,8 @@ void mlx5_cleanup_qp_table(struct mlx5_ib_dev *dev)
 	struct mlx5_qp_table *table = &dev->qp_table;
 
 	mlx5_notifier_unregister(dev->mdev, &table->nb);
-	mlx5_qp_debugfs_cleanup(dev->mdev);
+	if (dev->ib_dev.type != RDMA_DEVICE_TYPE_SMI)
+		mlx5_qp_debugfs_cleanup(dev->mdev);
 }
 
 int mlx5_core_qp_query(struct mlx5_ib_dev *dev, struct mlx5_core_qp *qp,
-- 
2.45.2


