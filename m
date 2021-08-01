Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89183DCB5D
	for <lists+linux-rdma@lfdr.de>; Sun,  1 Aug 2021 13:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbhHAL16 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 1 Aug 2021 07:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:53792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231461AbhHAL16 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 1 Aug 2021 07:27:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 27EE860F46;
        Sun,  1 Aug 2021 11:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627817270;
        bh=C3z33tqBperSCk84d9sEKrhG3x66XBirfJNluhRCJ9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qtVacoZKe8jlk1KrjjGUYmfOQ4HNczUH8o9ncNIU6MrVoYbTlmWo1jgjh499jrslv
         ZWnYYDBxuXnWFp+nNRV4YRrzpE4Nff1DNHV1+eKEmV9DkrSFtcAhhnVtan1WyH71rf
         qMNw9l3O6AewS4hMrLL9CANjwmP69c3vKXmSaoPhZYu3d8khdcwc2DGS9spTZyquH1
         sRSimLYDYr+36/g/REgmIPEAXdDfwZLUguI3p6TonfJZOnXH+4QLRNG1JNqD9UrVCG
         ot9x2jUpTVyiAYcM7LTqeSuzUd8ljRxnvewyBJKa5Fs+9LNYCfz0ww6zCtMH/Rk42d
         fGKlBP91dZYvw==
Date:   Sun, 1 Aug 2021 14:27:47 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Li Zhijian <lizhijian@cn.fujitsu.com>
Cc:     dledford@redhat.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: return the EFAULT per ibv_advise_mr(3)
Message-ID: <YQaFM8OTlmde+ZFV@unreal>
References: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210801092050.6322-1-lizhijian@cn.fujitsu.com>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Aug 01, 2021 at 05:20:50PM +0800, Li Zhijian wrote:
> ibv_advise_mr(3) says:
> EFAULT In one of the following: o When the range requested is out of the  MR  bounds,
>        or  when  parts of it are not part of the process address space. o One of the
>        lkeys provided in the scatter gather list is invalid or with wrong write access
> 
> Actually get_prefetchable_mr() will return NULL if it see above conditions
> 
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---
>  drivers/infiniband/hw/mlx5/odp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
