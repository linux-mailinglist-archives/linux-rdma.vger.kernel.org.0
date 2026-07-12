Return-Path: <linux-rdma+bounces-23060-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CwrmHzblUmpQVQMAu9opvQ
	(envelope-from <linux-rdma+bounces-23060-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 02:52:06 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7DA743549
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 02:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linux.dev header.s=key1 header.b=Eyp2V1BA;
	dmarc=pass (policy=none) header.from=linux.dev;
	spf=pass (mail.lfdr.de: domain of "linux-rdma+bounces-23060-lists+linux-rdma=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-rdma+bounces-23060-lists+linux-rdma=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D06B30158B9
	for <lists+linux-rdma@lfdr.de>; Sun, 12 Jul 2026 00:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C518FC97;
	Sun, 12 Jul 2026 00:51:46 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974B01DFDE
	for <linux-rdma@vger.kernel.org>; Sun, 12 Jul 2026 00:51:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783817506; cv=none; b=l7mX0jDd1BJeTyIw+ijMKwxfhwphJ7J8OIo2IDYxy4dGuWUDkLgZ4GGw93XNmy5tPE0gchLNhz/gKkdRnsxPNt6+HKekRiEjp7FMahfvv0u+3AtwjYF34+h2JjfqpO/9jemFWphV0K1JkT5hg+OxNHBLsZghqVI2tNcWf83QZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783817506; c=relaxed/simple;
	bh=jtdTCu5QiW81ffPknlfolxfdknYZoV5gk3lQV4ofpDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LLQrB0ugefSCX/B67lYPbIJn6hW/o7em913UXQPuXQi6DT8w92vYb9UXqkyS82ci4+3NaIdZlGWAFjXO2LMiUtx8rNxOSmAhmE/1+PCH6BSCzRER6xZgUn8eR1nHG94sJIrSK8KX1RL3uIKBGzHaUgRDBKnc3qesI5njj8tWmZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Eyp2V1BA; arc=none smtp.client-ip=95.215.58.172
Message-ID: <1e7a15bf-b619-4b12-b275-de495d2aea4b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783817492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pDNLgmL5xIhl6Wi9rji2gTBnytSwbpbJCER1WyoQQKo=;
	b=Eyp2V1BAEBT3ZWH6ONA6SAVdNuLAgQ5zKyRWdyLD5xoyfW6JGlmw457vQmO9cSlAabMlSJ
	+3P+Z1iOe20piA5EWFP4FW+zMaMOiGX2jgiudH1roJcqO+ew1wHhfIRyG+hzHDgXR5e0Ho
	0ypaSX1ClD5eN2jpV1dwHt3l1wdWk6I=
Date: Sat, 11 Jul 2026 17:51:18 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH for-rc] RDMA/rxe: don't re-execute the current packet
 after the QP moved to error state
To: Allison Henderson <achender@kernel.org>, Zhu Yanjun
 <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Leon Romanovsky <leon@kernel.org>,
 "yanjun.zhu@linux.dev" <yanjun.zhu@linux.dev>
Cc: Bob Pearson <rpearsonhpe@gmail.com>, Ian Ziemba <ian.ziemba@hpe.com>,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260711165419.13486-1-achender@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260711165419.13486-1-achender@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:achender@kernel.org,m:zyjzyj2000@gmail.com,m:jgg@ziepe.ca,m:leon@kernel.org,m:yanjun.zhu@linux.dev,m:rpearsonhpe@gmail.com,m:ian.ziemba@hpe.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23060-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,ziepe.ca,linux.dev];
	FORGED_SENDER(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,hpe.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-rdma];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED7DA743549

在 2026/7/11 9:54, Allison Henderson 写道:
> When do_complete() finds the QP in the error state it returns
> RESPST_CHK_RESOURCE.  Before commit 49dc9c1f0c7e ("RDMA/rxe: Cleanup
> reset state handling in rxe_resp.c") this was the flush loop:
> check_resource() had an error-state branch that fetched each remaining
> recv WQE and completed it with IB_WC_WR_FLUSH_ERR, without touching
> the current packet.  That commit removed the error-state branch from
> check_resource() (draining is now done at rxe_receiver() entry) but
> kept the do_complete() error-state return.
> 
> As a result, when a QP moves to the error state while a packet is
> being completed - e.g. an rdma_cm disconnect racing with receive
> processing - the responder state machine loops back into the request
> processing chain with the already-completed packet still in hand:
> check_resource() fetches a fresh recv WQE, execute()/send_data_in()
> copies the same packet payload again, do_complete() posts another
> IB_WC_SUCCESS CQE (qp->resp.status is still 0), and control returns
> to the error-state check.  The loop re-executes the same packet once
> per posted recv WQE (observed: ~1000 duplicate IB_WC_SUCCESS
> completions of one SEND, one per ~8us, matching the RQ occupancy)
> until the RQ is exhausted, after which qp->resp.wqe is NULL and
> send_data_in() dereferences it:
> 
>    BUG: kernel NULL pointer dereference, address: 0000000000000014
>    Workqueue: rxe_wq do_work
>    RIP: copy_data+0x29/0x1f0
>    Call Trace:
>     send_data_in+0x25/0x50
>     rxe_receiver+0xf36/0x1dd0
> 
> The duplicate completions are indistinguishable from real receives to
> the ULP.  During an rds stress test, the message was accepted as new and
> delivered the same datagram to user space hundreds of times, corrupting
> the stream; any ULP that relies on RC exactly-once delivery is affected.
> 
> A live packet reaching the error-state check in do_complete() has
> been executed and completed exactly once and must be consumed, not
> re-processed.  Return RESPST_CLEANUP for it (dequeue and free); keep
> returning RESPST_CHK_RESOURCE for the pkt == NULL case.
> 
> Fixes: 49dc9c1f0c7e ("RDMA/rxe: Cleanup reset state handling in rxe_resp.c")
> Assisted-by: Claude-Code:claude-fable-5
> Signed-off-by: Allison Henderson <achender@kernel.org>

The fix is correct and strictly adheres to the InfiniBand RC service
guarantees. When a QP transitions to the error state while processing
a live packet, returning RESPST_CLEANUP ensures the executed packet
is properly consumed rather than improperly re-injected into the request
chain. This accurately prevents both data stream corruption from
duplicate completions and the kernel panic caused by RQ exhaustion.

Thanks a lot.
Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_resp.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_resp.c b/drivers/infiniband/sw/rxe/rxe_resp.c
> index d8cbdfa70cdbd..02b16e2b49b8f 100644
> --- a/drivers/infiniband/sw/rxe/rxe_resp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_resp.c
> @@ -1217,7 +1217,14 @@ static enum resp_states do_complete(struct rxe_qp *qp,
>   	spin_lock_irqsave(&qp->state_lock, flags);
>   	if (unlikely(qp_state(qp) == IB_QPS_ERR)) {
>   		spin_unlock_irqrestore(&qp->state_lock, flags);
> -		return RESPST_CHK_RESOURCE;
> +		/* The packet was executed and completed before the QP
> +		 * moved to ERROR; it must be consumed exactly once.
> +		 * Re-entering the request chain with the stale packet
> +		 * would copy it into every remaining recv WQE as a new
> +		 * completion.  Remaining WQEs are flushed by the drain
> +		 * path at rxe_receiver() entry.
> +		 */
> +		return pkt ? RESPST_CLEANUP : RESPST_CHK_RESOURCE;
>   	}
>   	spin_unlock_irqrestore(&qp->state_lock, flags);
>   


