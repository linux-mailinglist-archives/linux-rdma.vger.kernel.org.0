Return-Path: <linux-rdma+bounces-14065-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97AD4C0DD95
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 14:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11120405650
	for <lists+linux-rdma@lfdr.de>; Mon, 27 Oct 2025 13:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955C92566DD;
	Mon, 27 Oct 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEbq8ce0"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133825393B;
	Mon, 27 Oct 2025 12:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761569981; cv=none; b=ZL7MJ98qjq1cVp22WsCMqQ5jjE2RW6qP47qX9w1/YMP70vzmJSyDB830Xm7WSFu3ms3BKr4eC9l5zOSeCnfnNAzsdXW9miJDYLYyhPRQrpAwhXC1I/5wA6rQZ+dHcYFwCjVnxlpj4i+Spmh/WanUqvJ3zY31EZDFBsq0FU0vC9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761569981; c=relaxed/simple;
	bh=eW1OcFnqyrp5QQ5y5xmXHAC1ZnTIFdjryrwStarra9w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upwZLg+iBlVG2Qrad7nVFSKtPNEIuci0U0eVYNHcHb49qKuVzYUtH1/Y7/NflOnvBEaeTQAHhTdF/oZQr/y9PzQAJUGSwOY37Q5212spBelEZ/Tw9lJEXCu2Pr0WvpH9YQFdAO15NF5F8i9taWr9yvoHJjAJ/c6WHHysCOZm4EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEbq8ce0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E42AC4CEF1;
	Mon, 27 Oct 2025 12:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761569980;
	bh=eW1OcFnqyrp5QQ5y5xmXHAC1ZnTIFdjryrwStarra9w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEbq8ce0cOWHXvIHjN2VMb0Zka5H2ureVvPVX4PMYFAdA6ypmvwLO76hT0X4ryBh8
	 LRT+MiHpJ0RILflN1BlWFd5xlcgrUOhlYB4FnZ2wekESZmLkpZQtc6W+dJfQwDRHvQ
	 9/q3d5nf3HAdYjYg/df2Q/xh6pJ5qJT5qg0aYh3WzmHTebjMYrFyLqY9MKxXXqaWjk
	 wEhowhBZz5mQ9qP+hTHR0auxsM20Cdd2yiMpequj5rJmhdMfpxZS7Wt+KE6xX5aojg
	 7hJFv4kiTgyw4gqU563jVp18sWDesGamk6s+seJgwRFSpVTE/Q7YZ7w3zUIFBrSItH
	 6E4cpRZVltz+Q==
Date: Mon, 27 Oct 2025 14:59:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Shuhao Fu <sfual@cse.ust.hk>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RDMA/mlx5: Fix refcount inconsistency in
 mlx5_netdev_event
Message-ID: <20251027125935.GJ12554@unreal>
References: <aPe3mnFjQeXaILyR@chcpu18>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPe3mnFjQeXaILyR@chcpu18>

On Tue, Oct 21, 2025 at 04:40:58PM +0000, Shuhao Fu wrote:
> Fix refcount inconsistency related to `mlx5_ib_get_native_port_mdev`.
> 
> Function `mlx5_ib_get_native_port_mdev` could increase the counter of 
> `mpi->mdev_refcnt` if mpi is not master. To ensure refcount consistency,
> each call to `mlx5_ib_get_native_port_mdev` should have a corresponding
> call to `mlx5_ib_put_native_port_mdev`. In `mlx5_netdev_event`, two
> branches fail to do so, leading to a possible bug when unbinding.
> 
> Fixes: 379013776222 ("RDMA/mlx5: Handle link status event only for LAG device")
> Fixes: 35b0aa67b298 ("RDMA/mlx5: Refactor netdev affinity code")
> Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
> ---
>  drivers/infiniband/hw/mlx5/main.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
> index fc1e86f6c..0c4aa7c50 100644
> --- a/drivers/infiniband/hw/mlx5/main.c
> +++ b/drivers/infiniband/hw/mlx5/main.c
> @@ -247,7 +247,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
>  
>  		if (!netif_is_lag_master(ndev) && !netif_is_lag_port(ndev) &&
>  		    !mlx5_core_mp_enabled(mdev))
> -			return NOTIFY_DONE;
> +			goto done;

mdev_refcnt is increased only for MPV slave, but here we are checking if
MPV is enabled. It is not in this leaf and "return NOTIFY_DONE" is the
right thing to do.

>  
>  		if (mlx5_lag_is_roce(mdev) || mlx5_lag_is_sriov(mdev)) {
>  			struct net_device *lag_ndev;
> @@ -268,7 +268,7 @@ static int mlx5_netdev_event(struct notifier_block *this,
>  		if (ibdev->is_rep)
>  			roce = mlx5_get_rep_roce(ibdev, ndev, upper, &port_num);
>  		if (!roce)
> -			return NOTIFY_DONE;
> +			goto done;

It is not MPV flow either. There is nothing to change here.

Thanks

>  
>  		ib_ndev = ib_device_get_netdev(&ibdev->ib_dev, port_num);
>  
> -- 
> 2.39.5 (Apple Git-154)
> 

