Return-Path: <linux-rdma+bounces-13470-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B0B834B8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 85C327BB3A4
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 07:19:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 727982EC0B8;
	Thu, 18 Sep 2025 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="J4BJ7gz+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010022.outbound.protection.outlook.com [52.101.201.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47EEF2EACF9;
	Thu, 18 Sep 2025 07:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758180026; cv=fail; b=Ugh3CKf9/hdJQu0k6n6wR8haquezWvtc9ZzXRCW/Kc7UqzT1+NvDwsrPLbTBrqjBZp7HJ4IdC/OWAttWwrrgGWO2qKrGUpQJ9e92d23QTio1QQ+4CKj0eKXawExldhM8MZB//ApGJknP5C65DIB1L3bW/Cgyp0W0e/0ZcAnjY/Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758180026; c=relaxed/simple;
	bh=pGQq5So5teW/RZ0PzjVL3owVZm06qAQgSPGvgJbFp2w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FXO+/SjRGvrz3BBJoxD/ORYW6UZzZ0Za2unmMabMQbxVp+EK2hy5p2JKDjpgbsoHIWkzorr+n3mno3poSEx8GjkMcvAXdQe38PQzt29QzJD0JwnKBFksLM21N8VfRu6ywYKRDXi2XpkCycEydLHIu8vLQdIzyJs3KgDeIEcevNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=J4BJ7gz+; arc=fail smtp.client-ip=52.101.201.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HVA1PjWNhQlX1tAmoyvk1cfDC7oLxMFLCcUPk+nx9ZWZKdkpuUQIoe2jEC8kPuHCMEvVsOwQSbF5JnLW1q22weRx+PYqzoagaPHwdyHM9cxggwiT5e65v+r9dETusakhr0JCKfHzdKwlf0qi5jZp6Y1tEBUBV7murRdk2ENwZXVdIyESKKr4ecUap2FtUtdRgtez4YFsOkqlLGSab7fhA/Wim7PRwSwmD22lJ6DLe+/JYPGtrNzuS5QVWjn4s1wPKixFHVQ21nUcTaaKjf48ix+LT6mKOaRVhIUHhOBpYF2KO7wkCRh2ms8VLS6WIB3JWJgEEDe4j3aM7CiRM149qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbHeDXFhW4IKcNc0JICRhkaHnSTiBIn83jjCxuL18Sc=;
 b=Wb9txXnI+yriBk+JCQRfpPxeZXmJ2tmxWhWCgQPQBEz7ZxRciMyTu2XyavmrwoK0dnMv9mjXurZdR3w43uAiiE8mSAkd/SomU4O1CC7FSODU+HSdg6j8/GfPTo3HWZcVL89KSD745S0xl++6WygZWkX0xqDZhn65yAzjU6dUDOnT1WWDApHCCr2HEE4yjToQKa/neGEuA9TNq2NwfqQm7vAXagyoIkS+ru11qfquevSzhh8Wj3EBE+kFWkY+S9ZsDrpj2XZ07PrvGAsneLxtmmxJUdp+H8Z8aWWFI7DnupVTbM8nz4+sAsgyWrkx2oSfUqgIX62vuqSP8TwMgBcYYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DbHeDXFhW4IKcNc0JICRhkaHnSTiBIn83jjCxuL18Sc=;
 b=J4BJ7gz+voBfwzvaPQtXZgvrMwbVvthOhEe9xRfr8GB1pfTzY8iaxKGSGlhmbuEkWm8b1IwzAmOHIe3XDijMoK+GPjGneOHTCEj+CqX2SqGp0QKGXbY7tGggEDmJfpIfEsLAwFaC/Nvq0yBQgXD7gihZSZ35b4+d3KJdZUpTdZrC4vsVn1x1Xi1uC2FdDlChkdqEnLBBGLWHEIK4PIWrgbXs4tgJ7edJ7Fm2HpCOEWHELKfx/yWoJI0ls+zfybehjJsQjKlGli77MYHerT/szghHyKMbC9y7UIvPGYIxmocScYTASyg+QNpIf04VP47YyN37zZ8fztzT+N7c8Bse5g==
Received: from MN2PR06CA0003.namprd06.prod.outlook.com (2603:10b6:208:23d::8)
 by SJ2PR12MB8158.namprd12.prod.outlook.com (2603:10b6:a03:4f7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 07:20:14 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::e6) by MN2PR06CA0003.outlook.office365.com
 (2603:10b6:208:23d::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Thu,
 18 Sep 2025 07:20:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 07:20:13 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:20:00 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 18 Sep
 2025 00:19:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 18
 Sep 2025 00:19:55 -0700
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
Subject: [PATCH net-next 3/4] net/mlx5e: Add flow groups for the packets decrypted by crypto offload
Date: Thu, 18 Sep 2025 10:19:22 +0300
Message-ID: <1758179963-649455-4-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|SJ2PR12MB8158:EE_
X-MS-Office365-Filtering-Correlation-Id: 899930a4-8af1-48dd-3542-08ddf683cf5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YyNduiYHaxtL3iOeKAmqXcOk2ViSaSoQ4763B/pIVCye7BHbjYVSo8yIb4ha?=
 =?us-ascii?Q?VZgonz0nX7bmGiwZnsPPPGI2sQnVCkJQMiQn2M/7dCoI/QCVg2H5bGiqmjuv?=
 =?us-ascii?Q?rHAU75FMtZY0+UXwiys9w09+4I18YiPR1ex76cGit49VkwsGFRF8vLOJ/WjC?=
 =?us-ascii?Q?gOyHQgzmVywrNJYHEH9Gf5XYJ0kkq0jxZND/jlfVIeSMfwzVwLW+2LKvsW8x?=
 =?us-ascii?Q?XwWljxoPZl2yq7drxg/CDDiNWQx/J1Go3hgVUlmZKPnm1sZr5XNRSdcUlGhE?=
 =?us-ascii?Q?PEhnp6zSL+d9p5FaqK4fgFzNpbXdlegCDHvqAv/CLjiA53CNv+MFapj4q5uH?=
 =?us-ascii?Q?J/mfZ495yANZ+I37pOrxG9ofuxZIzFB/IOd5JIO6iRX3M9EU1bdph72h1a5I?=
 =?us-ascii?Q?7o8ZYut11DM2+F2s4FZhPJZw9ggX8LA8+k8XgJeeceCgR16CraThYyh0/e03?=
 =?us-ascii?Q?xNUBym7XI813nYJKRxQ80OMPEmObjX5cBiY3DP6lrLa7vRdRkn7/uy9fxKg9?=
 =?us-ascii?Q?+E1UAARp/tdFugEyDfNtkeALr05cb2Wc7qiAWrqilT8wwP757S2OiaUGjMQH?=
 =?us-ascii?Q?n61+qX8qB3jg8MD5oSkCwDMGU71WCwiyKgIak2nYmUTeXcLjEdgdoxQeOiHH?=
 =?us-ascii?Q?inHlj3NHDdaNcJrF01wTjl2IvMR3XQzuzL8LGo99OZczN0mXFlsTIMZxOlal?=
 =?us-ascii?Q?o29rGr9HhlAzmZG4u6emxSIuGWUfoIy6FKQ4GZxWF3K2UqTFkzX9tpdwRhlE?=
 =?us-ascii?Q?+CHrspOOwhWfBYsdv6N3bqJbhzSjljBh2Rg/J/Sci0WHTpYBkuPZvv5lYNtA?=
 =?us-ascii?Q?ffSEmBCspDm42lJybTmrwe8Cpa4x6MMU1N4HibcHukBIB5/pN5xjNbQJy2wf?=
 =?us-ascii?Q?ZXd+jBXXxyWvOlJAE0PGL318qDsZXM94D6Q0PFB6u4S9fPoTK4v7tmcpL3WW?=
 =?us-ascii?Q?cGCEPFCu9JWhr7l/HvJ4Ss+zZ/FjeCuX5BoVKIRIhw8yYLtSQy7KELZBxqkX?=
 =?us-ascii?Q?xh4S3glmQgzZIWQZavDW7zIk/kK/wqAVu5FYd7yeEt5DWtxI80966gJEWY27?=
 =?us-ascii?Q?uBMoEKpyEV4u439sM2waoKZwZyJ70bcw0qtJdQmVJzPuFOgqLgUWO2m/BQ35?=
 =?us-ascii?Q?mdgh+qY8QenFJSN37V+g7ydFfGNQMxaRZd+QXarqNm79T+ok4G4OPyq4JAUW?=
 =?us-ascii?Q?YrJM+wZi2IscNC1sgw843HvVYlPpbSVGohvNWuAuBP/p81m/d0/gapl3QiWd?=
 =?us-ascii?Q?JPdwT6qWue81Os7U3tVqjui/h2Ibc9Mpv46xTcE71KJQN6A6jbdmA6nAcJA6?=
 =?us-ascii?Q?Rot6tmItGvbS2K+Kk8GcLrgeRr80C2IvI2DsdweMAlUM7XI41JnpV7Y3aH42?=
 =?us-ascii?Q?7xQA7c+0R4bHKA/9sOvI87/dbZWuYE3ErUD35USZBBZADjKNAszdnRzEKXjX?=
 =?us-ascii?Q?tf1ley5QYzWcbMFx1bXk8iHI6I7XXjRS7fJ1kcQ1MK+leUi8Atn8i3GkQK/F?=
 =?us-ascii?Q?lRy/VjhHJLJjX6lFua+6UeWeAM7xamBjeFCY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 07:20:13.4804
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 899930a4-8af1-48dd-3542-08ddf683cf5e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8158

From: Jianbo Liu <jianbol@nvidia.com>

When using IPsec crypto offload, the hardware decrypts the packet
payload but preserves the ESP header. This prevents the standard RSS
mechanism from accessing the inner L4 (TCP/UDP) headers. As a result,
the RSS hash is calculated only on the outer L3 IP headers, causing
all traffic for a given IPsec tunnel to be directed to a single queue,
leading to poor traffic distribution.

Newer firmware introduces the ability to match on l4_type_ext, which
exposes the L4 protocol type following an ESP header. This allows the
driver to create steering rules that can identify the inner protocols
of decrypted packets.

This commit leverages this new capability to improve traffic
distribution. It adds two new flow groups to steer decrypted packets
to dedicated TIRs that was configured to perform RSS on the inner L4
headers.

These groups are inserted after the standard L4 group and before the
group that handles undecrypted ESP packets added in this series. The
first new group matches decrypted packets based on the outer IP
version (or ethertype) and l4_type_ext. The second new group matches
decrypted tunneled packets based on the inner IP version and
l4_type_ext. Eight new traffic types are also defined to support this
functionality.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/fs.h   |  2 +-
 .../net/ethernet/mellanox/mlx5/core/en_fs.c   | 15 ++++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  3 +
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.c  | 58 +++++++++++++++++--
 .../ethernet/mellanox/mlx5/core/lib/fs_ttc.h  | 13 +++++
 5 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
index cdc813ae9f23..59e3262cb09e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/fs.h
@@ -57,7 +57,7 @@ struct mlx5e_l2_table {
 	bool                       promisc_enabled;
 };
 
-#define MLX5E_NUM_INDIR_TIRS (MLX5_NUM_TT - 1)
+#define MLX5E_NUM_INDIR_TIRS (MLX5_NUM_INDIR_TIRS)
 
 #define MLX5_HASH_IP		(MLX5_HASH_FIELD_SEL_SRC_IP   |\
 				 MLX5_HASH_FIELD_SEL_DST_IP)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
index 15ffb8e0d884..8928d2dcd43f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_fs.c
@@ -905,6 +905,9 @@ static void mlx5e_set_inner_ttc_params(struct mlx5e_flow_steering *fs,
 	ft_attr->prio = MLX5E_NIC_PRIO;
 
 	for (tt = 0; tt < MLX5_NUM_TT; tt++) {
+		if (mlx5_ttc_is_decrypted_esp_tt(tt))
+			continue;
+
 		ttc_params->dests[tt].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 		ttc_params->dests[tt].tir_num =
 			tt == MLX5_TT_ANY ?
@@ -914,6 +917,13 @@ static void mlx5e_set_inner_ttc_params(struct mlx5e_flow_steering *fs,
 	}
 }
 
+static bool mlx5e_ipsec_rss_supported(struct mlx5_core_dev *mdev)
+{
+	return MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(mdev, ipsec_next_header) &&
+	       MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(mdev, outer_l4_type_ext) &&
+	       MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(mdev, inner_l4_type_ext);
+}
+
 void mlx5e_set_ttc_params(struct mlx5e_flow_steering *fs,
 			  struct mlx5e_rx_res *rx_res,
 			  struct ttc_params *ttc_params, bool tunnel,
@@ -929,9 +939,12 @@ void mlx5e_set_ttc_params(struct mlx5e_flow_steering *fs,
 	ft_attr->prio = MLX5E_NIC_PRIO;
 
 	ttc_params->ipsec_rss = ipsec_rss &&
-		MLX5_CAP_NIC_RX_FT_FIELD_SUPPORT_2(fs->mdev, ipsec_next_header);
+				mlx5e_ipsec_rss_supported(fs->mdev);
 
 	for (tt = 0; tt < MLX5_NUM_TT; tt++) {
+		if (mlx5_ttc_is_decrypted_esp_tt(tt))
+			continue;
+
 		ttc_params->dests[tt].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 		ttc_params->dests[tt].tir_num =
 			tt == MLX5_TT_ANY ?
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 09c3eecb836d..b6d6584fc6fe 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -838,6 +838,9 @@ static void mlx5e_hairpin_set_ttc_params(struct mlx5e_hairpin *hp,
 
 	ttc_params->ns_type = MLX5_FLOW_NAMESPACE_KERNEL;
 	for (tt = 0; tt < MLX5_NUM_TT; tt++) {
+		if (mlx5_ttc_is_decrypted_esp_tt(tt))
+			continue;
+
 		ttc_params->dests[tt].type = MLX5_FLOW_DESTINATION_TYPE_TIR;
 		ttc_params->dests[tt].tir_num =
 			tt == MLX5_TT_ANY ?
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
index 850fff4548c8..3cd5de6f714f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
@@ -9,7 +9,7 @@
 #include "mlx5_core.h"
 #include "lib/fs_ttc.h"
 
-#define MLX5_TTC_MAX_NUM_GROUPS		5
+#define MLX5_TTC_MAX_NUM_GROUPS		7
 #define MLX5_TTC_GROUP_TCPUDP_SIZE	(MLX5_TT_IPV6_UDP + 1)
 
 struct mlx5_fs_ttc_groups {
@@ -188,10 +188,12 @@ static const struct mlx5_fs_ttc_groups ttc_groups[] = {
 		},
 	},
 	[TTC_GROUPS_DEFAULT_ESP] = {
-		.num_groups = 4,
+		.num_groups = 6,
 		.group_size = {
 			MLX5_TTC_GROUP_TCPUDP_SIZE + BIT(1) +
 			MLX5_NUM_TUNNEL_TT,
+			BIT(2), /* decrypted outer L4 */
+			BIT(2), /* decrypted inner L4 */
 			BIT(1), /* ESP */
 			BIT(1),
 			BIT(0),
@@ -199,10 +201,12 @@ static const struct mlx5_fs_ttc_groups ttc_groups[] = {
 	},
 	[TTC_GROUPS_USE_L4_TYPE_ESP] = {
 		.use_l4_type = true,
-		.num_groups = 5,
+		.num_groups = 7,
 		.group_size = {
 			MLX5_TTC_GROUP_TCPUDP_SIZE,
 			BIT(1) + MLX5_NUM_TUNNEL_TT,
+			BIT(2), /* decrypted outer L4 */
+			BIT(2), /* decrypted inner L4 */
 			BIT(1), /* ESP */
 			BIT(1),
 			BIT(0),
@@ -391,6 +395,9 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 	for (tt = 0; tt < MLX5_NUM_TT; tt++) {
 		struct mlx5_ttc_rule *rule = &rules[tt];
 
+		if (mlx5_ttc_is_decrypted_esp_tt(tt))
+			continue;
+
 		if (test_bit(tt, params->ignore_dests))
 			continue;
 		rule->rule = mlx5_generate_ttc_rule(dev, ft, &params->dests[tt],
@@ -436,15 +443,55 @@ static int mlx5_generate_ttc_table_rules(struct mlx5_core_dev *dev,
 }
 
 static int mlx5_create_ttc_table_ipsec_groups(struct mlx5_ttc_table *ttc,
+					      bool use_ipv,
 					      u32 *in, int *next_ix)
 {
 	u8 *mc = MLX5_ADDR_OF(create_flow_group_in, in, match_criteria);
 	const struct mlx5_fs_ttc_groups *groups = ttc->groups;
 	int ix = *next_ix;
 
+	MLX5_SET(fte_match_param, mc, outer_headers.ip_protocol, 0);
+
+	/* decrypted ESP outer group */
+	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_OUTER_HEADERS);
+	MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.l4_type_ext);
+	MLX5_SET_CFG(in, start_flow_index, ix);
+	ix += groups->group_size[ttc->num_groups];
+	MLX5_SET_CFG(in, end_flow_index, ix - 1);
+	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
+	if (IS_ERR(ttc->g[ttc->num_groups]))
+		goto err;
+	ttc->num_groups++;
+
+	MLX5_SET(fte_match_param, mc, outer_headers.l4_type_ext, 0);
+
+	/* decrypted ESP inner group */
+	MLX5_SET_CFG(in, match_criteria_enable, MLX5_MATCH_INNER_HEADERS);
+	if (use_ipv)
+		MLX5_SET(fte_match_param, mc, outer_headers.ip_version, 0);
+	else
+		MLX5_SET(fte_match_param, mc, outer_headers.ethertype, 0);
+	MLX5_SET_TO_ONES(fte_match_param, mc, inner_headers.ip_version);
+	MLX5_SET_TO_ONES(fte_match_param, mc, inner_headers.l4_type_ext);
+	MLX5_SET_CFG(in, start_flow_index, ix);
+	ix += groups->group_size[ttc->num_groups];
+	MLX5_SET_CFG(in, end_flow_index, ix - 1);
+	ttc->g[ttc->num_groups] = mlx5_create_flow_group(ttc->t, in);
+	if (IS_ERR(ttc->g[ttc->num_groups]))
+		goto err;
+	ttc->num_groups++;
+
+	MLX5_SET(fte_match_param, mc, inner_headers.ip_version, 0);
+	MLX5_SET(fte_match_param, mc, inner_headers.l4_type_ext, 0);
+
 	/* undecrypted ESP group */
 	MLX5_SET_CFG(in, match_criteria_enable,
 		     MLX5_MATCH_OUTER_HEADERS | MLX5_MATCH_MISC_PARAMETERS_2);
+	if (use_ipv)
+		MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_version);
+	else
+		MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ethertype);
+	MLX5_SET_TO_ONES(fte_match_param, mc, outer_headers.ip_protocol);
 	MLX5_SET_TO_ONES(fte_match_param, mc,
 			 misc_parameters_2.ipsec_next_header);
 	MLX5_SET_CFG(in, start_flow_index, ix);
@@ -515,7 +562,7 @@ static int mlx5_create_ttc_table_groups(struct mlx5_ttc_table *ttc,
 	ttc->num_groups++;
 
 	if (mlx5_ttc_has_esp_flow_group(ttc)) {
-		err = mlx5_create_ttc_table_ipsec_groups(ttc, in, &ix);
+		err = mlx5_create_ttc_table_ipsec_groups(ttc, use_ipv, in, &ix);
 		if (err)
 			goto err;
 
@@ -615,6 +662,9 @@ static int mlx5_generate_inner_ttc_table_rules(struct mlx5_core_dev *dev,
 	for (tt = 0; tt < MLX5_NUM_TT; tt++) {
 		struct mlx5_ttc_rule *rule = &rules[tt];
 
+		if (mlx5_ttc_is_decrypted_esp_tt(tt))
+			continue;
+
 		if (test_bit(tt, params->ignore_dests))
 			continue;
 		rule->rule = mlx5_generate_inner_ttc_rule(dev, ft,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
index aead62441550..cae6a8ba0491 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.h
@@ -18,6 +18,14 @@ enum mlx5_traffic_types {
 	MLX5_TT_IPV4,
 	MLX5_TT_IPV6,
 	MLX5_TT_ANY,
+	MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_TCP,
+	MLX5_TT_DECRYPTED_ESP_OUTER_IPV6_TCP,
+	MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_UDP,
+	MLX5_TT_DECRYPTED_ESP_OUTER_IPV6_UDP,
+	MLX5_TT_DECRYPTED_ESP_INNER_IPV4_TCP,
+	MLX5_TT_DECRYPTED_ESP_INNER_IPV6_TCP,
+	MLX5_TT_DECRYPTED_ESP_INNER_IPV4_UDP,
+	MLX5_TT_DECRYPTED_ESP_INNER_IPV6_UDP,
 	MLX5_NUM_TT,
 	MLX5_NUM_INDIR_TIRS = MLX5_TT_ANY,
 };
@@ -72,5 +80,10 @@ bool mlx5_tunnel_inner_ft_supported(struct mlx5_core_dev *mdev);
 u8 mlx5_get_proto_by_tunnel_type(enum mlx5_tunnel_types tt);
 
 bool mlx5_ttc_has_esp_flow_group(struct mlx5_ttc_table *ttc);
+static inline bool mlx5_ttc_is_decrypted_esp_tt(enum mlx5_traffic_types tt)
+{
+	return tt >= MLX5_TT_DECRYPTED_ESP_OUTER_IPV4_TCP &&
+	       tt <= MLX5_TT_DECRYPTED_ESP_INNER_IPV6_UDP;
+}
 
 #endif /* __MLX5_FS_TTC_H__ */
-- 
2.31.1


