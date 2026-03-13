Return-Path: <linux-rdma+bounces-18142-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPz4OhortGkEigAAu9opvQ
	(envelope-from <linux-rdma+bounces-18142-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:19:54 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ABEF285D08
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 16:19:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 16AE130FD793
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 15:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F22D3A8752;
	Fri, 13 Mar 2026 15:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lHbwIfsz"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f196.google.com (mail-pg1-f196.google.com [209.85.215.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1900376BF8
	for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 15:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773414985; cv=none; b=SZxAQEt8gA+9omeQc/yCxArffPp6ByfahIzASip/wtwGf6Y/PRm4+aNtEUT5znpkZQuVYHFHVSLbxqOOon6jts5amouaBvTcDLiVyiz95t7mnT8krStp6tMzSxDgvv5X3FQFQW+hRNZ1CeKMwWxk7aasivuf1Kd/pfboiPNQXz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773414985; c=relaxed/simple;
	bh=nKIqkng7goYaJhNn9KFhUZs+O67N0oBmdb6gcW64wxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OeBRK6g5p+wArH/6yPgwe5WpseTmaGPWGndqi7QJSwzK61GW0otii8Pp6ry576C8mFhWJjVtxg5ESZQGTHH6chq6ixfPqe8xoHgkR0HNyKWAuc/OaNdAElJJlzKn/3bAKCxKJuN6nJ4Ral4fYQhov0DNWSsNexCiyMTCE6mdpeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lHbwIfsz; arc=none smtp.client-ip=209.85.215.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f196.google.com with SMTP id 41be03b00d2f7-c73aabd620bso1545310a12.1
        for <linux-rdma@vger.kernel.org>; Fri, 13 Mar 2026 08:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773414982; x=1774019782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Jm35vwsoB80q41RZr87kmohLp5VQSUbi+sVWXCJgW/s=;
        b=lHbwIfszfujz5hp3r8V6WLion15a/0kNlUzEDPJwA2I0eCs74ajlv3oD6nKMfF52xA
         gYtoOrXSb5TjVATCVI/2uAgaMiydFntMaTVT51dcyGhysRFMrhOVW3sdbpYrFdw/8fAw
         m9iIYw/7DKxJuiV+75K/F2MmhqHgE0tPNWbsyt95FSVQE30Ncir49olzMQnaYiPPhwZh
         vpp2wkprnzCpbYdaSlUFoNKj6TR7EYiV/qSBGkolqssXM7Gx8MbtKkO282teEG22Yhtg
         Fk5rae1YQLWgR4HVgGijhcw5E4ZMoHTuk7O0464A4dR3gQhkCXui+Sj+E20YOwhOocvc
         U4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773414982; x=1774019782;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jm35vwsoB80q41RZr87kmohLp5VQSUbi+sVWXCJgW/s=;
        b=mImTR+A9wBvLLEj87APk/uElGOYSAlsqeVD1W4IPRqUZtXURbjV8WswV3cSwJlajsL
         CmoJnR4BWfwPohedEruNtIcqAsmfoOl1ydX0jCUL5BV77IglGUeHYHVUUiXTcn+uXj3V
         /000+8rmw4ZATPzwzFYId8qUcf/aMm1g9EngTjwxZCwpwL3dqAWZ3/oCN2wxZvk2dnCq
         bEA9/EY6QbYsPQHwy1yq82y2nNBeRiWWqjlTOwWY4XJpBaVbFi9NvevN9swlirM0dQHK
         Eg3ZOI7V+yftCPtomRm9zjBeUUJ03lta83Jz4zwthQOGX6Vk0nWGjIIhApzSpGn/NDAl
         vH/A==
X-Forwarded-Encrypted: i=1; AJvYcCXKi5IESRI5T8TCwY4Lx1xUH0LMPqRUKZ953/9/wLlsgGeEXsFSF5JhZY1xWKmlPhSS3WJQxy7+dVr+@vger.kernel.org
X-Gm-Message-State: AOJu0YzhQqQnCiKzJCQCe3RrSTxxSYpMRrUBua7rNOB7S4MjSF3yVo+2
	NkasdfZyEUvlC3DUfNVMeh2bDJ8THyDC8yR7l/vKXKr6iVhPAGSHO5DI
X-Gm-Gg: ATEYQzwe6JH2xZfH53jhT5xjY4s9Dr9abwxmGo6taIgmpTaQb8PIoYHPnKJi0Yy9HsD
	lgR418RPLCEt+9Z3wvzHjOYKihK01qT22jXmVSyhPNn4aLZYiTK+uoFkenw/biyjlzV6YUMvF1N
	4wUbJ+2J5AxGih6dbnzWJHThzLzdhOUDzmjs05jsKmBNW3V2p0W69aliu9+QwCIq3KWm4TX9cMh
	ZktPzVDFs7iyKs0NgRC9HT7HExnQTcEU1xhCuiI6Nqu7igOqPd9zfPrfhTCVudipc7zsefGhwyh
	kRq24Xnz2RlOsMLmJXmYUHuKhKavEhU8FkChI0paSBZXzrj/MxnkFEVHctoYfyWleR8kNNqQXSK
	YxvwqRgw32dG3YAbCzKtdTi3wVLyX/Rd3h+tGGvVzaGxNNeCmPy1bJ4H0Ee0zfO/YFrg3o6eoEg
	Y6shchxWKAmrVXxkSbTWDg9lEn+oqakGaQUq5KR2wfhZeeDytkDBEl0VPDFCnF7ceK1TfM
X-Received: by 2002:a05:6a00:7596:b0:827:2ec9:e1bc with SMTP id d2e1a72fcca58-82a199432a1mr2901988b3a.61.1773414981906;
        Fri, 13 Mar 2026 08:16:21 -0700 (PDT)
Received: from henry-machine.taileee5f2.ts.net ([2408:8606:18c1:c673:73c4:970f:3c7:437b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07366123sm6453981b3a.47.2026.03.13.08.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:16:21 -0700 (PDT)
From: bsdhenrymartin@gmail.com
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com
Cc: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH] net/smc: fix NULL pointer dereference in smc_tcp_syn_recv_sock
Date: Fri, 13 Mar 2026 23:16:09 +0800
Message-ID: <20260313151609.83026-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,linux.ibm.com,kernel.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-18142-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bsdhenrymartin@gmail.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8ABEF285D08
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Henry Martin <bsdhenrymartin@gmail.com>

smc_tcp_syn_recv_sock() gets the SMC listener through
smc_clcsock_user_data(sk), but then dereferences it unconditionally.

During concurrent teardown, sk_user_data can already be cleared while the
hooked syn_recv_sock path is still reached, leaving smc as NULL. This
causes a NULL pointer dereference at atomic_read(&smc->queued_smc_hs).

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in smc_tcp_syn_recv_sock+0xae/0x485 net/smc/af_smc.c:136
Read of size 4 at addr 00000000000006c0 by task syz.0.22477/59456

CPU: 0 UID: 0 PID: 59456 Comm: syz.0.22477 Not tainted 7.0.0-rc3 #1 PREEMPT(lazy) 
Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0xad/0xf9 lib/dump_stack.c:120
 print_report+0x4c3/0x4d6 mm/kasan/report.c:485
 kasan_report+0xb3/0xe2 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x36/0x169 mm/kasan/generic.c:200
 __kasan_check_read+0x15/0x1b mm/kasan/shadow.c:31
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 smc_tcp_syn_recv_sock+0xae/0x485 net/smc/af_smc.c:136
 tcp_check_req+0x1713/0x1c6a net/ipv4/tcp_minisocks.c:927
 tcp_v6_rcv+0x11ca/0x22f7 net/ipv6/tcp_ipv6.c:1786
 ip6_protocol_deliver_rcu+0x380/0xd23 net/ipv6/ip6_input.c:438
 ip6_input_finish+0x32f/0x343 net/ipv6/ip6_input.c:489
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK.constprop.0+0x160/0x1aa include/linux/netfilter.h:312
 ip6_input+0x83/0x98 net/ipv6/ip6_input.c:500
 dst_input+0x72/0xb4 include/net/dst.h:480
 ip6_rcv_finish net/ipv6/ip6_input.c:79 [inline]
 ip6_rcv_finish+0x3b/0x50 net/ipv6/ip6_input.c:69
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK.constprop.0+0x160/0x1aa include/linux/netfilter.h:312
 ipv6_rcv+0xa5/0xbe net/ipv6/ip6_input.c:311
 __netif_receive_skb_one_core+0x146/0x1d9 net/core/dev.c:6164
 __netif_receive_skb+0xee/0x102 net/core/dev.c:6277
 process_backlog+0xf9/0x37f net/core/dev.c:6628
 __napi_poll.constprop.0+0xbc/0x361 net/core/dev.c:7692
 napi_poll net/core/dev.c:7755 [inline]
 net_rx_action+0x47f/0x974 net/core/dev.c:7912
 handle_softirqs+0x21c/0x488 kernel/softirq.c:622
 __do_softirq+0x14/0x1a kernel/softirq.c:656
 do_softirq kernel/softirq.c:523 [inline]
 do_softirq+0x50/0x71 kernel/softirq.c:510
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x46/0x62 kernel/softirq.c:450
 local_bh_enable+0x1a/0x20 include/linux/bottom_half.h:33
 rcu_read_unlock_bh include/linux/rcupdate.h:924 [inline]
 __dev_queue_xmit+0x1c6a/0x1cca net/core/dev.c:4873
 dev_queue_xmit include/linux/netdevice.h:3384 [inline]
 neigh_hh_output include/net/neighbour.h:540 [inline]
 neigh_output include/net/neighbour.h:554 [inline]
 ip6_finish_output2+0x1189/0x11e2 net/ipv6/ip6_output.c:136
 __ip6_finish_output+0x3f6/0x430 net/ipv6/ip6_output.c:208
 ip6_finish_output net/ipv6/ip6_output.c:219 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x25f/0x2c9 net/ipv6/ip6_output.c:246
 dst_output+0x84/0xd6 include/net/dst.h:470
 NF_HOOK include/linux/netfilter.h:318 [inline]
 NF_HOOK.constprop.0+0x76/0x94 include/linux/netfilter.h:312
 ip6_xmit+0xc0b/0xd41 net/ipv6/ip6_output.c:358
 inet6_csk_xmit+0x326/0x34c net/ipv6/inet6_connection_sock.c:115
 __tcp_transmit_skb+0x2e73/0x326b net/ipv4/tcp_output.c:1693
 __tcp_send_ack net/ipv4/tcp_output.c:4503 [inline]
 __tcp_send_ack+0x3a3/0x3b8 net/ipv4/tcp_output.c:4464
 tcp_send_ack_reflect_ect+0x122/0x12d net/ipv4/tcp_input.c:4038
 tcp_rcv_synsent_state_process net/ipv4/tcp_input.c:7021 [inline]
 tcp_rcv_state_process+0x19e9/0x390d net/ipv4/tcp_input.c:7215
 tcp_v6_do_rcv+0x7b8/0xdca net/ipv6/tcp_ipv6.c:1616
 sk_backlog_rcv+0xba/0x104 include/net/sock.h:1185
 __release_sock+0xea/0x181 net/core/sock.c:3213
 release_sock+0x62/0x188 net/core/sock.c:3795
 inet_wait_for_connect net/ipv4/af_inet.c:611 [inline]
 __inet_stream_connect+0x791/0xae8 net/ipv4/af_inet.c:705
 inet_stream_connect+0x66/0xa2 net/ipv4/af_inet.c:750
 kernel_connect+0x102/0x13e net/socket.c:3634
 smc_connect+0x3b3/0x54c net/smc/af_smc.c:1699
 __sys_connect_file+0x15e/0x177 net/socket.c:2089
 __sys_connect+0xf5/0x14a net/socket.c:2108
 __do_sys_connect net/socket.c:2114 [inline]
 __se_sys_connect net/socket.c:2111 [inline]
 __x64_sys_connect+0x8d/0x9a net/socket.c:2111
 x64_sys_call+0x27d/0x2105 arch/x86/include/generated/asm/syscalls_64.h:43
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x1b3/0x420 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc7601a576d
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc761151018 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fc760425fa0 RCX: 00007fc7601a576d
RDX: 000000000000001c RSI: 0000200000000000 RDI: 0000000000000004
RBP: 00007fc76024c5fe R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc760426038 R14: 00007fc760425fa0 R15: 00007fc76054f900
 </TASK>
==================================================================

Fix it by checking smc before accessing queued_smc_hs and dropping the
request when the SMC context is gone.

This issue was co-discovered by Wu Yangyang.

Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/smc/af_smc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
index d0119afcc6a1..bb8966eeb332 100644
--- a/net/smc/af_smc.c
+++ b/net/smc/af_smc.c
@@ -132,6 +132,8 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
 	struct sock *child;
 
 	smc = smc_clcsock_user_data(sk);
+	if (!smc)
+		goto drop;
 
 	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
 				sk->sk_max_ack_backlog)
-- 
2.43.0

