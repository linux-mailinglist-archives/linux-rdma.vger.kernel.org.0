Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375024374C2
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Oct 2021 11:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232404AbhJVJeP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 22 Oct 2021 05:34:15 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:14848 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232180AbhJVJeP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 22 Oct 2021 05:34:15 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HbJrz0K94z90My;
        Fri, 22 Oct 2021 17:26:59 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 22 Oct 2021 17:31:56 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Fri, 22 Oct
 2021 17:31:56 +0800
Subject: Re: [PATCH v2 for-next] RDMA/hns: Add a new mmap implementation
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20211012124155.12329-1-liangwenpeng@huawei.com>
 <20211020231500.GA27862@nvidia.com>
 <57276fd3-72d3-b1ba-3e83-c7c190d553d5@huawei.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <cbb7cfdf-e251-62a1-14bd-6e4ae7429038@huawei.com>
Date:   Fri, 22 Oct 2021 17:31:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <57276fd3-72d3-b1ba-3e83-c7c190d553d5@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Sorry, the reply is incomplete, please ignore this email.

On 2021/10/22 16:56, Wenpeng Liang wrote:
> On 2021/10/21 7:15, Jason Gunthorpe wrote:
>> On Tue, Oct 12, 2021 at 08:41:55PM +0800, Wenpeng Liang wrote:
>>> From: Chengchang Tang <tangchengchang@huawei.com>
>>>
>>> Add a new implementation for mmap by using the new mmap entry API.
>>>
>>> The new implementation prepares for subsequent features and is compatible
>>> with the old implementation. And the old implementation using hard-coded
>>> offset will not be extended in the future.
>>>
>>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  23 +++
>>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 208 +++++++++++++++++---
>>>  include/uapi/rdma/hns-abi.h                 |  21 +-
>>>  3 files changed, 225 insertions(+), 27 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>>> index 9467c39e3d28..1d4cf3f083c2 100644
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>>> @@ -225,11 +225,25 @@ struct hns_roce_uar {
>>>  	unsigned long	logic_idx;
>>>  };
>>>  
>>> +struct hns_user_mmap_entry {
>>> +	struct rdma_user_mmap_entry rdma_entry;
>>> +	u64 address;
>>> +	u8 mmap_flag;
>>
>> Call this mmap_type and use the enum:
>>
>>  enum hns_roce_mmap_type mmap_type
>>
> 
> I will fix it in v3, thanks!
> 
>>> +struct hns_user_mmap_entry *hns_roce_user_mmap_entry_insert(
>>> +				struct ib_ucontext *ucontext, u64 address,
>>> +				size_t length, u8 mmap_flag)
>>> +{
>>> +#define HNS_ROCE_PGOFFSET_TPTR 1
>>> +#define HNS_ROCE_PGOFFSET_DB 0
>>> +	struct hns_roce_ucontext *context = to_hr_ucontext(ucontext);
>>> +	struct hns_user_mmap_entry *entry;
>>> +	int ret;
>>> +
>>> +	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
>>> +	if (!entry)
>>> +		return NULL;
>>> +
>>> +	entry->address = address;
>>> +	entry->mmap_flag = mmap_flag;
>>> +
>>> +	if (context->mmap_key_support) {
>>> +		ret = rdma_user_mmap_entry_insert(ucontext, &entry->rdma_entry,
>>> +						  length);
>>> +	} else {
>>> +		switch (mmap_flag) {
>>> +		case HNS_ROCE_MMAP_TYPE_DB:
>>> +			ret = rdma_user_mmap_entry_insert_range(ucontext,
>>> +						&entry->rdma_entry, length,
>>> +						HNS_ROCE_PGOFFSET_DB,
>>> +						HNS_ROCE_PGOFFSET_DB);
>>
>> Please add this to avoid the odd #defines:
>>
>> static inline int
>> rdma_user_mmap_entry_insert_exact(struct ib_ucontext *ucontext,
>>                                   struct rdma_user_mmap_entry *entry,
>>                                   size_t length, u32 pgoff)
>> {
>>         return rdma_user_mmap_entry_insert_range(ucontext, entry, length, pgoff,
>>                                                  pgoff);
>> }
>>
> 
> ditto.
> 
>>> -static int hns_roce_mmap(struct ib_ucontext *context,
>>> -			 struct vm_area_struct *vma)
>>> +static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>>>  {
>>> -	struct hns_roce_dev *hr_dev = to_hr_dev(context->device);
>>> -
>>> -	switch (vma->vm_pgoff) {
>>> -	case 0:
>>> -		return rdma_user_mmap_io(context, vma,
>>> -					 to_hr_ucontext(context)->uar.pfn,
>>> -					 PAGE_SIZE,
>>> -					 pgprot_noncached(vma->vm_page_prot),
>>> -					 NULL);
>>> -
>>> -	/* vm_pgoff: 1 -- TPTR */
>>> -	case 1:
>>> -		if (!hr_dev->tptr_dma_addr || !hr_dev->tptr_size)
>>> -			return -EINVAL;
>>> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
>>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>>> +	struct rdma_user_mmap_entry *rdma_entry;
>>> +	struct hns_user_mmap_entry *entry;
>>> +	phys_addr_t pfn;
>>> +	pgprot_t prot;
>>> +	int ret;
>>> +
>>> +	rdma_entry = rdma_user_mmap_entry_get_pgoff(uctx, vma->vm_pgoff);
>>> +	if (!rdma_entry) {
>>> +		ibdev_err(ibdev, "Invalid entry vm_pgoff %lu.\n",
>>> +			  vma->vm_pgoff);
>>> +		return -EINVAL;
>>> +	}
>>> +
>>> +	entry = to_hns_mmap(rdma_entry);
>>> +	pfn = entry->address >> PAGE_SHIFT;
>>> +	prot = vma->vm_page_prot;
>>
>> Just write
>>
>>  if (entry->mmap_type != HNS_ROCE_MMAP_TYPE_TPTR)
>>     prot = pgprot_noncached(prot);
>>  ret = rdma_user_mmap_io(uctx, vma, pfn,
>> 			rdma_entry->npages * PAGE_SIZE,
>> 			pgprot_noncached(prot), rdma_entry);
>>
>> No need for the big case statement
>>
> 
> There will be new features added to this switch branch in a later patch.
> 
>>> diff --git a/include/uapi/rdma/hns-abi.h b/include/uapi/rdma/hns-abi.h
>>> index 42b177655560..ce1e39f21d73 100644
>>> +++ b/include/uapi/rdma/hns-abi.h
>>> @@ -83,11 +83,30 @@ struct hns_roce_ib_create_qp_resp {
>>>  	__aligned_u64 cap_flags;
>>>  };
>>>  
>>> +enum hns_roce_alloc_uctx_comp_flag {
>>> +	HNS_ROCE_ALLOC_UCTX_COMP_CONFIG = 1 << 0,
>>> +};
>>> +
>>> +enum hns_roce_alloc_uctx_resp_config {
>>> +	HNS_ROCE_UCTX_RESP_MMAP_KEY_EN = 1 << 0,
>>> +};
>>> +
>>> +enum hns_roce_alloc_uctx_req_config {
>>> +	HNS_ROCE_UCTX_REQ_MMAP_KEY_EN = 1 << 0,
>>> +};
>>> +
>>> +struct hns_roce_ib_alloc_ucontext {
>>> +	__u32 comp;
>>> +	__u32 config;
>>> +};
>>> +
>>>  struct hns_roce_ib_alloc_ucontext_resp {
>>>  	__u32	qp_tab_size;
>>>  	__u32	cqe_size;
>>>  	__u32	srq_tab_size;
>>> -	__u32	reserved;
>>> +	__u8    config;
>>> +	__u8    rsv[3];
>>> +	__aligned_u64 db_mmap_key;
>>
>> I'm confused, this doesn't change the uAPI, so why add this stuff?
>> This should go in a later patch?
>>
>> Jason
>> .
>>
> 
> The related userspace series is named "libhns: Add a new mmap implementation".
> 
> Thanks,
> Wenpeng
> .
> 
