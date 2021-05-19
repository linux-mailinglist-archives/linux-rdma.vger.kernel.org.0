Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69E5388C0B
	for <lists+linux-rdma@lfdr.de>; Wed, 19 May 2021 12:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345051AbhESKvi (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 19 May 2021 06:51:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:44140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345943AbhESKv1 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Wed, 19 May 2021 06:51:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 711DC61355;
        Wed, 19 May 2021 10:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621421408;
        bh=Fowarf4plbdfbQqqOSNt/zfJxe7Y57lEaHYbMxZJsn8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lsBDur4TRdHu/ikCGc9Uj2VjCQAkemp3sWuBzbAFmDcwBzNNVQe7xbw1lzoKk0pxP
         rziYm2UaQl3CGFsZ7FIqP2p5mSGANGMT7uMPZM+UOJo+AX1BVEWl71pyP89b0s9t2I
         aw+qP3hwHRU53wChoDe/vkWbCrw/RoGmHaEYY3hUuzGYK0FBMC2YRjhcXOZRWBlvIT
         xFi0I3OGxenE46bj8TM7p01MOr1lNJ6arx5m+wrsX36MvUr8uQo391YQ1XMsBszkIh
         XwSlDAtywd36H85pcG2kYbYyBQZX3NrnwZfYlw5KhGj23Q1BwH08kjXdGxeEwa1u2T
         r4DTT2Yk3truQ==
Date:   Wed, 19 May 2021 13:50:04 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Weihang Li <liweihang@huawei.com>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        linuxarm@huawei.com, Lang Cheng <chenglang@huawei.com>
Subject: Re: [PATCH for-next 3/4] RDMA/mlx5: Remove unused parameter udata
Message-ID: <YKTtXA0PUU+AUqoO@unreal>
References: <1620807142-39157-1-git-send-email-liweihang@huawei.com>
 <1620807142-39157-4-git-send-email-liweihang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1620807142-39157-4-git-send-email-liweihang@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 12, 2021 at 04:12:21PM +0800, Weihang Li wrote:
> From: Lang Cheng <chenglang@huawei.com>
> 
> The old version of ib_umem_get() need these udata as a parameter but now
> they are unnecessary.
> 
> Fixes: c320e527e154 ("IB: Allow calls to ib_umem_get from kernel ULPs")
> Cc: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Lang Cheng <chenglang@huawei.com>
> Signed-off-by: Weihang Li <liweihang@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/cq.c       | 2 +-
>  drivers/infiniband/hw/mlx5/doorbell.c | 3 +--
>  drivers/infiniband/hw/mlx5/mlx5_ib.h  | 4 +---
>  drivers/infiniband/hw/mlx5/mr.c       | 2 +-
>  drivers/infiniband/hw/mlx5/odp.c      | 1 -
>  drivers/infiniband/hw/mlx5/qp.c       | 4 ++--
>  drivers/infiniband/hw/mlx5/srq.c      | 2 +-
>  7 files changed, 7 insertions(+), 11 deletions(-)
> 

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
