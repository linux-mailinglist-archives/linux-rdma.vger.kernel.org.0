Return-Path: <linux-rdma+bounces-12109-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C91A3B0375B
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 08:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DD341773E1
	for <lists+linux-rdma@lfdr.de>; Mon, 14 Jul 2025 06:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E55B223716;
	Mon, 14 Jul 2025 06:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mfLacVT5"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643181CD1F;
	Mon, 14 Jul 2025 06:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752475662; cv=none; b=S5LJRSbg1OfJm8Z1M4mm8MxEw6QnKHxtWPh5RrwBifsEAaMdWzYqeo3j6g3pUQ87PkUnN+lEbJcGDf8/r1S84eN/80Ed5LZL9LgD9KyXMzBboc+6qG0YsVBbK43AJrUaWuhjS9ptSIdvZDKL9QppmiwuJsyLoyBY7xzknbv0vqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752475662; c=relaxed/simple;
	bh=6xDUYWE/Jr47TmrJ9Hv9e2CUNFE7R/C1tZglMaQ+AtM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YQvuBU2cFO7C0GxM+C7T+tAyAD08g2AmvKfzDxdxDccFQ9hY9x0n+NDocwKgboD6g2nRWrRTTwNCWW0c6UNQCwKOjan7en8EqYNjkE/WTpwimJsk/5F9yao4FJzmeZG+QLjD00IIFEYzxCxXxcU/yybTENSKc+vtdYcvFdIb3NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mfLacVT5; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752475660; x=1784011660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6xDUYWE/Jr47TmrJ9Hv9e2CUNFE7R/C1tZglMaQ+AtM=;
  b=mfLacVT5lc7rKvqAeGp7TvpwKGNvEd1/tZaAmJEBPbcqgkTY2QdQ1eOV
   adlpCjfwtKifhiUgq7vYRlfu77Hqhm0tD3XUzCCMZ6pqDRQsg8O3PUwEY
   j38wwDr+qMkv52uCFTXFJg+Ea2SH6qotMpaOgmCIPmzh8g93FemkjE7WQ
   0lwQf5SALFLTKt33DhIVwTqIIDFtQr3I/4Erjk9sHG2S43Ax+1f+arB3O
   rm7GXtYMmrwCMFBwslP8jzHdpyBVZx34KtiCSTfpthyq/J0I+kkRgjeku
   8+ADZ21q0hvFP13uSoosxHWIpHRX73wwy7vgGLPjbtkuUH3pjZytwWJLy
   w==;
X-CSE-ConnectionGUID: mZhCkYtGT1SsisIGWeeZZw==
X-CSE-MsgGUID: St4IEwijSDuhnd52Q6mQOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="42296094"
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="42296094"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 23:47:39 -0700
X-CSE-ConnectionGUID: lad1MMgrQi+Chk/T806a5Q==
X-CSE-MsgGUID: xWRV+z6XQa2BqI5IlVwcOQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,310,1744095600"; 
   d="scan'208";a="156942085"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2025 23:47:36 -0700
Date: Mon, 14 Jul 2025 08:46:31 +0200
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
	linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [PATCH net-next 2/6] net/mlx5e: fix kdoc warning on eswitch.h
Message-ID: <aHSnvakoq5U4QX3T@mev-dev.igk.intel.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-3-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752471585-18053-3-git-send-email-tariqt@nvidia.com>

On Mon, Jul 14, 2025 at 08:39:41AM +0300, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> Fix the following kdoc warning:
> git ls-files *.[ch] | egrep drivers/net/ethernet/mellanox/mlx5/core/ |\
> xargs scripts/kernel-doc --none
> drivers/net/ethernet/mellanox/mlx5/core/eswitch.h:824: warning: cannot
> understand function prototype: 'struct mlx5_esw_event_info '
> 
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eswitch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> index d59fdcb29cb8..b0b8ef3ec3c4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.h
> @@ -827,7 +827,7 @@ void mlx5_esw_vport_vhca_id_clear(struct mlx5_eswitch *esw, u16 vport_num);
>  int mlx5_eswitch_vhca_id_to_vport(struct mlx5_eswitch *esw, u16 vhca_id, u16 *vport_num);
>  
>  /**
> - * mlx5_esw_event_info - Indicates eswitch mode changed/changing.
> + * struct mlx5_esw_event_info - Indicates eswitch mode changed/changing.
>   *
>   * @new_mode: New mode of eswitch.
>   */

Looks like it is the only one structure in this file described using
kdoc.

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.40.1

