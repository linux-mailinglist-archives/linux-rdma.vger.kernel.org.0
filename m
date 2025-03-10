Return-Path: <linux-rdma+bounces-8533-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38119A59E05
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 18:27:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 476377A858C
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 17:26:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F338D234970;
	Mon, 10 Mar 2025 17:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BvTMWlw2"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B320F22D4C3;
	Mon, 10 Mar 2025 17:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741627590; cv=none; b=FquVOOljwy8JwAvKgq3KPU9pZhrtDGK0KtTnk5PQzxS0j8+rNLGtIDehkD7J04iZ+EEuDNbD04gpjCjrI0DckI8k29xCUF6E93vVz7QD9bsqtlhGguJqtaCZfl/803/JLVSi8hDWz89b+X9DhlUqh/H1gwL/uzLf2P7QOpfqFcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741627590; c=relaxed/simple;
	bh=+VfDGrZXmuH8meQqP1LdVcLROKhZqTPiinE518t0uuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KyxFvo7lMQn024jJApRchFmMzHIWaK/jx9VIdTC34yrGaGVammFmYv6w52+kZ6f69ODjLJqm+dHOrqQF6heIQOMdZX6ZzVDH5UcfrFkYmGfBBYZFqTzufdxhhHRcUM92ckKW3/pHHdvCPdQnDlpjeXvF7BvplO1wVcqRa2RV510=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BvTMWlw2; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741627588; x=1773163588;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+VfDGrZXmuH8meQqP1LdVcLROKhZqTPiinE518t0uuY=;
  b=BvTMWlw2iBeFAyNzhqB92Pzc930LC2o5/+5LE+wQhkb1DBIWy7ey0Iim
   7jQfortmbkuzgHD8qenzyNOO5OEF3jnHKu83SFMkQIuL4KlqOkcV+5TJo
   /h7cGTt+Tnw+Z/2kuyviwECoLGyifu7+xbEsRkZHxLU3aTf8YgzP1k+oy
   VdL666gnrAd/oKkZu10nv8SyYotDhKsPYgzdx0s3AECay1KFQlewWAoGV
   xp2J7aRu0TP46lf5fg1XSvo4DVyqnJ7u40yx4PEPrkTSUsoFY2ynwLC6J
   aQzFxM+U/PGaUYL50pp/K0/Zbn94LorQJWENQHVPGDZ/07gdesmFQr7nH
   Q==;
X-CSE-ConnectionGUID: pvxQGijuQ6uAraM6AEuclw==
X-CSE-MsgGUID: BAMkM2J+TPWsCsWezpJwdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="60184179"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="60184179"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:26:27 -0700
X-CSE-ConnectionGUID: 8/Z023WDQ+SJhSmkfC2AsA==
X-CSE-MsgGUID: lwrt/YwASnm3E+vXWQYYtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="157268983"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 10:26:26 -0700
Message-ID: <68c66882-3a91-4843-b08e-2f9d5d2d0290@intel.com>
Date: Mon, 10 Mar 2025 10:26:25 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/6] pds_core: specify auxiliary_device to be created
To: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-3-shannon.nelson@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250307185329.35034-3-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 11:53 AM, Shannon Nelson wrote:
> In preparation for adding a new auxiliary_device for the
> PF, make the vif type an argument to pdsc_auxbus_dev_add().

> We also now pass in the address to where we'll keep the new
> padev pointer so that the caller can specify where to save it
> but we can still change it under the mutex and keep the mutex
> usage within the function.

Please consider changing the commit log to use imperative language and avoid using pronouns such as "we". 

https://www.kernel.org/doc/html/v4.17/process/submitting-patches.html#describe-your-changes
https://kernelnewbies.org/PatchPhilosophy#:~:text=Please%20read%20that%20whole%20section,it%20into%20the%20git%20history.

Maybe something like:
Pass in the address of the padev pointer so the caller can specify where to save it. ...

> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c  | 37 ++++++++++-----------
>  drivers/net/ethernet/amd/pds_core/core.h    |  7 ++--
>  drivers/net/ethernet/amd/pds_core/devlink.c |  5 +--
>  drivers/net/ethernet/amd/pds_core/main.c    | 11 +++---
>  4 files changed, 33 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 78fba368e797..563de9e7ce0a 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -175,29 +175,32 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>  	return padev;
>  }
>  
> -void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
> +void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
> +			 struct pds_auxiliary_dev **pd_ptr)
>  {
>  	struct pds_auxiliary_dev *padev;
>  
> +	if (!*pd_ptr)
> +		return;
> +
>  	mutex_lock(&pf->config_lock);
>  
> -	padev = pf->vfs[cf->vf_id].padev;
> -	if (padev) {
> -		pds_client_unregister(pf, padev->client_id);
> -		auxiliary_device_delete(&padev->aux_dev);
> -		auxiliary_device_uninit(&padev->aux_dev);
> -		padev->client_id = 0;
> -	}
> -	pf->vfs[cf->vf_id].padev = NULL;
> +	padev = *pd_ptr;
> +	pds_client_unregister(pf, padev->client_id);
> +	auxiliary_device_delete(&padev->aux_dev);
> +	auxiliary_device_uninit(&padev->aux_dev);
> +	padev->client_id = 0;
> +	*pd_ptr = NULL;
>  
>  	mutex_unlock(&pf->config_lock);
>  }
>  
> -int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
> +int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
> +			enum pds_core_vif_types vt,
> +			struct pds_auxiliary_dev **pd_ptr)
>  {
>  	struct pds_auxiliary_dev *padev;
>  	char devname[PDS_DEVNAME_LEN];
> -	enum pds_core_vif_types vt;
>  	unsigned long mask;
>  	u16 vt_support;
>  	int client_id;
> @@ -206,6 +209,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>  	if (!cf)
>  		return -ENODEV;
>  
> +	if (vt >= PDS_DEV_TYPE_MAX)
> +		return -EINVAL;
> +
>  	mutex_lock(&pf->config_lock);
>  
>  	mask = BIT_ULL(PDSC_S_FW_DEAD) |
> @@ -217,17 +223,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>  		goto out_unlock;
>  	}
>  
> -	/* We only support vDPA so far, so it is the only one to
> -	 * be verified that it is available in the Core device and
> -	 * enabled in the devlink param.  In the future this might
> -	 * become a loop for several VIF types.
> -	 */
> -
>  	/* Verify that the type is supported and enabled.  It is not
>  	 * an error if there is no auxbus device support for this
>  	 * VF, it just means something else needs to happen with it.
>  	 */
> -	vt = PDS_DEV_TYPE_VDPA;
>  	vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
>  	if (!(vt_support &&
>  	      pf->viftype_status[vt].supported &&
> @@ -253,7 +252,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>  		err = PTR_ERR(padev);
>  		goto out_unlock;
>  	}
> -	pf->vfs[cf->vf_id].padev = padev;
> +	*pd_ptr = padev;
>  
>  out_unlock:
>  	mutex_unlock(&pf->config_lock);
> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
> index 631a59cfdd7e..f075e68c64db 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.h
> +++ b/drivers/net/ethernet/amd/pds_core/core.h
> @@ -303,8 +303,11 @@ void pdsc_health_thread(struct work_struct *work);
>  int pdsc_register_notify(struct notifier_block *nb);
>  void pdsc_unregister_notify(struct notifier_block *nb);
>  void pdsc_notify(unsigned long event, void *data);
> -int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
> -void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
> +int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
> +			enum pds_core_vif_types vt,
> +			struct pds_auxiliary_dev **pd_ptr);
> +void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
> +			 struct pds_auxiliary_dev **pd_ptr);
>  
>  void pdsc_process_adminq(struct pdsc_qcq *qcq);
>  void pdsc_work_thread(struct work_struct *work);
> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 4e2b92ddef6f..c5c787df61a4 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -57,9 +57,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
>  		struct pdsc *vf = pdsc->vfs[vf_id].vf;
>  
>  		if (ctx->val.vbool)
> -			err = pdsc_auxbus_dev_add(vf, pdsc);
> +			err = pdsc_auxbus_dev_add(vf, pdsc, vt_entry->vif_id,
> +						  &pdsc->vfs[vf_id].padev);
>  		else
> -			pdsc_auxbus_dev_del(vf, pdsc);
> +			pdsc_auxbus_dev_del(vf, pdsc, &pdsc->vfs[vf_id].padev);
>  	}
>  
>  	return err;
> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index 660268ff9562..a3a68889137b 100644
> --- a/drivers/net/ethernet/amd/pds_core/main.c
> +++ b/drivers/net/ethernet/amd/pds_core/main.c
> @@ -190,7 +190,8 @@ static int pdsc_init_vf(struct pdsc *vf)
>  	devl_unlock(dl);
>  
>  	pf->vfs[vf->vf_id].vf = vf;
> -	err = pdsc_auxbus_dev_add(vf, pf);
> +	err = pdsc_auxbus_dev_add(vf, pf, PDS_DEV_TYPE_VDPA,
> +				  &pf->vfs[vf->vf_id].padev);
>  	if (err) {
>  		devl_lock(dl);
>  		devl_unregister(dl);
> @@ -417,7 +418,7 @@ static void pdsc_remove(struct pci_dev *pdev)
>  
>  		pf = pdsc_get_pf_struct(pdsc->pdev);
>  		if (!IS_ERR(pf)) {
> -			pdsc_auxbus_dev_del(pdsc, pf);
> +			pdsc_auxbus_dev_del(pdsc, pf, &pf->vfs[pdsc->vf_id].padev);
>  			pf->vfs[pdsc->vf_id].vf = NULL;
>  		}
>  	} else {
> @@ -482,7 +483,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>  
>  		pf = pdsc_get_pf_struct(pdsc->pdev);
>  		if (!IS_ERR(pf))
> -			pdsc_auxbus_dev_del(pdsc, pf);
> +			pdsc_auxbus_dev_del(pdsc, pf,
> +					    &pf->vfs[pdsc->vf_id].padev);
>  	}
>  
>  	pdsc_unmap_bars(pdsc);
> @@ -527,7 +529,8 @@ static void pdsc_reset_done(struct pci_dev *pdev)
>  
>  		pf = pdsc_get_pf_struct(pdsc->pdev);
>  		if (!IS_ERR(pf))
> -			pdsc_auxbus_dev_add(pdsc, pf);
> +			pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
> +					    &pf->vfs[pdsc->vf_id].padev);
>  	}
>  }
>  


