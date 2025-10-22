Return-Path: <linux-rdma+bounces-13975-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 43489BFBDD1
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 14:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DDFD95023A7
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Oct 2025 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF8C344024;
	Wed, 22 Oct 2025 12:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RuvPQLFl"
X-Original-To: linux-rdma@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010047.outbound.protection.outlook.com [52.101.85.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15C11328B45;
	Wed, 22 Oct 2025 12:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761136260; cv=fail; b=kBWMmplr3qhnXQ1fmCMvjp+zi+ke0KHjM/bpdIB5FIZBnXHfW+OaF4ILjVhx6DvGLziLMLi56xqJvH4FraqvZNQXti9sAqASQobm9u+CJAzfVjQh33FDW/++LDJSQMm+VQjfNDzDpLyh2lQ49/x16i8n/+ZluR6tSaVkoH8lij4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761136260; c=relaxed/simple;
	bh=Jy2+6sTg0VM//Cm9mP5SSb4G0PAyOTDYCc+JVECqwi0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vGA2tL+G8/VKn3w9sso7ypVkA7aX7zA1GyxlSlmcAPC1B94fn6CaWkZjSJnJtR3fz8kHsVpRAxjBatN9RVvUkcogKM8QVlKFF/bqJu/wKf8nd4z7qrlSs/iXpyrR1ZAes+0RnIdpjB+cYX6GUV3ZPxbX7Phn9Z3A6bLP9AE4PT8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=RuvPQLFl; arc=fail smtp.client-ip=52.101.85.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ot8oXBpoWeecq38GBCkNeDkqLS3OBLLPD4+xQwo5frP84MG9/G7aDthqJ27HPuYs8bFFCJ96IMaFwDiky2EUTCy2K5S/i+IMDr/04dhY6e1NBSgs0eLOPacg+ZAzO3lX2WEEgNmHfPFhPVE2RHaYWNpYO7j7L+ki8frCFQSaJcYZgJC5m53SvS+6JLMjQL8CPdw1f3a6d/05aM1/Ck34SGfIcU9SYi239fTyztsswyFt4JnurrFYz719cQaUr+j6Qa8fFXFNuSsFXq6gnivxJSEKgtzE6mfexzjsTRhqJmaFD0fk7Q5WyeHT/cGQXvMb3Ch/vG0h0yK3a75D4kDuDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gBmsFPE/tBgccGXsHhUpydgLIqcPIRAEAkS49MCeOe4=;
 b=yR3qBUpXwn/DpMkSxSK5u7Bps3h842V+iUO1na+6jjZOdmuN4si1Wbb0Y79xTyj032QU2LhI5Qmw5bphcKjvdeWzLRSgi5OELedWCx9qbLVLW9UdLdKVlkQU6t9i0HFb7/pkaf+QDDIHOAbKJ+/yfZrqi3ZWLBQBFbpSLnz2VkZUrBucfhSG20LlefB9SeFMCMtS1+ID4J00a87ApSffECFnIgCgFgJA55ML9t2N9awBMSNwZYMZIwv/PRrZmKAdvTi1ft35ZS5eXWFWA22UwRwKg7KUHYc6A+y1xhgE9Q1FUGAw1rTnFs39j0OPd786bKVu7jQ77dgrmj0WM8a7Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gBmsFPE/tBgccGXsHhUpydgLIqcPIRAEAkS49MCeOe4=;
 b=RuvPQLFlepsaHHcK/HZObkuprTjhLQxene2vwTpSS5Z+KPaF2mzufuskvuKDBLV34Md5rjuIkXYZOqL1lb/X898TiiQlY7ofBAnTXhMCUrlCHDdpZkRT4Ko/rITj9BQih7QkZBd4iLpdwZNBfJumVSLKBhEd5cFyq6JuOKuWNnJbAlUtP3grH7+TajiqeDEkuJ8iLAFMa9LzMUa4/hda2h6+8fTXeXPAwOrewjywpT8GgMTl840mEFgmk4vYgg04QuOa2hBSctxlGxzJNEQyv/u5Sg3DG7p3n1kmPfIrhVM0Zd7KHqmdzUQbcpPLqZ1NTlic7cQxyvJLHKofpvTQrg==
Received: from SA9PR10CA0022.namprd10.prod.outlook.com (2603:10b6:806:a7::27)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.18; Wed, 22 Oct
 2025 12:30:56 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:806:a7:cafe::c8) by SA9PR10CA0022.outlook.office365.com
 (2603:10b6:806:a7::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Wed,
 22 Oct 2025 12:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9253.7 via Frontend Transport; Wed, 22 Oct 2025 12:30:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 22 Oct
 2025 05:30:32 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 22 Oct
 2025 05:30:31 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Wed, 22
 Oct 2025 05:30:27 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Patrisious
 Haddad" <phaddad@nvidia.com>
Subject: [PATCH net 4/4] net/mlx5: Fix IPsec cleanup over MPV device
Date: Wed, 22 Oct 2025 15:29:42 +0300
Message-ID: <1761136182-918470-5-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
References: <1761136182-918470-1-git-send-email-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 057dcdd4-0a21-48f3-f59a-08de1166d911
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r/daNuYe5aVSB3zXs4IFa8qbvUIivaaiOx3UTUnVYk/HDypV/eyNh5D17Bo2?=
 =?us-ascii?Q?D2/fIzWqCIXDX/qNxb2KyRxGnQvUf9mF7/z6j1d7fLDjWrgaE/Bz6+IbZjnb?=
 =?us-ascii?Q?fHa8aQ6zume3ZMQZ82RbZuRFqwTKAzt1PrjdlxjyTdW9DO/ox0QzoKA5g8m3?=
 =?us-ascii?Q?QMY8QpuOB6lufRS1/jcvy0XACyFtevFeo7guea+v5DTuKfuWlddQZ7Fq90ZJ?=
 =?us-ascii?Q?Uw58sdu4Aa4ockbXmhlCLWUGYFK3la2gCv2Y75WdjJ/1nG+6e31FrfB77TvP?=
 =?us-ascii?Q?/U8K81TT9PwZh+SDjY5HHU7XDL2dUgkvXO1PQtET/N8L0eAri8frfp2raDwa?=
 =?us-ascii?Q?5mnGPzgkYgixQrx5uQui/NedIyzF/31VBhEoO18FgxBClYaKOY/ELkr2Ewel?=
 =?us-ascii?Q?00Fem4sz1h5a3MWD1Wqm2XdmtPQwicaHS+lWNq0ieWHXM+efya91EXIsv1Gw?=
 =?us-ascii?Q?J9ZoRU3LJ1GcyksUNNSog0Xerkl0xRF7j3Wa2gkExWcW3duBy8LD2JRAwuwb?=
 =?us-ascii?Q?E5we9StwXcn+EifnRPieUQjO88BxvLXoxWYzFm+PKHOfdre7rRncIxmFlFiV?=
 =?us-ascii?Q?rIoXkd8b5qS0rqapGlTv44nzthVh10LIKIVABByyuitzl+wy9oO++yiU4nhb?=
 =?us-ascii?Q?qz5/kZY1CUgSvqzQYFcvxEcEaIWCTN9sKG4ZY2tKATW0KvT69ycs4UQlUYSd?=
 =?us-ascii?Q?jYLsdN2DzyagFcHGcfRxxcwnZ5cp+g/iHcSD9Fcmox4ym5OCmouJ225ACLa/?=
 =?us-ascii?Q?laIys65/NYsyiAtFUVXixQmTw3X8F9+SVShUfjUi/LGWBVf3DY20NIaonUNG?=
 =?us-ascii?Q?GFw/YN13LVGDr9Ll1aNnl0DwXGVKryOmtg+pAGyi5Uo0dmTHHNNOok06LqRs?=
 =?us-ascii?Q?PwCU2YP+FBVJKxs0LupsA8xtSDatvM6+EMRYgLRA700Y5HsfTck89Wa2wHSJ?=
 =?us-ascii?Q?53GXn/gJiCLwPwxBq67RMxjlCtiG68JlbGMtwNkob7uAnW1V3jWE7+Geefd7?=
 =?us-ascii?Q?LdR7ht3BWg84ZEh/57MA8bizCGKgn9GY7NAhp4a6LCeoq2fzGYlI6xKLZSkV?=
 =?us-ascii?Q?+XazAA6Fh/H0ivaJsfWNF/5Kpici7A8pcPshsgmr4J+jSpZP0wVAQtSYORJz?=
 =?us-ascii?Q?peD2QzBtG4vwlo3meqVAd4EpuPTL1IX7vpg9M95/HVnkDhS10WiEtGvjYdFM?=
 =?us-ascii?Q?sZq9evPt0o3iG1OPzogKn3RK4cjDcT5NQliyO3YM8efatKTQgPLU3TG6aUN0?=
 =?us-ascii?Q?9jTmGLGEX/b5mFzfZIAPPCQhmGDSfUANGHBUh4jAK/AvReFcKilSXABbO7hb?=
 =?us-ascii?Q?x1Y1shvzX0++6GdoOQw80HqnmC5AMxh3nHcgu5egx3CY9I/zaXyF4G9cmNzG?=
 =?us-ascii?Q?imrzNnH17lGESp081AZMC8FyhQ3sNdyFp/pzriQoxKOPR/gqSSWMtOY06FYd?=
 =?us-ascii?Q?Q6eCegrs0fmkQM40Rilac0xasql8U8fkbG+3nhXlgKjMm8XlHienZgDjApzG?=
 =?us-ascii?Q?k9FmGVwXe8DEeBUy/HoUGGLL/K+HaqMWRe7XyrpvLIVYrr2U5Qn87gxW3ah2?=
 =?us-ascii?Q?a0fMkYKnozvf90Qh+UA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2025 12:30:55.7831
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 057dcdd4-0a21-48f3-f59a-08de1166d911
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126

From: Patrisious Haddad <phaddad@nvidia.com>

When we do mlx5e_detach_netdev() we eventually disable blocking events
notifier, among those events are IPsec MPV events from IB to core.

So before disabling those blocking events, make sure to also unregister
the devcom device and mark all this device operations as complete,
in order to prevent the other device from using invalid netdev
during future devcom events which could cause the trace below.

BUG: kernel NULL pointer dereference, address: 0000000000000010
PGD 146427067 P4D 146427067 PUD 146488067 PMD 0
Oops: Oops: 0000 [#1] SMP
CPU: 1 UID: 0 PID: 7735 Comm: devlink Tainted: GW 6.12.0-rc6_for_upstream_min_debug_2024_11_08_00_46 #1
Tainted: [W]=WARN
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
RIP: 0010:mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
Code: 00 01 48 83 05 23 32 1e 00 01 41 b8 ed ff ff ff e9 60 ff ff ff 48 83 05 00 32 1e 00 01 eb e3 66 0f 1f 44 00 00 0f 1f 44 00 00 <48> 8b 47 10 48 83 05 5f 32 1e 00 01 48 8b 50 40 48 85 d2 74 05 40
RSP: 0018:ffff88811a5c35f8 EFLAGS: 00010206
RAX: ffff888106e8ab80 RBX: ffff888107d7e200 RCX: ffff88810d6f0a00
RDX: ffff88810d6f0a00 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffff88811a17e620 R08: 0000000000000040 R09: 0000000000000000
R10: ffff88811a5c3618 R11: 0000000de85d51bd R12: ffff88811a17e600
R13: ffff88810d6f0a00 R14: 0000000000000000 R15: ffff8881034bda80
FS:  00007f27bdf89180(0000) GS:ffff88852c880000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000010 CR3: 000000010f159005 CR4: 0000000000372eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? __die+0x20/0x60
 ? page_fault_oops+0x150/0x3e0
 ? exc_page_fault+0x74/0x130
 ? asm_exc_page_fault+0x22/0x30
 ? mlx5_devcom_comp_set_ready+0x5/0x40 [mlx5_core]
 mlx5e_devcom_event_mpv+0x42/0x60 [mlx5_core]
 mlx5_devcom_send_event+0x8c/0x170 [mlx5_core]
 blocking_event+0x17b/0x230 [mlx5_core]
 notifier_call_chain+0x35/0xa0
 blocking_notifier_call_chain+0x3d/0x60
 mlx5_blocking_notifier_call_chain+0x22/0x30 [mlx5_core]
 mlx5_core_mp_event_replay+0x12/0x20 [mlx5_core]
 mlx5_ib_bind_slave_port+0x228/0x2c0 [mlx5_ib]
 mlx5_ib_stage_init_init+0x664/0x9d0 [mlx5_ib]
 ? idr_alloc_cyclic+0x50/0xb0
 ? __kmalloc_cache_noprof+0x167/0x340
 ? __kmalloc_noprof+0x1a7/0x430
 __mlx5_ib_add+0x34/0xd0 [mlx5_ib]
 mlx5r_probe+0xe9/0x310 [mlx5_ib]
 ? kernfs_add_one+0x107/0x150
 ? __mlx5_ib_add+0xd0/0xd0 [mlx5_ib]
 auxiliary_bus_probe+0x3e/0x90
 really_probe+0xc5/0x3a0
 ? driver_probe_device+0x90/0x90
 __driver_probe_device+0x80/0x160
 driver_probe_device+0x1e/0x90
 __device_attach_driver+0x7d/0x100
 bus_for_each_drv+0x80/0xd0
 __device_attach+0xbc/0x1f0
 bus_probe_device+0x86/0xa0
 device_add+0x62d/0x830
 __auxiliary_device_add+0x3b/0xa0
 ? auxiliary_device_init+0x41/0x90
 add_adev+0xd1/0x150 [mlx5_core]
 mlx5_rescan_drivers_locked+0x21c/0x300 [mlx5_core]
 esw_mode_change+0x6c/0xc0 [mlx5_core]
 mlx5_devlink_eswitch_mode_set+0x21e/0x640 [mlx5_core]
 devlink_nl_eswitch_set_doit+0x60/0xe0
 genl_family_rcv_msg_doit+0xd0/0x120
 genl_rcv_msg+0x180/0x2b0
 ? devlink_get_from_attrs_lock+0x170/0x170
 ? devlink_nl_eswitch_get_doit+0x290/0x290
 ? devlink_nl_pre_doit_port_optional+0x50/0x50
 ? genl_family_rcv_msg_dumpit+0xf0/0xf0
 netlink_rcv_skb+0x54/0x100
 genl_rcv+0x24/0x40
 netlink_unicast+0x1fc/0x2d0
 netlink_sendmsg+0x1e4/0x410
 __sock_sendmsg+0x38/0x60
 ? sockfd_lookup_light+0x12/0x60
 __sys_sendto+0x105/0x160
 ? __sys_recvmsg+0x4e/0x90
 __x64_sys_sendto+0x20/0x30
 do_syscall_64+0x4c/0x100
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f27bc91b13a
Code: bb 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 8b 05 fa 96 2c 00 45 89 c9 4c 63 d1 48 63 ff 85 c0 75 15 b8 2c 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 76 f3 c3 0f 1f 40 00 41 55 41 54 4d 89 c5 55
RSP: 002b:00007fff369557e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000009c54b10 RCX: 00007f27bc91b13a
RDX: 0000000000000038 RSI: 0000000009c54b10 RDI: 0000000000000006
RBP: 0000000009c54920 R08: 00007f27bd0030e0 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
 </TASK>
Modules linked in: mlx5_vdpa vringh vhost_iotlb vdpa xt_MASQUERADE nf_conntrack_netlink nfnetlink iptable_nat xt_addrtype xt_conntrack nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay rpcrdma rdma_ucm ib_iser libiscsi ib_umad scsi_transport_iscsi ib_ipoib rdma_cm iw_cm ib_cm mlx5_fwctl mlx5_ib ib_uverbs ib_core mlx5_core
CR2: 0000000000000010

Fixes: 82f9378c443c ("net/mlx5: Handle IPsec steering upon master unbind/bind")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  5 ++++
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 25 +++++++++++++++++--
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  2 ++
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
index 5d7c15abfcaf..f8eaaf37963b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.h
@@ -342,6 +342,7 @@ void mlx5e_ipsec_build_accel_xfrm_attrs(struct mlx5e_ipsec_sa_entry *sa_entry,
 void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
 				  struct mlx5e_priv *master_priv);
 void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event);
+void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv);
 
 static inline struct mlx5_core_dev *
 mlx5e_ipsec_sa2dev(struct mlx5e_ipsec_sa_entry *sa_entry)
@@ -387,6 +388,10 @@ static inline void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *sl
 static inline void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
 {
 }
+
+static inline void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv)
+{
+}
 #endif
 
 #endif	/* __MLX5E_IPSEC_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
index bf1d2769d4f1..feef86fff4bf 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_fs.c
@@ -2893,9 +2893,30 @@ void mlx5e_ipsec_handle_mpv_event(int event, struct mlx5e_priv *slave_priv,
 
 void mlx5e_ipsec_send_event(struct mlx5e_priv *priv, int event)
 {
-	if (!priv->ipsec)
-		return; /* IPsec not supported */
+	if (!priv->ipsec || mlx5_devcom_comp_get_size(priv->devcom) < 2)
+		return; /* IPsec not supported or no peers */
 
 	mlx5_devcom_send_event(priv->devcom, event, event, priv);
 	wait_for_completion(&priv->ipsec->comp);
 }
+
+void mlx5e_ipsec_disable_events(struct mlx5e_priv *priv)
+{
+	struct mlx5_devcom_comp_dev *tmp = NULL;
+	struct mlx5e_priv *peer_priv;
+
+	if (!priv->devcom)
+		return;
+
+	if (!mlx5_devcom_for_each_peer_begin(priv->devcom))
+		goto out;
+
+	peer_priv = mlx5_devcom_get_next_peer_data(priv->devcom, &tmp);
+	if (peer_priv)
+		complete_all(&peer_priv->ipsec->comp);
+
+	mlx5_devcom_for_each_peer_end(priv->devcom);
+out:
+	mlx5_devcom_unregister_component(priv->devcom);
+	priv->devcom = NULL;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 41fd5eee6306..9c46511e7b43 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -266,6 +266,7 @@ static void mlx5e_devcom_cleanup_mpv(struct mlx5e_priv *priv)
 	}
 
 	mlx5_devcom_unregister_component(priv->devcom);
+	priv->devcom = NULL;
 }
 
 static int blocking_event(struct notifier_block *nb, unsigned long event, void *data)
@@ -6120,6 +6121,7 @@ static void mlx5e_nic_disable(struct mlx5e_priv *priv)
 	if (mlx5e_monitor_counter_supported(priv))
 		mlx5e_monitor_counter_cleanup(priv);
 
+	mlx5e_ipsec_disable_events(priv);
 	mlx5e_disable_blocking_events(priv);
 	mlx5e_disable_async_events(priv);
 	mlx5_lag_remove_netdev(mdev, priv->netdev);
-- 
2.31.1


