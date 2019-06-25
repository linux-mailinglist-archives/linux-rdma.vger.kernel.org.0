Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B152055830
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 21:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727284AbfFYTyk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 15:54:40 -0400
Received: from ale.deltatee.com ([207.54.116.67]:37308 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726712AbfFYTyk (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 15:54:40 -0400
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hfrWI-0007CW-Rp; Tue, 25 Jun 2019 13:54:23 -0600
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190624072752.GA3954@lst.de>
 <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
 <20190625072008.GB30350@lst.de>
 <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
 <20190625170115.GA9746@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
Date:   Tue, 25 Jun 2019 13:54:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190625170115.GA9746@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sbates@raithlin.com, jgg@ziepe.ca, kbusch@kernel.org, sagi@grimberg.me, dan.j.williams@intel.com, bhelgaas@google.com, axboe@kernel.dk, linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org, linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de
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



On 2019-06-25 11:01 a.m., Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 09:57:52AM -0600, Logan Gunthorpe wrote:
>>> You assume all addressing is done by the PCI bus address.  If a device
>>> is addressing its own BAR there is no reason to use the PCI bus address,
>>> as it might have much more intelligent schemes (usually bar + offset).
>>
>> Yes, that will be a bit tricky regardless of what we do.
> 
> At least right now it isn't at all.  I've implemented support for
> a draft NVMe proposal for that, and it basically boils down to this
> in the p2p path:
> 
> 	addr = sg_phys(sg);
> 
> 	if (page->pgmap->dev == ctrl->dev && HAS_RELATIVE_ADDRESSING)
> 		addr -= ctrl->cmb_start_addr;
> 
> 		// set magic flag in the SGL
> 	} else {
> 		addr -= pgmap->pci_p2pdma_bus_offset;
> 	}
> 
> without the pagemap it would require a range compare instead, which
> isn't all that hard either.
> 
>>>>> Also duplicating the whole block I/O stack, including hooks all over
>>>>> the fast path is pretty much a no-go.
>>>>
>>>> There was very little duplicate code in the patch set. (Really just the
>>>> mapping code). There are a few hooks, but in practice not that many if
>>>> we ignore the WARN_ONs. We might be able to work to reduce this further.
>>>> The main hooks are: when we skip bouncing, when we skip integrity prep,
>>>> when we split, and when we map. And the patchset drops the PCI_P2PDMA
>>>> hook when we map. So we're talking about maybe three or four extra ifs
>>>> that would likely normally be fast due to the branch predictor.
>>>
>>> And all of those add code to the block layer fast path.
>>
>> If we can't add any ifs to the block layer, there's really nothing we
>> can do.
> 
> That is not what I said.  Of course we can.  But we rather have a
> really good reason.  And adding a parallel I/O path violating the
> highlevel model is not one.
> 
>> So then we're committed to using struct page for P2P?
> 
> Only until we have a significantly better soltution.  And I think
> using physical address in some form instead of pages is that,
> adding a parallel path with dma_addr_t is not, it actually is worse
> than the current code in many respects.

Well whether it's dma_addr_t, phys_addr_t, pfn_t the result isn't all
that different. You still need roughly the same 'if' hooks for any
backed memory that isn't in the linear mapping and you can't get a
kernel mapping for directly.

It wouldn't be too hard to do a similar patch set that uses something
like phys_addr_t instead and have a request and queue flag for support
of non-mappable memory. But you'll end up with very similar 'if' hooks
and we'd have to clean up all bio-using drivers that access the struct
pages directly.

Though, we'd also still have the problem of how to recognize when the
address points to P2PDMA and needs to be translated to the bus offset.
The map-first inversion was what helped here because the driver
submitting the requests had all the information. Though it could be
another request flag and indicating non-mappable memory could be a flag
group like REQ_NOMERGE_FLAGS -- REQ_NOMAP_FLAGS.

If you think any of the above ideas sound workable I'd be happy to try
to code up another prototype.

Logan
