Return-Path: <linux-rdma+bounces-13973-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC51BFBDB6
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 14:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCC5618C82AE
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26620344059;
	Wed, 22 Oct 2025 12:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="rjvI/94L"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BA117C21B;
	Wed, 22 Oct 2025 12:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136244; cv=fail; b=Ea6R6nP4Uq3PDSZz1gpD04P+c0c/PFLtV8prc8qUlAAOF+umYqRLpye4BhnVM3CMpGoQCSgzXqLqR6nLB5yz01DRQmlck0m2psDtPaL6p9UsxXM6f0cBIXsAqiwQ9i3a7sIAWgCrBQJGr+A5RWAtyIiVqnxpITIto5BwN8+0PU8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136244; c=relaxed/simple;
	bh=CJ1nep80iULMppfRHqupTr4zuBsGh5ZhGNpDFLG3Z9A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=roi2oEDvgBZAx3OdGqAh6sV72HvH9B/fk74XiqFPE87h/mHDbRvzZsC+zsM2hGwYG5MZ8oPojo1/oia5bMsIl8FRNWCuH4noMe+oADLQU4eUuoJt2PkZNhnQyte3pPsdwZf7iYcZFAhmwhM2R0hBqFFgAfGPSXV/PhzufEtTPmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=rjvI/94L; arc=fail smtp.client-ip=52.101.46.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISIfLOCxqQP+5kK9hKgbtu0CYiCuSMFKMgD1AVJD/Wq9soK2vatRpOs5P4XMYPAOwYmTqB+be2wIjodDhKGwshv/n9BpniRCBW6fQeVA5zuntXTx+GCJ1N0kznQYeEsqNwk841E6YZbah7QMydnkgmJjXhhmpL5Mb+Ao8gxK5/fZuqbreFfoBmlcqDjikREQr7KzX/hBjFynMpZV4xf4muFEvxcAW1rFIAlSoqDMi0Y0Yxwj+JnLkPgeUlPYoFGpGOUcMjpQtEoxbxg1xbHSIVi3anA9/tBR6KmpTBvd7VtBBAGqptZXXogmswFX9xBLmEpav2NzUGINhv1Tv6DtMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BKk+WgVXUH5lB6Uw+xx9ypiAe3mulEP3YGiZj1gf8G4=;
 b=j3R03Y2k1edCxCWDN6wn3Ow+DRCsgxnvqVR90cV2mROZUUHPydW2Fr6PweeDR/4F4owcS/zmRHXEipi59G44t/vO9Abp9ULgbj7z0+DP6RGZFwdBcQhc1QUeO1Q9jU7lYUzgxl7c+k+dwKVuxGcmf3I6aq4fK44XJpjbcqaKWGmmoCCSJhGCBkkHK1rW5U/ZO0lnxpjTqQyK7eMoDyT4z2WkvrMq7GiOmXasZvN6wyE05HH/2gqJGi9SaiG/CqGLeBmJc6qlE+E0DQjipYLC/XREpx3EuejEGRmcbWklcuXSMQ3Gb5HUv8wb0g/TgszBAPrYEETGUwZg0m6Cj2cNSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BKk+WgVXUH5lB6Uw+xx9ypiAe3mulEP3YGiZj1gf8G4=;
 b=rjvI/94LcgXC2GT9K60Uh7vikjS8DrL8SM9yJthurdmlvx5NKprhnEpHMmNIvzWr2V/tixGNP8LQhwW/dgxGmUcCDA+Vn89+kmRBsZJ5freTCuPbfLNfRTuW8Gv677b6su4eEyp4tr/WooOeK/BLGsJdzoNyBY+4Ljys58xQh2sONVrZogfAMwjgE2c/n9Np0MFzWVZkT0OUiMZVfR1c9vOIdD6mJePweqMWpRl498e45o0ctJWPW+NG+j2vqy7Tj1zAszml3yTaowU7T61WMTjvG8eoaAWGgf+6m3VjDThMJ2oBta/Lo9PvNjdhf7udGYq7D/HDsdkQ8YgmAq7LIA==
Received: from DM6PR14CA0062.namprd14.prod.outlook.com (2603:10b6:5:18f::39)
 by SJ2PR12MB9138.namprd12.prod.outlook.com (2603:10b6:a03:565::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Wed, 22 Oct
 2025 12:30:41 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:18f:cafe::89) by DM6PR14CA0062.outlook.office365.com
 (2603:10b6:5:18f::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Wed,
 22 Oct 2025 12:30:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 12:30:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 05:30:22 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:30:22 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 05:30:18 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Alexei Lazar
	<alazar@nvidia.com>
Subject: [PATCH net 2/4] net/mlx5e: Skip PPHCR register query if not supported by the device
Date: Wed, 22 Oct 2025 15:29:40 +0300
Message-ID: <1761136182-918470-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
References: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|SJ2PR12MB9138:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5e5d81-e128-4516-c869-08de1166d03c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zbkeRqhnME8il42hvHvpK2a/yMjcVQPd3VuxUg4TuF0/3MBdEt2x3Ic820ll?=
 =?us-ascii?Q?kljmpDBFsp1uKjDhNVqMbuBqwih28YjieO7bdEHG6qxLXSJIMd/xryuQWN0r?=
 =?us-ascii?Q?r8Z5t3+VT3tryzDEgDBBu/DpS0PWioJOEGzvhozg1qn3YTKAZd8zbA+J0W4m?=
 =?us-ascii?Q?9nOBiiDtkv/oWWcBgjIIEVc7Agb7YGpAkytTeNfctJqxLhqdQ7PTjiWGjrA2?=
 =?us-ascii?Q?VZYtkYqYY3/57DVyr4+j0m1WtA/neLrDgHqd+bIst4g9q/FSXLqBjUKfMEHF?=
 =?us-ascii?Q?UsbM0E+GwFqNpVr1oxx5v225/T9OmOXIG/GUUftwBjD4d+aqCEZqNAqYvqHb?=
 =?us-ascii?Q?D1sKXvD5fQrnA/YZXGppHlZ7eQGU4gaCMgmZwZoT13EJFagj2ofn+g9QojQx?=
 =?us-ascii?Q?I4eRPG//zKH8DltU2e1TeOygj//78iv6nr1SJ4kifgRV/YB8SSNvm/M0M2SM?=
 =?us-ascii?Q?nwHzRrR2KHUXXbyQRdhpvdbqLheoj9N3njserqPTcgeDbg9jp30uGQAI1su8?=
 =?us-ascii?Q?UO+VPtncxBx5RMdTRf5/sCwnTSspbMlbgXJ1zOUTnNTxO+yX0vdZzAjCfips?=
 =?us-ascii?Q?fd4r8+5fW4UioQ/6KWEYwGajRSrBb6PvHhITfaxfttwAuhkLpy9yVAlF4vbP?=
 =?us-ascii?Q?ZRJtL7q2qhij5jhTK0yb6FoCzW+0yLs6/M+RMU6WRRcM5gGydC+DbGOwRLxM?=
 =?us-ascii?Q?BjgSja1nZF75z5Abepb0cCdkf/jappKnRbBPMWY/7OlZXy9HySiceQS1GnGV?=
 =?us-ascii?Q?H5u60iaN5Q7pIGAvSC/oPwTzEuP/xtcK4mt7qGgRUGHXihuJ8g1qIFbOjTTP?=
 =?us-ascii?Q?ecWy/PfnIpE9vBpGkY/N627UDGgp1Qa3ASVzzabtKEBgLI1Pur2X/8lubabH?=
 =?us-ascii?Q?Ve8qpNCUkBvq8HAvOkcLy4J9dd3RI8pyUZuDuQK+pWY4ofMUFlKYaArCrXCX?=
 =?us-ascii?Q?0LSTJERhrDOrDNQ/IhnnlrBHh1KsW7dIfmq3cKCwKYmeLULAs7vdwn4eGvOs?=
 =?us-ascii?Q?WQkb6wlqgwoeypxLJf7EjOn3VY+l3Sak86ZiIReGkQlf8D/5objAPFi/s4ly?=
 =?us-ascii?Q?JUBK5DlwmqzRQ2PfKSGNP3f+sJkrFKMcWjzAVRKQ6ZOHbzZf3PNnWilizx2r?=
 =?us-ascii?Q?79Sj/RfGVKB91E1MUXtux/VZqwEBDUm1xUYBehlJSPSRNjOsrGmSehAfwV4+?=
 =?us-ascii?Q?QFEfmwdOMQqI8L75ftuBLEWfPftCR36lnyCJ5rC8HvCvzHPqOpjs37njJ+UU?=
 =?us-ascii?Q?nymDNLoGz3n0JiDh96SQx4ZHowMbScA3ai+aPnGdSenwL5dS+d+UbT4lsPv6?=
 =?us-ascii?Q?q9pMtFDSS5Ywd/oBY6E3d0nkcAqroNX4w4xNFL+yXVE5jDC5cRdfc+DvE1rv?=
 =?us-ascii?Q?sxCcJwT53wdGATRLtmU/7SMRVUWsvydw7Zou2txVNxHHyvdhYH5o6LZmq4PI?=
 =?us-ascii?Q?S92yfflMW3vShhwnyFc/erphziMM9dUE7VrkSFTf+FG0xF7RRsBHUfWnvOb4?=
 =?us-ascii?Q?5LUFOtlRmAzCNIB+IpXHaJZUQra6N3fBNm/EQH4LsPkDTMpzKExDXUQLEVd6?=
 =?us-ascii?Q?8buCIj7vcfaTOmPHceI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:30:40.9592
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5e5d81-e128-4516-c869-08de1166d03c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9138

From: Alexei Lazar <alazar@nvidia.com>

Check the PCAM supported registers mask before querying the PPHCR
register, as it is not supported in older devices.

Fixes: 44907e7c8fd0 ("net/mlx5e: Add logic to read RS-FEC histogram bin ranges from PPHCR")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 7c029a7d0fd7..a2802cfc9b98 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1614,7 +1614,9 @@ void mlx5e_stats_fec_get(struct mlx5e_priv *priv,
 
 	fec_set_corrected_bits_total(priv, fec_stats);
 	fec_set_block_stats(priv, mode, fec_stats);
-	fec_set_histograms_stats(priv, mode, hist);
+
+	if (MLX5_CAP_PCAM_REG(priv->mdev, pphcr))
+		fec_set_histograms_stats(priv, mode, hist);
 }
 
 #define PPORT_ETH_EXT_OFF(c) \
-- 
2.31.1


