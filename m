Return-Path: <linux-rdma+bounces-1689-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8AE892BB9
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Mar 2024 16:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F8ADB2203E
	for <lists+linux-rdma@lfdr.de>; Sat, 30 Mar 2024 15:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68EE839FC1;
	Sat, 30 Mar 2024 15:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X5icV5T8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7753BB2A
	for <linux-rdma@vger.kernel.org>; Sat, 30 Mar 2024 15:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711810899; cv=none; b=Jc42pQrIhkIFeQ6ABhOy9TTIwtmt7k9klbrJO9qOUPppHzAdq3NCL3tThdA3f1TuyMLD5iy88VhfX3XD7/Cbr9UP7j/tFtlj4JJnNmQaAwaEDZX0LXNxkrLHWsvieBr4FV7dhOx+f6H+EgbYL9PCc2Cvm09mZHyVbvXT2q6FTpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711810899; c=relaxed/simple;
	bh=EiHDak1LlcjzlO5HWUi/0K+kMJysy+vv+BJl//exVBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sRz2sim1ShPayGzjCXiAl6aAAwhdewgick49OdsiDWaTk1Rej795ThNVg5fX8tv56E/a5cR+C7LpuIJkXhmk10ibVuj3oovxXW3Kp5w6ZKBn8qKesvT9tnibpxxBKzbtjbAEKzJEylAlNr1DGmnM0RXX8jaBlVZP+/MRmY2wfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X5icV5T8; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <43de471c-249d-484e-8155-891eefed8b03@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1711810894;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TIY2HeIcVbfRAM+gJyKucmTKInVZABsc6uRhnPoevZU=;
	b=X5icV5T84CgcL5wp+KMZpRSXViuqe6APyPBVmXVwQXRfOhC3mxDe2fN3re/r33NB3OX5vx
	PeRBfgdIVbxmPONaq0StFqdycqJREbdrDNZ25/4Lzwhcg/kYq9EKK1rLxBHyWNENDMMITo
	hOnlTq31X1xRCrPnSw2+hRZOSZ7m3eA=
Date: Sat, 30 Mar 2024 16:01:29 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-next v3 02/12] RDMA/rxe: Allow good work requests to
 be executed
To: Bob Pearson <rpearsonhpe@gmail.com>, jgg@ziepe.ca, leon@kernel.org,
 linux-rdma@vger.kernel.org, jhack@hpe.com
References: <20240329145513.35381-2-rpearsonhpe@gmail.com>
 <20240329145513.35381-5-rpearsonhpe@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20240329145513.35381-5-rpearsonhpe@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/3/29 15:55, Bob Pearson 写道:
> A previous commit incorrectly added an 'if(!err)' before scheduling
> the requester task in rxe_post_send_kernel(). But if there were send
> wrs successfully added to the send queue before a bad wr they might
> never get executed.
>
> This commit fixes this by scheduling the requester task if any wqes were
> successfully posted in rxe_post_send_kernel() in rxe_verbs.c.
>
> Signed-off-by: Bob Pearson <rpearsonhpe@gmail.com>
> Fixes: 5bf944f24129 ("RDMA/rxe: Add error messages")
> ---
>   drivers/infiniband/sw/rxe/rxe_verbs.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/sw/rxe/rxe_verbs.c b/drivers/infiniband/sw/rxe/rxe_verbs.c
> index 614581989b38..a49784e5156c 100644
> --- a/drivers/infiniband/sw/rxe/rxe_verbs.c
> +++ b/drivers/infiniband/sw/rxe/rxe_verbs.c
> @@ -888,6 +888,7 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
>   {
>   	int err = 0;
>   	unsigned long flags;
> +	int good = 0;

If we use RCT (Reverse Christmas Tree) to sort out the above variable 
declaration, it is better.

Thanks,

Zhu Yanjun

>   
>   	spin_lock_irqsave(&qp->sq.sq_lock, flags);
>   	while (ibwr) {
> @@ -895,12 +896,15 @@ static int rxe_post_send_kernel(struct rxe_qp *qp,
>   		if (err) {
>   			*bad_wr = ibwr;
>   			break;
> +		} else {
> +			good++;
>   		}
>   		ibwr = ibwr->next;
>   	}
>   	spin_unlock_irqrestore(&qp->sq.sq_lock, flags);
>   
> -	if (!err)
> +	/* kickoff processing of any posted wqes */
> +	if (good)
>   		rxe_sched_task(&qp->req.task);
>   
>   	spin_lock_irqsave(&qp->state_lock, flags);

