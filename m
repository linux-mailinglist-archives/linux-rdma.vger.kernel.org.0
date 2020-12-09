Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E22D72D3C08
	for <lists+linux-rdma@lfdr.de>; Wed,  9 Dec 2020 08:14:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgLIHOS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 9 Dec 2020 02:14:18 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:8474 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725829AbgLIHOS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 9 Dec 2020 02:14:18 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5fd079150000>; Tue, 08 Dec 2020 23:13:25 -0800
Received: from [172.27.12.60] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Wed, 9 Dec
 2020 07:13:16 +0000
Subject: Re: [PATCH v14 4/4] RDMA/mlx5: Support dma-buf based userspace memory
 region
To:     Jianxin Xiong <jianxin.xiong@intel.com>
CC:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        "Leon Romanovsky" <leon@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        <linux-rdma@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        Yishai Hadas <yishaih@nvidia.com>
References: <1607467155-92725-1-git-send-email-jianxin.xiong@intel.com>
 <1607467155-92725-5-git-send-email-jianxin.xiong@intel.com>
From:   Yishai Hadas <yishaih@nvidia.com>
Message-ID: <225a196a-802b-44e3-3c86-6e14ed12b608@nvidia.com>
Date:   Wed, 9 Dec 2020 09:13:14 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <1607467155-92725-5-git-send-email-jianxin.xiong@intel.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1607498005; bh=i1cv+u87Nd0uULgRUMlk4FTcOMpVOSHSRWHxCt6Sud8=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Transfer-Encoding:
         Content-Language:X-Originating-IP:X-ClientProxiedBy;
        b=JLhoxI7zId7XnsBVKyT+597ItPZdEGYp3aLzD1H51N0ING0sFL7xvz6VK9N75n49m
         vMY09Vo3tc4t2tFTBXZnbH8w3I6LClgyjNFY4adB9NYBncdsfKAGi65NcrynacrVyI
         89ZInduFLLaV9LzL83Nh9Jj7kZxApYyLj4zpgfeJUi9G6tpZh73PPxVxy8zYmWONxy
         zdsR5jDbBaUZu1tTr8o2G5XxTHus9wcysCDvP0eHOXH++9b/HAPEueoRa3A0HgnG3o
         h7YrvAaPlAIEXoTO0AZ69j677nLJrGKU8FwACDbFiR3sxbWlRMUGnM8w38BA1zM6cI
         M5P3cewVgMdhw==
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 12/9/2020 12:39 AM, Jianxin Xiong wrote:
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
> ---
>   drivers/infiniband/hw/mlx5/main.c    |   2 +
>   drivers/infiniband/hw/mlx5/mlx5_ib.h |  18 +++++
>   drivers/infiniband/hw/mlx5/mr.c      | 128 ++++++++++++++++++++++++++++=
+++++--
>   drivers/infiniband/hw/mlx5/odp.c     |  86 +++++++++++++++++++++--
>   4 files changed, 225 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/ml=
x5/main.c
> index 4a054eb..c025746 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -1,6 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
>   /*
>    * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reser=
ved.
> + * Copyright (c) 2020, Intel Corporation. All rights reserved.
>    */
>  =20
>   #include <linux/debugfs.h>
> @@ -4069,6 +4070,7 @@ static int mlx5_ib_enable_driver(struct ib_device *=
dev)
>   	.query_srq =3D mlx5_ib_query_srq,
>   	.query_ucontext =3D mlx5_ib_query_ucontext,
>   	.reg_user_mr =3D mlx5_ib_reg_user_mr,
> +	.reg_user_mr_dmabuf =3D mlx5_ib_reg_user_mr_dmabuf,
>   	.req_notify_cq =3D mlx5_ib_arm_cq,
>   	.rereg_user_mr =3D mlx5_ib_rereg_user_mr,
>   	.resize_cq =3D mlx5_ib_resize_cq,
> diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw=
/mlx5/mlx5_ib.h
> index 718e59f..6f4d1b4 100644
> --- a/drivers/infiniband/hw/mlx5/mlx5_ib.h
> +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> @@ -1,6 +1,7 @@
>   /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>   /*
>    * Copyright (c) 2013-2020, Mellanox Technologies inc. All rights reser=
ved.
> + * Copyright (c) 2020, Intel Corporation. All rights reserved.
>    */
>  =20
>   #ifndef MLX5_IB_H
> @@ -704,6 +705,12 @@ static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
>   	       mr->umem->is_odp;
>   }
>  =20
> +static inline bool is_dmabuf_mr(struct mlx5_ib_mr *mr)
> +{
> +	return IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING) && mr->umem &&
> +	       mr->umem->is_dmabuf;
> +}
> +


Didn't we agree that IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)=20
should be checked earlier

upon mlx5_ib_reg_user_mr_dmabuf () to fully prevent the functionality=20
when ODP is not supported=C2=A0 ? see note on previous versions.


>   struct mlx5_ib_mw {
>   	struct ib_mw		ibmw;
>   	struct mlx5_core_mkey	mmkey;
> @@ -1239,6 +1246,10 @@ int mlx5_ib_create_cq(struct ib_cq *ibcq, const st=
ruct ib_cq_init_attr *attr,
>   struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd, u64 start, u64 leng=
th,
>   				  u64 virt_addr, int access_flags,
>   				  struct ib_udata *udata);
> +struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 start,
> +					 u64 length, u64 virt_addr,
> +					 int fd, int access_flags,
> +					 struct ib_udata *udata);
>   int mlx5_ib_advise_mr(struct ib_pd *pd,
>   		      enum ib_uverbs_advise_mr_advice advice,
>   		      u32 flags,
> @@ -1249,11 +1260,13 @@ int mlx5_ib_advise_mr(struct ib_pd *pd,
>   int mlx5_ib_dealloc_mw(struct ib_mw *mw);
>   int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 idx, int npages,
>   		       int page_shift, int flags);
> +int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags);
>   struct mlx5_ib_mr *mlx5_ib_alloc_implicit_mr(struct mlx5_ib_pd *pd,
>   					     struct ib_udata *udata,
>   					     int access_flags);
>   void mlx5_ib_free_implicit_mr(struct mlx5_ib_mr *mr);
>   void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr);
> +void mlx5_ib_fence_dmabuf_mr(struct mlx5_ib_mr *mr);
>   int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int flags, u64 start,
>   			  u64 length, u64 virt_addr, int access_flags,
>   			  struct ib_pd *pd, struct ib_udata *udata);
> @@ -1341,6 +1354,7 @@ int mlx5_ib_advise_mr_prefetch(struct ib_pd *pd,
>   			       enum ib_uverbs_advise_mr_advice advice,
>   			       u32 flags, struct ib_sge *sg_list, u32 num_sge);
>   int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, bool enable);
> +int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr);
>   #else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>   static inline void mlx5_ib_internal_fill_odp_caps(struct mlx5_ib_dev *d=
ev)
>   {
> @@ -1366,6 +1380,10 @@ static inline int mlx5_ib_init_odp_mr(struct mlx5_=
ib_mr *mr, bool enable)
>   {
>   	return -EOPNOTSUPP;
>   }
> +static inline int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
>  =20
>   extern const struct mmu_interval_notifier_ops mlx5_mn_ops;
> diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5=
/mr.c
> index b6116f6..e3be1f5 100644
> --- a/drivers/infiniband/hw/mlx5/mr.c
> +++ b/drivers/infiniband/hw/mlx5/mr.c
> @@ -1,5 +1,6 @@
>   /*
>    * Copyright (c) 2013-2015, Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2020, Intel Corporation. All rights reserved.
>    *
>    * This software is available to you under a choice of one of two
>    * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -36,6 +37,8 @@
>   #include <linux/debugfs.h>
>   #include <linux/export.h>
>   #include <linux/delay.h>
> +#include <linux/dma-buf.h>
> +#include <linux/dma-resv.h>
>   #include <rdma/ib_umem.h>
>   #include <rdma/ib_umem_odp.h>
>   #include <rdma/ib_verbs.h>
> @@ -957,6 +960,16 @@ static struct mlx5_cache_ent *mr_cache_ent_from_orde=
r(struct mlx5_ib_dev *dev,
>   	return &cache->ent[order];
>   }
>  =20
> +static unsigned int mlx5_umem_dmabuf_default_pgsz(struct ib_umem *umem,
> +						  u64 iova)
> +{
> +	if ((iova ^ umem->address) & (PAGE_SIZE - 1))
> +		return 0;
> +


Also here, see my note from previous versions, can user space trigger=20
this by supplying some invalid input ?

If so, this may cause a WARN_ON() in the caller=20
(i.e.alloc_mr_from_cache) that we should prevent from being triggered by=20
user space application.


> +	umem->iova =3D iova;
> +	return PAGE_SIZE;
> +}
> +
>   static struct mlx5_ib_mr *alloc_mr_from_cache(struct ib_pd *pd,
>   					      struct ib_umem *umem, u64 iova,
>   					      int access_flags)
> @@ -966,7 +979,11 @@ static struct mlx5_ib_mr *alloc_mr_from_cache(struct=
 ib_pd *pd,
>   	struct mlx5_ib_mr *mr;
>   	unsigned int page_size;
>  =20
> -	page_size =3D mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iov=
a);
> +	if (umem->is_dmabuf)
> +		page_size =3D mlx5_umem_dmabuf_default_pgsz(umem, iova);
> +	else
> +		page_size =3D mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
> +						     0, iova);
>   	if (WARN_ON(!page_size))
>   		return ERR_PTR(-EINVAL);
>   	ent =3D mr_cache_ent_from_order(
> @@ -1212,8 +1229,10 @@ int mlx5_ib_update_xlt(struct mlx5_ib_mr *mr, u64 =
idx, int npages,
>  =20
>   /*
>    * Send the DMA list to the HW for a normal MR using UMR.
> + * Dmabuf MR is handled in a similar way, except that the MLX5_IB_UPD_XL=
T_ZAP
> + * flag may be used.
>    */
> -static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int fla=
gs)
> +int mlx5_ib_update_mr_pas(struct mlx5_ib_mr *mr, unsigned int flags)
>   {
>   	struct mlx5_ib_dev *dev =3D mr->dev;
>   	struct device *ddev =3D &dev->mdev->pdev->dev;
> @@ -1255,6 +1274,10 @@ static int mlx5_ib_update_mr_pas(struct mlx5_ib_mr=
 *mr, unsigned int flags)
>   		cur_mtt->ptag =3D
>   			cpu_to_be64(rdma_block_iter_dma_address(&biter) |
>   				    MLX5_IB_MTT_PRESENT);
> +
> +		if (mr->umem->is_dmabuf && (flags & MLX5_IB_UPD_XLT_ZAP))
> +			cur_mtt->ptag =3D 0;
> +
>   		cur_mtt++;
>   	}
>  =20
> @@ -1291,8 +1314,11 @@ static struct mlx5_ib_mr *reg_create(struct ib_mr =
*ibmr, struct ib_pd *pd,
>   	int err;
>   	bool pg_cap =3D !!(MLX5_CAP_GEN(dev->mdev, pg));
>  =20
> -	page_size =3D
> -		mlx5_umem_find_best_pgsz(umem, mkc, log_page_size, 0, iova);
> +	if (umem->is_dmabuf)
> +		page_size =3D mlx5_umem_dmabuf_default_pgsz(umem, iova);
> +	else
> +		page_size =3D mlx5_umem_find_best_pgsz(umem, mkc, log_page_size,
> +						     0, iova);
>   	if (WARN_ON(!page_size))
>   		return ERR_PTR(-EINVAL);
>  =20
> @@ -1572,6 +1598,96 @@ struct ib_mr *mlx5_ib_reg_user_mr(struct ib_pd *pd=
, u64 start, u64 length,
>   	return ERR_PTR(err);
>   }
>  =20
> +static void mlx5_ib_dmabuf_invalidate_cb(struct dma_buf_attachment *atta=
ch)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf =3D attach->importer_priv;
> +	struct mlx5_ib_mr *mr =3D umem_dmabuf->private;
> +
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!umem_dmabuf->sgt)
> +		return;
> +
> +	mlx5_ib_update_mr_pas(mr, MLX5_IB_UPD_XLT_ZAP);
> +	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
> +}
> +
> +static struct dma_buf_attach_ops mlx5_ib_dmabuf_attach_ops =3D {
> +	.allow_peer2peer =3D 1,
> +	.move_notify =3D mlx5_ib_dmabuf_invalidate_cb,
> +};
> +
> +struct ib_mr *mlx5_ib_reg_user_mr_dmabuf(struct ib_pd *pd, u64 offset,
> +					 u64 length, u64 virt_addr,
> +					 int fd, int access_flags,
> +					 struct ib_udata *udata)
> +{
> +	struct mlx5_ib_dev *dev =3D to_mdev(pd->device);
> +	struct mlx5_ib_mr *mr =3D NULL;
> +	struct ib_umem *umem;
> +	int err;
> +
> +	if (!IS_ENABLED(CONFIG_INFINIBAND_USER_MEM))
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	mlx5_ib_dbg(dev,
> +		    "offset 0x%llx, virt_addr 0x%llx, length 0x%llx, fd %d, access_fla=
gs 0x%x\n",
> +		    offset, virt_addr, length, fd, access_flags);
> +
> +	if (!mlx5_ib_can_load_pas_with_umr(dev, length))
> +		return ERR_PTR(-EINVAL);
> +
> +	umem =3D ib_umem_dmabuf_get(&dev->ib_dev, offset, length, fd, access_fl=
ags,
> +				  &mlx5_ib_dmabuf_attach_ops);
> +	if (IS_ERR(umem)) {
> +		mlx5_ib_dbg(dev, "umem get failed (%ld)\n", PTR_ERR(umem));
> +		return ERR_PTR(PTR_ERR(umem));
> +	}
> +
> +	mr =3D alloc_mr_from_cache(pd, umem, virt_addr, access_flags);
> +	if (IS_ERR(mr))
> +		mr =3D NULL;
> +
> +	if (!mr) {
> +		mutex_lock(&dev->slow_path_mutex);
> +		mr =3D reg_create(NULL, pd, umem, virt_addr, access_flags,
> +				false);
> +		mutex_unlock(&dev->slow_path_mutex);
> +	}
> +
> +	if (IS_ERR(mr)) {
> +		err =3D PTR_ERR(mr);
> +		goto error;
> +	}
> +
> +	mlx5_ib_dbg(dev, "mkey 0x%x\n", mr->mmkey.key);
> +
> +	mr->umem =3D umem;
> +	atomic_add(ib_umem_num_pages(mr->umem), &dev->mdev->priv.reg_pages);
> +	set_mr_fields(dev, mr, length, access_flags);
> +
> +	to_ib_umem_dmabuf(umem)->private =3D mr;
> +	init_waitqueue_head(&mr->q_deferred_work);
> +	atomic_set(&mr->num_deferred_work, 0);
> +	err =3D xa_err(xa_store(&dev->odp_mkeys,
> +			      mlx5_base_mkey(mr->mmkey.key), &mr->mmkey,
> +			      GFP_KERNEL));
> +	if (err) {
> +		dereg_mr(dev, mr);
> +		return ERR_PTR(err);
> +	}
> +
> +	err =3D mlx5_ib_init_dmabuf_mr(mr);
> +	if (err) {
> +		dereg_mr(dev, mr);
> +		return ERR_PTR(err);
> +	}
> +	return &mr->ibmr;
> +error:
> +	ib_umem_release(umem);
> +	return ERR_PTR(err);
> +}
> +
>   /**
>    * mlx5_mr_cache_invalidate - Fence all DMA on the MR
>    * @mr: The MR to fence
> @@ -1640,7 +1756,7 @@ int mlx5_ib_rereg_user_mr(struct ib_mr *ib_mr, int =
flags, u64 start,
>   	if (!mr->umem)
>   		return -EINVAL;
>  =20
> -	if (is_odp_mr(mr))
> +	if (is_odp_mr(mr) || is_dmabuf_mr(mr))
>   		return -EOPNOTSUPP;
>  =20
>   	if (flags & IB_MR_REREG_TRANS) {
> @@ -1804,6 +1920,8 @@ static void dereg_mr(struct mlx5_ib_dev *dev, struc=
t mlx5_ib_mr *mr)
>   	/* Stop all DMA */
>   	if (is_odp_mr(mr))
>   		mlx5_ib_fence_odp_mr(mr);
> +	else if (is_dmabuf_mr(mr))
> +		mlx5_ib_fence_dmabuf_mr(mr);
>   	else
>   		clean_mr(dev, mr);
>  =20
> diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx=
5/odp.c
> index 5c853ec..35d6770 100644
> --- a/drivers/infiniband/hw/mlx5/odp.c
> +++ b/drivers/infiniband/hw/mlx5/odp.c
> @@ -33,6 +33,8 @@
>   #include <rdma/ib_umem.h>
>   #include <rdma/ib_umem_odp.h>
>   #include <linux/kernel.h>
> +#include <linux/dma-buf.h>
> +#include <linux/dma-resv.h>
>  =20
>   #include "mlx5_ib.h"
>   #include "cmd.h"
> @@ -664,6 +666,37 @@ void mlx5_ib_fence_odp_mr(struct mlx5_ib_mr *mr)
>   	dma_fence_odp_mr(mr);
>   }
>  =20
> +/**
> + * mlx5_ib_fence_dmabuf_mr - Stop all access to the dmabuf MR
> + * @mr: to fence
> + *
> + * On return no parallel threads will be touching this MR and no DMA wil=
l be
> + * active.
> + */
> +void mlx5_ib_fence_dmabuf_mr(struct mlx5_ib_mr *mr)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf =3D to_ib_umem_dmabuf(mr->umem);
> +
> +	/* Prevent new page faults and prefetch requests from succeeding */
> +	xa_erase(&mr->dev->odp_mkeys, mlx5_base_mkey(mr->mmkey.key));
> +
> +	/* Wait for all running page-fault handlers to finish. */
> +	synchronize_srcu(&mr->dev->odp_srcu);
> +
> +	wait_event(mr->q_deferred_work, !atomic_read(&mr->num_deferred_work));
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	mlx5_mr_cache_invalidate(mr);
> +	umem_dmabuf->private =3D NULL;
> +	ib_umem_dmabuf_unmap_pages(umem_dmabuf);
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!mr->cache_ent) {
> +		mlx5_core_destroy_mkey(mr->dev->mdev, &mr->mmkey);
> +		WARN_ON(mr->descs);
> +	}
> +}
> +
>   #define MLX5_PF_FLAGS_DOWNGRADE BIT(1)
>   #define MLX5_PF_FLAGS_SNAPSHOT BIT(2)
>   #define MLX5_PF_FLAGS_ENABLE BIT(3)
> @@ -797,6 +830,41 @@ static int pagefault_implicit_mr(struct mlx5_ib_mr *=
imr,
>   	return ret;
>   }
>  =20
> +static int pagefault_dmabuf_mr(struct mlx5_ib_mr *mr, size_t bcnt,
> +			       u32 *bytes_mapped, u32 flags)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf =3D to_ib_umem_dmabuf(mr->umem);
> +	u32 xlt_flags =3D 0;
> +	int err;
> +	unsigned int page_size;
> +
> +	if (flags & MLX5_PF_FLAGS_ENABLE)
> +		xlt_flags |=3D MLX5_IB_UPD_XLT_ENABLE;
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	err =3D ib_umem_dmabuf_map_pages(umem_dmabuf);
> +	if (!err) {
> +		page_size =3D mlx5_umem_find_best_pgsz(&umem_dmabuf->umem, mkc,
> +						     log_page_size, 0,
> +						     umem_dmabuf->umem.iova);
> +		if (unlikely(page_size < PAGE_SIZE)) {
> +			ib_umem_dmabuf_unmap_pages(umem_dmabuf);
> +			err =3D -EINVAL;
> +		} else {
> +			err =3D mlx5_ib_update_mr_pas(mr, xlt_flags);
> +		}
> +	}
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (err)
> +		return err;
> +
> +	if (bytes_mapped)
> +		*bytes_mapped +=3D bcnt;
> +
> +	return ib_umem_num_pages(mr->umem);
> +}
> +
>   /*
>    * Returns:
>    *  -EFAULT: The io_virt->bcnt is not within the MR, it covers pages th=
at are
> @@ -815,6 +883,9 @@ static int pagefault_mr(struct mlx5_ib_mr *mr, u64 io=
_virt, size_t bcnt,
>   	if (unlikely(io_virt < mr->mmkey.iova))
>   		return -EFAULT;
>  =20
> +	if (mr->umem->is_dmabuf)
> +		return pagefault_dmabuf_mr(mr, bcnt, bytes_mapped, flags);
> +
>   	if (!odp->is_implicit_odp) {
>   		u64 user_va;
>  =20
> @@ -845,6 +916,16 @@ int mlx5_ib_init_odp_mr(struct mlx5_ib_mr *mr, bool =
enable)
>   	return ret >=3D 0 ? 0 : ret;
>   }
>  =20
> +int mlx5_ib_init_dmabuf_mr(struct mlx5_ib_mr *mr)
> +{
> +	int ret;
> +
> +	ret =3D pagefault_dmabuf_mr(mr, mr->umem->length, NULL,
> +				  MLX5_PF_FLAGS_ENABLE);
> +
> +	return ret >=3D 0 ? 0 : ret;
> +}
> +
>   struct pf_frame {
>   	struct pf_frame *next;
>   	u32 key;
> @@ -1747,7 +1828,6 @@ static void destroy_prefetch_work(struct prefetch_m=
r_work *work)
>   {
>   	struct mlx5_ib_dev *dev =3D to_mdev(pd->device);
>   	struct mlx5_core_mkey *mmkey;
> -	struct ib_umem_odp *odp;
>   	struct mlx5_ib_mr *mr;
>  =20
>   	lockdep_assert_held(&dev->odp_srcu);
> @@ -1761,11 +1841,9 @@ static void destroy_prefetch_work(struct prefetch_=
mr_work *work)
>   	if (mr->ibmr.pd !=3D pd)
>   		return NULL;
>  =20
> -	odp =3D to_ib_umem_odp(mr->umem);
> -
>   	/* prefetch with write-access must be supported by the MR */
>   	if (advice =3D=3D IB_UVERBS_ADVISE_MR_ADVICE_PREFETCH_WRITE &&
> -	    !odp->umem.writable)
> +	    !mr->umem->writable)
>   		return NULL;
>  =20
>   	return mr;


