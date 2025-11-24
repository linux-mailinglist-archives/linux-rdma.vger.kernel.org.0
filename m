Return-Path: <linux-rdma+bounces-14727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B106DC82A9F
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B65F3AEDBC
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E413358C3;
	Mon, 24 Nov 2025 22:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kct0km/W"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF083358B7;
	Mon, 24 Nov 2025 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023368; cv=fail; b=MjvFeCT+5tUw6KyTwdTUNQsDbxE2lh/UM/JZFN2bg7HJ5RlwBYYML2wsJcXeyjmx6ooKXoKbRk5SGD0dykQUaOLKf8rjR2pftF4Yx4wy0zBkV1rp9hS0vui9w5IhdVz6LbMuN096m5ZYblscgzUfOklDfCF7eW0/IEmmzuD7q9o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023368; c=relaxed/simple;
	bh=xGJQtX7UXHz8xbZdI7qg2jXIjE1gPPXyzBVr2eoncog=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Slr871o9IOx9iWRpa/RXzoOdySWMTwGRUrxAeXQRL+NdsO8U8qI0TWSJY22SJ6aS/gt3PioFvFf+jhpPksgKRS8MfHZRcoYrldIxpzEBEQPW612WDz7OSruB1mxnCnuct+DXxnH1HaWL4FFixbNA2Eai3cM40RNhlJw2j+WCgw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kct0km/W; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CN/iGD3UNqvaJE0J7uLOZD3ItIWpKrOjcJI+BcpevjU14kzmrpmAn8me3KfuFkUPP+eSRVg0vXXROJ+prMf3rpvprtS/lL7z5My89yXYIaehki0W1aEq43qqmtAc9H8SvULjyd8leREuEyovsPFnGrD3uYep0BH2Zph7DZKyewG2sJcLJJPVksnQc3QPcM1sTnxNc30/zK4ibx8SmGW9lVUhrCvma9Uf6v2QQBAqo77AgwVa7R+H7qUoDIVrUzqxJg7MJQakwJI2zwMJ0UgxhSPETfmhkD/cApx8D41G1AZ977Rxupu9XFlPfsvdzldfN35ZbUtd9EfWAVamX0cVdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PGcpjb8v2lVHiWVLvxRkPns35HfMvVIPVoTv6nFi1w=;
 b=ZgaG+oPrFpvF+Qn+AIQFDWsURSbZcYHjEwLoy3mDmuXcyHaf3YXD+A1GlCFV8OhNkA8UMeLrKbRrChWkWTAdjXs5jIUJ8cYqIU13NX5+HM6GcKRbi6leYismf/ewyOfoxc7QHu+3mRyNWR6yc81v7iJ2tdi7fOe7ZR92kPTrZCYZNDhBkHjoQdFm5AZZ52O4yj6uAW4JY0orCj+UpzGgMkWGY36nGlUZJ2ys2khIi0hoHUSmPcVZGMPJ6rSFEge3lrUIkg/jd3GK2K59tBma+qNrMmAhMNHnXKsB+BUwylPylxsp/zhZIq1JdXhTQVaOJNGfJUshXKL5nri7MKxUaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PGcpjb8v2lVHiWVLvxRkPns35HfMvVIPVoTv6nFi1w=;
 b=kct0km/WOp5/mslG7fMAPryi4a7hJZ56mc8P3R4w5Nr8X5gFP4vOPfqsI45vKYc++0tAsMWm+qBVjTNT7MXrmInbMy1VafA8OXY+Bsr3CsPug0Io/EGBYjmmLVORKvEVAVlOLofoJHuPYRVxkfwcL/qtgd0ZL6bw8m8Gd8TjNQsI2KlSke+ZY3hnuC1nSS2ze+ryeyw944C1+ujYCFlC9HjCR2ubD8CEh+PF0P2n/IIV9vq/CXXV6B3DVEXaV1aOVdBzmlR57FLMV7IehJCE8LRxzi8cU1mzvjKx+xJR8s2LE+gD/M2JMzRvP1Ez9Vh3EcN3/RGKDz3BdXNAKN+hlA==
Received: from SA0PR11CA0010.namprd11.prod.outlook.com (2603:10b6:806:d3::15)
 by LV8PR12MB9205.namprd12.prod.outlook.com (2603:10b6:408:191::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:18 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:806:d3:cafe::30) by SA0PR11CA0010.outlook.office365.com
 (2603:10b6:806:d3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:28:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:18 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:08 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:07 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:02 -0800
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
Subject: [PATCH net-next V3 05/14] devlink: Decouple rate storage from associated devlink object
Date: Tue, 25 Nov 2025 00:27:30 +0200
Message-ID: <1764023259-1305453-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|LV8PR12MB9205:EE_
X-MS-Office365-Filtering-Correlation-Id: 56994292-95a7-4f26-97a6-08de2ba8e84d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2zwSUE6UMW+s708tK3YdabnAuavnIZHcSM1XOicTvEjX3qsfRW5r98DxSsR2?=
 =?us-ascii?Q?wozua9ikJYlfaO1TDF2/9bvOxyihQyskJ9+luhq4XneoN6BhCXigqtBKj+kV?=
 =?us-ascii?Q?srKjg0hP0PBdEk7IQ67dxoU7xut7KhNpXdeZM036lPVP44mQoqhaKoT569+g?=
 =?us-ascii?Q?62aJeVBz3Dj5yv1zd5hCxUOrAZ70fGjdQ9fck3yND7EFfKo6qYG2SCSQlZBj?=
 =?us-ascii?Q?VilJJ2f7AbGpEsnx4AvBH2jWTuM4Z6T6qnmsJ1ZL0QkG7Ogs6sxuI4bVOou5?=
 =?us-ascii?Q?628EKxf3aGji69jvbA0K8xhdO2qrGuIMQO1xwhzZtn2MfSCOTJ5lhtRbpkrt?=
 =?us-ascii?Q?OyFOvTwN34T7tc5JEnYdsZluwxMOzhEkDqx2stzEs16OubzYnbJ9oG9YCZST?=
 =?us-ascii?Q?CTnY4ubcHirLCvQIgd8qFfm0ZZT+TIH99aKbrY/IvcwOrit2WnJ0y/IsZWo6?=
 =?us-ascii?Q?28FHJT/27dDBLbadFbjmMnL0gEc3xgj8YQidYKbAxlQt1aNMGvTvPt+n9F4v?=
 =?us-ascii?Q?w2pMRAqegabt1cnEFArpRvISiMNGAy9cSiksj9pVAktnbqlfJQ3GALlOAuS4?=
 =?us-ascii?Q?NFo9iwoutuehFQoXVAPDoZIxeCyqJmKucK0pt8fodsOYGLpaZbIfU1Mr4hMb?=
 =?us-ascii?Q?KDyrvj6GAvI8lI7N+0TVneSzc3Yq+m3qLHBQ4sAmIKCKNSvZmR7E3/KjuyE9?=
 =?us-ascii?Q?BP9HfmpnOSwgmA5BM9p2lLDnG1stLyS3GKI0gQ0K5rjcpz9+XjesG+xu+c5Y?=
 =?us-ascii?Q?CXZjyQMnmfS2hrOPD2e4rjxRnC96DwjT/roVxaD3gWaEITaY/2tG1hE2CVSU?=
 =?us-ascii?Q?iEfdcemrMJZcv+AGxKP+lK6EhxwQGvw+2+xkv0gy0Z0CkvsygigIpLL1c6pX?=
 =?us-ascii?Q?4BqiMjqzDTuvqoBMTmFYFSi6cg+Z99CnTt4hMvRTVWCcov3aIjH3DEcFfki3?=
 =?us-ascii?Q?PTkqQiUtEZb6IPVteLAIkoGtW7mE487obLdMtmXGsLMojAuvM75vMy4k9bVj?=
 =?us-ascii?Q?+h1rAKDKfe0DZpKVgTwLSle2yjRoiABELDDyo9GBlnjNiQllRgD66a2rP6dW?=
 =?us-ascii?Q?4DesN/qrsSrlKI2RCx6dr84lMtC3k1XpxdVmJMwVwDsXAgjMTxAMWHdSz/Wg?=
 =?us-ascii?Q?ioG7LNj/MHFkAztZWEvFfOfme5MQwLMuSgJyPu5P05MLfpLyyfxaG1K27THL?=
 =?us-ascii?Q?uu+Hv52KIpP6HgV/TvVbPIuI5Vr7Aqm4P1EhNKwTgln4zphDUPwBzkJjEr1b?=
 =?us-ascii?Q?ceX2TitLO4UlBwWC81GbXB/yQ4rl6acUab01MhjeygXomDh2DEid6qn6jMgw?=
 =?us-ascii?Q?PDlTXLEaU1sltUDK0Y4gYONawrRkPxgK2tp/f+esO4O1ePD7CdwqPIQUchAh?=
 =?us-ascii?Q?ud2XmL7r0D2hgnEFxATNUPkk46usrW9Le7eXrrdeq45l+bg7e+Xerfx1aT6l?=
 =?us-ascii?Q?tyBKxhrFNHcl86SijfYiNAQcEDF/Gma7U6r6Fm2gUG6+24+APodBCULPZnp6?=
 =?us-ascii?Q?z/J9iyJdJfQzoEZMFFsUfesoylYwJYdGd3k0rb8dSKLXk5y44DbrVLUe8jSr?=
 =?us-ascii?Q?I5srB+7qlh+mdVZG85M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:18.3805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56994292-95a7-4f26-97a6-08de2ba8e84d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9205

From: Cosmin Ratiu <cratiu@nvidia.com>

Devlink rate leafs and nodes were stored in their respective devlink
objects pointed to by devlink_rate->devlink.

This patch removes that association by introducing the concept of
'rate node devlink', which is where all rates that could link to each
other are stored. For now this is the same as devlink_rate->devlink.

After this patch, the devlink rates stored in this devlink instance
could potentially be from multiple other devlink instances. So all rate
node manipulation code was updated to:
- correctly compare the actual devlink object during iteration.
- maybe acquire additional locks (noop for now).

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 include/net/devlink.h |   2 +
 net/devlink/rate.c    | 192 +++++++++++++++++++++++++++++++-----------
 2 files changed, 144 insertions(+), 50 deletions(-)

diff --git a/include/net/devlink.h b/include/net/devlink.h
index cb839e0435a1..df481af91473 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1814,6 +1814,8 @@ void devlink_port_attrs_pci_sf_set(struct devlink_port *devlink_port,
 				   bool external);
 int devl_port_fn_devlink_set(struct devlink_port *devlink_port,
 			     struct devlink *fn_devlink);
+struct devlink *devl_rate_lock(struct devlink *devlink);
+void devl_rate_unlock(struct devlink *devlink);
 struct devlink_rate *
 devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index 0d68b5c477dc..ddbd0beec4b9 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,13 +30,31 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+struct devlink *devl_rate_lock(struct devlink *devlink)
+{
+	return devlink;
+}
+
+static struct devlink *
+devl_get_rate_node_instance_locked(struct devlink *devlink)
+{
+	return devlink;
+}
+
+void devl_rate_unlock(struct devlink *devlink)
+{
+}
+
 static struct devlink_rate *
 devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
 {
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate) &&
+	rate_devlink = devl_get_rate_node_instance_locked(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate) &&
 		    !strcmp(node_name, devlink_rate->name))
 			return devlink_rate;
 	}
@@ -190,17 +208,25 @@ static void devlink_rate_notify(struct devlink_rate *devlink_rate,
 void devlink_rates_notify_register(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(rate_node, &rate_devlink->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink);
 }
 
 void devlink_rates_notify_unregister(struct devlink *devlink)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
-	list_for_each_entry_reverse(rate_node, &devlink->rate_list, list)
-		devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry_reverse(rate_node, &rate_devlink->rate_list, list)
+		if (rate_node->devlink == devlink)
+			devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
+	devl_rate_unlock(devlink);
 }
 
 static int
@@ -209,10 +235,12 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 {
 	struct devlink_nl_dump_state *state = devlink_dump_state(cb);
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
 	int idx = 0;
 	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
 		enum devlink_command cmd = DEVLINK_CMD_RATE_NEW;
 		u32 id = NETLINK_CB(cb->skb).portid;
 
@@ -220,6 +248,9 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 			idx++;
 			continue;
 		}
+		if (devlink_rate->devlink != devlink)
+			continue;
+
 		err = devlink_nl_rate_fill(msg, devlink_rate, cmd, id,
 					   cb->nlh->nlmsg_seq, flags, NULL);
 		if (err) {
@@ -228,6 +259,7 @@ devlink_nl_rate_get_dump_one(struct sk_buff *msg, struct devlink *devlink,
 		}
 		idx++;
 	}
+	devl_rate_unlock(devlink);
 
 	return err;
 }
@@ -244,23 +276,33 @@ int devlink_nl_rate_get_doit(struct sk_buff *skb, struct genl_info *info)
 	struct sk_buff *msg;
 	int err;
 
+	devl_rate_lock(devlink);
 	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	msg = nlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
-	if (!msg)
-		return -ENOMEM;
+	if (!msg) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_fill(msg, devlink_rate, DEVLINK_CMD_RATE_NEW,
 				   info->snd_portid, info->snd_seq, 0,
 				   info->extack);
-	if (err) {
-		nlmsg_free(msg);
-		return err;
-	}
+	if (err)
+		goto err_fill;
 
+	devl_rate_unlock(devlink);
 	return genlmsg_reply(msg, info);
+
+err_fill:
+	nlmsg_free(msg);
+unlock:
+	devl_rate_unlock(devlink);
+	return err;
 }
 
 static bool
@@ -590,24 +632,32 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 	const struct devlink_ops *ops;
 	int err;
 
+	devl_rate_lock(devlink);
 	devlink_rate = devlink_rate_get_from_info(devlink, info);
-	if (IS_ERR(devlink_rate))
-		return PTR_ERR(devlink_rate);
+	if (IS_ERR(devlink_rate)) {
+		err = PTR_ERR(devlink_rate);
+		goto unlock;
+	}
 
 	ops = devlink->ops;
-	if (!ops || !devlink_rate_set_ops_supported(ops, info, devlink_rate->type))
-		return -EOPNOTSUPP;
+	if (!ops ||
+	    !devlink_rate_set_ops_supported(ops, info, devlink_rate->type)) {
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
 
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
 		devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
 int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 {
-	struct devlink *devlink = info->user_ptr[0];
+	struct devlink *rate_devlink, *devlink = info->user_ptr[0];
 	struct devlink_rate *rate_node;
 	const struct devlink_ops *ops;
 	int err;
@@ -621,15 +671,21 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
-	if (!IS_ERR(rate_node))
-		return -EEXIST;
-	else if (rate_node == ERR_PTR(-EINVAL))
-		return -EINVAL;
+	if (!IS_ERR(rate_node)) {
+		err = -EEXIST;
+		goto unlock;
+	} else if (rate_node == ERR_PTR(-EINVAL)) {
+		err = -EINVAL;
+		goto unlock;
+	}
 
 	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return -ENOMEM;
+	if (!rate_node) {
+		err = -ENOMEM;
+		goto unlock;
+	}
 
 	rate_node->devlink = devlink;
 	rate_node->type = DEVLINK_RATE_TYPE_NODE;
@@ -648,8 +704,9 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 		goto err_rate_set;
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &rate_devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink);
 	return 0;
 
 err_rate_set:
@@ -658,6 +715,8 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	kfree(rate_node->name);
 err_strdup:
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
@@ -667,13 +726,17 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	struct devlink_rate *rate_node;
 	int err;
 
+	devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_info(devlink, info);
-	if (IS_ERR(rate_node))
-		return PTR_ERR(rate_node);
+	if (IS_ERR(rate_node)) {
+		err = PTR_ERR(rate_node);
+		goto unlock;
+	}
 
 	if (refcount_read(&rate_node->refcnt) > 1) {
 		NL_SET_ERR_MSG(info->extack, "Node has children. Cannot delete node.");
-		return -EBUSY;
+		err = -EBUSY;
+		goto unlock;
 	}
 
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_DEL);
@@ -684,6 +747,8 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	list_del(&rate_node->list);
 	kfree(rate_node->name);
 	kfree(rate_node);
+unlock:
+	devl_rate_unlock(devlink);
 	return err;
 }
 
@@ -692,14 +757,20 @@ int devlink_rates_check(struct devlink *devlink,
 			struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
+	struct devlink *rate_devlink;
+	int err = 0;
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (!rate_filter || rate_filter(devlink_rate)) {
+	rate_devlink = devl_rate_lock(devlink);
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list)
+		if (devlink_rate->devlink == devlink &&
+		    (!rate_filter || rate_filter(devlink_rate))) {
 			if (extack)
 				NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
-			return -EBUSY;
+			err = -EBUSY;
+			break;
 		}
-	return 0;
+	devl_rate_unlock(devlink);
+	return err;
 }
 
 /**
@@ -716,14 +787,20 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 		      struct devlink_rate *parent)
 {
 	struct devlink_rate *rate_node;
+	struct devlink *rate_devlink;
 
+	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_by_name(devlink, node_name);
-	if (!IS_ERR(rate_node))
-		return ERR_PTR(-EEXIST);
+	if (!IS_ERR(rate_node)) {
+		rate_node = ERR_PTR(-EEXIST);
+		goto unlock;
+	}
 
 	rate_node = kzalloc(sizeof(*rate_node), GFP_KERNEL);
-	if (!rate_node)
-		return ERR_PTR(-ENOMEM);
+	if (!rate_node) {
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
+	}
 
 	if (parent) {
 		rate_node->parent = parent;
@@ -737,12 +814,15 @@ devl_rate_node_create(struct devlink *devlink, void *priv, char *node_name,
 	rate_node->name = kstrdup(node_name, GFP_KERNEL);
 	if (!rate_node->name) {
 		kfree(rate_node);
-		return ERR_PTR(-ENOMEM);
+		rate_node = ERR_PTR(-ENOMEM);
+		goto unlock;
 	}
 
 	refcount_set(&rate_node->refcnt, 1);
-	list_add(&rate_node->list, &devlink->rate_list);
+	list_add(&rate_node->list, &rate_devlink->rate_list);
 	devlink_rate_notify(rate_node, DEVLINK_CMD_RATE_NEW);
+unlock:
+	devl_rate_unlock(devlink);
 	return rate_node;
 }
 EXPORT_SYMBOL_GPL(devl_rate_node_create);
@@ -758,10 +838,10 @@ EXPORT_SYMBOL_GPL(devl_rate_node_create);
 int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 			  struct devlink_rate *parent)
 {
-	struct devlink *devlink = devlink_port->devlink;
+	struct devlink *rate_devlink, *devlink = devlink_port->devlink;
 	struct devlink_rate *devlink_rate;
 
-	devl_assert_locked(devlink_port->devlink);
+	devl_assert_locked(devlink);
 
 	if (WARN_ON(devlink_port->devlink_rate))
 		return -EBUSY;
@@ -770,6 +850,7 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	if (!devlink_rate)
 		return -ENOMEM;
 
+	rate_devlink = devl_rate_lock(devlink);
 	if (parent) {
 		devlink_rate->parent = parent;
 		refcount_inc(&devlink_rate->parent->refcnt);
@@ -779,9 +860,10 @@ int devl_rate_leaf_create(struct devlink_port *devlink_port, void *priv,
 	devlink_rate->devlink = devlink;
 	devlink_rate->devlink_port = devlink_port;
 	devlink_rate->priv = priv;
-	list_add_tail(&devlink_rate->list, &devlink->rate_list);
+	list_add_tail(&devlink_rate->list, &rate_devlink->rate_list);
 	devlink_port->devlink_rate = devlink_rate;
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_NEW);
+	devl_rate_unlock(devlink);
 
 	return 0;
 }
@@ -797,16 +879,19 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_create);
 void devl_rate_leaf_destroy(struct devlink_port *devlink_port)
 {
 	struct devlink_rate *devlink_rate = devlink_port->devlink_rate;
+	struct devlink *devlink = devlink_port->devlink;
 
-	devl_assert_locked(devlink_port->devlink);
+	devl_assert_locked(devlink);
 	if (!devlink_rate)
 		return;
 
+	devl_rate_lock(devlink);
 	devlink_rate_notify(devlink_rate, DEVLINK_CMD_RATE_DEL);
 	if (devlink_rate->parent)
 		refcount_dec(&devlink_rate->parent->refcnt);
 	list_del(&devlink_rate->list);
 	devlink_port->devlink_rate = NULL;
+	devl_rate_unlock(devlink);
 	kfree(devlink_rate);
 }
 EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
@@ -815,18 +900,22 @@ EXPORT_SYMBOL_GPL(devl_rate_leaf_destroy);
  * devl_rate_nodes_destroy - destroy all devlink rate nodes on device
  * @devlink: devlink instance
  *
- * Unset parent for all rate objects and destroy all rate nodes
- * on specified device.
+ * Unset parent for all rate objects involving this device and destroy all rate
+ * nodes on it.
  */
 void devl_rate_nodes_destroy(struct devlink *devlink)
 {
 	const struct devlink_ops *ops = devlink->ops;
 	struct devlink_rate *devlink_rate, *tmp;
+	struct devlink *rate_devlink;
 
 	devl_assert_locked(devlink);
+	rate_devlink = devl_rate_lock(devlink);
 
-	list_for_each_entry(devlink_rate, &devlink->rate_list, list) {
-		if (!devlink_rate->parent)
+	list_for_each_entry(devlink_rate, &rate_devlink->rate_list, list) {
+		if (!devlink_rate->parent ||
+		    (devlink_rate->devlink != devlink &&
+		     devlink_rate->parent->devlink != devlink))
 			continue;
 
 		if (devlink_rate_is_leaf(devlink_rate))
@@ -839,13 +928,16 @@ void devl_rate_nodes_destroy(struct devlink *devlink)
 		refcount_dec(&devlink_rate->parent->refcnt);
 		devlink_rate->parent = NULL;
 	}
-	list_for_each_entry_safe(devlink_rate, tmp, &devlink->rate_list, list) {
-		if (devlink_rate_is_node(devlink_rate)) {
+	list_for_each_entry_safe(devlink_rate, tmp, &rate_devlink->rate_list,
+				 list) {
+		if (devlink_rate->devlink == devlink &&
+		    devlink_rate_is_node(devlink_rate)) {
 			ops->rate_node_del(devlink_rate, devlink_rate->priv, NULL);
 			list_del(&devlink_rate->list);
 			kfree(devlink_rate->name);
 			kfree(devlink_rate);
 		}
 	}
+	devl_rate_unlock(devlink);
 }
 EXPORT_SYMBOL_GPL(devl_rate_nodes_destroy);
-- 
2.31.1


