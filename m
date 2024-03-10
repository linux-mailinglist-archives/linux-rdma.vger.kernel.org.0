Return-Path: <linux-rdma+bounces-1359-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D73087760D
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 11:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25AC4B2127A
	for <lists+linux-rdma@lfdr.de>; Sun, 10 Mar 2024 10:15:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5CE61EA71;
	Sun, 10 Mar 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTqzOiqX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71BEC208C8;
	Sun, 10 Mar 2024 10:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710065696; cv=none; b=dO6KkuP4TRDzzHoVIItdLyj6jywwp2VDnR08dwOb24Xwn+dDmKwTDvh8Z8t7GxPtSTkuZpIE7/v2FDHaqn8Br0igmHFavF4bXrrWHW3miMr053AoesGfkqWj0TcYj60UGNI0NFh2BdOfWE0jfEctYcCALFo/Jwn2oqmf+ZRB7F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710065696; c=relaxed/simple;
	bh=JoAFWb9nLtYnlHB1SCF0D6+9Y9U1vP862qBb0QXiCVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YsM0x4zUO9Bh2Wutkx4ieAZbqzyz/rUL31HTp4skrx7d8Pbpy1oB8oxPbbm1ZcDT+RJK2HY+Ly430e+1hxdWPqFwlu4uqbzEfECzN/mwijeApysJDSE3dWOFklBtNEE95wy2tGwHyPLk2gvlOtPeE9nr+DfqMJxQV3fRGFHxRxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTqzOiqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE4BC433F1;
	Sun, 10 Mar 2024 10:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710065696;
	bh=JoAFWb9nLtYnlHB1SCF0D6+9Y9U1vP862qBb0QXiCVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MTqzOiqXSKiBKyjZUmMnLGM2bCvM/Sjh4eK3npbXK7/mFi5qgxjaWsTtqHLKorVgR
	 nBHcSE+d3nK+DVqEF/dk15uAvtn76runMyEKa8is37KHzEtglUlTqwP4ZJLeUPUyGe
	 sv74xu5DJUFaKRK043v5JVn1+FckJnxLsGkwYODYXGvRfhz83cB8zDaqHZkZo2wEOJ
	 kLoBvYFapC2KHC0fdONZe2Rk2s6R/6f5UQIjQjvpGXK0l3N43RVRibsKN8HyUJyYX3
	 LT3ppqUl1IZDj2IiaWvmYJMpUp980WUQpnD1OSItf1efQgkdAhiqXIF5fK+DET45j7
	 GHyVws8wsBZiw==
Date: Sun, 10 Mar 2024 12:14:51 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, kuba@kernel.org,
	keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <20240310101451.GD12921@unreal>
References: <20240308182951.2137779-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308182951.2137779-1-leitao@debian.org>

On Fri, Mar 08, 2024 at 10:29:50AM -0800, Breno Leitao wrote:
> struct net_device shouldn't be embedded into any structure, instead,
> the owner should use the priv space to embed their state into net_device.

Why?

> 
> Embedding net_device into structures prohibits the usage of flexible
> arrays in the net_device structure. For more details, see the discussion
> at [1].
> 
> Un-embed the net_device from struct iwl_trans_pcie by converting it
> into a pointer. Then use the leverage alloc_netdev() to allocate the
> net_device object at iwl_trans_pcie_alloc.
> 
> The private data of net_device becomes a pointer for the struct
> iwl_trans_pcie, so, it is easy to get back to the iwl_trans_pcie parent
> given the net_device object.
> 
> [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/infiniband/hw/hfi1/netdev.h    | 2 +-
>  drivers/infiniband/hw/hfi1/netdev_rx.c | 9 +++++++--
>  2 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hfi1/netdev.h b/drivers/infiniband/hw/hfi1/netdev.h
> index 8aa074670a9c..07c8f77c9181 100644
> --- a/drivers/infiniband/hw/hfi1/netdev.h
> +++ b/drivers/infiniband/hw/hfi1/netdev.h
> @@ -49,7 +49,7 @@ struct hfi1_netdev_rxq {
>   *		When 0 receive queues will be freed.
>   */
>  struct hfi1_netdev_rx {
> -	struct net_device rx_napi;
> +	struct net_device *rx_napi;
>  	struct hfi1_devdata *dd;
>  	struct hfi1_netdev_rxq *rxq;
>  	int num_rx_q;
> diff --git a/drivers/infiniband/hw/hfi1/netdev_rx.c b/drivers/infiniband/hw/hfi1/netdev_rx.c
> index 720d4c85c9c9..5c26a69fa2bb 100644
> --- a/drivers/infiniband/hw/hfi1/netdev_rx.c
> +++ b/drivers/infiniband/hw/hfi1/netdev_rx.c
> @@ -188,7 +188,7 @@ static int hfi1_netdev_rxq_init(struct hfi1_netdev_rx *rx)
>  	int i;
>  	int rc;
>  	struct hfi1_devdata *dd = rx->dd;
> -	struct net_device *dev = &rx->rx_napi;
> +	struct net_device *dev = rx->rx_napi;
>  
>  	rx->num_rx_q = dd->num_netdev_contexts;
>  	rx->rxq = kcalloc_node(rx->num_rx_q, sizeof(*rx->rxq),
> @@ -360,7 +360,11 @@ int hfi1_alloc_rx(struct hfi1_devdata *dd)
>  	if (!rx)
>  		return -ENOMEM;
>  	rx->dd = dd;
> -	init_dummy_netdev(&rx->rx_napi);
> +	rx->rx_napi = alloc_netdev(sizeof(struct iwl_trans_pcie *),
> +				   "dummy", NET_NAME_UNKNOWN,

Will it create multiple "dummy" netdev in the system? Will all devices
have the same "dummy" name?

> +				   init_dummy_netdev);
> +	if (!rx->rx_napi)
> +		return -ENOMEM;

You forgot to release previously allocated "rx" here.

Thanks

>  
>  	xa_init(&rx->dev_tbl);
>  	atomic_set(&rx->enabled, 0);
> @@ -374,6 +378,7 @@ void hfi1_free_rx(struct hfi1_devdata *dd)
>  {
>  	if (dd->netdev_rx) {
>  		dd_dev_info(dd, "hfi1 rx freed\n");
> +		free_netdev(dd->netdev_rx->rx_napi);
>  		kfree(dd->netdev_rx);
>  		dd->netdev_rx = NULL;
>  	}
> -- 
> 2.43.0
> 

