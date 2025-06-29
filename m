Return-Path: <linux-rdma+bounces-11733-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F4A6AECCF6
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 15:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E8DB1894023
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 13:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BBB6220F37;
	Sun, 29 Jun 2025 13:52:07 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A2720A5EC
	for <linux-rdma@vger.kernel.org>; Sun, 29 Jun 2025 13:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751205127; cv=none; b=fuw6KPVpACCQoHyUfd8l36X0p2KAAnBFnb7OhGFDlyicdxqc09bot2o4LWARiUO2PUrJWvrzDyDrt7tSzfUpIM+0SvKKspzGDmds3r06k5tdpFy/pn83IHexvr7mqz0FBZNYABv3OaZtiI9gH3GFFm6dGvu6F1AA/pbLd9VQcDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751205127; c=relaxed/simple;
	bh=wTU93lkVicbIM8Sjk8+dhMmLKxe6XRkyeROuL5ICWNA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YSC6ToI5G7s/XKH8KFwZw94la9jDi9TNNK+WcDjF0pJGUUr28gZrS352RhQZM0GyauoLzoAzU/q34u21Kjqpxv7DugZTLXQFepiQ1VILqOddVrx/8kg5JofniOG1k+kobSZ/sFHsRLAC7J4D55wwvt6Thvb1zazAb8p0OswI2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so43503555ab.1
        for <linux-rdma@vger.kernel.org>; Sun, 29 Jun 2025 06:52:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751205124; x=1751809924;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=30Tbiw0hGkGJ+ZRbb+lh7FwxkPU+mvSzx5Jx6ZtM/Uw=;
        b=iIkXjPWt8KeGkv+04To3MckkmaELSKO9r2+/woKoWNU2h26+0x9P6R5yklYicIZdCX
         wuvOM02I/ea8nz5qI0iNrvzxBThg3SAc+YKRleHm7vGIzFC6VPcy/u7EZqNqe3Krkvud
         ksvGoIxNkmAfh/ScRTG1hkB1bpuKW5Y/p36z4b+WJyQ7ufN5EuExWWl/8plLgYnhppIY
         VsQ+QU0Az759S/wL3SinTfH7oOIKhzDRqrF2NenH4wjPJ3fev7Vz5iqLp5rbaHju1Wwu
         3jeFvIG8t8t9oSklQVvzkDuv2C5xS8yuSlXgSNmAj9iD5Nue9EyOUWba+2QRBmzWvVYS
         eHtw==
X-Forwarded-Encrypted: i=1; AJvYcCV8988fYYleTIZy7KjVQ0KmkdmmLn0GSmQ2fdck0Xa0qDuKt6xbxdRtuDy5amxafxV9mLspsFvf3W2Y@vger.kernel.org
X-Gm-Message-State: AOJu0YwKZc8RggptqrH3xa3sx865x/2P0ONgOgFrgyihGQ1gFkkzm7KB
	NNEGh7vmApu6wpZ/DNbvb8YXUiktF7+SY/fPQZvQfVzGaX05x7D5fZjlp7jXDnV7ds9o4rW7EoU
	whHcLbwIP3nUM/n7f7xgMHEeku2RatrjmPsN5o9mIBMLNWD8H/8EU+ptmZCs=
X-Google-Smtp-Source: AGHT+IGgU9qvvZ/14xP0m938EssDUqZjWHnJHHRwbdDlm5WKCY127sBx437m9ZO/NETS+2P0wK52vtxVCW2Wp3rVhFl5h8Ex5MrQ
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c23:b0:3df:49b0:9331 with SMTP id
 e9e14a558f8ab-3df4ab56743mr125744645ab.4.1751205124583; Sun, 29 Jun 2025
 06:52:04 -0700 (PDT)
Date: Sun, 29 Jun 2025 06:52:04 -0700
In-Reply-To: <20250629132933.33599-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68614504.a70a0220.2f4de1.001d.GAE@google.com>
Subject: Re: [syzbot] [smc?] KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
From: syzbot <syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, contact@arnaud-lcm.com, 
	davem@davemloft.net, edumazet@google.com, guwen@linux.alibaba.com, 
	horms@kernel.org, jaka@linux.ibm.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
	linux-s390@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in inet_child_forget

======================================================
WARNING: possible circular locking dependency detected
6.16.0-rc3-syzkaller-00329-gdfba48a70cb6-dirty #0 Not tainted
------------------------------------------------------
syz.3.22/6775 is trying to acquire lock:
ffff888031981170 (k-clock-AF_INET6){++.-}-{3:3}, at: sock_orphan include/net/sock.h:2075 [inline]
ffff888031981170 (k-clock-AF_INET6){++.-}-{3:3}, at: inet_child_forget+0x7e/0x2e0 net/ipv4/inet_connection_sock.c:1383

but task is already holding lock:
ffff888031980f58 (k-slock-AF_INET6){+.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
ffff888031980f58 (k-slock-AF_INET6){+.-.}-{3:3}, at: inet_csk_listen_stop+0x203/0x1090 net/ipv4/inet_connection_sock.c:1495

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (k-slock-AF_INET6){+.-.}-{3:3}:
       __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
       _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
       spin_lock include/linux/spinlock.h:351 [inline]
       sk_clone_lock+0x334/0x1330 net/core/sock.c:2499
       inet_csk_clone_lock+0x2a/0x750 net/ipv4/inet_connection_sock.c:1232
       tcp_create_openreq_child+0x34/0x1980 net/ipv4/tcp_minisocks.c:526
       tcp_v4_syn_recv_sock+0x115/0x1250 net/ipv4/tcp_ipv4.c:1774
       tcp_v6_syn_recv_sock+0x1353/0x2480 net/ipv6/tcp_ipv6.c:1382
       smc_tcp_syn_recv_sock+0x24b/0x500 net/smc/af_smc.c:144
       tcp_check_req+0x69d/0x1f80 net/ipv4/tcp_minisocks.c:874
       tcp_v4_rcv+0x19b0/0x4650 net/ipv4/tcp_ipv4.c:2283
       ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
       ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
       NF_HOOK include/linux/netfilter.h:317 [inline]
       NF_HOOK include/linux/netfilter.h:311 [inline]
       ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
       dst_input include/net/dst.h:469 [inline]
       ip_rcv_finish net/ipv4/ip_input.c:447 [inline]
       NF_HOOK include/linux/netfilter.h:317 [inline]
       NF_HOOK include/linux/netfilter.h:311 [inline]
       ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:567
       __netif_receive_skb_one_core+0x197/0x1e0 net/core/dev.c:5977
       __netif_receive_skb+0x1d/0x160 net/core/dev.c:6090
       process_backlog+0x442/0x15e0 net/core/dev.c:6442
       __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7414
       napi_poll net/core/dev.c:7478 [inline]
       net_rx_action+0xa9f/0xfe0 net/core/dev.c:7605
       handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
       do_softirq kernel/softirq.c:480 [inline]
       do_softirq+0xb2/0xf0 kernel/softirq.c:467
       __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:407
       local_bh_enable include/linux/bottom_half.h:33 [inline]
       rcu_read_unlock_bh include/linux/rcupdate.h:910 [inline]
       __dev_queue_xmit+0x8ab/0x43e0 net/core/dev.c:4740
       dev_queue_xmit include/linux/netdevice.h:3355 [inline]
       neigh_hh_output include/net/neighbour.h:523 [inline]
       neigh_output include/net/neighbour.h:537 [inline]
       ip_finish_output2+0xc38/0x21a0 net/ipv4/ip_output.c:235
       __ip_finish_output net/ipv4/ip_output.c:313 [inline]
       __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:295
       ip_finish_output+0x35/0x380 net/ipv4/ip_output.c:323
       NF_HOOK_COND include/linux/netfilter.h:306 [inline]
       ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:433
       dst_output include/net/dst.h:459 [inline]
       ip_local_out net/ipv4/ip_output.c:129 [inline]
       __ip_queue_xmit+0x1d7d/0x26c0 net/ipv4/ip_output.c:527
       __tcp_transmit_skb+0x2686/0x3e90 net/ipv4/tcp_output.c:1479
       __tcp_send_ack.part.0+0x3de/0x700 net/ipv4/tcp_output.c:4279
       __tcp_send_ack net/ipv4/tcp_output.c:4285 [inline]
       tcp_send_ack+0x84/0xa0 net/ipv4/tcp_output.c:4285
       tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6632 [inline]
       tcp_rcv_state_process+0x4236/0x4ed0 net/ipv4/tcp_input.c:6826
       tcp_v4_do_rcv+0x1ad/0xa90 net/ipv4/tcp_ipv4.c:1948
       sk_backlog_rcv include/net/sock.h:1148 [inline]
       __release_sock+0x31b/0x400 net/core/sock.c:3213
       release_sock+0x5a/0x220 net/core/sock.c:3767
       mptcp_connect+0xccd/0xfe0 net/mptcp/protocol.c:3695
       __inet_stream_connect+0x3c8/0x1020 net/ipv4/af_inet.c:677
       inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:748
       __sys_connect_file+0x141/0x1a0 net/socket.c:2038
       __sys_connect+0x13b/0x160 net/socket.c:2057
       __do_sys_connect net/socket.c:2063 [inline]
       __se_sys_connect net/socket.c:2060 [inline]
       __x64_sys_connect+0x72/0xb0 net/socket.c:2060
       do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
       do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (k-clock-AF_INET6){++.-}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3168 [inline]
       check_prevs_add kernel/locking/lockdep.c:3287 [inline]
       validate_chain kernel/locking/lockdep.c:3911 [inline]
       __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
       lock_acquire kernel/locking/lockdep.c:5871 [inline]
       lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
       __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
       _raw_write_lock_bh+0x33/0x40 kernel/locking/spinlock.c:334
       sock_orphan include/net/sock.h:2075 [inline]
       inet_child_forget+0x7e/0x2e0 net/ipv4/inet_connection_sock.c:1383
       inet_csk_listen_stop+0x323/0x1090 net/ipv4/inet_connection_sock.c:1523
       tcp_disconnect+0x18a4/0x1ec0 net/ipv4/tcp.c:3340
       inet_shutdown+0x26f/0x440 net/ipv4/af_inet.c:935
       smc_close_active+0xc2a/0x1070 net/smc/smc_close.c:223
       __smc_release+0x634/0x880 net/smc/af_smc.c:282
       smc_release+0x1fc/0x5f0 net/smc/af_smc.c:349
       __sock_release+0xb3/0x270 net/socket.c:647
       sock_close+0x1c/0x30 net/socket.c:1391
       __fput+0x402/0xb70 fs/file_table.c:465
       task_work_run+0x150/0x240 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
       exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
       syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
       syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
       do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(k-slock-AF_INET6);
                               lock(k-clock-AF_INET6);
                               lock(k-slock-AF_INET6);
  lock(k-clock-AF_INET6);

 *** DEADLOCK ***

4 locks held by syz.3.22/6775:
 #0: ffff888056c4b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:869 [inline]
 #0: ffff888056c4b808 (&sb->s_type->i_mutex_key#11){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:646
 #1: ffff8880316dc758 (sk_lock-AF_SMC/1){+.+.}-{0:0}, at: smc_release+0x378/0x5f0 net/smc/af_smc.c:341
 #2: ffff888031983858 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1667 [inline]
 #2: ffff888031983858 (k-sk_lock-AF_INET6){+.+.}-{0:0}, at: inet_shutdown+0x67/0x440 net/ipv4/af_inet.c:905
 #3: ffff888031980f58 (k-slock-AF_INET6){+.-.}-{3:3}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #3: ffff888031980f58 (k-slock-AF_INET6){+.-.}-{3:3}, at: inet_csk_listen_stop+0x203/0x1090 net/ipv4/inet_connection_sock.c:1495

stack backtrace:
CPU: 0 UID: 0 PID: 6775 Comm: syz.3.22 Not tainted 6.16.0-rc3-syzkaller-00329-gdfba48a70cb6-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x275/0x350 kernel/locking/lockdep.c:2046
 check_noncircular+0x14c/0x170 kernel/locking/lockdep.c:2178
 check_prev_add kernel/locking/lockdep.c:3168 [inline]
 check_prevs_add kernel/locking/lockdep.c:3287 [inline]
 validate_chain kernel/locking/lockdep.c:3911 [inline]
 __lock_acquire+0x126f/0x1c90 kernel/locking/lockdep.c:5240
 lock_acquire kernel/locking/lockdep.c:5871 [inline]
 lock_acquire+0x179/0x350 kernel/locking/lockdep.c:5828
 __raw_write_lock_bh include/linux/rwlock_api_smp.h:202 [inline]
 _raw_write_lock_bh+0x33/0x40 kernel/locking/spinlock.c:334
 sock_orphan include/net/sock.h:2075 [inline]
 inet_child_forget+0x7e/0x2e0 net/ipv4/inet_connection_sock.c:1383
 inet_csk_listen_stop+0x323/0x1090 net/ipv4/inet_connection_sock.c:1523
 tcp_disconnect+0x18a4/0x1ec0 net/ipv4/tcp.c:3340
 inet_shutdown+0x26f/0x440 net/ipv4/af_inet.c:935
 smc_close_active+0xc2a/0x1070 net/smc/smc_close.c:223
 __smc_release+0x634/0x880 net/smc/af_smc.c:282
 smc_release+0x1fc/0x5f0 net/smc/af_smc.c:349
 __sock_release+0xb3/0x270 net/socket.c:647
 sock_close+0x1c/0x30 net/socket.c:1391
 __fput+0x402/0xb70 fs/file_table.c:465
 task_work_run+0x150/0x240 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xeb/0x110 kernel/entry/common.c:114
 exit_to_user_mode_prepare include/linux/entry-common.h:330 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:414 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:449 [inline]
 do_syscall_64+0x3f6/0x4c0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe73c37e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe73d091038 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007fe73c535f80 RCX: 00007fe73c37e719
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000003
RBP: 00007fe73c3f132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe73c535f80 R15: 00007fff230025e8
 </TASK>


Tested on:

commit:         dfba48a7 Merge tag 'i2c-for-6.16-rc4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ce688c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3e0d55231e0c89c
dashboard link: https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1124c770580000


