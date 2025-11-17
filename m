Return-Path: <linux-rdma+bounces-14533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7849EC64030
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 13:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A6643A37D9
	for <lists+linux-rdma@lfdr.de>; Mon, 17 Nov 2025 12:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3216C259CB9;
	Mon, 17 Nov 2025 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tcmCKsfZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011050.outbound.protection.outlook.com [40.107.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AC4E38DF9;
	Mon, 17 Nov 2025 12:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763381810; cv=fail; b=Kio0hR4sqFuknKHsBVBeFyaznz8G0WxJnZPRNcCFIJQVsrFBrTiL2U/IYRJPT283ZegFongtWN7ULMm0L8zf78uqC0tyGPn9GXrdvB9Qa78ZYaP9lsRa7Cfi0YxSvanasMIHd6MBcejRtFjQ3pA5Ll2/2jtMoNhCMeb1DH3CxQo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763381810; c=relaxed/simple;
	bh=VFBLwS972MGYvvOifDXzkr1OzBMTih4dZh02T2bA3/c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oy9BXidYxd/FOawKtt6j8R6nO19ZBksT/86CIbwWEGyZCOdOV9W6Z2pAjypG8rQvtlqH01kCLWQOOs8gZiF+sMx14xjL+YgmzsYR5sOMMrrAYI1Ir5i35EYbc46x95i400ZY0OGuFQImEPmEfVBLqVYF3BP3vSbAiKlv3rMRtlA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tcmCKsfZ; arc=fail smtp.client-ip=40.107.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jlTVAfgLZrxkPoS+sS+4xwHgeTaIGI0eLG3oeW1jL2npHjuBiQfzm5d5jxugaJDMwS+xUBDOpCpTovMqak+i5g1fer2byf+AW4wkE48aa5GR2b+ATGWfnkwCLeduJKvbqYx62doMMj9TTkSwKfsHQ7kR2iHdLoPBSAvjCloVsu+VouS4Q0AF8Yh3JCYKq9GOFPvVJ19epTTm62x3aJiIimciomCuUv8Q7K5d8IYxv/sMUWp/1uH+8NKepG4Gq7DCR1pVwsedaGXKrO5+y2egsnHx4lHVgxzkTibzvGlxLtcSN2dfsGAfYo3zRLkiH+enG0zsa+M6z6WgFaft+AjXSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gctgK/rUQGagt1ko3Yx0sDsSYavh8CPXSF7w3csPK2Q=;
 b=lBR9Hz1/3MUV/CUTsFUURjerg+4gRZBkAa53SZCDb5laaeS/kjPahLebmaxiuGC1Q77YvjVQa1XOhdb+yQc96FJitGYgnafJuVSLti9/33fjQetsLHoKRsm3VF08sR2yhOuJjo1DSt0JnZyYPl1I/F54IUSTW7pcm6Jbgkx/n9Mig97GgngwiXnnBT5ugwg/zRMCQJr3d8Y0rz7J23cdVQyMwPIzJ2FM43SgXxgWGZTL2pQTr++4oapQPAPn+aGSuxecoiSw0gqEmWMGKC9RMma6KjK1bmpXPOMGYOUe5LPKERGj78suDoB96YEkpoP0veHUWxOse48nB+b+k1yGIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gctgK/rUQGagt1ko3Yx0sDsSYavh8CPXSF7w3csPK2Q=;
 b=tcmCKsfZcuPL3eFkyQvQXCjkApgKx6mYDG7BPgaVOQ9RwD+Tx5LXHjvn8IZKxCR1S5fg2UJRwGpovbuGgexP6wp/IGG/8yefi5HeXySjHCHrHYf0AeHUfWucKNYYuh6B8U2EG6Aa9v5XMtpUuPlDk/+DazA6/4YMNH+E5IY4tALlhYYPHwqvGcpdh5o+EWN241Y+qCBIEJS3BKFz2hnzi8bAkh9rpcmrtl4Xgydo1Ey7L0hVmbZo4Uum3nrtRor+tsbaLIBLZguLRh7XETDZgxSji8SFHnPG9ZSyj0cpDFCxaMqctz2s1SAJjzah6ntn9mwUXF6g5vX9kO5wkPXiNA==
Received: from BL1P221CA0017.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::35)
 by CH3PR12MB7523.namprd12.prod.outlook.com (2603:10b6:610:148::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Mon, 17 Nov
 2025 12:16:42 +0000
Received: from BL02EPF0001A0FD.namprd03.prod.outlook.com
 (2603:10b6:208:2c5:cafe::5d) by BL1P221CA0017.outlook.office365.com
 (2603:10b6:208:2c5::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Mon,
 17 Nov 2025 12:16:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FD.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 12:16:42 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 04:16:24 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 04:16:24 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17
 Nov 2025 04:16:18 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, "Leon
 Romanovsky" <leonro@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, "Moshe
 Shemesh" <moshe@nvidia.com>, <anand.a.khoje@oracle.com>, <elic@nvidia.com>,
	<jacob.e.keller@intel.com>, <manjunath.b.patil@oracle.com>,
	<pradyumn.rahar@oracle.com>, <qing.huang@oracle.com>,
	<rajesh.sivaramasubramaniom@oracle.com>, <rama.nichanamatlu@oracle.com>,
	<rohit.sajan.kumar@oracle.com>, <shayd@nvidia.com>, Mohith Kumar Thummaluru
	<mohith.k.kumar.thummaluru@oracle.com>
Subject: [PATCH net V3] net/mlx5: Clean up only new IRQ glue on request_irq() failure
Date: Mon, 17 Nov 2025 14:16:08 +0200
Message-ID: <1763381768-1234998-1-git-send-email-tariqt@nvidia.com>
X-Mailer: git-send-email 2.8.0
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FD:EE_|CH3PR12MB7523:EE_
X-MS-Office365-Filtering-Correlation-Id: 96dc50d5-9a58-4eaf-9b37-08de25d32b25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?vhkptVWADw24C1hk4TrtHLvy2faSVwxFfDO6cxp2J2dLjtb7/VoXv2Pui0mu?=
 =?us-ascii?Q?9qV4p97+g7bu6iH7lgjHBOd5hIsFf49FD3mf/WwYWbBfGKyLbXTMoQM4Fn1m?=
 =?us-ascii?Q?vDQ4tifugjXzJdA5t4vXWZFGrWLbiNSjoiyuV5cXZc3CgUZTcH5SIU0JBeqK?=
 =?us-ascii?Q?JoUw/4LdUSSvjO6CDpUQIw53WBUTAtMY64lNOI79VwuqVvX1rJQhgylCL8dj?=
 =?us-ascii?Q?XaMgDeO1RV1kr5e4Ll3slzHOCo4lhi6I5rxUvNSjOS8OF7VVDq3LtC2pJR0E?=
 =?us-ascii?Q?bRIqOlkdVhwbnv6X3tsRko7fy7Z+luaBr12w2hWa5V2rqVQCtU1VEczp7foQ?=
 =?us-ascii?Q?sUWrqa6aSnPrIdNP0SBS7YRO3l8gdQUj2sD8uInsPyyNQZdvJhqfsZFMyHxy?=
 =?us-ascii?Q?AtpC1vUNUDhwWDflyQkuyeMmIf8c1v9IM6KC3hT+uei0p8oCLjTVwXfSy0CH?=
 =?us-ascii?Q?HKyewXzmwlYIrRZ8d3FN9IA/c0iWdjfmx5LXd7xd57DupOh3WrbLQJEHFqUp?=
 =?us-ascii?Q?MUAqVYhWy2sEOdLapvXy3T/FTdVT4yd/XKNncoia2eAaO/kRfUUm1pWhlK8q?=
 =?us-ascii?Q?RMjGm5UEawgmumXLup93Vm4fhishBtGpEDeXy+tEv9HBV1p9X5zcSUYOLgF5?=
 =?us-ascii?Q?h1BVB3pwGHaXBjTgWXeao9c/uJwhfdFgGlByVbl1wkWkTACystpHCGThv9f2?=
 =?us-ascii?Q?WOpOxat/UiseED0EfGY9UoeiYcM4scBRh1yrzdPyw7WvZWyPYDuY5UjpfQ5S?=
 =?us-ascii?Q?wRNePSGbL3Q8J42Ev2pYwF7hSzTH9fgZC3IlKBIuuHYnYTw0s33/231kGxfk?=
 =?us-ascii?Q?n6BoOUcDy10XTRmm3UEEfQgSSZZMyHCp3rQG9IUp5dUQf7egXRApwJHkAbjO?=
 =?us-ascii?Q?BUlxohMjl9+22D7iWOmNbPn2O782f3u0UbqITQlQ7eNkNhUH+7E/JHTw/iMz?=
 =?us-ascii?Q?HZQ4mLrr9mW44cxCEC9p7Mpc925SaNYkl2HYpvhnLDzj4Kn9+xKNpkEdqgDP?=
 =?us-ascii?Q?1GPLT0WSFfnI6e49zi2xBpkKQ3qxZxE2h+7iKzjP+SW6i1ZTB8Nr6/2p9gKu?=
 =?us-ascii?Q?5roDPd1JfTdADUmN5dboDzGGBgGHJsaFEADKgQoKgq8co8UtOlX6/zUD3aY0?=
 =?us-ascii?Q?QIrzDcLx/Q9NFaFSCGNXlwVhvwVRTDM2v5Q5T9IzAxhhlP/ExGHdHlMrbfYo?=
 =?us-ascii?Q?/K0Ym+ArZa492VxZO/ncRDcbNcThwGKzaH7vReQuvgWMmWAQxuJRqAn2qe/P?=
 =?us-ascii?Q?CopvDVT5aavYB7VE4ctLVcHy435DPUldMEkV4mzI7/+T9SSEJFjTRhfF3aFu?=
 =?us-ascii?Q?yZXcrrYBzhIEkAFjjTnPKyUVzB9cQ8ZTFFw2aZHrrq41LRCS1MZ99jSIS5do?=
 =?us-ascii?Q?o5t/ioNuKZXdOZ1C5fYC1fU5KMTGHVEEO3O2nN2QCRR0ulbsZIArmFwFonqh?=
 =?us-ascii?Q?+QZgSHJ+D7vi8euMGysQEUhUywkqtP5OG5EB2rRFO/F6CvQcZW+1mPc9Ul9W?=
 =?us-ascii?Q?syTFFa7JSlypFgAMb8MLR9OrWTyaxUsJTzNoSaRlXbA9l1c4HHtHWgrG8apk?=
 =?us-ascii?Q?XFOzX36v7pgWWDTprkw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 12:16:42.3457
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 96dc50d5-9a58-4eaf-9b37-08de25d32b25
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A0FD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7523

From: Pradyumn Rahar <pradyumn.rahar@oracle.com>

The mlx5_irq_alloc() function can inadvertently free the entire rmap
and end up in a crash[1] when the other threads tries to access this,
when request_irq() fails due to exhausted IRQ vectors. This commit
modifies the cleanup to remove only the specific IRQ mapping that was
just added.

This prevents removal of other valid mappings and ensures precise
cleanup of the failed IRQ allocation's associated glue object.

Note: This error is observed when both fwctl and rds configs are enabled.

[1]
mlx5_core 0000:05:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
trying to test write-combining support
mlx5_core 0000:05:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:06:00.0: Successfully registered panic handler for port 1
mlx5_core 0000:06:00.0: mlx5_irq_alloc:293:(pid 66740): Failed to
request irq. err = -28
infiniband mlx5_0: mlx5_ib_test_wc:290:(pid 66740): Error -28 while
trying to test write-combining support
mlx5_core 0000:06:00.0: Successfully unregistered panic handler for port 1
mlx5_core 0000:03:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
request irq. err = -28
mlx5_core 0000:05:00.0: mlx5_irq_alloc:293:(pid 28895): Failed to
request irq. err = -28
general protection fault, probably for non-canonical address
0xe277a58fde16f291: 0000 [#1] SMP NOPTI

RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Call Trace:
   <TASK>
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? show_trace_log_lvl+0x1d6/0x2f9
   ? mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   ? __die_body.cold+0x8/0xa
   ? die_addr+0x39/0x53
   ? exc_general_protection+0x1c4/0x3e9
   ? dev_vprintk_emit+0x5f/0x90
   ? asm_exc_general_protection+0x22/0x27
   ? free_irq_cpu_rmap+0x23/0x7d
   mlx5_irq_alloc.cold+0x5d/0xf3 [mlx5_core]
   irq_pool_request_vector+0x7d/0x90 [mlx5_core]
   mlx5_irq_request+0x2e/0xe0 [mlx5_core]
   mlx5_irq_request_vector+0xad/0xf7 [mlx5_core]
   comp_irq_request_pci+0x64/0xf0 [mlx5_core]
   create_comp_eq+0x71/0x385 [mlx5_core]
   ? mlx5e_open_xdpsq+0x11c/0x230 [mlx5_core]
   mlx5_comp_eqn_get+0x72/0x90 [mlx5_core]
   ? xas_load+0x8/0x91
   mlx5_comp_irqn_get+0x40/0x90 [mlx5_core]
   mlx5e_open_channel+0x7d/0x3c7 [mlx5_core]
   mlx5e_open_channels+0xad/0x250 [mlx5_core]
   mlx5e_open_locked+0x3e/0x110 [mlx5_core]
   mlx5e_open+0x23/0x70 [mlx5_core]
   __dev_open+0xf1/0x1a5
   __dev_change_flags+0x1e1/0x249
   dev_change_flags+0x21/0x5c
   do_setlink+0x28b/0xcc4
   ? __nla_parse+0x22/0x3d
   ? inet6_validate_link_af+0x6b/0x108
   ? cpumask_next+0x1f/0x35
   ? __snmp6_fill_stats64.constprop.0+0x66/0x107
   ? __nla_validate_parse+0x48/0x1e6
   __rtnl_newlink+0x5ff/0xa57
   ? kmem_cache_alloc_trace+0x164/0x2ce
   rtnl_newlink+0x44/0x6e
   rtnetlink_rcv_msg+0x2bb/0x362
   ? __netlink_sendskb+0x4c/0x6c
   ? netlink_unicast+0x28f/0x2ce
   ? rtnl_calcit.isra.0+0x150/0x146
   netlink_rcv_skb+0x5f/0x112
   netlink_unicast+0x213/0x2ce
   netlink_sendmsg+0x24f/0x4d9
   __sock_sendmsg+0x65/0x6a
   ____sys_sendmsg+0x28f/0x2c9
   ? import_iovec+0x17/0x2b
   ___sys_sendmsg+0x97/0xe0
   __sys_sendmsg+0x81/0xd8
   do_syscall_64+0x35/0x87
   entry_SYSCALL_64_after_hwframe+0x6e/0x0
RIP: 0033:0x7fc328603727
Code: c3 66 90 41 54 41 89 d4 55 48 89 f5 53 89 fb 48 83 ec 10 e8 0b ed
ff ff 44 89 e2 48 89 ee 89 df 41 89 c0 b8 2e 00 00 00 0f 05 <48> 3d 00
f0 ff ff 77 35 44 89 c7 48 89 44 24 08 e8 44 ed ff ff 48
RSP: 002b:00007ffe8eb3f1a0 EFLAGS: 00000293 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 000000000000000d RCX: 00007fc328603727
RDX: 0000000000000000 RSI: 00007ffe8eb3f1f0 RDI: 000000000000000d
RBP: 00007ffe8eb3f1f0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007ffe8eb3f3c8 R15: 00007ffe8eb3f3bc
   </TASK>
---[ end trace f43ce73c3c2b13a2 ]---
RIP: 0010:free_irq_cpu_rmap+0x23/0x7d
Code: 0f 1f 80 00 00 00 00 48 85 ff 74 6b 55 48 89 fd 53 66 83 7f 06 00
74 24 31 db 48 8b 55 08 0f b7 c3 48 8b 04 c2 48 85 c0 74 09 <8b> 38 31
f6 e8 c4 0a b8 ff 83 c3 01 66 3b 5d 06 72 de b8 ff ff ff
RSP: 0018:ff384881640eaca0 EFLAGS: 00010282
RAX: e277a58fde16f291 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ff2335e2e20b3600 RSI: 0000000000000000 RDI: ff2335e2e20b3400
RBP: ff2335e2e20b3400 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000ffffffe4 R12: ff384881640ead88
R13: ff2335c3760751e0 R14: ff2335e2e1672200 R15: ff2335c3760751f8
FS:  00007fc32ac22480(0000) GS:ff2335e2d6e00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f651ab54000 CR3: 00000029f1206003 CR4: 0000000000771ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Kernel panic - not syncing: Fatal exception
Kernel Offset: 0x1dc00000 from 0xffffffff81000000 (relocation range:
0xffffffff80000000-0xffffffffbfffffff)
kvm-guest: disable async PF for cpu 0

Fixes: 3354822cde5a ("net/mlx5: Use dynamic msix vectors allocation")
Signed-off-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Tested-by: Mohith Kumar Thummaluru<mohith.k.kumar.thummaluru@oracle.com>
Reviewed-by: Moshe Shemesh <moshe@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Signed-off-by: Pradyumn Rahar <pradyumn.rahar@oracle.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

This is a re-send.
Find V2 here:
https://lore.kernel.org/all/20250923062823.89874-1-pradyumn.rahar@oracle.com/

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index e18a850c615c..aa3b5878e3da 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -324,10 +324,8 @@ struct mlx5_irq *mlx5_irq_alloc(struct mlx5_irq_pool *pool, int i,
 	free_irq(irq->map.virq, &irq->nh);
 err_req_irq:
 #ifdef CONFIG_RFS_ACCEL
-	if (i && rmap && *rmap) {
-		free_irq_cpu_rmap(*rmap);
-		*rmap = NULL;
-	}
+	if (i && rmap && *rmap)
+		irq_cpu_rmap_remove(*rmap, irq->map.virq);
 err_irq_rmap:
 #endif
 	if (i && pci_msix_can_alloc_dyn(dev->pdev))

base-commit: 5442a9da69789741bfda39f34ee7f69552bf0c56
-- 
2.31.1


