Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF3ED2A9391
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 11:01:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgKFKBT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 05:01:19 -0500
Received: from verein.lst.de ([213.95.11.211]:50944 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbgKFKBT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Nov 2020 05:01:19 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 96D3468B02; Fri,  6 Nov 2020 11:01:15 +0100 (CET)
Date:   Fri, 6 Nov 2020 11:01:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201106100115.GA5951@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-4-hch@lst.de> <20201105175253.GA35235@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105175253.GA35235@nvidia.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 01:52:53PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> > @@ -1341,7 +1322,14 @@ int ib_register_device(struct ib_device *device, const char *name,
> >  	if (ret)
> >  		return ret;
> >  
> > -	setup_dma_device(device, dma_device);
> > +	/*
> > +	 * If the caller does not provide a DMA capable device then the IB core
> > +	 * will set up ib_sge and scatterlist structures that stash the kernel
> > +	 * virtual address into the address field.
> > +	 */
> > +	device->dma_device = dma_device;
> > +	WARN_ON(dma_device && !dma_device->dma_parms);
> 
> I noticed there were a couple of places expecting dma_device to be set
> to !NULL:
> 
> drivers/infiniband/core/umem.c:                 dma_get_max_seg_size(device->dma_device), sg, npages,

This needs to use ib_dma_max_seg_size.

> drivers/nvme/host/rdma.c:       ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);

> Don't know much about NUMA, but do you think the ib device setup
> should autocopy the numa node from the dma_device to the ib_device and
> this usage should just refer to the ib_device?

IMHO we could add a ib_device_get_numa_node API or something like that,
which uses dev_to_node on the DMA device is present and otherwise returns
-1.  If needed we can refine that later.

> net/rds/ib.c:                                              device->dma_device,
> 
> No sure what to do about RDS..

Yikes, this is completely broken.  We either need a wrapper for the
dma_pool API, or get rid of it.  Let me dig into that.
