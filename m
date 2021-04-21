Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CEB83664AC
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Apr 2021 07:06:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhDUFEz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Apr 2021 01:04:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230440AbhDUFD7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Apr 2021 01:03:59 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C1FDA61417;
        Wed, 21 Apr 2021 05:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618981406;
        bh=wBnwnDUitc0rUIlCrXRrLrGW8ZLlmslXwts/9sa3pXM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d8gy6imrDNSUDrXuuvsZmXZCtF7vAxZ6X4DnFDvJs1M10sv51K9hSLz5AXb29UmP5
         Zjk6a5AVOoGROP4IqLpTH+I0Tt1sez9uVNMOKgb9VWMeWYEztV2MPFIe6DxqzaWjCI
         P7LQEG+Qxo4mDdm+0zXCOVpsoJMzragCtOiSugFmd4zxo+LMxH8p6KqEUZxve9nDS4
         VmbnpY+eUOvog/WfwyzisuI2HHUlUem849BgH6jMRMWrPvgN0WUJGG54uMLv0moPAl
         ZwLcY+kQ19QHsOyXA8Y+Zo3xRur63MkZ8icHgB3UX6nrCcRnxuHUFG7WhAwZ3qZG84
         9zkXinyn1uGLQ==
Date:   Wed, 21 Apr 2021 08:03:22 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, Shay Drory <shayd@nvidia.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/restrack: Delay QP deletion till all
 users are gone
Message-ID: <YH+yGj3cLuA5ga8s@unreal>
References: <9ba5a611ceac86774d3d0fda12704cecc30606f9.1618753038.git.leonro@nvidia.com>
 <20210420123950.GA2138447@nvidia.com>
 <YH7Ru5ZSr1kWGZoa@unreal>
 <20210420152541.GC1370958@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210420152541.GC1370958@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Apr 20, 2021 at 12:25:41PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 20, 2021 at 04:06:03PM +0300, Leon Romanovsky wrote:
> > On Tue, Apr 20, 2021 at 09:39:50AM -0300, Jason Gunthorpe wrote:
> > > On Sun, Apr 18, 2021 at 04:37:35PM +0300, Leon Romanovsky wrote:
> > > > From: Shay Drory <shayd@nvidia.com>
> > > > 
> > > > Currently, in case of QP, the following use-after-free is possible:
> > > > 
> > > > 	cpu0				cpu1
> > > >  res_get_common_dumpit()
> > > >  rdma_restrack_get()
> > > >  fill_res_qp_entry()
> > > > 				ib_destroy_qp_user()
> > > > 				 rdma_restrack_del()
> > > > 				 qp->device->ops.destroy_qp()
> > > >   ib_query_qp()
> > > >   qp->device->ops.query_qp()
> > > > 
> > > > This is because rdma_restrack_del(), in case of QP, isn't waiting until
> > > > all users are gone.
> > > > 
> > > > Fix it by making rdma_restrack_del() wait until all users are gone for
> > > > QPs as well.
> > > > 
> > > > Fixes: 13ef5539def7 ("RDMA/restrack: Count references to the verbs objects")
> > > > Signed-off-by: Shay Drory <shayd@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > >  drivers/infiniband/core/restrack.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > > > index ffabaf327242..def0c5b0efe9 100644
> > > > +++ b/drivers/infiniband/core/restrack.c
> > > > @@ -340,7 +340,7 @@ void rdma_restrack_del(struct rdma_restrack_entry *res)
> > > >  	rt = &dev->res[res->type];
> > > >  
> > > >  	old = xa_erase(&rt->xa, res->id);
> > > > -	if (res->type == RDMA_RESTRACK_MR || res->type == RDMA_RESTRACK_QP)
> > > > +	if (res->type == RDMA_RESTRACK_MR)
> > > >  		return;
> > > 
> > > Why is MR skipping this?
> > 
> > I don't remember the justification for RDMA_RESTRACK_MR || RDMA_RESTRACK_QP check.
> > My guess that it is related to the allocation flow (both are not converted) and
> > have internal objects to the drivers.
> 
> Well, I don't understand why QP has a bug but MR would not have the
> same one??

I didn't understand when reviewed either, but decided to post it anyway
to get possible explanation for this RDMA_RESTRACK_MR || RDMA_RESTRACK_QP
check.

Thanks

> 
> Jason
