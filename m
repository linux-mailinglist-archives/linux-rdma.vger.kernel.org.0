Return-Path: <linux-rdma+bounces-9667-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D00A9643F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 11:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 817AC16A6B0
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Apr 2025 09:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF84420126C;
	Tue, 22 Apr 2025 09:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="KD6oHFUi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A639A1FC0E6;
	Tue, 22 Apr 2025 09:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313994; cv=fail; b=VR2j1lFWHtUfS82X3mtsoPjb6xvdWvOQpWTE1Ky8zzf51mcH0+E1Sq72HpMb5CCqEBt1uj6tzh69gjJcvR8Or7cASu9mS+IRpH5Afy+tSrfzte101rTcdW1xSDfmPe+XkZeCmMHLO8tRYD/daceXlSaPcXpbHdxWGhjkLCrju0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313994; c=relaxed/simple;
	bh=WvSmCmATlv/IvB3jY+YouK6FRwwSYGva4E/S2FiwsuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FWREVN9C/CzHS2u1j/G2FCDp1BXKLFlutyon64kmkMJwGIj2PAfu4RbaDOqNLkfuWCyaYZlT5es0rOCT04lSqCHj7QjXKshkswWHTyODiPjR4I/GEpUVvG7XUrppNUOuR+b6GfoX3Sh67aUh6uk/JX4P5xoBzJsJ0jIiRG/AURg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=KD6oHFUi; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QW3u7Koy7aK9LAghWixDj+vG/BQBRcrcYquleHCCh1wFf4bQHlDM1VX+/Ek/7u+YMWEUkPno47H8eb8agn5krxha5kmDZctNL0d1NzYq8wmkCU8ydMEQtbD6mC9POSDB25LohXCWh2af/L1opmziyJtf9cjrJrVALvdKGJK1YGRP/VMjpJw3xNEYkZEPaV5b9qQ9dOZgSW4rEJDCQGaLRPvCIjG8/WXW0FhThLkgmaCnyV8AYzlebgTwTe+GR44+/Q7j4FfsW/yOBQB0gJQfWJiEVPxnD5QYu5f2jeUIAK/UBDIYhkafkNhG77eS4Z8HGBwiNuADhHT55UL6Dh+TJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xg4pNtyqaNKnTtSpf+biT+9xET/FnSHRQO5Xog8MaPo=;
 b=La83+VbHaP/l9Ne0nKmkPXVnOS7wrmcnqw7a9zOhdOPBkiyzVWYYlG/UKVOgda9dGLAwwpX+Cz0DfsCjNTmuKiTXpfGCBccH5ufIValnOehGoWfzXVUkfFOU5RRLPkKe6WI9QAFr5ykHWObppjF/7At5Ox25geRTiNVZIBBfmju0Gr7Ls8aIa6ZyJRrIfM59wS5IeIpOSyK7PVhWt/N5WNBPxF8flPrBqt7ZBUlkzkSqtF8XaZkDv3idwwsFM0IlH7V1euMZy54kY5uoY+zzZRRFDhCVS34QG+cQREfDi4WmJv+dXvbm+3oX3akmP5vgtlpxmgK+bqUD6HodufTAcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xg4pNtyqaNKnTtSpf+biT+9xET/FnSHRQO5Xog8MaPo=;
 b=KD6oHFUiotDQB27W+l+lNx1rX7uZMIaNhN4biuBBgQ7jpq/YfU3iRbDAXyz7PrrelCF0Q736Obu38sL5sHwFIIvn8ugy+67Tbkhmxs7k0+rnmUJP6bxvCkKZlqaxXDBNAwqY86AkbU75i4+3FS95Nx9rDQafZ/lJ3/s6bSm/VyjLdZ8Niv5OXMRnza+k23JvPsI0hvWFDt7/YH092jNgaHsSLri8GcF/lPfoyjxvNeyl7+/SAWogA0/x4nnz84q36bOLHDw3n3J8nMneFx7preauUgOzeS4Sp37TqqdW2kIXZP2Y/EEtxM9DyQ7NIbg0pSCjALNThUZgH/+o7ah1bg==
Received: from BYAPR01CA0030.prod.exchangelabs.com (2603:10b6:a02:80::43) by
 IA0PR12MB8716.namprd12.prod.outlook.com (2603:10b6:208:485::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Tue, 22 Apr
 2025 09:26:27 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:80:cafe::99) by BYAPR01CA0030.outlook.office365.com
 (2603:10b6:a02:80::43) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Tue,
 22 Apr 2025 09:26:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Tue, 22 Apr 2025 09:26:27 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Apr
 2025 02:26:03 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Apr
 2025 02:26:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 22
 Apr 2025 02:26:00 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Eric Dumazet
	<edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: HWS, Disallow matcher IP version mixing
Date: Tue, 22 Apr 2025 12:25:40 +0300
Message-ID: <20250422092540.182091-4-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250422092540.182091-1-mbloch@nvidia.com>
References: <20250422092540.182091-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|IA0PR12MB8716:EE_
X-MS-Office365-Filtering-Correlation-Id: 443b4696-4569-4fd9-0f67-08dd817fc1ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c96UdojOAtOl3LYHdQToERdqurkevynk0ihJoATX0yMw1KVFICTGIyqNVXYy?=
 =?us-ascii?Q?D8w2Hywl+QmkaeRGEvDwpv8PD3O3EdS/RFSZMfaUJAMpKaF6wiTL1OJrzG++?=
 =?us-ascii?Q?XgSRHvffnx0v5wGRfom6OZuj2Gp6BhZ5WYtz8ufYFaie0UOnOUUr0Yif1cMw?=
 =?us-ascii?Q?QnaT8StErF3RjtWXtVDmvukUlzmXDNH3uIprf0eFgurFqKnY7X0vcpPZJmre?=
 =?us-ascii?Q?9yOqi8KTHNGCC/njOIKVL1fpPFLRmqPdi7On/PMXzqCyHam6ddW3CuuuLFH4?=
 =?us-ascii?Q?Xl1cNBD+/wDJ8sXb9th6K2qtP4VWjhQRMu2Y1kL6+iDSI7sAFXKuWScTFVRD?=
 =?us-ascii?Q?HvpJwseBqvVcAZzlVWulYHcBvluX9P6vEwYbLv3yYK6jRS2r16wgngwcieS7?=
 =?us-ascii?Q?Io86Vorsj/3Ac+gyNlh4xrLFZP5H/d2dP666zp6STKLfP5WhlLJcQM5UPtJj?=
 =?us-ascii?Q?VEsJqwVXs1qhzs7AIb6qST4nDwLdZhVKI/HDnbGod203SvpO65+ieCo2VNgG?=
 =?us-ascii?Q?aCEuLcJdQCn1tnu9I5RwqUJhgdP7XC2olfXMZaCpRY966cIyCuc9sSHUw8sT?=
 =?us-ascii?Q?cLBgSlFBJfSxFyaNeY5CpkXiLynYDNt0XoXMKmdcVmxZog1705iYXBXpcJ1s?=
 =?us-ascii?Q?w7HsUDaSr+aZKZeisleVU48Lx79WQpGYoJVqJSsZS1/ZT2gDr/fwTnhq59UE?=
 =?us-ascii?Q?j8F3v/t4lUMkRNmj0+jIA3T5BYlNWVyGxe8JiIa7hpDM7RnaZ4C4wrvlmVL1?=
 =?us-ascii?Q?hSHDnwIU4Lm3nXNd/2Uc4bPBsXSHeZqsgEDPaIaywLPR8WPHIjAAUCeciERW?=
 =?us-ascii?Q?3MnjosDMsUNPLSPI7nhpSuy0RqbkGCVwxDH47vXueZQEbIx03y8K2wj6FMlE?=
 =?us-ascii?Q?b5I2BMq1ath+s9IJYV9vV8lmp48wpmXuocqvgefA7mztn4i1DSLe4eWnQKJI?=
 =?us-ascii?Q?PXwgy19HkAnNXYOiFYu0oljqByfa2eh4/gv3IfI0NZORb5SENKb0nxQqlqrj?=
 =?us-ascii?Q?Vrb50zLZXUFYNkSqOkKm60vf8L47EtYBqXBKNg6aQ4dCQtI0j3LgNvPPt5m7?=
 =?us-ascii?Q?UeHMjU82dipvuF6mOiEdZzlzKX8dyK5rDTUt0fBMnkUHSsvdKyV7Znc3Wxqh?=
 =?us-ascii?Q?kyFrXOrv25uL4pbkRF55NcVqWAoYTBoolQJKnWwyh0CI023tUItja11tqqgz?=
 =?us-ascii?Q?NP6eOFEntJ5a7oDc+2uY6xjqTE5+GnoukEKME4J4rVXs+BhL9qEaFfHPzRX/?=
 =?us-ascii?Q?GYbbMSYTMRKpJAdvsHtdL85P996bmwXVxQW7ECD6xa2jslDTT/Zw4WJWywfv?=
 =?us-ascii?Q?i1UWNrvjlVhrHqCerhU/cNDgGUSx1t/LbavogqI8YkrkJXg47nTfCkwzEUTI?=
 =?us-ascii?Q?UEXhNV8nyA2jcHD4tz36HQ88Fn6NDPCOzTGxUKHWAN44appRbbuXBdPZ73gs?=
 =?us-ascii?Q?pmpUGKvKffJOWsqsb2f1HemNNZrNfflZQe/gbQl1VUDzZcuZ8+n+3NKFC+sF?=
 =?us-ascii?Q?EljRbt5PBmn1CuLjoLzyWk9PnJLmSZpLPCUl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2025 09:26:27.0040
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443b4696-4569-4fd9-0f67-08dd817fc1ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8716

From: Vlad Dogaru <vdogaru@nvidia.com>

Signal clearly to the user, via an error, that mixing IPv4 and IPv6
rules in the same matcher is not supported. Previously such cases
silently failed by adding a rule that did not work correctly.

Rules can specify an IP version by one of two fields: IP version or
ethertype. At matcher creation, store whether the template matches on
any of these two fields. If yes, inspect each rule for its corresponding
match value and store the IP version inside the matcher to guard against
inconsistencies with subsequent rules.

Furthermore, also check rules for internal consistency, i.e. verify that
the ethertype and IP version match values do not contradict each other.

The logic applies to inner and outer headers independently, to account
for tunneling.

Rules that do not match on IP addresses are not affected.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/matcher.c |  26 ++++
 .../mellanox/mlx5/core/steering/hws/matcher.h |  12 ++
 .../mellanox/mlx5/core/steering/hws/rule.c    | 122 ++++++++++++++++++
 3 files changed, 160 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index 716502732d3d..5b0c1623499b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -385,6 +385,30 @@ static int hws_matcher_bind_at(struct mlx5hws_matcher *matcher)
 	return 0;
 }
 
+static void hws_matcher_set_ip_version_match(struct mlx5hws_matcher *matcher)
+{
+	int i;
+
+	for (i = 0; i < matcher->mt->fc_sz; i++) {
+		switch (matcher->mt->fc[i].fname) {
+		case MLX5HWS_DEFINER_FNAME_ETH_TYPE_O:
+			matcher->matches_outer_ethertype = 1;
+			break;
+		case MLX5HWS_DEFINER_FNAME_ETH_L3_TYPE_O:
+			matcher->matches_outer_ip_version = 1;
+			break;
+		case MLX5HWS_DEFINER_FNAME_ETH_TYPE_I:
+			matcher->matches_inner_ethertype = 1;
+			break;
+		case MLX5HWS_DEFINER_FNAME_ETH_L3_TYPE_I:
+			matcher->matches_inner_ip_version = 1;
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 {
 	struct mlx5hws_context *ctx = matcher->tbl->ctx;
@@ -401,6 +425,8 @@ static int hws_matcher_bind_mt(struct mlx5hws_matcher *matcher)
 		}
 	}
 
+	hws_matcher_set_ip_version_match(matcher);
+
 	/* Create an STE pool per matcher*/
 	pool_attr.table_type = matcher->tbl->type;
 	pool_attr.pool_type = MLX5HWS_POOL_TYPE_STE;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
index bad1fa8f77fd..8e95158a66b5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.h
@@ -50,6 +50,12 @@ struct mlx5hws_matcher_match_ste {
 	struct mlx5hws_pool *pool;
 };
 
+enum {
+	MLX5HWS_MATCHER_IPV_UNSET = 0,
+	MLX5HWS_MATCHER_IPV_4 = 1,
+	MLX5HWS_MATCHER_IPV_6 = 2,
+};
+
 struct mlx5hws_matcher {
 	struct mlx5hws_table *tbl;
 	struct mlx5hws_matcher_attr attr;
@@ -61,6 +67,12 @@ struct mlx5hws_matcher {
 	u8 num_of_action_stes;
 	/* enum mlx5hws_matcher_flags */
 	u8 flags;
+	u8 matches_outer_ethertype:1;
+	u8 matches_outer_ip_version:1;
+	u8 matches_inner_ethertype:1;
+	u8 matches_inner_ip_version:1;
+	u8 outer_ip_version:2;
+	u8 inner_ip_version:2;
 	u32 end_ft_id;
 	struct mlx5hws_matcher *col_matcher;
 	struct mlx5hws_matcher *resize_dst;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
index 9e6f35d68445..5342a4cc7194 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/rule.c
@@ -655,6 +655,124 @@ int mlx5hws_rule_move_hws_add(struct mlx5hws_rule *rule,
 	return 0;
 }
 
+static u8 hws_rule_ethertype_to_matcher_ipv(u32 ethertype)
+{
+	switch (ethertype) {
+	case ETH_P_IP:
+		return MLX5HWS_MATCHER_IPV_4;
+	case ETH_P_IPV6:
+		return MLX5HWS_MATCHER_IPV_6;
+	default:
+		return MLX5HWS_MATCHER_IPV_UNSET;
+	}
+}
+
+static u8 hws_rule_ip_version_to_matcher_ipv(u32 ip_version)
+{
+	switch (ip_version) {
+	case 4:
+		return MLX5HWS_MATCHER_IPV_4;
+	case 6:
+		return MLX5HWS_MATCHER_IPV_6;
+	default:
+		return MLX5HWS_MATCHER_IPV_UNSET;
+	}
+}
+
+static int hws_rule_check_outer_ip_version(struct mlx5hws_matcher *matcher,
+					   u32 *match_param)
+{
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	u8 outer_ipv_ether = MLX5HWS_MATCHER_IPV_UNSET;
+	u8 outer_ipv_ip = MLX5HWS_MATCHER_IPV_UNSET;
+	u8 outer_ipv, ver;
+
+	if (matcher->matches_outer_ethertype) {
+		ver = MLX5_GET(fte_match_param, match_param,
+			       outer_headers.ethertype);
+		outer_ipv_ether = hws_rule_ethertype_to_matcher_ipv(ver);
+	}
+	if (matcher->matches_outer_ip_version) {
+		ver = MLX5_GET(fte_match_param, match_param,
+			       outer_headers.ip_version);
+		outer_ipv_ip = hws_rule_ip_version_to_matcher_ipv(ver);
+	}
+
+	if (outer_ipv_ether != MLX5HWS_MATCHER_IPV_UNSET &&
+	    outer_ipv_ip != MLX5HWS_MATCHER_IPV_UNSET &&
+	    outer_ipv_ether != outer_ipv_ip) {
+		mlx5hws_err(ctx, "Rule matches on inconsistent outer ethertype and ip version\n");
+		return -EINVAL;
+	}
+
+	outer_ipv = outer_ipv_ether != MLX5HWS_MATCHER_IPV_UNSET ?
+		    outer_ipv_ether : outer_ipv_ip;
+	if (outer_ipv != MLX5HWS_MATCHER_IPV_UNSET &&
+	    matcher->outer_ip_version != MLX5HWS_MATCHER_IPV_UNSET &&
+	    outer_ipv != matcher->outer_ip_version) {
+		mlx5hws_err(ctx, "Matcher and rule disagree on outer IP version\n");
+		return -EINVAL;
+	}
+	matcher->outer_ip_version = outer_ipv;
+
+	return 0;
+}
+
+static int hws_rule_check_inner_ip_version(struct mlx5hws_matcher *matcher,
+					   u32 *match_param)
+{
+	struct mlx5hws_context *ctx = matcher->tbl->ctx;
+	u8 inner_ipv_ether = MLX5HWS_MATCHER_IPV_UNSET;
+	u8 inner_ipv_ip = MLX5HWS_MATCHER_IPV_UNSET;
+	u8 inner_ipv, ver;
+
+	if (matcher->matches_inner_ethertype) {
+		ver = MLX5_GET(fte_match_param, match_param,
+			       inner_headers.ethertype);
+		inner_ipv_ether = hws_rule_ethertype_to_matcher_ipv(ver);
+	}
+	if (matcher->matches_inner_ip_version) {
+		ver = MLX5_GET(fte_match_param, match_param,
+			       inner_headers.ip_version);
+		inner_ipv_ip = hws_rule_ip_version_to_matcher_ipv(ver);
+	}
+
+	if (inner_ipv_ether != MLX5HWS_MATCHER_IPV_UNSET &&
+	    inner_ipv_ip != MLX5HWS_MATCHER_IPV_UNSET &&
+	    inner_ipv_ether != inner_ipv_ip) {
+		mlx5hws_err(ctx, "Rule matches on inconsistent inner ethertype and ip version\n");
+		return -EINVAL;
+	}
+
+	inner_ipv = inner_ipv_ether != MLX5HWS_MATCHER_IPV_UNSET ?
+		    inner_ipv_ether : inner_ipv_ip;
+	if (inner_ipv != MLX5HWS_MATCHER_IPV_UNSET &&
+	    matcher->inner_ip_version != MLX5HWS_MATCHER_IPV_UNSET &&
+	    inner_ipv != matcher->inner_ip_version) {
+		mlx5hws_err(ctx, "Matcher and rule disagree on inner IP version\n");
+		return -EINVAL;
+	}
+	matcher->inner_ip_version = inner_ipv;
+
+	return 0;
+}
+
+static int hws_rule_check_ip_version(struct mlx5hws_matcher *matcher,
+				     u32 *match_param)
+{
+	int ret;
+
+	ret = hws_rule_check_outer_ip_version(matcher, match_param);
+	if (unlikely(ret))
+		return ret;
+
+	ret = hws_rule_check_inner_ip_version(matcher, match_param);
+	if (unlikely(ret))
+		return ret;
+
+	return 0;
+}
+
 int mlx5hws_rule_create(struct mlx5hws_matcher *matcher,
 			u8 mt_idx,
 			u32 *match_param,
@@ -665,6 +783,10 @@ int mlx5hws_rule_create(struct mlx5hws_matcher *matcher,
 {
 	int ret;
 
+	ret = hws_rule_check_ip_version(matcher, match_param);
+	if (unlikely(ret))
+		return ret;
+
 	rule_handle->matcher = matcher;
 
 	ret = hws_rule_enqueue_precheck_create(rule_handle, attr);
-- 
2.34.1


