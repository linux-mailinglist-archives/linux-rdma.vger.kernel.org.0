Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1849728F65F
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Oct 2020 18:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388686AbgJOQG4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Oct 2020 12:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388357AbgJOQG4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Oct 2020 12:06:56 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95A8AC061755
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 09:06:54 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h7so4200540wre.4
        for <linux-rdma@vger.kernel.org>; Thu, 15 Oct 2020 09:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D8cC18mlTHqJFsKXTazIQXk5u6Tfyu8LoMOhU5TpBnI=;
        b=JFqKm8+Zyl76xWvyW9HpNmTevNSlXXaCWBuy+FJ9Itkn3uHpivEnZfqKjoSE4t/Rc6
         NnVoXfKNMYbiWWrlA4HUjVc6XJEHpoJRlBQyslgzLornXHjfnARlspBlqVTOgbXXZunS
         dli8no3akl1b3oGpnzngFCH2d9ZcBDOpBezzM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D8cC18mlTHqJFsKXTazIQXk5u6Tfyu8LoMOhU5TpBnI=;
        b=crefkw/Hurrt2kKs8Bpo19pVQ8fx2ZlDKec9qdpPfbxWHiER6YIT7+j0er1MSU7cTd
         pJfoI1dnbm6Xzm2BmjVuYcFDn+URuFWZg5G1cq0z8/oOiuoD86/Ciw3YKKfQf/CYit4b
         lWCPQGLFPLKW+tih64eAAm8dQ4kDqFGEhVCsEutyoJjs7lE49H5hFH/yipqopUySgXxK
         8/A6mUZeJ3HtrZpl9ZF+xpXW+P/B9u18iEPt1H6RHxtcUw9Sfl3rt7I2/PDwT6mgeLSy
         7G480JgbemmPvKe9PRPoFFqYydTLhPm9pDcy/cdIW0cKLfqlmux9AcecilnMWi7WlXxV
         7s/g==
X-Gm-Message-State: AOAM533y7bhLtMUj9dtRfrt3BIruvLLf0PeY/ng468zGxdWCRspG8KsN
        V176j6MSAnK80oityBtncDa1qjv5RDwQj2jh
X-Google-Smtp-Source: ABdhPJzfU+EQGr/IktaOMUQ8FHr78ZLS0xqb7+zZmza7+9QVfkbmrbZeMyqz9L4j4eaSuo+yhXUqZw==
X-Received: by 2002:a5d:480a:: with SMTP id l10mr4964799wrq.279.1602778013174;
        Thu, 15 Oct 2020 09:06:53 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id o4sm5341795wrv.8.2020.10.15.09.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2020 09:06:52 -0700 (PDT)
Date:   Thu, 15 Oct 2020 18:06:50 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Doug Ledford <dledford@redhat.com>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Christian Koenig <christian.koenig@amd.com>
Subject: Re: [PATCH v4 1/5] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20201015160650.GB401619@phenom.ffwll.local>
References: <1602692116-106937-1-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1602692116-106937-1-git-send-email-jianxin.xiong@intel.com>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 14, 2020 at 09:15:16AM -0700, Jianxin Xiong wrote:
> Dma-buf is a standard cross-driver buffer sharing mechanism that can be
> used to support peer-to-peer access from RDMA devices.
> 
> Device memory exported via dma-buf is associated with a file descriptor.
> This is passed to the user space as a property associated with the
> buffer allocation. When the buffer is registered as a memory region,
> the file descriptor is passed to the RDMA driver along with other
> parameters.
> 
> Implement the common code for importing dma-buf object and mapping
> dma-buf pages.
> 
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> Acked-by: Christian Koenig <christian.koenig@amd.com>
> ---
>  drivers/infiniband/core/Makefile      |   2 +-
>  drivers/infiniband/core/umem.c        |   4 +
>  drivers/infiniband/core/umem_dmabuf.c | 200 ++++++++++++++++++++++++++++++++++
>  drivers/infiniband/core/umem_dmabuf.h |  11 ++
>  include/rdma/ib_umem.h                |  32 +++++-
>  5 files changed, 247 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/infiniband/core/umem_dmabuf.c
>  create mode 100644 drivers/infiniband/core/umem_dmabuf.h
> 
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> index ccf2670..8ab4eea 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -40,5 +40,5 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
>  				uverbs_std_types_srq.o \
>  				uverbs_std_types_wq.o \
>  				uverbs_std_types_qp.o
> -ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
> +ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o umem_dmabuf.o
>  ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index e9fecbd..8c608a5 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -2,6 +2,7 @@
>   * Copyright (c) 2005 Topspin Communications.  All rights reserved.
>   * Copyright (c) 2005 Cisco Systems.  All rights reserved.
>   * Copyright (c) 2005 Mellanox Technologies. All rights reserved.
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
>   *
>   * This software is available to you under a choice of one of two
>   * licenses.  You may choose to be licensed under the terms of the GNU
> @@ -43,6 +44,7 @@
>  #include <rdma/ib_umem_odp.h>
>  
>  #include "uverbs.h"
> +#include "umem_dmabuf.h"
>  
>  static void __ib_umem_release(struct ib_device *dev, struct ib_umem *umem, int dirty)
>  {
> @@ -269,6 +271,8 @@ void ib_umem_release(struct ib_umem *umem)
>  {
>  	if (!umem)
>  		return;
> +	if (umem->is_dmabuf)
> +		return ib_umem_dmabuf_release(umem);
>  	if (umem->is_odp)
>  		return ib_umem_odp_release(to_ib_umem_odp(umem));
>  
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> new file mode 100644
> index 0000000..4f2303e
> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -0,0 +1,200 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/dma-buf.h>
> +#include <linux/dma-resv.h>
> +#include <linux/dma-mapping.h>
> +
> +#include "uverbs.h"
> +
> +struct ib_umem_dmabuf {
> +	struct ib_umem umem;
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +	const struct ib_umem_dmabuf_ops *ops;
> +	void *device_context;
> +	struct work_struct work;
> +};
> +
> +static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *umem)
> +{
> +	return container_of(umem, struct ib_umem_dmabuf, umem);
> +}
> +
> +int ib_umem_dmabuf_map_pages(struct ib_umem *umem, bool first)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +	struct sg_table *sgt;
> +	struct dma_fence *fence;
> +	int err;
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +
> +	sgt = dma_buf_map_attachment(umem_dmabuf->attach,
> +				     DMA_BIDIRECTIONAL);
> +
> +	if (IS_ERR(sgt)) {
> +		dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +		return PTR_ERR(sgt);
> +	}
> +
> +	umem_dmabuf->umem.sg_head = *sgt;
> +	umem_dmabuf->umem.nmap = sgt->nents;
> +	umem_dmabuf->sgt = sgt;
> +

Maybe you want to put the explanation why we have to first get the mapping
and then wait on it here as a comment, since that's rather non-obvious for
non-gpu people.

Either way I think the dma-buf side of this looks good now, both the map
and unmap side.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> +	fence = dma_resv_get_excl(umem_dmabuf->attach->dmabuf->resv);
> +	if (fence)
> +		dma_fence_wait(fence, false);
> +
> +	if (first)
> +		err = umem_dmabuf->ops->init(umem,
> +					     umem_dmabuf->device_context);
> +	else
> +		err = umem_dmabuf->ops->update(umem,
> +					       umem_dmabuf->device_context);
> +
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +	return err;
> +}
> +
> +int ib_umem_dmabuf_init_mapping(struct ib_umem *umem, void *device_context)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +
> +	umem_dmabuf->device_context = device_context;
> +	return ib_umem_dmabuf_map_pages(umem, true);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_init_mapping);
> +
> +bool ib_umem_dmabuf_mapping_ready(struct ib_umem *umem)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +	bool ret;
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	ret = !!umem_dmabuf->sgt;
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +	return ret;
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_mapping_ready);
> +
> +static void ib_umem_dmabuf_unmap_pages(struct ib_umem *umem, bool do_invalidate)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	if (!umem_dmabuf->sgt)
> +		return;
> +
> +	if (do_invalidate)
> +		umem_dmabuf->ops->invalidate(umem, umem_dmabuf->device_context);
> +
> +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt,
> +				 DMA_BIDIRECTIONAL);
> +	umem_dmabuf->sgt = NULL;
> +}
> +
> +static void ib_umem_dmabuf_work(struct work_struct *work)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	int ret;
> +
> +	umem_dmabuf = container_of(work, struct ib_umem_dmabuf, work);
> +	ret = ib_umem_dmabuf_map_pages(&umem_dmabuf->umem, false);
> +	if (ret)
> +		pr_debug("%s: failed to update dmabuf mapping, error %d\n",
> +			 __func__, ret);
> +}
> +
> +static void ib_umem_dmabuf_invalidate_cb(struct dma_buf_attachment *attach)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = attach->importer_priv;
> +
> +	dma_resv_assert_held(umem_dmabuf->attach->dmabuf->resv);
> +
> +	ib_umem_dmabuf_unmap_pages(&umem_dmabuf->umem, true);
> +	queue_work(ib_wq, &umem_dmabuf->work);
> +}
> +
> +static struct dma_buf_attach_ops ib_umem_dmabuf_attach_ops = {
> +	.allow_peer2peer = 1,
> +	.move_notify = ib_umem_dmabuf_invalidate_cb,
> +};
> +
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access,
> +				   const struct ib_umem_dmabuf_ops *ops)
> +{
> +	struct dma_buf *dmabuf;
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct ib_umem *umem;
> +	unsigned long end;
> +	long ret;
> +
> +	if (check_add_overflow(addr, size, &end))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(PAGE_ALIGN(end) < PAGE_SIZE))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (unlikely(!ops || !ops->invalidate || !ops->update))
> +		return ERR_PTR(-EINVAL);
> +
> +	umem_dmabuf = kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
> +	if (!umem_dmabuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem_dmabuf->ops = ops;
> +	INIT_WORK(&umem_dmabuf->work, ib_umem_dmabuf_work);
> +
> +	umem = &umem_dmabuf->umem;
> +	umem->ibdev = device;
> +	umem->length = size;
> +	umem->address = addr;
> +	umem->writable = ib_access_writable(access);
> +	umem->is_dmabuf = 1;
> +
> +	dmabuf = dma_buf_get(dmabuf_fd);
> +	if (IS_ERR(dmabuf)) {
> +		ret = PTR_ERR(dmabuf);
> +		goto out_free_umem;
> +	}
> +
> +	umem_dmabuf->attach = dma_buf_dynamic_attach(
> +					dmabuf,
> +					device->dma_device,
> +					&ib_umem_dmabuf_attach_ops,
> +					umem_dmabuf);
> +	if (IS_ERR(umem_dmabuf->attach)) {
> +		ret = PTR_ERR(umem_dmabuf->attach);
> +		goto out_release_dmabuf;
> +	}
> +
> +	return umem;
> +
> +out_release_dmabuf:
> +	dma_buf_put(dmabuf);
> +
> +out_free_umem:
> +	kfree(umem_dmabuf);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_get);
> +
> +void ib_umem_dmabuf_release(struct ib_umem *umem)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf = to_ib_umem_dmabuf(umem);
> +	struct dma_buf *dmabuf = umem_dmabuf->attach->dmabuf;
> +
> +	dma_resv_lock(umem_dmabuf->attach->dmabuf->resv, NULL);
> +	ib_umem_dmabuf_unmap_pages(umem, false);
> +	dma_resv_unlock(umem_dmabuf->attach->dmabuf->resv);
> +
> +	dma_buf_detach(dmabuf, umem_dmabuf->attach);
> +	dma_buf_put(dmabuf);
> +	kfree(umem_dmabuf);
> +}
> diff --git a/drivers/infiniband/core/umem_dmabuf.h b/drivers/infiniband/core/umem_dmabuf.h
> new file mode 100644
> index 0000000..485f653
> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.h
> @@ -0,0 +1,11 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef UMEM_DMABUF_H
> +#define UMEM_DMABUF_H
> +
> +void ib_umem_dmabuf_release(struct ib_umem *umem);
> +
> +#endif /* UMEM_DMABUF_H */
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index 7059750..fac8553 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -1,6 +1,7 @@
>  /* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
>  /*
>   * Copyright (c) 2007 Cisco Systems.  All rights reserved.
> + * Copyright (c) 2020 Intel Corporation.  All rights reserved.
>   */
>  
>  #ifndef IB_UMEM_H
> @@ -22,12 +23,19 @@ struct ib_umem {
>  	unsigned long		address;
>  	u32 writable : 1;
>  	u32 is_odp : 1;
> +	u32 is_dmabuf : 1;
>  	struct work_struct	work;
>  	struct sg_table sg_head;
>  	int             nmap;
>  	unsigned int    sg_nents;
>  };
>  
> +struct ib_umem_dmabuf_ops {
> +	int	(*init)(struct ib_umem *umem, void *context);
> +	int	(*update)(struct ib_umem *umem, void *context);
> +	int	(*invalidate)(struct ib_umem *umem, void *context);
> +};
> +
>  /* Returns the offset of the umem start relative to the first page. */
>  static inline int ib_umem_offset(struct ib_umem *umem)
>  {
> @@ -79,6 +87,12 @@ int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t offset,
>  unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>  				     unsigned long pgsz_bitmap,
>  				     unsigned long virt);
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access,
> +				   const struct ib_umem_dmabuf_ops *ops);
> +int ib_umem_dmabuf_init_mapping(struct ib_umem *umem, void *device_context);
> +bool ib_umem_dmabuf_mapping_ready(struct ib_umem *umem);
>  
>  #else /* CONFIG_INFINIBAND_USER_MEM */
>  
> @@ -101,7 +115,23 @@ static inline unsigned long ib_umem_find_best_pgsz(struct ib_umem *umem,
>  {
>  	return 0;
>  }
> +static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +						 unsigned long addr,
> +						 size_t size, int dmabuf_fd,
> +						 int access,
> +						 struct ib_umem_dmabuf_ops *ops)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +static inline int ib_umem_dmabuf_init_mapping(struct ib_umem *umem,
> +					      void *device_context)
> +{
> +	return -EINVAL;
> +}
> +static inline bool ib_umem_dmabuf_mapping_ready(struct ib_umem *umem)
> +{
> +	return false;
> +}
>  
>  #endif /* CONFIG_INFINIBAND_USER_MEM */
> -
>  #endif /* IB_UMEM_H */
> -- 
> 1.8.3.1
> 
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
