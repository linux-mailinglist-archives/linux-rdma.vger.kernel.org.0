Return-Path: <linux-rdma+bounces-14696-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFDFC7DD68
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 08:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DEE4D4E4DD4
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 07:26:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C9E82D6E7C;
	Sun, 23 Nov 2025 07:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fC8UljVG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011000.outbound.protection.outlook.com [40.93.194.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93704268C42;
	Sun, 23 Nov 2025 07:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763882681; cv=fail; b=el50xRwe5+grZVEiBjE9VURiYWsk1EfS4wNGuc+Aj+FnOK2lM/ARlK1ScpM65X75mWL5vvQOY6sUbfT7H5w8kWqAebfY2zr8Ew5yErB+n7Tpnt3K8vTYD6rFuhSl/72xD9+VYtRrAMZzgeJCbXaV5sDxKggjhiaYXT143vGe2Bg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763882681; c=relaxed/simple;
	bh=laqhXYcSE5aLkYc7pF2bt4DbzfCrooj7Lr3PO4a3cOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pomM3yJjERWEdsUkSrv/lQp/9SB6S+6+WBvOg8DO9KD1HEbX9OC3b5LaYN9hifIt7jjYVJmDJ9mbLits3lQDQI8MnhyzlXlTXqp+7m5Ujs6++QKOBkc5PiecSaybGlTXRxFuKy0P/LshO+NEoOPy56vycLXqFy8CJ8CoMjv4JLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fC8UljVG; arc=fail smtp.client-ip=40.93.194.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bmid4jejYOaCLyXJFuGNa3HZV7L4bu0fF7STKDCWJtpKPrktW+R0KAuCIEAtD7QwdNaC4YkKvZpUzkEQ6Gu2OIlAjJrwbJpW2R8KcH4rcCwvg/jWAIqsJkl3dkJLXX64mF3utuWeXbmOqibGxnJnccO7E1eG2p+X4Te9mXI3Wd0MZZlKDUo/t7lsZAsBrmROk2zwf86pmaLam47ORIMu8As1Mv5/njNeWxyZF/e2kh86AkIvpE83ROzyiRRlz2ADjsFT4GTI3QVrdSLw5LWa2KqbXPm4YHu9Hi6IX0kozECoi5YRJIPH51cj5kZJ02d6bb58Wvd17i9xg3/Bif4dsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0oMWPq9284fuT06yzYfZBkh46RG0wxVIVqeQ4t6rLNM=;
 b=qP5mYbvmtzSNglk+4suol1GS6nialE9mxxKgu6QWdwMDa0UrEa8tNizvZkO0qjWSxLyfyRQdRVtWNumnsERg3Q419eYgEbwj+Y2dt96p9cZsZ8UVMUdrw1xcVqnHPVaxZiDNagfmCX08cc/idEg0YPwMF+ZxyMRmVDg9Es3ldbYt4UVLqkWkdrVta+AMOyECD9FV3VkJeu0ZilrhviSxxf+QwgQgzczTolDQDP73piI+1wmQqV67tn05w1vExB5eYmjd6J9W3opzTEE1cQ1J4zN3noN55mGxSr22KOxZEulVHsIHKyPQvvw6XBFsTQKJYJM61+Rno+HknItjzLxWeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0oMWPq9284fuT06yzYfZBkh46RG0wxVIVqeQ4t6rLNM=;
 b=fC8UljVG6olh8cXRHjMsvdp9KA//9e11JcjR36gyw2W+ezFFXQywsCbBPwUS6p3gkgV271uHfMXngP1Abje1ZGCozMbPmt3doYDJ6S6ih5gEhS6qC5LxYPgYiKvXvoPeUbiuHb6tITAOqXRl1ZfqDx72s6TSXyQx1u//oAwTOu2ezqpMV4DIdwRjER2sfGm2HehY0hKRMFw8w2QA+c2vX7gzhJF1Nn4twwTwp8781U+W2UG3HsxB5d0dHaqKn7oFR3zSIosVJZFl6R+2aqQ7cTokZPZvk8Nq7dbE1WRmWVsp6U1XjKJcxelohr5/2MszsUjtCg0iberAyQ2Ts91Jog==
Received: from SN1PR12CA0081.namprd12.prod.outlook.com (2603:10b6:802:21::16)
 by DS4PR12MB9659.namprd12.prod.outlook.com (2603:10b6:8:27f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sun, 23 Nov
 2025 07:24:29 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:802:21:cafe::ca) by SN1PR12CA0081.outlook.office365.com
 (2603:10b6:802:21::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.16 via Frontend Transport; Sun,
 23 Nov 2025 07:24:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Sun, 23 Nov 2025 07:24:29 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:20 -0800
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sat, 22 Nov
 2025 23:24:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Sat, 22
 Nov 2025 23:24:14 -0800
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
Subject: [PATCH net-next V2 11/14] net/mlx5: Store QoS sched nodes in the sh_devlink
Date: Sun, 23 Nov 2025 09:22:57 +0200
Message-ID: <1763882580-1295213-12-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|DS4PR12MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 43a4de11-4a46-483d-d894-08de2a6156ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?h9zBO40R/TRYwyQFrmuyBNb2BXTCd6HvnvKfqoqs8EYf30Xcfo+riYFnIVQH?=
 =?us-ascii?Q?xaersDuR4Z4298FZHcyYMgumoZvlL2mEtUidBDV48F/lhSnTs6RDzqXYfx9M?=
 =?us-ascii?Q?GSDSh+CXedqCcW/0/ac9LExJ7+5yHlg1PO+lJnLVFuW+jbqy+AcqC7X1UcTt?=
 =?us-ascii?Q?z0hIFX6QmTTUl27b9Uzfd/96dNGGcoBBtUitDT+z/d/i2fi/aX4+1nph9cwh?=
 =?us-ascii?Q?XIe07PDGdSbFFqcfM7EWB7pM0b8L9MRuaFd61oo8QpJpJ5/SHDk9jIopx2bG?=
 =?us-ascii?Q?fD6E3Hm7laHPtE3q/odsgpUdlZo6d9pkcXW2BRlJPxDhbydviZUUHgA8MgtH?=
 =?us-ascii?Q?6D2gofvZJunJ3N+s9TIhj0V/6JtZp5QRM66L1fI/AQBzaHaEZ0NIrHob2/qy?=
 =?us-ascii?Q?xEqTGbAScnoN+mFhwPyt2oiQTMVbIKqwTAH2x4ZYttGv6oGsXfOELxyykkrW?=
 =?us-ascii?Q?Lo/BqJMp7oYcg71KF7Ob22YXfqORWzlSWctqfPLzAfEeMxyeKhbszDhQCMkd?=
 =?us-ascii?Q?3Jz6egH5Dhh85oXD72H2Wljdm6tpynmN8hyDQbYA/11rpasdNs/bo/RjsXy4?=
 =?us-ascii?Q?Na8hKpxs5T51p+bi3reDrK/gUsLiSzNpVoDVo1VOuObmO6RFkU8hZJs2yaHk?=
 =?us-ascii?Q?hp8OhwbpdYyG7KSy76nqNU1Rkfp+jXag1rGzZt2qZ/2zSmXBxBpa6ZwhyaLG?=
 =?us-ascii?Q?KTHrrDIypf7PXdHQXBhtzz/dFm0FNWK/yF9W6WcuQED+CbgOyXqpFvJTjeFL?=
 =?us-ascii?Q?oPrLtRU2tpULibWm+5YreuO5vwEzJHgQ0BvUNEAnMgykCmj3ff0lBifxgAvE?=
 =?us-ascii?Q?+N0IjipINO6lMzc0r4fCQOsVT7d/JjWldQB2Tx/NczQhk8cCWVrIMfWSRH65?=
 =?us-ascii?Q?ha5ikRIqNv+8H8XRSQUPkzAMJH2NM5MLUp92tvooIgC1UhMswTQHNfyRUN/3?=
 =?us-ascii?Q?2ck6SLD8TO607A7j1lljIbk1hLVjVzqGCH9xe+J996OLrxusWu/5FJ6L53VT?=
 =?us-ascii?Q?lCRNiUXwLPmqC+dUcDcajSskOqk5WBiUdV2KlTylYG3ngr5Eyiap6F2hLhbw?=
 =?us-ascii?Q?qPdQnJF5QVvI5Hzp/SL7HyGdFPX46t32W/BrUQafNZeWcWpm1edikmsO30l7?=
 =?us-ascii?Q?EI8TDzr4ULU3VsEDVme9iMLzqGJY0QUm2dMj5tqRQOm/emHhOSCFKeFMMXxv?=
 =?us-ascii?Q?i+PDd6AhGMyjzPhZD4CoEBn3zFIp+1HVaV5mT273iXez0cRSTOgnMswNOGUO?=
 =?us-ascii?Q?pIrZ8/Dqq3P2qo6ftsiDxQm9i7chqCOny0doYGNlsjPL+79uAS2WKw+UQJcY?=
 =?us-ascii?Q?R7L4xMJrkNrep/Tlh0DBoz/2fggfKf4FNZDhy0rtjB1ZM2GbDTaJmTeaWB6T?=
 =?us-ascii?Q?r0gI4JE6D8TUJ1h9On5gQeJLbbAGJaBBFJ9CEu3gekvOC6chrfBrlwSm/e/R?=
 =?us-ascii?Q?iLpkvnDTPAsL8nZA/9XccM3jtwfMJWBcA0wCsu6qJBiQ93r7uqwgD8j4oBlW?=
 =?us-ascii?Q?LNquwnpeSD38rtkudHoh9GmYxmk3X79ov3bmxt7RpVz3uBrGD5fsAEGJ5iFp?=
 =?us-ascii?Q?+fIa07QJfiBvMxjjYFNrriUqB1xE318z8DypMxAO?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2025 07:24:29.0577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43a4de11-4a46-483d-d894-08de2a6156ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9659

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
index 4b7a1ce7f406..51eacc286cbb 100644
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
@@ -2028,9 +2025,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		goto reps_err;
 
 	esw->mode = MLX5_ESWITCH_LEGACY;
-	err = mlx5_esw_qos_init(esw);
-	if (err)
-		goto reps_err;
 
 	mutex_init(&esw->offloads.encap_tbl_lock);
 	hash_init(esw->offloads.encap_tbl);
@@ -2080,7 +2074,6 @@ void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 
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


