Return-Path: <linux-rdma+bounces-22990-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id B+aqNGd5UGrBzgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22990-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 06:47:35 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 747487372CF
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 06:47:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mN+EcDLS;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22990-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22990-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B72BC301745A
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jul 2026 04:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88A662BEC55;
	Fri, 10 Jul 2026 04:47:30 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC58C11CA9;
	Fri, 10 Jul 2026 04:47:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783658850; cv=none; b=U0QoLz9cQUeVwd/U1tDmx8V559288tRf74D5BsK75enZQiGVilfOvIosFJbf2tH84YZRPgDpyJAT+idvtY+vOdysYK90Z1tzITzZdMY9Z+/M+ELql4em8rDrvywCNBBxgaKGmoBN7GabK/Z41sKTdKJVNJUkVaL5hEPbZSexh8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783658850; c=relaxed/simple;
	bh=KtG3riWECgWxPZFYMBRzoEK28fpoNz5iuKjzcYAzfEU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=A9leuxOH66I6aST3khHDCUYF8u1mLibQatI1S08s/t3V3T0QOxg+rp47LExoK0l5tcG36+u5e9oB7jTpmWg7GD3n3OUymY8olgK7gz0cm/ZftGq0tpESneYcfRUHP1TbyBFC/Yw9+8ScIPTw/j+UKeEfsWK1w4663hK91zmgI1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mN+EcDLS; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37641F000E9;
	Fri, 10 Jul 2026 04:47:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783658848;
	bh=GaKEO6GGumHidrHTSXe+VCKHIYFpp8qWu+DuVp5SDP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=mN+EcDLS7AEkDia1MsxMqlgLitULy2kBhxHkimLgMScVUqDt2gP2zJXTqpBJSWr/Y
	 YvS4zPn9SCd8H2dDKeM/4TyxLukc66/nZwRODi/sTWzCYC0dljJKsj6bY9krc2Ccgy
	 PITOGZYhZKOS43Ux5H86vQZxBFCXdBIY+JdywczUMJ5uxXk2zSyhfUNaqUs5GWPFPh
	 oqdTXpRUz5CWH/mRS1fPlv2zcB/7XrBNU5VxDJC7dw9SbnbkrcIFvA2tc6hksuYnuL
	 JY05MzEm8igwHPeWI/OCrzTN8qx18mqLf0IwYJ8lWzIeAkViSknSg95/iBJek2Ly4d
	 d29Xbt39lDdCA==
Message-ID: <223445519263531dbeb5607889e11ebc4249ddf6.camel@kernel.org>
Subject: Re: [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when
 IPv6 is disabled
From: Allison Henderson <achender@kernel.org>
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Ka-Cheong Poon
 <ka-cheong.poon@oracle.com>, Santosh Shilimkar
 <santosh.shilimkar@oracle.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>,  "linux-rdma@vger.kernel.org"
 <linux-rdma@vger.kernel.org>, "rds-devel@oss.oracle.com"
 <rds-devel@oss.oracle.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Date: Thu, 09 Jul 2026 21:47:26 -0700
In-Reply-To: <20260709162723.367523-1-Ilia.Gavrilov@infotecs.ru>
References: <20260709162723.367523-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS(0.00)[m:Ilia.Gavrilov@infotecs.ru,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:ka-cheong.poon@oracle.com,m:santosh.shilimkar@oracle.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22990-lists,linux-rdma=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linuxtesting.org:url,infotecs.ru:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 747487372CF

On Thu, 2026-07-09 at 16:27 +0000, Ilia Gavrilov wrote:
> When booting with the 'ipv6.disable=3D1' parameter, inet6_addr_lst
> is never initialized because inet6_init() exits before addrconf_init()
> is called to initialize it. An attempt to bind an RDS socket to
> an ipv6 address results in a crash in __ipv6_chk_addr_and_flags()
>=20
> KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
> RIP: 0010:__ipv6_chk_addr_and_flags+0x1df/0x7e0
> Call Trace:
>  <TASK>
>  ipv6_chk_addr+0x3b/0x50
>  rds_tcp_laddr_check+0x155/0x3b0 [rds_tcp]
>  rds_trans_get_preferred+0x15d/0x2d0 [rds]
>  ? trace_hardirqs_on+0x2d/0x110
>  rds_bind+0x1433/0x1d60 [rds]
>  ? rds_remove_bound+0xd50/0xd50 [rds]
>  ? aa_af_perm+0x250/0x250
>  ? __might_fault+0xde/0x190
>  ? __sys_bind+0x1dc/0x210
>  __sys_bind+0x1dc/0x210
>  ? __ia32_sys_socketpair+0x100/0x100
>  ? restore_fpregs_from_fpstate+0x53/0x100
>  __x64_sys_bind+0x73/0xb0
>  ? syscall_enter_from_user_mode+0x1c/0x50
>  do_syscall_64+0x34/0x80
>  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
> RIP: 0033:0x7f47f8269ea9
>  </TASK>
>=20
> The following code reproduces the issue:
>=20
> struct sockaddr_in6 addr;
> s =3D socket(PF_RDS, SOCK_SEQPACKET, 0);
>=20
> memset(&addr, 0, sizeof(addr));
> inet_pton(AF_INET6, ADDRESS, &addr.sin6_addr);
> addr.sin6_family =3D AF_INET6;
> addr.sin6_port =3D htons(PORT);
>=20
> bind(s, &addr, sizeof(addr));
>=20
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with Syzkaller.
>=20
> Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to=
 struct in6_addr")
> Fixes: 1e2b44e78eea ("rds: Enable RDS IPv6 support")
> Signed-off-by: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>

This looks good to me, thanks for the quick response.
Reviewed-by: Allison Henderson <achender@kernel.org>

> ---
> v2: Add a similar check for inbound link-local IPv6 connects
>=20
>  net/rds/ib.c    | 4 ++++
>  net/rds/ib_cm.c | 4 ++++
>  net/rds/tcp.c   | 8 +++++---
>  3 files changed, 13 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/rds/ib.c b/net/rds/ib.c
> index 39f87272e071..8f9cf491984f 100644
> --- a/net/rds/ib.c
> +++ b/net/rds/ib.c
> @@ -429,6 +429,10 @@ static int rds_ib_laddr_check_cm(struct net *net, co=
nst struct in6_addr *addr,
>  		sa =3D (struct sockaddr *)&sin;
>  	} else {
>  #if IS_ENABLED(CONFIG_IPV6)
> +		if (!ipv6_mod_enabled()) {
> +			ret =3D -EADDRNOTAVAIL;
> +			goto out;
> +		}
>  		memset(&sin6, 0, sizeof(sin6));
>  		sin6.sin6_family =3D AF_INET6;
>  		sin6.sin6_addr =3D *addr;
> diff --git a/net/rds/ib_cm.c b/net/rds/ib_cm.c
> index 5667f0173b47..d46146887ba4 100644
> --- a/net/rds/ib_cm.c
> +++ b/net/rds/ib_cm.c
> @@ -810,6 +810,10 @@ int rds_ib_cm_handle_connect(struct rdma_cm_id *cm_i=
d,
>  	dp =3D event->param.conn.private_data;
>  	if (isv6) {
>  #if IS_ENABLED(CONFIG_IPV6)
> +		if (!ipv6_mod_enabled()) {
> +			err =3D -EOPNOTSUPP;
> +			goto out;
> +		}
>  		dp_cmn =3D &dp->ricp_v6.dp_cmn;
>  		saddr6 =3D &dp->ricp_v6.dp_saddr;
>  		daddr6 =3D &dp->ricp_v6.dp_daddr;
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index a1de114d5e2e..955d92277d5a 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -366,9 +366,11 @@ int rds_tcp_laddr_check(struct net *net, const struc=
t in6_addr *addr,
>  		rcu_read_unlock();
>  	}
>  #if IS_ENABLED(CONFIG_IPV6)
> -	ret =3D ipv6_chk_addr(net, addr, dev, 0);
> -	if (ret)
> -		return 0;
> +	if (ipv6_mod_enabled()) {
> +		ret =3D ipv6_chk_addr(net, addr, dev, 0);
> +		if (ret)
> +			return 0;
> +	}
>  #endif
>  	return -EADDRNOTAVAIL;
>  }


