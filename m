Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22CBF25EE30
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 16:30:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728940AbgIFOZZ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 10:25:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:58042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728957AbgIFOYi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 10:24:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8A19B207BC;
        Sun,  6 Sep 2020 14:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599402244;
        bh=dJhQbQ3cJjVwJyssRQ7zNyNSbfTW94IW0atFm6h5So0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bEichCto4MgGVwp6kRP/eHT8L/iFBMfCFL2G/s2j36rfqUZY6f0+6qdQgRB9OMsu8
         TyTieDy3Za93rSXcqh1DXKLwVVg6seRNj3kguC9Mc0PxJ3jhpyrNn7qnmeRg1p5nQD
         PsjKQ/Svy2f5z0Mf3cAJgoer4rwUmC1Z4nc34nk4=
Date:   Sun, 6 Sep 2020 17:24:00 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 13/13] RDMA/restrack: Drop valid restrack
 field as source of ambiguity
Message-ID: <20200906142400.GG55261@unreal>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-14-leon@kernel.org>
 <20200903162148.GA1552408@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903162148.GA1552408@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 03, 2020 at 01:21:48PM -0300, Jason Gunthorpe wrote:
> On Sun, Aug 30, 2020 at 01:14:36PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The valid field was needed to distinguish between supported/not
> > supported QPs, after the create_qp was changed to support all types,
> > that field can be dropped and the code simplified a little bit.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/restrack.c | 29 ++++++++---------------------
> >  include/rdma/restrack.h            |  9 ---------
> >  2 files changed, 8 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > index 4caaa6312105..fb5345c8bd89 100644
> > +++ b/drivers/infiniband/core/restrack.c
> > @@ -143,7 +143,7 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
> >  		return container_of(res, struct rdma_counter, res)->device;
> >  	default:
> >  		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
> > -		return NULL;
> > +		return ERR_PTR(-EINVAL);
> >  	}
> >  }
> >
> > @@ -223,7 +223,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
> >  	struct rdma_restrack_root *rt;
> >  	int ret = 0;
> >
> > -	if (!dev)
> > +	if (IS_ERR_OR_NULL(dev))
> >  		return -ENODEV;
> >
> >  	if (res->no_track)
> > @@ -261,10 +261,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
> >  	}
> >
> >  out:
> > -	if (ret)
> > -		return ret;
> > -	res->valid = true;
> > -	return 0;
> > +	return ret;
> >  }
> >  EXPORT_SYMBOL(rdma_restrack_add);
> >
> > @@ -323,25 +320,16 @@ EXPORT_SYMBOL(rdma_restrack_put);
> >   */
> >  void rdma_restrack_del(struct rdma_restrack_entry *res)
> >  {
> > +	struct ib_device *dev = res_to_dev(res);
> >  	struct rdma_restrack_entry *old;
> >  	struct rdma_restrack_root *rt;
> > -	struct ib_device *dev;
> >
> > -	if (!res->valid) {
> > -		if (res->task) {
> > -			put_task_struct(res->task);
> > -			res->task = NULL;
> > -		}
> > -		return;
> > -	}
> > -
> > -	if (res->no_track)
> > +	WARN_ONCE(!dev && res->type != RDMA_RESTRACK_CM_ID,
> > +		  "IB device should be set for restrack type %s",
> > +		  type2str(res->type));
> > +	if (res->no_track || IS_ERR_OR_NULL(dev))
> >  		goto out;
> >
> > -	dev = res_to_dev(res);
> > -	if (WARN_ON(!dev))
> > -		return;
> > -
> >  	rt = &dev->res[res->type];
> >  	old = xa_erase(&rt->xa, res->id);
>
> How does this work without valid?
>
> xa_alloc is called in rdma_restrack_add() and previously it was safe
> to call res_track_del() on unadded things.
>
> Now there are problems, like __ib_alloc_cq_user() does calls
> restrack_del without doing restrack_ad()

Maybe I missed it, but I don't see it in the code.

After this series is applied, the rdma_restrack_del() can be called
only on rdma_restrack_add(). This ensure that ->valid is not needed any
more. Everything that is not added to DB uses rdma_restrack_new() call,
which will be released by rdma_restrack_put().


>
> > @@ -351,7 +339,6 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> >  	WARN_ON(old != res);
>
> So this WARN_ON should trigger?

It helps to find the places with calls to rdma_restrack_del() without
rdma_restrack_add() before.

>
> I don't think this can escape a bit that says that id is in the
> xarray.

Not needed, because of separation between _add() and _new().

>
> I'd say no_track is a flag to add to rdma_restrack_add(), not a bit in
> the struct. The bit in the struct is 'valid' aka
> 'added_to_xarray'. The no_track flag simply doesn't set valid.
>
> Jason
