Return-Path: <linux-rdma+bounces-13996-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FEDBFF62B
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 08:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7AA818C6E99
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 06:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45F9E2BFC60;
	Thu, 23 Oct 2025 06:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qhfQCCx3"
X-Original-To: linux-rdma@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011067.outbound.protection.outlook.com [40.93.194.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F1D22F14C;
	Thu, 23 Oct 2025 06:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761201930; cv=fail; b=q8Z4MKMjBeR3wyT0wHzsUVYWybS4bPpPF/mwmhpDQA8GPrTDTSY3yRO84GO6fIrmjSTPGlXelV1BQxhusGT+Z3GTcMPJmIPujjUVjUKEQu50wEwOYgmem5Wlbdh6hK0M6Q66maQAkdK+R+RyVqvkSBCo36UdW32NR8g4k5cqQ08=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761201930; c=relaxed/simple;
	bh=2rv1HKehKeyN19QMHDlcu1QtHBsysRYfvijZR5j48qg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQ9vHmClhDS7BQfWfD3X6t0nCS9coTJXYUzSKTc4O+/mIFvK+mvgaN+SKGVE3kPUsIiWoexYsJBwgdyvpMq/e+56mv8M02/wlxaDjyuLvsbCO7MZHLlDrd3HQbaStf32S09KxXskAvD9Oo6fugx5joaqdpTu0GivDj5+ef2zwxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qhfQCCx3; arc=fail smtp.client-ip=40.93.194.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=maz8B6VkqrCHBuFGog825PLiaMm1YaAR/CWoydbr6xuYEBn1w1L00e+mgGEULq2Kzx+B+N8Ms1wQ0qFZR0e8ynNe29pQZCCk6FYSqnObXKkeZ5qTUrHNrKlCAQnfwzHs/stmGyarITaDBsUyJ82j6EVp5cPPhAjoX0YpuzikARZBzguB46s0J5gZudeoQlaEFNy5LotdNhfmgwN+TIQwnfrqROwOiqF+mMZPWP8YBoTYmdWcSpWjhwy93XAh31ZSlmC7I7IIb+CvXIOI4v+QJsj6xECeLpOV/B4bS9Y4XxM1UWDvCiBW6rtqzQHjgDnXTz/tOSA0qbjK8qH4o3lwZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RZnaJIdEJnIT2/maj9T624DEDnB3bWGd4bLy/SkrOZk=;
 b=CjzXHcNCb6GYGBoJdt0Cb7BS/Vdr6bQVCQUcEZnsA5/jZr6nv5jboIesZ2sr7dGmGZEce8HpF48j2th9cldPdia5UkpTIrnhDhc7LQEDRyskwDk6/j0aXhctrPR6YttLOz7gfqvMV72eoYM+WIODsefq9vR9ow4T1EGC4OpX1+ukG/2A4FNxcw2TJwpgYU9yqv0caGHJIIRCiupSFyvOc9x9Ir4mpXMDjLzWRLRQ70PJ9iEgH//BlKvN4phvKWUNvk52HiIYrjSwHUDzTg0x+0hB8wKuOgMOOOwQFbFZMslm1l5Gk6NdCuojWC2FuF5ekdbvEEzm2LGAOk/rzGxwmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RZnaJIdEJnIT2/maj9T624DEDnB3bWGd4bLy/SkrOZk=;
 b=qhfQCCx3l8yNly3bXUROaCQFVvPO+T9NSwHYYHnlBLCjs3R5MFylJI9Oxv/mIUTeY4NjNDK/Aek9pnClD6Lb3xUNrVzTVxX1JxLeKpeg9B/rFP6CJ5FPRdCpzVoGL+IZlR9V6rYHIi3JwmuS1bB+dDpZc5hKRubfAfC+ux6IPKASr7AOil2YzVcJCRXPS1OKzyks8aO2qC1XWYe2e+gTXcpfvsIqxpTeq2GJ5Yxxz1hwDt60U6fPVw4FA0QW4U4t1VD1UkxKbDW7cFn/TLUH+TqGbx5GUb2umH1VFDMVBmLjYox50+JHbWXxwT0DZpxp3BNpkPfMnsM9AS4HYqx4UQ==
Received: from PH8PR07CA0007.namprd07.prod.outlook.com (2603:10b6:510:2cd::23)
 by DS0PR12MB7704.namprd12.prod.outlook.com (2603:10b6:8:138::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Thu, 23 Oct
 2025 06:45:24 +0000
Received: from CY4PEPF0000EE37.namprd05.prod.outlook.com
 (2603:10b6:510:2cd:cafe::91) by PH8PR07CA0007.outlook.office365.com
 (2603:10b6:510:2cd::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9253.13 via Frontend Transport; Thu,
 23 Oct 2025 06:45:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE37.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Thu, 23 Oct 2025 06:45:24 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.34; Wed, 22 Oct
 2025 23:45:07 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 23:45:07 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 23:45:03 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Carolina
 Jubran" <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 4/7] net/mlx5: IPoIB, set self loopback prevention in TIR init
Date: Thu, 23 Oct 2025 09:43:37 +0300
Message-ID: <1761201820-923638-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE37:EE_|DS0PR12MB7704:EE_
X-MS-Office365-Filtering-Correlation-Id: bf12f4d7-0427-41bb-fb83-08de11ffbea2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MU3a87sCSx1tiefnlmVEg+TP8JDpY/iuYrrRrMj0NueyYlA7CcQxgmQdmIHn?=
 =?us-ascii?Q?+8LnO5/zYXzgPDdyX2zzEnn2cr3n/esXr8dhTfG/XYqqXqj3Xyy2adECNjIM?=
 =?us-ascii?Q?r4Sp8yO9DOLi7b2vZh8r+p8VdoT0Qu0SBKRVPNHWb3jtYk5J1oJGbUYROgnr?=
 =?us-ascii?Q?1YXeyAzJHBBpYgISjeB6JSAi6jwsKBAGKFzZFkDplLZQPgqZTok/DoFCSeln?=
 =?us-ascii?Q?7OitWhILZJ1bbglk7o9hlbQhl0WvqMpVJmRgEJEYGMX0HSOBokWv/F/3IT2w?=
 =?us-ascii?Q?LvIxGiJAk39ED9B8uUAF+4A5KHOCtjF6opO4u1MDTeuh3hnJ2mpXlxnfSvd2?=
 =?us-ascii?Q?y6te80xA1ZZ1lDE97xJIF+zM2Ml/wbFfmMcb2X3GfU8ZdfG04TtrlcO374vJ?=
 =?us-ascii?Q?aQUsbTNqPnwYWblYzZVaYdTSTbTuehxqGuBSl8U1Tg/e3mlrWsi2T227rbtp?=
 =?us-ascii?Q?69hHpTmv+vaTwMNjC57jNXxRG5RpqDwIsnhEes/9xknu9DwBqqilj4V2O5FI?=
 =?us-ascii?Q?og23/WC0dRsxD4KH1nFApP8DDXwKs6vNjNMP6jG+LK8xgJpxTEehBfDGDT64?=
 =?us-ascii?Q?OiWVXcznIViLdRaIuyl89bw/HQikt96+wP/IVdSUy+qp/0ptYapwZo2013dk?=
 =?us-ascii?Q?lsz2ux2d8Gr4LUckvSVoK2pGlKkoOqc57yDSpjXi9tiKPEc7U7BnYegfVGDS?=
 =?us-ascii?Q?fUau8eZLaiqQihY2JojGNzoGJxF3xPgiAFgWYBVksbhGiXV912HEGwvOYwyY?=
 =?us-ascii?Q?KS2IBlqsbeKboVPxaTxLQ7nQzYEg3FI/v5m9XMhBb3goh6KQuCntvbLz+QWx?=
 =?us-ascii?Q?cvqOUUe1M/qsBo6v7OH9gfDSH5bd1PgBU+escZRM/T4maOaUCpTUwl579S9c?=
 =?us-ascii?Q?QnuMuFLBUcPjc1fRCLl/nXtSAWOByvE0zsu+H9plMA5SWT9IqBXuz3oJep/J?=
 =?us-ascii?Q?BetcDcZ1HQkT8TO2EhlB/NYV9HK5sbnhqnveS2x9yaQqBZqjUM6BGvK5ggDJ?=
 =?us-ascii?Q?ZaZEa/ZLrRWf1ZJhtjgtmUAS4MaYkRwHYdCL4jmJrofo3IeCiN8jFLF0dawn?=
 =?us-ascii?Q?Zj5xlS0iRGjF4rEKWLEEScCpodG/SiqIjdYpZS7t6cURsmvtk7xV1A+oZzE6?=
 =?us-ascii?Q?AxuFp349k85RN5naqxMpKtMtgiYXT9GRFDlZf7Cq/mgnWSGkTBmlbFUza0c3?=
 =?us-ascii?Q?o0FuKvzlz5/DJyJ+ZDKjjTsd0tJzfqDggqDWrdQMJtJ7m6UAlrAzA93Wkjjw?=
 =?us-ascii?Q?0/C7LdSHIhuAt8dFRIbv+VaNkBlgNV0Wt41zQDpaFg3YdgBompKrqjkIokFx?=
 =?us-ascii?Q?PXnRUbJXv90kbtmNzr6t4l8QbekJR+9DVGd2GqkAmqIZWSWEGHeW1DRUA6jR?=
 =?us-ascii?Q?5Y1aubkdhAII+VN0ej6O96bNwKn+AL2ZOk7JL6HvP2+ZSJ+DKLPquAjgMDdP?=
 =?us-ascii?Q?lh28ThPA2CsF6mB0+v2ZzCBCYEvmm4Gb5H3pUehnJAjdGFzAPtrNEX0kc+w5?=
 =?us-ascii?Q?FYiQw/M9it2cLRdRjX5Os/qRmellSVAZq2tbyKOztDzYrPOscOl9A/uDl+4F?=
 =?us-ascii?Q?YgZ+GWLS3LYKYN+CczU=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Oct 2025 06:45:24.4814
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf12f4d7-0427-41bb-fb83-08de11ffbea2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE37.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7704

In IPoIB, the self loopback prevention configuration apply in activation
stage has two roles: fulfill a firmware requirement for old firmware
(tis_tir_td_order=0), and update the proper configuration as it was not
set in init.

Here we set the proper configuration in init, to allow skipping the
modify_tirs commands on new firmware in a downstream patch.

Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
index 49ab0de762c9..7f3f6d7edb38 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -409,6 +409,7 @@ static void mlx5i_destroy_flow_steering(struct mlx5e_priv *priv)
 static int mlx5i_init_rx(struct mlx5e_priv *priv)
 {
 	struct mlx5_core_dev *mdev = priv->mdev;
+	enum mlx5e_rx_res_features features;
 	int err;
 
 	priv->fs = mlx5e_fs_init(priv->profile, mdev,
@@ -427,7 +428,9 @@ static int mlx5i_init_rx(struct mlx5e_priv *priv)
 		goto err_destroy_q_counters;
 	}
 
-	priv->rx_res = mlx5e_rx_res_create(priv->mdev, 0, priv->max_nch, priv->drop_rq.rqn,
+	features = MLX5E_RX_RES_FEATURE_SELF_LB_BLOCK;
+	priv->rx_res = mlx5e_rx_res_create(priv->mdev, features, priv->max_nch,
+					   priv->drop_rq.rqn,
 					   &priv->channels.params.packet_merge,
 					   priv->channels.params.num_channels);
 	if (IS_ERR(priv->rx_res)) {
-- 
2.31.1


