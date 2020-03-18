Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 213F5189C97
	for <lists+linux-rdma@lfdr.de>; Wed, 18 Mar 2020 14:08:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbgCRNIs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 09:08:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:56778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgCRNIs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 18 Mar 2020 09:08:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0060920724;
        Wed, 18 Mar 2020 13:08:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584536927;
        bh=8sPTwl/Hw5a2ZwVfk/OTdq2VuD+Hcl+DLLmxfs5oV+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EIHBbTIQ1OBBa5BDzmFAihP6bS3o+MYG4GWK7tiZxIOtSsBPuT8N85FyZO8JFcBSv
         NXfa408qglVsyDiFu0Ytf/O9kYsiHk+JFT65++hQHWGCuxyCJqgZr+tlfBJ8JB7LPT
         OVVCaWEk5LEbCM7GlwiK1vCNVMZ78j/4rspAWO5Y=
Date:   Wed, 18 Mar 2020 15:08:44 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@mellanox.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@mellanox.com>
Subject: Re: [PATCH rdma-next 3/4] IB/mlx5: Extend QP creation to get uar
 page index from user space
Message-ID: <20200318130844.GX3351@unreal>
References: <20200318124329.52111-1-leon@kernel.org>
 <20200318124329.52111-4-leon@kernel.org>
 <20200318130514.GJ13183@mellanox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200318130514.GJ13183@mellanox.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Mar 18, 2020 at 10:05:14AM -0300, Jason Gunthorpe wrote:
> On Wed, Mar 18, 2020 at 02:43:28PM +0200, Leon Romanovsky wrote:
> > From: Yishai Hadas <yishaih@mellanox.com>
> >
> > Extend QP creation to get uar page index from user space, this mode can
> > be used with the UAR dynamic mode APIs to allocate/destroy a UAR object.
> >
> > As part of enabling this option blocked the weird/un-supported cross
> > channel option which uses index 0 hard-coded.
> >
> > This QP flag wasn't exposed to user space as part of any formal upstream
> > release, the dynamic option can allow having valid UAR page index
> > instead.
> >
> > Signed-off-by: Yishai Hadas <yishaih@mellanox.com>
> > Reviewed-by: Michael Guralnik <michaelgur@mellanox.com>
> > Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
> >  drivers/infiniband/hw/mlx5/qp.c | 27 +++++++++++++++++----------
> >  include/uapi/rdma/mlx5-abi.h    |  1 +
> >  2 files changed, 18 insertions(+), 10 deletions(-)
> >
> > diff --git a/drivers/infiniband/hw/mlx5/qp.c b/drivers/infiniband/hw/mlx5/qp.c
> > index 88db580f7272..380ba3321851 100644
> > +++ b/drivers/infiniband/hw/mlx5/qp.c
> > @@ -919,6 +919,7 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
> >  	void *qpc;
> >  	int err;
> >  	u16 uid;
> > +	u32 uar_flags;
> >
> >  	err = ib_copy_from_udata(&ucmd, udata, sizeof(ucmd));
> >  	if (err) {
> > @@ -928,24 +929,29 @@ static int create_user_qp(struct mlx5_ib_dev *dev, struct ib_pd *pd,
> >
> >  	context = rdma_udata_to_drv_context(udata, struct mlx5_ib_ucontext,
> >  					    ibucontext);
> > -	if (ucmd.flags & MLX5_QP_FLAG_BFREG_INDEX) {
> > +	uar_flags = ucmd.flags & (MLX5_QP_FLAG_UAR_PAGE_INDEX |
> > +				  MLX5_QP_FLAG_BFREG_INDEX);
> > +	switch (uar_flags) {
>
> Do we really need this temporary uar_flags?

I thinks that it is more clear, this is why I used temp variable.

Thanks

>
> Jason
