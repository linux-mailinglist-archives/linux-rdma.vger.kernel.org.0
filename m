Return-Path: <linux-rdma+bounces-8552-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B769A5A6B2
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 23:04:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEC2F1891A50
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 22:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB0022171E;
	Mon, 10 Mar 2025 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WHIHnIK8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2053.outbound.protection.outlook.com [40.107.94.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046B22206AE;
	Mon, 10 Mar 2025 22:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741644195; cv=fail; b=c/kikeFKjIatvzusa+eoaLnQWsoVyZ0Ww+uBmCFQHy/I+z0fgd04aar1DYa134+nqlxom+Fw8pVDwX+Bi4pl1aibJ5p0aaNpej1yuYSn8CNoYsVR4kwuNTQT8IU76t52KYbatmXL6XsOUzgQFdOqw+eIpba87ynku5mOeVmb3oU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741644195; c=relaxed/simple;
	bh=adcwiVaAQ+kXOJqSv69evt6wAWVgKuLRtLYYXuLAr7k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hQWqfLNDsgbk8dm30zlDpqGyo80wLjO82kp7ZWV5OsOBvVEACd2xNh3a6Vw6+Lvz9Ffe4zdHp48VbumcuI467snC60G1lVyJ+i8TM1f7gPuFnAQ7GLrDjb7y92UalM6qZ+Bn9sZoDPY3HtyFy+QMUzqow0VSyal9OeHwcxE7oR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WHIHnIK8; arc=fail smtp.client-ip=40.107.94.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RI6yi5zJIBEomeBqPPHBnd/4DMlzC5R8QRueffbKx3Sc47nIvXuGyHH5UkUqZoUyV6ZfCGkgEGEF0OIiLVVGlrgKdKi5cZD9wbUQVeuoJzm+BcdoTCGrWUlyBNt55JkBpCJw2uWtiRqRMet0oRlNsehbisZE52umTN5Ky29FrHcQVkrNsfeMxwrO5SvSdNrOon1zYhmOf57mD7EYVPiIORfr4clb0STa8EQygC3tJKfq8QkTaOWQjrXyJiplJpoS6c4ftF7Yal8VV6Au0HPnvV3jY1ddUlV3cxE74RQUIQg9sbyAvJONcxxb/qaQ7DgP2d48rl3ZFBUEL57gJ8ayLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RuANXfBsmt2ynahjkNpdAOfVzRT5ANFyYFx/dk2iXM=;
 b=se5c7awidzwUp8qeb9JbGi7lw9HKoDC2eg2xI7kjVWMdpQcehGffwkgrg+xfHcurfsLkl9AqYrNrpX8xk2rS+ywP1LsQPS2YCB7an6vik4ZhXSefyb5LAKINMM3UcVeCjeMdXlxScr2N/hKYh7IRxpDI0s9P79O5L1CG/RhNA//5A1SY3ZxIXBMRi9mayQqjxezIbg9A138lhnby6OyrqJdwL2mcdSvip9T7H3OttL/JR2HZSVPNHXYHP9LqtMThQ7t2wd2Fei3HC0Kn8QKryd5VhLECB2jGXOjxQntMsA7W0fMXfF5Z8fQKo+3nCOsOupWqj/7huCD3dOnA8lFZPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0RuANXfBsmt2ynahjkNpdAOfVzRT5ANFyYFx/dk2iXM=;
 b=WHIHnIK8IuJh9Y0vLFAvsm8ydttbkA9PYgRvDQ6pm6wijC8JuoLfVEy6fdb2HDd4nN989+eiJXGdNgiVeOMmt0x/W/x2PAWH5JTC0OBa1bjrSryZxmwthsFUFDU3jp83724D8vjpNXOXyCY0GNokqzkb5Te/iV5rApECK5cBc2qS0E40sJwDvCyeu+x9cnG5aggs88VyEl/ahYPtW0urcpx9Z3mEfkY6Vjdwj9Vi2HDLQ2pBP6dOhNO3iDETswHTt8if7YQ2v5m0rYpZ4T+VIdV4yjVnsQ974RKLH3HG6ELu0Mo7p+uiCyF4TtOTNCOd6XFbo5Ck7IZ8vEG8kvs+9Q==
Received: from SA9PR10CA0006.namprd10.prod.outlook.com (2603:10b6:806:a7::11)
 by SA1PR12MB6969.namprd12.prod.outlook.com (2603:10b6:806:24c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 22:03:08 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::61) by SA9PR10CA0006.outlook.office365.com
 (2603:10b6:806:a7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Mon,
 10 Mar 2025 22:03:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 22:03:08 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 10 Mar
 2025 15:03:00 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 10 Mar 2025 15:03:00 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 10 Mar 2025 15:02:56 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Gal Pressman <gal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>, "Leon
 Romanovsky" <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Jianbo Liu <jianbol@nvidia.com>
Subject: [PATCH net 5/6] net/mlx5: Bridge, fix the crash caused by LAG state check
Date: Tue, 11 Mar 2025 00:01:43 +0200
Message-ID: <1741644104-97767-6-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SA1PR12MB6969:EE_
X-MS-Office365-Filtering-Correlation-Id: f1bf5af2-4fe9-4eee-58ae-08dd601f5747
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aMe5mJF9W8BzfnJ1CPOBEPvGkN1dxGO8frGo7u1CSRE0zew61eX9+DwFkOpC?=
 =?us-ascii?Q?mFWUI7DgLEPIfBQNBPhRC7H3MwV1GusNoR7Xr5Hfv2SEqlfDj+YLRxAxUvxu?=
 =?us-ascii?Q?Khoe5lg8CXWLsQurVGKHVUy9jZWGXS+KnfqWqDXN2AZgluhuYpMLSHidYdy3?=
 =?us-ascii?Q?hIAKZNRTSxh0CbAmIol5Q7gwZJaLCIsgn1SVUoK9LHbh3/lVVN9wqmRO4BUC?=
 =?us-ascii?Q?ikwLOQoiFcAAMbXdEy/hb9CtLyAoaC4Z/8gKV7o75Ec/dfSh+kBkblxa0SYc?=
 =?us-ascii?Q?YztMHLSnLGu+9GOWvWHo0ktMYLwku8V+VycCmO21jqWnvmqdrcyw2gfLYeIE?=
 =?us-ascii?Q?/SCQLuavjjUbJAHR/xizrz3nKMVfY4W2//o+WTMIm3sTJwIqG1EyKvQm91ma?=
 =?us-ascii?Q?BbEdZK0msC50a9vyEwuXSQemDAKbFFsGOTrdZkohJaHMgkhs6c2BLrn0AKSU?=
 =?us-ascii?Q?a1K8iNOgpjavu2g9kBZIrMFPuqvOHj0xCwnbV3cq6vbBzv/72rzLnC/epTN0?=
 =?us-ascii?Q?eWZ6g8cyi4Zz3Lnk2keRYpt0uNtYFwKzdgTMgq5AadpF6/XKT/DVfGxskA6L?=
 =?us-ascii?Q?9bqkKq1vHeUv7w7qM3PCo0t0yEkCaEeMyUBhwZzOQkUjqGdw/EwcRRo6DiN2?=
 =?us-ascii?Q?zfGW1CpsTW1MIfNc/SuQPMqReB1rQk7N6UpeBvmBoNNHGl1YGwP3g1W2FJ3m?=
 =?us-ascii?Q?ZH+u8N6dmI0vBTi4E3C1kepsRZBmVygBPp+YOqVeuj+PCaEmAa7VzrzG3Itf?=
 =?us-ascii?Q?bC6pAMiSjp7joHZJFEV+knjhejk2/JCDaYGmMQIaCG3antc3N5LFvWXFHmfD?=
 =?us-ascii?Q?s47yl3iyWaa8OyQuaRe1mQyZW6eZpN9rIx4yR7dlTJZ+PKE0ewTVZpf2l14l?=
 =?us-ascii?Q?zZ234KGUoemFVJWaIA9dq1iGlaOoEZnav9K/pRhxLP8G3DBmTcUgQ6uUW2RM?=
 =?us-ascii?Q?l/RKK1WLd+8Jhno0toNboZ1qYXslOnfv18FhSLtf2egjQqJz8pVoG8UbLMyk?=
 =?us-ascii?Q?q8u9cnKEhMqGkR/hHCOEj+oUBE2oglkDELhFARONhE1RaPn3DhoO3PKci8aH?=
 =?us-ascii?Q?3XW3KY+1gmFKxRM3KfpUHaXvMtQwF0yg6BzunfP1diBx4GdQ2I1RBKF3NmMs?=
 =?us-ascii?Q?HbcifxO2LSb8Ujm0zLkcNM4kg/V87Tz7ZzAODk/9/VwytSFxh3l5Qg0R3L8b?=
 =?us-ascii?Q?Akgb2j65mtJIsjyGg83WrgePIm0AT3y1eEmycoCS9VMy9DDc7qrioLHlZw0u?=
 =?us-ascii?Q?hboyznBvoC+4GfL+q3CGNNkBcjhX9ARt0+Yl8P53/LVAjOAAO5JL+fNz5IQk?=
 =?us-ascii?Q?qX7IT0rehj8SBIkDEmyfmmBuBIerQFH15zRShQ0JiCPvXd1Op59fTTpQrH9X?=
 =?us-ascii?Q?Ou05whSI92TLJhKO+875cVosKBTbrTZJVb0ElFkpcKWT7YqfG/RLSEAEW4Kk?=
 =?us-ascii?Q?mZ+y08IyeOygX6btvqNq0CLXRndGq7Wy3AGPyLD6ClMctPkrJW608NxqJDr8?=
 =?us-ascii?Q?NfStKadBzWgsT0k=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 22:03:08.0087
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1bf5af2-4fe9-4eee-58ae-08dd601f5747
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6969

From: Jianbo Liu <jianbol@nvidia.com>

When removing LAG device from bridge, NETDEV_CHANGEUPPER event is
triggered. Driver finds the lower devices (PFs) to flush all the
offloaded entries. And mlx5_lag_is_shared_fdb is checked, it returns
false if one of PF is unloaded. In such case,
mlx5_esw_bridge_lag_rep_get() and its caller return NULL, instead of
the alive PF, and the flush is skipped.

Besides, the bridge fdb entry's lastuse is updated in mlx5 bridge
event handler. But this SWITCHDEV_FDB_ADD_TO_BRIDGE event can be
ignored in this case because the upper interface for bond is deleted,
and the entry will never be aged because lastuse is never updated.

To make things worse, as the entry is alive, mlx5 bridge workqueue
keeps sending that event, which is then handled by kernel bridge
notifier. It causes the following crash when accessing the passed bond
netdev which is already destroyed.

To fix this issue, remove such checks. LAG state is already checked in
commit 15f8f168952f ("net/mlx5: Bridge, verify LAG state when adding
bond to bridge"), driver still need to skip offload if LAG becomes
invalid state after initialization.

 Oops: stack segment: 0000 [#1] SMP
 CPU: 3 UID: 0 PID: 23695 Comm: kworker/u40:3 Tainted: G           OE      6.11.0_mlnx #1
 Tainted: [O]=OOT_MODULE, [E]=UNSIGNED_MODULE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 Workqueue: mlx5_bridge_wq mlx5_esw_bridge_update_work [mlx5_core]
 RIP: 0010:br_switchdev_event+0x2c/0x110 [bridge]
 Code: 44 00 00 48 8b 02 48 f7 00 00 02 00 00 74 69 41 54 55 53 48 83 ec 08 48 8b a8 08 01 00 00 48 85 ed 74 4a 48 83 fe 02 48 89 d3 <4c> 8b 65 00 74 23 76 49 48 83 fe 05 74 7e 48 83 fe 06 75 2f 0f b7
 RSP: 0018:ffffc900092cfda0 EFLAGS: 00010297
 RAX: ffff888123bfe000 RBX: ffffc900092cfe08 RCX: 00000000ffffffff
 RDX: ffffc900092cfe08 RSI: 0000000000000001 RDI: ffffffffa0c585f0
 RBP: 6669746f6e690a30 R08: 0000000000000000 R09: ffff888123ae92c8
 R10: 0000000000000000 R11: fefefefefefefeff R12: ffff888123ae9c60
 R13: 0000000000000001 R14: ffffc900092cfe08 R15: 0000000000000000
 FS:  0000000000000000(0000) GS:ffff88852c980000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f15914c8734 CR3: 0000000002830005 CR4: 0000000000770ef0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __die_body+0x1a/0x60
  ? die+0x38/0x60
  ? do_trap+0x10b/0x120
  ? do_error_trap+0x64/0xa0
  ? exc_stack_segment+0x33/0x50
  ? asm_exc_stack_segment+0x22/0x30
  ? br_switchdev_event+0x2c/0x110 [bridge]
  ? sched_balance_newidle.isra.149+0x248/0x390
  notifier_call_chain+0x4b/0xa0
  atomic_notifier_call_chain+0x16/0x20
  mlx5_esw_bridge_update+0xec/0x170 [mlx5_core]
  mlx5_esw_bridge_update_work+0x19/0x40 [mlx5_core]
  process_scheduled_works+0x81/0x390
  worker_thread+0x106/0x250
  ? bh_worker+0x110/0x110
  kthread+0xb7/0xe0
  ? kthread_park+0x80/0x80
  ret_from_fork+0x2d/0x50
  ? kthread_park+0x80/0x80
  ret_from_fork_asm+0x11/0x20
  </TASK>

Fixes: ff9b7521468b ("net/mlx5: Bridge, support LAG")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Vlad Buslov <vladbu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/rep/bridge.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
index 5d128c5b4529..0f5d7ea8956f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/rep/bridge.c
@@ -48,15 +48,10 @@ mlx5_esw_bridge_lag_rep_get(struct net_device *dev, struct mlx5_eswitch *esw)
 	struct list_head *iter;
 
 	netdev_for_each_lower_dev(dev, lower, iter) {
-		struct mlx5_core_dev *mdev;
-		struct mlx5e_priv *priv;
-
 		if (!mlx5e_eswitch_rep(lower))
 			continue;
 
-		priv = netdev_priv(lower);
-		mdev = priv->mdev;
-		if (mlx5_lag_is_shared_fdb(mdev) && mlx5_esw_bridge_dev_same_esw(lower, esw))
+		if (mlx5_esw_bridge_dev_same_esw(lower, esw))
 			return lower;
 	}
 
@@ -125,7 +120,7 @@ static bool mlx5_esw_bridge_is_local(struct net_device *dev, struct net_device *
 	priv = netdev_priv(rep);
 	mdev = priv->mdev;
 	if (netif_is_lag_master(dev))
-		return mlx5_lag_is_shared_fdb(mdev) && mlx5_lag_is_master(mdev);
+		return mlx5_lag_is_master(mdev);
 	return true;
 }
 
@@ -455,6 +450,9 @@ static int mlx5_esw_bridge_switchdev_event(struct notifier_block *nb,
 	if (!rep)
 		return NOTIFY_DONE;
 
+	if (netif_is_lag_master(dev) && !mlx5_lag_is_shared_fdb(esw->dev))
+		return NOTIFY_DONE;
+
 	switch (event) {
 	case SWITCHDEV_FDB_ADD_TO_BRIDGE:
 		fdb_info = container_of(info,
-- 
2.31.1


