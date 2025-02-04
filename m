Return-Path: <linux-rdma+bounces-7386-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC289A26C08
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 07:13:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D421618F0
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Feb 2025 06:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6790E20370C;
	Tue,  4 Feb 2025 06:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lAEjk6k4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749C11FFC75;
	Tue,  4 Feb 2025 06:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738649580; cv=none; b=oWw6lEgrFG7Y17AcG+owqXOT0mXmmKwREIr4j0VkLq0ZCBUVA0xreIdKUweIsg1gzTUJH+7AM3dALGSatEOgX9YcB+5bGDK325WdyleSPdYiNQw3+L6nS5pE/T+yWGoNa2Jr8NE+nX2jpz93vkL7iDV0Wliw5zq3FAWzP9enZVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738649580; c=relaxed/simple;
	bh=Dhv3SRrHpLrLEKz3V+145BCuQEnuBa4gIZEwCDoN8/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uLcPvFPUeLarJYUj4aQlJdQroi8DAJBdmJ5k2phTvqxJxhaUW3/6Yx0uB12AmSwin/JoqgpCeNv1UHEDS+qhBAKydi2tZtt9ZsGPIEW/2CC4x7beAo+Tnwz/L7cDNk+TqZAV33ZVAAgflcjPnAO3s6LQ5g19HdAcNW2t4HLBSQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lAEjk6k4; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738649578; x=1770185578;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dhv3SRrHpLrLEKz3V+145BCuQEnuBa4gIZEwCDoN8/4=;
  b=lAEjk6k4ku57jx1r6wNB4t3WtIPDqBm7/G2NSvOtu4IOgrF4oiGkITar
   ZqVPaL3Gs3XoRReolflIs7qc++eSNhYWjPyrkT76zZAemwat6z6m78Bwm
   KtFMnUn1PjBPbTljq0f6Qc5VVcqavF7kCAfPP7xa+TfKogle3zcMzJzPO
   pavaVQYATMk96RGOYz5MtonPORbtt6y8BSCaIPlPamA1vKi+pCMCKACnT
   9xIOPxCEOCVXEg30aQBiB9HOTah/GeCWcCtGDpL7sSJ+9kd0y6cQOz9hA
   Sb5Xu8g+NedWu5DTH64yaRs+WgIFedwn/9KTe4sMyr5wi3pvh80msgXnv
   Q==;
X-CSE-ConnectionGUID: mkFuB8pDQQKV3CSs9SL++A==
X-CSE-MsgGUID: zPQK+9sUT+aRdd/pgpwxPw==
X-IronPort-AV: E=McAfee;i="6700,10204,11335"; a="49812965"
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="49812965"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:12:57 -0800
X-CSE-ConnectionGUID: pUEZjYQMQFOvutZG/29oIA==
X-CSE-MsgGUID: CQJAhstLRE+hJtPENz1Jvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,258,1732608000"; 
   d="scan'208";a="111049364"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 22:12:54 -0800
Date: Tue, 4 Feb 2025 07:09:23 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] net/mlx5e: Avoid a hundred
 -Wflex-array-member-not-at-end warnings
Message-ID: <Z6GvE4su2/m9e+Ev@mev-dev.igk.intel.com>
References: <Z6GCJY8G9EzASrwQ@kspp>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6GCJY8G9EzASrwQ@kspp>

On Tue, Feb 04, 2025 at 01:27:41PM +1030, Gustavo A. R. Silva wrote:
> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
> getting ready to enable it, globally.
> 
> So, in order to avoid ending up with a flexible-array member in the
> middle of other structs, we use the `struct_group_tagged()` helper
> to create a new tagged `struct mlx5e_umr_wqe_hdr`. This structure
> groups together all the members of the flexible `struct mlx5e_umr_wqe`
> except the flexible array.
> 
> As a result, the array is effectively separated from the rest of the
> members without modifying the memory layout of the flexible structure.
> We then change the type of the middle struct member currently causing
> trouble from `struct mlx5e_umr_wqe` to `struct mlx5e_umr_wqe_hdr`.
> 
> We also want to ensure that when new members need to be added to the
> flexible structure, they are always included within the newly created
> tagged struct. For this, we use `static_assert()`. This ensures that the
> memory layout for both the flexible structure and the new tagged struct
> is the same after any changes.
> 
> This approach avoids having to implement `struct mlx5e_umr_wqe_hdr` as
> a completely separate structure, thus preventing having to maintain two
> independent but basically identical structures, closing the door to
> potential bugs in the future.
> 
> We also use `container_of()` whenever we need to retrieve a pointer to
> the flexible structure, through which we can access the flexible-array
> member, if necessary.
> 
> So, with these changes, fix 124 of the following warnings:
> 
> drivers/net/ethernet/mellanox/mlx5/core/en.h:664:48: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
> 
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h      | 13 +++++++++----
>  drivers/net/ethernet/mellanox/mlx5/core/en_main.c |  4 +++-
>  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> index 979fc56205e1..c30c64eb346f 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
> @@ -233,15 +233,20 @@ struct mlx5e_rx_wqe_cyc {
>  };
>  
>  struct mlx5e_umr_wqe {
> -	struct mlx5_wqe_ctrl_seg       ctrl;
> -	struct mlx5_wqe_umr_ctrl_seg   uctrl;
> -	struct mlx5_mkey_seg           mkc;
> +	/* New members MUST be added within the struct_group() macro below. */
> +	struct_group_tagged(mlx5e_umr_wqe_hdr, hdr,
> +		struct mlx5_wqe_ctrl_seg       ctrl;
> +		struct mlx5_wqe_umr_ctrl_seg   uctrl;
> +		struct mlx5_mkey_seg           mkc;
> +	);
>  	union {
>  		DECLARE_FLEX_ARRAY(struct mlx5_mtt, inline_mtts);
>  		DECLARE_FLEX_ARRAY(struct mlx5_klm, inline_klms);
>  		DECLARE_FLEX_ARRAY(struct mlx5_ksm, inline_ksms);
>  	};
>  };
> +static_assert(offsetof(struct mlx5e_umr_wqe, inline_mtts) == sizeof(struct mlx5e_umr_wqe_hdr),
> +	      "struct member likely outside of struct_group_tagged()");
>  
>  enum mlx5e_priv_flag {
>  	MLX5E_PFLAG_RX_CQE_BASED_MODER,
> @@ -660,7 +665,7 @@ struct mlx5e_rq {
>  		} wqe;
>  		struct {
>  			struct mlx5_wq_ll      wq;
> -			struct mlx5e_umr_wqe   umr_wqe;
> +			struct mlx5e_umr_wqe_hdr umr_wqe;
>  			struct mlx5e_mpw_info *info;
>  			mlx5e_fp_skb_from_cqe_mpwrq skb_from_cqe_mpwrq;
>  			__be32                 umr_mkey_be;
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> index bd41b75d246e..4ff4ff2342cf 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
> @@ -373,6 +373,8 @@ static void mlx5e_rq_shampo_hd_info_free(struct mlx5e_rq *rq)
>  
>  static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
>  {
> +	struct mlx5e_umr_wqe *umr_wqe =
> +		container_of(&rq->mpwqe.umr_wqe, struct mlx5e_umr_wqe, hdr);
>  	int wq_sz = mlx5_wq_ll_get_size(&rq->mpwqe.wq);
>  	size_t alloc_size;
>  
> @@ -393,7 +395,7 @@ static int mlx5e_rq_alloc_mpwqe_info(struct mlx5e_rq *rq, int node)
>  		bitmap_fill(wi->skip_release_bitmap, rq->mpwqe.pages_per_wqe);
>  	}
>  
> -	mlx5e_build_umr_wqe(rq, rq->icosq, &rq->mpwqe.umr_wqe);
> +	mlx5e_build_umr_wqe(rq, rq->icosq, umr_wqe);
>  
>  	return 0;

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

>  }
> -- 
> 2.43.0

