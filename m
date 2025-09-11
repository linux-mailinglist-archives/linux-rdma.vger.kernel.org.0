Return-Path: <linux-rdma+bounces-13271-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C868AB5299F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 09:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63EC81C24A0F
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Sep 2025 07:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B0ED274668;
	Thu, 11 Sep 2025 07:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oJX8m+bI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2079.outbound.protection.outlook.com [40.107.100.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2597B26A1AF;
	Thu, 11 Sep 2025 07:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757574667; cv=fail; b=jmfSk6uwpOOW1kiKojYvsEOveYqrDwW5j6Z/M0if3kAl+ekdWfPKkNUwypLhoB8jJdBfCPMA9/dv4dcNCp0wttvIGZy7DpUx8+7BiG24IS+jXNDEvWIZOFLAMvgNKMc7hIrKJ8s7aQzye3oHkQbPZxXlYTciZz09zFQp9L6bR3I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757574667; c=relaxed/simple;
	bh=tdqLDse0OUHz3msP/lsi0MuiaOZvCO/YC+Fz9Ow77jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SeJ3Gxh4GGB2gNr3n9jz826KLqHXe8XA29YIAs0qW4+fjCvAv0xvA8ki+rbljAXrWZ3smlP4S5NxvS1S/5fjNWxehok2bcs9gIwqzNCMeLj7uzSc821qJmelqjHtpbmQ+tDgXW9jlbODX6/DRz6VVxPyt/MNIR+EYvHIrLnV/i8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oJX8m+bI; arc=fail smtp.client-ip=40.107.100.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=avoccAR304YJGezjjn+YeLH/DnZEk0YqEhBkGvsNMM4oyMFDkHHw+uSmp9ZTp8WE2hKQOt5z5hI8cLezmtXAieCoS+FGikVr9tOprWUiKPXvUSYXRfrWpGiVvgVgYCppxEHj/bNj5JsOqLnqd7SMjccfDhAJ2NgIrAYe3uPfU2WVRRoEDkj59AxYhyPQSB8pDIqKY4/eqHlnEAW4QS7o8KJofoMLYV0Qtr9wuQCHQpJb9sOZ1OEvKhPPlbJAAggmcmkYEedalQPACD8X6UfZPzcN2tdDD4hTyBjskpMnzyzF7CVBoexxADxzjBo1R5dfG+OqJ21KdvQgefRq9BAfDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=utZMZPyhbeprNDM11aULKyxzHNM/hAh4xZKBq0G7/DI=;
 b=cEL737xNeZgetW3xGo6Ju/5sfnYsg/fjZHxo9iKQZzCjuP7Uu6IgkOLRIxrY7R1+XI+UL1BzDhQi41o1/C2stqDSPvvDsH5mhNCSkXeq6HVn2G9vfaZCvPfYwbDA6oGTT7WaJjLG1EGirOS5yL2zb9vKOz1rK1VS0NUCn0hgtmsVSqVWeDJHW2dJMIFG+ibUwlJwZwweEtuwypAtrK55ExwUUb+ygaEJUP9QTkhAnkGtf0Dm5BrmSP3W/1iOuf3paQsQ/lbT701hZXMkxCL4SY0H2d1i6fj4PHWUDYHX2K/pdbE5uM6RVDnJuu46LO9NindtiagG6NMM33pMw2LsLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=utZMZPyhbeprNDM11aULKyxzHNM/hAh4xZKBq0G7/DI=;
 b=oJX8m+bIaoFRjL3RlfFa3hkbfqgMLJZUuqbsZ2nO8/5fPYtrRW/6ohfqJl00bxNfjesDcw7Yl0J0HuhnPp2n2o4OAtacDZjO0WoHHUQW85OeHDoU8xVumkOHiYxQseeSO21peRNAMT198dh4RQvGHlBDsKl/W47YWqygvT6sXKvPmbUbbLPZg71q3bxcJXYBlxpZ+CjztOXfqKYA2i3G8W3ILS33aWTSYhiw+V22gg6JP7Z1qSJB8je0o1KFHu4SQA2Ej4mqQ0DwcLzsq5sOYOs3LMTVEXmHoz/6aYrJF0qS39Zif/056ZXEla2056Yn3tIOgDO/ROM7upnDGeDuew==
Received: from MN2PR14CA0006.namprd14.prod.outlook.com (2603:10b6:208:23e::11)
 by SJ5PPFD5E8DE351.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::9a4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 07:11:00 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:23e:cafe::2f) by MN2PR14CA0006.outlook.office365.com
 (2603:10b6:208:23e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Thu,
 11 Sep 2025 07:10:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Thu, 11 Sep 2025 07:10:59 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 11 Sep
 2025 00:10:46 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Thu, 11
 Sep 2025 00:10:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>
CC: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Tariq Toukan <tariqt@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>, Sabrina Dubroca <sd@queasysnail.net>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH mlx5-next 3/3] net/mlx5e: Prevent WQE metadata conflicts between timestamping and offloads
Date: Thu, 11 Sep 2025 10:10:19 +0300
Message-ID: <1757574619-604874-4-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
References: <1757574619-604874-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ5PPFD5E8DE351:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bdc9808-483b-47dd-150f-08ddf1025c41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rL4z/5p59VZ3/1oL3hLa1inSBWLgLgRh82FXu5Ij8xJlVU4qls5t1HzHuuLn?=
 =?us-ascii?Q?iR8lspM8tdRUnjc9QQgkqLEmHo+G2a78PmmvRkAG3brZsQLI/DEIPsA1DcpP?=
 =?us-ascii?Q?XmoWVw3y3rpLtx+5HxxXNivgcLOAA/yVMHvwKL6a5dza7zrfvZxXZwe9048i?=
 =?us-ascii?Q?5z6E7cxjylYCK6zu5TDfEDaj844qOOpEKiQsZb2AuBbi+kbrXMenJhl7vLt4?=
 =?us-ascii?Q?xgo+mxQuRylFmXF4ZIt2KRBDCSsl/mtH68NpvB0M3y6cqdmQ1nP/KSa2HpFH?=
 =?us-ascii?Q?FbYJQJSx7bewl2IFkFTHIdUhKoSqk6S4E5hYhehs95W7IptGdzGwfS1T0xVr?=
 =?us-ascii?Q?rKP46FjTh3Z0t2D6Kw4RzZ0pS6kkkgjZFowgZgjP9RkvKg+YS5NLuG/fgO8t?=
 =?us-ascii?Q?vRD0mwOY/GgzfqtAFyGgBN/bKdZ9zQPu4XIhXEjz/JN42XxahlGzXiIZ9XF6?=
 =?us-ascii?Q?xQ2Xnml/KelF2lV5xRMwgHIp//eVcKa3iE73YG3thVfImnvZtBFq41L3vttI?=
 =?us-ascii?Q?8zDbtoU81KDzjAzgxpUmJGzuj2PyHNrZntZ/3mMeo3KDmezmW7EnhQTHTetZ?=
 =?us-ascii?Q?t+i99yguqWBXgHnzV8NjeIEa/GgVskQp9KH3cIo32sKuXwrBmm9J/h5lA1lf?=
 =?us-ascii?Q?1XIImFsZeqI4kLQ6ca6mHG5FtaDZBiqVxquEoKyln6LkbGeKG31ZqhpS7+Lq?=
 =?us-ascii?Q?ATTvaaNPj8nSChf8M43DBIYLUGLjyBtkUZJeGwAwfM/Z2n3+yI+VSxlRGXQl?=
 =?us-ascii?Q?0qXezjc+ZbacVAykXvtoDv4t1+v4sJ4zaOhBObptuXFIvTA4MUQ97PJd9n1y?=
 =?us-ascii?Q?IZGaNbqGk8GL+sNGFkBFmr1j0F5sN6rC6C/2Lsa2aHAB8Tj4FZHIUNQCzzc2?=
 =?us-ascii?Q?yVtaWeNMfN2o2eK02d1hW6oYyh70Dfv8k2grpt5zXEbUyAS4VNK06pxmNF7a?=
 =?us-ascii?Q?99M2UuojbwANnHUR1H5LURBYjp9L2rI7j7nPGUANhxhB9tYS46j2OEIuxHZK?=
 =?us-ascii?Q?I5X27hwUgDGhjdCAmxUJhTYQikKlFcG85l7vCqNFiS5koZGjSGUmtvsAQ6uq?=
 =?us-ascii?Q?HjNJYf/YuP7AthkSrOCKcRXVr7+8aWoExpMyWyMz664TM1ORfpMeFg9b7alF?=
 =?us-ascii?Q?1BpuFhPuay6mysBGjThlBtRD7iOCoGHkRg95jKNcCgrxt0h4E1T9sn4IcO8o?=
 =?us-ascii?Q?K3Bf5afA1V3IjyykXnZVzoXAhA+RRA4CARzTsOcnJ1LnewtNeN5dCvryzjDO?=
 =?us-ascii?Q?Hi/aHrBSuOpVwBljH0jiyp+C05S7jNAdPa7T+K/j9DI/rQ62UX6gIfGsiTrN?=
 =?us-ascii?Q?7fQTgWqCooX6aYPbv7gFu39r7JVr84M/ZeHQkMvyEJVu9e79Zr4mdxMNtolg?=
 =?us-ascii?Q?JHEsBvAT5dUPpRfQIJTObHGfXP8ete7jclWGZSWyHoweS5oKrxky2/fb9K4d?=
 =?us-ascii?Q?StqXRr+B37Ork9qBT9svmyzq+j5tmMNOAg8ML/LLrFt08e/cUsHHzvoGklyB?=
 =?us-ascii?Q?Ty6SDUXc//HJx6NBUZSuCKqcKRHCqny4Cs9f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 07:10:59.4613
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bdc9808-483b-47dd-150f-08ddf1025c41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFD5E8DE351

From: Carolina Jubran <cjubran@nvidia.com>

Update the WQE metadata assignment to avoid overriding existing
metadata when setting the sysport timestamp ID. Since timestamp IDs are
limited to 256 values, they use only the lower 8 bits of the metadata
field.

To avoid conflicts, move IPsec and MACsec metadata ID to bits 8 and 9,
and shift the MACsec fs_id accordingly. This ensures safe coexistence
of timestamping and offload features that use the same metadata field.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c         | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c | 2 +-
 include/linux/mlx5/qp.h                                 | 5 +++--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
index 319061d31602..6c55b67b7335 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tx.c
@@ -653,7 +653,7 @@ static void mlx5e_cqe_ts_id_eseg(struct mlx5e_ptpsq *ptpsq, struct sk_buff *skb,
 				 struct mlx5_wqe_eth_seg *eseg)
 {
 	if (unlikely(skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP))
-		eseg->flow_table_metadata =
+		eseg->flow_table_metadata |=
 			cpu_to_be32(mlx5e_ptp_metadata_fifo_peek(&ptpsq->metadata_freelist));
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
index 9ec450603176..e6be2f01daf4 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
@@ -2219,7 +2219,7 @@ static int mlx5_macsec_fs_add_roce_rule_tx(struct mlx5_macsec_fs *macsec_fs, u32
 		 mlx5_macsec_fs_set_tx_fs_id(fs_id));
 	MLX5_SET(set_action_in, action, offset,
 		 MLX5_ETH_WQE_FT_META_MACSEC_SHIFT);
-	MLX5_SET(set_action_in, action, length, 32);
+	MLX5_SET(set_action_in, action, length, 8);
 
 	modify_hdr = mlx5_modify_header_alloc(mdev, MLX5_FLOW_NAMESPACE_RDMA_TX_MACSEC,
 					      1, action);
diff --git a/include/linux/mlx5/qp.h b/include/linux/mlx5/qp.h
index b21be7630575..d67aedc6ea68 100644
--- a/include/linux/mlx5/qp.h
+++ b/include/linux/mlx5/qp.h
@@ -251,8 +251,9 @@ enum {
 	MLX5_ETH_WQE_SWP_OUTER_L4_UDP   = 1 << 5,
 };
 
-/* Base shift for metadata bits used by timestamping, IPsec, and MACsec */
-#define MLX5_ETH_WQE_FT_META_SHIFT 0
+/* Metadata bits 0-7 are used by timestamping */
+/* Base shift for metadata bits used by IPsec and MACsec */
+#define MLX5_ETH_WQE_FT_META_SHIFT 8
 
 enum {
 	MLX5_ETH_WQE_FT_META_IPSEC = BIT(0) << MLX5_ETH_WQE_FT_META_SHIFT,
-- 
2.31.1


