Return-Path: <linux-rdma+bounces-2929-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 482F68FE074
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 10:02:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4976A1C24CCF
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Jun 2024 08:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A5013C67E;
	Thu,  6 Jun 2024 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TIduEXlY"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3147913A898;
	Thu,  6 Jun 2024 08:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717660901; cv=none; b=iWM0ueLU/chMijHApT6zB6zSIOfYRm8jCWVkCjXRjTil26ToMCjmI2BdegkYcCiuVqTM3SUzkJykIDdA6SbsH+Tv0PFPOgeA8JS1daX9ba5lTjUXG5UgedRaX+dYleCbzFplyzZbHtMjKfATexfA+R8GN9f/+naT40K3Pr6csqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717660901; c=relaxed/simple;
	bh=ekce3OXuudSQTA77aLwVlXQ5YKU+oxCcMsr77jL1Agg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jBo1UJL9YkgticoLo8YR5jrJDX3vRRkmbH4LbcJwo5FjVHA+mtx1grKeMtrZtwV4LyuIYb/0JRp5iPhq3Ex9LWc64+7uvHq7uqxWlzyXlVjOQmeWBf0pXKYSUlLFr3QUeS56oWDx1xCg2TyXlmhdGR+4URmJppb5HO5QNieDBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TIduEXlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38982C4AF10;
	Thu,  6 Jun 2024 08:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717660900;
	bh=ekce3OXuudSQTA77aLwVlXQ5YKU+oxCcMsr77jL1Agg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TIduEXlYnCGz/X/Ue/eoqvO4aSJEU/bWkU4RP3qWZ6aBZhp3sB5D0HpmN5iTea8Ih
	 Er/8sNMNRSG7MD4C32fMPDqmph6xST11lV2oULgcf6UGt1cluh4UvWM+2SZwvt9Jxd
	 KW2+b5cGHAqJuEqYce09uHn9+gSFmms1+RftIySy3E1ATIpR7fj4pNKZ5c+Iwq3v/N
	 ueVbYrgklm3BWEsrqNsYiEY0P3uFfbG1ppUMHYJAUzIlAwjym03ULUeUvbF9LsJoDX
	 ubEy/mz3QMM4bed4zV24h9N0dayuN1PJR1W5SMqp7iFthjcKAOvu5KOl2CcX+lSDPy
	 7FIqefXXuWEVg==
Date: Thu, 6 Jun 2024 11:01:36 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@microsoft.com>
Cc: Konstantin Taranov <kotaranov@linux.microsoft.com>,
	Wei Hu <weh@microsoft.com>,
	"sharmaajay@microsoft.com" <sharmaajay@microsoft.com>,
	Long Li <longli@microsoft.com>, "jgg@ziepe.ca" <jgg@ziepe.ca>,
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH rdma-next 1/1] RDMA/mana_ib: process QP error events
Message-ID: <20240606080136.GB13732@unreal>
References: <1717500963-1108-1-git-send-email-kotaranov@linux.microsoft.com>
 <20240604120846.GQ3884@unreal>
 <PAXPR83MB0559D385C1AD343A506C45E3B4F82@PAXPR83MB0559.EURPRD83.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR83MB0559D385C1AD343A506C45E3B4F82@PAXPR83MB0559.EURPRD83.prod.outlook.com>

On Tue, Jun 04, 2024 at 02:13:39PM +0000, Konstantin Taranov wrote:
> > > +static void
> > > +mana_ib_event_handler(void *ctx, struct gdma_queue *q, struct
> > > +gdma_event *event) {
> > > +	struct mana_ib_dev *mdev = (struct mana_ib_dev *)ctx;
> > > +	struct mana_ib_qp *qp;
> > > +	struct ib_event ev;
> > > +	unsigned long flag;
> > > +	u32 qpn;
> > > +
> > > +	switch (event->type) {
> > > +	case GDMA_EQE_RNIC_QP_FATAL:
> > > +		qpn = event->details[0];
> > > +		xa_lock_irqsave(&mdev->qp_table_rq, flag);
> > > +		qp = xa_load(&mdev->qp_table_rq, qpn);
> > > +		if (qp)
> > > +			refcount_inc(&qp->refcount);
> > > +		xa_unlock_irqrestore(&mdev->qp_table_rq, flag);
> > > +		if (!qp)
> > > +			break;
> > > +		if (qp->ibqp.event_handler) {
> > > +			ev.device = qp->ibqp.device;
> > > +			ev.element.qp = &qp->ibqp;
> > > +			ev.event = IB_EVENT_QP_FATAL;
> > > +			qp->ibqp.event_handler(&ev, qp->ibqp.qp_context);
> > > +		}
> > > +		if (refcount_dec_and_test(&qp->refcount))
> > > +			complete(&qp->free);
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +}
> > 
> > <...>
> > 
> > > @@ -620,6 +626,11 @@ static int mana_ib_destroy_rc_qp(struct
> > mana_ib_qp *qp, struct ib_udata *udata)
> > >  		container_of(qp->ibqp.device, struct mana_ib_dev, ib_dev);
> > >  	int i;
> > >
> > > +	xa_erase_irq(&mdev->qp_table_rq, qp->ibqp.qp_num);
> > > +	if (refcount_dec_and_test(&qp->refcount))
> > > +		complete(&qp->free);
> > > +	wait_for_completion(&qp->free);
> > 
> > This flow is unclear to me. You are destroying the QP and need to make sure
> > that mana_ib_event_handler is not running at that point and not mess with
> > refcount and complete.
> 
> Hi, Leon. Thanks for the concern. Here is the clarification:
> The flow is similar to what mlx5 does with mlx5_get_rsc and mlx5_core_put_rsc.
> When we get a QP resource, we increment the counter while holding the xa lock.
> So, when we destroy a QP, the code first removes the QP from the xa to ensure that nobody can get it.
> And then we check whether mana_ib_event_handler is holding it with refcount_dec_and_test.
> If the QP is held, then we wait for the mana_ib_event_handler to call complete.
> Once the wait returns, it is impossible to get the QP referenced, since it is not in the xa and all references have been removed.
> So now we can release the QP in HW, so the QPN can be assigned to new QPs.
> 
> Leon, have you spotted a bug? Or just wanted to understand the flow?

I understand the "general" flow, but think that implementation is very
convoluted here. In addition, mlx5 and other drivers make sure sure that
HW object is not free before they free it. They don't "mess" with ibqp,
and probably you should do the same.

Thanks

> Thanks
> 
> > 
> > Thanks

