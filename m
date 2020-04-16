Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81D331ACF4C
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437455AbgDPSCJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:02:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:55158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2437342AbgDPSCI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 14:02:08 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4127C221EB;
        Thu, 16 Apr 2020 18:02:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587060127;
        bh=AVtRgB+GMkVsrWAgj98CfYkYVfj0lO7tdZtACUeLzhk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ASu5IGv2uMuUSusQP9BoxkwrWor7Pnr+sFIV9USlSWGyMpHtNtAquiNdiouiTfsgF
         MYf7dn99cbXRiw3us4NMZ0yWAt9Qy7vnzTtCWhJtKigZfOLstYk9XHisrLO9wN3w2A
         Z072sJQffpoHK9tmR3aJGbViHSqXs9BtDVpR2N9M=
Date:   Thu, 16 Apr 2020 21:02:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Sumit Semwal <sumit.semwal@linaro.org>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20200416180201.GH1309273@unreal>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 10:09:31AM -0700, Jianxin Xiong wrote:
> Dma-buf, a standard cross-driver buffer sharing mechanism, is chosen to
> be the basis of a non-proprietary approach for supporting RDMA to/from
> buffers allocated from device local memory (e.g. GPU VRAM).

Where can I read more about "is chosen to be the basis of a
non-proprietary approach" part of the sentence?

Especially HMM vs. dma-buf in this regard.

>
> Dma-buf is supported by mainstream GPU drivers. By using ioctl calls
> via the devices under /dev/dri/, user space applications can allocate
> and export GPU buffers as dma-buf objects with associated file
> descriptors.
>
> In order to use the exported GPU buffers for RDMA operations, the RDMA
> driver needs to be able to import dma-buf objects. This happens at the
> time of memory registration. A GPU buffer is registered as a special
> type of user space memory region with the dma-buf file descriptor as
> an extra parameter. The uverbs API needs to be extended to allow the
> extra parameter be passed from user space to kernel.
>
> Implements the common code for pinning and mapping dma-buf pages and
> adds config option for RDMA driver dma-buf support. The common code
> is utilized by the new uverbs commands introduced by follow-up patches.
>
> Signed-off-by: Jianxin Xiong <jianxin.xiong@intel.com>
> Reviewed-by: Sean Hefty <sean.hefty@intel.com>
> Acked-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
> ---
>  drivers/infiniband/Kconfig            |  10 ++++
>  drivers/infiniband/core/Makefile      |   1 +
>  drivers/infiniband/core/umem.c        |   3 +
>  drivers/infiniband/core/umem_dmabuf.c | 100 ++++++++++++++++++++++++++++++++++
>  include/rdma/ib_umem.h                |   2 +
>  include/rdma/ib_umem_dmabuf.h         |  50 +++++++++++++++++
>  6 files changed, 166 insertions(+)
>  create mode 100644 drivers/infiniband/core/umem_dmabuf.c
>  create mode 100644 include/rdma/ib_umem_dmabuf.h
>
> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
> index ade8638..1dcfc59 100644
> --- a/drivers/infiniband/Kconfig
> +++ b/drivers/infiniband/Kconfig
> @@ -63,6 +63,16 @@ config INFINIBAND_ON_DEMAND_PAGING
>  	  memory regions without pinning their pages, fetching the
>  	  pages on demand instead.
>
> +config INFINIBAND_DMABUF

There is no need to add extra config, it is not different from any
other verbs feature which is handled by some sort of mask.

> +	bool "InfiniBand dma-buf support"
> +	depends on INFINIBAND_USER_MEM
> +	default n
> +	help
> +	  Support for dma-buf based user memory.
> +	  This allows userspace processes register memory regions
> +	  backed by device memory exported as dma-buf, and thus
> +	  enables RDMA operations using device memory.
> +
>  config INFINIBAND_ADDR_TRANS
>  	bool "RDMA/CM"
>  	depends on INFINIBAND
> diff --git a/drivers/infiniband/core/Makefile b/drivers/infiniband/core/Makefile
> index d1b14887..7981d0f 100644
> --- a/drivers/infiniband/core/Makefile
> +++ b/drivers/infiniband/core/Makefile
> @@ -39,3 +39,4 @@ ib_uverbs-y :=			uverbs_main.o uverbs_cmd.o uverbs_marshall.o \
>  				uverbs_std_types_async_fd.o
>  ib_uverbs-$(CONFIG_INFINIBAND_USER_MEM) += umem.o
>  ib_uverbs-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += umem_odp.o
> +ib_uverbs-$(CONFIG_INFINIBAND_DMABUF) += umem_dmabuf.o
> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
> index 82455a1..54b35df 100644
> --- a/drivers/infiniband/core/umem.c
> +++ b/drivers/infiniband/core/umem.c
> @@ -40,6 +40,7 @@
>  #include <linux/slab.h>
>  #include <linux/pagemap.h>
>  #include <rdma/ib_umem_odp.h>
> +#include <rdma/ib_umem_dmabuf.h>
>
>  #include "uverbs.h"
>
> @@ -317,6 +318,8 @@ void ib_umem_release(struct ib_umem *umem)
>  {
>  	if (!umem)
>  		return;
> +	if (umem->is_dmabuf)
> +		return ib_umem_dmabuf_release(to_ib_umem_dmabuf(umem));
>  	if (umem->is_odp)
>  		return ib_umem_odp_release(to_ib_umem_odp(umem));
>
> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/infiniband/core/umem_dmabuf.c
> new file mode 100644
> index 0000000..325d44f
> --- /dev/null
> +++ b/drivers/infiniband/core/umem_dmabuf.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause)
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/sched/mm.h>
> +#include <linux/dma-mapping.h>
> +#include <rdma/ib_umem_dmabuf.h>
> +
> +#include "uverbs.h"
> +
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access)
> +{
> +	struct ib_umem_dmabuf *umem_dmabuf;
> +	struct sg_table *sgt;
> +	enum dma_data_direction dir;
> +	long ret;
> +
> +	if (((addr + size) < addr) ||
> +	    PAGE_ALIGN(addr + size) < (addr + size))
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!can_do_mlock())
> +		return ERR_PTR(-EPERM);
> +
> +	if (access & IB_ACCESS_ON_DEMAND)
> +		return ERR_PTR(-EOPNOTSUPP);

Does dma-buf really need to prohibit ODP?

> +
> +	umem_dmabuf = kzalloc(sizeof(*umem_dmabuf), GFP_KERNEL);
> +	if (!umem_dmabuf)
> +		return ERR_PTR(-ENOMEM);
> +
> +	umem_dmabuf->umem.ibdev = device;
> +	umem_dmabuf->umem.length = size;
> +	umem_dmabuf->umem.address = addr;
> +	umem_dmabuf->umem.writable = ib_access_writable(access);
> +	umem_dmabuf->umem.is_dmabuf = 1;
> +	umem_dmabuf->umem.owning_mm = current->mm;
> +	mmgrab(umem_dmabuf->umem.owning_mm);
> +
> +	umem_dmabuf->fd = dmabuf_fd;
> +	umem_dmabuf->dmabuf = dma_buf_get(umem_dmabuf->fd);
> +	if (IS_ERR(umem_dmabuf->dmabuf)) {
> +		ret = PTR_ERR(umem_dmabuf->dmabuf);
> +		goto out_free_umem;
> +	}
> +
> +	umem_dmabuf->attach = dma_buf_attach(umem_dmabuf->dmabuf,
> +					     device->dma_device);
> +	if (IS_ERR(umem_dmabuf->attach)) {
> +		ret = PTR_ERR(umem_dmabuf->attach);
> +		goto out_release_dmabuf;
> +	}
> +
> +	dir = umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
> +	sgt = dma_buf_map_attachment(umem_dmabuf->attach, dir);
> +	if (IS_ERR(sgt)) {
> +		ret = PTR_ERR(sgt);
> +		goto out_detach_dmabuf;
> +	}
> +
> +	umem_dmabuf->sgt = sgt;
> +	umem_dmabuf->umem.sg_head = *sgt;
> +	umem_dmabuf->umem.nmap = sgt->nents;
> +	return &umem_dmabuf->umem;
> +
> +out_detach_dmabuf:
> +	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
> +
> +out_release_dmabuf:
> +	dma_buf_put(umem_dmabuf->dmabuf);
> +
> +out_free_umem:
> +	mmdrop(umem_dmabuf->umem.owning_mm);
> +	kfree(umem_dmabuf);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_get);
> +
> +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
> +{
> +	enum dma_data_direction dir;
> +
> +	dir = umem_dmabuf->umem.writable ? DMA_BIDIRECTIONAL : DMA_FROM_DEVICE;
> +
> +	/*
> +	 * Only use the original sgt returned from dma_buf_map_attachment(),
> +	 * otherwise the scatterlist may be freed twice due to the map caching
> +	 * mechanism.
> +	 */
> +	dma_buf_unmap_attachment(umem_dmabuf->attach, umem_dmabuf->sgt, dir);
> +	dma_buf_detach(umem_dmabuf->dmabuf, umem_dmabuf->attach);
> +	dma_buf_put(umem_dmabuf->dmabuf);
> +	mmdrop(umem_dmabuf->umem.owning_mm);
> +	kfree(umem_dmabuf);
> +}
> +EXPORT_SYMBOL(ib_umem_dmabuf_release);
> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> index e3518fd..026a3cf 100644
> --- a/include/rdma/ib_umem.h
> +++ b/include/rdma/ib_umem.h
> @@ -40,6 +40,7 @@
>
>  struct ib_ucontext;
>  struct ib_umem_odp;
> +struct ib_umem_dmabuf;
>
>  struct ib_umem {
>  	struct ib_device       *ibdev;
> @@ -48,6 +49,7 @@ struct ib_umem {
>  	unsigned long		address;
>  	u32 writable : 1;
>  	u32 is_odp : 1;
> +	u32 is_dmabuf : 1;
>  	struct work_struct	work;
>  	struct sg_table sg_head;
>  	int             nmap;
> diff --git a/include/rdma/ib_umem_dmabuf.h b/include/rdma/ib_umem_dmabuf.h
> new file mode 100644
> index 0000000..e82b205
> --- /dev/null
> +++ b/include/rdma/ib_umem_dmabuf.h
> @@ -0,0 +1,50 @@
> +/* SPDX-License-Identifier: (GPL-2.0 OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2020 Intel Corporation. All rights reserved.
> + */
> +
> +#ifndef IB_UMEM_DMABUF_H
> +#define IB_UMEM_DMABUF_H
> +
> +#include <linux/dma-buf.h>
> +#include <rdma/ib_umem.h>
> +#include <rdma/ib_verbs.h>
> +
> +struct ib_umem_dmabuf {
> +	struct ib_umem	umem;
> +	int		fd;
> +	struct dma_buf	*dmabuf;
> +	struct dma_buf_attachment *attach;
> +	struct sg_table *sgt;
> +};
> +
> +static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *umem)
> +{
> +	return container_of(umem, struct ib_umem_dmabuf, umem);
> +}
> +
> +#ifdef CONFIG_INFINIBAND_DMABUF
> +
> +struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +				   unsigned long addr, size_t size,
> +				   int dmabuf_fd, int access);
> +
> +void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf);
> +
> +#else /* CONFIG_INFINIBAND_DMABUF */
> +
> +static inline struct ib_umem *ib_umem_dmabuf_get(struct ib_device *device,
> +						 unsigned long addr,
> +						 size_t size, int dmabuf_fd,
> +						 int access)
> +{
> +	return ERR_PTR(-EINVAL);
> +}
> +
> +static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
> +{
> +}
> +
> +#endif /* CONFIG_INFINIBAND_DMABUF */
> +
> +#endif /* IB_UMEM_DMABUF_H */
> --
> 1.8.3.1
>
