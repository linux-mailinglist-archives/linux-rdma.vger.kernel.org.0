Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8C07D795
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729531AbfHAI1y (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:27:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729140AbfHAI1y (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:27:54 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 32D282087E;
        Thu,  1 Aug 2019 08:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564648073;
        bh=L8Akj5KKLmVFaa9GYZXaak5d2uP9eVF8GmrFy4RwUF0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1OU/fJQkVFqYgYdQawR9BtzrgrS7Zq6IyyUURt+L0ujjvRgViQuXeUN4f24K/SPjM
         FSPA6+jX8qskxeU5xSfXEqoigUA4TBF7MKZh5WRCKPZ+hpS4EqeDu12LaohTj8P/fg
         cz0wodx02D90WuL3ilmxNbLsBYIf4PoKVrIgy8Bk=
Date:   Thu, 1 Aug 2019 11:27:49 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Message-ID: <20190801082749.GH4832@mtr-leonro.mtl.com>
References: <20190731083852.584-1-leon@kernel.org>
 <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
 <20190731170054.GF22677@mellanox.com>
 <20190731170944.GC4832@mtr-leonro.mtl.com>
 <20190731172215.GJ22677@mellanox.com>
 <20190731180124.GE4832@mtr-leonro.mtl.com>
 <20190731195523.GK22677@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731195523.GK22677@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 07:55:28PM +0000, Jason Gunthorpe wrote:
> On Wed, Jul 31, 2019 at 09:01:24PM +0300, Leon Romanovsky wrote:
> > On Wed, Jul 31, 2019 at 05:22:19PM +0000, Jason Gunthorpe wrote:
> > > On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky wrote:
> > > > On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe wrote:
> > > > > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > > > > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > index c2a5780cb394..e12a4404096b 100644
> > > > > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > @@ -5802,13 +5802,12 @@ static void mlx5_ib_unbind_slave_port(struct
> > > > > > > mlx5_ib_dev *ibdev,
> > > > > > >  		return;
> > > > > > >  	}
> > > > > > >
> > > > > > > -	if (mpi->mdev_events.notifier_call)
> > > > > > > -		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > > > > -	mpi->mdev_events.notifier_call = NULL;
> > > > > > > -
> > > > > > >  	mpi->ibdev = NULL;
> > > > > > >
> > > > > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > > > > +	if (mpi->mdev_events.notifier_call)
> > > > > > > +		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > > > > > +	mpi->mdev_events.notifier_call = NULL;
> > > > > >
> > > > > > I can see where this fixes the problem at hand, but this gives the
> > > > > > appearance of creating a new race.  Doing a check/unregister/set-null
> > > > > > series outside of any locks is a red flag to someone investigating the
> > > > > > code.  You should at least make note of the fact that calling unregister
> > > > > > more than once is safe.  If you're fine with it, I can add a comment and
> > > > > > take the patch, or you can resubmit.
> > > > >
> > > > > Mucking about notifier_call like that is gross anyhow, maybe better to
> > > > > delete it entirely.
> > > >
> > > > What do you propose to delete?
> > >
> > > The 'mpi->mdev_events.notifier_call = NULL;' and 'if
> > > (mpi->mdev_events.notifier_call)'
> > >
> > > Once it leaves the lock it stops doing anything useful.
> > >
> > > If you need it, then we can't drop the lock, if you don't, it is just
> > > dead code, delete it.
> >
> > This specific notifier_call is protected outside
> > of mlx5_ib_unbind_slave_port() by mlx5_ib_multiport_mutex and NULL check
> > is needed to ensure single call to mlx5_notifier_unregister, because
> > calls to mlx5_ib_unbind_slave_port() will be serialized.
>
> If this routine is now relying on locking that is not obvious in the
> function itself then add a lockdep too.

It was "before" without lockdep and we are
protecting "mpi->mdev_events.notifier_call = NULL;"

So why should we change this patch?

Thanks

>
> Jason
