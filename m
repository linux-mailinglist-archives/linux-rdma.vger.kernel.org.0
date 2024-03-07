Return-Path: <linux-rdma+bounces-1315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C72948751A8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 15:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C88C286EE8
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Mar 2024 14:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01C712DD9F;
	Thu,  7 Mar 2024 14:18:10 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158C312DD85;
	Thu,  7 Mar 2024 14:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709821090; cv=none; b=MWibRsrsvCPssqyOvLgQvhsVqoYWeQHEkH9lHHw0uFyln7FIknUQOl5o82aANQ3+/2SfPSDkHf2OSRvs0ui4o2EpXfdvEyKTZcYx8+R7JgUlsi2eAr9nU/Pa2PZBtuMQCe2NPU8gq8iFkJtcw6yteT2BX3TMBjSGhKUKn5VAnXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709821090; c=relaxed/simple;
	bh=KXDYJsIENlq93snFXGmcNBn+jCvgC+BX+tYksxyFvhQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YAbMc8BMx+0oRKRx+fPYQg7wJixTK8rdPiVcO3S0jPHFLFuOASW9XRAFta1nusWIiN+/JL1nZswGG4rGliudz+FB0aXMYLf9eyW+7c9xVjVhzlLIOiYtXeViBZFkCVM4NXKv4P2nJu3xqvyx7BfRj8TAOzqwiSMs+AtoK2z3csI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TrBCy0dsRzwPF5;
	Thu,  7 Mar 2024 22:15:42 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id CEB54140F4F;
	Thu,  7 Mar 2024 22:18:00 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Mar 2024 22:18:00 +0800
Message-ID: <c84561e1-0fc5-4381-961f-a246b577938f@huawei.com>
Date: Thu, 7 Mar 2024 22:17:59 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] RDMA/restrack: Fix potential invalid address access
To: Leon Romanovsky <leon@kernel.org>
CC: Jason Gunthorpe <jgg@ziepe.ca>, <linux-rdma@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240301095514.3598280-1-haowenchao2@huawei.com>
 <20240307091317.GA8392@unreal>
Content-Language: en-US
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20240307091317.GA8392@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/3/7 17:13, Leon Romanovsky wrote:
> On Fri, Mar 01, 2024 at 05:55:15PM +0800, Wenchao Hao wrote:
>> struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
>> in ib_create_cq(), while if the module exited but forgot del this
>> rdma_restrack_entry, it would cause a invalid address access in
>> rdma_restrack_clean() when print the owner of this rdma_restrack_entry.
>>
>> Fix this issue by using kstrdup() to set rdma_restrack_entry's
>> kern_name.
> 
> I don't like kstrdup() and would like to avoid it, this rdma_restrack_clean()
> is purely for debugging and for a long time all upstream ULPs are "clean"
> from these not-released bugs.
> 
> So my suggestion is to delete that part of code and it will be good enough.
> 

It's OK for me. When found this issue, my first plan is to remove the code, but
I do not know why these code is added, so decide to using kstrdup() to work around
it.

Then what to do next? Do I need to post another patch or you would fix it by yourself?

> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> index 01a499a8b88d..27727138f188 100644
> --- a/drivers/infiniband/core/restrack.c
> +++ b/drivers/infiniband/core/restrack.c
> @@ -60,47 +60,14 @@ static const char *type2str(enum rdma_restrack_type type)
>   void rdma_restrack_clean(struct ib_device *dev)
>   {
>   	struct rdma_restrack_root *rt = dev->res;
> -	struct rdma_restrack_entry *e;
> -	char buf[TASK_COMM_LEN];
> -	bool found = false;
> -	const char *owner;
>   	int i;
>   
>   	for (i = 0 ; i < RDMA_RESTRACK_MAX; i++) {
>   		struct xarray *xa = &dev->res[i].xa;
>   
> -		if (!xa_empty(xa)) {
> -			unsigned long index;
> -
> -			if (!found) {
> -				pr_err("restrack: %s", CUT_HERE);
> -				dev_err(&dev->dev, "BUG: RESTRACK detected leak of resources\n");
> -			}
> -			xa_for_each(xa, index, e) {
> -				if (rdma_is_kernel_res(e)) {
> -					owner = e->kern_name;
> -				} else {
> -					/*
> -					 * There is no need to call get_task_struct here,
> -					 * because we can be here only if there are more
> -					 * get_task_struct() call than put_task_struct().
> -					 */
> -					get_task_comm(buf, e->task);
> -					owner = buf;
> -				}
> -
> -				pr_err("restrack: %s %s object allocated by %s is not freed\n",
> -				       rdma_is_kernel_res(e) ? "Kernel" :
> -							       "User",
> -				       type2str(e->type), owner);
> -			}
> -			found = true;
> -		}
> +		WARN_ON(!xa_empty(xa));
>   		xa_destroy(xa);
>   	}
> -	if (found)
> -		pr_err("restrack: %s", CUT_HERE);
> -
>   	kfree(rt);
>   }
>   
> 
>>
>> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
>> ---
>>   drivers/infiniband/core/restrack.c | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
>> index 01a499a8b88d..6605011c4edc 100644
>> --- a/drivers/infiniband/core/restrack.c
>> +++ b/drivers/infiniband/core/restrack.c
>> @@ -177,7 +177,8 @@ static void rdma_restrack_attach_task(struct rdma_restrack_entry *res,
>>   void rdma_restrack_set_name(struct rdma_restrack_entry *res, const char *caller)
>>   {
>>   	if (caller) {
>> -		res->kern_name = caller;
>> +		kfree(res->kern_name);
>> +		res->kern_name = kstrdup(caller, GFP_KERNEL);
>>   		return;
>>   	}
>>   
>> @@ -195,7 +196,7 @@ void rdma_restrack_parent_name(struct rdma_restrack_entry *dst,
>>   			       const struct rdma_restrack_entry *parent)
>>   {
>>   	if (rdma_is_kernel_res(parent))
>> -		dst->kern_name = parent->kern_name;
>> +		dst->kern_name = kstrdup(parent->kern_name, GFP_KERNEL);
>>   	else
>>   		rdma_restrack_attach_task(dst, parent->task);
>>   }
>> @@ -306,6 +307,7 @@ static void restrack_release(struct kref *kref)
>>   		put_task_struct(res->task);
>>   		res->task = NULL;
>>   	}
>> +	kfree(res->kern_name);
>>   	complete(&res->comp);
>>   }
>>   
>> -- 
>> 2.32.0
>>


