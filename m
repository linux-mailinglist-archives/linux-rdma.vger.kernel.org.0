Return-Path: <linux-rdma+bounces-14730-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98581C82AC6
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAF8A3AE7A4
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A4F335553;
	Mon, 24 Nov 2025 22:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Iwivl/w/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012021.outbound.protection.outlook.com [40.107.200.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1962F744C;
	Mon, 24 Nov 2025 22:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023396; cv=fail; b=GELjbZwDhusyNqHF6QqxDTwBDgOTe2+97Ad+skMzcaFGR1mc2shTxn5kqgoYAFZUWAFejjHOLxWFj9KFLUQynPLF/90u6ubykBW7NXiOdfwFwAcdQZcAAgWvWHi+x4tP130PyRlx9B4a51LqtR5iMU5o+ikZKugGY1IeEXDpFfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023396; c=relaxed/simple;
	bh=e4UMip5zlJLjD4EFppWhVW2MYA1Sj1FMnNI5AkYneqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ExHSSJsh8p99GohOQN49uxNl4U2C2Mm0yiS8DswXFvosxiSEqZdeLgAAD5f07xjxYOPF0wZkk0rGfBZP3iu4aVZoo18eUcWf3thVkP5iScmY6N2Jco7qWgVZBZXd5qbmm5vGvWLMSOtz/wqOofr200XpLv9CRlwdOcA+Du7wYPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Iwivl/w/; arc=fail smtp.client-ip=40.107.200.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tf/qYyrvEv6ESz3PHR5mKlAukHWCFmAE/wH9DdMby3T8+v/iWMgJo1KRoWDRPzeXN1oUW47mKGOLgQv3wRe3vyn5Ka1+lplBAPpQgPq7CrxK6DaNFLNpw1p4h6L2PZu4YFG72EFQd91RfHzwZhsbGf0xcbw2bIDDhgqRj3rWTb6nxzPn+unI1nrs0OOfB8gI/9jrb8s1piHWVeRhVz2W9Y+1MVp2LNaNUe1wo82rtUKEH+cRzNh6xoAePXwsczmRaHwkL9vW6oScMZetgxoUX0x7YO1Ftdq/TX178ibIMTByxuLifpB/lx8pUjfi5UYvJg9O+KYs2X0I7OXwjBgAfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6WCn79jicBvaRTc7FGjKgqmH+CPsvHhzXkkiOoddIY=;
 b=tk6VJQ/Xvfv+HO3QAVSw2++Vnd43OIjS7SKVV1w82Ptua6v20WOvnJIfYp87W+bFVDia20Zi6gXN5zOA1cVgHfFzagLiUY7G5fwHvEycQKi+n0VlnfaidhYnujh1aLEk3rtlB9nT0HrOTtFLQ6Cu4uMPFXIUm0vUYgjmzrvkn1KImXVEW4cSpHLqTE0Da++73csCVFhxvuYbknlkePTnoYXsEQRv/MGo3MpKiHrkhI00Rnq5MdmPQf4hU8iTeagzgW0n9IiF3NKiXYpSrXT6EIXk735FIyJlqNWnd5+6/1qUF5mI/S+ygIyhIdOX+yQ+dP3f29icvboialnIyY4iuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6WCn79jicBvaRTc7FGjKgqmH+CPsvHhzXkkiOoddIY=;
 b=Iwivl/w/HBVJQCO9G7KJFY1N41Tto9xgpsXpE9UHIFY1XgtehnThZVRO8ZIdwjsttFcQFAU3JUPobGhYCaUbpN5e8LxHlan1DuH4c4OZL3b5YE4BFHxqeji4XgJOnk9obaJtb2YscjTf1Mh8KqwW/Hc4BoYDz42LMVoVLIvc2lhCes/lgp91aWGKgrWDizKPrVmmdvmAg1OVWpSFLqm6AaXLrOU6uwwnokYU7yvkGb9fmRhm5A6O71D/izZy6pJWU8Ja5CyJF7pqqWwgUmL0dZnThnxZhf0JAk8IDn36le/00olCTzQO3VHpyua5rKCjQTi8HPjLFUvOBN0qRSpgfQ==
Received: from DM6PR02CA0101.namprd02.prod.outlook.com (2603:10b6:5:1f4::42)
 by DS0PR12MB8270.namprd12.prod.outlook.com (2603:10b6:8:fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:39 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::5a) by DM6PR02CA0101.outlook.office365.com
 (2603:10b6:5:1f4::42) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:29:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:38 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:25 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:25 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:19 -0800
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
Subject: [PATCH net-next V3 08/14] devlink: Allow rate node parents from other devlinks
Date: Tue, 25 Nov 2025 00:27:33 +0200
Message-ID: <1764023259-1305453-9-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DS0PR12MB8270:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a36f94d-9839-4403-6b67-08de2ba8f490
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QE0WtHlBiZTMQrZ//hBEL8DFqO85Q3ssM+0jxO282oXkkmf0qVT7c2JciD11?=
 =?us-ascii?Q?5caQ0203O76gO4p3xyOxFIgzwkNIvlZjbwZZCbZpoRKhMcZLQDUe7NntYQcS?=
 =?us-ascii?Q?937Kw/kX0ocwJmYBdmN5PnMZGeWJlLvFEhgMGwb1HWtj0ORatcSBh7bQRGIA?=
 =?us-ascii?Q?/6PCcIYkFxvOIBw6ueL9DUZVqIHWLz1WJvdgL1840c4wBScR7Mp26AzFVZUW?=
 =?us-ascii?Q?zxvXMGy5vqbo5BToX05sEtErMrNlwfXksfhN+QEkoKTbEOCAhZvhmONS/S5a?=
 =?us-ascii?Q?wCK2wZH4jeZSmqLWIt/0O9UPzzuqXcXMyhl7FsYVNaj0QFOjqsTqhQtM5RHL?=
 =?us-ascii?Q?SeOlw4PPgE0XFUHS7D0Aq+S8Y1fcyA4jA4XIhziKg6Oj2zHDqLoYQ65EhYeE?=
 =?us-ascii?Q?b+8xObSgYtWIW5ExxYTfkh93Vrr3ZAcTxFIdS6b0CZYDBTYtZ94DSU6BkTrY?=
 =?us-ascii?Q?pNO4X8AQWN7Dte7ERcYq8tonAGCly1M6yvrjPNxUQmwC8kOYB6hBwJCJs/RS?=
 =?us-ascii?Q?WoL2GgkVYeTrG0+mdoL84Amcze+R2u3RKlY5sCqbOwpRStF0IkRHJ6yHFQ6W?=
 =?us-ascii?Q?pVSw824zJGzfSl4Y2i647ib9S6+rxq7RSByWor/rnaCuLc80+HhrxBhFvBjU?=
 =?us-ascii?Q?idBv0eXLgB9K0vmZp+3fP13ulTra3NWPvq0Ul00iSLWhRF86Ad0KLjItr/3b?=
 =?us-ascii?Q?0qBzKRA2l2Lr/Ik+8pdNu33NxdjECpnbST4msplnabtQwwYfAdMpnH5yBOMj?=
 =?us-ascii?Q?E7Wmqcd03AvUZZgUsCbCyqK5SIz5MoQB2lOoBEzgFPyeWkHck0yCtPftla4d?=
 =?us-ascii?Q?cdjNT0M5SAfCYG0cEnomudpzgaLjZmx5fI3UqaGbQMKPVfD4V7FivIeFrtbU?=
 =?us-ascii?Q?tZp0gn6XIdJgWREqc2SNua7kABdI6QfzQL2+C+zAsMZGgZZ8C7uZrVlKOnt3?=
 =?us-ascii?Q?GpHbgRSuvuvqdt8CWcFt9WS99Pn17LfbXcxGz+DwnlxqgBo6h2o1FjkIteS0?=
 =?us-ascii?Q?fyH5lKRfGQlCNBkQalJYW0vVditaBqRFF8s7Bs1dtyqoggMfC19vaMzIHlxs?=
 =?us-ascii?Q?iL/3JiaqqIgoG6qbiKVLH15Z8QojDjT64PdIb9ono47Su7lmWKDgQvXS9ix5?=
 =?us-ascii?Q?ou4M4NlcVlf1gyc6AVOqiqZQsONa1NwMhnKD8VGV6b23Ue+EnoF/HF0MxlKB?=
 =?us-ascii?Q?f1iJSYSqmDyB2C1TXGcMB+7zTeoubAYcmJMLrKvE/iQVBpWv1SLA+WV31nLz?=
 =?us-ascii?Q?Rax5cBgte+O79UtUbhbMFM16NueoVCHgyfoCFgQ/bJic+FGyD4C6Srcgd+68?=
 =?us-ascii?Q?bM3G2+njIygJJNCi5huuZD15OuyEvVlyLfQOSkej3KvqcTxiLigiqFbwV7qY?=
 =?us-ascii?Q?8sda/DTGEn3i1mbC3Ap1gJ6e6+NQTCz3fSj6BMldoXgIrYwHIYa5Kf0OpkqR?=
 =?us-ascii?Q?ZWEpmDEtpo4z8yY7lCS8W0zZaFJkUkHCfyULEu71DW6KxQMvjBjATdrJC4rq?=
 =?us-ascii?Q?Ltru8E1NqCyrCN9LwlRm8aurt7mgk9oMH7g5mrcaPHCqC01E1Ir9nMv+XYY+?=
 =?us-ascii?Q?DG7svIoa3uXgr+791gg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:38.9532
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a36f94d-9839-4403-6b67-08de2ba8f490
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8270

From: Cosmin Ratiu <cratiu@nvidia.com>

This commit makes use of the building blocks previously added to
implement cross-device rate nodes.

A new 'supported_cross_device_rate_nodes' bool is added to devlink_ops
which lets drivers advertise support for cross-device rate objects.
If enabled and if there is a common shared devlink instance, then:
- all rate objects will be stored in the top-most common nested instance
  and
- rate objects can have parents from other devices sharing the same
  common instance.

The parent devlink from info->user_ptr[1] is not locked, so none of its
mutable fields can be used. But parent setting only requires comparing
devlink pointer comparisons. Additionally, since the shared devlink is
locked, other rate operations cannot concurrently happen.

The rate lock/unlock functions are now exported, so that drivers
implementing this can protect against concurrent modifications on any
shared device structures.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../networking/devlink/devlink-port.rst       |  2 +
 include/net/devlink.h                         |  5 ++
 net/devlink/rate.c                            | 90 +++++++++++++++++--
 3 files changed, 89 insertions(+), 8 deletions(-)

diff --git a/Documentation/networking/devlink/devlink-port.rst b/Documentation/networking/devlink/devlink-port.rst
index 5e397798a402..976bc5ca0962 100644
--- a/Documentation/networking/devlink/devlink-port.rst
+++ b/Documentation/networking/devlink/devlink-port.rst
@@ -417,6 +417,8 @@ API allows to configure following rate object's parameters:
   Parent node name. Parent node rate limits are considered as additional limits
   to all node children limits. ``tx_max`` is an upper limit for children.
   ``tx_share`` is a total bandwidth distributed among children.
+  If the device supports cross-function scheduling, the parent can be from a
+  different function of the same underlying device.
 
 ``tc_bw``
   Allow users to set the bandwidth allocation per traffic class on rate
diff --git a/include/net/devlink.h b/include/net/devlink.h
index df481af91473..bef89179db75 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1585,6 +1585,11 @@ struct devlink_ops {
 				    struct devlink_rate *parent,
 				    void *priv_child, void *priv_parent,
 				    struct netlink_ext_ack *extack);
+	/* Indicates if cross-device rate nodes are supported.
+	 * This also requires a shared common ancestor object all devices that
+	 * could share rate nodes are nested in.
+	 */
+	bool supported_cross_device_rate_nodes;
 	/**
 	 * selftests_check() - queries if selftest is supported
 	 * @devlink: devlink instance
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index ddbd0beec4b9..f0a2a746cf23 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -30,20 +30,56 @@ devlink_rate_leaf_get_from_info(struct devlink *devlink, struct genl_info *info)
 	return devlink_rate ?: ERR_PTR(-ENODEV);
 }
 
+/* Repeatedly locks the nested-in devlink instances while cross device rate
+ * nodes are supported. Returns the devlink instance where rates should be
+ * stored.
+ */
 struct devlink *devl_rate_lock(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_lock(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
+EXPORT_SYMBOL_GPL(devl_rate_lock);
 
+/* Variant of the above for when the nested-in devlink instances are already
+ * locked.
+ */
 static struct devlink *
 devl_get_rate_node_instance_locked(struct devlink *devlink)
 {
-	return devlink;
+	struct devlink *rate_devlink = devlink;
+
+	while (rate_devlink->ops &&
+	       rate_devlink->ops->supported_cross_device_rate_nodes) {
+		devlink = devlink_nested_in_get_locked(rate_devlink->rel);
+		if (!devlink)
+			break;
+		rate_devlink = devlink;
+	}
+	return rate_devlink;
 }
 
+/* Repeatedly unlocks the nested-in devlink instances of 'devlink' while cross
+ * device nodes are supported.
+ */
 void devl_rate_unlock(struct devlink *devlink)
 {
+	if (!devlink || !devlink->ops ||
+	    !devlink->ops->supported_cross_device_rate_nodes)
+		return;
+
+	devl_rate_unlock(devlink_nested_in_get_locked(devlink->rel));
+	devlink_nested_in_put_unlock(devlink->rel);
 }
+EXPORT_SYMBOL_GPL(devl_rate_unlock);
 
 static struct devlink_rate *
 devlink_rate_node_get_by_name(struct devlink *devlink, const char *node_name)
@@ -120,6 +156,24 @@ static int devlink_rate_put_tc_bws(struct sk_buff *msg, u32 *tc_bw)
 	return -EMSGSIZE;
 }
 
+static int devlink_nl_rate_parent_fill(struct sk_buff *msg,
+				       struct devlink_rate *devlink_rate)
+{
+	struct devlink_rate *parent = devlink_rate->parent;
+	struct devlink *devlink = parent->devlink;
+
+	if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
+			   parent->name))
+		return -EMSGSIZE;
+
+	if (devlink != devlink_rate->devlink &&
+	    devlink_nl_put_nested_handle(msg, devlink_net(devlink), devlink,
+					 DEVLINK_ATTR_PARENT_DEV))
+		return -EMSGSIZE;
+
+	return 0;
+}
+
 static int devlink_nl_rate_fill(struct sk_buff *msg,
 				struct devlink_rate *devlink_rate,
 				enum devlink_command cmd, u32 portid, u32 seq,
@@ -164,10 +218,9 @@ static int devlink_nl_rate_fill(struct sk_buff *msg,
 			devlink_rate->tx_weight))
 		goto nla_put_failure;
 
-	if (devlink_rate->parent)
-		if (nla_put_string(msg, DEVLINK_ATTR_RATE_PARENT_NODE_NAME,
-				   devlink_rate->parent->name))
-			goto nla_put_failure;
+	if (devlink_rate->parent &&
+	    devlink_nl_rate_parent_fill(msg, devlink_rate))
+		goto nla_put_failure;
 
 	if (devlink_rate_put_tc_bws(msg, devlink_rate->tc_bw))
 		goto nla_put_failure;
@@ -322,13 +375,14 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 				struct genl_info *info,
 				struct nlattr *nla_parent)
 {
-	struct devlink *devlink = devlink_rate->devlink;
+	struct devlink *devlink = devlink_rate->devlink, *parent_devlink;
 	const char *parent_name = nla_data(nla_parent);
 	const struct devlink_ops *ops = devlink->ops;
 	size_t len = strlen(parent_name);
 	struct devlink_rate *parent;
 	int err = -EOPNOTSUPP;
 
+	parent_devlink = info->user_ptr[1] ? : devlink;
 	parent = devlink_rate->parent;
 
 	if (parent && !len) {
@@ -346,7 +400,13 @@ devlink_nl_rate_parent_node_set(struct devlink_rate *devlink_rate,
 		refcount_dec(&parent->refcnt);
 		devlink_rate->parent = NULL;
 	} else if (len) {
-		parent = devlink_rate_node_get_by_name(devlink, parent_name);
+		/* parent_devlink (when different than devlink) isn't locked,
+		 * but the rate node devlink instance is, so nobody from the
+		 * same group of devices sharing rates could change the used
+		 * fields or unregister the parent.
+		 */
+		parent = devlink_rate_node_get_by_name(parent_devlink,
+						       parent_name);
 		if (IS_ERR(parent))
 			return -ENODEV;
 
@@ -646,6 +706,13 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		return -EOPNOTSUPP;
+	}
+
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
@@ -671,6 +738,13 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
 	if (!devlink_rate_set_ops_supported(ops, info, DEVLINK_RATE_TYPE_NODE))
 		return -EOPNOTSUPP;
 
+	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		return -EOPNOTSUPP;
+	}
+
 	rate_devlink = devl_rate_lock(devlink);
 	rate_node = devlink_rate_node_get_from_attrs(devlink, info->attrs);
 	if (!IS_ERR(rate_node)) {
-- 
2.31.1


