Return-Path: <linux-rdma+bounces-6878-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D62A03C35
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 11:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B5637A2AD4
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2025 10:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464951E0DC0;
	Tue,  7 Jan 2025 10:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmNfU8nW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19FD1AAA10;
	Tue,  7 Jan 2025 10:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245331; cv=none; b=iMbv4rJ2J4G6V7gEKH8NBQpcYQ4p6W1Ddajodj929dipgtkIi95vqnTjhNMBSiOY+a8L76psdqpRZVpuZOhZoxvzt1PWmpMfmeLHeP5tHdt4DdlhVVHNW1Laz3YtQnp/FwKplY+rSZ3oMBRXCCkAsIX0cZSmu9jvz+KhvGiGSug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245331; c=relaxed/simple;
	bh=Wb3Ea2iB8+M8aL3ooVQ7LOltSr1/6YrzyALThhjx3TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BTtZ0mBlPpnKiSZrhwsLWjOuQjwsAeAbyNJBgMbd8t5ZqvtPvUnAlwJUP8sIzVCvvsINqmaJBnpfGzUSj3BSUefiJRk66zlHmMsBlaYOPkbNwdgltT1OpcGw0oBPleDZoVBG0Z2vrg5LGaeJzPm8yU3l2dBdTo8VIjyvEZIuaEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmNfU8nW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9714C4CED6;
	Tue,  7 Jan 2025 10:22:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736245329;
	bh=Wb3Ea2iB8+M8aL3ooVQ7LOltSr1/6YrzyALThhjx3TI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DmNfU8nWLBuNkkgcsPZZpv1EIaEoOmLXTmnqfJ7XOpK5AJw9NqvsA3rEgqpDN6KC5
	 EZ76YiWsYoDWHKtTxeQatN+C76DPga3faVhdtz65TJA1pNiNIDp0Xi9E6WR+HMIRIo
	 A9C/Bs8BYOMGaV2VDJhV4DblSUS6C6i2jFyeTgcJUtkzd1DFJq83UmW9OXwC4FiAiH
	 2sQXwWwCaUn+POtfJdpu4jlcDVJMVSi8iOJ7a2uhALOBAjd2aGCFULZQXV2Ga3JnHF
	 bCbT8o9lJWPYxp4wTD+je9bEbeDHVZL7Lxq9U+LW6fgyNsfouVZmYHAR6CWYr3+QuV
	 GTy4uwlc5HzZA==
Date: Tue, 7 Jan 2025 12:22:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: Jianbo Liu <jianbol@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, linux-rdma@vger.kernel.org,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>
Subject: Re: [PATCH ipsec-next 1/2] xfrm: Support ESN context update to
 hardware for TX
Message-ID: <20250107102204.GB87447@unreal>
References: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874f965d786606b0b4351c976f50271349f68b03.1734611621.git.leon@kernel.org>

On Thu, Dec 19, 2024 at 02:37:29PM +0200, Leon Romanovsky wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Previously xfrm_dev_state_advance_esn() was added for RX only. But
> it's possible that ESN context also need to be synced to hardware for
> TX, so call it for outbound in this patch.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  Documentation/networking/xfrm_device.rst                 | 3 ++-
>  drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c          | 3 +++
>  drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c | 3 +++
>  net/xfrm/xfrm_replay.c                                   | 1 +
>  4 files changed, 9 insertions(+), 1 deletion(-)

Steffen,

This is kindly reminder.

Thanks

> 
> diff --git a/Documentation/networking/xfrm_device.rst b/Documentation/networking/xfrm_device.rst
> index bfea9d8579ed..66f6e9a9b59a 100644
> --- a/Documentation/networking/xfrm_device.rst
> +++ b/Documentation/networking/xfrm_device.rst
> @@ -169,7 +169,8 @@ the stack in xfrm_input().
>  
>  	hand the packet to napi_gro_receive() as usual
>  
> -In ESN mode, xdo_dev_state_advance_esn() is called from xfrm_replay_advance_esn().
> +In ESN mode, xdo_dev_state_advance_esn() is called from
> +xfrm_replay_advance_esn() for RX, and xfrm_replay_overflow_offload_esn for TX.
>  Driver will check packet seq number and update HW ESN state machine if needed.
>  
>  Packet offload mode:
> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> index bc3af0054406..e56e4f238795 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -6559,6 +6559,9 @@ static void cxgb4_advance_esn_state(struct xfrm_state *x)
>  {
>  	struct adapter *adap = netdev2adap(x->xso.dev);
>  
> +	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
> +		return;
> +
>  	if (!mutex_trylock(&uld_mutex)) {
>  		dev_dbg(adap->pdev_dev,
>  			"crypto uld critical resource is under use\n");
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> index ca92e518be76..3dd4f2492090 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c
> @@ -980,6 +980,9 @@ static void mlx5e_xfrm_advance_esn_state(struct xfrm_state *x)
>  	struct mlx5e_ipsec_sa_entry *sa_entry_shadow;
>  	bool need_update;
>  
> +	if (x->xso.dir != XFRM_DEV_OFFLOAD_IN)
> +		return;
> +
>  	need_update = mlx5e_ipsec_update_esn_state(sa_entry);
>  	if (!need_update)
>  		return;
> diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
> index bc56c6305725..e500aebbad22 100644
> --- a/net/xfrm/xfrm_replay.c
> +++ b/net/xfrm/xfrm_replay.c
> @@ -729,6 +729,7 @@ static int xfrm_replay_overflow_offload_esn(struct xfrm_state *x, struct sk_buff
>  		}
>  
>  		replay_esn->oseq = oseq;
> +		xfrm_dev_state_advance_esn(x);
>  
>  		if (xfrm_aevent_is_on(net))
>  			xfrm_replay_notify(x, XFRM_REPLAY_UPDATE);
> -- 
> 2.47.0
> 
> 

