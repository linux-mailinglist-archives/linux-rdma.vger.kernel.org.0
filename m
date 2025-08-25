Return-Path: <linux-rdma+bounces-12901-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3804B3446F
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 16:46:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9408207032
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Aug 2025 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E739303CA0;
	Mon, 25 Aug 2025 14:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="IIBTborC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB28302CC4;
	Mon, 25 Aug 2025 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756132559; cv=fail; b=e5KMEbpFK5ELqM/WEQMbkjG2On4fyzXGvgG7bAniipoGKU5S2fnCmQxiFdhRHxjPEoaZc4DJLbR0sq6Ht3QgWylOIwvJgXHAURg+BtzZ7GT6sM63oYSGiL5OoN3b0BidANihdt4GflQP5cL1+8UL/kBMnrbUDWChvRD2DrYasVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756132559; c=relaxed/simple;
	bh=ClhUyjvjEEKD06NFYcxXlKPD8vuVCdFU9Q/H0Bb4cGU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TayP+l43BPsMkO6zK9td5yb5uvP+8vgoUCsurZVU74/+KIZz4ONA4qGi3NTz1Os2TzgmELx7lZHdFhbJm86hybtxl43lFCg74dWFleI16aGcUqKs8ldGFoHb8DPSD62Hi//zD7EkuE2/VEkvyHmLG6BCPoYyBxqbqI20u3t95fU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=IIBTborC; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XZju7x/33ivl96Khj9poa2m2LXacgyqcyIySCihHBgfx442m0w6E9aMgEr5I6Eqb/sA8DMfj/djEfcfuXIxf6lhDPlVmwX8KB8cozoSThdZjEeLLE1H+rkwmzBDeVncaSR4UAlSrIK2zuoVdjoXKy5IjH3DX4gy+bxYzXNZUAJXwaYe59mKDLqRFSSaUxUAr2Ys9w3n4scHnAUWwvjOdhHtCYUq/EZG32BtRBwlV3JWdSdY/nNX+PQYX2kKRO35svXyRkBneW7oH+VGelIVoOnJ2SxgXmzTNKMQOlMeHvQZIIW3gx9RR5qrDYRrx2tNdn8K5f2c+QqypkbH4sJrIoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XZSeYjjkUcxj8LEv+LRhzMUIpz5SuulFxbJzoROLWIk=;
 b=S9ANLdgrHNXZrtkI1LJmHhsIzEP23XKPWzjfbK2QnDd5L7jlc2JrItU2E3AOKcRpt+NscLJ/dzS0txvFvhczFLP9Du5rZ4zTEjBg12jsrPDWOieaiBfp53yNVYTklg8Ahvte3eMPbrFigEDMAPNcCC4y4RxiJy3rJWbfjwo6+Zugc9va0Z79VgCJui9bK1XpolFNxs+FmgcGruUMeNH74NOVyo57QpAg51d263b6G6zwLJXIeid9OvcCvtKgJcIleFRM6YKdzq32WtlVQe+owExSwtKifiPIouHg5rwwuo19Ls/QK2cxv31/TCN6qZabOwV6E5Bm1k/yZV3XyJ59fA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XZSeYjjkUcxj8LEv+LRhzMUIpz5SuulFxbJzoROLWIk=;
 b=IIBTborCB4cQcABTdgty8C3kMLMQcDyRm2kLc+TGX5LGI6xZNfmlLDieOb/WKFsTVEbc2gjwWDckOBJvEXyPNgSnd4M0zSImLSF1KNO2ubY52jTKoXnPS6w8chEh8zYQy1FVK+o7VB8PkwsEpetv44BlPtNoO67RvqxePjZjVw3+y4TQxqjPqy1RlxhbAmy9acrrDPgbA2GUGsbXEJS+YvKN6sP3lY6JJVR6P5KZ+k/ShHrLzKmYuLmEmXC8i99XpgyhncmZCKLbk3QfmxnNi+WGd5SA38ShjNHrXie+ABpxOiTGooWreJB54B9qLu3/9Xj3TcW4P1DtQgQcvabeZA==
Received: from CH0PR13CA0047.namprd13.prod.outlook.com (2603:10b6:610:b2::22)
 by CH2PR12MB4216.namprd12.prod.outlook.com (2603:10b6:610:a8::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Mon, 25 Aug
 2025 14:35:54 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:b2:cafe::53) by CH0PR13CA0047.outlook.office365.com
 (2603:10b6:610:b2::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.11 via Frontend Transport; Mon,
 25 Aug 2025 14:35:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.8 via Frontend Transport; Mon, 25 Aug 2025 14:35:54 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 25 Aug
 2025 07:35:38 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 25 Aug 2025 07:35:37 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 25 Aug 2025 07:35:34 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Alexei Lazar <alazar@nvidia.com>, "Dragos
 Tatulea" <dtatulea@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net V2 11/11] net/mlx5e: Set local Xoff after FW update
Date: Mon, 25 Aug 2025 17:34:34 +0300
Message-ID: <20250825143435.598584-12-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825143435.598584-1-mbloch@nvidia.com>
References: <20250825143435.598584-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|CH2PR12MB4216:EE_
X-MS-Office365-Filtering-Correlation-Id: a35b3000-3ccb-4286-5451-08dde3e4b2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?A9msPlb8KjDDhfRhLi5D5OY/AfzkNftMM9g2ahEsYhJxCU/2BXrXax7aeQce?=
 =?us-ascii?Q?b+wMvLqMY00DJ9CRSSSLhi8tDEFBpXF7x4l9zkR085KaGR9oFkaCiPO0kWVL?=
 =?us-ascii?Q?xRm4UeYhxDiA/WqnB5uOyu8r2a9ORtvCrRrEBa/lAp4fkeQv3PklUIyOh/E8?=
 =?us-ascii?Q?yWA/2H2KG2+Ua4lfOA0kXJAm88OUA1tBhFvHVJG69rqVfbPgmxG+3llZwSKx?=
 =?us-ascii?Q?ZJQ2SNArv2luIi/ZBwwB20kjjqr27V7BV6heFDOXibdpCecw3IBDCJGpcYKL?=
 =?us-ascii?Q?2W0pFe8uT/bQstP8rkrGp8wy6ZqduuGyyu+VBBqb7GKWtzv6ZmjJIUmSVFhz?=
 =?us-ascii?Q?ylafhqmjC/ozActUbs9IuNLuCBPCoGDjlcbPBF2h5NOlRFyJcyUqjS0RWFlA?=
 =?us-ascii?Q?YMqk/qigInl67iNACxPx9CXjtFmJVhG/aT+Jowg7OUZ61x9nyVyUaWifcKBv?=
 =?us-ascii?Q?Y8BHnMMHhNf2QAjYDCp9AkNGtwjDxqG7o9pI3srkcwpUex9d/kW+SkK6CBFQ?=
 =?us-ascii?Q?3fnCq/0+sjUe/EZcegQYwUpQXw85YZ8uHvRHWdNHQa9dgSAXoXP7Bjp81mjP?=
 =?us-ascii?Q?aYmd3Jqlz5qeH4fFsV5NG1XFOrg8HaNFOkgFlVFbE0D9GhzfuDI+1KqxdH69?=
 =?us-ascii?Q?Ini0VSs30WzYv4pZeF+6np4Q8UhFw6j+/MuDz94tD+iHNCEM1ubbZ3s8+v8B?=
 =?us-ascii?Q?TRLhFuAHl8+FR0lJGH1+UnYoRDsz4BPNIwfuub/KLzGoYTGVGxKpKqMCHA8F?=
 =?us-ascii?Q?FAzQVZJJCODNKu1T0BENXrKQwIlMIt/3BgMY2o0jYSRUwNwN8g2y9NahJl/F?=
 =?us-ascii?Q?mq6tPmkPMZnlOHWi7gYAD07R40F+aiSMHO752sHSw8bW0gHgtJ8jw0iNVSSZ?=
 =?us-ascii?Q?Qkr5IAJaog9mr0h1GsVxAU0TImcvsOEXtqXjWHaoCs+Yq8oTgthigAB/wenB?=
 =?us-ascii?Q?69gfdmga7NXXPqA9I6tavxBZZM9lu0tuXD/COT5mHObu7jbIA49zu/+7aqWZ?=
 =?us-ascii?Q?ab9VhO1YdDwcveZFTlOfpmBOX2Ga46HTu9n35Asuvex6krtVuamIFOM6II9i?=
 =?us-ascii?Q?svMsow5Z6VLKlPc5GUPEZEqHDGahwdrtGnN04i38X2kFWdmUUnvbq1VTqESb?=
 =?us-ascii?Q?aYUoKNMV5UwfJC/TWmrTJqfkbomHu9dWdKklzXubX2R8VKpJcE+t0uqrv5eL?=
 =?us-ascii?Q?tUtRWT5QwKLd9MxaeXVH2cA0+GMBISCE4Pmkxu+DX7EISlvTN3NU8jQD9EI1?=
 =?us-ascii?Q?gL4lqmHU3qN6A8Fo/miDnPYoigzPiowa1rSb3XJ8HqVXvuHW2fimOFw9xllL?=
 =?us-ascii?Q?f86quBHAQEm4vq3LOHJGnIFRTq4+vwzzXTOplg68pk5leMBY6lVGPY6AaXDY?=
 =?us-ascii?Q?S7t2NR/Y1BWNMz2Ixs7LyoSJocIoLPn8QjvIKAx8mWgXysPHB0MdH0GaRaSz?=
 =?us-ascii?Q?xlxuEwamA6z1OVSC4atpMyJo2KgM1WNLIijeSXolffjjHc4gWhwOaCv1DhsR?=
 =?us-ascii?Q?cMB9d6BvzzFYrYblVI682HYp6qoPjRdIcb5w?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 14:35:54.4832
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a35b3000-3ccb-4286-5451-08dde3e4b2ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4216

From: Alexei Lazar <alazar@nvidia.com>

The local Xoff value is being set before the firmware (FW) update.
In case of a failure where the FW is not updated with the new value,
there is no fallback to the previous value.
Update the local Xoff value after the FW has been successfully set.

Fixes: 0696d60853d5 ("net/mlx5e: Receive buffer configuration")
Signed-off-by: Alexei Lazar <alazar@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
index 3efa8bf1d14e..4720523813b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/port_buffer.c
@@ -575,7 +575,6 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 		if (err)
 			return err;
 	}
-	priv->dcbx.xoff = xoff;
 
 	/* Apply the settings */
 	if (update_buffer) {
@@ -584,6 +583,8 @@ int mlx5e_port_manual_buffer_config(struct mlx5e_priv *priv,
 			return err;
 	}
 
+	priv->dcbx.xoff = xoff;
+
 	if (update_prio2buffer)
 		err = mlx5e_port_set_priority2buffer(priv->mdev, prio2buffer);
 
-- 
2.34.1


