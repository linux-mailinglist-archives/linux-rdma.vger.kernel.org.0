Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE64C52446
	for <lists+linux-rdma@lfdr.de>; Tue, 25 Jun 2019 09:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728078AbfFYHUm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 25 Jun 2019 03:20:42 -0400
Received: from verein.lst.de ([213.95.11.211]:60232 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726419AbfFYHUl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 25 Jun 2019 03:20:41 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4CE0068B02; Tue, 25 Jun 2019 09:20:09 +0200 (CEST)
Date:   Tue, 25 Jun 2019 09:20:08 +0200
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
Message-ID: <20190625072008.GB30350@lst.de>
References: <20190620161240.22738-1-logang@deltatee.com> <20190624072752.GA3954@lst.de> <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <558a27ba-e7c9-9d94-cad0-377b8ee374a6@deltatee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 24, 2019 at 10:07:56AM -0600, Logan Gunthorpe wrote:
> > For one passing a dma_addr_t through the block layer is a layering
> > violation, and one that I think will also bite us in practice.
> > The host physical to PCIe bus address mapping can have offsets, and
> > those offsets absolutely can be different for differnet root ports.
> > So with your caller generated dma_addr_t everything works fine with
> > a switched setup as the one you are probably testing on, but on a
> > sufficiently complicated setup with multiple root ports it can break.
> 
> I don't follow this argument. Yes, I understand PCI Bus offsets and yes
> I understand that they only apply beyond the bus they're working with.
> But this isn't *that* complicated and it should be the responsibility of
> the P2PDMA code to sort out and provide a dma_addr_t for. The dma_addr_t
> that's passed through the block layer could be a bus address or it could
> be the result of a dma_map_* request (if the transaction is found to go
> through an RC) depending on the requirements of the devices being used.

You assume all addressing is done by the PCI bus address.  If a device
is addressing its own BAR there is no reason to use the PCI bus address,
as it might have much more intelligent schemes (usually bar + offset).
> 
> > Also duplicating the whole block I/O stack, including hooks all over
> > the fast path is pretty much a no-go.
> 
> There was very little duplicate code in the patch set. (Really just the
> mapping code). There are a few hooks, but in practice not that many if
> we ignore the WARN_ONs. We might be able to work to reduce this further.
> The main hooks are: when we skip bouncing, when we skip integrity prep,
> when we split, and when we map. And the patchset drops the PCI_P2PDMA
> hook when we map. So we're talking about maybe three or four extra ifs
> that would likely normally be fast due to the branch predictor.

And all of those add code to the block layer fast path.
