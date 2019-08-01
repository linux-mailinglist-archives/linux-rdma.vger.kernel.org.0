Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E52EF7DF95
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 17:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730728AbfHAP7T (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 11:59:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:53510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729708AbfHAP7T (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 11:59:19 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64016206B8;
        Thu,  1 Aug 2019 15:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564675158;
        bh=6sXYakjSTba1H5xK6EGDWaqk7CCoYYzC7eaDqCYqKtM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FnUowuEuQHz6In1lXhrm5ZV+ZBsBSbAG86zO3leqHD/TyC8imvzeeKd+fHspYKI0z
         HRFxG+Qxi2cs8IyjNIftuq1lrIJ6uz5a26k9R+ZBX6OpMBBoxOalvrLMxrSbSqxUrU
         OSECDylBHikS+p/bXJsx1GkYfzbFV6pFO0A69o3E=
Date:   Thu, 1 Aug 2019 18:59:12 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Message-ID: <20190801155912.GS4832@mtr-leonro.mtl.com>
References: <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
 <20190731170054.GF22677@mellanox.com>
 <20190731170944.GC4832@mtr-leonro.mtl.com>
 <20190731172215.GJ22677@mellanox.com>
 <20190731180124.GE4832@mtr-leonro.mtl.com>
 <20190731195523.GK22677@mellanox.com>
 <20190801082749.GH4832@mtr-leonro.mtl.com>
 <20190801120007.GB23885@mellanox.com>
 <20190801120821.GK4832@mtr-leonro.mtl.com>
 <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <060b3e8fbe48312e9af33b88ba7ba62a6b64b493.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 01, 2019 at 10:16:23AM -0400, Doug Ledford wrote:
> On Thu, 2019-08-01 at 15:08 +0300, Leon Romanovsky wrote:
> > On Thu, Aug 01, 2019 at 12:00:12PM +0000, Jason Gunthorpe wrote:
> > > On Thu, Aug 01, 2019 at 11:27:49AM +0300, Leon Romanovsky wrote:
> > > > On Wed, Jul 31, 2019 at 07:55:28PM +0000, Jason Gunthorpe wrote:
> > > > > On Wed, Jul 31, 2019 at 09:01:24PM +0300, Leon Romanovsky wrote:
> > > > > > On Wed, Jul 31, 2019 at 05:22:19PM +0000, Jason Gunthorpe
> > > > > > wrote:
> > > > > > > On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky
> > > > > > > wrote:
> > > > > > > > On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe
> > > > > > > > wrote:
> > > > > > > > > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford
> > > > > > > > > wrote:
> > > > > > > > > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > > > > index c2a5780cb394..e12a4404096b 100644
> > > > > > > > > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > > > > > @@ -5802,13 +5802,12 @@ static void
> > > > > > > > > > > mlx5_ib_unbind_slave_port(struct
> > > > > > > > > > > mlx5_ib_dev *ibdev,
> > > > > > > > > > >  		return;
> > > > > > > > > > >  	}
> > > > > > > > > > >
> > > > > > > > > > > -	if (mpi->mdev_events.notifier_call)
> > > > > > > > > > > -		mlx5_notifier_unregister(mpi->mdev,
> > > > > > > > > > > &mpi->mdev_events);
> > > > > > > > > > > -	mpi->mdev_events.notifier_call = NULL;
> > > > > > > > > > > -
> > > > > > > > > > >  	mpi->ibdev = NULL;
> > > > > > > > > > >
> > > > > > > > > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > > > > > > > > +	if (mpi->mdev_events.notifier_call)
> > > > > > > > > > > +		mlx5_notifier_unregister(mpi->mdev,
> > > > > > > > > > > &mpi->mdev_events);
> > > > > > > > > > > +	mpi->mdev_events.notifier_call = NULL;
> > > > > > > > > >
> > > > > > > > > > I can see where this fixes the problem at hand, but
> > > > > > > > > > this gives the
> > > > > > > > > > appearance of creating a new race.  Doing a
> > > > > > > > > > check/unregister/set-null
> > > > > > > > > > series outside of any locks is a red flag to someone
> > > > > > > > > > investigating the
> > > > > > > > > > code.  You should at least make note of the fact that
> > > > > > > > > > calling unregister
> > > > > > > > > > more than once is safe.  If you're fine with it, I can
> > > > > > > > > > add a comment and
> > > > > > > > > > take the patch, or you can resubmit.
> > > > > > > > >
> > > > > > > > > Mucking about notifier_call like that is gross anyhow,
> > > > > > > > > maybe better to
> > > > > > > > > delete it entirely.
> > > > > > > >
> > > > > > > > What do you propose to delete?
> > > > > > >
> > > > > > > The 'mpi->mdev_events.notifier_call = NULL;' and 'if
> > > > > > > (mpi->mdev_events.notifier_call)'
> > > > > > >
> > > > > > > Once it leaves the lock it stops doing anything useful.
> > > > > > >
> > > > > > > If you need it, then we can't drop the lock, if you don't,
> > > > > > > it is just
> > > > > > > dead code, delete it.
> > > > > >
> > > > > > This specific notifier_call is protected outside
> > > > > > of mlx5_ib_unbind_slave_port() by mlx5_ib_multiport_mutex and
> > > > > > NULL check
> > > > > > is needed to ensure single call to mlx5_notifier_unregister,
> > > > > > because
> > > > > > calls to mlx5_ib_unbind_slave_port() will be serialized.
> > > > >
> > > > > If this routine is now relying on locking that is not obvious in
> > > > > the
> > > > > function itself then add a lockdep too.
> > > >
> > > > It was "before" without lockdep and we are
> > > > protecting "mpi->mdev_events.notifier_call = NULL;"
> > >
> > > Before the locking was relying on mpi_lock inside this function now
> > > this patch changes it to relies on mlx5_ib_multiport_mutex, so it
> > > needs a lockdep
> >
> > It didn't rely, but was moved by mistake. I'll add lockdep and resend.
> >
> > Thanks
>
> There's no need for a lockdep.  The removal of the notifier callback
> entry is re-entrant safe.  The core removal routines have their own
> spinlock they use to protect the actual notifier list.  If you call it
> more than once, the second and subsequent calls merely scan the list,
> find no matching entry, and return ENOENT.  The only reason this might
> need a lock and a lockdep entry is if you are protecting against a race
> with the *add* notifier code in the mlx5 driver specifically (the core
> add code won't have an issue, but since you only have a single place to
> store the notifier callback pointer, if it would be possible for you to
> add two callbacks and write over the first callback pointer with the
> second without removing the first, then you would leak a callback
> notifier in the core notifier list).

atomic_notifier_chain_unregister() unconditionally calls to
syncronize_rcu() and I'm not so sure that it is best thing to do
for every port unbind.

Actually, I'm completely lost here, we are all agree that the patch
fixes issue correctly, and it returns the code to be exactly as
it was before commit df097a278c75 ("IB/mlx5: Use the new mlx5 core notifier
API"). Can we simply merge it and fix the kernel panic?

Thanks

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


