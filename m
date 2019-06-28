Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 752CB5A0B2
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 18:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfF1QWW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 12:22:22 -0400
Received: from ale.deltatee.com ([207.54.116.67]:39208 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726667AbfF1QWW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 12:22:22 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hgtdb-0000Xu-VQ; Fri, 28 Jun 2019 10:22:12 -0600
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
References: <20190626065708.GB24531@lst.de>
 <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
 <20190626202107.GA5850@ziepe.ca>
 <8a0a08c3-a537-bff6-0852-a5f337a70688@deltatee.com>
 <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
 <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
 <20190627163504.GB9568@ziepe.ca>
 <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
 <20190628045705.GD3705@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <8022a2a4-4069-d256-11da-e6d9b2ffbf60@deltatee.com>
Date:   Fri, 28 Jun 2019 10:22:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628045705.GD3705@ziepe.ca>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, kbusch@kernel.org, sagi@grimberg.me, dan.j.williams@intel.com, bhelgaas@google.com, axboe@kernel.dk, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de, jgg@ziepe.ca
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        GREYLIST_ISWHITE autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019-06-27 10:57 p.m., Jason Gunthorpe wrote:
> On Thu, Jun 27, 2019 at 10:49:43AM -0600, Logan Gunthorpe wrote:
> 
>>> I don't think a GPU/FPGA driver will be involved, this would enter the
>>> block layer through the O_DIRECT path or something generic.. This the
>>> general flow I was suggesting to Dan earlier
>>
>> I would say the O_DIRECT path has to somehow call into the driver
>> backing the VMA to get an address to appropriate memory (in some way
>> vaguely similar to how we were discussing at LSF/MM)
> 
> Maybe, maybe no. For something like VFIO the PTE already has the
> correct phys_addr_t and we don't need to do anything..
> 
> For DEVICE_PRIVATE we need to get the phys_addr_t out - presumably
> through a new pagemap op?

I don't know much about either VFIO or DEVICE_PRIVATE, but I'd still
wager there would be a better way to handle it before they submit it to
the block layer.

>> If P2P can't be done at that point, then the provider driver would
>> do the copy to system memory, in the most appropriate way, and
>> return regular pages for O_DIRECT to submit to the block device.
> 
> That only makes sense for the migratable DEVICE_PRIVATE case, it
> doesn't help the VFIO-like case, there you'd need to bounce buffer.
> 
>>>> I think it would be a larger layering violation to have the NVMe driver
>>>> (for example) memcpy data off a GPU's bar during a dma_map step to
>>>> support this bouncing. And it's even crazier to expect a DMA transfer to
>>>> be setup in the map step.
>>>
>>> Why? Don't we already expect the DMA mapper to handle bouncing for
>>> lots of cases, how is this case different? This is the best place to
>>> place it to make it shared.
>>
>> This is different because it's special memory where the DMA mapper
>> can't possibly know the best way to transfer the data.
> 
> Why not?  If we have a 'bar info' structure that could have data
> transfer op callbacks, infact, I think we might already have similar
> callbacks for migrating to/from DEVICE_PRIVATE memory with DMA..

Well it could, in theory be done, but It just seems wrong to setup and
wait for more DMA requests while we are in mid-progress setting up
another DMA request. Especially when the block layer has historically
had issues with stack sizes. It's also possible you might have multiple
bio_vec's that have to each do a migration and with a hook here they'd
have to be done serially.

>> One could argue that the hook to the GPU/FPGA driver could be in the
>> mapping step but then we'd have to do lookups based on an address --
>> where as the VMA could more easily have a hook back to whatever driver
>> exported it.
> 
> The trouble with a VMA hook is that it is only really avaiable when
> working with the VA, and it is not actually available during GUP, you
> have to have a GUP-like thing such as hmm_range_snapshot that is
> specifically VMA based. And it is certainly not available during dma_map.

Yup, I'm hoping some of the GUP cleanups will help with that but it's
definitely a problem. I never said the VMA would be available at dma_map
time nor would I want it to be. I expect it to be available before we
submit the request to the block layer and it really only applies to the
O_DIRECT path and maybe a similar thing in the RDMA path.

> When working with VMA's/etc it seems there are some good reasons to
> drive things off of the PTE content (either via struct page & pgmap or
> via phys_addr_t & barmap)
> 
> I think the best reason to prefer a uniform phys_addr_t is that it
> does give us the option to copy the data to/from CPU memory. That
> option goes away as soon as the bio sometimes provides a dma_addr_t.

Not really. phys_addr_t alone doesn't give us a way to copy data. You
need a lookup table on that address and a couple of hooks.

> At least for RDMA, we do have some cases (like siw/rxe, hfi) where
> they sometimes need to do that copy. I suspect the block stack is
> similar, in the general case.

But the whole point of the use cases I'm trying to serve is to avoid the
root complex. If the block layer randomly decides to ephemerally copy
the data back to the CPU (for integrity or something) then we've
accomplished nothing and shouldn't have put the data in the BAR to begin
with. Similarly, for DEVICE_PRIVATE, I'd have guessed it wouldn't want
to use ephemeral copies but actually migrate the memory semi-permanently
to the CPU for more than one transaction and I would argue that it makes
the most sense to make these decisions before the data gets to the block
layer.

Logan
