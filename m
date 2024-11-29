Return-Path: <linux-rdma+bounces-6159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9449DC233
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 11:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B1EF282198
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Nov 2024 10:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9486189BB0;
	Fri, 29 Nov 2024 10:36:29 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D51BC155345
	for <linux-rdma@vger.kernel.org>; Fri, 29 Nov 2024 10:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732876589; cv=none; b=htHhM5HJWYTTcbERWmewvtiNWTOoEJJR5IArHjA9/iPJIqhXvTU3+Ivm1KEqbkhN197S+PKNWc5COpxzCkb+30TbDkOQWA7b+6w2bJS7qOeeDMBOSFeR01I5l8qSJo9ol7vK1uJ6tVziccyaU7VL51ao88lD8X06EHaqb+6zMnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732876589; c=relaxed/simple;
	bh=+pLa2bua1duRGrBM/9HvrC+egix09o5q9XlEsPCS88Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ffCMpWFXvOgjp6qkJXn95Y07wNGK3/Yrk3M9TTWxQ7MMjMahmH9iAXZL0jQPtTPT6LGkV4EG9EsmXsJpYPgSiR9PA0AU7wiCfJre17RJjJVFlofv+LiJoza8TsoyRHTdx/iF5yySXkZJAqLwH0clt/krOIbDG4lt4mN2mXfe09w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6084370c-e870-4c1d-af1c-f8a27f234ddd@linux.dev>
Date: Fri, 29 Nov 2024 11:36:16 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 siw_query_port (2)
To: Bernard Metzler <BMT@zurich.ibm.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
 "leon@kernel.org" <leon@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc: "zyjzyj2000@gmail.com" <zyjzyj2000@gmail.com>
References: <6746eaef.050a0220.21d33d.0021.GAE@google.com>
 <BN8PR15MB251331ECA48AD10C366BFCF199282@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <BN8PR15MB251331ECA48AD10C366BFCF199282@BN8PR15MB2513.namprd15.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 27.11.24 13:57, Bernard Metzler wrote:
> 
> 
>> -----Original Message-----
>> From: syzbot <syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com>
>> Sent: Wednesday, November 27, 2024 10:49 AM
>> To: Bernard Metzler <BMT@zurich.ibm.com>; jgg@ziepe.ca; leon@kernel.org;
>> linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
>> netdev@vger.kernel.org; syzkaller-bugs@googlegroups.com
>> Subject: [EXTERNAL] [syzbot] [rdma?] KASAN: slab-use-after-free Read in
>> siw_query_port (2)
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    5d066766c5f1 net/l2tp: fix warning in l2tp_exit_net found
>> ..
>> git tree:       net
>> console output: https%
>> 3A__syzkaller.appspot.com_x_log.txt-3Fx-
>> 3D168e8dc0580000&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4t
>> YSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx
>> 17mPmc2wtJaU4&s=6au3yUVQofLXZAr8nH0sfWV1MtQx2Z16Nk9rsXOeVFs&e=
>> kernel config:  https%
>> 3A__syzkaller.appspot.com_x_.config-3Fx-
>> 3D83e9a7f9e94ea674&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE
>> 4tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyy
>> Hx17mPmc2wtJaU4&s=n9aCEUutAWKdDNujKIupw82TQQSlr_TZcMgisng0Xus&e=
>> dashboard link: https%
>> 3A__syzkaller.appspot.com_bug-3Fextid-
>> 3D67a887427af54ecb7c93&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbh
>> vovE4tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vF
>> sIyyHx17mPmc2wtJaU4&s=7f-Omz7ps-pKM3jhyCcKlwMASxX_kB_Sd_pAF-Jvpxg&e=
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
>> Debian) 2.40
>> syz repro:      https%
>> 3A__syzkaller.appspot.com_x_repro.syz-3Fx-
>> 3D11355530580000&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4t
>> YSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx
>> 17mPmc2wtJaU4&s=fZra1eeMYqeDiaYg5CltF9l2fz28wKtU-yI_jEtubGg&e=
>>
>> Downloadable assets:
>> disk image: https%
>> 3A__storage.googleapis.com_syzbot-2Dassets_ba9b7c97759c_disk-
>> 2D5d066766.raw.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4
>> tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyH
>> x17mPmc2wtJaU4&s=4ypBicdKG1ksPIkOu2OLcppS8J0vPN08wFzXHtyvNEE&e=
>> vmlinux: https%
>> 3A__storage.googleapis.com_syzbot-2Dassets_92a30584a5ad_vmlinux-
>> 2D5d066766.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSb
>> qxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17m
>> Pmc2wtJaU4&s=YyIgS6-_sljSEl3L1KN4bsGRpSJUuXDDkf1lrONXgNE&e=
>> kernel image: https%
>> 3A__storage.googleapis.com_syzbot-2Dassets_88d717deaf07_bzImage-
>> 2D5d066766.xz&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSb
>> qxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17m
>> Pmc2wtJaU4&s=hNlNLIJQasRBAom2wakJesBp-oiI9FnXezvbtTzPW34&e=
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the
>> commit:
>> Reported-by: syzbot+67a887427af54ecb7c93@syzkaller.appspotmail.com
>>
>> xfrm0 speed is unknown, defaulting to 1000
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in siw_query_port+0x348/0x440
>> drivers/infiniband/sw/siw/siw_verbs.c:183
>> Read of size 4 at addr ffff88802ff88038 by task kworker/0:5/5883
>>
>> CPU: 0 UID: 0 PID: 5883 Comm: kworker/0:5 Not tainted 6.12.0-syzkaller-
>> 05491-g5d066766c5f1 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
>> Google 09/13/2024
>> Workqueue: infiniband ib_cache_event_task
>> Call Trace:
>>   <TASK>
>>   __dump_stack lib/dump_stack.c:94 [inline]
>>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>>   print_address_description mm/kasan/report.c:377 [inline]
>>   print_report+0x169/0x550 mm/kasan/report.c:488
>>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>>   siw_query_port+0x348/0x440 drivers/infiniband/sw/siw/siw_verbs.c:183
>>   ib_cache_update+0x1a9/0xb80 drivers/infiniband/core/cache.c:1494
>>   ib_cache_event_task+0xf3/0x1e0 drivers/infiniband/core/cache.c:1568
>>   process_one_work kernel/workqueue.c:3229 [inline]
>>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>>   kthread+0x2f0/0x390 kernel/kthread.c:389
>>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>   </TASK>
>>
> 
> Here siw is getting a use-after-free when accessing the netdev in
> query_port() verb, since the netdev got free'd already. I was
> assuming the rdma core would serialize device deallocation
> and driver access accordingly. Seems not to be the case?
> 
> Looking at somewhat similar rxe driver, I see a mutex protecting
> netdev access in rxe_query_port() - 'rxe->usdev_lock'. That
> mutex is used only right there and I don't see how it is useful.
> @Zhu, was it intended to serialize netdev access?

Hi, Leon && Bernard

rxe->usdev_lock is initialized in the function "static void 
rxe_init(struct rxe_dev *rxe)",

and it is destroyed in the function "void rxe_dealloc(struct ib_device 
*ib_dev)".

This mutext lock is used in the function "static int 
rxe_query_port(struct ib_device *ibdev,
               u32 port_num, struct ib_port_attr *attr)
".

As such, it is difficult for this mutex lock to intend to serialize 
netdev access.

To this problem, I delved into the logs in the link 
https://syzkaller.appspot.com/x/log.txt?x=168e8dc0580000.

 From the bug report 
https://lore.kernel.org/netdev/6746eaef.050a0220.21d33d.0021.GAE@google.com/T/, 


"Allocated by task 10564:",

it means that siw link was created by task 10564.

But in the onsole output: 
https://syzkaller.appspot.com/x/log.txt?x=168e8dc0580000, the followings 
appeared.

"
[  172.868389][T10564] netdevsim netdevsim0 netdevsim3: set [1, 0] type 
2 family 0 port 6081 - 0                                      < ----- 
Task 10564 will create a siw link?
2024/11/26 23:11:55 executed programs: 4202
[  172.915059][ T3456] wlan0: Created IBSS using preconfigured BSSID 
50:50:50:50:50:50
[  172.926680][ T3456] wlan0: Creating new IBSS network, BSSID 
50:50:50:50:50:50
[  172.946967][ T3456] wlan1: Created IBSS using preconfigured BSSID 
50:50:50:50:50:50
[  172.954941][ T3456] wlan1: Creating new IBSS network, BSSID 
50:50:50:50:50:50
[  172.988844][T10604] xfrm0 speed is unknown, defaulting to 1000
[  172.995474][T10604] xfrm0 speed is unknown, defaulting to 1000
[  173.001453][T10604] FAULT_INJECTION: forcing a failure.
[  173.001453][T10604] name failslab, interval 1, probability 0, space 
0, times 0
[  173.015026][T10604] CPU: 1 UID: 0 PID: 10604 Comm: syz.0.4215 Not 
tainted 6.12.0-syzkaller-05491-g5d066766c5f1 #0
[  173.025487][T10604] Hardware name: Google Google Compute 
Engine/Google Compute Engine, BIOS Google 09/13/2024
[  173.035551][T10604] Call Trace:
[  173.038829][T10604]  <TASK>
[  173.041761][T10604]  dump_stack_lvl+0x241/0x360
[  173.046441][T10604]  ? __pfx_dump_stack_lvl+0x10/0x10
[  173.051633][T10604]  ? __pfx__printk+0x10/0x10
[  173.056214][T10604]  ? __kmalloc_cache_noprof+0x44/0x2c0
[  173.061666][T10604]  ? __pfx___might_resched+0x10/0x10
[  173.066947][T10604]  should_fail_ex+0x3b0/0x4e0
[  173.071617][T10604]  should_failslab+0xac/0x100
[  173.076299][T10604]  ? add_modify_gid+0x176/0xba0
[  173.081142][T10604]  __kmalloc_cache_noprof+0x6c/0x2c0
[  173.086427][T10604]  add_modify_gid+0x176/0xba0
[  173.091096][T10604]  ? _raw_spin_unlock+0x28/0x50
[  173.095941][T10604]  ib_cache_update+0x533/0xb80
[  173.100697][T10604]  ? __pfx_ib_cache_update+0x10/0x10
[  173.105994][T10604]  ? ib_enum_roce_netdev+0x2a1/0x2d0
[  173.111318][T10604]  ? __pfx_pass_all_filter+0x10/0x10
[  173.116606][T10604]  ib_cache_setup_one+0x49c/0x5b0
[  173.121635][T10604]  ib_register_device+0xf7e/0x13e0
[  173.126761][T10604]  ? __pfx_ib_register_device+0x10/0x10
[  173.132311][T10604]  ? xa_load+0x2dd/0x350
[  173.136545][T10604]  ? xa_load+0x147/0x350
[  173.140775][T10604]  ? __asan_memset+0x23/0x50
[  173.145375][T10604]  ? lockdep_init_map_type+0xa1/0x910
[  173.150751][T10604]  ? __pfx_lockdep_init_map_type+0x10/0x10
[  173.156557][T10604]  ? ib_device_set_netdev+0x5b6/0x6b0
[  173.161932][T10604]  ? __raw_spin_lock_init+0x45/0x100
[  173.167219][T10604]  siw_newlink+0x9d9/0xe50 
<---- here it means that siw will be created?
[  173.171627][T10604]  nldev_newlink+0x5c0/0x640
"

As such, from the console log, it seems that task 10564 failed to create 
a siw link.

This should be the root cause of "KASAN: slab-use-after-free Read in 
siw_query_port" ?

Because siw link could not be created successfully, then siw_query_port 
failed?

If I am missing something, please feel free to let me know.

Zhu Yanjun

> 
> Many thanks,
> Bernard.
> 
>> Allocated by task 10564:
>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>   poison_kmalloc_redzone mm/kasan/common.c:377 [inline]
>>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:394
>>   kasan_kmalloc include/linux/kasan.h:257 [inline]
>>   __do_kmalloc_node mm/slub.c:4264 [inline]
>>   __kmalloc_node_noprof+0x22a/0x440 mm/slub.c:4270
>>   __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>>   alloc_netdev_mqs+0xa4/0x1080 net/core/dev.c:11203
>>   rtnl_create_link+0x2f9/0xc20 net/core/rtnetlink.c:3595
>>   rtnl_newlink_create+0x210/0xa30 net/core/rtnetlink.c:3770
>>   __rtnl_newlink net/core/rtnetlink.c:3897 [inline]
>>   rtnl_newlink+0x17dd/0x24f0 net/core/rtnetlink.c:4007
>>   rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6917
>>   netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
>>   netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
>>   netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
>>   netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
>>   sock_sendmsg_nosec net/socket.c:711 [inline]
>>   __sock_sendmsg+0x221/0x270 net/socket.c:726
>>   __sys_sendto+0x363/0x4c0 net/socket.c:2197
>>   __do_sys_sendto net/socket.c:2204 [inline]
>>   __se_sys_sendto net/socket.c:2200 [inline]
>>   __x64_sys_sendto+0xde/0x100 net/socket.c:2200
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Freed by task 35:
>>   kasan_save_stack mm/kasan/common.c:47 [inline]
>>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
>>   poison_slab_object mm/kasan/common.c:247 [inline]
>>   __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
>>   kasan_slab_free include/linux/kasan.h:230 [inline]
>>   slab_free_hook mm/slub.c:2342 [inline]
>>   slab_free mm/slub.c:4579 [inline]
>>   kfree+0x1a0/0x440 mm/slub.c:4727
>>   device_release+0x99/0x1c0
>>   kobject_cleanup lib/kobject.c:689 [inline]
>>   kobject_release lib/kobject.c:720 [inline]
>>   kref_put include/linux/kref.h:65 [inline]
>>   kobject_put+0x22f/0x480 lib/kobject.c:737
>>   netdev_run_todo+0xe79/0x1000 net/core/dev.c:10918
>>   cleanup_net+0x762/0xcc0 net/core/net_namespace.c:628
>>   process_one_work kernel/workqueue.c:3229 [inline]
>>   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>>   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>>   kthread+0x2f0/0x390 kernel/kthread.c:389
>>   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>
>> The buggy address belongs to the object at ffff88802ff88000
>>   which belongs to the cache kmalloc-cg-4k of size 4096
>> The buggy address is located 56 bytes inside of
>>   freed 4096-byte region [ffff88802ff88000, ffff88802ff89000)
>>
>> The buggy address belongs to the physical page:
>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2ff88
>> head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
>> memcg:ffff888031975541
>> flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
>> page_type: f5(slab)
>> raw: 00fff00000000040 ffff88801b04f500 ffffea0001f8f800 dead000000000002
>> raw: 0000000000000000 0000000000040004 00000001f5000000 ffff888031975541
>> head: 00fff00000000040 ffff88801b04f500 ffffea0001f8f800 dead000000000002
>> head: 0000000000000000 0000000000040004 00000001f5000000 ffff888031975541
>> head: 00fff00000000003 ffffea0000bfe201 ffffffffffffffff 0000000000000000
>> head: 0000000000000008 0000000000000000 00000000ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>> page_owner tracks the page as allocated
>> page last allocated via order 3, migratetype Unmovable, gfp_mask
>> 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEM
>> ALLOC), pid 7294, tgid 7294 (udevd), ts 104300491113, free_ts 104288279948
>>   set_page_owner include/linux/page_owner.h:32 [inline]
>>   post_alloc_hook+0x1f3/0x230 mm/page_alloc.c:1556
>>   prep_new_page mm/page_alloc.c:1564 [inline]
>>   get_page_from_freelist+0x3649/0x3790 mm/page_alloc.c:3474
>>   __alloc_pages_noprof+0x292/0x710 mm/page_alloc.c:4751
>>   alloc_pages_mpol_noprof+0x3e8/0x680 mm/mempolicy.c:2265
>>   alloc_slab_page+0x6a/0x140 mm/slub.c:2412
>>   allocate_slab+0x5a/0x2f0 mm/slub.c:2578
>>   new_slab mm/slub.c:2631 [inline]
>>   ___slab_alloc+0xcd1/0x14b0 mm/slub.c:3818
>>   __slab_alloc+0x58/0xa0 mm/slub.c:3908
>>   __slab_alloc_node mm/slub.c:3961 [inline]
>>   slab_alloc_node mm/slub.c:4122 [inline]
>>   __do_kmalloc_node mm/slub.c:4263 [inline]
>>   __kmalloc_node_noprof+0x286/0x440 mm/slub.c:4270
>>   __kvmalloc_node_noprof+0x72/0x190 mm/util.c:658
>>   seq_buf_alloc fs/seq_file.c:38 [inline]
>>   seq_read_iter+0x20c/0xd70 fs/seq_file.c:210
>>   new_sync_read fs/read_write.c:484 [inline]
>>   vfs_read+0x991/0xb70 fs/read_write.c:565
>>   ksys_read+0x18f/0x2b0 fs/read_write.c:708
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>> page last free pid 7342 tgid 7342 stack trace:
>>   reset_page_owner include/linux/page_owner.h:25 [inline]
>>   free_pages_prepare mm/page_alloc.c:1127 [inline]
>>   free_unref_page+0xdf9/0x1140 mm/page_alloc.c:2657
>>   discard_slab mm/slub.c:2677 [inline]
>>   __put_partials+0xeb/0x130 mm/slub.c:3145
>>   put_cpu_partial+0x17c/0x250 mm/slub.c:3220
>>   __slab_free+0x2ea/0x3d0 mm/slub.c:4449
>>   qlink_free mm/kasan/quarantine.c:163 [inline]
>>   qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
>>   kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
>>   __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
>>   kasan_slab_alloc include/linux/kasan.h:247 [inline]
>>   slab_post_alloc_hook mm/slub.c:4085 [inline]
>>   slab_alloc_node mm/slub.c:4134 [inline]
>>   kmem_cache_alloc_lru_noprof+0x139/0x2b0 mm/slub.c:4153
>>   sock_alloc_inode+0x28/0xc0 net/socket.c:307
>>   alloc_inode+0x65/0x1a0 fs/inode.c:336
>>   sock_alloc net/socket.c:615 [inline]
>>   __sock_create+0x127/0xa30 net/socket.c:1522
>>   sock_create net/socket.c:1616 [inline]
>>   __sys_socket_create net/socket.c:1653 [inline]
>>   __sys_socket+0x150/0x3c0 net/socket.c:1700
>>   __do_sys_socket net/socket.c:1714 [inline]
>>   __se_sys_socket net/socket.c:1712 [inline]
>>   __x64_sys_socket+0x7a/0x90 net/socket.c:1712
>>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>
>> Memory state around the buggy address:
>>   ffff88802ff87f00: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff88802ff87f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>> ffff88802ff88000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                                          ^
>>   ffff88802ff88080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   ffff88802ff88100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https%
>> 3A__goo.gl_tpsmEJ&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4
>> tYSbqxyOwdSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyH
>> x17mPmc2wtJaU4&s=IN3iayLHmzULE2aCAPu4KTVSnPNVh7pCMpPelU3ttrw&e=  for more
>> information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ%
>> 23status&d=DwIBaQ&c=BSDicqBQBDjDI9RkVyTcHQ&r=4ynb4Sj_4MUcZXbhvovE4tYSbqxyOw
>> dSiLedP4yO55g&m=m3O6vMc9WMuoczjDeT5i4qksFSps2rP3_ATMJw2E343vFsIyyHx17mPmc2w
>> tJaU4&s=8ZTBWQFsMGIjFpf_f8tEpszCYanWYyZkGLEEV4YofhU&e=  for how to
>> communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want syzbot to run the reproducer, reply with:
>> #syz test: git://repo/address.git branch-or-commit-hash
>> If you attach or paste a git patch, syzbot will apply it before testing.
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup


