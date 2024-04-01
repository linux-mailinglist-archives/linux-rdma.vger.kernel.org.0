Return-Path: <linux-rdma+bounces-1695-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF1489393F
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 11:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEB01F21BB4
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Apr 2024 09:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FF6FC05;
	Mon,  1 Apr 2024 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V0Bznzf5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D2EB10979;
	Mon,  1 Apr 2024 09:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962372; cv=fail; b=VLuCJvJf8uWjVQzcNf0DOreHXLoUSy9the3Q2jgtUjhFwvmDhkl1wmUPiFXXunKh5Die4eGqO6a+SOvjdeC3F8bgGftAUg1tXEx6wgL7dv0HC6IsuFT5CrbdnVkP/FTMlHEL8pYwxP8GA09AbHJrgIioU1aqiVbIBcxD/Q05sl4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962372; c=relaxed/simple;
	bh=gcuz4StINLJ0R4led+6b2ZvSdVadYTY2NvXYbT+x4pQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=adL9CheM6mX+bX3gbf1+36vZf3RNhvtIEGF3jhfjfuY22kays/mseWLUKiZPdxGK0p7Tl4lzCuXSxC2y8PaX3WOsTz6oY8/f0NKEEvJZ1roYD+q8lt6vInPFzLfebPLIjhBHRH6OXPugQoqW5gKPCRrqf1ALQlCRdxpzWbCotx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V0Bznzf5; arc=fail smtp.client-ip=40.107.94.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFem7INpRybT16I0m0XOelSn4vQUfB8kVcE4DWfhnO0kWSMz91p7t1U+B5Dkr8q9d5DE/dVB4X/ZkzW3rxXtmZUQ+diRC1gjdYOA8FgBTg2aCy1ZVMlzGSq7EYG1+8kBmI2SVwMCRVU4kYRxHeGrqcAqnhVHdpVoXFN/H2na0gdKwhNnUovO5zcVDuMXg686WwSbdcFyGEf6eW9AfTG22f39vpQz8TPbMVcH3XwNFt09LricE5DY2GfWjwYUANiErNNIl0XW4gUbmw5B4Ad6mt8vZQoFfOsgjNO+uolID1Pk8ma1L4iD2m8/wSKzAEM1VTXAVcaUB4CdIzSxLd0/HQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gfm2qdOtVqLijsTOFtal1oa1/U+Id+r32Ctod2m4EQc=;
 b=Vr7mN1vdA5c80jFfIxRKda3boeuGJUPDUADAJvJgcnqIa4BU2aL71QFeKboU+O2zvUn7ouLYSw9NH2XTbme/YqO6/vFv4cvoidAJzQAPR8n8zrWgiNVwQFQwni+PA3lbuHgIH8PnJ43Jcy2Oz8SprgKzhCBh0jImTmMfp4AxLO2Q7B/0EvTE9ahmNfoiWus93TN3+y4qpC0aNN+01mDukNCG+L+UFu1ofVTdPEF2ARSG7UyJfkTo5lJeJzcPpTcRiCKCDjKiIpRthH9myvngzPpNyFu+eRRzj7HTNqu3sCOJTrofshbEkPgK0z2KmFkwPK+I8B42dcBOjT/flNjvmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gfm2qdOtVqLijsTOFtal1oa1/U+Id+r32Ctod2m4EQc=;
 b=V0Bznzf50ozp4FNbLVN8s0RciIR95jNctu5nacbtjH+nJEdvdnZzF07QfujbnIyAIv7iPgSWaQwkcrsnYmGEIdpmUnnmpcqbbJta8aT24UXE16GaDKui4AKOvC+HcMrQf5Cb09YM/M4caFx+PE6Zm4FB93Tv9c4in3mYKXykr2XqVNXBEmcrS5bzYlP47ExngNOaf0CSe0CAw7xKf3KjRgL5j6diVIvkmHpzwW+SU8HL4lSWyUcJ61K11dpCoS5RZmkwJaWdEyJ/rN5hmnbu5KOoCSNB6qHAnZ/+luaMJ1Dgqf4vEQ7c4+ySQ3n7M/xYSdoRMFoYOTim5+vjNn7dVA==
Received: from SJ0PR03CA0147.namprd03.prod.outlook.com (2603:10b6:a03:33c::32)
 by PH8PR12MB6939.namprd12.prod.outlook.com (2603:10b6:510:1be::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 1 Apr
 2024 09:06:07 +0000
Received: from SJ1PEPF00001CDD.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::a0) by SJ0PR03CA0147.outlook.office365.com
 (2603:10b6:a03:33c::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Mon, 1 Apr 2024 09:06:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDD.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 1 Apr 2024 09:06:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 1 Apr 2024
 02:05:53 -0700
Received: from sw-mtx-036.mtx.labs.mlnx (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Mon, 1 Apr 2024 02:05:51 -0700
From: Parav Pandit <parav@nvidia.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <corbet@lwn.net>
CC: <saeedm@nvidia.com>, <leon@kernel.org>, <jiri@resnulli.us>,
	<shayd@nvidia.com>, <danielj@nvidia.com>, <dchumak@nvidia.com>,
	<linux-doc@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Parav Pandit
	<parav@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [net-next 2/2] mlx5/core: Support max_io_eqs for a function
Date: Mon, 1 Apr 2024 12:05:31 +0300
Message-ID: <20240401090531.574575-3-parav@nvidia.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20240401090531.574575-1-parav@nvidia.com>
References: <20240401090531.574575-1-parav@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDD:EE_|PH8PR12MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: ff0ee1a9-df75-41a6-162d-08dc522af756
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	NHGQUXXu65UJffr5NnFHjsNikKros5KKkIdzuWPyZ2d0OmlWltaJ/GQF99R7Qs/IJ0Ojk3Odr0EOl6gIZeakSd6tWiHmdOzx6u6N1jt3X+czrJon00rbOlLIVrEWTUeNLeptNZs7R8016MvIYv+NXNyp2Vp5KF5w91WzXX+ulQ8+1UTkaJjEVpKwtsvA0avVJDJFGq4hbinvAfJ9gGSUyw6e2pCHlvvYoSSwVyGI9E/sf4EnQxUpxx/xhqJHafajfoxcSe/YsrjzRQ8HJzwRv/uwMgKrGH8dShl/BHs4bEg3iBldnBgthYO7wd7w4CIdjVceGuivKBe7Pb7wDGMZuYopb6OR4zjRGib4K7thNop6OmkgQGky/yFwL5lVji9H1TIKG7I1XHinF6DZajEA+Y57edVmgfRz9ejmaFxStvbGWNgemTiZjL/2ql5qb/OwEAGhSqJk30/N660TX/i9aUQPM4HVT6xZ6A1tSaNUF4bjAMXs2m8vpLjs53L61PasY2B+6yE7kahZ6FIOgM/lWow9sJp1p3RWn/c1Sdr44H23uzTEQBIOFceNIXE8A6zBZqo3bqFy6Gd6bdYRZGkbYiJydXHtnl/EXTuMR9nQTUWJoNNQtTZ23sZ7NLV9TKRZ9cQ03YQTHoQZGQA8+1/xoSAyG69R3Q/upR2lyNOlQgofeAnFAMTM1yrJCuY5fGqLoKCQUKfU5zr7qrkSAn12nmBOLfAyaHMkZmEjQTLvNmhYE3DfUi3JJnJdkMpsn1IM
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(7416005)(376005)(82310400014)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2024 09:06:07.0236
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff0ee1a9-df75-41a6-162d-08dc522af756
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDD.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6939

Implement get and set for the maximum IO event queues for SF and VF.
This enables administrator on the hypervisor to control the maximum
IO event queues which are typically used to derive the maximum and
default number of net device channels or rdma device completion vectors.

Signed-off-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 .../mellanox/mlx5/core/esw/devlink_port.c     |  2 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 94 +++++++++++++++++++
 3 files changed, 103 insertions(+)

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
index baaae628b0a0..9d9a06a25cac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -66,6 +66,8 @@
 
 #define MLX5_ESW_FT_OFFLOADS_DROP_RULE (1)
 
+#define MLX5_ESW_MAX_CTRL_EQS 4
+
 static struct esw_vport_tbl_namespace mlx5_esw_vport_tbl_mirror_ns = {
 	.max_fte = MLX5_ESW_VPORT_TBL_SIZE,
 	.max_num_groups = MLX5_ESW_VPORT_TBL_NUM_GROUPS,
@@ -4557,3 +4559,95 @@ int mlx5_devlink_port_fn_ipsec_packet_set(struct devlink_port *port,
 	return err;
 }
 #endif /* CONFIG_XFRM_OFFLOAD */
+
+int mlx5_devlink_port_fn_max_io_eqs_get(struct devlink_port *port, u32 *max_io_eqs,
+					struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	u16 vport_num = vport->vport;
+	void *query_ctx;
+	void *hca_caps;
+	u32 max_eqs;
+	int err;
+
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
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
+	return 0;
+}
+
+int mlx5_devlink_port_fn_max_io_eqs_set(struct devlink_port *port, u32 max_io_eqs,
+					struct netlink_ext_ack *extack)
+{
+	struct mlx5_eswitch *esw = mlx5_devlink_eswitch_nocheck_get(port->devlink);
+	struct mlx5_vport *vport = mlx5_devlink_port_vport_get(port);
+	int query_out_sz = MLX5_ST_SZ_BYTES(query_hca_cap_out);
+	u16 vport_num = vport->vport;
+	u16 max_eqs = max_io_eqs + MLX5_ESW_MAX_CTRL_EQS;
+	void *query_ctx;
+	void *hca_caps;
+	int err;
+
+	if (!MLX5_CAP_GEN(esw->dev, vhca_resource_manager)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device doesn't support VHCA management");
+		return -EOPNOTSUPP;
+	}
+
+	if (max_io_eqs + MLX5_ESW_MAX_CTRL_EQS > USHRT_MAX) {
+		NL_SET_ERR_MSG_MOD(extack, "Supplied value out of range");
+		return -EINVAL;
+	}
+
+	mutex_lock(&esw->state_lock);
+
+	query_ctx = kzalloc(query_out_sz, GFP_KERNEL);
+	if (!query_ctx) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	err = mlx5_vport_get_other_func_cap(esw->dev, vport_num, query_ctx,
+					    MLX5_CAP_GENERAL);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed getting HCA caps");
+		goto out_free;
+	}
+
+	hca_caps = MLX5_ADDR_OF(query_hca_cap_out, query_ctx, capability);
+	MLX5_SET(cmd_hca_cap, hca_caps, max_num_eqs, max_eqs);
+
+	err = mlx5_vport_set_other_func_cap(esw->dev, hca_caps, vport_num,
+					    MLX5_SET_HCA_CAP_OP_MOD_GENERAL_DEVICE);
+	if (err)
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting HCA roce cap");
+
+out_free:
+	kfree(query_ctx);
+out:
+	mutex_unlock(&esw->state_lock);
+	return err;
+}
-- 
2.26.2


