Return-Path: <linux-rdma+bounces-23191-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZFhOGf4rVmq10gAAu9opvQ
	(envelope-from <linux-rdma+bounces-23191-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:30:54 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C341075490C
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 14:30:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Uk8LCrfd;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23191-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23191-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA670311DB30
	for <lists+linux-rdma@lfdr.de>; Tue, 14 Jul 2026 12:26:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFAA45BD6C;
	Tue, 14 Jul 2026 12:25:14 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73CE3F65F9;
	Tue, 14 Jul 2026 12:25:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784031913; cv=none; b=llRhd4PTbEyoSsYfXVONngcRpjxcz1gHl3isV84dutzLtybzHgtKN3uaQxOxAa0szIEGuPI0wz4qREWN91+xJPcsRXBwLGvQxNpu6mGNSbFkiPQakGE70i9TaiuZSJwZ9huUD7aVb+kZ+/zSIH8CbzP+vJ6R0FSlLG06dy6Ie6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784031913; c=relaxed/simple;
	bh=X+zhc8g0fJVudjV8pFBtpHMZsTT4XVawhNZEoqTcuW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZqRNBKh26w7jYTcU8XCmYHmS6hJ5F/6zDwgEDoVVbxDIUyxzNOcbTBesnFGCqkzpUU0PS/vVeqabPcdVb2qgElZdZNP7v8Ly7m4rrbYHR/Pt+3foECp4LTa5A8HveU4J7GxcX1gmfmQoUsVDTa0tOAftEJ7U/4Ek8CXN5wtmsWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Uk8LCrfd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB38A1F00A3A;
	Tue, 14 Jul 2026 12:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784031899;
	bh=ncHjbQ9ufoT6SdeAfwRC2oHP5TMeYh9A0isrkQOo65c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Uk8LCrfdl+bpQBeTpDRh0oc+8+a48aSIelbqzRi4zcYvWLX8sL8PxBp5hbaMZ0N9Y
	 nVwiwe5noR2fo5n8OoliuzsH7AN/eZRgcnZMxx4vJk4UrEIUqUa6k2idnbK9QgHqXj
	 MvcdH/lQE7Be/UpQwxNPD6F6RDv4kQpNEWdShdefAKU7jb+xKA44rV4fWKT8iKCIpd
	 oYq5git6zMaT/Ydsw25+f41mpCLw8kebEFGA22uBE3LXWKxb4zzlWHCYg2aA4NMASc
	 6KhnkAFxAiN3+HQ57h5wBLKt+VIJv0+/x3+ocfej2PJIAOaCgDGi2/izTJw36B81t0
	 qYENoTSEHp4mg==
Date: Tue, 14 Jul 2026 15:24:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 0/5] RDMA, IB: replace __get_free_pages() with
 kmalloc()
Message-ID: <20260714122456.GD19233@unreal>
References: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260713-b4-rdma-v2-0-65d2a1a5180c@kernel.org>
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
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:rppt@kernel.org,m:jgg@ziepe.ca,m:dennis.dalessandro@cornelisnetworks.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-rdma@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23191-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C341075490C

On Mon, Jul 13, 2026 at 10:17:21AM +0300, Mike Rapoport (Microsoft) wrote:
> This is a (small) part of larger work of replacing page allocator calls
> with kmalloc.
> 
> My initial intention a few month ago was to remove ugly casts [1], but then
> willy pointed out that Linus objected to something like this [2] and it
> looks like more than a decade old technical debt.
> 
> Largely, anything that doesn't need struct page (or a memdesc in the
> future) should just use kmalloc() or kvmalloc() to allocate memory.
> kmalloc() guarantees alignment, physical contiguity and working
> virt_to_phys() and beside nicer API that returns void * on alloc and
> doesn't require to know the allocation size on free, kmalloc() provides
> better debugging capabilities than page allocator.
> 
> Another thing is that touching these allocation sites gives the reviewers
> opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
> another size is appropriate.
> 
> For larger allocations that don't need physically contiguous memory
> kvmalloc() can be a better option that __get_free_pages() because under
> memory pressure it's is easier to allocate several order-0 pages than a
> physically contiguous chunk with the same number of pages.
> 
> And last, but not least, removing needless calls to page allocator should
> help with memdesc (aka project folio) conversion. There will be way less
> places to audit to see if the user was actually using struct page.
> 
> Also in git:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/rdma

Will you also change get_zeroed_page() in RDMA, or should I
prepare a patch?

Thanks

> 
> [1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
> [2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/ 
> 
> ---
> v2 changes:
> * add comment to keep markers for sites that need "fast and as large as
>   possible" allocation helper
> 
> v1: https://patch.msgid.link/20260630-b4-rdma-v1-0-ab42bcf0de92@kernel.org
> 
> ---
> Mike Rapoport (Microsoft) (5):
>       RDMA/umem: ib_umem_get(): use kmalloc() to allocate page array
>       RDMA/mlx5: replace __get_free_page() with kmalloc()
>       IB/mthca: mthca_reg_user_mr(): use kmalloc() to allocate addresses array
>       IB/mthca: allocate mthca_array memory with kzalloc()
>       IB/rdmavt: use kzalloc() to allocate QPN-map pages
> 
>  drivers/infiniband/core/umem.c                | 5 +++--
>  drivers/infiniband/hw/mlx5/odp.c              | 6 ++++--
>  drivers/infiniband/hw/mthca/mthca_allocator.c | 6 +++---
>  drivers/infiniband/hw/mthca/mthca_provider.c  | 5 +++--
>  drivers/infiniband/sw/rdmavt/qp.c             | 8 ++++----
>  5 files changed, 17 insertions(+), 13 deletions(-)
> ---
> base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
> change-id: 20260610-b4-rdma-44625922fe16
> 
> --
> Sincerely yours,
> Mike.
> 

