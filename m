Return-Path: <linux-rdma+bounces-21826-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id k8dLDn2jImpcbQEAu9opvQ
	(envelope-from <linux-rdma+bounces-21826-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:22:53 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C503364748D
	for <lists+linux-rdma@lfdr.de>; Fri, 05 Jun 2026 12:22:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b="R/Kc8WrG";
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-21826-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-21826-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7F9BB30B18EF
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Jun 2026 10:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65A3F4DF1;
	Fri,  5 Jun 2026 10:08:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 579E03E833D;
	Fri,  5 Jun 2026 10:08:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654096; cv=none; b=PtNrOv3VKg9qMlPJB5ujyKxcUwrHCt4Dz9+MdU/23ruZzYe9TybuqfQXsx3aQROTViB+XJGsEMIZdprLo9JP8WN4A/q6vFr2T/5Kr/evTWZxPxHHRYGhqehHRyeazus7yaLafQsoRZXYEcMswyzB4+fzH2IQIq4iNbgTIGKwkss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654096; c=relaxed/simple;
	bh=16RvWksa+rizFjuIqdbs1bqsqadUr7KBVKH8Ybw50BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCFo76wA0mnvGN1PIA0gaEIPWGw9+SNe2s8n/swjedRGbyTAxzNatTFU+9qG9fEPf7PVVhQPg3CdUTqpJddc0Q1QnW2952vUJIi3VI7baKZma2egq6FBZcA+zRYnhYp7DdP2Zc2HqgxUbaZliWzH2Z+qu6nvdQeybRF2PBkd6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=R/Kc8WrG; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Reply-To:Content-ID:Content-Description;
	bh=D18Xtzr5xewgZKqPOSu7XXhuWStzZZlyZRzJN9HQ44w=; b=R/Kc8WrGjgX6J9KiYzCZr3mnwF
	4mQWH4LCREy9ixei3kdDF/5Q9NNebGw5Vmbe/mKc7I7YKEKVeRxzt7ZUbLvJ8KeYZ52VSB37LxB99
	MKJWLKez6JZrwwhk/ajDfvMWx74G4FuPR43VYyck5iX2TbgDfgJh+xycsz6+TdC8cDlWL4EpMqb13
	0y6oxISClWYsZV+4oEdxUxtFgJU5r4PQ853HupFE1ueOgQbYjXzN77jDuQJBsLODhlNR3TBfSQcAx
	enWm3Oy1TkNZ0buNq0O39ysqvQ3EFX31iYzqRe5E6r7f1KWysC5j5B9toR8MUrcsZ8ODnep1VSTRS
	DFh+/z8w==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wVRT9-005DDt-04;
	Fri, 05 Jun 2026 10:08:03 +0000
Date: Fri, 5 Jun 2026 03:07:57 -0700
From: Breno Leitao <leitao@debian.org>
To: Allison Henderson <achender@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, linux-rdma@vger.kernel.org, 
	rds-devel@oss.oracle.com, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 1/2] rds: convert to getsockopt_iter
Message-ID: <aiKfQfNHlaWLiP1F@gmail.com>
References: <20260603-getsock_more-v1-0-43b8d40c8849@debian.org>
 <20260603-getsock_more-v1-1-43b8d40c8849@debian.org>
 <4b81c104a8b0f67bb844b894cbd0c58a8191ac5d.camel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4b81c104a8b0f67bb844b894cbd0c58a8191ac5d.camel@kernel.org>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-rdma@vger.kernel.org,m:rds-devel@oss.oracle.com,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-21826-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C503364748D

On Thu, Jun 04, 2026 at 07:20:24PM -0700, Allison Henderson wrote:
> Thanks for working on this.  The conversions look mostly correct to me, just a few nits I noticed below:

Thanks for the very detailed review.

> > +	/* The info producers write into the pages with kmap_atomic() while
> > +	 * holding a spinlock, so they need a genuine page-backed user buffer.
> > +	 */
> > +	if (iov_iter_is_kvec(&opt->iter_out)) {
> > +		ret = -EOPNOTSUPP;
> > +		goto out;
> I think !user_backed_iter() is more accurate for what you're meaning to do here?  Technically we only ever get kvecs or
> ubufs since rds_info_getsockopt is only called by do_sock_getsockopt.  Those appear to be the only two types it passes,
> so it works out.  But it means we're counting on that assumption from the caller and ideally we should filter anything
> that's not user backed.  So, I'd replace the iov_iter_is_kvec check with:
> 
> 	if (!user_backed_iter(&opt->iter_out)) {

Agreed, that's more accurate and doesn't lean on the caller only ever
handing us kvec or ubuf. Will switch to !user_backed_iter() in v2.

> > @@ -230,13 +239,12 @@ int rds_info_getsockopt(struct socket *sock, int optname, char __user *optval,
> >  		ret = lens.each;
> >  	}
> >  
> > -	if (put_user(len, optlen))
> > -		ret = -EFAULT;
> > +	opt->optlen = len;
> >  
> >  out:
> The unpin here works, but it took me a little bit to trace out where the corresponding pin went since it is removed
> earlier in the patch.  Pages are pinned on extract, but only for user pages. This works out since the only caller here
> passes kvec or ubuf, and we error out on kvec iters.  Pages are assumed pinned if they're not null, but without the
> !user_backed_iter check, it leans on this behavior from the caller.  Ideally I think iov_iter_extract_pages is supposed
> to be paired with iov_iter_extract_will_pin.  A quick comment would help clarify too.  So the closing gate would look
> something like this:
> 
> 	/* unpin pages from ubuf iters */
> 	if (pages && iov_iter_extract_will_pin(&opt->iter_out))
> 
> >  	if (pages)
> >  		unpin_user_pages(pages, nr_pages);
> 
> Having both checks is somewhat redundant, but it doesnt hurt anything either.  And I think it helps make it a little
> more uniform and readable.  Other than that I think this patch is looking pretty good to me.

Makes sense. In v2 I'll pair the extract with extract_will_pin and add a
comment so the pin/unpin contract is self-documenting:

  out:
              /*
               * iov_iter_extract_pages() pins only user-backed (ubuf)
               * iters; iov_iter_extract_will_pin() reports whether an
               * unpin is owed here.
               */
              if (pages && iov_iter_extract_will_pin(&opt->iter_out))
                      unpin_user_pages(pages, nr_pages);
              kvfree(pages);

Thanks for the review!
--breno

