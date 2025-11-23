Return-Path: <linux-rdma+bounces-14689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EA0C7DCE4
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 275353AA8E3
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:24:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C82C028C;
	Sun, 23 Nov 2025 07:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="dWMnoOX6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012018.outbound.protection.outlook.com [40.107.200.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FED29E114;
	Sun, 23 Nov 2025 07:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882632; cv=fail; b=LhyqFSMhDiv2IDrHTPmMvdJOiiBZl1oKKOUSOVlVoXK7Hc0y0JDJe04B/IOyTIsKbm5H9qya62ehz54n0aQYSJ7satmhWj8cGezcR7yt9KpJwjKgdYiD5KvxRDEvFjQipT6lx8ZGKqJcRd49yHYfZQbj+uhG3zs061ya6URy3yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882632; c=relaxed/simple;
	bh=xhJB/sYh0ubkeeYp1a8DRm5dsj7cwoJdOdCWOS6Tmb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fOjpfozVNkhBFGmMEyZXpJP/iQItSKY/jbtMFDVKxN7+c4d/6bkJljD80YQUI4ykZc639KF71zXCJiFTMk5fviedFwABZVJU1xoHafDDMvvgJa4KSE0zlNHQLlwhB1OoRgBMrmnQr5EcOT//Ng+1MSuVFjJablSiHm+1F68cjnk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=dWMnoOX6; arc=fail smtp.client-ip=40.107.200.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bANy8COPN7TeS0qtR2Wi5XFsospQZPWBD0fJSqjknk4nUenvuo/VHEOBXman9pfMAlXlTFn1PyL6v2iQDp32lqNDdsnk2lpz3+9z8BNjqW+0kkTXdZ5lCUFstI45z8b/WKUdPSe1j8+jMZD4mp3pdFrQXqiWanpNF0sT5/xvMBuesz+uoUEydKi08VqynMD+Wi79EDgqxp8TJ1x8pIUjP1RXt+sh/Ilmq3ya9h8Yrn75RFOM5AhBrA3hHDssRo6FBK8zeE/lMzBYiBZw9yJ4kJ77hA8/kEa4BRS4i8oJRHchB5Rl99wCIG2o7gX54zVzJ6aS6uumBigqyFfm/1OOZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PUAQAuCDnrjxX94659OK3IBx8BMuWDkmqvGWavblWHQ=;
 b=C2NXKxqWlzl6MJIYKHk8uOKXVRxpX+GJGTPoSOBSdLgRwoXgV3TKBZWaUzjJvsSXPiVzilyKLDxtHgHDgByf30h4OM3gWqWZl9hH8uRUjvxJNTLQmLCsPLZmDTiMOP6STfnnwZvMxeP88nAYnAlyaqECDUz4AkQJ2c7KDJRJaZV5f2+LGmi62wYxyE6nS2hKkJy0ZHQQIK8JCJkTzkuTG2m+D/sPcEJ/Uy2JZB51mYmuz2bfIuvpeE4e0GJcgHRCWb8KbJ4GF1xKY3PM2kmzbKkpvcpilIuyAzNIYw3tORYjUlQYMpegy6kACsT8Zr/JEwtUmAWXJMPuxYsYsfn6bQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PUAQAuCDnrjxX94659OK3IBx8BMuWDkmqvGWavblWHQ=;
 b=dWMnoOX6a6sFmte6kmBqTke83pcOgB2m4wDB+UHX5vC/okZQequ881UDp3QjyLk3fuYqmzRt+gydpqz2mpIgxlsoZla0EkBSGS/2oL3x2zDk2UrAgSeEHSl0tGHW3Uwgtioc1lCKpcuDAvYHalp7Hsbjj0AT2NOXRTr01/MRGwK2PFE+NvM7PhS0uwxXglha+3Bz3WRZSjd1m00Qdws6FAWzCQuubwW2SXtJnQ44SfZRqK8IwWrrpvghp+h08jVE8/N9NpQkRj4PyoXDSFsD0X5CRHf5dRlqoxX6afkGqNnALq8KUnlry9h+3bovV1aKC0GdB69WiNyOYShLIWD2tQ==
Received: from SA9PR13CA0047.namprd13.prod.outlook.com (2603:10b6:806:22::22)
 by SN7PR12MB7978.namprd12.prod.outlook.com (2603:10b6:806:34b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:23:46 +0000
Received: from SN1PEPF000397B3.namprd05.prod.outlook.com
 (2603:10b6:806:22:cafe::fb) by SA9PR13CA0047.outlook.office365.com
 (2603:10b6:806:22::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Sun,
 23 Nov 2025 07:23:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397B3.mail.protection.outlook.com (10.167.248.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:23:45 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:36 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:36 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:30 -0800
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
Subject: [PATCH net-next V2 04/14] devlink: Refactor devlink_rate_nodes_check
Date: Sun, 23 Nov 2025 09:22:50 +0200
Message-ID: <1763882580-1295213-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
References: <1763882580-1295213-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B3:EE_|SN7PR12MB7978:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eb0ac2c-bb99-4bb4-6a9f-08de2a613d25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T3/VTdheOeqFar1eOBHtIsOf8ZHPff9KdTPnVczIez2yzXWQ9X4jXPQZ264f?=
 =?us-ascii?Q?0we6Iw2BB9SojsmQAclOWAopc+jeNjbidiy5tEO6q12pbnU505jetZ0efxl7?=
 =?us-ascii?Q?R8nqUzNWvPoerNw+ypFCcxu9+RMM8ZaXBq6B2CWQbPwbPFZ6jF/VoJfqJpzy?=
 =?us-ascii?Q?tOnaggRPIjRqEgMGT4TUQ5oMe2VvqD+luAKKTW7ITdqMei+uYJENCaRse0AK?=
 =?us-ascii?Q?dHQu2+9cfypCmStY/rZG9z4RfQzZYFcKDwGLnxCb6xMahx+fpui15Ikgv+9Y?=
 =?us-ascii?Q?Uos939WXpyD4b0LJbGsSbij3G5tdrb4rg2LKGsdT4CxI8y6eMdKM23vRiAp1?=
 =?us-ascii?Q?dsoCBfuV4UNfuBGZKoo7XBmVZLkDZt0PKw/qnqWufndTk+2cPPcvHWt5UU/e?=
 =?us-ascii?Q?moCroINr23DGJ+lH8tCmeT+5osHX8YRPmrZ29R1i9KVoqL58tYrWMcspAg4G?=
 =?us-ascii?Q?nnwARuk79iiSVBqc0lSKtnumTbk0sevm6HuPIfSxQSrS3n2UFSf4YnXsCuRK?=
 =?us-ascii?Q?/q27Avf7yKAhEMNEGMlG7Uc24yUmlbLsVs9F/dtHsvCmLnBVQ9AbKaJpufNI?=
 =?us-ascii?Q?VTJ3ngforD31af1cOlT2BQD0Rknnkl/n640EybXx5axuHn8lo0Py2JsabVRM?=
 =?us-ascii?Q?fkuPJPoacDKM5BFnUvzJmY4UiNVdOFN1teW179TL9ICrHst9UV8SPKZ2C4J7?=
 =?us-ascii?Q?E2GZ3v25rEkEx+XFMvNSfGOLG8Cf6cBkUcu3jwqtQjOG7yuaUoK184fIKPBc?=
 =?us-ascii?Q?WrjkQBv09qXwu3FKZy8PPucVdXHwTn3SD72U4V5IEYpp9A2lM7l+mhfos3pb?=
 =?us-ascii?Q?jZtQdy+7aCoGu4yn41II+fsLGoJ1ukZDUqExRW9P+vZkgH3i3Zzo8Jw7sPnZ?=
 =?us-ascii?Q?8GbWRBx3kuW/YtwXKOx97C1Bk12NYNewWhWpicWpGBfaxP+jHGr0yIiWTCkF?=
 =?us-ascii?Q?NOyfcyIYEwpbpLlgrv17p2/DRSk1gHbuArqQ05f48Fb8aZ8Wpfud2UM4HIvb?=
 =?us-ascii?Q?Sq89FrIzVl+R6BxZq8x7iy1Z6qsOacjfULb7p2xK6D8UumFAETXAaCakAYds?=
 =?us-ascii?Q?YY/71yem+xnCFpbBuLYFDzBbnsL3Se/3s3O0wzFVl1wq42BUlfYzLG4LJIzN?=
 =?us-ascii?Q?2lU2inGfy1bftuJey3eNrzFRZy27r6CHR5j3mly9NQj4dS7kKUUBqkElVWd9?=
 =?us-ascii?Q?Xdxy471bwcP+tYMs8b4lo3OAudEPR49pu9TTMaIGGZKPyXtknDkV3gnX8/80?=
 =?us-ascii?Q?ngZkTcXUPHp0q8qKaA080UraoEvc/NZ5yaE+hiaRZXrs3YhaXEuzwjF0aoQ4?=
 =?us-ascii?Q?YwR933sQ7hDWQF2kcnaMYh+N+SfYhu1Q1jLBgiQO01tIdcxGuDtBddMP1tiA?=
 =?us-ascii?Q?kB5aR1ldSmwQP3dvRffybb4T39AWGmdEUNU49nKTMJduzZFBraubv9PIXTla?=
 =?us-ascii?Q?ASJ0Nae3gw6/RM9uMh/9wPjZTDmPqvORP0BUZMOvmfuGWtmWKcPwVgO4AJI1?=
 =?us-ascii?Q?FRf9vyQn9JCccT3zNydJ+2yx1TVAkHrHJDy1jIaexqacRkpjApilP7sXnN9l?=
 =?us-ascii?Q?eScrEMSYgSrHXhlgS8k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:23:45.7810
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eb0ac2c-bb99-4bb4-6a9f-08de2a613d25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7978

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


