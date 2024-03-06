Return-Path: <linux-rdma+bounces-1301-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDA4874376
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 00:06:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1F71F26AD3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Mar 2024 23:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACA881C68F;
	Wed,  6 Mar 2024 23:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ORt4Aiw4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79BCB1B94D;
	Wed,  6 Mar 2024 23:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766365; cv=none; b=F/cgUqtHloHyuYYGLaclGCVROKzKTSs2RgQpkT6oBiya3Swdrq/O2g287xniSDV2BCib00lu7KhAOGDDtiEMpzlRs7hg1QhYJbok3uefi27YR2d98yeOIKJxYlj/K1/OqFjEqTBACaiK9n0TaepCP6go3sWNyoJjejxwsS7bEPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766365; c=relaxed/simple;
	bh=IEeymUNg0v7y9Xw4PkshSYaM4y01685Npml10B9mlYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ifgy7tPhPztODTR1rb/gA1IrmcFt7vZ50zXWyP7oR3NabALMu1hLBToVWBwQdEsw9Nk6LsWJEmheeHXLRcbcamfKq7HQtJIroHICtlWg6Dtkawb8N6j89gyiYgmt1oXeW+Xogt930Qv9ebcVCpTfmOdQbhXwBmsmAG1oOckUvxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ORt4Aiw4; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1709766364; x=1741302364;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QJ4LTZl/2PMOY7UZIWHghK8GMXnzP+GXzm2glwDUwS0=;
  b=ORt4Aiw4cpDrGzX34MWdfEQAM9uOsXctJzLxm3xyBayzCFZmEomQSp3s
   KiClCIDRQy8HXZ/DhfnUcINVT3Ib30oFSCk3Hw8IxfdJUIgzPumnkrnlu
   CG+qWI5MFyKdTYxf2PbIQ0tUG4lDe35pjrDGhXnN0d3MNrxiGutqcAhQE
   k=;
X-IronPort-AV: E=Sophos;i="6.06,209,1705363200"; 
   d="scan'208";a="189780791"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 23:06:01 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:52793]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.183:2525] with esmtp (Farcaster)
 id c103ad5d-df13-462c-b262-1f10d7e282c8; Wed, 6 Mar 2024 23:06:00 +0000 (UTC)
X-Farcaster-Flow-ID: c103ad5d-df13-462c-b262-1f10d7e282c8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 23:06:00 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.26) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 6 Mar 2024 23:05:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Allison Henderson <allison.henderson@oracle.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>, <linux-rdma@vger.kernel.org>,
	<rds-devel@oss.oracle.com>, syzkaller <syzkaller@googlegroups.com>
Subject: [PATCH v3 net 2/2] rds: tcp: Fix use-after-free of net in reqsk_timer_handler().
Date: Wed, 6 Mar 2024 15:04:58 -0800
Message-ID: <20240306230458.28784-3-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240306230458.28784-1-kuniyu@amazon.com>
References: <20240306230458.28784-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
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
inet_twsk_purge()") fixed this issue only for per-netns ehash.

Let's apply the same fix for the global ehash.

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
 net/ipv4/inet_timewait_sock.c | 2 +-
 net/ipv4/tcp_minisocks.c      | 4 ----
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/ipv4/inet_timewait_sock.c b/net/ipv4/inet_timewait_sock.c
index 00cbebaa2c68..961b1917c3eb 100644
--- a/net/ipv4/inet_timewait_sock.c
+++ b/net/ipv4/inet_timewait_sock.c
@@ -283,7 +283,7 @@ void inet_twsk_purge(struct inet_hashinfo *hashinfo, int family)
 				 * freed.  Userspace listener and reqsk never exist here.
 				 */
 				if (unlikely(sk->sk_state == TCP_NEW_SYN_RECV &&
-					     hashinfo->pernet)) {
+					     !refcount_read(&sock_net(sk)->ns.count))) {
 					struct request_sock *req = inet_reqsk(sk);
 
 					inet_csk_reqsk_queue_drop_and_put(req->rsk_listener, req);
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 9e85f2a0bddd..0ecc7311dc6c 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -398,10 +398,6 @@ void tcp_twsk_purge(struct list_head *net_exit_list, int family)
 			/* Even if tw_refcount == 1, we must clean up kernel reqsk */
 			inet_twsk_purge(net->ipv4.tcp_death_row.hashinfo, family);
 		} else if (!purged_once) {
-			/* The last refcount is decremented in tcp_sk_exit_batch() */
-			if (refcount_read(&net->ipv4.tcp_death_row.tw_refcount) == 1)
-				continue;
-
 			inet_twsk_purge(&tcp_hashinfo, family);
 			purged_once = true;
 		}
-- 
2.30.2


