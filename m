Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC113BC90
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Jan 2020 10:40:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729442AbgAOJkF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Jan 2020 04:40:05 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:40734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729406AbgAOJkF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Jan 2020 04:40:05 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 176D6F51066FB148731D;
        Wed, 15 Jan 2020 17:40:03 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Wed, 15 Jan 2020
 17:39:56 +0800
Subject: Re: [PATCH v5 for-next 1/2] RDMA/hns: Add the workqueue framework for
 flush cqe handler
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <1577503735-26685-1-git-send-email-liuyixian@huawei.com>
 <1577503735-26685-2-git-send-email-liuyixian@huawei.com>
 <20200110152602.GC8765@ziepe.ca>
 <65fb928c-5f85-02f9-c5ac-06037b3fe967@huawei.com>
 <20200113140442.GA9861@ziepe.ca>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <65f1590e-588a-3678-dc50-217a3affa8ab@huawei.com>
Date:   Wed, 15 Jan 2020 17:39:55 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20200113140442.GA9861@ziepe.ca>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/1/13 22:04, Jason Gunthorpe wrote:
> On Mon, Jan 13, 2020 at 07:26:45PM +0800, Liuyixian (Eason) wrote:
>>
>>
>> On 2020/1/10 23:26, Jason Gunthorpe wrote:
>>> On Sat, Dec 28, 2019 at 11:28:54AM +0800, Yixian Liu wrote:
>>>> +void init_flush_work(struct hns_roce_dev *hr_dev, struct hns_roce_qp *hr_qp)
>>>> +{
>>>> +	struct hns_roce_work *flush_work;
>>>> +
>>>> +	flush_work = kzalloc(sizeof(struct hns_roce_work), GFP_ATOMIC);
>>>> +	if (!flush_work)
>>>> +		return;
>>>
>>> You changed it to only queue once, so why do we need the allocation
>>> now? That was the whole point..
>>
>> Hi Jason,
>>
>> The flush work is queued **not only once**. As the flag being_pushed is set to 0 during
>> the process of modifying qp like this:
>> 	hns_roce_v2_modify_qp {
>> 		...
>> 		if (new_state == IB_QPS_ERR) {
>> 			spin_lock_irqsave(&hr_qp->sq.lock, sq_flag);
>> 			...
>> 			hr_qp->state = IB_QPS_ERR;
>> 			hr_qp->being_push = 0;
>> 			...
>> 		}
>> 		...
>> 	}
>> which means the new updated PI value needs to be updated with initializing a new flush work.
>> Thus, maybe there are two flush work in the workqueue. Thus, we still need the allocation here.
> 
> I don't see how you should get two? One should be pending until the
> modify is done with the new PI, then once the PI is updated the same
> one should be re-queued the next time the PI needs changing.
> 
Hi Jason,

Thanks! I will fix it according to your suggestion in V7.


