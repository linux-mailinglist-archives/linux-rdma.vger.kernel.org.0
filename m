Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8B950587F0
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 19:06:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfF0RGw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 13:06:52 -0400
Received: from verein.lst.de ([213.95.11.210]:40347 "EHLO newverein.lst.de"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726405AbfF0RGw (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 13:06:52 -0400
X-Greylist: delayed 380 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 Jun 2019 13:06:51 EDT
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 991F9227A8B; Thu, 27 Jun 2019 19:00:27 +0200 (CEST)
Date:   Thu, 27 Jun 2019 19:00:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190627170027.GE10652@lst.de>
References: <20190625072008.GB30350@lst.de> <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com> <20190625170115.GA9746@lst.de> <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com> <20190626065708.GB24531@lst.de> <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com> <20190626202107.GA5850@ziepe.ca> <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com> <20190627090843.GB11548@lst.de> <89889319-e778-7772-ab36-dc55b59826be@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <89889319-e778-7772-ab36-dc55b59826be@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 27, 2019 at 10:30:42AM -0600, Logan Gunthorpe wrote:
> >  (a) a range is normal RAM, DMA mapping works as usual
> >  (b) a range is another devices BAR, in which case we need to do a
> >      map_resource equivalent (which really just means don't bother with
> >      cache flush on non-coherent architectures) and apply any needed
> >      offset, fixed or iommu based
> 
> Well I would split this into two cases: (b1) ranges in another device's
> BAR that will pass through the root complex and require a map_resource
> equivalent and (b2) ranges in another device's bar that don't pass
> through the root complex and require applying an offset to the bus
> address. Both require rather different handling and the submitting
> driver should already know ahead of time what type we have.

True.

> 
> >  (c) a range points to a BAR on the acting device. In which case we
> >      don't need to DMA map at all, because no dma is happening but just an
> >      internal transfer.  And depending on the device that might also require
> >      a different addressing mode
> 
> I think (c) is actually just a special case of (b2). Any device that has
> a special protocol for addressing the local BAR can just do a range
> compare on the address to determine if it's local or not. Devices that
> don't have a special protocol for this would handle both (c) and (b2)
> the same.

It is not.  (c) is fundamentally very different as it is not actually
an operation that ever goes out to the wire at all, and which is why the
actual physical address on the wire does not matter at all.
Some interfaces like NVMe have designed it in a way that it the commands
used to do this internal transfer look like (b2), but that is just their
(IMHO very questionable) interface design choice, that produces a whole
chain of problems.

> > I guess it might make sense to just have a block layer flag that (b) or
> > (c) might be contained in a bio.  Then we always look up the data
> > structure, but can still fall back to (a) if nothing was found.  That
> > even allows free mixing and matching of memory types, at least as long
> > as they are contained to separate bio_vec segments.
> 
> IMO these three cases should be reflected in flags in the bio_vec. We'd
> probably still need a queue flag to indicate support for mapping these,
> but a flag on the bio that indicates special cases *might* exist in the
> bio_vec and the driver has to do extra work to somehow distinguish the
> three types doesn't seem useful. bio_vec flags also make it easy to
> support mixing segments from different memory types.

So I іnitially suggested these flags.  But without a pgmap we absolutely
need a lookup operation to find which phys address ranges map to which
device.  And once we do that the data structure the only thing we need
is a flag saying that we need that information, and everything else
can be in the data structure returned from that lookup.
