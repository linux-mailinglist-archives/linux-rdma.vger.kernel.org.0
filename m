Return-Path: <linux-rdma+bounces-22597-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M5+ZMCXcQ2qtkQoAu9opvQ
	(envelope-from <linux-rdma+bounces-22597-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 17:09:25 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 28FFD6E5BFB
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 17:09:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=D5QS6KFh;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22597-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22597-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF30B30D0AD1
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 15:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3527281E;
	Tue, 30 Jun 2026 15:00:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82ACD21ABAA;
	Tue, 30 Jun 2026 15:00:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782831625; cv=none; b=jqr0HvFzd28p0DodTfhHWlZWwwk5ZQy6EvZ5Xhig82fEZxeJ2q/mdymz6xQ54Ygh/t62bjCSx9g80NPZUUDueBpBkNvrtG/+FzyWnMb4MZkkkj27XaH7ax5bwjF7s4WSTr1wFZI3354dgYNpL+PkDfosfHB21flOtyqs9XdIylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782831625; c=relaxed/simple;
	bh=MPzABO0zBN/6WA35CI45RYVH+YOk7AmePdrxclcf2ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=unGT3FGQ5jbYnXYozZfB2V2o9zqzXfSc0kI6efljxPsUz/f5mw0qduyVnZncsk1XnzUvkR+McwXXCsmYcgLdEQb2prSOe4W1GAU55VIX7y8Pa0NGJbY9Uuk4OaRPu8oivIgMsVz7QzzoTgtK0gyzWeXNDJwaGtVjlf8/za2Z+fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D5QS6KFh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB01F1F000E9;
	Tue, 30 Jun 2026 15:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782831624;
	bh=lEjljAT8oCBe6H0+DZxoSp7D0aXaqVksk3/Y1JCjZd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=D5QS6KFhU/5DOxHs4TOWy0bffEu1vpyOjarro1YAFzBSMYJ0jmUqd8LXAXR5OSaYX
	 lT+ZeDgjVMLyeTBPni32H7bS6yD3N1YatU8vQZ3m4XXPIvFBZ3bClUETpdYbq6NLN0
	 D525b55NxYXe3NhT9lr1DvZDoZmx3XKZXU9PtqtAN+uGBEEWkUx4jDIMjFq5ywIOYB
	 0k2hic87Cigrr0lRB35EPiUya7c9cB7pohffQfgPmFBS9sx4Q0i+DDDGdU7K9/pwAh
	 gSQmlmDsiNreWpKLyF9SfSGdt/GUWU4i07X6MW5tXoGFu0D9jvOBINDUNGr6sQp+rf
	 9Ql8aWYKvA5/g==
Date: Tue, 30 Jun 2026 18:00:18 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/5] RDMA/umem: ib_umem_get(): use kmalloc() to allocate
 page array
Message-ID: <akPaAp-0Zul8uVga@kernel.org>
References: <20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org>
 <20260630-b4-rdma-v1-1-ab42bcf0de92@kernel.org>
 <20260630123150.GB7525@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260630123150.GB7525@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-22597-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28FFD6E5BFB

(adding Vlastimil)

On Tue, Jun 30, 2026 at 09:31:50AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 30, 2026 at 01:52:29PM +0300, Mike Rapoport (Microsoft) wrote:
> > ib_umem_get() allocates an array of pointers to struct page for
> > pin_user_pages_fast() calls during memory registration.
> 
> A whole bunch of these use cases in rdma are really "give me some
> temporary memory, I want it fast and as large as possible. In a
> syscall context I will free it before returning back to userspace"

Not sure I follow where "as large as possible" comes from. Here it's
explicitly a page.

And does "fast" mean that vmalloc() is not an option?
 
> eg we'd be really happy to get any kind of high order page here.
> 
> So, how would you feel about a new API?
> 
>  void *kmalloc_temporary(size_t min_size, size_t max_size, size_t *actual_size, gfp);
> 
> I know of a few other cases like this in the kernel at least.
> 
> The implementation could try to find an available high order page and
> immediately return it, otherwise do a small reclaim allocation?

How do you suggest to decide how much of reclaim should happen? With the
usual semantics of gfp?

> Jason

-- 
Sincerely yours,
Mike.

