Return-Path: <linux-rdma+bounces-16685-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANQLGzkAimluFQAAu9opvQ
	(envelope-from <linux-rdma+bounces-16685-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 16:41:45 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C07112059
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Feb 2026 16:41:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF01B301584C
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Feb 2026 15:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2A2037FF50;
	Mon,  9 Feb 2026 15:41:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D122F5A1F
	for <linux-rdma@vger.kernel.org>; Mon,  9 Feb 2026 15:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770651684; cv=none; b=YOviOeLc5cfQQwb5FTQGsqlE+3uDvrwtACS2nWK9zOLjPGyQhgpBfjxgvHQ6V2PhpGNj+pF4bYWxtfA4QI40QeVWzG6ivq1gBwbvm8eWb+EeRftAxKrvRkFStJ1FimOc+EH70ekBbY+NxPRvYom6SkQT/EvBc/PxN3GiErs7cYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770651684; c=relaxed/simple;
	bh=ZafYOtc7L+oFFBIzl+MG4fPmt2i/qy2G91TqRC4LoLo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hAvtIbc1+yDUXsMcfXctcr1BVrYoTWTaBr+4PuGuxP8eSFUexSgjEKNula6a+k6S+IADu4cZZau85IesgWDwsGNvzz8b/s1ThN2PCSN4VdbsH4ZguV22qqv03/UtF+KdCgEI3OahfqKlAs8vGcOAo0LcZukorAikDWoMY7GYW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-409648bc2a2so17975130fac.3
        for <linux-rdma@vger.kernel.org>; Mon, 09 Feb 2026 07:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770651683; x=1771256483;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hNK9kU9v8v12Dojw7r/qw4vHBzF8h3GteZ5Hpo/f/ZE=;
        b=wJftwNe1QuQC5VrwKChXj5T/eYqBHvVVrbdCs55krmDoMupZvHLfyvdUEPEXmpy6Ec
         IkKEFyFBzR1y2erQuBrZLdzuxxzQCUG96dn5oTjOFjUtPwCNeo+4WYupDQpRhCHR5xEh
         H4wR2k6fgk5szofjRhYFdxLl+daHKdsvclNUbrZwMuGVFahbp/3L/U+lQHkr4bIOzEyd
         fmdoBMSOruphUH9z8NbD/ii+AjDOEXl6p3s1uSlgt6KQhO83cJzIVk7MzrQh2smF59dp
         EeDWsOi1ncKD9lOfmLn+QlJn/HLhmGPAOW73ESIoW+EURgECdLLDb6dJ/M1IuXsVcuyl
         +cHg==
X-Forwarded-Encrypted: i=1; AJvYcCUNV77V0YDd+2N0m3KMwOXUSVQbObhsN2e9sVC2qnx8kO+4bh94SIdfaVmg+XWvcLfdmiAls6QlIuu4@vger.kernel.org
X-Gm-Message-State: AOJu0YwRcGna2sIjhdrTEhku9a7LQaioaopVwh5xvNlLtZJInEsFAhaZ
	sh2URZaoI/sP5pq0wBefedpgFvbNLOja/uoYzAUcyG1E2Yexx2629aUsLeeANlui0LhO3/Qai35
	wSYYmm/UW6QrV20vigRCnZK9XBW3hmol648NhelXhiBkd06N2bdhjEhnb5yY=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:210b:b0:663:12f:215f with SMTP id
 006d021491bc7-66d09cb2a1cmr5054428eaf.15.1770651683338; Mon, 09 Feb 2026
 07:41:23 -0800 (PST)
Date: Mon, 09 Feb 2026 07:41:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <698a0023.050a0220.3b3015.0078.GAE@google.com>
Subject: [syzbot] [rds?] general protection fault in rds_tcp_accept_one
From: syzbot <syzbot+96046021045ffe6d7709@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rds-devel@oss.oracle.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=ac78ce3b6729749e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-16685-lists,linux-rdma=lfdr.de,96046021045ffe6d7709];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,googlegroups.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url]
X-Rspamd-Queue-Id: D3C07112059
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    9845cf73f7db Add linux-next specific files for 20260205
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=10ec4a5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac78ce3b6729749e
dashboard link: https://syzkaller.appspot.com/bug?extid=96046021045ffe6d7709
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=122acb22580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=149fc7fa580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9f30334a2431/disk-9845cf73.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0d58741a15a6/vmlinux-9845cf73.xz
kernel image: https://storage.googleapis.com/syzbot-assets/62204da1452c/bzImage-9845cf73.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+96046021045ffe6d7709@syzkaller.appspotmail.com

netdevsim netdevsim1 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 UID: 0 PID: 3485 Comm: kworker/u8:8 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: krdsd rds_tcp_accept_worker
RIP: 0010:rds_tcp_accept_one+0xa5b/0xd70 net/rds/tcp_listen.c:319
Code: 00 00 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 63 a9 2f f7 48 8b 1b 48 83 c3 12 49 89 de 49 c1 ee 03 <43> 0f b6 04 2e 84 c0 0f 85 53 02 00 00 44 0f b6 2b bf 08 00 00 00
RSP: 0018:ffffc9000b64f9a0 EFLAGS: 00010202
RAX: 1ffff1100dacb173 RBX: 0000000000000012 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8e006fa9 RDI: 00000000ffffffff
RBP: ffffc9000b64fb18 R08: ffffffff903342b7 R09: 1ffffffff2066856
R10: dffffc0000000000 R11: fffffbfff2066857 R12: ffff88803286c000
R13: dffffc0000000000 R14: 0000000000000002 R15: 1ffff920016c9f3c
FS:  0000000000000000(0000) GS:ffff888125115000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f30359456b8 CR3: 00000000320ee000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 rds_tcp_accept_worker+0x1d/0x70 net/rds/tcp.c:524
 process_one_work+0x949/0x1650 kernel/workqueue.c:3279
 process_scheduled_works kernel/workqueue.c:3362 [inline]
 worker_thread+0xb46/0x1140 kernel/workqueue.c:3443
 kthread+0x388/0x470 kernel/kthread.c:467
 ret_from_fork+0x51e/0xb90 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rds_tcp_accept_one+0xa5b/0xd70 net/rds/tcp_listen.c:319
Code: 00 00 48 83 c3 18 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 63 a9 2f f7 48 8b 1b 48 83 c3 12 49 89 de 49 c1 ee 03 <43> 0f b6 04 2e 84 c0 0f 85 53 02 00 00 44 0f b6 2b bf 08 00 00 00
RSP: 0018:ffffc9000b64f9a0 EFLAGS: 00010202
RAX: 1ffff1100dacb173 RBX: 0000000000000012 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8e006fa9 RDI: 00000000ffffffff
RBP: ffffc9000b64fb18 R08: ffffffff903342b7 R09: 1ffffffff2066856
R10: dffffc0000000000 R11: fffffbfff2066857 R12: ffff88803286c000
R13: dffffc0000000000 R14: 0000000000000002 R15: 1ffff920016c9f3c
FS:  0000000000000000(0000) GS:ffff888125115000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f303594da08 CR3: 000000000e74c000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	48 83 c3 18          	add    $0x18,%rbx
   6:	48 89 d8             	mov    %rbx,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  12:	74 08                	je     0x1c
  14:	48 89 df             	mov    %rbx,%rdi
  17:	e8 63 a9 2f f7       	call   0xf72fa97f
  1c:	48 8b 1b             	mov    (%rbx),%rbx
  1f:	48 83 c3 12          	add    $0x12,%rbx
  23:	49 89 de             	mov    %rbx,%r14
  26:	49 c1 ee 03          	shr    $0x3,%r14
* 2a:	43 0f b6 04 2e       	movzbl (%r14,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 53 02 00 00    	jne    0x28a
  37:	44 0f b6 2b          	movzbl (%rbx),%r13d
  3b:	bf 08 00 00 00       	mov    $0x8,%edi


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

