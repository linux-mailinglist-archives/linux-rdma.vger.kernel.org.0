Return-Path: <linux-rdma+bounces-8137-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0575BA45F2F
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 13:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC9E13B9204
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Feb 2025 12:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CDE21D003;
	Wed, 26 Feb 2025 12:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HBGbK0Fw"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B499C214817;
	Wed, 26 Feb 2025 12:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740572816; cv=fail; b=DvME0GAGOuYAMN2i3AadEIyfgrp83PCg1nnRIjPt6msHiEV8hp5U+xmFPpxtXvCmlppS6sH2/pg12sRcSbxVsuvSMlXgQCRGSZbESzEYsy2ANeDdIYcB6LwgI92zJA9UQSsZZXN9Ymnr6g0Lv4TqUlEFs8qKognlNQ9SNYHRPIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740572816; c=relaxed/simple;
	bh=td9+L8B3Cl22co7LlEXwp5GN1HwdvLP3hU+LsvOfSEU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WaduveS2bn59ycJn9X7p4t8AiFEbUPRAU43niC88SnXDTcSE5f9CxZAzJlo00FZcOcjzMJ9uDTtEInTsFQR4fY8qmTGD9DVQdh1I8hxPbV39o9LbH09QSBXdSjkk1PRBk3WC9BpZG+EJsTZLm6rBoDKr6ueXTHYor/DSjeJnnQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HBGbK0Fw; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDuVkpAkn8uFdbN+5uRsO8As2y60XIooWb0LbwkDrN8lkckWtiYyu2UH5UoJfXXaBJgm4jw6/0yE418OJGuWTtSpyv4qRnYT27+1J1SVNTSSDPfV7gDOhbnkfTgtDuanGf9zXeOCTxFOnE41fLejGRy1DJCWML456qzEdx2/eStRx1htaqIWs5wpdqnDYIhECZAHDhHR3oh+FuHghaQ77Q9a2n/dIq+gC6PKwRncFdOM6EFGHAC07vsAqKK34i/5QWt07XfSDEPuBmIJ3pJ3qsQ0Bvqb5BhiYMq7jRxWWO6dSIigqTy+VtNn/XiRj8p53EJINzHYz5tRIBq0CMCrYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSIhId/IHwWIv7HDVtZDmmQzYDlsG3OwKH8K0rj80p4=;
 b=mx2lSrvUh2/I4Wr6owJonl799ku7+a4UmDg0yOzLP4H4r0aHt772Y7pzYh3JbVvvlIAKkeAkHEB4mI6nmp0IHzYDW/QRPxaYksqQkCGIJXkGa2vEXximnCSQbU3m8grIc9pwk8Pooz3Zv6UIPih9R+1qmQDlmf+kErHGpQebYHsUZ+UnF/e+wEO1U3G1H2UbmcNyyJCmIssyW9/BPANY5DcOCrNlkXGL76DWyQVtgMvHK10zRKuLp7YwA3cpALJoBfjgSs9eCVcs0+aZ5nH2DvGMdXMWva5NwKCiKEiAErC7dcKS+muDlvKx/3dq4HRb1Ww3NtaxXw55UFRBHe9aVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSIhId/IHwWIv7HDVtZDmmQzYDlsG3OwKH8K0rj80p4=;
 b=HBGbK0Fw1qFL6fHtP2U16d4pvkpdAGLddThwv+QYNhvkIu2ap8/Nq9ttB8k8GkEC6HK+eJZCWZyw0vjujq4Fg4STULksC/5JjOvbIo301JFGQwYuFsKNJA+gmrF0hsGHWn71bo3/hkDzRMNfnPEjsDovhBM3AhWdUL9NATyVOiNH9h7kxA2oUBRU0qaJKK0+TzY74b7j7xhLuK2NRK/wQu1TCzBo833OLGMlpiOAOxhwpFq7eczq8j6OdY/ZZS201o1+nSNsNfjA5lfr+a3ZrvRl6SevZagqALdMCKyj6aNIqSxAXNujdRRxvFqj1MrnUoeTdzWJFibNEIw6g5+58g==
Received: from BY3PR03CA0015.namprd03.prod.outlook.com (2603:10b6:a03:39a::20)
 by SJ2PR12MB9008.namprd12.prod.outlook.com (2603:10b6:a03:543::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Wed, 26 Feb
 2025 12:26:47 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::b2) by BY3PR03CA0015.outlook.office365.com
 (2603:10b6:a03:39a::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Wed,
 26 Feb 2025 12:26:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Wed, 26 Feb 2025 12:26:47 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 26 Feb
 2025 04:26:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 26 Feb 2025 04:26:38 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 26 Feb 2025 04:26:35 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Leon Romanovsky <leon@kernel.org>, "Tariq
 Toukan" <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Shahar Shitrit <shshitrit@nvidia.com>
Subject: [PATCH net-next 1/4] net/mlx5: Avoid report two health errors on same syndrome
Date: Wed, 26 Feb 2025 14:25:40 +0200
Message-ID: <20250226122543.147594-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250226122543.147594-1-tariqt@nvidia.com>
References: <20250226122543.147594-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|SJ2PR12MB9008:EE_
X-MS-Office365-Filtering-Correlation-Id: bc195bc1-9bc7-4ca8-13a7-08dd5660d67d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UoD7/KOs0AGgLS6gdH1urwCOpFXKu6a3FHrx0lsfzcEzEieAmPuW0Pc7N/dh?=
 =?us-ascii?Q?HB0QWj8ouFwHU7Yr7H0m/YYoEfPQJm45EBF8c3o1H4Mojg5aolYxaAjZkB6E?=
 =?us-ascii?Q?1uINVy/yTm0J6xTvHfnqZfkKIyEwetjnyFC2dMrYxCwhoc/zMjvI9pPpvSAT?=
 =?us-ascii?Q?k12wxhgQ2E0zPklHk+R+1x90ad6oSBIPiO5ZZycKKNSJtODAHPEx5MSfCW/m?=
 =?us-ascii?Q?FVVHC5tHrvt3ECEMPI5ShkboiQNOXq72TBEE45449brkYVV4NSjoP/P/xJgZ?=
 =?us-ascii?Q?lcIYM6YS3OdsI/AWaZCwdW7p/p/DfrSnVtQZx7n8qgoZgsjD+U9DBUcT1jc5?=
 =?us-ascii?Q?MNugoyCnnJuoVfxr0NkGrRQLKG23f/iTkBaipOpzDpWSG2cY8ZdQDa+fgdJO?=
 =?us-ascii?Q?plPLj0XUwH2QY1psXHQAr4438Hz0DMhY268dijxmTtOgGk9Ib9vfV3eCNkZd?=
 =?us-ascii?Q?yBOhb9VaVsoTeS7Q6trXrDuyZ4VGcTBRz7Lx2tYchmOLDgHBXpEE0dj3VZVN?=
 =?us-ascii?Q?5H3tsMkmt/sI/A1aPQeeiX+HwJ6nUorQo+EUDRgK3RTrkJuesy9FKX2HmYOt?=
 =?us-ascii?Q?47XyM38Au2zPK53XTTjXqPys62HPfQIoxztwV9uZwztEFcVM4yJMcBKnNjA6?=
 =?us-ascii?Q?jb7EF4m33VzeJNVjia51RphBcjpCzjSbC+AUyBDzzF8tn+Mmth2S+YPxoZXS?=
 =?us-ascii?Q?LJ2POU5vp2RpWtOIp9cyFGWukcmbipr479WGcS8qKsTgCTvo7nm6lGX1yxrc?=
 =?us-ascii?Q?AyEF7/J/C8ESlr8wxnBBm+d5olHknCbUZm6Ujki8y3B1c413JWfltef5HCZK?=
 =?us-ascii?Q?kPmejPSsYN1XpAS5V3R6Ugb820Ig2WSH3KpgtuGrJqUpWPRexlSR0n+laoEJ?=
 =?us-ascii?Q?ymE/zDLns5xQVDnYk3tu5YGOno1vp2Z5oiV0Hvn3Rh7GvTOtJrRYilihpUab?=
 =?us-ascii?Q?Q7LPzCJRZtqMlNw4SlqwHB49lO/jpNXXvtR+SiD8AN5pJha2V3490IeHKch/?=
 =?us-ascii?Q?be4T7zHSThJMzlRkpx3EC73qWh7NFPFLA7ljaJivoVdyOzohtpcBXhbX3rKN?=
 =?us-ascii?Q?jO436omSG4CJhtNcRKbQjuPm36CPb+smPC4mGpCE/lORder3E2xpedHr7R6B?=
 =?us-ascii?Q?9stdOVUjVANUYqVo/VeJunegAIqtkIRMz1j1iGqfam3Lw7mZFP3i4k5CbK+j?=
 =?us-ascii?Q?fjmfBuenSq6tELGISqancCNgQK+0IlmM3TdVn84lW5wvw6U7DOfpSBcZ6UHI?=
 =?us-ascii?Q?yNpjwsYcMxiq0J3rm7OKGE3rRZOGcdJEl5LpwZHC9h/lV17Kt2no43O9p9iM?=
 =?us-ascii?Q?7ewYEstUBvolExnevgFLcMWOyIUsxitZoqRx8aFVYnuttBwQKPoyunJL62Hp?=
 =?us-ascii?Q?Wy/N0XpYOGqXgUEqA3FeytHu4A9FrSSAeveeKUjo4WUgAXeGuflAGRPG05QY?=
 =?us-ascii?Q?61rxmaWWtvmLVQXe8A2LwBow9iPuf5nV3cqRM9Sb2SycLllY6hsB5M4mNprR?=
 =?us-ascii?Q?u2R5cvrUyni8CVM=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 12:26:47.1692
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc195bc1-9bc7-4ca8-13a7-08dd5660d67d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9008

From: Moshe Shemesh <moshe@nvidia.com>

In case health counter has not increased for few polling intervals, miss
counter will reach max misses threshold and health report will be
triggered for FW health reporter. In case syndrome found on same health
poll another health report will be triggered.

Avoid two health reports on same syndrome by marking this syndrome as
already known.

Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/health.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/health.c b/drivers/net/ethernet/mellanox/mlx5/core/health.c
index a6329ca2d9bf..52c8035547be 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/health.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/health.c
@@ -799,6 +799,7 @@ static void poll_health(struct timer_list *t)
 	health->prev = count;
 	if (health->miss_counter == MAX_MISSES) {
 		mlx5_core_err(dev, "device's health compromised - reached miss count\n");
+		health->synd = ioread8(&h->synd);
 		print_health_info(dev);
 		queue_work(health->wq, &health->report_work);
 	}
-- 
2.45.0


