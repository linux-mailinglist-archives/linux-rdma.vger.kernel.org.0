Return-Path: <linux-rdma+bounces-8516-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FDEA586D6
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 19:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCA97168F80
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 18:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05E41FC7D9;
	Sun,  9 Mar 2025 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NislXyOF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2057.outbound.protection.outlook.com [40.107.95.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC251F8756;
	Sun,  9 Mar 2025 18:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543709; cv=fail; b=N9Ql8P3R5hNxv3MpSK1oefGcRiHFL9iv+of4aRHuLYaogDj1TSjvg4JjRPXivRQVzw87PNlwPhv38WPaE8066UuFpAm/4C3Uu8jDdTHl7+hURdGyNcmTmpRkf6vRqEDWpUPEsTXovPrVBGrkEM8LQXrHU8o9AIYu1VDlfxAnOHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543709; c=relaxed/simple;
	bh=OWSJPCu21S97qSY3hDsXeodFo78Qc21ywiHnXD/nfuA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PiiI2CRROmhzzPhmlYuLfPf1Bw0J4CW1MkpNaGFBSVsce022xqH8OVAmoY5JlAYbF3JET5Uzac6eYAE0BasJNg7Bj5G0mu4jAvVK6sSez5+DZDmDJnUzHAx2g9MOyMdRkj7Jv8Tog18fNjmm+F3p9ZBA9U9e6TKUZqwk9oxfeZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NislXyOF; arc=fail smtp.client-ip=40.107.95.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NL8q+e7n23Q1ipl/M7NSxQnV4IVg0bhWGcA64nqywa558afh9huWlN/gxUMwymv9+nKzrPNP7gHt2nPm4Z7gMzIVixCJ6cR0VXn1SzLx6O7nix5RMPwppdHJzE4VaDW5JU0oWt1tRpQfnWnB6n/DNvWennrRMkIHMEUt3rMtL2GkNX3tCOeO0Rb9aTF5QHKgbeUmSCWRP2Obc/Tq/hsAknzo0Uv7TtZ+LRpkkGCGtHQyfnS3nNRPkXf1QRk1NgecRZPT+gttLM2Serb824pS7/mTy3RIPM5Ex8U5VXd/kUhOP2nM3cbO+Hv7N92/dOVzoBP0cA8YSPCILWiVle2Ktw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PgqpwvJAu+LG3GHZNrR3h+AKWb7AKebmCyPcEHLXtSQ=;
 b=EIx9dsW9hShLEun0Cqdhfz+ulU5rFA2JIdNiW1be/F3sQcRdWnj8FSkL07ejxSpa7F88V0CShlGnfxACLbyHzdvaJXFKoTdnvpLCLxQzcyWCXABZXhSuQP1QPWAzC+cP7Eqb5jsW7gAY8wJ+xg5qmUZbumxNy/o7kVoXzjoVdGueYP+SB0kAS8IYE+2gh19499Zi8Y4EpdNEwg3sxAxY+EKmljAgcLa29ykVi/zbSYQjO3KRBoaqGOkbCiZrhlWzrgomRz6MuU/t+zPQZ8V0TXzJIqWFNpmMdQto0hS0PfYryY2LXA98ZHc6k3Al5DhDLN+aqlMMe8A2dSKmqXn5jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PgqpwvJAu+LG3GHZNrR3h+AKWb7AKebmCyPcEHLXtSQ=;
 b=NislXyOF70/AR2u2eauVAzl8Hk7yzAUNSQ9sPXRof5GzsTVSHV0kaXZHUmeIsUaIcu4nfUpVf3EQONdEnyV2O8HfJH7SippK4LC5GP1GeBaXTrXxBu4IIXClEmcw9kBxB4INoMSbJvZl37vAuvMDKIpcnbxKdx7VZLT/VMmfqC2Hm56AoKAIh1LFg1z7+2wxLjCaSfIDAW80Z72pGDGxo7b7WZzuZHsc4crx7ybRChgCe+fvdfWb8csjEpUoKfKhDEizM9Hsw2yu7RIyYwVnjgujrwa23F47EPOL5XlSsLjNHEMDpVCEGm4hPlVEHZFzhvouqKkOe+Y1Zwa0q/gb+w==
Received: from BLAPR05CA0006.namprd05.prod.outlook.com (2603:10b6:208:36e::9)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 18:08:21 +0000
Received: from BL6PEPF0001AB57.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::26) by BLAPR05CA0006.outlook.office365.com
 (2603:10b6:208:36e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.17 via Frontend Transport; Sun,
 9 Mar 2025 18:08:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF0001AB57.mail.protection.outlook.com (10.167.241.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Sun, 9 Mar 2025 18:08:20 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Mar 2025
 11:08:16 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Mar 2025 11:08:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Mar 2025 11:08:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 2/3] net/mlx5: fs, add support for flow meters HWS action
Date: Sun, 9 Mar 2025 20:07:42 +0200
Message-ID: <1741543663-22123-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
References: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB57:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 0de5bc7f-9903-4e4d-8934-08dd5f356020
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0724JHepZ9GTGTt5SbEdpbScoty9ve1XgywEv+5+2mrnKgvK4KzqYCFjxW84?=
 =?us-ascii?Q?v8Zv7TeNprXFwdC2GxwiDvmIRMzb6IigiE+8seMOOeAduVQfr1ePtum+az2P?=
 =?us-ascii?Q?rBpoSocs7vFVN6eZjrroGH9OLoZnm+NLRvxr1y+hNDZ4rn07Zw5VvujxZ0l2?=
 =?us-ascii?Q?LSA99AzZUHH2VZyJM13LbS1z8gD0SchU35jvumi5uWCFbfBrVNazfNR8Ondw?=
 =?us-ascii?Q?RDuxVuWPsQc69XnAWMoeFicIHNVpNdnLu4Fgo93YzXCxc1ZdN/k46AmmS3fV?=
 =?us-ascii?Q?YjGuGTEw1XpPLPCB3IkUR5zcnEFV1yQR/TLAeW9lYrgWtyC6nacqPcSzoIuW?=
 =?us-ascii?Q?FNqA5Xj4qgHz6vYdgPFA+rYOWjooLwZ9z8i5/zQKGR0dh+WFz4uvBnC/gnKj?=
 =?us-ascii?Q?Nly/Arn1aW/99uUmO9CEEEZRpC5jM/OyAmDW67/PynfQcwMFEUDublBgnvz8?=
 =?us-ascii?Q?wgBTOQuE5lpzVIlRlKom33s2QQb2b2WS7lA6ivmcfa1jpIC32ZApAqU/SM3v?=
 =?us-ascii?Q?3YlTbW8RjllbWjTSyJ+DEY9vSHAlNUIQQFpgmW97xI4bueNcJ04MiIaTGwxT?=
 =?us-ascii?Q?3rXNeX8SBObxObI6OX61FtX9DAc0Ix7G1dZlvx6mcISeKbV/nYPVSEMOaHoV?=
 =?us-ascii?Q?m9tpFD+qymtL4jk/B+iSS1bFInwYaE7UOyUMNEOmNj7k/n6sWai9gH6ObDBd?=
 =?us-ascii?Q?gD1nlJr4rrvrmipFaHsGEw5TQTQnTTUnRiaQFF6CGcC3EU9ReF3hZMDVbnR3?=
 =?us-ascii?Q?6rBVyD26RObQqpsoWN9o40q7hFXqn3FgWAZwSg8LiA+P0PFgYBjAwlTw+FDP?=
 =?us-ascii?Q?MdZSs/AHYmN+Sb5ZcSy0QOYtWx2bNaet6HRGXURtrnJT5z5MvTewRPzr/uBO?=
 =?us-ascii?Q?5+78LmXGwuuwh9u6v64Mfw/WM4beWdLWdVKbtq5yzITh5fKjb88bk4c/yS+Q?=
 =?us-ascii?Q?H+ScSB0/AG4vRR5AApRl3PNi55t93OuPMPXSKX2hMeQM8HTEfEvYbIMKhcPJ?=
 =?us-ascii?Q?IfJDMNPNcRSxzZX/r5j+RSaRC6Qy/1icvgp8md3tbLpdi2lkfTsGTKmfncjo?=
 =?us-ascii?Q?HSU6EhxX1D7ei/LHvmBs/067CDlXNSE627goTExbnNAbEP15Jgdx7a0JYld1?=
 =?us-ascii?Q?jC6mAR/Q+uoSKKQ0UsKkIEFpe7s8mLwQu6fqBlFo8TTBsTC4SwzZmI/azccE?=
 =?us-ascii?Q?nxqVieSNl21DfLdnVLrx28gan0segsQURNkeDiL//AEcXrdivDUyaOZavl6D?=
 =?us-ascii?Q?sazK3karRZxIP5vukjURe/iAGFgfZXmBDdoO7ucouVS7nMARYFJ2FhrN7lIg?=
 =?us-ascii?Q?jQC2w+E5n2e2I3H5W+gBStsZX8+lToGAGKUUwL63qZlStyxgXjT/vEVoqLKi?=
 =?us-ascii?Q?XGYQ983HOtQIXSK8j0wjT+xB9PmiwZXvM1zljW6ioL/8mDXnpSNtA1WA6QqL?=
 =?us-ascii?Q?DXJFSMzxfYdjApKwuGJ8YJTyUSaU99eCFjQHNhg0fdpKspvzuMJcHAsQKKu/?=
 =?us-ascii?Q?TfsUHzQXCH1YkzY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 18:08:20.5253
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de5bc7f-9903-4e4d-8934-08dd5f356020
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB57.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364

From: Moshe Shemesh <moshe@nvidia.com>

Add support for HW Steering action of flow meter range. Flow meters
range can use one HWS action for the whole range. Thus, share a cached
HWS action among rules that use same flow meter object range. Hold
refcount for each rule using the cached action.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en/tc/meter.c |   5 +
 .../ethernet/mellanox/mlx5/core/en/tc/meter.h |  13 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     |   1 +
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 120 ++++++++++++++++--
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  |   5 +
 include/linux/mlx5/fs.h                       |   1 +
 6 files changed, 135 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
index 8218c892b161..7819fb297280 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.c
@@ -593,3 +593,8 @@ mlx5e_tc_meter_get_stats(struct mlx5e_flow_meter_handle *meter,
 	*drops = packets2;
 	*lastuse = max_t(u64, lastuse1, lastuse2);
 }
+
+int mlx5e_flow_meter_get_base_id(struct mlx5e_flow_meter_handle *meter)
+{
+	return meter->meters_obj->base_id;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.h
index 9b795cd106bb..d6afb6556875 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc/meter.h
@@ -72,4 +72,17 @@ void
 mlx5e_tc_meter_get_stats(struct mlx5e_flow_meter_handle *meter,
 			 u64 *bytes, u64 *packets, u64 *drops, u64 *lastuse);
 
+#if IS_ENABLED(CONFIG_MLX5_CLS_ACT)
+
+int mlx5e_flow_meter_get_base_id(struct mlx5e_flow_meter_handle *meter);
+
+#else /* CONFIG_MLX5_CLS_ACT */
+
+static inline int
+mlx5e_flow_meter_get_base_id(struct mlx5e_flow_meter_handle *meter)
+{
+	return 0;
+}
+#endif /* CONFIG_MLX5_CLS_ACT */
+
 #endif /* __MLX5_EN_FLOW_METER_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 0fa0333106a2..967175cd7ca0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -648,6 +648,7 @@ esw_setup_meter(struct mlx5_flow_attr *attr, struct mlx5_flow_act *flow_act)
 	meter = attr->meter_attr.meter;
 	flow_act->exe_aso.type = attr->exe_aso_type;
 	flow_act->exe_aso.object_id = meter->obj_id;
+	flow_act->exe_aso.base_id = mlx5e_flow_meter_get_base_id(meter);
 	flow_act->exe_aso.flow_meter.meter_idx = meter->idx;
 	flow_act->exe_aso.flow_meter.init_color = MLX5_FLOW_METER_COLOR_GREEN;
 	/* use metadata reg 5 for packet color */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index 50e43d574e0a..edf7db1e6e9c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -66,6 +66,7 @@ static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 	xa_init(&hws_pool->table_dests);
 	xa_init(&hws_pool->vport_dests);
 	xa_init(&hws_pool->vport_vhca_dests);
+	xa_init(&hws_pool->aso_meters);
 	return 0;
 
 cleanup_insert_hdr:
@@ -88,10 +89,14 @@ static int mlx5_fs_init_hws_actions_pool(struct mlx5_core_dev *dev,
 static void mlx5_fs_cleanup_hws_actions_pool(struct mlx5_fs_hws_context *fs_ctx)
 {
 	struct mlx5_fs_hws_actions_pool *hws_pool = &fs_ctx->hws_pool;
+	struct mlx5_fs_hws_data *fs_hws_data;
 	struct mlx5hws_action *action;
 	struct mlx5_fs_pool *pool;
 	unsigned long i;
 
+	xa_for_each(&hws_pool->aso_meters, i, fs_hws_data)
+		kfree(fs_hws_data);
+	xa_destroy(&hws_pool->aso_meters);
 	xa_for_each(&hws_pool->vport_vhca_dests, i, action)
 		mlx5hws_action_destroy(action);
 	xa_destroy(&hws_pool->vport_vhca_dests);
@@ -459,6 +464,70 @@ mlx5_fs_create_dest_action_range(struct mlx5hws_context *ctx,
 						      flags);
 }
 
+static struct mlx5_fs_hws_data *
+mlx5_fs_get_cached_hws_data(struct xarray *cache_xa, unsigned long index)
+{
+	struct mlx5_fs_hws_data *fs_hws_data;
+	int err;
+
+	xa_lock(cache_xa);
+	fs_hws_data = xa_load(cache_xa, index);
+	if (!fs_hws_data) {
+		fs_hws_data = kzalloc(sizeof(*fs_hws_data), GFP_ATOMIC);
+		if (!fs_hws_data) {
+			xa_unlock(cache_xa);
+			return NULL;
+		}
+		refcount_set(&fs_hws_data->hws_action_refcount, 0);
+		mutex_init(&fs_hws_data->lock);
+		err = __xa_insert(cache_xa, index, fs_hws_data, GFP_ATOMIC);
+		if (err) {
+			kfree(fs_hws_data);
+			xa_unlock(cache_xa);
+			return NULL;
+		}
+	}
+	xa_unlock(cache_xa);
+
+	return fs_hws_data;
+}
+
+static struct mlx5hws_action *
+mlx5_fs_get_action_aso_meter(struct mlx5_fs_hws_context *fs_ctx,
+			     struct mlx5_exe_aso *exe_aso)
+{
+	struct mlx5_fs_hws_create_action_ctx create_ctx;
+	struct mlx5hws_context *ctx = fs_ctx->hws_ctx;
+	struct mlx5_fs_hws_data *meter_hws_data;
+	u32 id = exe_aso->base_id;
+	struct xarray *meters_xa;
+
+	meters_xa = &fs_ctx->hws_pool.aso_meters;
+	meter_hws_data = mlx5_fs_get_cached_hws_data(meters_xa, id);
+	if (!meter_hws_data)
+		return NULL;
+
+	create_ctx.hws_ctx = ctx;
+	create_ctx.actions_type = MLX5HWS_ACTION_TYP_ASO_METER;
+	create_ctx.id = id;
+	create_ctx.return_reg_id = exe_aso->return_reg_id;
+
+	return mlx5_fs_get_hws_action(meter_hws_data, &create_ctx);
+}
+
+static void mlx5_fs_put_action_aso_meter(struct mlx5_fs_hws_context *fs_ctx,
+					 struct mlx5_exe_aso *exe_aso)
+{
+	struct mlx5_fs_hws_data *meter_hws_data;
+	struct xarray *meters_xa;
+
+	meters_xa = &fs_ctx->hws_pool.aso_meters;
+	meter_hws_data = xa_load(meters_xa, exe_aso->base_id);
+	if (!meter_hws_data)
+		return;
+	return mlx5_fs_put_hws_action(meter_hws_data);
+}
+
 static struct mlx5hws_action *
 mlx5_fs_create_action_dest_array(struct mlx5hws_context *ctx,
 				 struct mlx5hws_action_dest_attr *dests,
@@ -528,6 +597,11 @@ mlx5_fs_create_hws_action(struct mlx5_fs_hws_create_action_ctx *create_ctx)
 	case MLX5HWS_ACTION_TYP_CTR:
 		return mlx5hws_action_create_counter(create_ctx->hws_ctx,
 						     create_ctx->id, flags);
+	case MLX5HWS_ACTION_TYP_ASO_METER:
+		return mlx5hws_action_create_aso_meter(create_ctx->hws_ctx,
+						       create_ctx->id,
+						       create_ctx->return_reg_id,
+						       flags);
 	default:
 		return NULL;
 	}
@@ -576,26 +650,33 @@ void mlx5_fs_put_hws_action(struct mlx5_fs_hws_data *fs_hws_data)
 	mutex_unlock(&fs_hws_data->lock);
 }
 
-static void mlx5_fs_destroy_fs_action(struct mlx5_fs_hws_rule_action *fs_action)
+static void mlx5_fs_destroy_fs_action(struct mlx5_flow_root_namespace *ns,
+				      struct mlx5_fs_hws_rule_action *fs_action)
 {
+	struct mlx5_fs_hws_context *fs_ctx = &ns->fs_hws_context;
+
 	switch (mlx5hws_action_get_type(fs_action->action)) {
 	case MLX5HWS_ACTION_TYP_CTR:
 		mlx5_fc_put_hws_action(fs_action->counter);
 		break;
+	case MLX5HWS_ACTION_TYP_ASO_METER:
+		mlx5_fs_put_action_aso_meter(fs_ctx, fs_action->exe_aso);
+		break;
 	default:
 		mlx5hws_action_destroy(fs_action->action);
 	}
 }
 
 static void
-mlx5_fs_destroy_fs_actions(struct mlx5_fs_hws_rule_action **fs_actions,
+mlx5_fs_destroy_fs_actions(struct mlx5_flow_root_namespace *ns,
+			   struct mlx5_fs_hws_rule_action **fs_actions,
 			   int *num_fs_actions)
 {
 	int i;
 
 	/* Free in reverse order to handle action dependencies */
 	for (i = *num_fs_actions - 1; i >= 0; i--)
-		mlx5_fs_destroy_fs_action(*fs_actions + i);
+		mlx5_fs_destroy_fs_action(ns, *fs_actions + i);
 	*num_fs_actions = 0;
 	kfree(*fs_actions);
 	*fs_actions = NULL;
@@ -792,8 +873,25 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 	}
 
 	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_EXECUTE_ASO) {
-		err = -EOPNOTSUPP;
-		goto free_actions;
+		if (fte_action->exe_aso.type != MLX5_EXE_ASO_FLOW_METER ||
+		    num_actions == MLX5_FLOW_CONTEXT_ACTION_MAX) {
+			err = -EOPNOTSUPP;
+			goto free_actions;
+		}
+
+		tmp_action = mlx5_fs_get_action_aso_meter(fs_ctx,
+							  &fte_action->exe_aso);
+		if (!tmp_action) {
+			err = -ENOMEM;
+			goto free_actions;
+		}
+		(*ractions)[num_actions].aso_meter.offset =
+			fte_action->exe_aso.flow_meter.meter_idx;
+		(*ractions)[num_actions].aso_meter.init_color =
+			fte_action->exe_aso.flow_meter.init_color;
+		(*ractions)[num_actions++].action = tmp_action;
+		fs_actions[num_fs_actions].action = tmp_action;
+		fs_actions[num_fs_actions++].exe_aso = &fte_action->exe_aso;
 	}
 
 	if (fte_action->action & MLX5_FLOW_CONTEXT_ACTION_DROP) {
@@ -907,7 +1005,7 @@ static int mlx5_fs_fte_get_hws_actions(struct mlx5_flow_root_namespace *ns,
 	return 0;
 
 free_actions:
-	mlx5_fs_destroy_fs_actions(&fs_actions, &num_fs_actions);
+	mlx5_fs_destroy_fs_actions(ns, &fs_actions, &num_fs_actions);
 free_dest_actions_alloc:
 	kfree(dest_actions);
 free_fs_actions_alloc:
@@ -957,7 +1055,7 @@ static int mlx5_cmd_hws_create_fte(struct mlx5_flow_root_namespace *ns,
 	return 0;
 
 free_actions:
-	mlx5_fs_destroy_fs_actions(&fte->fs_hws_rule.hws_fs_actions,
+	mlx5_fs_destroy_fs_actions(ns, &fte->fs_hws_rule.hws_fs_actions,
 				   &fte->fs_hws_rule.num_fs_actions);
 out_err:
 	mlx5_core_err(ns->dev, "Failed to create hws rule err(%d)\n", err);
@@ -977,7 +1075,8 @@ static int mlx5_cmd_hws_delete_fte(struct mlx5_flow_root_namespace *ns,
 	err = mlx5hws_bwc_rule_destroy(rule->bwc_rule);
 	rule->bwc_rule = NULL;
 
-	mlx5_fs_destroy_fs_actions(&rule->hws_fs_actions, &rule->num_fs_actions);
+	mlx5_fs_destroy_fs_actions(ns, &rule->hws_fs_actions,
+				   &rule->num_fs_actions);
 
 	return err;
 }
@@ -1015,11 +1114,12 @@ static int mlx5_cmd_hws_update_fte(struct mlx5_flow_root_namespace *ns,
 	if (ret)
 		goto restore_actions;
 
-	mlx5_fs_destroy_fs_actions(&saved_hws_fs_actions, &saved_num_fs_actions);
+	mlx5_fs_destroy_fs_actions(ns, &saved_hws_fs_actions,
+				   &saved_num_fs_actions);
 	return ret;
 
 restore_actions:
-	mlx5_fs_destroy_fs_actions(&fte->fs_hws_rule.hws_fs_actions,
+	mlx5_fs_destroy_fs_actions(ns, &fte->fs_hws_rule.hws_fs_actions,
 				   &fte->fs_hws_rule.num_fs_actions);
 	fte->fs_hws_rule.hws_fs_actions = saved_hws_fs_actions;
 	fte->fs_hws_rule.num_fs_actions = saved_num_fs_actions;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index 1c4b853cf88d..6970b1aa9540 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -22,6 +22,7 @@ struct mlx5_fs_hws_actions_pool {
 	struct xarray table_dests;
 	struct xarray vport_vhca_dests;
 	struct xarray vport_dests;
+	struct xarray aso_meters;
 };
 
 struct mlx5_fs_hws_context {
@@ -49,6 +50,7 @@ struct mlx5_fs_hws_rule_action {
 	struct mlx5hws_action *action;
 	union {
 		struct mlx5_fc *counter;
+		struct mlx5_exe_aso *exe_aso;
 	};
 };
 
@@ -68,6 +70,9 @@ struct mlx5_fs_hws_create_action_ctx {
 	enum mlx5hws_action_type actions_type;
 	struct mlx5hws_context *hws_ctx;
 	u32 id;
+	union {
+		u8 return_reg_id;
+	};
 };
 
 struct mlx5hws_action *
diff --git a/include/linux/mlx5/fs.h b/include/linux/mlx5/fs.h
index 01cb72d68c23..5da734a526a0 100644
--- a/include/linux/mlx5/fs.h
+++ b/include/linux/mlx5/fs.h
@@ -240,6 +240,7 @@ void mlx5_destroy_flow_group(struct mlx5_flow_group *fg);
 
 struct mlx5_exe_aso {
 	u32 object_id;
+	int base_id;
 	u8 type;
 	u8 return_reg_id;
 	union {
-- 
2.45.0


