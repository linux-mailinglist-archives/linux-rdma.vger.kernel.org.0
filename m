Return-Path: <linux-rdma+bounces-14572-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E42C6651F
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 22:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 79B4E29A55
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 21:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4843385A8;
	Mon, 17 Nov 2025 21:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dr5hJxX/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013060.outbound.protection.outlook.com [40.93.201.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE59E34D929;
	Mon, 17 Nov 2025 21:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763415804; cv=fail; b=cBTjpVPwonijgZCXFREqZQExiEKzuh2v9uhLe0k2hgMyJ6UviDbjgP3x/Gq0edqxSlWGgWecxshqJMk6TBIWosv6DSs5LlC6nvk3xqrGi99LD9Q9L3vJSxiahB0WfIr674KS15np+KuIfddw7vsKWEW2YpJCuiqW88j8l5AL5PY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763415804; c=relaxed/simple;
	bh=g1StgutCFHXlR6ozNoJMmAKXUyEf+4ISbk0hAK4sxuw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvbDBYwj0FAdBKc2/0oRFuI9LHhqfKQvFnWzulyADHJT1gjc07oy/csALlUv+oGPedRw0Hm5RLhSh0MijSqpYRT1acbYcZrUjgigwzcsgHAdM7E/Se0TDqLyg9oOg/c5vc56dqKkSpLyvUIwME5CODFTiRSmVUTI0MGIXfYm0cQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dr5hJxX/; arc=fail smtp.client-ip=40.93.201.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fmk33kTvLOC530LtIdBW0JEgbz+Qrkl7O2ZM+u0hRf1d4NsNAx6mUUrr8N7oksn+PofmKPABIuY1ULKIjRg583lvF7tx24m96YOO1/aFItdRzY4d/V40kIqbspdGgXKCcVlRGoc01SdztL3q1Ofnekc4iCj49YM+ErtlWwXR7y9JfQS5h90SXyZ0loPvTJ7k71lVpMZKaMno1o82nBDsDBd6ZO8+W7Fwu873jw26kN+Gm2hzjTUhpEeyGapqXxh95ke0fYGn0/PUx37b/l0kPmLFh00tw0T6fkyKFvlswQfAvyLe+xJiReVScjBhVHNGRbVw5t+n7flJeYL6FAWc9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xMH59HLFc/Xy3EQHKQeBPkk4i3QPzY75r3sf9WeBCDs=;
 b=uIgPQoEWB+9uWLvygcednxmEYVgrS0WPn1TTkxqFtQGCWqvEn4YZ+NEZ65I5p6uBNxz5acD8PSeHdjt11R8DIFuFctbZ/xqzGBB163TA9q7JhYm+WXrCz7/H2rk6MvyznWV7sqRYWqEihyT8VWRPahvzz3mbUiNXGQ/eiuwLxBycCVLV/KleoFiMhJtYmAASYd65lb3y+9r5gtaP2VatnRjhlY8uhAE0UCn73ltLRPCbBAj+vmNVvcTOZJ7OTlCmbk1TMwQ/9f5AS9f5js+Bfj8ho2/hZ8vB/sJdQYeop9Nrq8K/CX5dwfCLXKyqlwXPH7jXIaa1NpfsmeiBUHvbMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMH59HLFc/Xy3EQHKQeBPkk4i3QPzY75r3sf9WeBCDs=;
 b=dr5hJxX/D+ZKumqAtmPoY6OBgG0UwHVaMR+oQB2ex3C884TmyilxN8nk8lihLdDzz9qvbOP/MExKFYyQrSNSQ9zzAuVSYzY9zOejQKPFqIzh/AT7rUHH+tqseJSdsZyf8A62DyRVE7pU408lvfRIS0486gnBmnG+cwwcjDHBQ5I1wyD9DfYyY9yw5HskoT1oFDmcoW14MPUliJRuk3Xut1Us7vm0vqP93I4EL/JMT9ORhBhKOZQus6OPJXoU4jwANAmoUDdnuHfT6zl1jfaAFajNmEO/p79Ah3wWV0kguVELWoJT6J3RYEcr7kNjnxH5OWX1wBRhJj9zdA2ifUmRJg==
Received: from CH2PR14CA0043.namprd14.prod.outlook.com (2603:10b6:610:56::23)
 by LV3PR12MB9119.namprd12.prod.outlook.com (2603:10b6:408:1a2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Mon, 17 Nov
 2025 21:43:16 +0000
Received: from CH2PEPF0000013D.namprd02.prod.outlook.com
 (2603:10b6:610:56:cafe::9c) by CH2PR14CA0043.outlook.office365.com
 (2603:10b6:610:56::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 21:43:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000013D.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 21:43:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:55 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 13:42:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 13:42:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Richard
 Cochran" <richardcochran@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Gal Pressman
	<gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net-next 5/5] net/mlx5: Use EOPNOTSUPP instead of ENOTSUPP
Date: Mon, 17 Nov 2025 23:42:09 +0200
Message-ID: <1763415729-1238421-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
References: <1763415729-1238421-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013D:EE_|LV3PR12MB9119:EE_
X-MS-Office365-Filtering-Correlation-Id: 89487329-6350-48b1-da9a-08de26224f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?N1WMx9iP7/rtx977coY96bUBaTnMBlSJ+1nNnHJSPRSC63Ln7Ak0zjSmJ64/?=
 =?us-ascii?Q?AiJ60HjAwErRtJINiETkd/ZqRM7L4u80TGI5g0Z3Md38qgrkCr5SYMs5qOHA?=
 =?us-ascii?Q?jnf13ymJpJq28GpshvVXw9NQIzam2YAEBBBoT0Fs8xY9pqz4CoB84ykLXP6N?=
 =?us-ascii?Q?D0uYs0Vqf8l4xV5k4q8esJiv3zTge8xIo1j6pq/wj3OKtsR1Iw0Fn9YM62WQ?=
 =?us-ascii?Q?ODPA7BOnCrrPn2qtAMrLj8ApvcZEw/FXaXUJbqZzsZ1UuyStjuWrUg7rHyoK?=
 =?us-ascii?Q?MUeZ5gxeIsKgQRDIjyce1OPLdcxUqtds9mKNecK9qCzdBvmxnYWCfyPX4MJ2?=
 =?us-ascii?Q?VlazAz0SGUjVgml54kj66SVrm8TqOpuBTCoImKdiZ3+IMClMb9Gq3EVeTmG5?=
 =?us-ascii?Q?E61aznFMGFWXBJtvPOUhkj0+7yp+XlWZ+/u61Ij54g0wpk9vzyocBkBaug98?=
 =?us-ascii?Q?4DLvpa30/xjICRCQJJJ9rW/UrP+YkVUq7BoFZzfyyfKK5lUcBIGHdK+Okdal?=
 =?us-ascii?Q?H9Bx7EOxbknPbL+M+pZrvrg8jSzZ5h6Jt4RVuL97fbzwTUtvNbIr7AGD3h5f?=
 =?us-ascii?Q?QBlJKgH7otq6u8kODdcjz7OkxrZRElpqgicrvlF7p2MXbKAoEoNQpUuKPYJY?=
 =?us-ascii?Q?o0zrRM/5aWxzbKY5pjcQabSkESG4/k4gkiV/H+/3beKjhMqzI3RgAHVMJBGn?=
 =?us-ascii?Q?jF2QmmfVx8HYdLbOyMxEyZMMCLiq4GI0TdASy7h//hauw/ZcuzQBxgqw6UD4?=
 =?us-ascii?Q?Yznl16dNIihi67HRvfSQVM2ajoUj+IdVvSfWzrpuij3nyVfE0VQnxcsgi6EJ?=
 =?us-ascii?Q?+wNIFf4QyXFwNsdnnL4Ddl3kD7StDebiKKeb6CKMj62r5sock6S+M0VBPzQF?=
 =?us-ascii?Q?3i5xN3Y2tvvjIsz5FyW1YWTAQxuwQ8MMnXTU/bzCfWh+pn2W/jisSFc8poBN?=
 =?us-ascii?Q?2Iz8mno9M52Vd3TRvJ+nmskcBfGQ+CmtllmEPSGoq6HMVxOrfhpB+C/tmvCe?=
 =?us-ascii?Q?51Z+AQeojwyIodP4PLCf/TYihMNd7KW3BXgUQAjdY7oCr5UM88gMrjYzQtiF?=
 =?us-ascii?Q?2gwOqsClArBMrs5G0/bIvObCFVf/fqnjR8eD8C2JINAsOBvw+s60916pK3Mk?=
 =?us-ascii?Q?UyOrrIYXQJjhXAjS5CqG3wA4mcBLJ1hz7bj6OQZgbzyyXxiqBdnDP4iamEJ8?=
 =?us-ascii?Q?u6EzRHwzuCXV9eKRaf4ZvX+n4RxI1J/S0hoPrO9ZxNApet075fJeAdsD0wZz?=
 =?us-ascii?Q?EhDlRnTN0uQHaeIq0zliwwGkots36N475ajyB7szkfv/EvOhzCE0fbSYAHMT?=
 =?us-ascii?Q?fzrpuB7IcdqN2t8DWUnuNhF3vDjlmAQThBMN32Cink7Rgc4WMNYXGjayRlel?=
 =?us-ascii?Q?3YXCqtUy7rW3gQ10cgM6c/grZ14xLaroJkdjfpYzKUg17gRqCkeuNrBCcJA/?=
 =?us-ascii?Q?mlnC4EjWgdrYTwFXcbxRxD8v07HVaPweQiLvITrYoFqX1+yzz2QURnkKr26X?=
 =?us-ascii?Q?kZHD0afoiFmWsKZ3ICdboGhupeY3B9a95FhmADN2l9WMrevPPTmG2LRO4ohC?=
 =?us-ascii?Q?/2oJCZWukKq8gNvdt3M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 21:43:13.6548
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89487329-6350-48b1-da9a-08de26224f87
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9119

Per Documentation/dev-tools/checkpatch.rst, ENOTSUPP is not a standard
error code and should be avoided. EOPNOTSUPP should be used instead.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Gal Pressman <gal@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c  | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c   | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c       | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c       | 2 +-
 .../ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c  | 8 ++++----
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
index 080e7eab52c7..7bcf822a89f9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/diag/fw_tracer.c
@@ -54,7 +54,7 @@ static int mlx5_query_mtrc_caps(struct mlx5_fw_tracer *tracer)
 
 	if (!MLX5_GET(mtrc_cap, out, trace_to_memory)) {
 		mlx5_core_dbg(dev, "FWTracer: Device does not support logging traces to memory\n");
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 
 	tracer->trc_ver = MLX5_GET(mtrc_cap, out, trc_ver);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
index 79916f1abd14..63bdef5b4ba5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs_ethtool.c
@@ -704,7 +704,7 @@ static int validate_flow(struct mlx5e_priv *priv,
 		num_tuples += ret;
 		break;
 	default:
-		return -ENOTSUPP;
+		return -EOPNOTSUPP;
 	}
 	if ((fs->flow_type & FLOW_EXT)) {
 		ret = validate_vlan(fs);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c b/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
index e5c1012921d2..1ec61164e6b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/core.c
@@ -211,7 +211,7 @@ int mlx5_fpga_device_start(struct mlx5_core_dev *mdev)
 	max_num_qps = MLX5_CAP_FPGA(mdev, shell_caps.max_num_qps);
 	if (!max_num_qps) {
 		mlx5_fpga_err(fdev, "FPGA reports 0 QPs in SHELL_CAPS\n");
-		err = -ENOTSUPP;
+		err = -EOPNOTSUPP;
 		goto out;
 	}
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c
index d55e15c1f380..304912637c35 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/vxlan.c
@@ -149,7 +149,7 @@ struct mlx5_vxlan *mlx5_vxlan_create(struct mlx5_core_dev *mdev)
 	struct mlx5_vxlan *vxlan;
 
 	if (!MLX5_CAP_ETH(mdev, tunnel_stateless_vxlan) || !mlx5_core_is_pf(mdev))
-		return ERR_PTR(-ENOTSUPP);
+		return ERR_PTR(-EOPNOTSUPP);
 
 	vxlan = kzalloc(sizeof(*vxlan), GFP_KERNEL);
 	if (!vxlan)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
index 65740bb68b09..e8c67ed9f748 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_domain.c
@@ -410,7 +410,7 @@ static int dr_domain_caps_init(struct mlx5_core_dev *mdev,
 	switch (dmn->type) {
 	case MLX5DR_DOMAIN_TYPE_NIC_RX:
 		if (!DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, rx))
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		dmn->info.supp_sw_steering = true;
 		dmn->info.rx.type = DR_DOMAIN_NIC_TYPE_RX;
@@ -419,7 +419,7 @@ static int dr_domain_caps_init(struct mlx5_core_dev *mdev,
 		break;
 	case MLX5DR_DOMAIN_TYPE_NIC_TX:
 		if (!DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, tx))
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		dmn->info.supp_sw_steering = true;
 		dmn->info.tx.type = DR_DOMAIN_NIC_TYPE_TX;
@@ -428,10 +428,10 @@ static int dr_domain_caps_init(struct mlx5_core_dev *mdev,
 		break;
 	case MLX5DR_DOMAIN_TYPE_FDB:
 		if (!dmn->info.caps.eswitch_manager)
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		if (!DR_DOMAIN_SW_STEERING_SUPPORTED(dmn, fdb))
-			return -ENOTSUPP;
+			return -EOPNOTSUPP;
 
 		dmn->info.rx.type = DR_DOMAIN_NIC_TYPE_RX;
 		dmn->info.tx.type = DR_DOMAIN_NIC_TYPE_TX;
-- 
2.31.1


