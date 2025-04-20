Return-Path: <linux-rdma+bounces-9609-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DFBA94778
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 12:53:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B4193AE1AC
	for <lists+linux-rdma@lfdr.de>; Sun, 20 Apr 2025 10:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79E91E1A16;
	Sun, 20 Apr 2025 10:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c1IH7Q5y"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7201BF37;
	Sun, 20 Apr 2025 10:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745146395; cv=none; b=SiUv4p6f5PGd2NK/4OzGKqyWNVn15/lELP2o1Jw0YSAwMvjv2ZYSktj+qnr//S/wNTM5TMkAasKq2jwjHF9E1nb+I716JB6ml4Ic6/Khs4BRhaEKNAJqgNQ1+NqNM37TZmSscBGaV5nyXyVDYi10IdteJ4icDrqz7fQcP88CiPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745146395; c=relaxed/simple;
	bh=bXJdf1xzVKKv9/u8aO8bX8b9n3UfGPVIyIYQIFfGoVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvHO7A9n6+rQrtsWguY9jNftPDsy5daU76GNZx+Q7+G+J2cwG1q1k//t7RdMaIkTwkXWSkT63+Iefb05qrlCrwyfAqrvjtPpR5gsbe8Z39WrABcnIyxreVSFS07P4wWzj1SiArmGv+/9APTWJJ6g5v3cC8B/9WU1bAj8ysAcIP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c1IH7Q5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503B7C4CEE2;
	Sun, 20 Apr 2025 10:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745146394;
	bh=bXJdf1xzVKKv9/u8aO8bX8b9n3UfGPVIyIYQIFfGoVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c1IH7Q5yZmKMr2iaSMvQmdem9ZqiUllJEl0EL9okREs+73sVALAqaYn2A6yKNPHFB
	 orHjbSDctMxhBIDrd769PITPCe7y1ouf3hUW6jfwzqEdzyCsjtvS2860afiYYWPupp
	 O0UzqLEIe8Tp6XlWCc4G2an6wOsUEkXOk6jNAH4By57YQHMQVyZNT4sdlyQOprX4Ey
	 F/NTMVTq5U9F4MAk0cRdQRrUb6an90Oj6oc61DyzKl8fdrZEcTj7Q3M3qXDzpIKHS/
	 Q/PQaDu0MRUx4v6V8elUIqn9libCYHoX/WEQSRXh8y8+YjT3hsrDPmtlNnRMGutGNk
	 DGjyIi3RqAebA==
Date: Sun, 20 Apr 2025 13:53:09 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Konstantin Taranov <kotaranov@linux.microsoft.com>
Cc: kotaranov@microsoft.com, pabeni@redhat.com, haiyangz@microsoft.com,
	kys@microsoft.com, edumazet@google.com, kuba@kernel.org,
	davem@davemloft.net, decui@microsoft.com, wei.liu@kernel.org,
	longli@microsoft.com, jgg@ziepe.ca, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH rdma-next 4/4] net: mana: Add support for auxiliary
 device servicing events
Message-ID: <20250420105309.GC10635@unreal>
References: <1744655329-13601-1-git-send-email-kotaranov@linux.microsoft.com>
 <1744655329-13601-5-git-send-email-kotaranov@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1744655329-13601-5-git-send-email-kotaranov@linux.microsoft.com>

On Mon, Apr 14, 2025 at 11:28:49AM -0700, Konstantin Taranov wrote:
> From: Shiraz Saleem <shirazsaleem@microsoft.com>
> 
> Handle soc servcing events which require the rdma auxiliary device resources to
> be cleaned up during a suspend, and re-initialized during a resume.
> 
> Signed-off-by: Shiraz Saleem <shirazsaleem@microsoft.com>
> Signed-off-by: Konstantin Taranov <kotaranov@microsoft.com>
> ---
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 11 +++-
>  .../net/ethernet/microsoft/mana/hw_channel.c  | 19 ++++++
>  drivers/net/ethernet/microsoft/mana/mana_en.c | 60 +++++++++++++++++++
>  include/net/mana/gdma.h                       | 18 ++++++
>  include/net/mana/hw_channel.h                 |  9 +++
>  5 files changed, 116 insertions(+), 1 deletion(-)

<...>

> @@ -1474,6 +1481,8 @@ static void mana_gd_cleanup(struct pci_dev *pdev)
>  	mana_hwc_destroy_channel(gc);
>  
>  	mana_gd_remove_irqs(pdev);
> +
> +	destroy_workqueue(gc->service_wq);
>  }

<...>

> +static void mana_handle_rdma_servicing(struct work_struct *work)
> +{
> +	struct mana_service_work *serv_work =
> +		container_of(work, struct mana_service_work, work);
> +	struct gdma_dev *gd = serv_work->gdma_dev;
> +	struct device *dev = gd->gdma_context->dev;
> +	int ret;
> +
> +	switch (serv_work->event) {
> +	case GDMA_SERVICE_TYPE_RDMA_SUSPEND:
> +		if (!gd->adev || gd->is_suspended)
> +			break;
> +
> +		remove_adev(gd);
> +		gd->is_suspended = true;
> +		break;
> +
> +	case GDMA_SERVICE_TYPE_RDMA_RESUME:
> +		if (!gd->is_suspended)
> +			break;
> +
> +		ret = add_adev(gd, "rdma");
> +		if (ret)
> +			dev_err(dev, "Failed to add adev on resume: %d\n", ret);
> +		else
> +			gd->is_suspended = false;
> +		break;
> +
> +	default:
> +		dev_warn(dev, "unknown adev service event %u\n",
> +			 serv_work->event);
> +		break;
> +	}
> +
> +	kfree(serv_work);

The series looks ok to me, except one question. Are you sure that it is
safe to have not-connected and not-locked general work while add_adev/remove_adev
can be called in parallel from different thread? For example getting event
GDMA_SERVICE_TYPE_RDMA_SUSPEND while mana_gd_probe() fails or some other
intervention with PCI (GDMA_SERVICE_TYPE_RDMA_SUSPEND and PCI shutdown).

What type of protection do you have here?

Thanks

