Return-Path: <linux-rdma+bounces-19746-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qIu8HhNn8mkBqwEAu9opvQ
	(envelope-from <linux-rdma+bounces-19746-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:16:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB0D49A075
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 22:16:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 28A64302EABD
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Apr 2026 20:16:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A525F39280C;
	Wed, 29 Apr 2026 20:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NlNQQNMt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F8238E5FA;
	Wed, 29 Apr 2026 20:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777493759; cv=fail; b=VILlfYDcP63lGKwo0zwxqGvKgnRkJkSFFb1uCykSNVJOXGZl475Y+I39wnunQsfXlnEegM6TJtAjMpvLt5jUziN1Q4LawGxJMvDsnt4UkxyamLZHSntt9P9x2SghSTi5O4QuF6w3S7Cbo4DwVTWfK7oPqUFe4qJBgtkSzAKxioA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777493759; c=relaxed/simple;
	bh=al2RXGKb+j5LDXjNGYbr9sxEE0tuS1Q4+i3oOYjDTUQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEaG5PMopFW5xPWLHmPFOAqwRHAOPOYLjOG9sMQ8NgGa7PbGPXSwi1fItPEc1QnLMXKuTCYFHYvEkDlKEeu1SF4rxeE14193LZdBr+MobdylENNrax1Qv7vm35We9FqstTG4xpqKEWuN800CCBtcTeHBnNa1/DITXKdc5hov7Co=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NlNQQNMt; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oob7bvu8TTWo0cSNlIB3WDhuABRMKq3olEnbPybSYnK4gpW2Oy9gOpNfyU7+W93aIz6wDk3Alf0UGmfBdSoAobDJLdQ/CSISjVJ4dcGCj1C67HCHNhP3jpxj0nIXECWj7WhM4D3D6cC+NKiv29/8ewRC0RaSU6L4zRHe4qhyfVSgPsuclznz7llLUcBfQ1WO1Z18zAdY1fotC9h9OmjXhAghJxX6iSWDPzZrKgswtUINULrLNNMruxhQK8mf+cl1BUUBWvkzl/Ejt8tnfe8uBDgXyz+ey5llh/vIdyGqRnqMBunCN/32+kq4dVPiBvKwZOit9ZWq2iAvHnj9jiIkvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgFgPWiXOMsPmeGPpZeVnDj8Ft8a0TrSdiN6nVSFLWc=;
 b=ndCG4lbsC8NS8k1EGYzZda2gAGCz94VJ7Q0IJWaI6DaR69Lo1wXoR/DqswNILtoijMukpf3rO2QucgP7Z8vF0/g4Xkn8KlxiY5iUSIa6XFV2zSHJXKXWJF4ZEPiClUNRyARMbTscV1wxpPeRNjKNdCUnCFnUxAYm8QL3tob2W+1hbypL+v3bciyhX/pxddM/fyNYHeRyxvqL9tcZJUyiv/IvreHsxOQOwB0HovoliScz7JkBTeHBWFXQ88MG9heGbme/MiO5yKQmezKI827xFmNd2O5QSwigfr4ssMrgoJOSHfA5+ioYj+nGdBX6hzB6arnUtnQavE0n2kuK2B6Wwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgFgPWiXOMsPmeGPpZeVnDj8Ft8a0TrSdiN6nVSFLWc=;
 b=NlNQQNMtlJZYiLgpYYxcBllWOfP/3mv6M8dZPQvIr1zXoRlTIWIuf8JKdcV9q+kpfwZy1LuX65N101AD+OIgvFghDwJbaMUtS7Uw+bynJxzxKQDwr2yRc6IyyMVo2V2yMNDTaQ9rjF/OzGLvgbEbPUOOHhnkFxk1kRfXqTBr92fIxgvZsKXiOi+Xe3MXnI7LZXWCQIiVZMm2SQYHoN845uxqcPYrvvIsw1ZHLjlGSLj+Z7SBg7nfo80r+3kqvh+rOmWo5bvYJMhfQzmhvd04AJCrEtjxISADVUtmNC9gNNaxemfEKmqJxNhddejuD+OTDujHkwa1U+DMrfYD2SBPBw==
Received: from DS7PR07CA0022.namprd07.prod.outlook.com (2603:10b6:5:3af::24)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Wed, 29 Apr
 2026 20:15:53 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:5:3af:cafe::f) by DS7PR07CA0022.outlook.office365.com
 (2603:10b6:5:3af::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Wed,
 29 Apr 2026 20:15:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 20:15:52 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Apr
 2026 13:15:36 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 29 Apr 2026 13:15:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Wed, 29 Apr 2026 13:15:32 -0700
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
Subject: [PATCH net-next V2 3/3] net/mlx5: use internal dma pools for frag buf alloc
Date: Wed, 29 Apr 2026 23:14:29 +0300
Message-ID: <20260429201429.223809-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260429201429.223809-1-tariqt@nvidia.com>
References: <20260429201429.223809-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 270745b3-b55d-4a13-9e0f-08dea62c1d28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	aCL6RD3f/ZprNYHUUZRcOxPoM/rV/YThBpdm3vYR0TESxZ/u9W1ljRwrlBGgllZR66YmMTfMGDqCTeF++6PLcdNOtDqkY3lL0GAcWHcKAa6+sN9mZ2Fs4SIFpYCeyvRiN9IjkKx+svvKSedfxTVTMV9H0pWo2Pg2HIoq3OwRfK8KwIlt28C3Aj+INaPZ3x3mzYvTBMI79r3NYA1afgjj3lUZQu9uiTgTHObSnjMddlOn2MpPb0Iy9SXYlh91c2iCCudp+lp3NuWR+7JA3l7kcBd8plsYE6/ufXNr4QCyNqey6I6rTxfrXZN/rarYWJ62t3bofL0XsimjBsFjv1cXLMCMyeeeVaP/kTCgSc4Dq23KAhef9G0WK65EVKubXyjlumPvNHgBXSZObsfgtZU3gEEoSil+GxRtFyHtgKShCzQ6cGQuHYLekKTe+XWQ2jqxsopm4afP4PV8nF4IKnS9IeK3Ga3YbloASOVjTxk1vCQeOwpGykq9tbfbFV6ZVU0oSJ1K5mzCSN90tFdHsgIBO7Fd9JgTSlFIzbq6G3adGPgRyFoSjn1uvLqNp+85AJVu17WKsd8up32NOVpp9WXYMVc0LUsnV7a8blcXbspKdd/4MDoMjnQk0pSyi+ykOc2MCxPG8xiNsDgiN0NrNWFwPDVUm1xsNugzhi2b+qOArYYAsf8iqEOQ4HUzTbGyRvwzYCKo/Efz/6OWMhg9m+OM8MPzdxL44DDm9rpVMGNtLPqndNWt+CT8f8HwuRbSj93Rn1jpBLg8Dm2loNprd5Heiw==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	pskLJ+2Ao1TbBEqsvGSu73IBTWgEvDeA0wGNzGheur3/2vfyKVBN2GDRX9YEIcrVhT2UJknDgjjTpPAAWlx9qbYYxRhvjcLrw/Eg7TRWWsihYi9K4OmWZuDmYNvQAtG/yCVKfAaT0Rc9m8Li/0l/IhyfayX9n/djEjzjfy/jDp51/KNuVuSDfGhtQgaZtNhqLmvXXLbEpGdfjeHFF6EOvp+60abGUYrZ/v2UVL0ojyCqO+yUKD0bouoKmVPi41LlPNdJ47gSyOKE0AsF6g4/suKg7gv9revn41snXJ3Rg31I0uEqsMjDhcG7jhNE6ipLs+Nqi7Cgu505/YZjxNJAIGdRBW6UuhNEPsU3LnZW2cPI5hEzeYhZwItgVvzE4DXdst+LyCKTnAxCO6izETCuAGIWy/tYV4dG3xJVmmRvbaGk8m2qeShcFfkDu7z3J1FD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 20:15:52.9683
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 270745b3-b55d-4a13-9e0f-08dea62c1d28
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737
X-Rspamd-Queue-Id: EAB0D49A075
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-19746-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-1.000];
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
 .../net/ethernet/mellanox/mlx5/core/alloc.c   | 170 ++++++++++++++----
 include/linux/mlx5/driver.h                   |   2 +
 2 files changed, 140 insertions(+), 32 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
index fcc859c5f810..f19644183828 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/alloc.c
@@ -120,6 +120,111 @@ static struct mlx5_dma_pool *mlx5_dma_pool_create(struct mlx5_core_dev *dev,
 	return pool;
 }
 
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
+static void mlx5_dma_pool_page_free(struct mlx5_core_dev *dev,
+				    struct mlx5_dma_pool_page *page)
+{
+	dma_free_coherent(mlx5_core_dma_dev(dev), PAGE_SIZE, page->buf,
+			  page->dma);
+	bitmap_free(page->bitmap);
+	kfree(page);
+}
+
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
+	mutex_lock(&pool->lock);
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
+	mutex_unlock(&pool->lock);
+}
+
 static void
 mlx5_frag_buf_node_pools_destroy(struct mlx5_frag_buf_node_pools *node_pools)
 {
@@ -197,56 +302,57 @@ int mlx5_frag_buf_pools_init(struct mlx5_core_dev *dev)
 int mlx5_frag_buf_alloc_node(struct mlx5_core_dev *dev, int size,
 			     struct mlx5_frag_buf *buf, int node)
 {
-	int i;
+	struct mlx5_dma_pool *pool;
+	int pool_idx;
+
+	node = node == NUMA_NO_NODE ? first_online_node : node;
 
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


