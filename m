Return-Path: <linux-rdma+bounces-8292-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDC43A4D5A5
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 09:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8F557188D06C
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Mar 2025 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669B71FA164;
	Tue,  4 Mar 2025 08:03:37 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2A1F941B;
	Tue,  4 Mar 2025 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075417; cv=none; b=DlLfOG/9CjKFD0/fvgs/DqAOc/xe49idr6feP3iNDT0Y8lwPTpMeeQZucZU2llVOy3BC0JlSScP3/MT+j7sIlPDveUskS+0jcfFyvKH+BM/4nXxIa96Ee43jchoSUvULNHXZYVfMnTMEf2pYoNxUXJBGuxoV7vf6WWyuoV1LcA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075417; c=relaxed/simple;
	bh=n752P0g5Sm3IR1OpdadRyVcB7ffSL2HcHGRDkS8Vi2I=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+TyA5rPM72X1GrRRB8aV9lKLFnX6brUKY3jvmdcpV3XdEZMiFmvHD3VPfsM1Efwjw8LaJEv6c481W6kthVxGZdKJMn0a1MfUTxtungKrqcj0fGi/nk7jdYjSdj/z/W/DsW4r3CPlnxfq7OQw4Vfwmc5tPDWabgqJTQ++gfUZk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Z6Smv4h0kz6D8r5;
	Tue,  4 Mar 2025 16:01:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 7999514039E;
	Tue,  4 Mar 2025 16:03:31 +0800 (CST)
Received: from localhost (10.96.237.92) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Mar
 2025 09:03:25 +0100
Date: Tue, 4 Mar 2025 16:03:21 +0800
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Shannon Nelson <shannon.nelson@amd.com>
CC: <jgg@nvidia.com>, <andrew.gospodarek@broadcom.com>,
	<aron.silverton@oracle.com>, <dan.j.williams@intel.com>,
	<daniel.vetter@ffwll.ch>, <dave.jiang@intel.com>, <dsahern@kernel.org>,
	<gregkh@linuxfoundation.org>, <hch@infradead.org>, <itayavr@nvidia.com>,
	<jiri@nvidia.com>, <kuba@kernel.org>, <lbloch@nvidia.com>,
	<leonro@nvidia.com>, <linux-cxl@vger.kernel.org>,
	<linux-rdma@vger.kernel.org>, <netdev@vger.kernel.org>, <saeedm@nvidia.com>,
	<brett.creeley@amd.com>
Subject: Re: [PATCH v2 3/6] pds_core: add new fwctl auxiliary_device
Message-ID: <20250304160321.000038a0@huawei.com>
In-Reply-To: <20250301013554.49511-4-shannon.nelson@amd.com>
References: <20250301013554.49511-1-shannon.nelson@amd.com>
	<20250301013554.49511-4-shannon.nelson@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 28 Feb 2025 17:35:51 -0800
Shannon Nelson <shannon.nelson@amd.com> wrote:

> Add support for a new fwctl-based auxiliary_device for creating a
> channel for fwctl support into the AMD/Pensando DSC.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Hi Shannon,

A few really minor comments inline from a fresh read through.

Thanks,

Jonathan

> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c |  3 +--
>  drivers/net/ethernet/amd/pds_core/core.c   |  7 +++++++
>  drivers/net/ethernet/amd/pds_core/core.h   |  1 +
>  drivers/net/ethernet/amd/pds_core/main.c   | 11 +++++++++++
>  include/linux/pds/pds_common.h             |  2 ++
>  5 files changed, 22 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index db950a9c9d30..ac6f76c161f2 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -225,8 +225,7 @@ int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf,
>  	}
>  
>  	/* Verify that the type is supported and enabled.  It is not
> -	 * an error if there is no auxbus device support for this
> -	 * VF, it just means something else needs to happen with it.
> +	 * an error if there is no auxbus device support.

Comment feels a bit general. Is this no auxbus support for this device
or none at all in the kernel?

>  	 */
>  	vt_support = !!le16_to_cpu(pf->dev_ident.vif_types[vt]);
>  	if (!(vt_support &&

> diff --git a/drivers/net/ethernet/amd/pds_core/main.c b/drivers/net/ethernet/amd/pds_core/main.c
> index a3a68889137b..41575c7a148d 100644
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
> @@ -297,6 +301,7 @@ static int pdsc_init_pf(struct pdsc *pdsc)
>  	devlink_params_unregister(dl, pdsc_dl_params,
>  				  ARRAY_SIZE(pdsc_dl_params));
>  err_out_stop:
> +	pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);

This doesn't smell right (by which I mean I had to go look at the
implementation to be sure it wasn't a bug) In my ideal
world that should be obvious on a more local basis.
I'd expect a new label here. pdsc_auxbus_dev_add() should be and is
side effect free if it fails. That is it should not make sense
to call pdsc_auxbus_dev_del() if it fails.

It isn't a bug today as that becomes a noop due to
&pdsc->padev being NULL but that is a detail I shouldn't
ideally need to know when reading this code.

I'd put err_out_stop label here and rename previous
one to err_out_auxbus_del + replace the existing
goto err_out_stop; 
with
goto err_out_auxbus_del;

>  	pdsc_stop(pdsc);
>  err_out_teardown:
>  	pdsc_teardown(pdsc, PDSC_TEARDOWN_REMOVING);
> @@ -427,6 +432,7 @@ static void pdsc_remove(struct pci_dev *pdev)
>  		 * shut themselves down.
>  		 */
>  		pdsc_sriov_configure(pdev, 0);
> +		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  
>  		timer_shutdown_sync(&pdsc->wdtimer);
>  		if (pdsc->wq)
> @@ -485,6 +491,8 @@ static void pdsc_reset_prepare(struct pci_dev *pdev)
>  		if (!IS_ERR(pf))
>  			pdsc_auxbus_dev_del(pdsc, pf,
>  					    &pf->vfs[pdsc->vf_id].padev);
> +	} else {
> +		pdsc_auxbus_dev_del(pdsc, pdsc, &pdsc->padev);
>  	}
>  
>  	pdsc_unmap_bars(pdsc);
> @@ -531,6 +539,9 @@ static void pdsc_reset_done(struct pci_dev *pdev)
>  		if (!IS_ERR(pf))
>  			pdsc_auxbus_dev_add(pdsc, pf, PDS_DEV_TYPE_VDPA,
>  					    &pf->vfs[pdsc->vf_id].padev);
> +	} else {
> +		pdsc_auxbus_dev_add(pdsc, pdsc, PDS_DEV_TYPE_FWCTL,
> +				    &pdsc->padev);
>  	}
>  }


