Return-Path: <linux-rdma+bounces-6356-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B4E19EA0E8
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68C51888937
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB1F19CD19;
	Mon,  9 Dec 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DZQ0WvID"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA6813E898;
	Mon,  9 Dec 2024 21:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778809; cv=fail; b=ne5HW1jDmUIinAos0N+qNFuHJP9ItdnbxtDXNZlAZnLcDLP3Qu+aCZHoQN89aO3Xku6jNKdlnRM2DEzquAngsyjGnvW/0NHkmjhKs5H1Myd/WdGVB3eJe18A3FIVTgoE6pOiAZP+SjepPzlSbeLFzn61TI0TsRxLOl/QJwi5BS8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778809; c=relaxed/simple;
	bh=p+f0Rc2cXt21kTHLqooaSn39K7o1wGJSQMQlC7VmNFk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AaE1y0gz4mhg5uLB6wuDqygKlBEB4LMdSNCNzDJE3qkzSFR3dZoRcKyDYROuzHd0ziGN3jt5e3wAsFkOIS2Ba0xnLqJ0ysP5lN4xbUJPRE/ii9zH703gx3j9HAAjxhx/xlwHq0CLVKMkHPMiHlIy08sOrduMwiuR90yjwniXqM4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DZQ0WvID; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k8nOb/rB0OFRMZh2w6hF3WRIRTACxPAXKmPkeM0Ho5xg1lw4ulH6ehdCn98+kG1NGefBVUoJp1Ij5JR589BtvfrS9jW1eyzkioCbUN3E/2O4m1EzLS/uMm+LE/Tg8CsaQYz+57/dLSR3MIHSDL7V+2PjPPAvnrKNDj/N4Xj6zQ7gk7uwP1xh62ZcGVoj2uGcejzcswrsUnUCNq9zysykkz6cQlpWGu+ZhfkbD/4c1KaA0+Ua17rb6os7WlQVkXvwxpk78yZ+/+bZU2aBtDM6ISjxQTIdKGOt6FwvhPmRgZ2GEcErCag5Y7gT5LhvyTOiCeYyofx9I+TAGqLj1ibmAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=A1B8oUR44/5irTZCcYe4/0UH/ppU4atnyJ4IiWE1vvkthlWwzD869NO2wPq6N4yGOWCpqDatFvdMDBCl8eSxfYSaeEwY32HmQzIFyb+kI2Dyezxl2mV/cQXiDybp9UbGo+zC1TJ++d6ADy4gj1sYzEufvAuLwtFf3IotLde51p64IgV0ybgQjd0iy407ZIhm7QsaDbRoZl72tjORiK9CEyJARSkXe/C4udS34R1/AlDj6OoTocEbS49S9IOyJ4GcHP7wLhA2MIsMTKKAU9BsyBApxnQQW+JRqUUaLExRr5SZuIWytpOTmwMlFFaswnQL0lboUizD0u7RooR+dTeIKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7HaYmOaPnhb5t6S6+OAIrA4j5fQBco6gkGceNj+Ws4=;
 b=DZQ0WvIDmXLqjfV9NuKQFcXH0lo4/B/E0T0+31ATU8jF/IOkevC0q0jNujjbEshdQHfMzfcBefIu5TVVtxMuR+xAuobc9RPJu6F1ccbct5dm21LWtU5yxm6ClJoA5/M6cw17nlhIcQfbdm/Lcy4p3GWPpKrtYHFZcOXM0CR6SIAKMZYk7m4oTxD+HQYxTr3wkYqgjU9TwrLdE+UmzBqqy06jt+3d0CMsKcDeXCVGFowYJw+IEQNDqkKqwhdQJ2KNFTLDSpRv+8J+k8Dix09wM30jXZI4x2U2WUElNd18sHawlcJbEukykK4PVmEAENu9ha3ZBhdcwfQsk+L508L6rA==
Received: from MW2PR2101CA0011.namprd21.prod.outlook.com (2603:10b6:302:1::24)
 by BL1PR12MB5852.namprd12.prod.outlook.com (2603:10b6:208:397::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 21:13:21 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:302:1:cafe::6) by MW2PR2101CA0011.outlook.office365.com
 (2603:10b6:302:1::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.12 via Frontend Transport; Mon,
 9 Dec 2024 21:13:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 9 Dec 2024 21:13:21 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 13:13:06 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 13:13:06 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 13:13:03 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V6 4/7] net/mlx5: Add no-op implementation for setting tc-bw on rate objects
Date: Mon, 9 Dec 2024 23:09:47 +0200
Message-ID: <20241209210950.290129-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241209210950.290129-1-tariqt@nvidia.com>
References: <20241209210950.290129-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: d5134383-35f5-4c5c-8f31-08dd18964f4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6f2BL2nc62rOFavtvsK29801tKdSWAqgBnCxiyIAZh+KzlTrcY85rer/xF33?=
 =?us-ascii?Q?kVtwiUwHkiSwmqormV5CQ9I9FHRXQ3LRhegTs9jZA3hzodZQVD34N4f3g+6q?=
 =?us-ascii?Q?jGsx6BqIlgXZbgBbDmLGOKT2wcgkAYeLZh6hdsYZSSIkgwUeJGQksWs3N9H1?=
 =?us-ascii?Q?RdWyVvgbVtQxXtWeJnG54SxUxMGSsbpRgOmM8t3Lidg0LSaR82Aj0UcjI/Wb?=
 =?us-ascii?Q?IBO3ZHIUgtzmzgwyWM4TZ+8YZXaKR6I6Hp8KF/aMOwfwOgPoutHRznDvRV2W?=
 =?us-ascii?Q?vvxT6l7MbyLsym/9nj3sM655O+TLcPOUeOPs1W5fcQcZ6DMiMrvkhm++t4Mo?=
 =?us-ascii?Q?WgYkEHPvngT9RWwLEvSGtiRMFdFnGQMX6onf9g88JVe9BdQs+l1TnxyoogoC?=
 =?us-ascii?Q?lVvEgIESj/rbvSHScYAJ3Dn1B/eAApsseLynzVpR51Enjiim/Bq2pCT+NnWA?=
 =?us-ascii?Q?sy7V8rfmoTuMjIUS6ZecMEQvzTlf8eOUF7VvVCfRR5TQLlj56f92pGZeEIsR?=
 =?us-ascii?Q?AeFiTVyXqhE3WbzigFeIVgnMd4iVr/ue5d/TZooPzT1C+eAoohQSzmMolK6B?=
 =?us-ascii?Q?gJNSW2O++oJ4FZG81jzSSXD1QMFAW/MtBHdui9L3i1OYAXq7AiCji2kX/vev?=
 =?us-ascii?Q?lFt4nkkRo+bvpZ9HXnk4mUAkQRqUdTCwAOPdLU2KmGx1kCO4Hw/e8vznUI/Z?=
 =?us-ascii?Q?don4B5h4hy9y1390NqbA0A4vPhcJZGEwKDIBXCgcuDuRKuEu5VQzTUei8SS9?=
 =?us-ascii?Q?99Vj9l4vUo0+jLEDTw/0KNjCaoCCZeRWX0R16NOYVI021FprKc6RU9TwvpCN?=
 =?us-ascii?Q?YVNsi9TlZ2DEXHK1a0hL20ReVhn/7UxPpohY5KoVanCq9iAP34Gbgsn8KXba?=
 =?us-ascii?Q?NmJBXHRjTxiAfMVnoKPWTI4JCWnZnXHTIfkopdMmjkkJHl+BnlLU7aE5qJmH?=
 =?us-ascii?Q?umAvmgsPwBJTsBGkbFYX6dHPVfrkjnN4dg/gfc9PI55hB9zwEDmniM7mxfMY?=
 =?us-ascii?Q?dnvatK3lKYRxSTEu6rdQ7Vem6p7gPxMPcZn0vA93JR8Qsit8axDjlxKIGnyN?=
 =?us-ascii?Q?7dDZ60WpbS9tkbdhBRK6JCMeUAitI/bzWST8qSOJmDrb4cEDggLLa7+UJ78F?=
 =?us-ascii?Q?gUsbkY7MQAw9fKrssZ9JI93tRwjUvkQmUkx0J+GNIaagNeaRn6R3WKxp0XOI?=
 =?us-ascii?Q?j9M6id9G7Zw+eBpblTCm0/qsHt2kUu0/lnizWdBAW41ARd+nfskwV4C6DM95?=
 =?us-ascii?Q?3r0jAJZuuyuKn+60NJrU/8pPE+kJF3ff6sut00D7hRHH01D+or+rb516oZz3?=
 =?us-ascii?Q?TFAwWJsAuEGtDrh7+GK5g1rBJy15drmvdkaC5H233rcPCpSVuBzoEVMVRe0k?=
 =?us-ascii?Q?nHVAQ/FhxBViebE10LO7j2LS0V/2ErZ46h5DUMwfxpPzm4taT4B2EYTmtiza?=
 =?us-ascii?Q?BFOykPHUHm5H4kgtsYdsd27HdeYcR0L/?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:13:21.0250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5134383-35f5-4c5c-8f31-08dd18964f4e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852

From: Carolina Jubran <cjubran@nvidia.com>

Introduce `mlx5_esw_devlink_rate_node_tc_bw_set()` and
`mlx5_esw_devlink_rate_leaf_tc_bw_set()` with no-op logic.

Future patches will add support for setting traffic class bandwidth
on rate objects.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  2 ++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c | 14 ++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h |  4 ++++
 3 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
index 98d4306929f3..728d5c06d612 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
@@ -320,6 +320,8 @@ static const struct devlink_ops mlx5_devlink_ops = {
 	.eswitch_encap_mode_get = mlx5_devlink_eswitch_encap_mode_get,
 	.rate_leaf_tx_share_set = mlx5_esw_devlink_rate_leaf_tx_share_set,
 	.rate_leaf_tx_max_set = mlx5_esw_devlink_rate_leaf_tx_max_set,
+	.rate_leaf_tc_bw_set = mlx5_esw_devlink_rate_leaf_tc_bw_set,
+	.rate_node_tc_bw_set = mlx5_esw_devlink_rate_node_tc_bw_set,
 	.rate_node_tx_share_set = mlx5_esw_devlink_rate_node_tx_share_set,
 	.rate_node_tx_max_set = mlx5_esw_devlink_rate_node_tx_max_set,
 	.rate_node_new = mlx5_esw_devlink_rate_node_new,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b7c843446e1..db112a87b7ee 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -882,6 +882,20 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 	return err;
 }
 
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on leafs");
+	return -EOPNOTSUPP;
+}
+
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
+	return -EOPNOTSUPP;
+}
+
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 6eb8f6a648c8..0239f10f95e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -21,6 +21,10 @@ int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *priv,
 					  u64 tx_max, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
+int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
+					 u32 *tc_bw, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack);
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
-- 
2.44.0


