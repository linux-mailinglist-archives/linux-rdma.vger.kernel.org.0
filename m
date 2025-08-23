Return-Path: <linux-rdma+bounces-12886-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF29B326EA
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Aug 2025 07:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8156517C6DD
	for <lists+linux-rdma@lfdr.de>; Sat, 23 Aug 2025 05:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C6E3393DD4;
	Sat, 23 Aug 2025 05:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MEUvJy13"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD51A9FB6
	for <linux-rdma@vger.kernel.org>; Sat, 23 Aug 2025 05:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755926587; cv=none; b=SRhZQOaCeBbbRzIF5ymenuOnrXEn0TRYLaG+4CYQCjFOSjYfKZ6iMsPK0ER+Zk3dAaMqebLfmQLND8RjK+swFLiwQC048B81RjHg6EoFSOqZ5CvT5Aw8/06QOKX8ICHWj3rgvhKeawAbfQc4XuyVr+jamXMocJuNwM7ktdMFTCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755926587; c=relaxed/simple;
	bh=Sl0XSx20TweYUUIdD6CPwhuG9r+JogxTgKtGPquvbCE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WykT7KOYoeE2RsCz3ViZypdJivpxg/pnU9EqHebKoDw4CxQepXZsCIO5aYuu3MeuNzyzAKrMIVh3NDmAQ5Se0tUsVazOkDwzc5Q3ldXx6p5CLtJRDPHN/m29X8oP7WMoc4IdWWoqqkJrVWZq78xx2Spt3383rt3OzAfaiDbAQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MEUvJy13; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <41f3b537-3463-498e-a2bb-cb8be8176a1a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755926582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uTkVZrM3isklAHhw6Z2qbIYKCl+UFE1C0mlKfuNl0N0=;
	b=MEUvJy13JQGazrI7N67K+dJZtHwGoKjxd/dFzl7zcxrvJrmA8ZuMkDCLAFKxkXHKXD/65R
	ODCDOMEjmlcmGIu1NkisThORdx0xbX4duGf0TezTDUy7yG6OtdfRscJfPnbPO6PoesUj/a
	QJ1I/G0u+5A9kmvtw4mMkiy64FygcXM=
Date: Fri, 22 Aug 2025 22:22:39 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc v1] RDMA/rxe: Avoid CQ polling hang triggered by CQ
 resize
To: Daisuke Matsuda <dskmtsd@gmail.com>, linux-rdma@vger.kernel.org,
 leon@kernel.org, jgg@ziepe.ca, zyjzyj2000@gmail.com
Cc: philipp.reisner@linbit.com
References: <20250817123752.153735-1-dskmtsd@gmail.com>
 <f764f4ae-91c2-4e22-8380-9a8dd144d0c1@linux.dev>
 <4a2b6587-7bb1-4fdd-a3c1-6f0c61a84ef7@gmail.com>
 <29dad784-f3d0-4b90-84fb-6f7ae066a79d@linux.dev>
 <6851c585-b7ed-43a8-8edf-b08573a37afd@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <6851c585-b7ed-43a8-8edf-b08573a37afd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/8/22 21:19, Daisuke Matsuda 写道:
> On 2025/08/21 12:12, Zhu Yanjun wrote:
>> 在 2025/8/19 8:15, Daisuke Matsuda 写道:
>>> On 2025/08/18 13:44, Zhu Yanjun wrote:
>>>> 在 2025/8/17 5:37, Daisuke Matsuda 写道:
>>>>> When running the test_resize_cq testcase from rdma-core, polling a
>>>>> completion queue from userspace may occasionally hang and 
>>>>> eventually fail
>>>>> with a timeout:
>>>>> =====
>>>>> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
>>>>> Test resize CQ, start with specific value and then increase and 
>>>>> decrease
>>>>> ---------------------------------------------------------------------- 
>>>>>
>>>>> Traceback (most recent call last):
>>>>>      File "/root/deb/rdma-core/tests/test_cq.py", line 135, in 
>>>>> test_resize_cq
>>>>>        u.poll_cq(self.client.cq)
>>>>>      File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>>>>>        wcs = _poll_cq(cq, count, data)
>>>>>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>>>>>      File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>>>>>        raise PyverbsError(f'Got timeout on polling ({count} CQEs 
>>>>> remaining)')
>>>>> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
>>>>> remaining)
>>>>> =====
>>>>>
>>>>> The issue is caused when rxe_cq_post() fails to post a CQE due to 
>>>>> the queue
>>>>> being temporarily full, and the CQE is effectively lost. To 
>>>>> mitigate this,
>>>>> add a bounded busy-wait with fallback rescheduling so that CQE 
>>>>> does not get
>>>>> lost.
>>>>>
>>>>> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
>>>>> ---
>>>>>   drivers/infiniband/sw/rxe/rxe_cq.c | 27 +++++++++++++++++++++++++--
>>>>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c 
>>>>> b/drivers/infiniband/ sw/rxe/rxe_cq.c
>>>>> index fffd144d509e..7b0fba63204e 100644
>>>>> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
>>>>> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
>>>>> @@ -84,14 +84,36 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int 
>>>>> cqe,
>>>>>   /* caller holds reference to cq */
>>>>>   int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int 
>>>>> solicited)
>>>>>   {
>>>>> +    unsigned long flags;
>>>>> +    u32 spin_cnt = 3000;
>>>>>       struct ib_event ev;
>>>>> -    int full;
>>>>>       void *addr;
>>>>> -    unsigned long flags;
>>>>> +    int full;
>>>>>       spin_lock_irqsave(&cq->cq_lock, flags);
>>>>>       full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>>>> +    if (likely(!full))
>>>>> +        goto post_queue;
>>>>> +
>>>>> +    /* constant backoff until queue is ready */
>>>>> +    while (spin_cnt--) {
>>>>> +        full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
>>>>> +        if (!full)
>>>>> +            goto post_queue;
>>>>> +
>>>>> +        cpu_relax();
>>>>> +    }
>>>>
>>>> The loop runs 3000 times.
>>>> Each iteration:
>>>>
>>>> Checks queue_full()
>>>> Executes cpu_relax()
>>>>
>>>> On modern CPUs, each iteration may take a few cycles, e.g., 4–10 
>>>> cycles per iteration (depends on memory/cache).
>>>>
>>>> Suppose 1 cycle = ~0.3 ns on a 3 GHz CPU, 10 cycles ≈ 3 ns
>>>> 3000 iterations × 10 cycles ≈ 30,000 cycles
>>>>
>>>> 30000 cycles * 0.3 ns = 9000 ns = 9 microseconds
>>>>
>>>> So the “critical section” while spinning is tens of microseconds, 
>>>> not milliseconds.
>>>>
>>>> I was concerned that 3000 iterations might make the spin lock 
>>>> critical section too long, but based on the analysis above, it 
>>>> appears that this is still a short-duration critical section.
>>>
>>> Thank you for the review.
>>>
>>> Assuming the two loads in queue_full() hit in the L1 cache, I 
>>> estimate each iteration could take around
>>> 15–20 cycles. Based on your calculation, the maximum total time 
>>> would be approximately 18 microseconds.
>>
>> ======================================================================
>> ERROR: test_rdmacm_async_write (tests.test_rdmacm.CMTestCase)
>> ----------------------------------------------------------------------
>> Traceback (most recent call last):
>>    File "/..../rdma-core/tests/test_rdmacm.py", line 71, in 
>> test_rdmacm_async_write
>>      self.two_nodes_rdmacm_traffic(CMAsyncConnection,
>>    File "/..../rdma-core/tests/base.py", line 447, in 
>> two_nodes_rdmacm_traffic
>>      raise Exception('Exception in active/passive side occurred')
>> Exception: Exception in active/passive side occurred
>>
>> After appying your commit, I run the following run_tests.py for 10000 
>> times.
>> The above error sometimes will appear. The frequency is very low.
>>
>> "
>> for (( i = 0; i < 10000; i++ ))
>> do
>>      rdma-core/build/bin/run_tests.py --dev rxe0
>> done
>> "
>> It is weird.
>
> I tried running test_rdmacm_async_write alone for 50000 times, but 
> could not reproduce this one.
> There have been multiple latency-related issues in RXE, so it is not 
> surprising a new one is
> uncovered by changing seemingly irrelevant part.
>
> How about applying additional change below:
> ===
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c 
> b/drivers/infiniband/sw/rxe/rxe_cq.c
> index 7b0fba63204e..8f8d56051b8d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -102,7 +102,9 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe 
> *cqe, int solicited)
>                 if (!full)
>                         goto post_queue;
>
> +               spin_unlock_irqrestore(&cq->cq_lock, flags);
>                 cpu_relax();
> +               spin_lock_irqsave(&cq->cq_lock, flags);
>         }
>
>         /* try giving up cpu and retry */
> ===
> This makes cpu_relax() almost meaningless, but ensures the lock is 
> released in each iteration.
>
> It would be nice if you could provide the frequency and whether it 
> takes longer than usual in failure cases.
> I think that could be helpful as a starting point to find a solution.


With a clean KVM QEMU VM, after applying your commit, the same problem 
occurs every time the above script is run.

Yanjun.Zhu


>
> Thanks,
> Daisuke
>
>>
>> Yanjun.Zhu
>>
>
>
-- 
Best Regards,
Yanjun.Zhu


