Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC5C25EE8E
	for <lists+linux-rdma@lfdr.de>; Sun,  6 Sep 2020 17:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729002AbgIFPYm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 6 Sep 2020 11:24:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:45178 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728988AbgIFPYi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 6 Sep 2020 11:24:38 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 939EF20714;
        Sun,  6 Sep 2020 15:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599405878;
        bh=0AN9vTtEVgo+SJBOVzsksipscEZrvAzHFAC1UL7iWfs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SGjpKyNmrwpETQlKgQaZ+ECbe8jVgsNTyn+YrZuCk4Xokv44XE3RaoeU0Zbau6Zue
         CVs/Mfsb58MvBdq0FCZ6Qgd33UCzsTIBWMuv9ExS9ZR376cZx2fUkLo3R0FF+zkKWY
         TYqaGPLj74CdmL5Jcr/jRorA0zovs+Xen7YpguCo=
Date:   Sun, 6 Sep 2020 18:24:33 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 13/13] RDMA/restrack: Drop valid restrack
 field as source of ambiguity
Message-ID: <20200906152433.GJ55261@unreal>
References: <20200830101436.108487-1-leon@kernel.org>
 <20200830101436.108487-14-leon@kernel.org>
 <20200903162148.GA1552408@nvidia.com>
 <20200906142400.GG55261@unreal>
 <20200906142815.GC9166@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200906142815.GC9166@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Sep 06, 2020 at 11:28:15AM -0300, Jason Gunthorpe wrote:
> On Sun, Sep 06, 2020 at 05:24:00PM +0300, Leon Romanovsky wrote:
> > On Thu, Sep 03, 2020 at 01:21:48PM -0300, Jason Gunthorpe wrote:
> > > On Sun, Aug 30, 2020 at 01:14:36PM +0300, Leon Romanovsky wrote:
> > > > From: Leon Romanovsky <leonro@mellanox.com>
> > > >
> > > > The valid field was needed to distinguish between supported/not
> > > > supported QPs, after the create_qp was changed to support all types,
> > > > that field can be dropped and the code simplified a little bit.
> > > >
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > >  drivers/infiniband/core/restrack.c | 29 ++++++++---------------------
> > > >  include/rdma/restrack.h            |  9 ---------
> > > >  2 files changed, 8 insertions(+), 30 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > > index 4caaa6312105..fb5345c8bd89 100644
> > > > +++ b/drivers/infiniband/core/restrack.c
> > > > @@ -143,7 +143,7 @@ static struct ib_device *res_to_dev(struct rdma_restrack_entry *res)
> > > >  		return container_of(res, struct rdma_counter, res)->device;
> > > >  	default:
> > > >  		WARN_ONCE(true, "Wrong resource tracking type %u\n", res->type);
> > > > -		return NULL;
> > > > +		return ERR_PTR(-EINVAL);
> > > >  	}
> > > >  }
> > > >
> > > > @@ -223,7 +223,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
> > > >  	struct rdma_restrack_root *rt;
> > > >  	int ret = 0;
> > > >
> > > > -	if (!dev)
> > > > +	if (IS_ERR_OR_NULL(dev))
> > > >  		return -ENODEV;
> > > >
> > > >  	if (res->no_track)
> > > > @@ -261,10 +261,7 @@ int __must_check rdma_restrack_add(struct rdma_restrack_entry *res)
> > > >  	}
> > > >
> > > >  out:
> > > > -	if (ret)
> > > > -		return ret;
> > > > -	res->valid = true;
> > > > -	return 0;
> > > > +	return ret;
> > > >  }
> > > >  EXPORT_SYMBOL(rdma_restrack_add);
> > > >
> > > > @@ -323,25 +320,16 @@ EXPORT_SYMBOL(rdma_restrack_put);
> > > >   */
> > > >  void rdma_restrack_del(struct rdma_restrack_entry *res)
> > > >  {
> > > > +	struct ib_device *dev = res_to_dev(res);
> > > >  	struct rdma_restrack_entry *old;
> > > >  	struct rdma_restrack_root *rt;
> > > > -	struct ib_device *dev;
> > > >
> > > > -	if (!res->valid) {
> > > > -		if (res->task) {
> > > > -			put_task_struct(res->task);
> > > > -			res->task = NULL;
> > > > -		}
> > > > -		return;
> > > > -	}
> > > > -
> > > > -	if (res->no_track)
> > > > +	WARN_ONCE(!dev && res->type != RDMA_RESTRACK_CM_ID,
> > > > +		  "IB device should be set for restrack type %s",
> > > > +		  type2str(res->type));
> > > > +	if (res->no_track || IS_ERR_OR_NULL(dev))
> > > >  		goto out;
> > > >
> > > > -	dev = res_to_dev(res);
> > > > -	if (WARN_ON(!dev))
> > > > -		return;
> > > > -
> > > >  	rt = &dev->res[res->type];
> > > >  	old = xa_erase(&rt->xa, res->id);
> > >
> > > How does this work without valid?
> > >
> > > xa_alloc is called in rdma_restrack_add() and previously it was safe
> > > to call res_track_del() on unadded things.
> > >
> > > Now there are problems, like __ib_alloc_cq_user() does calls
> > > restrack_del without doing restrack_ad()
> >
> > Maybe I missed it, but I don't see it in the code.
>
> Look at the error unwinding

After this series I will call to rdma_restrack_put() and not to rdma_restrack_del().
in error unwind.

Thanks

>
> Jason
