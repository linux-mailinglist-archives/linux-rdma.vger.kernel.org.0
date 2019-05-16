Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AF0520886
	for <lists+linux-rdma@lfdr.de>; Thu, 16 May 2019 15:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbfEPNpF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 May 2019 09:45:05 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49546 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726692AbfEPNpF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 16 May 2019 09:45:05 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 6C05FF5289AA3F1FAAB3;
        Thu, 16 May 2019 21:45:03 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Thu, 16 May 2019
 21:44:56 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support function clear when
 removing module
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Leon Romanovsky <leon@kernel.org>, oulijun <oulijun@huawei.com>,
        <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
References: <20190422122209.GD27901@mtr-leonro.mtl.com>
 <add43d02-b3d5-35d9-a74d-8254c1fb472c@huawei.com>
 <20190423152339.GE27901@mtr-leonro.mtl.com>
 <90a91e1f-91fc-bc4e-067c-7bc788c62ab6@huawei.com>
 <20190426143656.GA2278@ziepe.ca> <20190426210520.GA6705@mtr-leonro.mtl.com>
 <99195660-be8d-555f-01fc-efd9e680fdf3@huawei.com>
 <20190502130304.GB18518@ziepe.ca>
 <a23d02b4-5a1f-8b25-2b5c-f14e16acdcc2@huawei.com>
 <bd517597-4feb-c748-b43b-e0f45ced959d@huawei.com>
 <20190515114927.GB30791@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <874cdd5d-93df-f323-1615-db24011e74ad@huawei.com>
Date:   Thu, 16 May 2019 21:44:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190515114927.GB30791@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/5/15 19:49, Jason Gunthorpe wrote:
> On Wed, May 15, 2019 at 05:38:02PM +0800, Liuyixian (Eason) wrote:
>>
>>
>> On 2019/5/9 18:50, Liuyixian (Eason) wrote:
>>>
>>>
>>> On 2019/5/2 21:03, Jason Gunthorpe wrote:
>>>> On Tue, Apr 30, 2019 at 04:27:41PM +0800, Liuyixian (Eason) wrote:
>>>>>
>>>>>
>>>>> On 2019/4/27 5:05, Leon Romanovsky wrote:
>>>>>> On Fri, Apr 26, 2019 at 11:36:56AM -0300, Jason Gunthorpe wrote:
>>>>>>> On Fri, Apr 26, 2019 at 06:12:11PM +0800, Liuyixian (Eason) wrote:
>>>>>>>
>>>>>>>>     However, I have talked with our chip team about function clear
>>>>>>>>     functionality. We think it is necessary to inform the chip to
>>>>>>>>     perform the outstanding task and some cleanup work and restore
>>>>>>>>     hardware resources in time when rmmod ko. Otherwise, it is
>>>>>>>>     dangerous to reuse the hardware as it can not guarantee those
>>>>>>>>     work can be done well without the notification from our driver.
>>>>>>>
>>>>>>> If it is dangerous to reuse the hardware then you have to do this
>>>>>>> cleanup on device startup, not on device removal.
>>>>>>
>>>>>> Right, I can think about gazillion ways to brick such HW.
>>>>>> The simplest way will be to call SysRq during RDMA traffic
>>>>>> and no cleanup function will be called in such case.
>>>>>>
>>>>>> Thanks
>>>>>
>>>>> Hi Jason and Leon,
>>>>>
>>>>> 	As hip08 is a fake pcie device, we could not disassociate and stop the hardware access
>>>>> 	through the chain break mechanism as a real pcie device. Alternatively, function clear
>>>>> 	is used as a notification to the hardware to stop accessing and ensure to not read or
>>>>> 	write DDR later. That is, the role of function clear to hip08 is similar as the chain
>>>>> 	break to pcie device.
>>>>
>>>> What? This hardware is broken and doesn't respond to the bus master
>>>> enable bit in the PCI config space??
>>>>
>>> Hi Jason,
>>>
>>> Sorry to reply to you late.
>>>
>>> Yes, the bus master enable bit should be set by a pcie device when startup and removal.
>>> The hns (nic) module use it as well. However, we couldn't use/operate this bit in hip08
>>> as it shares the PF(physical function) with nic. Therefore, we need function clear to
>>> notify the hardware to do the cleanup thing and cache write back.
>>>
>>> Thanks.
>>>
>>
>> Hi Jason and Leon,
>>
>> Do you have further more suggestions?
> 
> The approach seems completely wrong to me - no other driver is doing
> something so sketchy. 
> 
> You need to explain why hns is so special
> 
> Jason

Thanks, Jason. I will revisit the solution and feedback soon.

