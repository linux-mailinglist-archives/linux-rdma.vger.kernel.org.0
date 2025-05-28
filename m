Return-Path: <linux-rdma+bounces-10846-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8037EAC679D
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 12:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA6717B63C
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 10:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5E9E27A129;
	Wed, 28 May 2025 10:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iAfhC0NO"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B3920B806;
	Wed, 28 May 2025 10:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748429052; cv=none; b=MEcy1m+seYhdzEp6K/UvmdibDvGwx3n9wFTvlHV8egKo4fLRHONGsL36O8neWiS/fAx/kHdx706PRxiuqemH4gmCKqLTnkfUs/5NGly+X3pvDSS33/rFitxXvBQZk59KvgM08FVQFXLuHm8+CzxxY02Qd1XRt6t1S8mjSQrq/+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748429052; c=relaxed/simple;
	bh=3VvPOVTPfky32Wj9xAy3aa71oo39L3aLtSBZat6Oa24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qIYRxwm0kX+UF5AeUf4EGlFiTidCDRmWjtOEaC+b6fEhNe9mQNLDejJB3U2E+Use03g/efDUtfKrCzxhh87NI3s8udtwm8YDjp0Vw5ulw3dllR0UofpAGwPNCwL03lj+le90jV9dS7a19pNKKqPOURVrm0l8ago6onyy0fNH/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iAfhC0NO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 150C5C4CEE7;
	Wed, 28 May 2025 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748429051;
	bh=3VvPOVTPfky32Wj9xAy3aa71oo39L3aLtSBZat6Oa24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iAfhC0NOSWJRUFmNUInJJGJ+OcGalmd/KFHT76JPvejknwJ0KvYoKWJ5OlSIxiYMi
	 WuJ4MFd+ISoa5ml1UB6xM3XB3g/DPM9t6caFglVpa9o1V1C+xIlk6uQ6bOtaY81nNJ
	 LKDpDlXRp4FJgJQDkH5YtzQLrC9vdS3LW2zFgxR3n97RkJvhYiQO3OmBB/ps9hedKI
	 93hzPUP1oK8dOu9W9pHmY17HilN5WJP5asMnTQ4btdOTyHPzhnAOsbl63a67y2DfmG
	 vRlyrj3q16EGiAcb2ZjYKkR0jponXhr4iFLfo2Q0+P1/y/pB/e4oqCLMXjvbmOK726
	 OU51rkUSyZX/A==
Date: Wed, 28 May 2025 11:44:07 +0100
From: Simon Horman <horms@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, jgg@nvidia.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
	anthony.l.nguyen@intel.com, Joshua Hay <joshua.a.hay@intel.com>
Subject: Re: [iwl-next 6/6] idpf: implement get LAN MMIO memory regions
Message-ID: <20250528104407.GB365796@horms.kernel.org>
References: <20250523170435.668-1-tatyana.e.nikolova@intel.com>
 <20250523170435.668-7-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523170435.668-7-tatyana.e.nikolova@intel.com>

On Fri, May 23, 2025 at 12:04:35PM -0500, Tatyana Nikolova wrote:
> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> The RDMA driver needs to map its own MMIO regions for the sake of
> performance, meaning the IDPF needs to avoid mapping portions of the BAR
> space. However, the IDPF cannot assume where these are and must avoid
> mapping hard coded regions as much as possible.
> 
> The IDPF maps the bare minimum to load and communicate with the
> control plane, i.e., the mailbox registers and the reset state
> registers. Because of how and when mailbox reigster offsets are
> initialized, it is easier to adjust the existing defines to be relative
> to the mailbox region starting address. Use a specific mailbox register
> write function that uses these relative offsets. The reset state
> register addresses are calculated the same way as for other registers,
> described below.
> 
> The IDPF then calls a new virtchnl op to fetch a list of MMIO regions
> that it should map. The addresses for the registers in these regions are
> calculated by determining what region the register resides in, adjusting
> the offset to be relative to that region, and then adding the
> register's offset to that region's mapped address.
> 
> If the new virtchnl op is not supported, the IDPF will fallback to
> mapping the whole bar. However, it will still map them as separate
> regions outside the mailbox and reset state registers. This way we can
> use the same logic in both cases to access the MMIO space.
> 
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c

...

> @@ -447,12 +469,15 @@ int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
>   */
>  void idpf_idc_deinit_core_aux_device(struct iidc_rdma_core_dev_info *cdev_info)
>  {
> +	struct iidc_rdma_priv_dev_info *privd = cdev_info->iidc_priv;
> +

Hi Joshua, Tatyana, all,

On the line below it is assumed that cdev_info may be NULL.
But on the line above cdev_info is unconditionally dereferenced.
This doesn't seem consistent.

Flagged by Smatch.

>  	if (!cdev_info)
>  		return;
>  
>  	idpf_unplug_aux_dev(cdev_info->adev);
>  
> -	kfree(cdev_info->iidc_priv);
> +	kfree(privd->mapped_mem_regions);
> +	kfree(privd);
>  	kfree(cdev_info);
>  }
>  

...

