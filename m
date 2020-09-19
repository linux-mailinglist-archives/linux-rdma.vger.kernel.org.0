Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA66270C1A
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 11:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726129AbgISJKb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 05:10:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:56494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726041AbgISJKb (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 05:10:31 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 945FC21582;
        Sat, 19 Sep 2020 09:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600506224;
        bh=SIeT7tM5Xc/+hPJT4ZVevUeTRuDcKc+If94tnsUGU1Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=y0wrRtpzwqcqHHW+aOU8R8zOzwnvFcyy0em5sJ/3yI1yR7OXRqlMyParITiTy6h+W
         Xu5sYASQ5eAbcaI+JkWMFCr4afbANaaXVjRfikcyy0lqg6cAZUlDEit5DCd2xrbGPP
         a6GeNiyNNXcuOIVfGZkJewzgC9JYd6HP+ao/L7jk=
Date:   Sat, 19 Sep 2020 12:03:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 07/14] RDMA/cma: Be strict with attaching to
 CMA device
Message-ID: <20200919090340.GB869610@unreal>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-8-leon@kernel.org>
 <20200918232619.GA450933@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918232619.GA450933@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 08:26:19PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2020 at 03:21:49PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The RDMA-CM code wasn't consistent in flows that attached to cma_dev,
> > this caused to situations where failure during attach to listen on such
> > device leave RDMA-CM in non-consistent state.
> >
> > Update the listen/attach flow to correctly deal with failures.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/cma.c | 197 ++++++++++++++++++++--------------
> >  1 file changed, 114 insertions(+), 83 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/cma.c b/drivers/infiniband/core/cma.c
> > index 3fc3c821743d..ab1f8b707a5b 100644
> > +++ b/drivers/infiniband/core/cma.c
> > @@ -458,8 +458,8 @@ static int cma_igmp_send(struct net_device *ndev, union ib_gid *mgid, bool join)
> >  	return (in_dev) ? 0 : -ENODEV;
> >  }
> >
> > -static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
> > -			       struct cma_device *cma_dev)
> > +static int _cma_attach_to_dev(struct rdma_id_private *id_priv,
> > +			      struct cma_device *cma_dev)
> >  {
> >  	cma_dev_get(cma_dev);
> >  	id_priv->cma_dev = cma_dev;
> > @@ -475,15 +475,22 @@ static void _cma_attach_to_dev(struct rdma_id_private *id_priv,
> >  	rdma_restrack_add(&id_priv->res);
> >
> >  	trace_cm_id_attach(id_priv, cma_dev->device);
> > +	return 0;
> >  }
>
> This commit message doesn't explain this patch at all. This is adding
> a return code to _cma_attach_to_dev because some later patch needs
> it. This should also be ordered directly before the later patch
>
> > -static void cma_listen_on_dev(struct rdma_id_private *id_priv,
> > -			      struct cma_device *cma_dev)
> > +static int cma_listen_on_dev(struct rdma_id_private *id_priv,
> > +			     struct cma_device *cma_dev)
> >  {
> >  	struct rdma_id_private *dev_id_priv;
> >  	struct rdma_cm_id *id;
> > @@ -2491,12 +2500,12 @@ static void cma_listen_on_dev(struct rdma_id_private *id_priv,
> >  	lockdep_assert_held(&lock);
> >
> >  	if (cma_family(id_priv) == AF_IB && !rdma_cap_ib_cm(cma_dev->device, 1))
> > -		return;
> > +		return 0;
> >
> >  	id = __rdma_create_id(net, cma_listen_handler, id_priv, id_priv->id.ps,
> >  			      id_priv->id.qp_type, id_priv->res.kern_name);
> >  	if (IS_ERR(id))
> > -		return;
> > +		return PTR_ERR(id);
>
> And there here it is fixing already missing error handling, seems like
> it could be two patches

I don't think so, it is "visible" only after I changed cma_listen_on_dev() function return type,
which is an outcome of _cma_attach_to_dev() change.

Thanks

>
> Jason
