Return-Path: <linux-rdma+bounces-6247-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E208F9E479C
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:13:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C79AA18813A3
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891871F542C;
	Wed,  4 Dec 2024 22:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="A1T0AUCb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2077.outbound.protection.outlook.com [40.107.236.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71111F5416;
	Wed,  4 Dec 2024 22:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350307; cv=fail; b=OkoNRm6NrnpVa9xZQWb18+fh5Zf+5sSOTDqia4LvYIDnZFbKX415H29UzS+GcjCXjKkwM0W1d2ZQugHWiOW2ufw34BOtIqQb3n1S/GfOtGY6sT2kb/UVkxQ/Thitfjnc4h/QHDVLEiOGtYtsnGjKQC/3TAP+cY81YFDKVKy2Rkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350307; c=relaxed/simple;
	bh=ZMXttAAi+cPxkYzuVI9ssjM5Os1UDm7P2NfN9uPdj7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6WbDrPPOE1/Y18mx2qy75+IqU9fe3yV44qZFis/MQwJMvNA1ah++xJ9hHGGm9eLu1SiNOcJ7viO/Mf7muVff0Q/kNvigLSPIEHOtSK+sCF0tjA/+zZUkPQxGWJo9feh5T8Dbt36d55hmyQaniAAaKpcx2y8deutGiAMLCBiKV8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=A1T0AUCb; arc=fail smtp.client-ip=40.107.236.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pS/uJR7AkK+GJ+6hFWfvWd0Pjjph6Iamg0c2ZcQQFxYw6NNdyJRPL5f1uc3CYL4tFWuawnLr2rUyXfWZa+jtJEHMJ4KmZBHOdNy2Y4sNYmRyXo2ImNcGO/VobsS1qQzReb43g7d7uztfuc4+TUUwz1UVIfKFb7cdgg5KLJhMzog7HqHuAZ30CglxOoufXAQ1aVnI/6xc2Vxi/kjhD/46CsAcagd0IP+i80KFdOqhBr8gb8zuNpOHIdCopjNmpwhwioSxI4fkI+mIolavwo2dS17k2ljWTc3C6n6GhkVhLDF2cpwEmyryFFpiYlXEhO6dfIQP4mjcweaehOj4ygK6sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX6tDMjM26CGsXxvelMV8aWSCGNI2ocmDy42LHZrLqo=;
 b=VeizHbl8M+BLvRGB0n2t1LrJ/HtOtLBtPUnfW54vCjzqLHl1SobLzycGoicaFb9VDIfvgK5ygC/BdGzcVHK0PYCqX3nXVx8bDaaigwzhdrJwXtLelLxeanmexsBs3RrdNNygTDfne2Q4caMS5LoV+FDd3I4/FGg+roT/kwl43B8SP7aIOAoPcILj7byiTDD6OSyVQ+AiLMBTDeNjFQrOwqJ4hUWJErrSt5AizcHnvVjHy+/Cfg+8IoVsgtCcdfgfNhpgsdKctaGUderovHbIe8511y+Qtpf9ULOREx0QyyUDxDzB9eFj/e0amfFosIz9PFjtsOyXksqU6OElD9Ksyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX6tDMjM26CGsXxvelMV8aWSCGNI2ocmDy42LHZrLqo=;
 b=A1T0AUCbSDUPYIJHjgNR76CCVTR0dZdHpLoWnxtyF8T7ij1U2L7u0ekOEezE35Qh2WBM+yWLnGFPrByFcAX/2yhWDsu1nfyj6KreMRzhjYHr1pX40mJS7wsnQOmSjIlxcS8DsadqpYHbCGTCzr2eQrHGjPFrySABun5du1mQvI+55+7NukpeBlhO6o3W5N1xS/B8kQF5CZqxyMx2Ku9wbVN1uZydqKsr3xu8oTWBJnjO65n4l6VIqxA9wPvEvHVRXc60r5CCnXTZ7KaBzxseUeWy3uCmzWjYfh5Hyji4bV93HPFK6TSwukLOO7vig3i+YM2VBBJTeVOqtdKdBU/N1Q==
Received: from BN7PR06CA0057.namprd06.prod.outlook.com (2603:10b6:408:34::34)
 by DM6PR12MB4044.namprd12.prod.outlook.com (2603:10b6:5:21d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 22:11:41 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::69) by BN7PR06CA0057.outlook.office365.com
 (2603:10b6:408:34::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.19 via Frontend Transport; Wed,
 4 Dec 2024 22:11:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:40 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:17 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:17 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:14 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH mlx5-next V5 03/11] net/mlx5: Add support for new scheduling elements
Date: Thu, 5 Dec 2024 00:09:23 +0200
Message-ID: <20241204220931.254964-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|DM6PR12MB4044:EE_
X-MS-Office365-Filtering-Correlation-Id: 02a61bba-15c2-4f7c-be63-08dd14b0a0ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qhw/96JCNVof6QSo47UNE0je1Zodh6iVDzs+odYTpfvN7Pjmun0KPb2YuVkU?=
 =?us-ascii?Q?eimCZpiwI0CzaCqQ4Wc2i3Db5y+wQ2nqXs/eKgY7YqrGOzKNORbkUaxvdDY6?=
 =?us-ascii?Q?j2hMVtxnpveac31UhPaOSMebwBTfzwrvSt3K4pRAt4vzDEkkYBRvtKWPdRQr?=
 =?us-ascii?Q?LFp7nXSumHnarCVxakej2DjBHyXT/6JZvXsfQVAoTxxTakpbKXyrJk45we8f?=
 =?us-ascii?Q?o6XYJ9fArq+rJNyTHulCOPLjHhFcPeg1Cl1zuzKUqRZ/jjyMTLyJOL84xFH1?=
 =?us-ascii?Q?g6iOOece4vrbZ+76tvOnHWpaQvRhFsPCsJqdYNnJHiz9NtmimkoJ+vomLJCd?=
 =?us-ascii?Q?jYOWzXSWivmslfZ+J3kWsk4I4iKdgdcd32EXSoATsWPG2nr8akERcxoDMuYU?=
 =?us-ascii?Q?gUbvDjJqnvXIIIrGpiSqPwychTLCxG30G/U5eU9OSF0gOl3jnI2vev7Virkl?=
 =?us-ascii?Q?4csNQMzXH7mEo0m9k/eSPdcR7ctN29hM080di9q70n6QAT1fOXhDhRDMw9lS?=
 =?us-ascii?Q?heNb1HDd/zjMC3ryYvnz+HsGCYY53DtNABXhoI05ZDoAmjCyfWNQNXn3I+1J?=
 =?us-ascii?Q?o3aTF4uJ4ttiGUHNJ2SjMc3OJfBFEKfRDaT8E5xalr7XA4DSUtJKPQIDWGrc?=
 =?us-ascii?Q?qckXYuz8FdU07FlNiAQ42wAX/Uj3HnHaiEuO2bzGWlmWSSy7aodqmoJ0ST7y?=
 =?us-ascii?Q?3YVFDmtZNDQsbfQs1wGPwRKMiVlDpEW3N9m88XwXPkj62lvqGzf2zwzjxqu/?=
 =?us-ascii?Q?18QZXi5F7+AMzrTyB86gCRmXyHwEkOnOQ+5xdsWy1Mapc+Rrt/4BgFx7N/ZS?=
 =?us-ascii?Q?UtvlHodgQVt/DVjYtR6JuqMGo89FXIGsaDnLJ4brh8hNPO6z0zmiThWxBzA1?=
 =?us-ascii?Q?CfhuVh9yb8SNz2iypjXp3e/0idm77Vw1eIl09TNy6+KlvH36yvgLpQdWsb+Z?=
 =?us-ascii?Q?85su2Xp07EYJpJADrUaVyM2dyAcjvFefED3XerBhp0H0LnMjzjzthiHan8EL?=
 =?us-ascii?Q?GcEwpJwOm7PgEcQZc76ZcRlHxdv51w8Wd2sxfIY7vAi/IDRs2/gkU4+PACr+?=
 =?us-ascii?Q?JPhS7otDxgFhYbGTPpSkeOrugGcs71YUYU+zLdD0RGkvUGtF8gNGQOnd35ko?=
 =?us-ascii?Q?5UlVFBYmXWV6hRSMqC/P+3zzxPHyKjHsZVZBRHkEE0Z979AQHsXC8HvXKsm7?=
 =?us-ascii?Q?yUqw67ao5MeJgXO4Ijli1p/5yshjuPwKeFFtrQ3fZKa2hH2L0aevy4yLy5SI?=
 =?us-ascii?Q?f94hUdTXri70WNpbj7GSM0NH6fFlfg1/bghj2hSaXZvx8QEPua0exU/ZEf3V?=
 =?us-ascii?Q?gNvhx70wvu4MIhAyMMRMaLnXYr4D9d2nmfGK6h82Q56nS8m2pRadhukDoM3c?=
 =?us-ascii?Q?O7mg+MJO38v8FxGMZMDLowDVesaass1zx8gRY8coPPGDxVIqwVhBVTboPipu?=
 =?us-ascii?Q?V9IdsWe5GD0BOpyTEU1FpetpB9pVfUZI?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:40.0844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02a61bba-15c2-4f7c-be63-08dd14b0a0ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4044

From: Carolina Jubran <cjubran@nvidia.com>

Introduce new scheduling elements in the E-Switch QoS hierarchy to
enhance traffic management capabilities. This patch adds support for:

- Rate Limit scheduling elements: Enables bandwidth limitation across
  multiple nodes without a shared ancestor, providing a mechanism for
  more granular control of bandwidth allocation.

- Traffic Class Transmit Scheduling Arbiter (TSAR): Introduces the
  infrastructure for creating Traffic Class TSARs, allowing
  hierarchical arbitration based on traffic classes.

- Traffic Class Arbiter TSAR: Adds support for a TSAR capable of
  managing arbitration between multiple traffic classes, enabling
  improved bandwidth prioritization and traffic management.

No functional changes are introduced in this patch.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/rl.c |  4 ++++
 include/linux/mlx5/mlx5_ifc.h                | 14 +++++++++++---
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/rl.c b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
index e393391966e0..39a209b9b684 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/rl.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/rl.c
@@ -56,6 +56,8 @@ bool mlx5_qos_tsar_type_supported(struct mlx5_core_dev *dev, int type, u8 hierar
 		return cap & TSAR_TYPE_CAP_MASK_ROUND_ROBIN;
 	case TSAR_ELEMENT_TSAR_TYPE_ETS:
 		return cap & TSAR_TYPE_CAP_MASK_ETS;
+	case TSAR_ELEMENT_TSAR_TYPE_TC_ARB:
+		return cap & TSAR_TYPE_CAP_MASK_TC_ARB;
 	}
 
 	return false;
@@ -87,6 +89,8 @@ bool mlx5_qos_element_type_supported(struct mlx5_core_dev *dev, int type, u8 hie
 		return cap & ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC;
 	case SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP:
 		return cap & ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP;
+	case SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT:
+		return cap & ELEMENT_TYPE_CAP_MASK_RATE_LIMIT;
 	}
 
 	return false;
diff --git a/include/linux/mlx5/mlx5_ifc.h b/include/linux/mlx5/mlx5_ifc.h
index bd9b1833408e..8b202521b774 100644
--- a/include/linux/mlx5/mlx5_ifc.h
+++ b/include/linux/mlx5/mlx5_ifc.h
@@ -1103,7 +1103,8 @@ struct mlx5_ifc_qos_cap_bits {
 
 	u8         packet_pacing_min_rate[0x20];
 
-	u8         reserved_at_80[0x10];
+	u8         reserved_at_80[0xb];
+	u8         log_esw_max_rate_limit[0x5];
 	u8         packet_pacing_rate_table_size[0x10];
 
 	u8         esw_element_type[0x10];
@@ -4104,6 +4105,7 @@ enum {
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_VPORT_TC = 0x2,
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_PARA_VPORT_TC = 0x3,
 	SCHEDULING_CONTEXT_ELEMENT_TYPE_QUEUE_GROUP = 0x4,
+	SCHEDULING_CONTEXT_ELEMENT_TYPE_RATE_LIMIT = 0x5,
 };
 
 enum {
@@ -4112,22 +4114,26 @@ enum {
 	ELEMENT_TYPE_CAP_MASK_VPORT_TC		= 1 << 2,
 	ELEMENT_TYPE_CAP_MASK_PARA_VPORT_TC	= 1 << 3,
 	ELEMENT_TYPE_CAP_MASK_QUEUE_GROUP	= 1 << 4,
+	ELEMENT_TYPE_CAP_MASK_RATE_LIMIT	= 1 << 5,
 };
 
 enum {
 	TSAR_ELEMENT_TSAR_TYPE_DWRR = 0x0,
 	TSAR_ELEMENT_TSAR_TYPE_ROUND_ROBIN = 0x1,
 	TSAR_ELEMENT_TSAR_TYPE_ETS = 0x2,
+	TSAR_ELEMENT_TSAR_TYPE_TC_ARB = 0x3,
 };
 
 enum {
 	TSAR_TYPE_CAP_MASK_DWRR		= 1 << 0,
 	TSAR_TYPE_CAP_MASK_ROUND_ROBIN	= 1 << 1,
 	TSAR_TYPE_CAP_MASK_ETS		= 1 << 2,
+	TSAR_TYPE_CAP_MASK_TC_ARB       = 1 << 3,
 };
 
 struct mlx5_ifc_tsar_element_bits {
-	u8         reserved_at_0[0x8];
+	u8         traffic_class[0x4];
+	u8         reserved_at_4[0x4];
 	u8         tsar_type[0x8];
 	u8         reserved_at_10[0x10];
 };
@@ -4164,7 +4170,9 @@ struct mlx5_ifc_scheduling_context_bits {
 
 	u8         max_average_bw[0x20];
 
-	u8         reserved_at_e0[0x120];
+	u8         max_bw_obj_id[0x20];
+
+	u8         reserved_at_100[0x100];
 };
 
 struct mlx5_ifc_rqtc_bits {
-- 
2.44.0


