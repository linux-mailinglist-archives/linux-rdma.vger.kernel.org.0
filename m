Return-Path: <linux-rdma+bounces-6251-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2402B9E47A6
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 23:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 598C4188052F
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Dec 2024 22:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A00202C21;
	Wed,  4 Dec 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WymXe2Df"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2086.outbound.protection.outlook.com [40.107.236.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F08D11A8F6C;
	Wed,  4 Dec 2024 22:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733350324; cv=fail; b=hXugpfwW4OhjFtd9geLzxJ5qVcjSR4dAPWDtmUm87MkH0Z/9ZtryTO7cBMIRGmXXnjiD0iBzczNG0Y0Gkkr6jRsNMCHw60QTOimzSGuaiyWd/aAc8uia5k7CanYWr7jalRqmf7kt+XAWrMXTBzPcTxpRMF+9AzdCXLlwgOVaEMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733350324; c=relaxed/simple;
	bh=FPuvYi9r0lQX3bfQkfNbraHml67mhEjEYOCQHOXl6Wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b+cjnCkL/qH/3GeSmVdZug++tQWh0X/0JahLXfeNmw+oiNyFz+tXMKIvS5RWa97b2OzOByKHRG95UVjRCX5xyUCG+DwhQ941QVuSdRCzNmBGRS9cxATvgTHpBBdrIRryoR8LPoaqisoa2TMwQR4WgiX83tXksKfD2YtiPKnCC2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WymXe2Df; arc=fail smtp.client-ip=40.107.236.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VdO5u3BYnNuRT83HOHTqQuAqu93ooPx2eaXjD/HjuaoOHy3YOOagwwkCY1g3nJZ2qB+u/aRXxiIK+tgMyumHeUzaeIG/BYas1cOwIPEuKTp8cv2IfI0TZSmynA+QsAKduxjmfcq2GMsGLVREYErZtEioCt4bVy/JShCjp5/BpYH9w7+mLk/tFawggVxkiqHwi0yIeMtWGSLW7LIcrn7SYJrnZVXHkPXt65ffUCRMQ5TN3NQ2tHI3Vf3CnxzBH5ZWvyb/ZYC5Anf8n0G9OPgvycFUg7FMxb1T9Epu7j1gPBA/xuzlIwMJZJERaCGkMPThHjdW+njMoTWPs+q3aN8G9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4E+XFBH9pCyxc0EKw76fyVXGUiE49BhpfBub6y5Ds=;
 b=ihwXS6g0CI6SRGouxO5/d+zKy2ap3H/bhVwh6fB/EXKLx0niHwUGcDLedI1AGuFS12m4+ozwcJ01eJZEeB2dmwBFZ3E3KAwIu3/X4umgjoILFCzIVC7gRDKaKKoq2Qlo1dNu6kPjEb6AVDn83rpjb//jgpOQ2JeEnLjpU3dlbmSvA6zcQmkim4gT1Xt22kkO2Qm2Rk3dnNrwPKWjaR7GWK9slBMmnRQew3U4tkKFQ8ygw6ecaLksxPrSFIG/pLXaVUioW35TxU+sT1enUUYUSaubyu88QolM2a71g8kryXeNgYk3UR7T62dI2TZcpA99jDofRlwNAhg6IObcU5NLUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4E+XFBH9pCyxc0EKw76fyVXGUiE49BhpfBub6y5Ds=;
 b=WymXe2DfpiqDXDhEwbO7jSa04X05jCJYFYAkywGB+j0Lh/Dt0VDMwBiJmuxdeUeefkqwAHccTi9nkkcEUOFW4AqF1pJfK2LZgBJioaqzkPnbbmEJ1XThvjvaYiTYKgizA/8rmYoUQw4D4dDEE5sx9muYfui4u1hYoa17qb51KPZZ6gXyPByl5oVkHndQlXJ1aqcquNRf93RTRxKnY2kTDtwJ4FZrRBrvzhtGqrO8wWBQw2IbbWOTDCqQISG0T5dO063e4tAu4xwzy1jB8nsJnHVPHYFBvzrlwNw8VPbJCg2u57sksg5oivih35aGTMfV/5mQZWKJO6CejvsdHSbelQ==
Received: from BN7PR06CA0045.namprd06.prod.outlook.com (2603:10b6:408:34::22)
 by IA1PR12MB6260.namprd12.prod.outlook.com (2603:10b6:208:3e4::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.19; Wed, 4 Dec
 2024 22:11:55 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:408:34:cafe::9d) by BN7PR06CA0045.outlook.office365.com
 (2603:10b6:408:34::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.9 via Frontend Transport; Wed, 4
 Dec 2024 22:11:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Wed, 4 Dec 2024 22:11:55 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:39 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 4 Dec 2024
 14:11:39 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 4 Dec
 2024 14:11:36 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>, Leon Romanovsky <leonro@nvidia.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, <linux-rdma@vger.kernel.org>, Carolina Jubran
	<cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V5 09/11] net/mlx5: Add support for setting tc-bw on nodes
Date: Thu, 5 Dec 2024 00:09:29 +0200
Message-ID: <20241204220931.254964-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241204220931.254964-1-tariqt@nvidia.com>
References: <20241204220931.254964-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|IA1PR12MB6260:EE_
X-MS-Office365-Filtering-Correlation-Id: 66a4a73c-e41f-46b0-64e1-08dd14b0a9f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S1EzVTI1WXQwclQzWFF5Y3FRbkRFUCtvcWpGSzFzY0kraTZjZjMveVFFaGxG?=
 =?utf-8?B?b3BCMTV6emVIdmRGbGVFR0UyUGJkQUJicDAxMXFBaHZGb0h2OUVNYW1qZmpN?=
 =?utf-8?B?cStmYzFGdXY2N09Ebm5iZDN1dXZ0RmJ5NFZUdTNNbVljQ0duZS90VnpHclQ2?=
 =?utf-8?B?NGg4U2JGZUQ3bk1ZSnlJZUtRbDBlWDJINUQxc1Q3MWhXVitLSlpSRU55aUV5?=
 =?utf-8?B?L2dwb0k4c1RtSzl4T09hRnc3STBVeTBaVW95QW8zOU1lallnRnR2L0hNV205?=
 =?utf-8?B?cWlCWVpSbnNjT2grR0VKOFhZUUI1a1RkeENpd0dtd2RSR0JsSXFIa3hPeCt4?=
 =?utf-8?B?ckM1T1czMVdTVDRYSVhsVEo5S2ZGZVFxa2VSS0o5L2pva1ppV0oxV2I3ZDBa?=
 =?utf-8?B?K2p1MEtnUExnNllhVWFSdGtsajFkTnNPM1lvY3l2ZUdyeTRHT2c5WUQ1TGph?=
 =?utf-8?B?cGJtYkRBY09EamNZWVdqL3RvQzNyd3lXcXhWMFVkMURNZEQzbFJrQUd2YWln?=
 =?utf-8?B?dENCVVRZY2xtd1ZPN0tHRng0ZHVsQkVFYVFSSEJXZjUzZUJqVHJTOXNQUklN?=
 =?utf-8?B?SUVKS29EckpyNkdjNjhma1RkY2xDbjIrTUhOZWVFR3RUbE0xTFV6RFVPdWlR?=
 =?utf-8?B?ZjdFOTl4Q2FZaEhqQ3QvcTRGdWk0TlRTOW5zYlQzeE9uNU9aT0NEY3dJaFFV?=
 =?utf-8?B?dmh6ZVpGeTZvUDAyZzJJY2xLaTVPckJOaHFQQXpmcm1uUkZMdkNBdTFpMUp4?=
 =?utf-8?B?c0xiZ1N3dFRKaUZneHZ6OVBYK3FKS0M0WUxRU094WWJhekxJTFlnclhXYXM2?=
 =?utf-8?B?bFZVaHI4cVRISmJjdjJXSWJqbUl5M1dFVG8wUDI5UHIyTGhBUlhsV1FFWVQy?=
 =?utf-8?B?cU1GYmNZNFJrSXc1V1ZJMmtNemVVTjAvSDdUVllKMGYycGw2TjBkMmJxVmtu?=
 =?utf-8?B?TW9LbFlWSHQ4dXJzSHZ2TUV6cVR3Q29kdjJTSzdMSHhIL3F2bGczcXQvc1Nr?=
 =?utf-8?B?WVZvTGhOeHRmSm5oMVlMMWY3MTVndGhUeWc5cTVTemJneEdZUjBqSUdJU0p6?=
 =?utf-8?B?THBxSnR1TmYwSk55ZnN3NG91VUtXVmRTNTRtb1pHdEFnc3ZVMUFpbXVpQWRs?=
 =?utf-8?B?WkN5TUdkTUsxSGRIWjRhN0w2Q3FYenNHc0xLVzdEdlUrNlg5aThvbEtraGlL?=
 =?utf-8?B?N2pYcURwRWhBM1NXSzRZUU93cmkvWFNobXpmT1oydzY1cUE2aFdFc2RFYTJ5?=
 =?utf-8?B?VGs0Q1I0MEkySFZEYVZyZHZrZndlR0JodXlsTFpTWFJIY3dUSW9OUUttMFND?=
 =?utf-8?B?eFJiMmxTUENkbDdjOUNjK0pTaHRDWlF3OFJFaXp0L3VEODhMTUl6M0ZYWFNo?=
 =?utf-8?B?TGZzUjg4OUdybTR6WWhwZHFuV29MNnAzd3AvUjl1RTNqS21WRXI5a1BRODNz?=
 =?utf-8?B?L2dsZmFQVVpRNm8xZU14dUc1WW9KWmRDWHpOZnRjM1h4UWYwOFMvd2xmUHRO?=
 =?utf-8?B?QW5LVjFNeDdYWk96ZURNdVdsVVZsNGxza3BlZXBvakdXczVjMzVwcnZCeXJR?=
 =?utf-8?B?RXpxWXpTOUhZR1cwb3dmclBCU2dINXNIZ0RBRHR5ZDl0MUZXaHhDSS8wQUEx?=
 =?utf-8?B?YkFJaHZoQnR2Ym1YUG9xMTdUMFNIdVNObmZUaU9jZ2lrK25tKzBXZHlJWXoy?=
 =?utf-8?B?UndFWVI5MHk1aXRuMTZuOXJ3RXYxL2xxVzR0NWF3VFpJYWRNMGxwZU9xME1U?=
 =?utf-8?B?QUFib3JsTFNRcm84TTYrZWVVcVZkS0ovZkE4U1kwclM4YUI0SkFpVG1zVFNq?=
 =?utf-8?B?NEdUNHNWamdoUXRFQ0RFQzZwZ3BxemhIY2tGU05LeWZCSnkzeGZDc3NYSk00?=
 =?utf-8?B?amk3NFJhYnIzM1h5cTJMWnJxMHJ4R2NWc25WeHY2WnltV2RtdnRmS283cXFw?=
 =?utf-8?Q?sqDfT7lMtE7y6GqwigsEubVHExQ1jB7T?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2024 22:11:55.2718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66a4a73c-e41f-46b0-64e1-08dd14b0a9f8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6260

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


