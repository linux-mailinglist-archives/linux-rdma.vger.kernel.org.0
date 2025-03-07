Return-Path: <linux-rdma+bounces-8471-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B143A56857
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 13:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F7D33B12A9
	for <lists+linux-rdma@lfdr.de>; Fri,  7 Mar 2025 12:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A589219A81;
	Fri,  7 Mar 2025 12:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="a68YjyEa"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480FF2192FC;
	Fri,  7 Mar 2025 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741352248; cv=none; b=HaAuTGeE7SEptMe2Suihgzbm/NsK/c77v8ui49KctlrU2MoLW6cR3pfekfxgY8pyTin3gfIj9uNeSCr90yCoH+ck9Vmye5THlR7ZVwvQlvzGh5Q1PpwtjaS+cKhVRPGSVnuK79zHLyaqE7xUKWuXI24g7WXN1w37COzv6SmZgoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741352248; c=relaxed/simple;
	bh=dUQt3efYaBwnkNkbg8+vGSt7xM8wMCm8dXGlA0fxYL8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vawzoge+Tos9pw7L1Fjpqyrj/gaY/q+zEd82gby7ZN8uiVgLdIF6J76AfOO1G1PdP8mGok/CarXS+aveYC1POMjdwYZxRAHMx6Gqf6mNRjn2UIY8/0Cqo8PKyBaiB96daBF4jJkbZBYd8AV6mySmveQ+AXKYykKMueuvRYpd/es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=a68YjyEa; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741352247; x=1772888247;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dUQt3efYaBwnkNkbg8+vGSt7xM8wMCm8dXGlA0fxYL8=;
  b=a68YjyEa+QfAtB+wrP9SMiBMFunadyR3ZYpnYbPJ8WIG22OLhvldfXTX
   0zX2U2tiR6c6Ub69Ho6oYDqUmegP7zb1IhLf+nCQZBDgGg8qYt6YoyV/J
   688Izk3XCo9n0OefQKHKeYqT/5UWNiKeNbNEX04qUC5l0Y22PEwZ0ugZq
   7po+1tPLBwnMLxY7Uxnail/heDrEBH5/s1tjmFr+zMpC8KL3j/JsV8bbF
   ZVUh7Yq1I/UP9+9/qD1IQ0DAeGRopxxURsLFEfqDI6eDGVdsMdUOhWC+x
   mb7qLVLzciGZg8wwY1i6ymrnS6m2G6HfbO2FtLJ4APZGX6HqzrAnwNZ3P
   w==;
X-CSE-ConnectionGUID: AdfcmRAlRdafu1kiNEpn7Q==
X-CSE-MsgGUID: bgmSVdr+QdmBwiIVrmB6Pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="42629396"
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="42629396"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:57:26 -0800
X-CSE-ConnectionGUID: a43TkmSDROGckEG637lOdA==
X-CSE-MsgGUID: 2SKO4zDjTfu+ExFab++YOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,229,1736841600"; 
   d="scan'208";a="123909172"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 04:57:22 -0800
Date: Fri, 7 Mar 2025 13:53:32 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Simon Horman <horms@kernel.org>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH net-next] net/mlx5: Avoid unnecessary use of comma
 operator
Message-ID: <Z8rsQXAjtK+FN6iu@mev-dev.igk.intel.com>
References: <20250307-mlx5-comma-v1-1-934deb6927bb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307-mlx5-comma-v1-1-934deb6927bb@kernel.org>

On Fri, Mar 07, 2025 at 12:39:33PM +0000, Simon Horman wrote:
> Although it does not seem to have any untoward side-effects,
> the use of ';' to separate to assignments seems more appropriate than ','.
> 
> Flagged by clang-19 -Wcomma
> 
> No functional change intended.
> Compile tested only.
> 
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> index c862dd28c466..e8cc91a9bd82 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_chains.c
> @@ -700,7 +700,7 @@ mlx5_chains_create_global_table(struct mlx5_fs_chains *chains)
>  		goto err_ignore;
>  	}
>  
> -	chain = mlx5_chains_get_chain_range(chains),
> +	chain = mlx5_chains_get_chain_range(chains);
>  	prio = mlx5_chains_get_prio_range(chains);
>  	level = mlx5_chains_get_level_range(chains);

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

