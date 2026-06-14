Return-Path: <linux-rdma+bounces-22199-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Me7ZMVr2LWpHngQAu9opvQ
	(envelope-from <linux-rdma+bounces-22199-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 02:31:22 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1E26801D8
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 02:31:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="c/Qs4wWo";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22199-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22199-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3770F300B06E
	for <lists+linux-rdma@lfdr.de>; Sun, 14 Jun 2026 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFD023183C;
	Sun, 14 Jun 2026 00:31:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117991E9B37;
	Sun, 14 Jun 2026 00:31:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781397076; cv=none; b=D9gJgKbL1g7+XDBH0tIlWdeSkce7sHMf3gpz9H8k/8gPcuwNdZHoYjWgRF8vdYa6iDouuT7rL/78b1lbj7aNj6BH95SbJPecHgc6CRW932Cs+w40Nswpq6T104hXLNxcpFb+nOILFS0vHXpX8dlJpqZ3Bs2qmouSL2EHwetTZuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781397076; c=relaxed/simple;
	bh=8mYJYvcpyLC563E8e5G/kEn95obSwkzshUm0zHc6GYI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZkybE04Og6CZ96sFsJ3RK6A1VxgTY3gCn8ZXJQz4oKfffSIdZtn76rB7CRWGLAHsQ0JvHPXA0pnvi5xfYdL8TkWyuvV+ohxM0Sl0YClRnQvjFdRSAjbjstsT1C8kAj/fY7sh5fgY9uB1AKxuDI/xZoXSGWFL3gjxNpxgjRzA05w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c/Qs4wWo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB56F1F000E9;
	Sun, 14 Jun 2026 00:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781397074;
	bh=Osk2e50RUY4RQGcxII9so6cvH9/DLpbiJiZuFVeibpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=c/Qs4wWoUXcIn20mRXYd2HSircOepmYOc8868RlrPLkaGMQk2trCwEkObid+Ng4FX
	 +U1IPGkzrUgmKn+Lvsbbup3F6AswV+tiqYvbJ85XEv+jpsfTAxEH9NMNmGRgZKRANr
	 aPbn7+fjKNRUuGXpfVqm/uQ3+ERJwVxd/5oDwOdzUXGUrruj8YgLA7kXZFY2RkJuGu
	 MI3dvFvFp1qA3zwyIegXBDdrnJOu4FPwBlaX6a/RKj37GthWQlgXrPd+RVpXv7XX+t
	 MP9TrqqdlUTz3RUI8pJeQjlXjrMHUnEVMNtDD87vkdqOQ6emZ24SAd+r/ltjdniTPT
	 bV14SqWVgEgSA==
From: Jakub Kicinski <kuba@kernel.org>
To: hexlabsecurity@proton.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	raspl@linux.ibm.com,
	ubraun@linux.ibm.com,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/smc: bound the peer producer cursor on SMC-D and SMC-R CDC receive
Date: Sat, 13 Jun 2026 17:31:11 -0700
Message-ID: <20260614003111.383195-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260610084803.186516-1-hexlabsecurity@proton.me>
References: <20260610084803.186516-1-hexlabsecurity@proton.me>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22199-lists,linux-rdma=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:hexlabsecurity@proton.me,m:kuba@kernel.org,m:alibuda@linux.alibaba.com,m:dust.li@linux.alibaba.com,m:sidraya@linux.ibm.com,m:wenjia@linux.ibm.com,m:mjambigi@linux.ibm.com,m:tonylu@linux.alibaba.com,m:guwen@linux.alibaba.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:raspl@linux.ibm.com,m:ubraun@linux.ibm.com,m:linux-rdma@vger.kernel.org,m:linux-s390@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2B1E26801D8

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/smc: bound the peer producer cursor on SMC-D and SMC-R CDC receive

This patch attempts to close an out-of-bounds read in the SMC CDC
receive path by clamping the peer producer cursor and the
bytes_to_rcv accumulator against rmb_desc->len.  A couple of
questions on the approach below.

> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 619b3bab3824..738c45fd5cd0 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -382,6 +382,8 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>  		smp_mb__before_atomic();
>  		atomic_add(diff_prod, &conn->bytes_to_rcv);
>  		/* guarantee 0 <= bytes_to_rcv <= rmb_desc->len */
> +		if (atomic_read(&conn->bytes_to_rcv) > conn->rmb_desc->len)
> +			atomic_set(&conn->bytes_to_rcv, conn->rmb_desc->len);

[Critical]
Is this clamp safe against a concurrent smc_rx_recvmsg() on another
CPU?

smc_cdc_msg_recv() runs the BH path under bh_lock_sock() (slock with
BH disabled), while smc_rx_recvmsg() runs under lock_sock(), which
sets sk_lock.owned but releases the slock for the body of the
syscall.  The body contains:

    /* update cursors */
    if (!(flags & MSG_PEEK)) {
        smp_mb__before_atomic();
        atomic_sub(copylen, &conn->bytes_to_rcv);
        smp_mb__after_atomic();
        ...
    }

so the BH on CPU0 and the recvmsg body on CPU1 can run concurrently
on the same connection.

The new clamp here is a non-atomic read-then-set:

    atomic_add(diff_prod, &conn->bytes_to_rcv);
    if (atomic_read(&conn->bytes_to_rcv) > conn->rmb_desc->len)
        atomic_set(&conn->bytes_to_rcv, conn->rmb_desc->len);

With L = rmb_desc->len, the commit message notes that the
differing-wrap branch of smc_curs_diff() can return up to
(L - old.count) + new.count, i.e. close to 2L, even after the count
itself is clamped.  Can the following interleaving happen?

  CPU0 (BH)                                CPU1 (recvmsg)
  atomic_add(diff_prod) -> X (~2L)
                                           readable =
                                             atomic_read(&bytes_to_rcv) = X
                                           copylen = min(remaining, X)
                                           chunk_len = min(copylen,
                                                           L - cons.count)
                                           second chunk = copylen - chunk_len
                                           memcpy_to_msg(rcvbuf_base + 0,
                                                         second_chunk_len)
  atomic_read() -> X
  atomic_set(&bytes_to_rcv, L)

With cons.count near L/2 and copylen near 2L, the second chunk reads
roughly 3L/2 bytes starting at rcvbuf_base + 0, walking past the end
of the RMB allocation.  Is that not the same OOB read this patch is
meant to close?

A second variant of the same race seems to silently corrupt the
counter:

  CPU0 (BH)                                CPU1 (recvmsg)
  atomic_add(diff_prod)        -> X > L
                                           atomic_sub(Y) -> X - Y
  atomic_read()                -> X - Y
  (X - Y still > L?)
  atomic_set(L)

If X - Y is still above L, CPU0 overwrites the consumer's decrement
and bytes_to_rcv ends up at L even though Y bytes were already
consumed, leaving a persistent over-report that future recvmsg calls
use as readable.

smp_mb__after_atomic() does not turn this read-then-set into an RMW;
atomic_set() is a relaxed store.  Would clamping diff_prod against
(L - atomic_read(&bytes_to_rcv)) before the atomic_add (or using an
atomic_cmpxchg loop) close both windows?

>  		smp_mb__after_atomic();
>  		smc->sk.sk_data_ready(&smc->sk);
>  	} else {
> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303..7fa6e0d3817f 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
> @@ -230,6 +230,12 @@ static inline void smc_cdc_cursor_to_host(union smc_host_cursor *local,
>  	smc_curs_copy_net(&net, peer, conn);
>  	temp.count = ntohl(net.count);
>  	temp.wrap = ntohs(net.wrap);
> +	/* the peer producer cursor is wire-controlled; bound the SMC-R count to
> +	 * our RMB before it is used as a raw index by the urgent path, mirroring
> +	 * the SMC-D conversion in smcd_cdc_msg_to_host().
> +	 */
> +	if (temp.count > conn->rmb_desc->len)
> +		temp.count = conn->rmb_desc->len;

[High]
Should this clamp live in the shared helper, or only on the prod
call site?

smc_cdc_cursor_to_host() is invoked twice from smcr_cdc_msg_to_host():

    smc_cdc_cursor_to_host(&local->prod, &peer->prod, conn);
    smc_cdc_cursor_to_host(&local->cons, &peer->cons, conn);

The producer cursor is bounded by our local RMB (conn->rmb_desc->len),
but the consumer cursor lives in the peer's RMB space and is bounded
by conn->peer_rmbe_size, which is set independently in
smcr_conn_save_peer_info() from the peer's CLC bufsize.

smc_cdc_msg_recv_action() confirms the asymmetry:

    diff_cons = smc_curs_diff(conn->peer_rmbe_size, &cons_old,
                              &conn->local_rx_ctrl.cons);
    ...
    atomic_add(diff_cons, &conn->peer_rmbe_space);

so peer_rmbe_size (not rmb_desc->len) is the right bound for the cons
cursor.

Whenever peer_rmbe_size > rmb_desc->len, legitimate peer cons.count
values in (rmb_desc->len, peer_rmbe_size] are silently truncated to
rmb_desc->len here, diff_cons is under-credited and
peer_rmbe_space stays artificially low, which can stall TX flow
control on perfectly well-behaved peers.

The SMC-D companion in this same patch is structured the way the
prod/cons asymmetry suggests -- it clamps prod and copies cons
unmodified:

> @@ -260,6 +266,12 @@ static inline void smcd_cdc_msg_to_host(struct smc_host_cdc_msg *local,
>  
>  	temp.wrap = peer->prod.wrap;
>  	temp.count = peer->prod.count;
> +	/* the peer producer cursor is wire-controlled; a count past our RMB is
> +	 * used as a raw index by the urgent path (smc_cdc_handle_urg_data_arrival)
> +	 * and as a length by the recv path.  Bound it to the RMB.
> +	 */
> +	if (temp.count > conn->rmb_desc->len)
> +		temp.count = conn->rmb_desc->len;
>  	smc_curs_copy(&local->prod, &temp, conn);
>  
>  	temp.wrap = peer->cons.wrap;

Should the SMC-R hunk be moved out of the shared smc_cdc_cursor_to_host()
helper and onto the prod call site in smcr_cdc_msg_to_host(), to match
the SMC-D shape?
-- 
pw-bot: cr

