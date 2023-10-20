Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4C5C7D0D1F
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Oct 2023 12:30:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376842AbjJTKaX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Oct 2023 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376764AbjJTKaS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Oct 2023 06:30:18 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1FB7FD5F
        for <linux-rdma@vger.kernel.org>; Fri, 20 Oct 2023 03:30:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A0A722F4;
        Fri, 20 Oct 2023 03:30:53 -0700 (PDT)
Received: from [10.57.68.58] (unknown [10.57.68.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB6683F5A1;
        Fri, 20 Oct 2023 03:30:10 -0700 (PDT)
Message-ID: <41218260-1e5f-4d36-8287-fc6f50f3ec00@arm.com>
Date:   Fri, 20 Oct 2023 11:30:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Content-Language: en-GB
To:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Chuck Lever <cel@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
        iommu@lists.linux.dev
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net>
 <ZTFRBxVFQIjtQEsP@casper.infradead.org> <20231020045849.GA12269@lst.de>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <20231020045849.GA12269@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023-10-20 05:58, Christoph Hellwig wrote:
> On Thu, Oct 19, 2023 at 04:53:43PM +0100, Matthew Wilcox wrote:
>>> RDMA core API could support struct biovec array arguments. The
>>> series compiles on x86, but I haven't tested it further. I'm posting
>>> early in hopes of starting further discussion.
>>
>> Good call, because I think patch 2/9 is a complete non-starter.
>>
>> The fundamental problem with scatterlist is that it is both input
>> and output for the mapping operation.  You're replicating this mistake
>> in a different data structure.
> 
> Agreed.
> 
>>
>> My vision for the future is that we have phyr as our input structure.
>> That looks something like:
>>
>> struct phyr {
>> 	phys_addr_t start;
>> 	size_t len;
>> };
> 
> So my plan was always to turn the bio_vec into that structure, since
> before you came u wit hthe phyr name.  But that's really a separate
> discussion as we might as well support multiple input formats if we
> really have to.
> 
>> Our output structure can continue being called the scatterlist, but
>> it needs to go on a diet and look more like:
>>
>> struct scatterlist {
>> 	dma_addr_t dma_address;
>> 	size_t dma_length;
>> };
> 
> I called it a dma_vec in my years old proposal I can't find any more.
> 
>> Getting to this point is going to be a huge amount of work, and I need
>> to finish folios first.  Or somebody else can work on it ;-)
> 
> Well, we can stage this.  I wish I could find my old proposal about the
> dma_batch API (I remember Robin commented on it, my he is better at
> finding it than me).

Heh, the dirty secret is that Office 365 is surprisingly effective at 
searching 9 years worth of email I haven't deleted :)

https://lore.kernel.org/linux-iommu/79926b59-0eb9-2b88-b1bb-1bd472b10370@arm.com/

>  I think that mostly still stands, independent
> of the transformation of the input structure.  The basic idea is that
> we add a dma batching API, where you start a batch with one call,
> and then add new physically discontiguous vectors to add it until
> it is full and finalized it.  Very similar to how the iommu API
> works internally.  We'd then only use this API if we actually have
> an iommu (or if we want to be fancy swiotlb that could do the same
> linearization), for the direct map we'd still do the equivalent
> of dma_map_page for each element as we need one output vector per
> input vector anyway.

The other thing that's clear by now is that I think we definitely want 
distinct APIs for "please map this bunch of disjoint things" for true 
scatter-gather cases like biovecs where it's largely just convenient to 
keep them grouped together (but opportunistic merging might still be a 
bonus), vs. "please give me a linearised DMA mapping of these pages (and 
fail if you can't)" for the dma-buf style cases.

Cheers,
Robin.

> As Jason pointed out the only fancy implementation we need for now
> is the IOMMU API.  arm32 and powerpc will need to do the work
> to convert to it or do their own work.
