Return-Path: <linux-rdma+bounces-17920-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFU9NRWmsGnZlgIAu9opvQ
	(envelope-from <linux-rdma+bounces-17920-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 00:15:33 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E101E25933E
	for <lists+linux-rdma@lfdr.de>; Wed, 11 Mar 2026 00:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0F5A13018073
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2026 23:15:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5454B36B05F;
	Tue, 10 Mar 2026 23:15:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBE826ED25
	for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 23:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773184528; cv=none; b=ow3QZbQ9q8biZsOtFCxu/0h7qT/SKJOkLsqpWJPXEiLUKgw5nj9c5p9tDbzaFD/kQ4DFYQSJc+cLRi4duReRopZFItcooKnRqpYkAAFP07Vxflk2CrlWxBxLYx2PqOV8VjOa4WyN02qxBey+IkYIdRb0Eg+S5fh1zvPL1quql10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773184528; c=relaxed/simple;
	bh=jDPt2+axzf6QmW4X7Bq1ogLhr/VgUZUOuwu6w/7LA3Y=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=PDOwqngo+mxa5CpwNMhNQdCK0PHpPdnXFI0ZXk4MyikQWxbNCXnxHZk7/5EnZI4dTbzJSjD5YUEkJ5Cpnja0+O+gsiQwexONRNfJGJxBaU5PMN5pPDCDyejiyeZ5pzjcrJ7PloWjte8CrmbvUK08duoUuEGYiQgRu009N4V5Pzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-41701418411so30016009fac.1
        for <linux-rdma@vger.kernel.org>; Tue, 10 Mar 2026 16:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773184525; x=1773789325;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P2m7J15Rmijkxj/rodQsj2WND6I6uBKnU+578P4HG1Q=;
        b=Yz7reMAqw52J4jNzm6ME2YJ2xJkqLJkL1D0s9PdoLn1jTgFSD5osxipeWehKTo/4tq
         f9KlKSGbXd3R52Szp1twuK3Y+gzyOY1jP4WSNB8P3q0glMK+NpY/h+e8hIVovnt3KcIx
         kpeV7mmItqdc/tuTNQbGe8awr1SNctuq3p7RT40ZBNI07wQB/EW/HvxCA/e0Fpu0nGUL
         wBTx7xj9MREF46SOSVSELdg7ISOK7PrekBaNIjf02iD5C8ORpkjpeycjv/BwQFUD1GwH
         cfEBEe1WbAb4+90F+quyDxxsl4IgTW9GY96KhEwNoEQkUsZJ/RFGd5LMxamKiOn2M3+J
         HzQw==
X-Forwarded-Encrypted: i=1; AJvYcCVCilPo8ec7o5sWaWzJHtLeNDn4l8M2Ko+RxSrXO5351TaGHWYqQpNhXtGwp6JXjY5GmBVe8VYBjlcK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn6btEoG0zN1PY8XIdBARAQFL5a0wjYk6xng8bH80+cPkXx05+
	g4RmQDDlVkJJ75KMY2wKyjVez+reWtYfqqKCq3pnsKfP9yit4rZ/Ja6p3DEw6QBp2UT3HIdc7w3
	VAh1oaL9wSijFF0CHuYmhYGHoWEybeFj59ND8ZLUcw7qBtEIvKaYa1133RD4=
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:460c:b0:67b:b7ff:e3b5 with SMTP id
 006d021491bc7-67bc89918f2mr338388eaf.42.1773184525685; Tue, 10 Mar 2026
 16:15:25 -0700 (PDT)
Date: Tue, 10 Mar 2026 16:15:25 -0700
In-Reply-To: <20260310120053.136594-1-jiayuan.chen@linux.dev>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b0a60d.a00a0220.3a1cd4.0002.GAE@google.com>
Subject: [syzbot ci] Re: net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
From: syzbot ci <syzbot+ci146b0afba6158e88@syzkaller.appspotmail.com>
To: alibuda@linux.alibaba.com, davem@davemloft.net, dust.li@linux.alibaba.com, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jiayuan.chen@linux.dev, jiayuan.chen@shopee.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, mjambigi@linux.ibm.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, sidraya@linux.ibm.com, syzbot@syzkaller.appspotmail.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: E101E25933E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlegroups.com:email,appspotmail.com:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.872];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-17920-lists,linux-rdma=lfdr.de,ci146b0afba6158e88];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[]
X-Rspamd-Action: no action

syzbot ci has tested the following series

[v3] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
https://lore.kernel.org/all/20260310120053.136594-1-jiayuan.chen@linux.dev
* [PATCH net v3] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

and found the following issues:
* WARNING: suspicious RCU usage in smc_fback_error_report
* WARNING: suspicious RCU usage in smc_fback_state_change
* WARNING: suspicious RCU usage in smc_fback_write_space

Full report is available here:
https://ci.syzbot.org/series/b6883213-02f6-437e-bb3b-09fc59b0534c

***

WARNING: suspicious RCU usage in smc_fback_error_report

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      73aefba4e2eb713cf7bc4ad83cfc9b5d4f966f6d
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/0ecfc74c-85c7-4a7b-8b09-d322ac9ea108/config
C repro:   https://ci.syzbot.org/findings/f8c698ca-41b9-4ced-953c-f6c3ee405ebc/c_repro
syz repro: https://ci.syzbot.org/findings/f8c698ca-41b9-4ced-953c-f6c3ee405ebc/syz_repro

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/net/sock.h:682 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz.0.17/5970:
 #0: ffff88811a1d1d60 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #0: ffff88811a1d1d60 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet_stream_connect+0x51/0xa0 net/ipv4/af_inet.c:749
 #1: ffff88811a1d1f08 (k-clock-AF_INET6){++..}-{3:3}, at: smc_fback_error_report+0x2d/0x140 net/smc/af_smc.c:900

stack backtrace:
CPU: 0 UID: 0 PID: 5970 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 __rcu_dereference_sk_user_data_with_flags include/net/sock.h:682 [inline]
 smc_clcsock_user_data net/smc/smc.h:345 [inline]
 smc_fback_error_report+0x135/0x140 net/smc/af_smc.c:901
 sk_error_report+0x48/0x2b0 net/core/sock.c:348
 tcp_disconnect+0x132c/0x1fa0 net/ipv4/tcp.c:3543
 __inet_stream_connect+0x32b/0xdd0 net/ipv4/af_inet.c:648
 inet_stream_connect+0x66/0xa0 net/ipv4/af_inet.c:750
 __sys_connect_file net/socket.c:2089 [inline]
 __sys_connect+0x312/0x450 net/socket.c:2108
 __do_sys_connect net/socket.c:2114 [inline]
 __se_sys_connect net/socket.c:2111 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2111
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7effcfd9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe9219fa18 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007effd0015fa0 RCX: 00007effcfd9c799
RDX: 000000000000000c RSI: 00002000000001c0 RDI: 0000000000000003
RBP: 00007effcfe32bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007effd0015fac R14: 00007effd0015fa0 R15: 00007effd0015fa0
 </TASK>


***

WARNING: suspicious RCU usage in smc_fback_state_change

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      73aefba4e2eb713cf7bc4ad83cfc9b5d4f966f6d
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/0ecfc74c-85c7-4a7b-8b09-d322ac9ea108/config
C repro:   https://ci.syzbot.org/findings/fb044c1b-44f5-483a-bb87-1aad71a75a03/c_repro
syz repro: https://ci.syzbot.org/findings/fb044c1b-44f5-483a-bb87-1aad71a75a03/syz_repro

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/net/sock.h:682 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by syz.0.17/5945:
 #0: ffff8881be8b0ee0 (sk_lock-AF_SMC){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #0: ffff8881be8b0ee0 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_sendmsg+0x52/0x4d0 net/smc/af_smc.c:2802
 #1: ffff8881b9f04360 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #1: ffff8881b9f04360 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg+0x21/0x50 net/ipv4/tcp.c:1464
 #2: ffff8881b9f04508 (k-clock-AF_INET){++..}-{3:3}, at: smc_fback_state_change+0x2d/0x140 net/smc/af_smc.c:864

stack backtrace:
CPU: 1 UID: 0 PID: 5945 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 __rcu_dereference_sk_user_data_with_flags include/net/sock.h:682 [inline]
 smc_clcsock_user_data net/smc/smc.h:345 [inline]
 smc_fback_state_change+0x135/0x140 net/smc/af_smc.c:865
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:7000 [inline]
 tcp_rcv_state_process+0x2b23/0x4810 net/ipv4/tcp_input.c:7215
 tcp_v4_do_rcv+0x6bb/0x1430 net/ipv4/tcp_ipv4.c:1907
 sk_backlog_rcv include/net/sock.h:1185 [inline]
 __release_sock+0x265/0x3a0 net/core/sock.c:3213
 release_sock+0x5f/0x1f0 net/core/sock.c:3795
 tcp_sendmsg+0x39/0x50 net/ipv4/tcp.c:1466
 smc_sendmsg+0x250/0x4d0 net/smc/af_smc.c:2823
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg net/socket.c:742 [inline]
 ____sys_sendmsg+0x972/0x9f0 net/socket.c:2592
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2646
 __sys_sendmsg net/socket.c:2678 [inline]
 __do_sys_sendmsg net/socket.c:2683 [inline]
 __se_sys_sendmsg net/socket.c:2681 [inline]
 __x64_sys_sendmsg+0x1bd/0x2a0 net/socket.c:2681
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9b66d9c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe630639c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f9b67015fa0 RCX: 00007f9b66d9c799
RDX: 00000000200048cc RSI: 0000200000000240 RDI: 0000000000000003
RBP: 00007f9b66e32bd9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f9b67015fac R14: 00007f9b67015fa0 R15: 00007f9b67015fa0
 </TASK>


***

WARNING: suspicious RCU usage in smc_fback_write_space

tree:      net
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
base:      73aefba4e2eb713cf7bc4ad83cfc9b5d4f966f6d
arch:      amd64
compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
config:    https://ci.syzbot.org/builds/0ecfc74c-85c7-4a7b-8b09-d322ac9ea108/config
C repro:   https://ci.syzbot.org/findings/a3f8aa1e-ebea-41f3-b6e4-97d45bc19aaf/c_repro
syz repro: https://ci.syzbot.org/findings/a3f8aa1e-ebea-41f3-b6e4-97d45bc19aaf/syz_repro

=============================
WARNING: suspicious RCU usage
syzkaller #0 Not tainted
-----------------------------
./include/net/sock.h:682 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
2 locks held by syz.0.17/5953:
 #0: ffff8881b9ed1c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1709 [inline]
 #0: ffff8881b9ed1c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: sockopt_lock_sock net/core/sock.c:1152 [inline]
 #0: ffff8881b9ed1c60 (k-sk_lock-AF_INET){+.+.}-{0:0}, at: sk_setsockopt+0xe62/0x2e80 net/core/sock.c:1310
 #1: ffff8881b9ed1e08 (k-clock-AF_INET){++..}-{3:3}, at: smc_fback_write_space+0x2d/0x140 net/smc/af_smc.c:888

stack backtrace:
CPU: 1 UID: 0 PID: 5953 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x13f/0x1d0 kernel/locking/lockdep.c:6876
 __rcu_dereference_sk_user_data_with_flags include/net/sock.h:682 [inline]
 smc_clcsock_user_data net/smc/smc.h:345 [inline]
 smc_fback_write_space+0x135/0x140 net/smc/af_smc.c:889
 sk_setsockopt+0x221f/0x2e80 net/core/sock.c:1351
 do_sock_setsockopt+0x11b/0x1b0 net/socket.c:2318
 __sys_setsockopt net/socket.c:2347 [inline]
 __do_sys_setsockopt net/socket.c:2353 [inline]
 __se_sys_setsockopt net/socket.c:2350 [inline]
 __x64_sys_setsockopt+0x13d/0x1b0 net/socket.c:2350
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0c5f39c799
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd35759278 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f0c5f615fa0 RCX: 00007f0c5f39c799
RDX: 0000000000000020 RSI: 0000000000000001 RDI: 0000000000000003
RBP: 00007f0c5f432bd9 R08: 0000000000000004 R09: 0000000000000000
R10: 0000200000000100 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f0c5f615fac R14: 00007f0c5f615fa0 R15: 00007f0c5f615fa0
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.

