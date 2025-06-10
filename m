Return-Path: <linux-rdma+bounces-11145-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF821AD3C71
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 17:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 76E11189EC4F
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Jun 2025 15:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8201E23D2BB;
	Tue, 10 Jun 2025 15:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kaIPgayh"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2077.outbound.protection.outlook.com [40.107.94.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 700C623D2A8;
	Tue, 10 Jun 2025 15:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749568309; cv=fail; b=PKPrZzOKGeUIauMJpqxzkhjymMkf8qwwg+N8rDGOnic68VNF+oQ0wgOeiOJ2Upvkt4YvNACrIsBULArZV1FiyL5BBl5+9iRznzYEowbpU3umEpP7O16BxXS4PrIUdV4EKgPPCFk7HudVKYC7qEhoOeMXUQ7dNxeloWgY29SrFKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749568309; c=relaxed/simple;
	bh=Feguanfe2tf9nTQGUcIOfUb0kSx5SkOx/DTRazG1tzE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uBB5YzcpLLJYSUdf+nN8iUIon/eiass/M2s1c9HWpWo9xIlSD/xEAvpov56MpsNtmF3dr6No4HHdfCNG5sup7jO0wpQaDsVpaaTZBhuWV4IWBZlvJ12L76MjPtZavnXLElS7SYYoHiQbYPizj0kw5k3feLRuaCqFonZdDvAGxNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kaIPgayh; arc=fail smtp.client-ip=40.107.94.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Evao71BGv8H7DmdWEUm8U+ZJe3Uhof6CH9uM+uGg3KzozlNCqgdzlc1waOTCNH0ijykghl2NLNjvvOnom1A3QN0YHzc3RVXTF7j0iLiQwhpHf1/WK/aDCnPsfPT4cv2HlArFZ9kGFdWd5vNVwSodTVVcZuOm81URkEAKDpYCp2Sgvo0JxFdcSflQVDmJ+2WK7IZ51ZukVPGZ+V3JPHStXau/RZq2K6zVumnA5S6SUp60c7a8ko+7hMrRpBEQszWWrGPTan0KjHGkg6q6IQMF9ei66twv7gIPEHjPa4/5/P3Wuz5nC7kU2VFE0SQxpIlfk7j4TMURowZ6DDEdeUQPtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAf2atQudQXzME50aC6sT/pZmjfpOwNa26Vj0oCzHRk=;
 b=cNsXYKCqCdy3NaVka/90q0oogktXG9FqPmpjDpYFCxJlZ5YZQf6a1MrfcnAarjzFBWHIwDFO3qzNrWY/UbpsgPH+RTmdGSEIF+yhvxmqfTztCXmSrCQMOxVpGTRg7UmSdn0p0ro4RCGCqE6P2Y7kYNZrLaGDSJHY/q6RECvqMaU4tOsCN+rC/VcKbzncIm40UXCn3lyUFyujJ6b8rNltHlAlM/Af/gDQf6IG0cmD05lCFQTmk5HwTjBLZ4pn4hhevU2yc5Q5ReyrJ50rUNK37BDRaygmmbHE0uv1wopypNjvOo5rZL+++Lw4BWe7IW5dmMrIGzGqtsGEC32FB68PPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAf2atQudQXzME50aC6sT/pZmjfpOwNa26Vj0oCzHRk=;
 b=kaIPgayha7u8xJs+wLrNKp9BoRm8kWyaGbyNq8S0gSx6pgLKV40blQKDfkGbOBfDku1Xc3yAecSg7vxUAlB7z/HbtIRhmeuB8w9HtiyKykW0906GG0boW/jO35moQllxryH6iBwqDKm3pkiZqeid8GhdQ32v1hHOgDzN9CY50VlUyaeRUYWq4mr4Z5752nsZYuL+s4Hgn0uF9ifc4iAT0QCYqKvwtBrHMILk0GrXhmlKPcddITt8F4+5ibzwVMX14VhzTm7NT3Vy7lsEVZy2d6cGPQkgeyn5rA1TFW7ApUS0LLnoe+D/CnskNFc3AovjTLAe9YV9UkgOPbuahJQlZA==
Received: from SJ0PR05CA0143.namprd05.prod.outlook.com (2603:10b6:a03:33d::28)
 by DM3PR12MB9286.namprd12.prod.outlook.com (2603:10b6:8:1ae::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 10 Jun
 2025 15:11:41 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::af) by SJ0PR05CA0143.outlook.office365.com
 (2603:10b6:a03:33d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.16 via Frontend Transport; Tue,
 10 Jun 2025 15:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Tue, 10 Jun 2025 15:11:40 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 10 Jun
 2025 08:11:18 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 10 Jun
 2025 08:11:18 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 10
 Jun 2025 08:11:14 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <saeedm@nvidia.com>, <gal@nvidia.com>, <leonro@nvidia.com>,
	<tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net-next v4 07/11] net/mlx5e: Convert over to netmem
Date: Tue, 10 Jun 2025 18:09:46 +0300
Message-ID: <20250610150950.1094376-8-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|DM3PR12MB9286:EE_
X-MS-Office365-Filtering-Correlation-Id: 00f30c9a-9fcd-4b14-e3e5-08dda8311a54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YdIQx4duYRGOOveY0WEG6OL0ib/cM942nln8PnhIwANDKtUMAcMmTiAilSwY?=
 =?us-ascii?Q?l9HBtWdCR5ct3ni5DXvuOzP3XLQTsIj5XZj9QOXKvLe/l+PcdqFr6z77bn+Z?=
 =?us-ascii?Q?MLRAW5S6+wMsnLQPckTsq5c2cyOka6J258PH+7WTxMbt0fXckQq/4kJ0mJTs?=
 =?us-ascii?Q?axjQVD7f8673avy+qbcqWIMZ1TtiL4NaXfAB14KofEvyeEKXX5cick5moCiY?=
 =?us-ascii?Q?yr/sJd+ioeM/Y4GLYrdMvSzRG04NHIm403YvlQojGB62poWMzR+q0dbbEDiJ?=
 =?us-ascii?Q?u3Cj/n3xF1YuWxiHF0unzlesR9r5ROTo6xMp3+1BgW0vZb3FrXVKi+0obcrS?=
 =?us-ascii?Q?G9If+xTEEeJtubZrv6wMUPRz2HgvDaTsbaO9qEIZ8zNUAwwpEKKXLSNowHX0?=
 =?us-ascii?Q?VDhI80TTonTorjjULXvFtgQ6T9S5Ps3FeWg24BWAoFUJW/wHUrwnh2cKyhNk?=
 =?us-ascii?Q?NiI2UsjyfkeB/Y6hpYlyNeMvNhUSVc5kKprTaDvKDqVClRCjuX+cOLZgvpXX?=
 =?us-ascii?Q?qx60v/hXmpOIa0JXJoNFpPRyzHT/4RRZFY3opa28ers6tvnx/as8rgYo92ez?=
 =?us-ascii?Q?/y95p16x3Jo9ucgoz+VU5cIyHfa9+8w2LxcKXIRJeB4YxIpFY9m0+Mgx9QSC?=
 =?us-ascii?Q?VFjqGyd9YOmbXf8Bl5fCP9CIHyx6ZFtBDjbvg74zNZO3Gq3zgcnjhiNPonSd?=
 =?us-ascii?Q?3t2U97vTtw6Gjy9RqtbtWEbcSMjU7MQILLr7vL21XB7ua25oQXiFTRgPnsM5?=
 =?us-ascii?Q?8OiBqUQbesNW9C4/Asrtia8pHkzOThAVreku+GKrt5LbV0w0oloi5rC4L7dT?=
 =?us-ascii?Q?YmryYt85RE6N/vXIgVtvSKDVsT+ivN3JiaDsmVR3Lw625rNXAVu/qPNziX+Q?=
 =?us-ascii?Q?brgIJ4QAgqjeN0YKH8XMZ+jObyQOljx6ZeN2ru0tnIkRgTCvTa2tIVJS2kHp?=
 =?us-ascii?Q?wl5maZmgvCEhx9SeH1yr6Q/wbRM4BGpmoABtoBkAp0yA3WzPrp2kyYD24Pqy?=
 =?us-ascii?Q?HZLi4DCYVHA3hrkQW6dnftoOqk/mxpJiDMUa4CMTDkQ5UpMghRlVB1KC7hPH?=
 =?us-ascii?Q?EaOC8Gng06DEVK7bG2866g48w9rDFKGL5rjmcC2jyYbyal5ZPoKEUt+JEsU4?=
 =?us-ascii?Q?zG9D9ekME6IwnonJI34SK5Mm+ucvfqXkdQMDw25v+7bEAxp6FavBbXbtzFDf?=
 =?us-ascii?Q?4CaJu3wQ13oWUpsG+Un+U5/JumYcmZmcFDwS1RnaK3pr8ZS0+Xj9lItlu2PH?=
 =?us-ascii?Q?M9dQfu9o95qUUgvtDo5QP6GqvGGaLi7Mq6xvYBmE6JBDDY1NEBxm0GnKATn1?=
 =?us-ascii?Q?PEIpiCLQcEKlwBwCAhyd0IKNMr0eXPp9c1COUZJ+GSp/f3e+2xz8KdF+17Yf?=
 =?us-ascii?Q?t1nsBCoB7LH6Dmr1NtQTY5n+hUymd7b/xnv1UwF3K+l9A7HxqzokKL/AMBUn?=
 =?us-ascii?Q?UDPQuhvK2cK68TpPcLGrcT1v62PboqZSJLrOAPKQvMRMBlqQn+yrlZjCXNQd?=
 =?us-ascii?Q?b/jtBraJ75VT2dk60TFYcfz9Rg3PCP96DQti?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 15:11:40.3634
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00f30c9a-9fcd-4b14-e3e5-08dda8311a54
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9286

From: Saeed Mahameed <saeedm@nvidia.com>

mlx5e_page_frag holds the physical page itself, to naturally support
zc page pools, remove physical page reference from mlx5 and replace it
with netmem_ref, to avoid internal handling in mlx5 for net_iov backed
pages.

SHAMPO can issue packets that are not split into header and data. These
packets will be dropped if the data part resides in a net_iov as the
driver can't read into this area.

No performance degradation observed.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 103 ++++++++++--------
 2 files changed, 61 insertions(+), 44 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index c329de1d4f0a..65a73913b9a2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -553,7 +553,7 @@ struct mlx5e_icosq {
 } ____cacheline_aligned_in_smp;
 
 struct mlx5e_frag_page {
-	struct page *page;
+	netmem_ref netmem;
 	u16 frags;
 };
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index e34ef53ebd0e..75e753adedef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -273,33 +273,33 @@ static inline u32 mlx5e_decompress_cqes_start(struct mlx5e_rq *rq,
 
 #define MLX5E_PAGECNT_BIAS_MAX (PAGE_SIZE / 64)
 
-static int mlx5e_page_alloc_fragmented(struct page_pool *pool,
+static int mlx5e_page_alloc_fragmented(struct page_pool *pp,
 				       struct mlx5e_frag_page *frag_page)
 {
-	struct page *page;
+	netmem_ref netmem = page_pool_alloc_netmems(pp,
+						    GFP_ATOMIC | __GFP_NOWARN);
 
-	page = page_pool_dev_alloc_pages(pool);
-	if (unlikely(!page))
+	if (unlikely(!netmem))
 		return -ENOMEM;
 
-	page_pool_fragment_page(page, MLX5E_PAGECNT_BIAS_MAX);
+	page_pool_fragment_netmem(netmem, MLX5E_PAGECNT_BIAS_MAX);
 
 	*frag_page = (struct mlx5e_frag_page) {
-		.page	= page,
+		.netmem	= netmem,
 		.frags	= 0,
 	};
 
 	return 0;
 }
 
-static void mlx5e_page_release_fragmented(struct page_pool *pool,
+static void mlx5e_page_release_fragmented(struct page_pool *pp,
 					  struct mlx5e_frag_page *frag_page)
 {
 	u16 drain_count = MLX5E_PAGECNT_BIAS_MAX - frag_page->frags;
-	struct page *page = frag_page->page;
+	netmem_ref netmem = frag_page->netmem;
 
-	if (page_pool_unref_page(page, drain_count) == 0)
-		page_pool_put_unrefed_page(pool, page, -1, true);
+	if (page_pool_unref_netmem(netmem, drain_count) == 0)
+		page_pool_put_unrefed_netmem(pp, netmem, -1, true);
 }
 
 static inline int mlx5e_get_rx_frag(struct mlx5e_rq *rq,
@@ -359,7 +359,7 @@ static int mlx5e_alloc_rx_wqe(struct mlx5e_rq *rq, struct mlx5e_rx_wqe_cyc *wqe,
 		frag->flags &= ~BIT(MLX5E_WQE_FRAG_SKIP_RELEASE);
 
 		headroom = i == 0 ? rq->buff.headroom : 0;
-		addr = page_pool_get_dma_addr(frag->frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag->frag_page->netmem);
 		wqe->data[i].addr = cpu_to_be64(addr + frag->offset + headroom);
 	}
 
@@ -500,9 +500,10 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 			       struct xdp_buff *xdp, struct mlx5e_frag_page *frag_page,
 			       u32 frag_offset, u32 len)
 {
+	netmem_ref netmem = frag_page->netmem;
 	skb_frag_t *frag;
 
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(netmem);
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len, rq->buff.map_dir);
 	if (!xdp_buff_has_frags(xdp)) {
@@ -515,9 +516,9 @@ mlx5e_add_skb_shared_info_frag(struct mlx5e_rq *rq, struct skb_shared_info *sinf
 	}
 
 	frag = &sinfo->frags[sinfo->nr_frags++];
-	skb_frag_fill_page_desc(frag, frag_page->page, frag_offset, len);
+	skb_frag_fill_netmem_desc(frag, netmem, frag_offset, len);
 
-	if (page_is_pfmemalloc(frag_page->page))
+	if (!netmem_is_net_iov(netmem) && netmem_is_pfmemalloc(netmem))
 		xdp_buff_set_frag_pfmemalloc(xdp);
 	sinfo->xdp_frags_size += len;
 }
@@ -528,27 +529,29 @@ mlx5e_add_skb_frag(struct mlx5e_rq *rq, struct sk_buff *skb,
 		   u32 frag_offset, u32 len,
 		   unsigned int truesize)
 {
-	dma_addr_t addr = page_pool_get_dma_addr(frag_page->page);
+	dma_addr_t addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	u8 next_frag = skb_shinfo(skb)->nr_frags;
+	netmem_ref netmem = frag_page->netmem;
 
 	dma_sync_single_for_cpu(rq->pdev, addr + frag_offset, len,
 				rq->buff.map_dir);
 
-	if (skb_can_coalesce(skb, next_frag, frag_page->page, frag_offset)) {
+	if (skb_can_coalesce_netmem(skb, next_frag, netmem, frag_offset)) {
 		skb_coalesce_rx_frag(skb, next_frag - 1, len, truesize);
-	} else {
-		frag_page->frags++;
-		skb_add_rx_frag(skb, next_frag, frag_page->page,
-				frag_offset, len, truesize);
+		return;
 	}
+
+	frag_page->frags++;
+	skb_add_rx_frag_netmem(skb, next_frag, netmem,
+			       frag_offset, len, truesize);
 }
 
 static inline void
 mlx5e_copy_skb_header(struct mlx5e_rq *rq, struct sk_buff *skb,
-		      struct page *page, dma_addr_t addr,
+		      netmem_ref netmem, dma_addr_t addr,
 		      int offset_from, int dma_offset, u32 headlen)
 {
-	const void *from = page_address(page) + offset_from;
+	const void *from = netmem_address(netmem) + offset_from;
 	/* Aligning len to sizeof(long) optimizes memcpy performance */
 	unsigned int len = ALIGN(headlen, sizeof(long));
 
@@ -685,7 +688,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 		if (unlikely(err))
 			goto err_unmap;
 
-		addr = page_pool_get_dma_addr(frag_page->page);
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 
 		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
 			header_offset = mlx5e_shampo_hd_offset(index++);
@@ -796,7 +799,8 @@ static int mlx5e_alloc_rx_mpwqe(struct mlx5e_rq *rq, u16 ix)
 		err = mlx5e_page_alloc_fragmented(rq->page_pool, frag_page);
 		if (unlikely(err))
 			goto err_unmap;
-		addr = page_pool_get_dma_addr(frag_page->page);
+
+		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 		umr_wqe->inline_mtts[i] = (struct mlx5_mtt) {
 			.ptag = cpu_to_be64(addr | MLX5_EN_WR),
 		};
@@ -1216,7 +1220,7 @@ static void *mlx5e_shampo_get_packet_hd(struct mlx5e_rq *rq, u16 header_index)
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index) + rq->buff.headroom;
 
-	return page_address(frag_page->page) + head_offset;
+	return netmem_address(frag_page->netmem) + head_offset;
 }
 
 static void mlx5e_shampo_update_ipv4_udp_hdr(struct mlx5e_rq *rq, struct iphdr *ipv4)
@@ -1677,11 +1681,11 @@ mlx5e_skb_from_cqe_linear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi,
 	dma_addr_t addr;
 	u32 frag_size;
 
-	va             = page_address(frag_page->page) + wi->offset;
+	va             = netmem_address(frag_page->netmem) + wi->offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -1731,10 +1735,10 @@ mlx5e_skb_from_cqe_nonlinear(struct mlx5e_rq *rq, struct mlx5e_wqe_frag_info *wi
 
 	frag_page = wi->frag_page;
 
-	va = page_address(frag_page->page) + wi->offset;
+	va = netmem_address(frag_page->netmem) + wi->offset;
 	frag_consumed_bytes = min_t(u32, frag_info->frag_size, cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, wi->offset,
 				      rq->buff.frame0_sz, rq->buff.map_dir);
 	net_prefetchw(va); /* xdp_frame data area */
@@ -2007,13 +2011,14 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 	if (prog) {
 		/* area for bpf_xdp_[store|load]_bytes */
-		net_prefetchw(page_address(frag_page->page) + frag_offset);
+		net_prefetchw(netmem_address(frag_page->netmem) + frag_offset);
 		if (unlikely(mlx5e_page_alloc_fragmented(rq->page_pool,
 							 &wi->linear_page))) {
 			rq->stats->buff_alloc_err++;
 			return NULL;
 		}
-		va = page_address(wi->linear_page.page);
+
+		va = netmem_address(wi->linear_page.netmem);
 		net_prefetchw(va); /* xdp_frame data area */
 		linear_hr = XDP_PACKET_HEADROOM;
 		linear_data_len = 0;
@@ -2124,8 +2129,8 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 			while (++pagep < frag_page);
 		}
 		/* copy header */
-		addr = page_pool_get_dma_addr(head_page->page);
-		mlx5e_copy_skb_header(rq, skb, head_page->page, addr,
+		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
+		mlx5e_copy_skb_header(rq, skb, head_page->netmem, addr,
 				      head_offset, head_offset, headlen);
 		/* skb linear part was allocated with headlen and aligned to long */
 		skb->tail += headlen;
@@ -2155,11 +2160,11 @@ mlx5e_skb_from_cqe_mpwrq_linear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		return NULL;
 	}
 
-	va             = page_address(frag_page->page) + head_offset;
+	va             = netmem_address(frag_page->netmem) + head_offset;
 	data           = va + rx_headroom;
 	frag_size      = MLX5_SKB_FRAG_SZ(rx_headroom + cqe_bcnt);
 
-	addr = page_pool_get_dma_addr(frag_page->page);
+	addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
 	dma_sync_single_range_for_cpu(rq->pdev, addr, head_offset,
 				      frag_size, rq->buff.map_dir);
 	net_prefetch(data);
@@ -2198,16 +2203,19 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 			  struct mlx5_cqe64 *cqe, u16 header_index)
 {
 	struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, header_index);
-	dma_addr_t page_dma_addr = page_pool_get_dma_addr(frag_page->page);
 	u16 head_offset = mlx5e_shampo_hd_offset(header_index);
-	dma_addr_t dma_addr = page_dma_addr + head_offset;
 	u16 head_size = cqe->shampo.header_size;
 	u16 rx_headroom = rq->buff.headroom;
 	struct sk_buff *skb = NULL;
+	dma_addr_t page_dma_addr;
+	dma_addr_t dma_addr;
 	void *hdr, *data;
 	u32 frag_size;
 
-	hdr		= page_address(frag_page->page) + head_offset;
+	page_dma_addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
+	dma_addr = page_dma_addr + head_offset;
+
+	hdr		= netmem_address(frag_page->netmem) + head_offset;
 	data		= hdr + rx_headroom;
 	frag_size	= MLX5_SKB_FRAG_SZ(rx_headroom + head_size);
 
@@ -2232,7 +2240,7 @@ mlx5e_skb_from_cqe_shampo(struct mlx5e_rq *rq, struct mlx5e_mpw_info *wi,
 		}
 
 		net_prefetchw(skb->data);
-		mlx5e_copy_skb_header(rq, skb, frag_page->page, dma_addr,
+		mlx5e_copy_skb_header(rq, skb, frag_page->netmem, dma_addr,
 				      head_offset + rx_headroom,
 				      rx_headroom, head_size);
 		/* skb linear part was allocated with headlen and aligned to long */
@@ -2326,11 +2334,20 @@ static void mlx5e_handle_rx_cqe_mpwrq_shampo(struct mlx5e_rq *rq, struct mlx5_cq
 	}
 
 	if (!*skb) {
-		if (likely(head_size))
+		if (likely(head_size)) {
 			*skb = mlx5e_skb_from_cqe_shampo(rq, wi, cqe, header_index);
-		else
-			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe, cqe_bcnt,
-								  data_offset, page_idx);
+		} else {
+			struct mlx5e_frag_page *frag_page;
+
+			frag_page = &wi->alloc_units.frag_pages[page_idx];
+			if (unlikely(netmem_is_net_iov(frag_page->netmem)))
+				goto free_hd_entry;
+			*skb = mlx5e_skb_from_cqe_mpwrq_nonlinear(rq, wi, cqe,
+								  cqe_bcnt,
+								  data_offset,
+								  page_idx);
+		}
+
 		if (unlikely(!*skb))
 			goto free_hd_entry;
 
-- 
2.34.1


