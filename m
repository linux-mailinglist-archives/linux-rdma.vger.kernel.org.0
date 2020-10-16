Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F8C428FC2E
	for <lists+linux-rdma@lfdr.de>; Fri, 16 Oct 2020 03:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbgJPAyX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 20:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388737AbgJPAyX (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 20:54:23 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D11C061755
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 17:54:23 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id n6so1581333ioc.12
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 17:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FNvgrlFY+mYnW8LeU28rfZ2P3+p6rVAfraH8nRohf6M=;
        b=kYGJXtQwFErHyGGOs0+3KoHk3gYQWREQ9FCFyLA4HtiFuHWpStpavqDwLdq6TGxj9W
         aIBxLhjSD5sWSGlNrqbSirtovhLQiJbDIFnr+NJHHVM0AGCVeCCryU9cjYjul6InBcco
         VpX++8KBHwKJCZq99xIk8FLNnrpfvV07yG2AxBz7wYDLq0oVf9NPfigbK9xrK2QyHbWB
         85Bd1M9hg6n6F6uyznuSjZCjYDdFojF4faTxIMmts2mSmgmjhMd6629SeCUVVbD24amW
         dBtfMGG6k7EV58/8CAydcCSKd9PQDxDEWgXtQ1VJ3SRcAG+KI3Xq0N6wj/svGuIfsNH6
         nRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FNvgrlFY+mYnW8LeU28rfZ2P3+p6rVAfraH8nRohf6M=;
        b=qi1JwOFhFf3PHbKzWW6a7mOr//c1qTMksAnT7NujvcnIRABZBe01v+jS1M5oNmXru3
         MPq+IahWqZmmcblGnWXFlqyNw/WcDkzkqgtPQaVTrPeV2UUxStJ5524oXlwOq26rec7J
         z6yue8WrISjXri3j+x+lDPsmgdPIxoC6DYsCeC5iX1EfLKHJ33OeDUtOW9wT9PjbAf/T
         NtPvQTfimcsXuX3CYeM3ng7p43Xj6qq3VqufqBGyM8nL6hjPjAR/r3GlpbeM4ggR/RkT
         4fFPMkekCxB7QDeAw/+K0jKH2D175h4AQpLmty5Sh69wWn1Wk5OGzyEkij5nY2UC2XMN
         iO6Q==
X-Gm-Message-State: AOAM531hcRHCqgtSIx99KbY0JkQdRgNTJdyfwfFT9BK1EczzgzOlOxP8
        auO7Bmzey5/YjNg6jh3FaAQB8g==
X-Google-Smtp-Source: ABdhPJyXDuyHBC23kxewb0cG0HjPVN22Zk3Yz47IeXrJIffXDVzOLmEBCw+yFGS2ID8HcqV75iNGMA==
X-Received: by 2002:a6b:b2cb:: with SMTP id b194mr619641iof.132.1602809662297;
        Thu, 15 Oct 2020 17:54:22 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-48-30.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.48.30])
        by smtp.gmail.com with ESMTPSA id b17sm606302ilo.86.2020.10.15.17.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 17:54:21 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1kTE0h-0009jv-W8; Thu, 15 Oct 2020 21:54:20 -0300
Date:   Thu, 15 Oct 2020 21:54:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: Re: [PATCH v5 4/5] RDMA/mlx5: Support dma-buf based userspace memory
 region
Message-ID: <20201016005419.GA36674@ziepe.ca>
References: <1602799378-138316-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602799378-138316-1-git-send-email-jianxin.xiong@intel.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Oct 15, 2020 at 03:02:58PM -0700, Jianxin Xiong wrote:
> Implement the new driver method 'reg_user_mr_dmabuf'.  Utilize the core
> functions to import dma-buf based memory region and update the mappings.
> 
> Add code to handle dma-buf related page fault.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Acked-by: Christian Koenig <christian.koenig@amd.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
>  drivers/infiniband/hw/mlx5/main.c    |   2 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h |   5 ++
>  drivers/infiniband/hw/mlx5/mr.c      | 119 +++++++++++++++++++++++++++++++++++
>  drivers/infiniband/hw/mlx5/odp.c     |  42 +++++++++++++
>  4 files changed, 168 insertions(+)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 89e04ca..ec4ad2f 100644
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>  /*
>   * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reserved.
> + * Copyright (c) 2020, Intel Corporation. All rights reserved.
>   */
>  
>  #include <linux/debugfs.h>
> @@ -4060,6 +4061,7 @@ static int mlx5_ib_enable_driver(struct ib_device *dev)
>  	.query_srq = mlx5_ib_query_srq,
>  	.query_ucontext = mlx5_ib_query_ucontext,
>  	.reg_user_mr = mlx5_ib_reg_user_mr,
> +	.reg_user_mr_dmabuf = mlx5_ib_reg_user_mr_dmabuf,
>  	.req_notify_cq = mlx5_ib_arm_cq,
>  	.rereg_user_mr = mlx5_ib_rereg_user_mr,
>  	.resize_cq = mlx5_ib_resize_cq,
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index b1f2b34..65fcc18 100644
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>  /*
>   * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reserved.
> + * Copyright (c) 2020, Intel Corporation. All rights reserved.
>   */
>  
>  #ifndef MLX5_IB_H
> @@ -1174,6 +1175,10 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const struct ib_cq_init_attr *attr,
>  struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  				  u64 virt_addr, int access_flags,
>  				  struct ib_udata *udata);
> +struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> +					 u64 length, u64 virt_addr,
> +					 int dmabuf_fd, int access_flags,
> +					 struct ib_udata *udata);
>  int mlx5_ib_advise_mr(struct ib_pd *pd,
>  		      enum ib_uverbs_advise_mr_advice advice,
>  		      u32 flags,
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index b261797..24750f1 100644
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1,5 +1,6 @@
>  /*
>   * Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2020, Intel Corporation. All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
>   * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -1462,6 +1463,124 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 length,
>  	return ERR_PTR(err);
>  }
>  
> +static int mlx5_ib_umem_dmabuf_xlt_init(struct ib_umem *umem, void *context)
> +{
> +	struct mlx5_ib_mr *mr = context;
> +	int flags = MLX5_IB_UPD_XLT_ENABLE;
> +
> +	if (!mr)
> +		return -EINVAL;
> +
> +	return mlx5_ib_update_xlt(mr, 0, mr->npages, PAGE_SHIFT, flags);
> +}

> +static int mlx5_ib_umem_dmabuf_xlt_update(struct ib_umem *umem, void *context)
> +{
> +	struct mlx5_ib_mr *mr = context;
> +	int flags = MLX5_IB_UPD_XLT_ATOMIC;

Why are these atomic? Why the strange coding style of declaring a
variable?

> +	if (!mr)
> +		return -EINVAL;

Why can this happen? Will dma_buf call move_notify prior to
dma_buf_map_attachment? There are locking problems if that happens.

> +	return mlx5_ib_update_xlt(mr, 0, mr->npages, PAGE_SHIFT, flags);
> +}
> +
> +static int mlx5_ib_umem_dmabuf_xlt_invalidate(struct ib_umem *umem, void *context)
> +{
> +	struct mlx5_ib_mr *mr = context;
> +	int flags = MLX5_IB_UPD_XLT_ZAP | MLX5_IB_UPD_XLT_ATOMIC;
> +
> +	if (!mr)
> +		return -EINVAL;
> +
> +	return mlx5_ib_update_xlt(mr, 0, mr->npages, PAGE_SHIFT, flags);
> +}
> +
> +static struct ib_umem_dmabuf_ops mlx5_ib_umem_dmabuf_ops = {
> +	.init = mlx5_ib_umem_dmabuf_xlt_init,
> +	.update = mlx5_ib_umem_dmabuf_xlt_update,
> +	.invalidate = mlx5_ib_umem_dmabuf_xlt_invalidate,
> +};

I'm not really convinced these should be ops, this is usually a bad
design pattern. 

Why do I need so much code to extract the sgl from the dma_buf? I
would prefer the dma_buf layer simplify this, not by adding a wrapper
around it in the IB core code...

> +struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> +					 u64 length, u64 virt_addr,
> +					 int dmabuf_fd, int access_flags,
> +					 struct ib_udata *udata)
> +{
> +	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> +	struct mlx5_ib_mr *mr = NULL;
> +	struct ib_umem *umem;
> +	int page_shift;
> +	int npages;
> +	int ncont;
> +	int order;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	mlx5_ib_dbg(dev,
> +		    "start 0x%llx, virt_addr 0x%llx, length 0x%llx, fd %d, access_flags 0x%x\n",
> +		    start, virt_addr, length, dmabuf_fd, access_flags);
> +
> +	if (!mlx5_ib_can_load_pas_with_umr(dev, length))
> +		return ERR_PTR(-EINVAL);
> +
> +	umem = ib_umem_dmabuf_get(&dev->ib_dev, start, length, dmabuf_fd,
> +				  access_flags, &mlx5_ib_umem_dmabuf_ops);
> +	if (IS_ERR(umem)) {
> +		mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(umem));
> +		return ERR_PTR(PTR_ERR(umem));
> +	}
> +
> +	npages = ib_umem_num_pages(umem);
> +	if (!npages) {
> +		mlx5_ib_warn(dev, "avoid zero region\n");
> +		ib_umem_release(umem);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	page_shift = PAGE_SHIFT;
> +	ncont = npages;
> +	order = ilog2(roundup_pow_of_two(ncont));

We still need to deal with contiguity here, this ncont/npages is just
obfuscation.

I have a patch series that should get posted soon rewriting all of
this stuff..

> +	mlx5_ib_dbg(dev, "npages %d, ncont %d, order %d, page_shift %d\n",
> +		    npages, ncont, order, page_shift);
> +
> +	mr = alloc_mr_from_cache(pd, umem, virt_addr, length, ncont,
> +				 page_shift, order, access_flags);
> +	if (IS_ERR(mr))
> +		mr = NULL;
> +
> +	if (!mr) {
> +		mutex_lock(&dev->slow_path_mutex);
> +		mr = reg_create(NULL, pd, virt_addr, length, umem, ncont,
> +				page_shift, access_flags, false);
> +		mutex_unlock(&dev->slow_path_mutex);
> +	}
> +
> +	if (IS_ERR(mr)) {
> +		err = PTR_ERR(mr);
> +		goto error;
> +	}
> +
> +	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
> +
> +	mr->umem = umem;
> +	set_mr_fields(dev, mr, npages, length, access_flags);

After another series I have there will be three copies of this
sequence :\

> +	err = ib_umem_dmabuf_init_mapping(umem, mr);
> +	if (err) {
> +		dereg_mr(dev, mr);
> +		return ERR_PTR(err);
> +	}

Did you test the page fault path at all? Looks like some xarray code
is missing here, and this is also missing the related complex teardown
logic.

Does this mean you didn't test the pagefault_dmabuf_mr() at all?

Jason
