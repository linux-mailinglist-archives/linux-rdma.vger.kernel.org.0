Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF621435E49
	for <lists+linux-rdma@lfdr.de>; Thu, 21 Oct 2021 11:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhJUJwO (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 21 Oct 2021 05:52:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:45188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230269AbhJUJwN (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Thu, 21 Oct 2021 05:52:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A39D6103D;
        Thu, 21 Oct 2021 09:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634809798;
        bh=eVv1giL11L/SqDiCYTChwI/A/LBslfiVpSORimC/dSA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ph/5i/F/KXdjd67IIAV0Vz5Ts+/YgEh5Gx1mj5ZwN2IfJKQDxBXgOtoue9lQQBGth
         LrDHlcymy8l7oZ1q3zynUszIjDrvv7BF2xZ3fQAR2xyrny2e4ItQcc4gnlIntjc8a4
         yuNPJpAfItvR863RM1i47TXM6y2hVvpHrzMKA696PEBCwuwOjxVmkqX+jXpXi5Juk5
         iIU/7mm1Eh5vwW/9MgLDbzYlM2riy4fDRDDEeYJWQF6egQn59wsvZ57Ou4kotXXJzf
         UNSpgsJOxclorjVe1RcbKE7qg3Qj231SRCUHOx82P+/f69oaijP7uNxtal5aplRicQ
         eZaZmMH0Mlbfg==
Date:   Thu, 21 Oct 2021 12:49:53 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     dledford@redhat.com, jgg@nvidia.com, linux-rdma@vger.kernel.org,
        saeedm@nvidia.com
Subject: Re: [PATCH rdma-next 2/3] mlx5: use dev_addr_mod()
Message-ID: <YXE3wblxcVY/1siJ@unreal>
References: <20211019182604.1441387-1-kuba@kernel.org>
 <20211019182604.1441387-3-kuba@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211019182604.1441387-3-kuba@kernel.org>
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Oct 19, 2021 at 11:26:03AM -0700, Jakub Kicinski wrote:
> Commit 406f42fa0d3c ("net-next: When a bond have a massive amount
> of VLANs...") introduced a rbtree for faster Ethernet address look
> up. To maintain netdev->dev_addr in this tree we need to make all
> the writes to it got through appropriate helpers.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: saeedm@nvidia.com
> CC: leon@kernel.org
> CC: linux-rdma@vger.kernel.org
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> index 67571e5040d6..fe76c27835ae 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
> @@ -472,11 +472,13 @@ int mlx5i_dev_init(struct net_device *dev)
>  {
>  	struct mlx5e_priv    *priv   = mlx5i_epriv(dev);
>  	struct mlx5i_priv    *ipriv  = priv->ppriv;
> +	u8 addr_mod[3];
>  
>  	/* Set dev address using underlay QP */
> -	dev->dev_addr[1] = (ipriv->qpn >> 16) & 0xff;
> -	dev->dev_addr[2] = (ipriv->qpn >>  8) & 0xff;
> -	dev->dev_addr[3] = (ipriv->qpn) & 0xff;
> +	addr_mod[0] = (ipriv->qpn >> 16) & 0xff;
> +	addr_mod[1] = (ipriv->qpn >>  8) & 0xff;
> +	addr_mod[2] = (ipriv->qpn) & 0xff;
> +	dev_addr_mod(dev, 1, addr_mod, sizeof(addr_mod));
                         ^^^ It should be 0, no?

>  
>  	/* Add QPN to net-device mapping to HT */
>  	mlx5i_pkey_add_qpn(dev, ipriv->qpn);
> -- 
> 2.31.1
> 
