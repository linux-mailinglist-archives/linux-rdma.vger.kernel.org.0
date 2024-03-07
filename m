Return-Path: <linux-rdma+bounces-1305-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56C88744DA
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 01:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D95941C2159F
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 00:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534F1C2A1;
	Thu,  7 Mar 2024 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="NsZTbDch"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316F8F4F5
	for <linux-rdma@vger.kernel.org>; Thu,  7 Mar 2024 00:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709769643; cv=none; b=pa5Ipxh09srNYCeSaIqFHmkospspBEmc/G4pqfsIlqxmbVcqXj6DTnFpXrDJP28gwXUG94F8lGGw0DJ18jvjy42JBj5ehTUmZaa1yL+4IYgYS1mCIMudjVvuNoY5M1e3cgZuc9rvyOSB3s4JHmFea2wLcI+EcPr4xh7vhuCiU7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709769643; c=relaxed/simple;
	bh=T+UOSxEPBysqG32w+zMGX5xyeXuEl5alWxX1qNj0v48=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lr4qMyjF7FdwZUWm2C4f15SIgzY+CdbCBPX49gq5ZBQxzT9iKAJzIfwRTadYtEXrz7rjau//bTIFSgjbuZO8M5KS2GLoubxGIyjk8rda6+Yi87N+TN6ScRNBu3nZPxJ6EQ17gc03MTCoW84jmp3AiStg+4i5KOYFgmLOTXZirAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=NsZTbDch; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-22157b09a17so100494fac.1
        for <linux-rdma@vger.kernel.org>; Wed, 06 Mar 2024 16:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1709769640; x=1710374440; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FnAsXY5W3o0aBO5Fh+OdY1VF737kiERo49tIrv2JTH0=;
        b=NsZTbDch8wC6sasBCF6lPZ5a9uT85angZHr+9Fcg2WcIONOFUVqCOhLdLXs1QMz7CF
         fE5abEuJwtMVWXIfwbGl6sLJjYaFCJE/RHiji6HDc612aQrRPtubOqHJ7+VeQTqhcdMG
         olSzIPq/N6AveQDAZuE01G3P+jyn7GhvgYbEKBeOxD4nGA4Lo8n2G5SEEuvQQrwsK+pB
         +71SwuD5SBmh4/TyqxZtgqyAYXS57Sz6JcJo+8l8v/ImU14NhWejMKtIJyueTeVb/daB
         zwI/wp35dllpF/towcyd3qY1dKGx/hmqbLTOV33lwt/HV6/b2XtymYBw35wcpFsxxWM2
         enhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709769640; x=1710374440;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FnAsXY5W3o0aBO5Fh+OdY1VF737kiERo49tIrv2JTH0=;
        b=L4WQmnPBehqWvynl94GhtwcAj0NVj7H7BhDK7ddoLQ9n8ldT1w8vC5qKI7CtdbT+jb
         JBnyylk+o8/r4VV4ZMwYpxrnjsoqiWi0dTnZiVt0OZknqTvxAvu3mM+5ZPFxlZnC/R4u
         NNNMg9qcX871TwPQ+kEimZra71HnViTYzX+O2r3rv+iSFcygEgy23ybAeO3kT+vGrBTv
         ourgD8ZU++Nl/5uxTUDyh4mqHp9WB77nZOZDlOskrDY+JDp00p/fF8oDqfWn0cgjW5dx
         dBITs4IPv+BygoTcinEBScb135QzW2LXF51mo5knFdBmj437WHzqcwVk73g3Xf+cDrd8
         rsZw==
X-Forwarded-Encrypted: i=1; AJvYcCVB9P/qfsbHH3NP/CRDxpuxaLg8xcPZTOIrRsP7UqftilaowVCSCEl4AKP+jnfBuef7hvhPDDcznyiOMTwH39nEXnBHP5QA0jrclg==
X-Gm-Message-State: AOJu0YxNAUrsQACnwa+03kSUgJqNpTC7agClktIpm4CkO4gGFf8Cfljc
	Ic2ANg5oksdhKH63WOss3TmwVa7NT4gE7aIjDk/VYM4k0NKooVVvaj4RPabTn4M=
X-Google-Smtp-Source: AGHT+IGK0xl48nl3utXsBsT9cDlUym3mZ050RInjod+5qLAgYBHQgf3Jm+BxBWeRpDZbnqg1tP4wIQ==
X-Received: by 2002:a05:6871:28e:b0:21e:dd7a:2d3e with SMTP id i14-20020a056871028e00b0021edd7a2d3emr6947112oae.22.1709769640012;
        Wed, 06 Mar 2024 16:00:40 -0800 (PST)
Received: from ziepe.ca ([12.97.180.36])
        by smtp.gmail.com with ESMTPSA id vz3-20020a056871a40300b00220c6f7734esm2827969oab.35.2024.03.06.16.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 16:00:39 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1ri1Bc-002SqN-Sb;
	Wed, 06 Mar 2024 20:00:36 -0400
Date: Wed, 6 Mar 2024 20:00:36 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christoph Hellwig <hch@lst.de>
Cc: Leon Romanovsky <leon@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	kvm@vger.kernel.org, linux-mm@kvack.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	Dan Williams <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240307000036.GP9225@ziepe.ca>
References: <cover.1709635535.git.leon@kernel.org>
 <47afacda-3023-4eb7-b227-5f725c3187c2@arm.com>
 <20240305122935.GB36868@unreal>
 <20240306144416.GB19711@lst.de>
 <20240306154328.GM9225@ziepe.ca>
 <20240306162022.GB28427@lst.de>
 <20240306174456.GO9225@ziepe.ca>
 <20240306221400.GA8663@lst.de>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240306221400.GA8663@lst.de>

On Wed, Mar 06, 2024 at 11:14:00PM +0100, Christoph Hellwig wrote:
> On Wed, Mar 06, 2024 at 01:44:56PM -0400, Jason Gunthorpe wrote:
> > There is a list of interesting cases this has to cover:
> > 
> >  1. Direct map. No dma_addr_t at unmap, multiple HW SGLs
> >  2. IOMMU aligned map, no P2P. Only IOVA range at unmap, single HW SGLs
> >  3. IOMMU aligned map, P2P. Only IOVA range at unmap, multiple HW SGLs
> >  4. swiotlb single range. Only IOVA range at unmap, single HW SGL
> >  5. swiotlb multi-range. All dma_addr_t's at unmap, multiple HW SGLs.
> >  6. Unaligned IOMMU. Only IOVA range at unmap, multiple HW SGLs
> > 
> > I think we agree that 1 and 2 should be optimized highly as they are
> > the common case. That mainly means no dma_addr_t storage in either
> 
> I don't think you can do without dma_addr_t storage.  In most cases
> your can just store the dma_addr_t in the LE/BE encoded hardware
> SGL, so no extra storage should be needed though.

RDMA (and often DRM too) generally doesn't work like that, the driver
copies the page table into the device and then the only reason to have
a dma_addr_t storage is to pass that to the dma unmap API. Optionally
eliminating long term dma_addr_t storage would be a worthwhile memory
savings for large long lived user space memory registrations.

> > 3 is quite similar to 1, but it has the IOVA range at unmap.
> 
> Can you explain what P2P case you mean?  The switch one with the
> bus address is indeed basically the same, just with potentioally a
> different offset, while the through host bridge case is the same
> as a normal iommu map.

Yes, the bus address case. The IOMMU is turned on, ACS on a local
switch is off.

All pages go through the IOMMU in the normal way except P2P pages
between devices on the same switch. (ie the dma_addr_t is CPU physical
of the P2P plus an offset). RDMA must support a mixture of IOVA and
P2P addresses in the same IO operation.

I suppose it would make more sense to say it is similar to 6.

> > 5 is the slowest and has the most overhead.
> 
> and 5 could be broken into multiple 4s at least for now.  Or do you
> have a different dfinition of range here?

I wrote the list as from a single IO operation perspective, so all but
5 need to store a single IOVA range that could be stored in some
simple non-dynamic memory along with whatever HW SGLs/etc are needed.

The point of 5 being different is because the driver has to provide a
dynamically sized list of dma_addr_t's as storage until unmap. 5 is
the only case that requires that full list.

So yes, 5 could be broken up into multiple IOs, but then the
specialness of 5 is the driver must keep track of multiple IOs..

> > So are you thinking something more like a driver flow of:
> > 
> >   .. extent IO and get # aligned pages and know if there is P2P ..
> >   dma_init_io(state, num_pages, p2p_flag)
> >   if (dma_io_single_range(state)) {
> >        // #2, #4
> >        for each io()
> > 	    dma_link_aligned_pages(state, io range)
> >        hw_sgl = (state->iova, state->len)
> >   } else {
> 
> I think what you have a dma_io_single_range should become before
> the dma_init_io.  If we know we can't coalesce it really just is a
> dma_map_{single,page,bvec} loop, no need for any extra state.

I imagine dma_io_single_range() to just check a flag in state.

I still want to call dma_init_io() for the non-coalescing cases
because all the flows, regardless of composition, should be about as
fast as dma_map_sg is today.

That means we need to always pre-allocate the IOVA in any case where
the IOMMU might be active - even on a non-coalescing flow.

IOW, dma_init_io() always pre-allocates IOVA if the iommu is going to
be used and we can't just call today's dma_map_page() in a loop on the
non-coalescing side and pay the overhead of Nx IOVA allocations.

In large part this is for RDMA, were a single P2P page in a large
multi-gigabyte user memory registration shouldn't drastically harm the
registration performance by falling down to doing dma_map_page, and an
IOVA allocation, on a 4k page by page basis.

The other thing that got hand waved here is how does dma_init_io()
know which of the 6 states we are looking at? I imagine we probably
want to do something like:

   struct dma_io_summarize summary = {};
   for each io()
        dma_io_summarize_range(&summary, io range)
   dma_init_io(dev, &state, &summary);
   if (state->single_range) {
   } else {
   }
   dma_io_done_mapping(&state); <-- flush IOTLB once

At least this way the DMA API still has some decent opportunity for
abstraction and future growth using state to pass bits of information
between the API family.

There is some swiotlb complexity that needs something like this, a
system with iommu can still fail to coalesce if the pages are
encrypted and the device doesn't support DMA from encrypted pages. We
need to check for P2P pages, encrypted memory pages, and who knows
what else.

> And we're back to roughly the proposal I sent out years ago.

Well, all of this is roughly your original proposal, just with
different optimization choices and some enhancement to also cover
hmm_range_fault() users.

Enhancing the single sgl case is not a big change, I think. It does
seem simplifying for the driver to not have to coalesce SGLs to detect
the single-SGL fast-path.

> > This is not quite what you said, we split the driver flow based on
> > needing 1 HW SGL vs need many HW SGL.
> 
> That's at least what I intended to say, and I'm a little curious as what
> it came across.

Ok, I was reading the discussion more about as alignment than single
HW SGL, I think you ment alignment as implying coalescing behavior
implying single HW SGL..

Jason

