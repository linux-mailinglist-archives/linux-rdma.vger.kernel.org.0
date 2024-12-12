Return-Path: <linux-rdma+bounces-6494-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C66E9EFF1C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 23:15:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CB2D281148
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Dec 2024 22:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 656441DE2BF;
	Thu, 12 Dec 2024 22:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mecxz/sT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2063.outbound.protection.outlook.com [40.107.223.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587F61D7989;
	Thu, 12 Dec 2024 22:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734041740; cv=fail; b=Ptyv0QrSYqL99p7lu/8SkxdYDsqJKJAq8DspAmXcfqc7tudM5haJFrmQAPX4vDTiof4288atbxi7zb1Wg8/pyiLlnhHodajLVHAt2ItBDKsN9sgkYGt092i5vlO86nT21eRAepGDF6GnTsUtFA3AP75mA7Gx1D4itB5U1WeE3OU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734041740; c=relaxed/simple;
	bh=u5gboAqmZ4cg9fUrTFwfulOROlP3FOFOXHwTi4TXjT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iIZ6T8CIUv34n+PDFpB27c8DhY69y4CvYxoWuegkTu49ri/wfl2m2myk5rEvMVVwfr7nqxWqduTpAVjE92KsDESzXJB4nHrUmyvl3gyhYs7Yoc0aAJXBmp1QRhYfrYD4XyfwYLjBbEtkmy5Rq8vpJHB896JN0s+kjTBQlAX0Xh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mecxz/sT; arc=fail smtp.client-ip=40.107.223.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q8vhpFaTKA588uHOche2VfCH0EHyIwUnOS27H/Z2xIC4gi3vvh61n6rtAFkeX5aYO7mkfwDLE83PK4/Dd8zqgNmyQjVl1W8tHtmWCd6Hp9/GIWEIpETOR8+ddO43rblI7dA2FEIWDACu5GkFKQI/LLtC2ADHX6SXJzWCmmxtsxXoa0OsJEAPir1J4HFrrtPj1G5EXcyCLv5WvhwoN1cIawATDdPJRh00HHdTH1YayCjgASEtckeOXuXGcdCnPfmteRz9hyd7TOxNVKe6YsToBNJN4WXrPW458Z5x960VcIf9VVjLo4chC//J/Zih8jMJ45g+x14PrJN6Thc4UiVnBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pau08nKiXKlCsZtbvC2vBvvbLmkUKXzWrUDYBnn9VX0=;
 b=Y/S4gw7cmTxBeOXlFasKbV+oVYOHjmmFhfQcrgTNMX5OAsaxyqkW0y5QntP3inKNC+l8i2nhKT7y9Ko+YFBRMFvCwoo0/W8UUJQHnhqY76elERydJdv4AQX+OV/6ROiQFBs+3/8RpBLBLVmqothsoYOYpEiNmKW9T83KhYm2RJtOlEd37cHFOMaLAr074rNqW/sGLFakBzLVOlQXGvHZ/0zbw7F3WAaSujvLs0k9NBxlZuuNDUrzM3DMuZjyozt4IJxer9wZfKHTIQiPl3YW26QVZ+1y1p7ILdqU6BvIiQTXaBqnlV+88rVwhsTioB0chpgnEh6XMDiILDLKdczPNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pau08nKiXKlCsZtbvC2vBvvbLmkUKXzWrUDYBnn9VX0=;
 b=mecxz/sTDkR9JyVo4mvKh+W07zEMcorZoffXv3pmemYZ6WnNnYBjOXrrhZe6qV5zzxdPI8P3oCwNtcRH2xNw1rUYcy3H8PPm2tomul78IdbVagzoFq/xRj1pS0N/FUYS5xjjkJrRheSC9ofPYvi3xu00JLIsDK829unm2KmeYbuluzf25Z0J/Yuzgia2pQdW8A3YWA3sKCeG6KKwGJDZM/hvAbPrJRXEgI07sMKxhRg8R6J4e1uvhBSe+bsRyF3GcrbXk6tpIJOEz7EgIr9nVafWbWjfT6A8T9d+4iS+pJ9SXkle10wakMMQ+uC3cZEmGvvUnSRK7yXHZ5DzA7RktQ==
Received: from SJ2PR07CA0004.namprd07.prod.outlook.com (2603:10b6:a03:505::10)
 by BL3PR12MB6546.namprd12.prod.outlook.com (2603:10b6:208:38d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.15; Thu, 12 Dec
 2024 22:15:22 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::89) by SJ2PR07CA0004.outlook.office365.com
 (2603:10b6:a03:505::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.15 via Frontend Transport; Thu,
 12 Dec 2024 22:15:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Thu, 12 Dec 2024 22:15:22 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 12 Dec
 2024 14:15:09 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 12 Dec 2024 14:15:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 12 Dec 2024 14:15:06 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Itamar Gozlan
	<igozlan@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 07/10] net/mlx5: DR, expand SWS STE callbacks and consolidate common structs
Date: Fri, 13 Dec 2024 00:13:26 +0200
Message-ID: <20241212221329.961628-8-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|BL3PR12MB6546:EE_
X-MS-Office365-Filtering-Correlation-Id: 248b37ed-ee0d-4fa3-554e-08dd1afa78c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+nH60Ad8xphyJrDaPwn7fEoDlmy8HuO8sGrWwPjiAPu6IaAmSvASnf6kZogw?=
 =?us-ascii?Q?Wkw8298Fj8VACGjNb2IMc7+/hE49x/4nPD7AE5sFdQ6F0kHUUxPq7wRlzz1Z?=
 =?us-ascii?Q?84XM4VnSZ8biJsPdAs6ZalSurlDRvUveawq5kyZRlCSmMhinujOIdmGQYM6Q?=
 =?us-ascii?Q?32Ufh5gZWrDymhXPmg2nfXzX7QsfcwDkZxYR/Lca7MF77Yhc4o4dkGnxxZEa?=
 =?us-ascii?Q?ABHTHbKI32wB28HgecOLT7Rw+QPSmE1U36YrQ+rFSzeRxNwk8KRhZjmoV9TT?=
 =?us-ascii?Q?IU7ePvdeien4OdSWQTkqN+4oPbrrjmn/nghn0hGZJ/QgU8B5rOtKf6QCNLaW?=
 =?us-ascii?Q?irQUZgYsxWbqGXgOm9Rl0x+uR1jjs3cnLYUPg47yyjSPNpvu60vxR48PIMeX?=
 =?us-ascii?Q?0mwuE95xicTu+FFdRuHQyYqT7Lpfr44Bu0khBugJyGlSzNpF5G4k6pyViqJH?=
 =?us-ascii?Q?TJ7kg5BvwvAQNUJdgzS0OFTXRqmyIbOrV/pNeL8HUvyPTQcQtSdFK8vTNenB?=
 =?us-ascii?Q?8+sJ4Ai1mScNQKERGpnZvqB9Yxd3vUkDxFh5a/pOgflY/j0xIyQEgSphR4Ab?=
 =?us-ascii?Q?jcrT7fANqCzP5myOZcox+dEMkytpNrTum6RtyM1NBWrybhbKu5F+Jmr7q7dc?=
 =?us-ascii?Q?dUpybWg7RBdwMcCYuAgbzBOuoqIpvb6M02oQqQc2ufSmsrGLqOqgEJFxw1aL?=
 =?us-ascii?Q?p9hDlorwbU8T4OEKSIciaFUOVSNAfoDTR/nAYbyuAk30OSh06LEkwCVwZ7/W?=
 =?us-ascii?Q?gu5n7muUSkCM9On3SqroKCKI68IogNsN3hlnGz7DQRudqSlWqVs4QQnIRWeo?=
 =?us-ascii?Q?RZvbL/JZvq7FhhH2bT66eKEOCHC67nddqC6z9qf9q8L6tEreZdTWFp3Dhc4/?=
 =?us-ascii?Q?DUWVIaMUH8ZRmrY7h+vFE+6G+E3kVwIChyc9SyNyH+KWcMBq/ytTZtkbEdej?=
 =?us-ascii?Q?aha6sZZvO15gFp4YQgUlCnDGKxdBggPH44IyF84hQQ4WrfSdmXIpSF96SP23?=
 =?us-ascii?Q?YcA4BRH2+qUNfKfArgYP0NTRDUyExrbyVpOxG8L3YfweD9AMXOrss3HUaeMd?=
 =?us-ascii?Q?DXj+z7JUP/WisoaQB00keFTArqtXbWXesRiAEMVC6UWlyjbDJvpqCoGfeadv?=
 =?us-ascii?Q?cu99BY2q8uhPgSoR8ThfPm73e756bLG3Llp4ulEGedcfHf2malS1834z/2x0?=
 =?us-ascii?Q?R1LKg6IHu05vH6qzL4kOlqMp3greoxZGNnLf+aG1jgF3wl2YIpg6AZxoijcX?=
 =?us-ascii?Q?f1RAOB+B500oaoM4k27e2hKgxr86gnUSmqGleyentEaF4JFqFBpH7hkchLIQ?=
 =?us-ascii?Q?nH2Pq8cvHU9QdQCwf3gZRvT2Huok7xLgfpAHvTUKJGY3LXLrYvO1z/x12eGg?=
 =?us-ascii?Q?HpT3bWNbP99kDlQmZ+jtDJyyAYpd/QolNuExCm+xxNo8nk02a8CkMmJuuZtC?=
 =?us-ascii?Q?8xtDnp+skLr1sWhRgDhLisrlWd2R1WkD?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Dec 2024 22:15:22.6248
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 248b37ed-ee0d-4fa3-554e-08dd1afa78c1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6546

From: Itamar Gozlan <igozlan@nvidia.com>

Expand SWS STE callbacks to support ConnectX-8 hardware.
Move common enums and structures to a shared header file.

Signed-off-by: Itamar Gozlan <igozlan@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/steering/sws/dr_ste.c  |   4 +-
 .../mellanox/mlx5/core/steering/sws/dr_ste.h  |  18 +-
 .../mlx5/core/steering/sws/dr_ste_v0.c        |   6 +-
 .../mlx5/core/steering/sws/dr_ste_v1.c        | 207 ++++--------------
 .../mlx5/core/steering/sws/dr_ste_v1.h        | 147 ++++++++++++-
 .../mlx5/core/steering/sws/dr_ste_v2.c        | 169 +-------------
 .../mlx5/core/steering/sws/dr_ste_v2.h        | 168 ++++++++++++++
 7 files changed, 377 insertions(+), 342 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
index e94fbb015efa..01ba8eae2983 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.c
@@ -555,7 +555,7 @@ void mlx5dr_ste_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
 			       struct mlx5dr_ste_actions_attr *attr,
 			       u32 *added_stes)
 {
-	ste_ctx->set_actions_tx(dmn, action_type_set, ste_ctx->actions_caps,
+	ste_ctx->set_actions_tx(ste_ctx, dmn, action_type_set, ste_ctx->actions_caps,
 				hw_ste_arr, attr, added_stes);
 }
 
@@ -566,7 +566,7 @@ void mlx5dr_ste_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
 			       struct mlx5dr_ste_actions_attr *attr,
 			       u32 *added_stes)
 {
-	ste_ctx->set_actions_rx(dmn, action_type_set, ste_ctx->actions_caps,
+	ste_ctx->set_actions_rx(ste_ctx, dmn, action_type_set, ste_ctx->actions_caps,
 				hw_ste_arr, attr, added_stes);
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
index 54a6619c3ecb..b6ec8d30d990 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste.h
@@ -160,13 +160,15 @@ struct mlx5dr_ste_ctx {
 
 	/* Actions */
 	u32 actions_caps;
-	void (*set_actions_rx)(struct mlx5dr_domain *dmn,
+	void (*set_actions_rx)(struct mlx5dr_ste_ctx *ste_ctx,
+			       struct mlx5dr_domain *dmn,
 			       u8 *action_type_set,
 			       u32 actions_caps,
 			       u8 *hw_ste_arr,
 			       struct mlx5dr_ste_actions_attr *attr,
 			       u32 *added_stes);
-	void (*set_actions_tx)(struct mlx5dr_domain *dmn,
+	void (*set_actions_tx)(struct mlx5dr_ste_ctx *ste_ctx,
+			       struct mlx5dr_domain *dmn,
 			       u8 *action_type_set,
 			       u32 actions_caps,
 			       u8 *hw_ste_arr,
@@ -197,7 +199,17 @@ struct mlx5dr_ste_ctx {
 					u16 *used_hw_action_num);
 	int (*alloc_modify_hdr_chunk)(struct mlx5dr_action *action);
 	void (*dealloc_modify_hdr_chunk)(struct mlx5dr_action *action);
-
+	/* Actions bit set */
+	void (*set_encap)(u8 *hw_ste_p, u8 *d_action,
+			  u32 reformat_id, int size);
+	void (*set_push_vlan)(u8 *ste, u8 *d_action,
+			      u32 vlan_hdr);
+	void (*set_pop_vlan)(u8 *hw_ste_p, u8 *s_action,
+			     u8 vlans_num);
+	void (*set_rx_decap)(u8 *hw_ste_p, u8 *s_action);
+	void (*set_encap_l3)(u8 *hw_ste_p, u8 *frst_s_action,
+			     u8 *scnd_d_action, u32 reformat_id,
+			     int size);
 	/* Send */
 	void (*prepare_for_postsend)(u8 *hw_ste_p, u32 ste_size);
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
index e9f6c7ed7a7b..42536bee55e2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v0.c
@@ -406,7 +406,8 @@ static void dr_ste_v0_arr_init_next(u8 **last_ste,
 }
 
 static void
-dr_ste_v0_set_actions_tx(struct mlx5dr_domain *dmn,
+dr_ste_v0_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
+			 struct mlx5dr_domain *dmn,
 			 u8 *action_type_set,
 			 u32 actions_caps,
 			 u8 *last_ste,
@@ -476,7 +477,8 @@ dr_ste_v0_set_actions_tx(struct mlx5dr_domain *dmn,
 }
 
 static void
-dr_ste_v0_set_actions_rx(struct mlx5dr_domain *dmn,
+dr_ste_v0_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
+			 struct mlx5dr_domain *dmn,
 			 u8 *action_type_set,
 			 u32 actions_caps,
 			 u8 *last_ste,
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
index 1d49704b9542..7f83d77c43ef 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.c
@@ -5,136 +5,6 @@
 #include "mlx5_ifc_dr_ste_v1.h"
 #include "dr_ste_v1.h"
 
-#define DR_STE_CALC_DFNR_TYPE(lookup_type, inner) \
-	((inner) ? DR_STE_V1_LU_TYPE_##lookup_type##_I : \
-		   DR_STE_V1_LU_TYPE_##lookup_type##_O)
-
-enum dr_ste_v1_entry_format {
-	DR_STE_V1_TYPE_BWC_BYTE	= 0x0,
-	DR_STE_V1_TYPE_BWC_DW	= 0x1,
-	DR_STE_V1_TYPE_MATCH	= 0x2,
-	DR_STE_V1_TYPE_MATCH_RANGES = 0x7,
-};
-
-/* Lookup type is built from 2B: [ Definer mode 1B ][ Definer index 1B ] */
-enum {
-	DR_STE_V1_LU_TYPE_NOP				= 0x0000,
-	DR_STE_V1_LU_TYPE_ETHL2_TNL			= 0x0002,
-	DR_STE_V1_LU_TYPE_IBL3_EXT			= 0x0102,
-	DR_STE_V1_LU_TYPE_ETHL2_O			= 0x0003,
-	DR_STE_V1_LU_TYPE_IBL4				= 0x0103,
-	DR_STE_V1_LU_TYPE_ETHL2_I			= 0x0004,
-	DR_STE_V1_LU_TYPE_SRC_QP_GVMI			= 0x0104,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_O			= 0x0005,
-	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_O		= 0x0105,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_I			= 0x0006,
-	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_I		= 0x0106,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_O		= 0x0007,
-	DR_STE_V1_LU_TYPE_IPV6_DES_O			= 0x0107,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_I		= 0x0008,
-	DR_STE_V1_LU_TYPE_IPV6_DES_I			= 0x0108,
-	DR_STE_V1_LU_TYPE_ETHL4_O			= 0x0009,
-	DR_STE_V1_LU_TYPE_IPV6_SRC_O			= 0x0109,
-	DR_STE_V1_LU_TYPE_ETHL4_I			= 0x000a,
-	DR_STE_V1_LU_TYPE_IPV6_SRC_I			= 0x010a,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_O		= 0x000b,
-	DR_STE_V1_LU_TYPE_MPLS_O			= 0x010b,
-	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_I		= 0x000c,
-	DR_STE_V1_LU_TYPE_MPLS_I			= 0x010c,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_O		= 0x000d,
-	DR_STE_V1_LU_TYPE_GRE				= 0x010d,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_TNL_HEADER	= 0x000e,
-	DR_STE_V1_LU_TYPE_GENERAL_PURPOSE		= 0x010e,
-	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_I		= 0x000f,
-	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_0		= 0x010f,
-	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_1		= 0x0110,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_OK		= 0x0011,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_0			= 0x0111,
-	DR_STE_V1_LU_TYPE_FLEX_PARSER_1			= 0x0112,
-	DR_STE_V1_LU_TYPE_ETHL4_MISC_O			= 0x0113,
-	DR_STE_V1_LU_TYPE_ETHL4_MISC_I			= 0x0114,
-	DR_STE_V1_LU_TYPE_INVALID			= 0x00ff,
-	DR_STE_V1_LU_TYPE_DONT_CARE			= MLX5DR_STE_LU_TYPE_DONT_CARE,
-};
-
-enum dr_ste_v1_header_anchors {
-	DR_STE_HEADER_ANCHOR_START_OUTER		= 0x00,
-	DR_STE_HEADER_ANCHOR_1ST_VLAN			= 0x02,
-	DR_STE_HEADER_ANCHOR_IPV6_IPV4			= 0x07,
-	DR_STE_HEADER_ANCHOR_INNER_MAC			= 0x13,
-	DR_STE_HEADER_ANCHOR_INNER_IPV6_IPV4		= 0x19,
-};
-
-enum dr_ste_v1_action_size {
-	DR_STE_ACTION_SINGLE_SZ = 4,
-	DR_STE_ACTION_DOUBLE_SZ = 8,
-	DR_STE_ACTION_TRIPLE_SZ = 12,
-};
-
-enum dr_ste_v1_action_insert_ptr_attr {
-	DR_STE_V1_ACTION_INSERT_PTR_ATTR_NONE = 0,  /* Regular push header (e.g. push vlan) */
-	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP = 1, /* Encapsulation / Tunneling */
-	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ESP = 2,   /* IPsec */
-};
-
-enum dr_ste_v1_action_id {
-	DR_STE_V1_ACTION_ID_NOP				= 0x00,
-	DR_STE_V1_ACTION_ID_COPY			= 0x05,
-	DR_STE_V1_ACTION_ID_SET				= 0x06,
-	DR_STE_V1_ACTION_ID_ADD				= 0x07,
-	DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE		= 0x08,
-	DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER	= 0x09,
-	DR_STE_V1_ACTION_ID_INSERT_INLINE		= 0x0a,
-	DR_STE_V1_ACTION_ID_INSERT_POINTER		= 0x0b,
-	DR_STE_V1_ACTION_ID_FLOW_TAG			= 0x0c,
-	DR_STE_V1_ACTION_ID_QUEUE_ID_SEL		= 0x0d,
-	DR_STE_V1_ACTION_ID_ACCELERATED_LIST		= 0x0e,
-	DR_STE_V1_ACTION_ID_MODIFY_LIST			= 0x0f,
-	DR_STE_V1_ACTION_ID_ASO				= 0x12,
-	DR_STE_V1_ACTION_ID_TRAILER			= 0x13,
-	DR_STE_V1_ACTION_ID_COUNTER_ID			= 0x14,
-	DR_STE_V1_ACTION_ID_MAX				= 0x21,
-	/* use for special cases */
-	DR_STE_V1_ACTION_ID_SPECIAL_ENCAP_L3		= 0x22,
-};
-
-enum {
-	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
-	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
-	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
-	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
-	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
-	DR_STE_V1_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
-	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
-	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
-	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
-	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
-	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
-	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
-	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
-	DR_STE_V1_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
-	DR_STE_V1_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_0		= 0x8c,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_1		= 0x8d,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_0		= 0x8e,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_1		= 0x8f,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_0		= 0x90,
-	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_1		= 0x91,
-};
-
-enum dr_ste_v1_aso_ctx_type {
-	DR_STE_V1_ASO_CTX_TYPE_POLICERS = 0x2,
-};
-
 static const struct mlx5dr_ste_action_modify_field dr_ste_v1_action_modify_field_arr[] = {
 	[MLX5_ACTION_IN_FIELD_OUT_SMAC_47_16] = {
 		.hw_field = DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_0, .start = 0, .end = 31,
@@ -379,13 +249,12 @@ static void dr_ste_v1_set_counter_id(u8 *hw_ste_p, u32 ctr_id)
 	MLX5_SET(ste_match_bwc_v1, hw_ste_p, counter_id, ctr_id);
 }
 
-static void dr_ste_v1_set_reparse(u8 *hw_ste_p)
+void dr_ste_v1_set_reparse(u8 *hw_ste_p)
 {
 	MLX5_SET(ste_match_bwc_v1, hw_ste_p, reparse, 1);
 }
 
-static void dr_ste_v1_set_encap(u8 *hw_ste_p, u8 *d_action,
-				u32 reformat_id, int size)
+void dr_ste_v1_set_encap(u8 *hw_ste_p, u8 *d_action, u32 reformat_id, int size)
 {
 	MLX5_SET(ste_double_action_insert_with_ptr_v1, d_action, action_id,
 		 DR_STE_V1_ACTION_ID_INSERT_POINTER);
@@ -432,8 +301,7 @@ static void dr_ste_v1_set_remove_hdr(u8 *hw_ste_p, u8 *s_action,
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action,
-				    u32 vlan_hdr)
+void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action, u32 vlan_hdr)
 {
 	MLX5_SET(ste_double_action_insert_with_inline_v1, d_action,
 		 action_id, DR_STE_V1_ACTION_ID_INSERT_INLINE);
@@ -446,7 +314,7 @@ static void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action,
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num)
+void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num)
 {
 	MLX5_SET(ste_single_action_remove_header_size_v1, s_action,
 		 action_id, DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE);
@@ -459,11 +327,8 @@ static void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num)
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_encap_l3(u8 *hw_ste_p,
-				   u8 *frst_s_action,
-				   u8 *scnd_d_action,
-				   u32 reformat_id,
-				   int size)
+void dr_ste_v1_set_encap_l3(u8 *hw_ste_p, u8 *frst_s_action, u8 *scnd_d_action,
+			    u32 reformat_id, int size)
 {
 	/* Remove L2 headers */
 	MLX5_SET(ste_single_action_remove_header_v1, frst_s_action, action_id,
@@ -483,7 +348,7 @@ static void dr_ste_v1_set_encap_l3(u8 *hw_ste_p,
 	dr_ste_v1_set_reparse(hw_ste_p);
 }
 
-static void dr_ste_v1_set_rx_decap(u8 *hw_ste_p, u8 *s_action)
+void dr_ste_v1_set_rx_decap(u8 *hw_ste_p, u8 *s_action)
 {
 	MLX5_SET(ste_single_action_remove_header_v1, s_action, action_id,
 		 DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER);
@@ -620,7 +485,8 @@ static void dr_ste_v1_arr_init_next_match_range(u8 **last_ste,
 	dr_ste_v1_set_entry_type(*last_ste, DR_STE_V1_TYPE_MATCH_RANGES);
 }
 
-void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
+void dr_ste_v1_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx,
+			      struct mlx5dr_domain *dmn,
 			      u8 *action_type_set,
 			      u32 actions_caps,
 			      u8 *last_ste,
@@ -640,7 +506,7 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 					      last_ste, action);
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
-		dr_ste_v1_set_pop_vlan(last_ste, action, attr->vlans.count);
+		ste_ctx->set_pop_vlan(last_ste, action, attr->vlans.count);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 
@@ -677,8 +543,8 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 				action_sz = DR_STE_ACTION_TRIPLE_SZ;
 				allow_encap = true;
 			}
-			dr_ste_v1_set_push_vlan(last_ste, action,
-						attr->vlans.headers[i]);
+			ste_ctx->set_push_vlan(last_ste, action,
+					       attr->vlans.headers[i]);
 			action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 			action += DR_STE_ACTION_DOUBLE_SZ;
 		}
@@ -691,9 +557,9 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 			allow_encap = true;
 		}
-		dr_ste_v1_set_encap(last_ste, action,
-				    attr->reformat.id,
-				    attr->reformat.size);
+		ste_ctx->set_encap(last_ste, action,
+				   attr->reformat.id,
+				   attr->reformat.size);
 		action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 		action += DR_STE_ACTION_DOUBLE_SZ;
 	} else if (action_type_set[DR_ACTION_TYP_L2_TO_TNL_L3]) {
@@ -706,10 +572,10 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 		}
 		d_action = action + DR_STE_ACTION_SINGLE_SZ;
 
-		dr_ste_v1_set_encap_l3(last_ste,
-				       action, d_action,
-				       attr->reformat.id,
-				       attr->reformat.size);
+		ste_ctx->set_encap_l3(last_ste,
+				      action, d_action,
+				      attr->reformat.id,
+				      attr->reformat.size);
 		action_sz -= DR_STE_ACTION_TRIPLE_SZ;
 		action += DR_STE_ACTION_TRIPLE_SZ;
 	} else if (action_type_set[DR_ACTION_TYP_INSERT_HDR]) {
@@ -776,7 +642,8 @@ void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn,
 	dr_ste_v1_set_hit_addr(last_ste, attr->final_icm_addr, 1);
 }
 
-void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
+void dr_ste_v1_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx,
+			      struct mlx5dr_domain *dmn,
 			      u8 *action_type_set,
 			      u32 actions_caps,
 			      u8 *last_ste,
@@ -799,7 +666,7 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 		allow_modify_hdr = false;
 		allow_ctr = false;
 	} else if (action_type_set[DR_ACTION_TYP_TNL_L2_TO_L2]) {
-		dr_ste_v1_set_rx_decap(last_ste, action);
+		ste_ctx->set_rx_decap(last_ste, action);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 		allow_modify_hdr = false;
@@ -827,7 +694,7 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
 
-		dr_ste_v1_set_pop_vlan(last_ste, action, attr->vlans.count);
+		ste_ctx->set_pop_vlan(last_ste, action, attr->vlans.count);
 		action_sz -= DR_STE_ACTION_SINGLE_SZ;
 		action += DR_STE_ACTION_SINGLE_SZ;
 		allow_ctr = false;
@@ -868,8 +735,8 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 						      last_ste, action);
 				action_sz = DR_STE_ACTION_TRIPLE_SZ;
 			}
-			dr_ste_v1_set_push_vlan(last_ste, action,
-						attr->vlans.headers[i]);
+			ste_ctx->set_push_vlan(last_ste, action,
+					       attr->vlans.headers[i]);
 			action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 			action += DR_STE_ACTION_DOUBLE_SZ;
 		}
@@ -895,9 +762,9 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 			action = MLX5_ADDR_OF(ste_mask_and_match_v1, last_ste, action);
 			action_sz = DR_STE_ACTION_TRIPLE_SZ;
 		}
-		dr_ste_v1_set_encap(last_ste, action,
-				    attr->reformat.id,
-				    attr->reformat.size);
+		ste_ctx->set_encap(last_ste, action,
+				   attr->reformat.id,
+				   attr->reformat.size);
 		action_sz -= DR_STE_ACTION_DOUBLE_SZ;
 		action += DR_STE_ACTION_DOUBLE_SZ;
 		allow_modify_hdr = false;
@@ -912,10 +779,10 @@ void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn,
 
 		d_action = action + DR_STE_ACTION_SINGLE_SZ;
 
-		dr_ste_v1_set_encap_l3(last_ste,
-				       action, d_action,
-				       attr->reformat.id,
-				       attr->reformat.size);
+		ste_ctx->set_encap_l3(last_ste,
+				      action, d_action,
+				      attr->reformat.id,
+				      attr->reformat.size);
 		action_sz -= DR_STE_ACTION_TRIPLE_SZ;
 		allow_modify_hdr = false;
 	} else if (action_type_set[DR_ACTION_TYP_INSERT_HDR]) {
@@ -1027,9 +894,6 @@ void dr_ste_v1_set_action_copy(u8 *d_action,
 	MLX5_SET(ste_double_action_copy_v1, d_action, source_right_shifter, src_shifter);
 }
 
-#define DR_STE_DECAP_L3_ACTION_NUM	8
-#define DR_STE_L2_HDR_MAX_SZ		20
-
 int dr_ste_v1_set_action_decap_l3_list(void *data,
 				       u32 data_sz,
 				       u8 *hw_action,
@@ -2330,7 +2194,12 @@ static struct mlx5dr_ste_ctx ste_ctx_v1 = {
 	.set_action_decap_l3_list	= &dr_ste_v1_set_action_decap_l3_list,
 	.alloc_modify_hdr_chunk		= &dr_ste_v1_alloc_modify_hdr_ptrn_arg,
 	.dealloc_modify_hdr_chunk	= &dr_ste_v1_free_modify_hdr_ptrn_arg,
-
+	/* Actions bit set */
+	.set_encap			= &dr_ste_v1_set_encap,
+	.set_push_vlan			= &dr_ste_v1_set_push_vlan,
+	.set_pop_vlan			= &dr_ste_v1_set_pop_vlan,
+	.set_rx_decap			= &dr_ste_v1_set_rx_decap,
+	.set_encap_l3			= &dr_ste_v1_set_encap_l3,
 	/* Send */
 	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
index e2fc69867088..a8d9e308d339 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v1.h
@@ -7,6 +7,138 @@
 #include "dr_types.h"
 #include "dr_ste.h"
 
+#define DR_STE_DECAP_L3_ACTION_NUM	8
+#define DR_STE_L2_HDR_MAX_SZ		20
+#define DR_STE_CALC_DFNR_TYPE(lookup_type, inner) \
+	((inner) ? DR_STE_V1_LU_TYPE_##lookup_type##_I : \
+		   DR_STE_V1_LU_TYPE_##lookup_type##_O)
+
+enum dr_ste_v1_entry_format {
+	DR_STE_V1_TYPE_BWC_BYTE	= 0x0,
+	DR_STE_V1_TYPE_BWC_DW	= 0x1,
+	DR_STE_V1_TYPE_MATCH	= 0x2,
+	DR_STE_V1_TYPE_MATCH_RANGES = 0x7,
+};
+
+/* Lookup type is built from 2B: [ Definer mode 1B ][ Definer index 1B ] */
+enum {
+	DR_STE_V1_LU_TYPE_NOP				= 0x0000,
+	DR_STE_V1_LU_TYPE_ETHL2_TNL			= 0x0002,
+	DR_STE_V1_LU_TYPE_IBL3_EXT			= 0x0102,
+	DR_STE_V1_LU_TYPE_ETHL2_O			= 0x0003,
+	DR_STE_V1_LU_TYPE_IBL4				= 0x0103,
+	DR_STE_V1_LU_TYPE_ETHL2_I			= 0x0004,
+	DR_STE_V1_LU_TYPE_SRC_QP_GVMI			= 0x0104,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_O			= 0x0005,
+	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_O		= 0x0105,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_I			= 0x0006,
+	DR_STE_V1_LU_TYPE_ETHL2_HEADERS_I		= 0x0106,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_O		= 0x0007,
+	DR_STE_V1_LU_TYPE_IPV6_DES_O			= 0x0107,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_5_TUPLE_I		= 0x0008,
+	DR_STE_V1_LU_TYPE_IPV6_DES_I			= 0x0108,
+	DR_STE_V1_LU_TYPE_ETHL4_O			= 0x0009,
+	DR_STE_V1_LU_TYPE_IPV6_SRC_O			= 0x0109,
+	DR_STE_V1_LU_TYPE_ETHL4_I			= 0x000a,
+	DR_STE_V1_LU_TYPE_IPV6_SRC_I			= 0x010a,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_O		= 0x000b,
+	DR_STE_V1_LU_TYPE_MPLS_O			= 0x010b,
+	DR_STE_V1_LU_TYPE_ETHL2_SRC_DST_I		= 0x000c,
+	DR_STE_V1_LU_TYPE_MPLS_I			= 0x010c,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_O		= 0x000d,
+	DR_STE_V1_LU_TYPE_GRE				= 0x010d,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_TNL_HEADER	= 0x000e,
+	DR_STE_V1_LU_TYPE_GENERAL_PURPOSE		= 0x010e,
+	DR_STE_V1_LU_TYPE_ETHL3_IPV4_MISC_I		= 0x000f,
+	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_0		= 0x010f,
+	DR_STE_V1_LU_TYPE_STEERING_REGISTERS_1		= 0x0110,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_OK		= 0x0011,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_0			= 0x0111,
+	DR_STE_V1_LU_TYPE_FLEX_PARSER_1			= 0x0112,
+	DR_STE_V1_LU_TYPE_ETHL4_MISC_O			= 0x0113,
+	DR_STE_V1_LU_TYPE_ETHL4_MISC_I			= 0x0114,
+	DR_STE_V1_LU_TYPE_INVALID			= 0x00ff,
+	DR_STE_V1_LU_TYPE_DONT_CARE			= MLX5DR_STE_LU_TYPE_DONT_CARE,
+};
+
+enum dr_ste_v1_header_anchors {
+	DR_STE_HEADER_ANCHOR_START_OUTER		= 0x00,
+	DR_STE_HEADER_ANCHOR_1ST_VLAN			= 0x02,
+	DR_STE_HEADER_ANCHOR_IPV6_IPV4			= 0x07,
+	DR_STE_HEADER_ANCHOR_INNER_MAC			= 0x13,
+	DR_STE_HEADER_ANCHOR_INNER_IPV6_IPV4		= 0x19,
+};
+
+enum dr_ste_v1_action_size {
+	DR_STE_ACTION_SINGLE_SZ = 4,
+	DR_STE_ACTION_DOUBLE_SZ = 8,
+	DR_STE_ACTION_TRIPLE_SZ = 12,
+};
+
+enum dr_ste_v1_action_insert_ptr_attr {
+	DR_STE_V1_ACTION_INSERT_PTR_ATTR_NONE = 0,  /* Regular push header (e.g. push vlan) */
+	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ENCAP = 1, /* Encapsulation / Tunneling */
+	DR_STE_V1_ACTION_INSERT_PTR_ATTR_ESP = 2,   /* IPsec */
+};
+
+enum dr_ste_v1_action_id {
+	DR_STE_V1_ACTION_ID_NOP				= 0x00,
+	DR_STE_V1_ACTION_ID_COPY			= 0x05,
+	DR_STE_V1_ACTION_ID_SET				= 0x06,
+	DR_STE_V1_ACTION_ID_ADD				= 0x07,
+	DR_STE_V1_ACTION_ID_REMOVE_BY_SIZE		= 0x08,
+	DR_STE_V1_ACTION_ID_REMOVE_HEADER_TO_HEADER	= 0x09,
+	DR_STE_V1_ACTION_ID_INSERT_INLINE		= 0x0a,
+	DR_STE_V1_ACTION_ID_INSERT_POINTER		= 0x0b,
+	DR_STE_V1_ACTION_ID_FLOW_TAG			= 0x0c,
+	DR_STE_V1_ACTION_ID_QUEUE_ID_SEL		= 0x0d,
+	DR_STE_V1_ACTION_ID_ACCELERATED_LIST		= 0x0e,
+	DR_STE_V1_ACTION_ID_MODIFY_LIST			= 0x0f,
+	DR_STE_V1_ACTION_ID_ASO				= 0x12,
+	DR_STE_V1_ACTION_ID_TRAILER			= 0x13,
+	DR_STE_V1_ACTION_ID_COUNTER_ID			= 0x14,
+	DR_STE_V1_ACTION_ID_MAX				= 0x21,
+	/* use for special cases */
+	DR_STE_V1_ACTION_ID_SPECIAL_ENCAP_L3		= 0x22,
+};
+
+enum {
+	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
+	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
+	DR_STE_V1_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
+	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
+	DR_STE_V1_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
+	DR_STE_V1_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
+	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
+	DR_STE_V1_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
+	DR_STE_V1_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
+	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
+	DR_STE_V1_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
+	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
+	DR_STE_V1_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
+	DR_STE_V1_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
+	DR_STE_V1_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_0		= 0x8c,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_2_1		= 0x8d,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_0		= 0x8e,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_1_1		= 0x8f,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_0		= 0x90,
+	DR_STE_V1_ACTION_MDFY_FLD_REGISTER_0_1		= 0x91,
+};
+
+enum dr_ste_v1_aso_ctx_type {
+	DR_STE_V1_ASO_CTX_TYPE_POLICERS = 0x2,
+};
+
 bool dr_ste_v1_is_miss_addr_set(u8 *hw_ste_p);
 void dr_ste_v1_set_miss_addr(u8 *hw_ste_p, u64 miss_addr);
 u64 dr_ste_v1_get_miss_addr(u8 *hw_ste_p);
@@ -17,11 +149,18 @@ u16 dr_ste_v1_get_next_lu_type(u8 *hw_ste_p);
 void dr_ste_v1_set_hit_addr(u8 *hw_ste_p, u64 icm_addr, u32 ht_size);
 void dr_ste_v1_init(u8 *hw_ste_p, u16 lu_type, bool is_rx, u16 gvmi);
 void dr_ste_v1_prepare_for_postsend(u8 *hw_ste_p, u32 ste_size);
-void dr_ste_v1_set_actions_tx(struct mlx5dr_domain *dmn, u8 *action_type_set,
-			      u32 actions_caps, u8 *last_ste,
+void dr_ste_v1_set_reparse(u8 *hw_ste_p);
+void dr_ste_v1_set_encap(u8 *hw_ste_p, u8 *d_action, u32 reformat_id, int size);
+void dr_ste_v1_set_push_vlan(u8 *hw_ste_p, u8 *d_action, u32 vlan_hdr);
+void dr_ste_v1_set_pop_vlan(u8 *hw_ste_p, u8 *s_action, u8 vlans_num);
+void dr_ste_v1_set_encap_l3(u8 *hw_ste_p, u8 *frst_s_action, u8 *scnd_d_action,
+			    u32 reformat_id, int size);
+void dr_ste_v1_set_rx_decap(u8 *hw_ste_p, u8 *s_action);
+void dr_ste_v1_set_actions_tx(struct mlx5dr_ste_ctx *ste_ctx, struct mlx5dr_domain *dmn,
+			      u8 *action_type_set, u32 actions_caps, u8 *last_ste,
 			      struct mlx5dr_ste_actions_attr *attr, u32 *added_stes);
-void dr_ste_v1_set_actions_rx(struct mlx5dr_domain *dmn, u8 *action_type_set,
-			      u32 actions_caps, u8 *last_ste,
+void dr_ste_v1_set_actions_rx(struct mlx5dr_ste_ctx *ste_ctx, struct mlx5dr_domain *dmn,
+			      u8 *action_type_set, u32 actions_caps, u8 *last_ste,
 			      struct mlx5dr_ste_actions_attr *attr, u32 *added_stes);
 void dr_ste_v1_set_action_set(u8 *d_action, u8 hw_field, u8 shifter,
 			      u8 length, u32 data);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
index 808b013cf48c..0882dba0f64b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.c
@@ -2,167 +2,7 @@
 /* Copyright (c) 2022, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
 
 #include "dr_ste_v1.h"
-
-enum {
-	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
-	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
-	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
-	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
-	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
-	DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
-	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
-	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
-	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
-	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
-	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
-	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
-	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
-	DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
-	DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0		= 0x90,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1		= 0x91,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0		= 0x92,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1		= 0x93,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0		= 0x94,
-	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1		= 0x95,
-};
-
-static const struct mlx5dr_ste_action_modify_field dr_ste_v2_action_modify_field_arr[] = {
-	[MLX5_ACTION_IN_FIELD_OUT_SMAC_47_16] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SMAC_15_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1, .start = 16, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_ETHERTYPE] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 0, .end = 15,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DMAC_47_16] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DMAC_15_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 16, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_IP_DSCP] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 18, .end = 23,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_FLAGS] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1, .start = 16, .end = 24,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_SPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_DPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_IP_TTL] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_IPV6_HOPLIMIT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_UDP_SPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_UDP_DPORT] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
-		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_127_96] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_95_64] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_63_32] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_31_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_127_96] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_95_64] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_63_32] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_31_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_SIPV4] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_DIPV4] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1, .start = 0, .end = 31,
-		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_A] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_B] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_1] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_2] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_3] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_4] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_5] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_SEQ_NUM] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_TCP_ACK_NUM] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_FIRST_VID] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2, .start = 0, .end = 15,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_EMD_31_0] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1, .start = 0, .end = 31,
-	},
-	[MLX5_ACTION_IN_FIELD_OUT_EMD_47_32] = {
-		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0, .start = 0, .end = 15,
-	},
-};
+#include "dr_ste_v2.h"
 
 static struct mlx5dr_ste_ctx ste_ctx_v2 = {
 	/* Builders */
@@ -223,7 +63,12 @@ static struct mlx5dr_ste_ctx ste_ctx_v2 = {
 	.set_action_decap_l3_list	= &dr_ste_v1_set_action_decap_l3_list,
 	.alloc_modify_hdr_chunk		= &dr_ste_v1_alloc_modify_hdr_ptrn_arg,
 	.dealloc_modify_hdr_chunk	= &dr_ste_v1_free_modify_hdr_ptrn_arg,
-
+	/* Actions bit set */
+	.set_encap			= &dr_ste_v1_set_encap,
+	.set_push_vlan			= &dr_ste_v1_set_push_vlan,
+	.set_pop_vlan			= &dr_ste_v1_set_pop_vlan,
+	.set_rx_decap			= &dr_ste_v1_set_rx_decap,
+	.set_encap_l3			= &dr_ste_v1_set_encap_l3,
 	/* Send */
 	.prepare_for_postsend		= &dr_ste_v1_prepare_for_postsend,
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
new file mode 100644
index 000000000000..d853fde49cfc
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/sws/dr_ste_v2.h
@@ -0,0 +1,168 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved. */
+
+#ifndef	_DR_STE_V2_
+#define	_DR_STE_V2_
+
+enum {
+	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0		= 0x00,
+	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1		= 0x01,
+	DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2		= 0x02,
+	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0		= 0x08,
+	DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1		= 0x09,
+	DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0		= 0x0e,
+	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0		= 0x18,
+	DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1		= 0x19,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0		= 0x40,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1		= 0x41,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0	= 0x44,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1	= 0x45,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2	= 0x46,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3	= 0x47,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0	= 0x4c,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1	= 0x4d,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2	= 0x4e,
+	DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3	= 0x4f,
+	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0		= 0x5e,
+	DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1		= 0x5f,
+	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0		= 0x6f,
+	DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1		= 0x70,
+	DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE	= 0x7b,
+	DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE		= 0x7c,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0		= 0x90,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1		= 0x91,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0		= 0x92,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1		= 0x93,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0		= 0x94,
+	DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1		= 0x95,
+};
+
+static const struct mlx5dr_ste_action_modify_field dr_ste_v2_action_modify_field_arr[] = {
+	[MLX5_ACTION_IN_FIELD_OUT_SMAC_47_16] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SMAC_15_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_SRC_L2_OUT_1, .start = 16, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_ETHERTYPE] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 0, .end = 15,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DMAC_47_16] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DMAC_15_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_1, .start = 16, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_IP_DSCP] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 18, .end = 23,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_FLAGS] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_1, .start = 16, .end = 24,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_SPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_DPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_TCP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_IP_TTL] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_IPV6_HOPLIMIT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L3_OUT_0, .start = 8, .end = 15,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_UDP_SPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 16, .end = 31,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_UDP_DPORT] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L4_OUT_0, .start = 0, .end = 15,
+		.l4_type = DR_STE_ACTION_MDFY_TYPE_L4_UDP,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_127_96] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_0, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_95_64] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_1, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_63_32] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_2, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV6_31_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_SRC_OUT_3, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_127_96] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_0, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_95_64] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_1, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_63_32] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_2, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV6_31_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV6_DST_OUT_3, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV6,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_SIPV4] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_0, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_DIPV4] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_IPV4_OUT_1, .start = 0, .end = 31,
+		.l3_type = DR_STE_ACTION_MDFY_TYPE_L3_IPV4,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_A] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_GNRL_PURPOSE, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_B] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_METADATA_2_CQE, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_1] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_0_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_2] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_3] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_1_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_4] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_METADATA_REG_C_5] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_REGISTER_2_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_SEQ_NUM] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_0, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_TCP_ACK_NUM] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_TCP_MISC_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_FIRST_VID] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_L2_OUT_2, .start = 0, .end = 15,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_EMD_31_0] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_1, .start = 0, .end = 31,
+	},
+	[MLX5_ACTION_IN_FIELD_OUT_EMD_47_32] = {
+		.hw_field = DR_STE_V2_ACTION_MDFY_FLD_CFG_HDR_0_0, .start = 0, .end = 15,
+	},
+};
+
+#endif  /* _DR_STE_V2_ */
-- 
2.44.0


