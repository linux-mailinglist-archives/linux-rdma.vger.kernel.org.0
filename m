Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC589261C6D
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 21:20:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731859AbgIHTTy (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 15:19:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:52114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730987AbgIHQCs (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 12:02:48 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B088B21D95;
        Tue,  8 Sep 2020 14:26:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599575215;
        bh=jVVOOCkUC8wOayrnwocaRMRbu0RREJrejN5buzvDNSM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J2D4L41/AFE7Tp/qX5B4qaoIZvfwqo38WU0WQUJIdjj7ornwe5s9PSXtVD7OwjCf+
         +GwdnWJyRu1AE0caqzywOhSnWO92soaHJl4zN3m1j1nkzUotpwaHSyeynRJbjnluVV
         3bFbzMDK6smstTjkkrPh3r8Z/7vJwnxAculLk8Sg=
Date:   Tue, 8 Sep 2020 17:26:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Aharon Landau <aharonl@mellanox.com>,
        Adit Ranadive <aditr@vmware.com>,
        Ariel Elior <aelior@marvell.com>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Devesh Sharma <devesh.sharma@broadcom.com>,
        linux-rdma@vger.kernel.org,
        Michael Guralnik <michaelgur@nvidia.com>,
        Michal Kalderon <mkalderon@marvell.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Naresh Kumar PBS <nareshkumar.pbs@broadcom.com>,
        Selvin Xavier <selvin.xavier@broadcom.com>,
        Somnath Kotur <somnath.kotur@broadcom.com>,
        Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>,
        VMware PV-Drivers <pv-drivers@vmware.com>
Subject: Re: [PATCH rdma-next v1 3/3] RDMA: Fix link active_speed size
Message-ID: <20200908142651.GE421756@unreal>
References: <20200902074503.743310-1-leon@kernel.org>
 <20200902074503.743310-4-leon@kernel.org>
 <20200908141924.GG9166@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908141924.GG9166@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 11:19:24AM -0300, Jason Gunthorpe wrote:
> On Wed, Sep 02, 2020 at 10:45:03AM +0300, Leon Romanovsky wrote:
> > From: Aharon Landau <aharonl@mellanox.com>
> >
> > According to the IB spec active_speed size should be u16 and not u8 as
> > before. Changing it to allow further extensions in offered speeds.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> >  drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
> >  drivers/infiniband/core/verbs.c                   | 2 +-
> >  drivers/infiniband/hw/bnxt_re/bnxt_re.h           | 2 +-
> >  drivers/infiniband/hw/hfi1/verbs.c                | 2 +-
> >  drivers/infiniband/hw/mlx5/main.c                 | 8 ++------
> >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       | 2 +-
> >  drivers/infiniband/hw/qedr/verbs.c                | 2 +-
> >  drivers/infiniband/hw/qib/qib.h                   | 6 +++---
> >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 2 +-
> >  include/rdma/ib_verbs.h                           | 4 ++--
> >  10 files changed, 15 insertions(+), 18 deletions(-)
> >
> > diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> > index 75df2094a010..7b03446b6936 100644
> > +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> > @@ -165,7 +165,8 @@ void copy_port_attr_to_resp(struct ib_port_attr *attr,
> >  	resp->subnet_timeout = attr->subnet_timeout;
> >  	resp->init_type_reply = attr->init_type_reply;
> >  	resp->active_width = attr->active_width;
> > -	resp->active_speed = attr->active_speed;
> > +	WARN_ON(attr->active_speed & ~0xFF);
>
> ?? This doesn't seem like a warn on situation..

Why? We are returning u8 to the user, so need to catch overflow.

>
> > @@ -1307,7 +1303,7 @@ static int mlx5_query_hca_port(struct ib_device *ibdev, u8 port,
> >  		props->port_cap_flags2 = rep->cap_mask2;
> >
> >  	err = mlx5_query_ib_port_oper(mdev, &ib_link_width_oper,
> > -				      (u16 *)&props->active_speed, port);
> > +				      &props->active_speed, port);
>
> This hunk should be in the earlier patch

Sorry about that.

>
> Jason
