Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 383297C9FA
	for <lists+linux-rdma@lfdr.de>; Wed, 31 Jul 2019 19:09:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730383AbfGaRJu (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 31 Jul 2019 13:09:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:49168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727327AbfGaRJt (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 31 Jul 2019 13:09:49 -0400
Received: from localhost (unknown [77.137.115.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FD8D214DA;
        Wed, 31 Jul 2019 17:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564592989;
        bh=cNskMdpoV/axlwerfZFOBLqytck4lCUgJDX7UyMuKaI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sqH3NG5meUU7/IYdv2yn6CPV8nqfoXAEtB0STe3zRoNwdH4syXW8sABDzwhAnVaCZ
         3PHO94QKPx96OkMlChDxnEyTrXzkSpwka7fox3Ag/p/Aznciat+kCgOTaptKIkgrLm
         r+tHPc9zM2Qbs+Kd2nmdYfN8pLJhjSu0BootYvBc=
Date:   Wed, 31 Jul 2019 20:09:44 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Release locks during notifier
 unregister
Message-ID: <20190731170944.GC4832@mtr-leonro.mtl.com>
References: <20190731083852.584-1-leon@kernel.org>
 <44863abbef5c1e233cbedfdf959fe900f7722d74.camel@redhat.com>
 <20190731170054.GF22677@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190731170054.GF22677@mellanox.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Jul 31, 2019 at 05:00:59PM +0000, Jason Gunthorpe wrote:
> On Wed, Jul 31, 2019 at 12:22:44PM -0400, Doug Ledford wrote:
> > > diff --git a/drivers/infiniband/hw/mlx5/main.c
> > > b/drivers/infiniband/hw/mlx5/main.c
> > > index c2a5780cb394..e12a4404096b 100644
> > > +++ b/drivers/infiniband/hw/mlx5/main.c
> > > @@ -5802,13 +5802,12 @@ static void mlx5_ib_unbind_slave_port(struct
> > > mlx5_ib_dev *ibdev,
> > >  		return;
> > >  	}
> > >
> > > -	if (mpi->mdev_events.notifier_call)
> > > -		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > -	mpi->mdev_events.notifier_call = NULL;
> > > -
> > >  	mpi->ibdev = NULL;
> > >
> > >  	spin_unlock(&port->mp.mpi_lock);
> > > +	if (mpi->mdev_events.notifier_call)
> > > +		mlx5_notifier_unregister(mpi->mdev, &mpi->mdev_events);
> > > +	mpi->mdev_events.notifier_call = NULL;
> >
> > I can see where this fixes the problem at hand, but this gives the
> > appearance of creating a new race.  Doing a check/unregister/set-null
> > series outside of any locks is a red flag to someone investigating the
> > code.  You should at least make note of the fact that calling unregister
> > more than once is safe.  If you're fine with it, I can add a comment and
> > take the patch, or you can resubmit.
>
> Mucking about notifier_call like that is gross anyhow, maybe better to
> delete it entirely.

What do you propose to delete?

Doug,

I wasn't excited about that code either, but decided to do less possible harm here.

Thanks

>
> Jason
