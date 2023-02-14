Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C2E3697226
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Feb 2023 00:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjBNXzy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 14 Feb 2023 18:55:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjBNXzx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 14 Feb 2023 18:55:53 -0500
Received: from out-17.mta0.migadu.com (out-17.mta0.migadu.com [IPv6:2001:41d0:1004:224b::11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A44193E8
        for <linux-rdma@vger.kernel.org>; Tue, 14 Feb 2023 15:55:51 -0800 (PST)
Message-ID: <ee983dce-0f26-3e1a-e792-a57bba6ca7e4@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1676418948;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FQbzqPsY16Z/ZmQDJDHNb75dV90gulWNxNWV49DqzuU=;
        b=olrykl7ESOQ1uK3xqKRWLOjHi44Z7welIUNswXZ6h5nbfr9DAeCiBSO/LzZmmF6Kp0Ej4n
        0vjMiI98anEWxaeOKexQpN9mDl6Cb0+hy9QbRFIWHph3A4+PlOZ955K0tY/E8NBvS/3OYn
        dUNWIDiqdKW2TfZx7MWtDu+D+140SZ8=
Date:   Wed, 15 Feb 2023 07:55:40 +0800
MIME-Version: 1.0
Subject: Re: [PATCH for-next] RDMA/rxe: Remove rxe_alloc()
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@nvidia.com,
        zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
Cc:     rpearson@hpe.com
References: <20230213225551.12437-1-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20230213225551.12437-1-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2023/2/14 6:55, Bob Pearson 写道:
> Currently all the object types in the rxe driver are allocated in
> rdma-core except for MRs. By moving tha kzalloc() call outside of
> the pool code the rxe_alloc() subroutine can be eliminated and code
> checking for MR as a special case can be removed.
> 
> This patch moves the kzalloc() and kfree_rcu() calls into the mr
> registration and destruction verbs. It removes that code from
> rxe_pool.c including the rxe_alloc() subroutine which is no longer
> used.

No bug fixes and no function changes.
In this commit, refactoring the some code snippet.

Not sure if this will introduce risks.

But to now, it seems fine to me.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun
> 
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_mr.c    |  2 +-
>   drivers/infiniband/sw/rxe/rxe_pool.c  | 46 --------------------
>   drivers/infiniband/sw/rxe/rxe_pool.h  |  3 --
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 61 +++++++++++++++++++--------
>   4 files changed, 45 insertions(+), 67 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index c80458634962..c79a4161a6ae 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -724,7 +724,7 @@ int rxe_dereg_mr(struct ib_mr *ibmr, struct ib_udata *udata)
>   		return -EINVAL;
>   
>   	rxe_cleanup(mr);
> -
> +	kfree_rcu(mr);
>   	return 0;
>   }
>   
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index f50620f5a0a1..3f6bd672cc2d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -116,55 +116,12 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
>   	WARN_ON(!xa_empty(&pool->xa));
>   }
>   
> -void *rxe_alloc(struct rxe_pool *pool)
> -{
> -	struct rxe_pool_elem *elem;
> -	void *obj;
> -	int err;
> -
> -	if (WARN_ON(!(pool->type == RXE_TYPE_MR)))
> -		return NULL;
> -
> -	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
> -		goto err_cnt;
> -
> -	obj = kzalloc(pool->elem_size, GFP_KERNEL);
> -	if (!obj)
> -		goto err_cnt;
> -
> -	elem = (struct rxe_pool_elem *)((u8 *)obj + pool->elem_offset);
> -
> -	elem->pool = pool;
> -	elem->obj = obj;
> -	kref_init(&elem->ref_cnt);
> -	init_completion(&elem->complete);
> -
> -	/* allocate index in array but leave pointer as NULL so it
> -	 * can't be looked up until rxe_finalize() is called
> -	 */
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> -	if (err < 0)
> -		goto err_free;
> -
> -	return obj;
> -
> -err_free:
> -	kfree(obj);
> -err_cnt:
> -	atomic_dec(&pool->num_elem);
> -	return NULL;
> -}
> -
>   int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>   				bool sleepable)
>   {
>   	int err;
>   	gfp_t gfp_flags;
>   
> -	if (WARN_ON(pool->type == RXE_TYPE_MR))
> -		return -EINVAL;
> -
>   	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>   		goto err_cnt;
>   
> @@ -275,9 +232,6 @@ int __rxe_cleanup(struct rxe_pool_elem *elem, bool sleepable)
>   	if (pool->cleanup)
>   		pool->cleanup(elem);
>   
> -	if (pool->type == RXE_TYPE_MR)
> -		kfree_rcu(elem->obj);
> -
>   	atomic_dec(&pool->num_elem);
>   
>   	return err;
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index 9d83cb32092f..b42e26427a70 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -54,9 +54,6 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>   /* free resources from object pool */
>   void rxe_pool_cleanup(struct rxe_pool *pool);
>   
> -/* allocate an object from pool */
> -void *rxe_alloc(struct rxe_pool *pool);
> -
>   /* connect already allocated object to pool */
>   int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>   				bool sleepable);
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 7a902e0a0607..268be6983c1e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -869,10 +869,17 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>   	struct rxe_dev *rxe = to_rdev(ibpd->device);
>   	struct rxe_pd *pd = to_rpd(ibpd);
>   	struct rxe_mr *mr;
> +	int err;
>   
> -	mr = rxe_alloc(&rxe->mr_pool);
> -	if (!mr)
> -		return ERR_PTR(-ENOMEM);
> +	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	err = rxe_add_to_pool(&rxe->mr_pool, mr);
> +	if (err)
> +		goto err_free;
>   
>   	rxe_get(pd);
>   	mr->ibmr.pd = ibpd;
> @@ -880,8 +887,12 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>   
>   	rxe_mr_init_dma(access, mr);
>   	rxe_finalize(mr);
> -
>   	return &mr->ibmr;
> +
> +err_free:
> +	kfree(mr);
> +err_out:
> +	return ERR_PTR(err);
>   }
>   
>   static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
> @@ -895,9 +906,15 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>   	struct rxe_pd *pd = to_rpd(ibpd);
>   	struct rxe_mr *mr;
>   
> -	mr = rxe_alloc(&rxe->mr_pool);
> -	if (!mr)
> -		return ERR_PTR(-ENOMEM);
> +	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	err = rxe_add_to_pool(&rxe->mr_pool, mr);
> +	if (err)
> +		goto err_free;
>   
>   	rxe_get(pd);
>   	mr->ibmr.pd = ibpd;
> @@ -905,14 +922,16 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd,
>   
>   	err = rxe_mr_init_user(rxe, start, length, iova, access, mr);
>   	if (err)
> -		goto err1;
> +		goto err_cleanup;
>   
>   	rxe_finalize(mr);
> -
>   	return &mr->ibmr;
>   
> -err1:
> +err_cleanup:
>   	rxe_cleanup(mr);
> +err_free:
> +	kfree(mr);
> +err_out:
>   	return ERR_PTR(err);
>   }
>   
> @@ -927,24 +946,32 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>   	if (mr_type != IB_MR_TYPE_MEM_REG)
>   		return ERR_PTR(-EINVAL);
>   
> -	mr = rxe_alloc(&rxe->mr_pool);
> -	if (!mr)
> -		return ERR_PTR(-ENOMEM);
> +	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> +	if (!mr) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	err = rxe_add_to_pool(&rxe->mr_pool, mr);
> +	if (err)
> +		goto err_free;
>   
>   	rxe_get(pd);
>   	mr->ibmr.pd = ibpd;
>   	mr->ibmr.device = ibpd->device;
>   
>   	err = rxe_mr_init_fast(max_num_sg, mr);
> -	if (err)
> -		goto err1;
> +	if (err)
> +		goto err_cleanup;
>   
>   	rxe_finalize(mr);
> -
>   	return &mr->ibmr;
>   
> -err1:
> +err_cleanup:
>   	rxe_cleanup(mr);
> +err_free:
> +	kfree(mr);
> +err_out:
>   	return ERR_PTR(err);
>   }
>   
> 
> base-commit: 9cd9842c46996ef62173c36619c746f57416bcb0

