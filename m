Return-Path: <linux-rdma+bounces-14495-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E38C60889
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Nov 2025 17:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id C97812428E
	for <lists+linux-rdma@lfdr.de>; Sat, 15 Nov 2025 16:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D01DF27D;
	Sat, 15 Nov 2025 16:31:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DF281E1E00
	for <linux-rdma@vger.kernel.org>; Sat, 15 Nov 2025 16:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763224283; cv=none; b=FSWM3ZWIVdvQXrHHPcMrR6HRtSffRc4EnOXo7xXXvW33joBdSH33OY0ZFrsNehdItjobMo4WEArsoT/zbKYomTLiF1C1VeSyP+wbBAsemT5VUePkjxo2yiBej3uqGGBDIROg3deI4TuWAEvTiLUjzG9SU2cuHYwkaBYgk7ptpk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763224283; c=relaxed/simple;
	bh=TWQvIINaswKPWu1tgrEVqbMcZs+KA419++3kmB43XuU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j+F35aixS+Sl6QsZq8GC+GVMcbmyCcVtVQ3wRG6AeRQgGm6OBUo2cHK8KCETrYKg5qBynFofCxRK8YRP218TsQm1oUTGF2goPwMonbUcWmNo9oJmbygN9D43pH41X1Do+kdoe5B6/8+W0+DalZXXlx5bMw299Bv9mRJOMgssMGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43331ea8ed8so28955945ab.3
        for <linux-rdma@vger.kernel.org>; Sat, 15 Nov 2025 08:31:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763224280; x=1763829080;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gObGYVOeXiLjSXzoNnI5JIjGDVKD50rx4iXO4PEaljM=;
        b=W9eKI/adysK6jlI8jCnOp9LPgD7KQaDtfYyJOILKh/zaQ3HCArcbN01dMmozXCPW0L
         iOSDnImDx/Z5oImq/Q/tYS1SfAhjcKFXJq+JonkgUFesL9ZEAyc1MlCNH4RwlEEPx7aK
         LrqJ/gRV+w3zJPTV+Q9TFk9VxngfhBj6wuS8Eu2CeAY5TMtEkb33a8Yf95eswOiEznGP
         UKxHqc9tHm0t1hPV7h6DlZrPAGRdb+ttMWf1qJNa/pVJ1BknHrd3TJFuahoG+2c+f7Mw
         A0clyl6kNB8cQJA8SHQnVUlABjCElfjJ1pH/YLtqXGWJcQg2sSj3nAFt1fiR9MreILVe
         Mshg==
X-Forwarded-Encrypted: i=1; AJvYcCUPaK/OOjwotoysRGzLChtNNAaTAdPJeYFUhmgIWpoe9p+ZZp4eTGZnPYdk6oeW8DesVii6KDrrX7f0@vger.kernel.org
X-Gm-Message-State: AOJu0YzTWZpiYCK+s9N60r9/DyX/s2r0bneMtuiHzSoZ0fvUjwWcmCje
	Tgeiz4ZTJ5NrjXL3IxfFA8M9NQo5Ae7AdAASj4KWjJXRImjP252S2HNVQDmKFBcj7LuPMMxQ/A7
	S3nYzmuTjXaomHyF48y+0h6i0OQUnrhquct4uiGp2YsC1uO8m1tnrFN7OC1g=
X-Google-Smtp-Source: AGHT+IHWjb0KwlErCAvMDzgwfx0Ie1NVKorWr7p/8y/uYAv4qEJHPypHxmKDJFUOp9DK6n1YSTRP0tPzDyq6+4nDvRj4mzlVBKPW
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:730a:0:b0:434:96ea:ff5f with SMTP id
 e9e14a558f8ab-43496eb0125mr42170615ab.40.1763224280559; Sat, 15 Nov 2025
 08:31:20 -0800 (PST)
Date: Sat, 15 Nov 2025 08:31:20 -0800
In-Reply-To: <67eaf9b8.050a0220.3c3d88.004a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6918aad8.050a0220.1c914e.0042.GAE@google.com>
Subject: Re: [syzbot] [smc?] KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
From: syzbot <syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, contact@arnaud-lcm.com, 
	davem@davemloft.net, dust.li@linux.alibaba.com, edumazet@google.com, 
	guwen@linux.alibaba.com, hdanton@sina.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	mjambigi@linux.ibm.com, netdev@vger.kernel.org, pabeni@redhat.com, 
	richard120310@gmail.com, sidraya@linux.ibm.com, 
	syzkaller-bugs@googlegroups.com, tonylu@linux.alibaba.com, 
	wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    db9030a787e3 Merge remote-tracking branch 'will/for-next/p..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=167bc97c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fdc83aa8a8b9d1ae
dashboard link: https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10496884580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14da2692580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8932d8648ef5/disk-db9030a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8446b6e4ef5c/vmlinux-db9030a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/b17118b94e44/Image-db9030a7.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock+0x84/0x574 net/smc/af_smc.c:134
Read of size 4 at addr 0000000000000acc by task syz.0.42/6792

CPU: 1 UID: 0 PID: 6792 Comm: syz.0.42 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
Call trace:
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:499 (C)
 __dump_stack+0x30/0x40 lib/dump_stack.c:94
 dump_stack_lvl+0xd8/0x12c lib/dump_stack.c:120
 print_report+0x58/0x84 mm/kasan/report.c:485
 kasan_report+0xb0/0x110 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x264/0x2a4 mm/kasan/generic.c:200
 __kasan_check_read+0x20/0x30 mm/kasan/shadow.c:31
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 smc_tcp_syn_recv_sock+0x84/0x574 net/smc/af_smc.c:134
 tcp_check_req+0xf6c/0x18e8 net/ipv4/tcp_minisocks.c:912
 tcp_v6_rcv+0xf50/0x2460 net/ipv6/tcp_ipv6.c:1845
 ip6_protocol_deliver_rcu+0x9a4/0x12d4 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x154/0x350 net/ipv6/ip6_input.c:489
 NF_HOOK+0x2c4/0x358 include/linux/netfilter.h:318
 ip6_input+0x15c/0x270 net/ipv6/ip6_input.c:500
 dst_input include/net/dst.h:474 [inline]
 ip6_rcv_finish+0x1f0/0x21c net/ipv6/ip6_input.c:79
 NF_HOOK+0x2c4/0x358 include/linux/netfilter.h:318
 ipv6_rcv+0x9c/0xbc net/ipv6/ip6_input.c:311
 __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
 __netif_receive_skb+0xcc/0x2a8 net/core/dev.c:6192
 process_backlog+0x60c/0x10e4 net/core/dev.c:6544
 __napi_poll+0xb4/0x310 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x548/0xd00 net/core/dev.c:7784
 handle_softirqs+0x328/0xc88 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
 do_softirq+0x90/0xf8 kernel/softirq.c:523
 __local_bh_enable_ip+0x240/0x35c kernel/softirq.c:450
 local_bh_enable+0x28/0x34 include/linux/bottom_half.h:33
 rcu_read_unlock_bh include/linux/rcupdate.h:936 [inline]
 __dev_queue_xmit+0x17ac/0x32a8 net/core/dev.c:4790
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 neigh_hh_output include/net/neighbour.h:531 [inline]
 neigh_output include/net/neighbour.h:545 [inline]
 ip6_finish_output2+0x1150/0x1a78 net/ipv6/ip6_output.c:136
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x418/0x7b4 net/ipv6/ip6_output.c:220
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x2c8/0x640 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:464 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip6_xmit+0x1134/0x1a20 net/ipv6/ip6_output.c:371
 inet6_csk_xmit+0x454/0x66c net/ipv6/inet6_connection_sock.c:120
 __tcp_transmit_skb+0x1a34/0x3214 net/ipv4/tcp_output.c:1628
 tcp_transmit_skb net/ipv4/tcp_output.c:1646 [inline]
 tcp_write_xmit+0x159c/0x52a4 net/ipv4/tcp_output.c:2999
 __tcp_push_pending_frames net/ipv4/tcp_output.c:3182 [inline]
 tcp_send_fin+0x620/0xc08 net/ipv4/tcp_output.c:3800
 __tcp_close+0x558/0xf68 net/ipv4/tcp.c:3207
 tcp_close+0x38/0x144 net/ipv4/tcp.c:3298
 inet_release+0x154/0x1d0 net/ipv4/af_inet.c:437
 inet6_release+0x5c/0x78 net/ipv6/af_inet6.c:487
 __sock_release net/socket.c:662 [inline]
 sock_close+0xa0/0x1e4 net/socket.c:1455
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:81 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:725
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
==================================================================
Unable to handle kernel paging request at virtual address dfff800000000159
KASAN: null-ptr-deref in range [0x0000000000000ac8-0x0000000000000acf]
Mem abort info:
  ESR = 0x0000000096000005
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x05: level 1 translation fault
Data abort info:
  ISV = 0, ISS = 0x00000005, ISS2 = 0x00000000
  CM = 0, WnR = 0, TnD = 0, TagAccess = 0
  GCS = 0, Overlay = 0, DirtyBit = 0, Xs = 0
[dfff800000000159] address between user and kernel address ranges
Internal error: Oops: 0000000096000005 [#1]  SMP
Modules linked in:
CPU: 1 UID: 0 PID: 6792 Comm: syz.0.42 Tainted: G    B               syzkaller #0 PREEMPT 
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/03/2025
pstate: 43400005 (nZcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
pc : atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
pc : smc_tcp_syn_recv_sock+0x88/0x574 net/smc/af_smc.c:134
lr : instrument_atomic_read include/linux/instrumented.h:68 [inline]
lr : atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
lr : smc_tcp_syn_recv_sock+0x84/0x574 net/smc/af_smc.c:134
sp : ffff800097937340
x29: ffff800097937340 x28: 0000000000000000 x27: dfff800000000000
x26: 0000000000000000 x25: 0000000000000acc x24: ffff0000cdd47270
x23: ffff0000d72a7a00 x22: ffff0000d72a7a00 x21: ffff800097937480
x20: 0000000000000000 x19: ffff0000c7c80000 x18: 0000000000000000
x17: 3d3d3d3d3d3d3d3d x16: ffff800082debe40 x15: 0000000000000001
x14: 1ffff000125cd314 x13: 0000000000000000 x12: 0000000000000000
x11: ffff7000125cd315 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000159 x7 : 0000000000000001 x6 : ffff8000805653c0
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff8000803c084c
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline] (P)
 atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline] (P)
 smc_tcp_syn_recv_sock+0x88/0x574 net/smc/af_smc.c:134 (P)
 tcp_check_req+0xf6c/0x18e8 net/ipv4/tcp_minisocks.c:912
 tcp_v6_rcv+0xf50/0x2460 net/ipv6/tcp_ipv6.c:1845
 ip6_protocol_deliver_rcu+0x9a4/0x12d4 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x154/0x350 net/ipv6/ip6_input.c:489
 NF_HOOK+0x2c4/0x358 include/linux/netfilter.h:318
 ip6_input+0x15c/0x270 net/ipv6/ip6_input.c:500
 dst_input include/net/dst.h:474 [inline]
 ip6_rcv_finish+0x1f0/0x21c net/ipv6/ip6_input.c:79
 NF_HOOK+0x2c4/0x358 include/linux/netfilter.h:318
 ipv6_rcv+0x9c/0xbc net/ipv6/ip6_input.c:311
 __netif_receive_skb_one_core net/core/dev.c:6079 [inline]
 __netif_receive_skb+0xcc/0x2a8 net/core/dev.c:6192
 process_backlog+0x60c/0x10e4 net/core/dev.c:6544
 __napi_poll+0xb4/0x310 net/core/dev.c:7594
 napi_poll net/core/dev.c:7657 [inline]
 net_rx_action+0x548/0xd00 net/core/dev.c:7784
 handle_softirqs+0x328/0xc88 kernel/softirq.c:622
 __do_softirq+0x14/0x20 kernel/softirq.c:656
 ____do_softirq+0x14/0x20 arch/arm64/kernel/irq.c:68
 call_on_irq_stack+0x30/0x48 arch/arm64/kernel/entry.S:891
 do_softirq_own_stack+0x20/0x2c arch/arm64/kernel/irq.c:73
 do_softirq+0x90/0xf8 kernel/softirq.c:523
 __local_bh_enable_ip+0x240/0x35c kernel/softirq.c:450
 local_bh_enable+0x28/0x34 include/linux/bottom_half.h:33
 rcu_read_unlock_bh include/linux/rcupdate.h:936 [inline]
 __dev_queue_xmit+0x17ac/0x32a8 net/core/dev.c:4790
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 neigh_hh_output include/net/neighbour.h:531 [inline]
 neigh_output include/net/neighbour.h:545 [inline]
 ip6_finish_output2+0x1150/0x1a78 net/ipv6/ip6_output.c:136
 __ip6_finish_output net/ipv6/ip6_output.c:-1 [inline]
 ip6_finish_output+0x418/0x7b4 net/ipv6/ip6_output.c:220
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x2c8/0x640 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:464 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ip6_xmit+0x1134/0x1a20 net/ipv6/ip6_output.c:371
 inet6_csk_xmit+0x454/0x66c net/ipv6/inet6_connection_sock.c:120
 __tcp_transmit_skb+0x1a34/0x3214 net/ipv4/tcp_output.c:1628
 tcp_transmit_skb net/ipv4/tcp_output.c:1646 [inline]
 tcp_write_xmit+0x159c/0x52a4 net/ipv4/tcp_output.c:2999
 __tcp_push_pending_frames net/ipv4/tcp_output.c:3182 [inline]
 tcp_send_fin+0x620/0xc08 net/ipv4/tcp_output.c:3800
 __tcp_close+0x558/0xf68 net/ipv4/tcp.c:3207
 tcp_close+0x38/0x144 net/ipv4/tcp.c:3298
 inet_release+0x154/0x1d0 net/ipv4/af_inet.c:437
 inet6_release+0x5c/0x78 net/ipv6/af_inet6.c:487
 __sock_release net/socket.c:662 [inline]
 sock_close+0xa0/0x1e4 net/socket.c:1455
 __fput+0x340/0x75c fs/file_table.c:468
 ____fput+0x20/0x58 fs/file_table.c:496
 task_work_run+0x1dc/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xfc/0x178 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 arm64_exit_to_user_mode arch/arm64/kernel/entry-common.c:81 [inline]
 el0_svc+0x170/0x254 arch/arm64/kernel/entry-common.c:725
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
Code: 52800081 aa1903e0 9761d4da d343ff28 (38fb6908) 
---[ end trace 0000000000000000 ]---
----------------
Code disassembly (best guess):
   0:	52800081 	mov	w1, #0x4                   	// #4
   4:	aa1903e0 	mov	x0, x25
   8:	9761d4da 	bl	0xfffffffffd875370
   c:	d343ff28 	lsr	x8, x25, #3
* 10:	38fb6908 	ldrsb	w8, [x8, x27] <-- trapping instruction


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

