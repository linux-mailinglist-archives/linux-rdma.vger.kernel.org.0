Return-Path: <linux-rdma+bounces-18274-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCwPDMaluWlILgIAu9opvQ
	(envelope-from <linux-rdma+bounces-18274-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 20:04:38 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A786C2B1572
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 20:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB1D230F2F8E
	for <lists+linux-rdma@lfdr.de>; Tue, 17 Mar 2026 19:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B3220ED;
	Tue, 17 Mar 2026 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EzCtYtsO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4635D3F8819;
	Tue, 17 Mar 2026 19:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773774202; cv=none; b=gQqxlSbsAKW2/M2aSaikrcbtm1h+rIfmk2ET8JTPKgrCGlRv/mD+KNaOPpAS+vUKSqqXGNhcjZjH5ersYi3IGgLoiActrR7JEWLKJtcvMqflvgwDtz0Pc6/NcwEnN5KW/eF2EVMOn3YufTewZoVW30iccKhlZWzNPYxqHckD3Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773774202; c=relaxed/simple;
	bh=D2ERyuc1UMSKeLgncXUztDaW41U5T9m9Em2noKGdIT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qs1esMq29D0aFpCHO4dC5nzUZvTI4uXKwKMm6YPSAgJ9rDszLjuUJ/xArYGicyDD86xM6b760dzh0DfcKElxhlSOYnBjadVFcXdXJAMyrLK8lXLJP/4BQa8VVkD1tp8t5J1g4tvIO5hInsVnrrNo4CQf72Yb8s/VX75frtqev5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EzCtYtsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F943C4CEF7;
	Tue, 17 Mar 2026 19:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773774202;
	bh=D2ERyuc1UMSKeLgncXUztDaW41U5T9m9Em2noKGdIT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EzCtYtsOjwrWeWI5owLPGRPzPdfDT6YDgZ1eiU1VTbTtNsK/Mg0xzDmnPVHxVq7e0
	 KBkubv6qe/IIvnn5Cy8NwFgt95sGOdxlbMUrQVRbXqj+iQPIFmAM0+l14+lAp7L0lM
	 IDkU64T3OaSMuseH0XdVXVYNQ+4YW5z338xi/XbkxQ8C0JbdeLmUWEugcZP7z2BzOs
	 vTxxLca04v4PqU9glL7/ZV7iT4muQVBZGXvLBX/XFxUs9U/X0rsKtFwlMgG70XlilA
	 RoByqZhlBVvKuSU9w0VdueztQSWKtJcVOA3H1J60AKTnuQnSQY+S/pD3RFt4qU10FM
	 ssMvNLGpOaBeQ==
Date: Tue, 17 Mar 2026 21:03:14 +0200
From: Leon Romanovsky <leon@kernel.org>
To: "Yanjun.Zhu" <yanjun.zhu@linux.dev>
Cc: Marco Crivellari <marco.crivellari@suse.com>,
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Michal Hocko <mhocko@suse.com>, Zhu Yanjun <zyjzyj2000@gmail.com>,
	Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH] RDMA/rxe: Replace use of system_unbound_wq with
 system_dfl_wq
Message-ID: <20260317190314.GC61385@unreal>
References: <20260313154023.298325-1-marco.crivellari@suse.com>
 <20260316201301.GL61385@unreal>
 <c5374d12-84ed-4298-92d3-90062988f68d@linux.dev>
 <5de82ef1-3df6-44f8-a3c1-c6568c1110cf@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5de82ef1-3df6-44f8-a3c1-c6568c1110cf@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[suse.com,vger.kernel.org,kernel.org,gmail.com,linutronix.de,ziepe.ca];
	TAGGED_FROM(0.00)[bounces-18274-lists,linux-rdma=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.com:email]
X-Rspamd-Queue-Id: A786C2B1572
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 10:24:11AM -0700, Yanjun.Zhu wrote:
> 
> On 3/17/26 7:38 AM, Zhu Yanjun wrote:
> > 在 2026/3/16 13:13, Leon Romanovsky 写道:
> > > On Fri, Mar 13, 2026 at 04:40:23PM +0100, Marco Crivellari wrote:
> > > > This patch continues the effort to refactor workqueue APIs,
> > > > which has begun
> > > > with the changes introducing new workqueues and a new
> > > > alloc_workqueue flag:
> > > > 
> > > >     commit 128ea9f6ccfb ("workqueue: Add system_percpu_wq and
> > > > system_dfl_wq")
> > > >     commit 930c2ea566af ("workqueue: Add new WQ_PERCPU flag")
> > > > 
> > > > The point of the refactoring is to eventually alter the default
> > > > behavior of
> > > > workqueues to become unbound by default so that their workload
> > > > placement is
> > > > optimized by the scheduler.
> > > > 
> > > > Before that to happen, workqueue users must be converted to the
> > > > better named
> > > > new workqueues with no intended behaviour changes:
> > > > 
> > > >     system_wq -> system_percpu_wq
> > > >     system_unbound_wq -> system_dfl_wq
> > > > 
> > > > This way the old obsolete workqueues (system_wq,
> > > > system_unbound_wq) can be
> > > > removed in the future.
> > > 
> > > I recall earlier efforts to replace system workqueues with
> > > per‑driver queues,
> > > because unloading a driver forces a flush of the entire system
> > > workqueue,
> > > which is undesirable for overall system behavior.
> > > 
> > > Wouldn't it be better to introduce a local workqueue here and use
> > > that instead?
> > 
> > Thanks.
> > 
> > 1.The initialization should be:
> > 
> > my_wq = alloc_workqueue("my_driver_queue", WQ_UNBOUND | WQ_MEM_RECLAIM,
> > 0);
> > if (!my_wq)
> >     return -ENOMEM;
> > 
> > 2. The Submission should be:
> > 
> > queue_work(my_wq, &my_work);
> > 
> > 3. Destroy should be:
> > 
> > destroy_workqueue()
> > 
> > Thanks,
> > Zhu Yanjun
> 
> Hi, Leon
> 
> The diff for a new work queue in rxe is as below. Please review it.

I'm not sure that you need second workqueue and destroy_workqueue
already does flush_workqueue. There is no need to call it explicitly.

Thanks

> 
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c
> b/drivers/infiniband/sw/rxe/rxe_odp.c
> index bc11b1ec59ac..03199fef47fb 100644
> --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
>          work->frags[i].mr = mr;
>      }
> 
> -    queue_work(system_unbound_wq, &work->work);
> +    rxe_queue_aux_work(&work->work);
> 
>      return 0;
> 
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.c
> b/drivers/infiniband/sw/rxe/rxe_task.c
> index f522820b950c..a2da699b969e 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.c
> +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> @@ -6,19 +6,36 @@
> 
>  #include "rxe.h"
> 
> +/* work for rxe_task */
>  static struct workqueue_struct *rxe_wq;
> 
> +/* work for other rxe jobs */
> +static struct workqueue_struct *rxe_aux_wq;
> +
>  int rxe_alloc_wq(void)
>  {
> -    rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> +    rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND | WQ_MEM_RECLAIM,
> +                WQ_MAX_ACTIVE);
>      if (!rxe_wq)
>          return -ENOMEM;
> 
> +    rxe_aux_wq = alloc_workqueue("rxe_aux_wq",
> +                WQ_UNBOUND | WQ_MEM_RECLAIM, WQ_MAX_ACTIVE);
> +    if (!rxe_aux_wq) {
> +        destroy_workqueue(rxe_wq);
> +        return -ENOMEM;
> +
> +    }
> +
>      return 0;
>  }
> 
>  void rxe_destroy_wq(void)
>  {
> +    flush_workqueue(rxe_aux_wq);
> +    destroy_workqueue(rxe_aux_wq);
> +
> +    flush_workqueue(rxe_wq);
>      destroy_workqueue(rxe_wq);
>  }
> 
> @@ -254,6 +271,14 @@ void rxe_sched_task(struct rxe_task *task)
>      spin_unlock_irqrestore(&task->lock, flags);
>  }
> 
> +/* rxe_wq for rxe tasks. rxe_aux_wq for other rxe jobs.
> + */
> +void rxe_queue_aux_work(struct work_struct *work)
> +{
> +    WARN_ON_ONCE(!rxe_aux_wq);
> +    queue_work(rxe_aux_wq, work);
> +}
> +
>  /* rxe_disable/enable_task are only called from
>   * rxe_modify_qp in process context. Task is moved
>   * to the drained state by do_task.
> diff --git a/drivers/infiniband/sw/rxe/rxe_task.h
> b/drivers/infiniband/sw/rxe/rxe_task.h
> index a8c9a77b6027..e1c0a34808b4 100644
> --- a/drivers/infiniband/sw/rxe/rxe_task.h
> +++ b/drivers/infiniband/sw/rxe/rxe_task.h
> @@ -36,6 +36,7 @@ int rxe_alloc_wq(void);
> 
>  void rxe_destroy_wq(void);
> 
> +void rxe_queue_aux_work(struct work_struct *work);
>  /*
>   * init rxe_task structure
>   *    qp  => parameter to pass to func
> 
> Zhu Yanjun
> 
> > 
> > > 
> > > Thanks
> > > 
> > > > 
> > > > Link:
> > > > https://lore.kernel.org/all/20250221112003.1dSuoGyc@linutronix.de/
> > > > Suggested-by: Tejun Heo <tj@kernel.org>
> > > > Signed-off-by: Marco Crivellari <marco.crivellari@suse.com>
> > > > ---
> > > >   drivers/infiniband/sw/rxe/rxe_odp.c | 2 +-
> > > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > index bc11b1ec59ac..d440c8cbaea5 100644
> > > > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > > @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct
> > > > ib_pd *ibpd,
> > > >           work->frags[i].mr = mr;
> > > >       }
> > > >   -    queue_work(system_unbound_wq, &work->work);
> > > > +    queue_work(system_dfl_wq, &work->work);
> > > >         return 0;
> > > >   --
> > > > 2.53.0
> > > > 
> > 
> 

