Return-Path: <linux-rdma+bounces-12108-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE77B03752
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 08:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9903C7A1858
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 06:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C15226CF4;
	Mon, 14 Jul 2025 06:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Brup725k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5BA13A86C;
	Mon, 14 Jul 2025 06:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475453; cv=none; b=DAgdQH+N40lcCen4j3PmorjGpvFAMRcoKjBYPdY2sWNRkNnQbXDz/LEJltJbi5dKQ7IrwhJ+8vK7vCB5rJfYNXYRIk5tg+mcv4AmCr8B9GdmAet0cDfMq5ef7RdOwIsDduOne59nOuWzDLtnKiTpXWoz6T4rdzfX0/5Z3B3ufF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475453; c=relaxed/simple;
	bh=3gmL7rjyWzxXlZQp4lpwIQABbTj7vbN8aapxCnC0n+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p9rQKFzO235DjEJnsVNV0uHv5vNc67BI0XNxJqWpj/PXBc+rfGKzxtYmLV65mKg8oEhcSZAgFFzjfbghCKqPhrobp1oxpkYXlJlBiWj/e5rBBR1JPtTT1vNiJaUGV/MTTNjnD71uv/+EQQeA8oTc+v78qwjzxGtNWoANRWA92bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Brup725k; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752475452; x=1784011452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3gmL7rjyWzxXlZQp4lpwIQABbTj7vbN8aapxCnC0n+M=;
  b=Brup725kIGhUkM0k+TSGSl0BFEG703EGaTUfV6llAFCO+2h0kXhKMFA+
   HsrUWKyw98bm5D/wGGHQdhe0pP96VFWHQ5qz0wqqk5QPyBY7Lpr8/QQ5q
   O5AOp2f4rHUXbYM9zDQHurVHJAkO0PBMkMIikURSUI/HM/vkpK9VYuvL6
   95O2UQc22TjsMh1aIPdLHAd1s+2J3diPP2Tl26JnazgJrgwtNs0VQX9vW
   lhyjtelaVgEizZJFTRX5naKdph4rScZTPvgCtIruoGn+QyBemh5VWtABl
   jsd9goqrTJVpU0vHOwfIBfIyjUr/oA92YUoMl2XE69PO2bp8n1GTJfjfD
   w==;
X-CSE-ConnectionGUID: 4/CdFXU0R7GlMpc+WNa1uQ==
X-CSE-MsgGUID: sV/zTeFrR6CLpnvgHz3KlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65360063"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="65360063"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 23:44:11 -0700
X-CSE-ConnectionGUID: fYwSSvNZSNqHUsz3jfG30A==
X-CSE-MsgGUID: bcTFa//hRzaoX68h8vkNfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="156957374"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 23:44:08 -0700
Date: Mon, 14 Jul 2025 08:43:04 +0200
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Saeed Mahameed <saeed@kernel.org>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Saeed Mahameed <saeedm@nvidia.com>, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lama Kayal <lkayal@nvidia.com>
Subject: Re: [PATCH net-next 1/6] net/mlx5: HWS, Enable IPSec hardware
 offload in legacy mode
Message-ID: <aHSm7SHg1xTMNE0F@mev-dev.igk.intel.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-2-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752471585-18053-2-git-send-email-tariqt@nvidia.com>

On Mon, Jul 14, 2025 at 08:39:40AM +0300, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
> 
> IPSec hardware offload in legacy mode should not be affected by the
> steering mode, hence it should also work properly with hmfs mode.

What about dmfs mode? I am not sure, if you didn't remove it because it
is still needed or just forgot about removing it.

In case it is ok as it is:
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

> 
> Remove steering mode validation when calculating the cap for packet
> offload, this will also enable the missing cap MLX5_IPSEC_CAP_PRIO
> needed for crypto offload.
> 
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Jianbo Liu <jianbol@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c   | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> index 820debf3fbbf..ef7322d381af 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec_offload.c
> @@ -42,8 +42,7 @@ u32 mlx5_ipsec_device_caps(struct mlx5_core_dev *mdev)
>  
>  	if (MLX5_CAP_IPSEC(mdev, ipsec_full_offload) &&
>  	    (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_DMFS ||
> -	     (mdev->priv.steering->mode == MLX5_FLOW_STEERING_MODE_SMFS &&
> -	     is_mdev_legacy_mode(mdev)))) {
> +	     is_mdev_legacy_mode(mdev))) {
>  		if (MLX5_CAP_FLOWTABLE_NIC_TX(mdev,
>  					      reformat_add_esp_trasport) &&
>  		    MLX5_CAP_FLOWTABLE_NIC_RX(mdev,
> -- 
> 2.40.1
> 

