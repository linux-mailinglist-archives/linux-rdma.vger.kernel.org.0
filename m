Return-Path: <linux-rdma+bounces-1733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7648951CD
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 13:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 710FAB2422D
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Apr 2024 11:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AF496996E;
	Tue,  2 Apr 2024 11:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BHoIF3Qw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2059.outbound.protection.outlook.com [40.107.220.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9952C627E8;
	Tue,  2 Apr 2024 11:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712057185; cv=fail; b=adQ+Q5iA0A32eYkgw7UOAUIFAaSKBZvWB2GNDGRW05OHbsjhyvbRzC5xAcq9LAiaO4+jYizXDc0/g0oNA0dFL9jKMH+RE71xPOFJD8dOZsX3qjECq/i/3bPD2rACPQ1WX/JV+YPwwcT70zYbWS+iqCCiNOaZIQWEXycRrk5oiNM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712057185; c=relaxed/simple;
	bh=It/6SHSaixETk5v3CsVqb9Ev8JhOOChMjUsJTFvvnBo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OV15aUyV0vt9ylavmpKtkte4FMrrjviUrhlvwpQ7A2CaIei8wbdVwAoVrqPAmVU2OVA7R//HXzHg59aL3Za0hTaqX7CS5WQcKPC6jLMAuemunkHV6y2fQZQZF0AwAl2SZxd2XRgYm6rgxznGH7XTLopJFm4bSWzJC+23MtcLQvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BHoIF3Qw; arc=fail smtp.client-ip=40.107.220.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JeTLnN8GE/eSf9vpyjv4y+qv+BK/iKn2C6Zmeb878WZ+tH0ikh8kirsqwx+5QjUgXsrJOaPGZ8nWQX/bm5M6eWvXMaUAR9pGEsH1e7EYuTcsNXGsy+Hvmj2SwGUg8CjT2C7lEOBJTZZWu8UZ3J96cAYTrwmJs20A6QNOLrWOvJg9VB/JwZ8RFjUS0meAmEAx+EzJZBAsAT+aBMCg789Ak15EIOahsC9rR+v51gdMGXp92IgLiQt3pUXgnsLjR+V0A9kXqGoPTxK9WAjmh7lEM1fSFe2GBxezcsqNj76zmwle2GEf/2pHjJgz9PSgOrZPhlUQq/QW6vZSrA0DoqCASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+u/NLwIobXyARWsSuh6gPKrqiKlbBW1Jyplj3Dv2lzE=;
 b=frZG66H8QecC0kk2c1b5tQr2AWe41S5sZKbVf9A0OKmXjyo7GiwTTnQAjqCdyiT/1FaSRMiCo3+zqsQrF3rsEx84OKNx/xIMSDXXWZXbr8vQe7qizJPjYv/yMaISHv8qzRE69Kw1Etl+0YMECe1qHDLYltBPc5kV/G247Q/qyRZJOJ1EYfxAK/n823+qE7vAH2bWdN+sf+0v8zTPrGasy65PIUQ3FWch92EnpisT3MQawQE0AvY/t0z6REOFthZk03WVilnTJKDJdeKwQo+MFP7AzLrmiGuDE10Qc02kbjqNp1lDApWZPY17IqEgZ8zQ2W9iKW8wsbzixNdKFfp0oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+u/NLwIobXyARWsSuh6gPKrqiKlbBW1Jyplj3Dv2lzE=;
 b=BHoIF3QwM6XzlA6grOsp6P3d/Xq3gPdH9giPuPfd6eS2Y1OkP8IjnG3Kxt6cdgrEU/HC3MQCcrJxxHvgRBmo6oAlgE3c5yqUS2SQ8FnGBWxAXMGmMK1g5Bd5RGqTBMEfKRbdQXmv2Qi9yno2on+l6kZS89WPbImcXDiYwHpS11po0KfxFszD4DRcXxzBTSbrKEFwk+q6E+Uqd23W4u3u55+L/zr3ravSi+e+1my+a8b7d3jA6T2UXkG2oIY8u78O4F7uDjBIsw/1vrC0pXExL5Q5X/n2HRQi8fsNkWifEkmS3WW5KS/nGAt9g+uUYR+/dpjZY2VoFn7ozMIpzyRbJg==
Received: from SJ0PR03CA0204.namprd03.prod.outlook.com (2603:10b6:a03:2ef::29)
 by DS7PR12MB5885.namprd12.prod.outlook.com (2603:10b6:8:78::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 11:26:20 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:a03:2ef:cafe::cf) by SJ0PR03CA0204.outlook.office365.com
 (2603:10b6:a03:2ef::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Tue, 2 Apr 2024 11:26:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 2 Apr 2024 11:26:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 2 Apr 2024
 04:26:07 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Tue, 2 Apr 2024 04:26:05 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>,
	<kalesh-anakkur.purayil@broadcom.com>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [net-next v2 2/2] mlx5/core: Support max_io_eqs for a function
Date: Tue, 2 Apr 2024 14:25:49 +0300
Message-ID: <20240402112549.598596-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240402112549.598596-1-parav@nvidia.com>
References: <20240402112549.598596-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|DS7PR12MB5885:EE_
X-MS-Office365-Filtering-Correlation-Id: dd997a52-e657-4002-699d-08dc5307b81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	EMQc+smjnBGV3qpMZK2bIgpubd7HyuWUVcOfzsKUOYAsuw1EjSPSlsAVT2cOrG97GWgtfrWofCDkAXRLESzHBEt6jLhjCOEI2HBle0YtJ4m9+AW2ODrtdxVP5ZYhOt7rC4WNhZaDdtln2UWt3CgVRXmr0MpgDAdJ9/KfnnN0vtH3zZpqeTw3JpoqIGDpwP70weQ7D7DcD6l6lQz2t/dayythPb6vTRcd13PqgcVQwNUhz+2Md7mWoW5EiP5ti8/vr9kw5szs1Tv8HnooGh1sDgro+MQJASq7DvbSIdzToiZvhlFapxLB7WxOeRCdAvneFllOzNWtusLRPck4qwr2sx2X0pA642rPQMEf/BPJjlpFgWGwJgag/VZxT+WsBBf10Lxk5BkpamI4kcui/bJDo7mjHglKnJ8FdVdn2d75areHNP5o7R47AfmOwuKkhQRbU+GR5fyV7qurj3ICC5DkMCQKiiVr5+wvQIbXUX8X+O7Em349jSFY6JeDQYgmhUpCjHgQHYo2icBlwIloEAd9Tpf4qQ9rsujTO4w/jP/3e/wk32BKiH4YpZh5AaAVozXq+KH2rfAhl6sZcaXtapPaLR0a4647rvxBEN8+a4/PRCpeIoW7kwLfSWDAUMMiORNZPgmwTyJEya7WSX/ZHtGZ0/yUeV0mGkYm8pyGW2GRNSgWTYseziBEvI3Gm5jMyV4T9LyAe7uzkh/4rbxCQLCXLmvyyxMHOeDwonhy/giZiKOEV8Y2Cr/H0ke3IR4Nnl6Y
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 11:26:19.7173
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd997a52-e657-4002-699d-08dc5307b81d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5885

Implement get and set for the maximum IO event queues for SF and VF.
This enables administrator on the hypervisor to control the maximum
IO event queues which are typically used to derive the maximum and
default number of net device channels or rdma device completion vectors.

Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Shay Drory <shayd@nvidia.com>
Signed-off-by: Parav Pandit <parav@nvidia.com>
---
changelog:
v1->v2:
- fixed comments from Kalesh
- fixed missing kfree in get call
- returning error code for get cmd failure
- fixed error msg copy paste error in set on cmd failure
- limited code to 80 chars limit
- fixed set function variables for reverse christmas tree
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 97 +++++++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
index d8e739cbcbce..76d1ed93c773 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/devlink_port.c
@@ -98,6 +98,8 @@ static const struct devlink_port_ops mlx5_esw_pf_vf_dl_port_ops = {
 	.port_fn_ipsec_packet_get = mlx5_devlink_port_fn_ipsec_packet_get,
 	.port_fn_ipsec_packet_set = mlx5_devlink_port_fn_ipsec_packet_set,
 #endif /* CONFIG_XFRM_OFFLOAD */
+	.port_fn_max_io_eqs_get = mlx5_devlink_port_fn_max_io_eqs_get,
+	.port_fn_max_io_eqs_set = mlx5_devlink_port_fn_max_io_eqs_set,
 };
 
 static void mlx5_esw_offloads_sf_devlink_port_attrs_set(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 349e28a6dd8d..50ce1ea20dd4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -573,6 +573,13 @@ int mlx5_devlink_port_fn_ipsec_packet_get(struct devlink_port *port, bool *is_en
 int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port, bool enable,
 					  struct netlink_ext_ack *extack);
 #endif /* CONFIG_XFRM_OFFLOAD */
+int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port,
+					u32 *max_io_eqs,
+					struct netlink_ext_ack *extack);
+int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port,
+					u32 max_io_eqs,
+					struct netlink_ext_ack *extack);
+
 void *mlx5_eswitch_get_uplink_priv(struct mlx5_eswitch *esw, u8 rep_type);
 
 int __mlx5_eswitch_set_vport_vlan(struct mlx5_eswitch *esw,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index baaae628b0a0..a6d68370d43a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -66,6 +66,8 @@
 
 #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
 
+#define MLX5_ESW_MAX_CTRL_EQS 4
+
 static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
 	.max_num_groups = MLX5_ESW_VPORT_TBL_NUM_GROUPS,
@@ -4557,3 +4559,98 @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
 	return err;
 }
 #endif /* CONFIG_XFRM_OFFLOAD */
+
+int
+mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	u16 vport_num = vport->vport;
+	struct mlx5_eswitch *esw;
+	void *query_ctx;
+	void *hca_caps;
+	u32 max_eqs;
+	int err;
+
+	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
+	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	if (!query_ctx)
+		return -ENOMEM;
+
+	mutex_lock(&esw->state_lock);
+	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
+					    MLX5_CAP_GENERAL);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		goto out;
+	}
+
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
+	max_eqs = MLX5_GET(cmd_hca_cap, hca_caps, max_num_eqs);
+	if (max_eqs < MLX5_ESW_MAX_CTRL_EQS)
+		*max_io_eqs = 0;
+	else
+		*max_io_eqs = max_eqs - MLX5_ESW_MAX_CTRL_EQS;
+out:
+	mutex_unlock(&esw->state_lock);
+	kfree(query_ctx);
+	return err;
+}
+
+int
+mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
+				    struct netlink_ext_ack *extack)
+{
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	u16 max_eqs = max_io_eqs + MLX5_ESW_MAX_CTRL_EQS;
+	u16 vport_num = vport->vport;
+	struct mlx5_eswitch *esw;
+	void *query_ctx;
+	void *hca_caps;
+	int err;
+
+	esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
+	if (max_io_eqs + MLX5_ESW_MAX_CTRL_EQS > USHRT_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
+		return -EINVAL;
+	}
+
+	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	if (!query_ctx)
+		return -ENOMEM;
+
+	mutex_lock(&esw->state_lock);
+	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
+					    MLX5_CAP_GENERAL);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		goto out;
+	}
+
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
+	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
+
+	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
+					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+	mutex_unlock(&esw->state_lock);
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA caps");
+
+out:
+	kfree(query_ctx);
+	return err;
+}
-- 
2.26.2


