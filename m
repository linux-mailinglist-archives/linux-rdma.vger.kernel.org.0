Return-Path: <linux-rdma+bounces-21473-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sTWsLVftGGrbowgAu9opvQ
	(envelope-from <linux-rdma+bounces-21473-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 03:35:19 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08C875FC0B0
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 03:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA23A3017C1F
	for <lists+linux-rdma@lfdr.de>; Fri, 29 May 2026 01:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0AD34DCD6;
	Fri, 29 May 2026 01:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VOFEJW6y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F02853E9
	for <linux-rdma@vger.kernel.org>; Fri, 29 May 2026 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780018515; cv=none; b=qDz0I+qPmGdueC7pAW/j9U6QlqxEs16VHdEZWX47nOeNCaksliNst074qs4tj7aPVOh3RqiOc6z/S6GM8iEL4VblspnFebKerK67JSo6sEzya7ZqFniGKVbC0vrWlt3o2gk4GAuNTPM2h92tPiUADQcNygcgCShmkPe9C4kEcQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780018515; c=relaxed/simple;
	bh=CFrhf5Se033lsxQECbFBNX2VLQSs82tJq9/3AeeZE5Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH6mDfyn9HX4rx01GBBQjdmfLypscRd434lOx/B3XSHLziQloMSbTZfK33M3ALuSyMziemhtZX1BapiclpBUGiIMWMQs9beQZ2+wfQsY3c69NpOdVLR+yNZiFk9pmlb1LbYyPAzQM0Og2k3UCsXpBjrM5RzhPYnbMv1M9U3f0hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VOFEJW6y; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <19c4d945-52d9-4456-8d4f-58173b122a10@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780018511;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TNaZ70BiB3adYrqONKh/K5nWRjrmfXqH8QcaH32eqXY=;
	b=VOFEJW6yoElsGHcwdJnlNGlAWm6UMcspnx1Ztx1e0099U1d1d9/AKHJnJkEv5yPydkV5FN
	kVUQGCi+2LL46e1Yg30DkUH9A5HxMzuIL+5NOa2hB6g4NBVRwJPAPw4znvLqaiACHF5c4n
	eCa98dUSl4KXJTDIc8jQ2c415kez7f8=
Date: Thu, 28 May 2026 18:34:32 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] RDMA/rxe: fix TOCTOU heap overflow in get_srq_wqe
To: Tristan Madani <tristmd@gmail.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>
References: <20260518215040.1598586-1-tristan@talencesecurity.com>
 <20260518215040.1598586-2-tristan@talencesecurity.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260518215040.1598586-2-tristan@talencesecurity.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-21473-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,linux.dev:mid,linux.dev:dkim,talencesecurity.com:email]
X-Rspamd-Queue-Id: 08C875FC0B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/18/26 2:50 PM, Tristan Madani wrote:
> get_srq_wqe() reads wqe->dma.num_sge from the shared receive queue
> buffer, which is mapped into userspace. It validates num_sge against
> max_sge, but then re-reads the same field to calculate the memcpy
> size. A concurrent userspace thread can modify num_sge between
> validation and use, causing a heap buffer overflow when copying the
> WQE into qp->resp.srq_wqe.
> 
> Read num_sge into a local variable and use it for both the bounds
> check and the size calculation.

Thanks for reporting and analyzing this issue.

I was able to reproduce the problem locally. The race between the two 
reads of wqe->dma.num_sge is observable from userspace because the SRQ 
buffer is userspace-mapped and attacker-controlled. By modifying num_sge 
concurrently after the bounds check but before the memcpy size 
calculation, it is possible to trigger an out-of-bounds copy into 
qp->resp.srq_wqe.

Using a local cached copy of num_sge for both validation and size 
calculation fixes the issue and prevents the heap buffer overflow.

The proposed fix looks correct to me.

Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index 9cb2f6f..8a0a973 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -264,6 +264,7 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>   	struct rxe_recv_wqe *wqe;
>   	struct ib_event ev;
>   	unsigned int count;
> +	unsigned int num_sge;
>   	size_t size;
>   	unsigned long flags;
>   
> @@ -279,12 +280,13 @@ static enum resp_states get_srq_wqe(struct rxe_qp *qp)
>   	}
>   
>   	/* don't trust user space data */
> -	if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
> +	num_sge = wqe->dma.num_sge;
> +	if (unlikely(num_sge > srq->rq.max_sge)) {
>   		spin_unlock_irqrestore(&srq->rq.consumer_lock, flags);
>   		rxe_dbg_qp(qp, "invalid num_sge in SRQ entry\n");
>   		return RESPST_ERR_MALFORMED_WQE;
>   	}
> -	size = sizeof(*wqe) + wqe->dma.num_sge*sizeof(struct rxe_sge);
> +	size = sizeof(*wqe) + num_sge * sizeof(struct rxe_sge);
>   	memcpy(&qp->resp.srq_wqe, wqe, size);
>   
>   	qp->resp.wqe = &qp->resp.srq_wqe.wqe;


