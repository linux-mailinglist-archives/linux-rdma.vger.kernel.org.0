Return-Path: <linux-rdma+bounces-16216-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D7oFThEfGnZLgIAu9opvQ
	(envelope-from <linux-rdma+bounces-16216-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 06:40:08 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB15B75A9
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 06:40:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 24414301467D
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jan 2026 05:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37A8E36E471;
	Fri, 30 Jan 2026 05:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9nZxXqC"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5B9353EE6
	for <linux-rdma@vger.kernel.org>; Fri, 30 Jan 2026 05:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769751603; cv=none; b=ShmuFYVwQ0ixXFwoEcxxRTdT8GIHomTryL/y3l1CqHKz5yx/LGIt18Il8g0z+OGawqxfHap8BK//JhvVH1mRn/Nv/ehXQGPEmgCIlBGNssPVM8eUCxsUF8DYYNXDaXRLQJzufEZaT6TBxXHdFg38nC1IwMBdiazZLNHNa2PzaJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769751603; c=relaxed/simple;
	bh=m9QiYfJSEeZvm1degB9UdjAeNUBeQVAmlJtZotX3y/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ch6A7O0gSgKvQFXsOTFjw7Ja+qcxxEP9lgeb1gBlxaxujH39dzlDE8IlH7lTGF5cqKTQ9psazQqn6pLx6nXmGGlK3afj7HGtD/tZjb39s+3b+EZCUTzc0vM+/QiBAAVTiAJUl8XrT5Q4NoEErbWcbHbi3o8nQgfECAGln9KCh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9nZxXqC; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2a07f8dd9cdso11955325ad.1
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jan 2026 21:40:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769751601; x=1770356401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0au5pT4OKj7pKX1PLzRclS0sMWHW3RBVI7y4DBAElM8=;
        b=c9nZxXqCfJiGJTHAfeLj+KmaUBMIEc3SIlp9LjxqKUsQ9YTysVwRA5rxJZCz/8PinY
         rnu4Z50PCErbrED8ih48evzM9uoh99IYFrKQW9tufBwziYV878864sE3FEx5A8J0plKB
         RMMom18KBRYhy6EHghk+V5jtiAciTFajdo5Lv2azRCT2bAaDKUeyE3QxHoDouy5QNrZ6
         0kjnaJUA+7kyHoRMZ0rmcJ7Vz3jwMOiZMFgXSeiDqGNAU+pTcAPeB3y5ZXL16w+9x5Rx
         9BHOq57PhqrG3aNjCyPR9QrT1rdvgZ9fVq5DimfKltXgloJ9zkvwEWGJ9fhTd7pseD9H
         AcmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769751601; x=1770356401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0au5pT4OKj7pKX1PLzRclS0sMWHW3RBVI7y4DBAElM8=;
        b=d4fXQI686aEhSusyxqqVJevUZQEXF7y4zoT+I2n/VaNMz6yd3ZivwvP8GVHCIyh2yP
         9ghjg+Hq/ICjhVM21Ro6v+PKDCrxj6YQGwYXoWHKyPv5f50PAAGoOVbI6lC03yW0Xn0P
         /oykxQIFpfDKz+0RrM1qqe9oBNbh+F54z7eHXGETNDp0cbPJmvpnqVpF6ocenMyXZron
         yzx9n4eKS1JK/MW1WUf1w6VIISXYTE7mSh3lRVVkBXzlOCWyN605LIJCPOx5bhqtnblo
         10PWbL3nteMtgA8Nn39TGdnFaJvsGEfVLtI/EY6/TMhz33bzLBGC+8TRJUx+o7PEUwlM
         Rwww==
X-Forwarded-Encrypted: i=1; AJvYcCXek73kETaPJdA5jMjC74APxhyAzKpPdQ1/+NqNestD12bBkGPHatJPvU+k5nQNLD+CWlgp2Cm9QpiW@vger.kernel.org
X-Gm-Message-State: AOJu0Yx22xjzl4m9S9OaCJDJy8xaxTygs0vftLGvfyZJsY6SPkCPLMbU
	43fPbuc0gyS8z7wpb/CWmF878x2bAoF1CUUseVrg5bsbZ7JvQWF0/uKQ
X-Gm-Gg: AZuq6aKbCPbT358RDKPYlKyuSEJBIHPnrhbwyjubeuV6kGoS7QfYYrubnu1wtCYPLbR
	pLvIZGLoZXFS28qV3f1VfGvltJdFNqCBP9b6VyD4XsQQmPq0+1+uYLUSgnLC+aR0/NH1kqVW31p
	g2utythVyB94yK39S2wYqetK6JRN36//c7LVXBNy8iNvMDAw6guoj8k8kEtwQk8y0BeevIgNz33
	38PPfnGUyIuprEW30I45Gzwm9VUw4qNQO18n38g9xCXWzrA8Y53Gozghym3TG7+w4HEeAGt3aOp
	cKrhRnmRXCSOatX4if5U3OeEPKQ471nwa8krdFr75E794jVZ/cy6Ad7kw1uxUBdG0UAsGXO9p+j
	AsQ5JxkKJswOapSSocJs+iTGJ81e7y9xAE8TY4BGn4KCNdzaDWOvrJBFZsm76HlQqEVOmgA7hlB
	LjRe15UP/8Kp/+VQGAAoAL4RSAMPTTF+XD
X-Received: by 2002:a17:903:1967:b0:2a3:bf5f:936b with SMTP id d9443c01a7336-2a8d96b11cfmr18172725ad.26.1769751600239;
        Thu, 29 Jan 2026 21:40:00 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b4153efsm60601235ad.38.2026.01.29.21.39.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jan 2026 21:39:59 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: Leon Romanovsky <leon@kernel.org>,
	Bernard Metzler <bernard.metzler@linux.dev>,
	Jason Gunthorpe <jgg@ziepe.ca>
Cc: Joonkyoo Jeong <joonkyoj@yonsei.ac.kr>,
	Greg KH <gregkh@linuxfoundation.org>,
	linux-rdma@vger.kernel.org,
	YunJe Shin <ioerts@kookmin.ac.kr>
Subject: [PATCH] RDMA/siw: Avoid NULL deref on header parse error
Date: Fri, 30 Jan 2026 14:38:14 +0900
Message-ID: <20260130053919.2180043-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026012951-diving-silo-3aac@gregkh>
References: <2026012951-diving-silo-3aac@gregkh>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16216-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kookmin.ac.kr:mid,kookmin.ac.kr:email]
X-Rspamd-Queue-Id: AEB15B75A9
X-Rspamd-Action: no action

If siw_get_hdr() returns -EINVAL before set_rx_fpdu_context(), qp->rx_fpdu
can be NULL. The error path in siw_tcp_rx_data() dereferences
qp->rx_fpdu->more_ddp_segs without checking, leading to a NULL pointer
deref. Since the state check is redundant, only check more_ddp_segs when
rx_fpdu is present.


[  101.384271] KASAN: null-ptr-deref in range
[0x00000000000000c0-0x00000000000000c7]
[  101.385071] CPU: 1 UID: 1000 PID: 265 Comm: exploit_poc Not tainted
6.19.0-rc7-g8dfce8991b95 #1 PREEMPT(voluntary)
[  101.385418] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  101.385869] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50
[  101.386511] Code: 0b 89 34 24 e8 b4 49 1b fe 8b 34 24 48 8b ab f8
03 00 00 b8 ff ff 37 00 48 c1 e0 2a 48 8d bd c5 00 00 8
[  101.386979] RSP: 0018:ffff88806d1083a0 EFLAGS: 00000207
[  101.387243] RAX: dffffc0000000000 RBX: ffff88800d5ef000 RCX: 0000000000000000
[  101.387545] RDX: 0000000000000018 RSI: 00000000ffffffea RDI: 00000000000000c5
[  101.387829] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000006
[  101.388076] R10: ffff88800d5ef5be R11: 0000000000000001 R12: dffffc0000000000
[  101.388316] R13: ffff88800d5ef3f4 R14: 0000000000000010 R15: ffff88800d5ef384
[  101.388599] FS:  00000000110e2380(0000) GS:ffff8880e62af000(0000)
knlGS:0000000000000000
[  101.388819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.389020] CR2: dffffc0000000018 CR3: 00000000092c7000 CR4: 00000000000006f0
[  101.389324] Call Trace:
[  101.389635]  <IRQ>
[  101.389807]  ? lapic_next_event+0x10/0x20
[  101.389978]  ? clockevents_program_event+0x1d0/0x280
[  101.390121]  ? hrtimer_interrupt+0x319/0x7e0
[  101.390269]  __tcp_read_sock+0x1ab/0x810
[  101.390412]  ? __pfx_siw_tcp_rx_data+0x10/0x10
[  101.390535]  ? __pfx___tcp_read_sock+0x10/0x10
[  101.390658]  siw_qp_llp_data_ready+0x185/0x2c0
[  101.390759]  ? __pfx_siw_qp_llp_data_ready+0x10/0x10
[  101.390871]  ? tcp_event_data_recv+0x36a/0x7b0
[  101.390967]  ? tcp_queue_rcv+0x30a/0x620
[  101.391062]  tcp_data_queue+0x1ecc/0x4b40
[  101.391164]  ? common_startup_64+0x13e/0x148
[  101.391265]  ? __pfx_tcp_data_queue+0x10/0x10
[  101.391358]  ? tcp_try_undo_loss+0x640/0x710
[  101.391459]  ? __pfx_read_tsc+0x10/0x10
[  101.391545]  ? ktime_get+0x60/0x140
[  101.391669]  ? __pfx_do_sync_core+0x10/0x10
[  101.391764]  tcp_rcv_established+0x801/0x35e0
[  101.391864]  ? sk_filter_trim_cap+0x4ab/0xb20
[  101.391963]  ? __pfx_tcp_inbound_hash+0x10/0x10
[  101.392060]  ? __pfx_tcp_rcv_established+0x10/0x10
[  101.392167]  ? bpf_skb_net_hdr_push+0x560/0x580
[  101.392268]  ? _raw_spin_lock+0x7f/0xd0
[  101.392363]  tcp_v4_do_rcv+0x525/0x8a0
[  101.392461]  tcp_v4_rcv+0x249d/0x3e50
[  101.392558]  ? kernel_text_address+0xa7/0x130
[  101.392685]  ? __pfx_tcp_v4_rcv+0x10/0x10
[  101.392779]  ? unwind_get_return_address+0x59/0xa0
[  101.392897]  ? __pfx_raw_local_deliver+0x10/0x10
[  101.393020]  ip_protocol_deliver_rcu+0x61/0x2e0
[  101.393122]  ? __pfx_stack_trace_save+0x10/0x10
[  101.393233]  ip_local_deliver_finish+0x332/0x4b0
[  101.393333]  ? ip_finish_output2+0x71f/0x19a0
[  101.393429]  ip_local_deliver+0x18f/0x2d0
[  101.393530]  ? __pfx_ip_local_deliver+0x10/0x10
[  101.393642]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
[  101.393789]  ? __kasan_mempool_poison_object+0xbb/0x190
[  101.393899]  ? napi_skb_cache_put+0x23/0x190
[  101.394001]  ? skb_defer_free_flush+0x145/0x1b0
[  101.394100]  ? net_rx_action+0x349/0xfb0
[  101.394215]  ? __asan_memset+0x23/0x50
[  101.394315]  ? __tcp_push_pending_frames+0x8f/0x2f0
[  101.394423]  ip_rcv+0x221/0x270
[  101.394506]  ? __pfx_ip_rcv+0x10/0x10
[  101.394627]  ? __pfx_ip_rcv+0x10/0x10
[  101.394735]  __netif_receive_skb_one_core+0x161/0x1b0
[  101.394876]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
[  101.395029]  ? _raw_spin_lock_irq+0x80/0xe0
[  101.395154]  process_backlog+0x1e5/0x5e0
[  101.395268]  ? napi_skb_cache_put+0x23/0x190
[  101.395423]  __napi_poll+0x9a/0x500
[  101.395533]  net_rx_action+0x988/0xfb0
[  101.395671]  ? _raw_spin_lock_irq+0x80/0xe0
[  101.395797]  ? __pfx_net_rx_action+0x10/0x10
[  101.395948]  ? timerqueue_add+0x21b/0x320
[  101.396093]  ? __hrtimer_run_queues+0x3de/0x790
[  101.396251]  ? __pfx_read_tsc+0x10/0x10
[  101.396365]  ? ktime_get+0x60/0x140
[  101.396475]  handle_softirqs+0x18c/0x530
[  101.396592]  ? __pfx_handle_softirqs+0x10/0x10
[  101.396731]  do_softirq+0x3b/0x60
[  101.396855]  </IRQ>
[  101.396940]  <TASK>
[  101.397004]  __local_bh_enable_ip+0x61/0x70
[  101.397144]  __dev_queue_xmit+0x618/0x2fe0
[  101.397257]  ? __local_bh_enable_ip+0x61/0x70
[  101.397380]  ? __pfx___dev_queue_xmit+0x10/0x10
[  101.397500]  ? sched_clock+0x10/0x30
[  101.397613]  ? __pfx_selinux_ip_postroute_compat+0x10/0x10
[  101.397770]  ? _raw_spin_trylock+0xaf/0x120
[  101.397883]  ? selinux_ip_postroute+0x3e9/0x9d0
[  101.398008]  ip_finish_output2+0x71f/0x19a0
[  101.398125]  ? __pfx_ip_finish_output2+0x10/0x10
[  101.398251]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[  101.398395]  __ip_finish_output.part.0+0x477/0x950
[  101.398541]  ? __pfx___ip_finish_output.part.0+0x10/0x10
[  101.398691]  ? nf_hook_slow+0xa7/0x1e0
[  101.398796]  ip_output+0x260/0x4d0
[  101.398903]  ? __pfx_ip_output+0x10/0x10
[  101.399015]  ? __pfx_stack_trace_save+0x10/0x10
[  101.399132]  ? __pfx_ip_finish_output+0x10/0x10
[  101.399236]  ? kasan_save_stack+0x42/0x60
[  101.399501]  ? ipv4_dst_check+0x10a/0x160
[  101.399665]  __ip_queue_xmit+0xcfb/0x1d60
[  101.399813]  ? __tcp_select_window+0xf8/0xed0
[  101.399931]  ? __skb_clone+0x550/0x740
[  101.400034]  __tcp_transmit_skb+0x29ce/0x3de0
[  101.400159]  ? __pfx___tcp_transmit_skb+0x10/0x10
[  101.400284]  ? kmem_cache_alloc_node_noprof+0x13b/0x4d0
[  101.400423]  ? kasan_save_track+0x14/0x30
[  101.400565]  tcp_write_xmit+0x11ba/0x7610
[  101.400744]  ? skb_page_frag_refill+0x55/0x430
[  101.400872]  __tcp_push_pending_frames+0x8f/0x2f0
[  101.400999]  tcp_sendmsg_locked+0x156e/0x3b70
[  101.401165]  ? __pfx_tcp_sendmsg_locked+0x10/0x10
[  101.401362]  ? __pfx_selinux_socket_sendmsg+0x10/0x10
[  101.401528]  ? _raw_spin_lock_bh+0x83/0xe0
[  101.401733]  ? ldsem_up_read+0x12/0x40
[  101.402061]  tcp_sendmsg+0x26/0x40
[  101.402210]  __sys_sendto+0x364/0x430
[  101.402346]  ? __pfx___sys_sendto+0x10/0x10
[  101.402523]  ? ksys_write+0xf7/0x1c0
[  101.402671]  ? __pfx_ksys_write+0x10/0x10
[  101.402834]  __x64_sys_sendto+0xdb/0x1b0
[  101.402968]  ? fpregs_assert_state_consistent+0x56/0xe0
[  101.403107]  do_syscall_64+0xa4/0x320
[  101.403254]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[  101.403554] RIP: 0033:0x42440d
[  101.403982] Code: 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e
fa 80 3d 5d fc 08 00 00 41 89 ca 74 20 45 31 c9 45 31 9
[  101.404392] RSP: 002b:00007ffc69a5f158 EFLAGS: 00000246 ORIG_RAX:
000000000000002c
[  101.404659] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000042440d
[  101.404864] RDX: 0000000000000030 RSI: 00007ffc69a5f180 RDI: 0000000000000003
[  101.405069] RBP: 00007ffc69a5f200 R08: 0000000000000000 R09: 0000000000000000
[  101.405257] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc69a5f318
[  101.405416] R13: 00007ffc69a5f340 R14: 00000000004ae868 R15: 0000000000000001
[  101.405634]  </TASK>
[  101.405771] Modules linked in:
[  101.406766] ---[ end trace 0000000000000000 ]---
[  101.407214] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50
[  101.407387] Code: 0b 89 34 24 e8 b4 49 1b fe 8b 34 24 48 8b ab f8
03 00 00 b8 ff ff 37 00 48 c1 e0 2a 48 8d bd c5 00 00 8
[  101.407946] RSP: 0018:ffff88806d1083a0 EFLAGS: 00000207
[  101.408091] RAX: dffffc0000000000 RBX: ffff88800d5ef000 RCX: 0000000000000000
[  101.408239] RDX: 0000000000000018 RSI: 00000000ffffffea RDI: 00000000000000c5
[  101.408375] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000006
[  101.408508] R10: ffff88800d5ef5be R11: 0000000000000001 R12: dffffc0000000000
[  101.408741] R13: ffff88800d5ef3f4 R14: 0000000000000010 R15: ffff88800d5ef384
[  101.408897] FS:  00000000110e2380(0000) GS:ffff8880e62af000(0000)
knlGS:0000000000000000
[  101.409051] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  101.409181] CR2: dffffc0000000018 CR3: 00000000092c7000 CR4: 00000000000006f0
[  101.409577] Kernel panic - not syncing: Fatal exception in interrupt
[  101.410887] Kernel Offset: disabled
[  101.411108] Rebooting in 1 seconds..



Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
---
 drivers/infiniband/sw/siw/siw_qp_rx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
index e8a88b378d51..960f740cf46a 100644
--- a/drivers/infiniband/sw/siw/siw_qp_rx.c
+++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
@@ -1434,8 +1434,7 @@ int siw_tcp_rx_data(read_descriptor_t *rd_desc, struct sk_buff *skb,
 			run_completion = 0;
 		}
 		if (unlikely(rv != 0 && rv != -EAGAIN)) {
-			if ((srx->state > SIW_GET_HDR ||
-			     (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs)) &&
+			if (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs &&
 			    run_completion)
 				siw_rdmap_complete(qp, rv);
 
-- 
2.43.0



