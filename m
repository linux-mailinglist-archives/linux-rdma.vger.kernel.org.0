Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6895743EFA
	for <lists+linux-rdma@lfdr.de>; Fri, 30 Jun 2023 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbjF3Pef (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 30 Jun 2023 11:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbjF3PeR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 30 Jun 2023 11:34:17 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC25646A2
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jun 2023 08:33:40 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-39ed35dfa91so1391446b6e.3
        for <linux-rdma@vger.kernel.org>; Fri, 30 Jun 2023 08:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688139220; x=1690731220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r9BPc7XEzF3iwV82woknMyUsENtfb16BcQzJnqv5eMM=;
        b=rhI9Oi/dfi6DJTYpPSugcs411V0PWpeeglJAkSm1NniSiPLvlf1cm2+5oamLNxOCLN
         L2qapVhhzo+bjnikZz9VxqbfsUiADFvHgYyINYIwScvJeSqkJPaH676937bz6Lk+wXBl
         ipvV7FNJ0O5tRNl5rx+0DIVEnVDp0zced/q/LwEk4SDyo7yxXuVb5iEjp0/V6kixTZMm
         E2AicVrx03K3TxOcrlMptYlFrVbVSW3XFBp3YnD8//22FiXiEqIxvMIdWoMU49RU55Dh
         gjzOzVDGJb6Rf7EXMycQlIWwQyCnyNdtJFq0u0+cJlSvfiHFQYvtYW7Xo8Ook0vATsQw
         4I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688139220; x=1690731220;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r9BPc7XEzF3iwV82woknMyUsENtfb16BcQzJnqv5eMM=;
        b=QDsLGh1Fl/fJuvBUGmQMCAJu3z+aMWWVAXVLcm/uWIdNT5xzEOJBMeWviPG/dzYQ/8
         k3PkUQ/ejAYeIWEMwaQcF+x8wSnuZmxDmIroF1w1dl0WYhJn6QFcllFt/kdpWt9H0YL9
         UHje57RRp4mrGcbKklWOkqNLF/zai4DQVX6/iS2UP8h5oIyje2C/dJr7qV2xidUEXyQk
         4ZZZTTy1eGP1St5eWwSki7huU/pvT+3saaM4dfeKE3/YCIUrhoY70MwLbb2VIUJ93A3A
         8sKUBrGdCGHVxwpNGwbU4YecBlLCcWHVUiQO3kTjbzV2k6sqjwMSVFZTbtQvqQXn+AiR
         +JCg==
X-Gm-Message-State: ABy/qLaRVOHA0EQAr+XM6Zs+rp9ghXihn4XKxAJ1DM163cX5gdGGEFda
        e7Ck0IUMS8/iPFCQsnx1kBA=
X-Google-Smtp-Source: APBJJlEEo1adA+BtOaGao+kGAtNEe/2ht/DEKxten6uIlSV87G50COeK1Gymd6XV9+i4jyvl6Q7b1Q==
X-Received: by 2002:a05:6808:986:b0:3a3:65a8:c12b with SMTP id a6-20020a056808098600b003a365a8c12bmr1267087oic.49.1688139219923;
        Fri, 30 Jun 2023 08:33:39 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fa73:c602:aec:b14e? (2603-8081-140c-1a00-fa73-c602-0aec-b14e.res6.spectrum.com. [2603:8081:140c:1a00:fa73:c602:aec:b14e])
        by smtp.gmail.com with ESMTPSA id z6-20020a056808028600b003a1f1f48d0bsm3932402oic.44.2023.06.30.08.33.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 08:33:39 -0700 (PDT)
Message-ID: <f48d9b89-d80a-c191-9618-102957868429@gmail.com>
Date:   Fri, 30 Jun 2023 10:33:38 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH for-next] RDMA/rxe: Fix potential race in
 rxe_pool_get_index
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, frank.zago@hpe.com, ian.ziemba@hpe.com,
        jhack@hpe.com, linux-rdma@vger.kernel.org
References: <20230629223023.84008-1-rpearsonhpe@gmail.com>
 <ZJ4RXctDIYEhjnQ9@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <ZJ4RXctDIYEhjnQ9@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/29/23 18:18, Jason Gunthorpe wrote:
> On Thu, Jun 29, 2023 at 05:30:24PM -0500, Bob Pearson wrote:
>> Currently the lookup of an object from its index and taking a
>> reference to the object are incorrectly protected by an rcu_read_lock
>> but this does not make the xa_load and the kref_get combination an
>> atomic operation.
>>
>> The various write operations need to share the xarray state in a
>> mixture of user, soft irq and hard irq contexts so the xa_locking
>> must support that.
>>
>> This patch replaces the xa locks with xa_lock_irqsave.
>>
>> Fixes: 3225717f6dfa ("RDMA/rxe: Replace red-black trees by xarrays")
>> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
>> ---
>>  drivers/infiniband/sw/rxe/rxe_pool.c | 24 ++++++++++++++++++------
>>  1 file changed, 18 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 6215c6de3a84..f2b586249793 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -119,8 +119,10 @@ void rxe_pool_cleanup(struct rxe_pool *pool)
>>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>>  				bool sleepable)
>>  {
>> -	int err;
>> +	struct xarray *xa = &pool->xa;
>> +	unsigned long flags;
>>  	gfp_t gfp_flags;
>> +	int err;
>>  
>>  	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>>  		goto err_cnt;
>> @@ -138,8 +140,10 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem,
>>  
>>  	if (sleepable)
>>  		might_sleep();
>> -	err = xa_alloc_cyclic(&pool->xa, &elem->index, NULL, pool->limit,
>> +	xa_lock_irqsave(xa, flags);
>> +	err = __xa_alloc_cyclic(xa, &elem->index, NULL, pool->limit,
>>  			      &pool->next, gfp_flags);
>> +	xa_unlock_irqrestore(xa, flags);
> 
> This stuff doesn't make any sense, the non __ versions already take
> the xa_lock internally.
> 
> Or is this because you need the save/restore version for some reason?
> But that seems unrelated and there should be a lockdep oops to go
> along with it showing the backtrace??

The background here is that we are testing a 256 node system with the Lustre file system and doing
fail-over-fail-back testing which is very high stress. This has uncovered several bugs where this is
just one.
The logic is 1st need to lock the lookup in rxe_pool_get_index() then when we tried to run
with ordinary spin_locks we got lots of deadlocks. These are related to taking spin locks while in
(soft irq) interrupt mode. In theory we could also get called in hard irq mode so might as well
convert the locks to spin_lock_irqsave() which is safe in all cases.
> 
>> @@ -154,15 +158,16 @@ void *rxe_pool_get_index(struct rxe_pool *pool, u32 index)
>>  {
>>  	struct rxe_pool_elem *elem;
>>  	struct xarray *xa = &pool->xa;
>> +	unsigned long flags;
>>  	void *obj;
>>  
>> -	rcu_read_lock();
>> +	xa_lock_irqsave(xa, flags);
>>  	elem = xa_load(xa, index);
>>  	if (elem && kref_get_unless_zero(&elem->ref_cnt))
>>  		obj = elem->obj;
>>  	else
>>  		obj = NULL;
>> -	rcu_read_unlock();
>> +	xa_unlock_irqrestore(xa, flags);
> 
> And this should be safe as long as the object is freed via RCU, so
> what are you trying to fix?

The problem here is that rcu_read_lock only helps us if the object is freed with kfree_rcu.
But we have no control over what rdma-core does and it does *not* do that for e.g. qp's.
If this code gets scheduled off the cpu between the xa_load and the kref_get the object can
be completed cleaned up and freed by rdma-core. It isn't likely but it definitely could happen.
This results in a seg fault in kref_get. This is safer and keeps us out of Leon's hair.

Bob
> 
> Jason

