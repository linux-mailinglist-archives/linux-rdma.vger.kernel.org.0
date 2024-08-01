Return-Path: <linux-rdma+bounces-4150-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2BF2944A75
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 13:34:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D6F01F232EB
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2024 11:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00FA318E036;
	Thu,  1 Aug 2024 11:34:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752AE18DF6B;
	Thu,  1 Aug 2024 11:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722512085; cv=none; b=OZWEeWqIyMxi2iwFg4ApYiyR/KvQgWCo8whnVw34NjKX1Qs+j8yS+DN8Zkc8YinOukQLLHp7eQBbkNjK6L2TKvaFsFuFWECMBsj1s7BHd/E/C1WBJ8aAWakevhWaqPEdeTe5hdYLlN3pJdFiaTwBSr4kRshjgRRM7Drr4sw+zsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722512085; c=relaxed/simple;
	bh=ZBGPGAnnSSo4MaKa7rOByKAwviaiY9jt7YJtmwzw2MM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=QvNkvfi4Lpma8hyB7LApL0FYVZjszZ0Ecpr9AD/XigKCH8h2N1BsSleWy1vpSaYtAp1BQlmvKcRRewGy4WSOr2Xz9IByCmmyvMhnKUEkVCXvZFjWrztOnblXrXL0/5+aKLOirN2IAjwLKv+7B06usTPthBkyGzy4eUVBa1e/e5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com; spf=pass smtp.mailfrom=hisilicon.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hisilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hisilicon.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WZRh36H8hzxVHV;
	Thu,  1 Aug 2024 19:34:27 +0800 (CST)
Received: from kwepemf100018.china.huawei.com (unknown [7.202.181.17])
	by mail.maildlp.com (Postfix) with ESMTPS id CD90914041B;
	Thu,  1 Aug 2024 19:34:40 +0800 (CST)
Received: from [10.67.120.168] (10.67.120.168) by
 kwepemf100018.china.huawei.com (7.202.181.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 1 Aug 2024 19:34:40 +0800
Message-ID: <f5da09d7-30f9-198f-84ac-5c73e2925f6f@hisilicon.com>
Date: Thu, 1 Aug 2024 19:34:39 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.0
Subject: Re: [PATCH for-rc] RDMA/srpt: Fix UAF when srpt_add_one() failed
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>
CC: <jgg@ziepe.ca>, <bvanassche@acm.org>, <nab@risingtidesystems.com>,
	<linux-rdma@vger.kernel.org>, <linuxarm@huawei.com>,
	<linux-kernel@vger.kernel.org>, <target-devel@vger.kernel.org>
References: <20240801074415.1033323-1-huangjunxian6@hisilicon.com>
 <20240801103712.GG4209@unreal>
 <bcbc57ba-3e54-cfe5-60b8-8f3990f40000@hisilicon.com>
 <20240801113055.GH4209@unreal>
From: Junxian Huang <huangjunxian6@hisilicon.com>
In-Reply-To: <20240801113055.GH4209@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100018.china.huawei.com (7.202.181.17)



On 2024/8/1 19:30, Leon Romanovsky wrote:
> On Thu, Aug 01, 2024 at 07:02:41PM +0800, Junxian Huang wrote:
>>
>>
>> On 2024/8/1 18:37, Leon Romanovsky wrote:
>>> On Thu, Aug 01, 2024 at 03:44:15PM +0800, Junxian Huang wrote:
>>>> Currently cancel_work_sync() is not called when srpt_refresh_port()
>>>> failed in srpt_add_one(). There is a probability that sdev has been
>>>> freed while the previously initiated sport->work is still running,
>>>> leading to a UAF as the log below:
>>>>
>>>> [  T880] ib_srpt MAD registration failed for hns_1-1.
>>>> [  T880] ib_srpt srpt_add_one(hns_1) failed.
>>>> [  T376] Unable to handle kernel paging request at virtual address 0000000000010008
>>>> ...
>>>> [  T376] Workqueue: events srpt_refresh_port_work [ib_srpt]
>>>> ...
>>>> [  T376] Call trace:
>>>> [  T376]  srpt_refresh_port+0x94/0x264 [ib_srpt]
>>>> [  T376]  srpt_refresh_port_work+0x1c/0x2c [ib_srpt]
>>>> [  T376]  process_one_work+0x1d8/0x4cc
>>>> [  T376]  worker_thread+0x158/0x410
>>>> [  T376]  kthread+0x108/0x13c
>>>> [  T376]  ret_from_fork+0x10/0x18
>>>>
>>>> Add cancel_work_sync() to the exception branch to fix this UAF.
>>>>
>>>> Fixes: a42d985bd5b2 ("ib_srpt: Initial SRP Target merge for v3.3-rc1")
>>>> Signed-off-by: Junxian Huang <huangjunxian6@hisilicon.com>
>>>> ---
>>>>  drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +++--
>>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/ulp/srpt/ib_srpt.c b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> index 9632afbd727b..244e5c115bf7 100644
>>>> --- a/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> +++ b/drivers/infiniband/ulp/srpt/ib_srpt.c
>>>> @@ -3148,8 +3148,8 @@ static int srpt_add_one(struct ib_device *device)
>>>>  {
>>>>  	struct srpt_device *sdev;
>>>>  	struct srpt_port *sport;
>>>> +	u32 i, j;
>>>>  	int ret;
>>>> -	u32 i;
>>>>  
>>>>  	pr_debug("device = %p\n", device);
>>>>  
>>>> @@ -3226,7 +3226,6 @@ static int srpt_add_one(struct ib_device *device)
>>>>  		if (ret) {
>>>>  			pr_err("MAD registration failed for %s-%d.\n",
>>>>  			       dev_name(&sdev->device->dev), i);
>>>> -			i--;
>>>>  			goto err_port;
>>>>  		}
>>>>  	}
>>>> @@ -3241,6 +3240,8 @@ static int srpt_add_one(struct ib_device *device)
>>>>  	return 0;
>>>>  
>>>>  err_port:
>>>> +	for (j = i, i--; j > 0; j--)a
>>>> +		cancel_work_sync(&sdev->port[j - 1].work);
>>>
>>> There is no need in extra variable, the following code will do the same:
>>>
>>> 	while (i--)
>>> 		cancel_work_sync(&sdev->port[i].work);
>>>
>>>>  	srpt_unregister_mad_agent(sdev, i);
>>
>> i is also used here.
> 
> So put cancel_work_sync() there.
> 
> Thanks
> 

Sure.

Junxian

>>
>> Junxian
>>
>>>>  err_cm:
>>>>  	if (sdev->cm_id)
>>>> -- 
>>>> 2.33.0
>>>>
>>>
>>

