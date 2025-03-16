Return-Path: <linux-rdma+bounces-8729-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E8A634A4
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 09:15:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE06C7A8469
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 08:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E2F18DB01;
	Sun, 16 Mar 2025 08:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hEIoG6XS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8963E199E8D;
	Sun, 16 Mar 2025 08:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742112910; cv=fail; b=UefqixSh8CzWY2jpvx9Q/707vtvZ4NAtzlGg3v5ozAL1mmn3ZCJwMZ6iuZk5T8aR67KTuKrBblx4Pl7eGQuHbZuWCR5VmPkJxSz3FQCllm9A28DfAthC+mNtMt/LrtMF0kc9TuB3lT/7/K3e7MGjCSj9SJMVadmiXjH55kjyob8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742112910; c=relaxed/simple;
	bh=s8ySOmGCTGN0w+KkptSgkL2Kh0k4j+yDl8Ck7mSjTRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BgFOh1vI8DHXERTtRuo7M7dtEU5ALTHsMOGBO1VCw+Z3qSNZBaOkax1bRkfQk3IhUJpKQjRFzoKjTFFOxfV+cVDq1S6GSfy3+EZKHDagw+ibkaLoGAC/RYm5ChAp7Tm6vdhrUbVEcJqDQtJSODVBWT7m8Nyw67b59Zqm7nve3AA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hEIoG6XS; arc=fail smtp.client-ip=40.107.93.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HylwU62CUho0ilT1fEFnegO1kqX3A0nNozyBryI4wCebCEMNhEkUCwlVK8BoxpKvteLl5driEvvYeuSc2odphO3v1/fnWZ4h6TwjiRi/rygunlqGjaF4RyCpAFkWVl50qPmXLANlPsLoz/i7h06BITDcB5XDE+YrfTqHUSWM+inSW6rSkqmsn3ZvHnWDJCIxrL7dX/IcgDqMdZZEmgRTO2fdGnnF7dylwjfBvwyrUALVyBcvm2+LOwNnuI1F54h5sKqS6VVHL5JRCtyLW/in2hAa3XuZUSw0Zp6nrEVIK8XWA5S/dIfRNYrbItS7odP6VQY0QS0MC5CmEXTF+OVTpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yaTbK7jYh6Df1aIlAykHP4YeUitoVWVqGGS8xnAeniI=;
 b=emXRgVKI98iJrua/lWucRCgI0+vxCn5g1oD4nXd8Sg4CnBiiLOxLhLhAyS4z3EUnuGPow9oTOeSMg27PxOhs8xPqn95iIvXkZ0srmM/jZ90BurygBZd9kHXpNSLLifZ9C0HYUm6bs3cdqn80iBM3GT0q8x3l4VIUgwvNhgpdxEFHGOM428D315pw8nC8MSNNq2sZzcmxf8MKM/B6LQRn6tMG/DeRx2QY3sLj0RDW5JQ9aiznWzqgO+ZdDdfrwkFdoWM5BBWsTeJ8oDjOapjpHfKfhOI98Yq0C9lTbKouJ4xuE7BOfDSMBpF0Y+jKHfVxYQt0HAmZjYsNWQwXATqiyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yaTbK7jYh6Df1aIlAykHP4YeUitoVWVqGGS8xnAeniI=;
 b=hEIoG6XSAL+ccQHmYZ347L7RhAxAoxXmvFARWnBp7Z7ADdJAuApaJexEKgiESw6PJI7zJbJ0jhIaAliGDCpyD3tBD6loJ/SMGRseLCX11OfzbkXQfShxe2jGE/wyPTONyf487cvMHaKpLBBAr1hNwWKNudiBr9/gJMSg3l5CUVkkqwu/wSyj8pHuKHJOGLkF/8yuz1luDtEIwcip3cwtt3UUovOWhm0bo9jLRU3bq379+aKOE8GFuk+V6JNTlV1Ljz6umtmvB1L2plxI8UD/HqpoMWzR1oIL5hSYHYIzyHd4XZY+dM+LwujXvi3mzlnply7K9UQr0v/wzB8c5DknxQ==
Received: from DM6PR02CA0150.namprd02.prod.outlook.com (2603:10b6:5:332::17)
 by MW3PR12MB4490.namprd12.prod.outlook.com (2603:10b6:303:2f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.30; Sun, 16 Mar
 2025 08:15:04 +0000
Received: from CY4PEPF0000EE33.namprd05.prod.outlook.com
 (2603:10b6:5:332:cafe::ae) by DM6PR02CA0150.outlook.office365.com
 (2603:10b6:5:332::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.30 via Frontend Transport; Sun,
 16 Mar 2025 08:15:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE33.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 08:15:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Mar
 2025 01:15:01 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Mar 2025 01:15:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 16 Mar 2025 01:14:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Yael
 Chemla" <ychemla@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, "Jonathan
 Corbet" <corbet@lwn.net>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Kalesh Anakkur Purayil
	<kalesh-anakkur.purayil@broadcom.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Stanislav Fomichev <stfomichev@gmail.com>
Subject: [PATCH net-next V2 3/4] net/mlx5e: Get counter group size by FW capability
Date: Sun, 16 Mar 2025 10:14:35 +0200
Message-ID: <1742112876-2890-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
References: <1742112876-2890-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE33:EE_|MW3PR12MB4490:EE_
X-MS-Office365-Filtering-Correlation-Id: e88ec0c5-ef2a-4f91-ec24-08dd6462a7b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dsbmcAVF/OkYm5JOprB/3Xi/Pzg1e9PGUOTYZM1BCkTkCVG+4RAVgEBPe4xy?=
 =?us-ascii?Q?trwFunVDg92ByyVlHeiccfDipPS9e61bteicRRqmGs4nTVCC0gvSKe+ElZy6?=
 =?us-ascii?Q?BB6aAGZ4Yj7+Z5qo4TRQs4L880p/6ZV7zJZj60fZfiG1lOnUMy4hzAaXjIkn?=
 =?us-ascii?Q?r849srj/ZfcKxl/qCYDFm0UA8JFlvzz9pLWi2kxDBmDQO7Qoubn+udTc6Q7N?=
 =?us-ascii?Q?PptBPVfrYM5Seg9OTqQg/0CCEML/pxYP7ivz9KgsJmq6TmXVaOBEsUO3bEf+?=
 =?us-ascii?Q?+kwhhpJUnXiNpMItWmmdjhOnQ35AbkBddBv4iRebILwalsIPnfQePWM861HL?=
 =?us-ascii?Q?ykxf09san8FDwDwYhc85ePuz+zj3mhj/2s1eGJ895gx8DHifkcaaJCI+AOGk?=
 =?us-ascii?Q?mI+jj9lAyyjiHvLo+2trl03nbPq7Z8dE0FEV44My/Ix4FWgW55fSOOenngNO?=
 =?us-ascii?Q?ZlBup2xlfyVGpd1X+wTh5RrkX7kzOXg8JenvxfbIdc3uj70YLfwDZAlCyl4n?=
 =?us-ascii?Q?uLUuOn3Z5lpXRWDHRqmQZ2Cu7Qla0uYtfFO2RirZwexrA2T+jy7V/4jLmMNV?=
 =?us-ascii?Q?uOB33+ln+xzS9GIsbF0OMM+BuV3LMISGA+oEC9iRpgbOwCiLDH6L2we3JDVX?=
 =?us-ascii?Q?xwudMRzdpEiNHuVZ9eHbmqkRR7c2YCOKs7poSO5jvqJrDP1ZbSuLKsh+JKU6?=
 =?us-ascii?Q?n9RLPDhZ7XcCBC0ZpVWqmz8y5z4F3i1RyH+6BshCcptBS/dGI8UREGsOqZbA?=
 =?us-ascii?Q?r3cIrP+wbH6Xdq26w1n6mbdDxCLGHRvv+Tpjkn12g5+/+oDynzf9PSXPGTxc?=
 =?us-ascii?Q?EoUxVSgt6PR81AxNOlEuUflEgjB8/rgdVnCR2z5n6ennzdI4M7zW8RSM5wqq?=
 =?us-ascii?Q?PP1lEeEwW+FPiWCnYyBkhvtf3YRQWq9kaXATYWx60DEbTjGjpBNHDin346VG?=
 =?us-ascii?Q?Y4cCVfG4+ycXvjSf+9lv+k5AT/AHZyVQzbrudiIIFSb1IPlQhAIB9h7t1CdR?=
 =?us-ascii?Q?j9vNyyOaUE5n+3qfhnMfcXCeGugtyul7RO1qVK6psQO5kroUP5NJDw3mL1Lt?=
 =?us-ascii?Q?Iq+iJsUcBnkvcessHJ3QwvV0sjbQQyKPeQypAbMiRvXcMbSnSLKH3Nhn5Y6H?=
 =?us-ascii?Q?p8LJSpniV7DuUJbNBfjzboa3eC8uk22gqMaZGzxhqKMvrnbC0SWPlO7cgSUE?=
 =?us-ascii?Q?zxZhcUxUxf1JNtoICDYP1QvlPQrYwh6fKFFZcvy9TICiSHgzjWmXoKd09MhH?=
 =?us-ascii?Q?vm8OnAFhREVdsUJKz4PoRKItWQ+eqbWbnmf3CTfcsaWn7FYNL9nR5lGYPv03?=
 =?us-ascii?Q?Jxe/lULBRka9YCYSxyMo+fBYCGhjX7FHWSt+2EQmwucngMOEgqLH8Vc2KGwQ?=
 =?us-ascii?Q?aEuUizfh0SQ2Ueh6qrAtZb26j9ITumX2U6WBwsXU/fzyEXDQSCVi+JBqg4g7?=
 =?us-ascii?Q?ja411+BhJy7b5t6v8cda1cuTYTMrw7N4ZgpViwX5VPcY77I6zB1Jvkm1l09y?=
 =?us-ascii?Q?Chn08ylnmozKRCg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 08:15:03.8831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e88ec0c5-ef2a-4f91-ec24-08dd6462a7b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE33.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4490

From: Yael Chemla <ychemla@nvidia.com>

Retrieve the number of fields supported by each PPCNT counter group
based on the FW capability for this group.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 58 ++++++++++---------
 1 file changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 0cf0c920532f..a417962acfa9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1257,6 +1257,13 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_err_lanes_stats_desc)
 
+#define NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(dev) \
+	(MLX5_CAP_PCAM_FEATURE(dev, ppcnt_statistical_group) ? \
+	NUM_PPORT_PHY_STATISTICAL_COUNTERS : 0)
+#define NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(dev) \
+	(MLX5_CAP_PCAM_FEATURE(dev, per_lane_error_counters) ? \
+	NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS : 0)
+
 static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
@@ -1264,11 +1271,9 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 
 	num_stats = NUM_PPORT_PHY_LAYER_COUNTERS;
 
-	num_stats += MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group) ?
-		     NUM_PPORT_PHY_STATISTICAL_COUNTERS : 0;
+	num_stats += NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(mdev);
 
-	num_stats += MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters) ?
-		     NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS : 0;
+	num_stats += NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
 
 	return num_stats;
 }
@@ -1281,14 +1286,15 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 	for (i = 0; i < NUM_PPORT_PHY_LAYER_COUNTERS; i++)
 		ethtool_puts(data, pport_phy_layer_cntrs_stats_desc[i].format);
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-			ethtool_puts(data, pport_phy_statistical_stats_desc[i].format);
+	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(mdev); i++)
+		ethtool_puts(data, pport_phy_statistical_stats_desc[i].format);
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
-			ethtool_puts(data,
-				     pport_phy_statistical_err_lanes_stats_desc[i].format);
+	for (i = 0;
+	     i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
+	     i++)
+		ethtool_puts(data,
+			     pport_phy_statistical_err_lanes_stats_desc[i]
+			     .format);
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
@@ -1303,23 +1309,21 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 					.phy_counters,
 					pport_phy_layer_cntrs_stats_desc, i));
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-			mlx5e_ethtool_put_stat(
-				data,
-				MLX5E_READ_CTR64_BE(
-					&priv->stats.pport.phy_statistical_counters,
-					pport_phy_statistical_stats_desc, i));
+	for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_LOOPBACK_COUNTERS(mdev); i++)
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(
+				&priv->stats.pport.phy_statistical_counters,
+				pport_phy_statistical_stats_desc, i));
 
-	if (MLX5_CAP_PCAM_FEATURE(mdev, per_lane_error_counters))
-		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS; i++)
-			mlx5e_ethtool_put_stat(
-				data,
-				MLX5E_READ_CTR64_BE(
-					&priv->stats.pport
-						 .phy_statistical_counters,
-					pport_phy_statistical_err_lanes_stats_desc,
-					i));
+	for (i = 0;
+	     i < NUM_PPORT_PHY_STATISTICAL_PER_LANE_LOOPBACK_COUNTERS(mdev);
+	     i++)
+		mlx5e_ethtool_put_stat(
+			data,
+			MLX5E_READ_CTR64_BE(
+				&priv->stats.pport.phy_statistical_counters,
+				pport_phy_statistical_err_lanes_stats_desc, i));
 }
 
 static MLX5E_DECLARE_STATS_GRP_OP_UPDATE_STATS(phy)
-- 
2.31.1


