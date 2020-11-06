Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07EF32A9781
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Nov 2020 15:18:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbgKFOSr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 6 Nov 2020 09:18:47 -0500
Received: from verein.lst.de ([213.95.11.211]:51756 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726010AbgKFOSr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 6 Nov 2020 09:18:47 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id CF4FA68B02; Fri,  6 Nov 2020 15:18:43 +0100 (CET)
Date:   Fri, 6 Nov 2020 15:18:43 +0100
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
Subject: Re: [PATCH 3/6] RDMA/core: remove use of dma_virt_ops
Message-ID: <20201106141843.GD23884@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-4-hch@lst.de> <20201105175253.GA35235@nvidia.com> <20201105175816.GH36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201105175816.GH36674@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 01:58:16PM -0400, Jason Gunthorpe wrote:
> > I noticed there were a couple of places expecting dma_device to be set
> > to !NULL:
> > 
> > drivers/infiniband/core/umem.c:                 dma_get_max_seg_size(device->dma_device), sg, npages,
> > drivers/nvme/host/rdma.c:       ctrl->ctrl.numa_node = dev_to_node(ctrl->device->dev->dma_device);
> 
> Don't know much about NUMA, but do you think the ib device setup
> should autocopy the numa node from the dma_device to the ib_device and
> this usage should just refer to the ib_device?

FYI, I ended up just lifting the ibdev_to_node from rds to ib_verbs.h.  That uses
the parent pointer in the ib_device and should generally work ok.  If not we can
improve іt as we now have a proper abstraction.
