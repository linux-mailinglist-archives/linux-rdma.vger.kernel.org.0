Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA0D36597D
	for <lists+linux-rdma@lfdr.de>; Tue, 20 Apr 2021 15:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbhDTNGo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 20 Apr 2021 09:06:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:57658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhDTNGj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 20 Apr 2021 09:06:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id ABDC161073;
        Tue, 20 Apr 2021 13:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618923967;
        bh=2w7Ed3BCqxcN4xIn6thXlQe8uN4XXNJvGRwEljF/Gxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m8m2097tFX7TG8c+kFM8+//J9yCME8pOlpG3gBBhZLwEQdvIxyBxGKoTkFoRp9Cha
         q2MOVhJp9fRuNWksUYWsvLDfWQvDlFfZ53iAt+38SZ/DF/FG+t76knTlLiHq23nhvm
         DuwAqNr3rgNDwQztLAXR9N0jMEysBXGbQVd8E3NbeoYxSZ8vQBEOXLMrNqD3jyjrPH
         48y41xDJ1ZRQt+NRA/7t+7vr4buUbd5riXpwS4cVJYAH4jPWHQFcstdtNFmMLO214c
         PuxA2q+3+IurNbHGT2P5UtH5Pqy06VgSKBcr+Buth4PrtrQq0eacFZWT36x73zHcJg
         tHiZVio8LUSSg==
Date:   Tue, 20 Apr 2021 16:06:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <YH7Ru5ZSr1kWGZoa@unreal>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420123950.GA2138447@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 09:39:50AM -0300, Jason Gunthorpe wrote:
> On Sun, Apr 18, 2021 at 04:37:35PM +0300, Leon Romanovsky wrote:
> > From: Shay Drory <shayd@nvidia.com>
> > 
> > Currently, in case of QP, the following use-after-free is possible:
> > 
> > 	cpu0				cpu1
> > 	----				----
> >  res_get_common_dumpit()
> >  rdma_restrack_get()
> >  fill_res_qp_entry()
> > 				ib_destroy_qp_user()
> > 				 rdma_restrack_del()
> > 				 qp->device->ops.destroy_qp()
> >   ib_query_qp()
> >   qp->device->ops.query_qp()
> >     --> use-after-free-qp
> > 
> > This is because rdma_restrack_del(), in case of QP, isn't waiting until
> > all users are gone.
> > 
> > Fix it by making rdma_restrack_del() wait until all users are gone for
> > QPs as well.
> > 
> > Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> > Signed-off-by: Shay Drory <shayd@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/core/restrack.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > index ffabaf327242..def0c5b0efe9 100644
> > --- a/drivers/infiniband/core/restrack.c
> > +++ b/drivers/infiniband/core/restrack.c
> > @@ -340,7 +340,7 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> >  	rt = &dev->res[res->type];
> >  
> >  	old = xa_erase(&rt->xa, res->id);
> > -	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
> > +	if (res->type == RDMA_RESTRACK_MR)
> >  		return;
> 
> Why is MR skipping this?

I don't remember the justification for RDMA_RESTRACK_MR || RDMA_RESTRACK_QP check.
My guess that it is related to the allocation flow (both are not converted) and
have internal objects to the drivers.

> 
> 
> It also calls into the driver under its dumpit, at the very least this
> needs a comment.
> 
> Jason
