Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE58AE3E5
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Sep 2019 08:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403928AbfIJGkh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Sep 2019 02:40:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2199 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403926AbfIJGkh (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Sep 2019 02:40:37 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 03C2B8F854BC91F49AA9;
        Tue, 10 Sep 2019 14:40:30 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Tue, 10 Sep 2019
 14:40:21 +0800
Subject: Re: [PATCH for-next] RDMA/hns: Bugfix for flush cqe in case softirq
 and multi-process
To:     Leon Romanovsky <leon@kernel.org>,
        Weihang Li <liweihang@hisilicon.com>
CC:     <linux-rdma@vger.kernel.org>, <jgg@ziepe.ca>,
        <dledford@redhat.com>, <linuxarm@huawei.com>
References: <1567686671-4331-1-git-send-email-liweihang@hisilicon.com>
 <20190908080303.GC26697@unreal>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <f8f29a6a-b473-6c89-8ec7-092fd53aea16@huawei.com>
Date:   Tue, 10 Sep 2019 14:40:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <20190908080303.GC26697@unreal>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/9/8 16:03, Leon Romanovsky wrote:
> On Thu, Sep 05, 2019 at 08:31:11PM +0800, Weihang Li wrote:
>> From: Yixian Liu <liuyixian@huawei.com>
>>
>> Hip08 has the feature flush cqe, which help to flush wqe in workqueue
>> (sq and rq) when error happened by transmitting producer index with
>> mailbox to hardware. Flush cqe is emplemented in post send and recv
>> verbs. However, under NVMe cases, these verbs will be called under
>> softirq context, and it will lead to following calltrace with
>> current driver as mailbox used by flush cqe can go to sleep.
>>
>> This patch solves this problem by using workqueue to do flush cqe,
> 
> Unbelievable, almost every bug in this driver is solved by introducing
> workqueue. You should fix "sleep in flush path" issue and not by adding
> new workqueue.
> 
Hi Leon,

Thanks for the comment.
Up to now, for hip08, only one place use workqueue in hns_roce_hw_v2.c
where for irq prints.

The solution for flush cqe in this patch is as follow:
While flush cqe should be implement, the driver should modify qp to error state
through mailbox with the newest product index of sq and rq, the hardware then
can flush all outstanding wqes in sq and rq.

That's the whole mechanism of flush cqe, also is the flush path. We can't
change neither mailbox sleep attribute or flush cqe occurred in post send/recv.
To avoid the calltrace of flush cqe in post verbs under NVMe softirq,
use workqueue for flush cqe seems reasonable.

As far as I know, there is no other alternative solution for this situation.
I will be very grateful if you reminder me more information.

Thanks

> _______________________________________________
> Linuxarm mailing list
> Linuxarm@huawei.com
> http://hulk.huawei.com/mailman/listinfo/linuxarm
> 
> 

