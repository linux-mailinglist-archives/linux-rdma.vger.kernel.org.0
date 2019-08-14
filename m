Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCD08CB6F
	for <lists+linux-rdma@lfdr.de>; Wed, 14 Aug 2019 07:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727578AbfHNFyo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 14 Aug 2019 01:54:44 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:50666 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725263AbfHNFyo (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 14 Aug 2019 01:54:44 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id F0160D08E1BA1BB87DFA;
        Wed, 14 Aug 2019 13:54:37 +0800 (CST)
Received: from [127.0.0.1] (10.74.150.236) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Wed, 14 Aug 2019
 13:54:27 +0800
Subject: Re: [PATCH for-next 8/9] RDMA/hns: Kernel notify usr space to stop
 ring db
To:     Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
CC:     Lijun Ou <oulijun@huawei.com>, <dledford@redhat.com>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1565343666-73193-1-git-send-email-oulijun@huawei.com>
 <1565343666-73193-9-git-send-email-oulijun@huawei.com>
 <20190812055220.GA8440@mtr-leonro.mtl.com> <20190812131437.GG24457@ziepe.ca>
From:   Yangyang Li <liyangyang20@huawei.com>
Message-ID: <6ab06eaf-e257-2a3b-2c1b-c008f2a70038@huawei.com>
Date:   Wed, 14 Aug 2019 13:54:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812131437.GG24457@ziepe.ca>
Content-Type: text/plain; charset="gbk"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.74.150.236]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Leon & Jason
Thanks a lot for your reply.

ÔÚ 2019/8/12 21:14, Jason Gunthorpe Ð´µÀ:
> On Mon, Aug 12, 2019 at 08:52:20AM +0300, Leon Romanovsky wrote:
>> On Fri, Aug 09, 2019 at 05:41:05PM +0800, Lijun Ou wrote:
>>> From: Yangyang Li <liyangyang20@huawei.com>
>>>
>>> In the reset scenario, if the kernel receives the reset signal,
>>> it needs to notify the user space to stop ring doorbell.
>>
>> I doubt about it, it is racy like hell and relies on assumption that
>> userspace will honor such request to stop.
> 
> Sounds like this is the device unplug flow we already have support
> for, use the APIs to drop the VMA refering to the doorbell

Thanks for the suggestion, I have found this new unplug API,
and  I am trying to use it in the driver..

> 
>>> Signed-off-by: Yangyang Li <liyangyang20@huawei.com>
>>>  drivers/infiniband/hw/hns/hns_roce_device.h |  4 +++
>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c  | 52 ++++++++++++++++++++++++++++-
>>>  drivers/infiniband/hw/hns/hns_roce_hw_v2.h  |  4 +++
>>>  drivers/infiniband/hw/hns/hns_roce_main.c   | 22 ++++++------
>>>  4 files changed, 70 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_device.h b/drivers/infiniband/hw/hns/hns_roce_device.h
>>> index 32465f5..be65fce 100644
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_device.h
>>> @@ -268,6 +268,8 @@ enum {
>>>
>>>  #define PAGE_ADDR_SHIFT				12
>>>
>>> +#define HNS_ROCE_IS_RESETTING			1
>>> +
>>>  struct hns_roce_uar {
>>>  	u64		pfn;
>>>  	unsigned long	index;
>>> @@ -1043,6 +1045,8 @@ struct hns_roce_dev {
>>>  	u32			odb_offset;
>>>  	dma_addr_t		tptr_dma_addr;	/* only for hw v1 */
>>>  	u32			tptr_size;	/* only for hw v1 */
>>> +	struct page		*reset_page; /* store reset state */
>>> +	void			*reset_kaddr; /* addr of reset page */
>>>  	const struct hns_roce_hw *hw;
>>>  	void			*priv;
>>>  	struct workqueue_struct *irq_workq;
>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> index d33341e..138e5a8 100644
>>> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
>>> @@ -1867,17 +1867,49 @@ static void hns_roce_free_link_table(struct hns_roce_dev *hr_dev,
>>>  			  link_tbl->table.map);
>>>  }
>>>
>>> +static int hns_roce_v2_get_reset_page(struct hns_roce_dev *hr_dev)
>>> +{
>>> +	hr_dev->reset_page = alloc_page(GFP_KERNEL | __GFP_ZERO);
>>> +	if (!hr_dev->reset_page)
>>> +		return -ENOMEM;
>>> +
>>> +	hr_dev->reset_kaddr = vmap(&hr_dev->reset_page, 1, VM_MAP, PAGE_KERNEL);
>>> +	if (!hr_dev->reset_kaddr)
>>> +		goto err_with_vmap;
> 
> Yes, this vmap is nonsense too, get_zeroed_page() is the right API
> 
> Jason
> 
> 
Thanks for the suggestion, put_page is not the correct usage,
I will use the appropriate API to fix it in the next patch.

Thanks

