Return-Path: <linux-rdma+bounces-14057-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3777C0B2D8
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 21:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C57C3BD4D6
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Oct 2025 20:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77BF32FF645;
	Sun, 26 Oct 2025 20:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AvFMn5h+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010003.outbound.protection.outlook.com [52.101.56.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006292FDC3F;
	Sun, 26 Oct 2025 20:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761510072; cv=fail; b=VPFHX9KebMtNnyVPa+R5HJv1EglNq5q6EEwlLn6eJXTYecjkqSwFPAGsitatfZDA1sSNhxcRWkofs2eA2pCeYpIGT5fe/YLnanhlyYsT1TnzLZ8mfGpEoPZzZWduODnry5zMeODDcfczHwe+UoBGxHeFPEYmaJm1uGBtYRFKvkY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761510072; c=relaxed/simple;
	bh=w6jD+E9glNaCf68IY1QGBoy1nIkrh6LIGMH5f9itmoY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N3/e0vCVcxZjA2hU1SbkFg9TOS3txnlYSoBv2ovMMUPVAbgFprTMWxQ7KAIhvDRHW6FVbkp8JcWVkTD8/kHaChqdGJqEii/KiRvLZIN2cTsPAS+YjYxEcxiqsvPuHLh62poqwdIcT4aXADHcSkb19KGSRKuN9Q9L9OPVGClnNRA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AvFMn5h+; arc=fail smtp.client-ip=52.101.56.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C2YfsNCnBdkdnxdl9O4R0XjXHU/7vagw0rx09E1yCU/+ITHguTHaDUfg2z7d+vcmVRGL/fI10qzA1orGOcm7gTH1rDwT/8RXu4+Hx+u6LyAf4o3wPklLV3iKZ0xB9px5vzw3IGc5P0gOhabDefNAjqnlh1DzD6FplxLE7syRucDE2FwgCbuX1PFlRxJY7NZqFMDqavyNlf6Gtm8faucVc73gd7vtkmab5RuvzC0ev00U/5O3IboTKdUbhHvfdrJXKRVtdC5zK+8zW1DGl3k+V/QJ5yPsk1F+5X3aLum3E+ogxDAW9xg7+niVCJHCilJCxSP2LVV6ICZrTw3/qP8Svw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a77WkG2LnOwubNWFj7SJSplUu77bvpIJHLBv7hf6u60=;
 b=suk8+yiEBmvwlSbYeCIArtTJ1UVlMMLDkLf6drH2H+CmUprlYa8+WyiO1Ydd5srYo7wABfaf3zssXs8NtGtA3IOSMtMNLbkHL2orCRd1Vihn7Hpl0ABAah/UDBpKVpodTp0JtumWcqkj+2IXBoHEOlTLOLZsjrSS0jfhfYjDXj/jvSvGLCWSZiu9Bsa2snRKJmZMfviue46O7xJYR2jXTC6q0mH4OmK5R61Zj5CqWLNtGJcjqthrLe/aPDJ0hm2yErofJ21eJdkdcaKBuEtxaLQnSRIdIaCXas4dKqUfuyTshhs/WeG4ApOshBsLVCDjGgfABxRdzzXQNpcTOMQTNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a77WkG2LnOwubNWFj7SJSplUu77bvpIJHLBv7hf6u60=;
 b=AvFMn5h+oY1Nro1z70i8ny6EyWPQOwRUu9ccLHH7nKspoZCy7y6uBhf5yvDH67tlhfkAQXjlP+YCCg/ULbRzpIfEw9sJCjZD6i3v+1p+lAk6TS18+j/qi52eMrVfuAAshWkZ8YAciUYoJMx2URJeHV5VHloal6NcOBptQ847YYYD5fnxE/NsoEOSPSjVvvMzA1ImKzq9/5K/AZ6VQujA3iAZumHm6BnzHknIkgNmsx9xNe9l6U7dRmwkvIepiOkeDiVHPLepfQSDMzDozzpRfb90wwOBWiue4pQFy0CuNKqhLo0rWXSRQgR0nKw49LVK4lARxfXDDhr4JbnxCedTbA==
Received: from BYAPR05CA0063.namprd05.prod.outlook.com (2603:10b6:a03:74::40)
 by CYXPR12MB9427.namprd12.prod.outlook.com (2603:10b6:930:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.17; Sun, 26 Oct
 2025 20:21:05 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:74:cafe::80) by BYAPR05CA0063.outlook.office365.com
 (2603:10b6:a03:74::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.5 via Frontend Transport; Sun,
 26 Oct 2025 20:21:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Sun, 26 Oct 2025 20:21:04 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Sun, 26 Oct
 2025 13:20:54 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 26 Oct
 2025 13:20:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 26
 Oct 2025 13:20:50 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>
Subject: [PATCH net] net/mlx5: Don't zero user_count when destroying FDB tables
Date: Sun, 26 Oct 2025 22:20:19 +0200
Message-ID: <1761510019-938772-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|CYXPR12MB9427:EE_
X-MS-Office365-Filtering-Correlation-Id: b8023cd0-7212-407d-234c-08de14cd3095
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CY1w0LXF39cFAubzBW/6Gycy04KTlWaB+8NPuaVcTzAvDZ9l2xtvmCdlufQ7?=
 =?us-ascii?Q?Hb7iNQXm+uQCBryI6fmXAfBJBF13oRB/w0TeL4a5qXTzUf+o/LgUavO2JHE4?=
 =?us-ascii?Q?ZEzMcM4iOBqBHQXSKhBN1aEecnkZh8h1DpzO1XKHsqtqcPFJjJsh6+fUggv9?=
 =?us-ascii?Q?+SOEQ7ej7rZmcw12k4Blp4hnAnE0Hj0Mv01lGVm5MjcYUJ4YLb/6hIzuHC/v?=
 =?us-ascii?Q?Cm479OOigAszWXjlhe+0gS+GrWyDuVYZw/MmE2VZC9iIwV82NltX8l6+tts5?=
 =?us-ascii?Q?HQkzz6S3NOKwuM/581U64hERUmYCB98O+/fZgNiS+BNW4zRdeDayeY4MPXyk?=
 =?us-ascii?Q?0s1TEoT3KYx2yh6XXiET+yYWmMpWl7s/qQLbamxyAK+PYPtbvABFLpoM/do8?=
 =?us-ascii?Q?XVyGQtVZio2HX9+W3lwOMVBNFs4RD93GS86cM/ZjTTyL6ZXYm97P8/3Kd0QG?=
 =?us-ascii?Q?HA95jL6PV/WxD9QcCio5hIqyqj0HVgKjmI/ppURajav7n62LmAdngVqNuEd/?=
 =?us-ascii?Q?4cKDLx1q/m633aTV9tu53R5naULqRcP+efYsoQS/ddamiTU0Go409kHlvS4L?=
 =?us-ascii?Q?OxILEGgRhN8S8UWsagdQ9wjy+S9pANd3A6+cBUFDSpf0SrCZA3+4qf6A4y1L?=
 =?us-ascii?Q?eUTHymjnuhMUy0WxD4iAedZcbKuEKxs4PpVK4RttgSuU+VxEpJjuyjUyUs4O?=
 =?us-ascii?Q?7XAcTbLG/qUZC0Pa7JzMGPF6cznTIUlp7X2lwUk8aiDt3OW8b4yghyeU+LxG?=
 =?us-ascii?Q?2wJTcb5p5sAUVRL2HF+Y6OrvV3Abchr7yuku2ovvT7ImopK/mEVZ3tZvnjY9?=
 =?us-ascii?Q?y3zW8rnKKzeuZEQvPdQPIbyOZyX04dRgoxnVD27JNeN/QEgMmbDSDOUKeUhN?=
 =?us-ascii?Q?3bXVy4fGP8a9ZClBx8bhXYMcYn0fLlPAfnV06ePT18lUkWCLAav0+YsgsyKk?=
 =?us-ascii?Q?U0abKt0cQE+Uv3OEMYtmX/C81nkeS/XNDuGsT+9lYxHFQPlFrnXyQ5dJBBba?=
 =?us-ascii?Q?qwXM7LdC5AVOXC/ipAD63SauQYhd+CaN1rJTg+2c6Dxg23DYPQugqasHOAtn?=
 =?us-ascii?Q?irYL/ECxUBBiYA6eaMsCJnL8GQdjuVzXllhCNUqbCpSbXHtfWLYGWOsl3A1b?=
 =?us-ascii?Q?LtSH2I8u7QnWGCot5iGRYMxaPEkZKVcFhvvOPzVkjpkGe/g9lm/bIVrz2we7?=
 =?us-ascii?Q?MKPVDfQh1wlFNF4MmMad4YU89ro2DciJHQBu8gyxEsdBVLTkRMvOWcn5U2l2?=
 =?us-ascii?Q?J6CxLU3Bc6VuobO2Kz6xYpm/vgwNA+LPiIliMdCFcd9sMOp8BpkOpXXYgNGe?=
 =?us-ascii?Q?cCtABQJWrYzpih/2VY/ohBUG39hUiiEKLFc39bFbbEJxzZzO7KMNOIYF/GEj?=
 =?us-ascii?Q?LJWvHNrReRQQpUWsqjTg3I/wQluEmqONfX+goDyvhQWF2WFpC+bwfGgc46lE?=
 =?us-ascii?Q?96LcplxdVlcHl8jtTZ9F1g0FQH8BJR99chtPLugGNASSE1rScFr9KlktuTZr?=
 =?us-ascii?Q?r9uE0tvPjwaDlqdi82i2dHv2YMTcox3oXLE5yxw4PGQyNNKCHQ8S2wbDs79+?=
 =?us-ascii?Q?UOWJHAkSt23NBm5VPvs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2025 20:21:04.8678
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8023cd0-7212-407d-234c-08de14cd3095
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9427

From: Cosmin Ratiu <cratiu@nvidia.com>

esw->user_count tracks how many TC rules are added on an esw via
mlx5e_configure_flower -> mlx5_esw_get -> atomic64_inc(&esw->user_count)

esw.user_count was unconditionally set to 0 in
esw_destroy_legacy_fdb_table and esw_destroy_offloads_fdb_tables.

These two together can lead to the following sequence of events:
1. echo 1 > /sys/class/net/eth2/device/sriov_numvfs
  - mlx5_core_sriov_configure -...-> esw_create_legacy_table ->
    atomic64_set(&esw->user_count, 0)
2. tc qdisc add dev eth2 ingress && \
   tc filter replace dev eth2 pref 1 protocol ip chain 0 ingress \
       handle 1 flower action ct nat zone 64000 pipe
  - mlx5e_configure_flower -> mlx5_esw_get ->
    atomic64_inc(&esw->user_count)
3. echo 0 > /sys/class/net/eth2/device/sriov_numvfs
  - mlx5_core_sriov_configure -..-> esw_destroy_legacy_fdb_table
    -> atomic64_set(&esw->user_count, 0)
4. devlink dev eswitch set pci/0000:08:00.0 mode switchdev
  - mlx5_devlink_eswitch_mode_set -> mlx5_esw_try_lock ->
    atomic64_read(&esw->user_count) == 0
  - then proceed to a WARN_ON in:
  esw_offloads_start -> mlx5_eswitch_enable_locke -> esw_offloads_enable
  -> mlx5_esw_offloads_rep_load -> mlx5e_vport_rep_load ->
  mlx5e_netdev_change_profile -> mlx5e_detach_netdev ->
  mlx5e_cleanup_nic_rx -> mlx5e_tc_nic_cleanup ->
  mlx5e_mod_hdr_tbl_destroy

Fix this by not clearing out the user_count when destroying FDB tables,
so that the check in mlx5_esw_try_lock can prevent the mode change when
there are TC rules configured, as originally intended.

Fixes: 2318b8bb94a3 ("net/mlx5: E-switch, Destroy legacy fdb table when needed")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c       | 1 -
 drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
index 76382626ad41..929adeb50a98 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/legacy.c
@@ -66,7 +66,6 @@ static void esw_destroy_legacy_fdb_table(struct mlx5_eswitch *esw)
 	esw->fdb_table.legacy.addr_grp = NULL;
 	esw->fdb_table.legacy.allmulti_grp = NULL;
 	esw->fdb_table.legacy.promisc_grp = NULL;
-	atomic64_set(&esw->user_count, 0);
 }
 
 static int esw_create_legacy_fdb_table(struct mlx5_eswitch *esw)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index 34749814f19b..44a142a041b2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1978,7 +1978,6 @@ static void esw_destroy_offloads_fdb_tables(struct mlx5_eswitch *esw)
 	/* Holds true only as long as DMFS is the default */
 	mlx5_flow_namespace_set_mode(esw->fdb_table.offloads.ns,
 				     MLX5_FLOW_STEERING_MODE_DMFS);
-	atomic64_set(&esw->user_count, 0);
 }
 
 static int esw_get_nr_ft_offloads_steering_src_ports(struct mlx5_eswitch *esw)

base-commit: 84a905290cb4c3d9a71a9e3b2f2e02e031e7512f
-- 
2.31.1


