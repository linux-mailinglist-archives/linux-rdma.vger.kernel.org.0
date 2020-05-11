Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 958291CE0D8
	for <lists+linux-rdma@lfdr.de>; Mon, 11 May 2020 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgEKQpG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 11 May 2020 12:45:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:53064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728711AbgEKQpG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 11 May 2020 12:45:06 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 036EF20708;
        Mon, 11 May 2020 16:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589215505;
        bh=elAtUSL4B/XpPr2C/FfcE/naqM5sSqqshVqQv04qZ9Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nCD+IeFhrMBQhRyVoAeosusnc0n9byz+7cYdb7Tlt/lpeiLBFQmckEKZ3vJjKkWJJ
         /S0nw7mqIkoGWwYpO5BWEWmBfp5uKOMPflwk4R4ED297PhDrBTT8/YjIyz7czREDmu
         Rv09wRGL6EgguDwozfPyWS2gJNGKj8A2zKscCzqE=
Date:   Mon, 11 May 2020 19:45:01 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Yamin Friedman <yaminf@mellanox.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Christoph Hellwig <hch@lst.de>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/4] infiniband/core: Add protection for shared CQs used
 by ULPs
Message-ID: <20200511164501.GE356445@unreal>
References: <1589122557-88996-1-git-send-email-yaminf@mellanox.com>
 <1589122557-88996-2-git-send-email-yaminf@mellanox.com>
 <20200511043753.GA356445@unreal>
 <892bf273-b343-0ca5-ba96-b0c02bdb510d@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <892bf273-b343-0ca5-ba96-b0c02bdb510d@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 11, 2020 at 02:59:44PM +0300, Yamin Friedman wrote:
>
> On 5/11/2020 7:37 AM, Leon Romanovsky wrote:
> > On Sun, May 10, 2020 at 05:55:54PM +0300, Yamin Friedman wrote:
> > > A pre-step for adding shared CQs. Add the infra-structure to prevent
> > > shared CQ users from altering the CQ configurations. For now all cqs are
> > > marked as private (non-shared). The core driver should use the new force
> > > functions to perform resize/destroy/moderation changes that are not
> > > allowed for users of shared CQs.
> > >
> > > Signed-off-by: Yamin Friedman <yaminf@mellanox.com>
> > > Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
> > > ---
> > >   drivers/infiniband/core/cq.c    | 25 ++++++++++++++++++-------
> > >   drivers/infiniband/core/verbs.c | 37 ++++++++++++++++++++++++++++++++++---
> > >   include/rdma/ib_verbs.h         | 20 +++++++++++++++++++-
> > >   3 files changed, 71 insertions(+), 11 deletions(-)
> > infiniband/core -> RDMA/core
> Will fix.
> >
> > > diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
> > > index 4f25b24..443a9cd 100644
> > > --- a/drivers/infiniband/core/cq.c
> > > +++ b/drivers/infiniband/core/cq.c
> > > @@ -37,6 +37,7 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
> > >   {
> > >   	struct dim *dim = container_of(w, struct dim, work);
> > >   	struct ib_cq *cq = dim->priv;
> > > +	int ret;
> > >
> > >   	u16 usec = rdma_dim_prof[dim->profile_ix].usec;
> > >   	u16 comps = rdma_dim_prof[dim->profile_ix].comps;
> > > @@ -44,7 +45,10 @@ static void ib_cq_rdma_dim_work(struct work_struct *w)
> > >   	dim->state = DIM_START_MEASURE;
> > >
> > >   	trace_cq_modify(cq, comps, usec);
> > > -	cq->device->ops.modify_cq(cq, comps, usec);
> > > +	ret = rdma_set_cq_moderation_force(cq, comps, usec);
> > > +	if (ret)
> > > +		WARN_ONCE(1, "Failed set moderation for CQ 0x%p\n", cq);
> > First WARN_ONCE(ret, ...), second no to pointer address print and third
> > this dump stack won't help, because CQ moderation will fail for many
> > reasons unrelated to the caller.
> Would it be better to not include any warning for failed calls?

At least for most of the places, the answer is yes, you are better to
delete WARN_*s.

WARN_*s are good thing to catch programmers errors, something that can't
be but happened. It is wrong to use them inform about the failures.

Thanks
