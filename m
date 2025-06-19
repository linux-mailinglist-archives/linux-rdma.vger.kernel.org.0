Return-Path: <linux-rdma+bounces-11462-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 055DEAE048C
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 13:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B44703B40B6
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Jun 2025 11:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C96E24E4DD;
	Thu, 19 Jun 2025 11:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ego14+3+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2064.outbound.protection.outlook.com [40.107.236.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5012C24DD04;
	Thu, 19 Jun 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750334173; cv=fail; b=tlYpg7db1W5+T28AUq535Zt6WsXTAhX+tJ+Epu9z+4yMF/iIiRmS/q1lq7qaEQ6V0k4waXOOLg4QQjo/+YA7ztsIMO4vMmw2EDT4mZUYlKGHmsp+VwkS1wscoIA7UGT35WNi9EjMKIDx2P4fgBVXeqUN+V88vveCQEed/oeSOys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750334173; c=relaxed/simple;
	bh=0fVp0x8l5ZMB7LYW2oY1c2qrt0X69ZiLWs5M70XAgoY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qic8XjBsR/T3UAKJxhg0YhQUFICbmo366dWI9caysz7LDtGFskULYd0OsFg6Dm6QXTTQmfsPe9RWKdpAI7YqwSas56ZAjej8PbH0Sv/claKC8MbC6aPxguufuuN1K249hKKjaiuhhIQPdx4qlwop8jAR8xmf0gMvpo1hwHNbmK0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ego14+3+; arc=fail smtp.client-ip=40.107.236.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p4WHeMGirun3j4W+2DiR+1a4vaqtO/iX8gdSmBMrPxsVBhoFVAun4gPa+UJptwCjE7+k81QzjHs9Iox+KIe7YPHMIaEjL4q9i3OwYgaqBODqpJNbhHVr6tjGf8wDplA5l7qYEAdFj0IHr8E549EYTyUUXBwbPYYDJFH3GmdNA03Ckd6aYttfzbQylTZhwB3Mgt7fRLiqiJN9LuyOA5RLw20PPHE0vH5EK9YC6wQp7496tIAGDY/0Q1QBRWNf4bXCTXEsm++z356m7vZXIcTr1btZ7Ecl4SgtxMXvfM8ZwhKLMskGl7PmtE4YWv7fX8kY147JNVqq+V5+2HvPngadhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/x7gZLPuykhniOZXSAx/itjpVsmZbMiaKAwN4erJ2hs=;
 b=wF6jFJ/Y10VNCjw22kJNA/Tjk/wuVOilOuhtD8OeeHs8cN9nz8kZQFMSL+MStwPK9fDSJZJAUa9y3wI3SwON7rSrnbXvvhfCiwLgz+cNUVd/2lvR5bMB7v38BeMJVmtib2FYBBVY5meS5AVhgGWCH9cijDIATcTDBD4l3SxPbKTZisK9WUZSGCNvDQ/NWfygXNG8hKi5gXYgj+orqjkZ+3AskeB/4rwK3nMZnXcKwM/YAK5YsG4hsuwLj18Dk+C9FQJsFrry87MuWA/N2dETtMGR9bPBLHJ18mWgbx1r3QpgJ/3LByKiSqK83Qy0GCqR+h+fWOWt46zYfvfmWnnM1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/x7gZLPuykhniOZXSAx/itjpVsmZbMiaKAwN4erJ2hs=;
 b=Ego14+3+TIa5DesNlWWRCZyfA3nzKLyDI4/KkKzNGsjaL545cgTqu0HDbMBDq4gVhBcOrT2+p970KTc60hQOK9pgpfuVSSVGVjSBi6OX1jKg4tMJvf6LE5CnkDt22kqNbEKgNJNmjmH84M0cheRgY0Xb8xZ4aOnrKj/r/n2oNTenqcSokoPRDz2jpge5tnDDum+tv2OAYn/VvJ0uzkl0uFJN/lgY1qrt7SBDl2wJKKeWMWVlHrN14R955ULdQpYtYVD/cyZgUt4pqW5zwVzPZpG4re9fbIUBOrgerncLFw7nH0Y7/yEKKt2alYwU+rTCWInk796xidJBVP8a1jir4A==
Received: from CH2PR10CA0008.namprd10.prod.outlook.com (2603:10b6:610:4c::18)
 by PH7PR12MB8108.namprd12.prod.outlook.com (2603:10b6:510:2bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Thu, 19 Jun
 2025 11:56:02 +0000
Received: from DS3PEPF0000C37D.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::3a) by CH2PR10CA0008.outlook.office365.com
 (2603:10b6:610:4c::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.32 via Frontend Transport; Thu,
 19 Jun 2025 11:56:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DS3PEPF0000C37D.mail.protection.outlook.com (10.167.23.7) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 11:56:01 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 04:55:55 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 19 Jun 2025 04:55:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 19 Jun 2025 04:55:51 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Jonathan Corbet
	<corbet@lwn.net>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Yevgeny
 Kliteynik" <kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net-next 6/8] net/mlx5: HWS, Track matcher sizes individually
Date: Thu, 19 Jun 2025 14:55:20 +0300
Message-ID: <20250619115522.68469-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250619115522.68469-1-mbloch@nvidia.com>
References: <20250619115522.68469-1-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37D:EE_|PH7PR12MB8108:EE_
X-MS-Office365-Filtering-Correlation-Id: 95f47cd7-eb50-466c-dec1-08ddaf28434f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WHUh4ELgGtMGRN/WYmaku+bxCWtJ1T/NhErDTCxlWWGldHzt4KVm5QBB3xGH?=
 =?us-ascii?Q?VQkC0WBQuwPSysPUNlLTKNH0Ds3btVQ7aQsLWMi0DjJPyAiPlLgofmCKuQM1?=
 =?us-ascii?Q?FrGb1uS5QSJgvPSc9H2niFc2NLEG6YmHDq8qnedgAxVE89KOzx7WQUeU8rHW?=
 =?us-ascii?Q?eE8z7eSUKhIG7oV76ZYdWtD6CfDZt/MAPH8/50pfTUOzlfOTxfKL2u2fvuhY?=
 =?us-ascii?Q?xunqvAkXyW6B/zc0jYhXefYD6qHzrPB6zWyXS3n00VX3UD6wFG7O7hTUDv1q?=
 =?us-ascii?Q?V89yLXA5gJXdSjvK+pz4MpkywisYVxvGQAAeZ2HJo3cDGVFFmTIEZTV5FBYB?=
 =?us-ascii?Q?DsZpojgRPewC0p3+Gd1IU3WrVg/+t4U90Bie4InhFOHABMaPfyIITeQVgcG6?=
 =?us-ascii?Q?H7oL+OtnVign5VZbWOFpxzjFstsmz1kQ/lnvFG1gQd82JZ7voYaoXxV/oOCm?=
 =?us-ascii?Q?CQYdSKoRh5vlX7ngc3fuz6aG/s8FKM7nfp2EreNXEkj6rzGzQPc0ZKgyIWAK?=
 =?us-ascii?Q?+TevtBWuVBxy6UJvDUONQx7C9zVph4sTg6YIrGMzXIZJ6TzeSrS2EMzyh51x?=
 =?us-ascii?Q?jl4PIoBIvfpLCEiSOi4F5QQLCdfZU1k/5E7mi0D2J8BhAdOWI7V3RNhO/z/7?=
 =?us-ascii?Q?LqQJGTYOrJFqlzXUKrcGOr6Q1cuk1DLukojbdti4qBGC6XLuy4s/qYOIZFOl?=
 =?us-ascii?Q?8mzuTp6qHkABJZ2R3tuqljFOWprtG3WDe51EESbhLf+wZuxDiV6dPu+qL3ab?=
 =?us-ascii?Q?mLbEyGYut3NMQelMtdkib+egkNsmhIdhsrJyxs4q16+aGn4/FqP6bZzJNpVc?=
 =?us-ascii?Q?CeDCFK1m/HFVHJhPc7nwa/+zyjg9q2pBCDUkNahdgQWSpI5LfqWxcXvKtJny?=
 =?us-ascii?Q?8JPWBCryv513f48b+kZB+GaKNQ0YEeCKt/TBbBpAYOjSXW2pdKxLFoKVEsP4?=
 =?us-ascii?Q?vMcNwY1HpQpf6sOr2DGoInY5t6r4Gf9hDN9e6ODiZ/7dK9c6ZL0XkA2tKxX3?=
 =?us-ascii?Q?inO7Y7WoCYEiAl/toJyLYOlIP8lsZFbhId3od4Lopn7891icCqazk+fqEAef?=
 =?us-ascii?Q?pSRLK2/Or7Zn8IxZq3bAXejIVvymajbdGjFMJh7I2/fzBptparqnOCXU4GDy?=
 =?us-ascii?Q?3ox0sgVVlR+l+JBFotjvFcq1q58q1gpyJnuB80WmnqsvbAFEAzgwrEgFPN6B?=
 =?us-ascii?Q?DUckhmazGIQLb5ciQ2+F9b6aECnJmDp0ftWf2js6ywoi0ajKsDgaPYd1Rwhn?=
 =?us-ascii?Q?m2BAcDnM6huC44hzeI6GVgKYx5gwmv8ogQSuX/HgJ4gg8KW+VH51r8jqDd0p?=
 =?us-ascii?Q?YjCjNOX1fN4DzafOOr6LVJnb7YxHAi1+IEOdi8vUGuX6J3J2PAlRyhxGvvp7?=
 =?us-ascii?Q?OY8+FTnxtzZ6xcskUt+ywli57Yh/kq529jzLEIYMWen9vmtqMYKIXNTbb/df?=
 =?us-ascii?Q?w4kBVPxYJBBwBjuipzUN0RXB45ykmuODsPTAHMHO52oM2FEZsqMuh9VbpnW5?=
 =?us-ascii?Q?PlfbGpMcwCSVXDX4TPLHSEldWtUQhqg8w47Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:56:01.8029
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95f47cd7-eb50-466c-dec1-08ddaf28434f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C37D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8108

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Track and grow matcher sizes individually for RX and TX RTCs. This
allows RX-only or TX-only use cases to effectively halve the device
resources they use.

For testing we used a simple module that inserts 1M RX-only rules and
measured the number of pages the device requests, and memory usage as
reported by `free -h`.

			Pages		Memory
Before this patch:	300k		1.5GiB
After this patch:	160k		900MiB

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/bwc.c     | 213 +++++++++++++-----
 .../mellanox/mlx5/core/steering/hws/bwc.h     |  14 +-
 2 files changed, 167 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
index 009641e6c874..0a7903cf75e8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.c
@@ -93,12 +93,11 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  priority,
-				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
-				  MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG,
+				  bwc_matcher->rx_size.size_log,
+				  bwc_matcher->tx_size.size_log,
 				  &attr);
 
 	bwc_matcher->priority = priority;
-	bwc_matcher->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
 
 	bwc_matcher->size_of_at_array = MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM;
 	bwc_matcher->at = kcalloc(bwc_matcher->size_of_at_array,
@@ -150,6 +149,20 @@ int mlx5hws_bwc_matcher_create_simple(struct mlx5hws_bwc_matcher *bwc_matcher,
 	return -EINVAL;
 }
 
+static void
+hws_bwc_matcher_init_size_rxtx(struct mlx5hws_bwc_matcher_size *size)
+{
+	size->size_log = MLX5HWS_BWC_MATCHER_INIT_SIZE_LOG;
+	atomic_set(&size->num_of_rules, 0);
+	atomic_set(&size->rehash_required, false);
+}
+
+static void hws_bwc_matcher_init_size(struct mlx5hws_bwc_matcher *bwc_matcher)
+{
+	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->rx_size);
+	hws_bwc_matcher_init_size_rxtx(&bwc_matcher->tx_size);
+}
+
 struct mlx5hws_bwc_matcher *
 mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 			   u32 priority,
@@ -170,8 +183,7 @@ mlx5hws_bwc_matcher_create(struct mlx5hws_table *table,
 	if (!bwc_matcher)
 		return NULL;
 
-	atomic_set(&bwc_matcher->num_of_rules, 0);
-	atomic_set(&bwc_matcher->rehash_required, false);
+	hws_bwc_matcher_init_size(bwc_matcher);
 
 	/* Check if the required match params can be all matched
 	 * in single STE, otherwise complex matcher is needed.
@@ -221,12 +233,13 @@ int mlx5hws_bwc_matcher_destroy_simple(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 int mlx5hws_bwc_matcher_destroy(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
-	u32 num_of_rules = atomic_read(&bwc_matcher->num_of_rules);
+	u32 rx_rules = atomic_read(&bwc_matcher->rx_size.num_of_rules);
+	u32 tx_rules = atomic_read(&bwc_matcher->tx_size.num_of_rules);
 
-	if (num_of_rules)
+	if (rx_rules || tx_rules)
 		mlx5hws_err(bwc_matcher->matcher->tbl->ctx,
-			    "BWC matcher destroy: matcher still has %d rules\n",
-			    num_of_rules);
+			    "BWC matcher destroy: matcher still has %u RX and %u TX rules\n",
+			    rx_rules, tx_rules);
 
 	if (bwc_matcher->complex)
 		mlx5hws_bwc_matcher_destroy_complex(bwc_matcher);
@@ -386,6 +399,16 @@ hws_bwc_rule_destroy_hws_sync(struct mlx5hws_bwc_rule *bwc_rule,
 	return 0;
 }
 
+static void hws_bwc_rule_cnt_dec(struct mlx5hws_bwc_rule *bwc_rule)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+
+	if (!bwc_rule->skip_rx)
+		atomic_dec(&bwc_matcher->rx_size.num_of_rules);
+	if (!bwc_rule->skip_tx)
+		atomic_dec(&bwc_matcher->tx_size.num_of_rules);
+}
+
 int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 {
 	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
@@ -402,7 +425,7 @@ int mlx5hws_bwc_rule_destroy_simple(struct mlx5hws_bwc_rule *bwc_rule)
 	mutex_lock(queue_lock);
 
 	ret = hws_bwc_rule_destroy_hws_sync(bwc_rule, &attr);
-	atomic_dec(&bwc_matcher->num_of_rules);
+	hws_bwc_rule_cnt_dec(bwc_rule);
 	hws_bwc_rule_list_remove(bwc_rule);
 
 	mutex_unlock(queue_lock);
@@ -489,25 +512,27 @@ hws_bwc_rule_update_sync(struct mlx5hws_bwc_rule *bwc_rule,
 }
 
 static bool
-hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher)
+hws_bwc_matcher_size_maxed_out(struct mlx5hws_bwc_matcher *bwc_matcher,
+			       struct mlx5hws_bwc_matcher_size *size)
 {
 	struct mlx5hws_cmd_query_caps *caps = bwc_matcher->matcher->tbl->ctx->caps;
 
 	/* check the match RTC size */
-	return (bwc_matcher->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
+	return (size->size_log + MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH +
 		MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP) >
 	       (caps->ste_alloc_log_max - 1);
 }
 
 static bool
 hws_bwc_matcher_rehash_size_needed(struct mlx5hws_bwc_matcher *bwc_matcher,
+				   struct mlx5hws_bwc_matcher_size *size,
 				   u32 num_of_rules)
 {
-	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher)))
+	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size)))
 		return false;
 
 	if (unlikely((num_of_rules * 100 / MLX5HWS_BWC_MATCHER_REHASH_PERCENT_TH) >=
-		     (1UL << bwc_matcher->size_log)))
+		     (1UL << size->size_log)))
 		return true;
 
 	return false;
@@ -564,20 +589,21 @@ hws_bwc_matcher_extend_at(struct mlx5hws_bwc_matcher *bwc_matcher,
 }
 
 static int
-hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher)
+hws_bwc_matcher_extend_size(struct mlx5hws_bwc_matcher *bwc_matcher,
+			    struct mlx5hws_bwc_matcher_size *size)
 {
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_cmd_query_caps *caps = ctx->caps;
 
-	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher))) {
+	if (unlikely(hws_bwc_matcher_size_maxed_out(bwc_matcher, size))) {
 		mlx5hws_err(ctx, "Can't resize matcher: depth exceeds limit %d\n",
 			    caps->rtc_log_depth_max);
 		return -ENOMEM;
 	}
 
-	bwc_matcher->size_log =
-		min(bwc_matcher->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
-		    caps->ste_alloc_log_max - MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
+	size->size_log = min(size->size_log + MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
+			     caps->ste_alloc_log_max -
+				     MLX5HWS_MATCHER_ASSURED_MAIN_TBL_DEPTH);
 
 	return 0;
 }
@@ -697,8 +723,8 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 
 	hws_bwc_matcher_init_attr(bwc_matcher,
 				  bwc_matcher->priority,
-				  bwc_matcher->size_log,
-				  bwc_matcher->size_log,
+				  bwc_matcher->rx_size.size_log,
+				  bwc_matcher->tx_size.size_log,
 				  &matcher_attr);
 
 	old_matcher = bwc_matcher->matcher;
@@ -736,21 +762,39 @@ static int hws_bwc_matcher_move(struct mlx5hws_bwc_matcher *bwc_matcher)
 static int
 hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 {
+	bool need_rx_rehash, need_tx_rehash;
 	int ret;
 
-	/* If the current matcher size is already at its max size, we can't
-	 * do the rehash. Skip it and try adding the rule again - perhaps
-	 * there was some change.
+	need_rx_rehash = atomic_read(&bwc_matcher->rx_size.rehash_required);
+	need_tx_rehash = atomic_read(&bwc_matcher->tx_size.rehash_required);
+
+	/* It is possible that another rule has already performed rehash.
+	 * Need to check again if we really need rehash.
 	 */
-	if (hws_bwc_matcher_size_maxed_out(bwc_matcher))
+	if (!need_rx_rehash && !need_tx_rehash)
 		return 0;
 
-	/* It is possible that other rule has already performed rehash.
-	 * Need to check again if we really need rehash.
+	/* If the current matcher RX/TX size is already at its max size,
+	 * it can't be rehashed.
 	 */
-	if (!atomic_read(&bwc_matcher->rehash_required) &&
-	    !hws_bwc_matcher_rehash_size_needed(bwc_matcher,
-						atomic_read(&bwc_matcher->num_of_rules)))
+	if (need_rx_rehash &&
+	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
+					   &bwc_matcher->rx_size)) {
+		atomic_set(&bwc_matcher->rx_size.rehash_required, false);
+		need_rx_rehash = false;
+	}
+	if (need_tx_rehash &&
+	    hws_bwc_matcher_size_maxed_out(bwc_matcher,
+					   &bwc_matcher->tx_size)) {
+		atomic_set(&bwc_matcher->tx_size.rehash_required, false);
+		need_tx_rehash = false;
+	}
+
+	/* If both RX and TX rehash flags are now off, it means that whatever
+	 * we wanted to rehash is now at its max size - no rehash can be done.
+	 * Return and try adding the rule again - perhaps there was some change.
+	 */
+	if (!need_rx_rehash && !need_tx_rehash)
 		return 0;
 
 	/* Now we're done all the checking - do the rehash:
@@ -759,12 +803,22 @@ hws_bwc_matcher_rehash_size(struct mlx5hws_bwc_matcher *bwc_matcher)
 	 *  - move all the rules to the new matcher
 	 *  - destroy the old matcher
 	 */
+	atomic_set(&bwc_matcher->rx_size.rehash_required, false);
+	atomic_set(&bwc_matcher->tx_size.rehash_required, false);
 
-	atomic_set(&bwc_matcher->rehash_required, false);
+	if (need_rx_rehash) {
+		ret = hws_bwc_matcher_extend_size(bwc_matcher,
+						  &bwc_matcher->rx_size);
+		if (ret)
+			return ret;
+	}
 
-	ret = hws_bwc_matcher_extend_size(bwc_matcher);
-	if (ret)
-		return ret;
+	if (need_tx_rehash) {
+		ret = hws_bwc_matcher_extend_size(bwc_matcher,
+						  &bwc_matcher->tx_size);
+		if (ret)
+			return ret;
+	}
 
 	return hws_bwc_matcher_move(bwc_matcher);
 }
@@ -816,6 +870,62 @@ static int hws_bwc_rule_get_at_idx(struct mlx5hws_bwc_rule *bwc_rule,
 	return at_idx;
 }
 
+static void hws_bwc_rule_cnt_inc_rxtx(struct mlx5hws_bwc_rule *bwc_rule,
+				      struct mlx5hws_bwc_matcher_size *size)
+{
+	u32 num_of_rules = atomic_inc_return(&size->num_of_rules);
+
+	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_rule->bwc_matcher,
+							size, num_of_rules)))
+		atomic_set(&size->rehash_required, true);
+}
+
+static void hws_bwc_rule_cnt_inc(struct mlx5hws_bwc_rule *bwc_rule)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+
+	if (!bwc_rule->skip_rx)
+		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->rx_size);
+	if (!bwc_rule->skip_tx)
+		hws_bwc_rule_cnt_inc_rxtx(bwc_rule, &bwc_matcher->tx_size);
+}
+
+static int hws_bwc_rule_cnt_inc_with_rehash(struct mlx5hws_bwc_rule *bwc_rule,
+					    u16 bwc_queue_idx)
+{
+	struct mlx5hws_bwc_matcher *bwc_matcher = bwc_rule->bwc_matcher;
+	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
+	struct mutex *queue_lock; /* Protect the queue */
+	int ret;
+
+	hws_bwc_rule_cnt_inc(bwc_rule);
+
+	if (!atomic_read(&bwc_matcher->rx_size.rehash_required) &&
+	    !atomic_read(&bwc_matcher->tx_size.rehash_required))
+		return 0;
+
+	queue_lock = hws_bwc_get_queue_lock(ctx, bwc_queue_idx);
+	mutex_unlock(queue_lock);
+
+	hws_bwc_lock_all_queues(ctx);
+	ret = hws_bwc_matcher_rehash_size(bwc_matcher);
+	hws_bwc_unlock_all_queues(ctx);
+
+	mutex_lock(queue_lock);
+
+	if (likely(!ret))
+		return 0;
+
+	/* Failed to rehash. Print a diagnostic and rollback the counters. */
+	mlx5hws_err(ctx,
+		    "BWC rule insertion: rehash to sizes [%d, %d] failed (%d)\n",
+		    bwc_matcher->rx_size.size_log,
+		    bwc_matcher->tx_size.size_log, ret);
+	hws_bwc_rule_cnt_dec(bwc_rule);
+
+	return ret;
+}
+
 int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 				   u32 *match_param,
 				   struct mlx5hws_rule_action rule_actions[],
@@ -826,7 +936,6 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	struct mlx5hws_context *ctx = bwc_matcher->matcher->tbl->ctx;
 	struct mlx5hws_rule_attr rule_attr;
 	struct mutex *queue_lock; /* Protect the queue */
-	u32 num_of_rules;
 	int ret = 0;
 	int at_idx;
 
@@ -844,26 +953,10 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 		return -EINVAL;
 	}
 
-	/* check if number of rules require rehash */
-	num_of_rules = atomic_inc_return(&bwc_matcher->num_of_rules);
-
-	if (unlikely(hws_bwc_matcher_rehash_size_needed(bwc_matcher, num_of_rules))) {
+	ret = hws_bwc_rule_cnt_inc_with_rehash(bwc_rule, bwc_queue_idx);
+	if (unlikely(ret)) {
 		mutex_unlock(queue_lock);
-
-		hws_bwc_lock_all_queues(ctx);
-		ret = hws_bwc_matcher_rehash_size(bwc_matcher);
-		hws_bwc_unlock_all_queues(ctx);
-
-		if (ret) {
-			mlx5hws_err(ctx, "BWC rule insertion: rehash size [%d -> %d] failed (%d)\n",
-				    bwc_matcher->size_log - MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP,
-				    bwc_matcher->size_log,
-				    ret);
-			atomic_dec(&bwc_matcher->num_of_rules);
-			return ret;
-		}
-
-		mutex_lock(queue_lock);
+		return ret;
 	}
 
 	ret = hws_bwc_rule_create_sync(bwc_rule,
@@ -881,8 +974,11 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	 * It could be because there was collision, or some other problem.
 	 * Try rehash by size and insert rule again - last chance.
 	 */
+	if (!bwc_rule->skip_rx)
+		atomic_set(&bwc_matcher->rx_size.rehash_required, true);
+	if (!bwc_rule->skip_tx)
+		atomic_set(&bwc_matcher->tx_size.rehash_required, true);
 
-	atomic_set(&bwc_matcher->rehash_required, true);
 	mutex_unlock(queue_lock);
 
 	hws_bwc_lock_all_queues(ctx);
@@ -891,7 +987,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 
 	if (ret) {
 		mlx5hws_err(ctx, "BWC rule insertion: rehash failed (%d)\n", ret);
-		atomic_dec(&bwc_matcher->num_of_rules);
+		hws_bwc_rule_cnt_dec(bwc_rule);
 		return ret;
 	}
 
@@ -907,7 +1003,7 @@ int mlx5hws_bwc_rule_create_simple(struct mlx5hws_bwc_rule *bwc_rule,
 	if (unlikely(ret)) {
 		mutex_unlock(queue_lock);
 		mlx5hws_err(ctx, "BWC rule insertion failed (%d)\n", ret);
-		atomic_dec(&bwc_matcher->num_of_rules);
+		hws_bwc_rule_cnt_dec(bwc_rule);
 		return ret;
 	}
 
@@ -937,6 +1033,9 @@ mlx5hws_bwc_rule_create(struct mlx5hws_bwc_matcher *bwc_matcher,
 	if (unlikely(!bwc_rule))
 		return NULL;
 
+	mlx5hws_rule_skip(bwc_matcher->matcher, flow_source,
+			  &bwc_rule->skip_rx, &bwc_rule->skip_tx);
+
 	bwc_queue_idx = hws_bwc_gen_queue_idx(ctx);
 
 	if (bwc_matcher->complex)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index d21fc247a510..1e9de6b9222c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -19,6 +19,13 @@
 #define MLX5HWS_BWC_POLLING_TIMEOUT 60
 
 struct mlx5hws_bwc_matcher_complex_data;
+
+struct mlx5hws_bwc_matcher_size {
+	u8 size_log;
+	atomic_t num_of_rules;
+	atomic_t rehash_required;
+};
+
 struct mlx5hws_bwc_matcher {
 	struct mlx5hws_matcher *matcher;
 	struct mlx5hws_match_template *mt;
@@ -27,10 +34,9 @@ struct mlx5hws_bwc_matcher {
 	struct mlx5hws_bwc_matcher *complex_first_bwc_matcher;
 	u8 num_of_at;
 	u8 size_of_at_array;
-	u8 size_log;
 	u32 priority;
-	atomic_t num_of_rules;
-	atomic_t rehash_required;
+	struct mlx5hws_bwc_matcher_size rx_size;
+	struct mlx5hws_bwc_matcher_size tx_size;
 	struct list_head *rules;
 };
 
@@ -40,6 +46,8 @@ struct mlx5hws_bwc_rule {
 	struct mlx5hws_bwc_rule *isolated_bwc_rule;
 	struct mlx5hws_bwc_complex_rule_hash_node *complex_hash_node;
 	u16 bwc_queue_idx;
+	bool skip_rx;
+	bool skip_tx;
 	struct list_head list_node;
 };
 
-- 
2.34.1


