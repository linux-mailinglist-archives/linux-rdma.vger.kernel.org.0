Return-Path: <linux-rdma+bounces-15740-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 985A9D3C160
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:06:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 06419447C38
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABBC03BF303;
	Tue, 20 Jan 2026 07:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="AnOL9aSM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012059.outbound.protection.outlook.com [52.101.48.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF903BC4E3;
	Tue, 20 Jan 2026 07:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895948; cv=fail; b=BJux1g8E6pp4Oxti3mBw85C/oc/P0ZN8Rxldp5ZHYNf1fTk0CcnzVdxoNnFA1P+igCvvBzK/IiYAydyBeVRDglXEqbNQjhMxxjGnym4MtxLcmxkKTf6tTz7XkIFKvmA6OuvflJvA7DYrGZaAq0HT5APnwS8K6i8wdU4BiwgnK5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895948; c=relaxed/simple;
	bh=RjAnyV49OpqLxH1Y/1/JYniSm6cVIzb8TL2yHKgRTfY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=StvXK/v++VzT1YW3vhEl/h6BgCgRJa1yfU4OJcXuXRKt+nbgeYUI6rDIF11EDC8FUA0/nSvDk+8RRCjp06dogB8t+HO8vsyZn9N7AnFXhne5gz3pO6HGvmB1fWJYESLQUgu/kjTlgx8BOfz/tMciN/KgdLebfKAyL0TXwGUp7oE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=AnOL9aSM; arc=fail smtp.client-ip=52.101.48.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ik+V/ifa2/iNAC6ncFyBVyweKyDf81ki9/L+QB6Pfi4T5YMyy8r8c48I79jYdg140GSa2AjtSoFnHjJO7ZTlCaQW05+eygqnGj8QM6GAAP8bYSN28XZyoLpPEcz6+1PDsA14nD+BRhd/2VHtQ5G875I+ox88Z2JIkmxytzNc0NjCB7MaiD86bfgajuo32qesc5M5q4v+13PSfrpzktgM/zI5cwd5AyWYjNd2EXsxfSLklOcgkG+sLSmCQTcZpFnvTSAWwc2UK0j3qe5v1eN7tx23LUuGsrc3k0O94OOgb7YaRSm+miILqVZNlaOKPnJPMyqTxhzldTp90S0WdBw3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2GtwMvng+TR169kHZ1pzGoSguw7VuTInPh8458bkCg=;
 b=fQKTgzSgenf9CpdCRo7x1MfSJbhV4rmGvtycc2mSPrbh3HoJ0aVBXtgMtupETQERtiD6Qb5Ibx5ZnORd1XagBPno7iGAxMPd4hcPgi5ht0jc16/3I0JR2D6y/w8KKG+SDR0qSA2gYLZ1lk/qkVjLhW+Ww4mVqUwMpD6DzTSPWwcsqnFWoJWMfMNihffPs1t3rN+8C37ugrIit5ldVtSQZlDs7Jox9lBpplKVbhY7fyeObSbbFbqW9syDf+LmYRvm8g37j5yoYb8HXpSzwwK3GRGkyJRULJSAL0DwC2T6c68F+3HZei5Q1uQUZpIan5Be5fayC/+Db2YuTnKF1fJBPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2GtwMvng+TR169kHZ1pzGoSguw7VuTInPh8458bkCg=;
 b=AnOL9aSMhpxJeFzu91MpclVVG/GPcTx2wR+t3bSzQPGaEwwSuDbVhO0VTf0V5vwtOti+YPNCz3jB4OQb+5w3u3LsxmnLGZcXMb4tqxb9rHxRNQE1w1NoYfAM2jQyDCmD4QbyFkgU1dS3BB8MmoxRP5xcn9H7furGc85qNhEs4Wkw26tRUnobNkyCp+wfOeOzbHlyT3Q6Im6+u+3LdOn85CDZB70rDKhmNRX4X5h5pUNZD1MJsVX2sPbpgBqLTQj+45WXoWN5g8QB2oZUtHekq3fViWmfHrTRId6bmXOLW2pnCz7mVtxuT4o0lLUsPNhb9Kt1O5qko9AW2YcYYvUtng==
Received: from DS7PR05CA0085.namprd05.prod.outlook.com (2603:10b6:8:56::15) by
 SA5PPFD8C5D7E64.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8e3) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.12; Tue, 20 Jan
 2026 07:59:02 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:56:cafe::56) by DS7PR05CA0085.outlook.office365.com
 (2603:10b6:8:56::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 07:59:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:59:01 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:58:52 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:58:51 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:58:46 -0800
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
	<cratiu@nvidia.com>, Jiri Pirko <jiri@nvidia.com>, Randy Dunlap
	<rdunlap@infradead.org>, Simon Horman <horms@kernel.org>, Krzysztof Kozlowski
	<krzk@kernel.org>
Subject: [PATCH net-next V5 05/15] devlink: Refactor devlink_rate_nodes_check
Date: Tue, 20 Jan 2026 09:57:48 +0200
Message-ID: <1768895878-1637182-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
References: <1768895878-1637182-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SA5PPFD8C5D7E64:EE_
X-MS-Office365-Filtering-Correlation-Id: a3780917-bb9b-411e-c7fc-08de57f9c676
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3h6utauHNjI8SivTCbsBrj+P1cA2XWaR/vf9vyAUmu4mdo/4AAkl48+4LmRf?=
 =?us-ascii?Q?9Q9qAOhWusM14ZrwVOJOaQaMICf0C5g95vuTk9oCJvvsDdEBfvWpbURn5lgi?=
 =?us-ascii?Q?gIztiPDOJ3JSf12BheYcKZyOuruj8ZZFBT4TViUVu5/dvJmZqjiuDoNaEkbc?=
 =?us-ascii?Q?2k4+62A9eXs8IbG6J1Dm8EGAC4CEY2OeIEDYkuW0lDEvSUYNJ66nr94qF9e5?=
 =?us-ascii?Q?GiQHNrn6GfRstmpVfAUloCG1eVzqtZ2lSRDDURKmIdq6uZ6vv3K+82kLXJGx?=
 =?us-ascii?Q?xSDJF2xrQaKNRmhlWMe5qVZwVrj5iXwFC6nP+NptZfMc/X5lswHHCAYGR93Q?=
 =?us-ascii?Q?lUtm+tQSZ3ulJW0j4H3MDciyypvQmSFcuE3iQZ0JIo6ZCdk31sYI+gzG4zDE?=
 =?us-ascii?Q?rCXqaE93dTZFFugLnjgN7qnsg/ux6oYiqjeaC3YbwvC/h6zcYH0vMZK2vhHv?=
 =?us-ascii?Q?X55gcx9iySk2+MaBTiI7A8i41pjLFv/6oafeN0tl/r6f9fbGNvgLrhOZWSew?=
 =?us-ascii?Q?QBtIP/Jcun9odaH9xndUOQx9WNLw4YaP0W8xxe1k+uFjZYjdlnvC6X+VrgNh?=
 =?us-ascii?Q?TvYPF6y1sThelORIROs7pkZhK2FIw+TJqUZ4Th1mFNpe3Ukx6moKkJ06MkJC?=
 =?us-ascii?Q?rfZ4uFS4l3SgmxEcMxkLxs1AxXGRz0xqKiFJgLTmYVtvdCbrekMVzZSol8JB?=
 =?us-ascii?Q?iUNrqNGUK7A9t1fgJu+0h4M7IPSCgxukNcetRUBDsh9oPJl36dHRnU3a3h0s?=
 =?us-ascii?Q?9QAcM+OTNFDfp9/+wAlR+k5DT+t+auep2RLzQnUnGn5EktM44BlsmeTiBQ+9?=
 =?us-ascii?Q?YDUrNyfyFvO+mfrth/PDlsxwwEF3c9VT75C6zMagDSFGBULCrp3atYOrQVed?=
 =?us-ascii?Q?OyXxJfQtxQFECLP3cJTWvawA3ASjOSvHFOABIxkhBHLimm5TuD5oNVCkPu4K?=
 =?us-ascii?Q?sRQ2+jpAasg9ahU1OOcFrbCQqxYtRz4OEbpDLvg30YyonC4jT1WrtaTEogEw?=
 =?us-ascii?Q?EOey1r84OL+FCbzrOItGozx3Yr+eqwuyZf30BrZa3M3qgt+0GJzHPPwlDA8U?=
 =?us-ascii?Q?6vyl19FI3CGUb3qQ0EqTPeBeqs9NdVL3ZB3lj7TKvSk/sL9R3RG7wF9qrw7e?=
 =?us-ascii?Q?tL2VWq6u5cKjpP1eJD8Z7NUeQ3VUuZdLD3i7jT7HMJDyc4UUFuykCH9An2F4?=
 =?us-ascii?Q?G/1ciSnFFUnhu7LOWXMRZ/Ps6TVUlG5Pfs+DSOUlUA3mA/tiEOz/S3o8N9kp?=
 =?us-ascii?Q?VDBFoGWSHRXR3cqxkYyz96lkZRg232PaLEyIWa4snh3HqLTnz2ZlAWdR5y4C?=
 =?us-ascii?Q?RXH9Gzlr7X/kAuutEj8JZYHreNqjvqPRP/wi9DYT+UUv25VKAWCa04ER1FEN?=
 =?us-ascii?Q?skYHVjTEEiWtGWriVGJM+YgAKBA3eF38Yq5yyOWePbZynTuAX/7iBUW5GZ35?=
 =?us-ascii?Q?tthNjxzK3VQETiI8Lt+/TIRN0nnUPr45CQogJZNqV8+N9QfTvZWFoJCSuBQ2?=
 =?us-ascii?Q?NJh/6u9fDajVpojrPRUfOYhb/pWqDoQCP59tuLpRuvXZLsy99MoLM+Lu8UKA?=
 =?us-ascii?Q?8wGcdlmdK0K9kCTQFHZq/ZBch4L2i4a/3hy/xMFt68wpK2LFrTzTVVrzxkNy?=
 =?us-ascii?Q?2oojS5FmLxv5CDNxgapn5ZGjyMd0PblcX0qYEJI8yp+fd9jEsvzpwBsMyxG1?=
 =?us-ascii?Q?NdGfxw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:01.9860
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3780917-bb9b-411e-c7fc-08de57f9c676
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFD8C5D7E64

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
2.44.0


