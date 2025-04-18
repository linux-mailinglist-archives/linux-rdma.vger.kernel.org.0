Return-Path: <linux-rdma+bounces-9599-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30412A93E23
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 21:09:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7D7A1B67EBB
	for <lists+linux-rdma@lfdr.de>; Fri, 18 Apr 2025 19:09:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890B822B8C6;
	Fri, 18 Apr 2025 19:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ptQ1eUR7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD7D14EC5B
	for <linux-rdma@vger.kernel.org>; Fri, 18 Apr 2025 19:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745003349; cv=none; b=ECghPFtxYJ1KJRsKncjQTFlS0MgXavHpoDUeUZqXtItdT4t10C7xLOOlprwHsPJydamZsYsoM+2rK9RfHpdEcQZ1KcScBdP0h08nE4Ub6yR9qI7LXvKUsn3HVNju3LEvUiweOKrZK01K1dHXT1MbG9GaHM8xg156wrRNw45D4uY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745003349; c=relaxed/simple;
	bh=hU6eXmRY4wBh/a2Q8y74FkYvBxc7NBqaEaSme9pnpAo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AXNuGOKWqCAKm3Nc4dMCe/V3L0DS5fxLYzqJ8S5OmgTtrGBccG4SVTNOuwLbunLlsu3Wkppj5/q45di+1mObhc/K6EN0ydgoZoOmGFj792LxJSnRIO+mdujsYFeAQdwERdC4hUl4EnNuXpreAXJ7TC7qhucr/3ZECnnIrH3CE9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ptQ1eUR7; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bf07ce66-32e8-4069-894a-7eff120a07ff@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1745003335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HBrqOA4dgnVJQOMUUjhEMXVEgE25HZG/0klpz9S9AVE=;
	b=ptQ1eUR7ShEDLGErX83atwlw7jgts9u9ghcna7qCncCJIfcX/bMQNLtojxHmhNlgwuvvPt
	xc17g6leJ6XnthvAGSEKtiEI2L8y2JoYIvssjfMsdCawLAInkoJw3hJ0kTt5se46njTd1f
	QW8+LBge/7c1Gxj6uvsiAx/aatchc8w=
Date: Fri, 18 Apr 2025 21:08:52 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Remove unused rxe_run_task
To: linux@treblig.org, zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250418165948.241433-1-linux@treblig.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250418165948.241433-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/4/18 18:59, linux@treblig.org 写道:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> rxe_run_task() has been unused since 2024's
> commit 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")
> 
> Remove it.
> 

Thanks a lot. Please add the Fixes tags.

Fixes: 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")

And in the following comments, the function rxe_run_task is still mentioned.
"
  86 /* do_task is a wrapper for the three tasks (requester,
  87  * completer, responder) and calls them in a loop until
  88  * they return a non-zero value. It is called either
  89  * directly by rxe_run_task or indirectly if rxe_sched_task
  90  * schedules the task. They must call __reserve_if_idle to
  91  * move the task to busy before calling or scheduling.
  92  * The task can also be moved to drained or invalid
  93  * by calls to rxe_cleanup_task or rxe_disable_task.
  94  * In that case tasks which get here are not executed but
  95  * just flushed. The tasks are designed to look to see if
  96  * there is work to do and then do part of it before returning
  97  * here with a return value of zero until all the work
  98  * has been consumed then it returns a non-zero value.
  99  * The number of times the task can be run is limited by
100  * max iterations so one task cannot hold the cpu forever.
101  * If the limit is hit and work remains the task is rescheduled.
102  */
"
Not sure if you like to modify the above comments to remove rxe_run_task 
or not.

Except the above, I am fine with this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Best Regards,
Zhu Yanjun
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> ---
>   drivers/infiniband/sw/rxe/rxe_task.c | 18 ------------------
>   drivers/infiniband/sw/rxe/rxe_task.h |  2 --
>   2 files changed, 20 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 80332638d9e3..9d02d847fd78 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -234,24 +234,6 @@ void rxe_cleanup_task(struct rxe_task *task)
>   	spin_unlock_irqrestore(&task->lock, flags);
>   }
>   
> -/* run the task inline if it is currently idle
> - * cannot call do_task holding the lock
> - */
> -void rxe_run_task(struct rxe_task *task)
> -{
> -	unsigned long flags;
> -	bool run;
> -
> -	WARN_ON(rxe_read(task->qp) <= 0);
> -
> -	spin_lock_irqsave(&task->lock, flags);
> -	run = __reserve_if_idle(task);
> -	spin_unlock_irqrestore(&task->lock, flags);
> -
> -	if (run)
> -		do_task(task);
> -}
> -
>   /* schedule the task to run later as a work queue entry.
>    * the queue_work call can be called holding
>    * the lock.
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
> index a63e258b3d66..a8c9a77b6027 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.h
> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> @@ -47,8 +47,6 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
>   /* cleanup task */
>   void rxe_cleanup_task(struct rxe_task *task);
>   
> -void rxe_run_task(struct rxe_task *task);
> -
>   void rxe_sched_task(struct rxe_task *task);
>   
>   /* keep a task from scheduling */


