Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9425A145790
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jan 2020 15:15:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVOP1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jan 2020 09:15:27 -0500
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net ([173.201.192.239]:46880
        "EHLO p3plsmtpa07-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727523AbgAVOP1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 22 Jan 2020 09:15:27 -0500
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Wed, 22 Jan 2020 09:15:27 EST
Received: from [192.168.0.20] ([24.218.182.144])
        by :SMTPAUTH: with ESMTPSA
        id uGfwiGzz8zYQvuGfwirZuE; Wed, 22 Jan 2020 07:08:09 -0700
Subject: Re: [PATCH for-next] RDMA/hns: Add support for extended atomic in
 userspace
To:     Weihang Li <liweihang@huawei.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc:     dledford@redhat.com, leon@kernel.org, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com
References: <1579052546-11746-1-git-send-email-liweihang@huawei.com>
 <20200115205611.GG25201@ziepe.ca>
 <9b7a3629-0564-6643-f6e7-c2f098afd010@huawei.com>
 <20200116195118.GG10759@ziepe.ca>
 <cebc88dc-09fe-a1dd-a3da-a3de55deb732@huawei.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <49d6c8e9-ecf8-b00e-06c2-cc873703361b@talpey.com>
Date:   Wed, 22 Jan 2020 09:08:08 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <cebc88dc-09fe-a1dd-a3da-a3de55deb732@huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfKYRqUT5I0bAa4x6jNv2lGzPylilLtNqsSLMYXYGT9CMKgEXPibcCTNrcz0svV9N2lTv8KT9e4Gp9xStHSP/6MBOihVswxRI/Dl1XrxwLZqk7haRaMGE
 spxi2On/T+hlAGKjJ8zSyNaeKMnRFSyrbe5TnSy1af0NtlciVQvwkozUFu/iNw9hcVPGVDJfNGS6Ykf+VUsgcpjB2PFyGqUF+LkpgXdA7zHvBc9FKs9JqUCE
 PukU7L/IvDt/vlefZ9Hvo5gQOc/OCATSMcBSpmBwVXvxOLvKdhPRm5ESdztMAwHE+1JCYAZvAYntePVqnSD+lg==
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 1/22/2020 3:54 AM, Weihang Li wrote:
> 
> 
> On 2020/1/17 3:51, Jason Gunthorpe wrote:
>>>> What happens to your userspace if it runs on an old kernel and tries
>>>> to use extended atomic?
>>>>
>>>> Jason
>>>>
>>> Hi Jason,
>>>
>>> If the hns userspace runs with old kernel, the hardware will report a asynchronous
>>> event for the extended atomic operation and modify the qp to error state because
>>> the enable bit in this qp's context hasn't been set.
>>>
>>> The driver will print like this:
>>>
>>> [ 1252.240921] hns3 0000:7d:00.0: Invalid request local work queue 0x9 error.
>>> [ 1252.247772] hns3 0000:7d:00.0: no hr_qp can be found!
>> Ideally the provider will not set
>> IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP and related without kernel
>> support..
>>
>> I've applied this patch, but I feel like you may need a followup to
>> fix the capability reporting?
>>
>> Jason
> 
> Hi Jason,
> 
> Thank for your suggestions.
> 
> But I'm confuse about the relationship between "PCI ATOMIC" in this macro
> and atomic operations in RDMA.

PCI Atomics are optonal and are a much more recent facility.

RDMA Atomics do not require PCI Atomics, because they have
different semantics with respect to memory atomicity. Read
carefully and you'll see that they operate atomically only
within the adapter, and are not atomic all the way to the
underlying memory. It's a long and somewhat historical story.

Now that PCIe Atomics are becoming more widely supported by
processor complexes, there is the possibility these may be
more tightly embraced by RDMA implementations. There is
discussion in IBTA and IETF around this currently, in fact,
for the new RDMA Atomic Write operation.

Be aware that PCI Atomics are relatively expensive operations.
The existing ones perform a read-modify-write cycle on both
PCI and memory busses. This overhead is not to be taken lightly.

Tom.

> I found the related series on patchwork:
> https://patchwork.kernel.org/cover/10782873/
> 
> And I found the description about atomic operations in PCIe specification
> v4.0:
> 
> "An Atomic Operation (AtomicOp) is a single PCI Express transaction that
> targets a location in Memory Space, reads the location’s value, potentially
> writes a new value back to the location, and returns the original value. This
> "read-modify-write" sequence to the location is performed atomically."
> 
> It seems that the atomic for PCIe and RDMA is different concepts, and the macro
> IBV_PCI_ATOMIC_OPERATION_4_BYTE_SIZE_SUP is for PCIe atomic.
> 
> Could you please give me more suggestions about them?
> 
> Thanks
> Weihang
> 
> 
> 
