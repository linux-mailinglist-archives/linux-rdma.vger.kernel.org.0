Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 997CE3B1ADA
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 15:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbhFWNPT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 09:15:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:39396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230234AbhFWNPH (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 09:15:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B27A661075;
        Wed, 23 Jun 2021 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624453970;
        bh=keklxYVpJ0fp2JdHytWXvpu0copjsSh0//zqfv8mzYI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ksofQ/bXbDZp+dmchRx5cnCRIQJ+NtE0a1ABcGwnW4UsEM/Ac7qxcGalSv592lr4d
         MiT/psyxsbgAuG4ZIohlhb4IF19z9+c6WNQlaqQaj0MuSeZcfh+ZdqacNaLrWtg20w
         FEXLLAvHFjsd4LtV9dy6tSDuMqezOmuNEh71SNcCTX7ESZLdkVSZwaQX5sJgGeMeok
         C3kBgE6l/my3hTEjsw6wvo4kUldnv3OIJCJGKn7nNGdKbY7sUaxiN+MLXHgqTrmC6k
         G5/EbGQgO2EeT01EaayWb2oHd5tlJhJXY4AkgNIKmSVkpcokshSQGAMSPm8IA7vUuz
         9V+XMGGMcPKvQ==
Date:   Wed, 23 Jun 2021 16:12:46 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Maor Gottlieb <maorg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>,
        Yishai Hadas <yishaih@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
Subject: Re: [PATCH rdma-next 2/2] RDMA: Use dma_map_sgtable for map umem
 pages
Message-ID: <YNMzTs0xOPWVXmYE@unreal>
References: <cover.1624361199.git.leonro@nvidia.com>
 <29b80ff0c32675351c0a1b2f34e0181f463beb3d.1624361199.git.leonro@nvidia.com>
 <20210622131816.GA2371267@nvidia.com>
 <YNLFRa75KQ+BO4rB@unreal>
 <20210623121005.GK2371267@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623121005.GK2371267@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jun 23, 2021 at 09:10:05AM -0300, Jason Gunthorpe wrote:
> On Wed, Jun 23, 2021 at 08:23:17AM +0300, Leon Romanovsky wrote:
> > On Tue, Jun 22, 2021 at 10:18:16AM -0300, Jason Gunthorpe wrote:
> > > On Tue, Jun 22, 2021 at 02:39:42PM +0300, Leon Romanovsky wrote:
> > > 
> > > > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > > > index 0eb40025075f..a76ef6a6bac5 100644
> > > > +++ b/drivers/infiniband/core/umem.c
> > > > @@ -51,11 +51,11 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
> > > >  	struct scatterlist *sg;
> > > >  	unsigned int i;
> > > >  
> > > > -	if (umem->nmap > 0)
> > > > -		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
> > > > -				DMA_BIDIRECTIONAL);
> > > > +	if (dirty)
> > > > +		ib_dma_unmap_sgtable_attrs(dev, &umem->sg_head,
> > > > +					   DMA_BIDIRECTIONAL, 0);
> > > >  
> > > > -	for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
> > > > +	for_each_sgtable_dma_sg(&umem->sg_head, sg, i)
> > > >  		unpin_user_page_range_dirty_lock(sg_page(sg),
> > > >  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> > > 
> > > This isn't right, can't mix sg_page with a _dma_ API
> > 
> > Jason, why is that?
> > 
> > We use same pages that were passed to __sg_alloc_table_from_pages() in __ib_umem_get().
> 
> A sgl has two lists inside it a 'dma' list and a 'page' list, they are
> not the same length and not interchangable.
> 
> If you use for_each_sgtable_dma_sg() then you iterate over the 'dma'
> list and have to use 'dma' accessors
> 
> If you use for_each_sgtable_sg() then you iterate over the 'page' list
> and have to use 'page' acessors
> 
> Mixing dma iteration with page accessors or vice-versa, like above, is
> always a bug.
> 
> You can see it alos because the old code used umem->sg_nents which is
> the CPU list length while this new code is using the dma list length.

Ohh, I see difference between types now, thank you for the explanation,
will consult with Maor once he returns next week to the office.

Thanks

> 
> Jason
