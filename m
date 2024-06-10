Return-Path: <linux-rdma+bounces-3037-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 002D6902674
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 18:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83BBB288961
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2024 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBDE1142E97;
	Mon, 10 Jun 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txBNSTf1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD7C81754;
	Mon, 10 Jun 2024 16:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036311; cv=none; b=Hpx/d+XIxJIJnoHKvEItSCOMNlZgHu+5Bj6VjwGMF6uL22mwQH8m+IxD2USJHuVEm0QRTTsbrFaFiglPVMsDzfzGXDmh9sxAPWdNKlrMnOnDceEFjvgKrV0TNrX9XXRw4xc7nHS0d8OZqsyPwxxo3RIqBMNnM0FG+CTTnqT4MbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036311; c=relaxed/simple;
	bh=uZtlK/h+IV89qKq/D7HEEGiIqU3n+5uR+aMUW6bSTYI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h/X3C/8uf1aNsfF0tFg64gVY3KVSVlLsifbWJkTOcVd5fwa5wPVm4y1M1sZCGz2uF2kvnNj5WlVosE0leE5wtvv2F9ndrHSVUnxQqFHnlXNEGQczE0UXXu4pnPHFeudCIE0LI9es+epw0rhZ9zFMIo1vMNBmlDsncgd7R2xslqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txBNSTf1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270DCC2BBFC;
	Mon, 10 Jun 2024 16:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718036311;
	bh=uZtlK/h+IV89qKq/D7HEEGiIqU3n+5uR+aMUW6bSTYI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txBNSTf1+1t4Xc9gPPh5vQRc5XfFN8nPv3Ro8SB/Yq/j5yEFp8jrN0I+5Vvp5KhOC
	 31eIcQtv4gSFNYkJWu5tiUYcRsGWbQIFh2b2tiBQYfLYxsJieRJiOTdFhWwTvQJF/M
	 fUzjRO+rL2bVJQVsXagyKG+uCYHiF1TBWgw463NfDzmu1rm2XEkNCph2ZdlBvKMPM0
	 Gr/XbPplhRTbNTmuXHWyp/dAQvRpoJf5jrDLG/1hP72FEcChZfoVi0qm5BQFx6ewcw
	 vpY5DbRGJh+Zpb2hIoVs4KxbjfSUVKLSS1z59lmFu0jrgvvdpMja9j94fZRFY7GnNT
	 znfhgKqB0z4zQ==
Date: Mon, 10 Jun 2024 19:18:26 +0300
From: Leon Romanovsky <leon@kernel.org>
To: "Zeng, Oak" <oak.zeng@intel.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Christoph Hellwig <hch@lst.de>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
	Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	"Brost, Matthew" <matthew.brost@intel.com>,
	"Hellstrom, Thomas" <thomas.hellstrom@intel.com>,
	Jonathan Corbet <corbet@lwn.net>, Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Yishai Hadas <yishaih@nvidia.com>,
	Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
	"Tian, Kevin" <kevin.tian@intel.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	=?iso-8859-1?B?Suly9G1l?= Glisse <jglisse@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <damien.lemoal@opensource.wdc.com>,
	Amir Goldstein <amir73il@gmail.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	"daniel@iogearbox.net" <daniel@iogearbox.net>,
	"Williams, Dan J" <dan.j.williams@intel.com>,
	"jack@suse.com" <jack@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	"Bommu, Krishnaiah" <krishnaiah.bommu@intel.com>,
	"Ghimiray, Himal Prasad" <himal.prasad.ghimiray@intel.com>
Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to two steps
Message-ID: <20240610161826.GA4966@unreal>
References: <cover.1709635535.git.leon@kernel.org>
 <SA1PR11MB6991CB2B1398948F4241E51992182@SA1PR11MB6991.namprd11.prod.outlook.com>
 <20240503164239.GB901876@ziepe.ca>
 <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH7PR11MB70047236290DC1CFF9150B8592C62@PH7PR11MB7004.namprd11.prod.outlook.com>

On Mon, Jun 10, 2024 at 03:12:25PM +0000, Zeng, Oak wrote:
> Hi Jason, Leon,
> 
> I come back to this thread to ask a question. Per the discussion in another thread, I have integrated the new dma-mapping API (the first 6 patches of this series) to DRM subsystem. The new API seems fit pretty good to our purpose, better than scatter-gather dma-mapping. So we want to continue work with you to adopt this new API.

Sounds great, thanks for the feedback.

> 
> Did you test the new API in RDMA subsystem? 

This version was tested in our regression tests, but there is a chance
that you are hitting flows that were not relevant for RDMA case.

> Or this RFC series was just some untested codes sending out to get people's design feedback? 

RFC was fully tested in VFIO and RDMA paths, but not NVMe patch.

> Do you have refined version for us to try? I ask because we are seeing some issues but not sure whether it is caused by the new API. We are debugging but it would be good to also ask at the same time.

Yes, as an outcome of the feedback in this thread, I implemented a new
version. Unfortunately, there are some personal matters that are preventing
from me to send it right away.
https://git.kernel.org/pub/scm/linux/kernel/git/leon/linux-rdma.git/log/?h=dma-split-v1

There are some differences in the API, but the main idea is the same.
This version is not fully tested yet.

Thanks

> 
> Cc Himal/Krishna who are also working/testing the new API.
> 
> Thanks,
> Oak
> 
> > -----Original Message-----
> > From: Jason Gunthorpe <jgg@ziepe.ca>
> > Sent: Friday, May 3, 2024 12:43 PM
> > To: Zeng, Oak <oak.zeng@intel.com>
> > Cc: leon@kernel.org; Christoph Hellwig <hch@lst.de>; Robin Murphy
> > <robin.murphy@arm.com>; Marek Szyprowski
> > <m.szyprowski@samsung.com>; Joerg Roedel <joro@8bytes.org>; Will
> > Deacon <will@kernel.org>; Chaitanya Kulkarni <chaitanyak@nvidia.com>;
> > Brost, Matthew <matthew.brost@intel.com>; Hellstrom, Thomas
> > <thomas.hellstrom@intel.com>; Jonathan Corbet <corbet@lwn.net>; Jens
> > Axboe <axboe@kernel.dk>; Keith Busch <kbusch@kernel.org>; Sagi
> > Grimberg <sagi@grimberg.me>; Yishai Hadas <yishaih@nvidia.com>;
> > Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>; Tian, Kevin
> > <kevin.tian@intel.com>; Alex Williamson <alex.williamson@redhat.com>;
> > J�r�me Glisse <jglisse@redhat.com>; Andrew Morton <akpm@linux-
> > foundation.org>; linux-doc@vger.kernel.org; linux-kernel@vger.kernel.org;
> > linux-block@vger.kernel.org; linux-rdma@vger.kernel.org;
> > iommu@lists.linux.dev; linux-nvme@lists.infradead.org;
> > kvm@vger.kernel.org; linux-mm@kvack.org; Bart Van Assche
> > <bvanassche@acm.org>; Damien Le Moal
> > <damien.lemoal@opensource.wdc.com>; Amir Goldstein
> > <amir73il@gmail.com>; josef@toxicpanda.com; Martin K. Petersen
> > <martin.petersen@oracle.com>; daniel@iogearbox.net; Williams, Dan J
> > <dan.j.williams@intel.com>; jack@suse.com; Leon Romanovsky
> > <leonro@nvidia.com>; Zhu Yanjun <zyjzyj2000@gmail.com>
> > Subject: Re: [RFC RESEND 00/16] Split IOMMU DMA mapping operation to
> > two steps
> > 
> > On Thu, May 02, 2024 at 11:32:55PM +0000, Zeng, Oak wrote:
> > 
> > > > Instead of teaching DMA to know these specific datatypes, let's separate
> > > > existing DMA mapping routine to two steps and give an option to
> > advanced
> > > > callers (subsystems) perform all calculations internally in advance and
> > > > map pages later when it is needed.
> > >
> > > I looked into how this scheme can be applied to DRM subsystem and GPU
> > drivers.
> > >
> > > I figured RDMA can apply this scheme because RDMA can calculate the
> > > iova size. Per my limited knowledge of rdma, user can register a
> > > memory region (the reg_user_mr vfunc) and memory region's sized is
> > > used to pre-allocate iova space. And in the RDMA use case, it seems
> > > the user registered region can be very big, e.g., 512MiB or even GiB
> > 
> > In RDMA the iova would be linked to the SVA granual we discussed
> > previously.
> > 
> > > In GPU driver, we have a few use cases where we need dma-mapping. Just
> > name two:
> > >
> > > 1) userptr: it is user malloc'ed/mmap'ed memory and registers to gpu
> > > (in Intel's driver it is through a vm_bind api, similar to mmap). A
> > > userptr can be of any random size, depending on user malloc
> > > size. Today we use dma-map-sg for this use case. The down side of
> > > our approach is, during userptr invalidation, even if user only
> > > munmap partially of an userptr, we invalidate the whole userptr from
> > > gpu page table, because there is no way for us to partially
> > > dma-unmap the whole sg list. I think we can try your new API in this
> > > case. The main benefit of the new approach is the partial munmap
> > > case.
> > 
> > Yes, this is one of the main things it will improve.
> > 
> > > We will have to pre-allocate iova for each userptr, and we have many
> > > userptrs of random size... So we might be not as efficient as RDMA
> > > case where I assume user register a few big memory regions.
> > 
> > You are already doing this. dma_map_sg() does exactly the same IOVA
> > allocation under the covers.
> > 
> > > 2) system allocator: it is malloc'ed/mmap'ed memory be used for GPU
> > > program directly, without any other extra driver API call. We call
> > > this use case system allocator.
> > 
> > > For system allocator, driver have no knowledge of which virtual
> > > address range is valid in advance. So when GPU access a
> > > malloc'ed/mmap'ed address, we have a page fault. We then look up a
> > > CPU vma which contains the fault address. I guess we can use the CPU
> > > vma size to allocate the iova space of the same size?
> > 
> > No. You'd follow what we discussed in the other thread.
> > 
> > If you do a full SVA then you'd split your MM space into granuals and
> > when a fault hits a granual you'd allocate the IOVA for the whole
> > granual. RDMA ODP is using a 512M granual currently.
> > 
> > If you are doing sub ranges then you'd probably allocate the IOVA for
> > the well defined sub range (assuming the typical use case isn't huge)
> > 
> > > But there will be a true difficulty to apply your scheme to this use
> > > case. It is related to the STICKY flag. As I understand it, the
> > > sticky flag is designed for driver to mark "this page/pfn has been
> > > populated, no need to re-populate again", roughly...Unlike userptr
> > > and RDMA use cases where the backing store of a buffer is always in
> > > system memory, in the system allocator use case, the backing store
> > > can be changing b/t system memory and GPU's device private
> > > memory. Even worse, we have to assume the data migration b/t system
> > > and GPU is dynamic. When data is migrated to GPU, we don't need
> > > dma-map. And when migration happens to a pfn with STICKY flag, we
> > > still need to repopulate this pfn. So you can see, it is not easy to
> > > apply this scheme to this use case. At least I can't see an obvious
> > > way.
> > 
> > You are already doing this today, you are keeping the sg list around
> > until you unmap it.
> > 
> > Instead of keeping the sg list you'd keep a much smaller datastructure
> > per-granual. The sticky bit is simply a convient way for ODP to manage
> > the smaller data structure, you don't have to use it.
> > 
> > But you do need to keep track of what pages in the granual have been
> > DMA mapped - sg list was doing this before. This could be a simple
> > bitmap array matching the granual size.
> > 
> > Looking (far) forward we may be able to have a "replace" API that
> > allows installing a new page unconditionally regardless of what is
> > already there.
> > 
> > Jason

