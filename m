Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 973D9981B5
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728836AbfHURrP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:47:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:49478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728835AbfHURrP (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 13:47:15 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A99F22D6D;
        Wed, 21 Aug 2019 17:47:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566409635;
        bh=GB6KMp+/IXydWbPc31Hrq/VfNkL6mINjttjjuk63BFc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VhBlvu0j6ps7G3DfGX3ZpsA1rFc1LIneB9SXGKhRsVantd+Ak5x234Wlq0SUridzu
         Ya5MdAiedSNUcJhtqio4z3H/3kEYxKndqfONl+Bim/+aSLfjTh6P6G1PakKqIvRkCp
         cyiPD1dk6AfHzyaMHaBAdUGQRhke42YiRtlc12ZE=
Date:   Wed, 21 Aug 2019 20:47:13 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next 02/12] RDMA/odp: Iterate over the whole rbtree
 directly
Message-ID: <20190821174713.GB29433@mtr-leonro.mtl.com>
References: <20190819111710.18440-1-leon@kernel.org>
 <20190819111710.18440-3-leon@kernel.org>
 <20190821171502.GA23022@ziepe.ca>
 <20190821172735.GC27741@mtr-leonro.mtl.com>
 <20190821173551.GF8653@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821173551.GF8653@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 02:35:52PM -0300, Jason Gunthorpe wrote:
> On Wed, Aug 21, 2019 at 08:27:35PM +0300, Leon Romanovsky wrote:
> > On Wed, Aug 21, 2019 at 02:15:02PM -0300, Jason Gunthorpe wrote:
> > > On Mon, Aug 19, 2019 at 02:17:00PM +0300, Leon Romanovsky wrote:
> > > > From: Jason Gunthorpe <jgg@mellanox.com>
> > > >
> > > > Instead of intersecting a full interval, just iterate over every element
> > > > directly. This is faster and clearer.
> > > >
> > > > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> > > >  drivers/infiniband/core/umem_odp.c | 51 ++++++++++++++++--------------
> > > >  drivers/infiniband/hw/mlx5/odp.c   | 41 +++++++++++-------------
> > > >  2 files changed, 47 insertions(+), 45 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> > > > index 8358eb8e3a26..b9bebef00a33 100644
> > > > +++ b/drivers/infiniband/core/umem_odp.c
> > > > @@ -72,35 +72,41 @@ static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
> > > >  	mutex_unlock(&umem_odp->umem_mutex);
> > > >  }
> > > >
> > > > -static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
> > > > -					       u64 start, u64 end, void *cookie)
> > > > -{
> > > > -	/*
> > > > -	 * Increase the number of notifiers running, to
> > > > -	 * prevent any further fault handling on this MR.
> > > > -	 */
> > > > -	ib_umem_notifier_start_account(umem_odp);
> > > > -	umem_odp->dying = 1;
> > >
> > > This patch was not applied on top of the commit noted in the cover
> > > letter
> >
> > Strange: git log --oneline on my submission queue.
> > ....
> > 39c10977a728 RDMA/odp: Iterate over the whole rbtree directly
> > 779c1205d0e0 RDMA/odp: Use the common interval tree library instead of generic
> > 25705cc22617 RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
>
> But that patch has to apply on top of rc, which has the other commit
> that deleted dying

Interesting

>
> Jason
