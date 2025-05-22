Return-Path: <linux-rdma+bounces-10523-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A27CAC0804
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 10:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84C064A09DD
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE6289348;
	Thu, 22 May 2025 08:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDErB1ft"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161EC288CA9
	for <linux-rdma@vger.kernel.org>; Thu, 22 May 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904324; cv=none; b=l4YCbn00S47MUmn0UcWgSwf6vC9rY8yWd2crzzb723tD/q07dnXUsy+WqDnvc9dckZWpgVE9pcBJt8ttJf2Gv3UOqID5cBvg+a5G3BAwbEYL3hF0QnizajPxBOWgVxpuTrYioyq11jp+Inefg8sejiu2uAIagnhS/8LDquqUIrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904324; c=relaxed/simple;
	bh=EWtMKjV7qK00a//Prt5xhUTl7GQK9KURYfpYwVla3yM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gliF/uXEHgeVHecm+AZc1CRDRopK+l7C6F1uLb7ksoAIiE+80pJBjc6O8hlMG/70fJwqDBDOxKnMEC9YQC3o3y5KtQhgGysTQgZR9NqzFJWvDZmeygr+ipsL2AkMvaeub/c1Bf3iNE+2ch1Bk2/6lIkUqwNgCMket4atwhLJCnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDErB1ft; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5604C4CEEF;
	Thu, 22 May 2025 08:58:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747904323;
	bh=EWtMKjV7qK00a//Prt5xhUTl7GQK9KURYfpYwVla3yM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gDErB1ftIxGjZ/rr1tqHaQb/0LmWhi8E3x8gaP8YZYVWOqtKuTO7DK4wi+pck4uaq
	 hTfXYir9P8d8DMwuwlZNDLxpyQjztT02wY0q5x+8ZgH3t5lu52hMOjUyYVCGf4Yh9K
	 Jla/EeUN/DRY1FlTLENPvsAhWvapo2w1QFUyqCSVcWQBRueH4apEhAA+Av8+tqZ+VH
	 sKo6o7pwz9YQSkf5kH7GoLJK5GqNACpcq6ecd/SU/4YZHQ0YZ76kJJhXN8AA7QjRPo
	 44/Wgl/KUSE2nLS0KP97545/r9jUhSxdpwfg4T11nMmh5YpWpINjR1Qv1Dwj3V7zgm
	 PtLnS0LOHn3ag==
Date: Thu, 22 May 2025 11:58:38 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sharath Srinivasan <sharath.srinivasan@oracle.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Jack Morgenstein <jackm@nvidia.com>,
	Feng Liu <feliu@nvidia.com>,
	=?iso-8859-1?Q?H=E5kon?= Bugge <haakon.bugge@oracle.com>,
	linux-rdma@vger.kernel.org, Patrisious Haddad <phaddad@nvidia.com>,
	Vlad Dumitrescu <vdumitrescu@nvidia.com>
Subject: Re: [PATCH rdma-rc] RDMA/cma: Fix hang when cma_netevent_callback
 fails to queue_work
Message-ID: <20250522085838.GO7435@unreal>
References: <4f3640b501e48d0166f312a64fdadf72b059bd04.1747827103.git.leon@kernel.org>
 <0f005949-cf9b-403f-afcb-95be492a8e49@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f005949-cf9b-403f-afcb-95be492a8e49@oracle.com>

On Wed, May 21, 2025 at 11:59:22AM -0700, Sharath Srinivasan wrote:
> 
> On 2025-05-21 4:36 a.m., Leon Romanovsky wrote:
> > From: Jack Morgenstein <jackm@nvidia.com>
> > 
> > The cited commit fixed a crash when cma_netevent_callback was called for
> > a cma_id while work on that id from a previous call had not yet started.
> > The work item was re-initialized in the second call, which corrupted the
> > work item currently in the work queue.
> > 
> > However, it left a problem when queue_work fails (because the item is
> > still pending in the work queue from a previous call). In this case,
> > cma_id_put (which is called in the work handler) is therefore not
> > called. This results in a userspace process hang (zombie process).
> > 
> > Fix this by calling cma_id_put() if queue_work fails.
> > 
> > Fixes: 45f5dcdd0497 ("RDMA/cma: Fix workqueue crash in cma_netevent_work_handler")
> 
> IMO the above Fixes: tag should point to the commit that introduced the line:
> "queue_work(cma_wq, &current_id->id.net_work);"
> 
> i.e. Fixes: 925d046e7e52 ("RDMA/core: Add a netevent notifier to cma")
> 
> and not another bug fix (45f5dcdd0497) which did not introduce the problem being described in this patch (a missing cma_id_put() when queue_work() fails).

It is not, according to the queue_work() description and implementation,
that function call can fail only if this work already exist. Before commit 45f5dcdd0497
that cma_netevent_work was always new and hence can't fail. This is why queue_work()
returned value is almost never checked in the kernel.

Thanks

> 
> Otherwise the fix looks good to me:
> Reviewed-by: Sharath Srinivasan <sharath.srinivasan@oracle.com>
> 
> Thanks,
> Sharath
> 
> > Signed-off-by: Jack Morgenstein <jackm@nvidia.com>
> > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/cma.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index ab31eefa916b3..274cfbd5aaba7 100644
> > --- a/drivers/infiniband/core/cma.c
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -5245,7 +5245,8 @@ static int cma_netevent_callback(struct notifier_block *self,
> >  			   neigh->ha, ETH_ALEN))
> >  			continue;
> >  		cma_id_get(current_id);
> > -		queue_work(cma_wq, &current_id->id.net_work);
> > +		if (!queue_work(cma_wq, &current_id->id.net_work))
> > +			cma_id_put(current_id);
> >  	}
> >  out:
> >  	spin_unlock_irqrestore(&id_table_lock, flags);
> 

