Return-Path: <linux-rdma+bounces-6496-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 37EF29EFF20
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEF54188E236
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B5201898FB;
	Thu, 12 Dec 2024 22:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A92Nj3M4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2071.outbound.protection.outlook.com [40.107.94.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626121DE3D5;
	Thu, 12 Dec 2024 22:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041746; cv=fail; b=twoX86sD9OGL8zt4XZ8AsgY5gYxEgn+dbFqX+8Nd/An+evxAOju9fNCZdgC+5SnfbGbt2aha451YZSpDly864s3iZkpHlfvVEUeYO/ZCrZNu/Nv9jiLJyubfjnYKdt/9t99DFnN3GYBh6NRUnO98JfU0c98lov2GsfmNRKJU7hA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041746; c=relaxed/simple;
	bh=A+oajGb4jNh11clMOgpt2ZBtKNJEb+yXYLA4cfLyUIk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfzHB09WRQGmQWiHwZem5Pefeq0gbXNOrxMwJdYZom98FMutsV1Uwns2mNxBU6+wAEAQQnZKOXqXQGdGxNMnQUgGTN/zfrWsGm98LKWwxckN/mFPeO0EVgwJuj/DqqVCoTNqLa/nIdwrfCttnzy/rTKHPMmDr0eumslnKOLjB6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A92Nj3M4; arc=fail smtp.client-ip=40.107.94.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B3JOqVQ0Az48cxL70wGO7F7xEQ0zm1hDSIJ5ShD5XMN/a+1SLW2khYUynZJv5C0/ziShOq6RgCWcU/EAIrBmM9f/mH4ydWxWOdTrGuIlaud6FuzvboYglTLVe+f/f7+lSgOQKq2aD9x7vDcKPd6SEH8mXuoedhiM2USwdlPVCdtoAOKHqmOQFM5+8RnC2psWpHR4OTr/TBkwiEL2xYn1wLW9KiSKTNbryioVw0oeavwIDiJUHP37k1nInBuBTpsso/v5DSCXpPH23PLhHyPXK9pFJz4fWXX2uui1RjyftwH65AQslXq+FzX91N8KNsTU8BBVNJqwSE1+lDd8BBdjSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xSKYJJvBudYdr/u8xFqZkJOHIQIVQj+wpBHwSZdEVEk=;
 b=RmFETZLs31q5hQ59RRyDTZbyn3fSnWcl2sSdPb7HKpvJR2xJ0TpSdJV7oSQUV0ahcdOzpZ28yIKBrC6Ylr2q39Y0Z/H3CZ1DhDwrIY1tNYNiJ/CxjfyW/3Y5yx2JHEKj8vZnvXAvjA9TcNCHvddEkJ8jY6Lx/yCZ762gwbyHSSDlQjDM2xWO6TLo4+O5m4yptxKRtvOWKwaMbIwhKRMjsyzuR6On/FubstKfBdcSD5FKKO6p4NlNX5IObZ0xVD/4AQQwtS8EujMwctcPmtZYCa8+3XuOt6dVqMSiXVsO09K/OUJ4X1KnvV8KA+Cj6ae8ADdGgDm3vF0npPIQXNuDXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xSKYJJvBudYdr/u8xFqZkJOHIQIVQj+wpBHwSZdEVEk=;
 b=A92Nj3M4nqosEA61WeuBSQ4iMp6ixG5rHz0F2cpqiLDVbfs9IJ1hTbAe7P9BEhfV0AdDeHdirLDu0KRiYoxigoGVBAZrJT9/ONavNOrLd5SkBhlemDP9/4X+J6FoaMZGxOUhDNQPuyhxeMh0PGwGylA8oChf1D9dvFTOq2Gz1yM8uoYlNafpCGrQDM8FGwP++lUeuMT+rWFeU56oioI69pTXdWot6jMv7yLolAd6iDmqtblQPFK8PRMtcwlxxsZe+XiZWDfyRNwDBZ0cIN4F9mjXT6l11XzOEsMtOCMQCfLTJI2/jpR7zOM3ad1DK0nb6LvnQ050HPSUCrdDChqy4A==
Received: from SJ0PR03CA0383.namprd03.prod.outlook.com (2603:10b6:a03:3a1::28)
 by LV2PR12MB5776.namprd12.prod.outlook.com (2603:10b6:408:178::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Thu, 12 Dec
 2024 22:15:37 +0000
Received: from SJ5PEPF000001CC.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::61) by SJ0PR03CA0383.outlook.office365.com
 (2603:10b6:a03:3a1::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.14 via Frontend Transport; Thu,
 12 Dec 2024 22:15:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001CC.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:36 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:15:20 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:15:19 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:15:16 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Patrisious Haddad
	<phaddad@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 10/10] net/mlx5: fs, Add support for RDMA RX steering over IB link layer
Date: Fri, 13 Dec 2024 00:13:29 +0200
Message-ID: <20241212221329.961628-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241212221329.961628-1-tariqt@nvidia.com>
References: <20241212221329.961628-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CC:EE_|LV2PR12MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: aec8ab5a-a710-47ae-2211-08dd1afa80c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+qmut/vEs9QJe/8VgTDe4/rOauVDpyZILXocH21oNtcVZbvcTKnTQCQXdHst?=
 =?us-ascii?Q?AtYgWd4SLduGzsEmmIx8Vr1BgavNYMxRDuPZvwwvICNxZuPBtepKDp7CHO/G?=
 =?us-ascii?Q?VbLwKh8YQsIkw31qE0X8bh0vdHQv/skqSiTsptFCawuf3gFO5RNSRydKUuma?=
 =?us-ascii?Q?X2f2mVK52cGYU5bIJF19h8xtcKCASzRSu8GLCbvglhidAMf0A33rgf4BnPCP?=
 =?us-ascii?Q?2ob98yEUiffkvyM5Jl5oZ5I2qxNiFHd2noshhgl7Ma8PBF1X3VmFfNJuICh2?=
 =?us-ascii?Q?lLHRQ5L8tUBXIBwInNtWvutVGFp4v4s6ucM7BW9yGmmNvTry04qyma1BZX/V?=
 =?us-ascii?Q?PB2A118T2RWd6Y6aDmyf9fYTdnoyCfoCzLO2+x8gHyuuX0dSvD5qmnn8ErIF?=
 =?us-ascii?Q?rIfd4G18slA2b6DdlNQ/XioPuF5zhDjInC1t9T44PhUk3JWUfe/cepnjNK+q?=
 =?us-ascii?Q?jQguse+PV2eDqXlQ2ZmN1BytmxGx8fpOgjDRpFujfZxK0/Wi6OjsVh7Q967j?=
 =?us-ascii?Q?ydFPTRoRluqLnKaxLqqxsoOZbcDBzdQHBQvAe9Vb87mA5UoQ8SPwTyK3Eqbc?=
 =?us-ascii?Q?5+XjhK1Ej33XvU54obz6gXdRAldNYj/2kH+VH6yd7A8Kd54B8CdxxNl4ny58?=
 =?us-ascii?Q?eCoY5hKcxrtp9XWgNtuFxCtGcbVWHI7Ee7GH3in3SjfGxVVzF0JtAgAObLBL?=
 =?us-ascii?Q?Tht4ETFyXH/KMVyCJglXg9cpcKYF8/OYDG3i+UsZ4GSDnxBdAYwoiVOljJ4h?=
 =?us-ascii?Q?4BQfLgVPC2wEN3JFkcFSS6/L0hg9k4dbSV9l0/JI9ZYOy4JR0ekJfY4vLNLy?=
 =?us-ascii?Q?TNicd0+wEwygwHLyPzgHUJm0yKaqELDTRwQ9oovwkHH8pHxFtD99VrHzEUtQ?=
 =?us-ascii?Q?+TsaPSOBMmaFf0jU7GcycSBkzhxAZsl4NVR+GuNAP3SzpXACTQ2Jhu8N8hzt?=
 =?us-ascii?Q?DuOEav9x0XhmpyVvYsm82F9/OThWnM9pP1ku+mPjNovRu1q4SObq6Gkw99km?=
 =?us-ascii?Q?3b1HohR2oStVKv9XfhuxowZTuWgFS88b4SD4rjrALINWwfugU8yJEHEcRITQ?=
 =?us-ascii?Q?yWZcAEVxFaWr9AwNdKiAcvN+SSvEv+ou24Tq6DKOQMwoT5cs3Uc15KfUHaH1?=
 =?us-ascii?Q?ABSiqpgaGgBAfEtewr4EncFOigpxnyfQFJYc4z2iDcM7LKZnfccuBTQUtzD2?=
 =?us-ascii?Q?tnyvVDp8/JgU9RNohDBlBsGJhBpDDo5BfdiT4gChWZRLTxKyPI5qAHQg0htM?=
 =?us-ascii?Q?D1ZDEPU2v5U34XNvrUlAkoAMnyschYnd2KdU19UH+2JiVwZeTeh/bEeRilDZ?=
 =?us-ascii?Q?NrA/lAdRA6xQzQ20PtlK50w9rW3ZcbcrVt5+hlfiChDSyx54ydZeKJS7jQ9q?=
 =?us-ascii?Q?NiuWRCvXo8rNXFAaWLDklSgtb5bKz+RlCMGDZo/5p5bl9Sy8bQqXR3ImczDp?=
 =?us-ascii?Q?8uZlobmRhWa0WeT5Ac8rtIRjimg6GQTj?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:36.0543
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aec8ab5a-a710-47ae-2211-08dd1afa80c0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5776

From: Patrisious Haddad <phaddad@nvidia.com>

Relax the capability check for creating the RDMA RX steering domain
by considering only the capabilities reported by the firmware
as necessary for its creation, which in turn allows RDMA RX creation
over devices with IB link layer as well.

The table_miss_action_domain capability is required only for a specific
priority, which is handled in mlx5_rdma_enable_roce_steering().
The additional capability check for this case is already in place.

Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c  | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 +--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
index 676005854dad..7cfc4d81f346 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c
@@ -217,7 +217,8 @@ static int mlx5_cmd_update_root_ft(struct mlx5_flow_root_namespace *ns,
 	int err;
 
 	if ((MLX5_CAP_GEN(dev, port_type) == MLX5_CAP_PORT_TYPE_IB) &&
-	    underlay_qpn == 0)
+	    underlay_qpn == 0 &&
+	    (ft->type != FS_FT_RDMA_RX && ft->type != FS_FT_RDMA_TX))
 		return 0;
 
 	if (ft->type == FS_FT_FDB &&
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 1eb2c5ff367d..2226ee8dce2b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -3664,8 +3664,7 @@ int mlx5_fs_core_init(struct mlx5_core_dev *dev)
 			goto err;
 	}
 
-	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support) &&
-	    MLX5_CAP_FLOWTABLE_RDMA_RX(dev, table_miss_action_domain)) {
+	if (MLX5_CAP_FLOWTABLE_RDMA_RX(dev, ft_support)) {
 		err = init_rdma_rx_root_ns(steering);
 		if (err)
 			goto err;
-- 
2.44.0


