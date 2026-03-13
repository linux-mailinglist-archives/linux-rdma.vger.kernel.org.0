Return-Path: <linux-rdma+bounces-18151-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMOCAStPtGk4kAAAu9opvQ
	(envelope-from <linux-rdma+bounces-18151-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 18:53:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 24C0628857D
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 18:53:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D27A3081F1E
	for <lists+linux-rdma@lfdr.de>; Fri, 13 Mar 2026 17:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BAE3CF683;
	Fri, 13 Mar 2026 17:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SEDIPXMX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFD7C3603EB;
	Fri, 13 Mar 2026 17:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773424205; cv=none; b=hhzG4VrmvIWQuONDb8XzfjPTWHzZTXt2Y6ZZXuuzf8S+lmEJLWxRSR/8Aqvn84s1NnxmtAaAj1FQyilES65pQ+IBPg11N4TLf2kZvnxYp6jrZe1HC5haZ3XS0t35mT3OCYB9Ds4HlKaJtGcri83xS1v1fJluncWmzbMPvYuzvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773424205; c=relaxed/simple;
	bh=RQq4jffaA3OgSOx8zxQ/XNKY/PoImMSSenIJ/w+Lx74=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oagVex+B0KW48XuKD0ictgnsLG3JuKisCL9rtv5JUd8X/zrCC3o6oF01nb3kMO42g96MJJ4ui4X6qwFHJ2CqejvGmt+cy6+DVy+g5aDEu1laq01mEArO2TA0wOJ1a0vq19lKKgfUsnwePSPm6ThaNAUb+54nL82P9cJ1ArplgXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SEDIPXMX; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <66bc6576-dda0-4ba9-bd66-f8514e3dda09@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773424200;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g6alHL3mr/0O4Xgpc7m1dmSg8spXbYGaz9EXl4+8ON4=;
	b=SEDIPXMXQqqbcW8lSD+PuUluIMc1iHQW19/riQ3e/qsWiGD9aHI5vjHiKaaM03vtBlzb0S
	yIXe2Xek6RGDFTMLldAdViX2hjcGSf70bZlOkxhNZ8TwMlnRQou8/gFDsjzvWcVTegewNZ
	sjgS2xwK6DRFLZ08gcfzKgPIm36V6aI=
Date: Fri, 13 Mar 2026 10:49:50 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with
 system_dfl_wq
To: Marco Crivellari <marco.crivellari@suse.com>,
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
References: <20260313154023.298325-1-marco.crivellari@suse.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "yanjun.zhu" <yanjun.zhu@linux.dev>
In-Reply-To: <20260313154023.298325-1-marco.crivellari@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18151-lists,linux-rdma=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yanjun.zhu@linux.dev,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 24C0628857D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/13/26 8:40 AM, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>     commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>     commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> Before that to happen, workqueue users must be converted to the better named
> new workqueues with no intended behaviour changes:
> 
>     system_wq -> system_percpu_wq
>     system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.
> 
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>

This patch is part of a broader effort to clarify workqueue semantics. 
As discussed in the recent thread at 
https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/], the 
move towards system_dfl_wq is not just a renaming exercise; it's about 
ensuring work items correctly respect the system's housekeeping CPUMASK.

To RXE, it is a software-defined RDMA transport. RXE does not have 
strict hardware-to-CPU affinity requirements. Specifically for the ODP 
prefetch path modified here:

1. Prefetching doesn't rely on being executed on the local CPU where the 
advise_mr was called.

2. The locality benefits of per-cpu execution are negligible compared to 
the importance of system-wide jitter reduction, especially in NOHZ_FULL 
environments.

3. By using system_dfl_wq, we allow the scheduler to offload prefetch 
tasks from isolated CPUs to housekeeping CPUs, which is a desirable 
behavior for real-time users.

The patch is safe, logically sound, and aligns with the current 
kernel-wide modernization of workqueue placement.

I have made tests with this commit. It can work well in functionality.

I am fine with this.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun

> ---
>   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index bc11b1ec59ac..d440c8cbaea5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>   		work->frags[i].mr = mr;
>   	}
>   
> -	queue_work(system_unbound_wq, &work->work);
> +	queue_work(system_dfl_wq, &work->work);
>   
>   	return 0;
>   


