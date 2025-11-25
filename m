Return-Path: <linux-rdma+bounces-14768-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D05BC86F12
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F0FC44EAD54
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A8633EB19;
	Tue, 25 Nov 2025 20:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iyzmvm0p"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012026.outbound.protection.outlook.com [52.101.53.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC3E33BBAB;
	Tue, 25 Nov 2025 20:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101276; cv=fail; b=bl8TtGucH6BctTvGxySKNCSrJR5z+5Di7TPrWbnNaahWPHs8BiR4UIwNB9T85WT2LCnWA5kB8A0EPSrHbzH6fC0HbN9Pp3xnyShlh6h9eg9CHr6PZE69qClxGXUv6tVluTQyB7AdBB1/L3BAeQaBt+rFA9Rup7CjkKQ5+Ogc1Vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101276; c=relaxed/simple;
	bh=H6KAI3Olm7BD8Q+V8uGc/XoHS9h5SDKyKzKXzLM9g+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcRhAy8adw8Bv44w7cWaBRudbTVSRwKqVUSD9O7SrANV6sTqKGtVRCHICM6EQ0aQuE0e4R3eYL2woAxX07CsaoZqOIqZSNuMUgrNhhykicGWJNLg0qDwOcj1XISmvMF3HJIlp+4bciNVr/yBBFFOuxbmmmsBXvFT2cqBcNr9s8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iyzmvm0p; arc=fail smtp.client-ip=52.101.53.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lbbam8EduTQsjjfMvb9IeazpH2b/KMCoIQ/ugBZEqpIKGfH5J/XE/jgWkzqPvDpxOD+l8Ax5HFVbMD0RVquk9hckCuiQbRRIW27hTnTm8bCaCGr5Yo3g7s5GeAE7R9Qwv+t6hF8pNumERQ1ZjmLCXWHh0SixEqIaj2gef/DJzE40JUsYkqVfVHyCgcI8iIX984Yh11mFtHe89jo+7EB/LVEZYbw2So4LMa61+dy90Cczd6y81eYFhEy1oPnCFNernwYqPo4UZ8QKueqFZvBhFjMCibwvQQPf0CsWp3UcsC3xXWL4FVdviifdXLbFCiEz7SjcWdyFeOHdVGRRfNGCkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5DniNffgu6Qz2rhmTFtzXOMPEVkhKMk0T2S6iDPd6o=;
 b=HUT0WDxp0oPNaG65fjQ9BPzS2J+P8So5kO1hvmqU/0jMw7oVAbze9klT0WZsr8138ccdHlQ6cOIsUD6+Rxvx4mYMVzc1iUsAUUj4Sztvq5XEm7q4U92JzX6HfFRctOYMgHlm9S2ny9FkwJUrKNV87VCEtSPP0CYdpJtfgTT0236/AHn/vAXze4FTXgIBW6ouHmAJmx4ZkuB8aGRHgs4ALxMo67P/p8OXMaeVi+ZxbySFADaenTWJdv75tfFLYuevhjLMSCryy44Du6zQeO1E/azbUO6VszS0TsdZSdM5KVvEwdPGPwofUd1B43Jb5u9kIoDuQ8Wn0ltHraOVaWUksQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5DniNffgu6Qz2rhmTFtzXOMPEVkhKMk0T2S6iDPd6o=;
 b=iyzmvm0paahuYNaw7wn3aPaySb7dluIsGz5F0J1Ix9iHG2CvvEbWUlyZLS6jCcP/vv0BF4LrY2ZrepJ4VF8LdgX/v64+HZ2QD4uEBl4lrR57vh84Y0cEUhlvMn9Uj85/1Istrw7c1NjmZIqe2vHC5dFm4Z+8S+gA5qzqVXxOvwyEDm2VIjT94FLP/HZUYurPxpNIL8qN18gBr52s2C511HeFhDUJ/5JlJbnpIthPU8hdcMBOWqQPkwTH72HLoe4S/5AVv4LgpNYMwyr+jASyeRI6sKczAN6tZQ7UU4adO9B54Nus4qSqY4M0AH3g/OUpiTqwUTSvrzkqRhOat6Q/Bg==
Received: from SA1PR03CA0004.namprd03.prod.outlook.com (2603:10b6:806:2d3::8)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 20:07:35 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:806:2d3:cafe::81) by SA1PR03CA0004.outlook.office365.com
 (2603:10b6:806:2d3::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Tue,
 25 Nov 2025 20:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:35 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:11 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:10 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:05 -0800
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
Subject: [PATCH net-next V4 06/14] devlink: Add parent dev to devlink API
Date: Tue, 25 Nov 2025 22:06:05 +0200
Message-ID: <1764101173-1312171-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 85de78e2-42e2-4f68-df82-08de2c5e4688
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7ahej4raffGh/kC7Vqg763zwUbuviwvMzavSEhfpvE5hkdmt5jMMwwNY6mDM?=
 =?us-ascii?Q?YeQFjpudYJ4LEv1LhoFFenxH1bdCcO2Yf1sMhpsBD04GCeiImew1vV9OJ38v?=
 =?us-ascii?Q?fU4dtiE9xklPto/b3KTsYe0ZKTlxEt3wrcCHC2Ut3t6yz/guLxcY5MJcsZae?=
 =?us-ascii?Q?I+p6i489JB7984O5gO2d2IJFShQbzbzie24yOr0Y/BZk+dLbcbf8XQVq/Ivj?=
 =?us-ascii?Q?4qmpYSx8H5LdutvDcJL6OAmBC4Xw7636CijmXjS5srEB8rmJD+LRfKP9YvP1?=
 =?us-ascii?Q?zqXMCLyB9C2AcmGdBWVqpK6AJJnrqRioljDYBHVI5GTiIRhQGvQ5+9Oairlb?=
 =?us-ascii?Q?BqBn8dbYt3gUCZ8YzH090+v3krOQezkZfjUERH9MKrGn2E4LwS1MF5/XIQz1?=
 =?us-ascii?Q?NpxHmZ2TKgmDJb3AISmVSK8unacaSvFhzQdRmYh6v1sD4j9g93PJSkb71jR6?=
 =?us-ascii?Q?feieXXUJvYT/kkDbxSB/Udj/fkRLdKrwDx2A7UjAMxtI3xCxhGVbPWSKQUH3?=
 =?us-ascii?Q?G0qI7XJxkdO9GEw1Zk2xPP7X2BrCNbmmOrqWnX0dvCc0cZGSdVFG9Uf2zGPo?=
 =?us-ascii?Q?yILC/Y1Ujgh93M2DitaJpCUPurS1lF7lGLkw9vJIcCHIPnbP108veX7yAo7X?=
 =?us-ascii?Q?Wj2ZoEKpvSZi3FdhF5mdxV+pIre84g+6bjQr6MRIPVEegSNyMsRTwgHOExp5?=
 =?us-ascii?Q?Y57mEo74PTQX2iE4NQUpbgtb6tvf/+aHut7h5XKVCG/2DUfC4AvNEfQuykqb?=
 =?us-ascii?Q?KyrL0vIMZ82b/Ej07V1uDd7BORl1amEAm9edB9AxChiGdkT4d4haWlmbyNDw?=
 =?us-ascii?Q?nCRhrjsKWbF0awdQRByJzi0A0HdczPd3YOpk9pdzyWQB80TEG/sqpTiDMrNz?=
 =?us-ascii?Q?vL+R5PK7n3X6yBK9gpNnv4IMyBqjmr368mNbDYk9iia62WEvP+S5YgHjh4xp?=
 =?us-ascii?Q?d9GxSI2c6SVi6/9VAGRy54a4zhrTZfm3G9piV/G092mUp+Cs38tuRjIwjpo2?=
 =?us-ascii?Q?cPU9zeCXEJ59yEHYVhqqHHDr9tpQd6VBcEIWU27EPAj+gtfdR7MwI+W9Lzcu?=
 =?us-ascii?Q?Vqcc/D0ZD32UxXdtiVOViBcewpBadJGWDj41bZPijDg5QPgmKUHkCpvZz4s4?=
 =?us-ascii?Q?5rOcK28lekipE1ezdHyNnuyyiedQ5npje44JG3RxTGe1FIlT7e58uGfL8eCE?=
 =?us-ascii?Q?qAnIB0YdOuypY60+yiIfLSy2DvSkj5JxCLwxkGDjzkNvvI0E2fzbW4JY2ogj?=
 =?us-ascii?Q?33j1J7gt4vW0BG57rMj/XYyeC6kPSMFifhiKMp+ozjoYLtGGtNv/UyjkeFYo?=
 =?us-ascii?Q?CjIDNRat+vhIc0SXSo9XepbPlNuMUjSD0hw+VI+nfgXaTYRPVZMSD1idjRRj?=
 =?us-ascii?Q?1lo1PdFYHdu5HWXCnPl437qgn4NGKxXLWuTZ7Q/qxPajNJNKZBnM18tl58Bx?=
 =?us-ascii?Q?nRENPRjk+Bee5+Qk5bizrSP35TeFwwZUvDqKrMWxZrOOv9koQz0w2JjlaEp4?=
 =?us-ascii?Q?tqAWnMZCPWClge+UR4e3A9+pnTaBUPGpP6iHVI76HQMRwbaUNUKFhUmEmdeQ?=
 =?us-ascii?Q?rUMOMSUIpmlxyH75MJ8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:35.3616
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85de78e2-42e2-4f68-df82-08de2c5e4688
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9

From: Cosmin Ratiu <cratiu@nvidia.com>

Upcoming changes to the rate commands need the parent devlink specified.
This change adds a nested 'parent-dev' attribute to the API and helpers
to obtain and put a reference to the parent devlink instance in
info->user_ptr[1].

To avoid deadlocks, the parent devlink is unlocked before obtaining the
main devlink instance that is the target of the request.
A reference to the parent is kept until the end of the request to avoid
it suddenly disappearing.

This means that this reference is of limited use without additional
protection.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 11 ++++
 include/uapi/linux/devlink.h             |  2 +
 net/devlink/devl_internal.h              |  2 +
 net/devlink/netlink.c                    | 67 ++++++++++++++++++++++--
 net/devlink/netlink_gen.c                |  5 ++
 net/devlink/netlink_gen.h                |  8 +++
 6 files changed, 90 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 837112da6738..1f41d934dc5b 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,9 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+      - name: parent-dev
+        type: nest
+        nested-attributes: dl-parent-dev
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1289,6 +1292,14 @@ attribute-sets:
              Specifies the bandwidth share assigned to the Traffic Class.
              The bandwidth for the traffic class is determined
              in proportion to the sum of the shares of all configured classes.
+  -
+    name: dl-parent-dev
+    subset-of: devlink
+    attributes:
+      -
+        name: bus-name
+      -
+        name: dev-name
 
 operations:
   enum-model: directional
diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index e7d6b6d13470..94b8a4437bac 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -642,6 +642,8 @@ enum devlink_attr {
 	DEVLINK_ATTR_PARAM_VALUE_DEFAULT,	/* dynamic */
 	DEVLINK_ATTR_PARAM_RESET_DEFAULT,	/* flag */
 
+	DEVLINK_ATTR_PARENT_DEV,		/* nested */
+
 	/* Add new attributes above here, update the spec in
 	 * Documentation/netlink/specs/devlink.yaml and re-generate
 	 * net/devlink/netlink_gen.c.
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index 8374c9cab6ce..3ca4cc8517cd 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -162,6 +162,8 @@ typedef int devlink_nl_dump_one_func_t(struct sk_buff *msg,
 struct devlink *
 devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 			    bool dev_lock);
+struct devlink *
+devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs);
 
 int devlink_nl_dumpit(struct sk_buff *msg, struct netlink_callback *cb,
 		      devlink_nl_dump_one_func_t *dump_one);
diff --git a/net/devlink/netlink.c b/net/devlink/netlink.c
index 593605c1b1ef..781758b8632c 100644
--- a/net/devlink/netlink.c
+++ b/net/devlink/netlink.c
@@ -12,6 +12,7 @@
 #define DEVLINK_NL_FLAG_NEED_PORT		BIT(0)
 #define DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT	BIT(1)
 #define DEVLINK_NL_FLAG_NEED_DEV_LOCK		BIT(2)
+#define DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV	BIT(3)
 
 static const struct genl_multicast_group devlink_nl_mcgrps[] = {
 	[DEVLINK_MCGRP_CONFIG] = { .name = DEVLINK_GENL_MCGRP_CONFIG_NAME },
@@ -206,19 +207,51 @@ devlink_get_from_attrs_lock(struct net *net, struct nlattr **attrs,
 	return ERR_PTR(-ENODEV);
 }
 
+struct devlink *
+devlink_get_parent_from_attrs_lock(struct net *net, struct nlattr **attrs)
+{
+	struct nlattr *tb[DEVLINK_ATTR_DEV_NAME + 1];
+	int err;
+
+	if (!attrs[DEVLINK_ATTR_PARENT_DEV])
+		return ERR_PTR(-EINVAL);
+
+	err = nla_parse_nested(tb, DEVLINK_ATTR_DEV_NAME,
+			       attrs[DEVLINK_ATTR_PARENT_DEV],
+			       devlink_dl_parent_dev_nl_policy, NULL);
+	if (err)
+		return ERR_PTR(err);
+
+	return devlink_get_from_attrs_lock(net, tb, false);
+}
+
 static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 				 u8 flags)
 {
+	bool parent_dev = flags & DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV;
 	bool dev_lock = flags & DEVLINK_NL_FLAG_NEED_DEV_LOCK;
+	struct devlink *devlink, *parent_devlink = NULL;
+	struct net *net = genl_info_net(info);
+	struct nlattr **attrs = info->attrs;
 	struct devlink_port *devlink_port;
-	struct devlink *devlink;
 	int err;
 
-	devlink = devlink_get_from_attrs_lock(genl_info_net(info), info->attrs,
-					      dev_lock);
-	if (IS_ERR(devlink))
-		return PTR_ERR(devlink);
+	if (parent_dev && attrs[DEVLINK_ATTR_PARENT_DEV]) {
+		parent_devlink = devlink_get_parent_from_attrs_lock(net, attrs);
+		if (IS_ERR(parent_devlink))
+			return PTR_ERR(parent_devlink);
+		info->user_ptr[1] = parent_devlink;
+		/* Drop the parent devlink lock but don't release the reference.
+		 * This will keep it alive until the end of the request.
+		 */
+		devl_unlock(parent_devlink);
+	}
 
+	devlink = devlink_get_from_attrs_lock(net, attrs, dev_lock);
+	if (IS_ERR(devlink)) {
+		err = PTR_ERR(devlink);
+		goto parent_put;
+	}
 	info->user_ptr[0] = devlink;
 	if (flags & DEVLINK_NL_FLAG_NEED_PORT) {
 		devlink_port = devlink_port_get_from_info(devlink, info);
@@ -237,6 +270,9 @@ static int __devlink_nl_pre_doit(struct sk_buff *skb, struct genl_info *info,
 unlock:
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+parent_put:
+	if (parent_dev && parent_devlink)
+		devlink_put(parent_devlink);
 	return err;
 }
 
@@ -265,6 +301,14 @@ int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 	return __devlink_nl_pre_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEVLINK_OR_PORT);
 }
 
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info)
+{
+	return __devlink_nl_pre_doit(skb, info,
+				     DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 				   u8 flags)
 {
@@ -274,6 +318,11 @@ static void __devlink_nl_post_doit(struct sk_buff *skb, struct genl_info *info,
 	devlink = info->user_ptr[0];
 	devl_dev_unlock(devlink, dev_lock);
 	devlink_put(devlink);
+	if ((flags & DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV) &&
+	    info->user_ptr[1]) {
+		devlink = info->user_ptr[1];
+		devlink_put(devlink);
+	}
 }
 
 void devlink_nl_post_doit(const struct genl_split_ops *ops,
@@ -289,6 +338,14 @@ devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_NEED_DEV_LOCK);
 }
 
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info)
+{
+	__devlink_nl_post_doit(skb, info, DEVLINK_NL_FLAG_OPTIONAL_PARENT_DEV);
+}
+
 static int devlink_nl_inst_single_dumpit(struct sk_buff *msg,
 					 struct netlink_callback *cb, int flags,
 					 devlink_nl_dump_one_func_t *dump_one,
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 580985025f49..8fbe0417ab55 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -38,6 +38,11 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
 }
 
 /* Common nested types */
+const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_DEV_NAME + 1] = {
+	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
+	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
+};
+
 const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1] = {
 	[DEVLINK_PORT_FUNCTION_ATTR_HW_ADDR] = { .type = NLA_BINARY, },
 	[DEVLINK_PORT_FN_ATTR_STATE] = NLA_POLICY_MAX(NLA_U8, 1),
diff --git a/net/devlink/netlink_gen.h b/net/devlink/netlink_gen.h
index 09cc6f264ccf..94566cab1734 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -12,6 +12,7 @@
 #include <uapi/linux/devlink.h>
 
 /* Common nested types */
+extern const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_DEV_NAME + 1];
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
 extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
@@ -28,12 +29,19 @@ int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
 int devlink_nl_pre_doit_port_optional(const struct genl_split_ops *ops,
 				      struct sk_buff *skb,
 				      struct genl_info *info);
+int devlink_nl_pre_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					    struct sk_buff *skb,
+					    struct genl_info *info);
 void
 devlink_nl_post_doit(const struct genl_split_ops *ops, struct sk_buff *skb,
 		     struct genl_info *info);
 void
 devlink_nl_post_doit_dev_lock(const struct genl_split_ops *ops,
 			      struct sk_buff *skb, struct genl_info *info);
+void
+devlink_nl_post_doit_parent_dev_optional(const struct genl_split_ops *ops,
+					 struct sk_buff *skb,
+					 struct genl_info *info);
 
 int devlink_nl_get_doit(struct sk_buff *skb, struct genl_info *info);
 int devlink_nl_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb);
-- 
2.31.1


