Return-Path: <linux-rdma+bounces-19629-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDaIGLBH8Gm2RAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19629-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:37:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA13647DB35
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 07:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6C08B306BA5C
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Apr 2026 05:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D4833A00C;
	Tue, 28 Apr 2026 05:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cPy3IWDL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010046.outbound.protection.outlook.com [52.101.85.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377D231065B;
	Tue, 28 Apr 2026 05:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777354248; cv=fail; b=l5a6NdN3afrlC1gUu6L5hjX2QdCoJQ67cgxr3L9mkedKK+SZQPzRid/elTdtiq5qaYDM/lmKQLPIEIOMmEc9wYw01z5b4WOFpeK/UuDiepJyNwxZxws2HcR8i0+1XlUttOA330+yA1ZWuC5/Md2oDyy+v5/Vl1He+UWE+zrRiQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777354248; c=relaxed/simple;
	bh=+Q60X2ZAR5/LpkpWElKaUPLZR86k9seKYbq7g/2Og0c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MIsWEl0TQNHzTILG92vBiSqflTnWHFTT+D6CmMxQCRq4TYojtkh2H90w5YXwd0CkRI5zV9mGdLJIybC/CAHlfbAz45VMrFywTeSFp/+jCc8LbU18dUbosXkpQvRUjQmvfN/KCEvIFELI13bCAqWBkjdRDLTg9+2DzmG8j3/kHIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cPy3IWDL; arc=fail smtp.client-ip=52.101.85.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zUkWkbfSnPOXhnENTgU3xyshPv+t+paPjUwJ7MAOv3AT9SYZrxoxcsLTkmGeFfciIKvxZAed7OuKf5Ob8w9BT/ERmNxAfCcwpu4tT31ERxqA02OZLuPSyXLhTv4Ra4MhAuH1yp4jZ1grfRB2VBJKommSq3XgKWZoU5baNJnRe9NKD03aYBxTSpZqwZWdrdlTmgI3Z3dgLgby/0nRBk1wCeYAsTX6DCCF02V1u6K7SJZ0Ykijm4KrWP7bdAe4al/40xgJbgQDTfKpHC73fQ2HnKeKrPx/vpIHVHiLorOnY7+HGslVIIyv2LJv558ssje4ShOIvyTmDNK2xIa5pArpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1HHCf19uzChilZlCCP/wRyQD0j/USUOwH8ADTHgJZc=;
 b=Nfxwpk3JDO3RdL3xfqfppMWzhqoM6k5dGPz4Asyeqla4PuAn6jUZA6Aca6GLMha/NchM5JJzdA3ifz2WyA217CIR6JcAuB/X030U1NZg40RhqZmig/DwYzMmO4I0WpGsXw8UvRlRxmHtmYSmrO5CaC/0ouZrefM5XadEv2twnqQFsD0WN5D2TWYKXlnmtQDll5z3cDiueZWFVvfFi0nl5yP32OruBdSKdy+4tybC2WsuGCjNGagaCqbCxhjJdPKRhX+ldOsEmBSdYsChiiUMwxxetr0obnQWYQrPGa0Wp7m8BBu3x0rXmBF+f5CYZnnKuL+2XJh8FMewKoLqgVREIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c1HHCf19uzChilZlCCP/wRyQD0j/USUOwH8ADTHgJZc=;
 b=cPy3IWDL/6LNW4t0rExFbVTdqNr9AK4B5XWmwKYhEjJKUMuAP0H4kHpCohH36p6ZXVOWHV6k6PckYhllwpTiAiLpMsJ5q7ITw/Akp2pPmkN5fr0mI45/6RnTKfD1OGb5OVbUiyHuxviNUFPnNvDXDqFc5WJyXzBOe4vWnN7e/j2eqQh71dk2ng+IYPHlUaLq5sExzQZSjXaMMe5tKGz4/DP7Y93UyIJzPcN6/QGJ7x9zLG+fQm0PL5oKqLQL+GG7yAgHw9WanYwnZirSw9btrKKKk5tQtAH8mXpMYi4RxZ03dWfdfi1UuAAcKhvvwtODljoqbzKZWmkN5P9wJwhuCQ==
Received: from BYAPR21CA0003.namprd21.prod.outlook.com (2603:10b6:a03:114::13)
 by MN2PR12MB4094.namprd12.prod.outlook.com (2603:10b6:208:15f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.17; Tue, 28 Apr
 2026 05:30:40 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:114:cafe::b2) by BYAPR21CA0003.outlook.office365.com
 (2603:10b6:a03:114::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.4 via Frontend Transport; Tue,
 28 Apr 2026 05:30:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Tue, 28 Apr 2026 05:30:39 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:16 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 27 Apr
 2026 22:30:15 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 27
 Apr 2026 22:30:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Nimrod Oren
	<noren@nvidia.com>
Subject: [PATCH net-next 3/3] net/mlx5: use internal dma pools for frag buf alloc
Date: Tue, 28 Apr 2026 08:29:20 +0300
Message-ID: <20260428052920.219201-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260428052920.219201-1-tariqt@nvidia.com>
References: <20260428052920.219201-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|MN2PR12MB4094:EE_
X-MS-Office365-Filtering-Correlation-Id: 8944020b-59f4-47d8-d847-08dea4e748cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|1800799024|18096099003|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	di6ZKjDy1Cg7FSdLoiA0YOfiisMKGR9ex0WiRk6rxmCT6sHf5BaguqA2NjlfKm9lLRC2COlkPDjx139e6fjnc15IpbJS292SobuVtLA0dbfVtlbRlQxjNtIRwBuKzGdYfB1PePhTYiv/DWDjVZE1JZ5nW1GYUnva3TYBNZwLcaEeWXZafnFd6y7wiGuAhN+qYirNvulNbBUjlyQyWSfYTRmWwIdJTSUN79stOSWjcxHTgACoAh31CmDZOcnAV/vDjJmwZoiR5cG3RLeXn4MdXbyfzVD6o1SWvAawM6QYTW6QQtlxzSQfbYQXbRdo3amzAP8DeNFJZxFQRauic1g5+zeQNl6IDdFvmkCHj1oDgl2o4j8fgFBFStwZLA7vyIwZqt8MDqdAAjVx0bLR9bHkeBpg0xeAImrqLMaJkkPfozpjqUYn7nrti5nXBOalAEx/u5wkX7L10n/FrsY/jlU9nXm1UTyUK0KiJaQyOJlW13fYp0+7lveSw/M61TgBKCKstit9pUJ7Zoo4I6ad7zUlejGyk/Rd6poww00CajuXHcegXxU0tI3elIqkXkiwP5V9aeJcRlsUhURExH7B38sP64HZoCWxgA1Z+G81BG/cnLcWgyTu4NNvyw+nlzR2zvCFcDyQ5ROBvV1BHjMbNEVMzBCVR/kXvntjoEJ76nQ/CAa5tRQfsqXEbnd1J0+8Axa0zaCA5do73XVW38wkVBTtHZe96uhLstBxmeheKe1NK2KjzfyxUgDam3g6pvo5rHetln2PsydasaFeUoVGnQJtMg==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(18096099003)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mJdos45eqV6etMJz/fClM0UMIi8VIcHnd3Qu2P4ilnldhGjxn2TZSJ1ygcelx2dOAG3o/wgt2VaYV6Bh8JooCxBnkDxTS3O6krf+FCOnuIMJY3c0T8eip3QC6ekpZjzwX0sr7niGo4l5P7KcOk0/I7AnADdegnOi3v88xR/XAEVsR6T++4EA4YUXNYI+Jht448ru1jH5krX8uc9GcBz8a1OJ1CE9lY16YuxTqB/rzVNx4r3KxPEol2+0cMhiml5frLwhKu6KM8f/wDvKZUp0qmglfW1u0kSePsiVCSfHR9BNMCf4EnoeaaNPd6pbhin4qNLBZ/qQxKAb+G56VZII2hgeefi61DjRQ5GszhBMbg/Xf9urN0CKt3yN1ZgF3t0rwGwJNFU54xF9iQKK6mmtcQM8z79QDHmAOHhzRsEBdlFCEtm0Kq4xP230BNrp4DGn
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2026 05:30:39.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8944020b-59f4-47d8-d847-08dea4e748cd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4094
X-Rspamd-Queue-Id: CA13647DB35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19629-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]

From: Nimrod Oren <noren@nvidia.com>

Add mlx5_dma_pool alloc/free paths, and wire mlx5_frag_buf allocation
and free paths to use them.

mlx5_frag_buf_alloc_node() now selects an mlx5_dma_pool to allocate
fragments from, instead of directly allocating full coherent pages.

mlx5_frag_buf_free() frees from the respective pool.

mlx5_dma_pool_alloc() keeps allocation fast by maintaining pages with
available indexes at the head of the list, so the common allocation path
can take a free index immediately. New backing pages are allocated only
when no free index is available.

mlx5_dma_pool_free() returns released indexes to the pool and frees a
backing page once all of its indexes become free. This avoids keeping
fully free pages for the lifetime of the pool and reduces coherent DMA
memory footprint.

Signed-off-by: Nimrod Oren <noren@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 185 ++++++++++++++----
 include/linux/mlx5/driver.h                   |   2 +
 2 files changed, 154 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index 918cf027bcbc..5cced45caf36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -97,10 +97,44 @@ static void *mlx5_dma_zalloc_coherent_node(struct mlx5_core_dev *dev,
 	return cpu_handle;
 }
 
-/* Implemented later in the series */
+static struct mlx5_dma_pool_page *
+mlx5_dma_pool_page_alloc(struct mlx5_dma_pool *pool)
+{
+	int blocks_per_page = BIT(PAGE_SHIFT - pool->block_shift);
+	struct mlx5_dma_pool_page *page;
+
+	page = kzalloc_obj(*page);
+	if (!page)
+		goto err_out;
+
+	page->pool = pool;
+	page->bitmap = bitmap_zalloc(blocks_per_page, GFP_KERNEL);
+	if (!page->bitmap)
+		goto err_free_page;
+
+	bitmap_fill(page->bitmap, blocks_per_page);
+	page->buf = mlx5_dma_zalloc_coherent_node(pool->dev, PAGE_SIZE,
+						  &page->dma, pool->node);
+	if (!page->buf)
+		goto err_free_bitmap;
+
+	return page;
+
+err_free_bitmap:
+	bitmap_free(page->bitmap);
+err_free_page:
+	kfree(page);
+err_out:
+	return NULL;
+}
+
 static void mlx5_dma_pool_page_free(struct mlx5_core_dev *dev,
 				    struct mlx5_dma_pool_page *page)
 {
+	dma_free_coherent(mlx5_core_dma_dev(dev), PAGE_SIZE, page->buf,
+			  page->dma);
+	bitmap_free(page->bitmap);
+	kfree(page);
 }
 
 static void mlx5_dma_pool_destroy(struct mlx5_dma_pool *pool)
@@ -142,6 +176,83 @@ static struct mlx5_dma_pool *mlx5_dma_pool_create(struct mlx5_core_dev *dev,
 	return pool;
 }
 
+static int mlx5_dma_pool_alloc_from_page(struct mlx5_dma_pool *pool,
+					 struct mlx5_dma_pool_page *page,
+					 unsigned long *idx_out)
+{
+	int blocks_per_page = BIT(PAGE_SHIFT - pool->block_shift);
+
+	*idx_out = find_first_bit(page->bitmap, blocks_per_page);
+	if (*idx_out >= blocks_per_page)
+		return -ENOMEM;
+
+	__clear_bit(*idx_out, page->bitmap);
+
+	if (bitmap_empty(page->bitmap, blocks_per_page))
+		list_move_tail(&page->pool_link, &pool->page_list);
+
+	return 0;
+}
+
+static struct mlx5_dma_pool_page *
+mlx5_dma_pool_alloc(struct mlx5_dma_pool *pool, unsigned long *idx_out)
+{
+	struct mlx5_dma_pool_page *page;
+
+	mutex_lock(&pool->lock);
+
+	page = list_first_entry_or_null(&pool->page_list,
+					struct mlx5_dma_pool_page, pool_link);
+	if (page && !mlx5_dma_pool_alloc_from_page(pool, page, idx_out))
+		goto unlock; /* successfully allocated from existing page */
+
+	page = mlx5_dma_pool_page_alloc(pool);
+	if (!page)
+		goto unlock;
+
+	list_add(&page->pool_link, &pool->page_list);
+	mlx5_dma_pool_alloc_from_page(pool, page, idx_out);
+
+unlock:
+	mutex_unlock(&pool->lock);
+	return page;
+}
+
+static void mlx5_dma_pool_free(struct mlx5_dma_pool *pool,
+			       struct mlx5_dma_pool_page *page,
+			       unsigned long idx)
+{
+	int blocks_per_page = BIT(PAGE_SHIFT - pool->block_shift);
+	bool was_full;
+
+	if (WARN_ONCE(idx >= blocks_per_page,
+		      "mlx5 dma pool invalid idx: %lu (max %d)\n",
+		      idx, blocks_per_page - 1))
+		return;
+
+	mutex_lock(&pool->lock);
+	if (WARN_ONCE(test_bit(idx, page->bitmap),
+		      "mlx5 dma pool double free: idx=%lu block_shift=%u\n",
+		      idx, pool->block_shift))
+		goto unlock;
+
+	was_full = bitmap_empty(page->bitmap, blocks_per_page);
+	__set_bit(idx, page->bitmap);
+
+	if (bitmap_full(page->bitmap, blocks_per_page)) {
+		list_del(&page->pool_link);
+		mlx5_dma_pool_page_free(pool->dev, page);
+	} else {
+		memset((u8 *)page->buf + (idx << pool->block_shift), 0,
+		       BIT(pool->block_shift));
+		if (was_full)
+			list_move(&page->pool_link, &pool->page_list);
+	}
+
+unlock:
+	mutex_unlock(&pool->lock);
+}
+
 static void
 mlx5_frag_buf_node_pools_destroy(struct mlx5_frag_buf_node_pools *node_pools)
 {
@@ -219,56 +330,64 @@ int mlx5_frag_buf_pools_init(struct mlx5_core_dev *dev)
 int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
 			     struct mlx5_frag_buf *buf, int node)
 {
-	int i;
+	struct mlx5_dma_pool *pool;
+	int pool_idx;
+
+	if (WARN_ONCE(size <= 0, "mlx5_frag_buf non-positive size: %d\n", size))
+		return -EINVAL;
+
+	node = node == NUMA_NO_NODE ? first_online_node : node;
+
+	if (WARN_ONCE(node < 0 || node >= nr_node_ids || !node_possible(node),
+		      "mlx5_frag_buf invalid node ID: %d\n", node))
+		return -EINVAL;
 
 	buf->size = size;
 	buf->npages = DIV_ROUND_UP(size, PAGE_SIZE);
-	buf->page_shift = PAGE_SHIFT;
-	buf->frags = kzalloc_objs(struct mlx5_buf_list, buf->npages);
+	buf->page_shift = clamp_t(int, order_base_2(size),
+				  MLX5_FRAG_BUF_POOL_MIN_BLOCK_SHIFT,
+				  PAGE_SHIFT);
+	buf->frags = kcalloc_node(buf->npages, sizeof(*buf->frags),
+				  GFP_KERNEL, node);
 	if (!buf->frags)
-		goto err_out;
+		return -ENOMEM;
 
-	for (i = 0; i < buf->npages; i++) {
+	pool_idx = buf->page_shift - MLX5_FRAG_BUF_POOL_MIN_BLOCK_SHIFT;
+	pool = dev->priv.frag_buf_node_pools[node]->pools[pool_idx];
+	for (int i = 0; i < buf->npages; i++) {
 		struct mlx5_buf_list *frag = &buf->frags[i];
-		int frag_sz = min_t(int, size, PAGE_SIZE);
+		struct mlx5_dma_pool_page *page;
+		unsigned long idx;
 
-		frag->buf = mlx5_dma_zalloc_coherent_node(dev, frag_sz,
-							  &frag->map, node);
-		if (!frag->buf)
-			goto err_free_buf;
-		if (frag->map & ((1 << buf->page_shift) - 1)) {
-			dma_free_coherent(mlx5_core_dma_dev(dev), frag_sz,
-					  buf->frags[i].buf, buf->frags[i].map);
-			mlx5_core_warn(dev, "unexpected map alignment: %pad, page_shift=%d\n",
-				       &frag->map, buf->page_shift);
-			goto err_free_buf;
+		page = mlx5_dma_pool_alloc(pool, &idx);
+		if (!page) {
+			mlx5_frag_buf_free(dev, buf);
+			return -ENOMEM;
 		}
-		size -= frag_sz;
+		frag->buf = (u8 *)page->buf + (idx << pool->block_shift);
+		frag->map = page->dma + (idx << pool->block_shift);
+		frag->frag_page = page;
 	}
 
 	return 0;
-
-err_free_buf:
-	while (i--)
-		dma_free_coherent(mlx5_core_dma_dev(dev), PAGE_SIZE, buf->frags[i].buf,
-				  buf->frags[i].map);
-	kfree(buf->frags);
-err_out:
-	return -ENOMEM;
 }
 EXPORT_SYMBOL_GPL(mlx5_frag_buf_alloc_node);
 
 void mlx5_frag_buf_free(struct mlx5_core_dev *dev, struct mlx5_frag_buf *buf)
 {
-	int size = buf->size;
-	int i;
+	for (int i = 0; i < buf->npages; i++) {
+		struct mlx5_buf_list *frag = &buf->frags[i];
+		struct mlx5_dma_pool_page *page;
+		struct mlx5_dma_pool *pool;
+		unsigned long idx;
 
-	for (i = 0; i < buf->npages; i++) {
-		int frag_sz = min_t(int, size, PAGE_SIZE);
+		if (!frag->buf)
+			continue;
 
-		dma_free_coherent(mlx5_core_dma_dev(dev), frag_sz, buf->frags[i].buf,
-				  buf->frags[i].map);
-		size -= frag_sz;
+		page = frag->frag_page;
+		pool = page->pool;
+		idx = (frag->map - page->dma) >> pool->block_shift;
+		mlx5_dma_pool_free(pool, page, idx);
 	}
 	kfree(buf->frags);
 }
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 71f7615ab553..531ce66fc8ef 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -343,9 +343,11 @@ struct mlx5_cmd_mailbox {
 	struct mlx5_cmd_mailbox *next;
 };
 
+struct mlx5_dma_pool_page;
 struct mlx5_buf_list {
 	void		       *buf;
 	dma_addr_t		map;
+	struct mlx5_dma_pool_page *frag_page;
 };
 
 struct mlx5_frag_buf {
-- 
2.44.0


