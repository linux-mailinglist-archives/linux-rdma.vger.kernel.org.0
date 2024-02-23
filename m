Return-Path: <linux-rdma+bounces-1114-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA38619A4
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 18:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59FFC1F26DA9
	for <lists+linux-rdma@lfdr.de>; Fri, 23 Feb 2024 17:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACAD13A862;
	Fri, 23 Feb 2024 17:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BABycqrm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F14720DF8;
	Fri, 23 Feb 2024 17:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708709167; cv=none; b=oaL1lKv+cHdLtCZr6cYSE9LkVWVSV+6pncK3cRkMlkcIcqOwsKWOgIo/hlNJ2FyVguFMAF4tQ0tZ7yyOELIJ8koxSSkDQaCh1hQv24Rcg8jSeKwECSxpyL8d7YhhARHETsvPFERbo7EoWEIb/AQmojkzdW4vVE4O/3L8tuQg2is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708709167; c=relaxed/simple;
	bh=7fed7ePXHCkzI4CFJ5+VUwNztvIdR0Yb/YSif4y8Ddw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tO99U7Z1wBgcRnl2ijCm1unbgqSpE5gUeRx07A34NLUT49dyv/dobowiR+GVmNLMTLHcaq5FTjDzTdyqBGIKsNvhbckjvk34njFOl6CqaKHXzRCOv7WY3bcAEapXtM1a3nO9bIay9K4gjATw5iVbu6xO2s1P/pT1afQzlN7tYb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BABycqrm; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1708709165; x=1740245165;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Hu0uLmoy54JYHokYsSpP8/4WedLN2zGC+4CnLikdlrY=;
  b=BABycqrmlmM8jFQjKPvaKEeK1vg6gvetF6G5atdTmcssOzMHEQjHoAgF
   VDYsRkKu8A4PLIIl1HXpZ/kJBbMsMndB1VhvZ7WrH/k7FRt5GBJj8MQyE
   iB6cF3fDzWVB6PfdojuzOc1pL+mcPyV6lesiGwAJzvrZS8HVXKzKw/6e2
   k=;
X-IronPort-AV: E=Sophos;i="6.06,180,1705363200"; 
   d="scan'208";a="636375394"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 17:26:02 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:29814]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.23.221:2525] with esmtp (Farcaster)
 id 77113ec9-ab22-4ea5-8b69-a3a0fea2ef69; Fri, 23 Feb 2024 17:26:00 +0000 (UTC)
X-Farcaster-Flow-ID: 77113ec9-ab22-4ea5-8b69-a3a0fea2ef69
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 17:25:59 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.9) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 17:25:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Sowmini Varadhan <sowmini.varadhan@oracle.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v1 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Fri, 23 Feb 2024 09:24:48 -0800
Message-ID: <20240223172448.94084-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240223172448.94084-1-kuniyu@amazon.com>
References: <20240223172448.94084-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
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

Instead of iterating potentially large ehash and purging reqsk during
netns dismantle, let's hold netns refcount for the kernel TCP listener.

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
Fixes: 467fa15356ac ("RDS-TCP: Support multiple RDS-TCP listen endpoints, one per netns.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/rds/tcp_listen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 05008ce5c421..4f7863932df7 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -282,6 +282,11 @@ struct socket *rds_tcp_listen_init(struct net *net, bool isv6)
 		goto out;
 	}
 
+	__netns_tracker_free(net, &sock->sk->ns_tracker, false);
+	sock->sk->sk_net_refcnt = 1;
+	get_net_track(net, &sock->sk->ns_tracker, GFP_KERNEL);
+	sock_inuse_add(net, 1);
+
 	sock->sk->sk_reuse = SK_CAN_REUSE;
 	tcp_sock_set_nodelay(sock->sk);
 
-- 
2.30.2


