Return-Path: <linux-rdma+bounces-19419-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UNSfJziT4mkt7gAAu9opvQ
	(envelope-from <linux-rdma+bounces-19419-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 22:08:24 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE4241E72F
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 22:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2183B3033A80
	for <lists+linux-rdma@lfdr.de>; Fri, 17 Apr 2026 20:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A0F311C2D;
	Fri, 17 Apr 2026 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMbvrqAH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B672E2DDD;
	Fri, 17 Apr 2026 20:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776456479; cv=none; b=F/ozciWucZQ7RG00SuzZAveo9xIPxd8VSap+r1CHil7JjG34c2gTqM8TqxNf3R493yR8RRwsd+bM4H5G4IxXehIWp0DW/EGOwxSCquPjhuJUXda2n+ySfC6+2lfgUFpmLvt0z94H9V93oc/gqQ7hLFGvR6zzwQcy+dSlJauzdEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776456479; c=relaxed/simple;
	bh=bisWL2qqSYUYacd8xHtjBdVVCXmH5lYC3aeC9TX92yA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ryo63dHMg3sjTb2KmGbDmUMS0tUyqwUwDFgqSt6p2caDu/7uodz+JjkLyVgvah71YX/rDrkYTUVmt9BQqXZQTuylhv+cEYRI9lKVUvAsKaM4j32KNnx0kYPuUIH5m7SuUqwJ0B+YoufeuNt2YWG8Dgzd1A2LAmxb68yTylhyiVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMbvrqAH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BF29C19425;
	Fri, 17 Apr 2026 20:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776456478;
	bh=bisWL2qqSYUYacd8xHtjBdVVCXmH5lYC3aeC9TX92yA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cMbvrqAHld7I6ZAeNpIOHVCEANrvuHkt/dmyeiEnf42S606HWjCqUOmLbgHUdtpws
	 T4Y3HWjoc71p4+dQ/1eJGajT2vX3TiV/QkCT942uEr73n1kbdIY8N6fje9SLr/mk7n
	 xxx36K1EFdXSYL6fc1UYIrq5sBGJQ7XuaniJ5kX0ockP67BExZuZCItxN4j6Zc0EVB
	 Qrs3vT4oh/TZ1kbDRQ87lJmqKTXqnQ/E3GjTvPix26j6K0mZBCxcSPdiwYYIsAi139
	 YxZAmjSpQobalxncNukq2iKpQoeOuOkRD+EobAca6D7Rm47JXgutUGAsmvtLG6l9pT
	 6zbQaq2KBiSTg==
Message-ID: <a30638c3498f5b12a0824211d942b1e97fd1a084.camel@kernel.org>
Subject: Re: [PATCH] rds: zero per-item info buffer before handing it to
 visitors
From: Allison Henderson <achender@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>, "David S . Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kernel@vger.kernel.org
Date: Fri, 17 Apr 2026 13:07:56 -0700
In-Reply-To: <20260417141916.494761-1-michael.bommarito@gmail.com>
References: <20260417141916.494761-1-michael.bommarito@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19419-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4AE4241E72F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 10:19 -0400, Michael Bommarito wrote:
> Yet another from my "clanker."  This only applies to people who
> don't use CONFIG_INIT_STACK_ALL_ZERO, but I presume that's
> still enough people that it's worth backporting since it can
> be chained through leaked addresses to defeat KASLR.
>=20
> rds_for_each_conn_info() and rds_walk_conn_path_info() both hand a
> caller-allocated on-stack u64 buffer to a per-connection visitor and
> then copy the full item_len bytes back to user space via
> rds_info_copy() regardless of how much of the buffer the visitor
> actually wrote.
>=20
> rds_ib_conn_info_visitor() and rds6_ib_conn_info_visitor() only
> write a subset of their output struct when the underlying
> rds_connection is not in state RDS_CONN_UP (src/dst addr, tos, sl
> and the two GIDs via explicit memsets).  Several u32 fields
> (max_send_wr, max_recv_wr, max_send_sge, rdma_mr_max, rdma_mr_size,
> cache_allocs) and the 2-byte alignment hole between sl and
> cache_allocs remain as whatever stack contents preceded the visitor
> call and are then memcpy_to_user()'d out to user space.
>=20
> struct rds_info_rdma_connection and struct rds6_info_rdma_connection
> are the only rds_info_* structs in include/uapi/linux/rds.h that are
> not marked __attribute__((packed)), so they have a real alignment
> hole.  The other info visitors (rds_conn_info_visitor,
> rds6_conn_info_visitor, rds_tcp_tc_info, ...) write all fields of
> their packed output struct today and are not known to be vulnerable,
> but a future visitor that adds a conditional write-path would have
> the same bug.
>=20
> Reproduction on a kernel built without CONFIG_INIT_STACK_ALL_ZERO=3Dy:
> a local unprivileged user opens AF_RDS, sets SO_RDS_TRANSPORT=3DIB,
> binds to a local address on an RDMA-capable netdev (rxe soft-RoCE on
> any netdev is sufficient), sendto()'s any peer on the same subnet
> (fails cleanly but installs an rds_connection in the global hash in
> RDS_CONN_CONNECTING), then calls getsockopt(SOL_RDS,
> RDS_INFO_IB_CONNECTIONS).  The returned 68-byte item contains 26
> bytes of stack garbage including kernel text/data pointers:
>=20
>     0..7   0a 63 00 01 0a 63 00 02     src=3D10.99.0.1 dst=3D10.99.0.2
>     8..39  00 ...                      gids (memset-zeroed)
>     40..47 e0 92 a3 81 ff ff ff ff     kernel pointer (max_send_wr)
>     48..55 7f 37 b5 81 ff ff ff ff     kernel pointer (rdma_mr_max)
>     56..59 01 00 08 00                 rdma_mr_size (garbage)
>     60..61 00 00                       tos, sl
>     62..63 00 00                       alignment padding
>     64..67 18 00 00 00                 cache_allocs (garbage)
>=20
> Fix by zeroing the per-item buffer in both rds_for_each_conn_info()
> and rds_walk_conn_path_info() before invoking the visitor.  This
> covers the IPv4/IPv6 IB visitors and hardens all current and future
> visitors against the same class of bug.
>=20
> No functional change for visitors that fully populate their output.
>=20
> Fixes: ec16227e1414 ("RDS/IB: Infiniband transport")
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> Assisted-by: Claude:claude-opus-4-7

Hi Micheal,

The change looks fine to me.  Since this is a bug fix, you'll want to cc st=
able
tree stable@vger.kernel.org, and note the target tree and component in the
subject line like this: =C2=A0

[PATCH net v2] net/rds: zero per-item info buffer before handing it to visi=
tors

Other than that, the patch looks good to me.  Thanks Micheal.

Reviewed-by: Allison Henderson <achender@kernel.org>

Allison

> ---
>  net/rds/connection.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>=20
> diff --git a/net/rds/connection.c b/net/rds/connection.c
> index 412441aaa298..c10b7ed06c49 100644
> --- a/net/rds/connection.c
> +++ b/net/rds/connection.c
> @@ -701,6 +701,13 @@ void rds_for_each_conn_info(struct socket *sock, uns=
igned int len,
>  	     i++, head++) {
>  		hlist_for_each_entry_rcu(conn, head, c_hash_node) {
> =20
> +			/* Zero the per-item buffer before handing it to the
> +			 * visitor so any field the visitor does not write -
> +			 * including implicit alignment padding - cannot leak
> +			 * stack contents to user space via rds_info_copy().
> +			 */
> +			memset(buffer, 0, item_len);
> +
>  			/* XXX no c_lock usage.. */
>  			if (!visitor(conn, buffer))
>  				continue;
> @@ -750,6 +757,13 @@ static void rds_walk_conn_path_info(struct socket *s=
ock, unsigned int len,
>  			 */
>  			cp =3D conn->c_path;
> =20
> +			/* Zero the per-item buffer for the same reason as
> +			 * rds_for_each_conn_info(): any byte the visitor
> +			 * does not write (including alignment padding) must
> +			 * not leak stack contents via rds_info_copy().
> +			 */
> +			memset(buffer, 0, item_len);
> +
>  			/* XXX no cp_lock usage.. */
>  			if (!visitor(cp, buffer))
>  				continue;


