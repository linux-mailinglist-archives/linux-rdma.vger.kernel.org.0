Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 978F277CCAC
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Aug 2023 14:32:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234097AbjHOMb2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 15 Aug 2023 08:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236484AbjHOMbF (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 15 Aug 2023 08:31:05 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D544D1;
        Tue, 15 Aug 2023 05:31:04 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RQ9ZG3FwtzrSgW;
        Tue, 15 Aug 2023 20:29:42 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 15 Aug
 2023 20:31:02 +0800
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Simon Horman <horms@kernel.org>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-2-linyunsheng@huawei.com>
 <ZNtgfy9KPUclHnLE@vergenet.net>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b497faa8-2e57-a060-1105-24ea6bad0051@huawei.com>
Date:   Tue, 15 Aug 2023 20:31:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <ZNtgfy9KPUclHnLE@vergenet.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/8/15 19:24, Simon Horman wrote:
> On Mon, Aug 14, 2023 at 08:56:38PM +0800, Yunsheng Lin wrote:
> 
> ...
> 
>> diff --git a/net/core/page_pool.c b/net/core/page_pool.c
>> index 77cb75e63aca..d62c11aaea9a 100644
>> --- a/net/core/page_pool.c
>> +++ b/net/core/page_pool.c
> 
> ...
> 
>> @@ -737,18 +736,16 @@ static void page_pool_free_frag(struct page_pool *pool)
>>  	page_pool_return_page(pool, page);
>>  }
>>  
>> -struct page *page_pool_alloc_frag(struct page_pool *pool,
>> -				  unsigned int *offset,
>> -				  unsigned int size, gfp_t gfp)
>> +struct page *__page_pool_alloc_frag(struct page_pool *pool,
>> +				    unsigned int *offset,
>> +				    unsigned int size, gfp_t gfp)
>>  {
>>  	unsigned int max_size = PAGE_SIZE << pool->p.order;
>>  	struct page *page = pool->frag_page;
>>  
>> -	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG) ||
>> -		    size > max_size))
>> +	if (WARN_ON(!(pool->p.flags & PP_FLAG_PAGE_FRAG))
> 
> Hi Yunsheng Lin,
> 
> There is a ')' missing on the line above, which results in a build failure.

Yes, thanks for noticing.
As the above checking is removed in patch 3, so it is not noticeable in testing
when the whole patchset is applied.

> 
