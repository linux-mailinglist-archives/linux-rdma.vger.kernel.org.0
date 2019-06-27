Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5268558968
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Jun 2019 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbfF0SAu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 27 Jun 2019 14:00:50 -0400
Received: from ale.deltatee.com ([207.54.116.67]:38904 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726520AbfF0SAu (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 27 Jun 2019 14:00:50 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hgYhL-00046B-JH; Thu, 27 Jun 2019 12:00:40 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
References: <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190627090843.GB11548@lst.de>
 <89889319-e778-7772-ab36-dc55b59826be@deltatee.com>
 <20190627170027.GE10652@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <e63d0259-e17f-effe-b76d-43dbfda8ae3a@deltatee.com>
Date:   Thu, 27 Jun 2019 12:00:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190627170027.GE10652@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
X-SA-Exim-Rcpt-To: sbates@raithlin.com, kbusch@kernel.org, sagi@grimberg.me, dan.j.williams@intel.com, bhelgaas@google.com, axboe@kernel.dk, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, jgg@ziepe.ca, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE,MYRULES_FREE autolearn=ham autolearn_force=no
        version=3.4.2
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-06-27 11:00 a.m., Christoph Hellwig wrote:
> It is not.  (c) is fundamentally very different as it is not actually
> an operation that ever goes out to the wire at all, and which is why the
> actual physical address on the wire does not matter at all.
> Some interfaces like NVMe have designed it in a way that it the commands
> used to do this internal transfer look like (b2), but that is just their
> (IMHO very questionable) interface design choice, that produces a whole
> chain of problems.

From the mapping device's driver's perspective yes, but from the
perspective of a submitting driver they would be the same.

>>> I guess it might make sense to just have a block layer flag that (b) or
>>> (c) might be contained in a bio.  Then we always look up the data
>>> structure, but can still fall back to (a) if nothing was found.  That
>>> even allows free mixing and matching of memory types, at least as long
>>> as they are contained to separate bio_vec segments.
>>
>> IMO these three cases should be reflected in flags in the bio_vec. We'd
>> probably still need a queue flag to indicate support for mapping these,
>> but a flag on the bio that indicates special cases *might* exist in the
>> bio_vec and the driver has to do extra work to somehow distinguish the
>> three types doesn't seem useful. bio_vec flags also make it easy to
>> support mixing segments from different memory types.
> 
> So I іnitially suggested these flags.  But without a pgmap we absolutely
> need a lookup operation to find which phys address ranges map to which
> device.  And once we do that the data structure the only thing we need
> is a flag saying that we need that information, and everything else
> can be in the data structure returned from that lookup.

Yes, you did suggest them. But what I'm trying to suggest is we don't
*necessarily* need the lookup. For demonstration purposes only, a
submitting driver could very roughly potentially do:

struct bio_vec vec;
dist = pci_p2pdma_dist(provider_pdev, mapping_pdev);
if (dist < 0) {
     /* use regular memory */
     vec.bv_addr = virt_to_phys(kmalloc(...));
     vec.bv_flags = 0;
} else if (dist & PCI_P2PDMA_THRU_HOST_BRIDGE) {
     vec.bv_addr = pci_p2pmem_alloc_phys(provider_pdev, ...);
     vec.bv_flags = BVEC_MAP_RESOURCE;
} else {
     vec.bv_addr = pci_p2pmem_alloc_bus_addr(provider_pdev, ...);
     vec.bv_flags = BVEC_MAP_BUS_ADDR;
}

-- And a mapping driver would roughly just do:

dma_addr_t dma_addr;
if (vec.bv_flags & BVEC_MAP_BUS_ADDR) {
     if (pci_bus_addr_in_bar(mapping_pdev, vec.bv_addr, &bar, &off))  {
          /* case (c) */
          /* program the DMA engine with bar and off */
     } else {
          /* case (b2) */
          dma_addr = vec.bv_addr;
     }
} else if (vec.bv_flags & BVEC_MAP_RESOURCE) {
     /* case (b1) */
     dma_addr = dma_map_resource(mapping_dev, vec.bv_addr, ...);
} else {
     /* case (a) */
     dma_addr = dma_map_page(..., phys_to_page(vec.bv_addr), ...);
}

The real difficulty here is that you'd really want all the above handled
by a dma_map_bvec() so it can combine every vector hitting the IOMMU
into a single continuous IOVA -- but it's hard to fit case (c) into that
equation. So it might be that a dma_map_bvec() handles cases (a), (b1)
and (b2) and the mapping driver has to then check each resulting DMA
vector for pci_bus_addr_in_bar() while it is programming the DMA engine
to deal with case (c).

Logan
