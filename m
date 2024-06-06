Return-Path: <linux-rdma+bounces-2928-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEB58FE001
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 09:38:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911A81F22418
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 07:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A81D13AD0F;
	Thu,  6 Jun 2024 07:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hDDoI2mm"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07CD93AC16;
	Thu,  6 Jun 2024 07:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717659487; cv=none; b=b00IJgNcT63eT35kWN4hZkexjTu9ImKrsN3DAPHPJKiQ+q6D7Qb9agUyDoM3kUqR67fV44c/SfVsDoV6A5bMiTeGhjBKSSYtL993MzvD0P9CQ3SpG85m8rJIQtvGy3MoRFQmPPPF0mrU6v1fsL45P86f1Xf5Fch7qlbuovII8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717659487; c=relaxed/simple;
	bh=BjRy2bONDnwpsYh5J5sDM+y5cxV/N4RQdfo+TuyNLsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VPsf3EhWiwx8AZX3pyatJ+9mjNN+UxoTvyDR36ZRe/oL+7CbjftrshOq3tPoszdJToZsBYlJePI0D3frxJE3zh9cnT3M0qzAtUbvbzUxpEVFb8V0iGYvSyDR2TgGtg/Rax525yAqCZOvf/0PeT9Vro1RdFz1+iBQTnHyqi60sHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hDDoI2mm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1607BC4AF12;
	Thu,  6 Jun 2024 07:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717659486;
	bh=BjRy2bONDnwpsYh5J5sDM+y5cxV/N4RQdfo+TuyNLsA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hDDoI2mm06p/NCVDMo41ApIhrMhZ2MQL2aIZG3NVsqLoRbI68S2PR1qR8xX5jXnXl
	 F66QPwka8MSRV/7VVK95YTMKgCdznjxm+snZrvQW5T3gRW1NqhXW/XKCa7qM+VK9VV
	 ufh5QEwOTEm4zKrV+0/yAy6SXeOdx8ZqMBsv9T8LA3QLWIH9xWash0LCfJG4B/ADku
	 iA3Yl0gJj6MMMMg7J8j9jM1etcIDjEQ/YSFlPH8Nitgov+hSfG5LSd/vKPZqu/ePw8
	 ajhy5OyhWJd5E9M3U0jkLPxHMI0MQ/nF2FtOrxE/Suv4F6K1gGDKucvuiLesMwMEGU
	 C5xKoonVhFVfA==
Date: Thu, 6 Jun 2024 10:38:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Tejun Heo <tj@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <20240606073801.GA13732@unreal>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
 <Zl4jPImmEeRuYQjz@slm.duckdns.org>
 <20240604105456.1668-1-hdanton@sina.com>
 <20240604113834.GO3884@unreal>
 <Zl9BOaPDsQBc8hSL@slm.duckdns.org>
 <20240605111055.1843-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605111055.1843-1-hdanton@sina.com>

On Wed, Jun 05, 2024 at 07:10:55PM +0800, Hillf Danton wrote:
> On Tue, 4 Jun 2024 21:58:04 +0300 Leon Romanovsky <leon@kernel.org>
> > On Tue, Jun 04, 2024 at 06:30:49AM -1000, Tejun Heo wrote:
> > > On Tue, Jun 04, 2024 at 02:38:34PM +0300, Leon Romanovsky wrote:
> > > > Thanks, it is very rare situation where call to flush/drain queue
> > > > (in our case kthread_flush_worker) in the middle of the allocation
> > > > flow can be correct. I can't remember any such case.
> > > >
> > > > So even we don't fully understand the root cause, the reimplementation
> > > > is still valid and improves existing code.
> > > 
> > > It's not valid. pwq release is async and while wq free in the error path
> > > isn't. The flush is there so that we finish the async part before
> > > synchronize error handling. The patch you posted will can lead to double
> > > free after a pwq allocation failure. We can make the error path synchronous
> > > but the pwq free path should be updated first so that it stays synchronous
> > > in the error path. Note that it *needs* to be asynchronous in non-error
> > > paths, so it's going to be a bit subtle one way or the other.
> > 
> > But at that point, we didn't add newly created WQ to any list which will execute
> > that asynchronous release. Did I miss something?
> > 
> Maybe it is more subtle than thought, but not difficult to make the wq
> allocation path sync. See if the patch could survive your test.

Thanks, I started to run our tests with Dan's revert.
https://lore.kernel.org/all/171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com/

As premature results, it fixed my lockdep warnings, but it will take time till I get full confidence.
If not, I will try your patch.

Thanks

> 
> --- x/include/linux/workqueue.h
> +++ y/include/linux/workqueue.h
> @@ -402,6 +402,7 @@ enum wq_flags {
>  	 */
>  	WQ_POWER_EFFICIENT	= 1 << 7,
>  
> +	__WQ_INITIALIZING 	= 1 << 14, /* internal: workqueue is initializing */
>  	__WQ_DESTROYING		= 1 << 15, /* internal: workqueue is destroying */
>  	__WQ_DRAINING		= 1 << 16, /* internal: workqueue is draining */
>  	__WQ_ORDERED		= 1 << 17, /* internal: workqueue is ordered */
> --- x/kernel/workqueue.c
> +++ y/kernel/workqueue.c
> @@ -5080,6 +5080,8 @@ static void pwq_release_workfn(struct kt
>  	 * is gonna access it anymore.  Schedule RCU free.
>  	 */
>  	if (is_last) {
> +		if (wq->flags & __WQ_INITIALIZING)
> +			return;
>  		wq_unregister_lockdep(wq);
>  		call_rcu(&wq->rcu, rcu_free_wq);
>  	}
> @@ -5714,8 +5716,10 @@ struct workqueue_struct *alloc_workqueue
>  			goto err_unreg_lockdep;
>  	}
>  
> +	wq->flags |= __WQ_INITIALIZING;
>  	if (alloc_and_link_pwqs(wq) < 0)
>  		goto err_free_node_nr_active;
> +	wq->flags &= ~__WQ_INITIALIZING;
>  
>  	if (wq_online && init_rescuer(wq) < 0)
>  		goto err_destroy;
> --
> 

