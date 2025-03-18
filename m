Return-Path: <linux-rdma+bounces-8801-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C427A67FFB
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 23:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD1F417B5C9
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Mar 2025 22:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 972262063E5;
	Tue, 18 Mar 2025 22:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="f4Mdow3M"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2064.outbound.protection.outlook.com [40.107.95.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEECF1EFF97;
	Tue, 18 Mar 2025 22:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742338160; cv=fail; b=h+aSzT8LutnpOQssrElljj32Y/VztTPJUsQ+1pXbzW2fEYicA2Lg/LZa6Q32n0GF9F3u4X9bBphzU3kZaM6mj+en+euie2avo5KrZiODkczWivyFo6CLURCSCn51Ie8ijnY+kZDYjwgAxtcQJmPJOTITuYBkAO8HTswlVkhy1KY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742338160; c=relaxed/simple;
	bh=2fInRnCjBnM0aHg2NfcvojEjll7xFvxbx1lKWXoWx1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ECAwZz5hlikmSfYJ1zowfx1kGOVB+c0GqHAKNnx3cSQ4CJBW7saeMBuk2aRhlKK/5C8MjA79PrF1dnuRE1QHnUnKtlxEDilwJBXS/ctNMcAZBai4BlcXwOXHFx4VPETEv6EwNhMrsU2KfDk/MIhGYaymJn55UTAhKXl0MqabLQU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=f4Mdow3M; arc=fail smtp.client-ip=40.107.95.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgOTVBEJB/zobkc2M7Ulke3PZ7ZJwX/J68oSAQGUmcCS+1O1hSRZxH5fGRywsL2IUDkXytXYZkbBoZoX3/mvQNnn7BGjjLPGE6jWopSs29VGlXyJEvyACtSCKGnNheRRW4DjUOnKUtxtaEE1w3M5MuGyO9bnUTlyW8SDHrWpUWhRLeJUOpH1PzTNxRm/f2s8GfdXOLT4ilZ3AaXwC3S0gA9uKjJYwFXPGKS20Ot3AMqlLfXvoyK9wBT5k4HGSJzp+s32zoi0y6ZbIx4hzacgfcdosn0n9Md8zsDODfzP/An9MXs7zRoSAWA+sN2ssE5b3s2bEJ8DXgmZuWhpNLTC9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egwzTCbYiFMFRa/6Q138Im1l3tIHhdlEMn4qx8PFyb8=;
 b=pBnYzVj0KnMNGk4DvdeqGv0JI72tlCOxj01lxRcMtwk6YCdJwVj1EIGrXke3Bj6ibZOCdEhUszhV6Bkpd5E1vU+GDOxuk8kwmGtwjOPJZH/JyRLti8XxXlVzeUc4jm3f+ahEeKK8JGAGnhZiL01cPrfAs1SIwOxhcxvKdQJx6BfjP0xz1kca5ZwbSzIkX7zFx6s8CG6VQXWHSwsbKNMhkM7aP78pbl10SpgVv1j2kduizp21d0AACBdUOR05UOJPtBqbMlR2r3N7gOatRK+puNSZz0ySa+YLcvXS+Ybk+CzloQXgZkbdA/4qp50Llh4+0Q1WXnf+Lcs3jV5rIJfsyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egwzTCbYiFMFRa/6Q138Im1l3tIHhdlEMn4qx8PFyb8=;
 b=f4Mdow3MZQaS7ro6eimGv65ZPus8ItJVvUUEwZiu+7EET5i58ZTJR9sZ0Q5InnstrRtwSX2gEbLOsii+1U1liqOnwwnaPTZTlVRIsrItndbIIP7SrHRdyHgTC90BJezVfJCM1q0Do0nqzpsBtt6mNA1XrP9R1Rd83uYUQn0DuZoy88ruqDrmgKYO28qSgFx/dLG6Y0o9cDPYmIm6F1MLckGVRBkdyrPH9ZsmU4KAejal59YRHWmWVdx+y/ooAXkz4nr+9l4LwyHhSxEriKyDPcmha+PaZAc48SH48JCZkRxASsRcNduR9y+Ay4+DD7XbT+VBnTjDcIskwXL4B/Kg+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB8659.namprd12.prod.outlook.com (2603:10b6:610:17c::13)
 by PH0PR12MB7813.namprd12.prod.outlook.com (2603:10b6:510:286::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 22:49:13 +0000
Received: from CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732]) by CH3PR12MB8659.namprd12.prod.outlook.com
 ([fe80::6eb6:7d37:7b4b:1732%4]) with mapi id 15.20.8534.034; Tue, 18 Mar 2025
 22:49:13 +0000
Date: Tue, 18 Mar 2025 19:49:12 -0300
From: Jason Gunthorpe <jgg@nvidia.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Leon Romanovsky <leon@kernel.org>,
	Nikolay Aleksandrov <nikolay@enfabrica.net>,
	Linux Kernel Network Developers <netdev@vger.kernel.org>,
	Shrijeet Mukherjee <shrijeet@enfabrica.net>,
	alex.badea@keysight.com, eric.davis@broadcom.com, rip.sohan@amd.com,
	David Ahern <dsahern@kernel.org>, bmt@zurich.ibm.com,
	roland@enfabrica.net, Winston Liu <winston.liu@keysight.com>,
	dan.mihailescu@keysight.com, kheib@redhat.com,
	parth.v.parikh@keysight.com, davem@redhat.com, ian.ziemba@hpe.com,
	andrew.tauferner@cornelisnetworks.com, welch@hpe.com,
	rakhahari.bhunia@keysight.com, kingshuk.mandal@keysight.com,
	linux-rdma@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: Netlink vs ioctl WAS(Re: [RFC PATCH 00/13] Ultra Ethernet driver
 introduction
Message-ID: <20250318224912.GB9311@nvidia.com>
References: <20250306230203.1550314-1-nikolay@enfabrica.net>
 <20250308184650.GV1955273@unreal>
 <2f06a40d-2f14-439a-9c95-0231dce5772d@enfabrica.net>
 <20250312112921.GA1322339@unreal>
 <86af1a4b-e988-4402-aed2-60609c319dc1@enfabrica.net>
 <20250312151037.GE1322339@unreal>
 <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM0EoMnJW7zJ2_DBm2geTpTnc5ZenNgvcXkLn1eXk4Tu0H0R+A@mail.gmail.com>
X-ClientProxiedBy: MN2PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:208:238::12) To CH3PR12MB8659.namprd12.prod.outlook.com
 (2603:10b6:610:17c::13)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8659:EE_|PH0PR12MB7813:EE_
X-MS-Office365-Filtering-Correlation-Id: a94df98d-263a-4a16-d99c-08dd666f1ac2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CnpzT5bUKFDPo5EjXqzOhwTPTDPimaOJwwgP5UftTeIM7jjzQjJwtX2Nrcxx?=
 =?us-ascii?Q?LixpAdApShaeiPZ+IV/IhOMpznrCzvBqb0gTAo/ZsGznWB5atxQ/EBveG0Rp?=
 =?us-ascii?Q?k/YJ7+ShiZclA9meCT8vNAeFACRFLC4MJlufcSKUAPKfGYG9gIMcmY2EDSxW?=
 =?us-ascii?Q?Dve9UFNGDB8GXxCfSJZSVzVzCrim85GLrYWkut3rWEZXOqK70KeAaPl6jGqO?=
 =?us-ascii?Q?qoocN4NxV6m/2byrM1Aqw41ED2u3s6KMBN5r5qZbAc1XQRbV+3xzUYzd1z69?=
 =?us-ascii?Q?cbe4adBd+bT4MC/GrO5BHiZhLF2PdIB9orRwU6etzXDgpONVuLXo7o8/kZOI?=
 =?us-ascii?Q?b1gkSVQIJ34ciF26r87PXMuHF57OT42DIryXseMObMkyxrEsaNO5dqj0nIN5?=
 =?us-ascii?Q?3KQD+Q8v1qR4+Qc40MgDm7K4d75gZIKOe3IfHTxtO9C6mhP1or0iJRnDrz8T?=
 =?us-ascii?Q?11TGSazlmySFggu6WDaOHS7QtyP9+FZipnn5chxlEgBdFEE+V1XMjcJGU/Lf?=
 =?us-ascii?Q?5NIT1kYbtnr7ALPPUgNqb+q3qUcf6pF0qIDkWTPcMWIJsKCHscUmhQJTt+OV?=
 =?us-ascii?Q?WesVKL60Q0EW3IdaQpcyh07GYdfL7dhmi1C869pqatQNtInfWBW/XftJMHls?=
 =?us-ascii?Q?4ke5Xr2HK83LlhHzGNyqUL+EQoa303c5PDpxvJOq8P+GOrsL1wXpKTRsFX16?=
 =?us-ascii?Q?yx6wSquCSsPXNbNNGlGan+iq7e2gAYCOvTx7wo+afThQuP/alwTM+8n7yoY/?=
 =?us-ascii?Q?3Dm2au0VwR5SS5E/BczhIjzEmP4GdKfCqkcb9mVg6FvK/idQ4hUtoGh0dGgx?=
 =?us-ascii?Q?MBLddEcu69XQ+9g1KUOU+G9d6jexHuIUtvBKywtjnTOFc8pcSonIa12xY58g?=
 =?us-ascii?Q?HlXlBNJ7ANvFjpaBPxdXzv8XFKoi+5++UZ0+Y7usdHyx5J6jgPfDdEV0FERy?=
 =?us-ascii?Q?RGxLsFSmX4BAN9t+F7PfHhU1X3/gv0kVsa4RT7/nIbrL+s8qmpnJnnt9tOhC?=
 =?us-ascii?Q?fGKC4xZ1XMo85LtgtG4ZMVyfX2M0zQIEKzBMZV43YHBk7ZvgzG4JU9GQ8TtS?=
 =?us-ascii?Q?/3I2nHH+slPiTTXPJzCvhKBQLo9qrNPO/IqahgewBuNGCmgLw0flP8DyI+Gq?=
 =?us-ascii?Q?nivZSLbAiiT6QNxqkzG8ze59uoRa1o/NSjf32gzt+05FxqhxAF7HdhJTuHr4?=
 =?us-ascii?Q?Hy4/TngJK/mheg8WzjFInwkLOWXraa22RSDrD0SLwqGYYEEAnFuiQrlkosCx?=
 =?us-ascii?Q?YRwV4EV1MwSybOmD8xUlQ5Espp1AfcL2oqNlD1KSLpri2UT14D0VCJD+avg7?=
 =?us-ascii?Q?+HUe2pAUSlswEXk5MdiwhOJkYzOK+pyzcxIj17UbsSOaWz5prnzGvdqHUk2r?=
 =?us-ascii?Q?go7k+YCsB6OLghKtCSjpQGNKd6Kc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8659.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?uvCoSY9e6b7XjwHKZKk1ErWb+O4SlDvSHiqUpbW2lzJhEZBKBYC8EPTq1spn?=
 =?us-ascii?Q?hMz6Nlj4FHAcMbw837PMgbGklpxNVTEEhMXYEvGdQh57ifSHFqYB73nGaUPg?=
 =?us-ascii?Q?DfbctMSedbv/mlW8btaq36ZIKJWZc2MgN3ihI/wxR9hJPtDJ67qNztau1j4K?=
 =?us-ascii?Q?LEA1mPtcn3pZx8x/mkhRnb632eV3JEycu8ap1z+3eQLn2nD/DVvw4FDIODSg?=
 =?us-ascii?Q?hoB+cYmPis7lYgM3vB/lRBmWnQyf6c6PTaVXcWHTKm9jTVRNyE/G5GsuEPby?=
 =?us-ascii?Q?ojukkeSE0/hBwkR6Z+BYHJ4LC3Od/zOVN/Uzrrr0VSAjZuxAXlP8BKl6x2p4?=
 =?us-ascii?Q?WTC8Q2q3XuocCXWKJQW6B1n8+TUGAarca/wNa+YAW6RHiH1zGwkwPhVStuRg?=
 =?us-ascii?Q?t8ly3jj+3vJ+XA+z+x2OpICKA0gpNa7MbvqBd9SjBKNiQBp1prDDsX6P1Bzl?=
 =?us-ascii?Q?fCidjbNHB1cU2B2KD6Formrt0jsuxelrvu5ucGoIgcKKY7yqzZHJKjN38/q2?=
 =?us-ascii?Q?RcMaoZH62082QEcHJoomcCg7SzVXpyNOljDZ6Sl1Tmw2BmKbq3m6Xh0slPyz?=
 =?us-ascii?Q?vLWOIPwSjNEE3FTBy4mlt79a3/6c5BdZ+YxCVk7vpUzFFglJ4AFsW9Wi10sb?=
 =?us-ascii?Q?Zj/e1jL2ToMSjNHXcJtIxTa+BP4T8V45vvXApsvKE+OYE5FTqZ0uzbwHbalo?=
 =?us-ascii?Q?Lc1FDVOdxizIwHLpw2BDVw7gUE8wjZhVZSYK1yOEfxFlawj4Iit2eIDQtinR?=
 =?us-ascii?Q?z8hIHtkWgHhvLrx0XdPRF19TWtCrMRGPefWkL/WnvFF2CST2hKNvJIFqded1?=
 =?us-ascii?Q?WbNm/IavICIA5B6xaWUu2TSNEVEhnRQdWG07zRweJlL60bbxw/5UE8+XE7ft?=
 =?us-ascii?Q?NqhhrR5t2IQOAue7BpZ2opwHqBijlaXKfT5IngFsh0/HQArbBdMWNQJ8RbVD?=
 =?us-ascii?Q?w+f0dRzAlD6bBSv+MilOS6QnGcgXBJ5DL5k5he8ZkA02tvQ4LkAmdM39L8BL?=
 =?us-ascii?Q?1FpE6DWNUD0Jo5FuReKrViYYQhPc5zrY+PjxaabPmw+a/UxGCrd7wAK+BqcY?=
 =?us-ascii?Q?w8NmjmRaxA8ATwQmz+FLzj5wqlek7feSssRCdcH3HTIoYA8W4F+E81ZqHze0?=
 =?us-ascii?Q?YMBlTH9gqJFgYxZEi+N6DJ6ZMJ/AdNNJ0MkqU4aOB9lj7IN2nBPPZvsnNTNG?=
 =?us-ascii?Q?az4Ib3TwTNtIjL1jVQ2vUukcBYKRZvywSGct+z90yT7FWXhW6eK4kG8Wo2mo?=
 =?us-ascii?Q?78Yf1UCx/1RKwbQvv8i7HG1HzI7s0lh7+cUt69n+Wq6qAOq8ZlgIWGJY0362?=
 =?us-ascii?Q?P3IoGQXY7fb1MAOOFHDqLHNK0squU9KlQCgszvf2PUSRqhRnxQ2TsIF8ljhX?=
 =?us-ascii?Q?QLLjxHfr2m0/GIYT6kbYLk922yl1FYnchLQ92tr5oaAw/glWF5FBNJWOkNdS?=
 =?us-ascii?Q?bUblJEPcMlmJs9vp/Jw54BTCzlSEnmevvWCWNZcQRdiNnsHHtUlEIvwBrC8h?=
 =?us-ascii?Q?atdfwPfXN4tECqg7ZZIj0L0+3tnZ0rEYj5ndAsZYTsJD2VZaJ/8CFupWn8kW?=
 =?us-ascii?Q?/RGOXFJ4Vf19DPXxHsw=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a94df98d-263a-4a16-d99c-08dd666f1ac2
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8659.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 22:49:13.5270
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOWkcDluNRtOpMLt22reQ5RVdP/g5nk8xRK4uw1774dv1caWi9QTC2mJbKOgS2Ee
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7813

On Sat, Mar 15, 2025 at 04:49:20PM -0400, Jamal Hadi Salim wrote:

> On "unreliable": This is typically a result of some request response
> (or a subscribed to event) whose execution has failed to allocate
> memory in the kernel or overrun some buffers towards user space;
> however, any such failures are signalled to user space and can be
> recovered from.

No, they can't be recovered from in all cases. Randomly failing system
calls because of memory pressure is a horrible foundation to build
what something like RDMA needs. It is not acceptable that something
like a destroy system call would just randomly fail because the kernel
is OOMing. There is no recovery from this beyond leaking memory - the
opposite of what you want in an OOM situation.

> ioctl is synchronous which gives it the "reliability" and "speed".
> iirc, if memory failure was to happen on ioctl it will block until it
> is successful? 

It would fail back to userspace and unwind whatever it did.

The unwinding is tricky and RDMA's infrastructure has alot of support
to make it easier for driver writers to get this right in all the
different error cases.

Overall systems calls here should either succeed or fail and be the
same as a NOP. No failure that actually did something and then creates
some resource leak or something because userspace didn't know about
it.

> Extensibility: ioctl take binary structs which make it much harder to
> extend but adds to that "speed". Once you pick your struct, you are
> stuck with it - as opposed to netlink which uses very extensible
> formally defined TLVs that makes it highly extensible. 

RDMA uses TLVs now too. It has one of the largest uAPI surfaces in the
kernel, TLVs were introduced for the same reason netlink uses them.

RDMA also has special infrastructure to split up the TLV space between
core code and HW driver code which is a key feature and necessary part
of how you'd build a user/kernel split driver.

> - And as Nik mentioned: The new (yaml)model-to-generatedcode approach
> that is now common in generic netlink highly reduces developer effort.
> Although in my opinion we really need this stuff integrated into tools
> like iproute2..

RDMA also has a DSL like scheme for defining schema, and centralized
parsing and validation. IMHO it's capability falls someplace between
the old netlink policy stuff and the new YAML stuff.

But just focusing on schema and TLVs really undersells all the
specialized infrastructure that exists for managing objects, security,
HW pass through and other infrastructure things unique to RDMA.

Jason

