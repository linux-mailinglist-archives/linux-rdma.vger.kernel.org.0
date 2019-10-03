Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 279B8C9A42
	for <lists+linux-rdma@lfdr.de>; Thu,  3 Oct 2019 10:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727995AbfJCIyy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 3 Oct 2019 04:54:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:44532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfJCIyx (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 3 Oct 2019 04:54:53 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1A7D2086A;
        Thu,  3 Oct 2019 08:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570092892;
        bh=xKO1I0nbSJhvzGmHc15DTnvqW2lbbUKPnJj1FmjcA1Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H61h+amreyqUIexicT/gl9qVk/8RT3syW05/hAU7ecwOg+BZ8qBOzTIjyPaQjHZBb
         o2o/UhxQdNY1LBZosLVpwjaBGZgPM2rTOuyKneZQ1Z0CgG8E3bjZNhr7G71RKsqMfz
         8qF8REbKh7T2otzYknJ9PoFJjr/LzcMiXtpR51G0=
Date:   Thu, 3 Oct 2019 11:54:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH 6/6] RDMA/mlx5: Add missing synchronize_srcu() for MW
 cases
Message-ID: <20191003085449.GN5855@unreal>
References: <20191001153821.23621-1-jgg@ziepe.ca>
 <20191001153821.23621-7-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001153821.23621-7-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 01, 2019 at 12:38:21PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> While MR uses live as the SRCU 'update', the MW case uses the xarray
> directly, xa_erase() causes the MW to become inaccessible to the pagefault
> thread.
>
> Thus whenever a MW is removed from the xarray we must synchronize_srcu()
> before freeing it.
>
> This must be done before freeing the mkey as re-use of the mkey while the
> pagefault thread is using the stale mkey is undesirable.
>
> Add the missing synchronizes to MW and DEVX indirect mkey and delete the
> bogus protection against double destroy in mlx5_core_destroy_mkey()
>
> Fixes: 534fd7aac56a ("IB/mlx5: Manage indirection mkey upon DEVX flow for ODP")
> Fixes: 6aec21f6a832 ("IB/mlx5: Page faults handling infrastructure")
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c            | 58 ++++++--------------
>  drivers/infiniband/hw/mlx5/mlx5_ib.h         |  1 -
>  drivers/infiniband/hw/mlx5/mr.c              | 21 +++++--
>  drivers/net/ethernet/mellanox/mlx5/core/mr.c |  8 +--
>  4 files changed, 33 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/devx.c b/drivers/infiniband/hw/mlx5/devx.c
> index 59022b7441448f..d609f4659afb7a 100644
> --- a/drivers/infiniband/hw/mlx5/devx.c
> +++ b/drivers/infiniband/hw/mlx5/devx.c
> @@ -1298,29 +1298,6 @@ static int devx_handle_mkey_create(struct mlx5_ib_dev *dev,
>  	return 0;
>  }
>
> -static void devx_free_indirect_mkey(struct rcu_head *rcu)
> -{
> -	kfree(container_of(rcu, struct devx_obj, devx_mr.rcu));
> -}
> -
> -/* This function to delete from the radix tree needs to be called before
> - * destroying the underlying mkey. Otherwise a race might occur in case that
> - * other thread will get the same mkey before this one will be deleted,
> - * in that case it will fail via inserting to the tree its own data.
> - *
> - * Note:
> - * An error in the destroy is not expected unless there is some other indirect
> - * mkey which points to this one. In a kernel cleanup flow it will be just
> - * destroyed in the iterative destruction call. In a user flow, in case
> - * the application didn't close in the expected order it's its own problem,
> - * the mkey won't be part of the tree, in both cases the kernel is safe.
> - */
> -static void devx_cleanup_mkey(struct devx_obj *obj)
> -{
> -	xa_erase(&obj->ib_dev->mdev->priv.mkey_table,
> -		 mlx5_base_mkey(obj->devx_mr.mmkey.key));
> -}
> -
>  static void devx_cleanup_subscription(struct mlx5_ib_dev *dev,
>  				      struct devx_event_subscription *sub)
>  {
> @@ -1362,8 +1339,16 @@ static int devx_obj_cleanup(struct ib_uobject *uobject,
>  	int ret;
>
>  	dev = mlx5_udata_to_mdev(&attrs->driver_udata);
> -	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY)
> -		devx_cleanup_mkey(obj);
> +	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
> +		/*
> +		 * The pagefault_single_data_segment() does commands against
> +		 * the mmkey, we must wait for that to stop before freeing the
> +		 * mkey, as another allocation could get the same mkey #.
> +		 */
> +		xa_erase(&obj->ib_dev->mdev->priv.mkey_table,
> +			 mlx5_base_mkey(obj->devx_mr.mmkey.key));
> +		synchronize_srcu(&dev->mr_srcu);
> +	}
>
>  	if (obj->flags & DEVX_OBJ_FLAGS_DCT)
>  		ret = mlx5_core_destroy_dct(obj->ib_dev->mdev, &obj->core_dct);
> @@ -1382,12 +1367,6 @@ static int devx_obj_cleanup(struct ib_uobject *uobject,
>  		devx_cleanup_subscription(dev, sub_entry);
>  	mutex_unlock(&devx_event_table->event_xa_lock);
>
> -	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
> -		call_srcu(&dev->mr_srcu, &obj->devx_mr.rcu,
> -			  devx_free_indirect_mkey);
> -		return ret;
> -	}
> -
>  	kfree(obj);
>  	return ret;
>  }
> @@ -1491,26 +1470,21 @@ static int UVERBS_HANDLER(MLX5_IB_METHOD_DEVX_OBJ_CREATE)(
>  				   &obj_id);
>  	WARN_ON(obj->dinlen > MLX5_MAX_DESTROY_INBOX_SIZE_DW * sizeof(u32));
>
> -	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
> -		err = devx_handle_mkey_indirect(obj, dev, cmd_in, cmd_out);
> -		if (err)
> -			goto obj_destroy;
> -	}
> -
>  	err = uverbs_copy_to(attrs, MLX5_IB_ATTR_DEVX_OBJ_CREATE_CMD_OUT, cmd_out, cmd_out_len);
>  	if (err)
> -		goto err_copy;
> +		goto obj_destroy;
>
>  	if (opcode == MLX5_CMD_OP_CREATE_GENERAL_OBJECT)
>  		obj_type = MLX5_GET(general_obj_in_cmd_hdr, cmd_in, obj_type);
> -
>  	obj->obj_id = get_enc_obj_id(opcode | obj_type << 16, obj_id);
>
> +	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY) {
> +		err = devx_handle_mkey_indirect(obj, dev, cmd_in, cmd_out);
> +		if (err)
> +			goto obj_destroy;
> +	}
>  	return 0;
>
> -err_copy:
> -	if (obj->flags & DEVX_OBJ_FLAGS_INDIRECT_MKEY)
> -		devx_cleanup_mkey(obj);
>  obj_destroy:
>  	if (obj->flags & DEVX_OBJ_FLAGS_DCT)
>  		mlx5_core_destroy_dct(obj->ib_dev->mdev, &obj->core_dct);
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> index 15e42825cc976e..1a98ee2e01c4b9 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -639,7 +639,6 @@ struct mlx5_ib_mw {
>  struct mlx5_ib_devx_mr {
>  	struct mlx5_core_mkey	mmkey;
>  	int			ndescs;
> -	struct rcu_head		rcu;
>  };
>
>  struct mlx5_ib_umr_context {
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> index 3a27bddfcf31f5..630599311586ec 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1962,14 +1962,25 @@ struct ib_mw *mlx5_ib_alloc_mw(struct ib_pd *pd, enum ib_mw_type type,
>
>  int mlx5_ib_dealloc_mw(struct ib_mw *mw)
>  {
> +	struct mlx5_ib_dev *dev = to_mdev(mw->device);
>  	struct mlx5_ib_mw *mmw = to_mmw(mw);
>  	int err;
>
> -	err =  mlx5_core_destroy_mkey((to_mdev(mw->device))->mdev,
> -				      &mmw->mmkey);
> -	if (!err)
> -		kfree(mmw);
> -	return err;
> +	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
> +		xa_erase(&dev->mdev->priv.mkey_table,
> +			 mlx5_base_mkey(mmw->mmkey.key));
> +		/*
> +		 * pagefault_single_data_segment() may be accessing mmw under
> +		 * SRCU if the user bound an ODP MR to this MW.
> +		 */
> +		synchronize_srcu(&dev->mr_srcu);
> +	}
> +
> +	err = mlx5_core_destroy_mkey(dev->mdev, &mmw->mmkey);
> +	if (err)
> +		return err;
> +	kfree(mmw);

You are skipping kfree() in case of error returned by mlx5_core_destroy_mkey().
IMHO, it is right for -ENOENT, but is not right for mlx5_cmd_exec() failures.

Thanks
