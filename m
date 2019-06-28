Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 004765A532
	for <lists+linux-rdma@lfdr.de>; Fri, 28 Jun 2019 21:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfF1TgA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 28 Jun 2019 15:36:00 -0400
Received: from ale.deltatee.com ([207.54.116.67]:42826 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726695AbfF1TgA (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 28 Jun 2019 15:36:00 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hgwex-0003Qy-9H; Fri, 28 Jun 2019 13:35:48 -0600
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
References: <20190626210018.GB6392@ziepe.ca>
 <c25d3333-dcd5-3313-089b-7fbbd6fbd876@deltatee.com>
 <20190627063223.GA7736@ziepe.ca>
 <6afe4027-26c8-df4e-65ce-49df07dec54d@deltatee.com>
 <20190627163504.GB9568@ziepe.ca>
 <4894142c-3233-a3bb-f9a3-4a4985136e9b@deltatee.com>
 <20190628045705.GD3705@ziepe.ca>
 <8022a2a4-4069-d256-11da-e6d9b2ffbf60@deltatee.com>
 <20190628172926.GA3877@ziepe.ca>
 <25a87c72-630b-e1f1-c858-9c8b417506fc@deltatee.com>
 <20190628190931.GC3877@ziepe.ca>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <cb680437-9615-da42-ebc5-4751e024a45f@deltatee.com>
Date:   Fri, 28 Jun 2019 13:35:42 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628190931.GC3877@ziepe.ca>
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



On 2019-06-28 1:09 p.m., Jason Gunthorpe wrote:
> On Fri, Jun 28, 2019 at 12:29:32PM -0600, Logan Gunthorpe wrote:
>>
>>
>> On 2019-06-28 11:29 a.m., Jason Gunthorpe wrote:
>>> On Fri, Jun 28, 2019 at 10:22:06AM -0600, Logan Gunthorpe wrote:
>>>
>>>>> Why not?  If we have a 'bar info' structure that could have data
>>>>> transfer op callbacks, infact, I think we might already have similar
>>>>> callbacks for migrating to/from DEVICE_PRIVATE memory with DMA..
>>>>
>>>> Well it could, in theory be done, but It just seems wrong to setup and
>>>> wait for more DMA requests while we are in mid-progress setting up
>>>> another DMA request. Especially when the block layer has historically
>>>> had issues with stack sizes. It's also possible you might have multiple
>>>> bio_vec's that have to each do a migration and with a hook here they'd
>>>> have to be done serially.
>>>
>>> *shrug* this is just standard bounce buffering stuff...
>>
>> I don't know of any "standard" bounce buffering stuff that uses random
>> other device's DMA engines where appropriate.
> 
> IMHO, it is conceptually the same as memcpy.. And probably we will not
> ever need such optimization in dma map. Other copy places might be
> different at least we have the option.
>  
>> IMO the bouncing in the DMA layer isn't a desirable thing, it was a
>> necessary addition to work around various legacy platform issues and
>> have existing code still work correctly. 
> 
> Of course it is not desireable! But there are many situations where we
> do not have the luxury to work around the HW limits in the caller, so
> those callers either have to not do DMA or they have to open code
> bounce buffering - both are wrong.

They don't have to open code it, they can use helpers and good coding
practices. But the submitting driver is the one that's in the best
position to figure this stuff out. Just like it is with the dma_map
bouncing -- all it has to do is use dma_alloc_coherent(). If we don't
write any submitting drivers that assume the dma_map API bounces than we
should never have to deal with it.

>>> What I see as the question is how to layout the BIO. 
>>>
>>> If we agree the bio should only have phys_addr_t then we need some
>>> 'bar info' (ie at least the offset) in the dma map and some 'bar info'
>>> (ie the DMA device) during the bio construciton.
>>
>> Per my other email, it was phys_addr_t plus hints on how to map the
>> memory (bus address, dma_map_resource, or regular). This requires
>> exactly two flag bits in the bio_vec and no interval tree or hash table.
>> I don't want to have to pass bar info, other hooks, or anything like
>> that to the block layer.
> 
> This scheme makes the assumption that the dma mapping struct device is
> all you need, and we never need to know the originating struct device
> during dma map. This is clearly safe if the two devices are on the
> same PCIe segment
> 
> However, I'd feel more comfortable about that assumption if we had
> code to support the IOMMU case, and know for sure it doesn't require
> more info :(

The example I posted *does* support the IOMMU case. That was case (b1)
in the description. The idea is that pci_p2pdma_dist() returns a
distance with a high bit set (PCI_P2PDMA_THRU_HOST_BRIDGE) when an IOMMU
mapping is required and the appropriate flag tells it to call
dma_map_resource(). This way, it supports both same-segment and
different-segments without needing any look ups in the map step.

For the only existing upstream use case (NVMe-of), this is ideal because
we can calculate the mapping requirements exactly once ahead of any
transfers. Then populating the bvecs and dma-mapping for each transfer
is fast and doesn't require any additional work besides deciding where
to get the memory from.

For O_DIRECT and userspace RDMA, this should also be ideal, the real
problem is how to get the necessary information out of the VMA. This
isn't helped by having a lookup at the dma map step. But the provider
driver is certainly going to be involved in creating the VMA so it
should be able to easily provide the necessary hooks. Though there are
still a bunch of challenges here.

Maybe other use-cases are not this ideal but I suspect they should still
be able to make use of the same flags. It's hard to say right now,
though, because we haven't seen any other use cases.


> Maybe you can hide these flags as some dma_map helper, then the
> layering might be nicer:
> 
>   dma_map_set_bio_p2p_flags(bio, phys_addr, source dev, dest_dev) 
> 
> ?
> 
> ie the choice of flag scheme to use is opaque to the DMA layer.

If there was such a use case, I suppose you could use a couple of flag
bits to tell you how to interpret the other flag bits but, at the
moment, I only see a need for 2 bits so we'll probably have a lot of
spares for a long time. You could certainly have a 3rd bit which says do
a lookup and try to figure out bouncing, but I don't think it's a good idea.

>>> If we can spare 4-8 bits in the bio then I suggest a 'perfect hash
>>> table'. Assign each registered P2P 'bar info' a small 4 bit id and
>>> hash on that. It should be fast enough to not worry about the double
>>> lookup.
>>
>> This feels like it's just setting us up to run into nasty limits based
>> on the number of bits we actually have. The number of bits in a bio_vec
>> will always be a precious resource. If I have a server chassis that
>> exist today with 24 NVMe devices, and each device has a CMB, I'm already
>> using up 6 of those bits. Then we might have DEVICE_PRIVATE and other
>> uses on top of that.
> 
> A hash is an alternative data structure to a interval tree that has
> better scaling for small numbers of BARs, which I think is our
> case.

But then you need a large and not necessarily future-proof number of
bits in the bio_vec to store the hash.

Logan
