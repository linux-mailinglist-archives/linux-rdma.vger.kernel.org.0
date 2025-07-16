Return-Path: <linux-rdma+bounces-12219-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBDB077D7
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 16:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E11E5855DE
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Jul 2025 14:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D5D2641F9;
	Wed, 16 Jul 2025 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q8QC1l9d"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E81425A353;
	Wed, 16 Jul 2025 14:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675535; cv=fail; b=TLuYXKW8tyV5vM5u7Xt6kqZ1GrI6e8PSVG7xmSoWmvXpdY/Ti7uz+GhhOSBJhT27X0S3ozkkF1TyRYnTNzQz8g04ZOnDmKymdT3Aky9fmD9ef1Auh8+V/8PXP8GY7Yu2b+fRyHNI2l9M6f0A2puMA9fFCQ2M0FzR/pqK0IZOvpY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675535; c=relaxed/simple;
	bh=e1HYoSJ20+vVwsve2ay0AXJ7L6dsHTNrBD5bvRX7wm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HkjaFNBEwouUh0lw2PMUamzWV7nxQ+cpdVPhqu4ZaqAL9dGSPzdO344UQIWQHOqBdpekN4yT80GfHcd3LpMfI6UnZHxGT1Cz/AJjLFH+gFIYivMxrceuIRNRxJeoEGokzgkULPC4xdDdladRnTMSXFOyWeehSs5TicriOfXT0hY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q8QC1l9d; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=De0Sy9XsFQ8N4DIKN/kK8u/v0xsXG8Hs/x/WFsyNxIuhYis35zW77trdiKQr572axSrGp2V8iaWSr9tvU5LkhPpoh06ZiUOxIO3JKE+TlseaT9pbVn5hddx62G7sAtInQNz4+wRLJuqZVonyQCr5S4UibqRei/mBaXcE/LXm6d4QAtkWnhE4WHPekpEG6gethEr2UvzflSqjBCRusNAVXSONhT8r52My+7crSUkdnOWSeuFyEqbZqXtk469NyZpkI+0jkQNnrEP/D7GH3xt5JmRqV+zn24iXpPRJW2vvScfh2xWPXZinZW1vTn4JubT9zieDDvp6Am725B6bFbgRhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=11UnKHCAB7arXa/LypjcGAwS6t5111thVnyknBsBqbY=;
 b=zR2Gz3zmF/5Lp78m8iEZ6hybmwHcdmLKrVKlWinoCs21i++T//QS3Hx/c03DJNkYHaivEY3eSiSoUBEw1D/gkkxwfQhHjQnRJgf3Lb5zqkVWKkR6OIbS/e5WUISqBw+w320dLWiw0jyRjKiaC/pCBO7WjrvNSQxAFKByKPt+6xsAln4ZMY6C0vPnnfK7gAOnra9MT64wMuqZAdcUUZE+I4Su4eBu5EKVwU8XVgxmss3fxqEXH9TsMJmYKuDmrzxYXb7Xx6Cwi7L7OMw648iR6CUq/1ipBBy+X4iOvVkompMf+YY6hD7o5l2fZUC8KTLh32T2ScwmuF0n7+BIdN1Hvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=11UnKHCAB7arXa/LypjcGAwS6t5111thVnyknBsBqbY=;
 b=Q8QC1l9dYxIOyOQwCn22/jVsFJgWLYxKbkUACIFvAdycBZUSXaH2x+0G03c0Jfhf/tjA+ii086i0BLd5sm9o0ug5x3wGLwlbkgmkpfUlU6apwU5dYw8zcLJRF9M1ED41rZcbXVJt4DLhefHMuDPFy0J7BENevAbYKUxhr53RlZo/NyrNQHcpeAc+nRv2GS0eqzlyYZilWJWMYRV8zPAJ0t/97J46h5MpaQdBm/Rno91Y8TOupgqdOa+9TUgTzAg7coSnG+xCgw61w5ICG3K+SSL+2UPtqHwRE+HVufxRDJGZ43P1ILUS+Pr3Jq9K4lqMwQxpC6nNb3sgvqq+qq6n2Q==
Received: from MN2PR07CA0029.namprd07.prod.outlook.com (2603:10b6:208:1a0::39)
 by IA1PR12MB6140.namprd12.prod.outlook.com (2603:10b6:208:3e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.36; Wed, 16 Jul
 2025 14:18:49 +0000
Received: from BL6PEPF00022575.namprd02.prod.outlook.com
 (2603:10b6:208:1a0:cafe::21) by MN2PR07CA0029.outlook.office365.com
 (2603:10b6:208:1a0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.20 via Frontend Transport; Wed,
 16 Jul 2025 14:18:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BL6PEPF00022575.mail.protection.outlook.com (10.167.249.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 14:18:49 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 07:18:39 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 16 Jul 2025 07:18:39 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 16 Jul 2025 07:18:35 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next V2 5/6] net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
Date: Wed, 16 Jul 2025 17:17:51 +0300
Message-ID: <1752675472-201445-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022575:EE_|IA1PR12MB6140:EE_
X-MS-Office365-Filtering-Correlation-Id: ad0fc460-075d-4a15-eccb-08ddc473af21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eOHpgF3ZOeaKA6Lue5KLG9lhFj1Ax1erYLO1cx6d0oXEvu8GwfxZkIQHDTdy?=
 =?us-ascii?Q?b4SwFvQefFq71SXQceDKBv28eQmeYA5DXAoZiZGuLYYva2GvH/TB2Ixc4h70?=
 =?us-ascii?Q?UjOvW2hJfohKR6eJY2K7Bkqf5Ip+MUG+rongBe315gNVTvgZ9CmfPpmYpc02?=
 =?us-ascii?Q?Iptnhp7SXNUgw9AUeDxgtVktyclIYzlP85hiVHm8Rolk05P/oQB5OgMNzpDZ?=
 =?us-ascii?Q?daezCg541gxMNJ8cf/uWCqLVwuaJSRHpu+FBagJcbemrCShps13RvI9Dxgv3?=
 =?us-ascii?Q?qXJCRCFV6VCYwA2jMuOAHiK0pS1hGqXvZaQfEmgJqmwSFrwCIgTKsNcXp4lZ?=
 =?us-ascii?Q?QfBXbA0Pp4Y42bUCl9QVzThP1FG7NkOdVYqEMUfI70pG6yteo0LER/Yf0aLD?=
 =?us-ascii?Q?fWB9wOKGgkJELNPUnfu4q220QXZLD+Pt8aOGgoqGzBbxnKdaCMkQv+cxnTDI?=
 =?us-ascii?Q?FQzaY0ovZXu1A1sQIok8fKWN29dNp1TrAkoHcwEgqN/0bCvN+NB9QE6EQUtq?=
 =?us-ascii?Q?TI7nlbmKhK7RjM3SzjsoM9Gzhy/87qXoqpjtDZ9Np3aQ5Di0eE1E4oPKf52G?=
 =?us-ascii?Q?5bPDbCIoeupgzz8QgRL+dT7Fpv/nz2++mzfxob/a2xw6ylwKuGopbA4R/TGI?=
 =?us-ascii?Q?AFDA4uNibJNtGuSi2BoSRMtXNF1oiFmPIlUXZVheK6zVQgnT40X4sMQWWut5?=
 =?us-ascii?Q?msvt/ee/KFzC9Go+k1lIrdiSrVBEWjsd8fZYiu7H6ltqdYyQVlYps9SOncCB?=
 =?us-ascii?Q?KejK3xbSnHLrrTMUg+wgzHyVwoMzofJ8hANsl1vWKz56u1Sxk021h+6Zthr7?=
 =?us-ascii?Q?GDdNR7kVan8HXmmEbxMTTwcca7rbpSjgGrqJE/iQIZQuV4rKTEqN6kbYWD7z?=
 =?us-ascii?Q?rFpaJroqK516khv3gpEwPA+WySwdbARNX8w0YMw12nkrk0Qi1tRGTQNx52Q4?=
 =?us-ascii?Q?4xYJJXnjFS33U3HISwAivRiaXWWZdKrYWkMqOnuaFa3HTJ3hjMfBleSmPIRo?=
 =?us-ascii?Q?YgRg2VmPquGnfC/2wfMbJXgAhrFkWBtmc+EQ47L8OxB2i78a1ws08q1rrgcH?=
 =?us-ascii?Q?bthuHM1M/7JfbC3zHBcMj2PsQHL+vMU1DJgc80h9lhoZe6gghQuqCkpIb1DD?=
 =?us-ascii?Q?YBKOTvmqyoHPNxX3QjKJaypQCYEEzdGDDpqRkzPPecF9jzfl3zRXyTqwT4Wy?=
 =?us-ascii?Q?kyBZZLpfkSyaAzJEDIoqJz9yyCj/cDNkxNNAisBqN877V7m3Wtp4zycv9PyY?=
 =?us-ascii?Q?CjrMPBtgvRWBNco9P/j1IzxJ2vvO46htHXcaUKOHqpRpuot6oaVfg/Wd+V12?=
 =?us-ascii?Q?ujIgR1GgkETFs4EAg1uFTXc4GdjVq6jK7aKyVfuCRmkWx+8BZjYcGMjaVf5y?=
 =?us-ascii?Q?4V2kegzxqod6QAg/8kB03MdNJyDXv9sTISh2Cga7uUkAYTW+bZI52IcpJL5N?=
 =?us-ascii?Q?BM8kARXGp3dXPm3vKHfbU7q965dS6iYPcdhyXMG2Iwd1wzrja4tMrA+HP7xF?=
 =?us-ascii?Q?IawxDjMwpw7RONxnfkrhjjFd5DOnYSuQxSeH?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 14:18:49.3714
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad0fc460-075d-4a15-eccb-08ddc473af21
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022575.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6140

From: Lama Kayal <lkayal@nvidia.com>

Refactor mlx5e_shampo_get_log_hd_entry_size() as macro, for more
simplicity.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/params.c | 9 ++-------
 drivers/net/ethernet/mellanox/mlx5/core/en/params.h | 2 --
 3 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 019bc6ca4455..22098c852570 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -84,7 +84,7 @@ struct page_pool;
 #define MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE (9)
 #define MLX5E_SHAMPO_WQ_HEADER_PER_PAGE (PAGE_SIZE >> MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
 #define MLX5E_SHAMPO_LOG_WQ_HEADER_PER_PAGE (PAGE_SHIFT - MLX5E_SHAMPO_LOG_MAX_HEADER_ENTRY_SIZE)
-#define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE (64)
+#define MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT (6)
 #define MLX5E_SHAMPO_WQ_RESRV_SIZE_BASE_SHIFT (12)
 #define MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE (16)
 #define MLX5E_SHAMPO_WQ_RESRV_SIZE BIT(MLX5E_SHAMPO_WQ_LOG_RESRV_SIZE)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
index b98973fe2f03..300acea7f3ca 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.c
@@ -414,12 +414,6 @@ u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 	return params->log_rq_mtu_frames - log_pkts_per_wqe;
 }
 
-u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
-				      struct mlx5e_params *params)
-{
-	return order_base_2(DIV_ROUND_UP(MLX5E_RX_MAX_HEAD, MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE));
-}
-
 static u8 mlx5e_shampo_get_log_pkt_per_rsrv(struct mlx5e_params *params)
 {
 	return order_base_2(DIV_ROUND_UP(MLX5E_SHAMPO_WQ_RESRV_SIZE,
@@ -928,7 +922,8 @@ int mlx5e_build_rq_param(struct mlx5_core_dev *mdev,
 			 log_max_num_of_packets_per_reservation,
 			 mlx5e_shampo_get_log_pkt_per_rsrv(params));
 		MLX5_SET(wq, wq, log_headers_entry_size,
-			 mlx5e_shampo_get_log_hd_entry_size(mdev, params));
+			 MLX5E_SHAMPO_LOG_HEADER_ENTRY_SIZE -
+			 MLX5E_SHAMPO_WQ_BASE_HEAD_ENTRY_SIZE_SHIFT);
 		lro_timeout =
 			mlx5e_choose_lro_timeout(mdev,
 						 MLX5E_DEFAULT_SHAMPO_TIMEOUT);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
index 919895f64dcd..488ccdbc1e2c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/params.h
@@ -95,8 +95,6 @@ bool mlx5e_rx_mpwqe_is_linear_skb(struct mlx5_core_dev *mdev,
 u8 mlx5e_mpwqe_get_log_rq_size(struct mlx5_core_dev *mdev,
 			       struct mlx5e_params *params,
 			       struct mlx5e_xsk_param *xsk);
-u8 mlx5e_shampo_get_log_hd_entry_size(struct mlx5_core_dev *mdev,
-				      struct mlx5e_params *params);
 u32 mlx5e_shampo_hd_per_wqe(struct mlx5_core_dev *mdev,
 			    struct mlx5e_params *params,
 			    struct mlx5e_rq_param *rq_param);
-- 
2.31.1


