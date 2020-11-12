Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D49702B021C
	for <lists+linux-rdma@lfdr.de>; Thu, 12 Nov 2020 10:40:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726969AbgKLJke (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 12 Nov 2020 04:40:34 -0500
Received: from verein.lst.de ([213.95.11.211]:42940 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725928AbgKLJke (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 12 Nov 2020 04:40:34 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1A9D367373; Thu, 12 Nov 2020 10:40:31 +0100 (CET)
Date:   Thu, 12 Nov 2020 10:40:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201112094030.GA19550@lst.de>
References: <20201106181941.1878556-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201106181941.1878556-1-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

ping?

On Fri, Nov 06, 2020 at 07:19:31PM +0100, Christoph Hellwig wrote:
> Hi Jason,
> 
> this series switches the RDMA core to opencode the special case of
> devices bypassing the DMA mapping in the RDMA ULPs.  The virt ops
> have caused a bit of trouble due to the P2P code node working with
> them due to the fact that we'd do two dma mapping iterations for a
> single I/O, but also are a bit of layering violation and lead to
> more code than necessary.
> 
> Tested with nvme-rdma over rxe.
> 
> Note that the rds changes are untested, as I could not find any
> simple rds test setup.
> 
> Changes since v2:
>  - simplify the INFINIBAND_VIRT_DMA dependencies
>  - add a ib_uses_virt_dma helper
>  - use ib_uses_virt_dma in nvmet-rdma to disable p2p for virt_dma devices
>  - use ib_dma_max_seg_size in umem
>  - stop using dmapool in rds
> 
> Changes since v1:
>  - disable software RDMA drivers for highmem configs
>  - update the PCI commit logs
---end quoted text---
