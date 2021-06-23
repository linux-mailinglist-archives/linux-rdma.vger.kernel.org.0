Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C49C93B132D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Jun 2021 07:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbhFWFZh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 23 Jun 2021 01:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229665AbhFWFZh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 23 Jun 2021 01:25:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 11E40610A0;
        Wed, 23 Jun 2021 05:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624425800;
        bh=OFqdMRZSiIQvLVLduSpuTOtW8IYIbvv1f7+uzGkqC3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Fu/asISaSJ9QJS6zK75gbfB07pIamtFSKaPtxURtGmYvtJ6uZG4WbroV/QBx0G50m
         zKKvUpGTva2hw3PVEaYqo3Yw9UpuJaEHhrpLULlXrliau6zUeffTom1K+LKqEqD16R
         wT+BsDvpoUS47oX6ZiZ6SWnm3LSgnvzgId/M4LR6on9g80uHJTMl3uPK4RTii0qYLR
         zSWtR5jKVplXUK+PWwyVnoY0172WjL1K3WIyEywt3/iBmNOl4nr8QBf1MoYyqR0z+f
         on/sPmySkgDwZvHyYc4tX0FSkc5BCbYwRLIBD6xTlbknOoE+ppcHHII3bkxDlmi2Yc
         XV9nIkJUtsabA==
Date:   Wed, 23 Jun 2021 08:23:17 +0300
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
Message-ID: <YNLFRa75KQ+BO4rB@unreal>
References: <cover.1624361199.git.leonro@nvidia.com>
 <29b80ff0c32675351c0a1b2f34e0181f463beb3d.1624361199.git.leonro@nvidia.com>
 <20210622131816.GA2371267@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210622131816.GA2371267@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 22, 2021 at 10:18:16AM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 22, 2021 at 02:39:42PM +0300, Leon Romanovsky wrote:
> 
> > diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> > index 0eb40025075f..a76ef6a6bac5 100644
> > +++ b/drivers/infiniband/core/umem.c
> > @@ -51,11 +51,11 @@ static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int d
> >  	struct scatterlist *sg;
> >  	unsigned int i;
> >  
> > -	if (umem->nmap > 0)
> > -		ib_dma_unmap_sg(dev, umem->sg_head.sgl, umem->sg_nents,
> > -				DMA_BIDIRECTIONAL);
> > +	if (dirty)
> > +		ib_dma_unmap_sgtable_attrs(dev, &umem->sg_head,
> > +					   DMA_BIDIRECTIONAL, 0);
> >  
> > -	for_each_sg(umem->sg_head.sgl, sg, umem->sg_nents, i)
> > +	for_each_sgtable_dma_sg(&umem->sg_head, sg, i)
> >  		unpin_user_page_range_dirty_lock(sg_page(sg),
> >  			DIV_ROUND_UP(sg->length, PAGE_SIZE), make_dirty);
> 
> This isn't right, can't mix sg_page with a _dma_ API

Jason, why is that?

We use same pages that were passed to __sg_alloc_table_from_pages() in __ib_umem_get().

Thanks

> 
> Jason
