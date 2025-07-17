Return-Path: <linux-rdma+bounces-12232-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C369B0855F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 08:49:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 605C83B59AA
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jul 2025 06:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8C53219311;
	Thu, 17 Jul 2025 06:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gcLy7aYw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C7E1D7E5B;
	Thu, 17 Jul 2025 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752734949; cv=fail; b=lbMSF7OvSjPPKg/x9pi/cbZB/GyntIfYLWFeIpr8V3Y6qj1EA8WPmYDaDBG6PcwGQONxqQfX8ktdjax0/eNpqkOnjAfx4homGmQeXkZNNsPVLiHM2TtBdimr2gWIYLNLGZ2O18JM4IvxGZSBYL2VpgY+q6Db1aH3jehkTlmowIk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752734949; c=relaxed/simple;
	bh=EzjsZp5dWjxA7wXLf4HLfatZ1+o7n5+N+lvKN2o+Raw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsZ4I+3u9cDEX42uksjodj6Y9q7ModEG9w78TKu0RMh2divgK1yBSJVwF5KLBR5jzH2ZUYBWCvQhH3WLU3JxwOeSlM/EbeqQSLNMD4Cj1eX8mQH6ykUnQu2/738ImcqZX46vBmLD0IVe0mXjXG/PQPpRz+deYb0Ce+sVubrv8rA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gcLy7aYw; arc=fail smtp.client-ip=40.107.244.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VIw7W75wP8XmVUzYeF+l+QMbU3I+ncqoihbyUhd8A6dc5cX0EB0Qax8nKhzNekJqtJPsRe23XUvSxa/2OEAWlVyoMXjrDgTAMQjbkbl3buxAr/He1BdtOSGXtn6f6iNOG0AVB/CM3V0qlT+V+iWOWU9s8IgaWnsnVb4i8FoWiUgqNEiA02d9fDgCxA8RBmR5jAxvJ91nl67oomkiWU4bwFogXmaHJ9qPnNi0U8UYt8BJivrYQ78qbjH13xoacaGjmhM4Uz8ubE46mTKDNjIBFVjqjptAAr92Iw9BBcFy0TUPa5s2sdxk6JfMXl8wpRbvCQDbL8AZRvjQapH6ZKEYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cXX0CDlIsTO2ExM9hQVJ7wSo/w1QRnE03TN+g7sERTo=;
 b=ayA3U8mX5xNyyZavNqqpMNgVdfHgfUe6myjxnK/eZi59Hb87KhDdqdjAUDAaqYj4AFiVVvedd7sea8lHkYENsvnZjpezSGRzkJmTGEj7fESugh/fbObiPltD92fJHxroKv4YO2VXIV7i9PmWb2K61BbAke31jSdruzutNcRImsHbbk1QJxCifFyK29m+jES1lcYelohjgN04UKkldV1VvYC3GX2jheJpnemFbBGFevOnwBoPkP2XrBqIrkdPpYXpy+he4XAn1tpl06h0YPcug35WcYBzEQarORBMiFL+py+iLv6FgrP5OhiIec8JFvF3/OAm42yez4qJ3/QxgOb1BQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cXX0CDlIsTO2ExM9hQVJ7wSo/w1QRnE03TN+g7sERTo=;
 b=gcLy7aYw3xEXWiPE14zbglkeCzEFi86Z0QzvvvDbMnoR4WpjsQjR++jvCTAJpFOajotZ9S4F9i2VkSveCD0wlxkO1Z/dT6TLHbdSFXS0vo9rhBGK6uzpK73OXA6QHvKu3ZejZYd3RjGYTGSVMQ/W4JK3hy3gZDaiypYkp3VMPkd9VHJTHeVOgtyySKNBULUvpURwwDezA0E9H0JtC1Zr11Tec0/RG0ahwPTQBSlA/xqxh5LMv1Loir5ReCDYzc21NRdj2NyBfWgTx4pkrVtFhT4X6afOq+BlqsZPqtVr6tabgLincqTZ/hHmHi9oz4LOgiYrdrA20DY6M6PvwuxeNA==
Received: from DS7PR03CA0338.namprd03.prod.outlook.com (2603:10b6:8:55::31) by
 DS0PR12MB8564.namprd12.prod.outlook.com (2603:10b6:8:167::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.39; Thu, 17 Jul 2025 06:49:05 +0000
Received: from CY4PEPF0000E9D7.namprd05.prod.outlook.com
 (2603:10b6:8:55:cafe::a) by DS7PR03CA0338.outlook.office365.com
 (2603:10b6:8:55::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Thu,
 17 Jul 2025 06:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D7.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8943.21 via Frontend Transport; Thu, 17 Jul 2025 06:49:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 23:48:45 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 23:48:45 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 16
 Jul 2025 23:48:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeed@kernel.org>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Gal Pressman <gal@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH mlx5-next 1/3] net/mlx5: Add IFC bits to support RSS for IPSec offload
Date: Thu, 17 Jul 2025 09:48:13 +0300
Message-ID: <1752734895-257735-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
References: <1752734895-257735-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D7:EE_|DS0PR12MB8564:EE_
X-MS-Office365-Filtering-Correlation-Id: 62517491-d0c2-4608-e0b4-08ddc4fe05c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P9ufeSN9AdzKEmRU0UNMleSJH/nIVUnoEBLaL02DqCdc0qh7VbvEufh/Zaql?=
 =?us-ascii?Q?pZsrfqJ3L3LDC/vIoE7mX3Mb6Ov42F6yaOF7IGxDdKHwU1v+7da6Lt5qJCjC?=
 =?us-ascii?Q?sMabyG1grsCdlJH94V3U8x1m1e38KaSJDvuZQdE6qm1sMhULHWuFwTZOSuLO?=
 =?us-ascii?Q?MWEKSJtKxmdqouzSbK4UZYl44YyOrIM4s+y0xuLGsSEKh91jdFCpfopOkkZe?=
 =?us-ascii?Q?m4RfeWDcqeLQOBYf1n/km14wDg5BUClENPdtvDKTvX2Bdo+MJF7HEsiLDeG+?=
 =?us-ascii?Q?dcsPRk+OKY5wpJRGuHFztsICzNj29OdYqYPFZYvMjUBz6YajRBJ20Mp8+xBH?=
 =?us-ascii?Q?S97/faf28XwLIereeS9tz19g7kfPQ80XnCAWlZJ7M0PaqhPsA8YZMUzc0HQj?=
 =?us-ascii?Q?FJRxiZvdkfFYlVDJ0bqo7Bx38iUD0RfdG950AQyQeeSjtsMUedl4iH6yAYI9?=
 =?us-ascii?Q?r5Ay5QujgEKr2oszihw2VNjAPfA8jQ96eAo6fQvLbwHHKUdh7eMzpTpxsPXW?=
 =?us-ascii?Q?7XOWgHQ+rKEIuqUQ+J19qzgCub6+1Q3u8aLzgGyX16se+3FeP+npqgmZ6iwq?=
 =?us-ascii?Q?xNHzMsX8iHfCzePAE2EgDgc9KtD+My0aCtCupwlNS512UEy0Hc+q+sYDnZyW?=
 =?us-ascii?Q?17Y3IaxNxusJhoRmweZwZqyBy1ZZhL+xCv9NwIzvwYm7ouxJiVVJaA/GmPO3?=
 =?us-ascii?Q?Gizn6YQFVIfPTKwAqtGqqPD7Jx3kJ18HJde0kuai3zSW+2ZVzORe4b6Tnmq4?=
 =?us-ascii?Q?zj0uNf+VLHkVOJTFJnoZ2vno7uIudwK/rmE+MM3HfmbduWCCpCSYU8JWw+K6?=
 =?us-ascii?Q?pr45xJfO33YnImEHzU+aR08wmdJxMHfJdZNtsbOadkwH1vgzp6ZyH+z5U3Sw?=
 =?us-ascii?Q?d3s/jpR/74k/FgPVSQIG2thFuhT8xU89GOvBM8KWRz/DDWblgkzWCGy2S9ZS?=
 =?us-ascii?Q?Ktt9hYo5+8E3vXHuuugeBxEFl41/syvt4KxVlozXazB96tNVlJ01EFQ5DLwG?=
 =?us-ascii?Q?m+qF7zQNQgwEpdxgx0MRJwE9vbrJiFyihGIp7BtYl3hRX3N2F9TPF8AzXZCv?=
 =?us-ascii?Q?ZeoFxmucQFHgNghE4TbhcZI9+51SqF1z0gqkCIrbVslCYaK5ud3Oz9w58XZS?=
 =?us-ascii?Q?VkdU9WCJhpSebr31bevsiWcf2hh240ALngu5m7CIP2snMKoQAvqdGOf8Hac1?=
 =?us-ascii?Q?kw06+X8R9wSjwIa3k6vwqt5YXrR5TwiqghV6Z4fHVAdtvpU5Fkh83WVIQ7nB?=
 =?us-ascii?Q?jn0846BaylF56pv44AiGSfudoyRIVGnMrzDAXWtnfGOMacNau0sxXgpf5Lqe?=
 =?us-ascii?Q?dIRBKs5c5u3M3/sDpIkppZ8GidZzxURcahGhPbnDh60JO2pGrYfgS6uN4JRc?=
 =?us-ascii?Q?JNjOyAQJmlI1wvbkldJ4U8809sbF4x1qRfyZNTMpmVWXT4CjOB+6aMk289F4?=
 =?us-ascii?Q?n4445xXdgdTY7zluBzG0g6ltpwRqa6oS/sDED6Tsm6zpJueveZhI/UPdydgI?=
 =?us-ascii?Q?Kb2w5P7XpZhwzaDlvWWLEoRrAK4C6DZSOxMJ?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 06:49:05.2855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62517491-d0c2-4608-e0b4-08ddc4fe05c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8564

From: Jianbo Liu <jianbol@nvidia.com>

This adds the capabilities, ipsec_next_header and inner/outer
l4_type_ext fields to support RSS for the decrypted packets.

These fields are specifically for firmware steering. HWS validation
logic is updated to correctly handle the changes, ensuring the
unsupported fields are not set.

Besides, reserved_at_c4 is fixed to reserved_at_d4 to reflect the
accurate offset within the structure.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/hws/definer.c | 13 ++++++----
 include/linux/mlx5/mlx5_ifc.h                 | 25 +++++++++++++------
 2 files changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
index d45e1145d197..c6436c3a7a83 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/definer.c
@@ -727,8 +727,9 @@ hws_definer_conv_outer(struct mlx5hws_definer_conv_data *cd,
 	u32 *s_ipv6, *d_ipv6;
 
 	if (HWS_IS_FLD_SET_SZ(match_param, outer_headers.l4_type, 0x2) ||
-	    HWS_IS_FLD_SET_SZ(match_param, outer_headers.reserved_at_c2, 0xe) ||
-	    HWS_IS_FLD_SET_SZ(match_param, outer_headers.reserved_at_c4, 0x4)) {
+	    HWS_IS_FLD_SET_SZ(match_param, outer_headers.l4_type_ext, 0x4) ||
+	    HWS_IS_FLD_SET_SZ(match_param, outer_headers.reserved_at_c6, 0xa) ||
+	    HWS_IS_FLD_SET_SZ(match_param, outer_headers.reserved_at_d4, 0x4)) {
 		mlx5hws_err(cd->ctx, "Unsupported outer parameters set\n");
 		return -EINVAL;
 	}
@@ -903,8 +904,9 @@ hws_definer_conv_inner(struct mlx5hws_definer_conv_data *cd,
 	u32 *s_ipv6, *d_ipv6;
 
 	if (HWS_IS_FLD_SET_SZ(match_param, inner_headers.l4_type, 0x2) ||
-	    HWS_IS_FLD_SET_SZ(match_param, inner_headers.reserved_at_c2, 0xe) ||
-	    HWS_IS_FLD_SET_SZ(match_param, inner_headers.reserved_at_c4, 0x4)) {
+	    HWS_IS_FLD_SET_SZ(match_param, inner_headers.l4_type_ext, 0x4) ||
+	    HWS_IS_FLD_SET_SZ(match_param, inner_headers.reserved_at_c6, 0xa) ||
+	    HWS_IS_FLD_SET_SZ(match_param, inner_headers.reserved_at_d4, 0x4)) {
 		mlx5hws_err(cd->ctx, "Unsupported inner parameters set\n");
 		return -EINVAL;
 	}
@@ -1279,7 +1281,8 @@ hws_definer_conv_misc2(struct mlx5hws_definer_conv_data *cd,
 	struct mlx5hws_definer_fc *curr_fc;
 
 	if (HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.reserved_at_1a0, 0x8) ||
-	    HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.reserved_at_1b8, 0x8) ||
+	    HWS_IS_FLD_SET_SZ(match_param,
+			      misc_parameters_2.ipsec_next_header, 0x8) ||
 	    HWS_IS_FLD_SET_SZ(match_param, misc_parameters_2.reserved_at_1c0, 0x40) ||
 	    HWS_IS_FLD_SET(match_param, misc_parameters_2.macsec_syndrome) ||
 	    HWS_IS_FLD_SET(match_param, misc_parameters_2.ipsec_syndrome)) {
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 639dd0b56655..c9a7773ac8ec 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -420,7 +420,8 @@ struct mlx5_ifc_flow_table_fields_supported_bits {
 
 /* Table 2170 - Flow Table Fields Supported 2 Format */
 struct mlx5_ifc_flow_table_fields_supported_2_bits {
-	u8         reserved_at_0[0x2];
+	u8         inner_l4_type_ext[0x1];
+	u8         outer_l4_type_ext[0x1];
 	u8         inner_l4_type[0x1];
 	u8         outer_l4_type[0x1];
 	u8         reserved_at_4[0xa];
@@ -429,7 +430,11 @@ struct mlx5_ifc_flow_table_fields_supported_2_bits {
 	u8         tunnel_header_0_1[0x1];
 	u8         reserved_at_11[0xf];
 
-	u8         reserved_at_20[0x60];
+	u8         reserved_at_20[0xf];
+	u8         ipsec_next_header[0x1];
+	u8         reserved_at_30[0x10];
+
+	u8         reserved_at_40[0x40];
 };
 
 struct mlx5_ifc_flow_table_prop_layout_bits {
@@ -552,6 +557,13 @@ enum {
 	MLX5_PACKET_L4_TYPE_UDP,
 };
 
+enum {
+	MLX5_PACKET_L4_TYPE_EXT_NONE,
+	MLX5_PACKET_L4_TYPE_EXT_TCP,
+	MLX5_PACKET_L4_TYPE_EXT_UDP,
+	MLX5_PACKET_L4_TYPE_EXT_ICMP,
+};
+
 struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
 	u8         smac_47_16[0x20];
 
@@ -578,10 +590,10 @@ struct mlx5_ifc_fte_match_set_lyr_2_4_bits {
 	u8         tcp_dport[0x10];
 
 	u8         l4_type[0x2];
-	u8         reserved_at_c2[0xe];
+	u8         l4_type_ext[0x4];
+	u8         reserved_at_c6[0xa];
 	u8         ipv4_ihl[0x4];
-	u8         reserved_at_c4[0x4];
-
+	u8         reserved_at_d4[0x4];
 	u8         ttl_hoplimit[0x8];
 
 	u8         udp_sport[0x10];
@@ -689,10 +701,9 @@ struct mlx5_ifc_fte_match_set_misc2_bits {
 	u8         metadata_reg_a[0x20];
 
 	u8         reserved_at_1a0[0x8];
-
 	u8         macsec_syndrome[0x8];
 	u8         ipsec_syndrome[0x8];
-	u8         reserved_at_1b8[0x8];
+	u8         ipsec_next_header[0x8];
 
 	u8         reserved_at_1c0[0x40];
 };
-- 
2.31.1


