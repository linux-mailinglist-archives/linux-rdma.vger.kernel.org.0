Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E067D72FE28
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Jun 2023 14:15:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbjFNMPy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Jun 2023 08:15:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238034AbjFNMPx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 14 Jun 2023 08:15:53 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398E81BF9;
        Wed, 14 Jun 2023 05:15:51 -0700 (PDT)
Received: from dggpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Qh4BF5q4szTl45;
        Wed, 14 Jun 2023 20:15:17 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemm500005.china.huawei.com
 (7.185.36.74) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 14 Jun
 2023 20:15:48 +0800
Subject: Re: [PATCH net-next v4 1/5] page_pool: frag API support for 32-bit
 arch with 64-bit DMA
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
CC:     <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Leon Romanovsky <leon@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        <linux-rdma@vger.kernel.org>
References: <20230612130256.4572-1-linyunsheng@huawei.com>
 <20230612130256.4572-2-linyunsheng@huawei.com>
 <483d7a70-3377-a241-4554-212662ee3930@intel.com>
 <6db097ba-c3fe-6e45-3c39-c21b4d9e16ef@huawei.com>
 <16cc3a9d-bd05-5a9f-cb2e-7c6790ebd9fe@intel.com>
From:   Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <2eb57144-1e51-239b-07b2-b6b3737e7497@huawei.com>
Date:   Wed, 14 Jun 2023 20:15:48 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
MIME-Version: 1.0
In-Reply-To: <16cc3a9d-bd05-5a9f-cb2e-7c6790ebd9fe@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.30.204]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2023/6/14 18:52, Alexander Lobakin wrote:
> From: Yunsheng Lin <linyunsheng@huawei.com>
> Date: Wed, 14 Jun 2023 11:36:28 +0800
> 
>> On 2023/6/13 21:30, Alexander Lobakin wrote:
>>> From: Yunsheng Lin <linyunsheng@huawei.com>
>>> Date: Mon, 12 Jun 2023 21:02:52 +0800
> 
> [...]
> 
>>> I addressed this in my series, which I hope will land soon after yours
>>> (sending new revision in 24-48 hours), so you can leave it as it is. Or
>>> otherwise you can pick my solution (or come up with your own :D).
>>
>> Do you mean by removing "#include <linux/dma-direction.h>" as dma-mapping.h
>> has included dma-direction.h?
> 
> By "I addressed" I meant that I dropped including page_pool.h from
> skbuff.h, as I also had to include dma-mapping.h to page_pool.h and this
> implied that half of the kernel started including dma-mapping.h as well
> for no profit.

I see, thank for the explanation.
I perfer that you can continue with that effort if that is ok.
