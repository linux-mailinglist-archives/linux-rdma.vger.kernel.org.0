Return-Path: <linux-rdma+bounces-20127-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCo1MoNh/Gm7OwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20127-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:55:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B18C34E64E1
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 11:55:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1C90301E659
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 09:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46B7A3CF02E;
	Thu,  7 May 2026 09:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TL1uqM+K"
X-Original-To: linux-rdma@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010044.outbound.protection.outlook.com [52.101.61.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E42D3CEBBC;
	Thu,  7 May 2026 09:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778147677; cv=fail; b=D1y3qRdNTNZddfjdLrlx+6FnHzlLcXAt+KwgL42XdmapJR7P/51lAPN2cgLIfG+oWFaP7ocnsL9ZpMymE5dBVv1U4eFLgReVLGQDv5gmJZgkCG6W1Ne6AYl7bc2nhAIVPUWRSRDRrqc4I8oVCVccuBxROOh7ifNOcedlY/2d1L4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778147677; c=relaxed/simple;
	bh=TITk72mWppCLlR4JBt8FfzTf5Xky/PartntqY68GRJg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pyc+UP1mVVpZP6e/HdLxlhioWIEPVRIIHkCyyxTRnESSQCxeZ6KN2OBjrFANCmao34hXQpdwekUmkSDAALEOjTy74MVJ6htuaesp2wrZrDej3ab/L5oT/jwcUpCpFpEITg7zf+awJmZZHjHXJgnLI4uk2e1yA/+UWZT6JLS1UkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TL1uqM+K; arc=fail smtp.client-ip=52.101.61.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKAbOVGeoC+T/RjaUJXSFFX6mNGCP+iyQMMTHPZEYo2hl1CBG+oHERETQ78IsW8jNJUSIvSkx54SnqjkDRtdELVAoI5I0w1isBTRVdJtDrNeXZ8cBd129QqYGadTBrPWzCL2HxCDOx5Q4GMC8o7SUYq5AawpWMpDvsezthn41IJe+HO5G7F+mk7jDcEtwi/FT2JCq0xgYh78YrlqcO+n593+MlJJeIQYuseuReMY+QRGn506jArtwo6VSDFkF5A90NjPylJmgGsu+AZk6uqTkqWLyaRdoXCv12iaA3doCyt/HbLKXodqanLwMjWeZmcEre0uW9bt0UuvWOtoWtk7Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bY/WzmSAdUJL9CFEZO0ImygcVkQ2Kn4fuLtEx0hwtVc=;
 b=fZWZjzpwdYAAifPoxqt75QOeiK88/1BwbJ1a856MFaGTlgPoW0fFla5Q5lb5IsZDPowS6WAXFt1Biu1bHxSpGH1B/TSPee0SJr4FWcuNFYufh4TGFQYGCc4rHOdf4SFjOYExm2JqkINt7s1PUfwCjkh9+U/e/6esjWJASDB5B940j0y5QwSh23kpNVbAH1SBZPvm+wL9In1W9CmrUBh7m57rNxbKGes51WcfxNYAZy0WxjpEHe4UNkn0yXxDxyK2sQO8qqZ2NidlshrIrmVvf8CAoLQQ0RpUhTWXkmK30IS3mcbmJl7blu0HN6Jl+juj/WpnJm2T7ArrB8szFwSirw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=openai.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bY/WzmSAdUJL9CFEZO0ImygcVkQ2Kn4fuLtEx0hwtVc=;
 b=TL1uqM+KTP/BYp3O6J5eWQ/5KO3khKA9S8bMglJ0zoQAfFIrtsAL7R+NZxxCkAHzyIdwEg9bsVR9pGH95mJVL557jXJMODyvuvVbD/XzAABmJJMhq/JVRTdsgci2G9LtgAh1eUQv7tsrBbFSnqrwDcnBtskU1WfwdfK4nDu5zV/TmTnd/uiG7ukmSOxFt0ai0twGPHrrZpknKhT/PkFTZRkP8eiaE+HR4Px9xoHnERw8aErrRg2LWhw9jXm7xs0ntde/oS7Dl1rgZlJv1OkIVOQYjy/AqcMAFKE1d84lDYdDqRScSx7lVO6a1pNU2TbfHupf/JI2GNHA8o/y9EQ8Rw==
Received: from SJ0PR05CA0119.namprd05.prod.outlook.com (2603:10b6:a03:334::34)
 by MN0PR12MB6150.namprd12.prod.outlook.com (2603:10b6:208:3c6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.15; Thu, 7 May
 2026 09:54:31 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::fe) by SJ0PR05CA0119.outlook.office365.com
 (2603:10b6:a03:334::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9891.11 via Frontend Transport; Thu,
 7 May 2026 09:54:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Thu, 7 May 2026 09:54:30 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 7 May
 2026 02:54:16 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Thu, 7 May 2026 02:54:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Thu, 7 May 2026 02:54:11 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Christoph Paasch <cpaasch@openai.com>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Mark Bloch" <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Daniel Borkmann <daniel@iogearbox.net>, "Jesper
 Dangaard Brouer" <hawk@kernel.org>, John Fastabend
	<john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Amery Hung
	<ameryhung@gmail.com>, Alexei Starovoitov <ast@kernel.org>
Subject: [PATCH net-next V6 3/3] net/mlx5e: Align header copy to cache line for Striding RQ non-linear
Date: Thu, 7 May 2026 12:53:30 +0300
Message-ID: <20260507095330.318892-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20260507095330.318892-1-tariqt@nvidia.com>
References: <20260507095330.318892-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|MN0PR12MB6150:EE_
X-MS-Office365-Filtering-Correlation-Id: d8587488-5f7f-4b31-29bc-08deac1ea26c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|7416014|36860700016|1800799024|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	qWiBLt2RGm/E8Or6Zr63Gzs+WOxAS7XlqGS0Fm4zYUc3MkNhRAD6c8/z9GAxR+1+R3MF2RKcpX7fWFqvkPCmV/NXDwTmAPUSxpnwZYoxf0CVDUcetfKtc9S1vMxhkrlqKm8WdONceC8TqiSAamU9g/T/Y7Wrt7Tc+l6ktj5nl5K8mDnHjNLWh8dG27E1Da73NQRpcUSjV3EFiyK232SRrngCQmk7GKmtfQAdvpgYzVMdD+mH1KHO5RhQWtlmy4IZnJ2NH1S7napVRxJJq7+TDe6ek13HRNPVMTJR5XFLOjQNgcXRyqbJQVz8WqTvNmheHtlD/Q1wG+cV9VEVEty7Jfj308qKzPhWSuERs/ghT1UlrL/6BxHUlrnafgTZlhA0CkfWFotLwAr4rVdfhIBrKzAB0enj9U3dBVTSDbDYQMOC/SI0X8J5MjInx49WgnS5rYIzW4zqlGxJFbAOT+R7p+FrPZ3mSPyXXjnxRH0IVdMnS7yErNG4LRUF3Bl/DVXPXZIkOc0uWlorjfBD6LK7VOxrOZqZQy2Zif4T9NswW4uW5YJ+rvQX7sWue5tTJKoxYrT8yoPCSrfptJaM4H3xSDuDrr6KGyzcqWt+Q0Xdvmz8FSXsdideHY563aXCnK2CyKiJF8p//XzVt6U6SBXOy7bHAFCD94L8XDwjA+T3QQuMIT5x38USkPWvojZ6FzH0V3/xLIszEI0yL7Nae7IoQvuVoUwXjG/UPjcxSnrFvVk=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(7416014)(36860700016)(1800799024)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	cp0rNq7cjbsyt9iQZndMbuqLDxW6MvCWit1QCiNtoFVo5yUUaOd7I7/ARCniFQfYJHkvQlXZpVKSJwFe85Fbr1hi42Q4wUbUaLJH+KFfAZA4c3VOwkZCczKy2Zd/PuyN0AEXrKw+5ApmYUV//betmbJdeX4UJhhBcs+J527iTv+7b4KaV8WGm05NxmoTIWeys8+/cTrck2r2U/pkK5EYEoR8FX/0JKI+xLfB53218/iChnMv22qV1ZSsxGrjl8JAJGs+/yJ8Z1SvDBNqiG7zDkvE2zRh2dL5QV2QMwHn8TnZp2Lx1hAIFbF6qpiMFlfWpn33D9puQe+BGunWvnLDFQBNpbCu7w6BBmE0NG19wuDoLQ58abbmi/Zeg5Y7ymTx4LZrQYpo7E1RqwJ/mZzvtbsJpryFUO/Sc4rQbpOtfnKRnF1vFmS6lt7OhU+cGDOc
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:54:30.6939
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8587488-5f7f-4b31-29bc-08deac1ea26c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6150
X-Rspamd-Queue-Id: B18C34E64E1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[nvidia.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[Nvidia.com:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[nvidia.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-20127-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[Nvidia.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tariqt@nvidia.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[Nvidia.com:dkim,nvidia.com:email,nvidia.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-rdma,netdev];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Action: no action

From: Dragos Tatulea <dtatulea@nvidia.com>

In Striding RQ non-linear mode, there is a memcpy to pull the
header from the first fragment into the linear part of the skb.
As the header length is not aligned, it can cause cache thrashing
from a Read-Modify-Write cycle for the remaining bytes of the
cache line.

This patch changes the memcopy length to be aligned to the cache line.
The DMA sync is also aligned to cache line size accordingly. Note that
the original DMA sync is done on the initial conservative headlen
which is min(MLX5E_RX_MAX_HEAD, cqe_bcnt).

To show the improvement, a test was run with an XDP_DROP program
processing 64B packets at 100% CPU utilization over a single queue at
9000 MTU:

|----------+----------+------|
| Before   | After    | Diff |
|----------+----------+------|
| 3.6 Mpps | 3.8 Mpps | 5%   |
|----------+----------+------|

(CX7 NIC on Intel Xeon Platinum 8580 system)

While small packets profit most from this improvement, large packets
are not negatively affected (no regressions).

Suggested-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 301b33419207..e5963e1b5309 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1973,7 +1973,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 		addr = page_pool_get_dma_addr_netmem(head_page->netmem);
 		dma_sync_single_for_cpu(rq->pdev, addr + head_offset,
-					ALIGN(headlen, sizeof(long)),
+					ALIGN(headlen, cache_line_size()),
 					rq->buff.map_dir);
 
 		headlen = eth_get_headlen(rq->netdev, head_addr, headlen);
@@ -2086,7 +2086,7 @@ mlx5e_skb_from_cqe_mpwrq_nonlinear(struct mlx5e_rq *rq, struct mlx5e_mpw_info *w
 
 		/* copy header */
 		skb_copy_to_linear_data(skb, head_addr,
-					ALIGN(headlen, sizeof(long)));
+					ALIGN(headlen, cache_line_size()));
 
 		/* skb linear part was allocated with headlen and aligned to long */
 		skb->tail += headlen;
-- 
2.44.0


