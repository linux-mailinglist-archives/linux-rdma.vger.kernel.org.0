Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171D4321889
	for <lists+linux-rdma@lfdr.de>; Mon, 22 Feb 2021 14:26:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbhBVNZG (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 22 Feb 2021 08:25:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:36702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhBVNX7 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 22 Feb 2021 08:23:59 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 119DF600CF;
        Mon, 22 Feb 2021 13:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614000198;
        bh=xqQOF02MY68NQaErsbZLk6z07mtojH5uvtvco3RHktg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MkKoZ1LR/FxUlROkW7zpmvzAm5DW02Ec5ywdqWt9HSH9KTahBeSAL9RTwGeOo75mc
         4V45Bb8xOfVXsqscPbwgTySAdh9JswoGghQzV8ANe2/vQLOzHU0VGdyeSOpZ2O4Y5R
         Kl7oGBMycQx/DXI0kCKSPEEBg6ROpzBmBSOsQdqrZy317tY9mG1RB8vCDrjKtXsvx+
         plfd8++//dvtl/3DV0iv/JkD7ZOTo+8iJ/n3aJvHWQUpK7J/4cDbJ4FdYCkFrEhPBq
         quWSAX2UkukmyCt5I0lei8eHE8bun8w+dBuMB1ZncZNGgtFSHm3Vuq3m1ANVknidVN
         9/cfYCjzM8KbQ==
Date:   Mon, 22 Feb 2021 15:23:15 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, yishaih@nvidia.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 -next] IB/mlx5: Add missing error code
Message-ID: <YDOwQyZJ+Iovj/Yj@unreal>
References: <20210222082503.22388-1-yuehaibing@huawei.com>
 <20210222122343.19720-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222122343.19720-1-yuehaibing@huawei.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 22, 2021 at 08:23:43PM +0800, YueHaibing wrote:
> Set err to -ENOMEM if kzalloc fails instead of 0.
>
> Fixes: 759738537142 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>

And please don't send new version of patches as a reply-to, it is
annoying like hell.

Thanks
