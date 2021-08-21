Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93AF93F39F8
	for <lists+linux-rdma@lfdr.de>; Sat, 21 Aug 2021 11:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbhHUJnc (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 21 Aug 2021 05:43:32 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:8758 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233401AbhHUJnc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 21 Aug 2021 05:43:32 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GsD7M6pkwzYrWJ;
        Sat, 21 Aug 2021 17:42:23 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 21 Aug 2021 17:42:52 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Sat, 21 Aug
 2021 17:42:51 +0800
Subject: Re: [PATCH v4 for-next 09/12] RDMA/hns: Add a shared memory to sync
 DCA status
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <1627525163-1683-1-git-send-email-liangwenpeng@huawei.com>
 <1627525163-1683-10-git-send-email-liangwenpeng@huawei.com>
 <20210819234330.GA398239@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>, <leon@kernel.org>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <8908772c-9857-e4cf-9126-39081059b951@huawei.com>
Date:   Sat, 21 Aug 2021 17:42:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20210819234330.GA398239@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/8/20 7:43, Jason Gunthorpe wrote:
> On Thu, Jul 29, 2021 at 10:19:20AM +0800, Wenpeng Liang wrote:
> 
>> +static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>> +{
>> +	switch (hns_roce_mmap_get_command(vma->vm_pgoff)) {
>> +	case HNS_ROCE_MMAP_REGULAR_PAGE:
>> +		return mmap_uar(uctx, vma);
>> +	case HNS_ROCE_MMAP_DCA_PAGE:
>> +		return mmap_dca(uctx, vma);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
> 
> New code should not copy the vm_pgoff stuff from old mlx5.
> 
> New code needs to use the mmap infrastructure and new APIs with proper
> mmap cookies for the things it is exporting.
> 
> See the newer stuff added to mlx5, the efa driver, etc.
> 
> Jason
> .
> 

The new code will be implemented according to the new APIs,
while the old code will continue to be retained for compatibility.
