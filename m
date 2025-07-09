Return-Path: <linux-rdma+bounces-12002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3B0AFE933
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 14:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485C91C81895
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Jul 2025 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C850E2DCF7D;
	Wed,  9 Jul 2025 12:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yiv2+yJV"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454E2DA771;
	Wed,  9 Jul 2025 12:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752064968; cv=fail; b=Ts6S/v2DPsfybuAxim0Yu53oYInEIx7z/6DlCknSNMxwfRYzFmtswmgdcEZk+uH5A5c+FWpdR1LupfCl6zlZpcFIz+T9VCzJ9F9unWHcm3hQ+UwYf4AMmnD9Jjk1eW5A0Y77cgypMuU/PZOgxtCMPWNQ8zyz6iy4TG2SHU+xbmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752064968; c=relaxed/simple;
	bh=rPi2Jr2J30n47K/yc0D+iNNwSmRaBqzztN3xuW786tg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DkCKJYq1MIdiwxfp9cuLdiCKJiXN1Uak9Ajk1Plhmkj25uy++YNmYLerl9rkkgK3T3X/R4pJHxgDtH3rcCLC9K3z4aH5FDx5jrj7iHAg1qS5kkQqBuYqDSQuYjOQRqpVkeDIfLX1tpkkVqQBAeldN70hAwe512ngBe2RuS5+H8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yiv2+yJV; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q5TyFcCHzbYtE+lDQUY5Uo6C3z3t5GQ0pS08ZS1WCFiSkIIfOTYDryzmhhrDucq/yMLmeTsxvh38OzWS1QiNh7dbT9+SisJD0s7r2aZF/yfe2tMgSRYrFTvW4RBkMWeywnKqW4mHxYMqHShtVQymQqu5yoGDSXpQDVJDQ10cWMwOu/BSEHTje4nbyxM7ZW7IE4kgDvFWyKOtjSiVzDdHAhzkCPQ65ae9V67QlCBLYxiHhdbsNmSxaIMjk+TIqBBL8Hpd2w+HXVSmH3jOaLiR7IttveOwjY8U0iLTkjv39mK+p5wJZnccZtgf4PXLy2atMPyL+HliMe0t96y0ri63jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZozueNypQgcofe5tyAfPEYoR55zuy2MhIF/aMw2bL38=;
 b=VrR2f0xy7Usd7fNsOEr1lkvvY54MBX6gncSe4XEPfoeSiH+W59uvmc0ZJhIZ7OKdMW4GUaYivC7XzzlwwE/DfNopL/b6IqhPWQflVm42KE7KBCDfmiv9ZX59GaFTmX68gTG7I77i3GABBiw6IdCsibiR6opayBwXiGxNMDyxuICrSAdMI5Yy4WhktVaXxal76poXgy8u/YTG5wWTQFOBvkHvpFu3/2yLED2KrrIOz123XUGscUGo+0AGhAOVnSq6MEdu3wesI6LHzmzjBXw1EZ35vLTr4WENvdFo+zDYIw3MLpO3Ew3wZJNAFbFjY2lTJrn6MGrXz08nMhNwGApCdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZozueNypQgcofe5tyAfPEYoR55zuy2MhIF/aMw2bL38=;
 b=Yiv2+yJV34bKHnSuD0O9FHHiGSJABGpykAII024yrPc9iLf/IDjsjzurdgzndb//tQz059A1iUap8nGA8nJghfWAeBzq5FPKyNUUu3KgP6T+G2kXgXK02K6ziT1vbxv6e/CE7qBT/f3GJg4SHR4iWlwMhc47C5jOgfAaUWGfxVrJSeo4sujcwYWNfjPjpBi9nlipg/cREhhkD6rPANrRSK+pzGcrxsRNDRxUlF+8H/EBHnQlSRuNDYGeKDoz78brq1YcSrhh5URmanqbaf1HYVbALMHvWalonK3JkwmtW2/SQXNJ7cMiwp9Gu6nMDLBqQY/c8N8edp6KZjT2Vpp5dA==
Received: from BN0PR02CA0019.namprd02.prod.outlook.com (2603:10b6:408:e4::24)
 by BL4PR12MB9484.namprd12.prod.outlook.com (2603:10b6:208:58e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 12:42:44 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:e4:cafe::dc) by BN0PR02CA0019.outlook.office365.com
 (2603:10b6:408:e4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.22 via Frontend Transport; Wed,
 9 Jul 2025 12:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 9 Jul 2025 12:42:44 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 05:42:32 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 9 Jul 2025 05:42:32 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 9 Jul 2025 05:42:28 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Daniel Jurgens <danielj@nvidia.com>
Subject: [PATCH mlx5-next 2/2] net/mlx5: IFC updates for disabled host PF
Date: Wed, 9 Jul 2025 15:41:07 +0300
Message-ID: <1752064867-16874-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752064867-16874-1-git-send-email-tariqt@nvidia.com>
References: <1752064867-16874-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|BL4PR12MB9484:EE_
X-MS-Office365-Filtering-Correlation-Id: 7619e038-dbff-478d-2603-08ddbee61a16
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5KrQI8pBdwLvj0+F2rau8kLBCMJM0vMXkpQojWYQk8LXsb5Gv+hioH1Ncutf?=
 =?us-ascii?Q?bt8VgposN80PTkZeBJq4txbPxp8vyEqzgD1pqDf2Xka9MEdyrLZ2H9PsiYcs?=
 =?us-ascii?Q?QH7TTUZ8TGqiiwbwQBxKo8nAjpO36+AhMJkBRJwBvATDi4fb/t0nBduElVaF?=
 =?us-ascii?Q?Z1VGDkRN6u/kp8fGbBez9ULjb33JTUrqVG5cz6qIgRjs780wCRFVJ16iGYe/?=
 =?us-ascii?Q?TCgQ0ZNw2g+XA29ZTeakCc1pmhdKaUfg6qcc3EHSE8JaG4KEogc0MZ6sqy5K?=
 =?us-ascii?Q?d1jZvTTAClXRsEex1vkQUQQ8S2mlDfkWko9UDnSrRpe/EEHivELxj7Kce0t4?=
 =?us-ascii?Q?iiwDYAoSLQGQX5bagzl4s4ryK1VNj6S/mdZyqzBVfy808rPB/TClBB4dK2kh?=
 =?us-ascii?Q?Ob9KFMWab20/yC6/i9fPxRipwwBdetH9fYUrt+GuPWLlxsnfxGQ0BLT0k/Vl?=
 =?us-ascii?Q?c5Tt4ABb1ait/tsGHDQq25wrIWHinkAiE3LeKqnPDb8J37VKAOHruaMXtWbi?=
 =?us-ascii?Q?i94RF6gOLKUfBpdphdkTjcnLsvDpHZQ3ujyQ7JkZLuOm3jyROZUkidYcKaKW?=
 =?us-ascii?Q?QVwQObryGzrZ9/wKUh0oNPKvoiGzpgBKgM9K2A2DDTmowFwMsV2ljRzTsLqQ?=
 =?us-ascii?Q?TDlIsPtkLrWN+O3Xsq7LZ+ioVFYJGMWoKUK03RGgvfrthW3kcLfk4Pcthq47?=
 =?us-ascii?Q?zcVa32EVAnxdU7w6zg+DYWRR3E+JlzEOM+J5dE2twugguYENSOeTFG0mQa2U?=
 =?us-ascii?Q?5MLTtCsK5+E8W0T6jDxKPjSU2jCQ4hUVJ0WeMNyl8knwRoLosWFgcqlKKpBu?=
 =?us-ascii?Q?Vv06aXS+l4CbcnInrfOLS0K3PL96i28cUBqI9utFlP5NQIQNVXI20PuB+FEZ?=
 =?us-ascii?Q?kTh6l+SXsZnOkcJ+tzmFpVAGE1KaywS8SImCJ2Ab/Ho9wiXIylK5Dir6ypNP?=
 =?us-ascii?Q?MOJ0f0inVY0Uk27NJY4qp8vtE7WCKceLecSA1GhDmP4pJwOyDdFp8g9EnpHg?=
 =?us-ascii?Q?xhOKVwxPSyAENsTBzy2+WVB9dlYRPi81vawylOnDhPt8T0ljcZHHcni9F2cL?=
 =?us-ascii?Q?0SAEMy8rFRAIM9yCHovy1KMCqfRoGGlzYSDsZ/22jzp/a3Pz8vYWlAn7T78M?=
 =?us-ascii?Q?eysOGhXLv7dIbkS8quQQS0EP2Zw+dntkkr3LwmuGvbbT7GE+c1ThnuXCXnca?=
 =?us-ascii?Q?U/9ctowIZm9VheJxhdyL0kRw+xs7UW1Dg1/ttkFPlxNXbiaadiaBkBnRq2Nx?=
 =?us-ascii?Q?8868bwgBMkvLOqw+LWeFpeiHBJCGjwK+cmLnZyNY+zh8YdiIE+w5vpzLwxwd?=
 =?us-ascii?Q?BtzY4deQt11ye6rFdVrKbRsdgmulyO3MFF4ML+jjRawRtH8cLK8jw+vsVixf?=
 =?us-ascii?Q?LX3Oc9EI1W92JBep/O+K5fLTS22cYYjj05O/kksEoOV/ulUE7zpXcUEsmSCL?=
 =?us-ascii?Q?mY2CrSonUMx0Jia2zZ2jzMFSj0evD56xoIIvynKI6VlFfaMu9UAQdj5WUs6M?=
 =?us-ascii?Q?J24CT4ZWAeDPCMFrbDF0Z1A+7rIXSnWaGyXD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 12:42:44.4119
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7619e038-dbff-478d-2603-08ddbee61a16
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9484

From: Daniel Jurgens <danielj@nvidia.com>

The port 2 host PF can be disabled, this bit reflects that setting.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index e03fa6cd4509..8ff408cf40ed 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -12381,7 +12381,9 @@ struct mlx5_ifc_mtrc_ctrl_bits {
 
 struct mlx5_ifc_host_params_context_bits {
 	u8         host_number[0x8];
-	u8         reserved_at_8[0x7];
+	u8         reserved_at_8[0x5];
+	u8         host_pf_not_exist[0x1];
+	u8         reserved_at_14[0x1];
 	u8         host_pf_disabled[0x1];
 	u8         host_num_of_vfs[0x10];
 
-- 
2.31.1


