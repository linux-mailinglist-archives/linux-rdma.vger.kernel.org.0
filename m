Return-Path: <linux-rdma+bounces-23193-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6dqTDMktVmps0wAAu9opvQ
	(envelope-from <linux-rdma+bounces-23193-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:38:33 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9481C754A51
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:38:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A1JGbJ7n;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23193-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23193-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1239030E2A74
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 12:30:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CECFB448D13;
	Tue, 14 Jul 2026 12:28:25 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4357B4483BE;
	Tue, 14 Jul 2026 12:28:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784032104; cv=none; b=prd+1fJf2dgwBMobMQcbWWdIUCtSLj1nT5K3ddK+ko6N1CqJ0R6spuatOUqIDsYNhuMZszhKH5ufn7x/1nabDQ7VNIDgB/AKuqUjiAk2aPDB4O4FzyDW4rU2TrYE6MyeIZQsHX3sveoMDPGNeZGM1O3sDBQ3u8yXFD1LWj84S5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784032104; c=relaxed/simple;
	bh=e6W3rRljH9s2qNsuCgb1A8N3quDHRMi0XsVpVxmgfsQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMs7a2auKLYe4eS0LKh/ojPxbTTIXmkN9lz+b/uOXbx+B/2urazo0P0Z5wTflcff23rVqDS+VWvXQLMBEGhu9Sa/6xsOVImaQbB/8ZsbIX60KR2qKSHfIcs5UoBNPD18r8SKNzbqEVQXuCJhJynDNYEX0IRDhq5jV5R9dAr+JWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A1JGbJ7n; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFE91F00A3A;
	Tue, 14 Jul 2026 12:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784032101;
	bh=+oslaUM27lhUj79GayiLUHIp4AZwhj+Xm81InQr+S28=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=A1JGbJ7n6lr8x/40sEJ5ktfvHwkiKUIbbHDtqsJr3p+3V/b1m6XvWO/HJ4ptNxB7g
	 rG7G3Ei7YrR3ecoJHXXsFHQo2lvdGyyMPareLJAhSpZw5LPhcFJ+GqAL4SUqvAXsi9
	 AFw50u6XqzQhSkExiIm+ymDv1wKis34+RGr4mhJ6Ggs00Wz+tPbL6PoY4pQml8CpmB
	 jIytPsG3BII/c3A/uGXiqLjR1wJk54rWoVr9q08eU8PI+ye9rO7wCfymQYGpeo1Dpz
	 OegVMdOYU+bYvAxhOCNlqH+nME9C+6Dju27rTDHPPR9kdTgZHKavG6HKeBXSsMT9pY
	 NogEbuF3Q7H8Q==
Date: Tue, 14 Jul 2026 15:28:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/5] RDMA, IB: replace __get_free_pages() with
 kmalloc()
Message-ID: <20260714122818.GE19233@unreal>
References: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
 <20260714122456.GD19233@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260714122456.GD19233@unreal>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:jgg@ziepe.ca,m:dennis.dalessandro@cornelisnetworks.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23193-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9481C754A51

On Tue, Jul 14, 2026 at 03:24:56PM +0300, Leon Romanovsky wrote:
> On Mon, Jul 13, 2026 at 10:17:21AM +0300, Mike Rapoport (Microsoft) wrote:
> > This is a (small) part of larger work of replacing page allocator calls
> > with kmalloc.
> > 
> > My initial intention a few month ago was to remove ugly casts [1], but then
> > willy pointed out that Linus objected to something like this [2] and it
> > looks like more than a decade old technical debt.
> > 
> > Largely, anything that doesn't need struct page (or a memdesc in the
> > future) should just use kmalloc() or kvmalloc() to allocate memory.
> > kmalloc() guarantees alignment, physical contiguity and working
> > virt_to_phys() and beside nicer API that returns void * on alloc and
> > doesn't require to know the allocation size on free, kmalloc() provides
> > better debugging capabilities than page allocator.
> > 
> > Another thing is that touching these allocation sites gives the reviewers
> > opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> > another size is appropriate.
> > 
> > For larger allocations that don't need physically contiguous memory
> > kvmalloc() can be a better option that __get_free_pages() because under
> > memory pressure it's is easier to allocate several order-0 pages than a
> > physically contiguous chunk with the same number of pages.
> > 
> > And last, but not least, removing needless calls to page allocator should
> > help with memdesc (aka project folio) conversion. There will be way less
> > places to audit to see if the user was actually using struct page.
> > 
> > Also in git:
> > https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/rdma
> 
> Will you also change get_zeroed_page() in RDMA, or should I
> prepare a patch?

➜  kernel git:(wip/leon-for-next) git grep get_zeroed_page drivers/infiniband/
drivers/infiniband/hw/bnxt_re/ib_verbs.c:                       srq->uctx_srq_page = (void *)get_zeroed_page(GFP_KERNEL);
drivers/infiniband/hw/bnxt_re/ib_verbs.c:               cq->uctx_cq_page = (void *)get_zeroed_page(GFP_KERNEL);
drivers/infiniband/hw/bnxt_re/ib_verbs.c:       uctx->shpg = (void *)get_zeroed_page(GFP_KERNEL);
drivers/infiniband/hw/mlx4/mr.c:        mr->pages = (__be64 *)get_zeroed_page(GFP_KERNEL);
drivers/infiniband/hw/qedr/verbs.c:     q->db_rec_data = (void *)get_zeroed_page(GFP_USER);

Thanks

> 
> Thanks
> 
> > 
> > [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> > [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/ 
> > 
> > ---
> > v2 changes:
> > * add comment to keep markers for sites that need "fast and as large as
> >   possible" allocation helper
> > 
> > v1: https://patch.msgid.link/20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org
> > 
> > ---
> > Mike Rapoport (Microsoft) (5):
> >       RDMA/umem: ib_umem_get(): use kmalloc() to allocate page array
> >       RDMA/mlx5: replace __get_free_page() with kmalloc()
> >       IB/mthca: mthca_reg_user_mr(): use kmalloc() to allocate addresses array
> >       IB/mthca: allocate mthca_array memory with kzalloc()
> >       IB/rdmavt: use kzalloc() to allocate QPN-map pages
> > 
> >  drivers/infiniband/core/umem.c                | 5 +++--
> >  drivers/infiniband/hw/mlx5/odp.c              | 6 ++++--
> >  drivers/infiniband/hw/mthca/mthca_allocator.c | 6 +++---
> >  drivers/infiniband/hw/mthca/mthca_provider.c  | 5 +++--
> >  drivers/infiniband/sw/rdmavt/qp.c             | 8 ++++----
> >  5 files changed, 17 insertions(+), 13 deletions(-)
> > ---
> > base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> > change-id: 20260610-b4-rdma-44625922fe16
> > 
> > --
> > Sincerely yours,
> > Mike.
> > 
> 

