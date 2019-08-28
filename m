Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82F749FD54
	for <lists+linux-rdma@lfdr.de>; Wed, 28 Aug 2019 10:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfH1Ikv (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 28 Aug 2019 04:40:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:51378 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726259AbfH1Ikv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 28 Aug 2019 04:40:51 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2635723403;
        Wed, 28 Aug 2019 08:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566981650;
        bh=816LzUJz8QbKhqalvwkoiuDGdBpxLEP7wbyuS/qIWjw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YeeL61NYsRUv1+1Idq93iNFU2wgCeFiMwp8fbyexza43fxwNBpLF0pqZogt1VQav8
         KFMW43KMPcZZG7xPQjdhOU2Z1gVRtdekLTgzoSsQeW4pZgdzlnXJnKAvbYSDWo9guW
         ZV5KccL8PfJ9P9gUa2SuajnKRS68gGcmRmO2x/Hw=
Date:   Wed, 28 Aug 2019 11:40:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yuval Shaia <yuval.shaia@oracle.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, oulijun@huawei.com,
        xavier.huwei@huawei.com, majd@mellanox.com, markz@mellanox.com,
        swise@opengridcomputing.com, galpress@amazon.com,
        monis@mellanox.com, israelr@mellanox.com, maxg@mellanox.com,
        dan.carpenter@oracle.com, kamalheib1@gmail.com,
        denisd@mellanox.com, yuvalav@mellanox.com,
        dennis.dalessandro@intel.com, ereza@mellanox.com, will@kernel.org,
        linux-rdma@vger.kernel.org, jgg@mellanox.com, srabinov7@gmail.com,
        santosh.shilimkar@oracle.com,
        Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
Subject: Re: [PATCH 3/4] IB/{core,hw}: ib_pd should not have ib_uobject
 pointer
Message-ID: <20190828084045.GE4725@mtr-leonro.mtl.com>
References: <20190828074134.17042-1-yuval.shaia@oracle.com>
 <20190828074134.17042-4-yuval.shaia@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828074134.17042-4-yuval.shaia@oracle.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 28, 2019 at 10:41:33AM +0300, Yuval Shaia wrote:
> From: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
>
> As a preparation step to shared PD, where ib_pd object will be pointed
> by one or more ib_uobjects, remove ib_uobject pointer from ib_pd struct.
>
> Signed-off-by: Shamir Rabinovitch <shamir.rabinovitch@oracle.com>
> Signed-off-by: Shamir Rabinovitch <srabinov7@gmail.com>
> ---
>  drivers/infiniband/core/uverbs_cmd.c       | 1 -
>  drivers/infiniband/core/verbs.c            | 1 -
>  drivers/infiniband/hw/hns/hns_roce_hw_v1.c | 1 -
>  drivers/infiniband/hw/mlx5/main.c          | 1 -
>  drivers/infiniband/hw/mthca/mthca_qp.c     | 3 ++-
>  include/rdma/ib_verbs.h                    | 1 -
>  6 files changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> index 204a93305f1c..d1f0c04f0ae8 100644
> --- a/drivers/infiniband/core/uverbs_cmd.c
> +++ b/drivers/infiniband/core/uverbs_cmd.c
> @@ -432,7 +432,6 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
>  	}
>
>  	pd->device  = ib_dev;
> -	pd->uobject = uobj;
>  	pd->__internal_mr = NULL;
>  	atomic_set(&pd->usecnt, 0);
>  	pd->res.type = RDMA_RESTRACK_PD;
> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index f974b6854224..1d0215c1a504 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -263,7 +263,6 @@ struct ib_pd *__ib_alloc_pd(struct ib_device *device, unsigned int flags,
>  		return ERR_PTR(-ENOMEM);
>
>  	pd->device = device;
> -	pd->uobject = NULL;
>  	pd->__internal_mr = NULL;
>  	atomic_set(&pd->usecnt, 0);
>  	pd->flags = flags;
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> index 0ff5f9617639..bd4a09b2ec1e 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v1.c
> @@ -760,7 +760,6 @@ static int hns_roce_v1_rsv_lp_qp(struct hns_roce_dev *hr_dev)
>
>  	free_mr->mr_free_pd = to_hr_pd(pd);
>  	free_mr->mr_free_pd->ibpd.device  = &hr_dev->ib_dev;
> -	free_mr->mr_free_pd->ibpd.uobject = NULL;
>  	free_mr->mr_free_pd->ibpd.__internal_mr = NULL;
>  	atomic_set(&free_mr->mr_free_pd->ibpd.usecnt, 0);
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index 98e566acb746..93db6d4c7da4 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -4937,7 +4937,6 @@ static int create_dev_resources(struct mlx5_ib_resources *devr)
>  		return -ENOMEM;
>
>  	devr->p0->device  = ibdev;
> -	devr->p0->uobject = NULL;
>  	atomic_set(&devr->p0->usecnt, 0);
>
>  	ret = mlx5_ib_alloc_pd(devr->p0, NULL);
> diff --git a/drivers/infiniband/hw/mthca/mthca_qp.c b/drivers/infiniband/hw/mthca/mthca_qp.c
> index d04c245359eb..b1a9169e3af6 100644
> --- a/drivers/infiniband/hw/mthca/mthca_qp.c
> +++ b/drivers/infiniband/hw/mthca/mthca_qp.c
> @@ -956,7 +956,8 @@ static int mthca_max_data_size(struct mthca_dev *dev, struct mthca_qp *qp, int d
>  static inline int mthca_max_inline_data(struct mthca_pd *pd, int max_data_size)
>  {
>  	/* We don't support inline data for kernel QPs (yet). */
> -	return pd->ibpd.uobject ? max_data_size - MTHCA_INLINE_HEADER_SIZE : 0;
> +	return !rdma_is_kernel_res(&pd->ibpd.res) ?
> +		max_data_size - MTHCA_INLINE_HEADER_SIZE : 0;
>  }
>
>  static void mthca_adjust_qp_caps(struct mthca_dev *dev,
> diff --git a/include/rdma/ib_verbs.h b/include/rdma/ib_verbs.h
> index 391499008a22..7b429b2e7cf6 100644
> --- a/include/rdma/ib_verbs.h
> +++ b/include/rdma/ib_verbs.h
> @@ -1509,7 +1509,6 @@ struct ib_pd {
>  	u32			local_dma_lkey;
>  	u32			flags;
>  	struct ib_device       *device;
> -	struct ib_uobject      *uobject;

It doesn't compile, you broke nldev.c

drivers/infiniband/core/nldev.c: In function 'fill_res_pd_entry':
drivers/infiniband/core/nldev.c:638:6: error: 'struct ib_pd' has no member named 'uobject'
    pd->uobject->context->res.id))
      ^~

>  	atomic_t          	usecnt; /* count all resources */
>
>  	u32			unsafe_global_rkey;
> --
> 2.20.1
>
