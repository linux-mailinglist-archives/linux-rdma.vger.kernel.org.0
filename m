Return-Path: <linux-rdma+bounces-11656-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6885AE96BA
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 09:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3537F3B17EB
	for <lists+linux-rdma@lfdr.de>; Thu, 26 Jun 2025 07:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF34823B620;
	Thu, 26 Jun 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OFJcrwcH"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93F941A8F94;
	Thu, 26 Jun 2025 07:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750922818; cv=none; b=Ow5eSJTP1wgS6h5j9QZsXdQ9oKsivcEeiTKw+G4zU6ME6kTJXuOxC3uJCBqWUoER71A0QuYCbDH1XMNpsJjq39DWpHxp3TXUqv7mbTF9i+mqOFvBeXyi08y6f0Qlp16v9xTrLw29TCI0nzgM/+kNGmjK04XrBeEbOwMQdkQSLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750922818; c=relaxed/simple;
	bh=kh8PTnqwdXVM33XrWSHg6xtxFJcL8XC9586i9CBGYu0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JeGlRv2z3fjCGB2rkkmJ4jGe9GX18VRNdzLqnS/6dxSEnfGZ1umCBd6/Z0PuHiGwcJSykKsThyhVBCPUjjTKmSDDuZxobSN4w1lvKr0hwlHkYwzNumltUNd/la5IeCpmduE8k8/20NeXaP8q8cik3lRBGRRhLRf+35oTPPDJ140=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OFJcrwcH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D4ADC4CEEB;
	Thu, 26 Jun 2025 07:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750922818;
	bh=kh8PTnqwdXVM33XrWSHg6xtxFJcL8XC9586i9CBGYu0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OFJcrwcHsR3vRlPb5zeQb0wmJV97Y0VzvDRKVWvGRvXqemb3qwG7lgO65EHa9dnWv
	 Yd6PSiLKll8Tg2LCOQQmUvbHZwMrMGSstGEBcnUi5aa6LvoA/cBB4y+5snQNwG7+O4
	 U/uyxpH7T7wkvkLjULDufr8wdCnRmHdbIja+TflMrNrU4+dkHX5O4PGWNC0Yn1ZAQu
	 clVmgL1xPgPi6M4EAgPP6+TWiEVYz8Vbb/PIQJUMyAId/LItwXUKLgmj8MqZcTwpcs
	 SvoHM9Dl/9nZLau8ArZdCRdouyZaNMiBAP8Hwd430OOUvkh5blvSsCPz3+VJ+waSVv
	 J5PtZ7MWVsM7A==
Date: Thu, 26 Jun 2025 10:26:53 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Abhijit Gangurde <abhijit.gangurde@amd.com>
Cc: shannon.nelson@amd.com, brett.creeley@amd.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	corbet@lwn.net, jgg@ziepe.ca, andrew+netdev@lunn.ch,
	allen.hubbe@amd.com, nikhil.agarwal@amd.com,
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Boyer <andrew.boyer@amd.com>
Subject: Re: [PATCH v3 08/14] RDMA/ionic: Register auxiliary module for ionic
 ethernet adapter
Message-ID: <20250626072653.GI17401@unreal>
References: <20250624121315.739049-1-abhijit.gangurde@amd.com>
 <20250624121315.739049-9-abhijit.gangurde@amd.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250624121315.739049-9-abhijit.gangurde@amd.com>

On Tue, Jun 24, 2025 at 05:43:09PM +0530, Abhijit Gangurde wrote:
> Register auxiliary module to create ibdevice for ionic
> ethernet adapter.
> 
> Co-developed-by: Andrew Boyer <andrew.boyer@amd.com>
> Signed-off-by: Andrew Boyer <andrew.boyer@amd.com>
> Co-developed-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Allen Hubbe <allen.hubbe@amd.com>
> Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> ---
> v1->v2
>   - Removed netdev references from ionic RDMA driver
>   - Moved to ionic_lif* instead of void* to convey information between
>     aux devices and drivers.
> 
>  drivers/infiniband/hw/ionic/ionic_ibdev.c   | 133 ++++++++++++++++++++
>  drivers/infiniband/hw/ionic/ionic_ibdev.h   |  21 ++++
>  drivers/infiniband/hw/ionic/ionic_lif_cfg.c | 118 +++++++++++++++++
>  drivers/infiniband/hw/ionic/ionic_lif_cfg.h |  65 ++++++++++
>  4 files changed, 337 insertions(+)
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_ibdev.h
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.c
>  create mode 100644 drivers/infiniband/hw/ionic/ionic_lif_cfg.h

<...>

> +	rc = ionic_version_check(&ionic_adev->adev.dev, ionic_adev->lif);
> +	if (rc)
> +		return ERR_PTR(rc);

<...>

> +struct net_device *ionic_lif_netdev(struct ionic_lif *lif)
> +{
> +	return lif->netdev;
> +}

Why do you need to store netdev pointer?
Why can't you use existing ib_device_get_netdev/ib_device_set_netdev?

> +
> +int ionic_version_check(const struct device *dev, struct ionic_lif *lif)
> +{
> +	union ionic_lif_identity *ident = &lif->ionic->ident.lif;
> +
> +	if (ident->rdma.version < IONIC_MIN_RDMA_VERSION ||
> +	    ident->rdma.version > IONIC_MAX_RDMA_VERSION) {
> +		dev_err_probe(dev, -EINVAL,
> +			      "ionic_rdma: incompatible version, fw ver %u\n",
> +			      ident->rdma.version);
> +		dev_err_probe(dev, -EINVAL,
> +			      "ionic_rdma: Driver Min Version %u\n",
> +			      IONIC_MIN_RDMA_VERSION);
> +		dev_err_probe(dev, -EINVAL,
> +			      "ionic_rdma: Driver Max Version %u\n",
> +			      IONIC_MAX_RDMA_VERSION);
> +	}
> +
> +	return 0;
> +}

Upstream code has all subsystems in sync, and RDMA driver is always
compatible with its netdev counterpart. Please remove this part.

This is not full review yet, please wait till next week, so we will
review more deeply.

Thanks

