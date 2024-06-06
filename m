Return-Path: <linux-rdma+bounces-2937-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 436E88FE4A5
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 12:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A65151F27D39
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 10:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF45B19596C;
	Thu,  6 Jun 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKkS4aDL"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAA1953A6;
	Thu,  6 Jun 2024 10:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717671038; cv=none; b=NZhnhMOpdYY9+o11IXdPu0h8BWEXUf4KnpmUtzUwZkgvaVw9J/bQY9C4rZ36fcOmn2PE63ONb9JLo7A93RCpeoJ+f4SS4MbLIUEd8fUjy0/zYhC1Y5O9c6aClKfZIVoFNStbW0Jc4OBu+Dy7hTGCQSveIZk0bdkA9O1v93IELro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717671038; c=relaxed/simple;
	bh=h6KYXJFHQc+mvtWcnYwa8pq9IgUKG9NU+TZNQUHrWBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UYPbg9aqq8xbhkdXU29P1OtZT2XRCgviQgOIKd/ZZ7erOfOlHmlNe6PE8xfdBL1gKvhXP8XGE0qsRrnXGmtOpAbe8IHI5VZV+8HhG0wyLbmHHMefLMg3y8Z4FJ3IeiFk9HL8Og6SF5BntL3V03ep4aqL1VH5Ex42GOyegKI06Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKkS4aDL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CF8EC4AF07;
	Thu,  6 Jun 2024 10:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717671038;
	bh=h6KYXJFHQc+mvtWcnYwa8pq9IgUKG9NU+TZNQUHrWBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YKkS4aDLqIUaST3xTej8wzC1v80nowkkqWRUFrh+6i+PVWqkXenE1ZJIlaeWIiG+Y
	 Goe6dKflV4loAbp/wforpzwYHCecs32J5pKicHr842xVZrk+Xf3PnfEDk6YNcSo/uU
	 dmU0E8XnqQjl5kwkqdo++HefvFGygx6aLDXr5Xh2E7S4yjCpdrMGETCwk+nMLGgMg/
	 61ibOaPg+oahTjf8vX5SJ1GkkHM9AWzDNKzwuVlX9ZhCr2maP8HL6fGM7q6vdm/c1C
	 vjZuvIUFeemrX4RajzGa6sd5IUHKQKV6xubzwQx9iiI9q4kSaVml9SC7f79TMVHp2g
	 xCiuBQfkrs0Eg==
Date: Thu, 6 Jun 2024 13:50:33 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Message-ID: <20240606105033.GF13732@unreal>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240604120846.GQ3884@unreal>
 <PAXPR83MB0559D385C1AD343A506C45E3B4F82@PAXPR83MB0559.EURPRD83.prod.outlook.com>
 <20240606080136.GB13732@unreal>
 <PAXPR83MB0559D46DC010185AD7F7D531B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559D46DC010185AD7F7D531B4FA2@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Thu, Jun 06, 2024 at 09:30:51AM +0000, Konstantin Taranov wrote:
> > > > > +static void
> > > > > +mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct
> > > > > +gdma_event *event) {
> > > > > +	struct mana_ib_dev *mdev = (struct mana_ib_dev *)ctx;
> > > > > +	struct mana_ib_qp *qp;
> > > > > +	struct ib_event ev;
> > > > > +	unsigned long flag;
> > > > > +	u32 qpn;
> > > > > +
> > > > > +	switch (event->type) {
> > > > > +	case GDMA_EQE_RNIC_QP_FATAL:
> > > > > +		qpn = event->details[0];
> > > > > +		xa_lock_irqsave(&mdev->qp_table_rq, flag);
> > > > > +		qp = xa_load(&mdev->qp_table_rq, qpn);
> > > > > +		if (qp)
> > > > > +			refcount_inc(&qp->refcount);
> > > > > +		xa_unlock_irqrestore(&mdev->qp_table_rq, flag);
> > > > > +		if (!qp)
> > > > > +			break;
> > > > > +		if (qp->ibqp.event_handler) {
> > > > > +			ev.device = qp->ibqp.device;
> > > > > +			ev.element.qp = &qp->ibqp;
> > > > > +			ev.event = IB_EVENT_QP_FATAL;
> > > > > +			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
> > > > > +		}
> > > > > +		if (refcount_dec_and_test(&qp->refcount))
> > > > > +			complete(&qp->free);
> > > > > +		break;
> > > > > +	default:
> > > > > +		break;
> > > > > +	}
> > > > > +}
> > > >
> > > > <...>
> > > >
> > > > > @@ -620,6 +626,11 @@ static int mana_ib_destroy_rc_qp(struct
> > > > mana_ib_qp *qp, struct ib_udata *udata)
> > > > >  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> > > > >  	int i;
> > > > >
> > > > > +	xa_erase_irq(&mdev->qp_table_rq, qp->ibqp.qp_num);
> > > > > +	if (refcount_dec_and_test(&qp->refcount))
> > > > > +		complete(&qp->free);
> > > > > +	wait_for_completion(&qp->free);
> > > >
> > > > This flow is unclear to me. You are destroying the QP and need to
> > > > make sure that mana_ib_event_handler is not running at that point
> > > > and not mess with refcount and complete.
> > >
> > > Hi, Leon. Thanks for the concern. Here is the clarification:
> > > The flow is similar to what mlx5 does with mlx5_get_rsc and
> > mlx5_core_put_rsc.
> > > When we get a QP resource, we increment the counter while holding the xa
> > lock.
> > > So, when we destroy a QP, the code first removes the QP from the xa to
> > ensure that nobody can get it.
> > > And then we check whether mana_ib_event_handler is holding it with
> > refcount_dec_and_test.
> > > If the QP is held, then we wait for the mana_ib_event_handler to call
> > complete.
> > > Once the wait returns, it is impossible to get the QP referenced, since it is
> > not in the xa and all references have been removed.
> > > So now we can release the QP in HW, so the QPN can be assigned to new
> > QPs.
> > >
> > > Leon, have you spotted a bug? Or just wanted to understand the flow?
> > 
> > I understand the "general" flow, but think that implementation is very
> > convoluted here. In addition, mlx5 and other drivers make sure sure that HW
> > object is not free before they free it. They don't "mess" with ibqp, and
> > probably you should do the same.
> 
> I can make the code more readable by introducing 4 helpers: add_qp_ref, get_qp_ref, put_qp_ref, destroy_qp_ref.
> Would it make the code less convoluted for you?

The thing is that you are trying to open-code part of restrack logic,
which already has xarray DB per-QPN, maybe you should extend it to support
your case, by adding some sort of barrier to prevent QP from being used.

> 
> The devices are different. Mana can do EQE with QPN, which can be destroyed by OS. With that reference counting I make sure
> we do not destroy QP which is used in EQE processing. We still destroy the HW resource at same time as before the change.
> The xa table is just a lookup table, which says whether object can be referenced or not. The change just dictates that we first
> make a QP not referenceable.
> 
> Note, that if we remove the QP from the table after we destroy it in HW, we can have a bug due to the collision in the xa table when
> at the same time another entity creates a QP. Since the QPN is released in HW, it will most likely given to the next create_qp (so mana, unlike mlx,
> does not assign QPNs with an increment and gives recently used QPN). So, the create_qp can fail as the QPN is still used in the xa.
> 
> And what do you mean that "don't "mess" with ibqp"? Are you saying that we cannot process QP-related interrupts?
> What do you propose to change? In any case it will be the same logic:
> 1) remove from table
> 2) make sure that current IRQ does not hold a reference
> I use counters for that as most of other IB providers.
> 
> I would also appreciate a list of changes to make this patch approved or confirmation that no changes are required.

I'm not asking to change anything at this point, just trying to see if
there is more general way to solve this problem, which exists in all
drivers now and in the future.

Thanks

> Thanks
> 
> > Thanks
> > 
> > > Thanks
> > >
> > > >
> > > > Thanks

