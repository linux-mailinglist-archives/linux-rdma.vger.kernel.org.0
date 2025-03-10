Return-Path: <linux-rdma+bounces-8551-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 661B4A5A6AD
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 23:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F9D47A42C2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8E8202979;
	Mon, 10 Mar 2025 22:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="i9zpAQKp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E394F1E105E;
	Mon, 10 Mar 2025 22:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644190; cv=fail; b=JEMwNmYp5aIOKqkw1xc2/Y+cRQq4MIP1+F8ehadqsSa2K3ZYwpEN7k3Rn7OwzJlnhxs3CxzM7AbQbnksveoFyhO38pwm8mJT4/jCoI8jnSeZJhNNwLms5Gce3jJEy3krFi/+PuUPfEGKMApaXJ3fv1V+idVj/mXpccP89vwLF4o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644190; c=relaxed/simple;
	bh=K5LVgPzd6eQmQHskwmblvyB+oMlmNs3H47gl7q3ugCc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wh8hAhe1tv81nuDsMH0kt/SJXppynZ8Qg+ev6MhKWBIZCcVIJRRl3bxgycR/2TOpy4DFNtxHSyOwLUN7ggZsvUnVIYd6YJgvZchcd11K55qJCInvKw2JVUspsbDapGTCmFeAkqlT7foc8Li2sDDjyMeFRC8OWZkqzGKuPFhdejc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=i9zpAQKp; arc=fail smtp.client-ip=40.107.96.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCs4jgrGoznyApuRQhty6OBhMHKOaRzjkx1GEVEwhJD/g/WTSSbSKi2/a7FxgZSYhB+p/0SJ9471XdU7Aaf1h1GEjXZ9UYFKphIsuflnzSuXNCPmVPowFzBrYbA04rkWzpFlKwXeyFZ5PVLz1rmlgdYAg75OEUnntRadOtVGQRX10evxVyiEsg6ek5eFDjzEYqZoAj24w+Pndq35KimsoVeqavihfLZjtd3zQ2+zbTmXIQlCXHoD4AQxjkytdZpFNkToaQxCFjh9e+p4vquxWmB1AXiJTl/9qGErIc2Op5dwXVQtVkrLRhof2uZ7Jy52Vgj/ibu431sVVH3kac8xNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DtMBpzXZhNol+NGk6eCYKyconLZsMeGmJvOP1rFZ1cU=;
 b=qXKG1l9Qyt/hOPXj2gyzlcRhlSgaL4Wv6EXOEmv70IyaVtmgA2YIUN/QrtsA9iAUECxCUnEy53SbBTV6ud/qGE+FFue/kmgQW9vFKbp4JAAhNAPttsfBHG5OqSBfe6wmihvmq1EQ+5Xqf5Tchy9twxqxyZHPClZczkJhH5f2mEmaF/ulQ6AK60rDg2PzNXkuk0GkYkMd+0Mj3Kk670YNmZRzePHa27rQ4IaGSqLIcE3ML013t3NL2S89Y80yiesdbWtEBS8dMlTjNkDtMX/WyUUuBs7JTAlZhMkJnjA4Uqww6xKBclvBNZJRgaYUJ113ASOAqHm6jGhEW0izUAejYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DtMBpzXZhNol+NGk6eCYKyconLZsMeGmJvOP1rFZ1cU=;
 b=i9zpAQKptPdqo+URXmOaCbtKnpLbGRzFRDdERsrpdLPDFK2i4/G4RXcDO5ZDq3mvxsUxDWNeStARstq14VovGBfxLt1zHGPTP+4WBLRRn+DjeJrLzjvg+u+0+NoeO8vosbdQDosSygXLG+QFXk1YmcKEvlB4CQ8M/swhT7wzwtCVMUYqnsLdXxsSRlj+VJ/k4qwt6OrtqzZhgAI7C8zd8d1kwwUvQ0usJ8DR7NbkpmPtgNw8jsw7mbI5XLlXs2opM+D/qMpKQGTK4JoUq/KYDXF7nmI5S+f4i6Irv0Fi/MxkMsg4vxl1LXHXWz9r59XKphKUDvdPhlC0H1vU8yiS8A==
Received: from SA1PR02CA0003.namprd02.prod.outlook.com (2603:10b6:806:2cf::9)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 22:03:03 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:2cf:cafe::7c) by SA1PR02CA0003.outlook.office365.com
 (2603:10b6:806:2cf::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 22:03:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:03:02 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 15:02:56 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:02:56 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 15:02:53 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net 4/6] net/mlx5: Lag, Check shared fdb before creating MultiPort E-Switch
Date: Tue, 11 Mar 2025 00:01:42 +0200
Message-ID: <1741644104-97767-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: b7e83fc7-6465-46a8-f015-08dd601f5440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6gSXpu7oKf+jz/oN/+k/NU5fQpu6Y4ZGA0WOVtYyTInAUsis8hwB9hQUbnFT?=
 =?us-ascii?Q?pObaHN8/APW4LnrFduTr015vQsMs3+ixKLKK5mdI+k/Bz4uSEkZvSweuinKk?=
 =?us-ascii?Q?OKRfjanoP9CwPfnijpUjaZr6zWu/e+e7kp2RxflV+X41zGdWsVq0uv8v5T64?=
 =?us-ascii?Q?WwZfbeBSTgOH2yOIqtSixBrkZRiKlI5y1B/X/3KAS8UeTyh2HqK5NEsHGjUv?=
 =?us-ascii?Q?danmEx7G+UnrSsJbjlHT+lldVnFAaoqm6OLXmj5s6XIT338ITvi5iDdX1uVV?=
 =?us-ascii?Q?3iBvl05xAgauzikNLKerapQeCphBkIEUFHhPp5H0mpZlMiwpJtj9IrW9M509?=
 =?us-ascii?Q?/RfdAu1KftGcwoQ347mXsoN0cXWR0weSAWUDIoRr60hg1S5TerksguzO+hfW?=
 =?us-ascii?Q?500PEZjYeuc3R8Pm0nVBX1xFN6eIa9/1PFoBa7Sb1vEClulk47x+EpkqmDy3?=
 =?us-ascii?Q?oIWsVZk5PihHvTgglHcKvIIYQt7kbyEug+c7dXlfj7vyUv8EPsduO+Oppcyb?=
 =?us-ascii?Q?2flbzDcaHF5nRmAZ6O8rLLAtxJ+SnJHilsNNxQRBmgVlKykHtoCuGpb+zAcy?=
 =?us-ascii?Q?QYMkLuHXl2E8JfCUphS9LVzQ/eU6JcKUn0eMX5EYKNPMVvge+XZQrqEGCHZw?=
 =?us-ascii?Q?114sv4yq7op7lcJQm636akVD4Ry46FOBZCU6xXNSr059vidQoeDLq5lMkyVb?=
 =?us-ascii?Q?EUNTZoFavu7MFfnw2egXBEdoyyVzI6odt55V6Sna6Ohwokovb2WG8oXM0UFh?=
 =?us-ascii?Q?HA0vpSahT7t7sOqQ6Ak9gObMsaUP2voXMIfvB35jZEE+l01HZpY7hAFHWMd4?=
 =?us-ascii?Q?QZUWhQnCuQnmpID/YPhPM6HuZOJMJs17LMD9qrRw7wQ0/nk36ksn0xuz8L64?=
 =?us-ascii?Q?R7gkHdwh8UqG8GGONZSRsgsCDzoeOXG8cjbWsVvH5+dhOInOBlBl6IaE+OK1?=
 =?us-ascii?Q?Vq/UZIFMyzhEPFg065gDGpoFCRLKVOiPxUTiCqa7tXoSX0XogXTBc4014zW+?=
 =?us-ascii?Q?pP4XG77kxxCx1idxXS2BjGGfxSUOWZyGiDJArPS9j3ta0w/IC0KaOflDrSFU?=
 =?us-ascii?Q?EUhzo3d+gYcCNqII/cVishpKavnEHoBz+Gb6zW+1kvs8humDWYxYr4Ju8B2v?=
 =?us-ascii?Q?XN6UH0yWQIeQTAz9Qls35HC9nGzfOr4zQskJSgI67G7AwbP9MrDT3lefiwmc?=
 =?us-ascii?Q?Lzmt759Omvzgdsq/2fI+3tWARtd28dvFOblogzULg/AvQUa0jwK/r5/7tX7M?=
 =?us-ascii?Q?2Ib9R56HQ74/Z0aQ/vZyYRi/nmhxsV34/n2QQE5ioHcK3NSpyRSbHVg3pT5+?=
 =?us-ascii?Q?h3zOCozCHsr5oGAs218eZKOniGDI/nJ7W5FQZEko+x2APb1MWndLAOKjU/+K?=
 =?us-ascii?Q?OjX1j4188GPCKRTNawzOZY5k2LPkNuam3QwSFn6P8SkufI5yqhyYbt0hh/mY?=
 =?us-ascii?Q?XxqeiV2h7usp0E0XYFj3smfhFFZpOqg5y/NelpUlXaC7VeXXe83z40bB+8en?=
 =?us-ascii?Q?Sb76IQZFEoAzr30=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:03:02.9335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7e83fc7-6465-46a8-f015-08dd601f5440
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

From: Shay Drory <shayd@nvidia.com>

Currently, MultiPort E-Switch is requesting to create a LAG with shared
FDB without checking the LAG is supporting shared FDB.
Add the check.

Fixes: a32327a3a02c ("net/mlx5: Lag, Control MultiPort E-Switch single FDB mode")
Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h   | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 3 ++-
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
index cea5aa314f6c..ed2ba272946b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
@@ -951,7 +951,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
 				mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
 }
 
-static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
+bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
 {
 	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
 	struct mlx5_core_dev *dev;
@@ -1038,7 +1038,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
 	}
 
 	if (do_bond && !__mlx5_lag_is_active(ldev)) {
-		bool shared_fdb = mlx5_shared_fdb_supported(ldev);
+		bool shared_fdb = mlx5_lag_shared_fdb_supported(ldev);
 
 		roce_lag = mlx5_lag_is_roce_lag(ldev);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
index 01cf72366947..c2f256bb2bc2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
@@ -92,6 +92,7 @@ mlx5_lag_is_ready(struct mlx5_lag *ldev)
 	return test_bit(MLX5_LAG_FLAG_NDEVS_READY, &ldev->state_flags);
 }
 
+bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
 bool mlx5_lag_check_prereq(struct mlx5_lag *ldev);
 void mlx5_modify_lag(struct mlx5_lag *ldev,
 		     struct lag_tracker *tracker);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
index ffac0bd6c895..1770297a112e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
@@ -83,7 +83,8 @@ static int enable_mpesw(struct mlx5_lag *ldev)
 	if (mlx5_eswitch_mode(dev0) != MLX5_ESWITCH_OFFLOADS ||
 	    !MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table) ||
 	    !MLX5_CAP_GEN(dev0, create_lag_when_not_master_up) ||
-	    !mlx5_lag_check_prereq(ldev))
+	    !mlx5_lag_check_prereq(ldev) ||
+	    !mlx5_lag_shared_fdb_supported(ldev))
 		return -EOPNOTSUPP;
 
 	err = mlx5_mpesw_metadata_set(ldev);
-- 
2.31.1


