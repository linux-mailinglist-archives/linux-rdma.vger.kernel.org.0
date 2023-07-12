Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55550750859
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jul 2023 14:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232125AbjGLMeT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jul 2023 08:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGLMeS (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 12 Jul 2023 08:34:18 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D953B0;
        Wed, 12 Jul 2023 05:34:16 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R1HGV6k34z1JCVN;
        Wed, 12 Jul 2023 20:33:38 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 12 Jul
 2023 20:34:13 +0800
Subject: Re: [PATCH v5 RFC 1/6] page_pool: frag API support for 32-bit arch
 with 64-bit DMA
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        Jakub Kicinski <kuba@kernel.org>
CC:     Yunsheng Lin <yunshenglin0825@gmail.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Liang Chen <liangchen.linux@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
References: <20230629120226.14854-1-linyunsheng@huawei.com>
 <20230629120226.14854-2-linyunsheng@huawei.com>
 <20230707170157.12727e44@kernel.org>
 <3d973088-4881-0863-0207-36d61b4505ec@gmail.com>
 <20230710113841.482cbeac@kernel.org>
 <8639b838-8284-05a2-dbc3-7e4cb45f163a@intel.com>
 <20230711093705.45454e41@kernel.org>
 <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <46ad09d9-6596-cf07-5cab-d6ceb1e36f3c@huawei.com>
Date:   Wed, 12 Jul 2023 20:34:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <1bec23ff-d38b-3fdf-1bb3-89658c1d465a@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/7/12 0:59, Alexander Lobakin wrote:
> From: Jakub Kicinski <kuba@kernel.org>
> Date: Tue, 11 Jul 2023 09:37:05 -0700
> 
>> On Tue, 11 Jul 2023 12:59:00 +0200 Alexander Lobakin wrote:
>>> I'm fine with that, although ain't really able to work on this myself
>>> now :s (BTW I almost finished Netlink bigints, just some more libie/IAVF
>>> crap).
>>
>> FWIW I was thinking about the bigints recently, and from ynl
>> perspective I think we may want two flavors :( One which is at
>> most the length of platform's long long, and another which is
> 
> (not sure we shouldn't split a separate thread off this one at this
>  point :D)
> 
> `long long` or `long`? `long long` is always 64-bit unless I'm missing
> something. On my 32-bit MIPS they were :D
> If `long long`, what's the point then if we have %NLA_U64 and would
> still have to add dumb padding attrs? :D I thought the idea was to carry
> 64+ bits encapsulated in 32-bit primitives.
> 
>> always a bigint. The latter will be more work for user space
>> to handle, so given 99% of use cases don't need more than 64b
>> we should make its life easier?
>>
>>> It just needs to be carefully designed, because if we want move ALL the
>>> inlines to a new header, we may end up including 2 PP's headers in each
>>> file. That's why I'd prefer "core/driver" separation. Let's say skbuff.c
>>> doesn't need page_pool_create(), page_pool_alloc(), and so on, while
>>> drivers don't need some of its internal functions.
>>> OTOH after my patch it's included in only around 20-30 files on
>>> allmodconfig. That is literally nothing comparing to e.g. kernel.h
>>> (w/includes) :D
>>
>> Well, once you have to rebuilding 100+ files it gets pretty hard to
>> clean things up ;) 
>>
>> I think I described the preferred setup, previously:
>>
>> $path/page_pool.h:
>>
>> #include <$path/page_pool/types.h>
>> #include <$path/page_pool/helpers.h>
>>
>> $path/page_pool/types.h - has types
>> $path/page_pool/helpers.h - has all the inlines
>>
>> C sources can include $path/page_pool.h, headers should generally only
>> include $path/page_pool/types.h.

Does spliting the page_pool.h as above fix the problem about including
a ton of static inline functions from "linux/dma-mapping.h" in skbuff.c?

As the $path/page_pool/helpers.h which uses dma_get_cache_alignment()
must include the "linux/dma-mapping.h" which has dma_get_cache_alignment()
defining as a static inline function.
and if skbuff.c include $path/page_pool.h or $path/page_pool/helpers.h,
doesn't we still have the same problem? Or do I misunderstand something
here?

> 
> Aaah okay, I did read it backwards ._. Moreover, generic stack barely
> uses PP's inlines, it needs externals mostly.
> 
> Thanks,
> Olek
> 
> .
> 
