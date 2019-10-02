Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E066C494A
	for <lists+linux-rdma@lfdr.de>; Wed,  2 Oct 2019 10:18:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbfJBISb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 2 Oct 2019 04:18:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:49440 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbfJBISb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 2 Oct 2019 04:18:31 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4C9FE21783;
        Wed,  2 Oct 2019 08:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570004309;
        bh=JPw6G1JWLjoiRu02KAaq31tEQTM4K3L9HPQtLj7FH4Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fNZDiwI4p7jx9ZKfxert5K1m9QL/DdLoI4vl87EDq/xD4wvukKKGM5w0fAv1NY0yz
         CKyePP/UIJNrhzG6ElKZgg+i/PbBF6KyqnqppF1cc5uMh7GZiHqINBi8t6OC6KluFo
         taQcglkt+YeFv2982ly+OrTQ6Ki1SKNGzarcrXDQ=
Date:   Wed, 2 Oct 2019 11:18:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@mellanox.com>,
        Artemy Kovalyov <artemyko@mellanox.com>
Subject: Re: [PATCH 2/6] RDMA/mlx5: Fix a race with mlx5_ib_update_xlt on an
 implicit MR
Message-ID: <20191002081826.GA5855@unreal>
References: <20191001153821.23621-1-jgg@ziepe.ca>
 <20191001153821.23621-3-jgg@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191001153821.23621-3-jgg@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 01, 2019 at 12:38:17PM -0300, Jason Gunthorpe wrote:
> From: Jason Gunthorpe <jgg@mellanox.com>
>
> mlx5_ib_update_xlt() must be protected against parallel free of the MR it
> is accessing, also it must be called single threaded while updating the
> HW. Otherwise we can have races of the form:
>
>     CPU0                               CPU1
>   mlx5_ib_update_xlt()
>    mlx5_odp_populate_klm()
>      odp_lookup() == NULL
>      pklm = ZAP
>                                       implicit_mr_get_data()
>  				        implicit_mr_alloc()
>  					  <update interval tree>
> 					mlx5_ib_update_xlt
> 					  mlx5_odp_populate_klm()
> 					    odp_lookup() != NULL
> 					    pklm = VALID
> 					   mlx5_ib_post_send_wait()
>
>     mlx5_ib_post_send_wait() // Replaces VALID with ZAP
>
> This can be solved by putting both the SRCU and the umem_mutex lock around
> every call to mlx5_ib_update_xlt(). This ensures that the content of the
> interval tree relavent to mlx5_odp_populate_klm() (ie mr->parent == mr)
> will not change while it is running, and thus the posted WRs to update the
> KLM will always reflect the correct information.
>
> The race above will resolve by either having CPU1 wait till CPU0 completes
> the ZAP or CPU0 will run after the add and instead store VALID.
>
> The pagefault path adding children already holds the umem_mutex and SRCU,
> so the only missed lock is during MR destruction.
>
> Fixes: 81713d3788d2 ("IB/mlx5: Add implicit MR support")
> Reviewed-by: Artemy Kovalyov <artemyko@mellanox.com>
> Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 34 ++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> index 2e9b4306179745..3401c06b7e54f5 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -178,6 +178,29 @@ void mlx5_odp_populate_klm(struct mlx5_klm *pklm, size_t offset,
>  		return;
>  	}
>
> +	/*
> +	 * The locking here is pretty subtle. Ideally the implicit children
> +	 * list would be protected by the umem_mutex, however that is not
> +	 * possible. Instead this uses a weaker update-then-lock pattern:
> +	 *
> +	 *  srcu_read_lock()
> +	 *    <change children list>
> +	 *    mutex_lock(umem_mutex)
> +	 *     mlx5_ib_update_xlt()
> +	 *    mutex_unlock(umem_mutex)
> +	 *    destroy lkey
> +	 *
> +	 * ie any change the children list must be followed by the locked
> +	 * update_xlt before destroying.
> +	 *
> +	 * The umem_mutex provides the acquire/release semantic needed to make
> +	 * the children list visible to a racing thread. While SRCU is not
> +	 * technically required, using it gives consistent use of the SRCU
> +	 * locking around the children list.
> +	 */
> +	lockdep_assert_held(&to_ib_umem_odp(mr->umem)->umem_mutex);
> +	lockdep_assert_held(&mr->dev->mr_srcu);
> +
>  	odp = odp_lookup(offset * MLX5_IMR_MTT_SIZE,
>  			 nentries * MLX5_IMR_MTT_SIZE, mr);
>
> @@ -202,15 +225,22 @@ static void mr_leaf_free_action(struct work_struct *work)
>  	struct ib_umem_odp *odp = container_of(work, struct ib_umem_odp, work);
>  	int idx = ib_umem_start(odp) >> MLX5_IMR_MTT_SHIFT;
>  	struct mlx5_ib_mr *mr = odp->private, *imr = mr->parent;
> +	struct ib_umem_odp *odp_imr = to_ib_umem_odp(imr->umem);
> +	int srcu_key;
>
>  	mr->parent = NULL;
>  	synchronize_srcu(&mr->dev->mr_srcu);

Are you sure that this line is still needed?

>
> -	ib_umem_odp_release(odp);
> -	if (imr->live)
> +	if (imr->live) {
> +		srcu_key = srcu_read_lock(&mr->dev->mr_srcu);
> +		mutex_lock(&odp_imr->umem_mutex);
>  		mlx5_ib_update_xlt(imr, idx, 1, 0,
>  				   MLX5_IB_UPD_XLT_INDIRECT |
>  				   MLX5_IB_UPD_XLT_ATOMIC);
> +		mutex_unlock(&odp_imr->umem_mutex);
> +		srcu_read_unlock(&mr->dev->mr_srcu, srcu_key);
> +	}
> +	ib_umem_odp_release(odp);
>  	mlx5_mr_cache_free(mr->dev, mr);
>
>  	if (atomic_dec_and_test(&imr->num_leaf_free))
> --
> 2.23.0
>
