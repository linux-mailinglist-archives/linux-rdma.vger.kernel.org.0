Return-Path: <linux-rdma+bounces-7809-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0BC5A3A766
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 20:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB24B167B93
	for <lists+linux-rdma@lfdr.de>; Tue, 18 Feb 2025 19:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B711E5200;
	Tue, 18 Feb 2025 19:28:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5jdeo6/"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3BA21B9C4;
	Tue, 18 Feb 2025 19:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739906908; cv=none; b=o/wJ8VPGOnpJ+M2SC3FvEmXUuRPVUQXQP4IVCiuHu4q8rRgz/IlOUIXkNrRSKcPgFo+kMQmQdwHxqClu8+mIwyNvZzXNjLnDmleH9voDRzbJ5HU+rbjDu/IaXWsZfa0GI1XgVmz3ac5hxEJx9T71WTnOoGPxMnu3kfAlkS4Kpio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739906908; c=relaxed/simple;
	bh=Hd/wpagtTZgfh/zMS4gO2X0hOemS9snGzg/7cCUNl6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nrDZL9+qYfiWr0MR85h0EgjvULyPq4YEZpWtq3p4lzNRE75gnWfRJQ24X5HGdTb7gM6FyjxKbYYOaGqQbhWYYM0pde97iqrMjB+EiC88WBWMFqhbBqfswXAGkgqlMA8no0QO95SuXxL9BJGLyNaVBA4IHAoSWebN910D0ibdU98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5jdeo6/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C024C4CEE2;
	Tue, 18 Feb 2025 19:28:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739906907;
	bh=Hd/wpagtTZgfh/zMS4gO2X0hOemS9snGzg/7cCUNl6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5jdeo6/AwQNp+5fHQjex3bLr9gJvL6fnCgf96u1ElyWhiIxzjOxU6Tihhnns4Juy
	 v78+KUGpg5B2d/QQju5dr8uc8IGLhVLrFocthBc0isZFbQvwJM0EzDQMqsqHyRcObT
	 2Ztjzi1NURJ5lsgW8OwlZcG8M4UxFITln2b/fa7/okcKBtH03kQlRNx2MDg3Chxded
	 8Y3kc54LHlZTeaBPsdGjb4Mh/d8tSLaUg264Fqs5WHZZO2ZkmO7sYmNPQ0EgP60c4t
	 n51PDYTCMHq/4rYUDUQiueM5TzJuSV0PkIbxZpKtaNuNxB9GEx5oSz3IhzawNtjeUM
	 WHwVrHlbHqQAw==
Date: Tue, 18 Feb 2025 21:28:22 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Shannon Nelson <shannon.nelson@amd.com>
Cc: jgg@nvidia.com, andrew.gospodarek@broadcom.com,
	aron.silverton@oracle.com, dan.j.williams@intel.com,
	daniel.vetter@ffwll.ch, dave.jiang@intel.com, dsahern@kernel.org,
	gospo@broadcom.com, hch@infradead.org, itayavr@nvidia.com,
	jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
	lbloch@nvidia.com, saeedm@nvidia.com, linux-cxl@vger.kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	brett.creeley@amd.com
Subject: Re: [RFC PATCH fwctl 2/5] pds_core: add new fwctl auxilary_device
Message-ID: <20250218192822.GA53094@unreal>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
 <20250211234854.52277-3-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211234854.52277-3-shannon.nelson@amd.com>

On Tue, Feb 11, 2025 at 03:48:51PM -0800, Shannon Nelson wrote:
> Add support for a new fwctl-based auxiliary_device for creating a
> channel for fwctl support into the AMD/Pensando DSC.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
>  drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
>  drivers/net/ethernet/amd/pds_core/core.h   |  1 +
>  drivers/net/ethernet/amd/pds_core/main.c   | 10 ++++++++++
>  include/linux/pds/pds_common.h             |  2 ++
>  5 files changed, 21 insertions(+), 2 deletions(-)

<...>

My comment is only slightly related to the patch itself, but worth to
write it anyway.

> diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
> index 5802e1deef24..b193adbe7cc3 100644
> --- a/include/linux/pds/pds_common.h
> +++ b/include/linux/pds/pds_common.h
> @@ -29,6 +29,7 @@ enum pds_core_vif_types {
>  	PDS_DEV_TYPE_ETH	= 3,
>  	PDS_DEV_TYPE_RDMA	= 4,
>  	PDS_DEV_TYPE_LM		= 5,
> +	PDS_DEV_TYPE_FWCTL	= 6,

This enum and defines below should be cleaned from unsupported types.
I don't see any code for RDMA, LM and ETH.

Thanks

>  
>  	/* new ones added before this line */
>  	PDS_DEV_TYPE_MAX	= 16   /* don't change - used in struct size */
> @@ -40,6 +41,7 @@ enum pds_core_vif_types {
>  #define PDS_DEV_TYPE_ETH_STR	"Eth"
>  #define PDS_DEV_TYPE_RDMA_STR	"RDMA"
>  #define PDS_DEV_TYPE_LM_STR	"LM"
> +#define PDS_DEV_TYPE_FWCTL_STR	"fwctl"
>  
>  #define PDS_VDPA_DEV_NAME	PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_VDPA_STR
>  #define PDS_VFIO_LM_DEV_NAME	PDS_CORE_DRV_NAME "." PDS_DEV_TYPE_LM_STR "." PDS_DEV_TYPE_VFIO_STR
> -- 
> 2.17.1
> 
> 

