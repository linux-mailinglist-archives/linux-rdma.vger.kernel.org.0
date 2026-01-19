Return-Path: <linux-rdma+bounces-15720-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40D72D3B313
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 18:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 358B5300B355
	for <lists+linux-rdma@lfdr.de>; Mon, 19 Jan 2026 16:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B5452F360A;
	Mon, 19 Jan 2026 16:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PcdR0EK4"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8097329BDB4
	for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 16:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768841995; cv=none; b=aiv2/pNX8JgAaS5I3HqO5BDAKT8gRZDRfV7VTbry5PgVGRqdDisfbAHFFvC0wlU98jfQ6uGAlbSG/PYxK4FO1Fl/eK34R7KWHtCt9LLw/epQAxCwm889XgkB1En7ZkmK6Cp6w5kjhezTZAMXyJgAmGV6VfLf/NjS2VjZ5UpoO2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768841995; c=relaxed/simple;
	bh=bhDzKe3hBaMep6hb4Ruwhdat9qUjuZInlAgPSftgqs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T2Apnz6aSIdRfBMqrpRcQ49nlDYbTfJ0+b+Fby3A268CcgM9jZFblpZvES7wCTH6QJ886VrlVNd03aREKaR5oaLh6YYr87twMkLLKKRSPyspmxYV30oKkVQOGa5sUQtszGBywyIjd/qNdbV3pWlPwcY0LWLtfQPqa6/c6xqGJaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=PcdR0EK4; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-8c52f15c5b3so520668685a.3
        for <linux-rdma@vger.kernel.org>; Mon, 19 Jan 2026 08:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1768841992; x=1769446792; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
        b=PcdR0EK43JTx60gis7CFG3xkG/NxLT5THwvgfbiJvSZZ5OLMwewfa5seKHPFfJ59W6
         ++EalUij4O7QvK7DVAsbqXikrhQnP54gv4aD9zMUy70Mwiqwvwg/S1guw9n/L+ORoBqa
         cFSQYnafWkvrpgiMFogqwcqDgIwtX8qk/jjG0oMFehi4NAEC6Nc0ahhq907bxw09MwGY
         s5yrqryAgTqoErepfDtJA7QvdEzqu6gio4mVCC5X+M292/Vsu/OYK+MZv3hcRsvGjKLk
         kvOEh5eTxnR+68YNdRvNq1mZCqAEoCk+mW63/bYvN/K5sO+eA9WfQn42b1+DRxQ076d2
         WtNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768841992; x=1769446792;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TPsA7s1a/5IQbuetD0KLnhoW9jbCMPzN3lJpfuVRncw=;
        b=Qksi/zO4otNOUhVgo1wSfEUPGgDxJ69gUgvJO6i5wNDBDBh1sFYYPnrcLmAEgzXgbD
         sAlYJwVAAOG7hdwQsrPKmyLA7xWSS4yoffuU0wa/3IdUz9NwH0LALeHXooLgG23IDFR8
         /f2m+vjZuBLqSmXCXcM3uM1FNasD0Oj7gI8xxu3OWd18WTksj5dV4wE48lUQCORE5Dq/
         SZqMDEsvSDcLNSTXPVCXA9aKqq+nvJ4GKEukq7UjcPtHOTSoNUAuHAt+CxrWt8YEHlzf
         hNCHfCcrjiKyF8R5VUTt41ErfSbxzxB4mfWJT1OOKRalVf4aaafM6Or9dNhT21Du5JFt
         CBKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCpWDcNLveMGnAbJ0+tiBiqdYl88VmQ0HU7YJ5tcHCGQgSCDJoFvBh+mcdWV47OuETc5VC4c7e85n4@vger.kernel.org
X-Gm-Message-State: AOJu0YxoJDzUF/zrcQD9BGeTJW0vlN09fDCv+AL/6Vv60PQ3oCBVtHP0
	WJdcc7A4+s7DTae4OnvYz73n+pGLmzN7BrHrVspTEFsGDMMpqEgkQQkut3Zw/wkYyBw=
X-Gm-Gg: AY/fxX7ooMx+7ELMx8zASkMlZcufNd6OZTwRnFUF3/vQ9EcekekXODxtOBTOlkuVMKv
	6lEtiHhcu+OcGeLwC2TxFCAjPvs1bdcmIwNI3MWaBuxplVOYZNsJF3XzVxClf0s2m0499kHkqGf
	6rFq/MyH9Gf8HdtdDppOBfBz/LgoRZVY4VMj7TFvQFvxBbr62mk67p86w0zSpH6007oQNb9A/Th
	9c+yDCkHX5Q5bRqPsdKxZKIAwYEs9+Z3VwCnW0m/CM27ZguniVZKm4uAqH79dtmwzYMPEW2kEaW
	cYMLe/LhZTkx5j4FFoe5Js5+4uBvDyxTAFrI9bjvuHA0cnMeXUEfyDg34o5O2og3+S8rC7zgc8j
	zdIE2fpw3mzeF9HPHksOJtkh5xzphqk0M+QRu1464iZcdbXx91MUCpzkwWd2q/flj0YrLcHdX5Q
	ZSNFHn815FuZS0dBUXCNdKq+ymwPbE7W8JnprQMHIojUO0946xBGpCps2kI+6DfbMPULI=
X-Received: by 2002:ac8:7f56:0:b0:501:50cd:cd3a with SMTP id d75a77b69052e-502a16b363amr184663241cf.43.1768841992288;
        Mon, 19 Jan 2026 08:59:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8942e5e4d79sm93947786d6.2.2026.01.19.08.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 08:59:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1vhsbX-00000005IQz-1QSu;
	Mon, 19 Jan 2026 12:59:51 -0400
Date: Mon, 19 Jan 2026 12:59:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: Sumit Semwal <sumit.semwal@linaro.org>,
	Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Lucas De Marchi <lucas.demarchi@intel.com>,
	Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Kevin Tian <kevin.tian@intel.com>, Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Alex Williamson <alex@shazbot.org>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
	virtualization@lists.linux.dev, intel-xe@lists.freedesktop.org,
	linux-rdma@vger.kernel.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org
Subject: Re: [PATCH v2 3/4] iommufd: Require DMABUF revoke semantics
Message-ID: <20260119165951.GI961572@ziepe.ca>
References: <20260118-dmabuf-revoke-v2-0-a03bb27c0875@nvidia.com>
 <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260118-dmabuf-revoke-v2-3-a03bb27c0875@nvidia.com>

On Sun, Jan 18, 2026 at 02:08:47PM +0200, Leon Romanovsky wrote:
> From: Leon Romanovsky <leonro@nvidia.com>
> 
> IOMMUFD does not support page fault handling, and after a call to
> .invalidate_mappings() all mappings become invalid. Ensure that
> the IOMMUFD DMABUF importer is bound to a revoke‑aware DMABUF exporter
> (for example, VFIO).
> 
> Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
> ---
>  drivers/iommu/iommufd/pages.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommufd/pages.c b/drivers/iommu/iommufd/pages.c
> index 76f900fa1687..a5eb2bc4ef48 100644
> --- a/drivers/iommu/iommufd/pages.c
> +++ b/drivers/iommu/iommufd/pages.c
> @@ -1501,16 +1501,22 @@ static int iopt_map_dmabuf(struct iommufd_ctx *ictx, struct iopt_pages *pages,
>  		mutex_unlock(&pages->mutex);
>  	}
>  
> -	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	rc = dma_buf_pin(attach);
>  	if (rc)
>  		goto err_detach;
>  
> +	rc = sym_vfio_pci_dma_buf_iommufd_map(attach, &pages->dmabuf.phys);
> +	if (rc)
> +		goto err_unpin;
> +
>  	dma_resv_unlock(dmabuf->resv);
>  
>  	/* On success iopt_release_pages() will detach and put the dmabuf. */
>  	pages->dmabuf.attach = attach;
>  	return 0;

Don't we need an explicit unpin after unmapping?

Jason

