Return-Path: <linux-rdma+bounces-14766-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E271EC86EF7
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 21:09:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AD53F4EB61B
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Nov 2025 20:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C59BE33E35A;
	Tue, 25 Nov 2025 20:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZeK/fVGT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011044.outbound.protection.outlook.com [40.93.194.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC61733DEFD;
	Tue, 25 Nov 2025 20:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764101262; cv=fail; b=qzGHw16+Opvd1Um33XQXA14nEfSaJgBevJPAGjQXoNsCn7ChUtlH0U2r4ODZLL+yTEJL/cEb5AH+PTYHe+gTdx5tkxVWUv3HR9N9ZntmQbPBrQUtQDV1b/yB6UM4Ckg+KvlYXMAYaOsPY58zLwE91uiTfazrppM4x6gGYS8XsZU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764101262; c=relaxed/simple;
	bh=j+JpDB8lrUITToa6HtXVUiQKkYMS06iYiub1LMNjBWI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLxKGV8irG+/RwVWHPuXvB2hZFgv/Kmjrm+XzSv74I20sbLFVTuVqmUunO6BIRTMCL+vWRCwBQELU1Y/YBfxvZoQnFpLpIkpS/i0I4o0cNzkr3t6jma221Fa3DVxSTwZdq7B0jQvUDzFvO8nUtIxs9tSRFr1lkUwxtCQ4LowJWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZeK/fVGT; arc=fail smtp.client-ip=40.93.194.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OORBdD8Cnmoz7BGAIy0i6obH55CcbRmudtIdaf8UkN5xYOvhf01KogEcD/l8orgwr9MEz0WypJCNCHHv05o4kWBcJv5EzD7bDcCPi0Gb5/6dK1X5fV+hh8KYVBEaiXDObsYGRLaM82HyQMXmyjQkhMHzEg0RkKk4d2VCrf99xUcaRpxq/a1+zlnfLi7Vs9/W2/eHcvKOr8vGhj/0abVeECE4Ac0sH0wbY0fBjjt3SstIj285EY1JUQ2yUoAUwrxe4vyPjG9nZ/Vd0qSGnBy/m0Je5DicsYuWuVFbtz/Fznz/RuknvpvaJpG5AHp1Kg4YdqzsAm0VAv08hJE1DGNmSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7MGL78J8w1FDJhYk01+ZTwT+lZwV/itnX/hL3p0kBQ=;
 b=Svpc7zY4RKEpdqY4IvYn+tDhKCbhExoOGDgDi21Hyl1/0TbpweaqyW5qEwFmoLEAZbv47arVMBMNh74fnZ/bqNn8WaVLQJOrKyv4/Vf9neV3hF94kAHbT08dhjX298OP2pZRsOFVo6y6dAxSODDaxcULxl0x+kSBjoE5vCZCQUNr3E/fb3bJmVQMcJoZAca8i2RXC0ZoJNLHyKfzPv2N+gBfuEz2tfuq9CEgTLlW1T182ct3bdYzBU9okz39ZOksHBEE19VR+9BnlIcXm/YozIzXPtck45fc+Xwmg3H6bYgGnRK2DZyqGg7CFMr52KzDknk9lro8l+FxG6GtTxfnRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E7MGL78J8w1FDJhYk01+ZTwT+lZwV/itnX/hL3p0kBQ=;
 b=ZeK/fVGTKFjCdv+rRKF8BDL+Af3dEyXicLGgEAx0dKHPIS5Pe+5FLBMpGKwFdz9kz4HAV4R6VwE0Gx3+GrrZ5w4BM1ZD/VWimB5ym+kwgXvIApkEIJhuP84Dc9Tx/E03NdPbTXtWdiGrFIvNpya/f9VA9f2siV1LvBA4MtMGeLQtnoWYos4rIokkiuCKroC3jffJR2lUIWm6uy1OTwYwELLGEk8q3Cl3toMlxgbCBXqGlhJrcCN43EU2pqETDzV9vatHc1GFBwL7QL+jzjwOjVzQLFXtS37QNFTLpZaDtDFM5JhnoM2uuopUXcopt2bDkhCHaUzLnXf7L4IovCBJSg==
Received: from BY3PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:217::11)
 by BY5PR12MB4129.namprd12.prod.outlook.com (2603:10b6:a03:213::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Tue, 25 Nov
 2025 20:07:37 +0000
Received: from SJ1PEPF00001CDF.namprd05.prod.outlook.com
 (2603:10b6:a03:217:cafe::59) by BY3PR04CA0006.outlook.office365.com
 (2603:10b6:a03:217::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Tue,
 25 Nov 2025 20:07:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CDF.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Tue, 25 Nov 2025 20:07:35 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:17 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 25 Nov
 2025 12:07:16 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Tue, 25
 Nov 2025 12:07:11 -0800
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
Subject: [PATCH net-next V4 07/14] devlink: Allow parent dev for rate-set and rate-new
Date: Tue, 25 Nov 2025 22:06:06 +0200
Message-ID: <1764101173-1312171-8-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDF:EE_|BY5PR12MB4129:EE_
X-MS-Office365-Filtering-Correlation-Id: abc1e27b-9c10-4f2f-b5c8-08de2c5e46cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6/nLx1eOoEKshewPyuEFc6RC6GNLXJsWcnXlAMQCuBIIPURT06cNPzVtUEFC?=
 =?us-ascii?Q?Tma8zUbIfMlWIFnwN0mrpUcRa5MOqZN5xRYKehaHsdaZAvhqg0RrVT3i1GqN?=
 =?us-ascii?Q?wBUSSJ8+zxpL/Z8hUYls2TAREgqNskLnjyivfM45IAodP72PUs5PQPfZ4wBF?=
 =?us-ascii?Q?CW4qUO8bzAGmukmjmqO38JBdSrAn8b2Si8hDFrNC+8O8pciPKyQerWpDp0Zj?=
 =?us-ascii?Q?MElh0aLTYo/TKI+cjgEB1AUco01xZ5ioezpqim3O/jx7jZ+giseck1ZBybx7?=
 =?us-ascii?Q?OTppV/I39yakyZslaU2PCX7JOcna0jbxWbUTzcv5JQfLZrkXsa3cg+h5KJUU?=
 =?us-ascii?Q?mAYn7ZSUlaoHxF9r2qFAqN7qtiCFIBsY//o2ERH9g8C1vXwyihflsuah7rXP?=
 =?us-ascii?Q?P4HXmJPgqbfc/GaXgwRUoScfqoOS8hiiADziPbfJsLqW2grWDHbI5kxw3vMF?=
 =?us-ascii?Q?6JU3PewQv/G58pC84bNqy9hfP2vtUq5yKiedWvEyAk1JbH9n47UxZVVJXCvY?=
 =?us-ascii?Q?Z1A06FwGozKUXzob/+OdtPgLRT1kAFYAHnrdwOWX/4Qi9JRPQyHrYUzGsdUk?=
 =?us-ascii?Q?vmRtF6CB8czhdFXXVO2hsojwFCl1hPwzo5NvSs1n3MKFZplbUgNgBOdP1dSg?=
 =?us-ascii?Q?lF3dmQmWrdMOmrssQu6SgiE/lbSKzRTCYoLyqd39VyczsXEwMeK6eAHJVzFq?=
 =?us-ascii?Q?xRshGJXFIvgnKpGgnMk5/AsgjVVehdKH8hFv6+50gFs7mWOByn5QzVQWsHiQ?=
 =?us-ascii?Q?gDUZsA8JRSweXLYdIquAccly1i0GbJlpsooDTVy6PWHodbpo2oh5uyuEADu0?=
 =?us-ascii?Q?5OwGRHio7Mz/i6YzS6/tEd9I6I7/A75WZFHRrAotgMMYDGHyI8UYV+n8aJSf?=
 =?us-ascii?Q?FrpK33fGAdg06MuuPUEADvoymH0Q5Fyfnnnsv4+LLtKRew5LdI6nGeHNas+G?=
 =?us-ascii?Q?YJKbCbe/chD5nQ1q9r46h5K9PSllcAGtxzgG6a24SQPUn03TNy2zPTxFWZu0?=
 =?us-ascii?Q?iemaLNK6ij3lNISmiz+WlOfzDQVONSZA7Nop14cZiIChESQO5j3gSk90u126?=
 =?us-ascii?Q?Hq8uCwZDYX7RSqZ0XV+0e+LwO8IaoUJZTkXRhVP8ZZb5qpTjhotjgJzngcqF?=
 =?us-ascii?Q?VbGPcxP0mySraSw7MrkeZWBtcBcYvJn309JKWGnDLJk3mKQZHsbVHaJqBg8a?=
 =?us-ascii?Q?gvBLsrV7AaLddvHbJbR4T9fZ5PUMIWBMfCKeS54K2/UibxfZJ2b03e0W99cv?=
 =?us-ascii?Q?9bix7B+HaZLWBN8r9/ruf0vDf/e/uSthzd4pjTPHxaP77QS3rvDJeqSiZomx?=
 =?us-ascii?Q?h5cDQBxk0EVnfbYh7OYCBoMZSc9SFsqvqRUz6OuhRm1bUkuVlgd6KB2rX0Ae?=
 =?us-ascii?Q?LIkJPyKhqL+GTIS6tbGufLDyb7/y8sCbpRLbgnl6XC8Qzln99nZEXm+z/vqw?=
 =?us-ascii?Q?ASNKOc+jdrE2+WD9hhDjI9oT9W3m4moj7oMvyCaAYCiq149VI2jlD6AMJ3co?=
 =?us-ascii?Q?+00wDalOV4ZxX+T2ku9kF3CV/Rj0AeIaYQxNOKG7nqtQtdIBDeAkFWt1CAQn?=
 =?us-ascii?Q?J8hn6qQOlHHCMP8fI/0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 20:07:35.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: abc1e27b-9c10-4f2f-b5c8-08de2c5e46cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4129

From: Cosmin Ratiu <cratiu@nvidia.com>

Currently, a devlink rate's parent device is assumed to be the same as
the one where the devlink rate is created.

This patch changes that to allow rate commands to accept an additional
argument that specifies the parent dev. This will allow devlink rate
groups with leafs from other devices.

Example of the new usage with ynl:

Creating a group on pci/0000:08:00.1 with a parent to an already
existing pci/0000:08:00.1/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-new --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "rate-node-name": "group2",
    "rate-parent-node-name": "group1",
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.1"
    }
  }'

Setting the parent of leaf node pci/0000:08:00.1/65537 to
pci/0000:08:00.0/group1:
./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/devlink.yaml --do rate-set --json '{
    "bus-name": "pci",
    "dev-name": "0000:08:00.1",
    "port-index": 65537,
    "parent-dev": {
        "bus-name": "pci",
        "dev-name": "0000:08:00.0"
    },
    "rate-parent-node-name": "group1"
  }'

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 Documentation/netlink/specs/devlink.yaml | 10 ++++++----
 net/devlink/netlink_gen.c                | 18 ++++++++++--------
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
index 1f41d934dc5b..bfeacfcfdf9e 100644
--- a/Documentation/netlink/specs/devlink.yaml
+++ b/Documentation/netlink/specs/devlink.yaml
@@ -2217,8 +2217,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2230,6 +2230,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-new
@@ -2238,8 +2239,8 @@ operations:
       dont-validate: [strict]
       flags: [admin-perm]
       do:
-        pre: devlink-nl-pre-doit
-        post: devlink-nl-post-doit
+        pre: devlink-nl-pre-doit-parent-dev-optional
+        post: devlink-nl-post-doit-parent-dev-optional
         request:
           attributes:
             - bus-name
@@ -2251,6 +2252,7 @@ operations:
             - rate-tx-weight
             - rate-parent-node-name
             - rate-tc-bws
+            - parent-dev
 
     -
       name: rate-del
diff --git a/net/devlink/netlink_gen.c b/net/devlink/netlink_gen.c
index 8fbe0417ab55..91d2c9b69391 100644
--- a/net/devlink/netlink_gen.c
+++ b/net/devlink/netlink_gen.c
@@ -535,7 +535,7 @@ static const struct nla_policy devlink_rate_get_dump_nl_policy[DEVLINK_ATTR_DEV_
 };
 
 /* DEVLINK_CMD_RATE_SET - do */
-static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -545,10 +545,11 @@ static const struct nla_policy devlink_rate_set_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_NEW - do */
-static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_BWS + 1] = {
+static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_PARENT_DEV + 1] = {
 	[DEVLINK_ATTR_BUS_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_DEV_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_NODE_NAME] = { .type = NLA_NUL_STRING, },
@@ -558,6 +559,7 @@ static const struct nla_policy devlink_rate_new_nl_policy[DEVLINK_ATTR_RATE_TC_B
 	[DEVLINK_ATTR_RATE_TX_WEIGHT] = { .type = NLA_U32, },
 	[DEVLINK_ATTR_RATE_PARENT_NODE_NAME] = { .type = NLA_NUL_STRING, },
 	[DEVLINK_ATTR_RATE_TC_BWS] = NLA_POLICY_NESTED(devlink_dl_rate_tc_bws_nl_policy),
+	[DEVLINK_ATTR_PARENT_DEV] = NLA_POLICY_NESTED(devlink_dl_parent_dev_nl_policy),
 };
 
 /* DEVLINK_CMD_RATE_DEL - do */
@@ -1201,21 +1203,21 @@ const struct genl_split_ops devlink_nl_ops[74] = {
 	{
 		.cmd		= DEVLINK_CMD_RATE_SET,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_set_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_set_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
 		.cmd		= DEVLINK_CMD_RATE_NEW,
 		.validate	= GENL_DONT_VALIDATE_STRICT,
-		.pre_doit	= devlink_nl_pre_doit,
+		.pre_doit	= devlink_nl_pre_doit_parent_dev_optional,
 		.doit		= devlink_nl_rate_new_doit,
-		.post_doit	= devlink_nl_post_doit,
+		.post_doit	= devlink_nl_post_doit_parent_dev_optional,
 		.policy		= devlink_rate_new_nl_policy,
-		.maxattr	= DEVLINK_ATTR_RATE_TC_BWS,
+		.maxattr	= DEVLINK_ATTR_PARENT_DEV,
 		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
 	},
 	{
-- 
2.31.1


