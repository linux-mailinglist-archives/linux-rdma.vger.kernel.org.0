Return-Path: <linux-rdma+bounces-6252-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 285589E47A2
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECFD916AD6A
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31911C3C04;
	Wed,  4 Dec 2024 22:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="oH7eSFgd"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2081.outbound.protection.outlook.com [40.107.100.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AD51A8F6C;
	Wed,  4 Dec 2024 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350328; cv=fail; b=H1BMYJwn8PDPWSFBsRAqLWKMc/KA3Jgpi4zcrsXMXBrW+7uhzZeVcB98BI2qLRC7WX3TWGxyfpGaZ7QWUlydQJvE+b3YCcJRk4GTtLubHJ6ofdm7YJxjWEaWsTZ5otM1qY92tW5jG1QOe7hFQSjXEVYHKNYyYURYmZpqvT+6gq8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350328; c=relaxed/simple;
	bh=u5gboAqmZ4cg9fUrTFwfulOROlP3FOFOXHwTi4TXjT4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o5xzAB5ank7Q54iwVKZai9dzLjCmHu7l0oiQd7Hd/NIcL5nk9Q1who0VCHP8iW7gwKTJzKjxlArHTtfN5b/pXTukLqCc7m6W3M9bP4JrykVpbjyI77pJQ8K7hhVVDqdjM9RMiqwdFvwA5GoqkbFaMBxYU2zk5poFn2uUlYuG53Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=oH7eSFgd; arc=fail smtp.client-ip=40.107.100.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJj+kKRSRyW0VaxuX0vBNDDVMwHLWumiLUt+7d7i20eqaaxRUiaw77ZstmB6q4A868Q/MAsf6pkfFbGNd9EwYrsyQRtiUWgUyKcouvg9t3XipdxHVlD0yrg0mlVIEb2W+P6lOTIunCb2l1PvpZFdaItIzf//LZ3sY1lKlNlIKgt2lgGIDmYPGx/ao2RlLZ1cHuF5ydVh24VP8pjhSERV4OATrK1hGnVtBKqRfbaXsttXThu46ZLKCTDs3Kh3NoPsRK4AWAfYuRq2cMmlZjnaIjVmILozspAbeHUskItbJwQaqI/Wvfy6u1LvAdwQEDHrUjAfMVyoqF+hxMUMhVPL2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pau08nKiXKlCsZtbvC2vBvvbLmkUKXzWrUDYBnn9VX0=;
 b=Wkr4kHgVCrWdEbBoXSw5dAypE6g6mEySYtLbOYrYK38GwH0IhtF5nDIy1Ins1d87eNDWx1XF9j+eEQXTtstIvBW5Z3QJPelinBCiWaOFSjFGpK2q+gyNhztmE2wAtI8OtC60V8vucBBtZgSLO+/cyIZAQ7upzsSuFGz5MGCaEDZzsEeiWuqhlZwhtVcHMV/K+9OvfJOzL+YmK+UhiiG7rJKhsD+xE+1XnKqoShbuVgTeBbv09MwX8ttDtjvg7qtXGirQzRDyU45oYUId7OlKdXRIAv2yx2YcGTxmCZ02cwezA9TTkKEJLCGcEyK4pC8d9Ye24E58gTILqvwMZmooxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pau08nKiXKlCsZtbvC2vBvvbLmkUKXzWrUDYBnn9VX0=;
 b=oH7eSFgdln8m8xKb7GYixba/vwa9U9Yrzh/OX9QtpSJJlG3H/vMXVzbt/nLzG7XB4ckbYXAWy7ddVnR2zfxDablWkEBSX+xlifwllMeFAu4XARpgxgJfKRPwya4NMcRfCtjPYjNO5uarZI4wLjmWS760cCKsZPMVQXvtimoStf8vMnZmxAdorYrfPDnHnSDTuMbaYbkhFcalI4aHgLmNyS/hGGZyhPSansXPJmD3+VbSUILFu4PKexLSLL0oZH5r7BwZeVWo1bzGkmtS2CH+jNRGVJEb6b7N1r2L0fwjlHYM7A1n1UdCGqHPula504YNVsyWDVWP7ULckITl4MgpPg==
Received: from BYAPR02CA0039.namprd02.prod.outlook.com (2603:10b6:a03:54::16)
 by LV3PR12MB9266.namprd12.prod.outlook.com (2603:10b6:408:21b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Wed, 4 Dec
 2024 22:11:45 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:54:cafe::d4) by BYAPR02CA0039.outlook.office365.com
 (2603:10b6:a03:54::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.10 via Frontend Transport; Wed,
 4 Dec 2024 22:11:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:44 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:25 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:21 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Itamar Gozlan
	<igozlan@nvidia.com>, Yevgeny Kliteynik <kliteyn@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V5 05/11] net/mlx5: DR, Expand SWS STE callbacks and consolidate common structs
Date: Thu, 5 Dec 2024 00:09:25 +0200
Message-ID: <20241204220931.254964-6-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|LV3PR12MB9266:EE_
X-MS-Office365-Filtering-Correlation-Id: 47514ab8-5d28-478d-17c5-08dd14b0a37e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qTlzNkOsK9EQDwvqnjvaYklzmsoGpztp9Fs1gCNSmQO+Y55HRVqyhNZhuTym?=
 =?us-ascii?Q?mnwTa9GvlyEaHak/kSC95wrDjxSBk/6xb1rMu/mqsqM/LZ1sWlh/xYLlct63?=
 =?us-ascii?Q?bDQa2BZN/+6A8fj2YcpbCQK87zCMoC6aM9Af/boOtI8WKXewuV8jjJvFPPaB?=
 =?us-ascii?Q?IlfoDVA38dHleW+QXEADuf9WGmSOqFR7dqqV1yH4as7JqdqYtMz+5QpBv1YN?=
 =?us-ascii?Q?YcPpMmX6CDA1d3hICWiwcEvY8kXLSasxQ530TvP9AkqgbBQkSO5l72XQeAHC?=
 =?us-ascii?Q?eYnSDn7Ta7+0tM1gwRCmPDPxhjj+N+XFGyunVwLEX7XEJV7YVTV8zV5t1gHp?=
 =?us-ascii?Q?VwCwHaG6C8i+Um+zMK6C+ZCtcc6sUiIBvbOVZT5qBWrWWQNqkg7z5E2vMoEA?=
 =?us-ascii?Q?Jw+4YBwhXNEM9b6eYAgCeLTXbt6W55hgn3WUflIAlQsaWsW13KMC24l4yESo?=
 =?us-ascii?Q?2mxE+9jDDCMgv00StNqb58KKAaVdOcpvVQbs/trlgsJV4x0n5lfYThpnOixm?=
 =?us-ascii?Q?GGBmYc5E+kaHvoxAQnOejVd20hEB2IMungP80ZvOcegK5JJpTj5jiRDiGpeB?=
 =?us-ascii?Q?HUKoG08lC8f5Z/zMSmiwIg9f7E51CrCCgdM1Gu1zyq1/09g+8oS1r4vZNnvR?=
 =?us-ascii?Q?BX6UQPKIu9lbYhoZ7Yy2nKlw/PjeYQ46NnWBkPyy+3vIbdupFdlM1T77IsSH?=
 =?us-ascii?Q?MoZZzQq9rC1X8dZG/W7RkVN5Hze1XYfRNbjbwy4i0DqqhSZIykZNSgRr/tcY?=
 =?us-ascii?Q?JPYxkgCVJf+v3vUXky6VoGJtUBJvtjqhML2K3LQF0zKESAW1T0WyFn0cwMvI?=
 =?us-ascii?Q?W53DB7UYLSRmxBPyD0r8N0nZPHtZSCXLBdBHGjcG3Nt47W0Wp6GLKi2EuPdc?=
 =?us-ascii?Q?VsU/vTLZ+j2lrS4WrYzwVQwBGjtaS9SWSiH5uIZW47DqCukYDorZXHW9fTew?=
 =?us-ascii?Q?ctelRwHkSLg8wHRKuB7S8NRx+a6aEhklpvKflfGNxasFCCcA0L5kN/FrS4g3?=
 =?us-ascii?Q?G4F3itOXH3vqQdf8MKNQE0Nn7EaqYbCEYTIDmU72uP4wawxbs0X3Y4OeLXtV?=
 =?us-ascii?Q?u/cz+UXq+CATIm3yNAS8y6T3fkL6hEvVujSumWYSI43qPVXD0z9hwNVEeqHg?=
 =?us-ascii?Q?F69UT8YZ386CuOKUS4Brv4fkqM3g8mfYMxaPMElDKDM2ZfSeLL8r/ARp+1Ff?=
 =?us-ascii?Q?9FgAeWMFS45stMLZSZ9KToualS9H+n3/czLPfHHP4+/+9rLE6nT6Ogf+JEWv?=
 =?us-ascii?Q?o6JGD0AC5oJLxym34oIFQW51R0/VcGM+1XzF6oi2yIMMThzQ9EaBo88Av/vG?=
 =?us-ascii?Q?hrhYI1VgNPK9GAZTMqC11Ac6T7U9uAzP3Bo00DVcvBoy2XiWIqIYEspou3M+?=
 =?us-ascii?Q?8Gd6hwdttc0eBmaePonOMJVdT482TyRwbOAPDVofiPg99n3wRYtUQQuGgoac?=
 =?us-ascii?Q?RhLtMPDIOhVzXS4QeUTe2Mw9hnZXSje5?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:44.4821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47514ab8-5d28-478d-17c5-08dd14b0a37e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9266

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


