Return-Path: <linux-rdma+bounces-14704-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CE511C7DEFD
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 10:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 059593501BE
	for <lists+linux-rdma@lfdr.de>; Sun, 23 Nov 2025 09:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F042BEC3A;
	Sun, 23 Nov 2025 09:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f7jifpVG"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0FF19F41C;
	Sun, 23 Nov 2025 09:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763890165; cv=none; b=IRfadQEZlEzRJK53Z012pw0BQQO+fN9loJLZ0A9PfpIbUx0zXa+mnkgA1rB8dYYmqC3byn4W7HjUDRDoKi1RfYnMMExtr6VYAPRQ7Gxr1t+Lp4HRTcNSYEn7N/2+i+DDsMAqscnMnPtF4brJVDZqB61ARZUBwFRn2KfCvKOqHzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763890165; c=relaxed/simple;
	bh=2I+PL6KFXMf1ExzwcEo6rxHgBhtJ6ZnSKe1DUCdju6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fBCcBESzh3qc2LGb2EUxOI0pDh79sUXK5red/bkgtES/RyjwUs6eH0a2WXI65LybV7B6dDbdljihvNPqI+/pkYRFnJ13GR11Pe08/eqdDYWsU4iGnRNNMiknIABvLr9TYT9pFkPsE8l/4oERqTmgjtJuQQtn5DumFHFY8emfr0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f7jifpVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0853C113D0;
	Sun, 23 Nov 2025 09:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763890164;
	bh=2I+PL6KFXMf1ExzwcEo6rxHgBhtJ6ZnSKe1DUCdju6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f7jifpVGDAqPpKDkZuO/QsfToNbQDpJa2kAFJZk4yAylfgk/MeL1ezsABScoWiTZO
	 Ku+OXoOcjccsTnJNVU1zQf9yPlmKH06vJWutPJzn1yH3BptuD9feIUO/MnErEuPISq
	 r5y6WFdsKU3khR65MZEj5AZhn/N47JUrWgdbQB0EVoDMyAI+E3GaUQJBay4euzi31x
	 O2AVOrQYiTC2cLaDfjgimQSwJ6eL1aMJuZUtR1ois0Q7WcCFXdl75NooHFy9CX/xz8
	 XRwqfzPfl99hPRywUKEZspXnVUBxauU8sJxNXjtiaWVG6jVwA0A0i8bA5DudifPBwP
	 92yJNUREfDQWA==
Date: Sun, 23 Nov 2025 11:29:20 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Christian Benvenuti <benve@cisco.com>,
	Heiko Stuebner <heiko@sntech.de>, iommu@lists.linux.dev,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Joerg Roedel <joro@8bytes.org>,
	linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-rdma@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Nelson Escobar <neescoba@cisco.com>,
	Rob Clark <robin.clark@oss.qualcomm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Samuel Holland <samuel@sholland.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Chen-Yu Tsai <wens@csie.org>, Will Deacon <will@kernel.org>,
	Yong Wu <yong.wu@mediatek.com>, Lu Baolu <baolu.lu@linux.intel.com>,
	Kevin Tian <kevin.tian@intel.com>, patches@lists.linux.dev,
	Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v3 1/3] RDMA/usnic: Remove iommu_set_fault_handler()
Message-ID: <20251123092920.GB16619@unreal>
References: <0-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
 <1-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1-v3-e5d08e2d551e+109-iommu_set_fault_jgg@nvidia.com>

On Thu, Nov 20, 2025 at 03:46:22PM -0400, Jason Gunthorpe wrote:
> The handler in usnic just prints a fault report message, the iommu drivers
> all do a better job of that these days. Just remove the use of this old
> API.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Acked-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
> ---
>  drivers/infiniband/hw/usnic/usnic_uiom.c | 13 -------------
>  1 file changed, 13 deletions(-)
>

I imagine that you want to merge this patch through iommu tree.

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

