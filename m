Return-Path: <linux-rdma+bounces-15793-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLh0FZNecGkVXwAAu9opvQ
	(envelope-from <linux-rdma+bounces-15793-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 06:05:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9C7514E3
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 06:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9625D4F392E
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Jan 2026 05:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43C833E368;
	Wed, 21 Jan 2026 05:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eEysbBxS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4048633DED8
	for <linux-rdma@vger.kernel.org>; Wed, 21 Jan 2026 05:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768971915; cv=none; b=EKM1540mkwctzxm+JIUjUM+T1JzM1yn1ddWdU2y/GCsINKemT79XaLH2JM7vfgxzx0lH3VVSud5EknNWWDIHMiio8cgUNlYZ/qPfltjf7T2AhCRynBKfkRnRiZKkpYo6SG+FrlQBSsnLQXN6nO0w9JWe52YHDeBR8GvoNvi/T+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768971915; c=relaxed/simple;
	bh=/2F3YxYazcp3chVDEiNdJCfgY9xuwk1ucvXalo9C6tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e65QnxY4aVxGt2oW2t7jA5YC3kPnchJFLBUsfS0+WDhG3F+HaLDFZENVxZuj1Hq6ja78B13f2/zOtqrt/oBbWvZUFxFMWOFwWefeoLdKs6Py1Pwzh5B0fz+U+JKjuT085PBp9Y4byOiBZxCvAVmG07EzvbliQG2xW16wwOZ7AvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eEysbBxS; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0f37cd78-d4d1-4910-95e2-8f91a6417b3a@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768971911;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVv0E2X/BfUN/RnCsT8W19P3ln0+bZdL9P0VfJNSC9Q=;
	b=eEysbBxSomIZYXKpuhEahD2Ei9KpW8yGhPs43tLMEC9sDA+153HzqgqmaInXDzIiV3gBwN
	h84DYESPprx8aDbrnHIucwF6td0aW1tQrosEoMaJf84FtQC3eGMbAXcwNdH51vq+scTird
	qTZRc5K5gseIM26yxPM8eiX+fNd0ZHE=
Date: Tue, 20 Jan 2026 21:04:27 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix race condition in QP timer handlers
To: Li Zhijian <lizhijian@fujitsu.com>, linux-rdma@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, zyjzyj2000@gmail.com, jgg@ziepe.ca,
 leon@kernel.org
References: <20260120074437.623018-1-lizhijian@fujitsu.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260120074437.623018-1-lizhijian@fujitsu.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ziepe.ca,kernel.org];
	TAGGED_FROM(0.00)[bounces-15793-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-rdma];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:email,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: BF9C7514E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

在 2026/1/19 23:44, Li Zhijian 写道:
> I encontered the following warning:
>   WARNING: drivers/infiniband/sw/rxe/rxe_task.c:249 at rxe_sched_task+0x1c8/0x238 [rdma_rxe], CPU#0: swapper/0/0
> ...
>    libsha1 [last unloaded: ip6_udp_tunnel]
>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G         C          6.19.0-rc5-64k-v8+ #37 PREEMPT
>   Tainted: [C]=CRAP
>   Hardware name: Raspberry Pi 4 Model B Rev 1.2
>   Call trace:
>    rxe_sched_task+0x1c8/0x238 [rdma_rxe] (P)
>    retransmit_timer+0x130/0x188 [rdma_rxe]
>    call_timer_fn+0x68/0x4d0
>    __run_timers+0x630/0x888
> ...
>   WARNING: drivers/infiniband/sw/rxe/rxe_task.c:38 at rxe_sched_task+0x1c0/0x238 [rdma_rxe], CPU#0: swapper/0/0
> ...
>   WARNING: drivers/infiniband/sw/rxe/rxe_task.c:111 at do_work+0x488/0x5c8 [rdma_rxe], CPU#3: kworker/u17:4/93400
> ...
>   refcount_t: underflow; use-after-free.
>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x138/0x1a0, CPU#3: kworker/u17:4/93400
> 
> The issue is caused by a race condition between retransmit_timer() and
> rxe_destroy_qp, leading to the Queue Pair's (QP) reference count dropping
> to zero during timer handler execution.
> 
> It seems this warning is harmless because rxe_qp_do_cleanup() will flush
> all pending timers and requests.
> 
> Example of flow causing the issue:
> 
> CPU0                                   CPU1
> retransmit_timer() {
>      spin_lock_irqsave
>                             rxe_destroy_qp()
>                              __rxe_cleanup()
>                                __rxe_put() // qp->ref_count decrease to 0

In  __rxe_cleanup, __rxe_put decrease qp->ref_count to 0.

Then in the timer functions retransmit_timer and rnr_nak_timer will 
check qp and resend the packets. IMO, it may be a solution to use the 
function rxe_get to check if ref_count is 0 or not.

I am fine with it.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Thanks,
Zhu Yanjun

>                              rxe_qp_do_cleanup() {
>      if (qp->valid) {
>          rxe_sched_task() {
>              WARN_ON(rxe_read(task->qp) <= 0);
>          }
>      }
>      spin_unlock_irqrestore
> }
>                                spin_lock_irqsave
>                                qp->valid = 0
>                                spin_unlock_irqrestore
>                              }
> 
> Ensure the QP's reference count is maintained and its validity is checked
> within the timer callbacks by adding calls to rxe_get(qp) and corresponding
> rxe_put(qp) after use.
> 
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>   drivers/infiniband/sw/rxe/rxe_comp.c | 3 +++
>   drivers/infiniband/sw/rxe/rxe_req.c  | 3 +++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_comp.c b/drivers/infiniband/sw/rxe/rxe_comp.c
> index a5b2b62f596b..1390e861bd1d 100644
> --- a/drivers/infiniband/sw/rxe/rxe_comp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_comp.c
> @@ -119,12 +119,15 @@ void retransmit_timer(struct timer_list *t)
>   
>   	rxe_dbg_qp(qp, "retransmit timer fired\n");
>   
> +	if (!rxe_get(qp))
> +		return;
>   	spin_lock_irqsave(&qp->state_lock, flags);
>   	if (qp->valid) {
>   		qp->comp.timeout = 1;
>   		rxe_sched_task(&qp->send_task);
>   	}
>   	spin_unlock_irqrestore(&qp->state_lock, flags);
> +	rxe_put(qp);
>   }
>   
>   void rxe_comp_queue_pkt(struct rxe_qp *qp, struct sk_buff *skb)
> diff --git a/drivers/infiniband/sw/rxe/rxe_req.c b/drivers/infiniband/sw/rxe/rxe_req.c
> index 373b03f223be..12d03f390b09 100644
> --- a/drivers/infiniband/sw/rxe/rxe_req.c
> +++ b/drivers/infiniband/sw/rxe/rxe_req.c
> @@ -102,6 +102,8 @@ void rnr_nak_timer(struct timer_list *t)
>   
>   	rxe_dbg_qp(qp, "nak timer fired\n");
>   
> +	if (!rxe_get(qp))
> +		return;
>   	spin_lock_irqsave(&qp->state_lock, flags);
>   	if (qp->valid) {
>   		/* request a send queue retry */
> @@ -110,6 +112,7 @@ void rnr_nak_timer(struct timer_list *t)
>   		rxe_sched_task(&qp->send_task);
>   	}
>   	spin_unlock_irqrestore(&qp->state_lock, flags);
> +	rxe_put(qp);
>   }
>   
>   static void req_check_sq_drain_done(struct rxe_qp *qp)


