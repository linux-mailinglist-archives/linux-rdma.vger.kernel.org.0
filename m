Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA9D389F7A
	for <lists+linux-rdma@lfdr.de>; Thu, 20 May 2021 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhETILF (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 20 May 2021 04:11:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34664 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229536AbhETILF (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 20 May 2021 04:11:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6572961059;
        Thu, 20 May 2021 08:09:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621498184;
        bh=EiZTRan4NS7P0IMxcIGWGtvHidJlLqo9inKvhwmL7Jw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PKUqHHcz8B7CSnM5x7ikq6SWdIVE0MDWE5vVqBPvr6iBP3AmVsKvrO0RsSwrWjus4
         6k5Zpv1KA0IY/z3N5P5aNP5zOaPEChY2/9u6WqHHs1d3uEMM2NTX7kpuccB1unVZI9
         GsXZDHOVCjEZj4GCHihKb2sTAP75xWFANtuDwEaO3aZqRs7ySi5K0/qa8nx2n3Rg+r
         OKg9FzBu0D3IYt+katKm/Wmdke4+l4Cdo9bGdY6z/tRGiem8K8+wbtGBpoS3yp36W4
         qBN8vrJeSTnZ+T2U0Z62yuI0odStRJPPeERhvgQUOZ+4P+bXWtxNLQXWipO7/7oNr0
         BUR83DjMzHcHA==
Date:   Thu, 20 May 2021 11:09:40 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     danielj@mellanox.com, linux-rdma@vger.kernel.org
Subject: Re: [bug report] {net, IB}/mlx5: Manage port association for
 multiport RoCE
Message-ID: <YKYZRPVauAtmmt/M@unreal>
References: <20210518082855.GB32682@kadam>
 <YKUeOV14j98OJIj7@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YKUeOV14j98OJIj7@mwanda>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Wed, May 19, 2021 at 05:18:33PM +0300, Dan Carpenter wrote:
> Hello Daniel Jurgens,
> 
> The patch 32f69e4be269: "{net, IB}/mlx5: Manage port association for
> multiport RoCE" from Jan 4, 2018, leads to the following static
> checker warning:
> 
> 	drivers/infiniband/hw/mlx5/main.c:3285 mlx5_ib_init_multiport_master()
> 	warn: iterator 'mpi->list.next' changed during iteration

Thanks Dan for the report, I'll prepare the fix.

> 
> drivers/infiniband/hw/mlx5/main.c
>   3285                  list_for_each_entry(mpi, &mlx5_ib_unaffiliated_port_list,
>                                                   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> We're iterating through the unafiliated list.
> 
>   3286                                      list) {
>   3287                          if (dev->sys_image_guid == mpi->sys_image_guid &&
>   3288                              (mlx5_core_native_port_num(mpi->mdev) - 1) == i) {
>   3289                                  bound = mlx5_ib_bind_slave_port(dev, mpi);
> 
> The mlx5_ib_bind_slave_port() function returns true on success and
> false on failure.  On the failure path it calls:
> 
> 	mlx5_ib_unbind_slave_port(ibdev, mpi);
> 
> Which adds our "mpi" as the last item on the unaffiliated list.  I don't
> think anything good can come from adding a list item to a list twice.
> 
>   3290                          }
>   3291  
>   3292                          if (bound) {
>   3293                                  dev_dbg(mpi->mdev->device,
>   3294                                          "removing port from unaffiliated list.\n");
>   3295                                  mlx5_ib_dbg(dev, "port %d bound\n", i + 1);
>   3296                                  list_del(&mpi->list);
>   3297                                  break;
>   3298                          }
>   3299                  }
>   3300                  if (!bound)
>   3301                          mlx5_ib_dbg(dev, "no free port found for port %d\n",
>   3302                                      i + 1);
> 
> regards,
> dan carpenter
