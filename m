Return-Path: <linux-rdma+bounces-12818-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EE98B2C842
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 17:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 940AF1BA529D
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326FB280A2C;
	Tue, 19 Aug 2025 15:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eJICgpo8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A3F2765C0
	for <linux-rdma@vger.kernel.org>; Tue, 19 Aug 2025 15:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755616558; cv=none; b=KQ8c1c+/A1h3FvsRyPkld89wnbcwj2FXJqh2XjILlB7igBfwKG+YzbaZTaVzJXy6XxIYuJSU/obFqKIBtC28xEYTHJwoGBmHRrlViB7suuTaB8nR+p1MBvFmArrgu5jsQY2DG9WZJ9Sxz5jr7LiIYvMLDcGvLnSTdU4JU1uYDUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755616558; c=relaxed/simple;
	bh=/YXnqVuK8U4gBXC+dMsuRDaeL1UwB3gwONUyZmb/PzM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkXCQYoMQAiV18v2MiSYSFp7lt32iR+xgXU8A1LiUwab20TQhROwARXFjBxVR1mmgZZi2gxvxHjNvtGxzAF/5gdvxg++GQMPtuGaqU1FK+BDA0z+aPQDZzaxjwFXQbB1GwPTQPGRatSB6kK5THbjSvbzEKDg/TJnS8gozGpksRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eJICgpo8; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-32372c05b79so2190552a91.0
        for <linux-rdma@vger.kernel.org>; Tue, 19 Aug 2025 08:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755616556; x=1756221356; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=g1vXWOG6u1Oib3gcXHgFe/NxeA0k1BMk9PSmX9WxRMA=;
        b=eJICgpo87CBZ8TZYP++9cFNROwV2rZG0hXg+OoozqS5uxmAi1TSbTYnDCj5Am9TTmG
         0858aSxm5HUlqCErXbWhNElvfVA6Ep0pId5W/B0QZ+IE4o/gAtnFzEq+9Ic24142hLz8
         4A1VM43u4YVAnu2su1zLKLT4co+yopgXOERey1ux1SWXR8AK3KoyYkhfX9neB24Wnlhv
         hKykHfbwoen7e5bAS9JSG0vdloe6ovH1mBdpQiC4RT89uamsOycREBnYch2EQfW6Eff7
         sVfChez8wA0/zXu0zwVFwSGUbRmGvbZSDQR9J4Luhw4tRVngIkldDBp6Nfvi//mHxFx5
         8V/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755616556; x=1756221356;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g1vXWOG6u1Oib3gcXHgFe/NxeA0k1BMk9PSmX9WxRMA=;
        b=lGZKSmqiGM2/2tOAfiV6yd2nWMQbD75US/RXGDt8I5CYWOHOFhu3lIqSFt4+olTgkI
         jvuev+sxZXC0A4QheWdAvx/VXy16wM04EwyFzsDDrnqM86Sv5t+qZtoBf9Ic3tK2vvVh
         F5FqN/JxQIwYs1bOdYXZzusofHG07dlzkP3EblhJ6YC2j4J5k0FrxABMk39jt0g4limC
         vdaG5uOfxlIBFjLKxO7aWdybS6UwaZAxcw6yVB89ZOmhTthoWbPjqXRyFvHqR7O71OYg
         wxkj+2SuZ3Y7olqpZZNVnLfkxJUXzAwPmqiGh3Ud86e7A3a5FaT6+37o5Wh2zUrnSlxu
         LguQ==
X-Forwarded-Encrypted: i=1; AJvYcCXDRkudOuFUoiT/MuE41pd+PGw0qo43pJiyUP3LLiLJUylGuPJ9rK1cKQW3tVU0FkmBEwWrddcSDH4w@vger.kernel.org
X-Gm-Message-State: AOJu0YyLYUFPHkMocvqF2fGkYAtz7CQYy8VRggWSS5wgR0sgoNgedQ+q
	U+fSd6EWEDK2301bbwnfO/QEO7N14MumgaP6VW7YmhwxAC9t5Ds6+XfK
X-Gm-Gg: ASbGnct3no3/mvCQUV6p7dZQjXOlbQtyfggJIzxOS2w0GVjlTQEe25En4J+vzZiuKq8
	RF6bSRgt3vk/NL9iN4/pUbu8fEAZSq8YP/zrFbSKwL+KhiA5BfpC/E90fJxnY2lDO+pT0/l5oNX
	qQoh2PDxrQ7J7XXfN//AMs0T/qa69y+gCgjcKyiBEf0KjiN9TGAL1ln8sm6H1JR8clyqxiYbTCo
	UzjFNk6i1OkEoA5azlRu/1i7HwEHOfJP4CqfQxD7Vrwif2rQja3VnpVWBi7D0DNxHvtbgbTF51W
	gyr7Ysg4AKTwXJP8i2/fnjdIgH6EbIhgDREawoPqapeaFSNVx36MmB4gVLg/f5PsVKAi/ey2q5S
	4Hlz+CRIRvnYvKVljL667um/kyOEI9cz8EqaCyhseHKWuFCkPx7VGpHaao4p9FiqrPsHpZ24FGh
	PQ
X-Google-Smtp-Source: AGHT+IGCIMGYVzz86HcLWYbmv+1tTXX//56RCya3uXijrtZgP97h+FDU7Na7Fi8miIcud8peJkdbkQ==
X-Received: by 2002:a17:90b:2d48:b0:323:7e05:5a2c with SMTP id 98e67ed59e1d1-32476b01fcamr3679050a91.36.1755616555444;
        Tue, 19 Aug 2025 08:15:55 -0700 (PDT)
Received: from [192.168.11.3] (FL1-125-195-176-151.tky.mesh.ad.jp. [125.195.176.151])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32330f836cfsm14666838a91.5.2025.08.19.08.15.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 08:15:55 -0700 (PDT)
Message-ID: <4a2b6587-7bb1-4fdd-a3c1-6f0c61a84ef7@gmail.com>
Date: Wed, 20 Aug 2025 00:15:51 +0900
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Avoid CQ polling hang triggered by CQ
 resize
To: Zhu Yanjun <yanjun.zhu@linux.dev>, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
Cc: philipp.reisner@linbit.com
References: <20250817123752.153735-1-dskmtsd@gmail.com>
 <f764f4ae-91c2-4e22-8380-9a8dd144d0c1@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <f764f4ae-91c2-4e22-8380-9a8dd144d0c1@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/08/18 13:44, Zhu Yanjun wrote:
> 在 2025/8/17 5:37, Daisuke Matsuda 写道:
>> When running the test_resize_cq testcase from rdma-core, polling a
>> completion queue from userspace may occasionally hang and eventually fail
>> with a timeout:
>> =====
>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>> Test resize CQ, start with specific value and then increase and decrease
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>      File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>>        u.poll_cq(self.client.cq)
>>      File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>        wcs = _poll_cq(cq, count, data)
>>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>>      File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>        raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>> remaining)
>> =====
>>
>> The issue is caused when rxe_cq_post() fails to post a CQE due to the queue
>> being temporarily full, and the CQE is effectively lost. To mitigate this,
>> add a bounded busy-wait with fallback rescheduling so that CQE does not get
>> lost.
>>
>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>> ---
>>   drivers/infiniband/sw/rxe/rxe_cq.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
>> index fffd144d509e..7b0fba63204e 100644
>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
>> @@ -84,14 +84,36 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
>>   /* caller holds reference to cq */
>>   int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>>   {
>> +    unsigned long flags;
>> +    u32 spin_cnt = 3000;
>>       struct ib_event ev;
>> -    int full;
>>       void *addr;
>> -    unsigned long flags;
>> +    int full;
>>       spin_lock_irqsave(&cq->cq_lock, flags);
>>       full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>> +    if (likely(!full))
>> +        goto post_queue;
>> +
>> +    /* constant backoff until queue is ready */
>> +    while (spin_cnt--) {
>> +        full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>> +        if (!full)
>> +            goto post_queue;
>> +
>> +        cpu_relax();
>> +    }
> 
> The loop runs 3000 times.
> Each iteration:
> 
> Checks queue_full()
> Executes cpu_relax()
> 
> On modern CPUs, each iteration may take a few cycles, e.g., 4–10 cycles per iteration (depends on memory/cache).
> 
> Suppose 1 cycle = ~0.3 ns on a 3 GHz CPU, 10 cycles ≈ 3 ns
> 3000 iterations × 10 cycles ≈ 30,000 cycles
> 
> 30000 cycles * 0.3 ns = 9000 ns = 9 microseconds
> 
> So the “critical section” while spinning is tens of microseconds, not milliseconds.
> 
> I was concerned that 3000 iterations might make the spin lock critical section too long, but based on the analysis above, it appears that this is still a short-duration critical section.

Thank you for the review.

Assuming the two loads in queue_full() hit in the L1 cache, I estimate each iteration could take around
15–20 cycles. Based on your calculation, the maximum total time would be approximately 18 microseconds.

> 
> I am not sure if it is a big spin lock critical section or not.
> If it is not,

In my opinion, this duration is acceptable, as the thread does not actually spin for that long
in practice. During my testing, it never reached the cond_resched() fallback, so the
current spin count appears sufficient to avoid the failure case.

Thanks,
Daisuke

> 
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> 
> Zhu Yanjun
> 
>> +
>> +    /* try giving up cpu and retry */
>> +    if (full) {
>> +        spin_unlock_irqrestore(&cq->cq_lock, flags);
>> +        cond_resched();
>> +        spin_lock_irqsave(&cq->cq_lock, flags);
>> +
>> +        full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>> +    }
>> +
>>       if (unlikely(full)) {
>>           rxe_err_cq(cq, "queue full\n");
>>           spin_unlock_irqrestore(&cq->cq_lock, flags);
>> @@ -105,6 +127,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>>           return -EBUSY;
>>       }
>> + post_queue:
>>       addr = queue_producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>       memcpy(addr, cqe, sizeof(*cqe));
> 


