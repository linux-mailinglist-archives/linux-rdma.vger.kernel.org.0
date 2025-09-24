Return-Path: <linux-rdma+bounces-13629-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC907B9ADD6
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 18:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CF5BE4E138D
	for <lists+linux-rdma@lfdr.de>; Wed, 24 Sep 2025 16:21:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F72313D45;
	Wed, 24 Sep 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ES7lIF7a"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1448B30E823;
	Wed, 24 Sep 2025 16:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758730913; cv=none; b=cU9+XIR3jWUIM79OzgAROi3r0gcAFKNM2HmOokUvs7r0wQWCpPRo7uaIfWys0UnRy4O4MoJfcjKsEnygDH1T/mAq/CAhrL5mWTP9HRW2qY71+Lpc0ndWsl59V9I0UVrTqPQVhJb27VJPTLZcG8CjUkv/RNxefBHfLHCHATRU/hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758730913; c=relaxed/simple;
	bh=ZbyqNUcz+bsad92zuKS5NXPfXO8YX6iGZ1pYcRh3eEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTSRaJAxGmULPtpLtWshCFMJGnwRZYIR3BjG2B1fqOlfiayXc0d+4hOKTjH+cNSl9x5CS8bR1DpuBprJ5WVLETvspzBwVjRh0VhAzrCZexgf+O7SofsgTUjZtfy6+U2vw5TKovSU4+0vDD+3q77scB6RGugsnLp7KQr/cX1cIMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ES7lIF7a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B55C4CEE7;
	Wed, 24 Sep 2025 16:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758730912;
	bh=ZbyqNUcz+bsad92zuKS5NXPfXO8YX6iGZ1pYcRh3eEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ES7lIF7aszufdp9L5L1j/Uzx/5RTDzasxs/PMj/8vTY0pimTLgYXZpzo+JFBwgr1M
	 AH+jA7kmbEgKpKCRR1Ti8Y5DVLrD1o6inAXl9lvdbky8ni2+RE7W+kNyCXrSdpuRK7
	 EL2gcn7NP43/aiy5N30IeY9yEacuGVekePV4JKHOVl2D83g7km9Bwmul3VxF369aNH
	 ZLFwMCQTNaRdBSqMcOKeE4J5jKWBwtIVBV/whrx8cp2go3FrbewYAu6x2ZsTEILdmH
	 1+qEY1b2I9M9o2UnrFCb5CzVM24jNGfFxwyGKC0shiD8R6wKZy80u+EDh4zcJl0+ew
	 rI5cly/fZa/ZA==
Date: Wed, 24 Sep 2025 17:21:48 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 7/7] net/mlx5e: Use extack in set rxfh callback
Message-ID: <20250924162148.GN836419@horms.kernel.org>
References: <1758531671-819655-1-git-send-email-tariqt@nvidia.com>
 <1758531671-819655-8-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1758531671-819655-8-git-send-email-tariqt@nvidia.com>

On Mon, Sep 22, 2025 at 12:01:11PM +0300, Tariq Toukan wrote:
> From: Gal Pressman <gal@nvidia.com>
> 
> The ->set_rxfh() callback now passes a valid extack instead of NULL
> through netlink [1]. In case of an error, reflect it through extack instead
> of a dmesg print.
> 
> [1]
> commit c0ae03588bbb ("ethtool: rss: initial RSS_SET (indirection table handling)")
> 
> Signed-off-by: Gal Pressman <gal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c  | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index d507366d773e..eb25b19b4a4a 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -1494,7 +1494,8 @@ static int mlx5e_get_rxfh(struct net_device *netdev, struct ethtool_rxfh_param *
>  }
>  
>  static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
> -				  const struct ethtool_rxfh_param *rxfh)
> +				  const struct ethtool_rxfh_param *rxfh,
> +				  struct netlink_ext_ack *extack)
>  {
>  	unsigned int count;
>  
> @@ -1504,8 +1505,10 @@ static int mlx5e_rxfh_hfunc_check(struct mlx5e_priv *priv,
>  		unsigned int xor8_max_channels = mlx5e_rqt_max_num_channels_allowed_for_xor8();
>  
>  		if (count > xor8_max_channels) {
> -			netdev_err(priv->netdev, "%s: Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
> -				   __func__, count, xor8_max_channels);
> +			NL_SET_ERR_MSG_FMT_MOD(
> +				extack,
> +				"Cannot set RSS hash function to XOR, current number of channels (%d) exceeds the maximum allowed for XOR8 RSS hfunc (%d)\n",
> +				count, xor8_max_channels);
>  			return -EINVAL;
>  		}
>  	}

Hi Tariq and Gal,

Coccinelle says: "WARNING avoid newline at end of message in NL_SET_ERR_MSG_FMT_MOD"

...

