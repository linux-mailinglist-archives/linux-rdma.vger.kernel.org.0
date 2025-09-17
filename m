Return-Path: <linux-rdma+bounces-13463-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EC0B81A39
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 21:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 018B71894E37
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Sep 2025 19:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F102DCF69;
	Wed, 17 Sep 2025 19:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nYwiUIRT"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2076420E03F
	for <linux-rdma@vger.kernel.org>; Wed, 17 Sep 2025 19:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758137474; cv=none; b=SkQ5y4KIA6JJI7vabvG2nvHYXkt1xE1+h4b4Xa9AApWvinnA70mTn3jHzCbvHi+qozQd8blEhereY6O/W4YBL9a6K9Vr6nNhVk7FGPhd6Qx9eeRLmKXD4169zoXVVJvV4eU7a/yXZ7yS7pgwX3dnoEBqDQ5vrzRrsBk1qo7LUcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758137474; c=relaxed/simple;
	bh=RZnZyxoAGJixZI7UyHnJvCMzSr5eHzb1JHDa6gR5wx4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WXqYP2Li/aNIBPBqyW22ve9hXFwJaAWAknPrRHuVc0So70E0FETBk2jqmkoyhUBYUMY4hAImNJ6T+ruGoqanoM6EtREWnZmXVC+t2TQ6MAg0NlRqbPwQjdGFH/O1RheYyn/+GSIIspxU2Bsg4NOyc0C/So3A0OBilsL7iDsi8JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nYwiUIRT; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <a321729d-f8a1-4901-ae9d-f08339b5093b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758137460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J0BNl5ZVaTpZ5ArhCofyo8O0fTEGTpHVhfR9/EZhE9g=;
	b=nYwiUIRTNIiGEE1ZnVtuwqUSOqeiLmRKmM34YFiQUBkTRqeL2v036e67QKwS1bX778SHza
	WMJbqK8mY6kPTpRcUMqZuwy3AV+bvLHtQ+ZzXyt5sDf+LFFPIWGpGPtKsBHPL36GOE17QX
	R6eBb6Z5RwtM6VExi1669Pn0L97OhV8=
Date: Wed, 17 Sep 2025 12:30:56 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix race in do_task() when draining
To: Gui-Dong Han <hanguidong02@gmail.com>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 baijiaju1990@gmail.com, stable@vger.kernel.org
References: <20250917100657.1535424-1-hanguidong02@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20250917100657.1535424-1-hanguidong02@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 9/17/25 3:06 AM, Gui-Dong Han wrote:
> When do_task() exhausts its RXE_MAX_ITERATIONS budget, it unconditionally

 From the source code, it will check ret value, then set it to 
TASK_STATE_IDLE, not unconditionally.

> sets the task state to TASK_STATE_IDLE to reschedule. This overwrites
> the TASK_STATE_DRAINING state that may have been concurrently set by
> rxe_cleanup_task() or rxe_disable_task().

 From the source code, there is a spin lock to protect the state. It 
will not make race condition.

> 
> This race condition breaks the cleanup and disable logic, which expects
> the task to stop processing new work. The cleanup code may proceed while
> do_task() reschedules itself, leading to a potential use-after-free.
> 

Can you post the call trace when this problem occurred?

Hi, Jason && Leon

Please comment on this problem.

Thanks a lot.
Yanjun.Zhu

> This bug was introduced during the migration from tasklets to workqueues,
> where the special handling for the draining case was lost.
> 
> Fix this by restoring the original behavior. If the state is
> TASK_STATE_DRAINING when iterations are exhausted, continue the loop by
> setting cont to 1. This allows new iterations to finish the remaining
> work and reach the switch statement, which properly transitions the
> state to TASK_STATE_DRAINED and stops the task as intended.
> 
> Fixes: 9b4b7c1f9f54 ("RDMA/rxe: Add workqueue support for rxe tasks")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_task.c | 8 ++++++--
>   1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> index 6f8f353e9583..f522820b950c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -132,8 +132,12 @@ static void do_task(struct rxe_task *task)
>   		 * yield the cpu and reschedule the task
>   		 */
>   		if (!ret) {
> -			task->state = TASK_STATE_IDLE;
> -			resched = 1;
> +			if (task->state != TASK_STATE_DRAINING) {
> +				task->state = TASK_STATE_IDLE;
> +				resched = 1;
> +			} else {
> +				cont = 1;
> +			}
>   			goto exit;
>   		}
>   


