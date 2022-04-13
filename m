Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6446B4FEBF7
	for <lists+linux-rdma@lfdr.de>; Wed, 13 Apr 2022 02:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiDMAr1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 12 Apr 2022 20:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbiDMAr1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 12 Apr 2022 20:47:27 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822C722537
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 17:45:07 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id b189so253670qkf.11
        for <linux-rdma@vger.kernel.org>; Tue, 12 Apr 2022 17:45:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HJIAxa3tR6qFOXypB9E4ixKlhjBFhM88io6XyexlQ8I=;
        b=cKDGvnBOVKUd/zTw9BrMArsdseSBfnjuS74G+/hb9oBevHqptSJx/VX+n8awBx/uqQ
         5/Jzk1azDbEfWe7jCAZfoEDRmQI99g5+dyA8U1RU7rw0TROqXgnQQq7xCnI0ifVNov6x
         A4kPksM/Lj5GKwzsitBX/qB1K70ASv0rSB3edr3ETD+OJqfYR3kka7Ct/+nTinQIYTkU
         Q6bvkL4wetCC8LCSoegFL/JT/pItFg6uvNPM/CpsXtBrJxI5G0+j9CIhurym73HOjNcQ
         Yk1I+QkCib+hBktlaIK6zmVFwTBIuimkiOpa9WIWrO/4qIdCYoDuIBOZZLFrQBTBJm8b
         xq5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HJIAxa3tR6qFOXypB9E4ixKlhjBFhM88io6XyexlQ8I=;
        b=Ml3f9ddcHqHrV+dwoQiRRzBbA1kQi79fJo3juDEXUPgjoqPq0JuYf6fFHfj4bVyUMr
         LLDm2BY9BIUYq1emM9ul8ui3jzmd9Ig3d8tgSlhyWiijOPt3Mip70C8CKWfVjEacN5/1
         44Ipap2fQ0WjguwlIFWryYMjxFps/qIe1YWHHY50O4wNtHjWWLdGnfhlw0my9jiTIO8n
         Ga377SgZ8HDs2S6uW7xILR7SgC/N6KcFsrsWSzsp2bLbFVPWhOwqS89V1ndbR0y8EGuR
         EwVQSga7u0+oQbRLkDeuxblLU7fh9oTXrnuxrsVaB5uSOi0pVTkRhvK9pmuiCtPRvgHm
         pUDg==
X-Gm-Message-State: AOAM532vJHLESiKuzmaecSZ5PW2nQ1BIri85WGjvNucO1s5Wlo/fvNnd
        l0BDJp2Sg4tgz5hOsAaOU6rXxQ==
X-Google-Smtp-Source: ABdhPJy1dS5oLNSS5ZvZZKO9WFxFi9DGRMH+2Ggf9runSaN+2a8S7I7Q1HQdGT8x+s6VyoYZ6c6S7Q==
X-Received: by 2002:a37:bbc4:0:b0:69b:db2c:c962 with SMTP id l187-20020a37bbc4000000b0069bdb2cc962mr5115528qkf.565.1649810706704;
        Tue, 12 Apr 2022 17:45:06 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id l18-20020a05622a051200b002e1e5e57e0csm28636412qtx.11.2022.04.12.17.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 17:45:05 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1neR84-001L64-Bh; Tue, 12 Apr 2022 21:45:04 -0300
Date:   Tue, 12 Apr 2022 21:45:04 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     yanjun.zhu@linux.dev
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
Subject: Re: [PATCHv3 1/1] RDMA/rxe: Fix a dead lock problem
Message-ID: <20220413004504.GH64706@ziepe.ca>
References: <20220413074208.1401112-1-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413074208.1401112-1-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Apr 13, 2022 at 03:42:08AM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> This is a dead lock problem.
> The xa_lock first is acquired in this:
> 
> {SOFTIRQ-ON-W} state was registered at:
> 
>   lock_acquire+0x1d2/0x5a0
>   _raw_spin_lock+0x33/0x80
>   __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>   __ib_alloc_pd+0xf9/0x550 [ib_core]
>   ib_mad_init_device+0x2d9/0xd20 [ib_core]
>   add_client_context+0x2fa/0x450 [ib_core]
>   enable_device_and_get+0x1b7/0x350 [ib_core]
>   ib_register_device+0x757/0xaf0 [ib_core]
>   rxe_register_device+0x2eb/0x390 [rdma_rxe]
>   rxe_net_add+0x83/0xc0 [rdma_rxe]
>   rxe_newlink+0x76/0x90 [rdma_rxe]
>   nldev_newlink+0x245/0x3e0 [ib_core]
>   rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
>   rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
>   netlink_unicast+0x43b/0x640
>   netlink_sendmsg+0x7eb/0xc40
>   sock_sendmsg+0xe0/0x110
>   __sys_sendto+0x1d7/0x2b0
>   __x64_sys_sendto+0xdd/0x1b0
>   do_syscall_64+0x37/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> Then xa_lock is acquired in this:
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
>   rxe_requester+0x75b/0x4a90 [rdma_rxe]
>   rxe_do_task+0x134/0x230 [rdma_rxe]
>   tasklet_action_common.isra.12+0x1f7/0x2d0
>   __do_softirq+0x1ea/0xa4c
>   run_ksoftirqd+0x32/0x60
>   smpboot_thread_fn+0x503/0x860
>   kthread+0x29b/0x340
>   ret_from_fork+0x1f/0x30
>  </TASK>
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
> V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
>         GFP_ATOMIC is used in __rxe_add_to_pool.
> V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 87066d04ed18..b9b147df4020 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -138,8 +138,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>  	elem->obj = obj;
>  	kref_init(&elem->ref_cnt);
>  
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> +	xa_lock_bh(&pool->xa);
> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> +				&pool->next, GFP_KERNEL);
> +	xa_unlock_bh(&pool->xa);
>  	if (err)
>  		goto err_free;

You can't mix bh and not bh locks, either this is an irq spinlock or
it is bh spinlock, pick one and also ensure that the proper xa_init
flag is set.

> @@ -166,8 +168,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  	elem->obj = (u8 *)elem - pool->elem_offset;
>  	kref_init(&elem->ref_cnt);
>  
> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -			      &pool->next, GFP_KERNEL);
> +	xa_lock_irq(&pool->xa);
> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> +				&pool->next, GFP_ATOMIC);
> +	xa_unlock_irq(&pool->xa);
>  	if (err)
>  		goto err_cnt;

Still no, this does almost every allocation - only AH with the
non-blocking flag set should use this path.

Jason
