Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914A378076C
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Aug 2023 10:47:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242706AbjHRIqo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 18 Aug 2023 04:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358777AbjHRIqV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 18 Aug 2023 04:46:21 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D36323AAC;
        Fri, 18 Aug 2023 01:46:06 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RRwNb0KLbztSBV;
        Fri, 18 Aug 2023 16:42:23 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 18 Aug
 2023 16:46:01 +0800
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
 <06e89203-9eaf-99eb-99de-e5209819b8b3@huawei.com>
 <CAC_iWjJ4Pi7Pj9Rm13y4aXBB3RsP9pTsfRf_A-OraXKwaO_xGA@mail.gmail.com>
 <b71d5f5f-0ea1-3a35-8c90-53ef4ae27e79@huawei.com>
 <CAC_iWjJbrwSTT9OT3VjzXkCTdcwShWWaaPJUVC0aG2hR5sbkWg@mail.gmail.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <b8efc2ce-8856-2c9b-2a8c-edf2a819ebe5@huawei.com>
Date:   Fri, 18 Aug 2023 16:46:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <CAC_iWjJbrwSTT9OT3VjzXkCTdcwShWWaaPJUVC0aG2hR5sbkWg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/8/17 19:43, Ilias Apalodimas wrote:
>>>>>>
>>>>>> In order to simplify the driver's work when using frag API
>>>>>> this patch allows page_pool_alloc_frag() to call
>>>>>> page_pool_alloc_pages() to return pages for those arches.
>>>>>
>>>>> Do we have any use cases of people needing this?  Those architectures
>>>>> should be long dead and although we have to support them in the
>>>>> kernel,  I don't personally see the advantage of adjusting the API to
>>>>> do that.  Right now we have a very clear separation between allocating
>>>>> pages or fragments.   Why should we hide a page allocation under a
>>>>> frag allocation?  A driver writer can simply allocate pages for those
>>>>> boards.  Am I the only one not seeing a clean win here?
>>>>
>>>> It is also a part of removing the per page_pool PP_FLAG_PAGE_FRAG flag
>>>> in this patchset.
>>>
>>> Yes, that happens *because* of this patchset.  I am not against the
>>> change.  In fact, I'll have a closer look tomorrow.  I am just trying
>>> to figure out if we really need it.  When the recycling patches were
>>> introduced into page pool we had a very specific reason.  Due to the
>>> XDP verifier we *had* to allocate a packet per page.  That was
>>
>> Did you mean a xdp frame containing a frag page can not be passed to the
>> xdp core?
>> What is exact reason why the XDP verifier need a packet per page?
>> Is there a code block that you can point me to?
> 
> It's been a while since I looked at this, but doesn't __xdp_return()
> still sync the entire page if the mem type comes from page_pool?

Yes, I checked that too.
It is supposed to sync the entire page if the mem type comes from page_pool,
as it depend on the last freed frag to do the sync_for_device operation.
