Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAA1509FFE
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Apr 2022 14:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383534AbiDUMwR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Apr 2022 08:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239734AbiDUMwQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 21 Apr 2022 08:52:16 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BDFA32993
        for <linux-rdma@vger.kernel.org>; Thu, 21 Apr 2022 05:49:26 -0700 (PDT)
Message-ID: <540b594e-dcc1-0d8a-a579-c5638d8919d1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650545364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cbaBNmCWLqg28V7OOXalFQjj0MDIDETeLeWIQeFK79s=;
        b=X853eA6U7zNujR0HXcK+hA7PsJjnrFiNkQZbu6WvMAmGq8MV0uOCb/6TpcB/f1i81dyCRD
        A+ufoVg2K+lTD8JhJr5X3L0jQ80WoKMCFr/fiw2QWVPiwKJGtbVyvaHkMTLLhhQJJ2ehDj
        4rHFGkTNLm8WCCb2n4BSWn+46WRGgtM=
Date:   Thu, 21 Apr 2022 20:49:14 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv5 1/2] RDMA/rxe: Fix a dead lock problem
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc:     yanjun.zhu@linux.dev, linux-rdma@vger.kernel.org,
        Yi Zhang <yi.zhang@redhat.com>
References: <20220417024343.568777-1-yanjun.zhu@linux.dev>
 <Yl+rT9tMRDYZwSKD@unreal> <20220420163249.GQ64706@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <20220420163249.GQ64706@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

在 2022/4/21 0:32, Jason Gunthorpe 写道:
> On Wed, Apr 20, 2022 at 09:42:23AM +0300, Leon Romanovsky wrote:
>> On Sat, Apr 16, 2022 at 10:43:42PM -0400, yanjun.zhu@linux.dev wrote:
>>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>>
>>> This is a dead lock problem.
>>> The ah_pool xa_lock first is acquired in this:
>>>
>>> {SOFTIRQ-ON-W} state was registered at:
>>>
>>>    lock_acquire+0x1d2/0x5a0
>>>    _raw_spin_lock+0x33/0x80
>>>    __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>>>
>>> Then ah_pool xa_lock is acquired in this:
>>>
>>> {IN-SOFTIRQ-W}:
>>>
>>> Call Trace:
>>>   <TASK>
>>>    dump_stack_lvl+0x44/0x57
>>>    mark_lock.part.52.cold.79+0x3c/0x46
>>>    __lock_acquire+0x1565/0x34a0
>>>    lock_acquire+0x1d2/0x5a0
>>>    _raw_spin_lock_irqsave+0x42/0x90
>>>    rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>>    rxe_get_av+0x168/0x2a0 [rdma_rxe]
>>> </TASK>
>>>
>>>  From the above, in the function __rxe_add_to_pool,
>>> xa_lock is acquired. Then the function __rxe_add_to_pool
>>> is interrupted by softirq. The function
>>> rxe_pool_get_index will also acquire xa_lock.
>>>
>>> Finally, the dead lock appears.
>>>
>>> [  296.806097]        CPU0
>>> [  296.808550]        ----
>>> [  296.811003]   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
>>> [  296.814583]   <Interrupt>
>>> [  296.817209]     lock(&xa->xa_lock#15); <---- rxe_pool_get_index
>>> [  296.820961]
>>>                   *** DEADLOCK ***
>>>
>>> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
>>> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> V4->V5: Commit logs are changed to avoid confusion.
>>> V3->V4: xa_lock_irq locks are used.
>>> V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
>>>          GFP_ATOMIC is used in __rxe_add_to_pool.
>>> V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
>>>   drivers/infiniband/sw/rxe/rxe_pool.c | 20 ++++++++++++++------
>>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>>> index 87066d04ed18..f1f06dc7e64f 100644
>>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>>> @@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>>>   
>>>   	atomic_set(&pool->num_elem, 0);
>>>   
>>> -	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
>>> +	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
>>>   	pool->limit.min = info->min_index;
>>>   	pool->limit.max = info->max_index;
>>>   }
>>> @@ -138,8 +138,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>>>   	elem->obj = obj;
>>>   	kref_init(&elem->ref_cnt);
>>>   
>>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>> -			      &pool->next, GFP_KERNEL);
>>> +	xa_lock_irq(&pool->xa);
>>> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>>> +				&pool->next, GFP_KERNEL);
>>> +	xa_unlock_irq(&pool->xa);
> 
> It should just use xa_alloc_cyclic_irq() and xa_erase_irq(). Don't
> open code the lock.

Got it. I will use the above functions.

> 
>> I may admit that I didn't follow your previous discussions, so maybe you
>> already explained it. But why do you need xa_lock_irq() here?
> 
> The spinlock type needs to be consistent in all users.
> 
> You can only use the naked version if the spinlock is always obtained
> from a process context.
> 
> You can only use bh version if the spinlock is always obtained from a
> process context or bh/softirq
> 
> You can always use the irq version
> 
> What I don't understand is why IRQ and not BH? AFAIK there is no case
> where rxe is called from a real IRQ, right? Or is it because you can't
> nest BH under the IRQ spinlock from CM?

Sure. I will use IRQ spinlock. The reason is as below:

1. 
https://patchwork.kernel.org/project/linux-rdma/patch/20220210073655.42281-2-guoqing.jiang@linux.dev/

2. 
https://patchwork.kernel.org/project/linux-rdma/patch/20220215194448.44369-1-rpearsonhpe@gmail.com/

The above 2 links are why I used IRQ.

Zhu Yanjun

> 
> Jason

