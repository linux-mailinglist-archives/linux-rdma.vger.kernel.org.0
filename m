Return-Path: <linux-rdma+bounces-13522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59197B8BDDF
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 05:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3FA85661B4
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Sep 2025 03:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E062147E6;
	Sat, 20 Sep 2025 03:14:15 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A203286A9;
	Sat, 20 Sep 2025 03:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758338055; cv=none; b=UF3/Q/9j5yJV6y5VLcw/6FOm0mlkXPMstpWQKz1DuY7idA8G9PG5zftgj5hexY9h+KysdM4ziYzuiG2KhoK/XWgVRh6P4vZ+lHJ15GcFusSQG6HC6KcMP7JMUEygivK8Bi5R5le75wyehsa9lCGO4UArv5yu6IdU0POuxsjHpm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758338055; c=relaxed/simple;
	bh=42Q1yqeXj9JxOAIn0H5mMd4LavLanRycmbxv9/wrDmA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=QnMwj1JJa+mVXeaJslwwt6Lb+GY6/sZcmX61eU/9oR4mdfzMHBRyLPaRyZ9yCnVbLRhB1queaVuANM27Ws4mw9kzWVFdwsfDbe1SQrvura+3fiYnM91i5EtOlVIgE6/Ct6Ru6AZRptAmGSFFDcAGz+6qCoR9VCPXgG9zk7JLLt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cTDws673wz14MPh;
	Sat, 20 Sep 2025 11:13:49 +0800 (CST)
Received: from dggpemf500016.china.huawei.com (unknown [7.185.36.197])
	by mail.maildlp.com (Postfix) with ESMTPS id 804DC1402C1;
	Sat, 20 Sep 2025 11:14:07 +0800 (CST)
Received: from [10.174.176.70] (10.174.176.70) by
 dggpemf500016.china.huawei.com (7.185.36.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 20 Sep 2025 11:14:05 +0800
Message-ID: <0ca2c567-b311-4f0b-bb29-2b860b75f85e@huawei.com>
Date: Sat, 20 Sep 2025 11:14:04 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [smc?] general protection fault in __smc_diag_dump (4)
To: syzbot <syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com>,
	<alibuda@linux.alibaba.com>, <davem@davemloft.net>,
	<dust.li@linux.alibaba.com>, <edumazet@google.com>,
	<guwen@linux.alibaba.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <mjambigi@linux.ibm.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <sidraya@linux.ibm.com>,
	<syzkaller-bugs@googlegroups.com>, <tonylu@linux.alibaba.com>,
	<wenjia@linux.ibm.com>, zhangchangzhong <zhangchangzhong@huawei.com>,
	yuehaibing <yuehaibing@huawei.com>
References: <68caf6c7.050a0220.2ff435.0597.GAE@google.com>
From: Wang Liang <wangliang74@huawei.com>
In-Reply-To: <68caf6c7.050a0220.2ff435.0597.GAE@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500016.china.huawei.com (7.185.36.197)

This issue is similar to:
https://lore.kernel.org/netdev/20250331081003.1503211-1-wangliang74@huawei.com/

The process like this:
(CPU1)                           | (CPU2)
---------------------------------|-------------------------------
inet_create()                    |
   sk = sk_alloc()                |
                                  |
   inet_init_csk_locks()          |
     modify smc->clcsock          |
                                  |
   sk->sk_prot->init              |
     smc_inet_init_sock()         |
       smc_sk_init()              |
         smc_hash_sk()            |
           head = &smc_hash->ht;  |
           sk_add_node(sk, head); |
                                  | smc_diag_dump_proto
                                  |   head = &smc_hash->ht;
                                  |     sk_for_each(sk, head)
                                  |       __smc_diag_dump()
                                  |         visit smc->clcsock


The 'smc->clcsock' is modified in inet_init_csk_locks():
__sock_create(family=2, type=1, protocol=256)
     inet_create
         sk = sk_alloc(...); // smc->clcsock = 0
         inet_init_csk_locks(sk);
             icsk = inet_csk(sk);
spin_lock_init(&icsk->icsk_accept_queue.rskq_lock); // smc->clcsock = 
0xdead4ead00000000

The relevant structure is 'struct smc_sock' and 'struct 
inet_connection_sock':
struct smc_sock {
     union {
         struct sock      sk;
         struct inet_sock icsk_inet;
     };
     struct socket        *clcsock;
     ...
};
struct inet_connection_sock {
     struct inet_sock          icsk_inet;
     struct request_sock_queue icsk_accept_queue;
     ...
};

Commit 60ada4fe644e ("smc: Fix various oops due to inet_sock type 
confusion.")
add inet_sock as the first member of smc_sock. Maybe add 
inet_connection_sock
instead of inet_sock is more appropriate.

#syz test

 From 782467e7f55f2f1487744252060ffbaa992ee47a Mon Sep 17 00:00:00 2001
From: Wang Liang <wangliang74@huawei.com>
Date: Sat, 20 Sep 2025 11:29:52 +0800
Subject: [PATCH net] net/smc: fix general protection fault in 
__smc_diag_dump

Use inet_connection_sock instead of inet_sock in struct smc_sock.

Signed-off-by: Wang Liang <wangliang74@huawei.com>
---
  net/smc/smc.h | 2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc.h b/net/smc/smc.h
index 2c9084963739..1b20f0c927d3 100644
--- a/net/smc/smc.h
+++ b/net/smc/smc.h
@@ -285,7 +285,7 @@ struct smc_connection {
  struct smc_sock {                              /* smc sock container */
         union {
                 struct sock             sk;
-               struct inet_sock        icsk_inet;
+               struct inet_connection_sock     inet_conn;
         };
         struct socket           *clcsock;       /* internal tcp socket */
         void                    (*clcsk_state_change)(struct sock *sk);
--
2.34.1




在 2025/9/18 1:58, syzbot 写道:
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5aca7966d2a7 Merge tag 'perf-tools-fixes-for-v6.17-2025-09..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=147e2e42580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=8f01d8629880e620
> dashboard link: https://syzkaller.appspot.com/bug?extid=f775be4458668f7d220e
> compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17aec534580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=115a9f62580000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f191b2524020/disk-5aca7966.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/5aa02ba0cba2/vmlinux-5aca7966.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/b9b04ddba61b/bzImage-5aca7966.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+f775be4458668f7d220e@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xfbd5a5d5a0000003: 0000 [#1] SMP KASAN NOPTI
> KASAN: maybe wild-memory-access in range [0xdead4ead00000018-0xdead4ead0000001f]
> CPU: 1 UID: 0 PID: 6949 Comm: syz.0.335 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
> RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
> Code: 4c 8b b3 40 06 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 6b 4f 78 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f6 1e 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc90003f2f1a8 EFLAGS: 00010a06
> RAX: dffffc0000000000 RBX: ffff88802a33bd40 RCX: ffffffff897ee8a4
> RDX: 1bd5a9d5a0000003 RSI: ffffffff8b434dd5 RDI: dead4ead00000018
> RBP: ffff888032418000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000001 R11: 0000000000000000 R12: ffff8880754915f0
> R13: ffff88805d823780 R14: dead4ead00000000 R15: ffff88802a33c380
> FS:  00007fec5f7dd6c0(0000) GS:ffff8881247b2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fec5f7dcf98 CR3: 000000007d646000 CR4: 00000000003526f0
> Call Trace:
>   <TASK>
>   smc_diag_dump_proto+0x26d/0x420 net/smc/smc_diag.c:217
>   smc_diag_dump+0x27/0x90 net/smc/smc_diag.c:234
>   netlink_dump+0x539/0xd30 net/netlink/af_netlink.c:2327
>   __netlink_dump_start+0x6d6/0x990 net/netlink/af_netlink.c:2442
>   netlink_dump_start include/linux/netlink.h:341 [inline]
>   smc_diag_handler_dump+0x1f9/0x240 net/smc/smc_diag.c:251
>   __sock_diag_cmd net/core/sock_diag.c:249 [inline]
>   sock_diag_rcv_msg+0x438/0x790 net/core/sock_diag.c:285
>   netlink_rcv_skb+0x158/0x420 net/netlink/af_netlink.c:2552
>   netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
>   netlink_unicast+0x5a7/0x870 net/netlink/af_netlink.c:1346
>   netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
>   sock_sendmsg_nosec net/socket.c:714 [inline]
>   __sock_sendmsg net/socket.c:729 [inline]
>   ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
>   ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
>   __sys_sendmsg+0x16d/0x220 net/socket.c:2700
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0xcd/0x4e0 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fec6018eba9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fec5f7dd038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007fec603d6090 RCX: 00007fec6018eba9
> RDX: 0000000000000000 RSI: 0000200000000140 RDI: 0000000000000003
> RBP: 00007fec60211e19 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fec603d6128 R14: 00007fec603d6090 R15: 00007ffcb0713c08
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:smc_diag_msg_common_fill net/smc/smc_diag.c:44 [inline]
> RIP: 0010:__smc_diag_dump.constprop.0+0x3ca/0x2550 net/smc/smc_diag.c:89
> Code: 4c 8b b3 40 06 00 00 4d 85 f6 0f 84 f6 02 00 00 e8 6b 4f 78 f6 49 8d 7e 18 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 f6 1e 00 00 48 b8 00 00 00 00 00 fc ff df 4d 8b
> RSP: 0018:ffffc90003f2f1a8 EFLAGS: 00010a06
> RAX: dffffc0000000000 RBX: ffff88802a33bd40 RCX: ffffffff897ee8a4
> RDX: 1bd5a9d5a0000003 RSI: ffffffff8b434dd5 RDI: dead4ead00000018
> RBP: ffff888032418000 R08: 0000000000000005 R09: 0000000000000000
> R10: 0000000080000001 R11: 0000000000000000 R12: ffff8880754915f0
> R13: ffff88805d823780 R14: dead4ead00000000 R15: ffff88802a33c380
> FS:  00007fec5f7dd6c0(0000) GS:ffff8881247b2000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fec5f7dcf98 CR3: 000000007d646000 CR4: 00000000003526f0
> ----------------
> Code disassembly (best guess):
>     0:	4c 8b b3 40 06 00 00 	mov    0x640(%rbx),%r14
>     7:	4d 85 f6             	test   %r14,%r14
>     a:	0f 84 f6 02 00 00    	je     0x306
>    10:	e8 6b 4f 78 f6       	call   0xf6784f80
>    15:	49 8d 7e 18          	lea    0x18(%r14),%rdi
>    19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    20:	fc ff df
>    23:	48 89 fa             	mov    %rdi,%rdx
>    26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>    2e:	0f 85 f6 1e 00 00    	jne    0x1f2a
>    34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    3b:	fc ff df
>    3e:	4d                   	rex.WRB
>    3f:	8b                   	.byte 0x8b
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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
>
>

