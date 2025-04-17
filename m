Return-Path: <linux-rdma+bounces-9515-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0025BA91A9C
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 13:21:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54E8B5A7708
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Apr 2025 11:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D819123BFA9;
	Thu, 17 Apr 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sq3quHBK"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9512523A9A6;
	Thu, 17 Apr 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744888907; cv=none; b=RUQQEbiGzwPLgLobk2o/GMAQtJv3Nya/nf7P1NIWHxhS4SfQRirXrCn1FhxlPhd4r0wm/sfSC7GihGELUO4Drj/QTlY7/uwTNbuT7lSp/VIScRL/a62cjkbe23d8x+E4xP+2aG6cOQgZJHZbbghvhkHSarbMFoQwg6XcROzQflI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744888907; c=relaxed/simple;
	bh=cKGsn1KKHqWxVH9Dg8CQ8Go9CXiV1USwr3gjtvak9Lw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuxBsNlVirBQs62TDE9jpoTJ3bigpatrFnJq28Wa9Fop+UDUsNC7D5UuYKyAa4weTsN9uHEYw1bsUO5D0vxvbNilF/c/CU8IffrJSzewPjqpDSFQSV0fgI+40d0Jq1J061mpRogLJAPItcZZDgKgINePh1VG3awhoHU0wMlAvug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sq3quHBK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1029FC4CEE4;
	Thu, 17 Apr 2025 11:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744888907;
	bh=cKGsn1KKHqWxVH9Dg8CQ8Go9CXiV1USwr3gjtvak9Lw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sq3quHBK8r91e3sTPAplQTi/VY5dF0nGMvoUvkCMPSWTWMB+oC6B9m9XQEaYxPTCJ
	 bpcJ8nwotmnvrt0hpiQnRnH4KWwj+CoUoYRz7EJco8YWoxH0H0X+RE2fgfGnPR4D3V
	 rA0olR3hV4ckmuSd9y4WG1ztQbqSi7zNWyaMhX/CRuPUBC2P6KazToDz2MD1qS5qoL
	 6lF0C2c+11irXZo7n2yxazFbTuITAyuq0BNadldMUig+brvmUN9iY6QzeIWQO8VKXx
	 WDNDM2nNt2xMhbvAylmBUZwu1FAHdQqt/pRu98RgEXwigeW6mn/fnCwu3ONWa8mpz7
	 mLFmQSjbInfTQ==
Date: Thu, 17 Apr 2025 12:21:43 +0100
From: Simon Horman <horms@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: jgg@nvidia.com, leon@kernel.org, intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [iwl-next v5 5/5] iidc/ice/irdma: Update IDC to support multiple
 consumers
Message-ID: <20250417112143.GE2430521@horms.kernel.org>
References: <20250416021549.606-1-tatyana.e.nikolova@intel.com>
 <20250416021549.606-6-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250416021549.606-6-tatyana.e.nikolova@intel.com>

On Tue, Apr 15, 2025 at 09:15:49PM -0500, Tatyana Nikolova wrote:
> From: Dave Ertman <david.m.ertman@intel.com>
> 
> In preparation of supporting more than a single core PCI driver
> for RDMA, move ice specific structs like qset_params, qos_info
> and qos_params from iidc_rdma.h to iidc_rdma_ice.h.
> 
> Previously, the ice driver was just exporting its entire PF struct
> to the auxiliary driver, but since each core driver will have its own
> different PF struct, implement a universal struct that all core drivers
> can provide to the auxiliary driver through the probe call.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Dave Ertman <david.m.ertman@intel.com>
> Co-developed-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Signed-off-by: Mustafa Ismail <mustafa.ismail@intel.com>
> Co-developed-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
> Co-developed-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> index fcb199efbea5..4af60e2f37df 100644
> --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> @@ -1339,8 +1339,13 @@ ice_devlink_enable_roce_get(struct devlink *devlink, u32 id,
>  			    struct devlink_param_gset_ctx *ctx)
>  {
>  	struct ice_pf *pf = devlink_priv(devlink);
> +	struct iidc_rdma_core_dev_info *cdev;
>  
> -	ctx->val.vbool = pf->rdma_mode & IIDC_RDMA_PROTOCOL_ROCEV2 ? true : false;
> +	cdev = pf->cdev_info;
> +	if (!cdev)
> +		return -ENODEV;

Is it possible for cdev to be NULL here?

Likewise for other checks for NULL arguments passed to functions
elsewhere in this patch.

> +
> +	ctx->val.vbool = !!(cdev->rdma_protocol & IIDC_RDMA_PROTOCOL_ROCEV2);
>  
>  	return 0;
>  }

...

