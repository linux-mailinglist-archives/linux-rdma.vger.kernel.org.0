Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989A04DA91A
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Mar 2022 04:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239609AbiCPD4R (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Mar 2022 23:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiCPD4R (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Mar 2022 23:56:17 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE50954189
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 20:55:02 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s207so1349477oie.11
        for <linux-rdma@vger.kernel.org>; Tue, 15 Mar 2022 20:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=0r81XJLimGJxsYWfmGKt6NnQhsX4AEnsco/WdhAvtak=;
        b=SyjiU/V8ivEM7KAUp5ApBtqIrC+Bp+J8pmmJ4nXAJq1xdmuLwkmuPdiKFoHC1XaRn8
         1ixQZRfFW6mFKpDafpPKl6R23swEMh0JG79IipcSqNg3o4auCkTM2joZthhvu2P7zznB
         aRIiXHlmN3mDdow2aR2b7BUWICbn1tp+LMMr3A8mjDul3ZztWzSsG5vQd7YxX1hKHpAL
         Izq/YLvNfMsOt7Mj/WJBakbtI6e+g48ZUThY7xEka1i/sb9+do66IoGKwEcirhDZtJ/v
         houg7RZjMpXTWZD7xTCTk0noX0vemGrkP85kyY5M+Cyd417HiFgJkl5nCCM9bGbIK2cx
         exRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=0r81XJLimGJxsYWfmGKt6NnQhsX4AEnsco/WdhAvtak=;
        b=Z2XS8+YzME2JaefQm8Y9DPPZogLohHbEVLIOW3ggveQtweVrzuMEXCwXjT3vFM3vgP
         zfJbvLqUD2GmPnHelKGbRUkzPzD0Bknd5JE8ElXs0EUIVygWMAHpqAYraQDB5ZVV10uZ
         xFGnYm48lCC2alPpnOBK8tVw5oy1jjCQE2He0ASLlz6LXAuIKbGHbYsrQZ1R6462jnFJ
         zDUs4MyPNNVLbMRWZa18kfG09fVnz4yoIgWW5CREhQrEotVZjdgmmg0UjY9h3mKY/3y9
         gAWugOifZwQOlCJB/6JcsZe3GKDH6DmTpu21Tp4w4nrHBobFHjz55I/HJLL1fZwqW7uP
         3SQg==
X-Gm-Message-State: AOAM532a0oUFA3TOiJBsSnCHBGZHsSGncosDgoNayjFankTRXcUbFyjS
        nqhSWYiE7ISVvTOtFM11kHU=
X-Google-Smtp-Source: ABdhPJzYWD9yDYj4mrvurEweFUFcxuMfKGaAktYKWD6Q7GVULHGNEo5u49uVMaO+B784PcQxwqBPXg==
X-Received: by 2002:aca:6254:0:b0:2da:1b96:f8eb with SMTP id w81-20020aca6254000000b002da1b96f8ebmr3026873oib.232.1647402902154;
        Tue, 15 Mar 2022 20:55:02 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:744:9605:b0bf:1b15? (2603-8081-140c-1a00-0744-9605-b0bf-1b15.res6.spectrum.com. [2603:8081:140c:1a00:744:9605:b0bf:1b15])
        by smtp.gmail.com with ESMTPSA id h12-20020a9d6a4c000000b005b9d727d4b9sm407910otn.14.2022.03.15.20.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 20:55:01 -0700 (PDT)
Message-ID: <8aa69cff-2871-3015-fd2d-7279d8f3ddac@gmail.com>
Date:   Tue, 15 Mar 2022 22:55:01 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH for-next v11 10/13] RDMA/rxe: Stop lookup of partially
 built objects
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, linux-rdma@vger.kernel.org
References: <20220304000808.225811-1-rpearsonhpe@gmail.com>
 <20220304000808.225811-11-rpearsonhpe@gmail.com>
 <20220316001655.GV11336@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220316001655.GV11336@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/15/22 19:16, Jason Gunthorpe wrote:
> On Thu, Mar 03, 2022 at 06:08:06PM -0600, Bob Pearson wrote:
>> Currently the rdma_rxe driver has a security weakness due to giving
>> objects which are partially initialized indices allowing external
>> actors to gain access to them by sending packets which refer to
>> their index (e.g. qpn, rkey, etc) causing unpredictable results.
>>
>> This patch adds two new APIs rxe_show(obj) and rxe_hide(obj) which
>> enable or disable looking up pool objects from indices using
>> rxe_pool_get_index(). By default objects are disabled. These APIs
>> are used to enable looking up objects which have indices:
>> AH, SRQ, QP, MR, and MW. They are added in create verbs after the
>> objects are fully initialized and as soon as possible in destroy
>> verbs.
> 
> In other parts of rdma we use the word 'finalize' where you used show
> 
> So rxe_pool_finalize() or something
> 
> I'm not clear on what hide is supposed to be for, if the object is
> being destroyed why do we need a period when it is NULL in the xarray
> before just erasing it?
The problem I am trying to solve is that when a destroy verb is called I want
to stop looking up rdma objects from their numbers (rkey, qpn, etc.) which
happens when a new packet arrives that refers to the object. So we start the
object destroy flow but we may hit a long delay if there are already
references taken on the object. In the next patch we are going to add a complete
wait_for_completion so that we won't return to rdma_core until all the refs
are dropped. While we are waiting for some past event to complete and drop its
reference new packets may arrive and take a reference on the object while looking it
up. Potentially this could happen many times. I just want to stop accepting any
new packets as soon as the destroy verb gets called. Meanwhile we will allow
past packets to complete. That is what hide() does.

Show() deals with the opposite problem. The way the object library worked as soon as
the object was created or 'added to the pool' it becomes searchable. But some of the
verbs have a lot of code to execute after the object gets its number assigned so by
setting the link to NULL in the xa_alloc call we get the index assigned but the
object is not searchable. show turns it on at the end for the create verb call after
all the init code is done.

There are likely better names but these were the ones that came to mind.

> 
>> @@ -221,8 +221,12 @@ static void rxe_elem_release(struct kref *kref)
>>  {
>>  	struct rxe_pool_elem *elem = container_of(kref, typeof(*elem), ref_cnt);
>>  	struct rxe_pool *pool = elem->pool;
>> +	struct xarray *xa = &pool->xa;
>> +	unsigned long flags;
>>  
>> -	xa_erase(&pool->xa, elem->index);
>> +	xa_lock_irqsave(xa, flags);
>> +	__xa_erase(&pool->xa, elem->index);
>> +	xa_unlock_irqrestore(xa, flags);
> 
> I guess it has to do with this, but why have the xa_erase in the kref
> release at all?
> 
>>  	if (pool->cleanup)
>>  		pool->cleanup(elem);
>> @@ -242,3 +246,33 @@ int __rxe_put(struct rxe_pool_elem *elem)
>>  {
>>  	return kref_put(&elem->ref_cnt, rxe_elem_release);
>>  }
>> +
>> +int __rxe_show(struct rxe_pool_elem *elem)
>> +{
>> +	struct xarray *xa = &elem->pool->xa;
>> +	unsigned long flags;
>> +	void *ret;
>> +
>> +	xa_lock_irqsave(xa, flags);
>> +	ret = __xa_store(&elem->pool->xa, elem->index, elem, GFP_KERNEL);
>> +	xa_unlock_irqrestore(xa, flags);
>> +	if (IS_ERR(ret))
>> +		return PTR_ERR(ret);
> 
> This can't fail due to the xa memory already being allocated. You can
> just WARN_ON here and 'finalize' should not return an error code.
> 
> If you want to be fancy this checks for other mistakes too:
> 
>    tmp = xa_cmpxchg((&elem->pool->xa, elem->index, XA_ZERO_ENTRY,  elem, 0)
>    WARN_ON(tmp != NULL);
> 
>> +int __rxe_hide(struct rxe_pool_elem *elem)
>> +{
>> +	struct xarray *xa = &elem->pool->xa;
>> +	unsigned long flags;
>> +	void *ret;
>> +
>> +	xa_lock_irqsave(xa, flags);
>> +	ret = __xa_store(&elem->pool->xa, elem->index, NULL, GFP_KERNEL);
>> +	xa_unlock_irqrestore(xa, flags);
> 
> IIRC storing NULL is the same as erase, isn't it?  You have to store
> XA_ZERO_ENTRY if you want to keep an allocated NULL
This works just fine. You are correct for normal xarrays but for allocating xarrays
setting the link to NULL is treated differently and it remembers. Here is the comment
in <kernel>/Documentation

Allocating XArrays

If you use DEFINE_XARRAY_ALLOC() to define the XArray, or initialise it by passing XA_FLAGS_ALLOC to xa_init_flags(), the XArray changes to track whether entries are in use or not.

You can call xa_alloc() to store the entry at an unused index in the XArray. If you need to modify the array from interrupt context, you can use xa_alloc_bh() or xa_alloc_irq() to disable interrupts while allocating the ID.

Using xa_store(), xa_cmpxchg() or xa_insert() will also mark the entry as being allocated. Unlike a normal XArray, storing NULL will mark the entry as being in use, like xa_reserve(). To free an entry, use xa_erase() (or xa_release() if you only want to free the entry if it’s NULL).

> 
>> +	if (IS_ERR(ret))
>> +		return PTR_ERR(ret);
>> +	else
>> +		return 0;
>> +}
> 
> Same remark about the error handling
> 
>> @@ -491,6 +497,7 @@ static int rxe_destroy_qp(struct ib_qp *ibqp, struct ib_udata *udata)
>>  	struct rxe_qp *qp = to_rqp(ibqp);
>>  	int ret;
>>  
>> +	rxe_hide(qp);
>>  	ret = rxe_qp_chk_destroy(qp);
>>  	if (ret)
>>  		return ret;
> 
> So we decided not to destroy the QP but wrecked it in the xarray?
> 
> Not convinced about the hide at all..
This particular example is pretty light weight since rxe_qp_chk_destroy only makes one
memory reference. But dereg_mr actually can do a lot of work and in either case
the idea as explained above is not to wreck the object but prevent rxe_pool_get_index(pool, index)
from succeeding and taking a new ref on the object. Once the verbs client has called a destroy
verb I don't see any reason why we should continue to process newly arriving packets forever which
is the only place in the driver where we convert object numbers to objects.

There is another issue which is not being dealt with here and that is partially torn down
objects. After this patch the flow for a destroy verb for an indexed object is

hide() =	"disable new lookups, e.g. xa_store(NULL)"
		"misc tear down code"
rxe_put() = 	"drop a reference, will be last one if the object is quiescent"
		"if necessary wait until last ref dropped"
		"object cleanup code, includes xa_erase()"

If objects are still holding references you have to be careful to make sure that
nothing in misc tear down code matters for an outstanding reference. Currently this all works
but if any change breaks things we have had to defer the change to the cleanup phase.
It doesn't work by design but just debugging in the past.

Bob


> 
> Jason

