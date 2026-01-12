Return-Path: <linux-rdma+bounces-15475-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3DDD1429A
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 17:49:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7C0763008C94
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 16:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F74336C0D6;
	Mon, 12 Jan 2026 16:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZaznfNMs"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6012B36C0D0
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 16:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768236576; cv=none; b=RnK4cAdr6zwWderyqHq22RBotOVO4Nx4KwjrxDhC9pPgqY/+0lnN5e6Y0GFQvMLFTjT+DKQwpWmsFQaXfMC5R9wySScE8xHwjEHd2woldGTx8HneQNJ4oem/VTRVAAB4iuhj6oE2SDklTetdsX91GxWcyWkeXIweiQbziGJDpkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768236576; c=relaxed/simple;
	bh=wbfL5Q6nNcN9+KnEdnewC4kbRBoyljTK9P40etMbimU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=e4kTVEA5pAziKi5RUetFjQZGOlYaBs3K3Mu6JT2Xmp6+4a5yxdNXBOEBa7KZnTTA/VZQZT/Q2uPVT9yUUBUoMIFBgm3dtVlGX5aSdlLsdadHTQ/u75QAmLkP1oC0IPq8U/AUQpVFWbx8zKC/FqR51EkWZlApFF87jRZtwnHSD8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZaznfNMs; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c6107e72-3a96-4b93-a260-f2629883dfec@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768236560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vmVi7et+dd4LOujHUf6J1DByHvgjomFuJmcwezZNPPc=;
	b=ZaznfNMsO1Ny/j632dQH8MgLAmHoiRkKAiTJdEUJTR6WryIn1UBFeTT3prf6a7J1yQrPi1
	Kp0vUaQLYPjAebBBYVAVit8+8HtmGOMNEjoB+GZIJ2DXCNAsGZampcDe8kFNtoCeMo20W5
	a8KU8/yNiPWLjNyzcZ841VgulQp9CnA=
Date: Mon, 12 Jan 2026 08:49:11 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: Fix double free in rxe_srq_from_init
To: Jiasheng Jiang <jiashengjiangcool@gmail.com>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260112015412.29458-1-jiashengjiangcool@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260112015412.29458-1-jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

在 2026/1/11 17:54, Jiasheng Jiang 写道:
> In rxe_srq_from_init(), the queue pointer 'q' is assigned to
> 'srq->rq.queue' before copying the SRQ number to user space.
> If copy_to_user() fails, the function calls rxe_queue_cleanup()
> to free the queue, but leaves the now-invalid pointer in
> 'srq->rq.queue'.
> 
> The caller of rxe_srq_from_init() (rxe_create_srq) eventually
> calls rxe_srq_cleanup() upon receiving the error, which triggers
> a second rxe_queue_cleanup() on the same memory, leading to a
> double free.
> 
> The call trace looks like this:
>     kmem_cache_free+0x.../0x...
>     rxe_queue_cleanup+0x1a/0x30 [rdma_rxe]
>     rxe_srq_cleanup+0x42/0x60 [rdma_rxe]
>     rxe_elem_release+0x31/0x70 [rdma_rxe]
>     rxe_create_srq+0x12b/0x1a0 [rdma_rxe]
>     ib_create_srq_user+0x9a/0x150 [ib_core]
> 
> Fix this by moving 'srq->rq.queue = q' after copy_to_user.
> 
> Fixes: aae0484e15f0 ("IB/rxe: avoid srq memory leak")
> Signed-off-by: Jiasheng Jiang <jiashengjiangcool@gmail.com>
> ---
> Changelog:
> 
> v1 -> v2:
> 
> 1. Move both 'srq->rq.queue = q' and 'init->attr.max_wr = srq->rq.max_wr'
> after copy_to_user().
> 2. Add call trace for better understanding of the issue.

Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.Zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_srq.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_srq.c b/drivers/infiniband/sw/rxe/rxe_srq.c
> index 2a234f26ac10..c9a7cd38953d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_srq.c
> +++ b/drivers/infiniband/sw/rxe/rxe_srq.c
> @@ -77,9 +77,6 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
>   		goto err_free;
>   	}
>   
> -	srq->rq.queue = q;
> -	init->attr.max_wr = srq->rq.max_wr;
> -
>   	if (uresp) {
>   		if (copy_to_user(&uresp->srq_num, &srq->srq_num,
>   				 sizeof(uresp->srq_num))) {
> @@ -88,6 +85,9 @@ int rxe_srq_from_init(struct rxe_dev *rxe, struct rxe_srq *srq,
>   		}
>   	}
>   
> +	srq->rq.queue = q;
> +	init->attr.max_wr = srq->rq.max_wr;
> +
>   	return 0;
>   
>   err_free:


