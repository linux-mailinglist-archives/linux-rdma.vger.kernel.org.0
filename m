Return-Path: <linux-rdma+bounces-14336-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73982C43AF8
	for <lists+linux-rdma@lfdr.de>; Sun, 09 Nov 2025 10:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA1C3B2EBE
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Nov 2025 09:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D922D94B9;
	Sun,  9 Nov 2025 09:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SLACFqeX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013037.outbound.protection.outlook.com [40.107.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 281AA2D73B1;
	Sun,  9 Nov 2025 09:39:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762681175; cv=fail; b=eDu1gCFOrzxoMuPJYPeHCtHUTRJfJOsE/YJrqCFQexPLRKvwI/EaKcuUxSMiqbf+ldKxicrch9LNnbY7R43TN569C+kXREoAESkeAopMsi+QRUMH9cYtAA7n2Xml6wHgwVotkoIA03eu0+bfFo/DRoXYi7SApA5xjhU2w2nMdEo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762681175; c=relaxed/simple;
	bh=F2YBi0oVxOtv0Gt1hvkHDCpUBPwrAwobwGCwVzm0tyw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fj31wbtX8gC2viFBpelYvP/efik06j4RmEvBCVMETXYy/2KWNTxV4PhNMtuTH8J19hf1MU23JTAJlK19CuEKvTMasb2EksJTSDuj6L5tI1k2XN+9Sa/2V81M/vnmqNYUdydcjz0He6cKvPbaQ/KxWonCnGriWXlLvl7UCUAtmSY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SLACFqeX; arc=fail smtp.client-ip=40.107.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kzEQhM9KxcrCbpeawhT5yQ/wEl6l7G5Vx9hd1BTkZ/YmU4XnbK1WglcCcuP3diivpax51d9ldrYUu6g/4MrnAOWk4HtjDkLaGb5rlupiD+46TtFJEQ0CITz4GgV45qpsOrSgiyyNHvn63RgmYFU3N7D16YOMcbK3TVjOdh+BrcSJHj36cxkr0B5F7RawEIFLP0HHmz9jfPrugDwyBIrbcicqUByZYsTU+X26p78lcegB7SD+lvNKYyG98zYd77SESGT0V9lqlRbOykvoFZD0QG02jBC9IuQPVq34wDBYoS2zGCpRX4AYUB7X1KpKeJzJ/02QSAc/pbsCPy6/dnnuxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S+GgU5WOvCId56ebE6AW88FHdxGveUwY2sMvHw0Ut/4=;
 b=B98MtoH3YV9ShMHiTuPLVzykcbGtU0K0NCdsylhCCcDEW2nOaifbYmv14HcApAZAXidNS7ZWPkkn7KG3jvIwo5mUUoy+1ygLMbasqp10SEcVrmPW6hRtmUvRoI9QIrBpHenJMj07BL3WhSBuaA6jo1c0ArCuBE6+mGlxm+wOem/tJNkKsgjAWcJPEXVj0uTNj5Q7rW4avmFcFVXwBSt8V4ZeEPco7v1eda2nVPDZ+LA8wYlZ19QSqNkcM878WqNatfGUn4IZGFc8PWZF3jc3AjbzJbffaOOEJvfbOzur2Z37Y5kXI3UnlHUyYTNXb/TdKNLbIw8AwWkynfO4VZitzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+GgU5WOvCId56ebE6AW88FHdxGveUwY2sMvHw0Ut/4=;
 b=SLACFqeXJ9Th2g79NlRRGR1GQM1HUZ4BKaHKOAV/+RZH4JRozrpTHKa5majUfL7pmV82SF9RA+r53uDnJ4rTHfffbZGIETelo/6WF3rMgwPziKfzGU/LB0+BFQuFJ4bSU/uFnbdVvfLXr8q3H95ihMLCqd5t/Eu/hWRiiwOdaoxXStj5tSQ+iMcHGL1CTAfXIw07PC4EUrvumrTbs6TRBdizQqQxhzgf5lPagQQ5rbpF/VH88Q/xSTQ8zbX87e+YP6M8NiElOKOnV6GfjPJyMABwqwZ9y+qHBYgOHYVXCT6yoFlQzs5xR+8Go2vF0/Ez9GChIW44Wyej5qhMA/++Cw==
Received: from BYAPR05CA0088.namprd05.prod.outlook.com (2603:10b6:a03:e0::29)
 by IA4PR12MB9812.namprd12.prod.outlook.com (2603:10b6:208:55b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Sun, 9 Nov
 2025 09:39:07 +0000
Received: from MWH0EPF000989E8.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::e4) by BYAPR05CA0088.outlook.office365.com
 (2603:10b6:a03:e0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.11 via Frontend Transport; Sun,
 9 Nov 2025 09:39:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989E8.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Sun, 9 Nov 2025 09:39:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:38:55 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Nov
 2025 01:38:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sun, 9 Nov
 2025 01:38:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net 2/5] net/mlx5e: Trim the length of the num_doorbell error
Date: Sun, 9 Nov 2025 11:37:50 +0200
Message-ID: <1762681073-1084058-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000989E8:EE_|IA4PR12MB9812:EE_
X-MS-Office365-Filtering-Correlation-Id: 52f4c4c6-e488-4d46-7a3e-08de1f73d3d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jiZeSfu3s7p14lcjQkg83E69MmAkO4tOs9gjv3YXySpf3Pfxaj2zNXO1YqPu?=
 =?us-ascii?Q?kvMKjbw1Cp9DYGgSyOC+FuX7IOqykfNPGEwjLTX4/hAUSiyh7njGRXsbdXS6?=
 =?us-ascii?Q?HrmLxNDsU425AKZTJMXzd8pQB0mj67f/kmMd1f6z2oleS7dohrbEgQp8Jebg?=
 =?us-ascii?Q?bjMvFuFxV9wXS9HvSRYKe6U0XDPALV+cRvcC3V6cJHoy4Esbi+mMXhtOPjRG?=
 =?us-ascii?Q?Xlzexn50BtTkNfiXK7hQEHwGyJhuIONJ+lbdsR22wnshqcMttNHpZWBkTTq3?=
 =?us-ascii?Q?UuBdgKVHSOj6y25kh0dMTG2ppYMkuWi4QBPNz61m8uxRuTEleqoW1vPSWWtk?=
 =?us-ascii?Q?Paa8PKdQu4Fxa16aByhEZcb08ld+VXvYNsnmNW0IPVyAQ+H84z8P4iV1ZoPc?=
 =?us-ascii?Q?tN3HCXd/Vq8GS7+apT0cayVr8HMU/aYlaV99pla6vBGWBFFyVpA6JS1o1I09?=
 =?us-ascii?Q?QgCJHH9utIXWK9dlF7/5awyN+s5qDtig0d+SAWmIq+ApHRSUynzYVqfxw/+X?=
 =?us-ascii?Q?Q8hlfXcP17hLO0dvC0s+pD4fePgZjDOlMNlVWISoiq0UmOrPaLCx88EGmIDc?=
 =?us-ascii?Q?DipMyPA8HOZ7kkVohOzZk4Jv1r76HqeqFZQlbmsKYgVAAtXQy4DqrxnD6QgH?=
 =?us-ascii?Q?zK/PpMsZYTGYAc0IG95k1ez+nOUF1UU6tq3Su91PQsAMwj3qwceBQtA1bJzX?=
 =?us-ascii?Q?7/sp31Fi1GwmTIHh4y/7ZZ9IZ8RIYUU1fZZFUfNglOa08G6l/i/ViTRMZcGV?=
 =?us-ascii?Q?zjCKQ+PJSaGgNHmebkTDi8KLowL5kDGbVky+6/Cd2cghhZdT0fPO/4OQKuOu?=
 =?us-ascii?Q?OYrOGttmmFJIZ9uefNvIQH+MQzsCHce69JjzeNhHpvLiU2rV1VxaaSxvjqxY?=
 =?us-ascii?Q?y8dxmq9u9t0dWXK3cRl2DBXr/O7QWQ3cthtbd44+F4xrSPkUrox3kP0Q2S0K?=
 =?us-ascii?Q?WXaeQnV8KTzGfa4aH9lyOre0fkwukcjIZTbF95Dx+N4XLyh22ZbAxis0KHxk?=
 =?us-ascii?Q?qWmzhVmNQ1hSVzY+CYCST24G2QUJDHWGlbFRCr4EuK5nrqmJqwuGa3eZHOgi?=
 =?us-ascii?Q?fcsnersZTgQR8waCHFDkDCikhLjAKMZwelJ0HyVz/HKvS9g4ch0XRVa2YcEW?=
 =?us-ascii?Q?6zL1GHGYYzYbPCqj5Y6Ui1JJF2k8cO/8BExiaYY9OZ7HnvomBSU6YNvH6skV?=
 =?us-ascii?Q?LhqOnyuSs3iKte54ZTjSV4v3OhSBT3lGWeelBZVeiRqZLjcDR755SSy1UNr9?=
 =?us-ascii?Q?G+pWjE1RzhP7WCzTlu8AQl2NYO6xzEfgqnSvWuavutO42ceMekqYxY7McA5m?=
 =?us-ascii?Q?L0k/A4z0b0AAXgtr4Mjko7VGDeHbX527rLz4Q6ZKp+0uYVIrNXOS5kpMZYy6?=
 =?us-ascii?Q?HGqKZK60AgG0jvMFPIkce40/OMu4TAOnz7GrRxtAZjw7XE8v6RINlpZhwGz3?=
 =?us-ascii?Q?dZK/xITEMXxdrNll8Nz7iUYxr6ImgKTI5aHZip8vmXkyO5NtxEdE27X5cZFK?=
 =?us-ascii?Q?JWxpGW2jnFnZU93zh+1xHDcWCltRcPLpRxBB1Egp9DxmbMvcAMhvdeIygy6b?=
 =?us-ascii?Q?j7Vzotk+rsWlQ+YoUpk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2025 09:39:06.7730
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 52f4c4c6-e488-4d46-7a3e-08de1f73d3d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000989E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9812

From: Cosmin Ratiu <cratiu@nvidia.com>

When trying to set num_doorbells to a value greater than the max number
of channels, the error message was going over the netlink limit of 80
chars, truncating the most important part of the message, the number of
channels.

Fix that by trimming the length a bit.

Fixes: 11bbcfb7668c ("net/mlx5e: Use the 'num_doorbells' devlink param")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index fceea83abbd7..887adf4807d1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -541,7 +541,7 @@ static int mlx5_devlink_num_doorbells_validate(struct devlink *devlink, u32 id,
 	max_num_channels = mlx5e_get_max_num_channels(mdev);
 	if (val32 > max_num_channels) {
 		NL_SET_ERR_MSG_FMT_MOD(extack,
-				       "Requested num_doorbells (%u) exceeds maximum number of channels (%u)",
+				       "Requested num_doorbells (%u) exceeds max number of channels (%u)",
 				       val32, max_num_channels);
 		return -EINVAL;
 	}
-- 
2.31.1


