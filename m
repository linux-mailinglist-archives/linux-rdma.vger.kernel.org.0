Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 608B714FC65
	for <lists+linux-rdma@lfdr.de>; Sun,  2 Feb 2020 10:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725962AbgBBJaB (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 2 Feb 2020 04:30:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725956AbgBBJaB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 2 Feb 2020 04:30:01 -0500
Received: from localhost (unknown [185.175.219.0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B16682067C;
        Sun,  2 Feb 2020 09:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580635800;
        bh=XjEThwS5uF6Jb4T0tE+tXlCl5f7hqrdGoZ3C0ffGLjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OfGsvTORydVS30Aj7EVadbmnNmhcUg7IsKO6MD0vPtP0qt4G/wqshSAzjC1meW4wX
         2avxDjDIIWT4+dxiTBTq5x9koBCbSQMpYGgYwEqB3JxiNWQjmbsNr1y601VIVNptyu
         sFuECnRNhNX9BoNoomw0ss2F4dF8swxLer38jpgE=
Date:   Sun, 2 Feb 2020 11:29:56 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     Kamal Heib <kamalheib1@gmail.com>, linux-rdma@vger.kernel.org,
        Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH for-next] RDMA/providers: Fix return value when QP type
 isn't supported
Message-ID: <20200202092956.GI414821@unreal>
References: <20200130082049.463-1-kamalheib1@gmail.com>
 <20200130083904.GF3326@unreal>
 <1f508bbc-d858-13b6-d81e-db95fa172e9a@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f508bbc-d858-13b6-d81e-db95fa172e9a@intel.com>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 30, 2020 at 11:07:17AM -0500, Dennis Dalessandro wrote:
> On 1/30/2020 3:39 AM, Leon Romanovsky wrote:
> > On Thu, Jan 30, 2020 at 10:20:49AM +0200, Kamal Heib wrote:
> > > The proper return code is "-EOPNOTSUPP" when the requested QP type is
> > > not supported by the provider.
> > >
> > > Signed-off-by: Kamal Heib <kamalheib1@gmail.com>
> > > ---
> > >   drivers/infiniband/hw/bnxt_re/ib_verbs.c     | 2 +-
> > >   drivers/infiniband/hw/cxgb4/qp.c             | 2 +-
> > >   drivers/infiniband/hw/hns/hns_roce_qp.c      | 2 +-
> > >   drivers/infiniband/hw/i40iw/i40iw_verbs.c    | 2 +-
> > >   drivers/infiniband/hw/mlx4/qp.c              | 2 +-
> > >   drivers/infiniband/hw/mlx5/qp.c              | 2 +-
> > >   drivers/infiniband/hw/mthca/mthca_provider.c | 2 +-
> > >   drivers/infiniband/hw/ocrdma/ocrdma_verbs.c  | 2 +-
> > >   drivers/infiniband/hw/qedr/verbs.c           | 2 +-
> > >   drivers/infiniband/hw/usnic/usnic_ib_verbs.c | 2 +-
> > >   drivers/infiniband/hw/vmw_pvrdma/pvrdma_qp.c | 2 +-
> > >   drivers/infiniband/sw/rdmavt/qp.c            | 2 +-
> > >   drivers/infiniband/sw/siw/siw_verbs.c        | 2 +-
> > >   13 files changed, 13 insertions(+), 13 deletions(-)
> >
> > *_err() prints definitely should go too. Simple user space
> > application will create DDOS on dmesg with those prints.
> >
> > I would say that other prints should be removed too or at least
> > put in general way inside the caller of ->create_qp() callback.
>
> I'd agree but I don't think that has to be done in this patch. This looks
> fine to me.

No doubts, I simply want to reduce the amount of churn.

Thanks

>
> -Denny
>
>
