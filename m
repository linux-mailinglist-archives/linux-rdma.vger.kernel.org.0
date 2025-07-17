Return-Path: <linux-rdma+bounces-12277-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF13B09171
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 18:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4D5B3A565B
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 16:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78082FBFE7;
	Thu, 17 Jul 2025 16:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="r/G99WsW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DF0145346;
	Thu, 17 Jul 2025 16:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752768547; cv=fail; b=gN//k0AMC7f9T1znf+2qrE+KnNUMXAHd2WSN/d0eo0cQyBnK1d680chQm8inoGaOZpKrIX6Y1H+FqA+UV5NzKd3t/7/fJcOmoafH3J5Fpb7pyVmOXiXds9/63MHwQ/Wt9qFZjSoTBsQ4IW2pe4COm7eChX/vcR5q/Sgdvz51k5Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752768547; c=relaxed/simple;
	bh=4kuP5ouKzvHGufukgbAIjJOth9Hl5YnEZqZHxVKuizk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UmigqKVDT0Y8NB9ShJk/LHgrsX35gKsEVtyWf6ak6UY+xIpKCnQCBtct3PEaXvbJ3bjv10y19kLylrWUK2Eb2z0V2oarTiW1tn93rSMjAhaXWupm2WJ+f6hfQYjMUjNh7Xhftig0GcSG+YMO6lqcfMftghpadX4gsvx/3YMxsJY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=r/G99WsW; arc=fail smtp.client-ip=40.107.237.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lY7oMpbtLxYSmPIoOLPWskhAS1M0zIYr4GKwOWpao2lZVPwR/E5CnvGiOqGTuv5qgl6dXiAD/QgxlqcgUc9s/BOaaPIcND/Ig+i0Dy6OtMhuNYRq9CZ3haMekkEeV79Ea31HA6N9T7mZNcDYdN4OxHB0bCgUZR5f/gN/jq/aso9F8zmUarxLVnVW1Q4DSIZt1ijMJBdHxZGqKsx4l3/PbbGSDVTDgmV4p1iolbAbLvhOXxeW+xCp4ms+Q7EqS5KJdBr7Dy21w/R92zApMlGK2GCrQmjkIfUqmt061G7h65flTY0LiJ6p1AyqhYqbN/sB1XiPQvDY6qmwDGcDEPkVNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5KUVVw8QFOwW/eO5P2Va5I82DixybRl2nX/TlW+fPNc=;
 b=KpiWBSVuJRYPRNlXAztairu3thvzpoyNOT/3p76J/AiCZxNVGn+sEwdSQ0kM35Yrr4Z98zKo6LMRrudO/BWVqostMa+KNSXJO59lQ9C2cjrPDhIk8DKQNSaADoSnWzXrfiEKqNEvWKqOPT67nSdCy/xpsP034NEy89gyjmMNhvkkEunvm4WUqLXE/mDVRVCuq5BD8d1WA+pMgBB5iRRHJGyftp8S8RRcyvl5+3WVHnBd++htXSeKM00v0/G286B3bgLiCjlYlpG9c68aIo2CcMjjnib28ns8tZVdR/J6sKr4fFr4GTL4BTgeLeb03zVOTgYVTuS8jL8Is9nDRvJZ7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5KUVVw8QFOwW/eO5P2Va5I82DixybRl2nX/TlW+fPNc=;
 b=r/G99WsW1S+nnBbfI/BK1XMTOIKd1Hwsllk+Ctb3kMsyun+qG0G/obh23tWhvD6KlzS+OS7rDD2/ggEZgE7/+ArgbpF6y4R9tzeSrXpmPLxq/+P2mONv51RdZ1D8HJU6Z2vIm0zzUASydt3cpdMKopuRNbKd/1luYfifBJrTe3tN9BFJoKDycGkBNmiP+8QbnCXI6Nm7yr13OVQFJ4vpV/XWDKxr5LyjRyumz+P4/9KozHiPQbBRdhLZReS9tLxryFtK/W6aa6i1uCZ/NgplDZYICJ8J0MeEG5NhXxxpeWRBT2phod/0uFHM8U7z26hx6f/N/Bk/F9mM7Q5kCBWIuA==
Received: from BN9PR03CA0188.namprd03.prod.outlook.com (2603:10b6:408:f9::13)
 by BL1PR12MB5921.namprd12.prod.outlook.com (2603:10b6:208:398::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Thu, 17 Jul
 2025 16:09:02 +0000
Received: from BL6PEPF0001AB58.namprd02.prod.outlook.com
 (2603:10b6:408:f9:cafe::39) by BN9PR03CA0188.outlook.office365.com
 (2603:10b6:408:f9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Thu,
 17 Jul 2025 16:09:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB58.mail.protection.outlook.com (10.167.241.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 16:09:02 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 17 Jul
 2025 09:08:42 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 17 Jul
 2025 09:08:41 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 17
 Jul 2025 09:08:34 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>, Jiri Pirko
	<jiri@nvidia.com>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Shahar Shitrit <shshitrit@nvidia.com>, "Donald
 Hunter" <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>, "Brett
 Creeley" <brett.creeley@amd.com>, Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>, Cai Huoqing
	<cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>, "Przemek
 Kitszel" <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, "Subbaraya Sundeep" <sbhatta@marvell.com>, Saeed
 Mahameed <saeedm@nvidia.com>, "Tariq Toukan" <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Ido Schimmel <idosch@nvidia.com>, Petr Machata
	<petrm@nvidia.com>, Manish Chopra <manishc@marvell.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<linux-rdma@vger.kernel.org>
Subject: [PATCH net-next 5/5] net/mlx5e: Set default grace period delay for TX and RX reporters
Date: Thu, 17 Jul 2025 19:07:22 +0300
Message-ID: <1752768442-264413-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
References: <1752768442-264413-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB58:EE_|BL1PR12MB5921:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ab750ba-6db9-496d-e106-08ddc54c3f5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JrrnWwQWmd5OCYRyi3hELGx3sZUiEh0s5beXo9r+4ktuD74SCdlBs4xw4LAr?=
 =?us-ascii?Q?H0N4pz7bgQsqjcyjnRJlKWaqsOnsIXPm2fD6oy9QF3rKTFpJ5IGxfM6oCzpx?=
 =?us-ascii?Q?sLEbjo6abbGE651VnFld64fQ0r4LKfBqvUSiAVyU3GuH+k9VZbK41nBenChQ?=
 =?us-ascii?Q?NFrQ0Hl/pG9b1F2ia2xjk2k8x8uUSZVeKmOdA9o4bM612f0fdv2VQj6OnM8o?=
 =?us-ascii?Q?i+Lve/AXowzJp0xE1DXh+Sg74gwX30Lwj6+WdhEVGiBcEpaCRgJkNWsDwAdS?=
 =?us-ascii?Q?UHjuvt6+b2EEznaeULIE+rWrOxzehLFb7br3nMJwl1TXBYPHiuXMBLm7t3YT?=
 =?us-ascii?Q?qSPcObhyTyP+5XxhaQ6pH0Gvl13EOcZz7zqCquW/lIqBLOGT5LutQu+IjBRT?=
 =?us-ascii?Q?KC931yM7WHhPxdKZVHyhKTXlCVEwYRHzcv9E7x+OVt4L+z65JaUijk/TEcnN?=
 =?us-ascii?Q?SDYGzjTDzcU2ScWQwOPxjKdSD7kQqMewax9jOsqPeUbjqRuFiuBAg5SqKzhn?=
 =?us-ascii?Q?xL2PJ1meDHooepAj48V/mEKsTFrqxM+6CpVuMUcReEf7Yp5Ppm0chojhAnwn?=
 =?us-ascii?Q?CJ9X6hUFgZ9DooMreF0C1LbOLwJGw+Xki18A8qYMRSQVTeyaxh24Lcpmf7oy?=
 =?us-ascii?Q?jWW52QKtymv+g+OIaPIuBeicw79itZrQfKDJ9o7WI3bXNzXZEy3sU5XtsBio?=
 =?us-ascii?Q?DC9okpcGed0tYPUxwfpi+wjbS8onqua9vC5gwBH2YZTc//g5aQCj58WZwErf?=
 =?us-ascii?Q?rZ/W50BSRks56apYPxdfh+FDcjE7QTnP+AwRp9d+pgdQfbO9G1yj9dck82/Z?=
 =?us-ascii?Q?YuoLdi7YJ5B754TJg9QYFOcYGrQxR6CtqqqColLjlXuE/AFRWrZGSBAlNojP?=
 =?us-ascii?Q?zpZqRh2GwJRSr6PkNJ9o4x3n0l92zAnoJmqaUI2Ob2y2tJv+zoA3UjPOkkLw?=
 =?us-ascii?Q?YFMVvlFMASHSfjp+nqBZEIu51/GRxXEurTU5W7rsnGtShyNt/7sYx+kj88UT?=
 =?us-ascii?Q?cG8TJPyyTjWEsT5KMOjO3dwnJyStRFoFt1fTdYiaz0fqQ7Gq+R2bZxkUnZ4P?=
 =?us-ascii?Q?DsAENCv0WBD4ld4YnjL7axzXKc+8YCfvAN61dVSpxYR1iBUz/f0GfmwZd3uA?=
 =?us-ascii?Q?5q0sUhWcLbAWfiXn2tOK/8AwqLZpIp6QJGJOStL98XIXsgb5zP7CAgmCHFtX?=
 =?us-ascii?Q?3sIHQmZxoHlHvZ0PGW+R3nV9j+c2pyrUVFTd3elpa6rEZcoLVNVSuZ2WiDTz?=
 =?us-ascii?Q?7QD/Ts/5o6TTApYhbSqqRtqznqOCWETUcQw6sY7dJWk/uIyGupdZjiLawtLc?=
 =?us-ascii?Q?tmJoI2ffJFGxGilrcGEEq1KXsZFsIcyeaGTVBEUGj3z323SLh6ro2L43Udi2?=
 =?us-ascii?Q?eBDEIAx830Qdx3zlVo6edyF5Q40F5Cw1tPUgYLqhRWIXcfZuxQD8zo76rRux?=
 =?us-ascii?Q?roYGP1OVhrk8xV7KMwK4kI6G8JMkIeAs3lBhKX0R0XT8koBPFDgUi9ZqIWj7?=
 =?us-ascii?Q?KribJWCeQ56xACYZt7h2Q8qxJWobutbkjxjc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:09:02.5695
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ab750ba-6db9-496d-e106-08ddc54c3f5f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB58.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5921

From: Shahar Shitrit <shshitrit@nvidia.com>

System errors can sometimes cause multiple errors to be reported
to the TX reporter at the same time. For instance, lost interrupts
may cause several SQs to time out simultaneously. When dev_watchdog
notifies the driver for that, it iterates over all SQs to trigger
recovery for the timed-out ones, via TX health reporter.
However, grace period allows only one recovery at a time, so only
the first SQ recovers while others remain blocked. Since no further
recoveries are allowed during the grace period, subsequent errors
cause the reporter to enter an ERROR state, requiring manual
intervention.

To address this, set the TX reporter's default grace period
delay to 0.5 second. This allows the reporter to detect and handle
all timed-out SQs within this delay window before initiating the
grace period.

To account for the possibility of a similar issue in the RX reporter,
its default grace period delay is also configured.

Additionally, while here, align the TX definition prefix with the RX,
as these are used only in EN driver.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 7 +++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index e106f0696486..feb3f2bce830 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -645,6 +645,7 @@ void mlx5e_reporter_icosq_resume_recovery(struct mlx5e_channel *c)
 }
 
 #define MLX5E_REPORTER_RX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_RX_GRACEFUL_PERIOD_DELAY 500
 
 static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.name = "rx",
@@ -652,6 +653,8 @@ static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.diagnose = mlx5e_rx_reporter_diagnose,
 	.dump = mlx5e_rx_reporter_dump,
 	.default_graceful_period = MLX5E_REPORTER_RX_GRACEFUL_PERIOD,
+	.default_graceful_period_delay =
+		MLX5E_REPORTER_RX_GRACEFUL_PERIOD_DELAY,
 };
 
 void mlx5e_reporter_rx_create(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 6fb0d143ad1b..515b77585926 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -514,14 +514,17 @@ void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq)
 	mlx5e_health_report(priv, priv->tx_reporter, err_str, &err_ctx);
 }
 
-#define MLX5_REPORTER_TX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_TX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_TX_GRACEFUL_PERIOD_DELAY 500
 
 static const struct devlink_health_reporter_ops mlx5_tx_reporter_ops = {
 		.name = "tx",
 		.recover = mlx5e_tx_reporter_recover,
 		.diagnose = mlx5e_tx_reporter_diagnose,
 		.dump = mlx5e_tx_reporter_dump,
-		.default_graceful_period = MLX5_REPORTER_TX_GRACEFUL_PERIOD,
+		.default_graceful_period = MLX5E_REPORTER_TX_GRACEFUL_PERIOD,
+		.default_graceful_period_delay =
+			MLX5E_REPORTER_TX_GRACEFUL_PERIOD_DELAY,
 };
 
 void mlx5e_reporter_tx_create(struct mlx5e_priv *priv)
-- 
2.31.1


