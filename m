Return-Path: <linux-rdma+bounces-11987-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C433AFD995
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 23:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0810E580A96
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Jul 2025 21:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58979253F1B;
	Tue,  8 Jul 2025 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TWcmRgMC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2054.outbound.protection.outlook.com [40.107.237.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7EB251792;
	Tue,  8 Jul 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752009437; cv=fail; b=EIdOhDXn0AwV/WxjwdrBibjt53mOBNoKlhcZ2q84rqHAV+OKw0b2v6k+VWIsKxFMM4/TQwrPs4/ddtTxgHJ7GZ48euRdbzdBqvAfb++svRq9HQ+OJn7FbhB/IPo80EFaIxqce0Hjn2RGSGpALRLwX9rKAuwHwbBzY7JyDX650yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752009437; c=relaxed/simple;
	bh=M7gic7/nVeVa8CPTx/GVnTPTpA/kvQobUY0MX4+g8dE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cVFkrd9rHJEeLfMkD8fBZ/V80ArWhgkiroeF6LuJ+YnuF00bQB2iGVd9c0JvCyJQSqnL30tvD5QM/XLAWOcf9Z/3KTMDOyL8T0LleR4azXyqSysZ2cyf+wRKQUvv9AHy/aGSSkH/txoWgyR18gldpgHjzHdKLT1yJtc18aNljlM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TWcmRgMC; arc=fail smtp.client-ip=40.107.237.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Wi/opI3ENvWGxA+MdhP1/OCYbLUsDLDPcGtW/THSYtPmz1Jmz7//fTCLrO54E/ld+r7if8SqEyn65PAfIVf3X0pUr3vGMsBuCNCafkGtElhgrBp+q/RhmrynqVq/34nqsohIjE12Kl/ZPpS2tL7JtPdNfCEAPBDphr9TxowKgUCj6dND7/QBCTbTiQuAeZqLBUDK21VGV3AU80VmIw/JhGQ0AXjH7F+ub7RFvXamEdHeH8wqEFmupw3hpR6n+Lj7pz5CfWsfEv+8gs7kZwGyLkN11AcjCWa7fV3t0Eu1RvKSzjpzvJIv/CBS/c2wf8QrXzT664I+clZV1JZLtSg/mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnxD2vJQ1xpim/Ofed8TCDALx6YRmKyfch4XJFCvv/8=;
 b=u8BQqllUcK41CiDRaDcatQhgj+hJplsXkQmeCnOTG/pKUcMg6CAc7ClpUxxZ+DuK9JKwSXBW0m7YjR2hwVmoInuPhsQl7xXKs0qCQ3u/b9jnQvTS1FBWqzgKcNSLK06dKs2DuKiAnOqZENzAGTA6NYQsqAiqVjKVTFixGH8Tc80MXGLe8X85gva6ToGC/rT0j7YMWmhz2CSYgEcg4bR48YCZov1A7XVai4Qd00xTxE29KW1AlLN7RSqDjUb6jDmxe3oDysJTGfMfOX+KEiLlDTpmyvDUyrdYcqfBQi1o6aKHYq+VrP5/teoT6JJ8dOf5O7bMYrU/fZzGJ4Jqjrt+NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dnxD2vJQ1xpim/Ofed8TCDALx6YRmKyfch4XJFCvv/8=;
 b=TWcmRgMCctIiRhKYWW6Brfc/fvEF5xu09k69mr0z69P9U9mG1mLE4+2WBlU2+begt/0jSxEPVa5YTpYIK71TmNfbybaMUrL0gcYSjrIazRnp1g2fOZ7Fdw07a4+4zT0f20iUQU500nRnhbScaYUFgDd6/pkYkfitmOYnEqYJxgOQM8Rmc6uWAFSJXVD8uIX5En29n3qDp1uboPUGseYEPCRKytHgRhg9ep2ZqXNLX7yrGnrVdS7Q25ezbNt6mSyK+CmEYy/G2Cxc0eFFn8Nncq4CCRzIwm5TLZdguMJeror9GHCeuqu4D8QS2uvzy8s5bOQoeHZIK9jHF5xWq5d7ug==
Received: from BN9P223CA0018.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::23)
 by CH1PR12MB9647.namprd12.prod.outlook.com (2603:10b6:610:2b0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 8 Jul
 2025 21:17:12 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:408:10b:cafe::8f) by BN9P223CA0018.outlook.office365.com
 (2603:10b6:408:10b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20 via Frontend Transport; Tue,
 8 Jul 2025 21:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Tue, 8 Jul 2025 21:17:12 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Jul 2025
 14:16:57 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 8 Jul 2025 14:16:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 8 Jul 2025 14:16:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 5/5] net/mlx5e: RX, Remove unnecessary RQT redirects
Date: Wed, 9 Jul 2025 00:16:27 +0300
Message-ID: <1752009387-13300-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
References: <1752009387-13300-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CH1PR12MB9647:EE_
X-MS-Office365-Filtering-Correlation-Id: 2438859b-4462-44e7-1012-08ddbe64ce88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ymSnPN5Ke3LjpCk0KbNS8zg5pLuxdBTIBpnEhX4hWTH5WuINLYouzCOaphqt?=
 =?us-ascii?Q?RsG0lUr6JmHAtVC4hijOXGtgUuH3UokVb3I7k1cEV9BLTMbHSjkO5mqWzZ0I?=
 =?us-ascii?Q?rDA28MLqcTdgD7u/4d4NlXxARxNvBci3jnD1VfxsHctu5BlL03iHp0+JMj4U?=
 =?us-ascii?Q?wVxO51wKDfZsxigtVc9vdJikrgNl2/wUYnimhtnIE9C9JgK4bFU4v6umP2I6?=
 =?us-ascii?Q?keQ7Lj/JGp4uGwYY1nWTZ0ar1iDVUZ9RDRa4vo+DpRQOI/wCk9QGRe/sEpSL?=
 =?us-ascii?Q?23Sf4jDFG/485eoHggXSAZeG/o+iHzgmOBaHti1ELgYdZoP+FE7n6cgs3Pck?=
 =?us-ascii?Q?BF6TVLCOXuxINzks8ftuxVNLINuIn0lqkmBvY0jrdTclPNRrMtVPRrw0xcck?=
 =?us-ascii?Q?yWKSjpdQ5EcdRv7b2GqoI+QY2ofzwlor5oyQNws9nVGV4MlTgNBujiy3dbMV?=
 =?us-ascii?Q?SeXZBMAb9VzG5ZhiyYF5wM0hdA+Dj2MbNtdazpvFGagT5CuX87IYGYD8vpLG?=
 =?us-ascii?Q?7q8sREAZMLaCXUyo9EqV2BAv9Dw+X71+OIxK9b6BSEHRa6jooB0STwXXYoaa?=
 =?us-ascii?Q?hA9j+zQNKOyyOUUVwmDHxTrRdmJr5sieL4YjOOrIqS56OR/NCQTxiqqkazvO?=
 =?us-ascii?Q?HbauvkK6mHXGbin/ViXzKFNlBpO/eTVLtp3DQJG0idPCsUcUexr3k+eojXpy?=
 =?us-ascii?Q?qC2tjBZ1D7FGv0Rl6Ro0STEn9LH/fpIiE21D8QGsbgye70yHGCumQ58oj5Mj?=
 =?us-ascii?Q?XX3xCfw0XxSN4vVTuPRodhSsa756kou67+JIlsdvwRCK1KHYGVRcPGDv4etk?=
 =?us-ascii?Q?92QBgHz95dcbZR/FVTbOmznUv/4YViaiTfrJdDPs87UBKCYTQNJSFlm5BPs/?=
 =?us-ascii?Q?h09D3q29eObfHTFB1jc6w5UaUx3OfZCMXjLkLK/7c6cDDcVpCn43EsNm/RR7?=
 =?us-ascii?Q?ct07o5E/xdsFA925No1ymEOMtLy7Fpe7SLzzbV6er604bO9yvFTZ2eBfwxcS?=
 =?us-ascii?Q?YRw5hP99wn0DFTEc2x3ENpV4F4eP+0MMQAbZLXZWPyJcisxlZBByNdHWlR6f?=
 =?us-ascii?Q?9hT1Rzs6vdqRgzLn7TYR+cT9JCf3dWlTprrlhkxMyN6BK8ZJNLnPkKQiqKc2?=
 =?us-ascii?Q?Q1ymwuTQJxL58HJ0NrmOhDgJrD4Y6mhiBI+jNPnnb7kOKKGnkGaiuWPgIqjC?=
 =?us-ascii?Q?4ATk/oNwS984Y7RVNPhXJBzfQx+a2g5n2iz0GhRPKWQWfxDcAT+tR6vqvLCx?=
 =?us-ascii?Q?rwxJoiKRrtUmPy/RsMlW53ihOaBS6tM+wMbs0FZvB43MqJCU/94xGxeQTmDB?=
 =?us-ascii?Q?9cBwpEtenRq4gzKeSfR0G4RYgd3Ht8k0WrMlC28/X5F7fye68FX9SrJQHW7u?=
 =?us-ascii?Q?q10nsvDEPl3wZjAoTGlE5R42tLwjZ9ZaQNkpbg/H1JjREK0bkGNIISmfIWaE?=
 =?us-ascii?Q?z861XdySKZ5cTWAxG97VtuDLc17O9JlcuWO5wwkocU74mR7WqGwws4mGJEGL?=
 =?us-ascii?Q?C5NF359DsdD+RUWDpBT4VVggEuo6vAwc8c9N?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 21:17:12.5644
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2438859b-4462-44e7-1012-08ddbe64ce88
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9647

RQTs (Receive Queue Table) should redirect traffic to the channels' RQs
when they're active.  Otherwise, redirect to the designated "drop RQ".

RQTs are created in "inactive" state, pointing to the "drop RQ".
In activate and de-activate flows, do not "deactivate" the rest of RQTs
(beyond the num of channels), as they are already inactive.

This cuts down unnecessary execution of FW commands (MODIFY_RQT), and
improves the latency of open/close channels or configuration change.

Perf:
NIC: Connect-X7.
Configuration: 1 combined channel, max num channels 248.
Measure time for "interface up + interface down".

Before: 0.313 sec
After:  0.057 sec (5.5x faster)

247 MODIFY_RQT commands saved in interface up.
247 MODIFY_RQT commands saved in interface down.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index 5fcbe47337b0..b3fdb1afa1e6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -579,8 +579,6 @@ void mlx5e_rx_res_channels_activate(struct mlx5e_rx_res *res, struct mlx5e_chann
 
 	for (ix = 0; ix < nch; ix++)
 		mlx5e_rx_res_channel_activate_direct(res, chs, ix);
-	for (ix = nch; ix < res->max_nch; ix++)
-		mlx5e_rx_res_channel_deactivate_direct(res, ix);
 
 	if (res->features & MLX5E_RX_RES_FEATURE_PTP) {
 		u32 rqn;
@@ -603,7 +601,7 @@ void mlx5e_rx_res_channels_deactivate(struct mlx5e_rx_res *res)
 
 	mlx5e_rx_res_rss_disable(res);
 
-	for (ix = 0; ix < res->max_nch; ix++)
+	for (ix = 0; ix < res->rss_nch; ix++)
 		mlx5e_rx_res_channel_deactivate_direct(res, ix);
 
 	if (res->features & MLX5E_RX_RES_FEATURE_PTP) {
-- 
2.31.1


