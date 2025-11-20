Return-Path: <linux-rdma+bounces-14641-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 62141C74203
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 335A735AF69
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080A533BBC3;
	Thu, 20 Nov 2025 13:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NUz5Iqcq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F0B33ADA1;
	Thu, 20 Nov 2025 13:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644439; cv=fail; b=H2PQKPeg0vRuurPMW2b9AYOUfrvgcY0CwzNis0rIW59zwDfLr+rUOOCzKCNCd/JtfA5xyi44WkbWumtsuIc0uww8xcbD+EWgf84PETnwpaWgoLkO70VfvCtyqN8/Y0kTv2pNnU5qxom+64LxIYfO/OinGdOStffDjakRalfptL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644439; c=relaxed/simple;
	bh=GUl7EljBHhJhuehaHegX7fbEwV5xsHCffH3Dmd9ZmOg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MuAsqxguWZyxlML7g3Q23ChEzzEl1dPGJ6vpUP8Hx2dX/cDKvdvw6PpehB4uPsTXinZpWMaghjPwX0laSIeF4108/rBXV4S1VtHgILlKnaMuG9s8P6dofNMUF1R0vqeORyZ6Ro5l+VaiBtwRHjCCmsCkYcFmJqIak75G3QqJg+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NUz5Iqcq; arc=fail smtp.client-ip=52.101.43.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ldToFBbHv9sx6pmxomu3p7waFRtqCM4vGnCvuSVceJcVONrqps4chrzJmt4Ln6Ovx0uWJ0ZJKF+hTkQigXTgD1Hw+JojMQPYIxRD6IOcQzTIZJEEv8xm79WCMe0QaRefNJdChewgjX0ECFIgtIl0afjspShodvkTycjQE0LXgT6VmkPeu2H/UKTrn+G4Ooo8ICHHozxAy7IAd0Q77XJDMw7YZrFne+k+VCn06YhIx1Ptfkj2H19IsSd/csFb8U81ciU8ytl2P+b+MenI/RgkBo2ZBASlx8WW11VclCtrROVn498G+98U9m3bMHHTfojCzRw48yNRqjGrs79YnW4MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FzIKOzo8cM3LWaYX4Iqqu/INLIJCOdLiYgif027XBlA=;
 b=aK3Ti9awMMJ/ZOIuviug9L0eqW5XHLClducnDQD9XS7DlhoFEM3kZVx6GujrZvYBiHSl3R/QRHPiv71pOGKpBQ7rItMc+NlKhGTPqD3KezctHpKKnESW35VIgyxvdltBLp2VsjH+ojKGu+v4T6Jth/ajuXsy7ff/raRpH+7/bPNf1b+wBpUHwG60NWPk9So6wEsonMPrrdU/JYoziZNSeCP0U/zK72KnMS4aT1QA1LLQYD6dceq7QXL9Ip/rvLJwvxzgjBCyWfA/2h5vOv9HbZvuorBq9GDgM78nAcq1pMTm3SoRylxHbhLPp4DDrRGBIHZgC/GISttkjuthdKrplw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FzIKOzo8cM3LWaYX4Iqqu/INLIJCOdLiYgif027XBlA=;
 b=NUz5IqcqgVAceio6I+Csc0Hzd+Yu/pV3tbM/TJp3TdeWpSqebmj45augFAhHtuR/aa7cD1jwTOEMpLPdI/HYz2OnPIsZjwOBpJPJoDojhaFPAkh1L8v8bs/VQUUHqGqZPiTiE4wb2dDv8gi2x3dNAne9swQBwRaZlS37LT5C07nabAQVLy2oQAkMPiQGiL9vosM4kvghnFlxYdM1iXV/GlxWyA/m+9wSItAwMoEBAa4SveB+oSOQL9hnJ/wX6OyMyJFGxhM0WyX+RnwyUqzURvb+nU/oRv6xAy+rdKkD6TjmWKGhQFeryLNKASjJGNwo07ZcQqQl2hkGzMPDUj6Zsg==
Received: from BY3PR04CA0029.namprd04.prod.outlook.com (2603:10b6:a03:217::34)
 by DS2PR12MB9710.namprd12.prod.outlook.com (2603:10b6:8:276::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:13:55 +0000
Received: from MWH0EPF000A6735.namprd04.prod.outlook.com
 (2603:10b6:a03:217:cafe::fb) by BY3PR04CA0029.outlook.office365.com
 (2603:10b6:a03:217::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Thu,
 20 Nov 2025 13:13:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6735.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:13:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:34 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:13:33 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:13:27 -0800
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
Subject: [PATCH net-next 04/14] devlink: Refactor devlink_rate_nodes_check
Date: Thu, 20 Nov 2025 15:09:16 +0200
Message-ID: <1763644166-1250608-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6735:EE_|DS2PR12MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7005b350-fb27-4149-b8ac-08de2836a872
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jTvpkMRBy+ltX3qftcMj1lnon0CcA6FhPV9aofl9YNWR6RpMmimkmoJA0FMx?=
 =?us-ascii?Q?DIn98a8QV5UBy2QrXQ1u0bLXLUA/SS4jaZuhpvVDR0QH1adkjKieXkcv7PF8?=
 =?us-ascii?Q?9F3KYwmvrgKnP2E4TfMxRpZWnJx81Er3VEmrwkntYj5TRqX7uVa0K1m6jxoA?=
 =?us-ascii?Q?LhMK962RpePwWaBzMwnJqEyPt/0XWWE3jaaWBf8kqlA7cGCAIu7Wk0MjAHJh?=
 =?us-ascii?Q?Jv4KU1RpDz86/QHCrYyLvZgt1gdyYW9kdgujKz8j5XJ4qBgMiwkxT675X0wf?=
 =?us-ascii?Q?bYW9s4cZF10lMmEbBOWbzvXIkJ7HanqNyOh5DD5wbIONrgmXCozzq5WQ9Ss6?=
 =?us-ascii?Q?VcrOR1sLZHGdJLdVIYS5oUoB3SoUpEkSFLw74witFFmIzSmCrX7WCU2n4LF5?=
 =?us-ascii?Q?0EuRGmlkxUlJMI1CmiwGYpy9WO2LbphyDkvpjZVIQmBd+dm9Di8bkRZ/Z2yv?=
 =?us-ascii?Q?FkEtHWlbXCBeY64FLXT6bkOh5Ph9quzFrUaDME/nwUj/O7QTkIzmIyecjtBv?=
 =?us-ascii?Q?hvP+oir0p49CpQsNgb2NnvxW6Sdjh1tMXEzgdKuEUmlT2VCgxO8KnGBOs+ep?=
 =?us-ascii?Q?tlD33YE3hiN0eS/J9fHSf0lUoaAGS0ZpoPOLpG/i8PgNWKaBkwOMmjFq7UGc?=
 =?us-ascii?Q?A87LybQMcg1FdnMhrASbsGYOv4gVXrJ8LXZdnnLK6l45rAc9M8oTLWMsDNho?=
 =?us-ascii?Q?Q3WYTS7j4fwAuAb9+tjm0QIkgUBUVeEunE+uZFF5mrqtcdz/wvGumEPM+dYC?=
 =?us-ascii?Q?WKEsqiRAIua31las3kfl+WZGnFsRio6OifKTTXemQw5/fGLoI9lUAjxpJweF?=
 =?us-ascii?Q?4qzDYN26xc9MFJPJHGUmcUekTak6v/r2TF4sqOe4yUpSoFbqoGEJnJovFhsN?=
 =?us-ascii?Q?/B11XjdPJcBEMOkYIEMYPxSwlzNJgjWP3Sa8rv+jBq57532Mj3O1iORkClGJ?=
 =?us-ascii?Q?jC4GUuiFidNGKEq9e90i4ldfJxZ7/XyAUIX91hWim4kYGj7dFTC9zeps9NSW?=
 =?us-ascii?Q?Yra09kRsUrNwnZvI0yrJcmvJNRjqdOIetE4u+2dAshAhWT80l/H/RYy4JphD?=
 =?us-ascii?Q?4u0Ui+E7bWAcMrSfN/heB05aVKZ4hVLgskekVjufu2IaLervy/v1cBczMHh2?=
 =?us-ascii?Q?umb4BOAUWyUfWCtdRHn0fUmYJwOhN/Q7v7noQTnuiuLYHYtS0AQJCz2DXngp?=
 =?us-ascii?Q?Krdkq30/mvmaMjxSH8oOBEi1qzYXexHPm9NpJ0eSc/1QSirrOvMkGgegKhbP?=
 =?us-ascii?Q?9sKz6vkk1Pat2+U7Rx7Qf8ZssBi/6VQgmyY/1/gAe4bP1nHu/TUCHsigObtT?=
 =?us-ascii?Q?+qamp6yODbHYhK7u95jBtx81nObw0g78CaejYuHPVOmkmut+BT5d9bduFWv+?=
 =?us-ascii?Q?CHtvVFg4whQT58d1t18+V232+yVry9x4XsQsmnYxctzV/9gAPwUdXfVidZia?=
 =?us-ascii?Q?w6uqV5p27e1aiFXuuWdsji0NbdlW/PdSqDxRWkjImIbDVvSeooMuoNZpUzIR?=
 =?us-ascii?Q?60I50y9vL/vMdtVE3/TJmhJk0IpaxYa+4QFUVeucOfADD86LGMZuhf59Ilxi?=
 =?us-ascii?Q?ZpTri8INNToD+Z3y6A8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:13:55.1649
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7005b350-fb27-4149-b8ac-08de2836a872
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6735.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9710

From: Cosmin Ratiu <cratiu@nvidia.com>

devlink_rate_nodes_check() was used to verify there are no devlink rate
nodes created when switching the esw mode.

Rate management code is about to become more complex, so refactor this
function:
- remove unused param 'mode'.
- add a new 'rate_filter' param.
- rename to devlink_rates_check().
- expose devlink_rate_is_node() to be used as a rate filter.

This makes it more usable from multiple places, so use it from those
places as well.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 net/devlink/core.c          |  2 +-
 net/devlink/dev.c           |  7 ++++---
 net/devlink/devl_internal.h |  6 ++++--
 net/devlink/rate.c          | 13 +++++++------
 4 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/devlink/core.c b/net/devlink/core.c
index f228190df346..f72d8cc0d6dd 100644
--- a/net/devlink/core.c
+++ b/net/devlink/core.c
@@ -517,7 +517,7 @@ void devlink_free(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->resource_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 
diff --git a/net/devlink/dev.c b/net/devlink/dev.c
index 02602704bdea..e3a36de4f4ae 100644
--- a/net/devlink/dev.c
+++ b/net/devlink/dev.c
@@ -434,7 +434,7 @@ static void devlink_reload_reinit_sanity_check(struct devlink *devlink)
 	WARN_ON(!list_empty(&devlink->trap_list));
 	WARN_ON(!list_empty(&devlink->dpipe_table_list));
 	WARN_ON(!list_empty(&devlink->sb_list));
-	WARN_ON(!list_empty(&devlink->rate_list));
+	WARN_ON(devlink_rates_check(devlink, NULL, NULL));
 	WARN_ON(!list_empty(&devlink->linecard_list));
 	WARN_ON(!xa_empty(&devlink->ports));
 }
@@ -713,10 +713,11 @@ int devlink_nl_eswitch_set_doit(struct sk_buff *skb, struct genl_info *info)
 	if (info->attrs[DEVLINK_ATTR_ESWITCH_MODE]) {
 		if (!ops->eswitch_mode_set)
 			return -EOPNOTSUPP;
-		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
-		err = devlink_rate_nodes_check(devlink, mode, info->extack);
+		err = devlink_rates_check(devlink, devlink_rate_is_node,
+					  info->extack);
 		if (err)
 			return err;
+		mode = nla_get_u16(info->attrs[DEVLINK_ATTR_ESWITCH_MODE]);
 		err = ops->eswitch_mode_set(devlink, mode, info->extack);
 		if (err)
 			return err;
diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
index aea43d750d23..8374c9cab6ce 100644
--- a/net/devlink/devl_internal.h
+++ b/net/devlink/devl_internal.h
@@ -300,8 +300,10 @@ int devlink_resources_validate(struct devlink *devlink,
 			       struct genl_info *info);
 
 /* Rates */
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack);
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate);
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack);
 
 /* Linecards */
 unsigned int devlink_linecard_index(struct devlink_linecard *linecard);
diff --git a/net/devlink/rate.c b/net/devlink/rate.c
index d157a8419bca..0d68b5c477dc 100644
--- a/net/devlink/rate.c
+++ b/net/devlink/rate.c
@@ -12,8 +12,7 @@ devlink_rate_is_leaf(struct devlink_rate *devlink_rate)
 	return devlink_rate->type == DEVLINK_RATE_TYPE_LEAF;
 }
 
-static inline bool
-devlink_rate_is_node(struct devlink_rate *devlink_rate)
+bool devlink_rate_is_node(const struct devlink_rate *devlink_rate)
 {
 	return devlink_rate->type == DEVLINK_RATE_TYPE_NODE;
 }
@@ -688,14 +687,16 @@ int devlink_nl_rate_del_doit(struct sk_buff *skb, struct genl_info *info)
 	return err;
 }
 
-int devlink_rate_nodes_check(struct devlink *devlink, u16 mode,
-			     struct netlink_ext_ack *extack)
+int devlink_rates_check(struct devlink *devlink,
+			bool (*rate_filter)(const struct devlink_rate *),
+			struct netlink_ext_ack *extack)
 {
 	struct devlink_rate *devlink_rate;
 
 	list_for_each_entry(devlink_rate, &devlink->rate_list, list)
-		if (devlink_rate_is_node(devlink_rate)) {
-			NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
+		if (!rate_filter || rate_filter(devlink_rate)) {
+			if (extack)
+				NL_SET_ERR_MSG(extack, "Rate node(s) exists.");
 			return -EBUSY;
 		}
 	return 0;
-- 
2.31.1


