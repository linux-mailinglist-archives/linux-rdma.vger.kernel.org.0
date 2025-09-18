Return-Path: <linux-rdma+bounces-13467-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3F0B834A0
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B758466583
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 07:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EED2E5D2A;
	Thu, 18 Sep 2025 07:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XW4WHFp6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012046.outbound.protection.outlook.com [40.93.195.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4249923315A;
	Thu, 18 Sep 2025 07:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180005; cv=fail; b=BAwyE4fSgpjhf+xu/8HiGdQRB0d4TUfC+oRgnrvXRpdDRZV1S+QxzOLNjvjLupW0OxvixkA6qtsUImWEslS1w7a11OC3gz0MgjzXBJ1xFlLQxpEShA85Vgt8ISEuxxucUJ2/F2mfVLGkbFQ1RmszW5te4qtmldrRogkSKHamq8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180005; c=relaxed/simple;
	bh=bzAvJQzOjMa5QvIVP18atlZuoYHA7Z+euyTLnn/va+E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ia9uH9jvUqXCJmd1RMgUAGI4KBdVU4z2RhBIuG5naVJUMQ0I/A0uYDjWW4FAvEIrWQaLB/u1fBjwTP0Vhcg/37eUQ7wRIrY1BnJKyQX9WCSlFS7+7pUxee1mKhITBCZA7vkYugbQgsj6S2/VhTj4tLJqpWUvFaFrhdWQ+s93ABE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XW4WHFp6; arc=fail smtp.client-ip=40.93.195.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BUkUwXpI0D8bMoLA74W0XYEqCii4QB53s9Xf+Z3874SSVP0bwX+ZWLu0AvdUtzDoBTEJoy1HKa4k+QPnkxjLoCu606YvWLfp8NmeBzUMn5UbRa25jqwjzdnMvzXOiwcAxd0Csw+CsuvQfw7Mm1ayTPTnEV7Sm2aFagj8zLhlyZlg1ibgpPUAyohbmFg+jOhipKMaDvixqj1nh5DvF2kWH0J2oRQzM0y93eNzkXfo4WSqB1PKFFux1xErkIwmUwu8BnXQTfNby5BraP6EcIpXLtjYaWAdcWFfi/zOR/aPuWmGQqW1FkYln1XCcriwdkudoCZdCmj2bV2hbqm1Yc+YDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uJa73CakWmdXp4E5fyydCWIx3ruNtlj6kzsevlU7Vzc=;
 b=uFY5bOtZ5wJZ7bBw9wUYThSSLZUBpwNhAleBRtOmVjzBY865llW9wiv7bmdMXCk+fZz/J4NHJ5uwQ17zP12iok8zCd3KTNiVwrefPIUKviVHM63N9strEp4VjSDL5CJyIfi3nfBGrIHZymuubuGrK7bjuMPEK8eBridusDWe5gKX+lMAbH4y4GCrRErK5dN/zblqKinCj1oqu014lIL82Y4eZEOEbkuTF4BXJHHdoBwg0iu1wyAKiGA1ycqAz8SNyzKAcSMUQQFcM63DAHvJhM+TnOt8KeZeEAR1/A1uzwRQ2CGu32LUfK+3ICVFrDbIA95sjY+EkyhLG1P0DVzKIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uJa73CakWmdXp4E5fyydCWIx3ruNtlj6kzsevlU7Vzc=;
 b=XW4WHFp6ynrUvs4mggQVxgyezSjt62s+1FdXCoQ/3cMwHi5iFhFJH87OllIMlDVuVQqVopA5lFm8YTnGlqh9g478FskXvA4qmWS6YYvctqYl2r68+tBDupvQi+vY2hg68eD0dfqbwi1Ca4M1LwKftYZi64s07mXRux7wfJO7o/yC36jTCbDLvI/gKbmfXFhjF8URLm7dODRBJAcIJ43b79zyejlBJgWXfxQR2Eumbsbk5G48gU1GWEXdYaaLY+FsSCiBff1pTyjcybmN0lMUGocyPjSG5AoT3V9J8KCwEbPpVxOIeZEB6vGv+Jdpxk1RBCvXL67BFgVIdoS4DdqS6Q==
Received: from BN1PR13CA0020.namprd13.prod.outlook.com (2603:10b6:408:e2::25)
 by DM6PR12MB4268.namprd12.prod.outlook.com (2603:10b6:5:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 07:20:00 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:e2:cafe::29) by BN1PR13CA0020.outlook.office365.com
 (2603:10b6:408:e2::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 07:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:19:59 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 00:19:44 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:19:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 00:19:39 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH net-next 0/4] net/mlx5e: Support RSS for IPSec offload
Date: Thu, 18 Sep 2025 10:19:19 +0300
Message-ID: <1758179963-649455-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|DM6PR12MB4268:EE_
X-MS-Office365-Filtering-Correlation-Id: 856b9819-c55d-47ff-f9c0-08ddf683c726
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S1Q3MuL6THLnbSn5AxkdO0FvpQquw9vYfAc9un+x8XFyKTNvyBr5MxsOcLdh?=
 =?us-ascii?Q?jpqC/674TLJnRVp8wi/MJLBYa5vulPwuTX3trpwjol4h+1GLdqN5hRZRUjtS?=
 =?us-ascii?Q?8+c1tqOQf4EJf4wtMtX8MhB2uA5h6XaNxCrlrLDdyIeYN8uYCGK42hNoXD+O?=
 =?us-ascii?Q?Xo/DxzsZl9LfDsvECXq8cAZ9BHGkrUUwY645We26FldnKTQcm9IUHfrS4vDY?=
 =?us-ascii?Q?O18sWXGC65G56EnPOOk1Uc3QKQvEFd7XYnFYUSpr6AfBZyQIOiMiC2v7Ap9m?=
 =?us-ascii?Q?nXWXn/PcD1AliFjdR3qtfCbtcH0o9xZHLJFBd+bMpwkDgFv/x5/CPBGFQvxO?=
 =?us-ascii?Q?CFtGVVhvbEncJrbxm5pmopMxoisOX4fKOxIH7LXxFTHOzYXf6xh9v7BqFKX6?=
 =?us-ascii?Q?wD43xqc9kK+Il5iGBFSjb+XY97PHKF0yZ6jUyUgX9/zRoGQ3M5nbADAY7gE1?=
 =?us-ascii?Q?DCgrw3/sFCtHKqOHt5t5tCFn5rEF8g/kWFOA/PqmjWSyLMNXKMeXIVR4jdSx?=
 =?us-ascii?Q?j7EXhHysTKa6CI2xfyr2G8PrBdSMxq5iw77s9XXQU8n2xPXRHpyzR16KLCFh?=
 =?us-ascii?Q?NNKEwyXTATnN/Fb73epD+Us3+B+xLatXoMIKNOXHRo6YWGU7nBHugtTKWa4d?=
 =?us-ascii?Q?T/kJ0xOwRg/6/00EGKvPk9ZcbEyDPBYUYi5OYlXj6nmXsJWYrwp3uitGMIUB?=
 =?us-ascii?Q?p8SFGCxB+1vn8fxUWVQ6wtq13yRTb9k2v8iMPO/HKtlEHr533mZBYe4NFKch?=
 =?us-ascii?Q?QaQThP/ofZX4TMPx1G18VYwRC6o74jyhxYRshmKuMqYE1jgbTsH/wCmPkRaY?=
 =?us-ascii?Q?zBBlGEx3+iI/ZGHBR98UgFSyzIB6dqaxTJ2YeqYRRW5oQzMXlt/tIJLgkdle?=
 =?us-ascii?Q?1h9cUOzCLXup3NQCHRwppyCoSOSnqotBVfuswg/+jsW/GYap5VF/RO0zwVXc?=
 =?us-ascii?Q?fmipebbSqX2zraaq3Nc6MjCkoVXNIfOn3cU2E9UNG7vciPRv81O3h7cvHoKh?=
 =?us-ascii?Q?zFCLOIpkAr5FRSBWvDLqzEBolXdlEthGt2pogw2Y8Q9jONcwoinrOPSyzVft?=
 =?us-ascii?Q?aDWP83Xy3l5/NcrpEkhHUovXw6a3EvuFmK2nHS9beGQtvX62UmyO5RkiZiJ5?=
 =?us-ascii?Q?SOeNdPFb9u+yf82WRH0uAW13cx5s8Br0R34GdiCdguHKSkZUxWrdAwz95s07?=
 =?us-ascii?Q?/8jbj/EOtAT35mdpzfYXgH2OK3ddMqMSCGuZFpltvQUpWHxm0t7A05CL0PGt?=
 =?us-ascii?Q?pLYW0TcOaM3pe6u6yMtc6G2OApX5eY3hSswCAs+OImi646xJ+4OY99/qVZQj?=
 =?us-ascii?Q?hiO77HZSdLOUXg4y+Rdd3vbmxk01ubrZbrZ0nam1dgkHukdT98ijigR35Hpx?=
 =?us-ascii?Q?WADZidVTuxkTKxhU9jxNUgiuOpn7aVak88h/RrE+xRuJ8rjPscRBklVO4lq4?=
 =?us-ascii?Q?U/Dvc3/o2qfuGG9sPPmrK2kGQPJVE+Y+nlXFu1Rr+9hu/9zHBCOzVe4JjNk8?=
 =?us-ascii?Q?OshxHAlwh2hXVRyO+49ol+BJPfTjhQmhC1KG?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:19:59.6972
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 856b9819-c55d-47ff-f9c0-08ddf683c726
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4268

Hi,

The series by Jianbo uses a new firmware feature to identify the inner
protocol of decrypted packets, adding new flow groups and steering rules
to redirect them for proper L4-based RSS. This ensures traffic is spread
across multiple CPU cores.

Regards,
Tariq

Jianbo Liu (4):
  net/mlx5: Change TTC rules to match on undecrypted ESP packets
  net/mlx5e: Recirculate decrypted packets into TTC table
  net/mlx5e: Add flow groups for the packets decrypted by crypto offload
  net/mlx5e: Add flow rules for the decrypted ESP packets

 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |   5 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  40 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   |  21 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |   3 +
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 395 ++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  |  19 +
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    |   4 +
 8 files changed, 452 insertions(+), 37 deletions(-)


base-commit: 152ba35c04ade1a164c774d6fccbf8e8cf4652cf
-- 
2.31.1


