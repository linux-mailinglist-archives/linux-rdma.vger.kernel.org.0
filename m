Return-Path: <linux-rdma+bounces-6940-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AA417A08180
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 21:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8716904C
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 20:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7EC1200BA8;
	Thu,  9 Jan 2025 20:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sez54/em"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2047.outbound.protection.outlook.com [40.107.93.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06B01FF7DE;
	Thu,  9 Jan 2025 20:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455441; cv=fail; b=ZgLTdFsEHZhmBFdT4gEJUtyDYPImipOMoFc5vk7j6vYY8rSruB7sw42xOux6U9Udwcw9ykY2AvoYDLdSrIeVP8TBSbHe9N2jf0f7Z6tBkSRICFMiK5ZLjIJU5SYenD+PqniQ4PKhOsKzzEloTHHQH4Iwnk7uXA3uabazMk3r0rQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455441; c=relaxed/simple;
	bh=ZFy1yur5eojcuhQjcvjLb3KWa6qpH9zFPfXfuNM84tE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CFAxeq4s2kluDEyxaCEzkxuncfMSDsPAEk+pD5MH0e5QF/JF5eIL7IKDIlko/wAUZJRohtz46Y8RyTwduVdP1Zk1BkuBE/EgcCFAmU5nH1mwHQJPYCPkqk6OxrhvcTaS4wQxu1wJCXxuNyZVVa+fNmyhsVSz2kjmPa5Qedqv1co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sez54/em; arc=fail smtp.client-ip=40.107.93.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bERqfXQU2yeEfV310iKw5c9PS+rQpqMGRPNbNRPQjlGCR5sq28MhTNzPakFoE2QMoXxGWmiQ9ztTxOviU2s8EbgaDMjVVzGsnnpDAMtyFeiHTGLx5l/K0tGnKdykvzmFjy5jdv33R/IDCc47blwZ9kGb/TWl8brcXGPmBbjUMVAScAX7EgWYb4pjlExsBnRfAHs4MHA18AxnH/pPhq1iSzEi2AD5SI1WT/RKbzkyj0gkcvAH7Pns/bqiUlsy4dakE4eqognoJsJISnVbZyubay6tWiRgBNZs6RDoDicwVxkvspLGxkOWpPxKGMUIQ6laoRp/x/4cDOeXATkTo3xzQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FezVwni3vlIURcRL9piWm80PnEJEB3qPrquEx+qREcY=;
 b=d9kmVqy7bff4nYTtDPMukDjk88Xf6vLm2m2SgMpauVYdbdHsWLLtrDbDJgFfeiEVU+TCPXs12NAQV2eHg+rLKAWACGOdPNoqyV6XEpK2x4zRv4FBeKGSLeLOxWU8wCruMxq48D0AnWPHc4EFzw4lZqddv8RBPrJZbTNb/WtlXx0RrjLyXgkAYpo0l8WzsoWIdNZcmhcDL2uWR9bwcwANh9sElXwqXYtWQqTQB2mxpgf8Rh7P22yT1kA/UHIzOeK53fcBxpa/AFiousblCu+E31bMy3BcdlWOClqQMf+weQRnFKrJZvzDA1HVtzyzII9He3Haqz11TFGAteadSFYnRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FezVwni3vlIURcRL9piWm80PnEJEB3qPrquEx+qREcY=;
 b=sez54/em8p27lYlgJYbt3SuF+75TEYBfqIjCCtdFHkORfzv0tQ+rhMnHQ6E/J7boPdTk/TuK1WQjIv44XI5nVfIw8lHvIYCkgzho2SqY0hJYF39FhkUO0SStVaqLwP3LivmR3TXADLfHdXGyMLFPCZXkRwv9w2bPwUwNpnQbYbqH0yP+/98PGm0BHbNVkgVeIdjNBFu8xPpEoiChBrsudtGRaWviCEr8ZyoA7oqEb4UnfPaG7D67P/m9ji3lXiuEvsYcbtna3T4RDanmHom2GTUMM2zab6Hm5diPLhvzlZ3Tey6XVY0ImR60bovnUyXynSPbGlvaEr2LZnDss6EyfA==
Received: from BL1PR13CA0241.namprd13.prod.outlook.com (2603:10b6:208:2ba::6)
 by PH0PR12MB7094.namprd12.prod.outlook.com (2603:10b6:510:21d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.12; Thu, 9 Jan
 2025 20:43:56 +0000
Received: from BL02EPF0001A105.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::9f) by BL1PR13CA0241.outlook.office365.com
 (2603:10b6:208:2ba::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.5 via Frontend Transport; Thu, 9
 Jan 2025 20:43:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF0001A105.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 20:43:56 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 12:43:48 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 Jan 2025 12:43:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 Jan 2025 12:43:45 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 1/4] net/mlx5: Update mlx5_ifc to support FEC for 200G per lane link modes
Date: Thu, 9 Jan 2025 22:42:28 +0200
Message-ID: <20250109204231.1809851-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109204231.1809851-1-tariqt@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A105:EE_|PH0PR12MB7094:EE_
X-MS-Office365-Filtering-Correlation-Id: 2415e067-48cf-4fb8-ecd5-08dd30ee5657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mb1XHGp+bfgJHTkebYTVC0r0DmJbZzNfYVdi2Sh5B8vGc8wnyvJ5SenKe+GH?=
 =?us-ascii?Q?a8eeLs4+/U9LrhFEr2a8RzjbqYxefOa2pp7GWHIHCwAAh1KNHRX8GFTXOOHS?=
 =?us-ascii?Q?LENWKj6VgkeNHUtxbOoGwSGIwuLyV+uR9p4t8TJv5vgh+5cYepVYYqTCrCZG?=
 =?us-ascii?Q?+X1nkBUa1dbp+dNILDry+gpbLhF6rG+D/5WEVig7+48syH0OaWwqjohQV/UW?=
 =?us-ascii?Q?/zfctJGvePZXS6E+3sVEa5Qq5v2B15efyHmYMykPOr/+7DpwEi72yYMWZteK?=
 =?us-ascii?Q?vD86z0vHcElFu6eKYt3w1UhDcM0xiUrtpPWVuTHjuuVtE+r2zhI3vneL5pMl?=
 =?us-ascii?Q?pAbrj/phxlEthEOWrn8ORrMvXwNEcOMdEkOv8ibDbodRbrNK5Q/MRtpAs8Ws?=
 =?us-ascii?Q?gXIiPgXsvSTyInVb4GhwYuhH1G1ShusCQVsUe4FXnWNIVWEleBhgjSCNyTqH?=
 =?us-ascii?Q?lTRxTyf2ATy5BrxET8mddP0O7lAwMkcrPJszzXpYoUD/bbxpH0xeXFqGWCKY?=
 =?us-ascii?Q?y/WFz5lGyM9mf3dp70rMY7ZOkUhMjL//uVIx/wiKvJT8L4gI1FG2tTZJKWmk?=
 =?us-ascii?Q?+SJUhJ3/PtfEYSFb9cx374YqRMK0/XZw3yNmd1FljYu73G0IhpzJnAITIjR6?=
 =?us-ascii?Q?WTVtJLBG0meTKUAQZE2jMndX4umVwyArbqeIvFr76FZ5rppwFoEuDiV3+6fG?=
 =?us-ascii?Q?seKAiMyh+97OViMJ8wn0/w0Y0SdF11q1ICFNzleSYyrthkkaRFiRs8SUtK+D?=
 =?us-ascii?Q?AEI4iOHf2hAjGg2kPaGy9WrmIo80mebQFS1JsFBdbEslmefhU+whR6s56frU?=
 =?us-ascii?Q?e8hcNKbsrdC5K7JT9ZvbiYNjubS+3VeUwHH8voD5hQpekRc+O0dgTMbiBULB?=
 =?us-ascii?Q?BcVzX74TjqW2AjOQrZvb85s+Thf5isOcfojCyuW2PTvRNVcD/vmIcd5xq9LU?=
 =?us-ascii?Q?JH+i00sF1LIA3DP4Jnf5OGgtemqH8mIsqw3Zbpn5ck8qtFS37e0qo+I2GNEz?=
 =?us-ascii?Q?l+Y0lXyPxtQkZuEg0gsXtWgNmYVOW9ZJmdzDawFd+J5iiGq7/ZqNL+vlq22n?=
 =?us-ascii?Q?BXJ+1G3/aktfH+w2rO2pBPFQ9dII3VC6SuH8X2UumgpFyCQFRxqJ6E0Z8emS?=
 =?us-ascii?Q?LHq3l9wPMAOPDP8V/Tj/NiK/l+HO1erBID/K637alliQIS9pLvetj2wVrRru?=
 =?us-ascii?Q?d5969JWiBmORfp9R+DOZoHepn7pqjmjFlyKjF0rO+HUINVsKO+ErIBKPVHNm?=
 =?us-ascii?Q?iFYkQpg+JWsmUjGV1oEe+2c7HczLoc8KQOdRpKgiVa2AV7l8HO7nLUEKcvXm?=
 =?us-ascii?Q?Us1HHr5E52faoLtpHnyIj0UjnKA0gaTcgqDXsOpNw4HPBuudvSrbz8/Nom7u?=
 =?us-ascii?Q?cMhcYZQtfTjcLoMdi3aJsSqbPivJMHU5DuNFvEWHXtsWOtlk6XbS4fDlZ3I5?=
 =?us-ascii?Q?3NX75T5cXuQusZkNh747D81Zp9WJk7MbVvmplnl1RURhQcCk2A52R63FMtVs?=
 =?us-ascii?Q?A7r6XgHJPDfelmg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:43:56.3712
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2415e067-48cf-4fb8-ecd5-08dd30ee5657
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A105.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7094

From: Jianbo Liu <jianbol@nvidia.com>

Add FEC admin and override related fields in PPLM, and the bit in PCAM
to indicate those fields are supported.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 43b3cb4bf8d1..c3da1581853c 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -10150,7 +10150,21 @@ struct mlx5_ifc_pplm_reg_bits {
 	u8         fec_override_admin_200g_2x[0x10];
 	u8         fec_override_admin_100g_1x[0x10];
 
-	u8         reserved_at_260[0x20];
+	u8         reserved_at_260[0x60];
+
+	u8         fec_override_cap_1600g_8x[0x10];
+	u8         fec_override_cap_800g_4x[0x10];
+
+	u8         fec_override_cap_400g_2x[0x10];
+	u8         fec_override_cap_200g_1x[0x10];
+
+	u8         fec_override_admin_1600g_8x[0x10];
+	u8         fec_override_admin_800g_4x[0x10];
+
+	u8         fec_override_admin_400g_2x[0x10];
+	u8         fec_override_admin_200g_1x[0x10];
+
+	u8         reserved_at_340[0x80];
 };
 
 struct mlx5_ifc_ppcnt_reg_bits {
@@ -10524,7 +10538,9 @@ struct mlx5_ifc_mtutc_reg_bits {
 };
 
 struct mlx5_ifc_pcam_enhanced_features_bits {
-	u8         reserved_at_0[0x48];
+	u8         reserved_at_0[0x1d];
+	u8         fec_200G_per_lane_in_pplm[0x1];
+	u8         reserved_at_1e[0x2a];
 	u8         fec_100G_per_lane_in_pplm[0x1];
 	u8         reserved_at_49[0x1f];
 	u8         fec_50G_per_lane_in_pplm[0x1];
-- 
2.45.0


