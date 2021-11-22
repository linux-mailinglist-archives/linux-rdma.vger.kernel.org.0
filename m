Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5AC3458E83
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhKVMj7 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 07:39:59 -0500
Received: from szxga08-in.huawei.com ([45.249.212.255]:28090 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239584AbhKVMjx (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 07:39:53 -0500
Received: from dggpeml500020.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HyRXk3MZGz1DJT2;
        Mon, 22 Nov 2021 20:34:14 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500020.china.huawei.com (7.185.36.88) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 20:36:44 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 20:36:43 +0800
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
To:     Leon Romanovsky <leon@kernel.org>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com> <YZtboTThVCL7xs5s@unreal>
 <10bbb3f3-600c-1db7-4859-47bd6850969f@huawei.com> <YZt6jQDzNLw7Zn1r@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <48b465dc-bc58-d00b-39ae-e8133d621666@huawei.com>
Date:   Mon, 22 Nov 2021 20:36:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YZt6jQDzNLw7Zn1r@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/11/22 19:10, Leon Romanovsky wrote:
> On Mon, Nov 22, 2021 at 05:28:31PM +0800, Wenpeng Liang wrote:
>>
>>
>> On 2021/11/22 16:58, Leon Romanovsky wrote:
>>>>  	entry = to_hns_mmap(rdma_entry);
>>>>  	pfn = entry->address >> PAGE_SHIFT;
>>>> -	prot = vma->vm_page_prot;
>>>>  
>>>> -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
>>>> -		prot = pgprot_noncached(prot);
>>>> +	switch (entry->mmap_type) {
>>>> +	case HNS_ROCE_MMAP_TYPE_DB:
>>>> +		prot = pgprot_noncached(vma->vm_page_prot);
>>>> +		break;
>>>> +	case HNS_ROCE_MMAP_TYPE_TPTR:
>>>> +		prot = vma->vm_page_prot;
>>>> +		break;
>>>> +	case HNS_ROCE_MMAP_TYPE_DWQE:
>>>> +		prot = pgprot_device(vma->vm_page_prot);
>>> Everything fine, except this pgprot_device(). You probably need to check
>>> WC internally in your driver and use or pgprot_writecombine() or
>>> pgprot_noncached() explicitly.
>>>
>>> Thanks
>>> .
>>>
>>
>> This issue is also discussed in the v2 version, direct wqe uses
>> this prot on HIP09 can achieve better performance than NC.
>>
>> v2 link: https://patchwork.kernel.org/project/linux-rdma/patch/1622705834-19353-3-git-send-email-liweihang@huawei.com/
> 
> But isn't it specific to ARM model that behaves such? Will it be the case
> when you move to upgrade your ARM core?
> 
> Thanks
> 

Although the hns roce engine is a PCIe device, it is integrated into the SoC,
and using pgprot_device() will bring a higher performance improvement.
If the ARM core is upgraded, we will consider this issue again.

Thanks
Wenpeng

>>
>> Thanks
>> Wenpeng
> .
> 
