Return-Path: <linux-rdma+bounces-22973-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id AAWwHufnT2o3qAIAu9opvQ
	(envelope-from <linux-rdma+bounces-22973-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:26:47 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E177573442F
	for <lists+linux-rdma@lfdr.de>; Thu, 09 Jul 2026 20:26:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b="MuY/Pz9N";
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-22973-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-22973-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AE5AF3056717
	for <lists+linux-rdma@lfdr.de>; Thu,  9 Jul 2026 18:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6C24DC553;
	Thu,  9 Jul 2026 18:24:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6EE4DC520
	for <linux-rdma@vger.kernel.org>; Thu,  9 Jul 2026 18:24:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621492; cv=none; b=j+i6F79CDtKzU2UlrmerWCev3PYZwnEBW46HxR1tbOgXXBGNQPw1rN1XRNS6rrkpgGDGDJ53sb5Au5rOXEr1AqMzW77B+CUQBWrs4fRYMVY3JVmyZ7BR+ymwlvJGoEFjDFYHwBCR2J8vypR7UUiHwZ+wiWUL4PJftVWvZuGaG5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621492; c=relaxed/simple;
	bh=Y7wRC87fXpoR4wkA3OpfTWZDKusrqy03psARRSRx5XI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PXLRxS9rhkXEmE7AvjGCad3Qis2zuo4ZNo35zFxXC/LhqJRl9DFU7lmvTCyYNQ8dgsmGn2ByBju+2no9or2RdRqx3K/sC2XK9AjkD+FHcbeqFfhSJ3NBhnHSK4xNXn37Jn/M6xZZ43OU53vM+IMcLfGWKkM2XtsudbHrUKCp4vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MuY/Pz9N; arc=none smtp.client-ip=91.218.175.178
Message-ID: <821c7993-b99d-42eb-be3f-0c2b9ac33340@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783621477;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UwM1Ks6XenPps+xT4ZqnKVM4XFvYTspyLoyGWV812TU=;
	b=MuY/Pz9N8ZZK16f0PAWJCBXTOtojy2uva/CDnGqFH6f2lJjFh/kGhEHDbQKJNaRXFinUjU
	u4CWlK9f1d/PWyZ6kEGO433gQ/z9LuDpmVa+Z2uNP+eXlrrF1ldlDE5Gq5GAe2M1zBCXJ0
	IfhRTfNvb0vR8U9VIiRs4WDU+bqXpuo=
Date: Thu, 9 Jul 2026 11:24:32 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] RDMA/rxe: fix responder UAF on
 IB_QP_MAX_DEST_RD_ATOMIC modify_qp
To: Ibrahim Hashimov <security@auditcode.ai>, zyjzyj2000@gmail.com,
 jgg@ziepe.ca, leon@kernel.org, Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260708224550.1281-1-security@auditcode.ai>
 <20260709072651.9040-1-security@auditcode.ai>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260709072651.9040-1-security@auditcode.ai>
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
	TAGGED_FROM(0.00)[bounces-22973-lists,linux-rdma=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,linux.dev:from_mime,linux.dev:email,linux.dev:mid,linux.dev:dkim,auditcode.ai:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E177573442F

On 7/9/26 12:26 AM, Ibrahim Hashimov wrote:
> rxe_qp_from_attr()'s IB_QP_MAX_DEST_RD_ATOMIC branch frees and
> reallocates qp->resp.resources[] (the rd_atomic resource array used by
> the responder to track in-flight RDMA READ/ATOMIC/FLUSH requests)
> completely outside of the IB_QP_STATE handling above it. Unlike every
> other place that tears this array down -- rxe_qp_reset(), reached only
> under IB_QP_STATE, always calls rxe_disable_task(&qp->recv_task) /
> rxe_disable_task(&qp->send_task) to drain the responder and requester
> tasks before touching per-QP state, then re-enables them -- this branch
> runs with the responder task (rxe_receiver(), scheduled as recv_task on
> the rxe_wq workqueue) fully live and unlocked. A userspace modify_qp()
> that sets only IB_QP_MAX_DEST_RD_ATOMIC (no state change, so
> __qp_chk_state()/ib_modify_qp_is_ok() never runs and qp->state_lock is
> never taken here) can therefore race the responder in two ways:
> 
>   1. free_rd_atomic_resources() calls kfree(qp->resp.resources) and
>      alloc_rd_atomic_resources() kzalloc_objs()'s a new array while
>      rxe_prepare_res()/find_resource() in rxe_resp.c are concurrently
>      walking &qp->resp.resources[i] with no lock held -- a straight
>      free-vs-read race on the array itself.
> 
>   2. free_rd_atomic_resources() only NULLs qp->resp.resources; it never
>      clears qp->resp.res, the raw pointer *into* that array that
>      rxe_resp.c caches across a multi-packet RDMA READ/ATOMIC/FLUSH
>      reply (set at rxe_resp.c read/atomic/flush-reply sites, cleared
>      only on the normal completion paths). If a modify_qp() races a
>      resource still referenced by qp->resp.res, the array is freed out
>      from under the cached pointer and the next reply packet dereferences
>      it -- independent of the kfree/kzalloc_objs() window in (1).
> 
> Reproduced with KASAN: a single process driving one RC QP pair in rxe
> loopback, one thread pumping large multi-packet IBV_WR_RDMA_READs
> against qpB while a second thread hammers
> ibv_modify_qp(qpB, IB_QP_MAX_DEST_RD_ATOMIC), reliably (~11s) produces
> 
>    BUG: KASAN: slab-use-after-free in rxe_receiver+0x4f78/0x89e0 [rdma_rxe]
>    Workqueue: rxe_wq do_work [rdma_rxe]
> 
> with the freed kmalloc-1k object being the rd_atomic resource array
> freed by the modify_qp() thread while the recv_task kworker reads it.
> An identical run modifying only IB_QP_MIN_RNR_TIMER (no resource free)
> is clean.
> 
> Fix both races the same way rxe_qp_reset() already handles tearing down
> this exact array: quiesce the responder task around the free/realloc by
> calling rxe_disable_task(&qp->recv_task) before free_rd_atomic_resources()
> and rxe_enable_task(&qp->recv_task) only after alloc_rd_atomic_resources()
> has succeeded, so rxe_receiver() cannot observe the array mid-free/
> mid-realloc. On the alloc-failure path the responder is deliberately
> left quiesced: qp->resp.resources is NULL at that point and
> rxe_prepare_res()/find_resource() would dereference it, so recv_task
> must not be re-enabled until a fresh array has been installed. And
> close the still-open window for (2) at the source: have
> free_rd_atomic_resources() clear qp->resp.res along with
> qp->resp.resources, exactly like the existing completion paths in
> rxe_resp.c (check_rkey()/duplicate_request()/RESPST_CLEANUP) already do
> when a resource's lifetime ends, so a drained-and-resumed responder
> restarts at RESPST_CHK_PSN against the fresh array instead of replaying
> a stale reference into the old one.
> 
> Only qp->recv_task is drained: qp->resp.resources / qp->resp.res are
> touched exclusively by the responder (rxe_resp.c); the requester
> (send_task / rxe_sender()) never reads them, so there is no need to
> widen this beyond what rxe_qp_reset() would drain for the equivalent
> state.
> 
> Verified on the same v6.19 KASAN stand: with this fix applied, the
> identical differential reproducer drives sustained MAX_DEST_RD_ATOMIC
> storms against qpB well past the ~11s pre-fix time-to-first-splat with
> zero KASAN reports, versus reliably tripping the slab-use-after-free in
> rxe_receiver() described above before the fix.
> 
> Fixes: 8700e3e7c485 ("Soft RoCE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Ibrahim Hashimov <security@auditcode.ai>
> Assisted-by: AuditCode-AI:2026.07
> ---
> v2: address Zhu Yanjun's review of v1
>      (https://lore.kernel.org/linux-rdma/20260708224550.1281-1-security@auditcode.ai/):
>      only re-enable recv_task after alloc_rd_atomic_resources() succeeds, so
>      the responder is not resumed against a NULL qp->resp.resources on the
>      ENOMEM path (rxe_prepare_res()/find_resource() would dereference it).
>      No change to the successful path; fix description updated accordingly.
> 
>   drivers/infiniband/sw/rxe/rxe_qp.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_qp.c b/drivers/infiniband/sw/rxe/rxe_qp.c
> index f3dff1aea96a..e39fb144cbbb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_qp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_qp.c
> @@ -172,6 +172,7 @@ static void free_rd_atomic_resources(struct rxe_qp *qp)
>   		}
>   		kfree(qp->resp.resources);
>   		qp->resp.resources = NULL;
> +		qp->resp.res = NULL;
>   	}
>   }
>   
> @@ -709,11 +710,24 @@ int rxe_qp_from_attr(struct rxe_qp *qp, struct ib_qp_attr *attr, int mask,
>   
>   		qp->attr.max_dest_rd_atomic = max_dest_rd_atomic;
>   
> +		/*
> +		 * This branch is not gated by IB_QP_STATE, so the responder
> +		 * task is live here. Quiesce it the way rxe_qp_reset() does
> +		 * before swapping the rd_atomic resource array, so
> +		 * rxe_receiver() cannot race the free/realloc.
> +		 */
> +		rxe_disable_task(&qp->recv_task);
>   		free_rd_atomic_resources(qp);
> -
>   		err = alloc_rd_atomic_resources(qp, max_dest_rd_atomic);
> +		/*
> +		 * On failure the responder stays quiesced: qp->resp.resources
> +		 * is NULL now, and rxe_prepare_res()/find_resource() would
> +		 * dereference it, so do not re-enable recv_task until a fresh
> +		 * array has been installed.
> +		 */
>   		if (err)
>   			return err;
> +		rxe_enable_task(&qp->recv_task);

Thanks a lot. I am fine with this commit. Please Leon and Jason comment 
on this commit.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

>   	}
>   
>   	if (mask & IB_QP_EN_SQD_ASYNC_NOTIFY)


