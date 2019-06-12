Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BEF9C4278B
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 15:30:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732427AbfFLN3y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 12 Jun 2019 09:29:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53704 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732452AbfFLN3t (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 12 Jun 2019 09:29:49 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E737A5B8912AD984DCF5;
        Wed, 12 Jun 2019 21:29:45 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Wed, 12 Jun 2019
 21:29:35 +0800
Subject: Re: [PATCH V4 for-next 1/3] RDMA/hns: Add mtr support for mixed
 multihop addressing
To:     Jason Gunthorpe <jgg@ziepe.ca>
References: <1559285867-29529-1-git-send-email-oulijun@huawei.com>
 <1559285867-29529-2-git-send-email-oulijun@huawei.com>
 <20190607164818.GA22156@ziepe.ca>
 <26040386-e155-7223-b2b7-48e74e92b521@huawei.com>
 <20190610132716.GC18468@ziepe.ca>
 <1e1f3980-6c31-c562-7f23-7734bf739ef4@huawei.com>
 <20190611055604.GH6369@mtr-leonro.mtl.com>
 <3487721f-2f1b-c3e4-473b-5ed506c5682c@huawei.com>
 <20190612115226.GC3876@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>, wangxi <wangxi11@huawei.com>,
        <linux-rdma@vger.kernel.org>, <dledford@redhat.com>,
        <linuxarm@huawei.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <df493f60-92b0-f5bc-0f85-91510e808d48@huawei.com>
Date:   Wed, 12 Jun 2019 14:29:31 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <20190612115226.GC3876@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

>>> Combine v1 and v2 into one driver (.ko) and change initialization to
>>> call v1 or v2 accordingly. The rest is handled by ib_device_ops
>>> structure.
>>>
>>
>> Is there a rule which says that a driver cannot export symbols? Module
>> stacking is useful for more complex drivers, in that a hw-specific
>> implementation may plug into common driver. This helps code reuse.
>

Hi Jason,

> Generally we do not like to see leaf drivers be so complicated that
> they need to export symbols.A multi-module driver is generally an
> over engineered thing to do, few drivers would be so big for that to
> make any sense.
>

I wouldn't say that any driver needs to have multiple modules simply 
because it is big.

But in the case of this driver, the requirement of supporting different 
hw revisions, dependencies on different network drivers, and also the 
need to support either platform or pci device driver was the motivation.

>> In addition to this, v1 hw is a platform device driver and depends on HNS,
>> while v2 hw is for a PCI device and depends on PCI && HNS3. Attempts to
>> combine into a single ko would introduce messy dependencies and ifdefs.
>
> I suspect it would not be any different from how it is today. Do
> everything the same, just have one module not three. module_init/etc
> already take care of conditional compilation of the entire .c file via
> Makefile
>

We can try it, but I'm not sure how much the complexity of the driver 
will be reduced.

Cheers,
John

> Jason
>
> .
>


