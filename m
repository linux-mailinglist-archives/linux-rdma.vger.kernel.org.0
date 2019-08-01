Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C6FC7D771
	for <lists+linux-rdma@lfdr.de>; Thu,  1 Aug 2019 10:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbfHAIWr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 1 Aug 2019 04:22:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:40158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfHAIWr (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 1 Aug 2019 04:22:47 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 253682087E;
        Thu,  1 Aug 2019 08:22:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564647766;
        bh=s5dXhkpeJafPwDVl5s4Gi0HS4FzDwC6D0rY9X0wyKfk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlByyLIyeYvQXIGUdRoZ1MfXALsdAWfWel272Gr/3Ob8Fe2a/0pLfrmXiHV5aYavx
         N9NwkNb4AIaZjjnRMSt/EnCMiM8uF2Ulf7kvFNg7R0IyF3JkencXFcftSgYjWWz9uT
         DuvqBZJgIo0EFcMfAQf3Wx35IeheEfWRPf5kOcBE=
Date:   Thu, 1 Aug 2019 11:22:43 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>
Cc:     Jason Gunthorpe <jgg@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Message-ID: <20190801082243.GG4832@mtr-leonro.mtl.com>
References: <20190731083852.584-1-leon@kernel.org>
 <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
 <20190731170054.GF22677@mellanox.com>
 <20190731170944.GC4832@mtr-leonro.mtl.com>
 <20190731172215.GJ22677@mellanox.com>
 <20190731180124.GE4832@mtr-leonro.mtl.com>
 <805ad5c2714ad2fb4c9b92eb99a256e8998334f9.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <805ad5c2714ad2fb4c9b92eb99a256e8998334f9.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 02:51:42PM -0400, Doug Ledford wrote:
> On Wed, 2019-07-31 at 21:01 +0300, Leon Romanovsky wrote:
> > On Wed, Jul 31, 2019 at 05:22:19PM +0000, Jason Gunthorpe wrote:
> > > On Wed, Jul 31, 2019 at 08:09:44PM +0300, Leon Romanovsky wrote:
> > > > On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe wrote:
> > > > > On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > > > > > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > > > > > b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > index c2a5780cb394..e12a4404096b 100644
> > > > > > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > > > > > @@ -5802,13 +5802,12 @@ static void
> > > > > > > mlx5_ib_unbind_slave_port(struct
> > > > > > > mlx5_ib_dev *ibdev,
> > > > > > >  		return;
> > > > > > >  	}
> > > > > > >
> > > > > > > -	if (mpi->mdev_events.notifier_call)
> > > > > > > -		mlx5_notifier_unregister(mpi->mdev, &mpi-
> > > > > > > >mdev_events);
> > > > > > > -	mpi->mdev_events.notifier_call = NULL;
> > > > > > > -
> > > > > > >  	mpi->ibdev = NULL;
> > > > > > >
> > > > > > >  	spin_unlock(&port->mp.mpi_lock);
> > > > > > > +	if (mpi->mdev_events.notifier_call)
> > > > > > > +		mlx5_notifier_unregister(mpi->mdev, &mpi-
> > > > > > > >mdev_events);
> > > > > > > +	mpi->mdev_events.notifier_call = NULL;
> > > > > >
> > > > > > I can see where this fixes the problem at hand, but this gives
> > > > > > the
> > > > > > appearance of creating a new race.  Doing a
> > > > > > check/unregister/set-null
> > > > > > series outside of any locks is a red flag to someone
> > > > > > investigating the
> > > > > > code.  You should at least make note of the fact that calling
> > > > > > unregister
> > > > > > more than once is safe.  If you're fine with it, I can add a
> > > > > > comment and
> > > > > > take the patch, or you can resubmit.
> > > > >
> > > > > Mucking about notifier_call like that is gross anyhow, maybe
> > > > > better to
> > > > > delete it entirely.
> > > >
> > > > What do you propose to delete?
> > >
> > > The 'mpi->mdev_events.notifier_call = NULL;' and 'if
> > > (mpi->mdev_events.notifier_call)'
> > >
> > > Once it leaves the lock it stops doing anything useful.
> > >
> > > If you need it, then we can't drop the lock, if you don't, it is
> > > just
> > > dead code, delete it.
> >
> > This specific notifier_call is protected outside
> > of mlx5_ib_unbind_slave_port() by mlx5_ib_multiport_mutex and NULL
> > check
> > is needed to ensure single call to mlx5_notifier_unregister, because
> > calls to mlx5_ib_unbind_slave_port() will be serialized.
>
> But looking at the code, it doesn't appear mlx5_notifier_unregister
> requires there to only be a single call.  It's safe to call it multiple
> times for the same notifier.

I think so.

>
> --
> Doug Ledford <dledford@redhat.com>
>     GPG KeyID: B826A3330E572FDD
>     Fingerprint = AE6B 1BDA 122B 23B4 265B  1274 B826 A333 0E57 2FDD


