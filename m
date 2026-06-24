Return-Path: <linux-rdma+bounces-22448-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id A2nfDCnnO2ppfAgAu9opvQ
	(envelope-from <linux-rdma+bounces-22448-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 16:18:17 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CD66BF05D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 16:18:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=BlXyAMiP;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22448-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22448-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3109300F52D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Jun 2026 14:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E653BD63C;
	Wed, 24 Jun 2026 14:17:33 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97553BCD3D
	for <linux-rdma@vger.kernel.org>; Wed, 24 Jun 2026 14:17:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782310653; cv=none; b=CK+2Gz8enFKX0X4WJB9EfhitP1vv1aIDdgw2QYClOMPCbQNhbPnsaZOgiVL3A2+2F4Gc+EqHP1qnL7G21fDmmAjc1TURk4cdmgAaKmM/MvwAZUsYGZAfJ8ki8+k4hfr3Z7lYSV1LYMCj59yhbqALVjNA/Chz29nQwJw8hunX9cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782310653; c=relaxed/simple;
	bh=5hSgeoSWJSRpago6TbMqK7JDZoc9A25CfcxutslSlCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TnZhT5MfOzDmtrsdvLZ+IdPWQ3GLpZ0fGQSbIqutVCmnnMBn1FecMSNqGyW5qOBkP3R8h1xOkY2h4recKCBGCbn7QaOMDDBUMurVy2xD8rnw3s8fySCpV5KwlI1uXLITs+6e1NLuesUVq621fBzqiOWJ8f9GFYy+vh+zEua3nE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BlXyAMiP; arc=none smtp.client-ip=95.215.58.178
Message-ID: <0b131e1d-0459-4524-974b-17870172a87f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782310649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1V3GV21sCx/eIQ00kyK522+MLAjRj/BfJbTXfGGiQYA=;
	b=BlXyAMiP688rzUQbhSl60KB2qv/94n5+6dwIazeZIFd+Jeb342FkzYxRy5J5jyIi5GmKNu
	x+PCYaN5k3fAthHOGC3rGDHCIcvZQyQvoDsEusf7P9F8jZeMrBPyLtm/UPu6E0Q01eBd7i
	0LRFWIPz53Tp6lEh0KE0JrlsTTR47P0=
Date: Wed, 24 Jun 2026 16:16:50 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/siw: publish QP after initialization
To: Ruoyu Wang <ruoyuw560@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260620155306.78919-1-ruoyuw560@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260620155306.78919-1-ruoyuw560@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:ruoyuw560@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22448-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,ziepe.ca,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:dkim,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 86CD66BF05D

On 20.06.2026 17:53, Ruoyu Wang wrote:
> siw_create_qp() allocates a QP number before the queues, CQ pointers,
> state, completion, and device list entry are ready. A QPN lookup can
> therefore reach a QP that is still being constructed if the object is
> published at allocation time.
> 
> Reserve the QPN with an empty XArray entry first. Publish the QP object
> only after the kernel-visible QP state is initialized and just before
> siw_create_qp() returns it to the caller.
> 
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
>   drivers/infiniband/sw/siw/siw.h       |  1 +
>   drivers/infiniband/sw/siw/siw_qp.c    | 26 ++++++++++++++++++--------
>   drivers/infiniband/sw/siw/siw_verbs.c | 12 +++++++++++-
>   3 files changed, 30 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/siw/siw.h b/drivers/infiniband/sw/siw/siw.h
> index f5fd71717b80..ade7c96135c2 100644
> --- a/drivers/infiniband/sw/siw/siw.h
> +++ b/drivers/infiniband/sw/siw/siw.h
> @@ -511,6 +511,7 @@ void siw_send_terminate(struct siw_qp *qp);
>   void siw_qp_get_ref(struct ib_qp *qp);
>   void siw_qp_put_ref(struct ib_qp *qp);
>   int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp);
> +int siw_qp_publish(struct siw_qp *qp);
>   void siw_free_qp(struct kref *ref);
>   
>   void siw_init_terminate(struct siw_qp *qp, enum term_elayer layer,
> diff --git a/drivers/infiniband/sw/siw/siw_qp.c b/drivers/infiniband/sw/siw/siw_qp.c
> index bb780e3904a2..1a9135d9a2a7 100644
> --- a/drivers/infiniband/sw/siw/siw_qp.c
> +++ b/drivers/infiniband/sw/siw/siw_qp.c
> @@ -1281,15 +1281,25 @@ void siw_rq_flush(struct siw_qp *qp)
>   
>   int siw_qp_add(struct siw_device *sdev, struct siw_qp *qp)
>   {
> -	int rv = xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, qp, xa_limit_32b,
> -			  GFP_KERNEL);
> +	qp->sdev = sdev;
>   
> -	if (!rv) {
> -		kref_init(&qp->ref);
> -		qp->sdev = sdev;
> -		siw_dbg_qp(qp, "new QP\n");
> -	}
> -	return rv;
> +	return xa_alloc(&sdev->qp_xa, &qp->base_qp.qp_num, NULL,
> +			xa_limit_32b, GFP_KERNEL);
> +}
> +
> +int siw_qp_publish(struct siw_qp *qp)
> +{
> +	void *old;
> +
> +	kref_init(&qp->ref);
> +
> +	old = xa_store(&qp->sdev->qp_xa, qp_id(qp), qp, GFP_KERNEL);
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
> index 1e1d262a4ae2..71bc0cc59e3d 100644
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
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
> +	rv = siw_qp_publish(qp);

To avoid this transient visibility of a not-yet-initialized
QP - can't we just move siw_qp_add() to the end of the
siw_create_qp() function?


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


