Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A56212A8475
	for <lists+linux-rdma@lfdr.de>; Thu,  5 Nov 2020 18:09:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgKERJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 5 Nov 2020 12:09:17 -0500
Received: from verein.lst.de ([213.95.11.211]:47930 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725862AbgKERJR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 5 Nov 2020 12:09:17 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id E09B768B02; Thu,  5 Nov 2020 18:09:14 +0100 (CET)
Date:   Thu, 5 Nov 2020 18:09:14 +0100
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
Message-ID: <20201105170914.GD7502@lst.de>
References: <20201105074205.1690638-1-hch@lst.de> <20201105074205.1690638-4-hch@lst.de> <20201105143415.GB36674@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201105143415.GB36674@ziepe.ca>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 05, 2020 at 10:34:15AM -0400, Jason Gunthorpe wrote:
> On Thu, Nov 05, 2020 at 08:42:02AM +0100, Christoph Hellwig wrote:
> > diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> > index 5f8fd7976034e0..661e4a22b3cb81 100644
> > +++ b/include/rdma/ib_verbs.h
> > @@ -3950,6 +3950,8 @@ static inline int ib_req_ncomp_notif(struct ib_cq *cq, int wc_cnt)
> >   */
> >  static inline int ib_dma_mapping_error(struct ib_device *dev, u64 dma_addr)
> >  {
> > +	if (!dev->dma_device)
> > +		return 0;
> 
> How about:
> 
> static inline bool ib_uses_virt_dma(struct ib_device *dev)
> {
> 	return IS_ENABLED(CONFIG_INFINIBAND_VIRT_DMA) && !dev->dma_device;
> }
> 
> Which is a a little more guidance that driver authors need to set this
> config symbol.

Sure, I'll do that.
