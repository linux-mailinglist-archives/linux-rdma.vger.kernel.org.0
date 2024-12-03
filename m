Return-Path: <linux-rdma+bounces-6216-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FFC9E2D28
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 21:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 396BF1638C7
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Dec 2024 20:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00629207A2C;
	Tue,  3 Dec 2024 20:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZIlXc97l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC48220A5F6;
	Tue,  3 Dec 2024 20:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733257864; cv=fail; b=lURCLoUs3EC3YnRJUIJtA9fMB0QnLL5brmqEiYI5o0TBtBYTjEYhR8fHKUC0OObSrVsMG2/vvIRDyPwL5DjoDhyK6NADJrMqd67A3V2KpZ7PPcMZLelPu31rRDt+s49xBTOAiQrj0XjTL2tN5ydeAmcSr1wts/xkcWZMLkQRqzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733257864; c=relaxed/simple;
	bh=FPuvYi9r0lQX3bfQkfNbraHml67mhEjEYOCQHOXl6Wg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZiCeyBjCA8QR1kpN1Ojr8g6fK5GBxTdIBkLR953R0Aq6cbF0tEc7D3zWnH9+19ayVaBSm8SXP/2XJJkRbbYUQCwr22Zn29XKbFZKcT15coxW8suD24lRbKQqLbR8kDFpF/A/H7sICahSYVks4uZFtbQYX2JFdYjTvE4Yw3kK/Cs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZIlXc97l; arc=fail smtp.client-ip=40.107.236.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y1GMjklDivTwKdvYQHhEyk4POCnBkygMeyjCyk4T3hN0WxXPsgZ1+cPiPMVx418vFWTIVG4wUjavdDe6igBAmSrlYCKPKjDFtmAVrTl4jUJh08pdDY8Ynhgd3Sn9AfNCSzM0dLy7gs3TTAYf9Q8CXuGM0bWKk54fE9b1EAzmbYqACseo1vssuQ3zXEjLaC3cdHwZ0+x/LBuFk49XvmcoHoHH5hGmih3nIwDEXgNqWqkccoEgdo3t9dZdyGsm4ZfvEQ7TAm0TdLaYJB0naAOeQWS9AluMQcEOposJRmJ1qgfzrhXpux5RYnLm5rqUd2oT7kZYqSDF8e8xGALfhpML+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+X4E+XFBH9pCyxc0EKw76fyVXGUiE49BhpfBub6y5Ds=;
 b=LAbLVPDwm/qFZMpdsgGwugjtwtbFLHfEBa8bHtlmKjyfQSH33FSm0awgBBQIbXAl1Lw2vQB1043cmFFnZkFaPad8pASZb0EPaSDu2Ye7q9ZWPfwK0OjLLWafayKpv+5wKSDxwKMkhBZKTAeCGT59BjBgJqYMbzjr3poAOhxnHYnOB/58crR3oev7/a6h9XqJvv8a/r7TpPJYupVs5j5ANaxQDKuiWKk6b9NhV1+u0FJqkFiVb90bMKhiymmlmTPP1jxO+nnGAh2b1n/tM2W2lhgRXQS2qo9CuBJye+5Qz0QGcRgo0eK2NgZQXryNNXfifwCliTBjQ0jQB/m8CMnz+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+X4E+XFBH9pCyxc0EKw76fyVXGUiE49BhpfBub6y5Ds=;
 b=ZIlXc97lG/4+oo8Mv9bw3HThPzOiBnyLVJQrl7A6N01CKASAkLhqxRqrP8X8q2cCFwQ2NzAqcHwAmVbr9DULzDdYnv7+64Np7DHp9A6S+0DIuLhgvrRYzyH614iAUe9aUqYr2s+xkBFUFQXbPeN/KuyDdRbKuCouiJpYVk0qkTO36BVqDZr7uya72jSX+1HHzzPoaMEyVWCwtvi95gIrii1K2cth+cUGUooCPr5CMetSuTqwyUrB0l7OLfFg4hK5SdeTDE4L3vgwUDeX1++/fuc2O8rnBoHZ6iFyOZwkgfZcy8PE9aSZdAtGmPfJogcbRxWoyTz95MHb7nGjlWnyWw==
Received: from DM6PR11CA0069.namprd11.prod.outlook.com (2603:10b6:5:14c::46)
 by SJ0PR12MB6903.namprd12.prod.outlook.com (2603:10b6:a03:485::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.18; Tue, 3 Dec
 2024 20:30:53 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:14c:cafe::2f) by DM6PR11CA0069.outlook.office365.com
 (2603:10b6:5:14c::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Tue,
 3 Dec 2024 20:30:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8230.7 via Frontend Transport; Tue, 3 Dec 2024 20:30:53 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Dec 2024
 12:30:33 -0800
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 3 Dec 2024 12:30:32 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 3 Dec 2024 12:30:29 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
	<linux-rdma@vger.kernel.org>, Carolina Jubran <cjubran@nvidia.com>, "Cosmin
 Ratiu" <cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next V4 09/11] net/mlx5: Add support for setting tc-bw on nodes
Date: Tue, 3 Dec 2024 22:29:22 +0200
Message-ID: <20241203202924.228440-10-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241203202924.228440-1-tariqt@nvidia.com>
References: <20241203202924.228440-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|SJ0PR12MB6903:EE_
X-MS-Office365-Filtering-Correlation-Id: 91cbd6db-9212-4e33-a56c-08dd13d9623e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L3RaMCtWUGVSYW1ZeVZmTkk1M0tnUDdsYyswcEUwaDJsMGZkb3RSaEpvOUVp?=
 =?utf-8?B?dlJvTmc5aEgrOEo5U0VCclp1UGhuUlZsK2Jublh5WHFFTkQ2Vk9Fb1EvTkMv?=
 =?utf-8?B?ZGhjUndhSUd3YzM1eVAzRHVOQ0pWQ3lBUnZRNUdNUjlGVm9UdWlMdHVUS2lR?=
 =?utf-8?B?WWdJY2hPWnJLT0t5QVZZR0pSNXBqUVVaeUtWOExURTZlQnlMRXlBR1o3NXVF?=
 =?utf-8?B?OHZKeUIwaWdhNWRrOFpKN0dPZHV3RmhYTUsrdWNNMjZkOU1iOWUrSFRNUktP?=
 =?utf-8?B?VnZmNDdIUHpqUEhxL1RvUk81UE1BR1RrODRPZzFOc1k0NEp2TjhJOHk3eVlm?=
 =?utf-8?B?bXNhUlQveXdqS01aTXJyc0xVVmIvTmxPMDFIT0NSRm9oeWpRREVxc3Zid1Ju?=
 =?utf-8?B?bi9MV3hWcFdEV1FpZmF6QWFBMkloWDBFZkIwcWd0M0l4VDdLS1AvU3h1bkZN?=
 =?utf-8?B?T3dIWUdIUGNsTGlESmtKNEp1RXRHYTVWeHM1VjFRemVXN0wwUUNNM3pxdGlW?=
 =?utf-8?B?Y01PUDBxcTl5Nk8reTU3M1Z1MmNHbDJ4ZytXanEzUGk5Q1BQdUwrd0xEemMr?=
 =?utf-8?B?bGluUTRIRnM5c1pNY0QwazdSRDMyV0s3bWtONHptekVONGIrYWhTRW9YQnVY?=
 =?utf-8?B?V1drdGhOQlo2c0RYMWxPbklNcVY2U09xdUVtelc2OERaa25DRVhSRisrdjBS?=
 =?utf-8?B?RkQ5Y05yWjFuZy9LNGRPOXBNN1pybHJDY1BBTkpLWnhiU29maEhqcUlTY05Z?=
 =?utf-8?B?c3RqZVAwSVNMMXhLdmpJWUFkeEJLa09WRnhSdkhLcEdFT3pKalVvNWZFMGRJ?=
 =?utf-8?B?NjZ5cnlvakx4anFkK0JPODMyR1ZEL0tmdDBZeVdQOTZ3OXk3ZWhxdy9zNkkw?=
 =?utf-8?B?dkNRUzJxVGtaMzBTV0R4U3BZWVB3OVJDa00wTmdTb29yZVQ2elQ1WWRIQzYr?=
 =?utf-8?B?SzdYQytXbktIeHpTUzVpM3BJR3lMN2FoZWk1RE5yL3ZXYkh6Z01qWTJQYW04?=
 =?utf-8?B?dCs1L1FMZFpDSXJMTHhESFlndWxySmlTNERIVnhiZEFLKy9SeGFlNmhNbFJX?=
 =?utf-8?B?MnZCQ2xMNGNKY0pkektSZFYwS3dzeEZsWm01L2JEVEVRbXpTVFg0MkZWc0Ix?=
 =?utf-8?B?MXFwRVhlSGNNZ0djNVZ4UnB2ckZkcnZkMlkrUHo0UlowUGhvaWE0RkNEWDJ4?=
 =?utf-8?B?dit5TWthMmc2c2tlbHJCOTluNmNLcFNQbUlIV0YvbHZ0QVN6VlZTZy9Zd3JV?=
 =?utf-8?B?bHRRNnFiZzFsS1l4b0lTK25SdjcrTVZiZXpzUjNyUG1PQzdhV1BKR1dGTklY?=
 =?utf-8?B?S3VrblIxTFg3Sk5FSzlrdWQ1cVdmY0VPY1JDbXdXamxvSXp2NUkyeHhCaVB4?=
 =?utf-8?B?K05IeFhuV0VQTWFUUm13ZG9uQ2tFT2R1R2VneWEvWi82RVRXQlJlRy9IL0xV?=
 =?utf-8?B?UzRDdWN6VXhEaU9uVVhBN0F1dmxUdnRsakNtMVJiZDlKWEcyZVFmU0lJSnc4?=
 =?utf-8?B?V3l4NThmRjZIRkUyRUFFYXp3cEFReFFNQnU1azYxME1WZFNZSTlIczZCcE52?=
 =?utf-8?B?bmF6c3ZHak1KV3VRbFlwQ3VhRlFBdkdtY2M3NUh3NFluUEVBbWZ4S1VTTU56?=
 =?utf-8?B?UitwVjRmRnkzU1l2aHFPTkU5M2JsTE1rSjRTaWEvWEhhaWxYNFFBVUZZV0x0?=
 =?utf-8?B?Y0xJOWJrSnZvaTNBMEdQdmxBL0U3NkYwbkFPOWdzMnQvUjV0THc1T3dGbnk3?=
 =?utf-8?B?dUxlTFN3QnNmMmtOMmpKTzBlS3dMcEFTZkFMdHlLNmJsemZSRVdkaElFWmNC?=
 =?utf-8?B?SW80THR0bjExRzdPRUl5ZkViRnVoeWljbGtQK1JvMWgzSFpyR1JpKzJQNFBV?=
 =?utf-8?B?Rjg4RGRUVHdiM045Q1dNYWNyTXBBODJtcWlOVk9XVHdVdDRQMGJQa01nMHBK?=
 =?utf-8?Q?HW9MOBpph6lAEyu2Dlg4hwc8R9kz5Qon?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:30:53.2019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91cbd6db-9212-4e33-a56c-08dd13d9623e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6903

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


