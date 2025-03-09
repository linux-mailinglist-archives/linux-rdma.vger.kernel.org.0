Return-Path: <linux-rdma+bounces-8515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E448AA586D3
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 19:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93ACF7A3BE3
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Mar 2025 18:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7151F4CAF;
	Sun,  9 Mar 2025 18:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jcl8SP8R"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2082.outbound.protection.outlook.com [40.107.223.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC731EF365;
	Sun,  9 Mar 2025 18:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741543703; cv=fail; b=G8VmmW1wN49n0moSvsWYsIak5i9BBD+f0UcdwzRRbqkmTl9EPnQKuFTZuTIP7tLMTt+Tg5S/0U2BX1kgGX3oDRUqiI/ktZo9exyGJRO6mpLmyENoOyk9bZi/ptzYOXjR+0Vm5Xchjt1YW85X89wON+G6ZEc2MO9Ama/NIGK1yQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741543703; c=relaxed/simple;
	bh=l0q8rdQM06n7GoPr0SXGAN1sLkYkeTCjvviLBBiEM10=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BryKV97VZAbI+8E6LP3SVVogfxZZQA8zOCQ4Yv9znjRU1xnFGT+xzScGALbDswxp9z6EBzc51A/qeMG09gNu7kjrHD4QcBo3yxoSd2kSzGqR6wXmXZON+uRS3C9BZ2+lbVS+SmVOaQB3nrQN1pSx+x8p+FW41+KVhl7Pih5ZOWw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jcl8SP8R; arc=fail smtp.client-ip=40.107.223.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H6Hyt28Luy4Q4XHleufxpj7qwlakVpGq3K2fzXpLiCMQxyyhaFhflx3iQLOhbbDsJoWYAFPC3/fRjza5C2DC8RqqrYrgr5n8Ix9JUAu4JpUEtPGSYpsVt/ir04+t+EazrPkaQDCZqxcVk9FjGId9ydhjcvG3ynOcv5Cnzo6baP3QROK3umU0F3fsIZJEpquw3AgTjOlkzY1wokCnnQ96iOTUmSq1aBdXVHZ+DMOkPuZCT6qGotG625Y97wPK4iEdjVGPQKAsbVQfOL+lIQwSfwe0xO/fqE8Raot0Z56ySm3w6huKfdiYpJMKPASKld3j2omtiNTit5DtLsIvqIq3dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zcowUooBpXKvjuI9CzUiBL6iBc8q6hCA5klZeB945Io=;
 b=aGmS+1SxH4AW6KltOsVTlc2qkFP+w1CA4hr3azjfj339sklsQhhgv8Q2RSxUSBn9f8garCXvLNTtQ6FjsEaAWbgcgTZ4SzYegP9MKY4bmrrZIQw6YnoiRaQ6J771LT1ts38PemiEV+ghstJNbre/2jghrNlfuyC+L9LTTj11b8vQIVvqWzKe0vXW3fqB1QJnfrvpLWNm3zaI4UmW5wttcSvvuMizYYG0uO3/i+P83OAFjnMZCwuvCO3tHmgg1JuLA5QzCfHNOsrEobL9Fadq/RQ4Cg1CogqFORdaGtDiPA+nutiaC0B/FdusEhzKS9lTlTNlDBu8XelpfITsAZJ3Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zcowUooBpXKvjuI9CzUiBL6iBc8q6hCA5klZeB945Io=;
 b=jcl8SP8R+/HSLp5hbNBbb7l84RHwzJQssv42qQXfsuHlJCZlgKi4teJLmM/Veftf0/Czc6BOAk1io2hCK1EYVMZcuaiDjTQbmtZQ74CZFqgqHFWBNsPXOXT0A53aa4hWgyXHUF7EaUTyu5LY4KhDQEWY6nL2hfbuWnXXNOrfF5P5dRx3TgDczicKxrQ0/OpatD0nPzkGy4QIQyUVEh5oWPapadNDC++hA6ijfo2RFWwFARlZrKaGG3l6KcUYPX5Py+d1e9DM8gkMp1HFlmTj12cqXsQoNcJIJK8zQ+P7d6AXO9LMytzQ+HAuiOyeN/kFmfpkp1mSQNkfqiO7JRpIHg==
Received: from SA0PR11CA0124.namprd11.prod.outlook.com (2603:10b6:806:131::9)
 by DS0PR12MB7995.namprd12.prod.outlook.com (2603:10b6:8:14e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Sun, 9 Mar
 2025 18:08:17 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:131:cafe::a4) by SA0PR11CA0124.outlook.office365.com
 (2603:10b6:806:131::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.24 via Frontend Transport; Sun,
 9 Mar 2025 18:08:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Sun, 9 Mar 2025 18:08:17 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 9 Mar 2025
 11:08:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 9 Mar 2025 11:08:12 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 9 Mar 2025 11:08:09 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH net-next 1/3] net/mlx5: fs, add API for sharing HWS action by refcount
Date: Sun, 9 Mar 2025 20:07:41 +0200
Message-ID: <1741543663-22123-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
References: <1741543663-22123-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 93a5ac6c-ef30-4d2d-cb75-08dd5f355e44
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WnFNt21dOlyPQF6Q/nBe3+/E+QuG6EgfjsoM9UnK6ctO6MlPbM1p6ELNAL29?=
 =?us-ascii?Q?vX1+7WTz0/vLNGxRTao4FZzp+xbZOXaKYcEmkmKfQ315rePchP244zd5MbY+?=
 =?us-ascii?Q?Sp5STqPJVEGXgv3twXznpauoDZ6maAQcepWS2PanxoseGocHAPmXs0yEgy/4?=
 =?us-ascii?Q?5I5p2teAfpN/5ZilxCRa51JE/XzA5bgz1HXWm50gXDvsQDbkoU1z9chPCaXE?=
 =?us-ascii?Q?OZuXAqnLnhV7T2dpSAaAHIVYK1VjA8BAou4SjlCwgmvP3ZX1gC0kOhN7R3nX?=
 =?us-ascii?Q?XQ5Tmn8JGyraY2r/ub5xCQmXTXsXbi7zrQVpA6qLJOdZlda/MiUEbJ5yH9FG?=
 =?us-ascii?Q?WSWD74w/IXHspdKtZSynj0nidT3TYq3HW7CkRu49Ti3+5gJYLPRTwGtLIq//?=
 =?us-ascii?Q?L46ZkDskw6aZw9UX5wtS0MDZA/EXlJPMAYFFuIWlw2QIPrcA70ylLyheosb5?=
 =?us-ascii?Q?E39yTG2tjq55A+xEalIzslINfYesvWdWiQMyGewAJe6CwH7DE/KMbgw8ZmCR?=
 =?us-ascii?Q?1Tw3q0twt6CpMugTU5T1NJ0SMhlFIwEVA5GEJmQ05j7iw103TWlsZ6sosdLw?=
 =?us-ascii?Q?2Y3mNentcg7eO/3LwZfq4xsaWLf/HvNdDKiDTNqmKGWOCKPWHW2s3KgsZgGq?=
 =?us-ascii?Q?xCCkhqeQ1vmoKOqq/6cPbTBBJQHDH+EufCgoMh1F/k/zw77c/xQ4gA7AHsfv?=
 =?us-ascii?Q?AjxdikNRB4rRF2QMMYZ5iRDYcw2/oDpfADc3Sj+D/gHWYiIT1bgBdiCWHYXU?=
 =?us-ascii?Q?3qj7WmtVCgmg4h+dscOGCDveUY4fjqsiFr3r7FsklGa3kzxusYor2eyla7/P?=
 =?us-ascii?Q?/gSGsHrZqB8nRq1T5fu/ZEPHZ3w9gB1UKOnPQZasbpWnK8qqy+CtaPa+oSRO?=
 =?us-ascii?Q?wCmS84B/hOaqWZyMQlNo0YMyRLv0yuD1Qv1KikWvSjSlPLlhsMNeNL3mVAbC?=
 =?us-ascii?Q?24vhDkcBCKtixG3bzxEzrL7Qjt5cLSdk+bH6LseLKuStaCeaZZ3o+rh2G3di?=
 =?us-ascii?Q?uEhcbF6As6Tv3D94ju0MmI3kh2eJwgSsBj1H3zVVp9cMrpvdpE97VQgy/IM2?=
 =?us-ascii?Q?Ii8iUXOo8dd7UcQNaoDT+bDJ7frJikiLTUfcHtuJwm9VVPi6x7i7ATTaMeaL?=
 =?us-ascii?Q?+8WxJXd5JE6ZCdsz/tre+wRxkYHIhQ1iiZHw/ijaomyj/3okNz98WBNMPlwD?=
 =?us-ascii?Q?WhtXNezk29wJSGlF91dU3Ejs3bTL8id8FmVtVTE/XyMr3V1jX2yKqa13fhJu?=
 =?us-ascii?Q?Hf7PbVbtPpwo5zWJXGb78i3e3jljI1ONGoYtmUFvAzZoXDjunHoTMyMRX2JJ?=
 =?us-ascii?Q?LWevHLfdYfrHgFf+6gd9aXJUQXniUv4P8YQLnZqYZtm88OPp5HIF/3BBr2Ic?=
 =?us-ascii?Q?QceENiy7oBDQZTF2eBHyJ4CcKApVDjAPMd7dhXkzHUrGqt0JRUi8u0TEE3dc?=
 =?us-ascii?Q?DzxI0V1S/v4XtPGUJeu2WMQsXly26di/OaWgjxAUkZufB0jlPRHepyhLCe33?=
 =?us-ascii?Q?TlnShZNrOXw8/c4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2025 18:08:17.4700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93a5ac6c-ef30-4d2d-cb75-08dd5f355e44
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995

From: Moshe Shemesh <moshe@nvidia.com>

Counters HWS actions are shared using refcount, to create action on
demand by flow steering rule and destroy only when no rules are using
the action. The method is extensible to other HWS action types, such as
flow meter and sampler actions, in the downstream patches.

Add an API to facilitate the reuse of get/put logic for HWS actions
shared by refcount.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/fs_core.h |  8 +--
 .../mellanox/mlx5/core/steering/hws/fs_hws.c  | 57 +++++++++++++++++++
 .../mellanox/mlx5/core/steering/hws/fs_hws.h  | 17 ++++++
 .../mlx5/core/steering/hws/fs_hws_pools.c     | 41 ++-----------
 4 files changed, 81 insertions(+), 42 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
index 20837e526679..dd8b56e2287f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.h
@@ -341,16 +341,10 @@ struct mlx5_fc {
 	u64 lastbytes;
 };
 
-struct mlx5_fc_bulk_hws_data {
-	struct mlx5hws_action *hws_action;
-	struct mutex lock; /* protects hws_action */
-	refcount_t hws_action_refcount;
-};
-
 struct mlx5_fc_bulk {
 	struct mlx5_fs_bulk fs_bulk;
 	u32 base_id;
-	struct mlx5_fc_bulk_hws_data hws_data;
+	struct mlx5_fs_hws_data hws_data;
 	struct mlx5_fc fcs[];
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
index f34bbbbba1c2..50e43d574e0a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.c
@@ -519,6 +519,63 @@ mlx5_fs_create_action_last(struct mlx5hws_context *ctx)
 	return mlx5hws_action_create_last(ctx, flags);
 }
 
+static struct mlx5hws_action *
+mlx5_fs_create_hws_action(struct mlx5_fs_hws_create_action_ctx *create_ctx)
+{
+	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+
+	switch (create_ctx->actions_type) {
+	case MLX5HWS_ACTION_TYP_CTR:
+		return mlx5hws_action_create_counter(create_ctx->hws_ctx,
+						     create_ctx->id, flags);
+	default:
+		return NULL;
+	}
+}
+
+struct mlx5hws_action *
+mlx5_fs_get_hws_action(struct mlx5_fs_hws_data *fs_hws_data,
+		       struct mlx5_fs_hws_create_action_ctx *create_ctx)
+{
+	/* try avoid locking if not necessary */
+	if (refcount_inc_not_zero(&fs_hws_data->hws_action_refcount))
+		return fs_hws_data->hws_action;
+
+	mutex_lock(&fs_hws_data->lock);
+	if (refcount_inc_not_zero(&fs_hws_data->hws_action_refcount)) {
+		mutex_unlock(&fs_hws_data->lock);
+		return fs_hws_data->hws_action;
+	}
+	fs_hws_data->hws_action = mlx5_fs_create_hws_action(create_ctx);
+	if (!fs_hws_data->hws_action) {
+		mutex_unlock(&fs_hws_data->lock);
+		return NULL;
+	}
+	refcount_set(&fs_hws_data->hws_action_refcount, 1);
+	mutex_unlock(&fs_hws_data->lock);
+
+	return fs_hws_data->hws_action;
+}
+
+void mlx5_fs_put_hws_action(struct mlx5_fs_hws_data *fs_hws_data)
+{
+	if (!fs_hws_data)
+		return;
+
+	/* try avoid locking if not necessary */
+	if (refcount_dec_not_one(&fs_hws_data->hws_action_refcount))
+		return;
+
+	mutex_lock(&fs_hws_data->lock);
+	if (!refcount_dec_and_test(&fs_hws_data->hws_action_refcount)) {
+		mutex_unlock(&fs_hws_data->lock);
+		return;
+	}
+	mlx5hws_action_destroy(fs_hws_data->hws_action);
+	fs_hws_data->hws_action = NULL;
+	mutex_unlock(&fs_hws_data->lock);
+}
+
 static void mlx5_fs_destroy_fs_action(struct mlx5_fs_hws_rule_action *fs_action)
 {
 	switch (mlx5hws_action_get_type(fs_action->action)) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
index cbddb72d4362..1c4b853cf88d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws.h
@@ -58,6 +58,23 @@ struct mlx5_fs_hws_rule {
 	int num_fs_actions;
 };
 
+struct mlx5_fs_hws_data {
+	struct mlx5hws_action *hws_action;
+	struct mutex lock; /* protects hws_action */
+	refcount_t hws_action_refcount;
+};
+
+struct mlx5_fs_hws_create_action_ctx {
+	enum mlx5hws_action_type actions_type;
+	struct mlx5hws_context *hws_ctx;
+	u32 id;
+};
+
+struct mlx5hws_action *
+mlx5_fs_get_hws_action(struct mlx5_fs_hws_data *fs_hws_data,
+		       struct mlx5_fs_hws_create_action_ctx *create_ctx);
+void mlx5_fs_put_hws_action(struct mlx5_fs_hws_data *fs_hws_data);
+
 #ifdef CONFIG_MLX5_HW_STEERING
 
 bool mlx5_fs_hws_is_supported(struct mlx5_core_dev *dev);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
index 2ae4ac62b0e2..f1ecdba74e1f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/fs_hws_pools.c
@@ -405,46 +405,17 @@ bool mlx5_fs_hws_mh_pool_match(struct mlx5_fs_pool *mh_pool,
 struct mlx5hws_action *mlx5_fc_get_hws_action(struct mlx5hws_context *ctx,
 					      struct mlx5_fc *counter)
 {
-	u32 flags = MLX5HWS_ACTION_FLAG_HWS_FDB | MLX5HWS_ACTION_FLAG_SHARED;
+	struct mlx5_fs_hws_create_action_ctx create_ctx;
 	struct mlx5_fc_bulk *fc_bulk = counter->bulk;
-	struct mlx5_fc_bulk_hws_data *fc_bulk_hws;
 
-	fc_bulk_hws = &fc_bulk->hws_data;
-	/* try avoid locking if not necessary */
-	if (refcount_inc_not_zero(&fc_bulk_hws->hws_action_refcount))
-		return fc_bulk_hws->hws_action;
+	create_ctx.hws_ctx = ctx;
+	create_ctx.id = fc_bulk->base_id;
+	create_ctx.actions_type = MLX5HWS_ACTION_TYP_CTR;
 
-	mutex_lock(&fc_bulk_hws->lock);
-	if (refcount_inc_not_zero(&fc_bulk_hws->hws_action_refcount)) {
-		mutex_unlock(&fc_bulk_hws->lock);
-		return fc_bulk_hws->hws_action;
-	}
-	fc_bulk_hws->hws_action =
-		mlx5hws_action_create_counter(ctx, fc_bulk->base_id, flags);
-	if (!fc_bulk_hws->hws_action) {
-		mutex_unlock(&fc_bulk_hws->lock);
-		return NULL;
-	}
-	refcount_set(&fc_bulk_hws->hws_action_refcount, 1);
-	mutex_unlock(&fc_bulk_hws->lock);
-
-	return fc_bulk_hws->hws_action;
+	return mlx5_fs_get_hws_action(&fc_bulk->hws_data, &create_ctx);
 }
 
 void mlx5_fc_put_hws_action(struct mlx5_fc *counter)
 {
-	struct mlx5_fc_bulk_hws_data *fc_bulk_hws = &counter->bulk->hws_data;
-
-	/* try avoid locking if not necessary */
-	if (refcount_dec_not_one(&fc_bulk_hws->hws_action_refcount))
-		return;
-
-	mutex_lock(&fc_bulk_hws->lock);
-	if (!refcount_dec_and_test(&fc_bulk_hws->hws_action_refcount)) {
-		mutex_unlock(&fc_bulk_hws->lock);
-		return;
-	}
-	mlx5hws_action_destroy(fc_bulk_hws->hws_action);
-	fc_bulk_hws->hws_action = NULL;
-	mutex_unlock(&fc_bulk_hws->lock);
+	mlx5_fs_put_hws_action(&counter->bulk->hws_data);
 }
-- 
2.45.0


