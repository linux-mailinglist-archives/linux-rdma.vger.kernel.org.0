Return-Path: <linux-rdma+bounces-16294-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2FbBFPvjfWkgUQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16294-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 12:14:03 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A4197C1AE8
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 12:14:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EFD7300AB03
	for <lists+linux-rdma@lfdr.de>; Sat, 31 Jan 2026 11:14:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C94862EC559;
	Sat, 31 Jan 2026 11:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mNkBIGsY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBD5C2AEE4
	for <linux-rdma@vger.kernel.org>; Sat, 31 Jan 2026 11:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769858040; cv=none; b=HVjxZfV+SC/MZlKEvKOX2yvZU8gdCvIfL6KlNZjv73sWbRFPGP5TFiXysd7BU8EeFch5qvdVSoaMS5CPhQsDmV4VLVje6qYGGCNRIDkqwS/B3gT8Hw+mufrYumRZlr0woxyi9+4SK3xMfbwUXIIYPg679ihxgmWC+We96oP4jiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769858040; c=relaxed/simple;
	bh=1w8MkfOJpEx2WRwAzuCi8k2GRwjRBSr9dzS3RgHstoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jo1lozA0aoX3ZBE1/OZw4QbK6mN+JY8L+tgQTFhdO1xM+mhG2JV/TYggype1jpNQhZDIoDFw6TVF2EP6TKz0nS6xMkIdiJwp28eyURBXxtsD0zMaAmVBUImVMWkxGnOWnqhiT0QQL2n0gzOpnUCC4JOccNaMeYaFYiaNf0wAb/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mNkBIGsY; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f102b013fso29954395ad.2
        for <linux-rdma@vger.kernel.org>; Sat, 31 Jan 2026 03:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769858038; x=1770462838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JCu31SazbYYByLPjQxZikzkTsPTt4oeT2QO7k8dPsxA=;
        b=mNkBIGsYHX3cRRUPaEwNCVR5daVer6RdJkf9Cg5js27VTNPZi/nkF4kY0pKhHDg7ui
         mz9gLffdwtO9q7q4w74glcAoEEs9eAHZDkSiTDyONexzwOjn4NS2umIXuPVczd7FATsK
         1rR2khnaJ0jHKbPL/g5+co9IRkrkp3F8KMf5MVsbErWteZCnziwUhAQ7jT9Kbbf6e8JJ
         xGfMUb6qx9qdKqK7DWqn6AmM49u73+wwpGVaKUFojxskSszZgsHrjRw6tiX9Xyin4E3r
         JLb1Bi0eD+ubNgik4f3LGf+1y0UOGZ06qFYEwbiQJFIXfG9C10R6QIOOvAKADOzXL4Kh
         42UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769858038; x=1770462838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JCu31SazbYYByLPjQxZikzkTsPTt4oeT2QO7k8dPsxA=;
        b=dVBCCqAHbDK5fXYc0hRSw4u1cGzQHJ1bpvzkfJ1up62lNfIV7AsCnz374cEUEu/P4P
         RL2hjWa0y7NBaQXQJPSwo0xSXuUSOEsmxjoX+hHMisGFJLGQXPBIZK2ImoLR2krHs+wU
         V2KnYWo2VN8363Rkw6x7eEFmrb5kKLgV33TCu+3gdc0jKeTDrESJ2yDFL8AdhPddgHgq
         xW+v/h9gp/oM7kkeaBOrl38iDvbz31n6MqqhWy1bFztCbnjczz2uuKK3T7EJT2Iqf9ps
         4SxyunZfTRsOhaOYW2wb/kl0PcM7bdinAWPqfm0cabAYuHLiCisj0Eqvuazec29U8gJP
         0DvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHQGG3eAi3Z7nDzvmjrhfWnKWeRFHVfh5TiF53BI1teLk+e6m/SAdkj/nRexDmsFVQNVGD1uLDbxwZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4goOGof3MahiV4eEY/VovCqppTwrPBMecccy5nSGJzKaAHLPi
	4FMK9qqyIVm8pQtM00L91D1PCPLmAcmbRR7aXU9jX+KKbt4JZja6bR0P
X-Gm-Gg: AZuq6aLUIsi+3S+TiYq9DKB6Y90OM0tkUBZlxEWnfWqJoMQtZ10i9UvSAPMn26GqOcd
	AXHDlp8P1SsTR8NikMMEk7Fso7enBmekvInWQy15En6NLx/ncheN3qgWS2/kW/Cunmfy8w4IN1t
	aWZHlB2xYfohN9hGMgwhZdIrQqXXE8c+fTG+nRT/MQrl41WacjaEI6iINKHg9eMEqIgICuxyPk4
	Slv9VYdS75y00TE5+F5NCnU9HcJXxWi+szIQ3LCB/z5OrIuMP2gY7wma19UKBlKOX1heFRWkcl8
	rWycBAYPRSCXWo5o2UfmHs9VFK8fZq9bJNZGyx2fVe7HFhpJ8hoGKHT0ADOjd5hL4tTGrd8tGb+
	gewHeLW3PIpPDMorbmWriINxKC+Ro2I2Df4gUQP7M1b033mmueHqbQdN6QBJMosq7Qsv2t4PtKj
	/CdAdcLeLiaH92/JlM+l7ZKsrbwJPIc2wg
X-Received: by 2002:a17:903:11d0:b0:2a7:b447:3389 with SMTP id d9443c01a7336-2a8d9596c21mr51566015ad.2.1769858038115;
        Sat, 31 Jan 2026 03:13:58 -0800 (PST)
Received: from user-System-Product-Name.. ([210.121.152.246])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b41390bsm96257855ad.23.2026.01.31.03.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jan 2026 03:13:57 -0800 (PST)
From: YunJe Shin <yjshin0438@gmail.com>
X-Google-Original-From: YunJe Shin <ioerts@kookmin.ac.kr>
To: bernard.metzler@linux.dev
Cc: jgg@ziepe.ca,
	leon@kernel.org,
	joonkyoj@yonsei.ac.kr,
	linux-rdma@vger.kernel.org,
	ioerts@kookmin.ac.kr
Subject: [PATCH] RDMA/siw: Fix potential NULL pointer dereference in header processing
Date: Sat, 31 Jan 2026 20:13:05 +0900
Message-ID: <20260131111335.4069021-1-ioerts@kookmin.ac.kr>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <662a7cd7-a1ea-4b9f-8654-c2537e5ef615@linux.dev>
References: <662a7cd7-a1ea-4b9f-8654-c2537e5ef615@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16294-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yjshin0438@gmail.com,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A4197C1AE8
X-Rspamd-Action: no action

If siw_get_hdr() returns -EINVAL before set_rx_fpdu_context(),
qp->rx_fpdu can be NULL. Since the error path in siw_tcp_rx_data()
dereferences qp->rx_fpdu->more_ddp_segs without checking, this
may lead to a NULL pointer deref. Only check more_ddp_segs when
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



