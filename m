Return-Path: <linux-rdma+bounces-12417-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9CEB0EC3B
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 09:46:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF8317D6BF
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jul 2025 07:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24EE2798EB;
	Wed, 23 Jul 2025 07:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="s82nsFGq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FB427875C;
	Wed, 23 Jul 2025 07:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753256747; cv=fail; b=FDJy7NsBAMypDYqb/fOBlx0Cpro1zhNJG4zzeFFryJtUk6Gj94rzMpDY0BxCYaQTLpovEcG9x+6wOWo79ovChTJBTDczr53MqLnMwQUixOj4hr16L32CAbRGSHqHuwmUdKcIupES91G0rkYdoKVNcFznZAg9MIIfxDinhmAVQJE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753256747; c=relaxed/simple;
	bh=sNkDmAcEpH2Lf66pKSc187Vxeo0vH9/P5lAV6dJtiAo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0Rg5TxB2bIYUwG15AWosNpZvYAWn3crzRJIQXct7SrcJ5w4tDm/ZpegyRekhfc4nZgvnzcMG83qJ/X4cmODNbfTC2GqhAYO8UYQelxlcMOmnFV45KGf8apSnlmd8GZ+QL44j/2l4rVLmLw0WOc3eDRirpHj3FPDUThQDVO/CNE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=s82nsFGq; arc=fail smtp.client-ip=40.107.236.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qNDSywJwjhIkM+4hOj2zPVIqneXfQKAXUYuLIas4CVP6j9yiFQL1rryQZ+cNvC6NeRKcb5N1wocmSbdk0wHFu4B8kfXojh6B+Odc8vI5wIfPJyAHffDLJ+VxwzveBek1LPk4xprtbZ+82eqZf6BZWQwZ2ORjAqiLN2a/by1cdeFHGWaIKLx1CSIhIcc7XqS2ZE+8akHJDyqpDxcHh0ROCTOlTwyNdXhIifunQTt9D16MAiZ0uQNUotVcVPqaTwpTlc5sC1KsgHnZ2uiB9ADq+FdqUmNi1r9WheZ/eRYkSefgjpc6zFrNlSMxiV+UmgxS3SCyRW690L1149F9PyhBNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0y01IS+uW/c1d1m2SQayzXrbcH9fJHIvTG+olpo7Pj0=;
 b=x5XmWVXaZHaBzOJObPBKdN8qERDb/QaIKkAtz/ha4xQlboWvSu+XDDK5/QCN+Ls8QT+0Epo6Jb7aO6z/iDjcNxw6D6T/WM3JHcyD9bgDVAWfUg7pPW8hwu5w5vv44yqJhRFygE3oOv2lMQsTWFLaWQNvu+/rCRWaUEWBivLWBKc1M+mRdn2BagtgcZVamRrJxFPVk0YKyYRUzEWvYCSJ2ct9WraUY6WksHuYrSK8Hnla1B4FM9g97wlX6+Ze8JnEL8pfGMRwk0T78/oQcqtQx5zHpuBmSXV9WlzCi/C9CYHn6w/FtM/uuiNKC/foNxjFyNnQvdG1y2ZWIZGQTdcyWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0y01IS+uW/c1d1m2SQayzXrbcH9fJHIvTG+olpo7Pj0=;
 b=s82nsFGq3Jy4urJPMtMfn2aXFJMrQLgmIcUA9fhPDAdtjQwAtACXxxanAAIKzRGDNWGn+UwearfD8G/0Ey1Mt6fgvZQBbc9WRdp8WV5rMKdMgvZ9cRi12Mdy0xRh80qyVyf3l3+zj6Hm2rP5wmIn8eH0K2usIyLZYB+tf8Q56wmB1bYhDfDa5tE0WNwe83EdF/9emszvSbSaxSDiEDIwISKPMSJUWF9tQvtIxezcBOUodVOjeXHMsltFluVidOA/0LPibCad9HsO/azwXzAwR2qNy8JgeEfcJz1cDyOqBfl5TmUZR52tcXfNyvtJVv7BmKHtFe/9kgfqdD5v9/SMHw==
Received: from MW4PR02CA0025.namprd02.prod.outlook.com (2603:10b6:303:16d::11)
 by IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Wed, 23 Jul
 2025 07:45:39 +0000
Received: from BY1PEPF0001AE16.namprd04.prod.outlook.com
 (2603:10b6:303:16d:cafe::e9) by MW4PR02CA0025.outlook.office365.com
 (2603:10b6:303:16d::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.29 via Frontend Transport; Wed,
 23 Jul 2025 07:45:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE16.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 07:45:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Jul
 2025 00:45:14 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Jul
 2025 00:45:14 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.7)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Jul 2025 00:45:10 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Jianbo Liu
	<jianbol@nvidia.com>
Subject: [PATCH net 2/3] net/mlx5e: Remove skb secpath if xfrm state is not found
Date: Wed, 23 Jul 2025 10:44:31 +0300
Message-ID: <1753256672-337784-3-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
References: <1753256672-337784-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE16:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: d3dd9ec7-7d38-421f-9c43-08ddc9bceadb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8Vxxl/eJY2xzKQ0hUMz8p5ecdHiwa1jI5S5YijX48vBuuHNVWDhcYAEi3cXp?=
 =?us-ascii?Q?i8kq29YkloonwmDO8fz3ahaQebLMb1xGYCLijjxP9b2aqqcvWNw+RYbp8o7/?=
 =?us-ascii?Q?6fzWJc/aadPytqmGji6CSI8OuKpaAS4Ka3MzCtgWKp7K4M1pAnGmrTHR68j3?=
 =?us-ascii?Q?1/J6SvmZ3gQBr3/wywnIihJU6BKjfwA48DTdiMv8WkwvI2QGuHv4dyxnJM0A?=
 =?us-ascii?Q?i2aTTw48ivtcXrYvwPqFbPyrlksSw1P6A2xaF6Lbr0vbeLINqo3BFyeVyG/e?=
 =?us-ascii?Q?5DdyopRiEfT2dpwkux9AVVq50aAokQ8cnH5qXq6aFfhCAH4oIqkONMnEewVe?=
 =?us-ascii?Q?w8PqhxsTDSNNQpXAkxPJmvXzTbLOF4lRS5/T5+ZXqCmOzsEhp02Dbe2h5DUg?=
 =?us-ascii?Q?PzI0CTDLxutz1PvCu8kxktfT7kjjwrfpLojnyHv8YyQTtMVSDpY5WqvykPsz?=
 =?us-ascii?Q?qYoLXYjlrxFou8Iv8/boVmx723hcSIXHhpF3lYqZh0LNQ+haYl0jBQSW9TwH?=
 =?us-ascii?Q?H0hTDTiSvRiQXDzLiGrRC+oL4KeN7TJTzwmZb37gcxes2HzkptHGI93faoAH?=
 =?us-ascii?Q?iv5IQ2O99lDsiseHwey4Jh59dsmPLR+EXOuVJ9HlKM49s9ENi/tZmZqIKOXG?=
 =?us-ascii?Q?lpRRhj0Uzv1YTSKUa1Pom+75HnhkeoFcSK0oOAsPj26CHPzsBD7dBP+8MTQs?=
 =?us-ascii?Q?Uhvfej+Vj2Ac5jYZ+PT88pp33mYwxRoc87MK+ee+pEPPJi+JptBix+q3cs0K?=
 =?us-ascii?Q?uwmz3PjlL1L+kPXFubOWYd6RqeglLtOzs4uhQCyybM01RiCwc4r+E+9htHRz?=
 =?us-ascii?Q?Lswge+DWUa/MmHCVSVyh2xzFbbICAISodFW2yTmqc9arjPo7Rfch4psPkkrR?=
 =?us-ascii?Q?iuXCunJM/kAkrQKm4oklh1c8tAIOiH6TCv3umdQj6PNatQHPqSpthhf6tSkO?=
 =?us-ascii?Q?QV9x6a5r0zT5Wn1eIFK3Sq9LfFrbyDBiBirfS6MVIIdPnuAsExz7UPE2d8wC?=
 =?us-ascii?Q?5zY5pVptq8Tuc7ZdjNOQuTe/raxfW6+ABOGOWtSUiHVNmIOIduYEuaKvAHm+?=
 =?us-ascii?Q?rOfgwsPaNixfXepzc2Y/skFz2lQaB64QzMC0iHZrKsnOB83HiHQmN8rCx1gH?=
 =?us-ascii?Q?+sunlmxfNUMUeIhmj/j00lFRXvmBVjiblXlRkhGujXog53+CE+NxgWlLllqo?=
 =?us-ascii?Q?ROYrcuxhHVjogSi9bZ9BDQcgN7TgLsWtqeX3RUIoj08ZOpg2jjHnLT6ezn7R?=
 =?us-ascii?Q?ritGKl0XgivMVqMJm1IsFDX1N+bPJ+PEt4S/tT6qga2Men2bvloeezUwdEvo?=
 =?us-ascii?Q?RD9/jSR85xJsW/tf2eg9AVkRiWZW4B0pakJ33dBucYKjB62O4/TC/rHoA4Ae?=
 =?us-ascii?Q?qkX0G0uQjZmEf0qO8MLLI54Ss/FdY/ttsZ+eJORAchPUrKNfSl1i3AnzV5u5?=
 =?us-ascii?Q?V1AiTPug3zjVsX4T3c7AMeQW5v2Q7tIGG6Ax6EzSxm0BA0iCTqFrVEuWtWJk?=
 =?us-ascii?Q?yKLFk7EtT1LKXycyfAHZy7Dx0edroI/tK62f?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 07:45:38.6430
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3dd9ec7-7d38-421f-9c43-08ddc9bceadb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE16.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

From: Jianbo Liu <jianbol@nvidia.com>

Hardware returns a unique identifier for a decrypted packet's xfrm
state, this state is looked up in an xarray. However, the state might
have been freed by the time of this lookup.

Currently, if the state is not found, only a counter is incremented.
The secpath (sp) extension on the skb is not removed, resulting in
sp->len becoming 0.

Subsequently, functions like __xfrm_policy_check() attempt to access
fields such as xfrm_input_state(skb)->xso.type (which dereferences
sp->xvec[sp->len - 1]) without first validating sp->len. This leads to
a crash when dereferencing an invalid state pointer.

This patch prevents the crash by explicitly removing the secpath
extension from the skb if the xfrm state is not found after hardware
decryption. This ensures downstream functions do not operate on a
zero-length secpath.

 BUG: unable to handle page fault for address: ffffffff000002c8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 282e067 P4D 282e067 PUD 0
 Oops: Oops: 0000 [#1] SMP
 CPU: 12 UID: 0 PID: 0 Comm: swapper/12 Not tainted 6.15.0-rc7_for_upstream_min_debug_2025_05_27_22_44 #1 NONE
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:__xfrm_policy_check+0x61a/0xa30
 Code: b6 77 7f 83 e6 02 74 14 4d 8b af d8 00 00 00 41 0f b6 45 05 c1 e0 03 48 98 49 01 c5 41 8b 45 00 83 e8 01 48 98 49 8b 44 c5 10 <0f> b6 80 c8 02 00 00 83 e0 0c 3c 04 0f 84 0c 02 00 00 31 ff 80 fa
 RSP: 0018:ffff88885fb04918 EFLAGS: 00010297
 RAX: ffffffff00000000 RBX: 0000000000000002 RCX: 0000000000000000
 RDX: 0000000000000002 RSI: 0000000000000002 RDI: 0000000000000000
 RBP: ffffffff8311af80 R08: 0000000000000020 R09: 00000000c2eda353
 R10: ffff88812be2bbc8 R11: 000000001faab533 R12: ffff88885fb049c8
 R13: ffff88812be2bbc8 R14: 0000000000000000 R15: ffff88811896ae00
 FS:  0000000000000000(0000) GS:ffff8888dca82000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffffffff000002c8 CR3: 0000000243050002 CR4: 0000000000372eb0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 Call Trace:
  <IRQ>
  ? try_to_wake_up+0x108/0x4c0
  ? udp4_lib_lookup2+0xbe/0x150
  ? udp_lib_lport_inuse+0x100/0x100
  ? __udp4_lib_lookup+0x2b0/0x410
  __xfrm_policy_check2.constprop.0+0x11e/0x130
  udp_queue_rcv_one_skb+0x1d/0x530
  udp_unicast_rcv_skb+0x76/0x90
  __udp4_lib_rcv+0xa64/0xe90
  ip_protocol_deliver_rcu+0x20/0x130
  ip_local_deliver_finish+0x75/0xa0
  ip_local_deliver+0xc1/0xd0
  ? ip_protocol_deliver_rcu+0x130/0x130
  ip_sublist_rcv+0x1f9/0x240
  ? ip_rcv_finish_core+0x430/0x430
  ip_list_rcv+0xfc/0x130
  __netif_receive_skb_list_core+0x181/0x1e0
  netif_receive_skb_list_internal+0x200/0x360
  ? mlx5e_build_rx_skb+0x1bc/0xda0 [mlx5_core]
  gro_receive_skb+0xfd/0x210
  mlx5e_handle_rx_cqe_mpwrq+0x141/0x280 [mlx5_core]
  mlx5e_poll_rx_cq+0xcc/0x8e0 [mlx5_core]
  ? mlx5e_handle_rx_dim+0x91/0xd0 [mlx5_core]
  mlx5e_napi_poll+0x114/0xab0 [mlx5_core]
  __napi_poll+0x25/0x170
  net_rx_action+0x32d/0x3a0
  ? mlx5_eq_comp_int+0x8d/0x280 [mlx5_core]
  ? notifier_call_chain+0x33/0xa0
  handle_softirqs+0xda/0x250
  irq_exit_rcu+0x6d/0xc0
  common_interrupt+0x81/0xa0
  </IRQ>

Fixes: b2ac7541e377 ("net/mlx5e: IPsec: Add Connect-X IPsec Rx data path offload")
Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Reviewed-by: Yael Chemla <ychemla@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
index 727fa7c18523..6056106edcc6 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_rxtx.c
@@ -327,6 +327,10 @@ void mlx5e_ipsec_offload_handle_rx_skb(struct net_device *netdev,
 	if (unlikely(!sa_entry)) {
 		rcu_read_unlock();
 		atomic64_inc(&ipsec->sw_stats.ipsec_rx_drop_sadb_miss);
+		/* Clear secpath to prevent invalid dereference
+		 * in downstream XFRM policy checks.
+		 */
+		secpath_reset(skb);
 		return;
 	}
 	xfrm_state_hold(sa_entry->x);
-- 
2.31.1


