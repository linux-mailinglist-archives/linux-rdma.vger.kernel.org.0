Return-Path: <linux-rdma+bounces-4749-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 963B496C27C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 17:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78D61B25C09
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Sep 2024 15:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 391111DEFFA;
	Wed,  4 Sep 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gi8IzZOL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2040.outbound.protection.outlook.com [40.107.220.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524211DEFFE
	for <linux-rdma@vger.kernel.org>; Wed,  4 Sep 2024 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725463878; cv=fail; b=o3yydrdBLPYiGMJBWwYBKRZEIHXqNIsvUuQf7Iyx1Bb0KZGkYE/Rli8BQ9DB8JMMop1tE9wOn3bcH+POPsZMW8TDHormr11nJhmGdXANVB5IJWjz/XPX9L1E4gJNo/YUT3qZ0ypjAzrsw+0mxpwOUGh/a2Kkmrrs++0mVmABqCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725463878; c=relaxed/simple;
	bh=bwh8IN3GVDkApqT518iGbmgEkDVWi5swgLYSzS3AybA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=noVFHJsWj7Ukqp+pRyTncaVnWId9iHCnBLhFmv9D6gP+iMH+xeSA6bvvt7Y/Hvcu4l14UOAISsBa0WhMBJGjxwKzsxg6AI4z04olBTBVwv9sAYruN+gNRXwP+6Z1/utJR2/XkSgjhTj1adP0JP9mt3UNVQUtDxsTCmYai67OnR0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gi8IzZOL; arc=fail smtp.client-ip=40.107.220.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X4DLjys63ywRPc8OkNPPgDztqM8M8gfvrZD0+XB65AYi0HcH2yqa1aKEt2J56v7u2DQim564igLwIWPKWCxlWaTyQP/Obx62z8CPrB2vOSnipaPxhvx0ipX/7yH+CqjSVy9GT1Uqd7SgX6nn/xJ+gN2HBCBdhZpFx5rX/uOm5Hh3KL1+8rPw6Sli9sl/KNAIyrgfOAo8UlDcF0fHMtt7/hFw2ysbISpBDmpvh5lKxB7okY1KtDCGOv/im/I9YGPwquCDQvkyAgCriy70Ry3Jwj8x5YU4zM9OkNIGvIgShBJK736X7b5WNHyPRCGk4wruSv7cLtkpHTLynccc5q2I3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC5pVCwjpryKSBtAQx6+28APM4+DZJ5nJWGw0WUsNB0=;
 b=f0T8YSUzsXAoVNC8NqUcjm9+EMuF04UfnIfG7DEF3v+SBtNCHa+gTDFOcXmrzeTzX913WGzxl+hHexqp3PKB//ouKAtRdFaoKXHh9gn5VhXWP/4CJuFc/vZceWvirMpEghB1prGedo1sFvwH8LsPWjx4p/cVNVNukFI59pOSaRTY7P1gIUAv7TI7RLJjZTWRZ9yRZNoqO01Nm1ojOxb0YqD2qlfo6pHoKqGJs6SkwvroVHgbf9GoPKUDPJtIsJOrBArX/76d5TWmPzzdQuHmrPB+r72brDUCm1woMsv8pl1Hosn2mkIfy/W23SizuitgDSNisChDQri+c0+gJ6qO6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC5pVCwjpryKSBtAQx6+28APM4+DZJ5nJWGw0WUsNB0=;
 b=Gi8IzZOL3vJ//CQzqvvEgFUnPS5xtrr8Z6gXiuU9MxsSkv0/zvvAOyV6JjH8ok+QsOe3TllhBUXQEMc8jtRLouc01ANAuA3Uha6H95Wf77lvFh+VnaEMCSU5eM3mK6ZdayYAG9pBXdZK9Lgx6b7SIeVFyDEfmpjNTjXbo1jVxlzZ6YVge0BWytQGWci5V5AG7Pj8or50Sx8KtpRSI9dAggqCnDXxtqGm5SdQ9xLGeRlrmJCc5q3sexMQNaPn/XzBHUymU61HDNXU7oX6iu4JCu7d38CTOIK6V40MrOiBMoztTg2TIVtL2RqjjA5Wm8tcOc5yPNPXLYLUcmciU9KS8A==
Received: from BY3PR10CA0002.namprd10.prod.outlook.com (2603:10b6:a03:255::7)
 by SJ2PR12MB8882.namprd12.prod.outlook.com (2603:10b6:a03:537::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Wed, 4 Sep
 2024 15:31:11 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::2) by BY3PR10CA0002.outlook.office365.com
 (2603:10b6:a03:255::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.26 via Frontend
 Transport; Wed, 4 Sep 2024 15:31:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 4 Sep 2024 15:31:11 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Sep 2024
 08:31:00 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 4 Sep 2024 08:31:00 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 4 Sep 2024 08:30:58 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH rdma-next 8/8] net/mlx5: Handle memory scheme ODP capabilities
Date: Wed, 4 Sep 2024 18:30:38 +0300
Message-ID: <20240904153038.23054-9-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240904153038.23054-1-michaelgur@nvidia.com>
References: <20240904153038.23054-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|SJ2PR12MB8882:EE_
X-MS-Office365-Filtering-Correlation-Id: 959928c0-e430-49cd-44bd-08dcccf69b09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WXaHF7D6eYS7fuBhOIk0U2gNlhkxTn8Gf521Y1K4CNQU17WuWFkjCLz3N+QC?=
 =?us-ascii?Q?c4HWJAUAxdOpTrQojYAm7ELTni5AW1Jc0EDl35vQdjfRFfzkJB3BtQF/5yow?=
 =?us-ascii?Q?XXJaucHO7xzjqOkiVAft8FR9YAMD1i4cdb2W8Bek7kDW4dRATOiL+8rfnY61?=
 =?us-ascii?Q?kFAYrrfSKuhJsHmcto9eOdLffNSH1kqwiLUprTab2rBkbYaxLcg8KdgAgxGk?=
 =?us-ascii?Q?RhqAv2Qp/0e2tMfwySSAlManXbVaUA67OqiaI8FeRbtODgEzZL6vPWRQA655?=
 =?us-ascii?Q?fOBTvFDyeAylJKshvA0pPS8sHwfbJpqOSXeDe/8zelkty3BhiH5KyYfjgaOo?=
 =?us-ascii?Q?nv3Mabu/7qe4NO/qYM33Wc4AwiAE1GreITqvPYIJpd2fjbxuexGj/kcuQp91?=
 =?us-ascii?Q?Z3Z5BndsKEExENyqbe4mcBkaXyfl1QTVPu+9jyx/neMrXBn3kb5VV8rhMExe?=
 =?us-ascii?Q?iZEzu84aHoWC4qi2G+KisMaeiWLxgcHquTIj1nbSeVlmBAa3oS3KcXEh0H/H?=
 =?us-ascii?Q?TUP3swM7olhK6v5yr9SMaOrAXhLQs81pFpyRfxtdzqAB55oxz1R+ESS+vSb+?=
 =?us-ascii?Q?oSY6S+gyCm1dKYSWWts6EM3r9eIOsL2hIWS/9WttY1/JDSRmifj/9ngk3OPf?=
 =?us-ascii?Q?yfOkiGti9qteji7xf7e1v7K1tqWCZ3GfumnwTTUsoW44IWk+oI6a4WXkOWPN?=
 =?us-ascii?Q?sQnIfv1CJSImVHJv8tpiuEyi23L30v4+ok1o8tcESHxGO+tuKahEcKwYmY7z?=
 =?us-ascii?Q?65ikV7GlFJ0krhMHbpOvK0Anacoe/L4vvsgseqh7rBPnyX/jvt+Z00XcXn9k?=
 =?us-ascii?Q?OynVsti/YxQqtnnnN6HtYbmMXzZVVAakLKtzV6cHCduCRz6XycyIOKRD2yEf?=
 =?us-ascii?Q?LQ1drAM+YstS2Ha4NNicrnLGOpUzDzNRbt5sMlr+/vDWCmztFeBsQENb6Li+?=
 =?us-ascii?Q?qh8r/ytdpOF9uZpMhMMRSm4C4zFUotUfsp6K0tRY4ynHEPA1EUjXjEJ2Xfgt?=
 =?us-ascii?Q?l2XDGkEJjq5KuQPHaANdFqItqj9rm6pnlnvgn0nLgfoWNtQBVNSwKDNelLmQ?=
 =?us-ascii?Q?CfYhzGirymcxNOPUgIAwXMVi/yqABqY0c4BsQXIZIccPn4l8976Q728W3ypp?=
 =?us-ascii?Q?B+GhaAz9HpcHryET4v18NX1EeQ64NmhDiQ4RjrLgiFMISogMR1z18HMrUpcz?=
 =?us-ascii?Q?HrXxBw0WYfIkimiD6xp/61JXQq2XMBMyx+mxxaQeO/pgg2Ea8y/v2IRbqyqY?=
 =?us-ascii?Q?+gZNSOQ0gPe0fyQfEJLhZe8oDiC0+te+WSbqUsvuLic+oSWnXEg7bA2ptJr9?=
 =?us-ascii?Q?IRA/mECPrrZtUgzV4Umga7nHm+RWsQ2TaSvBtKEi8xBbrMMbL1kPZG+Q+Fx6?=
 =?us-ascii?Q?aCgrfqEJb6LBQrOqRQJCVq+fqi/9QWqgXuYbc7O/KT66qzRbI+89DNuDCUwr?=
 =?us-ascii?Q?cdK8kEjyJzznIw7KPMHVo+bIcu3gwHiV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:31:11.3614
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 959928c0-e430-49cd-44bd-08dcccf69b09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8882

When running over new FW that supports the new memory scheme ODP, set
the cap in the FW to signal the FW we are working in the new scheme.

In the memory scheme ODP the per_transport_service capabilities are RO
for the driver so we skip their setting.

Signed-off-by: Michael Guralnik <michaelgur@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/main.c    | 22 +++++++++++++++----
 include/linux/mlx5/device.h                   | 10 ++++++---
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index cc2aa46cff04..944c209e9569 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -454,8 +454,8 @@ static int handle_hca_cap_atomic(struct mlx5_core_dev *dev, void *set_ctx)
 
 static int handle_hca_cap_odp(struct mlx5_core_dev *dev, void *set_ctx)
 {
+	bool do_set = false, mem_page_fault = false;
 	void *set_hca_cap;
-	bool do_set = false;
 	int err;
 
 	if (!IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) ||
@@ -470,6 +470,17 @@ static int handle_hca_cap_odp(struct mlx5_core_dev *dev, void *set_ctx)
 	memcpy(set_hca_cap, dev->caps.hca[MLX5_CAP_ODP]->cur,
 	       MLX5_ST_SZ_BYTES(odp_cap));
 
+	/* For best performance, enable memory scheme ODP only when
+	 * it has page prefetch enabled.
+	 */
+	if (MLX5_CAP_ODP_MAX(dev, mem_page_fault) &&
+	    MLX5_CAP_ODP_MAX(dev, memory_page_fault_scheme_cap.page_prefetch)) {
+		mem_page_fault = true;
+		do_set = true;
+		MLX5_SET(odp_cap, set_hca_cap, mem_page_fault, mem_page_fault);
+		goto set;
+	};
+
 #define ODP_CAP_SET_MAX(dev, field)                                            \
 	do {                                                                   \
 		u32 _res = MLX5_CAP_ODP_MAX(dev, field);                       \
@@ -494,10 +505,13 @@ static int handle_hca_cap_odp(struct mlx5_core_dev *dev, void *set_ctx)
 	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.read);
 	ODP_CAP_SET_MAX(dev, transport_page_fault_scheme_cap.dc_odp_caps.atomic);
 
-	if (!do_set)
-		return 0;
+set:
+	if (do_set)
+		err = set_caps(dev, set_ctx, MLX5_SET_HCA_CAP_OP_MOD_ODP);
 
-	return set_caps(dev, set_ctx, MLX5_SET_HCA_CAP_OP_MOD_ODP);
+	mlx5_core_dbg(dev, "Using ODP %s scheme\n",
+		      mem_page_fault ? "memory" : "transport");
+	return err;
 }
 
 static int max_uc_list_get_devlink_param(struct mlx5_core_dev *dev)
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index 154095256d0d..57c9b18c3adb 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1389,9 +1389,13 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_ODP(mdev, cap)\
 	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, cap)
 
-#define MLX5_CAP_ODP_SCHEME(mdev, cap)                       \
-	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, \
-		 transport_page_fault_scheme_cap.cap)
+#define MLX5_CAP_ODP_SCHEME(mdev, cap)                                \
+	(MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur,         \
+		  mem_page_fault) ?                                   \
+		 MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, \
+			  memory_page_fault_scheme_cap.cap) :         \
+		 MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->cur, \
+			  transport_page_fault_scheme_cap.cap))
 
 #define MLX5_CAP_ODP_MAX(mdev, cap)\
 	MLX5_GET(odp_cap, mdev->caps.hca[MLX5_CAP_ODP]->max, cap)
-- 
2.17.2


