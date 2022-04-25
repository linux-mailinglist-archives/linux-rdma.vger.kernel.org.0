Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46C6650E75A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 Apr 2022 19:32:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236243AbiDYRfi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 Apr 2022 13:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiDYRfg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 25 Apr 2022 13:35:36 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400B7633B1
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 10:32:31 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id e4so17910141oif.2
        for <linux-rdma@vger.kernel.org>; Mon, 25 Apr 2022 10:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0rnJUvB1Q071eWjsaJ9GJ30s3Ys7//r/fWm/2A1bVxQ=;
        b=WMDLWCVaA1JZGedJ6j2IlPobhQJbf86ifSscgXmsm1RPavA4viuiWluqCgwt95mQWS
         te6bp+WdroFpywOYlVst3QWdPHQlkGVHwdXjFo468tIVjyW5wj9CutO6lOCNX/l0jN4G
         2IZ7j85LS3LZhuuwg2Pf83VQyFUY1B3BPdFa5t+Wlwmj37xw1nr5u2dIydOdWmvtMJmY
         tKqG214TSdE8KIVABJip6RUP/agCizQPsqQE4+yZFBxt4N3/chRCHMV2fLmiA14pp3ts
         GgBAOgHCx4KzOkCcMpaNT4yjyP4gSao3lW0VMLyIRMaIzRa2j6sEG//Obj1wb0PX32BB
         qv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0rnJUvB1Q071eWjsaJ9GJ30s3Ys7//r/fWm/2A1bVxQ=;
        b=JrhHYjW0ZzyQ4altmMvz6QCPm3e3BfQxppZGKHKD/umSPspmKOhDyaQMknDl2VNiDo
         h4g8WDPHgyldoyiGPlJIet9mm94zUnJ5LLxXo5g8HivdTj62cQq5YjE/dTkLQbv60V63
         ynRAGTF3QzABB87FpR2y4YTsRWPNgInr3TAVSHEJ8088cYKUrfwQIjHCg/MBCywnLpOO
         aY7kQbghLuDbKKR/yP8wgrumRzdzbrWie67L6Zf/y2OIE6q4e5uZss4FuxxJa45f4+gz
         k2lT363c4YVxgmqK+IT/L2lhNsZCfnivr/RpI+pVbFLN6VmqS8um3L5/njQcfmOowf60
         9p1A==
X-Gm-Message-State: AOAM532+ocKwMIgTQYCckoL7XYy22ZV3hLAHJPvIx8gEg3MeLvJ6DeQF
        CQy/856Q7H9in4HogOqUmrA=
X-Google-Smtp-Source: ABdhPJyHWUnRNk+OctXyks1T/kTqFkWOZiFKjQoAu9n67CSWgxWaoX40gw7g21eVdVVFaG2hUnyJ2Q==
X-Received: by 2002:a05:6808:148f:b0:325:1f58:9dfc with SMTP id e15-20020a056808148f00b003251f589dfcmr3870184oiw.20.1650907950614;
        Mon, 25 Apr 2022 10:32:30 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:219e:3c55:e4f9:4342? (2603-8081-140c-1a00-219e-3c55-e4f9-4342.res6.spectrum.com. [2603:8081:140c:1a00:219e:3c55:e4f9:4342])
        by smtp.gmail.com with ESMTPSA id fq16-20020a0568710b1000b000e91c16eeb7sm2272979oab.38.2022.04.25.10.32.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Apr 2022 10:32:30 -0700 (PDT)
Message-ID: <37452048-aabf-07dd-a968-7bb2dfa92c15@gmail.com>
Date:   Mon, 25 Apr 2022 12:32:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool
 interrupted by rxe_pool_get_index
Content-Language: en-US
To:     Yanjun Zhu <yanjun.zhu@linux.dev>,
        "Pearson, Robert B" <robert.pearson2@hpe.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>, "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Cc:     Yi Zhang <yi.zhang@redhat.com>
References: <20220422194416.983549-1-yanjun.zhu@linux.dev>
 <MW4PR84MB23078B439AE048978D67F42EBCF79@MW4PR84MB2307.NAMPRD84.PROD.OUTLOOK.COM>
 <79753213-60cc-87bf-b0e6-b9c6a29209a3@linux.dev>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <79753213-60cc-87bf-b0e6-b9c6a29209a3@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 4/24/22 18:47, Yanjun Zhu wrote:
> 在 2022/4/22 23:57, Pearson, Robert B 写道:
>> Use of rcu_read_lock solves this problem. Rcu_read_lock and spinlock on same data can
>> Co-exist at the same time. That is the whole point. All this is going away soon.
> 
> This is based on your unproved assumption.
We are running the same tests (pyverbs, rping, blktests, perftest, etc.) with the same
configurations set (lockdep) and I am using rcu_read_lock for rxe_pool_get_index.
I do not see any deadlocks or lockdep warnings. The idea of RCU is to separate accesses
to a shared data structure into write operations and read operations. For write operations
a normal spinlock is used to allow only one writer at a time to access the data.
For RCU, unlike rwlocks, the reader is *not* locked at all and the writers are written so
that they can change the data structure underneath the readers and the reader will either
see the old data or the new data and not some combination of the two. This requires
some care but there is library support for this usually denoted by xxx_rcu(). In the case
of xarrays the whole library is RCU enabled so one can safely use xa_load() without
holding a spinlock. The rcu_read_lock() API marks the critical section so the writers can
make sure to wait long enough that there are no readers in the critical section before
freeing the data. The rcu_read_lock() is also recursive. It just expands the critical section.
In the case of rxe_pool.c the only rcu reader is rxe_pool_get_index() which looks up an
object from its index by calling xa_load(). This normally runs in a tasklet but sometimes
could run in process context. The only writers (as we have discussed) run in process context
in a create or destroy verbs call. The writers sometimes call while holding a _saveirq
spinlock from ib_create_ah() so lockdep issues warnings unless the spinlock in rxe_add_to_pool()
is also an _irq spinlock. However it does not issue this warning when RCU is used because
the reader *doesn't take a lock and therefore can't deadlock*. Thus the default xa_alloc_xxx()
which takes a spin_lock() it OK and the sequence xa_lock_irq(); __xa_alloc_xxx(); xa_unlock_irq()
is not needed.
> 
> Zhu Yanjun
> 
>>
>> Bob
>>
>> -----Original Message-----
>> From: yanjun.zhu@linux.dev <yanjun.zhu@linux.dev>
>> Sent: Friday, April 22, 2022 2:44 PM
>> To: jgg@ziepe.ca; leon@kernel.org; linux-rdma@vger.kernel.org; yanjun.zhu@linux.dev
>> Cc: Yi Zhang <yi.zhang@redhat.com>
>> Subject: [PATCHv6 1/4] RDMA/rxe: Fix dead lock caused by __rxe_add_to_pool interrupted by rxe_pool_get_index
>>
>> From: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> This is a dead lock problem.
>> The ah_pool xa_lock first is acquired in this:
>>
>> {SOFTIRQ-ON-W} state was registered at:
>>
>>    lock_acquire+0x1d2/0x5a0
>>    _raw_spin_lock+0x33/0x80
>>    __rxe_add_to_pool+0x183/0x230 [rdma_rxe]
>>
>> Then ah_pool xa_lock is acquired in this:
>>
>> {IN-SOFTIRQ-W}:
>>
>> Call Trace:
>>   <TASK>
>>    dump_stack_lvl+0x44/0x57
>>    mark_lock.part.52.cold.79+0x3c/0x46
>>    __lock_acquire+0x1565/0x34a0
>>    lock_acquire+0x1d2/0x5a0
>>    _raw_spin_lock_irqsave+0x42/0x90
>>    rxe_pool_get_index+0x72/0x1d0 [rdma_rxe]
>>    rxe_get_av+0x168/0x2a0 [rdma_rxe]
>> </TASK>
>>
>>  From the above, in the function __rxe_add_to_pool, xa_lock is acquired. Then the function __rxe_add_to_pool is interrupted by softirq. The function rxe_pool_get_index will also acquire xa_lock.
>>
>> Finally, the dead lock appears.
>>
>>          CPU0
>>          ----
>>     lock(&xa->xa_lock#15);  <----- __rxe_add_to_pool
>>     <Interrupt>
>>       lock(&xa->xa_lock#15); <---- rxe_pool_get_index
>>
>>                   *** DEADLOCK ***
>>
>> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by carrays")
>> Reported-and-tested-by: Yi Zhang <yi.zhang@redhat.com>
>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>> ---
>> V5->V6: One dead lock fix in one commit
>> V4->V5: Commit logs are changed.
>> V3->V4: xa_lock_irq locks are used.
>> V2->V3: __rxe_add_to_pool is between spin_lock and spin_unlock, so
>>          GFP_ATOMIC is used in __rxe_add_to_pool.
>> V1->V2: Replace GFP_KERNEL with GFP_ATOMIC
>> ---
>>   drivers/infiniband/sw/rxe/rxe_pool.c | 11 +++++++----
>>   1 file changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 87066d04ed18..67f1d4733682 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -106,7 +106,7 @@ void rxe_pool_init(struct rxe_dev *rxe, struct rxe_pool *pool,
>>         atomic_set(&pool->num_elem, 0);
>>   -    xa_init_flags(&pool->xa, XA_FLAGS_ALLOC);
>> +    xa_init_flags(&pool->xa, XA_FLAGS_ALLOC | XA_FLAGS_LOCK_IRQ);
>>       pool->limit.min = info->min_index;
>>       pool->limit.max = info->max_index;
>>   }
>> @@ -155,6 +155,7 @@ void *rxe_alloc(struct rxe_pool *pool)  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)  {
>>       int err;
>> +    unsigned long flags;
>>         if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
>>           return -EINVAL;
>> @@ -166,8 +167,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>>       elem->obj = (u8 *)elem - pool->elem_offset;
>>       kref_init(&elem->ref_cnt);
>>   -    err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> -                  &pool->next, GFP_KERNEL);
>> +    xa_lock_irqsave(&pool->xa, flags);
>> +    err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>> +                &pool->next, GFP_ATOMIC);
>> +    xa_unlock_irqrestore(&pool->xa, flags);
>>       if (err)
>>           goto err_cnt;
>>   @@ -201,7 +204,7 @@ static void rxe_elem_release(struct kref *kref)
>>       struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>>       struct rxe_pool *pool = elem->pool;
>>   -    xa_erase(&pool->xa, elem->index);
>> +    xa_erase_irq(&pool->xa, elem->index);
>>         if (pool->cleanup)
>>           pool->cleanup(elem);
>> -- 
>> 2.27.0
>>
> 

