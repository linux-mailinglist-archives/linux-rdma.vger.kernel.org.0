Return-Path: <linux-rdma+bounces-8288-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E69A4D4CA
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 08:27:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146AA188C637
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 07:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B3A1F5830;
	Tue,  4 Mar 2025 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/JdyAlq"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2670B1F461E;
	Tue,  4 Mar 2025 07:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741073238; cv=none; b=f3J4r+ZCutZuBuWWmFchOu6h97nTaElhk4A5A843FhWEs+81VmH9w4Fii2ktufGDeR2/th5X/u1Ss8vwSaXNwvKXkTEKf8sMeqjpfn7FjlYlWYjgyMAepwEo0FKXXtD5WYlzvFW+CuzQilKKA7f4qGu1ZQlbG9E4zPLzuAWUz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741073238; c=relaxed/simple;
	bh=T77wGR7eXHCugm56bgRS+Cpw9HAasGubLIvjTvw6nLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ho8wrx0ChXTxvUBKTizZ0KolvIz6VsnaHmHxCyzLWkerZ6iXu7P7CK2/0Iel4KNInhzrppU3YhAKJjhfFLvVfuHJvskwi1QdKg3hbugLB+NKIgnu81aBv78HkUcVUKCzBogf6ZzzbdP0X5VnLY5PxaFqTXYKt/0BT9z5RxgLqZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/JdyAlq; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741073237; x=1772609237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T77wGR7eXHCugm56bgRS+Cpw9HAasGubLIvjTvw6nLU=;
  b=f/JdyAlqbx23CJ7whVV+P0BZBkdPo6UekTn9fTuuJzYTSj73nGEjzr2Z
   TNY/Bj77RBDvd+T+PUQCWKnYHSoM1R/0PcFFmXK7Tx4RL5EC3ChTxXTnx
   YD0OD0jaf1i/Ro833toq3WH23ll/HIfb/lBas9pjje3K+Vnl+P450D4HG
   eQlSYmkRrjDkVIagD0ndMrPVg3bFDoPAxwpKLiSa1I86KE/kAPTKQZUIL
   Sm2BNbrK3dRtADyKBZcmizsnfx61MbHsRUEsD7Q6UyZglThUI7IYjpsT3
   XayE7VNA131lnCZcZR9lFILCEXkVPXj4awUSgq46uv3oSApnZiCB6/sxV
   w==;
X-CSE-ConnectionGUID: 10znjHcYSymKMzA8riAc5A==
X-CSE-MsgGUID: ANim9a1ATUqOv4Ces5pXqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="53371433"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="53371433"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:27:17 -0800
X-CSE-ConnectionGUID: 2+PVFWQcTvGczLGMIwtInA==
X-CSE-MsgGUID: kC/4aWeMQPeHeJqp/B56JQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123307002"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:27:14 -0800
Date: Tue, 4 Mar 2025 08:23:26 +0100
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/6] net/mlx5e: Separate address related
 variables to be in struct
Message-ID: <Z8aqbjHicSGBvtsG@mev-dev.igk.intel.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
 <20250226114752.104838-6-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114752.104838-6-tariqt@nvidia.com>

On Wed, Feb 26, 2025 at 01:47:51PM +0200, Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Prepare the code to addition of prefix handling logic which is needed
> to support matching logic based on source and/or destination network
> prefixes.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en_accel/ipsec.c       | 32 ++++----
>  .../mellanox/mlx5/core/en_accel/ipsec.h       | 26 +++----
>  .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 75 +++++++++++--------
>  3 files changed, 68 insertions(+), 65 deletions(-)
> 

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

