Return-Path: <linux-rdma+bounces-8002-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB06A40764
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 11:32:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CD3119C5E4B
	for <lists+linux-rdma@lfdr.de>; Sat, 22 Feb 2025 10:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3687207E09;
	Sat, 22 Feb 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cRTK47HF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE761FCF53
	for <linux-rdma@vger.kernel.org>; Sat, 22 Feb 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740220317; cv=none; b=Bo4dr6nwzwx2dssyGslFNDkFADZvxaI1Kze5+guG4LEhM4ytcHldHtff573h/YDn7238pYSG8C4lH9hEgjLOj5hMPHkt2MKR9wJ/fnQFKe/UuxYteUIe7j04WtC22g9Nfcr25ng86IPX8rUWfqSIetAusRBw6o+t0QG5L6yPHKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740220317; c=relaxed/simple;
	bh=1nemJPfOBc+DyKKbr3dZNsvhmBGiNJGGb1PZCRzeMB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CFfz9H6tfkd74FiJEB9oQgR1i7cMnpXJ9E135tnL8e9DzhdkaWpmrBn2WBJ+SYZYnT1kpABiiWXjNKtLJTfN3r7BKuI8KxoLY1T6Y+74qJph/iIefWgfdgcQvGPOAdc/+Wd0eRyZLcPWab3zZQhhe9KCewoyk6IqQuxpV96Rly0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=cRTK47HF; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b7921ac7-574d-461f-9e1d-8c3faff86edc@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1740220312;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T+dSUch04llgwodXedh8z35HEIIawbLP2kHpdTFBGog=;
	b=cRTK47HF1hpNgEyNuctu66DpJlb66ryEMai6KhWmAvoaHE7jgLBg0PF5uu4ScmuSaMlqX+
	I+9W8T4JErFLakmx5wouNmjDbUnp/RCglDGGY3g/4occAaqnORCUYL+SYtAIurxyeTj7Es
	Uh4+eYOX8+kXXAwmc5nX/u+DMiFcES0=
Date: Sat, 22 Feb 2025 11:31:45 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] IB/cm: use rwlock for MAD agent lock
To: Eric Dumazet <edumazet@google.com>
Cc: Jacob Moroni <jmoroni@google.com>, jgg@ziepe.ca, leon@kernel.org,
 markzhang@nvidia.com, linux-rdma@vger.kernel.org
References: <20250220175612.2763122-1-jmoroni@google.com>
 <838a95a2-f286-4f94-8667-2da8ba330c47@linux.dev>
 <CANn89iKSUZxfCm9rqEykZtzEAsu1F0dpooh1iih_RwRMHjpGNg@mail.gmail.com>
 <31fe1fe8-0f8f-4781-9ac1-2c0bb347d1b5@linux.dev>
 <CANn89i+52deipLpK4jPiQmM4kZk6gfhHBOt91j2vXZCd2GG8DA@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <CANn89i+52deipLpK4jPiQmM4kZk6gfhHBOt91j2vXZCd2GG8DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/2/22 8:38, Eric Dumazet 写道:
> On Sat, Feb 22, 2025 at 7:21 AM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>
>> 在 2025/2/21 18:32, Eric Dumazet 写道:
>>> On Fri, Feb 21, 2025 at 6:04 PM Zhu Yanjun <yanjun.zhu@linux.dev> wrote:
>>>>
>>>> On 20.02.25 18:56, Jacob Moroni wrote:
>>>>> In workloads where there are many processes establishing
>>>>> connections using RDMA CM in parallel (large scale MPI),
>>>>> there can be heavy contention for mad_agent_lock in
>>>>> cm_alloc_msg.
>>>>>
>>>>> This contention can occur while inside of a spin_lock_irq
>>>>> region, leading to interrupts being disabled for extended
>>>>> durations on many cores. Furthermore, it leads to the
>>>>> serialization of rdma_create_ah calls, which has negative
>>>>> performance impacts for NICs which are capable of processing
>>>>> multiple address handle creations in parallel.
>>>>
>>>> In the link:
>>>> https://www.cs.columbia.edu/~jae/4118-LAST/L12-interrupt-spinlock.html
>>>> "
>>>> ...
>>>> spin_lock() / spin_unlock()
>>>>
>>>> must not lose CPU while holding a spin lock, other threads will wait for
>>>> the lock for a long time
>>>>
>>>> spin_lock() prevents kernel preemption by ++preempt_count in
>>>> uniprocessor, that’s all spin_lock() does
>>>>
>>>> must NOT call any function that can potentially sleep
>>>> ex) kmalloc, copy_from_user
>>>>
>>>> hardware interrupt is ok unless the interrupt handler may try to lock
>>>> this spin lock
>>>> spin lock not recursive: same thread locking twice will deadlock
>>>>
>>>> keep the critical section as small as possible
>>>> ...
>>>> "
>>>> And from the source code, it seems that spin_lock/spin_unlock are not
>>>> related with interrupts.
>>>>
>>>> I wonder why "leading to interrupts being disabled for extended
>>>> durations on many cores" with spin_lock/spin_unlock?
>>>>
>>>> I am not against this commit. I am just obvious why
>>>> spin_lock/spin_unlock are related with "interrupts being disabled".
>>>
>>> Look at drivers/infiniband/core/cm.c
>>>
>>> spin_lock_irqsave(&cm_id_priv->lock, flags);
>>
>> Thanks a lot. spin_lock_irq should be spin_lock_irqsave?
> 
> Both spin_lock_irq and spin_lock_irqsave are masking all interrupts.

Maybe the commit log should be written clearly. Thanks.

Zhu Yanjun

> 
> 
> 
>>
>> Follow the steps of reproducer, I can not reproduce this problem on
>> KVMs. Maybe I need a powerful host.
>>
>> Anyway, read_lock should be a lighter lock than spin_lock.
>>
>> Thanks,
>> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
>>
>> Zhu Yanjun
>>
>>>
>>> -> Then call cm_alloc_msg() while hard IRQ are masked.
>>


