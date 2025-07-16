Return-Path: <linux-rdma+bounces-12214-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE20B077C8
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 16:18:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48EDC581C26
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 14:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A78C1F1311;
	Wed, 16 Jul 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="gKRyi6Z4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A213BB44;
	Wed, 16 Jul 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675527; cv=fail; b=F+eEkvHRClG2wozdFFb9mgoDxr4NwB2S2r5W7+GF33dq9k1lIBvabAHsHlASMJ00f6ZeuUfgIEFv8pvehu1RPrppbeM+r9n/NbR1EdBIuYTEMD8k+sFTJlJlnl7V9VuzzLA8oLuwdRdZEZBGPM6zI/ToOqs0vHodIZazDfTxl0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675527; c=relaxed/simple;
	bh=Y4AttdlfYxMAJf+EphI81eZDGZEzH+AZwCuLtPuZ4Qc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R7i8n0vW6V/1sB1WPfWiCt6CRtO8cl10Bsve+NETHI++Fl9KkyZBt6GPrk42li4lVfXSAR+/MtLh2EmzdvU+XfNfoN+j/GNkXqUQsGDDJE9yDbQghMQ+0coWUx/0n3rAWKYwvc2TIRc4BtRzLn+ZgeebpnFo/Y0Kh+MAiM1Oefs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=gKRyi6Z4; arc=fail smtp.client-ip=40.107.243.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ecVIGcBvIdWchaUJ/s3Cymj2UxItygXhvhe0fFffi7RxW2phn34Moa/Q2lqIRHy3NiVs3kyEaTD/ZWCUQOMu9g/34eDL8a4F3Pz/MLPEM32eD1VIGci+qozUULL0ld+NzRczXfGEyvHm2k0MRDa6sLPvRiCVMPGCcvIKao4mnZ0vdfA/CGalVdP+ezR8D2kHwCeT7HWCW2iuAgnfagzJGbbyrSPbZ5ZcVabNRcY4S8M6KDuYwjMCKMl+UkMn4aS9bKaSPVFYf3DAJJUC2Nebq46IcAbQ/WhngXiywXeAmRvCrYk5E2MnYiy6EgHNhXU8NOJhcLd6vE/5Uk6EJuoHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jjsxHf9p7B2XdafL0Dix4tAAlTjXXkUY9aUjZpKMYKs=;
 b=H3QplXHy4uQC55cmnSY8HUPlxo5VZHaaX43F0H6Zp86hxe6Gt3SqfcxrFQ8pKz/GrrLomjXYXWf/ggLFeIXcHmtpi/sWgbKjZtPe2f4HnQE3Qnawo86+3sjGruECpIGm6JxHWCu0kLIZiGzL1MD3ACyCg6H8ZI478Gj8CIE6oKX/T4TF5dbjwggt+kYNV30xfjdMsLy+LI7fF5noPPVjS07buLBfqF6hzjcE35LRmSJ6J9B7GhdjjdMoZTe+f1N/oC1DhdE2njPIymER+fyXRx5n4DcumLA3rbonsU0gjDh6aHcfg8EbWWSIuPmYkBoSySahyGJXJB45Md/2u4z2sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jjsxHf9p7B2XdafL0Dix4tAAlTjXXkUY9aUjZpKMYKs=;
 b=gKRyi6Z4uKR7QAeYyDtxCCMLzD5Wwr89sXnvbmRbn1nADwO1iiTt8KIHjCgospNcjA553rpsYcv7ij5/z4sNPKZPvQ92WF5gbfoYf2LGwyZB9Po8kFObAdUXAPy6vRgEHVD39xNQz6IaYURflk+nB0IcW4kVreCX701+t0HYLfQIxC/GeJl6Ky+e3js4bPqMzrojvZXuyClq8m8bumrfM+54MfVgMtdvZXVro+gmMXqXUSofdVuGNHUN4dJGn3KBgKigeOkwkreMMbNa55EXxJzN8d+rDCyAevvTy/QtjCxMTY40iZqfnBqH87ALtkJw+RbeLt2VxKkMhnmQWR8Tng==
Received: from SJ0PR13CA0112.namprd13.prod.outlook.com (2603:10b6:a03:2c5::27)
 by DS0PR12MB7747.namprd12.prod.outlook.com (2603:10b6:8:138::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 14:18:42 +0000
Received: from CO1PEPF000066E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::e1) by SJ0PR13CA0112.outlook.office365.com
 (2603:10b6:a03:2c5::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.12 via Frontend Transport; Wed,
 16 Jul 2025 14:18:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CO1PEPF000066E8.mail.protection.outlook.com (10.167.249.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 14:18:41 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 07:18:24 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 07:18:23 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 07:18:20 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V2 1/6] net/mlx5: HWS, Enable IPSec hardware offload in legacy mode
Date: Wed, 16 Jul 2025 17:17:47 +0300
Message-ID: <1752675472-201445-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
References: <1752675472-201445-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E8:EE_|DS0PR12MB7747:EE_
X-MS-Office365-Filtering-Correlation-Id: 0192af55-06eb-4919-170b-08ddc473aab5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ij2PkScf/f43v4aH+ja5GqHtiD8zthVBHXViWCyGx61u7id944w+4VlwLalZ?=
 =?us-ascii?Q?AL6n2xLneivgm+NTTMDtV0j56Wor2KrB+oEFMqfKgtoFs49ZNAuN4gBKEkBc?=
 =?us-ascii?Q?DKzUvyGx5VMHk/UogSc5gc6FdOEdl/vN7/ehczCYf4i83gDZgPcVZJ/ppHF4?=
 =?us-ascii?Q?yRN8HIb0RGtv0/Sc5yGfLl9qI9YfzR1UwAUt4luQL5dVkj4ZyRZxmNmINZ4x?=
 =?us-ascii?Q?L77D1oDPC9dROfZL+pa4ux7ObjzqNbZ+pxM2GQEs7X6waI/7BvdN9rdwVLKl?=
 =?us-ascii?Q?jnEr99xArJBy9WDxGOoJLFuJwklioOiSg8t48smeM0j122SWSm89fJPM3XWs?=
 =?us-ascii?Q?DARPNUzA1MCWA993xX4ZA9LkzMCSPhVlAX5l4dl79wa4ogyl9Gs5AFB6mv9S?=
 =?us-ascii?Q?+drldOWrr915wEN1DujWPIIVASglm6hA6jFjQcz0SKV/UHiCa3E+x02vFDWk?=
 =?us-ascii?Q?KRm/z0nUWZwMza7LIhsYezjjI/C5r/ue/O6xAoFfjkRAo/KbqVFoi+tXPcNQ?=
 =?us-ascii?Q?az4EmEG/xmTdvs3lDgdaJHpqDc2vqdqHgztpqHOXuHMfoeYs9Q0GuZUaf7La?=
 =?us-ascii?Q?6pZM973GfZErwtBQDjiJ2AUZQqEFxHsHzte/57ye8DarWHfQRFMjzSwzYhML?=
 =?us-ascii?Q?ckEwpFMZm4RiUHXybqHiO6JPtzjt5mqrkvJRtNFE8P26qDjFuwQzeczgfg1D?=
 =?us-ascii?Q?9gxOyoUduMsqbyezJ9DINdK7lQk7N5AF3Bqvpa0ewJQQpQfqly6/0iOmIlPv?=
 =?us-ascii?Q?j2MX2YHicC2C7jEvCEBAEJDicPE/YuGXAdl+wjink6BiLVt3Q7iKkge5JFNA?=
 =?us-ascii?Q?SUCx2m2MRNEVGiwgTR1HKlQRRhJri5u1wgXuzbQprFlwSGCHq1Nh8XPycJ6l?=
 =?us-ascii?Q?IT+aTFVact2McWLHmFd9f9KwiJIbXiL8auSyZXHaUKFY2E++XYSQLVed1uCT?=
 =?us-ascii?Q?oD9RzKmHyERUlu/c/yyK2mkRPKT2+7n1a4gz//TBmPtUEdhWfcVzjYBKTz6B?=
 =?us-ascii?Q?qz777sT4t7DWxi99Haeon6y6YrJR/0JN4Gsz8y5phKbqqtfW/z+RBVQ4OMLk?=
 =?us-ascii?Q?pE1S5SXlPcHtcpec3kGGuCbefkHVHXnvL8W3lzISEBRD5H6inLA9dv7p5mRq?=
 =?us-ascii?Q?nwigqLDyMLzKCiMs3eul9Hs2Tdq2cHs2ysq7BFbf6m0CG7d0RJXJiNPw8CFg?=
 =?us-ascii?Q?CVFbj4mQ+fWjX4AoTfSKl5INrr3qcrk5LU2PzpnXnlAQiz0Dnzf9tWaXw18A?=
 =?us-ascii?Q?9OiudtomTRXQedw2/K0N7ukklh46+N8G9p4xodlr10WXDPVGAEik7dfKbOh6?=
 =?us-ascii?Q?UlCTfESdEG3nLXWeul18fwDGhIsDfDKi2spJIMpe0279ON5eNdEDV0l8ALSX?=
 =?us-ascii?Q?A81PA3K+z7NOesobTnYDZopSEI1N5v9oOGrD9LC3j2lHXOTFBbpRzSPureJM?=
 =?us-ascii?Q?W/L9l6yw+wufDGQ2hsfYh2nMmrFXP96Sj3MZY+jKTOowJ8ljeaZhyx/bZN6G?=
 =?us-ascii?Q?3Bx6ZSvP2d1faCpzlOOw9j1/wPD/uZK+zUXT?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:18:41.9805
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0192af55-06eb-4919-170b-08ddc473aab5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7747

From: Lama Kayal <lkayal@nvidia.com>

IPSec hardware offload in legacy mode should not be affected by the
steering mode, hence it should also work properly with hmfs mode.

Remove steering mode validation when calculating the cap for packet
offload, this will also enable the missing cap MLX5_IPSEC_CAP_PRIO
needed for crypto offload.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
index 820debf3fbbf..ef7322d381af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
@@ -42,8 +42,7 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
 
 	if (MLX5_CAP_IPSEC(mdev, ipsec_full_offload) &&
 	    (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_DMFS ||
-	     (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS &&
-	     is_mdev_legacy_mode(mdev)))) {
+	     is_mdev_legacy_mode(mdev))) {
 		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
 					      reformat_add_esp_trasport) &&
 		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
-- 
2.31.1


