Return-Path: <linux-rdma+bounces-12814-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 434B5B2B71B
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 04:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 089AE7AFE98
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Aug 2025 02:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0244D25A35F;
	Tue, 19 Aug 2025 02:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="GIXkje/e"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D54E286897
	for <linux-rdma@vger.kernel.org>; Tue, 19 Aug 2025 02:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755571060; cv=none; b=KfMZgXPeDLVrPUVeOPmgEHHmM/Caj/Tz/wiTf+gI8TT4xUOoDesy1/nulpkXi16VvHHJnUdMLJyRTA/rD9NK8NmptAhhENp3VnwQJIGO3NVoRXSMuGpIdRL49BrMlfApobb7fVK4tkyvIYJFwkdXmzDJEbzVysBw66+fSFSLc0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755571060; c=relaxed/simple;
	bh=V071NYvHh5cdjm+WP3OMWffJbE+bnL9K3nYzRdqsPKY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jvadJVQbQ+/C01K6pEOQ5z5mWVMKyd6E0P38jdeKBOTeqvTzXUyXgREuBDv5OeDUG7G0JwrHhiHFFOFHlpgGQaxtdM7vyXbCYalVM1ZoEpMljhkA4wH2+9GWk1QtKCd9zQG5SLpy/2+qB1Svk7MUKmf0dj72+koQ0+ab6S0QKp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=GIXkje/e; arc=none smtp.client-ip=95.215.58.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e0f88ef5-b046-4128-8c81-ce3c7e20274c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755571054;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yb0ATGH3PpNPET0acCYFBEvAlmYh6lwPjl8Ts17Dyso=;
	b=GIXkje/eDX7CHR9aMwmqKH8qC74UAoxetJcTZbH/XIJwy4ns/8SQ0WnNYje/zOFb1ao9mn
	D1/UV4DotQJaI1MA+Z8Awe7T2+gpjfv9EiS9RMsUWFnOzMvsaBm9xDTQQNivWchQD2nw1l
	SqhXjbg6OF8UHLOPvdIwIFYF8LyhSAI=
Date: Mon, 18 Aug 2025 19:37:16 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Philipp Reisner <philipp.reisner@linbit.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250806123921.633410-1-philipp.reisner@linbit.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250806123921.633410-1-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/6 5:39, Philipp Reisner 写道:
> Allow the comp_handler callback implementation to call ib_poll_cq().
> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> 
> The Mellanox and Intel drivers allow a comp_handler callback
> implementation to call ib_poll_cq().
> 
> Avoid the deadlock by calling the comp_handler callback without
> holding cq->cw_lock.
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_cq.c | 12 +++++++-----
>   1 file changed, 7 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index fffd144d509e..1195e109f89b 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>   	int full;
>   	void *addr;
>   	unsigned long flags;
> +	u8 notify;
>   
>   	spin_lock_irqsave(&cq->cq_lock, flags);
>   
> @@ -110,14 +111,15 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>   
>   	queue_advance_producer(cq->queue, QUEUE_TYPE_TO_CLIENT);
>   
> -	if ((cq->notify & IB_CQ_NEXT_COMP) ||
> -	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
> -		cq->notify = 0;
> -		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> -	}
> +	notify = cq->notify;
> +	cq->notify = 0;

Thanks a lot. In the original source code, cq->notify is set to 0 in the 
following test cases:

if ((cq->notify & IB_CQ_NEXT_COMP) ||
	    (cq->notify & IB_CQ_SOLICITED && solicited))

but in your commit, the above test case is removed.
I am not sure if this will introduce any risk or not.

I am fine with others.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   
>   	spin_unlock_irqrestore(&cq->cq_lock, flags);
>   
> +	if ((notify & IB_CQ_NEXT_COMP) ||
> +	    (notify & IB_CQ_SOLICITED && solicited))
> +		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +
>   	return 0;
>   }
>   


