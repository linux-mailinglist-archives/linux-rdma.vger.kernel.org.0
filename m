Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72BC709D93
	for <lists+linux-rdma@lfdr.de>; Fri, 19 May 2023 19:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjESRKA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 19 May 2023 13:10:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbjESRJj (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 19 May 2023 13:09:39 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3898410D9;
        Fri, 19 May 2023 10:09:37 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19a53345720so473906fac.1;
        Fri, 19 May 2023 10:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684516176; x=1687108176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9yh3tXpDdp1m1DcnMgvMepxVXROzuI/LH56qyr/pVpQ=;
        b=sqFlAWAoIYegiaQiEpvb+C7aL84Fwbz3xY3HsXxawWpUQNuXEvt+w5n52jcoALvjCY
         rzKb7pg1A5YQJEZwBVOHiy1vBgsEXt9rsyfeXb8y2/uWjhOBCWgZV6nQFg5kQoxiS2kP
         3W10d5GXqvF+ZJEj+6T93MjKxReXSUui1TbL95OhCtpY8eEH0k0lDbQhvR/X+it5CtTK
         BI7RULxNYsjcyNnZjyye5jTItDEFh52SILxg4CSWT/FZa7qrm8TC7PJEhG81MDguvPpu
         igqRjBej/QQHi/M8eKTHZF9ZggXlOLPDfKJy9jUe+8FDzo8R5gJcQxBEXWCEV8F7sxPu
         nBSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684516176; x=1687108176;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9yh3tXpDdp1m1DcnMgvMepxVXROzuI/LH56qyr/pVpQ=;
        b=Blyg0tc+KjqPcZjX8mqEVe+aW4ghcrLBYQWnu5HoinEJEx7KhbS4WuJKVyFMuSZAc2
         dcVcr493JoS8/mKFtZUpVsPeWMvb9HFNLJ+DFoKlA6O5nEKAmk8H8LjCMpNe6krw03gb
         M+2lbzNlFSXtR0rlaQH+zAIsuER/lmRPqxsRDPuh9OLYsoDSKlbxPt64uQTaiEpVjXbW
         zdDriVp5xvLU7n3JtTAvrjRJLGCEZTIf2zhwjaGq6pwZTbIoIflBB6Wst56YWaUpTQvL
         qV2+psOzInt6fAllJcl/sB8lFwimyfpDCYzajkgtd9LJ3Kt6wIbq0ns88izroiDpyGBt
         e+SQ==
X-Gm-Message-State: AC+VfDxtMk0oasv1k6TEulWKrq778Wa78K5CkmWSVgGGKRNZNgneBNZX
        u5Bknk8PGiRWUpaPvFk+NDAJHedf3KfFKQ==
X-Google-Smtp-Source: ACHHUZ6AjHkCRAfWe4/Zjs1mj00UipS7igYWT9dSuGPMxkinl/JoctgjeVutCrK4s1eRZBdswWGipg==
X-Received: by 2002:a05:6870:d303:b0:196:9112:7853 with SMTP id f3-20020a056870d30300b0019691127853mr1391952oag.36.1684516176154;
        Fri, 19 May 2023 10:09:36 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1b3d:4b6b:e581:f922? (2603-8081-140c-1a00-1b3d-4b6b-e581-f922.res6.spectrum.com. [2603:8081:140c:1a00:1b3d:4b6b:e581:f922])
        by smtp.gmail.com with ESMTPSA id d44-20020a056870d2ac00b001964cb38d37sm2146324oae.11.2023.05.19.10.09.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 10:09:35 -0700 (PDT)
Message-ID: <2806a097-1a8f-595c-fad8-6cb7ec5f4172@gmail.com>
Date:   Fri, 19 May 2023 12:09:34 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next v5 5/7] RDMA/rxe: Allow registering MRs for
 On-Demand Paging
Content-Language: en-US
To:     Daisuke Matsuda <matsuda-daisuke@fujitsu.com>,
        linux-rdma@vger.kernel.org, leonro@nvidia.com, jgg@nvidia.com,
        zyjzyj2000@gmail.com
Cc:     linux-kernel@vger.kernel.org, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, y-goto@fujitsu.com
References: <cover.1684397037.git.matsuda-daisuke@fujitsu.com>
 <7d8595c23e954e0fdc19b14e95da13ceef2adafd.1684397037.git.matsuda-daisuke@fujitsu.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <7d8595c23e954e0fdc19b14e95da13ceef2adafd.1684397037.git.matsuda-daisuke@fujitsu.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 5/18/23 03:21, Daisuke Matsuda wrote:
> Allow applications to register an ODP-enabled MR, in which case the flag
> IB_ACCESS_ON_DEMAND is passed to rxe_reg_user_mr(). However, there is no
> RDMA operation supported right now. They will be enabled later in the
> subsequent two patches.
> 
> rxe_odp_do_pagefault() is called to initialize an ODP-enabled MR. It syncs
> process address space from the CPU page table to the driver page table
> (dma_list/pfn_list in umem_odp) when called with RXE_PAGEFAULT_SNAPSHOT
> flag. Additionally, It can be used to trigger page fault when pages being
> accessed are not present or do not have proper read/write permissions, and
> possibly to prefetch pages in the future.
> 
> Signed-off-by: Daisuke Matsuda <matsuda-daisuke@fujitsu.com>
> ---
>  drivers/infiniband/sw/rxe/rxe.c       |   7 ++
>  drivers/infiniband/sw/rxe/rxe_loc.h   |  14 +++
>  drivers/infiniband/sw/rxe/rxe_mr.c    |   9 +-
>  drivers/infiniband/sw/rxe/rxe_odp.c   | 120 ++++++++++++++++++++++++++
>  drivers/infiniband/sw/rxe/rxe_resp.c  |  15 +++-
>  drivers/infiniband/sw/rxe/rxe_verbs.c |   5 +-
>  drivers/infiniband/sw/rxe/rxe_verbs.h |   2 +
>  7 files changed, 166 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index 54c723a6edda..f2284d27229b 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -73,6 +73,13 @@ static void rxe_init_device_param(struct rxe_dev *rxe)
>  			rxe->ndev->dev_addr);
>  
>  	rxe->max_ucontext			= RXE_MAX_UCONTEXT;
> +
> +	if (IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING)) {
> +		rxe->attr.kernel_cap_flags |= IBK_ON_DEMAND_PAGING;
> +
> +		/* IB_ODP_SUPPORT_IMPLICIT is not supported right now. */
> +		rxe->attr.odp_caps.general_caps |= IB_ODP_SUPPORT;
> +	}
>  }
>  
>  /* initialize port attributes */
> diff --git a/drivers/infiniband/sw/rxe/rxe_loc.h b/drivers/infiniband/sw/rxe/rxe_loc.h
> index 00fedd1a4980..93247d123642 100644
> --- a/drivers/infiniband/sw/rxe/rxe_loc.h
> +++ b/drivers/infiniband/sw/rxe/rxe_loc.h
> @@ -202,4 +202,18 @@ static inline unsigned int wr_opcode_mask(int opcode, struct rxe_qp *qp)
>  	return rxe_wr_opcode_info[opcode].mask[qp->ibqp.qp_type];
>  }
>  
> +/* rxe_odp.c */
> +#ifdef CONFIG_INFINIBAND_ON_DEMAND_PAGING
> +int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
> +			 u64 iova, int access_flags, struct rxe_mr *mr);
> +#else /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
> +static inline int
> +rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length, u64 iova,
> +		     int access_flags, struct rxe_mr *mr)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +#endif /* CONFIG_INFINIBAND_ON_DEMAND_PAGING */
> +
>  #endif /* RXE_LOC_H */
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index ffbac6f5e828..cd368cd096c8 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -318,7 +318,10 @@ int rxe_mr_copy(struct rxe_mr *mr, u64 iova, void *addr,
>  		return err;
>  	}
>  
> -	return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
> +	if (mr->odp_enabled)
> +		return -EOPNOTSUPP;
> +	else
> +		return rxe_mr_copy_xarray(mr, iova, addr, length, dir);
>  }
>  
>  /* copy data in or out of a wqe, i.e. sg list
> @@ -527,6 +530,10 @@ int rxe_mr_do_atomic_write(struct rxe_mr *mr, u64 iova, u64 value)
>  	struct page *page;
>  	u64 *va;
>  
> +	/* ODP is not supported right now. WIP. */
> +	if (mr->odp_enabled)
> +		return RESPST_ERR_UNSUPPORTED_OPCODE;
> +
>  	/* See IBA oA19-28 */
>  	if (unlikely(mr->state != RXE_MR_STATE_VALID)) {
>  		rxe_dbg_mr(mr, "mr not in valid state");
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index b69b25e0fef6..e5497d09c399 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -24,6 +24,24 @@ static void rxe_mr_unset_xarray(struct rxe_mr *mr, unsigned long start,
>  	spin_unlock(&mr->page_list.xa_lock);
>  }
>  
> +static void rxe_mr_set_xarray(struct rxe_mr *mr, unsigned long start,
> +			      unsigned long end, unsigned long *pfn_list)
> +{
> +	unsigned long lower, upper, idx;
> +	struct page *page;
> +
> +	lower = rxe_mr_iova_to_index(mr, start);
> +	upper = rxe_mr_iova_to_index(mr, end);
> +
> +	/* make pages visible in xarray. no sleep while taking the lock */
> +	spin_lock(&mr->page_list.xa_lock);
> +	for (idx = lower; idx <= upper; idx++) {
> +		page = hmm_pfn_to_page(pfn_list[idx]);
> +		__xa_store(&mr->page_list, idx, page, GFP_ATOMIC);
> +	}
> +	spin_unlock(&mr->page_list.xa_lock);
> +}
> +
>  static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
>  				    const struct mmu_notifier_range *range,
>  				    unsigned long cur_seq)
> @@ -54,3 +72,105 @@ static bool rxe_ib_invalidate_range(struct mmu_interval_notifier *mni,
>  const struct mmu_interval_notifier_ops rxe_mn_ops = {
>  	.invalidate = rxe_ib_invalidate_range,
>  };
> +
> +#define RXE_PAGEFAULT_RDONLY BIT(1)
> +#define RXE_PAGEFAULT_SNAPSHOT BIT(2)
> +static int rxe_odp_do_pagefault(struct rxe_mr *mr, u64 user_va, int bcnt, u32 flags)
> +{
> +	int np;
> +	u64 access_mask;
> +	bool fault = !(flags & RXE_PAGEFAULT_SNAPSHOT);
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +	access_mask = ODP_READ_ALLOWED_BIT;
> +	if (umem_odp->umem.writable && !(flags & RXE_PAGEFAULT_RDONLY))
> +		access_mask |= ODP_WRITE_ALLOWED_BIT;
> +
> +	/*
> +	 * ib_umem_odp_map_dma_and_lock() locks umem_mutex on success.
> +	 * Callers must release the lock later to let invalidation handler
> +	 * do its work again.
> +	 */
> +	np = ib_umem_odp_map_dma_and_lock(umem_odp, user_va, bcnt,
> +					  access_mask, fault);
> +	if (np < 0)
> +		return np;
> +
> +	/* umem_mutex is still locked here, so we can use hmm_pfn_to_page()
> +	 * safely to fetch pages in the range.
> +	 */
> +	rxe_mr_set_xarray(mr, user_va, user_va + bcnt, umem_odp->pfn_list);
> +
> +	return np;
> +}
> +
> +static int rxe_odp_init_pages(struct rxe_mr *mr)
> +{
> +	int ret;
> +	struct ib_umem_odp *umem_odp = to_ib_umem_odp(mr->umem);
> +
> +	ret = rxe_odp_do_pagefault(mr, mr->umem->address, mr->umem->length,
> +				   RXE_PAGEFAULT_SNAPSHOT);
> +
> +	if (ret >= 0)
> +		mutex_unlock(&umem_odp->umem_mutex);
> +
> +	return ret >= 0 ? 0 : ret;
> +}
> +
> +int rxe_odp_mr_init_user(struct rxe_dev *rxe, u64 start, u64 length,
> +			 u64 iova, int access_flags, struct rxe_mr *mr)
> +{
> +	int err;
> +	struct ib_umem_odp *umem_odp;
> +
> +	if (!IS_ENABLED(CONFIG_INFINIBAND_ON_DEMAND_PAGING))
> +		return -EOPNOTSUPP;
> +
> +	rxe_mr_init(access_flags, mr);
> +
> +	xa_init(&mr->page_list);
> +
> +	if (!start && length == U64_MAX) {
> +		if (iova != 0)
> +			return -EINVAL;
> +		if (!(rxe->attr.odp_caps.general_caps & IB_ODP_SUPPORT_IMPLICIT))
> +			return -EINVAL;
> +
> +		/* Never reach here, for implicit ODP is not implemented. */
> +	}
> +
> +	umem_odp = ib_umem_odp_get(&rxe->ib_dev, start, length, access_flags,
> +				   &rxe_mn_ops);
> +	if (IS_ERR(umem_odp)) {
> +		rxe_dbg_mr(mr, "Unable to create umem_odp err = %d\n",
> +			   (int)PTR_ERR(umem_odp));
> +		return PTR_ERR(umem_odp);
> +	}
> +
> +	umem_odp->private = mr;
> +
> +	mr->odp_enabled = true;
> +	mr->umem = &umem_odp->umem;
> +	mr->access = access_flags;
> +	mr->ibmr.length = length;
> +	mr->ibmr.iova = iova;
> +	mr->page_offset = ib_umem_offset(&umem_odp->umem);
> +
> +	err = rxe_odp_init_pages(mr);
> +	if (err) {
> +		ib_umem_odp_release(umem_odp);
> +		return err;
> +	}
> +
> +	err = rxe_mr_fill_pages_from_sgt(mr, &umem_odp->umem.sgt_append.sgt);
> +	if (err) {
> +		ib_umem_odp_release(umem_odp);
> +		return err;
> +	}
> +
> +	mr->state = RXE_MR_STATE_VALID;
> +	mr->ibmr.type = IB_MR_TYPE_USER;
> +
> +	return err;
> +}
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index ba0222bfce9e..90c31c4f2944 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -626,6 +626,10 @@ static enum resp_states process_flush(struct rxe_qp *qp,
>  	struct rxe_mr *mr = qp->resp.mr;
>  	struct resp_res *res = qp->resp.res;
>  
> +	/* ODP is not supported right now. WIP. */
> +	if (mr->odp_enabled)
> +		return RESPST_ERR_UNSUPPORTED_OPCODE;
> +
>  	/* oA19-14, oA19-15 */
>  	if (res && res->replay)
>  		return RESPST_ACKNOWLEDGE;
> @@ -679,10 +683,13 @@ static enum resp_states atomic_reply(struct rxe_qp *qp,
>  	if (!res->replay) {
>  		u64 iova = qp->resp.va + qp->resp.offset;
>  
> -		err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
> -					  atmeth_comp(pkt),
> -					  atmeth_swap_add(pkt),
> -					  &res->atomic.orig_val);
> +		if (mr->odp_enabled)
> +			err = RESPST_ERR_UNSUPPORTED_OPCODE;
> +		else
> +			err = rxe_mr_do_atomic_op(mr, iova, pkt->opcode,
> +						  atmeth_comp(pkt),
> +						  atmeth_swap_add(pkt),
> +						  &res->atomic.orig_val);
>  		if (err)
>  			return err;
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index dea605b7f683..9c23defdc7b5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1274,7 +1274,10 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>  	mr->ibmr.pd = ibpd;
>  	mr->ibmr.device = ibpd->device;
>  
> -	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
> +	if (access & IB_ACCESS_ON_DEMAND)
> +		err = rxe_odp_mr_init_user(rxe, start, length, iova, access, mr);
> +	else
> +		err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
>  	if (err) {
>  		rxe_dbg_mr(mr, "reg_user_mr failed, err = %d", err);
>  		goto err_cleanup;
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.h b/drivers/infiniband/sw/rxe/rxe_verbs.h
> index b6fbd9b3d086..de5a982c7c7e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.h
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.h
> @@ -333,6 +333,8 @@ struct rxe_mr {
>  	u32			nbuf;
>  
>  	struct xarray		page_list;
> +
> +	bool			odp_enabled;
>  };
>  
>  static inline unsigned int mr_page_size(struct rxe_mr *mr)

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
