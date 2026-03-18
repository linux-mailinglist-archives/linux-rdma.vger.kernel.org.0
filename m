Return-Path: <linux-rdma+bounces-18344-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOqwNs/Iumm6bwIAu9opvQ
	(envelope-from <linux-rdma+bounces-18344-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:46:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8124C2BE84B
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 16:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 582D03040DB6
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2026 15:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939973264F3;
	Wed, 18 Mar 2026 15:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RmCgPND7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BE53A9DA6
	for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2026 15:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773848498; cv=none; b=jLh7pLNTdctaaRnSdBbC4kX6c43Qt2Xy2uMK4Di1cOtY6LGXZFE/U2viFDefEqtgn7lsYFRTS9WrEpLaXfpVTXfsF5J7Otw+MBpuPOaj7PI2SCjSTZkO5LMqRAP1tRbuN956hrAM7DF6pZPA66uuSEY/ZUogsf80S8EQFrPSlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773848498; c=relaxed/simple;
	bh=amum9/345NuRUXJP6lO/HUFIq7fvh8S9cRFquGg9Dk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q58BlDA7qPdmizZzaPMXwpA49uOtW6HaM2Ew+6nEyy3zGEnsq24VB8f+i4NjIyN5ExJKM+eko52lhKmCxriWgJxlMTpSTSwRoXyOjfPug6m2Jjmeddc+12HvxJCwZT7fAUZ7KXUSChrElKiUxtpOSgOnMTmYo9k4wZhb8vwbZ3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RmCgPND7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6925EC19421;
	Wed, 18 Mar 2026 15:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773848498;
	bh=amum9/345NuRUXJP6lO/HUFIq7fvh8S9cRFquGg9Dk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RmCgPND7heUMcSd68EWZlkyP5a5YHGGAy5waqifEL4doQU1wu2m2s4mCp9uj3p5CZ
	 GiRZ5fnylIkJlsY61GKzLiB9CU6k8N+u59JXDmTSIrCjt2Q8XaQc3MOtajO8whYJYp
	 cBHqNJ76JK8VvMDlcKJldoWfRLLSX13zuX+W8+c2paHWAnWQRMtXvZiou/qUTNo3Vu
	 H+l0yehAnqNRuOAsSH43ggHhFDfTufM+GdCUZ6ezIvTID95ZSPUyR4VOleMXcdYt0W
	 whLcu+Vkng9hvVqkKY5pVXX4GUCmt+I6YVXIOat9AUSmon39r+rvkIOfrGo4DYeZs/
	 qs9+KCB+9Pozg==
Date: Wed, 18 Mar 2026 17:41:33 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: zyjzyj2000@gmail.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/rxe: Use a dedicated and robust workqueue for
 RXE tasks
Message-ID: <20260318154133.GF352386@unreal>
References: <20260318025739.5058-1-yanjun.zhu@linux.dev>
 <20260318145327.GC352386@unreal>
 <9963f346-cd53-4f88-bb54-642a5babb768@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9963f346-cd53-4f88-bb54-642a5babb768@linux.dev>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-18344-lists,linux-rdma=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-rdma];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 8124C2BE84B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 08:34:42AM -0700, Zhu Yanjun wrote:
> 
> 在 2026/3/18 7:53, Leon Romanovsky 写道:
> > On Wed, Mar 18, 2026 at 03:57:39AM +0100, Zhu Yanjun wrote:
> > > Currently, the RXE driver uses the system-wide 'system_unbound_wq' for
> > > auxiliary tasks like ODP prefetching. This can lead to interference
> > > from other system services and lacks guaranteed forward progress
> > > under memory pressure.
> > > 
> > > Currently make all the tasks queue into the driver-specific 'rxe_wq'.
> > > 
> > > Suggested-by: Leon Romanovsky <leon@kernel.org>
> > > Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> > > ---
> > >   drivers/infiniband/sw/rxe/rxe_odp.c  |  2 +-
> > >   drivers/infiniband/sw/rxe/rxe_task.c | 10 +++++++++-
> > >   drivers/infiniband/sw/rxe/rxe_task.h |  1 +
> > >   3 files changed, 11 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_odp.c b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > index bc11b1ec59ac..98092dcc1870 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_odp.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_odp.c
> > > @@ -545,7 +545,7 @@ static int rxe_ib_advise_mr_prefetch(struct ib_pd *ibpd,
> > >   		work->frags[i].mr = mr;
> > >   	}
> > > -	queue_work(system_unbound_wq, &work->work);
> > > +	rxe_queue_work(&work->work);
> > >   	return 0;
> > > diff --git a/drivers/infiniband/sw/rxe/rxe_task.c b/drivers/infiniband/sw/rxe/rxe_task.c
> > > index f522820b950c..4385137eb4d7 100644
> > > --- a/drivers/infiniband/sw/rxe/rxe_task.c
> > > +++ b/drivers/infiniband/sw/rxe/rxe_task.c
> > > @@ -10,7 +10,8 @@ static struct workqueue_struct *rxe_wq;
> > >   int rxe_alloc_wq(void)
> > >   {
> > > -	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND, WQ_MAX_ACTIVE);
> > > +	rxe_wq = alloc_workqueue("rxe_wq", WQ_UNBOUND | WQ_MEM_RECLAIM,
> > Why did you add WQ_MEM_RECLAIM flag? rxe_ib_advise_mr_prefetch() doesn't
> > perform any memory reclaim.
> 
> You are correct that rxe_ib_advise_mr_prefetch() does not directly call
> memory reclaim functions.
> 
> However, the WQ_MEM_RECLAIM flag was added to prevent circular dependencies
> during
> 
> low-memory conditions.
> 
> Since rxe handles memory regions that may be part of the storage or network
> stack,
> 
> the workqueue must be able to make progress even when the system is under
> extreme
> 
> memory pressure. Without this flag, if the kernel attempts to reclaim memory
> and that
> 
> reclaim process depends on an RDMA operation being processed by this
> workqueue,
> 
> the system could deadlock because the workqueue might be unable to spawn a
> new
> 
> worker thread.
> 
> By setting WQ_MEM_RECLAIM, we ensure that a rescuer thread is pre-allocated,
> 
> guaranteeing that prefetch and MR-related tasks can complete and allow the
> 
> memory management subsystem to finish its reclaim cycle.

Zhu,

Please avoid relying on AI when answering ML-related questions. The  
response you received is broadly correct, but it is incorrect for RXE.  
You should set the WQ_MEM_RECLAIM flag only when the workqueue handlers  
free memory. RXE does the opposite in rxe_ib_advise_mr_prefetch().

Thanks

> 
> 
> Zhu Yanjun
> 
> > 
> > Thanks
> 
> -- 
> Best Regards,
> Yanjun.Zhu
> 
> 

