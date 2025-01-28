Return-Path: <linux-rdma+bounces-7269-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC8A20CBF
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 16:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67A817A3F14
	for <lists+linux-rdma@lfdr.de>; Tue, 28 Jan 2025 15:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6341AAE28;
	Tue, 28 Jan 2025 15:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="I7Ec0hbm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600191A304A
	for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2025 15:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738077375; cv=none; b=Ca8SDrFV9XzopZMlLOrUTITdmuIVtnMJ8tubHJyDaQXAgQJNsZ9ur99uXjp53CZm9pzuMawqqI0ecUiqgL2lM7k6O4Sh8k0/qlHSybYc1nF6+llw7iGIhmZ1VJtkn75jAu3eON7L4MRYXvFYTGUm6eJOevkgTGR6OpITf9q5D8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738077375; c=relaxed/simple;
	bh=4ZVOFSAawQAPNqPaIUjGeYS67Fj53STM2tzTLB9iD9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gevTa1I+drWjtOZZpqX4Y+ddio4/4TzJgEbkF/rUF381R60GmX3lQx2bVly/qV07HFEU+O/oRBVgsFgQMBk6zKvL+U7L+SyGhdn8NrKkWDRYWwZItFBkLDrCX/8qwVnwHCRS3Qm9v7uWKpfDJ40vJArQ0roUiR/yOVn734i6xuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=I7Ec0hbm; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-467918c360aso63137241cf.0
        for <linux-rdma@vger.kernel.org>; Tue, 28 Jan 2025 07:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1738077372; x=1738682172; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9asZltzPGSVkB8UT62aMxicpstwn5ZY78K38XF9efC4=;
        b=I7Ec0hbmYzMXZ8jo04bUdwpTL/8c9lApSxVlT7Red9/3rVWVtr32MsKl4+vtlZfUct
         ZHIe6giC8lPpEoQGHGwy1CHz1RLd81SE0zmg77hsdJW9dQOjoyJd0gUXq/GEjU1bPPH8
         VusuXiTSlm4xb0th6khMBGYB6+vEckzlBie60PLz/lUaIXX+F/3G0VTx9ILBlhJ9ejLf
         fl6CYLDwxSTrOZCtSThxxcgMSfIew7Xac3c6Ypcfzg53NmzrHKirPhTzSz8/ck1Kzouv
         A7Cd4Qe0pUrY1AeANUCd7/DPDUMcYaYH1KEhvEOIfc8oUZEtxjCntP2wBBpv1xP7jSzT
         TWBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738077372; x=1738682172;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9asZltzPGSVkB8UT62aMxicpstwn5ZY78K38XF9efC4=;
        b=Gd2PTlHnZdfBui0k0mTJr6PqrbqCfM2zr4oRsmmBdX4sSbPYdRJY373axyiXegHhyL
         o4GmbhAIQnIlzUlV3X92IVZN8ZRGmAZbzJvLU/zRRUmrN10LhFpwJbnfHlVI9ocvydNB
         1S7CKdXUhHalubLJmovFQcISggM13mmkq9TlhiE+RoFPUU1/00WqbzMIhvlCRRTePK/X
         tdVsGriymVdNvdY8DUdzueieTg63ozH/DZz5H0of2jbq4DpaxLG6d0c0SaIQQCxTF0gC
         c/Iko3m9st8Qiw5DFUwL4emXh/bOAfxnwGqAoktbcAZPUgMg1Dfa/c7Byr/joeyrNgx5
         MJYA==
X-Forwarded-Encrypted: i=1; AJvYcCXhWzFz9MiNSyh70SR0PqyXwWqQY8/W5rHtudIYIBJ7aIF7ZZ9Yuq4V8Hhn0LKBBL3Zu6Lhs0cZRYNh@vger.kernel.org
X-Gm-Message-State: AOJu0YxPjqwmO4hN0WZqwuiPrsOckl5AC+NpXn1jcZpLCASfW8abzB8i
	i2L8qfGsVvOQhxRrstfrT8v49DwmxYETkRvmQGhOvP4Xph3ivoi8mXWbADszPsA=
X-Gm-Gg: ASbGncuX7IO21ls3sVaj1OtXgs4HdpJ5xweo17gYRzvKBzCrStENF2sEXMfXpJ6/ZDK
	k8CaQqHVzAS419xKgqVWz5cP4h4dRwZkSIn0Fxql13n51jXeXb/QsSfZj02b1BrMu0oed+mgPkD
	RiNZC8m3kt96xsGb7aPaQmpg1KyL7MofJmXJqdH9K4rkghEC27I+VYuFlCOEKhBZVz4Xd+Dney7
	B3eInzieQuoMXxTpfRP3mp5gwVamEoaWeRoJTIsIP0dm/wviU0Sgm1AuqAk79AuqXheaHlJHBX6
	2MU3YGjaqz7gxQurI5G5KDM/VYhPe2hmt4ImEDUGkzbHWt0n1oBk1hHEoxGooD5Q
X-Google-Smtp-Source: AGHT+IGRdYaLk5GMFm39sxxEUnAoVN5fAg2yjnF65TF+ISHX+uAwVSwQhG2SfGCyK/fZcBn4SrAwBQ==
X-Received: by 2002:a05:622a:40f:b0:467:6833:e30c with SMTP id d75a77b69052e-46e12a8affdmr746561081cf.30.1738077372160;
        Tue, 28 Jan 2025 07:16:12 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-128-5.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.128.5])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-46e6687dd65sm51648611cf.18.2025.01.28.07.16.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jan 2025 07:16:11 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1tcnJy-00000007czI-18wL;
	Tue, 28 Jan 2025 11:16:10 -0400
Date: Tue, 28 Jan 2025 11:16:10 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Cc: Yonatan Maman <ymaman@nvidia.com>, kherbst@redhat.com, lyude@redhat.com,
	dakr@redhat.com, airlied@gmail.com, simona@ffwll.ch,
	leon@kernel.org, jglisse@redhat.com, akpm@linux-foundation.org,
	GalShalom@nvidia.com, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-mm@kvack.org,
	linux-tegra@vger.kernel.org
Subject: Re: [RFC 1/5] mm/hmm: HMM API to enable P2P DMA for device private
 pages
Message-ID: <20250128151610.GC1524382@ziepe.ca>
References: <20241201103659.420677-1-ymaman@nvidia.com>
 <20241201103659.420677-2-ymaman@nvidia.com>
 <7282ac68c47886caa2bc2a2813d41a04adf938e1.camel@linux.intel.com>
 <20250128132034.GA1524382@ziepe.ca>
 <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <de293a7e9b4c44eab8792b31a4605cc9e93b2bf5.camel@linux.intel.com>

On Tue, Jan 28, 2025 at 03:48:54PM +0100, Thomas Hellström wrote:
> On Tue, 2025-01-28 at 09:20 -0400, Jason Gunthorpe wrote:
> > On Tue, Jan 28, 2025 at 09:51:52AM +0100, Thomas Hellström wrote:
> > 
> > > How would the pgmap device know whether P2P is actually possible
> > > without knowing the client device, (like calling
> > > pci_p2pdma_distance)
> > > and also if looking into access control, whether it is allowed?
> > 
> > The DMA API will do this, this happens after this patch is put on top
> > of Leon's DMA API patches. The mapping operation will fail and it
> > will
> > likely be fatal to whatever is going on.
> >  
> > get_dma_pfn_for_device() returns a new PFN, but that is not a DMA
> > mapped address, it is just a PFN that has another struct page under
> > it.
> > 
> > There is an implicit assumption here that P2P will work and we don't
> > need a 3rd case to handle non-working P2P..
> 
> OK. We will have the case where we want pfnmaps with driver-private
> fast interconnects to return "interconnect possible, don't migrate"
> whereas possibly other gpus and other devices would return
> "interconnect unsuitable, do migrate", so (as I understand it)
> something requiring a more flexible interface than this.

I'm not sure this doesn't handle that case?

Here we are talking about having DEVICE_PRIVATE struct page
mappings. On a GPU this should represent GPU local memory that is
non-coherent with the CPU, and not mapped into the CPU.

This series supports three case:

 1) pgmap->owner == range->dev_private_owner
    This is "driver private fast interconnect" in this case HMM should
    immediately return the page. The calling driver understands the
    private parts of the pgmap and computes the private interconnect
    address.

    This requires organizing your driver so that all private
    interconnect has the same pgmap->owner.

 2) The page is DEVICE_PRIVATE and get_dma_pfn_for_device() exists.
    The exporting driver has the option to return a P2P struct page
    that can be used for PCI P2P without any migration. In a PCI GPU
    context this means the GPU has mapped its local memory to a PCI
    address. The assumption is that P2P always works and so this
    address can be DMA'd from.

 3) Migrate back to CPU memory - then eveything works.

Is that not enough? Where do you want something different?

> > > but leaves any dma- mapping or pfn mangling to be done after the
> > > call to hmm_range_fault(), since hmm_range_fault() really only
> > > needs
> > > to know whether it has to migrate to system or not.
> > 
> > See above, this is already the case..
> 
> Well what I meant was at hmm_range_fault() time only consider whether
> to migrate or not. Afterwards at dma-mapping time you'd expose the
> alternative pfns that could be used for dma-mapping.

That sounds like you are talking about multipath, we are not really
ready to tackle general multipath yet at the DMA API level, IMHO.

If you are just talking about your private multi-path, then that is
already handled..

> We were actually looking at a solution where the pagemap implements
> something along
> 
> bool devmem_allowed(pagemap, client); //for hmm_range_fault
> 
> plus dma_map() and dma_unmap() methods.

This sounds like dmabuf philosophy, and I don't think we should go in
this direction. The hmm caller should always be responsible for dma
mapping and we need to improve the DMA API to make this work better,
not build side hacks like this.

You can read my feelings and reasoning on this topic within this huge thread:

https://lore.kernel.org/dri-devel/20250108132358.GP5556@nvidia.com/

> In this way you'd don't need to expose special p2p dma pages and the

Removing the "special p2p dma pages" has to be done by improving the
DMA API to understand how to map phsyical addresses without struct
page. We are working toward this, slowly.

pgmap->ops->dma_map/unmap() ideas just repeat the DMABUF mistake
of mis-using the DMA API for P2P cases. Today you cannot correctly DMA
map P2P memory without the struct page.

> interface could also handle driver-private interconnects, where
> dma_maps and dma_unmap() methods become trivial.

We already handle private interconnect.

> > > One benefit of using this alternative
> > > approach is that struct hmm_range can be subclassed by the caller
> > > and
> > > for example cache device pairs for which p2p is allowed.
> > 
> > If you want to directly address P2P non-uniformity I'd rather do it
> > directly in the core code than using a per-driver callback. Every
> > driver needs exactly the same logic for such a case.
> 
> Yeah, and that would look something like the above

No, it would look like the core HMM code calling pci distance on the
P2P page returned from get_dma_pfn_for_device() and if P2P was
impossible then proceed to option #3 fault to CPU.

> although initially we intended to keep these methods in drm
> allocator around its pagemaps, but could of course look into doing
> this directly in dev_pagemap ops.   But still would probably need
> some guidance into what's considered acceptable, and I don't think
> the solution proposed in this patch meets our needs.

I'm still not sure what you are actually trying to achieve?

Jason

