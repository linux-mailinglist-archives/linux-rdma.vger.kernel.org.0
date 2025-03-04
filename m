Return-Path: <linux-rdma+bounces-8325-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A86ADA4E64F
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E52641B41137
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33972298CC8;
	Tue,  4 Mar 2025 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rbcDCoU6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B9278175;
	Tue,  4 Mar 2025 16:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104423; cv=fail; b=jM4DNR4I13kg55bE+QDlfbev47wpUD+PJ0g7Woi+8oyoJsDfcGkcqI4r66fQX9LiMciw213nwxydsI3fHoo84c+mQGePUsrwqfHg+C49w/6mfmBzyFJAHtatgt0+Zweb9yPep45JFoK4CRTa4ajiTCLCstHbmPJvvPRcXQBvG7E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104423; c=relaxed/simple;
	bh=h04KYfo7IA662PJfAt6zE9bIY6RolFmn442P0cPK02I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UDu4baB4r0f0a/X7DTEcG/NL/YdisWSV7/+wjSeE6u77m4ySdO+vtyJ428PYbP4mR0Ua6kwpimo4CCke2m9g63A0fS9ac4xwq/6zzsJlHDx6PtYGz2nWMqTqIhhApvVQbmNi18ta+ZIgreXtoHUw/8gXqmLfLxoUmGzjv3l4VSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rbcDCoU6; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yc2DEql1hNwuRqZO/3GlYBu7q2EfT4wt4ivfSBtIv5XbGFLdxTCiH4ywe0gnMIHjQohTvyQlvVtevBry287gHlsg0X+meik4rfOMzCDgiybHc/qIJzxqK+Wg40F8Y2/k46Wn43YO5Iu4OxOpy4zRG3YgwbVljsPLPORpmS4aR587jXR+SwO+hjeeKqsV3ZGgOcpD20Vp+kAZcouplHAOUDHoW0tCUAngiMThfsj1quEqUulC8TRNr9HGaGEn9XfROgOvC7iGZBGv6YRtAeVinNflg/xVgJgSIRWohb9ddxEFsmRKtsV6HJwYan3C93N1pHzSFMG8CfCJWGdCblASfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S2siwFWjeFWuewdZwNSQjV0XTk8BHyZuIgrxMH9MEno=;
 b=M4sdOuHR8lgIhCziMnnC+gLkhqp42nn6wJSzzyAcBkj5qFJ4iimDANvFkAyV5+gWhkSN7IKSAt4B4NNQ1/fo3OurIoFO9x4Y6KuF126kQLn2esTft9msmPPIcROGrpsw2Mb2T+DVm0MeXSCXiR/Y76jyx/aVVwCgvvVfakAlq66bc0meTQFDhoALP+H+Rlt/I1o4FAkSXCW5ZNUx8ZO4pm/hNld1yrHD0DNd+j3+rpFTsIECXhjXN7rtrd9EOiJLdeE3T0781QMarYfKQPAIc3UZMPuiCMh4BWj2yDqLOMN+VZA5mZ92RqSPO8lFKNo7nr/hEiUd1IrEPU/uZTXX3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S2siwFWjeFWuewdZwNSQjV0XTk8BHyZuIgrxMH9MEno=;
 b=rbcDCoU6A6zpg5HV1Rukfsqz8im8cM2/dJeBrZmKVGmw3+vKlYeUSkrSDH7fcdmDIRa7+AhxgbwKVBVEFv/7u4eywbMq0HYajM0/oOCZ95nEUmBie5M/oVSfVzO/srrN1SL2pc7hv0B1/Brvsh/TJsHMU4yhj0bahMxakv8Vg4qrYUFSDVRDWlo1kBUM0dTSu5SGXQdexSZeppbdnIktys2XoRi/gmbyFkv6Mc82q9s88dHtoMIarr7+aE6dXfyayHRQRql53MkSU97SYOgBUonlxDA5iZvo9YdEzq+/EQU3L9V6ijjd+Rv3TMETxlzY5HPM6bMS1CRQBiGw7h7nRA==
Received: from SA0PR11CA0130.namprd11.prod.outlook.com (2603:10b6:806:131::15)
 by IA1PR12MB7592.namprd12.prod.outlook.com (2603:10b6:208:428::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:06:58 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::e2) by SA0PR11CA0130.outlook.office365.com
 (2603:10b6:806:131::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.16 via Frontend Transport; Tue,
 4 Mar 2025 16:06:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:06:57 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 08:06:41 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 08:06:40 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 4 Mar
 2025 08:06:37 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH net-next V2 0/6] mlx5 misc enhancements 2025-03-04
Date: Tue, 4 Mar 2025 18:06:14 +0200
Message-ID: <20250304160620.417580-1-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|IA1PR12MB7592:EE_
X-MS-Office365-Filtering-Correlation-Id: 630df9a7-9ff0-4f4a-5313-08dd5b3696f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/OWj23Tt+yZy7Btr/tkwOjblKOHQ92Lq3HsnRbqoTDDIVvlZKG3TxtGwpY2q?=
 =?us-ascii?Q?ayAjrDqjZshdYEftxqSQNG4bkkba+MMEGkuXIDzZILDIA+hvqFRnH9/mC8k4?=
 =?us-ascii?Q?CG1sebrB68Ih8YmDmlkriX4tkavBfWdE8RwS7spDCgeFjcxSfKL4S4bItBiK?=
 =?us-ascii?Q?WCDRkfKqNh2D4YFL+ThbW50cFwVWkRpF9xbwihMwXALXxFs8x609Fz54RokK?=
 =?us-ascii?Q?0U8J3KZioR29bSAoXlVIoivCL0cGuHqaEPG1eX72Q1DHlGQ+F3f4DdmSLeLx?=
 =?us-ascii?Q?DwJSFTeRBDXvpl0bdSLHhp2Hn6yjiUih4Iw12e/98j4+oi4oLQaQuqU0g6fg?=
 =?us-ascii?Q?YCsUa9BYlIjxqA0USY43C3uArlMYSu1dH+rBAg1ZkOEyjfPYg7GeBNOeEtf5?=
 =?us-ascii?Q?xcgvVmVIrP9epKnjjDnxvLGVxo1vLbUbgwxMfW4UZCFCvXrZ/ynDBtxNaU37?=
 =?us-ascii?Q?Vkk04sVOz2geVMkfMoaJt9yEvmxRUUnAMCGBwb4GYv6XcGyOHe3IceuUUt6V?=
 =?us-ascii?Q?RyV7KZaMjz5Z435gq8GREs0I2ngm+qP1mVh1ZDUxxuYYYZEE+Yqx7gGP0b74?=
 =?us-ascii?Q?ORXAr1e/W1UWde9Pkoaj68Xbh7yoYNAS8wUxBj9UObLJj2UfF4VS0hrEsh5N?=
 =?us-ascii?Q?YIgRTMTG+Ylp71Z8qNV2XDsuJ17+F52jQky5pma0Q17zNi5KMCq5bqXkAbpG?=
 =?us-ascii?Q?RfFJo0Qjps06FsOznnnu9fApbfDW7PZtAmNC2bEXRXfid5/AtmivPStApMSz?=
 =?us-ascii?Q?gZtNWPg7tdT7zuZ2eSeALHRH8VHr/MUmw5qHOQt3SkM/PKwbypNJu5mGvFr7?=
 =?us-ascii?Q?w3g1yrLXmIzlVdDQB0s3UrUJSQqK4EXWPb9VdpVSvXUJbAgPNMpgcjj+FiY/?=
 =?us-ascii?Q?Hm1i4+CTdofvstChloSe8/c5HQ6D9jioL+JVfWRnRK0NSaIlQuQqcMnt9Pyo?=
 =?us-ascii?Q?HVGd7jfWJ2L7ntJG0m1VBhpbX0TtoMDS9o4SPPgANlIhs9+siHq15UhSfnOa?=
 =?us-ascii?Q?Lo6MQorKFif5k6gcxrHEKCONmj1N6sMQM9EWr0vqEPrAr60/blY8OCIE5V0p?=
 =?us-ascii?Q?6qx88/DJV0roG+Q6dSdpVXY7XqII4LO6Iz2clbZ8ukyjq0iQ1uP9PB3+YPF+?=
 =?us-ascii?Q?THy72U3TqZUTTZZLuJ8cLeeay9s69zKjNn62N8s+k9R84ZSUl5GpqXKONBV7?=
 =?us-ascii?Q?+5N208zHUOkF/n+QaEuvsE6sjKciU4JuaRND4wRIpX58uNaMor9HR35ZR8XJ?=
 =?us-ascii?Q?xFpyWHl3aFeqFqsqUDaM1diX+QVTJndlm+yAeE/6DS4VoIziIkuO/k6C8gTN?=
 =?us-ascii?Q?4EHHWaHtqjODk0Sm0qkCUI8XOtHyl+eLhaZBcErDVKy9HNHp3aw2+oDoqTkU?=
 =?us-ascii?Q?srzGHItHsGkr48VcuWkZ8NX0WMpyjU6G0MTFN1vyKqsfXZWBYSwxYSafEtDd?=
 =?us-ascii?Q?6JKDkzl9aBBIY22sQJMwlwMLC8xxsrFWAeHZPM32JfsPCKpb2e4DtHp7AWdq?=
 =?us-ascii?Q?b23j5C8pPOOQmQQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:06:57.3740
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 630df9a7-9ff0-4f4a-5313-08dd5b3696f2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7592

Hi,

This is V2.
Find initial version here:
https://lore.kernel.org/lkml/20250226114752.104838-1-tariqt@nvidia.com/

This series introduces enhancements to the mlx5 core and Eth drivers.

Patches 1-3 by Shahar introduce support for configuring lanes alongside
speed when autonegotiation is disabled. The combination of speed and the
number of lanes corresponds to a specific link mode (in the extended
mask typically used in newer hardware), allowing the user to select a
precise link mode when autonegotiation is off, instead of just choosing
the speed.

Patch 4 by Amir extends the multi-port LAG support.

Patches 5-6 by Leon enhance IPsec matching logic.

Regards,
Tariq

V2:
- Added Reviewed-by tags.
- Addressed comments on patch #3 (Jakub).

Amir Tzin (1):
  net/mlx5: Lag, Enable Multiport E-Switch offloads on 8 ports LAG

Leon Romanovsky (2):
  net/mlx5e: Separate address related variables to be in struct
  net/mlx5e: Properly match IPsec subnet addresses

Shahar Shitrit (3):
  net/mlx5: Relocate function declarations from port.h to mlx5_core.h
  net/mlx5: Refactor link speed handling with mlx5_link_info struct
  net/mlx5e: Enable lanes configuration when auto-negotiation is off

 .../net/ethernet/mellanox/mlx5/core/en/port.c |   9 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  81 +++++++--
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  35 ++--
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  95 +++++-----
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  47 ++---
 .../ethernet/mellanox/mlx5/core/lag/mpesw.c   |   4 -
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  92 ++++++++++
 .../net/ethernet/mellanox/mlx5/core/port.c    | 168 ++++++++----------
 include/linux/mlx5/port.h                     |  85 +--------
 9 files changed, 342 insertions(+), 274 deletions(-)


base-commit: 05ec5c085eb7ae044d49e04a3cff194a0b2a3251
-- 
2.45.0


