Return-Path: <linux-rdma+bounces-11092-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 905ABAD21C0
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jun 2025 17:05:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 371C418903F1
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Jun 2025 15:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE86821CC60;
	Mon,  9 Jun 2025 14:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gPh//ir8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55381B425C;
	Mon,  9 Jun 2025 14:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749481191; cv=fail; b=K9O9TJOH7Nm1ezjajI6tKV+K77vSqofsNOoLbJB6tWzBnVchvNAjqw7vRsxO7R6nOW8ucvmJDv4M9FoPVa9fdPndGmav2sMK87WGUtzlZoaIfjR0NqPYP9TcSv4eMyRSNCSg6tgY5oVUbpV6o5PA6G5kkKwigGuTigcl+e83qsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749481191; c=relaxed/simple;
	bh=udq+3o5ZtYamRoeM1huBcSpYT2n1uJTiwgb8yhgZkg0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k6nII7clSs1PJRL4O0YNioWWmzQWBSmuUf/o7rBHI0xHVdP8CULd0IhwjAzhzBIrMk7SxY5SYkD7Js8qMgtoXvjceb92SBpHle0F0yUbmijlKaesE341SL0tvWwHm/X5BlMiVQHe+kJqBw22UyEkIUlhQ2PNa6yuDx0j2xNTN+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gPh//ir8; arc=fail smtp.client-ip=40.107.244.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=infuvVAwHTbXxiu87I4RQY1Jj9eU+8V7DTVVoyuBY/8ATUE2QV0xuIk02ZKzyAB/Tt9Dq0lyYNhOZ6TfihONKDvDtVQP5Zegz5sgNuwAU6JyVBcVixHMzlRuBmd0lCYB/FGNWLMzefC9l+H8/ss/uf8pse0bJxYiSAIRMG/j34Lokp3RXo1br5mk/d+dJvfvF7t50QtwnGXXB6Yb/M88nJxrbcaQYHlVV6VDxzpbyEbb75ncSdhGxodqRqw2Q2fdLL8s6jAoen9inQZW19Xkw5cSUV4SqBoOaJMX8qE7yQm1IkskOJ9DwkV/I1BPruvyGRpPZJY1plbqjUQ2bhPxvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dsH3dcWUuviSyLvD16PIq0Dl8w+NXzoh610l+FCu6N4=;
 b=P9we1lnDpYjm6H3nojCCZYkyBo8NU2gXh/onFFgvYGg9IzzXXNavNxzpkaW5Q+aTW8J8mMB2k4l9A7DtFzHlMDH7yRfst7E+kYd1ces1hd31FT0VU9TMbzVljJZs7oBQoiY1mfFezn0wjEbnyZRN+KlDAoAW/5+pURH8oJbJfzX4FK3fYDkLcVfhBNPYVTDwklAOUMlCu+Wl3Awh7BZuJYwPAT36nFFfeNvtr+/f+ZLAahDBNPU8Ze06V2AIj+8P0nhvfdK/IWvaokFsq9uJzJSKSQ/TGwlr+ZdIx1vruWFfvet75qx5o0YhWXLPYkAJVVEk0P3FQl6BS2cwXBziOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dsH3dcWUuviSyLvD16PIq0Dl8w+NXzoh610l+FCu6N4=;
 b=gPh//ir82o9uq9jcgR4T3+yznQrvJBglDPqQWRHSQMwVZKhPGJ2WJjdAgf8289dLl1a3GBOwVADPXmS6Zc1YIR/hY9SJOkiSu/ZnF2bbAb9tvotmRk4WeJjNvssrSqxrfg5obWiCdxQqzO6ajveUku1/WxGdzjc5iCKQ0AdMu877uRcJUuFzbDT4kBqpXmjCveKd7BlgWtjtMac8MJskZIEJRWOnkT2VtXUgTuYU9LkiEeRYLuqgFXitqgb3sFtsF8Fx8hOmOIBR8aWhRGOU/0CGw/AiRpXAuB0ShOgcI0jCBFsVJ15Q0mzSufQHlEKIDGfwaX3R5qlybFQpR+cfAQ==
Received: from CH0PR03CA0252.namprd03.prod.outlook.com (2603:10b6:610:e5::17)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.36; Mon, 9 Jun
 2025 14:59:43 +0000
Received: from DS2PEPF00003445.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::3f) by CH0PR03CA0252.outlook.office365.com
 (2603:10b6:610:e5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.27 via Frontend Transport; Mon,
 9 Jun 2025 14:59:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF00003445.mail.protection.outlook.com (10.167.17.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Mon, 9 Jun 2025 14:59:42 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Jun 2025
 07:59:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 9 Jun
 2025 07:59:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 9 Jun
 2025 07:59:20 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Simon Horman
	<horms@kernel.org>, Richard Cochran <richardcochran@gmail.com>, "Alexei
 Starovoitov" <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	"Jesper Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<bpf@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v3 06/12] net/mlx5e: SHAMPO: Separate pool for headers
Date: Mon, 9 Jun 2025 17:58:27 +0300
Message-ID: <20250609145833.990793-7-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250609145833.990793-1-mbloch@nvidia.com>
References: <20250609145833.990793-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003445:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cacb90-1abe-4b40-b5ec-08dda7664450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Fpd1rq3vRLyuGNSl6uqygMQuAlCsnv5UQtFdjg/DgvgCKCSWEX7q+GtvCsuO?=
 =?us-ascii?Q?C/AR0p0vb552SD2cLz5KXcn5rWa5FKkULLEW2+PrDyYj4Ton9fAAwxWLrAZU?=
 =?us-ascii?Q?a8fVH73O5I7PiXOwPhOez99uzDfhVoeypLcAVeAVt5oI06pgwFpVwNpxgdi6?=
 =?us-ascii?Q?iDwL6HJ7XksO+gpdPk4Y0RsxGlDGFhxr2Xd19DPTzA8M5znwJ227ptWR022l?=
 =?us-ascii?Q?ByIP8ktFlK0i3x76o8VwDLbTNjCmFGGKLX93J6b8O4v+uyrMmcO7XS10dveC?=
 =?us-ascii?Q?ryaydETaSJKZlAA7klsQzu0Er+Qlc336KR27oHYWf84QT9UiDMs1xBQ/cx+G?=
 =?us-ascii?Q?lL+Du4aMckJMFzyI2v9eHuiUvGfkAmHgA06Uk4MtKMRVskuyVnJbREWYW4Ya?=
 =?us-ascii?Q?mtvNM5cJo8Dv547Diwd8Es7/ojr6/bdDiRNG9SMHHX2bxNkOIQKe1Aj8fxAj?=
 =?us-ascii?Q?IBJA+IFZEbLN+PIbTonek+DH1B35DA0BlCNNQmyeBEVN68n/OF04pUxVMhhz?=
 =?us-ascii?Q?SJO3cKWhIP63HlPHxVyX97UW69EIR82OiaV9T4xx0mJqlgJ68NwehKk1an9e?=
 =?us-ascii?Q?s2y93MDu2ihGVrHVonJb6hV0WRT0IeeSCpnhowPayokwWFa4O2spWBU76rlB?=
 =?us-ascii?Q?9eCf+eO7neO6nzRosZbSsxyv/yGQdeRvNfY41ByTXwkgxu8iat6YyOv7XLEo?=
 =?us-ascii?Q?a0APkhPBO6GH9mD5zRwc49j2VbW3U2fUA1a4cClE1F6C0045O6+wGcJCJ+wi?=
 =?us-ascii?Q?UEoxNRq3wz+eya3ePnc9z5piD/Psmda5Bl4G60d3117MJjvGY+x7mBk1uj1b?=
 =?us-ascii?Q?8GacH6nPl0pE1iBL1+d402icKHilRtLXF7EyOLiqZ7o8bGG7hInyxzBmyqr5?=
 =?us-ascii?Q?fJmV6u7njXsBYwNksE2Uwkq1Y0BON4P0qZMwBDPFtZTTCQuT2MSmAVR3RIFs?=
 =?us-ascii?Q?ko7Yo+RQW15kaJHYg7+MKdsz1AcN3MKMxERpBE7+Ux8e7OFGrfgQQPIOB/5o?=
 =?us-ascii?Q?yqVnukjtNa3SRDZuwRvqOLPLXIv3KP+NL/SEIvgeiEk1VfV5FKxnU/AlGoTw?=
 =?us-ascii?Q?MWu67sBFuskck+E9BOuvsRLSbayuN0McuK3GxFCocfUr5Ta6huhQPXGXtnfF?=
 =?us-ascii?Q?8EUnx7DP9AyOKLflbirxULQYLIkGeHb1MoBTabknGnpJxnzyxa85DFYFfFSs?=
 =?us-ascii?Q?0gSGEofKlOTumqVjIC2GpdCUCrmTntlwX5L6CsTnP4dTFZP5zv3c9Rp1wPEI?=
 =?us-ascii?Q?1QDR7yYjtyeS5ZobmFM7ypmU4R99ikpTentL6bvyQQRm0tek7kLUBzXSkn+k?=
 =?us-ascii?Q?BbA/FPseq/49XRLeuwxX1fyRJYqeiuzBseGfi4KLqNM7cEnos/LNvm7AgiMl?=
 =?us-ascii?Q?5vCwgQ2RCgDliaMEMLpXT52DA0IL/0qKgq91ggw95YB2WIukw5iI87FcSL91?=
 =?us-ascii?Q?5FZ9dJDzRHlWWslpN6sh+62YMqNFP6xLpFkukYRr0N/6cdfQ7nx7uROHz1sy?=
 =?us-ascii?Q?JXHZraWHhSBsLARoyX4Zoss/q7q+ZEoe7MgC?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 14:59:42.9639
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cacb90-1abe-4b40-b5ec-08dda7664450
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003445.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

From: Saeed Mahameed <saeedm@nvidia.com>

Allow allocating a separate page pool for headers when SHAMPO is on.
This will be useful for adding support to zc page pool, which has to be
different from the headers page pool.
For now, the pools are the same.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 ++
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 43 ++++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 41 ++++++++++--------
 3 files changed, 69 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 581eef34f512..c329de1d4f0a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -716,7 +716,11 @@ struct mlx5e_rq {
 	struct bpf_prog __rcu *xdp_prog;
 	struct mlx5e_xdpsq    *xdpsq;
 	DECLARE_BITMAP(flags, 8);
+
+	/* page pools */
 	struct page_pool      *page_pool;
+	struct page_pool      *hd_page_pool;
+
 	struct mlx5e_xdp_buff mxbuf;
 
 	/* AF_XDP zero-copy */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index a81d354af7c8..5e649705e35f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -41,6 +41,7 @@
 #include <linux/filter.h>
 #include <net/netdev_lock.h>
 #include <net/netdev_queues.h>
+#include <net/netdev_rx_queue.h>
 #include <net/page_pool/types.h>
 #include <net/pkt_sched.h>
 #include <net/xdp_sock_drv.h>
@@ -746,6 +747,11 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 	bitmap_free(rq->mpwqe.shampo->bitmap);
 }
 
+static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
+{
+	return false;
+}
+
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				struct mlx5e_params *params,
 				struct mlx5e_rq_param *rqp,
@@ -754,6 +760,7 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 				int node)
 {
 	void *wqc = MLX5_ADDR_OF(rqc, rqp->rqc, wq);
+	u32 hd_pool_size;
 	u16 hd_per_wq;
 	int wq_size;
 	int err;
@@ -781,8 +788,34 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	rq->mpwqe.shampo->hd_per_wqe =
 		mlx5e_shampo_hd_per_wqe(mdev, params, rqp);
 	wq_size = BIT(MLX5_GET(wq, wqc, log_wq_sz));
-	*pool_size += (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
-		     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+	hd_pool_size = (rq->mpwqe.shampo->hd_per_wqe * wq_size) /
+		MLX5E_SHAMPO_WQ_HEADER_PER_PAGE;
+
+	if (mlx5_rq_needs_separate_hd_pool(rq)) {
+		/* Separate page pool for shampo headers */
+		struct page_pool_params pp_params = { };
+
+		pp_params.order     = 0;
+		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV;
+		pp_params.pool_size = hd_pool_size;
+		pp_params.nid       = node;
+		pp_params.dev       = rq->pdev;
+		pp_params.napi      = rq->cq.napi;
+		pp_params.netdev    = rq->netdev;
+		pp_params.dma_dir   = rq->buff.map_dir;
+		pp_params.max_len   = PAGE_SIZE;
+
+		rq->hd_page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(rq->hd_page_pool)) {
+			err = PTR_ERR(rq->hd_page_pool);
+			rq->hd_page_pool = NULL;
+			goto err_hds_page_pool;
+		}
+	} else {
+		/* Common page pool, reserve space for headers. */
+		*pool_size += hd_pool_size;
+		rq->hd_page_pool = NULL;
+	}
 
 	/* gro only data structures */
 	rq->hw_gro_data = kvzalloc_node(sizeof(*rq->hw_gro_data), GFP_KERNEL, node);
@@ -794,6 +827,8 @@ static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
 	return 0;
 
 err_hw_gro_data:
+	page_pool_destroy(rq->hd_page_pool);
+err_hds_page_pool:
 	mlx5_core_destroy_mkey(mdev, rq->mpwqe.shampo->mkey);
 err_umr_mkey:
 	mlx5e_rq_shampo_hd_info_free(rq);
@@ -808,6 +843,8 @@ static void mlx5e_rq_free_shampo(struct mlx5e_rq *rq)
 		return;
 
 	kvfree(rq->hw_gro_data);
+	if (rq->hd_page_pool != rq->page_pool)
+		page_pool_destroy(rq->hd_page_pool);
 	mlx5e_rq_shampo_hd_info_free(rq);
 	mlx5_core_destroy_mkey(rq->mdev, rq->mpwqe.shampo->mkey);
 	kvfree(rq->mpwqe.shampo);
@@ -939,6 +976,8 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 			rq->page_pool = NULL;
 			goto err_free_by_rq_type;
 		}
+		if (!rq->hd_page_pool)
+			rq->hd_page_pool = rq->page_pool;
 		if (xdp_rxq_info_is_reg(&rq->xdp_rxq))
 			err = xdp_rxq_info_reg_mem_model(&rq->xdp_rxq,
 							 MEM_TYPE_PAGE_POOL, rq->page_pool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 84b1ab8233b8..e34ef53ebd0e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,12 +273,12 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
 				       struct mlx5e_frag_page *frag_page)
 {
 	struct page *page;
 
-	page = page_pool_dev_alloc_pages(rq->page_pool);
+	page = page_pool_dev_alloc_pages(pool);
 	if (unlikely(!page))
 		return -ENOMEM;
 
@@ -292,14 +292,14 @@ static int mlx5e_page_alloc_fragmented(struct mlx5e_rq *rq,
 	return 0;
 }
 
-static void mlx5e_page_release_fragmented(struct mlx5e_rq *rq,
+static void mlx5e_page_release_fragmented(struct page_pool *pool,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
 	struct page *page = frag_page->page;
 
 	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(rq->page_pool, page, -1, true);
+		page_pool_put_unrefed_page(pool, page, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -313,7 +313,8 @@ static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
 		 * offset) should just use the new one without replenishing again
 		 * by themselves.
 		 */
-		err = mlx5e_page_alloc_fragmented(rq, frag->frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool,
+						  frag->frag_page);
 
 	return err;
 }
@@ -332,7 +333,7 @@ static inline void mlx5e_put_rx_frag(struct mlx5e_rq *rq,
 				     struct mlx5e_wqe_frag_info *frag)
 {
 	if (mlx5e_frag_can_release(frag))
-		mlx5e_page_release_fragmented(rq, frag->frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag->frag_page);
 }
 
 static inline struct mlx5e_wqe_frag_info *get_frag(struct mlx5e_rq *rq, u16 ix)
@@ -584,7 +585,8 @@ mlx5e_free_rx_mpwqe(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi)
 				struct mlx5e_frag_page *frag_page;
 
 				frag_page = &wi->alloc_units.frag_pages[i];
-				mlx5e_page_release_fragmented(rq, frag_page);
+				mlx5e_page_release_fragmented(rq->page_pool,
+							      frag_page);
 			}
 		}
 	}
@@ -679,11 +681,10 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 		u64 addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->hd_page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 
-
 		addr = page_pool_get_dma_addr(frag_page->page);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
@@ -715,7 +716,8 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (!header_offset) {
 			struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
 
-			mlx5e_page_release_fragmented(rq, frag_page);
+			mlx5e_page_release_fragmented(rq->hd_page_pool,
+						      frag_page);
 		}
 	}
 
@@ -791,7 +793,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 	for (i = 0; i < rq->mpwqe.pages_per_wqe; i++, frag_page++) {
 		dma_addr_t addr;
 
-		err = mlx5e_page_alloc_fragmented(rq, frag_page);
+		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
 		addr = page_pool_get_dma_addr(frag_page->page);
@@ -836,7 +838,7 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 err_unmap:
 	while (--i >= 0) {
 		frag_page--;
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->page_pool, frag_page);
 	}
 
 	bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
@@ -855,7 +857,7 @@ mlx5e_free_rx_shampo_hd_entry(struct mlx5e_rq *rq, u16 header_index)
 	if (((header_index + 1) & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1)) == 0) {
 		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 
-		mlx5e_page_release_fragmented(rq, frag_page);
+		mlx5e_page_release_fragmented(rq->hd_page_pool, frag_page);
 	}
 	clear_bit(header_index, shampo->bitmap);
 }
@@ -1100,6 +1102,8 @@ INDIRECT_CALLABLE_SCOPE bool mlx5e_post_rx_mpwqes(struct mlx5e_rq *rq)
 
 	if (rq->page_pool)
 		page_pool_nid_changed(rq->page_pool, numa_mem_id());
+	if (rq->hd_page_pool)
+		page_pool_nid_changed(rq->hd_page_pool, numa_mem_id());
 
 	head = rq->mpwqe.actual_wq_head;
 	i = missing;
@@ -2004,7 +2008,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
 		net_prefetchw(page_address(frag_page->page) + frag_offset);
-		if (unlikely(mlx5e_page_alloc_fragmented(rq, &wi->linear_page))) {
+		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
+							 &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
@@ -2068,7 +2073,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 				wi->linear_page.frags++;
 			}
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool,
+						      &wi->linear_page);
 			return NULL; /* page/packet was consumed by XDP */
 		}
 
@@ -2077,13 +2083,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			mxbuf->xdp.data - mxbuf->xdp.data_hard_start, 0,
 			mxbuf->xdp.data - mxbuf->xdp.data_meta);
 		if (unlikely(!skb)) {
-			mlx5e_page_release_fragmented(rq, &wi->linear_page);
+			mlx5e_page_release_fragmented(rq->page_pool,
+						      &wi->linear_page);
 			return NULL;
 		}
 
 		skb_mark_for_recycle(skb);
 		wi->linear_page.frags++;
-		mlx5e_page_release_fragmented(rq, &wi->linear_page);
+		mlx5e_page_release_fragmented(rq->page_pool, &wi->linear_page);
 
 		if (xdp_buff_has_frags(&mxbuf->xdp)) {
 			struct mlx5e_frag_page *pagep;
-- 
2.34.1


