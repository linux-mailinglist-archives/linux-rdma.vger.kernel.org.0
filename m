Return-Path: <linux-rdma+bounces-9050-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D0C2A76F1C
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 22:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B87C53AAD46
	for <lists+linux-rdma@lfdr.de>; Mon, 31 Mar 2025 20:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3E121B18C;
	Mon, 31 Mar 2025 20:23:23 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0320421ABB6
	for <linux-rdma@vger.kernel.org>; Mon, 31 Mar 2025 20:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743452603; cv=none; b=VnE3q23mvjcXjZmG9y9wmhMIcHMBLOLKj+8y2MhYqq7shvZxW4JaMzNElrWd99Ae880oKC9zYB/jM/4dFYGDB028EVPWSs2j8tcJMvDR1s4XgKFHIGTrlm9B9XZGpYY+MsIkfhWNLHnhIzahBje552V/zM7Qbw/Ia8iNV3dK47s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743452603; c=relaxed/simple;
	bh=3PY05xnMoMY5l0MLOVsaY4dzTB65DW9ZAGjtkWZLVh0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cDoRxjYTrqZtT3vSue4GsGlQ8a4IhCp3+QVHZXYGt0vFvaAEK2dBqXFTHfYCoitnoxGe4QLNxxnnhrOaFO6WiJBuUj250qsT7/9joLK7m6jleGXZleHw23+eUK6FMf4d76Wo9BAdcPMx5DKyQk4ZSMkOzEaS+LBYaYhWNtY9kb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so51391005ab.2
        for <linux-rdma@vger.kernel.org>; Mon, 31 Mar 2025 13:23:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743452600; x=1744057400;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3IdS2CIIBxydV1hM12Yq4u+yxRM3vbbwLHZJ/Jv2v1U=;
        b=ndKHGIfSeelCt8rsGl/Vq74wQ0aP8NkkKe1UlZmgauOtcnm2El70vS5ydL9Xqegb67
         5ueHWrQ56qMvwG+u3rvUcOdUwbEUT7m/Q0xuocIpkIyxbTTD/r1BqwHmH1EP6g5Xm5Zl
         mUJ0FUG7bpBE2ovx8E9KKL33Ue8U7vvCQIam0KsYHTqE+oGi83QnsamMNDMivyWfkDaX
         WvT1+aDnHYakLpRfBEmWP1eaV5OMcqCsqKCQmt/exIE5+VEWrwPkiPGwqwXMH6vyZ0Bf
         NCoMHs5BSy7B9QPj8UO+Au/TYTFWnWd8jfyGK3kmtukpur+RnR0nIPgvRtahwAAZhf56
         vVTg==
X-Forwarded-Encrypted: i=1; AJvYcCXLl4l7l/q1SMakbvWvdRrbUyR/sQngwkUDghvK5mlwquqKMQvd8zmyM0AfWD5s36iM/cSb5aNlM03n@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyuz8AR6xkbgwtwbxHqPjqx5AmZG4T/euRk5sGdke4yxAIyQhf
	ldzfaM9TlNTEM3lZLfnQmyCoQxljRkj1ypECJ0pOkF0oGWdzqkZNqyDn+vDM2C6GACVzwMNk+9P
	3EH68wkgZHoKylnM6IvIlNsUlH0Cl3z4DwyTY+hrMCghBEPaeDowkkfs=
X-Google-Smtp-Source: AGHT+IHLSJS1wU9leOVUk3T6cwy7hiPNlkyZgl8AGQuBu7QPD/fBMTwXXwdHHtraXgZq65fv4E9K737nJXsbQyEFMVQY9/Ey77Hg
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:238a:b0:3d3:fa0a:7242 with SMTP id
 e9e14a558f8ab-3d5e0912eb8mr90641135ab.9.1743452600121; Mon, 31 Mar 2025
 13:23:20 -0700 (PDT)
Date: Mon, 31 Mar 2025 13:23:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67eaf9b8.050a0220.3c3d88.004a.GAE@google.com>
Subject: [syzbot] [rdma?] [s390?] [net?] KASAN: null-ptr-deref Read in smc_tcp_syn_recv_sock
From: syzbot <syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com>
To: agordeev@linux.ibm.com, alibuda@linux.alibaba.com, davem@davemloft.net, 
	edumazet@google.com, guwen@linux.alibaba.com, horms@kernel.org, 
	jaka@linux.ibm.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tonylu@linux.alibaba.com, wenjia@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    850925a8133c Merge tag '9p-for-6.12-rc5' of https://github..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1227aa87980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17c0d505695d6b0
dashboard link: https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15489230580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6d8177e17058/disk-850925a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5d88252f39ff/vmlinux-850925a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a675a61b90d/bzImage-850925a8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com

TCP: request_sock_TCP: Possible SYN flooding on port [::]:20002. Sending cookies.
TCP: request_sock_TCP: Possible SYN flooding on port [::]:20002. Sending cookies.
==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:68 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock+0xa7/0x4b0 net/smc/af_smc.c:131
Read of size 4 at addr 00000000000009d4 by task syz.4.10809/28966

CPU: 1 UID: 0 PID: 28966 Comm: syz.4.10809 Not tainted 6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 kasan_report+0xd9/0x110 mm/kasan/report.c:601
 check_region_inline mm/kasan/generic.c:183 [inline]
 kasan_check_range+0xef/0x1a0 mm/kasan/generic.c:189
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 smc_tcp_syn_recv_sock+0xa7/0x4b0 net/smc/af_smc.c:131
 tcp_get_cookie_sock+0xd5/0x790 net/ipv4/syncookies.c:204
 cookie_v4_check+0xcf8/0x1d40 net/ipv4/syncookies.c:485
 tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1864 [inline]
 tcp_v4_do_rcv+0x98e/0xa90 net/ipv4/tcp_ipv4.c:1923
 tcp_v4_rcv+0x3cd2/0x4390 net/ipv4/tcp_ipv4.c:2340
 ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5666
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5779
 process_backlog+0x443/0x15f0 net/core/dev.c:6111
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6966
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x887/0x4350 net/core/dev.c:4455
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x16d7/0x2530 net/ipv4/ip_output.c:236
 __ip_finish_output net/ipv4/ip_output.c:314 [inline]
 __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:296
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:450 [inline]
 ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:130
 __ip_queue_xmit+0x747/0x1940 net/ipv4/ip_output.c:536
 __tcp_transmit_skb+0x2a4c/0x3dc0 net/ipv4/tcp_output.c:1466
 __tcp_send_ack.part.0+0x390/0x720 net/ipv4/tcp_output.c:4268
 __tcp_send_ack net/ipv4/tcp_output.c:4274 [inline]
 tcp_send_ack+0x82/0xa0 net/ipv4/tcp_output.c:4274
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6576 [inline]
 tcp_rcv_state_process+0x4332/0x4f30 net/ipv4/tcp_input.c:6770
 tcp_v4_do_rcv+0x1ad/0xa90 net/ipv4/tcp_ipv4.c:1938
 sk_backlog_rcv include/net/sock.h:1115 [inline]
 __release_sock+0x31b/0x400 net/core/sock.c:3072
 release_sock+0x5a/0x220 net/core/sock.c:3626
 mptcp_connect+0xc14/0xee0 net/mptcp/protocol.c:3800
 __inet_stream_connect+0x3ca/0x1020 net/ipv4/af_inet.c:679
 inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:750
 __sys_connect_file+0x150/0x190 net/socket.c:2071
 __sys_connect+0x147/0x180 net/socket.c:2088
 __do_sys_connect net/socket.c:2098 [inline]
 __se_sys_connect net/socket.c:2095 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2095
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f68acb7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f68ada08038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f68acd35f80 RCX: 00007f68acb7e719
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f68acbf132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f68acd35f80 R15: 00007ffdea14cb48
 </TASK>
==================================================================
Oops: general protection fault, probably for non-canonical address 0xdffffc000000013a: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000009d0-0x00000000000009d7]
CPU: 1 UID: 0 PID: 28966 Comm: syz.4.10809 Tainted: G    B              6.12.0-rc4-syzkaller-00261-g850925a8133c #0
Tainted: [B]=BAD_PAGE
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:smc_tcp_syn_recv_sock+0xb8/0x4b0 net/smc/af_smc.c:131
Code: ad d4 09 00 00 be 04 00 00 00 44 8b bb 1c 04 00 00 4c 89 ef e8 69 94 2e f7 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 34
RSP: 0018:ffffc90000a18668 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: ffff88805b9cb600 RCX: ffffffff814e856f
RDX: 000000000000013a RSI: ffffffff81ee031e RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 6e696c6261736944 R12: ffff88807df5bd00
R13: 00000000000009d4 R14: ffffc90000a186e8 R15: 0000000000000000
FS:  00007f68ada086c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68ad9e7d58 CR3: 000000005e3fa000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 tcp_get_cookie_sock+0xd5/0x790 net/ipv4/syncookies.c:204
 cookie_v4_check+0xcf8/0x1d40 net/ipv4/syncookies.c:485
 tcp_v4_cookie_check net/ipv4/tcp_ipv4.c:1864 [inline]
 tcp_v4_do_rcv+0x98e/0xa90 net/ipv4/tcp_ipv4.c:1923
 tcp_v4_rcv+0x3cd2/0x4390 net/ipv4/tcp_ipv4.c:2340
 ip_protocol_deliver_rcu+0xba/0x4c0 net/ipv4/ip_input.c:205
 ip_local_deliver_finish+0x316/0x570 net/ipv4/ip_input.c:233
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_local_deliver+0x18e/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5666
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5779
 process_backlog+0x443/0x15f0 net/core/dev.c:6111
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6966
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 rcu_read_unlock_bh include/linux/rcupdate.h:919 [inline]
 __dev_queue_xmit+0x887/0x4350 net/core/dev.c:4455
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 neigh_hh_output include/net/neighbour.h:526 [inline]
 neigh_output include/net/neighbour.h:540 [inline]
 ip_finish_output2+0x16d7/0x2530 net/ipv4/ip_output.c:236
 __ip_finish_output net/ipv4/ip_output.c:314 [inline]
 __ip_finish_output+0x49e/0x950 net/ipv4/ip_output.c:296
 ip_finish_output+0x31/0x310 net/ipv4/ip_output.c:324
 NF_HOOK_COND include/linux/netfilter.h:303 [inline]
 ip_output+0x13b/0x2a0 net/ipv4/ip_output.c:434
 dst_output include/net/dst.h:450 [inline]
 ip_local_out+0x33e/0x4a0 net/ipv4/ip_output.c:130
 __ip_queue_xmit+0x747/0x1940 net/ipv4/ip_output.c:536
 __tcp_transmit_skb+0x2a4c/0x3dc0 net/ipv4/tcp_output.c:1466
 __tcp_send_ack.part.0+0x390/0x720 net/ipv4/tcp_output.c:4268
 __tcp_send_ack net/ipv4/tcp_output.c:4274 [inline]
 tcp_send_ack+0x82/0xa0 net/ipv4/tcp_output.c:4274
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:6576 [inline]
 tcp_rcv_state_process+0x4332/0x4f30 net/ipv4/tcp_input.c:6770
 tcp_v4_do_rcv+0x1ad/0xa90 net/ipv4/tcp_ipv4.c:1938
 sk_backlog_rcv include/net/sock.h:1115 [inline]
 __release_sock+0x31b/0x400 net/core/sock.c:3072
 release_sock+0x5a/0x220 net/core/sock.c:3626
 mptcp_connect+0xc14/0xee0 net/mptcp/protocol.c:3800
 __inet_stream_connect+0x3ca/0x1020 net/ipv4/af_inet.c:679
 inet_stream_connect+0x57/0xa0 net/ipv4/af_inet.c:750
 __sys_connect_file+0x150/0x190 net/socket.c:2071
 __sys_connect+0x147/0x180 net/socket.c:2088
 __do_sys_connect net/socket.c:2098 [inline]
 __se_sys_connect net/socket.c:2095 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2095
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f68acb7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f68ada08038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f68acd35f80 RCX: 00007f68acb7e719
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007f68acbf132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f68acd35f80 R15: 00007ffdea14cb48
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:atomic_read include/linux/atomic/atomic-instrumented.h:33 [inline]
RIP: 0010:smc_tcp_syn_recv_sock+0xb8/0x4b0 net/smc/af_smc.c:131
Code: ad d4 09 00 00 be 04 00 00 00 44 8b bb 1c 04 00 00 4c 89 ef e8 69 94 2e f7 4c 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <0f> b6 14 02 4c 89 e8 83 e0 07 83 c0 03 38 d0 7c 08 84 d2 0f 85 34
RSP: 0018:ffffc90000a18668 EFLAGS: 00010217
RAX: dffffc0000000000 RBX: ffff88805b9cb600 RCX: ffffffff814e856f
RDX: 000000000000013a RSI: ffffffff81ee031e RDI: 0000000000000007
RBP: 0000000000000000 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 6e696c6261736944 R12: ffff88807df5bd00
R13: 00000000000009d4 R14: ffffc90000a186e8 R15: 0000000000000000
FS:  00007f68ada086c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f68ad9e7d58 CR3: 000000005e3fa000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 2 bytes skipped:
   0:	09 00                	or     %eax,(%rax)
   2:	00 be 04 00 00 00    	add    %bh,0x4(%rsi)
   8:	44 8b bb 1c 04 00 00 	mov    0x41c(%rbx),%r15d
   f:	4c 89 ef             	mov    %r13,%rdi
  12:	e8 69 94 2e f7       	call   0xf72e9480
  17:	4c 89 ea             	mov    %r13,%rdx
  1a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  21:	fc ff df
  24:	48 c1 ea 03          	shr    $0x3,%rdx
* 28:	0f b6 14 02          	movzbl (%rdx,%rax,1),%edx <-- trapping instruction
  2c:	4c 89 e8             	mov    %r13,%rax
  2f:	83 e0 07             	and    $0x7,%eax
  32:	83 c0 03             	add    $0x3,%eax
  35:	38 d0                	cmp    %dl,%al
  37:	7c 08                	jl     0x41
  39:	84 d2                	test   %dl,%dl
  3b:	0f                   	.byte 0xf
  3c:	85                   	.byte 0x85
  3d:	34                   	.byte 0x34


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

