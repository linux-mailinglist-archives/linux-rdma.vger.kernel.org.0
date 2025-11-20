Return-Path: <linux-rdma+bounces-14648-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D6DC742C8
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4BAE4ED934
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Nov 2025 13:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0141D341AD7;
	Thu, 20 Nov 2025 13:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Drs9b0Z3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010051.outbound.protection.outlook.com [52.101.61.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7134133B951;
	Thu, 20 Nov 2025 13:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644489; cv=fail; b=HZUfuozY8TEpFs9Z0+woOJe1Q1pM3JDvb4T2fXDnhisW6ravvDHJw9FsGqN1vKwib9qZo2H08N6nWTXHRxrAzlmutlVZobouzaevVDY/n/xt8SDkKNoD0JfZbEk6hWpb1egaX2x9fx4Chq5+VFm3FtTdpd8SaVJTOLfMuEJKThQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644489; c=relaxed/simple;
	bh=7fDKZe2Jym2PxcPQiqFdF9u5tnaIGjo+GUZ2Niq8JQ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IoVzERswqlbT0U4a8t3EMxnzCHTUeUUx5SSLZGvmEgGrSooo/1R2UJEPhmHhEEn5FB+HQer+FTHeZ5o7dPLcdfeH0yepWEaUQHFOL3KqacmFDEHNYI1ZSMjycT08T8YhVre/EMMghJm9RzIeVlJI2lLXQO42Q11twvQb6VKbURs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Drs9b0Z3; arc=fail smtp.client-ip=52.101.61.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tJGeyvLGtlceML0HocwI7V0rSd4yU5ONnETFtZBnGcgRhVm+kxeeakQXdT5vbsfhWP+729FTg0FQk/bzPwKnE6BFTeZuqpyrXtZjXAHHkIiTYTxrOtNSA98SLDmlQa1n8MfU0eQzE9lWq9WfXUma3uqDoWrgnq5mQ1nB6hyzPZ+Mlh3pcPbPggkRiIn9cDxvN5nw72ckh/MtcJZpoRNdM26mg+ad6XlUE6TBlHYWk/BJeU/M+xGjr2FOMvhfaRGCjPeJuyKlYVTYOnoCaZWscooepE9GbCQAoKzxRPXnkUjNF07hKrG0+D7sQeXwWkL+lHkhVlf0yiOzr2ZsfHrRzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i0WMOHZP1mXwSreyV6aKUchOFswxAwSJSyOhYm7NKxA=;
 b=Aid7rPpN8eS3qni9JaDhxQXanXy7tj5VrZFPpGtRNi/XZKLKwxLNQzgKue9xJu92dKn+IGndg4lXgYBnBjbxUKJlbw2RfIVe24odOr1qnGNONanYJ/VPjNfVzGKf94aTzg3mk4N1xluzGQ+J8N4S0usQKZorpnUd7AalxdhEGKjrsaxov2aoNMavScKsugwdBU/kH+6jqpEHQTfzRgaPoPGfFLQolrhpDszes7w10fbOfgVtuE8vGyH9A7+9FKtTZPeXvYzAP3uGHN2h9HFLJK0tHYqjjWGjB46h2gQZdFq67eAA6QseshlrI+/7pnlYHesxMtAmX34t8/7l/5v9NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i0WMOHZP1mXwSreyV6aKUchOFswxAwSJSyOhYm7NKxA=;
 b=Drs9b0Z3819IAIdtszA0cbGLu2iXnNH3xqs+ZWJ5aaoMaNNSJmUnRfxsbhMydqzBiPC0WIq+f6N728jKcBlk5JYifXDZjFZmdn3rqY9JMsQJZjstdL9+YPJsWvVshyMd/dAhWlu4BlrpRtrDXOlxPkjt8oGQngHgWVQnrDh4wF/FfBlNe+P/Z4jTxfllNyOAXIozCRME1JKKO6uxiFJI681PcElZV13V4wKUBxiCBIKYytvNLxw5xFgyxQrg+kbuygntdp4yET4O+NvEzFzlbiklc51Jvn81Zvq0wco/v9Cao/EnsFy5SuY4OCgq+vX8jlI6JbbXiE0EdwSIyY7cbw==
Received: from BN0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:e8::35)
 by CY8PR12MB8298.namprd12.prod.outlook.com (2603:10b6:930:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 13:14:37 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:408:e8:cafe::3) by BN0PR04CA0060.outlook.office365.com
 (2603:10b6:408:e8::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.11 via Frontend Transport; Thu,
 20 Nov 2025 13:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Thu, 20 Nov 2025 13:14:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:21 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 20 Nov
 2025 05:14:20 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Thu, 20
 Nov 2025 05:14:14 -0800
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
Subject: [PATCH net-next 11/14] net/mlx5: Store QoS sched nodes in the sh_devlink
Date: Thu, 20 Nov 2025 15:09:23 +0200
Message-ID: <1763644166-1250608-12-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|CY8PR12MB8298:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d34a329-62a8-4e56-5fa5-08de2836c1cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aDa/9dVKiy2OvHHl10t5iJONOu1thcM8tD7tEUYszIsD7WZ8ZKRd2CkkybXj?=
 =?us-ascii?Q?JMXKJed99MBreEgljeCPYTU0efwelJ5roFF98htyNbP1W679J11gvtD8f5XK?=
 =?us-ascii?Q?iouTDNrSk16cQi91let7qp1JIRZxbNqZSqhhQUrhDva2RU+n5fti5VTtpwsi?=
 =?us-ascii?Q?NtRZ+bc0CSbHM5IiV6AUu9UbKnppUbjkql7a7tnfz7shvTsQPvjwqRhkJFHK?=
 =?us-ascii?Q?EdEzpFSYNrwqzG0W8Kvr3H5wNnKUjWPpeOpnHYjezLmiXYJDRDHS4z2pOLXo?=
 =?us-ascii?Q?PScsS8HvIRmVDKVQO+zW8Y1Iuasxly5mp+Eq4JxXTobRPGjdGBycMIyti+kU?=
 =?us-ascii?Q?asnBG9QsDoxu19I06luMDD0UmrQA65H5DJXauNlaT1aU8ZBqxs6AeOyz7Hd/?=
 =?us-ascii?Q?KZAkAxXeswzSTvxBx/pB0s7ZHPCUI3EBJ9h9KOiRhbV3XP2t6PDzmKagXHsF?=
 =?us-ascii?Q?JQt0nxQ1pqCjIl9HfocM75zSWtTMbAqOPIK6q6sKp24O/RqNIENX8uObX+Ek?=
 =?us-ascii?Q?K6QuqKvtQDFItHmIPWWiwmXmXPmqTXDlRadmFx1Qu83yin2PVlqApyxScKn2?=
 =?us-ascii?Q?LTuJ8Z9WapRa2ZWFWFtu0ZaQ1qDw3n5roPfRNK4xShiAAXYyrXNGzNMrS1KJ?=
 =?us-ascii?Q?pCIQhEC+XSYafK0e4HPoqSVWPHVt4VoJbddVr/n9FbTXO9Ih+MO19aUIambh?=
 =?us-ascii?Q?LHcTd+5C9MVlZNTJgARMM/0j+gzQPdiaE/4qAnIpfsXRkVpBQfZ8/Y450wy8?=
 =?us-ascii?Q?zuQIDF5wO/7eK3Fw7YkhNz9YQuBBEsdHajUWEEnpKENEzcT1oZYC11XyBEbi?=
 =?us-ascii?Q?92D1COaOL2maiPwE4yHgUvParlupSyEmEPe9IVyPr42PWBiXW3WOLkCkbZkQ?=
 =?us-ascii?Q?r6jzWk/5LFaCMkwTZfkyY8EAiLIwmllg1Qo/nD7OfOV1T88qwzRSRDOO4u5T?=
 =?us-ascii?Q?tttUvL/5ekU5KvHrCPAVK6sUdUuP4XFGJ+bthVFai9qtfPLZWuBe+AAIluCT?=
 =?us-ascii?Q?RLTPiLk6EpiUhHR/4wgc8RXjViHGtZ9xCMo9b6UbYboDCZbSy1jmPmUsTv7Q?=
 =?us-ascii?Q?zlt1iCPldYUxcHjvz+jvECMx1i9JbNSoZE6nQLB3Az6WTbQwkcP4/ohUS6Sj?=
 =?us-ascii?Q?RKi6rX79MkTKRF3Xg/F+PcPeK5QWQDdP4KKIynXcMgGofo6snyRlTi4ERAOq?=
 =?us-ascii?Q?r1Pa/ATO2Gct51nN6H/McBeX0ttxyt+cQYsLaTAZDNmmZtVnFNJ9h51n//2M?=
 =?us-ascii?Q?ip522pGB58sLYP13NoHQDfoVqU3Cj2ofoMGe200vOkVoc0uQuYGu65juute6?=
 =?us-ascii?Q?IIyGwr4KX8Q2OMtgLtJspbcro3HKjyvIiu7+VpycbedUB0wDjgXDgRGHeuHs?=
 =?us-ascii?Q?tKsE4EvD8Ll3aS+b+lHP6kCEErH4B1nH8bI/cxGAatPUYHaSou5THfxYeyNY?=
 =?us-ascii?Q?7z8PCyguN3W+oH1NosGZe3/YAVY5skZUxmtlGotfJdiSV+zSSnloeAQOP4iG?=
 =?us-ascii?Q?CG0JbRZ97Prlcn7PYk5c1Dv1ou5oDG5PbMD9f3HHhuyv7NVnfTSRt2M0MTxt?=
 =?us-ascii?Q?XYZ4AlnKkWdeY6LhM5Wq01qzSTlqjr/D6EygJFqx?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 13:14:37.6061
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d34a329-62a8-4e56-5fa5-08de2836c1cc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8298

From: Cosmin Ratiu <cratiu@nvidia.com>

In order to support cross-esw scheduling, the nodes for all devices need
to be accessible from the same place so that normalization can work.
Store them in the shared devlink instance and provide an accessor for
them.

Protecting against concurrent QoS modifications is now done with
the shd lock. All calls originating from devlink rate already have the
shd lock held so only the additional entry points into QoS need to
acquire it.

As part of this change, the E-Switch qos domain concept was removed.
E-Switch QoS domains were added with the intention of eventually
implementing shared qos domains to support cross-esw scheduling in the
previous approach ([1]), but they are no longer necessary in the new
approach.

[1] https://lore.kernel.org/netdev/20250213180134.323929-1-tariqt@nvidia.com/

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 201 +++++-------------
 .../net/ethernet/mellanox/mlx5/core/esw/qos.h |   3 -
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   9 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  11 +-
 .../ethernet/mellanox/mlx5/core/sh_devlink.c  |  17 ++
 .../ethernet/mellanox/mlx5/core/sh_devlink.h  |   3 +
 6 files changed, 76 insertions(+), 168 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8c3a026b8db4..f86d7c50db42 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -5,60 +5,16 @@
 #include "lib/mlx5.h"
 #include "esw/qos.h"
 #include "en/port.h"
+#include "sh_devlink.h"
 #define CREATE_TRACE_POINTS
 #include "diag/qos_tracepoint.h"
 
 /* Minimum supported BW share value by the HW is 1 Mbit/sec */
 #define MLX5_MIN_BW_SHARE 1
 
-/* Holds rate nodes associated with an E-Switch. */
-struct mlx5_qos_domain {
-	/* Serializes access to all qos changes in the qos domain. */
-	struct mutex lock;
-	/* List of all mlx5_esw_sched_nodes. */
-	struct list_head nodes;
-};
-
-static void esw_qos_lock(struct mlx5_eswitch *esw)
-{
-	mutex_lock(&esw->qos.domain->lock);
-}
-
-static void esw_qos_unlock(struct mlx5_eswitch *esw)
-{
-	mutex_unlock(&esw->qos.domain->lock);
-}
-
 static void esw_assert_qos_lock_held(struct mlx5_eswitch *esw)
 {
-	lockdep_assert_held(&esw->qos.domain->lock);
-}
-
-static struct mlx5_qos_domain *esw_qos_domain_alloc(void)
-{
-	struct mlx5_qos_domain *qos_domain;
-
-	qos_domain = kzalloc(sizeof(*qos_domain), GFP_KERNEL);
-	if (!qos_domain)
-		return NULL;
-
-	mutex_init(&qos_domain->lock);
-	INIT_LIST_HEAD(&qos_domain->nodes);
-
-	return qos_domain;
-}
-
-static int esw_qos_domain_init(struct mlx5_eswitch *esw)
-{
-	esw->qos.domain = esw_qos_domain_alloc();
-
-	return esw->qos.domain ? 0 : -ENOMEM;
-}
-
-static void esw_qos_domain_release(struct mlx5_eswitch *esw)
-{
-	kfree(esw->qos.domain);
-	esw->qos.domain = NULL;
+	mlx5_shd_assert_locked(esw->dev);
 }
 
 enum sched_node_type {
@@ -111,7 +67,8 @@ static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
 	if (!node->parent) {
 		/* Root children are assigned a depth level of 2. */
 		node->level = 2;
-		list_add_tail(&node->entry, &node->esw->qos.domain->nodes);
+		list_add_tail(&node->entry,
+			      mlx5_shd_get_qos_nodes(node->esw->dev));
 	} else {
 		node->level = node->parent->level + 1;
 		list_add_tail(&node->entry, &node->parent->children);
@@ -324,14 +281,15 @@ static int esw_qos_create_rate_limit_element(struct mlx5_esw_sched_node *node,
 static u32 esw_qos_calculate_min_rate_divider(struct mlx5_eswitch *esw,
 					      struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
 	u32 fw_max_bw_share = MLX5_CAP_QOS(esw->dev, max_tsar_bw_share);
 	struct mlx5_esw_sched_node *node;
+	struct list_head *nodes;
 	u32 max_guarantee = 0;
 
 	/* Find max min_rate across all nodes.
 	 * This will correspond to fw_max_bw_share in the final bw_share calculation.
 	 */
+	nodes = parent ? &parent->children : mlx5_shd_get_qos_nodes(esw->dev);
 	list_for_each_entry(node, nodes, entry) {
 		if (node->esw == esw && node->ix != esw->qos.root_tsar_ix &&
 		    node->min_rate > max_guarantee)
@@ -372,10 +330,11 @@ static void esw_qos_normalize_min_rate(struct mlx5_eswitch *esw,
 				       struct mlx5_esw_sched_node *parent,
 				       struct netlink_ext_ack *extack)
 {
-	struct list_head *nodes = parent ? &parent->children : &esw->qos.domain->nodes;
 	u32 divider = esw_qos_calculate_min_rate_divider(esw, parent);
 	struct mlx5_esw_sched_node *node;
+	struct list_head *nodes;
 
+	nodes = parent ? &parent->children : mlx5_shd_get_qos_nodes(esw->dev);
 	list_for_each_entry(node, nodes, entry) {
 		if (node->esw != esw || node->ix == esw->qos.root_tsar_ix)
 			continue;
@@ -715,7 +674,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
-	list_add_tail(&node->entry, &esw->qos.domain->nodes);
+	list_add_tail(&node->entry, mlx5_shd_get_qos_nodes(esw->dev));
 	esw_qos_normalize_min_rate(esw, NULL, extack);
 	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
@@ -1108,7 +1067,8 @@ static int mlx5_esw_qos_vport_enable(struct mlx5_vport *vport, enum sched_node_t
 		return -ENOMEM;
 	}
 	if (!parent)
-		list_add_tail(&sched_node->entry, &esw->qos.domain->nodes);
+		list_add_tail(&sched_node->entry,
+			      mlx5_shd_get_qos_nodes(esw->dev));
 
 	sched_node->max_rate = max_rate;
 	sched_node->min_rate = min_rate;
@@ -1143,7 +1103,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 	struct mlx5_esw_sched_node *parent;
 
 	lockdep_assert_held(&esw->state_lock);
-	esw_qos_lock(esw);
+	mlx5_shd_lock(esw->dev);
 	if (!vport->qos.sched_node)
 		goto unlock;
 
@@ -1152,7 +1112,7 @@ void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport)
 
 	mlx5_esw_qos_vport_disable_locked(vport);
 unlock:
-	esw_qos_unlock(esw);
+	mlx5_shd_unlock(esw->dev);
 }
 
 static int mlx5_esw_qos_set_vport_max_rate(struct mlx5_vport *vport, u32 max_rate,
@@ -1191,26 +1151,25 @@ int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *vport, u32 max_rate, u32 min_
 	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	int err;
 
-	esw_qos_lock(esw);
+	mlx5_shd_lock(esw->dev);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, min_rate, NULL);
 	if (!err)
 		err = mlx5_esw_qos_set_vport_max_rate(vport, max_rate, NULL);
-	esw_qos_unlock(esw);
+	mlx5_shd_unlock(esw->dev);
 	return err;
 }
 
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate)
 {
-	struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
 	bool enabled;
 
-	esw_qos_lock(esw);
+	mlx5_shd_lock(vport->dev);
 	enabled = !!vport->qos.sched_node;
 	if (enabled) {
 		*max_rate = vport->qos.sched_node->max_rate;
 		*min_rate = vport->qos.sched_node->min_rate;
 	}
-	esw_qos_unlock(esw);
+	mlx5_shd_unlock(vport->dev);
 	return enabled;
 }
 
@@ -1576,9 +1535,9 @@ int mlx5_esw_qos_modify_vport_rate(struct mlx5_eswitch *esw, u16 vport_num, u32
 			return err;
 	}
 
-	esw_qos_lock(esw);
+	mlx5_shd_lock(esw->dev);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, rate_mbps, NULL);
-	esw_qos_unlock(esw);
+	mlx5_shd_unlock(esw->dev);
 
 	return err;
 }
@@ -1667,44 +1626,24 @@ static void esw_vport_qos_prune_empty(struct mlx5_vport *vport)
 	mlx5_esw_qos_vport_disable_locked(vport);
 }
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		return 0;  /* Nothing to change. */
-
-	return esw_qos_domain_init(esw);
-}
-
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw)
-{
-	if (esw->qos.domain)
-		esw_qos_domain_release(esw);
-}
-
 /* Eswitch devlink rate API */
 
 int mlx5_esw_devlink_rate_leaf_tx_share_set(struct devlink_rate *rate_leaf, void *priv,
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_share", &tx_share, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_min_rate(vport, tx_share, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
 	return err;
 }
 
@@ -1712,24 +1651,18 @@ int mlx5_esw_devlink_rate_leaf_tx_max_set(struct devlink_rate *rate_leaf, void *
 					  u64 tx_max, struct netlink_ext_ack *extack)
 {
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	int err;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	err = esw_qos_devlink_rate_to_mbps(vport->dev, "tx_max", &tx_max, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	err = mlx5_esw_qos_set_vport_max_rate(vport, tx_max, extack);
-	if (err)
-		goto out;
-	esw_vport_qos_prune_empty(vport);
-out:
-	esw_qos_unlock(esw);
+	if (!err)
+		esw_vport_qos_prune_empty(vport);
 	return err;
 }
 
@@ -1740,34 +1673,30 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 {
 	struct mlx5_esw_sched_node *vport_node;
 	struct mlx5_vport *vport = priv;
-	struct mlx5_eswitch *esw;
 	bool disable;
 	int err = 0;
 
-	esw = vport->dev->priv.eswitch;
-	if (!mlx5_esw_allowed(esw))
+	if (!mlx5_esw_allowed(vport->dev->priv.eswitch))
 		return -EPERM;
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
 
 	if (!esw_qos_vport_validate_unsupported_tc_bw(vport, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "E-Switch traffic classes number is not supported");
-		err = -EOPNOTSUPP;
-		goto unlock;
+		return -EOPNOTSUPP;
 	}
 
 	vport_node = vport->qos.sched_node;
 	if (disable && !vport_node)
-		goto unlock;
+		return 0;
 
 	if (disable) {
 		if (vport_node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
 			err = esw_qos_vport_update(vport, SCHED_NODE_TYPE_VPORT,
 						   vport_node->parent, extack);
 		esw_vport_qos_prune_empty(vport);
-		goto unlock;
+		return err;
 	}
 
 	if (!vport_node) {
@@ -1782,8 +1711,6 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf,
 	}
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(vport_node, tc_bw, extack);
-unlock:
-	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1793,28 +1720,22 @@ int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node,
 					 struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node = priv;
-	struct mlx5_eswitch *esw = node->esw;
 	bool disable;
 	int err;
 
-	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+	if (!esw_qos_validate_unsupported_tc_bw(node->esw, tc_bw)) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "E-Switch traffic classes number is not supported");
 		return -EOPNOTSUPP;
 	}
 
 	disable = esw_qos_tc_bw_disabled(tc_bw);
-	esw_qos_lock(esw);
-	if (disable) {
-		err = esw_qos_node_disable_tc_arbitration(node, extack);
-		goto unlock;
-	}
+	if (disable)
+		return esw_qos_node_disable_tc_arbitration(node, extack);
 
 	err = esw_qos_node_enable_tc_arbitration(node, extack);
 	if (!err)
 		esw_qos_set_tc_arbiter_bw_shares(node, tc_bw, extack);
-unlock:
-	esw_qos_unlock(esw);
 	return err;
 }
 
@@ -1822,17 +1743,14 @@ int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void
 					    u64 tx_share, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *node = priv;
-	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
-	err = esw_qos_devlink_rate_to_mbps(esw->dev, "tx_share", &tx_share, extack);
+	err = esw_qos_devlink_rate_to_mbps(node->esw->dev, "tx_share",
+					   &tx_share, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
-	err = esw_qos_set_node_min_rate(node, tx_share, extack);
-	esw_qos_unlock(esw);
-	return err;
+	return esw_qos_set_node_min_rate(node, tx_share, extack);
 }
 
 int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *priv,
@@ -1846,10 +1764,7 @@ int mlx5_esw_devlink_rate_node_tx_max_set(struct devlink_rate *rate_node, void *
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
-	err = esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
-	esw_qos_unlock(esw);
-	return err;
+	return esw_qos_sched_elem_config(node, tx_max, node->bw_share, extack);
 }
 
 int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
@@ -1857,30 +1772,23 @@ int mlx5_esw_devlink_rate_node_new(struct devlink_rate *rate_node, void **priv,
 {
 	struct mlx5_esw_sched_node *node;
 	struct mlx5_eswitch *esw;
-	int err = 0;
 
 	esw = mlx5_devlink_eswitch_get(rate_node->devlink);
 	if (IS_ERR(esw))
 		return PTR_ERR(esw);
 
-	esw_qos_lock(esw);
 	if (esw->mode != MLX5_ESWITCH_OFFLOADS) {
 		NL_SET_ERR_MSG_MOD(extack,
 				   "Rate node creation supported only in switchdev mode");
-		err = -EOPNOTSUPP;
-		goto unlock;
+		return -EOPNOTSUPP;
 	}
 
 	node = esw_qos_create_vports_sched_node(esw, extack);
-	if (IS_ERR(node)) {
-		err = PTR_ERR(node);
-		goto unlock;
-	}
+	if (IS_ERR(node))
+		return PTR_ERR(node);
 
 	*priv = node;
-unlock:
-	esw_qos_unlock(esw);
-	return err;
+	return 0;
 }
 
 int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
@@ -1889,10 +1797,9 @@ int mlx5_esw_devlink_rate_node_del(struct devlink_rate *rate_node, void *priv,
 	struct mlx5_esw_sched_node *node = priv;
 	struct mlx5_eswitch *esw = node->esw;
 
-	esw_qos_lock(esw);
 	__esw_qos_destroy_node(node, extack);
 	esw_qos_put(esw);
-	esw_qos_unlock(esw);
+
 	return 0;
 }
 
@@ -1909,7 +1816,6 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 		return -EOPNOTSUPP;
 	}
 
-	esw_qos_lock(esw);
 	if (!vport->qos.sched_node && parent) {
 		enum sched_node_type type;
 
@@ -1920,13 +1826,15 @@ mlx5_esw_qos_vport_update_parent(struct mlx5_vport *vport,
 	} else if (vport->qos.sched_node) {
 		err = esw_qos_vport_update_parent(vport, parent, extack);
 	}
-	esw_qos_unlock(esw);
+
 	return err;
 }
 
 void mlx5_esw_qos_vport_clear_parent(struct mlx5_vport *vport)
 {
+	mlx5_shd_lock(vport->dev);
 	mlx5_esw_qos_vport_update_parent(vport, NULL, NULL);
+	mlx5_shd_unlock(vport->dev);
 }
 
 int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
@@ -1939,13 +1847,8 @@ int mlx5_esw_devlink_rate_leaf_parent_set(struct devlink_rate *devlink_rate,
 	int err;
 
 	err = mlx5_esw_qos_vport_update_parent(vport, node, extack);
-	if (!err) {
-		struct mlx5_eswitch *esw = vport->dev->priv.eswitch;
-
-		esw_qos_lock(esw);
+	if (!err)
 		esw_vport_qos_prune_empty(vport);
-		esw_qos_unlock(esw);
-	}
 
 	return err;
 }
@@ -2071,14 +1974,12 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 					   struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *curr_parent;
-	struct mlx5_eswitch *esw = node->esw;
 	int err;
 
 	err = mlx5_esw_qos_node_validate_set_parent(node, parent, extack);
 	if (err)
 		return err;
 
-	esw_qos_lock(esw);
 	curr_parent = node->parent;
 	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR) {
 		err = esw_qos_tc_arbiter_node_update_parent(node, parent,
@@ -2088,15 +1989,11 @@ static int mlx5_esw_qos_node_update_parent(struct mlx5_esw_sched_node *node,
 	}
 
 	if (err)
-		goto out;
-
-	esw_qos_normalize_min_rate(esw, curr_parent, extack);
-	esw_qos_normalize_min_rate(esw, parent, extack);
-
-out:
-	esw_qos_unlock(esw);
+		return err;
 
-	return err;
+	esw_qos_normalize_min_rate(node->esw, curr_parent, extack);
+	esw_qos_normalize_min_rate(node->esw, parent, extack);
+	return 0;
 }
 
 int mlx5_esw_devlink_rate_node_parent_set(struct devlink_rate *devlink_rate,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
index 0a50982b0e27..f275e850d2c9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.h
@@ -6,9 +6,6 @@
 
 #ifdef CONFIG_MLX5_ESWITCH
 
-int mlx5_esw_qos_init(struct mlx5_eswitch *esw);
-void mlx5_esw_qos_cleanup(struct mlx5_eswitch *esw);
-
 int mlx5_esw_qos_set_vport_rate(struct mlx5_vport *evport, u32 max_rate, u32 min_rate);
 bool mlx5_esw_qos_get_vport_rate(struct mlx5_vport *vport, u32 *max_rate, u32 *min_rate);
 void mlx5_esw_qos_vport_disable(struct mlx5_vport *vport);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 3adf2b1cd26a..00658b44d429 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -49,6 +49,7 @@
 #include "ecpf.h"
 #include "en/mod_hdr.h"
 #include "en_accel/ipsec.h"
+#include "sh_devlink.h"
 
 enum {
 	MLX5_ACTION_NONE = 0,
@@ -1618,10 +1619,6 @@ int mlx5_eswitch_enable_locked(struct mlx5_eswitch *esw, int num_vfs)
 	MLX5_NB_INIT(&esw->nb, eswitch_vport_event, NIC_VPORT_CHANGE);
 	mlx5_eq_notifier_register(esw->dev, &esw->nb);
 
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto err_esw_init;
-
 	if (esw->mode == MLX5_ESWITCH_LEGACY) {
 		err = esw_legacy_enable(esw);
 	} else {
@@ -2027,9 +2024,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		goto reps_err;
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto reps_err;
 
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
@@ -2079,7 +2073,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
 	esw_info(esw->dev, "cleanup\n");
 
-	mlx5_esw_qos_cleanup(esw);
 	destroy_workqueue(esw->work_queue);
 	WARN_ON(refcount_read(&esw->qos.refcnt));
 	mutex_destroy(&esw->state_lock);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 20cf9dd542a1..d145591b3434 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -224,8 +224,9 @@ struct mlx5_vport {
 
 	struct mlx5_vport_info  info;
 
-	/* Protected with the E-Switch qos domain lock. The Vport QoS can
-	 * either be disabled (sched_node is NULL) or in one of three states:
+	/* Protected by mlx5_shd_lock().
+	 * The Vport QoS can either be disabled (sched_node is NULL) or in one
+	 * of three states:
 	 * 1. Regular QoS (sched_node is a vport node).
 	 * 2. TC QoS enabled on the vport (sched_node is a TC arbiter).
 	 * 3. TC QoS enabled on the vport's parent node
@@ -356,7 +357,6 @@ enum {
 };
 
 struct dentry;
-struct mlx5_qos_domain;
 
 struct mlx5_eswitch {
 	struct mlx5_core_dev    *dev;
@@ -383,12 +383,13 @@ struct mlx5_eswitch {
 	struct rw_semaphore mode_lock;
 	atomic64_t user_count;
 
-	/* Protected with the E-Switch qos domain lock. */
+	/* The QoS tree is stored in mlx5_shd.
+	 * QoS changes are serialized with mlx5_shd_lock().
+	 */
 	struct {
 		/* Initially 0, meaning no QoS users and QoS is disabled. */
 		refcount_t refcnt;
 		u32 root_tsar_ix;
-		struct mlx5_qos_domain *domain;
 	} qos;
 
 	struct mlx5_esw_bridge_offloads *br_offloads;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
index e39a5e20e102..ef073cc53f8e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
@@ -22,6 +22,8 @@ struct mlx5_shd {
 	struct list_head dev_list;
 	/* Related faux device */
 	struct faux_device *faux_dev;
+	/* List of esw qos nodes. */
+	struct list_head qos_nodes;
 };
 
 static const struct devlink_ops mlx5_shd_ops = {
@@ -76,6 +78,7 @@ static struct mlx5_shd *mlx5_shd_create(const char *sn)
 	shd->sn = sn;
 	INIT_LIST_HEAD(&shd->dev_list);
 	shd->faux_dev = faux_dev;
+	INIT_LIST_HEAD(&shd->qos_nodes);
 	return shd;
 }
 
@@ -164,3 +167,17 @@ void mlx5_shd_unlock(struct mlx5_core_dev *dev)
 		return;
 	devl_unlock(priv_to_devlink(dev->shd));
 }
+
+void mlx5_shd_assert_locked(struct mlx5_core_dev *dev)
+{
+	if (dev->shd)
+		devl_assert_locked(priv_to_devlink(dev->shd));
+}
+
+struct list_head *mlx5_shd_get_qos_nodes(struct mlx5_core_dev *dev)
+{
+	if (!dev->shd)
+		return NULL;
+	mlx5_shd_assert_locked(dev);
+	return &dev->shd->qos_nodes;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
index 54ce0389cfea..56ead7e11756 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.h
@@ -8,6 +8,9 @@ int mlx5_shd_init(struct mlx5_core_dev *dev);
 void mlx5_shd_uninit(struct mlx5_core_dev *dev);
 void mlx5_shd_lock(struct mlx5_core_dev *dev);
 void mlx5_shd_unlock(struct mlx5_core_dev *dev);
+void mlx5_shd_assert_locked(struct mlx5_core_dev *dev);
 void mlx5_shd_nested_set(struct mlx5_core_dev *dev);
 
+struct list_head *mlx5_shd_get_qos_nodes(struct mlx5_core_dev *dev);
+
 #endif /* __MLX5_SH_DEVLINK_H__ */
-- 
2.31.1


