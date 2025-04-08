Return-Path: <linux-rdma+bounces-9258-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24015A80D5F
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6521B4C79FF
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Apr 2025 14:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12E322686B;
	Tue,  8 Apr 2025 14:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DSfcNeW9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2070.outbound.protection.outlook.com [40.107.236.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4B1DDC2B;
	Tue,  8 Apr 2025 14:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744121004; cv=fail; b=oD41RZ8NMXmXsmxkGCzcyxwwQmvKVkeBQlUoAQHMPiOCDF1wn0NCcWX5H612/rW+1JNZu7/0DbHHFwxd1Qcqcf3/1Rnd/X56wC2vBcEEwlyGciJq8+JDYrykhn6qcKdPPTy8N3yZrAh2WeMvh9TeUT02Wg/Iu8zFqPZFiGSR34M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744121004; c=relaxed/simple;
	bh=RHM3qN3y9v8cDEfYdS0TVdQkP37l8V5AxQwTigvuBI8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6fvArqfzkBK+W8pM+U7J81CbdCVLcyXTzrcAJRtJhLDVSrMg+w0Q32NsOGd2fD8nO0UDSKioexCDo+o3aPwZm++HSZrQNuVFHbHHuIt/x+Z4BAR63v1Qom+jq9injGMfgzJizb/1tKMionoVehDzrof71Soxc+p3W2zqrpev4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DSfcNeW9; arc=fail smtp.client-ip=40.107.236.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LdStnpF85wMrJV6Uc3AIw+ang/gJRFJB5TM0HERKot+3i6RCesjKTp2C1rbpK9J6GMfuybjVEwrQfXFA2Hk6U7WJSFG5sKW126S4vQn4H+SgiQDyQXI8vPtLhNaXN7LazefCs4x4oMwBHEzZB5MJwZp+hEoF6GOMGxTRV+tT4shbqOw1t9ctxF3yz4Hp7RJnwmXVJMNlRmp1e3J9QEaFC7kmD6CmJOHrmdlHPWKPZHt0Q3Sse6mYYxovR60aJ3HQ8xFHCaOxAoJoRnnEgofZi9jk1rcaAJGmLy/Zx2tNODEVayd/VyR1WB4xdfVOVYMWJKKVyhRUevg0a8VXPDRraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xY1mypgYW4O8UpWTlvAjcKm2EtvlHBVEI2KsWAdF9hc=;
 b=mXSfYntAfwfCzlc+NeOidH8JnwsK5ppiQVppnxOOrEU6F3mFmDe+9bKtcFBlk53DvIS4nm1yQXfVy7TemCR+eWwcsRovDmXVJepfZejqxI2yvvDv+/VAWuItc6zjkwNDqp4Ivld+DMCag3UjqhTywt/Pqx5uIcF+4nUssElGEHYi5wBCU5eRlROibLJj9SiaZPXDSBE7dYUmKypCsFz4JDSzYssQ3jwYFsVxCLIOgXpN3pXqgcphTSTL3Fjcmwq8c5bqEI5957c4fHuvtXlQXpM7wnvMeq34LWkGEv3116hKilt+yODbqfsBW9dghCg2YuWW3LsEiINqLRV0sjK4/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xY1mypgYW4O8UpWTlvAjcKm2EtvlHBVEI2KsWAdF9hc=;
 b=DSfcNeW9tkANcUOobIieoGeV3bvjcoAJazb0y/Tjyot7C5ffvlHS+vqRqw9TBgIpE/FusoKx7oLwmwJZifaw0Hw7fDqlJ87DdSF0w2RuBsNq/Z3aTT1MqzSARJaIBt+9zLOJslD+e7wHfl4vkhqq6P8MEQqm7bHmeVMT4/RGOsorb6WVXDCO4jfPco+NHLT7jPac0C8+99AAP3ylpDEpW4HmHDVrRWeQmke2yytW6YcyhKUhiIVmxNU2ALeaKU1rGsgeQw+jfK5bx43LPL9mzJLLJTRhnlJ6tJmQ7dkDMLmlXT8UUQAgki4DH/pWi8fVVfjrpmlPRffH7nPlk8DHsw==
Received: from SA0PR11CA0053.namprd11.prod.outlook.com (2603:10b6:806:d0::28)
 by IA0PR12MB8373.namprd12.prod.outlook.com (2603:10b6:208:40d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.36; Tue, 8 Apr
 2025 14:03:18 +0000
Received: from SA2PEPF00003F64.namprd04.prod.outlook.com
 (2603:10b6:806:d0:cafe::e1) by SA0PR11CA0053.outlook.office365.com
 (2603:10b6:806:d0::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.27 via Frontend Transport; Tue,
 8 Apr 2025 14:03:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003F64.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Tue, 8 Apr 2025 14:03:17 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 8 Apr 2025
 07:02:54 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 8 Apr
 2025 07:02:53 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 8 Apr
 2025 07:02:49 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Vlad Dogaru
	<vdogaru@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: [PATCH net-next 11/12] net/mlx5: HWS, Free unused action STE tables
Date: Tue, 8 Apr 2025 17:00:55 +0300
Message-ID: <1744120856-341328-12-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
References: <1744120856-341328-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F64:EE_|IA0PR12MB8373:EE_
X-MS-Office365-Filtering-Correlation-Id: 682c3d18-5be4-4ef9-e5a2-08dd76a61cad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qyrRHQnM0C+BTPCVgszIAwa8UEX2Y+c2rhedsbdY40cnjYbNgOU/dIvS/wtJ?=
 =?us-ascii?Q?sJj9+VocBTKp7F87VZk2rsxicvBGPsmFO28CRZmgEUN6+QRG4t5f+xdbxnoY?=
 =?us-ascii?Q?apQzMDf9FOyLmPWXtFQavRetfhUoxKN3huHGe80PpEwxpXlx2jQrCWjUmfJ5?=
 =?us-ascii?Q?Fo7ajVZZef1TsZ1ikVbYE3hZFORzt5UNlMp9kqV+jXZODFR277hQQwxG0j4/?=
 =?us-ascii?Q?FJxYpjrQAE4PPikMWlvn5yQGvrXleaIW37s/27jF/et6O6QOkphVn1+UFgMY?=
 =?us-ascii?Q?XoeNtE0630ra0oSxZsOLqs0PpCWeLjXKCb31W/WO2W0XxMrqTtAALwWIraMk?=
 =?us-ascii?Q?yZk5sNneGyfcUvJ6OW/tC/inJiQOWK06pJrnAij99inUlmk1pHYahaiLdF3i?=
 =?us-ascii?Q?qciaBQ1V8D5tZGX1KVRC206YaOAIQIh4u2t1/Dga9Omu8TJlDKvbTOKBGRXW?=
 =?us-ascii?Q?/S4wskZPY6i+BmzNDr+n53Kci1KL6UUw/FhRIN3d+VF05UdRUmGCc8Ki5XQT?=
 =?us-ascii?Q?qVkWKXVSm1at/c4Z+WEo7D4NXGInLGdDhTuUMHs5jHBWdimT4z9GWAUZ54Qp?=
 =?us-ascii?Q?Qtg1ucl2Q6oSRFYYA30LT1WksVdHrSZ+iE7QggFwp+Bddn8oYm+umYrQJD5I?=
 =?us-ascii?Q?G72MxZ9uvD1PE+CVM1h6pGk3phty7JJF5DqfTwx7XnbnMgvGzfHLh60fEnYl?=
 =?us-ascii?Q?WjEZYURq/ju920pGlBaAad0gRwSYTzGRdwsouiK9DA1/Y4ck0nmAdQmQD2vM?=
 =?us-ascii?Q?s/3wkIjWYytozJjpNdC6mr5/OElRy/YSxHedjaWVQHd8gpiXDpfo9jTRWU48?=
 =?us-ascii?Q?gLXzxt3BwjIPgGCrlBfoJ3FR+e4USXYbSjRp8ZiDJ5BtjA3t4RX9d7ierpM4?=
 =?us-ascii?Q?Zyomeg9tIQFx0uFBNo8m/cbQsyl+Hco77IxQa0OWivqaaLTCV/FcClMcBbHk?=
 =?us-ascii?Q?FvnIr4NtOfvyjDUrowX9Mpbv1JNkkWLxAZvoREHNjv7o2E8Xs4DSMivnFbQf?=
 =?us-ascii?Q?95Nvgwq6sBKTrTJ5Zh4CFYXxbx2iFsq1UJ7Tx+xpyLPG1WX0Jn+PcmOePjDJ?=
 =?us-ascii?Q?d/BBOke4hufeQH3BxVyJIx7ibWvcHbz+OySFR21TVOmxWsNlx0jder8JuroJ?=
 =?us-ascii?Q?SbC6dMgDg1pmWxkNM6FwV0IgLD/ayXUrOdRrt4tNYgJM9njF//GWUgn0doXN?=
 =?us-ascii?Q?cwLRJB0knE5X0jaTwmNLboxnr1zp/8muvnbbkb/6FCOqtWbnoi1Bvj19uUBa?=
 =?us-ascii?Q?L3oCrLNGoOkOv7uwRpRUZBFa0Hxylw2ved232PW5Pa/VypI7sjHpzgnTOSxi?=
 =?us-ascii?Q?jErwVlufxy0Py7ybCLDiC3EndbuuyIUrw4qHQWiNAkm9u/hfxtyaN30EvynF?=
 =?us-ascii?Q?hWoMP4k9xVTcAIcs1QosMl3ITEwPkkf/gxxHn0uoaweyJt9UhRWm32Ht74WS?=
 =?us-ascii?Q?hHZyM9+hjnmLftPWkuASiKorvNx42RRXg2j4drnlnPYuelRbAtmqWdP+mjT5?=
 =?us-ascii?Q?wrd0rGr1K5QNmgk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 14:03:17.3037
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 682c3d18-5be4-4ef9-e5a2-08dd76a61cad
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003F64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8373

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
index e5c453ec65b3..509e19ec101b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/action_ste_pool.c
@@ -160,6 +160,7 @@ hws_action_ste_table_alloc(struct mlx5hws_action_ste_pool_element *parent_elem)
 
 	action_tbl->parent_elem = parent_elem;
 	INIT_LIST_HEAD(&action_tbl->list_node);
+	action_tbl->last_used = jiffies;
 	list_add(&action_tbl->list_node, &parent_elem->available);
 	parent_elem->log_sz = log_sz;
 
@@ -237,6 +238,8 @@ static int hws_action_ste_pool_init(struct mlx5hws_context *ctx,
 	enum mlx5hws_pool_optimize opt;
 	int err;
 
+	mutex_init(&pool->lock);
+
 	/* Rules which are added for both RX and TX must use the same action STE
 	 * indices for both. If we were to use a single table, then RX-only and
 	 * TX-only rules would waste the unused entries. Thus, we use separate
@@ -248,6 +251,7 @@ static int hws_action_ste_pool_init(struct mlx5hws_context *ctx,
 						       opt);
 		if (err)
 			goto destroy_elems;
+		pool->elems[opt].parent_pool = pool;
 	}
 
 	return 0;
@@ -268,6 +272,58 @@ static void hws_action_ste_pool_destroy(struct mlx5hws_action_ste_pool *pool)
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
@@ -286,6 +342,12 @@ int mlx5hws_action_ste_pool_init(struct mlx5hws_context *ctx)
 
 	ctx->action_ste_pool = pool;
 
+	INIT_DELAYED_WORK(&ctx->action_ste_cleanup,
+			  hws_action_ste_pool_cleanup);
+	schedule_delayed_work(
+		&ctx->action_ste_cleanup,
+		secs_to_jiffies(MLX5HWS_ACTION_STE_POOL_CLEANUP_SECONDS));
+
 	return 0;
 
 free_pool:
@@ -301,6 +363,8 @@ void mlx5hws_action_ste_pool_uninit(struct mlx5hws_context *ctx)
 	size_t queues = ctx->queues;
 	int i;
 
+	cancel_delayed_work_sync(&ctx->action_ste_cleanup);
+
 	for (i = 0; i < queues; i++)
 		hws_action_ste_pool_destroy(&ctx->action_ste_pool[i]);
 
@@ -331,6 +395,7 @@ hws_action_ste_table_chunk_alloc(struct mlx5hws_action_ste_table *action_tbl,
 		return err;
 
 	chunk->action_tbl = action_tbl;
+	action_tbl->last_used = jiffies;
 
 	return 0;
 }
@@ -347,6 +412,8 @@ int mlx5hws_action_ste_chunk_alloc(struct mlx5hws_action_ste_pool *pool,
 	if (skip_rx && skip_tx)
 		return -EINVAL;
 
+	mutex_lock(&pool->lock);
+
 	elem = hws_action_ste_choose_elem(pool, skip_rx, skip_tx);
 
 	mlx5hws_dbg(elem->ctx,
@@ -363,26 +430,39 @@ int mlx5hws_action_ste_chunk_alloc(struct mlx5hws_action_ste_pool *pool,
 
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


