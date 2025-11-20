Return-Path: <linux-rdma+bounces-14645-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86B37C7426E
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F04744EBD15
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ABA33E34B;
	Thu, 20 Nov 2025 13:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QVClHUus"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBA533DEE9;
	Thu, 20 Nov 2025 13:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644466; cv=fail; b=m3yuREM0bNZ2ojc1maZT1S2EQTZbz6ZwNtMi8SEOsSc/5MAPCAzXjK5aQsIiKoheO01XMOb890fUm8HqMY7gCp74Bl5EYeyeNe11BulPd+7s8S1qHsGeffnr/3KRbPav/wVMQFw4Pynf3XCGHArNdoEE70Dn8UHeypixHabc9qk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644466; c=relaxed/simple;
	bh=MNXr6pjKbfzOX3KD4IHWIlDIQOCjH8eCSY+Fa024zwE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7HECyoRQt7FXftmZW1SvHhCdgjyTQMCLMazyojpcRuOw7faHSR0tPHfr+jii+Ms/cbsTs893c2joRkCvLI0fNB7Zdc2zzE5rk9/V+95EoShrm1QqKBCdXf7Tk5O/0yiETcfSDyCzzH8l8QZooRHSje17T5z1JzPyG1ePLB7jnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QVClHUus; arc=fail smtp.client-ip=52.101.43.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vErD1iXyOWfpCbfwyWBbQQu9Yt54ixV2WoAfdAmJ04EIBIFIf7VrE3Ve7RuRcbh48YxPdES87rMTL4dkFjnnprOutFsNmxguIUSBZ3Z/OUzxgAYaWAxSQxJQCl3OGujJOxNjSAfekYryrYMhc1EA36JerUDkpPyKQh752Vfc1IwPEJu0Pw8dpvDmMaym8iUdzfOzUmwDpM1jSRVWHDroootFbljSSOGNtDB/RSS4dUw4Ec8usVh+e+fXjC2wOjiAD4JiTI7gv+hK/OTH+zoMz1mIaUGnOEzxIwVm8f1uSeSY94RZuo09oh0IfIVI0sCtsj2dGYuwOrZRXLTbpH9Hew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NtfD+P364o7Escz9COi7IvmIz8T3l/r7gbDI5p6Xtt4=;
 b=ehsoXM3TaO8JGdJqztfQS08dVQFH8C/JUCFKw4/SV8txIqMw8Uy2CiIVCQHKN1b4CLx7GsgUxO8FgXs6KdU3ww3IYHt5dvQgvbhIz57udyXfT5bmDZ4n9B3ISlVqqDbifvTxxKXjvg/YOw9mrEYMzVbY5BEepl7oVD/1VZkXVKHJXvPHWkFF/dZ+CjcEesgWq4LBogUCYsusVgmTkCw/zy4nYQ5Cl5AUoLqt/9aG0WfPsTpElGBGLFJxBor8+mkZeVfrXi7u/jG4Ou2A/Jmxz9QgqDQdTqp9hb71cXzVIeAsfmBeJZTEXBHeQWrO3KKK23V7PMJ6vHeM1KjKoRekMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NtfD+P364o7Escz9COi7IvmIz8T3l/r7gbDI5p6Xtt4=;
 b=QVClHUuskQSBFrxQTsn8UxoXLRNxY/3EUMzkDmNizh7j5p6TW5mrHo+7ZGA/ZxlbEA0TgOaR4A91P0PItFHheZUm0trmqrQbpgPwXQrzpHkvo87jG68c0WmAFgcw6tpsPxvrFnUmXWw9U2EQIru03HLGTySdfUKAQLdBgw/gZt0IxoMbHUfsqzS67jVoN3CfJL1HugIYtiSeuQYy/SfHvkUqb/W2+pwBHACKoYQpOV9IP61ZlrIC0f/yJC9YwfCLa228wO8CHaQJiWTzX6zTj9X1TyeLg8wmym98Jg7REukJ6dQrjTEdlQnB/tyA6BsOX8YwLet3vjZpz5ePMMKi0Q==
Received: from BN0PR03CA0057.namprd03.prod.outlook.com (2603:10b6:408:e7::32)
 by CY3PR12MB9679.namprd12.prod.outlook.com (2603:10b6:930:100::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:14:19 +0000
Received: from BN2PEPF000044A9.namprd04.prod.outlook.com
 (2603:10b6:408:e7:cafe::e0) by BN0PR03CA0057.outlook.office365.com
 (2603:10b6:408:e7::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:14:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A9.mail.protection.outlook.com (10.167.243.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:18 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:00 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:59 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:53 -0800
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
Subject: [PATCH net-next 08/14] devlink: Allow rate node parents from other devlinks
Date: Thu, 20 Nov 2025 15:09:20 +0200
Message-ID: <1763644166-1250608-9-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
References: <1763644166-1250608-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A9:EE_|CY3PR12MB9679:EE_
X-MS-Office365-Filtering-Correlation-Id: 15be636e-50a2-4508-fae2-08de2836b664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyxWGXmFqAHVeYY1ePWakyacqaLeG+LGJrd2S30sxCt8Y47BmUijcYxHc+mr?=
 =?us-ascii?Q?TAIYB8J2UP6eUek58J2JcBe+nKk5rBUFKaTxHMIpE0uKSKSWcATA3cMh72Nk?=
 =?us-ascii?Q?I/o9lnyyFDTwbUIqHzSBp8gA4hQFJUKgL5IHpQ8UMgsv6klP5z1z5xNasFIO?=
 =?us-ascii?Q?YEkx6epTBVB6VawBkW+6JMa/2A4sT+d2/MKXmmQn3MoFvq4oAvKbkibwYsNz?=
 =?us-ascii?Q?ypP1giWVfoeKQg0pSGmW4XQnBaIQArxsfuwjJ9xdlSahOgy16TY5l3HYyiJ9?=
 =?us-ascii?Q?0TbidhhA8Oxi7zHOCQe5frJFB8+ArY8S1uhr3U8XblA9VVDCPYz42HQeihsm?=
 =?us-ascii?Q?vYCR19X+hLUAUIk2umOSC1DMSIu10pvZbcKWZR9vIZqQPjRRIcXa+K9ec8RG?=
 =?us-ascii?Q?tYb2xETcbYG8zxrV3EbkKahERZL1sk+hupq7Fc9flPO+KDqwbWCpGm9AV8yo?=
 =?us-ascii?Q?oSgmHlNDjsHHGRuped+H5lpf5hBtpfKbOGWdmc+84cyoBWm9CpbDkXMReBfi?=
 =?us-ascii?Q?JCYTanDQcZ4TyAh5V43rGvNbtgrHvNR0tgF5rFqAf+0VF7Dv3kEx2PNSt0yj?=
 =?us-ascii?Q?Yvw8F6ZqwyjLNIosctt8Y8VjSnczx4p4Z9U1C0R8Y2Calmwnu73s6hMSIn5y?=
 =?us-ascii?Q?EadjvWZJDtXC5ekAnF6Bl4i3oXm8m5iZ9+8dJ0AwyuJvCcpp9jP1FMo7tGzY?=
 =?us-ascii?Q?TQXfZYQfkZE/y144afmJDK0m9Ho0sC9JVCJD8s8HOEbBQ7RBMZy6j7O/vFu3?=
 =?us-ascii?Q?YziwgIzCbQP5Euah/BXD9RADCx79XJx0uQ8AC6EhjRfQ5oePnsjbgb82SG2s?=
 =?us-ascii?Q?TSesNniuqxyfq6dhrEUNMiGIY6ijooTPK3JQrPZGFTLgESfPX0zvgHDf5fME?=
 =?us-ascii?Q?VQTEPGpU+DYisb7vaaLlXY5jPNkWaC9kgCGNxG7hSJ9m2jM9seKBEtXDL3/i?=
 =?us-ascii?Q?cxazfe+w6bEyJMNS9/1xyPcJaF7dDYmxDBkhiVo48pGRZdJCT5Qw3Li1Ssya?=
 =?us-ascii?Q?iIMve0xGo1q/yd+C47zO+d/OiYQZMa2gjEUEC8m1zDmkbp/SYRQUWTmmyfom?=
 =?us-ascii?Q?mv0v8FW62KBA1EKJONF4NIEcPzXbELVZzGAD0tIw/1dKXkVZjV3rsuJYzE8G?=
 =?us-ascii?Q?Fvv5av4yQfxDJ5kiK9Pp8eSHr+2wMUabgs/D4FF4FUYWk+LzwtEJVl0wtPZQ?=
 =?us-ascii?Q?zlJJLp7I06hD/0JTHYLzpyPRQAyJ0fJYBHokQ/U9fq+Zvuc7pnSZOH6gHcPy?=
 =?us-ascii?Q?2tTdDmg6PLd0d6NWFmC2FYZG0bXJOXOFQFycO4f/ANjJP8hPdvuPFwGNU75N?=
 =?us-ascii?Q?bo3Rp30baAUhyh9aURa6wXCAqM9qBHCiFrMQt62arsJv3oD7hz7PViNsfwpe?=
 =?us-ascii?Q?Y6lbBdiJKgjX4Ofw1Yic1w83N3FHfGXDayLHV4ehRjvUpmVHqo10Z1GRpqiT?=
 =?us-ascii?Q?m78ynzzSQ+PIXxTOAEC49ifyYV0ALfxt1PGGNWVxtTA/5FbVL+WEk7Ad1NOA?=
 =?us-ascii?Q?i8YJP9nUrh5+CNINQ6QxGxC5M54KjSR38AFYYYvMhM5LASDWXLpg1K8mU/zZ?=
 =?us-ascii?Q?0n+XL7pTZWcfYag7WmM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:18.4771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 15be636e-50a2-4508-fae2-08de2836b664
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A9.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9679

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
index 7e7789098f0e..1cbd37aee3e3 100644
--- a/include/net/devlink.h
+++ b/include/net/devlink.h
@@ -1542,6 +1542,11 @@ struct devlink_ops {
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


