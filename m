Return-Path: <linux-rdma+bounces-4828-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 178959714D2
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 12:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CAE1C230D1
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2024 10:06:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C132C1B3B08;
	Mon,  9 Sep 2024 10:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uCD8uEvo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053271B3F34
	for <linux-rdma@vger.kernel.org>; Mon,  9 Sep 2024 10:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725876343; cv=fail; b=tqlCEMzxQ2R+V3QxG0TmbB7YS3vFVDDzleX++J2hUXTP+1rM2TQyX01flF2cp8T36UV3vIq8DTb1BIT7dAWpHbxJ+SJuLjVlL+/Ab/AhC3FIBYEES+CW9erXgCXYwKfzU2lLwsBzHs5pMisaYkP4rHHK+RjlG4LGYrXY41NTjO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725876343; c=relaxed/simple;
	bh=bwh8IN3GVDkApqT518iGbmgEkDVWi5swgLYSzS3AybA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RGr0+ce2M+4Nboj8Oj2YTY5Pdlb6bh9qs9B7Tch0Zvo950o2rl95FdrOmDJ0FAI7kS+StPjMkmqDNOppqeRzoHFe3YGKH+IDaCm2Z4KrqW2OCMJ5zbUGZ2rmwtjriBlkOF5MBOGR9z95ocgNlddda73xVtFueLkbdQiEklcT9sc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uCD8uEvo; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEpJrQqahdMNP3yBSKEkpGZrGeCcodiTHgIwH4yW7qidkA3AZqYVeVbLZOpCGgCtgKBbGooymXqL7AaoZgHMiKJB6Ls2QEZY4Lnoao+kItvpiBSaAi3b3scBj+NryReUXZW3G6T5jjJTZF/zp/LLFv3jKqv5YGb7VVDutAZatS89tYLP6j06A1oLKJ8LlscG6g9Wx+aFm1bDpaAZqe1ho1sud31hgDK0SXrHTPvTyO9SdIMwLDsE1LuFTjDzlNPISQJCSR629mULRRdDx5MnQkRgOzOuuigtpSFxUxeOP8bIt1m7+Bj7Kz3aRrihRT26+3XkiPCZj5KXIuWC++swqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iC5pVCwjpryKSBtAQx6+28APM4+DZJ5nJWGw0WUsNB0=;
 b=ae/9to7kRYuL2rdY4qpNt8P3jzh3nOo9Y5iPLEmr3ajPjKP2wXYYc7cQdSjvvEIz05JhOcbtOG0jC7in3g04HkksvacYyVO9gyiJjgUhKErT58lhTQY9kIx0sWzEDSi1HRxdMh4lW5XF2F/A5klOfRBklW/afSWyjYnzQGJB73pgWYH+w44IFcEtqE37vMGVitGC5k2feFXksOp+6nzx/7TC2cjC9x5niLDZjbB+WZ+eFLmVSxvLBwh78dLmqKKtrEv1veISl4hdjHOPVhJVU/VZjeq6r5Y/mda/b5ki/IUaphhE5LCY3TT4fROtBGc00ECDDDZ1hse18yx7l2MHVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iC5pVCwjpryKSBtAQx6+28APM4+DZJ5nJWGw0WUsNB0=;
 b=uCD8uEvora2tFS6g6YykcE/0w7pt6XMgGEy1t7w174gwnbxeM1QYMi39uKurq1gJefZdw2U3+6jLwHxjWhlUiNHNpDQ/r0zB2nlh4GP4Vx6xN3Hxjwn8F3BsocRRPTB0cWl7yVN+E1lFTLAa7t4d5WDWFLd99hDg8j6xG/Bjie+mlt8riDXMNzD7njDBgEWosZNWDbrt+HP+6fzOBX5uEqpO/h3lvJnQMfux8NZo9U0snGKFO+Pbdbw3qjldArn2/gEpFYqpNgfe1MW78jnUAbQE7PXBemh0e2++5Xdi3wAQOTdZiw6EriVzXPitnaWPFiqjuoOj7wbUyE/LgfuVOg==
Received: from MN2PR06CA0019.namprd06.prod.outlook.com (2603:10b6:208:23d::24)
 by CY8PR12MB7414.namprd12.prod.outlook.com (2603:10b6:930:5e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.17; Mon, 9 Sep
 2024 10:05:37 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::7a) by MN2PR06CA0019.outlook.office365.com
 (2603:10b6:208:23d::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.23 via Frontend
 Transport; Mon, 9 Sep 2024 10:05:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Mon, 9 Sep 2024 10:05:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Sep 2024
 03:05:25 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Sep 2024 03:05:24 -0700
Received: from vdi.nvidia.com (10.127.8.13) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Sep 2024 03:05:23 -0700
From: Michael Guralnik <michaelgur@nvidia.com>
To: <leonro@nvidia.com>, <jgg@nvidia.com>
CC: <linux-rdma@vger.kernel.org>, <saeedm@nvidia.com>, <tariqt@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>
Subject: [PATCH v2 rdma-next 8/8] net/mlx5: Handle memory scheme ODP capabilities
Date: Mon, 9 Sep 2024 13:05:04 +0300
Message-ID: <20240909100504.29797-9-michaelgur@nvidia.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20240909100504.29797-1-michaelgur@nvidia.com>
References: <20240909100504.29797-1-michaelgur@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|CY8PR12MB7414:EE_
X-MS-Office365-Filtering-Correlation-Id: 96e8639c-26aa-4b97-9b4d-08dcd0b6f3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aE/F+SBKtT4UW3gouB3KBC9jUrVMprnABuXGoZRV0JPAqcJYMgsGDJnYWw5c?=
 =?us-ascii?Q?5mkeOOWRy4D9XxGWKksirD5BkOPNuWMxVQo0fjuAamj0uUp8Y8cKJAX5LCBd?=
 =?us-ascii?Q?yYykoedPgasPCDLln6NiejGMjuye0dJrE9nEdhzWJhO5bqDOXYIeviXzh8HM?=
 =?us-ascii?Q?tb/uroRicc4TexT8OPUZyX5vPQj0EQsCxWeGtDszkOJZptAOGVhZkjQBOwKO?=
 =?us-ascii?Q?MqnkqkXwk9gdHyoQGkyMSwJCBFdDwPFyjB7NOrHu+XY1wCHweWgYgiTDTgEn?=
 =?us-ascii?Q?Umqh3fCSjRqAvsasPgboK7F6Wg22mgnEtODC8LiSr3KSYxnUvRBVgH0AcHcc?=
 =?us-ascii?Q?1LT7nLx6zI/ExNkI2BT/vnq9ERoLzz4fRpB1Ec52Qc4acvut9c9uPk0RTtfM?=
 =?us-ascii?Q?rM2MktTW18KM7QD9VIa6iW3lb/RT3eptgj5n5irbgKCq5LtFrzA1MuG0t9/Z?=
 =?us-ascii?Q?jyqPG8Nmk3Kyu1A6CVNTftWfrNcT2J6UUjJjkoZ2u2/myyqVbzKggg4vC95Y?=
 =?us-ascii?Q?RuM/E+hsyrJ9GVQ82Yp3FlQwaRjR5gVOBWjnsCG7JWFgV+Cu8m8n29HvUx3B?=
 =?us-ascii?Q?Y1DBDmO+kehlntlV/cdFxqB0gNia81IzfLOpBfRpuLcMQ4IwB1XB12x97cOP?=
 =?us-ascii?Q?0iWGzlDDziUm6mCfB0rMspY/BqyGdSnAffHC05AjoCYjhQ4lcqfjkfLWBHXe?=
 =?us-ascii?Q?aILGJBd/eW/uQcj3ZCEjhTCz59Jz/apZiMgVDH5eguvblLdKfx8lLITWVsQ7?=
 =?us-ascii?Q?HXg9MfgbhXRvfgVKt6CCw7bI18yfQ9pCWcrW+TGRAsL+KS6XaAkh8cl6pPrw?=
 =?us-ascii?Q?d9DcbzhNVoJBYPwoXAZ7yfmcx9UZWTgupO5Fnw2zt/SUJLgWEijKdOW6FS4s?=
 =?us-ascii?Q?0YP9Jo1529ocHbk6N5EE8ql2vE9yN0c2uJdm6S9t212W9hbBnmKyI5Eiqw2J?=
 =?us-ascii?Q?oQXRb8LdlzzDaLfHuYGZoKLNQNxWNXqPFwEgkccmC9bcSCEX2QzKIzizgK03?=
 =?us-ascii?Q?w2G6RO3Lbf/JjQ/dQGEYHWD/K+GFvN+mnuNL/fZEVX+aNcTXBnyI6nfUvG22?=
 =?us-ascii?Q?lsMb4Flp+dX5q6Qw/DLHMVOUMGgujykm/gX4Ku4HMCWrncgvexHD+Ex+lmsQ?=
 =?us-ascii?Q?RCLCYGYtn5e0rhs7nq0nD3t+HNOjY1QcIZEBubrrzomvCFfgKIF6G318plpW?=
 =?us-ascii?Q?SXEg69FjM1prPgB6spfqDK7gobyVkDCB1q1hGU7PlOjRq7/n3XfxBQBK0OYA?=
 =?us-ascii?Q?iGewNSkN750APuOopo9/BoHOwWxVMfnNm/KAuRziNvIqB6oRQ6ilpRmyfqUR?=
 =?us-ascii?Q?ptzf06tRCcnCVIBmzujKIFj0xMKwM38jCVz6CJoqQsifZs/11dZDQMbTTTSn?=
 =?us-ascii?Q?yajKKrTVSDmoSl26IlJ4/pvvqI15d43Rm1wYtqcgVi4AeGplj2TbDjCNFhtb?=
 =?us-ascii?Q?oe7d6rM5xNJs4ci8ZslSzD91Mitx/ofA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2024 10:05:36.9086
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96e8639c-26aa-4b97-9b4d-08dcd0b6f3b2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7414

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


