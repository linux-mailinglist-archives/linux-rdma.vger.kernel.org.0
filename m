Return-Path: <linux-rdma+bounces-8738-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C99A649F2
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 11:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202E01899D23
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Mar 2025 10:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144323E344;
	Mon, 17 Mar 2025 10:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aeFoNK9q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2084.outbound.protection.outlook.com [40.107.223.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2369B23A560;
	Mon, 17 Mar 2025 10:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207091; cv=fail; b=r/cJlWAaGXDHET4mCY0fxCa1ykH77bgi6opQlHQepdlVcxmEyZM8FK/R9Cn7D0lhsuHOyvNMfzQg4nYQ+70fsGvvqYNb+dZC+SLujR/rz8xZg6uENRHXvieeWc3Zot2wF3Ze/aEBlnuwVtocFyd9auXWxYOJD4XvFRk9aTBP75o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207091; c=relaxed/simple;
	bh=R44Q0zhhsn2kYuDt8KeBTNLPVh7QMrJDvGFvjhnhQfc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bxjFyikPUvWUtiJnsHxuerR/MwEYh4qwbydRNSDUEQ5DuStb17bfWsbW1H4IlL9oK4QVWWJ1FyCzU8TQzaeGhyvq4UW3BfLaG2KYguxIUJsrPYnZh6r3dAGeiMIAhb9T9X6Is3gACgvCR9QiHamXc5K70AcR674qmujJ3kS4qiM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aeFoNK9q; arc=fail smtp.client-ip=40.107.223.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vdX5KiVHb6mSn3hxxUrXsJmsrWilIs9R42eawP5y302aFYuNKymDFBwib0rnkTH/jKUDKlU0AfB2T1ztLiV8Pht1j6tdneE7n47dnEc8v+vXOYUl1cqLE5s1IoJJKoz3cvvnsJQt9yELWuyOG1vEIoMAHbxqzN/Mm9rfnNfII0ermqGqBUbUhI38/UggF++TGgUVCUZsJJoYJ183Y8Qim3ztpII2EktiSIjkdKQETUVm3qPy4A2kwAEZ5ax72o2qLGf7pqtPWXXZkqeFHQTTR9kDJlM8K+xte1jSDs8y9ioXXaM7GJ8Ayfz4KwtSTn7YKos60ImGf9jsaqQOTYv+DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XRfKWZ11dC8efZZwB+Ji5E0BbaSSQdDqwYhm6LxppUo=;
 b=UFNQMCaWnxaj5FF32q0f/RPZCQX56JEtDWb7M9KPhzIbvuGYLvguuSMjxjWQ4eI5WdrOYGrX7et+WeNRWyrkNZ5rhzRehHR/AOdHysH6GcMf4KcgVgEPSNawGmj1/6yD8fSaAKzIhUoMd7vzgxWlbEf+JyOcgy/v1LWGxSb3mpAX43x1hIB3UJCS9qqEtnUZloTlXz6oLxtjv7q6Kq4LkqMAlQhCUCTcfIPBZ/RN964e1amqJ0/td1v9MtV9Cwt40Ulb44YlUI1bpXY8N4DzURP2wImFhms4SfwFYPGZ8RbmuR5gmA+fq+RUkcBH/YQx2nrslDQHZqLjGp6d/+PWng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XRfKWZ11dC8efZZwB+Ji5E0BbaSSQdDqwYhm6LxppUo=;
 b=aeFoNK9qpLztwonzIlOF/xYC7Nlvho1p9joq/d495/VnK5ak/4XcqI84CfIr9yBGdsdsNQFYBWRACittMn+oB3AzlwkFTlg+dZ+rbmcJkSpEfFGgd4YvXYjksy8P5j4KPg4PBYZ2WaW0vJ7t3kmjbnPEOU7p04HjDrOfE6510uyEM/smis4iZFMTfGxOZ03/NnmOLU2XvxYGgD8RIxsxnfyhxS90AuJl074nseSVtN2Tumh0k1Hk8yNFrUzdfcXBJeSwwV2H0/uhQg2DlPLob9uVnPDzQtwNUOHe4ZArel8n9heyzzEGdy0ss1du0PIQXKVr+lBzaXADzyKpDc9hqQ==
Received: from MW4PR03CA0161.namprd03.prod.outlook.com (2603:10b6:303:8d::16)
 by SJ5PPF0C60B25BF.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::98a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 17 Mar
 2025 10:24:44 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:303:8d:cafe::6c) by MW4PR03CA0161.outlook.office365.com
 (2603:10b6:303:8d::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.32 via Frontend Transport; Mon,
 17 Mar 2025 10:24:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Mon, 17 Mar 2025 10:24:43 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Mar
 2025 03:24:34 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 17 Mar 2025 03:24:34 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 17 Mar 2025 03:24:31 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Leon Romanovsky <leon@kernel.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	Mark Zhang <markzhang@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH net] rtnetlink: Allocate vfinfo size for VF GUIDs when supported
Date: Mon, 17 Mar 2025 12:24:19 +0200
Message-ID: <20250317102419.573846-1-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|SJ5PPF0C60B25BF:EE_
X-MS-Office365-Filtering-Correlation-Id: 8371d403-a7c2-4753-ee21-08dd653def13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3/ltdwXfn23cHJgkfdqDSLJHC94GsW5T3KVydrAwl6btiTfK1l6sZApFmfoH?=
 =?us-ascii?Q?b3mnwWSJIy+l4TcP5EuulLGUnJHelFinG/Zc5kdv8Ad+gsnjuQ6YF+OOB+7Y?=
 =?us-ascii?Q?oSrJaQoKm+2my1zr2NZAaUYldNTcJPjqfvswqFzUXjfYxFZDpM8rfNebtKuU?=
 =?us-ascii?Q?APY1SyTAEhjCPOGt+sXAO5XaOct3gUTBb1SlEgGBhqSyVGV5sUxO1Ut4sOMv?=
 =?us-ascii?Q?kkT6dohYqyANvYzuXACyuLp+3u/pmsKzrVqcIwEN7LErBZVB//hX5Cr/E4MR?=
 =?us-ascii?Q?n5B8TNDHuRXh4YpDyCbHfkqou8LYH700BcYzjLUyuY3qQCHb4Cja4fn9FX7X?=
 =?us-ascii?Q?zQ/zL9fTQ6wctTt8ZTtk/8kjfjSY4xOm0YoBwcEXSD+NnWFkjDcShHb3jenm?=
 =?us-ascii?Q?dQUWNTkBb7bSb9LTPcvrxptUcZJeAsPRw+4m9DMxoaoLf/ZqFXB+WlBO5e7A?=
 =?us-ascii?Q?NFSnImVPsyzrrhBMHLHNy3OnnkNDL/PGZyhbFdYD1GWXbaGw+gjLHLRCIpar?=
 =?us-ascii?Q?sjC1ZQkHdutKpB/Ez51sQGURtUWRyNsB1eA1OBTIaMb0FW/jboiFX4HGuEO2?=
 =?us-ascii?Q?kxCn0AScd+q01myYVV5vdzyaVJsbajDxNpEp059h/edNNPXcspIGZQclykab?=
 =?us-ascii?Q?s9YqNv1Fj0+6mL6COOOA2J+dJlRP6zLtCc/VWWNOyukX1FTL+vMuBfDQys2F?=
 =?us-ascii?Q?jRTS+ZCSNF73zJ9XC6Gg6VbAUmmA2HFfHWz26cg1lyj33WF65Oo0/hpvVi5q?=
 =?us-ascii?Q?WivkKZbaS25v9i++tVQ98f2tKwKfAIR+17c9vN4IH3BmKRdplFpblXJn28QK?=
 =?us-ascii?Q?RyEK+pq8f3g/3yuHlbSll+76fPiczeD89VJAQYCKu+bdO4hzF2U9VECmuivm?=
 =?us-ascii?Q?s+KqAOvLGj6aWK8W3Cq+nmneBDZKqfA05fNO8CJTlYq6BBogSObE3Nw1xNzM?=
 =?us-ascii?Q?KUM1uYTS2EUl4EUQOa7FGVj9niqbq2JDZ8Drl4SElv6YpmVQt0BDH9TLztu8?=
 =?us-ascii?Q?+wIZybwzt6Zfbz1tpwzUI5JkUbx/qYrKA49m4NDncCnRiRk8pYbYtblJoLBT?=
 =?us-ascii?Q?HcBH60xFIbAOIyReSArf7IuiJj7nvHfe57Qo1DY98WbeFigsf/ONXxeJrOVl?=
 =?us-ascii?Q?zk0lj//L6rX6wPorHqOBYnsqHMafFBlYKq/GMbUZ52L7jfiN7YWz6dx7KL+z?=
 =?us-ascii?Q?D9axOoTQwVQOCspLoLYM5Ub2qsH8PLfy8NN4uZhULELid/8LVZgzb49kD7QB?=
 =?us-ascii?Q?MHMZ+xkXwOFogSg7U//nD+BrCy17gAUi9Xi069wcP8AzS9FcHWT7vwDmhrNF?=
 =?us-ascii?Q?+bpKj0mjAVsC+0WzhB7c2SzWf5kZ9MgD66RRc398vcKU2qSpMxJIZzJZEYOz?=
 =?us-ascii?Q?J+c8+CxLGBAW96oRVMTheqqrFvkoXGGyWdBy3m1bgRI47/Pvt5/4ryq6cl9h?=
 =?us-ascii?Q?tZqeYVcE3mraCizj/nMYSpt6Iu5HsR9T9c8V29u5Arlmx1BRn5ErgS0zCbIM?=
 =?us-ascii?Q?jU0Nb8VQPU4PGok=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 10:24:43.4168
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8371d403-a7c2-4753-ee21-08dd653def13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0C60B25BF

From: Mark Zhang <markzhang@nvidia.com>

Commit 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
added support for getting VF port and node GUIDs in netlink ifinfo
messages, but their size was not taken into consideration in the
function that allocates the netlink message, causing the following
warning when a netlink message is filled with many VF port and node
GUIDs:
 # echo 64 > /sys/bus/pci/devices/0000\:08\:00.0/sriov_numvfs
 # ip link show dev ib0
 RTNETLINK answers: Message too long
 Cannot send link get request: Message too long

Kernel warning:

 ------------[ cut here ]------------
 WARNING: CPU: 2 PID: 1930 at net/core/rtnetlink.c:4151 rtnl_getlink+0x586/0x5a0
 Modules linked in: xt_conntrack xt_MASQUERADE nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter overlay mlx5_ib macsec mlx5_core tls rpcrdma rdma_ucm ib_uverbs ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm iw_cm ib_ipoib fuse ib_cm ib_core
 CPU: 2 UID: 0 PID: 1930 Comm: ip Not tainted 6.14.0-rc2+ #1
 Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
 RIP: 0010:rtnl_getlink+0x586/0x5a0
 Code: cb 82 e8 3d af 0a 00 4d 85 ff 0f 84 08 ff ff ff 4c 89 ff 41 be ea ff ff ff e8 66 63 5b ff 49 c7 07 80 4f cb 82 e9 36 fc ff ff <0f> 0b e9 16 fe ff ff e8 de a0 56 00 66 66 2e 0f 1f 84 00 00 00 00
 RSP: 0018:ffff888113557348 EFLAGS: 00010246
 RAX: 00000000ffffffa6 RBX: ffff88817e87aa34 RCX: dffffc0000000000
 RDX: 0000000000000003 RSI: 0000000000000000 RDI: ffff88817e87afb8
 RBP: 0000000000000009 R08: ffffffff821f44aa R09: 0000000000000000
 R10: ffff8881260f79a8 R11: ffff88817e87af00 R12: ffff88817e87aa00
 R13: ffffffff8563d300 R14: 00000000ffffffa6 R15: 00000000ffffffff
 FS:  00007f63a5dbf280(0000) GS:ffff88881ee00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: 00007f63a5ba4493 CR3: 00000001700fe002 CR4: 0000000000772eb0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  ? __warn+0xa5/0x230
  ? rtnl_getlink+0x586/0x5a0
  ? report_bug+0x22d/0x240
  ? handle_bug+0x53/0xa0
  ? exc_invalid_op+0x14/0x50
  ? asm_exc_invalid_op+0x16/0x20
  ? skb_trim+0x6a/0x80
  ? rtnl_getlink+0x586/0x5a0
  ? __pfx_rtnl_getlink+0x10/0x10
  ? rtnetlink_rcv_msg+0x1e5/0x860
  ? __pfx___mutex_lock+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? __pfx_lock_acquire+0x10/0x10
  ? stack_trace_save+0x90/0xd0
  ? filter_irq_stacks+0x1d/0x70
  ? kasan_save_stack+0x30/0x40
  ? kasan_save_stack+0x20/0x40
  ? kasan_save_track+0x10/0x30
  rtnetlink_rcv_msg+0x21c/0x860
  ? entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
  ? arch_stack_walk+0x9e/0xf0
  ? rcu_is_watching+0x34/0x60
  ? lock_acquire+0xd5/0x410
  ? rcu_is_watching+0x34/0x60
  netlink_rcv_skb+0xe0/0x210
  ? __pfx_rtnetlink_rcv_msg+0x10/0x10
  ? __pfx_netlink_rcv_skb+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? __pfx___netlink_lookup+0x10/0x10
  ? lock_release+0x62/0x200
  ? netlink_deliver_tap+0xfd/0x290
  ? rcu_is_watching+0x34/0x60
  ? lock_release+0x62/0x200
  ? netlink_deliver_tap+0x95/0x290
  netlink_unicast+0x31f/0x480
  ? __pfx_netlink_unicast+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? lock_acquire+0xd5/0x410
  netlink_sendmsg+0x369/0x660
  ? lock_release+0x62/0x200
  ? __pfx_netlink_sendmsg+0x10/0x10
  ? import_ubuf+0xb9/0xf0
  ? __import_iovec+0x254/0x2b0
  ? lock_release+0x62/0x200
  ? __pfx_netlink_sendmsg+0x10/0x10
  ____sys_sendmsg+0x559/0x5a0
  ? __pfx_____sys_sendmsg+0x10/0x10
  ? __pfx_copy_msghdr_from_user+0x10/0x10
  ? rcu_is_watching+0x34/0x60
  ? do_read_fault+0x213/0x4a0
  ? rcu_is_watching+0x34/0x60
  ___sys_sendmsg+0xe4/0x150
  ? __pfx____sys_sendmsg+0x10/0x10
  ? do_fault+0x2cc/0x6f0
  ? handle_pte_fault+0x2e3/0x3d0
  ? __pfx_handle_pte_fault+0x10/0x10
  ? preempt_count_sub+0x14/0xc0
  ? __down_read_trylock+0x150/0x270
  ? __handle_mm_fault+0x404/0x8e0
  ? __pfx___handle_mm_fault+0x10/0x10
  ? lock_release+0x62/0x200
  ? __rcu_read_unlock+0x65/0x90
  ? rcu_is_watching+0x34/0x60
  __sys_sendmsg+0xd5/0x150
  ? __pfx___sys_sendmsg+0x10/0x10
  ? __up_read+0x192/0x480
  ? lock_release+0x62/0x200
  ? __rcu_read_unlock+0x65/0x90
  ? rcu_is_watching+0x34/0x60
  do_syscall_64+0x6d/0x140
  entry_SYSCALL_64_after_hwframe+0x76/0x7e
 RIP: 0033:0x7f63a5b13367
 Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
 RSP: 002b:00007fff8c726bc8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
 RAX: ffffffffffffffda RBX: 0000000067b687c2 RCX: 00007f63a5b13367
 RDX: 0000000000000000 RSI: 00007fff8c726c30 RDI: 0000000000000004
 RBP: 00007fff8c726cb8 R08: 0000000000000000 R09: 0000000000000034
 R10: 00007fff8c726c7c R11: 0000000000000246 R12: 0000000000000001
 R13: 0000000000000000 R14: 00007fff8c726cd0 R15: 00007fff8c726cd0
  </TASK>
 irq event stamp: 0
 hardirqs last  enabled at (0): [<0000000000000000>] 0x0
 hardirqs last disabled at (0): [<ffffffff813f9e58>] copy_process+0xd08/0x2830
 softirqs last  enabled at (0): [<ffffffff813f9e58>] copy_process+0xd08/0x2830
 softirqs last disabled at (0): [<0000000000000000>] 0x0
 ---[ end trace 0000000000000000 ]---

Thus, when calculating ifinfo message size, take VF GUIDs sizes into
account when supported.

Fixes: 30aad41721e0 ("net/core: Add support for getting VF GUIDs")
Signed-off-by: Mark Zhang <markzhang@nvidia.com>
Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 net/core/rtnetlink.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d1e559fce918..bfc590e933d9 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1150,7 +1150,9 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
 			 nla_total_size(sizeof(struct ifla_vf_rate)) +
 			 nla_total_size(sizeof(struct ifla_vf_link_state)) +
 			 nla_total_size(sizeof(struct ifla_vf_rss_query_en)) +
-			 nla_total_size(sizeof(struct ifla_vf_trust)));
+			 nla_total_size(sizeof(struct ifla_vf_trust)) +
+			 (dev->netdev_ops->ndo_get_vf_guid ?
+			  nla_total_size(sizeof(struct ifla_vf_guid)) * 2 : 0));
 		if (~ext_filter_mask & RTEXT_FILTER_SKIP_STATS) {
 			size += num_vfs *
 				(nla_total_size(0) + /* nest IFLA_VF_STATS */
-- 
2.34.1


