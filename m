Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236DC74C42C
	for <lists+linux-rdma@lfdr.de>; Sun,  9 Jul 2023 14:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjGIMkA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 9 Jul 2023 08:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjGIMj7 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 9 Jul 2023 08:39:59 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A8D130;
        Sun,  9 Jul 2023 05:39:59 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d9443c01a7336-1b8b2b60731so15055515ad.2;
        Sun, 09 Jul 2023 05:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688906398; x=1691498398;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AunKTef2eVoQgdM8wyqDnspSjgv/YIQnYn6ve6LmJII=;
        b=DlennG7Y4GQFlVxQjTnTSmmMBJD2potTQ8oqXI3hJyqMdd12UB8A4NhzXtZ83D7Q2j
         DUa0vbOdQMFGtlu2JzcVhrk+IIUE7x5SBKqkPgGSThLlfPXGKe++HivBdKd/8m5+8DUt
         rO2rKcwlXEGCLRlT3XbRvr5jFhmVk2s8xCpJEijniNe47NOa4cSCSfhKP3a4ZdpdmTYL
         tRUBTYXp+wy1L1U5DMbpNc3fPtcXlLI1ceI6qPoFLFiwj59Cxws3/Z10f6CuTtQDy5Cl
         B+qQ9k76XZuFIOwcviNiKGwcKjeBbp+vTQPV1s46ixATK3SLwFjTedxrqLYhEMcQ1SB4
         Kglg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688906398; x=1691498398;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AunKTef2eVoQgdM8wyqDnspSjgv/YIQnYn6ve6LmJII=;
        b=ZAi4l2gYhNDvqBMmV8rHDb5BZ0hSBPi/CefhzrGKm7WEwBeqqjr1DeqsSPkg9R1r5R
         CqogLvd4zcjsLIlrrfZ7/JxJNUtoYG8O94HZmJ9OMlwU9zfkYZBqVWK4Y/gX6WHWBIaC
         isDdN7ruEfokqo35ixcHRaWpoYxpP9CgfNon3WZDfiUQDyjFCNIVa22/No3VG+ExhBfH
         tONuu0a5/mbOwTWPrn+MG0c2ofwUAKIghQ2q+OnHylpjL4LdcYZMCKSjAvWszudMwozA
         VkMk0WWwTLuVUx2HAdBJF//CTmSDO1qMhm4wO1fGzZD8zXepjH7YyP3e53ivasgSDeX5
         J4iA==
X-Gm-Message-State: ABy/qLasTQ7xtkr+ZRbUcqgVLsem4fojAsBlOHg8nRMQzf1db9I9uW1p
        F3wIPwjDduKPhyXMH6SQ+cOL3vLA8scTJiGr
X-Google-Smtp-Source: APBJJlEVymbZm7XdprX4gfU/SLXEpyNTedwLKgASfuNwnbJeSLXzAJ7NQOqdPHGELnD+00BxMx2s7Q==
X-Received: by 2002:a17:902:b58c:b0:1b8:94e9:e7cb with SMTP id a12-20020a170902b58c00b001b894e9e7cbmr7359068pls.21.1688906398236;
        Sun, 09 Jul 2023 05:39:58 -0700 (PDT)
Received: from ?IPv6:2409:8a55:301b:e120:1523:3ecb:e154:8f22? ([2409:8a55:301b:e120:1523:3ecb:e154:8f22])
        by smtp.gmail.com with ESMTPSA id d17-20020a170903231100b001b3d0aff88fsm6249708plh.109.2023.07.09.05.39.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Jul 2023 05:39:57 -0700 (PDT)
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
To:     Jakub Kicinski <kuba@kernel.org>,
        Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        linux-rdma@vger.kernel.org
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707165921.565b1228@kernel.org>
From:   Yunsheng Lin <yunshenglin0825@gmail.com>
Message-ID: <81a8b412-f2b5-fac9-caa4-149d5bf71510@gmail.com>
Date:   Sun, 9 Jul 2023 20:39:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20230707165921.565b1228@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/7/8 7:59, Jakub Kicinski wrote:
> On Thu, 29 Jun 2023 20:02:21 +0800 Yunsheng Lin wrote:
>> +		/* Return error here to avoid mlx5e_page_release_fragmented()
>> +		 * calling page_pool_defrag_page() to write to pp_frag_count
>> +		 * which is overlapped with dma_addr_upper in 'struct page' for
>> +		 * arch with PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true.
>> +		 */
>> +		if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT) {
>> +			err = -EINVAL;
>> +			goto err_free_by_rq_type;
>> +		}
> 
> I told you not to do this in a comment on v4.
> Keep the flag in page pool params and let the creation fail.

There seems to be naming disagreement in the previous discussion,
The simplest way seems to be reuse the
PAGE_POOL_DMA_USE_PP_FRAG_COUNT and do the checking in the driver
without introducing new macro or changing macro name.

Let's be more specific about what is your suggestion here:
Do you mean keep the PP_FLAG_PAGE_FRAG flag and keep the below
checking in page_pool_init(), right?
	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
	    pool->p.flags & PP_FLAG_PAGE_FRAG)
		return -EINVAL;

Isn't it confusing to still say page frag is not supported
for PAGE_POOL_DMA_USE_PP_FRAG_COUNT being true case when this
patch will now add support for it, at least from API POV, the
page_pool_alloc_frag() is always supported now.

Maybe remove the PP_FLAG_PAGE_FRAG and add a new macro named
PP_FLAG_PAGE_SPLIT_IN_DRIVER, and do the checking as before in
page_pool_init() like below?
	if (PAGE_POOL_DMA_USE_PP_FRAG_COUNT &&
	    pool->p.flags & PP_FLAG_PAGE_SPLIT_IN_DRIVER)
		return -EINVAL;

Or any better suggestion? 
