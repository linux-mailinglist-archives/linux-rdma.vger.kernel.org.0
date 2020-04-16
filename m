Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8FE1ACF64
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Apr 2020 20:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbgDPSKf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Apr 2020 14:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726129AbgDPSKe (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 Apr 2020 14:10:34 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC76C061A0C
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:10:33 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id f13so17086506qti.5
        for <linux-rdma@vger.kernel.org>; Thu, 16 Apr 2020 11:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MH7tW21Kpy4ipgJS8hr+vkIkI1tWZrnbx7KE4rrCqks=;
        b=lrqCsHl0GStrQ011XXCE42T2GTLWlJsgqyO2qXgaxwbJ8fF3O/dGQGjCksTg+b+feQ
         FugUcZ+ltUEAgTo74mDE4wRdlhi4hwiNPgkjE+g/O3L0Mj4ebJTA8HX1puYtts/KMtR0
         KYUSBd1xryiHoCUSwdy0BNsE815aj+FDgfnPRqBl/liYXHOjHKUgivUYNwrOVgnx+M7u
         1mYNVNyETTrq4R1Uy3/1ztAOpJ/E77x1moiKlLuArQ+v7FlFWU6IWFc5ybNfDYe5eAaD
         Vg1J5enkofyFWWkYatoZe8q/67Ds9Si0MMewrcPuxFHvCdWHodftqdpwixvoWi7xXNxU
         KB+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MH7tW21Kpy4ipgJS8hr+vkIkI1tWZrnbx7KE4rrCqks=;
        b=aaPRy222zVEvsPAXjxzhWNo1uVoGjOIdL6bZEUyoFZ95w84Bk+QLZVxsIUgkKq8/sL
         /uJpOVbRy6Cp67Ai3hmi7zm63NlOMQQq1MC3gAkV5gXeG5bcooBh2g4dKBRguT3JEN6u
         uS8gDiUOL5qxx9pUhZtbHmV8GkRgNAwGYQlGGOtSl7QEGPd64cbbwqVj6phhEe8EpX3x
         XiZD2wleF3T1FAKjiHl5HzBRcjgukUUqrPM/BeApfAa/2nG15k8G7luROAzTK2VMkplO
         O6d+7VMn4/IfleB7LaFgmTeEY/lCB1i49EVQ2+40xqBUdpC3xsbPJmuavH7BDeDSswG4
         Cg+A==
X-Gm-Message-State: AGi0PuZEZUN+91Br+6rxE3UUki6NLGa1oRszRwxe8H/YiWa/SKDM1MlQ
        E6zkGYv/mfgYbdpRhR3eWy+LBbjKtCYboQ==
X-Google-Smtp-Source: APiQypLYPq6UI5w5ph6LCC0Qi6+S+/afawNQMaYsUON+WCKBehUq25avR62PG1TWJio5sjOGgA38kQ==
X-Received: by 2002:ac8:65d6:: with SMTP id t22mr9209716qto.241.1587060112765;
        Thu, 16 Apr 2020 11:01:52 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id d1sm15655004qto.66.2020.04.16.11.01.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Apr 2020 11:01:52 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jP8pj-00066g-N0; Thu, 16 Apr 2020 15:01:51 -0300
Date:   Thu, 16 Apr 2020 15:01:51 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jianxin Xiong <jianxin.xiong@intel.com>
Cc:     linux-rdma@vger.kernel.org, Doug Ledford <dledford@redhat.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Leon Romanovsky <leon@kernel.org>
Subject: Re: [RFC PATCH 1/3] RDMA/umem: Support importing dma-buf as user
 memory region
Message-ID: <20200416180151.GU5100@ziepe.ca>
References: <1587056973-101760-1-git-send-email-jianxin.xiong@intel.com>
 <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1587056973-101760-2-git-send-email-jianxin.xiong@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Apr 16, 2020 at 10:09:31AM -0700, Jianxin Xiong wrote:
> Dma-buf, a standard cross-driver buffer sharing mechanism, is chosen to
> be the basis of a non-proprietary approach for supporting RDMA to/from
> buffers allocated from device local memory (e.g. GPU VRAM).
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
> +++ b/drivers/infiniband/Kconfig
> @@ -63,6 +63,16 @@ config INFINIBAND_ON_DEMAND_PAGING
>  	  memory regions without pinning their pages, fetching the
>  	  pages on demand instead.
>  
> +config INFINIBAND_DMABUF
> +	bool "InfiniBand dma-buf support"
> +	depends on INFINIBAND_USER_MEM

select ..some kind of DMABUF symbol...

> +	default n
> +	help
> +	  Support for dma-buf based user memory.
> +	  This allows userspace processes register memory regions
> +	  backed by device memory exported as dma-buf, and thus
> +	  enables RDMA operations using device memory.

See remarks on the cover letter

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

This math validating the user parameters can overflow in various bad
ways

> +	if (!can_do_mlock())
> +		return ERR_PTR(-EPERM);

Why?

> +	umem_dmabuf->umem.ibdev = device;
> +	umem_dmabuf->umem.length = size;
> +	umem_dmabuf->umem.address = addr;
> +	umem_dmabuf->umem.writable = ib_access_writable(access);
> +	umem_dmabuf->umem.is_dmabuf = 1;
> +	umem_dmabuf->umem.owning_mm = current->mm;

Why does this need to store owning_mm?

> +	umem_dmabuf->fd = dmabuf_fd;

Doesn't need to store fd

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

Why is this an EXPORT_SYMBOL?

> diff --git a/include/rdma/ib_umem_dmabuf.h b/include/rdma/ib_umem_dmabuf.h
> new file mode 100644
> index 0000000..e82b205
> +++ b/include/rdma/ib_umem_dmabuf.h

This should not be a public header

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

Probably the ib_umem should be changed to hold a struct sg_table. Not
clear to me why dma_buf wants to allocate this as a pointer..

Also this can be in umem_dmabuf.c

> +static inline struct ib_umem_dmabuf *to_ib_umem_dmabuf(struct ib_umem *umem)
> +{
> +	return container_of(umem, struct ib_umem_dmabuf, umem);
> +}

Put in ummem_dmabuf.c

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

This should be in the existing ib_umem.h

> +
> +static inline void ib_umem_dmabuf_release(struct ib_umem_dmabuf *umem_dmabuf)
> +{
> +}

In uverbs_priv.h

Jason
