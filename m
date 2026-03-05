Return-Path: <linux-rdma+bounces-17523-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGb4IBVzqWnH7AAAu9opvQ
	(envelope-from <linux-rdma+bounces-17523-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 13:12:05 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E853B2115DC
	for <lists+linux-rdma@lfdr.de>; Thu, 05 Mar 2026 13:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6376C31235BB
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Mar 2026 11:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6904C39A7F3;
	Thu,  5 Mar 2026 11:58:34 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com [209.85.160.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99E753976B3
	for <linux-rdma@vger.kernel.org>; Thu,  5 Mar 2026 11:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772711914; cv=none; b=E+QSXnN9I+jo1tQXQiVKlKfZc6dTsjbzqDTOlKikLB04wsYlSTz0lp7vppMnwvQou+wfNh57UeSFS7SnpF1bwFQE62ourNXypyxoVLEHreOECxtLQeA33wj3pVb91tWPGouMlUoFcLjPaWYsHmT236tArVB5UprZJ1mrAGpRX6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772711914; c=relaxed/simple;
	bh=BpDLlxlHv/1YJcm5R8Ip30r0fUzyaCFEItVhshuFSYs=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MIVVjyk8NEDOmFSxDfs0ZGz7hTeK7P7CQe2dkC9Tyl4ri3ACxRcK+k1om/5Pi7Rbg+VvLg3RKJkiC74T1RtQScqNNIlTLtXxRvvxi/Q/bf9Er650u6NxM1UB7d+C1ttgkxx0JbbmwlC3hTPAUUOeum2XxGSqRXVvtMAYFxXV5ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-40f09403c56so20129109fac.1
        for <linux-rdma@vger.kernel.org>; Thu, 05 Mar 2026 03:58:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772711911; x=1773316711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RdxsOqxk+NfY8zfwQAwo+ZzFguPNl7tVhrDifbEGfvk=;
        b=PbCjxD1Qv4gzDTVLVH65j6KuIsft5+vJX7oyrZdkZWiFsopN1qWJE6obN70GZ3ivp5
         j/MHhvFZCNNEcNFpXQophsaLdwIDK1AfXJXuThTZBl8rUnPBOwpwzHmb7KDUck5nvhji
         m2l/Twk0ZZPfmiihrcz5VVm/WcJDJwqfyao0NAaIXaJiO11Zjn4DzoyNUyLbRUIPL0k+
         sHOsmT9keDnVooye0QsDsodb02vyOhxT5FQ4qul2Ljr5YlfqPbqOOyTrWWeuqoAmU3Il
         A6hjZcdh0DvOCA3zwJxLMqiuPUvBrtHwzutX7Ihm+fXgh+QLoTr1X0fJwJH4/ImKJ0Qz
         n3gg==
X-Forwarded-Encrypted: i=1; AJvYcCUu+2wbQTml41ngRVVLVwQ96BCIwzGamLOq8Q+9lrDpalnRNm8q/eZgGmJUO5IBnjPk81bMrxbfAWpL@vger.kernel.org
X-Gm-Message-State: AOJu0YzgvBZP9L4nDcI8kK2CzJcJ7jY27I+N9TpgQeY0prXzZKvIqOFi
	daA7oeQHpN+pH5MV9YkLM0XhspTthaCpcmeGS8/Z+J13qEQm/GFIY/tk+150/hyfLaQ7xi20l0B
	l+DTuFCz5se41rKRRZzxpgJJm3/w4cFiPF7S8gPtRBN6rlAxHfDdew8XukGE=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4410:b0:679:c346:d8cd with SMTP id
 006d021491bc7-67b9456357bmr1058550eaf.28.1772711911652; Thu, 05 Mar 2026
 03:58:31 -0800 (PST)
Date: Thu, 05 Mar 2026 03:58:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a96fe7.a70a0220.1ca35.0006.GAE@google.com>
Subject: [syzbot] [rds?] KASAN: slab-use-after-free Read in rds_conn_path_drop
From: syzbot <syzbot+da8e060735ae02c8f3d1@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E853B2115DC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=163cf0fb07ea84d3];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-17523-lists,linux-rdma=lfdr.de,da8e060735ae02c8f3d1];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-rdma];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    ecc64d2dc9ff Merge tag 'sysctl-7.00-fixes-rc3' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14eb98d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=163cf0fb07ea84d3
dashboard link: https://syzkaller.appspot.com/bug?extid=da8e060735ae02c8f3d1
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ecc64d2d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7dbb1345713/vmlinux-ecc64d2d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff1cd3190933/bzImage-ecc64d2d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+da8e060735ae02c8f3d1@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-use-after-free in instrument_atomic_read include/linux/instrumented.h:82 [inline]
BUG: KASAN: slab-use-after-free in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: slab-use-after-free in refcount_read include/linux/refcount.h:170 [inline]
BUG: KASAN: slab-use-after-free in __ns_ref_read include/linux/ns_common.h:65 [inline]
BUG: KASAN: slab-use-after-free in check_net include/net/net_namespace.h:309 [inline]
BUG: KASAN: slab-use-after-free in rds_destroy_pending net/rds/rds.h:984 [inline]
BUG: KASAN: slab-use-after-free in rds_conn_path_drop+0x11d/0x3c0 net/rds/connection.c:914
Read of size 4 at addr ffff88804ae88180 by task kworker/u32:0/23206

CPU: 2 UID: 0 PID: 23206 Comm: kworker/u32:0 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Workqueue: ib_mad1 timeout_sends
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:378 [inline]
 print_report+0x156/0x4c9 mm/kasan/report.c:482
 kasan_report+0xdf/0x1e0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:170 [inline]
 __ns_ref_read include/linux/ns_common.h:65 [inline]
 check_net include/net/net_namespace.h:309 [inline]
 rds_destroy_pending net/rds/rds.h:984 [inline]
 rds_conn_path_drop+0x11d/0x3c0 net/rds/connection.c:914
 rds_rdma_cm_event_handler_cmn+0x47d/0x7c0 net/rds/rdma_transport.c:146
 cma_cm_event_handler+0x99/0x330 drivers/infiniband/core/cma.c:2181
 cma_ib_handler+0x29d/0x700 drivers/infiniband/core/cma.c:2259
 cm_process_send_error drivers/infiniband/core/cm.c:3801 [inline]
 cm_send_handler+0x533/0x9d0 drivers/infiniband/core/cm.c:3834
 clear_mad_error_list+0x18f/0x260 drivers/infiniband/core/mad.c:2646
 timeout_sends+0x720/0xb20 drivers/infiniband/core/mad.c:2918
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Allocated by task 26019:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4515 [inline]
 slab_alloc_node mm/slub.c:4844 [inline]
 kmem_cache_alloc_noprof+0x241/0x6e0 mm/slub.c:4851
 net_alloc net/core/net_namespace.c:490 [inline]
 copy_net_ns+0xe8/0x7c0 net/core/net_namespace.c:565
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:130
 unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x473/0xad0 kernel/fork.c:3174
 __do_sys_unshare kernel/fork.c:3245 [inline]
 __se_sys_unshare kernel/fork.c:3243 [inline]
 __ia32_sys_unshare+0x30/0x40 kernel/fork.c:3243
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe3/0x8c0 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e

Freed by task 14441:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x70 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2692 [inline]
 slab_free mm/slub.c:6143 [inline]
 kmem_cache_free+0x124/0x6a0 mm/slub.c:6273
 net_complete_free net/core/net_namespace.c:526 [inline]
 cleanup_net+0x51a/0x920 net/core/net_namespace.c:713
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x754/0xd80 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

Last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2199
 __queue_work+0x3fd/0x1150 kernel/workqueue.c:2358
 call_timer_fn+0x19a/0x670 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1794 [inline]
 __run_timers+0x570/0xb30 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2394
 run_timer_softirq+0x24/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1eb/0x9e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xef/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

Second to last potentially related work creation:
 kasan_save_stack+0x30/0x50 mm/kasan/common.c:57
 kasan_record_aux_stack+0xa7/0xc0 mm/kasan/generic.c:556
 insert_work+0x36/0x230 kernel/workqueue.c:2199
 __queue_work+0x9bc/0x1150 kernel/workqueue.c:2354
 call_timer_fn+0x19a/0x670 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1794 [inline]
 __run_timers+0x570/0xb30 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2394
 run_timer_softirq+0x24/0x50 kernel/time/timer.c:2405
 handle_softirqs+0x1eb/0x9e0 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xef/0x150 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa3/0xc0 arch/x86/kernel/apic/apic.c:1056
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697

The buggy address belongs to the object at ffff88804ae88000
 which belongs to the cache net_namespace of size 9536
The buggy address is located 384 bytes inside of
 freed 9536-byte region [ffff88804ae88000, ffff88804ae8a540)

The buggy address belongs to the physical page:
page: refcount:0 mapcount:0 mapping:0000000000000000 index:0xffff88804ae88000 pfn:0x4ae88
head: order:3 mapcount:0 entire_mapcount:0 nr_pages_mapped:0 pincount:0
memcg:ffff88804dfbda81
flags: 0x4fff00000000240(workingset|head|node=1|zone=1|lastcpupid=0x7ff)
page_type: f5(slab)
raw: 04fff00000000240 ffff88801d2f2780 ffffea0001663410 ffffea0001c9fe10
raw: ffff88804ae88000 0000000800030001 00000000f5000000 ffff88804dfbda81
head: 04fff00000000240 ffff88801d2f2780 ffffea0001663410 ffffea0001c9fe10
head: ffff88804ae88000 0000000800030001 00000000f5000000 ffff88804dfbda81
head: 04fff00000000003 ffffea00012ba201 00000000ffffffff 00000000ffffffff
head: ffffffffffffffff 0000000000000000 00000000ffffffff 0000000000000008
page dumped because: kasan: bad access detected
page_owner tracks the page as allocated
page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 5930, tgid 5930 (syz-executor), ts 52026837212, free_ts 30286540261
 set_page_owner include/linux/page_owner.h:32 [inline]
 post_alloc_hook+0x153/0x170 mm/page_alloc.c:1889
 prep_new_page mm/page_alloc.c:1897 [inline]
 get_page_from_freelist+0x111d/0x3140 mm/page_alloc.c:3962
 __alloc_frozen_pages_noprof+0x27c/0x2ba0 mm/page_alloc.c:5250
 alloc_slab_page mm/slub.c:3269 [inline]
 allocate_slab mm/slub.c:3458 [inline]
 new_slab+0xa6/0x6d0 mm/slub.c:3516
 refill_objects+0x26b/0x400 mm/slub.c:7153
 refill_sheaf mm/slub.c:2818 [inline]
 alloc_full_sheaf mm/slub.c:2839 [inline]
 __pcs_replace_empty_main+0x19f/0x600 mm/slub.c:4602
 alloc_from_pcs mm/slub.c:4695 [inline]
 slab_alloc_node mm/slub.c:4829 [inline]
 kmem_cache_alloc_noprof+0x480/0x6e0 mm/slub.c:4851
 net_alloc net/core/net_namespace.c:490 [inline]
 copy_net_ns+0xe8/0x7c0 net/core/net_namespace.c:565
 create_new_namespaces+0x3ea/0xac0 kernel/nsproxy.c:130
 unshare_nsproxy_namespaces+0xc3/0x1f0 kernel/nsproxy.c:226
 ksys_unshare+0x473/0xad0 kernel/fork.c:3174
 __do_sys_unshare kernel/fork.c:3245 [inline]
 __se_sys_unshare kernel/fork.c:3243 [inline]
 __ia32_sys_unshare+0x30/0x40 kernel/fork.c:3243
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xe3/0x8c0 arch/x86/entry/syscall_32.c:307
 do_fast_syscall_32+0x32/0x70 arch/x86/entry/syscall_32.c:332
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
page last free pid 5644 tgid 5644 stack trace:
 reset_page_owner include/linux/page_owner.h:25 [inline]
 __free_pages_prepare mm/page_alloc.c:1433 [inline]
 __free_frozen_pages+0x7e1/0x10d0 mm/page_alloc.c:2978
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x47/0xe0 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x1a0/0x1f0 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x69/0x90 mm/kasan/common.c:350
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4515 [inline]
 slab_alloc_node mm/slub.c:4844 [inline]
 kmem_cache_alloc_noprof+0x241/0x6e0 mm/slub.c:4851
 alloc_filename fs/namei.c:142 [inline]
 do_getname+0x35/0x390 fs/namei.c:182
 getname include/linux/fs.h:2512 [inline]
 getname_maybe_null include/linux/fs.h:2519 [inline]
 class_filename_maybe_null_constructor include/linux/fs.h:2543 [inline]
 vfs_fstatat+0xd0/0xe0 fs/stat.c:368
 __do_sys_newfstatat+0x9d/0x120 fs/stat.c:538
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Memory state around the buggy address:
 ffff88804ae88080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804ae88100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>ffff88804ae88180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
                   ^
 ffff88804ae88200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
 ffff88804ae88280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
==================================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

