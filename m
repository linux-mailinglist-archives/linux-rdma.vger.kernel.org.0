Return-Path: <linux-rdma+bounces-14938-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CDE9CAFFD4
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Dec 2025 13:58:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ECB8530D47CE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Dec 2025 12:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF6B3322B70;
	Tue,  9 Dec 2025 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OagUDgO4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010005.outbound.protection.outlook.com [40.93.198.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC6E328635;
	Tue,  9 Dec 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765285010; cv=fail; b=iqW8hgmatIPCtsLdmLDLKRMpAi8xk8GlXdfr9kamZ3M8GyiYTHYcCKx0rsvMU7jXlw4a+vVL/NvqziUzj+oJ8kH2v7AglHWpCwCUhr3Wf/xFNPDynhdFZae81IFHc34QKa+8Zfeo/aM2hpTuAXRcLEo5FMybRNHz0IeV8eEoPK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765285010; c=relaxed/simple;
	bh=yjVlHpsIL8e7U4ktofbPqSwamYYn4u8sjCLLvlyLLs4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=inP20C+Pyl5xxALZPsvdkmNRjvA+pKkHe0cz2k+wVGokEkUPy5d+ajpDTEGHNm08+sM4gtRyTXr8TqmcLTN6AljTqiRjyFBjpp3Vcx4UFgHi2bnnqu+Q2D0CPFqEmuGitQs7Z+myU0RHdrgS1NabHH5UwkvbOtkzUYXrlhKxcR8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OagUDgO4; arc=fail smtp.client-ip=40.93.198.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o4HOLmEZ3zhPAk15dDJWADF4fE39cDgoZg5cCWNJ7gzj5iFYp8Z7iSizoMqeROEKnBUP4YnLB+E31RvrzaPKIYstt87zVWmWpSZ6djr0meNMzC1pcJx3YR3yevZpso7/+PlfiGnpCHHj46syyOmTPjf9jT/YxXhlw9aNE7utVAZ9qYjA/Khct0cln89ThhSadB3Iuw71iu4Dy6ZWcV+g+9O5DFmegFqlg+51Fc6/sIwBgz5HVhZA/gysQSvcEI4vfkkoMGaatliZ9w94doJZZJQ5Dw6G1VGiXEnmdBSpba+jbB85Z9hXHb+/FtzsxklbEqlqjv+8P1c2O0a/mlFPBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GUuSXIi7E6QRPUxv753YFm+evynWQCgky23IrOOzNwc=;
 b=Bj23Z2hyzM9w716Py4y825xfbKYDctqmEopLC2U5WD+dwr0k3xzSfVeQqfArI3kjODwGN/LjwU/cqLKsXiME6VTaMklyagJ48r+881TNY/J8qvHxCh+b1R3NyZSI4OBGsRaT5VD6xB0lQtjIRtYyXWews3zJV6NNMXp5ubWB4RK+8WoemT5ZQlhyPb8IAAPqX3c7ebqYipPcmnGEfCw5s5rY0Gdgz4I7+vC5y/fvwC6jQMDrIDtaZaz18GpbuPs3RM+FH7vtNjK+FUolLLA6xcagQ/IpAaSBahZlWyI98H3R9BuMHYX0PkribPwZu+xMZmFSITvNZC3mp6Lu58bKjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUuSXIi7E6QRPUxv753YFm+evynWQCgky23IrOOzNwc=;
 b=OagUDgO4NhqH/6t/bcvHU9Vw35aSMGSmp7B6w+cgIdKIhhdNwoALXxsibXH/J1EEE3swMlcXmL9ftcTjHsl5jw7qhz3nyQFCJ8mPA80IGQSNgjWYNGJgNS0KnmiHZnng0Fs+RS6ayTu0Gf6/zSlAIcrjSODalxWFjvWKlZDOSve7R9KEixrs/DXjhmVs1ESNOaz7p7VTE02JpBfX7U4t34G19ADxmuxQZ1/BZgLyjz9kU4YqfNW8iPxmorbQ2QbrXRzy+JGHK1YmuFKrbwnSbb0XIqjxELimMzG7ClvE58tefOWbUdbeHc/v01kUiKNZUXFESoqDWfWqTvCoR09KRg==
Received: from MN2PR07CA0011.namprd07.prod.outlook.com (2603:10b6:208:1a0::21)
 by SA5PPF8ECEC29A9.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8d5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.14; Tue, 9 Dec
 2025 12:56:45 +0000
Received: from BL02EPF0001A103.namprd05.prod.outlook.com
 (2603:10b6:208:1a0:cafe::22) by MN2PR07CA0011.outlook.office365.com
 (2603:10b6:208:1a0::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.14 via Frontend Transport; Tue,
 9 Dec 2025 12:56:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL02EPF0001A103.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9412.4 via Frontend Transport; Tue, 9 Dec 2025 12:56:45 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Dec
 2025 04:56:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 9 Dec 2025 04:56:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Tue, 9 Dec 2025 04:56:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Breno Leitao <leitao@debian.org>, Alexandre Cassen
	<acassen@corp.free.fr>
Subject: [PATCH net 1/9] net/mlx5: fw reset, clear reset requested on drain_fw_reset
Date: Tue, 9 Dec 2025 14:56:09 +0200
Message-ID: <1765284977-1363052-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
References: <1765284977-1363052-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A103:EE_|SA5PPF8ECEC29A9:EE_
X-MS-Office365-Filtering-Correlation-Id: 805226c6-bd7b-4326-4a14-08de3722685a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|7416014|1800799024|41080700001;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ai5LDom3qOS73w0+rxq33fDqyBjL+HdfcPjfcbKLmOQQH52JmDlN9+H3tpv/?=
 =?us-ascii?Q?KK6J/sRGhaCIdzk9HtveOpbgkpL7iyZ7O3jG4getva/gC7ASXV6hXnMZ5614?=
 =?us-ascii?Q?DXWvCx7a4IMiY5rLYqaRqxadxv3h8TP+IRMPVXKfNFe+EHKLP/q9a3GH77Gb?=
 =?us-ascii?Q?diBWURpCHCtfVx5XS0ZC3h1a64o6zAV4yLPwYzOyxwJfl+qwQUXv2f5Em9g3?=
 =?us-ascii?Q?2trrvPt+iWMwpLjZfMeQMsFplE6fVobBnNdoQpRgB5a+emaeoh25JJbHFKiM?=
 =?us-ascii?Q?7ms8BVLWHTxY14851LWhhj+oBXqwPnwF463ZgNpq4+HWYxIieVOa8HzWERGN?=
 =?us-ascii?Q?r8QYpZ+Sd0yY2OP4KG0lIDYljoaN9KxI0YVFW8s/sABhuf21dBaKsul/xgyT?=
 =?us-ascii?Q?DiGpZb6MnECz7Z+L3nqaXIFY9q8mHVIY82N3p6Q3UNw1FaSvWnyllFDPNLMe?=
 =?us-ascii?Q?DWKT0254i/bGBDanEzxkQ9qHly24SXHfZRiSCN23av8ZD8d5ailmqG8ahZXD?=
 =?us-ascii?Q?jWfkwnRdjERhG+7dFXxNa0svMIdKzWv3+Nep6FgZ/uOrbgHdzzjJ2SmO92tW?=
 =?us-ascii?Q?jCfV3CLh9zlWFiK5bsjQme7/WHGduHrgVvCNyHoseIE3zuHjqCKw6Hrfj/Py?=
 =?us-ascii?Q?8oVYddwg6QerAfGer28p9maO5STF4+CRucDhwXJHidpsYzzbZaugdscwOpUb?=
 =?us-ascii?Q?otPZ2sqyIoxUyUU7f+Ice0jOJlPanxSKYqNVAgYIV8AKQq5aaekKGFEe+w0A?=
 =?us-ascii?Q?Jl6yw7NpuEv1lzJj2R0ndCF4HNgtFj/ZUTe8ZNBAytrPso/6oS69UcwA/68g?=
 =?us-ascii?Q?nJdGmVYlbUZ5jRNYg/5vhGxVE1E24cHyv6Wu5zs/TDojf6Hdvpl9VLEnHxTk?=
 =?us-ascii?Q?3rbQ6aTrYwq5CdHl10QdqZmMUb1vKKFSWRbe90oELjuHlYhBn8xHRNTpsOS/?=
 =?us-ascii?Q?Jx8/ombKm5TkRSthzrAyqQUmrACmkKHXyKeNSj2YNb/j9I9cx0hIbbC4TNu7?=
 =?us-ascii?Q?kw/Vgy5RRLW5arKaSRiDuZhQA2ETxdSDtwtIZw7cPIAgM1DkaaHN3AdA5iY3?=
 =?us-ascii?Q?Q9Ww7/0FYag8NoNGEDeV12geTlRzDTNsp0lMKjSw7s9Icz9M5DKm32pt5qRr?=
 =?us-ascii?Q?k8i0dWDD5Ucia33LRN1VcVZUoSYlU6zhiYz9/lHTCZrOkyaW6Ge3a9M1l6OL?=
 =?us-ascii?Q?EDFxiA4J42uiov+okrOvUKS1TP9ZCpTSzzOdNqBwDmxByb6VHrKTMRH9+H4z?=
 =?us-ascii?Q?41DZSgEOXsnOqsjXFcHcH2oztecb8bPULyAU7P3SI7W3Gm98f8KLS3JakUiy?=
 =?us-ascii?Q?oSyvjZ5cROEGQNBfVo5bYQdfXjwSQbZ09XGChaTIQuCxhC5TJsSjBlNol6Z4?=
 =?us-ascii?Q?s+yNY2FhOFAfJVfH8QMLYdpG2Cge569q9c4wLSzWLCLD/vhdE+tVwncRPdpL?=
 =?us-ascii?Q?hWVKJMZw7yyh0XAYfyJ2bf10D9TK7eQ6H1XBpiKw28xTZNxnsvqelLx/yrFZ?=
 =?us-ascii?Q?5VvVNMGks59Ax6ksWmQk5Hut7WYDGqOMWkU/AkOXA+R/Wi7b/cUSoTvuuMJj?=
 =?us-ascii?Q?rWiw2qV6Mwu8vYQZ9wVohH4J9uLOzjmYkrtasdUG?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(7416014)(1800799024)(41080700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2025 12:56:45.0703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 805226c6-bd7b-4326-4a14-08de3722685a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A103.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8ECEC29A9

From: Moshe Shemesh <moshe@nvidia.com>

drain_fw_reset() waits for ongoing firmware reset events and blocks new
event handling, but does not clear the reset requested flag, and may
keep sync reset polling.

To fix it, call mlx5_sync_reset_clear_reset_requested() to clear the
flag, stop sync reset polling, and resume health polling, ensuring
health issues are still detected after the firmware reset drain.

Fixes: 16d42d313350 ("net/mlx5: Drain fw_reset when removing device")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
index 2bceb42c98cc..b81de792c181 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c
@@ -844,7 +844,8 @@ void mlx5_drain_fw_reset(struct mlx5_core_dev *dev)
 	cancel_work_sync(&fw_reset->reset_reload_work);
 	cancel_work_sync(&fw_reset->reset_now_work);
 	cancel_work_sync(&fw_reset->reset_abort_work);
-	cancel_delayed_work(&fw_reset->reset_timeout_work);
+	if (test_bit(MLX5_FW_RESET_FLAGS_RESET_REQUESTED, &fw_reset->reset_flags))
+		mlx5_sync_reset_clear_reset_requested(dev, true);
 }
 
 static const struct devlink_param mlx5_fw_reset_devlink_params[] = {
-- 
2.31.1


