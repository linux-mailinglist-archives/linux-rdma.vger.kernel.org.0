Return-Path: <linux-rdma+bounces-13559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05068B8FAFF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B400118A1627
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65D962FCBFD;
	Mon, 22 Sep 2025 09:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BRAm89QM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012006.outbound.protection.outlook.com [40.93.195.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12E2F9990;
	Mon, 22 Sep 2025 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531744; cv=fail; b=S78qnnKU6WzB9iYEWNb6z2xMp4Jr5Dy4xAx82QFmjhJDZtdtNW6ygAnZlxcNofdAyVnhlbVqFd7nqSLkEcbe09q6loDvpM8JeAl3prlodHKd6Tt0kGy9DuppBspxWPZohm7wU/OLUsF3YQqmdLU9b0sIqV0KdDo8+TE4Q9+/v+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531744; c=relaxed/simple;
	bh=s2NG4JqLZcJM9xOsOhgnxFVuwPtp50A6NWpDDPMTnDo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n1V9KLjkuVlgT/plyoqKhvdAPFT51wnoitPKtPuLvYmKQqgDBomeG93Em64NRHkItWRN64wYkBbruaK0vHcMMib7Qt4q7bQP3u4EIi4ZLs2FtTmwmWDlz0dDrP1j83Mc+M7r1wkKCY0kOjkIRreuvgpFpCzAXb6w6LDqwu7q3xU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BRAm89QM; arc=fail smtp.client-ip=40.93.195.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+eTMXErOIr4C4PwcpsIfnU0kARWjLWbGmdPNqrxNlbwbXU9c067xtDPURHLRfDbnaFgwwwqWj4jecfcEBkp/3rzsPDyiaPwaOOlsknei8Ng9A81eWQ0QP464m7hI0ck73aVpWg94MzolleQukBCD31ggM54r/Pb9KKxBWN3oYdRIq71GB7hRfjMzXBmuQqpWWRty0+Vmz8VadhemmFkqTw7ww1MiwwIgnHQzAv/Eglyb/DGbA2jaeu+IrgO4HA6P5bimeErz08WDzIjuLiyDrBe0i2PCrXIyVC0h16bY/drV6zGDmOPYaYbUN7Nyv92u54OYkN27LIrUKPfDpAozQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O8JBkxXRcG8ne3/d/sUhn721Rv+N5uY1DO2Jmc91n/o=;
 b=I37QX0MgbSVnonZJwE47+qAZMxGDNmmJX6QzZrFr9AwOBxZcnTyts3QkogTAhoqjt2IOPjRc3ZAIlLN52WABf/+qlhlQahHgmgoLMnqKR6l+Whzv6o3VOcfR1xvC3w929hQVMHMtg3AFmyRSJZL6IW8cC5llue6nU0eHEA8wXhi7BZE9k5z5Lg2N5tCjes7cDJBp6SKH9oNGkvnjtG0lX8FkYbxuGZzTHqFl14w4IOYW6UZ/rCsCABtSnX4g3Wrj4S52wYAaDLg/gIJuA4onM1gFNm3tqEXLpBuDdPa8zJitBS7BAj+YVbMJG2OKBsfkhbMwb7UW4vbvSmoPtekBAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O8JBkxXRcG8ne3/d/sUhn721Rv+N5uY1DO2Jmc91n/o=;
 b=BRAm89QM2BTsR78PUyhEoyQMmxZe7/tS3NWSION5TWxA+mueduUjdxC7AzBHHkHQjmCspafDK1Wo23230BzraZdmvTDlGFtsbr82OLN6N+xrH1IbXXU/JRjIKaPODpHe6LoT0Wc+zk3uh/z+SA6HJgtvZMjztPB6IqeDMDvJezsoimsNCEpUCnsCzyE1TYSVYfSNMcX/afATDAVWO5O0Z9eXLENVZOPgrqqlgBiAG4bY6mKtMBTyFtfuZm/W68BLGB1+Xnb37I0F3t1WLicqse4osRGIlZ0+xCeuAIbEOkkkOY4JA0mcpB425+Vp4cymXfegXfzk418ZYEfVDD4YoA==
Received: from CH2PR02CA0009.namprd02.prod.outlook.com (2603:10b6:610:4e::19)
 by DS0PR12MB6461.namprd12.prod.outlook.com (2603:10b6:8:c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Mon, 22 Sep
 2025 09:02:15 +0000
Received: from CH2PEPF00000149.namprd02.prod.outlook.com
 (2603:10b6:610:4e:cafe::d6) by CH2PR02CA0009.outlook.office365.com
 (2603:10b6:610:4e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.19 via Frontend Transport; Mon,
 22 Sep 2025 09:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CH2PEPF00000149.mail.protection.outlook.com (10.167.244.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:02:15 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:02:03 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Sep 2025 02:02:02 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:01:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 5/7] net/mlx5e: Introduce mlx5e_rss_init_params
Date: Mon, 22 Sep 2025 12:01:09 +0300
Message-ID: <1758531671-819655-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000149:EE_|DS0PR12MB6461:EE_
X-MS-Office365-Filtering-Correlation-Id: f0c4cfe8-4f96-4631-0907-08ddf9b6b9e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kumPIkHLt0URz44Jw0MNks04iK3xjMgATkewFtZ91Sw+k0ZXMkTn6vlKSo04?=
 =?us-ascii?Q?U0dNLNc+pTBT6MuhiBi4+dDLXo93Pxsu0mweIJHX7t3labixnxK3SM7XMC38?=
 =?us-ascii?Q?D3uwSI2P6llQ0Q40B6PTWKVyNto2DgDDQgT+RAM7s32tyuBPQwXnnKrWdpwm?=
 =?us-ascii?Q?0TPVuyOdldU0UU37it7IfuxUyqtfZsYdgPDl8b34oKd/1ujNjYKb6x6eYAWu?=
 =?us-ascii?Q?Pt+mfJPsLZH4lFU6mWUGcSiy+W/i6/YF9OWuQUMvejBwrxs34GYTVvlZutOm?=
 =?us-ascii?Q?Dp9mC9V/JNrBCzdqZx5fQ3pDCv52CMvBmmwAdDumyckYTzc1tGjvF37L2Vgh?=
 =?us-ascii?Q?hwsvFgF22IrP8Dp9Y94KldKTl2ZaFrLO2OhDMoA1ormIJdIzB8IN8asGsx06?=
 =?us-ascii?Q?BTt2K7lHzcpbMZA5k55zl88DPtI2qdfdafHU9SdrTWfFahex+w55JIBDMO9w?=
 =?us-ascii?Q?mNAnuaYtkJRGZMOkCLAOE5miZKuS3M2DgsbSwscUZLIt5CoCBae8QyblokT+?=
 =?us-ascii?Q?F1x0kYh1iRWdGe/4OiiaPOaEW4HIHgj6zdUEWmXCLAq0tmQ6Mk69yBYCAkzl?=
 =?us-ascii?Q?H6x+OkaY0zYAq2dzbNRpDLJcGGT5t7ES39vN64XAoEac6Un/0wBH/0UXXQ+U?=
 =?us-ascii?Q?KjiTATRuG3Awmdg34M67jyBWQ9sMeiDpFIfbRSLyIf/KaoN5Mgb3H13s+sZw?=
 =?us-ascii?Q?PdwJBJFMaC4dSBwFpnSGlHGC5keSwRmbg9JGpbs9WIZjmwLewwy2Uq4V9GmK?=
 =?us-ascii?Q?phMbznfp/V/VPUchkWvhIZPzTZYp7KWQPkdWqrgxkBAK1VPBmARzn8ZdPUL4?=
 =?us-ascii?Q?TbiTtlRTXT+WvGm4XcK9Oqu6yfkW/KfAPJ3Wlvs5YpU5YAxYu8Np635KGenu?=
 =?us-ascii?Q?RPHXxbEyA/aGx9bwEo2snTw31roySSrC04MRHP2HbNaBN62cZVLBj2YxoQcp?=
 =?us-ascii?Q?6DvRQRGmS3J8uC939RKvhvDZHW6IGNW88p9DGoo+yl99HFAT/+2rd3jVQVdZ?=
 =?us-ascii?Q?PorASl16no/wuNGLckGe664uMdJoDuP3KigLg0OaZZ2wPeWwhQwxJD9wzGNq?=
 =?us-ascii?Q?sDDA4hGjOReJqFLhWgWOCFgNM6sv1+P4kgRboQtnJVhWRt4MSImF5Aj6SzGo?=
 =?us-ascii?Q?w7ekQIDIFH8cMKKaXZHN+zsRC0UVnOkT553tsUAsvFCu3f+pQHjnCtLPHMtU?=
 =?us-ascii?Q?Raoxy72Y7r9KmNg8j7dNE2nJospHNyUA77JptEzqC0rSa2Cr1YqPLCMMzCc6?=
 =?us-ascii?Q?WxpYhnlDXVav+YmHkG6EEbxHKpcBY0NEGpVeQSgtM2oPQ/Hk2ZPeZn7Erq16?=
 =?us-ascii?Q?vzeVpg86Swa9SNh0ETVmqLz6VF4lW7BF2zbksdM1vaiYwH75PG4z0OuL57/E?=
 =?us-ascii?Q?MlQqQ7rJuNH0IOLy+nNSfjFyR8ZuKGiU5nurwmdQ9sNidiQHWPaN3OuBMZZd?=
 =?us-ascii?Q?NKckeBdNYIWIaldBoL6eLC3icUeDXGK2oQCc/0I0ldj3cYSN4FKHRzjL2Bko?=
 =?us-ascii?Q?4u8GNL1tyT+I0ZB9tit2ECguFgSxvMMeRL2M?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:02:15.3358
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0c4cfe8-4f96-4631-0907-08ddf9b6b9e8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000149.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6461

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


