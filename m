Return-Path: <linux-rdma+bounces-22915-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7GsBK+oJT2ozZgIAu9opvQ
	(envelope-from <linux-rdma+bounces-22915-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 04:39:38 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DDF7E72C0AF
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 04:39:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Z0ZrtqzD;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22915-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22915-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F012F3026F3A
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 02:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD30A34040C;
	Thu,  9 Jul 2026 02:39:00 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A2230FF2A
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 02:38:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783564740; cv=none; b=fmPXDBpVETMnEs+nF49WwpqiR+M89VJJo6V53lGDgLEjwL2gMHNJsFS7k1lzSt5rS5H6r2PrR0F5c68KwMnXL9bnr1OHx/Hm8UN4EmRs5edYsQrMJKoVCkOrsYSRSvQDtuyKf0rMXRjtFAcZzzjy7YsznuGiKPRzIS0hKMTZZdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783564740; c=relaxed/simple;
	bh=nM17uBlBSO29jd8iHKvxiWBZrvZetvXLELJUHMhKuGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRmAZn+FzfFZtwQ3k+q4+se4ybnsasYyw8WoK5+XK7Omb84s5aWUn+MFEaDurRjcVU7FZJBLKHHZX1W6JA+dXMbfgQGB9bbqo/9TYlLw87OTuPX2oSMFnceOFzy+ROQsKdyBySexkHDZlYsSI0FsPPrIWiVO9Wjd5sh39JvI1Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z0ZrtqzD; arc=none smtp.client-ip=91.218.175.171
Message-ID: <71562c7f-183c-40e4-bb90-84b078cf079d@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783564726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v8G90Uh25zbPhM1ZwNcOXV6L2AePEvbAedmTn3KSKo4=;
	b=Z0ZrtqzD64f7oznKtYfv04nNzXaeOiDaILKKTBuu2f59uiUEmVXWxqpjq3EbNV/hldPiEF
	F+CCkC73X0p5PpHCx/OzpbahTkvqfhipveA8trjVY+xypt8Jo97hskmPlhrh1MJ+VwCEr0
	8K6rYXRjrdlu+EveCf5M3UTlgtTPRtM=
Date: Wed, 8 Jul 2026 19:38:40 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: validate num_sge/cur_sge before indexing
 wqe->dma.sge[]
To: Ibrahim Hashimov <security@auditcode.ai>,
 Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260708224534.1206-1-security@auditcode.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260708224534.1206-1-security@auditcode.ai>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-22915-lists,linux-rdma=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:from_mime,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,auditcode.ai:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DDF7E72C0AF

On 7/8/26 3:45 PM, Ibrahim Hashimov wrote:
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
> copy_data() immediately indexes the per-WQE sge array with the
> attacker-controlled cur_sge field, before any bound is checked:
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
> bound both fields pulled from the (possibly user-mapped) send queue
> entry before they are ever used to index wqe->dma.sge[], right where
> the requester fetches the next WQE off the ring in rxe_requester().
> num_sge is capped at qp->sq.max_sge (matching the sibling SRQ check
> and the kernel-QP validate_send_wr() check), and cur_sge is capped at
> qp->sq.max_sge directly, since that is the true per-WQE array capacity
> that copy_data() indexes into -- this also covers num_sge == 0 /
> cur_sge == 0 local-op and zero-payload WQEs, which remain valid.
> 
> This is a long-standing bug in the rxe (soft-RoCE) driver: the
> qp->is_user bypass in rxe_post_send() and the unbounded
> &dma->sge[dma->cur_sge] indexing in copy_data() have been present
> since the driver was introduced.
> 
> Runtime-verified on a v6.19 KASAN (CONFIG_KASAN_VMALLOC=y) stand: a
> reproducer that posts a user QP send WQE with an out-of-range
> cur_sge reliably tripped "KASAN: vmalloc-out-of-bounds in
> copy_data" (an out-of-bounds read) before this patch, and no longer
> triggers that report with the patch applied.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
>   drivers/infiniband/sw/rxe/rxe_req.c | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 12d03f390b09..9fb2c49fb503 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -701,6 +701,22 @@ int rxe_requester(struct rxe_qp *qp)
>   	if (unlikely(!wqe))
>   		goto exit;
>   
> +	/*
> +	 * Don't trust user space data: qp->sq.queue is a raw ring the
> +	 * application writes directly for a user QP, so wqe->dma.num_sge
> +	 * and wqe->dma.cur_sge must be bounds-checked the same way
> +	 * get_srq_wqe() checks an SRQ entry's num_sge before it is used.
> +	 * Otherwise copy_data() indexes wqe->dma.sge[wqe->dma.cur_sge]
> +	 * with an unvalidated, attacker-controlled index/count and reads
> +	 * out of bounds of the per-wqe sge array.
> +	 */
> +	if (unlikely(wqe->dma.num_sge > qp->sq.max_sge ||

 From this function,

static int rxe_init_sq(struct rxe_qp *qp, struct ibv_qp_init_attr 
*init_attr)
{
     ...
     qp->sq.max_sge = init_attr->cap.max_send_sge;
     ...
}

qp->sq.max_sge is also from the user space application. It is possible 
that qp->sq.max_sge is 0.

Then this makes rxe_requester will return error and exit.

Zhu Yanjun

> +		     wqe->dma.cur_sge >= qp->sq.max_sge)) {
> +		rxe_dbg_qp(qp, "invalid num_sge/cur_sge in send wqe\n");
> +		wqe->status = IB_WC_LOC_QP_OP_ERR;
> +		goto err;
> +	}
> +
>   	if (rxe_wqe_is_fenced(qp, wqe)) {
>   		qp->req.wait_fence = 1;
>   		goto exit;


