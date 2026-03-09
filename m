Return-Path: <linux-rdma+bounces-17745-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eMvQJ2ZjrmlbCwIAu9opvQ
	(envelope-from <linux-rdma+bounces-17745-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 07:06:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CBAE23413E
	for <lists+linux-rdma@lfdr.de>; Mon, 09 Mar 2026 07:06:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2817300D947
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2026 06:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E65D234D902;
	Mon,  9 Mar 2026 06:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Wnn9abNe"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA0336894;
	Mon,  9 Mar 2026 06:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773036382; cv=none; b=XO+DgPil6rEmWd0XJzaOy0lVZyGO7qYd6fnuehNM7KNH+8up7+pbzf+ZV8yz2EEz4ozlpsu5edMQ159FKg2KQSsjTQeIh5VwCRVYpO82IwiGFZXwdr1i5FTvsCOJq6lsWHjjF4gLQrRtDgY7uEdIPdtFCQzERYctnwn8e5y5ZKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773036382; c=relaxed/simple;
	bh=2YI9AKJjBSCzEUKsa+As6mznfoXkSfwgK6NyIZZ21N8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CvVuJq3hqKuiO9tpI0+0XjwVyw3v8jnb5ITtMEH/OCOaR30LVM+twMo64LKEfu0XZGqnl0BJ+Jh944dMeEkqDmruxiAQ57MqKSCyPND/J992+E5qKMF+FSybxi7US5ib4qmUHzClnDYQEtih36cYLdAUMcL1s8nd3PMUSLOoZwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Wnn9abNe; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773036372; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=cwjmxtMna3QTTbBzSWg0RIeWT7P+DPhE3JlwWCOxQmY=;
	b=Wnn9abNeTK93vp2kzLW7fK6JAMhlAIOT/wO5EVvehvLh93KwgVctr+eGYnxaKLwALBJdOpQFnamoql2RPbmmHgG86+d/7ZTtJEiwXZnhTjb/a5J1+9Ih+tiP+6UDmEF2cUQLAiA/Wb0V4EORg2hRwURjA35OQxBPlbvKi3tWsHw=
Received: from localhost(mailfrom:alibuda@linux.alibaba.com fp:SMTPD_---0X-UQbA9_1773036371 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 09 Mar 2026 14:06:11 +0800
Date: Mon, 9 Mar 2026 14:06:11 +0800
From: "D. Wythe" <alibuda@linux.alibaba.com    >
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org,
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com,
	Eric Dumazet <edumazet@google.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Dust Li <dust.li@linux.alibaba.com>,
	Sidraya Jayagond <sidraya@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Mahanta Jambigi <mjambigi@linux.ibm.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net/smc: fix NULL dereference and UAF in
 smc_tcp_syn_recv_sock()
Message-ID: <20260309060611.GA130186@j66a10360.sqa.eu95>
References: <20260309023846.18516-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309023846.18516-1-jiayuan.chen@linux.dev>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Rspamd-Queue-Id: 4CBAE23413E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-7.66 / 15.00];
	WHITELIST_DMARC(-7.00)[alibaba.com:D:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.alibaba.com,none];
	R_DKIM_ALLOW(-0.20)[linux.alibaba.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17745-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alibuda@linux.alibaba.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.alibaba.com:+];
	NEURAL_HAM(-0.00)[-0.990];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,appspotmail.com:email,linux.alibaba.com:dkim]
X-Rspamd-Action: no action

On Mon, Mar 09, 2026 at 10:38:45AM +0800, Jiayuan Chen wrote:
> Syzkaller reported a panic in smc_tcp_syn_recv_sock() [1].
> 
> smc_tcp_syn_recv_sock() is called in the TCP receive path
> (softirq) via icsk_af_ops->syn_recv_sock on the clcsock (TCP
> listening socket). It reads sk_user_data to get the smc_sock
> pointer. However, when the SMC listen socket is being closed
> concurrently, smc_close_active() sets clcsock->sk_user_data
> to NULL under sk_callback_lock, and then the smc_sock itself
> can be freed via sock_put() in smc_release().
> 
> This leads to two issues:
> 
> 1) NULL pointer dereference: sk_user_data is NULL when
>    accessed.
> 2) Use-after-free: sk_user_data is read as non-NULL, but the
>    smc_sock is freed before its fields (e.g., queued_smc_hs,
>    ori_af_ops) are accessed.
> 
> The race window looks like this:
> 
>   CPU A (softirq)              CPU B (process ctx)
> 
>   tcp_v4_rcv()
>     TCP_NEW_SYN_RECV:
>     sk = req->rsk_listener
>     sock_hold(sk)
>     /* No lock on listener */
>                                smc_close_active():
>                                  write_lock_bh(cb_lock)
>                                  sk_user_data = NULL
>                                  write_unlock_bh(cb_lock)
>                                  ...
>                                  smc_clcsock_release()
>                                  sock_put(smc->sk) x2
>                                    -> smc_sock freed!
>     tcp_check_req()
>       smc_tcp_syn_recv_sock():
>         smc = user_data(sk)
>           -> NULL or dangling
>         smc->queued_smc_hs
>           -> crash!
> 
> Note that the clcsock and smc_sock are two independent objects
> with separate refcounts. TCP stack holds a reference on the
> clcsock, which keeps it alive, but this does NOT prevent the
> smc_sock from being freed.
> 
> Fix this by using RCU and refcount_inc_not_zero() to safely
> access smc_sock. Since smc_tcp_syn_recv_sock() is called in
> the TCP three-way handshake path, taking read_lock_bh on
> sk_callback_lock is too heavy and would not survive a SYN
> flood attack. Using rcu_read_lock() is much more lightweight.
> 
> - Set SOCK_RCU_FREE on the SMC listen socket so that
>   smc_sock freeing is deferred until after the RCU grace
>   period. This guarantees the memory is still valid when
>   accessed inside rcu_read_lock().
> - Use rcu_read_lock() to protect reading sk_user_data.
> - Use refcount_inc_not_zero(&smc->sk.sk_refcnt) to pin the
>   smc_sock. If the refcount has already reached zero (close
>   path completed), it returns false and we bail out safely.
> 
> Note: smc_hs_congested() has a similar lockless read of
> sk_user_data without rcu_read_lock(), but it only checks for
> NULL and accesses the global smc_hs_wq, never dereferencing
> any smc_sock field, so it is not affected.
> 
> Reproducer was verified with mdelay injection and smc_run,
> the issue no longer occurs with this patch applied.
> 
> [1] https://syzkaller.appspot.com/bug?extid=827ae2bfb3a3529333e9
> 
> Fixes: 8270d9c21041 ("net/smc: Limit backlog connections")
> Reported-by: syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@google.com/T/
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
> ---
> v2:
> - Use rcu_read_lock() + refcount_inc_not_zero() instead of
>   read_lock_bh(sk_callback_lock) + sock_hold(), since this
>   is the TCP handshake hot path and read_lock_bh is too
>   expensive under SYN flood.
> - Set SOCK_RCU_FREE on SMC listen socket to ensure
>   RCU-deferred freeing.
> 
> v1: https://lore.kernel.org/netdev/20260307032158.372165-1-jiayuan.chen@linux.dev/
> ---
>  net/smc/af_smc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> index d0119afcc6a1..72ac1d8c62d4 100644
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -131,7 +131,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  	struct smc_sock *smc;
>  	struct sock *child;
>  
> +	rcu_read_lock();
>  	smc = smc_clcsock_user_data(sk);
> +	if (!smc || !refcount_inc_not_zero(&smc->sk.sk_refcnt)) {
> +		rcu_read_unlock();
> +		return NULL;
> +	}
> +	rcu_read_unlock();
>  
>  	if (READ_ONCE(sk->sk_ack_backlog) + atomic_read(&smc->queued_smc_hs) >
>  				sk->sk_max_ack_backlog)
> @@ -153,11 +159,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  		if (inet_csk(child)->icsk_af_ops == inet_csk(sk)->icsk_af_ops)
>  			inet_csk(child)->icsk_af_ops = smc->ori_af_ops;
>  	}
> +	sock_put(&smc->sk);
>  	return child;
>  
>  drop:
>  	dst_release(dst);
>  	tcp_listendrop(sk);
> +	sock_put(&smc->sk);
>  	return NULL;
>  }
>  
> @@ -2691,6 +2699,7 @@ int smc_listen(struct socket *sock, int backlog)
>  		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
>  		goto out;
>  	}
> +	sock_set_flag(sk, SOCK_RCU_FREE);

This RCU approach looks good to me. Since SOCK_RCU_FREE is now enabled,
other callers of smc_clcsock_user_data() should also follow this
RCU-based pattern. It will eventually allow us to completely remove the
annoying sk_callback_lock.

D. Wythe

>  	sk->sk_max_ack_backlog = backlog;
>  	sk->sk_ack_backlog = 0;
>  	sk->sk_state = SMC_LISTEN;
> -- 
> 2.43.0

