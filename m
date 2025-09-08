Return-Path: <linux-rdma+bounces-13155-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8FCB48992
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 12:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DCD816317F
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 10:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD842F8BD1;
	Mon,  8 Sep 2025 10:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pjRB5Dv5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2077.outbound.protection.outlook.com [40.107.95.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6522F7AAF;
	Mon,  8 Sep 2025 10:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757326074; cv=fail; b=kitcSRdeE/x8E5RxuA6bohh/bDhTylSK6uzam4JtKEW2dZNJkhTPGwEiVAh2Buqr+X1NA52/0V9BBBlj+8zIamJI587cpoNauIiR3hz6yjE7uZ6x17O72TbiGpMcBNOdVU3Sg/H09SudQTFnfn2Dw17uXeJoyWbNYWDZ3uiFfiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757326074; c=relaxed/simple;
	bh=kTLF7KEHBBu+bnqgVH+npNSEA00VsY5VugAR/4phNzA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUA+9yDd+eLZs9fViQZelxRLCQ0S5OdH7dHlVtADG1Pp1imtstmDH1rVeg6riZN2LANCZwV6cDRafajMJSMmrXntD8o4rP3n7ZuHBrWE0AERBvvliMI+iKHibmbubz/yFLmL3mOcUlt511KgWwtrCm6iWXpFP2OlHDy/S/fHkvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pjRB5Dv5; arc=fail smtp.client-ip=40.107.95.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nt1lkhbizIqGvbBbLNrayHp9NmeIBG9R+uL/yTamy+3tiP1VkG6ncVc1B2d4mKkTdB3PBkijKzAm1b1H+qA80Gyg3F0XJ57Q2owaklxUuQYm7+fGA913NUrInL2ZLj9rugIJfS6/p9vAEJWPDECoH5AQL5mNdnT4NRe/YBs9tecXmb49SO3W3Gk0bsyPo6XhLIqgRD1KWIQvwKGbWwPLHbdtU4quN9PJmZWU1VEl8qTrKtBsAvbqu7k7/AAz+Inl0T5UnujlypnbySs4T5tCgnNYvNYa7EGjx+S66sDcr6gXcaOxSYdUeA9DX9zziyceZQwU/igRxroCjNvw0KeZYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ar3S//DGp/0M1CyAK8qmFXrf93sK7b6EtmJK2IISIlY=;
 b=ERCrJIi6wt9tE6dUTDqhwYtD91TaOsHjMcKmTlWO7mtg/W0OcN2RcjAXPIjVuWv86Gesu8jtYn8Jvtvipwdxy5s059Ww08tMMPaD3YBLktlZGcTNp37XjUxYtUlNwM/UVb2TXTbJfj0fuxa9zYymOf3ay7a2x2PimdM862gciSioIYzKDDs63uCPTnXMbR6sFurZOxmWOuzbRxtPhRm3U8lm2AQTnm18rvQTJCCPQmhm0c5TvK+LEGXeu/ffrhu3gd8Uf9kg+GkvoAON0g5uMxcMPLwDyer8fKaMhEf1qEcCAoFbqXPsHECeF6Rt5/K5mlpcinjbcq1puEDv/KVXTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ar3S//DGp/0M1CyAK8qmFXrf93sK7b6EtmJK2IISIlY=;
 b=pjRB5Dv5t8YuJXLc6aBM7XabWdtHk9WLr/8F4pFEsS3YpjDTn60GnOHloi8lsx9rBirA3ilCjEqZWJSXT0S0YhVIsU7ga92OXCODjb2UkZUz9/xYFd0n4d4DJ/fW4fN5+QbHiRzcOXS5/x7ROhUWF5DE0AIZobXQUKoSYwuRqmtnMmiOo9SUwLIvmKFxcWZWimWwUtM2ZsAU7/5nNESiu1KYxT8eLxSEuTTuw38A2oRVrzP+1X4sA0HtTk2DJjnj1hH7iu//HJNQzZ2hc8vIaGjMQOnVo+ZbFhXO3HbNIzIKfDFAdOMJLD8EkXk4suZs8xTIZZrzc3s5zWHyf5IOXw==
Received: from DM6PR11CA0007.namprd11.prod.outlook.com (2603:10b6:5:190::20)
 by CH1PPF0316D269B.namprd12.prod.outlook.com (2603:10b6:61f:fc00::604) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 10:07:48 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:190:cafe::b8) by DM6PR11CA0007.outlook.office365.com
 (2603:10b6:5:190::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 10:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 10:07:47 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:07:28 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 8 Sep
 2025 03:07:26 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Mon, 8 Sep
 2025 03:07:21 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net 1/3] net/mlx5e: Harden uplink netdev access against device unbind
Date: Mon, 8 Sep 2025 13:07:04 +0300
Message-ID: <1757326026-536849-2-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
References: <1757326026-536849-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|CH1PPF0316D269B:EE_
X-MS-Office365-Filtering-Correlation-Id: e07226c3-14b3-4a24-79d1-08ddeebf9028
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ixyrFEXj+ijoqFgIJC7scNI+hd3G/Q/hMnEiHnVUaSYCxc1eENi1HNAVg4ch?=
 =?us-ascii?Q?O3PaajTU78QRUu1VONzd+wpQRmGFz+A5Gu4CiDUCxMEq+LfkgvSi070hzWUG?=
 =?us-ascii?Q?2QKEAE1fY3uAqcE+N4ZN+0gKL6O5+byABA2y/ZFH1rDk2rZ956jnKZtZsTsO?=
 =?us-ascii?Q?hKvLGkJz63nJu9v7rqxTBn9YgzXGtuUHtdOQpab//xTVKAhKHT/TiRc9ookk?=
 =?us-ascii?Q?/Sz/DcBhlNMn3GO3pd+s2qW4NrFeEYd5kA2i3Ro4nSmBy9SXkujXYAqbk8Xj?=
 =?us-ascii?Q?jKafdngNiLUXR4w4T/n2WIbeOzUvBeEY3OV99FwdxeXFgj6TQOfnPnWHUGwp?=
 =?us-ascii?Q?YrSVRbVJvewqsTOb5ZCP7IZDZEAKFE+6kUK01zvbvHqtimM10o/WNI9KhD6Q?=
 =?us-ascii?Q?gL27gD2LFY+wyHG3bsVCGa29hNjcSZvsjPxcYdqB1EDTt69OBMC1Ywvo+J59?=
 =?us-ascii?Q?5VmzIlwvkxmKbvETsg2GEFKg/iShGp71RHn4rgRIJpY+MMDdtXV0drqGqi4I?=
 =?us-ascii?Q?K9lBSHR7pkqcpgHhrtnSt3zj8yCI1U4h4UYAvo9B+WKGEViqn0Gce2ssrxRQ?=
 =?us-ascii?Q?1SkJkJw5GGnPtznrkzR/tHnQGIotV6bFG+KK/FnGIVEIRduRTKyEgStv9cK6?=
 =?us-ascii?Q?AzHuYB1Are3yD7PfOx7zYRjLobBKrWsxYaFNBbYSFLKBkfvm4Q5wxUmlkiju?=
 =?us-ascii?Q?sDcBZBetUYOV0MuKjQWcrFT+O2DUXjCWxycAP0eiNJf/H4OffFd/gEd/ID8g?=
 =?us-ascii?Q?N/btFjTDr95OWf7AVD8tB2nNIJLsQmiyKhgcuOcS3c/c+tFl3obEg+LzFrcK?=
 =?us-ascii?Q?TzTLMJbvAdnhWRNuvsLDr149Y1cyYe3/kLJRPxHQeLfQtVZQ+N3J70wTfrzL?=
 =?us-ascii?Q?1hpyYYwn6qZ4jyPx0kNyLZBUJBZnNzSp2WMNMoK/qgQ+D/wcfdARJlnc5Z5h?=
 =?us-ascii?Q?GUmg7AH8O34g6D6e5Ko5iuVJVyonjuWs2wyb5V5ugOoBaCVz83xiZR1iXRzP?=
 =?us-ascii?Q?H4x2LKVkv40gsA6sUCGWFqtBkcBdAyhPZuOOCoQZFpKpY5Mw8SEYgYeiLmrM?=
 =?us-ascii?Q?AkfOJcJ2XInRKGQND2xC3px+T+gtZeFKo7utx05QVHPMgmyFjiurkLwf4dAc?=
 =?us-ascii?Q?JtH4TCaSsCh6Lqdy6Ghqn18PdscpYbhsP+pVblE9J8uHlM9G7AXgfVjmeHvt?=
 =?us-ascii?Q?G0SPhMrFJJ5tZD3A/EV01eUhlylAfS0QxQaWBK+DxKVyP7U19acAmhLyaVJf?=
 =?us-ascii?Q?ZxJhjlHDQQkcqajytw9elmIShd9eBHFu1j3b25dwEZyUxdEECEGsz7E+gT2e?=
 =?us-ascii?Q?d87CB6cF8wbyKEhtdD2Twnyx6bA7TZM2YExUxVOnmbzypfUigyWt2XUUs7XW?=
 =?us-ascii?Q?Gd1e6dyaFfLuPp16x5PNiwVmId/iY4P35QyRRpzH/DAfcg8657d31hyBOGSQ?=
 =?us-ascii?Q?8bCDZR0AAXodu5rPA/9ec/ZzwDqeOngtK8zFfgQq53iODM2N60jcC59G8ifq?=
 =?us-ascii?Q?qPgcbVTD0wfE3MY9oqzkTZdys6pJqCHjRlxA?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 10:07:47.9765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e07226c3-14b3-4a24-79d1-08ddeebf9028
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF0316D269B

From: Jianbo Liu <jianbol@nvidia.com>

The function mlx5_uplink_netdev_get() gets the uplink netdevice
pointer from mdev->mlx5e_res.uplink_netdev. However, the netdevice can
be removed and its pointer cleared when unbound from the mlx5_core.eth
driver. This results in a NULL pointer, causing a kernel panic.

 BUG: unable to handle page fault for address: 0000000000001300
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 0 P4D 0
 Oops: Oops: 0000 [#1] SMP
 CPU: 5 UID: 0 PID: 1420 Comm: devlink Not tainted 6.16.0-rc7+ #1 NONE
 Hardware name: ...
 RIP: 0010:mlx5e_vport_rep_load+0x22a/0x270 [mlx5_core]
 Code: ...
 RSP: 0018:ffff8881142b78f0 EFLAGS: 00010246
 RAX: ffff888104652150 RBX: ffff88810215a6c0 RCX: 0000000000000000
 RDX: ffff888104652000 RSI: ffffffffa02b0cc0 RDI: 0000000000000000
 RBP: ffff888104652000 R08: ffff8884edaad5c0 R09: 0000000000000000
 R10: ffff8881142b78f0 R11: ffff888100716480 R12: ffff88810f1e0000
 R13: ffff88810215a6c0 R14: ffff888104652000 R15: ffff8881095301a0
 FS:  00007fa008742740(0000) GS:ffff88856a9f6000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 0000000000001300 CR3: 0000000106fb6001 CR4: 0000000000372eb0
 Call Trace:
  <TASK>
  mlx5_esw_offloads_rep_load+0x68/0xe0 [mlx5_core]
  esw_offloads_enable+0x593/0x910 [mlx5_core]
  mlx5_eswitch_enable_locked+0x341/0x420 [mlx5_core]
  ? is_mp_supported+0x4b/0xa0 [mlx5_core]
  mlx5_devlink_eswitch_mode_set+0x17e/0x3a0 [mlx5_core]
  devlink_nl_eswitch_set_doit+0x60/0xd0
  genl_family_rcv_msg_doit+0xe0/0x130
  genl_rcv_msg+0x183/0x290
  ? devlink_get_from_attrs_lock+0x180/0x180
  ? devlink_nl_eswitch_get_doit+0x290/0x290
  ? devlink_nl_pre_doit_port_optional+0x40/0x40
  ? genl_family_rcv_msg_dumpit+0xf0/0xf0
  netlink_rcv_skb+0x4b/0xf0
  genl_rcv+0x24/0x40
  netlink_unicast+0x255/0x380
  ? __alloc_skb+0x120/0x1b0
  netlink_sendmsg+0x1f3/0x420
  __sock_sendmsg+0x38/0x60
  __sys_sendto+0x119/0x180
  ? count_memcg_events+0xec/0x150
  ? __rseq_handle_notify_resume+0xa9/0x460
  ? handle_mm_fault+0x12e/0x260
  ? do_user_addr_fault+0x2a4/0x680
  __x64_sys_sendto+0x20/0x30
  do_syscall_64+0x53/0x1d0
  entry_SYSCALL_64_after_hwframe+0x4b/0x53

Ensure the pointer is valid before use by checking it for NULL. If it
is valid, immediately call netdev_hold() to take a reference, and
preventing the netdevice from being freed while it is in use.

Fixes: 7a9fb35e8c3a ("net/mlx5e: Do not reload ethernet ports when changing eswitch mode")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  | 26 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/esw/qos.c |  1 +
 .../ethernet/mellanox/mlx5/core/lib/mlx5.h    | 15 ++++++++++-
 include/linux/mlx5/driver.h                   |  1 +
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
index 63a7a788fb0d..912887376824 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rep.c
@@ -1506,12 +1506,20 @@ static const struct mlx5e_profile mlx5e_uplink_rep_profile = {
 static int
 mlx5e_vport_uplink_rep_load(struct mlx5_core_dev *dev, struct mlx5_eswitch_rep *rep)
 {
-	struct mlx5e_priv *priv = netdev_priv(mlx5_uplink_netdev_get(dev));
 	struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
+	struct net_device *netdev = mlx5_uplink_netdev_get(dev);
+	struct mlx5e_priv *priv;
+	int err;
+
+	if (!netdev)
+		return 0;
 
+	priv = netdev_priv(netdev);
 	rpriv->netdev = priv->netdev;
-	return mlx5e_netdev_change_profile(priv, &mlx5e_uplink_rep_profile,
-					   rpriv);
+	err = mlx5e_netdev_change_profile(priv, &mlx5e_uplink_rep_profile,
+					  rpriv);
+	mlx5_uplink_netdev_put(dev, netdev);
+	return err;
 }
 
 static void
@@ -1638,8 +1646,16 @@ mlx5e_vport_rep_unload(struct mlx5_eswitch_rep *rep)
 {
 	struct mlx5e_rep_priv *rpriv = mlx5e_rep_to_rep_priv(rep);
 	struct net_device *netdev = rpriv->netdev;
-	struct mlx5e_priv *priv = netdev_priv(netdev);
-	void *ppriv = priv->ppriv;
+	struct mlx5e_priv *priv;
+	void *ppriv;
+
+	if (!netdev) {
+		ppriv = rpriv;
+		goto free_ppriv;
+	}
+
+	priv = netdev_priv(netdev);
+	ppriv = priv->ppriv;
 
 	if (rep->vport == MLX5_VPORT_UPLINK) {
 		mlx5e_vport_uplink_rep_unload(rpriv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
index 8b4977650183..5f2d6c35f1ad 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c
@@ -1515,6 +1515,7 @@ static u32 mlx5_esw_qos_lag_link_speed_get_locked(struct mlx5_core_dev *mdev)
 		speed = lksettings.base.speed;
 
 out:
+	mlx5_uplink_netdev_put(mdev, slave);
 	return speed;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
index b111ccd03b02..74ea5da58b7e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h
@@ -47,7 +47,20 @@ int mlx5_crdump_collect(struct mlx5_core_dev *dev, u32 *cr_data);
 
 static inline struct net_device *mlx5_uplink_netdev_get(struct mlx5_core_dev *mdev)
 {
-	return mdev->mlx5e_res.uplink_netdev;
+	struct mlx5e_resources *mlx5e_res = &mdev->mlx5e_res;
+	struct net_device *netdev;
+
+	mutex_lock(&mlx5e_res->uplink_netdev_lock);
+	netdev = mlx5e_res->uplink_netdev;
+	netdev_hold(netdev, &mlx5e_res->tracker, GFP_KERNEL);
+	mutex_unlock(&mlx5e_res->uplink_netdev_lock);
+	return netdev;
+}
+
+static inline void mlx5_uplink_netdev_put(struct mlx5_core_dev *mdev,
+					  struct net_device *netdev)
+{
+	netdev_put(netdev, &mdev->mlx5e_res.tracker);
 }
 
 struct mlx5_sd;
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 8c5fbfb85749..10fe492e1fed 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -663,6 +663,7 @@ struct mlx5e_resources {
 		bool			   tisn_valid;
 	} hw_objs;
 	struct net_device *uplink_netdev;
+	netdevice_tracker tracker;
 	struct mutex uplink_netdev_lock;
 	struct mlx5_crypto_dek_priv *dek_priv;
 };
-- 
2.31.1


