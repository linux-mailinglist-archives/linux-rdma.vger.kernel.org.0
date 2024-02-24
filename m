Return-Path: <linux-rdma+bounces-1124-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAF986223B
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Feb 2024 03:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1FD61F24155
	for <lists+linux-rdma@lfdr.de>; Sat, 24 Feb 2024 02:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3BCDF67;
	Sat, 24 Feb 2024 02:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Q0OWtO4U"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C41DF59
	for <linux-rdma@vger.kernel.org>; Sat, 24 Feb 2024 02:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708740794; cv=none; b=XEGlMq9XSOY/J5B50GRA0ddDaH2GYaB0NRksI29jcrUXynfnAKO7/CwGQbcYkuAMBcmJC+jA56Mkztx9ws9qmOMF/9Tw1srud6pZ0P6Dia7sk9BxheNp4BPuSQKIxjikgJoYIJXkJy0mF+GmLXuVg6gD1JZc3fPIZw4wOUplrUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708740794; c=relaxed/simple;
	bh=PIyfvj1SsIDXcZamZhefCaptklQTGgjWI3oKGtcoWtw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=FhPdaSfIHVnOH2s0E2SK/xbMo7fqwP6RyMPsz91E3XplPi65cfN5Iov5Omw25mYR1p4M8wwV0qz2DyOA5pBzhsPCNH9tASbHT78d9RfpEGMqHOl6ugMq9RFYEq3sq1zrfAZkjVtzjnsEVTQyg3mce+Pd4ExbSmD1yQc4EK0K6Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Q0OWtO4U; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c1161f13-0356-4b09-aa1f-8e2ad8c8dccf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708740789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YfUxlztpGoN9TRoWp7gbNs0j/1jZiH0M4hoaH6m3hs=;
	b=Q0OWtO4UWFqVX37W1df9VLD4ST67bb7Ce5Yi5BAC86Iz2oNrCsouveITrZgNmpvf/sVNzd
	V/EIcBjJhZEMfqYBDa/LjxWMX6E34Hih0TqJ1ma3/B9/fDHbrvrJqYjilvViOjl7meeydE
	H2pH9jg2u8jB6Tgk0dWYzGGC2UZloug=
Date: Sat, 24 Feb 2024 10:12:46 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma?] KASAN: slab-use-after-free Read in
 rdma_resolve_route
To: syzbot <syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com>,
 jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 syzkaller-bugs@googlegroups.com
References: <000000000000f3f42f06120a5679@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <000000000000f3f42f06120a5679@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2024/2/23 18:51, syzbot 写道:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    2c3b09aac00d Add linux-next specific files for 20240214
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=1793a064180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=176d2dcbf8ba7017
> dashboard link: https://syzkaller.appspot.com/bug?extid=a2e2735f09ebb9d95bd1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ac51042b61c6/disk-2c3b09aa.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/012344301c35/vmlinux-2c3b09aa.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/cba3c3e5cd7c/bzImage-2c3b09aa.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+a2e2735f09ebb9d95bd1@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-use-after-free in compare_netdev_and_ip drivers/infiniband/core/cma.c:473 [inline]
> BUG: KASAN: slab-use-after-free in cma_add_id_to_tree drivers/infiniband/core/cma.c:513 [inline]
> BUG: KASAN: slab-use-after-free in rdma_resolve_route+0x23f7/0x3150 drivers/infiniband/core/cma.c:3379
> Read of size 4 at addr ffff88808dcf6184 by task syz-executor.4/11929

I delved into the source code (cma.c), it seems that the spinlock 
id_table_lock protects id_priv as below when id_priv is used:

  468 static int compare_netdev_and_ip(int ifindex_a, struct sockaddr *sa,
  469                                  struct id_table_entry *entry_b)
  470 {
  471         struct rdma_id_private *id_priv = list_first_entry(
  472                 &entry_b->id_list, struct rdma_id_private, 
id_list_entry);
  473         int ifindex_b = id_priv->id.route.addr.dev_addr.bound_dev_if;
  474         struct sockaddr *sb = cma_dst_addr(id_priv);

But when id_priv is freed. No id_table_lock is used to protect id_priv 
as below.

2067 static void destroy_id_handler_unlock(struct rdma_id_private *id_priv)
2068         __releases(&idprv->handler_mutex)
2069 {
2070         enum rdma_cm_state state;
2071         unsigned long flags;
2072
2073         trace_cm_id_destroy(id_priv);
2074
2075         /*
2076          * Setting the state to destroyed under the handler mutex 
provides a
2077          * fence against calling handler callbacks. If this is 
invoked due to
2078          * the failure of a handler callback then it guarentees 
that no future
2079          * handlers will be called.
2080          */
2081         lockdep_assert_held(&id_priv->handler_mutex);
2082         spin_lock_irqsave(&id_priv->lock, flags);
2083         state = id_priv->state;
2084         id_priv->state = RDMA_CM_DESTROYING;
2085         spin_unlock_irqrestore(&id_priv->lock, flags);
2086         mutex_unlock(&id_priv->handler_mutex);
2087         _destroy_id(id_priv, state);
2088 }

As such,  This causes id_priv to get out of sync.
So a dirty and quick solution should be:

diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
index 1e2cd7c8716e..5cf034494898 100644
--- a/drivers/infiniband/core/cma.c
+++ b/drivers/infiniband/core/cma.c
@@ -2084,7 +2084,9 @@ static void destroy_id_handler_unlock(struct 
rdma_id_private *id_priv)
         id_priv->state = RDMA_CM_DESTROYING;
         spin_unlock_irqrestore(&id_priv->lock, flags);
         mutex_unlock(&id_priv->handler_mutex);
+       spin_lock_irqsave(&id_table_lock, flags);
         _destroy_id(id_priv, state);
+       spin_unlock_irqrestore(&id_table_lock, flags);
  }

That is, the spinlock id_table_lock is used when id_priv is freed.

And in the function compare_netdev_and_ip, when id_priv is NULL, the 
function compare_netdev_and_ip returns directly.

RDMA stack is big and complicated. This is just my 2 cents. Please 
comment. Thanks a lot.

Zhu Yanjun

> 
> CPU: 1 PID: 11929 Comm: syz-executor.4 Not tainted 6.8.0-rc4-next-20240214-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/25/2024
> Call Trace:
>   <TASK>
>   __dump_stack lib/dump_stack.c:88 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>   print_address_description mm/kasan/report.c:377 [inline]
>   print_report+0x169/0x550 mm/kasan/report.c:488
>   kasan_report+0x143/0x180 mm/kasan/report.c:601
>   compare_netdev_and_ip drivers/infiniband/core/cma.c:473 [inline]
>   cma_add_id_to_tree drivers/infiniband/core/cma.c:513 [inline]
>   rdma_resolve_route+0x23f7/0x3150 drivers/infiniband/core/cma.c:3379
>   ucma_resolve_route+0x1ba/0x330 drivers/infiniband/core/ucma.c:745
>   ucma_write+0x2df/0x430 drivers/infiniband/core/ucma.c:1743
>   vfs_write+0x2a4/0xcb0 fs/read_write.c:588
>   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f4eae47dda9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f4eaf2cd0c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 00007f4eae5abf80 RCX: 00007f4eae47dda9
> RDX: 0000000000000010 RSI: 0000000020000440 RDI: 0000000000000003
> RBP: 00007f4eae4ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f4eae5abf80 R15: 00007fff93bb3dc8
>   </TASK>
> 
> Allocated by task 11919:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
>   __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
>   kasan_kmalloc include/linux/kasan.h:211 [inline]
>   kmalloc_trace+0x1d9/0x360 mm/slub.c:4013
>   kmalloc include/linux/slab.h:590 [inline]
>   kzalloc include/linux/slab.h:711 [inline]
>   __rdma_create_id+0x65/0x590 drivers/infiniband/core/cma.c:993
>   rdma_create_user_id+0x83/0xc0 drivers/infiniband/core/cma.c:1049
>   ucma_create_id+0x2d0/0x500 drivers/infiniband/core/ucma.c:463
>   ucma_write+0x2df/0x430 drivers/infiniband/core/ucma.c:1743
>   vfs_write+0x2a4/0xcb0 fs/read_write.c:588
>   ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> Freed by task 11915:
>   kasan_save_stack mm/kasan/common.c:47 [inline]
>   kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
>   kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:586
>   poison_slab_object+0xa6/0xe0 mm/kasan/common.c:240
>   __kasan_slab_free+0x37/0x60 mm/kasan/common.c:256
>   kasan_slab_free include/linux/kasan.h:184 [inline]
>   slab_free_hook mm/slub.c:2122 [inline]
>   slab_free mm/slub.c:4296 [inline]
>   kfree+0x14a/0x380 mm/slub.c:4406
>   ucma_close_id drivers/infiniband/core/ucma.c:186 [inline]
>   ucma_destroy_private_ctx+0x14e/0xc10 drivers/infiniband/core/ucma.c:578
>   ucma_close+0xfc/0x170 drivers/infiniband/core/ucma.c:1808
>   __fput+0x429/0x8a0 fs/file_table.c:411
>   __do_sys_close fs/open.c:1557 [inline]
>   __se_sys_close fs/open.c:1542 [inline]
>   __x64_sys_close+0x7f/0x110 fs/open.c:1542
>   do_syscall_64+0xfb/0x240
>   entry_SYSCALL_64_after_hwframe+0x6d/0x75
> 
> The buggy address belongs to the object at ffff88808dcf6000
>   which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 388 bytes inside of
>   freed 2048-byte region [ffff88808dcf6000, ffff88808dcf6800)
> 
> The buggy address belongs to the physical page:
> page:ffffea0002373c00 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x8dcf0
> head:ffffea0002373c00 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
> flags: 0xfff80000000840(slab|head|node=0|zone=1|lastcpupid=0xfff)
> page_type: 0xffffffff()
> raw: 00fff80000000840 ffff888014c42000 dead000000000100 dead000000000122
> raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> page_owner tracks the page as allocated
> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5149, tgid 5149 (kworker/1:4), ts 205905084555, free_ts 0
>   set_page_owner include/linux/page_owner.h:31 [inline]
>   post_alloc_hook+0x1ea/0x210 mm/page_alloc.c:1533
>   prep_new_page mm/page_alloc.c:1540 [inline]
>   get_page_from_freelist+0x33ea/0x3580 mm/page_alloc.c:3311
>   __alloc_pages+0x256/0x6a0 mm/page_alloc.c:4567
>   __alloc_pages_node include/linux/gfp.h:238 [inline]
>   alloc_pages_node include/linux/gfp.h:261 [inline]
>   alloc_slab_page+0x5f/0x160 mm/slub.c:2191
>   allocate_slab mm/slub.c:2354 [inline]
>   new_slab+0x84/0x2f0 mm/slub.c:2407
>   ___slab_alloc+0xc73/0x1260 mm/slub.c:3541
>   __slab_alloc mm/slub.c:3626 [inline]
>   __slab_alloc_node mm/slub.c:3679 [inline]
>   slab_alloc_node mm/slub.c:3851 [inline]
>   __do_kmalloc_node mm/slub.c:3981 [inline]
>   __kmalloc_node_track_caller+0x2d4/0x4e0 mm/slub.c:4002
>   kmalloc_reserve+0xf3/0x260 net/core/skbuff.c:582
>   __alloc_skb+0x1b1/0x420 net/core/skbuff.c:651
>   alloc_skb include/linux/skbuff.h:1296 [inline]
>   alloc_skb_with_frags+0xc3/0x780 net/core/skbuff.c:6394
>   sock_alloc_send_pskb+0x91a/0xa60 net/core/sock.c:2794
>   sock_alloc_send_skb include/net/sock.h:1855 [inline]
>   mld_newpack+0x1c3/0xa90 net/ipv6/mcast.c:1746
>   add_grhead net/ipv6/mcast.c:1849 [inline]
>   add_grec+0x1492/0x19a0 net/ipv6/mcast.c:1987
>   mld_send_cr net/ipv6/mcast.c:2113 [inline]
>   mld_ifc_work+0x6bf/0xb30 net/ipv6/mcast.c:2650
>   process_one_work kernel/workqueue.c:3146 [inline]
>   process_scheduled_works+0x9d7/0x1730 kernel/workqueue.c:3226
>   worker_thread+0x86d/0xd70 kernel/workqueue.c:3307
> page_owner free stack trace missing
> 
> Memory state around the buggy address:
>   ffff88808dcf6080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88808dcf6100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ffff88808dcf6180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                     ^
>   ffff88808dcf6200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   ffff88808dcf6280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup


