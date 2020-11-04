Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F31882A65C2
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 15:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726843AbgKDOBO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 09:01:14 -0500
Received: from verein.lst.de ([213.95.11.211]:42740 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgKDOBN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 09:01:13 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 265B767373; Wed,  4 Nov 2020 15:01:09 +0100 (CET)
Date:   Wed, 4 Nov 2020 15:01:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104140108.GA5674@lst.de>
References: <20201104095052.1222754-1-hch@lst.de> <20201104095052.1222754-3-hch@lst.de> <20201104134241.GP36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104134241.GP36674@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 09:42:41AM -0400, Jason Gunthorpe wrote:
> On Wed, Nov 04, 2020 at 10:50:49AM +0100, Christoph Hellwig wrote:
> 
> > +int ib_dma_virt_map_sg(struct ib_device *dev, struct scatterlist *sg, int nents)
> > +{
> > +	struct scatterlist *s;
> > +	int i;
> > +
> > +	for_each_sg(sg, s, nents, i) {
> > +		sg_dma_address(s) = (uintptr_t)sg_virt(s);
> > +		sg_dma_len(s) = s->length;
> 
> Hmm.. There is nothing ensuring the page is mapped here for this
> sg_virt(). Before maybe some of the kconfig stuff prevented highmem
> systems indirectly, I wonder if we should add something more direct to
> exclude highmem for these drivers?

I had actually noticed this earlier as well and then completely forgot
about it..

rdmavt depends on X86_64, so it can't be used with highmem, but for
rxe and siw there weren't any such dependencies so I think we were just
lucky.  Let me send a fix to add explicit depencies and then respin this
series on top of that..

> Sigh. I think the proper fix is to replace addr/length with a
> scatterlist pointer in the struct ib_sge, then have SW drivers
> directly use the page pointer properly.

The proper fix is to move the DMA mapping into the RDMA core, yes.
And as you said it will be hard.  But I don't think scatterlists
are the right interface.  IMHO we can keep re-use the existing
struct ib_sge:

struct ib_ge {
	u64     addr;
	u32     length;
	u32     lkey;
};

with the difference that if lkey is not a MR, addr is the physical
address of the memory, not a dma_addr_t or virtual address.
