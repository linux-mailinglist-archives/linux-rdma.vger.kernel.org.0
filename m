Return-Path: <linux-rdma+bounces-20306-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iC++JfecAGoGLAEAu9opvQ
	(envelope-from <linux-rdma+bounces-20306-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 16:57:59 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F2839504AC3
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2CCD300D698
	for <lists+linux-rdma@lfdr.de>; Sun, 10 May 2026 14:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8F239EF11;
	Sun, 10 May 2026 14:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vKQwM30Q"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F290234CFD0;
	Sun, 10 May 2026 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778425051; cv=none; b=qvO8/E+/JUa3z6vDGPFwu72E2pUPFDxwy6Y5u5kML9yqioSPBdQEWaspmu8UykV/xpqPoTulB3dgxGF+SL6rWvp2Jx63HHXHPUsOHYKOEpvS0WJV8FcKD+H5gl2QOqYs/2fUe2affpHp3QeXP34ELUIna1VGHy3rfEQk3JLSomA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778425051; c=relaxed/simple;
	bh=wOtHkB9Mlz3SS+ubzxZDx0L04GF9pzB1MyoMiNKCABA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EVwW5dNOSziCNq14P8zEDaSjcm9zmXl0ai3kkbCmYwKRchjpY+SSdGPp0lBfFLqYeQM1FKWvyrXgTHGrx93iQEDj1BfbvIEEftz1smA01flu+EP44cfHBG65tBppFKC/QSZxaN0qZErjvlg8OVUN32ig9CexsxbamgV/oZTmBDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vKQwM30Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E960C2BCB8;
	Sun, 10 May 2026 14:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778425050;
	bh=wOtHkB9Mlz3SS+ubzxZDx0L04GF9pzB1MyoMiNKCABA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vKQwM30QdHOP1Fqk81Ma/ZM4UMWfbKRsCYZ+AF735XLG3/yZ/YKYKtEBzHrcrXDKx
	 KNESAXQTaLEjjhSFdZHu7tWbWJKxPe91VpFHmjK5PdFCv1xN+q0wMjTviV5yWQxOK4
	 3rrgRc4fB+5H8GXp2a8aRJlfexlrsUiirCLZq60YBcYgRafaEk+jMLQPkNZBTLg57U
	 Vanp9RyWXtQ4Am5mIKFWSNWEf4cCMYC3R6f1arrjvJnVWdfWfb0vzIpYfkYoOWEdE5
	 mUokus49hpx1WVcPAmDPG4dJpbaOaUv0KFSRC/93CFpSaorC1EfrxFPk/7Y0i/edqB
	 NFsNlgaBTtg0Q==
From: Simon Horman <horms@kernel.org>
To: maoyixie.tju@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	achender@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	maoyi.xie@ntu.edu.sg,
	praveen.kakkolangara@aumovio.com
Subject: Re: [PATCH net v2] rds: filter RDS_INFO_* getsockopt by caller's netns
Date: Sun, 10 May 2026 15:54:27 +0100
Message-ID: <20260510145425.1372018-3-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260507081332.2868770-1-maoyixie.tju@gmail.com>
References: <20260507081332.2868770-1-maoyixie.tju@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2839504AC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-20306-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.947];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
rds: filter RDS_INFO_* getsockopt by caller's netns

This commit updates the RDS_INFO_* getsockopt handlers to filter sockets and
connections by the caller's network namespace. This prevents users in
isolated namespaces from reading host-wide socket state.

> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 76f625986a7f2..98f3cfd48b813 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
[ ... ]
> @@ -847,17 +859,24 @@ static void rds6_sock_info(struct socket *sock, unsigned int len,
>  			   struct rds_info_iterator *iter,
>  			   struct rds_info_lengths *lens)
>  {
> +	struct net *net = sock_net(sock->sk);
>  	struct rds6_info_socket sinfo6;
> +	unsigned int cnt = 0;
>  	struct rds_sock *rs;
>  
>  	len /= sizeof(struct rds6_info_socket);
>  
>  	spin_lock_bh(&rds_sock_lock);
>  
> -	if (len < rds_sock_count)
> +	if (len < rds_sock_count) {
> +		cnt = rds_sock_count;
>  		goto out;
> +	}

Does this early-out check using the global rds_sock_count break the namespace
isolation and force callers to over-allocate memory?

If a user in an isolated network namespace provides a 0-length buffer to probe
the required size, len < rds_sock_count evaluates to true and the global count
is returned to userspace. Could this allow a user to track the exact host-wide
number of RDS sockets?

Additionally, if an isolated container has 1 socket but the host system has
thousands, the kernel might reject a correctly sized buffer with -ENOSPC and
demand a buffer large enough for all system-wide sockets. Is it possible to
remove this global counter check and always iterate the list to return the
exact netns-filtered count?

Simon says: I'm not convinced that the issue flagged above is a bug.
            But it does seem suboptimal to me.

>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
[ ... ]
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 654e23d13e3df..ef9e958cafb4f 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
[ ... ]
> @@ -235,20 +235,27 @@ static void rds_tcp_tc_info(struct socket *rds_sock, unsigned int len,
>  			    struct rds_info_iterator *iter,
>  			    struct rds_info_lengths *lens)
>  {
[ ... ]
>  	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
>  		struct inet_sock *inet = inet_sk(tc->t_sock->sk);

Simon says: As a pre-existing issue I don't think this needs to block
            progress of this patch. But it does seem worth investigating
	    (perhaps that is already happening?).

Can concurrent getsockopt calls trigger a NULL pointer dereference here?

While this isn't a regression introduced by this patch, it appears there is
a race condition during list traversal. Looking at rds_tcp_set_callbacks(), a
newly allocated connection tc is added to rds_tcp_tc_list under the lock, but
the lock is released before tc->t_sock is assigned:

rds_tcp_set_callbacks() {
    spin_lock(&rds_tcp_tc_list_lock);
    list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
    ...
    spin_unlock(&rds_tcp_tc_list_lock);
    ...
    tc->t_sock = sock;
}

If a caller concurrently executes this getsockopt handler during that window,
it would acquire the lock, observe the new entry, and attempt to evaluate
inet_sk(tc->t_sock->sk). Since tc->t_sock is still NULL, would dereferencing
NULL->sk result in a panic?

>  		if (tc->t_cpath->cp_conn->c_isv6)
>  			continue;
> +		/* Only show connections in the caller's netns. */
> +		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
> +			continue;
>  
>  		tsinfo.local_addr = inet->inet_saddr;

