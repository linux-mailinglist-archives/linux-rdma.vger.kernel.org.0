Return-Path: <linux-rdma+bounces-22730-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id n92FGgG+RmoGcgsAu9opvQ
	(envelope-from <linux-rdma+bounces-22730-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 21:37:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CCF726FC925
	for <lists+linux-rdma@lfdr.de>; Thu, 02 Jul 2026 21:37:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=LAFXpiM5;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22730-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22730-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 438853045098
	for <lists+linux-rdma@lfdr.de>; Thu,  2 Jul 2026 19:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CFAA390230;
	Thu,  2 Jul 2026 19:36:38 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C9438C42E;
	Thu,  2 Jul 2026 19:36:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783020997; cv=none; b=Rvv8IkYt9fWC7kAUXA5ri9TeaGyK+b85BdPdYkNZdF1x5ixJVtEyuEaAlh3AILtjgJxL2SULop6dBa06DATjFQitGbjV9u0CTk5lt4PpE0yfl4q1GSdtnVSvtBwww9F//bG2jnXFqgpy7B7VosW+AbKql1HIIWSgEiReLcWU+b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783020997; c=relaxed/simple;
	bh=3UryPjSdrm1VNQ0lGXMgyb8aizmIz6MkoIzRwt5AT10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M7qx7JAZen5gDj6B+6+QzTUE4meZmyw1VoZCzXMOS4/hNmfim3ZfC0+mCIWhWUocN46adP16M4cAdVlHR0BfPY1mBlo6ltj58VTzxKAtQIjLfgf766vT6ovdFzVJeHv6QM2HtSekfAZ1pTScqfr7vCaa8X8UU728sets08cuw7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LAFXpiM5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1472B1F000E9;
	Thu,  2 Jul 2026 19:36:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783020996;
	bh=MY2PvaibwGLXUsakAE8KZoj1YpuVr+KpHhe3HAZG2cY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=LAFXpiM5yXxtgfZHPm0Wh6d4EBqzikJlBc9DZIxvBW///LR3ZlYwKS8VEPhSwMLni
	 5Ff1rr215W1jtQ9H2DzGiUboxwvpI5gOpyVzV3hYRsJZFbmnsbDraXswJRf4pSPpLh
	 AXpX69ssAn2+z4jkrwG0EjeH/PNCQbHCcU5pREN4CTil3KOkOfPs6UlTytKpfCdd8E
	 ZU81jx3RMsZqYWVMkj0rldjftacBQw2G39vyw/9rZNMDDec1AJu1aUJuaGgTZNLRTV
	 DXTsecJkTevpSvOEketwG0h8D74tZ79onp22LrWroYO0H2YtdHcq08iR2P6uMWX6Lg
	 dC21cEPa1sOaQ==
Date: Thu, 2 Jul 2026 22:36:29 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	Michal Hocko <mhocko@kernel.org>,
	"David Hildenbrand (Red Hat)" <david@kernel.org>,
	Dave Chinner <dgc@kernel.org>
Subject: Re: [PATCH 1/5] RDMA/umem: ib_umem_get(): use kmalloc() to allocate
 page array
Message-ID: <aka9vZSViFlzBrwW@kernel.org>
References: <20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org>
 <20260630-b4-rdma-v1-1-ab42bcf0de92@kernel.org>
 <20260630123150.GB7525@ziepe.ca>
 <akPaAp-0Zul8uVga@kernel.org>
 <akPaPaCJdYINBEEV@kernel.org>
 <20260630153638.GG7525@ziepe.ca>
 <9cc11eeb-372a-49fb-ba89-486333ac71c4@kernel.org>
 <20260702125516.GO7525@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702125516.GO7525@ziepe.ca>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22730-lists,linux-rdma=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:vbabka@kernel.org,m:leon@kernel.org,m:dennis.dalessandro@cornelisnetworks.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,m:willy@infradead.org,m:mhocko@kernel.org,m:david@kernel.org,m:dgc@kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[linux-rdma];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CCF726FC925

On Thu, Jul 02, 2026 at 09:55:16AM -0300, Jason Gunthorpe wrote:
> On Thu, Jul 02, 2026 at 02:46:46PM +0200, Vlastimil Babka (SUSE) wrote:
> > I think this should be discussed more broadly and not block this
> > change.
> 
> Currently all of these get_free_pages ones in this series are this
> special need, so I'd like to not loose that marking somehow. Maybe a
> comment or maybe a inline wrapper function.

Comment is easy :)

As for an inline wrapper, is there an appropriate rdma header to put it?
I don't think it belongs to slab.h.

> Jason

-- 
Sincerely yours,
Mike.

