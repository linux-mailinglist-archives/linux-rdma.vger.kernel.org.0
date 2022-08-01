Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6BE1587140
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Aug 2022 21:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbiHATOW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Aug 2022 15:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234653AbiHATNh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Aug 2022 15:13:37 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B953371B2;
        Mon,  1 Aug 2022 12:12:45 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id y10-20020a9d634a000000b006167f7ce0c5so8911982otk.0;
        Mon, 01 Aug 2022 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=DGMsJ9bla5eGfElaNQwPSE6Invk7R1PYIXSydXhFXQE=;
        b=TOuFTIk5bbqx/OdF4kCNgl1EQRsvRM7u5VqnAD9qalCC9ZMXm+5fbccr4MbHHYID4h
         Oq5QJljh0B+r6XiGY7psbdGQ/OKoxKcNlAWergO73oNwZZANAikpfqdwxrouwJ9aaVzQ
         /Ga1bTxKGvWkn4z4xqN3Ibja8vnrHba6QXGGbZmyB1ZZP+NOPjIyZORyyd2GjeGwKpEB
         PsrS9E0IzM6Bw2nF8ffuJnQv44QlPpUqkvkYiDXhLlzSo8bdUinWuXdUK75Pwyy0H4ym
         WnQZ3IVEnGUSZ3A1TGw3eccQHZlsaXLwOzpwqd4Jbntg+L10rnwIz56arVKvsZ0LLvp2
         xc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=DGMsJ9bla5eGfElaNQwPSE6Invk7R1PYIXSydXhFXQE=;
        b=L7COGAV+cDmY2pJuQLHbI4JQyMFxNt2tlSVwKnHArMZQ++VDrdY1ETBl9+oP9l9B8U
         xdERPr4dFkNy0fs9y1mmBtTLOAMqyy+D41Ahaf0RM7VyU3G1c6HjIYBOKP/q9Hd1gd4f
         wLPl+1lgFdAVL38VxfO3sL3fYYpc3eWXtVRj2hgAWIqwOiFX1fh12Aka3temvWTU+kdm
         42MGb2wQT7dl1M458FgqYxWhYO+DyBFwu98fCDtrwOO1pqOdxlUoNppIeibDk3RmiToh
         elrFNHpSVk6BOWHjeU7Una19y8OpYl+mDUOAYD8GL2hIIZSi7ftSRQydVYbux/ak1eyC
         ttkg==
X-Gm-Message-State: AJIora+IuknpDJ/iLtRMV6w6w/RNmfAhOkhoewZ5B1kpcVHpu0OPwWuQ
        gCNd2dkqvosFLnBR+RKpAX4=
X-Google-Smtp-Source: AGRyM1vaPJGomInhg99NwnAi/WyqZpjt8gpryl4w+TyjBe0BVa5Qkd+OIWNIroCoM7qj4+AwlcHjWw==
X-Received: by 2002:a05:6830:25c2:b0:61c:c3ab:ca5f with SMTP id d2-20020a05683025c200b0061cc3abca5fmr6453712otu.117.1659381164392;
        Mon, 01 Aug 2022 12:12:44 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:fad3:624f:1d1b:8d14? (2603-8081-140c-1a00-fad3-624f-1d1b-8d14.res6.spectrum.com. [2603:8081:140c:1a00:fad3:624f:1d1b:8d14])
        by smtp.gmail.com with ESMTPSA id f24-20020a056870899800b0010db1a8d931sm3316738oaq.28.2022.08.01.12.12.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 12:12:43 -0700 (PDT)
Message-ID: <13232d91-d50e-0936-7e46-680721119262@gmail.com>
Date:   Mon, 1 Aug 2022 14:12:42 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] RDMA/rxe: Correct error handling in routines allocating
 xarray entries
Content-Language: en-US
To:     William Kucharski <william.kucharski@oracle.com>,
        Zhu Yanjun <zyjzyj2000@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220801073850.841628-1-william.kucharski@oracle.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20220801073850.841628-1-william.kucharski@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 8/1/22 02:38, William Kucharski wrote:
> The current code will report an error if xa_alloc_cyclic() returns
> non-zero, but it will return 1 if it wrapped indices before successfully
> allocating an entry.
> 
> An error should only be reported if the call actually failed (denoted by
> a return value < 0.)
> 
> Fixes: 3225717f6dfa2 ("RDMA/rxe: Replace red-black trees by xarrays")
> Signed-off-by: William Kucharski <william.kucharski@oracle.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_pool.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_pool.c b/drivers/infiniband/sw/rxe/rxe_pool.c
> index 19b14826385b..e9f3bbd8d605 100644
> --- a/drivers/infiniband/sw/rxe/rxe_pool.c
> +++ b/drivers/infiniband/sw/rxe/rxe_pool.c
> @@ -139,7 +139,7 @@ void *rxe_alloc(struct rxe_pool *pool)
>  
>  	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>  			      &pool->next, GFP_KERNEL);
> -	if (err)
> +	if (err < 0)
>  		goto err_free;
>  
>  	return obj;
> @@ -167,7 +167,7 @@ int __rxe_add_to_pool(struct rxe_pool *pool, struct rxe_pool_elem *elem)
>  
>  	err = xa_alloc_cyclic(&pool->xa, &elem->index, elem, pool->limit,
>  			      &pool->next, GFP_KERNEL);
> -	if (err)
> +	if (err < 0)
>  		goto err_cnt;
>  
>  	return 0;

We fixed this a while back but not sure what happened. In any case this is absolutely correct.
You can add

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>

Bob
