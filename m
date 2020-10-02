Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46422813B1
	for <lists+linux-rdma@lfdr.de>; Fri,  2 Oct 2020 15:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387785AbgJBNGD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 2 Oct 2020 09:06:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:59324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726569AbgJBNGD (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 2 Oct 2020 09:06:03 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AE64206E3;
        Fri,  2 Oct 2020 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601643962;
        bh=R6XTUMmHvmA/wMaQy3WwByGZght37TdUTkX/j1BA7B0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=2LR13zwOwDyv93jyGbCAzqL2e7zEZuJ041vXeaMYshRLIWEz0BW3gQtYQ+TVHXEm6
         hAWx0HoCVs1knhNFqBISD/kCDzKC36FeLuYHMY1Fm7RbgO2IbCBCLjXN2AmO9ysrPI
         Y6Sv+BW/MtzIbUXLzW9rCZepEDvPGWmO5OsuLP1o=
Date:   Fri, 2 Oct 2020 16:05:57 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v3 9/9] RDMA/restrack: Drop valid restrack
 field as source of ambiguity
Message-ID: <20201002130557.GE3094@unreal>
References: <20200926101938.2964394-1-leon@kernel.org>
 <20200926101938.2964394-10-leon@kernel.org>
 <20201002125535.GA1344115@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201002125535.GA1344115@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 02, 2020 at 09:55:35AM -0300, Jason Gunthorpe wrote:
> On Sat, Sep 26, 2020 at 01:19:38PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > The valid field was needed to distinguish between supported/not
> > supported QPs, after the create_qp was changed to support all types,
> > that field can be dropped in a favor of no_track field.
> >
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/restrack.c | 29 ++++++++---------------------
> >  include/rdma/restrack.h            |  9 ---------
> >  2 files changed, 8 insertions(+), 30 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > index 593af32d86a0..6ca3e6f3adb5 100644
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
>
> dev can't be NULL
>
> Not sure why this was changed? The error code is always thrown away,
> what was wrong with keeping it as NULL?
>
> Now that all callers check the return code this should be a WARN_ON as
> calling restrack_add in a way that is guarenteed to fail us a ULP
> error.
>
> > +	WARN_ONCE(!dev && res->type != RDMA_RESTRACK_CM_ID,
> > +		  "IB device should be set for restrack type %s",
> > +		  type2str(res->type));
> > +	if (res->no_track || IS_ERR_OR_NULL(dev))
> >  		goto out;
>
> dev is never NULL so that WARN_ONCE doesn't work
>
> Why does this exclude CM_ID? I thought all the fixing in the cm was so
> restrack_add and _del were prefectly paired and a device must be
> present?

Both NULL and RDMA_RESTRACK_CM_ID are not needed, this is how I
discovered the need to clean the cma.c, but left it here.

Thanks

>
> Jason
