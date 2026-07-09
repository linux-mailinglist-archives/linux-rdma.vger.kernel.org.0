Return-Path: <linux-rdma+bounces-22974-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id E6E2GXzqT2rdqAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22974-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:37:48 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 12BFA73455E
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:37:48 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Ry497XDY;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22974-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22974-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7979D3027351
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 18:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238354DBD7E;
	Thu,  9 Jul 2026 18:37:36 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7E84DB548
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 18:37:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783622254; cv=none; b=qOzWgsW9wycoNHfGAq+xevCEJjD1ZisuCuCgllt57gmh5snYimD12LEMVqIGHERUooCxeZxZQfGYeZb4M7g85aWvijoYC5X3ymLMBBepPcyfkiMJU0ZXdieSCQLcKrO1fgBylVL9r7SijQ7lSuedvpWqhWwzATkV/JUnTUJWHG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783622254; c=relaxed/simple;
	bh=hPON6rdlsK6qogJ8M57JeOTmmKD2AXgVYFZaBT5fhB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s3F41B4+++QAWjWKpJvHmxbgsoYg19sO6NBYIxxoxKK57uW840cBNMQZ6+/0s55CFcAUhbA3EjlW7aWoJRXkUp20XBmsZ5FQblhBng4JtxCq4qDnByxJiGH00/+pn0uRcmG8zseUuPz+jSwRsvpKGNq9jZAGjsPj12zPWeJ3okA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ry497XDY; arc=none smtp.client-ip=95.215.58.180
Message-ID: <3f5b2bfb-9ca0-4ece-aae6-177e7c845e08@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783622239;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hTGRpd5XR3qZvQOxUVhMyy6tNzwyK8gZeBNAdQOz/8g=;
	b=Ry497XDYc1Wp+nl06h0j6od+zPtCjpLw6ULiWPX62CZCiYeOLKlwRgiFoZUBJXBxE5ZFjZ
	ROpswGdC/KJPctGNj6BpfIsh8FotfcGAUrr7vzQIOseeoleiVzlspD0TNX2nm/WFY6C0/c
	Gez2gIOxXb1Pv+iQe4vJMMXmHdd7fFw=
Date: Thu, 9 Jul 2026 11:37:08 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: validate num_sge/cur_sge before indexing
 wqe->dma.sge[]
To: Ibrahim Hashimov <security@auditcode.ai>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260708224534.1206-1-security@auditcode.ai>
 <20260709072656.9074-1-security@auditcode.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260709072656.9074-1-security@auditcode.ai>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22974-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:security@auditcode.ai,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:yanjun.zhu@linux.dev,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_TO(0.00)[auditcode.ai,gmail.com,ziepe.ca,kernel.org,linux.dev];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,auditcode.ai:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 12BFA73455E

On 7/9/26 12:26 AM, Ibrahim Hashimov wrote:
> A user QP's send queue (qp->sq.queue) is a shared ring the userspace
> application writes to directly via mmap (vmalloc_user(), see
> rxe_queue.c). For such a QP, rxe_post_send() takes the qp->is_user
> branch and only schedules the requester task -- it never validates or
> copies the posted WQE:
> 
> 	drivers/infiniband/sw/rxe/rxe_verbs.c:
> 		if (qp->is_user) {
> 			rxe_sched_task(&qp->send_task);
> 			...
> 		}
> 
> The requester then consumes the WQE in place straight out of that
> mmap'd ring:
> 
> 	rxe_req.c:	wqe = req_next_wqe(qp);
> 	rxe_req.c:	err = copy_data(qp->pd, 0, &wqe->dma,
> 					payload_addr(pkt), payload,
> 					RXE_FROM_MR_OBJ);
> 
> copy_data() indexes the per-WQE sge array with the attacker-controlled
> cur_sge field and dereferences it (once there is payload to copy):
> 
> 	rxe_mr.c:	struct rxe_sge *sge = &dma->sge[dma->cur_sge];
> 	rxe_mr.c:	...
> 	rxe_mr.c:	if (sge->length && (offset < sge->length)) {
> 
> dma->sge[] is a flex array whose real backing storage is exactly
> qp->sq.max_sge entries per WQE slot (see rxe_qp.c, wqe_size computed
> from max_sge at QP create time). Since a user QP's WQE bytes are
> entirely attacker-supplied, both wqe->dma.num_sge and wqe->dma.cur_sge
> can be set to arbitrary values independent of each other and of
> max_sge. Only the *kernel*-QP post path bounds num_sge:
> 
> 	rxe_verbs.c: validate_send_wr()
> 		if (num_sge > sq->max_sge) {
> 			rxe_err_qp(qp, "num_sge > max_sge\n");
> 
> but that function is only reachable from rxe_post_one_send() for
> kernel-owned QPs; it is never consulted for a user QP's raw WQE.
> 
> The sibling receive path already has the equivalent guard, with the
> literal comment documenting exactly why it is required:
> 
> 	rxe_resp.c: get_srq_wqe()
> 		/* don't trust user space data */
> 		if (unlikely(wqe->dma.num_sge > srq->rq.max_sge)) {
> 			...
> 			rxe_dbg_qp(qp, "invalid num_sge in SRQ entry\n");
> 			return RESPST_ERR_MALFORMED_WQE;
> 		}
> 
> The send/requester path has no analogous check, so a local,
> unprivileged user who can open /dev/infiniband/uverbs* and create a
> user QP on a soft-RoCE (rxe) link can hand-craft a WQE in the shared
> send queue with an out-of-range wqe->dma.cur_sge (or an oversized
> wqe->dma.num_sge) and ring the send doorbell. rxe_requester() then
> calls copy_data(), which dereferences &dma->sge[cur_sge] out of the
> bounds of the per-WQE sge array -- a vmalloc out-of-bounds *read*
> (confirmed via KASAN: "KASAN: vmalloc-out-of-bounds in copy_data"),
> reliably panicking the kernel (local DoS). sge->addr itself is still
> bounds-checked later by lookup_mr()/rxe_mr_copy(), so the primitive is
> an OOB read of sge metadata, not an arbitrary read/write primitive.
> 
> Fix this the same way get_srq_wqe() already does for SRQ entries:
> bound the fields pulled from the (possibly user-mapped) send queue
> entry before they are used to index wqe->dma.sge[], right where the
> requester fetches the next WQE off the ring in rxe_requester(). num_sge
> is capped at qp->sq.max_sge (matching the sibling SRQ check and the
> kernel-QP validate_send_wr() check). cur_sge is bounded only when the
> WQE actually carries payload (wqe->dma.resid): copy_data() dereferences
> dma->sge[cur_sge] only after its own length == 0 early return, so a
> zero-payload WQE never touches the sge array and must not be rejected
> -- notably that is the only kind of WQE a max_sge == 0 QP can post
> (qp->sq.max_sge is itself derived from user-supplied max_send_sge /
> max_inline_data and may be 0). Gating on resid rather than num_sge is
> deliberate: payload is wqe->dma.resid, which is independent of num_sge,
> so a WQE with num_sge == 0 but a large resid and an out-of-range
> cur_sge would still reach the sge dereference.
> 
> This is a long-standing bug in the rxe (soft-RoCE) driver: the
> qp->is_user bypass in rxe_post_send() and the unbounded
> &dma->sge[dma->cur_sge] indexing in copy_data() have been present
> since the driver was introduced.
> 
> Runtime-verified on a v6.19 KASAN (CONFIG_KASAN_VMALLOC=y) stand: a
> reproducer that posts a user QP send WQE with an out-of-range cur_sge
> reliably tripped "KASAN: vmalloc-out-of-bounds in copy_data" (an
> out-of-bounds read) before this patch, and no longer triggers that
> report with the patch applied.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
> v2: address Zhu Yanjun's review of v1
>      (https://lore.kernel.org/linux-rdma/20260708224534.1206-1-security@auditcode.ai/):
>      qp->sq.max_sge can legitimately be 0, and v1's unconditional
>      "cur_sge >= max_sge" check then wrongly rejected a valid zero-payload
>      WQE. Gate the cur_sge bound on wqe->dma.resid instead (copy_data()
>      dereferences dma->sge[] only when there is payload), so zero-payload
>      WQEs -- the only kind a max_sge == 0 QP can post -- are accepted while
>      the out-of-range cur_sge OOB is still rejected. Commit message fixed.

Thanks a lot. I am fine with this. Please Leon and Jason comment on this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> 
>   drivers/infiniband/sw/rxe/rxe_req.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 12d03f390b09..363c56a1edbb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -701,6 +701,28 @@ int rxe_requester(struct rxe_qp *qp)
>   	if (unlikely(!wqe))
>   		goto exit;
>   
> +	/*
> +	 * Don't trust user space data: for a user QP, qp->sq.queue is a
> +	 * raw ring the application writes directly, so this WQE's num_sge
> +	 * and cur_sge are attacker-controlled. copy_data() dereferences
> +	 * dma->sge[cur_sge] without bounding the initial cur_sge against
> +	 * the per-WQE sge array, whose capacity is qp->sq.max_sge (the
> +	 * loop there only bounds subsequent increments, against num_sge).
> +	 * Bound num_sge to that capacity, the way get_srq_wqe() and
> +	 * validate_send_wr() already do, and bound cur_sge only when the
> +	 * WQE actually carries payload (dma.resid): copy_data() returns
> +	 * early on a zero-length copy before it ever touches dma->sge[],
> +	 * so a zero-payload WQE -- the only valid WQE on a max_sge == 0
> +	 * QP -- must not be rejected here.
> +	 */
> +	if (unlikely(wqe->dma.num_sge > qp->sq.max_sge ||
> +		     (wqe->dma.resid &&
> +		      wqe->dma.cur_sge >= qp->sq.max_sge))) {
> +		rxe_dbg_qp(qp, "invalid num_sge/cur_sge in send wqe\n");
> +		wqe->status = IB_WC_LOC_QP_OP_ERR;
> +		goto err;
> +	}
> +
>   	if (rxe_wqe_is_fenced(qp, wqe)) {
>   		qp->req.wait_fence = 1;
>   		goto exit;


