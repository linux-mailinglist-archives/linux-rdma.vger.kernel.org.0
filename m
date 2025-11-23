Return-Path: <linux-rdma+bounces-14693-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C1E29C7DD35
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:28:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7FE383535A0
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D56F2C15AA;
	Sun, 23 Nov 2025 07:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="UVbOyHB4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012047.outbound.protection.outlook.com [52.101.43.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE4D2D2493;
	Sun, 23 Nov 2025 07:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882656; cv=fail; b=nRf4JYp0SwegYhv7zN9tHyRJG08DSLWmS7iqHeUdvkH3Tghkq4MfOBJURcj0tCQKqHYJ/akaMCKh2UlnNWx4dJJEnG5bomOAHWoF/WpjIdbYRjyO4WK4N+jRrOksMcn6Jj7mQa41nmOB6BBY9vIfV4NV8NmJ8QIutDkXd41w/xY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882656; c=relaxed/simple;
	bh=e4UMip5zlJLjD4EFppWhVW2MYA1Sj1FMnNI5AkYneqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bps4DnyQIjJRjxjj4DLg95IKvvrn0JObeDrWknDIVD7/1nwxTm7fq5rZlbNY4kckE7n68iPZd9lVnZImA0FGNIdoOUiZECgCNGT4rgDCBF+zgN9nlAFCqeXAyikRUfHpIt+Lf/5JItORkYtcHeHwD6mGWoOip2ID22ybZ3nICM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=UVbOyHB4; arc=fail smtp.client-ip=52.101.43.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vBnbNY58FUV1gZMwh1QozA/fDixIO0xKH1tUndIkrxs4aEtLzRGm45xR9ZW3fjGxOZj+mR6NxTe+0Gilf7Ontc2JJJxQH4OZ1FXnEaH1AeT+lk0xGEk3OLXAAa0uRUqpiv1XPgSTcUsp5StSdn8FaBmvGrIxETMHOKFNhq0g/ICY735MpTS880TPu927/pRROgy+hCllRc0EKLmmwF/SW2rgGcEJ1t3X0vGsKWn/U0Ck+1BNijcR7nt90EO7hTrO4Jc6U/HIvqSJQZw032PXRfOrPL6IUxIZKE4Q1F0VPMhS3Hz1VI6l6OyRsmIb9BPEq0PAWu/CC75kaShrQGzOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6WCn79jicBvaRTc7FGjKgqmH+CPsvHhzXkkiOoddIY=;
 b=IwtsJjxUk552NXI0FevV0nvsbaL7HRjd40+1PtNwMukOqmQ4kKQbAPPjFfm3gc2vxE8efH2CM2K4iblJ8n5q0bVPEH0CyDHi2melIlnGA6lNEaPFM5AMN2XCoEAwxGZGXZord1kKQ6+I1c2cQyty1PC95p+BbH103Up/0IjHVm2ZktEik/n8mY8CWHLV7y7qowmsZ0NpL5YNjoyCiqJy2D0IBrHD37H8T6fWGRBnmbQLV9a4xay+GK8xF9cp0nl21C9Pzj232ciHPXWi8ngPhHROm9x9lVooiYbtXvEYmQBHuN0i4TCIs9hLgBtnZTdhVC5lB4Clp3ftYxCL7Um5Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6WCn79jicBvaRTc7FGjKgqmH+CPsvHhzXkkiOoddIY=;
 b=UVbOyHB4qcOxKO+iYsVD7W4qdRTtNbpNxK7EtrC+j3GdaPU0cgC0NOeLWoZtbNKY3MP+QraKF726TuAH/hgO4ZUdZ5yxHEEbvqg+5OgP54kqUmK5QMKL57CzUOA0D9iyW8kdICoTobjvg6mkWv5BH7IbQjZF0kVbdi5Q9afsZrQMp/CC7anhGzphJYyjCVDI3H5weHvp5Z+jRoGvpd1yAJIyl0Lq0ByuNyWG5AGbzWS1+bbVJeLuVtGAsD0hCwR8n7dvpCvFRGz3eR7uBMxIIvxFQxrQZpromYQ4HNLTM4ELChGq26l5ZL+on0HKDpKDd2gRKVi070BHIQ6/J7/HHg==
Received: from DM6PR11CA0002.namprd11.prod.outlook.com (2603:10b6:5:190::15)
 by DM4PR12MB8522.namprd12.prod.outlook.com (2603:10b6:8:18f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:24:10 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:5:190:cafe::6c) by DM6PR11CA0002.outlook.office365.com
 (2603:10b6:5:190::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 07:24:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:10 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:01 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:00 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:55 -0800
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
Subject: [PATCH net-next V2 08/14] devlink: Allow rate node parents from other devlinks
Date: Sun, 23 Nov 2025 09:22:54 +0200
Message-ID: <1763882580-1295213-9-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|DM4PR12MB8522:EE_
X-MS-Office365-Filtering-Correlation-Id: eaf6e33f-255e-418f-c0e1-08de2a614bb0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|7416014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I72igR2jUgf4Kp4QxP2L2Q5pf1zct7kLbNbIHXsUUq0N3tqOmatW4xe3fiCN?=
 =?us-ascii?Q?I5gWqiiPwcrzeTu+X438r+ENmLqIjWnu84DiRqIPu7qBMq1v/bc8VGv5CRBB?=
 =?us-ascii?Q?TMluLTvtMZU6/7MVEypwmIqTgFjWK2okHvikwOsZL+I38uT62XDePdQT6KnD?=
 =?us-ascii?Q?jnOT2kuVhtSO8Gxc7fm4HEx8nznXnaLmF7S1xMNEwe1vdNGlxNnb1s1D5PMu?=
 =?us-ascii?Q?kFarbQdTSkB/a79KEP1UjAqYwLmC+mSOQGfCpnBH9/l9Np+X8dohRAK2ZOUu?=
 =?us-ascii?Q?+4ibFjo1mJXuq2WECONUtGr4u+BKQela0RTuFcNXxHh8pCTBtvrxGLYj9BqU?=
 =?us-ascii?Q?yPfd2CX2Pc1rfK094U5rU6D19yVvGkUyX3wHMGeC/0f2M7tpnyhtpfOeD/Gj?=
 =?us-ascii?Q?f/2RIYd+xxk17StLsjCuGbOu6g9dTD3x0BJ0OxxKfv6alMQrPhJUVOC35Enb?=
 =?us-ascii?Q?Yly5kQl9IW6VRtpZfxTeyuqGOLM6nIMzDFLuz2ZIvQh9SniCfZ70qVjPZ49O?=
 =?us-ascii?Q?6RwnD4ZD4vAa4q7leFrEukIB3b7FKyxeCvwldlYJPo267PLfQHoJyCr9TFrS?=
 =?us-ascii?Q?tnjDqzEjhEGP60Kq46IbpjyCQrDCHS01tf9GwpLqNiHMOuVmQW9qqGOnjxw1?=
 =?us-ascii?Q?429WfnJdcD/wa4HB9v8JG3CGGLw7TYrLa1vd/wLuYcIdLPpH3svfG7wWdYi4?=
 =?us-ascii?Q?3Uaq+Lejm6toOv/6a2PBky8cc+/f+aQ8CUsv1728oOqdB7Csob3ADhFdija1?=
 =?us-ascii?Q?HnHyN5BqxUm1dtOcskc0Sw9Zb2p5n8kwKbxeFWeaJHTdIic4h3Nu5TZe3C7Z?=
 =?us-ascii?Q?oYf9m4z9xRdkw+HwKldMjY6jDXKu+CIY5R1ZR5SyLF/0R8rUBaB9fYmscNID?=
 =?us-ascii?Q?PXFlMydEDQTgxNAD5pBHU8w0DN8PW7/6fHmKEN8OWsxfr0LroQyo6Cs45HSJ?=
 =?us-ascii?Q?LWKV6Szx0QfaReCz4ZpHASg2mbxcbAnFpq0PDsLk8WBdKSdh2dudl4ifsMBh?=
 =?us-ascii?Q?cume/pFZR43A6qyIrJERnVz9LVrx2ebnq2QoYsS7GuuTVP/zioIxfICXxeh1?=
 =?us-ascii?Q?vUW9Eu/cK5Qupmymli+BcwXL76Qb9mjnVhF9Og8thDjxGJS9N/8zjftT5DFV?=
 =?us-ascii?Q?Ti3emZn0Sli9x8snU5SnfrHcYF2+EsH7L3GVK5q8d1BDQihx2hTLu4W5alIP?=
 =?us-ascii?Q?SMlTSkI+vhEPVlMkPIpVCsxJC/GtmOyMKoBw8yGWPU8zyw8rlcqDaKCC3geS?=
 =?us-ascii?Q?b9ToTX3J9hwDCFUI8uPw0kpoaCLf0he/z7WsRhJdvaDcavEfBtlC+np4f7lO?=
 =?us-ascii?Q?P+eZKTqNMEA4a7iBsebMU5FKBRLcK3sFCD0Jw+PzDhqWSESOBhKkGNTd6yJg?=
 =?us-ascii?Q?xMNF4HEQFNbtM6TZgw7qpt5r2g0S3StcPl59cUFQh5eFlZLXFim+KS4ni2Lt?=
 =?us-ascii?Q?iaZm+HCBUppIWkN7nQCOa/xY3TrRxBhWXHlj70FpWEDm33cLuA3Y/zAiCV3W?=
 =?us-ascii?Q?aJiKo7uGvwjQ9UzeZOeFYxDh6xgnn3O654id5n5dk54ey9f6ueIAW8Hjm9KW?=
 =?us-ascii?Q?DRhQ4pDQE0kupvxXJEU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(7416014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:10.1744
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eaf6e33f-255e-418f-c0e1-08de2a614bb0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8522

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


