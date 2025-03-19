Return-Path: <linux-rdma+bounces-8829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 30B21A68E70
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 15:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3D127AC2BB
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Mar 2025 14:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AC11B5EB5;
	Wed, 19 Mar 2025 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uTt7W+4I"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2055.outbound.protection.outlook.com [40.107.223.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95FA11B423B;
	Wed, 19 Mar 2025 14:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393076; cv=fail; b=h4gh7f9bBZpaGHLKTQde2lQHzNxjFxJOo7ZqllHDs+yM0aGFve75gHPEGEZoEUdlP/39i/e8B7OHM5rP94XyD/y0cUMWOvxhHJDprel3N1C3Yr5LMqvrVczYj6ezk1zEVrcZM/yMOsbVfBJvk5TNPuTQp1PyP7n7SsDt95LJ5Ck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393076; c=relaxed/simple;
	bh=ZxdCQL47AYn8wiTpsAOSL7SmIbCYQ58hBhEa3ydGUDQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HwahrJpgPQRKcmFC+gL+EXWBSWXtulyZsdLu1qPUw/e/i9RkFEaQLSpbQPDE7kZ2KMzuhc2A4T5zpOipP2PFdENsgfZVIyIzORMcK2tKD68auqln0IKzYMJDSQY/pbmBQie2dI0O/8Natmz1C09vA/ayHO1NZQECwzWTrhEShok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uTt7W+4I; arc=fail smtp.client-ip=40.107.223.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdaVWF2mwbBy5kQDufyDr3/yxFh1IA+4CrcO2GGaHc673ehb6lkXWdHUZmZ7QHmAmDRdkm+AVlGS0tW/xbFaifp/s5lNnoOxWBDjyfbBZwbp5Yx43FKE2+qLJudU8HvP4JjPF7rIakNKkX9i9eEmD2nNW0w/B9NRwJPQrsVnaNykLa/fm6HqXcIbdkTk7YSl5kIlbB/4uJGE99cO4d+qZhP1zYY0Acz1kDBy49zoPRqfS7RaDLWueLvMrGR+c335MBlYxH8/T3SxmaTiSQHkqWLZCmwduhBFMz1dvT79rFlFz83n5o/iq3p+g+j2RlSOJ3ZM/EwDVvpafyM1u8o/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bquFVaDaZ4vYT39WFhf0FTYWs6iccAsA33fQgwP39SY=;
 b=wmKaL5N8ZDRFNqjINJTbVM0GCle4yOUGwqPmHYdabUvv30XRcJ5NMTwOV2tZbEzQxbBF46PvxC2d1uViTSOPZAAPNdtvXgralKIvcc/zvcyTqibhOHVMaWclAvh58VffT4QCdSQz+AlEAYziff9+mEM4oWJxraVRcEQwqDP2kqA72OJjuup39Gc+dVHwa1ssDDyFSdewZr+wHyyN2GqZBQLUMYCL0foFNGdUv1jwuXTtQ0MKBGYIR06LUSrLt/IPllCyrBZRfwFDT5kuaxAq0WqeQC5Cak22Dlx+t0YzhbDirw6qN7QWGwXrEiZ97xeCRkwLSoXr0Kbix+gSmt5pGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bquFVaDaZ4vYT39WFhf0FTYWs6iccAsA33fQgwP39SY=;
 b=uTt7W+4IjJ1IKvJa6ethfYn3YdVwPYQllaMLmV2h5Ee5WScVhsKKR2VAkwQKyVERy9y6/d0FQgS+W70gPDa9dt4bwvApYzGO4w+6XYssE1/3GMTbulNkKEKagLwFnnFy8q3YqY5qcGZshURlQ/omtIJNB0ApN2dqejTg1tZ9d6f5UC3eMkLdWkmJ10IOs0x2sogAC9ayBlWsxGQyJn318W3wQxyHu3rpDIRRbTBdVjU8enD/xU0WMXJv3vGJfAwIGSt2oSVmmnlBJmobUYErKtHpoj2nI0L4rAmHfoGA4NwCAkETVIb3F5beEA9KJKvUDQCdn1hXvq3XVrUXW5rNbg==
Received: from MW4PR03CA0072.namprd03.prod.outlook.com (2603:10b6:303:b6::17)
 by PH7PR12MB8039.namprd12.prod.outlook.com (2603:10b6:510:26a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Wed, 19 Mar
 2025 14:04:28 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2603:10b6:303:b6:cafe::f2) by MW4PR03CA0072.outlook.office365.com
 (2603:10b6:303:b6::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 14:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 19 Mar 2025 14:04:27 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Mar
 2025 07:04:15 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 19 Mar 2025 07:04:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 19 Mar 2025 07:04:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next 1/5] net/mlx5: Lag, use port selection tables when available
Date: Wed, 19 Mar 2025 16:02:59 +0200
Message-ID: <1742392983-153050-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
References: <1742392983-153050-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|PH7PR12MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: be7c1365-8ffc-48fb-8e6d-08dd66eef603
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gk1jms/bRV71z0nVdrdx94pvd9LTjHAFu50lJki3G9OLF8X+mYTZuEceS1Yl?=
 =?us-ascii?Q?WCFw/ucXyvetIJk5hDfIoTUhZtSh3tf80TyrpTyaUyQbhSWQT5rmTpasIsLE?=
 =?us-ascii?Q?M2BgqSRo4JyPO/7kn5HmSimRgHVwdOBoW2nJww2EjoNVEWGu2t2TZNdlFpNX?=
 =?us-ascii?Q?7Hv3xfhjnnmdfp96UWEHps1xS7xuBys3I/1tzUv3VmP3vnHntsdyyDNR+90e?=
 =?us-ascii?Q?rgClbwrhu7RqarFPYBOyEmoECfksQ/loTLiQgLL5XB/g22346nhz78Gpx+FX?=
 =?us-ascii?Q?R32nbzd6U/hM+DbrFQtFPFYCezH0P4Iz1hOBcdM+86OsghNBC9u64dc2J/Ix?=
 =?us-ascii?Q?CFrAd5CUmWZwDoP0v1EnG8Tc+q0al8WVuGtl4LbC9Yusmw9g0M9lfXk9ocRW?=
 =?us-ascii?Q?MqjbW2Rlxi3XVE7dvdv5Xuq8PtgH2bDvEus9Wp4pHnkZI3hMLn1UMTJBrt1J?=
 =?us-ascii?Q?Y/GUDBKmEdpJ+52CEvt8TK1jvRNkCRDyiSW5ZEUL4xXOa9EjPGMAKtlI9Nzh?=
 =?us-ascii?Q?DliXB5aCSoFoCW1J06o24mbmP2oGOomy7iK4GRjRlIShavvZdhUbTmcRXHwe?=
 =?us-ascii?Q?I03y97PjgXfMLw1dCfDzRo1J9XCZgqItMOiw4W+gPdXRB0+64WJfuzf81XLO?=
 =?us-ascii?Q?cSwYPfTC4IiSgz9bGusY7+VN/yyq/v5ho1ZqYPecZL51siLXL2B3BFzZ0XaF?=
 =?us-ascii?Q?xGHAjvYTt9OLLfJa0T8xExBMlwsWTmjKFVahIzkC2RbmJ95gaHFUbxSNU1Lt?=
 =?us-ascii?Q?2fOr47WO7pfqECeovEbdkDFxZ3ChLQ7muv8FgnSdpMQgTAeiiXGivCPw/w8b?=
 =?us-ascii?Q?XI9ayNgWsuLWylo92S083fMDT5p0Oo1gBvEjVj5GtXybYaxUOwdbLnQC5VKM?=
 =?us-ascii?Q?Wwn31MwI9oOqeHvd6sPeGpLYVyZji/L9q7aWNZ8ESZD/IxzZ4kKEIb2logEE?=
 =?us-ascii?Q?rP87GkIQ+fnLMddFm0YDnHSwg0C7iptD0bFr1X6j1D9RVMYkMnLLBpA2NtWh?=
 =?us-ascii?Q?a3eaikHgDIVXZUc2Xo5ywBkDUpGqvw9wgyv+0/kJ7/3TQP2+sLB0lHbuQdwo?=
 =?us-ascii?Q?LNDR6Cif1FFPsq7mcelH9XP794EP/cK8TujN1pQkmSZWd/2wFoF/BpYcnmX8?=
 =?us-ascii?Q?XL6BPB0RF9suU0f0VYPNntBp58tzK5DdoLlcnOX/Vc0R1RZCPW0manfiIwM0?=
 =?us-ascii?Q?vH0j4+XssVPKTTxu7t/6X62U/U4ZnUvK4MnhlrK+hebbWE+nBaCnJ1BOManC?=
 =?us-ascii?Q?jQ0a7hBf6qV8bJN2kJqWI7aopqFT2M11dPR2sZpuyYQ2Rry0Zu1i3XQiVo8H?=
 =?us-ascii?Q?DrJAOPiDM8HJs/sk/kIDJwpnHkLLsabgMFumRzLOJUHNnZu42xffKAluH1Sg?=
 =?us-ascii?Q?8RPbP81abyLS5wEJvAJFBqe3B03cs/c8ObfzYQ27gacIHXknwzSasoapGlMo?=
 =?us-ascii?Q?urfsCIjpo54GyXi7IjznUNx5axO5san7i8T+YJMGCv5xfatTr6PUpw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 14:04:27.1375
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be7c1365-8ffc-48fb-8e6d-08dd66eef603
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8039

From: Mark Bloch <mbloch@nvidia.com>

As queue affinity is being deprecated and will no longer be supported
in the future, Always check for the presence of the port selection
namespace. When available, leverage it to distribute traffic
across the physical ports via steering, ensuring compatibility with
future NICs.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Maor Gottlieb <maorg@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/lag/lag.c | 38 +++++--------------
 1 file changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index ed2ba272946b..e856edf6bbb5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -584,8 +584,9 @@ void mlx5_modify_lag(struct mlx5_lag *ldev,
 	}
 }
 
-static int mlx5_lag_set_port_sel_mode_roce(struct mlx5_lag *ldev,
-					   unsigned long *flags)
+static int mlx5_lag_set_port_sel_mode(struct mlx5_lag *ldev,
+				      enum mlx5_lag_mode mode,
+				      unsigned long *flags)
 {
 	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_core_dev *dev0;
@@ -593,7 +594,12 @@ static int mlx5_lag_set_port_sel_mode_roce(struct mlx5_lag *ldev,
 	if (first_idx < 0)
 		return -EINVAL;
 
+	if (mode == MLX5_LAG_MODE_MPESW ||
+	    mode == MLX5_LAG_MODE_MULTIPATH)
+		return 0;
+
 	dev0 = ldev->pf[first_idx].dev;
+
 	if (!MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table)) {
 		if (ldev->ports > 2)
 			return -EINVAL;
@@ -608,32 +614,10 @@ static int mlx5_lag_set_port_sel_mode_roce(struct mlx5_lag *ldev,
 	return 0;
 }
 
-static void mlx5_lag_set_port_sel_mode_offloads(struct mlx5_lag *ldev,
-						struct lag_tracker *tracker,
-						enum mlx5_lag_mode mode,
-						unsigned long *flags)
-{
-	int first_idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
-	struct lag_func *dev0;
-
-	if (first_idx < 0 || mode == MLX5_LAG_MODE_MPESW)
-		return;
-
-	dev0 = &ldev->pf[first_idx];
-	if (MLX5_CAP_PORT_SELECTION(dev0->dev, port_select_flow_table) &&
-	    tracker->tx_type == NETDEV_LAG_TX_TYPE_HASH) {
-		if (ldev->ports > 2)
-			ldev->buckets = MLX5_LAG_MAX_HASH_BUCKETS;
-		set_bit(MLX5_LAG_MODE_FLAG_HASH_BASED, flags);
-	}
-}
-
 static int mlx5_lag_set_flags(struct mlx5_lag *ldev, enum mlx5_lag_mode mode,
 			      struct lag_tracker *tracker, bool shared_fdb,
 			      unsigned long *flags)
 {
-	bool roce_lag = mode == MLX5_LAG_MODE_ROCE;
-
 	*flags = 0;
 	if (shared_fdb) {
 		set_bit(MLX5_LAG_MODE_FLAG_SHARED_FDB, flags);
@@ -643,11 +627,7 @@ static int mlx5_lag_set_flags(struct mlx5_lag *ldev, enum mlx5_lag_mode mode,
 	if (mode == MLX5_LAG_MODE_MPESW)
 		set_bit(MLX5_LAG_MODE_FLAG_FDB_SEL_MODE_NATIVE, flags);
 
-	if (roce_lag)
-		return mlx5_lag_set_port_sel_mode_roce(ldev, flags);
-
-	mlx5_lag_set_port_sel_mode_offloads(ldev, tracker, mode, flags);
-	return 0;
+	return mlx5_lag_set_port_sel_mode(ldev, mode, flags);
 }
 
 char *mlx5_get_str_port_sel_mode(enum mlx5_lag_mode mode, unsigned long flags)
-- 
2.31.1


