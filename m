Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B306C45E959
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Nov 2021 09:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346720AbhKZIan (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 26 Nov 2021 03:30:43 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:31908 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345287AbhKZI2n (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 26 Nov 2021 03:28:43 -0500
Received: from dggpeml500025.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4J0nqn0GjKzcbMg;
        Fri, 26 Nov 2021 16:25:25 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500025.china.huawei.com (7.185.36.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 26 Nov 2021 16:25:28 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Fri, 26 Nov
 2021 16:25:27 +0800
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com> <YZtboTThVCL7xs5s@unreal>
 <20211125175044.GA504288@nvidia.com>
CC:     <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <9b3e8596-a386-667b-b8b2-21358331d681@huawei.com>
Date:   Fri, 26 Nov 2021 16:25:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211125175044.GA504288@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/11/26 1:50, Jason Gunthorpe wrote:
> On Mon, Nov 22, 2021 at 10:58:09AM +0200, Leon Romanovsky wrote:
>> On Mon, Nov 22, 2021 at 11:38:01AM +0800, Wenpeng Liang wrote:
>>> From: Yixing Liu <liuyixing1@huawei.com>
>>>
>>> Add direct wqe enable switch and address mapping.
>>>
>>> Signed-off-by: Yixing Liu <liuyixing1@huawei.com>
>>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  8 +--
>>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 38 ++++++++++++---
>>>  drivers/infiniband/hw/hns/hns_roce_pd.c     |  3 ++
>>>  drivers/infiniband/hw/hns/hns_roce_qp.c     | 54 ++++++++++++++++++++-
>>>  include/uapi/rdma/hns-abi.h                 |  2 +
>>>  5 files changed, 94 insertions(+), 11 deletions(-)
>>
>> <...>
>>
>>>  	entry = to_hns_mmap(rdma_entry);
>>>  	pfn = entry->address >> PAGE_SHIFT;
>>> -	prot = vma->vm_page_prot;
>>>  
>>> -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
>>> -		prot = pgprot_noncached(prot);
>>> +	switch (entry->mmap_type) {
>>> +	case HNS_ROCE_MMAP_TYPE_DB:
>>> +		prot = pgprot_noncached(vma->vm_page_prot);
>>> +		break;
>>> +	case HNS_ROCE_MMAP_TYPE_TPTR:
>>> +		prot = vma->vm_page_prot;
>>> +		break;
>>> +	case HNS_ROCE_MMAP_TYPE_DWQE:
>>> +		prot = pgprot_device(vma->vm_page_prot);
>>
>> Everything fine, except this pgprot_device(). You probably need to check
>> WC internally in your driver and use or pgprot_writecombine() or
>> pgprot_noncached() explicitly.
> 
> pgprot_device is only used in two places in the kernel
> pci_mmap_resource_range() for setting up the sysfs resourceXX mmap
> 
> And in pci_remap_iospace() as part of emulationg PIO on mmio
> architectures
> 
> So, a PCI device should always be using pgprot_device() in its mmap
> function
> 
> The question is why is pgprot_noncached() being used at all? The only
> difference on ARM is that noncached is non-Early Write Acknowledgement
> and devices is not.
> 
> At the very least this should be explained in a comment why nE vs E is
> required in all these cases.
> 
> Jason
> .
> 

HIP09 is a SoC device, and our CPU only optimizes ST4 instructions for device
attributes. Therefore, we set device attributes to obtain optimization effects.

The device attribute allows early ack, so it is faster compared with noncached.
In order to ensure the early ack works correctly. Even if the data is incomplete,
our device still knocks on the doorbell according to the content of the first
8 bytes to complete the data transmission.

Thanks
Wenpeng
