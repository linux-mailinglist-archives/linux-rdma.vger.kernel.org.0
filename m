Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6BD2253B62
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 03:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgH0Bal (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 21:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgH0Bal (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 21:30:41 -0400
Received: from mail-oo1-xc44.google.com (mail-oo1-xc44.google.com [IPv6:2607:f8b0:4864:20::c44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0FC0617AB
        for <linux-rdma@vger.kernel.org>; Wed, 26 Aug 2020 18:30:41 -0700 (PDT)
Received: by mail-oo1-xc44.google.com with SMTP id h9so876980ooo.10
        for <linux-rdma@vger.kernel.org>; Wed, 26 Aug 2020 18:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HAVgogr7olt2qyGLihDYFgsDbgMfyHqGPLhtYLiCMfY=;
        b=cjEaJS16Ss64Djufb9yoHBJN7Q+aXBzDjJ48ooscJoDiHShG70b26N5Y6+kg0dCoDt
         KbSO1DXEsFyCucWv39bAFjHTz/+awkMNK2WYr+wgwljN1a+2LD7X4aTWV9X9RPKytBgm
         N2qOan3xQEgl4hZlE44VYCYCQZERYrhqPBMVVb9G6w/okXreLranb/gX4TEIZoJ0ifh8
         tiGIIMVHWcLSjUGUJuoAE2cgMYrSLhdNgYkpNkDaGRL+rgQ3/QYxf4RaWD9OXb6T9IkS
         2wgjSBEC/cJDn5tQ/hg1nkjOTqzkH2wog33A+JYiDpHG+9Te0xdgXzRmJ6Cpjj669TCM
         bMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HAVgogr7olt2qyGLihDYFgsDbgMfyHqGPLhtYLiCMfY=;
        b=FfHxiuwJ8uCZv0GnXzUNXD1iTNTi1v1UTUlNtdIOp6McgirkdhLhWO2RNFF9e7ZLkz
         ehdfcoAMZ9TZxoaqYAZAssXqfQdE3pG4ppMCHdL241JS+xm4mNuGZEtcfmaJx5TUoCSi
         odOrEfSrkjr8swFASAZsQgZmi1tk31/zzj8gYR812FFGndilXFhbPcQxSWpoDmvSOMNo
         dIlm3R2Rw69ty8fTesJ4SHozJlxcusKB26WqD7ap5QnQQ6jRcXmh9vrofI560TS3WR+D
         35fMsqz1LO1t63AkkGdVKhFCyMDOVbinLXv3LASiNPlCbwYXMlLZb8avwwwIqVpzPe7p
         U6GQ==
X-Gm-Message-State: AOAM530buoNUtArTnMKeDBDKeKWI5AQNPJO0Lu0vDNjkKAeFr81GZ92e
        VgAkoC2SZFBxSU9XNPsa5QaPhjmTjC3w3w==
X-Google-Smtp-Source: ABdhPJxTr5l9ZsaiIlUcOAv/zd0Yjqt0kmrl9ePkTLR30uCraea5OX8sbPgLyVy1DvahBYYrzCOEBA==
X-Received: by 2002:a4a:aa0e:: with SMTP id x14mr12381689oom.27.1598491840382;
        Wed, 26 Aug 2020 18:30:40 -0700 (PDT)
Received: from ?IPv6:2605:6000:8b03:f000:872d:55b6:c324:4146? ([2605:6000:8b03:f000:872d:55b6:c324:4146])
        by smtp.gmail.com with ESMTPSA id w11sm155361oog.33.2020.08.26.18.30.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 18:30:39 -0700 (PDT)
Subject: Re: [PATCH for-next] rdma_rxe: address an issue with hardened user
 copy
To:     Zhu Yanjun <zyjzyj2000@gmail.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200825165836.27477-1-rpearson@hpe.com>
 <a63b12bf-322f-f3ef-271e-cbf12944301f@gmail.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Message-ID: <83fe1102-56f7-0632-a058-a264169789df@gmail.com>
Date:   Wed, 26 Aug 2020 20:30:39 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a63b12bf-322f-f3ef-271e-cbf12944301f@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/26/20 8:21 PM, Zhu Yanjun wrote:
> On 8/26/2020 12:58 AM, Bob Pearson wrote:
>> Change rxe pools to use kzalloc instead of kmem_cache to allocate
> 
> Why do you use kzalloc instead of kmem_cache? For performance or some bugs?
> 
> Zhu Yanjun
> 
>> memory for rxe objects.
>>
>> Signed-off-by: Bob Pearson <rpearson@hpe.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe.c      |  8 ----
>>   drivers/infiniband/sw/rxe/rxe_pool.c | 60 +---------------------------
>>   drivers/infiniband/sw/rxe/rxe_pool.h |  7 ----
>>   3 files changed, 2 insertions(+), 73 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
>> index cc395da13eff..a1ff70e0b1f8 100644
>> --- a/drivers/infiniband/sw/rxe/rxe.c
>> +++ b/drivers/infiniband/sw/rxe/rxe.c
>> @@ -277,13 +277,6 @@ static int __init rxe_module_init(void)
>>   {
>>       int err;
>>   -    /* initialize slab caches for managed objects */
>> -    err = rxe_cache_init();
>> -    if (err) {
>> -        pr_err("unable to init object pools\n");
>> -        return err;
>> -    }
>> -
>>       err = rxe_net_init();
>>       if (err)
>>           return err;
>> @@ -298,7 +291,6 @@ static void __exit rxe_module_exit(void)
>>       rdma_link_unregister(&rxe_link_ops);
>>       ib_unregister_driver(RDMA_DRIVER_RXE);
>>       rxe_net_exit();
>> -    rxe_cache_exit();
>>         pr_info("unloaded\n");
>>   }
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
>> index c0fab4a65f9e..70fc9f7a25b6 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
>> @@ -84,62 +84,6 @@ static inline const char *pool_name(struct rxe_pool *pool)
>>       return rxe_type_info[pool->type].name;
>>   }
>>   -static inline struct kmem_cache *pool_cache(struct rxe_pool *pool)
>> -{
>> -    return rxe_type_info[pool->type].cache;
>> -}
>> -
>> -static void rxe_cache_clean(size_t cnt)
>> -{
>> -    int i;
>> -    struct rxe_type_info *type;
>> -
>> -    for (i = 0; i < cnt; i++) {
>> -        type = &rxe_type_info[i];
>> -        if (!(type->flags & RXE_POOL_NO_ALLOC)) {
>> -            kmem_cache_destroy(type->cache);
>> -            type->cache = NULL;
>> -        }
>> -    }
>> -}
>> -
>> -int rxe_cache_init(void)
>> -{
>> -    int err;
>> -    int i;
>> -    size_t size;
>> -    struct rxe_type_info *type;
>> -
>> -    for (i = 0; i < RXE_NUM_TYPES; i++) {
>> -        type = &rxe_type_info[i];
>> -        size = ALIGN(type->size, RXE_POOL_ALIGN);
>> -        if (!(type->flags & RXE_POOL_NO_ALLOC)) {
>> -            type->cache =
>> -                kmem_cache_create(type->name, size,
>> -                          RXE_POOL_ALIGN,
>> -                          RXE_POOL_CACHE_FLAGS, NULL);
>> -            if (!type->cache) {
>> -                pr_err("Unable to init kmem cache for %s\n",
>> -                       type->name);
>> -                err = -ENOMEM;
>> -                goto err1;
>> -            }
>> -        }
>> -    }
>> -
>> -    return 0;
>> -
>> -err1:
>> -    rxe_cache_clean(i);
>> -
>> -    return err;
>> -}
>> -
>> -void rxe_cache_exit(void)
>> -{
>> -    rxe_cache_clean(RXE_NUM_TYPES);
>> -}
>> -
>>   static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
>>   {
>>       int err = 0;
>> @@ -381,7 +325,7 @@ void *rxe_alloc(struct rxe_pool *pool)
>>       if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>>           goto out_cnt;
>>   -    elem = kmem_cache_zalloc(pool_cache(pool),
>> +    elem = kzalloc(rxe_type_info[pool->type].size,
>>                    (pool->flags & RXE_POOL_ATOMIC) ?
>>                    GFP_ATOMIC : GFP_KERNEL);
>>       if (!elem)
>> @@ -443,7 +387,7 @@ void rxe_elem_release(struct kref *kref)
>>           pool->cleanup(elem);
>>         if (!(pool->flags & RXE_POOL_NO_ALLOC))
>> -        kmem_cache_free(pool_cache(pool), elem);
>> +        kfree(elem);
>>       atomic_dec(&pool->num_elem);
>>       ib_device_put(&pool->rxe->ib_dev);
>>       rxe_pool_put(pool);
>> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
>> index 64d92be3f060..3d722aae5f15 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
>> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
>> @@ -42,7 +42,6 @@ struct rxe_type_info {
>>       u32            min_index;
>>       size_t            key_offset;
>>       size_t            key_size;
>> -    struct kmem_cache    *cache;
>>   };
>>     extern struct rxe_type_info rxe_type_info[];
>> @@ -96,12 +95,6 @@ struct rxe_pool {
>>       } key;
>>   };
>>   -/* initialize slab caches for managed objects */
>> -int rxe_cache_init(void);
>> -
>> -/* cleanup slab caches for managed objects */
>> -void rxe_cache_exit(void);
>> -
>>   /* initialize a pool of objects with given limit on
>>    * number of elements. gets parameters from rxe_type_info
>>    * pool elements will be allocated out of a slab cache
> 
> 
There is a regression in rxe caused by the hardened usercopy patches. It leads to a kernel warning the first time a QP is created each boot. The origin has been discussed in several emails between Leon myself and the list. There are a lot of ways to eliminate the warning but so far there has been resistance to any of these fixes. As far as I can tell there is no performance hit from moving from kmem_cache to kzalloc. (kzalloc and kmalloc just use pre defined caches with objects that are powers of 2 in size.) I am waiting for Leon to express an opinion on this solution. He also has a proposal to allocate QP objects in the core (like PD, etc).

Bob
