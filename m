Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF2140C583
	for <lists+linux-rdma@lfdr.de>; Wed, 15 Sep 2021 14:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237528AbhIOMpw (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 15 Sep 2021 08:45:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:57732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237375AbhIOMpv (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 15 Sep 2021 08:45:51 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CCD461178;
        Wed, 15 Sep 2021 12:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631709872;
        bh=QRi7E+DEpTJvxSWSI8MFdIh+vqqB9n9nwKqMVosEo2k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QNrJFDq4oO1syPUxeYbTYEIB3JqECcgdIUZtiFDRvQhPKwszWyX5HImCpkOFU3BMR
         Qgp+0RQ/3D4Jgp+qse17fGelGN4HZLsPgyjKfxWeSJs/R6OJNNa291US5+0maePgu/
         qvN51SxaDKYamOc7c5IZL4/X4HaQbh9GyKiKK6gVlzoStVOX9geg2WFKD5oCTLQ1b2
         Y9PN8clOYeSaZ/wxJsxK1is7WU8y4DDUf9AsI1643tJ9K7+kA5Ucvfo/OBWqR+qKhl
         +0yucvgI1b+arbVm0HyxepI0XXRqytdUfnOyuz2H1roNySeRu0D+h69lNKoRc/LV9k
         x/z/6NlRjWdiQ==
Date:   Wed, 15 Sep 2021 15:44:29 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>
Cc:     Alaa Hleihel <alaa@nvidia.com>, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH rdma-rc] RDMA/mlx5: Add dummy umem to IB_MR_TYPE_DM
Message-ID: <YUHqrUdnbIr3R9DO@unreal>
References: <9c6478b70dc23cfec3a7bfc345c30ff817e7e799.1631660866.git.leonro@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c6478b70dc23cfec3a7bfc345c30ff817e7e799.1631660866.git.leonro@nvidia.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, Sep 15, 2021 at 02:08:25AM +0300, Leon Romanovsky wrote:
> From: Alaa Hleihel <alaa@nvidia.com>
> 
> After the cited patch, and for the case of IB_MR_TYPE_DM that doesn't
> have a umem (even though it is a user MR), function mlx5_free_priv_descs()
> will think that it's a kernel MR, leading to wrongly accessing mr->descs
> that will get wrong values in the union which leads to attempting to
> release resources that were not allocated in the first place.
> 
> For example:
>  DMA-API: mlx5_core 0000:08:00.1: device driver tries to free DMA memory it has not allocated [device address=0x0000000000000000] [size=0 bytes]
>  WARNING: CPU: 8 PID: 1021 at kernel/dma/debug.c:961 check_unmap+0x54f/0x8b0
>  RIP: 0010:check_unmap+0x54f/0x8b0
>  Call Trace:
>   debug_dma_unmap_page+0x57/0x60
>   mlx5_free_priv_descs+0x57/0x70 [mlx5_ib]
>   mlx5_ib_dereg_mr+0x1fb/0x3d0 [mlx5_ib]
>   ib_dereg_mr_user+0x60/0x140 [ib_core]
>   uverbs_destroy_uobject+0x59/0x210 [ib_uverbs]
>   uobj_destroy+0x3f/0x80 [ib_uverbs]
>   ib_uverbs_cmd_verbs+0x435/0xd10 [ib_uverbs]
>   ? uverbs_finalize_object+0x50/0x50 [ib_uverbs]
>   ? lock_acquire+0xc4/0x2e0
>   ? lock_acquired+0x12/0x380
>   ? lock_acquire+0xc4/0x2e0
>   ? lock_acquire+0xc4/0x2e0
>   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
>   ? lock_release+0x28a/0x400
>   ib_uverbs_ioctl+0xc0/0x140 [ib_uverbs]
>   ? ib_uverbs_ioctl+0x7c/0x140 [ib_uverbs]
>   __x64_sys_ioctl+0x7f/0xb0
>   do_syscall_64+0x38/0x90
> 
> Fix it by adding a dummy umem to IB_MR_TYPE_DM MRs.
> 
> Fixes: f18ec4223117 ("RDMA/mlx5: Use a union inside mlx5_ib_mr")
> Signed-off-by: Alaa Hleihel <alaa@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/infiniband/core/umem.c  | 21 +++++++++++++++++++++
>  drivers/infiniband/hw/mlx5/mr.c |  5 +++++
>  include/rdma/ib_umem.h          |  5 +++++
>  3 files changed, 31 insertions(+)

Please drop this patch, it seems that the proposed solution is too naive.

Thanks
