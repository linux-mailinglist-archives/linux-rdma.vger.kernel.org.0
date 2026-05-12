Return-Path: <linux-rdma+bounces-20529-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKi1BC2XA2pG7wEAu9opvQ
	(envelope-from <linux-rdma+bounces-20529-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 23:10:05 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F723529F8A
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 23:10:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5BC73043D4E
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:06:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE43CB8E2;
	Tue, 12 May 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuaTpMoa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B98C3CB2DB;
	Tue, 12 May 2026 21:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778619990; cv=none; b=tZpdf3753YrUBLtxgYuytcBZnyVZS4n8dwI0mjLsgVOWKIjQkOd1KOUIUnfKZTxkBriifWoln1zW0HHhSAqqCPFhOHlXVnw3uT4oa4Ggrg8VXS+gLnylF5XlxUilVfraZg1PCJo06T30IFAXm2JeU61bmXiiScMtKS5oTVHSwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778619990; c=relaxed/simple;
	bh=ZIvbTOv7mGv5YKH2y2r48OhIXZowIMwcRvdd3yekhRo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=C7WlHaeFQF6EY1lfzACLYyPtYcSPFxz/82HgKLjfsC2WTguRCKcuDiuhbTbpLhNu4vIkGJJtCMiyjPnvjo43SR67ucHWxkKPvPFZMoc+jfxHVa1RVy+Uzq29Pwbt/8EuVdul7WA4Eq1rkEtGih4ef56LKOF3NGZyiSz8ALySILk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuaTpMoa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E12EC2BCB0;
	Tue, 12 May 2026 21:06:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778619989;
	bh=ZIvbTOv7mGv5YKH2y2r48OhIXZowIMwcRvdd3yekhRo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=BuaTpMoaimZlLD0h5HyetUagx3Z6y05iMPWCTL7D8sRv+nFXigTYVwmd4qgnaYTlr
	 eozizX/kHqaU2DMt8WkbegIpJ3lji7USGrDfQcv+UK4wosnr29QedlEom3SXLqs1kn
	 LQMLIAMZYoifH0AZ7hVGngZr/vGNiMM/I/m/XjDOLcmHDzbV1l3+ZDrJDCMTr7SqXt
	 69lcjWRLHk21E88SMcIR8gZ/qfS8y1z4ssi6UJnPgk2D3ZGtP6pB+7MSdb1bKjyiBH
	 6FdqC3AxKAOWHZs9KIWrS78rsNEbXjTBqd+xbfMVd3+pK6U2J0W6NRKer4cZk6okwt
	 JTTUu8DwzYuAA==
Message-ID: <fc16e29466dfeede64ec6c94bc7526aef13db2a1.camel@kernel.org>
Subject: Re: [PATCH net] rds_tcp: close NULL deref window in
 rds_tcp_set_callbacks
From: Allison Henderson <achender@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: horms@kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org, Maoyi Xie
	 <maoyi.xie@ntu.edu.sg>
Date: Tue, 12 May 2026 14:06:27 -0700
In-Reply-To: <20260512142807.1855619-1-maoyi.xie@ntu.edu.sg>
References: <20260512142807.1855619-1-maoyi.xie@ntu.edu.sg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 7F723529F8A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-20529-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Tue, 2026-05-12 at 22:28 +0800, Maoyi Xie wrote:
> rds_tcp_set_callbacks() links a new rds_tcp_connection onto
> rds_tcp_tc_list under rds_tcp_tc_list_lock. It releases the
> lock, then assigns tc->t_sock =3D sock outside the lock.
>=20
> rds_tcp_tc_info() and rds6_tcp_tc_info() walk rds_tcp_tc_list
> under the same lock. Both dereference tc->t_sock->sk without
> a NULL check.
>=20
> A reader can acquire rds_tcp_tc_list_lock between the writer's
> spin_unlock and the t_sock store. It then sees a list entry
> whose t_sock is NULL. The dereference of tc->t_sock->sk is a
> NULL access.
>=20
> Move tc->t_sock =3D sock inside rds_tcp_tc_list_lock, before
> list_add_tail. A reader holding the lock then observes the
> linkage and the t_sock store together.
>=20
> The restore path is safe. rds_tcp_restore_callbacks() does
> list_del_init inside the lock. The matching tc->t_sock =3D NULL
> after unlink is harmless to readers holding the lock.
>=20
> Fixes: 70041088e3b9 ("RDS: Add TCP transport to RDS")
> Suggested-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

Hi Maoyi,
This fix looks fine to me.  Thanks for the catch.

Reviewed-by: Allison Henderson <achender@kernel.org>

> ---
>  net/rds/tcp.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 654e23d13..5830b31a1 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -198,8 +198,13 @@ void rds_tcp_set_callbacks(struct socket *sock, stru=
ct rds_conn_path *cp)
>  	rdsdebug("setting sock %p callbacks to tc %p\n", sock, tc);
>  	write_lock_bh(&sock->sk->sk_callback_lock);
> =20
> -	/* done under the callback_lock to serialize with write_space */
> +	/* done under the callback_lock to serialize with write_space.
> +	 * Set t_sock inside rds_tcp_tc_list_lock so readers walking
> +	 * rds_tcp_tc_list under the same lock cannot observe an
> +	 * entry whose t_sock is NULL.
> +	 */
>  	spin_lock(&rds_tcp_tc_list_lock);
> +	tc->t_sock =3D sock;
>  	list_add_tail(&tc->t_list_item, &rds_tcp_tc_list);
>  #if IS_ENABLED(CONFIG_IPV6)
>  	rds6_tcp_tc_count++;
> @@ -211,8 +216,6 @@ void rds_tcp_set_callbacks(struct socket *sock, struc=
t rds_conn_path *cp)
>  	/* accepted sockets need our listen data ready undone */
>  	if (sock->sk->sk_data_ready =3D=3D rds_tcp_listen_data_ready)
>  		sock->sk->sk_data_ready =3D sock->sk->sk_user_data;
> -
> -	tc->t_sock =3D sock;
>  	if (!tc->t_rtn)
>  		tc->t_rtn =3D net_generic(sock_net(sock->sk), rds_tcp_netid);
>  	tc->t_cpath =3D cp;
>=20
> base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153


