Return-Path: <linux-rdma+bounces-8563-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7207DA5BA20
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AB841895901
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1062C222593;
	Tue, 11 Mar 2025 07:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NWjS0NOJ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6825D22173C;
	Tue, 11 Mar 2025 07:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741679101; cv=none; b=J80QaArpzFDH7Usi2ACOG71jstZiokh8uJpN9fjEY1ACZqsT+IZw0SrmjFMy4yrimcykBLZq62VIEIunMZtEA+t7xroBeG+FrCkhDhiYXFuqADYAV2RPfOr3Z3T6eh/Z0Kx75QrPsydtez57wPmfNtR/vrDQoJtw+48v5OOenlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741679101; c=relaxed/simple;
	bh=1ADFlvq1wbboRCA2G1LV3CEb9m8pqmqaV3auLbDu4+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UqspIdNLMyKyu2QywreX+xSHV/JW5RdAK9uk3QNmef3cR9YxCVyT6JhTqM5+qjoynH4QfXGb6t4PpumK9ytlqIXm6SpqaUFny1xZOAxpfhOl0u+/hu8E1pGu1MjtESHpidE7bBEZN3trg9A3UBLrTUHOpAzH7ucJ9Ij4o/g768E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NWjS0NOJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741679100; x=1773215100;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1ADFlvq1wbboRCA2G1LV3CEb9m8pqmqaV3auLbDu4+s=;
  b=NWjS0NOJLsidFQTyMTLgLwI4FBNZlYkH2CFeeaQoWAcXPTU1Q+srl2zw
   qNmjQMWroq8KR/pEVaD6d3bfPKeQZiMFz2EQScaH+oplQpoVKha7YGXQ7
   rv2yhglMyVG+P+CzP5gfv3ddd6O+xHLvkvjmlf1dBXiJCNF6mCfNS0iRi
   xfI+kTNRM85hX7n10xGt0VRefDhYg5kiDroSq1m0i/KqX2mpBeK6K4fh+
   pBO2+JowPQN5DI1ME+JRLaTqL+YcB8BVt2gi/34h9Ag/R1MUL5lGw4lRu
   TK3pmP77kdleA0o+y7Djsf+0lCzjBTFGBbM8GChex9Y3i6pz7xam9C00+
   w==;
X-CSE-ConnectionGUID: bV4JgXrgRzetqh/oBsaMqQ==
X-CSE-MsgGUID: fnSlpjnOSDWBqlO05yTiaw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42613009"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42613009"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:45:00 -0700
X-CSE-ConnectionGUID: RgQRP+pgRw+gu3XAjNHaAw==
X-CSE-MsgGUID: /tDWz1lJQSa9OLn3xj5WMw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="143439123"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:44:56 -0700
Date: Tue, 11 Mar 2025 08:41:04 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, Gal Pressman <gal@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	Shay Drory <shayd@nvidia.com>
Subject: Re: [PATCH net 4/6] net/mlx5: Lag, Check shared fdb before creating
 MultiPort E-Switch
Message-ID: <Z8/pEN9xy4Pw7kHF@mev-dev.igk.intel.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
 <1741644104-97767-5-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741644104-97767-5-git-send-email-tariqt@nvidia.com>

On Tue, Mar 11, 2025 at 12:01:42AM +0200, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> Currently, MultiPort E-Switch is requesting to create a LAG with shared
> FDB without checking the LAG is supporting shared FDB.
> Add the check.
> 
> Fixes: a32327a3a02c ("net/mlx5: Lag, Control MultiPort E-Switch single FDB mode")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Mark Bloch <mbloch@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c   | 4 ++--
>  drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h   | 1 +
>  drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c | 3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index cea5aa314f6c..ed2ba272946b 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -951,7 +951,7 @@ void mlx5_disable_lag(struct mlx5_lag *ldev)
>  				mlx5_eswitch_reload_ib_reps(ldev->pf[i].dev->priv.eswitch);
>  }
>  
> -static bool mlx5_shared_fdb_supported(struct mlx5_lag *ldev)
> +bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev)
>  {
>  	int idx = mlx5_lag_get_dev_index_by_seq(ldev, MLX5_LAG_P1);
>  	struct mlx5_core_dev *dev;
> @@ -1038,7 +1038,7 @@ static void mlx5_do_bond(struct mlx5_lag *ldev)
>  	}
>  
>  	if (do_bond && !__mlx5_lag_is_active(ldev)) {
> -		bool shared_fdb = mlx5_shared_fdb_supported(ldev);
> +		bool shared_fdb = mlx5_lag_shared_fdb_supported(ldev);
>  
>  		roce_lag = mlx5_lag_is_roce_lag(ldev);
>  
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> index 01cf72366947..c2f256bb2bc2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h
> @@ -92,6 +92,7 @@ mlx5_lag_is_ready(struct mlx5_lag *ldev)
>  	return test_bit(MLX5_LAG_FLAG_NDEVS_READY, &ldev->state_flags);
>  }
>  
> +bool mlx5_lag_shared_fdb_supported(struct mlx5_lag *ldev);
>  bool mlx5_lag_check_prereq(struct mlx5_lag *ldev);
>  void mlx5_modify_lag(struct mlx5_lag *ldev,
>  		     struct lag_tracker *tracker);
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> index ffac0bd6c895..1770297a112e 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/mpesw.c
> @@ -83,7 +83,8 @@ static int enable_mpesw(struct mlx5_lag *ldev)
>  	if (mlx5_eswitch_mode(dev0) != MLX5_ESWITCH_OFFLOADS ||
>  	    !MLX5_CAP_PORT_SELECTION(dev0, port_select_flow_table) ||
>  	    !MLX5_CAP_GEN(dev0, create_lag_when_not_master_up) ||
> -	    !mlx5_lag_check_prereq(ldev))
> +	    !mlx5_lag_check_prereq(ldev) ||
> +	    !mlx5_lag_shared_fdb_supported(ldev))
>  		return -EOPNOTSUPP;
>  
>  	err = mlx5_mpesw_metadata_set(ldev);

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.31.1

