Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E97253B55
	for <lists+linux-rdma@lfdr.de>; Thu, 27 Aug 2020 03:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgH0BV6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 26 Aug 2020 21:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgH0BV5 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 26 Aug 2020 21:21:57 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15B49C0617A3
        for <linux-rdma@vger.kernel.org>; Wed, 26 Aug 2020 18:21:57 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id o13so2165276pgf.0
        for <linux-rdma@vger.kernel.org>; Wed, 26 Aug 2020 18:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=G5jEAJq5hLw/caRVZkLL8IGLMMD+OKZWw84G3sSipsk=;
        b=dS2Gc0vn0y6fFV2WaeaHH7vNiTQHiya0bObmwDZbq3UHqFG5C+iE7vZc+P5RK5lmP8
         lpewe/mrHD3+mckZP8gR7uNMI/fQ3YaJcT9TTYVrJinjpdyuf1xM4vaKnhWOeRGyKfn7
         8VmZh92L5yIkBqBAm3xPAqHjshJnI97Mv/V4l0dIIvrgt1xxYxwn/wRcDQj7DgN/tmI2
         1LmiTdps7Bf2yUqJz9MXWp0ib7hnuU+hqkgbZ15eyiMRxyLVKkF+sUbV2yM0VLNMVS5G
         CqdxdPqKMMMhi5G7o8Zw3dzoSz10Juyzk6ofDZrjvXk4M1q5q8ZfSxkg2aXC/EiPL5Sh
         qoRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=G5jEAJq5hLw/caRVZkLL8IGLMMD+OKZWw84G3sSipsk=;
        b=rfPQe7ye7/pcEfrLOWJzR3aJRP2zKfy6l7Ii03adAVH6ZWVsHyGzGiFr5wXSFwbTwE
         qtVioZQFmeg66iwFpCMB2U1PmxnHHOA74YYL2u1Z9YUD21xCyWtm3qHSv3e3Yb+1XyaO
         2a4OYZnS0ZP9d1i9ZqVqXri30K/IQW0NGqeIjYjPqgBN7rsclBBPhJk5n/4n08GbTivh
         CWt0F0VrBI4vmzgT4jVl7dzfSp1Sf/0zruoczSL7HK4jPHoWL80aUkpVXTs/dl0EM7US
         yKRcZuWItmGcXSe1JrNrUL8LwRDrwhYXKZQjpp5v3ad5DlUoKqyB9RrR1jlZwVL9fGKS
         jGpQ==
X-Gm-Message-State: AOAM530xvZMzm4MUa1rVphmft4hxgCmsxYZRA8sPXmSIrXS8yPqUGCpf
        aT9x2yL/wtI84rpOheuLqhY=
X-Google-Smtp-Source: ABdhPJwiAI/QBUpl26O52RV1DAC6r7nBP1SqnSGGDXLUsLb2RClVcLvhbZ9ybIqHLJmo82lip60G5Q==
X-Received: by 2002:a17:902:a508:: with SMTP id s8mr14284886plq.152.1598491316543;
        Wed, 26 Aug 2020 18:21:56 -0700 (PDT)
Received: from [10.75.201.17] ([118.201.220.138])
        by smtp.gmail.com with ESMTPSA id b18sm307909pjq.3.2020.08.26.18.21.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Aug 2020 18:21:55 -0700 (PDT)
Subject: Re: [PATCH for-next] rdma_rxe: address an issue with hardened user
 copy
To:     Bob Pearson <rpearsonhpe@gmail.com>, leon@kernel.org,
        linux-rdma@vger.kernel.org
Cc:     Bob Pearson <rpearson@hpe.com>
References: <20200825165836.27477-1-rpearson@hpe.com>
From:   Zhu Yanjun <zyjzyj2000@gmail.com>
Message-ID: <a63b12bf-322f-f3ef-271e-cbf12944301f@gmail.com>
Date:   Thu, 27 Aug 2020 09:21:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
MIME-Version: 1.0
In-Reply-To: <20200825165836.27477-1-rpearson@hpe.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/26/2020 12:58 AM, Bob Pearson wrote:
> Change rxe pools to use kzalloc instead of kmem_cache to allocate

Why do you use kzalloc instead of kmem_cache? For performance or some bugs?

Zhu Yanjun

> memory for rxe objects.
>
> Signed-off-by: Bob Pearson <rpearson@hpe.com>
> ---
>   drivers/infiniband/sw/rxe/rxe.c      |  8 ----
>   drivers/infiniband/sw/rxe/rxe_pool.c | 60 +---------------------------
>   drivers/infiniband/sw/rxe/rxe_pool.h |  7 ----
>   3 files changed, 2 insertions(+), 73 deletions(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe.c b/drivers/infiniband/sw/rxe/rxe.c
> index cc395da13eff..a1ff70e0b1f8 100644
> --- a/drivers/infiniband/sw/rxe/rxe.c
> +++ b/drivers/infiniband/sw/rxe/rxe.c
> @@ -277,13 +277,6 @@ static int __init rxe_module_init(void)
>   {
>   	int err;
>   
> -	/* initialize slab caches for managed objects */
> -	err = rxe_cache_init();
> -	if (err) {
> -		pr_err("unable to init object pools\n");
> -		return err;
> -	}
> -
>   	err = rxe_net_init();
>   	if (err)
>   		return err;
> @@ -298,7 +291,6 @@ static void __exit rxe_module_exit(void)
>   	rdma_link_unregister(&rxe_link_ops);
>   	ib_unregister_driver(RDMA_DRIVER_RXE);
>   	rxe_net_exit();
> -	rxe_cache_exit();
>   
>   	pr_info("unloaded\n");
>   }
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index c0fab4a65f9e..70fc9f7a25b6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -84,62 +84,6 @@ static inline const char *pool_name(struct rxe_pool *pool)
>   	return rxe_type_info[pool->type].name;
>   }
>   
> -static inline struct kmem_cache *pool_cache(struct rxe_pool *pool)
> -{
> -	return rxe_type_info[pool->type].cache;
> -}
> -
> -static void rxe_cache_clean(size_t cnt)
> -{
> -	int i;
> -	struct rxe_type_info *type;
> -
> -	for (i = 0; i < cnt; i++) {
> -		type = &rxe_type_info[i];
> -		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
> -			kmem_cache_destroy(type->cache);
> -			type->cache = NULL;
> -		}
> -	}
> -}
> -
> -int rxe_cache_init(void)
> -{
> -	int err;
> -	int i;
> -	size_t size;
> -	struct rxe_type_info *type;
> -
> -	for (i = 0; i < RXE_NUM_TYPES; i++) {
> -		type = &rxe_type_info[i];
> -		size = ALIGN(type->size, RXE_POOL_ALIGN);
> -		if (!(type->flags & RXE_POOL_NO_ALLOC)) {
> -			type->cache =
> -				kmem_cache_create(type->name, size,
> -						  RXE_POOL_ALIGN,
> -						  RXE_POOL_CACHE_FLAGS, NULL);
> -			if (!type->cache) {
> -				pr_err("Unable to init kmem cache for %s\n",
> -				       type->name);
> -				err = -ENOMEM;
> -				goto err1;
> -			}
> -		}
> -	}
> -
> -	return 0;
> -
> -err1:
> -	rxe_cache_clean(i);
> -
> -	return err;
> -}
> -
> -void rxe_cache_exit(void)
> -{
> -	rxe_cache_clean(RXE_NUM_TYPES);
> -}
> -
>   static int rxe_pool_init_index(struct rxe_pool *pool, u32 max, u32 min)
>   {
>   	int err = 0;
> @@ -381,7 +325,7 @@ void *rxe_alloc(struct rxe_pool *pool)
>   	if (atomic_inc_return(&pool->num_elem) > pool->max_elem)
>   		goto out_cnt;
>   
> -	elem = kmem_cache_zalloc(pool_cache(pool),
> +	elem = kzalloc(rxe_type_info[pool->type].size,
>   				 (pool->flags & RXE_POOL_ATOMIC) ?
>   				 GFP_ATOMIC : GFP_KERNEL);
>   	if (!elem)
> @@ -443,7 +387,7 @@ void rxe_elem_release(struct kref *kref)
>   		pool->cleanup(elem);
>   
>   	if (!(pool->flags & RXE_POOL_NO_ALLOC))
> -		kmem_cache_free(pool_cache(pool), elem);
> +		kfree(elem);
>   	atomic_dec(&pool->num_elem);
>   	ib_device_put(&pool->rxe->ib_dev);
>   	rxe_pool_put(pool);
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.h b/drivers/infiniband/sw/rxe/rxe_pool.h
> index 64d92be3f060..3d722aae5f15 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.h
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.h
> @@ -42,7 +42,6 @@ struct rxe_type_info {
>   	u32			min_index;
>   	size_t			key_offset;
>   	size_t			key_size;
> -	struct kmem_cache	*cache;
>   };
>   
>   extern struct rxe_type_info rxe_type_info[];
> @@ -96,12 +95,6 @@ struct rxe_pool {
>   	} key;
>   };
>   
> -/* initialize slab caches for managed objects */
> -int rxe_cache_init(void);
> -
> -/* cleanup slab caches for managed objects */
> -void rxe_cache_exit(void);
> -
>   /* initialize a pool of objects with given limit on
>    * number of elements. gets parameters from rxe_type_info
>    * pool elements will be allocated out of a slab cache


