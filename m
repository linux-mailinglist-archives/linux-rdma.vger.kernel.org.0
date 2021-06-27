Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C278D3B526A
	for <lists+linux-rdma@lfdr.de>; Sun, 27 Jun 2021 09:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhF0Hd2 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 27 Jun 2021 03:33:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:34452 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229534AbhF0Hd1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 27 Jun 2021 03:33:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1161161C17;
        Sun, 27 Jun 2021 07:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624779063;
        bh=q511T8tgjpycuiF9Uy6fhTCaiui1eZRwQqAaYLuYPHI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DTi7MMqm994FZasb0KBvnViTAYDjvgalW3uQMP37UhaxINo+drUsz7i13KxO2koA/
         Z+FnoTWBwkeuEdeCtizvZjTpUAaOW71xbf3EAYrQuPA3jFwCZuK/6FWvEfd4MgPTsn
         x/bVvkdP7gAhEbE5Aagkfy3AaRhbApzU6Fm5F9oKuMu5nyPT0Q3e2lbk4B/k661HH9
         8Sht+f5uLw+A/98pmSgdssMxBV7YllkjcjOibmy3c/i1X5BbADXd6R2yWMezhs+KsN
         jyYrjApk5YlGtmfjpu6xcX4tbAiQmcqQQUU9xyzgvlsK/UdOjP8RHHTdCHdVjL7TLu
         T6AdM87DvAfwQ==
Date:   Sun, 27 Jun 2021 10:30:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Max Gurtovoy <mgurtovoy@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Avihai Horon <avihaih@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tom Talpey <tom@talpey.com>,
        Santosh Shilimkar <santosh.shilimkar@oracle.com>,
        Chuck Lever III <chuck.lever@oracle.com>,
        Keith Busch <kbusch@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        Honggang LI <honli@redhat.com>
Subject: Re: [PATCH v2 rdma-next] RDMA/mlx5: Enable Relaxed Ordering by
 default for kernel ULPs
Message-ID: <YNgpM+007Sm/SWhw@unreal>
References: <b7e820aab7402b8efa63605f4ea465831b3b1e5e.1623236426.git.leonro@nvidia.com>
 <9c5b7ae5-8578-3008-5e78-02e77e121cda@nvidia.com>
 <YNQoY7MRdYMNAUPg@unreal>
 <1ef0ac51-4c7d-d79d-cb30-2e219f74c8c1@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ef0ac51-4c7d-d79d-cb30-2e219f74c8c1@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jun 24, 2021 at 10:39:16AM +0300, Max Gurtovoy wrote:
> 
> On 6/24/2021 9:38 AM, Leon Romanovsky wrote:
> > On Thu, Jun 24, 2021 at 02:06:46AM +0300, Max Gurtovoy wrote:
> > > On 6/9/2021 2:05 PM, Leon Romanovsky wrote:
> > > > From: Avihai Horon <avihaih@nvidia.com>
> > > > 
> > > > Relaxed Ordering is a capability that can only benefit users that support
> > > > it. All kernel ULPs should support Relaxed Ordering, as they are designed
> > > > to read data only after observing the CQE and use the DMA API correctly.
> > > > 
> > > > Hence, implicitly enable Relaxed Ordering by default for kernel ULPs.
> > > > 
> > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > > ---
> > > > Changelog:
> > > > v2:
> > > >    * Dropped IB/core patch and set RO implicitly in mlx5 exactly like in
> > > >      eth side of mlx5 driver.
> > > > v1: https://lore.kernel.org/lkml/cover.1621505111.git.leonro@nvidia.com
> > > >    * Enabled by default RO in IB/core instead of changing all users
> > > > v0: https://lore.kernel.org/lkml/20210405052404.213889-1-leon@kernel.org
> > > > ---
> > > >    drivers/infiniband/hw/mlx5/mr.c | 10 ++++++----
> > > >    drivers/infiniband/hw/mlx5/wr.c |  5 ++++-
> > > >    2 files changed, 10 insertions(+), 5 deletions(-)
> > > > 
> > > > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > > > index 3363cde85b14..2182e76ae734 100644
> > > > --- a/drivers/infiniband/hw/mlx5/mr.c
> > > > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > > > @@ -69,6 +69,7 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> > > >    					  struct ib_pd *pd)
> > > >    {
> > > >    	struct mlx5_ib_dev *dev = to_mdev(pd->device);
> > > > +	bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
> > > >    	MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
> > > >    	MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
> > > > @@ -78,10 +79,10 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> > > >    	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
> > > >    		MLX5_SET(mkc, mkc, relaxed_ordering_write,
> > > > -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
> > > > +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
> > > >    	if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
> > > >    		MLX5_SET(mkc, mkc, relaxed_ordering_read,
> > > > -			 !!(acc & IB_ACCESS_RELAXED_ORDERING));
> > > > +			 acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled);
> > > Jason,
> > > 
> > > If it's still possible to add small change, it will be nice to avoid
> > > calculating "acc & IB_ACCESS_RELAXED_ORDERING && ro_pci_enabled" twice.
> > The patch is part of for-next now, so feel free to send followup patch.
> > 
> > Thanks
> > 
> > diff --git a/drivers/infiniband/hw/mlx5/mr.c b/drivers/infiniband/hw/mlx5/mr.c
> > index c1e70c99b70c..c4f246c90c4d 100644
> > --- a/drivers/infiniband/hw/mlx5/mr.c
> > +++ b/drivers/infiniband/hw/mlx5/mr.c
> > @@ -69,7 +69,8 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> >                                            struct ib_pd *pd)
> >   {
> >          struct mlx5_ib_dev *dev = to_mdev(pd->device);
> > -       bool ro_pci_enabled = pcie_relaxed_ordering_enabled(dev->mdev->pdev);
> > +       bool ro_pci_enabled = acc & IB_ACCESS_RELAXED_ORDERING &&
> > +                             pcie_relaxed_ordering_enabled(dev->mdev->pdev);
> > 
> >          MLX5_SET(mkc, mkc, a, !!(acc & IB_ACCESS_REMOTE_ATOMIC));
> >          MLX5_SET(mkc, mkc, rw, !!(acc & IB_ACCESS_REMOTE_WRITE));
> > @@ -78,11 +79,9 @@ static void set_mkc_access_pd_addr_fields(void *mkc, int acc, u64 start_addr,
> >          MLX5_SET(mkc, mkc, lr, 1);
> > 
> >          if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_write))
> > -               MLX5_SET(mkc, mkc, relaxed_ordering_write,
> > -                        (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
> > +               MLX5_SET(mkc, mkc, relaxed_ordering_write, ro_pci_enabled);
> >          if (MLX5_CAP_GEN(dev->mdev, relaxed_ordering_read))
> > -               MLX5_SET(mkc, mkc, relaxed_ordering_read,
> > -                        (acc & IB_ACCESS_RELAXED_ORDERING) && ro_pci_enabled);
> > +               MLX5_SET(mkc, mkc, relaxed_ordering_read, ro_pci_enabled);
> > 
> >          MLX5_SET(mkc, mkc, pd, to_mpd(pd)->pdn);
> >          MLX5_SET(mkc, mkc, qpn, 0xffffff);
> > (END)
> > 
> Yes this looks good.
> 
> Can you/Avihai create a patch from this ? or I'll do it ?

Feel free to send it directly.

Thanks

> 
> 
> > > 
