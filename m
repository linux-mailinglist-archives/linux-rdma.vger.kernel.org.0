Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F33F177E1EB
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Aug 2023 14:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245309AbjHPMuE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 16 Aug 2023 08:50:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245327AbjHPMti (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 16 Aug 2023 08:49:38 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBE026B8;
        Wed, 16 Aug 2023 05:49:22 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4RQnv22WG4zFqgH;
        Wed, 16 Aug 2023 20:46:22 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 16 Aug
 2023 20:49:19 +0800
Subject: Re: [PATCH net-next v6 1/6] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Ilias Apalodimas <ilias.apalodimas@linaro.org>
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
        <linux-rdma@vger.kernel.org>
References: <20230814125643.59334-1-linyunsheng@huawei.com>
 <20230814125643.59334-2-linyunsheng@huawei.com>
 <CAC_iWjKMLoUu4bctrWtK46mpyhQ7LoKe4Nm2t8jZVMM0L9O2xA@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <06e89203-9eaf-99eb-99de-e5209819b8b3@huawei.com>
Date:   Wed, 16 Aug 2023 20:49:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAC_iWjKMLoUu4bctrWtK46mpyhQ7LoKe4Nm2t8jZVMM0L9O2xA@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/8/16 19:26, Ilias Apalodimas wrote:
> Hi Yunsheng
> 
> On Mon, 14 Aug 2023 at 15:59, Yunsheng Lin <linyunsheng@huawei.com> wrote:
>>
>> Currently page_pool_alloc_frag() is not supported in 32-bit
>> arch with 64-bit DMA because of the overlap issue between
>> pp_frag_count and dma_addr_upper in 'struct page' for those
>> arches, which seems to be quite common, see [1], which means
>> driver may need to handle it when using frag API.
> 
> That wasn't so common. IIRC it was a single TI platform that was breaking?

I am not so sure about that as grepping 'ARM_LPAE' has a long
list for that.

> 
>>
>> In order to simplify the driver's work when using frag API
>> this patch allows page_pool_alloc_frag() to call
>> page_pool_alloc_pages() to return pages for those arches.
> 
> Do we have any use cases of people needing this?  Those architectures
> should be long dead and although we have to support them in the
> kernel,  I don't personally see the advantage of adjusting the API to
> do that.  Right now we have a very clear separation between allocating
> pages or fragments.   Why should we hide a page allocation under a
> frag allocation?  A driver writer can simply allocate pages for those
> boards.  Am I the only one not seeing a clean win here?

It is also a part of removing the per page_pool PP_FLAG_PAGE_FRAG flag
in this patchset.

> 
> Thanks
> /Ilias
> 
