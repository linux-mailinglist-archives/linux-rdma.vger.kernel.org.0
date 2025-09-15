Return-Path: <linux-rdma+bounces-13374-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A23DCB57B65
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 14:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7609F189E416
	for <lists+linux-rdma@lfdr.de>; Mon, 15 Sep 2025 12:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D22630DEDF;
	Mon, 15 Sep 2025 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="exOWv1UJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010018.outbound.protection.outlook.com [52.101.85.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44D73019DA;
	Mon, 15 Sep 2025 12:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940140; cv=fail; b=fp/FWh+QqMwIx5q83hTYuBtoAprdkpYsMl2a+1BZbDPP5eZg9HJxgtnjk38O8nzD0J7z5d4vY60JIUyIThXSh5v2Iabmku24OnkRUVaV1PsxbZp4e/jcKz922VwDuG4inx8HBsR6ppnjK2oe/saE12UdIqxUbm2kLBDrjB5GYHU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940140; c=relaxed/simple;
	bh=Pi2Gt3NOw3xIhz2b3ZN0yzp6MUAO5Fa5Or/D1QAeVCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oYdp4CutJabUknFGoL41c+aqm6am59p5jL2iiZbZuHDeqmchM+r+9KtFhrPhzQWtXKGsD7yh35k2ZSQFGMnO/HjMi9sxP4UzVM6O814X0zghhHvwl2S0UXrI+TxsOpkuTM7l75SATBFwTgavohTBelrBTyD2NaUrPK0mLhqLbEw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=exOWv1UJ; arc=fail smtp.client-ip=52.101.85.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIADaBTuSks8VDSzhTH59Zbchn76NjR1traT/yp9I3D6Fp0PV4bngFzKXbvBB6mcSdSwoUmixaFZQgSXTcwJlQoxmvhPpjY2Y1rYPoqjkvpZvlq+dTJRMvyE4xQnDLvP6zR8rR2YzauCVdGrqmOxCh28VTkEc56QGLQEts2VzIjImbc7RxMez5mvHPXoXpnhcH7AQi3NwQBjCCfJ65Uzh56RIA4Ku1lSTw41pw4gC2fmPFasv3EyclZKPAgbT04kwL00FQ/cSFaYhWdsZAKJdIuENU+vsV25FVqbI7QvxD/g7d37r1QffiqIsHPmYEyYZzqdFQOXZNWs1728eVyqgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mmaKApl/5JKvzcN/1EIJGITPQXQXTt9wpBXtJo9ETto=;
 b=IZ6B2Ig5xeMDEsVMhHYEmw2zmJ8nHK75upzt24Q19cyD1MI7MnmjB1b5yzHHghAXsdldH8sptDZdLnaHGSlMuMEXHvGpUxAyLWVpmm+e/mGsg42tOTFVlYfZBBHhxwTGl2Hx5ubS/azbzk1k9oIIb+fKU6eE4SF81m820rQeEhAbFB3IgKEW2VhQAVNDiVYU7p2zFTytNclIw63+0d4OPYj+qG1Mu+8/Zhs7UL6Tv6cNn8Bb64MwRLEXYbQZwX6Xw3yAdSX9Rbb0OOEzsp32b/6Uy+q+CToiuYX8/QjW6C1zu1vlhdMBHFeKlBGPwcsSTRx/ZQlv+SD88kTDgPvcyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mmaKApl/5JKvzcN/1EIJGITPQXQXTt9wpBXtJo9ETto=;
 b=exOWv1UJswP/btR59EXeNPTUvGK1yLIqCJPGeWi/Gq3Asd7IFMoiE/ABlhc5y7RsVEDArP32wix/JaEf3mX2shNLROPurUnno9JpPlM0lfLDNGDcdQ/RYULnX0yUdY7l9qYBwQ5KXf4SlymToSbOtwZKGkmAR0IWYirLr99Nuvk3ycZzI/2ypWpXHXCcU6tLxw1rMgaP/iIdQN5SLqZjvp89U2/3r5c1CPmWRTbHnse1W3DrkKJA6LptaCduvJvs80UIAr21V4TR/Hlm0+oCeswHygWiD0UdN0lBj33shKpCyQ74ShgWLGUYef37U7aeShMtJTQ2j3z3Kv9QF02beQ==
Received: from SJ0PR13CA0134.namprd13.prod.outlook.com (2603:10b6:a03:2c6::19)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.21; Mon, 15 Sep
 2025 12:42:11 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::10) by SJ0PR13CA0134.outlook.office365.com
 (2603:10b6:a03:2c6::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.12 via Frontend Transport; Mon,
 15 Sep 2025 12:42:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Mon, 15 Sep 2025 12:42:11 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 15 Sep
 2025 05:41:55 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 15 Sep 2025 05:41:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 15 Sep 2025 05:41:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Parav Pandit
	<parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: [PATCH net-next V2 1/4] net/mlx5: Refactor devcom to use match attributes
Date: Mon, 15 Sep 2025 15:41:07 +0300
Message-ID: <1757940070-618661-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
References: <1757940070-618661-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 87564af1-f2cd-4937-b1be-08ddf4554a92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MhWVdekzN7ffiaRKr56W1aUOafP3zUBCGWhZtznh0XUP5C5scD7/TGtyRH8T?=
 =?us-ascii?Q?B22yxu/ZBstgtpqpUJ+XKay5aFWo0VYDAdYmAEYOmP/y1qVay+YpLDfSYkXv?=
 =?us-ascii?Q?G1jyrfQPLRSBbYhw+zZQpVTh+/Gz7ARuSJVKu7vtK3rKrlbyEhq6PH1UNVMz?=
 =?us-ascii?Q?slAb6TZUu38oU1tQdOK23ayJIgiG17UTqNmCOSf/+Sk6IqSLtvMUog0cBPjp?=
 =?us-ascii?Q?b52MLXuezH6gIOsav8i17LyV3RJKhEKNSVc7OikRaJBeemGPWB2Keup6+WDw?=
 =?us-ascii?Q?z0bTWmSqzKMnLmlgkHADa61ibpgADY/9P3mF98UZEoLOcHEDlr7wUvNVTARt?=
 =?us-ascii?Q?biNecRFaV8mUmLjUBRWbOXiHl4NH2uxTarr8JX1k0c3Jz+SNYKocZr4OEe8X?=
 =?us-ascii?Q?65Buf3WPxxss244C5ETgKx/zgcWMkLbNDGtNmuumFykcfpxdxrd81n+Id7I1?=
 =?us-ascii?Q?tDs+/moQeG8t8DDFWgr02rbFIqftpTDwHAfxoOA3VRKBmkX9SR98qfREPgDD?=
 =?us-ascii?Q?oa7c/TkamHHNkYFv/xnvP3ulR1+3uhQhDm53QgLoIR/1YW/qbt11Eg/p1krG?=
 =?us-ascii?Q?DJxYGzQyw8kSkZUtJVW278XMw39XU9/PtjDfi7JpJ0lmBLPR6gC/KS243IUN?=
 =?us-ascii?Q?9df1Lyq2lkzIMiaEBw6Pc7EtaOlIP8QDPdN71X6aVMP5sp65uQDgx/40Vtam?=
 =?us-ascii?Q?83uCHLEoZmomH8J6buFOue9pJe61VT6oBE9eqcuW2DWZAhRaXwube92Cg24Q?=
 =?us-ascii?Q?/wCj+FXSjcJ5Azr6XJFceBCp0feoRepHLnMxi0K9/Htg9ixb66oFSt/PguFe?=
 =?us-ascii?Q?qV0UX1ZB9v3kzEUJ2LHxrLzAIGqCeekOFjENql9YS/HyggWvCj+Um8Laca4C?=
 =?us-ascii?Q?h7+3crpet2KXSIgoXFSz5kdaapqJVNmD0rELOuZAkEM0RLuMp6GO96uJYoOC?=
 =?us-ascii?Q?0LeG4YSD7/nEPIxcDTJfZHgo7tvAnH6uT3LYt9QTVoJ4d7xYlx4RGVhkGRnN?=
 =?us-ascii?Q?fJ8ZjKLyH9RAo1O9T7MnOCFt39pR8cOYBbLNGy5ak+DCTu3u82CYwYV4kLcT?=
 =?us-ascii?Q?8K1zbT7ORXLmyUIkWHOn1R5unqCEFLyPPZPEmcNT/23bFzmM9587wO1MEpKX?=
 =?us-ascii?Q?fuPYz7sHD95tqTgEM30d3Qhi4Je/CYbgvhKArZQG1DZOGDiHQajd6KKhtqAU?=
 =?us-ascii?Q?elLtGreKGcGWs9S0d9SDILwLoCrCelvDjZDLiNCFudJ01XbBIwc31bZdDwJd?=
 =?us-ascii?Q?jxrcUxTzy8dobvZi3qgusCUXLeKk+9qevRVjpcf4Hi9SLXvrN2B7QtSOlfVk?=
 =?us-ascii?Q?H9QgVZOpmA8TsGSjg5nJfhxOksa5Lmi/sdrvp2tCpAK3Kpb2cFRzRoSscDya?=
 =?us-ascii?Q?TSQya+HVd1vvUXDlG3auTE+5ltuCF/AR0UptLVgiJqQ9YZzrUvnJR9O6QMYx?=
 =?us-ascii?Q?3fhAYHDupX2bs7DNudye5DyFlH88omsa3c4pL0GrLv2e3UPtVQYMLR9nRM/J?=
 =?us-ascii?Q?4+eKr7EZKpkhLRFw2KKCYVVsUPdgn+zQ1m/l?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2025 12:42:11.5927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87564af1-f2cd-4937-b1be-08ddf4554a92
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141

From: Shay Drory <shayd@nvidia.com>

Refactor the devcom interface to use a match attribute structure instead
of passing raw keys. This change lays the groundwork for extending
devcom matching logic with additional fields like net namespace,
improving its flexibility and robustness.

No functional changes.

Signed-off-by: Shay Drory <shayd@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  6 +++-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  7 +++--
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 +++--
 .../mellanox/mlx5/core/eswitch_offloads.c     |  5 +--
 .../ethernet/mellanox/mlx5/core/lib/clock.c   | 14 ++++++---
 .../ethernet/mellanox/mlx5/core/lib/devcom.c  | 31 +++++++++++++------
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  | 10 +++++-
 .../net/ethernet/mellanox/mlx5/core/lib/sd.c  |  4 ++-
 .../net/ethernet/mellanox/mlx5/core/main.c    |  7 +++--
 9 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 714cce595692..fe5f5ae433b7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -235,9 +235,13 @@ static int mlx5e_devcom_event_mpv(int event, void *my_data, void *event_data)
 
 static int mlx5e_devcom_init_mpv(struct mlx5e_priv *priv, u64 *data)
 {
+	struct mlx5_devcom_match_attr attr = {
+		.key.val = *data,
+	};
+
 	priv->devcom = mlx5_devcom_register_component(priv->mdev->priv.devc,
 						      MLX5_DEVCOM_MPV,
-						      *data,
+						      &attr,
 						      mlx5e_devcom_event_mpv,
 						      priv);
 	if (IS_ERR(priv->devcom))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
index 32c07a8b03d1..9874a15c6fba 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -5387,12 +5387,13 @@ void mlx5e_tc_ht_cleanup(struct rhashtable *tc_ht)
 int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 {
 	const size_t sz_enc_opts = sizeof(struct tunnel_match_enc_opts);
+	struct mlx5_devcom_match_attr attr = {};
 	struct netdev_phys_item_id ppid;
 	struct mlx5e_rep_priv *rpriv;
 	struct mapping_ctx *mapping;
 	struct mlx5_eswitch *esw;
 	struct mlx5e_priv *priv;
-	u64 mapping_id, key;
+	u64 mapping_id;
 	int err = 0;
 
 	rpriv = container_of(uplink_priv, struct mlx5e_rep_priv, uplink_priv);
@@ -5448,8 +5449,8 @@ int mlx5e_tc_esw_init(struct mlx5_rep_uplink_priv *uplink_priv)
 
 	err = netif_get_port_parent_id(priv->netdev, &ppid, false);
 	if (!err) {
-		memcpy(&key, &ppid.id, sizeof(key));
-		mlx5_esw_offloads_devcom_init(esw, key);
+		memcpy(&attr.key.val, &ppid.id, sizeof(attr.key.val));
+		mlx5_esw_offloads_devcom_init(esw, &attr);
 	}
 
 	return 0;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 4fe285ce32aa..df3756d7e52e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -433,7 +433,8 @@ int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs);
 void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf);
 void mlx5_eswitch_disable_locked(struct mlx5_eswitch *esw);
 void mlx5_eswitch_disable(struct mlx5_eswitch *esw);
-void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key);
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
+				   const struct mlx5_devcom_match_attr *attr);
 void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw);
 bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw);
 int mlx5_eswitch_set_vport_mac(struct mlx5_eswitch *esw,
@@ -928,7 +929,9 @@ static inline void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw) {}
 static inline int mlx5_eswitch_enable(struct mlx5_eswitch *esw, int num_vfs) { return 0; }
 static inline void mlx5_eswitch_disable_sriov(struct mlx5_eswitch *esw, bool clear_vf) {}
 static inline void mlx5_eswitch_disable(struct mlx5_eswitch *esw) {}
-static inline void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key) {}
+static inline void
+mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
+			      const struct mlx5_devcom_match_attr *attr) {}
 static inline void mlx5_esw_offloads_devcom_cleanup(struct mlx5_eswitch *esw) {}
 static inline bool mlx5_esw_offloads_devcom_is_ready(struct mlx5_eswitch *esw) { return false; }
 static inline bool mlx5_eswitch_is_funcs_handler(struct mlx5_core_dev *dev) { return false; }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index d57f86d297ab..bc9838dc5bf8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -3104,7 +3104,8 @@ static int mlx5_esw_offloads_devcom_event(int event,
 	return err;
 }
 
-void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
+void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw,
+				   const struct mlx5_devcom_match_attr *attr)
 {
 	int i;
 
@@ -3123,7 +3124,7 @@ void mlx5_esw_offloads_devcom_init(struct mlx5_eswitch *esw, u64 key)
 	esw->num_peers = 0;
 	esw->devcom = mlx5_devcom_register_component(esw->dev->priv.devc,
 						     MLX5_DEVCOM_ESW_OFFLOADS,
-						     key,
+						     attr,
 						     mlx5_esw_offloads_devcom_event,
 						     esw);
 	if (IS_ERR(esw->devcom))
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 7ad3baca99de..8f2ad45bec9f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -1435,14 +1435,20 @@ static int mlx5_clock_alloc(struct mlx5_core_dev *mdev, bool shared)
 static void mlx5_shared_clock_register(struct mlx5_core_dev *mdev, u64 key)
 {
 	struct mlx5_core_dev *peer_dev, *next = NULL;
+	struct mlx5_devcom_match_attr attr = {
+		.key.val = key,
+	};
+	struct mlx5_devcom_comp_dev *compd;
 	struct mlx5_devcom_comp_dev *pos;
 
-	mdev->clock_state->compdev = mlx5_devcom_register_component(mdev->priv.devc,
-								    MLX5_DEVCOM_SHARED_CLOCK,
-								    key, NULL, mdev);
-	if (IS_ERR(mdev->clock_state->compdev))
+	compd = mlx5_devcom_register_component(mdev->priv.devc,
+					       MLX5_DEVCOM_SHARED_CLOCK,
+					       &attr, NULL, mdev);
+	if (IS_ERR(compd))
 		return;
 
+	mdev->clock_state->compdev = compd;
+
 	mlx5_devcom_comp_lock(mdev->clock_state->compdev);
 	mlx5_devcom_for_each_peer_entry(mdev->clock_state->compdev, peer_dev, pos) {
 		if (peer_dev->clock) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
index 7b0766c89f4c..1ab9de316deb 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.c
@@ -22,11 +22,15 @@ struct mlx5_devcom_dev {
 	struct kref ref;
 };
 
+struct mlx5_devcom_key {
+	union mlx5_devcom_match_key key;
+};
+
 struct mlx5_devcom_comp {
 	struct list_head comp_list;
 	enum mlx5_devcom_component id;
-	u64 key;
 	struct list_head comp_dev_list_head;
+	struct mlx5_devcom_key key;
 	mlx5_devcom_event_handler_t handler;
 	struct kref ref;
 	bool ready;
@@ -108,7 +112,8 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom_dev *devc)
 }
 
 static struct mlx5_devcom_comp *
-mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
+mlx5_devcom_comp_alloc(u64 id, const struct mlx5_devcom_match_attr *attr,
+		       mlx5_devcom_event_handler_t handler)
 {
 	struct mlx5_devcom_comp *comp;
 
@@ -117,7 +122,7 @@ mlx5_devcom_comp_alloc(u64 id, u64 key, mlx5_devcom_event_handler_t handler)
 		return ERR_PTR(-ENOMEM);
 
 	comp->id = id;
-	comp->key = key;
+	comp->key.key = attr->key;
 	comp->handler = handler;
 	init_rwsem(&comp->sem);
 	lockdep_register_key(&comp->lock_key);
@@ -180,21 +185,27 @@ devcom_free_comp_dev(struct mlx5_devcom_comp_dev *devcom)
 static bool
 devcom_component_equal(struct mlx5_devcom_comp *devcom,
 		       enum mlx5_devcom_component id,
-		       u64 key)
+		       const struct mlx5_devcom_match_attr *attr)
 {
-	return devcom->id == id && devcom->key == key;
+	if (devcom->id != id)
+		return false;
+
+	if (memcmp(&devcom->key.key, &attr->key, sizeof(devcom->key.key)))
+		return false;
+
+	return true;
 }
 
 static struct mlx5_devcom_comp *
 devcom_component_get(struct mlx5_devcom_dev *devc,
 		     enum mlx5_devcom_component id,
-		     u64 key,
+		     const struct mlx5_devcom_match_attr *attr,
 		     mlx5_devcom_event_handler_t handler)
 {
 	struct mlx5_devcom_comp *comp;
 
 	devcom_for_each_component(comp) {
-		if (devcom_component_equal(comp, id, key)) {
+		if (devcom_component_equal(comp, id, attr)) {
 			if (handler == comp->handler) {
 				kref_get(&comp->ref);
 				return comp;
@@ -212,7 +223,7 @@ devcom_component_get(struct mlx5_devcom_dev *devc,
 struct mlx5_devcom_comp_dev *
 mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 			       enum mlx5_devcom_component id,
-			       u64 key,
+			       const struct mlx5_devcom_match_attr *attr,
 			       mlx5_devcom_event_handler_t handler,
 			       void *data)
 {
@@ -223,14 +234,14 @@ mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 		return ERR_PTR(-EINVAL);
 
 	mutex_lock(&comp_list_lock);
-	comp = devcom_component_get(devc, id, key, handler);
+	comp = devcom_component_get(devc, id, attr, handler);
 	if (IS_ERR(comp)) {
 		devcom = ERR_PTR(-EINVAL);
 		goto out_unlock;
 	}
 
 	if (!comp) {
-		comp = mlx5_devcom_comp_alloc(id, key, handler);
+		comp = mlx5_devcom_comp_alloc(id, attr, handler);
 		if (IS_ERR(comp)) {
 			devcom = ERR_CAST(comp);
 			goto out_unlock;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
index c79699b94a02..f350d2395707 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/devcom.h
@@ -6,6 +6,14 @@
 
 #include <linux/mlx5/driver.h>
 
+union mlx5_devcom_match_key {
+	u64 val;
+};
+
+struct mlx5_devcom_match_attr {
+	union mlx5_devcom_match_key key;
+};
+
 enum mlx5_devcom_component {
 	MLX5_DEVCOM_ESW_OFFLOADS,
 	MLX5_DEVCOM_MPV,
@@ -25,7 +33,7 @@ void mlx5_devcom_unregister_device(struct mlx5_devcom_dev *devc);
 struct mlx5_devcom_comp_dev *
 mlx5_devcom_register_component(struct mlx5_devcom_dev *devc,
 			       enum mlx5_devcom_component id,
-			       u64 key,
+			       const struct mlx5_devcom_match_attr *attr,
 			       mlx5_devcom_event_handler_t handler,
 			       void *data);
 void mlx5_devcom_unregister_component(struct mlx5_devcom_comp_dev *devcom);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
index eeb0b7ea05f1..d4015328ba65 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
@@ -210,13 +210,15 @@ static void sd_cleanup(struct mlx5_core_dev *dev)
 static int sd_register(struct mlx5_core_dev *dev)
 {
 	struct mlx5_devcom_comp_dev *devcom, *pos;
+	struct mlx5_devcom_match_attr attr = {};
 	struct mlx5_core_dev *peer, *primary;
 	struct mlx5_sd *sd, *primary_sd;
 	int err, i;
 
 	sd = mlx5_get_sd(dev);
+	attr.key.val = sd->group_id;
 	devcom = mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_SD_GROUP,
-						sd->group_id, NULL, dev);
+						&attr, NULL, dev);
 	if (IS_ERR(devcom))
 		return PTR_ERR(devcom);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 0951c7cc1b5f..1f7942202e14 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -975,6 +975,10 @@ static void mlx5_pci_close(struct mlx5_core_dev *dev)
 
 static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 {
+	struct mlx5_devcom_match_attr attr = {
+		.key.val = mlx5_query_nic_system_image_guid(dev),
+	};
+
 	/* This component is use to sync adding core_dev to lag_dev and to sync
 	 * changes of mlx5_adev_devices between LAG layer and other layers.
 	 */
@@ -983,8 +987,7 @@ static void mlx5_register_hca_devcom_comp(struct mlx5_core_dev *dev)
 
 	dev->priv.hca_devcom_comp =
 		mlx5_devcom_register_component(dev->priv.devc, MLX5_DEVCOM_HCA_PORTS,
-					       mlx5_query_nic_system_image_guid(dev),
-					       NULL, dev);
+					       &attr, NULL, dev);
 	if (IS_ERR(dev->priv.hca_devcom_comp))
 		mlx5_core_err(dev, "Failed to register devcom HCA component\n");
 }
-- 
2.31.1


