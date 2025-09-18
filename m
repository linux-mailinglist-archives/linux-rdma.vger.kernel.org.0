Return-Path: <linux-rdma+bounces-13471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E5B834C4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B51D6468653
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 07:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614F2EC0AA;
	Thu, 18 Sep 2025 07:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="F8prLcWO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010065.outbound.protection.outlook.com [52.101.56.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B7A2EA48F;
	Thu, 18 Sep 2025 07:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180037; cv=fail; b=R/r3EhGCUBMxS6MgJ/HeoJfW58OXqkEve16BIf5tRI+AKEGKy21Nldxb1ILE1pQoD2WWYbTU2iaYo03kAiSBr87tl7CzdN5RdsnrWWvC2NKLYFFxLYwzDSzqrlJ9NFGLChDqFTgwYQ8Yo+fyP1RCsPzHJ/J7NsGma+JHgi5dO44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180037; c=relaxed/simple;
	bh=hsUEyXfBtlzMCqWCsy3f+7SNJ1VjYD/HbOONtfSqzuk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pW1OKv/vcThfHnjRxURHNBNf3t8GB3xjXUXHT0tAk78/BbbkiWfLBwVeaKUxJ1xF6flg7KYhjFL2uydz8kjD5lYprNS9FttjcV/a3FUOYjc59TzVkEe58+70CPUpE/xmgBC2QGvAIMYuiInlvOP7QnMe3W5SaoZITSMI7MOidTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=F8prLcWO; arc=fail smtp.client-ip=52.101.56.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RKInUK41Dx/AnPpPjF1VOnT2xSfFMJCcfYnUtjx6Vg1E1ZWoPNDgH0ekkmqOjVePfs/rqHati5QtbksQfcPraBIM24m2ZzUU6fRSMMAgrcmxXXsiqYGEcdaVDurVy1G3Tjqhi2wThW3f+nYiSpwPltl8LPGP1z57FQtepHwqKL/C462eOT+OCwqwFk59kr32Fk/HuZUU8P80yIADe/9xgZ4yWvdmtRV8Ol+pv9JNKC7qIGpK+FpDKptKsQNwD5lMod3QowdqexOxXZhZ3x1JM+S9wWAXqZKthtFwCRsxKXRTG8ByKiWkvMfpTCZ+uPfbq3kKgK+CU/u50QwbIxTmwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hV6nnGHUIqGGOBUEv98uUPhc15c8L9XI3TwVFJm2NH4=;
 b=Q6q42UeMjbaOJ1Ad2BehavJO6r+71uJ894nuB1cG2nvZf78/tIkw5BfqRvCTXDkNbFCnl69aXqZSmCEfphRAOjCbGmlzcYTTle2gCXAX+22tLm6SK9n70pdUeGI8h006Tj3NscF9+L6MwebeaU2VdpwTlG6ZvHcuTWVYNTG5/bylizN2r77vh3PHdnZ2/BZmAer4ZeVBB04ZnkRfXDfqIUk/WrVcvOkpjbavMVDS2wnhRp9UG6f2Jus2bUtt1ck1V6eVjNgnrAQLIBykDCXnjoxUNxAvOpOf9ax1JtSs1e4DV+kIXoZbdpZDFTJUV2XRO4ZqHJh/tjDzFvIsOvNpSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hV6nnGHUIqGGOBUEv98uUPhc15c8L9XI3TwVFJm2NH4=;
 b=F8prLcWOsb/e0M1LI8IZfc5lvJfc8UNYCaIBS1pfmM5jByTcgm3rf7gwgG2rP4wVLRiaiiJhn0aOoJ1Hrkp7/lz5ws0CkFv95s+7hnP8jpstankzvPkGhhS9u4xlIu4BUaI/89nB+vqD9Ssdf47EG63wPM9JK/EZ29l3/0wKTgN7DWe2Kg40gPUVyAUDm8wt2/emj0LGoTZnCW3MxdhbflJbRC5yaQi0MyMbkaLOInJN5S3Gt4NjJpKIIY2YkK0LqDQnq8wwhJdsSAXbLelzZrkJyDh/yidiJAdfpvFiy+7HARo+tW5u+tTqDjlgAYNl50IRNKRofIVbSa5UM5tDvA==
Received: from BL1PR13CA0119.namprd13.prod.outlook.com (2603:10b6:208:2b9::34)
 by PH7PR12MB8828.namprd12.prod.outlook.com (2603:10b6:510:26b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 07:20:23 +0000
Received: from BN1PEPF00006000.namprd05.prod.outlook.com
 (2603:10b6:208:2b9:cafe::fc) by BL1PR13CA0119.outlook.office365.com
 (2603:10b6:208:2b9::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 07:19:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00006000.mail.protection.outlook.com (10.167.243.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:20:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Thu, 18 Sep
 2025 00:20:06 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:20:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 00:20:00 -0700
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
Subject: [PATCH net-next 4/4] net/mlx5e: Add flow rules for the decrypted ESP packets
Date: Thu, 18 Sep 2025 10:19:23 +0300
Message-ID: <1758179963-649455-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006000:EE_|PH7PR12MB8828:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bada3d1-5bbb-463c-26f0-08ddf683d516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZkhZBMNnQv7G6p/ofd0IWnLKMFi64X2I+vcYWCb+eXgt0LjOsJX+hkw/ORXA?=
 =?us-ascii?Q?QYgH81QOafjP+TgDBbFlMq4xDxLLqKERV+61A6BNsN6oJwSLc4w/atIQ6182?=
 =?us-ascii?Q?fC6VeIdTBu91MXdU4SX0gHbaDPrjWZoT/ux1mFn+FmogsbqdhVG9+0903cnQ?=
 =?us-ascii?Q?vhALf2nc75cF7hVXbAGwmTkolFVfv9doQ/l04eeHbmODEx2175yKAESt6KVV?=
 =?us-ascii?Q?tgH2HaSX8eIszLI/vQRlI0pVpJbcZCGDzMF+Ol8crUoMRgSd+YRxrYDKHDrF?=
 =?us-ascii?Q?ZzoZU/6U8JBhgEhb2AaLbeGw7BAbfBWV/SQnqKw55UuYbCkILJSDEiPMmqym?=
 =?us-ascii?Q?YlPckLj9YeZYeBe4+hJK2pk8v5ezwKFp9MHZFRoFQT83v2SwmJJlbfZ55F8C?=
 =?us-ascii?Q?vKSRSRX/NGRM6EPXJPOFI5f0MJaK35V8y4uwRY2jmKDnMe8xexwV133SwBvN?=
 =?us-ascii?Q?av8TJFMCwM137Ib736UVUL1MmAdaaOr8sHZAdIDptPhdHgs0HywbOSVCDHR4?=
 =?us-ascii?Q?jKv3nwE1gvuApvhcwSCsiJJFVlEQ3TeadaLJdbBOyCH6C5KtXVEDyx5bAccD?=
 =?us-ascii?Q?SqA7N+PxjDcql3+3RgO0zPO8U/CMiPoDmkvzsGNehiQBjwiCcP97UeB8dL0w?=
 =?us-ascii?Q?wwsIFryllqZrzIpwlP0qZLzp0JKlZfGB0GROEoUn+9+5H2fJtwrluH+2ihi8?=
 =?us-ascii?Q?fvtd8uw3wzwTajUAkbHbuadhThWwRNAO7+xt3yCDsiKoAdfSRdB0VTWGCVjR?=
 =?us-ascii?Q?AKfD6Mnk3QQkWPicgo58FxOk6e737Pl2FBDa1wX4AV2EdgxvwiJU+pmBL+iB?=
 =?us-ascii?Q?ItqJ+3Oi0sqQTP+uf3ZGsAmUSG3HnTPwsAepaj9hGxRYVUco7vI7DEsKszTm?=
 =?us-ascii?Q?pNQTYioJSTsYf04rtc8uh3fjzthrp9fGykcnbwPVNlyfn3Ba6hjZTFilAZUt?=
 =?us-ascii?Q?QQ9Fh2tZvNbIifHJRGDejW52UeKCIvhrqUcPoThZwNILmSmh37KWpX8Clzon?=
 =?us-ascii?Q?PSRXYblIMpO1tidij1dp6B9KymyndMZUgyJdul9T6eELhmozHsUsjmH6r+GE?=
 =?us-ascii?Q?u5gOoa0W6da/dtcagTBjKi9pME67YDLVFgd1uABFswfVpG4BeVvJ+yD1CjOg?=
 =?us-ascii?Q?XcpoEXOrNPO2d4XdheS/COOwvJnp7NfpP219Ffe+qAkUKXheA1SguEB48+w4?=
 =?us-ascii?Q?pg5No076V9NYVPN1ViOnWfvG/Roo4QJ4tqHTT9GLVc7RceAKWJMQDZ3LF1EE?=
 =?us-ascii?Q?0SXWV9sjO/873b+qVe4y5Xob3LEcKYTg/qZKcbG/2T1lqUy98CmXUTJF/MVE?=
 =?us-ascii?Q?YB9IaQjvORgY3UI5AhhSp8Z9iUkbHyNrH5WPI+Bt2KdI4HVbF0JILpH16Slz?=
 =?us-ascii?Q?zPZsuh16XEKjLQwJi2KWsI8DBCTe/DQfWxx1KTvkhzCX9kf2pcMmqQF4S2XU?=
 =?us-ascii?Q?mEb1VijIlgFBs/CxeMcsYZoTMw2qf8qDK4edlMnr7Fv8PG+YhFuIKfM4RBQ/?=
 =?us-ascii?Q?yjsBM7+YzyfGs8IItIdHZRs9QJo1WG4roTL6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:20:23.0834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bada3d1-5bbb-463c-26f0-08ddf683d516
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006000.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8828

From: Jianbo Liu <jianbol@nvidia.com>

The previous commit introduced two new flow groups to enable L4 RSS
for decrypted IPsec traffic. This commit implements the logic to
populate these groups with the necessary steering rules.

The rules are created dynamically whenever the first IPSec offload
rule is configured via the xfrm subsystem and the decryption tables
for RX are created. Each rule matches a specific decrypted traffic
type based on its ip version (or ethertype) and outer/inner
l4_type_ext, directing it to the appropriate L4 RSS-enabled TIR.

The lifecycle of these steering rules is tied directly to the RX
tables. They are deleted when the RX tables are destroyed.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  16 +-
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 239 +++++++++++++++++-
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  |   3 +
 3 files changed, 241 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index a06929852296..4526ca899daf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -61,6 +61,7 @@ struct mlx5e_ipsec_rx {
 	struct mlx5_flow_table *pol_miss_ft;
 	struct mlx5_flow_handle *pol_miss_rule;
 	u8 allow_tunnel_mode : 1;
+	u8 ttc_rules_added : 1;
 };
 
 /* IPsec RX flow steering */
@@ -683,10 +684,13 @@ static void ipsec_mpv_work_handler(struct work_struct *_work)
 	complete(&work->master_priv->ipsec->comp);
 }
 
-static void ipsec_rx_ft_disconnect(struct mlx5e_ipsec *ipsec, u32 family)
+static void ipsec_rx_ft_disconnect(struct mlx5e_ipsec *ipsec,
+				   struct mlx5e_ipsec_rx *rx, u32 family)
 {
 	struct mlx5_ttc_table *ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
 
+	if (rx->ttc_rules_added)
+		mlx5_ttc_destroy_ipsec_rules(ttc);
 	mlx5_ttc_fwd_default_dest(ttc, family2tt(family));
 }
 
@@ -721,7 +725,7 @@ static void rx_destroy(struct mlx5_core_dev *mdev, struct mlx5e_ipsec *ipsec,
 {
 	/* disconnect */
 	if (rx != ipsec->rx_esw)
-		ipsec_rx_ft_disconnect(ipsec, family);
+		ipsec_rx_ft_disconnect(ipsec, rx, family);
 
 	mlx5_del_flow_rules(rx->sa.rule);
 	mlx5_destroy_flow_group(rx->sa.group);
@@ -820,10 +824,16 @@ static void ipsec_rx_ft_connect(struct mlx5e_ipsec *ipsec,
 				struct mlx5e_ipsec_rx_create_attr *attr)
 {
 	struct mlx5_flow_destination dest = {};
+	struct mlx5_ttc_table *ttc, *inner_ttc;
 
 	dest.type = MLX5_FLOW_DESTINATION_TYPE_FLOW_TABLE;
 	dest.ft = rx->ft.sa;
-	mlx5_ttc_fwd_dest(attr->ttc, family2tt(attr->family), &dest);
+	if (mlx5_ttc_fwd_dest(attr->ttc, family2tt(attr->family), &dest))
+		return;
+
+	ttc = mlx5e_fs_get_ttc(ipsec->fs, false);
+	inner_ttc = mlx5e_fs_get_ttc(ipsec->fs, true);
+	rx->ttc_rules_added = !mlx5_ttc_create_ipsec_rules(ttc, inner_ttc);
 }
 
 static int ipsec_rx_chains_create_miss(struct mlx5e_ipsec *ipsec,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index 3cd5de6f714f..7adad784ad46 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -32,10 +32,13 @@ static int mlx5_fs_ttc_table_size(const struct mlx5_fs_ttc_groups *groups)
 struct mlx5_ttc_table {
 	int num_groups;
 	const struct mlx5_fs_ttc_groups *groups;
+	struct mlx5_core_dev *mdev;
 	struct mlx5_flow_table *t;
 	struct mlx5_flow_group **g;
 	struct mlx5_ttc_rule rules[MLX5_NUM_TT];
 	struct mlx5_flow_handle *tunnel_rules[MLX5_NUM_TUNNEL_TT];
+	u32 refcnt;
+	struct mutex mutex; /* Protect adding rules for ipsec crypto offload */
 };
 
 struct mlx5_flow_table *mlx5_get_ttc_flow_table(struct mlx5_ttc_table *ttc)
@@ -302,6 +305,31 @@ static u8 mlx5_etype_to_ipv(u16 ethertype)
 	return 0;
 }
 
+static void mlx5_fs_ttc_set_match_ipv_outer(struct mlx5_core_dev *mdev,
+					    struct mlx5_flow_spec *spec,
+					    u16 etype)
+{
+	int match_ipv_outer =
+		MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
+					  ft_field_support.outer_ip_version);
+	u8 ipv;
+
+	ipv = mlx5_etype_to_ipv(etype);
+	if (match_ipv_outer && ipv) {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 outer_headers.ip_version);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 outer_headers.ip_version, ipv);
+	} else {
+		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+				 outer_headers.ethertype);
+		MLX5_SET(fte_match_param, spec->match_value,
+			 outer_headers.ethertype, etype);
+	}
+
+	spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
+}
+
 static void mlx5_fs_ttc_set_match_proto(void *headers_c, void *headers_v,
 					u8 proto, bool use_l4_type)
 {
@@ -326,14 +354,10 @@ mlx5_generate_ttc_rule(struct mlx5_core_dev *dev, struct mlx5_flow_table *ft,
 		       struct mlx5_flow_destination *dest, u16 etype, u8 proto,
 		       bool use_l4_type, bool ipsec_rss)
 {
-	int match_ipv_outer =
-		MLX5_CAP_FLOWTABLE_NIC_RX(dev,
-					  ft_field_support.outer_ip_version);
 	MLX5_DECLARE_FLOW_ACT(flow_act);
 	struct mlx5_flow_handle *rule;
 	struct mlx5_flow_spec *spec;
 	int err = 0;
-	u8 ipv;
 
 	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
@@ -350,16 +374,8 @@ mlx5_generate_ttc_rule(struct mlx5_core_dev *dev, struct mlx5_flow_table *ft,
 					    proto, use_l4_type);
 	}
 
-	ipv = mlx5_etype_to_ipv(etype);
-	if (match_ipv_outer && ipv) {
-		spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, outer_headers.ip_version);
-		MLX5_SET(fte_match_param, spec->match_value, outer_headers.ip_version, ipv);
-	} else if (etype) {
-		spec->match_criteria_enable = MLX5_MATCH_OUTER_HEADERS;
-		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria, outer_headers.ethertype);
-		MLX5_SET(fte_match_param, spec->match_value, outer_headers.ethertype, etype);
-	}
+	if (etype)
+		mlx5_fs_ttc_set_match_ipv_outer(dev, spec, etype);
 
 	if (ipsec_rss && proto == IPPROTO_ESP) {
 		MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
@@ -838,6 +854,7 @@ void mlx5_destroy_ttc_table(struct mlx5_ttc_table *ttc)
 
 	kfree(ttc->g);
 	mlx5_destroy_flow_table(ttc->t);
+	mutex_destroy(&ttc->mutex);
 	kvfree(ttc);
 }
 
@@ -894,6 +911,9 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
 	if (err)
 		goto destroy_ft;
 
+	ttc->mdev = dev;
+	mutex_init(&ttc->mutex);
+
 	return ttc;
 
 destroy_ft:
@@ -927,3 +947,194 @@ int mlx5_ttc_fwd_default_dest(struct mlx5_ttc_table *ttc,
 
 	return mlx5_ttc_fwd_dest(ttc, type, &dest);
 }
+
+static void _mlx5_ttc_destroy_ipsec_rules(struct mlx5_ttc_table *ttc)
+{
+	enum mlx5_traffic_types i;
+
+	for (i = MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_TCP;
+	     i <= MLX5_TT_DECRYPTED_ESP_INNER_IPV6_UDP; i++) {
+		if (!ttc->rules[i].rule)
+			continue;
+
+		mlx5_del_flow_rules(ttc->rules[i].rule);
+		ttc->rules[i].rule = NULL;
+	}
+}
+
+void mlx5_ttc_destroy_ipsec_rules(struct mlx5_ttc_table *ttc)
+{
+	if (!mlx5_ttc_has_esp_flow_group(ttc))
+		return;
+
+	mutex_lock(&ttc->mutex);
+	if (--ttc->refcnt)
+		goto unlock;
+
+	_mlx5_ttc_destroy_ipsec_rules(ttc);
+unlock:
+	mutex_unlock(&ttc->mutex);
+}
+
+static int mlx5_ttc_get_tt_attrs(enum mlx5_traffic_types type,
+				 u16 *etype, int *l4_type_ext,
+				 enum mlx5_traffic_types *tir_tt)
+{
+	switch (type) {
+	case MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_TCP:
+	case MLX5_TT_DECRYPTED_ESP_INNER_IPV4_TCP:
+		*etype = ETH_P_IP;
+		*l4_type_ext = MLX5_PACKET_L4_TYPE_EXT_TCP;
+		*tir_tt = MLX5_TT_IPV4_TCP;
+		break;
+	case MLX5_TT_DECRYPTED_ESP_OUTER_IPV6_TCP:
+	case MLX5_TT_DECRYPTED_ESP_INNER_IPV6_TCP:
+		*etype = ETH_P_IPV6;
+		*l4_type_ext = MLX5_PACKET_L4_TYPE_EXT_TCP;
+		*tir_tt = MLX5_TT_IPV6_TCP;
+		break;
+	case MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_UDP:
+	case MLX5_TT_DECRYPTED_ESP_INNER_IPV4_UDP:
+		*etype = ETH_P_IP;
+		*l4_type_ext = MLX5_PACKET_L4_TYPE_EXT_UDP;
+		*tir_tt = MLX5_TT_IPV4_UDP;
+		break;
+	case MLX5_TT_DECRYPTED_ESP_OUTER_IPV6_UDP:
+	case MLX5_TT_DECRYPTED_ESP_INNER_IPV6_UDP:
+		*etype = ETH_P_IPV6;
+		*l4_type_ext = MLX5_PACKET_L4_TYPE_EXT_UDP;
+		*tir_tt = MLX5_TT_IPV6_UDP;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static struct mlx5_flow_handle *
+mlx5_ttc_create_ipsec_outer_rule(struct mlx5_ttc_table *ttc,
+				 enum mlx5_traffic_types type)
+{
+	struct mlx5_flow_destination dest;
+	MLX5_DECLARE_FLOW_ACT(flow_act);
+	enum mlx5_traffic_types tir_tt;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int l4_type_ext;
+	u16 etype;
+	int err;
+
+	err = mlx5_ttc_get_tt_attrs(type, &etype, &l4_type_ext, &tir_tt);
+	if (err)
+		return ERR_PTR(err);
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return ERR_PTR(-ENOMEM);
+
+	mlx5_fs_ttc_set_match_ipv_outer(ttc->mdev, spec, etype);
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 outer_headers.l4_type_ext);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 outer_headers.l4_type_ext, l4_type_ext);
+
+	dest = mlx5_ttc_get_default_dest(ttc, tir_tt);
+
+	rule = mlx5_add_flow_rules(ttc->t, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(ttc->mdev, "%s: add rule failed\n", __func__);
+	}
+
+	kvfree(spec);
+	return err ? ERR_PTR(err) : rule;
+}
+
+static struct mlx5_flow_handle *
+mlx5_ttc_create_ipsec_inner_rule(struct mlx5_ttc_table *ttc,
+				 struct mlx5_ttc_table *inner_ttc,
+				 enum mlx5_traffic_types type)
+{
+	struct mlx5_flow_destination dest;
+	MLX5_DECLARE_FLOW_ACT(flow_act);
+	enum mlx5_traffic_types tir_tt;
+	struct mlx5_flow_handle *rule;
+	struct mlx5_flow_spec *spec;
+	int l4_type_ext;
+	u16 etype;
+	int err;
+
+	err = mlx5_ttc_get_tt_attrs(type, &etype, &l4_type_ext, &tir_tt);
+	if (err)
+		return ERR_PTR(err);
+
+	spec = kvzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return ERR_PTR(-ENOMEM);
+
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 inner_headers.ip_version);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 inner_headers.ip_version, mlx5_etype_to_ipv(etype));
+	MLX5_SET_TO_ONES(fte_match_param, spec->match_criteria,
+			 inner_headers.l4_type_ext);
+	MLX5_SET(fte_match_param, spec->match_value,
+		 inner_headers.l4_type_ext, l4_type_ext);
+
+	dest = mlx5_ttc_get_default_dest(inner_ttc, tir_tt);
+
+	spec->match_criteria_enable = MLX5_MATCH_INNER_HEADERS;
+
+	rule = mlx5_add_flow_rules(ttc->t, spec, &flow_act, &dest, 1);
+	if (IS_ERR(rule)) {
+		err = PTR_ERR(rule);
+		mlx5_core_err(ttc->mdev, "%s: add rule failed\n", __func__);
+	}
+
+	kvfree(spec);
+	return err ? ERR_PTR(err) : rule;
+}
+
+int mlx5_ttc_create_ipsec_rules(struct mlx5_ttc_table *ttc,
+				struct mlx5_ttc_table *inner_ttc)
+{
+	struct mlx5_flow_handle *rule;
+	enum mlx5_traffic_types i;
+
+	if (!mlx5_ttc_has_esp_flow_group(ttc))
+		return 0;
+
+	mutex_lock(&ttc->mutex);
+	if (ttc->refcnt)
+		goto skip;
+
+	for (i = MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_TCP;
+	     i <= MLX5_TT_DECRYPTED_ESP_OUTER_IPV6_UDP; i++) {
+		rule = mlx5_ttc_create_ipsec_outer_rule(ttc, i);
+		if (IS_ERR(rule))
+			goto err_out;
+
+		ttc->rules[i].rule = rule;
+	}
+
+	for (i = MLX5_TT_DECRYPTED_ESP_INNER_IPV4_TCP;
+	     i <= MLX5_TT_DECRYPTED_ESP_INNER_IPV6_UDP; i++) {
+		rule = mlx5_ttc_create_ipsec_inner_rule(ttc, inner_ttc, i);
+		if (IS_ERR(rule))
+			goto err_out;
+
+		ttc->rules[i].rule = rule;
+	}
+
+skip:
+	ttc->refcnt++;
+	mutex_unlock(&ttc->mutex);
+	return 0;
+
+err_out:
+	_mlx5_ttc_destroy_ipsec_rules(ttc);
+	mutex_unlock(&ttc->mutex);
+	return PTR_ERR(rule);
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
index cae6a8ba0491..95f6e56724a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
@@ -80,6 +80,9 @@ bool mlx5_tunnel_inner_ft_supported(struct mlx5_core_dev *mdev);
 u8 mlx5_get_proto_by_tunnel_type(enum mlx5_tunnel_types tt);
 
 bool mlx5_ttc_has_esp_flow_group(struct mlx5_ttc_table *ttc);
+int mlx5_ttc_create_ipsec_rules(struct mlx5_ttc_table *ttc,
+				struct mlx5_ttc_table *inner_ttc);
+void mlx5_ttc_destroy_ipsec_rules(struct mlx5_ttc_table *ttc);
 static inline bool mlx5_ttc_is_decrypted_esp_tt(enum mlx5_traffic_types tt)
 {
 	return tt >= MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_TCP &&
-- 
2.31.1


