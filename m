Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7EEBF9813A
	for <lists+linux-rdma@lfdr.de>; Wed, 21 Aug 2019 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728386AbfHUR1i (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 21 Aug 2019 13:27:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:42386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727266AbfHUR1h (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 21 Aug 2019 13:27:37 -0400
Received: from localhost (wsip-184-188-36-2.sd.sd.cox.net [184.188.36.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 65FE222D6D;
        Wed, 21 Aug 2019 17:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566408456;
        bh=2P2QORCP5BUmFfqq7uz+PeEQA+dg8frNWDlKIpnqufI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bXhKyyTeJnrU+6LjP1lZfiru59zSfLomw2Dht4v9LVaUs2OdLZY6PW+IjfqJSc8Y2
         OLe1nxZqFbfS3SJ/7o7yNAa+RuzND+VtADi46RrYajquYfNZkoK3A1ykfy82UWX719
         9/NlFXXP1yM8pTZa2blKLhMFqRqigZENEiXMiTRI=
Date:   Wed, 21 Aug 2019 20:27:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Guy Levi <guyle@mellanox.com>, Moni Shoua <monis@mellanox.com>
Subject: Re: [PATCH rdma-next 02/12] RDMA/odp: Iterate over the whole rbtree
 directly
Message-ID: <20190821172735.GC27741@mtr-leonro.mtl.com>
References: <20190819111710.18440-1-leon@kernel.org>
 <20190819111710.18440-3-leon@kernel.org>
 <20190821171502.GA23022@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821171502.GA23022@ziepe.ca>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Aug 21, 2019 at 02:15:02PM -0300, Jason Gunthorpe wrote:
> On Mon, Aug 19, 2019 at 02:17:00PM +0300, Leon Romanovsky wrote:
> > From: Jason Gunthorpe <jgg@mellanox.com>
> >
> > Instead of intersecting a full interval, just iterate over every element
> > directly. This is faster and clearer.
> >
> > Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/umem_odp.c | 51 ++++++++++++++++--------------
> >  drivers/infiniband/hw/mlx5/odp.c   | 41 +++++++++++-------------
> >  2 files changed, 47 insertions(+), 45 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
> > index 8358eb8e3a26..b9bebef00a33 100644
> > +++ b/drivers/infiniband/core/umem_odp.c
> > @@ -72,35 +72,41 @@ static void ib_umem_notifier_end_account(struct ib_umem_odp *umem_odp)
> >  	mutex_unlock(&umem_odp->umem_mutex);
> >  }
> >
> > -static int ib_umem_notifier_release_trampoline(struct ib_umem_odp *umem_odp,
> > -					       u64 start, u64 end, void *cookie)
> > -{
> > -	/*
> > -	 * Increase the number of notifiers running, to
> > -	 * prevent any further fault handling on this MR.
> > -	 */
> > -	ib_umem_notifier_start_account(umem_odp);
> > -	umem_odp->dying = 1;
>
> This patch was not applied on top of the commit noted in the cover
> letter

Strange: git log --oneline on my submission queue.
....
39c10977a728 RDMA/odp: Iterate over the whole rbtree directly
779c1205d0e0 RDMA/odp: Use the common interval tree library instead of generic
25705cc22617 RDMA/mlx5: Fix MR npages calculation for IB_ACCESS_HUGETLB
---


>
> > -	/* Make sure that the fact the umem is dying is out before we release
> > -	 * all pending page faults. */
> > -	smp_wmb();
> > -	complete_all(&umem_odp->notifier_completion);
> > -	umem_odp->umem.context->invalidate_range(
> > -		umem_odp, ib_umem_start(umem_odp), ib_umem_end(umem_odp));
> > -	return 0;
> > -}
> > -
> >  static void ib_umem_notifier_release(struct mmu_notifier *mn,
> >  				     struct mm_struct *mm)
> >  {
> >  	struct ib_ucontext_per_mm *per_mm =
> >  		container_of(mn, struct ib_ucontext_per_mm, mn);
> > +	struct rb_node *node;
> >
> >  	down_read(&per_mm->umem_rwsem);
> > -	if (per_mm->active)
> > -		rbt_ib_umem_for_each_in_range(
> > -			&per_mm->umem_tree, 0, ULLONG_MAX,
> > -			ib_umem_notifier_release_trampoline, true, NULL);
> > +	if (!per_mm->active)
> > +		goto out;
> > +
> > +	for (node = rb_first_cached(&per_mm->umem_tree); node;
> > +	     node = rb_next(node)) {
> > +		struct ib_umem_odp *umem_odp =
> > +			rb_entry(node, struct ib_umem_odp, interval_tree.rb);
> > +
> > +		/*
> > +		 * Increase the number of notifiers running, to prevent any
> > +		 * further fault handling on this MR.
> > +		 */
> > +		ib_umem_notifier_start_account(umem_odp);
> > +
> > +		umem_odp->dying = 1;
>
> So this ends up as a 'rebasing error'
>
> I fixed it
>
> Jason
