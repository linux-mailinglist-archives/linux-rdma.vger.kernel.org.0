Return-Path: <linux-rdma+bounces-14726-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9512CC82A96
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 33C894E829B
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22F335084;
	Mon, 24 Nov 2025 22:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XTMhm7+K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010034.outbound.protection.outlook.com [52.101.61.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556CE2FA0ED;
	Mon, 24 Nov 2025 22:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023362; cv=fail; b=qkQcwwhx25JgHedObB8ZoJfN+6GJrHKM9VdQ04Td0cshKiXWKjGS2Pm2SosJKmLRQZhIeozhFx6CccExDoe/M2TMs5kOZe6VZxoygV2c0+5xHzrz0zUUp/0tu5kQPBb8/9L22hksEsWKfNvQmWtUUiAZRcT1y40B7J95eTZCo6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023362; c=relaxed/simple;
	bh=xhJB/sYh0ubkeeYp1a8DRm5dsj7cwoJdOdCWOS6Tmb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RkT8AnW/xTwJol22KXuIyuVoG5qwEcMSZLCDssIumKTClXGlpDGJFUOU7l1hdh/IOuSPeNnsq5+zv9dhRPmBZDvs4/gETyX8HFx8hlngtfT9eRVo/jHDANSPWOQzvi9/GJnwPwBoqbQpASJpMO0L03NIJwYmNlgB/GTjL97+5qU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XTMhm7+K; arc=fail smtp.client-ip=52.101.61.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H40/uaM8vt8U3U8flJOInG7WlLQgNCOpXs9QWskUvtHlYx/QHOjLZG8TvIdT1NOnd18oBdgDD0NPtUmCOtFmN/ZZrZ/bXg3oSnGxAVGbpqwIP1VOH8cgeN7XN+O+hDo9Nx3af3U5eBHCjPFw+comHQO4++OmE0QBn41yXqRJTpYg9DEVV4eQyiJaE5B/43eogFtQHsHqm0fDmhPW//16hmIJ/i5yITBqDByAalPTdydR1VaavHkGhFfJSSgGfmibBtuK/YH0S30Q3WLusQihTYrQE7PxtPTSIwzh7giqM9vE4C3pP/YxXCYXhInZNfmYT1Tqdscvu9lfh6/bs4NSWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUAQAuCDnrjxX94659OK3IBx8BMuWDkmqvGWavblWHQ=;
 b=Y5gtcDGOrHECp3aIp+y3CDZb+4oZPobwyy1OelyfU1omS/dxTFchJ6De2V0VV0sECpN7i/cFUEZPbG4tyIDZrcq+RTN03AH12cImu6vTF/D99CUg8HvqndyRLLYXjg8TpbPpe6KUnh+CMkVqV1IGaDU3ys/iZzc8dZ+y0c2uKN2EdVZoKnMheks8GAtCuHNPUIbsh/Mik53zm4E5PgGmzaVJsDTai7MbUTWC54NmF/smK1+wsn7jQ4IVxy1Gkcz96s7+Ims2I6GoMzXg7outubWMloo/ehx/Jp7T1Urckbuel/fl3IRvsBlL50UudCFV8JnLkFSE9mIdK6Z7YvkbNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUAQAuCDnrjxX94659OK3IBx8BMuWDkmqvGWavblWHQ=;
 b=XTMhm7+KTDQItDHzrwACUm2lz8GHM1L658963Q3gaUnJnnN5CHwZylNMu3aAynkARMjuCV5tCO7sFy4sy2GvB8WaEd9u60+zUTc+LhHI2ZXeUvPTME5ZNepTcFd3RJyiI10wnueoJdCLykzhoN6h26p35H+hIW6+D7hPWkBktZhe0PPP77vobiUsdeTnL+7L+U5GHxgB41/yFvL69ht9Z+Jx45RLyO7mWeIH81nRAF5rAd1QuqiGJCSrFJRHCgr+t+Xvze4BSr++KgmPiOewYbTopg6yInxvGzKdjseKxqlJIAGM2poHdmqKYKpUTuyjZtuz0fL5BrXwkJDSZ5bLog==
Received: from DM6PR03CA0081.namprd03.prod.outlook.com (2603:10b6:5:333::14)
 by MN6PR12MB8492.namprd12.prod.outlook.com (2603:10b6:208:472::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:14 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:333:cafe::a8) by DM6PR03CA0081.outlook.office365.com
 (2603:10b6:5:333::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:28:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:14 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:02 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:01 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:28:56 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Donald Hunter <donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next V3 04/14] devlink: Refactor devlink_rate_nodes_check
Date: Tue, 25 Nov 2025 00:27:29 +0200
Message-ID: <1764023259-1305453-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
References: <1764023259-1305453-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|MN6PR12MB8492:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ce09413-29ff-42bc-5097-08de2ba8e5b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3DSQWANPKRY4uzEkYBvhtwRG0nd6RsdsPEvd5P1eX6jX5/MzcEiGyR8Y1Ikb?=
 =?us-ascii?Q?pTjRLRzVrJlXpzxuQYCLiVmA6FiNtgOyyCmN5nbgtDYa8WIPG266UEg8hVuR?=
 =?us-ascii?Q?obCWdoO/LOF2L2leBWJarx6pjwEc9x78O/2FhAewASXCi0yyPJlk22zPdbdV?=
 =?us-ascii?Q?tHtQmDZjCMbGX9SdA+CHc9RKaDnAyjyWyLUyfrVrI4hvqMFWTKf5ngVeXBJj?=
 =?us-ascii?Q?hD3K1TLl416sfimadu6t8sIV2oG0K5JhkEK/CjDTf6kUMB5Ux5iSlJRNDequ?=
 =?us-ascii?Q?v/JEBlLAnnwtDubcJ1zehsH3gH7j/0p1C30lZUSyAGgRzyGtAumcXqMqJdli?=
 =?us-ascii?Q?+PPVdFuHi93MFp9w7//gQ0xAoX+SIQRAg3uiMMGT/O1RlmRyxZElIqp04j9x?=
 =?us-ascii?Q?Uj2j6SBfv3xX50DZm8P6Bhiz7WoNflLKpEG+sh6QwKMwwGhkoE27CZbtz6Wl?=
 =?us-ascii?Q?zl39bVPK7z6XvG28vvoAcp0j+OD7DGwjIxKX6AYiVrwI38b+kqSzE/rCs0kU?=
 =?us-ascii?Q?3LC+aWKjxQRwRug0ySTWq+LYPZqx4bUTSnvDXvzGH494wSvxAxibpeXece8m?=
 =?us-ascii?Q?TmEtgKsPooCBYzsh3gMhwkNHG4trPcIUuSkGDpHcbdT/RKDvg3kT7jb1RPW5?=
 =?us-ascii?Q?41oAQMtanST0rwT36tl9am7ucHnwL6xGNuGn8fcuNYWfCczGVwLSEjt2ExlC?=
 =?us-ascii?Q?j00fKweBtg0/DWnmXL1Bse4BTIrIxq+8C0A8/9IUfh6Ym8QyjDunZz+tYEtJ?=
 =?us-ascii?Q?zZlAAGJeZ4LC0VuoUlJecimSoHX0WJyv1qy92+vRFUwHj11ZXK8sSTn1ayxG?=
 =?us-ascii?Q?XbvO6Ww/mcJfzONJt2mNdHH/E9MGXH9KgGUJ0bmUS9BxQafJ0V01Z2I0yiMb?=
 =?us-ascii?Q?oXePyTzWZ2hxfJ+30slwmVsNAaPxLVB4pHkyvmUkpYUJSxc7lPAYUXOzt25z?=
 =?us-ascii?Q?aYkGlGQW+QB7wPuw9foEh/Z2laJRyPjcWXMfC7ECV9hUsLmWFtvaNMGvDVNr?=
 =?us-ascii?Q?C3PTxjw6hk347dZ5C0/5LtR4ZASGEA/QrdqXqssJ+PNStvD1WC0sfj34N+Bj?=
 =?us-ascii?Q?RXBvubfm5GQJfGStUhwlHS1sIiGoMs72GbWwEvl4522eP0RRSU7fIGwVGETD?=
 =?us-ascii?Q?NQutaBQlwGYviPM7IxobD8YW6rKpRFjEmVSKOV3oV69hADSn6VflaOd0pb5i?=
 =?us-ascii?Q?EPQEg3EdLa+0IQp7VrpcnG5np4W0GO6oGzxQHJ/YvMN9H+9MWP8U7WNRKEMZ?=
 =?us-ascii?Q?L/ddVuK2MSM2AXl0gPfp5CZ5C3bAzIpgN1ZmjauvlcehtAXotDL/rqrooyHq?=
 =?us-ascii?Q?pd8AMux43jf0h4xvj9XmXAFqVq7l+aJMP6967Fyuolz6nLi9aTKMf08MAi3u?=
 =?us-ascii?Q?BAL5tfYl5c4tb13b6SLhGqVxeHW/U5hqijWK1egTJ5WKV7pMXyFxiWfncL3V?=
 =?us-ascii?Q?yHawGB4/wmB38Cw1nv1V9PACoqJRVO5u1glCDh4ZlgUQRabpEKFYZD/UZU0s?=
 =?us-ascii?Q?ptS67FaK3b9L/4gFV8Vzs9nGaJTICSb9MpY3+KfTWGD/IOE6Do6KmZsMfiQU?=
 =?us-ascii?Q?RA/Dolpq71BpF4sB7DM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:14.0269
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ce09413-29ff-42bc-5097-08de2ba8e5b5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8492

From: Cosmin Ratiu <cratiu@nvidia.com>

devlink_rate_nodes_check() was used to verify there are no devlink rate
nodes created when switching the esw mode.

Rate management code is about to become more complex, so refactor this
function:
- remove unused param 'mode'.
- add a new 'rate_filter' param.
- rename to devlink_rates_check().
- expose devlink_rate_is_node() to be used as a rate filter.

This makes it more usable from multiple places, so use it from those
places as well.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          |  2 +-
 net/devlink/dev.c           |  7 ++++---
 net/devlink/devl_internal.h |  6 ++++--
 net/devlink/rate.c          | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f228190df346..f72d8cc0d6dd 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -517,7 +517,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 02602704bdea..e3a36de4f4ae 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
@@ -713,10 +713,11 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
 		if (!ops->eswitch_mode_set)
 			return -EOPNOTSUPP;
-		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = devlink_rate_nodes_check(devlink, mode, info->extack);
+		err = devlink_rates_check(devlink, devlink_rate_is_node,
+					  info->extack);
 		if (err)
 			return err;
+		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = ops->eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index aea43d750d23..8374c9cab6ce 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -300,8 +300,10 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct genl_info *info);
 
 /* Rates */
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack);
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate);
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d157a8419bca..0d68b5c477dc 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -12,8 +12,7 @@ devlink_rate_is_leaf(struct devlink_rate *devlink_rate)
 	return devlink_rate->type == DEVLINK_RATE_TYPE_LEAF;
 }
 
-static inline bool
-devlink_rate_is_node(struct devlink_rate *devlink_rate)
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate)
 {
 	return devlink_rate->type == DEVLINK_RATE_TYPE_NODE;
 }
@@ -688,14 +687,16 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack)
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
 
 	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (devlink_rate_is_node(devlink_rate)) {
-			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
+		if (!rate_filter || rate_filter(devlink_rate)) {
+			if (extack)
+				NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
 			return -EBUSY;
 		}
 	return 0;
-- 
2.31.1


