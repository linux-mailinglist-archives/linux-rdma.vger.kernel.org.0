Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D009057095
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726328AbfFZSb3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 14:31:29 -0400
Received: from ale.deltatee.com ([207.54.116.67]:48362 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbfFZSb3 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Jun 2019 14:31:29 -0400
Received: from s01061831bf6ec98c.cg.shawcable.net ([68.147.80.180] helo=[192.168.6.132])
        by ale.deltatee.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <logang@deltatee.com>)
        id 1hgChR-0000jK-UL; Wed, 26 Jun 2019 12:31:19 -0600
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
 <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
 <20190626065708.GB24531@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <c15d5997-9ba4-f7db-0e7a-a69e75df316c@deltatee.com>
Date:   Wed, 26 Jun 2019 12:31:08 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190626065708.GB24531@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 68.147.80.180
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



On 2019-06-26 12:57 a.m., Christoph Hellwig wrote:
> On Tue, Jun 25, 2019 at 01:54:21PM -0600, Logan Gunthorpe wrote:
>> Well whether it's dma_addr_t, phys_addr_t, pfn_t the result isn't all
>> that different. You still need roughly the same 'if' hooks for any
>> backed memory that isn't in the linear mapping and you can't get a
>> kernel mapping for directly.
>>
>> It wouldn't be too hard to do a similar patch set that uses something
>> like phys_addr_t instead and have a request and queue flag for support
>> of non-mappable memory. But you'll end up with very similar 'if' hooks
>> and we'd have to clean up all bio-using drivers that access the struct
>> pages directly.
> 
> We'll need to clean that mess up anyway, and I've been chugging
> along doing some of that.  A lot still assume no highmem, so we need
> to convert them over to something that kmaps anyway.  If we get
> the abstraction right that will actually help converting over to
> a better reprsentation.
> 
>> Though, we'd also still have the problem of how to recognize when the
>> address points to P2PDMA and needs to be translated to the bus offset.
>> The map-first inversion was what helped here because the driver
>> submitting the requests had all the information. Though it could be
>> another request flag and indicating non-mappable memory could be a flag
>> group like REQ_NOMERGE_FLAGS -- REQ_NOMAP_FLAGS.
> 
> The assumes the request all has the same memory, which is a simplifing
> assuption.  My idea was that if had our new bio_vec like this:
> 
> struct bio_vec {
> 	phys_addr_t		paddr; // 64-bit on 64-bit systems
> 	unsigned long		len;
> };
> 
> we have a hole behind len where we could store flag.  Preferably
> optionally based on a P2P or other magic memory types config
> option so that 32-bit systems with 32-bit phys_addr_t actually
> benefit from the smaller and better packing structure.

That seems sensible. The one thing that's unclear though is how to get
the PCI Bus address when appropriate. Can we pass that in instead of the
phys_addr with an appropriate flag? Or will we need to pass the actual
physical address and then, at the map step, the driver has to some how
lookup the PCI device to figure out the bus offset?

>> If you think any of the above ideas sound workable I'd be happy to try
>> to code up another prototype.
> 
> Іt sounds workable.  To some of the first steps are cleanups independent
> of how the bio_vec is eventually going to look like.  That is making
> the DMA-API internals work on the phys_addr_t, which also unifies the
> map_resource implementation with map_page.  I plan to do that relatively
> soon.  The next is sorting out access to bios data by virtual address.
> All these need nice kmapping helper that avoid too much open coding.
> I was going to look into that next, mostly to kill the block layer
> bounce buffering code.  Similar things will also be needed at the
> scatterlist level I think.  After that we need to more audits of
> how bv_page is still used.  something like a bv_phys() helper that
> does "page_to_phys(bv->bv_page) + bv->bv_offset" might come in handy
> for example.

Ok, I should be able to help with that. When I have a chance I'll try to
look at the bv_phys() helper.

Logan
