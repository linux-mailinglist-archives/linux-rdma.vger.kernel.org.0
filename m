Return-Path: <linux-rdma+bounces-10682-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086B1AC33D6
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 12:25:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8FA816CF52
	for <lists+linux-rdma@lfdr.de>; Sun, 25 May 2025 10:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884C81EFF80;
	Sun, 25 May 2025 10:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmZ17vt+"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43BB64A28;
	Sun, 25 May 2025 10:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748168701; cv=none; b=MAqqpLS3CnQDV22ZjsnJWhrr4mO9G2ivNgYDb8oXBDxpOO8ULMIITJS5eBDTPTK3EEs3GrgBLaKrQk0wjaBe83YSvdvAunR5ORZ1BgCwKf4B7NRQjD8ge39EZEphwMMe8MFLAo4rkzOQafF009pvTTra34P10QRqgoMHkgaGbVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748168701; c=relaxed/simple;
	bh=14q94SM2llMUhp/EjDnyIULov7yuZCABk//l6xQ5x0A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M9aeI4RhE/pk7L6DcUSQ9CB2v8pL8TzP2M4Ksa/VZTBMYCYn90yZb4wUhtqxN2L+3XJz+cx8PGnI2g0fo6F1EKb4MO2WlEs8phgSeoDaEjMx0R0NnCymbileKF7iGD8saSvHM5oNTVcMLFixqJ/cI/GjK+fDovsKdvKhexiRuw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmZ17vt+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45485C4CEEA;
	Sun, 25 May 2025 10:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748168700;
	bh=14q94SM2llMUhp/EjDnyIULov7yuZCABk//l6xQ5x0A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmZ17vt+rulDWuGUTTzT1RoHkvIy1R/NkykoQ4ex+9kW7/d/9odmJMkZmuM51ZyXE
	 EmMNeVIqa4fpHWKJVyZGXqbr4dY+L0SdDwg3ugncJaXmVbZqMEqVTnx2iq9STBUncn
	 zIBEBQZvHkF6oa++4gM5ovasdKIRYEGgobkDag1yOk8GoV2iWmuy4saw3W6vhtyahL
	 VXz4pKAflUxb2C3ETZhvF45oWwBur9KS2nUYJ+FF3d6ypQVfpZR0ID1CO+MCizQXSF
	 k2tl4hBkjBNv+8/MEqJ8GjbFLAQB/mPEcvOKQBf63wkMP0qycraTIGUepiKgCOq+ln
	 HfTRzJQV/Le4g==
Date: Sun, 25 May 2025 13:24:56 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Daisuke Matsuda <dskmtsd@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, jgg@ziepe.ca,
	zyjzyj2000@gmail.com, hch@infradead.org
Subject: Re: [PATCH for-next v3] RDMA/core: Avoid hmm_dma_map_alloc() for
 virtual DMA devices
Message-ID: <20250525102456.GX7435@unreal>
References: <20250524144328.4361-1-dskmtsd@gmail.com>
 <20250525070806.GW7435@unreal>
 <77ba8709-9b59-4c83-8898-6f0c699992c3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77ba8709-9b59-4c83-8898-6f0c699992c3@gmail.com>

On Sun, May 25, 2025 at 06:34:56PM +0900, Daisuke Matsuda wrote:
> Hi Leon,
> 
> Thank you for amending the patch.
> I've run the test and confirmed that the bug has been resolved.
> 
> We still have two build errors. Please see my reply below.
> 
> On 2025/05/25 16:08, Leon Romanovsky wrote:
> > On Sat, May 24, 2025 at 02:43:28PM +0000, Daisuke Matsuda wrote:
> <...>
> > >   drivers/infiniband/core/device.c   | 17 +++++++++++++++++
> > >   drivers/infiniband/core/umem_odp.c | 11 ++++++++---
> > >   include/rdma/ib_verbs.h            |  4 ++++
> > >   3 files changed, 29 insertions(+), 3 deletions(-)
> > 
> > Please include changelogs when you submit vX patches next time.
> 
> Oh, sorry. I will be careful from next time.
> 
> > 
> > I ended with the following patch:
> > 
> > diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> > index 51d518989914e..cf16549919e02 100644
> > --- a/drivers/infiniband/core/umem_odp.c
> > +++ b/drivers/infiniband/core/umem_odp.c
> > @@ -60,9 +60,11 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
> >   {
> >   	struct ib_device *dev = umem_odp->umem.ibdev;
> >   	size_t page_size = 1UL << umem_odp->page_shift;
> > +	struct hmm_dma_map *map;
> >   	unsigned long start;
> >   	unsigned long end;
> > -	int ret;
> > +	size_t nr_entries;
> > +	int ret = 0;
> >   	umem_odp->umem.is_odp = 1;
> >   	mutex_init(&umem_odp->umem_mutex);
> > @@ -75,9 +77,20 @@ static int ib_init_umem_odp(struct ib_umem_odp *umem_odp,
> >   	if (unlikely(end < page_size))
> >   		return -EOVERFLOW;
> > -	ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
> > -				(end - start) >> PAGE_SHIFT,
> > -				1 << umem_odp->page_shift);
> > +	nr_entries = (end - start) >> PAGE_SHIFT;
> > +	if (!(nr_entries * PAGE_SIZE / page_size))
> > +		return -EINVAL;
> > +
> > +	nap = &umem_odp->map;
> 
> BUILD ERROR: 'nap' should be 'map'

Sorry, I pushed the code too fast.

> 
> > +	if (ib_uses_virt_dma(dev)) {
> > +		map->pfn_list = kvcalloc(nr_entries, sizeof(*map->pfn_list),
> > +					 GFP_KERNEL | __GFP_NOWARN);
> > +		if (!map->pfn_list)
> > +			ret = -ENOMEM;
> > +	} else
> > +		ret = hmm_dma_map_alloc(dev->dma_device, &umem_odp->map,
> 
> OPTIONAL: Perhaps we can just pass 'map' for the 2nd arg?


<...>

> > +		hmm_dma_map_free(dev->dma_device, &umem_odp->map);
> 
> OPTIONAL: Here too.

Sure, will change.

> 
> >   	return ret;
> >   }
> > @@ -259,7 +275,10 @@ static void ib_umem_odp_free(struct ib_umem_odp *umem_odp)
> >   				    ib_umem_end(umem_odp));
> >   	mutex_unlock(&umem_odp->umem_mutex);
> >   	mmu_interval_notifier_remove(&umem_odp->notifier);
> > -	hmm_dma_map_free(dev->dma_device, &umem_odp->map);
> > +	if (ib_uses_virt_dma(dev))
> > +		kfree(umem_odp->map->pfn_list);
> 
> BUILD ERROR:     'umem_odp->map.pfn_list' is correct.

Sorry about that too.

> 
> Thanks again,
> Daisuke
> 
> 

