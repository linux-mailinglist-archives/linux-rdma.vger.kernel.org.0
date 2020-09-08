Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0C5D26202A
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Sep 2020 22:10:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730437AbgIHUKK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Sep 2020 16:10:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:52606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730256AbgIHPQT (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Sep 2020 11:16:19 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C7CA020738;
        Tue,  8 Sep 2020 14:42:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599576130;
        bh=lfoUPPR2gqsJdqMiK482qM/kOQuzCSYDs5/hEZR9tfw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rffg2CMusAGHcc4AXnAglgwcpMXazNXrltouag4/eZvxjUTu7kjYGVo4pB0GdPI9q
         z0U05uH4Axfgo3AzXzEyWRqDtOIwxAC+JahnNWowv1xKpPBwvxDetznSMPLTuRdzlC
         rCTlUtYY1SdVGeqcooRmcQscYOlOUagBjdV7hJqI=
Date:   Tue, 8 Sep 2020 17:42:05 +0300
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
Message-ID: <20200908144205.GF421756@unreal>
References: <20200902074503.743310-1-leon@kernel.org>
 <20200902074503.743310-4-leon@kernel.org>
 <20200908141924.GG9166@nvidia.com>
 <20200908142651.GE421756@unreal>
 <20200908142756.GH9166@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200908142756.GH9166@nvidia.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Sep 08, 2020 at 11:27:56AM -0300, Jason Gunthorpe wrote:
> On Tue, Sep 08, 2020 at 05:26:51PM +0300, Leon Romanovsky wrote:
> > On Tue, Sep 08, 2020 at 11:19:24AM -0300, Jason Gunthorpe wrote:
> > > On Wed, Sep 02, 2020 at 10:45:03AM +0300, Leon Romanovsky wrote:
> > > > From: Aharon Landau <aharonl@mellanox.com>
> > > >
> > > > According to the IB spec active_speed size should be u16 and not u8 as
> > > > before. Changing it to allow further extensions in offered speeds.
> > > >
> > > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > > Signed-off-by: Aharon Landau <aharonl@mellanox.com>
> > > > Reviewed-by: Michael Guralnik <michaelgur@nvidia.com>
> > > > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > > >  drivers/infiniband/core/uverbs_std_types_device.c | 3 ++-
> > > >  drivers/infiniband/core/verbs.c                   | 2 +-
> > > >  drivers/infiniband/hw/bnxt_re/bnxt_re.h           | 2 +-
> > > >  drivers/infiniband/hw/hfi1/verbs.c                | 2 +-
> > > >  drivers/infiniband/hw/mlx5/main.c                 | 8 ++------
> > > >  drivers/infiniband/hw/ocrdma/ocrdma_verbs.c       | 2 +-
> > > >  drivers/infiniband/hw/qedr/verbs.c                | 2 +-
> > > >  drivers/infiniband/hw/qib/qib.h                   | 6 +++---
> > > >  drivers/infiniband/hw/vmw_pvrdma/pvrdma_verbs.h   | 2 +-
> > > >  include/rdma/ib_verbs.h                           | 4 ++--
> > > >  10 files changed, 15 insertions(+), 18 deletions(-)
> > > >
> > > > diff --git a/drivers/infiniband/core/uverbs_std_types_device.c b/drivers/infiniband/core/uverbs_std_types_device.c
> > > > index 75df2094a010..7b03446b6936 100644
> > > > +++ b/drivers/infiniband/core/uverbs_std_types_device.c
> > > > @@ -165,7 +165,8 @@ void copy_port_attr_to_resp(struct ib_port_attr *attr,
> > > >  	resp->subnet_timeout = attr->subnet_timeout;
> > > >  	resp->init_type_reply = attr->init_type_reply;
> > > >  	resp->active_width = attr->active_width;
> > > > -	resp->active_speed = attr->active_speed;
> > > > +	WARN_ON(attr->active_speed & ~0xFF);
> > >
> > > ?? This doesn't seem like a warn on situation..
> >
> > Why? We are returning u8 to the user, so need to catch overflow.
>
> We need to have actual backwards compat here, not just throw a warning
> at the syscall boundary

We don't have fallback and don't have speed that crosses u8 limit yet.
This WARN_ON() is needed to ensure that we properly extend
ib_port_speed.

>
> Why can't it just be truncated?

The coming IBTA will have extension in that area.

>
> Jason
