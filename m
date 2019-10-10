Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C7B26D25AE
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 11:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387915AbfJJJCH (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 05:02:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39324 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387769AbfJJJCG (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 05:02:06 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A81692067B;
        Thu, 10 Oct 2019 09:02:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570698126;
        bh=PqanS0Ex4WfpbIvH0UqnllduRamV7zs1Y7XoqF2SGaU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iQS33Vmun+fERymMCc2sXfStggIDcdwi1hHUG6SD00EEGJQ1Y9w62ALKHAt9jQrLx
         Gu6nxjaAE8Wzf2rhaKP9F+3uewz7ey+hD2SBclcMtyTdw1aw4hAhwIsA8FGzg6aeNI
         eBmerkBFF3tKGzhXs4PYvLLV7z+D03Qe1AN1b70g=
Date:   Thu, 10 Oct 2019 12:02:03 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v2 1/4] IB/mlx5: Introduce ODP diagnostic
 counters
Message-ID: <20191010090203.GJ5855@unreal>
References: <20191006155139.30632-1-leon@kernel.org>
 <20191006155139.30632-2-leon@kernel.org>
 <20191008195701.GE22714@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008195701.GE22714@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 08, 2019 at 07:57:05PM +0000, Jason Gunthorpe wrote:
> On Sun, Oct 06, 2019 at 06:51:36PM +0300, Leon Romanovsky wrote:
> > From: Erez Alfasi <ereza@mellanox.com>
> >
> > Introduce ODP diagnostic counters and count the following
> > per MR within IB/mlx5 driver:
> >  1) Page faults:
> > 	Total number of faulted pages.
> >  2) Page invalidations:
> > 	Total number of pages invalidated by the OS during all
> > 	invalidation events. The translations can be no longer
> > 	valid due to either non-present pages or mapping changes.
> >  3) Prefetched pages:
> > 	When prefetching a page, page fault is generated
> > 	in order to bring the page to the main memory.
> > 	The prefetched pages counter will be updated
> > 	during a page fault flow only if it was derived
> > 	from prefetching operation.
> >
> > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h |  4 ++++
> >  drivers/infiniband/hw/mlx5/odp.c     | 18 ++++++++++++++++++
> >  include/rdma/ib_verbs.h              |  6 ++++++
> >  3 files changed, 28 insertions(+)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/mlx5_ib.h b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > index bf30d53d94dc..5aae05ebf64b 100644
> > +++ b/drivers/infiniband/hw/mlx5/mlx5_ib.h
> > @@ -585,6 +585,9 @@ struct mlx5_ib_dm {
> >  					  IB_ACCESS_REMOTE_READ   |\
> >  					  IB_ZERO_BASED)
> >
> > +#define mlx5_update_odp_stats(mr, counter_name, value)		\
> > +	atomic64_add(value, &((mr)->odp_stats.counter_name))
> > +
> >  struct mlx5_ib_mr {
> >  	struct ib_mr		ibmr;
> >  	void			*descs;
> > @@ -622,6 +625,7 @@ struct mlx5_ib_mr {
> >  	wait_queue_head_t       q_leaf_free;
> >  	struct mlx5_async_work  cb_work;
> >  	atomic_t		num_pending_prefetch;
> > +	struct ib_odp_counters	odp_stats;
> >  };
> >
> >  static inline bool is_odp_mr(struct mlx5_ib_mr *mr)
> > diff --git a/drivers/infiniband/hw/mlx5/odp.c b/drivers/infiniband/hw/mlx5/odp.c
> > index 95cf0249b015..966783bfb557 100644
> > +++ b/drivers/infiniband/hw/mlx5/odp.c
> > @@ -261,6 +261,10 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
> >  				blk_start_idx = idx;
> >  				in_block = 1;
> >  			}
> > +
> > +			/* Count page invalidations */
> > +			mlx5_update_odp_stats(mr, invalidations,
> > +					      (idx - blk_start_idx + 1));
>
> I feel like these should be batched and the atomic done once at the
> end of the routine..

We can, but does it worth it?

>
> >  		} else {
> >  			u64 umr_offset = idx & umr_block_mask;
> >
> > @@ -287,6 +291,7 @@ void mlx5_ib_invalidate_range(struct ib_umem_odp *umem_odp, unsigned long start,
> >
> >  	ib_umem_odp_unmap_dma_pages(umem_odp, start, end);
> >
> > +
> >  	if (unlikely(!umem_odp->npages && mr->parent &&
> >  		     !umem_odp->dying)) {
> >  		WRITE_ONCE(umem_odp->dying, 1);
> > @@ -801,6 +806,19 @@ static int pagefault_single_data_segment(struct mlx5_ib_dev *dev,
> >  		if (ret < 0)
> >  			goto srcu_unlock;
> >
> > +		/*
> > +		 * When prefetching a page, page fault is generated
> > +		 * in order to bring the page to the main memory.
> > +		 * In the current flow, page faults are being counted.
> > +		 * Prefetched pages counter will be updated as well
> > +		 * only if the current page fault flow was derived
> > +		 * from prefetching flow.
> > +		 */
> > +		mlx5_update_odp_stats(mr, faults, ret);
> > +
> > +		if (prefetch)
> > +			mlx5_update_odp_stats(mr, prefetched, ret);
>
> Hm, I'm about to post a series that eliminates 'prefetch' here..

Jason,

For various reasons we are delaying this series for months already.
Let's drop "prefetch" counter for now and merge everything without
it.

>
> This is also not quite right for prefetch as we are doing a form of
> prefetching in the mlx5_ib_mr_rdma_pfault_handler() too, although it
> is less clear how to count those. Maybe this should be split to SQ/RQ
> faults?

mlx5_ib_mr_rdma_pfault_handler() calls to pagefault_single_data_segment()
without MLX5_PF_FLAGS_PREFETCH, so I'm unsure that this counter should
count mlx5_ib_mr_rdma_pfault_handler() pagefaults.

However the idea to separate SQ/RQ for everything sounds appealing.

Thanks

>
> Jason
