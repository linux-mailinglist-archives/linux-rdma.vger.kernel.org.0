Return-Path: <linux-rdma+bounces-11150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6469DAD3CC2
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1182B3AC85B
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:15:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE41237708;
	Tue, 10 Jun 2025 15:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Xi9OGWzA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5F01D7995;
	Tue, 10 Jun 2025 15:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568555; cv=fail; b=K9RJ42tMSEniyxz18bZHDHbMHrDnHkCfPVDnyh/4YSqV3a8foFlKI8tYr7+ZVMGiwlUZ/lSWLNtJboBjefgYrEiiZL1ggML8zZPZJbKobvVY20f7M0NWZguhAYGfz9BQkTpRabqPlZGljPbErJLtRlSYdvKkpSp0xHqdSFPWzwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568555; c=relaxed/simple;
	bh=cLcOUuEE92zRcPUoByLkpXeNA9PvN+BrT3MafVSQPHA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SdfMhj2qaX2CU4kb4cXygH59T1f2Ucqi5TteHMvmUztsYd4hJhJTLX1MaBxFqK0Lsm0rPS5zNTecVL1WIBcgnenitLXDuX9OgVUcmX1SS9n0QvEMdo7iHSBYD0m8xApoXh9LL8keMQpMB/dCWbFByKnZUmrRfJE99DgKg0UeR2Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Xi9OGWzA; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OAwHMTs5kCF9MvMtgc/1Qtd1qgHVcjFVfH70k4nlmTxiTcdANKB0Cg7v5QR9KPywlr4CsvxWZOqeStS+7cpNVxa4N+0fxaNzav71+W3fuuikEVIPmwX6UD7WsPbceYtIc4NurES/7kbxsDz0AsN9vRABKIoBXUYlQyDCYHPAf9P4HDPmnvuAQpNS8b8xmbxqV+fvykbxzbzGpBTSYQcf09vqmV+pH2Ewxtu2qzdTZiOBsFE6LjQFBERhTcBUw3e+Q4JsgffqJuLo+oexEB7yXygnfpzjRc9zfgfMB8EDtiH8sIcaFQTUhFVQT1L81jNClsOnAig6cIjhtLtq+HClhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QhdpSRVtbLGk+DqqoWj6rI/LSmPCnM/uItNzEWtyI28=;
 b=hDLUYBf7woWwpZZUgE+NmMQUNs0AFurVofOV3rt4hbA8ouxPq55DWDod/mCDJOa8qRS+18L1iS7UQyHFesbetE/HFeQoAVD30t3AydKgQsbNOLcU5w+QLcalOCRtG39DAf4iyaD1w9AoIjjjOrgV6DSDcJbErPHVfHFrm4vm2QjWuuMkHctQqKm645VAilZEKj5J9f1LcFcZLaw77xrndKFlIItygn2CggtUAfIoKDcy5b2UsOoLs3iqlDtfGs08Y2q1/Ai1kAUQ2MFO3SFyBmRPhpQP1hfBBdcqXEgBnL4w4uu5tVeJU7w2oBygLZuewr2NhFLhCoGEc6CtESHT2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QhdpSRVtbLGk+DqqoWj6rI/LSmPCnM/uItNzEWtyI28=;
 b=Xi9OGWzAPqJjAhhDUqp+t6rsDYfD/YPj0x3z77v3bT3f2x/m9Lb6z6j4cXpPdKqp4q+fIvKfqKhq223XHC9Zzn8qfRRUuUJdEaK7shAJdbzHmsMVKTp/uuWYiKN0G3pBGiuNaL3e7KVr6QsjAoR/H5TnBVpfDLX7pI8yLcrWxXqPZM6iilt/Ydbo4DpgaZHDre5P1g/i6wPj1wbBho0HCiQTnL+BaUcb8Tk8dwj4Wqm3NFEl7wjrwFR+2T7fnHkA7VyJn4ksHcXr51erW6Bg2coG0C7DM7SePoyGlKOLGgLq1d8rPvyiIID7NoLHifOWznYEgN8OhoFyGYoNB9Ueng==
Received: from MW4PR04CA0144.namprd04.prod.outlook.com (2603:10b6:303:84::29)
 by PH8PR12MB7231.namprd12.prod.outlook.com (2603:10b6:510:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 15:15:47 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:303:84:cafe::3a) by MW4PR04CA0144.outlook.office365.com
 (2603:10b6:303:84::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Tue,
 10 Jun 2025 15:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:15:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:15:25 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:15:24 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:15:21 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 0/9] mlx5 misc fixes 2025-06-10
Date: Tue, 10 Jun 2025 18:15:05 +0300
Message-ID: <20250610151514.1094735-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|PH8PR12MB7231:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e229ea8-2056-4b11-efef-08dda831ad4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UqEFBOp6dseLa8VowE6JDVukGiLdkU7YreLBUm6W3rQpFt7K2oZMg/1DWmrt?=
 =?us-ascii?Q?MIFSqbmc/kiIOOjSiF5y3D8C2Cp+rIEzoeVOLy5kh2KLNWMf9D1LJMOfginO?=
 =?us-ascii?Q?QeIOu/gIqXHvbCiqe3nj2crE050ZORw0pEepIKft8jQUav4/latb8kGjAGy3?=
 =?us-ascii?Q?TbXK102eypYPi6ZwfAD3s/Z82JbQZtd85uoIWdlzykpnrvQ7dip4o8Dk+APe?=
 =?us-ascii?Q?/JoeUFmlXrI76LFmAz2PjjJWG6oZqTz13FwHtQPWSnisUAFloRtRcWGL32zV?=
 =?us-ascii?Q?rDHpB4okrep7BgjhjNVsd3p5+Jma+Nfm3/pNzOf8U0mJhuw8ZGwEHkkIF+qR?=
 =?us-ascii?Q?dTkUn7nwx2Njcuw8E2DikCLOxAydZPZQU3mXTQvV5hyAPTi+7VLNOzgz5DdW?=
 =?us-ascii?Q?+6KMG8dAAp43CH8P7BVPNrFEhtaeo4N9k+lsbuKnAJVyAQQ62SkrkVxFu1FA?=
 =?us-ascii?Q?NAkdLNbL4MYUuW/73NyLnpD9LxtGvJDaV6mkcRoXY6U0bpnvac7ewKLYruNd?=
 =?us-ascii?Q?/teN4YIHROMjZmOmVsksrcEIsgFEeTKZ/h10uOqlZ3DjQgYHMDAG3UiQm0Sm?=
 =?us-ascii?Q?aKQoXmtI44NacoKkh8HBq1qtzchsHzgEHrmPg1r3HePzgHK0daJDI3iTMpfD?=
 =?us-ascii?Q?U1oWZRz/fOVquQLz91G/AZ7dv6gdZXT4WIV4BIoLYBBkgB+cZmg9UhK0pD71?=
 =?us-ascii?Q?mgYuYsY22CmG0oBv8k8K8ehP8dsH0VCVeMWwDjhV/N3GuvOzkVJ1mjyMXEPC?=
 =?us-ascii?Q?hhXW2FMAexINXZ+nCvyCo/C2FGLDH1mXDPmmn8EJhwtvKJXaGt8hJtbkIGdi?=
 =?us-ascii?Q?xcA9grlGMYsPefpSa0N0CgwMMhjdg5ztzXOh6pnWua7S4UYHR+vd8E5HqQik?=
 =?us-ascii?Q?9P8bcMIYvzQFYPVQAggWyrb45HCbn8N4eN/vOJoi4+8h618UyJw3TsQstTOJ?=
 =?us-ascii?Q?u+3TbC0hiZppvPznuTS5A71XLmgN1cHK91lAcUtdPgZQ8E2AxlwoE+/1b35H?=
 =?us-ascii?Q?+3rVFTLsf04Dt4XyRMFWErGlZh6YCSOmnRj5EFd9AJEFgUHK5eV5AgZsEjEV?=
 =?us-ascii?Q?atxF4hj37/KLn47pkTJMYeK2BuTM75xEAAGrl78UOsbzSA+mm5cfacmjRVpE?=
 =?us-ascii?Q?IAv52Yh0z4HLBt+g72T+0GcSfabgEIc2q+rkHlg90INXIVgTg60bGh65wW4j?=
 =?us-ascii?Q?9cttabkTznn1/saREkyt7SzEeDevjXlvLSPuu5quAnmpL3hBaoqYrWQtF0JI?=
 =?us-ascii?Q?O1oT1edd7OLkmxP8Ym8wr7FH5soCZ8QoC7UT1wo0N8Mno/bioXNY3Np5s/2K?=
 =?us-ascii?Q?6xcARsfT0AXvYqjMY7adQOoqux8YmPnsWt0SkXDaoV4URj5CX5RfgMQGwMJc?=
 =?us-ascii?Q?gN/3NEmGVFojVonfUwKU/mH7kJGLu73DK5I0F++lfQYz7vIxA209XngJntQc?=
 =?us-ascii?Q?jssMeo4DiuHPvbAAfs8H/yYEuamXDN1AJWnBucOBtw5AdrZgYDZPAJkGUHaB?=
 =?us-ascii?Q?JVVZO7GEOmif5cPfSXDKruFJYcX+X10pcvT2?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:15:46.9382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e229ea8-2056-4b11-efef-08dda831ad4b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7231

This patchset includes misc fixes from the team for the mlx5 core
and Ethernet drivers.

Thanks,
Mark

Amir Tzin (1):
  net/mlx5: Fix ECVF vports unload on shutdown flow

Jianbo Liu (1):
  net/mlx5e: Fix leak of Geneve TLV option object

Leon Romanovsky (1):
  net/mlx5e: Properly access RCU protected qdisc_sleeping variable

Moshe Shemesh (1):
  net/mlx5: Ensure fw pages are always allocated on same NUMA

Patrisious Haddad (1):
  net/mlx5: Fix return value when searching for existing flow group

Shahar Shitrit (1):
  net/mlx5e: Fix number of lanes to UNKNOWN when using data_rate_oper

Vlad Dogaru (2):
  net/mlx5: HWS, Init mutex on the correct path
  net/mlx5: HWS, make sure the uplink is the last destination

Yevgeny Kliteynik (1):
  net/mlx5: HWS, fix missing ip_version handling in definer

 .../net/ethernet/mellanox/mlx5/core/en/qos.c  |  4 +++-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  5 +----
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   | 12 +++++------
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 21 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  5 ++++-
 .../ethernet/mellanox/mlx5/core/pagealloc.c   |  2 +-
 .../mellanox/mlx5/core/steering/hws/action.c  | 14 ++++++-------
 .../mellanox/mlx5/core/steering/hws/definer.c |  3 +++
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  |  5 ++++-
 .../mellanox/mlx5/core/steering/hws/mlx5hws.h |  1 +
 10 files changed, 43 insertions(+), 29 deletions(-)


base-commit: fdd9ebccfc32c060d027ab9a2c957097e6997de6
-- 
2.34.1


