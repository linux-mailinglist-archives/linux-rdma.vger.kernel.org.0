Return-Path: <linux-rdma+bounces-16629-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOI2KlunhWmYEgQAu9opvQ
	(envelope-from <linux-rdma+bounces-16629-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 09:33:31 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FD2FB8CB
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 09:33:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 498973010B9F
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 08:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF41A34A3A2;
	Fri,  6 Feb 2026 08:32:44 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com [209.85.160.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDDF349B0A
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770366764; cv=none; b=CQupWBCWsnVNo7e64bGBIdlGTTRn0OfJN6H6L1ASNdUJsDyCdM6/Z/+3S56s7LViWrtEB1VP1EYQSxabmlYH0skrDtzD/TY5kE+lMRw77mn4/HqsV8xtNKYvbksF1e1a6/8++jPOOxVzNQ+w85FN7TzgZ9mqhfMlvA1TP7B3VNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770366764; c=relaxed/simple;
	bh=yZcU9zqmWydFOpKqECr31syO3KL5FI1L7fu+fuKt0V0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=D6fP+l4EPIP1pse8G+fw73YRRv/JUFUWIIqN8xGtlQNIff0Yql9sLyfvWRBRqt9QbLxxhwE3RZS3/qUPOml2UBgtJZvr/YGY02jAT4Cf7Xe4m58r7EE638MrzvbP0rkvuwKHYPLtOb6LMT7O38NxU1mRFVJxNaZyUpXXO92+7dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-40a5fc701e9so6407336fac.1
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 00:32:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770366763; x=1770971563;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HGcULbifs2XydNzYSTlCyu/fOsNa5SM6If0TWsmBnX0=;
        b=mwUKsVHkvNvyA1vJbzeKmw9urT5Ur5csdKjS09sJZ7y14CsPKoQRYWDjjyhAWHJaMk
         AASvBecGox3cXM4tlOxELf7kh8c7CQQV910UNcd3ws7kFa77Iyk/XUna2PK/yBIakm1G
         hKxQGVNAmQwHNeQoP58lrEsBrkIO7GWC1bLfa9nxWKEaIcMqvEZxCXvCoDnQgmNGYymM
         GLsKeIFYhdvgiBFRV2QXeXpPtJVpl1DcbkYjgKdqTVJoPdbjNHxIrL5n1Lv691bFxYNV
         g5k4hJ8C9dco45DsLPSCFpKD7hJqnXkEDrtULk18fXIB2AYX26yq827qzggkH7eeXZd3
         ke/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVEPGPiZIRaLUIHhdCaEUW/a4tMj5WEBBOc7hVurCtZqAOm5jrcj7VH4FgXbxRYo09quenERoEr578d@vger.kernel.org
X-Gm-Message-State: AOJu0YxcZ8hjp2cgNPBpBaEidIwNdV93iK51+WZv+RpBzxKgvoIKsz2p
	FlKqowxDJTSrGQ73i1Y+IGg71AZjLvo+IVQbN9ARDm/K1kiBLlrbZmg7GMJTPTfnHJdS8QdbISk
	7maZgrMKEOwvCcYV8sIhj0MiBlGnbnuaLpRjQUKsfQch5x4yroZ9oidXplzQ=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f02a:b0:659:9a49:8efe with SMTP id
 006d021491bc7-66d09cb2ff0mr939322eaf.15.1770366763404; Fri, 06 Feb 2026
 00:32:43 -0800 (PST)
Date: Fri, 06 Feb 2026 00:32:43 -0800
In-Reply-To: <20260206022419.1357513-1-achender@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6985a72b.050a0220.3b3015.0035.GAE@google.com>
Subject: [syzbot ci] Re: net/rds: RDS-TCP reconnect and fanout improvements
From: syzbot ci <syzbot+ci858e84e8400d24b3@syzkaller.appspotmail.com>
To: achender@kernel.org, allison.henderson@oracle.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kselftest@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	rds-devel@oss.oracle.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,googlesource.com:url,syzbot.org:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,googlegroups.com:email];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-16629-lists,linux-rdma=lfdr.de,ci858e84e8400d24b3];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 38FD2FB8CB
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v1] net/rds: RDS-TCP reconnect and fanout improvements
https://lore.kernel.org/all/20260206022419.1357513-1-achender@kernel.org
* [PATCH net-next v1 1/3] net/rds: Delegate fan-out to a background worker
* [PATCH net-next v1 2/3] net/rds: Use proper peer port number even when not connected
* [PATCH net-next v1 3/3] net/rds: rds_sendmsg should not discard payload_len

and found the following issue:
BUG: sleeping function called from invalid context in rds_tcp_conn_free

Full report is available here:
https://ci.syzbot.org/series/1a5ef180-c02c-401d-9df7-670b18570a55

***

BUG: sleeping function called from invalid context in rds_tcp_conn_free

tree:      net-next
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net-next.git
base:      7a4cd71fa4514cd85df39b3cf99da8142660cdcd
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/77f47047-43cb-4c25-b0b6-73b8746cea2a/config
syz repro: https://ci.syzbot.org/findings/49698f1e-4f36-4446-9dd1-c409366e6296/syz_repro

BUG: sleeping function called from invalid context at kernel/workqueue.c:4390
in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 6005, name: syz.2.19
preempt_count: 1, expected: 0
RCU nest depth: 1, expected: 0
2 locks held by syz.2.19/6005:
 #0: ffffffff8e35a360 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e35a360 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e35a360 (rcu_read_lock){....}-{1:3}, at: __rds_conn_create+0x2e4/0x22d0 net/rds/connection.c:177
 #1: ffffffff8fa00a98 (rds_conn_lock){....}-{3:3}, at: __rds_conn_create+0x18e2/0x22d0 net/rds/connection.c:304
irq event stamp: 752
hardirqs last  enabled at (751): [<ffffffff8b7cc843>] __raw_spin_unlock_irq include/linux/spinlock_api_smp.h:159 [inline]
hardirqs last  enabled at (751): [<ffffffff8b7cc843>] _raw_spin_unlock_irq+0x23/0x50 kernel/locking/spinlock.c:202
hardirqs last disabled at (752): [<ffffffff8b7cc61a>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
hardirqs last disabled at (752): [<ffffffff8b7cc61a>] _raw_spin_lock_irqsave+0x1a/0x60 kernel/locking/spinlock.c:162
softirqs last  enabled at (32): [<ffffffff8ac0cd59>] rds_sendmsg+0x7b9/0x2150 net/rds/send.c:1266
softirqs last disabled at (30): [<ffffffff89463a1f>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (30): [<ffffffff89463a1f>] release_sock+0x2f/0x1f0 net/core/sock.c:3793
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 UID: 0 PID: 6005 Comm: syz.2.19 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 __might_resched+0x378/0x4d0 kernel/sched/core.c:8829
 __cancel_work_sync+0x6d/0x110 kernel/workqueue.c:4390
 rds_tcp_conn_free+0x2c/0x170 net/rds/tcp.c:361
 __rds_conn_create+0x1bfb/0x22d0 net/rds/connection.c:334
 rds_conn_create_outgoing+0x43/0x60 net/rds/connection.c:377
 rds_sendmsg+0xff5/0x2150 net/rds/send.c:1321
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 ____sys_sendmsg+0x4d7/0x810 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5b6bf9acb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f5b6cd8b028 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f5b6c216090 RCX: 00007f5b6bf9acb9
RDX: 0000000000000000 RSI: 0000200000000480 RDI: 0000000000000004
RBP: 00007f5b6c008bf7 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f5b6c216128 R14: 00007f5b6c216090 R15: 00007ffc17760058
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

