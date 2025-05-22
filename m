Return-Path: <linux-rdma+bounces-10559-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CEEAC14B8
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 21:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8492D3B4528
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 19:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF0E2BCF4C;
	Thu, 22 May 2025 19:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y38/ya5l"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2B962BCF48;
	Thu, 22 May 2025 19:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747941416; cv=none; b=VScPfiwHbY87Y1bVFx92FBPLc/i11ij4rl01pETIZevNr2vPXmFWODb0NP6yyRBSpKolIFyUcOMOjMMNXqyqGZ7UWp5gajtvbMCWnYlmOj2+9XlGFNGzPzOacklhXdi15Chka4vQlkKl1q61Br+l4aynUY76HzB6iPUpNGTYzhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747941416; c=relaxed/simple;
	bh=jpP/8y9hWQDp+QUrnRhuh/0/iscikc2TEjFcArObSGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ounIPrNhO+JMCYHCy2+rWJAEEbLIA+q6cksYkxg01dITLf5QVtyZqEuopxZiSvK9PruSI4WXypib48Q6GS4T4Krr+8g47NCUHn+MhEbCZwqrvLuM8Z6qU/3869uWXNBuyHMHkaZ4qNP+lzvV5pdWIDvJyrvxj25gVpA18KqiYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y38/ya5l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74FBDC16AAE;
	Thu, 22 May 2025 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747941416;
	bh=jpP/8y9hWQDp+QUrnRhuh/0/iscikc2TEjFcArObSGg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y38/ya5l3bsy3cnZM+uFbU3q8PPIvEtgzKVyNh1tYYJ8xLNyTBZb5GkHgBFM57V9I
	 qH35cfxTMUL6zdp6ZEucwpev2r+LSLrxHOv5iy8vErP+OoIvPdmSUrPSV+tfVdHOan
	 ZGSIKsJ00/zNvJlH5jfoBAnWY4AGc9m9Hei4RaJp71lRaX3nq7y7F/hidn/kkjQc9O
	 XlOufCcEjZAR7MsN5JFtyzOWiVx/9pytrJKs3QOMC8JUIxLDnYnPcuKG++N3z1Qmg2
	 m/qD8u3LE7bDdOtDmwImKl58Lz7TV4nCYRRFwBAcmggKwrC9SPPNhBbYY5GwbcrBU5
	 vKQfmze0SK20Q==
Date: Thu, 22 May 2025 20:16:51 +0100
From: Simon Horman <horms@kernel.org>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	Gal Pressman <gal@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>
Subject: Re: [PATCH net 2/2] net/mlx5e: Fix leak of Geneve TLV option object
Message-ID: <20250522191651.GL365796@horms.kernel.org>
References: <1747895286-1075233-1-git-send-email-tariqt@nvidia.com>
 <1747895286-1075233-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1747895286-1075233-3-git-send-email-tariqt@nvidia.com>

On Thu, May 22, 2025 at 09:28:06AM +0300, Tariq Toukan wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Previously, a unique tunnel id was added for the matching on TC
> non-zero chains, to support inner header rewrite with goto action.
> Later, it was used to support VF tunnel offload for vxlan, then for
> Geneve and GRE. To support VF tunnel, a temporary mlx5_flow_spec is
> used to parse tunnel options. For Geneve, if there is TLV option, a
> object is created, or refcnt is added if already exists. But the
> temporary mlx5_flow_spec is directly freed after parsing, which causes
> the leak because no information regarding the object is saved in
> flow's mlx5_flow_spec, which is used to free the object when deleting
> the flow.
> 
> To fix the leak, call mlx5_geneve_tlv_option_del() before free the
> temporary spec if it has TLV object.
> 
> Fixes: 521933cdc4aa ("net/mlx5e: Support Geneve and GRE with VF tunnel offload")
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en_tc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> index f1d908f61134..b9c1d7f8f05c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
> @@ -2028,9 +2028,8 @@ mlx5e_tc_add_fdb_flow(struct mlx5e_priv *priv,
>  	return err;
>  }
>  
> -static bool mlx5_flow_has_geneve_opt(struct mlx5e_tc_flow *flow)
> +static bool mlx5_flow_has_geneve_opt(struct mlx5_flow_spec *spec)
>  {
> -	struct mlx5_flow_spec *spec = &flow->attr->parse_attr->spec;
>  	void *headers_v = MLX5_ADDR_OF(fte_match_param,
>  				       spec->match_value,
>  				       misc_parameters_3);
> @@ -2069,7 +2068,7 @@ static void mlx5e_tc_del_fdb_flow(struct mlx5e_priv *priv,
>  	}
>  	complete_all(&flow->del_hw_done);
>  
> -	if (mlx5_flow_has_geneve_opt(flow))
> +	if (mlx5_flow_has_geneve_opt(&attr->parse_attr->spec))
>  		mlx5_geneve_tlv_option_del(priv->mdev->geneve);
>  
>  	if (flow->decap_route)

Hi,

The lines leading up to the hung below are:

	      err = mlx5e_tc_tun_parse(filter_dev, priv, tmp_spec, f, match_level);
              if (err) {
                        kvfree(tmp_spec);
                        NL_SET_ERR_MSG_MOD(extack, "Failed to parse tunnel attributes");
                        netdev_warn(priv->netdev, "Failed to parse tunnel attributes");

I am wondering if the same resource leak described in the patch description
can occur if mlx5e_tc_tun_parse() fails after it successfully calls
tunnel->parse_tunnel().

> @@ -2580,6 +2579,8 @@ static int parse_tunnel_attr(struct mlx5e_priv *priv,
>  			return err;
>  		}
>  		err = mlx5e_tc_set_attr_rx_tun(flow, tmp_spec);
> +		if (mlx5_flow_has_geneve_opt(tmp_spec))
> +			mlx5_geneve_tlv_option_del(priv->mdev->geneve);
>  		kvfree(tmp_spec);
>  		if (err)
>  			return err;
> -- 
> 2.31.1
> 
> 

