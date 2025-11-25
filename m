Return-Path: <linux-rdma+bounces-14767-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 854FAC86F03
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 684E3341D7F
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08F733BBD4;
	Tue, 25 Nov 2025 20:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sCu5sjb5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012008.outbound.protection.outlook.com [40.107.200.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AD33BBAF;
	Tue, 25 Nov 2025 20:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101275; cv=fail; b=khyZTjluVB/9tfIU37/v8NYuVEy4GZ3bIRohsAR5mIltVKc5vaWriCP47Iyoa5be9C8w2i9qU5SghkUsRo1o5mYKmx18NWMvBAY8OoFFPHq0/FIAHNBBKNNa7OE3CyjYdCOnhqga6PMjt/GFyBo2enkqxXoGqYm/XSDPT0mh7nU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101275; c=relaxed/simple;
	bh=e4UMip5zlJLjD4EFppWhVW2MYA1Sj1FMnNI5AkYneqo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OX8cD0aUX82QqvsoEUylZkP2jRZ+YfmgMfTDRv4u0oS2NKfi2Y3+pnh8Q+7U/ggPTKk0PvZxdWSwGQ9Qi2zJ4c/CqPrm6M71FJuHi7ACCob/h8VFNoSdpx70zHAtbwM35Nw9EGHUD2D07H2nQQ9svpKMCGf0KXTSRPACr/70Iv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sCu5sjb5; arc=fail smtp.client-ip=40.107.200.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ovEZxCs9T6fEk72tGWSDHxi7BYlIDfJtpuRGzdzByVMUG5YjMoip1W2T8x5M40asVrae5FzgokvNllXMVhaqb7Ol34iKPUz7rkH6/hfFBAENHEyWc5O+w35uLoL1Gk/KfX/dyIrMCvP/dgRJ82IMeVcK6tRZz/u7X615uuWOr5DIIfS5BjUFDX2RwHaaM8EZhPiyOqMIYx6MuoYxUoLAI0QmQmy5gvbo+s7sD7fxxKPXKQiYxCHqVJ0t+ZbwmXBg8YPtzcZgHPFPvWSDGEGUe6c1vZX6NbeS8lLKyCS4O7Y8qK5ApJvVy0qvvGx56Ixl/QSZgb5nwKNn/mrrpAogEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6WCn79jicBvaRTc7FGjKgqmH+CPsvHhzXkkiOoddIY=;
 b=anMWSlnQ7HJRpkEUGatkWzD6T/BOHGDeXsBGwriIs2ymhdi+ssIoT4oYQfLfI8qSHBLPs7UM3hzams0POhhWAuZk5OHo6Q2rzaEEFjQonCn5VntXRrHo/wC9mUYQihj70OMMxRabfYFZrQXHDVM3B8hQxAaMHonqtmKQv74kucEpEjwXJn/vwn3FppDbSLiiRU6oEE0RkLVe3/P1vP/Sj7MfeBm0t9/BhUZx6noj4+v5DClEIAMutrI2qMV5e+aqNCyfSJCove1w70NSlVR4t9c7yhmTMW1waRs6sYl73PvBXuf/V4fCmYGM6FEx2tWc/HHllHauPQewTaJ+RDxk9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w6WCn79jicBvaRTc7FGjKgqmH+CPsvHhzXkkiOoddIY=;
 b=sCu5sjb5UXfp3vNSfAz8zpv5Pk1j2IdpqIKqVhHpQdv42VpGcSUpgtGeJDw2EAA/JeA01RZsW49D4FcBCj9MIqnD5MBbXZ9Spr/Kjf6ihdyrvfTh+p1+ei56iKZ3BNtMueyaSHE0XMta1V10ipgXi4smTwklK7HF2m45PzH3K/g/ywMhD05VuTm8w3/us6wUJmj21W+7uwteJ+mkjKGGZNE45Uh9jzw1QIDnvrbmxCOR8IX8tvJ3gD5mNuxejpup2F1jqvRRJOuFSQZSPjj3XC61QeZjp2Suf8KoajTuWqUftbQdqAXvInGDGIP+Rc8xIF9G+gm2HxCD2LsRzjURjA==
Received: from BYAPR07CA0071.namprd07.prod.outlook.com (2603:10b6:a03:60::48)
 by DM4PR12MB6445.namprd12.prod.outlook.com (2603:10b6:8:bd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 20:07:44 +0000
Received: from SJ1PEPF00001CE1.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::88) by BYAPR07CA0071.outlook.office365.com
 (2603:10b6:a03:60::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Tue,
 25 Nov 2025 20:07:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE1.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:43 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:22 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:22 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:17 -0800
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
Subject: [PATCH net-next V4 08/14] devlink: Allow rate node parents from other devlinks
Date: Tue, 25 Nov 2025 22:06:07 +0200
Message-ID: <1764101173-1312171-9-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE1:EE_|DM4PR12MB6445:EE_
X-MS-Office365-Filtering-Correlation-Id: 47ff9fb9-93cd-4493-e4e1-08de2c5e4b96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pbE6zafazRa8X2DbA0ZnRtJi4Lvv9ouVPPwRXYt1jLYEW1SeyJVSWpidO8KF?=
 =?us-ascii?Q?6uR639R7vtVQfnb5/nMPOd+1wCxyCkIvJ02KvBf8D/robtjplfEddonZsLUj?=
 =?us-ascii?Q?BYsJkP3M2bawyzAgiYpIMaRzew3EkySB1wE3CwVfH6bGffjJt14WWwXGwSNp?=
 =?us-ascii?Q?eQb6P/mK+xaN6MMmW5vuV6Jxp351oyheaMyaYfcFa8aQ8Nyq9H5SbTS4uxza?=
 =?us-ascii?Q?+dl/tvmbBWQTdi8Vp/WMfHYAGioT1Jl0MOFKkwyMAHF7ILxk4/S8dTwkYtsC?=
 =?us-ascii?Q?z8apowC9mbOFvJlY6JMPMhMHmVVGNmKhtT8F++CuB4PcdBBfPrDetc/Z0F7p?=
 =?us-ascii?Q?P6IC+Tjub4+9BKZ6OT6KjedQtjki0c8Jksir+ouR2WIhUc5RejK2QN0PQY2A?=
 =?us-ascii?Q?YgIEi0wxsP8Zi+ypVBsIGmLcX/NfkgwPDt7Ms3zGpRczZgABuL9qjAzG+sEE?=
 =?us-ascii?Q?zze4vhMMUDZRrJfvQGlm7Hw+0/o4YDjiM4GwNQdHjDOaOk2GgMmNi9exKJvF?=
 =?us-ascii?Q?A60rKm9OOXQypOHENnwP+sggbt73/mxQWwbJhXwl7aNdePvWKR2av+yjYBzd?=
 =?us-ascii?Q?4Dj85HO0Y4he7RnMfxhJIaXD0ks5IgiebqTJxi3Gc+ywS2LLdGeRxpmEsNvH?=
 =?us-ascii?Q?1+H1rO27NjltsndB0fbmxoKQ3VkOS5KYQNpl66y4Ur06/H7gwN50beKTSpJz?=
 =?us-ascii?Q?7WnuW4BpgeDdq5zOsZdtkX0HNWUiYgPLeHe8c9Sv+JKHM5dQEoRMUU+qffwj?=
 =?us-ascii?Q?9l1kKkT1/u5lj+0J8ao0Oe9fkns/GaXJNwNsR3c7pSLEH5DawSZbmcZLfJyb?=
 =?us-ascii?Q?Q25jIqZ7toV8xg2AJQ7mCCZBGY+rCltRhK5RWYQUxFjCVYuZMEFnOTkvJwof?=
 =?us-ascii?Q?o66q1zY9GEE89cFsx4/ptUoaoaocXDQid9OJDXKmUHh9pRx6F59j4GYlxuS/?=
 =?us-ascii?Q?dEJrXW7aDupMpqd9UQsDN1Rkty5WNf98wtTBHl8hS8ak9S/xX/ZgvbiHxQvQ?=
 =?us-ascii?Q?blOFl8lmJLI9vbHEQvrUpTL3EYkr6jU/gb4Sp7Ldt2IQKrvMk+JsJ8LwxWYN?=
 =?us-ascii?Q?haJ3qgX46y3TgAOlBwek29KwgIiXqh0pAVXzhmsZABwH2dfLsWIOf86uhV5N?=
 =?us-ascii?Q?Nw0lLaqvsv8ghiOaDQFiwjfGoDFWrExHWHxkwnYlhezon03dVpW6siG74o1/?=
 =?us-ascii?Q?fgAYjLiWcExihk53pCg0R8x8V80A9MJ7/K97Q4UA979eiAlJe69BBPcF9lcz?=
 =?us-ascii?Q?CPq5PsbFAXsK+IY6WurmDIAKigDYDWhwz4h+0nCw/Fb9Twar4YjbOes323mO?=
 =?us-ascii?Q?nOfGvrw+6TGSVIMLjIVg1nbz7mX8CGKj0Qr48Js1jcaHF05RrmAL1W7VAOid?=
 =?us-ascii?Q?wKKW7tdX/7aneoCzm4AdrmuMdf6aQ/0b87yeeygQ4KHjs0f3P8Tdj4EvTkJn?=
 =?us-ascii?Q?X9iFQ5s9m3DmBWN8IENFgI9fsZn4WAH6szuVB6Td56Bxzx3noeS3PSAqww9y?=
 =?us-ascii?Q?g3P8h3h/WkbbktJLGEZbNqXpJ1X/S3cvlWcSbceyZCHQL/QVdJaGrb/c67NJ?=
 =?us-ascii?Q?B3Dfc14oUxKPG7PHZ08=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:43.8637
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47ff9fb9-93cd-4493-e4e1-08de2c5e4b96
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6445

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


