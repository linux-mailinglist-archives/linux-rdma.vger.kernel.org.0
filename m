Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4776CF430
	for <lists+linux-rdma@lfdr.de>; Wed, 29 Mar 2023 22:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbjC2UOI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 29 Mar 2023 16:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjC2UOH (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 29 Mar 2023 16:14:07 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8F44ED3
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 13:14:06 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id y184so12557047oiy.8
        for <linux-rdma@vger.kernel.org>; Wed, 29 Mar 2023 13:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680120846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7ZHJPWEzb003n5XCm12NxdjUPTw/AJmKqsv3cCUWZU=;
        b=oU+5f1RqjX7gLQ/3PwYf1FAbkPVgPZE1iJImuOTPgvmz1/4YE6v1x9AHkBPCWo6uQq
         TBii8bZ5S4CkwaVj0ZFGUdySB0+43TkptQbrMChox8nZLibrxJiumNsFHv6gstOp5YtH
         HpPk1S5UcYGLA6rhTYasX5RXxZEvggoy3oBsbwbnfitK0+v8/WA/VaskwOJm2rGRHKdk
         EmmMO326LgkYt2H8X9+nDCS8iavAUYUf5gtm7/kDqD9Tyx8psxPo39mkMYdaqTeEbgOb
         oxITlf9WDfjLJqcTcyjQDc9LsgyeGzG+cjO9ZHmhKssPx/SSiMsUsenl0bTnFgkIGHKY
         Cwvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680120846;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7ZHJPWEzb003n5XCm12NxdjUPTw/AJmKqsv3cCUWZU=;
        b=FOH8bfs2pKIm3/0XL/8d8CdcwYlPnnNyoysZlTF2Nv37hoyVtMvkS4ydYqmkUwh1pL
         ToRw7nMukRczxIfX7NaUn12plYSFKMje52Bu4Jo0/7XeOZ9pSZNWZ6F5oGzHERku59wQ
         19oRQcNlFwmTV7o+BEYgdhD46GfglXypO3b0Fc4wmkbOtL0z9ahE9+kEaRy2wo4gtJ0E
         Pt/FQclntoCG9TY+OzqkPgFZRCisDLZlJfRoUCD11rYksbURgt9Z8FOSvKMwbxh7TqpK
         i8ScWMA+LXjyoaa+o4YxVDgMXgkh3sDflR/NmnNPNu4s2ou0X16KxVdaWmbI+3Ef4HIn
         lEZw==
X-Gm-Message-State: AO0yUKWql1ep3SGl87J4T/zKvsqlucc9iqeQFi6jt1mjqfOucMQH43N9
        w6MCg6ZEW7m876aT+QkZ8ZhqSljuYKw=
X-Google-Smtp-Source: AK7set8+Zkx04mi+Of+42EHJb82sSD6A73Jwx93wDN66E0YeoAbgqOC4wh1nhEodmuJNGhtDhGztrQ==
X-Received: by 2002:a05:6808:6192:b0:386:c463:4963 with SMTP id dn18-20020a056808619200b00386c4634963mr9111594oib.57.1680120846160;
        Wed, 29 Mar 2023 13:14:06 -0700 (PDT)
Received: from ?IPV6:2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c? (2603-8081-140c-1a00-5b9e-1cc2-c3f7-6f9c.res6.spectrum.com. [2603:8081:140c:1a00:5b9e:1cc2:c3f7:6f9c])
        by smtp.gmail.com with ESMTPSA id c3-20020aca1c03000000b0038901ece6e9sm4923216oic.12.2023.03.29.13.14.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 13:14:05 -0700 (PDT)
Message-ID: <ed178af5-841f-2615-3b51-8f8bcf656e46@gmail.com>
Date:   Wed, 29 Mar 2023 15:14:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 2/2] RDMA/rxe: Pass a pointer to virt_to_page()
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Leon Romanovsky <leonro@nvidia.com>
Cc:     linux-rdma@vger.kernel.org
References: <20230329142341.863175-1-linus.walleij@linaro.org>
 <20230329142341.863175-2-linus.walleij@linaro.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <20230329142341.863175-2-linus.walleij@linaro.org>
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

On 3/29/23 09:23, Linus Walleij wrote:
> Like the other calls in this function virt_to_page() expects
> a pointer, not an integer.
> 
> However since many architectures implement virt_to_pfn() as
> a macro, this function becomes polymorphic and accepts both a
> (unsigned long) and a (void *).
> 
> Fix this up with an explicit cast.
> 
> Then we need a second cast to (uintptr_t). This is because
> the kernel robot builds this driver also for the PARISC,
> yielding the following build error on PARISC when casting
> (void *) to virt_to_page():
> 
> drivers/infiniband/sw/rxe/rxe_mr.c: In function 'rxe_set_page':
>>> drivers/infiniband/sw/rxe/rxe_mr.c:216:42: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
>      216 |         struct page *page = virt_to_page((void *)(iova & mr->page_mask));
>          |                                          ^
>    include/asm-generic/memory_model.h:18:46: note: in definition of macro '__pfn_to_page'
>       18 | #define __pfn_to_page(pfn)      (mem_map + ((pfn) - ARCH_PFN_OFFSET))
>          |                                              ^~~
>    arch/parisc/include/asm/page.h:179:45: note: in expansion of macro '__pa'
>      179 | #define virt_to_page(kaddr)     pfn_to_page(__pa(kaddr) >> PAGE_SHIFT)
>          |                                             ^~~~
>    drivers/infiniband/sw/rxe/rxe_mr.c:216:29: note: in expansion of macro 'virt_to_page'
>      216 |         struct page *page = virt_to_page((void *)(iova & mr->page_mask));
>          |                             ^~~~~~~~~~~~
> 
> First: I think this happens because iova is u64 by design and
> (void *) on PARISC is sometimes 32 bit.
> 
> Second: compilation of the SW RXE driver on PARISC is made possible
> because it fulfills depends on INFINIBAND_VIRT_DMA since that is just
> def_bool !HIGHMEM and PARISC does not have HIGHMEM.
> 
> By first casting iova to (uintptr_t) it is turned into a u32 on PARISC
> or any other 32bit system and u64 on any 64BIT system.
> 
> Link: https://lore.kernel.org/linux-rdma/202303242000.HmTaa6yB-lkp@intel.com/
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Fix up confusion between virtual and physical addresses found
>   by Jason in a separate patch.
> - Fix up compilation on PARISC by additional cast.
>   I don't know if this is the right solution, perhaps RDMA should
>   rather depend on 64BIT if the subsystem is only for 64BIT
>   systems?
> ---
>  drivers/infiniband/sw/rxe/rxe_mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index 8e8250652f9d..a5efb0575956 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -213,7 +213,7 @@ int rxe_mr_init_fast(int max_pages, struct rxe_mr *mr)
>  static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
>  {
>  	struct rxe_mr *mr = to_rmr(ibmr);
> -	struct page *page = virt_to_page(iova & mr->page_mask);
> +	struct page *page = virt_to_page((void *)(uintptr_t)(iova & mr->page_mask));
>  	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
>  	int err;
>  

Linus, Thanks for these. AFAIK these are just fine. I am not aware of any interest in 32 bit
support for the rxe driver. My testing has been limited to IA64 architectures but I would be interested
in going further with emulated hardware.

Reviewed-by: Bob Pearson <rpearsonhpe@gmail.com>
