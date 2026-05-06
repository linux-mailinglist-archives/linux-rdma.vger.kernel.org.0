Return-Path: <linux-rdma+bounces-20081-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B38BkRH+2lPYgMAu9opvQ
	(envelope-from <linux-rdma+bounces-20081-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:51:00 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CAC4DB54F
	for <lists+linux-rdma@lfdr.de>; Wed, 06 May 2026 15:50:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B43BB3018741
	for <lists+linux-rdma@lfdr.de>; Wed,  6 May 2026 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D198347CC63;
	Wed,  6 May 2026 13:48:32 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FDDE3F7880
	for <linux-rdma@vger.kernel.org>; Wed,  6 May 2026 13:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778075312; cv=none; b=j0FpiE2NRRtM/ExkMbg0Cr+bMHKbQrmVp/bMYIgCJXaCbH1ze2ssBEt4159dqUZ9pS/ZWI+yZ7xkUBHY7r0IsNjRV/Y7lSb+kTQv3+3BrN7yKTf1gsPMOIEzAlRHn0F4MUCHGF0ioMoEe7JFjAYewwv/bqhVq3+kUgFAEEK7Xcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778075312; c=relaxed/simple;
	bh=FzAoyVrulMk4QyoGzpi2N+9RxsRlpt5w2CxGUrqohGI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=due2K1Yq7o1fbdN+NI0yfJ0TVQZCqvl7jIE5BTThvRNVfKvvF3+ZoEcCsvwPpCQuj9kh+mxPbvDmYjCZBv1a4712x0whCr0m+W+ax2wUfwonnqFepln71xX7dewMfaYmL7hxtPBcWUXYb6ZjCNZgjkP0Cs6/RS+eIRLgNBDA/4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-409037c3f0bso9808849fac.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 May 2026 06:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778075310; x=1778680110;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lMM/tivuo3s7SAwJDZmgU1AqsNMJYZvbjbH+Y8DwNCE=;
        b=XKf2OaRxZZgQ/X5PTiZny2KK1APZUelgEwtVi9ELbMNemPhLPTwBfyUuxbWayTFsVS
         vtLCSvQWOfe5vNeXIryXBcTK3AiQ0a26ExMd88+BZctxsi1rZaZ//36YJQliMdpSr4+4
         CYYlInu3au8+6q2upbVQatiAOG/cRo4Dh4StomRYsi+CmMgi9Djr+FBN7SnQvp9OiDVG
         QE9BuDWBfHg3rVVAYEBLV3kvX2mkg7YGGPOzUc7Zb/h0BCR+1Y9Q1mJNMzFW64zIAN6n
         fuugGE34d9pVFYW/rMbit53eWD2JZauv2/9+Qkf298GNvApNaBQ14P5jvKJwOms3xrCo
         JDPQ==
X-Forwarded-Encrypted: i=1; AFNElJ9tbyFZEvU4TgP4dXmNCFhrbmxzlojTpbk0UTuGfTBcpbsvF9zwvaPHQO9KLtDzyjEnMxRcY1/YaDq3@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3X7tbPYVyKLPYIDImmh3/2okXAiTTAkYxFMgkn6DH7P3Tf/Tm
	L3S5f0y5RxVl2xlB4Qfr7POXT9ym/eU1lOL4GDblrzB5o85D5rgEOsIQN7RqrE1TCK3i6iw7+cu
	gQNbImRA5ie8pLCu5OuwZTTPPgz7Bigdq4i/OcM4lbHOHqSE3ITg4wasHD10=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:161f:b0:694:8e28:fd6e with SMTP id
 006d021491bc7-69998d0e2cemr1605172eaf.38.1778075310189; Wed, 06 May 2026
 06:48:30 -0700 (PDT)
Date: Wed, 06 May 2026 06:48:30 -0700
In-Reply-To: <69ea344f.a00a0220.17a17.0040.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69fb46ae.a00a0220.387fc1.0002.GAE@google.com>
Subject: Re: [syzbot] [rdma] general protection fault in kernel_sock_shutdown (4)
From: syzbot <syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, arjan@linux.intel.com, davem@davemloft.net, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, jgg@ziepe.ca, 
	kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, leon@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	yanjun.zhu@linux.dev, zyjzyj2000@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: A3CAC4DB54F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[linux-foundation.org,linux.intel.com,davemloft.net,kernel.org,google.com,ziepe.ca,gmail.com,vger.kernel.org,redhat.com,googlegroups.com,linux.dev];
	TAGGED_FROM(0.00)[bounces-20081-lists,linux-rdma=lfdr.de,d8f76778263ab65c2b21];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_TWELVE(0.00)[18]

syzbot has found a reproducer for the following issue on:

HEAD commit:    74fe02ce122a Merge tag 'wq-for-7.1-rc2-fixes' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e895ce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=59da38148f3a3d24
dashboard link: https://syzkaller.appspot.com/bug?extid=d8f76778263ab65c2b21
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13a613ba580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-74fe02ce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c0a591d96864/vmlinux-74fe02ce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f94fb623cd1/bzImage-74fe02ce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d8f76778263ab65c2b21@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000d: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000068-0x000000000000006f]
CPU: 3 UID: 0 PID: 5986 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c ff e0
RSP: 0018:ffffc9000391f180 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff88802a2a0040 RCX: ffffffff8b8b72bd
RDX: 000000000000000d RSI: ffffffff89553b32 RDI: 0000000000000068
RBP: 0000000000000002 R08: 0000000000000001 R09: fffff52000723dfc
R10: ffffc9000391efe7 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880311b8000 R14: 0000000000000002 R15: 0000000000000018
FS:  00007f602d1fe6c0(0000) GS:ffff8880d6675000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c522a6000 CR3: 000000002e99e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 udp_tunnel_sock_release+0x68/0x80 net/ipv4/udp_tunnel_core.c:202
 rxe_release_udp_tunnel drivers/infiniband/sw/rxe/rxe_net.c:294 [inline]
 rxe_sock_put+0xae/0x130 drivers/infiniband/sw/rxe/rxe_net.c:639
 rxe_net_del+0x83/0x120 drivers/infiniband/sw/rxe/rxe_net.c:660
 rxe_dellink+0x15/0x20 drivers/infiniband/sw/rxe/rxe.c:254
 nldev_dellink+0x289/0x3c0 drivers/infiniband/core/nldev.c:1849
 rdma_nl_rcv_msg+0x392/0x6f0 drivers/infiniband/core/netlink.c:195
 rdma_nl_rcv_skb.constprop.0.isra.0+0x2cb/0x410 drivers/infiniband/core/netlink.c:239
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x585/0x850 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x8b0/0xda0 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg net/socket.c:802 [inline]
 ____sys_sendmsg+0x9e1/0xb70 net/socket.c:2698
 ___sys_sendmsg+0x190/0x1e0 net/socket.c:2752
 __sys_sendmsg+0x170/0x220 net/socket.c:2784
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x10b/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f602db9cdd9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f602d1fe028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f602de16090 RCX: 00007f602db9cdd9
RDX: 0000000000000000 RSI: 00002000000002c0 RDI: 0000000000000007
RBP: 00007f602dc32d69 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f602de16128 R14: 00007f602de16090 R15: 00007ffc1d89c428
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernel_sock_shutdown+0x47/0x70 net/socket.c:3785
Code: fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 33 48 b8 00 00 00 00 00 fc ff df 4c 8b 63 20 49 8d 7c 24 68 48 89 fa 48 c1 ea 03 <80> 3c 02 00 75 1a 49 8b 44 24 68 89 ee 48 89 df 5b 5d 41 5c ff e0
RSP: 0018:ffffc9000391f180 EFLAGS: 00010202

RAX: dffffc0000000000 RBX: ffff88802a2a0040 RCX: ffffffff8b8b72bd
RDX: 000000000000000d RSI: ffffffff89553b32 RDI: 0000000000000068
RBP: 0000000000000002 R08: 0000000000000001 R09: fffff52000723dfc
R10: ffffc9000391efe7 R11: 0000000000000000 R12: 0000000000000000
R13: ffff8880311b8000 R14: 0000000000000002 R15: 0000000000000018
FS:  00007f602d1fe6c0(0000) GS:ffff8880d6675000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561c522a6000 CR3: 000000002e99e000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	fc                   	cld
   1:	ff                   	lcall  (bad)
   2:	df 48 89             	fisttps -0x77(%rax)
   5:	fa                   	cli
   6:	48 c1 ea 03          	shr    $0x3,%rdx
   a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   e:	75 33                	jne    0x43
  10:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  17:	fc ff df
  1a:	4c 8b 63 20          	mov    0x20(%rbx),%r12
  1e:	49 8d 7c 24 68       	lea    0x68(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	75 1a                	jne    0x4a
  30:	49 8b 44 24 68       	mov    0x68(%r12),%rax
  35:	89 ee                	mov    %ebp,%esi
  37:	48 89 df             	mov    %rbx,%rdi
  3a:	5b                   	pop    %rbx
  3b:	5d                   	pop    %rbp
  3c:	41 5c                	pop    %r12
  3e:	ff e0                	jmp    *%rax


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

