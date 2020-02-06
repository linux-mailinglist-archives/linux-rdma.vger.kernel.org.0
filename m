Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CB0421540FC
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Feb 2020 10:15:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728289AbgBFJPE (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Feb 2020 04:15:04 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9705 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726365AbgBFJPE (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 6 Feb 2020 04:15:04 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 395B77CF7C3E18D60F4A;
        Thu,  6 Feb 2020 17:15:01 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 17:14:54 +0800
Subject: Re: [PATCH v7 for-next 2/2] RDMA/hns: Delayed flush cqe process with
 workqueue
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579081753-2839-1-git-send-email-liuyixian@huawei.com>
 <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
 <20200128200505.GB8107@ziepe.ca>
 <f4794cf0-e9db-540b-9752-761734edef5a@huawei.com>
 <20200205203040.GA25297@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <6b297785-b45d-c5b6-012f-b13cf36dacbd@huawei.com>
Date:   Thu, 6 Feb 2020 17:14:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20200205203040.GA25297@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/6 4:30, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 04:47:38PM +0800, Liuyixian (Eason) wrote:
>>
>>
>> On 2020/1/29 4:05, Jason Gunthorpe wrote:
>>> On Wed, Jan 15, 2020 at 05:49:13PM +0800, Yixian Liu wrote:
>>>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>>>> index fa38582..ad7ed07 100644
>>>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>>>> @@ -56,10 +56,16 @@ static void flush_work_handle(struct work_struct *work)
>>>>  	attr_mask = IB_QP_STATE;
>>>>  	attr.qp_state = IB_QPS_ERR;
>>>>  
>>>> -	ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
>>>> -	if (ret)
>>>> -		dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
>>>> -			ret);
>>>> +	while (atomic_read(&hr_qp->flush_cnt)) {
>>>> +		ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
>>>> +		if (ret)
>>>> +			dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
>>>> +				ret);
>>>> +
>>>> +		/* If flush_cnt larger than 1, only need one more time flush */
>>>> +		if (atomic_dec_and_test(&hr_qp->flush_cnt))
>>>> +			atomic_set(&hr_qp->flush_cnt, 1);
>>>> +	}
>>>
>>> And this while loop is just 
>>
>> There is a bug here, the code should be:
>> if (!atomic_dec_and_test(&hr_qp->flush_cnt))
>> 	atomic_set(&hr_qp->flush_cnt, 1);
>>
>> It merges all further flush operation requirements into only one more time flush,
>> that is, do the loop once again if flush_cnt larger than 1.
>>
>>>
>>> if (atomic_xchg(&hr_qp->flush_cnt, 0)) {
>>>   [..]
>>> }
>>
>> I think we can't use if instead of while loop.
> 
> Well, you can't do two operations and still have an atomic, so you
> have to fix it somehow. Possibly this needs a spinlock approach
> instead.

Agree.

> 
>> With your solution, when user posts a new wr during the
>> implementation of [...] in if condition, it will re-queue a new
>> init_flush_work, which will lead to a multiple call problem as we
>> discussed in v2.
> 
> queue_work can be called while a work is still running, it just makes
> sure it will run again.

Agree.

> 
>>> I'm not even sure this needs to be a counter, all you need is set_bit()
>>> and test_and_clear()
>>
>> We need the value of flush_cnt large than 1 to record further flush
>> requirements, that's why flush_cnt can be defined as a flag or bit
>> value.
> 
> This explanation doesn't make sense, the counter isn't being used to
> count anything, it is just a flag.

Yes, you are right. I have reconsidered the solution with your suggestion,
flag is enough for whole solution. Will fix it in v8 with flag idea.

Thanks a lot.

> 
> Jason
> 
> 

