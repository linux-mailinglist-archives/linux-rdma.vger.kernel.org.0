Return-Path: <linux-rdma+bounces-14334-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 95C47C43AE3
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 304DC188BF9F
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0E2D6605;
	Sun,  9 Nov 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="V3SCxtRM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013039.outbound.protection.outlook.com [40.107.201.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB0092D4805;
	Sun,  9 Nov 2025 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681164; cv=fail; b=uV3tE5Vi4LByCd70pwprfAHeVopd0Xj+kIWnkIPLVpf09E/LlNivR36e9FMWl99PYXDNisGccnbHqAU1X241r/oqvbSdkwBPehw4noC3vN4zliIxZcU8nMFG4BYMzeh1sC31qV7HSYEeXGUcBwXOB5LVpC3o+Uyd9qOVyQ0f8Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681164; c=relaxed/simple;
	bh=tLHW4/gws/sU1h07aQnIxXyYSXuW92bukoK20QE8Af0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jY7I4BJdv+KU0AseEgNRinAWu49CsihF4BWs/MABovXeEbWHB9kf9FPEmS8XYZL75O8c16V0YwbGU0LLVSxzBm/WCaLPClHwGVXEc4qKNjaLCT6gN1Xkshf98e9Um57skoqXU/RQBWKcJtadghicAZUJbM0/ECY1DOxuBrZsV/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=V3SCxtRM; arc=fail smtp.client-ip=40.107.201.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AKLfvk0JaGueicZgAhvilP9NfIrYpncX0796IrbP5H8yv7dqEfynA68a9tDglUFmC16CQ3GK8kTJecRhFvuGRfvUW5EY1p88a5215cjrw5Hff7A+PmdyXxQSsN5uioGmheaGtHLBn0z/i5+WmTcFbIAAQjAn3PaS825m9rubOZJWoXpRzMWNRxkDx6DGMuouP/suUW42BVMJvaiTHpoX03dDpe30FhZtLJjWLOUNC1mPWGDSaWmwQ5J9Q7zlIoDW7OVc561NbJ8LEcfMso3OxX6UHcFR9LUju0TViqdfJjCRJPGnEuUggWjyNX2b2RF0anecINwsykv6x9ucJbwCTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gm7JUJJmLZlYBTd0zdaBS005P95nzkFID5D8TuTTrZc=;
 b=m0ojAFy4TbGOuHGxrKMxbc22qe6aE09+3ch7XVPPmrzyyzYBQIEZH4NbiTAACAzZ5L1bD8QW4I9+TBZv391t5Xhc1HlYIxWfMqBPvvvolLAFjf/Eo2OzIs9FghIXUuGlhqvrnAjp2iUi4tsEgWU4+eIXJSVsZS7PK0lx9xo6PiMo7oPxp22RdHoV+RxTgAkh4zTyqMgU4jSWnnlpFnEEHldRitx7rexDDvgLGbVB31LagXQWoX17cwLY+OIOhu0D3gV9HcJtl5zHlchpV1jBiMZ7w1kqqsLP2cbxXuYmNnonwZlR0O5T9O5a0jhKB68XrhbMvZbkFBdh83BtsilofQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gm7JUJJmLZlYBTd0zdaBS005P95nzkFID5D8TuTTrZc=;
 b=V3SCxtRMeEujbX+QDbYNka34oBCgKjJZgFqbmH0RaAj1UFYdoM5FYg2iWeAg/CujjD4fp3eUt4x5I0//Ozlx1KETt5CjqDBEPo3stTp8oMQDzTr3c8QMKfPI0qoNZ0vz6bE90f5u/YhuMtSUV3Z8IqFPkOLSbYcpP0lPP6YJKZMmbqV0Dqr1zqjsOZvrB5izOzeXithDY3St5lNWgYR1CoMor46P7DJA8MwnPxx5BzF/OxcpVU7IQSSYenUjKAKVWsTf4VukJYSjPpjwEGiY1jEO2n0plWUQfJjMx9tr+WavAbJaJBj1a1WQZ+5tHdKxJDTSxMzNUu6sFLK+LxVJmw==
Received: from BY5PR13CA0018.namprd13.prod.outlook.com (2603:10b6:a03:180::31)
 by SJ2PR12MB9164.namprd12.prod.outlook.com (2603:10b6:a03:556::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 09:39:18 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:a03:180:cafe::88) by BY5PR13CA0018.outlook.office365.com
 (2603:10b6:a03:180::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.12 via Frontend Transport; Sun,
 9 Nov 2025 09:39:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 09:39:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:39:04 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:39:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 9 Nov
 2025 01:39:00 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 4/5] net/mlx5e: Fix wraparound in rate limiting for values above 255 Gbps
Date: Sun, 9 Nov 2025 11:37:52 +0200
Message-ID: <1762681073-1084058-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
References: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|SJ2PR12MB9164:EE_
X-MS-Office365-Filtering-Correlation-Id: edc8e331-2fbf-4e46-f63a-08de1f73da60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aerpW2j6JLdtcEqJjpz6Z/d8QL0rsx8XscJjBLAKco88oEFuWhjWujeqRMVX?=
 =?us-ascii?Q?cafATTieJVrvfHR4T5agzerVuEb3cnRVsoOtcwUJ/AoTj6o4N5bVNLP+DOD1?=
 =?us-ascii?Q?Ab3mEJ0pgAz8P0VQF1bX4KfzZpWeTs6LM6ipkdpXbph8ptw5O33wHcbDS9rL?=
 =?us-ascii?Q?XDIjJlCgLONpK/IqmMZYvo1mBOzhmMzwvArUbd7ndDPTLz4sBu6NplHwPOm6?=
 =?us-ascii?Q?LXQWK2iHltXd6h9Pu10wPkTGKQ02H53CjM/F1IlCwtxUMHcSC9nlAptu6YUw?=
 =?us-ascii?Q?Gn+jleHnw4g3SPDxSXcCRKp+8nlFqkDRbB1rUjMnMDKRM9VWQgwagUKf+t5H?=
 =?us-ascii?Q?dZm/66Os3f9kASmfeVoJXoFZ6BrtylF5qvzEYkNLLd+ge3kGwgCv8wj9JRP7?=
 =?us-ascii?Q?fEa5HyxQ64GPyApuAECaxtcxQ9zXSOeY966cNJgXjfvY8DRmVtN/6AW1c9g2?=
 =?us-ascii?Q?Y6s2oZq8bIuswmEKzXOUXeiR5CC4ISsiHlhCfuQJNyVQVQpZm1HaO82BkRJj?=
 =?us-ascii?Q?zDfvkPXhC6gGIjFRBiVxswN9CcKgVouV6q8+klXWfZzUIHZpLtKq2MbJ6ZmA?=
 =?us-ascii?Q?38EIp1pkH6csnBOqtQA3Wf0Jw8esrnUW8fINpvNs8uUIY2uYu9IN4fMLSTCW?=
 =?us-ascii?Q?Udpi+2Nh4JbkCYC2dNcPs2MHOtvMLnfMSZ36SRrQyo+7M7yrRiu0zAjUpITZ?=
 =?us-ascii?Q?/ZFoyYLxplEppFLPYOyn1QiVonJqIgK9FwKjEEJDmEyG4JT/+aVstMWSxwBM?=
 =?us-ascii?Q?H1GhKzW1DLYlNvqoyz01wSpVaEDQSiU55x24h/9lPL4nLWUchv0ZRts3KYz6?=
 =?us-ascii?Q?na7Hvw8QRjxM5ePNKLiip31UcpubwpmC6JtL/IYLGesEHZLiCbqshhxmuooW?=
 =?us-ascii?Q?YWA8z4RxJCIu24lAi5CM/1DJ8W/+8jkrqa0H5Ujx75/j0C91tIGCzxKrPKhz?=
 =?us-ascii?Q?8EHykrVyC98C/qrdEFd0YYUBoHl932VhfNfLKTo/QlPz5ABqf3UR5WZlAQl0?=
 =?us-ascii?Q?mXKaQ79MpjGbWTiJOZvRXRkl2je2r9uX+ORxmE3rS6YrKpmpZTFSzyXca+On?=
 =?us-ascii?Q?DZNhtaWnYmvht0viySdCsXaW7fmXnk+/5nJBpXcBFKndJTaHuK+uD2lEBdTd?=
 =?us-ascii?Q?gLJ11fj4GvWVv1aqwSElKFnhnqgh16+8WDWtmNEBnYSDoU9i1N3IW887fPVU?=
 =?us-ascii?Q?5PLzafdHerOSYkOwgfx0efgndyaPAjWGUWXXdMnnzzfXkrXGZt96QSXNh/gB?=
 =?us-ascii?Q?i44HLyCswePB9VjSXFHf8rzi+9vcXrS60OBF8TNQ2exwAzd81eSHe1OmmfQ2?=
 =?us-ascii?Q?45G7LFx+ggXw1hHGejDBEnD62pf1Bb4rkecQqsUJlsPGdbS0WLWONY/qegQj?=
 =?us-ascii?Q?huIGwKty+85LO8miGDmHNcm3Hy6ed17B29aGhtkR4XTbgb3ZbYa8Atk0jKpj?=
 =?us-ascii?Q?/c6IbtUDye/HPClHXDacw2ReMb6oM/UQpAwEboq2B0TQwIbRkyoC03A3q60q?=
 =?us-ascii?Q?f9EVKxqPMuTcuusl7lzvlW5EjOoTBo54qmhI9xruPQP20qiiUQdSBfBoYRvM?=
 =?us-ascii?Q?we4xZYdFgVVzhVYkKXI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 09:39:17.7755
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: edc8e331-2fbf-4e46-f63a-08de1f73da60
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9164

From: Gal Pressman <gal@nvidia.com>

Add validation to reject rates exceeding 255 Gbps that would overflow
the 8 bits max bandwidth field.

Fixes: d8880795dabf ("net/mlx5e: Implement DCBNL IEEE max rate")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index 345614471052..d88a48210fdc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -596,11 +596,13 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
 	__u64 upper_limit_mbps;
+	__u64 upper_limit_gbps;
 	int i;
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
 	upper_limit_mbps = 255 * MLX5E_100MB;
+	upper_limit_gbps = 255 * MLX5E_1GB;
 
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
 		if (!maxrate->tc_maxrate[i]) {
@@ -612,10 +614,16 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 						  MLX5E_100MB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
 			max_bw_unit[i]  = MLX5_100_MBPS_UNIT;
-		} else {
+		} else if (max_bw_value[i] <= upper_limit_gbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
 						  MLX5E_1GB);
 			max_bw_unit[i]  = MLX5_GBPS_UNIT;
+		} else {
+			netdev_err(netdev,
+				   "tc_%d maxrate %llu Kbps exceeds limit %llu\n",
+				   i, maxrate->tc_maxrate[i],
+				   upper_limit_gbps);
+			return -EINVAL;
 		}
 	}
 
-- 
2.31.1


