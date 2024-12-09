Return-Path: <linux-rdma+bounces-6357-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C69EA0EC
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 22:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84C0018887A5
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Dec 2024 21:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0F5E19D06A;
	Mon,  9 Dec 2024 21:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kNXUiUB9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2046.outbound.protection.outlook.com [40.107.237.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A959419CD17;
	Mon,  9 Dec 2024 21:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733778812; cv=fail; b=rhcVa7RgKWpca8/oRPj/BiC45XJNmwcXoJ2K9sy+TzABxcvuBHI+CXDhlhOLB2nubJBVnznXcbBlbFYW+VDleu+YnwrFl9QYWOoJAy8YDAbpUO3LPY2/awvbr3dA95ONTN1J95/F8Nn38LPSLpm5k1nQda6GcyyImMpAHd3oqlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733778812; c=relaxed/simple;
	bh=FPuvYi9r0lQX3bfQkfNbraHml67mhEjEYOCQHOXl6Wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ialgyc3IRu9LcJPJ5pBJIhjg1cixT1Heu09s0Bdxsr3SGyfugCTJM/kAo2JtNOxzEVEP/NK3xOMKGIhtayuNe58XazpNdpVeVqmEFJsoq/NPa2WO2RIo1+/kq14xX8mxHYHw+UUIJbPXFoObGjI/Y7wtdbGDKVuprhShAz5c89c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kNXUiUB9; arc=fail smtp.client-ip=40.107.237.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DkLhdUJ4LsVfmPNRNptb736lwlISqtvPp3rcZu+yTTK5ToEwbu/yVGHWu4GBfZAK7zPqUMeuWf3zDWvWJODJpUeoguM9KRsxn0S3AJJ6xfZGcFiP1oadxCDCMlV2irnT9oQiq1QhM/L48WZELnoHDWjhQyt0b3tVZdkljZZjOYcagVkTni5yWgHI4ujMq2cuX5JlYe3CutkkZsdyzoMAY5dMfeV4ASvI5NpMEFStGAmw9iBFYu6HRLpKH/Amxtx2JiV+cSG4I9pEXkuBU7CQlN6tVhH5t3t56aRkjoKW3fRsjf4Tq5cokmJwHFzE6xRvgD2UIWRa/0LyVcdIW/BIOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4E+XFBH9pCyxc0EKw76fyVXGUiE49BhpfBub6y5Ds=;
 b=sy/qHTIVVtsVKfFhVm1Islu7TLVg9ffK9dBQCMOqPwEuOEsdUzu/VIAGxwXo5kkDLGlQF23LK/sX7JBd54agISeoEz1EIi0cp+FiU+RaJAog06C35HOFvsQSZkpsd9ky6D7ARZZHeNdAnvTZGX5bLq7GhwpUBx4PSC2f4g3I6cCFrFd8eT6jwxXuzfSt+EokTLF1P24sWHUrSrdgjpgYEhfVj7+dExCEH4eCRne69/kkkf+onO9twuWS+jiUT2YBhvWrWBgFwWrNqsMZxt/4JOjoOQcDzvbqdrJDIkE4WZWxgqWiqp5nIMk/Hxv67RzTl6QMC3fWDGgoJDu7ZkY2ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4E+XFBH9pCyxc0EKw76fyVXGUiE49BhpfBub6y5Ds=;
 b=kNXUiUB9uziLz4SgOdqCErBqgZSQ4IjSG54gJhTlHbmcwRk9b5ipQc02OExTiPA8qMdUmVH+tN6B95QDY3X+oTDms8JNLnkJZ0EzEoLi5GMnpt/sjP43jhqZiY7U1l4BOz0LuQw1TyD0E4EYR2VdPI2lQCsCTcmu/kga7k3Ixy7KLGbBcFUp/dQNhOjvWPAD32VI+GPinR7eQekvV3W893KWh6axoAVpFG95l3cdKQ85+t1uBZpdCYtRkAF+LwQQbLdMnOZnD2BDBlo8P7cjtzQE5xgCZWoIibN3JFM4Sz38Fuieh85LyHg++8LfeY3UxcHYABNXaJtBMg6I6F+NnQ==
Received: from MW4PR03CA0036.namprd03.prod.outlook.com (2603:10b6:303:8e::11)
 by BY5PR12MB4193.namprd12.prod.outlook.com (2603:10b6:a03:20c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.17; Mon, 9 Dec
 2024 21:13:23 +0000
Received: from SJ1PEPF0000231E.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::e7) by MW4PR03CA0036.outlook.office365.com
 (2603:10b6:303:8e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 9 Dec 2024 21:13:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF0000231E.mail.protection.outlook.com (10.167.242.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 21:13:22 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 9 Dec 2024
 13:13:10 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Dec 2024 13:13:09 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Dec 2024 13:13:07 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V6 5/7] net/mlx5: Add support for setting tc-bw on nodes
Date: Mon, 9 Dec 2024 23:09:48 +0200
Message-ID: <20241209210950.290129-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241209210950.290129-1-tariqt@nvidia.com>
References: <20241209210950.290129-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231E:EE_|BY5PR12MB4193:EE_
X-MS-Office365-Filtering-Correlation-Id: d85c3be2-c129-4ab6-a80e-08dd1896502a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGVTMEtqd1FVTE9VTHdVaWhNV0NzV3hIbE1HanlWejFkTVpOWExaS0h1SHdO?=
 =?utf-8?B?blVES2JtT2FuM0FCRGRNZHhpbTVwMmQ0NTNYSkxsc0Zyc3FMOUp6SzBzY3dI?=
 =?utf-8?B?eDVReDVHaVZqSDBKUzdnc29tbFB1VVR6Zk1IVFpmdm5ndzlzOW1qNEEyU3dL?=
 =?utf-8?B?ZVpaZ1lxbkhZVXdwajJWUHgxVS9kNmZLUkw1V2Fvcnh2bXFWZXBuM2pXNXNI?=
 =?utf-8?B?aTdUSDlha3hmSU1OVThFRzlkbUNJWXR3Rkg1S0xGNnhqZU4yRUdING5BYUsz?=
 =?utf-8?B?V0FwMkxzR1dIYWo4OG1wYm5ldjFQQ2s2VCtLZkU4d0w4T0ZrVFovT2FZSi8x?=
 =?utf-8?B?cXZpd2FGSUppdE51WWFCeXZyaWt4aVU4ZWROQkQwd0pucDFHMFFGc05hS2Fi?=
 =?utf-8?B?WjdTTW1XSVBaRTZPRVVJaFlGa2dpcUQzVFFaQno0MDhZUEIvdGNzb0d4bTZp?=
 =?utf-8?B?RHZWYmp1bTdNQU9ycE1MSjhaaE5zeEx0aTA1RFJaSUZQZlYxZ3pRZFAwV2hH?=
 =?utf-8?B?QVc1VDhkR0lJY08rT0FGdGRYRXBtVWh0bklSNlJBZWtReW5EWElEbE1WNEZp?=
 =?utf-8?B?aWk5NURkTmQ0TXNHalZWSGZqZHptZ1hBK241RmhRZG1zUzNDeUx0V2k3WC9n?=
 =?utf-8?B?ZjJET1J0ZG92NkFBbHByaTJUUmI0dWs4SjhNaXoyemxINWhiYStGYmhKSnY1?=
 =?utf-8?B?WEpQRFlFMkxQTEUwZUhwdzQ5SFNxN2Y1L1JRSjJrZTlxSWszWEhpaHU3U2tS?=
 =?utf-8?B?V25DVVozdFRIUUJySDYvZlhVS2c2dE5ZdmlqNk10a292TTYwTGl2dmFXc2gz?=
 =?utf-8?B?Z25icDQ4aytqc2N3Qk0xQWZZdmdHWENoaCtwVTFqU1BiSmJTQ2J5NG9NSjFC?=
 =?utf-8?B?STlyb0xmYk9XL1hadUNtZUc4Y2FuVjFFcWgxWFl1cnJSbDdOVjExNElueHcx?=
 =?utf-8?B?R0lTREd1ck5uaE9aV0lkcHFwcWx6TkRuNERLcGdOc2NuN3RXeDNTQ3FXckRk?=
 =?utf-8?B?SE5XMjdETEYrd0tkT245NFZyUFFGdWR0ZWhwTGNzaDMrSWpBWmg0RWU4Tnhm?=
 =?utf-8?B?NmltdytlNFVtQ3k3eVM2dmVSVndDNEp0aDQ1bnlVWlppSU9WWXM3WlJ1MUVR?=
 =?utf-8?B?bUtWa0ZyazNkY1FyNEYvQkY4dE1zNHl4cWQyZmZDTWc0Z0pCRlo0NG1STHFS?=
 =?utf-8?B?M1R3SnRBRThYUnpjUWFjK2JHRHRKNlZ0ckczNU5kOHg3SURvRFJ4OHk4SGdH?=
 =?utf-8?B?aldieUdTOE1rRFlQdjJqY2YxZUprbElBN25kTHd3dTZNcUFORElIazFjZUd2?=
 =?utf-8?B?ZlNEVGk5YWE5ZEh4ZXlNRFpManV5QjBYWmpYUTNMTXhYMmoxUWVjZHdncWsx?=
 =?utf-8?B?bUtnVkNHR1JxVEt0SExaYm1UL0lJQTZZbmdYcU1OKzhZbVpDSWRiV2dvQjg5?=
 =?utf-8?B?c3A2R1VWRWlnQjRDcnNFeUhMc0JTeGUvOUZ1c0dqMHpIWEtIbEgvVWsrOE5o?=
 =?utf-8?B?ZFh0L3MydmIzQ2pnZzhnMGd4Z3ZjR1c4SmV5OVYyQjIxdFZma1JFakFSMnN0?=
 =?utf-8?B?N053aGZTWXZsRy92SnRBQU1SalNQSTZYRTJ0bXlhRXRyaWFvTTd2dW9aelBm?=
 =?utf-8?B?S0phQXNYbVFObDl2RjlWbE96U2c4TmNnK1MvN21ERmw2MnZINEU5dzdkd3cx?=
 =?utf-8?B?ZzVuVC9kTytiYXNsQ2Z6REpaNHFOc3U1MUZyRU4xazFGc3pnVzBmUWtxZlZl?=
 =?utf-8?B?Mk9oZVhEZ1IydmY1TGdSOVFwenExbWIwR2M5azRSRzdEYmJMK25zcDZJdFBv?=
 =?utf-8?B?Q2VFaVJ1WTJUOFNCNngwQXBqZ3NGRTE4dDhFYW5ZbHdMbnJFeVpWMFJheTBj?=
 =?utf-8?B?ZnN2SkYzcEZqeUxITDJKRWhJRExWQW9LbjZ0Y3FVbXAvR1hpbDM0eENIYTVm?=
 =?utf-8?Q?glypyJX4tsBu6FVPpjkdxBMHG0O5h2La?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 21:13:22.5456
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d85c3be2-c129-4ab6-a80e-08dd1896502a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4193

From: Carolina Jubran <cjubran@nvidia.com>

Introduce support for enabling and disabling Traffic Class (TC)
arbitration for existing devlink rate nodes. This patch adds support
for a new scheduling node type, `SCHED_NODE_TYPE_TC_ARBITER_TSAR`.

Key changes include:

- New helper functions for transitioning existing rate nodes to TC
  arbiter nodes and vice versa. These functions handle the allocation
  of TC arbiter nodes, copying of child nodes, and restoring vport QoS
  settings when TC arbitration is disabled.

- Implementation of `mlx5_esw_devlink_rate_node_tc_bw_set()` to manage
  tc-bw configuration on nodes.

- Introduced stubs for `esw_qos_tc_arbiter_scheduling_setup()` and
  `esw_qos_tc_arbiter_scheduling_teardown()`, which will be extended in
  future patches to provide full support for tc-bw on devlink rate
  objects.

- Validation functions for tc-bw settings, allowing graceful handling
  of unsupported traffic class bandwidth configurations.

- Updated `__esw_qos_alloc_node()` to insert the new node into the
  parent’s children list only if the parent is not NULL. For the root
  TSAR, the new node is inserted directly after the allocation call.

This patch lays the groundwork for future support for configuring tc-bw
on devlink rate nodes. Although the infrastructure is in place, full
support for tc-bw is not yet implemented; attempts to set tc-bw on
nodes will return `-EOPNOTSUPP`.

No functional changes are introduced at this stage.

Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c | 260 +++++++++++++++++-
 1 file changed, 246 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index db112a87b7ee..b17c3a82d175 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -64,11 +64,13 @@ static void esw_qos_domain_release(struct mlx5_eswitch *esw)
 enum sched_node_type {
 	SCHED_NODE_TYPE_VPORTS_TSAR,
 	SCHED_NODE_TYPE_VPORT,
+	SCHED_NODE_TYPE_TC_ARBITER_TSAR,
 };
 
 static const char * const sched_node_type_str[] = {
 	[SCHED_NODE_TYPE_VPORTS_TSAR] = "vports TSAR",
 	[SCHED_NODE_TYPE_VPORT] = "vport",
+	[SCHED_NODE_TYPE_TC_ARBITER_TSAR] = "TC Arbiter TSAR",
 };
 
 struct mlx5_esw_sched_node {
@@ -92,6 +94,13 @@ struct mlx5_esw_sched_node {
 	struct mlx5_vport *vport;
 };
 
+static int esw_qos_num_tcs(struct mlx5_core_dev *dev)
+{
+	int num_tcs = mlx5_max_tc(dev) + 1;
+
+	return num_tcs < IEEE_8021QAZ_MAX_TCS ? num_tcs : IEEE_8021QAZ_MAX_TCS;
+}
+
 static void
 esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_node *parent)
 {
@@ -101,6 +110,15 @@ esw_qos_node_set_parent(struct mlx5_esw_sched_node *node, struct mlx5_esw_sched_
 	node->esw = parent->esw;
 }
 
+static void
+esw_qos_nodes_set_parent(struct list_head *nodes, struct mlx5_esw_sched_node *parent)
+{
+	struct mlx5_esw_sched_node *node, *tmp;
+
+	list_for_each_entry_safe(node, tmp, nodes, entry)
+		esw_qos_node_set_parent(node, parent);
+}
+
 void mlx5_esw_qos_vport_qos_free(struct mlx5_vport *vport)
 {
 	kfree(vport->qos.sched_node);
@@ -126,16 +144,23 @@ mlx5_esw_qos_vport_get_parent(const struct mlx5_vport *vport)
 
 static void esw_qos_sched_elem_warn(struct mlx5_esw_sched_node *node, int err, const char *op)
 {
-	if (node->vport) {
+	switch (node->type) {
+	case SCHED_NODE_TYPE_VPORT:
 		esw_warn(node->esw->dev,
 			 "E-Switch %s %s scheduling element failed (vport=%d,err=%d)\n",
 			 op, sched_node_type_str[node->type], node->vport->vport, err);
-		return;
+		break;
+	case SCHED_NODE_TYPE_TC_ARBITER_TSAR:
+	case SCHED_NODE_TYPE_VPORTS_TSAR:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s %s scheduling element failed (err=%d)\n",
+			 op, sched_node_type_str[node->type], err);
+		break;
+	default:
+		esw_warn(node->esw->dev,
+			 "E-Switch %s scheduling element failed (err=%d)\n", op, err);
+		break;
 	}
-
-	esw_warn(node->esw->dev,
-		 "E-Switch %s %s scheduling element failed (err=%d)\n",
-		 op, sched_node_type_str[node->type], err);
 }
 
 static int esw_qos_node_create_sched_element(struct mlx5_esw_sched_node *node, void *ctx,
@@ -358,7 +383,6 @@ static struct mlx5_esw_sched_node *
 __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type type,
 		     struct mlx5_esw_sched_node *parent)
 {
-	struct list_head *parent_children;
 	struct mlx5_esw_sched_node *node;
 
 	node = kzalloc(sizeof(*node), GFP_KERNEL);
@@ -370,8 +394,10 @@ __esw_qos_alloc_node(struct mlx5_eswitch *esw, u32 tsar_ix, enum sched_node_type
 	node->type = type;
 	node->parent = parent;
 	INIT_LIST_HEAD(&node->children);
-	parent_children = parent ? &parent->children : &esw->qos.domain->nodes;
-	list_add_tail(&node->entry, parent_children);
+	if (parent)
+		list_add_tail(&node->entry, &parent->children);
+	else
+		INIT_LIST_HEAD(&node->entry);
 
 	return node;
 }
@@ -409,6 +435,7 @@ __esw_qos_create_vports_sched_node(struct mlx5_eswitch *esw, struct mlx5_esw_sch
 		goto err_alloc_node;
 	}
 
+	list_add_tail(&node->entry, &esw->qos.domain->nodes);
 	esw_qos_normalize_min_rate(esw, NULL, extack);
 	trace_mlx5_esw_node_qos_create(esw->dev, node, node->ix);
 
@@ -475,11 +502,11 @@ static int esw_qos_create(struct mlx5_eswitch *esw, struct netlink_ext_ack *exta
 		/* The eswitch doesn't support scheduling nodes.
 		 * Create a software-only node0 using the root TSAR to attach vport QoS to.
 		 */
-		if (!__esw_qos_alloc_node(esw,
-					  esw->qos.root_tsar_ix,
-					  SCHED_NODE_TYPE_VPORTS_TSAR,
+		if (!__esw_qos_alloc_node(esw, esw->qos.root_tsar_ix, SCHED_NODE_TYPE_VPORTS_TSAR,
 					  NULL))
 			esw->qos.node0 = ERR_PTR(-ENOMEM);
+		else
+			list_add_tail(&esw->qos.node0->entry, &esw->qos.domain->nodes);
 	}
 	if (IS_ERR(esw->qos.node0)) {
 		err = PTR_ERR(esw->qos.node0);
@@ -537,6 +564,17 @@ static void esw_qos_put(struct mlx5_eswitch *esw)
 		esw_qos_destroy(esw);
 }
 
+static void esw_qos_tc_arbiter_scheduling_teardown(struct mlx5_esw_sched_node *node,
+						   struct netlink_ext_ack *extack)
+{}
+
+static int esw_qos_tc_arbiter_scheduling_setup(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	NL_SET_ERR_MSG_MOD(extack, "TC arbiter elements are not supported.");
+	return -EOPNOTSUPP;
+}
+
 static void esw_qos_vport_disable(struct mlx5_vport *vport, struct netlink_ext_ack *extack)
 {
 	struct mlx5_esw_sched_node *vport_node = vport->qos.sched_node;
@@ -699,6 +737,157 @@ static int esw_qos_vport_update_parent(struct mlx5_vport *vport, struct mlx5_esw
 	return err;
 }
 
+static void esw_qos_switch_vport_tcs_to_vport(struct mlx5_esw_sched_node *tc_arbiter_node,
+					      struct mlx5_esw_sched_node *node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vports_tc_node, *vport_tc_node, *tmp;
+
+	vports_tc_node = list_first_entry(&tc_arbiter_node->children, struct mlx5_esw_sched_node,
+					  entry);
+
+	list_for_each_entry_safe(vport_tc_node, tmp, &vports_tc_node->children, entry)
+		esw_qos_vport_update_parent(vport_tc_node->vport, node, extack);
+}
+
+static int esw_qos_switch_tc_arbiter_node_to_vports(struct mlx5_esw_sched_node *tc_arbiter_node,
+						    struct mlx5_esw_sched_node *node,
+						    struct netlink_ext_ack *extack)
+{
+	u32 parent_tsar_ix = node->parent ? node->parent->ix : node->esw->qos.root_tsar_ix;
+	int err;
+
+	err = esw_qos_create_node_sched_elem(node->esw->dev, parent_tsar_ix, &node->ix);
+	if (err) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Failed to create scheduling element for vports node when disabliing vports TC QoS");
+		return err;
+	}
+
+	node->type = SCHED_NODE_TYPE_VPORTS_TSAR;
+
+	/* Disable TC QoS for vports in the arbiter node. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, extack);
+
+	return 0;
+}
+
+static int esw_qos_switch_vports_node_to_tc_arbiter(struct mlx5_esw_sched_node *node,
+						    struct mlx5_esw_sched_node *tc_arbiter_node,
+						    struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *vport_node, *tmp;
+	struct mlx5_vport *vport;
+	int err;
+
+	/* Enable TC QoS for each vport in the node. */
+	list_for_each_entry_safe(vport_node, tmp, &node->children, entry) {
+		vport = vport_node->vport;
+		err = esw_qos_vport_update_parent(vport, tc_arbiter_node, extack);
+		if  (err)
+			goto err_out;
+	}
+
+	/* Destroy the current vports node TSAR. */
+	err = mlx5_destroy_scheduling_element_cmd(node->esw->dev, SCHEDULING_HIERARCHY_E_SWITCH,
+						  node->ix);
+	if (err)
+		goto err_out;
+
+	return 0;
+err_out:
+	/* Restore vports back into the node if an error occurs. */
+	esw_qos_switch_vport_tcs_to_vport(tc_arbiter_node, node, NULL);
+
+	return err;
+}
+
+static struct mlx5_esw_sched_node *esw_qos_move_node(struct mlx5_esw_sched_node *curr_node)
+{
+	struct mlx5_esw_sched_node *new_node;
+
+	new_node = __esw_qos_alloc_node(curr_node->esw, curr_node->ix, curr_node->type, NULL);
+	if (!IS_ERR(new_node))
+		esw_qos_nodes_set_parent(&curr_node->children, new_node);
+
+	return new_node;
+}
+
+static int esw_qos_node_disable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					       struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node;
+	int err;
+
+	if (node->type != SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Allocate a new rate node to hold the current state, which will allow
+	 * for restoring the vports back to this node after disabling TC arbitration.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up vports node");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Disable TC QoS for all vports, and assign them back to the node. */
+	err = esw_qos_switch_tc_arbiter_node_to_vports(curr_node, node, extack);
+	if (err)
+		goto err_out;
+
+	/* Clean up the TC arbiter node after disabling TC QoS for vports. */
+	esw_qos_tc_arbiter_scheduling_teardown(curr_node, extack);
+	goto out;
+err_out:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
+static int esw_qos_node_enable_tc_arbitration(struct mlx5_esw_sched_node *node,
+					      struct netlink_ext_ack *extack)
+{
+	struct mlx5_esw_sched_node *curr_node;
+	int err;
+
+	if (node->type == SCHED_NODE_TYPE_TC_ARBITER_TSAR)
+		return 0;
+
+	/* Allocate a new node that will store the information of the current node.
+	 * This will be used later to restore the node if necessary.
+	 */
+	curr_node = esw_qos_move_node(node);
+	if (IS_ERR(curr_node)) {
+		NL_SET_ERR_MSG_MOD(extack, "Failed setting up node TC QoS");
+		return PTR_ERR(curr_node);
+	}
+
+	/* Initialize the TC arbiter node for QoS management.
+	 * This step prepares the node for handling Traffic Class arbitration.
+	 */
+	err = esw_qos_tc_arbiter_scheduling_setup(node, extack);
+	if (err)
+		goto err_setup;
+
+	/* Enable TC QoS for each vport within the current node. */
+	err = esw_qos_switch_vports_node_to_tc_arbiter(curr_node, node, extack);
+	if (err)
+		goto err_switch_vports;
+	goto out;
+
+err_switch_vports:
+	esw_qos_tc_arbiter_scheduling_teardown(node, NULL);
+	node->ix = curr_node->ix;
+	node->type = curr_node->type;
+err_setup:
+	esw_qos_nodes_set_parent(&curr_node->children, node);
+out:
+	__esw_qos_free_node(curr_node);
+	return err;
+}
+
 static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 {
 	struct ethtool_link_ksettings lksettings;
@@ -824,6 +1013,30 @@ static int esw_qos_devlink_rate_to_mbps(struct mlx5_core_dev *mdev, const char *
 	return 0;
 }
 
+static bool esw_qos_validate_unsupported_tc_bw(struct mlx5_eswitch *esw, u32 *tc_bw)
+{
+	int i, num_tcs = esw_qos_num_tcs(esw->dev);
+
+	for (i = num_tcs; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
+static bool esw_qos_tc_bw_disabled(u32 *tc_bw)
+{
+	int i;
+
+	for (i = 0; i < IEEE_8021QAZ_MAX_TCS; i++) {
+		if (tc_bw[i])
+			return false;
+	}
+
+	return true;
+}
+
 int mlx5_esw_qos_init(struct mlx5_eswitch *esw)
 {
 	if (esw->qos.domain)
@@ -892,8 +1105,27 @@ int mlx5_esw_devlink_rate_leaf_tc_bw_set(struct devlink_rate *rate_leaf, void *p
 int mlx5_esw_devlink_rate_node_tc_bw_set(struct devlink_rate *rate_node, void *priv,
 					 u32 *tc_bw, struct netlink_ext_ack *extack)
 {
-	NL_SET_ERR_MSG_MOD(extack, "TC bandwidth shares are not supported on nodes");
-	return -EOPNOTSUPP;
+	struct mlx5_esw_sched_node *node = priv;
+	struct mlx5_eswitch *esw = node->esw;
+	bool disable;
+	int err;
+
+	if (!esw_qos_validate_unsupported_tc_bw(esw, tc_bw)) {
+		NL_SET_ERR_MSG_MOD(extack, "E-Switch traffic classes number is not supported");
+		return -EOPNOTSUPP;
+	}
+
+	disable = esw_qos_tc_bw_disabled(tc_bw);
+	esw_qos_lock(esw);
+	if (disable) {
+		err = esw_qos_node_disable_tc_arbitration(node, extack);
+		goto unlock;
+	}
+
+	err = esw_qos_node_enable_tc_arbitration(node, extack);
+unlock:
+	esw_qos_unlock(esw);
+	return err;
 }
 
 int mlx5_esw_devlink_rate_node_tx_share_set(struct devlink_rate *rate_node, void *priv,
-- 
2.44.0


