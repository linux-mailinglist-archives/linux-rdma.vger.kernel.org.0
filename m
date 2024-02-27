Return-Path: <linux-rdma+bounces-1148-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3DD86859E
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 02:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7C88B2374F
	for <lists+linux-rdma@lfdr.de>; Tue, 27 Feb 2024 01:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF3CF4A29;
	Tue, 27 Feb 2024 01:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d9kEY3Eo"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C65A22916;
	Tue, 27 Feb 2024 01:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708996365; cv=none; b=oPt45iJEckVfpE/BbFHtWzg3KQCQLC5FEcR4pnZ+cUtEcm+UyzDPHGFLo9uSqPEslaEleJYzMcH8EQyJrdkUKfmp5/q4gTXmdl3lX9eTv/Gfq1BFYPP/mENrCB4udFnyh093C74oftnL2rJPtcnWZ4ZW6gKmdMcMsu2E+gnm0HQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708996365; c=relaxed/simple;
	bh=hEhfX717neP/XbOXoFNKl1HdG+lCiHfzvSniaM1QvvA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hcOnj2AZ1Q8FkCeejYme4y0dDdXJJWwK9N+kpFNRjdIC5ZzgdwQhPATMIc3engEhId7LfkJlWrzkwEFb/sgsDLlgJqX7bkR1GxJ/fFLuNTsFM33FDrmWQ7wz/n0pKsQUxI6UgFl6Qh6ceW9RZKAr3VcuLfzQ+W6ELphiJQd7e2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d9kEY3Eo; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708996365; x=1740532365;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TM92/DPMiES4drf9veDP2tNXPn/X3QYPrxvKLaPyVFs=;
  b=d9kEY3Eoavc1ZdzYQiZuN0F8p6UPTrg9BtwPOozG+vMJwiSOShGOn8c/
   kFZECqbQhlbD2X39PHtKHj8R94FD/tSt6j6LOVqoQM3pWC1e4PuH7Ry6a
   0qie2VSWpYff6u6ukCjn+Kmz0o2LDzcxj5AglvU9RafLRWTqaGNa8Px7a
   0=;
X-IronPort-AV: E=Sophos;i="6.06,187,1705363200"; 
   d="scan'208";a="389307606"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2024 01:12:41 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:63924]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.30.125:2525] with esmtp (Farcaster)
 id 83209d15-66dd-448b-b863-dd8208889c82; Tue, 27 Feb 2024 01:12:40 +0000 (UTC)
X-Farcaster-Flow-ID: 83209d15-66dd-448b-b863-dd8208889c82
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 27 Feb 2024 01:12:38 +0000
Received: from 88665a182662.ant.amazon.com.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 27 Feb 2024 01:12:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v2 net 4/5] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Mon, 26 Feb 2024 17:10:40 -0800
Message-ID: <20240227011041.97375-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240227011041.97375-1-kuniyu@amazon.com>
References: <20240227011041.97375-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC004.ant.amazon.com (10.13.139.254) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

syzkaller reported a warning of netns tracker [0] followed by KASAN
splat [1] and another ref tracker warning [1].

syzkaller could not find a repro, but in the log, the only suspicious
sequence was as follows:

  18:26:22 executing program 1:
  r0 = socket$inet6_mptcp(0xa, 0x1, 0x106)
  ...
  connect$inet6(r0, &(0x7f0000000080)={0xa, 0x4001, 0x0, @loopback}, 0x1c) (async)

The notable thing here is 0x4001 in connect(), which is RDS_TCP_PORT.

So, the scenario would be:

  1. unshare(CLONE_NEWNET) creates a per netns tcp listener in
      rds_tcp_listen_init().
  2. syz-executor connect()s to it and creates a reqsk.
  3. syz-executor exit()s immediately.
  4. netns is dismantled.  [0]
  5. reqsk timer is fired, and UAF happens while freeing reqsk.  [1]
  6. listener is freed after RCU grace period.  [2]

Basically, reqsk assumes that the listener guarantees netns safety
until all reqsk timers are expired by holding the listener's refcount.
However, this was not the case for kernel sockets.

Commit 740ea3c4a0b2 ("tcp: Clean up kernel listener's reqsk in
inet_twsk_purge()") fixed this issue only for per-netns ehash, but
the issue still exists for the global ehash.

We can apply the same fix, but this issue is specific to RDS.

Instead of iterating ehash and purging reqsk during netns dismantle,
let's hold netns refcount for the kernel listener.

[0]:
ref_tracker: net notrefcnt@0000000065449cc3 has 1/1 users at
     sk_alloc (./include/net/net_namespace.h:337 net/core/sock.c:2146)
     inet6_create (net/ipv6/af_inet6.c:192 net/ipv6/af_inet6.c:119)
     __sock_create (net/socket.c:1572)
     rds_tcp_listen_init (net/rds/tcp_listen.c:279)
     rds_tcp_init_net (net/rds/tcp.c:577)
     ops_init (net/core/net_namespace.c:137)
     setup_net (net/core/net_namespace.c:340)
     copy_net_ns (net/core/net_namespace.c:497)
     create_new_namespaces (kernel/nsproxy.c:110)
     unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
     ksys_unshare (kernel/fork.c:3429)
     __x64_sys_unshare (kernel/fork.c:3496)
     do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
     entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)
...
WARNING: CPU: 0 PID: 27 at lib/ref_tracker.c:179 ref_tracker_dir_exit (lib/ref_tracker.c:179)

[1]:
BUG: KASAN: slab-use-after-free in inet_csk_reqsk_queue_drop (./include/net/inet_hashtables.h:180 net/ipv4/inet_connection_sock.c:952 net/ipv4/inet_connection_sock.c:966)
Read of size 8 at addr ffff88801b370400 by task swapper/0/0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
Call Trace:
 <IRQ>
 dump_stack_lvl (lib/dump_stack.c:107 (discriminator 1))
 print_report (mm/kasan/report.c:378 mm/kasan/report.c:488)
 kasan_report (mm/kasan/report.c:603)
 inet_csk_reqsk_queue_drop (./include/net/inet_hashtables.h:180 net/ipv4/inet_connection_sock.c:952 net/ipv4/inet_connection_sock.c:966)
 reqsk_timer_handler (net/ipv4/inet_connection_sock.c:979 net/ipv4/inet_connection_sock.c:1092)
 call_timer_fn (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/timer.h:127 kernel/time/timer.c:1701)
 __run_timers.part.0 (kernel/time/timer.c:1752 kernel/time/timer.c:2038)
 run_timer_softirq (kernel/time/timer.c:2053)
 __do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
 irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14))
 </IRQ>

Allocated by task 258 on cpu 0 at 83.612050s:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:68)
 __kasan_slab_alloc (mm/kasan/common.c:343)
 kmem_cache_alloc (mm/slub.c:3813 mm/slub.c:3860 mm/slub.c:3867)
 copy_net_ns (./include/linux/slab.h:701 net/core/net_namespace.c:421 net/core/net_namespace.c:480)
 create_new_namespaces (kernel/nsproxy.c:110)
 unshare_nsproxy_namespaces (kernel/nsproxy.c:228 (discriminator 4))
 ksys_unshare (kernel/fork.c:3429)
 __x64_sys_unshare (kernel/fork.c:3496)
 do_syscall_64 (arch/x86/entry/common.c:52 arch/x86/entry/common.c:83)
 entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:129)

Freed by task 27 on cpu 0 at 329.158864s:
 kasan_save_stack (mm/kasan/common.c:48)
 kasan_save_track (mm/kasan/common.c:68)
 kasan_save_free_info (mm/kasan/generic.c:643)
 __kasan_slab_free (mm/kasan/common.c:265)
 kmem_cache_free (mm/slub.c:4299 mm/slub.c:4363)
 cleanup_net (net/core/net_namespace.c:456 net/core/net_namespace.c:446 net/core/net_namespace.c:639)
 process_one_work (kernel/workqueue.c:2638)
 worker_thread (kernel/workqueue.c:2700 kernel/workqueue.c:2787)
 kthread (kernel/kthread.c:388)
 ret_from_fork (arch/x86/kernel/process.c:153)
 ret_from_fork_asm (arch/x86/entry/entry_64.S:250)

The buggy address belongs to the object at ffff88801b370000
 which belongs to the cache net_namespace of size 4352
The buggy address is located 1024 bytes inside of
 freed 4352-byte region [ffff88801b370000, ffff88801b371100)

[2]:
WARNING: CPU: 0 PID: 95 at lib/ref_tracker.c:228 ref_tracker_free (lib/ref_tracker.c:228 (discriminator 1))
Modules linked in:
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
RIP: 0010:ref_tracker_free (lib/ref_tracker.c:228 (discriminator 1))
...
Call Trace:
<IRQ>
 __sk_destruct (./include/net/net_namespace.h:353 net/core/sock.c:2204)
 rcu_core (./arch/x86/include/asm/preempt.h:26 kernel/rcu/tree.c:2165 kernel/rcu/tree.c:2433)
 __do_softirq (./arch/x86/include/asm/jump_label.h:27 ./include/linux/jump_label.h:207 ./include/trace/events/irq.h:142 kernel/softirq.c:554)
 irq_exit_rcu (kernel/softirq.c:427 kernel/softirq.c:632 kernel/softirq.c:644)
 sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1076 (discriminator 14))
</IRQ>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/rds/tcp_listen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 05008ce5c421..2d40e523322c 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -274,8 +274,8 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 	int addr_len;
 	int ret;
 
-	ret = sock_create_kern(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
-			       IPPROTO_TCP, &sock);
+	ret = __sock_create(net, isv6 ? PF_INET6 : PF_INET, SOCK_STREAM,
+			    IPPROTO_TCP, &sock, SOCKET_KERN_NET_REF);
 	if (ret < 0) {
 		rdsdebug("could not create %s listener socket: %d\n",
 			 isv6 ? "IPv6" : "IPv4", ret);
-- 
2.30.2


