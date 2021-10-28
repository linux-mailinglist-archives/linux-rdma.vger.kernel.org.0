Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D7743DD1C
	for <lists+linux-rdma@lfdr.de>; Thu, 28 Oct 2021 10:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbhJ1IsL (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 28 Oct 2021 04:48:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:26200 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbhJ1IsK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 28 Oct 2021 04:48:10 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Hfzcy1bsmz8twS;
        Thu, 28 Oct 2021 16:44:18 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Thu, 28 Oct 2021 16:45:40 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Thu, 28 Oct
 2021 16:45:40 +0800
Subject: Re: [PATCH v3 for-next] RDMA/hns: Add a new mmap implementation
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20211027104129.36902-1-liangwenpeng@huawei.com>
 <20211027120941.GA583629@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <c69b0bce-3537-9747-23f7-8d9c168ef92a@huawei.com>
Date:   Thu, 28 Oct 2021 16:45:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211027120941.GA583629@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2021/10/27 20:09, Jason Gunthorpe wrote:
> On Wed, Oct 27, 2021 at 06:41:29PM +0800, Wenpeng Liang wrote:
>> +static int hns_roce_alloc_uar_entry(struct ib_ucontext *uctx)
>> +{
>> +	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
>> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
>> +	u64 address;
>> +	int ret;
>> +
>> +	address = context->uar.pfn << PAGE_SHIFT;
>> +	context->db_mmap_entry =
>> +		hns_roce_user_mmap_entry_insert(uctx, address, PAGE_SIZE,
>> +						HNS_ROCE_MMAP_TYPE_DB);
>> +	if (!context->db_mmap_entry)
>> +		return -ENOMEM;
>> +
>> +	if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
>> +		return 0;
> 
> You can move the FIXME comment below to here
> 

Thanks, I will move it in v4.

>> +	context->tptr_mmap_entry =
>> +		hns_roce_user_mmap_entry_insert(uctx, hr_dev->tptr_dma_addr,
>> +						hr_dev->tptr_size,
>> +						HNS_ROCE_MMAP_TYPE_TPTR);
>> +	if (!context->tptr_mmap_entry) {
>> +		ret = -ENOMEM;
>> +		goto err;
>> +	}
>> +
>> +	return 0;
>> +
>> +err:
>> +	hns_roce_dealloc_uar_entry(context);
>> +	return ret;
>> +}
> 
>> +	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
>> +	if (!rdma_entry) {
>> +		ibdev_err(ibdev, "Invalid entry vm_pgoff %lu.\n",
>> +			  vma->vm_pgoff);
> 
> Do not print on user controlled paths
> 
> Jason
> .
> 

Thanks, I will remove it in v4.

Wenpeng
