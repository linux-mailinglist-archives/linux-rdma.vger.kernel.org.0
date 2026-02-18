Return-Path: <linux-rdma+bounces-16998-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8GY0JESPlWl7SQIAu9opvQ
	(envelope-from <linux-rdma+bounces-16998-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 11:07:00 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1BB15519E
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 11:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 48FA23070DEC
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Feb 2026 10:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A65327C07;
	Wed, 18 Feb 2026 10:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvGkzdz1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5842E8DEC;
	Wed, 18 Feb 2026 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771408944; cv=none; b=BrFiy0+BeM6MB2BqlOWfofkZhGf7DcphVysyMEgLTSh4BK2Tbfpg9JMvBMsAjeqWDzitFiyVm896NtVCeuM0bbRRjA81xgAAs2iHClem8bYzGY5cBKmFINGDCrt6oVj0f0PWvoaAIutMHIKyaE6ThfpVGKMSq7wA6fF4tS5nWHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771408944; c=relaxed/simple;
	bh=ppHUfZIyefvO8OYVwEjG3eZCibw3R2vIPbwCROAL8HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbyVR5fj26Sx/E6tVX/hLI31fF9+rsZHtzKnqi6OFePpFVp9A1TmM2tSj0ruKFvXM9LtdeV6/EhIRvMLyOk8s1WVhdJhGqYM7tln0j6dTp214GoZ6t8Tv72uiTYXpEjhDFiUdmQA/y5Ylr8Fhs6+Llw8Opi7a9qGY1O17/BcbuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvGkzdz1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 407A4C19421;
	Wed, 18 Feb 2026 10:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771408943;
	bh=ppHUfZIyefvO8OYVwEjG3eZCibw3R2vIPbwCROAL8HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jvGkzdz1WNkIU2k8Dtxm7VxdD6fyN9p1USQ58z6Tf+fb8T4zUabSb4nkP5jKvB3Eq
	 o1mBhTZ5ulnNdeEa0aOHDKX6W36EWQQ0xpjo015vCW7FcQN09ETe3gYpXBsnw2qlGr
	 liqcNq1o1t5Oj3Ywc7DzswUrgCjak1BHZ2SxNknUwGFxxcJs4ViG8kZfVzOEZF25X3
	 vDx4l97oBXP4hIaqSg/8HqFPwC0ruuoUQRmE6qltCUR3VoAR5oxx1Odf/6TwkAzn15
	 8Z4kEuw69s4ZfQnuxbsw86mDeg/TCZTCh0VUdBx0xD0EeqTSx0WGFEo6Zhl6urtNS+
	 CVYqAEScDgmDQ==
From: Simon Horman <horms@kernel.org>
To: fmancera@suse.de
Cc: Simon Horman <horms@kernel.org>,
	pabeni@redhat.com,
	davem@davemloft.net,
	allison.henderson@oracle.com,
	syzbot+5efae91f60932839f0a5@syzkaller.appspotmail.com,
	kuba@kernel.org,
	rds-devel@oss.oracle.com,
	gerd.rausch@oracle.com,
	netdev@vger.kernel.org,
	edumazet@google.com,
	linux-rdma@vger.kernel.org
Subject: Re: [net,v2] net/rds: fix recursive lock in rds_tcp_conn_slots_available
Date: Wed, 18 Feb 2026 10:02:06 +0000
Message-ID: <20260218100206.88254-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260217223802.21659-1-fmancera@suse.de>
References: <20260217223802.21659-1-fmancera@suse.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-16998-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	PRECEDENCE_BULK(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,5efae91f60932839f0a5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 3B1BB15519E
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email says "I'm passing this on, not becuase of the first coment
regarding fan-out, which I think seems reasonable in it's current
form. But because of the second comment, at the end, regarding the
receive path. I'm not sure about that one either way, but it seems
worth passing on to you."

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/rds: fix recursive lock in rds_tcp_conn_slots_available

This commit addresses a recursive lock warning reported by syzbot in
rds_tcp_get_peer_sport() by replacing kernel_getpeername() calls with
direct socket struct access to read the peer port number.

Closes: https://syzkaller.appspot.com/bug?extid=5efae91f60932839f0a5

> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index 185f73b01694..a542f94c0214 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -455,6 +455,9 @@ void rds_conn_shutdown(struct rds_conn_path *cp)
>  		rcu_read_unlock();
>  	}
>
> +	/* we do not hold the socket lock here but it is safe because
> +	 * fan-out is disabled when calling conn_slots_available()
> +	 */

Is this comment potentially misleading about the safety reasoning?

The comment says "we do not hold the socket lock here but it is safe
because fan-out is disabled." This is factually accurate - with fan_out
set to false, the code path that reads from the socket (via
rds_tcp_get_peer_sport) is never reached.

However, the phrasing could confuse readers about what happens if fan_out
were true but the lock weren't held. In that scenario, the new code
(reading inet_dport directly) would still be safe because inet_dport is an
atomic-width read of a stable field.

The comment conflates two independent safety properties: (1) the socket
isn't accessed at all when fan_out is false, and (2) if it were accessed,
the new implementation would still be safe without the lock.

Could the comment more precisely explain the safety reasoning?

>  	if (conn->c_trans->conn_slots_available)
>  		conn->c_trans->conn_slots_available(conn, false);
>  }

[ ... ]

> @@ -59,30 +59,12 @@ void rds_tcp_keepalive(struct socket *sock)
>  static int
>  rds_tcp_get_peer_sport(struct socket *sock)
>  {
> -	union {
> -		struct sockaddr_storage storage;
> -		struct sockaddr addr;
> -		struct sockaddr_in sin;
> -		struct sockaddr_in6 sin6;
> -	} saddr;
> -	int sport;
> -
> -	if (kernel_getpeername(sock, &saddr.addr) >= 0) {
> -		switch (saddr.addr.sa_family) {
> -		case AF_INET:
> -			sport = ntohs(saddr.sin.sin_port);
> -			break;
> -		case AF_INET6:
> -			sport = ntohs(saddr.sin6.sin6_port);
> -			break;
> -		default:
> -			sport = -1;
> -		}
> -	} else {
> -		sport = -1;
> -	}
> +	struct sock *sk = sock->sk;
> +
> +	if (!sk)
> +		return -1;
>
> -	return sport;
> +	return ntohs(inet_sk(sk)->inet_dport);
>  }

The commit message states "For rds_tcp_conn_slots_available() the lock is
already held because we are in the receiving path." Is this claim accurate
across all receive paths?

Looking at the two receive sub-paths:

1. In the backlog processing path (shown in the syzbot stack trace), the
socket IS owned because __release_sock() runs while the lock_sock
ownership bit is still set:

tcp_sock_set_cork() -> lock_sock() -> release_sock() -> __release_sock()
  -> sk_backlog_rcv() -> tcp_v6_do_rcv() -> tcp_rcv_established()
  -> tcp_data_ready() -> sk->sk_data_ready() -> rds_tcp_data_ready()
  -> rds_tcp_read_sock()

2. However, rds_tcp_data_ready() can also be called directly from the
normal softirq receive path via tcp_data_ready() -> sk->sk_data_ready(),
where the socket lock is NOT held. In this path, rds_tcp_read_sock()
calls tcp_read_sock() without lock_sock.

The fix is still correct in both cases because inet_dport is a stable
atomic-width field, but the claim "the lock is already held" is not
universally true for all receiving paths.

Should the commit message be more precise about when the lock is held?

