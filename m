Return-Path: <linux-rdma+bounces-20114-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CASOKYAg/GlcLwAAu9opvQ
	(envelope-from <linux-rdma+bounces-20114-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:17:52 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8BC4E3101
	for <lists+linux-rdma@lfdr.de>; Thu, 07 May 2026 07:17:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B3858301456A
	for <lists+linux-rdma@lfdr.de>; Thu,  7 May 2026 05:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 472F631E847;
	Thu,  7 May 2026 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+hLmK3i"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A1926159E;
	Thu,  7 May 2026 05:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778131065; cv=none; b=diu0VVkYQZDtDbm9Iaxq2KxWWIPKuG8ziDlTkqp9jvolClZOay8StDuHvYITLrncooyur5U7xHWY2ftke2z14tEUjv+jxan4eqR0sC/E5soDfTu32cSubTZyoNUJOLu7Gs4Cbin3eXknvBTg+idpRppBXSVcuA3zBlpckqJ6D1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778131065; c=relaxed/simple;
	bh=9HijFHTjiPqacwwVBM8Z0Nsw1JZDw7iEzN3f7TEOl00=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PkbmqPmZVYdeGUQ+JeJTFqC0gOS9RaY7ltN3QZsFZ9QXloKa9oO0X90XtZJAeOKdFbU4RggC1mF79S5poUTIlVi4383vH56fe/GMYJsIe6FXFPdtaUiwnxvWpl9qSfx9XfB3rx3myrRqP1ToVSzgPyseq+l6vVFPiFdwoaOe7tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+hLmK3i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27026C2BCB8;
	Thu,  7 May 2026 05:17:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778131064;
	bh=9HijFHTjiPqacwwVBM8Z0Nsw1JZDw7iEzN3f7TEOl00=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=S+hLmK3iXFdQJcP4gdW3fc//TlDr12Jt9nFxWRV3ncmLK/QNymEoPDFJ6igCYs9SM
	 eFKOyBkvf21EB0Ng4YscDtfclbNdZWDZQGhbBG1cx+o7mNZqIlOV3yIwBSwh9kdV7r
	 VWSEwj/lH4U8y3/BNfmM0wlmbA+W0q8CrSP9jkY4v5zKxpbJT13+UManmwmy4wA19N
	 UlTVtzwrhAPul1GbbJC+PYckIBYPgie7gLMci3bstOekP/yheaEiS6oIY85pMPoNEM
	 7oziiwbT0HfH8pGTMHigcgLrIxPFTB3l5hiuLkNfDDMjHu8S/PPRbU8FrczwgaTrTv
	 520ljBkSp+wbA==
Message-ID: <4df3eb5dc608cf8b4649f1358cb74b9fbbfbbca6.camel@kernel.org>
Subject: Re: [PATCH net] rds: filter RDS_INFO_* getsockopt by caller's netns
From: Allison Henderson <achender@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org, Maoyi Xie
 <maoyi.xie@ntu.edu.sg>, Praveen Kakkolangara
 <praveen.kakkolangara@aumovio.com>
Date: Wed, 06 May 2026 22:17:43 -0700
In-Reply-To: <20260506075031.2238596-1-maoyixie.tju@gmail.com>
References: <20260506075031.2238596-1-maoyixie.tju@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0A8BC4E3101
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20114-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,aumovio.com:email]
X-Rspamd-Action: no action

On Wed, 2026-05-06 at 15:50 +0800, Maoyi Xie wrote:
> From: Maoyi Xie <maoyi.xie@ntu.edu.sg>
>=20
> The RDS_INFO_* family of getsockopt(2) options reads several
> file-scope global lists that are not per-netns:
>=20
>   rds_sock_info / rds6_sock_info,
>   rds_sock_inc_info / rds6_sock_inc_info        -> rds_sock_list
>   rds_tcp_tc_info / rds6_tcp_tc_info            -> rds_tcp_tc_list
>   rds_conn_info / rds6_conn_info,
>   rds_conn_message_info_cmn (for the *_SEND_MESSAGES and
>   *_RETRANS_MESSAGES variants),
>   rds_for_each_conn_info (for RDS_INFO_IB_CONNECTIONS)
>                                                 -> rds_conn_hash[]
>=20
> The handlers do not filter by the caller's network namespace.
> rds_info_getsockopt() has no netns or capable() check, and
> rds_create() has no capable() check, so AF_RDS is reachable from
> an unprivileged user namespace. As a result, an unprivileged
> caller in a fresh user_ns plus netns can read the bound address
> and sock inode of every RDS socket on the host, the peer address
> of incoming messages on every RDS socket on the host, the peer
> address and TCP sequence numbers of every rds-tcp connection on
> the host, and the peer address and RDS sequence numbers of every
> RDS connection on the host.
>=20
> The rds-tcp transport is reachable from a non-initial netns (see
> rds_set_transport()), so a one-shot init_net gate at
> rds_info_getsockopt() would deny legitimate per-netns visibility
> to rds-tcp callers. Instead, filter at each handler by comparing
> the netns of the caller's socket to the netns of the list entry,
> or to rds_conn_net(conn) for connection paths. Only copy entries
> whose netns matches the caller. Counters (RDS_INFO_COUNTERS) are
> aggregate statistics and remain global.
>=20
> Reproducer (KASAN VM, rds and rds_tcp loaded): an AF_RDS socket
> binds 127.0.0.1:4242 in init_net as root. A child process enters
> a fresh user_ns plus netns and opens AF_RDS there, then calls
> getsockopt(SOL_RDS, RDS_INFO_SOCKETS). Before this change, the
> child sees the init_net socket. After this change, the child
> sees zero entries.
>=20
> Suggested-by: Allison Henderson <achender@kernel.org>
> Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
> Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>

Thanks Xie.  This looks good to me.  I notice that patchwork failed to appl=
y this patch though.  So you may need to
rebase a v2 onto net/main.  Other than that I think it looks good.  Thank y=
ou!

Reviewed-by: Allison Henderson <achender@kernel.org>

> ---
>  net/rds/af_rds.c     | 24 ++++++++++++++++++++++--
>  net/rds/connection.c | 13 +++++++++++++
>  net/rds/tcp.c        | 25 +++++++++++++++++++++----
>  3 files changed, 56 insertions(+), 6 deletions(-)
>=20
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index b396c673d..469891131 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -729,6 +729,7 @@ static void rds_sock_inc_info(struct socket *sock, un=
signed int len,
>  			      struct rds_info_iterator *iter,
>  			      struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds_sock *rs;
>  	struct rds_incoming *inc;
>  	unsigned int total =3D 0;
> @@ -738,6 +739,9 @@ static void rds_sock_inc_info(struct socket *sock, un=
signed int len,
>  	spin_lock_bh(&rds_sock_lock);
> =20
>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
>  		/* This option only supports IPv4 sockets. */
>  		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
>  			continue;
> @@ -768,6 +772,7 @@ static void rds6_sock_inc_info(struct socket *sock, u=
nsigned int len,
>  			       struct rds_info_iterator *iter,
>  			       struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds_incoming *inc;
>  	unsigned int total =3D 0;
>  	struct rds_sock *rs;
> @@ -777,6 +782,9 @@ static void rds6_sock_inc_info(struct socket *sock, u=
nsigned int len,
>  	spin_lock_bh(&rds_sock_lock);
> =20
>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
>  		read_lock(&rs->rs_recv_lock);
> =20
>  		list_for_each_entry(inc, &rs->rs_recv_queue, i_item) {
> @@ -800,6 +808,7 @@ static void rds_sock_info(struct socket *sock, unsign=
ed int len,
>  			  struct rds_info_iterator *iter,
>  			  struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds_info_socket sinfo;
>  	unsigned int cnt =3D 0;
>  	struct rds_sock *rs;
> @@ -814,6 +823,9 @@ static void rds_sock_info(struct socket *sock, unsign=
ed int len,
>  	}
> =20
>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
>  		/* This option only supports IPv4 sockets. */
>  		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
>  			continue;
> @@ -841,17 +853,24 @@ static void rds6_sock_info(struct socket *sock, uns=
igned int len,
>  			   struct rds_info_iterator *iter,
>  			   struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds6_info_socket sinfo6;
> +	unsigned int cnt =3D 0;
>  	struct rds_sock *rs;
> =20
>  	len /=3D sizeof(struct rds6_info_socket);
> =20
>  	spin_lock_bh(&rds_sock_lock);
> =20
> -	if (len < rds_sock_count)
> +	if (len < rds_sock_count) {
> +		cnt =3D rds_sock_count;
>  		goto out;
> +	}
> =20
>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
>  		sinfo6.sndbuf =3D rds_sk_sndbuf(rs);
>  		sinfo6.rcvbuf =3D rds_sk_rcvbuf(rs);
>  		sinfo6.bound_addr =3D rs->rs_bound_addr;
> @@ -861,10 +880,11 @@ static void rds6_sock_info(struct socket *sock, uns=
igned int len,
>  		sinfo6.inum =3D sock_i_ino(rds_rs_to_sk(rs));
> =20
>  		rds_info_copy(iter, &sinfo6, sizeof(sinfo6));
> +		cnt++;
>  	}
> =20
>   out:
> -	lens->nr =3D rds_sock_count;
> +	lens->nr =3D cnt;
>  	lens->each =3D sizeof(struct rds6_info_socket);
> =20
>  	spin_unlock_bh(&rds_sock_lock);
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index 412441aaa..a73554816 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -568,6 +568,7 @@ static void rds_conn_message_info_cmn(struct socket *=
sock, unsigned int len,
>  				      struct rds_info_lengths *lens,
>  				      int want_send, bool isv6)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct hlist_head *head;
>  	struct list_head *list;
>  	struct rds_connection *conn;
> @@ -590,6 +591,9 @@ static void rds_conn_message_info_cmn(struct socket *=
sock, unsigned int len,
>  			struct rds_conn_path *cp;
>  			int npaths;
> =20
> +			/* Only show connections in the caller's netns. */
> +			if (!net_eq(rds_conn_net(conn), net))
> +				continue;
>  			if (!isv6 && conn->c_isv6)
>  				continue;
> =20
> @@ -688,6 +692,7 @@ void rds_for_each_conn_info(struct socket *sock, unsi=
gned int len,
>  			  u64 *buffer,
>  			  size_t item_len)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct hlist_head *head;
>  	struct rds_connection *conn;
>  	size_t i;
> @@ -700,6 +705,9 @@ void rds_for_each_conn_info(struct socket *sock, unsi=
gned int len,
>  	for (i =3D 0, head =3D rds_conn_hash; i < ARRAY_SIZE(rds_conn_hash);
>  	     i++, head++) {
>  		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
> +			/* Only show connections in the caller's netns. */
> +			if (!net_eq(rds_conn_net(conn), net))
> +				continue;
> =20
>  			/* XXX no c_lock usage.. */
>  			if (!visitor(conn, buffer))
> @@ -726,6 +734,7 @@ static void rds_walk_conn_path_info(struct socket *so=
ck, unsigned int len,
>  				    u64 *buffer,
>  				    size_t item_len)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct hlist_head *head;
>  	struct rds_connection *conn;
>  	size_t i;
> @@ -740,6 +749,10 @@ static void rds_walk_conn_path_info(struct socket *s=
ock, unsigned int len,
>  		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
>  			struct rds_conn_path *cp;
> =20
> +			/* Only show connections in the caller's netns. */
> +			if (!net_eq(rds_conn_net(conn), net))
> +				continue;
> +
>  			/* XXX We only copy the information from the first
>  			 * path for now.  The problem is that if there are
>  			 * more than one underlying paths, we cannot report
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 654e23d13..ef9e958ca 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -235,20 +235,27 @@ static void rds_tcp_tc_info(struct socket *rds_sock=
, unsigned int len,
>  			    struct rds_info_iterator *iter,
>  			    struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(rds_sock->sk);
>  	struct rds_info_tcp_socket tsinfo;
>  	struct rds_tcp_connection *tc;
> +	unsigned int cnt =3D 0;
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
> =20
> -	if (len / sizeof(tsinfo) < rds_tcp_tc_count)
> +	if (len / sizeof(tsinfo) < rds_tcp_tc_count) {
> +		cnt =3D rds_tcp_tc_count;
>  		goto out;
> +	}
> =20
>  	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
>  		struct inet_sock *inet =3D inet_sk(tc->t_sock->sk);
> =20
>  		if (tc->t_cpath->cp_conn->c_isv6)
>  			continue;
> +		/* Only show connections in the caller's netns. */
> +		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
> +			continue;
> =20
>  		tsinfo.local_addr =3D inet->inet_saddr;
>  		tsinfo.local_port =3D inet->inet_sport;
> @@ -263,10 +270,11 @@ static void rds_tcp_tc_info(struct socket *rds_sock=
, unsigned int len,
>  		tsinfo.tos =3D tc->t_cpath->cp_conn->c_tos;
> =20
>  		rds_info_copy(iter, &tsinfo, sizeof(tsinfo));
> +		cnt++;
>  	}
> =20
>  out:
> -	lens->nr =3D rds_tcp_tc_count;
> +	lens->nr =3D cnt;
>  	lens->each =3D sizeof(tsinfo);
> =20
>  	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
> @@ -281,19 +289,27 @@ static void rds6_tcp_tc_info(struct socket *sock, u=
nsigned int len,
>  			     struct rds_info_iterator *iter,
>  			     struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds6_info_tcp_socket tsinfo6;
>  	struct rds_tcp_connection *tc;
> +	unsigned int cnt =3D 0;
>  	unsigned long flags;
> =20
>  	spin_lock_irqsave(&rds_tcp_tc_list_lock, flags);
> =20
> -	if (len / sizeof(tsinfo6) < rds6_tcp_tc_count)
> +	if (len / sizeof(tsinfo6) < rds6_tcp_tc_count) {
> +		cnt =3D rds6_tcp_tc_count;
>  		goto out;
> +	}
> =20
>  	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
>  		struct sock *sk =3D tc->t_sock->sk;
>  		struct inet_sock *inet =3D inet_sk(sk);
> =20
> +		/* Only show connections in the caller's netns. */
> +		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
> +			continue;
> +
>  		tsinfo6.local_addr =3D sk->sk_v6_rcv_saddr;
>  		tsinfo6.local_port =3D inet->inet_sport;
>  		tsinfo6.peer_addr =3D sk->sk_v6_daddr;
> @@ -306,10 +322,11 @@ static void rds6_tcp_tc_info(struct socket *sock, u=
nsigned int len,
>  		tsinfo6.last_seen_una =3D tc->t_last_seen_una;
> =20
>  		rds_info_copy(iter, &tsinfo6, sizeof(tsinfo6));
> +		cnt++;
>  	}
> =20
>  out:
> -	lens->nr =3D rds6_tcp_tc_count;
> +	lens->nr =3D cnt;
>  	lens->each =3D sizeof(tsinfo6);
> =20
>  	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
>=20
> base-commit: 028ef9c96e96197026887c0f092424679298aae8


