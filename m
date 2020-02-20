Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FA3016562F
	for <lists+linux-rdma@lfdr.de>; Thu, 20 Feb 2020 05:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbgBTETG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 Feb 2020 23:19:06 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:59194 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727576AbgBTETG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 Feb 2020 23:19:06 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 072A283B730D04613DD4;
        Thu, 20 Feb 2020 12:19:01 +0800 (CST)
Received: from [127.0.0.1] (10.40.203.251) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 12:18:53 +0800
Subject: Re: [PATCH RFC v2 for-next 3/7] qede: remove invalid notify operation
To:     Jason Gunthorpe <jgg@ziepe.ca>, Weihang Li <liweihang@huawei.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>,
        <linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>
References: <20200204082408.18728-1-liweihang@huawei.com>
 <20200204082408.18728-4-liweihang@huawei.com>
 <20200219210425.GA31668@ziepe.ca>
From:   Lang Cheng <chenglang@huawei.com>
Message-ID: <a7f16048-b1f4-9071-6780-680c159d124a@huawei.com>
Date:   Thu, 20 Feb 2020 12:18:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200219210425.GA31668@ziepe.ca>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.40.203.251]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2020/2/20 5:04, Jason Gunthorpe wrote:
> On Tue, Feb 04, 2020 at 04:24:04PM +0800, Weihang Li wrote:
>> From: Lang Cheng <chenglang@huawei.com>
>>
>> The qedr notify() will remove the processing of QEDE_UP and QEDE_DOWN,
>> so qede no more needs to notify rdma of these two events.
>>
>> Signed-off-by: Lang Cheng <chenglang@huawei.com>
>>   drivers/net/ethernet/qlogic/qede/qede_rdma.c | 4 ----
>>   1 file changed, 4 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/qlogic/qede/qede_rdma.c b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
>> index ffabc2d..0493279 100644
>> +++ b/drivers/net/ethernet/qlogic/qede/qede_rdma.c
>> @@ -145,8 +145,6 @@ void qede_rdma_dev_remove(struct qede_dev *edev, bool recovery)
>>   
>>   static void _qede_rdma_dev_open(struct qede_dev *edev)
>>   {
>> -	if (qedr_drv && edev->rdma_info.qedr_dev && qedr_drv->notify)
>> -		qedr_drv->notify(edev->rdma_info.qedr_dev, QEDE_UP);
>>   }
>>   
>>   static void qede_rdma_dev_open(struct qede_dev *edev)
>> @@ -161,8 +159,6 @@ static void qede_rdma_dev_open(struct qede_dev *edev)
>>   
>>   static void _qede_rdma_dev_close(struct qede_dev *edev)
>>   {
>> -	if (qedr_drv && edev->rdma_info.qedr_dev && qedr_drv->notify)
>> -		qedr_drv->notify(edev->rdma_info.qedr_dev, QEDE_DOWN);
>>   }
> 
> Leaving empty functions behind? Why?
Remove these empty static functions.
> 
> I'm getting the feeling that this series is inside out or
> backwards something. This change should not happen until the rdma
> driver stops consuming these events
> 
"RDMA/qedr: remove deliver net device event" should be in front of 
"qede: remove invalid notify operation".

Exchange 3/7 and 4/7.

thanks.

> Jason
> 

