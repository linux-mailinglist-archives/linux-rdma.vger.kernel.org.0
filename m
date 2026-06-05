Return-Path: <linux-rdma+bounces-21878-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1DopJspMI2qPoQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21878-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 00:25:14 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01BCB64B9FF
	for <lists+linux-rdma@lfdr.de>; Sat, 06 Jun 2026 00:25:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=PX+hhUSe;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21878-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21878-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85D78303C64D
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 22:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1EF3B2FC8;
	Fri,  5 Jun 2026 22:22:58 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33371387362;
	Fri,  5 Jun 2026 22:22:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780698178; cv=none; b=d2bDqQYJ8+8V35wJrEiDjtCnea+NxTynCelLMZZ9gY8slf2dlbN+CXuY6thxHF2sHhgira0e4RlOSAsEEC33owTJSmXztngCtZCsz2CR3p8F672knWMLfGZPfAD/7HrkwmLLROzoRubENQF1uMLmMUQl+uaLAGyAFW+635WSAdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780698178; c=relaxed/simple;
	bh=y6xdVTXRfQbtR3STyUPrENAMKidFYd8kN+SkK8XvPOM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fqYyiO5XbivlEztBNW2+S4dXYEbdwn0PojESKYx4otF80M4iEGs+FThH9PFc9rdSSS3eQ1Fe8o/Z7uKUm+CB01Ty6041oyQ2WiCnnHi9jf81wGs+1eQe2n9TZx812Jz9xTaDhYE4xIGAndegujr5lw7zpM/UwJ0Tot65rFvLUDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PX+hhUSe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 094BE1F00893;
	Fri,  5 Jun 2026 22:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780698176;
	bh=7XgDadmUDLEi2PC1fUYzSXSnqluO/U4sZustqFpUA7c=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PX+hhUSee/XaWAVauUxaMUs33SGdzFkIF8mZefdpKs6KFjhT3Ua52TlU2WaxfP+LI
	 c+nkqi8IMFU3IK8YOb5holuXdtNdOt5DFVPPzEXWaGwF275aCooidGjfdi/hc5AsMP
	 Y7qSrFDE68ZMfwfoXeg/3cfGwZU0D25o/tQjfca4WTqmQ1TmaKcNSmrw9bPSQTsXi0
	 kftPVx38S9TVznWDoTbXptYXkbjJNqQzlvDyQ2/+Wadr+53nZGCZh+R/qoVOa7XgyV
	 zD3iZX94FmSovnqOkOekPXih5uPuCalWVFHYYfgJYZBx5O5GpQ/A/o1WY4okImSyx1
	 yr2culC3IWTXw==
Message-ID: <dea41eedebf284c2a57e75d1ca99b59a58863160.camel@kernel.org>
Subject: Re: [PATCH net-next v2 1/3] rds: mark snapshot pages dirty in
 rds_info_getsockopt()
From: Allison Henderson <achender@kernel.org>
To: Breno Leitao <leitao@debian.org>, "David S. Miller"
 <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,  Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com, 
	linux-kselftest@vger.kernel.org, kernel-team@meta.com
Date: Fri, 05 Jun 2026 15:22:55 -0700
In-Reply-To: <20260605-getsock_more-v2-1-80f38cdb8706@debian.org>
References: <20260605-getsock_more-v2-0-80f38cdb8706@debian.org>
	 <20260605-getsock_more-v2-1-80f38cdb8706@debian.org>
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
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21878-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[achender@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 01BCB64B9FF

On Fri, 2026-06-05 at 03:31 -0700, Breno Leitao wrote:
> rds_info_getsockopt() pins the destination user pages with FOLL_WRITE and
> the RDS_INFO_* producers memcpy the snapshot into them through
> kmap_atomic(). Because that copy goes through the kernel direct map, the
> dirty bit on the user PTE is never set, so unpin_user_pages() releases th=
e
> pages without marking them dirty. A file-backed destination page can then
> be reclaimed without writeback, silently discarding the copied data.
>=20
> Use unpin_user_pages_dirty_lock() with make_dirty=3Dtrue so the modified
> pages are marked dirty before they are unpinned.
>=20
> Signed-off-by: Breno Leitao <leitao@debian.org>
Hi Breno,

Thanks for following up with the Sashiko report.  Since this is a bug fix, =
it should carry a fixes tag.  This is a long
standing bug that's been present since the codes original appearance in a8c=
879a7ee98 ("RDS: Info and stats").  So it
should carry that in a fixes tag:

Fixes: a8c879a7ee98 ("RDS: Info and stats")

Other than that it looks fine to me.  Thanks for catching this.
Allison

> ---
>  net/rds/info.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/net/rds/info.c b/net/rds/info.c
> index f1b29994934a..17061f6ff74e 100644
> --- a/net/rds/info.c
> +++ b/net/rds/info.c
> @@ -235,7 +235,7 @@ int rds_info_getsockopt(struct socket *sock, int optn=
ame, char __user *optval,
> =20
>  out:
>  	if (pages)
> -		unpin_user_pages(pages, nr_pages);
> +		unpin_user_pages_dirty_lock(pages, nr_pages, true);
>  	kfree(pages);
> =20
>  	return ret;
>=20


