Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0974A1FC54E
	for <lists+linux-rdma@lfdr.de>; Wed, 17 Jun 2020 06:40:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgFQEjr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 17 Jun 2020 00:39:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:52376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725846AbgFQEjr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 17 Jun 2020 00:39:47 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 395B52082F;
        Wed, 17 Jun 2020 04:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592368786;
        bh=JPjtppjL1O7ACQNa5cMTDcytDs8lCde1/IdPDrFRybQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uGDUSjk8vwpEd4YyB2qVO7zMCreFndUVW/Gp52oX/p7zjHfw33TPLuXGBi0qEW5Jx
         TgdhgJjexmGb4p/AdIlylZVNK1cJqDc+lDjK3XTAVLkQqPp5rBowri/c2ka5tg4kpL
         S4WVg/39MSPjBzZHe7pW3erdqJbaKB/CYDvC9FPs=
Date:   Wed, 17 Jun 2020 07:39:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Yishai Hadas <yishaih@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/core: Check that type_attrs is not NULL
 prior access
Message-ID: <20200617043943.GE2383158@unreal>
References: <20200616105813.2428412-1-leon@kernel.org>
 <20200616192054.GE6578@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616192054.GE6578@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Jun 16, 2020 at 04:20:54PM -0300, Jason Gunthorpe wrote:
> On Tue, Jun 16, 2020 at 01:58:13PM +0300, Leon Romanovsky wrote:
> > diff --git a/drivers/infiniband/core/rdma_core.c b/drivers/infiniband/core/rdma_core.c
> > index 38de4942c682..16b86635d752 100644
> > +++ b/drivers/infiniband/core/rdma_core.c
> > @@ -470,40 +470,41 @@ static struct ib_uobject *
> >  alloc_begin_fd_uobject(const struct uverbs_api_object *obj,
> >  		       struct uverbs_attr_bundle *attrs)
> >  {
> > -	const struct uverbs_obj_fd_type *fd_type =
> > -		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
> > +	const struct uverbs_obj_fd_type *fd_type;
> >  	int new_fd;
> >  	struct ib_uobject *uobj;
> >  	struct file *filp;
> >
> > +	uobj = alloc_uobj(attrs, obj);
> > +	if (IS_ERR(uobj))
> > +		return uobj;
> > +
> > +	fd_type =
> > +		container_of(obj->type_attrs, struct uverbs_obj_fd_type, type);
> >  	if (WARN_ON(fd_type->fops->release != &uverbs_uobject_fd_release &&
> > -		    fd_type->fops->release != &uverbs_async_event_release))
> > +		    fd_type->fops->release != &uverbs_async_event_release)) {
> > +		uverbs_uobject_put(uobj);
> >  		return ERR_PTR(-EINVAL);
> > +	}
>
> I feel like this is a bit cleaner with a goto unwind ?

I don't have strong opinion about it, will resend.

Thanks

>
> Jason
