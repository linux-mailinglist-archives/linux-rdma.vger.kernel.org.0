Return-Path: <linux-rdma+bounces-9919-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1198AA032B
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 08:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E3993A919C
	for <lists+linux-rdma@lfdr.de>; Tue, 29 Apr 2025 06:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E67C8289364;
	Tue, 29 Apr 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTGc5PsS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D930276046;
	Tue, 29 Apr 2025 06:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745907534; cv=none; b=MoisXsWJm788O/KUFOo10kvuHfeox3wN4gE4FiirGHOFA7uaqAnfT6SCQwKurb+D1LbIBqGcoaGFdqmOCou+oDBkQ9VQNz+iwXPFYrp7nHDhNOymWARq5aXnw42DrVyQYc8cV1KxsksOtYOcgRBAL9LGB3sej6etg6SJoPlFdAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745907534; c=relaxed/simple;
	bh=vExQvIRKgBFgSfzxHEyrFALVuzPRUmMmvaWq9RovN60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l1oTR+Lk3dcq0scby1EjfHnjtlDQ23cXHbvslB9GuJDHp11E8eh13kQ1vK81UTit35v4zIqRHl5r+3tcEmJsjAgyL52rEkZ82dxHIB42ZVpsQEX5A9q+VpcbNDuGavsoP9AaKsuBY2oFF1oHpQgj5tYhJ2LGgXDVyS683XjNXPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTGc5PsS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F91C4CEE3;
	Tue, 29 Apr 2025 06:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745907533;
	bh=vExQvIRKgBFgSfzxHEyrFALVuzPRUmMmvaWq9RovN60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kTGc5PsSm7YoP9EmrE3/tfdAeh2ilrH28OMMhkA1i7TaGCseb+D12f8U4iRskFrE0
	 RSM+Ykr/eeWEOV3E2nvuETPKv5WgV2r3K5S0fSLkCufCBscRZZxm5uTAwOKKZQ34F/
	 w5YLetGv0DGVj4FS79jc9/KMtke5/3tgrMHoSQ+QeJcqJgLI/MgFlbbaDFejjar1j7
	 p+0iatgN6tx2738QkPeIAJSzLkpoG/pCdY9ka1HCzAgLK31eNn58UEn17swH4oZLFI
	 lBdvSt34FC1+vbqL/TFGUu3Gtp8x21gTZM2GnLCqybPJvtISk7Z3RIRONLDJ0zW3JA
	 NWZpkM6/vXKLw==
Date: Tue, 29 Apr 2025 09:18:49 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Jake Edge <jake@lwn.net>,
	Jonathan Corbet <corbet@lwn.net>, Jason Gunthorpe <jgg@ziepe.ca>,
	Zhu Yanjun <zyjzyj2000@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
	iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
	linux-pci@vger.kernel.org, kvm@vger.kernel.org, linux-mm@kvack.org,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Chaitanya Kulkarni <kch@nvidia.com>
Subject: Re: [PATCH v10 06/24] iommu/dma: Factor out a iommu_dma_map_swiotlb
 helper
Message-ID: <20250429061849.GL5848@unreal>
References: <cover.1745831017.git.leon@kernel.org>
 <f9a6a7874760a2919bea1f255bb3c81c6369ed1c.1745831017.git.leon@kernel.org>
 <8416e94f-171e-4956-b8fe-246ed12a2314@linux.intel.com>
 <20250429055339.GJ5848@unreal>
 <9d1abdbc-4b21-47e2-bcaf-6bc8ca365b01@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d1abdbc-4b21-47e2-bcaf-6bc8ca365b01@linux.intel.com>

On Tue, Apr 29, 2025 at 01:58:06PM +0800, Baolu Lu wrote:
> On 4/29/25 13:53, Leon Romanovsky wrote:
> > On Tue, Apr 29, 2025 at 12:58:18PM +0800, Baolu Lu wrote:
> > > On 4/28/25 17:22, Leon Romanovsky wrote:
> > > > From: Christoph Hellwig<hch@lst.de>
> > > > 
> > > > Split the iommu logic from iommu_dma_map_page into a separate helper.
> > > > This not only keeps the code neatly separated, but will also allow for
> > > > reuse in another caller.
> > > > 
> > > > Signed-off-by: Christoph Hellwig<hch@lst.de>
> > > > Tested-by: Jens Axboe<axboe@kernel.dk>
> > > > Reviewed-by: Luis Chamberlain<mcgrof@kernel.org>
> > > > Signed-off-by: Leon Romanovsky<leonro@nvidia.com>
> > > 
> > > Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> > > 
> > > with a nit below ...
> > > 
> > > > ---
> > > >    drivers/iommu/dma-iommu.c | 73 ++++++++++++++++++++++-----------------
> > > >    1 file changed, 41 insertions(+), 32 deletions(-)
> > > > 
> > > > diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
> > > > index d3211a8d755e..d7684024c439 100644
> > > > --- a/drivers/iommu/dma-iommu.c
> > > > +++ b/drivers/iommu/dma-iommu.c
> > > > @@ -1138,6 +1138,43 @@ void iommu_dma_sync_sg_for_device(struct device *dev, struct scatterlist *sgl,
> > > >    			arch_sync_dma_for_device(sg_phys(sg), sg->length, dir);
> > > >    }
> > > > +static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t phys,
> > > > +		size_t size, enum dma_data_direction dir, unsigned long attrs)
> > > > +{
> > > > +	struct iommu_domain *domain = iommu_get_dma_domain(dev);
> > > > +	struct iova_domain *iovad = &domain->iova_cookie->iovad;
> > > > +
> > > > +	if (!is_swiotlb_active(dev)) {
> > > > +		dev_warn_once(dev, "DMA bounce buffers are inactive, unable to map unaligned transaction.\n");
> > > > +		return (phys_addr_t)DMA_MAPPING_ERROR;
> > > > +	}
> > > > +
> > > > +	trace_swiotlb_bounced(dev, phys, size);
> > > > +
> > > > +	phys = swiotlb_tbl_map_single(dev, phys, size, iova_mask(iovad), dir,
> > > > +			attrs);
> > > > +
> > > > +	/*
> > > > +	 * Untrusted devices should not see padding areas with random leftover
> > > > +	 * kernel data, so zero the pre- and post-padding.
> > > > +	 * swiotlb_tbl_map_single() has initialized the bounce buffer proper to
> > > > +	 * the contents of the original memory buffer.
> > > > +	 */
> > > > +	if (phys != (phys_addr_t)DMA_MAPPING_ERROR && dev_is_untrusted(dev)) {
> > > > +		size_t start, virt = (size_t)phys_to_virt(phys);
> > > > +
> > > > +		/* Pre-padding */
> > > > +		start = iova_align_down(iovad, virt);
> > > > +		memset((void *)start, 0, virt - start);
> > > > +
> > > > +		/* Post-padding */
> > > > +		start = virt + size;
> > > > +		memset((void *)start, 0, iova_align(iovad, start) - start);
> > > > +	}
> > > > +
> > > > +	return phys;
> > > > +}
> > > > +
> > > >    dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> > > >    	      unsigned long offset, size_t size, enum dma_data_direction dir,
> > > >    	      unsigned long attrs)
> > > > @@ -1151,42 +1188,14 @@ dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> > > >    	dma_addr_t iova, dma_mask = dma_get_mask(dev);
> > > >    	/*
> > > > -	 * If both the physical buffer start address and size are
> > > > -	 * page aligned, we don't need to use a bounce page.
> > > > +	 * If both the physical buffer start address and size are page aligned,
> > > > +	 * we don't need to use a bounce page.
> > > >    	 */
> > > >    	if (dev_use_swiotlb(dev, size, dir) &&
> > > >    	    iova_offset(iovad, phys | size)) {
> > > > -		if (!is_swiotlb_active(dev)) {
> > > 
> > > ... Is it better to move this check into the helper? Simply no-op if a
> > > bounce page is not needed:
> > > 
> > > 	if (!dev_use_swiotlb(dev, size, dir) ||
> > > 	    !iova_offset(iovad, phys | size))
> > > 		return phys;
> > 
> > Am I missing something? iommu_dma_map_page() has more code after this
> > check, so it is not correct to return immediately:
> > 
> >    1189 dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> >    1190               unsigned long offset, size_t size, enum dma_data_direction dir,
> >    1191               unsigned long attrs)
> >    1192 {
> > 
> > <...>
> > 
> >    1201         /*
> >    1202          * If both the physical buffer start address and size are page aligned,
> >    1203          * we don't need to use a bounce page.
> >    1204          */
> >    1205         if (dev_use_swiotlb(dev, size, dir) &&
> >    1206             iova_unaligned(iovad, phys, size)) {
> >    1207                 phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);
> >    1208                 if (phys == (phys_addr_t)DMA_MAPPING_ERROR)
> >    1209                         return DMA_MAPPING_ERROR;
> >    1210         }
> >    1211
> >    1212         if (!coherent && !(attrs & DMA_ATTR_SKIP_CPU_SYNC))
> >    1213                 arch_sync_dma_for_device(phys, size, dir);
> >    1214
> >    1215         iova = __iommu_dma_map(dev, phys, size, prot, dma_mask);
> >    1216         if (iova == DMA_MAPPING_ERROR)
> >    1217                 swiotlb_tbl_unmap_single(dev, phys, size, dir, attrs);
> >    1218         return iova;
> >    1219 }
> 
> static phys_addr_t iommu_dma_map_swiotlb(struct device *dev, phys_addr_t
> phys,
> 		size_t size, enum dma_data_direction dir, unsigned long attrs)
> {
> <...>
> 	/*
> 	 * If both the physical buffer start address and size are page aligned,
> 	 * we don't need to use a bounce page.
> 	 */
> 	if (!dev_use_swiotlb(dev, size, dir) ||
> 	    !iova_offset(iovad, phys | size))
> 		return phys;
> <...>
> }
> 
> Then,
> 
> dma_addr_t iommu_dma_map_page(struct device *dev, struct page *page,
> 	unsigned long offset, size_t size, enum dma_data_direction dir,
> 	unsigned long attrs)
> {
> <...>
> 	phys = iommu_dma_map_swiotlb(dev, phys, size, dir, attrs);
> 	if (phys == (phys_addr_t)DMA_MAPPING_ERROR)
> 		return DMA_MAPPING_ERROR;
> <...>
> }

Such change will cause to extra function call for everyone who doesn't
use SWIOTLB (RDMA, HMM e.t.c).

In addition, iommu_dma_map_swiotlb() is called through
dma_iova_link -> 
	iommu_dma_iova_link_swiotlb -> 
		iommu_dma_iova_bounce_and_link() -> 
			iommu_dma_map_swiotlb()
and dma_iova_link() has this "if (dev_use_swiotlb(dev, size, dir) && iova_unaligned(iovad, phys, size))"
very early at call stack.

So, in dma_iova_link() we will find ourselves with same check twice.

Thanks

> 
> Thanks,
> baolu
> 

