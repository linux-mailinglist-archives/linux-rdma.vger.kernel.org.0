Return-Path: <linux-rdma+bounces-13159-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D971EB4914E
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 16:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32EA1895BD1
	for <lists+linux-rdma@lfdr.de>; Mon,  8 Sep 2025 14:25:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0BF82EC543;
	Mon,  8 Sep 2025 14:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzfj6hB/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CC332FFDC1;
	Mon,  8 Sep 2025 14:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757341504; cv=none; b=OqipP0sYnWPSCrg23OWB/SHQq3yL7qfEdR73SaVLCrvN5XRe3C221/lrVD3ZlXliwVtzSWlbbD0O2foOsRXWHallrcY4CROuT5P1kGTt1I00DVWmesOomH1VrKWNQubd1jo8o+fk8QNtXBVCqKtTrrg6dUWqkbqjZ8zSAzA4vic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757341504; c=relaxed/simple;
	bh=+NlQxgi42oWh+HtftTFZXTHY0Z27CctBEjtIacnisGA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXaK6VmHQe7fgn5I1m5O/0e5EkRYZjDtAQqiSlUsgQ/Xn3E/1Ue3UY6TCbPsfnNYXNKXMKGveeQBCSF1rviFYyze7t7jvTYFpx/BVTeq+2+Mx8G7M+kEYGcBiM9qAirGXm0t3GTQROAKclU+gajK4slNLImLbB+XirxbCoLiPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzfj6hB/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59E39C4CEF1;
	Mon,  8 Sep 2025 14:25:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757341502;
	bh=+NlQxgi42oWh+HtftTFZXTHY0Z27CctBEjtIacnisGA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fzfj6hB/QopZhk7fJQmSDVD4CPZTDykHEqRsuuudMXIpiyK1UiP0d07tJCwB626sQ
	 z8B8yG+e2J6WFu9TbuXJLSo+PQbv32KW+a0aSZZswJiWrfWgR3ig80b9dzdlkfb14d
	 mMR1WkvQYCZYOwUldRg1q+oR/uDB5k3HqJo4Xpf0fsM2jg7kHMxDhkGEqWZGs5qcAt
	 eIKVcA4eOov9k2PhIUqbtHYuKbhtbdqCijholn1csY/UeucX8ytOBtuGlELXksrlOg
	 G3rU7Neyha2AuMX2k4HtVoVD0rvsGGzswjTS/Neb85AaeuVZALPEluIVYpz80/mdCk
	 ignQZwKQHx3ew==
Date: Mon, 8 Sep 2025 17:24:57 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>, Jason Gunthorpe <jgg@ziepe.ca>,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] rdma_rxe: call comp_handler without holding
 cq->cq_lock
Message-ID: <20250908142457.GA341237@unreal>
References: <20250822081941.989520-1-philipp.reisner@linbit.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250822081941.989520-1-philipp.reisner@linbit.com>

On Fri, Aug 22, 2025 at 10:19:41AM +0200, Philipp Reisner wrote:
> Allow the comp_handler callback implementation to call ib_poll_cq().
> A call to ib_poll_cq() calls rxe_poll_cq() with the rdma_rxe driver.
> And rxe_poll_cq() locks cq->cq_lock. That leads to a spinlock deadlock.

Can you please be more specific about the deadlock?
Please write call stack to describe it.

> 
> The Mellanox and Intel drivers allow a comp_handler callback
> implementation to call ib_poll_cq().
> 
> Avoid the deadlock by calling the comp_handler callback without
> holding cq->cq_lock.
> 
> Changelog:
> v1: https://lore.kernel.org/all/20250806123921.633410-1-philipp.reisner@linbit.com/
> v1 -> v2:
> - Only reset cq->notify to 0 when invoking the comp_handler
> ====================
> 
> Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
> Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
>  drivers/infiniband/sw/rxe/rxe_cq.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_cq.c b/drivers/infiniband/sw/rxe/rxe_cq.c
> index fffd144d509e..95652001665d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_cq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_cq.c
> @@ -88,6 +88,7 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>  	int full;
>  	void *addr;
>  	unsigned long flags;
> +	bool invoke_handler = false;
>  
>  	spin_lock_irqsave(&cq->cq_lock, flags);
>  
> @@ -113,11 +114,14 @@ int rxe_cq_post(struct rxe_cq *cq, struct rxe_cqe *cqe, int solicited)
>  	if ((cq->notify & IB_CQ_NEXT_COMP) ||
>  	    (cq->notify & IB_CQ_SOLICITED && solicited)) {
>  		cq->notify = 0;
> -		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +		invoke_handler = true;
>  	}
>  
>  	spin_unlock_irqrestore(&cq->cq_lock, flags);
>  
> +	if (invoke_handler)
> +		cq->ibcq.comp_handler(&cq->ibcq, cq->ibcq.cq_context);
> +
>  	return 0;
>  }
>  
> -- 
> 2.50.1

