Return-Path: <linux-rdma+bounces-14764-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DF658C86EDC
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C9E8D34533F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3508033B6CE;
	Tue, 25 Nov 2025 20:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BtLlMNcM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012012.outbound.protection.outlook.com [52.101.43.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE0833D6C8;
	Tue, 25 Nov 2025 20:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101247; cv=fail; b=Tmv9GJT1UXXQlbTeHFDHhMuBZ7q/klAr50utC0uFA1uLUxUIH35CeoS0sH8YzHd++wcqX8BNN1NTKTT0QPOgABTjDG+oEXK3g6QasLuNdlZsA2kR665N99Bh+kx/Ik0WCVpDdhpOr/fg6P0TNaDig3kDzYH0yBbX+UTn/o6KaL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101247; c=relaxed/simple;
	bh=xhJB/sYh0ubkeeYp1a8DRm5dsj7cwoJdOdCWOS6Tmb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZbafLvKfilPMHnlsb+iG1mefoZnemupu875UM/Y/JChHhDsNIqil+wHXge7yihdeRlx8y5B4qR0Yx4ma52F2+MqY0Kp7KP/GlDqsRyN8lavf3Pge092kgKabSrf0dCemjzoCS83LGgWdB184DTK5VGXe3tN5ucLIk8HOrL1x50=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BtLlMNcM; arc=fail smtp.client-ip=52.101.43.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pVKe+Yn88sm00jYsQw2tbicCvt6dhyb/9RxxPP+tPC9l9zoX5S9wTl/Lxq3jklUNPrZrw1q/J9qJBEr8bdLofBSzROK1MigJY9vGTQpDHQNFYCKlz6zkFob3O4JWbfGLk2yJOBnbA0D8/wQPg3BkJmw//OPqNeComDiBFGBVY+Ov4KI60KDObVYTRZ00zx7ZFa+I1Qo+RWTOsCAzf6pSru0qwKYizz6T5JAKJL9LzWzn27IvgXe45Ho2S3GJ4dplk4eyhAOWeEagLnBx1fIpI276yWN3L25jCS10egh+dN242jh4hXZZHiY720NMRZkx8lbzfQvZP8FyE1wsz/YhbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUAQAuCDnrjxX94659OK3IBx8BMuWDkmqvGWavblWHQ=;
 b=A4WnNVKLUGyfk/cPCfDKC/sZO0nA/j1TDRpN1slVYm2MDBOe6QHGut+XjbS9aYG7Fkn9BFZ6cc6SF/xlm6JLieBIMeUUEo2a50rXVWh12md0GST5/wDjczEqvAwpCDOu4GFO8QtxghMWoHv1V5/QPBQR+fNFkrhyxRtXeQSu9JT15EoODwvakPUWRQp2luYIM1SOQ1uGlD+m21K2LD1AW2B2bWXLL9lZ3bs7uyYQVp9o3d6+u5IWPpXVyjPdcYS3rVwzFSr5xIX2T9KkaBNFh9KJPYCJCkC1adr13vAQVHPDl14YHceAk++FyMJqTC/nhUU5jX7SREB4kajKMCN7iQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUAQAuCDnrjxX94659OK3IBx8BMuWDkmqvGWavblWHQ=;
 b=BtLlMNcMz+H85JVFiDY54Qx5s7SDxOq6Z/mF0D0PcVwmxYSKg+uoA304RnniWTCxbBmSjfjs6UHS1Wsre9MTlYScx1lCDVYkPUbXTSCi1CG0Xr4c5VBjqgC1uz8pzRnFR75xnN68Tr1IAGwjFRw6nRJahlw+347pgQWdP7ywlCE/WajN139qxGc2ImQWY2hY8a0GGCFvCM7mwN6iW1WImnT7FFbxYAF0/ockjd8LGbMCPVAP+2rFY98yJZVo54hPbNuX+8yVpFJ8jfhwSqAHrtCgNDLj+MluAXo088mtIIYEln822bJGb9z8G6PxoKJ2DD8EGLeKtCPuo+SPWUocbA==
Received: from SJ0PR03CA0172.namprd03.prod.outlook.com (2603:10b6:a03:338::27)
 by PH0PR12MB8049.namprd12.prod.outlook.com (2603:10b6:510:28f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 20:07:20 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::4a) by SJ0PR03CA0172.outlook.office365.com
 (2603:10b6:a03:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 20:07:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:59 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:06:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:06:54 -0800
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
	<rdunlap@infradead.org>
Subject: [PATCH net-next V4 04/14] devlink: Refactor devlink_rate_nodes_check
Date: Tue, 25 Nov 2025 22:06:03 +0200
Message-ID: <1764101173-1312171-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
References: <1764101173-1312171-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|PH0PR12MB8049:EE_
X-MS-Office365-Filtering-Correlation-Id: af331ab2-057d-4806-cd78-08de2c5e3d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?loU8/SteCxa4X5wckZ/thBAue3puCenqQq1RQsOOoQeLuPxPycaGdETBxBRU?=
 =?us-ascii?Q?g07NH6gajWUY7F0PBIO+TNIsVPyogR93KNuQ6oLS05jppkDLnAXe0T/YgvtD?=
 =?us-ascii?Q?/nJwQs9ru2CZA6mXA5ln/+nuNhqUkeVE56jpZNuGrHVZTTGs77ZkmIG8Gdah?=
 =?us-ascii?Q?TCQmU4fFuWUMdSQ3HjnDOdcNB+wKPe8U//cM8/+1+HmUHc4mWOOoHvwFwbVP?=
 =?us-ascii?Q?dH1aMYqGL5Jv4TYNq8t4o7TzVVZtOmGih5OyjOmlBwsA+P4YVYY6Vy9hMwap?=
 =?us-ascii?Q?6zmb3ox4u+MGNLuDNLM+BBni25Dh/XMZiSK2nwHS+j9Jtu1gQxSvnpqwueXX?=
 =?us-ascii?Q?WqIC5T6aTA8zb2vydVwpoTuF6EI+B2hI7rVCvkJqYhvfWJT2Vb0JXZKo5m+D?=
 =?us-ascii?Q?aLmCluFgaIrGhAwSOR/q7nb91BlRzg6Fy9xnrIlUAFDP/5gGgwKIss3iOnvl?=
 =?us-ascii?Q?+p/bT+/6QjCB7ZRHwgqWkNw6qZX7jdamspJjgzOxAU0z0TNGV+QX1xWSw1Nm?=
 =?us-ascii?Q?tSuMgvL6AFvmMoYYCYxgXaDGhvd1KCywjm5akavU7+PlAtzVLvmfcxYblepn?=
 =?us-ascii?Q?NFTCkly2PramE3DyV+YpT1FDutYEDiFSmIjFbmWJ0qEXGClfikhZmflxs4Z8?=
 =?us-ascii?Q?GOi18KI0yC+8CR096pI2Rdv9CadsvIyjloIslCR77dqB6naVe7ix2mZnooWo?=
 =?us-ascii?Q?j2/7P6RGPW6Ux1Ls2SqcmmXbjOyvFLmr33Da9kezs2I5/LtXaBHiW7xDxAZi?=
 =?us-ascii?Q?cyvOZILDozpViPdr7g/dUiWQfK8qOTmMmVHakf9ZWUVoDknqqk30PqYTIW6y?=
 =?us-ascii?Q?vIs3565NTnxSaFSkpculHpPOYzWGxCnOdfREg8jE7Drpjc2WNyfjpVSZbniv?=
 =?us-ascii?Q?gINigtUzFwvpzel+4k6hOzDjqYbuFjcp2wMX9TZTGuLHNEvQ7jaya0Vt0g3Q?=
 =?us-ascii?Q?wjmROLztjeU7TQA6HVInMtLrBlqyRRDoqTQdReMlqGcUjqhjAvOQxmkTc9EU?=
 =?us-ascii?Q?LI+bJGL5v9+8hHnaQ1GVWID8bct8AZ+PYx7LBc8Bh4/diyXVAAGHFbzkFoYS?=
 =?us-ascii?Q?vrs34c8nKi3zOCQn7035sQP8YGOogKywsp6PBpwh79oua9A9BSL2J8tZyVE4?=
 =?us-ascii?Q?j21eun9HWj2pbWjZNYZJASudaON3o7z/hLg0d3rEpGA82FH6FECZX3dLJcVg?=
 =?us-ascii?Q?MvaoEL5GB3t+0J/1PqzyBJjBVW6QaQ+jdIgV7cZN3fUsShyzROjDfetQEt7O?=
 =?us-ascii?Q?BpZxl+Whftt47kT5yPkoQGu8eq5HfzKJWZpScRCKKVS1T/auu474irapEmvE?=
 =?us-ascii?Q?WXRHbYWIJGH8VtE/H+atE0FmrrgS2y4deChIt33FcEfvGFxP9Z6gZjAcQBSn?=
 =?us-ascii?Q?cEP6xcQhZV6Pxz9RT1QgNcIwgzWuYcEb+YFnemCljvQJ7l2NQ016JJuIoD2p?=
 =?us-ascii?Q?chvcZ4oNmqQ3nNz4P1U/Z5c/MIlAWP0uJJDKkYpOh1C/jwtU8bExL3/3M9DC?=
 =?us-ascii?Q?HjISAu5so2tj1x2o8g/pQWvHL/+4VvWDLObaBe50Y1D9c2ajS9N7yOzQey9i?=
 =?us-ascii?Q?9KlFLkgd+6UHxfyjD1Y=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:19.5432
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af331ab2-057d-4806-cd78-08de2c5e3d17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8049

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


