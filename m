Return-Path: <linux-rdma+bounces-14728-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF9C82AAE
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 23:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E3B24E6925
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Nov 2025 22:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9D4336EC0;
	Mon, 24 Nov 2025 22:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q0pZuVCN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013008.outbound.protection.outlook.com [40.107.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999D2F744C;
	Mon, 24 Nov 2025 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764023373; cv=fail; b=ZKoLwQBm0Q5RURXhj8+6wvj4OqeyCmoZHNJOmq7NtqUNbJVVRjDZQQiud7jPLHpZELnV1NSh27Nq0UA06kEenIstSmmWvA4FNu8gzz0cmcqTeAw5pVPt4bBv8f5bnpNH/W9hW+A1AmIHZ1fUFFDs2wxwXJfL+s0lR1cPDTGLme4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764023373; c=relaxed/simple;
	bh=H6KAI3Olm7BD8Q+V8uGc/XoHS9h5SDKyKzKXzLM9g+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TFN/fOj+jcIMmIcdTAjdH8axigpGB1iBAnlzwtkPwh0uGdiy6jiBX/OMgtTMgMYnpTKsGo2DuNOXYxb9pDcQg6i8xudHYLBlrQG06FA4eEogSd8CmxzNEdL2H3z1uEjm1GOZZMJw0LqFLX7HGkB4gAYkjqb0c+JFdHDvCa5aqhA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q0pZuVCN; arc=fail smtp.client-ip=40.107.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MhRDvonftUCoSFh3O4AISutTIDjAGFvaAJOKfEGNuhMKgS8KmQ/BasEfR2JsIJHLo386eMrba8FGbvas3TWWvubz+VX0V1X8cRqddMPHF9OAzuPgOejIcvSjBxUI8IoETJIfZ4ajSVBj77LX44lv5qM7sS8O2i7Tp3PnuTxAff84yGg2zpr21i2ASS72ldHkFWmq0SUaybFmUyoKnC9tZR2dUvm8J1wnj/+n73BkG329HtI3jDWzo5UiaxjCaRAKg6ycwaVQI08s+wktg/zHrC7B8b9jgyJPY6sj2IEZm++LO8RsM5CvOytCDhMlGVdRGoXXFWSGfSvWQWOF4PEq4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B5DniNffgu6Qz2rhmTFtzXOMPEVkhKMk0T2S6iDPd6o=;
 b=mgCZVPN4N50MPIqaCkwXWKpR0KppQ6qJ+lcoyaBdZUXoQdeEqq2Gn7dscK/fUrcrmVMFDpMjgeljyfPFshCR7SIR4MTkriRGOjz9ULE+k1h2k4FovGW8cRf8CG8xdne+Jb2b2m+X6vBuuVoQAx62i2GfTQ/mibMLLiMf71E2fa/6gA86Szbng2GUNnqi90GFL1bUOxpeJ9llLDGGTYfqJajAPNjmLqvMR5pWbYd4uz6w5iDdtDVEZhRDXASRbX6TsETNXNDn/kfVXAYNhp18BcWDbWV/rOLVJIRJ4xQE0gKzjbItvqM/VXV8NY5OaxSm7UpaJV7QMETvHzhjx0TK/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B5DniNffgu6Qz2rhmTFtzXOMPEVkhKMk0T2S6iDPd6o=;
 b=Q0pZuVCNOkH3XYCc846rresptBR+W4wH+Do0paCIe8saQDGyawcoTgMqzrcUnrzofmIkGsQE7cmLQHur7A9yhZYw2Htfgsj6UiOpnHkntreFX7iXclNM0TcFrCmI2uhelvbniXrXhkmIzW5rFe7tf6lq2rc90qotELpyHarK/47r1l2+EVV2TsrXVWWSl+6wLaXZNOAzAmxDOGIeCuqrVMaaTeQEmlCMkFjwzWQV9prl7lai7yV+E3X1YU0ITSu6fSL2PMqvJU2g+fYVdeiCQcBgYsIBdT1YO+VrLSJTtsuEp+hZdycsLaGRZvYNMIokan2c9aFQbo0v95sNEIdzMw==
Received: from DM6PR02CA0106.namprd02.prod.outlook.com (2603:10b6:5:1f4::47)
 by SA1PR12MB8967.namprd12.prod.outlook.com (2603:10b6:806:38b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 22:29:28 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::c) by DM6PR02CA0106.outlook.office365.com
 (2603:10b6:5:1f4::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 22:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 22:29:27 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 24 Nov
 2025 14:29:14 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 24 Nov 2025 14:29:13 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 24 Nov 2025 14:29:08 -0800
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
Subject: [PATCH net-next V3 06/14] devlink: Add parent dev to devlink API
Date: Tue, 25 Nov 2025 00:27:31 +0200
Message-ID: <1764023259-1305453-7-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|SA1PR12MB8967:EE_
X-MS-Office365-Filtering-Correlation-Id: cb1089fa-7465-4a5b-c61d-08de2ba8edef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ayoft3FW+3sc8tgIJWbgO2EDCzobNGERoIFoP8rmWuKxJnDIH8UaNY3gAkEA?=
 =?us-ascii?Q?KWQrHEl5nHsiBGraTQLuM4oIQOvC3XEtIJRdlgLoOTDNXncAuouDPAwSbCZG?=
 =?us-ascii?Q?9Tg92NjkCMrzDIuBePTILTQ1n3pBoBg4zoVMUC8Z9Weh7UaROyjnVtBs8PZK?=
 =?us-ascii?Q?5yGg/MDaxVjYaarBJMeZvhcgD5oSdAi1581OU/KSw1UHuWtUA5Tr49KDRjRu?=
 =?us-ascii?Q?zg3SavV/Wzb6R/CqYMZwuOPG1fmT48EQZw2StnQ2uL/dXJ6Wvy8jqtgqpRD+?=
 =?us-ascii?Q?x3MNomhWEi8jDI40KsvwVB8H9FFVetNPXCOo5tRbmGw1If4vMpd0HGRYdUg/?=
 =?us-ascii?Q?vaxBmNhFqKUU2NsZDZPy/Xwzb26KQOOHRqLoeNEBzRkVGSiSTUjiKDOEN/NW?=
 =?us-ascii?Q?JZzgakCdac/ybgbt6ob2/9yhS9tN3VrSZN2gp+YnEOkcUU36hzP6HxOTdFfX?=
 =?us-ascii?Q?id8Rsqu2teGJZV2pLBx6H502EYwaUs9YzxW8Q2S5ZJLlg97W8ldH/Ii6QD0l?=
 =?us-ascii?Q?npc1ZEj6cwJRMYJzz8VQFQc3pbjqw8BOg7agWEjqN5hWiMUvvjGe4kuKJokx?=
 =?us-ascii?Q?4qa9A6HHMie+5X4qWqufaCdGdebDZ1XS+JuWF3DyBcRKqnC3HVoYVHard6LN?=
 =?us-ascii?Q?pkYHFzPxBQLPjBCilwNyFOLAqOS7+lx6+hFUMqemnINC3FiAKvRCjODDf6S0?=
 =?us-ascii?Q?qrdJY+cJdeID27QJ0vHtGLPymBqEVha8PXHndzAnsgbqQVxSSApoSoZD4MDJ?=
 =?us-ascii?Q?BTX1U8T/2O6+Yemnz67MoUvX2TVQ3XgrUkH7a8ZQCAEQyqSYICpkPyvBtpjz?=
 =?us-ascii?Q?zSANaoRY7pQnxkD1C/D9fnaINa+PKo5nOEr2DIulIqlNeAFbTijGLT6Z5cvE?=
 =?us-ascii?Q?Zv7pHnU0p/tlGvDijbTs0LkBIBh3VDQPK2uRUsytYFSp0p3V2MQoU1MKVNxz?=
 =?us-ascii?Q?9MoQZFzghf5tXcRfHUdPXydJoYwSiDgiFQ/V21kMbZCBRWLvQscMiQUvQMRK?=
 =?us-ascii?Q?1ptv5m7gBMxGmWpQWXIn4Xdh8OS70wAdtLmPerE+EJWCYwyLvbbpitBS+gn1?=
 =?us-ascii?Q?rqpzzsqgHqRFOwb7+3MCQNiCY/BDq2AkDKIjnG5Bi6qspPlFpYZCkb8/lGw/?=
 =?us-ascii?Q?liE9bomb2QIZm1rDA2jUZ8WVSv5hDVT+kll3xZTDbc9mtLbM0JRzhNRwQoWf?=
 =?us-ascii?Q?shLc4wzHUc0GsqNGm3lpIiWQhgSd91xMNFBtikkGzXpoa4Mb3cGPwjIleF2k?=
 =?us-ascii?Q?aZnjFtQaXiEtWWI+ag20F7e5nE+3vBqdnChSEFW4xxJNG+7bwRExAn18BF6H?=
 =?us-ascii?Q?0akzAdeDReECUdzikZBTfy0knm728nv1/1EZR7suP1B57fPRt2DAh+pf2uNl?=
 =?us-ascii?Q?4aW14G2IPJuoNGw30DaKlt9yO9En0iW+UKTu5hf0rFLBFGJb6O098yQhEa8K?=
 =?us-ascii?Q?jlVrhFKmQDLBGcw+cJ4P3eiiIjmaJp0RKjqEef4Wc0r+NqwDDJ1fZCRf75Az?=
 =?us-ascii?Q?Wm+SxbvrfMTBMJ3P151wHeS8RwORu7+bUS3TDCQBrm4Ok4skmu/YErYguSkd?=
 =?us-ascii?Q?ige3I+C6srk00++GyFk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 22:29:27.8348
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1089fa-7465-4a5b-c61d-08de2ba8edef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8967

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


