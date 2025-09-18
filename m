Return-Path: <linux-rdma+bounces-13469-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DFBB834B2
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:20:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53163468008
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 07:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5422E974E;
	Thu, 18 Sep 2025 07:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TXzQM/Jg"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011069.outbound.protection.outlook.com [40.93.194.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED6E2EACF9;
	Thu, 18 Sep 2025 07:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180018; cv=fail; b=VPBxumJ5te0tvftSuB5dlYtT2WDBjY4D5BfBRnizzouUAsFPkDzC+x8L678SLZ5cxD41J5RWfIwul0Xi9jQ8RkBFYtGVqZhVBBvy+FVBQtNMXGvBWlju3L70pT4Id7BLR8XcIzGmMvZM4VtOamfJFBwum7gd8MAZ3kiOfukUaKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180018; c=relaxed/simple;
	bh=al+Q5667CS/6cdkR8ATpTRtQhim3nr42l2ON7dS87pA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGd1riynUYdp52Cq2qKIXl6A43r0zadHWCHKnrHecYriycQ7fHyQdMur46RVdtbsakngs9t8X8xbPUumt8MGxHkpU2aKOV/vun77pdVRCW0O6sOfoGOChi+6dgDh2+OXltMTTry26zh9im5Lo0xWn+zzJmG0+3R1S4GaF9hPxRE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TXzQM/Jg; arc=fail smtp.client-ip=40.93.194.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xCLNjLuHwLlqCMB4mfXUK+kmironUEvIC1lmXShmUlV9TJDTDi057GXYG/zRLW+6Cp2qq0hILg87Y+I1cNWVQTopSfRGPkLX0ugOxe86BoqeUfn0254wkzWAH5mhCC4aFsrgCPZ216KDJN/09vU262Sj/1wl3eFhObWD0+Uzh2ctIQUdDofcA/plZ/XJE2RYgx9HES+Kr36I/mP50mSiwfXl2I+9bQfoE7NBb/e9Z66tknV10RGPU4SAJ2QJ7SjQ6aHmHAsr57KW3B1/Np2s2em66U7UhXhIls9/yJAEIzQGJ5+W4/JnG8f4/ZJPlVu+b1zqO2hu7UkegWtdw7P+6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gs5ST19C9IIbWxwWJWrtr8Sf7RF+VFBnizWPCQHe9PE=;
 b=sojnVsA4eXNevIhhlf925oZGWrlqRDWuhgOdstQYsXfcCnxic/s2DicK9Sak0tjgDYCCIiocT/T5lM+ZmQ94PgJu0UM8zBPOEp8Hb66Fgr485oomNdZc5qcAOFD4fQxxLOVLTpg6OnCm2IN20ulFj4Q4e5to1WIJhG5bEH9ap+8JaU35QvypjPEo7uFRu6mKG8ZWN+dOZuHkROUJwAlUTulqB4pbBUvDlyXETVs7l3u8DFgRIRrh6B4fRlxok10F7oHk9sA54Ud24aS0HrkOlm1EkwmSE67NJNAzcgdb6Gf+Vlah221yVfA7mXndVTw3eIKa+r3k3PYmLZ0IJHrWPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gs5ST19C9IIbWxwWJWrtr8Sf7RF+VFBnizWPCQHe9PE=;
 b=TXzQM/JgmqzEGuqwjMOJofhLFfMbHazSU0FgIaMX/pNZk284f5IGtsXqq8akWE9AROFYjGCIs7vWrqfqjK4ukoQTlT3pWnWyrPPEz24V/luqLu2aFiITAhp+MzAT98KxGGUxA/jZuTU/r3UI8aZd11UOADC/Op+tqOPKlRTJFWRKGIY45vy3hlBaxbAevBMOJe0qnpRJ2PwyLkEwwjwpDha0rHe7h+tl/b85LkMFdLPpLx+FwCJQ5aUI2KdBF3RMlRmsdD2kkSLJL3cpHphjwN2FKwJSzex6n+eL+nerqE4aJgb39SUPqd0adltJ0q4Y7vdcCc0OkAD9eD8WX+U51w==
Received: from MN2PR03CA0001.namprd03.prod.outlook.com (2603:10b6:208:23a::6)
 by MW4PR12MB6924.namprd12.prod.outlook.com (2603:10b6:303:207::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Thu, 18 Sep
 2025 07:20:10 +0000
Received: from BN2PEPF000044AB.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::89) by MN2PR03CA0001.outlook.office365.com
 (2603:10b6:208:23a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 07:20:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044AB.mail.protection.outlook.com (10.167.243.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:20:09 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:19:54 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:19:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 00:19:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	Paul Moore <paul@paul-moore.com>
Subject: [PATCH net-next 2/4] net/mlx5e: Recirculate decrypted packets into TTC table
Date: Thu, 18 Sep 2025 10:19:21 +0300
Message-ID: <1758179963-649455-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758179963-649455-1-git-send-email-tariqt@nvidia.com>
References: <1758179963-649455-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AB:EE_|MW4PR12MB6924:EE_
X-MS-Office365-Filtering-Correlation-Id: e67ff6d4-16fc-419d-dda1-08ddf683cd0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76jfpKbaIjmosijRgaPXL1gtORtNW4mBmhjozTN3/E222bjh0cvTwhAhZhV8?=
 =?us-ascii?Q?OMMuaf+kzi8mBFjgMkEdzU96Ijcpd6XytZzZaeYFfCuy0JI2ifsH1qm/SNEl?=
 =?us-ascii?Q?kkyqkZkxs6yvKFv1DlW73+RqOwNYSUNBZPtw3TSTyN771ovyFx/NheAoeSxa?=
 =?us-ascii?Q?IjjYyP8Jfo0XeZGLISzos9ySGJmEqPRdCIYKvoQL2a/W010VXoCCFLXntgSd?=
 =?us-ascii?Q?O5vA8qx8S+itoxv3JX/4BJjCUJDbmpLh4zavnXl4yraMkpatIt2J+Qzb8rPJ?=
 =?us-ascii?Q?005FAPce8TzvL1Nz1jBsGz2rSWroM+7TM6IKo4Ldyz7OmAz/PWYClJ23tfqi?=
 =?us-ascii?Q?UCO1DJr84FQnHbJYden+oE0RytczPh8ve05H1HfjjCqBQhIsZu/PnK27Q6Tb?=
 =?us-ascii?Q?2lVuZp1A651iNowF+RQDtQT0s+IHfN9R7XWS/7RKS7DV4awfILU5Q7k0Dy7b?=
 =?us-ascii?Q?G/GY+L6n4Znj73itR29LZQSrvDwdtpg1/lmabalG3n36DcFO/vHwY3BANxIV?=
 =?us-ascii?Q?amD32LZLPbPikHnpUOhvZA1WNYujCXxOtrxxKjVGCiS7US1eRykGqJdDqtnO?=
 =?us-ascii?Q?Vwx0o0I3QzNCtwYQ2gl6q97qRAi6EVknnU46ulEgnA+qYG9AO/iryGjiLRwo?=
 =?us-ascii?Q?2VESD7Zj+FMxoI3ZyzOzNTEvEkBngodt+F+YjkgqGX0oi96eh0njQH6SZVDB?=
 =?us-ascii?Q?SU/Kz8JTjCeQRVCLhDSKfpP2nGUUGVCYCXadASmAiRZmqhil0ad5P5u2wEOE?=
 =?us-ascii?Q?QSWif5TOnpDTtI1F2T5ZUkN0eeeDRJex34NOjsmwZnCeBDaSNDeXkpRAsjtm?=
 =?us-ascii?Q?4dGtIfLPIwNTrkUUOuDj0AJlX06uxxruF4uaiEuN2dr85gfZo5vbR6TAGj6e?=
 =?us-ascii?Q?Bal52/F3Yc8ZJeAgFNZdkKCyPpx9Z6WxlB677GxNEGZXC8uW6JW/REVRN4a1?=
 =?us-ascii?Q?uojUpkuS5KqfuS7L6fOPmYAE605n6i6brENgqcAB7lq1Bl56Lzr90lLZm0Xi?=
 =?us-ascii?Q?XccTfcOVKY8hucRT9drLm68JiilVcPKhHTy9IMIztKECKD6psfQDkwfNhihZ?=
 =?us-ascii?Q?bmjl5OYNelJZOZO3FM8eWHz4kXDi4LSA3SEx/lNcaB4HqShgqvBKJ2i0csBS?=
 =?us-ascii?Q?ZgwRq99VDtiywzMhOrDZJfG9rmLD2kF7PbfkNJO2eSeYORiUrsCZTRH7IhdT?=
 =?us-ascii?Q?6gJY4fPgoloouFitXpjTdn8ToBBgNTIqC5xoMnQpyUp2PrqmfZB5wBhmfwoc?=
 =?us-ascii?Q?ZLjNtBdF8QCDXColED+M825gkSp8rpfBYGaVuzYVmisoSakGr3vYM/X6WXfi?=
 =?us-ascii?Q?lpJ/+uImHksCm8+D5wCJ/BJx4Q79BrRRrUuawICmm66gQa+ka6QxO/vD//5p?=
 =?us-ascii?Q?s0zHAUDW9sEUv6kUp2X08l0a1RagT8t3NhClZPtxeHx6Ea49NNklRrXoPtAb?=
 =?us-ascii?Q?8N53c3l6bli1WEyMr7IHiRmt/h5iyPoxaJUtp3W9W7zmkjn+Jk/ySc5hH//c?=
 =?us-ascii?Q?iwoC+w9WPO/rRtnPI2oAXAx2UArKWbLzU0Ua?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:20:09.5893
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e67ff6d4-16fc-419d-dda1-08ddf683cd0c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6924

From: Jianbo Liu <jianbol@nvidia.com>

In the commit 5e466345291a ("net/mlx5e: IPsec: Add IPsec steering in
local NIC RX"), the decrypted packets are handled in RX error flow
table. There is only one rule in the table, which forwards packets to
the default ESP TIR.

This patch updates the design to allow RSS after decryption. For ESP
traffic, SPI and IP addresses are the fields selected for RSS hash,
and it's common that only one SPI is configured in RX direction, so
RSS can't work properly as all the packets are hashed to one key in
this case. To take advantage of RSS and improve performance, the
decrypted packets need to be forwarded back to TTC table, where RSS
can work based on the decrypted packet types.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 24 +++++++++++++++----
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    |  4 ++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index 98b6a3a623f9..a06929852296 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -585,6 +585,20 @@ static int ipsec_miss_create(struct mlx5_core_dev *mdev,
 	return err;
 }
 
+static struct mlx5_flow_destination
+ipsec_rx_decrypted_pkt_def_dest(struct mlx5_ttc_table *ttc, u32 family)
+{
+	struct mlx5_flow_destination dest;
+
+	if (!mlx5_ttc_has_esp_flow_group(ttc))
+		return mlx5_ttc_get_default_dest(ttc, family2tt(family));
+
+	dest.ft = mlx5_get_ttc_flow_table(ttc);
+	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
+
+	return dest;
+}
+
 static void ipsec_rx_update_default_dest(struct mlx5e_ipsec_rx *rx,
 					 struct mlx5_flow_destination *old_dest,
 					 struct mlx5_flow_destination *new_dest)
@@ -598,10 +612,10 @@ static void handle_ipsec_rx_bringup(struct mlx5e_ipsec *ipsec, u32 family)
 {
 	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, XFRM_DEV_OFFLOAD_PACKET);
 	struct mlx5_flow_namespace *ns = mlx5e_fs_get_ns(ipsec->fs, false);
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
 	struct mlx5_flow_destination old_dest, new_dest;
 
-	old_dest = mlx5_ttc_get_default_dest(mlx5e_fs_get_ttc(ipsec->fs, false),
-					     family2tt(family));
+	old_dest = ipsec_rx_decrypted_pkt_def_dest(ttc, family);
 
 	mlx5_ipsec_fs_roce_rx_create(ipsec->mdev, ipsec->roce, ns, &old_dest, family,
 				     MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL, MLX5E_NIC_PRIO);
@@ -614,12 +628,12 @@ static void handle_ipsec_rx_bringup(struct mlx5e_ipsec *ipsec, u32 family)
 static void handle_ipsec_rx_cleanup(struct mlx5e_ipsec *ipsec, u32 family)
 {
 	struct mlx5e_ipsec_rx *rx = ipsec_rx(ipsec, family, XFRM_DEV_OFFLOAD_PACKET);
+	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
 	struct mlx5_flow_destination old_dest, new_dest;
 
 	old_dest.ft = mlx5_ipsec_fs_roce_ft_get(ipsec->roce, family);
 	old_dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
-	new_dest = mlx5_ttc_get_default_dest(mlx5e_fs_get_ttc(ipsec->fs, false),
-					     family2tt(family));
+	new_dest = ipsec_rx_decrypted_pkt_def_dest(ttc, family);
 	ipsec_rx_update_default_dest(rx, &old_dest, &new_dest);
 
 	mlx5_ipsec_fs_roce_rx_destroy(ipsec->roce, family, ipsec->mdev);
@@ -763,7 +777,7 @@ static int ipsec_rx_status_pass_dest_get(struct mlx5e_ipsec *ipsec,
 	if (rx == ipsec->rx_esw)
 		return mlx5_esw_ipsec_rx_status_pass_dest_get(ipsec, dest);
 
-	*dest = mlx5_ttc_get_default_dest(attr->ttc, family2tt(attr->family));
+	*dest = ipsec_rx_decrypted_pkt_def_dest(attr->ttc, attr->family);
 	err = mlx5_ipsec_fs_roce_rx_create(ipsec->mdev, ipsec->roce, attr->ns, dest,
 					   attr->family, MLX5E_ACCEL_FS_ESP_FT_ROCE_LEVEL,
 					   attr->prio);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
index b7d4b1a2baf2..d524f0220513 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/ipsec_fs_roce.c
@@ -164,6 +164,8 @@ ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
 	roce->rule = rule;
 
 	memset(spec, 0, sizeof(*spec));
+	if (default_dst->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE)
+		flow_act.flags |= FLOW_ACT_IGNORE_FLOW_LEVEL;
 	rule = mlx5_add_flow_rules(roce->ft, spec, &flow_act, default_dst, 1);
 	if (IS_ERR(rule)) {
 		err = PTR_ERR(rule);
@@ -178,6 +180,8 @@ ipsec_fs_roce_rx_rule_setup(struct mlx5_core_dev *mdev,
 		goto out;
 
 	flow_act.action = MLX5_FLOW_CONTEXT_ACTION_FWD_DEST;
+	if (default_dst->type == MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE)
+		flow_act.flags &= ~FLOW_ACT_IGNORE_FLOW_LEVEL;
 	dst.type = MLX5_FLOW_DESTINATION_TYPE_TABLE_TYPE;
 	dst.ft = roce->ft_rdma;
 	rule = mlx5_add_flow_rules(roce->nic_master_ft, NULL, &flow_act, &dst,
-- 
2.31.1


