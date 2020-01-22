Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8605C144E01
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 09:55:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgAVIzG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 03:55:06 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:36316 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725862AbgAVIzG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Jan 2020 03:55:06 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 4EFCA7AC0B5C7E2DF5A6;
        Wed, 22 Jan 2020 16:55:04 +0800 (CST)
Received: from [127.0.0.1] (10.40.168.149) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 16:54:56 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
 <20200115205611.GG25201@ziepe.ca>
 <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
 <20200116195118.GG10759@ziepe.ca>
From:   Weihang Li <liweihang@huawei.com>
Message-ID: <cebc88dc-09fe-a1dd-a3da-a3de55deb732@huawei.com>
Date:   Wed, 22 Jan 2020 16:54:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20200116195118.GG10759@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.168.149]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/17 3:51, Jason Gunthorpe wrote:
>>> What happens to your userspace if it runs on an old kernel and tries
>>> to use extended atomic?
>>>
>>> Jason
>>>
>> Hi Jason,
>>
>> If the hns userspace runs with old kernel, the hardware will report a asynchronous
>> event for the extended atomic operation and modify the qp to error state because
>> the enable bit in this qp's context hasn't been set.
>>
>> The driver will print like this:
>>
>> [ 1252.240921] hns3 0000:7d:00.0: Invalid request local work queue 0x9 error.
>> [ 1252.247772] hns3 0000:7d:00.0: no hr_qp can be found!
> Ideally the provider will not set
> IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP and related without kernel
> support..
> 
> I've applied this patch, but I feel like you may need a followup to
> fix the capability reporting?
> 
> Jason

Hi Jason,

Thank for your suggestions.

But I'm confuse about the relationship between "PCI ATOMIC" in this macro
and atomic operations in RDMA.

I found the related series on patchwork:
https://patchwork.kernel.org/cover/10782873/

And I found the description about atomic operations in PCIe specification
v4.0:

"An Atomic Operation (AtomicOp) is a single PCI Express transaction that
targets a location in Memory Space, reads the location’s value, potentially
writes a new value back to the location, and returns the original value. This
"read-modify-write" sequence to the location is performed atomically."

It seems that the atomic for PCIe and RDMA is different concepts, and the macro
IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP is for PCIe atomic.

Could you please give me more suggestions about them?

Thanks
Weihang

