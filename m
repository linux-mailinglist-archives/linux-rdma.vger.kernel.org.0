Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8587251F
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jul 2019 05:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbfGXDKO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 23:10:14 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725468AbfGXDKO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 23:10:14 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id CF1FEE77B2783C2E79F0;
        Wed, 24 Jul 2019 11:10:11 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Wed, 24 Jul 2019
 11:10:05 +0800
Subject: Re: [PATCH] RDMA/hns: Fix build error for hip08
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190723074339.GJ5125@mtr-leonro.mtl.com> <20190723123402.GA15357@ziepe.ca>
 <20190723133540.GM5125@mtr-leonro.mtl.com> <20190723133739.GC15357@ziepe.ca>
CC:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-rdma@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <75865ec7-443e-f65a-2221-8fbc57fedb6b@huawei.com>
Date:   Wed, 24 Jul 2019 11:10:04 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190723133739.GC15357@ziepe.ca>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2019/7/23 21:37, Jason Gunthorpe wrote:
> On Tue, Jul 23, 2019 at 04:35:40PM +0300, Leon Romanovsky wrote:
>> On Tue, Jul 23, 2019 at 09:34:02AM -0300, Jason Gunthorpe wrote:
>>> On Tue, Jul 23, 2019 at 10:43:39AM +0300, Leon Romanovsky wrote:
>>>> On Tue, Jul 23, 2019 at 10:49:08AM +0800, YueHaibing wrote:
>>>>> If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
>>>>> but INFINIBAND_HNS is y, building fails:
>>>>>
>>>>> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
>>>>> hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
>>>>> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
>>>>> hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
>>>>
>>>> It means that you have a problem with header files of your hns3.
>>>>
>>>>>
>>>>> Reported-by: Hulk Robot <hulkci@huawei.com>
>>>>> Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
>>>>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>>>>>  drivers/infiniband/hw/hns/Kconfig | 3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
>>>>> index b59da5d..4371c80 100644
>>>>> +++ b/drivers/infiniband/hw/hns/Kconfig
>>>>> @@ -23,7 +23,8 @@ config INFINIBAND_HNS_HIP06
>>>>>
>>>>>  config INFINIBAND_HNS_HIP08
>>>>>  	bool "Hisilicon Hip08 Family RoCE support"
>>>>> -	depends on INFINIBAND_HNS && PCI && HNS3
>>>>> +	depends on INFINIBAND_HNS && (INFINIBAND_HNS = HNS3)
>>>>
>>>> This is wrong.
>>>
>>> It is tricky. It is asserting that the IB side is built as a module if
>>> the ethernet side is a module..
>>>
>>> It is kind of a weird pattern as the module config is INFINIBAND_HNS
>>> and these others are just bool opens what to include, but I think it
>>> is OK..
>>
>> select ???
> 
> select doesn't influence module or not any different from depeends

Ok, it seems select is a better solution, it allows HNS3 is y while INFINIBAND_HNS is m,

Will send v2, Thanks!

> 
> Jason
> 
> .
> 

