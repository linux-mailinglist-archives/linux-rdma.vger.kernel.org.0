Return-Path: <linux-rdma+bounces-19075-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLZCN3W41GnQwgcAu9opvQ
	(envelope-from <linux-rdma+bounces-19075-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 09:55:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3D33AB033
	for <lists+linux-rdma@lfdr.de>; Tue, 07 Apr 2026 09:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BE3CA300A8EE
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Apr 2026 07:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECC103A3817;
	Tue,  7 Apr 2026 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iS789lTn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB2E3A0E93;
	Tue,  7 Apr 2026 07:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775548515; cv=none; b=L6alaVuCCE9UFS94Ci0+hQcxlc4q2vJqbvRLAFkB2X7q7C6Fub/cNcQvarYOkDcaME12CqNzJyNFAEV+ITlRoaFMZKzuj9eWJJ1E6pb7s9kcRCTyV40WkOD5R8bdjyn9VcgkljDF+57e8jeXD4pBS+TSQs3BjZTj4uEe3XwT1Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775548515; c=relaxed/simple;
	bh=sXqj+82/AJCtXH7jdhi8PtmByrItm3ulIt8JGoHDNAI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pkhZFOKdl5e9xb48wsNcGfRZYpFPMqjaI4SUDcQ9DpjZHxl4dzh61CAo7k750ZGj6Qlhs+oAe7CuaZA7hpmoA9V81K8DbDIgelo87EAbo1OHkyWlWRa7+U36KQWDSc0NFNmrOBqLe8GyQ8VxeFdcToqUQ39OI2EBqIJyYcJP7k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iS789lTn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD6EEC116C6;
	Tue,  7 Apr 2026 07:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775548515;
	bh=sXqj+82/AJCtXH7jdhi8PtmByrItm3ulIt8JGoHDNAI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=iS789lTnPjeW96at8PcKznFJwn0Nc2545ot2hEI+IEPOXQIfmWquBE8jVp9J2e8Ma
	 TtGjF0/A12QTAHqdZs4F6DxHm/Gbpp5HkZHzrZnDLNLVU2HRZWBqfB4wkbUgMpCsGF
	 /pAL5fiAKaIx7KgH0k0anSRp39Mht0tq19O4VI3VUC4cot+36OyNstBcN3/CJbPSZV
	 AX67eNb4PkH7UUGeaWC9R2gIKO6yBRZvNLcRNLrLAmPfECzMwwqxLprgb3/cyefRWp
	 msUzOxnMQg2IACA7Cs9uqgOEcoHRS/c7n3wx6lxIEyW1Cp/7+shKgm31vNwlHNnB8T
	 Us004aBxQA8ow==
Message-ID: <daf63276f1df31a4cb32b97f52ff9d1cbfd038bb.camel@kernel.org>
Subject: Re: [PATCH net v1 1/2] net/rds: Optimize rds_ib_laddr_check
From: Allison Henderson <achender@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: rds-devel@oss.oracle.com, edumazet@google.com,
 linux-rdma@vger.kernel.org,  horms@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org
Date: Tue, 07 Apr 2026 00:55:13 -0700
In-Reply-To: <20260407011900.3596320-1-kuba@kernel.org>
References: <20260405041613.309958-2-achender@kernel.org>
	 <20260407011900.3596320-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19075-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8C3D33AB033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-06 at 18:19 -0700, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> net/rds: Optimize rds_ib_laddr_check
>=20
> This patch optimizes rds_ib_laddr_check() to avoid excessive
> rdma_bind_addr() calls by checking if an address has been used before.
> It renames the original function to rds_ib_laddr_check_cm() and
> introduces a new wrapper that first checks rds_ib_get_device() before
> falling back to the CM-based check.
>=20
> > diff --git a/net/rds/ib.c b/net/rds/ib.c
> > index ac6affa33ce7..73e01984ee9a 100644
> > --- a/net/rds/ib.c
> > +++ b/net/rds/ib.c
> > @@ -401,8 +401,8 @@ static void rds6_ib_ic_info(struct socket *sock, un=
signed int len,
> >   * allowed to influence which paths have priority.  We could call user=
space
> >   * asserting this policy "routing".
> >   */
> > -static int rds_ib_laddr_check(struct net *net, const struct in6_addr *=
addr,
> > -			      __u32 scope_id)
> > +static int rds_ib_laddr_check_cm(struct net *net, const struct in6_add=
r *addr,
> > +				 __u32 scope_id)
> >  {
> >  	int ret;
> >  	struct rdma_cm_id *cm_id;
>=20
> [ ... ]
>=20
> > @@ -487,6 +487,20 @@ static int rds_ib_laddr_check(struct net *net, con=
st struct in6_addr *addr,
> >  	return ret;
> >  }
> >=20
> > +static int rds_ib_laddr_check(struct net *net, const struct in6_addr *=
addr,
> > +			      __u32 scope_id)
> > +{
> > +	struct rds_ib_device *rds_ibdev =3D rds_ib_get_device(addr->s6_addr32=
[3]);
> > +
> > +	if (rds_ibdev) {
> > +		rds_ib_dev_put(rds_ibdev);
> > +
> > +		return 0;
> > +	}
> > +
> > +	return rds_ib_laddr_check_cm(net, addr, scope_id);
> > +}
> > +
>=20
> Can this code handle pure IPv6 addresses correctly? The function extracts
> addr->s6_addr32[3] and passes it to rds_ib_get_device(), which looks up
> devices by IPv4 address.
>=20
> For IPv4-mapped IPv6 addresses, addr->s6_addr32[3] contains the IPv4
> address. But for pure IPv6 addresses (when CONFIG_IPV6 is enabled),
> addr->s6_addr32[3] contains the last 32 bits of the IPv6 address, which
> could accidentally match a stored IPv4 address.
>=20
> When this collision occurs, the function returns 0 (success) without
> calling rds_ib_laddr_check_cm(), which performs the full validation
> including rdma_bind_addr() and IPv6 link-local scope_id checks. This
> means a pure IPv6 address could be incorrectly accepted as valid for IB
> transport.
>=20
> Should this be guarded with an ipv6_addr_v4mapped(addr) check? For
> example:
>=20
>     if (ipv6_addr_v4mapped(addr)) {
>         rds_ibdev =3D rds_ib_get_device(addr->s6_addr32[3]);
>         ...
>     }
>=20
> The existing callers of rds_ib_get_device (rds_ib_get_mr,
> rds_ib_update_ipaddr) operate in post-connection contexts where the
> address type is already validated, but rds_ib_laddr_check is the
> validation gate called during bind/transport-selection for any address
> type.

Ok  I think the correct ports to fix this would be these two commits:
https://github.com/oracle/linux-uek/commit/caffdcae6593	=C2=A0
caffdcae6593 ("rds: Enable RDS IPv6 support")

https://github.com/oracle/linux-uek/commit/cb82f22bbff5 =C2=A0
cb82f22bbff5 ("rds: Changed IP address internal representation to struct in=
6_addr")

But that is starting to snowball quite a bit outside the scope of the syzbo=
t bug, and a lot of rds port patches tend to
domino like this if we don't find a way to contain it.  So for the syzbot r=
eport, I think the ai suggestion is
reasonable.  So, if folks agree, I am fine to add that check in v2.

Thank you!
Allison

>=20
> >  static void rds_ib_unregister_client(void)
> >  {
> >  	ib_unregister_client(&rds_ib_client);
>=20
> [ ... ]


