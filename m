Return-Path: <linux-rdma+bounces-15742-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0B3D3C167
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 09:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 66E7E448D29
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Jan 2026 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C33C009C;
	Tue, 20 Jan 2026 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="S0iVm4Li"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011023.outbound.protection.outlook.com [52.101.62.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692CE3C0090;
	Tue, 20 Jan 2026 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895961; cv=fail; b=Q3hJ9aD1caKLNUaYyADnEHIAm4ZSrl2WUFDP/01wtFbAG1epNa0GCOHNd8jH+6trYaXya5ZyI6OVqA0GVyQmPisnZ57EaxsGObmRkMJA0TmXiVe7MLz6Zn7ej7mSLtuzKkizTmVKeahEMbXzW6DLZuZIYtyZiXSzIzbPQTWV+VQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895961; c=relaxed/simple;
	bh=e3XJptELJEnmnr5z7cACroHkY6u9sbhoIMF8+phupMg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ibDLeJG0UgI1JpcuxIvcjgnVZEZHppETdfroZhJNFZuwTvbtEmFZFNj5JLdMgj08KJIwFn/k+4au/9fyhwQaxmBh3FKXt4ZHrZbVulA1OWu7FVX9okD+uzDenQW9KEaHAuPqqpQkJs/tM6cpnr8LTwIw8zgURiWkeRqANPoLTLg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=S0iVm4Li; arc=fail smtp.client-ip=52.101.62.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OMyX+gNBBCquqnbvUKCp75Gx1FQnOzTFwanBWu5GmJ7+GZcOta0zESA3YsNnI5IW90Cef1W7qUYgjkx7y2GaL5AuasCYLwDZSKaiBnl34rm7SwwhlIRRdK5prkjqj8VX7HELrmnDWlARkR67kLUYoyZ6I0yHvd0f3qPIGInFmgfXWhQ/DwEYZdUIUK+/YaH9lYQJy7VGgdHpU7VfOCmVN4uJa4ZP4e9a96rV0JagS4nuN2SYHxd7BUtRPi83O44QzH/2BwzHJ8pmDSiFpL+/A0GM816MhFBVj2L+aWURy8q7bFf+lgm/qH9178JG8MNj/TUUZh44R9PeiTm3GxbMBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FjvI+uEWYsA4geYb3SodbXXXDkMDfyXm2eY4HDr59+g=;
 b=XefH7ajxanb3M4pSAraOwTH+nZahRlu7Yh+5++Se4F7a6LgXQFM7Q/8677y3A5ceg7kC5bnsUJttMFkQoGSinSB4FDYwDM42vCfTLfZf1P5U5+lsFGM2RHtH8q3FxYfTYsgitXAfmxlPMx1uS/67V/YMSs7wvhLmvqlM4IT5kPo3YEKyj8UKBQyHStKfeZU5ua4K3zf68yGCbQnLhonAtQU4a7jSw/sNVwrTeEzX6SlPNk93ePRQ/kQdfoZJXpcA9imgNmSUM1/h3MVYGwN/R/frUPn2U8G52iUc8zSiW6Oq2vpnpVU/w8eSIRMZIK/IK0+3YigP/LUtpfL/YP1TGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FjvI+uEWYsA4geYb3SodbXXXDkMDfyXm2eY4HDr59+g=;
 b=S0iVm4Lizx1JMzKWcIqdJ5Kei7QInA70h2Op/QDyyeXCwBRIJo7bQlJbu75YJLRygdXO/YyASlPx7nFn52HgiyZFvQwhAi3pIYZEjvnI6euu7g9jjY+wi1QRfN8uZB55xG/oFM0nKFCFYRp1X0af8OcJ1vHPbfN/GnpJ8zft/tH0Xkml3bQZtu9E5waQhHmmV6YdKKZ/buAn0ysBtvKEXGVH2F54rl1crsCJUavGopNja7DZQlbl+UJe3p8+RI8pcF+JMtyhPtNYBw9pxULt7xGcODilxJoq1FNlzBxZOHpf4rF+IbDZstmVGYd3cZYDOV3sbd5WrOONRtNSJMO7Iw==
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 SA0PR12MB4431.namprd12.prod.outlook.com (2603:10b6:806:95::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.13; Tue, 20 Jan 2026 07:59:12 +0000
Received: from CH3PEPF00000012.namprd21.prod.outlook.com
 (2603:10b6:8:56:cafe::bc) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.9 via Frontend Transport; Tue,
 20 Jan 2026 07:59:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CH3PEPF00000012.mail.protection.outlook.com (10.167.244.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.0 via Frontend Transport; Tue, 20 Jan 2026 07:59:12 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 19 Jan
 2026 23:59:04 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 19 Jan 2026 23:59:04 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 19 Jan 2026 23:58:58 -0800
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
Subject: [PATCH net-next V5 07/15] devlink: Add parent dev to devlink API
Date: Tue, 20 Jan 2026 09:57:50 +0200
Message-ID: <1768895878-1637182-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000012:EE_|SA0PR12MB4431:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0be3a7-290d-4d0f-1a45-08de57f9ccb3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wBPi+TXun/CvU8LxYxuZTC7XUfLZDh1QBeYq+VCE8Lfr00EufFkVk6x5GR3x?=
 =?us-ascii?Q?XIqSXz2uY8wEfbs39LAFGO9q2R4Ks94q56M65u7lCZYVIZRsKeuC/lwhP6g1?=
 =?us-ascii?Q?vCxG9IbmiwesMsEljjXmJFs9oQe0uaM3NXe4buDcUP8+AUCnVeTrzVDwckK+?=
 =?us-ascii?Q?Gk9JUaUDRws6a6Az1HidpVQ6HsQuhewfu7Rd2YM8zPhMg2fPoIUcCNjky69E?=
 =?us-ascii?Q?K4m6G+jnIJNm2HTOj0iUL3E9N4u8y7lDJX5d4/IiFVQ5PVlv85DNmCCxgkir?=
 =?us-ascii?Q?MhXLftsFh8TZaVl8LMH2FityOE+L4qh/5oND+sXWdkzHAh4qqlbp/RuAkcc+?=
 =?us-ascii?Q?kzPrW4FRW9gnCFLQUKba9DxurmuPxGtC+irUbr4PKAhOdFT1j9cACt59tzZU?=
 =?us-ascii?Q?9a5L359Po+uA0ivXQJ1dKIQLOAZTTP5FXswmqTc8rs3L75nOmk+kONmIg4Ls?=
 =?us-ascii?Q?h09AixsM1D/jwJxIbg4hlTR8KGQrAdgu3Ewo7JuG58uNjdbDNUjtBjzug8WM?=
 =?us-ascii?Q?HdCOpZW9w4Er9VXPenRY2t956FlqVkaAezLDQ5vjHgkaaOKPRlet5gggpi6m?=
 =?us-ascii?Q?o+ZXberX3ca11k/I/1MwnrGK3E20VXeqRuZrKUMnwk5/7bgMUVtQp5hmA2MQ?=
 =?us-ascii?Q?1h4U5XOK2oo7bOFY3Brc2XaHSBlCdJdYj6BkVbov4MXFnxvwujTZNQVIAXAN?=
 =?us-ascii?Q?SwIfh1E8pAbEa3lDW0FKz9KooGP4h5a+Wi4jNpXn/a9BR/V7S6PB/6/t91wd?=
 =?us-ascii?Q?+AuX505nuubryHQUdeeqryLwr7HmpktH7tWzm7+QNpmR2Cy/R9PHY5J9D+Hw?=
 =?us-ascii?Q?0M+fKEhRwX4H3wRAxCvQeqVRSxEXy9c4POFp270/x8mmhTwB36ewvLkzyoiE?=
 =?us-ascii?Q?I/nIaqMqZ1fYOnut6Zff9ErmEl88dnzHycHqzHydOaZgn2lZaFxXUZx+YAP8?=
 =?us-ascii?Q?vi0pXWeZq8NP0QozyHNXGfIvq/t7OaOGcKKIn/4KeSnP65QsrToYRHRFxZsr?=
 =?us-ascii?Q?SxpP8pyNN0yAYItTMtBFBqXlNcEiaTYP5yqdui0yPbnBJt3iGz3AD8a0Xxel?=
 =?us-ascii?Q?U8y6jZJh1phap4ZztYEZwTv+oyXkL2SNCAFxwKFxgZVMmZLV1BP/0RkdMhDY?=
 =?us-ascii?Q?WX0CvBdcg9n7mBrEyxHifV6042v+cagbxP+7G6hh3jX+fTYhqhxe4yCWkzQE?=
 =?us-ascii?Q?hGBuuMSL+1QJz/5cCmmXpZHzL8hif6xfcvAsb6kt+TBAAT9ycglcshH1QzFh?=
 =?us-ascii?Q?CCa1nzZwrQYRtJuPcZEPzOY+ZiEYMvu4I6R61V+U+VDgoSD3eqiWYHd1jnoH?=
 =?us-ascii?Q?qkN20rtA0/FJiKH5ffDisolnQKFjWtdK4R8uu+Pye1435c3Gsi60jni0meWT?=
 =?us-ascii?Q?aEEbQXnQtuf7cmh6Db3JJNs94++ucA/+W4tCm57IZW+efwW2yG/v9Vv023bh?=
 =?us-ascii?Q?jrCemPhlRqyyYM7diILJyE/j+y126rQhzdTKZ/B+SbTUm022htRJS45TCc9J?=
 =?us-ascii?Q?J+aSxSYE1YcutiiSc0yRp6tBKwyn3JGUnhEQUgcUJ1gYf9217A087BlmhpzN?=
 =?us-ascii?Q?SP1vpWvTdubXCba+EwLimgs39NRG4Gn1gi/cCh0Rs50nrybqXiUuHMwYfP9e?=
 =?us-ascii?Q?IvGii7ghZaHDc3NJCg30NEO5tJYwY1swWo5p9NgiIbAUVumtxns4n2IFyjun?=
 =?us-ascii?Q?mBelCg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 07:59:12.4572
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0be3a7-290d-4d0f-1a45-08de57f9ccb3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000012.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4431

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
index 837112da6738..a8fd0a815c0d 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -867,6 +867,10 @@ attribute-sets:
         type: flag
         doc: Request restoring parameter to its default value.
         value: 183
+
+      - name: parent-dev
+        type: nest
+        nested-attributes: dl-parent-dev
   -
     name: dl-dev-stats
     subset-of: devlink
@@ -1289,6 +1293,14 @@ attribute-sets:
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
index f4c61c2b4f22..6b691bdbf037 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -39,6 +39,11 @@ devlink_attr_param_type_validate(const struct nlattr *attr,
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
index 2817d53a0eba..d4db82a00522 100644
--- a/net/devlink/netlink_gen.h
+++ b/net/devlink/netlink_gen.h
@@ -13,6 +13,7 @@
 #include <uapi/linux/devlink.h>
 
 /* Common nested types */
+extern const struct nla_policy devlink_dl_parent_dev_nl_policy[DEVLINK_ATTR_DEV_NAME + 1];
 extern const struct nla_policy devlink_dl_port_function_nl_policy[DEVLINK_PORT_FN_ATTR_CAPS + 1];
 extern const struct nla_policy devlink_dl_rate_tc_bws_nl_policy[DEVLINK_RATE_TC_ATTR_BW + 1];
 extern const struct nla_policy devlink_dl_selftest_id_nl_policy[DEVLINK_ATTR_SELFTEST_ID_FLASH + 1];
@@ -29,12 +30,19 @@ int devlink_nl_pre_doit_dev_lock(const struct genl_split_ops *ops,
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
2.44.0


