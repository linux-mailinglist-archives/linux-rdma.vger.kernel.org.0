Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C822674DD1A
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jul 2023 20:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjGJSLc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jul 2023 14:11:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjGJSLb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 10 Jul 2023 14:11:31 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6A0AB
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 11:11:30 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a3790a0a48so3671198b6e.1
        for <linux-rdma@vger.kernel.org>; Mon, 10 Jul 2023 11:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689012689; x=1691604689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+0lCbf4TiwuJwJ5jSXD/dQiXlcFQPmvaKZM5iRDS9zw=;
        b=BZp95LKRhb11WKYDECHyptvLRWndgA2A5e/tE7qxfGjAfndLvV4mxDhwcwDIjz27jO
         0+XJh9EKdnvtLF2Cdt6dwSRvjyxmzmZETl6VxJD7KskAK8Uzy/Z9T4fHZwub3av7WrsV
         iSlUyi4tgvr6K4lvv6JlcmNwWcQYDYF8e8I8vx1rPhKGJqCR38sHNE6vR7HktUhgSWTI
         pqZczJfZmQwInau8TjCYLh1XDugu/CUx98zRoYS8CuLXPDQiSpDXJOWu/IEqE7OSznJ6
         gxrB0vw4iJxjuKKojXMzE7VqEIY8Pv+o9ua2BDaVrhF2R8DTWdl+M7/jWQXj9hBVDAwT
         pq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689012689; x=1691604689;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+0lCbf4TiwuJwJ5jSXD/dQiXlcFQPmvaKZM5iRDS9zw=;
        b=PaNda4HG3XGwwctdNf+r9vi1QmZaLBQzIH6843qumUAaMSs5CoBVcOF31XmzeSCC/x
         eToaoUxCmwyFRNSr2QBUcVN3qD29WrpqYbOg3kh2qpfv147VO7XwP64Mk+g4jTYwlwuS
         eKHympcuEJnI+Ht2OY0AtSD7gt9iMK4Tz/lnfAfps9mtua0IOjl1KYT0AzO2dCmkG4zI
         fh65cHZE+u87ZsD0GhhOvT2/EfuL1vcNZ1P5GrHhYsfFnQ6JL/X4KFeTtWOxKWspP5AK
         2oZ80D8ssiz9yXJEMPE2vg9A5Z4z33HdDWGPpNBzuKc/jxRBXH/GMbWpvMkJ9Nep1m+G
         JsEQ==
X-Gm-Message-State: ABy/qLZa88K/ETnjs+2Vi4K0s6ogMvoMpSJODvNsvTgUloN20ViotKnS
        1rWWr9OHINCIkQe2GO0c+OQ=
X-Google-Smtp-Source: APBJJlFUgOnnPv126gh8GKIBPKDJM2+a+M7xk2yMtmmTkMZbMwhwVT4dFzVj1Eb3iQ/leCUlSJcXzw==
X-Received: by 2002:a05:6808:634d:b0:3a3:7612:28c7 with SMTP id eb13-20020a056808634d00b003a3761228c7mr9935039oib.23.1689012689409;
        Mon, 10 Jul 2023 11:11:29 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:1196:1f9f:c222:78a? (2603-8081-140c-1a00-1196-1f9f-c222-078a.res6.spectrum.com. [2603:8081:140c:1a00:1196:1f9f:c222:78a])
        by smtp.gmail.com with ESMTPSA id ex5-20020a056808298500b003a39462c860sm161204oib.32.2023.07.10.11.11.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 11:11:29 -0700 (PDT)
Message-ID: <8a34d5b4-1bd9-c2e6-aca2-ab34f4ca1e2e@gmail.com>
Date:   Mon, 10 Jul 2023 13:11:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix potential race in
 rxe_pool_get_index
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, frank.zago@hpe.com, ian.ziemba@hpe.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230629223023.84008-1-rpearsonhpe@gmail.com>
 <ZJ4RXctDIYEhjnQ9@nvidia.com>
 <f48d9b89-d80a-c191-9618-102957868429@gmail.com>
 <ZKw2NbcUhCo5F2+g@nvidia.com>
Content-Language: en-US
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZKw2NbcUhCo5F2+g@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 7/10/23 11:47, Jason Gunthorpe wrote:
> On Fri, Jun 30, 2023 at 10:33:38AM -0500, Bob Pearson wrote:
>> On 6/29/23 18:18, Jason Gunthorpe wrote:
>>> On Thu, Jun 29, 2023 at 05:30:24PM -0500, Bob Pearson wrote:
>>>> Currently the lookup of an object from its index and taking a
>>>> reference to the object are incorrectly protected by an rcu_read_lock
>>>> but this does not make the xa_load and the kref_get combination an
>>>> atomic operation.
>>>>
>>>> The various write operations need to share the xarray state in a
>>>> mixture of user, soft irq and hard irq contexts so the xa_locking
>>>> must support that.
>>>>
>>>> This patch replaces the xa locks with xa_lock_irqsave.
>>>>
>>>> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
>>>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>>>> ---
>>>>  drivers/infiniband/sw/rxe/rxe_pool.c | 24 ++++++++++++++++++------
>>>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>>>> index 6215c6de3a84..f2b586249793 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>>>> @@ -119,8 +119,10 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
>>>>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>>>>  				bool sleepable)
>>>>  {
>>>> -	int err;
>>>> +	struct xarray *xa = &pool->xa;
>>>> +	unsigned long flags;
>>>>  	gfp_t gfp_flags;
>>>> +	int err;
>>>>  
>>>>  	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>>>>  		goto err_cnt;
>>>> @@ -138,8 +140,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>>>>  
>>>>  	if (sleepable)
>>>>  		might_sleep();
>>>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
>>>> +	xa_lock_irqsave(xa, flags);
>>>> +	err = __xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
>>>>  			      &pool->next, gfp_flags);
>>>> +	xa_unlock_irqrestore(xa, flags);
>>>
>>> This stuff doesn't make any sense, the non __ versions already take
>>> the xa_lock internally.
>>>
>>> Or is this because you need the save/restore version for some reason?
>>> But that seems unrelated and there should be a lockdep oops to go
>>> along with it showing the backtrace??
>>
>> The background here is that we are testing a 256 node system with
>> the Lustre file system and doing fail-over-fail-back testing which
>> is very high stress. This has uncovered several bugs where this is
>> just one.
> 
>> The logic is 1st need to lock the lookup in rxe_pool_get_index()
>> then when we tried to run with ordinary spin_locks we got lots of
>> deadlocks. These are related to taking spin locks while in (soft
>> irq) interrupt mode. In theory we could also get called in hard irq
>> mode so might as well convert the locks to spin_lock_irqsave() which
>> is safe in all cases.
> 
> That should be its own patch with justification..
>  
>>>> @@ -154,15 +158,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>>>>  {
>>>>  	struct rxe_pool_elem *elem;
>>>>  	struct xarray *xa = &pool->xa;
>>>> +	unsigned long flags;
>>>>  	void *obj;
>>>>  
>>>> -	rcu_read_lock();
>>>> +	xa_lock_irqsave(xa, flags);
>>>>  	elem = xa_load(xa, index);
>>>>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>>>>  		obj = elem->obj;
>>>>  	else
>>>>  		obj = NULL;
>>>> -	rcu_read_unlock();
>>>> +	xa_unlock_irqrestore(xa, flags);
>>>
>>> And this should be safe as long as the object is freed via RCU, so
>>> what are you trying to fix?
>>
>> The problem here is that rcu_read_lock only helps us if the object is freed with kfree_rcu.
>> But we have no control over what rdma-core does and it does *not* do
>> that for e.g. qp's.
> 
> Oh, yes that does sound right. This is another patch with this
> explanation.
> 
> Jason

New news on this. After some testing it turns out that replacing rcu_read_lock() by xa_lock_irqsave()
in rxe_pool_get_index() with a large number of QPs has very bad performance. ib_send_bw -q 32 spends
about 40% of its time trying to get the spinlock on a 24 thread CPU with local loopback. With rcu_read_lock
performance is what I expect. So, since we don't actually see this race we are reverting that change.
Without it the irqsave locks aren't required either. So for now please ignore this patch.

The only way to address this risk without compromising performance would be to find a way to indicate to
rdma-core that it should use kfree_rcu instead of kfree if the driver needs it. A bit mask indexed by
object type exchanged at ib_register_device() would cover it.

Bob

