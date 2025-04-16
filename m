Return-Path: <linux-rdma+bounces-9479-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E23EA8B751
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 13:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFC543BBF7E
	for <lists+linux-rdma@lfdr.de>; Wed, 16 Apr 2025 11:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D3423D299;
	Wed, 16 Apr 2025 11:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nkoy7Dp7"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB6D23BCE6;
	Wed, 16 Apr 2025 11:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801605; cv=none; b=tMXWozZkYHuPFyNJwOr1MKQ6NHaBfJAYBPby0/h+X1LwlE2+PZQo3RBpHnk9/prsF5yUXAP9v8WhPTP5L00mjTjeZOc9CD8uflDjyxb4H/MgNCYm0Z5s1QVprXA+lSz8mgPRPb0ibzoWl1GaIG8o7QdNEyruRHqtnBnhtfhvvVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801605; c=relaxed/simple;
	bh=16DgpotWcDvzYYfzPcopAIgxhIvQDfu72PE4r4IyL3k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZAopr5Cl/UjIBEkGk7pT55spoVOM/Lo7ccLcVEM/+1mXkO+Gj2zGMZSpkMLctLfw22Xq9X55xpYjrHG9kcSLZKSkmDOjQdL2SLlnu59+RfXAFEj91tPHda+UAAAr8LFHmdUbYxb9eR+6hG7IvoOUwqao591uWCMeFsn71d79ikc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nkoy7Dp7; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744801604; x=1776337604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=16DgpotWcDvzYYfzPcopAIgxhIvQDfu72PE4r4IyL3k=;
  b=nkoy7Dp7faB9HpoOYf3w62cosSof0B8bj8Q/yDFT+6BhJrqSS8lXcNic
   Z0sLapwG5J82eZ5gNWX8V3a+/PlO05Mx9Xjn4aYy9cqTMdEkltDi7s03a
   NATddQ/Y3s32oSoRmfj6X/9B/fM61tubCLxnYcTT7EEre4JA06I/eVNr1
   1Gh6xaeeDjDC99Hh0LTzhk73pVuK8Q3erycDnYlPkh7laUOObbM2w7w2x
   G1OEAGyhpBrsa+YLaBlMD0M4Tr36sJl41M9CdHZcBTcE3YBhbu/gzqqX4
   OB+nVUC+PRr86xAXhcwqrU+J63zhsSpjok1XYLvTBypBUUfosU8xWZUKR
   g==;
X-CSE-ConnectionGUID: +GOt46gWTVyMAWXF3xsREg==
X-CSE-MsgGUID: lS40vlXjRmyrgJxq1ceT4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11404"; a="49037888"
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="49037888"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:06:39 -0700
X-CSE-ConnectionGUID: WleBxw5jSOy/jsnUAIjeew==
X-CSE-MsgGUID: IWkk0DsNTHWf2R8r+5d1nQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,216,1739865600"; 
   d="scan'208";a="134535186"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 04:06:36 -0700
Date: Wed, 16 Apr 2025 13:06:21 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mbloch@nvidia.com,
	michal.swiatkowski@linux.intel.com, amirtz@nvidia.com,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/2] net/mlx5: Move ttc allocation after switch case
 to prevent leaks
Message-ID: <Z/+PLbjcrd3F9pte@mev-dev.igk.intel.com>
References: <20250416092243.65573-1-bsdhenrymartin@gmail.com>
 <20250416092243.65573-3-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416092243.65573-3-bsdhenrymartin@gmail.com>

On Wed, Apr 16, 2025 at 05:22:43PM +0800, Henry Martin wrote:
> Relocate the memory allocation for ttc table after the switch statement
> that validates params->ns_type in both mlx5_create_inner_ttc_table() and
> mlx5_create_ttc_table(). This ensures memory is only allocated after
> confirming valid input, eliminating potential memory leaks when invalid
> ns_type cases occur.
> 
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> index 066121fed718..513dafd5ebf2 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/fs_ttc.c
> @@ -637,10 +637,6 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  	bool use_l4_type;
>  	int err;
>  
> -	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> -	if (!ttc)
> -		return ERR_PTR(-ENOMEM);
> -
>  	switch (params->ns_type) {
>  	case MLX5_FLOW_NAMESPACE_PORT_SEL:
>  		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
> @@ -654,6 +650,10 @@ struct mlx5_ttc_table *mlx5_create_inner_ttc_table(struct mlx5_core_dev *dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> +	if (!ttc)
> +		return ERR_PTR(-ENOMEM);
> +
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
>  	if (!ns) {
>  		kvfree(ttc);
> @@ -715,10 +715,6 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  	bool use_l4_type;
>  	int err;
>  
> -	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> -	if (!ttc)
> -		return ERR_PTR(-ENOMEM);
> -
>  	switch (params->ns_type) {
>  	case MLX5_FLOW_NAMESPACE_PORT_SEL:
>  		use_l4_type = MLX5_CAP_GEN_2(dev, pcc_ifa2) &&
> @@ -732,6 +728,10 @@ struct mlx5_ttc_table *mlx5_create_ttc_table(struct mlx5_core_dev *dev,
>  		return ERR_PTR(-EINVAL);
>  	}
>  
> +	ttc = kvzalloc(sizeof(*ttc), GFP_KERNEL);
> +	if (!ttc)
> +		return ERR_PTR(-ENOMEM);
> +
>  	ns = mlx5_get_flow_namespace(dev, params->ns_type);
>  	if (!ns) {
>  		kvfree(ttc);

Thanks for fixing
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.34.1
> 

