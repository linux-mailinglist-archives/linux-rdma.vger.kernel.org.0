Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBA394279F5
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Oct 2021 14:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbhJIMFC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Oct 2021 08:05:02 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:13887 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhJIMFB (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Oct 2021 08:05:01 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HRNqX01vPz8ypN;
        Sat,  9 Oct 2021 19:58:16 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 20:03:02 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 9 Oct 2021
 20:03:02 +0800
Subject: Re: [PATCH] RDMA/hns: Use dma_alloc_coherent() instead of
 kmalloc/dma_map_single()
To:     Cai Huoqing <caihuoqing@baidu.com>
References: <20210926061116.282-1-caihuoqing@baidu.com>
 <20210927115913.GA3544071@ziepe.ca> <20211004195224.GA2576309@nvidia.com>
 <07922740-2d3d-50dc-7239-421e39c42142@huawei.com>
 <20211009104246.GA1205@LAPTOP-UKSR4ENP.internal.baidu.com>
CC:     Jason Gunthorpe <jgg@nvidia.com>, Lijun Ou <oulijun@huawei.com>,
        "Weihang Li" <liweihang@huawei.com>,
        Doug Ledford <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linux-kernel@vger.kernel.org>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <28e67298-7ed5-399c-9052-d8c172e65062@huawei.com>
Date:   Sat, 9 Oct 2021 20:03:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211009104246.GA1205@LAPTOP-UKSR4ENP.internal.baidu.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/10/9 18:42, Cai Huoqing wrote:
> On 09 10月 21 17:50:50, Wenpeng Liang wrote:
>>
>>
>> On 2021/10/5 3:52, Jason Gunthorpe wrote:
>>> On Mon, Sep 27, 2021 at 08:59:13AM -0300, Jason Gunthorpe wrote:
>>>> On Sun, Sep 26, 2021 at 02:11:15PM +0800, Cai Huoqing wrote:
>>>>> Replacing kmalloc/kfree/dma_map_single/dma_unmap_single()
>>>>> with dma_alloc_coherent/dma_free_coherent() helps to reduce
>>>>> code size, and simplify the code, and coherent DMA will not
>>>>> clear the cache every time.
>>>>>
>>>>> Signed-off-by: Cai Huoqing <caihuoqing@baidu.com>
>>>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 20 +++++---------------
>>>>>  1 file changed, 5 insertions(+), 15 deletions(-)
>>>>
>>>> Given I don't see any dma_sync_single calls for this mapping, isn't
>>>> this a correctness fix too?
>>>
>>> HNS folks?
>>>
>>> Jason
>>> .
>>>
>>
>> Our SoC can keep cache coherent, so there is no exception even if
>> dma_sync_single* is not called, but the driver should not make
>> assumptions about SoC.
>>
>> So using dma_alloc_coherent() instead of kmalloc/dma_map_single()
>> can simplify the code and achieve the same purpose.
>>
>> Wenpeng Liang
> 
> 
> Hi Liang
> 
> Thanks for your feedback.
> 
> If you think my patch is correct, you can give a Reviewed-by: to it.
> You can also give a Tested-by: to it, if the test on hardware was made.
> 
> Thanks
> Cai
> .
> 

Hi, Cai

After testing, it seems ok to me.

Reviewed-by: Wenpeng Liang <liangwenpeng@huawei.com>
Tested-by: Wenpeng Liang <liangwenpeng@huawei.com>

Thanks,
Wenpeng
