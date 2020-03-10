Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1F4617F202
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Mar 2020 09:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgCJIff (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Mar 2020 04:35:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:50878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726389AbgCJIfe (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Tue, 10 Mar 2020 04:35:34 -0400
Received: from localhost (unknown [193.47.165.251])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B38B224677;
        Tue, 10 Mar 2020 08:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583829334;
        bh=DWQOhUpZ3gIvnqgQ3gwMpiB3+SrtCurV7OkFHYoKDF4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aUcrv22G+Lla4BSReGAwu6VJ54t5E+iKKCBis+acXNEjGTPAo0wUewqtqxAjdAIgs
         Q0s+3UHREspKYG1Mp2ncgBMxxik2nDSxckfnZsK2aO5nDo45AaiApve9uhIGNcDQUW
         lJKBHl3IztFmIPaI6aJeuO46MolYV+ALuqevsxpo=
Date:   Tue, 10 Mar 2020 10:35:31 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Cc:     RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH rdma-next v1 00/12] MR cache fixes and refactoring
Message-ID: <20200310083531.GA242734@unreal>
References: <20200310082238.239865-1-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310082238.239865-1-leon@kernel.org>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

+ RDMA

On Tue, Mar 10, 2020 at 10:22:26AM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@mellanox.com>
>
> Changelog:
>  * v1: Added Saeed's patches.
>  * v0: https://lore.kernel.org/linux-rdma/20200227123400.97758-1-leon@kernel.org
>
> --------------------------------------------------------------------
> Hi,
>
> This series fixes various corner cases in the mlx5_ib MR
> cache implementation, see specific commit messages for more
> information.
>
> Thanks
>
>
> Jason Gunthorpe (8):
>   RDMA/mlx5: Rename the tracking variables for the MR cache
>   RDMA/mlx5: Simplify how the MR cache bucket is located
>   RDMA/mlx5: Always remove MRs from the cache before destroying them
>   RDMA/mlx5: Fix MR cache size and limit debugfs
>   RDMA/mlx5: Lock access to ent->available_mrs/limit when doing
>     queue_work
>   RDMA/mlx5: Fix locking in MR cache work queue
>   RDMA/mlx5: Revise how the hysteresis scheme works for cache filling
>   RDMA/mlx5: Allow MRs to be created in the cache synchronously
>
> Michael Guralnik (1):
>   {IB,net}/mlx5: Move asynchronous mkey creation to mlx5_ib
>
> Saeed Mahameed (3):
>   {IB,net}/mlx5: Setup mkey variant before mr create command invocation
>   {IB,net}/mlx5: Assign mkey variant in mlx5_ib only
>   IB/mlx5: Replace spinlock protected write with atomic var
>
>  drivers/infiniband/hw/mlx5/main.c             |   1 +
>  drivers/infiniband/hw/mlx5/mlx5_ib.h          |  35 +-
>  drivers/infiniband/hw/mlx5/mr.c               | 659 ++++++++++--------
>  drivers/infiniband/hw/mlx5/odp.c              |   2 +-
>  .../net/ethernet/mellanox/mlx5/core/main.c    |   1 -
>  drivers/net/ethernet/mellanox/mlx5/core/mr.c  |  31 +-
>  include/linux/mlx5/driver.h                   |  10 -
>  7 files changed, 419 insertions(+), 320 deletions(-)
>
> --
> 2.24.1
>
