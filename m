Return-Path: <linux-rdma+bounces-18865-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELpbDKg3zGn7RQYAu9opvQ
	(envelope-from <linux-rdma+bounces-18865-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 23:07:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9B5371605
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 23:07:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65FE23058DC8
	for <lists+linux-rdma@lfdr.de>; Tue, 31 Mar 2026 21:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791CA3624A7;
	Tue, 31 Mar 2026 21:00:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C3C3DFC97
	for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 21:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774990831; cv=none; b=qi+C/cLkdbltsMtJTm4wDtpUMUoV9dpclnF7yox1taTlBFe95gWn6WelPBD2hK87Uko+pdjC5XM3Ai5LxL8ZeIImqylxTCd+Fwu+MzLLRCIsU5Mm+yO19hg5F6aP9sGqDWRyd5BjaMMYbGjl3vdjZXslardn0UDseG2Y4wb7D6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774990831; c=relaxed/simple;
	bh=tzLv5kZG7QR1ZgMCjv0LdURtgzvizp6wWAZAQQ2XCYc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WEbpDtovp1Kf4f7XGjOzI8oziF2WG+9LOgCxQvGs63l0+Atof+G3Iv07hoQp+ok+G61wWGaZ2+q00Y3Rs8iQu5WuZ3tMd+Qyp3NAOq8ADDvrYqoak9cWjIMqfyAnCPgBpKVP37uegByqjQOClchkEkqgzQiufvBV2XjFUERviVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-417120d5378so14085232fac.1
        for <linux-rdma@vger.kernel.org>; Tue, 31 Mar 2026 14:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774990828; x=1775595628;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rnvFCMRJi/h7UJTVkVrgxZTgbofSV+wGA9Mxfglblk=;
        b=o30mXTXde+AfwJWRxfj+DoqGbHWYmj7x3q8+tMd5qlgbyo4y/EJyrvql9Ric69/Hi/
         tOgdtQdtVkpC7QZnTG/W7cr+aIy/dESc4QPnm/O6BZ2O/9IfkP8M8RFUzC9FcQ3Lf061
         AVubX84tAMVYYjQ76d+yfxrYaPTx/iYoabv6uqLleCIZ1egSlEYvhbJn/hi3usJYVaHW
         5iO7N1+AXthM245JBBEm2nDbtR+Wx/nND014eQIcTdU0TJsKpMrbzhOihrTD8+KqnXs9
         fAloN+moHjPVNiBUjwMKx0LuOLEgzP0FPl/JkNTh5o7NI5pwlUBmNJQIEIcyYMPUqG1q
         /TIw==
X-Forwarded-Encrypted: i=1; AJvYcCWzYt1xfq2FdNN8R4RePnWxf3VtPNfBzgsrIm8AFPQFcD2TccqJJdL/xwrQ3+DbTdC1KIG2mAG+7va6@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/Z4OnFS6GteYMkEBA61x4xb49K/HPDaOK3ghRGLy+t1u75/rW
	giUAQL7mazNXB9panO51CeJTIQzmTOdMFcxuSUdRjEYxxksvRcJ4Vs1Ku9GDCaI4TAVuPW19B+F
	XPqZ4QLk77YBDA73OqiXwXqS/CFbg2LufF2lUKUGnYdaYPt0A9OaB+Y3Uywg=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:c83:b0:67e:160c:36c3 with SMTP id
 006d021491bc7-67fabcf20d3mr474752eaf.48.1774990828666; Tue, 31 Mar 2026
 14:00:28 -0700 (PDT)
Date: Tue, 31 Mar 2026 14:00:28 -0700
In-Reply-To: <69cc20ce.050a0220.183828.0033.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69cc35ec.a70a0220.97f31.02a2.GAE@google.com>
Subject: Re: [syzbot] [rdma?] KFENCE: invalid free in gid_table_release_one
From: syzbot <syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com>
To: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	tahernady45@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=e5c508e55e8ef9a7];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18865-lists,linux-rdma=lfdr.de,4334f9a250019c1b79b4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[ziepe.ca,kernel.org,vger.kernel.org,googlegroups.com,gmail.com];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 7D9B5371605
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

syzbot has found a reproducer for the following issue on:

HEAD commit:    36ece9697e89 Add linux-next specific files for 20260331
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10dc99f6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e5c508e55e8ef9a7
dashboard link: https://syzkaller.appspot.com/bug?extid=4334f9a250019c1b79b4
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ebf5da580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1253b3d6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46de62fad824/disk-36ece969.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/88dd71e1e51a/vmlinux-36ece969.xz
kernel image: https://storage.googleapis.com/syzbot-assets/51e7e482e157/bzImage-36ece969.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4334f9a250019c1b79b4@syzkaller.appspotmail.com

smbdirect: ib_dev[syz2] removed
==================================================================
BUG: KASAN: invalid-free in release_gid_table drivers/infiniband/core/cache.c:804 [inline]
BUG: KASAN: invalid-free in gid_table_release_one+0x384/0x470 drivers/infiniband/core/cache.c:877
Free of addr ffff88802bcdb6d8 by task kworker/u8:2/35

CPU: 1 UID: 0 PID: 35 Comm: kworker/u8:2 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: ib-unreg-wq ib_unregister_work
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 print_address_description+0x55/0x1e0 mm/kasan/report.c:378
 print_report+0x58/0x70 mm/kasan/report.c:482
 kasan_report_invalid_free+0xea/0x110 mm/kasan/report.c:557
 check_slab_allocation mm/kasan/common.c:-1 [inline]
 __kasan_slab_pre_free+0x104/0x120 mm/kasan/common.c:261
 kasan_slab_pre_free include/linux/kasan.h:199 [inline]
 slab_free_hook mm/slub.c:2634 [inline]
 slab_free mm/slub.c:6242 [inline]
 kfree+0x173/0x640 mm/slub.c:6557
 release_gid_table drivers/infiniband/core/cache.c:804 [inline]
 gid_table_release_one+0x384/0x470 drivers/infiniband/core/cache.c:877
 ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:482
 device_release+0xc4/0x1f0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x228/0x560 lib/kobject.c:737
 process_one_work kernel/workqueue.c:3278 [inline]
 process_scheduled_works+0xb5d/0x1860 kernel/workqueue.c:3361
 worker_thread+0xa53/0xfc0 kernel/workqueue.c:3442
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 6021:
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:415
 kasan_kmalloc include/linux/kasan.h:263 [inline]
 __do_kmalloc_node mm/slub.c:5292 [inline]
 __kmalloc_noprof+0x35c/0x760 mm/slub.c:5304
 kmalloc_noprof include/linux/slab.h:954 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 alloc_gid_table drivers/infiniband/core/cache.c:773 [inline]
 _gid_table_setup_one drivers/infiniband/core/cache.c:888 [inline]
 gid_table_setup_one drivers/infiniband/core/cache.c:916 [inline]
 ib_cache_setup_one+0x198/0x570 drivers/infiniband/core/cache.c:1606
 ib_register_device+0xfbd/0x13e0 drivers/infiniband/core/device.c:1426
 siw_device_register drivers/infiniband/sw/siw/siw_main.c:71 [inline]
 siw_newlink+0x8fe/0xde0 drivers/infiniband/sw/siw/siw_main.c:430
 nldev_newlink+0x5bc/0x650 drivers/infiniband/core/nldev.c:1812
 rdma_nl_rcv_msg drivers/infiniband/core/netlink.c:-1 [inline]
 rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
 rdma_nl_rcv+0x6d1/0xa10 drivers/infiniband/core/netlink.c:259
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x80f/0x9b0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x813/0xb40 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:786 [inline]
 __sock_sendmsg net/socket.c:801 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2650
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2704
 __sys_sendmsg net/socket.c:2736 [inline]
 __do_sys_sendmsg net/socket.c:2741 [inline]
 __se_sys_sendmsg net/socket.c:2739 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2739
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The buggy address belongs to the object at ffff88802bcdb600
 which belongs to the cache kmalloc-256 of size 256
The buggy address is located 216 bytes inside of
 224-byte region [ffff88802bcdb600, ffff88802bcdb6e0)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x2bcda
head: order:1 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
flags: 0xfff00000000040(head|node=0|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 00fff00000000040 ffff88813fe38b40 dead000000000100 dead000000000122
raw: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000040 ffff88813fe38b40 dead000000000100 dead000000000122
head: 0000000000000000 0000000800100010 00000000f5000000 0000000000000000
head: 00fff00000000001 ffffffffffffff81 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000002
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 1, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5953, tgid 5953 (syz-executor), ts 101457682506, free_ts 101330013904
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x231/0x280 mm/page_alloc.c:1858
 prep_new_page mm/page_alloc.c:1866 [inline]
 get_page_from_freelist+0x24ba/0x2540 mm/page_alloc.c:3946
 __alloc_frozen_pages_noprof+0x18d/0x380 mm/page_alloc.c:5226
 alloc_slab_page mm/slub.c:3278 [inline]
 allocate_slab+0x77/0x660 mm/slub.c:3467
 new_slab mm/slub.c:3525 [inline]
 refill_objects+0x339/0x3d0 mm/slub.c:7247
 refill_sheaf mm/slub.c:2816 [inline]
 __pcs_replace_empty_main+0x321/0x720 mm/slub.c:4651
 alloc_from_pcs mm/slub.c:4749 [inline]
 slab_alloc_node mm/slub.c:4883 [inline]
 __kmalloc_cache_noprof+0x392/0x660 mm/slub.c:5407
 kmalloc_noprof include/linux/slab.h:950 [inline]
 kzalloc_noprof include/linux/slab.h:1188 [inline]
 ____ip_mc_inc_group+0x518/0xdd0 net/ipv4/igmp.c:1535
 __ip_mc_inc_group net/ipv4/igmp.c:1573 [inline]
 ip_mc_inc_group net/ipv4/igmp.c:1579 [inline]
 ip_mc_up+0x115/0x2e0 net/ipv4/igmp.c:1880
 inetdev_event+0xff6/0x1610 net/ipv4/devinet.c:1630
 notifier_call_chain+0x1ad/0x3d0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2285 [inline]
 call_netdevice_notifiers net/core/dev.c:2299 [inline]
 __dev_notify_flags+0x1a9/0x310 net/core/dev.c:9835
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9864
 do_setlink+0xf82/0x4590 net/core/rtnetlink.c:3180
 rtnl_changelink net/core/rtnetlink.c:3798 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3957 [inline]
 rtnl_newlink+0x15a9/0x1be0 net/core/rtnetlink.c:4094
 rtnetlink_rcv_msg+0x7d5/0xbe0 net/core/rtnetlink.c:6980
page last free pid 5953 tgid 5953 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1402 [inline]
 __free_frozen_pages+0xbc7/0xd30 mm/page_alloc.c:2943
 rcu_do_batch kernel/rcu/tree.c:2617 [inline]
 rcu_core+0x7cd/0x1070 kernel/rcu/tree.c:2869
 handle_softirqs+0x22a/0x840 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x220 kernel/softirq.c:735
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:752
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1061 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1061
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Memory state around the buggy address:
 ffff88802bcdb580: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802bcdb600: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>ffff88802bcdb680: 00 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc
                                                    ^
 ffff88802bcdb700: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
 ffff88802bcdb780: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

