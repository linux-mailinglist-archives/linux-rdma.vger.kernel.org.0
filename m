Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 170C92A8473
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730246AbgKERIT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:08:19 -0500
Received: from verein.lst.de ([213.95.11.211]:47919 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726801AbgKERIT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:08:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E83EA68B02; Thu,  5 Nov 2020 18:08:16 +0100 (CET)
Date:   Thu, 5 Nov 2020 18:08:16 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 4/6] PCI/P2PDMA: Remove the DMA_VIRT_OPS hacks
Message-ID: <20201105170816.GC7502@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-5-hch@lst.de> <20201105143418.GA4142106@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105143418.GA4142106@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 10:34:18AM -0400, Jason Gunthorpe wrote:
> The check is removed here, but I didn't see a matching check added to
> the IB side? Something like:
> 
> static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
> 			  u32 sg_cnt, enum dma_data_direction dir)
> {
> 	if (is_pci_p2pdma_page(sg_page(sg))) {
> 		if (ib_uses_virt_dma(dev))
> 			return 0;
> 		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
> 	}
> 	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
> }

We should never get a P2P page into the rdma_rw_map_sg or other ib_dma*
routines for the software drivers, as their struct devices don't connect
to a PCІ device underneath, and thus no valid P2P distance can be
retourned.  That being said IFF we want to implement P2P for those
we'd need somethign like the above check, except that we still need
to cal ib_dma_map_sg, i.e.:

static int rdma_rw_map_sg(struct ib_device *dev, struct scatterlist *sg,
 			  u32 sg_cnt, enum dma_data_direction dir)
{
	if (is_pci_p2pdma_page(sg_page(sg)) && !ib_uses_virt_dma(dev))
		return pci_p2pdma_map_sg(dev->dma_device, sg, sg_cnt, dir);
	return ib_dma_map_sg(dev, sg, sg_cnt, dir);
}
