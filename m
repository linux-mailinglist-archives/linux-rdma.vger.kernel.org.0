Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A74799D25
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Sep 2023 10:30:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231224AbjIJIau (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 10 Sep 2023 04:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232732AbjIJIau (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 10 Sep 2023 04:30:50 -0400
Received: from out-212.mta1.migadu.com (out-212.mta1.migadu.com [95.215.58.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05DBBCF4
        for <linux-rdma@vger.kernel.org>; Sun, 10 Sep 2023 01:30:37 -0700 (PDT)
Message-ID: <5c6b896e-5f8a-9f34-6449-cb30a92ddc1e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1694334636;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i+w6wRWN3+gwr0nYpJ8Y7TWXEMRYzYq8PFgzAa1WHsU=;
        b=SQk9AeiidgWiIPzBpUYvWafAHN+hdacb3MLXBY+jw9T+VPTntbnSXvdynIz3Sl5OeGHXCl
        i5BMgMgkh+joyae4tKoV7B9Lbmfp09w5AORHSVD4flQeZ0/G8nSuQqBdKdxSLTwFOFodk5
        DD7icjMYCx3l1a/dmMbgTV8Op+JkNjo=
Date:   Sun, 10 Sep 2023 16:30:25 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next v6 4/7] RDMA/rxe: Add page invalidation support
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leon@kernel.org, jgg@ziepe.ca,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, rpearsonhpe@gmail.com,
        yangx.jy@fujitsu.com, lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1694153251.git.matsuda-daisuke@fujitsu.com>
 <1566fd3c63e4dac66717731e2c7a80039244e3af.1694153251.git.matsuda-daisuke@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <1566fd3c63e4dac66717731e2c7a80039244e3af.1694153251.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/9/8 14:26, Daisuke Matsuda 写道:
> On page invalidation, an MMU notifier callback is invoked to unmap DMA
> addresses and update the driver page table(umem_odp->dma_list). It also
> sets the corresponding entries in MR xarray to NULL to prevent any access.
> The callback is registered when an ODP-enabled MR is created.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/Makefile  |  2 +
>   drivers/infiniband/sw/rxe/rxe_odp.c | 64 +++++++++++++++++++++++++++++
>   2 files changed, 66 insertions(+)
>   create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
> 
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 5395a581f4bb..93134f1d1d0c 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -23,3 +23,5 @@ rdma_rxe-y := \
>   	rxe_task.o \
>   	rxe_net.o \
>   	rxe_hw_counters.o
> +
> +rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> new file mode 100644
> index 000000000000..834fb1a84800
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -0,0 +1,64 @@
> +// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
> +/*
> + * Copyright (c) 2022-2023 Fujitsu Ltd. All rights reserved.
> + */
> +
> +#include <linux/hmm.h>
> +
> +#include <rdma/ib_umem_odp.h>
> +
> +#include "rxe.h"
> +
> +static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
> +				unsigned long end)
> +{
> +	unsigned long lower = rxe_mr_iova_to_index(mr, start);
> +	unsigned long upper = rxe_mr_iova_to_index(mr, end - 1);
> +	void *entry;

Should follow Reverse Christmas Tree to declare variables.

Zhu Yanjun

> +
> +	XA_STATE(xas, &mr->page_list, lower);
> +
> +	/* make elements in xarray NULL */
> +	xas_lock(&xas);
> +	while (true) {
> +		xas_store(&xas, NULL);
> +
> +		entry = xas_next(&xas);
> +		if (xas_retry(&xas, entry) || (xas.xa_index <= upper))
> +			continue;
> +
> +		break;
> +	}
> +	xas_unlock(&xas);
> +}
> +
> +static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
> +				    const struct mmu_notifier_range *range,
> +				    unsigned long cur_seq)
> +{
> +	struct ib_umem_odp *umem_odp =
> +		container_of(mni, struct ib_umem_odp, notifier);
> +	struct rxe_mr *mr = umem_odp->private;
> +	unsigned long start, end;
> +
> +	if (!mmu_notifier_range_blockable(range))
> +		return false;
> +
> +	mutex_lock(&umem_odp->umem_mutex);
> +	mmu_interval_set_seq(mni, cur_seq);
> +
> +	start = max_t(u64, ib_umem_start(umem_odp), range->start);
> +	end = min_t(u64, ib_umem_end(umem_odp), range->end);
> +
> +	rxe_mr_unset_xarray(mr, start, end);
> +
> +	/* update umem_odp->dma_list */
> +	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
> +
> +	mutex_unlock(&umem_odp->umem_mutex);
> +	return true;
> +}
> +
> +const struct mmu_interval_notifier_ops rxe_mn_ops = {
> +	.invalidate = rxe_ib_invalidate_range,
> +};

