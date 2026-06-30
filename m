Return-Path: <linux-rdma+bounces-22581-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id konyFEWbQ2rSdAoAu9opvQ
	(envelope-from <linux-rdma+bounces-22581-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:32:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE196E2E5F
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 12:32:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Sa6sPGf+;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22581-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22581-lists+linux-rdma=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linux.dev;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3105D3145321
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Jun 2026 10:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54DF3F0A88;
	Tue, 30 Jun 2026 10:24:39 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D49B3ECBE5
	for <linux-rdma@vger.kernel.org>; Tue, 30 Jun 2026 10:24:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782815079; cv=none; b=MvSu3/LO1sOGGKK5CoVM1MoFRjZlaPLjOUZJzij1etIRf+rOBwKWDN0oPV5mMeF2ijWdoxSIt0LmlEnAOLvsbCrZZUWoqlOaCBxZlySLKGJCqh9DyGAXnQNYVX9bLD1HMJshsfmGqvE6WmqkkbKPqXLjaLTJdPM9fp8nlMkD5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782815079; c=relaxed/simple;
	bh=T1RX38NEZHLvIHJgW3gdRS66xS/J5tTYeFva44iffQA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SwE7Nhz0eIE2eMzTtWXc/RCzz39QG5Va+YRq7i89s+RYsC18U0HIGYmdEuaXLWVb7ixBSv798sKTFjZ+fPYau3RT9YSVqbPYMcoV2O99/sg6Fmo7jTbKxIAhz1wKVUfR0TP5A+m+o4ALL85n5Ab3tqLwAVjIXvQDk0SCUA4NyM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sa6sPGf+; arc=none smtp.client-ip=95.215.58.179
Message-ID: <acd343f9-3a36-4dfc-a9c2-b1d78971a41f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1782815066;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALU4sc2VpbXSZdXG79IeIOSUsLpLNSsUvnFVjl7FnxA=;
	b=Sa6sPGf+LjaTGyd/AT5T00YpwP1LpB5kspws6BRglm5DBD+DNWvY0gN5CBM9aup4+JVqJX
	6f6RF/b8UBTkqVKKtQfnjGrCtBlcajA4tlsrAUA/XRURO2eVFL7jFP8Makhm5gG1jQo0Mo
	1izdm4sN1i+lJ8D5r7nsszBkJ/f6ofk=
Date: Tue, 30 Jun 2026 12:24:12 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4] RDMA/siw: publish QP after initialization
To: Ruoyu Wang <ruoyuw560@gmail.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260630060040.966461-1-ruoyuw560@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Bernard Metzler <bernard.metzler@linux.dev>
In-Reply-To: <20260630060040.966461-1-ruoyuw560@gmail.com>
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
	FORGED_SENDER(0.00)[bernard.metzler@linux.dev,linux-rdma@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-22581-lists,linux-rdma=lfdr.de];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,linux.dev:from_mime,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9FE196E2E5F

On 30.06.2026 08:00, Ruoyu Wang wrote:
> siw_create_qp() currently calls siw_qp_add() before the queues, CQ
> pointers, state, completion, and device list entry are ready. A QPN
> lookup can therefore reach a QP that is still being constructed.
> 
> Move siw_qp_add() to the end of siw_create_qp(), after QP
> initialization and before adding the QP to the siw device list.
> 
> Fixes: f29dd55b0236 ("rdma/siw: queue pair methods")
> Suggested-by: Bernard Metzler <bernard.metzler@linux.dev>
> Signed-off-by: Ruoyu Wang <ruoyuw560@gmail.com>
> ---
> Changes in v4:
> - Move `if (udata->outlen < sizeof(uresp))` into the second `if (udata)`
>    clause, right before ib_copy_to_udata() (Bernard Metzler).
> - Move INIT_LIST_HEAD(&qp->devq) to just before spin_lock_irqsave(),
>    close to list_add_tail() where it logically belongs (Bernard Metzler).
> 
> Changes in v3:
> - Move siw_qp_add()/xa_alloc() to the end of siw_create_qp().
> - Drop the QPN reservation helper from v2.
> 
>   drivers/infiniband/sw/siw/siw_verbs.c | 57 ++++++++++++++++----------
>   1 file changed, 35 insertions(+), 22 deletions(-)
> 
> --- a/drivers/infiniband/sw/siw/siw_verbs.c
> +++ b/drivers/infiniband/sw/siw/siw_verbs.c
> @@ -316,6 +316,7 @@
>   	struct siw_ucontext *uctx =
>   		rdma_udata_to_drv_context(udata, struct siw_ucontext,
>   					  base_ucontext);
> +	struct siw_uresp_create_qp uresp = {};
>   	unsigned long flags;
>   	int num_sqe, num_rqe, rv = 0;
>   	size_t length;
> @@ -369,11 +370,6 @@
>   	spin_lock_init(&qp->rq_lock);
>   	spin_lock_init(&qp->orq_lock);
>   
> -	rv = siw_qp_add(sdev, qp);
> -	if (rv)
> -		goto err_atomic;
> -
> -
>   	/* All queue indices are derived from modulo operations
>   	 * on a free running 'get' (consumer) and 'put' (producer)
>   	 * unsigned counter. Having queue sizes at power of two
> @@ -391,14 +387,14 @@
>   
>   	if (qp->sendq == NULL) {
>   		rv = -ENOMEM;
> -		goto err_out_xa;
> +		goto err_out;
>   	}
>   	if (attrs->sq_sig_type != IB_SIGNAL_REQ_WR) {
>   		if (attrs->sq_sig_type == IB_SIGNAL_ALL_WR)
>   			qp->attrs.flags |= SIW_SIGNAL_ALL_WR;
>   		else {
>   			rv = -EINVAL;
> -			goto err_out_xa;
> +			goto err_out;
>   		}
>   	}
>   	qp->pd = pd;
> @@ -424,7 +420,7 @@
>   
>   		if (qp->recvq == NULL) {
>   			rv = -ENOMEM;
> -			goto err_out_xa;
> +			goto err_out;
>   		}
>   		qp->attrs.rq_size = num_rqe;
>   	}
> @@ -439,11 +435,8 @@
>   	qp->attrs.state = SIW_QP_STATE_IDLE;
>   
>   	if (udata) {
> -		struct siw_uresp_create_qp uresp = {};
> -
>   		uresp.num_sqe = num_sqe;
>   		uresp.num_rqe = num_rqe;
> -		uresp.qp_id = qp_id(qp);
>   
>   		if (qp->sendq) {
>   			length = num_sqe * sizeof(struct siw_sqe);
> @@ -452,7 +445,7 @@
>   						      length, &uresp.sq_key);
>   			if (!qp->sq_entry) {
>   				rv = -ENOMEM;
> -				goto err_out_xa;
> +				goto err_out;
>   			}
>   		}
>   
> @@ -464,9 +457,23 @@
>   			if (!qp->rq_entry) {
>   				uresp.sq_key = SIW_INVAL_UOBJ_KEY;
>   				rv = -ENOMEM;
> -				goto err_out_xa;
> +				goto err_out;
>   			}
>   		}
> +	}
> +	qp->tx_cpu = siw_get_tx_cpu(sdev);
> +	if (qp->tx_cpu < 0) {
> +		rv = -EINVAL;
> +		goto err_out;
> +	}
> +	init_completion(&qp->qp_free);
> +
> +	rv = siw_qp_add(sdev, qp);
> +	if (rv)
> +		goto err_out_tx;
> +
> +	if (udata) {
> +		uresp.qp_id = qp_id(qp);
>   
>   		if (udata->outlen < sizeof(uresp)) {
>   			rv = -EINVAL;
> @@ -476,22 +483,19 @@
>   		if (rv)
>   			goto err_out_xa;
>   	}
> -	qp->tx_cpu = siw_get_tx_cpu(sdev);
> -	if (qp->tx_cpu < 0) {
> -		rv = -EINVAL;
> -		goto err_out_xa;
> -	}
> +
>   	INIT_LIST_HEAD(&qp->devq);
>   	spin_lock_irqsave(&sdev->lock, flags);
>   	list_add_tail(&qp->devq, &sdev->qp_list);
>   	spin_unlock_irqrestore(&sdev->lock, flags);
>   
> -	init_completion(&qp->qp_free);
> -
>   	return 0;
>   
>   err_out_xa:
>   	xa_erase(&sdev->qp_xa, qp_id(qp));
> +err_out_tx:
> +	siw_put_tx_cpu(qp->tx_cpu);
> +err_out:
>   	if (uctx) {
>   		rdma_user_mmap_entry_remove(qp->sq_entry);
>   		rdma_user_mmap_entry_remove(qp->rq_entry);
> 
Thanks Ruoyu, that looks good.

Acked-by: Bernard Metzler <bernard.metzler@linux.dev>

