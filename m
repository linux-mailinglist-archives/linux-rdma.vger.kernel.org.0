Return-Path: <linux-rdma+bounces-13714-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 56022BA787C
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 23:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47A153B9E80
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Sep 2025 21:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739552BEC2B;
	Sun, 28 Sep 2025 21:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lrdX/4Uo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010053.outbound.protection.outlook.com [52.101.201.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620022BE639;
	Sun, 28 Sep 2025 21:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759094770; cv=fail; b=toWtyqZ7E7jhuSD/l4kWNcfC7/QW5R7iFm9Fg50j06xzKvoLl8asbCP1Hrvsg0NxaqpAOvdLVdtZUEEyDs8zIspoib3q6BnD6ocK5sB9bxnR+xgwp62rW+SCc2b/DsbQEg8ofUm8CdKeEkJqoNj6YNPzRN9ApkLwYPHqqJ+szTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759094770; c=relaxed/simple;
	bh=FAbUMoqi+Ib3Nd9IHCpEphLjNqdymi44wOLWnIrlgKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=spcjyMITvhFGfoQJcQ6kGIREJQAe5bFp4UEjyKFz4bfnNs8xnzdP5VRyngANN/3AS40Hy947f6JN6scPSOA6JChoyhk1pWw6n8OCf0waQpB6GltkzDewP6N7RUoq5iDi+PRtJRekbCimURNJrzswk2i4sClZ4rcDhMVmEA1Ae64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lrdX/4Uo; arc=fail smtp.client-ip=52.101.201.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qaKGXg62Gt4palVRG8a5dI8dBcg5zFR+0w1p7lYZu0/nVPYrC0auxVRNruWewcCiPQiJrnK24U/pG4jCreKpgRV9PtXZWrzqREocw72K9B996YTBJnSCej/KJqoR4Ty0r3+z+44xk9dwfdZtCXHJTNt2r36VvcFKlQIpFcRluYty5c8U7l3lOtm4hgQgHVX6jUg0PKvDCgurpfsaLkP/2ViFxef7tplKVtucPdpUsk5Xxf/l17d8NGazIevZdIQYQ904F+aw5TL3fef7YDvxwUPtsPv/p3EFYlBbqZ7UV8KtyKWbX+PuCzcKW6bqcZEvTGtpF2ijnr1Q8bm+X5joAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHR0VmRL9CQPhYFD+l59I+EIRrDjlj2BUOxE70UlM6Y=;
 b=yQG1iMxyRncOlfVaw/DK5CNObJscOf8niUpo1lg2blj2jYuCoPbGRDzgVHI1f/4R+ns4OM3VTtwZtjWfclRtPOeigt1+Sf0zD8Tde2Krv2So8ZALUYw4jrQFP7agS2k+SxkIKjqgE1frYgk1SnHD0oAsapf0fDyvEfQ9dTl1HbKzd8q8LE9H5ukUBFzXpWgOzNd8ORvpwHarKYLjBsusO9rN6cXru6uZtxFPryX3gfqk7aNtU8PIMma6ywlWOKEZuZcbWbPSY0Fj2pq0jP+FKx6E8LwdA6QEIah/6XzoDl5QxYU4RycpfBC/72uV4p3qeDYChDobHi+cwHFEuznC2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHR0VmRL9CQPhYFD+l59I+EIRrDjlj2BUOxE70UlM6Y=;
 b=lrdX/4UoKyxIcAn2sERo+1NSP9uPScMNfcnjNHnmp4Yq/BN7dmBgcbnNEhIfdIC8lRtayLKzwjVydJWoC0z2TNB3ts8VJKzjwrM+ufumus/5ksVzzMhIp4tu73lhIiMziEvrTsP1zJ3xVNhB9vEl4EpWZwAuN5R8VGagphoQrtcGwvvjtFTr47P4zohKBe51dyAIEpXMIq3qzWkvXFjJ1bi4ekLVx/kbWP5TIzW4DUMVt7UHTD7rVfcrL+NfjFfIOok4S7ed7ilSUDLeCqSSG5CThh3ODf+tzwf+Ff5W0RCJFGez38F88hdxgAs1GlKkROcZTEUGSJ707Qm8FYjaXA==
Received: from PH7P220CA0063.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32c::30)
 by PH8PR12MB7158.namprd12.prod.outlook.com (2603:10b6:510:22a::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Sun, 28 Sep
 2025 21:26:02 +0000
Received: from CY4PEPF0000EDD7.namprd03.prod.outlook.com
 (2603:10b6:510:32c:cafe::f6) by PH7P220CA0063.outlook.office365.com
 (2603:10b6:510:32c::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Sun,
 28 Sep 2025 21:26:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EDD7.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Sun, 28 Sep 2025 21:26:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 28 Sep
 2025 14:26:01 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Sun, 28 Sep 2025 14:26:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Sun, 28 Sep 2025 14:25:57 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Moshe Shemesh
	<moshe@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next V2 4/7] net/mlx5e: Remove unused mdev param from RSS indir init
Date: Mon, 29 Sep 2025 00:25:20 +0300
Message-ID: <1759094723-843774-5-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD7:EE_|PH8PR12MB7158:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f3261d0-1106-4ae4-65ee-08ddfed59fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?clTuHPiDBgBlQ/6LbPSHJvPvcSJx2YUZb5L12KbZl84cPBGCtjUW5jJcsgZS?=
 =?us-ascii?Q?UAvC3k5bLmRgohX7wQ7EXrKGgX4E5KBLRTiLX+nCJsXL7UxGFN/Ufw3DEKBk?=
 =?us-ascii?Q?sdnd5biD/5cdRxGmQE8zZy4EIXVY9cF62HGRdJ5kIdF1GJB4f+3bgcajWtzH?=
 =?us-ascii?Q?aWTTn6Q8b5KkaTxN+NzxoJQooYL4bFVJproQThOT740RtYC7u9WEQ6gXz58m?=
 =?us-ascii?Q?X/kOWnZnoSjNDD6zm2oGoIk9qeBE4ZznPoxeHwIBES2/LV4GAhdhE7WJ5/tI?=
 =?us-ascii?Q?Vh+QoPLHgaLP07ra980BvLEQ9DX+ODcO5pgi1k3oicf9PPVnGSD36vehlcVC?=
 =?us-ascii?Q?Q6neuHzK8T1yyB8Bm8prpVtOaZoklrxpWafxIaBxx63SbOShmSOetJjacwBy?=
 =?us-ascii?Q?AZQxtFQ3XYPTZGs7wELbE/NsNhQnK0bkwevuyLOFSuKj6o9N8T26I76850b7?=
 =?us-ascii?Q?HSttc81cryx1r4QtsMM5HCj9qwy6VMqikextfDJlhUToiqFs6Lune0kUuoJu?=
 =?us-ascii?Q?0fmmb17/gowlevY88yHQPi7s0BvFlynJ/ryDSEQn6hp70/S6ru+wEJVb89tt?=
 =?us-ascii?Q?cbIHvOnQB3iFCvHku99Md1Ul+d4e9ItqOprlTG/DzWdvjl8GKeJ3vaUcoYr+?=
 =?us-ascii?Q?uVLBAZBufaJRwym2ly1fOgxU73I9IMdfp7MGPO+oMV0TOITMzmnscpNETDKB?=
 =?us-ascii?Q?GRpiGjDFXs3P/GdlYAc2ypztnKED4hri+o11KS9w5tkIoCsKOUrm/QJ3yZcG?=
 =?us-ascii?Q?d0CzSC0QuyQQxSDE7AFAhGcoRkZHxUPwcD4cQ3s/dBPy8Hr8Sso63QEYrY7C?=
 =?us-ascii?Q?LTpVqF5CV2wwqiYzH805XIUd4G+1AZNgUE4lyVcpyi/Miq11bv8v1qkqTu82?=
 =?us-ascii?Q?7tk8xQ91Tm3Zy44ssFUR1MdoRMf6rASTvClaoMsFZZgGYEju5fPNDjgWUX/Z?=
 =?us-ascii?Q?kfFnXUuxy8QC6NJ/hJUfnzauH0HFpDLn+CVanF88+vjucu9zOLNa3UAQohKP?=
 =?us-ascii?Q?CRTtQddBwMtjmuBtIInyBFtBgsOiHxz0og6RJO9tFpO77RwY/8yGOIOoi9TT?=
 =?us-ascii?Q?Ku5heJKDL8AFnVgy3g9Vzc37QLzJVbzSeMLm+HjLA9X441dlxq5cNjWixopy?=
 =?us-ascii?Q?FLS5P78nDuvpF0ldhcEtwnd2z+Om0FM0qjF12J0J6p3e+h9rMAxQpMXWByG3?=
 =?us-ascii?Q?saFMwEzQTuiBe5AkBi6AbmvXHg8IDZyTNifwNTDGC8WXC97l6Wbn1CInL/Ep?=
 =?us-ascii?Q?8KCUZgi6BeVyH5eciBD2rwiZbtn8oyE1jbxOZtdSe1uz1qX7oI/LClw0Y07V?=
 =?us-ascii?Q?aUqUMGIdVZjzCqm7hEv876Q9dSaHUQ97Vm2gWZ6IIsmyLF/FVQdEO1LmoXi9?=
 =?us-ascii?Q?lGyPbl1gW35iNRFBLLmxyvL47A3BbSt2QvC8suR1XilVwy4O5DvPV+XHKyC7?=
 =?us-ascii?Q?pgCdPFALfo1ehkpfSGEIeoeIFwZX8Yg4fv3TIsHXQUXCJwN81180AmF6Drgv?=
 =?us-ascii?Q?H13GP4546NeDOa5eSZ4HGgqgluQg40rjMvIqP/X2uErs3PQWllnB2h1jNpQd?=
 =?us-ascii?Q?1S1hpsK29Co2WiOSmz8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2025 21:26:01.9069
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f3261d0-1106-4ae4-65ee-08ddfed59fdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7158

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


