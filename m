Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42A8216C8B
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jul 2020 14:10:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726745AbgGGMKC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 7 Jul 2020 08:10:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:59316 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726540AbgGGMKC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 7 Jul 2020 08:10:02 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3EE73206F6;
        Tue,  7 Jul 2020 12:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594123801;
        bh=cBgTShe+zhi8j3hGvyyQvOHtctmPMV6cbbie5P26Rso=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vpSn2UuyBqFLrMyL4Yo9I21sUZk5fpipuXclJGW2jde/P0CP2aiBHEisTyCJAJR4s
         U8Qq0SZLle220sWC9F5WsNqXcARTHsr5n/QpcGycDJDK6Zbtd96pNckIOkfIVtHiPN
         Iy3NReQOuULJmW+RG39UFe+xiAlTsCKkATzKllhM=
Date:   Tue, 7 Jul 2020 15:09:58 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH rdma-rc 1/3] RDMA/mlx5: Use xa_lock_irqsave when access
 to SRQ table
Message-ID: <20200707120958.GK207186@unreal>
References: <20200707110612.882962-1-leon@kernel.org>
 <20200707110612.882962-2-leon@kernel.org>
 <20200707114303.GY25301@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200707114303.GY25301@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jul 07, 2020 at 08:43:03AM -0300, Jason Gunthorpe wrote:
> On Tue, Jul 07, 2020 at 02:06:10PM +0300, Leon Romanovsky wrote:
> > Fixes: b02a29eb8841 ("mlx5: Convert mlx5_srq_table to XArray")
>
> This didn't introduce the bug, when things were converted to xarray it
> already had the wrong spinlock type.
>
> I'm surprised this is only been found now since it has been wrong for
> years. Did something else change?

I checked internal bug tracker to see when this bug was discovered. It
looks like ennoblement of more debug kernel config options by default
helped to find it.

>
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/mlx5/srq_cmd.c | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
> > index 6f5eadc4d183..be0e5469dad0 100644
> > +++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
> > @@ -82,12 +82,13 @@ struct mlx5_core_srq *mlx5_cmd_get_srq(struct mlx5_ib_dev *dev, u32 srqn)
> >  {
> >  	struct mlx5_srq_table *table = &dev->srq_table;
> >  	struct mlx5_core_srq *srq;
> > +	unsigned long flags;
> >
> > -	xa_lock(&table->array);
> > +	xa_lock_irqsave(&table->array, flags);
> >  	srq = xa_load(&table->array, srqn);
> >  	if (srq)
> >  		refcount_inc(&srq->common.refcount);
> > -	xa_unlock(&table->array);
> > +	xa_unlock_irqrestore(&table->array, flags);
>
> This and other places can just be xa_lock_irq as we are not in an atomic
> context here.

ok, let's change for the clarity.

Thanks
