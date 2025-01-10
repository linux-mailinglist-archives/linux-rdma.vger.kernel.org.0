Return-Path: <linux-rdma+bounces-6956-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AEEA0903C
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 13:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56C7E188C499
	for <lists+linux-rdma@lfdr.de>; Fri, 10 Jan 2025 12:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C3A20C037;
	Fri, 10 Jan 2025 12:23:16 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from stargate.chelsio.com (stargate.chelsio.com [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A06207A23
	for <linux-rdma@vger.kernel.org>; Fri, 10 Jan 2025 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=12.32.117.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736511796; cv=none; b=X8wnHcM4j63LpmtSU1p4Uwqib4deJZAtdHjN9857sSlQ6Giog8Ch66aPpuC0uNDI40zctGcAHqNsGU60zu8IGgrDO7ixsVu28MBzfsmm0XnH0if/ZU0ORCTnq67VH4XkmUPEtgQ0Y1yHLlOzbg3QRcqAUPuG152JOO//zAPPFeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736511796; c=relaxed/simple;
	bh=oWzq1U1kkY6EowI0i7KOT1CEe1q0TzC0l+VgmN5ITdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDyleZo6amZFcQNWPVrh59nHkYYmb59zGzO52UbAijMy4tJFWZW4JeOfy48V5pohRfnAGzPNrk1d456X4Nh8ddrNLgjFUH1IZq//6h8uP3gNGOdhyqPchv6UL9jZfRQFcIKGJAUIF8K4/nIxkiNTiu3aIweB8mFKoKID1fkjaFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com; spf=pass smtp.mailfrom=chelsio.com; arc=none smtp.client-ip=12.32.117.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from localhost (anumula.asicdesigners.com [10.193.191.37])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 50ACMqlC010837;
	Fri, 10 Jan 2025 04:22:53 -0800
Date: Fri, 10 Jan 2025 07:22:52 -0500
From: Anumula Murali Mohan Reddy <anumula@chelsio.com>
To: Leon Romanovsky <leon@kernel.org>
Cc: jgg@nvidia.com, bharat@chelsio.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc v2] RDMA/cxgb4: notify rdma stack for
 IB_EVENT_QP_LAST_WQE_REACHED event
Message-ID: <Z4ERHGq4xNL1lJkx@chelsio.com>
References: <20250107095053.81007-1-anumula@chelsio.com>
 <20250107101911.GA87447@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107101911.GA87447@unreal>

On Tuesday, January 01/07/25, 2025 at 15:49:11 +0530, Leon Romanovsky wrote:
> On Tue, Jan 07, 2025 at 03:20:53PM +0530, Anumula Murali Mohan Reddy wrote:
> > This patch sends IB_EVENT_QP_LAST_WQE_REACHED event on a QP that is in
> > error state and associated with an SRQ. This behaviour is incorporated
> > in flush_qp() which is called when QP transitions to error state.
> > Supports SRQ drain functionality added by commit 844bc12e6da3 ("IB/core:
> > add support for draining Shared receive queues")
> > 
> > Fixes: 844bc12e6da3 ("IB/core: add support for draining Shared receive queues")
> > Signed-off-by: Anumula Murali Mohan Reddy <anumula@chelsio.com>
> > Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
> > ---
> > Changes since v1:
> > Addressed previous review comments
> 
> There are two review comments. One is Fixes line, which is not a big deal
> as I can add it when applying patch, but what about second comment?
> 
> Why is this event limited to QP with SRQ only?
> https://lore.kernel.org/all/20250105090622.GA5511@unreal/
> 
> Thanks
> 
> > ---
> >  drivers/infiniband/hw/cxgb4/qp.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/infiniband/hw/cxgb4/qp.c b/drivers/infiniband/hw/cxgb4/qp.c
> > index 7b5c4522b426..10f61bc16dd5 100644
> > --- a/drivers/infiniband/hw/cxgb4/qp.c
> > +++ b/drivers/infiniband/hw/cxgb4/qp.c
> > @@ -1599,6 +1599,7 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
> >  	int count;
> >  	int rq_flushed = 0, sq_flushed;
> >  	unsigned long flag;
> > +	struct ib_event ev;
> >  
> >  	pr_debug("qhp %p rchp %p schp %p\n", qhp, rchp, schp);
> >  
> > @@ -1607,6 +1608,14 @@ static void __flush_qp(struct c4iw_qp *qhp, struct c4iw_cq *rchp,
> >  	if (schp != rchp)
> >  		spin_lock(&schp->lock);
> >  	spin_lock(&qhp->lock);
> > +	if (qhp->srq) {
> > +		if (qhp->attr.state == C4IW_QP_STATE_ERROR && qhp->ibqp.event_handler) {
> > +			ev.device = qhp->ibqp.device;
> > +			ev.element.qp = &qhp->ibqp;
> > +			ev.event = IB_EVENT_QP_LAST_WQE_REACHED;
> > +			qhp->ibqp.event_handler(&ev, qhp->ibqp.qp_context);
> > +		}
> > +	}
> >  
> >  	if (qhp->wq.flushed) {
> >  		spin_unlock(&qhp->lock);
> > -- 
> > 2.39.3
> > 
> >
RDMA stack expects the IB_EVENT_QP_LAST_WQE_REACHED event only for SRQ
, for non-SRQ  it is handled via the drain cqe

Thanks,
Anumula Murali Mohan Reddy

