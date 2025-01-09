Return-Path: <linux-rdma+bounces-6942-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EB57A08183
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 21:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BEA27A36D9
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jan 2025 20:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C471FF602;
	Thu,  9 Jan 2025 20:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ogsFVCcW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E061FF5FB;
	Thu,  9 Jan 2025 20:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736455450; cv=fail; b=EUX++YWSCmqiXYxReyVV1Hn0iS2MSfIbQMBWVGfvif0CfrQ1muBV38v23QETaTs1z2Q8uN3+FU4f3xmfwM4GHqiVjzF0FtYH6idIppNxTSv0wxTAwDseUDSeZX1tGx7heWqHXFIpCv6R9TGkoTEtbCf3nSkd8UH9vP7vzFQj3vo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736455450; c=relaxed/simple;
	bh=iZnR5NuUOXYkChTzY2KD48E9jV3MsLLZSmyspbBlSa4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qcoD+5apamsx5Ydp41rSK5+EFX/CCgd2BHCG9B/r5pyl+jAsGAHSbH7gOVByBwYNh1UyfMZvFVyGcglvkEGU8lG8Mutn7iwyJp/TiAGbzbxgqT4XVEHQ5mes+PrSdFMBMAMo/JHwQ6pGEpllrZ2noIQJGAJeYgDTV+TUy97tt3c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ogsFVCcW; arc=fail smtp.client-ip=40.107.93.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCJ+uy1RwH6GKme2+4+B/86XWlNMxwYUwDTMpZl41tHzLbGHUvHYTMaAC6JWU2pX22qjZl2GNhwMe2EIk/46++wEnbYyTGA2T4mRoHkm5Kv5uHOjlWP5VzPGzpERbLzGKpmB/WdgdHW30vBexcdD3dQWVLM5+WS1Nt7BZz5iSPA5fnNp3or46GRYeeSxD9GfvN49XWmKhlHYvqXl0kc9NEd6R/VjLKtv0DvS2loYRQKsMMDht5q3r6I4zfBGEkSBlmD57lBpb1Vo9EFw2AJUmvPid3RbfUQfK+dyFtRLJdudnzEOcrBoNPLez2COZdpvBEfzk7ObRa79xQ50XD494g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDIVBn1hnPVAyp5+gByE45WYl8+sLyn5oDgHImabGrY=;
 b=T9t05DOVu3YvF1NWp1EB4kV7XXW33P14r2/NjQOvS6jPvZw+TBwYYTGEy+BuEs5HoU73nJDPa6ccsrW3u7BeQuqSYn4sdrnzyNzB0RwzF3D32C7piuhhoQcLf+8wFbiU1bSVdCd/ob50rfoV+4Oizy7wnqAWDBHZZ7Xt0gyKbJWWejMOXM33503IwWFMdjxgGoFRP74FwPZHu1QEluZvGh4edKeOIdzhEufo/c3Qo7E+bUbKWrs1bC7KV9uEvB2w20zH60Gy4nZhu6T+jbUy2HHIebYcIGQKOAIDV37zxrdiZW0i5RdwtkJ437kE0bouyvE7BwV8Ws4p1B5ewlCfLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDIVBn1hnPVAyp5+gByE45WYl8+sLyn5oDgHImabGrY=;
 b=ogsFVCcWZS7eykByu0phS8dLF5X4lKmtFXofsaZ8Mcycl02La1QT+Cg3K3XBthnbeKpKWT6/JMNIxMjfwSVO1iy2Uj8b6nOWwCgzW9c2RX2CIxls7Ygi65Q2gKydA4hOYBRy7korbFPYqigZth9PCYB2TSYrQ/HK+yKJEioDs1EU56s+NSK+Z4DUpKoM/xYO0iqvPigHNeNv9BNgKaXv/M31NUloDNU4b38I4pPV7VIH8RMUwYRqC3K+V9KVCcKkb1+8MXmuwKqq1S4y8jXcfbVrCFcZQy2M9zSiwXAzwsxSr8LPQgcoI9VNURfI68uKy7JFK6D4HDHACxfPKW/VSQ==
Received: from BN9PR03CA0479.namprd03.prod.outlook.com (2603:10b6:408:139::34)
 by DM6PR12MB4449.namprd12.prod.outlook.com (2603:10b6:5:2a5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Thu, 9 Jan
 2025 20:44:04 +0000
Received: from MN1PEPF0000F0E5.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::76) by BN9PR03CA0479.outlook.office365.com
 (2603:10b6:408:139::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8335.11 via Frontend Transport; Thu,
 9 Jan 2025 20:44:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 MN1PEPF0000F0E5.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8335.7 via Frontend Transport; Thu, 9 Jan 2025 20:44:03 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 9 Jan 2025
 12:43:54 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 9 Jan 2025 12:43:53 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 9 Jan 2025 12:43:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	Jason Gunthorpe <jgg@nvidia.com>
CC: <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Gal Pressman <gal@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next 3/4] net/mlx5: SHAMPO: Introduce new SHAMPO specific HCA caps
Date: Thu, 9 Jan 2025 22:42:30 +0200
Message-ID: <20250109204231.1809851-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250109204231.1809851-1-tariqt@nvidia.com>
References: <20250109204231.1809851-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E5:EE_|DM6PR12MB4449:EE_
X-MS-Office365-Filtering-Correlation-Id: c591a8dd-a5f8-450d-37ec-08dd30ee5ab8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mJxLts8dVMg48FU0HiiPg9qaZuXCqGaWs6Ip+ywcs/htQxFTgq9opV/qbSOC?=
 =?us-ascii?Q?FFs9PGIdAzNsA0blXJS4OlvBxXZCmhGuIc9idawqd1B0E46jXmFX/tXMjYss?=
 =?us-ascii?Q?LmLGemavpmL6vwz2fj0iBqBSnf97FQcFXAUZMA+R/V4jlC3U+K4wTUh9lBYZ?=
 =?us-ascii?Q?DTIpV2PX6T+uQb00/di/k9whB3Fg7TETk+qnQauUN9djOcKJ5SAZrWiJaHmd?=
 =?us-ascii?Q?c9ZhSikMWOfcA2al3fTh49GH61mEikUegiLbY7511x1RrSWmpm9dQhSHHHQd?=
 =?us-ascii?Q?zLMBAqm5poe/s1bLckvmJIwEuvaZ7AmtZsH5x5j73vjI1SkU8GBmE2SrbTBq?=
 =?us-ascii?Q?F/Yzy8tbfK62BV8mPlDMc1QjG1lPxOr5XdZSTU4gUbUM7sz46ar1fIWrjCVD?=
 =?us-ascii?Q?he1EfK8VIbeGSMsYqi1FPzXGNJWTM3Hjrl9UTLjefiKlgzu9DgrYyzKRM5xC?=
 =?us-ascii?Q?ebN7h+/vBQAF2J+3GseelmXl+CXsLOnrMK7qGgdSaSo0b3CkL7zTAw1zTOKK?=
 =?us-ascii?Q?/iundHp13W1qC22zU4Ev5hrBnDLCTn1w1V8YmIZhR4Zyu5d1dRVsujHZulTc?=
 =?us-ascii?Q?M4MSAjRGV0zf/I+E66w2cnlBMhlSW68mxzJEFbbbKyM1vQPDmh9fRVZY5ruZ?=
 =?us-ascii?Q?Bl5o00xU/DhMHN9YsT2tyJC66A3GLoJzG29HlYC7VeGSl71VH13PZeHWdzeY?=
 =?us-ascii?Q?+Zjp24QMTQR9mAGbgPcReHAvSinKDYoV7yeKo8fJi9QUxMuxH0i5+DE4xjwl?=
 =?us-ascii?Q?I4mlKEa0U7qHxXVYy1FyHBssNEIAsWdPd08zc3NaYE4BEGCpFWt+kKNYVdlc?=
 =?us-ascii?Q?3XYL51QxZvXjPtZ8XSfOpmjV+QmT4IZF969IPdg0WLk6I1ZMXgxbE54smfyu?=
 =?us-ascii?Q?iy8RRsDWeLf8rmCUxyRtm+0zKeFCHuLY9diRn1R/EVcV+GT4eb56Kh8KJYem?=
 =?us-ascii?Q?RseV528H3EX6RxSQuXOO7jLWXpSjpACN5YcmzXHy+LD0fW/A67SRJAKQIuO0?=
 =?us-ascii?Q?jf8UAVNjmkFmhD1bA0HsBiVFIn7OWQ+8PVi7f4DnvXCon69LTLv3vksqZBr2?=
 =?us-ascii?Q?Y/JoB23dmCPC0yzeBlinWnBITM+NVox3LSBlE+wN8Sw0WMMKOASrditU20SH?=
 =?us-ascii?Q?jDVlSxnVHou7NJQ5ja+sHncR9q46AOvU9vRTcQE75nxPrf76DPUh2T5D0kNs?=
 =?us-ascii?Q?p+jibpWsKgkkXBvt177kgFEhlfyHoSRDKG198yzqRok/lh4zsurGKzrViRGb?=
 =?us-ascii?Q?VwPgDhrG7ADXnqfj8hF/n6eymEgu/t5LkLYyD6s0TK73k0HUOE+H+6mUbsyL?=
 =?us-ascii?Q?BrYwqC6GSqTl/i43tc4WY7tD6Lvf97Qum4lmEmg7igV0V3l/O8VGgsDolqoR?=
 =?us-ascii?Q?VkMPA/DEi7IiHRjyyT8uUvUdfpgjiHRK+4PsOQjNTAT1VWOXLy9HYUKqoFq0?=
 =?us-ascii?Q?IpJ8h0KvEdskKa9WkJzCCJv4V++To1zmHNY1MOdrBm43rco8T+aOFHYf1QCZ?=
 =?us-ascii?Q?bgnq2jv7yx6eOw8=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2025 20:44:03.6975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c591a8dd-a5f8-450d-37ec-08dd30ee5ab8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4449

From: Saeed Mahameed <saeedm@nvidia.com>

Read and cache SHAMPO specific caps for header data split capabilities.
Will be used in downstream patch.

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  6 ++++++
 .../net/ethernet/mellanox/mlx5/core/main.c    |  5 +++++
 include/linux/mlx5/device.h                   |  4 ++++
 include/linux/mlx5/mlx5_ifc.h                 | 20 ++++++++++++++++++-
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index 76ad46bf477d..b253d1673398 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -281,6 +281,12 @@ int mlx5_query_hca_caps(struct mlx5_core_dev *dev)
 			return err;
 	}
 
+	if (MLX5_CAP_GEN(dev, shampo)) {
+		err = mlx5_core_get_caps_mode(dev, MLX5_CAP_SHAMPO, HCA_CAP_OPMOD_GET_CUR);
+		if (err)
+			return err;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/main.c b/drivers/net/ethernet/mellanox/mlx5/core/main.c
index 220a9ac75c8b..a670e4538a13 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/main.c
@@ -368,6 +368,10 @@ int mlx5_core_get_caps_mode(struct mlx5_core_dev *dev, enum mlx5_cap_type cap_ty
 	u16 opmod = (cap_type << 1) | (cap_mode & 0x01);
 	int err;
 
+	if (WARN_ON(!dev->caps.hca[cap_type]))
+		/* this cap_type must be added to mlx5_hca_caps_alloc() */
+		return -EINVAL;
+
 	memset(in, 0, sizeof(in));
 	out = kzalloc(out_sz, GFP_KERNEL);
 	if (!out)
@@ -1788,6 +1792,7 @@ static const int types[] = {
 	MLX5_CAP_MACSEC,
 	MLX5_CAP_ADV_VIRTUALIZATION,
 	MLX5_CAP_CRYPTO,
+	MLX5_CAP_SHAMPO,
 };
 
 static void mlx5_hca_caps_free(struct mlx5_core_dev *dev)
diff --git a/include/linux/mlx5/device.h b/include/linux/mlx5/device.h
index cc647992f3d1..0c48b20f818a 100644
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@ -1245,6 +1245,7 @@ enum mlx5_cap_type {
 	MLX5_CAP_DEV_EVENT = 0x14,
 	MLX5_CAP_IPSEC,
 	MLX5_CAP_CRYPTO = 0x1a,
+	MLX5_CAP_SHAMPO = 0x1d,
 	MLX5_CAP_MACSEC = 0x1f,
 	MLX5_CAP_GENERAL_2 = 0x20,
 	MLX5_CAP_PORT_SELECTION = 0x25,
@@ -1470,6 +1471,9 @@ enum mlx5_qcam_feature_groups {
 #define MLX5_CAP_MACSEC(mdev, cap)\
 	MLX5_GET(macsec_cap, (mdev)->caps.hca[MLX5_CAP_MACSEC]->cur, cap)
 
+#define MLX5_CAP_SHAMPO(mdev, cap) \
+	MLX5_GET(shampo_cap, mdev->caps.hca[MLX5_CAP_SHAMPO]->cur, cap)
+
 enum {
 	MLX5_CMD_STAT_OK			= 0x0,
 	MLX5_CMD_STAT_INT_ERR			= 0x1,
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index 221146278ac8..d7c91f152735 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -2327,7 +2327,9 @@ struct mlx5_ifc_wq_bits {
 	u8         headers_mkey[0x20];
 
 	u8         shampo_enable[0x1];
-	u8         reserved_at_1e1[0x4];
+	u8         reserved_at_1e1[0x1];
+	u8         shampo_mode[0x2];
+	u8         reserved_at_1e4[0x1];
 	u8         log_reservation_size[0x3];
 	u8         reserved_at_1e8[0x5];
 	u8         log_max_num_of_packets_per_reservation[0x3];
@@ -3699,6 +3701,22 @@ struct mlx5_ifc_crypto_cap_bits {
 	u8    reserved_at_80[0x780];
 };
 
+struct mlx5_ifc_shampo_cap_bits {
+	u8    reserved_at_0[0x3];
+	u8    shampo_log_max_reservation_size[0x5];
+	u8    reserved_at_8[0x3];
+	u8    shampo_log_min_reservation_size[0x5];
+	u8    shampo_min_mss_size[0x10];
+
+	u8    shampo_header_split[0x1];
+	u8    shampo_header_split_data_merge[0x1];
+	u8    reserved_at_22[0x1];
+	u8    shampo_log_max_headers_entry_size[0x5];
+	u8    reserved_at_28[0x18];
+
+	u8    reserved_at_40[0x7c0];
+};
+
 union mlx5_ifc_hca_cap_union_bits {
 	struct mlx5_ifc_cmd_hca_cap_bits cmd_hca_cap;
 	struct mlx5_ifc_cmd_hca_cap_2_bits cmd_hca_cap_2;
-- 
2.45.0


