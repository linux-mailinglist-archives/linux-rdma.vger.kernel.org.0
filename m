Return-Path: <linux-rdma+bounces-1826-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3229489B809
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 08:57:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E607B22125
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Apr 2024 06:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF691CAAC;
	Mon,  8 Apr 2024 06:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Aj3rTdcM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26E4200BA
	for <linux-rdma@vger.kernel.org>; Mon,  8 Apr 2024 06:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712559459; cv=fail; b=k7/UXYLEU+NUO4YjgPG/OT9Sp/kMIfbmmM8H9XtKi9mSRYQzxEYytTYOSN+mYE4hKCkIGHbvXTE/TIv9xOadL9Zf6ZKst8uH0UlaLhpFZA4e/OQ4MrfKofgdvaxcUmAf7m04gpLtg+3ydAW2UPmRRIrZYgXt6F/7xFmo7iczKAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712559459; c=relaxed/simple;
	bh=1Xodh1zcpeHBDUXjFAD4ZgypKkQ7i1hBHN8nozFB6oI=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ht40er4f1wfEVH/CUVsxTADgtzd8ySURTHRC9UmcvwgcHd46v4yNW4KfyRT5HSzEtj4SFeN1XEKSwgENKCMDp2bRchP3oTvck3pZuI/wDWTYZQP2bqKc6xMTDCYvtMhnYR+5aLVvHWKY0ce92mGDg2VQhP/nwvReOqiCs6oAHvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Aj3rTdcM; arc=fail smtp.client-ip=40.107.92.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EmmQXROUdJah7nGmEy3dlGSAKJYmwESVmn0fYpH//fTgk+jbAmxQuXVA9BpihZDz8epINBerzNoUsy4IudhEmiONs0uvZaD5PaIxGyBPzhFF6MwuUOETKtWcsiPC/eb1lMPZl6ZLJw87/QdSfFLkO72cFM9KhYSAoIhyoFw5j+TjzpXUB5KzYXtQfmHvF+HaMc0uH12VUSmoeOUpWuZtYIy22BohjAEphuFHVXyJ5VjX6+0rEwnlEi7vEEnY1BG8pTZcsPzWswh06VI7L5n0qRsNwvopRz0OhA232QO02wWME5L9ky7EVvQtEKe2gKAkylHqmmWpZRchSxGyyqqHVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eak1W8t8KKybh6bCwFW+Qkufrp8HOSSisuzKJiBz7jg=;
 b=BkEhEgTUT2aDS95H/28idGkiQEc59xCEmNZSrYjPPnRE2gBxATTz+G0OHoM+JIE7yjGq4eJwa6hLQ8QToQAToUxh1rRHN5dlwcqOrXhrFcy5AfDoM3COyiulxRutGLgfi9aAC3OP4GUxOs1nKFvEMaq+nJGHbQf+ZuwcL9pMEDzGio9CViVBMQNEN8+5WEBEIguCE8Ln3ICXf2Q8hfMTHo+Azbd5fW8J+qYE7ulz5ti8TMfFFBhqnMvWigU8XdtV0Q4CAVdLZYh9pRRJh8jjsmL4IcI5q2ao5+OgnuTIRDTTZ6zKgNSG0/dzm8W4iEtaoDe8D6gbIuH5x/qiDlcWJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eak1W8t8KKybh6bCwFW+Qkufrp8HOSSisuzKJiBz7jg=;
 b=Aj3rTdcMOyvJWCdNv5NnW2VuCdzLInvzBx6dgpVpeVDCuXY9OzWepiK44gcQYV/DKd2liVBSG20NdKUEsnRq1MYCaCVZzqyFqzALRui4zVMFsstczt81f3Y6HotC7Xfq2G6d8pvBVekMdQ7gebemwdWtEI2YncGc2J3jycjD0ar7O72L1l3uzqnyvZP0o6HAaKMLEFXOtHddkNc2qHyYnmvy9jjch+llq73wTQqhVhT93sI0V6KSYUjGbj7wfioWmHZV6pFeVNgK+aZEX3lACRZSGzRI2PWblkg9Q+zCH6JUy2WugILkP4fH2oxyt5AXM+LMpw44Np+Ml2JgnYEF/Q==
Received: from PH0P220CA0028.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::17)
 by SJ0PR12MB6782.namprd12.prod.outlook.com (2603:10b6:a03:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Mon, 8 Apr
 2024 06:57:32 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:510:d3:cafe::23) by PH0P220CA0028.outlook.office365.com
 (2603:10b6:510:d3::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26 via Frontend
 Transport; Mon, 8 Apr 2024 06:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Mon, 8 Apr 2024 06:57:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Sun, 7 Apr 2024
 23:57:13 -0700
Received: from localhost (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Sun, 7 Apr
 2024 23:57:12 -0700
Date: Mon, 8 Apr 2024 09:57:10 +0300
From: Leon Romanovsky <leonro@nvidia.com>
To: Yi Zhang <yi.zhang@redhat.com>
CC: RDMA mailing list <linux-rdma@vger.kernel.org>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>, Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [bug report] kmemleak in rdma_core observed during blktests
 nvme/rdma use siw
Message-ID: <20240408065710.GC8764@unreal>
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
 <20240408063907.GB8764@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240408063907.GB8764@unreal>
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|SJ0PR12MB6782:EE_
X-MS-Office365-Filtering-Correlation-Id: 472a68ad-9088-40b8-9eda-08dc579929ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	edsxwDZV6JOXeliftDO1TjEBdbY5oMhnzyrH6bI80dl+wG0OhO31qgngBEvdX32wQ/QTwX3UgLlLP90g9GCLZYDJIst2jD7OeAAtpbquSiGnxuqZnZ6szW1kzVPid2x/k7uycnqT/BXoAKbCre+ZsCBNngJC9vJqOMojx/0XuhOGWj/hIh2bT6UCWtpSpRseal/brVLDJmVis0mnuqBlJQOcZG1j+nh4LoEZ2b8V19G9N1e0rA8hXK6CPH/Pmk4wfdImalLOn/INpTAWxhU/LpEJPFv9Aq1fqQuUwFsiHfw11RGf6xTUVUmyWKCD4HFO4v3PnTcaCvxu1tSdoFIaHTR8igP3VtyG2Emigo90Tkr8eMtrEP8wizT+qAYZGbj9Fwz2WsDFRwHWwOD+BCWVYEgssrdrj+M5X+9DKAfesRoETEKDlbjywO3KhIw6XGL3wKN/Qhsd1DaaHt8oSaOPDva6SUquAk4w1ycw/BJeAz2cJFNl6Rr1x/z9Fc6ljz5/F5PcKytEzYeDcqgoM4zIHjOC8q3HAlJdFWV65Dtehnmv5kmYuUrR7jW5u0oUmCfo8Qtta9vR+N5QtQ3T+l8YWqvhZOjM0cOIn6+9QXmFrLej+6Sp3mC0aNsUWDnIYLvKLE7zx3aANlmhbjZXS04cb18YXQbT0dCwcmqIVFZQoT+SM/Q6AAm8Y0iHw0zDsffl32QGCEpp4N/K32t7bJd2V1K9Li7/HLhsTDrcux7qfFpXeNKF2LFQAmOrG0oxYHg4
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 06:57:31.9284
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 472a68ad-9088-40b8-9eda-08dc579929ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6782

On Mon, Apr 08, 2024 at 09:39:07AM +0300, Leon Romanovsky wrote:
> On Mon, Apr 08, 2024 at 02:03:51PM +0800, Yi Zhang wrote:
> > Hi
> > I found the below kmemleak issue during blktests nvme/rdma on the
> > latest linux-rdma/for-next, please help check it and let me know if
> > you need any info/testing for it, thanks.
> > 
> > # dmesg | grep kmemleak
> > [   67.130652] kmemleak: Kernel memory leak detector initialized (mem
> > pool available: 36041)
> > [   67.130728] kmemleak: Automatic memory scanning thread started
> > [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
> > /sys/kernel/debug/kmemleak)
> > 
> > unreferenced object 0xffff88855da53400 (size 192):
> >   comm "rdma", pid 10630, jiffies 4296575922
> >   hex dump (first 32 bytes):
> >     37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
> >     10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
> >   backtrace (crc 47f66721):
> >     [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
> >     [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
> >     [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
> >     [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
> >     [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
> >     [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
> >     [<ffffffffc2a3d389>] 0xffffffffc2a3d389
> >     [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
> 
> My guess is that your test didn't call too nldev_dellink() and left
> device registered.

Sorry, I was wrong, it looks like GID entry leak.

Thanks

> 
> Thanks
> 
> >     [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
> >     [<ffffffffc264648c>]
> > rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
> >     [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
> >     [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
> >     [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
> >     [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
> >     [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
> >     [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79
> > 
> > -- 
> > Best Regards,
> >   Yi Zhang
> > 
> > 
> 

