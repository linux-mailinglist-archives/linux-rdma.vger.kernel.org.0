Return-Path: <linux-rdma+bounces-12805-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1161AB2989D
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 06:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 702524E7CCF
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Aug 2025 04:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E5C418871F;
	Mon, 18 Aug 2025 04:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BgV/lZll"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2D123AE62
	for <linux-rdma@vger.kernel.org>; Mon, 18 Aug 2025 04:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755492281; cv=none; b=DCf7TqlOKURVRExAbdyzKHhJ62ylbzBgQ6eUOhOPWqTf5/gxnXQ8u9JeLJSrxBL9edsFLklVpNd17r5xYAN5PZZpcXSFjfw6uZUlX2/BLKfIpewbDsnEo48TsqfJZ70rBhgbHIQNsWnAq4Dy/8RzEIWmXy5dekNbV0iFd3yMXFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755492281; c=relaxed/simple;
	bh=D2e6DpK2rJvT8nkAvDE3R3uPmkLlNOPQM33izOaf+Mg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KV7mdyb2DTdCaFn/y4XfOz19JoDi0HkBYEi+WCtvHTQ9Fc/Rt2amxdY/Sn3DkXA+4Pb1QHuwD3xVo7Gd2DmN5/DWycIxWq1Y9rlVVHf3cr1RBv3hzAHpMiyR9UqawnBBeVI/qlm01+PzwFB7vaBWNRGszaM83Ak/EMhaM1y2vqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BgV/lZll; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f764f4ae-91c2-4e22-8380-9a8dd144d0c1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755492276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5fzzeP8RBY29msJ9TDcYMTgLIqvstNi10FWCzkyerKg=;
	b=BgV/lZllL3TDmNSjzRguZqo9aPbrZtkoQ1tMPJzLdmbBVqxqqKQj/XkTJgnw7HPKSo46So
	3FzJy+94PVxBkFmsW4GGjpXJcu4C+L5VZRUh7LtBNEjQie0NPwyimsCBVpdwB28D7R74+w
	x3qtIMx/mmByX4jm2gS+eDVA/f9ASEA=
Date: Sun, 17 Aug 2025 21:44:16 -0700
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
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250817123752.153735-1-dskmtsd@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/17 5:37, Daisuke Matsuda 写道:
> When running the test_resize_cq testcase from rdma-core, polling a
> completion queue from userspace may occasionally hang and eventually fail
> with a timeout:
> =====
> ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
> Test resize CQ, start with specific value and then increase and decrease
> ----------------------------------------------------------------------
> Traceback (most recent call last):
>      File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
>        u.poll_cq(self.client.cq)
>      File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
>        wcs = _poll_cq(cq, count, data)
>              ^^^^^^^^^^^^^^^^^^^^^^^^^
>      File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
>        raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
> pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs
> remaining)
> =====
> 
> The issue is caused when rxe_cq_post() fails to post a CQE due to the queue
> being temporarily full, and the CQE is effectively lost. To mitigate this,
> add a bounded busy-wait with fallback rescheduling so that CQE does not get
> lost.
> 
> Signed-off-by: Daisuke Matsuda <dskmtsd@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_cq.c | 27 +++++++++++++++++++++++++--
>   1 file changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index fffd144d509e..7b0fba63204e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -84,14 +84,36 @@ int rxe_cq_resize_queue(struct rxe_cq *cq, int cqe,
>   /* caller holds reference to cq */
>   int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>   {
> +	unsigned long flags;
> +	u32 spin_cnt = 3000;
>   	struct ib_event ev;
> -	int full;
>   	void *addr;
> -	unsigned long flags;
> +	int full;
>   
>   	spin_lock_irqsave(&cq->cq_lock, flags);
>   
>   	full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
> +	if (likely(!full))
> +		goto post_queue;
> +
> +	/* constant backoff until queue is ready */
> +	while (spin_cnt--) {
> +		full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
> +		if (!full)
> +			goto post_queue;
> +
> +		cpu_relax();
> +	}

The loop runs 3000 times.
Each iteration:

Checks queue_full()
Executes cpu_relax()

On modern CPUs, each iteration may take a few cycles, e.g., 4–10 cycles 
per iteration (depends on memory/cache).

Suppose 1 cycle = ~0.3 ns on a 3 GHz CPU, 10 cycles ≈ 3 ns
3000 iterations × 10 cycles ≈ 30,000 cycles

30000 cycles * 0.3 ns = 9000 ns = 9 microseconds

So the “critical section” while spinning is tens of microseconds, not 
milliseconds.

I was concerned that 3000 iterations might make the spin lock critical 
section too long, but based on the analysis above, it appears that this 
is still a short-duration critical section.

I am not sure if it is a big spin lock critical section or not.
If it is not,

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> +
> +	/* try giving up cpu and retry */
> +	if (full) {
> +		spin_unlock_irqrestore(&cq->cq_lock, flags);
> +		cond_resched();
> +		spin_lock_irqsave(&cq->cq_lock, flags);
> +
> +		full = queue_full(cq->queue, QUEUE_TYPE_TO_CLIENT);
> +	}
> +
>   	if (unlikely(full)) {
>   		rxe_err_cq(cq, "queue full\n");
>   		spin_unlock_irqrestore(&cq->cq_lock, flags);
> @@ -105,6 +127,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>   		return -EBUSY;
>   	}
>   
> + post_queue:
>   	addr = queue_producer_addr(cq->queue, QUEUE_TYPE_TO_CLIENT);
>   	memcpy(addr, cqe, sizeof(*cqe));
>   


