Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA9729DB7
	for <lists+linux-rdma@lfdr.de>; Fri,  9 Jun 2023 17:03:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231887AbjFIPDs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 9 Jun 2023 11:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237994AbjFIPDq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 9 Jun 2023 11:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676142D48
        for <linux-rdma@vger.kernel.org>; Fri,  9 Jun 2023 08:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1686322979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kliWk5KtWXn6tjlvUWVqn/LoEmMuT+sYK46zS+DbrRU=;
        b=E0hapIaseMCdJwuWgijhtrHGHdxT3WTMJ0bWPLJno8lWtYKbxCCa5urwK1UtxufHjVmQps
        kgonkV/MB4YYjpTqiR1FIDq1STJ3BUm/L2A0NXFt7WzfNNuLFTxkIp17pmiTtYgp4CtbJX
        FmRNTmPOMkYoSp0qWf4Cuj6wJx+XwvQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-NdD3_HZhMFq7fm9SR1Tq2A-1; Fri, 09 Jun 2023 11:02:58 -0400
X-MC-Unique: NdD3_HZhMFq7fm9SR1Tq2A-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-94a34e35f57so164776466b.3
        for <linux-rdma@vger.kernel.org>; Fri, 09 Jun 2023 08:02:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686322977; x=1688914977;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:cc:user-agent:mime-version:date:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kliWk5KtWXn6tjlvUWVqn/LoEmMuT+sYK46zS+DbrRU=;
        b=kUDtQ664ndRsu5J55IVwhtHhMQ3oySu50+VyChSlmNcFsQv3vrtlt5MMXQXcjD66Al
         8BU5fHLa2C/6Qn/TdFaejUJJN+iojyUHwilya9yYA5WBVzDyvKZeZYZ9qNJUyX/aRLwE
         GQ4fpTDSzTeMn7ZcvyRfShLWqBA+nWQbRSlky9yDh0tFybzzgsdSLUkI66ANKXJKn4Yr
         UMa5+PVNfdBcB0v3dHvZenw6pPGJkE2aHdzap5LNkJyZUTn67xnNUpyXvIfn8quWMEk4
         nwvMXzRZqgygX9EHUDN0SsksYQJ3iOy/pMk8T6VTyHG7Ee2cqeP3C+flC7jiA+ervQoY
         P6eg==
X-Gm-Message-State: AC+VfDzWtk4jCy0dBTS1UBfaG+8Aw9tTPNONIW4+KLb5WXn0juMgkpv7
        lpsGPqDwRcoNW6fhDmw7Khy7HP6V2+ra6cKSSzamtbjvnvVr5VY0lplqLvFKd5loBYVu9LiEBQD
        rwlThXxOFAPSTpCk3fVNiOw==
X-Received: by 2002:a17:907:a40d:b0:94f:1c90:cb71 with SMTP id sg13-20020a170907a40d00b0094f1c90cb71mr2135530ejc.65.1686322977203;
        Fri, 09 Jun 2023 08:02:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7kIJT4Dw+mA4Q9GUBl8PP+/FekH+B7/fILEkXJGqguDJ8zV1PCspweiNi+i2gf5sACJchhag==
X-Received: by 2002:a17:907:a40d:b0:94f:1c90:cb71 with SMTP id sg13-20020a170907a40d00b0094f1c90cb71mr2135493ejc.65.1686322976901;
        Fri, 09 Jun 2023 08:02:56 -0700 (PDT)
Received: from [192.168.42.222] (194-45-78-10.static.kviknet.net. [194.45.78.10])
        by smtp.gmail.com with ESMTPSA id lf29-20020a170907175d00b009787062d21csm1396129ejc.77.2023.06.09.08.02.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Jun 2023 08:02:56 -0700 (PDT)
From:   Jesper Dangaard Brouer <jbrouer@redhat.com>
X-Google-Original-From: Jesper Dangaard Brouer <brouer@redhat.com>
Message-ID: <4f1a0b7d-973f-80f5-cc39-74f09622ccef@redhat.com>
Date:   Fri, 9 Jun 2023 17:02:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Cc:     brouer@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
Content-Language: en-US
To:     Yunsheng Lin <linyunsheng@huawei.com>, davem@davemloft.net,
        kuba@kernel.org, pabeni@redhat.com
References: <20230609131740.7496-1-linyunsheng@huawei.com>
 <20230609131740.7496-2-linyunsheng@huawei.com>
In-Reply-To: <20230609131740.7496-2-linyunsheng@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 09/06/2023 15.17, Yunsheng Lin wrote:
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index a7c526ee5024..cd4ac378cc63 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -832,6 +832,15 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
>   		/* Create a page_pool and register it with rxq */
>   		struct page_pool_params pp_params = { 0 };
>   
> +		/* Return error here to aoivd writing to page->pp_frag_count in
                                         ^^^^^
Typo

> +		 * mlx5e_page_release_fragmented() for page->pp_frag_count is not
> +		 * usable for arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
> +		 */
> +		if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
> +			err = -EINVAL;
> +			goto err_free_by_rq_type;
> +		}
> +
>   		pp_params.order     = 0;
>   		pp_params.flags     = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV | PP_FLAG_PAGE_FRAG;
>   		pp_params.pool_size = pool_size;
> diff --git a/include/net/page_pool.h b/include/net/page_pool.h
> index 126f9e294389..5c7f7501f300 100644
> --- a/include/net/page_pool.h
> +++ b/include/net/page_pool.h
> @@ -33,6 +33,7 @@
>   #include <linux/mm.h> /* Needed by ptr_ring */
>   #include <linux/ptr_ring.h>
>   #include <linux/dma-direction.h>
> +#include <linux/dma-mapping.h>
>   
>   #define PP_FLAG_DMA_MAP		BIT(0) /* Should page_pool do the DMA
>   					* map/unmap
> @@ -50,6 +51,9 @@
>   				 PP_FLAG_DMA_SYNC_DEV |\
>   				 PP_FLAG_PAGE_FRAG)
>   
> +#define PAGE_POOL_DMA_USE_PP_FRAG_COUNT	\
> +		(sizeof(dma_addr_t) > sizeof(unsigned long))
> +

I have a problem with the name PAGE_POOL_DMA_USE_PP_FRAG_COUNT
because it is confusing to read in an if-statement.

Proposals rename to:  DMA_OVERLAP_PP_FRAG_COUNT
  Or:  MM_DMA_OVERLAP_PP_FRAG_COUNT
  Or:  DMA_ADDR_OVERLAP_PP_FRAG_COUNT

Notice how I also removed the prefix PAGE_POOL_ because this is a 
MM-layer constraint and not a property of page_pool.


--Jesper

