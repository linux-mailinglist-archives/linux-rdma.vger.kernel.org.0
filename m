Return-Path: <linux-rdma+bounces-20523-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAuhMtyCA2pX6gEAu9opvQ
	(envelope-from <linux-rdma+bounces-20523-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:43:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E678528CA2
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 21:43:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBA0C306636C
	for <lists+linux-rdma@lfdr.de>; Tue, 12 May 2026 19:43:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C817536F916;
	Tue, 12 May 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZTsJKAD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AE4A36F904;
	Tue, 12 May 2026 19:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778615000; cv=none; b=lMifrL6pWxt0tuayyfDKMVvCe3JH6yild2FY/ZpterL2k2LKBe6TLHV9WFa00kW6UCRL5KJfS1yruUm2KDUI2bA34H1T6xiWXll2NNLzGkU9ftiSuyqSlbF8ymcNhG8N4MHVs4WSKkELHAhz1haybyJRx6J/M7tBkmgqttglgyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778615000; c=relaxed/simple;
	bh=r6iMY3/B+VfbZnvOgvfR3Ut7MPv/kjymM59J7Vaq9P0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jqk3mft5vFErkO6OQ/pdohKkxpHCD7CxBDxiJmLjwc9G/ANSoJHCtmJ74vxl4+H5iSDefReQp831QnDkGBf55+igptrnZosY3hAcTVPvSQRTO0LC+d1MnP716OelHUupGXDUnTlkKpgy9ZsNpNPguwoO0HBEk4NNYIDhsvUGoxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZTsJKAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B9F8C2BCB0;
	Tue, 12 May 2026 19:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778615000;
	bh=r6iMY3/B+VfbZnvOgvfR3Ut7MPv/kjymM59J7Vaq9P0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=nZTsJKAD97dU/hDwjjX+9akPdOjbyaYAuoy+rbKxlgX2VV875Be4yBXW97gJAH4Hs
	 Et+FwNXd+NL+OlTwz+rrhJR2hJHhAq8j0fSEeGiD2dnJId2c2BxutcG1jvv9LZrSgc
	 GDfjRxoL8/j2cG4kAbciwVF/Fpi3Kx7ymotZ9kLhfipdWM1W+ZCyB2KK6IwirGTDi2
	 iPQW+oHYQNCJ/VfcK12+nyexLXjH2fKGk+wpjOttY4l7zNbudX8kVz/0un4amKIPA5
	 GEzqC6KX39duwmd50bW3cA6EjQNTeEux0nnJvB2XayaXuBLe8ljpPbjZOMGUXEuyW6
	 C95i08PtDElhQ==
Message-ID: <9b6148b29f57728d97a9fea8a400e87a3f6a1526.camel@kernel.org>
Subject: Re: [PATCH net v3] rds: filter RDS_INFO_* getsockopt by caller's
 netns
From: Allison Henderson <achender@kernel.org>
To: Maoyi Xie <maoyixie.tju@gmail.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-rdma@vger.kernel.org,  rds-devel@oss.oracle.com,
 linux-kernel@vger.kernel.org, Praveen Kakkolangara
 <praveen.kakkolangara@aumovio.com>, Maoyi Xie <maoyi.xie@ntu.edu.sg>
Date: Tue, 12 May 2026 12:43:18 -0700
In-Reply-To: <20260511070211.1033178-1-maoyi.xie@ntu.edu.sg>
References: <20260511070211.1033178-1-maoyi.xie@ntu.edu.sg>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 3E678528CA2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20523-lists,linux-rdma=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,vger.kernel.org];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ntu.edu.sg:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 2026-05-11 at 15:02 +0800, Maoyi Xie wrote:
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
> Suggested-by: Simon Horman <horms@kernel.org>
> Reviewed-by: Allison Henderson <achender@kernel.org>
> Co-developed-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
> Signed-off-by: Praveen Kakkolangara <praveen.kakkolangara@aumovio.com>
> Signed-off-by: Maoyi Xie <maoyi.xie@ntu.edu.sg>
> ---
> v3: Address Simon Horman's review of v2. The size precheck and the
>     lens count are now both restricted to the caller's netns in
>     rds_sock_info, rds6_sock_info, rds_tcp_tc_info and
>     rds6_tcp_tc_info. Each handler now does a first pass under the
>     list lock to count entries visible in the caller's netns, then
>     short-circuits with that count if the user buffer is too small,
>     then a second pass to fill data. This closes both issues Simon
>     flagged: a zero-length probe no longer returns the global count,
>     and a caller that sizes its buffer to the value returned by lens
>     no longer hits ENOSPC on the second call.
>     Re-verified on KASAN VM with the v1 PoC: attacker in fresh
>     user_ns + netns sees zero RDS_INFO_SOCKETS entries; init_net
>     access sees its own entries; lens returns the ns-scoped count
>     on both probe and full reads.
> v2: rebased onto net/main tip (b266bacba) so patchwork can apply.
>     No code changes. Carries forward Reviewed-by from v1 review.
> v1: https://lore.kernel.org/r/20260506075031.2238596-1-maoyixie.tju@gmail=
.com
>=20
Hi Maoyi,

The two-pass approach looks good to me. The zero-length probe now returns
an appropriately ns-scoped count.  I've already gave the rvb on v2, but I t=
hink
v3 is a cleaner solution.

Thanks,
Allison


>  net/rds/af_rds.c     | 42 ++++++++++++++++++++++++++++++++++++------
>  net/rds/connection.c | 13 +++++++++++++
>  net/rds/tcp.c        | 35 +++++++++++++++++++++++++++++++----
>  3 files changed, 80 insertions(+), 10 deletions(-)
>=20
> diff --git a/net/rds/af_rds.c b/net/rds/af_rds.c
> index 76f625986..6e22b516b 100644
> --- a/net/rds/af_rds.c
> +++ b/net/rds/af_rds.c
> @@ -735,6 +735,7 @@ static void rds_sock_inc_info(struct socket *sock, un=
signed int len,
>  			      struct rds_info_iterator *iter,
>  			      struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds_sock *rs;
>  	struct rds_incoming *inc;
>  	unsigned int total =3D 0;
> @@ -744,6 +745,9 @@ static void rds_sock_inc_info(struct socket *sock, un=
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
> @@ -774,6 +778,7 @@ static void rds6_sock_inc_info(struct socket *sock, u=
nsigned int len,
>  			       struct rds_info_iterator *iter,
>  			       struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds_incoming *inc;
>  	unsigned int total =3D 0;
>  	struct rds_sock *rs;
> @@ -783,6 +788,9 @@ static void rds6_sock_inc_info(struct socket *sock, u=
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
> @@ -806,6 +814,7 @@ static void rds_sock_info(struct socket *sock, unsign=
ed int len,
>  			  struct rds_info_iterator *iter,
>  			  struct rds_info_lengths *lens)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct rds_info_socket sinfo;
>  	unsigned int cnt =3D 0;
>  	struct rds_sock *rs;
> @@ -814,12 +823,22 @@ static void rds_sock_info(struct socket *sock, unsi=
gned int len,
> =20
>  	spin_lock_bh(&rds_sock_lock);
> =20
> -	if (len < rds_sock_count) {
> -		cnt =3D rds_sock_count;
> -		goto out;
> +	/* First pass: count entries visible in the caller's netns. */
> +	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
> +		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
> +			continue;
> +		cnt++;
>  	}
> =20
> +	if (len < cnt)
> +		goto out;
> +
>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
>  		/* This option only supports IPv4 sockets. */
>  		if (!ipv6_addr_v4mapped(&rs->rs_bound_addr))
>  			continue;
> @@ -832,7 +851,6 @@ static void rds_sock_info(struct socket *sock, unsign=
ed int len,
>  		sinfo.inum =3D sock_i_ino(rds_rs_to_sk(rs));
> =20
>  		rds_info_copy(iter, &sinfo, sizeof(sinfo));
> -		cnt++;
>  	}
> =20
>  out:
> @@ -847,17 +865,29 @@ static void rds6_sock_info(struct socket *sock, uns=
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
> +	/* First pass: count entries visible in the caller's netns. */
> +	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
> +		cnt++;
> +	}
> +
> +	if (len < cnt)
>  		goto out;
> =20
>  	list_for_each_entry(rs, &rds_sock_list, rs_item) {
> +		/* Only show sockets in the caller's netns. */
> +		if (!net_eq(sock_net(rds_rs_to_sk(rs)), net))
> +			continue;
>  		sinfo6.sndbuf =3D rds_sk_sndbuf(rs);
>  		sinfo6.rcvbuf =3D rds_sk_rcvbuf(rs);
>  		sinfo6.bound_addr =3D rs->rs_bound_addr;
> @@ -870,7 +900,7 @@ static void rds6_sock_info(struct socket *sock, unsig=
ned int len,
>  	}
> =20
>   out:
> -	lens->nr =3D rds_sock_count;
> +	lens->nr =3D cnt;
>  	lens->each =3D sizeof(struct rds6_info_socket);
> =20
>  	spin_unlock_bh(&rds_sock_lock);
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index c10b7ed06..7c8ab8e97 100644
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
>  			/* Zero the per-item buffer before handing it to the
>  			 * visitor so any field the visitor does not write -
> @@ -733,6 +741,7 @@ static void rds_walk_conn_path_info(struct socket *so=
ck, unsigned int len,
>  				    u64 *buffer,
>  				    size_t item_len)
>  {
> +	struct net *net =3D sock_net(sock->sk);
>  	struct hlist_head *head;
>  	struct rds_connection *conn;
>  	size_t i;
> @@ -747,6 +756,10 @@ static void rds_walk_conn_path_info(struct socket *s=
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
> index 654e23d13..105e83507 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -235,13 +235,24 @@ static void rds_tcp_tc_info(struct socket *rds_sock=
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
> +	/* First pass: count entries visible in the caller's netns. */
> +	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
> +		if (tc->t_cpath->cp_conn->c_isv6)
> +			continue;
> +		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
> +			continue;
> +		cnt++;
> +	}
> +
> +	if (len / sizeof(tsinfo) < cnt)
>  		goto out;
> =20
>  	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
> @@ -249,6 +260,9 @@ static void rds_tcp_tc_info(struct socket *rds_sock, =
unsigned int len,
> =20
>  		if (tc->t_cpath->cp_conn->c_isv6)
>  			continue;
> +		/* Only show connections in the caller's netns. */
> +		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
> +			continue;
> =20
>  		tsinfo.local_addr =3D inet->inet_saddr;
>  		tsinfo.local_port =3D inet->inet_sport;
> @@ -266,7 +280,7 @@ static void rds_tcp_tc_info(struct socket *rds_sock, =
unsigned int len,
>  	}
> =20
>  out:
> -	lens->nr =3D rds_tcp_tc_count;
> +	lens->nr =3D cnt;
>  	lens->each =3D sizeof(tsinfo);
> =20
>  	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
> @@ -281,19 +295,32 @@ static void rds6_tcp_tc_info(struct socket *sock, u=
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
> +	/* First pass: count entries visible in the caller's netns. */
> +	list_for_each_entry(tc, &rds_tcp_tc_list, t_list_item) {
> +		if (!net_eq(rds_conn_net(tc->t_cpath->cp_conn), net))
> +			continue;
> +		cnt++;
> +	}
> +
> +	if (len / sizeof(tsinfo6) < cnt)
>  		goto out;
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
> @@ -309,7 +336,7 @@ static void rds6_tcp_tc_info(struct socket *sock, uns=
igned int len,
>  	}
> =20
>  out:
> -	lens->nr =3D rds6_tcp_tc_count;
> +	lens->nr =3D cnt;
>  	lens->each =3D sizeof(tsinfo6);
> =20
>  	spin_unlock_irqrestore(&rds_tcp_tc_list_lock, flags);
>=20
> base-commit: b266bacba796ff5c4dcd2ae2fc08aacf7ab39153


