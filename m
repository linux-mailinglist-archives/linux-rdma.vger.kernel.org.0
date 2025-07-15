Return-Path: <linux-rdma+bounces-12181-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E3B6B0536F
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 09:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5BBB4A08E8
	for <lists+linux-rdma@lfdr.de>; Tue, 15 Jul 2025 07:39:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D45326D4F8;
	Tue, 15 Jul 2025 07:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QAe7KEJ1"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B82B72615;
	Tue, 15 Jul 2025 07:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565164; cv=none; b=W62j9EYwP7HlHemt9DJLS+g1Dmx1QSnbbqdIi5VOt2ri92wcKNUd6HIfAQGHD+v3LqmqofuCICqwdzbWRxI5WAC+ZLXoKziEvCZdlployi4TOi8dBOaRbWEhvR7aSl8ZbLYcUh1OGoSDauXyrfPlJIP6m2fdoVPO7Gj3G6hOlyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565164; c=relaxed/simple;
	bh=3i/qMmuOjEPKKydSHfnRXQ/mWHKLggISVx9kXQtgX6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GmdvZFhX/ATNCAk/XwJ0yE0fOiBKCD/7nZIwHUUs2dCth3B6CspfG8uGORO45OC+8coIviTmMRRCKU1fspOiVLNRUxAHopE3tvGWE2ePIy2rCwk3rkfbGZ08aGEEFNgXQjVLX4DUiMnHlnJHBvJ/TPPKDL/t8sUwwedvB2sas+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QAe7KEJ1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752565162; x=1784101162;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3i/qMmuOjEPKKydSHfnRXQ/mWHKLggISVx9kXQtgX6Y=;
  b=QAe7KEJ1dmwMTcEEpiFvldGN9ZPCYL6MZIStiScXr5pHRFgjeES8N3n6
   YUHS37oTUenD2XTuNqY0BIjieAcuyyVbSvznznWIO8GJWP8tqnn3qi6p8
   xqtYvKcMRWrlNQ+sigcVkN5CugmyHUg409UxiuysB3LP0RxyuXQ5MIsQS
   HDfUpeZr4K2bwJH32gDR0J3H1jXlMKxMRwAb6liV8BxNhWBK9gli7DA0E
   usfsFDV90qkFOuNMBuVKZ+fr/QpWqMTiz8NiKHKKiLETt72jwiEH/cWgd
   h9SaWYlgPtlSCpVuk8hUtkpHad44mm2a7xEU0U1W4CRG3J+PNqdX8Zbv1
   w==;
X-CSE-ConnectionGUID: mKj44oV5R+SJGegufPa/wg==
X-CSE-MsgGUID: 2Imetq7/SM+K6m9v5Tv76Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58581057"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="58581057"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:39:21 -0700
X-CSE-ConnectionGUID: 3PdKRaDmR5eKlMg2GI7TPA==
X-CSE-MsgGUID: hdNi3wtMQOWJ/3PhkdF/4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157243663"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:39:18 -0700
Date: Tue, 15 Jul 2025 09:38:13 +0200
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
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Remove duplicate mkey from
 SHAMPO header
Message-ID: <aHYFZavwYYEFtxP+@mev-dev.igk.intel.com>
References: <1752471585-18053-1-git-send-email-tariqt@nvidia.com>
 <1752471585-18053-7-git-send-email-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1752471585-18053-7-git-send-email-tariqt@nvidia.com>

On Mon, Jul 14, 2025 at 08:39:45AM +0300, Tariq Toukan wrote:
> From: Lama Kayal <lkayal@nvidia.com>
> 
> SHAMPO structure holds two variations of the mkey, which is unnecessary,
> a duplication that's repeated per rq.
> 
> Remove duplicate mkey information and keep only one version, the one
> used in the fast path, rename field to reflect field type clearly.
> 
> Signed-off-by: Lama Kayal <lkayal@nvidia.com>
> Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en.h  |  3 +--
>  .../net/ethernet/mellanox/mlx5/core/en_main.c | 27 ++++++++++++-------
>  .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  2 +-
>  3 files changed, 20 insertions(+), 12 deletions(-)

Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

> -- 
> 2.40.1
> 

