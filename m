Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279FF25B9FE
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Sep 2020 07:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725967AbgICFIQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Sep 2020 01:08:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725943AbgICFIP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Sep 2020 01:08:15 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B6531207EA;
        Thu,  3 Sep 2020 05:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599109695;
        bh=RkCuBgxsj4U86Xf27obV3rYpZ6Ct/jXvbhhecSXUANE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FJ4cN0tOkbNeqmeronPG/Mo8MDp003+/yUod1VKBV+VbMfGAfbgBye+X4j6S7Xs1L
         BW4AtXPQJKGM3qwAliEmS+89LC4iEytZXGWlOwLdwb/r+AkfE8wA59iVuMvxMNCGqr
         zCKtAn5tFKMsE0WCAuuBIwtQZUQ08+1okbo2tjy4=
Date:   Thu, 3 Sep 2020 08:08:11 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 03/10] RDMA/mlx5: Issue FW command to
 destroy SRQ on reentry
Message-ID: <20200903050811.GO59010@unreal>
References: <20200830084010.102381-1-leon@kernel.org>
 <20200830084010.102381-4-leon@kernel.org>
 <20200903003115.GA1480685@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903003115.GA1480685@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 02, 2020 at 09:31:15PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 30, 2020 at 11:40:03AM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The HW release can fail and leave the system in limbo state,
> > where SRQ is removed from the table, but can't be destroyed later.
> > In every reentry, the initial xa_erase_irq() check will fail.
> >
> > Rewrite the erase logic to keep index, but don't store the entry
> > itself. By doing it, we can safely reinsert entry back in the case
> > of destroy failure and be safe from any xa_store_irq() error.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/mlx5/srq_cmd.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/srq_cmd.c b/drivers/infiniband/hw/mlx5/srq_cmd.c
> > index 37aaacebd3f2..c6d807f04d9d 100644
> > +++ b/drivers/infiniband/hw/mlx5/srq_cmd.c
> > @@ -596,13 +596,22 @@ void mlx5_cmd_destroy_srq(struct mlx5_ib_dev *dev, struct mlx5_core_srq *srq)
> >  	struct mlx5_core_srq *tmp;
> >  	int err;
> >
> > -	tmp = xa_erase_irq(&table->array, srq->srqn);
> > -	if (!tmp || tmp != srq)
> > +	/* Delete entry, but leave index occupied */
> > +	tmp = xa_store_irq(&table->array, srq->srqn, NULL, 0);
> > +	if (WARN_ON(!tmp || tmp != srq))
> >  		return;
>
> This isn't an allocating xarray:
>
> 	xa_init_flags(&table->array, XA_FLAGS_LOCK_IRQ);
>
> So storing NULL actually does delete the entry and clean up the memory
> and the store below could fail.
>
> I think this should be written as
>
>    xa_cmpxchg_irq(&table->array, srq->srqn, srq, XA_ZERO_ENTRY, 0);
>
> And the undo below would be
>
>    xa_cmpxchg_irq(&table->array, srq->srqn, XA_ZERO_ENTRY, srq 0);

Thanks, it is better.

>
> > +	xa_erase_irq(&table->array, srq->srqn);
>
> And this is racy since the FW could have reallocated the same srqn and
> already set it in the xarray.

Not in mlx5 devices, srqn is allocated in round-robin order.

>
> It needs to be xa_release_irq(), which looks like it needs to be
> added to match xa_reserve_irq()

We can't call to xa_lock_irq*() while issuing FW commands.

Thanks

>
> Jason
