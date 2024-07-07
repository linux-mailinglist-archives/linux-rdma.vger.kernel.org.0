Return-Path: <linux-rdma+bounces-3692-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C39F9297A0
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 13:31:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF75C281739
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Jul 2024 11:31:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D0111AACA;
	Sun,  7 Jul 2024 11:31:11 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 323376FBE
	for <linux-rdma@vger.kernel.org>; Sun,  7 Jul 2024 11:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720351871; cv=none; b=Kdxa0SZok2acN8hVAi1J/M4JvUgcfoJIhnzJjoW5ABGGqaCC1KbfVw2I8RKq48S5azqAQaBae1q6YI/s4ifYwiwy76v2SqwSoU1swxCAVeMpzjUPP2VZ6FqoxN1Dx9Fiyndqcy1TBrLwsPRA6DVFbTPSM2styiFCm4Hyec2/Sd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720351871; c=relaxed/simple;
	bh=w8bEWVxkq5PrSjvIwXeOMay/T22y98v3pTVhXXvO6IQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2smnxBnlG008lKhA2UtwN2b+tvSTsV4t+OmnmxR3Iblb5Hft9RsQnT/e3IjsZy+69Lm//t40Ccwb/zkQcXK7hp1hxxvNVri1A9ONc8Ii4Q+jTW3FtwwtPuPKkLTaXGSz2vTyEssWKGT+YdF+fYE1OB4gUgQTYDFIKhhej3zx6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 7723868BEB; Sun,  7 Jul 2024 13:31:03 +0200 (CEST)
Date: Sun, 7 Jul 2024 13:31:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Leon Romanovsky <leon@kernel.org>
Cc: Anumula Murali Mohan Reddy <anumula@chelsio.com>, jgg@nvidia.com,
	linux-rdma@vger.kernel.org,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Christoph Hellwig <hch@lst.de>, Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH for-next] RDMA/cxgb4: use dma_mmap_coherent() for
 mapping non-contiguous memory
Message-ID: <20240707113103.GA4441@lst.de>
References: <20240705131753.15550-1-anumula@chelsio.com> <20240707091105.GG6695@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240707091105.GG6695@unreal>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Jul 07, 2024 at 12:11:05PM +0300, Leon Romanovsky wrote:
> On Fri, Jul 05, 2024 at 06:47:53PM +0530, Anumula Murali Mohan Reddy wrote:
> > dma_alloc_coherent() allocates contiguous memory irrespective of
> > iommu mode, but after commit f5ff79fddf0e ("dma-mapping: remove
> > CONFIG_DMA_REMAP") if iommu is enabled in translate mode,
> > dma_alloc_coherent() may allocate non-contiguous memory.
> > Attempt to map this memory results in panic.
> > This patch fixes the issue by using dma_mmap_coherent() to map each page
> > to user space.
> 
> It is perfect time to move to use rdma_user_mmap_io(), instead of
> open-code it in the driver.

rdma_user_mmap_io does not work on dma coherent allocations.

> > Fixes: f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP")
> 
> + authors of the commit mentioned in Fixes.

If that commit triggered a bug for you it was buggy before, you
just didn't hit it.  The fixes tag needs to point to the commit
assuming trying to convert the return value from dma_alloc* into
a page/pfn/physical address.

> > +++ b/drivers/infiniband/hw/cxgb4/cq.c
> > @@ -1127,12 +1127,16 @@ int c4iw_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
> >  
> >  		mm->key = uresp.key;
> >  		mm->addr = virt_to_phys(chp->cq.queue);

... aka this one.  And it still is buggy and needs to go away.

> > +		if (vaddr && is_vmalloc_addr(vaddr)) {

And this check is broken.  The virtual address returned from
dma_alloc_coherent can also be other things than a vmalloc address.

>
>
> > +			vm_pgoff = vma->vm_pgoff;
> > +			vma->vm_pgoff = 0;
> > +			ret = dma_mmap_coherent(&rdev->lldi.pdev->dev, vma,
> > +						vaddr, dma_addr, size);
> > +			vma->vm_pgoff = vm_pgoff;

... and you thus must use this path unconditionally.

Same for the other hunks.


