Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226182D2348
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Dec 2020 06:43:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgLHFnW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Dec 2020 00:43:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:37598 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726080AbgLHFnW (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 8 Dec 2020 00:43:22 -0500
Date:   Tue, 8 Dec 2020 07:42:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607406162;
        bh=BKtVO+0M7OgRl4NJpQoi97fB4AnB80WBCn18/onclL0=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=pxtpi/8X7RsL2U0okFx4pooas3l42RBXMbZPWfe/k6LFbFdH4I+I8MzbrtdpTPQvd
         f3R4ycYsIssgN2OiNz2HV4yCPiOuDXgaw5mhWT7/E42iDHSLYeWOe9fBlPrYritOga
         0X3CtQaK3ojsXeWgzJB4xjh4gZro0br2prhq+41xn6vcgWI3tqXnPmXowKejUGOdjL
         yQM8Dr44A3aq8ehBihwqYlJ/lS0ML4A+2HvvdGmDRBhMRSn6UG01AAKB5dKFjBUVWj
         dwuvFZSCEwsW5ngSf1XW1XvCEk6yJL0fpqhEcCFB/Ep1BwEfeYmDra/GT3AWneveRj
         FIvF9tMU8Gvvw==
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        Maor Gottlieb <maorg@nvidia.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-next] RDMA/mlx5: Assign dev to DM MR
Message-ID: <20201208054235.GA4430@unreal>
References: <20201203190807.127189-1-leon@kernel.org>
 <20201207200306.GA1790347@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201207200306.GA1790347@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 07, 2020 at 04:03:06PM -0400, Jason Gunthorpe wrote:
> On Thu, Dec 03, 2020 at 09:08:07PM +0200, Leon Romanovsky wrote:
> > From: Maor Gottlieb <maorg@nvidia.com>
> >
> > Currently, DM MR registration flow doesn't set the mlx5_ib_dev
> > pointer and can cause NULL pointer dereference.
> > Fix it by assign the IB device together with the other fields and
> > remove unessecary reference of mlx5_ib_dev from mlx5_ib_mr.
> >
> > Fixes: 6c29f57ea475 ("IB/mlx5: Device memory mr registration support")
> > Signed-off-by: Maor Gottlieb <maorg@nvidia.com>
> > Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> > ---
> >  drivers/infiniband/hw/mlx5/mlx5_ib.h  |  6 +++-
> >  drivers/infiniband/hw/mlx5/mr.c       | 17 ++++++------
> >  drivers/infiniband/hw/mlx5/odp.c      | 40 ++++++++++++++-------------
> >  drivers/infiniband/hw/mlx5/restrack.c |  2 +-
> >  4 files changed, 35 insertions(+), 30 deletions(-)
>
> This really should be backported, an unconditional user triggerable
> null pointer deref is clearly cc: stable stuff. I've added that.
>
> This has all kinds of conflicts with the current rc branch so I'm
> putting it in for-next, someone will have to make the backport

Thanks, this is why I sent it to the -next branch.

>
> Jason
