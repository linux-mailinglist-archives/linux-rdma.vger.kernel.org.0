Return-Path: <linux-rdma+bounces-15744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12729D3C173
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48EB2460A08
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316C13C1FCC;
	Tue, 20 Jan 2026 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ifK4Gbuf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010024.outbound.protection.outlook.com [52.101.56.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975B3ACA42;
	Tue, 20 Jan 2026 07:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895972; cv=fail; b=Cw4Otsqpn/tD8a+wlYrDikFGVsSF4JUG/V8bmTjP3iXFAcU/i/fIj+Tw/y/a2ROukV2/ot1zNVTeVFhLXOAtCS84FSEhFuDeZEBw3EC2bEzJDZqmLOPD0/ShT2PDwBO5clQ7lYnS1VHABw5/nxJixGyzjaNMJnBgvvPO9Wg8Luc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895972; c=relaxed/simple;
	bh=f8LPyl+SaCVjU2/LXjAAzZ0ZbBodmhHpBwK2bJbokvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cEKFIMDFcvfAU1oo1vFsmd5r9UkRwlRtTuMQsinrN9tpePz/9rihwPoOIr3lytfLj2r2sTUqyIHyScj9ydYAzjJqWUDBLwY6Viwxn7ak1sA3xDp3YWRyZ2b/RKG5oLy9W6JhbYRJmVI5+eyOnerbfWTMrJVVkThF0Xvb5Z16190=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ifK4Gbuf; arc=fail smtp.client-ip=52.101.56.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FiCvZz1c2j7xbk8qGy3QnpqG0v9M1r3pppehFcHSpAqLu2m/6m+lQG/b6yvwXmkvow+BQKbObjp4zCdYVyJVajvLwbTiVg75V0SsqLkXmdZbjKT+WLIfxOScxXcGxwLaUrFlLHh5zpwkZpznE70Jh9aplcifMX1hwuGGPhNan6g2+5A2iIy51BlUyTYpqQMLUWIpwcq5Mm8VVIYUc5BXieGJAgeyoQA97d1mJVYuWpn/IcxKvhOVrviUOQvwBe+cDywx8UrALSE6EUTgdALVpU8eprkhg7V+sVi9hM3FBDJMu5amgJn0IbtU3E/YPP3ov/pn9szpkEmMvxChhR0mYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YivW0uh/ZYcGT1szP9K4piu2uC+IG19LbwQFMu224fc=;
 b=CWl7kvQyPqbkajUwk0LIby7GflMPM5+GcfMYbZQ0hP8oLNg5+0Asvw02qjHpDF7u8f21jyHvHBo9ttlvYjaWJU4yDJQjPxSZ7j7h5cVjY9ljef2HssMernhXZXovXCrS675MAjWq7k3Y7hUOJZhQ8spszTCsBh6T2c3K0H8AojgWoSNimAWzyvMK0ycWzPOE+2PYwtvRIB3BkWhglbtDtrjGjnM+Vf3hmF01zJqGTdlpej06gnTZqbUiAtIZrlrT/kTskjHvrOyuJCylJkbQKj9qMkJ7dzD+PXqYjzZBk9YG06XrQUKRwVr8NCDlEnwloIuvaW5z+wY/I1nTNEdSZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YivW0uh/ZYcGT1szP9K4piu2uC+IG19LbwQFMu224fc=;
 b=ifK4GbufzAMZxJiQkw4BCAA5qCLnE0tggjjK+mNamTKFE35ou9vqD3EPNv/me6wUHxQhZQW4seKFrCrs+RsVO0UgMNPO59tEQm3HhQlyIaV0S1zz1XQ+rFqx557u0JOTWmdofyqM32/l0ZZj56GCZRh5BubJGN7MxklXGbnvP1LecXIEw1yQYIN6XV1of3fsVl+IEouVrQEec1tnHnMBrxduvV/aPcY4PYO3VW6m3ECIzA3x4hNcJSOtl+aI6RE3vZEIwj2maXIIr84jO46kuQy+/aDeO9U9t+hlYlEcP0fprSO1WyhgOmXZ5qMFb2UGAYH3Tjo3c+0/AibXt3709Q==
Received: from BL6PEPF00013DFB.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:22e:400:0:1001:0:1f) by LV2PR12MB6015.namprd12.prod.outlook.com
 (2603:10b6:408:14f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.9; Tue, 20 Jan
 2026 07:59:26 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2a01:111:f403:f903::4) by BL6PEPF00013DFB.outlook.office365.com
 (2603:1036:903:4::4) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.12 via Frontend Transport; Tue,
 20 Jan 2026 07:59:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Tue, 20 Jan 2026 07:59:26 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:16 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:59:10 -0800
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
Subject: [PATCH net-next V5 09/15] devlink: Allow rate node parents from other devlinks
Date: Tue, 20 Jan 2026 09:57:52 +0200
Message-ID: <1768895878-1637182-10-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|LV2PR12MB6015:EE_
X-MS-Office365-Filtering-Correlation-Id: ebe139aa-8eb2-494f-4aa8-08de57f9d4fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QUrv6dFy5EZAGAJltCRzJ4sPJtHycqpxYwLn6lD2Jn6M2uB5y5Ny0TwjnxOI?=
 =?us-ascii?Q?fWZTkKFdw/Dqc7SxzLkwevEqSgdFiEoLJ5P0g+g1v9879I/AseoAI99kTEBG?=
 =?us-ascii?Q?LoeVW9TkMciMg4uHGRCq7IMyxK11NOmfk8vTWVzsyezVkiQdAcWPFiXppL8m?=
 =?us-ascii?Q?YPgY9teWUS6j1io9sfSZWWdWm2nHfi62ak4Wff+/RBstH0o9BogLkzQVejNH?=
 =?us-ascii?Q?wcttyhqIY2CbgfumdJwFGTFogrYHg6GzCm1NP+yR1xCIgXdgkBGodGLw5bK1?=
 =?us-ascii?Q?lnl0CzC0y3ZOTuxBXhUbl7amMfGGY1KrsbVRe+tU7lKGcP/B4B9cVoW4tsE7?=
 =?us-ascii?Q?9BfdjJZ48mghZYGyCBWiR0vi3Viod2RMNw8lhxf1VvTUMsJj5fQizg19cXSt?=
 =?us-ascii?Q?nZopvOc941c1qDajTsFhfFuZRVBFMAhp3Dj6kjXmmSHtfqshcg3ES1/vPyTJ?=
 =?us-ascii?Q?Qfd3z8dBH6O697KDb+lluzZpOqnhCTCVDhZrU0S+6GLHAo0qH1lj/LeMXmL6?=
 =?us-ascii?Q?IlBQjcJ0OAglmoFSwTi3b09VIKba6sPoiaupUix2/Japuj5jfU7fBrIqi0+7?=
 =?us-ascii?Q?Rc7tomN0WIppMfHWnA76dcgX3IUTGP4xhLETWTX674rmACLbq21R0DZ6J6Jx?=
 =?us-ascii?Q?cF6eC6O+n0wjMCY4mabFoT6qEmGI3eM76be1QM2fZkJ92JzGZIsKBAdmv59t?=
 =?us-ascii?Q?0CaFm+TMOCn9QA4K1zgdfAej045YGM7CJl3ikPwSakDcY7nJqFUDsbdJRLZC?=
 =?us-ascii?Q?yAa7caLTme4kmGQ8J7f5zfxH6LDhB7a0nZKRpXwWn5GBxOuUf9wHkv3H0zT2?=
 =?us-ascii?Q?VYHf1l1tsoAOT6bZeGZdsWp76InTtKdXxB7hCeUvDbqexGYJoNzlbkLZrB1m?=
 =?us-ascii?Q?55e/U0wBu9G2rchCtn6MSIvba/Oh8TA2jN6xyNidBmeA70WFYspOXb8ZPGqM?=
 =?us-ascii?Q?NjhWlJraXUq5jjEElrJVO3IprndCf+VUTBQszFE8IYQUDFUFZTFSOK7+AopD?=
 =?us-ascii?Q?Nsjq3eHLNGkOmHh6qeOOGiS6avn2OJV6eO4VVYKiWtjgZA5Bm6mQPU44weJ6?=
 =?us-ascii?Q?iPHY8a/hff00tl+LuQ+EFYYpwbgHrkHFqE6i6JDr2wmM3MTrUSAYyjSNjIz4?=
 =?us-ascii?Q?YfI3YhBqMK7T3Nfdr9JU/NQ5JkV1joSFmI2FznLZM/ijHV1uQq/cimCbzeoq?=
 =?us-ascii?Q?D2lfQ14almd1uT7gpi5aCXf7NxPREE0rSWzsbPOnbxeHxx2nlkf3CU/IjBds?=
 =?us-ascii?Q?peryQf2pd2LtsCw7KTjjYyAdfthS8zjXuaQh2TMzTk0upasux9jWqpcAjr+Y?=
 =?us-ascii?Q?m7AS1nbFnsi/vy9RqBNkDQ6wop10deyxZ2IS/AHadRCKmzq5n3W2jALc8Ah3?=
 =?us-ascii?Q?eNCs+Bjr7OhDlrggc9JKG5T+Jzol5bec9humXAqMQnwC53sfNdq69GSRY9+h?=
 =?us-ascii?Q?0JLGGwmjG0RhocSXLQGtXvkHKkrIpOjsDMW/6OqTB22sXv7oyn3vp/EhtxHs?=
 =?us-ascii?Q?Xrc8gL5s5afVZc/qCtENF/f96kyVohnWVenpEudr/hDh9K/BYWu245pHL7fS?=
 =?us-ascii?Q?MFVtwtLnRS96Toy+TWByiEj3qcCpEeO80M/lTGc9oqmK7w314JsjoskyMYhf?=
 =?us-ascii?Q?6y2xGY6M9S72PYy44NBkNHypj/QnMICXfPlPYsK5iWv689iwg5DESfl7MuX5?=
 =?us-ascii?Q?B+ZiTw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:26.3140
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ebe139aa-8eb2-494f-4aa8-08de57f9d4fc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB6015

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
 include/net/devlink.h                         |  5 +
 net/devlink/rate.c                            | 91 +++++++++++++++++--
 3 files changed, 90 insertions(+), 8 deletions(-)

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
index fbb434185a67..1165dc1ae165 100644
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
index ddbd0beec4b9..886ccbf1fab0 100644
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
 
@@ -646,6 +706,14 @@ int devlink_nl_rate_set_doit(struct sk_buff *skb, struct genl_info *info)
 		goto unlock;
 	}
 
+	if (info->user_ptr[1] && info->user_ptr[1] != devlink &&
+	    !ops->supported_cross_device_rate_nodes) {
+		NL_SET_ERR_MSG(info->extack,
+			       "Cross-device rate parents aren't supported");
+		err = -EOPNOTSUPP;
+		goto unlock;
+	}
+
 	err = devlink_nl_rate_set(devlink_rate, ops, info);
 
 	if (!err)
@@ -671,6 +739,13 @@ int devlink_nl_rate_new_doit(struct sk_buff *skb, struct genl_info *info)
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
2.44.0


