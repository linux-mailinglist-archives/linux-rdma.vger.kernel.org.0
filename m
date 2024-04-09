Return-Path: <linux-rdma+bounces-1868-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1725889D58A
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 11:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EE7B2397D
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Apr 2024 09:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D377FBDF;
	Tue,  9 Apr 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MnuVt8sZ"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01E7F7EE;
	Tue,  9 Apr 2024 09:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654765; cv=none; b=sSs+WkXYyk0pau8Cj9edSn3TCTHfSb2ZbDrfbvzLLbZXGQFyk+IpN96GvnpqLEKV0Oskstz0nVYwbFFm7e6ReN+Qrt/AGfWPAak82bSDVTiTDMOXr2wHGuqcVgnluuqCphyv0I0Lcp8Yi/B+S4HwtMsSA3tEDfR3dCFHvNqhlOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654765; c=relaxed/simple;
	bh=bgcIIjJjQFMe0flCyT/HZgtC54nQJKBb0Lkxfw4i+C8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LHuJEyqFCXTnhuI5EL2lWnDggaVIxR65Ru4HJNTCmDRs0XXmhMPgf7uwGJSZWkaOhKUpgcBNysiMR/gpYee90kib3fkBAzhSBuRhgmyWAxYkwmhplyUB0rD/DyYEqyNPzw9Y4VNHE5QDBLrZVFL1HNQYo9ANF5S57b9wSCrDcRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MnuVt8sZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A374EC433C7;
	Tue,  9 Apr 2024 09:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654765;
	bh=bgcIIjJjQFMe0flCyT/HZgtC54nQJKBb0Lkxfw4i+C8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MnuVt8sZEIN4xRBsPy63HgFIKhaFZC5kAA64dqeQKsa7mzOkESgc+4CNL+iG9T5Go
	 CNVcWDGolZOUQ1xerW6bdmcF43wxJBZ3K1KeVHS43PFtH9QeJHLkqgkF5Xmtwtchnx
	 XwhS/H8KiyLWoHmWKNg7/3eACpY9Z0evJue1Oz+z7fKqyZZrWd9k3SYCfEbiCL7pbp
	 yCErnJ8g/xYtCK/KlXkCVS6yEFYiI2mRSZxcHruFDEqC8+Hy7Y0HqCCTJKqLaVsI1w
	 AGXlpMvimqRbz9U7fZ00oBx0ILykEzy8dwjaaq8756pFLI7OIndRqiT/lN2QbpeI1+
	 tCpzn2nYaoiTQ==
Date: Tue, 9 Apr 2024 12:26:01 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Wei Xu <xuwei5@hisilicon.com>,
	Chengchang Tang <tangchengchang@huawei.com>,
	Junxian Huang <huangjunxian6@hisilicon.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Xi Wang <wangxi11@huawei.com>,
	Shengming Shu <shushengming1@huawei.com>,
	Weihang Li <liweihang@huawei.com>, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org
Subject: Re: [PATCH] RDMA: hns: Fix possible null pointer dereference
Message-ID: <20240409092601.GG4195@unreal>
References: <20240409083047.15784-1-amishin@t-argos.ru>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409083047.15784-1-amishin@t-argos.ru>

On Tue, Apr 09, 2024 at 11:30:47AM +0300, Aleksandr Mishin wrote:
> In hns_roce_hw_v2_get_cfg() pci_match_id() may return
> NULL which is later dereferenced. Fix this bug by adding NULL check.

I don't know, this NULL can't happen in this flow.

Thanks

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 0b567cde9d7a ("RDMA/hns: Enable RoCE on virtual functions")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/infiniband/hw/hns/hns_roce_hw_v2.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> index ba7ae792d279..31a2093334d9 100644
> --- a/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> +++ b/drivers/infiniband/hw/hns/hns_roce_hw_v2.c
> @@ -6754,7 +6754,7 @@ static const struct pci_device_id hns_roce_hw_v2_pci_tbl[] = {
>  
>  MODULE_DEVICE_TABLE(pci, hns_roce_hw_v2_pci_tbl);
>  
> -static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
> +static int hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>  				  struct hnae3_handle *handle)
>  {
>  	struct hns_roce_v2_priv *priv = hr_dev->priv;
> @@ -6763,6 +6763,9 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>  
>  	hr_dev->pci_dev = handle->pdev;
>  	id = pci_match_id(hns_roce_hw_v2_pci_tbl, hr_dev->pci_dev);
> +	if (!id)
> +		return -ENXIO;
> +
>  	hr_dev->is_vf = id->driver_data;
>  	hr_dev->dev = &handle->pdev->dev;
>  	hr_dev->hw = &hns_roce_hw_v2;
> @@ -6789,6 +6792,8 @@ static void hns_roce_hw_v2_get_cfg(struct hns_roce_dev *hr_dev,
>  
>  	hr_dev->reset_cnt = handle->ae_algo->ops->ae_dev_reset_cnt(handle);
>  	priv->handle = handle;
> +
> +	return 0;
>  }
>  
>  static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
> @@ -6806,7 +6811,11 @@ static int __hns_roce_hw_v2_init_instance(struct hnae3_handle *handle)
>  		goto error_failed_kzalloc;
>  	}
>  
> -	hns_roce_hw_v2_get_cfg(hr_dev, handle);
> +	ret = hns_roce_hw_v2_get_cfg(hr_dev, handle);
> +	if (ret) {
> +		dev_err(hr_dev->dev, "RoCE Engine cfg failed!\n");
> +		goto error_failed_roce_init;
> +	}
>  
>  	ret = hns_roce_init(hr_dev);
>  	if (ret) {
> -- 
> 2.30.2
> 

