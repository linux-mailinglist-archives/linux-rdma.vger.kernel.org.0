Return-Path: <linux-rdma+bounces-13995-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFD6BFF61F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 800A63A8F1F
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FFD2C0F81;
	Thu, 23 Oct 2025 06:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iF4ip+ZZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E7A2566F2;
	Thu, 23 Oct 2025 06:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201917; cv=fail; b=R6Kx4CypDJONBDLYpV0uLxX7p2WAEBpedCSOFYD9lB87aiLsb7v9T/U0UzK9uSeHfe/cW57lcQbMacMa9M7oOl3mXRPhDyZ0tH6Yo3VScF6JX09NgK6iT90155ZeUWgps9ZuPsTu0zuA2T4vWYBnw/lUZIxgcWAQFyUqhBswJ7A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201917; c=relaxed/simple;
	bh=84j4jKoucvT2eBwsEeUktBvBkp876TXh8T1y17szh+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tG7tmr3Ko7ivrMlAe4Kc9SNbwMmMb+2U+3Zhq22Tpkln3pSq5TrU8hoQVxy7YMmzWU2rOfjHxmoBsmY1XTVB96tqoVvWwtQGrUpZNskiyXAC8I820GGK/bF+gImw1k+bBtjK+S4nBUwpNQI4L48libaB5WhQz1bBdTqx/u4A9u0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iF4ip+ZZ; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mcNqj81tpHheWUhw241aQsTwMqzyxagO+eD6ML+02dX8lqza3y/paTwIa0ITweOlSyxWPQWbN7Exvh8oRlivIYi2uGYg5HO5lxZxwkBRQQbAVyPAZZpNGdCvCPDPiG5jdvYTf8vihAkv3ReOuewmCVrkYrW9kS55MLj648aC2UWb1Qed2we5NqE90Ejms2r+TW/M0xkhBSEn4lwTHwzNqDlqVNubw8NV2U2U97565wHEBPTZZUt9zV9oJGbD+f19e0RgGpLBi1l25PN+2zVD1A+lJZGODeiZmz9SSifSu7b5cenPrbOMkwVMNC1PwEfR+YZbNbko4ylZxbTGAUJBhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c/XkdFr6A4lCuA/eaRiHXQZvJHpx5yAoGDYcBtQbMpw=;
 b=XtfmJEz8Z7eHlYjDU40O0ehDLH+8yVUKaRr+e4pXutxpwLOCk3b3+HEqJB9QfjjBYJqokYJ9DlYeK07ehUTt4MdRecyK/xu1ede/f9SiM6ebA9RDaorJAN2QFsJsstDHlXrzE3m4T7riiNPCZwr9AyDCY8twTjPtTZaaKqGJ+nhFCPrOBbcqN4VLLUFhHgIIup6d1svdS3ISLvzizxPHZtm1JKTOqh4MhJC3n/Mc8W1ysM4xIx+IJB/Y/fUpTBZaw8TlKxsyOnqeknhTl2bm4UQybOn3khmpXuBF3Gqye7g2lJia+978wEdstX2X6oM8HIpyt5/f+OLXUQzJqVo7Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c/XkdFr6A4lCuA/eaRiHXQZvJHpx5yAoGDYcBtQbMpw=;
 b=iF4ip+ZZQ4ipjEMHGNatwdefT49TFXEefgpg81vDFu4XpQYbvQ/oZ954oKpSqEBf0SPaHOegQK0skabR9IDqSvwZpFqYsUGpG9IcSazdxbL3XZWo/QIqbYpytcyaZxS2YAPO3thKU1S/QC76kP9/wiGG6mVirqCa/oG+hlZL6vdvP6+0+wVjxzgiT6gPqx9Tw22V1J+i52H5XkGdypWejc2/JRZeI718R/jE8ptl0/aKBI5LDSFyvRkz1bu7wz9zZH/HLhDjxvkRMScUfZCLfrj9nORetEGIJA/ZajLc9WzzJntvspviTAqwudxdnO+eGC73KJODUC1W1WqQGXsv+w==
Received: from CH0PR04CA0029.namprd04.prod.outlook.com (2603:10b6:610:76::34)
 by CYYPR12MB8701.namprd12.prod.outlook.com (2603:10b6:930:bf::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:45:11 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:76:cafe::c) by CH0PR04CA0029.outlook.office365.com
 (2603:10b6:610:76::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.12 via Frontend Transport; Thu,
 23 Oct 2025 06:45:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:10 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 23:44:58 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:44:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:44:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/7] net/mlx5e: Use TIR API in mlx5e_modify_tirs_lb()
Date: Thu, 23 Oct 2025 09:43:35 +0300
Message-ID: <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|CYYPR12MB8701:EE_
X-MS-Office365-Filtering-Correlation-Id: fce1a999-465b-4df3-6865-08de11ffb688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4znl1lKlsu7PA7yeRNhrF5f3ZN6bfYW3XWU9lXbqYr63xRE0whQVYXuJCkDu?=
 =?us-ascii?Q?8c2wmKBGYQKn5mS+EaHuo7Apyfl9/zJdTGlR48ySEpogzAqXLhFoOFBL6KWI?=
 =?us-ascii?Q?TdiMtl614XH/zxKDWk2ig9v+iGyAg8th3avEstKq4ggoRZOGQhaEbiQ2F5U2?=
 =?us-ascii?Q?nrNauVH0Di0MIaq4WICUZzg89xGBOF1o3Ql9AQbcGNkghaSsF63+8b/CgKWK?=
 =?us-ascii?Q?4w0c78RzmN6107n2ihMYgY5kmpnzHYrZQ7j5jvF/+084tfaSgnOvyhROLDMp?=
 =?us-ascii?Q?oLY4/vr6u1mSB6JDFfIRtJYNfo215SjYR+YpBJL058cvB3eC33txapQz3abY?=
 =?us-ascii?Q?rCRj5xUBThX+VMlGq866HDl3+RfbGmu09NFv1Sif3RcHGO4GQr7QBbRo9beN?=
 =?us-ascii?Q?H5Nhpw/2MH4+y8DuEoGE+fwQtEAgMHttW/hIWWSGuE210Nd0LEuUMmcgFIg5?=
 =?us-ascii?Q?xLiZJ4AeBqmbxTKhE/Lk/RTnOv/bG3SFcPhiSDb0f1NjVxwQw7Tl1wEGsqg7?=
 =?us-ascii?Q?e6w4NF7GXI5KNzxhqflAmkg3sdB5WEiompTrIAA/8R97EawGRswRTDpN1v7w?=
 =?us-ascii?Q?xVDDJHV6OTsVAKPrif9SjLOB6ljhmwxZ4kbT6JQRD4qQCjktfa/rQWsnqFma?=
 =?us-ascii?Q?H6DjaBomOq78SOeKEiTKrCQ5Gx8O4+j+57SCDZmtCpAEr+73HyawVQCISHw4?=
 =?us-ascii?Q?Vnv0enYAhR/bofkFuMmSIyPGAMpQbNlYNyyFwPCAGsUV+mSgBIs1MJ3FhjzH?=
 =?us-ascii?Q?v/Hs2Ll/M7lRB6nHdfD3i0f8EuYjh2WOkY6opAb5SR4N1WtnJN0dQPwwwak0?=
 =?us-ascii?Q?zR3dP9o1Zvd2Hnsw35K+subMSXOt/Ck0SfYsDYHSHb6vhbrjfTsP1hkCNLr5?=
 =?us-ascii?Q?bqE+ZEmJ6TJOrdtcVV8Eqz6Htb2FOsUlG/I2rpAwuuvDQSy67dS3QbctlCTo?=
 =?us-ascii?Q?hVVr+c93H8TxJPa2U/5tdie5Mo/YrmH1ugZn4asbZn3k218m/McJraihMtlD?=
 =?us-ascii?Q?WdoHKN6OeHMQzr7QJVM0gh7+tZMZ5komYmTq+FXEOzz5kNRpELWcKB2E8xXD?=
 =?us-ascii?Q?wBEeiUhQ7A7YxDyfqoz+k5En5+ZufQOctDmx6NSbLy1pDIHifhCXzxecmzcq?=
 =?us-ascii?Q?7txZu7FmUnydRj7cBgsF1KCKjCDKRdcson4CWkSD6FqI6YcB9R1WQZ5c1r5n?=
 =?us-ascii?Q?EyAxMP0uBsELuOWiDW0wsSjD14KFyGh670VDBWsi1trIzTGBPMspyvr02sh1?=
 =?us-ascii?Q?QfgjfvnEU78Ukl6/2Y3PmUcC2BUriV/DXnykVZBl9xYCbuqp2klDs2EKwlCF?=
 =?us-ascii?Q?9fW1VcEe3a1OIpFJhO9Hd1qcXOVxk/w7a21zYZ4G3nU6GOT/1/j4gTv/+CO7?=
 =?us-ascii?Q?HYlKpUUxk5s8xFoC1t4VsNOH9bCXmN8eWMun3jhjwhxTVVebjEseFpDybuYp?=
 =?us-ascii?Q?uAZdTLXDhJgLEgRM0EA9jEJCXEHgqE2YCuVUcbb50nek0Ef85yoZ8PCqRdbL?=
 =?us-ascii?Q?qeqJqige/jLslB9CScxXMXcSODA8x4QtNA0TGFHqlo5Pa1wSU8EiXEZsncI0?=
 =?us-ascii?Q?w1jt64Xw0Rgga6BiBus=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:10.8418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fce1a999-465b-4df3-6865-08de11ffb688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8701

Extend the TIR API and use it in mlx5e_modify_tirs_lb() instead of the
explicit modify_tir code.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/tir.c  | 29 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en/tir.h  |  3 ++
 .../ethernet/mellanox/mlx5/core/en_common.c   | 29 +++++--------------
 3 files changed, 37 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
index 19499072f67f..0b55e77f19c8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.c
@@ -146,6 +146,31 @@ void mlx5e_tir_builder_build_direct(struct mlx5e_tir_builder *builder)
 	MLX5_SET(tirc, tirc, rx_hash_fn, MLX5_RX_HASH_FN_INVERTED_XOR8);
 }
 
+static void mlx5e_tir_context_self_lb_block(void *tirc, bool enable_uc_lb,
+					    bool enable_mc_lb)
+{
+	u8 lb_flags = 0;
+
+	if (enable_uc_lb)
+		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
+	if (enable_mc_lb)
+		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
+
+	MLX5_SET(tirc, tirc, self_lb_block, lb_flags);
+}
+
+void mlx5e_tir_builder_build_self_lb_block(struct mlx5e_tir_builder *builder,
+					   bool enable_uc_lb,
+					   bool enable_mc_lb)
+{
+	void *tirc = mlx5e_tir_builder_get_tirc(builder);
+
+	if (builder->modify)
+		MLX5_SET(modify_tir_in, builder->in, bitmask.self_lb_en, 1);
+
+	mlx5e_tir_context_self_lb_block(tirc, enable_uc_lb, enable_mc_lb);
+}
+
 void mlx5e_tir_builder_build_tls(struct mlx5e_tir_builder *builder)
 {
 	void *tirc = mlx5e_tir_builder_get_tirc(builder);
@@ -153,9 +178,7 @@ void mlx5e_tir_builder_build_tls(struct mlx5e_tir_builder *builder)
 	WARN_ON(builder->modify);
 
 	MLX5_SET(tirc, tirc, tls_en, 1);
-	MLX5_SET(tirc, tirc, self_lb_block,
-		 MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST |
-		 MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST);
+	mlx5e_tir_context_self_lb_block(tirc, true, true);
 }
 
 int mlx5e_tir_init(struct mlx5e_tir *tir, struct mlx5e_tir_builder *builder,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
index e8df3aaf6562..958eeb959a19 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tir.h
@@ -35,6 +35,9 @@ void mlx5e_tir_builder_build_rss(struct mlx5e_tir_builder *builder,
 				 const struct mlx5e_rss_params_traffic_type *rss_tt,
 				 bool inner);
 void mlx5e_tir_builder_build_direct(struct mlx5e_tir_builder *builder);
+void mlx5e_tir_builder_build_self_lb_block(struct mlx5e_tir_builder *builder,
+					   bool enable_uc_lb,
+					   bool enable_mc_lb);
 void mlx5e_tir_builder_build_tls(struct mlx5e_tir_builder *builder);
 
 struct mlx5_core_dev;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
index 376a018b2db1..fad6b761f622 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
@@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
 int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
 			 bool enable_mc_lb)
 {
+	struct mlx5e_tir_builder *builder;
 	struct mlx5e_tir *tir;
-	u8 lb_flags = 0;
 	int err  = 0;
-	u32 tirn = 0;
-	int inlen;
-	void *in;
 
-	inlen = MLX5_ST_SZ_BYTES(modify_tir_in);
-	in = kvzalloc(inlen, GFP_KERNEL);
-	if (!in)
+	builder = mlx5e_tir_builder_alloc(true);
+	if (!builder)
 		return -ENOMEM;
 
-	if (enable_uc_lb)
-		lb_flags = MLX5_TIRC_SELF_LB_BLOCK_BLOCK_UNICAST;
-
-	if (enable_mc_lb)
-		lb_flags |= MLX5_TIRC_SELF_LB_BLOCK_BLOCK_MULTICAST;
-
-	if (lb_flags)
-		MLX5_SET(modify_tir_in, in, ctx.self_lb_block, lb_flags);
-
-	MLX5_SET(modify_tir_in, in, bitmask.self_lb_en, 1);
+	mlx5e_tir_builder_build_self_lb_block(builder, enable_uc_lb,
+					      enable_mc_lb);
 
 	mutex_lock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 	list_for_each_entry(tir, &mdev->mlx5e_res.hw_objs.td.tirs_list, list) {
-		tirn = tir->tirn;
-		err = mlx5_core_modify_tir(mdev, tirn, in);
+		err = mlx5e_tir_modify(tir, builder);
 		if (err)
 			break;
 	}
 	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
 
-	kvfree(in);
+	mlx5e_tir_builder_free(builder);
 	if (err)
 		mlx5_core_err(mdev,
 			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
-			      tirn,
+			      mlx5e_tir_get_tirn(tir),
 			      enable_uc_lb, enable_mc_lb, err);
 
 	return err;
-- 
2.31.1


