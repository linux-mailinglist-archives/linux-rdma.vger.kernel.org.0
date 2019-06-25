Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D225554C
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729977AbfFYRBs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 13:01:48 -0400
Received: from verein.lst.de ([213.95.11.211]:36441 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728664AbfFYRBs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 13:01:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id D3C0068B05; Tue, 25 Jun 2019 19:01:15 +0200 (CEST)
Date:   Tue, 25 Jun 2019 19:01:15 +0200
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
Message-ID: <20190625170115.GA9746@lst.de>
References: <20190620161240.22738-1-logang@deltatee.com> <20190624072752.GA3954@lst.de> <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com> <20190625072008.GB30350@lst.de> <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0f002bf-2b94-cd18-d18f-5d0b08311495@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 25, 2019 at 09:57:52AM -0600, Logan Gunthorpe wrote:
> > You assume all addressing is done by the PCI bus address.  If a device
> > is addressing its own BAR there is no reason to use the PCI bus address,
> > as it might have much more intelligent schemes (usually bar + offset).
> 
> Yes, that will be a bit tricky regardless of what we do.

At least right now it isn't at all.  I've implemented support for
a draft NVMe proposal for that, and it basically boils down to this
in the p2p path:

	addr = sg_phys(sg);

	if (page->pgmap->dev == ctrl->dev && HAS_RELATIVE_ADDRESSING)
		addr -= ctrl->cmb_start_addr;

		// set magic flag in the SGL
	} else {
		addr -= pgmap->pci_p2pdma_bus_offset;
	}

without the pagemap it would require a range compare instead, which
isn't all that hard either.

> >>> Also duplicating the whole block I/O stack, including hooks all over
> >>> the fast path is pretty much a no-go.
> >>
> >> There was very little duplicate code in the patch set. (Really just the
> >> mapping code). There are a few hooks, but in practice not that many if
> >> we ignore the WARN_ONs. We might be able to work to reduce this further.
> >> The main hooks are: when we skip bouncing, when we skip integrity prep,
> >> when we split, and when we map. And the patchset drops the PCI_P2PDMA
> >> hook when we map. So we're talking about maybe three or four extra ifs
> >> that would likely normally be fast due to the branch predictor.
> > 
> > And all of those add code to the block layer fast path.
> 
> If we can't add any ifs to the block layer, there's really nothing we
> can do.

That is not what I said.  Of course we can.  But we rather have a
really good reason.  And adding a parallel I/O path violating the
highlevel model is not one.

> So then we're committed to using struct page for P2P?

Only until we have a significantly better soltution.  And I think
using physical address in some form instead of pages is that,
adding a parallel path with dma_addr_t is not, it actually is worse
than the current code in many respects.
