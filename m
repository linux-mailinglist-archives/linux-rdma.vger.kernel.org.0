Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105C6508D73
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Apr 2022 18:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380702AbiDTQhx (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Apr 2022 12:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380667AbiDTQhw (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Apr 2022 12:37:52 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542671BEAC
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 09:35:00 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id 204so1619737qkg.5
        for <linux-rdma@vger.kernel.org>; Wed, 20 Apr 2022 09:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=3FTVrMzh4Bd6LbiHoXIeTBkqxtiYApaCJP7OwGcTsRA=;
        b=CowhKkpermBdsSZMZYz+eFJz6Ws14ZYe0v7Vv/0e4vVlPtN/QCF9blzQn/7xfIwjry
         PBf8RFVSbHSeQlNiFjtFUodTXmi6pFefmHWGOCY9sW3N92gSjfGiR2SDknh7Aj/AiAfd
         PH0B/QIHEuRHLHpdcQRLf2zrfP9SQsrQLQWaj+2ZRqv4RVSW6N3nOlmHQ3BMjc2NOx/x
         /gXXL2V6nhUgSlNWX6S7xU9SDn6VhjhpJik+n339lyxIUQjTyauWmpO7LnMgE7w8pV1v
         /IBRwo/XpuDD7Dg/A44hFGn0zdp63E22VMByqzEJbbStncEn8NRg+jmwhG8MagvEb3J3
         3Lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3FTVrMzh4Bd6LbiHoXIeTBkqxtiYApaCJP7OwGcTsRA=;
        b=MLWmNEEqVl1LL6scbJBd98JG5Pfliqcmgny2azUP4j5xWNkXgxbh7RBjs+B0mH/F9N
         rDEy2msSzBC6V8v+5k3dW6gADNfdilU/sxObjNGrSNotF1klZPOMS2vydREHp8190Mcr
         kbuqCJGKgNIe58JnOvVYkVjBFmyaw+11Z5AXTYoNU4hT+Zg+sb4bbn6SVgzRQ4hPwHnS
         NIkc7WdeusjK94fW4L4N4AP+yJS7xJjzbmHNYbVTco8N0ut0nATwd8A5Rg4arc9EhtRd
         IOZXF0n5SYIQag+vJnK0YEgKhbZ9bGnuO2foFMeLBHE7u4YSHqrE0KfaXGVGXwP0cLA/
         hnVA==
X-Gm-Message-State: AOAM532JdZ1LhZdoRm86paxgIvrAzDAP50W2zyDwDejrYx5xVhTYwL0q
        0A09Ravj3yuqwGjcIOIs8A8ReQ==
X-Google-Smtp-Source: ABdhPJwutVVhTzNTrisDcBUrUodUYIOi9p2soOLPPan4ZOuAB7P8KPQVqOqGhzTc89mfyAdEIaWQRw==
X-Received: by 2002:a05:620a:4450:b0:69e:a1ce:cabe with SMTP id w16-20020a05620a445000b0069ea1cecabemr8503438qkp.400.1650472499372;
        Wed, 20 Apr 2022 09:34:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id x10-20020a37630a000000b0069ecbe5dd32sm1710477qkb.130.2022.04.20.09.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 09:34:58 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nhDIA-0061Ng-A0; Wed, 20 Apr 2022 13:34:58 -0300
Date:   Wed, 20 Apr 2022 13:34:58 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     yanjun.zhu@linux.dev
Cc:     leon@kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCHv2 2/2] RDMA/rxe: Use different xa locks on different path
Message-ID: <20220420163458.GR64706@ziepe.ca>
References: <20220417024343.568777-1-yanjun.zhu@linux.dev>
 <20220417024343.568777-2-yanjun.zhu@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220417024343.568777-2-yanjun.zhu@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Apr 16, 2022 at 10:43:43PM -0400, yanjun.zhu@linux.dev wrote:
> From: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> The function __rxe_add_to_pool is called on different path, and the
> requirement of the locks is different. The function rxe_create_ah
> requires xa_lock_irqsave/irqrestore while others only require xa_lock_irq.
> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> V1->V2: Use pool type instead of gfp_t;
>  drivers/infiniband/sw/rxe/rxe_pool.c | 18 +++++++++++++-----
>  1 file changed, 13 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index f1f06dc7e64f..5b097d6666eb 100644
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -157,7 +157,6 @@ void *rxe_alloc(struct rxe_pool *pool)
>  int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  {
>  	int err;
> -	unsigned long flags;
>  
>  	if (WARN_ON(pool->flags & RXE_POOL_ALLOC))
>  		return -EINVAL;
> @@ -169,10 +168,19 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  	elem->obj = (u8 *)elem - pool->elem_offset;
>  	kref_init(&elem->ref_cnt);
>  
> -	xa_lock_irqsave(&pool->xa, flags);
> -	err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> -				&pool->next, GFP_ATOMIC);
> -	xa_unlock_irqrestore(&pool->xa, flags);
> +	if (pool->type == RXE_TYPE_AH) {
> +		unsigned long flags;
> +
> +		xa_lock_irqsave(&pool->xa, flags);
> +		err = __xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
> +					&pool->next, GFP_ATOMIC);
> +		xa_unlock_irqrestore(&pool->xa, flags);

This is still not right - you have to test RDMA_CREATE_AH_SLEEPABLE
for the AH path as well.

Jason
