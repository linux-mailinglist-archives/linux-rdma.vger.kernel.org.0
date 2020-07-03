Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA550213418
	for <lists+linux-rdma@lfdr.de>; Fri,  3 Jul 2020 08:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725949AbgGCGZR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 3 Jul 2020 02:25:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:40184 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbgGCGZR (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 3 Jul 2020 02:25:17 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80FC3204EA;
        Fri,  3 Jul 2020 06:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593757516;
        bh=gJc1Af4y6gYB29zIO6ZLhOKgKRpYSplo2jZ/ZDfnz1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GH++h8TgYjysGf1qDwYQUKo8Uam7UcAtKaaJ99S/aLTbApvXAnzLm9aOL85BR4zh0
         ZSOcWMMJqhFfVHYAteGf6MaRMTWx5gcBUQDCtHxLI70Z6hPtWDLJHps4ZTde7AUukQ
         jUM8sn8qPCO277UjfkaJZpg8WYoWj0yeV5bSHj6c=
Date:   Fri, 3 Jul 2020 09:25:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 1/2] RDMA: Clean ib_alloc_xrcd() and reuse
 it to allocate XRC domain
Message-ID: <20200703062512.GF4837@unreal>
References: <20200623111531.1227013-1-leon@kernel.org>
 <20200623111531.1227013-2-leon@kernel.org>
 <20200702182724.GA744415@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702182724.GA744415@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jul 02, 2020 at 03:27:24PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 23, 2020 at 02:15:30PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > ib_alloc_xrcd already does the required initialization, so move
> > the mlx5 driver and uverbs to call it and save some code duplication,
> > while cleaning the function argument lists of that function.
> >
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/uverbs_cmd.c | 12 +++---------
> >  drivers/infiniband/core/verbs.c      | 19 +++++++++++++------
> >  drivers/infiniband/hw/mlx5/main.c    | 24 ++++++++----------------
> >  include/rdma/ib_verbs.h              | 22 ++++++++++++----------
> >  4 files changed, 36 insertions(+), 41 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index 557644dcc923..68c9a0210220 100644
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -614,17 +614,11 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
> >  	}
> >
> >  	if (!xrcd) {
> > -		xrcd = ib_dev->ops.alloc_xrcd(ib_dev, &attrs->driver_udata);
> > +		xrcd = ib_alloc_xrcd_user(ib_dev, inode, &attrs->driver_udata);
> >  		if (IS_ERR(xrcd)) {
> >  			ret = PTR_ERR(xrcd);
> >  			goto err;
> >  		}
> > -
> > -		xrcd->inode   = inode;
> > -		xrcd->device  = ib_dev;
> > -		atomic_set(&xrcd->usecnt, 0);
> > -		mutex_init(&xrcd->tgt_qp_mutex);
> > -		INIT_LIST_HEAD(&xrcd->tgt_qp_list);
> >  		new_xrcd = 1;
> >  	}
> >
> > @@ -663,7 +657,7 @@ static int ib_uverbs_open_xrcd(struct uverbs_attr_bundle *attrs)
> >  	}
> >
> >  err_dealloc_xrcd:
> > -	ib_dealloc_xrcd(xrcd, uverbs_get_cleared_udata(attrs));
> > +	ib_dealloc_xrcd_user(xrcd, uverbs_get_cleared_udata(attrs));
> >
> >  err:
> >  	uobj_alloc_abort(&obj->uobject, attrs);
> > @@ -701,7 +695,7 @@ int ib_uverbs_dealloc_xrcd(struct ib_uobject *uobject, struct ib_xrcd *xrcd,
> >  	if (inode && !atomic_dec_and_test(&xrcd->usecnt))
> >  		return 0;
> >
> > -	ret = ib_dealloc_xrcd(xrcd, &attrs->driver_udata);
> > +	ret = ib_dealloc_xrcd_user(xrcd, &attrs->driver_udata);
> >
> >  	if (ib_is_destroy_retryable(ret, why, uobject)) {
> >  		atomic_inc(&xrcd->usecnt);
> > diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> > index d70771caf534..d66a0ad62077 100644
> > +++ b/drivers/infiniband/core/verbs.c
> > @@ -2289,17 +2289,24 @@ int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
> >  }
> >  EXPORT_SYMBOL(ib_detach_mcast);
> >
> > -struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
> > +/**
> > + * ib_alloc_xrcd_user - Allocates an XRC domain.
> > + * @device: The device on which to allocate the XRC domain.
> > + * @inode: inode to connect XRCD
> > + * @udata: Valid user data or NULL for kernel object
> > + */
> > +struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
> > +				   struct inode *inode, struct ib_udata *udata)
> >  {
> >  	struct ib_xrcd *xrcd;
> >
> >  	if (!device->ops.alloc_xrcd)
> >  		return ERR_PTR(-EOPNOTSUPP);
> >
> > -	xrcd = device->ops.alloc_xrcd(device, NULL);
> > +	xrcd = device->ops.alloc_xrcd(device, udata);
> >  	if (!IS_ERR(xrcd)) {
> >  		xrcd->device = device;
> > -		xrcd->inode = NULL;
> > +		xrcd->inode = inode;
> >  		atomic_set(&xrcd->usecnt, 0);
> >  		mutex_init(&xrcd->tgt_qp_mutex);
> >  		INIT_LIST_HEAD(&xrcd->tgt_qp_list);
> > @@ -2307,9 +2314,9 @@ struct ib_xrcd *__ib_alloc_xrcd(struct ib_device *device, const char *caller)
> >
> >  	return xrcd;
> >  }
> > -EXPORT_SYMBOL(__ib_alloc_xrcd);
> > +EXPORT_SYMBOL(ib_alloc_xrcd_user);
> >
> > -int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
> > +int ib_dealloc_xrcd_user(struct ib_xrcd *xrcd, struct ib_udata *udata)
> >  {
> >  	struct ib_qp *qp;
> >  	int ret;
> > @@ -2327,7 +2334,7 @@ int ib_dealloc_xrcd(struct ib_xrcd *xrcd, struct ib_udata *udata)
> >
> >  	return xrcd->device->ops.dealloc_xrcd(xrcd, udata);
> >  }
> > -EXPORT_SYMBOL(ib_dealloc_xrcd);
> > +EXPORT_SYMBOL(ib_dealloc_xrcd_user);
> >
> >  /**
> >   * ib_create_wq - Creates a WQ associated with the specified protection
> > diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> > index 47a0c091eea5..46c596a855e7 100644
> > +++ b/drivers/infiniband/hw/mlx5/main.c
> > @@ -5043,27 +5043,17 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
> >  	if (ret)
> >  		goto err_create_cq;
> >
> > -	devr->x0 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
> > +	devr->x0 = ib_alloc_xrcd(&dev->ib_dev);
> >  	if (IS_ERR(devr->x0)) {
> >  		ret = PTR_ERR(devr->x0);
> >  		goto error2;
> >  	}
> > -	devr->x0->device = &dev->ib_dev;
> > -	devr->x0->inode = NULL;
> > -	atomic_set(&devr->x0->usecnt, 0);
> > -	mutex_init(&devr->x0->tgt_qp_mutex);
> > -	INIT_LIST_HEAD(&devr->x0->tgt_qp_list);
> >
> > -	devr->x1 = mlx5_ib_alloc_xrcd(&dev->ib_dev, NULL);
> > +	devr->x1 = ib_alloc_xrcd(&dev->ib_dev);
> >  	if (IS_ERR(devr->x1)) {
> >  		ret = PTR_ERR(devr->x1);
> >  		goto error3;
> >  	}
> > -	devr->x1->device = &dev->ib_dev;
> > -	devr->x1->inode = NULL;
> > -	atomic_set(&devr->x1->usecnt, 0);
> > -	mutex_init(&devr->x1->tgt_qp_mutex);
> > -	INIT_LIST_HEAD(&devr->x1->tgt_qp_list);
> >
> >  	memset(&attr, 0, sizeof(attr));
> >  	attr.attr.max_sge = 1;
> > @@ -5125,13 +5115,14 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
> >  error6:
> >  	kfree(devr->s1);
> >  error5:
> > +	atomic_dec(&devr->s0->ext.xrc.xrcd->usecnt);
> >  	mlx5_ib_destroy_srq(devr->s0, NULL);
> >  err_create:
> >  	kfree(devr->s0);
> >  error4:
> > -	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
> > +	ib_dealloc_xrcd(devr->x1);
> >  error3:
> > -	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
> > +	ib_dealloc_xrcd(devr->x0);
> >  error2:
> >  	mlx5_ib_destroy_cq(devr->c0, NULL);
> >  err_create_cq:
> > @@ -5149,10 +5140,11 @@ static void destroy_dev_resources(struct mlx5_ib_resources *devr)
> >
> >  	mlx5_ib_destroy_srq(devr->s1, NULL);
> >  	kfree(devr->s1);
> > +	atomic_dec(&devr->s0->ext.xrc.xrcd->usecnt);
> >  	mlx5_ib_destroy_srq(devr->s0, NULL);
> >  	kfree(devr->s0);
> > -	mlx5_ib_dealloc_xrcd(devr->x0, NULL);
> > -	mlx5_ib_dealloc_xrcd(devr->x1, NULL);
> > +	ib_dealloc_xrcd(devr->x0);
> > +	ib_dealloc_xrcd(devr->x1);
>
> Why is this an improvement? Whatever this internal driver thing is, it
> is not a visible XRCD..
>
> In fact why use an ib_xrcd here at all when this only needs the
> xrcdn? Just call the mlx_cmd_xrcd_* directly.

This is proper IB object and IMHO it should be created with standard primitives,
so we will be able account them properly and see full HW objects picture without
need to go and combine pieces from driver and ib_core.

The code properly hardcoded same thing as ib_core does for XRCD, which is right way
to do instead of making half of work like you are proposing.

At some point of time, XRCD will be visible in rdmatool too and we will
be able to RAW query even internal driver objects, because they are
standard ones.

Maybe, one day, we will be able to move mlx5_ib_handle_internal_error()
to general code.

>
> > +struct ib_xrcd *ib_alloc_xrcd_user(struct ib_device *device,
> > +				   struct inode *inode, struct ib_udata *udata);
> > +static inline struct ib_xrcd *ib_alloc_xrcd(struct ib_device *device)
> > +{
> > +	return ib_alloc_xrcd_user(device, NULL, NULL);
> > +}
>
> Because other than the above there is no in-kernel user of XRCD and
> this can all be deleted, the uverbs_cmd can directly create the xrcd
> and call the driver like for other non-kernel objects.

I can call directly to ib_alloc_xrcd_user() from mlx5, but I still
prefer to use ib_core primitives as much as possible.

Thanks

>
> Jason
