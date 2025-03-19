Return-Path: <linux-rdma+bounces-8828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11A7DA68E79
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE708844F4
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 14:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 653CA1AAE01;
	Wed, 19 Mar 2025 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OaYdHdXw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A117A30D;
	Wed, 19 Mar 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393070; cv=fail; b=PK1iArDjz0cNjtrfRjCgCOS0+MvuVitOzzKQZbqZNmgKxuHLVCeCQ6xyUrFUXZfTwgE5BSN6qZoeo60clhOWiYzmZy/JuqyDETLxl1W/3RYVMsHPG5QU2/r/HgUxFApO5dfYT6M6LVzYD9P1ldF6bP5w9/kTkuThzYjGVBUVFoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393070; c=relaxed/simple;
	bh=i2lMQIWRggtt/DN2xuOaTp8CMHQHjnTAC0W/7OcyuNY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oZ1+8nIVxNbNk83lcHq8W2ArmnxhX595/EqTA4jZID0cAMs4Drwi5aURKMXrr9iodeZP/9QEpg8bSe/UcCT7c8wlYUPJNFNIcsMjy4t/HdY5ApDtaLIuOZEYNVZcvOKy5cz3Asm5UZaApruETSwc8687rW3gR1vgWunIKGEVH38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OaYdHdXw; arc=fail smtp.client-ip=40.107.243.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RHLy0H0CTFR1UcnTASkNQgQrpb9hYWlg7Ew7PjpSFx5IgCvcrquFfYNd67o038C6sR8WABLf9Fbw3iGIkn7PYriHeRHFq/URUUOLwqpBcH0s5y+dYEeDsAmTewe+PGVqjInmGeFmGAp/HLh+bQTInx/cocRdANQCIEUVm41Lp2/3D4A1nOtwH8qmZAgCUdCKCyOSd8ykUoGluzuIz8oRtEJPeqXln+q/CPw87umhudcMU4TJmghxtJMkHVATu6Bc7BMJxCrfbhwRTcxfkYVSGKsq/aGk8X+drcL2xG2xL0BcSKX/3XUk7pm/kb2HS0EXJrNWT6cViSyp+DJ584eL6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jNfezoQhTkavOdpaVxDVCKccKpQJYCAVmCYVfmpHd+0=;
 b=oGoJGSk1AqgihmxMK7NDMp1CTeokX3lWkPS+eT5N7+H+82Rx3V8eRk7IR6wdixchTbCLZIye87o2DU281S7VYrCdsCc5cr/eTyfOBBRysMWdQN4FaQc7cK/i9S/N+Met8Ygq50CnQgrAnJ1e2UxS/fr2bE4mnGnloPhy3dTrRjLW4yb4J7Z5q1wPE830W7WVO0Cujz3XXVHRinIXvaDl9Ya2DrNtjTaoKHdKtDiIiDMBzT7mEvM7nVs3IFsqQnnpOTRm3ael4VKmyfGT7x11VSex3pm8Y74qwEptveTLvM02tefPoJedseYNp/wdUJbvhYyi3SqMZwNbccyajdedsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jNfezoQhTkavOdpaVxDVCKccKpQJYCAVmCYVfmpHd+0=;
 b=OaYdHdXwes7Jl4B/qex+XmVmReGtdRtOPGZAti4ShVzO30bH3Y3NtqV+tPGvEnYJYyxCruyAmv3C+4PRxYWKPOI5RBC3qa6pkzQn8jRo2q/XyTSPvIZsh8KEeeLiu92+72N3D3elXW51vc7wDWh9sCzPVA/hMazlFA4PAcjkXJL5bzGyvWg379WqEcBOI8kipO4NiZCMs+z8ZAxUzjruNS8cRZ3DtCkh2FiurWqSo5rg2lrPFUk5Bt/24B15CQpEdRVFfCwgKOUOxLoBSLK9vw/fhdJMTmspWn00wPYu6jnb3CHAYewgiehQuSOvSLjapsFVegdWSoZpk7dqCOssZg==
Received: from CY8PR11CA0006.namprd11.prod.outlook.com (2603:10b6:930:48::10)
 by CH3PR12MB9100.namprd12.prod.outlook.com (2603:10b6:610:1a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:04:22 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:48:cafe::45) by CY8PR11CA0006.outlook.office365.com
 (2603:10b6:930:48::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.31 via Frontend Transport; Wed,
 19 Mar 2025 14:04:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 14:04:21 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 07:04:11 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 07:04:11 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 07:04:07 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 0/5] mlx5 misc enhancements 2025-03-19
Date: Wed, 19 Mar 2025 16:02:58 +0200
Message-ID: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|CH3PR12MB9100:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e5829c8-0fdf-45c3-2d50-08dd66eef2c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AdQlqTCHaDJruYxppqRWEXKMGwuyz4c1unsSDt8yfauOapo+8VU3XhQ3J7T1?=
 =?us-ascii?Q?YWnve/rutfkXRi8VVRzuD24EL/GAweYmnd2R3MH1i6HjrBa3rt6QhAziwnMg?=
 =?us-ascii?Q?1U3eZEIRJRghvqXUvqg6VFjSrzkV8lMX+pxktpvkIUHdTAhXoyrbQspFW6Kt?=
 =?us-ascii?Q?VHdeAxFa9H38lWk4x0KC8Xws19O/3xVorVSD/Hc/ko5Cr8AekCrgeFD7V2kk?=
 =?us-ascii?Q?6U3ssej0pc3ASe+egGRVB6qEKr0sgHX8m5lRyz4GIVhLfM8SqxDXjRSb/Xkw?=
 =?us-ascii?Q?gSMALhwjm1z+oc6BuB6akPg4Hkms1Mrw9qkdJheqKi0VQPieHfkSCOj+metj?=
 =?us-ascii?Q?uyps/Hmqhq48i/w213GTSI8p7smzVKtQaeP23fH/ql0I4Ff6JDmi7VeLonnS?=
 =?us-ascii?Q?MgPHLqq7id6i7RvAQIQANVN/VL48Fs4MaNmMzNBRXhNfDn+UbSSBLITLWj42?=
 =?us-ascii?Q?b46cEZ/Yj+JA5d+b0tofPb7mwYU1t3JOQIrng5zPfC+UfMaBK1IN59rMtKY4?=
 =?us-ascii?Q?kj7a9a0k4pqHAbwWVBE4i4W4yW4jSsGWzAYXu89amtYF5/f2P7zJyeesemXR?=
 =?us-ascii?Q?stMK3UVNIjh4ueq/6fpS5MzmijkJQDALcfMDnZ916UQALOhXrYrzALMtSR2C?=
 =?us-ascii?Q?+Q6v35HnsrN/xerDHPOxS/nrS8YWYcsMnb1cK018E8bjfD+tyTlgTgGoYTPN?=
 =?us-ascii?Q?iI8UYuPRX1e/t4W/NoEjtdEkbEHrM4ex2hccyNx3/NFXPAsaSyheFUkU3Xk4?=
 =?us-ascii?Q?T7nBi7TmXRtpqhW9Re9xl8/ZDnU9TfhsOXSQ+dLvwsi6h34oDtQZQBrne6bR?=
 =?us-ascii?Q?WvyNa0iUs08/ON27VeHPKfyAltjUPTw+tzZtMe/zSh7b8cZmFF4aLprbUoSI?=
 =?us-ascii?Q?qc4qohQF7bCHDemN37IJ7g5WJ8YW9lE68uusd8KuW3A0K09MgO/okBSE29Fq?=
 =?us-ascii?Q?hPpEhMA3CDz2su9rzAvjdaDwshrG6KHQoggDe5CtO/1osoaRsim/JYlSNAi2?=
 =?us-ascii?Q?q0dCgt2yXCFE58jBUCqY5zR+TtP//uFM3mYSajiKF+RcTBuzbXVqLEM9RDwN?=
 =?us-ascii?Q?Twq0Jm4rlYls4nDJ/2En8NJ/8tsc2xrMxOqdDWRqkGJFb7GMwCkC/LDDPmEm?=
 =?us-ascii?Q?QdeQX0kCrKA+vV7K7fnHUJY7z39nyAaXKoQ5oxwBnUlRRNf8yyetuV2f6aO/?=
 =?us-ascii?Q?tWlgddeBr/4IG+Ub9aBHMDekB9KVWGrBaya4RlNgtb5yONxw/w/oROXSKkKf?=
 =?us-ascii?Q?p5wIDt/lpcLTJkuJ+S4pOcj1Clz9geGmWwtiJd89MJ0BrL/WgOzlPDpMkzIR?=
 =?us-ascii?Q?zQAOayJVqennSnnxgPdBQDaZKAXiSSKiTzwU1J+l5NBXyIt66SljqIeLmFIs?=
 =?us-ascii?Q?fIuo1i6678Oez9RBTPZL5R8AB0gLcTd85mZK6qHTIBt7fnOcGKz8AM/H4n+F?=
 =?us-ascii?Q?bSBj43Xw4C3M0G87iHp+LEK6dbqgjlNrYMemHWEELxpZYEFbY92Wfw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:04:21.6667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e5829c8-0fdf-45c3-2d50-08dd66eef2c3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9100

Hi,

This series introduces multiple small misc enhancements from the team to
the mlx5 core and Eth drivers.

Regards,
Tariq


Amir Tzin (1):
  net/mlx5: fw reset, check bridge accessibility at earlier stage

Jianbo Liu (1):
  net/mlx5e: TC, Don't offload CT commit if it's the last action

Mark Bloch (1):
  net/mlx5: Lag, use port selection tables when available

Paul Blakey (1):
  net/mlx5e: CT: Filter legacy rules that are unrelated to nic

Shay Drory (1):
  net/mlx5: Update pfnum retrieval for devlink port attributes

 .../mellanox/mlx5/core/en/tc/act/ct.c         | 11 ++++++
 .../ethernet/mellanox/mlx5/core/en/tc_ct.c    | 29 ++++++++++++++
 .../mellanox/mlx5/core/esw/devlink_port.c     |  4 +-
 .../ethernet/mellanox/mlx5/core/fw_reset.c    | 15 +++++---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 38 +++++--------------
 .../ethernet/mellanox/mlx5/core/sf/devlink.c  |  2 +-
 6 files changed, 61 insertions(+), 38 deletions(-)


base-commit: 23c9ff659140f97d44bf6fb59f89526a168f2b86
-- 
2.31.1


