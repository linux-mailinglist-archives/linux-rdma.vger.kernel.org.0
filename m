Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 572B445FD7C
	for <lists+linux-rdma@lfdr.de>; Sat, 27 Nov 2021 10:06:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352928AbhK0JJR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 27 Nov 2021 04:09:17 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31914 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241695AbhK0JHR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 27 Nov 2021 04:07:17 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J1Qdm5lb7zcbRG;
        Sat, 27 Nov 2021 17:03:56 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Sat, 27 Nov 2021 17:04:00 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Sat, 27 Nov
 2021 17:04:00 +0800
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com> <YZtboTThVCL7xs5s@unreal>
 <20211125175044.GA504288@nvidia.com>
 <9b3e8596-a386-667b-b8b2-21358331d681@huawei.com>
 <20211126121623.GQ4670@nvidia.com>
CC:     Leon Romanovsky <leon@kernel.org>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <1916afc6-3956-38be-aabe-0c955c0ecb23@huawei.com>
Date:   Sat, 27 Nov 2021 17:04:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211126121623.GQ4670@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/11/26 20:16, Jason Gunthorpe wrote:
> On Fri, Nov 26, 2021 at 04:25:27PM +0800, Wenpeng Liang wrote:
>> On 2021/11/26 1:50, Jason Gunthorpe wrote:
>>> On Mon, Nov 22, 2021 at 10:58:09AM +0200, Leon Romanovsky wrote:
>>>> On Mon, Nov 22, 2021 at 11:38:01AM +0800, Wenpeng Liang wrote:
>>>>> From: Yixing Liu <liuyixing1@huawei.com>
>>>>>
>>>>> Add direct wqe enable switch and address mapping.
>>>>>
>>>>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
>>>>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
>>>>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 38 ++++++++++++---
>>>>>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
>>>>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
>>>>>  include/uapi/rdma/hns-abi.h                 |  2 +
>>>>>  5 files changed, 94 insertions(+), 11 deletions(-)
>>>>
>>>> <...>
>>>>
>>>>>  	entry = to_hns_mmap(rdma_entry);
>>>>>  	pfn = entry->address >> PAGE_SHIFT;
>>>>> -	prot = vma->vm_page_prot;
>>>>>  
>>>>> -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
>>>>> -		prot = pgprot_noncached(prot);
>>>>> +	switch (entry->mmap_type) {
>>>>> +	case HNS_ROCE_MMAP_TYPE_DB:
>>>>> +		prot = pgprot_noncached(vma->vm_page_prot);
>>>>> +		break;
>>>>> +	case HNS_ROCE_MMAP_TYPE_TPTR:
>>>>> +		prot = vma->vm_page_prot;
>>>>> +		break;
>>>>> +	case HNS_ROCE_MMAP_TYPE_DWQE:
>>>>> +		prot = pgprot_device(vma->vm_page_prot);
>>>>
>>>> Everything fine, except this pgprot_device(). You probably need to check
>>>> WC internally in your driver and use or pgprot_writecombine() or
>>>> pgprot_noncached() explicitly.
>>>
>>> pgprot_device is only used in two places in the kernel
>>> pci_mmap_resource_range() for setting up the sysfs resourceXX mmap
>>>
>>> And in pci_remap_iospace() as part of emulationg PIO on mmio
>>> architectures
>>>
>>> So, a PCI device should always be using pgprot_device() in its mmap
>>> function
>>>
>>> The question is why is pgprot_noncached() being used at all? The only
>>> difference on ARM is that noncached is non-Early Write Acknowledgement
>>> and devices is not.
>>>
>>> At the very least this should be explained in a comment why nE vs E is
>>> required in all these cases.
>>>
>>> Jason
>>> .
>>>
>>
>> HIP09 is a SoC device, and our CPU only optimizes ST4 instructions for device
>> attributes. Therefore, we set device attributes to obtain optimization effects.
>>
>> The device attribute allows early ack, so it is faster compared with noncached.
>> In order to ensure the early ack works correctly. Even if the data is incomplete,
>> our device still knocks on the doorbell according to the content of the first
>> 8 bytes to complete the data transmission.
> 
> That doesn't really explain why the doorbell needs to be mapped noncache
> 

I might have misunderstood what you meant before.

For the HNS_ROCE_MMAP_TYPE_DB type, our device does not support Early Write
Acknowledgement. Therefore, HNS_ROCE_MMAP_TYPE_DB uses the noncached attribute.
I will add a comment in v5.

Thanks
Wenpeng
