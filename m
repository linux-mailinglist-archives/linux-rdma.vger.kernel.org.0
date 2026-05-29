Return-Path: <linux-rdma+bounces-21474-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id g/ezFFnuGGohpAgAu9opvQ
	(envelope-from <linux-rdma+bounces-21474-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 03:39:37 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B1FB75FC0C2
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 03:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 699FB303C667
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 01:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E97F352030;
	Fri, 29 May 2026 01:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C5d/Nfue"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C5134E762
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 01:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018772; cv=none; b=D7S6Jib29kADKeIBfCi7ezC1091Tj4LIwzOJ+34m1ECDvu456nGLFUDfb0hRwUI7TtMZtlzun60+pZqHi3Kw4xaP90toYZnTRHrrBDzic81tQHelxNQ5LMcoLVWwyosxQef06QWSCixRwLFi5YkAaONaQlHZtzDWTOHJgdQNMIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018772; c=relaxed/simple;
	bh=CrJHONzal1igCLU2RdflDf06+t5jtDPZKAZr+IvVkF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j7jSNP9uICRQqGcZm4qTsGBaDu8qeWtkvTEODsy70nvo9v6jO/rYSHRFOG/ONxQgnCuHgMzMLyy54uC2IHIMtK8qgkKHxSI1gvgfmzFvC/TU+Cl1Qj1jfoPz1MHBc2eyqQ1gLeXuhA7SxYlvOIzx/Sb2XMfBVzQ+93Iqw2XRM1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C5d/Nfue; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ca22a09a-9682-44f2-b10c-9daac2b2928f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780018768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LkcsFsPTbBgQrtVkPUc/bE1jIBwePz193zFdZhGY59o=;
	b=C5d/NfueLV+xeLe5/k1q9jD986DQovzY1Zlybl21LdHBd3qwIal6tDvxbTS+NLg5qvW+fP
	b3jWHdyguErYo88dG9JbgNyUhojBjPteoa0PEZncqjFPDhgyRIXojt9ozJNutDu4sAQ8a8
	FlMyzjJSnJEQ6Sz8ipev1ty0bcrF/0Y=
Date: Thu, 28 May 2026 18:39:05 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 2/2] RDMA/rxe: copy WQE to local buffer in non-SRQ receive
 path
To: Tristan Madani <tristmd@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <20260518215040.1598586-3-tristan@talencesecurity.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260518215040.1598586-3-tristan@talencesecurity.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21474-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: B1FB75FC0C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 2:50 PM, Tristan Madani wrote:
> For non-SRQ QPs, the responder reads WQE fields directly from the
> shared queue buffer mapped into userspace. This allows a malicious
> user to modify fields like num_sge or sge entries while the kernel
> is processing the WQE, leading to out-of-bounds reads in
> rxe_resp_check_length() and copy_data().
> 
> Introduce get_recv_wqe() that validates num_sge and copies the WQE
> to a kernel-local buffer before processing, matching the approach
> already used for SRQ WQEs in get_srq_wqe(). The srq_wqe buffer is
> reused since SRQ and non-SRQ paths are mutually exclusive per QP.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 27 ++++++++++++++++++++++++---
>   1 file changed, 24 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 8a0a973..43e8d86 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -310,6 +310,29 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>   	return RESPST_CHK_LENGTH;
>   }
>   
> +static enum resp_states get_recv_wqe(struct rxe_qp *qp)
> +{
> +	struct rxe_queue *q = qp->rq.queue;
> +	struct rxe_recv_wqe *wqe;
> +	unsigned int num_sge;
> +	size_t size;
> +
> +	wqe = queue_head(q, QUEUE_TYPE_FROM_CLIENT);
> +	if (!wqe)
> +		return RESPST_ERR_RNR;
> +
> +	num_sge = wqe->dma.num_sge;
> +	if (unlikely(num_sge > qp->rq.max_sge)) {
> +		rxe_dbg_qp(qp, "invalid num_sge in recv WQE\n");
> +		return RESPST_ERR_MALFORMED_WQE;
> +	}
> +	size = sizeof(*wqe) + num_sge * sizeof(struct rxe_sge);
> +	memcpy(&qp->resp.srq_wqe, wqe, size);
> +
> +	qp->resp.wqe = &qp->resp.srq_wqe.wqe;
> +	return RESPST_CHK_LENGTH;
> +}

This approach makes sense to me. Copying the receive WQE into a
kernel-local buffer before processing closes the race window against
userspace modifications and aligns the non-SRQ path with the existing
SRQ handling model.

One minor suggestion: it may be better to rename `get_recv_wqe()` to
`rxe_get_recv_wqe()` for consistency with the RXE naming convention
used elsewhere in the driver and to avoid overly generic helper names.


Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> +
>   static enum resp_states check_resource(struct rxe_qp *qp,
>   				       struct rxe_pkt_info *pkt)
>   {
> @@ -330,9 +353,7 @@ static enum resp_states check_resource(struct rxe_qp *qp,
>   		if (srq)
>   			return get_srq_wqe(qp);
>   
> -		qp->resp.wqe = queue_head(qp->rq.queue,
> -				QUEUE_TYPE_FROM_CLIENT);
> -		return (qp->resp.wqe) ? RESPST_CHK_LENGTH : RESPST_ERR_RNR;
> +		return get_recv_wqe(qp);
>   	}
>   
>   	return RESPST_CHK_LENGTH;


