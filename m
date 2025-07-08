Return-Path: <linux-rdma+bounces-11986-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1072AFD991
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:18:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE02F17D6B7
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A646252906;
	Tue,  8 Jul 2025 21:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="EALHm7nD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2062.outbound.protection.outlook.com [40.107.101.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF13F24290E;
	Tue,  8 Jul 2025 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009436; cv=fail; b=GcIrvdPLaWqOCLJFSxxOmenINtm0PPiEL0l/Fp0SjbDipyH5dzXsbw44IZ5fWdhzEAf+oP4eSTZC7gWLyy5UiIU01TpZ+MOCHDQwyTSfGb6TOFSIYnfSnFg+dQq/TTIqiuB/r0gWjG8GIax49CmMcHz+V1uo08j9Zmjrv1MFEvM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009436; c=relaxed/simple;
	bh=ZXvORc40euWtYzoM9RV7uqqsUSV8PPlrNfUh/vBWv/c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ffl1RX6mo6rVV/XicZj9Uu5Hh6C6otdVNNXNEjQ7BSJ/8X40Q1fO1FMYxq6OA5duAcOOlJBm6p9d9CgzUFX51VboDueQfsec+L6GTnEJf86ZhZoa61S5wyo4CFNVa6Lk2fxVlau2fdBBM63QZsTEYh7sMkt0ydrctVopfZj1mCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=EALHm7nD; arc=fail smtp.client-ip=40.107.101.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gB16TrENWwRu/KUYrSNtFmgO+JIN7Hu2kppTJ/WX4tAzAUMP+SLfPthx0OgHrjimA6UI36NGLtAANMO9yvvVDC0C5aXktDe6PEQvD160g0k13MXFcUcCd0L7P2ELE0kWYDaPeFmzuNuiZihjedtizFsZAc7vNAxeEX513iknmS7kDFHGvo9aaEXch7oGK7tUHKmYOp4PfC49to1/yLeuRRUlChkvm+/WecvyjxsCNrunH42eP8cuDplrGkZpVsxvVxSAvnUBEHPmBgZyqds8VZXG5bpyIfVgN0PBA9MUvv8lgXsXVl7//JqPcanQY2Nfcnt38JtqwJVjZ8LwArxOSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6CuLR25B3OMon9JGm6TJlO4e5OoklkNXXy1q9LE3yg=;
 b=OIZI5avu+cmgvQ+1PIjNe+Q4HuHb7r4dqzrWR+vkDGJJ5FkpWLq4K2UJhSlPrwdqFNuUgdx3xGNARtSuODV5PZN/lutlOPUFWuQK9kde7pJYj6PNO8orixrdut1ULYkyLIXlpxvTd21cHpnoXtsuBT88DiHMGCpYuwGDYIpu+TqOfWdwCeY2n5+o7dyCk/uBuc18dq6y5k+RuCc4bogI93Rjgi5bskyo4h53buRMWooFCaoFk5wuwGstCw9QyfwTdIIOFRr0qEgah08dcoaDTpOrh7zgovdw8tVWDHTXOSNbzhRz0exYvKhVf+Lmm8roLAJjcZVx7gIup4B2O+xdog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6CuLR25B3OMon9JGm6TJlO4e5OoklkNXXy1q9LE3yg=;
 b=EALHm7nDnjIj6rGKP4YOjddGNQ7TNkuJJB0GZ0P1NSRFAblaYltax/z4Hmf+MkZr8b6uHssPekxxdvBF+LHaxheTrpfTmDnz/xe1op8NqUWVmZyqEjXQPq8Mm1s92d2ivKD6O2/h6UItS73KV+2EMV0clZi2lsmlEaOZpb3BsID+nhiu3E30bY2ZyLJuqLBu6vO30h9sk3/3N1Y0xxAQwE4cLoIJv6TeD/pmW6FGO3Lrxb/jfVpuLV8BPTIpLB5HiM/w4A+2GxO24RSJVBvXjtEcbV/5c1oa7sh43LvM7CFOZe1MK2/xUz8vyTmwdOWXDnJ2MdwpoYwISo8yRB74jg==
Received: from PH7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:510:33a::23)
 by DM4PR12MB8474.namprd12.prod.outlook.com (2603:10b6:8:181::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 8 Jul
 2025 21:17:11 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:510:33a:cafe::6a) by PH7P222CA0009.outlook.office365.com
 (2603:10b6:510:33a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 21:17:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 21:17:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:16:53 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 14:16:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:16:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Maor Gottlieb <maorg@nvidia.com>
Subject: [PATCH net-next 4/5] net/mlx5: Warn when write combining is not supported
Date: Wed, 9 Jul 2025 00:16:26 +0300
Message-ID: <1752009387-13300-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|DM4PR12MB8474:EE_
X-MS-Office365-Filtering-Correlation-Id: db0d4b39-b0f5-49d0-6d8d-08ddbe64cdc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|7416014|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6wOQqbp1eX/O2ZKY5Y0po2OwQWGYUBSamLGsHOwO476fCTojiiU0Nmidmuwo?=
 =?us-ascii?Q?CAhRAzKauU+bLiXkyPuuWJnh0eP96x5+aTgSZlmMLFtCwFpduQnXiQWORTEW?=
 =?us-ascii?Q?ylG6BjntU/i9yBOb86Sfk+hU3psUvBtZS//Hj0ORI0/I+L8fNGxxasgaECmo?=
 =?us-ascii?Q?uUmIaIKlxJ9gs4cNxV3IALl9dT1N2+xTR03d0Dq6mzdI9dYUHUI2feuY1hQ0?=
 =?us-ascii?Q?iznC2bBfvfxhEUAUnZE5YWJeQ8YBq51Ak8G51V7m8uGGSfIhvd0DRjzffBX5?=
 =?us-ascii?Q?kOF8PpZAVrTLvlt7ujE4ow2+vNsruB+DqCvxZFcWM5wWqtWhuAm7BzVPsHWi?=
 =?us-ascii?Q?PSb+fzvn5nDh0vpExquVf0f+MWekSZZynl6NwvmppGCpCROChd79gGc5ymOZ?=
 =?us-ascii?Q?4w2UCG0yj6ZAIJeZYnjzCKWn5mkE+IHwa/jRWzK+1IJFNOqxPFwJoUoQW/AQ?=
 =?us-ascii?Q?Lp5wBAljSWSF1bx+uwD3PJWA6uZO47CM3RVRsRMso+8ZU7RGd//nEGg0Jvjc?=
 =?us-ascii?Q?lcX6RBbFe7H44z3k0kgp+5A9WgEVY++2NgeRn187caocZRGieab2/SxuGO3X?=
 =?us-ascii?Q?/QZKAGptgDJv69o1Cw2pgWFk/n4pNfTSwLjqpdGpFzRbeYkE+hguyq1uFGYp?=
 =?us-ascii?Q?EJhe6JX2tB/vbfj0/lcBPojFsrAHUqNdLHgb9S6kk/SCpwByadUuc3KO7XRt?=
 =?us-ascii?Q?88N+PnwSq2gaBMDARCqCXdIEdq8He7kCOWBvKVp0UuIs/WGhJso/fF/zudLm?=
 =?us-ascii?Q?Ngg8XldbmJMkGjZcPyZuS95eB66Jv/IzLOImZI55KrGvOwbNKU6zf1ZsJM/Y?=
 =?us-ascii?Q?8Qqjy+bDzNivJnlr8YjZFdU8MC5CnZGCsHERQ/EZ4KyKrnJkr8wL8e4INsyM?=
 =?us-ascii?Q?Ap1oablNbXvFIf1BUnpQwGOKhFxqqAhuAvN3gCh2Mfr022U+84ggWHTJyHkG?=
 =?us-ascii?Q?qT1NsVDECMhw/wBjQPY215E4nWkvFB2rQqISbwOjeHNbAUk+Ady6L0PwqLf0?=
 =?us-ascii?Q?pmYRxKM14v3+JH0WSQFppBIYqdHBdnSZ86HQqR8RZkVcDJ5DE8+DIeLLeSZd?=
 =?us-ascii?Q?JJK6wFqk/wrZH6+EeYKCxJL82dArv3DzVg6iI+pN4NGGchbgwcUecItFqgDz?=
 =?us-ascii?Q?uXjIQxgA4bNV071/oxt1dOGhXr0T+H/lVV8DRHNzuOtb2O5hDwF761xojFNX?=
 =?us-ascii?Q?ZypXbWiS9tdETYp2P8v8mwdFEalWdLbNYSaJI24Wpd13CKSF+rfnJtJT1pN9?=
 =?us-ascii?Q?CcmsKdkWphVdYhOsl7uef3RcY5lRwEC5zpOSSwFlGcOpTSXS/XzLg9XD47pG?=
 =?us-ascii?Q?eD1vO/1JEb5IDNlGpMT+9cobF6VjLs3cKDA/y/rx7EnoPyHthnsrBHDc/AnN?=
 =?us-ascii?Q?zf5zcn1uFu0VvIcZCBcz58RWtor8hoEBxCAaymDpIEvxIZT5X5mjhCT81NPP?=
 =?us-ascii?Q?QSqcYR90wO8j2Wljr4UbRQKfWa7SiX4sN/9DsbbYytMKzoFX0FLnqoRieHiV?=
 =?us-ascii?Q?eBrWJxz0FGDOwK6W5TgRr4hNWSvr0YXDUx8I?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(7416014)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:17:11.3364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db0d4b39-b0f5-49d0-6d8d-08ddbe64cdc0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8474

From: Maor Gottlieb <maorg@nvidia.com>

Warn if write combining is not supported, as it can impact latency.
Add the warning message to be printed only when the driver actually
run the test and detect unsupported state, rather than when
inheriting parent's result for SFs.

Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/wc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/wc.c b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
index 740b719e7072..2f0316616fa4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/wc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/wc.c
@@ -378,6 +378,9 @@ static void mlx5_core_test_wc(struct mlx5_core_dev *mdev)
 	mlx5_free_bfreg(mdev, &sq->bfreg);
 err_alloc_bfreg:
 	kfree(sq);
+
+	if (mdev->wc_state == MLX5_WC_STATE_UNSUPPORTED)
+		mlx5_core_warn(mdev, "Write combining is not supported\n");
 }
 
 bool mlx5_wc_support_get(struct mlx5_core_dev *mdev)
-- 
2.31.1


