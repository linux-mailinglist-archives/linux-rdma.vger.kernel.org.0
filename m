Return-Path: <linux-rdma+bounces-22489-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 60zKOq9rPmo/FwkAu9opvQ
	(envelope-from <linux-rdma+bounces-22489-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 14:08:15 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 178D56CCD16
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 14:08:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=smFsh3tw;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22489-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22489-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 725FE3080E60
	for <lists+linux-rdma@lfdr.de>; Fri, 26 Jun 2026 12:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9963F39F9;
	Fri, 26 Jun 2026 12:05:27 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAE93F39FD
	for <linux-rdma@vger.kernel.org>; Fri, 26 Jun 2026 12:05:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782475526; cv=none; b=LW5aqSDhpY3GydiemTfuB7zYhlhOT0s9CjlbmNZk9LAw7wLQ/6Lf4znYD1D9Hd70MFqrB5byVwv58486nM09pZjZ8cLhNwVGG9FxYw+8f8Gmz0RyfHO2rCCkc7Ci58lL6ShTH+ZQ+KyJH0eQZrGEbeoYLpC1NIN7syUhexFcjlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782475526; c=relaxed/simple;
	bh=3wcH4cXkxM2OVZoXTBscehE4malZCFqueS8JvvlIoxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b+drCmim5GDnpm1NNqcdRTxHKSIC8JagrP7UUgdY95FrXVSg2gMuNal1xxMn0b8uZMK1GH+RyAiZYDTvXQ9s6qDBeEoAmpV+SY4kshE05V47UE4sc71E4N2KyJ8WoHydBVXgLN3x0f3ybYCd4T86FBorSaiJFqPdysIK/VyNDcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=smFsh3tw; arc=none smtp.client-ip=95.215.58.178
Message-ID: <224357eb-9d86-43c9-9bf2-322b6e052040@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782475522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jXNCngv7Bpaztjyl7RPQxQK4/HSjTNliLQ2Or+cNQgI=;
	b=smFsh3twdyLI4alwUPdHbSg++fNttZzkkELDDu2sWtV15xjRnmybyM1aPbkW+j1wUn8TmQ
	uCvoHBi5iRwEnj7w+ZB9eWqi/qGWQpEYA6wt31C1penfFPe0vhheoDaARRYtuFGCj3Hqdh
	9KbM0GVT6y3w70v7EagjJbZwc/A6mgc=
Date: Fri, 26 Jun 2026 14:05:01 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/siw: publish QP after initialization
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260620155306.78919-1-ruoyuw560@gmail.com>
 <20260625134426.3084850-1-ruoyuw560@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260625134426.3084850-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-22489-lists,linux-rdma=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 178D56CCD16

On 25.06.2026 15:44, Ruoyu Wang wrote:
> siw_create_qp() currently calls siw_qp_add() before the queues, CQ
> pointers, state, completion, and device list entry are ready. A QPN
> lookup can therefore reach a QP that is still being constructed.
> 
> Move the siw_qp_add() publication step to the end of siw_create_qp(),
> after the kernel-visible QP state is initialized. The QPN must still be
> known before copying the siw-specific create response to userspace, so
> reserve the QPN first with an empty XArray entry. This lets
> siw_create_qp() report the QPN while QPN lookups still return NULL until
> the QP is published.
> 
Hi Ruoyu,

I am sorry I obviously wasn't clear on the idea:

Why can't we just move the xa_alloc() thing to the bottom
of create_qp()? Your complaint was that the QP is already visible
during initialization, which might be problematic. So, if you
move that down - just before adding the qp to the siw device.
It should be safe.

Why do we fuzz around with reserving an xa entry before
actually having a qp at it, if we can do the xa entry
as a last step after qp initialization.

Thanks,
Bernard
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Suggested-by: Bernard Metzler <bernard.metzler@linux.dev>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> Changes in v2:
> - Move the siw_qp_add() publication step to the end of siw_create_qp().
> - Add siw_qp_reserve_qpn() so the udata response can still report qp_num
>    before the QP becomes visible to QPN lookups.
> 
>   drivers/infiniband/sw/siw/siw.h       |  1 +
>   drivers/infiniband/sw/siw/siw_qp.c    | 26 ++++++++++++++++++--------
>   drivers/infiniband/sw/siw/siw_verbs.c | 14 ++++++++++++--
>   3 files changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index f5fd71717b80..f8d28dd7dd86 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -510,6 +510,7 @@ void siw_send_terminate(struct siw_qp *qp);
>   
>   void siw_qp_get_ref(struct ib_qp *qp);
>   void siw_qp_put_ref(struct ib_qp *qp);
> +int siw_qp_reserve_qpn(struct siw_device *sdev, struct siw_qp *qp);
>   int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp);
>   void siw_free_qp(struct kref *ref);
>   
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
> index bb780e3904a2..7d6224ebfe71 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -1279,17 +1279,27 @@ void siw_rq_flush(struct siw_qp *qp)
>   	}
>   }
>   
> +int siw_qp_reserve_qpn(struct siw_device *sdev, struct siw_qp *qp)
> +{
> +	qp->sdev = sdev;
> +
> +	return xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, NULL,
> +			xa_limit_32b, GFP_KERNEL);
> +}
> +
>   int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp)
>   {
> -	int rv = xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, qp, xa_limit_32b,
> -			  GFP_KERNEL);
> +	void *old;
>   
> -	if (!rv) {
> -		kref_init(&qp->ref);
> -		qp->sdev = sdev;
> -		siw_dbg_qp(qp, "new QP\n");
> -	}
> -	return rv;
> +	kref_init(&qp->ref);
> +
> +	old = xa_store(&sdev->qp_xa, qp_id(qp), qp, GFP_KERNEL);
> +	if (xa_is_err(old))
> +		return xa_err(old);
> +
> +	siw_dbg_qp(qp, "new QP\n");
> +
> +	return 0;
>   }
>   
>   void siw_free_qp(struct kref *ref)
> diff --git a/drivers/infiniband/sw/siw/siw_verbs.c b/drivers/infiniband/sw/siw/siw_verbs.c
> index 1e1d262a4ae2..ef9fa9c5bf88 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -369,7 +369,7 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
>   	spin_lock_init(&qp->rq_lock);
>   	spin_lock_init(&qp->orq_lock);
>   
> -	rv = siw_qp_add(sdev, qp);
> +	rv = siw_qp_reserve_qpn(sdev, qp);
>   	if (rv)
>   		goto err_atomic;
>   
> @@ -482,14 +482,24 @@ int siw_create_qp(struct ib_qp *ibqp, struct ib_qp_init_attr *attrs,
>   		goto err_out_xa;
>   	}
>   	INIT_LIST_HEAD(&qp->devq);
> +	init_completion(&qp->qp_free);
> +
>   	spin_lock_irqsave(&sdev->lock, flags);
>   	list_add_tail(&qp->devq, &sdev->qp_list);
>   	spin_unlock_irqrestore(&sdev->lock, flags);
>   
> -	init_completion(&qp->qp_free);
> +	rv = siw_qp_add(sdev, qp);
> +	if (rv)
> +		goto err_out_list;
>   
>   	return 0;
>   
> +err_out_list:
> +	spin_lock_irqsave(&sdev->lock, flags);
> +	list_del(&qp->devq);
> +	spin_unlock_irqrestore(&sdev->lock, flags);
> +
> +	siw_put_tx_cpu(qp->tx_cpu);
>   err_out_xa:
>   	xa_erase(&sdev->qp_xa, qp_id(qp));
>   	if (uctx) {


