Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EC1208B50C
	for <lists+linux-rdma@lfdr.de>; Tue, 13 Aug 2019 12:10:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbfHMKKI (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 13 Aug 2019 06:10:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:51218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728048AbfHMKKI (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 13 Aug 2019 06:10:08 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C38206C1;
        Tue, 13 Aug 2019 10:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565691007;
        bh=NjIev1iBAKQfwDFsz8dfbaaQb/4LlK+xSxO+9krnNzc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fDtmdSmQef1PX+/2IDXyFIsKCh+nlzF0lPulUnRVRbOKekhCmBtKnW3NX/UZ/0vwZ
         oasSc27MqUJYw9nPKCHIuFAhV6N4TLWD8Cz3kgXCPRi2xow79Hiuw52h5nWay8bHQ0
         7/1kv9QfpwjvCv8FS9Eeoy3e5gfwfHAU9XYyTHwA=
Date:   Tue, 13 Aug 2019 13:10:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        Yishai Hadas <yishaih@dev.mellanox.co.il>,
        Yishai Hadas <yishaih@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-rc] IB/mlx5: Fix use-after-free error while
 accessing ev_file pointer
Message-ID: <20190813101003.GF29138@mtr-leonro.mtl.com>
References: <20190808081538.28772-1-leon@kernel.org>
 <20190808122615.GC1975@mellanox.com>
 <869b1416-a87b-f361-7722-bf9d231bc262@dev.mellanox.co.il>
 <20190808153411.GE1975@mellanox.com>
 <61b0f6cff0fcc1f4ee06447a9ec3eda9c4784c68.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61b0f6cff0fcc1f4ee06447a9ec3eda9c4784c68.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Aug 12, 2019 at 10:59:07AM -0400, Doug Ledford wrote:
> On Thu, 2019-08-08 at 15:34 +0000, Jason Gunthorpe wrote:
> > On Thu, Aug 08, 2019 at 06:32:00PM +0300, Yishai Hadas wrote:
> > > > > diff --git a/drivers/infiniband/hw/mlx5/devx.c
> > > > > b/drivers/infiniband/hw/mlx5/devx.c
> > > > > index 2d1b3d9609d9..af5bbb35c058 100644
> > > > > +++ b/drivers/infiniband/hw/mlx5/devx.c
> > > > > @@ -2644,12 +2644,13 @@ static int devx_async_event_close(struct
> > > > > inode *inode, struct file *filp)
> > > > >   	struct devx_async_event_file *ev_file = filp-
> > > > > >private_data;
> > > >
> > > > This line is wrong, it should be
> > > >
> > > >    	struct devx_async_event_file *ev_file =
> > > > container_of(struct
> > > >   	                   devx_async_event_file, filp-
> > > > >private_data, uobj);
> > >
> > > You suggested the below 2 lines instead of the above one line,
> > > correct ? as
> > > struct devx_async_event_file wraps uobj as its first field this is
> > > logically
> > > equal, agree ?
> >
> > Yes, it is wrong only in the use of the type system, the private_data
> > void * should only ever be cast to a ib_uobject.
> >
> > > struct ib_uobject *uobj = filp->private_data;
> >
> > This could be done with a cast
> >
> > > > It is also a bit redundant to store the mlx5_ib_dev in the
> > > > devx_async_event_file as uobj->ucontext->dev is the same pointer.
> > > >
> > > Post hot unplug uobj->ucontext might not be accessible, isn't it ?
> > > Current code should be fine for that.
> >
> > That is the other kind of weird thing, all this destruction could be
> > done on unplug..
> >
> > > Are we fine to take this patch ?
> >
> > Yes
>
> Thanks, applied to for-rc.

Doug,

I don't see it in WIP branch, did you push it?

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


