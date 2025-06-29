Return-Path: <linux-rdma+bounces-11744-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DED8FAECE3E
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 17:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13FF93B2734
	for <lists+linux-rdma@lfdr.de>; Sun, 29 Jun 2025 15:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D9F2248B4;
	Sun, 29 Jun 2025 15:07:06 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CE2248BF
	for <linux-rdma@vger.kernel.org>; Sun, 29 Jun 2025 15:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751209626; cv=none; b=OmY2pgW4VS4TDkJ0ViOMeiEO9AgsfE4Uu5fiWhnTswRaRddDl9+Cb3A2nw07x1iT7XHZyLsSS8Z9AX3zx/EVqxKfNeqMymtKNb1A/JR0Px15FKvCJoVm/FwIVwoHE2nhPQgFpT5mtTcaDUQrx3sZqH8ihXIiOnwBN3EsUfJEO18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751209626; c=relaxed/simple;
	bh=9p5j+1mqqo5eGutd7ZZOQQP7oR71COV1J6XL55ODfMM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=KK0IV14nRUObvUbM3sE0pI40E/LS9//Y6zcluNOH3adE7H1eGq8UJ+RSEZlN02grAGLBCOvzSBLRTtUlVt6ZzaUPLI+j0Mi/AJfgNFrHX4j9bbndRojQLXr26P84EqFLAxvkqamI3G7uUTQ1OCMtb4nCYJpH8MS6IMZBifcnsac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3df3b71b987so11407645ab.0
        for <linux-rdma@vger.kernel.org>; Sun, 29 Jun 2025 08:07:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751209624; x=1751814424;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DWCEYgKLzJgMoXu54KGP51OMmYjuso0+KqTEW+OYlfo=;
        b=DZZ/LKyYtfFcQoFL198p1dLGqoL7u3uiB6CsiEabbpS4YMfVWkAnBd2RNEMc/wiEHn
         60JmUv+lerybNu4q/erM+DxGj53++xtHNmbPLHBnKITcXHywcMc1v6jH+ljDpw/e910h
         jncX1YTRrmi20u6ZlJGGZHQ3X4U+lSRDMrUwo7zKNnmIpHAhrkFMgIXCZVjqVk6zUpMc
         1pfX5aOEdM7UEG9LmcBAHLnN3YAkqGgB/5F7AsfGuwipQ6dbYwC3ZkaCC7giXhJbb6I2
         Ms9Wb2/a/Q/gm6mYsRSwJvmXWEhs3RXdsqKvVeHe1I2cex7KQ6D5LwA6rPx2k/QJzhb4
         zdlQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6J98Dgr/J/sd/XLTV0t7CJj4tetYDbaHrvf49emNW5ER5t7IR5T6/k09n1ZmdZMrobbd5juwnqzLU@vger.kernel.org
X-Gm-Message-State: AOJu0YzGx9NQlvKf6CsACQYZGA3qqRNDlkhXQIMddpAFMXPaOJmlOnr3
	1joo9HMI7GDov8d7ofZqnKP9QpxmyoXwTZ2xSZf7pfBmhBLppNE8MmyIPDerK4WxynmAA4Li9/D
	qcpMvoT1AswwDFG4DQ7VKUFBXeXY8djvMR03gLI+agzscRORsHWSpZuED928=
X-Google-Smtp-Source: AGHT+IGWB1npyb29iI1ZO3MCGbLX3x+ye5sX50XhZiUh3LBadwlVb8sgFlBy1w3tabtXlXnJjewVuth6lsR7dHcOuouFd7eqPPvx
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3308:b0:3df:49b4:8cd6 with SMTP id
 e9e14a558f8ab-3df4ab7811bmr116149255ab.7.1751209624226; Sun, 29 Jun 2025
 08:07:04 -0700 (PDT)
Date: Sun, 29 Jun 2025 08:07:04 -0700
In-Reply-To: <20250629144748.45117-1-contact@arnaud-lcm.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68615698.a00a0220.274b5f.0013.GAE@google.com>
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
WARNING in smc_tcp_syn_recv_sock

------------[ cut here ]------------
WARNING: CPU: 1 PID: 6792 at net/smc/af_smc.c:129 smc_tcp_syn_recv_sock+0x3f8/0x570 net/smc/af_smc.c:129
Modules linked in:
CPU: 1 UID: 0 PID: 6792 Comm: syz.1.16 Not tainted 6.16.0-rc3-syzkaller-gdfba48a70cb6-dirty #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:smc_tcp_syn_recv_sock+0x3f8/0x570 net/smc/af_smc.c:129
Code: 48 8d bb f0 03 00 00 be 01 00 00 00 e8 21 c0 57 00 31 ff 89 c5 89 c6 e8 96 88 a2 f6 85 ed 0f 85 81 fc ff ff e8 49 8d a2 f6 90 <0f> 0b 90 e9 73 fc ff ff e8 3b 8d a2 f6 4c 89 fa 48 b8 00 00 00 00
RSP: 0018:ffffc90000a08780 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888034d95e80 RCX: ffffffff8b198ffa
RDX: ffff88802825da00 RSI: ffffffff8b199007 RDI: 0000000000000005
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: 0000000000000000
R13: ffff8880352e89e0 R14: ffffc90000a08850 R15: ffff888034d95e80
FS:  00007fba98e0c6c0(0000) GS:ffff888124ab5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000040 CR3: 0000000032bf6000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
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
 </IRQ>
 <TASK>
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
RIP: 0033:0x7fba97f7e719
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fba98e0c038 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fba98135f80 RCX: 00007fba97f7e719
RDX: 0000000000000010 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fba97ff132e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fba98135f80 R15: 00007ffdbf9fe0b8
 </TASK>


Tested on:

commit:         dfba48a7 Merge tag 'i2c-for-6.16-rc4' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1622a982580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3e0d55231e0c89c
dashboard link: https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1097888c580000


