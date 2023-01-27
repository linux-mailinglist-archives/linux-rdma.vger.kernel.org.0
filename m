Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9503667EC1C
	for <lists+linux-rdma@lfdr.de>; Fri, 27 Jan 2023 18:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235036AbjA0RH2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 27 Jan 2023 12:07:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235107AbjA0RHO (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 27 Jan 2023 12:07:14 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E19FF91F83
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 09:06:02 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id p185so4715207oif.2
        for <linux-rdma@vger.kernel.org>; Fri, 27 Jan 2023 09:06:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cBptvRM4083nQZLsHAq/Nirr/LJWcnRuoiIz/wntDK8=;
        b=BXiPQ5/n7p+6KpbQR3BQEf5JC30AlL+HVn2BsQxAn+8JuqBwaBDp23OKE91ueTv3iH
         12nLcAcnIYcdZ1wrmLjRoISI3B9xIptqckFhPgnqpWghsb4/OhLNpFLc3VJuZJJPVFp1
         ZXs4pKbPIrKTT1qc4ga7A+jIiHLDwJ+mkOUk1kvtsWktxvBZFflwsci6gQpudj07Oun7
         8gZxIMDUiPSQWIPrgtPT93TJ1OZDc+/uVj383BFaHqJseGZ4ja/G4dTNlxMzh/R42nXE
         xVtuW87YfschHtJUkcXk7adkEfnJ4C4NPtmHRFCY4gs30ZZsJxZMPKUqvypTh2cMYlmM
         n8Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cBptvRM4083nQZLsHAq/Nirr/LJWcnRuoiIz/wntDK8=;
        b=atmnQKOp+2CPpfCPBCIaF51Lpz+j6jaW7KsNCFHA27yhUeIjkhzVTiesP5GiFVxa8y
         j13LgSbkypLax9qpiC75UIJi2aCz/6nG2Pr7D92A8juQJc7L1JFQxRaQQSihA8HprP9H
         LIqCGnaVkN7hdCVrK1VX4jBphZ3vtteojapoZkB5vPDL2SLOfUSBOc46nYOIv8wAuhYD
         gV6SN2CmLNMQm6CPi6eytYYGC7xm72v+XKK+twjkQ5ZEYavL7wCAL1344++shrfT5DuO
         nxBqFa9q2r+Of4in+Xhxm7Iq2x6UCacFQxuD875LtTteGB1FIg61kjgYRjEZQuPBETcg
         j+Kg==
X-Gm-Message-State: AO0yUKWQazG4aX//0oksZReE8xWJxqNo2yrePsiEZjjKKJxiw2Y/cCw0
        yz2ki1YFO9AQRKlCMV4qywM=
X-Google-Smtp-Source: AK7set9oqIVI1MtyuybY8SPK4tA6mYyLIXaBbv/sDsswnbP487hucIAintt4lbSevg18w7frliuZow==
X-Received: by 2002:a05:6808:d1:b0:35e:7595:30df with SMTP id t17-20020a05680800d100b0035e759530dfmr3032165oic.9.1674839158298;
        Fri, 27 Jan 2023 09:05:58 -0800 (PST)
Received: from [192.168.0.27] (097-099-248-255.res.spectrum.com. [97.99.248.255])
        by smtp.gmail.com with ESMTPSA id ex16-20020a056808299000b0036eafb8eee9sm1780601oib.22.2023.01.27.09.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 09:05:57 -0800 (PST)
Message-ID: <f69fc493-5046-c0f7-c5e7-5aeea98611ff@gmail.com>
Date:   Fri, 27 Jan 2023 11:05:56 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH for-next v7 0/6] RDMA/rxe: Replace mr page map with an
 xarray
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     zyjzyj2000@gmail.com, leonro@nvidia.com, yangx.jy@fujitsu.com,
        lizhijian@fujitsu.com, linux-rdma@vger.kernel.org
References: <20230119235936.19728-1-rpearsonhpe@gmail.com>
 <Y9P6bGbtTNYIdoWN@nvidia.com>
Content-Language: en-US
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

Thanks. I'll check these.

Bob
