Return-Path: <linux-rdma+bounces-11888-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BFDAF80FD
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 21:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EEFE3B0910
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Jul 2025 19:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959E42FF47F;
	Thu,  3 Jul 2025 18:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QWZMHOIU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2083.outbound.protection.outlook.com [40.107.244.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C2AF2FA653;
	Thu,  3 Jul 2025 18:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751569021; cv=fail; b=N7JPwQ2qlZ9ZxTkolwBn9mUUv5ZFgGVkuL3hv6eNIfp5TQgNEI/YWDSx/TKtzVjqrB14iBTRQaA5aoofyRPiQuXcTx1ZiD4IYR+AYKJBYjrMfgzto6NG/Tueah98G+1cWdiXlb3TgSFlSHts48QTtXfySUcKCuamaAWoG0YcBBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751569021; c=relaxed/simple;
	bh=3XtL9PEMQ2QLlLetwfxQNuI/WqgGNukNRhBMW+TgLgg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nGW5EbsBK4+e+rhoo4cIA41LNZWP20KNYf2I9+NBtTzWz3kbp07O3ecO/jby8SnLSzITc5ldHo4X9NhZutbMhh6Z937wLI4MFdKEeP84y/PidLMhKtTt+KhZdm28j5u1uaNXlWUkpC6/ebuu42TuuRFIWR3eJWgXw06rvqu2ik8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QWZMHOIU; arc=fail smtp.client-ip=40.107.244.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kar3J2FQBFTzd1Gl6Ca5dp4+eDhEpQlV4qnhP0Jzi+JYhKF7jVPDDmPEm/KmCTMHNwbNDBD7vwJGkPtgle+WMkfsz09bqgjFH6coom1TpRKTyGCKGP3HVScamgaiDZZsxrhd54Z26Dz7b7WO1oDiqxp7T5IMYfb387SPqTXFDbCIAggKLHCGoeOD9mxvrPrv6TPxEh0AKFxLFH1yIy/Iw9FJk8FhE8eoZrIidlOuSHi84SDfit6gcNBJe05sRYwH9Ud5+Nac7dq9wzt4F4tyRLpyXYxMhHAeHaKFvN8EXcViWm8n9cIwrrlNvbKCq90vmUU/LjkWiW+6utGs6x/OUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HZcxiea41geubKpbAkjUQmFiNMzR/zC7y97hxibXy88=;
 b=v8Lpo8u8XIR5l/wFkCySBQmEjM8TARWuztpvxambGFcs32tjutpwzWpfhYUbiXlQmHJAwT0U8xtx66btna/VUjS3LB4ik+7yRdmtwY9FUsSaS12oitn53QWOtIy6tISbh5tczFSzkf6HsT/YKwHqfgKsNgBvnXN7JniWC/zYB3XyuiqrEkg8Q9frWl/z/0zscNK4JzaYvO5PLhLMuCn5bEKW4VTVSdh7uID2xjNbwmpvXmHs3M+KnWGLWdp7iyCBNdM3oupDdOiQKgZUaFYXKtsRm6uwHkU2NJR0LaL8XDdvZA30Yu4cPC799oHdBsQR9LJT6TJOicVpLBWK/WlWYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HZcxiea41geubKpbAkjUQmFiNMzR/zC7y97hxibXy88=;
 b=QWZMHOIUa0XIdHHZy/OkoHi2yiZHLGMRtZec5ylJUFReyYhnLFEd6YXp6VRp6tYJYO6f6CgYpqr8v4vACUAYlgjCtVvmRXrTR3GWhA4Q7DAUu42deVbCSEG9SEccpJW2fuiBfsm+ubsE6pYMaSol/f85h0xzwGUZ/3tFsCdbUWRUPRQEieBpAmrWrz04d5idttmflHvL0UUqn7EWXcEicxd99/VoudgfAsW4z88yzhbXAOJQ5OyG6up0piqjLtSV5oTgm2eOCenKxNOzuOUdJk/YzY9Lm8J0cNwwURL2iBHyAOWThIBghh7JA7FhY/9Wd6i37p1gMC6di9TgwYKnAg==
Received: from BN9PR03CA0560.namprd03.prod.outlook.com (2603:10b6:408:138::25)
 by IA1PR12MB7544.namprd12.prod.outlook.com (2603:10b6:208:42c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.37; Thu, 3 Jul
 2025 18:56:50 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:138:cafe::fe) by BN9PR03CA0560.outlook.office365.com
 (2603:10b6:408:138::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.20 via Frontend Transport; Thu,
 3 Jul 2025 18:56:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Thu, 3 Jul 2025 18:56:50 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 3 Jul 2025
 11:56:33 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 3 Jul
 2025 11:56:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 3 Jul
 2025 11:56:28 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Vlad Dogaru <vdogaru@nvidia.com>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 07/10] net/mlx5: HWS, Track matcher sizes individually
Date: Thu, 3 Jul 2025 21:54:28 +0300
Message-ID: <20250703185431.445571-8-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250703185431.445571-1-mbloch@nvidia.com>
References: <20250703185431.445571-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|IA1PR12MB7544:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b0f56d-d630-4344-71ca-08ddba635e3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7FSTZ0C8Il4miw8rPPVA43IyTQgKGDQUH++AmrfRJNqIgTcOeHbAoB3HDY7P?=
 =?us-ascii?Q?aKZzdnNaTXZaX3CMacaLtf4MmWf1BmsFCkc9iNqFQUheXLNY0WdgiBnrBX76?=
 =?us-ascii?Q?Zc4W3LedG5EvfmYiMBYiNTjTERekqLK3KspYU2++jrnGTd0PNtx7UVpjky6O?=
 =?us-ascii?Q?tH66PsZ38U8Vdp9j92939TubrH14snn+80Pro9i8Xfq5XCswZdK3E+KifghL?=
 =?us-ascii?Q?Sn9emYdeZyzl2jMqW1+4Gv7jyARSzf2AxY5qAx/i8MjHjtXilEFq8NArtV2B?=
 =?us-ascii?Q?MNmax3E6O2WshEsSBxVZpZ01h4NVDEJ/zcOv26Uk6ihbHVodwGgSu8M/BooA?=
 =?us-ascii?Q?L3psRMLB0EqcYLQojzlR8R/gdUIJ+IBjzsKnvyFQbezs6DsyR9t9xNJGPVi1?=
 =?us-ascii?Q?M5IhVfazxrLSxmbLXnA+0/BCwbAXDi1gFiTG0WCGcQBaiyhDNC53PCgXuxpi?=
 =?us-ascii?Q?QbYbLGBroHYa2/cDtLrleWbs1igxLd7UO8L0hHsLFtya+eXOg3xdzHAEVgVx?=
 =?us-ascii?Q?meVkwVgc0ujHwjJsBrdzP6jll7fPxI8+B1gHDCWkGEwxwLplb+KbWb8aNf/h?=
 =?us-ascii?Q?wlsQJ2sojM5RSkaaX2ZsS+R6Q82cnkYaVZc/zAvHv24KJ4UB9vGUpEDZgwP2?=
 =?us-ascii?Q?uzTFuVeY1ZHT5ZznbPlLiFY7/vFLgA9Z0SxUsidxEq+Om5C+5TRiY0qFiklo?=
 =?us-ascii?Q?MHn9eMLifjsVErOYNlCIXLVDTCTT/XHT+tjCuVDxsWVgKB64GblgeEhSOE5w?=
 =?us-ascii?Q?BXaD3Eisu4pYhCoQgcj+SOuvjWOwwWseGAOf5zUdOxLRAbzgEdxGOecTLpxo?=
 =?us-ascii?Q?zE+Sl6txNVEpwflPk4uogGfYiYJc7oXBN54mdBBPTOtDZRiUR5aRmjXiFcTu?=
 =?us-ascii?Q?0vQ2/JfpHEU929mWCSH6TY2Q+pLpV4xEN6rb2toLVVx9AkI6lMKbGiF4Y7o0?=
 =?us-ascii?Q?5iaZ3gSbagDnCnSedx7bRgxYABolVwlsRZE5zUWrZAV65xmmuS0VTfumARTD?=
 =?us-ascii?Q?RgrV3ToIvz94JheFBNoDI0UKCUNGDuSlZL3g7I5m3o3qI2MwhUzmSdFqkAer?=
 =?us-ascii?Q?PQScfozwybWY7CR0c7foVEtW6eXozgWEA0J9fX+0026pR44nY02C+J3RRj+p?=
 =?us-ascii?Q?sUnfOFp8f/wr3r4lRpZwdrbdk8YVTT8nqvBuy8Se3BDAueGo000qe5Y7tuk4?=
 =?us-ascii?Q?vXy0jHMzTWwuiPGAAON5Di+ScyO5iy4PZCOLK9kSFK914iPZr9/i8vnjBD7D?=
 =?us-ascii?Q?It4d3LuEGVA4doJrG6ZFU1+aqJhnPjBIw653gzUTgRWTxcUixt++VM5OVV6n?=
 =?us-ascii?Q?LtPxui/ePd3cd8J09bFA82wzUjG/NkbWBTI4kxUVzZybPBznmNKibmSH7D0A?=
 =?us-ascii?Q?Dybhk8e9BpapcXy6a6toPgLf9XDole8oGQTMIMQMSyBMrPvSFt0X/LjCFOpw?=
 =?us-ascii?Q?odJgrf2vorC5XwYZpSqqaQwKzo3xAmt5sJDvxABEw7IHV15fzu5GE+MRSJMX?=
 =?us-ascii?Q?KF5UoGG9xRSYAznYNDKAPutdAOoImuM/XYwg?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2025 18:56:50.0053
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b0f56d-d630-4344-71ca-08ddba635e3c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7544

From: Vlad Dogaru <vdogaru@nvidia.com>

Track and grow matcher sizes individually for RX and TX RTCs. This
allows RX-only or TX-only use cases to effectively halve the device
resources they use.

For testing we used a simple module that inserts 1M RX-only rules and
measured the number of pages the device requests, and memory usage as
reported by `free -h`.

			Pages		Memory
Before this patch:	300k		1.5GiB
After this patch:	160k		900MiB

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 217 +++++++++++++-----
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  15 +-
 2 files changed, 171 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 009641e6c874..516634237cb8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -93,12 +93,11 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  priority,
-				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
-				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
+				  bwc_matcher->rx_size.size_log,
+				  bwc_matcher->tx_size.size_log,
 				  &attr);
 
 	bwc_matcher->priority = priority;
-	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
 
 	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
 	bwc_matcher->at = kcalloc(bwc_matcher->size_of_at_array,
@@ -150,6 +149,20 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	return -EINVAL;
 }
 
+static void
+hws_bwc_matcher_init_size_rxtx(struct mlx5hws_bwc_matcher_size *size)
+{
+	size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
+	atomic_set(&size->num_of_rules, 0);
+	atomic_set(&size->rehash_required, false);
+}
+
+static void hws_bwc_matcher_init_size(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->rx_size);
+	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->tx_size);
+}
+
 struct mlx5hws_bwc_matcher *
 mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 			   u32 priority,
@@ -170,8 +183,7 @@ mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 	if (!bwc_matcher)
 		return NULL;
 
-	atomic_set(&bwc_matcher->num_of_rules, 0);
-	atomic_set(&bwc_matcher->rehash_required, false);
+	hws_bwc_matcher_init_size(bwc_matcher);
 
 	/* Check if the required match params can be all matched
 	 * in single STE, otherwise complex matcher is needed.
@@ -221,12 +233,13 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	u32 num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
+	u32 rx_rules = atomic_read(&bwc_matcher->rx_size.num_of_rules);
+	u32 tx_rules = atomic_read(&bwc_matcher->tx_size.num_of_rules);
 
-	if (num_of_rules)
+	if (rx_rules || tx_rules)
 		mlx5hws_err(bwc_matcher->matcher->tbl->ctx,
-			    "BWC matcher destroy: matcher still has %d rules\n",
-			    num_of_rules);
+			    "BWC matcher destroy: matcher still has %u RX and %u TX rules\n",
+			    rx_rules, tx_rules);
 
 	if (bwc_matcher->complex)
 		mlx5hws_bwc_matcher_destroy_complex(bwc_matcher);
@@ -386,6 +399,16 @@ hws_bwc_rule_destroy_hws_sync(struct mlx5hws_bwc_rule *bwc_rule,
 	return 0;
 }
 
+static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+
+	if (!bwc_rule->skip_rx)
+		atomic_dec(&bwc_matcher->rx_size.num_of_rules);
+	if (!bwc_rule->skip_tx)
+		atomic_dec(&bwc_matcher->tx_size.num_of_rules);
+}
+
 int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
@@ -402,7 +425,7 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 	mutex_lock(queue_lock);
 
 	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
-	atomic_dec(&bwc_matcher->num_of_rules);
+	hws_bwc_rule_cnt_dec(bwc_rule);
 	hws_bwc_rule_list_remove(bwc_rule);
 
 	mutex_unlock(queue_lock);
@@ -489,25 +512,27 @@ hws_bwc_rule_update_sync(struct mlx5hws_bwc_rule *bwc_rule,
 }
 
 static bool
-hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher)
+hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher,
+			       struct mlx5hws_bwc_matcher_size *size)
 {
 	struct mlx5hws_cmd_query_caps *caps = bwc_matcher->matcher->tbl->ctx->caps;
 
 	/* check the match RTC size */
-	return (bwc_matcher->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
+	return (size->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
 		MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP) >
 	       (caps->ste_alloc_log_max - 1);
 }
 
 static bool
 hws_bwc_matcher_rehash_size_needed(struct mlx5hws_bwc_matcher *bwc_matcher,
+				   struct mlx5hws_bwc_matcher_size *size,
 				   u32 num_of_rules)
 {
-	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher)))
+	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size)))
 		return false;
 
 	if (unlikely((num_of_rules * 100 / MLX5HWS_BWC_MATCHER_REHASH_PERCENT_TH) >=
-		     (1UL << bwc_matcher->size_log)))
+		     (1UL << size->size_log)))
 		return true;
 
 	return false;
@@ -564,20 +589,21 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 }
 
 static int
-hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher)
+hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher,
+			    struct mlx5hws_bwc_matcher_size *size)
 {
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_cmd_query_caps *caps = ctx->caps;
 
-	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher))) {
+	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size))) {
 		mlx5hws_err(ctx, "Can't resize matcher: depth exceeds limit %d\n",
 			    caps->rtc_log_depth_max);
 		return -ENOMEM;
 	}
 
-	bwc_matcher->size_log =
-		min(bwc_matcher->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
-		    caps->ste_alloc_log_max - MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
+	size->size_log = min(size->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
+			     caps->ste_alloc_log_max -
+				     MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
 
 	return 0;
 }
@@ -697,8 +723,8 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  bwc_matcher->priority,
-				  bwc_matcher->size_log,
-				  bwc_matcher->size_log,
+				  bwc_matcher->rx_size.size_log,
+				  bwc_matcher->tx_size.size_log,
 				  &matcher_attr);
 
 	old_matcher = bwc_matcher->matcher;
@@ -736,21 +762,39 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 static int
 hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
+	bool need_rx_rehash, need_tx_rehash;
 	int ret;
 
-	/* If the current matcher size is already at its max size, we can't
-	 * do the rehash. Skip it and try adding the rule again - perhaps
-	 * there was some change.
+	need_rx_rehash = atomic_read(&bwc_matcher->rx_size.rehash_required);
+	need_tx_rehash = atomic_read(&bwc_matcher->tx_size.rehash_required);
+
+	/* It is possible that another rule has already performed rehash.
+	 * Need to check again if we really need rehash.
 	 */
-	if (hws_bwc_matcher_size_maxed_out(bwc_matcher))
+	if (!need_rx_rehash && !need_tx_rehash)
 		return 0;
 
-	/* It is possible that other rule has already performed rehash.
-	 * Need to check again if we really need rehash.
+	/* If the current matcher RX/TX size is already at its max size,
+	 * it can't be rehashed.
 	 */
-	if (!atomic_read(&bwc_matcher->rehash_required) &&
-	    !hws_bwc_matcher_rehash_size_needed(bwc_matcher,
-						atomic_read(&bwc_matcher->num_of_rules)))
+	if (need_rx_rehash &&
+	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
+					   &bwc_matcher->rx_size)) {
+		atomic_set(&bwc_matcher->rx_size.rehash_required, false);
+		need_rx_rehash = false;
+	}
+	if (need_tx_rehash &&
+	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
+					   &bwc_matcher->tx_size)) {
+		atomic_set(&bwc_matcher->tx_size.rehash_required, false);
+		need_tx_rehash = false;
+	}
+
+	/* If both RX and TX rehash flags are now off, it means that whatever
+	 * we wanted to rehash is now at its max size - no rehash can be done.
+	 * Return and try adding the rule again - perhaps there was some change.
+	 */
+	if (!need_rx_rehash && !need_tx_rehash)
 		return 0;
 
 	/* Now we're done all the checking - do the rehash:
@@ -759,12 +803,22 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	 *  - move all the rules to the new matcher
 	 *  - destroy the old matcher
 	 */
+	atomic_set(&bwc_matcher->rx_size.rehash_required, false);
+	atomic_set(&bwc_matcher->tx_size.rehash_required, false);
 
-	atomic_set(&bwc_matcher->rehash_required, false);
+	if (need_rx_rehash) {
+		ret = hws_bwc_matcher_extend_size(bwc_matcher,
+						  &bwc_matcher->rx_size);
+		if (ret)
+			return ret;
+	}
 
-	ret = hws_bwc_matcher_extend_size(bwc_matcher);
-	if (ret)
-		return ret;
+	if (need_tx_rehash) {
+		ret = hws_bwc_matcher_extend_size(bwc_matcher,
+						  &bwc_matcher->tx_size);
+		if (ret)
+			return ret;
+	}
 
 	return hws_bwc_matcher_move(bwc_matcher);
 }
@@ -816,6 +870,62 @@ static int hws_bwc_rule_get_at_idx(struct mlx5hws_bwc_rule *bwc_rule,
 	return at_idx;
 }
 
+static void hws_bwc_rule_cnt_inc_rxtx(struct mlx5hws_bwc_rule *bwc_rule,
+				      struct mlx5hws_bwc_matcher_size *size)
+{
+	u32 num_of_rules = atomic_inc_return(&size->num_of_rules);
+
+	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_rule->bwc_matcher,
+							size, num_of_rules)))
+		atomic_set(&size->rehash_required, true);
+}
+
+static void hws_bwc_rule_cnt_inc(struct mlx5hws_bwc_rule *bwc_rule)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+
+	if (!bwc_rule->skip_rx)
+		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->rx_size);
+	if (!bwc_rule->skip_tx)
+		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->tx_size);
+}
+
+static int hws_bwc_rule_cnt_inc_with_rehash(struct mlx5hws_bwc_rule *bwc_rule,
+					    u16 bwc_queue_idx)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mutex *queue_lock; /* Protect the queue */
+	int ret;
+
+	hws_bwc_rule_cnt_inc(bwc_rule);
+
+	if (!atomic_read(&bwc_matcher->rx_size.rehash_required) &&
+	    !atomic_read(&bwc_matcher->tx_size.rehash_required))
+		return 0;
+
+	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
+	mutex_unlock(queue_lock);
+
+	hws_bwc_lock_all_queues(ctx);
+	ret = hws_bwc_matcher_rehash_size(bwc_matcher);
+	hws_bwc_unlock_all_queues(ctx);
+
+	mutex_lock(queue_lock);
+
+	if (likely(!ret))
+		return 0;
+
+	/* Failed to rehash. Print a diagnostic and rollback the counters. */
+	mlx5hws_err(ctx,
+		    "BWC rule insertion: rehash to sizes [%d, %d] failed (%d)\n",
+		    bwc_matcher->rx_size.size_log,
+		    bwc_matcher->tx_size.size_log, ret);
+	hws_bwc_rule_cnt_dec(bwc_rule);
+
+	return ret;
+}
+
 int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 				   u32 *match_param,
 				   struct mlx5hws_rule_action rule_actions[],
@@ -826,7 +936,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
-	u32 num_of_rules;
 	int ret = 0;
 	int at_idx;
 
@@ -844,26 +953,10 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		return -EINVAL;
 	}
 
-	/* check if number of rules require rehash */
-	num_of_rules = atomic_inc_return(&bwc_matcher->num_of_rules);
-
-	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))) {
+	ret = hws_bwc_rule_cnt_inc_with_rehash(bwc_rule, bwc_queue_idx);
+	if (unlikely(ret)) {
 		mutex_unlock(queue_lock);
-
-		hws_bwc_lock_all_queues(ctx);
-		ret = hws_bwc_matcher_rehash_size(bwc_matcher);
-		hws_bwc_unlock_all_queues(ctx);
-
-		if (ret) {
-			mlx5hws_err(ctx, "BWC rule insertion: rehash size [%d -> %d] failed (%d)\n",
-				    bwc_matcher->size_log - MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
-				    bwc_matcher->size_log,
-				    ret);
-			atomic_dec(&bwc_matcher->num_of_rules);
-			return ret;
-		}
-
-		mutex_lock(queue_lock);
+		return ret;
 	}
 
 	ret = hws_bwc_rule_create_sync(bwc_rule,
@@ -881,8 +974,11 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	 * It could be because there was collision, or some other problem.
 	 * Try rehash by size and insert rule again - last chance.
 	 */
+	if (!bwc_rule->skip_rx)
+		atomic_set(&bwc_matcher->rx_size.rehash_required, true);
+	if (!bwc_rule->skip_tx)
+		atomic_set(&bwc_matcher->tx_size.rehash_required, true);
 
-	atomic_set(&bwc_matcher->rehash_required, true);
 	mutex_unlock(queue_lock);
 
 	hws_bwc_lock_all_queues(ctx);
@@ -891,7 +987,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	if (ret) {
 		mlx5hws_err(ctx, "BWC rule insertion: rehash failed (%d)\n", ret);
-		atomic_dec(&bwc_matcher->num_of_rules);
+		hws_bwc_rule_cnt_dec(bwc_rule);
 		return ret;
 	}
 
@@ -907,7 +1003,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(ret)) {
 		mutex_unlock(queue_lock);
 		mlx5hws_err(ctx, "BWC rule insertion failed (%d)\n", ret);
-		atomic_dec(&bwc_matcher->num_of_rules);
+		hws_bwc_rule_cnt_dec(bwc_rule);
 		return ret;
 	}
 
@@ -937,6 +1033,10 @@ mlx5hws_bwc_rule_create(struct mlx5hws_bwc_matcher *bwc_matcher,
 	if (unlikely(!bwc_rule))
 		return NULL;
 
+	bwc_rule->flow_source = flow_source;
+	mlx5hws_rule_skip(bwc_matcher->matcher, flow_source,
+			  &bwc_rule->skip_rx, &bwc_rule->skip_tx);
+
 	bwc_queue_idx = hws_bwc_gen_queue_idx(ctx);
 
 	if (bwc_matcher->complex)
@@ -972,7 +1072,8 @@ hws_bwc_rule_action_update(struct mlx5hws_bwc_rule *bwc_rule,
 
 	idx = bwc_rule->bwc_queue_idx;
 
-	mlx5hws_bwc_rule_fill_attr(bwc_matcher, idx, 0, &rule_attr);
+	mlx5hws_bwc_rule_fill_attr(bwc_matcher, idx, bwc_rule->flow_source,
+				   &rule_attr);
 	queue_lock = hws_bwc_get_queue_lock(ctx, idx);
 
 	mutex_lock(queue_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index d21fc247a510..af391d70c14f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -19,6 +19,13 @@
 #define MLX5HWS_BWC_POLLING_TIMEOUT 60
 
 struct mlx5hws_bwc_matcher_complex_data;
+
+struct mlx5hws_bwc_matcher_size {
+	u8 size_log;
+	atomic_t num_of_rules;
+	atomic_t rehash_required;
+};
+
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
@@ -27,10 +34,9 @@ struct mlx5hws_bwc_matcher {
 	struct mlx5hws_bwc_matcher *complex_first_bwc_matcher;
 	u8 num_of_at;
 	u8 size_of_at_array;
-	u8 size_log;
 	u32 priority;
-	atomic_t num_of_rules;
-	atomic_t rehash_required;
+	struct mlx5hws_bwc_matcher_size rx_size;
+	struct mlx5hws_bwc_matcher_size tx_size;
 	struct list_head *rules;
 };
 
@@ -39,7 +45,10 @@ struct mlx5hws_bwc_rule {
 	struct mlx5hws_rule *rule;
 	struct mlx5hws_bwc_rule *isolated_bwc_rule;
 	struct mlx5hws_bwc_complex_rule_hash_node *complex_hash_node;
+	u32 flow_source;
 	u16 bwc_queue_idx;
+	bool skip_rx;
+	bool skip_tx;
 	struct list_head list_node;
 };
 
-- 
2.34.1


