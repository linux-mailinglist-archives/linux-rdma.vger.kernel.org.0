Return-Path: <linux-rdma+bounces-23047-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1XhtLkq+UWrXIAMAu9opvQ
	(envelope-from <linux-rdma+bounces-23047-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 05:53:46 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1711D7403A2
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 05:53:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=bZ56CzrI;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23047-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23047-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AF973021B13
	for <lists+linux-rdma@lfdr.de>; Sat, 11 Jul 2026 03:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B6F2848AA;
	Sat, 11 Jul 2026 03:53:40 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F26625;
	Sat, 11 Jul 2026 03:53:38 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783742020; cv=none; b=HJ/xX9QQWamkmmzQhqn5bnovvpD2SVM4tJqiLuc/J4Eqh8P+e/lXIR2xmjLpTAnP2668MitD0B9R4VNYt0Ng2i6ZJcZh7oi+me3iH43wjn4XMVeF/uyaLInm/cUP2A7qfcU25UG4ssd7soJHdUsQ8aS9h6kGbSw8BaDl5rI6MU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783742020; c=relaxed/simple;
	bh=lJEHQJ5XaWY96QiPsa9fI1sTZQy+WmQgbc0sTNpR5SQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SOmhY6NCFKl97R1+JdtwQB53yjhIopoEbUPC/w9BKnD1V/0d+gPSj7TiITk+bnHThW/R2yjk9q/CLi5WrF2nHzo33mrc64cSqkG+iL5nRb9xZkkV04qcJnoKXlDTFwEWY/StVV3W1MJ2lG5+OePbzdIeQpPwQ2P7okQrZvIjVdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bZ56CzrI; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E6C81F000E9;
	Sat, 11 Jul 2026 03:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783742018;
	bh=EOwelTdL4nOzgVPFS/BBmfP0iFtL0k/Qc7vjkrjb4QQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bZ56CzrI9ybzuoEtN3WaBfTAdeVwUNNhp2F4sCqU66Cg3NztJUv6pGBNEfQgYPViz
	 yKTGsegqsRJm99wVNuo5kF7cpMALez1ujccvzlWKxd/u8BpvkyAn/Il34fV3F/FvzU
	 UP/aT6/Mn3JKzk8uo1jdfJyL1zOBcUJ9AORkGCz1Aro3yeR/kZhY2r3hITKSBgoxkQ
	 Y31ZlduS8DOiK2smGurJ4AokTQN7O/BJIFGGjooc0op1KYQrGlWOy8e4ecmxDVqC03
	 4lMSv/gSjFdwCpYLX6t0gy/PZI0PWnSTyd1gjg/J3C3ShI4MlzLLF7KcAVAgdjw7rC
	 h14vSuBpHH70Q==
Message-ID: <f69ec0975481ad04dc7403834bbb6b93d1092ecb.camel@kernel.org>
Subject: Re: [PATCH net v2] rds: tcp: hold the RCU lock across
 ipv6_chk_addr() in rds_tcp_laddr_check()
From: Allison Henderson <achender@kernel.org>
To: Xiang Mei <xmei5@asu.edu>, "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
 rds-devel@oss.oracle.com, linux-kernel@vger.kernel.org, Santosh Shilimkar
 <santosh.shilimkar@oracle.com>, Ka-Cheong Poon <ka-cheong.poon@oracle.com>,
  bestswngs@gmail.com
Date: Fri, 10 Jul 2026 20:53:37 -0700
In-Reply-To: <20260710223029.1307043-1-xmei5@asu.edu>
References: <20260710223029.1307043-1-xmei5@asu.edu>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-23047-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:santosh.shilimkar@oracle.com,m:ka-cheong.poon@oracle.com,m:bestswngs@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,oss.oracle.com,oracle.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[asu.edu:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1711D7403A2

On Fri, 2026-07-10 at 15:30 -0700, Xiang Mei wrote:
> rds_tcp_laddr_check() looks up a scoped IPv6 interface with
> dev_get_by_index_rcu(), drops the RCU read-side lock, and only then
> passes the bare struct net_device * into ipv6_chk_addr().
>=20
> dev_get_by_index_rcu() only keeps the device alive within the same RCU
> read-side section. After rcu_read_unlock(), a concurrent RTM_DELLINK can
> free the net_device; ipv6_chk_addr() then dereferences the stale pointer
> in __ipv6_chk_addr_and_flags() (e.g. l3mdev_master_dev_rcu(dev)), reading
> freed memory.
>=20
> Keep the RCU read-side lock held across the ipv6_chk_addr() call instead
> of dropping it right after the lookup, so the device cannot be freed
> while it is in use.
>=20
>   BUG: KASAN: slab-use-after-free in __ipv6_chk_addr_and_flags (... net/i=
pv6/addrconf.c:1998)
>   Read of size 8 at addr ffff8880106ec000 by task exploit/153
>   Call Trace:
>    ...
>    kasan_report (mm/kasan/report.c:595)
>    __ipv6_chk_addr_and_flags (... net/ipv6/addrconf.c:1998)
>    ipv6_chk_addr (net/ipv6/addrconf.c:2031 net/ipv6/addrconf.c:1972)
>    rds_tcp_laddr_check (net/rds/tcp.c:370)
>    rds_bind (net/rds/bind.c:248)
>    __sys_bind (net/socket.c:1920)
>    __x64_sys_bind (net/socket.c:1956)
>    do_syscall_64 (arch/x86/entry/syscall_64.c:63)
>    entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
>=20



Thanks Xiang!  Just more thing to make sure your patches gets through. Add =
a change log here like this:

Changes since v1:
  Use rcu_read_locks instead of dev_hold/put
  Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when I=
Pv6 is disabled

Changes since v2:
  Add change log


Otherwise, it might get bounced if they happen to try your patch first.
With that fixed:=C2=A0=C2=A0
Reviewed-by: Allison Henderson <achender@kernel.org>

Thanks!
Allison

> Thanks Xiang!  Just more thing to make sure your patches gets through. Ad=
d a change log here like this:
>=20
> Changes since v1:
>   Use rcu_read_locks instead of dev_hold/put
>   Rebased on [PATCH net v2] rds: Fix inet6_addr_lst NULL dereference when=
 IPv6 is disabled
>=20
> Changes since v2:
>   Add change log
>=20
> Reviewed-by: Allison Henderson <achender@kernel.org>
> Fixes: eee2fa6ab322 ("rds: Changing IP address internal representation to=
 struct in6_addr")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  net/rds/tcp.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/net/rds/tcp.c b/net/rds/tcp.c
> index 955d92277d5a..30cfb0087f2c 100644
> --- a/net/rds/tcp.c
> +++ b/net/rds/tcp.c
> @@ -355,23 +355,25 @@ int rds_tcp_laddr_check(struct net *net, const stru=
ct in6_addr *addr,
>  	/* If the scope_id is specified, check only those addresses
>  	 * hosted on the specified interface.
>  	 */
> +	rcu_read_lock();
>  	if (scope_id !=3D 0) {
> -		rcu_read_lock();
>  		dev =3D dev_get_by_index_rcu(net, scope_id);
>  		/* scope_id is not valid... */
>  		if (!dev) {
>  			rcu_read_unlock();
>  			return -EADDRNOTAVAIL;
>  		}
> -		rcu_read_unlock();
>  	}
>  #if IS_ENABLED(CONFIG_IPV6)
>  	if (ipv6_mod_enabled()) {
>  		ret =3D ipv6_chk_addr(net, addr, dev, 0);
> -		if (ret)
> +		if (ret) {
> +			rcu_read_unlock();
>  			return 0;
> +		}
>  	}
>  #endif
> +	rcu_read_unlock();
>  	return -EADDRNOTAVAIL;
>  }
> =20


