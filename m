Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF5D7D29DB
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Oct 2023 07:59:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbjJWF76 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Oct 2023 01:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjJWF76 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Oct 2023 01:59:58 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE61A4
        for <linux-rdma@vger.kernel.org>; Sun, 22 Oct 2023 22:59:56 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2FE7368AA6; Mon, 23 Oct 2023 07:59:52 +0200 (CEST)
Date:   Mon, 23 Oct 2023 07:59:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Chuck Lever <cel@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Alexander Potapenko <glider@google.com>, linux-mm@kvack.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        kasan-dev@googlegroups.com, David Howells <dhowells@redhat.com>,
        iommu@lists.linux.dev
Subject: Re: [PATCH RFC 0/9] Exploring biovec support in (R)DMA API
Message-ID: <20231023055951.GB11569@lst.de>
References: <169772852492.5232.17148564580779995849.stgit@klimt.1015granger.net> <ZTFRBxVFQIjtQEsP@casper.infradead.org> <20231020045849.GA12269@lst.de> <41218260-1e5f-4d36-8287-fc6f50f3ec00@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41218260-1e5f-4d36-8287-fc6f50f3ec00@arm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 20, 2023 at 11:30:06AM +0100, Robin Murphy wrote:
>> Well, we can stage this.  I wish I could find my old proposal about the
>> dma_batch API (I remember Robin commented on it, my he is better at
>> finding it than me).
>
> Heh, the dirty secret is that Office 365 is surprisingly effective at 
> searching 9 years worth of email I haven't deleted :)
>
> https://lore.kernel.org/linux-iommu/79926b59-0eb9-2b88-b1bb-1bd472b10370@arm.com/

Perfect, thanks!

> The other thing that's clear by now is that I think we definitely want 
> distinct APIs for "please map this bunch of disjoint things" for true 
> scatter-gather cases like biovecs where it's largely just convenient to 
> keep them grouped together (but opportunistic merging might still be a 
> bonus), vs. "please give me a linearised DMA mapping of these pages (and 
> fail if you can't)" for the dma-buf style cases.

Hmm, I'm not sure I agree.  For both the iommu and swiotlb case we
get the linear mapping for free with small limitations:

 - for the iommu case the alignment needs to be a multiple of the iommu
   page size
 - for swiotlb the size of each mapping is very limited

If these conditions are matched we can linearize for free, if they aren't
we can't linearize at all.

But maybe I'm missing something?

