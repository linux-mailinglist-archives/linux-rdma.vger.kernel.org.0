Return-Path: <linux-rdma+bounces-15492-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 621DAD17F96
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 11:22:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1AEDE302C622
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Jan 2026 10:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842FC38A2A7;
	Tue, 13 Jan 2026 10:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iOk76IjX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010058.outbound.protection.outlook.com [52.101.201.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E3E38A729;
	Tue, 13 Jan 2026 10:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768299518; cv=fail; b=HEldpKqzjXP1HH9EQ5zACuan6GYkynwj3NZ4p0aCIJNrBk+qOuVh2zq7WXFp9jsS6I8CEfPr8qyDxcVaouKmrm6HOsay4bfCkiIriSppVTe3pcAGSvm1dYDptZUHPMG3MyiPBdyTo3Tuyenet1HEQkfo01kjoVWF6WYspnemWnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768299518; c=relaxed/simple;
	bh=3q3nrmBR7ock52HFuvs9jhFrvYTSo9IuAcn7Yx2idPs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s9CR1rO3bk0fUIVO4aXm++vL7WFydZ7lbL8Jd68PxDEFLCizmdCd5FcXchUnIkxoy08M4sVfymNSPtAj/3yZq5nrqCWgLejqV7kreqARdAK29+00mJRegJHT8xLxB7s/fm0X3o97mc19w4QqyOhPZwJY5jpD1YCh6fn2NvhLd08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iOk76IjX; arc=fail smtp.client-ip=52.101.201.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f9B8plC4Fn4HOjAagl+Oo+YV68FjH9oNZr8Z2X6QNGrnT/PWwXf/+LJClX9UbCag8m2T+rzqlkzms7MslgPGZ/QXDQJVnesWnJwtRTz3tU1U9XFpnzQULDmF3hb032EekEVbWsQuCyShjbt1m5DD2GdFivXGKCzmlMYhLmpFutx+hkz2b9WQpBog13Mfs6i5c0t9+RWUydKbB2q/NXGZp5iKhh1lw9qMVPn62g45ddulETn7yaiR3yHHqdxv8dGxwruBfYLIZ0PFlcqCqgU5yn4gpDnzzrgbbH9T/SsBWu3mJ/BcQ38WgpvG8zBWx0cdky/VVRI+U/VfVn3Dp7nKLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gq/3YhSDI6qp9xzkYP6GoOEhy/awOGh0F6YiE/YpjrQ=;
 b=Jrm//9sGoBgtlNSmf0PSDBxGcJ3gWsFsrDeN6ELNHYTkLFtkmIu45vuC1Pa1cu/pcpg/JoUm2LHyimWt3c8Oy6Vf02TDY/nZT3hoMyXDkXkNQpUO3TUIGX0zIs/YhuxMYSmf6qCYjemyn5SUrtQakviljY2ElEluVfNG+xJ1uFLSPm2062s6v9XnoiZ8oE/rFd9dboXMvpbFaHYtx85bSgETFBfK4HBH2C2j21+AOKB/9trS90gXMjQ8XRO7UIB0SJtp9uCcnQK+zj4Cevj+X7BDrD2A2G2s5p0WFCOaPQkng4xiCmHtw4gslZrsocWwwfteC5ySIr9JNTSxfAE5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gq/3YhSDI6qp9xzkYP6GoOEhy/awOGh0F6YiE/YpjrQ=;
 b=iOk76IjXHMYSy3azZZSAp2Jl/nxbS3QfofssDmZhj5zKBfvbR3QttkDUWRFXbRoEGLPoeJ8F54dlU7a1IgCom9LMSqotIdwCCsB/gUXirDJ+ft0dXunsmlgr8XovrT4osU5viTMGHlmYWtI1pGR87MPiv4Zhr6zs+ArvCFtR5fHjEvqMw39+2k1qIG4ZaOZvEOdZ3Ebs5AFfhfJseoJK37nW8HjmU7y5Haqx35JG1K9cIJljOdQN6kl3WV2O7XfcdGCqRilDtLudqnlGS3PvgLpv5ZROWmWaYUynWDFTT4es8GYoA2/IdMhV3FG76NoPZwLLydvpjxokiyoINfAeNA==
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by SJ1PR12MB6098.namprd12.prod.outlook.com (2603:10b6:a03:45f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Tue, 13 Jan
 2026 10:18:30 +0000
Received: from BN2PEPF000055DF.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::df) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 10:18:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055DF.mail.protection.outlook.com (10.167.245.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Tue, 13 Jan 2026 10:18:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 02:18:14 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 13 Jan
 2026 02:18:14 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 13
 Jan 2026 02:18:11 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>, Or Har-Toov <ohartoov@nvidia.com>
Subject: [pull-request] mlx5-next updates 2026-01-13
Date: Tue, 13 Jan 2026 12:17:51 +0200
Message-ID: <1768299471-1603093-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DF:EE_|SJ1PR12MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 88f70508-7c8e-4753-49f3-08de528d18fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nmfyp0rITdSgmmLLCCXzS5tXe5Bwt4D14jWC08IzVG5t9EdMDfn28wjRfgPY?=
 =?us-ascii?Q?BwJM/P+enkxXlUAA62mL3wbteQG4aniA+ZtzbbCVpX+flibXmWq1p6UzQbYN?=
 =?us-ascii?Q?CMbP0XsZfYXm6Oge8csyn8irGyU2MPWLipYhuMPG29zdLMWEc3G4V4u5mjKT?=
 =?us-ascii?Q?ZaquLQUdoLKSQ8aruXb/j1KHvh0tYm/wq9s6o/+c9sqzroH4rjzk11No+fZl?=
 =?us-ascii?Q?+yM5Ocql05o+hlbJWq1YZPufL6wvpp9c2HpqB+3SdgMcNFT9JyQ5B+9J6slc?=
 =?us-ascii?Q?LMGwyOaNzMpOCy2Hn6UAqg4GRwH+mjmzVXxKaHszK+HpsnQxQZFknCw+p3GI?=
 =?us-ascii?Q?Yl5NcBj+12+n6nJjiIRS20r009har6Aa17ZfbOLTMbPq14UXYHkDU2VnOVxA?=
 =?us-ascii?Q?aLROO8CIfcO5hXp+CCrI8JNPrqLlJmn3nf6ykgUh562LBw4HJAX2vBW2Z4e2?=
 =?us-ascii?Q?xYEHCVUi527zRzrUxXGYf2GxeIMztfZoTpQnHsUrtAF2ggnm3mBwXH52+eB3?=
 =?us-ascii?Q?Mz/xYvZFU04YyozbXCWcSYQZW/6y4SQW0RP6KVa60lCM+YoFcF17+Of6oNrd?=
 =?us-ascii?Q?kDVK1uwX1R0wksd1qJfE/p9bA4t2n0HVBoLzRxoT0x/1hUTZc4eSV0Hmv31i?=
 =?us-ascii?Q?1yTnE3mLsEzXKZLZeRGja5n8RzgYootS6ub6yjwDG87VVOJkNOpgOFugGnAk?=
 =?us-ascii?Q?HUtJ9NG8yDvMPnC5jIj+5mHDhOwGfRi9mD3ERwwlOr8CG71sOtnj7MD/hBCN?=
 =?us-ascii?Q?HlbbamLFchMswSXohdFJ/i22G/9GKFJWhZyPFZqtCaEsX3xlSCDsbpgRnwE9?=
 =?us-ascii?Q?1hTP1cFVnLERlr6bZNPMPRmwQlGB6vg3amRsF5FeB3+rUL90IRN3h5safEjA?=
 =?us-ascii?Q?4bWgMlfPEPlYWcKkkODsq5tBQb8okv6wUH6FrJFwzrOQl+RLFdogIKcNUPFR?=
 =?us-ascii?Q?JE4Jccgjq0b9y6O1iofA81krPjTs3kN2KIpbBcoCkIUh4DoeU82nCicC90xL?=
 =?us-ascii?Q?2t5FlTa5MIk0ahLqT6pNYw6t6PFhT+DKUQrLUkwGkSNSHl3GCUM2aTxP7EhE?=
 =?us-ascii?Q?kmG9GxtxaGfxHKIfWyVp/l4lMLGKxX29Xplz+CL0cXkoOXeeN4xk4WQAJ6Mk?=
 =?us-ascii?Q?q3cDt6IUWQZF7YwZJHCAj1aHU2aV45YXhwU65uI1ECxdGTahQPer4745VDac?=
 =?us-ascii?Q?i9Ih38ATLkNBf5uz8rJTTYVH4UcZmx9H8/v/VoKMlN7U9WPoTYSUC2lLFQkV?=
 =?us-ascii?Q?PBomhZtQM1Wle8Y/geXJgqzsLBx7vVUreJmrQsO6Ro2jocqgc7ItlU8tD0BU?=
 =?us-ascii?Q?4cNTz4peUYQqO7yhJt0qIMtQ9bbnK5sVXLDSAfCSkNz0X1u946BP89T0dn+x?=
 =?us-ascii?Q?TJ/PTdL3J5zeokGtac9Dy77tQbcrrRjPB6dAsHXcar1ArySDUI5qN8cBsND/?=
 =?us-ascii?Q?vgaczqboDWeKRmtOmYZ+rin4AyK3hORRQI7w4TLO/D3ztd+e3XctyFjy/xQS?=
 =?us-ascii?Q?rdjWXVyUeqJWbiKmdI6gxGUofNcZExkA94DA5N2QnDL1hPDiRA0+7WASr9rP?=
 =?us-ascii?Q?JsDGMRis15PjNlpJizs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 10:18:29.4460
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88f70508-7c8e-4753-49f3-08de528d18fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DF.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6098

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

Regards,
Tariq

----------------------------------------------------------------
The following changes since commit f8f9c1f4d0c7a64600e2ca312dec824a0bc2f1da:

  Linux 6.19-rc3 (2025-12-28 13:24:26 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 49e41f3ea3f7545c732a0b399cb123173afc5cfe:

  net/mlx5: Add IFC bits for extended ETS rate limit bandwidth value (2026-01-13 03:43:00 -0500)

----------------------------------------------------------------
Alexei Lazar (1):
      net/mlx5: Add IFC bits for extended ETS rate limit bandwidth value

Or Har-Toov (4):
      net/mlx5: Add max_tx_speed and its CAP bit to IFC
      net/mlx5: Propagate LAG effective max_tx_speed to vports
      net/mlx5: Handle port and vport speed change events in MPESW
      net/mlx5: Add support for querying bond speed

 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  | 215 +++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |  11 ++
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |  39 ++++
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.h    |  14 ++
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  24 +++
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  74 +++++++
 include/linux/mlx5/driver.h                        |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |  16 +-
 include/linux/mlx5/vport.h                         |   6 +
 10 files changed, 395 insertions(+), 6 deletions(-)

