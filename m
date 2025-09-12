Return-Path: <linux-rdma+bounces-13315-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE40B55073
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 16:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32CD164D4E
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Sep 2025 14:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE88130F7F6;
	Fri, 12 Sep 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIhbFgsN"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2B27472;
	Fri, 12 Sep 2025 14:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757686147; cv=none; b=iO1MOOgG36p4lGf43JmguQy/TN0Ig14Cb8fNJH7SXnCNIM3wnZyJl/qTzOMcYvYuYyZzEj9OKywgR3vIm+zKjZdROjJfKqQ6WvUQ5K2Ea2zof1eawwoSqLc3zA5d6R8zJnCigjXNigpH52Z9W3cz3Yg+HLp1SFBb7Q5gMCsyS3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757686147; c=relaxed/simple;
	bh=8KzDjALzo8xyyPxdB0VGYT1Iqlg4ome+voJh7zshsT4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHOERMfv6Y+NR0bCPvJcekCEBmmC9zmJ+KtTXY0SG9qWqj8FZX80a6pcVgwDrwwHGstAjjw2Xw8FdMbILAaVdNtmCLo1o4EgN9Q9ot7QvYTHgJ58hjFiMjoBlF9iOzGJv+e+uwBTtPDT848pXAc/94OY6qH60khChKen6mtcvAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIhbFgsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D7A2C4CEF1;
	Fri, 12 Sep 2025 14:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757686147;
	bh=8KzDjALzo8xyyPxdB0VGYT1Iqlg4ome+voJh7zshsT4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AIhbFgsNZzwTeZi8P89hgzRTWGtS3aOMf63RbPxk4jAuUpRgec8QYvEhJ7fbs/W6w
	 lJzwwJ8Fyl6ODs3YLjX55rSkKEf3p/p9s+P6bnDgFP5VgLx0N5WPXdHPaRxUstKk4A
	 J5U3DeYTMYYXmQW5qdz/g8+xtqwAKAs8vMUxYF2dMgfQX9p7h5a+H4FIoEOq8a3KCD
	 OPdDGmeURfMNWXORrrhYwl8kFrAhWKx7cLu4gXICW0y/SeANQ/jsbeFkDxtreLF05z
	 3zfKtxNV7d/Mpi4vuGDebulNtmHHnwZRrlQFtiBWWbii2dZ+tsh5dqhCFoRNlp0dz4
	 5SD2jFvwbUV5w==
Date: Fri, 12 Sep 2025 15:09:02 +0100
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
	Parav Pandit <parav@nvidia.com>, Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net-next 4/4] net/mlx5: Lag, add net namespace support
Message-ID: <20250912140902.GC30363@horms.kernel.org>
References: <1757572267-601785-1-git-send-email-tariqt@nvidia.com>
 <1757572267-601785-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757572267-601785-5-git-send-email-tariqt@nvidia.com>

On Thu, Sep 11, 2025 at 09:31:07AM +0300, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Update the LAG implementation to support net namespace isolation.
> 
> With recent changes to the devcom framework allowing namespace-aware
> matching, the LAG layer is updated to register devcom clients with the
> associated net namespace. This ensures that LAG formation only occurs
> between mlx5 interfaces that reside in the same namespace.
> 
> This change ensures that devices in different namespaces do not interfere
> with each other's LAG setup and behavior. For example, if two PCI PFs are
> in the same namespace, they are eligible to form a hardware LAG.
> 
> In addition, reload behavior for LAG is adjusted to handle namespace
> contexts appropriately.
> 
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Reviewed-by: Parav Pandit <parav@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/devlink.c |  5 -----
>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 14 +++++++++++---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h |  1 +
>  3 files changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> index a0b68321355a..bfa44414be82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/devlink.c
> @@ -204,11 +204,6 @@ static int mlx5_devlink_reload_down(struct devlink *devlink, bool netns_change,
>  		return 0;
>  	}
>  
> -	if (mlx5_lag_is_active(dev)) {
> -		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported in Lag mode");
> -		return -EOPNOTSUPP;
> -	}
> -

Maybe I'm missing something obvious. But I think this could do with
some further commentary in the commit message. Or perhaps being a separate
patch.

>  	if (mlx5_core_is_mp_slave(dev)) {
>  		NL_SET_ERR_MSG_MOD(extack, "reload is unsupported for multi port slave");
>  		return -EOPNOTSUPP;

...

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index c2f256bb2bc2..4918eee2b3da 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -67,6 +67,7 @@ struct mlx5_lag {
>  	struct workqueue_struct   *wq;
>  	struct delayed_work       bond_work;
>  	struct notifier_block     nb;
> +	possible_net_t net;

nit: inconsistent indentation.

>  	struct lag_mp             lag_mp;
>  	struct mlx5_lag_port_sel  port_sel;
>  	/* Protect lag fields/state changes */
> -- 
> 2.31.1
> 
> 

