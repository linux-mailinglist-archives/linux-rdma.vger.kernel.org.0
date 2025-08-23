Return-Path: <linux-rdma+bounces-12885-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F37FB326CB
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Aug 2025 06:19:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 820DF7B9EA3
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Aug 2025 04:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887721FC0EA;
	Sat, 23 Aug 2025 04:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C8LkwmyF"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC61393DF4
	for <linux-rdma@vger.kernel.org>; Sat, 23 Aug 2025 04:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755922786; cv=none; b=iE93SHjWabpWlR5FBoCx03BShM5oef7EMEIPrPKuHMwLBMFBqK84FKGc2aNFPnoY3XOlKXIYOoAW0ku9/ZJUVvFw8JSnrpWvrxlR57+8qIzBezCeizkcQo19F/Ifdz/2WRTLVf4o2mLP/TQ2AlXodolgDguS348+8KQC36RbiLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755922786; c=relaxed/simple;
	bh=FbvLCjJf4GSa9M+8doaVaG/hKz4N+x+1EPWezy38Xhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RqUDQhopuIS4n1vcLUWw+sb9Wnm0Ftw+NoCs1EV1yWx87Opc+LNwlm77FKa66R2BIkk4XOmQnxSZ/fxyhsgSFz8bn8iTqXcS3d45w4bqKBGhmZ5j9d1KqLMHLd2Vq49g1AVX6w4IXxKkaU9+xB9FVyeTX2uBB+Cm6tG1Z2iz4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C8LkwmyF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-76e2eb6d07bso2426200b3a.3
        for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 21:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755922784; x=1756527584; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNkbWbD8xorBVyC4/SopQA2uxIowN77AwxCjIzNjunU=;
        b=C8LkwmyFVdDMQbHs4MUikK+R0dSI5kX3pdiTGYBtn0pwuvZ2na8gYb4tZe0yjX/hwf
         +nOS8QJy0KV+G7bQAU/JnQthY+U/40Eg8hz9XwjUWVVoZPLy+QfPJ08DvkGDM3f3Vzed
         uiBgl+E9SIWCSdO2prvHKRiMhEx/EOogmVOjKXKRwBl5NNdTd5U1b2C76bUccOdUSgTh
         uNr/hAnu4xwF9WK1tkAv7mNlJXT9H9WAR+Yr4/zWUcwOCwhPhMcqf+lEhUYPMv2N0ztB
         SrKuAbMny1sSuyIGyfS6YP4GH/Xed4qvMmQP36D+YC/QJ8oO/tdmyxiTWzoFuxBDQT1I
         P4iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755922784; x=1756527584;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MNkbWbD8xorBVyC4/SopQA2uxIowN77AwxCjIzNjunU=;
        b=epv1Q/Wr7qiVVACiO1K4xdy+85OfsEfzkJq1EQrBAy4krxoghPuVA9aSj8YQMeoFdu
         Zk6Qz9SSTjE+cTTt7PaCho6tL66MpHWiXrQ+v7GRFDGVfogTlRxT+zS5vE9fWuxsc3vJ
         v0x9sVKJL5PWibldLyaJJm+NpTOZgaWAA+v9goOgKuUn0FeCVaeMShXpNOIdg5Mja6f7
         f+1KfwRiY04lstdUoOhM7u8d2iQoD/FKF+Tyh6A5xlXUttRcQdq/paqcL0E+JcvK3zMl
         6oYdhszXxbF3E9G8AoysamjfVOvJSRe4+/xUPWns352w3mc9kDy8N1x3QdFZtFBknxHR
         +8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCVOZLqodvmVj6HLJoGYa0ngGV5GnK7QiB33hHhyvg0W/dfJIyzJVvFUomyfO1LVlLaQ6Vb+5FqfwNvS@vger.kernel.org
X-Gm-Message-State: AOJu0YzCaZUlQF4z9zgPWk5/nmcytW+P7WdCayWHc7Lz/OLxJ3j/2Ubt
	Y2D/4BlPRClXa6wt9uyqbB/yzKxd+XhL2hWgGC7VohgH4sO9gGRbrC84xXTIzQ==
X-Gm-Gg: ASbGncv4RUUJsGQtj/INq0cFq/Od0Bjn90ZJUvZelJ4wUUBm9HbellAfYBV0SMUrw/8
	xfOatQU3SeJrj0T8TZhNn0JcyXBaZ4lLURK83HSJBhdHEpZ1e/8Iwm4F31v5jHATDBykh/AjKC6
	6fOzMwN30WRGdR6/Bx7wJipBHNm4Xag+otEKtpsAQYHPeGg5bOSYY/ktJ7uQ8S59FFDEMiJ6ohx
	SHRweLCF/4I2PRo/voO0bi1vHFalCYkXRoVrU+6toXaV8FJQLdcsKMglkZVnsk+SBw7sjpG7LY4
	DNC9o2rvm1zuKIHvlO1aVcSIcQQgSI72Duk64R8+rhjPMbM+GJ8PVjhlnHOsCB+5JP7HXYZU2Lc
	2zVvRnqFLBadnFtY8nWLUOg2usl8miCZ/wuN//J0NQ4eKnM8GiTkwf4GWKbCSMsEy/8IMTM3u/v
	ijVwQ5/Eae+7c=
X-Google-Smtp-Source: AGHT+IGK7PZKZ3ShKUug1EFZuz7mYk88pqU1a9aI/F66JZN9kYLrHTCjnMAQnmeZb5jJm0FXLRvauA==
X-Received: by 2002:a05:6a00:3cd3:b0:76e:3d16:6e7b with SMTP id d2e1a72fcca58-7702f9ede7bmr7245402b3a.8.1755922783939;
        Fri, 22 Aug 2025 21:19:43 -0700 (PDT)
Received: from [192.168.11.3] (FL1-125-195-176-151.tky.mesh.ad.jp. [125.195.176.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7703ffc2ad0sm1382721b3a.9.2025.08.22.21.19.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Aug 2025 21:19:43 -0700 (PDT)
Message-ID: <6851c585-b7ed-43a8-8edf-b08573a37afd@gmail.com>
Date: Sat, 23 Aug 2025 13:19:40 +0900
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
 <4a2b6587-7bb1-4fdd-a3c1-6f0c61a84ef7@gmail.com>
 <29dad784-f3d0-4b90-84fb-6f7ae066a79d@linux.dev>
Content-Language: en-US
From: Daisuke Matsuda <dskmtsd@gmail.com>
In-Reply-To: <29dad784-f3d0-4b90-84fb-6f7ae066a79d@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2025/08/21 12:12, Zhu Yanjun wrote:
> 在 2025/8/19 8:15, Daisuke Matsuda 写道:
>> On 2025/08/18 13:44, Zhu Yanjun wrote:
>>> 在 2025/8/17 5:37, Daisuke Matsuda 写道:
>>>> When running the test_resize_cq testcase from rdma-core, polling a
>>>> completion queue from userspace may occasionally hang and eventually fail
>>>> with a timeout:
>>>> =====
>>>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>>>> Test resize CQ, start with specific value and then increase and decrease
>>>> ----------------------------------------------------------------------
>>>> Traceback (most recent call last):
>>>>      File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>>>>        u.poll_cq(self.client.cq)
>>>>      File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>>>        wcs = _poll_cq(cq, count, data)
>>>>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>      File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>>>        raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
>>>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>>>> remaining)
>>>> =====
>>>>
>>>> The issue is caused when rxe_cq_post() fails to post a CQE due to the queue
>>>> being temporarily full, and the CQE is effectively lost. To mitigate this,
>>>> add a bounded busy-wait with fallback rescheduling so that CQE does not get
>>>> lost.
>>>>
>>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>>> ---
>>>>   drivers/infiniband/sw/rxe/rxe_cq.c | 27 +++++++++++++++++++++++++--
>>>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/ sw/rxe/rxe_cq.c
>>>> index fffd144d509e..7b0fba63204e 100644
>>>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
>>>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
>>>> @@ -84,14 +84,36 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
>>>>   /* caller holds reference to cq */
>>>>   int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>>>>   {
>>>> +    unsigned long flags;
>>>> +    u32 spin_cnt = 3000;
>>>>       struct ib_event ev;
>>>> -    int full;
>>>>       void *addr;
>>>> -    unsigned long flags;
>>>> +    int full;
>>>>       spin_lock_irqsave(&cq->cq_lock, flags);
>>>>       full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>>> +    if (likely(!full))
>>>> +        goto post_queue;
>>>> +
>>>> +    /* constant backoff until queue is ready */
>>>> +    while (spin_cnt--) {
>>>> +        full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>>> +        if (!full)
>>>> +            goto post_queue;
>>>> +
>>>> +        cpu_relax();
>>>> +    }
>>>
>>> The loop runs 3000 times.
>>> Each iteration:
>>>
>>> Checks queue_full()
>>> Executes cpu_relax()
>>>
>>> On modern CPUs, each iteration may take a few cycles, e.g., 4–10 cycles per iteration (depends on memory/cache).
>>>
>>> Suppose 1 cycle = ~0.3 ns on a 3 GHz CPU, 10 cycles ≈ 3 ns
>>> 3000 iterations × 10 cycles ≈ 30,000 cycles
>>>
>>> 30000 cycles * 0.3 ns = 9000 ns = 9 microseconds
>>>
>>> So the “critical section” while spinning is tens of microseconds, not milliseconds.
>>>
>>> I was concerned that 3000 iterations might make the spin lock critical section too long, but based on the analysis above, it appears that this is still a short-duration critical section.
>>
>> Thank you for the review.
>>
>> Assuming the two loads in queue_full() hit in the L1 cache, I estimate each iteration could take around
>> 15–20 cycles. Based on your calculation, the maximum total time would be approximately 18 microseconds.
> 
> ======================================================================
> ERROR: test_rdmacm_async_write (tests.test_rdmacm.CMTestCase)
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>    File "/..../rdma-core/tests/test_rdmacm.py", line 71, in test_rdmacm_async_write
>      self.two_nodes_rdmacm_traffic(CMAsyncConnection,
>    File "/..../rdma-core/tests/base.py", line 447, in two_nodes_rdmacm_traffic
>      raise Exception('Exception in active/passive side occurred')
> Exception: Exception in active/passive side occurred
> 
> After appying your commit, I run the following run_tests.py for 10000 times.
> The above error sometimes will appear. The frequency is very low.
> 
> "
> for (( i = 0; i < 10000; i++ ))
> do
>      rdma-core/build/bin/run_tests.py --dev rxe0
> done
> "
> It is weird.

I tried running test_rdmacm_async_write alone for 50000 times, but could not reproduce this one.
There have been multiple latency-related issues in RXE, so it is not surprising a new one is
uncovered by changing seemingly irrelevant part.

How about applying additional change below:
===
diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
index 7b0fba63204e..8f8d56051b8d 100644
--- a/drivers/infiniband/sw/rxe/rxe_cq.c
+++ b/drivers/infiniband/sw/rxe/rxe_cq.c
@@ -102,7 +102,9 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
                 if (!full)
                         goto post_queue;

+               spin_unlock_irqrestore(&cq->cq_lock, flags);
                 cpu_relax();
+               spin_lock_irqsave(&cq->cq_lock, flags);
         }

         /* try giving up cpu and retry */
===
This makes cpu_relax() almost meaningless, but ensures the lock is released in each iteration.

It would be nice if you could provide the frequency and whether it takes longer than usual in failure cases.
I think that could be helpful as a starting point to find a solution.

Thanks,
Daisuke

> 
> Yanjun.Zhu
> 



