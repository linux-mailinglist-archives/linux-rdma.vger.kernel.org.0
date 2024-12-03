Return-Path: <linux-rdma+bounces-6209-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 680DE9E2D1C
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 21:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283782830A3
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:30:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE3EF1D4348;
	Tue,  3 Dec 2024 20:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QmWe6JGl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2040.outbound.protection.outlook.com [40.107.244.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C57F18E76F;
	Tue,  3 Dec 2024 20:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257828; cv=fail; b=U4Bz6XE3btBy8tyWaHKhI96VSrvLCslketRYik5wt45H8VkXZax8Hb8OZoZ/w9he6t1e11cZkxBicGGBwkipB07XUF2Eb9hTiP/wasp6ZrhEHNaXMrZKV/g1qDuM4MayuAVVH7k/peHt/9+CygX6IF0c/bo9Zkc6OQApzBKMIcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257828; c=relaxed/simple;
	bh=58hw4nZl1mQmhDedbbLKowV4upMBJ3iMauLTCB0OWqk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pDEBBZFmaB9uzG41oqI9QI++dz4H7ttpMAee8y/rxfcfBCScGGMC60FpFaWCvCROVu7uLjAHKVJdiPyLxXrZBmP1A7jadwX5mEb5IvQ6IOHso7DQMJJOQhfSS7ERs9W4a/XQVlMRhv8mFHVHVMX4MoF/LfmAMc2CJ0HSjKH1deU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QmWe6JGl; arc=fail smtp.client-ip=40.107.244.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GydClp25dYqRVX4SxhMeYwY5BoWg9YZzJUkAxyOKiSdx51Y7+b8MDGUF0O9m9bqRsV98pU3Nwn+tiJohw2VrY55zojkcM2ho+oMvHB6Wn+HyCB1RQkevEKf9K4mt2inIO3btclBztOS+cuTO0WhZvM18TaW8Z3nW4bIVJnLYVAzBjBWhr3MX3A5zg4xoRx8Eby+2danaqMW00j+uDPpjFhtMSOh78Np7VyGEq4lh7F5yus7enD8EX7Xkke2fA3eIBsc2RnUc0SV4Kv9O84EH7AVVcxcm0O6gMqJ2lCh/kh/kQ3KHf65nPlrFud2Bfh092BcCf+L8PsPDTgAiBrIRlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=48ODyl+gnmxsnZ3y+s4Sfga1soenzCmUIvVs88Iv2z8=;
 b=JNWcjrodhCyd3YzmFAn4a+O2gdEigEAPSeNTMY3/5SrqYwPIFKAceBAK9AWhmntDae+ezHy1Cqsbr8zMjVSoSL+gt+VtyRlP4WLrPG+3dErS6X3nQYBSBW/13mKccjOwQL0V4PCBP1qEM2U9obwrcq2jI9mUsch2vgz4SGLqWApNx/A6GLFHSRV1zmS/F5dxObhXh4k89w09oNXnLw5XpGvwPa5dkiO2/V8VlGZpTa2diaFtZy4Gp4bva7CCiymlRwNidAkfyPTQViOVigZspUSdNxtLBAw4VEtE9ieKjSQNO5pqoPkFukcIpDzFTV/KOQcRZuqJje3spJyDOkydsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=48ODyl+gnmxsnZ3y+s4Sfga1soenzCmUIvVs88Iv2z8=;
 b=QmWe6JGlYg5DMseQIKww2Rnm9KfWUJkzac7o9RggQdboB+z1cWAhMo/WR2Os7882Rji3Jeci1uQMIuyGTEIGRNnI5O/dACv2lOUinm2Z53r/p93owBHACOFcKUBVxTK2QQYMwrB+ifmoa8cwvLm+gFL7C738jGyiGlp3wxAz9k1qZ2sGDPQ75QJjrhlW2KBtmpBypXLsV+k2PmSDmBP8Ycgb7BITiDvtmlQL+6EYkqexR8qlKrXKfG/wVPpLlJ/nvqNc1Z+QkgMlI3dnY+0CpMHvYenhVL4fQIvPOFBeskSr+rZz80KEj/TWlomQqS8ffED74M4184M0S6QWoD9c5g==
Received: from MN2PR14CA0019.namprd14.prod.outlook.com (2603:10b6:208:23e::24)
 by MW6PR12MB8663.namprd12.prod.outlook.com (2603:10b6:303:240::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:30:19 +0000
Received: from BN1PEPF00006001.namprd05.prod.outlook.com
 (2603:10b6:208:23e:cafe::b6) by MN2PR14CA0019.outlook.office365.com
 (2603:10b6:208:23e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 20:30:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006001.mail.protection.outlook.com (10.167.243.233) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:30:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:30:05 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:30:05 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:30:02 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Yevgeny Kliteynik <kliteyn@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>
Subject: [PATCH mlx5-next V4 02/11] net/mlx5: Add ConnectX-8 device to ifc
Date: Tue, 3 Dec 2024 22:29:15 +0200
Message-ID: <20241203202924.228440-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
References: <20241203202924.228440-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006001:EE_|MW6PR12MB8663:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b537856-47ad-474a-47f9-08dd13d94da4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QdCdBVugeqIlLDkN8lAZDuh8qkK+LwTWEWUORSGqpjcF2GyaSIMvvsaur0Ik?=
 =?us-ascii?Q?l0ps30PjgDBa2PRSNMfu2Azm4byqVFfZKRbtsJyJFsYcAMR3Hh5mDn311Uxw?=
 =?us-ascii?Q?oaLbJiCYGiuVTRt+qtoorf4SAEojakwxu4qiYAFNzqrTMH384o6ccdqt9Lnl?=
 =?us-ascii?Q?ZfiTJveiThSxey7jas1A6SVcgjfEFwMnBS+MOQAxZASOW0x0hwYAJpkIpzrv?=
 =?us-ascii?Q?yFLX31b2odhjEOGYBt1zIn+Fw82M7pC26QvGxqXaKhEUhtQVmbOJ1BXQ7Qup?=
 =?us-ascii?Q?1MjhMwl+nqzQe8E8IOkynUG3iImFNOKK00KRZyaKqi/TGoQb4ytXEJ2yL77I?=
 =?us-ascii?Q?cZPOYArT0+3deY9KIjIuC1JozgMAwUCA04O2SvfNlqxrMzC5QL3auUf1PzLm?=
 =?us-ascii?Q?b6klK9oDb5PjXDmUcMC5JE8+pt6lSmAhFGN2G5+ZOsZOSqjSMPoqmvm3hYlc?=
 =?us-ascii?Q?hew9ObtN69zBWEmDsUAhWf7zLIWBNNwHGOxhfgBYc85VXqQWjndofJOENn0C?=
 =?us-ascii?Q?QtkGTrOvunGp8h1juJ4eA6EiXFl6rMRngqmoFKE9g/3uOiooduBB5tMytPWR?=
 =?us-ascii?Q?vEhHw+1ggWMsfaq8glsfYHi1DFG2I71hIb4uQDAhpknxEk1RTiZnIuWtOzur?=
 =?us-ascii?Q?gcY6S9xpntbzYIHpM8ZAgNkvNEGqqU10RY/Lbc+Xy0B9r04RMC/0mTNVpw1D?=
 =?us-ascii?Q?T0nXFm5SzjloNK62QDN/oS/8R3DGjsZgTHZ3Z6OlbUx0kmcH79MwCB56US5N?=
 =?us-ascii?Q?dRwvozYRz8OTEBL+KFIHvCiSQ+3wgLkq2vR0UXA3aZuJb9zmINgIl8szgXyt?=
 =?us-ascii?Q?kuwyY+/avJRLC5vRMshAX2HWnpL14w28pr7pafdS7Is4hSbRAKeIhUjKAirp?=
 =?us-ascii?Q?+BS6jOfBMmvGF9hVVDzJJ7tXbCmQ33J6wGFU24goJ74bJGwSfZU/OP22grgY?=
 =?us-ascii?Q?0EnOnPjnZGwtvNB8qLlNuD4bT+LaVU31ljmwmCep6/VPmZNGmb1+Bv+cMzEh?=
 =?us-ascii?Q?Bo9noBabPFj5/xqH6ckjoh8vENmwjhFBdpo+X2JxkO0+3bB5vtDPboM/AFVB?=
 =?us-ascii?Q?UvaW7kBokPl5ZAADpoUY0zITIGrP+K+20g16iLC4iAqNkBZZCBdoaeEcZXdh?=
 =?us-ascii?Q?+cAOXoaC/R1iTZnNniGF+q2ASM6nNCRfTdwtY8p0hNwog/l+wLRMcWyw+M+9?=
 =?us-ascii?Q?Ly0p5Ah8U3m2fSitKOzmTuGj06OMtOMHQwVSAgG72fPLqt6t0chQiFfJ7rap?=
 =?us-ascii?Q?J/ElS4ZHbZy6PEqJu+GtPXN24BECQ4JykuKITORmnpZUPrPTqd0Fg6nNheyN?=
 =?us-ascii?Q?7d2dTjHbBqH8cshWHD9UtnX26+8VFomR6fbMTpjvz8c8Ks/OI2RTuYwtjKuy?=
 =?us-ascii?Q?dqqyqvTCppvOwN3pMsFYpmd4y+a5vZFFpQTQI5ta9q4vYVDiFIO4FEtHXEim?=
 =?us-ascii?Q?o3kQtVnM2GpZEDB9DgjEsQb/JPsKFeNB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:18.5890
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b537856-47ad-474a-47f9-08dd13d94da4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006001.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB8663

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

In preparation for ConnectX-8 SWS support, add enum for the new device
type.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/linux/mlx5/mlx5_ifc.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index f3650f989e68..bd9b1833408e 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1590,6 +1590,7 @@ enum {
 	MLX5_STEERING_FORMAT_CONNECTX_5   = 0,
 	MLX5_STEERING_FORMAT_CONNECTX_6DX = 1,
 	MLX5_STEERING_FORMAT_CONNECTX_7   = 2,
+	MLX5_STEERING_FORMAT_CONNECTX_8   = 3,
 };
 
 struct mlx5_ifc_cmd_hca_cap_bits {
-- 
2.44.0


