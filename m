Return-Path: <linux-rdma+bounces-11968-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB01AFD6F9
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF6AC585597
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 19:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10B122422E;
	Tue,  8 Jul 2025 19:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WJS5kTcC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2053.outbound.protection.outlook.com [40.107.95.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93FC192B96;
	Tue,  8 Jul 2025 19:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752002161; cv=fail; b=mx/nrmcydJGkHNiElka9j+LeN495228N1Qx3hVK+VQqAoFTNxA6H8Lj25uMrih5h8YXr6PYpbf0CNqBwgQr/htmiGnJjV8/UTPRikst6bT+UeNVb1tpK3njJDITDP9vMcjFBtqMgTTl6GC2nPLZHcOC87fn+/kChEsfM7z8mEo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752002161; c=relaxed/simple;
	bh=78HvOBoOoyWiE1l8qGSydOENKUZI5baOSW3NxF37qYY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c+GoS4KlRIGmS16pRbnMT7YVdeAufzoUT5hY5pBUTWB99LB6v25qbJs0D4of0edDWyAYblFW854FQUtwAR8biMoxTpM9YuuKyUI0IRBuPBDZZvXMW5ALLg6M0od15+idUkEnAW6JmNWZ8uquOGScXrNn0K8VTsFxBEk+q7mR2gI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WJS5kTcC; arc=fail smtp.client-ip=40.107.95.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EcZI28AoUz22/t4Vo0B7AuVDxvzSDdIfZqxZBM+6q1X/zKi41n9ZEQsWb2sPRAkY3PNM6d3J9VD9s1RRbVsJDUDxKNHNA/lZuvXH31WMBDNnaNyEqPxCmRJVjHyv+FBhCUf6NiLwNzBcDVwxdgxGxHhlYc+/TltE/wa5VZCAowRxy205OZ4/jdem3oBa3FYUo7IIZ8AVZFDyrnO9IRNKHBwcGuWH393hyE8bMh53PJaE4ZYwTmD38j5yDEr/fxgcHMSwNl14sav6f0YryHxxN87C+KuUe0Sq6dA5y63KxXrqQ0UF+yTf7nT6jW4K9ty+3utgKPTRKQqSU0/YbZCKrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3yZEpDuGVaTr3bZ8/1tLS1BbN2MdSZEgr6yyOi0dxC4=;
 b=M0VdHhGzqfPc1rCoEfj0IKBSOOGRAevrS3QcMfQUEz8c30GN/7uXiXCBQTJSAx4eveCILbXhqiMz5S9VSKRG3gTQwfAgqWg77jphhqFMT6eKIEQPikZKvACSslhjLCTXQIaxw/KNgC24OveMUzmVvETeyB6WAsxk6x9i7aNRlxxmn2701I2/+UEjlW7DBUOsbioyU+9laZeDQ8PpxMzUoX1vuBGv+625Ysg3Pj4ZZdziqe9M8/Ghvbz6xVf3jfR9fnsyrUEGkf8CpP80oMDHXEoc7eOOLIV7OkSXAhUF+ZcHX0xv2U+qkXwOEQ/3il8OXRXPjPsac5vCOgpEIIYddQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3yZEpDuGVaTr3bZ8/1tLS1BbN2MdSZEgr6yyOi0dxC4=;
 b=WJS5kTcCbBvMkzJ/xhXYNXSO5EyoRzPXPcJEhO+rHVJkFwJViV3fRtD+51qeV1sZsIuk1CgLPV1baagFtKBHq7a780TM2bPXEPXFpaTRzaNj/APNUG5QtEbbG8sYA3f5WkKLt2C0Q374pKzwAM8FprPoizTy3zVWnUnDOeXU2reFvdoa9q96t0MlcS+kZ8u07aDaDtyd2KeZP7X6mAnjZm4pXQCLmh6pDK9jWpiaq+9CwNZVwFiH8tFFXh8/LWjaUVkCUG56qnBHrBsbTh2vRpzOmeRVFN5CJ2Xtv+2a/xvlCFsxGbwmkVEC9jde47UYuydbf405jUSRA9mLzF9xAw==
Received: from SA9PR03CA0008.namprd03.prod.outlook.com (2603:10b6:806:20::13)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Tue, 8 Jul
 2025 19:15:54 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:20:cafe::4d) by SA9PR03CA0008.outlook.office365.com
 (2603:10b6:806:20::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.27 via Frontend Transport; Tue,
 8 Jul 2025 19:15:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 19:15:54 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 12:15:37 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 12:15:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 12:15:33 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, Mark Bloch <mbloch@nvidia.com>
Subject: [pull-request] mlx5-next updates 2025-07-08
Date: Tue, 8 Jul 2025 22:15:02 +0300
Message-ID: <1752002102-11316-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 512a13f1-05b8-439f-e6f0-08ddbe53dc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014|7416014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W4yPxKuGW8tyFOFocLJzOIp6J5cXGibpGsNjzS21WAWVxY4U4yOehAARvU2+?=
 =?us-ascii?Q?oGx+P07esGt26b3sWnoVMZRj5U8ZU5RR9EtyoWm5FlotrIknYeF/6LauJOit?=
 =?us-ascii?Q?e0ew1CxRTmQqCi8lSQ9JnLtZ9+/zt+PlQ/ZOLY+2PLuMfuHzqF/XKAWJ1z5w?=
 =?us-ascii?Q?vwOBJIV5QiPtAhii90YC7ylAgQsAeAeCDNGrI7RpnTP3gk8UVSAeu8UQu+zv?=
 =?us-ascii?Q?uJpFESW4+Hdg9B+c8Z9QrCOl3W2N5Bqk4GFYVTO3yRJlYyMjWrnybtoaZ7Z5?=
 =?us-ascii?Q?fcRNCsPkUe1DhVm5aYklnE2zeZ0xUrtMFQ0M5GtSwprtGppKWEfOvMhlUS2K?=
 =?us-ascii?Q?Uq1oVGx4BN16iMtbp/w/f5QPZ0THf3FmjeoUPsKsfn2HZrowr+ut8wHIod4t?=
 =?us-ascii?Q?qJ5BcVaiFDug7bQh8zdDT50xoWiSHpi5z8kZG3eBhLDSurwsl1fFc05ikF95?=
 =?us-ascii?Q?ekz67NW8DFu81djHJ9C7xKPN5qKbhsyqHoDj4ULRGy1xo13cGacuSN2LONde?=
 =?us-ascii?Q?ExJLPo+Bf/mMTSZecbgbrdFDxNMEZtIdyNekBE9BQKZ5j9m2r2GXi6OtLrVB?=
 =?us-ascii?Q?w1NS7jDTd8hLS+iLViUtQtmcDDThXCmfYk8oTCy+MiP94IlMZfcsmqtsAoBQ?=
 =?us-ascii?Q?q1/pu8eD/oBVUJ1Fl2tKe6/JgQm0ICdNjLSEEQxekGECYoiIqApNKVJjsryp?=
 =?us-ascii?Q?M8Ud2LOimH+uwmaLqv6XxZnBhyDehRVUnkiOmu887p9W11Fy3OB6wmtqEoXk?=
 =?us-ascii?Q?EYPlZ3WKg52NFSSjFUQ5NxPNClrnb86Sn2eOqh3hZJOiSWLhMUywv783kkY4?=
 =?us-ascii?Q?AMM8a0nuz9tQi42aqa2i5FE+16evhWCpIk54KTrLNfRZsq7pDS+AecIpU+YX?=
 =?us-ascii?Q?A+wEpn0G4Jezhp/Fc/WqsmfiZJL6guUwDod5Pc0iuNj6hRuhAvBEyVszhyVx?=
 =?us-ascii?Q?jEm2ieC7ek01RaEhKST2vA1VT/W0k5VKf0TVB7D8DNrp30zi2CoWUOTVfymo?=
 =?us-ascii?Q?ZraOoHs88xiZBE7aWfdl38VxnO8hwdJYp+aNapBgQX3HAMUtMCyuorGWYGfc?=
 =?us-ascii?Q?OS0aAUE6snVujzAgeurjF5Xpzs4bqZZO5ms6cI+E2K6xYneqQEiNklIITFZ0?=
 =?us-ascii?Q?/Q/Yj3fTYREobe4m8ONUzYr0hlQKoYjGIEvKu7SY+Hknn/2e0N97uYZrB/vh?=
 =?us-ascii?Q?Q2yLv/0Lv5Y8sFHRFPK6Zsu2TsuFTeeNGBubEykoytX9iYUku1z+KzWz7m8y?=
 =?us-ascii?Q?Vp4IIC1JS9s6p1OBS/QPXhVAZ9orXrEoZMm1NyqfSg5ICivWJrkIcYTNGYYD?=
 =?us-ascii?Q?Aa4eFznNarB6fVUt8V+ip/3UCGTZwbx2D8YPDEEZMDRt9kj3jQCXHmKMTkqR?=
 =?us-ascii?Q?ZokGyDxu06fLOSDMp6KxxmO4Tj8NVX7FnHYfLVBEUXizYVxakCzDr5Fc2tMf?=
 =?us-ascii?Q?ERCxrtJQBdkuFTaI+enGrBaZlxyfCXelyEW85iYS+7YI0L8fjxaYjIS/CSqC?=
 =?us-ascii?Q?4JM3E4Cf3RU0TIeBkmAITZ44BrToqe6qJoCp+wC7hrNDhV63o+lae0E4fg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014)(7416014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 19:15:54.5549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 512a13f1-05b8-439f-e6f0-08ddbe53dc77
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

Hi,

The following pull-request contains common mlx5 updates
for your *net-next* tree.
Please pull and let me know of any problem.

This is V3.
Find V2 here:
https://lore.kernel.org/all/1751574385-24672-1-git-send-email-tariqt@nvidia.com/

V3:
- Add one more bug fix by Stav.

V2:
- Add a bug fix for the fs patch. 

Regards,
Tariq

----------------------------------------------------------------


The following changes since commit e04c78d86a9699d136910cfc0bdcf01087e3267e:

  Linux 6.16-rc2 (2025-06-15 13:49:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 70f238c902b8c0461ae6fbb8d1a0bbddc4350eea:

  net/mlx5: Check device memory pointer before usage (2025-07-02 14:08:23 -0400)

----------------------------------------------------------------
Dragos Tatulea (2):
      net/mlx5: Small refactor for general object capabilities
      net/mlx5: Add IFC bits for PCIe Congestion Event object

Patrisious Haddad (2):
      net/mlx5: fs, add multiple prios to RDMA TRANSPORT steering domain
      net/mlx5: fs, fix RDMA TRANSPORT init cleanup flow

Stav Aviram (1):
      net/mlx5: Check device memory pointer before usage

 drivers/infiniband/hw/mlx5/dm.c                   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 44 ++++++++++++---
 drivers/net/ethernet/mellanox/mlx5/core/lib/dm.c  |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c    |  3 -
 include/linux/mlx5/fs.h                           |  2 +-
 include/linux/mlx5/mlx5_ifc.h                     | 67 +++++++++++++++++++----
 6 files changed, 96 insertions(+), 26 deletions(-)

