Return-Path: <linux-rdma+bounces-9199-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93530A7E7D6
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 19:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6978E17623C
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Apr 2025 17:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18282153C2;
	Mon,  7 Apr 2025 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sq3s+rk6"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C7B207A03;
	Mon,  7 Apr 2025 17:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744045440; cv=none; b=WaOgDiVGdh5H1flrkhSs80UL5AhacwVqo4oIzGjIEvubVnEKIP4SlLfLLJaBHv5cFtKYI+Kz17Y/PDCeui/Tr5l9Ztbg4MHRrR2e1C48WJzncgU4ZjzI+IsVlXlghPTTUoC33stegGuBaoBsf3wAxYhPG4YxIUeszr/zZlKNMwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744045440; c=relaxed/simple;
	bh=Mp1yJ4tQaA49XECOmMwKj1j4Tx3V9HD7po6FSE/blEY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=P/Eh0OIbKF6luN3TCXZe0bj3XmmBziGVShDXEkdOUMzSDWVCI9F4rF46lTBPLvvQkg21zgHQq57GnAgIB8qLD+HChTtfBkt54ueZm+qz1bIn5km/uYL5dOuDOt4p87Y7+pSuyuibpJm/KI+KjEcQ5fQDf2Y5EjigFjciBuXbmR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sq3s+rk6; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744045439; x=1775581439;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F8ybB3i7BUzxcSm+BToxCqOS5oDKkiPUMrL+zrXl/ac=;
  b=sq3s+rk6cLlDFJAOXPWohGBF3SX5oo/S0WIc9hImKgQztv05fKVRjQtg
   hCR6X8Vb8gZg2maZkz0L7fMX6vxU7As7+f8E72JcUHc9l7uwm/0p1kd2B
   lZaYh7Cn7fKRWD78i55veTVni6jJTJ5bkl3vC+WCsM2jgiBRvAgQJgXwq
   A=;
X-IronPort-AV: E=Sophos;i="6.15,194,1739836800"; 
   d="scan'208";a="509513703"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Apr 2025 17:03:49 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:44334]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.62.147:2525] with esmtp (Farcaster)
 id 35a3157d-b401-4f0c-902d-6a64e6513bac; Mon, 7 Apr 2025 17:03:47 +0000 (UTC)
X-Farcaster-Flow-ID: 35a3157d-b401-4f0c-902d-6a64e6513bac
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:03:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.101.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 7 Apr 2025 17:03:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Wenjia Zhang <wenjia@linux.ibm.com>, Jan Karcher <jaka@linux.ibm.com>, "D.
 Wythe" <alibuda@linux.alibaba.com>, Tony Lu <tonylu@linux.alibaba.com>, "Wen
 Gu" <guwen@linux.alibaba.com>, Dust Li <dust.li@linux.alibaba.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com>
Subject: [PATCH v1 net] smc: Fix lockdep false-positive for IPPROTO_SMC.
Date: Mon, 7 Apr 2025 10:03:17 -0700
Message-ID: <20250407170332.26959-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB002.ant.amazon.com (10.13.138.97) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

SMC consists of two sockets: smc_sock and kernel TCP socket.

Currently, there are two ways of creating the sockets, and syzbot reported
a lockdep splat [0] for the newer way introduced by commit d25a92ccae6b
("net/smc: Introduce IPPROTO_SMC").

  socket(AF_SMC             , SOCK_STREAM, SMCPROTO_SMC or SMCPROTO_SMC6)
  socket(AF_INET or AF_INET6, SOCK_STREAM, IPPROTO_SMC)

When a socket is allocated, sock_lock_init() sets a lockdep lock class to
sk->sk_lock.slock based on its protocol family.  In the IPPROTO_SMC case,
AF_INET or AF_INET6 lock class is assigned to smc_sock.

The repro sets IPV6_JOIN_ANYCAST for IPv6 UDP and SMC socket and exercises
smc_switch_to_fallback() for IPPROTO_SMC.

  1. smc_switch_to_fallback() is called under lock_sock() and holds
     smc->clcsock_release_lock.

      sk_lock-AF_INET6 -> &smc->clcsock_release_lock
      (sk_lock-AF_SMC)

  2. Setting IPV6_JOIN_ANYCAST to SMC holds smc->clcsock_release_lock
     and calls setsockopt() for the kernel TCP socket, which holds RTNL
     and the kernel socket's lock_sock().

      &smc->clcsock_release_lock -> rtnl_mutex (-> k-sk_lock-AF_INET6)

  3. Setting IPV6_JOIN_ANYCAST to UDP holds RTNL and lock_sock().

      rtnl_mutex -> sk_lock-AF_INET6

Then, lockdep detects a false-positive circular locking,

  .-> sk_lock-AF_INET6 -> &smc->clcsock_release_lock -> rtnl_mutex -.
  `-----------------------------------------------------------------'

but IPPROTO_SMC should have the same locking rule as AF_SMC.

      sk_lock-AF_SMC   -> &smc->clcsock_release_lock -> rtnl_mutex -> k-sk_lock-AF_INET6

Let's set the same lock class for smc_sock.

Given AF_SMC uses the same lock class for SMCPROTO_SMC and SMCPROTO_SMC6,
we do not need to separate the class for AF_INET and AF_INET6.

[0]:
WARNING: possible circular locking dependency detected
6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0 Not tainted

syz.4.1528/11571 is trying to acquire lock:
ffffffff8fef8de8 (rtnl_mutex){+.+.}-{4:4}, at: ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220

but task is already holding lock:
ffff888027f596a8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

 -> #2 (&smc->clcsock_release_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:903
       smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2781
       sock_sendmsg_nosec net/socket.c:718 [inline]
       __sock_sendmsg net/socket.c:733 [inline]
       ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
       __sys_sendmsg+0x16e/0x220 net/socket.c:2659
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3645
       lock_sock include/net/sock.h:1624 [inline]
       sockopt_lock_sock net/core/sock.c:1133 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1124
       do_ipv6_setsockopt+0x2160/0x4520 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
       udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1850
       do_sock_setsockopt+0x222/0x480 net/socket.c:2303
       __sys_setsockopt+0x1a0/0x230 net/socket.c:2328
       __do_sys_setsockopt net/socket.c:2334 [inline]
       __se_sys_setsockopt net/socket.c:2331 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2331
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

 -> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
       inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
       __sock_release net/socket.c:647 [inline]
       sock_release+0x8e/0x1d0 net/socket.c:675
       smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
       __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
       smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
       __sock_release+0xb0/0x270 net/socket.c:647
       sock_close+0x1c/0x30 net/socket.c:1398
       __fput+0x3ff/0xb70 fs/file_table.c:464
       task_work_run+0x14e/0x250 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET6 --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET6);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

2 locks held by syz.4.1528/11571:
 #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
 #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:646
 #1: ffff888027f596a8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30

stack backtrace:
CPU: 0 UID: 0 PID: 11571 Comm: syz.4.1528 Not tainted 6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain kernel/locking/lockdep.c:3906 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
 ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
 inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
 __sock_release net/socket.c:647 [inline]
 sock_release+0x8e/0x1d0 net/socket.c:675
 smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
 __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
 smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
 __sock_release+0xb0/0x270 net/socket.c:647
 sock_close+0x1c/0x30 net/socket.c:1398
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b4b38d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4efd22d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00000000000b14a3 RCX: 00007f8b4b38d169
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f8b4b5a7ba0 R08: 0000000000000001 R09: 000000114efd25cf
R10: 00007f8b4b200000 R11: 0000000000000246 R12: 00007f8b4b5a5fac
R13: 00007f8b4b5a5fa0 R14: ffffffffffffffff R15: 00007ffe4efd23f0
 </TASK>

Fixes: d25a92ccae6b ("net/smc: Introduce IPPROTO_SMC")
Reported-by: syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=be6f4b383534d88989f7
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/smc/af_smc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index 3e6cb35baf25..3760131f1484 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -362,6 +362,9 @@ static void smc_destruct(struct sock *sk)
 		return;
 }
 
+static struct lock_class_key smc_key;
+static struct lock_class_key smc_slock_key;
+
 void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 {
 	struct smc_sock *smc = smc_sk(sk);
@@ -375,6 +378,8 @@ void smc_sk_init(struct net *net, struct sock *sk, int protocol)
 	INIT_WORK(&smc->connect_work, smc_connect_work);
 	INIT_DELAYED_WORK(&smc->conn.tx_work, smc_tx_work);
 	INIT_LIST_HEAD(&smc->accept_q);
+	sock_lock_init_class_and_name(sk, "slock-AF_SMC", &smc_slock_key,
+				      "sk_lock-AF_SMC", &smc_key);
 	spin_lock_init(&smc->accept_q_lock);
 	spin_lock_init(&smc->conn.send_lock);
 	sk->sk_prot->hash(sk);
-- 
2.48.1


