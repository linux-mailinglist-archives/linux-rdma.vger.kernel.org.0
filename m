Return-Path: <linux-rdma+bounces-18217-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGZ3OGpkuGlOdQEAu9opvQ
	(envelope-from <linux-rdma+bounces-18217-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:13:30 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2452A0166
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 21:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 776253033E62
	for <lists+linux-rdma@lfdr.de>; Mon, 16 Mar 2026 20:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A833ED5BE;
	Mon, 16 Mar 2026 20:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMDQUOsO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAEF3E92B2;
	Mon, 16 Mar 2026 20:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773691987; cv=none; b=IJFdaAWENQd7lscfJNkzDCrh+WhredXH4ibuyWm+wBY/aNwtxhKV7hewTgAgOtLkPiKQWyNKgX0blgVDgxuCf377MlMHQFfJSO9w/vg/xio7A8yeAjR+st+HozV88MCeWy6pwdrciyjonrWpZYeu12DTxVrZBmCGdfdrzIL0Em0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773691987; c=relaxed/simple;
	bh=CNG/WxKOmcaQk7ehA4qGRPauU7Y1BgjTuNyXzTcCMKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPTt0f9naOldReCCcrbE5JQCknp5bOeU11xVIGMzN23cVcbCR/R6CSG34Rc0Bp0l8kMGLnxoxAHkh97+29mgUmiZn6MlqOsZaUUi0LKrqUnBOkAAgf7wF5RM7POMqGefFQR9L/tqQr1LMEJnprOd5UXqBeETRp5VLbBBUz0RbNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMDQUOsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB9D1C19421;
	Mon, 16 Mar 2026 20:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773691986;
	bh=CNG/WxKOmcaQk7ehA4qGRPauU7Y1BgjTuNyXzTcCMKI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FMDQUOsOEs4zq24dFcEgjGuuu2vouDipBUv7uIBmxCUT8C9nQw8jx0ewqTl4Z6fMh
	 itUwzzsKQsO7d3OWtAp31bGS0hWbhGnMCRhhiQgSON8nOeW5s1lXnPmDJDUcDB51Mn
	 e0aJ8JE3RBe7ZI5Az+PHxaoj75rAXc9IM1KKkLdaYst/uZq7I3yN2nL7X4uyj3kAH8
	 QEQOtKkf+nj/XXggW05yrSazyPa5uwD1spB+zIfyI6aKHIjBY1ZNKbjCn92tjhSYcu
	 offSKQf9XX/EyrlkvjtUOLtDjRQeJF4Kn+lN1EEzISAvPA5E3h2ZNi73wUtosmZwAa
	 FEzGpHp8E9JoA==
Date: Mon, 16 Mar 2026 22:13:01 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Marco Crivellari <marco.crivellari@suse.com>
Cc: linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with
 system_dfl_wq
Message-ID: <20260316201301.GL61385@unreal>
References: <20260313154023.298325-1-marco.crivellari@suse.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260313154023.298325-1-marco.crivellari@suse.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,gmail.com,linutronix.de,suse.com,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18217-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8B2452A0166
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 04:40:23PM +0100, Marco Crivellari wrote:
> This patch continues the effort to refactor workqueue APIs, which has begun
> with the changes introducing new workqueues and a new alloc_workqueue flag:
> 
>    commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and system_dfl_wq")
>    commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> 
> The point of the refactoring is to eventually alter the default behavior of
> workqueues to become unbound by default so that their workload placement is
> optimized by the scheduler.
> 
> Before that to happen, workqueue users must be converted to the better named
> new workqueues with no intended behaviour changes:
> 
>    system_wq -> system_percpu_wq
>    system_unbound_wq -> system_dfl_wq
> 
> This way the old obsolete workqueues (system_wq, system_unbound_wq) can be
> removed in the future.

I recall earlier efforts to replace system workqueues with per‑driver queues,
because unloading a driver forces a flush of the entire system workqueue,
which is undesirable for overall system behavior.

Wouldn't it be better to introduce a local workqueue here and use that instead?

Thanks

> 
> Link: https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> Suggested-by: Tejun Heo <tj@kernel.org>
> Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> ---
>  drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> index bc11b1ec59ac..d440c8cbaea5 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>  		work->frags[i].mr = mr;
>  	}
>  
> -	queue_work(system_unbound_wq, &work->work);
> +	queue_work(system_dfl_wq, &work->work);
>  
>  	return 0;
>  
> -- 
> 2.53.0
> 

