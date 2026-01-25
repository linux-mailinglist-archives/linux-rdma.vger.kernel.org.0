Return-Path: <linux-rdma+bounces-15999-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MOoYGD6KdmkxRwEAu9opvQ
	(envelope-from <linux-rdma+bounces-15999-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 22:25:18 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2CBF827F2
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 22:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B333630062C5
	for <lists+linux-rdma@lfdr.de>; Sun, 25 Jan 2026 21:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E3C30C620;
	Sun, 25 Jan 2026 21:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="czckrqcZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9A43009EA;
	Sun, 25 Jan 2026 21:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769376305; cv=none; b=SCdv5io251e+C6tDRRyZzlKI830rC9zTilicvHIHBCplpXeUQbWlbLYDV3a50yISuZvNdQ/SyjZOAAhmojTZ7hDp1XJ3LR+CAGuDr3TnSs5EUL6Ng478oItupqnoJPijtCXvOby4N25/1575VSS8VZX0jO7pRMOL8HBqOrqen/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769376305; c=relaxed/simple;
	bh=ScdmgRKHbgyPHGr/tJY7RmMljwLMHuEUNkKmw6ueJzw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WzaSt0PKSp3gLBcY3v+ZM0jU+Aq+fpBELdRDRwpMoXlICN0Y9LUwehyxlJTR/Mfju7ZPKc3vPMTs+iV+aqziMdGaHSD51kSNXBPZPOSUZqFdXIhcy4Yazyl19x2HfCAlZDo5nFdT6aBTcMovD9SBOulDeFAhOrZXrthQvj8CPyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=czckrqcZ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <c718d1c2-6c7e-47df-a3f4-097f7cadbbbf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769376301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Eez2I/GY3/I4DPEXmZkLaQA4RuJiR1X0FtRWGveuTo=;
	b=czckrqcZ3q7lyXwefN3zXt65HHWuvjhXbse9ayaYNSiR9r9hHG99N/xlU9nTRbewWXxvmx
	mJ0NsvutRr7yqHUN9D+qebQ6zaMKSPSezEay5UBzhMw+wDfjbGNJEIJSHxGGerFYPrCu6r
	5llOZiWx+aJp6PN2ujwUp4Ol24Jj93A=
Date: Sun, 25 Jan 2026 13:24:39 -0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Fix race condition in QP timer handlers
To: Leon Romanovsky <leon@kernel.org>, Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 zyjzyj2000@gmail.com, jgg@ziepe.ca
References: <20260120074437.623018-1-lizhijian@fujitsu.com>
 <20260125140812.GE13967@unreal>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20260125140812.GE13967@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15999-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,ziepe.ca];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fujitsu.com:email]
X-Rspamd-Queue-Id: E2CBF827F2
X-Rspamd-Action: no action

在 2026/1/25 6:08, Leon Romanovsky 写道:
> On Tue, Jan 20, 2026 at 03:44:37PM +0800, Li Zhijian wrote:
>> I encontered the following warning:
>>   WARNING: drivers/infiniband/sw/rxe/rxe_task.c:249 at rxe_sched_task+0x1c8/0x238 [rdma_rxe], CPU#0: swapper/0/0
>> ...
>>    libsha1 [last unloaded: ip6_udp_tunnel]
>>   CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Tainted: G         C          6.19.0-rc5-64k-v8+ #37 PREEMPT
>>   Tainted: [C]=CRAP
>>   Hardware name: Raspberry Pi 4 Model B Rev 1.2
>>   Call trace:
>>    rxe_sched_task+0x1c8/0x238 [rdma_rxe] (P)
>>    retransmit_timer+0x130/0x188 [rdma_rxe]
>>    call_timer_fn+0x68/0x4d0
>>    __run_timers+0x630/0x888
>> ...
>>   WARNING: drivers/infiniband/sw/rxe/rxe_task.c:38 at rxe_sched_task+0x1c0/0x238 [rdma_rxe], CPU#0: swapper/0/0
>> ...
>>   WARNING: drivers/infiniband/sw/rxe/rxe_task.c:111 at do_work+0x488/0x5c8 [rdma_rxe], CPU#3: kworker/u17:4/93400
>> ...
>>   refcount_t: underflow; use-after-free.
>>   WARNING: lib/refcount.c:28 at refcount_warn_saturate+0x138/0x1a0, CPU#3: kworker/u17:4/93400
>>
>> The issue is caused by a race condition between retransmit_timer() and
>> rxe_destroy_qp, leading to the Queue Pair's (QP) reference count dropping
>> to zero during timer handler execution.
>>
>> It seems this warning is harmless because rxe_qp_do_cleanup() will flush
>> all pending timers and requests.
>>
>> Example of flow causing the issue:
>>
>> CPU0                                   CPU1
>> retransmit_timer() {
>>      spin_lock_irqsave
>>                             rxe_destroy_qp()
>>                              __rxe_cleanup()
>>                                __rxe_put() // qp->ref_count decrease to 0
>>                              rxe_qp_do_cleanup() {
>>      if (qp->valid) {
>>          rxe_sched_task() {
>>              WARN_ON(rxe_read(task->qp) <= 0);
>>          }
>>      }
>>      spin_unlock_irqrestore
>> }
>>                                spin_lock_irqsave
>>                                qp->valid = 0
>>                                spin_unlock_irqrestore
>>                              }
>>
>> Ensure the QP's reference count is maintained and its validity is checked
>> within the timer callbacks by adding calls to rxe_get(qp) and corresponding
>> rxe_put(qp) after use.
>>
>> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> 
> Fixes line?

The Fixes line should be the following?

Fixes: 8700e3e7c485 ("Soft RoCE driver")

Best Regards,
Zhu Yanjun

> 
> Thanks
> 
>> ---
>>   drivers/infiniband/sw/rxe/rxe_comp.c | 3 +++
>>   drivers/infiniband/sw/rxe/rxe_req.c  | 3 +++
>>   2 files changed, 6 insertions(+)


