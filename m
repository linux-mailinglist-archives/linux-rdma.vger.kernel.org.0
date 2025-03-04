Return-Path: <linux-rdma+bounces-8329-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB63A4E6AB
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 17:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 762CF3BDA02
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 16:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535D12BF3EE;
	Tue,  4 Mar 2025 16:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FjRwchjA"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D7552BF3D5;
	Tue,  4 Mar 2025 16:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104446; cv=fail; b=ehEtlgwy3ZRnkqvV9/Xt2jMT+vX+qe9YsPbE/fHkxjy3Wa33KAHV4ob8PcvVu8IrNFO1h4thaliF5wgzc/N2Gw52i2uwCb/ZIMWqszmOTnXK3t83kOM3kfMPLCcK7qf9x3sv2AD4tgNX69mvwrnZEJRhWrPbjyI6uCwQLW2ZCWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104446; c=relaxed/simple;
	bh=vbBMya5dyrptzjYzQJU+2Us4X3lB0KCY/v7iO5I0QKw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EM6znC19QwCV1flH4U2/YTw6/Wattcfqp0sgwZGxpmY4s/RAsuBhLURHCkEiobEDUMuHj0h8HbYjcLUCT9D1OwoeatkaGFhez2jdfYb89ILZqLYFNDfTm1kEtdy38Tu+LHPwNIMkBeLRtR5fp4xV0ubiAVd/XvTrfBiXGLMkDBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FjRwchjA; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uB0aWw/4sxC7lJI9+ivCthkF5Urefm/G9hbX5LxXClI1f8fQ4DNHe8kHPY4qceFHDnvrgQDhuxP6/dSVVpLXAtmQoa0Q5G4Qj6tVnxWh2+DX7BepRUFtJx+jzYobUfziMyvfQ0qsIa1R6NRI0OPi2xjyi7pCX3I5cKb1vwoIhG2WDIRZHkMxszVgTfBwywGxMIQ16VAQ0RlrmYCsdQt7DQ8dDpVXkj76oEnDJkEwQl5XPpWvEi7J8FRPnitYWwN+p5/Urwl/OzYAtawrIm5LfqnAAE2VCe5l087uSO+h1mbcx4g/AQ7Q4XPUpV8xKf5xxg6izxFA/SZQJRtKaY+vKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WjW0i5bvijxL0d/OsKFSEV0SsUfAdYPdT5U17Kn//M=;
 b=FDpTMJ5J6ZSSRFVKaJ7S67HwZ0+oaaYqjZIQLtet272WhQHBFHoleFTXNOrDXTaPGahqTPphcYeLDIW7RvZSxZIrNxPr8yus0J20nrg302QIETjWhR3tmcHHGIx4GggQ5Xmt5i3mq/FnztvU40ASkouNRHc+ymt+/8Y7SA3Kx73rXW6w8AMYCn53qDZsdB3O8fypLilT4BYe+tDscKHWRyxiBbhjIqCOmRlB2ZiSqP0gXtyeLor4yqWvHthtXyH1YdLGmAxzaj6V/d+g52MLxpZedhqW6TwkJxXi3QnRrBrK4puIi2yC216UR6IZ6NVKEQo/kXii1avO/azZWL7Icw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WjW0i5bvijxL0d/OsKFSEV0SsUfAdYPdT5U17Kn//M=;
 b=FjRwchjA+wm+radQBNEuPc2KYAYpwW7RNwiyhmpI3QTALFD+e8pFtvBWzQ3K/ktC9YznJqigiY+Pf/DkumQ+w6Qv+EFVGSFJsGZhzZ7hSQeEN8GuH1vM3IzllvTFDK9wo4qfYORbXMc3Njil9TKC2Msm1EOtx+XQy4IVceT+1e4wLccOvcPlXnZB3YT4vyW0XbGwvp4CsCN91wXlhEfOpSFhMw/jNPMmFCAxxkVb/vcAiBVLZMIHmqrsMkyC1gDj1vFYDle2qI9JTKn0bFU8ZRIWM/5U8MZJViU2vQ/dylRNCtvSM2fS/xhIyqXu8kjq9T/KGKZFGlkXJlGkFqcIPQ==
Received: from SN6PR04CA0078.namprd04.prod.outlook.com (2603:10b6:805:f2::19)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.25; Tue, 4 Mar
 2025 16:07:18 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:805:f2:cafe::1) by SN6PR04CA0078.outlook.office365.com
 (2603:10b6:805:f2::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.28 via Frontend Transport; Tue,
 4 Mar 2025 16:07:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8511.15 via Frontend Transport; Tue, 4 Mar 2025 16:07:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 4 Mar 2025
 08:06:57 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 4 Mar
 2025 08:06:57 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 4 Mar
 2025 08:06:53 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Amir Tzin
	<amirtz@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next V2 4/6] net/mlx5: Lag, Enable Multiport E-Switch offloads on 8 ports LAG
Date: Tue, 4 Mar 2025 18:06:18 +0200
Message-ID: <20250304160620.417580-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250304160620.417580-1-tariqt@nvidia.com>
References: <20250304160620.417580-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: dadce33a-d0e1-477b-9a6d-08dd5b36a25c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6vk0V2UcY6tqDXBV6Ir0WPv1SwgZsIScWOGaZRkgrJZrrTjFirrFkxezx4MZ?=
 =?us-ascii?Q?zfK63krc/S56FSjakiYqtoQjGCDWk2j8so+sI3tSK2vBl23NNeN98Cs+2X/y?=
 =?us-ascii?Q?0rIdIoTmQ/0coHvq9sUcnNuui05AMY9vNrJ0a+YJS2T4p5OYps7qn7TtfpXP?=
 =?us-ascii?Q?/0Vz6uFxhbIr8zqJ9V77mVnepD5jtSPl/T5S83S/aivAe8eCz4B+dd+nO0CJ?=
 =?us-ascii?Q?mAGA60QaRxY0r8GPFGi49WTR+mvieop/StCB6RsMBmV1Y5P/v2p6cdgj3nQI?=
 =?us-ascii?Q?awmjsuu3n4GPI1al8zEaMTmQp5NED1rWsCrPHp40o8zex5Wdcx5Ky2/S56jm?=
 =?us-ascii?Q?RFZRZ/YqS+sD1rh1e22FIjFpHJgdW0X92ScMKSerxAexCJEJEMm15HzxcD/J?=
 =?us-ascii?Q?8dl1VWKdXhanIV++trsWExQ6669wjLZCt5TA8/z+qsMIns7m/yeVw9RPFWF9?=
 =?us-ascii?Q?U3hsqybWKBh9bgdKIMcnd7OsktHP+gAxGK3xmHyaead5BCIN8U4TDFPDtkmD?=
 =?us-ascii?Q?1Rxla3Tato5mMmpdQ/PpR/x/S3qqxRke2HviR19NpnurGia6lpxZxf0E7/KO?=
 =?us-ascii?Q?UoTcjMfbF05bS8Qp81ZRTlFJ1TWcOQJdoEEDuAGyL8Kb932KifR+RlPi5ZrV?=
 =?us-ascii?Q?2CInpDV1CbGmr9HRoOnBytkQc5RV6nKQOHainQbDQA7YHtaeMZVoZk1qWy+h?=
 =?us-ascii?Q?xsTVFEm3LQDngCBYXkqra5TByhNCEctjQtGWJSrzozIMxwqOKg3RcHCrYLTA?=
 =?us-ascii?Q?S/Oy5Ae4FS9VcwyvDq3qG+H8acF68uuxghHoBFqc5DwS9YYMk5P5hjI8pOBn?=
 =?us-ascii?Q?efaGbBp1Dh4nn0WwVzfxemY5nZwHPlLkbxraqp0PDKF5dL6gN2SadWO90P78?=
 =?us-ascii?Q?n+KA5Ts70xar7MZscUCxvOr085ZujVWG0VP1DPsZ/ejtCu40jjvK25FEZ9Nr?=
 =?us-ascii?Q?nQQ1y1TAoAia3N5xYd9Io679ekSbU4xR1EXRR56dnP4BffSgRgXp7dEjPPR7?=
 =?us-ascii?Q?d6utkHKq+UR9W1+O6xvfB5mZ91VGb1uxJiJg5LUy53o5iTeLxUOI/szwkpBQ?=
 =?us-ascii?Q?0+DjNjl8FW5J0iKlEVx359MrXFnVxZv+CqVeFYqlT+cQ+StyeVMF23yBSp71?=
 =?us-ascii?Q?521XaQI2m8DpCnui/iRcI03CmwAmbZBGb9RONPn0pnRwCOxyYqFBofx/v3Lj?=
 =?us-ascii?Q?Rm60eu1u7ZAhjDH/DHJNqJgeHaF5Xxyi/JABkCyA3eFHhfqy7X5JtviEQGUt?=
 =?us-ascii?Q?adOXrc9Q4PGzppGnn5ycyLwVggK16afaft5avwnD9hMnyL0OTi1eX01sVXUd?=
 =?us-ascii?Q?1G1Kfass6ccIuvzsYkwH5Z2PRYNgEt57aDzlb1JI7LGcuzhyHVOtZhgnlyGt?=
 =?us-ascii?Q?3fzNjFirBa2MBjykRHMKMqjRbGX/n6jefUv7AA1I3LTYUBVYaHbKOrJBBCc/?=
 =?us-ascii?Q?+o1KmyaVA/+gFtsdjjdKunSBAdV0aT6npcAJq1UDcy8+gWQV730RIWWN+7Fj?=
 =?us-ascii?Q?VdKOBlTHuZfjL7Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2025 16:07:16.5255
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dadce33a-d0e1-477b-9a6d-08dd5b36a25c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902

From: Amir Tzin <amirtz@nvidia.com>

Patch [1] added mlx5 driver support for 8 ports HCAs which are available
since ConnectX-8. Now that Multiport E-Switch is tested, we can enable
it by removing flag MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS.

[1]
commit e0e6adfe8c20 ("net/mlx5: Enable 8 ports LAG")

Signed-off-by: Amir Tzin <amirtz@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index ffac0bd6c895..cbde54324059 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -65,7 +65,6 @@ static int mlx5_mpesw_metadata_set(struct mlx5_lag *ldev)
 	return err;
 }
 
-#define MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS 4
 static int enable_mpesw(struct mlx5_lag *ldev)
 {
 	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
@@ -77,9 +76,6 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 		return -EINVAL;
 
 	dev0 = ldev->pf[idx].dev;
-	if (ldev->ports > MLX5_LAG_MPESW_OFFLOADS_SUPPORTED_PORTS)
-		return -EOPNOTSUPP;
-
 	if (mlx5_eswitch_mode(dev0) != MLX5_ESWITCH_OFFLOADS ||
 	    !MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table) ||
 	    !MLX5_CAP_GEN(dev0, create_lag_when_not_master_up) ||
-- 
2.45.0


