Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F01CF5E77
	for <lists+linux-rdma@lfdr.de>; Sat,  9 Nov 2019 11:32:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726301AbfKIKcF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 9 Nov 2019 05:32:05 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:6174 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726149AbfKIKcE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 9 Nov 2019 05:32:04 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 65CE938C63BD73A6E770;
        Sat,  9 Nov 2019 18:32:03 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Sat, 9 Nov 2019
 18:31:54 +0800
Subject: Re: [PATCH for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1572255945-20297-1-git-send-email-liuyixian@huawei.com>
 <1572255945-20297-2-git-send-email-liuyixian@huawei.com>
 <20191106204013.GA26459@ziepe.ca>
 <e2e0f478-a057-c297-7e1e-d9b09eee2986@huawei.com>
 <20191107182850.GB6730@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <0bbc16e9-0bf0-76f3-f9c8-1bd9cd8dcdff@huawei.com>
Date:   Sat, 9 Nov 2019 18:30:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20191107182850.GB6730@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/8 2:28, Jason Gunthorpe wrote:
> On Thu, Nov 07, 2019 at 08:48:25PM +0800, Liuyixian (Eason) wrote:
>>
>>
>> On 2019/11/7 4:40, Jason Gunthorpe wrote:
>>> On Mon, Oct 28, 2019 at 05:45:44PM +0800, Yixian Liu wrote:
>>>> @@ -1998,6 +2000,17 @@ static int hns_roce_v2_init(struct hns_roce_dev *hr_dev)
>>>>  		}
>>>>  	}
>>>>  
>>>> +	snprintf(workq_name, HNS_ROCE_WORKQ_NAME_LEN - 1,
>>>> +		 "hns_roce_%d_flush_wq", device_id);
>>>> +	device_id++;
>>>> +
>>>> +	hr_dev->flush_workq = alloc_workqueue(workq_name, WQ_HIGHPRI, 0);
>>>> +	if (!hr_dev->flush_workq) {
>>>
>>> Why is this so time critical?
>>
>> Hi Jason,
>>
>> I am not quite sure whether you concerned with the flag "WQ_HIGHPRI" or
>> why WQ is created in hns_roce_v2_init.
> 
> Yes, why do you need a dedicated HIGHPRI work queue.

As hip08 hardware needs driver to help to do flush operation, I am not
sure the application can perceive that qp state is error without receiving
flush cqe if work in WQ is not scheduled in time.

> 
>> If it is WQ_HIGHPRI, yes, it is much better to implement flush operation
>> ASAP to help generating flushed cqe as ULP may poll cqe urgently. If you
>> concerned allocation stage, as flush operation is support for hip08 only,
>> there is no other place proper than here I think.
> 
> Why? This is only something that happens in error cases.

Yes, maybe we can move out WQ_HIGHPRI flag safely, will fix it in v2.

> 
>>> Why don't you do this from hns_roce_irq_work_handle() ?
>>
>> As described in the cover letter, here we used CMWQ (concurrency management workqueue)
>> to make sure that flush operation can be implemented ASAP. Current irq workqueue is
>> a singlethread workqueue, which may delay the flush too long when the system is heavy.
>>
>> Do you mean we can change irq workqueue to CMWQ to put flush work into it?
> 
> As far as I could tell the only thing the triggered the work to run
> was some variable which was only set in another work queue 'hns_roce_irq_work_handle()'

OK, thanks. I will consider you suggestion and reuse the irq workqueue.

>  
>>>> +}
>>>> +
>>>> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>>>> +{
>>>> +	struct hns_roce_flush_work *flush_work;
>>>> +
>>>> +	flush_work = kzalloc(sizeof(struct hns_roce_flush_work), GFP_ATOMIC);
>>>> +	if (!flush_work)
>>>> +		return;
>>>
>>> Don't do things that can fail here
>>
>> Do you mean that as "GFP_ATOMIC" is used, the if branch can be deleted?
> 
> No, don't do allocations at all if you can't allow them to fail.

OK, thanks! I will initialize this structure at compile time.

> 
> Jason
> 
> .
> 

