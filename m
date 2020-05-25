Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7401E129A
	for <lists+linux-rdma@lfdr.de>; Mon, 25 May 2020 18:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729513AbgEYQ1A (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 25 May 2020 12:27:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729338AbgEYQ1A (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 25 May 2020 12:27:00 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DFF4620723;
        Mon, 25 May 2020 16:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590424019;
        bh=JhQxqiI/zkpaOftLjLChbmYPvWSJmvwR+aaEvS4F78k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IvNNTrAZ74Efn5JWfSDcSJY+2E6yMV8e8gtkkS6G4i+xbHKNSQqlbvJNuZydBVC9Z
         OzT1XtwUY2Cxk3FDmlkAW8CYErS0K+RiVfbcg/9O6BnnctqvwNRSqrOM8afEhG9YqU
         f1otKmFErZK3n9tzOVOYbjSoKKztJWr2NWuHMd9s=
Date:   Mon, 25 May 2020 19:26:55 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@mellanox.com>, linux-rdma@vger.kernel.org,
        Potnuri Bharat Teja <bharat@chelsio.com>
Subject: Re: [PATCH rdma-next 09/14] RDMA: Add a dedicated QP resource
 tracker function
Message-ID: <20200525162655.GD10591@unreal>
References: <20200513095034.208385-1-leon@kernel.org>
 <20200513095034.208385-10-leon@kernel.org>
 <20200525143447.GA21596@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200525143447.GA21596@ziepe.ca>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, May 25, 2020 at 11:34:47AM -0300, Jason Gunthorpe wrote:
> On Wed, May 13, 2020 at 12:50:29PM +0300, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@mellanox.com>
> >
> > In order to avoid double multiplexing of the resource when it's QP,
> > add a dedicated callback function.
> >
> > Signed-off-by: Maor Gottlieb <maorg@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/core/device.c       | 1 +
> >  drivers/infiniband/core/nldev.c        | 2 +-
> >  drivers/infiniband/core/restrack.c     | 2 ++
> >  drivers/infiniband/hw/cxgb4/iw_cxgb4.h | 1 +
> >  drivers/infiniband/hw/cxgb4/restrack.c | 5 +----
> >  include/rdma/ib_verbs.h                | 1 +
> >  6 files changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index 1f9f44e62e49..23af3cc27ee1 100644
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2619,6 +2619,7 @@ void ib_set_device_ops(struct ib_device *dev, const struct ib_device_ops *ops)
> >  	SET_DEVICE_OP(dev_ops, fill_res_cq_entry);
> >  	SET_DEVICE_OP(dev_ops, fill_res_entry);
> >  	SET_DEVICE_OP(dev_ops, fill_res_mr_entry);
> > +	SET_DEVICE_OP(dev_ops, fill_res_qp_entry);
> >  	SET_DEVICE_OP(dev_ops, fill_stat_mr_entry);
> >  	SET_DEVICE_OP(dev_ops, get_dev_fw_str);
> >  	SET_DEVICE_OP(dev_ops, get_dma_mr);
> > diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
> > index 6207b68453a1..8c748888bf28 100644
> > +++ b/drivers/infiniband/core/nldev.c
> > @@ -499,7 +499,7 @@ static int fill_res_qp_entry(struct sk_buff *msg, bool has_cap_net_admin,
> >  	if (fill_res_name_pid(msg, res))
> >  		goto err;
> >
> > -	return dev->ops.fill_res_entry(msg, res);
> > +	return dev->ops.fill_res_qp_entry(msg, qp);
> >
> >  err:	return -EMSGSIZE;
> >  }
> > diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
> > index 031a4f94400e..33d7c0888753 100644
> > +++ b/drivers/infiniband/core/restrack.c
> > @@ -29,11 +29,13 @@ static int fill_res_dummy(struct sk_buff *msg,
> >
> >  FILL_DUMMY(mr);
> >  FILL_DUMMY(cq);
> > +FILL_DUMMY(qp);
>
> Lists of things should be sorted

I will fix.

>
> >  static const struct ib_device_ops restrack_dummy_ops = {
> >  	.fill_res_cq_entry = fill_res_cq,
> >  	.fill_res_entry = fill_res_dummy,
> >  	.fill_res_mr_entry = fill_res_mr,
> > +	.fill_res_qp_entry = fill_res_qp,
> >  	.fill_stat_mr_entry = fill_res_mr,
> >  };
>
> Here too
>
> I'm also not sure the FILL_DUMMY obfuscation is worthwhile for 3
> functions.

At the end, we removed a lot of duplicated code, despite adding code the
diffstat shows that we added not so much code after all.

17 files changed, 258 insertions(+), 201 deletions(-)

>
> > @@ -2571,6 +2571,7 @@ struct ib_device_ops {
> >  			      struct rdma_restrack_entry *entry);
> >  	int (*fill_res_mr_entry)(struct sk_buff *msg, struct ib_mr *ibmr);
> >  	int (*fill_res_cq_entry)(struct sk_buff *msg, struct ib_cq *ibcq);
> > +	int (*fill_res_qp_entry)(struct sk_buff *msg, struct ib_qp *ibqp);
>
> Sorted too

I will fix.

>
> Jason
