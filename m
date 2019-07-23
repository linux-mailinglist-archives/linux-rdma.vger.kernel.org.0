Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D8F67715A8
	for <lists+linux-rdma@lfdr.de>; Tue, 23 Jul 2019 12:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbfGWKGg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 23 Jul 2019 06:06:36 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:2738 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729188AbfGWKGg (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 23 Jul 2019 06:06:36 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 7895113D89DE9AEC72C9;
        Tue, 23 Jul 2019 18:06:33 +0800 (CST)
Received: from [127.0.0.1] (10.133.213.239) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Tue, 23 Jul 2019
 18:06:24 +0800
Subject: Re: [PATCH] RDMA/hns: Fix build error for hip08
To:     Leon Romanovsky <leon@kernel.org>
References: <20190723024908.11876-1-yuehaibing@huawei.com>
 <20190723074339.GJ5125@mtr-leonro.mtl.com>
CC:     <oulijun@huawei.com>, <xavier.huwei@huawei.com>,
        <dledford@redhat.com>, <jgg@ziepe.ca>,
        <linux-kernel@vger.kernel.org>, <linux-rdma@vger.kernel.org>
From:   Yuehaibing <yuehaibing@huawei.com>
Message-ID: <dd405aec-17ca-4ac4-9620-f28f7758022c@huawei.com>
Date:   Tue, 23 Jul 2019 18:06:22 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20190723074339.GJ5125@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.133.213.239]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


On 2019/7/23 15:43, Leon Romanovsky wrote:
> On Tue, Jul 23, 2019 at 10:49:08AM +0800, YueHaibing wrote:
>> If INFINIBAND_HNS_HIP08 is selected and HNS3 is m,
>> but INFINIBAND_HNS is y, building fails:
>>
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_exit':
>> hns_roce_hw_v2.c:(.exit.text+0xd): undefined reference to `hnae3_unregister_client'
>> drivers/infiniband/hw/hns/hns_roce_hw_v2.o: In function `hns_roce_hw_v2_init':
>> hns_roce_hw_v2.c:(.init.text+0xd): undefined reference to `hnae3_register_client'
> 
> It means that you have a problem with header files of your hns3.

hnae3_unregister_client is a EXPORT_SYMBOL. If INFINIBAND_HNS is y,
hns-roce-hw-v2 will be built-in, but as HNS3 is set to m, linking will failed.

I can't see how to fix this in header files of hns3, or am I missing something?

> 
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Fixes: dd74282df573 ("RDMA/hns: Initialize the PCI device for hip08 RoCE")
>> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
>> ---
>>  drivers/infiniband/hw/hns/Kconfig | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/Kconfig b/drivers/infiniband/hw/hns/Kconfig
>> index b59da5d..4371c80 100644
>> --- a/drivers/infiniband/hw/hns/Kconfig
>> +++ b/drivers/infiniband/hw/hns/Kconfig
>> @@ -23,7 +23,8 @@ config INFINIBAND_HNS_HIP06
>>
>>  config INFINIBAND_HNS_HIP08
>>  	bool "Hisilicon Hip08 Family RoCE support"
>> -	depends on INFINIBAND_HNS && PCI && HNS3
>> +	depends on INFINIBAND_HNS && (INFINIBAND_HNS = HNS3)
> 
> This is wrong.
> 
>> +	depends on PCI
>>  	---help---
>>  	  RoCE driver support for Hisilicon RoCE engine in Hisilicon Hip08 SoC.
>>  	  The RoCE engine is a PCI device.
>> --
>> 2.7.4
>>
>>
> 
> .
> 

