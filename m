Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 804AD4D499
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Jun 2019 19:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfFTRLI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 Jun 2019 13:11:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:47018 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726675AbfFTRLI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 20 Jun 2019 13:11:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id h21so3888460qtn.13
        for <linux-rdma@vger.kernel.org>; Thu, 20 Jun 2019 10:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=B/Z1xHhYAjAI7ioTCGgFoDOmi7PSKcfXMaUReB0Dr1o=;
        b=iDKiiByf/rCLVBiwQKacZOEFqluND5l/Q7B8xuyrYYiT8npctI6tkA6bd5Z3+X6WXJ
         7gP3l17z5AQNjEKoghc1QQGWYYTQhxhcX9yGx54PMvjgvEHZEh7JKLlg64yxdauLIkD6
         PlX1F93t1CtWxQ8kNNXs9JCH7/Ycn3pW7NdVjaUwoeBrG9xILQAk6iI0m+ngDTRaz0n2
         KHM4oMsjPmMO77I7PU4GywcSoyfCFebua5oLxUE6W85UfxNuyOXg7jsaASQUndU7XOUT
         zN203NLRIh3JOjlN2kSuwATpWhmPazDPI0SbRVShwbgeM2SVzNCO4ifAlBXeUKKBuJD+
         jaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=B/Z1xHhYAjAI7ioTCGgFoDOmi7PSKcfXMaUReB0Dr1o=;
        b=UJjGJF2sH2MeQw6N76sQ1A+wQb7s/Qs2HOVTnbXlWyt6vpYAqvBXsPFD1bcagXYk0J
         6qS9eFsOOhxrOEvD1MYvzimnqhxbk8hBx246FeL+bHwruVEEmPThbmU7VVf8LKZHOZcv
         3qQ1cuN89+h1bsZdptEF/BOOvtAkDlNFAsCKSLxalZUzDUH43QL7kS/2mdQRCHI0dyQJ
         KCUBqwkS0j7PaI87g33AoJzRyAhw1Yb/yZUtB8bZ/1oAYMip55+USananKzNnC+laLZ2
         /ZAcJpHruIxNet9oKN3DByImviO4xsyCIHdGvz/BWvmw64KDMabhB2cfjbjIeqyk5Dt9
         +BUw==
X-Gm-Message-State: APjAAAUrpF4k7L3QP304MT3F6WYIWk+kvmwyfTZ0XNIZCvb7N/sKlYTY
        NtHgKSLXzM0Dnpk5ywaaZZeBPg==
X-Google-Smtp-Source: APXvYqwc2iwZPScenX0v4jDBGu4RdLUTLz2n8sdXn8hwtd0G64nXQQ8UGnDbXfC6MHvJ9vTLmjr9lQ==
X-Received: by 2002:ac8:2e5d:: with SMTP id s29mr105147696qta.70.1561050666885;
        Thu, 20 Jun 2019 10:11:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id t29sm152221qtt.42.2019.06.20.10.11.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 20 Jun 2019 10:11:06 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1he0aX-0005SU-RR; Thu, 20 Jun 2019 14:11:05 -0300
Date:   Thu, 20 Jun 2019 14:11:05 -0300
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
Message-ID: <20190620171105.GD19891@ziepe.ca>
References: <20190620161240.22738-1-logang@deltatee.com>
 <20190620161240.22738-21-logang@deltatee.com>
 <20190620164909.GC19891@ziepe.ca>
 <f9186b2b-7737-965f-2dca-25e40e566e64@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f9186b2b-7737-965f-2dca-25e40e566e64@deltatee.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 20, 2019 at 10:59:44AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-20 10:49 a.m., Jason Gunthorpe wrote:
> > On Thu, Jun 20, 2019 at 10:12:32AM -0600, Logan Gunthorpe wrote:
> >> Introduce rdma_rw_ctx_dma_init() and rdma_rw_ctx_dma_destroy() which
> >> peform the same operation as rdma_rw_ctx_init() and
> >> rdma_rw_ctx_destroy() respectively except they operate on a DMA
> >> address and length instead of an SGL.
> >>
> >> This will be used for struct page-less P2PDMA, but there's also
> >> been opinions expressed to migrate away from SGLs and struct
> >> pages in the RDMA APIs and this will likely fit with that
> >> effort.
> >>
> >> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> >>  drivers/infiniband/core/rw.c | 74 ++++++++++++++++++++++++++++++------
> >>  include/rdma/rw.h            |  6 +++
> >>  2 files changed, 69 insertions(+), 11 deletions(-)
> >>
> >> diff --git a/drivers/infiniband/core/rw.c b/drivers/infiniband/core/rw.c
> >> index 32ca8429eaae..cefa6b930bc8 100644
> >> +++ b/drivers/infiniband/core/rw.c
> >> @@ -319,6 +319,39 @@ int rdma_rw_ctx_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp, u8 port_num,
> >>  }
> >>  EXPORT_SYMBOL(rdma_rw_ctx_init);
> >>  
> >> +/**
> >> + * rdma_rw_ctx_dma_init - initialize a RDMA READ/WRITE context from a
> >> + *	DMA address instead of SGL
> >> + * @ctx:	context to initialize
> >> + * @qp:		queue pair to operate on
> >> + * @port_num:	port num to which the connection is bound
> >> + * @addr:	DMA address to READ/WRITE from/to
> >> + * @len:	length of memory to operate on
> >> + * @remote_addr:remote address to read/write (relative to @rkey)
> >> + * @rkey:	remote key to operate on
> >> + * @dir:	%DMA_TO_DEVICE for RDMA WRITE, %DMA_FROM_DEVICE for RDMA READ
> >> + *
> >> + * Returns the number of WQEs that will be needed on the workqueue if
> >> + * successful, or a negative error code.
> >> + */
> >> +int rdma_rw_ctx_dma_init(struct rdma_rw_ctx *ctx, struct ib_qp *qp,
> >> +		u8 port_num, dma_addr_t addr, u32 len, u64 remote_addr,
> >> +		u32 rkey, enum dma_data_direction dir)
> > 
> > Why not keep the same basic signature here but replace the scatterlist
> > with the dma vec ?
> 
> Could do. At the moment, I had no need for dma_vec in this interface.

I think that is because you only did nvme not srp/iser :)

> >> +{
> >> +	struct scatterlist sg;
> >> +
> >> +	sg_dma_address(&sg) = addr;
> >> +	sg_dma_len(&sg) = len;
> > 
> > This needs to fail if the driver is one of the few that require
> > struct page to work..
> 
> Yes, right. Currently P2PDMA checks for the use of dma_virt_ops. And
> that probably should also be done here. But is that sufficient? You're
> probably right that it'll take an audit of the RDMA tree to sort that out.

For this purpose I'd be fine if you added a flag to the struct
ib_device_ops that is set on drivers that we know are OK.. We can make
that list bigger over time.

> > This is not so hard to do, as most drivers are already struct page
> > free, but is pretty much blocked on needing some way to go from the
> > block layer SGL world to the dma vec world that does not hurt storage
> > performance.
> 
> Maybe I can end up helping with that if it helps push the ideas here
> through. (And assuming people think it's an acceptable approach for the
> block-layer side of things).

Let us hope for a clear decision then

Jason
