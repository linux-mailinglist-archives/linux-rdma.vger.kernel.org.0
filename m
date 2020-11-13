Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197A52B1786
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Nov 2020 09:50:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726176AbgKMIu2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 13 Nov 2020 03:50:28 -0500
Received: from verein.lst.de ([213.95.11.211]:46410 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726160AbgKMIu2 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 13 Nov 2020 03:50:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1918467357; Fri, 13 Nov 2020 09:50:23 +0100 (CET)
Date:   Fri, 13 Nov 2020 09:50:23 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bernard Metzler <bmt@zurich.ibm.com>,
        Zhu Yanjun <yanjunz@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        linux-rdma@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-pci@vger.kernel.org, iommu@lists.linux-foundation.org
Subject: Re: remove dma_virt_ops v2
Message-ID: <20201113085023.GA17412@lst.de>
References: <20201106181941.1878556-1-hch@lst.de> <20201112165935.GA932629@nvidia.com> <20201112170956.GA18813@lst.de> <20201112173906.GT244516@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201112173906.GT244516@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 12, 2020 at 01:39:06PM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 12, 2020 at 06:09:56PM +0100, Christoph Hellwig wrote:
> > On Thu, Nov 12, 2020 at 12:59:35PM -0400, Jason Gunthorpe wrote:
> > >  RMDA/sw: Don't allow drivers using dma_virt_ops on highmem configs
> > 
> > I think this one actually is something needed in 5.10 and -stable.
> 
> Done, I added a
> 
> Fixes: 551199aca1c3 ("lib/dma-virt: Add dma_virt_ops")

Note that the drivers had open coded versions of this earlier.  I think
this goes back to the addition of the qib driver which is now gone
or the addition of the hfi1 or rxe drivers for something that still
matters.
