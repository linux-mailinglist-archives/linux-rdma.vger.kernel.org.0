Return-Path: <linux-rdma+bounces-3758-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A8092AFE6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 08:17:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F19E328234F
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Jul 2024 06:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D622912FB37;
	Tue,  9 Jul 2024 06:17:28 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A83F823CB;
	Tue,  9 Jul 2024 06:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720505848; cv=none; b=kVxmIN1sG5hZWavTEHSxnC+/JiHAJBMfP6VlJm/Fo5xhsFvXxnSBhjAX0hc1Iyco2VFKCgsyXLcGqzZgHjSRShNKCte2LXuDEpkYORBEhqZoyLgIMIxI0cXYzuobS/75TDq+Rl+gr91MzGduDqZx2kgefsr0zE7U5l60AFfKpTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720505848; c=relaxed/simple;
	bh=LpyTG0KfnM7IF4Mu59VZ6DJKNf7qJS9rIcXteLyoEV8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J5OF1Ufx67eo7mjEmfx4Vbmn2Qv5vlvl8cx58ou5E0b2o0rTQ3dtzhIZfkfC6tpxOJ1kra244Ptp/k98JChu4hRtz++JA+tTaeLaH0zclTplRBO5RTLUZo/WhWVwrG7q9JfAHw/EOcY0cLdlzRdjPjpW3i7mIR/ipEuvbEyTLtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 52C0568AFE; Tue,  9 Jul 2024 08:17:21 +0200 (CEST)
Date: Tue, 9 Jul 2024 08:17:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Christoph Hellwig <hch@lst.de>, Leon Romanovsky <leon@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Keith Busch <kbusch@kernel.org>, "Zeng, Oak" <oak.zeng@intel.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	Kevin Tian <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
	kvm@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v1 00/18] Provide a new two step DMA API mapping API
Message-ID: <20240709061721.GA16180@lst.de>
References: <cover.1719909395.git.leon@kernel.org> <20240703054238.GA25366@lst.de> <20240703105253.GA95824@unreal> <20240703143530.GA30857@lst.de> <20240703155114.GB95824@unreal> <20240704074855.GA26913@lst.de> <20240708165238.GE14050@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240708165238.GE14050@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 08, 2024 at 01:52:38PM -0300, Jason Gunthorpe wrote:
> Ideally we'd have some template code that consolidates these loops to
> common code with driver provided hooks - there are a few ways to get
> that efficiently in C.
> 
> I think it will be clearer when we get to RDMA and there we have the
> same SGL/PRP kind of split up and we can see what is sharable.

I really would not want to build common code for PRPs - this is a concept
very specific to RDMA and NVMe.  OTOH more common code SGLs would be
nice.  If you look at e.g. SCSI drivers most of them have a simpe loop of
mapping the SG table and then copying the fields into the hardware SGL.
This would be a very common case for a helper.

That whole thing of course opens the question if we want a pure
in-memory version of the dma_addr_t/len tuple.  IMHO that is the best
way to migrate and allows to share code easily.  We can look into ways
to avoiding that more for drivers that care, but most drivers are
probably best serve with it to keep the code simple and make the
conversion easier.

> I'm also cooking something that should let us build a way to iommu map
> a bio_vec very efficiently, which should transform this into a single
> indirect call into the iommu driver per bio_vec, and a single radix
> walk/etc.

I assume you mean array of bio_vecs here.  That would indeed nice.
We'd still potentially need a few calls for block drivers as
requests can have multiple bios and thus bio_vec arrays, but it would
still be a nice reduction of calls.


