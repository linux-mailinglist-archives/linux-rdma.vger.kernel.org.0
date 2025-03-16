Return-Path: <linux-rdma+bounces-8731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C27BA634AD
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 09:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5A3189332D
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 08:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DEC19C575;
	Sun, 16 Mar 2025 08:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tf+vJ8sD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E26319CC39;
	Sun, 16 Mar 2025 08:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742112927; cv=fail; b=Y4zratC6B0TPWoAGs/QmVaXpuB/FznunsRbP6mHJrPbWemV5djqJD9DmmjzltdBlGL5uPco7fq3MZZqmfkgKLssExFYtIPdQEeVe7sJhk0PfjrZMSUKs5sK3VRIckb8wsd4cNSWkeviTofG0pknubYn+Vac0Fv/AYCTCPvXfTXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742112927; c=relaxed/simple;
	bh=ry9SUCQ8T7WxUGMZyVngvXoYI6dXEbyJaKpeWh6NPAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C86ZUgcvAtNHDa3aUiyMwF4dHT9N+tWctH8k28vkOEW2TsMvRojB620+ZZrKU/p3wnGkQKMRozPHCJWMvjvhJza0WiQMrcfBpLhkHbYnrfmr0ycTbPVmYyGysbO5wGbYetdAliR2RdHce46OYLsBFuiwuBXArg6dEsdMm8a75rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tf+vJ8sD; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOE/vWKbVoYnLcSyzvSy0v9Ogaud+ZFjfxlJuKw5nOmquSx2Mjq0sOTiT3osN/fJLSgMZE/uqNaNSuwaT19bfiQVObnls27NXIpntwW2Dvm626cBOkAMlx8v8ecnWleDmkpj/Jrx6dNeN50Egf2354YsJ223c9Ge277dAzzcVbb3rRPfuIzU/gXGNoN5dVA6HsI7bZD66Y96CcUTEaVv5pUo/ZSPFdhINh/sWYsdhKhxlAW42rsfuN1TnV+/0ZYR0MrmQnenPq8xk3MON4jLMcGld7fMT7Q53QmKSSGEHQ2t/0cRwrGzim+23cuv6cphnnT4iUQ5oEu1+8gibPYVVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1YUG2VVA1Gh397RPt/0oh8RJPgraXmZ6yai6FXubgFU=;
 b=MVW+xQBmHPHo7xH9SF1cDzbEZPiHrEltbuoTv0bK27vkMR5ar0bAsK3cQnS7yK6ZxQyD38AydQaKwsuDQgrLEuDsZlpD+oqZO/T7tH+l3pIW2pAzFIktqL25KIzGlbiAm7vsRTbC1A/U4eu0BXePwE86z/FG4jda84vhLsMXmwV90gna2Ncg59C6fqme+FBAGRxO5iQqLJXYx4iQ99idZO/JkxC0ay5snmVb/ey6A6Fw1HDt5GznAgmolfmp4OqlIO9yVjdcil9vfISSqkqMuSFMnr2uujBJF9IF4lheWfBrDag2tCwy4AIoR2INfvTaA6+P2uQvOuYlNxyDxnoJCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1YUG2VVA1Gh397RPt/0oh8RJPgraXmZ6yai6FXubgFU=;
 b=tf+vJ8sDFGOxaC8d0gSMxMK57J1mRrqtFVpE5a1BltGV8U3wC5sgoMLteSMOz/zizfjKhGjiBlS2IHz8WOuKmBOXfaa/Ly/QjkzU4SPIf/xO78Rbog73HoIV0VZ1JUXgw3899uHgM2gn6/P7zaDE9WrhZc9VcoMxMftAeRk1iQay/VwtgT09S9OMM5gudxni6FWiPUigGtlJRn6Wh2s8LqSzXZWDMFS/MXoaDyEMPzcWQ1wry3X17qkxSYz+03I7o/NF4VFVS6vkbJ0ZS6oX7rxW2BTS4lV9uEeeOdmVmc5LZz/iwpDol2TTM5hnKKU4yIy0MmTNCZhTqYO6mv+TaQ==
Received: from BL0PR0102CA0040.prod.exchangelabs.com (2603:10b6:208:25::17) by
 SA3PR12MB7974.namprd12.prod.outlook.com (2603:10b6:806:307::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 08:15:20 +0000
Received: from BN1PEPF00004685.namprd03.prod.outlook.com
 (2603:10b6:208:25:cafe::c1) by BL0PR0102CA0040.outlook.office365.com
 (2603:10b6:208:25::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.28 via Frontend Transport; Sun,
 16 Mar 2025 08:15:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004685.mail.protection.outlook.com (10.167.243.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 08:15:19 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Mar
 2025 01:15:06 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Mar 2025 01:15:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 16 Mar 2025 01:15:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Yael
 Chemla" <ychemla@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kalesh Anakkur Purayil
	<kalesh-anakkur.purayil@broadcom.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net-next V2 4/4] net/mlx5e: Expose port reset cycle recovery counter via ethtool
Date: Sun, 16 Mar 2025 10:14:36 +0200
Message-ID: <1742112876-2890-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
References: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004685:EE_|SA3PR12MB7974:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d53355e-b07d-49b3-f47e-08dd6462b10a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xVmNA51KZfBIPyl99NdsyjN7/M/fNCzQ8iZFtgUXQbGLg17wOy79q3pd9EVC?=
 =?us-ascii?Q?WsNoCuuODx44zibabyAXE1PZ1d2YYywpYRfpvVr6N+KpkU9XouJ1ZR8t/uv6?=
 =?us-ascii?Q?wzxH+NFbnckvoqbSqBq99zP3gJpA5lgkvzZmaxy9J6lTmt38pMzCyfXhRzYe?=
 =?us-ascii?Q?Naq4gitwXfiXyU1aDHNZpO6zFpcXqPqc4NPNKRwnntyrICydCZMKLRO1dItl?=
 =?us-ascii?Q?0pgt9FRjQXMGnM/4XGJhVRxdL85aBWheqtbYO3IGjdxtMe3Gl9Cty6tCpb84?=
 =?us-ascii?Q?mA3J4esMmLHX+jN6H+IpjkFaHBEPQ3zetAaCY4Q9EeA3e86sYH0ScRCxOSoq?=
 =?us-ascii?Q?58ymsD1kB0BEuoPZmSzYdx87KNu5ygJrSd/Tg4qSwukpkareXZRYf3j2/sgF?=
 =?us-ascii?Q?a83JNpiLtpRs0IV/QgCEyCM7Ce02c0X4ZZ9Ujs/QCDiKo8aedrbDAkk1l7AU?=
 =?us-ascii?Q?CXmXMuZfGfVFU0NxBqGAlbZ62F+QWVFHQqHww5qLXMsC7ImPqO78fAHTVosh?=
 =?us-ascii?Q?C1FBDfizQMpPA1sBIS+x2vdkzri2gUPHKuJGVlvunJ6TvROypUwFtM2BlpTo?=
 =?us-ascii?Q?bnePjgquU2s4Fjc8IvDrXBDnyM2DYMa0ZWRWw11W+1sJIeoMcPtsskyV+kzE?=
 =?us-ascii?Q?LDw/GDPkwpLr1p1VyAV3HLgSNu6ou33vLrjnp3YAcBHh4XYE935yXR1ZkRd+?=
 =?us-ascii?Q?YFRcDjENIjxNMa60imXsri/+t9fDnzhwAl4KlNmlE++Zg0KDeoxiiDqXZGtP?=
 =?us-ascii?Q?dJqM1AmENxDmOqgit56wrHbYLQmRe8znGT7lXRLfyuBlHNj/9q9NeTo03zwG?=
 =?us-ascii?Q?P/Od6yFvr6/GM5MrVgVH6KNr35dPXs4/Brjo6YL7ZNrfhF0KQf/b1DCWfRYN?=
 =?us-ascii?Q?kEz9aH8oFrRwRNCrUUdRxgCzJ/2nU5guPEhYezTzrTyylZ4UDMu3RflMIcd1?=
 =?us-ascii?Q?9P7X54B+Ln+3igi8TuIlEkcZlRECP+6CUtRe1/ypOiMylKLirAykkh5fk9kh?=
 =?us-ascii?Q?e8h963NVVImIEp0WJgJGnPZBp3bM/PYpJPpdD4oXN/qPvIhQ/oAMRa3XVAi8?=
 =?us-ascii?Q?Tx1mJdpSdKMQk4FlGAaxB9f07wvC/5vu2TVHlLeev6B5sKC+1TCFo6J5QxS/?=
 =?us-ascii?Q?4T7DD5E/+JL+XuayUHUjBUqEEBJwYLiqHJp9CEvOFNnV1M6finzo+I/DDiU7?=
 =?us-ascii?Q?5GOaHctarE8xl9mPkNIpeLtBny1CpAd1rDKli1lHaXswmbGaJ/tQdEtrhpUN?=
 =?us-ascii?Q?RGxXo8xXkBdV/BsdwmG32h9ehLQqFDmtdCpSQC7SP98TgIs5NQi9Uc0l5HtY?=
 =?us-ascii?Q?RlXtHLwmVdh4ntKwCMIn3teB21/IUj4K8kN7OHuxHRo651z7ky6RYuF79VsK?=
 =?us-ascii?Q?8CGQA364AvsCtiXozp4z5jaij0CUbcsGQNpNmKGsogdmbp1n8tXg6vv3cCYU?=
 =?us-ascii?Q?FABefGVS7tSUtkxkv+hKenYf7cnCUrqNiVTJLnJ5XisarZl5ZN8uyNUdogY5?=
 =?us-ascii?Q?DNEXkclwhanthVY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 08:15:19.4304
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d53355e-b07d-49b3-f47e-08dd6462b10a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004685.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7974

From: Yael Chemla <ychemla@nvidia.com>

Display recovery event of PPCNT recovery counters group. Counts (per
link) the number of total successful recovery events of any recovery
types during port reset cycle.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../ethernet/mellanox/mlx5/counters.rst       |  5 +++
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 44 ++++++++++++++++---
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  4 ++
 3 files changed, 48 insertions(+), 5 deletions(-)

diff --git a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
index 99d95be4d159..43d72c8b713b 100644
--- a/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
+++ b/Documentation/networking/device_drivers/ethernet/mellanox/mlx5/counters.rst
@@ -1082,6 +1082,11 @@ like flow control, FEC and more.
        need to replace the cable/transceiver.
      - Error
 
+   * - `total_success_recovery_phy`
+     - The number of total successful recovery events of any type during
+       ports reset cycle.
+     - Error
+
    * - `rx_out_of_buffer`
      - Number of times receive queue had no software buffers allocated for the
        adapter's incoming traffic.
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index a417962acfa9..acb00fd7efa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1250,12 +1250,22 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 	{ "rx_err_lane_3_phy", PPORT_PHY_STATISTICAL_OFF(phy_corrected_bits_lane3) },
 };
 
+#define PPORT_PHY_RECOVERY_OFF(c) \
+	MLX5_BYTE_OFF(ppcnt_reg, counter_set.phys_layer_recovery_cntrs.c)
+static const struct counter_desc
+pport_phy_recovery_cntrs_stats_desc[] = {
+	{ "total_success_recovery_phy",
+	  PPORT_PHY_RECOVERY_OFF(total_successful_recovery_events) }
+};
+
 #define NUM_PPORT_PHY_LAYER_COUNTERS \
 	ARRAY_SIZE(pport_phy_layer_cntrs_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_err_lanes_stats_desc)
+#define NUM_PPORT_PHY_RECOVERY_COUNTERS \
+	ARRAY_SIZE(pport_phy_recovery_cntrs_stats_desc)
 
 #define NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(dev) \
 	(MLX5_CAP_PCAM_FEATURE(dev, ppcnt_statistical_group) ? \
@@ -1263,6 +1273,9 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(dev) \
 	(MLX5_CAP_PCAM_FEATURE(dev, per_lane_error_counters) ? \
 	NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS : 0)
+#define NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(dev) \
+	(MLX5_CAP_PCAM_FEATURE(dev, ppcnt_recovery_counters) ? \
+	NUM_PPORT_PHY_RECOVERY_COUNTERS : 0)
 
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 {
@@ -1275,6 +1288,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 
 	num_stats += NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
 
+	num_stats += NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(mdev);
 	return num_stats;
 }
 
@@ -1295,6 +1309,10 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 		ethtool_puts(data,
 			     pport_phy_statistical_err_lanes_stats_desc[i]
 			     .format);
+
+	for (i = 0; i < NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(mdev); i++)
+		ethtool_puts(data,
+			     pport_phy_recovery_cntrs_stats_desc[i].format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
@@ -1324,6 +1342,13 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 			MLX5E_READ_CTR64_BE(
 				&priv->stats.pport.phy_statistical_counters,
 				pport_phy_statistical_err_lanes_stats_desc, i));
+
+	for (i = 0; i < NUM_PPORT_PHY_RECOVERY_LOOPBACK_COUNTERS(mdev); i++)
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR32_BE(
+				&priv->stats.pport.phy_recovery_counters,
+				pport_phy_recovery_cntrs_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(phy)
@@ -1339,12 +1364,21 @@ static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(phy)
 	MLX5_SET(ppcnt_reg, in, grp, MLX5_PHYSICAL_LAYER_COUNTERS_GROUP);
 	mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0, 0);
 
-	if (!MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		return;
+	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group)) {
+		out = pstats->phy_statistical_counters;
+		MLX5_SET(ppcnt_reg, in, grp,
+			 MLX5_PHYSICAL_LAYER_STATISTICAL_GROUP);
+		mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0,
+				     0);
+	}
 
-	out = pstats->phy_statistical_counters;
-	MLX5_SET(ppcnt_reg, in, grp, MLX5_PHYSICAL_LAYER_STATISTICAL_GROUP);
-	mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0, 0);
+	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_recovery_counters)) {
+		out = pstats->phy_recovery_counters;
+		MLX5_SET(ppcnt_reg, in, grp,
+			 MLX5_PHYSICAL_LAYER_RECOVERY_GROUP);
+		mlx5_core_access_reg(mdev, in, sz, out, sz, MLX5_REG_PPCNT, 0,
+				     0);
+	}
 }
 
 void mlx5e_get_link_ext_stats(struct net_device *dev,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 5961c569cfe0..0d87947e348d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -309,6 +309,9 @@ struct mlx5e_vport_stats {
 #define PPORT_PHY_STATISTICAL_GET(pstats, c) \
 	MLX5_GET64(ppcnt_reg, (pstats)->phy_statistical_counters, \
 		   counter_set.phys_layer_statistical_cntrs.c##_high)
+#define PPORT_PHY_RECOVERY_GET(pstats, c) \
+	MLX5_GET64(ppcnt_reg, (pstats)->phy_recovery_counters, \
+		   counter_set.phys_layer_recovery_cntrs.c)
 #define PPORT_PER_PRIO_GET(pstats, prio, c) \
 	MLX5_GET64(ppcnt_reg, pstats->per_prio_counters[prio], \
 		   counter_set.eth_per_prio_grp_data_layout.c##_high)
@@ -324,6 +327,7 @@ struct mlx5e_pport_stats {
 	__be64 per_prio_counters[NUM_PPORT_PRIO][MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 phy_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 phy_statistical_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
+	__be64 phy_recovery_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 eth_ext_counters[MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 per_tc_prio_counters[NUM_PPORT_PRIO][MLX5_ST_SZ_QW(ppcnt_reg)];
 	__be64 per_tc_congest_prio_counters[NUM_PPORT_PRIO][MLX5_ST_SZ_QW(ppcnt_reg)];
-- 
2.31.1


