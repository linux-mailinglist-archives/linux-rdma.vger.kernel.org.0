Return-Path: <linux-rdma+bounces-20088-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qAaPAzJR+2mSZQMAu9opvQ
	(envelope-from <linux-rdma+bounces-20088-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:33:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E55C74DC41E
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 16:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4BF59305871A
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 14:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F556481A93;
	Wed,  6 May 2026 14:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZmrxhBnP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D9648164A
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 14:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077711; cv=none; b=U2u3IpNKaNXMDSgHkLGobyo/fLPM3omonJ/McjA/3XE2OPox0okrWChdSW9WKgcsURXCV0sGaaiSiRLcFeUztc2QnyW5CP7zwPhJWQWS2QJV4K/pqFVOHr20w4CMJK6ZJStx4uzAIR7S6W8jTb4yeyltECZmISyfuggGQo/qIgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077711; c=relaxed/simple;
	bh=5ZU21tRIlqXoH9jIFxronPOEdmNOHwLE03547/Jek1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=VNBAElfJPoQiDgf9trL9+6FGdifDRgOFuyeGmzh6mhA2XYYDmH9xjYTHQa/3jkWfwPNpYtvdDqs7A82vPZP3jaO7KzemJivjPFLMDaK5JG2Uyl44fKpUlXeqL4ss9KXJnAhHQGxYo3Es3xk9JNQRsUwjugJB+ShBzB8GntYm0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZmrxhBnP; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <78183562-ff83-4b7a-9c7b-b3cb92676ee8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1778077696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vuoq7yYRR946Z2PaAByJyOtutD5hvIdtunJIHpdgfA8=;
	b=ZmrxhBnP6yTe33insjP4W9UIy+jxXJFkVZPd54uf85RoC/rbEvobOZhrLa6t/KPtTAr91/
	v5n3n4meLok1Wh7lBsWjmu2JCRD6ERfbRu9u4uuwtB0uTWFlSbD5I1tLxDrzwR4KHI9nD8
	iJn4H7Q5zmwuLCjpVxDI+Iu5T13XxDA=
Date: Wed, 6 May 2026 07:28:10 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown
 (4)
To: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>,
 akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net,
 dsahern@kernel.org, edumazet@google.com, horms@kernel.org, jgg@ziepe.ca,
 kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, leon@kernel.org,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com,
 zyjzyj2000@gmail.com
References: <69fb46ae.a00a0220.387fc1.0002.GAE@google.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <69fb46ae.a00a0220.387fc1.0002.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E55C74DC41E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20088-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[syzkaller.appspotmail.com,linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,d8f76778263ab65c2b21];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,storage.googleapis.com:url,syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]


在 2026/5/6 6:48, syzbot 写道:
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    74fe02ce122a Merge tag 'wq-for-7.1-rc2-fixes' of git://git..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=16e895ce580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
> dashboard link: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a613ba580000
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-74fe02ce.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/c0a591d96864/vmlinux-74fe02ce.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/9f94fb623cd1/bzImage-74fe02ce.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com
>
> Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN NOPTI
> KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]

Thanks a lot. IIRC, this problem is in process. The link is 
https://patchwork.kernel.org/project/linux-rdma/patch/20260424013759.728288-1-kuniyu@google.com/

Hi, Kuniyuki Iwashima

I think you are fixing this problem. I hope that we can see your commit 
very soon.

Zhu Yanjun

> CPU: 3 UID: 0 PID: 5986 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c ff e0
> RSP: 0018:ffffc9000391f180 EFLAGS: 00010202
> RAX: dffffc0000000000 RBX: ffff88802a2a0040 RCX: ffffffff8b8b72bd
> RDX: 000000000000000d RSI: ffffffff89553b32 RDI: 0000000000000068
> RBP: 0000000000000002 R08: 0000000000000001 R09: fffff52000723dfc
> R10: ffffc9000391efe7 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8880311b8000 R14: 0000000000000002 R15: 0000000000000018
> FS:  00007f602d1fe6c0(0000) GS:ffff8880d6675000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000561c522a6000 CR3: 000000002e99e000 CR4: 0000000000352ef0
> Call Trace:
>   <TASK>
>   udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:202
>   rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
>   rxe_sock_put+0xae/0x130 drivers/infiniband/sw/rxe/rxe_net.c:639
>   rxe_net_del+0x83/0x120 drivers/infiniband/sw/rxe/rxe_net.c:660
>   rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
>   nldev_dellink+0x289/0x3c0 drivers/infiniband/core/nldev.c:1849
>   rdma_nl_rcv_msg+0x392/0x6f0 drivers/infiniband/core/netlink.c:195
>   rdma_nl_rcv_skb.constprop.0.isra.0+0x2cb/0x410 drivers/infiniband/core/netlink.c:239
>   netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
>   netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
>   netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
>   sock_sendmsg_nosec net/socket.c:787 [inline]
>   __sock_sendmsg net/socket.c:802 [inline]
>   ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
>   ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
>   __sys_sendmsg+0x170/0x220 net/socket.c:2784
>   do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>   do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f602db9cdd9
> Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f602d1fe028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> RAX: ffffffffffffffda RBX: 00007f602de16090 RCX: 00007f602db9cdd9
> RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000007
> RBP: 00007f602dc32d69 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f602de16128 R14: 00007f602de16090 R15: 00007ffc1d89c428
>   </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
> Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c ff e0
> RSP: 0018:ffffc9000391f180 EFLAGS: 00010202
>
> RAX: dffffc0000000000 RBX: ffff88802a2a0040 RCX: ffffffff8b8b72bd
> RDX: 000000000000000d RSI: ffffffff89553b32 RDI: 0000000000000068
> RBP: 0000000000000002 R08: 0000000000000001 R09: fffff52000723dfc
> R10: ffffc9000391efe7 R11: 0000000000000000 R12: 0000000000000000
> R13: ffff8880311b8000 R14: 0000000000000002 R15: 0000000000000018
> FS:  00007f602d1fe6c0(0000) GS:ffff8880d6675000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000561c522a6000 CR3: 000000002e99e000 CR4: 0000000000352ef0
> ----------------
> Code disassembly (best guess):
>     0:	fc                   	cld
>     1:	ff                   	lcall  (bad)
>     2:	df 48 89             	fisttps -0x77(%rax)
>     5:	fa                   	cli
>     6:	48 c1 ea 03          	shr    $0x3,%rdx
>     a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
>     e:	75 33                	jne    0x43
>    10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
>    17:	fc ff df
>    1a:	4c 8b 63 20          	mov    0x20(%rbx),%r12
>    1e:	49 8d 7c 24 68       	lea    0x68(%r12),%rdi
>    23:	48 89 fa             	mov    %rdi,%rdx
>    26:	48 c1 ea 03          	shr    $0x3,%rdx
> * 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
>    2e:	75 1a                	jne    0x4a
>    30:	49 8b 44 24 68       	mov    0x68(%r12),%rax
>    35:	89 ee                	mov    %ebp,%esi
>    37:	48 89 df             	mov    %rbx,%rdi
>    3a:	5b                   	pop    %rbx
>    3b:	5d                   	pop    %rbp
>    3c:	41 5c                	pop    %r12
>    3e:	ff e0                	jmp    *%rax
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

-- 
Best Regards,
Yanjun.Zhu


