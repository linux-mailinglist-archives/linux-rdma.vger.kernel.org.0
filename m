Return-Path: <linux-rdma+bounces-8540-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ECDFA5A62B
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4C41189453D
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 21:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6931E1A3F;
	Mon, 10 Mar 2025 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="PcQMr5gS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3551E105E;
	Mon, 10 Mar 2025 21:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642093; cv=fail; b=E3b+v2D8zwP2wsK6ZSJ2epBHypc4MmcdQxpAYBeHRJdXDw+0Ia1gR6PhLyJUGhNh4jyElVCzm7czAb2BWcsM4KubqE4DxNwHBVEtrQ5VMzViNIfE1i6HPJvxHHo4z/CzXXbYF3ANsRPwBPjaZwruW8u3aDGCDRwf6IwV/laTGwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642093; c=relaxed/simple;
	bh=9rOCnpkskcmBArRdBbxkAgboZxv6B1PsQaZ0dQh1H/I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r2/MT1FBokrA4bGyUjt6Pd+XAsbR9fJlEp9cevcSNHNpJ7etEiqdbjQ/ij6zW/SLnDikJMdDVZEBM/W+zTW8fBrwX8cNzjf9U9yYjgj+xzHQKh+ZthAmrtf1gVwN0LULvpnuk6uSne62E+yZzmUtm1qOwfzgdAkqVl9gav4vzys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=PcQMr5gS; arc=fail smtp.client-ip=40.107.237.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qXB3k3Vv7uQ0iVs0SZYUSqS4M673D2LYgO45Q764v0bMA2QgbWtvMpPwZ/UA+H9eorT94mswTr+BApNS/maE7osGJelnrcozeSQUZWntT6u/af89qMPxMyux9hFvTGcGl9Wn0uTuLqfbdjDISdSPZByZGa/1/TloVO+oDcSVGudC5h5tcRov97OzcSIx8F6+S6ZS8XI8NaEDG8fwIuQLdMkvupvH88iawxuEcTOEIie50aHC4T50oy84XrPooBpJpw/dgxe/bru1FjhUXyunqTto78Ehy8XZmzbgo7nTHKRG1TW/cDMexGWn3ZAkVa8ibABa9ky7wvczCtEqUjGjpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zzlFCeuyRwkNlFfYu+td4y3TitB/gk/XjZI8PsY+rpQ=;
 b=qM4PKPNJI0Vgjxivo1pL0rUrSfvcGuQAown/gO1j+lw1GgRF/NPcKNgqOU+0mLi7N7ypm0Y7DxIag/OvPNphzyTzBj2Ei2I/JCEdnuqoVSk7pp5jcGypzPyYVDI27QtssgS+vC3tbvSiCD42WaG3m58wAx09yMi0rJ5HzI0WH8u6APY2SF8AIB5oqGOtqdq7AF5IegzmqTfWTvmxLIn5p03mAOU33r86oVSHrcHHOZOEAQ1mxs8A48LDzVy6vwa0X8cgACsTzMjI8p+NqrC9wrNVa7AkLM+lKtmHZim1H6HHcXxRfhs8AV+9p+DvSELmyySSVru4rvCBwQuvCQRP3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zzlFCeuyRwkNlFfYu+td4y3TitB/gk/XjZI8PsY+rpQ=;
 b=PcQMr5gSVbhXW3eXJ4Tj3Q9oW/ygyN9DbBihH9DfArVwa7VLE488O5l6qizcYPhOqMJ4nGKFUhcM2YzaYByR2b5ablQAPX0HYX86s56ra4as4UI26Z9B+KLxhODdP0zwYvJyfpLOcvA+LIX2gFPIWVN5ghpCoyZRcQhnaI0POjR3O3KbaFGuXiWn2PO11+9AZbSHruzS292hDlCJpPC4O36ncqw08dwgy4x+m6IZh7CJUZAT8PslDJH7s7ZDwd4TcOuu5L6wm1+kJ6w4pTVU4WIGi66o9b+Mjtc7L3yC5r7u1JR3rY/Xg1IGze2JVy3RX+YiPRYFDZSt7anlpcwluA==
Received: from MW2PR2101CA0028.namprd21.prod.outlook.com (2603:10b6:302:1::41)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:28:05 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:302:1:cafe::e0) by MW2PR2101CA0028.outlook.office365.com
 (2603:10b6:302:1::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.14 via Frontend Transport; Mon,
 10 Mar 2025 21:28:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:28:05 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 14:27:58 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 14:27:57 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 14:27:54 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
Subject: [PATCH net-next 2/4] net/mlx5: Introduce hierarchy level tracking on scheduling nodes
Date: Mon, 10 Mar 2025 23:26:54 +0200
Message-ID: <1741642016-44918-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
References: <1741642016-44918-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|BY5PR12MB4274:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b85fb42-74bc-4ba6-9c5c-08dd601a71fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VXVCc2lIMFFDK3BHaHUwTXh6bGw2L3pNZjRFV0kxSFRnbmV1ekk2cGhwOEtH?=
 =?utf-8?B?c2I4WDVNWkR2NWJQcmMwRDZzNnlkOUl0YWdwUUZkeGhkVTJ5eXJ6NjJYMlRZ?=
 =?utf-8?B?ZURJWTlsOXYyUWJveGlZVEsvZnIwSjdaS1BtOTdOTjZuekw0T1FNS0Z6VmV5?=
 =?utf-8?B?UXo5aVF6cmRIL3UxU0l0eHJkOVlBUFRZZCt6YnVMSE5FblZxeG5qdWxLVGRl?=
 =?utf-8?B?SkUydXNWUE1WTE5kVEN0VFh3S3NON0VaQUpyTXduNXFsRnZtbjNqVjZaQmZZ?=
 =?utf-8?B?T2V2elQ2U241UW9FalcwOWNhRnBkYkp4emZsVU84cWRLRzUreVpKQ295Rko0?=
 =?utf-8?B?eEx3ZXpOclViK0hsL0JGZlRLTU04UEZ2YlF0Vy9remJZcHBmOUI1OFI4aVhL?=
 =?utf-8?B?YXNkRHZRL0doOWZuK0kwelRyeG5mZktJS0lpMktDd1pPbVpwVHpZZTZKT3FX?=
 =?utf-8?B?V3p2cHpaajhzeUJiUUxOUVcvNlN1d3hEUjhrdkJ5eERRODRFeVY3Z0xQMERI?=
 =?utf-8?B?QzR4THBWbm1nd29pU0MyUkJxbmY1L2VCWG9XdzJCaURkZ2VlQ0NoRklDZXR2?=
 =?utf-8?B?eDBFWUxPZXIwQlhqSVgvQ1Ura1pIOGI3cGVtbnNCRXo2QmhnRGVnMHZSWFdF?=
 =?utf-8?B?MG5rSFJFYVFTOERoc2dSWUtPb0dRRk15UWVOQXJRbzgyQVZmOFhZWUNPT2Fo?=
 =?utf-8?B?U2dDWGMxbEIvb1ZBVll4UWwvTUJpdndHdllUUm54WnhJS1Exb3IwcU9OZlBj?=
 =?utf-8?B?T3JmS3VKWFZjRUFuaFBtTEFyNGJDZ2UyeFlsK2tmRENGaFMxSFd3Q1pGcVJM?=
 =?utf-8?B?TGpSNkU1S0xsVElPdEZZZ3dMTm5MSm05Wjhpcnl6b0Y1SmhWYW43djJWZGhL?=
 =?utf-8?B?eDFaMEFGZGFUUEZLb0JxWUFjeU5vMExLVTRpeDRhRVFnWC9wVGU4dkNXQmhp?=
 =?utf-8?B?aFlabXpHekRVN3hBY2EzY1lhVjg2TUVXa1IvNU1SZ2k4NUhPU3FZNG5XMVRw?=
 =?utf-8?B?QVJEY2dHbnRkTXNIQWNyM05kc0JSMEZxVmVJQVpUUWxVVEdLMVd2aGEwWDZZ?=
 =?utf-8?B?U3dZeWRhVXdlT21NdUxVZjN3ZHo4NXAwWkVWWUZjOVRRWWZITGJYRU5Hd2Jl?=
 =?utf-8?B?UjUzSE9kWUFHekJNcUNvT2tIUDgyR01iMnhhdDlCV0RSd3ViVktZM2hhOS9x?=
 =?utf-8?B?OGJtbzF3eXFBVk0ybDBHQktLNkNLWXNsMU1YSWlEUjd1M3l0TTVlV0ZhczVL?=
 =?utf-8?B?Q21PR285UkNVQnFPQkNIcUluczM3VGVrRStiUFRrSUlRcG1qYk82SlRNVENN?=
 =?utf-8?B?dHZWeE5zQUROd3NTeUFMcVlHRWZxdE1udzI1ZmYyUXRnRFpWb0VZTG55dUo0?=
 =?utf-8?B?MEJtWDUza2hKcGRIeXkwSU9QU21UVlhuZWVpNnhYMUlJQ2syYlNIbFRISXNZ?=
 =?utf-8?B?TkVhZFdPbkpFVlJXUEFmeFBobTcyRGdGQ2d6VmV6N2g2YjhYUGJjVHQwTFZC?=
 =?utf-8?B?TzlydDZkQ0NzSDJnVS81Skh4YkVDQnBXcmVhNzNCN0JwWTVsNmxoNUdoYmhr?=
 =?utf-8?B?KzRKeW9JVUdzZDRkemRqdFZaMFR3ZWVtc2FPeVNEMmtNVUxVRWVWVmc1WmZr?=
 =?utf-8?B?eXh2K3NIS0xlbTZmM2plRnAyNE8vMS80MjlGZnFRME8xZ1JEc0RyajlEOG9y?=
 =?utf-8?B?M2UydWh4c2RRMkNsTTVkRW9CeU8zRmFKRTdaYTByNHpGMVpKTGI5c2UwMWlO?=
 =?utf-8?B?VUs0Q252dGVleHpWQ0RQMWpmUWNYeGpKQU54TFdHT3JNUmNjZ3RKdlNPZnd5?=
 =?utf-8?B?aVZBTi8xOTVRQjI0Umh2ZkhLZ1h6V3hXN1gxdy9RRFArd0JPaW9GRTY4TGZ5?=
 =?utf-8?B?RExlYW5lblQrQUo5S0JyWGdBL1R5V2Z1VjhBZFI4QWRoVGlqNHlMb1FIVEhO?=
 =?utf-8?B?c2FuYlhXOTFxL1N0bno0bHJ2NEs3VVl1KzNPSkp0REtERUlxWVJPRmlkcU9X?=
 =?utf-8?Q?W5HiZYuUk5p8AmqP1zVo8Wp7Nmvi/o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:28:05.4184
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b85fb42-74bc-4ba6-9c5c-08dd601a71fd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274

From: Carolina Jubran <cjubran@nvidia.com>

Add a `level` field to `mlx5_esw_sched_node` to track the hierarchy
depth of each scheduling node. This allows enforcement of the
scheduling depth constraints based on `log_esw_max_sched_depth`.

Modify `esw_qos_node_set_parent()` and `__esw_qos_alloc_node()` to
correctly assign hierarchy levels. Ensure that nodes inherit their
parent’s level incrementally.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index c56027838a57..959e4446327d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -90,8 +90,22 @@ struct mlx5_esw_sched_node {
 	struct list_head children;
 	/* Valid only if this node is associated with a vport. */
 	struct mlx5_vport *vport;
+	/* Level in the hierarchy. The root node level is 1. */
+	u8 level;
 };
 
+static void esw_qos_node_attach_to_parent(struct mlx5_esw_sched_node *node)
+{
+	if (!node->parent) {
+		/* Root children are assigned a depth level of 2. */
+		node->level = 2;
+		list_add_tail(&node->entry, &node->esw->qos.domain->nodes);
+	} else {
+		node->level = node->parent->level + 1;
+		list_add_tail(&node->entry, &node->parent->children);
+	}
+}
+
 static void
 esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
 {
@@ -99,6 +113,7 @@ esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_
 	node->parent = parent;
 	list_add_tail(&node->entry, &parent->children);
 	node->esw = parent->esw;
+	node->level = parent->level + 1;
 }
 
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
@@ -358,7 +373,6 @@ static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *parent_children;
 	struct mlx5_esw_sched_node *node;
 
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
@@ -370,8 +384,7 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	node->type = type;
 	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
-	parent_children = parent ? &parent->children : &esw->qos.domain->nodes;
-	list_add_tail(&node->entry, parent_children);
+	esw_qos_node_attach_to_parent(node);
 
 	return node;
 }
-- 
2.31.1


