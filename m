Return-Path: <linux-rdma+bounces-12724-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B121B2538E
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 21:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0043B5C0465
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899F5305E36;
	Wed, 13 Aug 2025 18:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jI3q1XYm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A952C305E21;
	Wed, 13 Aug 2025 18:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755111462; cv=fail; b=fGCB78BLH4l/DFavSZEZBYSp6hTLhnKXbZMd/ClVw1NczBwbbqnZXE8SNRM+olKGy2wpt6C6p1of/TMk7JR/AxmSQKqFI7iodzyScKNCQ+sWSnD0Me9ev8woTBdG76GR4yOIEeWqmIhmqH1FdNy24cbKNqhgfATSDifI7ZfHzNE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755111462; c=relaxed/simple;
	bh=nNclsje+EAqLbsYW3SihoM8DEEoQ1pE/MsVjmYP3Jlk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2Kl0rFuwNtXoRGkHnSMwzvs9xWXXoWaAm/6CXcqRiirFX1c0uOlcF7zLLmfClTFfnX272sD7cUYObFmI9wq6eVwjVgPB+pGnz9jxJ7w73hzMFo3NrYCyNYI5WDys/v7WdJSV0FqvdWYtSWYVY5KukuXhQnGSr/4jTuQ6jXUah0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jI3q1XYm; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GviUxmdISR5kUgVxLrR6XYp1PBt6MQ423AnBncg5QHu/RKCNz52SgkCeyOJD4vo3iXhV7NxsxQI+j51ZZ0qfbXh9WZmqFKpTtW4PFihKnCMV+9AHhfRpn6WWVd9kUzXx6D2VBSWi1mGV/dVMWkNEv7KNTmESPQQrdJpvMdr41ODIQJbvcm2zomDObOOCYG2ovt8EKWqh/uOI57wcjAWP3rutE6rl/hUcJ7SyqiVi7XEcX3sxQJ5ba+5NuvvQCRfmi2me1/9anrv+84JaaU/ZMSSulBqxUS/iJ51uyREMuQ7sz7MSTROi5Sp/8nSi3DrasMh2gVyNTh0AbisbjF3kXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fz5e5AjMB1U0jGd82Z0MTseLOWsgSQPAfq4rg9nEafw=;
 b=jv251CkVRK9s71dx2TmFM9t+eI/Ckkyzh2KlcZVWZq2Ur28noAGBilGrka0ds20mLGsOjrbP6efuOEB4feoAIvH3Qo4XsY3y5m7AryG+o0Xcmo3+JnzaHHtizUa5Nz3re/c+wCu4sytX4LextaotZa/e2nf4vCg5UAGGQsw9eOvgj0tu1tB5gtirIW+b9Hs/quoWiwhLvnQefuqEm4OmQS5NotRbWMtijlyVhXtWBj/VyEcKfu6FBObeS4kX0QHOwej0nnzCkYZL2oTVtKDMxVsQN+qUfOrI8CfyBZLESWZLhZoPOfcfO369s0pmUCkC/V5votdS6MI/WbOxZn30lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=marvell.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fz5e5AjMB1U0jGd82Z0MTseLOWsgSQPAfq4rg9nEafw=;
 b=jI3q1XYmP+G2DuvJxL4Q9hy9ccqauCuw6fav5L7Amf/ugALJXFJs9V7u1oEY5mOAv9N87asb6awphhyNzIjshpmpo0VNk5hMQlhuMnege1e8UEDCIIUXts9Aimyej15U9Q2KfkwK/TWPOhe3z2ogw5bLYAIjseXL9OpSfJH9q8PzdtUZUbB9Mzn9rWkyYpY+sTsDg2Uzn/gsuVa8cQMByy0SnOfeIbbJRUg49JWFyYLxRlf+ivHlVkikfApKqe4A5bZbQJNolYMOTst/QyMR92CBJ8L97g5T0cvdz8iVvxR3yP6KsPpwPvr5bHIi+krrT+rz7kEk9BeuWxl/4dkRLg==
Received: from SJ0PR03CA0172.namprd03.prod.outlook.com (2603:10b6:a03:338::27)
 by IA0PR12MB8424.namprd12.prod.outlook.com (2603:10b6:208:40c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Wed, 13 Aug
 2025 18:57:35 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::7d) by SJ0PR03CA0172.outlook.office365.com
 (2603:10b6:a03:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.22 via Frontend Transport; Wed,
 13 Aug 2025 18:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 18:57:34 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:57:15 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 11:57:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 11:57:06 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Jiri Pirko <jiri@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
	Brett Creeley <brett.creeley@amd.com>, Michael Chan
	<michael.chan@broadcom.com>, Pavan Chebbi <pavan.chebbi@broadcom.com>, "Cai
 Huoqing" <cai.huoqing@linux.dev>, Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Sunil Goutham
	<sgoutham@marvell.com>, Linu Cherian <lcherian@marvell.com>, Geetha sowjanya
	<gakula@marvell.com>, Jerin Jacob <jerinj@marvell.com>, hariprasad
	<hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, Saeed Mahameed
	<saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Ido Schimmel
	<idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, Manish Chopra
	<manishc@marvell.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <linux-rdma@vger.kernel.org>, "Gal
 Pressman" <gal@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>, "Shahar
 Shitrit" <shshitrit@nvidia.com>
Subject: [PATCH net-next V3 5/5] net/mlx5e: Set default error burst period for TX and RX reporters
Date: Wed, 13 Aug 2025 21:55:49 +0300
Message-ID: <1755111349-416632-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
References: <1755111349-416632-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|IA0PR12MB8424:EE_
X-MS-Office365-Filtering-Correlation-Id: 8791c638-c752-41fa-4f55-08ddda9b4398
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Gi0CVJYp+2uR/fVtGKnkuXf3m2BMn4eCamG3HJN0iwiaGWQ8/HUZQpeC4fRY?=
 =?us-ascii?Q?8cTlwVh9okhtxfWtNJScmEbtBFPhgL54WrZlMTJ8a3Aqg0vLln1hCToh789L?=
 =?us-ascii?Q?i340f1HNgYiilxaYm7Y4bqH9GQgx3HDKL/3tFGPj9Du4D8R9LolfzLC2d5Vm?=
 =?us-ascii?Q?sb9bOVCcLZC+WxEbsug6y7/lzYfJJTcA8v1H5apaacWygf+poqBE95yrMqUA?=
 =?us-ascii?Q?oZkyEzeqTnqvadzL8Gxq5MaQo1cOu50HDTOFIz20uECCU+339ta9z5TtPIW4?=
 =?us-ascii?Q?0DgRXGh76F4WHa1FCTEH99BpCgFhL/jg9AVcuNLw5EO+YZRQI/SbpWjys0qs?=
 =?us-ascii?Q?hqQ4FR7Y3FHogdtMt6dES1YnV19oeFzbA2UtDxuWdwzBgMr4QqBdP6Gk7Z8D?=
 =?us-ascii?Q?Jj6OPX/P8NUzzyxFp1oXjMYRMTpGLrYJloO31he8kn5fW/uq+a726/JmSPdg?=
 =?us-ascii?Q?aGZduToMPuuVfIXiiz58BX/GJ8wXE3pNg3Wlc7VOyLdXZtuWNXfDFJfAi2jh?=
 =?us-ascii?Q?lvgNZBQFf8tey+EFrc536NiRPepB41U6qAgNTC1CmWX1sLmyv1LkHfHzzCfS?=
 =?us-ascii?Q?6JdMnRNnO8Q21OWiQ6N6nFnrAZp1bXr2AEuFIVy5s6aep2MPnP+3ofggcHQl?=
 =?us-ascii?Q?SpE92BZ4BQtn6sCxTVUdAAsarjYgJ7Rde+ycvrEfHiNX4kQjR+JqT5YcdodV?=
 =?us-ascii?Q?PPfzVJrHq+yvRcBHqibpFoOtJJs6Oi2JwVUW2BK7zQHLJL/ZbSz2Ke5Qb7hP?=
 =?us-ascii?Q?o0YxKEJzv+tD1V5YHNkMLMSvTYsKB09+D+6YrbVxIVDt6fe2EoQ0pTlw9Isf?=
 =?us-ascii?Q?ZNlu2muwakA4z8Aqgt69kbWofnb5il+vYjJIZ8bv5E2SHZ2zIZNQJkq/Xv88?=
 =?us-ascii?Q?FLB4V/AYRHxsR+y/L2JKPcicO4dM8WcNdJr78ROS94XdG9MO5wwcFSRW70DW?=
 =?us-ascii?Q?fVk0bgVhYGRJ5Hry+sP1dYNXg5508566s1SODFxrNWRJNcdOsAM8lDI2dX2f?=
 =?us-ascii?Q?jJpWOqYA36+eYPQB23fe9UUfe1WzkPzDAKf+YKitioqmFFLQX0o6WLrYVm6b?=
 =?us-ascii?Q?kpJJA9I7AwTOBLXv5uk5rgbf7yk7cmF+AAcI/oxvcQRHgUec0iRgD1Zi/JWS?=
 =?us-ascii?Q?GlaY5orOG/b3Hj2YoCU5guHiQxjGYWic6ZhaObC4O/0gW010VhLvSmlqblHC?=
 =?us-ascii?Q?tSZyCFiRXLi+/w1Lt+wV0g+e0UTCM7ounpRj8Cal9S6jC2AEHOPr9/3DuAV6?=
 =?us-ascii?Q?QhkrCVcQBEy8HUQQf4caHSt86U1seTh9czQ0ZRf637q2MhzvpDheCW/qxLA3?=
 =?us-ascii?Q?2rNdWXSysfDDdwNXVbSNPCAMkx5EtBapoUnxO430VtFp27Wvj4zs/YuzpFrU?=
 =?us-ascii?Q?F4MMZXoYAeJrMHOaCn17K8AuPwe2Qdr7AlmRvO533CdcicgwVm8DiSgjv48L?=
 =?us-ascii?Q?jKxzL3GwoEy8tTCx06yldO+LN3Al7lVhowxvgvThl/guAj1mpqrv2uXyDJUv?=
 =?us-ascii?Q?GTPW8WG4CYb9AWaTSdKIVPe02k3nfmpRA3xs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 18:57:34.4962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8791c638-c752-41fa-4f55-08ddda9b4398
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8424

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

To address this, set the TX reporter's default error burst period
to 0.5 second. This allows the reporter to detect and handle all
timed-out SQs within this window before initiating the grace period.

To account for the possibility of a similar issue in the RX reporter,
its default error burst period is also configured.

Additionally, while here, align the TX definition prefix with the RX,
as these are used only in EN driver.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 2 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c | 7 +++++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 1b9ea72abc5a..0e861ae362bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -652,6 +652,7 @@ void mlx5e_reporter_icosq_resume_recovery(struct mlx5e_channel *c)
 }
 
 #define MLX5E_REPORTER_RX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_RX_ERROR_BURST_PERIOD 500
 
 static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.name = "rx",
@@ -659,6 +660,7 @@ static const struct devlink_health_reporter_ops mlx5_rx_reporter_ops = {
 	.diagnose = mlx5e_rx_reporter_diagnose,
 	.dump = mlx5e_rx_reporter_dump,
 	.default_graceful_period = MLX5E_REPORTER_RX_GRACEFUL_PERIOD,
+	.default_error_burst_period = MLX5E_REPORTER_RX_ERROR_BURST_PERIOD,
 };
 
 void mlx5e_reporter_rx_create(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
index 7a4a77f6fe6a..7813f18e7dfe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_tx.c
@@ -539,14 +539,17 @@ void mlx5e_reporter_tx_ptpsq_unhealthy(struct mlx5e_ptpsq *ptpsq)
 	mlx5e_health_report(priv, priv->tx_reporter, err_str, &err_ctx);
 }
 
-#define MLX5_REPORTER_TX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_TX_GRACEFUL_PERIOD 500
+#define MLX5E_REPORTER_TX_ERROR_BURST_PERIOD 500
 
 static const struct devlink_health_reporter_ops mlx5_tx_reporter_ops = {
 		.name = "tx",
 		.recover = mlx5e_tx_reporter_recover,
 		.diagnose = mlx5e_tx_reporter_diagnose,
 		.dump = mlx5e_tx_reporter_dump,
-		.default_graceful_period = MLX5_REPORTER_TX_GRACEFUL_PERIOD,
+		.default_graceful_period = MLX5E_REPORTER_TX_GRACEFUL_PERIOD,
+		.default_error_burst_period =
+			MLX5E_REPORTER_TX_ERROR_BURST_PERIOD,
 };
 
 void mlx5e_reporter_tx_create(struct mlx5e_priv *priv)
-- 
2.31.1


