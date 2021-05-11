Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83FD737A6C7
	for <lists+linux-rdma@lfdr.de>; Tue, 11 May 2021 14:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbhEKMfm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 May 2021 08:35:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230475AbhEKMfi (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 11 May 2021 08:35:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B3BE16190A;
        Tue, 11 May 2021 12:34:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620736470;
        bh=n+jSmGNQbhjtny2vTOSU0U5rOWM5+bi641fvtQxXXbE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ENjFrDtflR7X8+9+kXKiEToh7QqEjvV6UEUoFO01UfneHCBiV6CkrH/qV8yoPbBYQ
         uaGMRg2dgjmUgcD4UibaT9/4Rpo/TOPHwTJh8jkcB4L7Q3M1ZoclHmU/EEV7sEGS27
         Wa9FySRvxHiI6f/JDvMA+dAh8yn4g9og8kWqrMlsNLSj3l/BtINs9sednTc1RvI/Lo
         b+/26+g4lEuJvcPIkUU/6BCJTMcfvZsYSFY2LMuQ7ErYQ0xm2G96mf1UjV+DdF1wb7
         F4lMM9cDUpZrDS4GHSwup6/fb0iRl/xHyi5zE+F3W2s8wOxExWv9eDxKMB4yMkMEYf
         2UXPyLTRUhdFg==
Date:   Tue, 11 May 2021 15:34:26 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Haakon Bugge <haakon.bugge@oracle.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        OFED mailing list <linux-rdma@vger.kernel.org>,
        Mike Marciniszyn <mike.marciniszyn@cornelisnetworks.com>
Subject: Re: [PATCH rdma-next] RDMA/rdmavt: Decouple QP and SGE lists
 allocations
Message-ID: <YJp50nw6JD3ptVDp@unreal>
References: <c34a864803f9bbd33d3f856a6ba2dd595ab708a7.1620729033.git.leonro@nvidia.com>
 <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F62CF3D3-E605-4CBA-B171-5BB98594C658@oracle.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, May 11, 2021 at 10:59:52AM +0000, Haakon Bugge wrote:
> 
> 
> > On 11 May 2021, at 12:36, Leon Romanovsky <leon@kernel.org> wrote:
> > 
> > From: Leon Romanovsky <leonro@nvidia.com>
> > 
> > The rdmavt QP has fields that are both needed for the control and data
> > path. Such mixed declaration caused to the very specific allocation flow
> > with kzalloc_node and SGE list embedded into the struct rvt_qp.
> > 
> > This patch separates QP creation to two: regular memory allocation for
> > the control path and specific code for the SGE list, while the access to
> > the later is performed through derefenced pointer.
> > 
> > Such pointer and its context are expected to be in the cache, so
> > performance difference is expected to be negligible, if any exists.
> > 
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> > Hi,
> > 
> > This change is needed to convert QP to core allocation scheme. In that
> > scheme QP is allocated outside of the driver and size of such allocation
> > is constant and can be calculated at the compile time.
> > 
> > Thanks
> > ---
> > drivers/infiniband/sw/rdmavt/qp.c | 13 ++++++++-----
> > include/rdma/rdmavt_qp.h          |  2 +-
> > 2 files changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> > index 9d13db68283c..4522071fc220 100644
> > --- a/drivers/infiniband/sw/rdmavt/qp.c
> > +++ b/drivers/infiniband/sw/rdmavt/qp.c
> > @@ -1077,7 +1077,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
> > 	int err;
> > 	struct rvt_swqe *swq = NULL;
> > 	size_t sz;
> > -	size_t sg_list_sz;
> > +	size_t sg_list_sz = 0;
> > 	struct ib_qp *ret = ERR_PTR(-ENOMEM);
> > 	struct rvt_dev_info *rdi = ib_to_rvt(ibpd->device);
> > 	void *priv = NULL;
> > @@ -1125,8 +1125,6 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
> > 		if (!swq)
> > 			return ERR_PTR(-ENOMEM);
> > 
> > -		sz = sizeof(*qp);
> > -		sg_list_sz = 0;
> > 		if (init_attr->srq) {
> > 			struct rvt_srq *srq = ibsrq_to_rvtsrq(init_attr->srq);
> > 
> > @@ -1136,10 +1134,13 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
> > 		} else if (init_attr->cap.max_recv_sge > 1)
> > 			sg_list_sz = sizeof(*qp->r_sg_list) *
> > 				(init_attr->cap.max_recv_sge - 1);
> > -		qp = kzalloc_node(sz + sg_list_sz, GFP_KERNEL,
> > -				  rdi->dparms.node);
> > +		qp = kzalloc(sizeof(*qp), GFP_KERNEL);
> 
> Why not kzalloc_node() here?

The idea is to delete this kzalloc later in next patch, because all
drivers are doing same thing "qp = kzalloc(sizeof(*qp), GFP_KERNEL);".

Thanks
