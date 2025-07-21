Return-Path: <linux-rdma+bounces-12369-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9611BB0C516
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 15:23:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B14823B79A7
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Jul 2025 13:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA692D8767;
	Mon, 21 Jul 2025 13:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T3eT+XSs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18D829E118;
	Mon, 21 Jul 2025 13:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753104207; cv=none; b=rbtiaM+xw+KanNAq15SSSX1r2huYcPUyHdHgCt7NwqoInfygLAbT+tcD923APpllikUIDSFLE8pHKAxxJQkyOFmcBdKYM2PIcjMehFa6rGZbqgjY25rUhR79trvriOptddco8qg/blntriG+9l/MpLtAWp5Qk2BFF2gHzudiyHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753104207; c=relaxed/simple;
	bh=owv97BZV9UmEKfh3hGiomBUmsYTO6yyYbzIdUmq8zts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcx/j2KahsgJQcUo4R5a6+Xjq2v1a03Xx0LleufaiOzBH/U5S2MonFxp/UN0DvXTgIKQidgxzEuugs80sR/yPzbrDDmY+k0MPwei2ykKsYv3JsNDx30W5+goHJzAxVHVXih0+GqqUltzaRJdgQPIhyLgRLaiIklP5JxSUZOgiU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T3eT+XSs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6M2lfrqiVCmiF0Wc9FAkpPta+B8beY73GHDzTT0mJuM=; b=T3eT+XSsrzwbV1XqZcbUbrh7LZ
	H776ohxzo3FqBHlR9iUOMKsWSekI3pZ2M4Q7fI3qVGcz8XFiL3A0Yco+hW77J4VJd3rKMznaLp8yp
	MhkgVuYw+ssT8lWfZ9qJ5xN1I2wjh7NvJujhQpqfQm5ICcjwsvs0nSZJrBnvpAO6PuAGQZcA87TEN
	UPVibCOP1YOVHX5l2Zwpe0VC6AATkYZ4hZKzd70J5wAi2Nm0jXmh5tW/s8Uk1NdxUopZSV1scRPsx
	g0lzFIdaw3LFkEtZ3C62ZL7TK8ZXrnvYG7yTpAuzxv+1TZqlQkkSpJdv1B8ROa/69QRxMtWJapMgs
	ky127NWw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udqU5-0000000D9wk-1SEe;
	Mon, 21 Jul 2025 13:23:13 +0000
Date: Mon, 21 Jul 2025 14:23:13 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Yonatan Maman <ymaman@nvidia.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Leon Romanovsky <leon@kernel.org>, Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alistair Popple <apopple@nvidia.com>,
	Ben Skeggs <bskeggs@nvidia.com>,
	Michael Guralnik <michaelgur@nvidia.com>,
	Or Har-Toov <ohartoov@nvidia.com>,
	Daisuke Matsuda <dskmtsd@gmail.com>, Shay Drory <shayd@nvidia.com>,
	linux-mm@kvack.org, linux-rdma@vger.kernel.org,
	dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, Gal Shalom <GalShalom@nvidia.com>
Subject: Re: [PATCH v2 1/5] mm/hmm: HMM API to enable P2P DMA for device
 private pages
Message-ID: <aH4_QaNtIJMrPqOw@casper.infradead.org>
References: <20250718115112.3881129-1-ymaman@nvidia.com>
 <20250718115112.3881129-2-ymaman@nvidia.com>
 <aHpXXKTaqp8FUhmq@casper.infradead.org>
 <20250718144442.GG2206214@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718144442.GG2206214@ziepe.ca>

On Fri, Jul 18, 2025 at 11:44:42AM -0300, Jason Gunthorpe wrote:
> On Fri, Jul 18, 2025 at 03:17:00PM +0100, Matthew Wilcox wrote:
> > On Fri, Jul 18, 2025 at 02:51:08PM +0300, Yonatan Maman wrote:
> > > +++ b/include/linux/memremap.h
> > > @@ -89,6 +89,14 @@ struct dev_pagemap_ops {
> > >  	 */
> > >  	vm_fault_t (*migrate_to_ram)(struct vm_fault *vmf);
> > >  
> > > +	/*
> > > +	 * Used for private (un-addressable) device memory only. Return a
> > > +	 * corresponding PFN for a page that can be mapped to device
> > > +	 * (e.g using dma_map_page)
> > > +	 */
> > > +	int (*get_dma_pfn_for_device)(struct page *private_page,
> > > +				      unsigned long *dma_pfn);
> > 
> > This makes no sense.  If a page is addressable then it has a PFN.
> > If a page is not addressable then it doesn't have a PFN.
> 
> The DEVICE_PRIVATE pages have a PFN, but it is not usable for
> anything.

OK, then I don't understand what DEVICE PRIVATE means.

I thought it was for memory on a PCIe device that isn't even visible
through a BAR and so the CPU has no way of addressing it directly.
But now you say that it has a PFN, which means it has a physical
address, which means it's accessible to the CPU.

So what is it?

> This is effectively converting from a DEVICE_PRIVATE page to an actual
> DMA'able address of some kind. The DEVICE_PRIVATE is just a non-usable
> proxy, like a swap entry, for where the real data is sitting.
> 
> Jason
> 

