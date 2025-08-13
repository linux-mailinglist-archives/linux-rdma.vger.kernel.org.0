Return-Path: <linux-rdma+bounces-12717-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AED09B24C01
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 16:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FA777AECED
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Aug 2025 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297DA2FFDE4;
	Wed, 13 Aug 2025 14:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZZS203SP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2089.outbound.protection.outlook.com [40.107.102.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 649B32FFDD8;
	Wed, 13 Aug 2025 14:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755095546; cv=fail; b=J94frTryFgf+AnrsCnGhL4nAQZGjaiUrKzVpJQASL9guyHgOVTrpHlYz8znVEQEzIZ+gyN7EX7pXVLBeiGSMWez9VWjPZDONxR4Ihx4uF2rIPwTijiDRw1s55g7IVEkyizC7KC0nkqmL2O0d6r3gjLAMHQW5Vug7WVM9SqJKQgw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755095546; c=relaxed/simple;
	bh=sSYH2XUAqdVcASWibtzTfWdeYJ6zjYzMz+EcEfCdKL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gkpb/i/LRkLxXeGOTMFHTIJLklGLxKgc+Yd2ss8xOlFcQXlnhGq/175pztVQwPPhF/fO3BQLgYI2ctwZ7XnvHyozABwh4WuTHH8gNmjnTzPfeWBHgHM9hBzRMxzahFkUHfh48r6ApuULD/AvgRdkW/8dpp0U6ushi4hqHohBf8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZZS203SP; arc=fail smtp.client-ip=40.107.102.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d5P2+FTasuD/fkDVRYGpKhDBKyKhNRSC5RIvTqKnNmFNBvVxhFCSz2HPYJPdJSoMAbUcTMMHdT6eKnXZ1aFPCZAxSH+ONDe9WmH3HuKtYwHbHX6xid73E1cmmn4SoVqbN7C6feYn3hwUxLq44E95wTmF8NCy8s9lVGHzSH69DaWxmBwvpZaWLXJSP+7Gxn52b9quIgdnIHfEDOaEGVwrdaD3MTzcAd6dVKojCd2THG5HtUtE5eIcY8b/71wKUbjl1wPONmHkmD0GqAdY3IiN5Qbc2mPZbSb58Fz3ghVlmppHlFpFzUNdMzMZ/1KhDvuAw+jClluNysT2rOFOIaBDVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yED1mEZrh4cDa2M7GlFr3hXzgNLglVismLwC6YinYow=;
 b=nSn0uP0Ep2ve3oLP8BJB0MjM8sJB1qrYy0rll8EkGZNGwLtqf/n+R6JbfD0I6AcLV2iF3QhcoJa5Ryc3/ftLqz/lqwp6SILUpriFC8oKROYYGbZYU8JtrTuMelkkr8vefFOYw0Z/D0D7hzSfZDhz/Kk5u8U4uPqgHuLSTAqsmGfYdeku8NyuBfAipCZ8Ac75dR+iyVRgZj4uQtuofjKrV9HpRXXD5XXtH27knpjhzTrTH4PpLijinDPBXGJslEFYZMgCjXRD1HGPjkUCVnng7gZkd9XsH5s3ZvVW519uJjrFR7tZpBRrcFlA6mKasRV8i+SMERIUNDKtCbF4au2zZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yED1mEZrh4cDa2M7GlFr3hXzgNLglVismLwC6YinYow=;
 b=ZZS203SPuBML64546hTAfU5pZMtihVQqAoiexJ90G7ZBsMVmdb5uv5hAiob41JERM+Xn5OrxEHFftqj2eEBkGnv/tZ3KlX3JbF8/nlLxlrPsiGqJLXSpn7MnNkdqz7judfNP4/gvZUO3nkd2wiy+mN+kE0OeKtJngODT+ZI+rejVUItAexYozktTebQbesmKfQRu1Inv/g+eOyd9TtGZJYSHiLQ18sdD0+1DJhb0/jG5MjxRtDBkDvisEXcBqdzOwUmgUIVazs7LIthK03yhe7EEh3YbY16YCjwnm/Kyt4ZDs1LIqqWmtveFU8E8y7EqX+LbJaRez2Omyb4AfmEAnA==
Received: from SA0PR11CA0058.namprd11.prod.outlook.com (2603:10b6:806:d0::33)
 by LV2PR12MB5896.namprd12.prod.outlook.com (2603:10b6:408:172::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Wed, 13 Aug
 2025 14:32:21 +0000
Received: from SN1PEPF00026369.namprd02.prod.outlook.com
 (2603:10b6:806:d0:cafe::42) by SA0PR11CA0058.outlook.office365.com
 (2603:10b6:806:d0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.15 via Frontend Transport; Wed,
 13 Aug 2025 14:32:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SN1PEPF00026369.mail.protection.outlook.com (10.167.241.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 14:32:20 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 13 Aug
 2025 07:32:00 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 13 Aug 2025 07:31:59 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Wed, 13 Aug 2025 07:31:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>, Carolina Jubran <cjubran@nvidia.com>
Subject: [PATCH net 5/6] net/mlx5e: Preserve tc-bw during parent changes
Date: Wed, 13 Aug 2025 17:31:15 +0300
Message-ID: <1755095476-414026-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
References: <1755095476-414026-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026369:EE_|LV2PR12MB5896:EE_
X-MS-Office365-Filtering-Correlation-Id: 268951eb-a977-47d7-da23-08ddda76365c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PAizV9f2+UH6rvVD3YYavHEPq2D+TRkSZyN80DdJrxo+tXWNzgYUH8K4RJlm?=
 =?us-ascii?Q?AL6uKBr04KhHBpV/45dXR9L0t69H/wmuR3TZeqYCnqdPp1Uf9JMpk8CkL8co?=
 =?us-ascii?Q?OudCQhFKY5EVhDPXybbbOLyCaGKrwirz23TJU3ZUjmdjDRjtLJL2pGWg3KJr?=
 =?us-ascii?Q?pKLF6fH6NcEKmgb0TnUDYTc9gOO+O07kQcAEFN+ZKNm7sCFlxevR9NooZ/Vo?=
 =?us-ascii?Q?yf3O7WvJ6bm29i9wQUDUkmZWjdu/jxUeiUKjm3L+E52YJjqVC73XpF7R5XMx?=
 =?us-ascii?Q?3XNqCsHhndaaQySaWWu4CDgVLFQ98CHaUxrmcEa3aGsfvP1sQdOsdHC6vwH7?=
 =?us-ascii?Q?6zSEjBCa1vfqQysoJgdplD7jW6fiXYXiMZeES7GJUWuZuZPlAj60NP4O5dwQ?=
 =?us-ascii?Q?FgjVvm203xJ9kayUZ462nrQM/UptrPbWZL0w47T80572ncIK0jrgYPqksN7t?=
 =?us-ascii?Q?kZBdaczZ1x87GOTuD5C0K1XBegV8X+7GEVAeiB12CmTK1NUJq+KvnEZo9HXP?=
 =?us-ascii?Q?JJXhR5vNRUvXn9spcplNCYEVg2KioPjZasVzbmuKI1ylZGGcJhAn+H1JQj59?=
 =?us-ascii?Q?pTHxn5XiqWjyfyVPDcCpDH3a4/3zoNCikVGMHslh7lNSluI7psQiLag64HFf?=
 =?us-ascii?Q?0tzIl/Kobu/x9Qlpxn46s1q9X/gPcPvwCyjr33YGSpsI5yICk4LImR6YplrE?=
 =?us-ascii?Q?rOgI5dW1eOvQ3mBNNz9eR+E1Y/67sBRyjcZJe2fH06zKO8SocGFZGSU1DJYB?=
 =?us-ascii?Q?TfsIUbQxUOE9Ny98kATcj0ThhewDommWFRckYDSyW47ek3hpmJGIjwEdCfIJ?=
 =?us-ascii?Q?MWeqQapVEni4i+RIDmzbeTd41sSG6ppViNw61HHCrJbKWXi2Npk7rmZbekjo?=
 =?us-ascii?Q?o7LgAgFa2xjX6k15k72XIk2M4dSYz2uQYxnc6j/22BT+9+9BwePJWEEAj0x0?=
 =?us-ascii?Q?Eszyjx6Y00NKoNCNB549h77tRxRneaULrrsQpuoIiqRVu0+TufpN+in6Qm30?=
 =?us-ascii?Q?g3FL16J59SMmVHfHWEH2R0cCB2KVoT8rP6yPxr99yhYGc8jCQ5z/JopH1Kmo?=
 =?us-ascii?Q?28RF0jrDYhbVaXuiIlFLN4t90Hb0YVxtKAh6SNlgbSPkf9hH06A693M09RVL?=
 =?us-ascii?Q?2T0gV4SnIUQykx29OZNQcYmk5Cbycu2YMeOKRgJt/weovHNxJJucvPYzDUw9?=
 =?us-ascii?Q?Yw0gTW6PJ8yETxRfbBnUwvF0mgH90hTWogqHuRGUQptTxCTSPnqlKZO90vkj?=
 =?us-ascii?Q?9pdzNx5Hno59OkFsxZM+7QHCRZVJypsLw9u8UwembIFt5PHTihveDTQXIDJP?=
 =?us-ascii?Q?7msUdBGrc1TzsMlYqLeoCaOFcUEBRJsXd4byK+Fyd/weZK8i4lptx40Qd9gb?=
 =?us-ascii?Q?TIgKFDPfTtHu8wAEDveOxLFNLoJ9HTCgQHo4TKyP/jd+NuaRZq/XiSX0qfbq?=
 =?us-ascii?Q?nTHGzPGm8y2GdbxV/fOJi6UGMCcx/8nSA2Os8/3LIRq15nclRsjhN6FenAHo?=
 =?us-ascii?Q?i4U3X4fvWeiYBsslJta6CdWOwaKvWbgFZGVy?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:32:20.8270
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 268951eb-a977-47d7-da23-08ddda76365c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026369.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5896

From: Carolina Jubran <cjubran@nvidia.com>

When changing parent of a node/leaf with tc-bw configured, the code
saves and restores tc-bw values. However, it was reading the converted
hardware bw_share values (where 0 becomes 1) instead of the original
user values, causing incorrect tc-bw calculations after parent change.

Store original tc-bw values in the node structure and use them directly
for save/restore operations.

Fixes: cf7e73770d1b ("net/mlx5: Manage TC arbiter nodes and implement full support for tc-bw")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 811c1a121c03..e774f6fa3377 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -102,6 +102,8 @@ struct mlx5_esw_sched_node {
 	u8 level;
 	/* Valid only when this node represents a traffic class. */
 	u8 tc;
+	/* Valid only for a TC arbiter node or vport TC arbiter. */
+	u32 tc_bw[DEVLINK_RATE_TCS_MAX];
 };
 
 static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
@@ -608,10 +610,7 @@ static void
 esw_qos_tc_arbiter_get_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
 				 u32 *tc_bw)
 {
-	struct mlx5_esw_sched_node *vports_tc_node;
-
-	list_for_each_entry(vports_tc_node, &tc_arbiter_node->children, entry)
-		tc_bw[vports_tc_node->tc] = vports_tc_node->bw_share;
+	memcpy(tc_bw, tc_arbiter_node->tc_bw, sizeof(tc_arbiter_node->tc_bw));
 }
 
 static void
@@ -628,6 +627,7 @@ esw_qos_set_tc_arbiter_bw_shares(struct mlx5_esw_sched_node *tc_arbiter_node,
 		u8 tc = vports_tc_node->tc;
 		u32 bw_share;
 
+		tc_arbiter_node->tc_bw[tc] = tc_bw[tc];
 		bw_share = tc_bw[tc] * fw_max_bw_share;
 		bw_share = esw_qos_calc_bw_share(bw_share, divider,
 						 fw_max_bw_share);
@@ -1276,8 +1276,9 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 				struct mlx5_esw_sched_node *parent,
 				struct netlink_ext_ack *extack)
 {
-	struct mlx5_esw_sched_node *curr_parent = vport->qos.sched_node->parent;
-	enum sched_node_type curr_type = vport->qos.sched_node->type;
+	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
+	struct mlx5_esw_sched_node *curr_parent = vport_node->parent;
+	enum sched_node_type curr_type = vport_node->type;
 	u32 curr_tc_bw[DEVLINK_RATE_TCS_MAX] = {0};
 	int err;
 
@@ -1290,10 +1291,8 @@ static int esw_qos_vport_update(struct mlx5_vport *vport,
 	if (err)
 		return err;
 
-	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type) {
-		esw_qos_tc_arbiter_get_bw_shares(vport->qos.sched_node,
-						 curr_tc_bw);
-	}
+	if (curr_type == SCHED_NODE_TYPE_TC_ARBITER_TSAR && curr_type == type)
+		esw_qos_tc_arbiter_get_bw_shares(vport_node, curr_tc_bw);
 
 	esw_qos_vport_disable(vport, extack);
 
-- 
2.31.1


