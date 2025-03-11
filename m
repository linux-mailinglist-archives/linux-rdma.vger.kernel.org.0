Return-Path: <linux-rdma+bounces-8562-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF33A5BA19
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 08:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 010397A4A88
	for <lists+linux-rdma@lfdr.de>; Tue, 11 Mar 2025 07:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7464B222595;
	Tue, 11 Mar 2025 07:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sy+AHpPv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A94422257B;
	Tue, 11 Mar 2025 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741678967; cv=none; b=mk1oasbkoJut2v9S2N24WCGyij60HygToT05Xudy8lKan0Z6tXHq6+9IzJXz8P+vhtV2WnbLF05M/DJ3ukuLfuNNBhUC/RpZnGhAub05IAyXAa1Kfi8PBtDxRHVPmzwnJnMcHtiVMi/qCh5ydUwZn6FB3v+HaLwsQMOAfmLXuus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741678967; c=relaxed/simple;
	bh=SEVKryVmw9EdI0nGbBI78wK4YjhFT5TtzcIWAsyinnE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=badzu5RfW+Q/KHeUeCybdES2wxVqnkRSidoTNVpYrfF7YuvGlpTKQ0S+sWa4ah4+2THnQ2nu+d17i/mDuKWQgFNq6gruTNPrIf/M6qkYWfV7wpAoxD8Y/pfnD13paMgfzo755WhjrzqhVloc8uMvmwWv6kUyiD2C7O5u6WaXA4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sy+AHpPv; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741678965; x=1773214965;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SEVKryVmw9EdI0nGbBI78wK4YjhFT5TtzcIWAsyinnE=;
  b=Sy+AHpPv7XKq0XLGUEld20vsLm+LMAA+FmBuqzZzSwkYAQA3EUIK4Ajm
   OJd0blVwzEOwHxVw9acs3qDLPZHfg62OBiCvnMZKFYP7O0rxLZaWcir9s
   C067h8XT8eUCmYNWcahPXTEL4QKNp3MQ50IkeQwICiLI3l4be6tshRw4q
   PJhEpe24n2lSvEkYDxU+b1iBgcPvaOAZY6I6qO3lyY4/eVzzi8SNGRily
   OrkM2EHQ52nZVxSvnxvLKpkRThjjAcYHgF4cZIDnshIdiAj069SIxWsXG
   J10dSveUNtNQf0e5Ibe7qRfGCGoWdCI9e4I0P++1EnGHNH5isO0Ayf11n
   Q==;
X-CSE-ConnectionGUID: hiiznS35Qbm5U+PSnRjItQ==
X-CSE-MsgGUID: sV9BoiNBSqyMOPIz9shSYg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42554464"
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="42554464"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:42:44 -0700
X-CSE-ConnectionGUID: 8Xd3d6ptR5aeRVwVhOuHAQ==
X-CSE-MsgGUID: BI1CVhApRNCY8ANLDLsc9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,238,1736841600"; 
   d="scan'208";a="124839811"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2025 00:42:41 -0700
Date: Tue, 11 Mar 2025 08:38:50 +0100
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
Subject: Re: [PATCH net 3/6] net/mlx5: Fix incorrect IRQ pool usage when
 releasing IRQs
Message-ID: <Z8/oigZe964EbsHh@mev-dev.igk.intel.com>
References: <1741644104-97767-1-git-send-email-tariqt@nvidia.com>
 <1741644104-97767-4-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1741644104-97767-4-git-send-email-tariqt@nvidia.com>

On Tue, Mar 11, 2025 at 12:01:41AM +0200, Tariq Toukan wrote:
> From: Shay Drory <shayd@nvidia.com>
> 
> mlx5_irq_pool_get() is a getter for completion IRQ pool only.
> However, after the cited commit, mlx5_irq_pool_get() is called during
> ctrl IRQ release flow to retrieve the pool, resulting in the use of an
> incorrect IRQ pool.
> 
> Hence, use the newly introduced mlx5_irq_get_pool() getter to retrieve
> the correct IRQ pool based on the IRQ itself. While at it, rename
> mlx5_irq_pool_get() to mlx5_irq_table_get_comp_irq_pool() which
> accurately reflects its purpose and improves code readability.
> 
> Fixes: 0477d5168bbb ("net/mlx5: Expose SFs IRQs")
> Signed-off-by: Shay Drory <shayd@nvidia.com>
> Reviewed-by: Maher Sanalla <msanalla@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/eq.c        |  2 +-
>  .../net/ethernet/mellanox/mlx5/core/irq_affinity.c  |  2 +-
>  drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h  |  4 +++-
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c   | 13 ++++++++++---
>  drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h   |  2 +-
>  5 files changed, 16 insertions(+), 7 deletions(-)
> 
[...]

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

> -- 
> 2.31.1

