Return-Path: <linux-rdma+bounces-8532-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4E88A59BD0
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 17:58:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F908168CBA
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Mar 2025 16:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA84230BC8;
	Mon, 10 Mar 2025 16:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mgQckWjX"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4455222D4C3;
	Mon, 10 Mar 2025 16:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741625888; cv=none; b=aI8pFoYEdrPxlFixuyuTLTHDbyVrP6YJQQTkgdlSubVywPwmabzOuaC+/9LlqGKkxw9zm/sBbe3HOQIk70thln/IHOoMCdJgDNmnerPq4AktiDWi5Q3E8h9lmPcuFGf15aVTSw4nshXNFDhOwePmEvD5Qjg7ABxIjpC7cIzZguM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741625888; c=relaxed/simple;
	bh=1FDqnMxGLcsQkkezE18gJh/6LPBzJwjMsNmthUDDBJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mWhmmbZPdeWZJnyfoKKooqu8OJc8h2wIjPT5MWnfQmOyg6RsyR6spr0oEox6ZIOB5TPO47DkaRayfgk7hUUoThtCzw3oCPVaPQNKCW1nOawSV7vIL37zF0VzDcxiUaoshUDNng5iBJynR/bT6ChoGYTx8eaoUO64O7fWW6kG4ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mgQckWjX; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741625887; x=1773161887;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1FDqnMxGLcsQkkezE18gJh/6LPBzJwjMsNmthUDDBJY=;
  b=mgQckWjXODnYMThEcg7xPAZutL4xL7wTzz/zmgRsSCtDQHecEpPeQTdJ
   bTa9IrG1OkUr7eONMbcze91+GYRoRhXiGuQ89cJW06niMf4l7Oo3/KnBo
   9DZNtViWYI3cZdU+Ip5+fvM/Vq9iPhOQQ93Wwz2RV6X0Dwf3MvFjj/Cdc
   eZgYHeWUFlxVFHp1rcPqQy86bw5MG+ZpUHyuvSVRUdOBC90q5XDO9FhED
   BNWN95POpXuGsa/3BzpE7G6Yuqh43LuiMrla66GSLC7y0PgFgJRPrV8I6
   qPVaG1OTg8Nvui9S6Stns2Yncsk1gOZhYIgZ7aQOkF6q9P/fC+KRJnYBk
   Q==;
X-CSE-ConnectionGUID: 7eZiw8P8TSup2MmL2oL3IQ==
X-CSE-MsgGUID: yVcGyEyWQF+48f1+y/RJ5w==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="42847458"
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="42847458"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:58:06 -0700
X-CSE-ConnectionGUID: Y+zzCClDQ0GtFnQM7MVIRA==
X-CSE-MsgGUID: fMlt3OS9SHCdj+vSrO0jKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,236,1736841600"; 
   d="scan'208";a="120570233"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.63]) ([10.125.111.63])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 09:58:04 -0700
Message-ID: <a3b9c248-94de-4237-8ab4-f425bfc66258@intel.com>
Date: Mon, 10 Mar 2025 09:58:03 -0700
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] pds_core: make pdsc_auxbus_dev_del() void
To: Shannon Nelson <shannon.nelson@amd.com>, jgg@nvidia.com,
 andrew.gospodarek@broadcom.com, aron.silverton@oracle.com,
 dan.j.williams@intel.com, daniel.vetter@ffwll.ch, dsahern@kernel.org,
 gregkh@linuxfoundation.org, hch@infradead.org, itayavr@nvidia.com,
 jiri@nvidia.com, Jonathan.Cameron@huawei.com, kuba@kernel.org,
 lbloch@nvidia.com, leonro@nvidia.com, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, saeedm@nvidia.com
Cc: brett.creeley@amd.com
References: <20250307185329.35034-1-shannon.nelson@amd.com>
 <20250307185329.35034-2-shannon.nelson@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250307185329.35034-2-shannon.nelson@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/7/25 11:53 AM, Shannon Nelson wrote:
> Since there really is no useful return, advertising a return value
> is rather misleading.  Make pdsc_auxbus_dev_del() a void function.
> 
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/net/ethernet/amd/pds_core/auxbus.c  | 7 +------
>  drivers/net/ethernet/amd/pds_core/core.h    | 2 +-
>  drivers/net/ethernet/amd/pds_core/devlink.c | 6 ++++--
>  3 files changed, 6 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/auxbus.c b/drivers/net/ethernet/amd/pds_core/auxbus.c
> index 2babea110991..78fba368e797 100644
> --- a/drivers/net/ethernet/amd/pds_core/auxbus.c
> +++ b/drivers/net/ethernet/amd/pds_core/auxbus.c
> @@ -175,13 +175,9 @@ static struct pds_auxiliary_dev *pdsc_auxbus_dev_register(struct pdsc *cf,
>  	return padev;
>  }
>  
> -int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
> +void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
>  {
>  	struct pds_auxiliary_dev *padev;
> -	int err = 0;
> -
> -	if (!cf)
> -		return -ENODEV;
>  
>  	mutex_lock(&pf->config_lock);
>  
> @@ -195,7 +191,6 @@ int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf)
>  	pf->vfs[cf->vf_id].padev = NULL;
>  
>  	mutex_unlock(&pf->config_lock);
> -	return err;
>  }
>  
>  int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf)
> diff --git a/drivers/net/ethernet/amd/pds_core/core.h b/drivers/net/ethernet/amd/pds_core/core.h
> index 14522d6d5f86..631a59cfdd7e 100644
> --- a/drivers/net/ethernet/amd/pds_core/core.h
> +++ b/drivers/net/ethernet/amd/pds_core/core.h
> @@ -304,7 +304,7 @@ int pdsc_register_notify(struct notifier_block *nb);
>  void pdsc_unregister_notify(struct notifier_block *nb);
>  void pdsc_notify(unsigned long event, void *data);
>  int pdsc_auxbus_dev_add(struct pdsc *cf, struct pdsc *pf);
> -int pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
> +void pdsc_auxbus_dev_del(struct pdsc *cf, struct pdsc *pf);
>  
>  void pdsc_process_adminq(struct pdsc_qcq *qcq);
>  void pdsc_work_thread(struct work_struct *work);
> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index 44971e71991f..4e2b92ddef6f 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -56,8 +56,10 @@ int pdsc_dl_enable_set(struct devlink *dl, u32 id,
>  	for (vf_id = 0; vf_id < pdsc->num_vfs; vf_id++) {
>  		struct pdsc *vf = pdsc->vfs[vf_id].vf;
>  
> -		err = ctx->val.vbool ? pdsc_auxbus_dev_add(vf, pdsc) :
> -				       pdsc_auxbus_dev_del(vf, pdsc);
> +		if (ctx->val.vbool)
> +			err = pdsc_auxbus_dev_add(vf, pdsc);
> +		else
> +			pdsc_auxbus_dev_del(vf, pdsc);
>  	}
>  
>  	return err;


