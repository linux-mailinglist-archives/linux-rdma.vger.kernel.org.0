Return-Path: <linux-rdma+bounces-8798-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A7FEA67E4D
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 21:52:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD14717A87F
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 20:52:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023E7213E9C;
	Tue, 18 Mar 2025 20:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="m3W64AAx"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B2A32139B5;
	Tue, 18 Mar 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742331140; cv=fail; b=STR1f8wTPp8MSfkoSaOvp4rRFPxv2x4S5kBSnYJO36r6It2OnvdQn1gs+PidNRQvqvZTmEJaJEmsB+PLfk7iPSZLrz/FWxJx7mLdcclMngLCHMwxHZh52Zq+mMhA+wruVgn+uIgxB6zYCy1gm1thWpVX9JJp59PviZfDYb9Mnlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742331140; c=relaxed/simple;
	bh=mwdw+m7fRotcbnqkkHbdGmqHGVnV1N468KenD6nvhVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hBoKH1WdzccJHNR2lzYAIJ4NFF2SLJYQ7FQQ4ZyK5IftHWrrIyqtns3VsrsLZuJizLGqTZxSHy0lSZPouLj1s5+pa+I8ZSfbul0Ua0Tl1zydQGFqbSJ9IRfrtRgEn4U+ZxbciFCfRjxm9a4Q5/qPZIPuL4/ybfd0AbceeZ7sg6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=m3W64AAx; arc=fail smtp.client-ip=40.107.223.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edos0WpXaOp7EaY+GdKpBXY/pLOfRV7HMMjwqNTA7mt1911EhaH00zqQQs2SrJsJYIfwt3olY/947ArvkgoSx6V+4/uaodcA16+qKH4qN/bgOt7ZZ9IM3XbaHjHxEKkWpTJy+0zJMHKFJcP3jTIsGgedttcej5GazV+T+rEFKAfQePf81+HixcZ5A7gvL/cTlxA/s8srf0+SvBuPhocIqaCtqaAWpCkxPbQVIk1Txw4w/1crogSyXinfb0pfbuwkPNrIWjPvjMINVMlAoZjDmtq4lXnSPFe5YKqhbT9aFmh7BZcjpLGq1/+wxnI9KGwRXLiAge0dNIdQKV5AZGMtzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6gPrtqnpN1JtydiYzM5eoTmkdlQcQe81JgVLOSX0TI=;
 b=d6GQ6Ois1IrNBOIy1VS12TuxHVKgpXM00rFeTf3vZArlFdbshriZfCPjDCwjZn5d4TPQdWjxNorMbduS8eqQEpGg9+59OMheY9kPhBfOViKCjJDDd0jB7X9g1Lq40RSlWZLj0ILth6xu1lkPwhXgGyEOZ10PcTDbx506OZZZrTFMFaUtMtCdqWgugznZYw2xs8qyzRoIldqQZCfrXRbGdgnngfZ2/qO5VTuSKHpeHaL6eZLmvKBfGxxV8GncbN/YY4ELq16tD+hnYY4lnHvDQISAf+5Y1+9Jtu3tNqcMMqcGG5vy6C3zalHDAdJipARnh6M2QT8oPxwsU4q+LKoBgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6gPrtqnpN1JtydiYzM5eoTmkdlQcQe81JgVLOSX0TI=;
 b=m3W64AAx4KxcaU5lVKPSAhONBtVnrSAT1iMbtiIAJZIXedl9jth9q1uOOp314+wnL84GmHrzweDioxVQgdaiUtauKKk1AhyOEX2MHVknBufgHdMUxzqc6a8XdTOHHSFEFJHFoRxb0DzJxiYjUsL/a8F8mtKdZoYD6srVzfQfjEpGdYtHjuIv+IZKTuyCClsqAQQKYx40k52wSBDwhbyzeiTuZkAuonI+qCG7YHiaPXAJ8+wVKmIYE35SnkfdDLRFfqa+5VlEtkPcjYnE0EjY8ycC/ITcZojZwB8XTGZWM2D+s5/rPCLAEP9sSiqCTa40Y+Yer8gKBUtN8Bu5uscHGg==
Received: from BN8PR15CA0050.namprd15.prod.outlook.com (2603:10b6:408:80::27)
 by SJ2PR12MB9209.namprd12.prod.outlook.com (2603:10b6:a03:558::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 20:52:14 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:80:cafe::d9) by BN8PR15CA0050.outlook.office365.com
 (2603:10b6:408:80::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Tue,
 18 Mar 2025 20:52:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Tue, 18 Mar 2025 20:52:13 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 18 Mar
 2025 13:52:03 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 18 Mar
 2025 13:52:03 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 18
 Mar 2025 13:51:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>
Subject: [PATCH net 2/2] net/mlx5: Start health poll after enable hca
Date: Tue, 18 Mar 2025 22:51:17 +0200
Message-ID: <1742331077-102038-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
References: <1742331077-102038-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|SJ2PR12MB9209:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f273594-2a69-48bc-0544-08dd665ec277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oDzWqe7ngNnUpLSt6Un1WQs9jAUPegAuGgxfhRNaosHzTJ4VavN7DfPvo88H?=
 =?us-ascii?Q?wTuxKDzYr2dfoYHcCC5fEVyURL1xUuZRfIII9ju+0T4nh51yeSabP+7C92mc?=
 =?us-ascii?Q?3uamn1Gfipd2uGxoP/pSC0/8VeaeBspNuSIDBctZLAmaV1JOz49E4x+aTtb5?=
 =?us-ascii?Q?eEqVjhYTMuOkYTOuzQfacxkK1R4nZ6svG0vg1zzxzHiWhoq6fFDwX6GNGKSA?=
 =?us-ascii?Q?7LZVxdWLXHr84JpdwiNgweHyCKRtvwtMSOfwi2+ifqEYFuTH5PnmwNAuH212?=
 =?us-ascii?Q?kx6eTDrlk85+hgbmx26w6TAHti/9wr+cpbBicecPtDdC8gR42IKVgJxqIASy?=
 =?us-ascii?Q?o12wQwk1JcWtN7Th9ZyFGo3Rdl9StQx8abMa8bqDjBZ2zpzQ+zYdP0C9NbEv?=
 =?us-ascii?Q?68ypa+lMH5nAe5zoSon5Uo6+dgVUJitzhAQs1w1FPsRz9b10N1sb9g5FRu1I?=
 =?us-ascii?Q?d65D7Rkx03TLHQeZjcIqYB/ZNCikCbefXq139GKZmwmZRNNgoqTLx/hjERxK?=
 =?us-ascii?Q?+pg2rPJm2tE/EHfp0BZ49qJKny8xHE13au3i0nK44kUQjo/p5mSrs6nEOGvo?=
 =?us-ascii?Q?uZs+KkVHFqSIajeqZ32dUCAt+tTkcoa4hM1NOoI9Y76jAnDzsrhQX3ivt7MA?=
 =?us-ascii?Q?+o0a++i1BS4RH6IYBnfuuMVhoA6oqhqhDqDk/3rbODD+SnF90lZZh1IB4w9K?=
 =?us-ascii?Q?9slcBMqa+JIXnGBHLWgAp5KxEftIcqM6R+OmoAxZfG7FtgdRLzNEspnpwI9U?=
 =?us-ascii?Q?zs+782O4tou6RLbYgFA0u1s9LFYmxVrMbZkO4bo1/vr4Hqy/ofEzqvvGcA96?=
 =?us-ascii?Q?wQPXuUg4lFaIjUVu7Vi9F1d75GlHph1HTDMphG8coPMGY1UAxtbNmkKfHWub?=
 =?us-ascii?Q?LlWl2UUzDJEM9TC3Rr4fvfIxHXfhI3FocEyNY+/dXXI8TKq5fM6OfZMQsTCE?=
 =?us-ascii?Q?FjHLB3YZbgdI6nFN2QB0v+jRy3YHH+AP980DmwcLgt0MpUXbTzxN8zbwkUPp?=
 =?us-ascii?Q?ToUS/WuVCNZKdo5Cz9SMCnIeK4/Aymh3MbkoPnAHsyOz5d8EZKDylKkEtd1v?=
 =?us-ascii?Q?4/o1xZRSG931F0dOM3WBR/HD3FjlMDaJhAoOkZ+gwbBXNjFWC2kwb0lI/lLj?=
 =?us-ascii?Q?0xr4OB1DIOL0RHsaS1sFzuGZFOMaA3r55f8YuqVKGLgCawnamqJ4RJbjlxOL?=
 =?us-ascii?Q?5tVgEy2CsfQb0C/uANM673A208gHK33msjm/927FVz98zyTXtkj56qCZyY8u?=
 =?us-ascii?Q?nPOfTh7wjPVur6P7FjWG2h3ttt8IhRvTz+4L3TnnxhkmVgk1+e2T2Vvn7AIX?=
 =?us-ascii?Q?DiaRd7hVqPg+QdJ1ojAd2ZsS+W4qDm6P631TBeu0KeQ907WamkfRsWRWfooo?=
 =?us-ascii?Q?7x7Ny3HJGMpq2gLTqMi2/2yQfk5Mu2J4uBLetCdoXxd/OJ1SHUwBVAgidtA6?=
 =?us-ascii?Q?rTcHzyLCPL8kTc6Cgh4jCcAM0EMxEueYK3Fb9qoIbFBxTwnxFrWtStrn7ShZ?=
 =?us-ascii?Q?PK1LPMcvaTMINC8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 20:52:13.0298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f273594-2a69-48bc-0544-08dd665ec277
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9209

From: Moshe Shemesh <moshe@nvidia.com>

The health poll mechanism performs periodic checks to detect firmware
errors. One of the checks verifies the function is still enabled on
firmware side, but the function is enabled only after enable_hca command
completed. Start health poll after enable_hca command to avoid a race
between function enabled and first health polling.

Fixes: 9b98d395b85d ("net/mlx5: Start health poll at earlier stage of driver load")
Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/main.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index ec956c4bcebd..7c3312d6aed9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -1205,24 +1205,24 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 	dev->caps.embedded_cpu = mlx5_read_embedded_cpu(dev);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_UP);
 
-	mlx5_start_health_poll(dev);
-
 	err = mlx5_core_enable_hca(dev, 0);
 	if (err) {
 		mlx5_core_err(dev, "enable hca failed\n");
-		goto stop_health_poll;
+		goto err_cmd_cleanup;
 	}
 
+	mlx5_start_health_poll(dev);
+
 	err = mlx5_core_set_issi(dev);
 	if (err) {
 		mlx5_core_err(dev, "failed to set issi\n");
-		goto err_disable_hca;
+		goto stop_health_poll;
 	}
 
 	err = mlx5_satisfy_startup_pages(dev, 1);
 	if (err) {
 		mlx5_core_err(dev, "failed to allocate boot pages\n");
-		goto err_disable_hca;
+		goto stop_health_poll;
 	}
 
 	err = mlx5_tout_query_dtor(dev);
@@ -1235,10 +1235,9 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 
 reclaim_boot_pages:
 	mlx5_reclaim_startup_pages(dev);
-err_disable_hca:
-	mlx5_core_disable_hca(dev, 0);
 stop_health_poll:
 	mlx5_stop_health_poll(dev, boot);
+	mlx5_core_disable_hca(dev, 0);
 err_cmd_cleanup:
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
 	mlx5_cmd_disable(dev);
@@ -1249,8 +1248,8 @@ static int mlx5_function_enable(struct mlx5_core_dev *dev, bool boot, u64 timeou
 static void mlx5_function_disable(struct mlx5_core_dev *dev, bool boot)
 {
 	mlx5_reclaim_startup_pages(dev);
-	mlx5_core_disable_hca(dev, 0);
 	mlx5_stop_health_poll(dev, boot);
+	mlx5_core_disable_hca(dev, 0);
 	mlx5_cmd_set_state(dev, MLX5_CMDIF_STATE_DOWN);
 	mlx5_cmd_disable(dev);
 }
-- 
2.31.1


