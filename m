Return-Path: <linux-rdma+bounces-12869-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A41B30C13
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 04:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3928F17ADA8
	for <lists+linux-rdma@lfdr.de>; Fri, 22 Aug 2025 02:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1998F223DC6;
	Fri, 22 Aug 2025 02:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pKZY2cE7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAAC2236E9
	for <linux-rdma@vger.kernel.org>; Fri, 22 Aug 2025 02:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755831328; cv=none; b=q4fslTc9j4LzGXQELNhk7+vVJjRYpjmgTJ8xid0UNFF9cyMxtn+j5OXKTUOCTpWWxEyiJwLZSlPddHvUiGoQCRKPqGB4KbSBn7JZLbLwI1LFqKEkm3t5WM3Xg24jwwgYEdj8ZkSArG/X2L3R8uVh1rSOB8KfrhAW9fEsmY58/pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755831328; c=relaxed/simple;
	bh=HMk8TWGTzCTLW7YPb0zkU2XY0BqUG5qimdbf5gw361s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMgeI/y7ocC858w3W/fOXwdi2Fs+fiyh64H1MvNUJs0yO/gvv1RtMIRfCOmYeuFhlKqz2ISK6GkldbmJB4bs1pJ+51df7mEy3/CwgtGd7RCGsOdQLiazhzeRnVCE6jA7f+eEywRmdH1srN3T0TwZBc8lNJNzKwvaXNFOiGMjfPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pKZY2cE7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f21730cf-f176-4771-8c31-3e49450e48f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1755831323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jkkso3+bCf2uLyTJNBDHlypMXdRC4RJMGtgYsbysuxI=;
	b=pKZY2cE7bkN2TouGLgMb6Wz5m7LqMOsqR5j3oiCpQ4mb5Z59zd+fjybW7UAFZkAVD8Nop5
	oB8qsiQ2F1eNgQg9iawXpinouezKrL3rR2irsL00Mjs3j3SHl+EbuzsPj8tQLKaHpaNYXx
	C7SRgnIgUdaEyXpkdapAS5Xcrd/UbMw=
Date: Thu, 21 Aug 2025 19:54:49 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] rdma_rxe: call comp_handler without holding cq->cq_lock
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: jgg@ziepe.ca, leon@kernel.org, linux-kernel@vger.kernel.org,
 linux-rdma@vger.kernel.org, zyjzyj2000@gmail.com
References: <e0f88ef5-b046-4128-8c81-ce3c7e20274c@linux.dev>
 <20250819172427.645153-1-philipp.reisner@linbit.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20250819172427.645153-1-philipp.reisner@linbit.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2025/8/19 10:24, Philipp Reisner 写道:
> Allow the comp_handler callback implementation to call ib_poll_cq().
> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.
> 
> The Mellanox and Intel drivers allow a comp_handler callback
> implementation to call ib_poll_cq().
> 
> Avoid the deadlock by calling the comp_handler callback without
> holding cq->cq_lock.
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> ---

The new patch should be sent in a new mail thread; it is not appropriate 
to reply to the old thread.

Additionally:

The subject line does not include a version number.

The commit log of the new patch does not contain a changelog.

Other than these issues, I am fine with this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   drivers/infiniband/sw/rxe/rxe_cq.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index fffd144d509e..95652001665d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>   	int full;
>   	void *addr;
>   	unsigned long flags;
> +	bool invoke_handler = false;
>   
>   	spin_lock_irqsave(&cq->cq_lock, flags);
>   
> @@ -113,11 +114,14 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>   	if ((cq->notify & IB_CQ_NEXT_COMP) ||
>   	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
>   		cq->notify = 0;
> -		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +		invoke_handler = true;
>   	}
>   
>   	spin_unlock_irqrestore(&cq->cq_lock, flags);
>   
> +	if (invoke_handler)
> +		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +
>   	return 0;
>   }
>   


