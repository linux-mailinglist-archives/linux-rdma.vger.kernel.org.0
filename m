Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D830281344
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 14:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387826AbgJBM50 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 08:57:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:56576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726017AbgJBM5Z (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 08:57:25 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1877206DC;
        Fri,  2 Oct 2020 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601643445;
        bh=OJLz4v8DaEUpLjKa6x/6SSw3kFk9SIa7eGeT+ryTP48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kl0HEoTRJ7r5yCdHeCCDO//f73DbxO3LVcJdtjus9Fa8MxRUQ1ZjgLAm5klP9lglj
         7l17+QcmaczfB9EvNbNqe/sQl5MxDHafBuKJweL2CRcomPi6lV56z4Y8+h6qlUwTDa
         Aj+s2O31nncOhDCAPUR0azPCmDKMb4J9WCL67ZX0=
Date:   Fri, 2 Oct 2020 15:57:20 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201002125720.GD3094@unreal>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
 <20201002124217.GA1342563@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002124217.GA1342563@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 09:42:17AM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > index 12ebacf52958..1abcb01d362f 100644
> > +++ b/drivers/infiniband/core/cq.c
> > @@ -267,10 +267,25 @@ struct ib_cq *__ib_alloc_cq(struct ib_device *dev, void *private, int nr_cqe,
> >  		goto out_destroy_cq;
> >  	}
> >
> > -	rdma_restrack_add(&cq->res);
> > +	ret = rdma_restrack_add(&cq->res);
> > +	if (ret)
> > +		goto out_poll_cq;
> > +
> >  	trace_cq_alloc(cq, nr_cqe, comp_vector, poll_ctx);
> >  	return cq;
> >
> > +out_poll_cq:
> > +	switch (cq->poll_ctx) {
> > +	case IB_POLL_SOFTIRQ:
> > +		irq_poll_disable(&cq->iop);
> > +		break;
> > +	case IB_POLL_WORKQUEUE:
> > +	case IB_POLL_UNBOUND_WORKQUEUE:
> > +		cancel_work_sync(&cq->work);
>
> This error unwind is *technically* in the wrong order, it is wrong in
> ib_free_cq too which is an actual bug.
>
> The cq->comp_handler should be set before calling create_cq and undone
> after calling destroy_wq. We can do this right now that the
> allocations have been reworked.
>
> Otherwise there is no assurance the ib_cq_completion_workqueue() won't
> be called after this cancel == use after free
>
> Also, you need to check all the rdma_restrack_del()'s, they should
> always be *before* destroying the HW object, eg ib_free_cq() has it
> too late. Similarly the add should always be after the HW object is
> allocated.

It is true to not converted object (QP and MR), everything that was
converted has two steps: rdma_restrack_put() before creation,
rdma_restrack_add() right after creation and rdma_restrack_del() after
successful destroy.

>
> For instance fill_res_cq_entry() calls
>
>   dev->ops.fill_res_cq_entry(msg, cq)
>
> on an already free'd HW object with this arrangment.
>
> These are pre-existing things so lets fix them seperately please

I'll fix later.

>
> Jason
