Return-Path: <linux-rdma+bounces-10264-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD81AB27A6
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 12:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 233F77AB24C
	for <lists+linux-rdma@lfdr.de>; Sun, 11 May 2025 10:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B36731CDA3F;
	Sun, 11 May 2025 10:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="iLUcaXar"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2076.outbound.protection.outlook.com [40.107.95.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CC71C84A5;
	Sun, 11 May 2025 10:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746958585; cv=fail; b=QIma/yBxBvZuHTBYg5SnuoNHNrKnlVEojvS7ONrp74uFZtJ2UXlkGgYMtjIGIg+RTMQJ7KK7F3dA5CtBYTq4b6pzU9KobHT564b74mu6iXaz7FwQ5xJ9GdK0BYiKfPGirV2ZR7nSwgeoBBPcJbad0yu439//b9MmFaB26NLlwx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746958585; c=relaxed/simple;
	bh=mBy0Gyk7NpydjmoIKNGoo6cLuaRzYQeJPHA8+QHe2V0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Em71Cw4nMRhvQCIq00XLbtc+5Vif0swZoCbD3McuFIZPaB3DiJlORx1oHZeBTEizon/aA1A0O7eSbGzTRVV4QMOEC0QUXq/IF4prb3+62u+CBdozvhuCRsdvTNjp5BG9VaxxyZE5ARzoJb1/u1taksB7Xlaxthj12i033FuUPFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=iLUcaXar; arc=fail smtp.client-ip=40.107.95.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NT5z2pMM3yxijdILwf+czE6Wewy9ueku680ijuIhwkeit5r1MjZj809NNsCHQlBB/6naMQV4Dsbiu/lhNeeazHu7hmWhOX/z2THmo7I6i0Ba0yCZv9QZ4V4DJSBZM5SaFj6HOzvC6Hcp0LtX/5kl/zkndSzPYSMubbLLvJ3CwA7LjO2br8CNVbJll6nb0YCMT769Cvvcxhni1CVDYuSnLK9RG05tIHYCiKqWngykPzJb8L8ZfObAnikLOwE15w1hdLoagHWGk6KxnuR9ijewwt9lqlrrUuZ49XlV7mqPYbOXrmOSblTthLzVxDhfAFvlq/04K1Ya4qrGYso0iIXY0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TLYBSk5DjMVIrMuODyL5z+kbJQZXylh4NZ1sDJsp/KA=;
 b=hfNCpsCdlQ4G4NTdhbbF0fKP46yqPkiFsKbYmiMukNypewjvv+qRQyoAYRVIPcOlT7ubJeB+9gz697mzYQb57j0lBvWEJQewr9PnjCA5hXO9xGzwfmBWpwGlz/f2uvUMZFL9VDfS09e/HRl52zVGr5OUTodEwEOLMLuUwa8YdhZKljNpJzvILxaKo7Ga7nHVcvWIzluEUN6OJE4QKkX/xRYdG0Yes/O+c9JtGWh9qAzk4XemWcEyFOJHzF0gjSRyFKetK3r6piCkcGSghwkPk7+8a2fep3VrgOhngRistqEPIAACPk8Q0Oar3bRr6icTypKil8KoTd2m1gjNf8Nrzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TLYBSk5DjMVIrMuODyL5z+kbJQZXylh4NZ1sDJsp/KA=;
 b=iLUcaXarl024rA9bw8xMXEVuw2YBtdVHX4qii8xifIHmhoraRiiSXt4PWzcAvH1p9DuQCf7Reoid3AQiptlVuyEoZWUuXzL8Hrz2+xrROgdjNMnqLUOZuySKP6ULBwobTc/fJNGDIao/vGeWFz2O249AeS1X2TJIWjVdJ8zQZ5o/4DnV2GqPawZanWbkDKAQV361Hc59TogH6z4AzovBggg4U8jxx7eeaIFomzPyjP9fk3wvpbrYRj0DDkxhhcg57G8bqo7qSGYa/Ry+5wKwC6jF56JKwlhZCn/MBhq7ituJe9mEHsCwhTFHsJrOAqUJzq/sXFplPzDXVKSKh+Xt+Q==
Received: from CH2PR10CA0022.namprd10.prod.outlook.com (2603:10b6:610:4c::32)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.22; Sun, 11 May
 2025 10:16:17 +0000
Received: from CH1PEPF0000A345.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::21) by CH2PR10CA0022.outlook.office365.com
 (2603:10b6:610:4c::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Sun,
 11 May 2025 10:16:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A345.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8722.18 via Frontend Transport; Sun, 11 May 2025 10:16:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 11 May
 2025 03:16:04 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 11 May
 2025 03:16:04 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 11
 May 2025 03:16:01 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	"Leon Romanovsky" <leon@kernel.org>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Moshe Shemesh
	<moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>
Subject: [PATCH net] net/mlx5e: Disable MACsec offload for uplink representor profile
Date: Sun, 11 May 2025 13:15:52 +0300
Message-ID: <1746958552-561295-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A345:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: 892d39dd-b099-43bd-f0b0-08dd9074dd9f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?C87CJBN1CSANNCzaYtYXaJnaGiyRIdl2yjUfcilpAG3WXfYqvFHtCJNpajMe?=
 =?us-ascii?Q?XCMsTD1SiZwVTRbLoW8oke3HskT1P0Vp5+u8mKBhEHHM+KMRn67b1V/EvnRK?=
 =?us-ascii?Q?x0Wya6+DAouSODjxd5boren6giqjGYGywdpmURVxL2sztZP+zXRF+BwDWEBl?=
 =?us-ascii?Q?n8Rntm6GY1uuC19C+S/xP4LY2YuBQ8BAW1dBFbXZwNWrdW+ILup4WX0v4+IM?=
 =?us-ascii?Q?D3LTdpmdJpQTFUcRwmXIEJ/YZJIWZ3VNTeA1QaG5NrVL/4f5jPpbYLfFABKi?=
 =?us-ascii?Q?QK+Cj5SitbEcEWta0OdqLaGrxWHlZvslnlmhXHzdi8ewB+yaBE5SWIsJUo46?=
 =?us-ascii?Q?m0C2D+AiuCv/Jm4GZ53azff6CpVX51/okJnRF0y2iv7AnT/rPhLnP7pXDlgh?=
 =?us-ascii?Q?eEowe5udoMwxsXN6mRttRXdOnOcdx6SO6QFoHpbzDDRHKJtDVeBFxbXIEY2E?=
 =?us-ascii?Q?lYC/ZK5uys1sroIQDWyH8c2IgIcitwB0wfesejIY+me+rSrhb+IjvdvWRnlL?=
 =?us-ascii?Q?d831REKaicNf+O3HdXP0tqpcfxfzO7T+YQtlX75SbPxp05PA0ZzAC5XOJt0U?=
 =?us-ascii?Q?1cKWiaE5DSlAQ2xw34vT7f8iV7OXymqZPiBsSapWT2NaDrJFKohZVFDnRkOE?=
 =?us-ascii?Q?W5wFbFooRAKNcK7kiIzX+kFHrLKXdVipu9rv3rV7aLS7pRBEqpS5hoitBoaE?=
 =?us-ascii?Q?PzQQL7mfl7PevjDFaQJN2p2osMyTSppQwXpVXivUDB0oH3iTziwguZkIyJoO?=
 =?us-ascii?Q?/JnbpL3K55GVjp9Il3tNEyZbrAhaA4RQ9scHWX7/8XHruOOL00j1F5wD2Heg?=
 =?us-ascii?Q?lA2ySHzxTzdTz0T4dDK3kew7v/5T8zAblPdzR4U+IV4cgecKiKY309G06EZu?=
 =?us-ascii?Q?GhleCQmUOe6oHaJISx954GIHuKMGprI4BndICEVr66OeNx8fHsIhQJnr2iKO?=
 =?us-ascii?Q?MnUNIud9Cvc83QmlICIcLaRVNEBS79cHczjNo2R5jq1HWwfKVobPooSg7HI+?=
 =?us-ascii?Q?Z1kVEaZa18Hg/zwI+g/qMoDOhLuJNp3kWmEW0YE6tfSH/yRF/EVKo8NNlDaS?=
 =?us-ascii?Q?RT0DfPamwwQXTdRcQXwgnENV/iGD2fPjj9jXUPLz89ztRQau5iNKFyq7zkCv?=
 =?us-ascii?Q?BWXqByNrYHwlVWXpsjowJy17eLDVY03GfMuTX4peNrv++ND432C1WalkoUla?=
 =?us-ascii?Q?9ZbayHO5UM1mzKEWjLiTIl+uCRn1zpa/TGBGRLYNSk4+A332bMIR/VQuHRxr?=
 =?us-ascii?Q?yrU23ceizbqJqbzNWsgTYxD31CtnExLRBx3+xpOeLA90cimEbzaa4A4PWLMv?=
 =?us-ascii?Q?OnJTxgkMCiy3n140cK9GI283+yS2MTs+V3xqdX6nGCyLwieZ38J0NJNvETbJ?=
 =?us-ascii?Q?+SlALBZ4pYdn9nvi+ETyKlRqF1ONWB219XnNkuBV0qJrukrNVqMvsX6IOehY?=
 =?us-ascii?Q?rtbgR7H97OmadiddU3IiyUtRmt7l4sV4rRSRxehSC0CebXi6Su/IgJPZuB08?=
 =?us-ascii?Q?evKCq1U2kKmD56oj8CUqWHaSXTnAMeNERzQw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2025 10:16:16.4099
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 892d39dd-b099-43bd-f0b0-08dd9074dd9f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A345.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500

From: Carolina Jubran <cjubran@nvidia.com>

MACsec offload is not supported in switchdev mode for uplink
representors. When switching to the uplink representor profile, the
MACsec offload feature must be cleared from the netdevice's features.

If left enabled, attempts to add offloads result in a null pointer
dereference, as the uplink representor does not support MACsec offload
even though the feature bit remains set.

Clear NETIF_F_HW_MACSEC in mlx5e_fix_uplink_rep_features().

Kernel log:

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 29 UID: 0 PID: 4714 Comm: ip Not tainted 6.14.0-rc4_for_upstream_debug_2025_03_02_17_35 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:__mutex_lock+0x128/0x1dd0
Code: d0 7c 08 84 d2 0f 85 ad 15 00 00 8b 35 91 5c fe 03 85 f6 75 29 49 8d 7e 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 a6 15 00 00 4d 3b 76 60 0f 85 fd 0b 00 00 65 ff
RSP: 0018:ffff888147a4f160 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 000000000000000f RSI: 0000000000000000 RDI: 0000000000000078
RBP: ffff888147a4f2e0 R08: ffffffffa05d2c19 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000018 R15: ffff888152de0000
FS:  00007f855e27d800(0000) GS:ffff88881ee80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e5768 CR3: 000000013ae7c005 CR4: 0000000000372eb0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe07f0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? die_addr+0x3d/0xa0
 ? exc_general_protection+0x144/0x220
 ? asm_exc_general_protection+0x22/0x30
 ? mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
 ? __mutex_lock+0x128/0x1dd0
 ? lockdep_set_lock_cmp_fn+0x190/0x190
 ? mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
 ? mutex_lock_io_nested+0x1ae0/0x1ae0
 ? lock_acquire+0x1c2/0x530
 ? macsec_upd_offload+0x145/0x380
 ? lockdep_hardirqs_on_prepare+0x400/0x400
 ? kasan_save_stack+0x30/0x40
 ? kasan_save_stack+0x20/0x40
 ? kasan_save_track+0x10/0x30
 ? __kasan_kmalloc+0x77/0x90
 ? __kmalloc_noprof+0x249/0x6b0
 ? genl_family_rcv_msg_attrs_parse.constprop.0+0xb5/0x240
 ? mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
 mlx5e_macsec_add_secy+0xf9/0x700 [mlx5_core]
 ? mlx5e_macsec_add_rxsa+0x11a0/0x11a0 [mlx5_core]
 macsec_update_offload+0x26c/0x820
 ? macsec_set_mac_address+0x4b0/0x4b0
 ? lockdep_hardirqs_on_prepare+0x284/0x400
 ? _raw_spin_unlock_irqrestore+0x47/0x50
 macsec_upd_offload+0x2c8/0x380
 ? macsec_update_offload+0x820/0x820
 ? __nla_parse+0x22/0x30
 ? genl_family_rcv_msg_attrs_parse.constprop.0+0x15e/0x240
 genl_family_rcv_msg_doit+0x1cc/0x2a0
 ? genl_family_rcv_msg_attrs_parse.constprop.0+0x240/0x240
 ? cap_capable+0xd4/0x330
 genl_rcv_msg+0x3ea/0x670
 ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
 ? lockdep_set_lock_cmp_fn+0x190/0x190
 ? macsec_update_offload+0x820/0x820
 netlink_rcv_skb+0x12b/0x390
 ? genl_family_rcv_msg_dumpit+0x2a0/0x2a0
 ? netlink_ack+0xd80/0xd80
 ? rwsem_down_read_slowpath+0xf90/0xf90
 ? netlink_deliver_tap+0xcd/0xac0
 ? netlink_deliver_tap+0x155/0xac0
 ? _copy_from_iter+0x1bb/0x12c0
 genl_rcv+0x24/0x40
 netlink_unicast+0x440/0x700
 ? netlink_attachskb+0x760/0x760
 ? lock_acquire+0x1c2/0x530
 ? __might_fault+0xbb/0x170
 netlink_sendmsg+0x749/0xc10
 ? netlink_unicast+0x700/0x700
 ? __might_fault+0xbb/0x170
 ? netlink_unicast+0x700/0x700
 __sock_sendmsg+0xc5/0x190
 ____sys_sendmsg+0x53f/0x760
 ? import_iovec+0x7/0x10
 ? kernel_sendmsg+0x30/0x30
 ? __copy_msghdr+0x3c0/0x3c0
 ? filter_irq_stacks+0x90/0x90
 ? stack_depot_save_flags+0x28/0xa30
 ___sys_sendmsg+0xeb/0x170
 ? kasan_save_stack+0x30/0x40
 ? copy_msghdr_from_user+0x110/0x110
 ? do_syscall_64+0x6d/0x140
 ? lock_acquire+0x1c2/0x530
 ? __virt_addr_valid+0x116/0x3b0
 ? __virt_addr_valid+0x1da/0x3b0
 ? lock_downgrade+0x680/0x680
 ? __delete_object+0x21/0x50
 __sys_sendmsg+0xf7/0x180
 ? __sys_sendmsg_sock+0x20/0x20
 ? kmem_cache_free+0x14c/0x4e0
 ? __x64_sys_close+0x78/0xd0
 do_syscall_64+0x6d/0x140
 entry_SYSCALL_64_after_hwframe+0x4b/0x53
RIP: 0033:0x7f855e113367
Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b9 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
RSP: 002b:00007ffd15e90c88 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f855e113367
RDX: 0000000000000000 RSI: 00007ffd15e90cf0 RDI: 0000000000000004
RBP: 00007ffd15e90dbc R08: 0000000000000028 R09: 000000000045d100
R10: 00007f855e011dd8 R11: 0000000000000246 R12: 0000000000000019
R13: 0000000067c6b785 R14: 00000000004a1e80 R15: 0000000000000000
 </TASK>
Modules linked in: 8021q garp mrp sch_ingress openvswitch nsh mlx5_ib mlx5_fwctl mlx5_dpll mlx5_core rpcrdma rdma_ucm ib_iser libiscsi scsi_transport_iscsi ib_umad rdma_cm ib_ipoib iw_cm ib_cm ib_uverbs ib_core xt_conntrack xt_MASQUERADE nf_conntrack_netlink nfnetlink xt_addrtype iptable_nat nf_nat br_netfilter rpcsec_gss_krb5 auth_rpcgss oid_registry overlay zram zsmalloc fuse [last unloaded: mlx5_core]
---[ end trace 0000000000000000 ]---

Fixes: 8ff0ac5be144 ("net/mlx5: Add MACsec offload Tx command support")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Shahar Shitrit <shshitrit@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 3506024c2453..9bd166f489e7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -4349,6 +4349,10 @@ static netdev_features_t mlx5e_fix_uplink_rep_features(struct net_device *netdev
 	if (netdev->features & NETIF_F_HW_VLAN_CTAG_FILTER)
 		netdev_warn(netdev, "Disabling HW_VLAN CTAG FILTERING, not supported in switchdev mode\n");
 
+	features &= ~NETIF_F_HW_MACSEC;
+	if (netdev->features & NETIF_F_HW_MACSEC)
+		netdev_warn(netdev, "Disabling HW MACsec offload, not supported in switchdev mode\n");
+
 	return features;
 }
 

base-commit: 4d64321c4f6faf90b5a3b9f52ee1e7e0eeeff00c
-- 
2.31.1


