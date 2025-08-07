Return-Path: <linux-rdma+bounces-12620-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AEAB1D002
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 03:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67682188ED65
	for <lists+linux-rdma@lfdr.de>; Thu,  7 Aug 2025 01:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0C3192B84;
	Thu,  7 Aug 2025 01:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u1qb2Ubb"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA254190676
	for <linux-rdma@vger.kernel.org>; Thu,  7 Aug 2025 01:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528968; cv=none; b=HMBDVJjCc1joyQISwL4fZO9ZhZxY4YcznoiZ0yQI3ci+iu6Tozt5MF2F9uHkMDcyER2uPwbTUUJmqilIoL7yiUkmprr5IQP9VHtNKJzAovhnYh+ST/Vh1XVSSU+8aHhbg27ZYfi4Dc9mps6uJP9WxkHCrMysQahMOxAHSzboBfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528968; c=relaxed/simple;
	bh=B/HhbrVApmn9pq0h5M1gnl/C5pn/W6FSo7549Z36cLY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NIQpdGQGcvT8oVyJ0U95qRepbg+hqqaw4XuG19crMDtJ6einII2ZgP+ZWot4R8SRhbKGjEdsFS7WCP7TH7dSlBrtwtd+t3SOyAFqxocyBI/bZ6IgrpnJl50vaBL5JI8OthLhSbMTl3B97pBz82FwqQlVik5EbuiOrTkwwUZy2X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u1qb2Ubb; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5a31f3ef-358f-4382-8ad1-8050569a2a23@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754528963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hzQ/jmAEqx+5WztylhoXd83cleNXPFmc4NXF0vaDdo0=;
	b=u1qb2UbbuaVXfm4nJMwd/9zXSq5G7gyY1LrGFEx7eFTduBR6dB7Yz7GpPrWE1xb7PDvrl6
	saodhydnnj/E+lqYPIqO7NfcpYu7TouluXO8xFYRi1B8SK+WTYIkVznw1pLcQlUWPQyIvS
	Dwhk/c2lnCOqJKmHdWflj26r/EWVr4Q=
Date: Wed, 6 Aug 2025 18:09:06 -0700
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

ERROR: test_resize_cq (tests.test_cq.CQTest.test_resize_cq)
Test resize CQ, start with specific value and then increase and decrease
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/root/deb/rdma-core/tests/test_cq.py", line 135, in test_resize_cq
     u.poll_cq(self.client.cq)
   File "/root/deb/rdma-core/tests/utils.py", line 687, in poll_cq
     wcs = _poll_cq(cq, count, data)
           ^^^^^^^^^^^^^^^^^^^^^^^^^
   File "/root/deb/rdma-core/tests/utils.py", line 669, in _poll_cq
     raise PyverbsError(f'Got timeout on polling ({count} CQEs remaining)')
pyverbs.pyverbs_error.PyverbsError: Got timeout on polling (1 CQEs 
remaining)

After I applied your patch in kervel v6.16, I got the above errors.

Zhu Yanjun

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


