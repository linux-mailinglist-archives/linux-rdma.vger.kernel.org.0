Return-Path: <linux-rdma+bounces-22428-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oQgTC4EhOmoX2AcAu9opvQ
	(envelope-from <linux-rdma+bounces-22428-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 08:02:41 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AAA26B4566
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 08:02:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.alibaba.com header.s=default header.b=Y9vekp61;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22428-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22428-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.alibaba.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82054302001F
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jun 2026 06:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A8863A9636;
	Tue, 23 Jun 2026 06:02:31 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4C331EB8;
	Tue, 23 Jun 2026 06:02:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782194551; cv=none; b=GPnnoC+Gp4ucLnPAmh7NgQf0fx6ygvjrruuwPa4QEWLcZn4ceGzWTVO6pc+ubZEoQB7EgxVJ2CrOE1UQrag8JdWVgKFkUltLbPaYvtSMxPMXS1PTy5Ngc4lACYCuefnUhyJ8/MOJGDwlhKPhe7Nbu4hIhl5N7aQcDIpzSa0Zjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782194551; c=relaxed/simple;
	bh=Ohl8H5CIdVJ0LZVBp5/kkC99ycMWv9vhyOY2FRSkPyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5NJdIBsjhoREWewXt3UKF+B+4o2Y7VYdAzmw6q9SyF1TLn5Rrwyl6YcTHS16L7ffFUDs6x9SnKeYLMgCA7d5Yp23A9h3YLF2kgo82/oi1bhimGRwOp+8n923FWLfOnDKwIBtEN5jmWQyviHDZxFq6Tk7qLSn9Eydzs8JmU1bIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y9vekp61; arc=none smtp.client-ip=115.124.30.97
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782194539; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=5D6qSgcvkXY5fZhgXS+3C6PguwJ4UnErXlSfTf6hK/0=;
	b=Y9vekp61xn2XhxSvykk9bYtq5TyJ6bTyOa86OlMAzzOKGVp7HLoKyayz+2iRlV0yUWUgJ0rpjkJJiltf4J4gpnu6HSfSAtR+g96UMf83HyOIfEEbjwR2ogbGhYzTS5E+NVe9Cx/IVg0vVDkKqVHGhMd9/lRUH+wK+EgmWBuHjjc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=alibuda@linux.alibaba.com;NM=1;PH=DS;RN=21;SR=0;TI=SMTPD_---0X5SwrVe_1782194538;
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X5SwrVe_1782194538 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 23 Jun 2026 14:02:18 +0800
Date: Tue, 23 Jun 2026 14:02:18 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: "D . Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>, Simon Horman <horms@kernel.org>,
	Ursula Braun <ubraun@linux.ibm.com>,
	Karsten Graul <kgraul@linux.ibm.com>,
	Guvenc Gulce <guvenc@linux.ibm.com>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH net v2] net/smc: fix out-of-bounds read when sk_user_data
 holds a sk_psock
Message-ID: <20260623060218.GA29925@j66a10360.sqa.eu95>
References: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260619150342.3626224-1-rhkrqnwk98@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.16 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	WHITELIST_SPF_DKIM(-3.00)[alibaba.com:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rhkrqnwk98@gmail.com,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:horms@kernel.org,m:ubraun@linux.ibm.com,m:kgraul@linux.ibm.com,m:guvenc@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
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
	TAGGED_FROM(0.00)[bounces-22428-lists,linux-rdma=lfdr.de];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.alibaba.com:dkim,linux.alibaba.com:from_mime,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,j66a10360.sqa.eu95:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9AAA26B4566

On Fri, Jun 19, 2026 at 03:03:41PM +0000, Sechang Lim wrote:
> SMC stores its smc_sock in the clcsock's sk_user_data tagged
> SK_USER_DATA_NOCOPY and reads it back with smc_clcsock_user_data(), which
> only strips that flag. sockmap stores a sk_psock in the same field tagged
> SK_USER_DATA_NOCOPY | SK_USER_DATA_PSOCK. Nothing keeps both off one
> socket, and SMC then casts the sk_psock to an smc_sock.
> 
> A passive-open child hits this. It inherits the listener's
> smc_clcsock_data_ready(), but sk_clone_lock() clears its NOCOPY
> sk_user_data, and a BPF sock_ops program then adds the child to a sockmap,
> installing a sk_psock in that field. The inherited callback reads it as an
> smc_sock and dereferences a clcsk_* pointer past the end of the sk_psock:
> 
>   BUG: KASAN: slab-out-of-bounds in smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>   Read of size 8 at addr ffff8880013b8674 by task syz.6.12484/67930
>    <IRQ>
>    smc_clcsock_data_ready+0x84/0x200 net/smc/af_smc.c:2637
>    tcp_urg+0x24d/0x360 net/ipv4/tcp_input.c:6264
>    tcp_rcv_state_process+0x280d/0x4940 net/ipv4/tcp_input.c:7336
>    tcp_child_process+0x371/0xa50 net/ipv4/tcp_minisocks.c:1002
>    tcp_v4_rcv+0x1eaa/0x2a00 net/ipv4/tcp_ipv4.c:2186
>    [...]
>    </IRQ>
> 
>   Allocated by task 67930:
>    sk_psock_init+0x142/0x740 net/core/skmsg.c:766
>    sock_hash_update_common+0xd3/0x990 net/core/sock_map.c:1010
>    bpf_sock_hash_update+0x114/0x170 net/core/sock_map.c:1229
>    __cgroup_bpf_run_filter_sock_ops+0x74/0xa0 kernel/bpf/cgroup.c:1727
>    tcp_init_transfer+0x1085/0x1100 net/ipv4/tcp_input.c:6693
>    [...]
> 
> sk_psock() already guards the other side, returning NULL unless
> SK_USER_DATA_PSOCK is set. Make smc_clcsock_user_data() and its RCU
> variant return the smc_sock only when sk_user_data carries SMC's tag
> alone. A sk_psock then reads back as NULL, which the data_ready and
> fallback callbacks already handle.
> 
> Fixes: a60a2b1e0af1 ("net/smc: reduce active tcp_listen workers")
> Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
> ---
>  net/smc/smc.h | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc.h b/net/smc/smc.h
> index 52145df83f6e..88dfb459b7cc 100644
> --- a/net/smc/smc.h
> +++ b/net/smc/smc.h
> @@ -342,13 +342,25 @@ static inline void smc_init_saved_callbacks(struct smc_sock *smc)
>  
>  static inline struct smc_sock *smc_clcsock_user_data(const struct sock *clcsk)
>  {
> -	return (struct smc_sock *)
> -	       ((uintptr_t)clcsk->sk_user_data & ~SK_USER_DATA_NOCOPY);
> +	uintptr_t data = (uintptr_t)clcsk->sk_user_data;
> +
> +	/*
> +	 * Return the smc_sock only if the slot carries SMC's tag alone.
> +	 * sockmap stores a sk_psock here tagged SK_USER_DATA_PSOCK; it is
> +	 * not an smc_sock and must not be dereferenced as one.
> +	 */
> +	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
> +		return NULL;
> +	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
>  }
>  
>  static inline struct smc_sock *smc_clcsock_user_data_rcu(const struct sock *clcsk)
>  {
> -	return (struct smc_sock *)rcu_dereference_sk_user_data(clcsk);
> +	uintptr_t data = (uintptr_t)rcu_dereference(__sk_user_data(clcsk));
> +
> +	if ((data & ~SK_USER_DATA_PTRMASK) != SK_USER_DATA_NOCOPY)
> +		return NULL;
> +	return (struct smc_sock *)(data & SK_USER_DATA_PTRMASK);
>  }
>  
>  /* save target_cb in saved_cb, and replace target_cb with new_cb */

No. The core issue is how to resolve the ownership conflict between
sockmap and SMC over sk_user_data, which can by no means be solved by
adding runtime checks on the read path.

Following sk_psock_init(), the simplest approach would be to always
explicitly set sk_user_data or ulp_ops during the active/passive
creation of smc->clcsock, thereby avoiding the conflict at its root.

Additionally, compatibility with sockmap in the fallback path needs to
be considered, though that can be addressed later.

> -- 
> 2.43.0

