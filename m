Return-Path: <linux-rdma+bounces-20704-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hKy5N4f0BWpVdwIAu9opvQ
	(envelope-from <linux-rdma+bounces-20704-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:12:55 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 320BB544828
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 18:12:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CF0B301BA55
	for <lists+linux-rdma@lfdr.de>; Thu, 14 May 2026 16:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5B632AAB2;
	Thu, 14 May 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWYr1JXQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764B433066E
	for <linux-rdma@vger.kernel.org>; Thu, 14 May 2026 16:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778775144; cv=none; b=R1I/xHEo4eAaxeYqiYAAzKLNGgbTflp8KfRKQGD1CGatum/eJp/UT+ztKXy40eah4E/I+bRiOMoeRmLScftu3cVjCXvciZ8kXhOqJsZRR9CiepWoXeB1Ij4w2EK3QC2uny74BsuBeU3ny9u55S/4Ta/EjaAuWlXRlN1PPwOARZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778775144; c=relaxed/simple;
	bh=eTKJVOXg2o5aD5lx7jCAlENhEJLCOmE4ytkf3G2jOd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oi8PKD+2tyYeh2isFzCq+V28nyeA2zOGFgGNVRSa5XZfFaCkdQURz7VmdEwC+FN3XCb74Zq18ltIlZuBpcnBptLOp4LUB0w6o9swIiG0AnvUM8oqrvk8r/57PzN9DEAz5KaVrqVzmxhxzoWW9wd+UGLDFiScbFbi+GX8247lDR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gWYr1JXQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09DEFC2BCB3;
	Thu, 14 May 2026 16:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778775144;
	bh=eTKJVOXg2o5aD5lx7jCAlENhEJLCOmE4ytkf3G2jOd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gWYr1JXQlhsWX0pqfZB2utw0F30nCOAAtDBemciCwZsqWYbR10puGuj16o6kir5JN
	 2gDeXRU2jQqlBsstkicTxUsnQgBkcJme5cSI0D05cFHHdjF2NGVA5oQ8g3DtARnIUg
	 Siq49maABOQ5F9p6t3B70DwuokH8ddxTExYFCwoGv48eaHFeifhTOGBYH9H7FJgXZp
	 3TLYzlp5edTVXjXSZa7/ocLY2TYwFypo3yOlhREe4xM1dDWegRkV0z88R9X44UV0y3
	 3zuDS6/WnEW/m9uuS+rYInIKR+llJAUTKfM8EEgRMOS3adLnJlONrqBDYwmQSEltEz
	 6ehYjf77Ernjg==
Date: Thu, 14 May 2026 09:12:23 -0700
From: Kees Cook <kees@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bernard Metzler <bernard.metzler@linux.dev>, rosenp@gmail.com,
	leon@kernel.org, gustavoars@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [RFC PATCH v3] RDMA/siw: use kzalloc_flex
Message-ID: <202605140906.EC4B0F5A@keescook>
References: <20260511141149.52362-1-bernard.metzler@linux.dev>
 <8226377c-0691-4368-bb82-48b620f784d2@linux.dev>
 <20260513142846.GN7702@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513142846.GN7702@ziepe.ca>
X-Rspamd-Queue-Id: 320BB544828
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20704-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.dev,gmail.com,kernel.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kees@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 11:28:46AM -0300, Jason Gunthorpe wrote:
> Ignore this, kxalloc_flex should not be assumed to initialize anything
> but 0. IDK why they put in the auto-initialize when it cannot be
> relied on, security in depth I guess.

Correct, manual initialization is still always required. The auto-init
(when counted_by is supported) is to deal with adding counted_by to code
that doesn't initialize the counter before access. i.e. this code used
to work:

thing = kzalloc(sizeof(*thing) + n * sizeof(*thing->fam));
access(thing->fam);
thing->fam_count = n;

but if we add counted_by and use kzalloc_flex, suddenly it breaks (at
access() time) unless kzalloc_flex also performs the "fam_count = n"
at alloc time.

-- 
Kees Cook

