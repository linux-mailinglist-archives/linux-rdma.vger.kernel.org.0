Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D282F0BF3
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 03:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730274AbfKFCRa (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 5 Nov 2019 21:17:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:5730 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730231AbfKFCRa (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 5 Nov 2019 21:17:30 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 06619B993E7B5F10C34A;
        Wed,  6 Nov 2019 10:17:29 +0800 (CST)
Received: from [127.0.0.1] (10.74.223.196) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.439.0; Wed, 6 Nov 2019
 10:17:19 +0800
Subject: Re: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
To:     Parav Pandit <parav@mellanox.com>,
        "dledford@redhat.com" <dledford@redhat.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "leon@kernel.org" <leon@kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
References: <1572925690-7336-1-git-send-email-liuyixian@huawei.com>
 <AM0PR05MB4866B3612F0AE576136EED94D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <a0053ce9-7b16-2d10-0f5c-37ee4771a1ea@huawei.com>
 <AM0PR05MB48667BDE7D8E4A74958F0FA0D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
From:   "Liuyixian (Eason)" <liuyixian@huawei.com>
Message-ID: <780a6168-a5ae-5158-ab57-a3ff1e5a80eb@huawei.com>
Date:   Wed, 6 Nov 2019 10:15:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.1
MIME-Version: 1.0
In-Reply-To: <AM0PR05MB48667BDE7D8E4A74958F0FA0D17E0@AM0PR05MB4866.eurprd05.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.74.223.196]
X-CFilter-Loop: Reflected
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2019/11/5 23:02, Parav Pandit wrote:
> 
> 
>> -----Original Message-----
>> From: Liuyixian (Eason) <liuyixian@huawei.com>
>> Sent: Tuesday, November 5, 2019 1:55 AM
>> To: Parav Pandit <parav@mellanox.com>; dledford@redhat.com;
>> jgg@ziepe.ca
>> Cc: leon@kernel.org; linux-rdma@vger.kernel.org; linuxarm@huawei.com
>> Subject: Re: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
>>
>>
>>
>> On 2019/11/5 12:09, Parav Pandit wrote:
>>> Hi Yixian Liu,
>>>
>>>> -----Original Message-----
>>>> From: linux-rdma-owner@vger.kernel.org <linux-rdma-
>>>> owner@vger.kernel.org> On Behalf Of Yixian Liu
>>>> Sent: Monday, November 4, 2019 9:48 PM
>>>> To: dledford@redhat.com; jgg@ziepe.ca
>>>> Cc: Parav Pandit <parav@mellanox.com>; leon@kernel.org; linux-
>>>> rdma@vger.kernel.org; linuxarm@huawei.com
>>>> Subject: [PATCH rdma-next] RDMA/core: Use pr_warn_ratelimited
>>>>
>>>> This warning can be triggered easily when adding a large number of
>>>> VLANs while the capacity of GID table is small.
>>>>
>>>> Fixes: 598ff6bae689 ("IB/core: Refactor GID modify code for RoCE")
>>>> Signed-off-by: Yixian Liu <liuyixian@huawei.com>
>>>> ---
>>>>  drivers/infiniband/core/cache.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>> Thanks for the patch. However, vlan netdevice addition is an
>> administrative operation allowed to process which has CAP_NET_ADMIN
>> privilege.
>>> So large number of VLAN addition by a user for a RoCE device whose GID
>> capacity is small is constrained operation.
>>
>> How can we constrain this operation from an administrator?
>>
> Administrator knows the GID table size of the RoCE device he is managing.
> 
>>> Therefore, we shouldn't be rate limiting it.
>>> By rate limiting we miss the information about any bugs in GID cache
>> management.
>>
>> pr_warn_ratelimited only prevent from printing **the same messages**
>> frequently, why information will be lost?
>>
> Same message that may have different GID value and return code.
> So information is lost on why GID entry was not able to add (error by vendor driver, no space in table, something else etc).
> 
>  
>>> At best we can convert it to dev_dbg() so that we still get the necessary
>> debug information when needed.
>>> I wanted to convert them trace functions which will allow us to more
>> debug level prints such as netdev name, vlan etc.
>>> I think I remember comment from Leon too while working on it, but it was
>> long haul that time.
>>>
>>> Its base infrastructure is just got ready with Chuck Lever's patch.
>>> So around 5.5, I should convert to trace calls.
>>
>> Okay, whatever, the situation described in commit message may be
>> occurred, please consider it.
>>
> Yes. sure. Added to my todo list.

Thanks.

>  
>>>
>>>> diff --git a/drivers/infiniband/core/cache.c
>>>> b/drivers/infiniband/core/cache.c index 00fb3ea..2990075 100644
>>>> --- a/drivers/infiniband/core/cache.c
>>>> +++ b/drivers/infiniband/core/cache.c
>>>> @@ -579,8 +579,8 @@ static int __ib_cache_gid_add(struct ib_device
>>>> *ib_dev, u8 port,
>>>>  out_unlock:
>>>>  	mutex_unlock(&table->lock);
>>>>  	if (ret)
>>>> -		pr_warn("%s: unable to add gid %pI6 error=%d\n",
>>>> -			__func__, gid->raw, ret);
>>>> +		pr_warn_ratelimited("%s: unable to add gid %pI6
>>>> error=%d\n",
>>>> +				    __func__, gid->raw, ret);
>>>>  	return ret;
>>>>  }
>>>>
>>>> --
>>>> 2.7.4
>>>
>>>
>>>
> 

