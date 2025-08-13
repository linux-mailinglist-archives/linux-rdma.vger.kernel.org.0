Return-Path: <linux-rdma+bounces-12727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B6DB253DB
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 21:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01481C83704
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 19:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21C073DABE3;
	Wed, 13 Aug 2025 19:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PCoU0r0c"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C75E30E85F;
	Wed, 13 Aug 2025 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112851; cv=fail; b=Eve6U9PSLdqQtgiUwo5vhIrAWmKvDpQ+tXFsP2fdg89fi8xih3hOhFvmNNLsblnBmLByBH8dZPL9/s2Yl3c4LwmkjA7pnz3Kokf2penNS/aUGmPlq2Lsij1S7RJgLwv5+8pDMdGD2IWsMP36HYwOl0P8VGiCN3UBNSwyfQuTFpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112851; c=relaxed/simple;
	bh=MQ2g4M0EUJ3R2kltCW6fk1S3UJOWiG4S+8BemCVXH00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8GnHF0Exfjqi3k4aR2SY5MpMDqZKtbi3TNdV5GRCfuv+euEhMTxQNzeT/k2/FHVz17JNua84OEkuzfeWKdp0fiVwG12ceJphTRmJyg/78DOk6SMeku8uq+QdyQX2nPiUxpubYPcE965y46MfO6y6LPMg4QT5fIlESqTK+gfb40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PCoU0r0c; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d2xOOthGMnW078VvvKTmIhHfM7GbvTtikzDKvF5d1+q97YL9tA8FYMH/7ZdR/XCJvDjvNVWVn4I3EY/zFBmp61AICT78wpQ1hM1Y1SlGIefT4pCVry0XGAraCRdy1YuForNO5P7IzvM1/fRSkIqzvZ9IQYsTGz89tB4u8Z2aMh4qVfjGcUY4tdaGIGkXVvxXf7z2lpTk4nJec2Ynfm1Py5Z9sFAUsEjOxTjsXyvbPNTZKrmqqs0PrtFtWiweEsg20QQWb2URQNf8VJoaP9akuZCSxAGnr5bAPpROcxViFjVPF8OQ44ArcMS6VFRUHcBPNONHCGwFGgfJ8BLtU1hRZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6wNcDPioJmSvjOs0THkdEuhbonE9T6Zz/elgiNvL9E=;
 b=x22uweb+8kxbJJlnOIaUC8VyDswuELSb/gbf+Ox6dCrDVTxjJZBq4eTG+9WCM62CTZj1omZ6oSU8K5UsqqfsPzKlrS4TtLmLbtSt5EGoQFW6UNWeMlyMvH2i56emu8U9OxUwZ0wP+YsfOITUE6ADsx8Ir1Qu9lDay9EcWLsXaBKhkzL1q55jwUFYSfSbrM71AtsRgwOijyRvMq2MKIEcfCRu6zrKUa3NU6QP3M/gJUkriL/wkevedu6a/giZs7mRqvaJ5tUft9gxgiE2nRR8naJ/KKE+aBpHMzlsAaAfPWGM4N8CiXDNrvwPndIlbmJ0luah7E90jSszmTa8AI4iXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6wNcDPioJmSvjOs0THkdEuhbonE9T6Zz/elgiNvL9E=;
 b=PCoU0r0c1rm4rHQXoZW83LZlPlLrXQTbEScshQa+lYOdYoHiA8FlBWh3oXYzYiDjNA3tipQmoXYtT3PwgoZqIvkym/BrgFGxnwKChgUHvCihVJHSQVPLMv5fOACOBINsutzskkS0+rv3PdeheQitABYExt8rQ2H2y3wn92YvADA7poQMS86uYgQ7NlOxr+AKbKm6rZBYy5pyrWKRyp40hFJlyCmfPg1zOSU0Up5K8h0si6T2atcxKH8/GOAeI9GxaKYZSaOGxcH3oFDPcVUy0+K35EMvkWrVTSkaYNy4l0zMHZkpabq5O0DSt4Flu4Ms9rouGtsENothN2IloXpxLw==
Received: from SN7PR04CA0116.namprd04.prod.outlook.com (2603:10b6:806:122::31)
 by LV3PR12MB9233.namprd12.prod.outlook.com (2603:10b6:408:194::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 19:20:46 +0000
Received: from SA2PEPF00003AE9.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::dd) by SN7PR04CA0116.outlook.office365.com
 (2603:10b6:806:122::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 19:20:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE9.mail.protection.outlook.com (10.167.248.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 19:20:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 12:20:26 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 12:20:25 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.8)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 13
 Aug 2025 12:20:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Daniel Jurgens <danielj@nvidia.com>, William Tu
	<witu@nvidia.com>
Subject: [PATCH net-next 2/2] net/mlx5: Support disabling host PFs
Date: Wed, 13 Aug 2025 22:19:56 +0300
Message-ID: <1755112796-467444-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755112796-467444-1-git-send-email-tariqt@nvidia.com>
References: <1755112796-467444-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE9:EE_|LV3PR12MB9233:EE_
X-MS-Office365-Filtering-Correlation-Id: 0554b0e2-58e0-4e06-d384-08ddda9e80f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tZ5YS5kR/dwmPnlYi40tyj5uLXspX62mFInEKl1G5p72ZF97XYk9C8Hb9v+1?=
 =?us-ascii?Q?HOqbd6XEgd6mU1MC//eSv1kBH/XHTLJvZS4ZCxDhH7gfhxPqoWx4t4bNuzqC?=
 =?us-ascii?Q?NdNn2SpFdp+66kK9wyugTfKQlRieckZIfO0H9ogrs1bhWZM8RarA3SY6e4L9?=
 =?us-ascii?Q?6gu+sQcVGTl/EYqMzIYHi9/v0kzrYjIpCBMV086CohwmbssCiEZAURqqGwWh?=
 =?us-ascii?Q?q/jqS4JCc3Zualc/lSqI+zdzyL12ph5YFs/spN0heI558fZ92Cr1YHiDijld?=
 =?us-ascii?Q?XwEFI9vUFEfpmBmUqhFRxHGuT/1ue11l8kcg4gtGl1E/vS6/5OVDoJxXetK4?=
 =?us-ascii?Q?nqWZ+eDtSxT2PNP69beNPApc/pmWTUJvswUDDK+EISRNtGz/Cef52ff9kSa/?=
 =?us-ascii?Q?Nyh38dhShssTDRchMG1C8RN0GP8TyqmGeqDLMYnWsr5Xe7SztnLtHI0dJF6M?=
 =?us-ascii?Q?IH4DMj/cs4qdMIdvtZV3fqdpsAhR1TfqdXdNC4G8CiuNriQXFJ4virEu3PJT?=
 =?us-ascii?Q?Lbm8p1o2m1Yhcejl+6uEAZ0locUmv5+Ak7R33yRRthVRFuwh6GOeAxwxOEC8?=
 =?us-ascii?Q?vFt0nFCJvRtc2d/chNGpC2dxG4FGodfvlXAirMcTs8wSpDHe2abTKmeapZWT?=
 =?us-ascii?Q?O0LSrJQfnkva/5ZyHn4BZQgCFbOwrrVFbDuZFfv2gyJSsDV+5pM3KCRK1AUw?=
 =?us-ascii?Q?igD9RiCNF2hsjh+T7OlaY3g5rqm7ofmqzNv3kKfelzCquaofq41B1s916l1L?=
 =?us-ascii?Q?xcJx3bVIrjpOS7EOtzQbkZsmUp2R3EguAasw7BFILczqWUGJMQfswFMFivHk?=
 =?us-ascii?Q?XFMFGD31korSZOwN449KG+cmMeQn9N96IKQnBqjLf3ti7LVmyfBAnWLG6w5n?=
 =?us-ascii?Q?k95ytk+WXINKimtDjwNn5ULZ3xdzSn2jtQ7fypkTWsYh6OIbMJLSWGxnheze?=
 =?us-ascii?Q?Gcw8IWVvtbIQ77gv3QH49wXhkwp4poLkGTZz+TUTLaCirQlQvvMC9nk6egQ1?=
 =?us-ascii?Q?Pma2e0qnbmXORrrGRiU2d7MzTyil2pThNUNYP9nQ5ONKzl1B49VowekXqsxv?=
 =?us-ascii?Q?juRs6I3ndSGs8w2qO7wEEnTaaRaJFz/n9l8tYStRfj9kn15d20u87vGO+bdB?=
 =?us-ascii?Q?bRb/5Tr2oCddzyJb2YZ17f4m7Prm4NbMS/f1XqeletjZleL3ONcjdbMVzfNb?=
 =?us-ascii?Q?7rqlUwbF34i8G0YwOlVCANT6YCaQXhal4PlDXsxYNRNugTGShFDgxA5kIQJ2?=
 =?us-ascii?Q?mYJehh7TDXnSXZLPrADOy73meyex3MXdEc7PYgJkY4y8z5je6rxsZtpFsSjR?=
 =?us-ascii?Q?uMqo86orXOOP83P81pPAlExd71sIu8AUYssz5nNBbge9NTKX3zY4q++V9qSe?=
 =?us-ascii?Q?r6MVwv0E65n5PECzz5oTtFK0qEujPdzdRjpAzJ30cCEaKLIhN+jFnbSwu45F?=
 =?us-ascii?Q?4DJounwCc+J0pJiUDU+iuqNPdy+R7EOx8xwAr3Rx60QwpMlcPxPblD4bR6mk?=
 =?us-ascii?Q?YX6+GMda6VuUbeF5qQ9qP0r58Tm8sqGXT3Cl?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 19:20:45.8263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0554b0e2-58e0-4e06-d384-08ddda9e80f3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9233

From: Daniel Jurgens <danielj@nvidia.com>

Some devices support disabling the physical function on the host. When
this is configured the vports for the host functions do not exist.

This patch checks if host functions are enabled before trying to access
their vports.

Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/eswitch.c | 62 ++++++++++++-------
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  7 +++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 34 +++++-----
 3 files changed, 66 insertions(+), 37 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
index 31059fff30ec..3d533061311b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1297,17 +1297,19 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 		    esw->mode == MLX5_ESWITCH_LEGACY;
 
 	/* Enable PF vport */
-	if (pf_needed) {
+	if (pf_needed && mlx5_esw_host_functions_enabled(esw->dev)) {
 		ret = mlx5_eswitch_load_pf_vf_vport(esw, MLX5_VPORT_PF,
 						    enabled_events);
 		if (ret)
 			return ret;
 	}
 
-	/* Enable external host PF HCA */
-	ret = host_pf_enable_hca(esw->dev);
-	if (ret)
-		goto pf_hca_err;
+	if (mlx5_esw_host_functions_enabled(esw->dev)) {
+		/* Enable external host PF HCA */
+		ret = host_pf_enable_hca(esw->dev);
+		if (ret)
+			goto pf_hca_err;
+	}
 
 	/* Enable ECPF vport */
 	if (mlx5_ecpf_vport_exists(esw->dev)) {
@@ -1339,9 +1341,10 @@ mlx5_eswitch_enable_pf_vf_vports(struct mlx5_eswitch *esw,
 	if (mlx5_ecpf_vport_exists(esw->dev))
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 ecpf_err:
-	host_pf_disable_hca(esw->dev);
+	if (mlx5_esw_host_functions_enabled(esw->dev))
+		host_pf_disable_hca(esw->dev);
 pf_hca_err:
-	if (pf_needed)
+	if (pf_needed && mlx5_esw_host_functions_enabled(esw->dev))
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 	return ret;
 }
@@ -1361,10 +1364,12 @@ void mlx5_eswitch_disable_pf_vf_vports(struct mlx5_eswitch *esw)
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_ECPF);
 	}
 
-	host_pf_disable_hca(esw->dev);
+	if (mlx5_esw_host_functions_enabled(esw->dev))
+		host_pf_disable_hca(esw->dev);
 
-	if (mlx5_core_is_ecpf_esw_manager(esw->dev) ||
-	    esw->mode == MLX5_ESWITCH_LEGACY)
+	if ((mlx5_core_is_ecpf_esw_manager(esw->dev) ||
+	     esw->mode == MLX5_ESWITCH_LEGACY) &&
+	    mlx5_esw_host_functions_enabled(esw->dev))
 		mlx5_eswitch_unload_pf_vf_vport(esw, MLX5_VPORT_PF);
 }
 
@@ -1693,7 +1698,8 @@ int mlx5_esw_sf_max_hpf_functions(struct mlx5_core_dev *dev, u16 *max_sfs, u16 *
 	void *hca_caps;
 	int err;
 
-	if (!mlx5_core_is_ecpf(dev)) {
+	if (!mlx5_core_is_ecpf(dev) ||
+	    !mlx5_esw_host_functions_enabled(dev)) {
 		*max_sfs = 0;
 		return 0;
 	}
@@ -1769,21 +1775,23 @@ static int mlx5_esw_vports_init(struct mlx5_eswitch *esw)
 
 	xa_init(&esw->vports);
 
-	err = mlx5_esw_vport_alloc(esw, idx, MLX5_VPORT_PF);
-	if (err)
-		goto err;
-	if (esw->first_host_vport == MLX5_VPORT_PF)
-		xa_set_mark(&esw->vports, idx, MLX5_ESW_VPT_HOST_FN);
-	idx++;
-
-	for (i = 0; i < mlx5_core_max_vfs(dev); i++) {
-		err = mlx5_esw_vport_alloc(esw, idx, idx);
+	if (mlx5_esw_host_functions_enabled(dev)) {
+		err = mlx5_esw_vport_alloc(esw, idx, MLX5_VPORT_PF);
 		if (err)
 			goto err;
-		xa_set_mark(&esw->vports, idx, MLX5_ESW_VPT_VF);
-		xa_set_mark(&esw->vports, idx, MLX5_ESW_VPT_HOST_FN);
+		if (esw->first_host_vport == MLX5_VPORT_PF)
+			xa_set_mark(&esw->vports, idx, MLX5_ESW_VPT_HOST_FN);
 		idx++;
+		for (i = 0; i < mlx5_core_max_vfs(dev); i++) {
+			err = mlx5_esw_vport_alloc(esw, idx, idx);
+			if (err)
+				goto err;
+			xa_set_mark(&esw->vports, idx, MLX5_ESW_VPT_VF);
+			xa_set_mark(&esw->vports, idx, MLX5_ESW_VPT_HOST_FN);
+			idx++;
+		}
 	}
+
 	base_sf_num = mlx5_sf_start_function_id(dev);
 	for (i = 0; i < mlx5_sf_max_functions(dev); i++) {
 		err = mlx5_esw_vport_alloc(esw, idx, base_sf_num + i);
@@ -1883,6 +1891,7 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 		goto free_esw;
 
 	esw->dev = dev;
+	dev->priv.eswitch = esw;
 	esw->manager_vport = mlx5_eswitch_manager_vport(dev);
 	esw->first_host_vport = mlx5_eswitch_first_host_vport_num(dev);
 
@@ -1901,7 +1910,6 @@ int mlx5_eswitch_init(struct mlx5_core_dev *dev)
 	if (err)
 		goto abort;
 
-	dev->priv.eswitch = esw;
 	err = esw_offloads_init(esw);
 	if (err)
 		goto reps_err;
@@ -2433,3 +2441,11 @@ void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev)
 	dev->num_ipsec_offloads--;
 	mutex_unlock(&esw->state_lock);
 }
+
+bool mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
+{
+	if (!dev->priv.eswitch)
+		return true;
+
+	return !dev->priv.eswitch->esw_funcs.host_funcs_disabled;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
index 6d86db20f468..6c72080ac2a1 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
@@ -899,6 +899,7 @@ int mlx5_esw_ipsec_vf_packet_offload_set(struct mlx5_eswitch *esw, struct mlx5_v
 					 bool enable);
 int mlx5_esw_ipsec_vf_packet_offload_supported(struct mlx5_core_dev *dev,
 					       u16 vport_num);
+bool mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev);
 #else  /* CONFIG_MLX5_ESWITCH */
 /* eswitch API stubs */
 static inline int  mlx5_eswitch_init(struct mlx5_core_dev *dev) { return 0; }
@@ -966,6 +967,12 @@ static inline bool mlx5_eswitch_block_ipsec(struct mlx5_core_dev *dev)
 }
 
 static inline void mlx5_eswitch_unblock_ipsec(struct mlx5_core_dev *dev) {}
+
+static inline bool
+mlx5_esw_host_functions_enabled(const struct mlx5_core_dev *dev)
+{
+	return true;
+}
 #endif /* CONFIG_MLX5_ESWITCH */
 
 #endif /* __MLX5_ESWITCH_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
index bee906661282..8ec9c0e0f4b9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch_offloads.c
@@ -1213,7 +1213,8 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 	misc = MLX5_ADDR_OF(fte_match_param, spec->match_value,
 			    misc_parameters);
 
-	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
+	    mlx5_esw_host_functions_enabled(peer_dev)) {
 		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
 		esw_set_peer_miss_rule_source_port(esw, peer_esw, spec,
 						   MLX5_VPORT_PF);
@@ -1239,19 +1240,21 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		flows[peer_vport->index] = flow;
 	}
 
-	mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
-				   mlx5_core_max_vfs(peer_dev)) {
-		esw_set_peer_miss_rule_source_port(esw,
-						   peer_esw,
-						   spec, peer_vport->vport);
+	if (mlx5_esw_host_functions_enabled(esw->dev)) {
+		mlx5_esw_for_each_vf_vport(peer_esw, i, peer_vport,
+					   mlx5_core_max_vfs(peer_dev)) {
+			esw_set_peer_miss_rule_source_port(esw, peer_esw,
+							   spec,
+							   peer_vport->vport);
 
-		flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
-					   spec, &flow_act, &dest, 1);
-		if (IS_ERR(flow)) {
-			err = PTR_ERR(flow);
-			goto add_vf_flow_err;
+			flow = mlx5_add_flow_rules(mlx5_eswitch_get_slow_fdb(esw),
+						   spec, &flow_act, &dest, 1);
+			if (IS_ERR(flow)) {
+				err = PTR_ERR(flow);
+				goto add_vf_flow_err;
+			}
+			flows[peer_vport->index] = flow;
 		}
-		flows[peer_vport->index] = flow;
 	}
 
 	if (mlx5_core_ec_sriov_enabled(peer_dev)) {
@@ -1301,7 +1304,9 @@ static int esw_add_fdb_peer_miss_rules(struct mlx5_eswitch *esw,
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
 add_ecpf_flow_err:
-	if (mlx5_core_is_ecpf_esw_manager(peer_dev)) {
+
+	if (mlx5_core_is_ecpf_esw_manager(peer_dev) &&
+	    mlx5_esw_host_functions_enabled(peer_dev)) {
 		peer_vport = mlx5_eswitch_get_vport(peer_esw, MLX5_VPORT_PF);
 		mlx5_del_flow_rules(flows[peer_vport->index]);
 	}
@@ -4059,7 +4064,8 @@ mlx5_eswitch_vport_has_rep(const struct mlx5_eswitch *esw, u16 vport_num)
 {
 	/* Currently, only ECPF based device has representor for host PF. */
 	if (vport_num == MLX5_VPORT_PF &&
-	    !mlx5_core_is_ecpf_esw_manager(esw->dev))
+	    (!mlx5_core_is_ecpf_esw_manager(esw->dev) ||
+	     !mlx5_esw_host_functions_enabled(esw->dev)))
 		return false;
 
 	if (vport_num == MLX5_VPORT_ECPF &&
-- 
2.31.1


