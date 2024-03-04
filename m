Return-Path: <linux-rdma+bounces-1198-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C18086F8DB
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 04:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDD8B1F2149B
	for <lists+linux-rdma@lfdr.de>; Mon,  4 Mar 2024 03:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBF3D6D;
	Mon,  4 Mar 2024 03:21:43 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1284688;
	Mon,  4 Mar 2024 03:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709522503; cv=none; b=WJsU1/g0QDXprEguzgCWFsOlkSoJvYe71y3ZLTXPh7SaphKfVePYHjBW3V2I2lIF4AJy45t0btCLfMVVnibh/tucjYqSaec7wjGptp8TdZmLzJKdsNL7ke7KUYQSdV7JYhEwJYmFo0pmIkipGzzV830V2oH1M+y9BWelFdmzt6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709522503; c=relaxed/simple;
	bh=N2l4Fs5hXrcVqwfcD1WSV5rE9juV2u+G8MIDGqfCf3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=qJwMyhmPRK2zLfU5HJoWry/R0HhfKYIKmZtyTPPx1bPnLYpBNjIFr6gArrjcEh6G6InzT46ZegUUHgps8xnVPffTYowDcIxj52INz5uOMYBE+JEayYXeMffpDU4lNxJ2sxG4QswnK88nL7WIubKIkAU5pS9ExkQcnfssCfmHmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tp3ph3G9fz1xq2D;
	Mon,  4 Mar 2024 11:19:56 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (unknown [7.193.23.74])
	by mail.maildlp.com (Postfix) with ESMTPS id A24AE14037E;
	Mon,  4 Mar 2024 11:21:31 +0800 (CST)
Received: from [10.174.178.220] (10.174.178.220) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 4 Mar 2024 11:21:31 +0800
Message-ID: <a7b2409c-4a3b-472d-a23a-87b12530be6d@huawei.com>
Date: Mon, 4 Mar 2024 11:21:19 +0800
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
 <20240303125737.GB112581@unreal>
Content-Language: en-US
From: Wenchao Hao <haowenchao2@huawei.com>
In-Reply-To: <20240303125737.GB112581@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600012.china.huawei.com (7.193.23.74)

On 2024/3/3 20:57, Leon Romanovsky wrote:
> On Fri, Mar 01, 2024 at 05:55:15PM +0800, Wenchao Hao wrote:
>> struct rdma_restrack_entry's kern_name was set to KBUILD_MODNAME
>> in ib_create_cq(), while if the module exited but forgot del this
>> rdma_restrack_entry, it would cause a invalid address access in
>> rdma_restrack_clean() when print the owner of this rdma_restrack_entry.
> 
> How is it possible to exit owner module without cleaning the resources?
> 

I meet this issue with one of our product who develop their owner kernel
modules based on ib_core, and there are terrible logic with the exit
code which cause resource leak.

Of curse it's bug of module who did not clear resource when exit, but
I think ib_core should avoid accessing memory of other modules directly
to provides better stability.

What's more, from the context of rdma_restrack_clean() when print
"restack: %s %s object allocated by %s is not freed ...", it seems
designed for the above scene where client has bug to alerts there
are resource leak, so we should not panic on this log print.

> Thanks
> 
>>
>> Fix this issue by using kstrdup() to set rdma_restrack_entry's
>> kern_name.
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


