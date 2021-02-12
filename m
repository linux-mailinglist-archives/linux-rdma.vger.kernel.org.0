Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C0331A1E9
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Feb 2021 16:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbhBLPk7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Feb 2021 10:40:59 -0500
Received: from hqnvemgate25.nvidia.com ([216.228.121.64]:4177 "EHLO
        hqnvemgate25.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbhBLPk5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Feb 2021 10:40:57 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate25.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B6026a15b0000>; Fri, 12 Feb 2021 07:40:11 -0800
Received: from HQMAIL111.nvidia.com (172.20.187.18) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 12 Feb
 2021 15:40:10 +0000
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.176)
 by HQMAIL111.nvidia.com (172.20.187.18) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Fri, 12 Feb 2021 15:40:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V/t55ojSADoFGI3oLN34g2r4jc5GdAuDVh11+QJhHCiAUoPxEVIr/ac4kkgbUUKgGy/iepNPk29D8l/LJVRTdIxqOLohwtkRT38C2glf0UcnPBG7IsAsCywKZl7as6JjPMCPtM9KfGHNlyFLRjuKLJrynMYoFgb57iCLpjYg+K6w+/t2SzkUcVZW6Piy6vsktyXfJ0AidJqWoxnLXKIoqLsAsS4Lc4i5A6OYgwC85hAIP+8douVLMjnQDPir5V1Fx17aNsi0yUU/Er8s+Bh2Mu9uNORNroMr7O5F4iFvEjvFClVMiCURPgG4xkIRb9OQ3HJUpR+RsUPKvb8lPyH92A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BNZWp+pGPezV2kER24PezWLFcrWjuOrQjKUYGcAUSBw=;
 b=CrjvhcQhrsnQeZ3OIcSNOrPqDznwCMrD1krsq/vyatNxcn9uZQNt4pLlAFLNnrczAkn0yFynQCoJxZ/n6wjR+9o7Hn8CrC28MlHlQNsbQnGRYfZvbrGcxvQ6KtfoipdxuaeWZxZfAU0g4xoU+8wZLS3ph4UsUhnIYwrdoQI6ShtWxgGVs2WW7D2a5KQ/0zCKoVe9wCAhvNcT3VnvDNMp4aCCNA4llVmkerJpin8GGRHZRZif1O2ItR3CJL11M2gBhYh2gfl7phmfMcYoUl84D5RVu1QOXgMfpYBIMuezbgM6yGjzMraRn/rOApTxdHByilFN49/XS4xqk+ddW5GM6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
Received: from DM6PR12MB3834.namprd12.prod.outlook.com (2603:10b6:5:14a::12)
 by DM6PR12MB2603.namprd12.prod.outlook.com (2603:10b6:5:49::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Fri, 12 Feb
 2021 15:40:09 +0000
Received: from DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4]) by DM6PR12MB3834.namprd12.prod.outlook.com
 ([fe80::d6b:736:fa28:5e4%7]) with mapi id 15.20.3846.030; Fri, 12 Feb 2021
 15:40:09 +0000
Date:   Fri, 12 Feb 2021 11:40:07 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     Doug Ledford <dledford@redhat.com>,
        Avihai Horon <avihaih@nvidia.com>,
        Amit Matityahu <mitm@nvidia.com>, <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v2] RDMA/ucma: Fix use-after-free bug in
 ucma_create_uevent
Message-ID: <20210212154007.GA1716976@nvidia.com>
References: <20210211090517.1278415-1-leon@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210211090517.1278415-1-leon@kernel.org>
X-ClientProxiedBy: BL0PR02CA0095.namprd02.prod.outlook.com
 (2603:10b6:208:51::36) To DM6PR12MB3834.namprd12.prod.outlook.com
 (2603:10b6:5:14a::12)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (142.162.115.133) by BL0PR02CA0095.namprd02.prod.outlook.com (2603:10b6:208:51::36) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.25 via Frontend Transport; Fri, 12 Feb 2021 15:40:08 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lAaYB-007CjL-7g; Fri, 12 Feb 2021 11:40:07 -0400
X-Header: ProcessedBy-CMR-outbound
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1613144411; bh=yexm+o8z8/lFAwf2GKXchjcUD5avwqko0D+0ELj4Vrs=;
        h=ARC-Seal:ARC-Message-Signature:ARC-Authentication-Results:Date:
         From:To:CC:Subject:Message-ID:References:Content-Type:
         Content-Disposition:Content-Transfer-Encoding:In-Reply-To:
         X-ClientProxiedBy:MIME-Version:
         X-MS-Exchange-MessageSentRepresentingType:X-Header;
        b=M0+QYghNAZjKpGCx29oO2+Uzc6FCReu1nl4LGlpZlPXGmXpe8E5+BLyShSqai22FH
         cfm+t5dkm/Iw/R1/2vhCwIjiEad1HImWHmBtYi7QjR+NZ/XcooHRP4U1SAjHTzWnIR
         OMrK/y9I4rADxrzB5yjbk9Tlic2Sz8XlTe04E2Zaxzrpx9uVJvfwXvz/Q5w7Yz8q5t
         PAqJp5g+3FyTGBIAKfupdbcvI82BUXu8Xj5dNz1mIx1AjORzwzgpmU96bM0aV1fP0B
         Pn+bKFUEzrcotQTUlc1d8Ph7JCt+aC7kPxiV5CX7bVcjzpNgwi3z03kTkxdC054xkh
         UdEt2fdhhA6Bg==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Feb 11, 2021 at 11:05:17AM +0200, Leon Romanovsky wrote:
> From: Avihai Horon <avihaih@nvidia.com>
>=20
> ucma_process_join() allocates struct ucma_multicast mc and frees it if an
> error occurs during its run.
> Specifically, if an error occurs in copy_to_user(), a use-after-free
> might happen in the following scenario:
>=20
> 1. mc struct is allocated.
> 2. rdma_join_multicast() is called and succeeds. During its run,
>    cma_iboe_join_multicast() enqueues a work that will later use the
>    aforementioned mc struct.
> 3. copy_to_user() is called and fails.
> 4. mc struct is deallocated.
> 5. The work that was enqueued by cma_iboe_join_multicast() is run and
>    calls ucma_create_uevent() which tries to access mc struct (which is
>    freed by now).
>=20
> Fix this bug by cancelling the work enqueued by cma_iboe_join_multicast()=
.
> Since cma_work_handler() frees struct cma_work, we don't use it in
> cma_iboe_join_multicast() so we can safely cancel the work later.
>=20
> The following syzkaller report revealed it:
>=20
> BUG: KASAN: use-after-free in ucma_create_uevent+0x2dd/0&times;3f0
> drivers/infiniband/core/ucma.c:272
> Read of size 8 at addr ffff88810b3ad110 by task kworker/u8:1/108
> =C2=A0
> CPU: 1 PID: 108 Comm: kworker/u8:1 Not tainted 5.10.0-rc6+ #257
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> rel-1.13.0-0-gf21b5a4aeb02-prebuilt.qemu.org 04/01/2014
> Workqueue: rdma_cm cma_work_handler
> Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0xbe/0xf9 lib/dump_stack.c:118
> print_address_description.constprop.0+0x3e/0=C3=9760 mm/kasan/report.c:38=
5
> __kasan_report mm/kasan/report.c:545 [inline]
> kasan_report.cold+0x1f/0=C3=9737 mm/kasan/report.c:562
> ucma_create_uevent+0x2dd/0=C3=973f0 drivers/infiniband/core/ucma.c:272
> ucma_event_handler+0xb7/0=C3=973c0 drivers/infiniband/core/ucma.c:349
> cma_cm_event_handler+0x5d/0=C3=971c0 drivers/infiniband/core/cma.c:1977
> cma_work_handler+0xfa/0=C3=97190 drivers/infiniband/core/cma.c:2718
> process_one_work+0x54c/0=C3=97930 kernel/workqueue.c:2272
> worker_thread+0x82/0=C3=97830 kernel/workqueue.c:2418
> kthread+0x1ca/0=C3=97220 kernel/kthread.c:292
> ret_from_fork+0x1f/0=C3=9730 arch/x86/entry/entry_64.S:296
>=20
> Allocated by task 359:
> kasan_save_stack+0x1b/0=C3=9740 mm/kasan/common.c:48
> kasan_set_track mm/kasan/common.c:56 [inline]
> __kasan_kmalloc mm/kasan/common.c:461 [inline]
> __kasan_kmalloc.constprop.0+0xc2/0xd0 mm/kasan/common.c:434
> kmalloc include/linux/slab.h:552 [inline]
> kzalloc include/linux/slab.h:664 [inline]
> ucma_process_join+0x16e/0=C3=973f0 drivers/infiniband/core/ucma.c:1453
> ucma_join_multicast+0xda/0=C3=97140 drivers/infiniband/core/ucma.c:1538
> ucma_write+0x1f7/0=C3=97280 drivers/infiniband/core/ucma.c:1724
> vfs_write fs/read_write.c:603 [inline]
> vfs_write+0x191/0=C3=974c0 fs/read_write.c:585
> ksys_write+0x1a1/0=C3=971e0 fs/read_write.c:658
> do_syscall_64+0x2d/0=C3=9740 arch/x86/entry/common.c:46
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
>=20
> Freed by task 359:
> kasan_save_stack+0x1b/0=C3=9740 mm/kasan/common.c:48
> kasan_set_track+0x1c/0=C3=9730 mm/kasan/common.c:56
> kasan_set_free_info+0x1b/0=C3=9730 mm/kasan/generic.c:355
> __kasan_slab_free+0x112/0=C3=97160 mm/kasan/common.c:422
> slab_free_hook mm/slub.c:1544 [inline]
> slab_free_freelist_hook mm/slub.c:1577 [inline]
> slab_free mm/slub.c:3142 [inline]
> kfree+0xb3/0=C3=973e0 mm/slub.c:4124
> ucma_process_join+0x22d/0=C3=973f0 drivers/infiniband/core/ucma.c:1497
> ucma_join_multicast+0xda/0=C3=97140 drivers/infiniband/core/ucma.c:1538
> ucma_write+0x1f7/0=C3=97280 drivers/infiniband/core/ucma.c:1724
> vfs_write fs/read_write.c:603 [inline]
> vfs_write+0x191/0=C3=974c0 fs/read_write.c:585
> ksys_write+0x1a1/0=C3=971e0 fs/read_write.c:658
> do_syscall_64+0x2d/0=C3=9740 arch/x86/entry/common.c:46
> entry_SYSCALL_64_after_hwframe+0x44/0xa9
> The buggy address belongs to the object at ffff88810b3ad100
> which belongs to the cache kmalloc-192 of size 192
> The buggy address is located 16 bytes inside of
> 192-byte region [ffff88810b3ad100, ffff88810b3ad1c0)
>=20
> The buggy address belongs to the page:
> page:00000000796da98e refcount:1 mapcount:0 mapping:0000000000000000
> index:0=C3=970 pfn:0=C3=9710b3ad
> flags: 0=C3=978000000000000200(slab)
> raw: 8000000000000200 dead000000000100 dead000000000122 ffff888100043540
> raw: 0000000000000000 0000000080100010 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> Memory state around the buggy address:
> ffff88810b3ad000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88810b3ad080: 00 00 00 00 00 fc fc fc fc fc fc fc fc fc fc fc
> >ffff88810b3ad100: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff88810b3ad180: fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
> ffff88810b3ad200: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>=20
> Fixes: b5de0c60cc30 ("RDMA/cma: Fix use after free race in roce multicast=
 join")
> Reported-by: Amit Matityahu <mitm@nvidia.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
> Changelog:
> v2:
>  * Delete cma_id_get() in cma_iboe_join_multicast.
>  * Added WARN_ON(ret) checks.
> v1: https://lore.kernel.org/linux-rdma/20210125121556.838290-1-leon@kerne=
l.org
> ---
>  drivers/infiniband/core/cma.c | 70 ++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 29 deletions(-)

Applied to for-next, thanks

Jason
