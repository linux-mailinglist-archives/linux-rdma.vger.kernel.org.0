Return-Path: <linux-rdma+bounces-13716-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB59BA788B
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:27:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59D361897F4E
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6578B2C0F7E;
	Sun, 28 Sep 2025 21:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Nlz9Rv4F"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010071.outbound.protection.outlook.com [52.101.85.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C129ACF0;
	Sun, 28 Sep 2025 21:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094775; cv=fail; b=E8uDlxr4bNOoY66KTKj0ylNdkxOF5ARA6hGQXXpSVDE2C/6LdGDw15cDAl3A2T21Dm5TmWpgnaPceEqCsrTvivBHR87MOHk4I6tAQmohSBdeMGBAAL5EgiOenBmqt5fKrhPfkPt6ESrukV37+EHaltm0prvybfDXl57Prq5JtCA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094775; c=relaxed/simple;
	bh=s2NG4JqLZcJM9xOsOhgnxFVuwPtp50A6NWpDDPMTnDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TPupJKt4g1qlqUDTLOMdGJ/Q0EZj+nwMz0BvfwCr4ruoyH7Siz5+D1ydzu78gXfQgukeQlnAw25/CwsIAnLTTVkhdCvHSj6dNCmTESOxL9cXw6AC0JjMZZRq6dN6eRQlIC0GqjGN73JiMpkWFgrqMF0MUZZsJXJd7yt7fWptiVk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Nlz9Rv4F; arc=fail smtp.client-ip=52.101.85.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E8hfkMFwD/8rkuR3DbChZIywaLGAC4x18iGrnVppoQBSWgDaCG9n9jG/S6DXMjLltMF9Z4ZOZeOaahxWggF/pSxDHG4nil1a25RnEVSfijoGZH3cOEohwyKnrRhHNplPMQWXtv32witQHZm4XApIR6PghrF7plznfS8D1RmZgktCdkHsZZjUiw6ycuIsYvUmIQFYXLOXeFfphez9XwUp684KUkjJKTRtWUOWKFj/FntseSo/HB1lqERQ8H4s4HIHphLarWt7uFRXT/U6oE+FHfOV4nEkpxQpUXzJBIp1D9wgsPSeZ5lBPSpp7LLMCQs7lKwOuan/dORSNQBeuVBLAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8JBkxXRcG8ne3/d/sUhn721Rv+N5uY1DO2Jmc91n/o=;
 b=KJAjUPKlQXked0ZyH4eSeTvFTMZ6zlGtEjNMC/HI0L2qLjgC1h1Nc9nwONBnbpS+Vi548zEhElWdaJutBCwMSk5vvZ7MD4pPRYj1XR+mrVXBrZ/tvN5+J6zIowpUP3tsp3XhxBxTz3Ha/MBlBMQJAr0oA8bp8kHaHjAr+m/Sg2j3zE4NgB0PafpkAQ5U12dqVZzklUfyiZrVxWFL032KGim3zJcHDT9v0ROSl8KCa5j76fs1xJhBZI8nMNXQwU54qz9tMhl0/i0UA6dCtkV9INC4Q+1cRu84bfkBUC4FRTf0w800nM8tHm5EinJLN3T0zep0OW32aFgLE/O39iBq+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8JBkxXRcG8ne3/d/sUhn721Rv+N5uY1DO2Jmc91n/o=;
 b=Nlz9Rv4Fq8fni15Oog84XpMLfsZIWnyoyx+5XG7B5sLCVGQFYbR+MT7dKlHYJLfDz4WLkJVFwRJDr1uukm8DhklpwT1rknKN+n5M4JlU2gFYrW+sOGbf7zt3cJbW1lY7nk0kkLOOuqYgtUucR1RLJoHaAV0gMJyWChpRsfJVTLDXlL3cqQH52ppggxubpvUM2yORlDjUH+B2p9PlEz5c/22g46B/H/5xhPpafF0EmHLagHY8k/ZtZ4N7/lqFlrym6/fQC021aHDIRpKJpqNCvaHvB9ZvFVYc+kwOO5qc/cJfULISsMgkbPBgPAsXMCve4m1o+xUSTCaLYBnUag7OPA==
Received: from MW4PR04CA0206.namprd04.prod.outlook.com (2603:10b6:303:86::31)
 by DM3PR12MB9414.namprd12.prod.outlook.com (2603:10b6:0:47::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 21:26:06 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:303:86:cafe::2) by MW4PR04CA0206.outlook.office365.com
 (2603:10b6:303:86::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.15 via Frontend Transport; Sun,
 28 Sep 2025 21:26:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:26:06 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:26:05 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:26:05 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:26:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next V2 5/7] net/mlx5e: Introduce mlx5e_rss_init_params
Date: Mon, 29 Sep 2025 00:25:21 +0300
Message-ID: <1759094723-843774-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
References: <1759094723-843774-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|DM3PR12MB9414:EE_
X-MS-Office365-Filtering-Correlation-Id: 0be013ad-53e4-4cfe-590d-08ddfed5a26a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BS16kGnGdDq5mAOFdkJ+Phk7kYIUaVugekBjHI+LmopfTJMAxYW6yPT0tqnQ?=
 =?us-ascii?Q?4/Np58BAcpizdCTD1PmZx9FFMEvjFq+JYQ6mkAGAREdVUCkc3ta5L0EcPJXo?=
 =?us-ascii?Q?M1TywQLw+JMMkMnHM/gXapSxqSGp9fbfnAysQbG7FaYigWrYZxXMVfp8MM3U?=
 =?us-ascii?Q?dWBhuYnrpVQTDrgMnQOMjDu9geXLEzWuSdx6gkQVT9Mlta0BmZnJ0H/OB9Qz?=
 =?us-ascii?Q?xLnmR7k6fZ4mLc1LuRNWT1cVjMm+JipuJp+Gk1IQ0dj0RQ+5HeZfkMXFdNcD?=
 =?us-ascii?Q?hyr6XIhGPsOJLAd2KT+2YFWLYnoMHFTz+dp2ILdiaBwdMrtcJ9IPsy10AVmH?=
 =?us-ascii?Q?zamEY9cCAQoENstm5MNO2orDY8RkZ/m8BeBNNSo+pDin6ZqnwjHCNIgYK8Ul?=
 =?us-ascii?Q?QF3fTXnq1JW9r1hHhXYzXiYcxbu449xsJjq/d4FHlTpH2zOEKHtHHihxP2Bb?=
 =?us-ascii?Q?rphaOhaEfd2im78AgCpWUJ9IiB37MK37isqdtClAhqv/nS08vmw3mBr9/Bqe?=
 =?us-ascii?Q?mNUkVSL8dO4JgaAoNtl/duWNbK+uoRry0r7pMxYcwpD0v1DWyXD0fqSYpax5?=
 =?us-ascii?Q?fFk/rT/mdcm/NOavIAR8Hwo8u5FIDpNsOXDHO1o55gfGVQ9c8tZ4AyTIQ0ra?=
 =?us-ascii?Q?0zPhwofp0ZIAfirpGj/aV/TPFT1wp/sV4myYwX6UPy4uTjFrvpj5AGLYMnHO?=
 =?us-ascii?Q?ttVB3tEb0PHGMDnvc623l6ZL9r9m1KCnZwBoCwiJ5CdsqJebIvhoPHCQ+s1N?=
 =?us-ascii?Q?UFKoWvMeOCY3sF3G4SdgrI3PfhjKOC+4kwq4PRxP/WOv5aS9NWuze9ChduYE?=
 =?us-ascii?Q?PZJQOTkWRdcVI/nCNRPkNFtQacoITni3o5f1vZLk+6csNeSbf3JfFCI3AC0f?=
 =?us-ascii?Q?M3lskyvy7oBraSBKpPivosMON4s48GNmNg2M2AOQTV+7YcwHzpxNF0s6ShHL?=
 =?us-ascii?Q?WSr8VTDST6Dzg4BINCMsi5MzuBpkQcjQbuxNZ1UUOxuh5FH4J7IUB6uPd4F0?=
 =?us-ascii?Q?QERE9jFNro8t45uubLuSwPzBUjO4W8OB22xC6MvYfUrrRivY9Jy1mpuUhQXG?=
 =?us-ascii?Q?a4uwYnTpwIG58gu/R/0fmHKRv6XPyRinra46Yk8Ws4+W4SDTuWW7szGNN2nX?=
 =?us-ascii?Q?aAaliTApzlUYdPyLmvvJrK6836Q1Ii/QtkE+HFtFlYhZn+XQ3IPQUMmv49o2?=
 =?us-ascii?Q?+0zlNKqEqKFOkWPjX5NmClgT/5Vv7VrtXQO20I+AWWLEybkZbm40Sq2BWrlT?=
 =?us-ascii?Q?IfUSBEeTluwuwIfSjQNGhas2Jojvvgy9dTMChhJM7wmpley0r+SSXl51N5Z1?=
 =?us-ascii?Q?M9CY2AZP1EFD6gTExj3STNvAkeK1L89lykPbBc1+VMN93r5XbfFhOjg+zmD6?=
 =?us-ascii?Q?lfWRwkO37u0aSETTPZU7Davih9EqwA+fG7/QXgWMqv4FIQ/t/9i5xoxjdF48?=
 =?us-ascii?Q?2YUo5YUhA5vhiUfjQ6hux8CtBQBDKRYOeGTcD7pW1yP2fqZ76bFyzCVr0c0A?=
 =?us-ascii?Q?sJaE+wtQywsusYBp9fUjh/Dlr/2qXHUP4cdu+0D8AnpgszT5lvICm4q/pJRA?=
 =?us-ascii?Q?NXVVB5nCjDISTep/LEU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:26:06.1941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0be013ad-53e4-4cfe-590d-08ddfed5a26a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9414

From: Carolina Jubran <cjubran@nvidia.com>

Introduce a dedicated structure to group RSS initialization parameters
that are only used during RSS creation, and drop the "init" prefix
from pkt_merge_param.

No functional changes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  | 49 ++++++++++---------
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  | 22 ++++++---
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   | 29 ++++++++---
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |  2 +-
 4 files changed, 63 insertions(+), 39 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index 6422eeabc334..c3eeeec62129 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -193,10 +193,10 @@ mlx5e_rss_get_tt_config(struct mlx5e_rss *rss, enum mlx5_traffic_types tt)
 	return rss_tt;
 }
 
-static int mlx5e_rss_create_tir(struct mlx5e_rss *rss,
-				enum mlx5_traffic_types tt,
-				const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-				bool inner)
+static int
+mlx5e_rss_create_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
+		     const struct mlx5e_packet_merge_param *pkt_merge_param,
+		     bool inner)
 {
 	struct mlx5e_rss_params_traffic_type rss_tt;
 	struct mlx5e_tir_builder *builder;
@@ -229,7 +229,7 @@ static int mlx5e_rss_create_tir(struct mlx5e_rss *rss,
 	rqtn = mlx5e_rqt_get_rqtn(&rss->rqt);
 	mlx5e_tir_builder_build_rqt(builder, rss->mdev->mlx5e_res.hw_objs.td.tdn,
 				    rqtn, rss->inner_ft_support);
-	mlx5e_tir_builder_build_packet_merge(builder, init_pkt_merge_param);
+	mlx5e_tir_builder_build_packet_merge(builder, pkt_merge_param);
 	rss_tt = mlx5e_rss_get_tt_config(rss, tt);
 	mlx5e_tir_builder_build_rss(builder, &rss->hash, &rss_tt, inner);
 
@@ -265,15 +265,16 @@ static void mlx5e_rss_destroy_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types
 	*tir_p = NULL;
 }
 
-static int mlx5e_rss_create_tirs(struct mlx5e_rss *rss,
-				 const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-				 bool inner)
+static int
+mlx5e_rss_create_tirs(struct mlx5e_rss *rss,
+		      const struct mlx5e_packet_merge_param *pkt_merge_param,
+		      bool inner)
 {
 	enum mlx5_traffic_types tt, max_tt;
 	int err;
 
 	for (tt = 0; tt < MLX5E_NUM_INDIR_TIRS; tt++) {
-		err = mlx5e_rss_create_tir(rss, tt, init_pkt_merge_param, inner);
+		err = mlx5e_rss_create_tir(rss, tt, pkt_merge_param, inner);
 		if (err)
 			goto err_destroy_tirs;
 	}
@@ -359,10 +360,9 @@ static int mlx5e_rss_init_no_tirs(struct mlx5e_rss *rss)
 				     rss->drop_rqn, rss->indir.max_table_size);
 }
 
-struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
-				 const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-				 enum mlx5e_rss_init_type type, unsigned int nch,
-				 unsigned int max_nch)
+struct mlx5e_rss *
+mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
+	       const struct mlx5e_rss_init_params *init_params)
 {
 	u32 rqt_max_size, rqt_size;
 	struct mlx5e_rss *rss;
@@ -372,8 +372,8 @@ struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_suppo
 	if (!rss)
 		return ERR_PTR(-ENOMEM);
 
-	rqt_size = mlx5e_rqt_size(mdev, nch);
-	rqt_max_size = mlx5e_rqt_size(mdev, max_nch);
+	rqt_size = mlx5e_rqt_size(mdev, init_params->nch);
+	rqt_max_size = mlx5e_rqt_size(mdev, init_params->max_nch);
 	err = mlx5e_rss_params_indir_init(&rss->indir, rqt_size, rqt_max_size);
 	if (err)
 		goto err_free_rss;
@@ -386,15 +386,18 @@ struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_suppo
 	if (err)
 		goto err_free_indir;
 
-	if (type == MLX5E_RSS_INIT_NO_TIRS)
+	if (init_params->type == MLX5E_RSS_INIT_NO_TIRS)
 		goto out;
 
-	err = mlx5e_rss_create_tirs(rss, init_pkt_merge_param, false);
+	err = mlx5e_rss_create_tirs(rss, init_params->pkt_merge_param,
+				    false);
 	if (err)
 		goto err_destroy_rqt;
 
 	if (inner_ft_support) {
-		err = mlx5e_rss_create_tirs(rss, init_pkt_merge_param, true);
+		err = mlx5e_rss_create_tirs(rss,
+					    init_params->pkt_merge_param,
+					    true);
 		if (err)
 			goto err_destroy_tirs;
 	}
@@ -470,10 +473,10 @@ bool mlx5e_rss_valid_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt, bool
 /* Fill the "tirn" output parameter.
  * Create the requested TIR if it's its first usage.
  */
-int mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss,
-			  enum mlx5_traffic_types tt,
-			  const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-			  bool inner, u32 *tirn)
+int
+mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
+		      const struct mlx5e_packet_merge_param *pkt_merge_param,
+		      bool inner, u32 *tirn)
 {
 	struct mlx5e_tir *tir;
 
@@ -481,7 +484,7 @@ int mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss,
 	if (!tir) { /* TIR doesn't exist, create one */
 		int err;
 
-		err = mlx5e_rss_create_tir(rss, tt, init_pkt_merge_param, inner);
+		err = mlx5e_rss_create_tir(rss, tt, pkt_merge_param, inner);
 		if (err)
 			return err;
 		tir = rss_get_tir(rss, tt, inner);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index 616097c8770e..80225709675b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -13,6 +13,13 @@ enum mlx5e_rss_init_type {
 	MLX5E_RSS_INIT_TIRS
 };
 
+struct mlx5e_rss_init_params {
+	enum mlx5e_rss_init_type type;
+	const struct mlx5e_packet_merge_param *pkt_merge_param;
+	unsigned int nch;
+	unsigned int max_nch;
+};
+
 struct mlx5e_rss_params_traffic_type
 mlx5e_rss_get_default_tt_config(enum mlx5_traffic_types tt);
 
@@ -22,10 +29,9 @@ int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
 				u32 actual_table_size, u32 max_table_size);
 void mlx5e_rss_params_indir_cleanup(struct mlx5e_rss_params_indir *indir);
 void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels);
-struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
-				 const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-				 enum mlx5e_rss_init_type type, unsigned int nch,
-				 unsigned int max_nch);
+struct mlx5e_rss *
+mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_support, u32 drop_rqn,
+	       const struct mlx5e_rss_init_params *init_params);
 int mlx5e_rss_cleanup(struct mlx5e_rss *rss);
 
 void mlx5e_rss_refcnt_inc(struct mlx5e_rss *rss);
@@ -37,10 +43,10 @@ u32 mlx5e_rss_get_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
 		       bool inner);
 bool mlx5e_rss_valid_tir(struct mlx5e_rss *rss, enum mlx5_traffic_types tt, bool inner);
 u32 mlx5e_rss_get_rqtn(struct mlx5e_rss *rss);
-int mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss,
-			  enum mlx5_traffic_types tt,
-			  const struct mlx5e_packet_merge_param *init_pkt_merge_param,
-			  bool inner, u32 *tirn);
+int
+mlx5e_rss_obtain_tirn(struct mlx5e_rss *rss, enum mlx5_traffic_types tt,
+		      const struct mlx5e_packet_merge_param *pkt_merge_param,
+		      bool inner, u32 *tirn);
 
 void mlx5e_rss_enable(struct mlx5e_rss *rss, u32 *rqns, u32 *vhca_ids, unsigned int num_rqns);
 void mlx5e_rss_disable(struct mlx5e_rss *rss);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
index a2acbfee2b77..74dda61e92bc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.c
@@ -54,17 +54,25 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 				     unsigned int init_nch)
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
+	struct mlx5e_rss_init_params init_params;
 	struct mlx5e_rss *rss;
 
 	if (WARN_ON(res->rss[0]))
 		return -EINVAL;
 
+	init_params = (struct mlx5e_rss_init_params) {
+		.type = MLX5E_RSS_INIT_TIRS,
+		.pkt_merge_param = &res->pkt_merge_param,
+		.nch = init_nch,
+		.max_nch = res->max_nch,
+	};
+
 	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
-			     &res->pkt_merge_param, MLX5E_RSS_INIT_TIRS, init_nch, res->max_nch);
+			     &init_params);
 	if (IS_ERR(rss))
 		return PTR_ERR(rss);
 
-	mlx5e_rss_set_indir_uniform(rss, init_nch);
+	mlx5e_rss_set_indir_uniform(rss, init_params.nch);
 
 	res->rss[0] = rss;
 
@@ -74,18 +82,25 @@ static int mlx5e_rx_res_rss_init_def(struct mlx5e_rx_res *res,
 int mlx5e_rx_res_rss_init(struct mlx5e_rx_res *res, u32 rss_idx, unsigned int init_nch)
 {
 	bool inner_ft_support = res->features & MLX5E_RX_RES_FEATURE_INNER_FT;
+	struct mlx5e_rss_init_params init_params;
 	struct mlx5e_rss *rss;
 
 	if (WARN_ON_ONCE(res->rss[rss_idx]))
 		return -ENOSPC;
 
+	init_params = (struct mlx5e_rss_init_params) {
+		.type = MLX5E_RSS_INIT_NO_TIRS,
+		.pkt_merge_param = &res->pkt_merge_param,
+		.nch = init_nch,
+		.max_nch = res->max_nch,
+	};
+
 	rss = mlx5e_rss_init(res->mdev, inner_ft_support, res->drop_rqn,
-			     &res->pkt_merge_param, MLX5E_RSS_INIT_NO_TIRS, init_nch,
-			     res->max_nch);
+			     &init_params);
 	if (IS_ERR(rss))
 		return PTR_ERR(rss);
 
-	mlx5e_rss_set_indir_uniform(rss, init_nch);
+	mlx5e_rss_set_indir_uniform(rss, init_params.nch);
 	if (res->rss_active) {
 		u32 *vhca_ids = get_vhca_ids(res, 0);
 
@@ -438,7 +453,7 @@ static void mlx5e_rx_res_ptp_destroy(struct mlx5e_rx_res *res)
 struct mlx5e_rx_res *
 mlx5e_rx_res_create(struct mlx5_core_dev *mdev, enum mlx5e_rx_res_features features,
 		    unsigned int max_nch, u32 drop_rqn,
-		    const struct mlx5e_packet_merge_param *init_pkt_merge_param,
+		    const struct mlx5e_packet_merge_param *pkt_merge_param,
 		    unsigned int init_nch)
 {
 	bool multi_vhca = features & MLX5E_RX_RES_FEATURE_MULTI_VHCA;
@@ -454,7 +469,7 @@ mlx5e_rx_res_create(struct mlx5_core_dev *mdev, enum mlx5e_rx_res_features featu
 	res->max_nch = max_nch;
 	res->drop_rqn = drop_rqn;
 
-	res->pkt_merge_param = *init_pkt_merge_param;
+	res->pkt_merge_param = *pkt_merge_param;
 	init_rwsem(&res->pkt_merge_param_sem);
 
 	err = mlx5e_rx_res_rss_init_def(res, init_nch);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
index 1d049e2aa264..65a857c215e1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rx_res.h
@@ -27,7 +27,7 @@ enum mlx5e_rx_res_features {
 struct mlx5e_rx_res *
 mlx5e_rx_res_create(struct mlx5_core_dev *mdev, enum mlx5e_rx_res_features features,
 		    unsigned int max_nch, u32 drop_rqn,
-		    const struct mlx5e_packet_merge_param *init_pkt_merge_param,
+		    const struct mlx5e_packet_merge_param *pkt_merge_param,
 		    unsigned int init_nch);
 void mlx5e_rx_res_destroy(struct mlx5e_rx_res *res);
 
-- 
2.31.1


