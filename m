Return-Path: <linux-rdma+bounces-13991-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2CDBFF3B2
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 07:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F39614EAA42
	for <lists+linux-rdma@lfdr.de>; Thu, 23 Oct 2025 05:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68066265CDD;
	Thu, 23 Oct 2025 05:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cI3E5xq9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E990261B9E;
	Thu, 23 Oct 2025 05:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761196254; cv=none; b=bMrypUXkwHQ3XIXp1E5nTXYwSBJlxTi2sjX74+Fotd8MNcz13d4CYEoVaKmFT1C2R/I8OpNZTQ3JbqFvvwTaMkBPajD1CVAIT6qb65He275ndEt3KI9aFLuhKAsTljIjfbPPm3X/56mF6adXZvMqTuSPgoEF7pKNocBTmxhw6PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761196254; c=relaxed/simple;
	bh=aKhXAgLHi9hmESNfGrTuSyyU3uGYkrJW93/qzCuJl3Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eltk1zTik8KPmMDqM+W0I6VQnJj3WRVxMyI5V3a3J+UOZAYfVXOSQ/8inOKpGEToBPrDyGSLiCimkF+ka9hKnpS7emTzTo4al9dPtFEiQ3zG5j52oPxHtnk/MD4B30eoIIgr6Bf53uneWqrAt+dLSnpzTpHrqX4m5iV9jkSJ0lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cI3E5xq9; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761196252; x=1792732252;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=aKhXAgLHi9hmESNfGrTuSyyU3uGYkrJW93/qzCuJl3Y=;
  b=cI3E5xq9YVzHxpiUfle5500mgRwE3k645t9R66NHVZjd70kCaC0yHDqI
   y1jeAWx3JwQJPpYuxFOz/CmLUo34LDHVnrTNN0tC5vNDF4PRqfti+aQLD
   62CSD+Dmny/zUCIRrpl6+OUkvpvPPZwHah8s91d3DKr/8sQv9D/7V6az4
   30KmaXle4UP+cECN/aDlur+nsioRFvfjGIfVclctru3hF9jF9KZrS0JHW
   KxIgMIm3eMxUmhbIOVbOLlNM1Y/liqhVU7bTGvM8GHRlr4afHwl75GHmc
   U+cnfeIDGJh0smZpPYDX5s7erxHwDJQHRHH/43kqSRvmV08CbqIL8MtUo
   w==;
X-CSE-ConnectionGUID: 2Btm3/HFR+S3Ju0q4pzW6Q==
X-CSE-MsgGUID: FIueCYzOQDiok9iAdml69Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67000192"
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="67000192"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 22:10:52 -0700
X-CSE-ConnectionGUID: Z+VhdaUHRuSq6XPL/6mgHA==
X-CSE-MsgGUID: PVLbJFWUT5qWiIesV7OmAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,248,1754982000"; 
   d="scan'208";a="214988427"
Received: from allen-sbox.sh.intel.com (HELO [10.239.159.30]) ([10.239.159.30])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 22:10:47 -0700
Message-ID: <9292db0f-74cd-4ce5-8797-cc2a88449768@linux.intel.com>
Date: Thu, 23 Oct 2025 13:06:53 +0800
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] iommu: Allow drivers to say if they use
 report_iommu_fault()
To: Jason Gunthorpe <jgg@nvidia.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Christian Benvenuti <benve@cisco.com>, Heiko Stuebner <heiko@sntech.de>,
 iommu@lists.linux.dev, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Joerg Roedel <joro@8bytes.org>, Leon Romanovsky <leon@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nelson Escobar <neescoba@cisco.com>, Rob Clark
 <robin.clark@oss.qualcomm.com>, Robin Murphy <robin.murphy@arm.com>,
 Samuel Holland <samuel@sholland.org>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
 Yong Wu <yong.wu@mediatek.com>
Cc: patches@lists.linux.dev
References: <3-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <3-v1-391058a85f30+14b-iommu_set_fault_jgg@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/23/25 01:12, Jason Gunthorpe wrote:
> report_iommu_fault() is an older API that has been superseded by
> iommu_report_device_fault() which is capable to support PRI.
> 
> Only two external drivers consume this, drivers/remoteproc and
> drivers/gpu/drm/msm. Ideally they would move over to the new APIs, but for
> now protect against accidentally mix and matching the wrong components.
> 
> The iommu drivers support either the old iommu_set_fault_handler() via the
> driver calling report_iommu_fault(), or they are newer server focused
> drivers that call iommu_report_device_fault().
> 
> Include a flag in the domain_ops if it calls report_iommu_fault() and
> block iommu_set_fault_handler() on iommu's that can't support it.
> 
> Signed-off-by: Jason Gunthorpe<jgg@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu.c   | 1 +
>   drivers/iommu/arm/arm-smmu/qcom_iommu.c | 1 +
>   drivers/iommu/iommu.c                   | 6 +++++-
>   drivers/iommu/ipmmu-vmsa.c              | 1 +
>   drivers/iommu/mtk_iommu.c               | 1 +
>   drivers/iommu/mtk_iommu_v1.c            | 1 +
>   drivers/iommu/omap-iommu.c              | 1 +
>   drivers/iommu/rockchip-iommu.c          | 1 +
>   drivers/iommu/sun50i-iommu.c            | 1 +
>   include/linux/iommu.h                   | 3 +++
>   10 files changed, 16 insertions(+), 1 deletion(-)

Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>

