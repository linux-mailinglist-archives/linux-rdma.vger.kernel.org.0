Return-Path: <linux-rdma+bounces-8291-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5AFA4D571
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 08:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5293C7A1A45
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 07:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE99E1FA14B;
	Tue,  4 Mar 2025 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="El2Q9IsP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D670A1F583B;
	Tue,  4 Mar 2025 07:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741074879; cv=none; b=SR9Tmr0xNZrCIxiAdkwp6K8N3bS9F1vkhoGb8BbNiTqk0rBJPXPLfvXYm1U6uW4ZoRLHw1LpFuSJcRkR3a1VvxdRCG86RK/UtwkqF91otU07hT6PWsQn6+841KzQl3Xxs00hxAaCdXUXKyV35YWdXP1YqzDwFWIFgn20Zq7Kp0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741074879; c=relaxed/simple;
	bh=bakggjADoge3PlUC06WHqCG9hdUKEoVxgs+5cA5dUIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaRKAKlMGdGCzE4fFh8gdhApDl+rm+3s5bDT20DHMIDikaFUtvslK8P3j8T7pZgGYThnsgAMCte6JgQFB3FBL/YLjWAwAl8F8JS7q/9O9rDHTnb24QnMoNHSRrVav+06mXqlHDncioA/hVQoqJKK1Vlxa2zWDYbpwbhOo1/CjMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=El2Q9IsP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741074877; x=1772610877;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bakggjADoge3PlUC06WHqCG9hdUKEoVxgs+5cA5dUIc=;
  b=El2Q9IsPb3kNhN6Y8wy+bIBApFqCPKcy+bd6SRE+0ypEw7vkdEV9ehEw
   8upl+TfLVJB+H+d+sZZAANJ63FWzsPYtsC6Q0o4j3ZMYKTqsJN/0Uz/pb
   PGh2F+UDvkmtyI18E/oSV92VKAo3SxnOOkTVZvJoYQImDOJp+ltxlu/TP
   lw54Q9simdFrAcCqIOf3jePNdEVn6oZRnt6bp9ivSzhC+yexVa04cJaVE
   7/kjF2ugPkaQCoc9QrqF7hzJMin70a1rDp5NBmzeh7zm6cKF18FSNKrWB
   8kVFL0ylTsESiIun4UvFCeysVYNOUg/F6Cx+JQ8egTAzCte7ZsQU9Gs8W
   Q==;
X-CSE-ConnectionGUID: hcMK4nukRdaAyc733scfwQ==
X-CSE-MsgGUID: AWLJ0/aOSDKnxPK43Jodvw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41874283"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41874283"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:54:36 -0800
X-CSE-ConnectionGUID: P0BmQndnQL6qmYHE58fIeQ==
X-CSE-MsgGUID: f/KuNc03TBqeFuq5Hib8YQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="149098853"
Received: from mev-dev.igk.intel.com ([10.237.112.144])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 23:54:33 -0800
Date: Tue, 4 Mar 2025 08:50:46 +0100
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
Subject: Re: [PATCH net-next 6/6] net/mlx5e: Properly match IPsec subnet
 addresses
Message-ID: <Z8aw1gn5iFNiSxd3@mev-dev.igk.intel.com>
References: <20250226114752.104838-1-tariqt@nvidia.com>
 <20250226114752.104838-7-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250226114752.104838-7-tariqt@nvidia.com>

On Wed, Feb 26, 2025 at 01:47:52PM +0200, Tariq Toukan wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> Existing match criteria didn't allow to match whole subnet and
> only by specific addresses only. This caused to tunnel mode do not
> forward such traffic through relevant SA.
> 
> In tunnel mode, policies look like this:
> src 192.169.0.0/16 dst 192.169.0.0/16
>         dir out priority 383615 ptype main
>         tmpl src 192.169.101.2 dst 192.169.101.1
>                 proto esp spi 0xc5141c18 reqid 1 mode tunnel
>         crypto offload parameters: dev eth2 mode packet
> 
> In this case, the XFRM core code handled all subnet calculations and
> forwarded network address to the drivers e.g. 192.169.0.0.
> 
> For mlx5 devices, there is a need to set relevant prefix e.g. 0xFFFF00
> to perform flow steering match operation.
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>  .../mellanox/mlx5/core/en_accel/ipsec.c       | 49 +++++++++++++++++++
>  .../mellanox/mlx5/core/en_accel/ipsec.h       |  9 +++-
>  .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 20 +++++---
>  3 files changed, 69 insertions(+), 9 deletions(-)
> 

[...]

>  
> +static __be32 word_to_mask(int prefix)
> +{
> +	if (prefix < 0)
> +		return 0;
> +
> +	if (!prefix || prefix > 31)
> +		return cpu_to_be32(0xFFFFFFFF);
> +
> +	return cpu_to_be32(((1U << prefix) - 1) << (32 - prefix));

Isn't it GENMASK(31, 32 - prefix)? I don't know if it is preferable to
use this macro in such place.

> +}
> +
> +static void mlx5e_ipsec_policy_mask(struct mlx5e_ipsec_addr *addrs,
> +				    struct xfrm_selector *sel)
> +{
> +	int i;
> +
> +	if (addrs->family == AF_INET) {
> +		addrs->smask.m4 = word_to_mask(sel->prefixlen_s);
> +		addrs->saddr.a4 &= addrs->smask.m4;
> +		addrs->dmask.m4 = word_to_mask(sel->prefixlen_d);
> +		addrs->daddr.a4 &= addrs->dmask.m4;
> +		return;
> +	}
> +
> +	for (i = 0; i < 4; i++) {
> +		if (sel->prefixlen_s != 32 * i)
> +			addrs->smask.m6[i] =
> +				word_to_mask(sel->prefixlen_s - 32 * i);
> +		addrs->saddr.a6[i] &= addrs->smask.m6[i];
> +
> +		if (sel->prefixlen_d != 32 * i)
> +			addrs->dmask.m6[i] =
> +				word_to_mask(sel->prefixlen_d - 32 * i);
> +		addrs->daddr.a6[i] &= addrs->dmask.m6[i];
> +	}
> +}
> +

[...]

Looks fine,
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

Thanks

