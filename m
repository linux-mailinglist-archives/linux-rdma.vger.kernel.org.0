Return-Path: <linux-rdma+bounces-11148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE65AAD3C79
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FBD67A970F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CAA22417C6;
	Tue, 10 Jun 2025 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DW4z9UP2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736C6235064;
	Tue, 10 Jun 2025 15:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568329; cv=fail; b=UagPeOwRfER2NRRBUT/F0J4RFnHnZpLlygO4OXbLJ0T4UyUY/yVw9LY3rqPC5uzCjh0GDMJLer10s1g8bmzRLuIlmY/m5//PoEzYQUmdxIDeTHF2JS5DdZ3oHuyKiz6nFVrTLhGvcRBLkHkMdI5XNLchESqhhcDzBztCGQ5XQs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568329; c=relaxed/simple;
	bh=32u6So0csLjprV4yGjItykkpk/BWB1yCoglHqvNJP+8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ckf1mNSV5ROrG6R12eZpFJccJAQebEFfLC1UmNI2wHB9EfdoA3jLeUjLWvjg0X/b/633C4bUX3RxxvG9ranmyRtWqTSiGYyw0sICVTSTZxnbd0/ovx/0gWfgqMBIrsbWDFTAUyR1Ho+/xK6stQPs5GPHTgAXDXmMqBwxERkUZ3M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DW4z9UP2; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3mXCUjvZoxHuzNPgZ53yvIMEP8RjycQro7Q1utrNR+PvNa9wYqtb1cJvvKWHBvWknqRxc1HXMDud6EsV9Y03MiYEzR3uNs/uofhw6fdXa9dU9AixSkzJgux8OukU3ydswjl+b2I2snT47dlAUR0/NRP2MjPnFZCCiicnMSnlmO5kUvgOE/Umpj9fbx3halX2hWJSHQrXPIggTbBl2u4eCf8iaoxeOmJVhqVX82xhCiRsh1gZX5EKVk/cr8Ayu4jMf0vErDjoi6scJj19d2j6VzCaEev6Yi1RjTENKOZzVR8SenvG+bR+WopKeKOYUlNLKcS+cSNzw/rOsYqy3SCNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8m0iDAZAnWT/O2Uc4lSlxx2SAMTAYdoTiMMvLgY4Md8=;
 b=rhK4+6aISYkYajC4/89lXdbno2fKYTwPTJM8l5kI9cftNdoqlaAiXzR0JkycCWfoIrrLUd40rnjC5m2UPTodzqwaavCEZoqL4ppmRDgd4nCKtrmSd31QvIuEV6zauCIOnqLaKS0tAf7RYI3rNmy5Fz+KPUko+8K7lOmS2G1e5P7V5Y+6PX2ivLNa4UJ/IMzOUsbEIv/JKIU06gPyNqDMX+Zs0eWnT/lCHI4x65fjxqsAOvN/ulXAp/58/DYWjSOB0eXfg4pGYV7uxFMAFmcNS5G0+JPey63fmkB6uI9T7hYY0RK3YHTXBRLV8j+Uxxvb1RwDEAT+YHehtA3kRTPelQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8m0iDAZAnWT/O2Uc4lSlxx2SAMTAYdoTiMMvLgY4Md8=;
 b=DW4z9UP24AJnRm6bz/mTauHm4LgGJHmiZjdriFcmu/TsWE/CCMpfLYlrEKzO8FvrS7wMn+uQem49pgh2T10R6TGb40qcSDFDrvlwpnAe9HY3k6ADeE6oG9+K3qlOACYPs6N7GxlnF1QyGwwCfaPX6jdylHANP/747uNyOv34P4eomzY4H/OaXNlCGFKB7Ov7Mv7MatCN5yl9YBeXrxjizZO6oWj0pZjaf/rQTAXLr2klFKwk+bTbpcjhEm7ejo1JHME2QsmCVxjBOqHQE9hcG08GGLl5Xu1cYDulDDb2ntMfNpoUYwBqnRJnBrU6nzeht+G9db1iezrwG7ETq6yaNQ==
Received: from BL1PR13CA0382.namprd13.prod.outlook.com (2603:10b6:208:2c0::27)
 by BY5PR12MB4148.namprd12.prod.outlook.com (2603:10b6:a03:208::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.18; Tue, 10 Jun
 2025 15:12:04 +0000
Received: from BN2PEPF00004FBD.namprd04.prod.outlook.com
 (2603:10b6:208:2c0:cafe::6e) by BL1PR13CA0382.outlook.office365.com
 (2603:10b6:208:2c0::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.9 via Frontend Transport; Tue,
 10 Jun 2025 15:12:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF00004FBD.mail.protection.outlook.com (10.167.243.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:12:03 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:11:38 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:11:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:11:33 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 10/11] net/mlx5e: Support ethtool tcp-data-split settings
Date: Tue, 10 Jun 2025 18:09:49 +0300
Message-ID: <20250610150950.1094376-11-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610150950.1094376-1-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBD:EE_|BY5PR12MB4148:EE_
X-MS-Office365-Filtering-Correlation-Id: a949cf75-b08b-47c1-4e4c-08dda8312806
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ci5mPBvsezOCwlf8DKIJEZR43eTGq6yBGWWQOoojybg51osPXEmALW4cVmqB?=
 =?us-ascii?Q?S7za1y882hyFBjQVTCLiLj1u+xjkc2eomenmQQ1Dyz7X5pTStS12QSGIAQCV?=
 =?us-ascii?Q?rJa/64s3mCtrxdVRafqJKCPb/PPxRubbGLYVHH1vLV66G7R8huWumm2k8z9m?=
 =?us-ascii?Q?2pKG006mMLa04npTp18PqnwJl1427FTeqrXtPzD7nrVNQEgL5L7CC04+g7dz?=
 =?us-ascii?Q?FWspfCDiYvH81XOSrI59dVzyjnjt3J/SoBCMmZCBGc0/R2UDEFUqWnnvhnnT?=
 =?us-ascii?Q?/8kAlEBF4thjwpNL13NpzwTzlXahzmtPXcZibWLQgFJolh26Y8GBWTFCwaUp?=
 =?us-ascii?Q?EQ5wMvyLxyXYtiLGXsAxkpyXlKLaY4dFsKXjfLcva9DecpfbIOoXZARYN/b6?=
 =?us-ascii?Q?xSIOk0TMAE+lB2Er3NpoZPbs/dydMo/h6yLxDNuxBIRtPu9sJujvMb4GTO2i?=
 =?us-ascii?Q?CbqQESpeEo9bYYFP7qNrKD7hP8o0/XWyPB1RwcCJGl5jrRvHe8c86Ny70ehA?=
 =?us-ascii?Q?v7SVTia7BxUgB4I/j7JfhXof/hiROtRVScIz/tJ32s4OPvIAdeqwCWOLZ2VV?=
 =?us-ascii?Q?oHEN+A2HKjZC5BLH/05Czif2v/amhI8GQ+X9+e1BHRmjRTmNq/HtxyhYwMAT?=
 =?us-ascii?Q?W0ld+V8OQyacm0Z0Tf+clDQ+MDtZh3/5ONywDitHMINNe86nujCaY/iaEn0d?=
 =?us-ascii?Q?nbidHiT6Gj8VO57NCSGl5ZVyzB3kEyKUul5y27M9g1BR6B7Y6FhyHEHGzdCY?=
 =?us-ascii?Q?8jia7N4c2RVFIN0CL2bM5E+Q0RD9iNmR8mZ3NESIp73y4FYslYIc+2o/yb08?=
 =?us-ascii?Q?3PVE4eiGSam0Ii7wDnFlQtKr4zkVkSR+0WfjW9/jtWeKXWnzUR4kB6IxfzSh?=
 =?us-ascii?Q?dEVRtJQrIYmvrq6YOu7IJVvW2a6t6aB4nNnFmVSO/8dJg0kakyyAwPt8laam?=
 =?us-ascii?Q?RXD9f+NE6YwXJAmiDKvL8faHLIghnJYKzn39aTgvVww40oyCHo4EUPeA4hbq?=
 =?us-ascii?Q?3iCavlGbKL+akh9tnNk0dHcCQwu9Kg/lnfjrmnx7A8YO2yFka/EWCwi2Sdbt?=
 =?us-ascii?Q?2EVJKUqbtEQ8lTNSxPpBtxjdkNLcWJU/Gi9AzfebFCydYpnom+Uk/8kSIC4E?=
 =?us-ascii?Q?LyQm+Ldr/uxTzDpu4w4MBSAeu4d4LAkg2sP7T4449O81l4Hkfr9VRVVcsbj5?=
 =?us-ascii?Q?AbbEsyzF6DOSo73nShK+olubgbhB+8UKckwy6o5kAy2ZNNYBgZK/AERqsjRk?=
 =?us-ascii?Q?nql/bYyzJgWY0oUNwQSuJFNdIOr989gf5nJcpQnV+BzaPAf3t9a7BhRWKHIS?=
 =?us-ascii?Q?89304+VZPgNUIFdRMXo34goHmNAAXTnMQGPRhzjbZPygMALxPZygOWVmQ/Gs?=
 =?us-ascii?Q?sERC8FZlUFiHms3v8tV3mNy4qx5Pnj/g61xMWPWD2iwiaZpDmq3F5i9Mtnf6?=
 =?us-ascii?Q?9nCvXPPbBNojZR1CqIm70tHDIt17NCAVmUXWhDq0zyDPe7lqnmQphAbL6WuA?=
 =?us-ascii?Q?Kq+0qBgcE7Uq48hBjDzOxTihaS04R/Zbjk48?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:12:03.2682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a949cf75-b08b-47c1-4e4c-08dda8312806
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBD.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4148

From: Saeed Mahameed <saeedm@nvidia.com>

In mlx5, tcp header-data split requires HW GRO to be on.

Enabling it fails when HW GRO is off.
mlx5e_fix_features now keeps HW GRO on when tcp data split is enabled.
Finally, when tcp data split is disabled, features are updated to maybe
remove the forced HW GRO.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 33 ++++++++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  8 +++++
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index ea078c9f5d15..21005cc4eb06 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -32,6 +32,7 @@
 
 #include <linux/dim.h>
 #include <linux/ethtool_netlink.h>
+#include <net/netdev_queues.h>
 
 #include "en.h"
 #include "en/channels.h"
@@ -366,11 +367,6 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
 	param->tx_max_pending = 1 << MLX5E_PARAMS_MAXIMUM_LOG_SQ_SIZE;
 	param->rx_pending     = 1 << priv->channels.params.log_rq_mtu_frames;
 	param->tx_pending     = 1 << priv->channels.params.log_sq_size;
-
-	kernel_param->tcp_data_split =
-		(priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) ?
-		ETHTOOL_TCP_DATA_SPLIT_ENABLED :
-		ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 }
 
 static void mlx5e_get_ringparam(struct net_device *dev,
@@ -383,6 +379,27 @@ static void mlx5e_get_ringparam(struct net_device *dev,
 	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
 }
 
+static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
+					     u8 tcp_data_split,
+					     struct netlink_ext_ack *extack)
+{
+	struct net_device *dev = priv->netdev;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    !(dev->features & NETIF_F_GRO_HW)) {
+		NL_SET_ERR_MSG(extack,
+			       "TCP-data-split is not supported when GRO HW is disabled\n");
+		return false; /* GRO HW is not enabled */
+	}
+
+	/* Might need to disable HW-GRO if it was kept on due to hds. */
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+		netdev_update_features(priv->netdev);
+
+	return true;
+}
+
 int mlx5e_ethtool_set_ringparam(struct mlx5e_priv *priv,
 				struct ethtool_ringparam *param,
 				struct netlink_ext_ack *extack)
@@ -441,6 +458,11 @@ static int mlx5e_set_ringparam(struct net_device *dev,
 {
 	struct mlx5e_priv *priv = netdev_priv(dev);
 
+	if (!mlx5e_ethtool_set_tcp_data_split(priv,
+					      kernel_param->tcp_data_split,
+					      extack))
+		return -EINVAL;
+
 	return mlx5e_ethtool_set_ringparam(priv, param, extack);
 }
 
@@ -2625,6 +2647,7 @@ const struct ethtool_ops mlx5e_ethtool_ops = {
 				     ETHTOOL_COALESCE_USE_ADAPTIVE |
 				     ETHTOOL_COALESCE_USE_CQE,
 	.supported_input_xfrm = RXH_XFRM_SYM_OR_XOR,
+	.supported_ring_params = ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_drvinfo       = mlx5e_get_drvinfo,
 	.get_link          = ethtool_op_get_link,
 	.get_link_ext_state  = mlx5e_get_link_ext_state,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 90687392545c..026bd479c6dd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4413,6 +4413,7 @@ static netdev_features_t mlx5e_fix_uplink_rep_features(struct net_device *netdev
 static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 					    netdev_features_t features)
 {
+	struct netdev_config *cfg = netdev->cfg_pending;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	struct mlx5e_vlan_table *vlan;
 	struct mlx5e_params *params;
@@ -4479,6 +4480,13 @@ static netdev_features_t mlx5e_fix_features(struct net_device *netdev,
 		}
 	}
 
+	/* The header-data split ring param requires HW GRO to stay enabled. */
+	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    !(features & NETIF_F_GRO_HW)) {
+		netdev_warn(netdev, "Keeping HW-GRO enabled, TCP header-data split depends on it\n");
+		features |= NETIF_F_GRO_HW;
+	}
+
 	if (mlx5e_is_uplink_rep(priv)) {
 		features = mlx5e_fix_uplink_rep_features(netdev, features);
 		netdev->netns_immutable = true;
-- 
2.34.1


