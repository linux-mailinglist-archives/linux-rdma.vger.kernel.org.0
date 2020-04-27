Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2961C1BA318
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 14:03:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgD0MDl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 08:03:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:49624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgD0MDl (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 27 Apr 2020 08:03:41 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50DBF20656;
        Mon, 27 Apr 2020 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587989021;
        bh=HErJrtNLD6rbb2CKDJ6dQSlttKormWSWNbkzhDC7xgw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pV9opxO7w0b469oncFv/OiOjHO/yr+RY1CgJA/DGJCOnbr8VKs/MvrP8R1fWd331D
         nnA0PUz8eIvPE3yMTHj6JwydYJrNv9jYpXV7ZBAiBkZ/hCPu8LljtrKPhXN0Y/Q4X2
         lhDfC3rGkYLP63wGO0aw62paQm5MOSS5dCrzdiW8=
Date:   Mon, 27 Apr 2020 15:03:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Weihang Li <liweihang@huawei.com>, dledford@redhat.com,
        linux-rdma@vger.kernel.org, linuxarm@huawei.com,
        selvin.xavier@broadcom.com, devesh.sharma@broadcom.com,
        somnath.kotur@broadcom.com, sriharsha.basavapatna@broadcom.com,
        bharat@chelsio.com, galpress@amazon.com, sleybo@amazon.com,
        faisal.latif@intel.com, shiraz.saleem@intel.com,
        yishaih@mellanox.com, mkalderon@marvell.com, aelior@marvell.com,
        benve@cisco.com, neescoba@cisco.com, pkaustub@cisco.com,
        aditr@vmware.com, pv-drivers@vmware.com, monis@mellanox.com,
        kamalheib1@gmail.com, parav@mellanox.com, markz@mellanox.com,
        rd.dunlab@gmail.com, dennis.dalessandro@intel.com
Subject: Re: [PATCH for-next] RDMA/core: Assign the name of device when
 allocating ib_device
Message-ID: <20200427120337.GD134660@unreal>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <20200427114734.GC134660@unreal>
 <20200427115201.GN26002@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427115201.GN26002@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 08:52:01AM -0300, Jason Gunthorpe wrote:
> On Mon, Apr 27, 2020 at 02:47:34PM +0300, Leon Romanovsky wrote:
> > On Sun, Apr 26, 2020 at 05:31:57PM +0800, Weihang Li wrote:
> > > If the name of a device is assigned during ib_register_device(), some
> > > drivers have to use dev_*() for printing before register device. Bring
> > > assign_name() into ib_alloc_device(), so that drivers can use ibdev_*()
> > > anywhere.
> > >
> > > Signed-off-by: Weihang Li <liweihang@huawei.com>
> > >  drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
> > >  drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
> > >  drivers/infiniband/hw/cxgb4/device.c           |  2 +-
> > >  drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
> > >  drivers/infiniband/hw/efa/efa_main.c           |  4 +-
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
> > >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
> > >  drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
> > >  drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
> > >  drivers/infiniband/hw/mlx4/main.c              |  4 +-
> > >  drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
> > >  drivers/infiniband/hw/mlx5/main.c              | 18 +++---
> > >  drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
> > >  drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
> > >  drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
> > >  drivers/infiniband/hw/qedr/main.c              |  4 +-
> > >  drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
> > >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
> > >  drivers/infiniband/sw/rxe/rxe.c                |  4 +-
> > >  drivers/infiniband/sw/rxe/rxe.h                |  2 +-
> > >  drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
> > >  drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
> > >  drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
> > >  include/rdma/ib_verbs.h                        |  8 +--
> > >  24 files changed, 95 insertions(+), 86 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > > index d0b3d35..30d28da 100644
> > > +++ b/drivers/infiniband/core/device.c
> > > @@ -557,9 +557,45 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
> > >  	write_pnet(&coredev->rdma_net, net);
> > >  }
> > >
> > > +/*
> > > + * Assign the unique string device name and the unique device index. This is
> > > + * undone by ib_dealloc_device.
> > > + */
> > > +static int assign_name(struct ib_device *device, const char *name)
> > > +{
> > > +	static u32 last_id;
> > > +	int ret;
> > > +
> > > +	down_write(&devices_rwsem);
> > > +	/* Assign a unique name to the device */
> > > +	if (strchr(name, '%'))
> > > +		ret = alloc_name(device, name);
> > > +	else
> > > +		ret = dev_set_name(&device->dev, name);
> > > +	if (ret)
> > > +		goto out;
> > > +
> > > +	if (__ib_device_get_by_name(dev_name(&device->dev))) {
> > > +		ret = -ENFILE;
> > > +		goto out;
> > > +	}
> > > +	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
> > > +
> > > +	ret = xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
> > > +			      &last_id, GFP_KERNEL);
> > > +	if (ret > 0)
> > > +		ret = 0;
> > > +
> > > +out:
> > > +	up_write(&devices_rwsem);
> > > +	return ret;
> > > +}
> > > +
> > >  /**
> > >   * _ib_alloc_device - allocate an IB device struct
> > >   * @size:size of structure to allocate
> > > + * @name: unique string device name. This may include a '%' which will
> >
> > It looks like all drivers are setting "%" in their name and "name" can
> > be changed to be "prefix".
>
> Does hfi? I thought the name was forced there for some port swapped
> reason?

This patch doesn't touch HFI, nothing prohibits from us to make this
conversion work for all drivers except HFI and for the HFI add some
different callback. There is no need to make API harder just because
one driver needs it.

Thanks

>
> Jason
