Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B62424E505
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Aug 2020 06:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725811AbgHVERC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 22 Aug 2020 00:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725807AbgHVERB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 22 Aug 2020 00:17:01 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639B3C061573
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 21:17:00 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id q9so3217434oth.5
        for <linux-rdma@vger.kernel.org>; Fri, 21 Aug 2020 21:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SmZOhr2At1rMDgNNXtY5F9FoFdcOI3/Q/IAFqc+WtUo=;
        b=mWmvXzr4r6QFOG9bCXAY7rjYPu3k6Xiy2xiMGdWtmuqcM1Sr3Q3ouxBUL7+3AXd6fz
         mTf0hBM6LSDPps8WLzE39DVB7cTl1cYeYG1xIvNcRmLJTHxhaqCfF+38KVAtIy7VfRIC
         emh6sgal48kC+pIg/SEWYuBbCkl0QvXHR3ri0MLlZ7A0DwxEHTOiN8iGB3VjNZEBPE0E
         4KQ8197Uipirch8gzn5FEnNqjCUG3LH9HI5wrK3svOyMFTpPJbIsj5Aub8Qx/7nppovt
         ivCg/qOhvD/RFts5b1uLpoXliu0urGfMLbSKHLnAnq+mNVG4S+gMfCuPdHZBtmFb20T0
         zQew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SmZOhr2At1rMDgNNXtY5F9FoFdcOI3/Q/IAFqc+WtUo=;
        b=ZX90a5B4V0LbRINRhxV+QaywtY02C7Bto4XLVC61Fkyab8TW933NFup3bMmo19QRyG
         KKqT3Wk+DqTJGW7IoejnZBs4AVH1Sz/7zt0gLv6fUFukm5UrhG6h1ULHiqzV8FapSQVU
         c+p5/c7AVmgClfZZHz7ieQRS+Qf4qsCkTLKHncDq+GjP22WteE0PI4J1+oNFDwn9SGEO
         qizTahNz1fuc8Ckyp+S+fppW91KnhB/+peGO6krqvoD20Jr4+8LOcR/0uxe+DJo98ebJ
         8fCDvg1LeVUa7OwKuI7J0oTH2ThcdBz0OfhMw3svV58V4+/ftteM4yiiYhQa9/wFpD07
         l5zw==
X-Gm-Message-State: AOAM530+U5jRsvp5Gw646vqW3XcwYy6JAydDSb2j4uRQXUz4EBwxXBpC
        sorKffSr6TaJqj3hps+B1uU=
X-Google-Smtp-Source: ABdhPJy/E+vOr+CPycUbYSEKuE1Z35HSTIq+hhXu7rXfmokZ8yJM+rvFNqk8DyBqOemqWtCVhAJxrQ==
X-Received: by 2002:a9d:2c06:: with SMTP id f6mr4166020otb.122.1598069820227;
        Fri, 21 Aug 2020 21:17:00 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:228:31e8:cd20:3a66? ([2605:6000:8b03:f000:228:31e8:cd20:3a66])
        by smtp.gmail.com with ESMTPSA id w22sm870555ooq.37.2020.08.21.21.16.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 21:16:59 -0700 (PDT)
Subject: Re: [PATCH v3 11/17] rdma_rxe: Address an issue with hardened user
 copy
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200820224638.3212-1-rpearson@hpe.com>
 <20200820224638.3212-12-rpearson@hpe.com>
 <4fd91289-7cd7-a62c-54ee-4ace9eb45a14@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <f69f8a27-e4e6-88ae-77d8-358fde60d72e@gmail.com>
Date:   Fri, 21 Aug 2020 23:16:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <4fd91289-7cd7-a62c-54ee-4ace9eb45a14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/21/20 10:32 PM, Zhu Yanjun wrote:
> On 8/21/2020 6:46 AM, Bob Pearson wrote:
>> Added a new feature to pools to let driver white list a region of
>> a pool object. This removes a kernel oops caused when create qp
>> returns the qp number so the next patch will work without errors.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_pool.c | 20 +++++++++++++++++---
>>   drivers/infiniband/sw/rxe/rxe_pool.h |  4 ++++
>>   2 files changed, 21 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index 5679714827ec..374e56689d30 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -40,9 +40,12 @@ struct rxe_type_info rxe_type_info[RXE_NUM_TYPES] = {
>>           .name        = "rxe-qp",
>>           .size        = sizeof(struct rxe_qp),
>>           .cleanup    = rxe_qp_cleanup,
>> -        .flags        = RXE_POOL_INDEX,
>> +        .flags        = RXE_POOL_INDEX
>> +                | RXE_POOL_WHITELIST,
>>           .min_index    = RXE_MIN_QP_INDEX,
>>           .max_index    = RXE_MAX_QP_INDEX,
>> +        .user_offset    = offsetof(struct rxe_qp, ibqp.qp_num),
>> +        .user_size    = sizeof(u32),
>>       },
>>       [RXE_TYPE_CQ] = {
>>           .name        = "rxe-cq",
>> @@ -116,10 +119,21 @@ int rxe_cache_init(void)
>>           type = &rxe_type_info[i];
>>           size = ALIGN(type->size, RXE_POOL_ALIGN);
>>           if (!(type->flags & RXE_POOL_NO_ALLOC)) {
>> -            type->cache =
>> -                kmem_cache_create(type->name, size,
>> +            if (type->flags & RXE_POOL_WHITELIST) {
>> +                type->cache =
>> +                    kmem_cache_create_usercopy(
>> +                        type->name, size,
>> +                        RXE_POOL_ALIGN,
>> +                        RXE_POOL_CACHE_FLAGS,
>> +                        type->user_offset,
>> +                        type->user_size, NULL);
>> +            } else {
>> +                type->cache =
>> +                    kmem_cache_create(type->name, size,
>>                             RXE_POOL_ALIGN,
>>                             RXE_POOL_CACHE_FLAGS, NULL);
>> +            }
>> +
>>               if (!type->cache) {
>>                   pr_err("Unable to init kmem cache for %s\n",
>>                          type->name);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
>> index 664153bf9392..fc5b584a8137 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
>> @@ -17,6 +17,7 @@ enum rxe_pool_flags {
>>       RXE_POOL_INDEX        = BIT(1),
>>       RXE_POOL_KEY        = BIT(2),
>>       RXE_POOL_NO_ALLOC    = BIT(4),
>> +    RXE_POOL_WHITELIST    = BIT(5),
>>   };
>>     enum rxe_elem_type {
>> @@ -44,6 +45,9 @@ struct rxe_type_info {
>>       u32            min_index;
>>       size_t            key_offset;
>>       size_t            key_size;
>> +    /* for white listing where necessary */
> 
> s/where/when
> 
> 
>> +    unsigned int        user_offset;
>> +    unsigned int        user_size;
>>       struct kmem_cache    *cache;
>>   };
>>   
> 
> 
The reason for this change is that every time I do anything with rdma_rxe on current head of tree I get a kernel oops with a warning that there is a bad or missing white list. I traced this back to the user_copy routine which (recently) decided that when you copy just a part of a kernel memory object stored in a kmem cache that this represented a risk of leaking information from the kernel to user space. For the QP object the qp_num is copied back to user space in the user API. They also provided a new kmem_ccache_create_usercopy call that allows you to specify a 'whitelisted' portion of each object with an offset and length. So I just made it a feature of pools since it may come up again instead of treating QPs differently that all the other objects. This is part of a general program to harden the Linux kernel.
You can see the change to rxe_cache_init in the same file. Perhaps just dropping the comment would address the concern. See an earlier post I made with a pointer to an article in lwn describing the changes to the kernel.
