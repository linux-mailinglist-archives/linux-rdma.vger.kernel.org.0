Return-Path: <linux-rdma+bounces-14691-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 980E5C7DD20
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC89D4E5C50
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:24:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187DE2C376B;
	Sun, 23 Nov 2025 07:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pHZ2NR0O"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012026.outbound.protection.outlook.com [40.93.195.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1C929A33E;
	Sun, 23 Nov 2025 07:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882646; cv=fail; b=kyBruPV8ft2BQxUcxaf3AsZEhyDcKX+HHJziuwmC5Vf81A5IoUjDlsi8N24BzQWQ4F0Z47tx+d3t+PiLzF2Z9kvH+3/Pvw3XNsMQDvHv7MGA0vJphShy2xs/Dq5wMWOLwwLyKEo0vwGR67t0k4Uzju/jySbMVxpNEYLdtAJRQFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882646; c=relaxed/simple;
	bh=H6KAI3Olm7BD8Q+V8uGc/XoHS9h5SDKyKzKXzLM9g+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z8d584IAAFEoR3q66DfYwI2Ef7woxTLTS1RGKCrnyOkFIB5Ret0DREIA2Uuj9PF2nlIlwdYl8r0KuSu9kPE0zn4vFEPAXtBO71dZZo922v35EeAdp5srN08gOkxS+rcmiA+sB5GMQbU7uGgZOO2ovxvlkjnnDDLOxv3CYTCv6kA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pHZ2NR0O; arc=fail smtp.client-ip=40.93.195.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PyeBALAqX3CZye5MVO/3nm0Jx8pJCbTIoYI/t7fArwYJsCM1kLswZszYu70V+h4L9f8H9QlU7dMF+uLfiMlWJ57nSquFfzr9Mwq9XbYZb5l8x8+PdyJtD2lHEtfuHKySNqM62X7Mrh6uuCI3ItAYkD0RgHmEavsjarCV7UY1XSvG7YxEccyi65DxQfhACKbUX2rQKx638bO57hHv0JKHzv/Bz4FgqiAVxzYygYSYDDizBV3aJPyl6ObGJZ726QuUHLPGFfcMBKJ3WD7YYQZH5GdD6PUkahiZO1iQPtuSaqtQ/qU5/WTf4qui8egvJJB6kjCBccYsgoskPewckNxJOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5DniNffgu6Qz2rhmTFtzXOMPEVkhKMk0T2S6iDPd6o=;
 b=Tg53gE2VJuy2W4E9QA73ftrryvPESCSKl2N5C8RM3WLjY5MA/NRkrQghWb/Svaxqf+3Jcz0A2uqx4jZQufUH9lURbZR6EJVk166p+naOWrwbAmrKYxuaFl30tPyc1US3Hps+hvHTWZQhysUaxj3p9mJ+P73A4H0c+UocjLHgQU/zotWP9Fj1vBWJLed781IEG3ApNdNFoJ7s4k4JIz/XqleUzh7poOlH59q5A5y4PptefTo6Lr/ob5TFulM+k6npeVEO/kkfucKR9BXXX4G0snJgTG+0GB4E9FFyvdP6Tr4ITuUyvQCZLJ0ldIORB2sV5ctoHVum8I/ofxWellxcpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5DniNffgu6Qz2rhmTFtzXOMPEVkhKMk0T2S6iDPd6o=;
 b=pHZ2NR0OSzXs9Bhx89gQE9nDhVYKlR6KpbsE1TadUeW1o/pO8lY7oHDhW0h38m50jOQHM+TV5vt3qcBVmVF00Ujoe5vsOoaPVVjL/5+eoICZQs4KK9IeJXV9QAqwCOxsHuNuPY0lkswctisQGL39IKvnr+ThHNiYxjF+ciSz6S8oUDb2LRDZCXst36n5/CFKdUdRdf5nkPTLITSA2Anp6HjNMBTeD38OlajOt8lSQpVwxmAR9GZU4AN0w0Ng13ABrLIjZBfXKjDE3LVWaGVP5xDYgJ99+T4kdztNnhgT6fJRyM5tBKEqaDevcZ8NsQOt47XGlGa4K+o3D8uWzWcKcQ==
Received: from CH0P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::30)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:23:59 +0000
Received: from DS2PEPF00003441.namprd04.prod.outlook.com
 (2603:10b6:610:ef:cafe::69) by CH0P220CA0018.outlook.office365.com
 (2603:10b6:610:ef::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 07:23:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF00003441.mail.protection.outlook.com (10.167.17.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:23:58 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:49 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:23:48 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:23:43 -0800
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
Subject: [PATCH net-next V2 06/14] devlink: Add parent dev to devlink API
Date: Sun, 23 Nov 2025 09:22:52 +0200
Message-ID: <1763882580-1295213-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003441:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d4a358f-dbc4-4f50-44fb-08de2a6144a9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EytidXjNv1WFN1BDO0kTQKA/LHoGTBEyYLXGqQHR1e7juxVRUaBQOvTNL0jJ?=
 =?us-ascii?Q?Edi2SHCiVpSz+Yd8G0jzCXaPaRCvi5klfA/4eX3fpfGOc7SmBVbP3zwMZxiW?=
 =?us-ascii?Q?ukyu/yi9Kez739uPZI9TCGdhVE4ANcfzW6vKqeGkYlnu/ViGIhN/GkhCaHLX?=
 =?us-ascii?Q?Orn9maGIxwXY9tuVpc5ImFA42hgcAEaMewvwkRD0+1t26wCZNswJUHWAX4tt?=
 =?us-ascii?Q?FnsN9rtjPeyKYTjqcDcCBi7ZSCtPunk+3utvE3irvDpk29F9Bvld8KaX6jRM?=
 =?us-ascii?Q?RaEeCs/wZBOSw2ydcykz1az7L0YCr6cdI3XCalVfiVey8RWkonZkjUQtJmDq?=
 =?us-ascii?Q?oio3F7w3nfqlMoDx9Ng5vLtCzB4GW4fyaWkraCJY95J4VG+4x6gE9kohALFK?=
 =?us-ascii?Q?HwfdzEkPUBO1k+l0oOE2C5y5bTP2w72fVcIdQueDn1PeNn5VKRGZczpL0ECI?=
 =?us-ascii?Q?qqy5JalBftWKond+PRKtjHHEvdDYXS/awnXl4nYj9+CN4NE+1qP0eu5cO7Lo?=
 =?us-ascii?Q?LYk8NfXk8JmGzb7dWcACzZW/D5Ytp+/4WRbzNQ+Nh1ijqfWJwa/j9UAKSyu5?=
 =?us-ascii?Q?ZwMOi2ntAFNtOALJodsPAib9H6O8uiFShxXcn+M41MX0t4KMGGfXMZbbEyP8?=
 =?us-ascii?Q?xlBW2rvLRW9pzBPzNTTxpl/AUIhe9a3+PeUMBijBgexsDnBQy+VS6JEf4yMW?=
 =?us-ascii?Q?VG+/P7p8PQtLuWTjwAXPKUBiR1/cZm6Q/Zd7oV3FybUMD+ZoOqiM44qkKlLZ?=
 =?us-ascii?Q?PJxpxR//ooDNKKH2qh4Bbn4ha890da92mTZ/hv11eXc3y0lmGpkLorymoob5?=
 =?us-ascii?Q?uJUoYxYHMC7PVTjPL3uBPdkJCAa9LOb9usBpzi77kIs8z1btccsnBzC8iT9C?=
 =?us-ascii?Q?tRIu54mGVptBLEBBL0eHeUmuW6mcDyL93G9OUbSIbX0HqLaFYjGHPk7Khgxq?=
 =?us-ascii?Q?K3TXpoy4kF6MybpIH8Eg46LDlHoNqe+r5zrgvLkD4Nblterz8ftKYoo8Tos5?=
 =?us-ascii?Q?70xou3zJKwkQxdeWquGW5uYC5aVYfDbmggluuRgjsMbRp11p3m21s6E5vN2z?=
 =?us-ascii?Q?sM+IoxFEyR/P1NgqCribaymm9MMyDFc9S/Y41PwC3qI8BozTEnU5SceGjukM?=
 =?us-ascii?Q?+P2onI+OzSPRTRCsW4nhQVdq6AyEUrEHP4BhDhdM/Ivz44GU1wyyy3DaTQNl?=
 =?us-ascii?Q?WQO/Mgi4XLzusxHKAbHlssB2uN+qwrF5QgoiokxXUYrfUxf8Ig91cQ8RT5V/?=
 =?us-ascii?Q?SKs9et9pgJYKJfGRVI2mxPagI1A/+khXE/eoN4WYmZxXa7uPSP0bQTu5NNPc?=
 =?us-ascii?Q?JHa4ZhHcr2aXpSkLUd/Igjn3EzbFijVghdwpk5OhyCajV41laH6/gbCdXozM?=
 =?us-ascii?Q?IA3VwL1X3mAtrt5/DwFhKbq7AFxaKZ3wKtYPfcSGX8kmeMDccaQmQwxKIcJw?=
 =?us-ascii?Q?8uNSxLDnoI1v45juwqng7OZZxLdSf29SuOiq6YKxv2sapoNQH3dJ0Qor8C1o?=
 =?us-ascii?Q?cbpJW2Z1rzhUGrDYA54rx+KX8j90dcWQynitMVWuc2b8JCpuaxkiySEKYBYO?=
 =?us-ascii?Q?Xbl5JSNaSGSFu9dCAY8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:23:58.3850
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d4a358f-dbc4-4f50-44fb-08de2a6144a9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003441.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774

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


