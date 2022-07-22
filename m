Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7963B57E275
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Jul 2022 15:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiGVNn0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Jul 2022 09:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiGVNnZ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Jul 2022 09:43:25 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CE13E36
        for <linux-rdma@vger.kernel.org>; Fri, 22 Jul 2022 06:43:21 -0700 (PDT)
Message-ID: <921120a1-28fa-dd2a-b6fc-227faa3c8ace@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658497399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IMl81u3/E6xVxNZ9UVoU10FqjJdUG9J/XQjXB4f/g3g=;
        b=JuiC5ADGrGlGVjfLYK1NAMe/RsYJBphh/J+iWzBffh+DVPlU+CO+U9IVCmPJUHdAfbs1cr
        6znwfmKbbJpdzg95Ac/f7rpKB9bYfjnZy1CQcSdih3GEgYIQVdvqMEimHjUpSf4c9wX+R6
        zVDOR4L3LHTzDZ47Jbj6CfB0DgnNHEE=
Date:   Fri, 22 Jul 2022 21:43:05 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool
 interrupted by rxe_pool_get_index
To:     "yangx.jy@fujitsu.com" <yangx.jy@fujitsu.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "rpearsonhpe@gmail.com" <rpearsonhpe@gmail.com>
Cc:     Yi Zhang <yi.zhang@redhat.com>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <5c2c8590-4798-ab70-2a15-949ca245ddae@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <5c2c8590-4798-ab70-2a15-949ca245ddae@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/7/22 14:51, yangx.jy@fujitsu.com 写道:
> Hi Yanjun, Bob
>
> Could you tell me if the dead lock issue has been fixed by the following
> issue:
> [PATCH v16 2/2] RDMA/rxe: Convert read side locking to rcu

Hi， Xiao

Normally I applied this "RDMA/rxe: Fix dead lock caused by 
__rxe_add_to_pool interrupted by rxe_pool_get_index" patch

series to fix this problem. And I am not sure if this problem is fixed 
by "[PATCH v16 2/2] RDMA/rxe: Convert read side locking to rcu".

Zhu Yanjun

>
> Best Regards,
> Xiao Yang
>
> On 2022/4/23 3:44, yanjun.zhu@linux.dev 写道:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> This is a dead lock problem.
>> The ah_pool xa_lock first is acquired in this:
>>
>> {SOFTIRQ-ON-W} state was registered at:
>>
>>     lock_acquire+0x1d2/0x5a0
>>     _raw_spin_lock+0x33/0x80
>>     __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>>
>> Then ah_pool xa_lock is acquired in this:
>>
>> {IN-SOFTIRQ-W}:
>>
>> Call Trace:
>>    <TASK>
>>     dump_stack_lvl+0x44/0x57
>>     mark_lock.part.52.cold.79+0x3c/0x46
>>     __lock_acquire+0x1565/0x34a0
>>     lock_acquire+0x1d2/0x5a0
>>     _raw_spin_lock_irqsave+0x42/0x90
>>     rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>     rxe_get_av+0x168/0x2a0 [rdma_rxe]
>> </TASK>
>>
>>   From the above, in the function __rxe_add_to_pool,
>> xa_lock is acquired. Then the function __rxe_add_to_pool
>> is interrupted by softirq. The function
>> rxe_pool_get_index will also acquire xa_lock.
>>
>> Finally, the dead lock appears.
>>
>>           CPU0
>>           ----
>>      lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
>>      <Interrupt>
>>        lock(&xa->xa_lock#15); <---- rxe_pool_get_index
>>
>>                    *** DEADLOCK ***
>>
>> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
>> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V5->V6: One dead lock fix in one commit
>> V4->V5: Commit logs are changed.
>> V3->V4: xa_lock_irq locks are used.
>> V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
>>           GFP_ATOMIC is used in __rxe_add_to_pool.
>> V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
>> ---
>>    drivers/infiniband/sw/rxe/rxe_pool.c | 11 +++++++----
>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 87066d04ed18..67f1d4733682 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>>    
>>    	atomic_set(&pool->num_elem, 0);
>>    
>> -	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
>> +	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
>>    	pool->limit.min = info->min_index;
>>    	pool->limit.max = info->max_index;
>>    }
>> @@ -155,6 +155,7 @@ void *rxe_alloc(struct rxe_pool *pool)
>>    int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>>    {
>>    	int err;
>> +	unsigned long flags;
>>    
>>    	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
>>    		return -EINVAL;
>> @@ -166,8 +167,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>>    	elem->obj = (u8 *)elem - pool->elem_offset;
>>    	kref_init(&elem->ref_cnt);
>>    
>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> -			      &pool->next, GFP_KERNEL);
>> +	xa_lock_irqsave(&pool->xa, flags);
>> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> +				&pool->next, GFP_ATOMIC);
>> +	xa_unlock_irqrestore(&pool->xa, flags);
>>    	if (err)
>>    		goto err_cnt;
>>    
>> @@ -201,7 +204,7 @@ static void rxe_elem_release(struct kref *kref)
>>    	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>>    	struct rxe_pool *pool = elem->pool;
>>    
>> -	xa_erase(&pool->xa, elem->index);
>> +	xa_erase_irq(&pool->xa, elem->index);
>>    
>>    	if (pool->cleanup)
>>    		pool->cleanup(elem);
