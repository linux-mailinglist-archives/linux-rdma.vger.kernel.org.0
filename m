Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918B02456A5
	for <lists+linux-rdma@lfdr.de>; Sun, 16 Aug 2020 10:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726985AbgHPILl (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 16 Aug 2020 04:11:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725986AbgHPILj (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 16 Aug 2020 04:11:39 -0400
Received: from localhost (unknown [213.57.247.131])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5FED72065C;
        Sun, 16 Aug 2020 08:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597565499;
        bh=qR6bXbhqJAxMOnDvTEU8dcP0bKQliVVdnV9L5TbvwnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EmuYEeBWmyDRQIZBqtgUacqebNk4cbRj3Qtf3RBFwADs4dlKOFf3ntMYhjXVhKa++
         sebXMlGQpEGNi8jdXPND/vFwr0/HufIuUzZHL4VjgNka80mjNI1VTxayUEaHsfhXCU
         B84qDMcj1Lp+j0vbD5ibjIyJWYW0yMuNMo1Z1AQs=
Date:   Sun, 16 Aug 2020 11:11:35 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Doug Ledford <dledford@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Yishai Hadas <yishaih@mellanox.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/mlx5: Fix memleak in subscribe_event_xa_alloc
Message-ID: <20200816081135.GG7555@unreal>
References: <20200815034537.9867-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200815034537.9867-1-dinghao.liu@zju.edu.cn>
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Aug 15, 2020 at 11:45:37AM +0800, Dinghao Liu wrote:
> When xa_insert() fails, obj_event needs to be freed
> just like what we have done to event when xa_insert()
> fails. However, current code is returning directly
> and ends up leaking memory.
>
> Fixes: 7597385371425 ("IB/mlx5: Enable subscription for device events over DEVX")
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> ---
>  drivers/infiniband/hw/mlx5/devx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>

Thanks,
Acked-by: Leon Romanovsky <leonro@nvidia.com>
