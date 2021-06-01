Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3118397245
	for <lists+linux-rdma@lfdr.de>; Tue,  1 Jun 2021 13:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230288AbhFAL1C (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 1 Jun 2021 07:27:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:48614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230308AbhFAL1C (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 1 Jun 2021 07:27:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E91661057;
        Tue,  1 Jun 2021 11:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622546721;
        bh=Apc7cIwA6o9RRTjY1tleYLZhnwZrTpXYpKFK3+OCUs8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MA+bYTlO2sOgsTmNb8JuafDupq5h83nvxva2TA259b3kK7Jl9DlqPMa99yMu2p09e
         8zIcCBmCIlZtH/kWPD+FaJzyjFS/1zB8Hr37s3fd/BtJUFN5i4v3D8FzYZyrwfJmEP
         BT1iHa6ld+geZxn+cbvx14WNA4okyb4xA2p4s9fdgdMTYwpRL9kVG11kxtz0BduDr5
         27kbzwMqhvQ45RFPBdKZhhNLofxfJcXHrRfswGAvNmb33osrGNf8CzK0CF8YMn3r8K
         lnhn2ooOr91yst7M6y3bcn1B2xYg3xH//Eqz3DgfSlFQLwtaOViX/bYypqiiUME6GT
         3zvvmhtDNg97Q==
Date:   Tue, 1 Jun 2021 14:25:17 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Devesh Sharma <devesh.sharma@broadcom.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: [for-next 1/2] RDMA/bnxt_re: Enable global atomic ops if
 platform supports
Message-ID: <YLYZHSJLdpMEtkhz@unreal>
References: <20210517132522.774762-1-devesh.sharma@broadcom.com>
 <20210517132522.774762-2-devesh.sharma@broadcom.com>
 <YKYUyPOfeER2FVGD@unreal>
 <CANjDDBh+GOvpLMEDHToZqVf3OfKOTqjg8bDW5vvVs1_dc5bgvg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANjDDBh+GOvpLMEDHToZqVf3OfKOTqjg8bDW5vvVs1_dc5bgvg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, May 21, 2021 at 06:20:35PM +0530, Devesh Sharma wrote:
> On Thu, May 20, 2021 at 1:20 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Mon, May 17, 2021 at 06:55:21PM +0530, Devesh Sharma wrote:
> > > Enabling Atomic operations for Gen P5 devices if the underlying
> > > platform supports global atomic ops.
> > >
> > > Fixes:7ff662b76167 ("Disable atomic capability on bnxt_re adapters")
> > > Signed-off-by: Devesh Sharma <devesh.sharma@broadcom.com>
> > > ---
> > >  drivers/infiniband/hw/bnxt_re/ib_verbs.c  |  4 ++++
> > >  drivers/infiniband/hw/bnxt_re/main.c      |  4 ++++
> > >  drivers/infiniband/hw/bnxt_re/qplib_res.c | 15 +++++++++++++++
> > >  drivers/infiniband/hw/bnxt_re/qplib_res.h |  1 +
> > >  drivers/infiniband/hw/bnxt_re/qplib_sp.c  | 13 ++++++++++++-
> > >  drivers/infiniband/hw/bnxt_re/qplib_sp.h  |  2 --
> > >  6 files changed, 36 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/ib_verbs.c b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > index 2efaa80bfbd2..8194ac52a484 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/ib_verbs.c
> > > @@ -163,6 +163,10 @@ int bnxt_re_query_device(struct ib_device *ibdev,
> > >       ib_attr->max_qp_init_rd_atom = dev_attr->max_qp_init_rd_atom;
> > >       ib_attr->atomic_cap = IB_ATOMIC_NONE;
> > >       ib_attr->masked_atomic_cap = IB_ATOMIC_NONE;
> > > +     if (dev_attr->is_atomic) {
> > > +             ib_attr->atomic_cap = IB_ATOMIC_GLOB;
> > > +             ib_attr->masked_atomic_cap = IB_ATOMIC_GLOB;
> > > +     }
> > >
> > >       ib_attr->max_ee_rd_atom = 0;
> > >       ib_attr->max_res_rd_atom = 0;
> > > diff --git a/drivers/infiniband/hw/bnxt_re/main.c b/drivers/infiniband/hw/bnxt_re/main.c
> > > index 8bfbf0231a9e..e91e987b7861 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/main.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/main.c
> > > @@ -128,6 +128,10 @@ static int bnxt_re_setup_chip_ctx(struct bnxt_re_dev *rdev, u8 wqe_mode)
> > >       rdev->rcfw.res = &rdev->qplib_res;
> > >
> > >       bnxt_re_set_drv_mode(rdev, wqe_mode);
> > > +     if (bnxt_qplib_enable_atomic_ops_to_root(en_dev->pdev))
> > > +             ibdev_info(&rdev->ibdev,
> > > +                        "platform doesn't support global atomics.");
> > > +
> > >       return 0;
> > >  }
> > >
> > > diff --git a/drivers/infiniband/hw/bnxt_re/qplib_res.c b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > > index 3ca47004b752..d2efb295e0f6 100644
> > > --- a/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > > +++ b/drivers/infiniband/hw/bnxt_re/qplib_res.c
> > > @@ -959,3 +959,18 @@ int bnxt_qplib_alloc_res(struct bnxt_qplib_res *res, struct pci_dev *pdev,
> > >       bnxt_qplib_free_res(res);
> > >       return rc;
> > >  }
> > > +
> > > +bool bnxt_qplib_enable_atomic_ops_to_root(struct pci_dev *dev)
> >
> > Why do you need open-coded variant of pci_enable_atomic_ops_to_root()?
> That function is trying to write on the device after determination. I
> can rename to something else to avoid partial namespace collision, not
> a problem

I saw same implementation and this was the reason of my question.

Thanks

> >
> > Thanks
> 
> 
> 
> -- 
> -Regards
> Devesh


