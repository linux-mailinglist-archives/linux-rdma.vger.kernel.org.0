Return-Path: <linux-rdma+bounces-10845-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FDDDAC6725
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 12:40:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9CB63AC71B
	for <lists+linux-rdma@lfdr.de>; Wed, 28 May 2025 10:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3B279907;
	Wed, 28 May 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DBNy2Q7A"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF6918DB03;
	Wed, 28 May 2025 10:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748428847; cv=none; b=oro+uZAhJqw1nMPmSM44l47aMBFWUMch0Q3iNzmBqfqD6W20hS2GgLgpAj4E+m7+/S/Cqj62y0kpB9fXhUpfuMu9QE6deWUHA+WQKBoK+lBSjTvvtC0BBWFnSAzPDuwnK8OjcmbNFa3T1sHWvIn5USOOipcWDsmmhqWwZpp3EHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748428847; c=relaxed/simple;
	bh=VX4AsLj/Fc3QRbtPLrfPBaZuthCoHrVRnGWu/0hh6/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iqjSx7vK9pLPzJGAPFNps0aZPvbnpEfpkVfkngRsEyWzZy//6h/V6yhG6Zta39JZeApzu7V5hY49wjl2ykC7FxSwU8Jsgi5V5y04b1SXOBQ7iJOihxUVMT/mfZ9IIuakHKZpwyh5L1+jJvhWcl4mMKy3Nk+iCyNhSdthjX7SOZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DBNy2Q7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EA0C4CEE7;
	Wed, 28 May 2025 10:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748428847;
	bh=VX4AsLj/Fc3QRbtPLrfPBaZuthCoHrVRnGWu/0hh6/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DBNy2Q7AqCm7rbyZI1/Jwu3dX6jaQZ/uR/Rm/RMLrneZa5W0YNMtjfnF4IhVJ81Vz
	 j1htjKwNoaxpCO69J7Sxq0+CjDEeD2DrE00VFngcduUeDKqDAD2/8j2ZRNVU7No2WD
	 3q9yS/S2311vS0svJnbhPEdfvNn6TSF388x/PAiWmEcWZjbkMAyG3+DSN3/MHdlZ1M
	 B0hZpF1RFvR0Lbj6Pdv4JyDRMRRpyv+k3JAhFkAFmQ1gkgcsgn6lchNfQmfPkYOHSs
	 4J0dC1ZockszvKCn866jqlPRcaaCumJj80bWPOQ9pYeYLIbZeqBp7NAvRHO3Au2GZ+
	 0ypxKvEiA9HQw==
Date: Wed, 28 May 2025 11:40:43 +0100
From: Simon Horman <horms@kernel.org>
To: Tatyana Nikolova <tatyana.e.nikolova@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, jgg@nvidia.com, leon@kernel.org,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org,
	anthony.l.nguyen@intel.com, Joshua Hay <joshua.a.hay@intel.com>
Subject: Re: [iwl-next 2/6] idpf: implement core RDMA auxiliary dev create,
 init, and destroy
Message-ID: <20250528104043.GA365796@horms.kernel.org>
References: <20250523170435.668-1-tatyana.e.nikolova@intel.com>
 <20250523170435.668-3-tatyana.e.nikolova@intel.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250523170435.668-3-tatyana.e.nikolova@intel.com>

On Fri, May 23, 2025 at 12:04:31PM -0500, Tatyana Nikolova wrote:
> From: Joshua Hay <joshua.a.hay@intel.com>
> 
> Add the initial idpf_idc.c file with the functions to kick off the IDC
> initialization, create and initialize a core RDMA auxiliary device, and
> destroy said device.
> 
> The RDMA core has a dependency on the vports being created by the
> control plane before it can be initialized. Therefore, once all the
> vports are up after a hard reset (either during driver load or a function
> level reset), the core RDMA device info will be created. It is populated
> with the function type (as distinguished by the IDC initialization
> function pointer), the core idc_ops function points (just stubs for
> now), the reserved RDMA MSIX table, and various other info the core RDMA
> auxiliary driver will need. It is then plugged on to the bus.
> 
> During a function level reset or driver unload, the device will be
> unplugged from the bus and destroyed.
> 
> Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
> Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
> Signed-off-by: Tatyana Nikolova <tatyana.e.nikolova@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/idpf/idpf_idc.c b/drivers/net/ethernet/intel/idpf/idpf_idc.c

...

> +/**
> + * idpf_idc_init_aux_core_dev - initialize Auxiliary Device(s)
> + * @adapter: driver private data structure
> + * @ftype: PF or VF
> + *
> + * Return: 0 on success or error code on failure.
> + */
> +int idpf_idc_init_aux_core_dev(struct idpf_adapter *adapter,
> +			       enum iidc_function_type ftype)
> +{
> +	struct iidc_rdma_core_dev_info *cdev_info;
> +	struct iidc_rdma_priv_dev_info *privd;
> +	int err;
> +
> +	adapter->cdev_info = kzalloc(sizeof(*cdev_info), GFP_KERNEL);
> +	if (!adapter->cdev_info)
> +		return -ENOMEM;
> +
> +	privd = kzalloc(sizeof(*privd), GFP_KERNEL);
> +	if (!privd) {
> +		err = -ENOMEM;
> +		goto err_privd_alloc;

Hi Joshua, Tatyana, all,

Jumping to err_privd_alloc will free cdev_info.
However cdev_info isn't initialised until a few lines
further down.

Flagged by Smatch.

> +	}
> +
> +	cdev_info = adapter->cdev_info;
> +	cdev_info->iidc_priv = privd;
> +	cdev_info->pdev = adapter->pdev;
> +	cdev_info->rdma_protocol = IIDC_RDMA_PROTOCOL_ROCEV2;
> +	privd->ftype = ftype;
> +
> +	idpf_idc_init_msix_data(adapter);
> +
> +	err = idpf_plug_core_aux_dev(cdev_info);
> +	if (err)
> +		goto err_plug_aux_dev;
> +
> +	return 0;
> +
> +err_plug_aux_dev:
> +	kfree(privd);
> +err_privd_alloc:
> +	kfree(cdev_info);
> +	adapter->cdev_info = NULL;
> +
> +	return err;
> +}

...

