Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79B47B89D2
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2019 05:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407259AbfITD4K (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 19 Sep 2019 23:56:10 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2683 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404238AbfITD4K (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 19 Sep 2019 23:56:10 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 50868AC2C18A2635B9A6;
        Fri, 20 Sep 2019 11:56:07 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Fri, 20 Sep 2019
 11:55:57 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Bugfix for flush cqe in case softirq
 and multi-process
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
To:     Leon Romanovsky <leon@kernel.org>
CC:     <linux-rdma@vger.kernel.org>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <linuxarm@huawei.com>
References: <1567686671-4331-1-git-send-email-liweihang@hisilicon.com>
 <20190908080303.GC26697@unreal>
 <f8f29a6a-b473-6c89-8ec7-092fd53aea16@huawei.com>
 <20190910075216.GX6601@unreal>
 <94ad1f56-afc6-ec78-4aa2-85d03c644031@huawei.com>
Message-ID: <0d4ce391-6619-783d-55a8-fa2524af7b9c@huawei.com>
Date:   Fri, 20 Sep 2019 11:55:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <94ad1f56-afc6-ec78-4aa2-85d03c644031@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/9/11 21:17, Liuyixian (Eason) wrote:
> 
> 
> On 2019/9/10 15:52, Leon Romanovsky wrote:
>> On Tue, Sep 10, 2019 at 02:40:20PM +0800, Liuyixian (Eason) wrote:
>>>
>>>
>>> On 2019/9/8 16:03, Leon Romanovsky wrote:
>>>> On Thu, Sep 05, 2019 at 08:31:11PM +0800, Weihang Li wrote:
>>>>> From: Yixian Liu <liuyixian@huawei.com>
>>>>>
>>>>> Hip08 has the feature flush cqe, which help to flush wqe in workqueue
>>>>> (sq and rq) when error happened by transmitting producer index with
>>>>> mailbox to hardware. Flush cqe is emplemented in post send and recv
>>>>> verbs. However, under NVMe cases, these verbs will be called under
>>>>> softirq context, and it will lead to following calltrace with
>>>>> current driver as mailbox used by flush cqe can go to sleep.
>>>>>
>>>>> This patch solves this problem by using workqueue to do flush cqe,
>>>>
>>>> Unbelievable, almost every bug in this driver is solved by introducing
>>>> workqueue. You should fix "sleep in flush path" issue and not by adding
>>>> new workqueue.
>>>>
>>> Hi Leon,
>>>
>>> Thanks for the comment.
>>> Up to now, for hip08, only one place use workqueue in hns_roce_hw_v2.c
>>> where for irq prints.
>>
>> Thanks to our lack of desire to add more workqueues and previous patches
>> which removed extra workqueues from the driver.
>>
> Thanks, I see.
> 
>>>
>>> The solution for flush cqe in this patch is as follow:
>>> While flush cqe should be implement, the driver should modify qp to error state
>>> through mailbox with the newest product index of sq and rq, the hardware then
>>> can flush all outstanding wqes in sq and rq.
>>>
>>> That's the whole mechanism of flush cqe, also is the flush path. We can't
>>> change neither mailbox sleep attribute or flush cqe occurred in post send/recv.
>>> To avoid the calltrace of flush cqe in post verbs under NVMe softirq,
>>> use workqueue for flush cqe seems reasonable.
>>>
>>> As far as I know, there is no other alternative solution for this situation.
>>> I will be very grateful if you reminder me more information.
>>
>> ib_drain_rq/ib_drain_sq/ib_drain_qp????
>>
> Hi Leon,
> 
> I think these interfaces are designed for application to check that all wqes
> have been processed by hardware, so called drain or flush. However, it is not
> the same as the flush in this patch. The solution in this patch is used
> to help the hardware generate flush cqes for outstanding wqes while qp error.
> 
Hi Leon,

What's your opinion about above? Do you have any further comments?

Thanks.

>>>
>>> Thanks
>>>
>>>> _______________________________________________
>>>> Linuxarm mailing list
>>>> Linuxarm@huawei.com
>>>> http://hulk.huawei.com/mailman/listinfo/linuxarm
>>>>
>>>>
>>>
>>
>> .
>>
> 
> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
> 
> .
> 

