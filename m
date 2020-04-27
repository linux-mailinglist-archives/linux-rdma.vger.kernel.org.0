Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 519071BA2F2
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Apr 2020 13:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgD0LwE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 27 Apr 2020 07:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0LwE (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 27 Apr 2020 07:52:04 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57BDC0610D5
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 04:52:03 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id q7so5489307qkf.3
        for <linux-rdma@vger.kernel.org>; Mon, 27 Apr 2020 04:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/YLzVNJRsEbQQ/A9IMC+12jYjS7pkegTYPpERSgAr/Y=;
        b=oPTlnbE0oYyI6iV7he4vu1dL1SVCZRphNqbrKDfvV2PAmTugP92hhcu2iHu6uRjRJM
         Q8v0f8ArH1SUyQK0SYOsx6g/nmo8cO0RFpVUbS4DPU0RVs3Nx3Nf2Lzz0kM4TdIL02L9
         9LekieEGc1i9EoVaZN2DTDTBptzhWp1obV6BS2GaxgqZSDO+wbptIXkQOhNn1EnBv8or
         7vRjVqLmspUDxeq9GgURAmBpxhHWvIWReKIT1/Rhb6QiYOOG0Q8HuWHL6i5iTqIhAYHx
         Xrpx+Y1FsZ2dtygH01Ea7Fxrsm5Io4M49qYSMLOBvED+dZfFRCYtZ8VjB/50H1UGJ08K
         Lh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/YLzVNJRsEbQQ/A9IMC+12jYjS7pkegTYPpERSgAr/Y=;
        b=ZWmwoD9gpw7n5LDCvFyg+X4gjxEXRlrqWPUGhq7/jB8HZ0NArOQFgo8G9nRHIx7wvW
         UpVQWQ/LXCwVKzKxu8KOAHNysifwyDgzxnv/eS4FosDsWWjItDvNG6mX57CwpH504p4l
         vilv1qxNeGoWIxJT66fb0+pM+w+CeuYoMHy0q4LBOI4DLFepAsGXXBaRmYPz1QjCWxK9
         Ry+IMmWawCLz2CxzAi2FSNka6U5j3OQPXlBWYXWCQI3Eh1RMtk+JZLWv9mTsh1eS7Q+P
         eZvsG6utNppaiJ/IZGE3hEfcNBn91izVjfts6p9qbwctwUBNQ8O6QtF6qz1OS8BdVhz0
         Np2w==
X-Gm-Message-State: AGi0PuZqAha/VGrYo2iwu6/1kfRQwKgxCp81Iv9Hlo3a48GcFiFEPl74
        oW3lZkXMIAXIqsQiH0D+7dmKfg==
X-Google-Smtp-Source: APiQypKlSfwZRviWuq+dd86lO9CtBCNy7Y51usGEaY1kpFD3/kmrWK6JjlCc9UQjCZXL87Ar/V6BTQ==
X-Received: by 2002:a37:4d3:: with SMTP id 202mr21764568qke.244.1587988322910;
        Mon, 27 Apr 2020 04:52:02 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id c11sm10075921qkj.78.2020.04.27.04.52.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Apr 2020 04:52:02 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jT2Ir-0002hv-Hm; Mon, 27 Apr 2020 08:52:01 -0300
Date:   Mon, 27 Apr 2020 08:52:01 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
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
Message-ID: <20200427115201.GN26002@ziepe.ca>
References: <1587893517-11824-1-git-send-email-liweihang@huawei.com>
 <20200427114734.GC134660@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427114734.GC134660@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Apr 27, 2020 at 02:47:34PM +0300, Leon Romanovsky wrote:
> On Sun, Apr 26, 2020 at 05:31:57PM +0800, Weihang Li wrote:
> > If the name of a device is assigned during ib_register_device(), some
> > drivers have to use dev_*() for printing before register device. Bring
> > assign_name() into ib_alloc_device(), so that drivers can use ibdev_*()
> > anywhere.
> >
> > Signed-off-by: Weihang Li <liweihang@huawei.com>
> >  drivers/infiniband/core/device.c               | 85 +++++++++++++-------------
> >  drivers/infiniband/hw/bnxt_re/main.c           |  4 +-
> >  drivers/infiniband/hw/cxgb4/device.c           |  2 +-
> >  drivers/infiniband/hw/cxgb4/provider.c         |  2 +-
> >  drivers/infiniband/hw/efa/efa_main.c           |  4 +-
> >  drivers/infiniband/hw/hns/hns_roce_hw_v1.c     |  2 +-
> >  drivers/infiniband/hw/hns/hns_roce_hw_v2.c     |  2 +-
> >  drivers/infiniband/hw/hns/hns_roce_main.c      |  2 +-
> >  drivers/infiniband/hw/i40iw/i40iw_verbs.c      |  4 +-
> >  drivers/infiniband/hw/mlx4/main.c              |  4 +-
> >  drivers/infiniband/hw/mlx5/ib_rep.c            |  8 ++-
> >  drivers/infiniband/hw/mlx5/main.c              | 18 +++---
> >  drivers/infiniband/hw/mthca/mthca_main.c       |  2 +-
> >  drivers/infiniband/hw/mthca/mthca_provider.c   |  2 +-
> >  drivers/infiniband/hw/ocrdma/ocrdma_main.c     |  4 +-
> >  drivers/infiniband/hw/qedr/main.c              |  4 +-
> >  drivers/infiniband/hw/usnic/usnic_ib_main.c    |  4 +-
> >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c |  4 +-
> >  drivers/infiniband/sw/rxe/rxe.c                |  4 +-
> >  drivers/infiniband/sw/rxe/rxe.h                |  2 +-
> >  drivers/infiniband/sw/rxe/rxe_net.c            |  4 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.c          |  4 +-
> >  drivers/infiniband/sw/rxe/rxe_verbs.h          |  2 +-
> >  include/rdma/ib_verbs.h                        |  8 +--
> >  24 files changed, 95 insertions(+), 86 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index d0b3d35..30d28da 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -557,9 +557,45 @@ static void rdma_init_coredev(struct ib_core_device *coredev,
> >  	write_pnet(&coredev->rdma_net, net);
> >  }
> >
> > +/*
> > + * Assign the unique string device name and the unique device index. This is
> > + * undone by ib_dealloc_device.
> > + */
> > +static int assign_name(struct ib_device *device, const char *name)
> > +{
> > +	static u32 last_id;
> > +	int ret;
> > +
> > +	down_write(&devices_rwsem);
> > +	/* Assign a unique name to the device */
> > +	if (strchr(name, '%'))
> > +		ret = alloc_name(device, name);
> > +	else
> > +		ret = dev_set_name(&device->dev, name);
> > +	if (ret)
> > +		goto out;
> > +
> > +	if (__ib_device_get_by_name(dev_name(&device->dev))) {
> > +		ret = -ENFILE;
> > +		goto out;
> > +	}
> > +	strlcpy(device->name, dev_name(&device->dev), IB_DEVICE_NAME_MAX);
> > +
> > +	ret = xa_alloc_cyclic(&devices, &device->index, device, xa_limit_31b,
> > +			      &last_id, GFP_KERNEL);
> > +	if (ret > 0)
> > +		ret = 0;
> > +
> > +out:
> > +	up_write(&devices_rwsem);
> > +	return ret;
> > +}
> > +
> >  /**
> >   * _ib_alloc_device - allocate an IB device struct
> >   * @size:size of structure to allocate
> > + * @name: unique string device name. This may include a '%' which will
> 
> It looks like all drivers are setting "%" in their name and "name" can
> be changed to be "prefix".

Does hfi? I thought the name was forced there for some port swapped
reason?

Jason
