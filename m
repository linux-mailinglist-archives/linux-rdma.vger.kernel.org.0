Return-Path: <linux-rdma+bounces-2053-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85AC8B0AD8
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 15:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8516E2890D3
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Apr 2024 13:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A28D815B56E;
	Wed, 24 Apr 2024 13:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pqHAOqx2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF50915A4B0
	for <linux-rdma@vger.kernel.org>; Wed, 24 Apr 2024 13:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713965325; cv=none; b=p4YEL/9UchN055i5bKrVP5Bzj/oz66EKB8edzKvV2+VLNwr6DDpLe8xMvugN1rWWFsv7eSEQTe+IHpTklHJnvUqfograhGXQZQwH0yZG7ZgG55VHLaUJUVJ1rNxSjlWZP9JsvOAJ04mWQV7UhVPF8TPqAFKLaW9i7Q9afFd7b9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713965325; c=relaxed/simple;
	bh=XDkyNsTrBcYyo+3Ubm+JBcmkXQgJE7lyQpMBKYhlsOE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g1RYPFmThNxM+qF2fSiNGt/lRSKIBJRYsdWhtJn4yfJtn4K/UFz94fyNW5rmzdvHtovbCRGOozlgwUXPjYyrPi74QbuIRwdjbZDrEq34S8ZJqpUlndwDGdyAEmxB+0uVg8VGz2RqEiIg/VJ1qa306yMBf0UEaOOjpSyieJRxIx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pqHAOqx2; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7de9793f-6805-1412-3fae-a5508910124b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1713965319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jNmiYMIp2RQ2ow9rJvUN50cmKOLbTZHWc4qSLmcKTeg=;
	b=pqHAOqx2b+QB4JAGMP11Kv1hVz0jMlK4DWOC0FRlggZHUYN0mpEKr0Q4wEzKsG/lPWjvRo
	hrNK9HD/gwOfxtqKR5RTT+fzeCc3kF7b60PH2juBkrdzKf1Jj0QhnPrWBPzN52Q4sKgzD5
	ZChQvsAGOWBj3cbBZ0xhr2namS+WHXM=
Date: Wed, 24 Apr 2024 21:28:29 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] kmemleak in rdma_core observed during blktests
 nvme/rdma use siw
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Hi,

On 4/8/24 14:03, Yi Zhang wrote:
> Hi
> I found the below kmemleak issue during blktests nvme/rdma on the
> latest linux-rdma/for-next, please help check it and let me know if
> you need any info/testing for it, thanks.

Could you share which test case caused the issue? I can't reproduce
it with 6.9-rc3+ kernel (commit 586b5dfb51b) with the below.

use_siw=1 nvme_trtype=rdma ./check nvme/

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
>    comm "rdma", pid 10630, jiffies 4296575922
>    hex dump (first 32 bytes):
>      37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
>      10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
>    backtrace (crc 47f66721):
>      [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
>      [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
>      [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]

I guess add_modify_gid is called from config_non_roce_gid_cache, not sure
why we don't check the return value of it here.

Looks put_gid_entry is called in case add_modify_gid returns failure, it 
would
trigger schedule_free_gid -> queue_work(ib_wq, &entry->del_work), then
free_gid_work -> free_gid_entry_locked would free storage asynchronously by
put_gid_ndev and also entry.

>      [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
>      [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
>      [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
>      [<ffffffffc2a3d389>] 0xffffffffc2a3d389
>      [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
>      [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
>      [<ffffffffc264648c>]
> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
>      [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
>      [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
>      [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
>      [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
>      [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
>      [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79

After ib_cache_setup_one failed, maybe ib_cache_cleanup_one is needed
which flush ib_wq to ensure storage is freed. Could you try with the change?

--- a/drivers/infiniband/core/device.c
+++ b/drivers/infiniband/core/device.c
@@ -1388,7 +1388,7 @@ int ib_register_device(struct ib_device *device, 
const char *name,
         if (ret) {
                 dev_warn(&device->dev,
                          "Couldn't set up InfiniBand P_Key/GID cache\n");
-               return ret;
+               goto cache_cleanup;
         }

Thanks,
Guoqing

