Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B74042A69CE
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 17:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgKDQbi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 4 Nov 2020 11:31:38 -0500
Received: from verein.lst.de ([213.95.11.211]:43309 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726944AbgKDQbi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 4 Nov 2020 11:31:38 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6C26768B02; Wed,  4 Nov 2020 17:31:35 +0100 (CET)
Date:   Wed, 4 Nov 2020 17:31:35 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 2/5] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201104163135.GA15840@lst.de>
References: <20201104095052.1222754-1-hch@lst.de> <20201104095052.1222754-3-hch@lst.de> <20201104134241.GP36674@ziepe.ca> <20201104140108.GA5674@lst.de> <20201104155255.GR36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104155255.GR36674@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Nov 04, 2020 at 11:52:55AM -0400, Jason Gunthorpe wrote:
> It could work, I think a resonable ULP API would be to have some
> 
>  rdma_fill_ib_sge_from_sgl()
>  rdma_map_sge_single()
>  etc etc
> 
> ie instead of wrappering the DMA API as-is we have a new API that
> directly builds the ib_sge. It always fills the local_dma_lkey from
> the pd, so it knows it is doing DMA from local kernel memory.

Yeah.

> Logically SW devices then have a local_dma_lkey MR that has an IOVA of
> the CPU physical address space, not the DMA address space as HW
> devices have. The ib_sge builders can know this detail and fill in
> addr from either a cpu phyical or a dma map.

I don't think the builders are the right place to do it - it really
should to be in the low-level drivers for a bunch of reasons:

 1) this avoids doing the dma_map when no DMA is performed, e.g. for
    mlx5 when send data is in the extended WQE
 2) to deal with the fact that dma mapping reduces the number of SGEs.
    When the system uses a modern IOMMU we'll always end up with a
    single IOVA range no matter how many pages were mapped originally.
    This means any MR process can actually be consolidated to use
    a single SGE with the local lkey.

Note that 2 implies a somewhat more complicated API, where the ULP
attempts to create a MR, but the core/driver will tell it that it didn't
need a MR at all.
