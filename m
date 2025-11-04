Return-Path: <linux-rdma+bounces-14228-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 411E7C2F7D7
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 07:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CF824200DF
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 06:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 499A52DAFB8;
	Tue,  4 Nov 2025 06:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="k9IqMODd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010008.outbound.protection.outlook.com [52.101.201.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BB6B2D979D;
	Tue,  4 Nov 2025 06:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238961; cv=fail; b=Q7c4hO3TIUmefe3z15ppVXN4zUkRmOdEUiBoPS9svVhcR+dT7QI/MnS7Cjt4pG7eBp5CWWIF50WIH+lj0TToZpK+WShTuLYhWLYXQlb8tDJjRAo5yqVNQHBl8exBQG/+Pgxym7RDyzDIsp/h3J7PKzrOadQoyYukqLOGzqISdOw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238961; c=relaxed/simple;
	bh=lKUurM2B8QtlDnNsZu9wtcYUCVadzawruYaOT8y4ujA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q8i5+3Q0IFmzK7Jl4XmXREts0eRdm41pYHN7LtBSsnImrXclIhTxGso1w+QlmKJsMXCWhd88jPhAhgHAp4DIkQEtukaLq/wMX2D0s11GeQPk3iEZK3VbTULGY1UUkhlJsxvLcuHhUV80ghJtpiLD+HIQ8+Ep4smXwJhAzXFbBgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=k9IqMODd; arc=fail smtp.client-ip=52.101.201.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7QtFiAHCLhkwav0mBIY/UwEunAWR2VWkSW6iZsg1Qa8paU3ajnk4Btd989Q43Tv70l7X/emmIMFNPpYNAH9gIpAAU/sGe51999QStT88l41g0DU4cyjCh+IYS1HQCx5Xjf8zsk1sV5B55BNEmj42xvOj/HTsjd+nOt4jg+rNJZyORUxOKiD4GYjqF8/+hbd9STcaSnQOrCUieOidF5DA5bMFbT/RFLymNIn/QtApjNe5k1HWygFAWHF6nN3PZLueqrQVfhNqKxOLB6IdjBo5AXaQnq7nXSeVja3Mw4b0yfUCfvNxAvVjFErwdDR0BjSuOZ5wL9cbx9HY/CehSeFzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXr4s/0bZyZu9zq9zpShD4OIU/G5Z80/pQqSKM3WFSs=;
 b=jVPy05YpWjfy7vJR5pgwVoXdMQAxhCDT9+kjABpNKv2FxAjI5E+uCZpYo0ueJU8+GIQdGRri5aWSF+FVTf2aU/hQJyfheWOj1Qrc2JeAQ+tXxDAgoUsI6Xy+suQ24YF2o6WWnlAa14aysSMs3eIMk2rI1nOpe6JodtuAdNBLvJA3yYpY48kvhfPxyLxfCaVRQ7IiQeho3ve9tOjzQQ0OBcf6g/kTLTfYsAcgjVS+gWsXUbJdyQ9kCCRTmJxdLDf9SxM7Z6VMdNy8ehyuoLqQgdu0lrYS8bFjyyyisQie2M/ubr2SP0c8KPIniNmCpUGTcqFcEhPRLai0ZEWOrWFCwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXr4s/0bZyZu9zq9zpShD4OIU/G5Z80/pQqSKM3WFSs=;
 b=k9IqMODd8xn7SMbZIjPCz38dFdQDE7ZW1EwhB9ChgTkHfXeHAAUe558v9gZyfdL68KrwVtCXtqKPZYuM/Km66uQzkvoyo6GzR5F3dlZ2DrZ7hcksBMWOW+mrv7vO6PxB9MJQp/Kwv4IMVXJsckitONMkrA2U9oA1P7imvLvfM8uQ3+wnvBx7kNyke6/TBZzJsTCbJBcp3VLFI1/52X43bFxMxexnTfc5R/jQT0rC7km179I5Ysi+b+Cu+jvNVykWs0L9KiDNaU3wI8hUBsE8RXIZgmMeI+XjOEKnScmm2D4Owp6t6r4YIWf8oI01JjskOU08vCIt7c0ADEOv0yIzYg==
Received: from CH2PR02CA0005.namprd02.prod.outlook.com (2603:10b6:610:4e::15)
 by IA4PR12MB9761.namprd12.prod.outlook.com (2603:10b6:208:550::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Tue, 4 Nov
 2025 06:49:15 +0000
Received: from CH1PEPF0000AD79.namprd04.prod.outlook.com
 (2603:10b6:610:4e:cafe::ee) by CH2PR02CA0005.outlook.office365.com
 (2603:10b6:610:4e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 06:48:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD79.mail.protection.outlook.com (10.167.244.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:49:15 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:49:03 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Nov 2025 22:49:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 22:48:59 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net V2 3/3] net/mlx5e: SHAMPO, Fix header formulas for higher MTUs and 64K pages
Date: Tue, 4 Nov 2025 08:48:35 +0200
Message-ID: <1762238915-1027590-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
References: <1762238915-1027590-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD79:EE_|IA4PR12MB9761:EE_
X-MS-Office365-Filtering-Correlation-Id: 69f85208-9760-48a3-4a6d-08de1b6e4519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R0O+jYOpG9PFsXSZWy3D9KraozgMRFRwtrhx0KvnJsBnIcqhp3FTlHUS91VA?=
 =?us-ascii?Q?u64GLCVhDom3teTVR+eNqTXRMNNNe7pKyAWJhZi3Lgd2Kh1+UIMZGYMkmBl1?=
 =?us-ascii?Q?dZH2TMPuSmKQx4PChWVTIZX94PqElVEhavWQi6/3lnfo/h67YZwOT1PgsVWv?=
 =?us-ascii?Q?JO5qQKoKMUYgMlyjqzejZVDRbze/rOHSu7qG7rL+gEsDrJ6jjuN41ar8eyRx?=
 =?us-ascii?Q?/Cc0J+spC90D4sGTEG19fOLk30zCIr8sHLIW610fXN7pfE+ZFYpOSH29Uir4?=
 =?us-ascii?Q?fqlGwiKUZvmkKMzLZTP9ZddPy8V8v73Zx5I0nWUEDhCWNBNWbJFcERAoFr3K?=
 =?us-ascii?Q?oJQtN37IEUSq+ctSjtibQ0p0ku0IbSi+Sf9BCA1kKZZ4d9SF75xTHE85r73G?=
 =?us-ascii?Q?+ByszL7hdKn0AIidAkUZW7ksUyExeKOrKnzVs9Rk6erV/EodfCW3Jxwd6cBW?=
 =?us-ascii?Q?q3ZOcCsbPPaDhjFhWJgZNzZEWyUiqui8lfFMaAd5t7lvlLWyFZi/wbM4sEkH?=
 =?us-ascii?Q?vFBybcZAdIp0WL+gMjYiDoImgjM0wG+V4MLZjmlDeTgVnWylnfY6/0YiIXeH?=
 =?us-ascii?Q?UrlO204sezaX6RCxM4y3uTw+m/zTP+Bkbly/arrhDQqEpKxBPXuTNX/1qvRz?=
 =?us-ascii?Q?zMp5y7O6YCLeEiNo5BGJe6GE1F4dukA6Hc+bbfd8qJzIDOWqN/Fy0iWaGjIr?=
 =?us-ascii?Q?/uKJuRqkaP3E+pI571e2Bc3nfxiMcgQ+WxJZkEZPUREvz9nSkGvZA+UA09mA?=
 =?us-ascii?Q?emWGiCOR9yA8VsRArVCordxjK/AhGKeX8NTDqe0Jv7Y93G98Jetrj8kEzx8Y?=
 =?us-ascii?Q?aXzjTNydndR3DQb9QkmHvIsZecKSoXa85OimI7G/T0IpwFO9S3VJO6djSyNU?=
 =?us-ascii?Q?m3P3PEji3NTozqzmuPex5IEi4TUrMrgAIn/wdLRDamAuRTVo6EGHjTS1+OMs?=
 =?us-ascii?Q?qshjr++mqlaUTOrorVGj1k+EDXQn7YInJlW3H6P97/sIan5DG5NXpsbscms/?=
 =?us-ascii?Q?bU5IezXfs5X3PMhZK42vaHj0oFrvP4ZXi35ATxQyEFC7bje9oFAx3C1ZGyBY?=
 =?us-ascii?Q?Ur57zpfwzqFqscQh7W0V05vesHazgmBpNuCJ+aYjhoPW9BJIycbeIMKVWSsO?=
 =?us-ascii?Q?Vnmsb6czmhB3qSeVQvnfXMdyDLLmEMd726qyx+rJwUU8xN+C9UVYtknCvUhm?=
 =?us-ascii?Q?/wg0kR/D+fiCLa9RwtBFcRJ0+E9OKmyoEMnp/zjmy4DAqr3mUD2dCOJX1Eli?=
 =?us-ascii?Q?tnfslLMV0Ql4rcHznl5UcVR1vNbwdZfwf4yhOL0dPZApVH+WCRYVckUX83eZ?=
 =?us-ascii?Q?/P5+UwgNmVG980eh3k1tfcKKcKY4s63aCGI4v2NcVVNaP5PXsEc5moVnzbgT?=
 =?us-ascii?Q?bgN7dk/G6ZyRH7NGWRQu/to5fGrbECa4lxJgRjIaO0LfjTOY1Gxhrm8C3qVt?=
 =?us-ascii?Q?Nv81aQDMOgOyvnDH8Hx2VsxEX1X7iJwgbkDOPvgj5zEMjChyWAx1h1mT2xaf?=
 =?us-ascii?Q?OQweKfvgBqq+YuK7Sx/w4VANpRq7SCs65GJOz07rol4mhMIYaD0rQvuPubBP?=
 =?us-ascii?Q?vntnd12bdjghuDx+Mxs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:49:15.1553
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69f85208-9760-48a3-4a6d-08de1b6e4519
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD79.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9761

From: Dragos Tatulea <dtatulea@nvidia.com>

The MLX5E_SHAMPO_WQ_HEADER_PER_PAGE and
MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE macros are used directly in
several places under the assumption that there will always be more
headers per WQE than headers per page. However, this assumption doesn't
hold for 64K page sizes and higher MTUs (> 4K). This can be first
observed during header page allocation: ksm_entries will become 0 during
alignment to MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.

This patch introduces 2 additional members to the mlx5e_shampo_hd struct
which are meant to be used instead of the macrose mentioned above.
When the number of headers per WQE goes below
MLX5E_SHAMPO_WQ_HEADER_PER_PAGE, clamp the number of headers per
page and expand the header size accordingly so that the headers
for one WQE cover a full page.

All the formulas are adapted to use these two new members.

Fixes: 945ca432bfd0 ("net/mlx5e: SHAMPO, Drop info array")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 24 +++++++++++---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 33 +++++++++++--------
 3 files changed, 41 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 14e3207b14e7..a163f81f07c1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -634,7 +634,10 @@ struct mlx5e_dma_info {
 struct mlx5e_shampo_hd {
 	struct mlx5e_frag_page *pages;
 	u32 hd_per_wq;
+	u32 hd_per_page;
 	u16 hd_per_wqe;
+	u8 log_hd_per_page;
+	u8 log_hd_entry_size;
 	unsigned long *bitmap;
 	u16 pi;
 	u16 ci;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 9c46511e7b43..6023bbbf3f39 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -791,8 +791,9 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				int node)
 {
 	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u8 log_hd_per_page, log_hd_entry_size;
+	u16 hd_per_wq, hd_per_wqe;
 	u32 hd_pool_size;
-	u16 hd_per_wq;
 	int wq_size;
 	int err;
 
@@ -815,11 +816,24 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	if (err)
 		goto err_umr_mkey;
 
-	rq->mpwqe.shampo->hd_per_wqe =
-		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
+	hd_per_wqe = mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
 	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	hd_pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	BUILD_BUG_ON(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE > PAGE_SHIFT);
+	if (hd_per_wqe >= MLX5E_SHAMPO_WQ_HEADER_PER_PAGE) {
+		log_hd_per_page = MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE;
+		log_hd_entry_size = MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
+	} else {
+		log_hd_per_page = order_base_2(hd_per_wqe);
+		log_hd_entry_size = order_base_2(PAGE_SIZE / hd_per_wqe);
+	}
+
+	rq->mpwqe.shampo->hd_per_wqe = hd_per_wqe;
+	rq->mpwqe.shampo->hd_per_page = BIT(log_hd_per_page);
+	rq->mpwqe.shampo->log_hd_per_page = log_hd_per_page;
+	rq->mpwqe.shampo->log_hd_entry_size = log_hd_entry_size;
+
+	hd_pool_size = (hd_per_wqe * wq_size) >> log_hd_per_page;
 
 	if (netif_rxq_has_unreadable_mp(rq->netdev, rq->ix)) {
 		/* Separate page pool for shampo headers */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index f2a06752ce37..687cf123211d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -648,17 +648,20 @@ static void build_ksm_umr(struct mlx5e_icosq *sq, struct mlx5e_umr_wqe *umr_wqe,
 	umr_wqe->hdr.uctrl.mkey_mask     = cpu_to_be64(MLX5_MKEY_MASK_FREE);
 }
 
-static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq, int header_index)
+static struct mlx5e_frag_page *mlx5e_shampo_hd_to_frag_page(struct mlx5e_rq *rq,
+							    int header_index)
 {
-	BUILD_BUG_ON(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE > PAGE_SHIFT);
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 
-	return &rq->mpwqe.shampo->pages[header_index >> MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE];
+	return &shampo->pages[header_index >> shampo->log_hd_per_page];
 }
 
-static u64 mlx5e_shampo_hd_offset(int header_index)
+static u64 mlx5e_shampo_hd_offset(struct mlx5e_rq *rq, int header_index)
 {
-	return (header_index & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) <<
-		MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE;
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
+	u32 hd_per_page = shampo->hd_per_page;
+
+	return (header_index & (hd_per_page - 1)) << shampo->log_hd_entry_size;
 }
 
 static void mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index);
@@ -684,7 +687,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		u64 addr;
 
 		frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
-		header_offset = mlx5e_shampo_hd_offset(index);
+		header_offset = mlx5e_shampo_hd_offset(rq, index);
 		if (!header_offset) {
 			err = mlx5e_page_alloc_fragmented(rq->hd_page_pool,
 							  frag_page);
@@ -714,7 +717,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 err_unmap:
 	while (--i >= 0) {
 		--index;
-		header_offset = mlx5e_shampo_hd_offset(index);
+		header_offset = mlx5e_shampo_hd_offset(rq, index);
 		if (!header_offset) {
 			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 
@@ -738,7 +741,7 @@ static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 	ksm_entries = bitmap_find_window(shampo->bitmap,
 					 shampo->hd_per_wqe,
 					 shampo->hd_per_wq, shampo->pi);
-	ksm_entries = ALIGN_DOWN(ksm_entries, MLX5E_SHAMPO_WQ_HEADER_PER_PAGE);
+	ksm_entries = ALIGN_DOWN(ksm_entries, shampo->hd_per_page);
 	if (!ksm_entries)
 		return 0;
 
@@ -856,7 +859,7 @@ mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 {
 	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 
-	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
+	if (((header_index + 1) & (shampo->hd_per_page - 1)) == 0) {
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 
 		mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
@@ -1223,9 +1226,10 @@ static unsigned int mlx5e_lro_update_hdr(struct sk_buff *skb,
 static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
+	u16 head_offset = mlx5e_shampo_hd_offset(rq, header_index);
+	void *addr = netmem_address(frag_page->netmem);
 
-	return netmem_address(frag_page->netmem) + head_offset;
+	return addr + head_offset + rq->buff.headroom;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -2265,7 +2269,8 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	u16 head_offset = mlx5e_shampo_hd_offset(header_index);
+	u16 head_offset = mlx5e_shampo_hd_offset(rq, header_index);
+	struct mlx5e_shampo_hd *shampo = rq->mpwqe.shampo;
 	u16 head_size = cqe->shampo.header_size;
 	u16 rx_headroom = rq->buff.headroom;
 	struct sk_buff *skb = NULL;
@@ -2281,7 +2286,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 	data		= hdr + rx_headroom;
 	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
 
-	if (likely(frag_size <= BIT(MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE))) {
+	if (likely(frag_size <= BIT(shampo->log_hd_entry_size))) {
 		/* build SKB around header */
 		dma_sync_single_range_for_cpu(rq->pdev, dma_addr, 0, frag_size, rq->buff.map_dir);
 		net_prefetchw(hdr);
-- 
2.31.1


