Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7AB270BDF
	for <lists+linux-rdma@lfdr.de>; Sat, 19 Sep 2020 10:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgISIa0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 19 Sep 2020 04:30:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:52498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726174AbgISIa0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 19 Sep 2020 04:30:26 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB8C121481;
        Sat, 19 Sep 2020 08:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600504225;
        bh=2bS8Y8GUmZfsV4GY+Gme8bCKtCs+jJghBiCM0frI8Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZxTjRw1KLONSfGwICZGfWD/MKtv1ilwPpsjJ6gXbysojdeg/1HwCaTz0hEqFif8CV
         r7j1RS/Tpnzynb3zGpbBbrRHF6M567nsjalS4Gig3O7o4Y64oGIqwItlm1RJfD3mhN
         F18iur5XXJVUkMCOYoOv6JAXH9y961Nv8U+aUx14=
Date:   Sat, 19 Sep 2020 11:30:21 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next v2 04/14] RDMA/restrack: Count references to
 the verbs objects
Message-ID: <20200919083021.GY869610@unreal>
References: <20200907122156.478360-1-leon@kernel.org>
 <20200907122156.478360-5-leon@kernel.org>
 <20200918170020.GD3699@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200918170020.GD3699@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Sep 18, 2020 at 02:00:20PM -0300, Jason Gunthorpe wrote:
> On Mon, Sep 07, 2020 at 03:21:46PM +0300, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@mellanox.com>
> >
> > Refactor the restrack code to make sure that kref inside restrack entry
> > properly kref the object in which it is embedded. This slight change is
> > needed for future conversions of MR and QP which are refcounted before
> > the release and kfree.
> >
> > The ideal flow from ib_core perspective as follows:
> > * Allocate ib_* structure with rdma_zalloc_*.
>
> Given how things are going it would be good to eventually include the
> kref initialization in the allocation:

Yep, this is the plan.

>
> struct rdma_restrack_entry *_rdma_zalloc_drv_obj_gfp(struct ib_device *ibdev,
> 						     size_t size,
> 						     size_t res_offset,
> 						     gfp_t flags);
> {
>     struct rdma_restrack_entry res = kzalloc(size, flags) + res_offset;
> [..]
>     return res;
> }
>
> #define rdma_zalloc_drv_obj_gfp(ib_dev, ib_type, gfp)                          \
> 	container_of(_rdma_zalloc_drv_obj_gfp(                                 \
> 			     ib_dev, (ib_dev)->ops.size_##ib_type,             \
> 			     offsetof(struct ib_type, res), gfp),              \
> 		     struct ib_type, res)
>
> As the idea is every drv_obj will have the kref
>
> The patch looks OK, the rdma_restrack_new calls are all near their
> matching allocations
>
> Jason
