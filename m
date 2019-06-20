Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FB414D41F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbfFTQtL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 12:49:11 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:33778 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTQtL (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 12:49:11 -0400
Received: by mail-qk1-f196.google.com with SMTP id r6so2407472qkc.0
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 09:49:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=829lbkNVKVvO4IPRXGAwDfDwkNN3afdAsnYF+a2YEsM=;
        b=aJC5IbH09VqJ5L3x0Q2P/vdyGVj04jt+mOrx8MojMr34HRL9FTmxFEg2TQhHifyDZQ
         zJGpxBPdLE71kW8SpPaYQSQWCVmyOhq1uOAmmKBIEN1rx7yhd1GioZ2gCS8hKvWMwuGs
         Ec0/B4GH/O+G+7ljUgQ5LlaF/Bjjq3TqiBOS0/qgjrWpIrW2VurIj26fyeXJYmhMhTCo
         cMW7nwDNhlIjYLXWE1Eg9qDAte24DnQqGNVoJKhyKGoLtKGNEVDUKEx/5jgAMHSIBGBO
         8PMOE7Csa87nMhCTnW03D69d9h7ValFpBP7C4i9r5HRnKMQV1y5wzzjsye3BHTyIMbA9
         DqIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=829lbkNVKVvO4IPRXGAwDfDwkNN3afdAsnYF+a2YEsM=;
        b=hcEFn8w4ulunrwocMF+xregOz30Xfnwxc4iGrE8gbUCE5Pdd6zdOSjrjoVMsYdz7LB
         XzV3XAKOEWfGjkNZWMckp379E8hD4qYYt69HtRwY9TOZLFqfs8trTkVJJVk8uH2hooX5
         8q/r7BTTruPyN84XVxbL8GQVOBJXpcKbJIlAa3OF0oefRauXZU47mb4Qcls3bKshq+9H
         kQ97S3gvfmLcw0x0iPuc4zHkJsgmW8SRQ1WuTH/Oru0jbWotODQu3KpOtJqzSWhIHTZt
         8IzznvTL9ynVSJGl1pwiI9WfZRRxdxSb38nIa8Nql+9JqnfKUHxn8uBuBtVCHG/Zeqec
         PGow==
X-Gm-Message-State: APjAAAUHj+QGlAXW09WC3pqxyaJUQLxn8o0xZSEYUKwoSztUz99ziV4M
        TNtQYxtAnFA7SzJS3UOsDL4ZKg==
X-Google-Smtp-Source: APXvYqw7o+HXcNgbAT7Mxcu/N67Vdjqf/udIRQ32pWb17pSApuDTFWC8DfL+yTMaUbEhp4oKyoolPg==
X-Received: by 2002:ae9:ee17:: with SMTP id i23mr1814457qkg.401.1561049350327;
        Thu, 20 Jun 2019 09:49:10 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id u7sm94016qta.82.2019.06.20.09.49.09
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 09:49:09 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he0FJ-0005H9-BN; Thu, 20 Jun 2019 13:49:09 -0300
Date:   Thu, 20 Jun 2019 13:49:09 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-rdma@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Keith Busch <kbusch@kernel.org>,
        Stephen Bates <sbates@raithlin.com>
Subject: Re: [RFC PATCH 20/28] IB/core: Introduce API for initializing a RW
 ctx from a DMA address
Message-ID: <20190620164909.GC19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190620161240.22738-21-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620161240.22738-21-logang@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 10:12:32AM -0600, Logan Gunthorpe wrote:
> Introduce rdma_rw_ctx_dma_init() and rdma_rw_ctx_dma_destroy() which
> peform the same operation as rdma_rw_ctx_init() and
> rdma_rw_ctx_destroy() respectively except they operate on a DMA
> address and length instead of an SGL.
> 
> This will be used for struct page-less P2PDMA, but there's also
> been opinions expressed to migrate away from SGLs and struct
> pages in the RDMA APIs and this will likely fit with that
> effort.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
>  drivers/infiniband/core/rw.c | 74 ++++++++++++++++++++++++++++++------
>  include/rdma/rw.h            |  6 +++
>  2 files changed, 69 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
> index 32ca8429eaae..cefa6b930bc8 100644
> +++ b/drivers/infiniband/core/rw.c
> @@ -319,6 +319,39 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
>  }
>  EXPORT_SYMBOL(rdma_rw_ctx_init);
>  
> +/**
> + * rdma_rw_ctx_dma_init - initialize a RDMA READ/WRITE context from a
> + *	DMA address instead of SGL
> + * @ctx:	context to initialize
> + * @qp:		queue pair to operate on
> + * @port_num:	port num to which the connection is bound
> + * @addr:	DMA address to READ/WRITE from/to
> + * @len:	length of memory to operate on
> + * @remote_addr:remote address to read/write (relative to @rkey)
> + * @rkey:	remote key to operate on
> + * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
> + *
> + * Returns the number of WQEs that will be needed on the workqueue if
> + * successful, or a negative error code.
> + */
> +int rdma_rw_ctx_dma_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> +		u8 port_num, dma_addr_t addr, u32 len, u64 remote_addr,
> +		u32 rkey, enum dma_data_direction dir)

Why not keep the same basic signature here but replace the scatterlist
with the dma vec ?

> +{
> +	struct scatterlist sg;
> +
> +	sg_dma_address(&sg) = addr;
> +	sg_dma_len(&sg) = len;

This needs to fail if the driver is one of the few that require
struct page to work..

Really want I want to do is to have this new 'dma vec' pushed through
the RDMA APIs so we know that if a driver is using the dma vec
interface it is struct page free.

This is not so hard to do, as most drivers are already struct page
free, but is pretty much blocked on needing some way to go from the
block layer SGL world to the dma vec world that does not hurt storage
performance.

I am hoping that the biovec dma mapping that CH has talked about will
give the missing pieces.

FWIW, rdma is one of the places that is largely struct page free, and
has few problems to natively handle a 'dma vec' from top to bottom, so
I do like this approach.

Someone would have to look carefully at siw, rxe and hfi/qib to see
how they could continue to work with a dma vec, as they do actually
seem to need to kmap the data they are transferring. However, I
thought they were using custom dma ops these days, so maybe they just
encode a struct page in their dma vec and reject p2p entirely?

Jason
