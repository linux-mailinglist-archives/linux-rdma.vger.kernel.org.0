Return-Path: <linux-rdma+bounces-8129-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC200A45DA7
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:50:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D29E7A5144
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2D621B192;
	Wed, 26 Feb 2025 11:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ds3jURjS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2053.outbound.protection.outlook.com [40.107.236.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151B82165E2;
	Wed, 26 Feb 2025 11:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740570534; cv=fail; b=uWM9PBb1pCvGw+2/q19Mah0WB+FcpmiAig0OZVKdaapaNdz76SbDTGkRA/Avfs3F4LCoBaPvR0fcqYWJ2v8SClP7LeK2HbE32e2vTL26xk8qcHvqPSeWXjGPEDw8x9THvUXWGvcKUW7mD6rdinasZynWuMu8oN+U3UC4rRnsIGU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740570534; c=relaxed/simple;
	bh=wI3JCIRvePove8PzuCn8NYD2ezzc97vEBzlvPd7W2uU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YZUc805u7zHEq78LesXMbe5D6CV4rFyh7T/t1gY8D4j0jheXMgsGXNFfDUdjNATQcoRM9niyOcRNGdJebuk84zloAm0/6yXFjK4NVBTZkAh0nraY0+OewXfMbYKgLpHcFh/mAXJMDsfav65neQe3eki4xbDd5YrN31jdUz9np6k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Ds3jURjS; arc=fail smtp.client-ip=40.107.236.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMWOy3Vu+bzmPoUY2+LHyKjVGCrhhvPpwdlTd7lqrctiJBXvBAuo+xINTUsTQ5rHP33sl9UkV2sdBQqInbqivf4LO4TZxhxcE0ir/P+puKyxNWdKCmqH+yeMAE8wHrTJoDt4f8Z4Xt3hZet12nTJ/MFjZfCykaLlOIeFqeshO49Aztaiod41sigb07D4uhkowg1nAGsvk9xqyyHNakWcyI5HHsxb/pYTyDsAackxW9KWcEfWzV/aY2rvqRw1XN0eny/xSTaMINLmrYhgobBiYYOEseQ2SAaqkXJZNT8aC38+x8WghBeginpON+dwMWO5B7Hs8E5GmDZlT1LOK0eEiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=algvvJySy48jEiyV3tDYcf4Pzn3S3jS7kj8dLxhFUBo=;
 b=Id9em8nqibYs2l7luY87jwRUpFQ022O34j8edBI+j+ripkpImGyjo47UxxmBJBIGrP3WjnubbRqkKXe899KYRwQc1pkBOsEM1hWYEnVkJ1i8NQ+1C22DV+0XU/ALTnOvVuplW6rBI+/Mh4sg5D4uj4goa9/74LZbqwEjZCrH/wsbIG1VUXBCVKLos9IVtE+kdW1DGRYX6Kl+819zJTYOQ8lNl85yruCUky+IQN03FiGv2Tb2l7IERnE/qzQaHsRksSgQ8IqYcZpFWrvMGOiGOO7/aTKzNy2YXQDFb/VpNa4E13z195IRyGZeYquRMAXQ2KqMKGCv4IXNvyKec3VIiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=algvvJySy48jEiyV3tDYcf4Pzn3S3jS7kj8dLxhFUBo=;
 b=Ds3jURjSc/Q6sakcrjk8WSyHYSLsTwzEeg3H+QwkEx33FOqjBU+u808PwiKLLVhuAOphQmma8sakFsDmxdGBtDYsEoYrGijzAHzvSrqt+filnsKxZn4QqVQeZSMEBj/yzxNm5PyA8t6wfpVSS8rdFrUWZpU7e1dQ1XHTO82aGa3g8lTDnYQrVg3cVvQy6yX04OqppUKpYc8LqM/PGc3piAmuqSclOjgSlPYyPpHheGGh1tK14cEXvmMuga/9rJoV1d6lcWbZctGB5Er5PDJNMMB3nP2wPqb1TWFJKnKU26bC13MoewvD0eUBmJcQFOiMdSK/y4h9cw7WKQfXKW9vxA==
Received: from BYAPR08CA0011.namprd08.prod.outlook.com (2603:10b6:a03:100::24)
 by CH3PR12MB9219.namprd12.prod.outlook.com (2603:10b6:610:197::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.20; Wed, 26 Feb
 2025 11:48:44 +0000
Received: from SJ1PEPF000026C9.namprd04.prod.outlook.com
 (2603:10b6:a03:100:cafe::89) by BYAPR08CA0011.outlook.office365.com
 (2603:10b6:a03:100::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.22 via Frontend Transport; Wed,
 26 Feb 2025 11:48:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000026C9.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 11:48:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 03:48:33 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 26 Feb
 2025 03:48:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 26
 Feb 2025 03:48:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 3/6] net/mlx5e: Enable lanes configuration when auto-negotiation is off
Date: Wed, 26 Feb 2025 13:47:49 +0200
Message-ID: <20250226114752.104838-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226114752.104838-1-tariqt@nvidia.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C9:EE_|CH3PR12MB9219:EE_
X-MS-Office365-Filtering-Correlation-Id: 0cf614cc-6b99-41a1-9650-08dd565b85b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6+zOgjbzkFA69LA8eOWIsJLaXRbiMbsnL98yyRd9JlK7nwyGe+kl33rfe/sO?=
 =?us-ascii?Q?AiSeN8nyx5eXtRzAJv6jueX6j3cxc/eXOk/QGjAAU5ufdMAGqQ+sjAkCq6zE?=
 =?us-ascii?Q?hLu2Nr2QV6UwN41l8jOEO/2zcKr+052vfDkuVYujU7eX/MNcrLJZ7Be1j6EP?=
 =?us-ascii?Q?PZFU9rV1MwGxBIkl+dWuZT4kZWd0FV4PERM5BUveVyylMtmWvtUINyNP/8XL?=
 =?us-ascii?Q?0dIrrITYcOv1sdGVrWf9EgMt2et77B95xjkUu9JjEF9/MSplZlJyU00tKjNY?=
 =?us-ascii?Q?2QWPFjsqTnPVs9LPysVWry6Zn0JNXcW+RSRXipMdejhGis0TyMwEsAmnUtgB?=
 =?us-ascii?Q?sqNLCQM+Es0pURwF4GugxwPqWpUrPu9VerS26517OJri0Rbaw2BOmBthwbah?=
 =?us-ascii?Q?EdZrDjuYSbz6c1/PHjYkmkZvwHRqhD8g9y1QdaP9gttGGBFSIqtuNocYoqTO?=
 =?us-ascii?Q?80gR+v49r68pNU9taB3eYf+P41c+P8ZrlFYPx88vn6b9ElVnWstqibAP3sAA?=
 =?us-ascii?Q?wYzvEnDsUpAuC4IfcFgPiE80gg996ZEYt6lzBRkChJv6R2l9CB52+Z+LHADb?=
 =?us-ascii?Q?bupu2kBwIQJz5lb5s0ynWl/yPK3ZhPgF8ZAORJrHCy5El9K3ISS1ljeVF8v0?=
 =?us-ascii?Q?Rskeud+/n2lzT7tSLHSuAzKm1WuAbX6dnxx4Qktb2JDZO7PodsgS34p5pzL7?=
 =?us-ascii?Q?eKLFd17VGxTyDvQ3yMwRfu1UERi0SkQtqBxzgoEaPilPK/KS2XUx4RS11lNa?=
 =?us-ascii?Q?XR1qM/Ve1JbkFdyQj7YqagmrFV8E+f+0zY9D0BfU87ovDdmDAuBogLo1rOmN?=
 =?us-ascii?Q?PHiOXCruoppd4spsBwggIPCLJtwPRn1cD+jD8cGyi451IBejskLT0SqZIW2k?=
 =?us-ascii?Q?QNRGRTtXfhyRWkJT5DPDcvQmjs54smMt3eu/RsZklT+wIS4JTVrGjFVBKXrX?=
 =?us-ascii?Q?aOCN+aNCjX6iiSTqls9M3cr6GK3hFOjYygFr2Ur2w1PNn3GB+JvJ5nXlh0eP?=
 =?us-ascii?Q?VAMCroFtMii86OSjyMt/e3O9rGr+bTu5GSpRmhjgZwZFE6Wwe2UlEJ2pjSFm?=
 =?us-ascii?Q?6u7Iz7tRfr2GeRJqJ/LAiDH5Ax1es1muDOltPaY/WXyNDsK9rQSnVnqMLqY6?=
 =?us-ascii?Q?+SDqkr3ZLoHFLcIC6f9WfKTckD2ON9TZCm/qMlveSPpQniB0SLGHqmVKfWqY?=
 =?us-ascii?Q?CaAI+FqoaFZasuJ1/5y1X5RePC4HIaa16xwh0X0puRpnDKKaDs0H8/ARyYck?=
 =?us-ascii?Q?x4F7Z69NkFkey/GN4pwwucIf/6j6sC/fBsBJv5cPtWXTSsDbXQU2D7UJzrML?=
 =?us-ascii?Q?Jacut3A6Z44W+Vb6JvINworZ870nLG9feI/8XjKC7Fdqo8J7L9yWlisaWvFD?=
 =?us-ascii?Q?jxr+M+dZjvPBd9fRiWUWb1IGPZV/aR5qHtcfcmQaKbmfuSwpHMqtQqE1SS00?=
 =?us-ascii?Q?foLyT/jw0SsXlfory3iUGUKZebLcKf/KUMyy3tZRkkWMEDUYrJm+hX2pvT9G?=
 =?us-ascii?Q?5afGDuO+k2QVMG0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 11:48:44.0420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf614cc-6b99-41a1-9650-08dd565b85b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000026C9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9219

From: Shahar Shitrit <shshitrit@nvidia.com>

Currently, when auto-negotiation is disabled, the driver retrieves
the speed and converts it into all link modes that correspond to
that speed. With this patch, we add the ability to set the number
of lanes, so that the combination of speed and lanes corresponds to
exactly one specific link mode for the extended bit map.

For the legacy bit map the driver sets all link modes correspond to
speed and lanes.

This change provides users with the option to set a specific link
mode, rather than enabling all link modes associated with a given
speed when auto-negotiation is off.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 20 ++--
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  1 +
 .../net/ethernet/mellanox/mlx5/core/port.c    | 98 ++++++++++---------
 include/uapi/linux/ethtool.h                  |  2 +
 4 files changed, 66 insertions(+), 55 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 9a1b1564228b..77aa971a00ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -1076,15 +1076,16 @@ static void ptys2ethtool_supported_advertised_port(struct mlx5_core_dev *mdev,
 	}
 }
 
-static void get_speed_duplex(struct net_device *netdev,
-			     u32 eth_proto_oper, bool force_legacy,
-			     u16 data_rate_oper,
-			     struct ethtool_link_ksettings *link_ksettings)
+static void get_link_properties(struct net_device *netdev,
+				u32 eth_proto_oper, bool force_legacy,
+				u16 data_rate_oper,
+				struct ethtool_link_ksettings *link_ksettings)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
 	const struct mlx5_link_info *info;
 	u8 duplex = DUPLEX_UNKNOWN;
 	u32 speed = SPEED_UNKNOWN;
+	u32 lanes = LANES_UNKNOWN;
 
 	if (!netif_carrier_ok(netdev))
 		goto out;
@@ -1092,14 +1093,17 @@ static void get_speed_duplex(struct net_device *netdev,
 	info = mlx5_port_ptys2info(priv->mdev, eth_proto_oper, force_legacy);
 	if (info) {
 		speed = info->speed;
+		lanes = info->lanes;
 		duplex = DUPLEX_FULL;
 	} else if (data_rate_oper) {
 		speed = 100 * data_rate_oper;
+		lanes = MAX_LANES;
 	}
 
 out:
-	link_ksettings->base.speed = speed;
 	link_ksettings->base.duplex = duplex;
+	link_ksettings->base.speed = speed;
+	link_ksettings->lanes = lanes;
 }
 
 static void get_supported(struct mlx5_core_dev *mdev, u32 eth_proto_cap,
@@ -1236,8 +1240,8 @@ static int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
 	get_supported(mdev, eth_proto_cap, link_ksettings);
 	get_advertising(eth_proto_admin, tx_pause, rx_pause, link_ksettings,
 			admin_ext);
-	get_speed_duplex(priv->netdev, eth_proto_oper, !admin_ext,
-			 data_rate_oper, link_ksettings);
+	get_link_properties(priv->netdev, eth_proto_oper, !admin_ext,
+			    data_rate_oper, link_ksettings);
 
 	eth_proto_oper = eth_proto_oper ? eth_proto_oper : eth_proto_cap;
 	connector_type = connector_type < MLX5E_CONNECTOR_TYPE_NUMBER ?
@@ -1366,6 +1370,7 @@ static int mlx5e_ethtool_set_link_ksettings(struct mlx5e_priv *priv,
 	adver = link_ksettings->link_modes.advertising;
 	autoneg = link_ksettings->base.autoneg;
 	info.speed = link_ksettings->base.speed;
+	info.lanes = link_ksettings->lanes;
 
 	ext_supported = mlx5_ptys_ext_supported(mdev);
 	ext_requested = ext_link_mode_requested(adver);
@@ -2613,6 +2618,7 @@ static void mlx5e_get_ts_stats(struct net_device *netdev,
 }
 
 const struct ethtool_ops mlx5e_ethtool_ops = {
+	.cap_link_lanes_supported = true,
 	.cap_rss_ctx_supported	= true,
 	.rxfh_per_ctx_key	= true,
 	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index 9639e44f71ed..2e02bdea8361 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -131,6 +131,7 @@ struct mlx5_module_eeprom_query_params {
 
 struct mlx5_link_info {
 	u32 speed;
+	u32 lanes;
 };
 
 static inline void mlx5_printk(struct mlx5_core_dev *dev, int level, const char *format, ...)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
index e1b69416f391..549f1066d2a5 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
@@ -1039,56 +1039,56 @@ int mlx5_query_dscp2prio(struct mlx5_core_dev *mdev, u8 *dscp2prio)
 
 /* speed in units of 1Mb */
 static const struct mlx5_link_info mlx5e_link_info[MLX5E_LINK_MODES_NUMBER] = {
-	[MLX5E_1000BASE_CX_SGMII] = {.speed = 1000},
-	[MLX5E_1000BASE_KX]       = {.speed = 1000},
-	[MLX5E_10GBASE_CX4]       = {.speed = 10000},
-	[MLX5E_10GBASE_KX4]       = {.speed = 10000},
-	[MLX5E_10GBASE_KR]        = {.speed = 10000},
-	[MLX5E_20GBASE_KR2]       = {.speed = 20000},
-	[MLX5E_40GBASE_CR4]       = {.speed = 40000},
-	[MLX5E_40GBASE_KR4]       = {.speed = 40000},
-	[MLX5E_56GBASE_R4]        = {.speed = 56000},
-	[MLX5E_10GBASE_CR]        = {.speed = 10000},
-	[MLX5E_10GBASE_SR]        = {.speed = 10000},
-	[MLX5E_10GBASE_ER]        = {.speed = 10000},
-	[MLX5E_40GBASE_SR4]       = {.speed = 40000},
-	[MLX5E_40GBASE_LR4]       = {.speed = 40000},
-	[MLX5E_50GBASE_SR2]       = {.speed = 50000},
-	[MLX5E_100GBASE_CR4]      = {.speed = 100000},
-	[MLX5E_100GBASE_SR4]      = {.speed = 100000},
-	[MLX5E_100GBASE_KR4]      = {.speed = 100000},
-	[MLX5E_100GBASE_LR4]      = {.speed = 100000},
-	[MLX5E_100BASE_TX]        = {.speed = 100},
-	[MLX5E_1000BASE_T]        = {.speed = 1000},
-	[MLX5E_10GBASE_T]         = {.speed = 10000},
-	[MLX5E_25GBASE_CR]        = {.speed = 25000},
-	[MLX5E_25GBASE_KR]        = {.speed = 25000},
-	[MLX5E_25GBASE_SR]        = {.speed = 25000},
-	[MLX5E_50GBASE_CR2]       = {.speed = 50000},
-	[MLX5E_50GBASE_KR2]       = {.speed = 50000},
+	[MLX5E_1000BASE_CX_SGMII]	= {.speed = 1000, .lanes = 1},
+	[MLX5E_1000BASE_KX]		= {.speed = 1000, .lanes = 1},
+	[MLX5E_10GBASE_CX4]		= {.speed = 10000, .lanes = 4},
+	[MLX5E_10GBASE_KX4]		= {.speed = 10000, .lanes = 4},
+	[MLX5E_10GBASE_KR]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_20GBASE_KR2]		= {.speed = 20000, .lanes = 2},
+	[MLX5E_40GBASE_CR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_40GBASE_KR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_56GBASE_R4]		= {.speed = 56000, .lanes = 4},
+	[MLX5E_10GBASE_CR]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_10GBASE_SR]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_10GBASE_ER]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_40GBASE_SR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_40GBASE_LR4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_50GBASE_SR2]		= {.speed = 50000, .lanes = 2},
+	[MLX5E_100GBASE_CR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GBASE_SR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GBASE_KR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GBASE_LR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100BASE_TX]		= {.speed = 100, .lanes = 1},
+	[MLX5E_1000BASE_T]		= {.speed = 1000, .lanes = 1},
+	[MLX5E_10GBASE_T]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_25GBASE_CR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_25GBASE_KR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_25GBASE_SR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_50GBASE_CR2]		= {.speed = 50000, .lanes = 2},
+	[MLX5E_50GBASE_KR2]		= {.speed = 50000, .lanes = 2},
 };
 
 static const struct mlx5_link_info
 mlx5e_ext_link_info[MLX5E_EXT_LINK_MODES_NUMBER] = {
-	[MLX5E_SGMII_100M]			= {.speed = 100},
-	[MLX5E_1000BASE_X_SGMII]		= {.speed = 1000},
-	[MLX5E_5GBASE_R]			= {.speed = 5000},
-	[MLX5E_10GBASE_XFI_XAUI_1]		= {.speed = 10000},
-	[MLX5E_40GBASE_XLAUI_4_XLPPI_4]		= {.speed = 40000},
-	[MLX5E_25GAUI_1_25GBASE_CR_KR]		= {.speed = 25000},
-	[MLX5E_50GAUI_2_LAUI_2_50GBASE_CR2_KR2] = {.speed = 50000},
-	[MLX5E_50GAUI_1_LAUI_1_50GBASE_CR_KR]	= {.speed = 50000},
-	[MLX5E_CAUI_4_100GBASE_CR4_KR4]		= {.speed = 100000},
-	[MLX5E_100GAUI_2_100GBASE_CR2_KR2]	= {.speed = 100000},
-	[MLX5E_200GAUI_4_200GBASE_CR4_KR4]	= {.speed = 200000},
-	[MLX5E_400GAUI_8_400GBASE_CR8]		= {.speed = 400000},
-	[MLX5E_100GAUI_1_100GBASE_CR_KR]	= {.speed = 100000},
-	[MLX5E_200GAUI_2_200GBASE_CR2_KR2]	= {.speed = 200000},
-	[MLX5E_400GAUI_4_400GBASE_CR4_KR4]	= {.speed = 400000},
-	[MLX5E_800GAUI_8_800GBASE_CR8_KR8]	= {.speed = 800000},
-	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000},
-	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000},
-	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000},
+	[MLX5E_SGMII_100M]			= {.speed = 100, .lanes = 1},
+	[MLX5E_1000BASE_X_SGMII]		= {.speed = 1000, .lanes = 1},
+	[MLX5E_5GBASE_R]			= {.speed = 5000, .lanes = 1},
+	[MLX5E_10GBASE_XFI_XAUI_1]		= {.speed = 10000, .lanes = 1},
+	[MLX5E_40GBASE_XLAUI_4_XLPPI_4]		= {.speed = 40000, .lanes = 4},
+	[MLX5E_25GAUI_1_25GBASE_CR_KR]		= {.speed = 25000, .lanes = 1},
+	[MLX5E_50GAUI_2_LAUI_2_50GBASE_CR2_KR2]	= {.speed = 50000, .lanes = 2},
+	[MLX5E_50GAUI_1_LAUI_1_50GBASE_CR_KR]	= {.speed = 50000, .lanes = 1},
+	[MLX5E_CAUI_4_100GBASE_CR4_KR4]		= {.speed = 100000, .lanes = 4},
+	[MLX5E_100GAUI_2_100GBASE_CR2_KR2]	= {.speed = 100000, .lanes = 2},
+	[MLX5E_200GAUI_4_200GBASE_CR4_KR4]	= {.speed = 200000, .lanes = 4},
+	[MLX5E_400GAUI_8_400GBASE_CR8]		= {.speed = 400000, .lanes = 8},
+	[MLX5E_100GAUI_1_100GBASE_CR_KR]	= {.speed = 100000, .lanes = 1},
+	[MLX5E_200GAUI_2_200GBASE_CR2_KR2]	= {.speed = 200000, .lanes = 2},
+	[MLX5E_400GAUI_4_400GBASE_CR4_KR4]	= {.speed = 400000, .lanes = 4},
+	[MLX5E_800GAUI_8_800GBASE_CR8_KR8]	= {.speed = 800000, .lanes = 8},
+	[MLX5E_200GAUI_1_200GBASE_CR1_KR1]	= {.speed = 200000, .lanes = 1},
+	[MLX5E_400GAUI_2_400GBASE_CR2_KR2]	= {.speed = 400000, .lanes = 2},
+	[MLX5E_800GAUI_4_800GBASE_CR4_KR4]	= {.speed = 800000, .lanes = 4},
 };
 
 int mlx5_port_query_eth_proto(struct mlx5_core_dev *dev, u8 port, bool ext,
@@ -1168,8 +1168,10 @@ u32 mlx5_port_info2linkmodes(struct mlx5_core_dev *mdev,
 	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
 					  force_legacy);
 	for (i = 0; i < max_size; ++i) {
-		if (table[i].speed == info->speed)
-			link_modes |= MLX5E_PROT_MASK(i);
+		if (table[i].speed == info->speed) {
+			if (!info->lanes || table[i].lanes == info->lanes)
+				link_modes |= MLX5E_PROT_MASK(i);
+		}
 	}
 	return link_modes;
 }
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index 84833cca29fe..49d50afb102c 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2192,6 +2192,8 @@ enum ethtool_link_mode_bit_indices {
 #define SPEED_800000		800000
 
 #define SPEED_UNKNOWN		-1
+#define LANES_UNKNOWN		 0
+#define MAX_LANES		 8
 
 static inline int ethtool_validate_speed(__u32 speed)
 {
-- 
2.45.0


