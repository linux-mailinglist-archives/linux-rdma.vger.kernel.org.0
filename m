Return-Path: <linux-rdma+bounces-14643-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A3743C741E1
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:15:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 599422A9F2
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330C533A6ED;
	Thu, 20 Nov 2025 13:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pE7nNEMd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AB2433C1AF;
	Thu, 20 Nov 2025 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644451; cv=fail; b=fiUL3qdftsApBtP3KMLeCK/zLuR6G9X69ObxRd2iXyLQeziuz4qIzh4CCij3A6PHQ0rwRRoiAj0qY3EmWgntAlsOmpVWGG2d9U/fOquAfz35X/qQUiAQNgzWrify8kjfjsU7nswU3GENdUNZjMz8vPSJQ5caM5DW4uTwNyVWj00=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644451; c=relaxed/simple;
	bh=RLAyxL1Ohnkhh2OFufhxRIVsWQCxYOar20ZXjiTq85g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fMK4KhNiLQ28nDWlADp9HKDdwDXzYqjQkP4K96d9fbg8MQaDt0p6DoPsTsXdxO8d27gW208cRcfibqhpjf5fjddkdWNOA13iGS/mU+X23l3XJ2t4VKM1PnS2pUXTkVLMR/C1JRkgZXWraKa6jTFvcf3d7G9a7S9ZlBhvZlIzdro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pE7nNEMd; arc=fail smtp.client-ip=52.101.85.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rmsl2gtuyRt03TbTaiKIovBcGOMScUScvCJQvV4fi/aK7DLXHJQOo143nCxuEIIWvkKS1l2dOqXGnjgsn6QrrYUtxmfzMampQlOaYEjRxfEUAseQU6lu4KdSoBojXVJvuhZBdPdK+nnHLRgN0e/eHqN5sZO5/4XfMMZvGOgX0ASJMK7H1xDZSkdxGeMEoY4lPQ/CaCQmIl35qoK/2FG7CUZKphld5Iacs/bQ1gYyQVKNpRY6IifnzdG6k2yd/CafCdO9hdOTEMDwFqVEf4Sapoh8DAX9WuHiKiUVf9+9gs88Vp4fc1RKRmBUDH78rEj/ih9ffjxq+23LhL0mvNTgZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q62DGjOSsFHjCgJv9tnNtcna02pxpMm1nJISU09W5Y=;
 b=FoWYUpUcT9hQz6mde5l3Gs7go+C26BprTlHEO+EcUtdbSNUkF83dP/A/61pSKtBwG4a/E0xZ3ZOJc7LnJdUNPu3DlawG0oaB6oHmUYWTvmnnEKhCn3Qu+/XsmOaGKQ+72O72yHve1q7vv4CnUhsNetJnfCg0LY+Mx7oBAxfx7qDFrx9IRMyjIug21O1mxj/zIjoIStNIBbcXJqv5rTO8wmnExLgymahsNJ3uT07dpOD/xzioAKOQQszIorNbGkPFhXFD2kahj34lijsmRMQJuj/D/So6GYJ7L5a8ZA7z589xM4ibizo0MgtGiu85F4nvCT8DYRU6c+3DKeYabe6jkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1q62DGjOSsFHjCgJv9tnNtcna02pxpMm1nJISU09W5Y=;
 b=pE7nNEMdykxvDUzxG/3ftINVoO7pI57zKCytMTygbw4pKmHKi0NfiWcjsWsIIyiLH1Kifso2Gl8+QCBQxlw+taid39DCSSMwV8bjH2x7v1t7urL0Wob8M/5JnGKQjFi2xiwf0vLuJ6PtJoK/ug4a1QRqL1YI++mD5hS52aknYTSNhNsUalAwMOt4JUYXmu6G56qo8vrxHBV83ixWSU1cGAnBRXN9fkM2o1waRhh5OCZPAHYdhzRvKBEEjWgxxqkBwxdpIYrC3S9CTYcS/EdlNFSxIKg/Q80djmLknn39EpiwJZCLowsWor8mLBrcnzSBAqUSuJz/MNzdk/Iu+986Hw==
Received: from SA1P222CA0146.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c2::28)
 by DM4PR12MB6303.namprd12.prod.outlook.com (2603:10b6:8:a3::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Thu, 20 Nov 2025 13:14:04 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:3c2:cafe::a) by SA1P222CA0146.outlook.office365.com
 (2603:10b6:806:3c2::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:14:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:03 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:47 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:46 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:40 -0800
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
Subject: [PATCH net-next 06/14] devlink: Add parent dev to devlink API
Date: Thu, 20 Nov 2025 15:09:18 +0200
Message-ID: <1763644166-1250608-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|DM4PR12MB6303:EE_
X-MS-Office365-Filtering-Correlation-Id: a5964d80-5d34-4845-13d0-08de2836ada9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1yNd6SLpkVoVvWC/8jta1uMvNX2DaTIkBb0nxLVAInFJARXK89Z+E4OzrqDJ?=
 =?us-ascii?Q?zBqSBofoNIRtbbtUsmeP3eg6phfa0xj73DpwWBvTA5cfG1tNO5C6Kk+DTYYb?=
 =?us-ascii?Q?Me815rkhtEWAvHbI2KmmasLrCgSvePq2YHQcBhnxi1wx7kErCIGb6mGKwIlQ?=
 =?us-ascii?Q?A5dhEEuzE0xOy18oLgfWu3fu8Eqm4m44/Ac41frhJc6U1XfymFurzAP9rhke?=
 =?us-ascii?Q?R2zabdOUSsOfGapY2UHvk/94cmbLlspgvHajI9AfGZzfNLBbSCnrlVttpXWL?=
 =?us-ascii?Q?n9ahqljagCsvUrhssiO2VamPOHyfAqx/u/o0fzCzEqngzCfmIFbZ5/xBFiK5?=
 =?us-ascii?Q?iCK0INaUSED8W6MxS+i6wvQXJJWuIgfwdETH1sPw6AFNpE6JnmIp0k06y0hE?=
 =?us-ascii?Q?rtDx9b+fO+88Z4X/8Uz4EIMClFl0dSaADMkHVEcFTq4athjCWjp8f5cnv/ZI?=
 =?us-ascii?Q?RpKi6P3GuitbGQRE/vHrCNtPQke4ssT6DQgVPpyd8JHSM4ynYuvsuNlBzVv0?=
 =?us-ascii?Q?B7FFtIuWWjPPfemdQty1QhVfvNfEVf9HwVRfFScoTlqKFDuNaAQwi3btM/9/?=
 =?us-ascii?Q?1LpCLX1w2nH3P0y/ccX02vvHyV8p4/BCA0uQinIKawQE7XHzBIgEYIXYy80v?=
 =?us-ascii?Q?43qWCtulMBfSWa2HfgmRnJD9kUXN/V2LAyio3aRXwuwySt9A/zjvPv3TD83C?=
 =?us-ascii?Q?mNPmLLpI10XyqWtpkhp44XUHpWtkntKtPZZNMVgCFNj3P2UzzzeYOL/M6KLc?=
 =?us-ascii?Q?Ouq3m9Dt9ZafADFGXvnj14hYlLFZ2zY3ensAIBrVW2cbkvO3EHhzkkvqukHG?=
 =?us-ascii?Q?o2zMl55rSsJKFbl3/heYmNMzmyPcNDIKxhCFqI/bjkY3LvDdbhT7quqR6V9L?=
 =?us-ascii?Q?ZM08osWa9Q2Poi30VVKTKbXhJND/JoR5JQswBnZ1p4VY+NrazXAiqmqTMjJs?=
 =?us-ascii?Q?YjL3htmT8SdcL5luTEDv+6C6Qy83IUeKjjC5xdXEaKGaLb1MzjLvbyy+xGdk?=
 =?us-ascii?Q?B5qS4HCDiypT1D0g5qiqlw/PsYFjGcycSdDtymO1MEGijun5vXskL6K8DLiG?=
 =?us-ascii?Q?Z+2VZzYFboXISbYPOyY6H8W4c21oZYzsgFFvSvOxMoHDopSmTHVokZwJRTGV?=
 =?us-ascii?Q?zVUwGR2WqTxHnnQvfgxGviLqMj4zwxcor1DVn2oRqvlmLkMM6ccrmdztzrGN?=
 =?us-ascii?Q?n6GrzQacLkh/9Rzay5YZRAXfRHB9eecduN0sTThsVulqCAo1HeuJMg0X3DY8?=
 =?us-ascii?Q?ahtE2A1uUDFqptorbVVMyNuWYUJXIcKYAGiiaG1VCjHWaIPGNLBDpMh6g/U0?=
 =?us-ascii?Q?bLj1vjwhdDDd58aRrEBLU9KgAKFdxry/eem4WSs1/2r7K//O44R7SH3fyvnd?=
 =?us-ascii?Q?3P6k2A9iaA1LqCHqquNQ3JziBuxOfP4eKmelEl5AfF19KHXzetFMUSK0ygpi?=
 =?us-ascii?Q?vMCrOKmI78qX7kqHxJEaX1WD8lw5uUjBgMKOyUwQasfOuTn6EJvnhGT4M0mo?=
 =?us-ascii?Q?GuTv00A5tO24YMPdf493UEdNal59dFSLsmPWKViCSG0mTFru74Ua1RQCN1NM?=
 =?us-ascii?Q?oC/Bw0sX7h6kfZXczt8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:03.8690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5964d80-5d34-4845-13d0-08de2836ada9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6303

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
 Documentation/netlink/specs/devlink.yaml | 12 +++++
 include/uapi/linux/devlink.h             |  2 +
 net/devlink/devl_internal.h              |  2 +
 net/devlink/netlink.c                    | 67 ++++++++++++++++++++++--
 net/devlink/netlink_gen.c                |  5 ++
 net/devlink/netlink_gen.h                |  8 +++
 6 files changed, 91 insertions(+), 5 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 426d5aa7d955..fe49acd2b271 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -859,6 +859,10 @@ attribute-sets:
         name: health-reporter-burst-period
         type: u64
         doc: Time (in msec) for recoveries before starting the grace period.
+
+      - name: parent-dev
+        type: nest
+        nested-attributes: dl-parent-dev
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1281,6 +1285,14 @@ attribute-sets:
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
index 157f11d3fb72..1744235c3d15 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -639,6 +639,8 @@ enum devlink_attr {
 
 	DEVLINK_ATTR_HEALTH_REPORTER_BURST_PERIOD,	/* u64 */
 
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
index 5ad435aee29d..3cabbc1207f2 100644
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


