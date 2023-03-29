Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EDD6CF3D3
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 21:57:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbjC2T5v (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 15:57:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjC2T5u (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 15:57:50 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655D11A6
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:57:48 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id bi31so12510399oib.9
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 12:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680119867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wQj3HvtPH059svwtMzvZ56WLk7yEO3y1PwuwsrPStYA=;
        b=UqiJeyTp8dIDsjtv7HJVgE4V0lu9AXsyAIIq/SrHeNK9a3WKPXHe1Gl6G4lCOeUGA0
         G55827g2FY/rzzDnJBu4dnSqiyNHdnPEaQ3HGhiiCOG42WoP5RCIWvPIwLxWLI5Trh0X
         dJ7IOaozbA4q6q3J4+SqCBw44lcbRfjtsWw022gcSkMhU9Zh0lVOeKjyoc+CXLAVMz3r
         C8iXBixyn2XOYK//5xttYXnkp7L3I2xdr2QadMHh6ir3bWaz4UG1nHYELLG161z7XnEU
         wcmvV/Jk1CZyMmJulMaPLUBkQNvKsAb3+pn4XFn5lFX7R9XHW5eLshGgFKqRT1b1Wk/h
         9wTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680119867;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wQj3HvtPH059svwtMzvZ56WLk7yEO3y1PwuwsrPStYA=;
        b=Q7gLtVxRckClpnWfWzZtMxnOWBC3KQ3XE5jAemodIYgcA2WjC4kJJwOC1n9F4ljKuA
         cH5C8ksg2mB0G4btjv13ORsxPyRFrg3PuAGqiKnlD+z7qNgjWiWFBiVvR+bOyF4Y8Ufe
         G7GZ8SHq80eAI60n7YVmkHaND/sipazSlPn9Ye/L6suJRcnfqFV7GJUphECuNqXNRx+m
         PyAthsa+4/wtJ/zVw9H7dqwsiXirtvilEG6637iMShKTKUsZX2k2jq34LqWJWCbgsKja
         50Qjyg79WIu95qb4RORsQ+4F0ssH4ICpTZYrvXa3gwKtp5u+GUN4O1k+T6PomfA8gEWc
         tbDA==
X-Gm-Message-State: AO0yUKXM0QBTK959eBOstAycOSjpLuJwhtgOdbT3DbwrYWpucbetkxmD
        ol67aAl9vLXm85jP7TjiFP0=
X-Google-Smtp-Source: AK7set/K4UcX22H2fr7yQLjfFIbPAArEWJdoxJfoTLo+fJAF9AWoJQlMPyEVeHoLEc4oieMKi7pe6A==
X-Received: by 2002:a05:6808:6081:b0:387:2e2e:7b2 with SMTP id de1-20020a056808608100b003872e2e07b2mr9183526oib.26.1680119867692;
        Wed, 29 Mar 2023 12:57:47 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c? (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id p204-20020acaf1d5000000b003845f4991c7sm14018533oih.11.2023.03.29.12.57.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 12:57:47 -0700 (PDT)
Message-ID: <9e4d8e2e-d737-98a7-c2dd-174966da4551@gmail.com>
Date:   Wed, 29 Mar 2023 14:57:46 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH rdma-next] RDMA/rxe: Clean kzalloc failure paths
Content-Language: en-US
To:     Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>
Cc:     Leon Romanovsky <leonro@nvidia.com>,
        Dan Carpenter <error27@gmail.com>, linux-rdma@vger.kernel.org,
        Zhu Yanjun <zyjzyj2000@gmail.com>
References: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <d3cedf723b84e73e8062a67b7489d33802bafba2.1680113597.git.leon@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 3/29/23 13:14, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> There is no need to print any debug messages after failure to
> allocate memory, because kernel will print OOM dumps anyway.
> 
> Together with removal of these messages, remove useless goto jumps.
> 
> Fixes: 5bf944f24129 ("RDMA/rxe: Add error messages")
> Reported-by: Dan Carpenter <error27@gmail.com>
> Link: https://lore.kernel.org/all/ea43486f-43dd-4054-b1d5-3a0d202be621@kili.mountain
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_queue.c |  5 ++---
>  drivers/infiniband/sw/rxe/rxe_verbs.c | 23 ++++++-----------------
>  2 files changed, 8 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_queue.c b/drivers/infiniband/sw/rxe/rxe_queue.c
> index d6dbf5a0058d..9611ee191a46 100644
> --- a/drivers/infiniband/sw/rxe/rxe_queue.c
> +++ b/drivers/infiniband/sw/rxe/rxe_queue.c
> @@ -61,11 +61,11 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>  
>  	/* num_elem == 0 is allowed, but uninteresting */
>  	if (*num_elem < 0)
> -		goto err1;
> +		return NULL;
>  
>  	q = kzalloc(sizeof(*q), GFP_KERNEL);
>  	if (!q)
> -		goto err1;
> +		return NULL;
>  
>  	q->rxe = rxe;
>  	q->type = type;
> @@ -100,7 +100,6 @@ struct rxe_queue *rxe_queue_init(struct rxe_dev *rxe, int *num_elem,
>  
>  err2:
>  	kfree(q);
> -err1:
>  	return NULL;
>  }
>  
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 090d5bfb1e18..06f071832635 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -1198,11 +1198,8 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>  	int err;
>  
>  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> -	if (!mr) {
> -		err = -ENOMEM;
> -		rxe_dbg_dev(rxe, "no memory for mr");
> -		goto err_out;
> -	}
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
>  
>  	err = rxe_add_to_pool(&rxe->mr_pool, mr);
>  	if (err) {
> @@ -1220,7 +1217,6 @@ static struct ib_mr *rxe_get_dma_mr(struct ib_pd *ibpd, int access)
>  
>  err_free:
>  	kfree(mr);
> -err_out:
>  	rxe_err_pd(pd, "returned err = %d", err);
>  	return ERR_PTR(err);
>  }
> @@ -1235,11 +1231,8 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>  	int err, cleanup_err;
>  
>  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> -	if (!mr) {
> -		err = -ENOMEM;
> -		rxe_dbg_pd(pd, "no memory for mr");
> -		goto err_out;
> -	}
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
>  
>  	err = rxe_add_to_pool(&rxe->mr_pool, mr);
>  	if (err) {
> @@ -1266,7 +1259,6 @@ static struct ib_mr *rxe_reg_user_mr(struct ib_pd *ibpd, u64 start,
>  		rxe_err_mr(mr, "cleanup failed, err = %d", cleanup_err);
>  err_free:
>  	kfree(mr);
> -err_out:
>  	rxe_err_pd(pd, "returned err = %d", err);
>  	return ERR_PTR(err);
>  }
> @@ -1287,11 +1279,8 @@ static struct ib_mr *rxe_alloc_mr(struct ib_pd *ibpd, enum ib_mr_type mr_type,
>  	}
>  
>  	mr = kzalloc(sizeof(*mr), GFP_KERNEL);
> -	if (!mr) {
> -		err = -ENOMEM;
> -		rxe_dbg_mr(mr, "no memory for mr");
> -		goto err_out;
> -	}
> +	if (!mr)
> +		return ERR_PTR(-ENOMEM);
>  
>  	err = rxe_add_to_pool(&rxe->mr_pool, mr);
>  	if (err) {

These are all fine. Thanks!
Reviewed-by:- Bob Pearson <rpearsonhpe@gmail.com>
