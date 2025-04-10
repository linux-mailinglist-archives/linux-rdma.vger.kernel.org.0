Return-Path: <linux-rdma+bounces-9345-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A82A84CBE
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 21:19:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB1BA1BA441D
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Apr 2025 19:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1029428FFD8;
	Thu, 10 Apr 2025 19:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fu0PszMf"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA128FFC7;
	Thu, 10 Apr 2025 19:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744312719; cv=fail; b=HmVkLq2HAJV8IbyngrosY64mH1p7mcIZvnrgw04q8Lz6FTZXnNbUY9ZujHFpDBaqo4mTU8PsxF8952lI2u59rr/DRQBNEBDPKXo+MIP83crkSYlW37ttMiFrRf/D52XveoarZkoE4M1DANbKiU+gE5wBfCk9XsJIXM8OOai7H5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744312719; c=relaxed/simple;
	bh=N3ZBhb4FcIkUOjzxMYSxz/IPKpRlXniN0FAQa0I2wCY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeywNgCvxviyCBbqY0NnEyV9MDi5wiq4DOqxzWyPz8DUu77i1DCfpqKNhKSmkfDt/hRwnOXBMHSJV5aRsjK/dufiTXjfksCzgvFB93iHi+gyomoG56My/hVWGic6sqavvyZXccbz3Rxu7BSVj9r/eu3zbYPpGyJPl35NL7gvoY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fu0PszMf; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a1HaFa12S263z5MgefrQkWnDwahtaqVcfoZf8PDIDNJyl11ycGjB+H0rRRuo62IaHOSvibrDxQm0YDQz2qRhXBJ+6jan0RWxlWtTHEcRwvhoSWMOmqi8/oYHedr6VK5FfEB4eUIGWfuFMKypwDwqFETdt1niio/jovrHLnlA+WzQ5LP6RwFWLYZnewiB7uTjXKKCy4QuI9Z1QF2nQdVUMKT/X6AJbUGW1pdeM2EIDl7rfMiUAZLxm+91L+tEE0voPg/XghplRWkRMscfqd8vRq0UUVP6n5vc9W9yhfTOkOs9cSENp91nOjPkkOdpHURgJHkdgCT8k9JHIMP2GqRvQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IGK49uSaNATQw6Zn1UHX44d6SycIv0icibxgmaljrqI=;
 b=EVAwO7yIFEufypU94e29itDuGRQ3Yi+xbG80fLg1XAtm3LjyCql7eHnq9s6DOaeKy0rAt+mEJW6WRAcMcp3ja4/sWqVJ9WbifLQBkiSH+ikfy9gmsX4rXsHSyYy4oxKwstQ/q7lET4iESKlPSNlWhYsw3esjMnayQKQqXeXbWpfaXbkbAU0rwCEqQ0gnpRAE3CuvlyHNGcKGlwXgLldkdgbLEk5V3Ll9UUiAGkkJAIYKZzRdUrsUEBFGL7k7tAz960tnPVL5wFMDRuqTYPeqsJ9TqPIFWwH757nPnQEVla6YeA7wZhvfrKW6o/oNNRv/XJcEzU2f+WqoBGXdxbypvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IGK49uSaNATQw6Zn1UHX44d6SycIv0icibxgmaljrqI=;
 b=fu0PszMfaeg3m6ouk22wnMxvG7/D73xEEhwd/C7WyQUihczYG/VlHsl2jfcdJDQaw95D1xjveuyO9iXFR3XQ/lL3ac/IdDLNn1333VgeHvxj2LocoG8u3aydLX9WVYKrkCntOyfENWeaqFlvXG0ApLvFW3K3v1jDYiZwxS+EIEdFAKJR5aKwIEzjzUCqDBkgmcijTxJM+qRKLpT25ZGvrHyVGVBclVtd6IKc0SdWIqo42W9LQdhAbinkHKuSpptUKYZPSFOAdFStSVShx1Ig5n92dx2k69kpv8Ja4GmaoQRIDwNzQTdaoYCSBmHn21unn20T4NzEg1ZCZbHaDymokQ==
Received: from BL0PR02CA0052.namprd02.prod.outlook.com (2603:10b6:207:3d::29)
 by PH7PR12MB7211.namprd12.prod.outlook.com (2603:10b6:510:206::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 19:18:33 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:207:3d:cafe::c7) by BL0PR02CA0052.outlook.office365.com
 (2603:10b6:207:3d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.37 via Frontend Transport; Thu,
 10 Apr 2025 19:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.13 via Frontend Transport; Thu, 10 Apr 2025 19:18:32 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 10 Apr
 2025 12:18:20 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 10 Apr 2025 12:18:20 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Thu, 10 Apr 2025 12:18:16 -0700
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
Subject: [PATCH net-next V2 02/12] net/mlx5: HWS, Remove unused element array
Date: Thu, 10 Apr 2025 22:17:32 +0300
Message-ID: <1744312662-356571-3-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|PH7PR12MB7211:EE_
X-MS-Office365-Filtering-Correlation-Id: 63a2be19-4f99-4c9e-94f1-08dd78647bce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4dndLXInVZ8RhjEi/PSpvuNFgAvI/1b5iQPRK27Me4ar6ZsoQosSQnIY+Y8r?=
 =?us-ascii?Q?l6tk7mZE4ax28atLYEkOK29FsOKm+l31lB/cUyiELybYOfy+tVV23sXWn2Fc?=
 =?us-ascii?Q?2hKQNeCPPE05GEGvFYoo0nn1xF5ZoTYY0qbuUuONQgetySqttr5luBOWrxFC?=
 =?us-ascii?Q?jMiSDE8Cmpe6+FJj1CJaoN37DIKX0XdMhhiGTSp0VrMt5Jj7hzUd/ML/hxk6?=
 =?us-ascii?Q?2s9wwTdIMVt4IH2CNBCCq6c5S23y4pbcYdR7Q21EvjEIL1Aziw/3xq+vVu5k?=
 =?us-ascii?Q?qLYc4BLbYxhfjulMDZrGDDaDEAGDX8NyHUL2QitL37Ge/s6blVfV93vu5oQw?=
 =?us-ascii?Q?+H8pfnQItv5HZ2akviT0xuVy3js8YCSuQ2pNNwjSu6n2tvMhZHrgj9H8VaV5?=
 =?us-ascii?Q?TBAkiKm16zZAIVlwatzQiTQKPJijHvpuC37ReLXTnCn6SJdIOysBXtQCFYLP?=
 =?us-ascii?Q?HO28l6pbuAenj0C7AP7jSSPf6b4L0OOaSLKKjXWTqPZxVYHT6qH7hH//6EN+?=
 =?us-ascii?Q?B9Bt3ruU2pPQsYl/BaOaweB3KnlaUczu0BnYx/kNf/LxR7qkRsReYYvXkwO5?=
 =?us-ascii?Q?XL+RuYOLy3m3R5JkZyQM3fklOESWowjt75XD+mhicoJi12OIKv/cHzFc9Ruw?=
 =?us-ascii?Q?H1647wMbpQLFP8x6xHlkOnLWtV6jeZwbPoC0vRuMiZ1tCmILTHZc3UiZLGn1?=
 =?us-ascii?Q?xF6OdD75sXz8bACmOgI9b1YZrbRnhYQZq1a95tS59IVpzMVU6FYQhISeasyq?=
 =?us-ascii?Q?MgFSxQoDUZ4rcJ1yR+Okc8Qz2xhBwA8XcWLd5vcsbf/PoRx+9CAC5VNUEkP8?=
 =?us-ascii?Q?8ZEIA5Xq4wtZbc0K1GfNhcg7GfD2mwsrZWnnpF9pwt3uwrc4aH61uQkVD1L/?=
 =?us-ascii?Q?jsFQho6VmcREM1g3aBas/Ru5hFA/me9YM2YFurSgLTtkagTQSxqKYUYmb1SW?=
 =?us-ascii?Q?xYb+sg3M84AyxnpbWxA+67s0BeWSrM2wBh2rTx6KCYb+mq1/ffroeUCaNPH5?=
 =?us-ascii?Q?0EcHRzbePRGJdpli42tnlxxsVur9TI8g739XCBsE3ZIfL8IKXMea0A7Bj9cO?=
 =?us-ascii?Q?hnWm8dDE4bIWJP8/0PsfZ13yQGsour5E1Yn5lINJaOuPv2uKoJRX9nzBd+4G?=
 =?us-ascii?Q?L+mu+dQx1Y79F1bSxgT4AVlKNJbFtnRVq52v+C1T5kJxi8JCqa0I1S18p6N6?=
 =?us-ascii?Q?E7bz74hcsui0+HUyviX8cwZQpkOn9fMjYEClzfD/aXbNQXny7SzGni3YhhrL?=
 =?us-ascii?Q?uFoffrZ2DbMvCAdP/ljV4Xri4zFGFrrbrOCcSNJFXBT26d6YCTbJPSRN6Cu+?=
 =?us-ascii?Q?oEeoCiqoSJJ7J882vZkP9oFaaynmFtsOINWrDW3KAgy+9o6UPejU/ChJ2m9Y?=
 =?us-ascii?Q?GtSOJkid148oFO6grGmgGwgRfR34TdVn0DmuZYuvtjPgpqz4BbBbMaJU6wQb?=
 =?us-ascii?Q?icYcpK2moQdTeGz0mDKW9k0nM1Scq5Xtijr9KiO17KJInIQ7mg2SlURUA2Gk?=
 =?us-ascii?Q?boNEw7o+bUn+Fqald9XYfOgiNXkGiAPzATU+?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 19:18:32.4427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63a2be19-4f99-4c9e-94f1-08dd78647bce
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7211

From: Vlad Dogaru <vdogaru@nvidia.com>

Remove the array of elements wrapped in a struct because in reality only
the first element was ever used.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
---
 .../mellanox/mlx5/core/steering/hws/pool.c    | 55 ++++++++-----------
 .../mellanox/mlx5/core/steering/hws/pool.h    |  6 +-
 2 files changed, 23 insertions(+), 38 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 50a81d360bb2..35ed9bee06a6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -293,7 +293,7 @@ static int hws_pool_create_resource_on_index(struct mlx5hws_pool *pool,
 }
 
 static struct mlx5hws_pool_elements *
-hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order, int idx)
+hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order)
 {
 	struct mlx5hws_pool_elements *elem;
 	u32 alloc_size;
@@ -311,21 +311,21 @@ hws_pool_element_create_new_elem(struct mlx5hws_pool *pool, u32 order, int idx)
 		elem->bitmap = hws_pool_create_and_init_bitmap(alloc_size - order);
 		if (!elem->bitmap) {
 			mlx5hws_err(pool->ctx,
-				    "Failed to create bitmap type: %d: size %d index: %d\n",
-				    pool->type, alloc_size, idx);
+				    "Failed to create bitmap type: %d: size %d\n",
+				    pool->type, alloc_size);
 			goto free_elem;
 		}
 
 		elem->log_size = alloc_size - order;
 	}
 
-	if (hws_pool_create_resource_on_index(pool, alloc_size, idx)) {
-		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d index: %d\n",
-			    pool->type, alloc_size, idx);
+	if (hws_pool_create_resource_on_index(pool, alloc_size, 0)) {
+		mlx5hws_err(pool->ctx, "Failed to create resource type: %d: size %d\n",
+			    pool->type, alloc_size);
 		goto free_db;
 	}
 
-	pool->db.element_manager->elements[idx] = elem;
+	pool->db.element = elem;
 
 	return elem;
 
@@ -359,9 +359,9 @@ hws_pool_onesize_element_get_mem_chunk(struct mlx5hws_pool *pool, u32 order,
 {
 	struct mlx5hws_pool_elements *elem;
 
-	elem = pool->db.element_manager->elements[0];
+	elem = pool->db.element;
 	if (!elem)
-		elem = hws_pool_element_create_new_elem(pool, order, 0);
+		elem = hws_pool_element_create_new_elem(pool, order);
 	if (!elem)
 		goto err_no_elem;
 
@@ -451,16 +451,14 @@ static int hws_pool_general_element_db_init(struct mlx5hws_pool *pool)
 	return 0;
 }
 
-static void hws_onesize_element_db_destroy_element(struct mlx5hws_pool *pool,
-						   struct mlx5hws_pool_elements *elem,
-						   struct mlx5hws_pool_chunk *chunk)
+static void
+hws_onesize_element_db_destroy_element(struct mlx5hws_pool *pool,
+				       struct mlx5hws_pool_elements *elem)
 {
-	if (unlikely(!pool->resource[chunk->resource_idx]))
-		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
-
-	hws_pool_resource_free(pool, chunk->resource_idx);
+	hws_pool_resource_free(pool, 0);
+	bitmap_free(elem->bitmap);
 	kfree(elem);
-	pool->db.element_manager->elements[chunk->resource_idx] = NULL;
+	pool->db.element = NULL;
 }
 
 static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
@@ -471,7 +469,7 @@ static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
 	if (unlikely(chunk->resource_idx))
 		pr_warn("HWS: invalid resource with index %d\n", chunk->resource_idx);
 
-	elem = pool->db.element_manager->elements[chunk->resource_idx];
+	elem = pool->db.element;
 	if (!elem) {
 		mlx5hws_err(pool->ctx, "No such element (%d)\n", chunk->resource_idx);
 		return;
@@ -483,7 +481,7 @@ static void hws_onesize_element_db_put_chunk(struct mlx5hws_pool *pool,
 
 	if (pool->flags & MLX5HWS_POOL_FLAGS_RELEASE_FREE_RESOURCE &&
 	    !elem->num_of_elements)
-		hws_onesize_element_db_destroy_element(pool, elem, chunk);
+		hws_onesize_element_db_destroy_element(pool, elem);
 }
 
 static int hws_onesize_element_db_get_chunk(struct mlx5hws_pool *pool,
@@ -504,18 +502,13 @@ static int hws_onesize_element_db_get_chunk(struct mlx5hws_pool *pool,
 
 static void hws_onesize_element_db_uninit(struct mlx5hws_pool *pool)
 {
-	struct mlx5hws_pool_elements *elem;
-	int i;
+	struct mlx5hws_pool_elements *elem = pool->db.element;
 
-	for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
-		elem = pool->db.element_manager->elements[i];
-		if (elem) {
-			bitmap_free(elem->bitmap);
-			kfree(elem);
-			pool->db.element_manager->elements[i] = NULL;
-		}
+	if (elem) {
+		bitmap_free(elem->bitmap);
+		kfree(elem);
+		pool->db.element = NULL;
 	}
-	kfree(pool->db.element_manager);
 }
 
 /* This memory management works as the following:
@@ -526,10 +519,6 @@ static void hws_onesize_element_db_uninit(struct mlx5hws_pool *pool)
  */
 static int hws_pool_onesize_element_db_init(struct mlx5hws_pool *pool)
 {
-	pool->db.element_manager = kzalloc(sizeof(*pool->db.element_manager), GFP_KERNEL);
-	if (!pool->db.element_manager)
-		return -ENOMEM;
-
 	pool->p_db_uninit = &hws_onesize_element_db_uninit;
 	pool->p_get_chunk = &hws_onesize_element_db_get_chunk;
 	pool->p_put_chunk = &hws_onesize_element_db_put_chunk;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
index 621298b352b2..f4258f83fdbf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.h
@@ -87,14 +87,10 @@ struct mlx5hws_pool_elements {
 	bool is_full;
 };
 
-struct mlx5hws_element_manager {
-	struct mlx5hws_pool_elements *elements[MLX5HWS_POOL_RESOURCE_ARR_SZ];
-};
-
 struct mlx5hws_pool_db {
 	enum mlx5hws_db_type type;
 	union {
-		struct mlx5hws_element_manager *element_manager;
+		struct mlx5hws_pool_elements *element;
 		struct mlx5hws_buddy_manager *buddy_manager;
 	};
 };
-- 
2.31.1


