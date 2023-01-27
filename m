Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D20F67EE22
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 20:26:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjA0T0e (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 14:26:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbjA0T0b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 14:26:31 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDDA7EFF1
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 11:26:29 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id i5so4968086oih.11
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 11:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NbNPwmAeNcooNjD7hToop0Et6uMnvb7rq8ZJxgwcOJY=;
        b=ooFTaw0aV9mC2CIq9mbqvoyIbQ/PNomzed7uWtAm2uPSSD8+KGHNWopSsbvQSyU3ha
         yqOq77njLyVkGeofc9ISQr6VarR6RFPTSb4OePgQsfRAeI6aPiiW9Oi9JiSHko5dAAXJ
         b3fyaV8XLpYnUdp5M99IEYP+NdBHTdYwrC5+C76xlIhEtAJ0Gnf4uFryQROhY98v3Q6b
         4mXjM3+dv+qDztSpw0MNMRYj3etPi13i5ZiXXQcTLlBbYkfpdEmHjkbMJk5xAcjCjgTA
         bSLgI7rLQCt2C3WCJRFqQO0lKxKF1crrhQ1RgJyPc/33uvDYBq71lHm8yEMgg5ktpYja
         l1/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NbNPwmAeNcooNjD7hToop0Et6uMnvb7rq8ZJxgwcOJY=;
        b=5AW94/b4Pybba72JnAEFYeEWjUw1DvjDFKDszlMMeYdjxHfU1kHCyHpAZp2cQR3mvY
         8wsKyp+EsAihUdlytIlyFN2vhnYzJK8Ltfq4GFAocY0cVNvAZtLVAyhdmBx6TjqMfYl2
         0U8Dv+vuNqbMvUYrDmABmxD0Da1g+PZoQOdANKntuPpEDs6pMVg+NqlI5LJUsC1Ka9KD
         IFz0vsfmrbMiDLie3gsSJytd67kdrVakayE4FSJ/LMUeweA3W0U4RJ0m+G/cfxPhSEE0
         UlnmUgR3opocYJK2VVt+UsMtoY2//ki1TwIv75G4wzqX5wgHf78U7hQeJM17VlU+vDMr
         +LhA==
X-Gm-Message-State: AO0yUKU11ff3dsmjh3ejbPRgiVszRNM1uUqb6RDh8PALtJeqKoQCRMQM
        HPDyw9jzCpfquaFMS++AW7bd55faqBUmcQ==
X-Google-Smtp-Source: AK7set9CD/ouVVPTmg4M6TNl3CsHZ+TkqiFWSu63PdmC9fWvXsRDojCczgVojBoq4T5xCJ5BUmiodw==
X-Received: by 2002:a05:6808:2087:b0:36e:adf1:d0a8 with SMTP id s7-20020a056808208700b0036eadf1d0a8mr4036552oiw.8.1674847589296;
        Fri, 27 Jan 2023 11:26:29 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id g131-20020acab689000000b0036e9160f57csm1919668oif.20.2023.01.27.11.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 11:26:28 -0800 (PST)
Message-ID: <94cccc32-f7fa-2307-29de-2549833d2d2e@gmail.com>
Date:   Fri, 27 Jan 2023 13:26:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v7 0/6] RDMA/rxe: Replace mr page map with an
 xarray
Content-Language: en-US
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org
References: <20230119235936.19728-1-rpearsonhpe@gmail.com>
 <Y9P6bGbtTNYIdoWN@nvidia.com>
From:   Bob Pearson <rpearsonhpe@gmail.com>
In-Reply-To: <Y9P6bGbtTNYIdoWN@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/27/23 10:23, Jason Gunthorpe wrote:
> On Thu, Jan 19, 2023 at 05:59:31PM -0600, Bob Pearson wrote:
>> This patch series replaces the page map carried in each memory region
>> with a struct xarray. It is based on a sketch developed by Jason
>> Gunthorpe. The first five patches are preparation that tries to
>> cleanly isolate all the mr specific code into rxe_mr.c. The sixth
>> patch is the actual change.
>>
>> v7:
>>   Link: https://lore.kernel.org/linux-rdma/Y8f53jdDAN0B9qy7@nvidia.com/
>>   Made changes requested by Jason to return RESPST_ERR_XXX from rxe_mr.c
>>   to rxe_resp.c.
> 
> I took it to for-next, but I made these changes, please check:
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_mr.c b/drivers/infiniband/sw/rxe/rxe_mr.c
> index fe4049330c9f19..c80458634962c6 100644
> --- a/drivers/infiniband/sw/rxe/rxe_mr.c
> +++ b/drivers/infiniband/sw/rxe/rxe_mr.c
> @@ -114,7 +114,8 @@ static int rxe_mr_fill_pages_from_sgt(struct rxe_mr *mr, struct sg_table *sgt)
>  
>  			if (persistent && !is_pmem_page(page)) {
>  				rxe_dbg_mr(mr, "Page can't be persistent\n");
> -				return -EINVAL;
> +				xas_set_err(&xas, -EINVAL);
> +				break;
>  			}
>  
>  			xas_store(&xas, page);

Looks good. Good catch.

> @@ -213,7 +214,6 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
>  {
>  	struct rxe_mr *mr = to_rmr(ibmr);
>  	struct page *page = virt_to_page(iova & mr->page_mask);
> -	XA_STATE(xas, &mr->page_list, mr->nbuf);
>  	bool persistent = !!(mr->access & IB_ACCESS_FLUSH_PERSISTENT);
>  	int err;
>  
> @@ -225,13 +225,7 @@ static int rxe_set_page(struct ib_mr *ibmr, u64 iova)
>  	if (unlikely(mr->nbuf == mr->num_buf))
>  		return -ENOMEM;
>  
> -	do {
> -		xas_lock(&xas);
> -		xas_store(&xas, page);
> -		xas_unlock(&xas);
> -	} while (xas_nomem(&xas, GFP_KERNEL));
> -
> -	err = xas_error(&xas);
> +	err = xa_err(xa_store(&mr->page_list, mr->nbuf, page, GFP_KERNEL));

Looks good.

>  	if (err)
>  		return err;
>  
> @@ -458,10 +452,8 @@ int rxe_flush_pmem_iova(struct rxe_mr *mr, u64 iova, unsigned int length)
>  				mr_page_size(mr) - page_offset);
>  
>  		va = kmap_local_page(page);
> -		if (!va)
> -			return -EFAULT;
> -
>  		arch_wb_cache_pmem(va + page_offset, bytes);
> +		kunmap_local(va);
>  
>  		length -= bytes;
>  		iova += bytes;

Looks good. Good catch. I take it kmap_local_page shouldn't fail.

Thanks,

Bob

