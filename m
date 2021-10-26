Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3388243B2D5
	for <lists+linux-rdma@lfdr.de>; Tue, 26 Oct 2021 15:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233472AbhJZNEy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 26 Oct 2021 09:04:54 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:29940 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230324AbhJZNEy (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 26 Oct 2021 09:04:54 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HdsLQ2c45zbnPH;
        Tue, 26 Oct 2021 20:57:50 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Tue, 26 Oct 2021 21:02:28 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Tue, 26 Oct
 2021 21:02:28 +0800
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add a new mmap implementation
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20211012124155.12329-1-liangwenpeng@huawei.com>
 <20211020231500.GA27862@nvidia.com>
 <7397cd8d-c976-fd81-8bb5-ae6c679a9e03@huawei.com>
 <20211025125523.GU2744544@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <d0938f60-61bc-ef6f-83de-37f32e6638b3@huawei.com>
Date:   Tue, 26 Oct 2021 21:02:27 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211025125523.GU2744544@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/10/25 20:55, Jason Gunthorpe wrote:
> On Fri, Oct 22, 2021 at 05:46:19PM +0800, Wenpeng Liang wrote:
>>> Just write
>>>
>>>  if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
>>>     prot = pgprot_noncached(prot);
>>>  ret = rdma_user_mmap_io(uctx, vma, pfn,
>>> 			rdma_entry->npages * PAGE_SIZE,
>>> 			pgprot_noncached(prot), rdma_entry);
>>>
>>> No need for the big case statement
>>>
>>
>> In the future, we will have multiple new features that will add
>> new branches to this switch. We hope to reduce the coupling
>> between subsequent patches, so we hope to keep this switch.
> 
> Why? The only choice that should be made at mmap time is if this is
> noncached or not - the address and everything else should be setup
> during the creation of the entry.
> 

Thanks for your comment, I will merge 'HNS_ROCE_MMAP_TYPE_TPTR' and
'HNS_ROCE_MMAP_TYPE_DB' into one statement in v3.

>>>>  struct hns_roce_ib_alloc_ucontext_resp {
>>>>  	__u32	qp_tab_size;
>>>>  	__u32	cqe_size;
>>>>  	__u32	srq_tab_size;
>>>> -	__u32	reserved;
>>>> +	__u8    config;
>>>> +	__u8    rsv[3];
>>>> +	__aligned_u64 db_mmap_key;
>>>
>>> I'm confused, this doesn't change the uAPI, so why add this stuff?
>>> This should go in a later patch?
>>>
>>
>> The related userspace has also been modified, the link is:
>> https://nam11.safelinks.protection.outlook.com/?url=https%3A%2F%2Fwww.spinics.net%2Flists%2Flinux-rdma%2Fmsg106056.html&amp;data=04%7C01%7Cjgg%40nvidia.com%7Cffac1b9f0afb458a4da308d99540ce99%7C43083d15727340c1b7db39efd9ccc17a%7C0%7C0%7C637704927843133708%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C1000&amp;sdata=BAszHlXQWWh%2F8hrb%2F8qEStm3VBrhvbMshfPN3pc6wKI%3D&amp;reserved=0
>>
>> I don’t know if I understood your question correctly. These fields
>> are used for compatibility, so they are necessary. The user space
>> and kernel space of different versions are handshake through 'config'.
> 
> That is for later patches, this patch doesn't seem to change the uAPI
> at all. The compat mmaps remain at the same offsets they were always
> at, there is nothing to negotiate at this point.
> 
> Move it to a later series?
> 
> Jason
> .
> 

Thanks, I will remove it in v3.

Wenpeng

