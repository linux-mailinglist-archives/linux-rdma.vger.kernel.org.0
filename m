Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 869C22FB82
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 14:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfE3MWz (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 08:22:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:60820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727182AbfE3MWz (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 30 May 2019 08:22:55 -0400
Received: from localhost (unknown [37.142.3.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 781C4258B0;
        Thu, 30 May 2019 12:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559218975;
        bh=SnJ45KsbBgbZtQW795wL3uJjRXs4XAgk7ShAVFKe0RY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cQZKdM60aSN1Wnr6ZTFBDmjKoW+J/sVYTVD+d5IY8zG1P/I+VQv8abjYK1AI61H4D
         uwCCmMMoMK1uL9QydhV1Puxc5E8OPbT+1vgFkI5ouobQqkPmVmNsS1w0GOrLlEbrpQ
         fPHAhSpnoxTtU0qkrYMI8Oiq9UV01f39+RcoeuYo=
Date:   Thu, 30 May 2019 15:22:51 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ariel Levkovich <lariel@mellanox.com>
Subject: Re: [PATCH] IB/mlx5: Limit to 64-bit builds
Message-ID: <20190530122251.GD6251@mtr-leonro.mtl.com>
References: <1559216144-2085-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1559216144-2085-1-git-send-email-linux@roeck-us.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 04:35:44AM -0700, Guenter Roeck wrote:
> 32-bit builds fail with errors such as
>
> ERROR: "__udivdi3" [drivers/infiniband/hw/mlx5/mlx5_ib.ko] undefined!

It is fixed in rdma-rc.
https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=wip/jgg-for-rc&id=37eb86c4507abcb14fc346863e83aa8751aa4675

Thanks

>
> Fixes: 25c13324d03d ("IB/mlx5: Add steering SW ICM device memory type")
> Cc: Ariel Levkovich <lariel@mellanox.com>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/infiniband/hw/mlx5/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/infiniband/hw/mlx5/Kconfig b/drivers/infiniband/hw/mlx5/Kconfig
> index ea248def4556..574b97da7a43 100644
> --- a/drivers/infiniband/hw/mlx5/Kconfig
> +++ b/drivers/infiniband/hw/mlx5/Kconfig
> @@ -1,7 +1,7 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  config MLX5_INFINIBAND
>  	tristate "Mellanox 5th generation network adapters (ConnectX series) support"
> -	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE
> +	depends on NETDEVICES && ETHERNET && PCI && MLX5_CORE && 64BIT
>  	---help---
>  	  This driver provides low-level InfiniBand support for
>  	  Mellanox Connect-IB PCI Express host channel adapters (HCAs).
> --
> 2.7.4
>
