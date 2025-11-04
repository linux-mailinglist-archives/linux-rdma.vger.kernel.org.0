Return-Path: <linux-rdma+bounces-14226-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D202C2F7C4
	for <lists+linux-rdma@lfdr.de>; Tue, 04 Nov 2025 07:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 84AC834B741
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Nov 2025 06:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CAA028D83D;
	Tue,  4 Nov 2025 06:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BeLk8iE1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013056.outbound.protection.outlook.com [40.107.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EDE288CA3;
	Tue,  4 Nov 2025 06:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762238954; cv=fail; b=lgYOv8oxawNNQjJZvnSvKXgz+eBxd1nA7pIPlt1U58KHjHcYt6PAtpTefkZ1MU+8Jheo1Uqbfj+iZNPRBNm3JnrZgCsxuvTN8UqhGoMMpXME6JWXO7tcmlv0+eCxPpaDHLyWwQj6q/7A3u2UAuy+6HSEsqgCW8KkZd7ZeL24kF8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762238954; c=relaxed/simple;
	bh=8Ewc+YoWg/Kz6Rm4FKclEzZEbPWunnzkH5OjVBCaoXY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZM6QDsjGs6ukFrQijptZ2vbMBCfqRHzYllhBtcdo3Qd44UaxCftFCkp8ns9TUAWJjnvkagnyXj41/4vn+CGhrdy5ydOK4QXjL9YPFM0OO+jikWMH+TE5m5VxhSWljmhUMj0ZCMwieu8Ma7o3lmAKLuTwVHkOKEbWTX0p88yano=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BeLk8iE1; arc=fail smtp.client-ip=40.107.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qEt97NXmaV5rhyfN+tuTwPwcAk0+4rHSqu5fjV8ayaWg0OdrHn4xBBU9RJd4uIwIBZK5oCJjLKx1G19ufDrHc0y2qCcCVZ2s0U0HQ9UwEL+I9zb8dIHaUwArU1IRd0buyqjFNwLNosjSkm0cA1E9bkuNW8FL7fwyHiGHLAreSDyh9pOXtYsfw2X63P4yYrm+2Jr2MHzRTOfpVMpcH6LwVer5tI/QLy/1P/oiZYo5u2LmPAckCMJEpz09pxXJ9ImEKslbPy4Z6uyqRkqivgzJ1z3Qa+pzvoTURWfMMuyT1QZ97FBmRoTOiQtMGgHCphpm67Senrq4qBLps3vaujcSMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlzQVZTi2j/DuDTVjddSV86ZBN2KscScXfQwYsyRILE=;
 b=VgubRPtqsCA+5BWS93AMQYHcr0dU1+S8oIayv0PsFQW/lp1w9+l9I6zNEg94RixT5nAtjJ3MMASU2sxDO+WYi4t8OH2YAB7JaPjxD+WGOSeblLzSH4dj1askHv3Yi5jQuqObwOaYiy+YCgQKbRgmVkuQgrT1IVOS8rbDGQy/BLl+DD6E+cCGZUBPXMUBa5/XWUxNATH53Q85p+xxjq0Ebz8bKW2xnk7rAAf98anTofpeTPb8Ph+lDBdwpekAtN2t0oj5CeviuFM7iyyM+aIxVDi6oTqNG5xf19RiCUtPTJsG1V6K0dmHLE55rljoJ85G3MgooHBrJ9Zm7rAekvsgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlzQVZTi2j/DuDTVjddSV86ZBN2KscScXfQwYsyRILE=;
 b=BeLk8iE1RnmZWu0/8JbnB7qlsgSvX/YQUgk5hwrGCwukNRk8fmhkkRZzncJqzdtO+NDHccAeaa/xYf1lCXR/MI+hXk18CVzdLbcVOfv6ja8dynCw4uLrwccIMkiNnjXjIlpeD98tQoZygHtfTQSTANFCf5vYe90348YWYtVmSzC0um7T3fW893JHxqFndTRjsVsR1b3aBnfxJzKW5DebFSXon3VP+4Be2YIf5SGcclJRFXFiKVKGmAp+k/cp0SSAjI8uDdoFJF/6QYm3acQh9AS/q08of6oZiy5S5mQNPNMu0gLCTQ0MaMxXA5nhgJIO1Lk9skLdHznA/h3WGWGy7g==
Received: from CH0PR03CA0005.namprd03.prod.outlook.com (2603:10b6:610:b0::10)
 by SA3PR12MB9198.namprd12.prod.outlook.com (2603:10b6:806:39f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Tue, 4 Nov
 2025 06:49:07 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::d7) by CH0PR03CA0005.outlook.office365.com
 (2603:10b6:610:b0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.16 via Frontend Transport; Tue,
 4 Nov 2025 06:49:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 06:49:06 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 3 Nov
 2025 22:48:55 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 3 Nov 2025 22:48:55 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 3 Nov 2025 22:48:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Simon Horman <horms@kernel.org>
Subject: [PATCH net V2 1/3] net/mlx5e: SHAMPO, Fix header mapping for 64K pages
Date: Tue, 4 Nov 2025 08:48:33 +0200
Message-ID: <1762238915-1027590-2-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SA3PR12MB9198:EE_
X-MS-Office365-Filtering-Correlation-Id: 38a08ca3-2f71-4b11-89af-08de1b6e4027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Mh6eyG/4N/2xZrc3Y/7mdOA19GCAg+B6lLJfhFUf7nG/UUDNgQI3aFocbwjU?=
 =?us-ascii?Q?IjFKHEGrxi6Yr8AGrNXvx1HqW0DsG2dvE9fyJCf98JJefxxCz5cDUMUuHIpz?=
 =?us-ascii?Q?KJxnpyiUjNrI6XCZbpAxEx7xAhk0GwP7bqojzrXrlwps/P6ABX8HIl0hNjH6?=
 =?us-ascii?Q?yZq3Ye5CyllQEnbmgINkaeH6L/e7p2rNoMSYLlSIBiNPsL/hVpUSic7RgdZ8?=
 =?us-ascii?Q?DqGvm2ryDSD4WFmyudgXS1BZsOqZm9J5jVgO5IpFcZV+eKCuwXo3KQkx/gWI?=
 =?us-ascii?Q?MBuhZ1FNTKTHXT1lZMWqTIPzLlPXkGBifRApM2JQw6eP/bfU7s/ZRJfGcEq4?=
 =?us-ascii?Q?2SU3ROkGUJu/xG9g+DL63fFvqpnUF3oM44EgGWk6+ekoS2FGafGqkaQl+4Le?=
 =?us-ascii?Q?UweOPA6a/1UP+ru+US3XMCJ2FhJ2gk79Xxvs6bUBLKJrGC2Cno/YG2UNZ+fg?=
 =?us-ascii?Q?5nO5sYZnsuRzJVgKhMaAMezD4yc4Z7GClbK/UaqTkU8sMntC92jp2OidXd7M?=
 =?us-ascii?Q?7bwxW5rGsUY7ugdwT+PJyN3IjgQ9h+L30t9573a66Isuj6FOhXndpQkalsdu?=
 =?us-ascii?Q?tyvxUFgXx0n8zh7Iw/Dlo+qtvNfDSMuzgjQFJV9sz14Fp5YyyqQLnwwejh7x?=
 =?us-ascii?Q?QgRTlY4WJv9cYxT0PGgnHjeng4zOrey5Hz467oGf1Y+RsofVpQP25xKEMmW0?=
 =?us-ascii?Q?u0E6Csp1IvuRUV54pL2DMvmSSWav6QIucZTvwm366Acu9StKvufa5EcoeFSm?=
 =?us-ascii?Q?01g7Kg3g4YwWBBb7UnozNLY1ADQPjM2BaaiN0v2f8hNUK9O5Q6VI9MuSShXs?=
 =?us-ascii?Q?2nO8FO92vT7VL3lAbyQ2weToxfXnUxZHr1M9R3u0EOdHgUacK6hVbePRG7et?=
 =?us-ascii?Q?tiZSAHsUAKxLwv85PZ8w/T03/pzbEkI6A5Ksrz1mST++s5YJDM2PQIewO/AC?=
 =?us-ascii?Q?djQLTI5onInxCoaVYpZk8OZ5nm4aHB3slbqE+ufGaU05UxOOfv3qzVODcWXK?=
 =?us-ascii?Q?1nww4hV/5liPz9Z5p82MaogVFpbhND5NJBOJC3Vx3s6JSgyEnKhKfexy0xPr?=
 =?us-ascii?Q?JhHhXV6mOrR2nF37r1fGjoCdIAL1gS03tOyQVY3Gr1r+iJjxiAltydRRI2rK?=
 =?us-ascii?Q?Kt3kpIrMq28PaeapiPh7djGv3h5uFFV9hePbsNztye40sTSTig3KRdGQ/Y66?=
 =?us-ascii?Q?V2nJAyN75rN06XQBZ6addKDFFVse+RUEKS+H64Vrc4h6Fejh++G3PoufYGan?=
 =?us-ascii?Q?SZ78+m071//eBa8zI80pwJes3XrgLwiAa6cQOBcRDo9s6/LqrX1JVv29AcfA?=
 =?us-ascii?Q?dYPHO9YUAO+O1MMT+DOdWskE+1o6Lq2IDVn+pC/SYKn1MWyjbqKBzb4odeAB?=
 =?us-ascii?Q?XfzN7aBQxeEjVQmV3PuPZzxZlirz98Oo2Traec84dKeTIq9egDP2GBgb/Jw0?=
 =?us-ascii?Q?EG6BK9OUBzwdgDmruj3HHi1Wy/LF+ZTpO8EG99iRWagLijpJbXkB/RKzyU/F?=
 =?us-ascii?Q?qj8t/AjJELvaH3ZiJlCS+N5jt5deTj1tn7H3kkX0oegt8WMqzIiefKOqnUDu?=
 =?us-ascii?Q?5twnJNoUcIrn4VheBbA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 06:49:06.8370
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a08ca3-2f71-4b11-89af-08de1b6e4027
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9198

From: Dragos Tatulea <dtatulea@nvidia.com>

HW-GRO is broken on mlx5 for 64K page sizes. The patch in the fixes tag
didn't take into account larger page sizes when doing an align down
of max_ksm_entries. For 64K page size, max_ksm_entries is 0 which will skip
mapping header pages via WQE UMR. This breaks header-data split
and will result in the following syndrome:

mlx5_core 0000:00:08.0 eth2: Error cqe on cqn 0x4c9, ci 0x0, qn 0x1133, opcode 0xe, syndrome 0x4, vendor syndrome 0x32
00000000: 00 00 00 00 04 4a 00 00 00 00 00 00 20 00 93 32
00000010: 55 00 00 00 fb cc 00 00 00 00 00 00 07 18 00 00
00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 4a
00000030: 00 00 3b c7 93 01 32 04 00 00 00 00 00 00 bf e0
mlx5_core 0000:00:08.0 eth2: ERR CQE on RQ: 0x1133

Furthermore, the function that fills in WQE UMRs for the headers
(mlx5e_build_shampo_hd_umr()) only supports mapping page sizes that
fit in a single UMR WQE.

This patch goes back to the old non-aligned max_ksm_entries value and it
changes mlx5e_build_shampo_hd_umr() to support mapping a large page over
multiple UMR WQEs.

This means that mlx5e_build_shampo_hd_umr() can now leave a page only
partially mapped. The caller, mlx5e_alloc_rx_hd_mpwqe(), ensures that
there are enough UMR WQEs to cover complete pages by working on
ksm_entries that are multiples of MLX5E_SHAMPO_WQ_HEADER_PER_PAGE.

Fixes: 8a0ee54027b1 ("net/mlx5e: SHAMPO, Simplify UMR allocation for headers")
Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   | 36 +++++++++----------
 1 file changed, 17 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 26621a2972ec..0c031954ca30 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -671,7 +671,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	u16 pi, header_offset, err, wqe_bbs;
 	u32 lkey = rq->mdev->mlx5e_res.hw_objs.mkey;
 	struct mlx5e_umr_wqe *umr_wqe;
-	int headroom, i = 0;
+	int headroom, i;
 
 	headroom = rq->buff.headroom;
 	wqe_bbs = MLX5E_KSM_UMR_WQEBBS(ksm_entries);
@@ -679,25 +679,24 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	umr_wqe = mlx5_wq_cyc_get_wqe(&sq->wq, pi);
 	build_ksm_umr(sq, umr_wqe, shampo->mkey_be, index, ksm_entries);
 
-	WARN_ON_ONCE(ksm_entries & (MLX5E_SHAMPO_WQ_HEADER_PER_PAGE - 1));
-	while (i < ksm_entries) {
-		struct mlx5e_frag_page *frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
+	for (i = 0; i < ksm_entries; i++, index++) {
+		struct mlx5e_frag_page *frag_page;
 		u64 addr;
 
-		err = mlx5e_page_alloc_fragmented(rq->hd_page_pool, frag_page);
-		if (unlikely(err))
-			goto err_unmap;
+		frag_page = mlx5e_shampo_hd_to_frag_page(rq, index);
+		header_offset = mlx5e_shampo_hd_offset(index);
+		if (!header_offset) {
+			err = mlx5e_page_alloc_fragmented(rq->hd_page_pool,
+							  frag_page);
+			if (err)
+				goto err_unmap;
+		}
 
 		addr = page_pool_get_dma_addr_netmem(frag_page->netmem);
-
-		for (int j = 0; j < MLX5E_SHAMPO_WQ_HEADER_PER_PAGE; j++) {
-			header_offset = mlx5e_shampo_hd_offset(index++);
-
-			umr_wqe->inline_ksms[i++] = (struct mlx5_ksm) {
-				.key = cpu_to_be32(lkey),
-				.va  = cpu_to_be64(addr + header_offset + headroom),
-			};
-		}
+		umr_wqe->inline_ksms[i] = (struct mlx5_ksm) {
+			.key = cpu_to_be32(lkey),
+			.va  = cpu_to_be64(addr + header_offset + headroom),
+		};
 	}
 
 	sq->db.wqe_info[pi] = (struct mlx5e_icosq_wqe_info) {
@@ -713,7 +712,7 @@ static int mlx5e_build_shampo_hd_umr(struct mlx5e_rq *rq,
 	return 0;
 
 err_unmap:
-	while (--i) {
+	while (--i >= 0) {
 		--index;
 		header_offset = mlx5e_shampo_hd_offset(index);
 		if (!header_offset) {
@@ -735,8 +734,7 @@ static int mlx5e_alloc_rx_hd_mpwqe(struct mlx5e_rq *rq)
 	struct mlx5e_icosq *sq = rq->icosq;
 	int i, err, max_ksm_entries, len;
 
-	max_ksm_entries = ALIGN_DOWN(MLX5E_MAX_KSM_PER_WQE(rq->mdev),
-				     MLX5E_SHAMPO_WQ_HEADER_PER_PAGE);
+	max_ksm_entries = MLX5E_MAX_KSM_PER_WQE(rq->mdev);
 	ksm_entries = bitmap_find_window(shampo->bitmap,
 					 shampo->hd_per_wqe,
 					 shampo->hd_per_wq, shampo->pi);
-- 
2.31.1


