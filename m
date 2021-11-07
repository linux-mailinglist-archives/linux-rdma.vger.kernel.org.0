Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D24C0447204
	for <lists+linux-rdma@lfdr.de>; Sun,  7 Nov 2021 08:40:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbhKGHmr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 7 Nov 2021 02:42:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234272AbhKGHmq (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sun, 7 Nov 2021 02:42:46 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C3675613AC;
        Sun,  7 Nov 2021 07:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636270804;
        bh=xK7EWfUT/HcNYKPKVTyFRCEn67drZQu6TfoeV5SB8wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y83LSuQDcfps1yh5CmqlTsWUZCUVhFxv0r7t5ZkQbyfhpmy+jYmBzjae/ZAI6uDLj
         1VLmVaWEZ/6PgBVSETy4GQTkLJ0Wqm+jbXPktorPvEZzKUTrvcE/v7L6irnlM+kXuf
         rN4Q2hWCdIDGke6u/3n3mVmxk9OQhnj4NUMVPR3OwWUcT0S4smEa1O2eHOj7dEw4Wl
         g/3Ot3A2Vjgw3Omh5Yy7oFk7VKybaZSzL4ZRSSjhWp+Gn+R0lIcLoX+buVTuOAQYoW
         Il9MS2y0Nr8TRuGkjtzqsW22RCyKiylGj8CXy1lRWorTaNmXGQATlZ9LaDDZcPmzwR
         hTJsgC7n8SMvg==
Date:   Sun, 7 Nov 2021 09:40:00 +0200
From:   Leon Romanovsky <leon@kernel.org>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     yishaih@nvidia.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx4: Fix potential memory leak
Message-ID: <YYeC0O3wL8X0uSsY@unreal>
References: <1636020852-3951757-1-git-send-email-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636020852-3951757-1-git-send-email-jiasheng@iscas.ac.cn>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 04, 2021 at 10:14:12AM +0000, Jiasheng Jiang wrote:
> In the error path, the dev->dev isn't released.
> Therefore, it might be better to fix it to avoid
> potential memory leak.
> 
> Fixes: 9376932 ("IB/mlx4_ib: Add support for user MR re-registration")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
>  drivers/infiniband/hw/mlx4/mr.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I don't understand about which release you are talking, but this patch
can't be right. You are supposed to call to "release_mpt_entry" only in
the error flows which after successful mlx4_mr_hw_get_mpt().

Thanks

> 
> diff --git a/drivers/infiniband/hw/mlx4/mr.c b/drivers/infiniband/hw/mlx4/mr.c
> index 50becc0..d8ae92e 100644
> --- a/drivers/infiniband/hw/mlx4/mr.c
> +++ b/drivers/infiniband/hw/mlx4/mr.c
> @@ -473,7 +473,7 @@ struct ib_mr *mlx4_ib_rereg_user_mr(struct ib_mr *mr, int flags, u64 start,
>  	 */
>  	err =  mlx4_mr_hw_get_mpt(dev->dev, &mmr->mmr, &pmpt_entry);
>  	if (err)
> -		return ERR_PTR(err);
> +		goto release_mpt_entry;
>  
>  	if (flags & IB_MR_REREG_PD) {
>  		err = mlx4_mr_hw_change_pd(dev->dev, *pmpt_entry,
> -- 
> 2.7.4
> 
