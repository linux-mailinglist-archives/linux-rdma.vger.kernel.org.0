Return-Path: <linux-rdma+bounces-9731-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2882A9879D
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 12:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B5211B66DD0
	for <lists+linux-rdma@lfdr.de>; Wed, 23 Apr 2025 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72FA26B949;
	Wed, 23 Apr 2025 10:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QQNzGFZE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B854E26982A;
	Wed, 23 Apr 2025 10:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745404475; cv=none; b=MLp5eG2ew6Kd1k2VQpiS7EnrRIKZ60rdtbMN+aZlvXwOQpPJV8Z5tsNbUvTn0mgx57mvxJgOeSw4vh+wxdzW+ruzOZTqZKxpf1+SBTc4Dt7ETRI95XSVpIBefOPIP/j3841p5jiGochnJYljy3XTQk3FT/Vek7Z5DcbgnUoau58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745404475; c=relaxed/simple;
	bh=1RB7NIL91XUf2k6m8r8JVyagzIj5xdzoJ5ohhRrl3a8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H8yp2MDA3L+heDYim+5ncnnoT3IhU+Vhx3LLzm6wwbmleiPliUOoSelTZ+uXY70fMCyIBptYVoMk6+h4PHOegvuUyP2K5S4X3V1pWFvbXTVOWH0P2Alve4y6YQW6AAsZTDi1dDD5wLndtyT6/fx48lDzfQzAYtLWA8Edu2kl0YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QQNzGFZE; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745404474; x=1776940474;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1RB7NIL91XUf2k6m8r8JVyagzIj5xdzoJ5ohhRrl3a8=;
  b=QQNzGFZEUJiX+1FoWe2Lqj539/1RN55WVxgy5V5kFfa1fVPtVZcq1+5c
   S2Dv+KO0WN27WpVz9lCLj9j/VYkgg48zpu6D0QAJ3MYxDOpaXZF4iwMzW
   UwYuQJOrk7yne2fys5VBwlJGNPeytAwppnXRJv3GOh+MpaQwY9v/GY3na
   QoQ2t/a3w+Du0zVug4vF4YqF/g2ldgWLiDUd+/C23Hu9zGZ7VZlvL9E2F
   qSr0n9CjO3FFvXwbmMBbTNI/z550IuuPhoPbP+KquhY0RW/ojfLGpmpLt
   L0nVd+ircr8WoYJyhUvkCuyz6xeUEj1kr4jfn3HrIaTbsgi6Zht3s/KtK
   w==;
X-CSE-ConnectionGUID: STpmY10FSuabNHbmfCnYCA==
X-CSE-MsgGUID: FVuFOoF8TyOIefVCUixuJQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11411"; a="57980407"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="57980407"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 03:34:33 -0700
X-CSE-ConnectionGUID: ChnanD1PQAiJuLHDknsfWA==
X-CSE-MsgGUID: cWUuRIhUSYivP4+B+XZ7QQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132810669"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 03:34:30 -0700
Date: Wed, 23 Apr 2025 12:34:08 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Mark Bloch <mbloch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Vlad Dogaru <vdogaru@nvidia.com>,
	Yevgeny Kliteynik <kliteyn@nvidia.com>
Subject: Re: [PATCH net 1/5] net/mlx5e: Use custom tunnel header for vxlan gbp
Message-ID: <aAjCIE/DMAlLZXGA@mev-dev.igk.intel.com>
References: <20250423083611.324567-1-mbloch@nvidia.com>
 <20250423083611.324567-2-mbloch@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423083611.324567-2-mbloch@nvidia.com>

On Wed, Apr 23, 2025 at 11:36:07AM +0300, Mark Bloch wrote:
> From: Vlad Dogaru <vdogaru@nvidia.com>
> 
> Symbolic (e.g. "vxlan") and custom (e.g. "tunnel_header_0") tunnels
> cannot be combined, but the match params interface does not have fields
> for matching on vxlan gbp. To match vxlan bgp, the tc_tun layer uses
> tunnel_header_0.
> 
> Allow matching on both VNI and GBP by matching the VNI with a custom
> tunnel header instead of the symbolic field name.
> 
> Matching solely on the VNI continues to use the symbolic field name.
> 
> Fixes: 74a778b4a63f ("net/mlx5: HWS, added definers handling")
> Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
> Reviewed-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
> Signed-off-by: Mark Bloch <mbloch@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en/tc_tun_vxlan.c      | 32 +++++++++++++++++--
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
> index 5c762a71818d..7a18a469961d 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_tun_vxlan.c
> @@ -165,9 +165,6 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
>  	struct flow_match_enc_keyid enc_keyid;
>  	void *misc_c, *misc_v;
>  
> -	misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria, misc_parameters);
> -	misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value, misc_parameters);
> -
>  	if (!flow_rule_match_key(rule, FLOW_DISSECTOR_KEY_ENC_KEYID))
>  		return 0;
>  
> @@ -182,6 +179,30 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
>  		err = mlx5e_tc_tun_parse_vxlan_gbp_option(priv, spec, f);
>  		if (err)
>  			return err;
> +
> +		/* We can't mix custom tunnel headers with symbolic ones and we
> +		 * don't have a symbolic field name for GBP, so we use custom
> +		 * tunnel headers in this case. We need hardware support to
> +		 * match on custom tunnel headers, but we already know it's
> +		 * supported because the previous call successfully checked for
> +		 * that.
> +		 */
> +		misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
> +				      misc_parameters_5);
> +		misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value,
> +				      misc_parameters_5);
> +
> +		/* Shift by 8 to account for the reserved bits in the vxlan
> +		 * header after the VNI.
> +		 */
> +		MLX5_SET(fte_match_set_misc5, misc_c, tunnel_header_1,
> +			 be32_to_cpu(enc_keyid.mask->keyid) << 8);
> +		MLX5_SET(fte_match_set_misc5, misc_v, tunnel_header_1,
> +			 be32_to_cpu(enc_keyid.key->keyid) << 8);
> +
> +		spec->match_criteria_enable |= MLX5_MATCH_MISC_PARAMETERS_5;
> +
> +		return 0;
>  	}
>  
>  	/* match on VNI is required */
> @@ -195,6 +216,11 @@ static int mlx5e_tc_tun_parse_vxlan(struct mlx5e_priv *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> +	misc_c = MLX5_ADDR_OF(fte_match_param, spec->match_criteria,
> +			      misc_parameters);
> +	misc_v = MLX5_ADDR_OF(fte_match_param, spec->match_value,
> +			      misc_parameters);
> +
>  	MLX5_SET(fte_match_set_misc, misc_c, vxlan_vni,
>  		 be32_to_cpu(enc_keyid.mask->keyid));
>  	MLX5_SET(fte_match_set_misc, misc_v, vxlan_vni,

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.34.1

