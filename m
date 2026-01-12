Return-Path: <linux-rdma+bounces-15449-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FC5D118AA
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 10:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC8863022838
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 09:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F01C34AB05;
	Mon, 12 Jan 2026 09:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="npaaYKEe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010055.outbound.protection.outlook.com [52.101.193.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5AE34A3B0;
	Mon, 12 Jan 2026 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768210868; cv=fail; b=BiAY0Kuty9DQWahfGJExePQ+6xqoPi8d7z3DfIGL+LRPg73nsYHyHIbomdVBFof10WhoP012ahyxyVS0RBntLkOimmo2Js8h7tttZ4pUs9+myTRx9iW0bBv1u79Cs5GWXkDCiao7uDL4HDqD9XhmvqnblEXuOEsWKAyUm8U+ABs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768210868; c=relaxed/simple;
	bh=9aIipBAdtyPtbQpagEBpyWd3DLCS18Xv17wmZg4x/MM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZzVOCscDQflFihk120zRjSThIJb0Wymr6Mr1z7vCa2/wHt3ej0ZNiHlmmDxfy5nEQI7zRjwjTMRMi6ciGnOSYr/D77PPojo3LMJoIvr/zWfjIWegGLb4WD/f/hYRz6YEg8Z4N/IQYJ4RahL35JCzs7Vl9vNbuMv4BY/tH2p3uI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=npaaYKEe; arc=fail smtp.client-ip=52.101.193.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mViMyWnwN4prLAJH5iDE57Wi3t3oKgYMLzzS5TdQjv8Fttjcoxq6TptDU89BGStwpJA+J4A4CL/+J02DXLNwRFSWgueb8N//xuS5lnH7rrfJf8YLAChEB3pIc1XuIUVv0QKkj+3DyKI/SMoPExL9XutYfXKxwPHUW16TB4hgTnk5dxOxAGElbfl69Q/2ChBHJaWXppZzXZsxMnpL6J0jMGNKSecDlxRGDAeV9/IyE2Pgd959IkRfoeTFCQem9Rt7+HcapkheF43fdjvdKgy/YxIesh2ifa5WrYncYP9SpLLoKE2xFy780QTzO8W6QOfraxTgN015mLPHXg3Pxq9fsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KGCt8mM+YwkUTVeCS1OtRC8AgjoybR+ed1L2JTGtSgE=;
 b=RLzQlgxaIQ7YuOcT+LQ1gl+Yp8f6VBxEu1OQygIRavydO5AzCT8rh1XZ5HlguHTqruh2V8o+L0ReXow/asG+ek/XbnqzzbOs7mG9xge8cQ0Z1PjdBIbEhXoxhOxnl3e0WiWBVYqkexENERk6RPRX1xRScOPX16YoLxshl0X0akIifqFGGqSZquSmHJLKBMo4sBw6tHGNue0B2VvwuhJDf+9XVa3/O2GAkQ+5YdScXdQAIr+fGuYS5eccPJzuvI+MS3qW/9s5ovZn/TADNIxhiO4o4tq6JaLqs0KADgBsbO/fdBFePUC0Yb8N80E2kgnbstOYdPccV54jUEZQpuBLDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KGCt8mM+YwkUTVeCS1OtRC8AgjoybR+ed1L2JTGtSgE=;
 b=npaaYKEeqiAt1uug3JxdnY4sjQSJaJw1tSR9l3Vn7vsT3jyMAQTjSfiDpDmtwdMRn4lCtEtnxiilvq/RfAA0GG4MiOXxX+GbNKbxW1BYQDCcq7vvZnJ8ClazlwIA+maffv8zh+5mJnzYmFJ37Sw4kvy5dk+HggtPTPq6rGTvCHaSpw5U34z0viYDf/mWpTQ+3556YDiSEuDfzzrPZBWnE5I6776sw+6ZPmLprttbZr+tDlIvrTEloeYmDDO8nLWshYH2rnIXfk2kA2FnDD8eeWNBpoTi3mog8dBan4LG0zgKcEN0fjLYXVMQ+6C+LZil0g1UmK3VlmAOg5AKbAmoSw==
Received: from BL1PR13CA0323.namprd13.prod.outlook.com (2603:10b6:208:2c1::28)
 by CYXPR12MB9318.namprd12.prod.outlook.com (2603:10b6:930:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.6; Mon, 12 Jan
 2026 09:41:02 +0000
Received: from BL02EPF00021F6F.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::d6) by BL1PR13CA0323.outlook.office365.com
 (2603:10b6:208:2c1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.4 via Frontend Transport; Mon,
 12 Jan 2026 09:40:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF00021F6F.mail.protection.outlook.com (10.167.249.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 09:41:01 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:43 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 01:40:43 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 12
 Jan 2026 01:40:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 1/3] net/mlx5: fs, factor out flow counter bulk init
Date: Mon, 12 Jan 2026 11:40:23 +0200
Message-ID: <1768210825-1598472-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
References: <1768210825-1598472-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6F:EE_|CYXPR12MB9318:EE_
X-MS-Office365-Filtering-Correlation-Id: 02860cbd-657f-409e-2720-08de51beb2b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MWLQFLqKsFnh7JfE/CyRohK7l8aVwhqPdDrbtiKz0NlQZYWXiGmozGUnF3nt?=
 =?us-ascii?Q?sTaijpVBYgX4MHO2aQguWczJPVIq7gDpcjIf4tmoMrlwXmervoIXc5KhEISw?=
 =?us-ascii?Q?6toi3n/DM/w8ZeUWwe8SYA+lI2CkOUY7Qaa/TKSruXQVLXiIcqJAm+FyP5Pc?=
 =?us-ascii?Q?gIEveOf5q/PtbhU+HjFeVvf6LzgPwpR2Ev9MVFdXmvUql3jYivwWf+uL76kb?=
 =?us-ascii?Q?be9tMZCRdDDlrtq68FjiHy2sf9rtrJMmYTV7eJDjNfSPNU6sX5d1+sVIsFh+?=
 =?us-ascii?Q?5sJeLMcBigsoa4bIJl00COYGZIzLZXNmFL//cJBm83cH7ctgQ/SQcV2TMwFz?=
 =?us-ascii?Q?+THZixNW8vs9RNBi0wweuNMKZSI3+GFKkPrS4k2ZwwDItdyx3OqzpY/kNer/?=
 =?us-ascii?Q?OvcwshjyH2ZPHZ1DaK3BTaoudc0D380iwJz39sRVGj68QK/2WRTAIL8BqnKr?=
 =?us-ascii?Q?qEgpAHB1asLjjqWDJVmUnK4hOwotApxMYF7yxU8F4HM4PIs920fNtqCz53zd?=
 =?us-ascii?Q?h6m8dftxiXa9F12kH1+uGBFuHD3As7JV8GsvUtgZk7IcEQZWBdq/1qYyF0IA?=
 =?us-ascii?Q?XoBDbJTbMrf5EK6ipzLcOTqhbyD20wdrgF8x8bCMfBSXwFppISsf4l1Bbiuv?=
 =?us-ascii?Q?aO42WOQ4amI5CWFUSk8Ov7Bmo9CLZbTKEqzP2OqX9ItyOP5H+d+BpoTwWWlw?=
 =?us-ascii?Q?bsk+SY9DJ+mGi/YSirgLexKvyOUdTNvpjm22ABZFATMFerVivoZXWtRwokAw?=
 =?us-ascii?Q?3KxWqYC2ZN0e+tyYGAGxYz8D2lCme5i6F5SP5aEXyJF3S4E4K0heHK+9eVU6?=
 =?us-ascii?Q?MiV8Hpkrh0n71kXFIN7j07s4YikqaycGJMToQkwZT6/RDMxLmj184UuRoiMP?=
 =?us-ascii?Q?n4zMO9Ss3l7HQ1tpLTvgti71GS8SuvyJlEOlpwHZ99/MV4YnM/zXeI+f+LNr?=
 =?us-ascii?Q?jMh43Iv9YYnF4K+v7Zi/bXIdeAPFMYlYlO5JDKD3pfsWWmaldi+Y5QshLnDv?=
 =?us-ascii?Q?mZzRyjcu7wO3ts5oNT/RMnV8abYBV5P8nritvxSBrDZLq/0dYy8FalBdM+hR?=
 =?us-ascii?Q?LaTSwMKbMWkyLWyCtxSLBxu7bHJpSrpiLO5+z6/KUhJGvlVjv0jtBjJW4grV?=
 =?us-ascii?Q?ERCC2C8396PJwPMfapNh/yDZkNyHfxhi2vh01liQ/ByCwJnUTxEzejsqaIeg?=
 =?us-ascii?Q?hpL2gfGZcehY13lmGGemapXOhKMcVFgEc1y+QDgHTW29wu0pml1vrj0P+eiU?=
 =?us-ascii?Q?jV0XTO/23XytsztHSzSqt2cpPlca3OqVXs1yTUSTomFGAStkEog2UbGGURrj?=
 =?us-ascii?Q?xVUkJvBrPOCb7HGIL7uGEzDfxVxIRy0l6/89wCZ03F5kJ9BbPXX3PHJIp1OU?=
 =?us-ascii?Q?rsyy9YM97JB2KXNgNhTv9k/WeDOQ9k4BNwPvE/15YuEqDu27ckYXgC+SK0lD?=
 =?us-ascii?Q?McVQDPZCkUJf0NWblheHsWqePTFN7hezg2QVXOWXwSxwa5jQpBpNCIBymPA4?=
 =?us-ascii?Q?9YHf/G5tOl3GsU4YqCzgRQMJwJSyGRE7cZZRKRWak8sHUDgef4ph1bG2ybaS?=
 =?us-ascii?Q?keYo3SAQutct21Vk+Q8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 09:41:01.5027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02860cbd-657f-409e-2720-08de51beb2b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00021F6F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9318

From: Mark Bloch <mbloch@nvidia.com>

Add mlx5_fc_bulk_init() to handle bulk initialization of flow counters.
This change does not alter any logic, but refactors the code to remove
duplicate initialization logic by centralizing it in a single function.

Signed-off-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fs_counters.c    | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index 83001eda3884..e14570a3d492 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -421,6 +421,13 @@ static void mlx5_fc_init(struct mlx5_fc *counter, struct mlx5_fc_bulk *bulk,
 	counter->id = id;
 }
 
+static void mlx5_fc_bulk_init(struct mlx5_fc_bulk *fc_bulk, u32 base_id)
+{
+	fc_bulk->base_id = base_id;
+	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
+	mutex_init(&fc_bulk->hws_data.lock);
+}
+
 u32 mlx5_fc_get_base_id(struct mlx5_fc *counter)
 {
 	return counter->bulk->base_id;
@@ -447,12 +454,11 @@ static struct mlx5_fs_bulk *mlx5_fc_bulk_create(struct mlx5_core_dev *dev,
 
 	if (mlx5_cmd_fc_bulk_alloc(dev, alloc_bitmask, &base_id))
 		goto fs_bulk_cleanup;
-	fc_bulk->base_id = base_id;
+
+	mlx5_fc_bulk_init(fc_bulk, base_id);
 	for (i = 0; i < bulk_len; i++)
 		mlx5_fc_init(&fc_bulk->fcs[i], fc_bulk, base_id + i);
 
-	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
-	mutex_init(&fc_bulk->hws_data.lock);
 	return &fc_bulk->fs_bulk;
 
 fs_bulk_cleanup:
@@ -560,10 +566,8 @@ mlx5_fc_local_create(u32 counter_id, u32 offset, u32 bulk_size)
 
 	counter->type = MLX5_FC_TYPE_LOCAL;
 	counter->id = counter_id;
-	fc_bulk->base_id = counter_id - offset;
 	fc_bulk->fs_bulk.bulk_len = bulk_size;
-	refcount_set(&fc_bulk->hws_data.hws_action_refcount, 0);
-	mutex_init(&fc_bulk->hws_data.lock);
+	mlx5_fc_bulk_init(fc_bulk, counter_id - offset);
 	counter->bulk = fc_bulk;
 	refcount_set(&counter->fc_local_refcount, 1);
 	return counter;
-- 
2.31.1


