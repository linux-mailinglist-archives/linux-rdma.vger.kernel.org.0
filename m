Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9938044009E
	for <lists+linux-rdma@lfdr.de>; Fri, 29 Oct 2021 18:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhJ2QxK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 29 Oct 2021 12:53:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:38908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229782AbhJ2QxK (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Fri, 29 Oct 2021 12:53:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id F06606115C;
        Fri, 29 Oct 2021 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635526241;
        bh=8SJryE87lt3CqnNnZFGBP+Z97N7ebwhXXACH8AyGa+U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HRG6EnINZXYlqZP34HiH55mdZRYYVWTTjpS2+Kv2zBHieF+YsToBwuvbyhhBjpQH6
         UQ9Zq6Y8XZwiXCQGWlaFJGZlOLNcplHK2QS3OMEs7TqCqgzanNZASsuDlOPchbq5q0
         5SU9DVuSUK6xccWqSY90Q1+MKKVBSMgEephxKdK2nO+OsGJtSSxViAduUiHjPrU6jE
         lmMWZ3ffFu0zm6xzwFikbcxgZQ+aNBde+q78lH/5fsV6pKYduhLGnYnLsp3f7MXFN+
         j7x7BFwPJg4BXWOk4TWU+zOXs+Z4Pvxu8p8Iu4LH9yM0b1DoaWGxHC/2j0WKOBnIW7
         wPx8BaDU1tGkA==
Date:   Fri, 29 Oct 2021 19:50:37 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/core: Rely on vendors to set right IOVA
Message-ID: <YXwmXef41U32Z6nO@unreal>
References: <4b0a31bbc372842613286a10d7a8cbb0ee6069c7.1635400472.git.leonro@nvidia.com>
 <20211029162702.GA846504@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211029162702.GA846504@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Oct 29, 2021 at 01:27:02PM -0300, Jason Gunthorpe wrote:
> On Thu, Oct 28, 2021 at 08:55:22AM +0300, Leon Romanovsky wrote:
> > From: Aharon Landau <aharonl@nvidia.com>
> > 
> > The vendors set the IOVA of newly created MRs in rereg_user_mr, so don't
> > overwrite it. That ensures that this field is set only if IB_MR_REREG_TRANS
> > flag is provided.
> > 
> > Fixes: 6e0954b11c05 ("RDMA/uverbs: Allow drivers to create a new HW object during rereg_mr")
> 
> This isn't really a fixes type patch..

Why? We see that without this patch MR IOVA is not as expected.

> 
> > Signed-off-by: Aharon Landau <aharonl@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/core/uverbs_cmd.c | 3 ---
> >  1 file changed, 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/core/uverbs_cmd.c b/drivers/infiniband/core/uverbs_cmd.c
> > index 740e6b2efe0e..d1345d76d9b1 100644
> > +++ b/drivers/infiniband/core/uverbs_cmd.c
> > @@ -837,11 +837,8 @@ static int ib_uverbs_rereg_mr(struct uverbs_attr_bundle *attrs)
> >  		new_mr->device = new_pd->device;
> >  		new_mr->pd = new_pd;
> >  		new_mr->type = IB_MR_TYPE_USER;
> > -		new_mr->dm = NULL;
> > -		new_mr->sig_attrs = NULL;
> >  		new_mr->uobject = uobj;
> >  		atomic_inc(&new_pd->usecnt);
> > -		new_mr->iova = cmd.hca_va;
> >  		new_uobj->object = new_mr;
> 
> It is like this because the reg_mr path does it this way, if you want
> to change it here then change reg_mr as well, but that needs auditing
> all the drivers..
> 
> And I'd also suggest removing the other set a few lines below

I decided to be safe than sorry and removed only 100% correct
attributes that does require minimal audit.

Thanks

> 
> Jason
