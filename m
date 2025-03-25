Return-Path: <linux-rdma+bounces-8928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 565B5A6EC13
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 10:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCF737A346E
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Mar 2025 09:01:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3591DBB13;
	Tue, 25 Mar 2025 09:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="kIvuz2TP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2087.outbound.protection.outlook.com [40.107.212.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94B22F3B;
	Tue, 25 Mar 2025 09:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742893376; cv=fail; b=iihvQRWQIdqScLazofxE3LDSqmCy0iAgDkIp4eWh6rIPcquOz29o5mvK/12XNWVc43RC9+hslhX6Dw0W7xT51Ncj0gCXdzNLgO+2tYJOBz8FnmQKJuNhTzK3YneFmCRWBNCMMWJRH43nJoDrpw5ia/Om86/Y4a55KLo4nY3ZV9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742893376; c=relaxed/simple;
	bh=i0s1ly49sH8fFRbhPQoiXHphsGcLzU55OHnTJM38iIs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YeezGJaraoiXhyrqee9Rild/hCjnt8u8oc4XSjkcm0/ddrYtzhVhcjg70DMCnld12dLSw2F3/O0JWadjl52t5KcdmeM6/E497geyva/jfwn8bl61ssPjR+kEIGwxCwNdqEwpnjeg8B7PeSmvslHL70OC5oAe6l6iLItKcoSdWXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=kIvuz2TP; arc=fail smtp.client-ip=40.107.212.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qp17M3kiXudeU1XrCLc3pwfRihMLB+kpk3fbIblivUlVC6O9U6/cH7WtWrhUHerQdFzFbJAVGoWvOkwy1ptFOcuWuMY6onfp2ciVIrHQGIjYaoIR8oUz15LPT3pJqoP6tJS9UnbnDzCibQUBEWcM2cGr+5tSTRHyWYoZThsYOm5ohpXdOWZi4xKAwXymtl7fTlSMaOIeJrPEwmbbHCWiPkBP0dGNvkGCXTGILjsjEQRdS7Kb8CxXpHQB3dOVEfLsCwnv6IY6jgSdl428tndzWGmRXBM7IFM+OqJC6pMkn0d+mKxqG39L0vBVYLZM13Et5xzgCRiikgWp2Djgfrmcbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwQse9kN576vZBK2/haJub2/SJWJrvrUNOsA/K/ZWzM=;
 b=X4K5yFBjL67rJdVd7btXX1s30fYA/Y2MHPzPGoAjiPXGAOnLvayvgPKZc+QV5DOQbLwBXnVOkD0JF5VhGo04C1SZoxUvvEiLD0X+IVxMp+t3DhmMAQPxLt3ZLeuwYBtUeYGPXzgTLYqsJkpQ0CuV3eaUlh511OzM2rbyB+K9pwtJhu6B/QUmWV5lFfETHEQZxWBa9NeoVqln5bPm1eCfy7jq8n0bNRCBIhZdKLFoOXVf+tKOIhiKLcyYY8AlVhtVzFIhYfIS7JnxisBJPvLzuq7zxY9XO61kH6IT59b/Qo54MjLjnCH8URsjNyRMvoAKac/2kTl1vdg+BmLSmavNyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwQse9kN576vZBK2/haJub2/SJWJrvrUNOsA/K/ZWzM=;
 b=kIvuz2TP/AY/ANlGmJNYaN38HYvCOEOk+SfZfyc1lHIVMzHgQ/pEOboGHbmzjgHP65yR9xlYFu6an9ld6E49/xC5CZhjmP+kfen2KChxxMuQrCvL9/xLJwCSfeO7ATTR57yzPTGSCZ+PYecfF3ak5dqmGeuVLczEZ1t7Tp+OKYdYa/uRj46A5Xyf7BsQm5dTo6/jR1ioCik+xla67AacWYlGXYZPBTjmOWQwZPef1jc5CEZYCgmEMhk/HcTfhqrm+dfJ1z9d5kwb9Dwy05S3dwurHktl6BWVMpPtM+rpBJRhzdsrM/j/3dIAFcI8nPN1Mu2V86dV8TCJ88D8B6JBDQ==
Received: from PH7PR13CA0011.namprd13.prod.outlook.com (2603:10b6:510:174::26)
 by DS7PR12MB5765.namprd12.prod.outlook.com (2603:10b6:8:74::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Tue, 25 Mar
 2025 09:02:48 +0000
Received: from SJ1PEPF000023D5.namprd21.prod.outlook.com
 (2603:10b6:510:174:cafe::78) by PH7PR13CA0011.outlook.office365.com
 (2603:10b6:510:174::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Tue,
 25 Mar 2025 09:02:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF000023D5.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.2 via Frontend Transport; Tue, 25 Mar 2025 09:02:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Mar
 2025 02:02:36 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Mar
 2025 02:02:35 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Tue, 25
 Mar 2025 02:02:32 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Sabrina Dubroca <sd@queasysnail.net>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Leon Romanovsky <leon@kernel.org>, David Ahern
	<dsahern@kernel.org>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	Mark Zhang <markzhang@nvidia.com>, Maher Sanalla <msanalla@nvidia.com>, "Mark
 Bloch" <mbloch@nvidia.com>
Subject: [PATCH v2 net] rtnetlink: Allocate vfinfo size for VF GUIDs when supported
Date: Tue, 25 Mar 2025 11:02:26 +0200
Message-ID: <20250325090226.749730-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D5:EE_|DS7PR12MB5765:EE_
X-MS-Office365-Filtering-Correlation-Id: 92828a40-ed61-4750-bd52-08dd6b7bd06f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uQkJ3HS0szhyVk7qPqWB9wlf1UcGZb6nKpR8occ28Ls6R+HF/2CrWlQrQyCr?=
 =?us-ascii?Q?rxJcmr08pmpCg4qi7TXR7MJsHbnzud0l3ktV3so25ISg/2aHM+1/CWAZ21Ab?=
 =?us-ascii?Q?V3Xgfx43h5e/l6GRwZz591zEi40UIZDQXPDU1IrCthVeHeeev91kALEaimEZ?=
 =?us-ascii?Q?XzGmC8YLtO5b+FPq/QOkPyptm67t6WBm9KGlZN6BF1XZoL9DjOsmsz3cOYjn?=
 =?us-ascii?Q?eRyoZ0LhZcy/b4MqrxKgF4W2/nhwPzUewqgwZwHBjBDmXSFj2yX5KkZ0gTEL?=
 =?us-ascii?Q?xl2Zsg8cKbxL3+RDF1Ac9bBLgbTGV79HakhQGfYy+cHdDaavHlVzF0F7C+4Z?=
 =?us-ascii?Q?JnXz28UPLbaoZ7ZetM2ZVAOhvAtDCeGNl4ZtMf+4z+dKK0neuJw7hARkz98p?=
 =?us-ascii?Q?KTqI3xeJeLUb7R2ljD/13jfHFSOz4pGIfuJszPC3ioaf6C/SFqCzgrHHAKQr?=
 =?us-ascii?Q?VG0Ll2qdLi+uQAVAxroGgD18kvVOc8vxh23MaQ0Ca8rthxOG3M7JVWUT3Rur?=
 =?us-ascii?Q?x9HJfIrmsmEnTsTMrMsOO0WMmSo6fWyfsuuIz1as8KFE8kEl05H7X7JYQhxv?=
 =?us-ascii?Q?iVDlK1pMP1AcsbkTxqjMRce0o8roXlcRMHBkOuv33FeDK8NI7VfY0goOjjDu?=
 =?us-ascii?Q?McCHPyrW8E7WIZkzFTkC0+NRhL0yPewg5op5sUtxKTG8YTAN5uUqWB/2P6JM?=
 =?us-ascii?Q?KR995/Vjwwit07GlT35AUfXobXBjfVEqmpKPizXRV93+oQwa/vikKug6NmrT?=
 =?us-ascii?Q?aVAbc8XPBj+MjJbiBNw1CpFrd5vnoNCG3Sy91ijWtXOZ/wFBhg8bvjXRMIaD?=
 =?us-ascii?Q?HuYTn2P2kc0ypeYC0oZEr0vAcgvHUTCbZV21jllIAcrvmkKRy0eWjqv+ViH2?=
 =?us-ascii?Q?zXsYLZHfYp+ZhRRIluHmUvffmJQX1ma5AwUhS4yWA1Ztxm6vyQ/ZKFhc0OR9?=
 =?us-ascii?Q?alT6fNdqZR58GU7sjz6ElWYheMaHorIiCS7313lY9g8KOMZ0bRK+1pcjuUte?=
 =?us-ascii?Q?zMetkhjJQq5kiXjmQmOwbAmhWPGddi0cIhR9UOv/P80JAbRFTgRxSEc2Iunw?=
 =?us-ascii?Q?WRSb1DqWQLrM08ozaWcwDA4qoyL0BkSScJtpMoq49+fezMFBpeg+MxaWKe5g?=
 =?us-ascii?Q?6q7/yDW7TdpVhn3mcpf22GCRP+ZVClByM2fT62CUS3wvGIAYN6x6x6GYlYAG?=
 =?us-ascii?Q?bsP/NbKNXU1WiMbN0NDE+ImRpNoR4G//TebiN5tvTdFzi9C8tKoCJ7T8/IxJ?=
 =?us-ascii?Q?3Q1t4Fx0Dl3MxOKc9SfxA2YRWmoERzILA9APRXdebdx8zc8ir+/FxSnRTj4N?=
 =?us-ascii?Q?Hwl4MAAmFzYTtZvM4zyCnehqj103D98Y1lijedcFS4Kda6b6zKSOS5ucurXA?=
 =?us-ascii?Q?/uyddIFyLWFzYASM23Mne9Wbj73nyOGDfErPInzSi6CfsZqhEVnAtb3jHXED?=
 =?us-ascii?Q?8vq75f4rmISLJVMRTmXAleuL1WtTAchJ2u/gXR+9nKQejUtLYDyJ9lljf9/3?=
 =?us-ascii?Q?l0R5s7pefc02lcQ=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2025 09:02:47.7373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 92828a40-ed61-4750-bd52-08dd6b7bd06f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023D5.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5765

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
v2: Moved the ndo check into a seperate if as suggested by
    Simon Horman and Jakub Kicinski.

 net/core/rtnetlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d1e559fce918..80e006940f51 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -1171,6 +1171,9 @@ static inline int rtnl_vfinfo_size(const struct net_device *dev,
 				 /* IFLA_VF_STATS_TX_DROPPED */
 				 nla_total_size_64bit(sizeof(__u64)));
 		}
+		if (dev->netdev_ops->ndo_get_vf_guid)
+			size += num_vfs * 2 *
+				nla_total_size(sizeof(struct ifla_vf_guid));
 		return size;
 	} else
 		return 0;
-- 
2.34.1


