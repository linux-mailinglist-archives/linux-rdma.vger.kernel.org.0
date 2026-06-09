Return-Path: <linux-rdma+bounces-22025-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rPAxN8lAKGpSBAMAu9opvQ
	(envelope-from <linux-rdma+bounces-22025-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 18:35:21 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8396E6626F1
	for <lists+linux-rdma@lfdr.de>; Tue, 09 Jun 2026 18:35:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Nx7jxR2I;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22025-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22025-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E09A30FE5DE
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jun 2026 16:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1CAE369D64;
	Tue,  9 Jun 2026 16:04:24 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F873655D9;
	Tue,  9 Jun 2026 16:04:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781021064; cv=none; b=tD8rSHOwoFaKq7COLDbWxnQskbw+0ghMnJD5nJ7jZT/OxQqDPz+XNn+qqVfzBS8iaKHstxM2Fjat8OpIGH71+sZxG1Gg/dFMrm3+Y6XuDQC4lB7Ym2WU/My9gEBENhyRwdHBI2ys270obESjIYlbP5u+CYVzJxNIOmmJ1s6w+3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781021064; c=relaxed/simple;
	bh=Htzjj+iBxZJDahLFAtt5wUwFAw1m+LlXlt/Fld8Ch1s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLXLYxR9coYdyiho8WjAowcF6pBL62vtG5554rSYJsC+XUJJK3NVGcZYNQDXRBnJSzkShpxrn0Oy3xYPZfYXzF+TQENMROwvvvxzSYcx8WFc8MmNseKlDxbf05fSalHwOz3eNVufsEi+anh2onyZVWWFTcC5NnMrCfo6tRPCCDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nx7jxR2I; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85C221F00893;
	Tue,  9 Jun 2026 16:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781021063;
	bh=t2wgkGNVfpS9fL7oWSyTipxzTFvk2mjVXvIgDz41TnE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Nx7jxR2IcaFDLN6VVikQBBdq4Q7JN6orMYlKhnIE3twN4qQmONXvaLb1rQKoGNtSy
	 ej8B8kqjtFPXJcUhAm/iGM3T1mxaA2qqafPyhH4QHHv0mLnK32shnTTD78002b781/
	 NccF8NiH1L4C+Hmjpd7P+lUBrLfZZV+yRuHOHoVTnBVYYf8FH/LhvnabGsSMUnezHJ
	 IHlJ4n8GNSiVdAmDnzc2KJDpADb9ITOKpOyj0isUeLrl85TLhbkqpq1TGfRztddrl9
	 rEamIZeC/LR6u9HAQzUoqgDO227C8TGk+62GTSC5Ob4VTzBKzBbhOw512FGcC2/4Mp
	 6vndQb6g++Oig==
Message-ID: <c68c873bf021ca2f64b582e337694c5a01871acd.camel@kernel.org>
Subject: Re: [PATCH net] rds: mark snapshot pages dirty in
 rds_info_getsockopt()
From: Allison Henderson <achender@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andy Grover
 <andy.grover@oracle.com>,  netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
 linux-kernel@vger.kernel.org, kernel-team@meta.com
Date: Tue, 09 Jun 2026 09:04:21 -0700
In-Reply-To: <aifP4O6jAMEKLJM-@gmail.com>
References: <20260608-rds_fix-v1-1-006c88543408@debian.org>
	 <7f310d00c39da9edf0019c130d346ce30107fd29.camel@kernel.org>
	 <aifP4O6jAMEKLJM-@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:andy.grover@oracle.com,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-22025-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8396E6626F1

On Tue, 2026-06-09 at 01:35 -0700, Breno Leitao wrote:
> On Tue, Jun 09, 2026 at 01:02:00AM -0700, Allison Henderson wrote:
> > On Mon, 2026-06-08 at 02:32 -0700, Breno Leitao wrote:
> > > rds_info_getsockopt() pins the destination user pages with FOLL_WRITE=
 and
> > > the RDS_INFO_* producers memcpy the snapshot into them through
> > > kmap_atomic(). Because that copy goes through the kernel direct map, =
the
> > > dirty bit on the user PTE is never set, so unpin_user_pages() release=
s the
> > > pages without marking them dirty. A file-backed destination page can =
then
> > > be reclaimed without writeback, silently discarding the copied data.
> > >=20
> > > Use unpin_user_pages_dirty_lock() with make_dirty=3Dtrue so the modif=
ied
> > > pages are marked dirty before they are unpinned.
> > >=20
> > > Fixes: a8c879a7ee98 ("RDS: Info and stats")
> > > Signed-off-by: Breno Leitao <leitao@debian.org>
> >=20
> > Hi Breno,
> >=20
> > Thanks for adding the Fixes tag. One thing though: now that this is
> > standalone, it collides with "[PATCH net-next v3 2/2] rds: convert to
> > getsockopt_iter" since both rewrite the same unpin in the out: block of
> > rds_info_getsockopt(). =20
> >=20
> > Easiest on everyone is to just keep it folded into the net-next series =
as
> > a three-patch set, rather than splitting the fix out to net.
>=20
> I got from the maintainers that they want to continue to split the fixes
> into net and non fixes (features) into net-next.
>=20
> 	"So just prepare for net with Fixes tags and we'll route the
> 	patches accordingly." -- Jakub
>=20
> https://lore.kernel.org/all/20260527155942.45c43c8d@kernel.org/
>=20
> Thanks for the review,
> --breno

I see, ok it's fine to apply my rvb then.

Thanks for working on this,
Allison


