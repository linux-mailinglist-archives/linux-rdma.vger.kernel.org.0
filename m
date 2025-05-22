Return-Path: <linux-rdma+bounces-10522-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E79AC0807
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 10:59:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6218E3A50D2
	for <lists+linux-rdma@lfdr.de>; Thu, 22 May 2025 08:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43979286415;
	Thu, 22 May 2025 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="beOWBqJG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A359C27C869;
	Thu, 22 May 2025 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904234; cv=none; b=PCsMAcrKxpxLGfFe6VYnojtPJX6rTekDRPq1FiCJroL58gk6Mx/J4QqiuV+E4gNoDruJvkc/lQglLGJ5nclC68cLon7TEfnuRBdvSnc6M9h+mgENXYJZpjfyUG/yiWk98WQe+bLswW+dxCPQQVzcfhzL4+04hg/Y+Zzeufqkdiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904234; c=relaxed/simple;
	bh=ydkaUK3wouda2Zq0gztkdTwGivh4JjLzuWEGh4AtuY0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iaq2BE76lnjvclbXoHJ6J8wFkeptjA3/9ovy1OypQ5Wt8WE+2EBiVSJJOMG0poXVdwn4dsSyAW9T2+Mogdr1xJhR5I8Cf21oS/nCxToqfG+C67O3RORqeKBGkF8wvTKrrV2VOSAN1deTcE8ckz/x38zA+e/w4OPskQoLIW7rzmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=beOWBqJG; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747904233; x=1779440233;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ydkaUK3wouda2Zq0gztkdTwGivh4JjLzuWEGh4AtuY0=;
  b=beOWBqJGY6OLCAwPHcb1szR5rG5hjJWO4/cI27z7IEzFkhLpxCX+D4Mu
   1Jbd5CpNyDOAETUR6KPD/XNsdEg3KoRElFqozx6JxOuCO0lS+gijBoi0H
   1x2igG0aeF4tOZVD4m1wJOlMju+ae1ROS4J/bq9RunAaFYsq6PQHjMdpL
   Qh8rVpgjcYp8EeGHndRH+NbJGFbLT3ZIKiyIdwoUVWmsLCKIY1ulMipYD
   Ii5pvbAu9NYl45EIwgy+SNCD0dmH/DsFdDxCY3j00rTlZ2JNlYQ7hX754
   04eUCmlpkJRIgAgMra6aOLxUgVZlkiUUOnqKW6Ri2yFjnP3A5Gx0NMqoF
   w==;
X-CSE-ConnectionGUID: fbuGTL4+TMuc1A904oTCpA==
X-CSE-MsgGUID: 555lSB/0QU6/jLd0i/vz/g==
X-IronPort-AV: E=McAfee;i="6700,10204,11440"; a="61259888"
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="61259888"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 01:57:09 -0700
X-CSE-ConnectionGUID: FMCyh0FiRPmXd2hwpibqDw==
X-CSE-MsgGUID: GOjCuW2NRHenkmUhJ8Yn6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,305,1739865600"; 
   d="scan'208";a="145470752"
Received: from soc-5cg4396xfb.clients.intel.com (HELO [172.28.180.67]) ([172.28.180.67])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2025 01:57:06 -0700
Message-ID: <5e6f4582-4c4a-461f-8298-c9ce207eae25@linux.intel.com>
Date: Thu, 22 May 2025 10:57:01 +0200
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/2] net/mlx5: Ensure fw pages are always allocated on
 same NUMA
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Moshe Shemesh <moshe@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Gal Pressman <gal@nvidia.com>
References: <1747895286-1075233-1-git-send-email-tariqt@nvidia.com>
 <1747895286-1075233-2-git-send-email-tariqt@nvidia.com>
Content-Language: pl, en-US
From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
In-Reply-To: <1747895286-1075233-2-git-send-email-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2025-05-22 8:28 AM, Tariq Toukan wrote:
> From: Moshe Shemesh <moshe@nvidia.com>
> 
> When firmware asks the driver to allocate more pages, using event of
> give_pages, the driver should always allocate it from same NUMA, the
> original device NUMA. Current code uses dev_to_node() which can result
> in different NUMA as it is changed by other driver flows, such as
> mlx5_dma_zalloc_coherent_node(). Instead, use saved numa node for
> allocating firmware pages.
> 
> Fixes: 311c7c71c9bb ("net/mlx5e: Allocate DMA coherent memory on reader NUMA node")
> Signed-off-by: Moshe Shemesh <moshe@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> index 972e8e9df585..9bc9bd83c232 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/pagealloc.c
> @@ -291,7 +291,7 @@ static void free_4k(struct mlx5_core_dev *dev, u64 addr, u32 function)
>   static int alloc_system_page(struct mlx5_core_dev *dev, u32 function)
>   {
>   	struct device *device = mlx5_core_dma_dev(dev);
> -	int nid = dev_to_node(device);
> +	int nid = dev->priv.numa_node;

Reviewed-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

Thanks,
Dawid

>   	struct page *page;
>   	u64 zero_addr = 1;
>   	u64 addr;


