Return-Path: <linux-rdma+bounces-12104-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D613DB0361E
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:42:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC69F3AAFFC
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 05:41:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CCE221FB1;
	Mon, 14 Jul 2025 05:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Yuhgrfs7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2047.outbound.protection.outlook.com [40.107.94.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB9F1FECB0;
	Mon, 14 Jul 2025 05:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471666; cv=fail; b=e/Mr+MHEb+G7XLBOKXvTppbzP5VLmnz0eNNUPdI3mXhWrW2DXCzBwcDh04Z1Fd62MYGO+2t4ZpisTz9Od0FeljYxDQgyqVvbUJNGe4YGk1CSsDM5HGo9kXUnbK2a3nkbCp4/iK2ABJ6BIvlFZDq1587KXmMQScrTgaWGdpbecqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471666; c=relaxed/simple;
	bh=S+J19DBuoN9eufNBN5zF9uHHSoB5E/JjnBz1opoMGKY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NvfikNUHoh/kGdS6OSZ/FXg2yJD/NPpiscR9hqfW7B10kTErdIOwjU87kTt7Z3ZyrGkvHhSmQqmbBhLgsBDGDGAMwVvb1mqLlNFmBfMPFsNfexJxQZbqvZ4miEIyTOO7kv4tZePQymriEEjK+whdQkXH64xSzRauTKVeZD6KaJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Yuhgrfs7; arc=fail smtp.client-ip=40.107.94.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NfDpkNt+L478NXoXZ0N1NDBKB6YNMfhWlzLLYjEaCu1qWgINf1FGBBpx1GLf6jAl8d5s8EmOmb3l+mlqhUO2f1c6+S5NvoqE0Y2QsKGI8U3+EzhdO3nOJ7hd5VSzeFD0VstWFdNgjd9nQOJrJ4hBL0s3g9bZBLO73ukVsF0yW2K2sNbtNP0Hq5aGW9HYUpPhYUUqm4Vszqb+JfZMekLN3ErsQmK4NBysw0vKaQzilIAVR5igmGVNoyK5tAgVd7Y9SWjVzmC1BwP0wBVEekqM8xkn4g/pDUtiGqY76PdFh5zVqlPqQXGH+yWIoxJfHfiM3AfV6/yFaxupVYHZvUbl8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7nICyObmMvbWPWrhZlqj6X3XUjcaL0+FQbCeNp4sxhA=;
 b=IlNYqIjwiYcqZPLRGBD2owHtPDwT9UVYNJ8w6D+YGPelxVzPNAw97ET+KFo1cgqR8+3WGxyoWnIYhxg0dTtrD+BzVRX/I/twP+fr8Bx7sn75T8Tees7ju3xKCLaw+SOwBp2y+noFLa9G+QTgmQtPjRVn+D5CTq/UvCmwASkXBa2gb5ozhU3TxYeLYgNIQwtJ92PzGcKduDgx9xcwBatfwDlcZwoolx/7K6wSfgBK3eBL+ClvpbuQHDHZtZEb6XXg00+nG3csTgfYKr2oYNMhkqsw8lWkXx5vqpGilmW29x4i7HojT+J2BNNN6L7ywszGSlJIbGyeD2DpEfbPwwRW7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7nICyObmMvbWPWrhZlqj6X3XUjcaL0+FQbCeNp4sxhA=;
 b=Yuhgrfs73dgyBTy21bbTGfBLuEEhBgOYX6wJohJWFRhkPKdIR8Ls37iCJrXF33aoAEjjic0wRxIg8Mwb3Es/LDX8NS8LM8TAa09ZmNgsxne48Ar1Lrwj96j+/+2i2eDqHKfs4UZZz4wRb8UchHrvaR6Ajn1cphM0QiqashCWB9u5HpS4a30TIWsBBrlKdNjYLuqLxTXf9Ikl5etDIBPdo5Vv5aQhrf4jYY131T11qDObnkR9CpCSIlFfdVc6kC0nwG6ECwXppcRkHfT4Rkt0TZVr0STQxarDgM8/PqqrCDJ1bZ8F7J2Rpr1Zp18bukLRtgx5OZAWEAWyYjFv4F4zUw==
Received: from BYAPR07CA0035.namprd07.prod.outlook.com (2603:10b6:a02:bc::48)
 by MW3PR12MB4396.namprd12.prod.outlook.com (2603:10b6:303:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Mon, 14 Jul
 2025 05:41:00 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::5d) by BYAPR07CA0035.outlook.office365.com
 (2603:10b6:a02:bc::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 05:41:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:41:00 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 22:40:51 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Jul 2025 22:40:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next 4/6] net/mlx5e: SHAMPO, Cleanup reservation size formula
Date: Mon, 14 Jul 2025 08:39:43 +0300
Message-ID: <1752471585-18053-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|MW3PR12MB4396:EE_
X-MS-Office365-Filtering-Correlation-Id: e7d70f25-50eb-4fa2-5857-08ddc29903b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rIP2m6QmrHUgzI3z+cF5I6idYwLqE6tpd7cD8RvmZH0KREo4wFQm/jYMItag?=
 =?us-ascii?Q?khP0cc7dI+NmrOCJWa4gqpvOLi6b+L0ByMHTFDzZFRRtq3OkigYQo1JlfEmA?=
 =?us-ascii?Q?u+0tsaI9lptB9VADKGir2O72GcWDxOUwq5x651M6ldIV3YO+ReHB3J2w8dnl?=
 =?us-ascii?Q?JwO8vwzLNeERa4WNfQL4YC75B+teWqvLsixvUWBD9wngXlcYfakVz/TT5+dC?=
 =?us-ascii?Q?ngOLtYiSNq93zTwqynqYD3ghBKO+MievzgXBidHXWBNNlUM/WmDaqujoJBfy?=
 =?us-ascii?Q?CNFW0+/X27p98JjbZUPeAq0+bKt0h6gwkDB/8zXrWHq/k2eP6o5OGP2NFof5?=
 =?us-ascii?Q?O5eMInbSyWEf6DmUsiGXNXGKEWOV3/eTHbPGhdjA/07XsawIemq35iRAb8ym?=
 =?us-ascii?Q?BfLz2y5jgTTPnmEA/aEWxgQI9qUaItMX0wUTFCAwOSLZvc/ViVqteARCpq7U?=
 =?us-ascii?Q?B6ck3fKco9gHekzjRHOABEni/Uq4gAZrSUJiTxQkvnz/9h+AH+AWJCS3hMiP?=
 =?us-ascii?Q?D6x/pWM6bPCzyGU2xxPmU8/sIVDlXq1BHGKZkTOxvLh0AzeEy6fKA2V3s0Kt?=
 =?us-ascii?Q?6SuE/cMJXdmpMzzDFJOlQq0n7ObFJIoA4s3h8XeEvN928uDpjdwcvyATJNvN?=
 =?us-ascii?Q?ZeC/6hhz6MOL0gtvpc+ausD04Aoe4zoCNoqy76Thqu400B7io/mdjbpC/JVW?=
 =?us-ascii?Q?mgUwkA9n5oxCZSTRl1yl4tuo4Nqo4vbyV3dyBT1VSNLqMsS4lOU7A4TucyIX?=
 =?us-ascii?Q?LBu33m9hk0iW2Bdu81UhzY+B45Oycn3hNO6oRjrTesbpXCJ5eoQhKSkJbPx0?=
 =?us-ascii?Q?3XU6DEQ2K1B6WCmICc2iAlwS5a35EkdYibZJ6cWKmgqOKrtc5Br2rLIACvAE?=
 =?us-ascii?Q?YQEpIshJNfHe2R11LEQDT7gi3MCmEn2jomN1Mbdcz9WWHjpUnc+LDCFmqYMv?=
 =?us-ascii?Q?XC98uidAAU7V9+tK2eCd6zJSU7svnQuNaTgvXIMTdfvqZxECyRhTTLm66v3V?=
 =?us-ascii?Q?iVA7wqVKIQng9tsfbR143I8slsFmUapbMyCN95MP8lTserCawcjWlCRwMa6J?=
 =?us-ascii?Q?njmjIA1I6t4StBr29iCDbY1AXpgr50jmSSI1taGB0WppYVGExpnddzyNFMLT?=
 =?us-ascii?Q?IYSVfDFBYcapJGh4He0aiB1j2rDC26c6NIL9yhaM/bY+CQdZ83/Zr84wG6HB?=
 =?us-ascii?Q?hiVSaZIcpten/lv8m+94QE1FcSJS2kmV61ZFoCzYh9cx9m57pSvTSqDqplgW?=
 =?us-ascii?Q?2TLc86NSmTaCKJNKBs9G0uMYNcqGw9lxuKDugOnuNpku4sBL5K0NeeWLDi68?=
 =?us-ascii?Q?oJ8yXXiHT1HzVTaTDUFFyVsWGAsEa0GWjBsu0pNajpMdqvbw66w+iRF8kPkG?=
 =?us-ascii?Q?knon7wYk866y/5GjM9v4JrIzjKgqQkRoKLJq63f0GcE7D2yDtnG4WKM4JEn1?=
 =?us-ascii?Q?5AD9n2Mups8p5f59PsorVcUFv/Tbc9eaNWzaKJmpOkjfL+LYTXhhDZAEibt/?=
 =?us-ascii?Q?KTtKL25cPAKy4Q1TZcm31baTecCsEDMFvDwa?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:41:00.4332
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7d70f25-50eb-4fa2-5857-08ddc29903b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4396

From: Lama Kayal <lkayal@nvidia.com>

The reservation size formula can be reduced to a simple evaluation of
MLX5E_SHAMPO_WQ_RESRV_SIZE. This leaves mlx5e_shampo_get_log_rsrv_size()
with one single use, which can be replaced with a macro for simplicity.

Also, function mlx5e_shampo_get_log_rsrv_size() is used only throughout
params.c, make it static.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  5 +--
 .../ethernet/mellanox/mlx5/core/en/params.c   | 34 +++++++------------
 .../ethernet/mellanox/mlx5/core/en/params.h   |  4 ---
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 64e69e616b1f..019bc6ca4455 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -85,8 +85,9 @@ struct page_pool;
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
-#define MLX5E_SHAMPO_WQ_RESRV_SIZE (64 * 1024)
-#define MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE (4096)
+#define MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT (12)
+#define MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE (16)
+#define MLX5E_SHAMPO_WQ_RESRV_SIZE BIT(MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE)
 
 #define MLX5_MPWRQ_MIN_LOG_STRIDE_SZ(mdev) \
 	(6 + MLX5_CAP_GEN(mdev, cache_line_128byte)) /* HW restriction */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index fc945bce933a..616251ec6d69 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -420,19 +420,10 @@ u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
 	return order_base_2(DIV_ROUND_UP(MLX5E_RX_MAX_HEAD, MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE));
 }
 
-u8 mlx5e_shampo_get_log_rsrv_size(struct mlx5_core_dev *mdev,
-				  struct mlx5e_params *params)
+static u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5e_params *params)
 {
-	return order_base_2(MLX5E_SHAMPO_WQ_RESRV_SIZE / MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE);
-}
-
-u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
-				     struct mlx5e_params *params)
-{
-	u32 resrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-			 MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
-
-	return order_base_2(DIV_ROUND_UP(resrv_size, params->sw_mtu));
+	return order_base_2(DIV_ROUND_UP(MLX5E_SHAMPO_WQ_RESRV_SIZE,
+					 params->sw_mtu));
 }
 
 u8 mlx5e_mpwqe_get_log_stride_size(struct mlx5_core_dev *mdev,
@@ -834,10 +825,9 @@ static u32 mlx5e_shampo_get_log_cq_size(struct mlx5_core_dev *mdev,
 					struct mlx5e_params *params,
 					struct mlx5e_xsk_param *xsk)
 {
-	int rsrv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
+	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, xsk));
-	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+	int pkt_per_rsrv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, xsk);
 	int wq_size = BIT(mlx5e_mpwqe_get_log_rq_size(mdev, params, xsk));
 	int wqe_size = BIT(log_stride_sz) * num_strides;
@@ -932,10 +922,11 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 
 		MLX5_SET(wq, wq, shampo_enable, true);
 		MLX5_SET(wq, wq, log_reservation_size,
-			 mlx5e_shampo_get_log_rsrv_size(mdev, params));
+			 MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE -
+			 MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT);
 		MLX5_SET(wq, wq,
 			 log_max_num_of_packets_per_reservation,
-			 mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+			 mlx5e_shampo_get_log_pkt_per_rsrv(params));
 		MLX5_SET(wq, wq, log_headers_entry_size,
 			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
 		lro_timeout =
@@ -1048,18 +1039,17 @@ u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param)
 {
-	int resv_size = BIT(mlx5e_shampo_get_log_rsrv_size(mdev, params)) *
-		MLX5E_SHAMPO_WQ_BASE_RESRV_SIZE;
+	int rsrv_size = MLX5E_SHAMPO_WQ_RESRV_SIZE;
 	u16 num_strides = BIT(mlx5e_mpwqe_get_log_num_strides(mdev, params, NULL));
-	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(mdev, params));
+	int pkt_per_resv = BIT(mlx5e_shampo_get_log_pkt_per_rsrv(params));
 	u8 log_stride_sz = mlx5e_mpwqe_get_log_stride_size(mdev, params, NULL);
 	int wqe_size = BIT(log_stride_sz) * num_strides;
 	u32 hd_per_wqe;
 
 	/* Assumption: hd_per_wqe % 8 == 0. */
-	hd_per_wqe = (wqe_size / resv_size) * pkt_per_resv;
+	hd_per_wqe = (wqe_size / rsrv_size) * pkt_per_resv;
 	mlx5_core_dbg(mdev, "%s hd_per_wqe = %d rsrv_size = %d wqe_size = %d pkt_per_resv = %d\n",
-		      __func__, hd_per_wqe, resv_size, wqe_size, pkt_per_resv);
+		      __func__, hd_per_wqe, rsrv_size, wqe_size, pkt_per_resv);
 	return hd_per_wqe;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index bd5877acc5b1..919895f64dcd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -97,10 +97,6 @@ u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 			       struct mlx5e_xsk_param *xsk);
 u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
 				      struct mlx5e_params *params);
-u8 mlx5e_shampo_get_log_rsrv_size(struct mlx5_core_dev *mdev,
-				  struct mlx5e_params *params);
-u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5_core_dev *mdev,
-				     struct mlx5e_params *params);
 u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param);
-- 
2.40.1


