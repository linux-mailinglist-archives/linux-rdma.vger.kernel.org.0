Return-Path: <linux-rdma+bounces-13132-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AC7B4625A
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 20:37:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 668A61CC80EC
	for <lists+linux-rdma@lfdr.de>; Fri,  5 Sep 2025 18:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F226FA5A;
	Fri,  5 Sep 2025 18:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pGGLzriU"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E30A779CF
	for <linux-rdma@vger.kernel.org>; Fri,  5 Sep 2025 18:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097468; cv=none; b=LqmYgh5oItEQbASiQ/gsaHVKp5hrujXKnImFDXECIBnjAJ1l0dcKXgDQSg8oYK5pxKA2r4312OvShAJNddQEWBm+Xp+KasAJwi/04rOTG0murqbyzZLYQPudCW/Ss1ClGM9iGOKf3eyVNDs25Vs3nUHsaucuGNJaqxlEOY7Oyvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097468; c=relaxed/simple;
	bh=hnrmP/+pNxdXfUPKjINYP+3IVXC/H6zCKFpa8R2p3eE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=boB0YzUNbPuP1Cb8wcD3bLnWFzhlQ6gpuL8jtRddRETU1hx5tPkRTN0JJj3oN7oGGuPDwk3k97GDLkEbqfBbSYKmGHflL+BNZFnAJwvp96pscIygJbWlThlfdqDumtMZGVsGyQGEy4S8+QrBAACwTuw2qleO1P/cgtxU/nRlrhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pGGLzriU; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <81f8377e-9872-40cc-8aab-736ac2c548ee@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757097462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bNr+fPN199iKuFsHhxnohFGP55usYrSnsaOTZPUwS0k=;
	b=pGGLzriU+6TraG9G5cBAiUyg0IhneVIsZGiwPJMOb7ORdj0Ig71LadU+0gUnBy96vQOonb
	COvRnLDrU8NV9vopIzbQEvJ/Kz6xEidkXML6/ftz25ewS7mmVP3q52jOjx8QMkio2CHiFP
	CUnsZVj+lsQiyEz1Z9aqHKpjOSMCdjM=
Date: Fri, 5 Sep 2025 20:37:21 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: avoid hiding errors in siw_post_send()
To: Stefan Metzmacher <metze@samba.org>, linux-rdma@vger.kernel.org
References: <20250904173608.1590444-1-metze@samba.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20250904173608.1590444-1-metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04.09.2025 19:36, Stefan Metzmacher wrote:
> When we hit situations like "sq full", "too many sge's" or similar
> things while queueing sqes, we should remember the error before
> rv = siw_activate_tx(qp); clears the return value.
> 
> Currently we hide such errors and confuse the caller
> which is waiting (most likely forever) for a post completion
> to arrive.
> 
I agree with that overall observation. Thanks for pointing it out.

> Also if we already queued some sqes with success we need to process
This is what we already do. But we hide the initial error.

One tricky question is what to return if we have both an immediate
error and an error happening during starting/processing the send queue.
I think it is best to return the immediate error in that case since
the caller relates it with the bad_wr content. The caller may
even understand that if bad_wr is not assigned it is not an
immediate error.


> them as no error happened, but at the end we need to return the
> error relative to the bad_wr to the caller.
> 
> Cc: Bernard Metzler <bernard.metzler@linux.dev>
> Cc: linux-rdma@vger.kernel.org
> Fixes: 303ae1cdfdf7 ("rdma/siw: application interface")
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
> ---
>   drivers/infiniband/sw/siw/siw_verbs.c | 20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 556a2b4b42ed..a3f548652c37 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -770,6 +770,8 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>   
>   	unsigned long flags;
>   	int rv = 0;
> +	size_t num_queued = 0;

I don't like counters which are actually used as boolean.
Introducing an immediate error value and assigning it if needed
should be sufficient.


> +	int error = 0;
>   
>   	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
>   		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
> @@ -948,9 +950,24 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>   		sqe->flags |= SIW_WQE_VALID;
>   
>   		qp->sq_put++;
> +		num_queued++;
>   		wr = wr->next;
>   	}
>   
> +	if (unlikely(rv < 0)) {
> +		/*
> +		 * If at least one was queued
> +		 * we should start the tx, but
> +		 * still return an error with
> +		 * the bad_wr at the end.
> +		 */
> +		error = rv;
> +		if (num_queued == 0) {
> +			spin_unlock_irqrestore(&qp->sq_lock, flags);
> +			goto skip_direct_sending;
> +		}
> +	}
> +
>   	/*
>   	 * Send directly if SQ processing is not in progress.
>   	 * Eventual immediate errors (rv < 0) do not affect the involved
> @@ -982,6 +999,9 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
>   
>   	up_read(&qp->state_lock);
>   
> +	if (unlikely(error != 0))
> +		rv = error;
> +
>   	if (rv >= 0)
>   		return 0;
>   	/*

I unfortunately do not have access to build/test infrastructure until
September 18th, but just a source tree and an editor. Sorry about that.
What I would have in mind as a good patch is the following below
(untested, maybe even with spelling errors). Maybe you can take it from
there and test?

Thanks very much!
Bernard.

diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
index 2b2a7b8e93b0..7780e39b4e3e 100644
--- a/drivers/infiniband/sw/siw/siw_verbs.c
+++ b/drivers/infiniband/sw/siw/siw_verbs.c
@@ -769,7 +769,7 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
	struct siw_wqe *wqe = tx_wqe(qp);

	unsigned long flags;
-	int rv = 0;
+	int rv = 0, imm_err = 0;

	if (wr && !rdma_is_kernel_res(&qp->base_qp.res)) {
		siw_dbg_qp(qp, "wr must be empty for user mapped sq\n");
@@ -958,6 +958,14 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,
	 * processing, if new work is already pending. But rv must be passed
	 * to caller.
	 */
+	if (unlikely(rv < 0)) {
+		/*
+		 * Immediate error
+		 */
+		siw_dbg_qp(qp, "Immediate error %d\n", rv);
+		imm_err = rv;
+		*bad_wr = wr;
+	}
	if (wqe->wr_status != SIW_WR_IDLE) {
		spin_unlock_irqrestore(&qp->sq_lock, flags);
		goto skip_direct_sending;
@@ -982,15 +990,10 @@ int siw_post_send(struct ib_qp *base_qp, const struct ib_send_wr *wr,

	up_read(&qp->state_lock);

-	if (rv >= 0)
-		return 0;
-	/*
-	 * Immediate error
-	 */
-	siw_dbg_qp(qp, "error %d\n", rv);
+	if unlikely(imm_err)
+		return imm_err;

-	*bad_wr = wr;
-	return rv;
+	return (rv >= 0) ? 0 : rv;
  }

  /*



