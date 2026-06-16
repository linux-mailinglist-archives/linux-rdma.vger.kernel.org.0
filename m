Return-Path: <linux-rdma+bounces-22274-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ln7fJHr5MGo7ZwUAu9opvQ
	(envelope-from <linux-rdma+bounces-22274-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 09:21:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E92AD68CCB6
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 09:21:29 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b="Ikzt/GbZ";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22274-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22274-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CCB77305A722
	for <lists+linux-rdma@lfdr.de>; Tue, 16 Jun 2026 07:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1859371042;
	Tue, 16 Jun 2026 07:16:53 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C75F314A98;
	Tue, 16 Jun 2026 07:16:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781594213; cv=none; b=W1eh2XdfTNq79h4T5sr/I/ueUtz+sBM/WEqou5SjXMXW4imU0AbsggDDYTe8YzjCMLxFgmoEvPBRGztcHTQnJSTt/RFx8XM/hagSUGaYMZuwDr88Jz83EnRL1/LZ8pWPbzCQvBrO8AjEqfwt75g17Htic8S5qksOUDrdgTtHt08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781594213; c=relaxed/simple;
	bh=JJvclFFT4XihspyYQV8fTcvSA19V8bdOxJ7beK7bQ/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aPRXGgVDtzKrBSGtmDeg+PpO0Jg+y4We01sd/9A1KPAkjGNw6Ob7nmUHnFnrKooGeediL79Eb9oblqOZLZiXE9VnNFfzK/9QiPUOQKkpmet+LWpIh5lxccoUrXOWGV9ROXREss/bq1gM/IDTHa7YYUdHEiuLhHsWMqWdygQz5Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Ikzt/GbZ; arc=none smtp.client-ip=115.124.30.124
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781594200; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=UeT/ZGSsk/AdS30HaVQrJg6VIQfwE5v65FXMb4s19jA=;
	b=Ikzt/GbZABA3D2yhujb/zZPwx8GoRfKs3og4PtERj1Sn0JrcDApfU7gLaDBCm3GVl08xBLFts3DFbl3PnAlFYJpzAnuPlhwLQdvwehAOxXgqHQdrMPt+XPO6ETEtgz6Q7E97Vz7Ihj7Rol219od9fuYs8lnmEHbqR/6bGZ5OaGs=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R911e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X5-RGDy_1781594199;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X5-RGDy_1781594199 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 16 Jun 2026 15:16:39 +0800
Date: Tue, 16 Jun 2026 15:16:39 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org,
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix out-of-bounds read in
 smc_clcsock_data_ready()
Message-ID: <20260616071639.GA104390@j66a10360.sqa.eu95>
References: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260614120931.4041687-1-rhkrqnwk98@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:davem@davemloft.net,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORGED_SENDER(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22274-lists,linux-rdma=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,j66a10360.sqa.eu95:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E92AD68CCB6

On Sun, Jun 14, 2026 at 12:09:30PM +0000, Sechang Lim wrote:
> smc_clcsock_data_ready() is installed on the listen socket and reads its
> sk_user_data as an smc_sock. A passive-open child inherits this callback,
> but sk_clone_lock() clears the child's sk_user_data because it is tagged
> SK_USER_DATA_NOCOPY. smc_tcp_syn_recv_sock() restores the child's af_ops,
> but the inherited sk_data_ready() is left in place until accept.
> 
> In that window the child is established. A cgroup sock_ops program can run
> bpf_sock_hash_update() on it from tcp_init_transfer(); sk_psock_init()
> stores a sk_psock in the NULL sk_user_data. The inherited callback then
> reads sk_user_data via smc_clcsock_user_data(), which masks only
> SK_USER_DATA_NOCOPY, mistakes the sk_psock for an smc_sock, and reads a
> callback pointer past the end of the sk_psock:
> 
>   BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>   Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
>    <IRQ>
>    smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>    tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
>    tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>    tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
>    ip_protocol_deliver_rcu+0x226/0x420 net/ipv4/ip_input.c:207
>    ip_local_deliver_finish+0x35a/0x5f0 net/ipv4/ip_input.c:241
>    __netif_receive_skb_one_core+0x1e5/0x210 net/core/dev.c:6216
>    process_backlog+0x631/0x1470 net/core/dev.c:6682
>    __napi_poll+0xb3/0x320 net/core/dev.c:7749
>    net_rx_action+0x4fa/0xcb0 net/core/dev.c:7969
>    handle_softirqs+0x236/0x800 kernel/softirq.c:622
>    </IRQ>
> 
>   Allocated by task 67930:
>    sk_psock_init+0x142/0x740 net/core/skmsg.c:766
>    sock_map_link+0x646/0xdf0 net/core/sock_map.c:279
>    sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
>    bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
>    __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
>    tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
>    tcp_rcv_state_process+0x241e/0x4940 net/ipv4/tcp_input.c:7231
>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
> 
> Restore the inherited sk_data_ready() in smc_tcp_syn_recv_sock(), where the
> child's sk_user_data is already cleared, rather than only at accept.
> 
> Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/smc/af_smc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index b5db69073e20..152971e8ad17 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -156,6 +156,12 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  	if (child) {
>  		rcu_assign_sk_user_data(child, NULL);
>  
> +		/*
> +		 * the child inherited the listen-specific sk_data_ready();
> +		 * restore it here, as sk_user_data may be reused before accept
> +		 */
> +		child->sk_data_ready = smc->clcsk_data_ready;

One concern:

smc_clcsock_user_data_rcu() together with refcount_inc_not_zero() only
pins the smc_sock; it does not guarantee anything about the lifetime or
consistency of smc->clcsk_data_ready. In the listen-close path,
smc_clcsock_restore_cb() clears that field under sk_callback_lock,
while smc_tcp_syn_recv_sock() reads it without any lock. These are
independent protection domains. If close wins the race,
child->sk_data_ready can end up NULL and the next data arrival will
crash.

Also, I don't object to this fix, but I'd rather see the underlying cause
addressed directly. The real issue seems to be the conflict between
SMC's sk_user_data and sk_psock. Maybe there is a cleaner solution, e.g.
always setting user_data.

> +
>  		/* v4-mapped sockets don't inherit parent ops. Don't restore. */
>  		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
>  			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
> -- 
> 2.43.0

