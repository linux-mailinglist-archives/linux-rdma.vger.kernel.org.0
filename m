Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6A9282921
	for <lists+linux-rdma@lfdr.de>; Sun,  4 Oct 2020 08:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725822AbgJDGEK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 4 Oct 2020 02:04:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:47536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725819AbgJDGEK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 4 Oct 2020 02:04:10 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D5F7206A1;
        Sun,  4 Oct 2020 06:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601791449;
        bh=9etWUcduhlXaKfOdVtVw90nrgtg0MZR0MY6UOe/DevE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H83mXnKafAUm46b3uMca+1E+N08B4qFhsJJrBRf/hiP+gEqmedae7yAXLkrbJTIP+
         6roEN53O+2QOmC9tgNAg2nAatxOnvhu57Nh3T9u8TSO10NXGXT3pK3cFHSpqyoM8UL
         45y3mO6vDZgoB2XS/zwxLkY6H7qXMYaRIACXnwyU=
Date:   Sun, 4 Oct 2020 09:04:06 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Mark Zhang <markz@nvidia.com>
Subject: Re: [PATCH rdma-next v3 6/9] RDMA/restrack: Add error handling while
 adding restrack object
Message-ID: <20201004060406.GA9764@unreal>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-7-leon@kernel.org>
 <20201002131318.GA1344650@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002131318.GA1344650@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 10:13:18AM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 26, 2020 at 01:19:35PM +0300, Leon Romanovsky wrote:
> > @@ -449,7 +453,10 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
> >  	ret = ib_dev->ops.alloc_pd(pd, &attrs->driver_udata);
> >  	if (ret)
> >  		goto err_alloc;
> > -	rdma_restrack_add(&pd->res);
> > +
> > +	ret = rdma_restrack_add(&pd->res);
> > +	if (ret)
> > +		goto err_restrack;
> >
> >  	uobj->object = pd;
> >  	uobj_finalize_uobj_create(uobj, attrs);
> > @@ -457,6 +464,9 @@ static int ib_uverbs_alloc_pd(struct uverbs_attr_bundle *attrs)
> >  	resp.pd_handle = uobj->id;
> >  	return uverbs_response(attrs, &resp, sizeof(resp));
> >
> > +err_restrack:
> > +	ib_dev->ops.dealloc_pd(pd, &attrs->driver_udata);
>
> There can be no failure between allocating the HW object and calling
> uobj_finalize_uobj_create(). That was the whole point of that scheme.
> It is really important that be kept.
>
> Now that destroys are allowed to fail we aboslutely cannot have any
> open coded destroys like this *anywhere* in the uobject system.
>
> I think you need to go back to a model where the xarray allocation can
> fail but we can still call del, otherwise the error unwind is a
> complete nightmare.
>
> This also has problems like this:
>
> int ib_dereg_mr_user(struct ib_mr *mr, struct ib_udata *udata)
> {
> 	rdma_restrack_del(&mr->res);
> 	ret = mr->device->ops.dereg_mr(mr, udata);
> 	if (!ret) {
>
> With the uobject destroy retry scheme restrack_del will be called
> multiple times.
>
> I think this is pretty simple to solve, write del as this:
>
> void rdma_restrack_del(struct rdma_restrack_entry *res)
> {
> 	struct ib_device *dev = res_to_dev(res);
> 	struct rdma_restrack_entry *old;
> 	struct rdma_restrack_root *rt;
>
> 	if (WARN_ON(!dev))
> 		return
>
> 	rt = &dev->res[res->type];
> 	if (xa_cmpxchg(&rt->xa, res->id, res, NULL, GFP_KERNEL) != res)
> 		return;
> 	rdma_restrack_put(res);
> 	wait_for_completion(&res->comp);
> }
>
> There is no need to do the wait_for_completion if we didn't change the
> xarray.

We still need to do it, because restrack does two things at the same
time: manages object lifetime (rdma_restrack_new and rdma_restrack_put)
and stores HW IDs (rdma_restrack_add).

For the objects that marked as no_track we still want to ensure that
their allocations are correct.

Thanks

>
> Jason
