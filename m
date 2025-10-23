Return-Path: <linux-rdma+bounces-14006-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E3FC0033A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 11:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA3381A6428A
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 09:19:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED7292FFF80;
	Thu, 23 Oct 2025 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WeC1Sa+j"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D5C2FDC38;
	Thu, 23 Oct 2025 09:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761211076; cv=fail; b=hOqbGgrvoO+Oa+xzIegHhxVkEs7rfFaneNIqoJDVlz1IaYXTN+znBGl0vQsZLxuw6M/4NZ3skAaN6TNkYiVvo8FFaUsJMCAMoyDhs3H578N0LawuvfQY6vSnWXfneJq2g8tiW+ffENvzPtJLK+Mg87Su+bPXRWS6Hbf+RoFaAr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761211076; c=relaxed/simple;
	bh=6kO3s0xbNvRxlf73REkWk+MZsE/1j+yNhcD/fn37Yo8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hXrqN2guv55PRvsYMKKW3FjmK081XiEWOI3PEzGCtQD16scmItamv1/9Sh4Q699EsAGpqwR1aOzj+qglMymxp/vzE1ZaIcE+Bu+tHoJfq/cnb7a5FmyK7kdPsk0OMpXndh6IctGHjsLIiPuryRV/lv5uOSVVW1IVR9SfW8rMEew=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WeC1Sa+j; arc=fail smtp.client-ip=52.101.52.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TRhr7O+GH87wuSqZ3t43ahq/o/iiOhM3O8Wakw49lTN93snehLvv1c9cnkEoP5mGsGsK/toyj2YkEVOVLT47JLX/5XcBKSddUxLPfayxqT48NFTf0ajkliitA89qtb5PI08G9erF6w8Ls9fTbGJDdf31gUqOy85h7b6wsSoVlxeVViOAQ0asI/k+apQpc+UjCAXPs/oILOmVE/xa7bTGLQH86y3UwoKd8ZvF7kzhJvW9zPASw+XiVF9CiECdOBsr/LXbiueGF+y1cFiXJH/Cg+jvWUiXXRpR97909jtGEYrBanlA21SbZqwniaa6MBdOW7Tw+2mMVNCSCjwqk/WXcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8E6w7BVRT33imtbuI1jUeAKrD5LLHiJYWPxLgdlABoY=;
 b=NJZw/rBU0OWc1nSwOl2v3p8+ZvNSVJoR9EPa2NaMGkcSODxI383+t6wxoEx3K2odRVSy+bU06+bIv3RxTfKRuVdK16cSLPBjoKh4RuaP4S/pcwwV2W6HMfg5s13W7AOBUCChRPlfuxe0WrMApGei9wtGO6vsTSKRfz+Zx0/kOd3ICQvi3KMtPXU4YQnMB30VlKvoYlUZZVj+IwMtRsX3C0PbNeaBedhRlwqIM6yb4RlTfg4W+Jl4bPUIiMZHdPWHs8xbPQ7SMI5dWIjV/YvZ7UIiw9nufZNw2MuCVRB8C4sws9PrXRVK3x8wOHMIysIAGqf02CV5mmWYBApyTQPvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8E6w7BVRT33imtbuI1jUeAKrD5LLHiJYWPxLgdlABoY=;
 b=WeC1Sa+jE9fh+yq3RRD/Z5C03H4yPaGKxPsSurnLcHoiI4p9487U6g1L0ER9Stbv+BhKkzrcoM9+/k7EJghcJCRCIRpGXL0f+q8zF52c7R3UP6YSmiM8V6RtIXVXWic9rR/ke9XyxqdwRwPhYODE/EI7I9Exmn270athMQLnWueRAaDDFd/X9sDEnRRT/4mYZ5q4+feAMa15nT6k4EpDdDEX8ALF/f9k5hhMjlSXfTvUHHR9oGq+51e7OTRJfEuUb9mv+nRe6I2OIs1zE695ITJKjyTbMuFONVsabay0L/OFiociBSVIp2aLgZZgYuVodPwIPRXdZr3R2bxAXiwLxw==
Received: from SJ0PR13CA0191.namprd13.prod.outlook.com (2603:10b6:a03:2c3::16)
 by IA0PR12MB8863.namprd12.prod.outlook.com (2603:10b6:208:488::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Thu, 23 Oct
 2025 09:17:49 +0000
Received: from SJ1PEPF000026C7.namprd04.prod.outlook.com
 (2603:10b6:a03:2c3:cafe::f3) by SJ0PR13CA0191.outlook.office365.com
 (2603:10b6:a03:2c3::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 09:17:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000026C7.mail.protection.outlook.com (10.167.244.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 09:17:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 23 Oct
 2025 02:17:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 23 Oct
 2025 02:17:36 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 23
 Oct 2025 02:17:32 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Shay Drori <shayd@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5: Use common mlx5_same_hw_devs function
Date: Thu, 23 Oct 2025 12:16:56 +0300
Message-ID: <1761211020-925651-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C7:EE_|IA0PR12MB8863:EE_
X-MS-Office365-Filtering-Correlation-Id: 7338cfab-8f75-4e8c-cce1-08de12150982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?G/i0HuoIhkguBfi6MOAXHgbDs9sHM3vuZjiyw4tSARDzm6F/bQrA3ULjQSdC?=
 =?us-ascii?Q?8TAQr8tQEMGds4ERAjliw0wWhCpzOWaP2TB3QONZRmtbhBlUYAA23S2Q357R?=
 =?us-ascii?Q?cwdIax9BGWo0okkXAASbGZu4pb6kDlxcsd2om9h6YXbwFhnIRaRRWOOE2twh?=
 =?us-ascii?Q?tagpQOApmE8vCgWI/nlSz1TOzqoCDqsS1F1Hui4SCk2l66wpiUdZ03stq243?=
 =?us-ascii?Q?T6u1lCEImjjVNwdrbXRX2+c4EhsmoFB0rrhDAAu2yv7T7CBLoaP0F6eQyowD?=
 =?us-ascii?Q?tlvZXjU68b8MwZBB6meSA+3jTcClu01KnhyAd4lHKcl/Zd3IuFpbWbapCmXV?=
 =?us-ascii?Q?XE4RG5KUPLM758mva1j/gIUWyBVDJt+Sdx3Uo1r8X3IG5E1UgM3U06H1d/aT?=
 =?us-ascii?Q?rnmByW6MKJ2Ny3PRcIBocLTg3vmjTL2+eeu3PZazN7Sfn4IMrzAEwROVtMNi?=
 =?us-ascii?Q?k9jXT9DMUCACY1A/Pufr+f9MKS5HcS34y0EuvG5hcf1WXYYUHT+qocu/oUnT?=
 =?us-ascii?Q?NHmRgtZ6e40xCmab/EkR3w7VB+dvweHM+j3h78Kja1rh3qe7m4KMRLAhN+Zg?=
 =?us-ascii?Q?Xjq4sqUgEwig0AN4TWErCMP9AEMX7tYHM3d7uNhgwQvsWjjw/PupJn9IAYb9?=
 =?us-ascii?Q?6w+rEnqlycqrFUgmvJYlV3GZmfegdrpZvL/+hcxISUqgXEe7aXz5cXLF9gZw?=
 =?us-ascii?Q?g6V4r93CQNFom1tndIic+hpOLMvxuVNn0uCEYpNFWUywDqophmjRiRgCJAGs?=
 =?us-ascii?Q?0a4GL4+LIwHpL4p0dcZZTMBaVIEPLC8K2qYwtCrjbOwEJ7fNPInKYyy4T/V8?=
 =?us-ascii?Q?ZHPn4bQM9jPPxhnsJXBXY+8K1olHkL4g/G4fkHlGgyTudntShtprT8F51uDH?=
 =?us-ascii?Q?U0geEu4DiD1SsQRq1YzKhC4QkjieJYOS/mR/2P38iYahHNdQRAoyR9X6jNl8?=
 =?us-ascii?Q?cF8fWwxR37Y0ylEMggzbKkZacilANPhJFlxZhlvyuMZkhN4IwmZSdI+KUsbb?=
 =?us-ascii?Q?t1CrUOGdjhln7TiYnDTHD3I9RppSvp1GjFqKwef+cOnOICF1ucK9PtvE4Mhc?=
 =?us-ascii?Q?DLNtCrASQisM4AjmlzZn3LLRrN4qqvbvVavMwKJCvN+qKc2fxFzjoLSgw7rq?=
 =?us-ascii?Q?LPsfwDi6up+RJ0U64I38qu3+JtBO3PUIC39vLEQVB/HIPQuhDPNCAW8KDWqd?=
 =?us-ascii?Q?FQQWVXeDdJhgrvMzvKDkI3oiNVPbMbzZQJPUn9af01KKpW5txmlXy9FIy4bY?=
 =?us-ascii?Q?cOi4UI1EdUegqyljUfXPqpnH1L5QHIgN55cc0iBMhWlsXg1UVc7yhrAGPSZc?=
 =?us-ascii?Q?jZVegKj64v5FSMRHMVQQcqfhl1ao9EbN89eXawUK7M0Gy+DUum3bLJRXbvvx?=
 =?us-ascii?Q?LYonRr/Fus8G+/PJ/3HJajR3gMoeGqcb6AOQQNML22ntB/XYMaZQke/OPhN/?=
 =?us-ascii?Q?/2CI4q49c9IabLi8h169MSkxbfNWp7B4gt1KL4uKb2wZtZMJXzrU2pVOg72C?=
 =?us-ascii?Q?Ul3kaLThEg6niODiO9Sjh6lfBXapvDrSSQzPXsfz2RJGfOaOjMiZflJschKm?=
 =?us-ascii?Q?x2/irkh8UKXoI9B0C94=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 09:17:49.5899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7338cfab-8f75-4e8c-cce1-08de12150982
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8863

From: Mark Bloch <mbloch@nvidia.com>

Refactor duplicate hardware device comparison code to use the common
mlx5_same_hw_devs() function instead of reimplementing system GUID
comparison logic in multiple places.

This cleanup eliminates code duplication in:
- Bridge representor device comparison.
- TC hardware device comparison.

Using the centralized function improves maintainability and ensures
consistent behavior across the driver.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c | 6 +-----
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c         | 6 +-----
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 9d1c677814e0..87a2ad69526d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -30,15 +30,11 @@ static bool mlx5_esw_bridge_dev_same_hw(struct net_device *dev, struct mlx5_eswi
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 	struct mlx5_core_dev *mdev, *esw_mdev;
-	u64 system_guid, esw_system_guid;
 
 	mdev = priv->mdev;
 	esw_mdev = esw->dev;
 
-	system_guid = mlx5_query_nic_system_image_guid(mdev);
-	esw_system_guid = mlx5_query_nic_system_image_guid(esw_mdev);
-
-	return system_guid == esw_system_guid;
+	return mlx5_same_hw_devs(mdev, esw_mdev);
 }
 
 static struct net_device *
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 00c2763e57ca..54ccfb4e6c4e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -3614,15 +3614,11 @@ static bool same_port_devs(struct mlx5e_priv *priv, struct mlx5e_priv *peer_priv
 bool mlx5e_same_hw_devs(struct mlx5e_priv *priv, struct mlx5e_priv *peer_priv)
 {
 	struct mlx5_core_dev *fmdev, *pmdev;
-	u64 fsystem_guid, psystem_guid;
 
 	fmdev = priv->mdev;
 	pmdev = peer_priv->mdev;
 
-	fsystem_guid = mlx5_query_nic_system_image_guid(fmdev);
-	psystem_guid = mlx5_query_nic_system_image_guid(pmdev);
-
-	return (fsystem_guid == psystem_guid);
+	return mlx5_same_hw_devs(fmdev, pmdev);
 }
 
 static int
-- 
2.31.1


