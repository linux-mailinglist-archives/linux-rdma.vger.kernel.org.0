Return-Path: <linux-rdma+bounces-13473-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB93B83C6C
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 11:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A354E5424F8
	for <lists+linux-rdma@lfdr.de>; Thu, 18 Sep 2025 09:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11D28301486;
	Thu, 18 Sep 2025 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJ83UGXi"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DCD30102A;
	Thu, 18 Sep 2025 09:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187505; cv=none; b=b2AXzUxH4eZLyS/iscb4Ic4lD7KQXlPFK9D5qzdSi8PXjEFPGLeaONMrgEhW4Q0WcB8PPJ9EXQz5qjDVFkKr7VJIdhGad7YzucwRyhad1Ceg8AS1bp46nDFRHX7AoNp95l1VcialxbXLYhx66fnGd6fCKtZB67HTxDS0RudLKqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187505; c=relaxed/simple;
	bh=RAR8dXKWlbmV8uP0jlDypnzw0W7v/wHnFIOGaGmBSa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T5WKaoIjhiwSOIJufEOJ2rjBbUOryQMmMCp+ZpivTNcOuQoGNI6LheTtg/AMjDDVJxwX7G2dX+lfhVZxlHJ0gylYdKyNqL+xtNAIe4nXfMhMkbrLaNXb8jRy6nuikJrBbxdgO5WItCE9tDygdsB8QtU/8jfQqSpPHgrNbxvxl24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJ83UGXi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E273C4CEE7;
	Thu, 18 Sep 2025 09:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758187505;
	bh=RAR8dXKWlbmV8uP0jlDypnzw0W7v/wHnFIOGaGmBSa4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UJ83UGXiONf5hj00ZcXbMMAuNde8EG/L705srzFgdwMRKjwjfinzoCVhC155uGWAZ
	 VRgSP0goekmMfEwpl+HbfQqS66A+tr3ktGuPrR/NBK+z1y0ThRhVXpZkW/HbUZieDm
	 1z4rVd8oeEws0An8dkbhE3i4P49dH1pBT5sd80IA+W98HvuyA6Xff22XcexTAuuTNb
	 9Ab+sBZ5uIR2U/q9URqYP9hWNQHoYDSu/PeGXuhb3+S7eDg1YedKPop8Na5a4wq4sD
	 gj0Y4U43EzhGi1yT0RWHp5O6smmyioebpZFFJTZcsNXp7tys3Z1NACiYT6BNYu3+Cy
	 bKGwvqvH62A9g==
Date: Thu, 18 Sep 2025 12:24:59 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Edward Srouji <edwards@nvidia.com>
Cc: jgg@ziepe.ca, linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
	parav@nvidia.com, cratiu@nvidia.com, vdumitrescu@nvidia.com,
	kuba@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com,
	gal@nvidia.com, idosch@nvidia.com
Subject: Re: [PATCH v1 0/4] Fix local destination address resolution with VRF
Message-ID: <20250918092459.GC10800@unreal>
References: <20250907160833.56589-1-edwards@nvidia.com>
 <20250916111103.84069-1-edwards@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916111103.84069-1-edwards@nvidia.com>

On Tue, Sep 16, 2025 at 02:10:59PM +0300, Edward Srouji wrote:
> From Parav:
> 
> Presently, address resolve routines consider a destination to be local
> if the next-hop device of the resolved route for the destination is the 
> loopback netdevice. While this works for simple configurations, it fails
> when the source and destination IP addresses belong to an enslaved
> netdevice of a VRF.
> In that case the next-hop device is the VRF itself, so packets are 
> generated with an incorrect destination MAC on the VRF netdevice and 
> ib_write_bw times out.
> 
> This patch series fixes that by determining whether a destination is
> local based on the resolved route's type rather than on the next-hop
> netdevice's loopback flag.
> That approach resolves loopback traffic consistently both with and 
> without VRF configurations.
> 
> This series contains 4 patches:
>   1/4: refactor address resolution code for reuse by subsequent patches
>   2/4: resolve destination MAC via IP stack
>   3/4: use route table entry instead of netdev loopback flag
>   4/4: fix netdev lookup for IPoIB interfaces
> 
> Parav.
> 
> ---
> 
> Changelog:
> v0 -> v1:
> - Addressed comments from Leon
> - Updated commit message to reflect that dev_addr fields are invalid in
>   case of failure in PATCH 1/4
> - Removed incorrect commit log about 'no functional change' in PATCH 1/4
> 
> v0: https://lore-kernel.gnuweeb.org/lkml/20250907160833.56589-5-edwards@nvidia.com/T/
> 
> ---
> 
> Parav Pandit (3):
>   RDMA/core: Squash a single user static function
>   RDMA/core: Resolve MAC of next-hop device without ARP support
>   RDMA/core: Use route entry flag to decide on loopback traffic
> 
> Vlad Dumitrescu (1):
>   IB/ipoib: Ignore L3 master device
> 
>  drivers/infiniband/core/addr.c            | 83 +++++++++++------------
>  drivers/infiniband/ulp/ipoib/ipoib_main.c | 21 +++---
>  2 files changed, 50 insertions(+), 54 deletions(-)

I applied this series, but please never send series as reply-to. It
broke all flows: b4 automatic apply script, patchworks and "Thanks you .."
email.

Thanks

> 
> -- 
> 2.21.3
> 

