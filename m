Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DBC37B41E
	for <lists+linux-rdma@lfdr.de>; Wed, 12 May 2021 04:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbhELCSk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 22:18:40 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2709 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhELCSk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 May 2021 22:18:40 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Ffyzb4pLFz1BLc3;
        Wed, 12 May 2021 10:14:51 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.72) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.498.0; Wed, 12 May 2021
 10:17:29 +0800
Subject: Re: [PATCH 1/1] RDMA/cm: Delete two redundant condition branches
From:   "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To:     Jason Gunthorpe <jgg@nvidia.com>
CC:     Doug Ledford <dledford@redhat.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
References: <20210510090840.3474-1-thunder.leizhen@huawei.com>
 <20210511195621.GA1317703@nvidia.com>
 <134c59d1-82d0-05c9-b5c5-f6a053fe234f@huawei.com>
Message-ID: <b9e41b3b-a68e-f423-e1f8-49a927c3ef7b@huawei.com>
Date:   Wed, 12 May 2021 10:17:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <134c59d1-82d0-05c9-b5c5-f6a053fe234f@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.72]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org



On 2021/5/12 9:35, Leizhen (ThunderTown) wrote:
> 
> 
> On 2021/5/12 3:56, Jason Gunthorpe wrote:
>> On Mon, May 10, 2021 at 05:08:40PM +0800, Zhen Lei wrote:
>>> The statement of the last "if (xxx)" branch is the same as the "else"
>>> branch. Delete it to simplify code.
>>>
>>> No functional change.
>>>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  drivers/infiniband/core/cm.c | 4 ----
>>>  1 file changed, 4 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/cm.c b/drivers/infiniband/core/cm.c
>>> index 0ead0d223154011..510beb25f5b8a0b 100644
>>> --- a/drivers/infiniband/core/cm.c
>>> +++ b/drivers/infiniband/core/cm.c
>>> @@ -668,8 +668,6 @@ static struct cm_id_private *cm_insert_listen(struct cm_id_private *cm_id_priv,
>>>  			link = &(*link)->rb_right;
>>>  		else if (be64_lt(service_id, cur_cm_id_priv->id.service_id))
>>>  			link = &(*link)->rb_left;
>>> -		else if (be64_gt(service_id, cur_cm_id_priv->id.service_id))
>>> -			link = &(*link)->rb_right;
>>>  		else
>>>  			link = &(*link)->rb_right;
>>>  	}
>>> @@ -700,8 +698,6 @@ static struct cm_id_private *cm_find_listen(struct ib_device *device,
>>>  			node = node->rb_right;
>>>  		else if (be64_lt(service_id, cm_id_priv->id.service_id))
>>>  			node = node->rb_left;
>>> -		else if (be64_gt(service_id, cm_id_priv->id.service_id))
>>> -			node = node->rb_right;
>>>  		else
>>>  			node = node->rb_right;
>>>  	}
>>
>> I don't like this, if you want to reorganize this function then it
>> should be written in the normal pattern for this kind of comparision
>>
>>  if (a < b)
>>    ..
>>  else if (a > b)
>>    ..
>>  else // a == b
>>    ..
>>
>> You can see the a==b clause written explicitly above this if ladder:
>>
>> 		if ((cur_cm_id_priv->id.service_mask & service_id) ==
>> 		    (service_mask & cur_cm_id_priv->id.service_id) &&
>> 		    (cm_id_priv->id.device == cur_cm_id_priv->id.device)) {
> 
> Right，So we'd better rewrite it with this set of judgments. This is because
> the judgment of (a < b) and (a > b) is performed N times before the judgment
> of (a == b) is performed. Therefore, the above modification you mentioned can
> improve the search performance.

This modification may have to be patched separately. Combined with one patch, the description is unclear.

> 
>>
>> Which is why the trailing else is just unexectuable code.
>>
>> Jason
>>
>> .
>>

