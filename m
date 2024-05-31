Return-Path: <linux-rdma+bounces-2727-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E058D5F23
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 12:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2753A1C220F5
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 10:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 236B5558A5;
	Fri, 31 May 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A55Jxqdt"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF78140395;
	Fri, 31 May 2024 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717149606; cv=none; b=qbBrxWYQe9A744E19T/TSe/h6wVt0BrweXSQsE4ejhE4roaBdQtJ1QMdOZXSkCiJLssZAyyHRJZl0LTtG1/Utl4cFwWSn0jqGhEGwiuYY1hQTiEgjxM0jU7pFotiauxk2Zt3Eo/QA52K66BPYe3hJw8sUCUZrpnAVDpXL2pzqBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717149606; c=relaxed/simple;
	bh=z8yB8OQXjB3WlTE06q4oT4336b2IkSpm9Wv5WCeHpmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jae+72AI0sQe3/GY2MROEVI3wHTsHQZl0sKtfYv3gtkc4bdcZRb3fWWi0XGSa8fgb7kPa2OgfYelMumyZRmmqZKQ9ssdh4rtj/PKgN+7/RsdlDkmUOmuGpXQbRzC/Mebpf0UdlHt02+/Za8D9ccPd7ClU+LWAcMVpnaNxCgp7eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A55Jxqdt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C2A7C116B1;
	Fri, 31 May 2024 10:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717149606;
	bh=z8yB8OQXjB3WlTE06q4oT4336b2IkSpm9Wv5WCeHpmI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A55JxqdtPnzbguBZIRJmtvMXADNpUnaLsEmY0IAHpj6ZV+6tiIPXUmnz2Tvfrl1bL
	 +s9YHlAOg4WnstWxVbnj3onii2SjbW73HgJcS+aVXaWDeM9zkLOQ5AzsS3WcyrW+wt
	 FFoHAjY7OkJll6v5q2ETvBrPB4vMi9NGzIuF6Ya6VEZ1cEiCmc5MSfMMwjPu54/Q1R
	 dsf5wV9KzBtzxE1eEEuRiwirUz1CfvO9P7azt2kaWGkkbri3fAK7rEgPkLaHpq+U8N
	 D5siFuY2U04AwfwbFpzojxEOnK1s9RzVLkBUQGwdnCWkOhjBrAQuRuTIJomdvVIghF
	 6EBNvFSCugpig==
Date: Fri, 31 May 2024 13:00:00 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Anand Khoje <anand.a.khoje@oracle.com>
Cc: linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	rama.nichanamatlu@oracle.com, manjunath.b.patil@oracle.com,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH 1/1] RDMA/mlx5: Release CPU for other processes in
 mlx5_free_cmd_msg()
Message-ID: <20240531100000.GG3884@unreal>
References: <20240522033256.11960-1-anand.a.khoje@oracle.com>
 <20240522033256.11960-2-anand.a.khoje@oracle.com>
 <20240530171440.GE3884@unreal>
 <f6d81694-c321-470e-8b53-dcdf24d67c9b@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6d81694-c321-470e-8b53-dcdf24d67c9b@oracle.com>

On Fri, May 31, 2024 at 10:21:39AM +0530, Anand Khoje wrote:
> 
> On 5/30/24 22:44, Leon Romanovsky wrote:
> > On Wed, May 22, 2024 at 09:02:56AM +0530, Anand Khoje wrote:
> > > In non FLR context, at times CX-5 requests release of ~8 million device pages.
> > > This needs humongous number of cmd mailboxes, which to be released once
> > > the pages are reclaimed. Release of humongous number of cmd mailboxes
> > > consuming cpu time running into many secs, with non preemptable kernels
> > > is leading to critical process starving on that cpu’s RQ. To alleviate
> > > this, this patch relinquishes cpu periodically but conditionally.
> > > 
> > > Orabug: 36275016
> > > 
> > > Signed-off-by: Anand Khoje <anand.a.khoje@oracle.com>
> > > ---
> > >   drivers/net/ethernet/mellanox/mlx5/core/cmd.c | 7 +++++++
> > >   1 file changed, 7 insertions(+)
> > > 
> > > diff --git a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> > > index 9c21bce..9fbf25d 100644
> > > --- a/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> > > +++ b/drivers/net/ethernet/mellanox/mlx5/core/cmd.c
> > > @@ -1336,16 +1336,23 @@ static struct mlx5_cmd_msg *mlx5_alloc_cmd_msg(struct mlx5_core_dev *dev,
> > >   	return ERR_PTR(err);
> > >   }
> > > +#define RESCHED_MSEC 2
> > >   static void mlx5_free_cmd_msg(struct mlx5_core_dev *dev,
> > >   			      struct mlx5_cmd_msg *msg)
> > >   {
> > >   	struct mlx5_cmd_mailbox *head = msg->next;
> > >   	struct mlx5_cmd_mailbox *next;
> > > +	unsigned long start_time = jiffies;
> > >   	while (head) {
> > >   		next = head->next;
> > >   		free_cmd_box(dev, head);
> > Did you consider to make this function asynchronous and parallel?
> > 
> > Thanks
> 
> Hi Leon,
> 
> Thanks for reviewing this patch.
> 
> Here, all page related methods give_pages/reclaim_pages/release_all_pages
> are executed in a worker thread through pages_work_handler().
> 
> Doesn't that mean it is already asynchronous?

You didn't provide any performance data, so I can't say if it is related to work_handlers.

For example, we can be in this loop when we call to mlx5_cmd_disable()
and it will cause to synchronous calls to dma_pool_free() which holds
the spinlock.

Also pages_work_handler() runs through single threaded workqueue, it is
not asynchronous.

> 
> When the worker thread, in this case it is processing reclaim_pages(), is
> taking a long time - it is starving other processes on the processor that it
> is running on. Oracle UEK being a non-preemptible kernel, these other
> processes that are getting starved do not get CPU until the worker
> relinquishes the CPU. This applies to even processes that are time critical
> and high priority. These processes when starved of CPU for a long time,
> trigger a kernel panic.

Please add kernel panic and perf data to your commit message.

> 
> Hence, this patch implements a time based relinquish of CPU using
> cond_resched().
> 
> Shay Dori, had a suggestion to tune the time (which we have made 2 msec), to
> reduce too frequent context switching and find a balance in processing of
> these mailbox objects. I am presently running some tests on the basis of
> this suggestion.

You will have better results if you parallel page release.

Thanks

> 
> Thanks,
> 
> Anand
> 
> > >   		head = next;
> > > +		if (time_after(jiffies, start_time + msecs_to_jiffies(RESCHED_MSEC))) {
> > > +			mlx5_core_warn_rl(dev, "Spent more than %d msecs, yielding CPU\n", RESCHED_MSEC);
> > > +			cond_resched();
> > > +			start_time = jiffies;
> > > +		}
> > >   	}
> > >   	kfree(msg);
> > >   }
> > > -- 
> > > 1.8.3.1
> > > 
> > > 

