Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7640B50356
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 09:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbfFXH2Z (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 03:28:25 -0400
Received: from verein.lst.de ([213.95.11.211]:53057 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726375AbfFXH2Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 03:28:25 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 0DC7D68B02; Mon, 24 Jun 2019 09:27:53 +0200 (CEST)
Date:   Mon, 24 Jun 2019 09:27:52 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190624072752.GA3954@lst.de>
References: <20190620161240.22738-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620161240.22738-1-logang@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is not going to fly.

For one passing a dma_addr_t through the block layer is a layering
violation, and one that I think will also bite us in practice.
The host physical to PCIe bus address mapping can have offsets, and
those offsets absolutely can be different for differnet root ports.
So with your caller generated dma_addr_t everything works fine with
a switched setup as the one you are probably testing on, but on a
sufficiently complicated setup with multiple root ports it can break.

Also duplicating the whole block I/O stack, including hooks all over
the fast path is pretty much a no-go.

I've been pondering for a while if we wouldn't be better off just
passing a phys_addr_t + len instead of the page, offset, len tuple
in the bio_vec, though.  If you look at the normal I/O path here
is what we normally do:

 - we get a page as input, either because we have it at hand (e.g.
   from the page cache) or from get_user_pages (which actually caculates
   it from a pfn in the page tables)
 - once in the bio all the merging decisions are based on the physical
   address, so we have to convert it to the physical address there,
   potentially multiple times
 - then dma mapping all works off the physical address, which it gets
   from the page at the start
 - then only the dma address is used for the I/O
 - on I/O completion we often but not always need the page again.  In
   the direct I/O case for reference counting and dirty status, in the
   file system also for things like marking the page uptodate

So if we move to a phys_addr_t we'd need to go back to the page at least
once.  But because of how the merging works we really only need to do
it once per segment, as we can just do pointer arithmerics do get the
following pages.  As we generally go at least once from a physical
address to a page in the merging code even a relatively expensive vmem_map
looks shouldn't be too bad.  Even more so given that the super hot path
(small blkdev direct I/O) can actually trivially cache the affected pages
as well.

Linus kinda hates the pfn approach, but part of that was really that
it was proposed for file system data, which we all found out really
can't work as-is without pages the hard way.  Another part probably
was potential performance issue, but between the few page lookups, and
the fact that using a single phys_addr_t instead of pfn/page + offset
should avoid quite a few calculations performance should not actually
be affected, although we'll have to be careful to actually verify that.
