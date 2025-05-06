Return-Path: <linux-rdma+bounces-10102-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E678AACC53
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 19:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDDCB4C5114
	for <lists+linux-rdma@lfdr.de>; Tue,  6 May 2025 17:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8FF27BF95;
	Tue,  6 May 2025 17:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HUmS7rk6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2051.outbound.protection.outlook.com [40.107.243.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2C84207E03
	for <linux-rdma@vger.kernel.org>; Tue,  6 May 2025 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746553104; cv=fail; b=aSWNLr/ytNoDHZ7B2GRYSTsy/OnL9jQhJ69zrbektA/flmAK0BOjhODOK1om0/imb6+a+B0ZGNeLW1ltdYW+qSFO+aV0Ayco/ceusus/3m3hPcySEklNOGKZWLS8v+AMncCSzhBcNNsm80VWptn81FVQKmXrB90K+dN/YfcIsNg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746553104; c=relaxed/simple;
	bh=xJ1ZJ/XEHxbEyaDIAEQFW/ZOjGsFmIMxRD/AuaQ1dH4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C4Ps/Y59rAanofgq4q/+aD5iJF5erWZ9uG63f7/lD0E91thKF8b+rL5lQs8L9iwckn/dSLmETlbmpkwiHRQEPWodk8RSbOfDTaZWnxsea40SaA6lnhXC5iYcxR86JHEG32yynIrGZUXMRom7u13rY9P49AwsLQal4XK2I/QGHME=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HUmS7rk6; arc=fail smtp.client-ip=40.107.243.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kpWbLZw2FkQpgxOJU9NWo6ALlcWFvY/itY/m/S8gA5p9gyOEZnkys5pwFKKTzG6JDWMIXADYYnOaklgirZjZePTHIMkk0Aunxjt/XJuUcN3uqZfjhuywgf6Swqt1B0fduY4+WcfwYtyOcRoj4ujyH4CzuJ2MVH4xvGEnXmqCgtd99wVjhJTRuD0egS37SijoZH7WgZvdq6R9k/9glTeZtCER5yCVqZDCTxDkeuFJoQkcPww8vxw76hKDIL6SlBZUTYGCBeRtLNck5O9+G1iABKPZl48XZammKFWmLEG4L5Y2GRVbiJWyqiy7gMv5i3DSdPcfcdPPs58xAEU/U1+9EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H3m+07SwK1V0W2gcE+TGU4pS/00UNfqaNTcEqocZF8k=;
 b=Ukv6YWh6uTlQGlQCL9M2abXhnwEeI/Jg0lRU7ox0GQThgzhn/meypsWKpmSVmf6SwLbm65Mu07BNZM2yDMDmAnSPO82UInNKlyvwP0ZNPWLtmhILAH8x0dmqvyQkOO8Ru+UQJkZ0xUXZ8E0afc1NDsv12hCFOISr5vY2unvlKDbbefr2IsflgigxmDws+a+drBeTDck7lphEv5P75qzcbeeKGyGasIxDb96mbMoMURgBJ8+KotEnt44OD+CokqfWvTxUyiEMnKIyCF7zgVCJE++qGv6t4J411ulRs0qAjBudaZS9jynfQ5iZNN7nJe7Aabux64DT+TIcYwxxvStuZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H3m+07SwK1V0W2gcE+TGU4pS/00UNfqaNTcEqocZF8k=;
 b=HUmS7rk65DDM9p6zHZjw0iQJJFOHV1nVTIJhHyfflbBUSteuR/MW6EsqBfdZBj2V7L2i9naQfCnSduHnF2w6y5q+YW8M4jlb5s67JeBFjm0AOPQ1eHHqW/Uts1jZ8kjAXhierZYn36lTi8mMBn9rxlyiUusLODHPjmmho4Lpenv/DKNKO4kkVaDrpUok67v6eLa0Ql0kUcpz/PtLy7qw/iGk8Y8E+WhaklgDm515KtsgmGg1DYo6BjYVT5cOYv27k4bn6IROmjsz7Gjz7K9Z4smi3JsZTx9M4N7zFqw8QeYzKMKQiwdfid9VXqK7hCubkv//NlJJhGzTHHDcXS1plA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by SJ2PR12MB7962.namprd12.prod.outlook.com (2603:10b6:a03:4c2::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Tue, 6 May
 2025 17:38:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%6]) with mapi id 15.20.8699.026; Tue, 6 May 2025
 17:38:12 +0000
Date: Tue, 6 May 2025 14:38:11 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
Subject: Re: [PATCHv2 1/1] RDMA/core: Fix "KASAN: slab-use-after-free Read in
 ib_register_device" problem
Message-ID: <20250506173811.GA86008@nvidia.com>
References: <20250506151008.75701-1-yanjun.zhu@linux.dev>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250506151008.75701-1-yanjun.zhu@linux.dev>
X-ClientProxiedBy: BL1PR13CA0435.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::20) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|SJ2PR12MB7962:EE_
X-MS-Office365-Filtering-Correlation-Id: 4be51648-e58c-48d7-398a-08dd8cc4c645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/sEm3kGMFl5Unn/Qa/KsF/FnBlTFaJfWP0+F6rRecH71myggEbj0xdhlvMT7?=
 =?us-ascii?Q?w6Gs4OGunyeQAbP/FPdjFqcr7m9ImoINo/VRzVXQxFzl2VaDu4lrYS2yQRB0?=
 =?us-ascii?Q?9CtT2J0FPYSaJMvFQrBk/0Kd14BftlO7SimSvcSVEWgtLs+9ZKm0TFzAdaNo?=
 =?us-ascii?Q?3NjKoxOUaCO5njZs/WfQDx1219aYjWMIOUiI7ULFF4KfWDTFbAJPzg9lkfTf?=
 =?us-ascii?Q?r3frnZr0Ox1D/iVLzHio1fGjsE2T5INPUha1wUGAQEJE4zCG+Y8CKJa/CNMs?=
 =?us-ascii?Q?LxvB1QAa0Sq4ocCuIr70i+VxuF9ySSFJR50wadM/UJukQPfZkeVdJU0cWbj3?=
 =?us-ascii?Q?BWKrJWgnUw4BD/WxA+vCrhCfqSypIH4LSk6gLQYR7d1xEvqEoTRrjoCttSAo?=
 =?us-ascii?Q?OO+Xzk/UHN2aavgpSPy+64YV+j75mtMZO7NCFesMGpimm+Tci8lyBaWxkVzK?=
 =?us-ascii?Q?EefXZ3dm/FJDOk94TmIcP9DRounCLtPh1m4txaA8eEfmswuyx9/WnsSd99Y6?=
 =?us-ascii?Q?xmN5b8G/Ucc9EtTtz0rdhy534pZJf+LvFOtkBkGET6tTIxBU/dVMBx2MYFxu?=
 =?us-ascii?Q?3gG7ESvpLUAducquMKc/U3FniufGn/f17t+2PsmZAF01Wkz0nuj6VoYoWcAZ?=
 =?us-ascii?Q?KGT1GfX+6Id1Zl/G55/cCW1hOfMuun9VUz7NXnGkM+58yxhXA9e7p9n6oZ3/?=
 =?us-ascii?Q?wEMinRnBiAZIBbr2iiillo9ZVGSoEg6t4gnSTL6Gf/dfGllqpBlOd7T8twgI?=
 =?us-ascii?Q?1DhvVbkRfEob5ryGxDtIUNDsgUMk6xUTIM/1a94rBYD8JIt8Wjd7sObK7658?=
 =?us-ascii?Q?h9Luijcty3nL4cngV3Pvwi+oGZnp48D+y0bYitgwTQ3wqkFHckd56Ytzjyei?=
 =?us-ascii?Q?zSc9YX2k9eUpaCL29EIv+7uHGKmoA8KMwLvQJNywGLFU/qcA138MFdiVlThv?=
 =?us-ascii?Q?Y5dcIVLjYkBn1c5NlyGBESk3BbhfBLtrq7XRI7culo/FcfghcjjOj5bxs7P/?=
 =?us-ascii?Q?BfFbTHT3VhsBm0zNtFGOAbzNq3935TOPrZTPM7i/uDDHuG5jtQdMQVlYkUAO?=
 =?us-ascii?Q?nOBT42pkj2oWnK5Lx1P33bljbNU4bQegy2Z0usy/rUmkFW3PIPo+dxPxRk+/?=
 =?us-ascii?Q?6CzA4FjGWwj9CVPFEGn2BHYWBbYbGdH/FSafSZaO8c4h+Sc7b1eDrUhbW11n?=
 =?us-ascii?Q?oACm5Dmk/d3QnbTX0tkJ1pC9L5oOuxkJ/L8R7CNrTg47RqVRhlPKcWIwWh8N?=
 =?us-ascii?Q?gdXtdS6mdF7p8tUFQ416j/TFzqLx17CJuHR4EFOiiKVlYwf4aMF6c4aIIhQU?=
 =?us-ascii?Q?BI689FefF8tPjdetyca6nKXkqbL9MNTsiwvpKJITwOSS/FQUzyiYTlWQleB6?=
 =?us-ascii?Q?Z1n1FpxFJVNtEFTdnqTA+7JB9qC1bapgPxh4pWzv3swtakxtBdiEbmKD28b4?=
 =?us-ascii?Q?cXH9AwdBW3M=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gk3zupV4PEC8Mty2Gr+Es+o2gYLTAw/Q8MiKDxs6wJLJmxVvRLZGdQC6CtdE?=
 =?us-ascii?Q?Rp05de6RWccoJrErjEWkRC8031JmH6ABDHRZia6PR9vFUOl6nX/84UyPwX+S?=
 =?us-ascii?Q?uTC34xWMkQhFezE20iwkuAJDqjwVjJxADRto858yOl+aXxZEsU1trqC/zlER?=
 =?us-ascii?Q?+n7Qn7kOVvdGLCcwlIUxDgALAkSNGKOzK44peveNQGs/UUGmoc5tkCrRjK+L?=
 =?us-ascii?Q?UapKQFyHwNIDXjCtqowQSlBz7QUY3OufmuYFwabVyTd5+9IO4eYSzwrlR/Gp?=
 =?us-ascii?Q?6zQk73EgqKAh60q0zL+nQsCc3duxN2GjSFlI6q8jERy2UJEgGeSQ+3ONpjVt?=
 =?us-ascii?Q?91tQ10miat1SxbqMGUna42rIeeBB2zIw1FVfxw36K7KmHuEDazEaiLVIFDvi?=
 =?us-ascii?Q?V7a2n9LqQi1c/5WoWvG1Nrk6NALHQSBPhZ6fP0V6BCR/XK2fgnYA7+88gWpy?=
 =?us-ascii?Q?8u6cubSXC3dbEenFvHq3YG5ItK6XgZZgIMyh0tivLAmfEG9ELo3iY5FHl1ry?=
 =?us-ascii?Q?HN0lbXxbIKAFAI6BiMdomRi1/MTFy9S9PT1kUmp/bafa6A9gHVdLfMB2GPy+?=
 =?us-ascii?Q?gh2LOhIUvoQ1NbmKoIbJqlvHcK4zMDbmbLM8JjdkY0itwzzweThCWuyvDCJn?=
 =?us-ascii?Q?ZvCZ5ae0loVFr0mrC2N4eK/U6t1PAqL1HD2bzVEKKHrTp5R4UO7QmHBuUt7I?=
 =?us-ascii?Q?eiXV+E4ypTseeXZyhOf4Kebjh1SufgbFrPRAPJ0+L7d+yfeBpbWPY8wd8+6j?=
 =?us-ascii?Q?hJ9qeDld4WbKVdGnRlRzEznRZkOnLn0g2o5AUvvvG7KOzf5wN3q13dD/kAJg?=
 =?us-ascii?Q?zipB1vKl48rfIpDfrLkQOvaVSubchGW4o5TPToexHpjNPntt4PinLAgebif3?=
 =?us-ascii?Q?5H88oUDZKMOzM1ZN8WJx84UTU1tRFF8paWp6lTpsNU+8ElIvs+PrmBCpeFF0?=
 =?us-ascii?Q?MvKR9Y3Gfegfknb5A139jzchqkNx+zuNCOYoKoqK/xXQ4RNuTF3Had2BgWVn?=
 =?us-ascii?Q?62OiNE3OdpyGFE88NTLsx89LWdv60vzOakLs6MzO8sDT6qX6164dYK7HtpgR?=
 =?us-ascii?Q?LubTqR1GlStcifShNbhMegSF9vjRo5zAcwMnnlbdsDR1y92ZblklVfaLjeD3?=
 =?us-ascii?Q?RyuagD5JD5mFJA7hNK5vPscEGFNpMbiwbg2X4268ww6ZALoH95omflKcxYp/?=
 =?us-ascii?Q?2ijOohcQv+B7TydGA6HsSbBU6UFUn+ZKQlK8cnrUdG/+UHcUBIREnaZePZch?=
 =?us-ascii?Q?ekG5/yv4Bl2iNtzT4qEOp7CgHBsADJWCm9peWgWHE9/iyOodsuJFufWsVPIL?=
 =?us-ascii?Q?slpkQwyrIR8bajNztlH6dNz8nsayZHfVxDVD/cD97aJFe4xKo7WAeUiprTIk?=
 =?us-ascii?Q?yvI09xPUIpvHP6hBwtRwnu+Ptmnd/xHbyxPvb3RyUEl2DUYm00XHGxqreD0V?=
 =?us-ascii?Q?uKlxYuMX+8oHxIw6QGsrKx2PSeV+/ba4IozNuhzoZXOgjraKq9Q6K5hOy00B?=
 =?us-ascii?Q?yhJMkEc5VKR34DSah77H5WJcxzgjZuMjzwU4VqDHQXzw13DjHSmE1MXVfR0B?=
 =?us-ascii?Q?ym9uXjl6E4FBVzIjFDvOWroIvCvbqBwJgYv5e3Gj?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4be51648-e58c-48d7-398a-08dd8cc4c645
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 17:38:12.7394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N8i1LLfUL80Ha4A8SLIEU/3oLlh+0GOTlnNKCFd/quAX0iMpOQ1EMDxGYk08aNcI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7962

On Tue, May 06, 2025 at 05:10:08PM +0200, Zhu Yanjun wrote:
> Call Trace:
> 
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
>  print_address_description mm/kasan/report.c:408 [inline]
>  print_report+0xc3/0x670 mm/kasan/report.c:521
>  kasan_report+0xe0/0x110 mm/kasan/report.c:634
>  strlen+0x93/0xa0 lib/string.c:420
>  __fortify_strlen include/linux/fortify-string.h:268 [inline]
>  get_kobj_path_length lib/kobject.c:118 [inline]
>  kobject_get_path+0x3f/0x2a0 lib/kobject.c:158
>  kobject_uevent_env+0x289/0x1870 lib/kobject_uevent.c:545
>  ib_register_device drivers/infiniband/core/device.c:1472 [inline]
>  ib_register_device+0x8cf/0xe00 drivers/infiniband/core/device.c:1393
>  rxe_register_device+0x275/0x320 drivers/infiniband/sw/rxe/rxe_verbs.c:1552
>  rxe_net_add+0x8e/0xe0 drivers/infiniband/sw/rxe/rxe_net.c:550
>  rxe_newlink+0x70/0x190 drivers/infiniband/sw/rxe/rxe.c:225
>  nldev_newlink+0x3a3/0x680 drivers/infiniband/core/nldev.c:1796
>  rdma_nl_rcv_msg+0x387/0x6e0 drivers/infiniband/core/netlink.c:195
>  rdma_nl_rcv_skb.constprop.0.isra.0+0x2e5/0x450
>  netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
>  netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
>  netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
>  sock_sendmsg_nosec net/socket.c:712 [inline]
>  __sock_sendmsg net/socket.c:727 [inline]
>  ____sys_sendmsg+0xa95/0xc70 net/socket.c:2566
>  ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
>  __sys_sendmsg+0x16d/0x220 net/socket.c:2652
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> This problem is similar to the problem that the commit
> 1d6a9e7449e2 ("RDMA/core: Fix use-after-free when rename device name")
> fixes.
> 
> The root cause is: the function ib_device_rename renames the name with
> lock. But in the function kobject_uevent, this name is accessed without
> lock protection at the same time.
> 
> The solution is to add the lock protection when this name is accessed in
> the function kobject_uevent.
> 
> Fixes: 779e0bf47632 ("RDMA/core: Do not indicate device ready when device enablement fails")
> Reported-by: syzbot+e2ce9e275ecc70a30b72@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=e2ce9e275ecc70a30b72
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V1->V2: Make kobject_uevent share the lock in ib_device_notify_register 
> ---
>  drivers/infiniband/core/device.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Applied to for-rc, thanks

Jason

