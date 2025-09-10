Return-Path: <linux-rdma+bounces-13228-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0178FB51156
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9539A1C8220C
	for <lists+linux-rdma@lfdr.de>; Wed, 10 Sep 2025 08:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D2630FC0C;
	Wed, 10 Sep 2025 08:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXA0u7/N"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570A30DECE;
	Wed, 10 Sep 2025 08:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757493155; cv=none; b=ErH4fPQBMu6E24pXceA+lc9axrsHg9XSJa7gfkCIWqLgprYiZKQXD3Bka8/oQicRYzm/uczKITUzJmzzCGSR2bUOYJVDAixw1V3MZbVDf3UoDSW8WX1g/PNC9wvebSMz8rpUUYaRJ0tBFZDazi7LQs5HVoxmFKrVjbx01StjMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757493155; c=relaxed/simple;
	bh=MekfQso4OasphqWcIs0CDtSKKcqX6OBMrfPleEPRA8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfGus5JGn7IosJRIMviBhpin9DOiHEXlmRHLc7f1EqWVNvsH5dmuCs6ECV5GxHw9Qgy3Jg4VQLA4fSytXAENO3j/ZbylFN/AgEbplOe6zJ4i7oBZJMb+y4GEigzdeYxjlmM3F65V4AvCE86LSrt5Oz0YNBPHqdz9yhZ/wNSNZXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXA0u7/N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE92C4CEF0;
	Wed, 10 Sep 2025 08:32:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757493154;
	bh=MekfQso4OasphqWcIs0CDtSKKcqX6OBMrfPleEPRA8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DXA0u7/NTCqsAQ+gAFiiXHMTq8v6RmUl/o07E1E00vlq4n6qMO3ESb0UKovfxCAS4
	 yEK3K3caQeHCxBe1Yh0sSTN66s5kv2GI9ds4IK0zZucDtkV614LPUvTsJbPIJ2rXpR
	 k5v2Cl5nFkgdFN7y8wHDAvoeULsN46PqdYc14/eWvyVIDP2Zk8DWGfW2p/bb7J9GIV
	 q19Z9u2Lx1FK8ZVICel/BtYBYDSU4H0HNlzZCa2U5a3CFjCXoWqV25qJr/mKB/FSGL
	 2xitda5tXYigKputVvagBEERplgPZyUMMSW4OuYPS0EjGYVpz8kjkQI8fcJRfIC3xf
	 FEscXmPXG2r2g==
Date: Wed, 10 Sep 2025 11:32:29 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	parav@nvidia.com, cratiu@nvidia.com, vdumitrescu@nvidia.com,
	kuba@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	gal@nvidia.com
Subject: Re: [PATCH 2/4] RDMA/core: Resolve MAC of next-hop device without
 ARP support
Message-ID: <20250910083229.GK341237@unreal>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250907160833.56589-3-edwards@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250907160833.56589-3-edwards@nvidia.com>

On Sun, Sep 07, 2025 at 07:08:31PM +0300, Edward Srouji wrote:
> From: Parav Pandit <parav@nvidia.com>
> 
> Currently, if the next-hop netdevice does not support ARP resolution,
> the destination MAC address is silently set to zero without reporting
> an error. 

Not an expert here, but from my understanding this is right behavior.
IFF_NOARP means "leave" MAC address as is (zero).

> This leads to incorrect behavior and may result in packet transmission failures.
> 
> Fix this by deferring MAC resolution to the IP stack via neighbour
> lookup, allowing proper resolution or error reporting as appropriate.

What is the difference here? For IPv4, neighbour lookup is ARP, no?

> 
> Fixes: 7025fcd36bd6 ("IB: address translation to map IP toIB addresses (GIDs)")
> Signed-off-by: Parav Pandit <parav@nvidia.com>
> Reviewed-by: Vlad Dumitrescu <vdumitrescu@nvidia.com>
> Signed-off-by: Edward Srouji <edwards@nvidia.com>
> ---
>  drivers/infiniband/core/addr.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
> index 594e7ee335f7..ca86c482662f 100644
> --- a/drivers/infiniband/core/addr.c
> +++ b/drivers/infiniband/core/addr.c
> @@ -454,14 +454,10 @@ static int addr_resolve_neigh(const struct dst_entry *dst,
>  {
>  	int ret = 0;
>  
> -	if (ndev_flags & IFF_LOOPBACK) {
> +	if (ndev_flags & IFF_LOOPBACK)
>  		memcpy(addr->dst_dev_addr, addr->src_dev_addr, MAX_ADDR_LEN);
> -	} else {
> -		if (!(ndev_flags & IFF_NOARP)) {
> -			/* If the device doesn't do ARP internally */
> -			ret = fetch_ha(dst, addr, dst_in, seq);
> -		}
> -	}
> +	else
> +		ret = fetch_ha(dst, addr, dst_in, seq);
>  	return ret;
>  }
>  
> -- 
> 2.21.3
> 

