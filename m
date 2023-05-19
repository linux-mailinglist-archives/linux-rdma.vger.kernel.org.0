Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA23709D8C
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 19:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229504AbjESRI4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 13:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbjESRIz (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 13:08:55 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A859E73;
        Fri, 19 May 2023 10:08:26 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-54fba751417so1021448eaf.0;
        Fri, 19 May 2023 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684516091; x=1687108091;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1huWkAV6FuLMkFZoFUc2jV0JBX1yJxviSFDa630aSUI=;
        b=NZTBKhwWfXCsnbVFJydIzWTvI8gqNXY7hZXh2onlWfRYFb8AvaI/LurW61SGa3kfF9
         zNuwfu7AB6ovqrLjgJhAEnis4xVPZkuVBpl3RsxcqHVjmnY6c7zbHrI7T3ezjWt6rmLV
         h2ntAJQuohlHtxeRF4Ty/Su4kq/86VqO06kIUSqf2Jrz95EOd+CqXhvFZBnTo5EBKi/K
         92knZgsUYgWLRXwso0BXFrFBY4GmKh+VL4OZTzZYBmRSW94qLy3hRfInaUf8YGFEKcbl
         BnCjNKGPKmlDqfcmqT91GDKiIKVANOMBB5qHjo2DUV3nvxsCkaHzY6hpunaYstndKHI6
         JG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516091; x=1687108091;
        h=content-transfer-encoding:in-reply-to:from:cc:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1huWkAV6FuLMkFZoFUc2jV0JBX1yJxviSFDa630aSUI=;
        b=VqQFfsRDZn9NsRfpDf7XMGEg7Vko06c97gGHhwW0ymW0fS8bTf1cLXf37CZwSGgtJv
         12d+BwHe+mH+oSC3QAlU4w0vBXHmGwQHQMdyOxdnnpbZnfdgL7DjeqOF9NUQvg5xM/OE
         GkKXKSGADxZfcBh8FbOsl6wDxZKKwsYTE/34BVgo+zVle99ne/3lF6FpkabelYJEwKcT
         sFf2FrwNeK1388lXLxVEMBWR2JcjTlnhpwiM+CDUYpSynXiglfX/cTbH1NnnVX85VBTH
         az3I5cyh+2wsJCyFaxaO2l46W6dFWDJvFyDWz11qG7VshLKF6Wm1xJZdrXXZL2QMaPmI
         ok5Q==
X-Gm-Message-State: AC+VfDzCin88x9nPecEfR/4CToXZQYINNRSJ+lPUB5DGIbZwU4ujwZDu
        NB/VAhBAA8LaBTN5knVGVm8=
X-Google-Smtp-Source: ACHHUZ6NQo6oN6AeG//kTa2RBjdJtIq7/7jCuDeLPHgvzI34Dm5ZqWAn/xhimwla2Cdz0CTH4XraqA==
X-Received: by 2002:aca:1907:0:b0:38c:2c70:ab05 with SMTP id l7-20020aca1907000000b0038c2c70ab05mr1251517oii.43.1684516090810;
        Fri, 19 May 2023 10:08:10 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1b3d:4b6b:e581:f922? (2603-8081-140c-1a00-1b3d-4b6b-e581-f922.res6.spectrum.com. [2603:8081:140c:1a00:1b3d:4b6b:e581:f922])
        by smtp.gmail.com with ESMTPSA id q14-20020a9d654e000000b006ac87b54ca4sm1820965otl.34.2023.05.19.10.08.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:08:10 -0700 (PDT)
Message-ID: <8b8ed0fa-1fdb-3cb5-4800-1d9defe9553f@gmail.com>
Date:   Fri, 19 May 2023 12:08:09 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v5 4/7] RDMA/rxe: Add page invalidation support
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <6e9d5e2d1b2a63385d1e4fc2a74c3b11d4909842.1684397037.git.matsuda-daisuke@fujitsu.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, rpearsonhpe@gmail.com,
        Xiao Yang <yangx.jy@fujitsu.com>,
        "lizhijian@fujitsu.com" <lizhijian@fujitsu.com>,
        "y-goto@fujitsu.com" <y-goto@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <6e9d5e2d1b2a63385d1e4fc2a74c3b11d4909842.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 23:07, Daisuke Matsuda wrote:
> On page invalidation, an MMU notifier callback is invoked to unmap DMA
> addresses and update the driver page table(umem_odp->dma_list). It also
> set the corresponding entries in MR xarray to NULL to prevent any access.
> The callback is registered when an ODP-enabled MR is created.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/Makefile  |  2 ++
>  drivers/infiniband/sw/rxe/rxe_odp.c | 56 +++++++++++++++++++++++++++++
>  2 files changed, 58 insertions(+)
>  create mode 100644 drivers/infiniband/sw/rxe/rxe_odp.c
> 
> diff --git a/drivers/infiniband/sw/rxe/Makefile b/drivers/infiniband/sw/rxe/Makefile
> index 5395a581f4bb..93134f1d1d0c 100644
> --- a/drivers/infiniband/sw/rxe/Makefile
> +++ b/drivers/infiniband/sw/rxe/Makefile
> @@ -23,3 +23,5 @@ rdma_rxe-y := \
>  	rxe_task.o \
>  	rxe_net.o \
>  	rxe_hw_counters.o
> +
> +rdma_rxe-$(CONFIG_INFINIBAND_ON_DEMAND_PAGING) += rxe_odp.o
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> new file mode 100644
> index 000000000000..b69b25e0fef6
> --- /dev/null
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -0,0 +1,56 @@
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
> +	unsigned long lower, upper, idx;
> +
> +	lower = rxe_mr_iova_to_index(mr, start);
> +	upper = rxe_mr_iova_to_index(mr, end);
> +
> +	/* make elements in xarray NULL */
> +	spin_lock(&mr->page_list.xa_lock);
> +	for (idx = lower; idx <= upper; idx++)
> +		__xa_erase(&mr->page_list, idx);
> +	spin_unlock(&mr->page_list.xa_lock);
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

Looks good.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

