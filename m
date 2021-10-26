Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE4F943B12C
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 13:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbhJZL0S (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 07:26:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:43644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229887AbhJZL0R (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 26 Oct 2021 07:26:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 61EED6044F;
        Tue, 26 Oct 2021 11:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635247434;
        bh=1rbXLbHoNsx7JDALabLgx2yfq303KBREfKM8vALcYGc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NZ1Ny5AxMBoJSvDXG2qfzaTw+U+o83fMM83QZeb10wZ62yUDaUSmB9h5Mhk0YeQSU
         CGJmnH0QcxHuVNOcsbZIlS2TZWK+Hth6Y6W6Rl2nzpH4OgIV/6jnmwk/T/q+HDLn/z
         iqfw+0muuEffnoOfwPoMNe8voOdh/cToKNno3l0VNoj73HzAL3r1OZpmYd2pdvYzqE
         pOZBPIl/97+AM/LGfRiOFWrxIEv172utxUsZ8WZHvMCyO6ZiJahaVISJF/hPE2IqcS
         +TSSP6dungYNd2FSMMqCK6ZeXACjzYK4yz9LKZlKbSoSK5H38o8zZgZxbcoCSFiD8Y
         b1/j6hgib37PQ==
Date:   Tue, 26 Oct 2021 14:23:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Alaa Hleihel <alaa@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH RESEND rdma-rc] RDMA/mlx5: Add dummy umem to IB_MR_TYPE_DM
Message-ID: <YXflRbBkvtBeQvA4@unreal>
References: <e13b7014857ea296285ee5cfcdaaada9007f6978.1634638695.git.leonro@nvidia.com>
 <20211025173150.GA396793@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211025173150.GA396793@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 25, 2021 at 02:31:50PM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 19, 2021 at 01:23:13PM +0300, Leon Romanovsky wrote:
> > From: Alaa Hleihel <alaa@nvidia.com>
> > 
> > After the cited patch, and for the case of IB_MR_TYPE_DM that doesn't
> > have a umem (even though it is a user MR), function mlx5_free_priv_descs()
> > will think that it's a kernel MR, leading to wrongly accessing mr->descs
> > that will get wrong values in the union which leads to attempting to
> > release resources that were not allocated in the first place.
> > 
> > For example:
> >  DMA-API: mlx5_core 0000:08:00.1: device driver tries to free DMA memory it has not allocated [device address=0x0000000000000000] [size=0 bytes]
> >  WARNING: CPU: 8 PID: 1021 at kernel/dma/debug.c:961 check_unmap+0x54f/0x8b0
> >  RIP: 0010:check_unmap+0x54f/0x8b0
> >  Call Trace:
> >   debug_dma_unmap_page+0x57/0x60
> >   mlx5_free_priv_descs+0x57/0x70 [mlx5_ib]
> >   mlx5_ib_dereg_mr+0x1fb/0x3d0 [mlx5_ib]
> >   ib_dereg_mr_user+0x60/0x140 [ib_core]
> >   uverbs_destroy_uobject+0x59/0x210 [ib_uverbs]
> >   uobj_destroy+0x3f/0x80 [ib_uverbs]
> >   ib_uverbs_cmd_verbs+0x435/0xd10 [ib_uverbs]
> >   ? uverbs_finalize_object+0x50/0x50 [ib_uverbs]
> >   ? lock_acquire+0xc4/0x2e0
> >   ? lock_acquired+0x12/0x380
> >   ? lock_acquire+0xc4/0x2e0
> >   ? lock_acquire+0xc4/0x2e0
> >   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
> >   ? lock_release+0x28a/0x400
> >   ib_uverbs_ioctl+0xc0/0x140 [ib_uverbs]
> >   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
> >   __x64_sys_ioctl+0x7f/0xb0
> >   do_syscall_64+0x38/0x90
> > 
> > Fix it by adding a dummy umem to IB_MR_TYPE_DM MRs.
> > 
> > Fixes: f18ec4223117 ("RDMA/mlx5: Use a union inside mlx5_ib_mr")
> > Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > RESEND: https://lore.kernel.org/all/9c6478b70dc23cfec3a7bfc345c30ff817e7e799.1631660866.git.leonro@nvidia.com
> > 
> > Our request to drop that original patch was because mr-->umem pointer is checked
> > in rereg flow for the DM MRs with expectation to have NULL there. However DM is
> > blocked for the rereg path in the commit 5ccbf63f87a3 ("IB/uverbs: Prevent
> > reregistration of DM_MR to regular MR"), and the checks in mlx5_ib are redundant.
> 
> That logic in the core code is bogus and should be deleted.
> 
> It is perfeclty fine to use rereg to change the access flags on a DM
> MR and mlx5 now implements that.
> 
> So let's not go down a path that blocks it.
> 
> Like this instead:

Thanks, let's give a try.

> 
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index e636e954f6bf2a..4a7a56ed740b9b 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -664,7 +664,6 @@ struct mlx5_ib_mr {
>  
>  	/* User MR data */
>  	struct mlx5_cache_ent *cache_ent;
> -	struct ib_umem *umem;
>  
>  	/* This is zero'd when the MR is allocated */
>  	union {
> @@ -676,7 +675,7 @@ struct mlx5_ib_mr {
>  			struct list_head list;
>  		};
>  
> -		/* Used only by kernel MRs (umem == NULL) */
> +		/* Used only by kernel MRs */
>  		struct {
>  			void *descs;
>  			void *descs_alloc;
> @@ -697,8 +696,9 @@ struct mlx5_ib_mr {
>  			int data_length;
>  		};
>  
> -		/* Used only by User MRs (umem != NULL) */
> +		/* Used only by User MRs */
>  		struct {
> +			struct ib_umem *umem;
>  			unsigned int page_shift;
>  			/* Current access_flags */
>  			int access_flags;
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 221f0949794e35..997d133d00369d 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1904,19 +1904,19 @@ mlx5_alloc_priv_descs(struct ib_device *device,
>  	return ret;
>  }
>  
> -static void
> -mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
> +static void mlx5_free_priv_descs(struct mlx5_ib_mr *mr)
>  {
> -	if (!mr->umem && mr->descs) {
> -		struct ib_device *device = mr->ibmr.device;
> -		int size = mr->max_descs * mr->desc_size;
> -		struct mlx5_ib_dev *dev = to_mdev(device);
> +	struct ib_device *device = mr->ibmr.device;
> +	int size = mr->max_descs * mr->desc_size;
> +	struct mlx5_ib_dev *dev = to_mdev(device);
>  
> -		dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
> -				 DMA_TO_DEVICE);
> -		kfree(mr->descs_alloc);
> -		mr->descs = NULL;
> -	}
> +	if (!mr->descs)
> +		return;
> +
> +	dma_unmap_single(&dev->mdev->pdev->dev, mr->desc_map, size,
> +			 DMA_TO_DEVICE);
> +	kfree(mr->descs_alloc);
> +	mr->descs = NULL;
>  }
>  
>  int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
> @@ -1978,7 +1978,7 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  			return rc;
>  	}
>  
> -	if (mr->umem) {
> +	if (udata && mr->umem) {
>  		bool is_odp = is_odp_mr(mr);
>  
>  		if (!is_odp)
> @@ -1992,7 +1992,8 @@ int mlx5_ib_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>  	if (mr->cache_ent) {
>  		mlx5_mr_cache_free(dev, mr);
>  	} else {
> -		mlx5_free_priv_descs(mr);
> +		if (!udata)
> +			mlx5_free_priv_descs(mr);
>  		kfree(mr);
>  	}
>  	return 0;
> @@ -2079,7 +2080,6 @@ static struct mlx5_ib_mr *mlx5_ib_alloc_pi_mr(struct ib_pd *pd,
>  	if (err)
>  		goto err_free_in;
>  
> -	mr->umem = NULL;
>  	kfree(in);
>  
>  	return mr;
> @@ -2206,7 +2206,6 @@ static struct ib_mr *__mlx5_ib_alloc_mr(struct ib_pd *pd,
>  	}
>  
>  	mr->ibmr.device = pd->device;
> -	mr->umem = NULL;
>  
>  	switch (mr_type) {
>  	case IB_MR_TYPE_MEM_REG:
