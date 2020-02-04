Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9106E15172A
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2020 09:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgBDIrt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Feb 2020 03:47:49 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726053AbgBDIrt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 4 Feb 2020 03:47:49 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7D976BB677DC4DACC4DC;
        Tue,  4 Feb 2020 16:47:46 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 4 Feb 2020
 16:47:38 +0800
Subject: Re: [PATCH v7 for-next 2/2] RDMA/hns: Delayed flush cqe process with
 workqueue
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1579081753-2839-1-git-send-email-liuyixian@huawei.com>
 <1579081753-2839-3-git-send-email-liuyixian@huawei.com>
 <20200128200505.GB8107@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <f4794cf0-e9db-540b-9752-761734edef5a@huawei.com>
Date:   Tue, 4 Feb 2020 16:47:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20200128200505.GB8107@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/29 4:05, Jason Gunthorpe wrote:
> On Wed, Jan 15, 2020 at 05:49:13PM +0800, Yixian Liu wrote:
>> diff --git a/drivers/infiniband/hw/hns/hns_roce_qp.c b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> index fa38582..ad7ed07 100644
>> +++ b/drivers/infiniband/hw/hns/hns_roce_qp.c
>> @@ -56,10 +56,16 @@ static void flush_work_handle(struct work_struct *work)
>>  	attr_mask = IB_QP_STATE;
>>  	attr.qp_state = IB_QPS_ERR;
>>  
>> -	ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
>> -	if (ret)
>> -		dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
>> -			ret);
>> +	while (atomic_read(&hr_qp->flush_cnt)) {
>> +		ret = hns_roce_modify_qp(&hr_qp->ibqp, &attr, attr_mask, NULL);
>> +		if (ret)
>> +			dev_err(dev, "Modify QP to error state failed(%d) during CQE flush\n",
>> +				ret);
>> +
>> +		/* If flush_cnt larger than 1, only need one more time flush */
>> +		if (atomic_dec_and_test(&hr_qp->flush_cnt))
>> +			atomic_set(&hr_qp->flush_cnt, 1);
>> +	}
> 
> And this while loop is just 

There is a bug here, the code should be:
if (!atomic_dec_and_test(&hr_qp->flush_cnt))
	atomic_set(&hr_qp->flush_cnt, 1);

It merges all further flush operation requirements into only one more time flush,
that is, do the loop once again if flush_cnt larger than 1.

> 
> if (atomic_xchg(&hr_qp->flush_cnt, 0)) {
>   [..]
> }

I think we can't use if instead of while loop.
Our current solution can merge all further flush requirements after the inflection point
(the place of reading PI of SQ and RQ in hns_roce_modify_qp) into only one more time flush.
That is, the flush_cnt can be changed again by post send/recv at any place of the implementation
of hns_roce_modify_qp. We need one more time flush to update the PI of SQ and RQ.

With your solution, when user posts a new wr during the implementation of [...] in if condition,
it will re-queue a new init_flush_work, which will lead to a multiple call problem as we discussed
in v2.

> 
> I'm not even sure this needs to be a counter, all you need is set_bit()
> and test_and_clear()

We need the value of flush_cnt large than 1 to record further flush requirements, that's why
flush_cnt can be defined as a flag or bit value.


