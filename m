Return-Path: <linux-rdma+bounces-18063-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wBgOCpQtsmmzJQAAu9opvQ
	(envelope-from <linux-rdma+bounces-18063-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:05:56 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC1226C924
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 04:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EC55F30B67D5
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Mar 2026 03:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FE6376BE8;
	Thu, 12 Mar 2026 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="quDFMvMt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94C1C41A8F;
	Thu, 12 Mar 2026 03:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773284723; cv=none; b=G6nT3MSWDgBfD2faTDjvWlkkOwMMJBXKpG4rsmggE040yAXkHcikTR1CxrfavTsDk4KmkvhrEcMzLMdhg4qcH2aaQw/y71DKukDmUrLbtL6N3iw/wEo1mzqZk1BPpRyiNUuYBnfcy1M8qH10FfD+B11jWOXAPkZ0ccvAMEsDX0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773284723; c=relaxed/simple;
	bh=GASPTmnpoUnzS8gsHiVcHdbchQoQtvTwDaFKlQx8S3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CxRhzlnCoSBPLjPrFDtOw4Gi5AAt39C+qKNV0D5U+8cwwjEwYLrlOUWtTypzYiHg3Djk4+BOus4D/nQABztXZS+8BpFuJEtJiOZUqx9BhEJAbiMksHqF1z1eIfEXm+ijlm3Hp8O0vWLMcurh8ZfPOVZB/hYuNPX+U1uNQWQPpfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=quDFMvMt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3078C4CEF7;
	Thu, 12 Mar 2026 03:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773284723;
	bh=GASPTmnpoUnzS8gsHiVcHdbchQoQtvTwDaFKlQx8S3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=quDFMvMteEZ0URno19WX0w1AETBg2BinT4vxTH4+xL0mS2WY5eKqkv1O1VZyMPbBM
	 /lbjTErc/6hJ95PJ9+n8hNteXjZCU5NaG2Gy1aDxbDrfLbWPhTHdt9QE0N+F04jBEf
	 23AKf3PxVWCwxErvE1qi3yXaci7kq0hJ6g/WWcLTUBASqVlEjGX88LsFKXjcP11dWb
	 u50K2vF62JnNIbzNjokRo+7BDKdZTso4Kn3mFbWx7pmr6bYOCNSGmgALQHWO8cVsSu
	 N+1vjApoo9/6AL2UqyUwl6hFWEF+fImLgcLV1ns1ae2ZxGPvqg+zUUVgZX/nzMdFTc
	 GVZ2UEogOck8g==
From: Jakub Kicinski <kuba@kernel.org>
To: jiayuan.chen@linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>,
	jiayuan.chen@shopee.com,
	mjambigi@linux.ibm.com,
	wenjia@linux.ibm.com,
	horms@kernel.org,
	sidraya@linux.ibm.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	dust.li@linux.alibaba.com,
	syzbot+827ae2bfb3a3529333e9@syzkaller.appspotmail.com,
	pabeni@redhat.com,
	tonylu@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	edumazet@google.com,
	alibuda@linux.alibaba.com
Subject: Re: [net,v4] net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()
Date: Wed, 11 Mar 2026 20:05:20 -0700
Message-ID: <20260312030520.626362-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311022451.395802-1-jiayuan.chen@linux.dev>
References: <20260311022451.395802-1-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-18063-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,827ae2bfb3a3529333e9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: BBC1226C924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/smc: fix NULL dereference and UAF in smc_tcp_syn_recv_sock()

This patch fixes a race condition in smc_tcp_syn_recv_sock() where
sk_user_data can be nullified or the smc_sock can be freed during
concurrent socket closure, using RCU and refcount_inc_not_zero() for
safe access.

Closes: https://lore.kernel.org/all/67eaf9b8.050a0220.3c3d88.004a.GAE@google.com/T/

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

The race diagram describes the tcp_check_req() path (TCP_NEW_SYN_RECV
handling), but the actual syzbot crash occurred through a different path.
Looking at the syzbot stacktrace, the crash shows:

smc_tcp_syn_recv_sock+0xa7/0x4b0 called from tcp_get_cookie_sock+0xd5/0x790

This is the SYN cookie path:

tcp_v4_rcv() -> tcp_v4_do_rcv() -> tcp_v4_cookie_check() ->
cookie_v4_check() -> tcp_get_cookie_sock() -> smc_tcp_syn_recv_sock()

The syzbot log even shows 'Possible SYN flooding on port [::]:20002.
Sending cookies.' confirming syncookies were active. Both paths are
vulnerable to the race, but the race diagram doesn't match the actual
crash path that the fuzzer triggered.

Would it be more accurate to note that both paths (tcp_check_req for
normal SYN handling and tcp_get_cookie_sock for SYN cookies) can trigger
the race?

> diff --git a/net/smc/af_smc.c b/net/smc/af_smc.c
> --- a/net/smc/af_smc.c
> +++ b/net/smc/af_smc.c
> @@ -131,7 +131,13 @@ static struct sock *smc_tcp_syn_recv_sock(const struct sock *sk,
>  	struct smc_sock *smc;
>  	struct sock *child;
>
> -	smc = smc_clcsock_user_data(sk);
> +	rcu_read_lock();
> +	smc = smc_clcsock_user_data_rcu(sk);
> +	if (!smc || !refcount_inc_not_zero(&smc->sk.sk_refcnt)) {
> +		rcu_read_unlock();
> +		return NULL;

When smc_tcp_syn_recv_sock() is called from the SYN cookie path
(tcp_get_cookie_sock() in net/ipv4/syncookies.c:205 and
net/ipv6/syncookies.c:275), the dst parameter is non-NULL.

The new early return here returns NULL without calling dst_release(dst).
The syn_recv_sock contract requires the callee to either consume dst
(attach to child socket on success) or release it (call dst_release on
failure).

Looking at tcp_get_cookie_sock() in net/ipv4/syncookies.c:

    child = af_ops->syn_recv_sock(..., &dst, ...)
    if (!child) {
        reqsk_free(req);
        return NULL;
    }

When syn_recv_sock returns NULL, tcp_get_cookie_sock immediately returns
NULL without releasing dst, expecting the syn_recv_sock callee to have
already handled it.

The existing 'drop:' label at line 165 correctly calls dst_release(dst),
but the new early return at line 138 bypasses it. This causes a dst_entry
reference count leak under SYN flood conditions on an SMC listener.

Should this be: goto drop instead of return NULL, or should dst_release(dst)
be added before the return NULL?

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
> @@ -254,7 +262,7 @@ static void smc_fback_restore_callbacks(struct smc_sock *smc)
>  	struct sock *clcsk = smc->clcsock->sk;
>
>  	write_lock_bh(&clcsk->sk_callback_lock);
> -	clcsk->sk_user_data = NULL;
> +	rcu_assign_sk_user_data(clcsk, NULL);
>
>  	smc_clcsock_restore_cb(&clcsk->sk_state_change, &smc->clcsk_state_change);
>  	smc_clcsock_restore_cb(&clcsk->sk_data_ready, &smc->clcsk_data_ready);

[ ... ]

> @@ -2687,10 +2695,11 @@ int smc_listen(struct socket *sock, int backlog)
>  		write_lock_bh(&smc->clcsock->sk->sk_callback_lock);
>  		smc_clcsock_restore_cb(&smc->clcsock->sk->sk_data_ready,
>  				       &smc->clcsk_data_ready);
> -		smc->clcsock->sk->sk_user_data = NULL;
> +		rcu_assign_sk_user_data(smc->clcsock->sk, NULL);
>  		write_unlock_bh(&smc->clcsock->sk->sk_callback_lock);
>  		goto out;
>  	}
> +	sock_set_flag(sk, SOCK_RCU_FREE);
>  	sk->sk_max_ack_backlog = backlog;
>  	sk->sk_ack_backlog = 0;
>  	sk->sk_state = SMC_LISTEN;

[ ... ]
-- 
pw-bot: cr

