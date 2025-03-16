Return-Path: <linux-rdma+bounces-8730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DEE2A634A9
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 09:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819573B388A
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Mar 2025 08:15:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034801A00FA;
	Sun, 16 Mar 2025 08:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q2Qz9lbz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFF6719F48D;
	Sun, 16 Mar 2025 08:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742112913; cv=fail; b=C6SGUiwdFz5VXGZ/b0vw04V+yAPGHPDArezQYK/l9VJOLE61MGeAftq9Pzo4Xj3DgAi8pC2SlkumNpFeV9tVArNiA9cM7KRSUsRI6onQeSFNBluu3JMK5mN4Zy1ZhHZT75EVmBK1BvVqBAHWQIM8oLF2zeAF8R3OI6QE8jQW2Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742112913; c=relaxed/simple;
	bh=dgytlhYyUBeashVfd5Fy0MUTAy5EXNtdr0W+IIrSQjM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjTd6RnTlgH5JhF1mvApRTrOw2p7Wpr+JyyPyflVuA0EuBEjvF4/lyapBQCwh3MG0oXiYpMkCxlOOgoOFb/pBmIHSkOVyJ6QquPUsCqBqPzQJ4Fy3SzZOt4cLdjXxZm0cwfDzpm4rHHYOihaRHdMcqYSBSVV8eV/zHmyqXAPiLs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q2Qz9lbz; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TPH/2rrK7OAhZKVTcS2Bm8QtnFWmryzPcYlUVKBq21kJd2CnwXlB+YxsVx0959GtQfh9yZiQ4pEGdNrUrMiRucd24M3fHHH8gPKzjkM4a5Hv3Ymlfrzm0Su8dmo3jsNsQvLEAxGMu5pMoEgTXaLXRz5yMRxK9Zsjeg8qF1vL3sQlNUXY2GhdnFKYxhhgOKMxn5vvejxOR39r4c7K0I9QpbFGI/9siIkowds+NoaBGDlleQA//S1ROrGLbszjtlAjFnBHYgvWjZu/MVwnlZolX9b5Nz3vLEWnOXBd+BtpeSmH289JwY5i86RyCRKKiztWp85M2/3kDipNumhnYjWbKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Oa+l0Y1Iz8xT1HafZlbWQmmhpQFZEHX0Jbr2FnOIosw=;
 b=F+gPBGMoq2wRRLfC5+pwNQ1ED2qjSKUXQ/j7uxnR1wwX9ULsFk4K62kj0vKT58fMHXucNSjcGMtMZuc1plKTZJLndOnqgDnQRINFrQcI0frInmkOWhbF6lnBG13z3rCEEj8g3m/WBbpsd9zIuoV00EqXsTAMTnbpBaq6f7qoNbpo24unAee5A7oZOv1mDy4yb03VD9CMnDVmcVcTy+ADRVLkchQ9b++QBFqKLzQtfWHhnq4KXF31T5FQm5oAA0u35uZoYijM933hTuY/Oce2vWLu5cQ3XcXkMs4tOPfDt1SUBG+hF8QhTjM71h2QuzKpgLo686ymMe1Bu/WdKX12Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Oa+l0Y1Iz8xT1HafZlbWQmmhpQFZEHX0Jbr2FnOIosw=;
 b=q2Qz9lbzgxfDnbj+z5cJ6inDyKAuCiV4q6mypIUJnXugY1jgOYe/BCfXXjse14rXZncagTbNT4JP3TB4db+nrSUPqs218esbak0vS9IheTISBhmEWjxzNWLk593dDBgkvLW8X6XQ5RoHSwafCn9133RaWTe8mZw0DD0XRaaid/TaK9rQvCdYWVdxZ2Nv0ZlkGbFNl9JE2Z6t9Xqkzrfb0PyNzXqDZKjQyaSyjEKvur5ByGRV3Gbg8wdSz4UOKA8Ma74LseLms74U76/9YzoqI/Pa2q1PB5XdszBzOxshxZlYIqxKkJy3XUM8q6BgEJoYHr2qEku7LV6zfC1dalTw0A==
Received: from BN9PR03CA0892.namprd03.prod.outlook.com (2603:10b6:408:13c::27)
 by SJ0PR12MB6928.namprd12.prod.outlook.com (2603:10b6:a03:47a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Sun, 16 Mar
 2025 08:15:07 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::f9) by BN9PR03CA0892.outlook.office365.com
 (2603:10b6:408:13c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Sun,
 16 Mar 2025 08:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 16 Mar 2025 08:15:06 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 16 Mar
 2025 01:14:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 16 Mar 2025 01:14:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 16 Mar 2025 01:14:52 -0700
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
Subject: [PATCH net-next V2 2/4] net/mlx5e: Access PHY layer counter group as other counter groups
Date: Sun, 16 Mar 2025 10:14:34 +0200
Message-ID: <1742112876-2890-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SJ0PR12MB6928:EE_
X-MS-Office365-Filtering-Correlation-Id: c3857f24-58a1-4251-79d7-08dd6462a922
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+xeX3WtSYJCOe3or0HVMXf0eS1C8bLo1VICvtwZWDcDdp6aam1qnd/2mxggh?=
 =?us-ascii?Q?NbcQ2vjRY026lEodWLRzbsDprMGGKvkryX0YqqSnnNzNMoKHr3wC+FHWlfxa?=
 =?us-ascii?Q?Fb+h1sX9w0BeSAK+IfaHIMIL8AQZre5LzLJkwie7LgzvvBPIiOON8P0JjQ91?=
 =?us-ascii?Q?LK5JlZniZRaGr42J7PRYZT9PWGZuaMX58Y7P5FzMSMrpqFim1vptHz6/lEA8?=
 =?us-ascii?Q?yq3yQBx/rqObjj/gvJxyeadM/skTpaEsphtCjj8T74VH+BzSBqoctn8SXLEQ?=
 =?us-ascii?Q?E3yWQZ7ohVmNgcLnOJc9ux37StrXv86T0XCKHSDAjRsMP1Mt55IuEhMsReEL?=
 =?us-ascii?Q?MU7Vq/lR5ZVned3tzJVhydWzjh1R6s8oiBucnQfjFrLlHVn/VSuqWK+Ts0jr?=
 =?us-ascii?Q?NXu/8SzfFancTlNwU8CEPvg9THAn1mp21huRbMsPJbcTuIBO2ZMG4n8wRzMN?=
 =?us-ascii?Q?uAb8wKaehMljBplEszUEmyMfgwFQpSCTaxoq0YATkLTwTFX7Hya8104bmlL9?=
 =?us-ascii?Q?GUQ9e8ey2Sh6dOAgve5xv9vrj5ZwIjTd/w/yoYsHqpc3O7As8ILozXGidV1Q?=
 =?us-ascii?Q?RA+rhq+fqHGOlsyyfKrT/1+6vEwhvjtqYApJq79h2qc1YxjBdm4qcOFZSEbc?=
 =?us-ascii?Q?4k7CWpX6XLFhDzbotEapUme7Cthj6I7J54aJmusYOw6Ep3Js0eByQxzpUae5?=
 =?us-ascii?Q?xk5e7mYztZ2xxUGd8fGZYpbNN8kyjFpwwo4RKjiKvrS/R0pwnFvQuaD94W1O?=
 =?us-ascii?Q?2JiBGRVOYUUq0wTD15OvJ9gqjUlQKKbbWxbI+ghBkrMTNADGfK1DbQwzJY+B?=
 =?us-ascii?Q?bcaldeeDNnIUsCmD/NgZFCToV1ZeQMK41JcFh+yVBlfy6aQy1A+XlZ+RxR60?=
 =?us-ascii?Q?7/Njn3Go1CMaeSYdCcaCWK+FvFzKHsDK0O6LGACUfqY3gKCTjVKNssfcrWgu?=
 =?us-ascii?Q?d3TsqLp7YDRgJVVrRoYXlqay7CSGajC0Oyc3Iq1P+Yn/Zidi8KFtcgDgKdVM?=
 =?us-ascii?Q?A7er3ZUg0LgBqwmxNQ5IswJdhOy7dpwVsiQpBW1OabED4+PTnjWT2AxxJ8U5?=
 =?us-ascii?Q?5CMV97EpHZYl4CKxN/BvGv2ISgyFAKchuCkHc1FvZLRTr9Hx2FgZVAc3cHGy?=
 =?us-ascii?Q?V4TN9KzufAf9WmDINOUNUIYdASYY89/FQ+1cYXeh3kKTYVyal+jLmIKzCAg9?=
 =?us-ascii?Q?l/+CM5q9SArBytpEFVJyOUBTa0L5zsggrqpI8RrbH8LXuJFljzncKnPKU+Go?=
 =?us-ascii?Q?6FATJ7m/oQ+HfMQVEYWH1vdqKNoTGPMGDLMpXsxRr/YAsgrMSawZ65WsCy4u?=
 =?us-ascii?Q?rSxcDC1mjUwgDALiNss9uzWz4MVJzRg8lVCWrWQdZF7gA+OtzDN4FpEf6Jb+?=
 =?us-ascii?Q?EH03nPyeLTaMb57kEU4PnUEKeQajX7nk2KvfDPR8lpmt2CS6jhO6QRO8YSLD?=
 =?us-ascii?Q?6vjSw1ArGnUwjoAm1dvXvEhvU4JQpUxsr58r3yDHfMoZMm6EbK0n7YsZVnTJ?=
 =?us-ascii?Q?sS24D41mwjkvRoU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2025 08:15:06.1628
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c3857f24-58a1-4251-79d7-08dd6462a922
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6928

From: Yael Chemla <ychemla@nvidia.com>

Adjust the way physical layer counters group is accessed to match the
generic method used for accessing other PPCNT counter groups.

Signed-off-by: Yael Chemla <ychemla@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
---
 .../ethernet/mellanox/mlx5/core/en_stats.c    | 25 +++++++++++++------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
index 77d34037b92b..0cf0c920532f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c
@@ -1227,6 +1227,13 @@ void mlx5e_stats_ts_get(struct mlx5e_priv *priv,
 	mutex_unlock(&priv->state_lock);
 }
 
+#define PPORT_PHY_LAYER_OFF(c) \
+	MLX5_BYTE_OFF(ppcnt_reg, \
+		      counter_set.phys_layer_cntrs.c)
+static const struct counter_desc pport_phy_layer_cntrs_stats_desc[] = {
+	{ "link_down_events_phy", PPORT_PHY_LAYER_OFF(link_down_events) }
+};
+
 #define PPORT_PHY_STATISTICAL_OFF(c) \
 	MLX5_BYTE_OFF(ppcnt_reg, \
 		      counter_set.phys_layer_statistical_cntrs.c##_high)
@@ -1243,6 +1250,8 @@ pport_phy_statistical_err_lanes_stats_desc[] = {
 	{ "rx_err_lane_3_phy", PPORT_PHY_STATISTICAL_OFF(phy_corrected_bits_lane3) },
 };
 
+#define NUM_PPORT_PHY_LAYER_COUNTERS \
+	ARRAY_SIZE(pport_phy_layer_cntrs_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_COUNTERS \
 	ARRAY_SIZE(pport_phy_statistical_stats_desc)
 #define NUM_PPORT_PHY_STATISTICAL_PER_LANE_COUNTERS \
@@ -1253,8 +1262,7 @@ static MLX5E_DECLARE_STATS_GRP_OP_NUM_STATS(phy)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int num_stats;
 
-	/* "1" for link_down_events special counter */
-	num_stats = 1;
+	num_stats = NUM_PPORT_PHY_LAYER_COUNTERS;
 
 	num_stats += MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group) ?
 		     NUM_PPORT_PHY_STATISTICAL_COUNTERS : 0;
@@ -1270,7 +1278,8 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STRS(phy)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int i;
 
-	ethtool_puts(data, "link_down_events_phy");
+	for (i = 0; i < NUM_PPORT_PHY_LAYER_COUNTERS; i++)
+		ethtool_puts(data, pport_phy_layer_cntrs_stats_desc[i].format);
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
@@ -1287,10 +1296,12 @@ static MLX5E_DECLARE_STATS_GRP_OP_FILL_STATS(phy)
 	struct mlx5_core_dev *mdev = priv->mdev;
 	int i;
 
-	/* link_down_events_phy has special handling since it is not stored in __be64 format */
-	mlx5e_ethtool_put_stat(
-		data, MLX5_GET(ppcnt_reg, priv->stats.pport.phy_counters,
-			       counter_set.phys_layer_cntrs.link_down_events));
+	for (i = 0; i < NUM_PPORT_PHY_LAYER_COUNTERS; i++)
+		mlx5e_ethtool_put_stat(
+				data,
+				MLX5E_READ_CTR32_BE(&priv->stats.pport
+					.phy_counters,
+					pport_phy_layer_cntrs_stats_desc, i));
 
 	if (MLX5_CAP_PCAM_FEATURE(mdev, ppcnt_statistical_group))
 		for (i = 0; i < NUM_PPORT_PHY_STATISTICAL_COUNTERS; i++)
-- 
2.31.1


