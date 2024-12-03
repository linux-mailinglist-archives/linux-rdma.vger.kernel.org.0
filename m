Return-Path: <linux-rdma+bounces-6210-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D77939E2D1D
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 21:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925B328353B
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF4205AA0;
	Tue,  3 Dec 2024 20:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="XHSyEEjN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9B1B21AA;
	Tue,  3 Dec 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257837; cv=fail; b=iBx4O2i7qd/AOCfPBx6iWtMxGKcbxngXaPO9U03qwEaH+PCpvH/1X6EyKji6UiC2/6lUEuHiTg7GeB2tdWwDUVIfgfx4OgieZEo17sKvdVVY9kxMoY06KJ8wQx1qF8CzeFZLyT7QkQB8jl1fElNrpo0J3Xu540Z/apVnkoLeOT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257837; c=relaxed/simple;
	bh=ZMXttAAi+cPxkYzuVI9ssjM5Os1UDm7P2NfN9uPdj7Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UUwcx4Yh6Jl2Soaw7TKaiY4DM29pcg6hm/QXr2HhW4tVmghqQV6laaMD9gJVl7ZykvEwTHPwDQ9Y0GTOvg1P8yj932OnRh+HMPNpfyCHlGwa28BVY8I+nxlJL+TI0M3vsFoq6NS8av8bjRS32GBJfyhxBg/zl8OWQhJriA4d9Wc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=XHSyEEjN; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=adD03zrVDSAFEb/M73ogR5yKwH76weFjuSMOOo3YLriPEJ1nJCWkVn4qkHK7d36aCLpP+ahDlIyyzykuOhNOm8WbzS8ehsfwcdKVoVS7DmvfGKURB58anj0OhjQ1cqppiQcAoZYMqlRrBIFPmabI6va8twZgqqMIDmszInzuoNdZP3Qq5jWQ8roCKRY7swwF8gWc0stcfrDY6fmBDLCGQCUKQ9dNJrcIogxi9lY7+FRyamv9oszmvemfhcmUrn9bK87nmInbYXyME9bJXFN6h22MNrNG9brRdREg8NCFe/fdZh4m7UDXBkQIJWzxpUm3ev4LZ2g+3TN0MHl8d8LUEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fX6tDMjM26CGsXxvelMV8aWSCGNI2ocmDy42LHZrLqo=;
 b=xh4x/uI8hBUXMaH+VDQX/UvE+17EWIr7T4946F7ZAn5Y78URAVu7hF50cAF6N4bSOljcVt0/hF8fy5n8CttrtWToyeCESAa0L/udK/HMX1+KLKntmft5PPr6GrIy5AjKSIss4VTur8Mn1HMggv19Qkg0Gny3ov/KDWYEuh9U+mYKszqXJLkBLozjQ0PEiH4ZTfQlnwJLenZyOac31iZfNt++hJ7nFLjip3dzYlEiT9zruRfVgM0sc14eIpo1TNqXkjlEAYq+EyrohY8J3BL3ppf5QrREsxAgPQQAhIomoTdXmm2q6d4WLIP2DxIduN1R90EXOs0Eq2yEinTEhE8qBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fX6tDMjM26CGsXxvelMV8aWSCGNI2ocmDy42LHZrLqo=;
 b=XHSyEEjNVHUh8PwZAemSip5bL/rKZ1W8NAq6W1EhG6RyKgplkJ3yK2d6aQe1mYG2QOtal/2CAK0Cjlw/4rND/tsmew/PTbhP+mWy0jubb3M1GE/Xn+rWOOCGkJlVSITlMkymmnHiGDyB4PdIL+nbdEX63CIF12s82OggdrwbHDNWt1s111RqS1AzAg6FyATLtDUzN+GSM5nzYmm4UqudlCLKpQJSXdQUWOQXtZSUpxlDZIJw8XEWMAJ5Em+zlRx1rJwoVwhdl5fRiDmm4Gm2wYa9RXYqBUgKp7QFYXGbBpgJ0bxWHIFICVA5sU+0txnOljnOZ66DuSMcVWfBNF7PLQ==
Received: from MN2PR15CA0048.namprd15.prod.outlook.com (2603:10b6:208:237::17)
 by CH2PR12MB9494.namprd12.prod.outlook.com (2603:10b6:610:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Tue, 3 Dec
 2024 20:30:31 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:208:237:cafe::8b) by MN2PR15CA0048.outlook.office365.com
 (2603:10b6:208:237::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.18 via Frontend Transport; Tue,
 3 Dec 2024 20:30:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:30:30 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:30:09 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:30:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:30:05 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH mlx5-next V4 03/11] net/mlx5: Add support for new scheduling elements
Date: Tue, 3 Dec 2024 22:29:16 +0200
Message-ID: <20241203202924.228440-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
References: <20241203202924.228440-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|CH2PR12MB9494:EE_
X-MS-Office365-Filtering-Correlation-Id: 0db7c381-6019-4d07-6ba2-08dd13d954f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?suQnd/oT4WcpAu8A6xGshohr9NLe5pXzc0GkWkFqRy/m65l6pjaIVot7VotH?=
 =?us-ascii?Q?fWKtAaauUn2kXTPbvtZa7BWnWiIq9abrG12VLTwNxRZNgJfkWP5uv50b65Mw?=
 =?us-ascii?Q?ed1UsXmCOeeeRy83XbhAi8Spjw2mBW4LJT05IwmNgduc11/69rvj8xOJ9HlQ?=
 =?us-ascii?Q?LiNBJWTc89vmdBnInvVlVU2v9aWtbm9D4kn/rHnqSHzeXMzMK1l8Hh0SB/r0?=
 =?us-ascii?Q?CnoMC2OjNjHGNOkJEahAa7yTSZ3f9Ig09E91WaW891LMG9K5pGcPrgQ/d7vn?=
 =?us-ascii?Q?APGVaH54W6wwwcodELaE3rmBLZUHi+Mj1dj9CUzgZz5QwHhzU+9x0TaJ/23W?=
 =?us-ascii?Q?8I41gQl0OAGaeRNjI7YntwfIZSF/fHtCchYL2QuNovOd5ftxuqhzeyJ3JFP4?=
 =?us-ascii?Q?LF4MUuwNgdkRxXQp58ZpnUWiL7mXeJdBGDN0IFYK9QSEXzKfwZTlP5uPSA9U?=
 =?us-ascii?Q?UoMiKy8yD41kqtz09uNyUHZPoqHixrWyk06gVXhTjch2/YVzmM8XASeyDsnw?=
 =?us-ascii?Q?7hQuu5TML2dPggVjJc/fPu36R+eG07o9v1Eo7eR4yaKmNL9Rk5ynDGA7aECT?=
 =?us-ascii?Q?AHLIkmywkHZvJsEIdjt2KOyONr5PaNQDx6qM4JXlcVuqmEAxm2PaHFWvTKxk?=
 =?us-ascii?Q?Kg5LAcN4z/QLuyFg2xNjy7mgCgK5rsbrmENQ+Ah6E5JwX+4vZIf+cICn21bP?=
 =?us-ascii?Q?YlxrLS3KghCs10MGgRBgIg2lJPDuDI60jTT6gzqQf5+xeej3vTSVAT5OTcD0?=
 =?us-ascii?Q?g2ZucylM8KVAnjpED6Hz+8e0ajUAvtI09hXTR/L+yCvJGMN2AiAj2zAXfG6v?=
 =?us-ascii?Q?Wi02p09+ff4v16uKt5tgpohdUo+XRdhMvSIHWyTDRWsTXZ/UdqzHdo2hypxo?=
 =?us-ascii?Q?lxPd/FFd9nLtJ2P5htjJesdbSSgw8/bOmiJgK63KI+qDq2th5YhIjgv8jGVf?=
 =?us-ascii?Q?3kDohs+TefoAeCf6p6uF8ZOybiU0GJm01ljPS2t/T6fP4fPB2bkpvvYnyMK8?=
 =?us-ascii?Q?ozRFKg8hlRABcBwyaOKuXoLDPAq4vtKH1M4OIPoio5vSGN1AdmotW5SjMRyh?=
 =?us-ascii?Q?lNSIKLtWIpZc4Ti0Q2IEYlDRVb9jE9EVENIs+StdtRQfytkcnI5UhoRtW7Qn?=
 =?us-ascii?Q?ue1c1a1DWBXumciNPJ/kyUX9LkaC8YMuOR8qirSoV5B9kRwUV6Yt+m0Muo0r?=
 =?us-ascii?Q?PetQvNzl1KlrQ/J3eu4w3whFaiBpiTN9FHKWUtthznW2AdkJB/XuRYYOoOCv?=
 =?us-ascii?Q?aH1x4HtRWIavNPETjpgpjcOwmmKQBic4FxpgeiBgtRZSJ8qUf9/xNTt8/GpW?=
 =?us-ascii?Q?sSICePS1+l0TcIaPg05QLUoyJBfzfDYGTLxIV6a+/P1mmHXVZN9yfaMasCmo?=
 =?us-ascii?Q?fvtSJ0DPcCJU+ju9lXwy5OXOb3QMMRX3MoY7be9ytqPFxCUXNDV4EM37d/g7?=
 =?us-ascii?Q?ZYjt2MNzBdY71v/wLYMLNRi0RllymomA?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:30.8935
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0db7c381-6019-4d07-6ba2-08dd13d954f7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9494

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


