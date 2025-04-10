Return-Path: <linux-rdma+bounces-9354-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4E9A84CDB
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F99C4E1DC3
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:21:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B70B2980CA;
	Thu, 10 Apr 2025 19:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="p9+YEge3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F5B290094;
	Thu, 10 Apr 2025 19:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312764; cv=fail; b=qfmFhOXsRmggDKnC+4yKKS+wuN2/REOkxOx5I+C3e5HUjqwMuXA0uJ3F5Tfh4OSvWmUu5R8PLIHm+HH+UlnqjoY2winxz0UXlEhuVlLcd5YLL+BTtCqc/bCrWkrK2j5QMqYqko/5LV7m6ITMFd/jB9ynRjw9EwxqKHo9rktn0cY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312764; c=relaxed/simple;
	bh=l1reJQsVLMPGZF8sjGpXHdGwE+0tau0YqL/lF8A4B4U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WPcUIqSpRS7gs/7OFKTTCMmirZfIW/GYzVnuDDDIt297uh4sFl+2HMLKmHAIDW4PS6tW0vnqW+xflH3lK0IosiIgkzszE8tsuk8TwNS4GxIk4gJzRcyfJlNbUsPn500TccCaP8JjI4eMMo2N+yC3zs0Av9ae91zyNlLS2jNzpDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=p9+YEge3; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPoobOFDYF1kIJGZabCWZOG3HFlN3v0pMV2a0ycqaEd65WV4Fweg4PDC7BW3Wds6tJX2scns0Z1xhBmgsrkIrCx5uFZOQO3YEIoqgChZNrUAWyXgBBdHD08fuh0iENldak22+376vQNYJaPTd2wrKQcNCL9usmx9AdAu7syX4nrK9F/mYFMPb5Bh4tB+CZLyvg9wg/0yPww1tAb96ZXxqdCsqWcg3r6gllZ16chyVsm9qHYFITFBJTNtUgqVsaaoj4O6EWlF1eDIwpCbV9SseQnqP79siS28bg04MLGtSET9cKePGMxI1fbXcp17aLVjcyOZosaW5DAOEvVllnNaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MnoCCKqs2NGxtmVHjMnOX/Jelxd0TwKh5zwyobSPFXs=;
 b=qtUae9II1EMVfRJbJqbX2fOeUPZIXgKl+7YtcD9ExKkVbVRPFWReS+IkSKsJYqRieTRZ0MiQdXRUjshpUFoPOY5MZnnoNiD5aVUX+fozvSYao7zdve8LS8PKMTuPIDh52XEMpqptcRY1FA5RH8XlJz5MFfi6+Btd7en/wJ+3IWRWFDVrHZ0dBnFtpR26W1kkmr3Pm0qK0zFQlHWdn6GwhF7Iv9le1eCfoOFiX+r1cQiSRKda9PDC58yqh+2kv3MskZ349k63zK7KcGQ8IhoVly9M/4J3bdnQnxO6Op7raDURgJuPEWv7T0DdGr/1dl/xv6EHUUXspTnL9L70vjoB0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MnoCCKqs2NGxtmVHjMnOX/Jelxd0TwKh5zwyobSPFXs=;
 b=p9+YEge3gqgTM6yhdsL9ZBNHnPW+GPkKLlUalwlaa5+7TKOfwPLCSIOrQKebUrrYr8V5DikmtymHqEaA4NhjfYVTYZZ8+cnWdnzbLCoeD8HY3TUOL5ttJxI3h9pYLM7n7Gg9zx0FOQNtd9Aw8xuTUKaWVTg6xdVhWk1mXDcuUaSmmnzHys6mmfruRnED+bcJvtLlRyTzvvxv4pksU4oh5OrDRbu+3YaAOqBVUhiPrxj7DaEOhIX4n339i3uatAPmvRTHIVD4lGu3q8c0zwlPZ56ZF7gQ7+z96FTxKXojOUf4KDQA2D+f6Z/S+BwvS1wSL4PTg3l82cTytWFGMfX3qw==
Received: from PH7PR17CA0052.namprd17.prod.outlook.com (2603:10b6:510:325::19)
 by DM4PR12MB8499.namprd12.prod.outlook.com (2603:10b6:8:181::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 19:19:16 +0000
Received: from SN1PEPF0002BA4E.namprd03.prod.outlook.com
 (2603:10b6:510:325:cafe::9e) by PH7PR17CA0052.outlook.office365.com
 (2603:10b6:510:325::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Thu,
 10 Apr 2025 19:19:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF0002BA4E.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:19:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:19:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Michal Kubiak
	<michal.kubiak@intel.com>
Subject: [PATCH net-next V2 11/12] net/mlx5: HWS, Free unused action STE tables
Date: Thu, 10 Apr 2025 22:17:41 +0300
Message-ID: <1744312662-356571-12-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
References: <1744312662-356571-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4E:EE_|DM4PR12MB8499:EE_
X-MS-Office365-Filtering-Correlation-Id: f6b3c8e9-a433-4fe1-45ed-08dd786495c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lQRjU4crPnKg6HsUpRWGYZ00Qy3XpwbIpZyPJP7R4AvsZj739PDw8E1WLOaX?=
 =?us-ascii?Q?GoMf3BE5hab10FKEcjdo4VRws2aB8lljSBm5fDJpRNK12XPiRA5bAoLAD4Nf?=
 =?us-ascii?Q?pLmtCBVsCecW47H8iX93E9Lu+Nc3c/Xue9svXaXDiEmd3v8+bxaa6vf88Pk8?=
 =?us-ascii?Q?9YJrU64Yx1/nRCBqQ69kJ7CWL9GHnznMuq18c4ohWQk7knX5dAnoX8rDwF0b?=
 =?us-ascii?Q?flZ6pAuDzEBBLYlAjePW6bPv7zYV/SAg2RW+WqpvXZwaC+V24IJpqKq+pc+8?=
 =?us-ascii?Q?VAq5WOzDX+WW6gEhiHJKGD9ahy/TmIKF8CKqI+XjBSMekTkGerjtxNLUrV/G?=
 =?us-ascii?Q?1oPHo1qiL5qOCeEbfYwiUaKzSpgYpGNhxzIezrEaCF+NGBkQLLJRNkmA1E9l?=
 =?us-ascii?Q?HzdDolw8j09rvOaE2uW16BLiEbTgsNnFr8MSbdINqpxiK06Di6b4v/w4GD0u?=
 =?us-ascii?Q?b9T+s875o2wmL1L+pgquG0eWhVJwBW/pzjzrgHSSW1tcjNgL5mOnHNd6B3ZX?=
 =?us-ascii?Q?ek4WomD922lYluR52ewod3V1kuKZMBowKEZafOPt2pXwFAPt2t6J4ZSd4Mnk?=
 =?us-ascii?Q?q5obEumAUQLu2GDW/fEfpBUrf+9GHT//2u8BoWOwTYtnD3SrjC/LPMZ2nofi?=
 =?us-ascii?Q?w0RzyxJcL+LLrT19J98Tcth4RTG8z+DH98MRmtdg3hTdslcNNliYtQNb4yAh?=
 =?us-ascii?Q?UZTyt/6/YDlTIXddd0VIf9jtmN7WcV6+B/MC8/za+n5Pt5Qvw1AUQwKenNhX?=
 =?us-ascii?Q?ug3d6Xb/Z7+lP0nF+AFj1UxJ24Asa4B9pvZEhUVIMto9l7ECVPppOBH0O+Rm?=
 =?us-ascii?Q?40qezdJ/BntE+OKXB7LOkoSiKMBD/dQTCSJKQUrVCPTS4aZizlVXJGvlQSL6?=
 =?us-ascii?Q?9kDW9ZS7xYLVi3bWQ48k5pYJy0//GvUa2UIRXPmqVlWRSnFprl0W56EWPLff?=
 =?us-ascii?Q?eFFCoV35Mq/RmepYRQZunlYwQTy8/w3eOlLZ8ArWC6BFnNlL6/M9pf/xNqkT?=
 =?us-ascii?Q?KUInpDbaKwTj3SHNy4B7wlNrg4nNOG4e4zSiUBT5003D8UJbOrgf5EBJzDDX?=
 =?us-ascii?Q?PRbrbRSdB+h9nsPzV7c+Xf6v+SZfnS2UhGAtRc7Tr3esA6i4NdNp5pPEudV8?=
 =?us-ascii?Q?hOwQwi8FxDpnxFZ35bpiBTTAI8pV1QA/2zQzbvdR8huSj0zSR4fK06Jya+AW?=
 =?us-ascii?Q?jY6pUjkydaXCCVL85V2ij+exzTZr/JQOozr/5gX5fXKlxLG536hNTHaHugSw?=
 =?us-ascii?Q?Ug5l/ZPEN7AUeYTGO6S/apjcuaTF07OHvTHS5BsLe6YqTn2zMgvrjNJ34SyJ?=
 =?us-ascii?Q?sQg9eiVmtyHbz8V5mji0cc6nvBNwM0JrfXvKx2u8cqGeEYCBWIdDu9VCUvCr?=
 =?us-ascii?Q?G0BCAo/MybU7PCYRwVnFmjomZoC1tPPzQehHnWqMfKDXzF7UW2sxaD4nsqwr?=
 =?us-ascii?Q?BTv2ogX9SstuOmSK91Dah0HLqVwkL0IgYmSYdExjF/EpaqY6TcyR/iCi9ywr?=
 =?us-ascii?Q?x0CD2F3Q92rO/F0=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:19:15.9606
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6b3c8e9-a433-4fe1-45ed-08dd786495c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8499

From: Vlad Dogaru <vdogaru@nvidia.com>

Periodically check for unused action STE tables and free their
associated resources. In order to do this safely, add a per-queue lock
to synchronize the garbage collect work with regular operations on
steering rules.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mlx5/core/steering/hws/action_ste_pool.c  | 88 ++++++++++++++++++-
 .../mlx5/core/steering/hws/action_ste_pool.h  | 11 +++
 .../mellanox/mlx5/core/steering/hws/context.h |  1 +
 3 files changed, 96 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
index cb6ad8411631..5766a9c82f96 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
@@ -159,6 +159,7 @@ hws_action_ste_table_alloc(struct mlx5hws_action_ste_pool_element *parent_elem)
 
 	action_tbl->parent_elem = parent_elem;
 	INIT_LIST_HEAD(&action_tbl->list_node);
+	action_tbl->last_used = jiffies;
 	list_add(&action_tbl->list_node, &parent_elem->available);
 	parent_elem->log_sz = log_sz;
 
@@ -236,6 +237,8 @@ static int hws_action_ste_pool_init(struct mlx5hws_context *ctx,
 	enum mlx5hws_pool_optimize opt;
 	int err;
 
+	mutex_init(&pool->lock);
+
 	/* Rules which are added for both RX and TX must use the same action STE
 	 * indices for both. If we were to use a single table, then RX-only and
 	 * TX-only rules would waste the unused entries. Thus, we use separate
@@ -247,6 +250,7 @@ static int hws_action_ste_pool_init(struct mlx5hws_context *ctx,
 						       opt);
 		if (err)
 			goto destroy_elems;
+		pool->elems[opt].parent_pool = pool;
 	}
 
 	return 0;
@@ -267,6 +271,58 @@ static void hws_action_ste_pool_destroy(struct mlx5hws_action_ste_pool *pool)
 		hws_action_ste_pool_element_destroy(&pool->elems[opt]);
 }
 
+static void hws_action_ste_pool_element_collect_stale(
+	struct mlx5hws_action_ste_pool_element *elem, struct list_head *cleanup)
+{
+	struct mlx5hws_action_ste_table *action_tbl, *p;
+	unsigned long expire_time, now;
+
+	expire_time = secs_to_jiffies(MLX5HWS_ACTION_STE_POOL_EXPIRE_SECONDS);
+	now = jiffies;
+
+	list_for_each_entry_safe(action_tbl, p, &elem->available, list_node) {
+		if (mlx5hws_pool_full(action_tbl->pool) &&
+		    time_before(action_tbl->last_used + expire_time, now))
+			list_move(&action_tbl->list_node, cleanup);
+	}
+}
+
+static void hws_action_ste_table_cleanup_list(struct list_head *cleanup)
+{
+	struct mlx5hws_action_ste_table *action_tbl, *p;
+
+	list_for_each_entry_safe(action_tbl, p, cleanup, list_node)
+		hws_action_ste_table_destroy(action_tbl);
+}
+
+static void hws_action_ste_pool_cleanup(struct work_struct *work)
+{
+	enum mlx5hws_pool_optimize opt;
+	struct mlx5hws_context *ctx;
+	LIST_HEAD(cleanup);
+	int i;
+
+	ctx = container_of(work, struct mlx5hws_context,
+			   action_ste_cleanup.work);
+
+	for (i = 0; i < ctx->queues; i++) {
+		struct mlx5hws_action_ste_pool *p = &ctx->action_ste_pool[i];
+
+		mutex_lock(&p->lock);
+		for (opt = MLX5HWS_POOL_OPTIMIZE_NONE;
+		     opt < MLX5HWS_POOL_OPTIMIZE_MAX; opt++)
+			hws_action_ste_pool_element_collect_stale(
+				&p->elems[opt], &cleanup);
+		mutex_unlock(&p->lock);
+	}
+
+	hws_action_ste_table_cleanup_list(&cleanup);
+
+	schedule_delayed_work(&ctx->action_ste_cleanup,
+			      secs_to_jiffies(
+				  MLX5HWS_ACTION_STE_POOL_CLEANUP_SECONDS));
+}
+
 int mlx5hws_action_ste_pool_init(struct mlx5hws_context *ctx)
 {
 	struct mlx5hws_action_ste_pool *pool;
@@ -285,6 +341,12 @@ int mlx5hws_action_ste_pool_init(struct mlx5hws_context *ctx)
 
 	ctx->action_ste_pool = pool;
 
+	INIT_DELAYED_WORK(&ctx->action_ste_cleanup,
+			  hws_action_ste_pool_cleanup);
+	schedule_delayed_work(
+		&ctx->action_ste_cleanup,
+		secs_to_jiffies(MLX5HWS_ACTION_STE_POOL_CLEANUP_SECONDS));
+
 	return 0;
 
 free_pool:
@@ -300,6 +362,8 @@ void mlx5hws_action_ste_pool_uninit(struct mlx5hws_context *ctx)
 	size_t queues = ctx->queues;
 	int i;
 
+	cancel_delayed_work_sync(&ctx->action_ste_cleanup);
+
 	for (i = 0; i < queues; i++)
 		hws_action_ste_pool_destroy(&ctx->action_ste_pool[i]);
 
@@ -330,6 +394,7 @@ hws_action_ste_table_chunk_alloc(struct mlx5hws_action_ste_table *action_tbl,
 		return err;
 
 	chunk->action_tbl = action_tbl;
+	action_tbl->last_used = jiffies;
 
 	return 0;
 }
@@ -346,6 +411,8 @@ int mlx5hws_action_ste_chunk_alloc(struct mlx5hws_action_ste_pool *pool,
 	if (skip_rx && skip_tx)
 		return -EINVAL;
 
+	mutex_lock(&pool->lock);
+
 	elem = hws_action_ste_choose_elem(pool, skip_rx, skip_tx);
 
 	mlx5hws_dbg(elem->ctx,
@@ -362,26 +429,39 @@ int mlx5hws_action_ste_chunk_alloc(struct mlx5hws_action_ste_pool *pool,
 
 	if (!found) {
 		action_tbl = hws_action_ste_table_alloc(elem);
-		if (IS_ERR(action_tbl))
-			return PTR_ERR(action_tbl);
+		if (IS_ERR(action_tbl)) {
+			err = PTR_ERR(action_tbl);
+			goto out;
+		}
 
 		err = hws_action_ste_table_chunk_alloc(action_tbl, chunk);
 		if (err)
-			return err;
+			goto out;
 	}
 
 	if (mlx5hws_pool_empty(action_tbl->pool))
 		list_move(&action_tbl->list_node, &elem->full);
 
-	return 0;
+	err = 0;
+
+out:
+	mutex_unlock(&pool->lock);
+
+	return err;
 }
 
 void mlx5hws_action_ste_chunk_free(struct mlx5hws_action_ste_chunk *chunk)
 {
+	struct mutex *lock = &chunk->action_tbl->parent_elem->parent_pool->lock;
+
 	mlx5hws_dbg(chunk->action_tbl->pool->ctx,
 		    "Freeing action STEs offset %d order %d\n",
 		    chunk->ste.offset, chunk->ste.order);
+
+	mutex_lock(lock);
 	mlx5hws_pool_chunk_free(chunk->action_tbl->pool, &chunk->ste);
+	chunk->action_tbl->last_used = jiffies;
 	list_move(&chunk->action_tbl->list_node,
 		  &chunk->action_tbl->parent_elem->available);
+	mutex_unlock(lock);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h
index 2de660a63223..a8ba97359e31 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.h
@@ -8,6 +8,9 @@
 #define MLX5HWS_ACTION_STE_TABLE_STEP_LOG_SZ 1
 #define MLX5HWS_ACTION_STE_TABLE_MAX_LOG_SZ 20
 
+#define MLX5HWS_ACTION_STE_POOL_CLEANUP_SECONDS 300
+#define MLX5HWS_ACTION_STE_POOL_EXPIRE_SECONDS 300
+
 struct mlx5hws_action_ste_pool_element;
 
 struct mlx5hws_action_ste_table {
@@ -19,10 +22,12 @@ struct mlx5hws_action_ste_table {
 	u32 rtc_0_id;
 	u32 rtc_1_id;
 	struct list_head list_node;
+	unsigned long last_used;
 };
 
 struct mlx5hws_action_ste_pool_element {
 	struct mlx5hws_context *ctx;
+	struct mlx5hws_action_ste_pool *parent_pool;
 	size_t log_sz;  /* Size of the largest table so far. */
 	enum mlx5hws_pool_optimize opt;
 	struct list_head available;
@@ -33,6 +38,12 @@ struct mlx5hws_action_ste_pool_element {
  * per queue.
  */
 struct mlx5hws_action_ste_pool {
+	/* Protects the entire pool. We have one pool per queue and only one
+	 * operation can be active per rule at a given time. Thus this lock
+	 * protects solely against concurrent garbage collection and we expect
+	 * very little contention.
+	 */
+	struct mutex lock;
 	struct mlx5hws_action_ste_pool_element elems[MLX5HWS_POOL_OPTIMIZE_MAX];
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
index e987e93bbc6e..3f8938c73dc0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/context.h
@@ -40,6 +40,7 @@ struct mlx5hws_context {
 	u32 pd_num;
 	struct mlx5hws_pool *stc_pool;
 	struct mlx5hws_action_ste_pool *action_ste_pool; /* One per queue */
+	struct delayed_work action_ste_cleanup;
 	struct mlx5hws_context_common_res common_res;
 	struct mlx5hws_pattern_cache *pattern_cache;
 	struct mlx5hws_definer_cache *definer_cache;
-- 
2.31.1


