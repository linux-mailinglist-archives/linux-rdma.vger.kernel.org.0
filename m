Return-Path: <linux-rdma+bounces-14333-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B4CC43ADA
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:39:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A1AB188A922
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F3252D5924;
	Sun,  9 Nov 2025 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AeQFs0Hz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FDA32D46A9;
	Sun,  9 Nov 2025 09:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681153; cv=fail; b=lF7Coxj93g2Y0Qkh9ILqk7Aq3qm7aYY0pdaww7/IGHtdfHAoU6kILbxz8PYahttLd/ywKR6uaG/+JEvB2XOSD+4yTF9JJcyjO/TYoCvzUeYy48cj1oak3/FP0BdSq+aKD9cA5D96huah/mvjOgdJMCs1H16JWUar0f/ZCffy+OQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681153; c=relaxed/simple;
	bh=7KFRU5If7RpDwTCjwSRyelnXWgLyDRQKTMNNZhllPwA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XvjFVHLei8wjdlhtdwG1lR2KtRc04YVUcwtJS71rJNg+sP1k79CD59s638RFq7ofx/G8b0/6wwRBojxS8F+g4I18psFYD2EdAXrTFKER3jCzJZBYrRTORBo1+HKjYT1W47mGr3zQnOHTZqxXEk4QLd4LRzuLw5kisa204sR4AD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AeQFs0Hz; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNSndxgQcOg/3g7wEl/NUF2Xc0uMp6e1CgWCWODK+SdWG1dCykFj4Z8TpkzVcsHDM7WoXZcljZEWBB7/HQ4D8bPjJHminebwl0DWDJ/xPL7byzKpl4kdbNkxtXwAsi4dMmhq6Et1h5Q2acey9vXm6VWNSPCO9dm0AwI6G4b1Pztg39oMRizbGBa2CilDx/nHcQoD6k/TV4nw1MHme8sFHwGTWN7qwEmfFymfP3q7ACeCZ0okOFY3glgMDSj8ATQlZUE4qAKFqi2X23cVBy+X07mYghvQCVxbaQB2KVBnhpyYTRE5myro+5Ue4WN5SiPo/m+10mzlkDKnodiYEc+BEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b83Zi2fmnHnD3HAco1an6+x556DSd3W/H+dmHBuseQA=;
 b=NBgUcM7asPsP1vOkVq0IlMuagz/zPdMg7cOBwCzrODHLENicnitdXtzxNqlyoUt57Y4z2rHAv5kOWOprdZp1vpUaiGTUnVUEv5+/FBzUtUUz95QOt+ERI/ozEMXe/caLEPI6JvDZlkOIEi1L2pwVoBwcTdMakaFN/aDr1OSjoy+msvSpY1bkFRO0sNUP34YTuTITxjiBwZAqj13h71opnSwb9TmXQnrEVnwB9uYyS0ayDuNu+4lCkVtXxAnBvyUKQB7iRZb4r09wYPHvgfa/63HsDvmFivCraBAlD9pMp9jMHNdjnPC2lLu+YeIjMjWkrTMkJpkOFFsSk5qwZW9S5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b83Zi2fmnHnD3HAco1an6+x556DSd3W/H+dmHBuseQA=;
 b=AeQFs0Hz2xOA/r5zqCzCGhLaIJN0is3/AvyBGGqY1Gwz2o9t5msn9yjRV60eiLMFwMQ2mY6A+Vo2nZ/HluoD6qpOCdE1yzACnq3AR7GmFAhVr5V2gIIVilY5yrIaUU6yHqNWx8L5wnzZfVT8UTXeSzjTA8PskGpo7rehCPRYAx1fUKH7MzE1xfAefD2SDT5ugeLKxU1N36wfXwD4WmzYOxkFgfo0uaG9qsX4UZY0+4yCCeb4OENJdHD5fGphBCRwmtSrWgIlfLs2sy3S7ljF+i0O9wr8UaA2xx4+iaY7v8VwbZdIvMS2dVRZhhwXy6YZmjpwcMBK8P33gZC24AbL2Q==
Received: from DS7PR03CA0022.namprd03.prod.outlook.com (2603:10b6:5:3b8::27)
 by CY1PR12MB9583.namprd12.prod.outlook.com (2603:10b6:930:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 09:39:08 +0000
Received: from CH3PEPF00000016.namprd21.prod.outlook.com
 (2603:10b6:5:3b8:cafe::56) by DS7PR03CA0022.outlook.office365.com
 (2603:10b6:5:3b8::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.15 via Frontend Transport; Sun,
 9 Nov 2025 09:39:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000016.mail.protection.outlook.com (10.167.244.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Sun, 9 Nov 2025 09:39:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:39:00 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:38:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 9 Nov
 2025 01:38:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>
Subject: [PATCH net 3/5] net/mlx5e: Fix maxrate wraparound in threshold between units
Date: Sun, 9 Nov 2025 11:37:51 +0200
Message-ID: <1762681073-1084058-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
References: <1762681073-1084058-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000016:EE_|CY1PR12MB9583:EE_
X-MS-Office365-Filtering-Correlation-Id: 31e2e684-81ab-4981-2320-08de1f73d48e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rppV0HIo9+y0peu8hGEGrpN8sSrXMwg/0qkyMnzrw2pFwDDlKWPNI+mCxPAj?=
 =?us-ascii?Q?+2a8+ncQ0HWc8XU4y28U3P9xecntX0a1GGnYhEXoQFCHFVDym3P/zh8aQihd?=
 =?us-ascii?Q?A6jpbZR/T/PUmt0NCgJSXNM6YRvhOXjoDgMn4p7ggKJLuEeMgLi32UlC+fCK?=
 =?us-ascii?Q?abLWzQeqtAn+bIhiINdDr/VSjjz4Y6Z7PqiiGBM5kDtrz59TVvK6lMBcwtRn?=
 =?us-ascii?Q?rDCUGXQSF7c6kTprgdLyUqPicMSHTego0+PfX22P7oSw9IcNfhob5EWlm9KB?=
 =?us-ascii?Q?Jg4r5loYPPsjbMjDXzhIiQF5KcKpSd2T/E+/Eggr7SV0iRaDiejY3m8ZRDpS?=
 =?us-ascii?Q?ZdC7aegGgmHwyyyKOj3O75pe4lh3X+UC6wXXqg6z4uxgCm5PQ8T/JiDmoIXk?=
 =?us-ascii?Q?qZkloMeERMX5V1XJExSBj62Joj6bwZjdDqM05FvhidlFiqoANFG75CKI3lwK?=
 =?us-ascii?Q?G+vCMkutxmSYnBmFOVjC59VcJoBTbIyp90stgilOQvFy69Xfomy9mLbCnH4M?=
 =?us-ascii?Q?XSfc3e2wws3Pi9ScTjRZwFtJqH/XC5pBlbUv1sLP/jtY1kUpZNrlnGgNRbyU?=
 =?us-ascii?Q?VzlpMmnMMypahUiX6TuUvUaScQ8WZI9CqGrDzq3Rifm4JeGmcfvRQ21Skqnt?=
 =?us-ascii?Q?7XpnV0zhQUkxn+a8MN5482h2c8KKd5WyK7q7Wm+up9516t1y3wb/R2fNUa1Z?=
 =?us-ascii?Q?LRLkRFaXi/VhX1ybNpsQMdOcpRvwhOZB/AQO1seWSJk/yqeA2yka7to1ta4D?=
 =?us-ascii?Q?M1SxMxIOomCSWMTDG3vUZMK7dzPsng8LsOJWc35EqqguchYN+Hr+XfjKKnBK?=
 =?us-ascii?Q?132kHbosX/EZ3tmV9aKWlLZKHlJ/3gqPMdJ3J/yRgwfWvMH1dUr1yXzlh/xv?=
 =?us-ascii?Q?ofUv+VlaX10FYPKhTAnHNxJCRVysyXWqwWw9ZI1MykzeaXT+oDj1KhtKlSJZ?=
 =?us-ascii?Q?JdvWvAtCx+Okq4DI2QrOpmxCw6H8O4eAKjUxcllGod+EImNr7QR7xGqf/oju?=
 =?us-ascii?Q?0k4vl2WLgwM4UB0llFyLNb7WZOlVCCPmfk2A/pttl3883d+VWYu1c1f1Rv3M?=
 =?us-ascii?Q?CbLy2E9iUYWUtIFvclDV5gRUFmS1WsWVIa7C8ZU64MdAYz9JxK8MG8e/h/ud?=
 =?us-ascii?Q?X2tVWh4MyOl42CPKlyD+3JewBAsAyze6U2Epoa90mRgKYGchKq1/qABJuvAY?=
 =?us-ascii?Q?BKcVzM7+HDG6K5ZvTKPM/KBEq5UwsqUoWyme3mBZvuiKiGXuPW+w1SSuLq8+?=
 =?us-ascii?Q?BpRNbpTcuD4tPwZtjdvWKO2tVdU69wLxfD8VuasMC0SAm47cpSvKtf9PMzAz?=
 =?us-ascii?Q?WZCSQmzXt0LSkvLIVcMmlCJ03lD5vClr23aU1wewUQ59DeB60FqkPJEmVOwf?=
 =?us-ascii?Q?64aAgs0jsPpB3OPwUatZ3IPFqjOWlpZqeoWm067+xZ7osdxqtt1Hzc8bN5H9?=
 =?us-ascii?Q?CakwkEsIxxfnSkKO+D74mzEfp/lOdXO27IVOfDPWlkUQua/39vGCEUR3S/Cx?=
 =?us-ascii?Q?kP5ri9u49sAflP7RAI2uxe0ZWNk46rKzpPFmZd4UYCHOwMh9zuy8Fc1wOS4s?=
 =?us-ascii?Q?p+3S+Qil+OFFlaqXsYU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 09:39:07.9295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31e2e684-81ab-4981-2320-08de1f73d48e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000016.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9583

From: Gal Pressman <gal@nvidia.com>

The previous calculation used roundup() which caused an overflow for
rates between 25.5Gbps and 26Gbps.
For example, a rate of 25.6Gbps would result in using 100Mbps units with
value of 256, which would overflow the 8 bits field.

Simplify the upper_limit_mbps calculation by removing the
unnecessary roundup, and adjust the comparison to use <= to correctly
handle the boundary condition.

Fixes: d8880795dabf ("net/mlx5e: Implement DCBNL IEEE max rate")
Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
index d166c0d5189e..345614471052 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dcbnl.c
@@ -595,18 +595,19 @@ static int mlx5e_dcbnl_ieee_setmaxrate(struct net_device *netdev,
 	struct mlx5_core_dev *mdev = priv->mdev;
 	u8 max_bw_value[IEEE_8021QAZ_MAX_TCS];
 	u8 max_bw_unit[IEEE_8021QAZ_MAX_TCS];
-	__u64 upper_limit_mbps = roundup(255 * MLX5E_100MB, MLX5E_1GB);
+	__u64 upper_limit_mbps;
 	int i;
 
 	memset(max_bw_value, 0, sizeof(max_bw_value));
 	memset(max_bw_unit, 0, sizeof(max_bw_unit));
+	upper_limit_mbps = 255 * MLX5E_100MB;
 
 	for (i = 0; i <= mlx5_max_tc(mdev); i++) {
 		if (!maxrate->tc_maxrate[i]) {
 			max_bw_unit[i]  = MLX5_BW_NO_LIMIT;
 			continue;
 		}
-		if (maxrate->tc_maxrate[i] < upper_limit_mbps) {
+		if (maxrate->tc_maxrate[i] <= upper_limit_mbps) {
 			max_bw_value[i] = div_u64(maxrate->tc_maxrate[i],
 						  MLX5E_100MB);
 			max_bw_value[i] = max_bw_value[i] ? max_bw_value[i] : 1;
-- 
2.31.1


