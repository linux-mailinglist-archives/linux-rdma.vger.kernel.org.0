Return-Path: <linux-rdma+bounces-8534-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F00DA59EBA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 18:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89E797A6319
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 17:32:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B9AD232376;
	Mon, 10 Mar 2025 17:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rtv7rRMW"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23ABA1DE89C;
	Mon, 10 Mar 2025 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628032; cv=none; b=DNsY9ch3l1flEpTdkKs4m4xD7bNQ0DcPS1B553HBK/cnSvoqCqyEF87RAvnSQhmLWYRUvxmSFpryAIcLU+nXDhg5fvunkoibQXIbWEqjrX47xZUbgmcMn8ERvBpdcrjGKQYKTUeWM6eADdfX2vyLUXRnan5tUzQaS/GBQldmS8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628032; c=relaxed/simple;
	bh=bEw+maa9WTZgzg9XdjAN2+u5BKdXeYeziA/QuptI0UE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJ5uDI5v0tfBYkN3egjDVuWBk3Iv1ADrJrt5JiWEvMibjzWpWOpdnA4twAGCxJEu+KKHEa5qJ5oK9dTsJeNAMjmFV9O1LWZokDUDPxDGPC0HfRrxGa2WlB79ris2BdP1mCOFL9Kx0xxF28+1BHOM0cniuQNicmtpxIuLVxauC84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rtv7rRMW; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741628031; x=1773164031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bEw+maa9WTZgzg9XdjAN2+u5BKdXeYeziA/QuptI0UE=;
  b=Rtv7rRMW/dyvV2K+ghEJPXIBn9S6zmMbf+yPQ+bNRNqrrswuFtNrBmmr
   /bPYycsWju+KAP7/7znfqoplfp4E4awAx6CYcNygOXQJKBRKag6AvObcE
   ri5Zo2NprdHPoTXutikFpG8AoN+GxmN3W+yXCA4Z90HYfnEEMCbB8GbhZ
   Trn9xR8ZIfdpXcSShUdMEPEKsrN9+LasWT7D6ui5X0aPzFmIT8nj/tAjU
   7fj0WwYxp0q3TElIpPYAqHgLART6FZkz4BltBIaC37ZK7SLsugzm3AKnD
   Y9X+oRZ/RqcXZwo8Tiiba2kjgvMs8nw5hFDhXX89118GkCZKhvd+BYGxB
   w==;
X-CSE-ConnectionGUID: wwikmW3tTf2sDYXd39vRog==
X-CSE-MsgGUID: oX+XrQ/aS0y9whj2AWb6gw==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="60185460"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="60185460"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:33:49 -0700
X-CSE-ConnectionGUID: X/2N4jYSQFungwLnd0V0xw==
X-CSE-MsgGUID: pqdFuhrhSAuUkFZwA+K1Vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120578013"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:33:48 -0700
Message-ID: <d63a0509-404a-4abd-90b9-d5ebb408ce98@intel.com>
Date: Mon, 10 Mar 2025 10:33:45 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] pds_core: add new fwctl auxiliary_device
To: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-4-shannon.nelson@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250307185329.35034-4-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 11:53 AM, Shannon Nelson wrote:
> Add support for a new fwctl-based auxiliary_device for creating a
> channel for fwctl support into the AMD/Pensando DSC.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

minor comment below

> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c |  4 ++--
>  drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
>  drivers/net/ethernet/amd/pds_core/core.h   |  1 +
>  drivers/net/ethernet/amd/pds_core/main.c   | 14 +++++++++++++-
>  include/linux/pds/pds_common.h             |  2 ++
>  5 files changed, 25 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 563de9e7ce0a..c9aeb56e8174 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -224,8 +224,8 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>  	}
>  
>  	/* Verify that the type is supported and enabled.  It is not
> -	 * an error if there is no auxbus device support for this
> -	 * VF, it just means something else needs to happen with it.
> +	 * an error if the firmware doesn't support the feature, we
> +	 * just won't set up an auxiliary_device for it.

s/, we just/; the driver/

DJ



>  	 */
>  	vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
>  	if (!(vt_support &&
> diff --git a/drivers/net/ethernet/amd/pds_core/core.c b/drivers/net/ethernet/amd/pds_core/core.c
> index 536635e57727..1eb0d92786f7 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.c
> +++ b/drivers/net/ethernet/amd/pds_core/core.c
> @@ -402,6 +402,9 @@ static int pdsc_core_init(struct pdsc *pdsc)
>  }
>  
>  static struct pdsc_viftype pdsc_viftype_defaults[] = {
> +	[PDS_DEV_TYPE_FWCTL] = { .name = PDS_DEV_TYPE_FWCTL_STR,
> +				 .vif_id = PDS_DEV_TYPE_FWCTL,
> +				 .dl_id = -1 },
>  	[PDS_DEV_TYPE_VDPA] = { .name = PDS_DEV_TYPE_VDPA_STR,
>  				.vif_id = PDS_DEV_TYPE_VDPA,
>  				.dl_id = DEVLINK_PARAM_GENERIC_ID_ENABLE_VNET },
> @@ -428,6 +431,10 @@ static int pdsc_viftypes_init(struct pdsc *pdsc)
>  
>  		/* See what the Core device has for support */
>  		vt_support = !!le16_to_cpu(pdsc->dev_ident.vif_types[vt]);
> +
> +		if (vt == PDS_DEV_TYPE_FWCTL)
> +			pdsc->viftype_status[vt].enabled = true;
> +
>  		dev_dbg(pdsc->dev, "VIF %s is %ssupported\n",
>  			pdsc->viftype_status[vt].name,
>  			vt_support ? "" : "not ");
> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
> index f075e68c64db..0bf320c43083 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.h
> +++ b/drivers/net/ethernet/amd/pds_core/core.h
> @@ -156,6 +156,7 @@ struct pdsc {
>  	struct dentry *dentry;
>  	struct device *dev;
>  	struct pdsc_dev_bar bars[PDS_CORE_BARS_MAX];
> +	struct pds_auxiliary_dev *padev;
>  	struct pdsc_vf *vfs;
>  	int num_vfs;
>  	int vf_id;
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index a3a68889137b..4843f9249a31 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -265,6 +265,10 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>  
>  	mutex_unlock(&pdsc->config_lock);
>  
> +	err = pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL, &pdsc->padev);
> +	if (err)
> +		goto err_out_stop;
> +
>  	dl = priv_to_devlink(pdsc);
>  	devl_lock(dl);
>  	err = devl_params_register(dl, pdsc_dl_params,
> @@ -273,7 +277,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>  		devl_unlock(dl);
>  		dev_warn(pdsc->dev, "Failed to register devlink params: %pe\n",
>  			 ERR_PTR(err));
> -		goto err_out_stop;
> +		goto err_out_del_dev;
>  	}
>  
>  	hr = devl_health_reporter_create(dl, &pdsc_fw_reporter_ops, 0, pdsc);
> @@ -296,6 +300,8 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>  err_out_unreg_params:
>  	devlink_params_unregister(dl, pdsc_dl_params,
>  				  ARRAY_SIZE(pdsc_dl_params));
> +err_out_del_dev:
> +	pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  err_out_stop:
>  	pdsc_stop(pdsc);
>  err_out_teardown:
> @@ -427,6 +433,7 @@ static void pdsc_remove(struct pci_dev *pdev)
>  		 * shut themselves down.
>  		 */
>  		pdsc_sriov_configure(pdev, 0);
> +		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  
>  		timer_shutdown_sync(&pdsc->wdtimer);
>  		if (pdsc->wq)
> @@ -485,6 +492,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>  		if (!IS_ERR(pf))
>  			pdsc_auxbus_dev_del(pdsc, pf,
>  					    &pf->vfs[pdsc->vf_id].padev);
> +	} else {
> +		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  	}
>  
>  	pdsc_unmap_bars(pdsc);
> @@ -531,6 +540,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
>  		if (!IS_ERR(pf))
>  			pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
>  					    &pf->vfs[pdsc->vf_id].padev);
> +	} else {
> +		pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL,
> +				    &pdsc->padev);
>  	}
>  }
>  
> diff --git a/include/linux/pds/pds_common.h b/include/linux/pds/pds_common.h
> index 5802e1deef24..b193adbe7cc3 100644
> --- a/include/linux/pds/pds_common.h
> +++ b/include/linux/pds/pds_common.h
> @@ -29,6 +29,7 @@ enum pds_core_vif_types {
>  	PDS_DEV_TYPE_ETH	= 3,
>  	PDS_DEV_TYPE_RDMA	= 4,
>  	PDS_DEV_TYPE_LM		= 5,
> +	PDS_DEV_TYPE_FWCTL	= 6,
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


