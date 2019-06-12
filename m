Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A35DB41FB9
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 10:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731500AbfFLIwR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 04:52:17 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:18139 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730954AbfFLIwQ (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 04:52:16 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 0DD35A4BFB29D6A26A55;
        Wed, 12 Jun 2019 16:52:15 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 16:52:04 +0800
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
To:     Leon Romanovsky <leon@kernel.org>, wangxi <wangxi11@huawei.com>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
 <20190611055604.GH6369@mtr-leonro.mtl.com>
CC:     <linux-rdma@vger.kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>,
        <dledford@redhat.com>, <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
Date:   Wed, 12 Jun 2019 09:51:59 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190611055604.GH6369@mtr-leonro.mtl.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 11/06/2019 06:56, Leon Romanovsky wrote:
> On Tue, Jun 11, 2019 at 10:37:48AM +0800, wangxi wrote:
>>
>>
>> 在 2019/6/10 21:27, Jason Gunthorpe 写道:
>>> On Sat, Jun 08, 2019 at 10:24:15AM +0800, wangxi wrote:
>>>
>>>>> Why is there an EXPROT_SYMBOL in a IB driver? I see many in
>>>>> hns. Please send a patch to remove all of them and respin this.
>>>>>
>>>> There are 2 modules in our ib driver, one is hns_roce.ko, another
>>>> is hns_roce_hw_v2.ko. all extern symbols are named like hns_roce_xxx,
>>>> this function defined in hns_roce.ko, and invoked in
>>>> hns_roce_hw_v2.ko.
>>>
>>> seems unnecessarily complicated
>>>
>>> Jason
>>> .
>>>
>> Hi,Jason,
>>
>> The hns ib driver was originally designed for the hip06. When designing the
>> driver for the new hardware hip08, in order to maximize the reuse of the
>> existing hip06 code, the common part of the code is separated into the
>> hns_roce.ko, and the hardware difference code is defined into hns_roce_hw_v1.ko
>> for hip06 and hns_roce_hw_v2.ko for hip08.
>>
>> The mtr code is designed as a public part in this patchset, so it is defined
>> in hns_roce.ko. It can be used for hi16xx series hardware with mixed mutihop
>> addressing feature. Currently, hip08 supports this feature, so it is be called
>> in hns_roce_hw_v2.ko.
>
> Combine v1 and v2 into one driver (.ko) and change initialization to
> call v1 or v2 accordingly. The rest is handled by ib_device_ops
> structure.
>

Is there a rule which says that a driver cannot export symbols? Module 
stacking is useful for more complex drivers, in that a hw-specific 
implementation may plug into common driver. This helps code reuse.

In addition to this, v1 hw is a platform device driver and depends on 
HNS, while v2 hw is for a PCI device and depends on PCI && HNS3. 
Attempts to combine into a single ko would introduce messy dependencies 
and ifdefs.

Thanks,
John


> Thanks
>
>>
>> Xi Wang
>>
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
>


