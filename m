Return-Path: <linux-rdma+bounces-1825-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD36D89B7BF
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 08:39:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC5841C2172E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 06:39:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFB658473;
	Mon,  8 Apr 2024 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pSU6PTqs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE031D52C
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 06:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712558370; cv=fail; b=bEsDy4CZXAyDeF7HPwqIATumN3jk5U9MfXRGkvtbNRoEhBwV9L+YugTUzv8+8vp5VgbRy5gk7oh8t0GJz0SbDkERyxc4O1xNmUpEpge+mV4SKXSpJX0EoxHyi1PMA3Is6RJPEopaDI4TLxIcPXBbyfqZFOlurhxeQwS2BfsRpXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712558370; c=relaxed/simple;
	bh=mJ28Ru/wF90rx8s+cgv14kR2b7/Ic3GfX8wJ6tRHaCQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qqeM2TRh78W2vv0FCL1qvMQRTH8N6uIcDl+4a86vw39bLpGn+MT9aaVGBjdEw4+mRNTkN3naOKIV4wvPVyJ5Ri5MINx59Z1JZ8BLNj/xCdpzcxtBNy8bHPyoXowjU4tXXM4JaKOYyq/C1E9EZd3yKB4rQur2v0c6+J+zN+N0uQ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pSU6PTqs; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E0OzkLYMinFBFiMApnNj7OicPFr66KRdPom05Vo6DgMX/TPb4Q0RR/YRdGLqS1rbEJgDrsPGlWcxEinjDoIkH2eHQKbsaZKmlN6k+guv1yD2gSwOOnxdF8mwJW2bPUsvZWaRQHUaVfWHC2zZ5ZeVryTq1VMrQFYIN3qt6KLaxvyabgwyPk2X0a8Va4Tcmqb4fXMKAdVLfzFT/1XTznInoteNVaZtD0ESawNBy3hO1vwrtl7O8x3Sq7axr7p7dMMd4WpFgV43XFSezbDeaRDy6m7MBf4BhLYp8ZFXFm0oKFEJrundo/Lz99+1Zlwx4TzzH2KQVgOB9rD6uyteFd+EDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3fVqp6w1Z7nClmkSyAivCJKvz3yObEfwZJhKnfOzNdw=;
 b=dw4O8kedKSkMhAbW+lRp1yibhncUdb28rIGqSYIEttC+mDI0fTmA+ipQhsXU8DwBgqmzAiKb7SWhnO7/AJFw04WcYTYIsJmAeOjkTQbB2ei4sHtiEzNdiMdUNlpQ6qawWqxE4+X/DzGJ5NPeST+1V+JzdN4dwGXomMBgpKH1SxRbgeDx5nWPBE4lq4VlX+y70U2QuAt3HVBSxct0ndqMmCMmrBQJ7zFISvS5BaY9XNJdWJZE9OwbPuE3G64PZE/mmFFHX6nJB+jWKSb4F01bFngwqpMsl3jB4Coqo5GPuHLjPsJYldbgrG5XwFxUiExN75TU43+u0z2jhDbrI/qdaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fVqp6w1Z7nClmkSyAivCJKvz3yObEfwZJhKnfOzNdw=;
 b=pSU6PTqs9cGkm6987UxDz4Q4ZhqfeDNF6MOzuZc2h19LZXC6lewtyoLv2SZRZMnlgEhWLFK08EnXQXPZZ8IBI3ws2VD2gG1EiXS8FPjz/4wQJdq847NprTyVCmtu0Us9/kH7po+vLtV8xVcjpCc/x/K81xmJqRQxTYDsBxqkaaxl1o8mpX2v4/ryUTlr7S8BfcDsODz8raipMMPkqqs9avok/J1VkGLDwSPQ1dvFgqN7WMFd6RqdIYnn/kLTjvzTTV4e6UZT+/A55PbXQ83DDSUdm0Afkg3RXS5m/GUuBLbzwFQySROJVoCsbVdEH7Qa/T/3dBldnlEVf5YZZpQXrQ==
Received: from MN2PR17CA0019.namprd17.prod.outlook.com (2603:10b6:208:15e::32)
 by SA0PR12MB4478.namprd12.prod.outlook.com (2603:10b6:806:9c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Mon, 8 Apr
 2024 06:39:25 +0000
Received: from BL02EPF0001A108.namprd05.prod.outlook.com
 (2603:10b6:208:15e:cafe::6a) by MN2PR17CA0019.outlook.office365.com
 (2603:10b6:208:15e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Mon, 8 Apr 2024 06:39:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A108.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 06:39:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 7 Apr 2024
 23:39:10 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 7 Apr
 2024 23:39:09 -0700
Date: Mon, 8 Apr 2024 09:39:07 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: RDMA mailing list <linux-rdma@vger.kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [bug report] kmemleak in rdma_core observed during blktests
 nvme/rdma use siw
Message-ID: <20240408063907.GB8764@unreal>
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A108:EE_|SA0PR12MB4478:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fe224df-9cbb-4379-3768-08dc5796a1e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	UJaZIH4UDK7Z5jm12uH57TKtkUczv9iyl5NQkzPOyITBAZsJNHktFQ+azXqq+FuydxhalGMoaOXM8sMdL3oinNmFiMADUkVkFdI6ZW9HdFzkwvjfreiJaYFWrLkH2QQk2lis8agE1keiOfpPRgCcYbai+1lXL0eWPfi2IskFYS83viQ78OQ9R5MUXAofFGBGKVMBy9DrzX5gwSKLfN2dDR4iCH+LP5twa/x36B5CgM6tjK/CW7fwIjPtHjYMDiDbx+7YOBxRknP1SIA+S8giV/l4GGhU1MYU2qsF3JIN+n2q9jb2HXQKSTaDDA+Wek78IsP9sJqREAz51walvasFtvZqRfWHFXp8lQpwGzXn3Xccb7JdSyi3MHxtGRjY4/6bo/xuhiya+sR7ZdE/Dirca+FciRVYPH9FixOCXzdndfdBGaENiqMU9Ul1C/BO8wxSPkC0tOgms3BrPv6pxa4zm4nC7wATgVsBn3DujW/JL+fzAr5KztRfxK+5ofhZest4yO+8rA5i+kWuq3Yx5SLRAbag3E/JE3Mi7tD0qrdEjQI8DfC5RIdWSkNY4WWjSyIGe1zIElXA02UzJEtRmvkSEK2RYyjv5kbl/kbeNDRdJXVTMrQf13eMvTQpv1ZHOIrp+id24jPYteS14JeilbDIWChFXCr1cs7nF04tAyPkZve5AVrpWSWo2fFD4nRYo5JlDrBX1OGe7xHsybbNVScWy8wNKGxapsoI4CHo1GMhoIhQNu8aBCKZmSkpebFsZT91
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 06:39:25.1019
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fe224df-9cbb-4379-3768-08dc5796a1e9
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A108.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4478

On Mon, Apr 08, 2024 at 02:03:51PM +0800, Yi Zhang wrote:
> Hi
> I found the below kmemleak issue during blktests nvme/rdma on the
> latest linux-rdma/for-next, please help check it and let me know if
> you need any info/testing for it, thanks.
> 
> # dmesg | grep kmemleak
> [   67.130652] kmemleak: Kernel memory leak detector initialized (mem
> pool available: 36041)
> [   67.130728] kmemleak: Automatic memory scanning thread started
> [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
> /sys/kernel/debug/kmemleak)
> 
> unreferenced object 0xffff88855da53400 (size 192):
>   comm "rdma", pid 10630, jiffies 4296575922
>   hex dump (first 32 bytes):
>     37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
>     10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
>   backtrace (crc 47f66721):
>     [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
>     [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
>     [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
>     [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
>     [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
>     [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
>     [<ffffffffc2a3d389>] 0xffffffffc2a3d389
>     [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]

My guess is that your test didn't call too nldev_dellink() and left
device registered.

Thanks

>     [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
>     [<ffffffffc264648c>]
> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
>     [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
>     [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
>     [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
>     [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
>     [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
>     [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79
> 
> -- 
> Best Regards,
>   Yi Zhang
> 
> 

