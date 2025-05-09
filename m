Return-Path: <linux-rdma+bounces-10181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D201CAB09F2
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 07:50:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10C47BED26
	for <lists+linux-rdma@lfdr.de>; Fri,  9 May 2025 05:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EDF726A1AB;
	Fri,  9 May 2025 05:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fSM76r+P"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2044.outbound.protection.outlook.com [40.107.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522326A0EE;
	Fri,  9 May 2025 05:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746769789; cv=fail; b=UPuvMP5MFxavyglEXHFfdIRDpWp7gmLul2L9jGWzvnpBOCQgStyvMT4sObSiWiDn9Hjf84utJEBqmPTfrl3LycRLL6gseIQr5A/mZCM7zHKI/k8wFlqP7ZpFahym02RVYRsEjQWWwRnZFkJBSBjXIj/NQ5FGoc0g7JWUATSfcOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746769789; c=relaxed/simple;
	bh=Te1qEdlgvowDoGwvowaLWk6OdMjCp6ayGmekHU/Q+oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tR7/lMw8tsJ44/teFODWJudoiGI8QU5GKvkWojH1ZBuuZ3Qbduz5hEtl4lyRncTXfWpSmeR0i9QWbsYiXRa457g8Io+2kDW4qGXNk7EvZSPT6TUxP3XN4tXP360sIe/lPj1b3RIH40DKOGbSh/drccO4EF1T1pJT2fkpAEgkoEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fSM76r+P; arc=fail smtp.client-ip=40.107.220.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lu/3MAca+3AsZ46MNCo6kxcCeL8kQuviAI1LHWbepUIAx4i7HKqhLnA9IlUB0xtrSqlt9X0fIyVMhsHGMBZx5/nMnEE7xiCT38uQgaptZ4DtjD0RcEdsN/ZLtiVExcrE80gtMTIHV9eiVPdHngST4Rs8hJ5300lCwp5GVFTmjBP86xT0rRw68LeyEoSAafb8tDgMU4QR16i7c4sQzi6jsUqtN2c68EoQTX5SxFdGVZHL/xQqPYctiw341YBeZ3UaKP/yFyaXkqYeCDJPYBWMlKC5dSKQvla2zp3SKUDxpcv/SXLJ8cXUbs/58ajPpb/4B/2ylIzftVRKF2yAawn9uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/Cc1Ca5Hd2X09GMSLP3D3QneVtydXPAbWn22kqPAiw=;
 b=qPyNWYiUi3m4NykBLv1lgMq5rMLmpmBEto5oMwo+SZMYxO2T1EbleCwSWSoxlnyL3bJXyQmpQHJ+PmU30+P6KHYVuHsgDNO3L85jtmecntT3C3xqj3ok3oUxLbA6Nd/tWip3hQNPQbPXd3MOjjEiNWxr7t/9q9PTSz5I3SGK+lWghNEktkDTqxO154heAOhXxOPWS5gGZ2KL9mNFCVP6cC5Aud3wNe6WRxMc9wtjBoBuj/YoODLfnFRmi2mxniD2yBvrFdKdS+0wTu4uM8sMZg1xIErCOf9+ljiS8qpj5OkkfT61VIKCsTK9MJeB7UUKukJYAMbcCtHOYyVMIt8Jow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Cc1Ca5Hd2X09GMSLP3D3QneVtydXPAbWn22kqPAiw=;
 b=fSM76r+P7zWOhD6Ia8XTVJ1I7AQTMx/9LotAIhIsHDz5lrDgbwZT0xOspT+1gqJLpwa9GUXD7LGGZ8c6iSWE4SRR2ySxshOtChw3W3Dvtw5THq2lkCK3mEl0oMmsUGAhJkhGauwEqHdLVSwKhJj3J7AwajCw9yuJWyXFIFUPx5Dj+LHX6bEN2mFb64rKlkNMliZ7w01KRZaj7UMyCuD3Mn6Ov92Y1SL86IIkajfW7B+2xp82ZkYU6LRghUytD66XG9f0NapQGm1DAwELpKDXuQ96Xa158dhupVRBBjwQbp97WpKev5hh+gnzOjxw6ZSO+942DWGrrdCJNMEBxvJXSQ==
Received: from CH5PR03CA0013.namprd03.prod.outlook.com (2603:10b6:610:1f1::11)
 by CH3PR12MB8511.namprd12.prod.outlook.com (2603:10b6:610:15c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.38; Fri, 9 May
 2025 05:49:39 +0000
Received: from DS2PEPF00003446.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::6b) by CH5PR03CA0013.outlook.office365.com
 (2603:10b6:610:1f1::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.20 via Frontend Transport; Fri,
 9 May 2025 05:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003446.mail.protection.outlook.com (10.167.17.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Fri, 9 May 2025 05:49:38 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 8 May 2025
 22:49:27 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 8 May
 2025 22:49:27 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 8 May
 2025 22:49:22 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Jiri Pirko <jiri@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
	"Jiri Pirko" <jiri@resnulli.us>, Jonathan Corbet <corbet@lwn.net>, Saeed
 Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq Toukan
	<tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Moshe Shemesh <moshe@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>
Subject: [PATCH net-next V9 2/5] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Fri, 9 May 2025 08:43:06 +0300
Message-ID: <1746769389-463484-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
References: <1746769389-463484-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003446:EE_|CH3PR12MB8511:EE_
X-MS-Office365-Filtering-Correlation-Id: f1badc82-3c18-4906-0ab1-08dd8ebd4981
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2iZ9RBcVkYLAOK2PSnv8G3HZEn6IP1lnWsUMC6xzIktcuJzhFNBJ6l0igH0Q?=
 =?us-ascii?Q?yKvXQu+BvlClKsIQ1kmZ8L1L2Cd6PHu9cka3btlbBEhzIlFuI5TXiFATRlky?=
 =?us-ascii?Q?WNk7J8ch7g4RF4hiC30mqxmdDJiQVHKKID7PQye39i+KSIv50wbWQjhOUG+B?=
 =?us-ascii?Q?pEBr1su0ZvsXhRgXAGdLs1xwvZ2Pz3upzgga63TzvXRaxGnYNdnpSxNXY+eo?=
 =?us-ascii?Q?LHUPhkAJO4t5K0nxVNKXjt0Nd/jOf8wNfy2/A/KDsK5/vPQMKhHc9mQzuP2m?=
 =?us-ascii?Q?S9AA49vEKC0XlbwDNWMX9Rf4NvXUCh+/t8Xtyx4pCAjEgH/uFOkpxmieAj2a?=
 =?us-ascii?Q?3/J8/WIAzC7zHIDnHbCtfvppPynfHyWWxvmTMnWKrpFAUkEWlyTfv8TrGT2V?=
 =?us-ascii?Q?CAgOS1/p54hsJST2mnCA2qvJtDM9dplKD8GsMhWzIKqAorhS4ipBnvLrR9LJ?=
 =?us-ascii?Q?Ayfb+npRYpMn5HrQvqHkq5fjR0VivFOx7QEwQlG/UGLKS/JfHan4O+Eu6TT6?=
 =?us-ascii?Q?d62JYcYO9hxCNyskg120qhd+DLypqZqMwDzoQ7VOiUzJD198nROHdk4G96rl?=
 =?us-ascii?Q?i3hKgVq7bBbHxGqM4df3yRfwwdTCtwe2kGKB4MTRiFhSiQ2+/K/DJFQFMo1S?=
 =?us-ascii?Q?zaphUTnLt/dOZD0pC8lIvmTYboEPPG3poYkv/Q78RKULP8BuX6K/X1/OAchK?=
 =?us-ascii?Q?VgZQZmrYYPtqg/WRearLJ0lGgf07wsVP2/i5XA2yGtjT+ETU2gg5NDcqMlP/?=
 =?us-ascii?Q?o/lPdqs1rqMIBL1Sq/U3UMMSOsrxgGE+/grPQupcSOcUm5MdbkOmtl6t5r0g?=
 =?us-ascii?Q?nMOV3oLGQxCp8JXdg7GkIV+YMmQR75eJWV51tv0uo0wuoa6SHHAxY5XyxEt6?=
 =?us-ascii?Q?DEyjAsShAc925KjH6Jv/PdVkm0Nnc+2hbenuqHxHpbBqG6wVyQ2YdXC593/c?=
 =?us-ascii?Q?JqV2SRNd26l6pMC6e8lJR5Re6bOvoOwTbML/klCcLAINEJYIKwj6/k1tSr54?=
 =?us-ascii?Q?pwiZ4/PSF1/DQIqO9U1e1PBA49xLJ5WaZZb1KIdScWZeZ1A7j6vQvqU4vWzg?=
 =?us-ascii?Q?JPDhgV5RsG1dVs2gW+nJxmNP7/cftKk/up1mZog0yS8EnvgwjYKe7LtbuCvU?=
 =?us-ascii?Q?THVJJjtznsQ0I6tT5aIR55R8q96Vz4kKlpSTkAkK4h6AZc1Ojbie2d6+mLse?=
 =?us-ascii?Q?ruKPD1c6l6m1kN0yLZ5RGmhWgksnes3a/8K3jS90/x0nQSM2p6wQ885+XbKp?=
 =?us-ascii?Q?I6haklFxRUhSJYv/U/uqSDvlWAL6KavET8uTnUFKZwgHzdMsryoe7LCLaBmH?=
 =?us-ascii?Q?1fp7mAYKp5tIm78LG+a+U+LVNe48tvFYzUcQD7SAeMSMqXVwdRkKsOVYXSFD?=
 =?us-ascii?Q?zYtcCtA1uXLLfyCqdcZmZqYe7FwF3YoVFQocLA51hBmR6ylVjufEhMHgZzAM?=
 =?us-ascii?Q?agyv+8obCI417x/P38OBs1h7rqjmwvrNxMSKbLrU/bdfb4A+bYXWV6h4j9Bg?=
 =?us-ascii?Q?zk/j5PwgJRXGwJ9daO4hSFHo6sjJT71XnqjB?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2025 05:49:38.8623
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1badc82-3c18-4906-0ab1-08dd8ebd4981
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003446.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8511

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 20 +++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |  8 ++++++++
 3 files changed, 30 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 73cd74644378..47d3acd011cf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -323,6 +323,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index b6ae384396b3..ec706e9352e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -906,6 +906,26 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack,
+			   "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack,
+			   "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index ed40ec8f027e..0a50982b0e27 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,14 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
+					 void *priv,
+					 u32 *tc_bw,
+					 struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.31.1


