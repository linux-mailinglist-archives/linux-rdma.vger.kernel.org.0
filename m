Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B38502502
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Apr 2022 07:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345245AbiDOF51 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 15 Apr 2022 01:57:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242245AbiDOF50 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 15 Apr 2022 01:57:26 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920AE344D2
        for <linux-rdma@vger.kernel.org>; Thu, 14 Apr 2022 22:54:57 -0700 (PDT)
Message-ID: <0d88246e-c29a-27c0-95c5-da73f52e6a59@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1650002096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T1OioZMg8NsnymhAs6JHy+gF8yO3oBxmYNrXcNCvrFI=;
        b=tlZVwMNUVdOKTWd78IQgsyKQ4PuvrcE6Ok0TRBD+c3RiZXmamEaamFr6/2mrB0fEyu1Yum
        fZF+zdLA52Si4/hIKD/JcaIdscv/zlRmADNKT2j4JG4VdE/j25yfFc41ghV2LPMTnKjsar
        QohCu2uIEM+jYqSHOMWRybPUu1UiQjA=
Date:   Fri, 15 Apr 2022 13:54:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCHv4 1/2] RDMA/rxe: Fix a dead lock problem
To:     Bob Pearson <rpearsonhpe@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
        linux-rdma@vger.kernel.org
References: <20220415195630.279510-1-yanjun.zhu@linux.dev>
 <e217ab50-75ff-9112-e492-a70cca50759b@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Yanjun Zhu <yanjun.zhu@linux.dev>
In-Reply-To: <e217ab50-75ff-9112-e492-a70cca50759b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


在 2022/4/15 13:37, Bob Pearson 写道:
> On 4/15/22 14:56, yanjun.zhu@linux.dev wrote:
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> This is a dead lock problem.
>> The xa_lock first is acquired in this:
>>
>> {SOFTIRQ-ON-W} state was registered at:
>>
>>    lock_acquire+0x1d2/0x5a0
>>    _raw_spin_lock+0x33/0x80
>>    __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>>    __ib_alloc_pd+0xf9/0x550 [ib_core]
>>    ib_mad_init_device+0x2d9/0xd20 [ib_core]
>>    add_client_context+0x2fa/0x450 [ib_core]
>>    enable_device_and_get+0x1b7/0x350 [ib_core]
>>    ib_register_device+0x757/0xaf0 [ib_core]
>>    rxe_register_device+0x2eb/0x390 [rdma_rxe]
>>    rxe_net_add+0x83/0xc0 [rdma_rxe]
>>    rxe_newlink+0x76/0x90 [rdma_rxe]
>>    nldev_newlink+0x245/0x3e0 [ib_core]
>>    rdma_nl_rcv_msg+0x2d4/0x790 [ib_core]
>>    rdma_nl_rcv+0x1ca/0x3f0 [ib_core]
>>    netlink_unicast+0x43b/0x640
>>    netlink_sendmsg+0x7eb/0xc40
>>    sock_sendmsg+0xe0/0x110
>>    __sys_sendto+0x1d7/0x2b0
>>    __x64_sys_sendto+0xdd/0x1b0
>>    do_syscall_64+0x37/0x80
>>    entry_SYSCALL_64_after_hwframe+0x44/0xae
> There is a separate xarray for each object pool. So this one is
> rxe->pd_pool.xa.xa_lock from rxe_alloc_pd().
>
>> Then xa_lock is acquired in this:
>>
>> {IN-SOFTIRQ-W}:
>>
>> Call Trace:
>>   <TASK>
>>    dump_stack_lvl+0x44/0x57
>>    mark_lock.part.52.cold.79+0x3c/0x46
>>    __lock_acquire+0x1565/0x34a0
>>    lock_acquire+0x1d2/0x5a0
>>    _raw_spin_lock_irqsave+0x42/0x90
>>    rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>    rxe_get_av+0x168/0x2a0 [rdma_rxe]
>>    rxe_requester+0x75b/0x4a90 [rdma_rxe]
>>    rxe_do_task+0x134/0x230 [rdma_rxe]
>>    tasklet_action_common.isra.12+0x1f7/0x2d0
>>    __do_softirq+0x1ea/0xa4c
>>    run_ksoftirqd+0x32/0x60
>>    smpboot_thread_fn+0x503/0x860
>>    kthread+0x29b/0x340
>>    ret_from_fork+0x1f/0x30
> And this one is rxe->ah_pool.xa.xa_lock from rxe_requester
> in the process of sending a UD packet from a work request
> which contains the index of the ah.
>
> For your story to work there needs to be an another ah_pool.xa.xa_lock somewhere.
> Let's assume it is there somewhere and it's from (a different) add_to_pool call
> then the add_to_pool_ routine should disable interrupts when it gets the lock
> with spin_lock_xxx. But only for AH objects.
>
> This may be old news.

What do you mean? Please check the call trace in the bug.

Zhu Yanjun

>
>>   </TASK>
>>
>>  From the above, in the function __rxe_add_to_pool,
>> xa_lock is acquired. Then the function __rxe_add_to_pool
>> is interrupted by softirq. The function
>> rxe_pool_get_index will also acquire xa_lock.
>>
>> Finally, the dead lock appears.
>>
>> [  296.806097]        CPU0
>> [  296.808550]        ----
>> [  296.811003]   lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
>> [  296.814583]   <Interrupt>
>> [  296.817209]     lock(&xa->xa_lock#15); <---- rxe_pool_get_index
>> [  296.820961]
>>                   *** DEADLOCK ***
>>
>> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
>> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V3->V4: xa_lock_irq locks are used.
>> V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
>>          GFP_ATOMIC is used in __rxe_add_to_pool.
>> V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
>> ---
>>   drivers/infiniband/sw/rxe/rxe_pool.c | 20 ++++++++++++++------
>>   1 file changed, 14 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 87066d04ed18..f1f06dc7e64f 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>>   
>>   	atomic_set(&pool->num_elem, 0);
>>   
>> -	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
>> +	xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
>>   	pool->limit.min = info->min_index;
>>   	pool->limit.max = info->max_index;
>>   }
>> @@ -138,8 +138,10 @@ void *rxe_alloc(struct rxe_pool *pool)
>>   	elem->obj = obj;
>>   	kref_init(&elem->ref_cnt);
>>   
>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> -			      &pool->next, GFP_KERNEL);
>> +	xa_lock_irq(&pool->xa);
>> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> +				&pool->next, GFP_KERNEL);
>> +	xa_unlock_irq(&pool->xa);
>>   	if (err)
>>   		goto err_free;
>>   
>> @@ -155,6 +157,7 @@ void *rxe_alloc(struct rxe_pool *pool)
>>   int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>>   {
>>   	int err;
>> +	unsigned long flags;
>>   
>>   	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
>>   		return -EINVAL;
>> @@ -166,8 +169,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>>   	elem->obj = (u8 *)elem - pool->elem_offset;
>>   	kref_init(&elem->ref_cnt);
>>   
>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> -			      &pool->next, GFP_KERNEL);
>> +	xa_lock_irqsave(&pool->xa, flags);
>> +	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> +				&pool->next, GFP_ATOMIC);
>> +	xa_unlock_irqrestore(&pool->xa, flags);
>>   	if (err)
>>   		goto err_cnt;
>>   
>> @@ -200,8 +205,11 @@ static void rxe_elem_release(struct kref *kref)
>>   {
>>   	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>>   	struct rxe_pool *pool = elem->pool;
>> +	unsigned long flags;
>>   
>> -	xa_erase(&pool->xa, elem->index);
>> +	xa_lock_irqsave(&pool->xa, flags);
>> +	__xa_erase(&pool->xa, elem->index);
>> +	xa_unlock_irqrestore(&pool->xa, flags);
>>   
>>   	if (pool->cleanup)
>>   		pool->cleanup(elem);
