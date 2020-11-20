Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4B2B9FFD
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Nov 2020 02:53:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbgKTBvT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Nov 2020 20:51:19 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8123 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726365AbgKTBvT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 19 Nov 2020 20:51:19 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Ccfdr1PC6zLqcx;
        Fri, 20 Nov 2020 09:50:56 +0800 (CST)
Received: from [10.174.177.160] (10.174.177.160) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 20 Nov 2020 09:51:12 +0800
Subject: Re: [PATCH] IB/mthca: fix return value of error branch in
 mthca_init_cq()
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <dledford@redhat.com>, <linux-rdma@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <1605789529-54808-1-git-send-email-wangxiongfeng2@huawei.com>
 <20201119153050.GA1960484@nvidia.com>
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
Message-ID: <c108c895-b7f2-af71-51a5-f34bcfa17825@huawei.com>
Date:   Fri, 20 Nov 2020 09:51:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20201119153050.GA1960484@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.160]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi, Jason

Thanks for your reply !

On 2020/11/19 23:30, Jason Gunthorpe wrote:
> On Thu, Nov 19, 2020 at 08:38:49PM +0800, Xiongfeng Wang wrote:
>> We return 'err' in the error branch, but this variable may be set as
>> zero by the above code. Fix it by setting 'err'  as a negative value
>> before we goto the error label.
>>
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> 
> Missing fixes line
> 
>>  drivers/infiniband/hw/mthca/mthca_cq.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/hw/mthca/mthca_cq.c b/drivers/infiniband/hw/mthca/mthca_cq.c
>> index c3cfea2..98d697b 100644
>> --- a/drivers/infiniband/hw/mthca/mthca_cq.c
>> +++ b/drivers/infiniband/hw/mthca/mthca_cq.c
>> @@ -803,8 +803,10 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
>>  	}
>>  
>>  	mailbox = mthca_alloc_mailbox(dev, GFP_KERNEL);
>> -	if (IS_ERR(mailbox))
>> +	if (IS_ERR(mailbox)) {
>> +		err = -ENOMEM;
>>  		goto err_out_arm;
>> +	}
> 
> mthca_alloc_mailbox returns err_ptr so this should do 
> 
>    err = ERR_PTR(mailbox)

Is it PTR_ERR here ?
Since mailbox is a pointer.

> 
>>  	cq_context = mailbox->buf;
>>  
>> @@ -850,6 +852,7 @@ int mthca_init_cq(struct mthca_dev *dev, int nent,
>>  			    cq->cqn & (dev->limits.num_cqs - 1),
>>  			    cq)) {
>>  		spin_unlock_irq(&dev->cq_table.lock);
>> +		err = -ENOMEM;
> 
> And this should assign err to the output of mthca_array_set
> 
> Please fix and resend.

Sure.

Thanks,
Xiongfeng

> 
> Thanks,
> Jason
> 
