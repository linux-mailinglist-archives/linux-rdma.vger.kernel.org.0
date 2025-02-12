Return-Path: <linux-rdma+bounces-7671-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A6464A3257C
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 12:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42A1D168029
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Feb 2025 11:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DCF20B203;
	Wed, 12 Feb 2025 11:57:47 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8E205AAF;
	Wed, 12 Feb 2025 11:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739361467; cv=none; b=d4H4ggYScW/UbCo+PAzqrdieZrT95aiKJvpNMjP33hUw3c4lnfgScHZLHRmDAgT0zM2sFldmDsAKpYVAj4x0fH7zjy+GiOak7NSvhhqVZqmvrbYd3LoQq7GJvo+FXn40TXUz/KTHQlU+w6tymeuJcOxS0OSh6AM2KICFp304+ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739361467; c=relaxed/simple;
	bh=JLcYrsxs5VQrFQ8zp3bYRSeJrYhvPjX8ki2I4JOySLc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sjYTeogypNwv7G1Uyqs0cGy20JjhGPlNTme65e78XGJpgAobp10FjAuuaeVSzNvWxq8qj/Yugkfj4WV+eiyfekCPRPB+j3EWj4MPRnk26HnHaQq2QmzDFmwbkc6y1P0l8eGZ6+XODk3ilUjpcuVDMBWZojFGBtSSeEPnv7AdiJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YtGxP4qGnz6HJc1;
	Wed, 12 Feb 2025 19:56:25 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 291681401DC;
	Wed, 12 Feb 2025 19:57:41 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 12 Feb
 2025 12:57:40 +0100
Date: Wed, 12 Feb 2025 11:57:38 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gospo@broadcom.com>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <saeedm@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>,
	<brett.creeley@amd.com>
Subject: Re: [RFC PATCH fwctl 1/5] pds_core: specify auxiliary_device to be
 created
Message-ID: <20250212115738.0000161b@huawei.com>
In-Reply-To: <20250211234854.52277-2-shannon.nelson@amd.com>
References: <20250211234854.52277-1-shannon.nelson@amd.com>
	<20250211234854.52277-2-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:48:50 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> In preparation for adding a new auxiliary_device for the
> PF, make the vif type an argument to pdsc_auxbus_dev_add().
> We also now pass in the address to where we'll keep the new
> padev pointer so that the caller can specify where to save it
> but we can still change it under the mutex and keep the mutex
> usage within the function.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

One trivial comment inline.

> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c  | 41 ++++++++++-----------
>  drivers/net/ethernet/amd/pds_core/core.h    |  7 +++-
>  drivers/net/ethernet/amd/pds_core/devlink.c |  6 ++-
>  drivers/net/ethernet/amd/pds_core/main.c    | 11 ++++--
>  4 files changed, 36 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 2babea110991..0a3035adda52 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -175,34 +175,37 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>  	return padev;
>  }
>  
> -int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
> +int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
> +			struct pds_auxiliary_dev **pd_ptr)
>  {
>  	struct pds_auxiliary_dev *padev;
> -	int err = 0;
>  
>  	if (!cf)
>  		return -ENODEV;
>  
> +	if (!*pd_ptr)
> +		return 0;
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
> -	return err;
> +
> +	return 0;

If you are always going to return 0, maybe change the signature
to not return anything?

Would require changing the ternary usage below, but perhaps
it is worth it to remove the implication of failures being
a possibility.


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
> @@ -211,6 +214,9 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>  	if (!cf)
>  		return -ENODEV;
>  
> +	if (vt >= PDS_DEV_TYPE_MAX)
> +		return -EINVAL;
> +
>  	mutex_lock(&pf->config_lock);
>  
>  	mask = BIT_ULL(PDSC_S_FW_DEAD) |
> @@ -222,17 +228,10 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
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
> @@ -258,7 +257,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
>  		err = PTR_ERR(padev);
>  		goto out_unlock;
>  	}
> -	pf->vfs[cf->vf_id].padev = padev;
> +	*pd_ptr = padev;
>  
>  out_unlock:
>  	mutex_unlock(&pf->config_lock);
> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
> index 14522d6d5f86..065031dd5af6 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.h
> +++ b/drivers/net/ethernet/amd/pds_core/core.h
> @@ -303,8 +303,11 @@ void pdsc_health_thread(struct work_struct *work);
>  int pdsc_register_notify(struct notifier_block *nb);
>  void pdsc_unregister_notify(struct notifier_block *nb);
>  void pdsc_notify(unsigned long event, void *data);
> -int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
> -int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
> +int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
> +			enum pds_core_vif_types vt,
> +			struct pds_auxiliary_dev **pd_ptr);
> +int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf,
> +			struct pds_auxiliary_dev **pd_ptr);
>  
>  void pdsc_process_adminq(struct pdsc_qcq *qcq);
>  void pdsc_work_thread(struct work_struct *work);
> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 44971e71991f..c2f380f18f21 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -56,8 +56,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
>  	for (vf_id = 0; vf_id < pdsc->num_vfs; vf_id++) {
>  		struct pdsc *vf = pdsc->vfs[vf_id].vf;
>  
> -		err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc) :
> -				       pdsc_auxbus_dev_del(vf, pdsc);
> +		err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc, vt_entry->vif_id,
> +							   &pdsc->vfs[vf_id].padev) :
> +				       pdsc_auxbus_dev_del(vf, pdsc,
> +						           &pdsc->vfs[vf_id].padev);
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


