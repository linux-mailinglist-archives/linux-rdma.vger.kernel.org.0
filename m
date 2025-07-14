Return-Path: <linux-rdma+bounces-12106-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAA7B0361F
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 07:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D72CF175189
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 05:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429A9224B07;
	Mon, 14 Jul 2025 05:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="q4GOs6HB"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2086.outbound.protection.outlook.com [40.107.212.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D25A2222AB;
	Mon, 14 Jul 2025 05:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752471669; cv=fail; b=MBGTS9ZMkixWUefUWC+Yzm3svBJqmn8zjks2xHoBv4nEB++mdodLbVkeIqtt6hXv/1zNk1gcQowfjd/5NH/H/ZShrNuo46n09KRGuAZi76go6W+m8oJxKJdCyg2JxNl8wsNXuZYYxgoeO86lD39R9cHXXwYoUPI39OAy3r3B/78=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752471669; c=relaxed/simple;
	bh=NYGTPJ1VpUvO4h0ehiQjwUO0L+EYotpBwnmDOb0Ah5k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F5N7RMGdjuD9FmOO5bhIAO3r1W3W5c68q8tXwSw/fs6nT0oGyE5/HfDRQOznQi/lqBFvHsJjoZrpnEoafL2iV/wRWG8/Ud5KAjULQcAr0EiFn2pYVp7Az/jqY2O1Ksk1mY5q2+gdnh4HOt1Lt2wqOlc/9Cv+xn7ASNN3XahkjIQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=q4GOs6HB; arc=fail smtp.client-ip=40.107.212.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JxXwU2gMCsR/30WNZ2zuHkqzW478KkZGvtt3e3tzIYLfKEGwBtwTAkJvWRdbZXMlycvQgcNo8IkznbIlD2Xg01utgKefrcTPjyuQ70Ca+V7qlwVc1jXzf6yb/yGWOUC2Y6R0Kgq6+sBs0U8lthkLxn36B5B17zneO4n4x9PQxGVGaxZyf70J4mDaHh7dNbntVD8OKgSCDHl+yS97nP0SezUqeIlbDaukCB8n3wo7lfaxMpcA4IvlKYkbKP93oKIZN2PVPH4rHv2+VD92kEt+kYR/aroKExjeGEdv3yK0d0aDpAqEaCvxHJYNUL1wWUGhVcu9jtFwZRFT3Ht1E44f0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MttrC1wskpx+lLGnslSAdc3AVFRFCR3iOfX3dUl6nsw=;
 b=etDzIlN/1Owt0UX9gzkKDnaYWpr7fDoP89yv0MY3/xsiAA731sPF6x+oUQrJWFdtaytTDP2YE2DH2h2hoDwz44HEhtMdb+X+8zWnaZRivkwPfrx1qOVEQ93yFuAaAKYZD2PIi56X96TtHFjN3avhqUFgDNeWD8V0HEBrmgreZtpOX+Ufj86pgVqad7uI+7UOsAC3xd+M0375L8oJS9dmRZ02mvnvm+opfGU1ormPIKhcuXm10EviomTgJ/iwnDIr2+fBr04ExvR+6y64HDrQOn2BfcY8i4t+FUAYsLDz4Qb3J6fKJA5/r+6Nin8dVR+h06qO28dfBMnAiOfTgj8CYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MttrC1wskpx+lLGnslSAdc3AVFRFCR3iOfX3dUl6nsw=;
 b=q4GOs6HBf4cb3nZsCBhcxG43Nmxm4nJ+TWrrGZ/Cyuo3rHJEUKi6iodJJsfrwjGMKS1xLxc1hNg4MytDzarN8t6pHgoXLQfGoCqmQsIbuNs8G1xRJfvTrvYthivP1otYnpNLZ/0iRX6C/iBoC8Tpy9Ol482fsXVJvH+8SBzZQ3sbqip8YBGHO/dZODNl4ClRnH8L4YctjmRI8qo7SpMv93DJAFjFxAHpT6/nj6MCszM1DG82Zj2UD3puNKv+49RB06LW5VzcOoKSnFtAfjtTwZuaonIUlSq7Z8fsCO6Rs4k+5Qz7Fw1lEPMx/0xNCCfgE0mOrkuWn0ZstZovnyvPRg==
Received: from BYAPR07CA0015.namprd07.prod.outlook.com (2603:10b6:a02:bc::28)
 by PH7PR12MB7988.namprd12.prod.outlook.com (2603:10b6:510:26a::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Mon, 14 Jul
 2025 05:41:03 +0000
Received: from SJ1PEPF00002311.namprd03.prod.outlook.com
 (2603:10b6:a02:bc:cafe::9e) by BYAPR07CA0015.outlook.office365.com
 (2603:10b6:a02:bc::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.32 via Frontend Transport; Mon,
 14 Jul 2025 05:41:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00002311.mail.protection.outlook.com (10.167.242.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Mon, 14 Jul 2025 05:41:02 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 13 Jul
 2025 22:40:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 13 Jul 2025 22:40:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Sun, 13 Jul 2025 22:40:51 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, "Tariq
 Toukan" <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Lama Kayal <lkayal@nvidia.com>
Subject: [PATCH net-next 5/6] net/mlx5e: SHAMPO, Remove mlx5e_shampo_get_log_hd_entry_size()
Date: Mon, 14 Jul 2025 08:39:44 +0300
Message-ID: <1752471585-18053-6-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002311:EE_|PH7PR12MB7988:EE_
X-MS-Office365-Filtering-Correlation-Id: 9312a408-c24d-4c3b-5241-08ddc2990536
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AAz7DrVvJ3hDJ6fbzcfTj4p76lW50nR6roo0vww6dZ32WXtMD19n4NPd5w1p?=
 =?us-ascii?Q?GM6I+6gLJfzQkCa/4qoTjqaKmSEFOZM4JNMDtVNEvC2f/unBpv3Q+EPz9g+i?=
 =?us-ascii?Q?N7z/lDZEd3Cmn4VhsOKcCbs2WkvmBU1/T3b1HkrF6wYzj5J5ctzPpHMZcWAF?=
 =?us-ascii?Q?zSoTruWK7XAJ8Dw5Kg0Y/xKGp68ojZFtpCrKOgds687kgw/DLKS8YQoR2iSw?=
 =?us-ascii?Q?d9TWG6gZBehYOHUTDVVukuWa839n2v7Ih5Ak32vJkAa/coO81lNmVq2jMOii?=
 =?us-ascii?Q?lAQpapZaamo+Wcx/lBzYiN6MtGZafPXo1TByeoBmXLIpnBC5zq0lEkzy2r5U?=
 =?us-ascii?Q?W7u1Bj+14XKiIJv1VHrlGxKkaDHNtBbywDh3CcJbVL6xDDSOMYkGgdLSiBvG?=
 =?us-ascii?Q?7fLYljaGNLowN4NLdVS/hlNu5DEMNFxInptey+8yVRhwpx/aX4OpcB4lu9O1?=
 =?us-ascii?Q?7baRAGUTLpAytvlwdE1Wo3eZmmcEGSlEwmOLtUvNVkcu4ObdAfUIRhDfZaGu?=
 =?us-ascii?Q?yPqOTYtxr8fup8YzMOE48MCOU2NUyOrfYvafBYa7yxH7lYAxY8F63LRt67Lt?=
 =?us-ascii?Q?A+FjJ6lD1kzAVTpVjnljW49cdDFTlksbCh2ZuETR/WyOzYMFgacLkVhOIUkG?=
 =?us-ascii?Q?gIiJO2xl1GiVKkdViaPzPhsZ1YgOKWnO/0eGNXaFcVDHSbDPEapn2oV+h3uc?=
 =?us-ascii?Q?lqhO0IS6WAdS0De76NzeB1lDpNsz2f61pV8BkG/ZCukuPqTla5n84j2MqFL1?=
 =?us-ascii?Q?O9ta7tYCPyZuTOqWP48u1LaMIQzUnnM7K6WGNrQo8xgW40u5jvWWbRhAQBiz?=
 =?us-ascii?Q?/7OIyg3mInkqL4DIp47TDYSywqr+o76oxCP0p9z4qzKLYHZsFFMRUR3rmJDR?=
 =?us-ascii?Q?/X+SgLSj15WNfL2jDhE/uN0fciHNPILp4KYBZNkGOf834JQFoR/9NM1EUv76?=
 =?us-ascii?Q?geKhznHiJ8hYQeNS1fhxQv1MM+m99K/SbzK0rXKsGGoihahtS9m7qmra/q3y?=
 =?us-ascii?Q?jBdw8P8LfkpbRTEA4obAk6TX4axeloQi8JyFkq6tyfYlqwlVJ7n/wDRwk6ov?=
 =?us-ascii?Q?AWsJs+7ET7An+OTotodCV9dNDjmv01esi/w3kZpd6DOiSKIeeaAzGruFbZyD?=
 =?us-ascii?Q?MKeAwTtXXYoSMLMpPQgu/o6g1pbMk/XXKf92a7TYsook05D2rJ6ZECGEG7oP?=
 =?us-ascii?Q?9UgNT0T4kMtjuWJJEvIvioaNs+ZEhy4N1aWVqgYVOl0y0LJypT72Eshd4O+/?=
 =?us-ascii?Q?q2dfBUTziV9vSLbNsVVyCs8a7KYDSWmnYoK4tYoVtcC03VhhvqieqoMb+ePf?=
 =?us-ascii?Q?UqyFJIvpLn0LFHTLA/WPE7nJyI05eO778dTNvrNJGNdml13+VHIxFjzku0pz?=
 =?us-ascii?Q?FQ4ZkhJNf7dqNlDGKPRBwMPOjUJsHNtmUrQkC1iOtPdRp1ZXC6OA9imik7xI?=
 =?us-ascii?Q?S7OVq6FBr0dX6Qa1Cz3xVyCexYDImI0pT+W4Fc8NiqDAs3/d6aOsv4JnBZf0?=
 =?us-ascii?Q?Udnhb+uxOvKvuCs7vq5Q3tUEhSh2EZ6tYETV?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2025 05:41:02.9021
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9312a408-c24d-4c3b-5241-08ddc2990536
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002311.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7988

From: Lama Kayal <lkayal@nvidia.com>

Refactor mlx5e_shampo_get_log_hd_entry_size() as macro, for more
simplicity.

Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
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
index 616251ec6d69..de5c97ea4dd8 100644
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
2.40.1


