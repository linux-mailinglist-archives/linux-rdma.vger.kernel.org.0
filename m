Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7E55458B69
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Nov 2021 10:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbhKVJbk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Nov 2021 04:31:40 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:14971 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238882AbhKVJbk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 22 Nov 2021 04:31:40 -0500
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HyMMZ54zFzZd8T;
        Mon, 22 Nov 2021 17:26:02 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggpeml500026.china.huawei.com (7.185.36.106) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 17:28:32 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 17:28:32 +0800
Subject: Re: [PATCH v4 for-next 1/1] RDMA/hns: Support direct wqe of userspace
To:     Leon Romanovsky <leon@kernel.org>
References: <20211122033801.30807-1-liangwenpeng@huawei.com>
 <20211122033801.30807-2-liangwenpeng@huawei.com> <YZtboTThVCL7xs5s@unreal>
CC:     <jgg@nvidia.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <10bbb3f3-600c-1db7-4859-47bd6850969f@huawei.com>
Date:   Mon, 22 Nov 2021 17:28:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YZtboTThVCL7xs5s@unreal>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/11/22 16:58, Leon Romanovsky wrote:
>>  	entry = to_hns_mmap(rdma_entry);
>>  	pfn = entry->address >> PAGE_SHIFT;
>> -	prot = vma->vm_page_prot;
>>  
>> -	if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
>> -		prot = pgprot_noncached(prot);
>> +	switch (entry->mmap_type) {
>> +	case HNS_ROCE_MMAP_TYPE_DB:
>> +		prot = pgprot_noncached(vma->vm_page_prot);
>> +		break;
>> +	case HNS_ROCE_MMAP_TYPE_TPTR:
>> +		prot = vma->vm_page_prot;
>> +		break;
>> +	case HNS_ROCE_MMAP_TYPE_DWQE:
>> +		prot = pgprot_device(vma->vm_page_prot);
> Everything fine, except this pgprot_device(). You probably need to check
> WC internally in your driver and use or pgprot_writecombine() or
> pgprot_noncached() explicitly.
> 
> Thanks
> .
> 

This issue is also discussed in the v2 version, direct wqe uses
this prot on HIP09 can achieve better performance than NC.

v2 link: https://patchwork.kernel.org/project/linux-rdma/patch/1622705834-19353-3-git-send-email-liweihang@huawei.com/

Thanks
Wenpeng
