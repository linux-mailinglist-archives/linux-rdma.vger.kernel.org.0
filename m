Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B092042DA26
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Oct 2021 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbhJNNVS (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Oct 2021 09:21:18 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28942 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhJNNVR (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Oct 2021 09:21:17 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HVVHN4dvDzbn14;
        Thu, 14 Oct 2021 21:14:40 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 21:19:09 +0800
Received: from [10.174.176.245] (10.174.176.245) by
 kwepemm600001.china.huawei.com (7.193.23.3) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Thu, 14 Oct 2021 21:19:08 +0800
Subject: Re: [PATCH] IB/cm: Fix possible use-after-free in ib_cm_cleanup()
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     <dledford@redhat.com>, <leon@kernel.org>, <markzhang@nvidia.com>,
        <liangwenpeng@huawei.com>, <liweihang@huawei.com>,
        <haakon.bugge@oracle.com>, <rolandd@cisco.com>,
        <sean.hefty@intel.com>, <linux-rdma@vger.kernel.org>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20211013093016.3869299-1-wanghai38@huawei.com>
 <20211013182448.GA3489723@nvidia.com>
From:   "wanghai (M)" <wanghai38@huawei.com>
Message-ID: <787f463c-85e9-c1f3-c772-1233e82a71b5@huawei.com>
Date:   Thu, 14 Oct 2021 21:19:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20211013182448.GA3489723@nvidia.com>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.176.245]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


ÔÚ 2021/10/14 2:24, Jason Gunthorpe Ð´µÀ:
> On Wed, Oct 13, 2021 at 05:30:16PM +0800, Wang Hai wrote:
>> This module's remove path calls cancel_delayed_work(). However, that
>> function does not wait until the work function finishes. This means
>> that the callback function may still be running after the driver's
>> remove function has finished, which would result in a use-after-free.
>>
>> Fix by calling cancel_delayed_work_sync(), which ensures that
>> the work is properly cancelled, no longer running, and unable
>> to re-schedule itself.
>>
>> Fixes: 8575329d4f85 ("IB/cm: Fix timewait crash after module unload")
>> Reported-by: Hulk Robot <hulkci@huawei.com>
>> Signed-off-by: Wang Hai <wanghai38@huawei.com>
>>   drivers/infiniband/core/cm.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>> index c903b74f46a4..ae0af63f3271 100644
>> +++ b/drivers/infiniband/core/cm.c
>> @@ -4508,7 +4508,7 @@ static void __exit ib_cm_cleanup(void)
>>   
>>   	spin_lock_irq(&cm.lock);
>>   	list_for_each_entry(timewait_info, &cm.timewait_list, list)
>> -		cancel_delayed_work(&timewait_info->work.work);
>> +		cancel_delayed_work_sync(&timewait_info->work.work);
>>   	spin_unlock_irq(&cm.lock);
> No, this will deadlock:
>
> static int cm_timewait_handler(struct cm_work *work)
> {
> 	struct cm_timewait_info *timewait_info;
> 	struct cm_id_private *cm_id_priv;
>
> 	timewait_info = container_of(work, struct cm_timewait_info, work);
> 	spin_lock_irq(&cm.lock);
>           ^^^^^^^^^^^^
>
> Holds the same lock
>
> What is your bug? The destroy_wq() a few lines below will flush out
> all the work so it is already not possible that work can still exist
> after the driver's remove function has finished.
>
> Jason
> .
Sorry, this is a wrong bugfix, thank you for pointing it out.

I was studying the code here and thought there might be a null
pointer reference problem.

You are right, I didn't take into account destroy_workqueue().
There are no bugs here. sorry for making this problematic patch.

Please ignore this patch.

-- 
Wang Hai

