Return-Path: <linux-rdma+bounces-2128-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B2118B4940
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Apr 2024 04:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D432B1F2189D
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Apr 2024 02:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2392515C9;
	Sun, 28 Apr 2024 02:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KLdj11/U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06B615C3
	for <linux-rdma@vger.kernel.org>; Sun, 28 Apr 2024 02:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714272858; cv=none; b=lRkDLeSNkn0PdQnocvhIdm2jpLlUXfgfIZ8g9plMm7PkmMozXZ8dyqemeeQWhcms6Zl0gEHddgzBxBdNaSlcAta13xn+Mvj1I/93KToeiyVPizIKLOXRHQkaf8va02YJllH6ihKjggpBgWObNKP5Wg1oI9XBaBgTFFZWaT5R8ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714272858; c=relaxed/simple;
	bh=8uZwmiaUi/c0yuAzmJeW5vDrc1VL4MYJMyMhtWgJN+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dlSHRXy0uv7TdAhu0bCOAGLV0tH7UkxL1B/SpEFkJ1pQBwG9/Scmfj1QdzHo6tIGgbUTSsCpCkdZo2SdL/A2/jvev1YHJMTBlkwDVap8Foj7IdnzH63LYmxKGhPyvubuj3INjPKhHQmwU0JwSxeHbKOTp/dQuR9bOWmCf3QrL44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KLdj11/U; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c9e68631-0e60-578d-e88d-23e1f9d8eb2f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714272853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OIX6OsC67SXTXYg4U1d5gflHeGQDSBe6JH0drIMk/iU=;
	b=KLdj11/URHLL5BN1UaR/U/4TcoDdPy9tx4shUlgYg+/0qgGntHR+FWdviNTOrGkOFByU2N
	rHcZt3NORsTalEtjt2qC+FtltQdomFVlArqOd1aIVba6rAKAyaevhQhhhyOMjvqatg+iyg
	O4+9h/jPMxhaybpo2hzL+NXH1gojUf0=
Date: Sun, 28 Apr 2024 10:54:06 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [bug report] kmemleak in rdma_core observed during blktests
 nvme/rdma use siw
To: Yi Zhang <yi.zhang@redhat.com>
Cc: RDMA mailing list <linux-rdma@vger.kernel.org>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Jason Gunthorpe <jgg@nvidia.com>, leonro@nvidia.com
References: <CAHj4cs9uQduBHjcsmOGHa8RaNGNMw8k8bBhZdGgdeEKPFeB8qQ@mail.gmail.com>
 <7de9793f-6805-1412-3fae-a5508910124b@linux.dev>
 <CAHj4cs-RiZXAdz131ihQ=wsW8nsViphJeHAD_i6qi7_DtW7NwQ@mail.gmail.com>
 <CAHj4cs-HWjMq__89RR1WwLcOa5H46H8+d2t=jj=qFJ_m5kRwFQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Guoqing Jiang <guoqing.jiang@linux.dev>
In-Reply-To: <CAHj4cs-HWjMq__89RR1WwLcOa5H46H8+d2t=jj=qFJ_m5kRwFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT



On 4/26/24 16:44, Yi Zhang wrote:
> On Fri, Apr 26, 2024 at 1:56 PM Yi Zhang <yi.zhang@redhat.com> wrote:
>> On Wed, Apr 24, 2024 at 9:28 PM Guoqing Jiang <guoqing.jiang@linux.dev> wrote:
>>> Hi,
>>>
>>> On 4/8/24 14:03, Yi Zhang wrote:
>>>> Hi
>>>> I found the below kmemleak issue during blktests nvme/rdma on the
>>>> latest linux-rdma/for-next, please help check it and let me know if
>>>> you need any info/testing for it, thanks.
>>> Could you share which test case caused the issue? I can't reproduce
>>> it with 6.9-rc3+ kernel (commit 586b5dfb51b) with the below.
>> It can be reproduced by [1], you can find more info from the symbol
>> info[2], I also attached the config file, maybe you can this config
>> file
> Just attached the config file
>

I tried with the config, but still unlucky.

# nvme_trtype=rdma ./check nvme/012
nvme/012 (run mkfs and data verification fio job on NVMeOF block 
device-backed ns)
nvme/012 (run mkfs and data verification fio job on NVMeOF block 
device-backed ns) [passed]
     runtime  52.763s  ...  392.027s device: nvme0

>> [1] nvme_trtype=rdma ./check nvme/012
>> [2]
>> unreferenced object 0xffff8883a87e8800 (size 192):
>>    comm "rdma", pid 2355, jiffies 4294836069
>>    hex dump (first 32 bytes):
>>      32 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  2...............
>>      10 88 7e a8 83 88 ff ff 10 88 7e a8 83 88 ff ff  ..~.......~.....
>>    backtrace (crc 4db191c4):
>>      [<ffffffff8cd251bd>] kmalloc_trace+0x30d/0x3b0
>>      [<ffffffffc207eff7>] alloc_gid_entry+0x47/0x380 [ib_core]
>>      [<ffffffffc2080206>] add_modify_gid+0x166/0x930 [ib_core]
>>      [<ffffffffc2081468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
>>      [<ffffffffc2082e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
>>      [<ffffffffc207749e>] ib_register_device+0x9e/0x3a0 [ib_core]
>>      [<ffffffffc24ac389>] 0xffffffffc24ac389
>>      [<ffffffffc20c6cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
>>      [<ffffffffc2083fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
>>      [<ffffffffc208448c>]
>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
>>      [<ffffffff8e30e715>] netlink_unicast+0x445/0x710
>>      [<ffffffff8e30f151>] netlink_sendmsg+0x761/0xc40
>>      [<ffffffff8e09da89>] __sys_sendto+0x3a9/0x420
>>      [<ffffffff8e09dbec>] __x64_sys_sendto+0xdc/0x1b0
>>      [<ffffffff8e9afad3>] do_syscall_64+0x93/0x180
>>      [<ffffffff8ea00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79
>>
>> (gdb) l *(alloc_gid_entry+0x47)
>> 0x2eff7 is in alloc_gid_entry (./include/linux/slab.h:628).
>> 623
>> 624 if (size > KMALLOC_MAX_CACHE_SIZE)
>> 625 return kmalloc_large(size, flags);
>> 626
>> 627 index = kmalloc_index(size);
>> 628 return kmalloc_trace(
>> 629 kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
>> 630 flags, size);
>> 631 }
>> 632 return __kmalloc(size, flags);
>>
>> (gdb) l *(add_modify_gid+0x166)
>> 0x30206 is in add_modify_gid (drivers/infiniband/core/cache.c:447).
>> 442 * empty table entries instead of storing them.
>> 443 */
>> 444 if (rdma_is_zero_gid(&attr->gid))
>> 445 return 0;
>> 446
>> 447 entry = alloc_gid_entry(attr);
>> 448 if (!entry)
>> 449 return -ENOMEM;
>> 450
>> 451 if (rdma_protocol_roce(attr->device, attr->port_num)) {
>>
>>
>>> use_siw=1 nvme_trtype=rdma ./check nvme/
>>>
>>>> # dmesg | grep kmemleak
>>>> [   67.130652] kmemleak: Kernel memory leak detector initialized (mem
>>>> pool available: 36041)
>>>> [   67.130728] kmemleak: Automatic memory scanning thread started
>>>> [ 1051.771867] kmemleak: 2 new suspected memory leaks (see
>>>> /sys/kernel/debug/kmemleak)
>>>> [ 1832.796189] kmemleak: 8 new suspected memory leaks (see
>>>> /sys/kernel/debug/kmemleak)
>>>> [ 2578.189075] kmemleak: 17 new suspected memory leaks (see
>>>> /sys/kernel/debug/kmemleak)
>>>> [ 3330.710984] kmemleak: 4 new suspected memory leaks (see
>>>> /sys/kernel/debug/kmemleak)
>>>>
>>>> unreferenced object 0xffff88855da53400 (size 192):
>>>>     comm "rdma", pid 10630, jiffies 4296575922
>>>>     hex dump (first 32 bytes):
>>>>       37 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  7...............
>>>>       10 34 a5 5d 85 88 ff ff 10 34 a5 5d 85 88 ff ff  .4.].....4.]....
>>>>     backtrace (crc 47f66721):
>>>>       [<ffffffff911251bd>] kmalloc_trace+0x30d/0x3b0
>>>>       [<ffffffffc2640ff7>] alloc_gid_entry+0x47/0x380 [ib_core]
>>>>       [<ffffffffc2642206>] add_modify_gid+0x166/0x930 [ib_core]
>>> I guess add_modify_gid is called from config_non_roce_gid_cache, not sure
>>> why we don't check the return value of it here.
>>>
>>> Looks put_gid_entry is called in case add_modify_gid returns failure, it
>>> would
>>> trigger schedule_free_gid -> queue_work(ib_wq, &entry->del_work), then
>>> free_gid_work -> free_gid_entry_locked would free storage asynchronously by
>>> put_gid_ndev and also entry.
>>>
>>>>       [<ffffffffc2643468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
>>>>       [<ffffffffc2644e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
>>>>       [<ffffffffc263949e>] ib_register_device+0x9e/0x3a0 [ib_core]
>>>>       [<ffffffffc2a3d389>] 0xffffffffc2a3d389
>>>>       [<ffffffffc2688cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
>>>>       [<ffffffffc2645fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
>>>>       [<ffffffffc264648c>]
>>>> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
>>>>       [<ffffffff9270e7b5>] netlink_unicast+0x445/0x710
>>>>       [<ffffffff9270f1f1>] netlink_sendmsg+0x761/0xc40
>>>>       [<ffffffff9249db29>] __sys_sendto+0x3a9/0x420
>>>>       [<ffffffff9249dc8c>] __x64_sys_sendto+0xdc/0x1b0
>>>>       [<ffffffff92db0ad3>] do_syscall_64+0x93/0x180
>>>>       [<ffffffff92e00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79
>>> After ib_cache_setup_one failed, maybe ib_cache_cleanup_one is needed
>>> which flush ib_wq to ensure storage is freed. Could you try with the change?
>> Will try it later.
>>
> The kmemleak still can be reproduced with this change:
>
> unreferenced object 0xffff8881f89fde00 (size 192):
>    comm "rdma", pid 8708, jiffies 4295703453
>    hex dump (first 32 bytes):
>      02 00 00 00 00 00 00 00 c0 ff ff ff 1f 00 00 00  ................
>      10 de 9f f8 81 88 ff ff 10 de 9f f8 81 88 ff ff  ................
>    backtrace (crc 888c494b):
>      [<ffffffffa7d251bd>] kmalloc_trace+0x30d/0x3b0
>      [<ffffffffc1efeff7>] alloc_gid_entry+0x47/0x380 [ib_core]
>      [<ffffffffc1f00206>] add_modify_gid+0x166/0x930 [ib_core]
>      [<ffffffffc1f01468>] ib_cache_update.part.0+0x6d8/0x910 [ib_core]
>      [<ffffffffc1f02e1a>] ib_cache_setup_one+0x24a/0x350 [ib_core]
>      [<ffffffffc1ef749e>] ib_register_device+0x9e/0x3a0 [ib_core]
>      [<ffffffffc22ee389>]
> siw_qp_state_to_ib_qp_state+0x28a9/0xfffffffffffd1520 [siw]

Is it possible to run the test with rxe instead of siw? In case it is 
only happened
with siw, I'd suggest to revert 0b988c1bee28 to check if it causes the 
issue.
But I don't understand why siw_qp_state_to_ib_qp_state was appeared in the
middle of above trace.

>      [<ffffffffc1f46cd8>] nldev_newlink+0x2b8/0x520 [ib_core]
>      [<ffffffffc1f03fe3>] rdma_nl_rcv_msg+0x2c3/0x520 [ib_core]
>      [<ffffffffc1f0448c>]
> rdma_nl_rcv_skb.constprop.0.isra.0+0x23c/0x3a0 [ib_core]
>      [<ffffffffa930e715>] netlink_unicast+0x445/0x710
>      [<ffffffffa930f151>] netlink_sendmsg+0x761/0xc40
>      [<ffffffffa909da89>] __sys_sendto+0x3a9/0x420
>      [<ffffffffa909dbec>] __x64_sys_sendto+0xdc/0x1b0
>      [<ffffffffa99afad3>] do_syscall_64+0x93/0x180
>      [<ffffffffa9a00126>] entry_SYSCALL_64_after_hwframe+0x71/0x79

Thanks,
Guoqing

