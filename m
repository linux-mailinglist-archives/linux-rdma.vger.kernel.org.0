Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A9230D32A
	for <lists+linux-rdma@lfdr.de>; Wed,  3 Feb 2021 06:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231348AbhBCFsC (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 3 Feb 2021 00:48:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:50960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231301AbhBCFsB (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 3 Feb 2021 00:48:01 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE93F64F41;
        Wed,  3 Feb 2021 05:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612331241;
        bh=0EIGiGbsZT1uQ909SuZhT8i8yS8RrntqUOcjTPRv2LE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T7rOw2sCrZncu44vHksHhRHmACC0F9VJSFMXoEqx14nVeD52zwN88lm/Dkx3ZQMGS
         G+YSXwolKnIuVtTCaD5kzKZXU1J6m3p0jiygz99aKRAI2E125/vDKCSx4UYgMxB8QG
         pZsmlXxXpQJ8XCkSpl/J4wZBUAzbN52LmU7cWR/D2uHO6eF4lN89fiEWH2rW9qJL/m
         hD1GNfqjU7kBNZYAOuvGFphkKY5AOlSCTyVKBqDxeZrHXemMEC/WdyeC2TPa3FZdLY
         D1hX5MsWgDhx0zAFbMg9D+ojsRT33WI/TBkDXU0z+IzWh8SPDJTsOtXRNH0oiLR4ZZ
         i3fFWrUl91JHw==
Date:   Wed, 3 Feb 2021 07:47:17 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH rdma-next 00/10] Various cleanups
Message-ID: <20210203054717.GJ3264866@unreal>
References: <20210127150010.1876121-1-leon@kernel.org>
 <20210202233504.GA677751@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210202233504.GA677751@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Feb 02, 2021 at 07:35:04PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 27, 2021 at 05:00:00PM +0200, Leon Romanovsky wrote:
> > From: Leon Romanovsky <leonro@nvidia.com>
> >
> > Various simple cleanups to mlx4, mlx5 and core.
> >
> > Parav Pandit (10):
> >   IB/mlx5: Move mlx5_port_caps from mlx5_core_dev to mlx5_ib_dev
> >   IB/mlx5: Avoid calling query device for reading pkey table length
> >   IB/mlx5: Improve query port for representor port
> >   RDMA/core: Introduce and use API to read port immutable data
> >   IB/mlx5: Use rdma_for_each_port for port iteration
>
> These didn't want to apply, can you resend them with that other thing
> fixed?
>
> >   IB/mlx5: Support default partition key for representor port
> >   IB/mlx5: Return appropriate error code instead of ENOMEM
> >   IB/cm: Avoid a loop when device has 255 ports
> >   IB/mlx4: Use port iterator and validation APIs
> >   IB/core: Use valid port number to check link layer
>
> I fixed the misplaced hunk and took these to for-next though

Thanks, I'll resend.

>
> Thanks,
> Jason
