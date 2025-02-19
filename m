Return-Path: <linux-rdma+bounces-7829-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54F25A3BD33
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 12:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01EB21705B5
	for <lists+linux-rdma@lfdr.de>; Wed, 19 Feb 2025 11:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2DF1DF73B;
	Wed, 19 Feb 2025 11:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZY8BNbYD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2089.outbound.protection.outlook.com [40.107.93.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620D01DF730;
	Wed, 19 Feb 2025 11:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739965383; cv=fail; b=Svdk4JjUYD6q+jPTU1L+dgwrpHJFsPyxmojWgGrCIUvPXPPr/xVUDtG9i9v00SnZIo839fDff7/Vy6eTvAhV5R+00nonPSGmU5xsy7dmafvdgsYJS9/G/muOHj3Gx/KF/wwsnO13EYTZrTsLIWEh8FIACFgkddftSCftC9vtS+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739965383; c=relaxed/simple;
	bh=j3/ChoVVVdCA6F4BaF6QHmixWNKqNwwhhX0vwNIUxUw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s3zCf4ZQ2MvSiuqbmhBm3DkXZQia0ksZmtm++drTPxUMmeVarrWstRl0Mwogl+q1AZMVje2fQrDRHCzs8qvIdUU2YPRqTkyNhghB9cY4lMAhQb+RmV9f/5ouiKFHwBWx47yFQexIS6bdM21z6WKR57it4psVsx0E8YeTUhcaDEA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZY8BNbYD; arc=fail smtp.client-ip=40.107.93.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kMaiBLWKhhsN0qzaRxw2tWMVG7GAOjoAJv04HmU8eDIuFYL6sI9HeYJsTeOkRj1/k3vzdhfxPZ7bHw+OlV8bgcCAhHl1jAStEiBmQaIhaZeVjD5VpSasWZFSD2m6q4sXuqqr9BJcbRvFHyPFE04x5DG29j+hMVyuMF7jUKMGRiOCakyd8PVNxYhNs/GHQCaFUl02qNzPbK+On1Sv+Ierr2yhAo5rCxETOr+aWZhLppNQHtzKlH9qraiyK+h5CKK1Kvopec7In7qX21mLhLGh4iPitBNqHts2HZZaWouApyVMxx2xCzwBqeS4r1+5JjN+SRM7Z1z+F+gyoQO9CglvMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QS+/xu1/erWDNma3r0pJG54Ozn6HCvrv28OolukXEVo=;
 b=nKxc7cXZ+YZrFI6pwvsM84XtmbSudtH+2ExY2umcTq8Blk/qS/yT0W4SnVsIAiuVo6uHPhL9nVejbwD7bz/TbTIgaWS82tTDon4qq9Sl74FQqW5riQ3lpwdKZkoLEdyzWMjkp0CqQGFDc6elw+QlRIdRh51W+VcHLDWXi9iAR/3jn15Az9hNFOZyDjvzqo65ZdGdiQ7cp8meW5kV0dOsodr31wPGFIsW4pjYsW7hs++g5l3KJLJ65JtWYFLCLM0mPpXRe7nflr1gXc40lI7gfNApuxtDmStx+WuvBBeipZqFSG31XdELNOqtFGNdX65HXghYxBBBbdY1iFfqXOSCgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QS+/xu1/erWDNma3r0pJG54Ozn6HCvrv28OolukXEVo=;
 b=ZY8BNbYDpabWdC3PL+JAEthOFHQZ0Li+66Hupqt34Pm4hj+pB+hI2eHvuD3PJ9rpO7GHh4zTnRARMfq40QawR8kXc9zU9/bwucDEEOrN5zDnLKYjwZ3xCJGSL0AFY3KKtwKJ/mHd04qLsql3uNAf3jPlceRrGN4vdpGYSUg3T4Kj9K+7+hg13eBx1hN2TVNPoVtvVblHx2r5BXjmqq7zjXboL+Dj//4x5887mnB1kpeBvdFC7D2ObaG6J/Fr+YDA2T42jaWbJITMi42JDbMzWHVwFE5CjZFX9IooIvWJW5g51zbI2ENHJtpdzJ26PDXfzYk81xJY4o9P4+yYuyg+fw==
Received: from PH8PR15CA0004.namprd15.prod.outlook.com (2603:10b6:510:2d2::15)
 by LV8PR12MB9154.namprd12.prod.outlook.com (2603:10b6:408:190::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Wed, 19 Feb
 2025 11:42:57 +0000
Received: from CY4PEPF0000FCC0.namprd03.prod.outlook.com
 (2603:10b6:510:2d2:cafe::a8) by PH8PR15CA0004.outlook.office365.com
 (2603:10b6:510:2d2::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Wed,
 19 Feb 2025 11:42:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000FCC0.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Wed, 19 Feb 2025 11:42:56 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 03:42:42 -0800
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 03:42:42 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 19
 Feb 2025 03:42:39 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Saeed
 Mahameed" <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Tariq
 Toukan <tariqt@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Shahar Shitrit
	<shshitrit@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net-next 3/5] net/mlx5e: Introduce ptys2ethtool_process_link()
Date: Wed, 19 Feb 2025 13:41:10 +0200
Message-ID: <20250219114112.403808-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250219114112.403808-1-tariqt@nvidia.com>
References: <20250219114112.403808-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC0:EE_|LV8PR12MB9154:EE_
X-MS-Office365-Filtering-Correlation-Id: 8416e6ff-8857-489e-78c6-08dd50da8dc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q1tuDib0msraTKd6LPyiQyYpvVmzSbLItEnc9UVRzCtCq6nDm+fn/+SMFCuw?=
 =?us-ascii?Q?rZtnSIwb53u5JVEymIlBhgYBlo6/3ct3x3h4cGxuVH7LHVoVnJXvQueNSYKM?=
 =?us-ascii?Q?UbkWxbbBdReLqqZTu+tsd3M6H46/AWHHSiAOhyTEc32gZ45hk9SNvJPghquh?=
 =?us-ascii?Q?vt325KOZqzEDTFICUypH5pqwr2mZNxRmS/MCB2YguhRxUnucdSKv1Bg3n/CG?=
 =?us-ascii?Q?HcHNeCRx16FOuc8Fw6sU/mEIAI4jbSeVw2FnANIioacqhLBRsKgCSBWkmk8K?=
 =?us-ascii?Q?kqTeSF1azAVOggQ+nICR0v915Wi7IjaQIk4Mck2MOF5OnMmvJ0k7yMBsrF86?=
 =?us-ascii?Q?OOp+0fiD1Gzi1AivwHHChIsjTBX3CjASZOYDW6vzdm0I6XQQnDzMF15WcVHx?=
 =?us-ascii?Q?U+P/pCRoRaYd2wBPi3PcJ80a1JKcWGfTlTXhzyUwKpFiUnBo25T6H/YmiJ/0?=
 =?us-ascii?Q?cC6qpnGFYeXMW8pNNDkaZEehX/yCCRlr9EPUgbFx4/jHoQiJYkpTFRLfatt1?=
 =?us-ascii?Q?9Xu1Ojz8N7T3GaAO7I78FJwBGPFzBCd8E39YeYTm6hZImviB+uzvHsiCe2co?=
 =?us-ascii?Q?3ObDgRAUfPUkAS4pwh5TtKQYveUPYZTfKVlpspkA04bjlltx5VTXwqZfI33Q?=
 =?us-ascii?Q?sU9X7QBPeCscnLvbDJSVZ+6G598mtJ+CWYvFnmCtc3NWEp/uX4UnEYI6OiV8?=
 =?us-ascii?Q?h+x/znu5my7ae8XlBcHrcSpBHiPbEKqAgS20qHKGP5qlktJDSDNxAmoDEdef?=
 =?us-ascii?Q?oSHIQjkiE0HxccPx/d957mPGv+oZukoFwVBlX4oWcNOb39inVco8Y2DIJpRq?=
 =?us-ascii?Q?ycaBkME1RUf8ZxhLypDfakG1XxR84Hg/gvaSQ78PIiMZCvqBMe0n1gE3dxd3?=
 =?us-ascii?Q?jzHeImZj8FaVIuKY9/qT78PP7HHJqoTswcA4PHxkj+B8oVGVAjhZM7iW+aZf?=
 =?us-ascii?Q?S9tpAFnz4Vtm9TfXCAIrK83skm6iLvVcHpmCccgcfybeaEsiP5Gdaf6saRdW?=
 =?us-ascii?Q?H4BBaBOnvhUkp0AAwT9cYNww3DNUCNU0JpC0hp2S+Gewxfyt+UGgcLUg2whb?=
 =?us-ascii?Q?5XcKT10Uprwrgtfz6T4WfNeTsyur/uEsmAEpyQU4MkxOPC2yVGQB2euLqJJ0?=
 =?us-ascii?Q?+QB+gM3WNJlZIOn9/9/tGClAhGbjt3ryufKXvtNv3JSEbWq3o5SAgx3Vp1ta?=
 =?us-ascii?Q?ai07dz3AgkeEVepTU0jLJrgQWVWFhL1RitR1m7JH6Dh/ci0JpArxqRJH1vjU?=
 =?us-ascii?Q?aV59Y8Ap+2Rnbb0M2Q6TssjjOGoFbt+lzZo8Bc/ZrmGt7pH07aqpdiSYpezA?=
 =?us-ascii?Q?hZ0pgNKjoyNfrOHcukJFO/2oEU3D955mZxWPzwI0gYxsSr3ayQ8NX59n25l5?=
 =?us-ascii?Q?erj0EktM0O3gomW+mkgsvREWlLhCCwbpPXKqC4QwWcGc5gNJdjmzblFsEKUr?=
 =?us-ascii?Q?Pbm30rAqNbXWt2tGrv1KpyW7TwGH46j6AfLxDJX+Na/0KkeMiOn1pCX9S1gj?=
 =?us-ascii?Q?MLNtXcEqeofFsHs=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Feb 2025 11:42:56.6759
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8416e6ff-8857-489e-78c6-08dd50da8dc6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000FCC0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9154

From: Shahar Shitrit <shshitrit@nvidia.com>

The functions ptys2ethtool_supported_link(), ptys2ethtool_adver_link()
share the same code, thus, in order to remove code duplication we
introduce a new function ptys2ethtool_process_link() to handle the
processing of both supported and advertised link modes.

Signed-off-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 35 ++++++-------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index a24bc546e270..6dab58ab50ac 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -910,33 +910,19 @@ int mlx5e_set_per_queue_coalesce(struct net_device *dev, u32 queue,
 	return mlx5e_ethtool_set_per_queue_coalesce(priv, queue, coal);
 }
 
-static void ptys2ethtool_supported_link(unsigned long *supported_modes,
-					u32 eth_proto_cap, bool ext)
+static void ptys2ethtool_process_link(u32 eth_eproto, bool ext, bool advertised,
+				      unsigned long *modes)
 {
-	unsigned long proto_cap = eth_proto_cap;
+	unsigned long eproto = eth_eproto;
 	struct ptys2ethtool_config *table;
 	u32 max_size;
 	int proto;
 
 	mlx5e_ethtool_get_speed_arr(ext, &table, &max_size);
-	for_each_set_bit(proto, &proto_cap, max_size)
-		bitmap_or(supported_modes, supported_modes,
-			  table[proto].supported,
-			  __ETHTOOL_LINK_MODE_MASK_NBITS);
-}
-
-static void ptys2ethtool_adver_link(unsigned long *advertising_modes,
-				    u32 eth_proto_cap, bool ext)
-{
-	unsigned long proto_cap = eth_proto_cap;
-	struct ptys2ethtool_config *table;
-	u32 max_size;
-	int proto;
-
-	mlx5e_ethtool_get_speed_arr(ext, &table, &max_size);
-	for_each_set_bit(proto, &proto_cap, max_size)
-		bitmap_or(advertising_modes, advertising_modes,
-			  table[proto].advertised,
+	for_each_set_bit(proto, &eproto, max_size)
+		bitmap_or(modes, modes,
+			  advertised ?
+			  table[proto].advertised : table[proto].supported,
 			  __ETHTOOL_LINK_MODE_MASK_NBITS);
 }
 
@@ -1124,7 +1110,7 @@ static void get_supported(struct mlx5_core_dev *mdev, u32 eth_proto_cap,
 	unsigned long *supported = link_ksettings->link_modes.supported;
 	bool ext = mlx5_ptys_ext_supported(mdev);
 
-	ptys2ethtool_supported_link(supported, eth_proto_cap, ext);
+	ptys2ethtool_process_link(eth_proto_cap, ext, false, supported);
 
 	ethtool_link_ksettings_add_link_mode(link_ksettings, supported, Pause);
 }
@@ -1134,8 +1120,7 @@ static void get_advertising(u32 eth_proto_cap, u8 tx_pause, u8 rx_pause,
 			    bool ext)
 {
 	unsigned long *advertising = link_ksettings->link_modes.advertising;
-	ptys2ethtool_adver_link(advertising, eth_proto_cap, ext);
-
+	ptys2ethtool_process_link(eth_proto_cap, ext, true, advertising);
 	if (rx_pause)
 		ethtool_link_ksettings_add_link_mode(link_ksettings, advertising, Pause);
 	if (tx_pause ^ rx_pause)
@@ -1191,7 +1176,7 @@ static void get_lp_advertising(struct mlx5_core_dev *mdev, u32 eth_proto_lp,
 	unsigned long *lp_advertising = link_ksettings->link_modes.lp_advertising;
 	bool ext = mlx5_ptys_ext_supported(mdev);
 
-	ptys2ethtool_adver_link(lp_advertising, eth_proto_lp, ext);
+	ptys2ethtool_process_link(eth_proto_lp, ext, true, lp_advertising);
 }
 
 static int mlx5e_ethtool_get_link_ksettings(struct mlx5e_priv *priv,
-- 
2.45.0


