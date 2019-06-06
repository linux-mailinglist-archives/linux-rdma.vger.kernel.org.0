Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 087A636C5A
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2019 08:36:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725782AbfFFGg1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Jun 2019 02:36:27 -0400
Received: from verein.lst.de ([213.95.11.211]:47385 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725267AbfFFGg1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Jun 2019 02:36:27 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 6DB8D68B05; Thu,  6 Jun 2019 08:36:01 +0200 (CEST)
Date:   Thu, 6 Jun 2019 08:36:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH] IB/iser: explicitly set shost max_segment_size
Message-ID: <20190606063600.GB27033@lst.de>
References: <20190606000209.26086-1-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190606000209.26086-1-sagi@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 05, 2019 at 05:02:09PM -0700, Sagi Grimberg wrote:
> if the lld does not explicitly sets this, scsi takes BLK_MAX_SEGMENT_SIZE
> and sets it using dma_set_max_seg_size(). In our case, this will affect
> all the rdma device consumers.
> 
> Fix it by setting shost max_segment_size according to the device
> capability.
> 
> Reported-by: Jason Gunthorpe <jgg@ziepe.ca>
> Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
> ---
> This goes on top of hch patchset:
> "properly communicate queue limits to the DMA layer"
> 
> Normally this should go through the rdma tree, so we can
> either get it through jens with hch patchset. Alternatively
> this is a fix that should go to rc anyways?

I don't think this make sense.

> 
>  drivers/infiniband/ulp/iser/iscsi_iser.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/infiniband/ulp/iser/iscsi_iser.c b/drivers/infiniband/ulp/iser/iscsi_iser.c
> index 56848232eb81..2984a366dd7d 100644
> --- a/drivers/infiniband/ulp/iser/iscsi_iser.c
> +++ b/drivers/infiniband/ulp/iser/iscsi_iser.c
> @@ -653,6 +653,7 @@ iscsi_iser_session_create(struct iscsi_endpoint *ep,
>  						   SHOST_DIX_GUARD_CRC);
>  		}
>  
> +		shost->max_segment_size = ib_dma_max_seg_size(ib_dev);
>  		if (!(ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG))
>  			shost->virt_boundary_mask = ~MASK_4K;

We only really need this settings in the IB_DEVICE_SG_GAPS_REG case,
as the segement size is unlimited on the PRP-like scheme used by the
other MR types anyway, and set as such by the block layer.  I.e.g this
should become:

 		if (ib_dev->attrs.device_cap_flags & IB_DEVICE_SG_GAPS_REG)
			shost->max_segment_size = ib_dma_max_seg_size(ib_dev);
		else
  			shost->virt_boundary_mask = ~MASK_4K;
