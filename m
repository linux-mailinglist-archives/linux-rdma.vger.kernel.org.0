Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E0C562D3
	for <lists+linux-rdma@lfdr.de>; Wed, 26 Jun 2019 08:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726006AbfFZG5m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Jun 2019 02:57:42 -0400
Received: from verein.lst.de ([213.95.11.211]:40637 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725876AbfFZG5m (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 26 Jun 2019 02:57:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C9BA468B05; Wed, 26 Jun 2019 08:57:08 +0200 (CEST)
Date:   Wed, 26 Jun 2019 08:57:08 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190626065708.GB24531@lst.de>
References: <20190620161240.22738-1-logang@deltatee.com> <20190624072752.GA3954@lst.de> <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com> <20190625072008.GB30350@lst.de> <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com> <20190625170115.GA9746@lst.de> <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41235a05-8ed1-e69a-e7cd-48cae7d8a676@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 25, 2019 at 01:54:21PM -0600, Logan Gunthorpe wrote:
> Well whether it's dma_addr_t, phys_addr_t, pfn_t the result isn't all
> that different. You still need roughly the same 'if' hooks for any
> backed memory that isn't in the linear mapping and you can't get a
> kernel mapping for directly.
> 
> It wouldn't be too hard to do a similar patch set that uses something
> like phys_addr_t instead and have a request and queue flag for support
> of non-mappable memory. But you'll end up with very similar 'if' hooks
> and we'd have to clean up all bio-using drivers that access the struct
> pages directly.

We'll need to clean that mess up anyway, and I've been chugging
along doing some of that.  A lot still assume no highmem, so we need
to convert them over to something that kmaps anyway.  If we get
the abstraction right that will actually help converting over to
a better reprsentation.

> Though, we'd also still have the problem of how to recognize when the
> address points to P2PDMA and needs to be translated to the bus offset.
> The map-first inversion was what helped here because the driver
> submitting the requests had all the information. Though it could be
> another request flag and indicating non-mappable memory could be a flag
> group like REQ_NOMERGE_FLAGS -- REQ_NOMAP_FLAGS.

The assumes the request all has the same memory, which is a simplifing
assuption.  My idea was that if had our new bio_vec like this:

struct bio_vec {
	phys_addr_t		paddr; // 64-bit on 64-bit systems
	unsigned long		len;
};

we have a hole behind len where we could store flag.  Preferably
optionally based on a P2P or other magic memory types config
option so that 32-bit systems with 32-bit phys_addr_t actually
benefit from the smaller and better packing structure.

> If you think any of the above ideas sound workable I'd be happy to try
> to code up another prototype.

Іt sounds workable.  To some of the first steps are cleanups independent
of how the bio_vec is eventually going to look like.  That is making
the DMA-API internals work on the phys_addr_t, which also unifies the
map_resource implementation with map_page.  I plan to do that relatively
soon.  The next is sorting out access to bios data by virtual address.
All these need nice kmapping helper that avoid too much open coding.
I was going to look into that next, mostly to kill the block layer
bounce buffering code.  Similar things will also be needed at the
scatterlist level I think.  After that we need to more audits of
how bv_page is still used.  something like a bv_phys() helper that
does "page_to_phys(bv->bv_page) + bv->bv_offset" might come in handy
for example.
