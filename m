Return-Path: <linux-rdma+bounces-14267-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6F6C368C4
	for <lists+linux-rdma@lfdr.de>; Wed, 05 Nov 2025 17:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32B5C623AB4
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Nov 2025 15:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0751E335BCF;
	Wed,  5 Nov 2025 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Oc/UUwul"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E296335BC5
	for <linux-rdma@vger.kernel.org>; Wed,  5 Nov 2025 15:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762357587; cv=none; b=jsHpQxE0F+ruIbxP83Frzptfmb5A6ag3FhzytOHUdvKzrVVUzNLzthLBk41fb8kY0LKoefiee3n+KdCdbSLqcMLQHfXGY2g9RM3Lc03RrREtDNtTNXBpsIT71mQiw00pxUzC/SraKwtI52ZF17i/wPXYmOXzBaib1IA82G40ONE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762357587; c=relaxed/simple;
	bh=b66PY49QtYrBX8nVq9PaYg5dshj4xYNMkyYVlvGUCjc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GUXl+TB/ebWuBz6F63772rjfxtUnuM7yYD5y0yP0+U/ds1fW8jhalH4V366Lh2YXzbk+ohf4qUzPyoApuySOl1Ftb8rb4m790NmBKmvH6brx1a76457pV2uFXyMMclybMyYfWD9vOVhGWCqc9kYeifQCtLa9ZAvdMraGuobGpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Oc/UUwul; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5ed1ead1-f51f-4d8a-ad40-6d90bbd4f1b7@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1762357582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jJAZ6hX7yDhjohxkHVFtTIAJYHz6AwDdImGPJGBbDBk=;
	b=Oc/UUwulU+s3y72QaAd90T4WJILVp3Ht1/r1XKMgRPmv7ElqG+xVGwjtmexxUYB1AlXNrY
	0qF0aj5JJ61P9n9k1Z8nAOzJ6ek8muqAJZHk3MGeTaCCheIyJSkYRDBDmbRaFN/S5U/3XH
	qOAXvNrsq8y/xbALkUy/eyPrj6jGMOA=
Date: Wed, 5 Nov 2025 07:46:18 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH rdma-next v2 1/1] RDMA/core: Fix WARNING in
 gid_table_release_one
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org,
 syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
References: <20251104233601.1145-1-yanjun.zhu@linux.dev>
 <20251105130958.GE16832@unreal> <20251105134524.GL1204670@ziepe.ca>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251105134524.GL1204670@ziepe.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/11/5 5:45, Jason Gunthorpe 写道:
> On Wed, Nov 05, 2025 at 03:09:58PM +0200, Leon Romanovsky wrote:
>> On Tue, Nov 04, 2025 at 03:36:01PM -0800, Zhu Yanjun wrote:
>>> GID entry ref leak for dev syz1 index 2 ref=615
>>> ...
>>> Call Trace:
>>>   <TASK>
>>>   ib_device_release+0xd2/0x1c0 drivers/infiniband/core/device.c:509
>>>   device_release+0x99/0x1c0 drivers/base/core.c:-1
>>>   kobject_cleanup lib/kobject.c:689 [inline]
>>>   kobject_release lib/kobject.c:720 [inline]
>>>   kref_put include/linux/kref.h:65 [inline]
>>>   kobject_put+0x228/0x480 lib/kobject.c:737
>>>   process_one_work kernel/workqueue.c:3263 [inline]
>>>   process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3346
>>>   worker_thread+0x8a0/0xda0 kernel/workqueue.c:3427
>>>   kthread+0x711/0x8a0 kernel/kthread.c:463
>>>   ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:158
>>>   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
>>>   </TASK>
>>>
>>> When the state of a GID is GID_TABLE_ENTRY_PENDING_DEL, it indicates
>>> that the GID is about to be released soon. Therefore, it does not
>>> appear to be a leak.
>>>
>>> Fixes: b150c3862d21 ("IB/core: Introduce GID entry reference counts")
>>> Reported-by: syzbot+b0da83a6c0e2e2bddbd4@syzkaller.appspotmail.com
>>> Closes: https://syzkaller.appspot.com/bug?extid=b0da83a6c0e2e2bddbd4
>>> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>> ---
>>> V1->V2: Use flush_workqueue instead of while loop
>>> ---
>>>   drivers/infiniband/core/cache.c | 16 +++++++++++++---
>>>   1 file changed, 13 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/infiniband/core/cache.c b/drivers/infiniband/core/cache.c
>>> index 81cf3c902e81..74211fb37020 100644
>>> --- a/drivers/infiniband/core/cache.c
>>> +++ b/drivers/infiniband/core/cache.c
>>> @@ -799,16 +799,26 @@ static void release_gid_table(struct ib_device *device,
>>>   	if (!table)
>>>   		return;
>>>   
>>> +	mutex_lock(&table->lock);
>>>   	for (i = 0; i < table->sz; i++) {
>>>   		if (is_gid_entry_free(table->data_vec[i]))
>>>   			continue;
>>>   
>>> -		WARN_ONCE(true,
>>> -			  "GID entry ref leak for dev %s index %d ref=%u\n",
>>> +		WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
>>> +			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
>>>   			  dev_name(&device->dev), i,
>>> -			  kref_read(&table->data_vec[i]->kref));
>>> +			  kref_read(&table->data_vec[i]->kref), table->data_vec[i]->state);
>>> +		/*
>>> +		 * The entry may be sitting in the WQ waiting for
>>> +		 * free_gid_work(), flush it to try to clean it.
>>> +		 */
>>> +		mutex_unlock(&table->lock);
>>> +		flush_workqueue(ib_wq);
>>> +		mutex_lock(&table->lock);
>> I can't agree with idea that flush_workqueue() is called in the loop.
> Since we almost never see these WARN_ON's it isn't really called in a
> loop, but sure you could put a conditional around it to do it only
> once.
>
> The WARN on is in the wrong order, it is not a kernel bug if the
> workqueue is still pending. flush the queue and then check again, and
> then do the warn.
>
> @@ -791,22 +791,31 @@ static struct ib_gid_table *alloc_gid_table(int sz)
>          return NULL;
>   }
>   
> -static void release_gid_table(struct ib_device *device,
> -                             struct ib_gid_table *table)
> +static bool is_gid_table_clean(struct ib_gid_table *table)
>   {
>          int i;
>   
> +       guard(mutex)(&table->lock);
> +       for (i = 0; i < table->sz; i++)
> +               if (!is_gid_entry_free(table->data_vec[i]))
> +                       return false;
> +       return true;
> +}
> +
> +static void release_gid_table(struct ib_device *device,
> +                             struct ib_gid_table *table)
> +{
>          if (!table)
>                  return;
>   
> -       for (i = 0; i < table->sz; i++) {
> -               if (is_gid_entry_free(table->data_vec[i]))
> -                       continue;
> -
> -               WARN_ONCE(true,
> -                         "GID entry ref leak for dev %s index %d ref=%u\n",
> -                         dev_name(&device->dev), i,
> -                         kref_read(&table->data_vec[i]->kref));
> +       if (!is_gid_table_clean(table)) {
> +               /*
> +                * The entry may be sitting in the WQ waiting for
> +                * free_gid_work(), flush it to try to clean it.
> +                */
> +               flush_workqueue(ib_wq);
> +               if (!is_gid_table_clean(table))
> +                       WARN_ONCE(true, "GID entry has leaked");

Thanks a lot. IMO, if a leak occurs, more information should be helpful. Thus, the following should be better?
	
	WARN_ONCE(table->data_vec[i]->state != GID_TABLE_ENTRY_PENDING_DEL,
			  "GID entry ref leak for dev %s index %d ref=%u, state: %d\n",
  			  dev_name(&device->dev), index,
			  kref_read(&table->data_vec[index]->kref), table->data_vec[index]->state);
I will make tests with syz and send the latest patch very soon.

Zhu Yanjun

>          }
>   
>          mutex_destroy(&table->lock);
>
> Jason

-- 
Best Regards,
Yanjun.Zhu


