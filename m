Return-Path: <linux-rdma+bounces-9600-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 130BFA94096
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Apr 2025 02:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4B8A65E7
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Apr 2025 00:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B32FA12B63;
	Sat, 19 Apr 2025 00:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="kjZR2+Wq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239D93232;
	Sat, 19 Apr 2025 00:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745022134; cv=none; b=RQCa/DnH8/SZunkW4blM0uvNK8OxuLSE1O2bWZ9pbOfVhY86lZRMoE+Bn/Cwt5UBKoaA2TNlB5A+JeDX6p4sk16b9mDDZuqZmBrNZ0+jXY8TLte4vcJCMwzWS5XTzp3Mo1d2J8XY1VU4hBtL5DnlFPK4HyqqFHn+EXr4wlA2Mkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745022134; c=relaxed/simple;
	bh=sady8YJRJXVmxiHPDhDApwxkv6YC6fPfISQ6M56Cvbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eVA/R4e1jrLDtcOsmKJa6tdRu30szSbBu1susgDW+dG/uG18IhnzFuUBO7FvddgwFtK+PpI7k8TEfQ9+x/DoKqCCPhrhtJrE7WNUfuzR/q3WEIUZ2AJBQCcP1BBWz60MuCMnrSLcr1ObeR5W51xCXSKS+61YzSbhrQH72Tw9kLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=kjZR2+Wq; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=Content-Type:MIME-Version:Message-ID:Subject:From:Date:From
	:Subject; bh=otKc+S46bwpVZkZBNdXVAJNZQaZf6mFC5EJT8PDuBQc=; b=kjZR2+WqTKAuaTvR
	E2vLv3V4bsCtYV/mUl6P8zTXoMFLuPu5HMhN6RVhOcm7jZGg/FHBLahDO+dl/FccD1x6w9Pfx346D
	//wKlz1T8phK0kvl5tzFUxAA+XHPgyM5AgTKyH4UEFUg1Ho1PdnZ3ZSbI3hZgPG1a3S3z1QacaMYY
	C+8Rura3O8VnvRkbXIEp+i5bk+yBNcp4psSN+3mvo9NRmT9lxXH4WApMj1xAhNV3RE805cQQud+aJ
	4vHawoE7Ok51FGo+tmw5JNQfYJBqTa2bJWre1cD6LFc9q4SkpIJkgArEG24Az40XdezEuvTpofrJe
	e3ofR0AGuqP/5qVCpQ==;
Received: from dg by mx.treblig.org with local (Exim 4.96)
	(envelope-from <dg@treblig.org>)
	id 1u5vy9-00Cbg0-0t;
	Sat, 19 Apr 2025 00:22:05 +0000
Date: Sat, 19 Apr 2025 00:22:05 +0000
From: "Dr. David Alan Gilbert" <linux@treblig.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, leon@kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/rxe: Remove unused rxe_run_task
Message-ID: <aALsrZxAqhwxDD7d@gallifrey>
References: <20250418165948.241433-1-linux@treblig.org>
 <bf07ce66-32e8-4069-894a-7eff120a07ff@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bf07ce66-32e8-4069-894a-7eff120a07ff@linux.dev>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/6.1.0-21-amd64 (x86_64)
X-Uptime: 00:18:27 up 345 days, 11:32,  1 user,  load average: 0.00, 0.00,
 0.00
User-Agent: Mutt/2.2.12 (2023-09-09)

* Zhu Yanjun (yanjun.zhu@linux.dev) wrote:
> 在 2025/4/18 18:59, linux@treblig.org 写道:
> > From: "Dr. David Alan Gilbert" <linux@treblig.org>
> > 
> > rxe_run_task() has been unused since 2024's
> > commit 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")
> > 
> > Remove it.
> > 
> 

Hi,

> Thanks a lot. Please add the Fixes tags.
> Fixes: 23bc06af547f ("RDMA/rxe: Don't call direct between tasks")

Thanks for the review;  I've tended to avoid the fixes tag because
people use 'Fixes' to automatically pull in patches to stable or
downstream kernels, and there is no need for them to do that for
a cleanup patch.

> And in the following comments, the function rxe_run_task is still mentioned.
> "
>  86 /* do_task is a wrapper for the three tasks (requester,
>  87  * completer, responder) and calls them in a loop until
>  88  * they return a non-zero value. It is called either
>  89  * directly by rxe_run_task or indirectly if rxe_sched_task
>  90  * schedules the task. They must call __reserve_if_idle to
>  91  * move the task to busy before calling or scheduling.
>  92  * The task can also be moved to drained or invalid
>  93  * by calls to rxe_cleanup_task or rxe_disable_task.
>  94  * In that case tasks which get here are not executed but
>  95  * just flushed. The tasks are designed to look to see if
>  96  * there is work to do and then do part of it before returning
>  97  * here with a return value of zero until all the work
>  98  * has been consumed then it returns a non-zero value.
>  99  * The number of times the task can be run is limited by
> 100  * max iterations so one task cannot hold the cpu forever.
> 101  * If the limit is hit and work remains the task is rescheduled.
> 102  */
> "
> Not sure if you like to modify the above comments to remove rxe_run_task or
> not.

Would it be correct to just reword:
>  88  *                               It is called either
>  89  * directly by rxe_run_task or indirectly if rxe_sched_task
>  90  * schedules the task.

to:
   It is called indirectly when rxe_sched_task schedules the task.

> Except the above, I am fine with this commit.

Thanks!

> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Dave

> Best Regards,
> Zhu Yanjun
> > Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
> > ---
> >   drivers/infiniband/sw/rxe/rxe_task.c | 18 ------------------
> >   drivers/infiniband/sw/rxe/rxe_task.h |  2 --
> >   2 files changed, 20 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> > index 80332638d9e3..9d02d847fd78 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_task.c
> > +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> > @@ -234,24 +234,6 @@ void rxe_cleanup_task(struct rxe_task *task)
> >   	spin_unlock_irqrestore(&task->lock, flags);
> >   }
> > -/* run the task inline if it is currently idle
> > - * cannot call do_task holding the lock
> > - */
> > -void rxe_run_task(struct rxe_task *task)
> > -{
> > -	unsigned long flags;
> > -	bool run;
> > -
> > -	WARN_ON(rxe_read(task->qp) <= 0);
> > -
> > -	spin_lock_irqsave(&task->lock, flags);
> > -	run = __reserve_if_idle(task);
> > -	spin_unlock_irqrestore(&task->lock, flags);
> > -
> > -	if (run)
> > -		do_task(task);
> > -}
> > -
> >   /* schedule the task to run later as a work queue entry.
> >    * the queue_work call can be called holding
> >    * the lock.
> > diff --git a/drivers/infiniband/sw/rxe/rxe_task.h b/drivers/infiniband/sw/rxe/rxe_task.h
> > index a63e258b3d66..a8c9a77b6027 100644
> > --- a/drivers/infiniband/sw/rxe/rxe_task.h
> > +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> > @@ -47,8 +47,6 @@ int rxe_init_task(struct rxe_task *task, struct rxe_qp *qp,
> >   /* cleanup task */
> >   void rxe_cleanup_task(struct rxe_task *task);
> > -void rxe_run_task(struct rxe_task *task);
> > -
> >   void rxe_sched_task(struct rxe_task *task);
> >   /* keep a task from scheduling */
> 
-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

