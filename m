Return-Path: <linux-rdma+bounces-13557-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC34B8FADF
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 11:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3FF3E4E1BD2
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Sep 2025 09:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 694CA2D77E2;
	Mon, 22 Sep 2025 09:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ACh/CA/m"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011014.outbound.protection.outlook.com [52.101.57.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B02828BAA6;
	Mon, 22 Sep 2025 09:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758531738; cv=fail; b=aQuvdPXgpEiivt7XcIAoHSC7Ubf9dHL+Xa25PKAyZPDBuDBR5LSZH0PE1PTomG3AhVQyGdTRuock8nmh3p0D/rsVvoBx2D8+S02wqfyNiil51M3J3ghN01hhmUnG5RM4VXVSI6pancekZK4xTuw3N+ehJAbbPTSz9330pqw0Qws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758531738; c=relaxed/simple;
	bh=FAbUMoqi+Ib3Nd9IHCpEphLjNqdymi44wOLWnIrlgKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZbWHFhoehepuBYQ3S3VNbrKWymby2/m8nKojWK5L946LlURwhVKRDzZY8HwpphrNlFmNmcWOPHr2spazcbmeC/kpSGnhyyQfh9JkUeaQmwRS1nNE6OIVVfqHaaawp8TZ+ghKhQ0CJtjFBxnPtE2sReL+UNqeFO2letT17hr+2RU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ACh/CA/m; arc=fail smtp.client-ip=52.101.57.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9FbGQgA5Qng3LIM6HPFkitI9ELCaLQuG7RHiFaSNQf1OHivf3S8D3aPF1THyFZZcAlST/7SUGYrbnlCBInwRZ89v52k/cgBt32QavL+/P3WhEl1InWn1bz9UMMtLt4xIyK6X8ut3TNC/SMFbWAweiZm81FpWxWDX2pvs1xjfciNDT+o4duLzMSf7LYxWnoQljE/PzrPfbQ711ORosD0gMCwA2l8V43wo4bRCuG2sAEItRzLroYxpbqdsi+sqnM4Kl7Hmcus0dwDbqNgPZBIaUtq7yRHSeNrPTLRiObIVO4/xw0T64jOSLwV5MYjeVNQNWkNVYL5pg1iYoX6FEAaxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHR0VmRL9CQPhYFD+l59I+EIRrDjlj2BUOxE70UlM6Y=;
 b=V9zKbhUFkDx6xJ/kJ78FM31dc2vJIPqfAlj/n46qklnssdlHRAJWFhB1KWyIuLm8RHZUmByOmcpqdpBEt/WKnMIXWrwdaN3jZcAB2rHTDwKPhQEEQp1VD5tUr0tAtKfcNvJ3fudYaKJ3+3t+N3rSNAT9uzQgaGW9nJwmKRapzmHQxZ5EhJpDhcIskij7J6bDLvXhQ3cP18kkwWWDQ1xzHHMDcwZofodJ2gUkUzr1DAM1pokw7uTGlc4CTZFZe+YN58SByON7Kq3D7683U6F+Jsxw9y4e0/PhGiopJ0mC2Ifs/dfDcHUcGdV4OGyH1B9zdIKSVLAzSpAkYywXN56drg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHR0VmRL9CQPhYFD+l59I+EIRrDjlj2BUOxE70UlM6Y=;
 b=ACh/CA/mRpkbIst8q4KuJ9oojCYa4i7b5zdCxtY2/1FR960iX9qvXQYMtHcuFo/dRz9gyPiNCnht8/dWgb6pOU93cAJajfkoPceiGpaz2T1bthliBdcHin6qJIy2VEN9RoOoSYukxiS0w1Zkmi9e7wF2D9/Qwmh0bR7n9NXjKtMJrAYybMwa402fB+tWi5rC7kQ8INIxo5IJkhUn6JUiDNy3RV9gQ5d7mBGAf/THAa/4GSasLX/Nnga15UYiPyqMYHwmpVhWD4Dp5Ag/YJkh0O74PEh9BprWJnFYPPiQ4awjAJjaD2u4LTF9La8+GBSZNbJgMqD4o4w2j9Z1uUYYsw==
Received: from BN8PR15CA0021.namprd15.prod.outlook.com (2603:10b6:408:c0::34)
 by PH7PR12MB8596.namprd12.prod.outlook.com (2603:10b6:510:1b7::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.19; Mon, 22 Sep
 2025 09:02:10 +0000
Received: from BN3PEPF0000B076.namprd04.prod.outlook.com
 (2603:10b6:408:c0:cafe::9b) by BN8PR15CA0021.outlook.office365.com
 (2603:10b6:408:c0::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Mon,
 22 Sep 2025 09:02:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN3PEPF0000B076.mail.protection.outlook.com (10.167.243.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 22 Sep 2025 09:02:09 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 22 Sep
 2025 02:01:59 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Sep 2025 02:01:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Sep 2025 02:01:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 4/7] net/mlx5e: Remove unused mdev param from RSS indir init
Date: Mon, 22 Sep 2025 12:01:08 +0300
Message-ID: <1758531671-819655-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B076:EE_|PH7PR12MB8596:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a398e95-4f7d-43aa-8c56-08ddf9b6b69f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?86BBwAdmhd2gZWedPykyq4mcsYMNghBgV7OqjQmS1tU4X1yeDi6++DHQL+xh?=
 =?us-ascii?Q?i6RyvQt3KAzd42oewSpH8xgz+bTJGal7CSs3O2dqe7KlJyh6UqtSf2F5ftLy?=
 =?us-ascii?Q?ua6VEPY+4OEYTYvLdmEH1I/RPmwcIXoBQwTmwmq0nIpqS4dn/reN4vB6qVh4?=
 =?us-ascii?Q?ZrAnv3LeW5IrOB1S03uuzHURL8510TlEof+j9X2HEURSogmty3GOvTEF8e/w?=
 =?us-ascii?Q?DISHGxRQh8MVijiNVbSrcTZp/bXse5InzZmTuAuYr0slFMp9rRfYTssxDwxi?=
 =?us-ascii?Q?fASyoHO6Q73pzH0ZEQcFdEy/h2YyYFzvYFzSs2x/LlL8bIz2fUUF8XlqFvWt?=
 =?us-ascii?Q?cezMmaii1XpcIjS6sVxlSO0o5JvjaLBVkM1YItUfRAHHSTN00AMrDuFS0tV8?=
 =?us-ascii?Q?cnL6rgGF31K7o3kd466akS0veJAZQYB9S52sVrk4RSxuF1RVQFbgsbjW92Ns?=
 =?us-ascii?Q?5qLdnuBHeWa3HJ7V0ojviWgMgaJOrHAEFCcugW47fA3fCuCnpfGoHCqaOr6g?=
 =?us-ascii?Q?E3DGCiabIuS+z9YPGpgh2hIvirpR7OkRVLhfXeyHwAZdpXMx77ycxRaB/8og?=
 =?us-ascii?Q?9htA1UJH1+nmZF19VisfNKDHoPLV430xLyvdMgD39EkeFY/BzEr2SykRvJfm?=
 =?us-ascii?Q?Egmk+o9JRfBMwvCES01aYETiOgIvnXzBKYbLYvTWGEPxkk09CaCZjBxSr8z1?=
 =?us-ascii?Q?JuRawaKD8YkESSVbSOAs9Ig2zusbuw0cbp1zfq2lPvuQtyKWKI6+qeOP7aNO?=
 =?us-ascii?Q?d5phQW5ArbsS/O46SI4vYxSjykdX34q3n/J3OtTfAA9fLwhKgfqT0FxodCwQ?=
 =?us-ascii?Q?r1ER9c5FtzTkDW5JVk3N9xu0nDBWZOx/plaVAYYtHGoFdpXI60c8LQzaj+KT?=
 =?us-ascii?Q?whFov2cybDZ94cg9vTU9zQISY25fV+Ectf3EsGwxLcRiNj4ucaeeelzpGc6t?=
 =?us-ascii?Q?0AMXTf/9xfPYEzXvEsCJAhLyPwhOheYSmr+EylWA+YPViWEV7eJRfv0bPTK4?=
 =?us-ascii?Q?N7l0+fLN5Py1Te/anlwMdUsa6UPcMhSw30Moku9I71Z2PYNKCiI6L/AbY2l7?=
 =?us-ascii?Q?h0NsDA6nCYXvNREvQCGX934Cc39Cs6jKIVm+u+L65dbHAuBXSCh87VRMY5pz?=
 =?us-ascii?Q?sXLCM5Rw2gmQZRFZIsnqG8dEWO7yAdLoMofJGCnGHY8pWfEy8bK9sO5boKJX?=
 =?us-ascii?Q?Cm+AGXZ2JIGRMPFnAmvYHzgnTMfj5wK4V5a8Px0Uy3SUS2uwwzuHNdI/j81O?=
 =?us-ascii?Q?39B16++7clWNgRhryKfzXl/r5N7nTplt47eA9NRG2ClMn1Fhv33zNJI0He7k?=
 =?us-ascii?Q?L0AJ2M3DamWFKKJdwVD8/tB394ZVp2bcZZPgPNF97xzkOGsqAbWBE3/6qcms?=
 =?us-ascii?Q?8st6H52daZdD2p8N6pNhuAdozDLa3PO8AuNWoz0JE64szGupbkSaH/znri6M?=
 =?us-ascii?Q?MaoLk2WAViRmN9rucLizGZ6GUB+mj9dNLBBNYze3k9gMwMIRvaIFJbxeTZnc?=
 =?us-ascii?Q?5BDOcQGL3Y6uFd+ig1lw/TLjTjKtrnHKWZzB?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 09:02:09.7981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a398e95-4f7d-43aa-8c56-08ddf9b6b69f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B076.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8596

From: Carolina Jubran <cjubran@nvidia.com>

The mdev parameter is not used in mlx5e_rss_params_indir_init, so drop
it from the function and update all callers accordingly.

No functional changes.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c | 12 +++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c  |  6 +++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
index c68ba0e58fa6..6422eeabc334 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.c
@@ -91,7 +91,7 @@ void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_ch
 	rss->indir.actual_table_size = mlx5e_rqt_size(rss->mdev, num_channels);
 }
 
-int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir, struct mlx5_core_dev *mdev,
+int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
 				u32 actual_table_size, u32 max_table_size)
 {
 	indir->table = kvmalloc_array(max_table_size, sizeof(*indir->table), GFP_KERNEL);
@@ -139,7 +139,8 @@ static struct mlx5e_rss *mlx5e_rss_init_copy(const struct mlx5e_rss *from)
 	if (!rss)
 		return ERR_PTR(-ENOMEM);
 
-	err = mlx5e_rss_params_indir_init(&rss->indir, from->mdev, from->indir.actual_table_size,
+	err = mlx5e_rss_params_indir_init(&rss->indir,
+					  from->indir.actual_table_size,
 					  from->indir.max_table_size);
 	if (err)
 		goto err_free_rss;
@@ -363,6 +364,7 @@ struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_suppo
 				 enum mlx5e_rss_init_type type, unsigned int nch,
 				 unsigned int max_nch)
 {
+	u32 rqt_max_size, rqt_size;
 	struct mlx5e_rss *rss;
 	int err;
 
@@ -370,9 +372,9 @@ struct mlx5e_rss *mlx5e_rss_init(struct mlx5_core_dev *mdev, bool inner_ft_suppo
 	if (!rss)
 		return ERR_PTR(-ENOMEM);
 
-	err = mlx5e_rss_params_indir_init(&rss->indir, mdev,
-					  mlx5e_rqt_size(mdev, nch),
-					  mlx5e_rqt_size(mdev, max_nch));
+	rqt_size = mlx5e_rqt_size(mdev, nch);
+	rqt_max_size = mlx5e_rqt_size(mdev, max_nch);
+	err = mlx5e_rss_params_indir_init(&rss->indir, rqt_size, rqt_max_size);
 	if (err)
 		goto err_free_rss;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
index c6c1b2847cf5..616097c8770e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rss.h
@@ -18,7 +18,7 @@ mlx5e_rss_get_default_tt_config(enum mlx5_traffic_types tt);
 
 struct mlx5e_rss;
 
-int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir, struct mlx5_core_dev *mdev,
+int mlx5e_rss_params_indir_init(struct mlx5e_rss_params_indir *indir,
 				u32 actual_table_size, u32 max_table_size);
 void mlx5e_rss_params_indir_cleanup(struct mlx5e_rss_params_indir *indir);
 void mlx5e_rss_params_indir_modify_actual_size(struct mlx5e_rss *rss, u32 num_channels);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index b6d6584fc6fe..00c2763e57ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -758,11 +758,11 @@ static int mlx5e_hairpin_create_indirect_rqt(struct mlx5e_hairpin *hp)
 	struct mlx5e_priv *priv = hp->func_priv;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_rss_params_indir indir;
+	u32 rqt_size;
 	int err;
 
-	err = mlx5e_rss_params_indir_init(&indir, mdev,
-					  mlx5e_rqt_size(mdev, hp->num_channels),
-					  mlx5e_rqt_size(mdev, hp->num_channels));
+	rqt_size = mlx5e_rqt_size(mdev, hp->num_channels);
+	err = mlx5e_rss_params_indir_init(&indir, rqt_size, rqt_size);
 	if (err)
 		return err;
 
-- 
2.31.1


