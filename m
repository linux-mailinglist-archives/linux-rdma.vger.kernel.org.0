Return-Path: <linux-rdma+bounces-10074-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67654AAC291
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 13:28:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87A5D1C28318
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 11:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84F027BF66;
	Tue,  6 May 2025 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QsFmeae+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2042.outbound.protection.outlook.com [40.107.100.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B838327AC38;
	Tue,  6 May 2025 11:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746530860; cv=fail; b=my2qhegNMNQPLFanu20R3sJm4pg68yGVKgrVIoq1DE8W0lw3rNwZtHW1h7JfjPp+/tYcK068gDDcjKYxXXjENqv10spIAy8RpjMZWzumNvHxoAw6EIbdET+ne7z/vkRl1rF/UdKAteM2nROvuyM76k45vgvy7gFzHSQocTgCeWo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746530860; c=relaxed/simple;
	bh=Te1qEdlgvowDoGwvowaLWk6OdMjCp6ayGmekHU/Q+oo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VKIlwFNF/aQhHQ3dFwWwpES+8OoAC0F6mQ9+M72czRsjSkMGTdd78+NIuDNWby4cUt+pfXsuzl7Cah8Lbcba0PC0U4u61Itrqd/1ADipCalSoKXaTp5uVNvNUbthmVjWYKdgf3HKAuUa6NteG65OfhYoaoRmV1kRRy0aWLYktco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QsFmeae+; arc=fail smtp.client-ip=40.107.100.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qvo9lJZlQyu045lbGBI4k+A4dBbwXmRT4+wBGss7Fwyl47bvrDTyn+UxBZZil0/w4ECWGNvdKXvS/SwNk+4Za4PIlslTUuhK8J7lAsNH3fwnvbsTw+RDIBbVTLx1hblQsfxUGaMMRKuLMUftamLFHDLeiKx1cgqK6hTbo3qVKrpBE4wNJZBR54plFxxepZ/pCCoSk92arQnxHmTAluNzo7Vwx4sPc1pU514h+5bptFsc97Zo0IHL1gDr/W1RJyntbBQizxEhCsO8HuCbBF7My31achKsNhhvJ7/EooeJJzTXvebqWtm6bdvyGRzOQgjXkmyGfECdupm/qKQXC0Yczw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M/Cc1Ca5Hd2X09GMSLP3D3QneVtydXPAbWn22kqPAiw=;
 b=tB6XAx5fBB2jXxSZUDSVadX87gCdxJuBV0ZcVIFnfavl3qgHbWbnWX1HRqrvQU1yJ3+kcCM5CxyWmI9mj60Ov3uzWex9BLBmRDDoZsOGgmkY0Ml6j7z7EYNIfLtwsWpXlLzYBKOrmHY5xUV9gMXw9dLPY9bvDZUhkXF2VK9K3UIA3MsN65QT4LK0UcMH58J9m9twsbISyTLbvoVA5lDJjh9slhBC1efrOJZj5g+GTxKiMotPE/gJ1GuhGrXmvwdkkvHiRHRrl2yfAnRGinUgqKQBVJY5f1+ptMUwjGM453KQVP+cLOcVSqP5b/IkjytVvJClBEhiExHXHVj1v7Eg2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M/Cc1Ca5Hd2X09GMSLP3D3QneVtydXPAbWn22kqPAiw=;
 b=QsFmeae+h1atCxp2JX2khfCzeK1dxKR2jpPS/J995lz8Kl5DEUDd+9PeV9K2ACdSrxg1oqGidkuykxrv6fFcfXSYvFXX69Ppny4mnXAN6KAJiVc/TdqegAxMnOpMFw5tKfiF7atgoV2of2B4eEQGcIZlk/0qbAMLdHa1DXCRw2BtP6afHcnK+BBuBVAku5GxZVs0kbvNC7/cNh7OYBCYUuTsdXfIvqkDFY1IYTXHuyyyTTRBOkFTVoUyvgw674pGCMiAhnftfhwIKaiPGaFX10cT4z5AtJSPyuvCCEISIVzeDly67SXjqDfgmD0w/os8It7oi8vVdy0aUeZKJxaqzg==
Received: from SJ0PR03CA0177.namprd03.prod.outlook.com (2603:10b6:a03:338::32)
 by PH7PR12MB8037.namprd12.prod.outlook.com (2603:10b6:510:27d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Tue, 6 May
 2025 11:27:31 +0000
Received: from SJ1PEPF00001CEA.namprd03.prod.outlook.com
 (2603:10b6:a03:338:cafe::49) by SJ0PR03CA0177.outlook.office365.com
 (2603:10b6:a03:338::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.24 via Frontend Transport; Tue,
 6 May 2025 11:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CEA.mail.protection.outlook.com (10.167.242.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Tue, 6 May 2025 11:27:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 May 2025
 04:27:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 6 May 2025 04:27:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Tue, 6 May 2025 04:27:16 -0700
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
Subject: [PATCH net-next V8 2/5] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Tue, 6 May 2025 14:26:40 +0300
Message-ID: <1746530803-450152-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
References: <1746530803-450152-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CEA:EE_|PH7PR12MB8037:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a2c94ab-3e1b-43c5-404a-08dd8c90fd75
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K9SlgPC4zk66SX7E1D6oKTAeSwMLiQfYWRTgJrPXRCPy5Jx+LDh09XnnSXx7?=
 =?us-ascii?Q?jHomPzzFSEabDcqBEvxeq64pFz7ZQz4ZFhyzvdHarJdmg/2mK7XLKOJLT5Nm?=
 =?us-ascii?Q?3UJ2C+XIZdp2E32dsgJASmIvQ/Pb7BcplHCbUNpT6yFj+X6cWzgJcRNBR7Of?=
 =?us-ascii?Q?TKgMkeCwEfAKyKyVsf3zS/x8t2wC8st6caK7dOEq73UMaH9x8VXKDX4L+F5T?=
 =?us-ascii?Q?buHvTMR6Q7wp5wMZ/CmXD8J1TwDi3M0ILAR2vG2BZGmN9Rh3n04RPGZ0sdmU?=
 =?us-ascii?Q?WSCWn9qbK6qKYHgRB/oDASjELTStDbqCBeVSv6LV7EVciifSO04APqxYQSKr?=
 =?us-ascii?Q?Gp1zQlkRF66oliKYOGr7N1DgyELkTiN2c9ldyGBXZE4N2odZ0kmjpQTkFjaW?=
 =?us-ascii?Q?fMaG1TQyFtd8VIZuibXIxdMfypUJ53fjZbZ0NpniueUIRYjqvTT3QE7NDEMQ?=
 =?us-ascii?Q?bL6ByR28MhkoQwL5WvvhyYOrMNkrg7muYJjTNobgf3D75Jr0q6k5loYAvclg?=
 =?us-ascii?Q?7JGqELwhQEXSJt/ToK8CwZgqjR5EKv3YzF7phQf43tJe+k+DYeceiYYzLAuY?=
 =?us-ascii?Q?n0FigNlBx+MHe2u/sGSW7HrebW+HXkNdQrg/FpjHQ96MHT0eegHDoc96uDkB?=
 =?us-ascii?Q?5P26CT8xuwY/hQaugRWYmt58YCQ+EFxbbYBfCryD6GEreo1b7l6pg1IDO+JA?=
 =?us-ascii?Q?i10PLsPQYl5Jbfs/fL5+UJKksjRkLC81Ul1fKWPbF3vZozg33ZgypVm7iOy8?=
 =?us-ascii?Q?d/uAygn5tSLJW//58LbI0P952hXoDkYQMvfeTlKWPXFYPWC0VxEK+wi61aSM?=
 =?us-ascii?Q?LUsFj+9lpFJlxHyEOks0DlwNwZmJarNujegJwEkr2CU5Rr00wzqb1XYlQeHt?=
 =?us-ascii?Q?vR19KM+XaA9YEnOQa4PgnFd++T1a9Czsy9GyzJn8AOPNUauM5CGzEOYkwJpB?=
 =?us-ascii?Q?sgxUWFvHK0eu/0rPM7K2ImYHLqphdIoD0VvvotCVibqaM9LbS9RpSDx6AGNw?=
 =?us-ascii?Q?6nV78s3waMTIbw26Sfwk4bWpIVLPeS7LXUAscY+bakSJylh3YRL+vIdctAQL?=
 =?us-ascii?Q?zYJ1iNb/Aop7J1++b6IxRdWb00NfqO8MzLnRQx4H2tBOwuTJS7TlA+7Hcmbq?=
 =?us-ascii?Q?PhLjB1267mcxkFeodF70rtiECrBtEvSS15eAo+1V2ujbQkkW+dlGgRw0ryrW?=
 =?us-ascii?Q?UX67HrInvN89rE3vl+vUz7DwsIizzjuYToAa3tTr0ahSIZO367bQRHy7UinN?=
 =?us-ascii?Q?r5+YmaBStezLWovkEmt3MupV8R7kPu8dziVOQIHx0/RjEpgp3WeX1Lgbzn/t?=
 =?us-ascii?Q?sM029oJdvTNhkNF3iqCRawVqE85GAkjV89VlalA++khInoM/wgOEbFNle337?=
 =?us-ascii?Q?+oyheIhfOHL0bqCNADpk/5MvHy26pIQcznU0qP4ap3WFT+T0AOlG7KWPx8Zs?=
 =?us-ascii?Q?zRuUmE7J95+xfe3C20CXJL+EIIqcHF1Sz4NIkb/nWK9IVez6Xl6MV1yX++bj?=
 =?us-ascii?Q?U55j9RdT//cnbnsaQ7ejw67IVKUSw5tvceJn?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 11:27:31.1705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a2c94ab-3e1b-43c5-404a-08dd8c90fd75
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CEA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8037

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


