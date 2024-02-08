Return-Path: <linux-rdma+bounces-969-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1622084DAEC
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 09:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0427286616
	for <lists+linux-rdma@lfdr.de>; Thu,  8 Feb 2024 08:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE0869E19;
	Thu,  8 Feb 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObbAzVNK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968BB69E11
	for <linux-rdma@vger.kernel.org>; Thu,  8 Feb 2024 08:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707379239; cv=none; b=TR3ijE5ytO6DRfZUwtmHbsC0nnID5TGfTZBrmLMtJ3mAQ7B7VHvSSyfnCwrCJGQkSQo3dCa/WMxzptzlfAuEJu0pM5wD07qWxSlJpK9eEjvoNQfRvjyvlEcm+7G74Rp7c/15T1eC+NZycxiUtbyOLZ0WOYMhdf9/YmgJZYEVbfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707379239; c=relaxed/simple;
	bh=INjeSbwvEU9umpeQro+UItzxg3FIUvgt7bn0gGD6Bgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lK6vUIXDEM6vyCzoPl1Xpr7NuyOywCK4FLKWkj079zLjzfwzWtXT2oioxwkguPSOi5v+0tEeYSGUHtAM3km1emU91WsDw1JxT/vwMofDzwThLJ7dSX0l9FVN4pQRSFGUv/AuikXB2Omgdk641Fv41JdUrYKoqr3dkKMM8VLQ/cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObbAzVNK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 812C5C433F1;
	Thu,  8 Feb 2024 08:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707379239;
	bh=INjeSbwvEU9umpeQro+UItzxg3FIUvgt7bn0gGD6Bgs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ObbAzVNKs5kaCbBwtv+UFIRqjk15Ug1iOdLnf2SynAPCqXdupiPVgdEfgXbpr8inf
	 Xn/6EQaYXOYrk0og35et1B/cQXv1E513OHLdNg56P5g8b6lljEwGL0k+YZHytw7EwQ
	 ByyyHwHpq79MTx/8wXCfJ063F064KzqGjcloa1/7nsRBSeXmjVkAWIErtTRcZfL008
	 tq4ZkvDwqhqlrJC0gWrESPL9rIfbePm7T9IOSxFlNFCF5MPY5LhQaRsCaiPN/K5flT
	 YcCMaYIamWEK7yDnrKJSZ6Mi+quBHOK0sPEmc7RVmRdRchZMgZC1rP99wrw09RsqHf
	 fzLvb+ba5Mrjw==
Date: Thu, 8 Feb 2024 10:00:34 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Kamal Heib <kheib@redhat.com>
Cc: linux-rdma@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
	Michal Kalderon <mkalderon@marvell.com>,
	Ariel Elior <aelior@marvell.com>
Subject: Re: [PATCH for-rc] RDMA/qedr: Fix qedr_create_user_qp error flow
Message-ID: <20240208080034.GC56027@unreal>
References: <20240206175449.1778317-1-kheib@redhat.com>
 <20240207073114.GA56027@unreal>
 <ZcQZ8cjtll07RQ2q@fedora-x1>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcQZ8cjtll07RQ2q@fedora-x1>

On Wed, Feb 07, 2024 at 07:01:53PM -0500, Kamal Heib wrote:
> On Wed, Feb 07, 2024 at 09:31:14AM +0200, Leon Romanovsky wrote:
> > On Tue, Feb 06, 2024 at 12:54:49PM -0500, Kamal Heib wrote:
> > > Avoid the following warning by making sure to call qedr_cleanup_user()
> > > in case qedr_init_user_queue() failed.
> > 
> > <...>
> > 
> > > diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> > > index 7887a6786ed4..0943abd4de27 100644
> > > --- a/drivers/infiniband/hw/qedr/verbs.c
> > > +++ b/drivers/infiniband/hw/qedr/verbs.c
> > > @@ -1880,7 +1880,7 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
> > >  		rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
> > >  					  ureq.rq_len, true, 0, alloc_and_init);
> > >  		if (rc)
> > > -			return rc;
> > > +			goto err1;
> > 
> > "goto err1" will cause to call to qedr_cleanup_user() which will call to qedr_free_pbl()
> > with qp->urq.pbl_tbl) which can be NULL.
> > 
> > Thanks
> >
> 
> I see, what about something like the following:

It will work.

> 
> diff --git a/drivers/infiniband/hw/qedr/verbs.c b/drivers/infiniband/hw/qedr/verbs.c
> index 7887a6786ed4..f118ce0a9a61 100644
> --- a/drivers/infiniband/hw/qedr/verbs.c
> +++ b/drivers/infiniband/hw/qedr/verbs.c
> @@ -1879,8 +1879,17 @@ static int qedr_create_user_qp(struct qedr_dev *dev,
>                 /* RQ - read access only (0) */
>                 rc = qedr_init_user_queue(udata, dev, &qp->urq, ureq.rq_addr,
>                                           ureq.rq_len, true, 0, alloc_and_init);
> -               if (rc)
> +               if (rc) {
> +                       ib_umem_release(qp->usq.umem);
> +                       qp->usq.umem = NULL;
> +                       if (rdma_protocol_roce(&dev->ibdev, 1)) {
> +                               qedr_free_pbl(dev, &qp->usq.pbl_info,
> +                                             qp->usq.pbl_tbl);
> +                       } else {
> +                               kfree(qp->usq.pbl_tbl);
> +                       }
>                         return rc;
> +               }
>         }
>  
>         memset(&in_params, 0, sizeof(in_params));
> 
> 
> Thanks!
> 
>  
> > >  	}
> > >  
> > >  	memset(&in_params, 0, sizeof(in_params));
> > > -- 
> > > 2.43.0
> > > 
> > > 
> > 
> 

