Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7379E14989A
	for <lists+linux-rdma@lfdr.de>; Sun, 26 Jan 2020 04:38:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbgAZDis (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 25 Jan 2020 22:38:48 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728842AbgAZDis (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 25 Jan 2020 22:38:48 -0500
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5F14D486B065258BC9DD;
        Sun, 26 Jan 2020 11:38:45 +0800 (CST)
Received: from [127.0.0.1] (10.45.216.243) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Sun, 26 Jan 2020
 11:38:35 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
To:     Tom Talpey <tom@talpey.com>, Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
 <20200115205611.GG25201@ziepe.ca>
 <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
 <20200116195118.GG10759@ziepe.ca>
 <cebc88dc-09fe-a1dd-a3da-a3de55deb732@huawei.com>
 <49d6c8e9-ecf8-b00e-06c2-cc873703361b@talpey.com>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <1805edde-ae5a-1dfd-3f52-e3a690e73e16@huawei.com>
Date:   Sun, 26 Jan 2020 11:38:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <49d6c8e9-ecf8-b00e-06c2-cc873703361b@talpey.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.45.216.243]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/22 22:08, Tom Talpey wrote:
> On 1/22/2020 3:54 AM, Weihang Li wrote:
>>
>>
>> On 2020/1/17 3:51, Jason Gunthorpe wrote:
>>>>> What happens to your userspace if it runs on an old kernel and tries
>>>>> to use extended atomic?
>>>>>
>>>>> Jason
>>>>>
>>>> Hi Jason,
>>>>
>>>> If the hns userspace runs with old kernel, the hardware will report a asynchronous
>>>> event for the extended atomic operation and modify the qp to error state because
>>>> the enable bit in this qp's context hasn't been set.
>>>>
>>>> The driver will print like this:
>>>>
>>>> [ 1252.240921] hns3 0000:7d:00.0: Invalid request local work queue 0x9 error.
>>>> [ 1252.247772] hns3 0000:7d:00.0: no hr_qp can be found!
>>> Ideally the provider will not set
>>> IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP and related without kernel
>>> support..
>>>
>>> I've applied this patch, but I feel like you may need a followup to
>>> fix the capability reporting?
>>>
>>> Jason
>>
>> Hi Jason,
>>
>> Thank for your suggestions.
>>
>> But I'm confuse about the relationship between "PCI ATOMIC" in this macro
>> and atomic operations in RDMA.
> 
> PCI Atomics are optonal and are a much more recent facility.
> 
> RDMA Atomics do not require PCI Atomics, because they have
> different semantics with respect to memory atomicity. Read
> carefully and you'll see that they operate atomically only
> within the adapter, and are not atomic all the way to the
> underlying memory. It's a long and somewhat historical story.
> 
> Now that PCIe Atomics are becoming more widely supported by
> processor complexes, there is the possibility these may be
> more tightly embraced by RDMA implementations. There is
> discussion in IBTA and IETF around this currently, in fact,
> for the new RDMA Atomic Write operation.
> 
> Be aware that PCI Atomics are relatively expensive operations.
> The existing ones perform a read-modify-write cycle on both
> PCI and memory busses. This overhead is not to be taken lightly.
> 
> Tom.
> 

Hi Tom,

Thanks for your patience and detailed explanation :)
I know more about their relationship now.

Weihang


>> I found the related series on patchwork:
>> https://patchwork.kernel.org/cover/10782873/
>>
>> And I found the description about atomic operations in PCIe specification
>> v4.0:
>>
>> "An Atomic Operation (AtomicOp) is a single PCI Express transaction that
>> targets a location in Memory Space, reads the location’s value, potentially
>> writes a new value back to the location, and returns the original value. This
>> "read-modify-write" sequence to the location is performed atomically."
>>
>> It seems that the atomic for PCIe and RDMA is different concepts, and the macro
>> IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP is for PCIe atomic.
>>
>> Could you please give me more suggestions about them?
>>
>> Thanks
>> Weihang
>>
>>
>>
> 
> .

