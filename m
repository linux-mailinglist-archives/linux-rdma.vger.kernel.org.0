Return-Path: <linux-rdma+bounces-16448-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLKgNmnTgWl1JwMAu9opvQ
	(envelope-from <linux-rdma+bounces-16448-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:52:25 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 819BFD7F84
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 11:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8F93230159DF
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 10:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38854327C13;
	Tue,  3 Feb 2026 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z/enM/G/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B334326D65
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 10:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770115942; cv=none; b=ZDZu9EwiM9HtuTdKWAOkgLnvB1eOIl45C9J7JlFqdw1lVAmIWMhfz6E5rsBJ44+38eQaId9qXODw0F+P71VudHGfSIRvdWkwTbR6s0yYZ6nofgX3/DPFUZRkgQ5YuEDoKceHBudLhuPCzgPAFUe54UcfIEO91MHyLIZ+pu6Fcxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770115942; c=relaxed/simple;
	bh=9CATYEhQiu5Ky0zDuc4RS0pSCbSSen26hRTagL4wjn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FMthmrHHYB16UGyStyMBIh+O/aL0TdloUDHKiIoZbGFXTbZYMKvX/40TD0wUhkrMiwPnM7kW2SiHlQYkOgy/7u6vGiR/5ZWr88nwTdjuQrBh/bxUbKaf61t1RDAHgngC/2tM54icHAzPqq/WSoieiTYBy/6suIwVBIszeK0dh7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z/enM/G/; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a4dd08cd-aa95-4d1b-a18e-412ecb43d543@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770115935;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E2axD/AIM3Mlsb9QLmr0igeG5h/TNQ1KIAJbUWygX0M=;
	b=Z/enM/G/ao9fRP+zHHtoMYREFqS5QTVQ3EmB9cqtEgrWx0l7wS4YWGMrId88lbfWtWH7EJ
	ai3vk/adJbudSMi6quGqUaM2LtjXPHalEAn6P7XCiyxc7Wg6VbLm12edQ8L+0V8ZQhV5SG
	p+wZ7OLOdL+zKcYaMX7fYZ0BZgNq+R4=
Date: Tue, 3 Feb 2026 11:52:10 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: Fix potential NULL pointer dereference in
 header processing
To: yunje shin <yjshin0438@gmail.com>, Leon Romanovsky <leon@kernel.org>
Cc: jgg@ziepe.ca, joonkyoj@yonsei.ac.kr, linux-rdma@vger.kernel.org,
 ioerts@kookmin.ac.kr
References: <662a7cd7-a1ea-4b9f-8654-c2537e5ef615@linux.dev>
 <20260131111335.4069021-1-ioerts@kookmin.ac.kr>
 <674871c0-1136-47ec-a5eb-907adda487ac@linux.dev>
 <20260202100605.GH34749@unreal>
 <e62a48ce-0cd4-4ff6-a576-d58cba57e132@linux.dev>
 <20260202133354.GL34749@unreal>
 <CAMX6_QFNKkg+se5CZTBjLTrq38xZVmAwgcgWmbT4kdAOEoNJfQ@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <CAMX6_QFNKkg+se5CZTBjLTrq38xZVmAwgcgWmbT4kdAOEoNJfQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16448-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 819BFD7F84
X-Rspamd-Action: no action

On 03.02.2026 02:12, yunje shin wrote:
> Hi Bernard, Leon,
> 
> Based on the follow-up discussion, I will keep the
> srx->state > SIW_GET_HDR condition intact, and only add a NULL check
> around qp->rx_fpdu to address the KASAN NULL dereference.
> 
> Concretely, the change would be as follows:
> 
> if (unlikely(rv != 0 && rv != -EAGAIN)) {
>          if ((srx->state > SIW_GET_HDR ||
> -            qp->rx_fpdu->more_ddp_segs) && run_completion)
> +            (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs)) &&
> +           run_completion)
>                  siw_rdmap_complete(qp, rv);
> 
>          siw_dbg_qp(qp, "rx error %d, rx state %d\n", rv, srx->state);
> }
> 
> Does this look correct to you before I resend the updated patch?
> 

Yes, that looks correct to me.

Thank you.
Bernard.

> Best regards
> YunJe
> 
> On Mon, Feb 2, 2026 at 10:34 PM Leon Romanovsky <leon@kernel.org> wrote:
>>
>> On Mon, Feb 02, 2026 at 01:55:14PM +0100, Bernard Metzler wrote:
>>> On 02.02.2026 11:06, Leon Romanovsky wrote:
>>>> On Sun, Feb 01, 2026 at 06:23:37PM +0100, Bernard Metzler wrote:
>>>>> On 31.01.2026 12:13, YunJe Shin wrote:
>>>>>> If siw_get_hdr() returns -EINVAL before set_rx_fpdu_context(),
>>>>>> qp->rx_fpdu can be NULL. Since the error path in siw_tcp_rx_data()
>>>>>> dereferences qp->rx_fpdu->more_ddp_segs without checking, this
>>>>>> may lead to a NULL pointer deref. Only check more_ddp_segs when
>>>>>> rx_fpdu is present.
>>>>>>
>>>>>>
>>>>>> [  101.384271] KASAN: null-ptr-deref in range
>>>>>> [0x00000000000000c0-0x00000000000000c7]
>>>>>> [  101.385071] CPU: 1 UID: 1000 PID: 265 Comm: exploit_poc Not tainted
>>>>>> 6.19.0-rc7-g8dfce8991b95 #1 PREEMPT(voluntary)
>>>>>> [  101.385418] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX,
>>>>>> 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
>>>>>> [  101.385869] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50
>>>>>> [  101.386511] Code: 0b 89 34 24 e8 b4 49 1b fe 8b 34 24 48 8b ab f8
>>>>>> 03 00 00 b8 ff ff 37 00 48 c1 e0 2a 48 8d bd c5 00 00 8
>>>>>> [  101.386979] RSP: 0018:ffff88806d1083a0 EFLAGS: 00000207
>>>>>> [  101.387243] RAX: dffffc0000000000 RBX: ffff88800d5ef000 RCX: 0000000000000000
>>>>>> [  101.387545] RDX: 0000000000000018 RSI: 00000000ffffffea RDI: 00000000000000c5
>>>>>> [  101.387829] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000006
>>>>>> [  101.388076] R10: ffff88800d5ef5be R11: 0000000000000001 R12: dffffc0000000000
>>>>>> [  101.388316] R13: ffff88800d5ef3f4 R14: 0000000000000010 R15: ffff88800d5ef384
>>>>>> [  101.388599] FS:  00000000110e2380(0000) GS:ffff8880e62af000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [  101.388819] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [  101.389020] CR2: dffffc0000000018 CR3: 00000000092c7000 CR4: 00000000000006f0
>>>>>> [  101.389324] Call Trace:
>>>>>> [  101.389635]  <IRQ>
>>>>>> [  101.389807]  ? lapic_next_event+0x10/0x20
>>>>>> [  101.389978]  ? clockevents_program_event+0x1d0/0x280
>>>>>> [  101.390121]  ? hrtimer_interrupt+0x319/0x7e0
>>>>>> [  101.390269]  __tcp_read_sock+0x1ab/0x810
>>>>>> [  101.390412]  ? __pfx_siw_tcp_rx_data+0x10/0x10
>>>>>> [  101.390535]  ? __pfx___tcp_read_sock+0x10/0x10
>>>>>> [  101.390658]  siw_qp_llp_data_ready+0x185/0x2c0
>>>>>> [  101.390759]  ? __pfx_siw_qp_llp_data_ready+0x10/0x10
>>>>>> [  101.390871]  ? tcp_event_data_recv+0x36a/0x7b0
>>>>>> [  101.390967]  ? tcp_queue_rcv+0x30a/0x620
>>>>>> [  101.391062]  tcp_data_queue+0x1ecc/0x4b40
>>>>>> [  101.391164]  ? common_startup_64+0x13e/0x148
>>>>>> [  101.391265]  ? __pfx_tcp_data_queue+0x10/0x10
>>>>>> [  101.391358]  ? tcp_try_undo_loss+0x640/0x710
>>>>>> [  101.391459]  ? __pfx_read_tsc+0x10/0x10
>>>>>> [  101.391545]  ? ktime_get+0x60/0x140
>>>>>> [  101.391669]  ? __pfx_do_sync_core+0x10/0x10
>>>>>> [  101.391764]  tcp_rcv_established+0x801/0x35e0
>>>>>> [  101.391864]  ? sk_filter_trim_cap+0x4ab/0xb20
>>>>>> [  101.391963]  ? __pfx_tcp_inbound_hash+0x10/0x10
>>>>>> [  101.392060]  ? __pfx_tcp_rcv_established+0x10/0x10
>>>>>> [  101.392167]  ? bpf_skb_net_hdr_push+0x560/0x580
>>>>>> [  101.392268]  ? _raw_spin_lock+0x7f/0xd0
>>>>>> [  101.392363]  tcp_v4_do_rcv+0x525/0x8a0
>>>>>> [  101.392461]  tcp_v4_rcv+0x249d/0x3e50
>>>>>> [  101.392558]  ? kernel_text_address+0xa7/0x130
>>>>>> [  101.392685]  ? __pfx_tcp_v4_rcv+0x10/0x10
>>>>>> [  101.392779]  ? unwind_get_return_address+0x59/0xa0
>>>>>> [  101.392897]  ? __pfx_raw_local_deliver+0x10/0x10
>>>>>> [  101.393020]  ip_protocol_deliver_rcu+0x61/0x2e0
>>>>>> [  101.393122]  ? __pfx_stack_trace_save+0x10/0x10
>>>>>> [  101.393233]  ip_local_deliver_finish+0x332/0x4b0
>>>>>> [  101.393333]  ? ip_finish_output2+0x71f/0x19a0
>>>>>> [  101.393429]  ip_local_deliver+0x18f/0x2d0
>>>>>> [  101.393530]  ? __pfx_ip_local_deliver+0x10/0x10
>>>>>> [  101.393642]  ? __pfx___netif_receive_skb_core.constprop.0+0x10/0x10
>>>>>> [  101.393789]  ? __kasan_mempool_poison_object+0xbb/0x190
>>>>>> [  101.393899]  ? napi_skb_cache_put+0x23/0x190
>>>>>> [  101.394001]  ? skb_defer_free_flush+0x145/0x1b0
>>>>>> [  101.394100]  ? net_rx_action+0x349/0xfb0
>>>>>> [  101.394215]  ? __asan_memset+0x23/0x50
>>>>>> [  101.394315]  ? __tcp_push_pending_frames+0x8f/0x2f0
>>>>>> [  101.394423]  ip_rcv+0x221/0x270
>>>>>> [  101.394506]  ? __pfx_ip_rcv+0x10/0x10
>>>>>> [  101.394627]  ? __pfx_ip_rcv+0x10/0x10
>>>>>> [  101.394735]  __netif_receive_skb_one_core+0x161/0x1b0
>>>>>> [  101.394876]  ? __pfx___netif_receive_skb_one_core+0x10/0x10
>>>>>> [  101.395029]  ? _raw_spin_lock_irq+0x80/0xe0
>>>>>> [  101.395154]  process_backlog+0x1e5/0x5e0
>>>>>> [  101.395268]  ? napi_skb_cache_put+0x23/0x190
>>>>>> [  101.395423]  __napi_poll+0x9a/0x500
>>>>>> [  101.395533]  net_rx_action+0x988/0xfb0
>>>>>> [  101.395671]  ? _raw_spin_lock_irq+0x80/0xe0
>>>>>> [  101.395797]  ? __pfx_net_rx_action+0x10/0x10
>>>>>> [  101.395948]  ? timerqueue_add+0x21b/0x320
>>>>>> [  101.396093]  ? __hrtimer_run_queues+0x3de/0x790
>>>>>> [  101.396251]  ? __pfx_read_tsc+0x10/0x10
>>>>>> [  101.396365]  ? ktime_get+0x60/0x140
>>>>>> [  101.396475]  handle_softirqs+0x18c/0x530
>>>>>> [  101.396592]  ? __pfx_handle_softirqs+0x10/0x10
>>>>>> [  101.396731]  do_softirq+0x3b/0x60
>>>>>> [  101.396855]  </IRQ>
>>>>>> [  101.396940]  <TASK>
>>>>>> [  101.397004]  __local_bh_enable_ip+0x61/0x70
>>>>>> [  101.397144]  __dev_queue_xmit+0x618/0x2fe0
>>>>>> [  101.397257]  ? __local_bh_enable_ip+0x61/0x70
>>>>>> [  101.397380]  ? __pfx___dev_queue_xmit+0x10/0x10
>>>>>> [  101.397500]  ? sched_clock+0x10/0x30
>>>>>> [  101.397613]  ? __pfx_selinux_ip_postroute_compat+0x10/0x10
>>>>>> [  101.397770]  ? _raw_spin_trylock+0xaf/0x120
>>>>>> [  101.397883]  ? selinux_ip_postroute+0x3e9/0x9d0
>>>>>> [  101.398008]  ip_finish_output2+0x71f/0x19a0
>>>>>> [  101.398125]  ? __pfx_ip_finish_output2+0x10/0x10
>>>>>> [  101.398251]  ? __pfx_stack_trace_consume_entry+0x10/0x10
>>>>>> [  101.398395]  __ip_finish_output.part.0+0x477/0x950
>>>>>> [  101.398541]  ? __pfx___ip_finish_output.part.0+0x10/0x10
>>>>>> [  101.398691]  ? nf_hook_slow+0xa7/0x1e0
>>>>>> [  101.398796]  ip_output+0x260/0x4d0
>>>>>> [  101.398903]  ? __pfx_ip_output+0x10/0x10
>>>>>> [  101.399015]  ? __pfx_stack_trace_save+0x10/0x10
>>>>>> [  101.399132]  ? __pfx_ip_finish_output+0x10/0x10
>>>>>> [  101.399236]  ? kasan_save_stack+0x42/0x60
>>>>>> [  101.399501]  ? ipv4_dst_check+0x10a/0x160
>>>>>> [  101.399665]  __ip_queue_xmit+0xcfb/0x1d60
>>>>>> [  101.399813]  ? __tcp_select_window+0xf8/0xed0
>>>>>> [  101.399931]  ? __skb_clone+0x550/0x740
>>>>>> [  101.400034]  __tcp_transmit_skb+0x29ce/0x3de0
>>>>>> [  101.400159]  ? __pfx___tcp_transmit_skb+0x10/0x10
>>>>>> [  101.400284]  ? kmem_cache_alloc_node_noprof+0x13b/0x4d0
>>>>>> [  101.400423]  ? kasan_save_track+0x14/0x30
>>>>>> [  101.400565]  tcp_write_xmit+0x11ba/0x7610
>>>>>> [  101.400744]  ? skb_page_frag_refill+0x55/0x430
>>>>>> [  101.400872]  __tcp_push_pending_frames+0x8f/0x2f0
>>>>>> [  101.400999]  tcp_sendmsg_locked+0x156e/0x3b70
>>>>>> [  101.401165]  ? __pfx_tcp_sendmsg_locked+0x10/0x10
>>>>>> [  101.401362]  ? __pfx_selinux_socket_sendmsg+0x10/0x10
>>>>>> [  101.401528]  ? _raw_spin_lock_bh+0x83/0xe0
>>>>>> [  101.401733]  ? ldsem_up_read+0x12/0x40
>>>>>> [  101.402061]  tcp_sendmsg+0x26/0x40
>>>>>> [  101.402210]  __sys_sendto+0x364/0x430
>>>>>> [  101.402346]  ? __pfx___sys_sendto+0x10/0x10
>>>>>> [  101.402523]  ? ksys_write+0xf7/0x1c0
>>>>>> [  101.402671]  ? __pfx_ksys_write+0x10/0x10
>>>>>> [  101.402834]  __x64_sys_sendto+0xdb/0x1b0
>>>>>> [  101.402968]  ? fpregs_assert_state_consistent+0x56/0xe0
>>>>>> [  101.403107]  do_syscall_64+0xa4/0x320
>>>>>> [  101.403254]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>>>>>> [  101.403554] RIP: 0033:0x42440d
>>>>>> [  101.403982] Code: 02 48 c7 c0 ff ff ff ff eb b5 0f 1f 00 f3 0f 1e
>>>>>> fa 80 3d 5d fc 08 00 00 41 89 ca 74 20 45 31 c9 45 31 9
>>>>>> [  101.404392] RSP: 002b:00007ffc69a5f158 EFLAGS: 00000246 ORIG_RAX:
>>>>>> 000000000000002c
>>>>>> [  101.404659] RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 000000000042440d
>>>>>> [  101.404864] RDX: 0000000000000030 RSI: 00007ffc69a5f180 RDI: 0000000000000003
>>>>>> [  101.405069] RBP: 00007ffc69a5f200 R08: 0000000000000000 R09: 0000000000000000
>>>>>> [  101.405257] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffc69a5f318
>>>>>> [  101.405416] R13: 00007ffc69a5f340 R14: 00000000004ae868 R15: 0000000000000001
>>>>>> [  101.405634]  </TASK>
>>>>>> [  101.405771] Modules linked in:
>>>>>> [  101.406766] ---[ end trace 0000000000000000 ]---
>>>>>> [  101.407214] RIP: 0010:siw_tcp_rx_data+0x13ad/0x1e50
>>>>>> [  101.407387] Code: 0b 89 34 24 e8 b4 49 1b fe 8b 34 24 48 8b ab f8
>>>>>> 03 00 00 b8 ff ff 37 00 48 c1 e0 2a 48 8d bd c5 00 00 8
>>>>>> [  101.407946] RSP: 0018:ffff88806d1083a0 EFLAGS: 00000207
>>>>>> [  101.408091] RAX: dffffc0000000000 RBX: ffff88800d5ef000 RCX: 0000000000000000
>>>>>> [  101.408239] RDX: 0000000000000018 RSI: 00000000ffffffea RDI: 00000000000000c5
>>>>>> [  101.408375] RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000006
>>>>>> [  101.408508] R10: ffff88800d5ef5be R11: 0000000000000001 R12: dffffc0000000000
>>>>>> [  101.408741] R13: ffff88800d5ef3f4 R14: 0000000000000010 R15: ffff88800d5ef384
>>>>>> [  101.408897] FS:  00000000110e2380(0000) GS:ffff8880e62af000(0000)
>>>>>> knlGS:0000000000000000
>>>>>> [  101.409051] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>>>>>> [  101.409181] CR2: dffffc0000000018 CR3: 00000000092c7000 CR4: 00000000000006f0
>>>>>> [  101.409577] Kernel panic - not syncing: Fatal exception in interrupt
>>>>>> [  101.410887] Kernel Offset: disabled
>>>>>> [  101.411108] Rebooting in 1 seconds..
>>>>>>
>>>>>>
>>>>>>
>>>>>> Fixes: 8b6a361b8c48 ("rdma/siw: receive path")
>>>>>> Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
>>>>>> ---
>>>>>>     drivers/infiniband/sw/siw/siw_qp_rx.c | 3 +--
>>>>>>     1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>>
>>>>>> diff --git a/drivers/infiniband/sw/siw/siw_qp_rx.c b/drivers/infiniband/sw/siw/siw_qp_rx.c
>>>>>> index e8a88b378d51..960f740cf46a 100644
>>>>>> --- a/drivers/infiniband/sw/siw/siw_qp_rx.c
>>>>>> +++ b/drivers/infiniband/sw/siw/siw_qp_rx.c
>>>>>> @@ -1434,8 +1434,7 @@ int siw_tcp_rx_data(read_descriptor_t *rd_desc, struct sk_buff *skb,
>>>>>>                          run_completion = 0;
>>>>>>                  }
>>>>>>                  if (unlikely(rv != 0 && rv != -EAGAIN)) {
>>>>>> -                       if ((srx->state > SIW_GET_HDR ||
>>>>>
>>>>> We cannot remove that state > SIW_GET_HDR condition.
>>>>>
>>>>> Consider this error case:
>>>>> We received a header of say a short SEND comprising only
>>>>> one DDP segment, and started data processing, while
>>>>> encountering an error (too much data, no write permission
>>>>> for the receive buffer, etc.). We have to complete the
>>>>> current RECEIVE processing and surface a local completion,
>>>>> since we already fetched the RQE from the receive queue.
>>>>
>>>> Could you walk me through the code call chain?
>>>> Don't we start with SIW_GET_HDR, which should initialize the qp->rx_fpdu
>>>> pointer?
>>>>
>>>
>>> Yes, we start with SIW_GET_HDR. If we got the complete header,
>>> we move on to states for placing data and/or fetching trailer
>>> CRC.
>>>
>>> If we did not complete the header but encounter an error during
>>> its parsing, such as an unsupported RDMA operation, we do not
>>> leave SIW_GET_HDR state, but let the outer receive loop handle
>>> the error case while in SIW_GET_HDR state. So far so good.
>>>
>>> We did not consider the special error case that we are in
>>> SIW_GET_HDR, but may have been unable to set the qp->rx_fpdu
>>> receive context pointer, since it is a first fragment of a new
>>> message and the header is malformed. In that case, we do not
>>> assign a receive context and no local completion must be
>>> generated.
>>>
>>> If, at the other hand, it is the start of an expected consecutive
>>> DDP fragment of a _fragmented_ message (checked via
>>> 'qp->rx_fpdu->more_ddp_segs'), we (1) already have a receive context
>>> (was set during parsing the first correct DDP segment), and (2) we
>>> shall complete that incomplete RDMA operation in error, since we
>>> already started it when parsing the previous message fragment(s).
>>>
>>> Yes that is all rather complicated ...
>>
>> Thanks, so let's leave srx->state > SIW_GET_HDR check intact.
>>
>>>
>>> Thanks,
>>> Bernard.
>>>
>>>
>>>
>>>
>>>> Thanks
>>>>
>>>>>
>>>>>> -                            (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs)) &&
>>>>>> +                       if (qp->rx_fpdu && qp->rx_fpdu->more_ddp_segs &&
>>>>>>                              run_completion)
>>>>>>                                  siw_rdmap_complete(qp, rv);
>>>>>
>>>
>>>


