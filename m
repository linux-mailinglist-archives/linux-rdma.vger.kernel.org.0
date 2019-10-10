Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93B4D25E4
	for <lists+linux-rdma@lfdr.de>; Thu, 10 Oct 2019 11:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388387AbfJJJDD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 10 Oct 2019 05:03:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:39948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387799AbfJJJDC (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 10 Oct 2019 05:03:02 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CB57D2190F;
        Thu, 10 Oct 2019 09:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570698182;
        bh=iBWylZV4s1mHX5S95KeH+Xo4wwtrt2IgNiuLobs/Idw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LO7iTcUkpmtNBog809AER8WW6bPARx29sOi6ePoVjuuZiycYNoCjPcTTi1Ji+JsCJ
         2yZNwI77Us6jhKMOlsd/02pqIhkqayWsPQYdB5aNQ5roSMfbHlVC6EfZ4ynfHbTVaF
         JnJF4EdQu/seJ5i8JGe1jYYCkfFsF5M5widkA+mw=
Date:   Thu, 10 Oct 2019 12:02:59 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Erez Alfasi <ereza@mellanox.com>
Subject: Re: [PATCH rdma-next v2 4/4] RDMA/nldev: Provide MR statistics
Message-ID: <20191010090259.GK5855@unreal>
References: <20191006155139.30632-1-leon@kernel.org>
 <20191006155139.30632-5-leon@kernel.org>
 <20191009144012.GJ22714@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009144012.GJ22714@mellanox.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Oct 09, 2019 at 02:40:16PM +0000, Jason Gunthorpe wrote:
> On Sun, Oct 06, 2019 at 06:51:39PM +0300, Leon Romanovsky wrote:
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
> >  drivers/infiniband/core/device.c      |  1 +
> >  drivers/infiniband/core/nldev.c       | 41 ++++++++++++++++++++++---
> >  drivers/infiniband/hw/mlx5/main.c     |  2 ++
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h  |  2 ++
> >  drivers/infiniband/hw/mlx5/restrack.c | 44 +++++++++++++++++++++++++++
> >  include/rdma/ib_verbs.h               |  7 +++++
> >  include/rdma/restrack.h               |  3 ++
> >  7 files changed, 96 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index a667636f74bf..2e53aa25f0c7 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2606,6 +2606,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, drain_sq);
> >  	SET_DEVICE_OP(dev_ops, enable_driver);
> >  	SET_DEVICE_OP(dev_ops, fill_res_entry);
> > +	SET_DEVICE_OP(dev_ops, fill_stat_entry);
> >  	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
> >  	SET_DEVICE_OP(dev_ops, get_dma_mr);
> >  	SET_DEVICE_OP(dev_ops, get_hw_stats);
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index 6114465959e1..1d9d89fd9ce9 100644
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -454,6 +454,14 @@ static bool fill_res_entry(struct ib_device *dev, struct sk_buff *msg,
> >  	return dev->ops.fill_res_entry(msg, res);
> >  }
> >
> > +static bool fill_stat_entry(struct ib_device *dev, struct sk_buff *msg,
> > +			    struct rdma_restrack_entry *res)
> > +{
> > +	if (!dev->ops.fill_stat_entry)
> > +		return false;
> > +	return dev->ops.fill_stat_entry(msg, res);
> > +}
>
> Why do we need this function called in only one place?

Be consistent with other fill_... functions.

>
> Jason
