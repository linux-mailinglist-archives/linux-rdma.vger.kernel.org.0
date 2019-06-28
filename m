Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DBC4C59D12
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 15:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbfF1Nim (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 09:38:42 -0400
Received: from verein.lst.de ([213.95.11.211]:38826 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfF1Nim (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 09:38:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 8BA79227A81; Fri, 28 Jun 2019 15:38:37 +0200 (CEST)
Date:   Fri, 28 Jun 2019 15:38:37 +0200
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
Message-ID: <20190628133837.GA3801@lst.de>
References: <20190625170115.GA9746@lst.de> <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com> <20190626065708.GB24531@lst.de> <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com> <20190626202107.GA5850@ziepe.ca> <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com> <20190627090843.GB11548@lst.de> <89889319-e778-7772-ab36-dc55b59826be@deltatee.com> <20190627170027.GE10652@lst.de> <e63d0259-e17f-effe-b76d-43dbfda8ae3a@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e63d0259-e17f-effe-b76d-43dbfda8ae3a@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 27, 2019 at 12:00:35PM -0600, Logan Gunthorpe wrote:
> > It is not.  (c) is fundamentally very different as it is not actually
> > an operation that ever goes out to the wire at all, and which is why the
> > actual physical address on the wire does not matter at all.
> > Some interfaces like NVMe have designed it in a way that it the commands
> > used to do this internal transfer look like (b2), but that is just their
> > (IMHO very questionable) interface design choice, that produces a whole
> > chain of problems.
> 
> >From the mapping device's driver's perspective yes, but from the
> perspective of a submitting driver they would be the same.

With your dma_addr_t scheme it won't be the same, as you'd need
a magic way to generate the internal addressing and stuff it into
the dma_addr_t.  With a phys_addr_t based scheme they should basically
be all the same.

> Yes, you did suggest them. But what I'm trying to suggest is we don't
> *necessarily* need the lookup. For demonstration purposes only, a
> submitting driver could very roughly potentially do:
> 
> struct bio_vec vec;
> dist = pci_p2pdma_dist(provider_pdev, mapping_pdev);
> if (dist < 0) {
>      /* use regular memory */
>      vec.bv_addr = virt_to_phys(kmalloc(...));
>      vec.bv_flags = 0;
> } else if (dist & PCI_P2PDMA_THRU_HOST_BRIDGE) {
>      vec.bv_addr = pci_p2pmem_alloc_phys(provider_pdev, ...);
>      vec.bv_flags = BVEC_MAP_RESOURCE;
> } else {
>      vec.bv_addr = pci_p2pmem_alloc_bus_addr(provider_pdev, ...);
>      vec.bv_flags = BVEC_MAP_BUS_ADDR;
> }

That doesn't look too bad, except..

> -- And a mapping driver would roughly just do:
> 
> dma_addr_t dma_addr;
> if (vec.bv_flags & BVEC_MAP_BUS_ADDR) {
>      if (pci_bus_addr_in_bar(mapping_pdev, vec.bv_addr, &bar, &off))  {
>           /* case (c) */
>           /* program the DMA engine with bar and off */

Why bother with that here if we could also let the caller handle
that? pci_p2pdma_dist() should be able to trivially find that out
based on provider_dev == mapping_dev.

> The real difficulty here is that you'd really want all the above handled
> by a dma_map_bvec() so it can combine every vector hitting the IOMMU
> into a single continuous IOVA -- but it's hard to fit case (c) into that
> equation. So it might be that a dma_map_bvec() handles cases (a), (b1)
> and (b2) and the mapping driver has to then check each resulting DMA
> vector for pci_bus_addr_in_bar() while it is programming the DMA engine
> to deal with case (c).

I'd do it the other way around.  pci_p2pdma_dist is used to find
the p2p type.  The p2p type is stuff into the bio_vec, and we then:

 (1) manually check for case (c) in driver for drivers that want to
     treat it different from (b)
 (2) we then have a dma mapping wrapper that checks the p2p type
     and does the right thing for the rest.
