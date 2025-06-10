Return-Path: <linux-rdma+bounces-11146-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63196AD3C9E
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A04F3ACD89
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDAC23FC6B;
	Tue, 10 Jun 2025 15:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yq80KGgp"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71163225A5B;
	Tue, 10 Jun 2025 15:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568317; cv=fail; b=TbXHReB6lUrrKnJIMGUFsHMAs0Qmve/h09DU4h6S0CaRCMqyFYMmCCm4V9fRIGesmupLY/IMB7LGAHa3foxpHRRumi5WCYj0irbKZauw+j4d2ruqIgZA/dx7VQIzneaw54BHPeg7rN/+RIrY0J+bmuze4laBDWVpoHBSMYqcTEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568317; c=relaxed/simple;
	bh=MkUXqMGdgt99DElX6FuJZK+KH/uecXa9QNcqRYT3UTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FM9eWlnqdyaeKCGGQbLiWn685dChAxBM23K9Z+BVj3oZ96aAnNGZlCLfOXTl7oFoqbVxg0OgMFbWugpLYwST712ZObTzKy0t2KejuBjcIMqyBTptoylLjBUdErWM4N2y3QynyzQEpOFV6pQTozoHNkoU747dDUoDGMBOgB1UzTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yq80KGgp; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OfSDS2uWoYCxAz9yCDYxQm0otULMjod+mz0z4f70nxpgu+YTBbgZa6eACMn4oGSxOrYQ0mBjIUmppT9PMFOlycWZZ5ry3SILbz9kz/xH+tCLJHJn5INKMFjA+uQlcy1oCNj/b9velwz/FvlkM+36Lq/LSxcKGcPlEPtXKnuqeCNs1UQnpxI26lAeS0u5+51MSIendgEYni0AWI9kn+vglZARIIWuT4mB/75PI5AQ8E/3brViXnXONnz/aAZPOjflfdi9O5Lde+M70ojrzprK93KM+bkJhmDyGeXv/K7NLOB17FQghz4+hkf9L8uAbnREnUx5l0R7XPLStpGUGmXsvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h6p1corQwWdCFsKO5166q53shgxvNfvAJzbBGheZUKg=;
 b=SBbMyZ63L36UFjSexzMIgbW+7pa/iGXqF0G7oZNl15CtGdisiCe2hUx+0UDvJ/EqQ/L54LFgEwG0hGyf/kf+KWARUAWOgSPgMKu2lD/ROks5sRHCw2aAwDMaRxCSEmnau8vXRGeRPe6Gj9SiMVNY532M8LN+6qlSOgFpxkT8y07xy2X6wMFXgz0svb/oW08Q2FPc6HZLzmAydoT8b0x1BN4tO/3VIIHPas9rbjZim2vYkKcfuC02Zp7GrXffHXMV97/6CmtqtIljP+5Y9FAHjYdafjdNHMxvo+iT7Z03VkqYjckU15baRz2EJtG7tqgLVKh65mPIg97YFSFWwq/TdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h6p1corQwWdCFsKO5166q53shgxvNfvAJzbBGheZUKg=;
 b=Yq80KGgpOCsog00+q6W/QZ1xJ0aFfq+SRQC+8b4VCjhSKJ2jwTIHAW01Ac8iuAr4tAArsfuKAAd24Bh+1HtcjhrZUTdQV2kS55SFjM7pYuEEHUAzT2vSmtGpRfv5fjDOk+t7H7HPFFLcajry1SR8n5+qt9TljvAE3ym5iCw4tyh2QLUgaYzznUkmL3aYp0/dFjTdBmCf70YAx+5h390NMQ6bIdlHocpRoMiSAXAvmoQgWY/JgvsimF+dk+I2PM3/iwXijF/J+BXNHS1GdlE8AG+qUakzoHjg3K3AgqHEDBc5pTeXtaDyVyZzTm6Ae3VsRCIo+mUdt19fYJ1VXwPC8w==
Received: from BY3PR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:254::31)
 by MN0PR12MB6320.namprd12.prod.outlook.com (2603:10b6:208:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:11:51 +0000
Received: from CY4PEPF0000EE3D.namprd03.prod.outlook.com
 (2603:10b6:a03:254:cafe::89) by BY3PR05CA0026.outlook.office365.com
 (2603:10b6:a03:254::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.18 via Frontend Transport; Tue,
 10 Jun 2025 15:11:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3D.mail.protection.outlook.com (10.167.242.15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:11:50 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:11:28 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:11:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:11:23 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 08/11] net/mlx5e: Add support for UNREADABLE netmem page pools
Date: Tue, 10 Jun 2025 18:09:47 +0300
Message-ID: <20250610150950.1094376-9-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610150950.1094376-1-mbloch@nvidia.com>
References: <20250610150950.1094376-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3D:EE_|MN0PR12MB6320:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fc73a27-ffa4-4637-765b-08dda8312068
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?B+D7SEmwmfOqXSQqNRfQu6nxh7yVKj74ArgkrUkTgdA2Igu0lKqINZRnCJBY?=
 =?us-ascii?Q?5DxDHB6SuTDIzV5j5XbV6PtvzQUuO3LgtVEqNAiFMsX1P/WRF5t0u0ckixSz?=
 =?us-ascii?Q?QHvjJ4ZtzHEgTizH74TirdLVoC6FOcei1LDvqoW9GHFnyKUphgqt23UMBkY9?=
 =?us-ascii?Q?PtPsFgP1pfVQaA2LEbQAR8Qw5cmZbbFJD692Fa0HNCtP0ac8EcCXP1kmInFP?=
 =?us-ascii?Q?QDGbxaFACNdA6CCq1mZsCxHmHEbHIWaNbzhMlh0/2G+qkrFcoOftwMx2U6LQ?=
 =?us-ascii?Q?fPEJqs7sHjGPnBOrThDllyi1sesWl5GdbSm4aW2bW+cJklzf6xuysStEn9Gn?=
 =?us-ascii?Q?pc1QPannm3PEys99H6hjn+YzrVFPPLTrn0FHbq21HFJxWlnPw6GCcZ7l6hFJ?=
 =?us-ascii?Q?XtqqPdqo1ynBzT/iwmsMuJh30i90/mtuxYQbuFPT19dUKpE7UC6AKRXsj63n?=
 =?us-ascii?Q?V62/Xgxk79letvNRoRjX/c4g+o9prcwK1Z9+gaoLJ/6NEV2EPCAzHRYQRZO9?=
 =?us-ascii?Q?rqJFSgn0+cUHSJBFKpuO+DBxyh/rBR9J/uG5bMN7l/Qi/gEn+I3Ah2nRWDyr?=
 =?us-ascii?Q?vK30PN9VFsLZCSkecU3ix3sj/ug7qkfcnATRSJsM4yXGGKVmlVuxlj21IRDP?=
 =?us-ascii?Q?YBwWHS35MoeSykHyNuKCmnMhhXElhzsqBi8oCAnZVXsvjba5bcyvKz9ansmr?=
 =?us-ascii?Q?UxwBe6KEF7DRJipdiUwk3CL7hiCoZQDT20HVLy3H9i6gd7my4uxHOrsG14qf?=
 =?us-ascii?Q?XvdPI6cF2PIp+rnZAuY+5vVxDJuWtx8ln9UpDk3dozAmd8sD3ee4IMNuKeyM?=
 =?us-ascii?Q?45V2mUsE47JKk0oaxfj5NwWNIJMQZDd+Kw2xGcg5byX/ycQYnr21cOo3J/Gk?=
 =?us-ascii?Q?S6PLxgnpFzuR+RbDso4+wzoImHzjt2t5kNKucctYY+ikB2v8bbourAIPWiIY?=
 =?us-ascii?Q?MYOmX+Dql5SIrAIR5+B9qAzLYL2xaJuQOSRiQqpA62N7Zd4S/2K5NCM5si43?=
 =?us-ascii?Q?7omjKwV15XPC7L/AfzuN15yX+joP9/O6DCfG28vRlKtTofBUwEyk6VeLwvpl?=
 =?us-ascii?Q?PAE+9vcFDu0X4i3G2PIevGEDa5VpYiKhdDiHtSV4AIQFi2Aj65f0nRd1bYh8?=
 =?us-ascii?Q?dUd9oJ8mn8ePAfgaCH8KycVP7Yu4HEoglS0T5++xolFVB0D/N2fv1J7co++u?=
 =?us-ascii?Q?VjtUDR041AwOYrQ4tEChx9IWCwlxOyaiH4/7q/m5aCyXYvomth+ISgOScZ25?=
 =?us-ascii?Q?FqXHW+ycQbzfQ2M2Rhw6G8+Purgwl5mHkjdo8+79prcrocxvcDOR2kiQ9D6k?=
 =?us-ascii?Q?arE/YBVJd4k6/Ep0AQZljDyvrs9cMvQQqNkoSgi8QynNeCoeXlCy3VqObJY9?=
 =?us-ascii?Q?oY375oIbkCy+2kiCNLRtAS0lll3wxG+E4wIU/Fy5eMYqL2D0kJeaXsWSQ/JL?=
 =?us-ascii?Q?nveoMFo56bJdXm3OxQN/UcXr3NvqezGu9zk4bFAqSoiO+jb/Nd67a6Uo0Z1T?=
 =?us-ascii?Q?/FvfD0Sy/y1W85JvX2APeQ/ZLJwlLIS3BbLu?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:11:50.5489
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fc73a27-ffa4-4637-765b-08dda8312068
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6320

From: Saeed Mahameed <saeedm@nvidia.com>

On netdev_rx_queue_restart, a special type of page pool maybe expected.

In this patch declare support for UNREADABLE netmem iov pages in the
pool params only when header data split shampo RQ mode is enabled, also
set the queue index in the page pool params struct.

Shampo mode requirement: Without header split rx needs to peek at the data,
we can't do UNREADABLE_NETMEM.

The patch also enables the use of a separate page pool for headers when
a memory provider is installed for the queue, otherwise the same common
page pool continues to be used.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 5e649705e35f..a51e204bd364 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -749,7 +749,9 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
 
 static bool mlx5_rq_needs_separate_hd_pool(struct mlx5e_rq *rq)
 {
-	return false;
+	struct netdev_rx_queue *rxq = __netif_get_rx_queue(rq->netdev, rq->ix);
+
+	return !!rxq->mp_params.mp_ops;
 }
 
 static int mlx5_rq_shampo_alloc(struct mlx5_core_dev *mdev,
@@ -964,6 +966,11 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		pp_params.netdev    = rq->netdev;
 		pp_params.dma_dir   = rq->buff.map_dir;
 		pp_params.max_len   = PAGE_SIZE;
+		pp_params.queue_idx = rq->ix;
+
+		/* Shampo header data split allow for unreadable netmem */
+		if (test_bit(MLX5E_RQ_STATE_SHAMPO, &rq->state))
+			pp_params.flags |= PP_FLAG_ALLOW_UNREADABLE_NETMEM;
 
 		/* page_pool can be used even when there is no rq->xdp_prog,
 		 * given page_pool does not handle DMA mapping there is no
-- 
2.34.1


