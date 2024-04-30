Return-Path: <linux-rdma+bounces-2162-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5153B8B76BA
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 15:16:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFD491F23397
	for <lists+linux-rdma@lfdr.de>; Tue, 30 Apr 2024 13:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59F49171666;
	Tue, 30 Apr 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAskZIZ8"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D91013D29F;
	Tue, 30 Apr 2024 13:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482970; cv=none; b=gybEaHrl+4BvIXrQMsnXAgKA3XTDeD8wj0/65pAAbDAkr1Kra1p2wA4m49qhPsKRkhtbKiMfjlOPWhSmraWkBN6CQZVZFxF8lHJZiUpujXIqtpZEbEsyaSw+nOb0odwRONhNLKYulaq20hibF3OfERUofp5U4DnPipikiWNHPPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482970; c=relaxed/simple;
	bh=m4PDQS6dCjFdhvSkpno1HuCOXMV1R50c9t6y5djkfB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aafPD3tmNjrn8lz6Umf5syWoA5czKO/e8AGMY8SzdTd9dT3WR6LGsg5u+vMlBWXDp1NAESqB/UXF4Amx/H3Ezor3KmPrpxrNm6mzPFbq/svA7+8HrncX6r0EMJ2L+fLZCpK9HaUuuwLEb58A4Nnz8DblF1Fjzc28QaOMzzlEfFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAskZIZ8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04057C2BBFC;
	Tue, 30 Apr 2024 13:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714482968;
	bh=m4PDQS6dCjFdhvSkpno1HuCOXMV1R50c9t6y5djkfB0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qAskZIZ8pwWCoU3ltxokrJW8TjpzHOrRZpAJz8BwDw1Yi/W5Vfp3/0KiSrWUSllMn
	 xxs/Q9cUbU4uYX+0RdHOfEHYDEH7VuKr3J3wZCctDwhILXa+FD3dy1It2BTwXbCI9c
	 E/OJ12aNUhdTrj9fZK0FmB0jAbRK9dMXY0Wj6e6s8sYqFu1ICQIQA22RfcsblK7ioO
	 T/M/S/ujajpy0kUBS/3cDJSACA4wdj4mM+lNQ2ZqFs0wPgOqpCSB7MzXYAPm7Bj+d7
	 oVeZtkMuTAax2z9KUQOmh008OqTI3z2p+tRmmLZ1RRrYoSQOxOyrTTFJYGQOSNJP2I
	 MkxwM96pRWnKA==
Date: Tue, 30 Apr 2024 16:16:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jules Irenge <jbi.octave@gmail.com>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/mlx5e: Remove NULL check before dev_{put, hold}
Message-ID: <20240430131603.GF100414@unreal>
References: <Zi5NUDItYAyDGdwV@octinomon.home>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zi5NUDItYAyDGdwV@octinomon.home>

On Sun, Apr 28, 2024 at 02:21:20PM +0100, Jules Irenge wrote:
> Coccinelle reports a warning
> 
> WARNING: NULL check before dev_{put, hold} functions is not needed
> 
> The reason is the call netdev_{put, hold} of dev_{put,hold} will check NULL
> There is no need to check before using dev_{put, hold}
> 
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
> index 8dfb57f712b0..f23d7116e6d8 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun.c
> @@ -68,16 +68,14 @@ static int get_route_and_out_devs(struct mlx5e_priv *priv,
>  	 * while holding rcu read lock. Take the net_device for correctness
>  	 * sake.
>  	 */
> -	if (uplink_upper)
> -		dev_hold(uplink_upper);
> +	dev_hold(uplink_upper);

I see same if (..) dev_hold() in drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c too.

>  	rcu_read_unlock();
>  
>  	dst_is_lag_dev = (uplink_upper &&
>  			  netif_is_lag_master(uplink_upper) &&
>  			  real_dev == uplink_upper &&
>  			  mlx5_lag_is_sriov(priv->mdev));
> -	if (uplink_upper)
> -		dev_put(uplink_upper);
> +	dev_put(uplink_upper);

This pattern exists in other places in the same file and others too.

Let's change all of them in one patch.

Thanks

>  
>  	/* if the egress device isn't on the same HW e-switch or
>  	 * it's a LAG device, use the uplink
> -- 
> 2.43.2
> 
> 

