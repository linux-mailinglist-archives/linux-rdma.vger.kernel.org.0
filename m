Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E16DF427A09
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Oct 2021 14:18:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232408AbhJIMUd (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Oct 2021 08:20:33 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:24231 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230163AbhJIMUc (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sat, 9 Oct 2021 08:20:32 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4HRPFl1Np9zQj5w;
        Sat,  9 Oct 2021 20:17:31 +0800 (CST)
Received: from dggpeml500017.china.huawei.com (7.185.36.243) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Sat, 9 Oct 2021 20:18:33 +0800
Received: from [10.40.238.78] (10.40.238.78) by dggpeml500017.china.huawei.com
 (7.185.36.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Sat, 9 Oct 2021
 20:18:33 +0800
Subject: Re: [PATCH for-next 1/1] RDMA/hns: Add a new mmap implementation
To:     Jason Gunthorpe <jgg@nvidia.com>
References: <20210930083608.18981-1-liangwenpeng@huawei.com>
 <20210930083608.18981-2-liangwenpeng@huawei.com>
 <20211006224431.GA2775740@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linuxarm@huawei.com>
From:   Wenpeng Liang <liangwenpeng@huawei.com>
Message-ID: <9b30a976-a550-1300-887b-9fd5628f179b@huawei.com>
Date:   Sat, 9 Oct 2021 20:18:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <20211006224431.GA2775740@nvidia.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.238.78]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500017.china.huawei.com (7.185.36.243)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/10/7 6:44, Jason Gunthorpe wrote:
> On Thu, Sep 30, 2021 at 04:36:08PM +0800, Wenpeng Liang wrote:
>> From: Chengchang Tang <tangchengchang@huawei.com>
>>
>> Add a new implementation for mmap by using the new mmap entry API.
>>
>> The new implementation prepares for subsequent features and is compatible
>> with the old implementation. And the old implementation using hard-coded
>> offset will not be extended in the future.
>>
>> Signed-off-by: Chengchang Tang <tangchengchang@huawei.com>
>> Signed-off-by: Wenpeng Liang <liangwenpeng@huawei.com>
>>  drivers/infiniband/hw/hns/hns_roce_device.h |  21 +++
>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 148 +++++++++++++++++++-
>>  include/uapi/rdma/hns-abi.h                 |  21 ++-
>>  3 files changed, 184 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>> index 9467c39e3d28..ca456948b2d8 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>> @@ -225,11 +225,23 @@ struct hns_roce_uar {
>>  	unsigned long	logic_idx;
>>  };
>>  
>> +struct hns_user_mmap_entry {
>> +	struct rdma_user_mmap_entry rdma_entry;
>> +	u64 address;
>> +	u8 mmap_flag;
>> +};
>> +
>> +enum hns_roce_mmap_type {
>> +	HNS_ROCE_MMAP_TYPE_DB = 1,
>> +};
>> +
>>  struct hns_roce_ucontext {
>>  	struct ib_ucontext	ibucontext;
>>  	struct hns_roce_uar	uar;
>>  	struct list_head	page_list;
>>  	struct mutex		page_mutex;
>> +	bool			mmap_key_support;
>> +	struct rdma_user_mmap_entry *db_mmap_entry;
> 
> This should be struct hns_user_mmap_entry
> 
> 

Thanks

>> +struct rdma_user_mmap_entry *hns_roce_user_mmap_entry_insert(
>> +			struct ib_ucontext *ucontext, u64 address,
>> +			size_t length, u8 mmap_flag)
> 
> And this should return the hns_user_mmap_entry too
> 

Thanks

>> +static void ucontext_get_config(struct hns_roce_ucontext *context,
>> +				struct hns_roce_ib_alloc_ucontext *ucmd)
>> +{
>> +	struct hns_roce_dev *hr_dev = to_hr_dev(context->ibucontext.device);
>> +
>> +	if (ucmd->comp & HNS_ROCE_ALLOC_UCTX_COMP_CONFIG &&
>> +	    hr_dev->hw_rev != HNS_ROCE_HW_VER1)
>> +		context->mmap_key_support = !!(ucmd->config &
>> +					       HNS_ROCE_UCTX_REQ_MMAP_KEY_EN);
> 
> No need for !! when in a bool context
> 

Thanks

>>  
>> +static int hns_roce_mmap(struct ib_ucontext *uctx, struct vm_area_struct *vma)
>> +{
>> +	struct hns_roce_ucontext *context = to_hr_ucontext(uctx);
>> +	struct hns_roce_dev *hr_dev = to_hr_dev(uctx->device);
>> +	struct ib_device *ibdev = &hr_dev->ib_dev;
>> +	struct rdma_user_mmap_entry *rdma_entry;
>> +	struct hns_user_mmap_entry *entry;
>> +	phys_addr_t pfn;
>> +	pgprot_t prot;
>> +	int ret;
>> +
>> +	if (!context->mmap_key_support)
>> +		return hns_roce_legacy_mmap(uctx, vma);
> 
> This shouldn't be necessary,
> 
> Just call rdma_user_mmap_entry_insert_range() to insert the two pages
> at 0 and 1 when in legacy mode and always keep the mmap routine in new
> mode
> 
> Jason
> .
> 

Thanks for your comment, I will send v2 to fix these.

Thanks,
Wenpeng
