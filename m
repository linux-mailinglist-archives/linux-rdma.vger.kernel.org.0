Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 784F750374
	for <lists+linux-rdma@lfdr.de>; Mon, 24 Jun 2019 09:32:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbfFXHb7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 24 Jun 2019 03:31:59 -0400
Received: from verein.lst.de ([213.95.11.211]:53082 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726623AbfFXHb7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 24 Jun 2019 03:31:59 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 03A7A68B02; Mon, 24 Jun 2019 09:31:27 +0200 (CEST)
Date:   Mon, 24 Jun 2019 09:31:26 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-rdma <linux-rdma@vger.kernel.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 00/28] Removing struct page from P2PDMA
Message-ID: <20190624073126.GB3954@lst.de>
References: <20190620161240.22738-1-logang@deltatee.com> <CAPcyv4ijztOK1FUjLuFing7ps4LOHt=6z=eO=98HHWauHA+yog@mail.gmail.com> <20190620193353.GF19891@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620193353.GF19891@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 04:33:53PM -0300, Jason Gunthorpe wrote:
> > My primary concern with this is that ascribes a level of generality
> > that just isn't there for peer-to-peer dma operations. "Peer"
> > addresses are not "DMA" addresses, and the rules about what can and
> > can't do peer-DMA are not generically known to the block layer.
> 
> ?? The P2P infrastructure produces a DMA bus address for the
> initiating device that is is absolutely a DMA address. There is some
> intermediate CPU centric representation, but after mapping it is the
> same as any other DMA bus address.
> 
> The map function can tell if the device pair combination can do p2p or
> not.

At the PCIe level there is no such thing as a DMA address, it all
is bus address with MMIO and DMA in the same address space (without
that P2P would have not chance of actually working obviously).  But
that bus address space is different per "bus" (which would be an
root port in PCIe), and we need to be careful about that.
