Return-Path: <linux-rdma+bounces-14147-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD3C2042D
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 14:36:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A5793BC067
	for <lists+linux-rdma@lfdr.de>; Thu, 30 Oct 2025 13:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777FB258EC1;
	Thu, 30 Oct 2025 13:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ul5QtI7/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011033.outbound.protection.outlook.com [52.101.62.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3005258EDF;
	Thu, 30 Oct 2025 13:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761831237; cv=fail; b=Rj3PTXhoxwbGm6GwvUM89VHfdJroqGMQT48QYRrrjf7o1MJs6Rc6HFio2gj37YYUOisNeMABOim3wkPL3rI7LRuGiK0XoFfsJ6qvwsqm8w7F+YsBgdrXXhAFnyBeyGEmhhtXRDSdzVdYsNyrdZgNph3OxBHthwKKg4ijeLtBPcw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761831237; c=relaxed/simple;
	bh=2rv1HKehKeyN19QMHDlcu1QtHBsysRYfvijZR5j48qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pb33Ak+TuWMVjAdqTzb3wjEIDAoq/dfxPW5vgziCN9zz/qtNhtEsLhVdXp+L2VmXQB/2ML1DXXtxnH1YfgTwUh8AXHvTMgjnSqzA4TfVWrCV2fgapYOwCrByPj2QuEwXoGOZgomx4F4xOF5axc9QsKeJhdPQgzIZnFYzT6AEFP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ul5QtI7/; arc=fail smtp.client-ip=52.101.62.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nxx6ALqtTNWNu1Oy8JMIXHAC2xAxN62p+BGRW0ai5O4Z82JrAR50hsiwFwkWhb7TaRVSyXlAITyvXk7yz6Tzdwr2xrT2t4NLMavmpGbPIvB3RtALxIYFKrEubGU0xx8HtTafbtAFrrXXXYRYQEGJIv5pD1dflEUk5gQI1OJYrAKQcbX/zLhgVcChYVOuuc+A866suBqFZwR4Yr1dyIb6Cgg8DAqMX0G8g+JoqL6R6VJw5b8bfjI/v3F9KxGCiCdqWvOrJe1LFVDIuJaGBLI83KmBod7Ir5IU/jdkNj/h70FT6Dq2M95cqBFQVO6WkjBnf9a9a5QR6LBPR1E+x/Fqhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZnaJIdEJnIT2/maj9T624DEDnB3bWGd4bLy/SkrOZk=;
 b=oC6OWILtXVUf3/inkb8eEmuA+X8YLuze7G6pTgCVDgbp++TbimuBSPPr6KHXajor5yTLKOAk4G7wjTkxvIu6wA8RHLp6v+ZIVF+CCw6seQDsWApYGUkCkWgOpy3Sb1QKVF0KSbhtdCK/1oL7ACN97LafCEelmQPOh1UqQkIFCXA7G8WsvowKLFBvhKvftpjxYHn78hQjNXD9W9NPMFAgFxA0ZwxWMlxUT2OdJ66mOUxSzG3qfJnS4BY7GWDDBwa665YYb2MNV2a0QV165Qeh2H4jOm4ZgaD+Kq6OEGTukGF51GjPzqJxeGMM9lToO7CqQYIHOSh4sZ4mDvDMtLSGsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZnaJIdEJnIT2/maj9T624DEDnB3bWGd4bLy/SkrOZk=;
 b=ul5QtI7/a+bjWo/sSJi5oMZN4w02zc2/qwFiR7nFL1eK2a8bZ2aJ/ZapcBwisOdnVqkKEIh/jFwBsXHukl9MjbCtcFp7tC9Kq+oh+BB+TYyyNy1IYpRajRSc+tnVO0bI8v704LZNS13HVJUu8v9sK/50E/Oo+0lACYnFoVe30DcKFe27oqrnv4BPFdw+9ou9GpJlt2n9MltamnkXDaEdABIaStIzj5fqLNtFQpOix6BwZLCAtF+lceA8f8KNC8oOxuUcW8gq9rYSeGw/CuSGSEzRLmCTc4NNHOwrZRpMitsN8hMvTudyQ+CA9jmdapZYEtvZEyVyRDPX8dpftHzvTA==
Received: from CH2PR18CA0035.namprd18.prod.outlook.com (2603:10b6:610:55::15)
 by SN7PR12MB8169.namprd12.prod.outlook.com (2603:10b6:806:32f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Thu, 30 Oct
 2025 13:33:49 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:610:55:cafe::f2) by CH2PR18CA0035.outlook.office365.com
 (2603:10b6:610:55::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Thu,
 30 Oct 2025 13:33:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Thu, 30 Oct 2025 13:33:49 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 06:33:30 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 06:33:29 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 30
 Oct 2025 06:33:25 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net-next V2 4/7] net/mlx5: IPoIB, set self loopback prevention in TIR init
Date: Thu, 30 Oct 2025 15:32:36 +0200
Message-ID: <1761831159-1013140-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
References: <1761831159-1013140-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SN7PR12MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d64bd89-8ac7-405b-8e79-08de17b8f574
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?o63GLylt5wotoKnrv8Z9BAuFxG6UjrQOEhZzeaaC1hC7MlnkpT64FFFj+3oR?=
 =?us-ascii?Q?JeQlh9yJNeZAhJ7tvEZlu6SRaLqVAIUV7FWtff2ruPLKRVru1V/tJVxggf5c?=
 =?us-ascii?Q?o+HjjzYpZ0t14zZDKF+qE5UGML/fMPsiBEEQHuX5cjiz3TShfsTpa7QWxjVE?=
 =?us-ascii?Q?wn7c7OMsjXW82IpAE4OzdTDztI7LfuovPEdMGBrlaswUNqIAkmepdHyZXY9w?=
 =?us-ascii?Q?+GFIqSDB5qiiIFABcJ+QTuj5X8lhHnNbpU5h9jLOkjeviz9wqqzA2Ya6Ok2D?=
 =?us-ascii?Q?2OVB3u14BbkrX1EIlWKm5bHp+O9QQ6WHvGIgS5xooq1NSCwxAC5vjvwEJMAJ?=
 =?us-ascii?Q?I2qbL0AedVuJla9D0laqX57Ekxki0vhkdGDlz82a64OyzB4ubWZ6mY1OhrOh?=
 =?us-ascii?Q?F7X0+Sskqz+H8knHU7hHqKePfUElA/AHB6KdObzmXlWg9qysxIYoJhfV1HP4?=
 =?us-ascii?Q?+mm7wB98qMgB0dMaCPZAOJeLOfWScHYzRV4UgpFykUNLbDZzBtRxrw9OWg36?=
 =?us-ascii?Q?DuDuURkiLXsHc+gdnq0mJ5+hCqgANqukZ5fR9ytQ+uYozpcK+84pes5qbB1K?=
 =?us-ascii?Q?JyOHfsKU0K69Rjs37IhZ5DKtyaBjNaYPDVnIiz2xUx1JlYG+4EOcb9YU89rz?=
 =?us-ascii?Q?4NlJf1JTl7TAGmVdVlzl0DaHdPGX2XW4MaHK+LbA9+PU3M9kcVjCHdwEcPHj?=
 =?us-ascii?Q?CU+pnZkw3w2cPb/L1rNFyf6M4t7OqFp8GPmkhFxT7ab9y/T9eOZZUGWmNUpc?=
 =?us-ascii?Q?Od9kcATG1BVoPnsUnXEMLtHMAl9kK6cHocLscL2gE7ijM6Bu35Ch8HeuQJpF?=
 =?us-ascii?Q?CgDUqU7CH9+8ntBVBC+bUJutFnQuFYbXnR6BFIp4dVHz7Lm52XtT4u73e0ws?=
 =?us-ascii?Q?BQB3MCKjjbzm/POO5Kmylek1Gj8Ue+qIbNosH0zsLLH5m1UKSJJ2Mt8GhviG?=
 =?us-ascii?Q?9PL2lgw6CbFdDMsv73q5gposn+U/4syisGzsdFnIIpajHY/CVOFpITHGI9e0?=
 =?us-ascii?Q?itwpBhuXS3g7/qfpktB8LNzPJP9v4thWF9uuKdttAg0jtBcsctDBxpg+X/jO?=
 =?us-ascii?Q?QQ9ELQgR8VHs8JAIApQlpx6BBkCvoQQaQ3cfQgJD45LuSAXVlu5NqgqSqGg+?=
 =?us-ascii?Q?aV0sCjfKImOb5eArTzfXF3OvYcjMizsNVQRCNJIvp0qwlTLj2HoxZW6qHn+a?=
 =?us-ascii?Q?ofeI8rUGMsbiZzd3jTaGHu2kL5yA9jHe22R/24Yydj67Qlv2BhYFIUE0s6LL?=
 =?us-ascii?Q?xQpEIb9No5a3psdV52SwjhRzMXXfjqmkTtZN6f0w2C5Rpk5N3xNGV1JLzyv1?=
 =?us-ascii?Q?ym2tqtc83yL3RAcr5P9w0sNeaPikxgHKg7vcjEY9k4Lx7ad03aau+OIQY4c/?=
 =?us-ascii?Q?fXBpg0HXx+4QzNLt0JLWnsLROxBX1WGuTKUmJO4XlpDB21yE0NyRCcw8HLL5?=
 =?us-ascii?Q?D2/f5EUWPl6ZbOITmX+B4sUkPbFie/t/v/jiXRsWdR3zS+aPtRHgOAX6xjev?=
 =?us-ascii?Q?ALj8VEyeectqDNcPN/dr5iS4SlRjM8Y5112USEWYwUsx2RA2WToT53kbX+KP?=
 =?us-ascii?Q?TmdxVqYuu68kiQ7Jabc=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 13:33:49.1161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d64bd89-8ac7-405b-8e79-08de17b8f574
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8169

In IPoIB, the self loopback prevention configuration apply in activation
stage has two roles: fulfill a firmware requirement for old firmware
(tis_tir_td_order=0), and update the proper configuration as it was not
set in init.

Here we set the proper configuration in init, to allow skipping the
modify_tirs commands on new firmware in a downstream patch.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 49ab0de762c9..7f3f6d7edb38 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -409,6 +409,7 @@ static void mlx5i_destroy_flow_steering(struct mlx5e_priv *priv)
 static int mlx5i_init_rx(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	enum mlx5e_rx_res_features features;
 	int err;
 
 	priv->fs = mlx5e_fs_init(priv->profile, mdev,
@@ -427,7 +428,9 @@ static int mlx5i_init_rx(struct mlx5e_priv *priv)
 		goto err_destroy_q_counters;
 	}
 
-	priv->rx_res = mlx5e_rx_res_create(priv->mdev, 0, priv->max_nch, priv->drop_rq.rqn,
+	features = MLX5E_RX_RES_FEATURE_SELF_LB_BLOCK;
+	priv->rx_res = mlx5e_rx_res_create(priv->mdev, features, priv->max_nch,
+					   priv->drop_rq.rqn,
 					   &priv->channels.params.packet_merge,
 					   priv->channels.params.num_channels);
 	if (IS_ERR(priv->rx_res)) {
-- 
2.31.1


