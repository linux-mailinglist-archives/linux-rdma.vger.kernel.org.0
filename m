Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B40338254D
	for <lists+linux-rdma@lfdr.de>; Mon, 17 May 2021 09:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233256AbhEQH3T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 17 May 2021 03:29:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229755AbhEQH3T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 17 May 2021 03:29:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF12F61007;
        Mon, 17 May 2021 07:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621236483;
        bh=goTEz7nazQW5gDBIA9h8iI3pQneXX7o+6EAS5sNYtmI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RL1vUC9hFzN4clsPbRvEOGnZ/kkc4JsJd84UYZsT9DD5kx4UFt5am4JmHnSxXiPed
         8v4TsCeq6xrcpvVPl+GktbWco0+st4Hj5AzkeRQBQdQGuethFDOIPI9ijerUU1OIhs
         hDsH3UoD45NAjpimb2LKiFtR9uzPf0HVme/UuhC4p8GuQHCvlFyj9x4gKSywcwiU6U
         MsNgChEM9Soz1Twuid+uxnM4NKwJZOpXDRWtEEJ610iF16cTApPBCAU2aLM5IX0Qja
         wIyqjFERrABFcK+kOoF9ikCTrh9mm86uLvFBhiS7ppSldAugKfvXovs86qPXYXWoFn
         6PErF6kNIHENw==
Date:   Mon, 17 May 2021 10:27:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Xi Wang <wangxi11@huawei.com>
Subject: Re: [PATCH for-next 1/7] RDMA/hns: Introduce DCA for RC QP
Message-ID: <YKIa/1BmNmMh5WPx@unreal>
References: <1620650889-61650-1-git-send-email-liweihang@huawei.com>
 <1620650889-61650-2-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620650889-61650-2-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 10, 2021 at 08:48:03PM +0800, Weihang Li wrote:
> From: Xi Wang <wangxi11@huawei.com>
> 
> The hip09 introduces the DCA(Dynamic context attachment) feature which
> supports many RC QPs to share the WQE buffer in a memory pool, this will
> reduce the memory consumption when there are too many QPs are inactive.
> 
> If a QP enables DCA feature, the WQE's buffer will not be allocated when
> creating. But when the users start to post WRs, the hns driver will
> allocate a buffer from the memory pool and then fill WQEs which tagged with
> this QP's number.
> 
> The hns ROCEE will stop accessing the WQE buffer when the user polled all
> of the CQEs for a DCA QP, then the driver will recycle this WQE's buffer
> to the memory pool.
> 
> This patch adds a group of methods to support the user space register
> buffers to a memory pool which belongs to the user context. The hns kernel
> driver will update the pages state in this pool when the user calling the
> post/poll methods and the user driver can get the QP's WQE buffer address
> by the key and offset which queried from kernel.
> 
> Signed-off-by: Xi Wang <wangxi11@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/hns/Makefile          |   2 +-
>  drivers/infiniband/hw/hns/hns_roce_dca.c    | 381 ++++++++++++++++++++++++++++
>  drivers/infiniband/hw/hns/hns_roce_dca.h    |  22 ++
>  drivers/infiniband/hw/hns/hns_roce_device.h |   9 +
>  drivers/infiniband/hw/hns/hns_roce_main.c   |  27 +-
>  include/uapi/rdma/hns-abi.h                 |  27 ++
>  6 files changed, 465 insertions(+), 3 deletions(-)
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.c
>  create mode 100644 drivers/infiniband/hw/hns/hns_roce_dca.h
> 
> diff --git a/drivers/infiniband/hw/hns/Makefile b/drivers/infiniband/hw/hns/Makefile
> index e105945..9962b23 100644
> --- a/drivers/infiniband/hw/hns/Makefile
> +++ b/drivers/infiniband/hw/hns/Makefile
> @@ -6,7 +6,7 @@
>  ccflags-y :=  -I $(srctree)/drivers/net/ethernet/hisilicon/hns3
>  
>  hns-roce-objs := hns_roce_main.o hns_roce_cmd.o hns_roce_pd.o \
> -	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o \
> +	hns_roce_ah.o hns_roce_hem.o hns_roce_mr.o hns_roce_qp.o hns_roce_dca.o \
>  	hns_roce_cq.o hns_roce_alloc.o hns_roce_db.o hns_roce_srq.o hns_roce_restrack.o
>  
>  ifdef CONFIG_INFINIBAND_HNS_HIP06
> diff --git a/drivers/infiniband/hw/hns/hns_roce_dca.c b/drivers/infiniband/hw/hns/hns_roce_dca.c
> new file mode 100644
> index 0000000..2a03cf3
> --- /dev/null
> +++ b/drivers/infiniband/hw/hns/hns_roce_dca.c
> @@ -0,0 +1,381 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2021 Hisilicon Limited. All rights reserved.
> + */
> +
> +#include <rdma/ib_user_verbs.h>
> +#include <rdma/ib_verbs.h>
> +#include <rdma/uverbs_types.h>
> +#include <rdma/uverbs_ioctl.h>
> +#include <rdma/uverbs_std_types.h>
> +#include <rdma/ib_umem.h>
> +#include "hns_roce_device.h"
> +#include "hns_roce_dca.h"
> +
> +#define UVERBS_MODULE_NAME hns_ib
> +#include <rdma/uverbs_named_ioctl.h>
> +
> +/* DCA memory */
> +struct dca_mem {
> +#define DCA_MEM_FLAGS_ALLOCED BIT(0)
> +#define DCA_MEM_FLAGS_REGISTERED BIT(1)
> +	u32 flags;
> +	struct list_head list; /* link to mem list in dca context */
> +	spinlock_t lock; /* protect the @flags and @list */
> +	int page_count; /* page count in this mem obj */
> +	u64 key; /* register by caller */
> +	u32 size; /* bytes in this mem object */
> +	struct hns_dca_page_state *states; /* record each page's state */
> +	void *pages; /* memory handle for getting dma address */
> +};
> +
> +struct dca_mem_attr {
> +	u64 key;
> +	u64 addr;
> +	u32 size;
> +};
> +
> +static inline bool dca_mem_is_free(struct dca_mem *mem)
> +{
> +	return mem->flags == 0;
> +}
> +
> +static inline void set_dca_mem_free(struct dca_mem *mem)
> +{
> +	mem->flags = 0;
> +}
> +
> +static inline void set_dca_mem_alloced(struct dca_mem *mem)
> +{
> +	mem->flags |= DCA_MEM_FLAGS_ALLOCED;
> +}
> +
> +static inline void set_dca_mem_registered(struct dca_mem *mem)
> +{
> +	mem->flags |= DCA_MEM_FLAGS_REGISTERED;
> +}
> +
> +static inline void clr_dca_mem_registered(struct dca_mem *mem)
> +{
> +	mem->flags &= ~DCA_MEM_FLAGS_REGISTERED;
> +}
> +
> +static void free_dca_pages(void *pages)
> +{
> +	ib_umem_release(pages);
> +}

All this oneline madness should go.

Thanks
