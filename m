Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 22E3BAD641
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Sep 2019 12:00:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729386AbfIIKAN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Sep 2019 06:00:13 -0400
Received: from mail.kernel.org ([198.145.29.99]:39612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729331AbfIIKAN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 9 Sep 2019 06:00:13 -0400
Received: from localhost (unknown [148.69.85.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E71CD2086D;
        Mon,  9 Sep 2019 10:00:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568023211;
        bh=ufHXaGgkjrnR3cDSJFUXOTlHYPFvFP3VNj4glNENtPM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LHFdyf80YPxaWGsNyRsjsrdliOHXxSAw/8J7p6d0lhsr9lfWgJgX04oXWE0lctqOe
         WQaL2DuOVAJaRORSMh2ImSmrOLL9wGwggmv3EoXJPsCyc7Fkx3qA2r8YzJQSYmF39d
         2vlPEd0SGv6q07ZtAympsZPGDR3WRbzva4qou1ow=
Date:   Mon, 9 Sep 2019 13:00:02 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v1 3/4] RDMA/nldev: Provide MR statistics
Message-ID: <20190909100002.GC6601@unreal>
References: <20190830081612.2611-1-leon@kernel.org>
 <20190830081612.2611-4-leon@kernel.org>
 <20190909085148.GD2843@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190909085148.GD2843@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Sep 09, 2019 at 08:51:50AM +0000, Jason Gunthorpe wrote:
> On Fri, Aug 30, 2019 at 11:16:11AM +0300, Leon Romanovsky wrote:
> > From: Erez Alfasi <ereza@mellanox.com>
> >
> > Add RDMA nldev netlink interface for dumping MR
> > statistics information.
> >
> > Output example:
> > ereza@dev~$: ./ibv_rc_pingpong -o -P -s 500000000
> >   local address:  LID 0x0001, QPN 0x00008a, PSN 0xf81096, GID ::
> >
> > ereza@dev~$: rdma stat show mr
> > dev mlx5_0 mrn 2 page_faults 122071 page_invalidations 0
> > prefetched_pages 122071
> >
> > Signed-off-by: Erez Alfasi <ereza@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/device.c  |  1 +
> >  drivers/infiniband/core/nldev.c   | 54 +++++++++++++++++++++++++++++--
> >  drivers/infiniband/hw/mlx5/main.c | 16 +++++++++
> >  include/rdma/ib_verbs.h           |  9 ++++++
> >  4 files changed, 78 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 99c4a55545cf..34a9e37c5c61 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2610,6 +2610,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, get_dma_mr);
> >  	SET_DEVICE_OP(dev_ops, get_hw_stats);
> >  	SET_DEVICE_OP(dev_ops, get_link_layer);
> > +	SET_DEVICE_OP(dev_ops, fill_odp_stats);
> >  	SET_DEVICE_OP(dev_ops, get_netdev);
> >  	SET_DEVICE_OP(dev_ops, get_port_immutable);
> >  	SET_DEVICE_OP(dev_ops, get_vector_affinity);
>
> I'm now curious what motivated placing the line here, apparently
> randomly in a sorted list?

desire to be different and express yourself?

>
> > +static int fill_stat_mr_entry(struct sk_buff *msg, bool has_cap_net_admin,
> > +			      struct rdma_restrack_entry *res, uint32_t port)
> > +{
> > +	struct ib_mr *mr = container_of(res, struct ib_mr, res);
> > +	struct ib_device *dev = mr->pd->device;
> > +	struct ib_odp_counters odp_stats;
> > +	struct nlattr *table_attr;
> > +
> > +	if (nla_put_u32(msg, RDMA_NLDEV_ATTR_RES_MRN, res->id))
> > +		goto err;
> > +
> > +	if (!dev->ops.fill_odp_stats)
> > +		return 0;
> > +
> > +	if (!dev->ops.fill_odp_stats(mr, &odp_stats))
> > +		return 0;
>
> As Parav says this seems to be wrong for !ODP MRs. Can we even detect
> !ODP at this point?

ODP is decided on UMEM level which you said should be driver property
and it means that driver should distinguish between odp/not-odp.

>
> > +
> > +	table_attr = nla_nest_start(msg,
> > +				    RDMA_NLDEV_ATTR_STAT_HWCOUNTERS);
> > +
> > +	if (!table_attr)
> > +		return -EMSGSIZE;
> > +
> > +	if (fill_stat_hwcounter_entry(msg, "page_faults",
> > +				      (u64)atomic64_read(&odp_stats.faults)))
>
> Why the cast?

atomic64_read returns s64 and not u64, I didn't see need to investigate
if s64 == u64 in all architectures.
>
>
> > +static bool mlx5_ib_fill_odp_stats(struct ib_mr *ibmr,
> > +				   struct ib_odp_counters *cnt)
> > +{
> > +	struct mlx5_ib_mr *mr = to_mmr(ibmr);
> > +
> > +	if (!is_odp_mr(mr))
> > +		return false;
> > +
> > +	memcpy(cnt, &to_ib_umem_odp(mr->umem)->odp_stats,
> > +	       sizeof(struct ib_odp_counters));
>
> Can't memcpy atomic64, have to open code a copy using atomic64_read.

Right

>
> > @@ -6316,6 +6331,7 @@ static const struct ib_device_ops mlx5_ib_dev_ops = {
> >  	.get_dev_fw_str = get_dev_fw_str,
> >  	.get_dma_mr = mlx5_ib_get_dma_mr,
> >  	.get_link_layer = mlx5_ib_port_link_layer,
> > +	.fill_odp_stats = mlx5_ib_fill_odp_stats,
>
> Randomly again..
>
> Jason
