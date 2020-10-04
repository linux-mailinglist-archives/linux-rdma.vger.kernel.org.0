Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6EA28293D
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 08:48:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725825AbgJDGsX (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 02:48:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725822AbgJDGsX (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 02:48:23 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA7FB206A1;
        Sun,  4 Oct 2020 06:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601794103;
        bh=HQ6s0iIRb2rcCsevtHUNj729BGP2JsOOlTa+i9JI6aU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xHCeH4NsdqocEW0fL/aHw8U6ZB15CFdpATTxtdohXVGW31WDIzRQoz9hkpv3in8T+
         R073NNERMYBhPdk1MZX1uJIouifBvCJ4PWqPS9A5ZHGo9DTqIb0HdAVTBvLZKZ8E1x
         c3AJXVFXAAXHUiRs7vKuupIkt7TRLORpCTFFgIlU=
Date:   Sun, 4 Oct 2020 09:48:18 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201004064818.GB9764@unreal>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
 <20201002124217.GA1342563@nvidia.com>
 <20201002125720.GD3094@unreal>
 <20201002131628.GI816047@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002131628.GI816047@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 10:16:28AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 02, 2020 at 03:57:20PM +0300, Leon Romanovsky wrote:
> > On Fri, Oct 02, 2020 at 09:42:17AM -0300, Jason Gunthorpe wrote:
> > > On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> > > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > > index 12ebacf52958..1abcb01d362f 100644
> > > > +++ b/drivers/infiniband/core/cq.c
> > > > @@ -267,10 +267,25 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
> > > >  		goto out_destroy_cq;
> > > >  	}
> > > >
> > > > -	rdma_restrack_add(&cq->res);
> > > > +	ret = rdma_restrack_add(&cq->res);
> > > > +	if (ret)
> > > > +		goto out_poll_cq;
> > > > +
> > > >  	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
> > > >  	return cq;
> > > >
> > > > +out_poll_cq:
> > > > +	switch (cq->poll_ctx) {
> > > > +	case IB_POLL_SOFTIRQ:
> > > > +		irq_poll_disable(&cq->iop);
> > > > +		break;
> > > > +	case IB_POLL_WORKQUEUE:
> > > > +	case IB_POLL_UNBOUND_WORKQUEUE:
> > > > +		cancel_work_sync(&cq->work);
> > >
> > > This error unwind is *technically* in the wrong order, it is wrong in
> > > ib_free_cq too which is an actual bug.
> > >
> > > The cq->comp_handler should be set before calling create_cq and undone
> > > after calling destroy_wq. We can do this right now that the
> > > allocations have been reworked.
> > >
> > > Otherwise there is no assurance the ib_cq_completion_workqueue() won't
> > > be called after this cancel == use after free
> > >
> > > Also, you need to check all the rdma_restrack_del()'s, they should
> > > always be *before* destroying the HW object, eg ib_free_cq() has it
> > > too late. Similarly the add should always be after the HW object is
> > > allocated.
> >
> > It is true to not converted object (QP and MR), everything that was
> > converted has two steps: rdma_restrack_put() before creation,
> > rdma_restrack_add() right after creation and rdma_restrack_del() after
> > successful destroy.
>
> It must be before destroy not after.

We need rdma_restrack_put() after destroy to release memory.

Thanks

>
> Jason
