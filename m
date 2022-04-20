Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FA7508157
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 08:42:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241403AbiDTGpP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 02:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233571AbiDTGpP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 02:45:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0485C340DA
        for <linux-rdma@vger.kernel.org>; Tue, 19 Apr 2022 23:42:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B609CB81D37
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 06:42:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089A1C385A1;
        Wed, 20 Apr 2022 06:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650436947;
        bh=oP5+jx+iBUzMixL0Tw3Tgp5MiCV198ACkSN/7hx637M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZ0zmNRyXBgX4lb6jtxehlnz6EHOqJ3LsZNGCVy2r2IhZpH38Ht6R6EdZ6gwjSwQm
         fCQ7EwyFAkAb4bVr2r0qdIgQ930OvynTP3pubjr2GKxCC9epsPjDkj0vyITxV11ew3
         0Kr9AI3bs6VYlM1swLSr6VrCo6MCRx0p+QK6ev7Y7cwocJpaZHgh302FKvabiNc3ZW
         LF6d5dq8MW9Qc/F3Bl+vPEnGh6Yc8nVJfpYHdIKu1PoEMICPw9vTU5dAlQZmq0MQ0I
         fOaT1lk7V9qUbmSjmmAjFlZjFlIAsYZXYrUvWLFlfVvhyv40pjbvQ9n5gOhcAb4grM
         gxGRzikDo9w6Q==
Date:   Wed, 20 Apr 2022 09:42:23 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     yanjun.zhu@linux.dev
Cc:     jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv5 1/2] RDMA/rxe: Fix a dead lock problem
Message-ID: <Yl+rT9tMRDYZwSKD@unreal>
References: <20220417024343.568777-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417024343.568777-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 16, 2022 at 10:43:42PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This is a dead lock problem.
> The ah_pool xa_lock first is acquired in this:
> 
> {SOFTIRQ-ON-W} state was registered at:
> 
>   lock_acquire+0x1d2/0x5a0
>   _raw_spin_lock+0x33/0x80
>   __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
> 
> Then ah_pool xa_lock is acquired in this:
> 
> {IN-SOFTIRQ-W}:
> 
> Call Trace:
>  <TASK>
>   dump_stack_lvl+0x44/0x57
>   mark_lock.part.52.cold.79+0x3c/0x46
>   __lock_acquire+0x1565/0x34a0
>   lock_acquire+0x1d2/0x5a0
>   _raw_spin_lock_irqsave+0x42/0x90
>   rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>   rxe_get_av+0x168/0x2a0 [rdma_rxe]
> </TASK>
> 
> From the above, in the function __rxe_add_to_pool,
> xa_lock is acquired. Then the function __rxe_add_to_pool
> is interrupted by softirq. The function
> rxe_pool_get_index will also acquire xa_lock.
> 
> Finally, the dead lock appears.
> 
> [  296.806097]        CPU0
> [  296.808550]        ----
> [  296.811003]   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
> [  296.814583]   <Interrupt>
> [  296.817209]     lock(&xa->xa_lock#15); <---- rxe_pool_get_index
> [  296.820961]
>                  *** DEADLOCK ***
> 
> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> V4->V5: Commit logs are changed to avoid confusion.
> V3->V4: xa_lock_irq locks are used.
> V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
>         GFP_ATOMIC is used in __rxe_add_to_pool.
> V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 87066d04ed18..f1f06dc7e64f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>  
>  	atomic_set(&pool->num_elem, 0);
>  
> -	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
> +	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
>  	pool->limit.min = info->min_index;
>  	pool->limit.max = info->max_index;
>  }
> @@ -138,8 +138,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>  	elem->obj = obj;
>  	kref_init(&elem->ref_cnt);
>  
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> +	xa_lock_irq(&pool->xa);
> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> +				&pool->next, GFP_KERNEL);
> +	xa_unlock_irq(&pool->xa);

I may admit that I didn't follow your previous discussions, so maybe you
already explained it. But why do you need xa_lock_irq() here?

Thanks

>  	if (err)
>  		goto err_free;
>  
> @@ -155,6 +157,7 @@ void *rxe_alloc(struct rxe_pool *pool)
>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  {
>  	int err;
> +	unsigned long flags;
>  
>  	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
>  		return -EINVAL;
> @@ -166,8 +169,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  	elem->obj = (u8 *)elem - pool->elem_offset;
>  	kref_init(&elem->ref_cnt);
>  
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> +	xa_lock_irqsave(&pool->xa, flags);
> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> +				&pool->next, GFP_ATOMIC);
> +	xa_unlock_irqrestore(&pool->xa, flags);
>  	if (err)
>  		goto err_cnt;
>  
> @@ -200,8 +205,11 @@ static void rxe_elem_release(struct kref *kref)
>  {
>  	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>  	struct rxe_pool *pool = elem->pool;
> +	unsigned long flags;
>  
> -	xa_erase(&pool->xa, elem->index);
> +	xa_lock_irqsave(&pool->xa, flags);
> +	__xa_erase(&pool->xa, elem->index);
> +	xa_unlock_irqrestore(&pool->xa, flags);
>  
>  	if (pool->cleanup)
>  		pool->cleanup(elem);
> -- 
> 2.27.0
> 
