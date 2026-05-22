Return-Path: <linux-rdma+bounces-21147-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBPTDu7hD2pERAYAu9opvQ
	(envelope-from <linux-rdma+bounces-21147-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 06:56:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 908DF5AED19
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 06:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A0953055423
	for <lists+linux-rdma@lfdr.de>; Fri, 22 May 2026 04:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2565D359A90;
	Fri, 22 May 2026 04:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSiqZitO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8D8029B77C;
	Fri, 22 May 2026 04:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779425363; cv=none; b=hp2Rs8Vhunv5E4BoRDmi+IN7Gielpgo6vq63nKX5KjzwpTj7kEqfyU+V0NiRvoDfi/Hb5M2sEAKpHlxcXD1x4++eimRPYDppO5uD88dmSANyzEIJLTDCZo0LsFUBTMiODycxNbTnjYp30mGixPjQV4h6duS2ta2rD1YC/jauJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779425363; c=relaxed/simple;
	bh=upzwlhH2S6BYm2RtVA6AYXk71GKmgyCd8tcanZx/Pjw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KF9fJ+HYlA5qdA5IQvTThHpCgRRjc2o7MVxHzLxSyq5O0nulYBWmc/5Fznez1GKpc9EHcGuQjlq1A1JG9gdlO0nndt6gA7jgQkRbCJfyCc4Lmgvp0f/WQKuoTnkMou2O6RhiNd7umEt7SKE5w+ybGj3KoG/mMV2Vx7YMAMOnHFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSiqZitO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97921F00A3D;
	Fri, 22 May 2026 04:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779425360;
	bh=ekNjVBI3tkZHPdsUPq0t0Huu7boUNAOIWIJNJDXGevI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=LSiqZitOmkNs6UcUnhE064EQY5fhVG3mtdt5yeq7FxnAYdYRe0eQmwG4yM7BByXha
	 mn6RIXqMClMSMzRaQourcJQdg7CIUvlwl+0D5vVfyPJFDj4RsMYhU9CoTFm3Kpk+l3
	 rlcWQW4mj9rbb7AMsAmMaJKWcf6X4AlYeiLt/YPoWwjkvZnsrDabKT0AgCS/LnO6Ri
	 qCHQc1E6/W16tYQWBj/OifEXR+npJ45LtZzfjvVqKoKIEgO32otPkld58OjWPPgfvS
	 jAjoBtsDDg4XyxkTlmOzTVZUTP7pGYaqPWBJ5mqe7OkEi4SvS1gqe5iLmepzqCGGVQ
	 7I30KhK5FoxgA==
Message-ID: <ba093b6b93fffe07564e89dc5744efe45dfb4c21.camel@kernel.org>
Subject: Re: [PATCH net] rds: annotate data-race around rs_seen_congestion
From: Allison Henderson <achender@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>, netdev@vger.kernel.org
Cc: syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	 <horms@kernel.org>, Andy Grover <andy.grover@oracle.com>, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Date: Thu, 21 May 2026 21:49:19 -0700
In-Reply-To: <20260522011621.304470-1-jiayuan.chen@linux.dev>
References: <20260522011621.304470-1-jiayuan.chen@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-21147-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma,fbf3648ae7f5bdb05c59];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,linux.dev:email]
X-Rspamd-Queue-Id: 908DF5AED19
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-05-22 at 09:16 +0800, Jiayuan Chen wrote:
> rs_seen_congestion is read in rds_poll() and written in rds_sendmsg()
> and rds_poll() without any lock.  Use READ_ONCE()/WRITE_ONCE() to
> annotate these lockless accesses and silence KCSAN.
>=20
> Fixes: b98ba52f96e7 ("RDS: only put sockets that have seen congestion on =
the poll_waitq")
> Reported-by: syzbot+fbf3648ae7f5bdb05c59@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/netdev/6a0f8d94.050a0220.6b33c.0000.GAE@g=
oogle.com/
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Hi Jiayuan,

I was about to send the same patch, so no complaints here.  Thanks for catc=
hing this.
Reviewed-by: Allison Henderson <achender@kernel.org>=C2=A0
Tested-by: Allison Henderson <achender@kernel.org>

Allison
> ---
>  net/rds/af_rds.c | 4 ++--
>  net/rds/send.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 76f625986a7f..93b2da63ed42 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -219,7 +219,7 @@ static __poll_t rds_poll(struct file *file, struct so=
cket *sock,
> =20
>  	poll_wait(file, sk_sleep(sk), wait);
> =20
> -	if (rs->rs_seen_congestion)
> +	if (READ_ONCE(rs->rs_seen_congestion))
>  		poll_wait(file, &rds_poll_waitq, wait);
> =20
>  	read_lock_irqsave(&rs->rs_recv_lock, flags);
> @@ -247,7 +247,7 @@ static __poll_t rds_poll(struct file *file, struct so=
cket *sock,
> =20
>  	/* clear state any time we wake a seen-congested socket */
>  	if (mask)
> -		rs->rs_seen_congestion =3D 0;
> +		WRITE_ONCE(rs->rs_seen_congestion, 0);
> =20
>  	return mask;
>  }
> diff --git a/net/rds/send.c b/net/rds/send.c
> index d8b14ff9d366..e5d58c29aabe 100644
> --- a/net/rds/send.c
> +++ b/net/rds/send.c
> @@ -1388,7 +1388,7 @@ int rds_sendmsg(struct socket *sock, struct msghdr =
*msg, size_t payload_len)
> =20
>  	ret =3D rds_cong_wait(conn->c_fcong, dport, nonblock, rs);
>  	if (ret) {
> -		rs->rs_seen_congestion =3D 1;
> +		WRITE_ONCE(rs->rs_seen_congestion, 1);
>  		goto out;
>  	}
>  	while (!rds_send_queue_rm(rs, conn, cpath, rm, rs->rs_bound_port,


