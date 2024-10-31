Return-Path: <linux-rdma+bounces-5646-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D62809B7632
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 09:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 824BA1F22D20
	for <lists+linux-rdma@lfdr.de>; Thu, 31 Oct 2024 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6839614C5A1;
	Thu, 31 Oct 2024 08:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sve0gstQ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F284E14
	for <linux-rdma@vger.kernel.org>; Thu, 31 Oct 2024 08:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730362689; cv=none; b=N+sA7wbHsPR+3xt2cWl1KrF1yVEHD4lPMiKOB9FYoqNRAVTNaZo+ka3LgYQk/49PRWnB5qdedBEwX+UOFT7AcNtqKa27gvfdWtCyLIUnnpmWZo//sdvejErNsHrEQwU8M6UOWCYlk2p7CoiQjcevbbn/hrO3PXG5RP3+j2c1CUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730362689; c=relaxed/simple;
	bh=FOOi+slq812vDc56o5qKan/wO2GMieT1qxQuQq7bl5I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwOQ0wcaMIy02LOG9yTxCWLRw6ePllVqGSlcvbDhlfB8Krf2nrbTMK9GWjIFNiVgSuRZDM8G71g5G4G6ZRu2Zo/aVRh+KA/kitGsiibMLbtbvwxQM2qWyrRIfPmUMoADMNe5eQnSAQX8fgEtrwtA6MTkTkgN0jCKTx1oMpBmjxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sve0gstQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 167CEC4CED0;
	Thu, 31 Oct 2024 08:18:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730362688;
	bh=FOOi+slq812vDc56o5qKan/wO2GMieT1qxQuQq7bl5I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sve0gstQYgv4vs8rJU6cUNbVMlMxorfd4bEM7XGZrQFdXzo2vR9JlYP4KH0mPqZ7r
	 FPdriKjFpm05jefEE4FfI3r38ZYinmIYPR3JyaHHUtU+SeG9sHrVMtUdWFCDiCEjhJ
	 iCu16jVpSKwvp12E1lT0BXS3IRoGeAqCZ8vT3k8QtJa+L9H7pSMbt9HIdg2k8XmbUs
	 4Iq9/Zgxv1UakZUNrLUMYwSyQIJMijU/5r1iCrRdSd0DJBW+EhjkYVSud2CICgOwr6
	 c7cDlMfILpmdX7Y6zRvd4ll0DEVodJ5Y9yfdKFv+RdrkQrDoyja4csr6qPXQUWuaLy
	 tHvF7cLjiZPbg==
Date: Thu, 31 Oct 2024 10:18:03 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: yishaih@nvidia.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 1/1] RDMA/mlx4: Use IB get_netdev functions and remove
 get_netdev callback
Message-ID: <20241031081803.GB7473@unreal>
References: <20241031073914.2368421-1-yanjun.zhu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031073914.2368421-1-yanjun.zhu@linux.dev>

On Thu, Oct 31, 2024 at 08:39:14AM +0100, Zhu Yanjun wrote:
> In the commit 8d159eb2117b ("RDMA/mlx5: Use IB set_netdev and get_netdev
> functions") removed the get_netdev callback from
> mlx5_ib_dev_common_roce_ops, in mlx4, get_netdev callback should also
> be removed.

It wasn't simple remove in mlx5, but an end result of long series to set
right netdev in LAG mode.

The similar thing needs to be done to mlx4, where you should set right
netdev in bond mode.

Thanks

> 
> Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
> ---
> compile successfully only
> ---
> ---
>  drivers/infiniband/hw/mlx4/main.c | 35 -------------------------------
>  1 file changed, 35 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx4/main.c b/drivers/infiniband/hw/mlx4/main.c
> index 529db874d67c..cf34d92de7b1 100644
> --- a/drivers/infiniband/hw/mlx4/main.c
> +++ b/drivers/infiniband/hw/mlx4/main.c
> @@ -123,40 +123,6 @@ static int num_ib_ports(struct mlx4_dev *dev)
>  	return ib_ports;
>  }
>  
> -static struct net_device *mlx4_ib_get_netdev(struct ib_device *device,
> -					     u32 port_num)
> -{
> -	struct mlx4_ib_dev *ibdev = to_mdev(device);
> -	struct net_device *dev, *ret = NULL;
> -
> -	rcu_read_lock();
> -	for_each_netdev_rcu(&init_net, dev) {
> -		if (dev->dev.parent != ibdev->ib_dev.dev.parent ||
> -		    dev->dev_port + 1 != port_num)
> -			continue;
> -
> -		if (mlx4_is_bonded(ibdev->dev)) {
> -			struct net_device *upper;
> -
> -			upper = netdev_master_upper_dev_get_rcu(dev);
> -			if (upper) {
> -				struct net_device *active;
> -
> -				active = bond_option_active_slave_get_rcu(netdev_priv(upper));
> -				if (active)
> -					dev = active;
> -			}
> -		}
> -
> -		dev_hold(dev);
> -		ret = dev;
> -		break;
> -	}
> -
> -	rcu_read_unlock();
> -	return ret;
> -}
> -
>  static int mlx4_ib_update_gids_v1(struct gid_entry *gids,
>  				  struct mlx4_ib_dev *ibdev,
>  				  u32 port_num)
> @@ -2544,7 +2510,6 @@ static const struct ib_device_ops mlx4_ib_dev_ops = {
>  	.get_dev_fw_str = get_fw_ver_str,
>  	.get_dma_mr = mlx4_ib_get_dma_mr,
>  	.get_link_layer = mlx4_ib_port_link_layer,
> -	.get_netdev = mlx4_ib_get_netdev,
>  	.get_port_immutable = mlx4_port_immutable,
>  	.map_mr_sg = mlx4_ib_map_mr_sg,
>  	.mmap = mlx4_ib_mmap,
> -- 
> 2.34.1
> 
> 

